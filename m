From: Juan Rodriguez Hervella <jrh@...176...>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_OmHSA47Hj2R/cU0"
Message-Id: <200403051358.54465.jrh@...176...>
Subject: [Openvpn-devel] --redirect-gateway on FreeBSD
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Fri Mar  5 05:06:08 2004
To: openvpn-devel@lists.sourceforge.net

--Boundary-00=_OmHSA47Hj2R/cU0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I've just subscribed to this list, but I've read on the
archives that the --redirect-gateway function is not
working yet on FreeBSD because of the problem of
retreiving the address of the default gateway.

I've just written a small program which makes that,
looking at /usr/src/sbin/route.c

Hope this helps, I've tested it on both FreeBSD-4.9
and FreeBSD-5.2

It uses PF_ROUTE sockets.

hope this helps!
-- 
******
JFRH
******

Go climb a gravity well!

--Boundary-00=_OmHSA47Hj2R/cU0
Content-Type: text/plain;
  charset="us-ascii";
  name="get_default_route.c.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="get_default_route.c.txt"

#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <net/route.h>
#include <err.h>
#include <errno.h>
#include <arpa/inet.h>
#include <stdio.h>

#include <sys/types.h>
#include <unistd.h>
#include <string.h>

struct {
	struct rt_msghdr m_rtm;
	char	   m_space[512];
} m_rtmsg;

#define ROUNDUP(a) \
	((a) > 0 ? (1 + (((a) - 1) | (sizeof(long) - 1))) : sizeof(long))

#define ADVANCE(x, n) (x += ROUNDUP((n)->sa_len))

char aux[INET_ADDRSTRLEN];
struct sockaddr so_dst, so_mask;


char *routename( struct sockaddr *sa )
{
        inet_ntop( AF_INET, &((struct sockaddr_in *)sa)->sin_addr, aux, INET_ADDRSTRLEN );

	return aux;
}


void print_getmsg(struct rt_msghdr *rtm, int msglen)       
{
	struct sockaddr *dst = NULL, *gate = NULL, *mask = NULL;
	struct sockaddr *sa;
	char *cp;
	int i;

	(void) printf("   route to: %s\n", routename(&so_dst));
	if (rtm->rtm_version != RTM_VERSION) {
		warnx("routing message version %d not understood",
		     rtm->rtm_version);
		return;
	}
	if (rtm->rtm_msglen > msglen) {
		warnx("message length mismatch, in packet %d, returned %d",
		      rtm->rtm_msglen, msglen);
	}
	if (rtm->rtm_errno)  {
		errno = rtm->rtm_errno;
		warn("message indicates error %d", errno);
		return;
	}
	cp = ((char *)(rtm + 1));
	if (rtm->rtm_addrs)
		for (i = 1; i; i <<= 1)
			if (i & rtm->rtm_addrs) {
				sa = (struct sockaddr *)cp;
				switch (i) {
				case RTA_DST:
					dst = sa;
					break;
				case RTA_GATEWAY:
					gate = sa;
					break;
				case RTA_NETMASK:
					mask = sa;
					break;
				}
				ADVANCE(cp, sa);
			}
	
	if (dst)
		(void)printf("destination: %s\n", routename(dst));
		
	if (mask)
		(void)printf("       mask: %s\n", routename(mask));		    	       

	if (gate && rtm->rtm_flags & RTF_GATEWAY)
		(void)printf("    gateway: %s\n", routename(gate));
}



int main()
{
  int s, seq, l, pid, rtm_addrs;
  char *cp = m_rtmsg.m_space; 

#define NEXTADDR(w, u) \
        if (rtm_addrs & (w)) {\
            l = ROUNDUP(u.sa_len); memmove(cp, &(u), l); cp += l;\
        }

#define rtm m_rtmsg.m_rtm

  pid = getpid();
  seq = 0;
  rtm_addrs = RTA_DST | RTA_NETMASK;

  bzero(&so_dst, sizeof(so_dst));
  bzero(&so_mask, sizeof(so_mask));
  bzero(&rtm, sizeof(struct rt_msghdr));

  rtm.rtm_type = RTM_GET;
  rtm.rtm_flags = RTF_UP | RTF_GATEWAY;
  rtm.rtm_version = RTM_VERSION;
  rtm.rtm_seq = ++seq;
  rtm.rtm_addrs = rtm_addrs; 

  NEXTADDR(RTA_DST, so_dst);
  NEXTADDR(RTA_NETMASK, so_mask);

  rtm.rtm_msglen = l = cp - (char *)&m_rtmsg;

  s = socket(PF_ROUTE, SOCK_RAW, 0);

  if (write(s, (char *)&m_rtmsg, l) < 0) {
		warn("writing to routing socket");
		return (-1);
  }

  do {
	l = read(s, (char *)&m_rtmsg, sizeof(m_rtmsg));
  } while (l > 0 && (rtm.rtm_seq != seq || rtm.rtm_pid != pid));
			

  print_getmsg(&rtm, l);

  return 0;
}


--Boundary-00=_OmHSA47Hj2R/cU0--

