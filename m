From: Gert Doering <gert@...1296...>
Date: Tue,  5 Mar 2024 09:22:36 +0100
Message-ID: <20240305082236.17566-1-gert@...1296...>
In-Reply-To: <gerrit.1709567200000.I38e70cb74c10848ab2981efc4c4c8863c5c8785d@...2715...>
References: <gerrit.1709567200000.I38e70cb74c10848ab2981efc4c4c8863c5c8785d@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Fix typo --data-cipher-fallback
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

Change-Id: I38e70cb74c10848ab2981efc4c4c8863c5c8785d
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/534
This mail reflects revision 1 of this Change.
Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generic-options.rst
index 95e4ca2..30c990d 100644
--- a/doc/man-sections/generic-options.rst
+++ b/doc/man-sections/generic-options.rst
@@ -75,7 +75,7 @@
     to the configuration if no other compression options are present.
   - 2.4.x or lower: The cipher in ``--cipher`` is appended to
     ``--data-ciphers``.
-  - 2.3.x or lower: ``--data-cipher-fallback`` is automatically added with
+  - 2.3.x or lower: ``--data-ciphers-fallback`` is automatically added with
     the same cipher as ``--cipher``.
   - 2.3.6 or lower: ``--tls-version-min 1.0`` is added to the configuration
     when ``--tls-version-min`` is not explicitly set.
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index cd3e0ad..14430d3 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -400,7 +400,7 @@
     if (o->enable_ncp_fallback
         && !tls_item_in_cipher_list(o->ciphername, dco_get_supported_ciphers()))
     {
-        msg(msglevel, "Note: --data-cipher-fallback with cipher '%s' "
+        msg(msglevel, "Note: --data-ciphers-fallback with cipher '%s' "
             "disables data channel offload.", o->ciphername);
         return false;
     }

