Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A24CA5FE4
	for <openvpn-devel@archiver.kernel.org>; Sat,  3 Oct 2026 20:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A5H/26v0mk5zHZRQizBZ9vLGOv9Nen4iRnsbNBKcFtg=; b=Yi2j31GmQtxL8J5GzZV/tYagQ4
	aX9oQGQPxFUzzklR9/KQtiz27hW0lyV17Guod9iBnHuFzImc8+0nJf2scossCD7D8LqKqw4FPBjRL
	hw3rqfugJ3wKkUCHCXPuKp6XO65sviDL102aZU0w5yu7aFkNXIDxN8YSzWqXWoBh/tQY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xD6aG-0004eK-Qo;
	Sat, 03 Oct 2026 20:43:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xD6aF-0004eC-3s
 for openvpn-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 20:43:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yYszwfxfXWhZcVR5sEeyBiR43i3qdavBNHJIDnVK1Iw=; b=immBxO60M9YVFoCxrIwRKhQZiU
 ZoKiOz1AAbSLQA1ffL3jc+fk2O6nm+715qow5TjDiZpRPgGSgCHXvOtBqvM6EHgH/2Jwc6SFTEZLj
 nAwwlf0np2NY58cvt+iSetW6HJridV2t/HXUCaiPncT4X77btY7xt8oGjzmRXqeteo5s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yYszwfxfXWhZcVR5sEeyBiR43i3qdavBNHJIDnVK1Iw=; b=dg9EwfG2ZkhGKMU+7O94iRjgn0
 gcWb1hVjWrf83p1I/TwUB3bUfck+bLo5RleX6n1vi16VYuD5NOHdLAuBewkG8LchVvbKVI8Grlkfb
 5I3LvWvO8692XM6zYUWr1xPEdm1rNGUkygk829jAgT0CgEyJgS017lc1VeNsvnV1hOG8=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xD6aE-000680-5S for openvpn-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 20:43:51 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 693KhhU1019522
 for <openvpn-devel@lists.sourceforge.net>; Sat, 3 Oct 2026 22:43:43 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 693Khhov019521
 for openvpn-devel@lists.sourceforge.net; Sat, 3 Oct 2026 22:43:43 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sat,  3 Oct 2026 22:43:37 +0200
Message-ID: <20261003204342.19505-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1790610390000.I0b39d6a0fb2e6dbb683e9555f0365353c4eda8d3@gerrit.openvpn.net>
References: <gerrit.1790610390000.I0b39d6a0fb2e6dbb683e9555f0365353c4eda8d3@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1xD6aE-000680-5S
Subject: [Openvpn-devel] [PATCH v3] Fix all occurrences of cppcheck
 invalidPrintfArgType_sint
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

From: Frank Lichtenheld <frank@lichtenheld.com>

Mostly trivially correct. The only exception is socklen_t which
can be of various types. In Linux it is uint32_t and in all cases
it should be a small unsigned number. So print it as that.

Change-Id: I0b39d6a0fb2e6dbb683e9555f0365353c4eda8d3
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1958
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1958
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/dev-tools/cppcheck-suppressions.xml b/dev-tools/cppcheck-suppressions.xml
index c3d81d8..12521e1 100644
--- a/dev-tools/cppcheck-suppressions.xml
+++ b/dev-tools/cppcheck-suppressions.xml
@@ -9,9 +9,6 @@
     <id>constParameterCallback</id>
   </suppress>
   <suppress>
-    <id>invalidPrintfArgType_sint</id>
-  </suppress>
-  <suppress>
     <id>invalidPrintfArgType_uint</id>
   </suppress>
   <suppress>
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index aee18bc..8196c26 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -261,7 +261,7 @@
             if (!buf_safe(&work, buf->len + cipher_ctx_block_size(ctx->cipher)))
             {
                 msg(D_CRYPT_ERRORS,
-                    "ENCRYPT: buffer size error, bc=%d bo=%d bl=%d wc=%d wo=%d wl=%d cbs=%d",
+                    "ENCRYPT: buffer size error, bc=%d bo=%d bl=%d wc=%d wo=%d wl=%d cbs=%u",
                     buf->capacity, buf->offset, buf->len, work.capacity, work.offset, work.len,
                     cipher_ctx_block_size(ctx->cipher));
                 goto err;
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index b023ade..4412ad0 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -231,7 +231,7 @@
     {
         remotestr = print_sockaddr(remoteaddr, &gc);
     }
-    msg(D_DCO_DEBUG, "%s: peer-id %d, fd %d, remote addr: %s", __func__, peerid, sd, remotestr);
+    msg(D_DCO_DEBUG, "%s: peer-id %u, fd %d, remote addr: %s", __func__, peerid, sd, remotestr);
 
     struct nl_msg *nl_msg = ovpn_dco_nlmsg_create(dco, OVPN_CMD_PEER_NEW);
     struct nlattr *attr = nla_nest_start(nl_msg, OVPN_A_PEER);
@@ -574,7 +574,7 @@
 int
 dco_swap_keys(dco_context_t *dco, unsigned int peerid)
 {
-    msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, peerid);
+    msg(D_DCO_DEBUG, "%s: peer-id %u", __func__, peerid);
 
     struct nl_msg *nl_msg = ovpn_dco_nlmsg_create(dco, OVPN_CMD_KEY_SWAP);
     if (!nl_msg)
@@ -598,7 +598,7 @@
 int
 dco_del_peer(dco_context_t *dco, unsigned int peerid)
 {
-    msg(D_DCO_DEBUG | M_NOIPREFIX, "%s: peer-id %d", __func__, peerid);
+    msg(D_DCO_DEBUG | M_NOIPREFIX, "%s: peer-id %u", __func__, peerid);
 
     struct nl_msg *nl_msg = ovpn_dco_nlmsg_create(dco, OVPN_CMD_PEER_DEL);
     if (!nl_msg)
@@ -623,7 +623,7 @@
 dco_del_key(dco_context_t *dco, unsigned int peerid, dco_key_slot_t slot)
 {
     int ret = -EMSGSIZE;
-    msg(D_DCO_DEBUG, "%s: peer-id %d, slot %d", __func__, peerid, slot);
+    msg(D_DCO_DEBUG, "%s: peer-id %u, slot %d", __func__, peerid, slot);
 
     struct nl_msg *nl_msg = ovpn_dco_nlmsg_create(dco, OVPN_CMD_KEY_DEL);
     if (!nl_msg)
@@ -648,7 +648,7 @@
             const uint8_t *encrypt_key, const uint8_t *encrypt_iv, const uint8_t *decrypt_key,
             const uint8_t *decrypt_iv, const char *ciphername, bool epoch)
 {
-    msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %d, cipher %s, epoch %d", __func__, slot, keyid, peerid,
+    msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %u, cipher %s, epoch %d", __func__, slot, keyid, peerid,
         ciphername, epoch);
 
     const size_t key_len = cipher_kt_key_size(ciphername);
@@ -701,7 +701,7 @@
 dco_set_peer(dco_context_t *dco, unsigned int peerid, int keepalive_interval, int keepalive_timeout,
              int mss)
 {
-    msg(D_DCO_DEBUG, "%s: peer-id %d, keepalive %d/%d, mss %d", __func__, peerid,
+    msg(D_DCO_DEBUG, "%s: peer-id %u, keepalive %d/%d, mss %d", __func__, peerid,
         keepalive_interval, keepalive_timeout, mss);
 
     struct nl_msg *nl_msg = ovpn_dco_nlmsg_create(dco, OVPN_CMD_PEER_SET);
@@ -968,7 +968,7 @@
     uint32_t ifindex = nla_get_u32(attrs[OVPN_A_IFINDEX]);
     if (ifindex != dco->ifindex)
     {
-        msg(D_DCO_DEBUG, "ovpn-dco: ignoring message for foreign ifindex %d", ifindex);
+        msg(D_DCO_DEBUG, "ovpn-dco: ignoring message for foreign ifindex %u", ifindex);
         return false;
     }
 
@@ -1010,7 +1010,7 @@
     int reason = nla_get_u32(dp_attrs[OVPN_A_PEER_DEL_REASON]);
     unsigned int peerid = nla_get_u32(dp_attrs[OVPN_A_PEER_ID]);
 
-    msg(D_DCO_DEBUG | M_NOIPREFIX, "ovpn-dco: received CMD_PEER_DEL_NTF, ifindex: %d, peer-id %u, reason: %d",
+    msg(D_DCO_DEBUG | M_NOIPREFIX, "ovpn-dco: received CMD_PEER_DEL_NTF, ifindex: %u, peer-id %u, reason: %d",
         dco->ifindex, peerid, reason);
     dco->dco_message_peer_id = peerid;
     dco->dco_del_peer_reason = reason;
@@ -1097,7 +1097,7 @@
     int key_id = nla_get_u16(dp_attrs[OVPN_A_KEYCONF_KEY_ID]);
     unsigned int peer_id = nla_get_u32(dp_attrs[OVPN_A_KEYCONF_PEER_ID]);
 
-    msg(D_DCO_DEBUG, "ovpn-dco: received CMD_KEY_SWAP_NTF, ifindex: %d, peer-id %u, key-id: %d",
+    msg(D_DCO_DEBUG, "ovpn-dco: received CMD_KEY_SWAP_NTF, ifindex: %u, peer-id %u, key-id: %d",
         dco->ifindex, peer_id, key_id);
     dco->dco_message_peer_id = peer_id;
     dco->dco_message_key_id = key_id;
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index e605867..c01a4e5 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -56,7 +56,7 @@
         {
             break;
         }
-        msg(D_DCO_DEBUG, "interface %ld not yet ready, retrying", idx);
+        msg(D_DCO_DEBUG, "interface %lu not yet ready, retrying", idx);
         Sleep(50);
     }
 }
@@ -409,7 +409,7 @@
              struct sockaddr *localaddr, struct sockaddr *remoteaddr,
              const struct in_addr *vpn_ipv4, const struct in6_addr *vpn_ipv6)
 {
-    msg(D_DCO_DEBUG, "%s: peer-id %d, fd " SOCKET_PRINTF, __func__, peerid, sd);
+    msg(D_DCO_DEBUG, "%s: peer-id %u, fd " SOCKET_PRINTF, __func__, peerid, sd);
 
     if (dco->ifmode == DCO_MODE_P2P)
     {
@@ -460,7 +460,7 @@
 int
 dco_del_peer(dco_context_t *dco, unsigned int peerid)
 {
-    msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, peerid);
+    msg(D_DCO_DEBUG, "%s: peer-id %u", __func__, peerid);
 
     OVPN_MP_DEL_PEER del_peer = { peerid };
     VOID *buf = NULL;
@@ -487,7 +487,7 @@
 dco_set_peer(dco_context_t *dco, unsigned int peerid, int keepalive_interval, int keepalive_timeout,
              int mss)
 {
-    msg(D_DCO_DEBUG, "%s: peer-id %d, keepalive %d/%d, mss %d", __func__, peerid,
+    msg(D_DCO_DEBUG, "%s: peer-id %u, keepalive %d/%d, mss %d", __func__, peerid,
         keepalive_interval, keepalive_timeout, mss);
 
     OVPN_MP_SET_PEER mp_peer = { peerid, keepalive_interval, keepalive_timeout, mss };
@@ -522,7 +522,7 @@
             const uint8_t *encrypt_key, const uint8_t *encrypt_iv, const uint8_t *decrypt_key,
             const uint8_t *decrypt_iv, const char *ciphername, bool epoch)
 {
-    msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %d, cipher %s", __func__, slot, keyid, peerid,
+    msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %u, cipher %s", __func__, slot, keyid, peerid,
         ciphername);
 
     const int nonce_len = 8;
@@ -575,7 +575,7 @@
 int
 dco_del_key(dco_context_t *dco, unsigned int peerid, dco_key_slot_t slot)
 {
-    msg(D_DCO, "%s: peer-id %d, slot %d called but ignored", __func__, peerid, slot);
+    msg(D_DCO, "%s: peer-id %u, slot %d called but ignored", __func__, peerid, slot);
     /* FIXME: Implement in driver first */
     return 0;
 }
@@ -583,7 +583,7 @@
 int
 dco_swap_keys(dco_context_t *dco, unsigned int peer_id)
 {
-    msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, peer_id);
+    msg(D_DCO_DEBUG, "%s: peer-id %u", __func__, peer_id);
 
     OVPN_MP_SWAP_KEYS swap = { peer_id };
     DWORD ioctl = OVPN_IOCTL_SWAP_KEYS;
@@ -667,7 +667,7 @@
     BOOL res = GetOverlappedResult(dco->tt->hand, &dco->ov, &bytes_read, FALSE);
     if (res)
     {
-        msg(D_DCO_DEBUG, "%s: completion%s success [%ld]", __func__, queued ? "" : " non-queued",
+        msg(D_DCO_DEBUG, "%s: completion%s success [%lu]", __func__, queued ? "" : " non-queued",
             bytes_read);
 
         dco->dco_message_peer_id = dco->notif_buf.PeerId;
@@ -1016,7 +1016,7 @@
         .Addr.Addr4.S_un.S_addr = dst, .Netbits = netbits, .PeerId = peer_id, .IPv6 = 0
     };
 
-    msg(D_DCO_DEBUG, "%s: %s/%d -> peer %d", __func__, print_in_addr_t(dst, IA_NET_ORDER, &gc),
+    msg(D_DCO_DEBUG, "%s: %s/%u -> peer %u", __func__, print_in_addr_t(dst, IA_NET_ORDER, &gc),
         netbits, peer_id);
 
     DWORD bytes_returned = 0;
@@ -1037,7 +1037,7 @@
 
     OVPN_MP_IROUTE route = { .Addr.Addr6 = dst, .Netbits = netbits, .PeerId = peer_id, .IPv6 = 1 };
 
-    msg(D_DCO_DEBUG, "%s: %s/%d -> peer %d", __func__, print_in6_addr(dst, IA_NET_ORDER, &gc),
+    msg(D_DCO_DEBUG, "%s: %s/%u -> peer %u", __func__, print_in6_addr(dst, IA_NET_ORDER, &gc),
         netbits, peer_id);
 
     DWORD bytes_returned = 0;
@@ -1059,7 +1059,7 @@
         .Addr.Addr4.S_un.S_addr = dst, .Netbits = netbits, .PeerId = -1, .IPv6 = 0
     };
 
-    msg(D_DCO_DEBUG, "%s: %s/%d", __func__, print_in_addr_t(dst, IA_NET_ORDER, &gc), netbits);
+    msg(D_DCO_DEBUG, "%s: %s/%u", __func__, print_in_addr_t(dst, IA_NET_ORDER, &gc), netbits);
 
     DWORD bytes_returned = 0;
     if (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_MP_DEL_IROUTE, &route, sizeof(route), NULL, 0,
@@ -1078,7 +1078,7 @@
 
     OVPN_MP_IROUTE route = { .Addr.Addr6 = dst, .Netbits = netbits, .PeerId = -1, .IPv6 = 1 };
 
-    msg(D_DCO_DEBUG, "%s: %s/%d", __func__, print_in6_addr(dst, IA_NET_ORDER, &gc), netbits);
+    msg(D_DCO_DEBUG, "%s: %s/%u", __func__, print_in6_addr(dst, IA_NET_ORDER, &gc), netbits);
 
     DWORD bytes_returned = 0;
     if (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_MP_DEL_IROUTE, &route, sizeof(route), NULL, 0,
diff --git a/src/openvpn/event.c b/src/openvpn/event.c
index f1492f8..5e17ea1 100644
--- a/src/openvpn/event.c
+++ b/src/openvpn/event.c
@@ -117,7 +117,7 @@
     }
     else
     {
-        msg(M_FATAL, "fatal error in we_set_events: rwflags=%d", rwflags);
+        msg(M_FATAL, "fatal error in we_set_events: rwflags=%u", rwflags);
     }
 
     wes->esr[i].rwflags = rwflags;
@@ -378,7 +378,7 @@
                 break;
 
             default:
-                msg(M_FATAL, "fatal error in we_ctl: rwflags=%d", rwflags);
+                msg(M_FATAL, "fatal error in we_ctl: rwflags=%u", rwflags);
         }
     }
     return;
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index b7913bd..2f1ca95 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -1502,7 +1502,7 @@
     }
     else if (streq(p[0], "pid"))
     {
-        msg(M_CLIENT, "SUCCESS: pid=%d", platform_getpid());
+        msg(M_CLIENT, "SUCCESS: pid=%u", platform_getpid());
     }
     else if (streq(p[0], "nclients"))
     {
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index f79b1bf..7eb3d77 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -164,7 +164,7 @@
     struct hash_iterator hi;
     struct hash_element *he;
 
-    dmsg(D_MULTI_DEBUG, "MULTI: REAP range %d -> %d", start_bucket, end_bucket);
+    dmsg(D_MULTI_DEBUG, "MULTI: REAP range %u -> %u", start_bucket, end_bucket);
     hash_iterator_init_range(m->vhash, &hi, start_bucket, end_bucket);
     while ((he = hash_iterator_next(&hi)) != NULL)
     {
@@ -271,7 +271,7 @@
     struct multi_context *m = t->multi;
     int dev = DEV_TYPE_UNDEF;
 
-    msg(D_MULTI_LOW, "MULTI: multi_init called, r=%d v=%d", t->options.real_hash_size,
+    msg(D_MULTI_LOW, "MULTI: multi_init called, r=%u v=%u", t->options.real_hash_size,
         t->options.virtual_hash_size);
 
     /*
@@ -430,7 +430,7 @@
         if (mi->context.c2.tls_multi && check_debug_level(D_DCO_DEBUG)
             && dco_enabled(&mi->context.options))
         {
-            buf_printf(&out, " rx-peer-id=%d", mi->context.c2.tls_multi->rx_peer_id);
+            buf_printf(&out, " rx-peer-id=%u", mi->context.c2.tls_multi->rx_peer_id);
         }
         return BSTR(&out);
     }
@@ -735,7 +735,7 @@
     if (hash_n_elements(m->hash) >= m->max_clients)
     {
         msg(D_MULTI_ERRORS,
-            "MULTI: new incoming connection would exceed maximum number of clients (%d)",
+            "MULTI: new incoming connection would exceed maximum number of clients (%u)",
             m->max_clients);
         goto err;
     }
@@ -996,7 +996,7 @@
 #ifdef ENABLE_ASYNC_PUSH
     if (m->inotify_watchers)
     {
-        msg(D_MULTI_DEBUG, "inotify watchers count: %d", hash_n_elements(m->inotify_watchers));
+        msg(D_MULTI_DEBUG, "inotify watchers count: %u", hash_n_elements(m->inotify_watchers));
     }
 #endif
 }
@@ -1302,7 +1302,7 @@
         }
         for (ir6 = mi->context.options.iroutes_ipv6; ir6 != NULL; ir6 = ir6->next)
         {
-            msg(D_MULTI_LOW, "MULTI: internal route %s/%d -> %s",
+            msg(D_MULTI_LOW, "MULTI: internal route %s/%u -> %s",
                 print_in6_addr(ir6->network, 0, &gc), ir6->netbits,
                 multi_instance_string(mi, false, &gc));
 
diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c
index 31084cb..4d9d7fb 100644
--- a/src/openvpn/multi_io.c
+++ b/src/openvpn/multi_io.c
@@ -439,7 +439,7 @@
         default:
         {
             struct gc_arena gc = gc_new();
-            msg(M_FATAL, "MULTI IO: multi_io_post bad state, mi=%s flags=%d",
+            msg(M_FATAL, "MULTI IO: multi_io_post bad state, mi=%s flags=%u",
                 multi_instance_string(mi, false, &gc), flags);
             gc_free(&gc);
             break;
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index 13e0f0b..bb29781 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -222,7 +222,7 @@
 
     if (addr_len != sizeof(local))
     {
-        msg(M_WARN, "%s: wrong address length %d", __func__, addr_len);
+        msg(M_WARN, "%s: wrong address length %u", __func__, (unsigned int)addr_len);
         return -EINVAL;
     }
 
@@ -528,7 +528,7 @@
 
     if (!if_indextoname(ifindex, res->iface))
     {
-        msg(M_WARN | M_ERRNO, "%s: rtnl: can't get ifname for index %d", __func__, ifindex);
+        msg(M_WARN | M_ERRNO, "%s: rtnl: can't get ifname for index %u", __func__, ifindex);
         return -1;
     }
 
@@ -1216,7 +1216,7 @@
         gw_ptr = &gw_be;
     }
 
-    msg(D_ROUTE, "%s: %s/%d via %s dev %s table %d metric %d", __func__,
+    msg(D_ROUTE, "%s: %s/%d via %s dev %s table %u metric %d", __func__,
         inet_ntop(AF_INET, &dst_be, dst_str, sizeof(dst_str)), prefixlen,
         inet_ntop(AF_INET, &gw_be, gw_str, sizeof(gw_str)), np(iface), table, metric);
 
@@ -1242,7 +1242,7 @@
         gw_v6.ipv6 = *gw;
     }
 
-    msg(D_ROUTE, "%s: %s/%d via %s dev %s table %d metric %d", __func__,
+    msg(D_ROUTE, "%s: %s/%d via %s dev %s table %u metric %d", __func__,
         inet_ntop(AF_INET6, &dst_v6.ipv6, dst_str, sizeof(dst_str)), prefixlen,
         inet_ntop(AF_INET6, &gw_v6.ipv6, gw_str, sizeof(gw_str)), np(iface), table, metric);
 
@@ -1293,7 +1293,7 @@
         gw_v4.ipv4 = htonl(*gw);
     }
 
-    msg(D_ROUTE, "%s: %s/%d via %s dev %s table %d metric %d", __func__,
+    msg(D_ROUTE, "%s: %s/%d via %s dev %s table %u metric %d", __func__,
         inet_ntop(AF_INET, &dst_v4.ipv4, dst_str, sizeof(dst_str)), prefixlen,
         inet_ntop(AF_INET, &gw_v4.ipv4, gw_str, sizeof(gw_str)), np(iface), table, metric);
 
@@ -1319,7 +1319,7 @@
         gw_v6.ipv6 = *gw;
     }
 
-    msg(D_ROUTE, "%s: %s/%d via %s dev %s table %d metric %d", __func__,
+    msg(D_ROUTE, "%s: %s/%d via %s dev %s table %u metric %d", __func__,
         inet_ntop(AF_INET6, &dst_v6.ipv6, dst_str, sizeof(dst_str)), prefixlen,
         inet_ntop(AF_INET6, &gw_v6.ipv6, gw_str, sizeof(gw_str)), np(iface), table, metric);
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index daa52b7..95e93da 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -4549,7 +4549,7 @@
         {
             if (netbits < 64 || netbits > 124)
             {
-                msg(msglevel, "ifconfig-ipv6: /netbits must be between 64 and 124, not '/%d'",
+                msg(msglevel, "ifconfig-ipv6: /netbits must be between 64 and 124, not '/%u'",
                     netbits);
                 goto err;
             }
@@ -5827,7 +5827,7 @@
         }
         if (netbits < 64 || netbits > 124)
         {
-            msg(msglevel, "--server-ipv6 settings: network must be between /64 and /124 (not /%d)",
+            msg(msglevel, "--server-ipv6 settings: network must be between /64 and /124 (not /%u)",
                 netbits);
 
             goto err;
@@ -5940,7 +5940,7 @@
         if (netbits < 64 || netbits > 124)
         {
             msg(msglevel,
-                "--ifconfig-ipv6-pool settings: network must be between /64 and /124 (not /%d)",
+                "--ifconfig-ipv6-pool settings: network must be between /64 and /124 (not /%u)",
                 netbits);
             goto err;
         }
diff --git a/src/openvpn/options_show.c b/src/openvpn/options_show.c
index ff090774..80d36f0 100644
--- a/src/openvpn/options_show.c
+++ b/src/openvpn/options_show.c
@@ -136,7 +136,7 @@
     msg(D_SHOW_PARMS, "  server_network = %s", print_in_addr_t(o->server_network, 0, &gc));
     msg(D_SHOW_PARMS, "  server_netmask = %s", print_in_addr_t(o->server_netmask, 0, &gc));
     msg(D_SHOW_PARMS, "  server_network_ipv6 = %s", print_in6_addr(o->server_network_ipv6, 0, &gc));
-    SHOW_INT(server_netbits_ipv6);
+    SHOW_UINT(server_netbits_ipv6);
     msg(D_SHOW_PARMS, "  server_bridge_ip = %s", print_in_addr_t(o->server_bridge_ip, 0, &gc));
     msg(D_SHOW_PARMS, "  server_bridge_netmask = %s",
         print_in_addr_t(o->server_bridge_netmask, 0, &gc));
@@ -170,8 +170,8 @@
     SHOW_INT(ifconfig_ipv6_pool_netbits);
     SHOW_INT(n_bcast_buf);
     SHOW_INT(tcp_queue_limit);
-    SHOW_INT(real_hash_size);
-    SHOW_INT(virtual_hash_size);
+    SHOW_UINT(real_hash_size);
+    SHOW_UINT(virtual_hash_size);
     SHOW_STR(client_connect_script);
     SHOW_STR(learn_address_script);
     SHOW_STR(client_disconnect_script);
@@ -444,10 +444,10 @@
 #if defined(TARGET_LINUX)
     SHOW_INT(mark);
 #endif
-    SHOW_INT(sockflags);
+    SHOW_UINT(sockflags);
 
     SHOW_INT(comp.alg);
-    SHOW_INT(comp.flags);
+    SHOW_UINT(comp.flags);
 
     SHOW_STR(route_script);
     SHOW_STR(route_default_gateway);
@@ -482,7 +482,7 @@
     SHOW_INT(management_echo_buffer_size);
     SHOW_STR(management_client_user);
     SHOW_STR(management_client_group);
-    SHOW_INT(management_flags);
+    SHOW_UINT(management_flags);
 #endif
 #ifdef ENABLE_PLUGIN
     if (o->plugin_list)
@@ -547,7 +547,7 @@
         int i;
         for (i = 0; i < MAX_PARMS; i++)
         {
-            SHOW_INT(remote_cert_ku[i]);
+            SHOW_UINT(remote_cert_ku[i]);
         }
     }
     SHOW_STR(remote_cert_eku);
@@ -567,7 +567,7 @@
         }
         gc_free(&gc);
     }
-    SHOW_INT(ssl_flags);
+    SHOW_UINT(ssl_flags);
 
     SHOW_INT(tls_timeout);
 
diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
index 6c766c2..ab581f4 100644
--- a/src/openvpn/platform.c
+++ b/src/openvpn/platform.c
@@ -580,7 +580,7 @@
         }
     }
 
-    msg(M_WARN, "Failed to create temporary file after %i attempts", attempts);
+    msg(M_WARN, "Failed to create temporary file after %u attempts", attempts);
     return NULL;
 }
 
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 8b85eac..469edb3 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -823,7 +823,7 @@
                 {
                     need_remote_ipv6_route = true;
                     msg(D_ROUTE,
-                        "ROUTE6: %s/%d overlaps IPv6 remote %s, adding host route to VPN endpoint",
+                        "ROUTE6: %s/%u overlaps IPv6 remote %s, adding host route to VPN endpoint",
                         print_in6_addr(r6->network, 0, &gc), r6->netbits,
                         print_in6_addr(*remote_host_ipv6, 0, &gc));
                 }
@@ -1355,7 +1355,7 @@
         struct buffer name2 = alloc_buf_gc(256, &gc);
 
         buf_printf(&name1, "route_ipv6_network_%d", i);
-        buf_printf(&val, "%s/%d", print_in6_addr(r6->network, 0, &gc), r6->netbits);
+        buf_printf(&val, "%s/%u", print_in6_addr(r6->network, 0, &gc), r6->netbits);
         setenv_str(es, BSTR(&name1), BSTR(&val));
 
         buf_printf(&name2, "route_ipv6_gateway_%d", i);
@@ -1803,10 +1803,10 @@
 #endif
 
 #ifndef _WIN32
-    msg(D_ROUTE, "add_route_ipv6(%s/%d -> %s metric %d) dev %s", network, r6->netbits, gateway,
+    msg(D_ROUTE, "add_route_ipv6(%s/%u -> %s metric %d) dev %s", network, r6->netbits, gateway,
         r6->metric, device);
 #else
-    msg(D_ROUTE, "add_route_ipv6(%s/%d -> %s metric %d) IF %lu", network, r6->netbits, gateway,
+    msg(D_ROUTE, "add_route_ipv6(%s/%u -> %s metric %d) IF %lu", network, r6->netbits, gateway,
         r6->metric, r6->adapter_index ? r6->adapter_index : tt->adapter_index);
 #endif
 
@@ -1832,7 +1832,7 @@
             "ROUTE6 WARNING: " PACKAGE_NAME " needs a gateway "
             "parameter for a --route-ipv6 option and no default was set via "
             "--ifconfig-ipv6 or --route-ipv6-gateway option.  Not installing "
-            "IPv6 route to %s/%d.",
+            "IPv6 route to %s/%u.",
             network, r6->netbits);
         status = 0;
         goto done;
@@ -2222,7 +2222,7 @@
     }
 #endif
 
-    msg(D_ROUTE, "delete_route_ipv6(%s/%d)", network, r6->netbits);
+    msg(D_ROUTE, "delete_route_ipv6(%s/%u)", network, r6->netbits);
 
 #if defined(TARGET_LINUX)
     int metric = -1;
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index c893c9b..df8e400 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -831,7 +831,8 @@
     else if (remote_len_af && remote_len != remote_len_af)
     {
         msg(D_LINK_ERRORS,
-            "TCP: Received strange incoming connection with unknown address length=%d", remote_len);
+            "TCP: Received strange incoming connection with unknown address length=%u",
+            (unsigned int)remote_len);
         openvpn_close_socket(new_sd);
         new_sd = SOCKET_UNDEFINED;
     }
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index 8b0f28d..f13f507 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -508,7 +508,7 @@
     }
 
     msg(D_TLS_DEBUG_LOW, "P2P mode NCP negotiation result: "
-                         "TLS_export=%d, DATA_v2=%d, rx-peer-id %d, tx-peer-id %d, epoch=%d, cipher=%s",
+                         "TLS_export=%d, DATA_v2=%d, rx-peer-id %u, tx-peer-id %u, epoch=%d, cipher=%s",
         (bool)(session->opt->crypto_flags & CO_USE_TLS_KEY_MATERIAL_EXPORT),
         multi->use_peer_id,
         multi->rx_peer_id,


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
