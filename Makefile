INPUT_FILE ?= zbar/qr.cpp
OUTPUT_DIR ?= public/wasm
OUTPUT_FILE ?= zbar
ZBAR_NAME ?= zbar-0.23.90


build: $(INPUT_FILE)
	mkdir -p ${OUTPUT_DIR}
	em++ -Oz -Wc++11-extensions -std=c++11 -Wall -Werror -o ${OUTPUT_DIR}/${OUTPUT_FILE}.js \
		${INPUT_FILE} -I /src/${ZBAR_NAME}/include/ \
		/src/${ZBAR_NAME}/zbar/*.o /src/${ZBAR_NAME}/zbar/*/*.o \
		-s EXTRA_EXPORTED_RUNTIME_METHODS='["cwrap", "UTF8ToString"]' \
		-s "BINARYEN_METHOD='native-wasm'" \
		-s ALLOW_MEMORY_GROWTH=1 \
		-s INLINING_LIMIT=1 \
		-s FILESYSTEM=0 \
		-s MODULARIZE=1 \
		-s ENVIRONMENT=worker \
		-s WASM=1

clean:
	rm ${OUTPUT_DIR}/${OUTPUT_FILE}.*
