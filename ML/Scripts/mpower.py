import synapseclient
import pandas as pd
import json

syn = synapseclient.login('_jinang99',##password)

for offset in range(26000,30000,100):
    results = syn.tableQuery('SELECT * FROM syn5511444 LIMIT 100 OFFSET '+str(offset))
    file_map = syn.downloadTableColumns(results,['audio_audio.m4a'])