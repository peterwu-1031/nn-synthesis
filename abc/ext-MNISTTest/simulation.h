#ifndef SIMULATION_H
#define SIMULATION_H

#include "base/main/main.h"
#include "base/main/mainInt.h"

#include <vector>

typedef std::vector<size_t> PtnVec;


void _sim(Abc_Ntk_t * pNtk,PtnVec& ptn);

#endif
