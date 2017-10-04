From: Jeremie Courreges-Anglas <jca@...2272...>
Date: Thu, 05 Oct 2017 01:47:17 +0200
Message-ID: <87fuaymq62.fsf@...2274...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Subject: [Openvpn-devel] [patch] Fix time_t printing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--=-=-=
Content-Type: text/plain


When building openvpn-2.4.4 on OpenBSD, I noticed the following warning:

--8<--
cc -DHAVE_CONFIG_H -I. -I/usr/ports/pobj/openvpn-2.4.4/openvpn-2.4.4/src/openvpn -I../.. -I../../include  -I/usr/ports/pobj/openvpn-2.4.4/openvpn-2.4.4/include  -I/usr/ports/pobj/openvpn-2.4.4/openvpn-2.4.4/src/compat  -I/usr/local/include     -I/usr/local/include    -DPLUGIN_LIBDIR=\"/usr/local/lib/openvpn/plugins\"  -O2 -pipe -std=c99 -MT error.o -MD -MP -MF .deps/error.Tpo -c -o error.o /usr/ports/pobj/openvpn-2.4.4/openvpn-2.4.4/src/openvpn/error.c
/usr/ports/pobj/openvpn-2.4.4/openvpn-2.4.4/src/openvpn/error.c:346:25: warning: format specifies type 'unsigned long' but the argument has type 'time_t' (aka 'long long') [-Wformat]
                        tv.tv_sec,
                        ^~~~~~~~~
1 warning generated.
mv -f .deps/error.Tpo .deps/error.Po
-->8--

OpenBSD uses long long for time_t on all architectures, 32 or 64 bits,
in order to cope with dates beyond 2038.  This is also the case on
NetBSD and Linux x32.

The warning is not innocuous, as a mismatch between the format and the
type of parameters passed to variadic functions can result in nasty
problems (crashes, etc).  For example, the code below crashes on
OpenBSD/arm (32 bits long).

--8<--
#include <stdio.h>
#include <time.h>

int
main(void)
{
        time_t t;

        time(&t);
        printf("%ld %s\n", t, "foobar");
        return 0;
}
-->8--

The diff below fixes the potential issue and the warning.  The method
used is a cast to (long long), a method successfully used since OpenBSD
switched to a 64 bits time_t.  More data at

  https://www.openbsd.org/papers/eurobsdcon_2013_time_t/mgp00029.html

openvpn already uses long long in a few places.  Note that I did not
audit the whole openvpn tree for other possible time_t problems, but
I can't spot similar warnings in the build logs.


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment;
 filename=0001-Cast-time_t-to-long-double-in-order-to-print-it.patch

From d620431f661375d3564b60f110d1f69575ac78d7 Mon Sep 17 00:00:00 2001
From: Jeremie Courreges-Anglas <jca@...2272...>
Date: Thu, 5 Oct 2017 01:43:33 +0200
Subject: [PATCH] Cast time_t to long double in order to print it.

The underlying type of time_t can be anything from unsigned 32 bits to
signed 64 bits to float.  To reliably print it, better cast it to "long
long", which is at least 64 bits wide and can represent values beyond
2038.

Printing as a "long" could cause problems on ILP32 systems using a 64
bits time_t (eg OpenBSD/armv7).

Signed-off-by: Jeremie Courreges-Anglas <jca@...2272...>
---
 src/openvpn/error.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index 04bf0da5..7b46c5ec 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -342,8 +342,8 @@ x_msg_va(const unsigned int flags, const char *format, va_list arglist)
                 struct timeval tv;
                 gettimeofday(&tv, NULL);
 
-                fprintf(fp, "%lu.%06lu %x %s%s%s%s",
-                        tv.tv_sec,
+                fprintf(fp, "%lld.%06lu %x %s%s%s%s",
+                        (long long)tv.tv_sec,
                         (unsigned long)tv.tv_usec,
                         flags,
                         prefix,
-- 
2.14.2


--=-=-=
Content-Type: text/plain


-- 
jca | PGP : 0x1524E7EE / 5135 92C1 AD36 5293 2BDF  DDCC 0DFA 74AE 1524 E7EE

--=-=-=--

