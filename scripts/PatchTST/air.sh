if [ ! -d "./logs" ]; then
    mkdir ./logs
fi

if [ ! -d "./logs/LongForecasting" ]; then
    mkdir ./logs/LongForecasting
fi
seq_len=336
model_name=PatchTST

root_path_name=../data/air_quality/
data_path_name=air_s.csv
model_id_name=air_s
data_name=custom

random_seed=2021

for pred_len in 96 192 336
do
    python -u run_longExp.py \
      --random_seed $random_seed \
      --is_training 1 \
      --root_path $root_path_name \
      --data_path $data_path_name \
      --model_id $model_id_name \
      --model $model_name \
      --data $data_name \
      --features M \
      --seq_len $seq_len \
      --pred_len $pred_len \
      --enc_in 9 \
      --e_layers 3 \
      --d_model 256 \
      --dropout 0.2\
      --head_dropout 0\
      --patch_len 16\
      --stride 8 \
      --des 'Exp' \
      --train_epochs 100\
      --patience 5\
      --loss_flag 2\
      --itr 1 --batch_size 256 --learning_rate 0.001 >logs/LongForecasting/$model_name'_'$model_id_name'_sl'$seq_len'_pl'$pred_len'_random_seed'$random_seed.log
done