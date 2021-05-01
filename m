From: Antonio Quartulli <a@...2181...>
Date: Sat,  1 May 2021 15:06:38 +0200
Message-Id: <20210501130640.9330-2-a@...2181...>
In-Reply-To: <20210501130640.9330-1-a@...2181...>
References: <20210501130640.9330-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/3] windows: use appropriate and portable
 format specifier for 64bit pointer
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
Cc: Antonio Quartulli <antonio@...515...>, Antonio Quartulli <a@...2181...>

From: Antonio Quartulli <antonio@...515...>

To print a 64bit poiner, fprintf() must be provided with the appropriate
format specifier.

The most portable in this case is PRIx64, which is redefined accordingly
on each platform. It comes from inttypes.h and it's the recommended way
to print a 64bit long hex value.

Fixes various warnings of this type:

event.c: In function ‘we_ctl’:
event.c:235:24: warning: 'I' flag used with ‘%x’ gnu_printf format [-Wformat=]
  235 |     dmsg(D_EVENT_WAIT, "WE_CTL n=%d ev=%p rwflags=0x%04x arg=" ptr_format,
      |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
error.h:151:68: note: in definition of macro ‘dmsg’
  151 | #define dmsg(flags, ...) do { if (msg_test(flags)) {x_msg((flags), __VA_ARGS__);} EXIT_FATAL(flags); } while (false)
      |                                                                    ^~~~~~~~~~~
event.c:235:24: warning: format ‘%x’ expects argument of type ‘unsigned int’, but argument 6 has type ‘long long unsigned int’ [-Wformat=]
  235 |     dmsg(D_EVENT_WAIT, "WE_CTL n=%d ev=%p rwflags=0x%04x arg=" ptr_format,
      |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
......
  239 |          (ptr_type)arg);
      |          ~~~~~~~~~~~~~
      |          |
      |          long long unsigned int

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/common.h b/src/openvpn/common.h
index 544fa238..6575bcb7 100644
--- a/src/openvpn/common.h
+++ b/src/openvpn/common.h
@@ -44,7 +44,7 @@ typedef int interval_t;
  * Printf formats for special types
  */
 #ifdef _WIN64
-#define ptr_format              "0x%I64x"
+#define ptr_format              "0x%016" PRIx64
 #else
 #define ptr_format              "0x%08lx"
 #endif
-- 
2.26.3


