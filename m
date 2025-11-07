From: Gert Doering <gert@...1296...>
Date: Fri,  7 Nov 2025 15:13:27 +0100
Message-ID: <20251107141333.12056-1-gert@...1296...>
In-Reply-To: <gerrit.1762447154000.I991d6053776efed771bc1a3880acb80b55959cbc@...2715...>
References: <gerrit.1762447154000.I991d6053776efed771bc1a3880acb80b55959cbc@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] FreeBSD DCO: repair incoming "delete
 peer" notifications in p2p client mode
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

commit 4a48841da2 introduced a workaround for spurious DCO notifications
"with no useful content" on Linux - namely, ignoring dco_message_type==0
in forward.c, process_incoming_dco(), "because Linux has no message
type 0 anyway".

Each DCO platform uses its own enum for these notification messages
*inside* OpenVPN (which might not have the best design decision ever),
and FreeBSD had OVPN_CMD_DEL_PEER in the enum on "position 0"...

Fix by changing the enum to start with 1.  Tested with DEL_PEER in p2p
client and DEL_PEER & FLOAT in p2mp server mode.

v2:
  introduce OVPN_CMD_NO_MESSAGE in position 0, and a comment explaining why.
  A future commit can then clean up forward.c and dco_linux.c to use the
  constant, and not "magic 0 which happens to be in there after CLEAR()".

Github: fixes OpenVPN/openvpn#881

Change-Id: I991d6053776efed771bc1a3880acb80b55959cbc
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1353
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1353
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/dco_freebsd.h b/src/openvpn/dco_freebsd.h
index 0797b82..5e2a552 100644
--- a/src/openvpn/dco_freebsd.h
+++ b/src/openvpn/dco_freebsd.h
@@ -33,6 +33,8 @@
 
 enum ovpn_message_type_t
 {
+    /* message type #0 is treated as magic number by process_incoming_dco() */
+    OVPN_CMD_NO_MESSAGE = 0,
     OVPN_CMD_DEL_PEER,
     OVPN_CMD_PACKET,
     OVPN_CMD_SWAP_KEYS,

