From: mader.raphael@...1204...
Date: Wed, 28 Sep 2022 19:38:50 +0200
Message-Id: <20220928173850.789-1-mader.raphael@...1204...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 openvpn3-linux] Fix non-systemd build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

From: Raphael Mader <mader.raphael@...1204...>

Signed-off-by: Raphael Mader <mader.raphael@...1204...>
---
 src/log/logwriters/journald.cpp | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/log/logwriters/journald.cpp b/src/log/logwriters/journald.=
cpp
index f0fc85f..a25537f 100644
--- a/src/log/logwriters/journald.cpp
+++ b/src/log/logwriters/journald.cpp
@@ -23,6 +23,10 @@
  * @brief  Implementation of JournaldWriter
  */

+#include "config.h"
+
+#ifdef HAVE_SYSTEMD
+
 #include <sys/uio.h>
 #include <ctype.h>
 #include <string>
@@ -34,8 +38,6 @@
 #include "log/logwriters/journald.hpp"


-#ifdef HAVE_SYSTEMD
-
 JournaldWriter::JournaldWriter()
     : LogWriter()
 {
--
2.37.3.windows.1


