import glob
import os

from typesense.api_call import ObjectNotFound
from acdh_cfts_pyutils import TYPESENSE_CLIENT as client
from acdh_cfts_pyutils import CFTS_COLLECTION
from acdh_tei_pyutils.tei import TeiReader
from tqdm import tqdm


files = glob.glob('./data/editions/*/*.xml')


try:
    client.collections['freud-edition'].delete()
except ObjectNotFound:
    pass

current_schema = {
    'name': 'freud-edition',
    'fields': [
        {
            'name': 'id',
            'type': 'string'
        },
        {
            'name': 'rec_id',
            'type': 'string'
        },
        {
            'name': 'title',
            'type': 'string'
        },
        {
            'name': 'full_text',
            'type': 'string'
        },
        {
            'name': 'year',
            'type': 'int32',
            'optional': True,
            'facet': True,
        },
        {
            'name': 'persons',
            'type': 'string[]',
            'facet': True,
            'optional': True
        },
        # {
        #     'name': 'places',
        #     'type': 'string[]',
        #     'facet': True,
        #     'optional': True
        # },
        # {
        #     'name': 'orgs',
        #     'type': 'string[]',
        #     'facet': True,
        #     'optional': True
        # },
        # {
        #     'name': 'works',
        #     'type': 'string[]',
        #     'facet': True,
        #     'optional': True
        # },
        {
            'name': 'keywords',
            'type': 'string[]',
            'facet': True,
            'optional': True
        }
    ]
}

client.collections.create(current_schema)

def get_entities(ent_type, ent_node, ent_name, subtype):
    entities = []
    for p in body:
        e_path = f'.//tei:rs[@type="{ent_type}"]/@ref'
        ent = p.xpath(e_path, namespaces={'tei': "http://www.tei-c.org/ns/1.0"})
        if len(ent) > 0:
            for r in ent:
                i = r.replace('#', '')
                p_path = f'.//tei:{ent_node}[@xml:id="{i}"]//tei:{ent_name}{subtype}//text()'
                entity = " ".join(" ".join(doc.any_xpath(p_path)).split())
                entities.append(entity)
    entities = set(entities)
    ent = []
    for x in entities:
        ent.append(x)
    return ent

records = []
cfts_records = []
for x in tqdm(files, total=len(files)):
    doc = TeiReader(x)
    pb = doc.any_xpath('.//tei:body/tei:div/tei:pb/@xml:id')
    pages = 0
    for p in pb:
        p_group = f".//tei:body/tei:div/tei:p[preceding-sibling::tei:pb[1]/@xml:id='{p}']"
        body = doc.any_xpath(p_group)
        pages += 1
        cfts_record = {
            'project': 'freud-edition',
        }
        record = {}
        record['id'] = os.path.split(x)[-1].replace(".xml", f".html?break=on#page-{str(pages)}")
        cfts_record['id'] = record['id']
        cfts_record['resolver'] = f"https://freud.acdh-dev.oeaw.ac.at/{record['id']}"
        record['rec_id'] = os.path.split(x)[-1]
        cfts_record['rec_id'] = record['rec_id']
        r_title = " ".join(" ".join(doc.any_xpath('.//tei:titleStmt/tei:title[@type="manifestation"]/text()')).split())
        record['title'] = f"{r_title} Seite {str(pages)}"        
        cfts_record['title'] = record['title']
        try:
            date_str = doc.any_xpath('//tei:biblStruct[@type="guidingManifestation"]//tei:imprint/tei:date/@when')[0]
        except IndexError:
            date_str = "1000"

        try:
            record['year'] = int(date_str[:4])
            cfts_record['year'] = int(date_str[:4])
        except ValueError:
            pass
        
        if len(body) > 0:
            ent_type = "person"
            ent_name = "persName"
            record['persons'] = get_entities(ent_type=ent_type, ent_node=ent_type, ent_name=ent_name, subtype='[1]')
            cfts_record['persons'] = record['persons']
            ent_type = "keyword"
            ent_node = "item"
            ent_name = "term"
            record['keywords'] = get_entities(ent_type=ent_type, ent_node=ent_node, ent_name=ent_name, subtype='[1]')
            cfts_record['keywords'] = record['keywords']
            # record['places'] = [
            #      " ".join(" ".join(x.xpath('.//text()')).split()) for x in doc.any_xpath('.//tei:back//tei:place[@xml:id]/tei:placeName[1]')
            # ]
            # cfts_record['places'] = record['places']
            # record['orgs'] = [
            #      " ".join(" ".join(x.xpath('.//text()')).split()) for x in doc.any_xpath('.//tei:back//tei:org[@xml:id]/tei:orgName[1]')
            # ]
            # cfts_record['orgs'] = record['orgs']
            # ent_type = "bibl"
            # ent_node = "biblStruct"
            # ent_name = "title"
            # record['works'] = get_entities(ent_type=ent_type, ent_node=ent_node, ent_name=ent_name, subtype='[@level="m"]')
            # cfts_record['works'] = record['works']
            # record['full_text'] = " ".join(''.join(body.itertext()).split())
            record['full_text'] = ""
            for p in body:
                l = " ".join(''.join(p.itertext()).split())
                record['full_text'] += f" {l}"
            if len(record['full_text']) > 0:
                records.append(record)
                cfts_record['full_text'] = record['full_text']
                cfts_records.append(cfts_record)

make_index = client.collections['freud-edition'].documents.import_(records)
print(make_index)
print('done with indexing freud-edition')

make_index = CFTS_COLLECTION.documents.import_(cfts_records, {'action': 'upsert'})
print(make_index)
print('done with cfts-index freud-edition')