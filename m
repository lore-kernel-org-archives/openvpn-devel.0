From: Gert Doering <gert@...1296...>
Date: Sun, 16 Nov 2025 19:36:15 +0100
Message-ID: <20251116183622.11727-1-gert@...1296...>
In-Reply-To: <gerrit.1761324750000.I6bc3147d10ca50291110335cd9fc3be961280c1b@...2715...>
References: <gerrit.1761324750000.I6bc3147d10ca50291110335cd9fc3be961280c1b@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] ssl: Change update argument of
 compute_earliest_wakeup to time_t
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

From: Frank Lichtenheld <frank@...2641...>

Since we usually input a diff of two time_t values here
the input value will be officially time_t. So avoid
conversion warnings at almost every caller site.

We can safely cast it to interval_t here because we
checked that it is smaller than the interval_t value
earliest. And all negative values are treated equal,
so exact value doesn't matter.

Change-Id: I6bc3147d10ca50291110335cd9fc3be961280c1b
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1299
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1299
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 7b93ebc..355ab46 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1107,11 +1107,11 @@
  * called again.
  */
 static inline void
-compute_earliest_wakeup(interval_t *earliest, interval_t seconds_from_now)
+compute_earliest_wakeup(interval_t *earliest, time_t seconds_from_now)
 {
     if (seconds_from_now < *earliest)
     {
-        *earliest = seconds_from_now;
+        *earliest = (interval_t)seconds_from_now;
     }
     if (*earliest < 0)
     {
@@ -1119,11 +1119,6 @@
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /*
  * Return true if "lame duck" or retiring key has expired and can
  * no longer be used.
@@ -1338,7 +1333,7 @@
     /* For now we hardcode this to be 16 for the software based data channel
      * DCO based implementations/HW implementation might adjust this number
      * based on their expected speed */
-    const int future_key_count = 16;
+    const uint8_t future_key_count = 16;
 
     int key_direction = server ? KEY_DIRECTION_INVERSE : KEY_DIRECTION_NORMAL;
     struct key_direction_state kds;
@@ -1785,6 +1780,11 @@
     return true;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 static bool
 write_string(struct buffer *buf, const char *str, const int maxlen)
 {

