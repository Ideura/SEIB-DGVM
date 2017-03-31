 #!/bin/sh

##################################################################
#   Script for running a MPI job @ GCOE saver
#
# ___ Notice ___
#   (1) Execusion command -> sh go.sh &
#   (2) Attribute of this file must be '744'
#   (3) �����s����ƁA������x���O�C���������Ȃ��ƕϐ��̓��Z�b�g����Ȃ�
#   (4) ���s�t�@�C���͍L��v�Z�p�̐ݒ��Makefile���邱��
##################################################################

#Deleting previous output files
   echo "Deleting previous output files"
   cd result
   rm      *_out.txt          #Delete previous result files 1
   rm     *_out2.txt          #Delete previous result files 2
#   rm     *spnin.txt         #(���X�^�[�g���ɂ݈̂Ӗ�����) �Â��X�s���C���t�@�C�����폜
#   rename spnout spnin *.txt #(���X�^�[�g���ɂ݈̂Ӗ�����) �X�s���A�E�g�t�@�C�����X�s���C���t�@�C���ɖ��O�ύX
   cd ../
   
#Submit MPI program, and wait for complete
   qsub go.bat
   echo "Waiting for MPI comuptation"
   date
   while [[ `qstat | grep hsato | wc -l` -ge 1  ]]; do
     sleep 5
   done
   date
   
#���ʃt�@�C���̕ϊ��v���O�����𓊓����A���ꂪ�I���܂ő҂�
#   cd code_visualize
#   qsub go.bat
#   cd ../
#   echo "Converting result files"
#   
#   while [[ `qstat | grep hsato | wc -l` -ge 1  ]]; do
#     sleep 3
#   done
   
#Visualizing result files with R script
   echo "Visualizing result files"
   R --vanilla --slave --quiet < visualization.R
   
#Delete job record files
   rm *.o[0-9]*
   
#message
   echo "Normal End"
