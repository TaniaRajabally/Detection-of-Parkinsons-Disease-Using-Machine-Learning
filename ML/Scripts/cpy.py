import shutil, os
path='C:\\Users\\aumkar\.synapseCache'
folders=os.listdir(path)
print(len(folders))
count=0
for i in folders:
    p=path+'\\'+i
    subfolders=folders=os.listdir(p)
   # print(len(subfolders))
    for j in subfolders:
            pth=p+'\\'+j
            try:
                file=[f for f in os.listdir(pth) if  (f.lower().endswith('.tmp'))][0]
                name=str(j)+'.m4a'
                if(count<10):
                        print(file,j)
                        count+=1
                shutil.copy(pth+'\\'+file, 'D:\Downloads\mp4000\\'+name)
            except Exception as e:
                    print(i,j)
