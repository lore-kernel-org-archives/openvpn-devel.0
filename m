From: samuli@...515...
Date: Fri, 13 Mar 2020 15:01:33 +0200
Message-Id: <20200313130133.19045-1-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Document some limitations of
 --auth-user-pass
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

From: Samuli Seppänen <samuli@...515...>

URL: https://community.openvpn.net/openvpn/ticket/757
Signed-off-by: Samuli Seppänen <samuli@...515...>
---
 doc/openvpn.8 | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 864f94e8..9e54890e 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -4127,6 +4127,12 @@ The server configuration must specify an
 .B \-\-auth\-user\-pass\-verify
 script to verify the username/password provided by
 the client.
+
+Note that OpenVPN GUI on Windows does not prompt for the
+password if the file contains only the username. However,
+OpenVPN versions from 2.4 up bundle OpenVPN GUI version 11
+which is able to cache usernames and passwords internally.
+
 .\"*********************************************************
 .TP
 .B \-\-auth\-retry type
-- 
2.21.1


