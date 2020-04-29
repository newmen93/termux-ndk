#include <jni.h>
#include <android/log.h>

#define LOG_TAG "TEST"

extern "C" {
    

JNIEXPORT jstring JNICALL 
Java_com_cmake_test_MainActivity_stringFromJNI(JNIEnv* env, jobject thiz) {
    
    __android_log_print(ANDROID_LOG_INFO, LOG_TAG, "hello\n");
    
    return env->NewStringUTF("Hello Android!");
    
}
    
} // extern "C"
