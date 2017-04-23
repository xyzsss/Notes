import threading
import time


def echo1():
    while True:
        print 'from echo1 ... start'
        time.sleep(1)
        print 'from echo1 ...  end '


def echo2():
    time.sleep(2)
    print 'from echo2222'


th = []
th.append(threading.Thread(target=echo1))
th.append(threading.Thread(target=echo2))
# define the array ,the add the thread into array

for t in th:
    t.setDaemon(True)   # define the daemon thread for being halt infinite
    t.start()        # start the thread

t.join()
# to wait the thread job run over normally;
# if not ,the thread will end with the main statement exec

print '\n\t script done\n'
