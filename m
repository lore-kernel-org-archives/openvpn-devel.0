From: Marcel =?iso-8859-1?q?Pennewi=DF?= <mailinglists@...1145...>
Date: Wed, 30 Sep 2009 20:47:07 +0200
References: <7bb795fd0909251436v2369d6d5q674e63e0621fcd56@...278...>
	<200909301941.01923.mailinglists@...1145...>
	<7bb795fd0909301120veaf5f48gb65b081cd2cb09a3@...278...>
In-Reply-To: <7bb795fd0909301120veaf5f48gb65b081cd2cb09a3@...278...>
MIME-Version: 1.0
Message-Id: <200909302047.07444.mailinglists@...1145...>
Subject: Re: [Openvpn-devel] [PATCH] openvpn over ipv6 support -v0.4.6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Wednesday 30 September 2009 20:20:40 JuanJo Ciarlante wrote:
> Could you please copy me the the exact cmdline and context (inetd?)
> you are using in both cases?, also if there's any extra patch applied, etc.

/usr/sbin/openvpn --config /etc/openvpn/tcp.conf --writepid /var/run/openvpn.tcp.pid --daemon --setenv 
SVCNAME openvpn.tcp --cd /etc/openvpn

/etc/openvpn/tcp.conf:
port 897
proto tcp6-server
dev tap1
server-bridge 192.168.42.253 255.255.255.0 192.168.42.1 192.168.42.200

tls-server
dh /etc/openvpn/files/dh2048.pem
ca /etc/openvpn/files/ca.pem
cert /etc/openvpn/files/cert.pem
key /etc/openvpn/files/key.pem
comp-lzo
client-to-client
client-config-dir /etc/openvpn/clients
persist-tun
persist-key
keepalive 10 120
script-security 2
user nobody
group nogroup
verb 3

patch applied from gentoo ebuild:
--- socket.c~   2008-11-02 01:39:00.406009999 +0100
+++ socket.c    2008-11-02 01:39:00.406009999 +0100
@@ -22,6 +22,7 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */

+#define _GNU_SOURCE
 #include "syshead.h"

 #include "socket.h"

thx,
Marcel

