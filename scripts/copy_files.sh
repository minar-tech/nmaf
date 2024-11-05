for i in $(seq -w 1 9); do
  gsutil cp gs://nmaf_input-bucket/footnote_ar_00"$i".html gs://nmaf_input-bucket-1/
done

for i in $(seq -w 10 72); do
  gsutil cp gs://nmaf_input-bucket/footnote_ar_0"$i".html gs://nmaf_input-bucket-1/
done

for i in $(seq -w 73 99); do
  gsutil cp gs://nmaf_input-bucket/footnote_ar_0"$i".html gs://nmaf_input-bucket-2/
done

for i in $(seq -w 100 144); do
  gsutil cp gs://nmaf_input-bucket/footnote_ar_"$i".html gs://nmaf_input-bucket-2/
done
