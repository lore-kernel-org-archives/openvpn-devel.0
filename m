From: Alon Bar-Lev <alon.barlev@...277...>
Date: Wed, 29 Feb 2012 22:12:21 +0200
Message-Id: <1330546342-17794-52-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 51/52] build: distribute samples in windows
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
To: 
Cc: Alon Bar-Lev <alon.barlev@...277...>


Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 configure.ac       |    3 +++
 sample/Makefile.am |   14 ++++++++++++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index 0f2a62e..2b095a3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -903,6 +903,9 @@ AC_SUBST([OPTIONAL_PKCS11_HELPER_LIBS])
 
 AM_CONDITIONAL([WIN32], [test "${WIN32}" = "yes"])
 
+sampledir="\$(docdir)/sample"
+AC_SUBST([sampledir])
+
 AC_CONFIG_FILES([
 	version.sh
 	Makefile
diff --git a/sample/Makefile.am b/sample/Makefile.am
index 5df8d9c..8e35bfc 100644
--- a/sample/Makefile.am
+++ b/sample/Makefile.am
@@ -17,3 +17,17 @@ EXTRA_DIST = \
 	sample-windows \
 	sample-keys \
 	sample-scripts
+
+if WIN32
+sample_DATA = \
+	client.ovpn \
+	server.ovpn \
+	sample-windows/sample.ovpn
+
+client.ovpn: sample-config-files/client.conf
+	-rm -f client.ovpn
+	cp "$(srcdir)/sample-config-files/client.conf" client.ovpn
+server.ovpn: sample-config-files/server.conf
+	-rm -f server.ovpn
+	cp "$(srcdir)/sample-config-files/server.conf" server.ovpn
+endif
-- 
1.7.3.4


