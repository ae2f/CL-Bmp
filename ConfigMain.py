import mod.ae2f.PreP.PreP
import os 

HERE = os.path.dirname(os.path.abspath(__file__))

paraminclude = [
    f"{HERE}/include",
    f"{HERE}/mod/ae2f/Bmp/include",
    f"{HERE}/mod/ae2f/Bmp/mod/ae2f/Core/include"
]

paramsrc: list[str]

with open('./mod/ae2f/Bmp/src/Src/Double.c', 'r') as F:
    paramsrc = F.readlines()

src_ret = mod.ae2f.PreP.PreP.Include(
    paramsrc,
    f"{HERE}/mod/ae2f/Bmp/src/Src",
    paraminclude 
) 

with open('./src/a.cl', 'w') as F:
    pre = """typedef uint uint32_t;
typedef ushort uint16_t;
typedef uchar uint8_t;
typedef int int32_t;

#define global m_global
""" + src_ret
    F.writelines(pre)