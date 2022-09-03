#include "base/main/main.h"
#include "base/main/mainInt.h"
#include "base/abc/abc.h"
#include "aig/gia/gia.h"
#include "misc/extra/extra.h"
//#include "aig/gia/giagen.c"

#include <iostream>
#include <fstream>
#include <string>
#include "simulation.h"

using namespace std;

typedef vector<size_t> PtnVec;

namespace
{

// extern "C" {
    
// }

double testWordFile( Abc_Ntk_t * p, char * pFileNameImg, char * pFileNameLabel, char * pDumpFile, int fVerbose );

int MnistTest_Command( Abc_Frame_t * pAbc, int argc, char ** argv )
{
    int c, fVerbose = 0;
    // char * pDumpFile = NULL;
    char ** pArgvNew;
    int nArgcNew;
    Abc_Ntk_t * pNtk;
    Extra_UtilGetoptReset();
    while ( ( c = Extra_UtilGetopt( argc, argv, "vh" ) ) != EOF )
    {
        switch ( c )
        {
        // case 'D':
        //     if ( globalUtilOptind >= argc )
        //     {
        //         Abc_Print( -1, "Command line switch \"-D\" should be followed by a file name.\n" );
        //         goto usage;
        //     }
        //     pDumpFile = argv[globalUtilOptind];
        //     globalUtilOptind++;
        //     break;
        case 'v':
            fVerbose ^= 1;
            break;
        case 'h':
            goto usage;
        default:
            goto usage;
        }
    }
    pArgvNew = argv + globalUtilOptind;
    nArgcNew = argc - globalUtilOptind;
    if ( nArgcNew == 3 )//aig file offered in command line
    {
        cout << "AIG name: " << pArgvNew[0] << endl;
        pNtk = Io_Read( pArgvNew[0], IO_FILE_AIGER, 0, 0 );
        // Gia_Man_t * pAig = Gia_AigerRead( pArgvNew[0], 0, 0, 0 );
        // cout << "nPO: " << Gia_ManCoNum(pAig) << endl;
        
        
        if ( pNtk == NULL )
        {
            Abc_Print( -1, "Reading AIGER from file \"%s\" has failed.\n", pArgvNew[0] );
            return 0;
        }
        if ( Abc_NtkLatchNum(pNtk) > 0 )
        {
            Abc_Print( -1, "CommandMNISTTest(): This command works only for combinational AIGs.\n" );
            return 0;
        }
        if ( Abc_NtkPiNum(pNtk) != 28*28*8 )
        {
            Abc_Print( -1, "CommandMNISTTest(): Expecting an AIG with 6272 inputs.\n" );
            return 0;
        }
        if ( Abc_NtkPoNum(pNtk) != 10 )
        {
            Abc_Print( -1, "CommandMNISTTest(): Expecting an AIG with 10 outputs.\n" );
            return 0;
        }
        // Gia_ManStop( pAig );
        
        // cout << "nPi: " << Abc_NtkPiNum(pNtk) << endl;
        // cout << "nPO: " << Abc_NtkPoNum(pNtk) << endl;
        testWordFile( pNtk, pArgvNew[1], pArgvNew[2], NULL, fVerbose );
        return 0;
    }
    //nArgcNew != 3 :   //aig file has been read
    pNtk = Abc_FrameReadNtk(pAbc);
    if ( pNtk == NULL )
    {
        Abc_Print( -1, "CommandMNISTTest(): There is no AIG.\n" );
        return 1;
    }
    if ( Abc_NtkPiNum(pNtk) != 28*28*8 )
    {
        Abc_Print( -1, "CommandMNISTTest(): Expecting an AIG with 6272 inputs.\n" );
        return 0;
    }
    if ( Abc_NtkPoNum(pNtk) != 10 )
    {
        Abc_Print( -1, "CommandMNISTTest(): Expecting an AIG with 10 outputs.\n" );
        return 0;
    }
    if ( nArgcNew != 2 )
    {
        Abc_Print( -1, "CommandMNISTTest(): Expecting data file name on the command line.\n" );
        return 0;
    }
    if ( Abc_NtkLatchNum(pNtk) > 0 )
    {
        Abc_Print( -1, "CommandMNISTTest(): This command works only for combinational AIGs.\n" );
        return 0;
    }
    // Abc_Ntk_t * pAig = Io_Read( pArgvNew[0], IO_FILE_AIGER, 0, 0 );
    // cout << "nPO: " << Abc_NtkPoNum(pAig) << endl;
    testWordFile( Abc_NtkStrash(pNtk,0,1,0), pArgvNew[0], pArgvNew[1], NULL, fVerbose );
    return 0;

usage:
    Abc_Print( -2, "usage: mnistTest [-vh] <file1> <file2> <file3>\n" );
    Abc_Print( -2, "\t          this command evaluates AIG for the MNIST dataset\n" );
    Abc_Print( -2, "\t-v      : toggle printing verbose information, including the simulation result and true label for each image [default = %s]\n", fVerbose? "yes": "no" );
    Abc_Print( -2, "\t-h      : print the command usage\n");
    // Abc_Print( -2, "\t-D file : file name to dump statistics [default = none]\n" );
    Abc_Print( -2, "\tfile1   : file with input AIG (or \"read_aiger <file1.aig>; mnistTest <file2> <file3>\" can be used)\n");
    Abc_Print( -2, "\tfile2   : file with MNIST image data\n");
    Abc_Print( -2, "\tfile3   : file with MNIST label data\n");
    return 1;
}

// string DecimalToBinaryString(size_t a)
// {
//     // cout << "sizemax: " << (size_t)SIZE_MAX << endl;
//     size_t b = a;
//     string binary = "";
//     size_t mask = (size_t)1 << 63;
//     while (mask > 0)
//     {
//         binary += ((b & mask) == 0) ? '0' : '1';
//         mask >>= 1;
//     }
//     // cout<<"bin:"<<binary<<endl;
//     return binary;
// }

int readMNISTFile(char * pFileNameImg, char * pFileNameLabel, vector<vector<size_t>> &vSimsIn, vector<int> &vSimsOut, int &nExamples)
{
    int nPixels   = 28 * 28;
    int nFileSize = Extra_FileSize( pFileNameImg ) - 16;//in bytes, the first 16 bytes are for other information
    nExamples = nFileSize / (nPixels);
    int nBatches = nExamples / 64 + 1;
    int nPI = nPixels * 8;
    // cout << "file size: " << nFileSize << endl;
    if ( nFileSize % (nPixels) )
    {
        printf( "The input file \"%s\" with image data does not appear to be in MNIST format.\n", pFileNameImg );
        return -1;
    }
    else
    {
        vector<size_t> zeros(nPI);
        vSimsIn = vector<vector<size_t>>(nBatches,zeros);// all zero, size: (nBatches, nPI)

        fstream file(pFileNameImg, ios::in|ios::binary);
        if(!file)
        {
            cout << "Faile to open image file " << pFileNameImg << endl;
        }
        file.seekg(16);//skip the first 16 bytes since they are not image data

        char buf[nPixels];//an image
        size_t val = 0;
        for(int i=0; i<10000; i++)//go through all examples
        {
            file.read(buf,sizeof(buf));
            // //print the read values for the first image
            // if(i==0)
            // {
            //     for(int p=0; p<nPixels; p++)
            //     {
            //         cout << "pix " << p << ": " << (int)buf[p] << endl;
            //     }
            // }

            int batchInd = i/64;
            
            for(int j=0;j<nPI;j++)
            {
                // // PI from MSB to LSB
                // val = buf[j/8] & (1<<(7-(j%8)));
                // val >>=  7-(j%8);//should be 0 or 1, from MSB to LSB

                // PI from LSB to MSB
                val = buf[j/8] & (1<<(j%8));
                val >>=  (j%8);//should be 0 or 1, from LSB to MSB

                assert(val==0 || val==1);
                vSimsIn[batchInd][j] |= val<<(63-(i%64));
            }
        }
        // //print first batch of vSimsIn
        // for(int i=0; i<nPI;i++)
        // {
        //     cout << "i=" << i << " : " << DecimalToBinaryString(vSimsIn[0][i]) << endl;
        // }
        file.close();

        file.open(pFileNameLabel,ios::in|ios::binary);
        file.seekg(8);//skip the first 8 bytes since they are not label data
        char l[1];
        for(int i=0;i<nExamples;i++)
        {
            file.read(l,1);
            vSimsOut.push_back((int)*l);
        }
        // cout << "labels:" << endl;
        // for(int i=0;i<1000;i++)
        // {
        //     cout << "i=" << i << " : " << vSimsOut[i] << endl;
        // }

        file.close();
        return 8*nPixels;
    }
}

double testWordFile( Abc_Ntk_t * pNtk, char * pFileNameImg, char * pFileNameLabel, char * pDumpFile, int fVerbose )
{
    if (fVerbose)
    {
        cout << "Img file name: " << pFileNameImg << endl;
        cout << "Label file name: " << pFileNameLabel << endl;
    }
    
    // abctime clk = Abc_Clock();
    int i, nExamples = 0;
    vector<vector<size_t>> vSimsIn;//shape: [numWords,numPI]
    vector<int> vSimsOut;//shape: [numTestingData]
    int nInputs = readMNISTFile( pFileNameImg, pFileNameLabel, vSimsIn, vSimsOut, nExamples );
    if(nInputs==-1)
        return 0;
    
    //simulation
    int numWords = 10000/64 + 1;
    int numPO = 10;
    vector<vector<size_t>> simResults(numWords,vector<size_t>(numPO));//shape: [numWords,numPO]
    Abc_Obj_t *pObj;
    for(int w=0;w<numWords;w++)
    {
        _sim(pNtk,vSimsIn[w]);
        Abc_NtkForEachPo(pNtk, pObj, i)
        {
            size_t v = (size_t)(pObj->pCopy);
            simResults[w][i]=v;
        }
    }
    //convert simResults to predicted labels
    vector<int> pred(10000);
    int ind, temp;
    if (fVerbose)
        cout << "\nSimulation results:\n";
    for(int w=0;w<numWords;w++)
    {
        for(i=0;i<64;i++)
        {
            ind = w*64 + i;//from 0 to 9999
            temp = -1;//pred undef
            for(int j=0;j<10;j++)
            {
                if(simResults[w][j]&((size_t)1<<(63-i)))
                {
                    if(temp==-1)
                    {
                        temp = j;
                    }
                    else
                    {
                        cout << "Error: There should be only one bit asserted in the circuit output." << endl;
                        temp = -2;
                        //return -1;
                    }
                }
            }
            assert(temp>=-2 && temp<=9);
            if (fVerbose)
                cout << "ind: " << ind << ", pred: " << temp << ", label: " << vSimsOut[ind] << endl;
            if (temp==-1)
                cout << "Error: There is no bit asserted in the circuit output for image " << ind << "." << endl;
            pred[ind] = temp;
            if(ind==9999) break;
        }
    }
    //compute the accuracy
    double correctCount = 0;//used for recording correct count
    for(i=0; i<10000;i++)
    {
        if(pred[i]==vSimsOut[i])
            correctCount++;
    }
    cout << endl;
    cout << "Testing accuracy: " << correctCount/100 << "%" << endl;
    cout << "Circuit size: " << Abc_NtkNodeNum(pNtk) << endl;
    if (Abc_NtkNodeNum(pNtk)>500000)
    {
        cout << "The circuit size exceeds the constraint.\n";
    }

    // Abc_PrintTime( 1, "Total checking time", Abc_Clock() - clk );
    return correctCount/100;
}

// called during ABC startup
void init(Abc_Frame_t* pAbc)
{
    Cmd_CommandAdd( pAbc, "IntroEDA", "mnistTest", MnistTest_Command, 0);
}

// called during ABC termination
void destroy(Abc_Frame_t* pAbc)
{
}

// this object should not be modified after the call to Abc_FrameAddInitializer
Abc_FrameInitializer_t frame_initializer = { init, destroy };

// register the initializer a constructor of a global object
// called before main (and ABC startup)
struct registrar
{
    registrar() 
    {
        Abc_FrameAddInitializer(&frame_initializer);
    }
} mnistTest_registrar;

} // unnamed namespace
