Subject: Re: [Openvpn-devel] Patch: TAP usage made non ARP dependent
From: Marcelo Toledo <marcelo@...461...>
In-Reply-To: <4348FD69.6010807@...361...>
References: <43404D99.8080309@...361...>  <434189C7.5090304@...361...>
	 <1128369731.6952.59.camel@...399...> <4342703F.90607@...361...>
	 <1128428582.7061.18.camel@...399...>
	 <4342D092.4050502@...361...>
	 <1128619301.7000.58.camel@...399...>
	 <4346A01F.4030106@...361...>
	 <1128702738.7000.97.camel@...399...>
	 <4346ED46.4040204@...361...> <43478832.9050200@...361...>
	 <Pine.LNX.4.58.0510081447170.32321@...41...> <4348E1EF.8020906@...361...>
	 <4348FD69.6010807@...361...>
Message-Id: <1128947877.32068.39.camel@...399...>
Mime-Version: 1.0
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
Date: Mon Oct 10 05:40:11 2005
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Rolf Fokkens <r.fokkens@...361...>
Cc: openvpn-devel@lists.sourceforge.net

Em Dom, 2005-10-09 às 13:22 +0200, Rolf Fokkens escreveu:
> Attached the patch with #ifdefs. I added a #define MACTAB in
> config.h.in, though that may not be the proper way to do it.
> 
> I tested it with and without the #define MACTAB, both ways it compiles
> and runs OK with a TAP interface. I didn't test TUN.

Hi Rolf,

I've tested your old patch and here is the result.

Compiling we had a few warnings:

In file included from multi.h:40,
                 from mtcp.c:35:
         mac_table.h:6: warning: redefinition of `uint32_t'
         /usr/include/stdint.h:52: warning: `uint32_t' previously
declared here
         mac_table.h:7: warning: redefinition of `uint8_t'
         /usr/include/stdint.h:49: warning: `uint8_t' previously
declared here




mac_table.c: In function `mactab_init':
mac_table.c:72: warning: assignment makes pointer from integer without a
cast
mac_table.c: In function `mactab_remove_mi':
mac_table.c:275: warning: assignment makes integer from pointer without
a cast
gcc  -g -O2   -o openvpn  base64.o buffer.o crypto.o error.o event.o
fdmisc.o forward.o fragment.o gremlin.o helper.o init.o interval.o
list.o lzo.o manage.o mbuf.o misc.o mroute.o mss.o mtcp.o mtu.o mudp.o
multi.o ntlm.o occ.o openvpn.o options.o otime.o packet_id.o perf.o
ping.o plugin.o pool.o proto.o proxy.o push.o reliable.o route.o
schedule.o session_id.o shaper.o sig.o socket.o socks.o ssl.o status.o
thread.o tun.o mac_table.o   -lssl -lcrypto -llzo -ldl

And this error appeared in the server when trying to stabilish a
connection.


Sat Oct  8 14:28:25 2005 Data Channel MTU parms [ L:1576 D:1450 EF:44
EB:135 ET:32 EL:0 AF:3/1 ]
Sat Oct  8 14:28:25 2005 Listening for incoming TCP connection on
[undef]:1194
Sat Oct  8 14:28:25 2005 TCPv4_SERVER link local (bound): [undef]:1194
Sat Oct  8 14:28:25 2005 TCPv4_SERVER link remote: [undef]
Sat Oct  8 14:28:25 2005 Initialization Sequence Completed
Sat Oct  8 14:30:16 2005 Assertion failed at multi.c:1815
Sat Oct  8 14:30:16 2005 Exiting
-- 
Marcelo Toledo <marcelo@...461...>


