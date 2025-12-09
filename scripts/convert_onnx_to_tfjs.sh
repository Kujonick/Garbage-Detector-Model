set -euo pipefail

rm -rf ./models/saved_model_tf
uv run onnx2tf -i ./models/waste_model.onnx -o ./models/saved_model_tf

rm -rf ./models/tfjs_model
uv run tensorflowjs_converter --input_format=tf_saved_model --output_format=tfjs_graph_model --signature_name=serving_default ./models/saved_model_tf ./models/tfjs_model