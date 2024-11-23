import mod.ae2f.PreP.PreP as PreP
import os 

print("Hello World! BmpCLConfig is running...")


HERE = os.path.dirname(os.path.abspath(__file__))
print(HERE)

paraminclude = [
    f"{HERE}/mod/ae2f/Bmp/include",
    f"{HERE}/mod/ae2f/Bmp/mod/ae2f/Core/include"
]

paramsrc: list[str]

# From Here is for Source
with open(f'{HERE}/mod/ae2f/Bmp/src/Src/Double.c', 'r') as F:
    paramsrc = F.readlines()

src_ret = PreP.Include(
    paramsrc,
    f"{HERE}/mod/ae2f/Bmp/src/Src",
    paraminclude 
)


# Library code assemble
with open(f'{HERE}/src/Programme/a.cl', 'w') as F:
    pre = """typedef uint uint32_t;
typedef ushort uint16_t;
typedef uchar uint8_t;
typedef int int32_t;

#define global m_global
#define ae2f_ptrBmpSrcUInt8 __global uint8_t*
#define ae2f_Cmp_Fun_h
""" + src_ret
    F.writelines(pre)

# Iterate all and make a raw string from source
import pathlib
for file in (f for f in pathlib.Path(f'{HERE}/src/').rglob("*.cl") if f.is_file()):
    FPATH : str = file.absolute().__str__()
    CTT : list[str]
    with open(FPATH) as F:
        CTT = F.readlines()

    with open((FPATH + 'h'), 'w') as F:
        F.writelines(['R"('] + CTT + [')"'])