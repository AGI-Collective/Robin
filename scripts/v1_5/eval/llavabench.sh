#!/bin/bash

python -m robin.eval.model_vqa \
    --model-path liuhaotian/llava-v1.5-13b \
    --question-file ./playground/data/eval/llava-bench-in-the-wild/questions.jsonl \
    --image-folder ./playground/data/eval/llava-bench-in-the-wild/images \
    --answers-file ./playground/data/eval/llava-bench-in-the-wild/answers/llava-v1.5-13b.jsonl \
    --temperature 0 \
    --conv-mode vicuna_v1

mkdir -p playground/data/eval/llava-bench-in-the-wild/reviews

python robin.eval/eval_gpt_review_bench.py \
    --question playground/data/eval/llava-bench-in-the-wild/questions.jsonl \
    --context playground/data/eval/llava-bench-in-the-wild/context.jsonl \
    --rule robin.eval/table/rule.json \
    --answer-list \
        playground/data/eval/llava-bench-in-the-wild/answers_gpt4.jsonl \
        playground/data/eval/llava-bench-in-the-wild/answers/llava-v1.5-13b.jsonl \
    --output \
        playground/data/eval/llava-bench-in-the-wild/reviews/llava-v1.5-13b.jsonl

python robin.eval/summarize_gpt_review.py -f playground/data/eval/llava-bench-in-the-wild/reviews/llava-v1.5-13b.jsonl
