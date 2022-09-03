#include "base/main/main.h"
#include "base/main/mainInt.h"

#include <vector>
#include <iostream>
#include "simulation.h"

using namespace std;

typedef vector<size_t> PtnVec;

void _sim(Abc_Ntk_t * pNtk,PtnVec& ptn)
{
    Abc_Obj_t *pConst1 = Abc_AigConst1(pNtk);
    pConst1->pCopy = (Abc_Obj_t *)((size_t)SIZE_MAX);
    unsigned i = 0;
    Abc_Obj_t *pObj;
    Abc_NtkForEachPi(pNtk, pObj, i)
    {
        pObj->pCopy = (Abc_Obj_t *)ptn[i];
    }
    Abc_AigForEachAnd(pNtk, pObj, i)
    {
        size_t v0 = (size_t)(Abc_ObjFanin0(pObj)->pCopy);
        size_t v1 = (size_t)(Abc_ObjFanin1(pObj)->pCopy);
        if (Abc_ObjFaninC0(pObj))
          v0 = ~v0;
        if (Abc_ObjFaninC1(pObj))
          v1 = ~v1;
        const size_t p = v0 & v1;
        pObj->pCopy = (Abc_Obj_t *)p;
    }
    Abc_NtkForEachPo(pNtk, pObj, i)
    {
        size_t v = (size_t)(Abc_ObjFanin0(pObj)->pCopy);
        if (Abc_ObjFaninC0(pObj))
            v = ~v;
        pObj->pCopy = (Abc_Obj_t *)v;
    }
}