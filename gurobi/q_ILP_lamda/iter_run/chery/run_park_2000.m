% params
totalNum = 1502861;
bValue = 2000;
lamda = 0.1;
qFile = '/home/yinhuan/Data/mapModel/park/weightVector.txt';
visFilesDir = '/home/yinhuan/Data/mapModel/park/visMatrix/';
maxQ = 110;
minQ = 1;

splitLength_0 = 100;
saveResultsDir_0 = '/home/yinhuan/Data/mapModel/park/iter_b_2000/0/';
saveReIndexFile_0 = '/hozcme/yinhuan/Data/mapModel/park/iter_b_2000/index/0.txt';
saveNewQFile_0 = '/home/yinhuan/Data/mapModel/park/iter_b_2000/weight/0.txt';

splitLength_1 = 200;
saveResultsDir_1 = '/home/yinhuan/Data/mapModel/park/iter_b_2000/1/';
saveReIndexFile_1 = '/home/yinhuan/Data/mapModel/park/iter_b_2000/index/1.txt';
saveNewQFile_1 = '/home/yinhuan/Data/mapModel/park/iter_b_2000/weight/1.txt';

splitLength_2 = 400;
saveResultsDir_2 = '/home/yinhuan/Data/mapModel/park/iter_b_2000/2/';
saveReIndexFile_2 = '/home/yinhuan/Data/mapModel/park/iter_b_2000/index/2.txt';
saveNewQFile_2 = '/home/yinhuan/Data/mapModel/park/iter_b_2000/weight/2.txt';

splitLength_3 = 800;
saveResultsDir_3 = '/home/yinhuan/Data/mapModel/park/iter_b_2000/3/';
saveReIndexFile_3 = '/home/yinhuan/Data/mapModel/park/iter_b_2000/index/3.txt';
saveNewQFile_3 = '/home/yinhuan/Data/mapModel/park/iter_b_2000/weight/3.txt';

splitLength_4 = 800;
saveResultsDir_4 = '/home/yinhuan/Data/mapModel/park/iter_b_2000/4/';
saveReIndexFile_4 = '/home/yinhuan/Data/mapModel/park/iter_b_2000/index/4.txt';
saveNewQFile_4 = '/home/yinhuan/Data/mapModel/park/iter_b_2000/weight/4.txt';

%% iteration of optimization

visCells_origin = fromVisDirToCells(visFilesDir);

[ epsilon_soft_0, time_sum_0  ] = Uniform_loopCompress_Cells( lamda, qFile, visCells_origin, splitLength_0, totalNum, bValue, saveResultsDir_0 );
min_cost_0 = get_min_cost(minQ, maxQ, saveResultsDir_0, qFile, lamda, epsilon_soft_0);
[totalNum_0, visCells_0] = deleteZeroPoints_Cells( qFile, visCells_origin, saveResultsDir_0, saveReIndexFile_0, saveNewQFile_0 );

[ epsilon_soft_1, time_sum_1  ] = Uniform_loopCompress_Cells( lamda, saveNewQFile_0, visCells_0, splitLength_1, totalNum_0, bValue, saveResultsDir_1 );
min_cost_1 = get_min_cost(minQ, maxQ, saveResultsDir_1, saveNewQFile_0, lamda, epsilon_soft_1);
[totalNum_1, visCells_1] = deleteZeroPoints_Cells( saveNewQFile_0, visCells_0, saveResultsDir_1, saveReIndexFile_1, saveNewQFile_1 );

[ epsilon_soft_2, time_sum_2  ] = Uniform_loopCompress_Cells( lamda, saveNewQFile_1, visCells_1, splitLength_2, totalNum_1, bValue, saveResultsDir_2 );
min_cost_2 = get_min_cost(minQ, maxQ, saveResultsDir_2, saveNewQFile_1, lamda, epsilon_soft_2);
[totalNum_2, visCells_2] = deleteZeroPoints_Cells( saveNewQFile_1, visCells_1, saveResultsDir_2, saveReIndexFile_2, saveNewQFile_2 );





[ epsilon_soft_3, time_sum_3  ] = Uniform_loopCompress_Cells( lamda, saveNewQFile_2, visCells_2, splitLength_3, totalNum_2, bValue, saveResultsDir_3 );
min_cost_3 = get_min_cost(minQ, maxQ, saveResultsDir_3, saveNewQFile_2, lamda, epsilon_soft_3);
[totalNum_3, visCells_3] = deleteZeroPoints_Cells( saveNewQFile_2, visCells_2, saveResultsDir_3, saveReIndexFile_3, saveNewQFile_3 );


[ epsilon_soft_4, time_sum_4  ] = Uniform_loopCompress_Cells( lamda, saveNewQFile_3, visCells_3, splitLength_4, totalNum_3, bValue, saveResultsDir_4 );
min_cost_4 = get_min_cost(minQ, maxQ, saveResultsDir_4, saveNewQFile_3, lamda, epsilon_soft_4);
[totalNum_4, visCells_4] = deleteZeroPoints_Cells( saveNewQFile_3, visCells_3, saveResultsDir_4, saveReIndexFile_4, saveNewQFile_4 );





%% save the results

compressIndex_3 = anal_reindex_last(saveResultsDir_4, saveReIndexFile_3);
compressIndex_2 = anal_reindex_middle(compressIndex_3, saveReIndexFile_2);
compressIndex_1 = anal_reindex_middle(compressIndex_2, saveReIndexFile_1);
compressIndex_0 = anal_reindex_middle(compressIndex_1, saveReIndexFile_0);


dlmwrite('/home/yinhuan/Data/mapModel/park/iter_b_2000/compressIndex_final.txt', compressIndex_0, 'precision', '%d');








