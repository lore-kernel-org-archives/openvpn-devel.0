From: Antonio Quartulli <a@...2181...>
Date: Fri, 24 Jun 2022 10:38:08 +0200
Message-Id: <20220624083809.23487-25-a@...2181...>
In-Reply-To: <20220624083809.23487-1-a@...2181...>
References: <20220624083809.23487-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 24/25] dco-win: add documentation to
 README.dco.md
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
Cc: Antonio Quartulli <a@...2181...>, Arne Schwabe <arne@...1227...>, Lev Stipakov <lev@...515...>

Signed-off-by: Arne Schwabe <arne@...1227...>
Signed-off-by: Lev Stipakov <lev@...515...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 README.dco.md | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/README.dco.md b/README.dco.md
index e73e0fc2..ef56f0fe 100644
--- a/README.dco.md
+++ b/README.dco.md
@@ -58,6 +58,13 @@ see a message like
 in your log.
 
 
+Getting started (Windows)
+-------------------------
+Getting started under windows is currently for brave people having experience
+with windows development. You need to compile openvpn yourself and also need
+to get the test driver installed on your system.
+
+
 DCO and P2P mode
 ----------------
 DCO is also available when running OpenVPN in P2P mode without --pull/--client option.
@@ -109,6 +116,8 @@ Limitations by design
 - topology subnet is the only supported `--topology` for servers
 - iroute directives install routes on the host operating system, see also
   Routing with ovpn-dco
+- (ovpn-dco-win) client and p2p mode only
+- (ovpn-dco-win) Chacha20-Poly1305 support available starting with Windows 11
 
 
 Current implementation limitations
-- 
2.35.1


