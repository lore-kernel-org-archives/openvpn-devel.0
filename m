From: Gert Doering <gert@...1296...>
Date: Fri, 22 Aug 2025 22:52:16 +0200
Message-ID: <20250822205223.3492-1-gert@...1296...>
In-Reply-To: <gerrit.1755870317000.Ibec7ffb9085503f72e79514776042bc310384f13@...2715...>
References: <gerrit.1755870317000.Ibec7ffb9085503f72e79514776042bc310384f13@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] options: Fix --hash-size virtual argument
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

Previously we ignored the second argument to --hash-size.
This bug is older than the openvpn git repository, but
clearly this is not an option often used (or at all).

Change-Id: Ibec7ffb9085503f72e79514776042bc310384f13
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1149
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 5f9971c..e9584a8 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -7951,7 +7951,7 @@
             goto err;
         }
         options->real_hash_size = real;
-        options->virtual_hash_size = real;
+        options->virtual_hash_size = virtual;
     }
     else if (streq(p[0], "connect-freq") && p[1] && p[2] && !p[3])
     {

