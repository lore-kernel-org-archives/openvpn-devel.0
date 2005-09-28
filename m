Message-ID: <433A7B68.9010500@...462...>
From: Sir Arthur <sir-arthur@...462...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Compiling troubles: undefined reference to lzo_init_v2
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
Date: Wed Sep 28 04:16:48 2005
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi all,

I've been trying to compile openvpn 2.0.2 with lzo-1.08, and 
openssl-0.9.7d installed (corresponding dev-packages also).
While compiling I get the following error:

gcc  -O2 -g -march=i586 -mcpu=i686 -fmessage-length=0   -o openvpn  
base64.o buffer.o crypto.o error.o event.o fdmisc.o forward.o fragment.o 
gremlin.o helper.o init.o interval.o list.o lzo.o manage.o mbuf.o misc.o 
mroute.o mss.o mtcp.o mtu.o mudp.o multi.o ntlm.o occ.o openvpn.o 
options.o otime.o packet_id.o perf.o ping.o plugin.o pool.o proto.o 
proxy.o push.o reliable.o route.o schedule.o session_id.o shaper.o sig.o 
socket.o socks.o ssl.o status.o thread.o tun.o   -lssl -lcrypto -llzo -ldl
lzo.o(.text+0x7cd): In function `lzo_compress_init':
/usr/src/packages/BUILD/openvpn-2.0.2/lzo.c:112: undefined reference to 
`__lzo_init_v2'
collect2: ld returned 1 exit status
make[1]: *** [openvpn] Fehler 1
make[1]: Leaving directory `/usr/src/packages/BUILD/openvpn-2.0.2'
make: *** [all] Fehler 2
error: Bad exit status from /var/tmp/rpm-tmp.10360 (%build)

Any hints
THX in advance


