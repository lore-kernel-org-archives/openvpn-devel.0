From: Gert van Dijk <gert@...2298...>
Date: Sat, 11 Nov 2017 17:11:21 +0100
Message-Id: <20171111161122.30087-1-gert@...2298...>
Subject: [Openvpn-devel] [PATCH 1/2] manpage: improve description of
 --status and --status-version
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

Signed-off-by: Gert van Dijk <gert@...2298...>
---
 doc/openvpn.8 | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index a4189ac2..267497fd 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -2452,12 +2452,37 @@ seconds.
 Status can also be written to the syslog by sending a
 .B SIGUSR2
 signal.
+
+With multi\-client capability enabled on a server, the status file includes a
+list of clients and a routing table. The output format can be controlled by the
+.B \-\-status\-version
+option in that case.
+
+For clients or instances running in point\-to\-point mode, it will contain the
+traffic statistics.
 .\"*********************************************************
 .TP
 .B \-\-status\-version [n]
-Choose the status file format version number.  Currently
-.B n
-can be 1, 2, or 3 and defaults to 1.
+Set the status file format version number to
+.B n\fR.
+
+This only affects the status file on servers with multi\-client capability
+enabled.
+
+.B 1
+\-\- traditional format (default). The client list contains the following
+fields comma\-separated: Common Name, Real Address, Bytes Received, Bytes Sent,
+Connected Since.
+.br
+.B 2
+\-\- a more reliable format for external processing. Compared to version 1, the
+client list contains some additional fields: Virtual Address, Virtual IPv6
+Address, Username, Client ID, Peer ID.
+Future versions may extend the number of fields.
+.br
+.B 3
+\-\- identical to 2, but fields are tab\-separated.
+
 .\"*********************************************************
 .TP
 .B \-\-mute n
-- 
2.15.0


