Date: Sun, 25 Dec 2022 00:01:23 +0100 (CET)
Message-Id: <202212242301.2BON1NYh018024@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221224194253.3202231-4-arne@...1227...>
References: <20221224194253.3202231-4-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Move dco_installed back to
 link_socket from link_socket.info.actual
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Tested on Linux/non-DCO (client and server) and DCO (client and server),
especially focusing on p2p --tls-server, which was the original reason
for moving dco_installed around.  Tests still succeed, good :-)

Test without --keepalive on the --tls-server (11 11t) and that still
gets confused, though it looks a bit different...

Dec 24 23:54:30 ubuntu2004 tun-udp-p2p-tls-sha256[1826875]: UDPv6 READ [14] from [AF_INET6]::ffff:194.97.140.5:51628: P_CONTROL_HARD_RESET_CLIENT_V2 kid=0 [ ] pid=0 DATA len=0
Dec 24 23:54:30 ubuntu2004 tun-udp-p2p-tls-sha256[1826875]: TLS Error: Received control packet from unexpected IP addr: [AF_INET6]::ffff:194.97.140.5:51628
Dec 24 23:54:30 ubuntu2004 tun-udp-p2p-tls-sha256[1826875]: UDPv6 WRITE [26] to [AF_INET6]::ffff:194.97.140.5:52318: P_CONTROL_HARD_RESET_SERVER_V2 kid=0 [ 0 ] pid=0 DATA len=0

..
Dec 24 23:55:38 ubuntu2004 tun-udp-p2p-tls-sha256[1826875]: UDPv6 READ [14] from [AF_INET6]2001:608:0:814::fb00:14:21675: P_CONTROL_HARD_RESET_CLIENT_V2 kid=0 [ ] pid=0 DATA len=0
Dec 24 23:55:38 ubuntu2004 tun-udp-p2p-tls-sha256[1826875]: TLS Error: Received control packet from unexpected IP addr: [AF_INET6]2001:608:0:814::fb00:14:21675
Dec 24 23:55:42 ubuntu2004 tun-udp-p2p-tls-sha256[1826875]: UDPv6 READ [14] from [AF_INET6]2001:608:0:814::fb00:14:21675: P_CONTROL_HARD_RESET_CLIENT_V2 kid=0 [ ] pid=0 DATA len=0
Dec 24 23:55:42 ubuntu2004 tun-udp-p2p-tls-sha256[1826875]: TLS Error: Received control packet from unexpected IP addr: [AF_INET6]2001:608:0:814::fb00:14:21675
Dec 24 23:55:42 ubuntu2004 tun-udp-p2p-tls-sha256[1826875]: UDPv6 WRITE [26] to [AF_INET6]::ffff:194.97.140.5:52318: P_CONTROL_HARD_RESET_SERVER_V2 kid=0 [ 0 ] pid=0 DATA len=0

.. and it still sticks to "send packets to the old address" - but going
back to the test run before this patch, it's the same problem, just 
without "dco_do_write()" being involved.  So, not better, but no worse
either - and since this change brought other issues Arne was experiencing,
this new approach seems to be a good thing.


The socket.h change breaks my bandaid patch, of which I'll send a v2
right away (because I still find that useful as an extra safety belt).

Your patch has been applied to the master branch.

commit 1413b38d0eacafb6c03c701236fe546f44f39a8d (master)
commit b87f69cdaad54a73bf5029b5511d33db06014602 (release/2.6)
Author: Arne Schwabe
Date:   Sat Dec 24 20:42:47 2022 +0100

     Move dco_installed back to link_socket from link_socket.info.actual

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221224194253.3202231-4-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25792.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


