Message-ID: <40F7F410.70200@...83...>
From: webmaster <uni-webmaster@...83...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Better understanding Proxy.c vs Socks.c
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
Date: Fri Jul 16 08:28:15 2004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

is it right, that proxy.c only is needed to establish a connection via 
the proxy. After that the communication is done via Socks.c?

And what does

/* format Socks CONNECT message */
  buf[0] = '\x05';        /* VER = 5 */
  buf[1] = '\x01';        /* CMD = 1 (CONNECT) */
  buf[2] = '\x00';        /* RSV */
  buf[3] = '\x03';        /* ATYP = 3 (DOMAINNAME) */

in socks.c mean? Is there any documentation on this?

Greetings

Ullrich

