From: Gert Doering <gert@...1296...>
Date: Mon, 15 Dec 2025 15:46:50 +0100
Message-ID: <20251215144656.17299-1-gert@...1296...>
In-Reply-To: <gerrit.1765547061000.Idd79f7cbd38e8b0831f15866339c3677a367cd49@...2715...>
References: <gerrit.1765547061000.Idd79f7cbd38e8b0831f15866339c3677a367cd49@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] schedule: Rework documentation for
 schedule_add_entry
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

The previous documentation was very misleading and made
it hard to understand how the sigma parameter is used.

Rewrite it so that it better reflects the actual
implementation.

Change-Id: Idd79f7cbd38e8b0831f15866339c3677a367cd49
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1439
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1439
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/schedule.h b/src/openvpn/schedule.h
index 79311c5..3e2a2ad 100644
--- a/src/openvpn/schedule.h
+++ b/src/openvpn/schedule.h
@@ -81,17 +81,26 @@
 
 /* Public inline functions */
 
-/*
- * Add a struct schedule_entry (whose storage is managed by
- * caller) to the btree.  tv signifies the wakeup time for
- * a future event.  sigma is a time interval measured
- * in microseconds -- the event window being represented
- * starts at (tv - sigma) and ends at (tv + sigma).
- * Event signaling can occur anywere within this interval.
- * Making the interval larger makes the scheduler more efficient,
- * while making it smaller results in more precise scheduling.
- * The caller should treat the passed struct schedule_entry as
- * an opaque object.
+/**
+ * Add a struct schedule_entry to the scheduler btree or
+ * update an existing entry with a new wakeup time.
+ *
+ * @p sigma is only used when the entry is already present
+ * in the schedule. If the originally scheduled time and the new
+ * time are within @p sigma microseconds of each other then the
+ * entry is not rescheduled and will occur at the original time.
+ * When adding a new entry @p sigma will be ignored.
+ *
+ * @param s     scheduler tree
+ * @param e     entry to add to the schedule
+ * @param tv    wakeup time for the entry
+ * @param sigma window size for the event in microseconds
+ *
+ * @note The caller should treat @p e as opaque data. Only
+ * the scheduler functions should change the object. The
+ * caller is expected to manage the memory for the object
+ * and must only free it once it has been removed from the
+ * schedule.
  */
 static inline void
 schedule_add_entry(struct schedule *s, struct schedule_entry *e, const struct timeval *tv,

