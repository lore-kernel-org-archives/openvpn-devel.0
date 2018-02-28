From: Steffan Karger <steffan@...1856...>
Date: Thu,  1 Mar 2018 00:11:23 +0100
Message-Id: <20180228231123.27782-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Add a warning that we do not officially
 support LibreSSL
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

As discussed in the community meeting of 13-12-2017, we should warn our
users that LibreSSL is not officially supported.  We expect that it
currently works, but it might suddenly break or we might decide to no
longer build against LibreSSL in the future.

There seem to be ongoing efforts to make LibreSSL compatible with the
OpenSSL 1.1 API.  If they truly do that, it might also keep working.

For now, make sure people understand we do not really support LibreSSL.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/options.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 41a42cf2..36d67b0f 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2949,6 +2949,11 @@ options_postprocess_mutate_invariant(struct options *options)
 static void
 options_postprocess_verify(const struct options *o)
 {
+#ifdef LIBRESSL_VERSION_NUMBER
+    msg(M_WARN, "WARNING: This OpenVPN was built against LibreSSL. "
+        "This might work, but is *not* supported and can break at any time.")
+#endif
+
     if (o->connection_list)
     {
         int i;
-- 
2.14.1


