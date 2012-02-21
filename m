From: Alon Bar-Lev <alon.barlev@...277...>
Date: Tue, 21 Feb 2012 03:22:41 +0200
Message-Id: <1329787361-26096-36-git-send-email-alon.barlev@...277...>
In-Reply-To: <1329787361-26096-1-git-send-email-alon.barlev@...277...>
References: <1329787361-26096-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 35/35] build: move out config.h include from
	syshead
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
Cc: Alon Bar-Lev <alon.barlev@...277...>

Yet another step in reducing the syshead.h content.

Conditional compilation of sources needs to be based on
a minimum program prefix (config.h only).

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 src/openvpn/base64.c              |    6 ++++++
 src/openvpn/buffer.c              |    6 ++++++
 src/openvpn/clinat.c              |    6 ++++++
 src/openvpn/compat.c              |    6 ++++++
 src/openvpn/crypto.c              |    6 ++++++
 src/openvpn/crypto_openssl.c      |    6 ++++++
 src/openvpn/crypto_polarssl.c     |    6 ++++++
 src/openvpn/cryptoapi.c           |    6 ++++++
 src/openvpn/dhcp.c                |    6 ++++++
 src/openvpn/error.c               |    6 ++++++
 src/openvpn/event.c               |    6 ++++++
 src/openvpn/fdmisc.c              |    6 ++++++
 src/openvpn/forward.c             |    6 ++++++
 src/openvpn/fragment.c            |    6 ++++++
 src/openvpn/gremlin.c             |    6 ++++++
 src/openvpn/helper.c              |    6 ++++++
 src/openvpn/httpdigest.c          |    6 ++++++
 src/openvpn/init.c                |    6 ++++++
 src/openvpn/interval.c            |    6 ++++++
 src/openvpn/list.c                |    6 ++++++
 src/openvpn/lladdr.c              |    6 ++++++
 src/openvpn/lzo.c                 |    6 ++++++
 src/openvpn/manage.c              |    6 ++++++
 src/openvpn/mbuf.c                |    6 ++++++
 src/openvpn/misc.c                |    6 ++++++
 src/openvpn/mroute.c              |    6 ++++++
 src/openvpn/mss.c                 |    6 ++++++
 src/openvpn/mstats.c              |    6 ++++++
 src/openvpn/mtcp.c                |    6 ++++++
 src/openvpn/mtu.c                 |    6 ++++++
 src/openvpn/mudp.c                |    6 ++++++
 src/openvpn/multi.c               |    6 ++++++
 src/openvpn/ntlm.c                |    6 ++++++
 src/openvpn/occ.c                 |    6 ++++++
 src/openvpn/openvpn.c             |    6 ++++++
 src/openvpn/options.c             |    6 ++++++
 src/openvpn/otime.c               |    6 ++++++
 src/openvpn/packet_id.c           |    6 ++++++
 src/openvpn/perf.c                |    6 ++++++
 src/openvpn/pf.c                  |    6 ++++++
 src/openvpn/ping.c                |    6 ++++++
 src/openvpn/pkcs11.c              |    6 ++++++
 src/openvpn/pkcs11_openssl.c      |    6 ++++++
 src/openvpn/pkcs11_polarssl.c     |    6 ++++++
 src/openvpn/plugin.c              |    6 ++++++
 src/openvpn/pool.c                |    6 ++++++
 src/openvpn/proto.c               |    6 ++++++
 src/openvpn/proxy.c               |    6 ++++++
 src/openvpn/ps.c                  |    6 ++++++
 src/openvpn/push.c                |    6 ++++++
 src/openvpn/reliable.c            |    6 ++++++
 src/openvpn/route.c               |    6 ++++++
 src/openvpn/schedule.c            |    6 ++++++
 src/openvpn/session_id.c          |    6 ++++++
 src/openvpn/shaper.c              |    6 ++++++
 src/openvpn/sig.c                 |    6 ++++++
 src/openvpn/socket.c              |    6 ++++++
 src/openvpn/socks.c               |    6 ++++++
 src/openvpn/ssl.c                 |    6 ++++++
 src/openvpn/ssl_openssl.c         |    6 ++++++
 src/openvpn/ssl_polarssl.c        |    6 ++++++
 src/openvpn/ssl_verify.c          |    6 ++++++
 src/openvpn/ssl_verify_openssl.c  |    6 ++++++
 src/openvpn/ssl_verify_polarssl.c |    6 ++++++
 src/openvpn/status.c              |    6 ++++++
 src/openvpn/syshead.h             |    9 ---------
 src/openvpn/tun.c                 |    6 ++++++
 src/openvpn/win32.c               |    7 +++++++
 68 files changed, 403 insertions(+), 9 deletions(-)

diff --git a/src/openvpn/base64.c b/src/openvpn/base64.c
index 303d773..bb89aae 100644
--- a/src/openvpn/base64.c
+++ b/src/openvpn/base64.c
@@ -31,6 +31,12 @@
  * SUCH DAMAGE.
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #if defined(ENABLE_HTTP_PROXY) || defined(ENABLE_PKCS11) || defined(ENABLE_CLIENT_CR) || defined(MANAGMENT_EXTERNAL_KEY)
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 391085b..ad30223 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -22,6 +22,12 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #include "common.h"
diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
index 8e85e22..af75fc9 100644
--- a/src/openvpn/clinat.c
+++ b/src/openvpn/clinat.c
@@ -22,6 +22,12 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #if defined(ENABLE_CLIENT_NAT)
diff --git a/src/openvpn/compat.c b/src/openvpn/compat.c
index 2b1098e..f2fa265 100644
--- a/src/openvpn/compat.c
+++ b/src/openvpn/compat.c
@@ -22,6 +22,12 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 #include "compat.h"
 #include <string.h>
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 9e7fa87..2e2e5d7 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -23,6 +23,12 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #ifdef ENABLE_CRYPTO
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 72b0c3c..4a3be1e 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -27,6 +27,12 @@
  * @file Data Channel Cryptography OpenSSL-specific backend interface
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #if defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_OPENSSL)
diff --git a/src/openvpn/crypto_polarssl.c b/src/openvpn/crypto_polarssl.c
index 7a7d9b0..0e6728c 100644
--- a/src/openvpn/crypto_polarssl.c
+++ b/src/openvpn/crypto_polarssl.c
@@ -27,6 +27,12 @@
  * @file Data Channel Cryptography PolarSSL-specific backend interface
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #if defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_POLARSSL)
diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index a825126..3eb942f 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -28,6 +28,12 @@
  * THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #ifdef ENABLE_CRYPTOAPI
diff --git a/src/openvpn/dhcp.c b/src/openvpn/dhcp.c
index 280a4af..8d0b18a 100644
--- a/src/openvpn/dhcp.c
+++ b/src/openvpn/dhcp.c
@@ -22,6 +22,12 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #include "dhcp.h"
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index 3de5487..1f2dd86 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -22,6 +22,12 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #include "error.h"
diff --git a/src/openvpn/event.c b/src/openvpn/event.c
index 51b17b3..26d9bcb 100644
--- a/src/openvpn/event.c
+++ b/src/openvpn/event.c
@@ -22,6 +22,12 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #include "buffer.h"
diff --git a/src/openvpn/fdmisc.c b/src/openvpn/fdmisc.c
index 5be3c8b..8dc11b1 100644
--- a/src/openvpn/fdmisc.c
+++ b/src/openvpn/fdmisc.c
@@ -22,6 +22,12 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #include "fdmisc.h"
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 5e1e2a6..e13b81a 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -22,6 +22,12 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #include "forward.h"
diff --git a/src/openvpn/fragment.c b/src/openvpn/fragment.c
index 5ef3a47..7ad1d61 100644
--- a/src/openvpn/fragment.c
+++ b/src/openvpn/fragment.c
@@ -22,6 +22,12 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #ifdef ENABLE_FRAGMENT
diff --git a/src/openvpn/gremlin.c b/src/openvpn/gremlin.c
index c7c0206..f0aa7f6 100644
--- a/src/openvpn/gremlin.c
+++ b/src/openvpn/gremlin.c
@@ -27,6 +27,12 @@
  * network outages when the --gremlin option is used.
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #ifdef ENABLE_DEBUG
diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
index 22ea652..d9eef03 100644
--- a/src/openvpn/helper.c
+++ b/src/openvpn/helper.c
@@ -22,6 +22,12 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #include "forward.h"
diff --git a/src/openvpn/httpdigest.c b/src/openvpn/httpdigest.c
index 5907637..8afa3d4 100644
--- a/src/openvpn/httpdigest.c
+++ b/src/openvpn/httpdigest.c
@@ -22,6 +22,12 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #if PROXY_DIGEST_AUTH
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index e71ebb0..d9bc9e7 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -22,6 +22,12 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #include "win32.h"
diff --git a/src/openvpn/interval.c b/src/openvpn/interval.c
index 44d59d0..64494f1 100644
--- a/src/openvpn/interval.c
+++ b/src/openvpn/interval.c
@@ -22,6 +22,12 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #include "interval.h"
diff --git a/src/openvpn/list.c b/src/openvpn/list.c
index fb93d0a..ea6bd74 100644
--- a/src/openvpn/list.c
+++ b/src/openvpn/list.c
@@ -22,6 +22,12 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #if P2MP_SERVER
diff --git a/src/openvpn/lladdr.c b/src/openvpn/lladdr.c
index fc01b63..57f447b 100644
--- a/src/openvpn/lladdr.c
+++ b/src/openvpn/lladdr.c
@@ -2,6 +2,12 @@
  * Support routine for configuring link layer address 
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 #include "error.h"
 #include "misc.h"
diff --git a/src/openvpn/lzo.c b/src/openvpn/lzo.c
index 4becd4d..195b819 100644
--- a/src/openvpn/lzo.c
+++ b/src/openvpn/lzo.c
@@ -26,6 +26,12 @@
  * @file Data Channel Compression module function definitions.
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #ifdef ENABLE_LZO
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index e84a423..85c9aca 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -22,6 +22,12 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #ifdef ENABLE_MANAGEMENT
diff --git a/src/openvpn/mbuf.c b/src/openvpn/mbuf.c
index 0f36d3c..82f2388 100644
--- a/src/openvpn/mbuf.c
+++ b/src/openvpn/mbuf.c
@@ -22,6 +22,12 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #if P2MP
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 4891251..48a3b99 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -22,6 +22,12 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #include "buffer.h"
diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index 285b151..5b53571 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -22,6 +22,12 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #if P2MP_SERVER
diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
index 660b62c..8981bad 100644
--- a/src/openvpn/mss.c
+++ b/src/openvpn/mss.c
@@ -22,6 +22,12 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 #include "error.h"
 #include "mss.h"
diff --git a/src/openvpn/mstats.c b/src/openvpn/mstats.c
index 2f29d94..b4b864b 100644
--- a/src/openvpn/mstats.c
+++ b/src/openvpn/mstats.c
@@ -26,6 +26,12 @@
  * Maintain usage stats in a memory-mapped file
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #if defined(ENABLE_MEMSTATS)
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 662cb9a..dc15f09 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -22,6 +22,12 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #if P2MP_SERVER
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index 494f939..13f3f6c 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -22,6 +22,12 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #include "common.h"
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 7648ec6..3468dab 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -22,6 +22,12 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #if P2MP_SERVER
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 65a834b..e79c6f1 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -22,6 +22,12 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #if P2MP_SERVER
diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
index 217173f..3390bdd 100644
--- a/src/openvpn/ntlm.c
+++ b/src/openvpn/ntlm.c
@@ -21,6 +21,12 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #if NTLM
diff --git a/src/openvpn/occ.c b/src/openvpn/occ.c
index 2fdbff0..ff48706 100644
--- a/src/openvpn/occ.c
+++ b/src/openvpn/occ.c
@@ -22,6 +22,12 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #ifdef ENABLE_OCC
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index b2175a1..75c751d 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -22,6 +22,12 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #include "init.h"
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 52207b5..4c8f0c4 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -30,6 +30,12 @@
  *   (Christof Meerwald, http://cmeerw.org)
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #include "buffer.h"
diff --git a/src/openvpn/otime.c b/src/openvpn/otime.c
index b295646..173573c 100644
--- a/src/openvpn/otime.c
+++ b/src/openvpn/otime.c
@@ -22,6 +22,12 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #include "otime.h"
diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
index fceead9..186f074 100644
--- a/src/openvpn/packet_id.c
+++ b/src/openvpn/packet_id.c
@@ -31,6 +31,12 @@
  * to IPSec.
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #ifdef ENABLE_CRYPTO
diff --git a/src/openvpn/perf.c b/src/openvpn/perf.c
index d9dbafc..910d171 100644
--- a/src/openvpn/perf.c
+++ b/src/openvpn/perf.c
@@ -22,6 +22,12 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #include "perf.h"
diff --git a/src/openvpn/pf.c b/src/openvpn/pf.c
index 0ef839e..729792e 100644
--- a/src/openvpn/pf.c
+++ b/src/openvpn/pf.c
@@ -24,6 +24,12 @@
 
 /* packet filter functions */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #if defined(ENABLE_PF)
diff --git a/src/openvpn/ping.c b/src/openvpn/ping.c
index 191ad74..6dc0b4e 100644
--- a/src/openvpn/ping.c
+++ b/src/openvpn/ping.c
@@ -22,6 +22,12 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #include "ping.h"
diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index 7c0b90a..2189208 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -22,6 +22,12 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #if defined(ENABLE_PKCS11)
diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c
index 4a14b7c..18651fd 100644
--- a/src/openvpn/pkcs11_openssl.c
+++ b/src/openvpn/pkcs11_openssl.c
@@ -27,6 +27,12 @@
  * @file PKCS #11 OpenSSL backend
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #if defined(ENABLE_PKCS11) && defined(ENABLE_CRYPTO_OPENSSL)
diff --git a/src/openvpn/pkcs11_polarssl.c b/src/openvpn/pkcs11_polarssl.c
index 349c312..ecef4d3 100644
--- a/src/openvpn/pkcs11_polarssl.c
+++ b/src/openvpn/pkcs11_polarssl.c
@@ -27,6 +27,12 @@
  * @file PKCS #11 PolarSSL backend
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #if defined(ENABLE_PKCS11) && defined(ENABLE_CRYPTO_POLARSSL)
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index a975161..7ce2f5e 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -22,6 +22,12 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #ifdef ENABLE_PLUGIN
diff --git a/src/openvpn/pool.c b/src/openvpn/pool.c
index 60dc520..28c26b4 100644
--- a/src/openvpn/pool.c
+++ b/src/openvpn/pool.c
@@ -22,6 +22,12 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #include "pool.h"
diff --git a/src/openvpn/proto.c b/src/openvpn/proto.c
index 65a6b67..2cf8314 100644
--- a/src/openvpn/proto.c
+++ b/src/openvpn/proto.c
@@ -22,6 +22,12 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #include "proto.h"
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index 5e74af2..991e165 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -22,6 +22,12 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #include "common.h"
diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index 182925b..a4e50e8 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -22,6 +22,12 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #if PORT_SHARE
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 8a8779d..8d7d23a 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -22,6 +22,12 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #include "push.h"
diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
index 7c0bb54..763169e 100644
--- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -27,6 +27,12 @@
  * so that SSL/TLS can be run over UDP.
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index ca8f1da..bf7af63 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -26,6 +26,12 @@
  * Support routines for adding/deleting network routes.
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #include "common.h"
diff --git a/src/openvpn/schedule.c b/src/openvpn/schedule.c
index f0482ab..471330f 100644
--- a/src/openvpn/schedule.c
+++ b/src/openvpn/schedule.c
@@ -22,6 +22,12 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #if P2MP_SERVER
diff --git a/src/openvpn/session_id.c b/src/openvpn/session_id.c
index 7caf105..2e07b54 100644
--- a/src/openvpn/session_id.c
+++ b/src/openvpn/session_id.c
@@ -31,6 +31,12 @@
  * it is called the key_id and is currently 2 bits long.
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
diff --git a/src/openvpn/shaper.c b/src/openvpn/shaper.c
index 1a89fc2..6b445e2 100644
--- a/src/openvpn/shaper.c
+++ b/src/openvpn/shaper.c
@@ -22,6 +22,12 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 #include "shaper.h"
 #include "memdbg.h"
diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c
index 924a343..5b33652 100644
--- a/src/openvpn/sig.c
+++ b/src/openvpn/sig.c
@@ -22,6 +22,12 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #include "buffer.h"
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 5c9ef99..ed2b300 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -22,6 +22,12 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #include "socket.h"
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index 949d256..510c110 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -30,6 +30,12 @@
  *   (Pierre Bourdon <delroth@...277...>)
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #ifdef ENABLE_SOCKS
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index caafd18..251f8ed 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -39,6 +39,12 @@
  * over the same TCP/UDP port.
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 9a0c4d0..6a60cb5 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -27,6 +27,12 @@
  * @file Control Channel OpenSSL Backend
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #if defined(ENABLE_SSL) && defined(ENABLE_CRYPTO_OPENSSL)
diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index e5bd8ca..c01ff8a 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -27,6 +27,12 @@
  * @file Control Channel PolarSSL Backend
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #if defined(ENABLE_SSL) && defined(ENABLE_CRYPTO_POLARSSL)
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 0fa1137..51457f8 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -27,6 +27,12 @@
  * @file Control Channel Verification Module
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index e647c2a..1ccfc60 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -27,6 +27,12 @@
  * @file Control Channel Verification Module OpenSSL implementation
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #if defined(ENABLE_SSL) && defined(ENABLE_CRYPTO_OPENSSL)
diff --git a/src/openvpn/ssl_verify_polarssl.c b/src/openvpn/ssl_verify_polarssl.c
index 249e687..53e6006 100644
--- a/src/openvpn/ssl_verify_polarssl.c
+++ b/src/openvpn/ssl_verify_polarssl.c
@@ -27,6 +27,12 @@
  * @file Control Channel Verification Module PolarSSL backend
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #if defined(ENABLE_SSL) && defined(ENABLE_CRYPTO_POLARSSL)
diff --git a/src/openvpn/status.c b/src/openvpn/status.c
index 8fd89ef..0be5e4c 100644
--- a/src/openvpn/status.c
+++ b/src/openvpn/status.c
@@ -22,6 +22,12 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #include "status.h"
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index eb73504..793ddd2 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -25,15 +25,6 @@
 #ifndef SYSHEAD_H
 #define SYSHEAD_H
 
-/*
- * Only include if not during configure
- */
-#ifdef HAVE_CONFIG_H
-#include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
-#endif
-
 #include "compat.h"
 
 /* branch prediction hints */
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 9df7126..abc6a99 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -30,6 +30,12 @@
  * from VTun by Maxim Krasnyansky <max_mk@...109...>.
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #include "tun.h"
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index a2a007f..49f169a 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -26,6 +26,13 @@
  * Win32-specific OpenVPN code, targetted at the mingw
  * development environment.
  */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
 #include "syshead.h"
 
 #ifdef WIN32
-- 
1.7.3.4


