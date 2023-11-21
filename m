From: Frank Lichtenheld <frank@...2641...>
Date: Tue, 21 Nov 2023 11:40:37 +0100
Message-Id: <20231121104037.15307-1-frank@...2641...>
In-Reply-To: <gerrit.1700480231000.I1141eb7740d8900ed4af0ff5ff52aa3659df99aa@...2715...>
References: <gerrit.1700480231000.I1141eb7740d8900ed4af0ff5ff52aa3659df99aa@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Remove unused function prototype
 crypto_adjust_frame_parameters
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

Change-Id: I1141eb7740d8900ed4af0ff5ff52aa3659df99aa
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/451
This mail reflects revision 1 of this Change.
Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index c5fd253..9255d38 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -429,12 +429,6 @@
                          struct gc_arena *gc);
 
 
-/** Calculate crypto overhead and adjust frame to account for that */
-void crypto_adjust_frame_parameters(struct frame *frame,
-                                    const struct key_type *kt,
-                                    bool packet_id,
-                                    bool packet_id_long_form);
-
 /** Calculate the maximum overhead that our encryption has
  * on a packet. This does not include needed additional buffer size
  *

