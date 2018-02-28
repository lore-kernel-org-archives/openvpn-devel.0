From: David Sommerseth <davids@...515...>
Date: Wed, 28 Feb 2018 14:19:17 +0100
Message-Id: <20180228131918.12954-2-davids@...515...>
In-Reply-To: <20180228131918.12954-1-davids@...515...>
References: <20180228131918.12954-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH 2/3] man: Reword --management to prefer unix
 sockets over TCP
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
To: openvpn-devel@lists.sourceforge.net

It is more secure to use unix sockets instead of TCP ports for the
management interface, so reword it and provide some details why TCP is
not recommended.

Also re-arranged this section to be somewhat easier to read and clearer
on a few related details.

Signed-off-by: David Sommerseth <davids@...515...>

---
This patch depends on the .TQ macro.  If the support macro patch has not
been applied, it will not render nicely on platforms not containing .TQ
support.
---
 doc/openvpn.8 | 76 +++++++++++++++++++++++++++++------------------------------
 1 file changed, 37 insertions(+), 39 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index bd9f2606..a923da02 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -2555,54 +2555,52 @@ the compression efficiency will be very low, triggering openvpn to disable
 compression for a period of time until the next re\-sample test.
 .\"*********************************************************
 .TP
+.B \-\-management socket\-name unix [pw\-file] \ \ \ \ \ (recommended)
+.TQ
 .B \-\-management IP port [pw\-file]
-Enable a TCP server on
-.B IP:port
-to handle daemon management functions.
-.B pw\-file,
-if specified,
-is a password file (password on first line)
-or "stdin" to prompt from standard input.  The password
-provided will set the password which TCP clients will need
-to provide in order to access management functions.
+Enable a management server on a
+.B socket\-name
+Unix socket on those platforms supporting it, or on
+a designated TCP port.
 
-The management interface can also listen on a unix domain socket,
-for those platforms that support it.  To use a unix domain socket, specify
-the unix socket pathname in place of
-.B IP
-and set
-.B port
-to 'unix'.  While the default behavior is to create a unix domain socket
-that may be connected to by any process, the
+.B pw\-file
+, if specified, is a password file where the password must be on first line.
+Instead of a filename it can use the keyword stdin which will prompt the user
+for a password to use when OpenVPN is starting.
+
+For unix sockets, the  default  behaviour  is to create a unix domain socket
+that may be connected to by any process.  Use the
 .B \-\-management\-client\-user
 and
 .B \-\-management\-client\-group
-directives can be used to restrict access.
+directives to restrict access.
 
-The management interface provides a special mode where the TCP
-management link can operate over the tunnel itself.  To enable this mode,
-set
-.B IP
-= "tunnel".  Tunnel mode will cause the management interface
-to listen for a TCP connection on the local VPN address of the
-TUN/TAP interface.
+The management interface provides a special mode where the TCP management link
+can operate over the tunnel itself.  To enable this mode, set IP to
+.B tunnel.
+Tunnel mode will cause the  management interface to listen for a
+TCP connection on the local VPN address of the TUN/TAP interface.
 
-While the management port is designed for programmatic control
-of OpenVPN by other applications, it is possible to telnet
-to the port, using a telnet client in "raw" mode.  Once connected,
-type "help" for a list of commands.
+.B BEWARE
+of enabling the management interface over TCP.  In  these cases you should
+.I ALWAYS
+make use of
+.B pw\-file
+to password protect the management interface.  Any user who can connect to this
+TCP
+.B IP:port
+will be able to manage and control (and interfere with) the OpenVPN process.
+It is also strongly recommended to set IP to 127.0.0.1 (localhost) to restrict
+accessibility of the management server to local clients.
 
-For detailed documentation on the management interface, see
-the management\-notes.txt file in the
-.B management
-folder of
-the OpenVPN source distribution.
+While the management port is designed for  programmatic control of OpenVPN by
+other applications, it is possible to telnet to the port, using a telnet client
+in "raw" mode.  Once  connected, type "help" for a list of commands.
+
+For detailed documentation on the management interface, see the
+.I management\-notes.txt
+file in the management folder of the OpenVPN source distribution.
 
-It is strongly recommended that
-.B IP
-be set to 127.0.0.1
-(localhost) to restrict accessibility of the management
-server to local clients. 
 .TP
 .B \-\-management\-client
 Management interface will connect as a TCP/unix domain client to
-- 
2.13.5


