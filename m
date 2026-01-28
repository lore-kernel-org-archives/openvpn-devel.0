From: Gert Doering <gert@...1296...>
Date: Wed, 28 Jan 2026 12:04:37 +0100
Message-ID: <20260128110443.24410-1-gert@...1296...>
In-Reply-To: <gerrit.1769556650000.Id530d890ba01cffb74d3dc04ad10b153f7bea1d4@...2715...>
References: <gerrit.1769556650000.Id530d890ba01cffb74d3dc04ad10b153f7bea1d4@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Prevent NULL pointer dereference with
 --dns-updown
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

From: Heiko Hund <heiko@...2662...>

If the dns-updown option appears in the config twice, there is a chance
of a NULL pointer dereference when comparing the script path to the
default script path. This happens when a custom script is set, after the
dns-updown script was disabled first. In that case the script path is
NULL, which leads to the deref during a strcmp(3).

Reported-by: <aarnav@...2953...>
Change-Id: Id530d890ba01cffb74d3dc04ad10b153f7bea1d4
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1498
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1498
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 85669e0..2bca647 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -7890,7 +7890,7 @@
         }
         else
         {
-            if (streq(dns->updown, DEFAULT_DNS_UPDOWN))
+            if (dns->updown && streq(dns->updown, DEFAULT_DNS_UPDOWN))
             {
                 /* Unset the default command to prevent warnings */
                 dns->updown = NULL;

