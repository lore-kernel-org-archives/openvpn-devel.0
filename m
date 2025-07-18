From: Gert Doering <gert@...1296...>
Date: Fri, 18 Jul 2025 21:16:56 +0200
Message-ID: <20250718191702.9451-1-gert@...1296...>
In-Reply-To: <gerrit.1752849659000.I217cfb319b85fd75a88f7d4d50c374d28771df28@...2715...>
References: <gerrit.1752849659000.I217cfb319b85fd75a88f7d4d50c374d28771df28@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] improve float collision logging
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

From: Ralf Lici <ralf@...2726...>

Extend the log message printed when an instance floats to an address
already taken by another instance with the same certificate. The updated
message now includes the instance being closed, the reason it's being
closed, and the new instance taking over that address.

Change-Id: I217cfb319b85fd75a88f7d4d50c374d28771df28
Signed-off-by: Ralf Lici <ralf@...2726...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1091
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index ead3dd0..4696686 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3263,7 +3263,11 @@
                 mroute_addr_print(&mi->real, &gc));
             goto done;
         }
-        msg(D_MULTI_MEDIUM, "closing instance %s", multi_instance_string(ex_mi, false, &gc));
+
+        msg(D_MULTI_LOW, "closing instance %s due to float collision with %s "
+            "using the same certificate",
+            multi_instance_string(ex_mi, false, &gc),
+            multi_instance_string(mi, false, &gc));
         multi_close_instance(m, ex_mi, false);
     }
 

