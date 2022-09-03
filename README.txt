model.aig        // Use abc command {mnistTest model.aig <data> <labels>} to test the accuracy and AIG size.

report.pdf       // Details of our project and description of our job division.

presentation.pdf // Our material for presentation.

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
model/
-model.pt         // Model with top-1 accuracy
-model_test.ipynb // Test the accuracy of our model

1. How to test accuracy?
   Open model_test.ipynb with Colab and upload model.pt and run.

2. Packages we used:
   Torch, torchvision, collections.

3. Model Architecture:
   Conv(in_planes = 1, out_planes = 3, kernal_size = 3, stride = 2, padding = 0)
   FC(in_features = 507, out_features = 32)
   FC(in_features = 32, out_features = 32)
   FC(in_features = 32, out_features = 10)

4. Training techniques:
   (1) Quantization-aware-training with 4 bits.
   (2) Batch normalization.
   (3) Dropout (p = 0.2).
   (4) Data Augmentation (Normalization, RandomRotate).
   (5) Scheduler (ExponentialLR, gamma = 0.95)

5. How do we use the testing set?
   We only used it to test the accuracy of our model after training, which we had trained different models or the same architecture with different parameters about 20 times in total.

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
circuit/
-model.v (top module)
 -conv1.v
 -fc1.v
 -fc2.v
 -fc3.v
   
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
src/
-model_training.ipynb   // How we train our model.
-generate_circuit.ipynb // How we synthesize our model.
   
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Vivado/
 -circuit/
  -top.sv (top module)
   -debouncer.v
   -MNIST_c1f3_32_4b.sv (model)
    -conv1.sv
    -fc1.sv
    -fc2.sv
    -fc3.sv
 
 -results/
  -TestingResult.JPG // Accuracy
  -TimingSummary.JPG
  -PowerSummary.JPG
  -LUT_counts.JPG
  -DSP_counts.JPG

1. Circuit performance:
   Latency:    20ns * 4 = 80ns
   Throughput: 1 picture / 20ns = 50M pictures / 1s
