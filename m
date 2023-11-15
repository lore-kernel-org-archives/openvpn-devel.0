From: "ordex (Code Review)" <gerrit@...515...>
Date: Wed, 15 Nov 2023 13:45:07 +0000
References: <gerrit.1700055887000.Id5c50dc754837ddb9a9414d8f38982f75e99bace@...2715...>
Reply-To: a@...2181..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <48fd065a8239ec40d1f2eec759fab20038a0dafe-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eMmhxVPf3D4="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: io_work: convert
 shift argument to uintptr_t
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--eMmhxVPf3D4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/432?usp=3Demail

to review the following change.


Change subject: io_work: convert shift argument to uintptr_t
......................................................................

io_work: convert shift argument to uintptr_t

Instead of passing the shift argument as pointer, pass
directly its integer value. This will allow the code to
distinguish a shift value from a real object pointer,
like we already do in multi_tcp_process_io().

This change will allow us later to pass an event_arg
object as event handler argument instead of a simple
integer value.

Change-Id: Id5c50dc754837ddb9a9414d8f38982f75e99bace
Signed-off-by: Antonio Quartulli <a@...2181...>
---
M src/openvpn/forward.c
M src/openvpn/mtcp.c
M src/openvpn/ovpn_dco_linux.h
M src/openvpn/ovpn_dco_win.h
4 files changed, 212 insertions(+), 213 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/32/432/1

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 88d3fea..9cc5c6b 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -2046,14 +2046,12 @@
     unsigned int tuntap =3D 0;
     struct event_set_return esr[4];

-    /* These shifts all depend on EVENT_READ (=3D1) and EVENT_WRITE (=3D2)
-     * and are added to the shift. Check openvpn.h for more details.
-     */
-    static int socket_shift =3D SOCKET_SHIFT;
-    static int tun_shift =3D TUN_SHIFT;
-    static int err_shift =3D ERR_SHIFT;
+    /* These shifts all depend on EVENT_READ and EVENT_WRITE */
+    static uintptr_t socket_shift =3D 0;   /* depends on SOCKET_READ and S=
OCKET_WRITE */
+    static uintptr_t tun_shift =3D 2;      /* depends on TUN_READ and TUN_=
WRITE */
+    static uintptr_t err_shift =3D 4;      /* depends on ES_ERROR */
 #ifdef ENABLE_MANAGEMENT
-    static int management_shift =3D MANAGEMENT_SHIFT;
+    static uintptr_t management_shift =3D 6; /* depends on MANAGEMENT_READ=
 and MANAGEMENT_WRITE */
 #endif
 #ifdef ENABLE_ASYNC_PUSH
     static int file_shift =3D FILE_SHIFT;
@@ -2073,7 +2071,7 @@
      */
     if (flags & IOW_WAIT_SIGNAL)
     {
-        wait_signal(c->c2.event_set, (void *)&err_shift);
+        wait_signal(c->c2.event_set, (void *)err_shift);
     }

     /*
@@ -2167,7 +2165,7 @@
      * Configure event wait based on socket, tuntap flags.
      */
     socket_set(c->c2.link_socket, c->c2.event_set, socket, (void *)&socket=
_shift, NULL);
-    tun_set(c->c1.tuntap, c->c2.event_set, tuntap, (void *)&tun_shift, NUL=
L);
+    tun_set(c->c1.tuntap, c->c2.event_set, tuntap, (void *)tun_shift, NULL=
);
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
     if (socket & EVENT_READ && c->c2.did_open_tun)
     {
@@ -2178,7 +2176,7 @@
 #ifdef ENABLE_MANAGEMENT
     if (management)
     {
-        management_socket_set(management, c->c2.event_set, (void *)&manage=
ment_shift, NULL);
+        management_socket_set(management, c->c2.event_set, (void *)managem=
ent_shift, NULL);
     }
 #endif

@@ -2229,7 +2227,7 @@
                 for (i =3D 0; i < status; ++i)
                 {
                     const struct event_set_return *e =3D &esr[i];
-                    c->c2.event_set_status |=3D ((e->rwflags & 3) << *((in=
t *)e->arg));
+                    c->c2.event_set_status |=3D ((e->rwflags & 3) << (uint=
ptr_t)e->arg);
                 }
             }
             else if (status =3D=3D 0)
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index b83bdca..de1d24f 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -720,6 +720,7 @@
                         multi_tcp_action(m, mi, TA_SOCKET_READ, false);
                     }
                     break;
+
                 /* new incoming TCP client attempting to connect? */
                 case EVENT_ARG_LINK_SOCKET:
                     ASSERT(m->top.c2.link_socket);
diff --git a/src/openvpn/ovpn_dco_linux.h b/src/openvpn/ovpn_dco_linux.h
index 73e19b5..e62d2b4 100644
--- a/src/openvpn/ovpn_dco_linux.h
+++ b/src/openvpn/ovpn_dco_linux.h
@@ -4,8 +4,8 @@
  *
  *  Copyright (C) 2019-2023 OpenVPN, Inc.
  *
- *  Author:	James Yonan <james@...515...>
- *		Antonio Quartulli <antonio@...515...>
+ *  Author:     James Yonan <james@...515...>
+ *              Antonio Quartulli <antonio@...515...>
  */

 #ifndef _UAPI_LINUX_OVPN_DCO_H_
@@ -19,238 +19,238 @@
  * enum ovpn_nl_commands - supported netlink commands
  */
 enum ovpn_nl_commands {
-	/**
-	 * @OVPN_CMD_UNSPEC: unspecified command to catch errors
-	 */
-	OVPN_CMD_UNSPEC =3D 0,
+    /**
+     * @OVPN_CMD_UNSPEC: unspecified command to catch errors
+     */
+    OVPN_CMD_UNSPEC =3D 0,

-	/**
-	 * @OVPN_CMD_NEW_PEER: Configure peer with its crypto keys
-	 */
-	OVPN_CMD_NEW_PEER,
+    /**
+     * @OVPN_CMD_NEW_PEER: Configure peer with its crypto keys
+     */
+    OVPN_CMD_NEW_PEER,

-	/**
-	 * @OVPN_CMD_SET_PEER: Tweak parameters for an existing peer
-	 */
-	OVPN_CMD_SET_PEER,
+    /**
+     * @OVPN_CMD_SET_PEER: Tweak parameters for an existing peer
+     */
+    OVPN_CMD_SET_PEER,

-	/**
-	 * @OVPN_CMD_DEL_PEER: Remove peer from internal table
-	 */
-	OVPN_CMD_DEL_PEER,
+    /**
+     * @OVPN_CMD_DEL_PEER: Remove peer from internal table
+     */
+    OVPN_CMD_DEL_PEER,

-	OVPN_CMD_NEW_KEY,
+    OVPN_CMD_NEW_KEY,

-	OVPN_CMD_SWAP_KEYS,
+    OVPN_CMD_SWAP_KEYS,

-	OVPN_CMD_DEL_KEY,
+    OVPN_CMD_DEL_KEY,

-	/**
-	 * @OVPN_CMD_GET_PEER: Retrieve the status of a peer or all peers
-	 */
-	OVPN_CMD_GET_PEER,
+    /**
+     * @OVPN_CMD_GET_PEER: Retrieve the status of a peer or all peers
+     */
+    OVPN_CMD_GET_PEER,
 };

 enum ovpn_cipher_alg {
-	/**
-	 * @OVPN_CIPHER_ALG_NONE: No encryption - reserved for debugging only
-	 */
-	OVPN_CIPHER_ALG_NONE =3D 0,
-	/**
-	 * @OVPN_CIPHER_ALG_AES_GCM: AES-GCM AEAD cipher with any allowed key size
-	 */
-	OVPN_CIPHER_ALG_AES_GCM,
-	/**
-	 * @OVPN_CIPHER_ALG_CHACHA20_POLY1305: ChaCha20Poly1305 AEAD cipher
-	 */
-	OVPN_CIPHER_ALG_CHACHA20_POLY1305,
+    /**
+     * @OVPN_CIPHER_ALG_NONE: No encryption - reserved for debugging only
+     */
+    OVPN_CIPHER_ALG_NONE =3D 0,
+    /**
+     * @OVPN_CIPHER_ALG_AES_GCM: AES-GCM AEAD cipher with any allowed key =
size
+     */
+    OVPN_CIPHER_ALG_AES_GCM,
+    /**
+     * @OVPN_CIPHER_ALG_CHACHA20_POLY1305: ChaCha20Poly1305 AEAD cipher
+     */
+    OVPN_CIPHER_ALG_CHACHA20_POLY1305,
 };

 enum ovpn_del_peer_reason {
-	__OVPN_DEL_PEER_REASON_FIRST,
-	OVPN_DEL_PEER_REASON_TEARDOWN =3D __OVPN_DEL_PEER_REASON_FIRST,
-	OVPN_DEL_PEER_REASON_USERSPACE,
-	OVPN_DEL_PEER_REASON_EXPIRED,
-	OVPN_DEL_PEER_REASON_TRANSPORT_ERROR,
-	OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT,
-	__OVPN_DEL_PEER_REASON_AFTER_LAST
+    __OVPN_DEL_PEER_REASON_FIRST,
+    OVPN_DEL_PEER_REASON_TEARDOWN =3D __OVPN_DEL_PEER_REASON_FIRST,
+    OVPN_DEL_PEER_REASON_USERSPACE,
+    OVPN_DEL_PEER_REASON_EXPIRED,
+    OVPN_DEL_PEER_REASON_TRANSPORT_ERROR,
+    OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT,
+    __OVPN_DEL_PEER_REASON_AFTER_LAST
 };

 enum ovpn_key_slot {
-	__OVPN_KEY_SLOT_FIRST,
-	OVPN_KEY_SLOT_PRIMARY =3D __OVPN_KEY_SLOT_FIRST,
-	OVPN_KEY_SLOT_SECONDARY,
-	__OVPN_KEY_SLOT_AFTER_LAST,
+    __OVPN_KEY_SLOT_FIRST,
+    OVPN_KEY_SLOT_PRIMARY =3D __OVPN_KEY_SLOT_FIRST,
+    OVPN_KEY_SLOT_SECONDARY,
+    __OVPN_KEY_SLOT_AFTER_LAST,
 };

 enum ovpn_netlink_attrs {
-	OVPN_ATTR_UNSPEC =3D 0,
-	OVPN_ATTR_IFINDEX,
-	OVPN_ATTR_NEW_PEER,
-	OVPN_ATTR_SET_PEER,
-	OVPN_ATTR_DEL_PEER,
-	OVPN_ATTR_NEW_KEY,
-	OVPN_ATTR_SWAP_KEYS,
-	OVPN_ATTR_DEL_KEY,
-	OVPN_ATTR_GET_PEER,
+    OVPN_ATTR_UNSPEC =3D 0,
+    OVPN_ATTR_IFINDEX,
+    OVPN_ATTR_NEW_PEER,
+    OVPN_ATTR_SET_PEER,
+    OVPN_ATTR_DEL_PEER,
+    OVPN_ATTR_NEW_KEY,
+    OVPN_ATTR_SWAP_KEYS,
+    OVPN_ATTR_DEL_KEY,
+    OVPN_ATTR_GET_PEER,

-	__OVPN_ATTR_AFTER_LAST,
-	OVPN_ATTR_MAX =3D __OVPN_ATTR_AFTER_LAST - 1,
+    __OVPN_ATTR_AFTER_LAST,
+    OVPN_ATTR_MAX =3D __OVPN_ATTR_AFTER_LAST - 1,
 };

 enum ovpn_netlink_key_dir_attrs {
-	OVPN_KEY_DIR_ATTR_UNSPEC =3D 0,
-	OVPN_KEY_DIR_ATTR_CIPHER_KEY,
-	OVPN_KEY_DIR_ATTR_NONCE_TAIL,
+    OVPN_KEY_DIR_ATTR_UNSPEC =3D 0,
+    OVPN_KEY_DIR_ATTR_CIPHER_KEY,
+    OVPN_KEY_DIR_ATTR_NONCE_TAIL,

-	__OVPN_KEY_DIR_ATTR_AFTER_LAST,
-	OVPN_KEY_DIR_ATTR_MAX =3D __OVPN_KEY_DIR_ATTR_AFTER_LAST - 1,
+    __OVPN_KEY_DIR_ATTR_AFTER_LAST,
+    OVPN_KEY_DIR_ATTR_MAX =3D __OVPN_KEY_DIR_ATTR_AFTER_LAST - 1,
 };

 enum ovpn_netlink_new_key_attrs {
-	OVPN_NEW_KEY_ATTR_UNSPEC =3D 0,
-	OVPN_NEW_KEY_ATTR_PEER_ID,
-	OVPN_NEW_KEY_ATTR_KEY_SLOT,
-	OVPN_NEW_KEY_ATTR_KEY_ID,
-	OVPN_NEW_KEY_ATTR_CIPHER_ALG,
-	OVPN_NEW_KEY_ATTR_ENCRYPT_KEY,
-	OVPN_NEW_KEY_ATTR_DECRYPT_KEY,
+    OVPN_NEW_KEY_ATTR_UNSPEC =3D 0,
+    OVPN_NEW_KEY_ATTR_PEER_ID,
+    OVPN_NEW_KEY_ATTR_KEY_SLOT,
+    OVPN_NEW_KEY_ATTR_KEY_ID,
+    OVPN_NEW_KEY_ATTR_CIPHER_ALG,
+    OVPN_NEW_KEY_ATTR_ENCRYPT_KEY,
+    OVPN_NEW_KEY_ATTR_DECRYPT_KEY,

-	__OVPN_NEW_KEY_ATTR_AFTER_LAST,
-	OVPN_NEW_KEY_ATTR_MAX =3D __OVPN_NEW_KEY_ATTR_AFTER_LAST - 1,
+    __OVPN_NEW_KEY_ATTR_AFTER_LAST,
+    OVPN_NEW_KEY_ATTR_MAX =3D __OVPN_NEW_KEY_ATTR_AFTER_LAST - 1,
 };

 enum ovpn_netlink_del_key_attrs {
-	OVPN_DEL_KEY_ATTR_UNSPEC =3D 0,
-	OVPN_DEL_KEY_ATTR_PEER_ID,
-	OVPN_DEL_KEY_ATTR_KEY_SLOT,
+    OVPN_DEL_KEY_ATTR_UNSPEC =3D 0,
+    OVPN_DEL_KEY_ATTR_PEER_ID,
+    OVPN_DEL_KEY_ATTR_KEY_SLOT,

-	__OVPN_DEL_KEY_ATTR_AFTER_LAST,
-	OVPN_DEL_KEY_ATTR_MAX =3D __OVPN_DEL_KEY_ATTR_AFTER_LAST - 1,
+    __OVPN_DEL_KEY_ATTR_AFTER_LAST,
+    OVPN_DEL_KEY_ATTR_MAX =3D __OVPN_DEL_KEY_ATTR_AFTER_LAST - 1,
 };

 enum ovpn_netlink_swap_keys_attrs {
-	OVPN_SWAP_KEYS_ATTR_UNSPEC =3D 0,
-	OVPN_SWAP_KEYS_ATTR_PEER_ID,
+    OVPN_SWAP_KEYS_ATTR_UNSPEC =3D 0,
+    OVPN_SWAP_KEYS_ATTR_PEER_ID,

-	__OVPN_SWAP_KEYS_ATTR_AFTER_LAST,
-	OVPN_SWAP_KEYS_ATTR_MAX =3D __OVPN_SWAP_KEYS_ATTR_AFTER_LAST - 1,
+    __OVPN_SWAP_KEYS_ATTR_AFTER_LAST,
+    OVPN_SWAP_KEYS_ATTR_MAX =3D __OVPN_SWAP_KEYS_ATTR_AFTER_LAST - 1,

 };

 enum ovpn_netlink_new_peer_attrs {
-	OVPN_NEW_PEER_ATTR_UNSPEC =3D 0,
-	OVPN_NEW_PEER_ATTR_PEER_ID,
-	OVPN_NEW_PEER_ATTR_SOCKADDR_REMOTE,
-	OVPN_NEW_PEER_ATTR_SOCKET,
-	OVPN_NEW_PEER_ATTR_IPV4,
-	OVPN_NEW_PEER_ATTR_IPV6,
-	OVPN_NEW_PEER_ATTR_LOCAL_IP,
+    OVPN_NEW_PEER_ATTR_UNSPEC =3D 0,
+    OVPN_NEW_PEER_ATTR_PEER_ID,
+    OVPN_NEW_PEER_ATTR_SOCKADDR_REMOTE,
+    OVPN_NEW_PEER_ATTR_SOCKET,
+    OVPN_NEW_PEER_ATTR_IPV4,
+    OVPN_NEW_PEER_ATTR_IPV6,
+    OVPN_NEW_PEER_ATTR_LOCAL_IP,

-	__OVPN_NEW_PEER_ATTR_AFTER_LAST,
-	OVPN_NEW_PEER_ATTR_MAX =3D __OVPN_NEW_PEER_ATTR_AFTER_LAST - 1,
+    __OVPN_NEW_PEER_ATTR_AFTER_LAST,
+    OVPN_NEW_PEER_ATTR_MAX =3D __OVPN_NEW_PEER_ATTR_AFTER_LAST - 1,
 };

 enum ovpn_netlink_set_peer_attrs {
-	OVPN_SET_PEER_ATTR_UNSPEC =3D 0,
-	OVPN_SET_PEER_ATTR_PEER_ID,
-	OVPN_SET_PEER_ATTR_KEEPALIVE_INTERVAL,
-	OVPN_SET_PEER_ATTR_KEEPALIVE_TIMEOUT,
+    OVPN_SET_PEER_ATTR_UNSPEC =3D 0,
+    OVPN_SET_PEER_ATTR_PEER_ID,
+    OVPN_SET_PEER_ATTR_KEEPALIVE_INTERVAL,
+    OVPN_SET_PEER_ATTR_KEEPALIVE_TIMEOUT,

-	__OVPN_SET_PEER_ATTR_AFTER_LAST,
-	OVPN_SET_PEER_ATTR_MAX =3D __OVPN_SET_PEER_ATTR_AFTER_LAST - 1,
+    __OVPN_SET_PEER_ATTR_AFTER_LAST,
+    OVPN_SET_PEER_ATTR_MAX =3D __OVPN_SET_PEER_ATTR_AFTER_LAST - 1,
 };

 enum ovpn_netlink_del_peer_attrs {
-	OVPN_DEL_PEER_ATTR_UNSPEC =3D 0,
-	OVPN_DEL_PEER_ATTR_REASON,
-	OVPN_DEL_PEER_ATTR_PEER_ID,
+    OVPN_DEL_PEER_ATTR_UNSPEC =3D 0,
+    OVPN_DEL_PEER_ATTR_REASON,
+    OVPN_DEL_PEER_ATTR_PEER_ID,

-	__OVPN_DEL_PEER_ATTR_AFTER_LAST,
-	OVPN_DEL_PEER_ATTR_MAX =3D __OVPN_DEL_PEER_ATTR_AFTER_LAST - 1,
+    __OVPN_DEL_PEER_ATTR_AFTER_LAST,
+    OVPN_DEL_PEER_ATTR_MAX =3D __OVPN_DEL_PEER_ATTR_AFTER_LAST - 1,
 };

 enum ovpn_netlink_get_peer_attrs {
-	OVPN_GET_PEER_ATTR_UNSPEC =3D 0,
-	OVPN_GET_PEER_ATTR_PEER_ID,
+    OVPN_GET_PEER_ATTR_UNSPEC =3D 0,
+    OVPN_GET_PEER_ATTR_PEER_ID,

-	__OVPN_GET_PEER_ATTR_AFTER_LAST,
-	OVPN_GET_PEER_ATTR_MAX =3D __OVPN_GET_PEER_ATTR_AFTER_LAST - 1,
+    __OVPN_GET_PEER_ATTR_AFTER_LAST,
+    OVPN_GET_PEER_ATTR_MAX =3D __OVPN_GET_PEER_ATTR_AFTER_LAST - 1,
 };

 enum ovpn_netlink_get_peer_response_attrs {
-	OVPN_GET_PEER_RESP_ATTR_UNSPEC =3D 0,
-	OVPN_GET_PEER_RESP_ATTR_PEER_ID,
-	OVPN_GET_PEER_RESP_ATTR_SOCKADDR_REMOTE,
-	OVPN_GET_PEER_RESP_ATTR_IPV4,
-	OVPN_GET_PEER_RESP_ATTR_IPV6,
-	OVPN_GET_PEER_RESP_ATTR_LOCAL_IP,
-	OVPN_GET_PEER_RESP_ATTR_LOCAL_PORT,
-	OVPN_GET_PEER_RESP_ATTR_KEEPALIVE_INTERVAL,
-	OVPN_GET_PEER_RESP_ATTR_KEEPALIVE_TIMEOUT,
-	OVPN_GET_PEER_RESP_ATTR_VPN_RX_BYTES,
-	OVPN_GET_PEER_RESP_ATTR_VPN_TX_BYTES,
-	OVPN_GET_PEER_RESP_ATTR_VPN_RX_PACKETS,
-	OVPN_GET_PEER_RESP_ATTR_VPN_TX_PACKETS,
-	OVPN_GET_PEER_RESP_ATTR_LINK_RX_BYTES,
-	OVPN_GET_PEER_RESP_ATTR_LINK_TX_BYTES,
-	OVPN_GET_PEER_RESP_ATTR_LINK_RX_PACKETS,
-	OVPN_GET_PEER_RESP_ATTR_LINK_TX_PACKETS,
+    OVPN_GET_PEER_RESP_ATTR_UNSPEC =3D 0,
+    OVPN_GET_PEER_RESP_ATTR_PEER_ID,
+    OVPN_GET_PEER_RESP_ATTR_SOCKADDR_REMOTE,
+    OVPN_GET_PEER_RESP_ATTR_IPV4,
+    OVPN_GET_PEER_RESP_ATTR_IPV6,
+    OVPN_GET_PEER_RESP_ATTR_LOCAL_IP,
+    OVPN_GET_PEER_RESP_ATTR_LOCAL_PORT,
+    OVPN_GET_PEER_RESP_ATTR_KEEPALIVE_INTERVAL,
+    OVPN_GET_PEER_RESP_ATTR_KEEPALIVE_TIMEOUT,
+    OVPN_GET_PEER_RESP_ATTR_VPN_RX_BYTES,
+    OVPN_GET_PEER_RESP_ATTR_VPN_TX_BYTES,
+    OVPN_GET_PEER_RESP_ATTR_VPN_RX_PACKETS,
+    OVPN_GET_PEER_RESP_ATTR_VPN_TX_PACKETS,
+    OVPN_GET_PEER_RESP_ATTR_LINK_RX_BYTES,
+    OVPN_GET_PEER_RESP_ATTR_LINK_TX_BYTES,
+    OVPN_GET_PEER_RESP_ATTR_LINK_RX_PACKETS,
+    OVPN_GET_PEER_RESP_ATTR_LINK_TX_PACKETS,

-	__OVPN_GET_PEER_RESP_ATTR_AFTER_LAST,
-	OVPN_GET_PEER_RESP_ATTR_MAX =3D __OVPN_GET_PEER_RESP_ATTR_AFTER_LAST - 1,
+    __OVPN_GET_PEER_RESP_ATTR_AFTER_LAST,
+    OVPN_GET_PEER_RESP_ATTR_MAX =3D __OVPN_GET_PEER_RESP_ATTR_AFTER_LAST -=
 1,
 };

 enum ovpn_netlink_peer_stats_attrs {
-	OVPN_PEER_STATS_ATTR_UNSPEC =3D 0,
-	OVPN_PEER_STATS_BYTES,
-	OVPN_PEER_STATS_PACKETS,
+    OVPN_PEER_STATS_ATTR_UNSPEC =3D 0,
+    OVPN_PEER_STATS_BYTES,
+    OVPN_PEER_STATS_PACKETS,

-	__OVPN_PEER_STATS_ATTR_AFTER_LAST,
-	OVPN_PEER_STATS_ATTR_MAX =3D __OVPN_PEER_STATS_ATTR_AFTER_LAST - 1,
+    __OVPN_PEER_STATS_ATTR_AFTER_LAST,
+    OVPN_PEER_STATS_ATTR_MAX =3D __OVPN_PEER_STATS_ATTR_AFTER_LAST - 1,
 };

 enum ovpn_netlink_peer_attrs {
-	OVPN_PEER_ATTR_UNSPEC =3D 0,
-	OVPN_PEER_ATTR_PEER_ID,
-	OVPN_PEER_ATTR_SOCKADDR_REMOTE,
-	OVPN_PEER_ATTR_IPV4,
-	OVPN_PEER_ATTR_IPV6,
-	OVPN_PEER_ATTR_LOCAL_IP,
-	OVPN_PEER_ATTR_KEEPALIVE_INTERVAL,
-	OVPN_PEER_ATTR_KEEPALIVE_TIMEOUT,
-	OVPN_PEER_ATTR_ENCRYPT_KEY,
-	OVPN_PEER_ATTR_DECRYPT_KEY,
-	OVPN_PEER_ATTR_RX_STATS,
-	OVPN_PEER_ATTR_TX_STATS,
+    OVPN_PEER_ATTR_UNSPEC =3D 0,
+    OVPN_PEER_ATTR_PEER_ID,
+    OVPN_PEER_ATTR_SOCKADDR_REMOTE,
+    OVPN_PEER_ATTR_IPV4,
+    OVPN_PEER_ATTR_IPV6,
+    OVPN_PEER_ATTR_LOCAL_IP,
+    OVPN_PEER_ATTR_KEEPALIVE_INTERVAL,
+    OVPN_PEER_ATTR_KEEPALIVE_TIMEOUT,
+    OVPN_PEER_ATTR_ENCRYPT_KEY,
+    OVPN_PEER_ATTR_DECRYPT_KEY,
+    OVPN_PEER_ATTR_RX_STATS,
+    OVPN_PEER_ATTR_TX_STATS,

-	__OVPN_PEER_ATTR_AFTER_LAST,
-	OVPN_PEER_ATTR_MAX =3D __OVPN_PEER_ATTR_AFTER_LAST - 1,
+    __OVPN_PEER_ATTR_AFTER_LAST,
+    OVPN_PEER_ATTR_MAX =3D __OVPN_PEER_ATTR_AFTER_LAST - 1,
 };

 enum ovpn_netlink_packet_attrs {
-	OVPN_PACKET_ATTR_UNSPEC =3D 0,
-	OVPN_PACKET_ATTR_PACKET,
-	OVPN_PACKET_ATTR_PEER_ID,
+    OVPN_PACKET_ATTR_UNSPEC =3D 0,
+    OVPN_PACKET_ATTR_PACKET,
+    OVPN_PACKET_ATTR_PEER_ID,

-	__OVPN_PACKET_ATTR_AFTER_LAST,
-	OVPN_PACKET_ATTR_MAX =3D __OVPN_PACKET_ATTR_AFTER_LAST - 1,
+    __OVPN_PACKET_ATTR_AFTER_LAST,
+    OVPN_PACKET_ATTR_MAX =3D __OVPN_PACKET_ATTR_AFTER_LAST - 1,
 };

 enum ovpn_ifla_attrs {
-	IFLA_OVPN_UNSPEC =3D 0,
-	IFLA_OVPN_MODE,
+    IFLA_OVPN_UNSPEC =3D 0,
+    IFLA_OVPN_MODE,

-	__IFLA_OVPN_AFTER_LAST,
-	IFLA_OVPN_MAX =3D __IFLA_OVPN_AFTER_LAST - 1,
+    __IFLA_OVPN_AFTER_LAST,
+    IFLA_OVPN_MAX =3D __IFLA_OVPN_AFTER_LAST - 1,
 };

 enum ovpn_mode {
-	__OVPN_MODE_FIRST =3D 0,
-	OVPN_MODE_P2P =3D __OVPN_MODE_FIRST,
-	OVPN_MODE_MP,
+    __OVPN_MODE_FIRST =3D 0,
+    OVPN_MODE_P2P =3D __OVPN_MODE_FIRST,
+    OVPN_MODE_MP,

-	__OVPN_MODE_AFTER_LAST,
+    __OVPN_MODE_AFTER_LAST,
 };

 #endif /* _UAPI_LINUX_OVPN_DCO_H_ */
diff --git a/src/openvpn/ovpn_dco_win.h b/src/openvpn/ovpn_dco_win.h
index ea2a733..e8bd074 100644
--- a/src/openvpn/ovpn_dco_win.h
+++ b/src/openvpn/ovpn_dco_win.h
@@ -3,7 +3,7 @@
  *
  *  Copyright (C) 2020-2021 OpenVPN Inc <sales@...515...>
  *
- *  Author:	Lev Stipakov <lev@...515...>
+ *  Author:     Lev Stipakov <lev@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
@@ -29,76 +29,76 @@
 #include <ws2ipdef.h>

 typedef enum {
-	OVPN_PROTO_UDP,
-	OVPN_PROTO_TCP
+    OVPN_PROTO_UDP,
+    OVPN_PROTO_TCP
 } OVPN_PROTO;

 typedef struct _OVPN_NEW_PEER {
-	union {
-		SOCKADDR_IN Addr4;
-		SOCKADDR_IN6 Addr6;
-	} Local;
+    union {
+        SOCKADDR_IN Addr4;
+        SOCKADDR_IN6 Addr6;
+    } Local;

-	union {
-		SOCKADDR_IN Addr4;
-		SOCKADDR_IN6 Addr6;
-	} Remote;
+    union {
+        SOCKADDR_IN Addr4;
+        SOCKADDR_IN6 Addr6;
+    } Remote;

-	OVPN_PROTO Proto;
-} OVPN_NEW_PEER, * POVPN_NEW_PEER;
+    OVPN_PROTO Proto;
+} OVPN_NEW_PEER, *POVPN_NEW_PEER;

 typedef struct _OVPN_STATS {
-	LONG LostInControlPackets;
-	LONG LostOutControlPackets;
+    LONG LostInControlPackets;
+    LONG LostOutControlPackets;

-	LONG LostInDataPackets;
-	LONG LostOutDataPackets;
+    LONG LostInDataPackets;
+    LONG LostOutDataPackets;

-	LONG ReceivedDataPackets;
-	LONG ReceivedControlPackets;
+    LONG ReceivedDataPackets;
+    LONG ReceivedControlPackets;

-	LONG SentControlPackets;
-	LONG SentDataPackets;
+    LONG SentControlPackets;
+    LONG SentDataPackets;

-	LONG64 TransportBytesSent;
-	LONG64 TransportBytesReceived;
+    LONG64 TransportBytesSent;
+    LONG64 TransportBytesReceived;

-	LONG64 TunBytesSent;
-	LONG64 TunBytesReceived;
-} OVPN_STATS, * POVPN_STATS;
+    LONG64 TunBytesSent;
+    LONG64 TunBytesReceived;
+} OVPN_STATS, *POVPN_STATS;

 typedef enum _OVPN_KEY_SLOT {
-	OVPN_KEY_SLOT_PRIMARY,
-	OVPN_KEY_SLOT_SECONDARY
+    OVPN_KEY_SLOT_PRIMARY,
+    OVPN_KEY_SLOT_SECONDARY
 } OVPN_KEY_SLOT;

 typedef enum _OVPN_CIPHER_ALG {
-	OVPN_CIPHER_ALG_NONE,
-	OVPN_CIPHER_ALG_AES_GCM,
-	OVPN_CIPHER_ALG_CHACHA20_POLY1305
+    OVPN_CIPHER_ALG_NONE,
+    OVPN_CIPHER_ALG_AES_GCM,
+    OVPN_CIPHER_ALG_CHACHA20_POLY1305
 } OVPN_CIPHER_ALG;
=20
 typedef struct _OVPN_KEY_DIRECTION
 {
-	unsigned char Key[32];
-	unsigned char KeyLen; // 16/24/32 -> AES-128-GCM/AES-192-GCM/AES-256-GCM
-	unsigned char NonceTail[8];
+    unsigned char Key[32];
+    unsigned char KeyLen;     /* 16/24/32 -> AES-128-GCM/AES-192-GCM/AES-2=
56-GCM */
+    unsigned char NonceTail[8];
 } OVPN_KEY_DIRECTION;

 typedef struct _OVPN_CRYPTO_DATA {
-	OVPN_KEY_DIRECTION Encrypt;
-	OVPN_KEY_DIRECTION Decrypt;
-	OVPN_KEY_SLOT KeySlot;
-	OVPN_CIPHER_ALG CipherAlg;
-	unsigned char KeyId;
-	int PeerId;
-} OVPN_CRYPTO_DATA, * POVPN_CRYPTO_DATA;
+    OVPN_KEY_DIRECTION Encrypt;
+    OVPN_KEY_DIRECTION Decrypt;
+    OVPN_KEY_SLOT KeySlot;
+    OVPN_CIPHER_ALG CipherAlg;
+    unsigned char KeyId;
+    int PeerId;
+} OVPN_CRYPTO_DATA, *POVPN_CRYPTO_DATA;

 typedef struct _OVPN_SET_PEER {
-	LONG KeepaliveInterval;
-	LONG KeepaliveTimeout;
-	LONG MSS;
-} OVPN_SET_PEER, * POVPN_SET_PEER;
+    LONG KeepaliveInterval;
+    LONG KeepaliveTimeout;
+    LONG MSS;
+} OVPN_SET_PEER, *POVPN_SET_PEER;

 typedef struct _OVPN_VERSION {
     LONG Major;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/432?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id5c50dc754837ddb9a9414d8f38982f75e99bace
Gerrit-Change-Number: 432
Gerrit-PatchSet: 1
Gerrit-Owner: ordex <a@...2181...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--eMmhxVPf3D4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>ordex would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/432?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">io_work: convert shift argument to uintptr_t<br><br>Instead o=
f passing the shift argument as pointer, pass<br>directly its integer value=
. This will allow the code to<br>distinguish a shift value from a real obje=
ct pointer,<br>like we already do in multi_tcp_process_io().<br><br>This ch=
ange will allow us later to pass an event_arg<br>object as event handler ar=
gument instead of a simple<br>integer value.<br><br>Change-Id: Id5c50dc7548=
37ddb9a9414d8f38982f75e99bace<br>Signed-off-by: Antonio Quartulli &lt;a@...493...=
2181...&gt;<br>---<br>M src/openvpn/forward.c<br>M src/openvpn/mtcp.c<br>M =
src/openvpn/ovpn_dco_linux.h<br>M src/openvpn/ovpn_dco_win.h<br>4 files cha=
nged, 212 insertions(+), 213 deletions(-)<br><br></pre><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.o=
penvpn.net:29418/openvpn refs/changes/32/432/1</pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/ope=
nvpn/forward.c b/src/openvpn/forward.c</span><br><span>index 88d3fea..9cc5c=
6b 100644</span><br><span>--- a/src/openvpn/forward.c</span><br><span>+++ b=
/src/openvpn/forward.c</span><br><span>@@ -2046,14 +2046,12 @@</span><br><s=
pan>     unsigned int tuntap =3D 0;</span><br><span>     struct event_set_r=
eturn esr[4];</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    /* These shifts all depend on EVENT_READ (=3D1) and EVENT_WRI=
TE (=3D2)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * and a=
re added to the shift. Check openvpn.h for more details.</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-     */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    static int socket_shift =3D SOCKET_SHIFT;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    static int tun_shift =3D T=
UN_SHIFT;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    static i=
nt err_shift =3D ERR_SHIFT;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* These shifts all depend on EVENT_READ and EVENT_WRITE */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    static uintptr_t so=
cket_shift =3D 0;   /* depends on SOCKET_READ and SOCKET_WRITE */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    static uintptr_t tun_shif=
t =3D 2;      /* depends on TUN_READ and TUN_WRITE */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    static uintptr_t err_shift =3D 4;    =
  /* depends on ES_ERROR */</span><br><span> #ifdef ENABLE_MANAGEMENT</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    static int management_s=
hift =3D MANAGEMENT_SHIFT;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    static uintptr_t management_shift =3D 6; /* depends on MANAGEMEN=
T_READ and MANAGEMENT_WRITE */</span><br><span> #endif</span><br><span> #if=
def ENABLE_ASYNC_PUSH</span><br><span>     static int file_shift =3D FILE_S=
HIFT;</span><br><span>@@ -2073,7 +2071,7 @@</span><br><span>      */</span>=
<br><span>     if (flags &amp; IOW_WAIT_SIGNAL)</span><br><span>     {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        wait_signal(c-&gt;=
c2.event_set, (void *)&amp;err_shift);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        wait_signal(c-&gt;c2.event_set, (void *)err_shif=
t);</span><br><span>     }</span><br><span> </span><br><span>     /*</span>=
<br><span>@@ -2167,7 +2165,7 @@</span><br><span>      * Configure event wai=
t based on socket, tuntap flags.</span><br><span>      */</span><br><span> =
    socket_set(c-&gt;c2.link_socket, c-&gt;c2.event_set, socket, (void *)&a=
mp;socket_shift, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    tun_set(c-&gt;c1.tuntap, c-&gt;c2.event_set, tuntap, (void *)&amp;tun=
_shift, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    t=
un_set(c-&gt;c1.tuntap, c-&gt;c2.event_set, tuntap, (void *)tun_shift, NULL=
);</span><br><span> #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)</s=
pan><br><span>     if (socket &amp; EVENT_READ &amp;&amp; c-&gt;c2.did_open=
_tun)</span><br><span>     {</span><br><span>@@ -2178,7 +2176,7 @@</span><b=
r><span> #ifdef ENABLE_MANAGEMENT</span><br><span>     if (management)</spa=
n><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     management_socket_set(management, c-&gt;c2.event_set, (void *)&amp;man=
agement_shift, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        management_socket_set(management, c-&gt;c2.event_set, (void *)man=
agement_shift, NULL);</span><br><span>     }</span><br><span> #endif</span>=
<br><span> </span><br><span>@@ -2229,7 +2227,7 @@</span><br><span>         =
        for (i =3D 0; i &lt; status; ++i)</span><br><span>                 =
{</span><br><span>                     const struct event_set_return *e =3D=
 &amp;esr[i];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
            c-&gt;c2.event_set_status |=3D ((e-&gt;rwflags &amp; 3) &lt;&lt=
; *((int *)e-&gt;arg));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                    c-&gt;c2.event_set_status |=3D ((e-&gt;rwflags &amp=
; 3) &lt;&lt; (uintptr_t)e-&gt;arg);</span><br><span>                 }</sp=
an><br><span>             }</span><br><span>             else if (status =
=3D=3D 0)</span><br><span>diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtc=
p.c</span><br><span>index b83bdca..de1d24f 100644</span><br><span>--- a/src=
/openvpn/mtcp.c</span><br><span>+++ b/src/openvpn/mtcp.c</span><br><span>@@=
 -720,6 +720,7 @@</span><br><span>                         multi_tcp_action=
(m, mi, TA_SOCKET_READ, false);</span><br><span>                     }</spa=
n><br><span>                     break;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span>                 /* new incoming TCP c=
lient attempting to connect? */</span><br><span>                 case EVENT=
_ARG_LINK_SOCKET:</span><br><span>                     ASSERT(m-&gt;top.c2.=
link_socket);</span><br><span>diff --git a/src/openvpn/ovpn_dco_linux.h b/s=
rc/openvpn/ovpn_dco_linux.h</span><br><span>index 73e19b5..e62d2b4 100644</=
span><br><span>--- a/src/openvpn/ovpn_dco_linux.h</span><br><span>+++ b/src=
/openvpn/ovpn_dco_linux.h</span><br><span>@@ -4,8 +4,8 @@</span><br><span> =
 *</span><br><span>  *  Copyright (C) 2019-2023 OpenVPN, Inc.</span><br><sp=
an>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  Author:	Jam=
es Yonan &lt;james@...515...&gt;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- *		Antonio Quartulli &lt;antonio@...515...&gt;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  Author:     James Yonan &lt;jame=
s@...515...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
            Antonio Quartulli &lt;antonio@...515...&gt;</span><br><span>  *=
/</span><br><span> </span><br><span> #ifndef _UAPI_LINUX_OVPN_DCO_H_</span>=
<br><span>@@ -19,238 +19,238 @@</span><br><span>  * enum ovpn_nl_commands -=
 supported netlink commands</span><br><span>  */</span><br><span> enum ovpn=
_nl_commands {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	/**</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-	 * @OVPN_CMD_UNSPEC: un=
specified command to catch errors</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-	 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN=
_CMD_UNSPEC =3D 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * @OVPN_=
CMD_UNSPEC: unspecified command to catch errors</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    OVPN_CMD_UNSPEC =3D 0,</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-	/**</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-	 * @OVPN_CMD_NEW_PEER: Configure peer with its crypt=
o keys</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	 */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_CMD_NEW_PEER,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /**</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     * @OVPN_CMD_NEW_PEER: Configure peer wi=
th its crypto keys</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_CMD_=
NEW_PEER,</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-	/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	 * @OVPN_C=
MD_SET_PEER: Tweak parameters for an existing peer</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-	 */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-	OVPN_CMD_SET_PEER,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     * @OVPN_CMD_SET_PEER: Tweak parameters for an existing peer</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    OVPN_CMD_SET_PEER,</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-	/**</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-	 * @OVPN_CMD_DEL_PEER: Remove peer fro=
m internal table</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	 */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_CMD_DEL_PEER,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /**</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     * @OVPN_CMD_DEL_PEER: Remove =
peer from internal table</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVP=
N_CMD_DEL_PEER,</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-	OVPN_CMD_NEW_KEY,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    OVPN_CMD_NEW_KEY,</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-	OVPN_CMD_SWAP_KEYS,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    OVPN_CMD_SWAP_KEYS,</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_CMD_DEL_KEY,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_CMD_DEL_KEY,</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-	/**</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-	 * @OVPN_CMD_GET_PEER: R=
etrieve the status of a peer or all peers</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-	 */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-	OVPN_CMD_GET_PEER,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * @O=
VPN_CMD_GET_PEER: Retrieve the status of a peer or all peers</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    OVPN_CMD_GET_PEER,</span><br><span> };</sp=
an><br><span> </span><br><span> enum ovpn_cipher_alg {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-	/**</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-	 * @OVPN_CIPHER_ALG_NONE: No encryption - reserved for deb=
ugging only</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	 */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_CIPHER_ALG_NONE =3D 0=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	/**</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-	 * @OVPN_CIPHER_ALG_AES_GCM: AES-GCM=
 AEAD cipher with any allowed key size</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-	 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
	OVPN_CIPHER_ALG_AES_GCM,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-	/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	 * @OVPN_CIP=
HER_ALG_CHACHA20_POLY1305: ChaCha20Poly1305 AEAD cipher</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-	 */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-	OVPN_CIPHER_ALG_CHACHA20_POLY1305,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /**</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     * @OVPN_CIPHER_ALG_NONE: No encryption - reserve=
d for debugging only</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_CI=
PHER_ALG_NONE =3D 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * @OVP=
N_CIPHER_ALG_AES_GCM: AES-GCM AEAD cipher with any allowed key size</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    OVPN_CIPHER_ALG_AES_GCM,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * @OVPN_CIPHER_ALG_CHACHA20_POLY1305=
: ChaCha20Poly1305 AEAD cipher</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   OVPN_CIPHER_ALG_CHACHA20_POLY1305,</span><br><span> };</span><br><span> =
</span><br><span> enum ovpn_del_peer_reason {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-	__OVPN_DEL_PEER_REASON_FIRST,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-	OVPN_DEL_PEER_REASON_TEARDOWN =3D __OVPN_=
DEL_PEER_REASON_FIRST,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-	OVPN_DEL_PEER_REASON_USERSPACE,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-	OVPN_DEL_PEER_REASON_EXPIRED,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-	OVPN_DEL_PEER_REASON_TRANSPORT_ERROR,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-	OVPN_DEL_PEER_REASON_TRANSPORT_DISCO=
NNECT,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	__OVPN_DEL_PEE=
R_REASON_AFTER_LAST</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    __OVPN_DEL_PEER_REASON_FIRST,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    OVPN_DEL_PEER_REASON_TEARDOWN =3D __OVPN_DEL_PEER_REASON_=
FIRST,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_DEL_=
PEER_REASON_USERSPACE,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    OVPN_DEL_PEER_REASON_EXPIRED,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    OVPN_DEL_PEER_REASON_TRANSPORT_ERROR,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    OVPN_DEL_PEER_REASON_TRANSPORT_D=
ISCONNECT,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    __OVP=
N_DEL_PEER_REASON_AFTER_LAST</span><br><span> };</span><br><span> </span><b=
r><span> enum ovpn_key_slot {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-	__OVPN_KEY_SLOT_FIRST,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-	OVPN_KEY_SLOT_PRIMARY =3D __OVPN_KEY_SLOT_FIRST,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-	OVPN_KEY_SLOT_SECONDARY,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-	__OVPN_KEY_SLOT_AFTER_LAST,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    __OVPN_KEY_SLOT_FIRS=
T,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_KEY_SLOT=
_PRIMARY =3D __OVPN_KEY_SLOT_FIRST,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    OVPN_KEY_SLOT_SECONDARY,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    __OVPN_KEY_SLOT_AFTER_LAST,</span><br><span> }=
;</span><br><span> </span><br><span> enum ovpn_netlink_attrs {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-	OVPN_ATTR_UNSPEC =3D 0,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_ATTR_IFINDEX,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_ATTR_NEW_PEER,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-	OVPN_ATTR_SET_PEER,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-	OVPN_ATTR_DEL_PEER,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-	OVPN_ATTR_NEW_KEY,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-	OVPN_ATTR_SWAP_KEYS,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-	OVPN_ATTR_DEL_KEY,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-	OVPN_ATTR_GET_PEER,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    OVPN_ATTR_UNSPEC =3D 0,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_ATTR_IFINDEX,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_ATTR_NEW_PEER,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_ATTR_SET_PEER,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_ATTR_DEL_PE=
ER,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_ATTR_NE=
W_KEY,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_ATTR=
_SWAP_KEYS,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN=
_ATTR_DEL_KEY,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    O=
VPN_ATTR_GET_PEER,</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-	__OVPN_ATTR_AFTER_LAST,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-	OVPN_ATTR_MAX =3D __OVPN_ATTR_AFTER_LAST - 1,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    __OVPN_ATTR_AFTER_LAST,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_ATTR_MAX =3D =
__OVPN_ATTR_AFTER_LAST - 1,</span><br><span> };</span><br><span> </span><br=
><span> enum ovpn_netlink_key_dir_attrs {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-	OVPN_KEY_DIR_ATTR_UNSPEC =3D 0,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	OVPN_KEY_DIR_ATTR_CIPHER_KEY,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-	OVPN_KEY_DIR_ATTR_NONCE_TAIL,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_KEY_DIR_ATTR_U=
NSPEC =3D 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVP=
N_KEY_DIR_ATTR_CIPHER_KEY,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    OVPN_KEY_DIR_ATTR_NONCE_TAIL,</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-	__OVPN_KEY_DIR_ATTR_AFTER_LAST,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_KEY_DIR_ATTR_MAX =3D =
__OVPN_KEY_DIR_ATTR_AFTER_LAST - 1,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    __OVPN_KEY_DIR_ATTR_AFTER_LAST,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    OVPN_KEY_DIR_ATTR_MAX =3D __OVPN_KEY_=
DIR_ATTR_AFTER_LAST - 1,</span><br><span> };</span><br><span> </span><br><s=
pan> enum ovpn_netlink_new_key_attrs {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-	OVPN_NEW_KEY_ATTR_UNSPEC =3D 0,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-	OVPN_NEW_KEY_ATTR_PEER_ID,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-	OVPN_NEW_KEY_ATTR_KEY_SLOT,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-	OVPN_NEW_KEY_ATTR_KEY_ID,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_NEW_KEY_ATTR_CIPHER_ALG=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_NEW_KEY_ATTR_E=
NCRYPT_KEY,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_NEW_=
KEY_ATTR_DECRYPT_KEY,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    OVPN_NEW_KEY_ATTR_UNSPEC =3D 0,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    OVPN_NEW_KEY_ATTR_PEER_ID,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    OVPN_NEW_KEY_ATTR_KEY_SLOT,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    OVPN_NEW_KEY_ATTR_KEY_ID,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_NEW_KEY_ATTR_CI=
PHER_ALG,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_N=
EW_KEY_ATTR_ENCRYPT_KEY,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    OVPN_NEW_KEY_ATTR_DECRYPT_KEY,</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-	__OVPN_NEW_KEY_ATTR_AFTER_LAST,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_NEW_KEY_ATTR_MAX =3D _=
_OVPN_NEW_KEY_ATTR_AFTER_LAST - 1,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    __OVPN_NEW_KEY_ATTR_AFTER_LAST,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    OVPN_NEW_KEY_ATTR_MAX =3D __OVPN_NEW_KEY=
_ATTR_AFTER_LAST - 1,</span><br><span> };</span><br><span> </span><br><span=
> enum ovpn_netlink_del_key_attrs {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-	OVPN_DEL_KEY_ATTR_UNSPEC =3D 0,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-	OVPN_DEL_KEY_ATTR_PEER_ID,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	OVPN_DEL_KEY_ATTR_KEY_SLOT,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    OVPN_DEL_KEY_ATTR_UNSPEC =3D 0=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_DEL_KEY_A=
TTR_PEER_ID,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVP=
N_DEL_KEY_ATTR_KEY_SLOT,</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-	__OVPN_DEL_KEY_ATTR_AFTER_LAST,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	OVPN_DEL_KEY_ATTR_MAX =3D __OVPN_DEL_KEY_A=
TTR_AFTER_LAST - 1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    __OVPN_DEL_KEY_ATTR_AFTER_LAST,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    OVPN_DEL_KEY_ATTR_MAX =3D __OVPN_DEL_KEY_ATTR_AFTER_LAS=
T - 1,</span><br><span> };</span><br><span> </span><br><span> enum ovpn_net=
link_swap_keys_attrs {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-	OVPN_SWAP_KEYS_ATTR_UNSPEC =3D 0,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-	OVPN_SWAP_KEYS_ATTR_PEER_ID,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    OVPN_SWAP_KEYS_ATTR_UNSPEC =3D 0,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    OVPN_SWAP_KEYS_ATTR_PEER_ID,<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-	__O=
VPN_SWAP_KEYS_ATTR_AFTER_LAST,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-	OVPN_SWAP_KEYS_ATTR_MAX =3D __OVPN_SWAP_KEYS_ATTR_AFTER_LAST - 1,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    __OVPN_SWAP_KEY=
S_ATTR_AFTER_LAST,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   OVPN_SWAP_KEYS_ATTR_MAX =3D __OVPN_SWAP_KEYS_ATTR_AFTER_LAST - 1,</span>=
<br><span> </span><br><span> };</span><br><span> </span><br><span> enum ovp=
n_netlink_new_peer_attrs {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-	OVPN_NEW_PEER_ATTR_UNSPEC =3D 0,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-	OVPN_NEW_PEER_ATTR_PEER_ID,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-	OVPN_NEW_PEER_ATTR_SOCKADDR_REMOTE,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-	OVPN_NEW_PEER_ATTR_SOCKET,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_NEW_PEER_ATTR_IPV4,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_NEW_PEER_ATTR_IPV6,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_NEW_PEER_ATTR_LO=
CAL_IP,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_NEW=
_PEER_ATTR_UNSPEC =3D 0,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    OVPN_NEW_PEER_ATTR_PEER_ID,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    OVPN_NEW_PEER_ATTR_SOCKADDR_REMOTE,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    OVPN_NEW_PEER_ATTR_SOCKET,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_NEW_PEER_ATTR_IPV4=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_NEW_PEER_=
ATTR_IPV6,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_=
NEW_PEER_ATTR_LOCAL_IP,</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-	__OVPN_NEW_PEER_ATTR_AFTER_LAST,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	OVPN_NEW_PEER_ATTR_MAX =3D __OVPN_NEW_PEER=
_ATTR_AFTER_LAST - 1,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    __OVPN_NEW_PEER_ATTR_AFTER_LAST,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    OVPN_NEW_PEER_ATTR_MAX =3D __OVPN_NEW_PEER_ATTR_AFTE=
R_LAST - 1,</span><br><span> };</span><br><span> </span><br><span> enum ovp=
n_netlink_set_peer_attrs {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-	OVPN_SET_PEER_ATTR_UNSPEC =3D 0,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-	OVPN_SET_PEER_ATTR_PEER_ID,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-	OVPN_SET_PEER_ATTR_KEEPALIVE_INTERVAL,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_SET_PEER_ATTR_KEEPALIVE_TIM=
EOUT,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_SET_P=
EER_ATTR_UNSPEC =3D 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    OVPN_SET_PEER_ATTR_PEER_ID,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    OVPN_SET_PEER_ATTR_KEEPALIVE_INTERVAL,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    OVPN_SET_PEER_ATTR_KEEPALIVE_TIME=
OUT,</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-	__OVPN_SET_PEER_ATTR_AFTER_LAST,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-	OVPN_SET_PEER_ATTR_MAX =3D __OVPN_SET_PEER_ATTR_AFTER_LAST - =
1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    __OVPN_SET_PE=
ER_ATTR_AFTER_LAST,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    OVPN_SET_PEER_ATTR_MAX =3D __OVPN_SET_PEER_ATTR_AFTER_LAST - 1,</span><=
br><span> };</span><br><span> </span><br><span> enum ovpn_netlink_del_peer_=
attrs {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_DEL_PEER=
_ATTR_UNSPEC =3D 0,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	O=
VPN_DEL_PEER_ATTR_REASON,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-	OVPN_DEL_PEER_ATTR_PEER_ID,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    OVPN_DEL_PEER_ATTR_UNSPEC =3D 0,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    OVPN_DEL_PEER_ATTR_REASON,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    OVPN_DEL_PEER_ATTR_PEER_ID,</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-	__OVP=
N_DEL_PEER_ATTR_AFTER_LAST,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-	OVPN_DEL_PEER_ATTR_MAX =3D __OVPN_DEL_PEER_ATTR_AFTER_LAST - 1,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    __OVPN_DEL_PEER_ATTR=
_AFTER_LAST,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVP=
N_DEL_PEER_ATTR_MAX =3D __OVPN_DEL_PEER_ATTR_AFTER_LAST - 1,</span><br><spa=
n> };</span><br><span> </span><br><span> enum ovpn_netlink_get_peer_attrs {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_GET_PEER_ATTR_U=
NSPEC =3D 0,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_GET=
_PEER_ATTR_PEER_ID,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    OVPN_GET_PEER_ATTR_UNSPEC =3D 0,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    OVPN_GET_PEER_ATTR_PEER_ID,</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-	__OVPN_GET_PEER_ATTR_AFTER_LA=
ST,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_GET_PEER_ATT=
R_MAX =3D __OVPN_GET_PEER_ATTR_AFTER_LAST - 1,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    __OVPN_GET_PEER_ATTR_AFTER_LAST,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_GET_PEER_ATTR_MAX =3D =
__OVPN_GET_PEER_ATTR_AFTER_LAST - 1,</span><br><span> };</span><br><span> <=
/span><br><span> enum ovpn_netlink_get_peer_response_attrs {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-	OVPN_GET_PEER_RESP_ATTR_UNSPEC =3D =
0,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_GET_PEER_RESP=
_ATTR_PEER_ID,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_G=
ET_PEER_RESP_ATTR_SOCKADDR_REMOTE,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-	OVPN_GET_PEER_RESP_ATTR_IPV4,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-	OVPN_GET_PEER_RESP_ATTR_IPV6,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	OVPN_GET_PEER_RESP_ATTR_LOCAL_IP,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_GET_PEER_RESP_ATTR_LOCAL=
_PORT,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_GET_PEER_=
RESP_ATTR_KEEPALIVE_INTERVAL,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-	OVPN_GET_PEER_RESP_ATTR_KEEPALIVE_TIMEOUT,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	OVPN_GET_PEER_RESP_ATTR_VPN_RX_BYTES,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_GET_PEER_RESP_ATTR_V=
PN_TX_BYTES,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_GET=
_PEER_RESP_ATTR_VPN_RX_PACKETS,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-	OVPN_GET_PEER_RESP_ATTR_VPN_TX_PACKETS,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-	OVPN_GET_PEER_RESP_ATTR_LINK_RX_BYTES,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_GET_PEER_RESP_ATTR_LIN=
K_TX_BYTES,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_GET_=
PEER_RESP_ATTR_LINK_RX_PACKETS,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-	OVPN_GET_PEER_RESP_ATTR_LINK_TX_PACKETS,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    OVPN_GET_PEER_RESP_ATTR_UNSPEC =3D 0,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_GET_PEER_R=
ESP_ATTR_PEER_ID,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  OVPN_GET_PEER_RESP_ATTR_SOCKADDR_REMOTE,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    OVPN_GET_PEER_RESP_ATTR_IPV4,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    OVPN_GET_PEER_RESP_ATTR_IPV6,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_GET_PEER_RESP_A=
TTR_LOCAL_IP,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OV=
PN_GET_PEER_RESP_ATTR_LOCAL_PORT,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    OVPN_GET_PEER_RESP_ATTR_KEEPALIVE_INTERVAL,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    OVPN_GET_PEER_RESP_ATTR_KEEPA=
LIVE_TIMEOUT,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OV=
PN_GET_PEER_RESP_ATTR_VPN_RX_BYTES,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    OVPN_GET_PEER_RESP_ATTR_VPN_TX_BYTES,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    OVPN_GET_PEER_RESP_ATTR_VPN_RX_PA=
CKETS,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_GET_=
PEER_RESP_ATTR_VPN_TX_PACKETS,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    OVPN_GET_PEER_RESP_ATTR_LINK_RX_BYTES,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    OVPN_GET_PEER_RESP_ATTR_LINK_TX_BYTES=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_GET_PEER_=
RESP_ATTR_LINK_RX_PACKETS,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    OVPN_GET_PEER_RESP_ATTR_LINK_TX_PACKETS,</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-	__OVPN_GET_PEER_RESP_ATTR_=
AFTER_LAST,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_GET_=
PEER_RESP_ATTR_MAX =3D __OVPN_GET_PEER_RESP_ATTR_AFTER_LAST - 1,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    __OVPN_GET_PEER_RESP_ATTR_=
AFTER_LAST,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN=
_GET_PEER_RESP_ATTR_MAX =3D __OVPN_GET_PEER_RESP_ATTR_AFTER_LAST - 1,</span=
><br><span> };</span><br><span> </span><br><span> enum ovpn_netlink_peer_st=
ats_attrs {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_PEER=
_STATS_ATTR_UNSPEC =3D 0,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-	OVPN_PEER_STATS_BYTES,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-	OVPN_PEER_STATS_PACKETS,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    OVPN_PEER_STATS_ATTR_UNSPEC =3D 0,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    OVPN_PEER_STATS_BYTES,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    OVPN_PEER_STATS_PACKETS,</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-	__OVPN_PEER=
_STATS_ATTR_AFTER_LAST,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-	OVPN_PEER_STATS_ATTR_MAX =3D __OVPN_PEER_STATS_ATTR_AFTER_LAST - 1,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    __OVPN_PEER_STATS_AT=
TR_AFTER_LAST,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    O=
VPN_PEER_STATS_ATTR_MAX =3D __OVPN_PEER_STATS_ATTR_AFTER_LAST - 1,</span><b=
r><span> };</span><br><span> </span><br><span> enum ovpn_netlink_peer_attrs=
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_PEER_ATTR_UNS=
PEC =3D 0,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_PEER_=
ATTR_PEER_ID,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_PE=
ER_ATTR_SOCKADDR_REMOTE,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-	OVPN_PEER_ATTR_IPV4,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-	OVPN_PEER_ATTR_IPV6,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-	OVPN_PEER_ATTR_LOCAL_IP,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-	OVPN_PEER_ATTR_KEEPALIVE_INTERVAL,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-	OVPN_PEER_ATTR_KEEPALIVE_TIMEOUT,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-	OVPN_PEER_ATTR_ENCRYPT_KEY,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-	OVPN_PEER_ATTR_DECRYPT_KEY,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_PEER_ATTR_RX_STATS,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_PEER_ATTR_TX_STAT=
S,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_PEER_ATT=
R_UNSPEC =3D 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
OVPN_PEER_ATTR_PEER_ID,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    OVPN_PEER_ATTR_SOCKADDR_REMOTE,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    OVPN_PEER_ATTR_IPV4,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    OVPN_PEER_ATTR_IPV6,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    OVPN_PEER_ATTR_LOCAL_IP,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    OVPN_PEER_ATTR_KEEPALIVE_INTERVA=
L,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_PEER_ATT=
R_KEEPALIVE_TIMEOUT,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    OVPN_PEER_ATTR_ENCRYPT_KEY,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    OVPN_PEER_ATTR_DECRYPT_KEY,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    OVPN_PEER_ATTR_RX_STATS,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    OVPN_PEER_ATTR_TX_STATS,</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-	__OVPN_PEER_ATT=
R_AFTER_LAST,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_PE=
ER_ATTR_MAX =3D __OVPN_PEER_ATTR_AFTER_LAST - 1,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    __OVPN_PEER_ATTR_AFTER_LAST,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    OVPN_PEER_ATTR_MAX =3D __OVPN=
_PEER_ATTR_AFTER_LAST - 1,</span><br><span> };</span><br><span> </span><br>=
<span> enum ovpn_netlink_packet_attrs {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-	OVPN_PACKET_ATTR_UNSPEC =3D 0,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-	OVPN_PACKET_ATTR_PACKET,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	OVPN_PACKET_ATTR_PEER_ID,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    OVPN_PACKET_ATTR_UNSPEC =3D 0,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_PACKET_ATTR_=
PACKET,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_PAC=
KET_ATTR_PEER_ID,</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-	__OVPN_PACKET_ATTR_AFTER_LAST,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-	OVPN_PACKET_ATTR_MAX =3D __OVPN_PACKET_ATTR_AFTER_=
LAST - 1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    __OVPN=
_PACKET_ATTR_AFTER_LAST,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    OVPN_PACKET_ATTR_MAX =3D __OVPN_PACKET_ATTR_AFTER_LAST - 1,</span>=
<br><span> };</span><br><span> </span><br><span> enum ovpn_ifla_attrs {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-	IFLA_OVPN_UNSPEC =3D 0,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-	IFLA_OVPN_MODE,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    IFLA_OVPN_UNSPEC =3D =
0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    IFLA_OVPN_MOD=
E,</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-	=
__IFLA_OVPN_AFTER_LAST,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-	IFLA_OVPN_MAX =3D __IFLA_OVPN_AFTER_LAST - 1,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    __IFLA_OVPN_AFTER_LAST,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    IFLA_OVPN_MAX =3D __IFLA_OVPN_AFTE=
R_LAST - 1,</span><br><span> };</span><br><span> </span><br><span> enum ovp=
n_mode {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	__OVPN_MODE_=
FIRST =3D 0,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_MOD=
E_P2P =3D __OVPN_MODE_FIRST,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-	OVPN_MODE_MP,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    __OVPN_MODE_FIRST =3D 0,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    OVPN_MODE_P2P =3D __OVPN_MODE_FIRST,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    OVPN_MODE_MP,</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-	__OVPN_MODE_AFTER_LAST,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    __OVPN_MODE_AFTER_=
LAST,</span><br><span> };</span><br><span> </span><br><span> #endif /* _UAP=
I_LINUX_OVPN_DCO_H_ */</span><br><span>diff --git a/src/openvpn/ovpn_dco_wi=
n.h b/src/openvpn/ovpn_dco_win.h</span><br><span>index ea2a733..e8bd074 100=
644</span><br><span>--- a/src/openvpn/ovpn_dco_win.h</span><br><span>+++ b/=
src/openvpn/ovpn_dco_win.h</span><br><span>@@ -3,7 +3,7 @@</span><br><span>=
  *</span><br><span>  *  Copyright (C) 2020-2021 OpenVPN Inc &lt;sales@...1696...=
15...&gt;</span><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- *  Author:	Lev Stipakov &lt;lev@...515...&gt;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *  Author:     Lev Stipakov &lt;lev@...493...=
515...&gt;</span><br><span>  *</span><br><span>  *  This program is free so=
ftware; you can redistribute it and/or modify</span><br><span>  *  it under=
 the terms of the GNU General Public License version 2</span><br><span>@@ -=
29,76 +29,76 @@</span><br><span> #include &lt;ws2ipdef.h&gt;</span><br><spa=
n> </span><br><span> typedef enum {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-	OVPN_PROTO_UDP,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-	OVPN_PROTO_TCP</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    OVPN_PROTO_UDP,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    OVPN_PROTO_TCP</span><br><span> } OVPN_PROTO;</span><br><span> </s=
pan><br><span> typedef struct _OVPN_NEW_PEER {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-	union {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-		SOCKADDR_IN Addr4;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-		SOCKADDR_IN6 Addr6;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-	} Local;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    union {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 SOCKADDR_IN Addr4;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        SOCKADDR_IN6 Addr6;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    } Local;</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-	union {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-		SOCKADDR_IN Addr4;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-		SOCKADDR_IN6 Addr6;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-	} Remote;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    un=
ion {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        SOCKAD=
DR_IN Addr4;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 SOCKADDR_IN6 Addr6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    } Remote;</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-	OVPN_PROTO Proto;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-} OVPN_NEW_PEER, * POVPN_NEW_PEER;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    OVPN_PROTO Proto;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+} OVPN_NEW_PEER, *POVPN_NEW_PEER;</span><br><span>=
 </span><br><span> typedef struct _OVPN_STATS {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-	LONG LostInControlPackets;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	LONG LostOutControlPackets;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    LONG LostInControlPackets;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    LONG LostOutControl=
Packets;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-	LONG LostInDataPackets;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-	LONG LostOutDataPackets;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    LONG LostInDataPackets;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    LONG LostOutDataPackets;</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-	LONG ReceivedDataPackets;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-	LONG ReceivedControlPa=
ckets;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    LONG Rece=
ivedDataPackets;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 LONG ReceivedControlPackets;</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-	LONG SentControlPackets;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	LONG SentDataPackets;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    LONG SentControlPackets;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    LONG SentDataPackets;</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-	LONG64 T=
ransportBytesSent;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	LO=
NG64 TransportBytesReceived;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    LONG64 TransportBytesSent;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    LONG64 TransportBytesReceived;</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-	LONG64 TunBytesSent;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-	LONG64 TunBytesReceived=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-} OVPN_STATS, * POVP=
N_STATS;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    LONG64 =
TunBytesSent;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    LO=
NG64 TunBytesReceived;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+} OVPN_STATS, *POVPN_STATS;</span><br><span> </span><br><span> typedef e=
num _OVPN_KEY_SLOT {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	=
OVPN_KEY_SLOT_PRIMARY,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-	OVPN_KEY_SLOT_SECONDARY</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    OVPN_KEY_SLOT_PRIMARY,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    OVPN_KEY_SLOT_SECONDARY</span><br><span> } OVPN_KEY_SLOT;<=
/span><br><span> </span><br><span> typedef enum _OVPN_CIPHER_ALG {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_CIPHER_ALG_NONE,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_CIPHER_ALG_AES_GCM,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_CIPHER_ALG_CHACHA20=
_POLY1305</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_C=
IPHER_ALG_NONE,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
OVPN_CIPHER_ALG_AES_GCM,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    OVPN_CIPHER_ALG_CHACHA20_POLY1305</span><br><span> } OVPN_CIPHER_A=
LG;</span><br><span> </span><br><span> typedef struct _OVPN_KEY_DIRECTION</=
span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	uns=
igned char Key[32];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	u=
nsigned char KeyLen; // 16/24/32 -&gt; AES-128-GCM/AES-192-GCM/AES-256-GCM<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-	unsigned char NonceTa=
il[8];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned =
char Key[32];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    un=
signed char KeyLen;     /* 16/24/32 -&gt; AES-128-GCM/AES-192-GCM/AES-256-G=
CM */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned c=
har NonceTail[8];</span><br><span> } OVPN_KEY_DIRECTION;</span><br><span> <=
/span><br><span> typedef struct _OVPN_CRYPTO_DATA {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	OVPN_KEY_DIRECTION Encrypt;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-	OVPN_KEY_DIRECTION Decrypt;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_KEY_SLOT KeySlot;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_CIPHER_ALG CipherAlg;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	unsigned char KeyId;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	int PeerId;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-} OVPN_CRYPTO_DATA, * POVPN_CR=
YPTO_DATA;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_=
KEY_DIRECTION Encrypt;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    OVPN_KEY_DIRECTION Decrypt;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    OVPN_KEY_SLOT KeySlot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    OVPN_CIPHER_ALG CipherAlg;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    unsigned char KeyId;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    int PeerId;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+} OVPN_CRYPTO_DATA, *POVPN_CRYPTO_DATA;<=
/span><br><span> </span><br><span> typedef struct _OVPN_SET_PEER {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-	LONG KeepaliveInterval;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-	LONG KeepaliveTimeout;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-	LONG MSS;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-} OVPN_SET_PEER, * POVPN_SET_PEER;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    LONG KeepaliveInt=
erval;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    LONG Keep=
aliveTimeout;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    LO=
NG MSS;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+} OVPN_SET_P=
EER, *POVPN_SET_PEER;</span><br><span> </span><br><span> typedef struct _OV=
PN_VERSION {</span><br><span>     LONG Major;</span><br><span></span><br></=
pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/432?=
usp=3Demail">change 432</a>. To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><=
div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/432?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id5c50dc754837ddb9a9414d8f38=
982f75e99bace </div>
<div style=3D"display:none"> Gerrit-Change-Number: 432 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;a@...2181...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--eMmhxVPf3D4=--

