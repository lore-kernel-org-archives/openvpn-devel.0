From: Christian Hesse <list@...1798...>
Date: Mon,  6 Jan 2020 09:04:26 +0100
Message-Id: <20200106080426.40701-1-list@...1798...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/1] configure.ac: replace set with env
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
To: OpenVPN Development <openvpn-devel@lists.sourceforge.net>
Cc: Christian Hesse <mail@...1798...>

From: Christian Hesse <mail@...1798...>

The shell builtin `set` produces different output for different shells:

bash$ set | grep '^TERM='
TERM=xterm
dash$ set | grep '^TERM='
TERM='xterm'

This may break reproducible builds depending on what shell is used.

Let's replace `set` with `env`, which is a real command and always
produces identical output.

Signed-off-by: Christian Hesse <mail@...1798...>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index a47e0a06..f13ff7b6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1326,7 +1326,7 @@ if test "${enable_async_push}" = "yes"; then
 	)
 fi
 
-CONFIGURE_DEFINES="`set | grep '^enable_.*=' ; set | grep '^with_.*='`"
+CONFIGURE_DEFINES="`env | grep '^enable_.*=' ; env | grep '^with_.*='`"
 AC_DEFINE_UNQUOTED([CONFIGURE_DEFINES], ["`echo ${CONFIGURE_DEFINES}`"], [Configuration settings])
 
 TAP_WIN_COMPONENT_ID="PRODUCT_TAP_WIN_COMPONENT_ID"

