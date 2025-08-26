# This is catalogue continous integration jenkins file

## Below are the steps to be followed to write jenkins file for ci pipeline

### Step1:
    - Read json file and get version info from that file.
    - (utility steps pipeline plugin) to be installed in jenkins to let it read data from json file
### Step2:
    - Next we are going to build code. which means installing dependencies
### Step3:
    - Once dependencies are installed we need to test code. this one we can see later
    - create a stage for testing and leave for now
### Step4:  
    - Now, we need to build docker images and push them to ECR
        - ECR (Elastic Container Registry)
        Create a repo to store the images that are built
        After creating repo , you can see steps to be followed to oush images to that Repo
        so, write a build stage with that steps so that images will be pushed into that repo
