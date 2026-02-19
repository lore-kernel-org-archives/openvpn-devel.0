From: Gert Doering <gert@...1296...>
Date: Thu, 19 Feb 2026 12:09:48 +0100
Message-ID: <20260219110954.21471-1-gert@...1296...>
In-Reply-To: <gerrit.1771437772000.I560f45fb0011180be8ca2b0e7fbc63030fa10f35@...2715...>
References: <gerrit.1771437772000.I560f45fb0011180be8ca2b0e7fbc63030fa10f35@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] DCO Linux: Fix setting DCO ifmode
 failing on big endian archs
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

The problem is that SITNL_ADDATTR is not forcing type safety and on
big endian architcutre passing a smaller size than the underlying
integer type of data causes only the more significant byte(s) to be passed
instead.

A proper fix would be to add specific methods for common integer types like
SITNL_ADDATTR_u8, SITNL_ADDATTR_u16, SITNL_ADDATTR_u32 like netlink library
does with NLA_PUT_U32, NLA_PUT_U16, NLA_PUT_U8.

Change-Id: I560f45fb0011180be8ca2b0e7fbc63030fa10f35
Github: closes OpenVPN/ovpn-dco#96
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Antonio Quartulli <antonio@...2726...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1547
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1547
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Antonio Quartulli <antonio@...2726...>

        
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index a5b2905..ad7edef 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -1337,7 +1337,15 @@
     {
         dco_context_t *dco = arg;
         struct rtattr *data = SITNL_NEST(&req.n, sizeof(req), IFLA_INFO_DATA);
-        SITNL_ADDATTR(&req.n, sizeof(req), IFLA_OVPN_MODE, &dco->ifmode, sizeof(uint8_t));
+
+        /* the netlink format is uint8_t for this and using something
+         * other than uint8_t here (enum underlying type is undefined but
+         * commonly int) causes the values to be 0 when passed
+         * on big endian arch as we only take the (biggest endian) byte
+         * directly at the address
+         */
+        uint8_t ifmode = (uint8_t)dco->ifmode;
+        SITNL_ADDATTR(&req.n, sizeof(req), IFLA_OVPN_MODE, &ifmode, sizeof(uint8_t));
         SITNL_NEST_END(&req.n, data);
     }
 #endif

