From: Gert Doering <gert@...1296...>
Date: Sun,  9 Nov 2025 09:42:31 +0100
Message-ID: <20251109084238.11581-1-gert@...1296...>
In-Reply-To: <gerrit.1762430608000.I48c877843d24144450af1282b7524bb3ba18232e@...2715...>
References: <gerrit.1762430608000.I48c877843d24144450af1282b7524bb3ba18232e@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] FreeBSD DCO: repair --inactive
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

--inactive on DCO requires a working DCO counters query function
(dco_get_peer_stats(), implemented in the previous commit) and
that the DCO implementation in use fills the "tun_{read,write}_bytes"
fields for the peer context.

FreeBSD DCO only fills the "dco_{read,write}_bytes" counters - which is
something we can't fix in OpenVPN, this needs kernel enhancements.

So, to make the feature (mostly) work, check the other set of counters
on FreeBSD.  Caveat: this will count encryption overhead and keepalives,
so it will still not work for `--inactive <n>` without a byte count, or
for byte counts with too tight thresholds.

Adding the #ifdef to forward.c was considered the least bad alternative.

v2: fix rst syntax for manpage addition

Github: OpenVPN/openvpn#898

Change-Id: I48c877843d24144450af1282b7524bb3ba18232e
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Ralf Lici <ralf@...2726...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1351
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1351
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Ralf Lici <ralf@...2726...>

        
diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-options.rst
index 0aee9e2..e8523d9 100644
--- a/doc/man-sections/client-options.rst
+++ b/doc/man-sections/client-options.rst
@@ -274,6 +274,11 @@
   counted as traffic, as they are used internally by OpenVPN and are not
   an indication of actual user activity.
 
+  NOTE: on FreeBSD with DCO, due to platform limits, the previous paragraph
+  is not correct.  In that case, encapsulation overhead and keepalives are
+  counted, so using this feature needs a sufficiently-high ``bytes`` value to
+  take these extra numbers into account.
+
 --proto-force p
   When iterating through connection profiles, only consider profiles using
   protocol ``p`` (:code:`tcp` \| :code:`udp`).
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 5bbac13..c355f66 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -476,13 +476,20 @@
  * and the logic needs to change - we permit the event to trigger and check
  * kernel DCO counters here, returning and rearming the timer if there was
  * sufficient traffic.
+ *
+ * NOTE: FreeBSD DCO does not supply "tun bytes" (= decrypted payload) today,
+ * so "dco bytes" (encrypted bytes, including keepalives) is used instead
  */
 static void
 check_inactivity_timeout(struct context *c)
 {
     if (dco_enabled(&c->options) && dco_get_peer_stats(c, true) == 0)
     {
+#ifdef TARGET_FREEBSD
+        int64_t tot_bytes = c->c2.dco_read_bytes + c->c2.dco_write_bytes;
+#else
         int64_t tot_bytes = c->c2.tun_read_bytes + c->c2.tun_write_bytes;
+#endif
         int64_t new_bytes = tot_bytes - c->c2.inactivity_bytes;
 
         if (new_bytes > c->options.inactivity_minimum_bytes)

