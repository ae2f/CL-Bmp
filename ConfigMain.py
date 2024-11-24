import mod.ae2f.PreP.PreP as PreP
import os 

print("Hello World! BmpCLConfig is running...")
HERE = os.path.dirname(os.path.abspath(__file__))

PRM_INCLUDE = [
    f"{HERE}/include/",
    f"{HERE}/mod/ae2f/Bmp/include",
    f"{HERE}/mod/ae2f/Bmp/mod/ae2f/Core/include"
]
import pathlib

# Preprocess 0: Get all source and throw it to ...cl
for file in (f for f in pathlib.Path(f'{HERE}/src/').rglob('*.cl.c') if f.is_file()):
    FPATH : str = file.absolute().__str__()
    CTT : list[str]

    with open(FPATH, 'r') as F:
        CTT = F.readlines()

    src_ret = PreP.Include(CTT, file.parent.__str__(), PRM_INCLUDE)

    with open(FPATH[:len(FPATH) - 2], 'w') as F:
        ret = """typedef uint uint32_t;
typedef ushort uint16_t;
typedef uchar uint8_t;
typedef int int32_t;

#define global m_global
#define ae2f_ptrBmpSrcUInt8 uint8_t*
#define ae2f_Cmp_Fun_h
#define ae2f_BmpCLKernDef_h
""" + src_ret
        F.writelines(ret)

# Preprocess 1: 
for file in (f for f in pathlib.Path(f'{HERE}/src/').rglob("*.cl") if f.is_file()):
    FPATH : str = file.absolute().__str__()
    CTT : list[str]
    with open(FPATH) as F:
        CTT = F.readlines()

    with open((FPATH + 'h'), 'w') as F:
        F.writelines(['R"('] + CTT + [')"'])