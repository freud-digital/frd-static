import glob
import lxml.etree as ET
from tqdm import tqdm
from acdh_tei_pyutils.tei import TeiReader

files = glob.glob('./data/editions/*.xml')
list_bibl_doc = TeiReader('./data/indices/listbibl.xml')

for x in files:
    if '__' in x:
        continue
    doc = TeiReader(x)
    bibls = []
    try:
        back = doc.any_xpath('.//tei:back')[0]
    except IndexError:
        continue
    for bad in doc.any_xpath('.//tei:back/tei:listBibl'):
            bad.getparent().remove(bad)
    listbible = ET.Element("{http://www.tei-c.org/ns/1.0}listBibl")
    back.append(listbible)
    for y in doc.any_xpath('.//tei:q[contains(@source, "#zotero")]/@source | .//tei:title[contains(@ref, "zotero")]/@ref'):
        xml_id = y.replace('#', '').split()[0]
        for n in list_bibl_doc.any_xpath(f'.//*[@xml:id="{xml_id}"]'):
            listbible.append(n)
    doc.tree_to_file(x)
