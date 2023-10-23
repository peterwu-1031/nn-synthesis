# Introduction
1. Implementation of an efficient direct logic synthesis algorithm for DNN/CNNs [1].
2. Knowledge distillation was employed to enhance the accuracy of image classification.
3. A fully combinational circuit with less than 500k AND gates in its AIG can be generated for the quantized CNN model with a 96.23% accuracy on MNIST.
4. Completed circuit simulation with Vivado.
# Structure
```
model
├── model.pt               // Model with top-1 accuracy.
└── model_test.ipynb       // Test the accuracy of our model.

abc
├── model.aig              // Use abc command "mnistTest model.aig <images> <labels>" to test the accuracy and AIG size.
├── dataset
│   ├── t10k-images.gz     // Part of MNIST images.
│   └── t10k-labels.gz     // Corresponding labels.
└── ext-MNISTTest          // Put this folder in abc/src before 'make'.

circuit
├── model.v (top module)   // The fully combinational circuit which abc/model.aig was generated from.
├── conv1.v
├── fc1.v
├── fc2.v
└── fc3.v

src
├── model_training.ipynb   // How we train our model.
└── generate_circuit.ipynb // How we synthesize our model.

Vivado                     // Result of implementation on FPGA.
├── circuit
│   ├── top.sv (top module)
│   ├── debouncer.v
│   ├── MNIST_c1f3_32_4b.sv (model)
│   ├── conv1.sv
│   ├── fc1.sv
│   ├── fc2.sv
│   └── fc3.sv
└── results
    ├── TestingResult.JPG  // Accuracy.
    ├── TimingSummary.JPG
    ├── PowerSummary.JPG
    ├── LUT_counts.JPG
    └── DSP_counts.JPG

presentation.pdf           // More detailed introduction to this project.
report.pdf                 // All details of this project.
```
# More details
1. How to test accuracy? <br>
   Open model_test.ipynb with Colab and upload model.pt and run. <br>
2. Packages we used: <br>
   Torch, torchvision, collections. <br>
3. Model Architecture: <br>
   Conv(in_planes = 1, out_planes = 3, kernal_size = 3, stride = 2, padding = 0) <br>
   FC(in_features = 507, out_features = 32) <br>
   FC(in_features = 32, out_features = 32) <br>
   FC(in_features = 32, out_features = 10) <br>
4. Training techniques: <br>
   (1) Quantization-aware training with 4 bits. <br>
   (2) Batch normalization. <br>
   (3) Dropout (p = 0.2). <br>
   (4) Data Augmentation (Normalization, RandomRotate). <br>
   (5) Scheduler (ExponentialLR, gamma = 0.95) <br>
5. Circuit performance: <br>
   Latency:    20ns * 4 = 80ns <br>
   Throughput: 1 picture / 20ns = 50M pictures / 1s <br>
# Reference
[1] Y.-S.Huang,J.-H.R.Jiang,andA.Mishchenko, ”QuantizedNeuralNet- work Synthesis for Direct Logic Circuit Implementation,” in Proceedings of International Workshop on Logic & Synthesis (IWLS), 2021. <br>
[2] UC Berkeley's ABC tool. (https://github.com/berkeley-abc/abc)
