Message-Id: <ICBORZ$D7385F4E922E35DA6840D3A7F8CCEC44@...354...>
MIME-Version: 1.0
From: "andi\.c\@libero\.it" <andi.c@...354...>
Subject: [Openvpn-devel] Question about TAP win32 programming
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
Date: Tue Feb 22 09:23:27 2005
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi to all,
i am disperately in need of some advices about a subject not=0D
strictly about OpenVPN, but maybe there is someone here who
can help me..
I ve developed a tunnel-broker apps for Linux using TUN/TAP support,=0D
based on TUN virtual interfce like OpenVPN. In Linux, create (and open) =0D
a TUN device is easy, as i do:

#include <net/tun.h>
#include <linux/if_tun.h>

fp =3D fopen("/dev/net/tun",O_RDWR);
ioctl(fd, TUNSETIFF, &ifr);

and then i can read and write to and from TUN device with simple=0D
read() and write() calls.

Now, i'd like to port that software on win32. I have installed the TAP
DRIVER on my machine, and now i have a TAP davide named "tap0801".
Can someone explain me how i can do the same thing
under win32 ?

Thanks a lot






____________________________________________________________
Navighi a 2 MEGA e i primi 3 mesi sono GRATIS.=20
Scegli Libero Adsl Flat senza limiti su http://www.libero.it



