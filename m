From: Gert Doering <gert@...1296...>
Date: Mon,  9 Jun 2025 12:02:10 +0200
Message-ID: <20250609100216.3997-1-gert@...1296...>
In-Reply-To: <gerrit.1749212899000.I4457b1d7262e0a39c275d33aaef6c4bcbeae6ab3@...2715...>
References: <gerrit.1749212899000.I4457b1d7262e0a39c275d33aaef6c4bcbeae6ab3@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] dco_linux: enable extended netlink error
 reporting
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

From: Antonio Quartulli <antonio@...2726...>

The ovpn netlink code reports more verbose error
strings to help userspace understand what went wrong,
rather than just returning, for example, -EINVAL.

However, userspace must instruct the kernel netlink
subsystem that it wants to receive such strings.

code for parsing such strings has always been present
but it was never used.

Set the socket option which enables such reporting.

Change-Id: I4457b1d7262e0a39c275d33aaef6c4bcbeae6ab3
Signed-off-by: Antonio Quartulli <antonio@...2726...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1040
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 49dbdad..0345413 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -367,19 +367,19 @@
     {
         len = strnlen((char *)nla_data(tb_msg[NLMSGERR_ATTR_MSG]),
                       nla_len(tb_msg[NLMSGERR_ATTR_MSG]));
-        msg(M_WARN, "kernel error: %*s\n", len,
+        msg(M_WARN, "kernel error: %*s", len,
             (char *)nla_data(tb_msg[NLMSGERR_ATTR_MSG]));
     }
 
     if (tb_msg[OVPN_NLMSGERR_ATTR_MISS_NEST])
     {
-        msg(M_WARN, "kernel error: missing required nesting type %u\n",
+        msg(M_WARN, "kernel error: missing required nesting type %u",
             nla_get_u32(tb_msg[OVPN_NLMSGERR_ATTR_MISS_NEST]));
     }
 
     if (tb_msg[OVPN_NLMSGERR_ATTR_MISS_TYPE])
     {
-        msg(M_WARN, "kernel error: missing required attribute type %u\n",
+        msg(M_WARN, "kernel error: missing required attribute type %u",
             nla_get_u32(tb_msg[OVPN_NLMSGERR_ATTR_MISS_TYPE]));
     }
 
@@ -405,6 +405,11 @@
             nl_geterror(ret));
     }
 
+    /* enable Extended ACK for detailed error reporting */
+    ret = 1;
+    setsockopt(nl_socket_get_fd(dco->nl_sock), SOL_NETLINK, NETLINK_EXT_ACK,
+               &ret, sizeof(ret));
+
     /* set close on exec and non-block on the netlink socket */
     set_cloexec(nl_socket_get_fd(dco->nl_sock));
     set_nonblock(nl_socket_get_fd(dco->nl_sock));

