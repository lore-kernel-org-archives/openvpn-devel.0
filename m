From: mader.raphael@...1204...
Date: Sat, 17 Sep 2022 11:41:16 +0200
Message-Id: <20220917094116.1765-1-mader.raphael@...1204...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH openvpn3-linux] Fix non-systemd build
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

When building in a non-systemd environment, `#include <systemd/sd-journal.h=
>` causes the build to break.

Signed-off-by: Raphael Mader <mader.raphael@...1204...>
---
 src/log/logwriters/journald.cpp | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/log/logwriters/journald.cpp b/src/log/logwriters/journald.=
cpp
index f0fc85f..beb06b0 100644
--- a/src/log/logwriters/journald.cpp
+++ b/src/log/logwriters/journald.cpp
@@ -23,6 +23,8 @@
  * @brief  Implementation of JournaldWriter
  */

+#ifdef HAVE_SYSTEMD
+
 #include <sys/uio.h>
 #include <ctype.h>
 #include <string>
@@ -34,8 +36,6 @@
 #include "log/logwriters/journald.hpp"


-#ifdef HAVE_SYSTEMD
-
 JournaldWriter::JournaldWriter()
     : LogWriter()
 {
--
2.37.3.windows.1


