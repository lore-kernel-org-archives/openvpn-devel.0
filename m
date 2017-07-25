From: Steffan Karger <steffan@...1856...>
Date: Tue, 25 Jul 2017 23:02:34 +0200
Message-Id: <20170725210234.5673-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Move create_temp_file() out of #ifdef
 ENABLE_CRYPTO
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

From: Steffan Karger <steffan.karger@...1435...>

By using get_random() instead of prng_bytes(), we no longer have to place
create_temp_file() inside #ifdef ENABLE_CRYPTO.

The resulting filename now has 62 bits of entropy (2 * [0-INT_MAX])
instead of the previous 128 bits, but that should be plenty.  Assuming an
int is 32 bits, we would need about 2**31 (2147483648) files to have a
(roughly) 0.5 chance of failing in one of the 6 attempts we do.

(This is preparing to move the function out of misc.c, where I'd prefer to
not have to add a #include "crypto.h".)

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/misc.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 4f729911..1537a2e4 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -831,8 +831,6 @@ test_file(const char *filename)
     return ret;
 }
 
-#ifdef ENABLE_CRYPTO
-
 /* create a temporary filename in directory */
 const char *
 create_temp_file(const char *directory, const char *prefix, struct gc_arena *gc)
@@ -845,15 +843,11 @@ create_temp_file(const char *directory, const char *prefix, struct gc_arena *gc)
 
     do
     {
-        uint8_t rndbytes[16];
-        const char *rndstr;
-
         ++attempts;
         ++counter;
 
-        prng_bytes(rndbytes, sizeof rndbytes);
-        rndstr = format_hex_ex(rndbytes, sizeof rndbytes, 40, 0, NULL, gc);
-        buf_printf(&fname, PACKAGE "_%s_%s.tmp", prefix, rndstr);
+        buf_printf(&fname, PACKAGE "_%s_%08lx%08lx.tmp", prefix,
+                   (unsigned long) get_random(), (unsigned long) get_random());
 
         retfname = gen_path(directory, BSTR(&fname), gc);
         if (!retfname)
@@ -884,6 +878,8 @@ create_temp_file(const char *directory, const char *prefix, struct gc_arena *gc)
     return NULL;
 }
 
+#ifdef ENABLE_CRYPTO
+
 /*
  * Prepend a random string to hostname to prevent DNS caching.
  * For example, foo.bar.gov would be modified to <random-chars>.foo.bar.gov.
-- 
2.11.0


