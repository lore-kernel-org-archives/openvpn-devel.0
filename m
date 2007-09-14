Message-ID: <46E9F75C.1020409@...1050...>
Date: Thu, 13 Sep 2007 19:52:12 -0700
From: Jeff Wiegley <jeffw@...1050...>
MIME-Version: 1.0
Subject: [Openvpn-devel] How does one use Tun/tap for raw frames???
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

I know this is off-topic, sorry. The email address for
Max K. the creator of the tun/tap driver, simply bounces
and I'm beating my head against the wall. Since OpenVPN
uses tap devices in a raw state I hoped that maybe
somebody here would be able to help.

I want a very simply program that opens a tap device
and then displays all the Ethernet frames that come
through it. Basically I want something that delivers
Ethernet frames up to a userspace program.

Basically...

# tunctl -u jeffw
# ifconfig tap0 10.10.0.1 netmask 255.255.255.0
$ ./tapwatcher tap0

Then from another window I want to be able to do
"ping 10.10.0.1" and tapwatcher should spew the
raw Ethernet frames that would be generated on
tap0.

To that end I have written the program appended
here but it doesn't do anything. It starts up, it
reports it opened the tap and I get a decent
file descriptor value but the select hangs.
there is never anything present to read.
The weird thing that does happen is the pings are
responded to! Shouldn't the kernel be simply passing
the frames on to my tapwatcher program and not
processing them itself??? I can even SSH to the
stupid tap0 and I get logged into localhost.
Why is the kernel attached to tap0 and not my
tapwatcher program?

Am I missing something fundamental? I would be happy
to contribute my result back to the kernel sources
to replace/augment the tuntap.txt Documentation that
is weak and doesn't really give a new tun/tap user
what he needs to get something working. (the examples
in vtun are also both broken and don't compile/run
on my 64-bit machine.)

Thanks, here's the program I wrote.

- Jeff
-------------------------------------------------------
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#include <string.h>

#include <sys/ioctl.h>
#include <net/if.h>
#include <netinet/if_ether.h>
#include <linux/if_tun.h>

#include <errno.h>
#include <signal.h>

#include <sys/select.h>

int tun_alloc(char *dev)
{
  struct ifreq ifr;
  int result = -1;
  int err;

  if( (result = open("/dev/net/tun", O_RDWR)) >= 0 )
    return result;

  memset(&ifr, 0, sizeof(ifr));

  ifr.ifr_flags = IFF_TAP;
  if( *dev )
    strncpy(ifr.ifr_name, dev, IFNAMSIZ);

  if( (err = ioctl(fd, TUNSETIFF, (void *) &ifr)) < 0 )
    {
      close(result);
      return err;
    }

  strcpy(dev, ifr.ifr_name);

  return result;
}

int continue_running;

void handler(int num, siginfo_t *info, void *context)
{
  continue_running = 0;
}

int main(int argc, char *argv[])
{
  continue_running = 0;

  struct sigaction action;

  action.sa_sigaction = handler;
  sigemptyset (&action.sa_mask);
  action.sa_flags = SA_SIGINFO;

  sigaction(SIGINT, &action, NULL);

  char name[128];
  strcpy(name,argv[1]);
  int tap = tun_alloc(name);

  if (tap < 0)
    perror("TAP failed: ");
  else
    {
      continue_running = 1;
      fprintf(stderr,"tap = %d, name = \"%s\"\n",tap,name);
      while (continue_running)
	{
	  fd_set watch;
	  FD_ZERO(&watch);
	  FD_SET(tap,&watch);
	  errno = 0;
	  select(tap+1,&watch, NULL, NULL, NULL);
	  fprintf(stderr,"ready\n");
	  if (errno && (errno != EINTR))
	    break;
	}
      close(tap);
    }
}
-------------------------------------------------------------

-- 
Jeff Wiegley, PhD
Cyte.Com, LLC

