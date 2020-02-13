#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>

#include "api.h"

void *thread_func(void *arg)
{
    int i = 0;
    while(i < 3) {
        printf("%s: i = %d\n", __func__, i);
        i++;
        sleep(1);
    }
    pthread_exit(NULL);
}

int main(int argc, char *argv[])
{
    pthread_t thrd;
    int ret;

    printf("%s: %s\n", argv[0], __func__);

    func_a();
    func_b();
    func_c();
    func_d();

    ret = pthread_create(&thrd, NULL, thread_func, NULL);
    if(ret) {
        perror("thread create");
        return 1;
    }
    ret = pthread_join(thrd, NULL);
    if(ret) {
        perror("thread join");
        return 1;
    }
    printf("%s: exit\n", __func__);
    return 0;
}
