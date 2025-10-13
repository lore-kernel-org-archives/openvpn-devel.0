From: Gert Doering <gert@...1296...>
Date: Mon, 13 Oct 2025 18:23:08 +0200
Message-ID: <20251013162313.2276-1-gert@...1296...>
In-Reply-To: <gerrit.1760359115000.I5e6cb3a287a2e8e1584036307b4c21bb68050c6a@...2715...>
References: <gerrit.1760359115000.I5e6cb3a287a2e8e1584036307b4c21bb68050c6a@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] schedule: Fix conversion warning
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

Return value of random() is safe to cast.

Change-Id: I5e6cb3a287a2e8e1584036307b4c21bb68050c6a
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1270
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1270
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/schedule.c b/src/openvpn/schedule.c
index 1389889..bf6693f 100644
--- a/src/openvpn/schedule.c
+++ b/src/openvpn/schedule.c
@@ -65,25 +65,16 @@
 }
 #endif
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static inline void
 schedule_set_pri(struct schedule_entry *e)
 {
-    e->pri = random();
+    e->pri = (unsigned int)random();
     if (e->pri < 1)
     {
         e->pri = 1;
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /* This is the master key comparison routine.  A key is
  * simply a struct timeval containing the absolute time for
  * an event.  The unique treap priority (pri) is used to ensure

