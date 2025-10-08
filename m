From: Gert Doering <gert@...1296...>
Date: Wed,  8 Oct 2025 12:55:01 +0200
Message-ID: <20251008105507.9997-1-gert@...1296...>
In-Reply-To: <gerrit.1757607620000.I73c46ac630834a8cf8894aaa2dcc429fbedd3db7@...2715...>
References: <gerrit.1757607620000.I73c46ac630834a8cf8894aaa2dcc429fbedd3db7@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v11] vlan: Remove -Wconversion override
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

Only Debian 11 (GCC 10) complains about this.
We decided not to add work-arounds for GCC 10
and older and instead accept that they do not
build -Werror clean.

Change-Id: I73c46ac630834a8cf8894aaa2dcc429fbedd3db7
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1179
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1179
This mail reflects revision 11 of this Change.

Acked-by according to Gerrit (reflected above):

        
diff --git a/src/openvpn/vlan.c b/src/openvpn/vlan.c
index 3da470a..a6a6e93 100644
--- a/src/openvpn/vlan.c
+++ b/src/openvpn/vlan.c
@@ -43,11 +43,6 @@
     return ntohs(hdr->pcp_cfi_vid & OPENVPN_8021Q_MASK_VID);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /*
  * Set the VLAN Identifier (VID) in an IEEE 802.1Q header.
  *
@@ -61,10 +56,6 @@
         (hdr->pcp_cfi_vid & ~OPENVPN_8021Q_MASK_VID) | (htons(vid) & OPENVPN_8021Q_MASK_VID);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /*
  * vlan_decapsulate - remove 802.1q header and return VID
  *

