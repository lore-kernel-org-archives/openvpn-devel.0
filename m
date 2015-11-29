From: Arne Schwabe <arne@...1227...>
Date: Sun, 29 Nov 2015 19:52:24 +0100
Message-Id: <1448823144-1497-1-git-send-email-arne@...1227...>
In-Reply-To: <CAEsd45QjsjNDWFkoHG2O0ycO2pNGxj115TH+SLiUD__jf=WWpQ@...278...>
References: <CAEsd45QjsjNDWFkoHG2O0ycO2pNGxj115TH+SLiUD__jf=WWpQ@...278...>
Subject: [Openvpn-devel] [PATCH] Reflect enable-password-save change in
	documentation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

---
 Changes.rst   | 3 +++
 doc/openvpn.8 | 5 +----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index a791ca3..c2142fa 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -72,3 +72,6 @@ User-visible Changes
 - proto udp6/tcp6 in server mode will now try to always listen to
   both IPv4 and IPv6 on platforms that allow it. Use bind ipv6only
   to explicitly listen only on IPv6.
+
+- Removed --enable-password-save from configure. This option is now
+  always enabled.
diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 9889540..4297513 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -3800,10 +3800,7 @@ over the client's routing table.
 Authenticate with server using username/password.
 .B up
 is a file containing username/password on 2 lines. If the
-password line is missing, OpenVPN will prompt for one. (Note: OpenVPN
-will only read passwords from a file if it has been built
-with the \-\-enable\-password\-save configure option, or on Windows
-by defining ENABLE_PASSWORD_SAVE in win/settings.in).
+password line is missing, OpenVPN will prompt for one. 
 
 If
 .B up
-- 
2.4.9 (Apple Git-60)


