From: Gert Doering <gert@...1296...>
Date: Sun, 17 Nov 2013 15:30:20 +0100
Message-Id: <1384698620-27946-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Make code and documentation for
	--remote-random-hostname consistent.
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

Documentation examples, description and code were disagreeing on what
this option actually does.  Now they will all agree that it will
*prepend* a random-byte string to the hostname name before resolving
to work around DNS caching (needs a "*" wildcard record in the zone).

Fix trac #143

Signed-off-by: Gert Doering <gert@...1296...>
---
 doc/openvpn.8      |  2 +-
 src/openvpn/misc.c | 27 +++++++++------------------
 2 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index b53d383..3e2e1a4 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -271,7 +271,7 @@ failover capability.
 .\"*********************************************************
 .TP
 .B \-\-remote-random-hostname
-Add a random string (6 characters) to first DNS label of hostname to prevent
+Prepend a random string (6 bytes, 12 hex characters) to hostname to prevent
 DNS caching.  For example, "foo.bar.gov" would be modified to
 "<random-chars>.foo.bar.gov".
 .\"*********************************************************
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 4688444..7483184 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -926,32 +926,23 @@ create_temp_file (const char *directory, const char *prefix, struct gc_arena *gc
 }
 
 /*
- * Add a random string to first DNS label of hostname to prevent DNS caching.
+ * Prepend a random string to hostname to prevent DNS caching.
  * For example, foo.bar.gov would be modified to <random-chars>.foo.bar.gov.
- * Of course, this requires explicit support in the DNS server.
+ * Of course, this requires explicit support in the DNS server (wildcard).
  */
 const char *
 hostname_randomize(const char *hostname, struct gc_arena *gc)
 {
 # define n_rnd_bytes 6
 
-  char *hst = string_alloc(hostname, gc);
-  char *dot = strchr(hst, '.');
+  uint8_t rnd_bytes[n_rnd_bytes];
+  const char *rnd_str;
+  struct buffer hname = alloc_buf_gc (strlen(hostname)+sizeof(rnd_bytes)*2+4, gc);
 
-  if (dot)
-    {
-      uint8_t rnd_bytes[n_rnd_bytes];
-      const char *rnd_str;
-      struct buffer hname = alloc_buf_gc (strlen(hostname)+sizeof(rnd_bytes)*2+4, gc);
-
-      *dot++ = '\0';
-      prng_bytes (rnd_bytes, sizeof (rnd_bytes));
-      rnd_str = format_hex_ex (rnd_bytes, sizeof (rnd_bytes), 40, 0, NULL, gc);
-      buf_printf(&hname, "%s-0x%s.%s", hst, rnd_str, dot);
-      return BSTR(&hname);
-    }
-  else
-    return hostname;
+  prng_bytes (rnd_bytes, sizeof (rnd_bytes));
+  rnd_str = format_hex_ex (rnd_bytes, sizeof (rnd_bytes), 40, 0, NULL, gc);
+  buf_printf(&hname, "%s.%s", rnd_str, hostname);
+  return BSTR(&hname);
 # undef n_rnd_bytes
 }
 
-- 
1.8.1.5


