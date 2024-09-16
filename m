From: Gert Doering <gert@...1296...>
Date: Mon, 16 Sep 2024 15:28:53 +0200
Message-ID: <20240916132853.29405-1-gert@...1296...>
In-Reply-To: <gerrit.1726491830000.Ie2797a82ad769cb640440d1ba7dfeb416e7b932d@...2715...>
References: <gerrit.1726491830000.Ie2797a82ad769cb640440d1ba7dfeb416e7b932d@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Move cipher/data-ciphers warning to
 D_LOW (verb 4)
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

From: Arne Schwabe <arne@...1227...>

These warnings served a purpose in OpenVPN 2.6.x to warn people
about the changed behaviour. But for 2.7 this is will be more
log spam than a helpful message. So only show this warning on a
high verbosity level.

Change-Id: Ie2797a82ad769cb640440d1ba7dfeb416e7b932d
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/746
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 61f6285..6009e5f 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3546,7 +3546,7 @@
          * parts of OpenVPN assert that the ciphername is set */
         o->ciphername = "BF-CBC";
 
-        msg(M_INFO, "Note: --cipher is not set. OpenVPN versions before 2.5 "
+        msg(D_LOW, "Note: --cipher is not set. OpenVPN versions before 2.5 "
             "defaulted to BF-CBC as fallback when cipher negotiation "
             "failed in this case. If you need this fallback please add "
             "'--data-ciphers-fallback BF-CBC' to your configuration "
@@ -3555,7 +3555,7 @@
     else if (!o->enable_ncp_fallback
              && !tls_item_in_cipher_list(o->ciphername, o->ncp_ciphers))
     {
-        msg(M_WARN, "DEPRECATED OPTION: --cipher set to '%s' but missing in "
+        msg(D_LOW, "DEPRECATED OPTION: --cipher set to '%s' but missing in "
             "--data-ciphers (%s). OpenVPN ignores --cipher for cipher "
             "negotiations. ",
             o->ciphername, o->ncp_ciphers);

