From: Antonio Quartulli <a@...2181...>
Date: Sat, 13 Aug 2022 22:42:21 +0200
Message-Id: <20220813204224.22576-4-a@...2181...>
In-Reply-To: <20220813204224.22576-1-a@...2181...>
References: <20220813204224.22576-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v101 4/7] dco-win: add documentation to
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
Changes from v100:
* add URL to windows installer (openvpn+dco) and modify text
---
 README.dco.md | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/README.dco.md b/README.dco.md
index c38d3de3..aa93d667 100644
--- a/README.dco.md
+++ b/README.dco.md
@@ -57,6 +57,13 @@ see a message like
 in your log.
 
 
+Getting started (Windows)
+-------------------------
+The simplest way to test DCO under Windows is to download the latest installer
+from https://build.openvpn.net/downloads/snapshots/github-actions/openvpn2/ .
+This installer contains the latest OpenVPN code and the ovpn-dco-win driver.
+
+
 DCO and P2P mode
 ----------------
 DCO is also available when running OpenVPN in P2P mode without `--pull` /
@@ -111,7 +118,9 @@ Limitations by design
   - older versions are missing support for the AEAD ciphers;
 - topology subnet is the only supported `--topology` for servers;
 - iroute directives install routes on the host operating system, see also
-  Routing with ovpn-dco.
+  Routing with ovpn-dco;
+- (ovpn-dco-win) client and p2p mode only;
+- (ovpn-dco-win) Chacha20-Poly1305 support available starting with Windows 11.
 
 
 Current implementation limitations
-- 
2.35.1


