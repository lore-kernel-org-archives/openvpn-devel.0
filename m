From: Lev Stipakov <lstipakov@...277...>
Date: Sat, 17 Sep 2022 19:34:25 +0300
Message-Id: <20220917163425.351-1-lstipakov@...277...>
In-Reply-To: <openvpn-devel@lists.sourceforge.net>
References: <openvpn-devel@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] doc: add "ovpn-dco" to usage and man page
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

While on it, remove redundant sentence
and quotation mark from --windows-driver man
description.

Signed-off-by: Lev Stipakov <lev@...515...>
---

v2:
 - mark ovpn-dco adapter as default, instead
of tap-windows6

 - mention that ovpn-dco requires --dev tun

 doc/man-sections/windows-options.rst | 6 +++---
 src/openvpn/options.c                | 3 ++-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/doc/man-sections/windows-options.rst b/doc/man-sections/windows-options.rst
index c389fbc4..368f7b19 100644
--- a/doc/man-sections/windows-options.rst
+++ b/doc/man-sections/windows-options.rst
@@ -238,7 +238,7 @@ Windows-Specific Options
   logged when this is found in the configuration file.
 
 --windows-driver drv
-  Specifies which tun driver to use. Values are :code:`tap-windows6`
-  (default) and :code:`wintun`.  This is a Windows-only option.
-  :code:`wintun`" requires ``--dev tun`` and the OpenVPN process to run
+  Specifies which tun driver to use. Values are :code:`ovpn-dco` (default),
+  :code:`tap-windows6` and :code:`wintun`. :code:`ovpn-dco` and :code:`wintun`
+  require ``--dev tun``. :code:`wintun` also requires OpenVPN process to run
   elevated, or be invoked using the Interactive Service.
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index d7954ebc..45fbb634 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -749,7 +749,8 @@ static const char usage_message[] =
     "--show-net-up   : Show " PACKAGE_NAME "'s view of routing table and net adapter list\n"
     "                  after TAP adapter is up and routes have been added.\n"
     "--windows-driver   : Which tun driver to use?\n"
-    "                     tap-windows6 (default)\n"
+    "                     ovpn-dco (default)\n"
+    "                     tap-windows6\n"
     "                     wintun\n"
     "--block-outside-dns   : Block DNS on other network adapters to prevent DNS leaks\n"
     "Windows Standalone Options:\n"
-- 
2.23.0.windows.1


