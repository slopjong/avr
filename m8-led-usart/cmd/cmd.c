#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <termios.h>

int fd;

void open_port(void) {
  struct termios options;
  
  fd = open("/dev/ttyUSB0", O_RDWR | O_NOCTTY | O_NDELAY);

  if (fd == -1) {
	perror("open_port: Unable to open /dev/ttyUSB-blau - ");
  } else fcntl(fd, F_SETFL, 0);

  tcgetattr(fd, &options);
  cfsetispeed(&options, B9600);
  cfsetospeed(&options, B9600);
  options.c_cflag |= (CLOCAL | CREAD);
  
  options.c_cflag &= ~PARENB;
  options.c_cflag &= ~CSTOPB;
  options.c_cflag &= ~CSIZE;
  options.c_cflag |= CS8;
  
  options.c_cflag &= ~CRTSCTS; // disable hw flow control
  options.c_iflag |= (IXON | IXOFF | IXANY); // enable sw flow control
  
  options.c_lflag &= ~(ICANON | ECHO | ECHOE | ISIG); // raw
  
  tcsetattr(fd, TCSANOW, &options);
}

led_off() {
  if (write(fd, "a\r", 2) < 0)
    fputs("write() of 2 bytes failed!\n", stderr);
}

led_on() {
  if (write(fd, "b\r", 2) < 0)
    fputs("write() of 2 bytes failed!\n", stderr);
}

int main() {
  open_port();
  
  led_on();
  led_off();
  
  close(fd);
}
