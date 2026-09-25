Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13EF4C9830D
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 06:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SeTX1ppH01lccBHYoDluUI1SUylrbapu1My61IuKEs4=; b=k6gcqSy6SHEFgi+3Y/fraeiodo
	albUUczWadBwGuKA05v53tcvt6JL71Swn2qgsB2McOYmFMEWcEp1N3P6uHNLeWzLchccuTlhH/20J
	nFVp7/HHuP5X6LKqfSyRY8srL8p/ESt3kqRgwqB28bDRsiBJQxQbUDY4C9TuzaqRiYio=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9z3T-0003uI-D2;
	Fri, 25 Sep 2026 06:05:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1x9z3S-0003u5-25
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 06:05:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fyDOoV80LddEb4WpM1AbyeCv/Bnq/dGBk+skXR9gMgc=; b=kQmDB7pIcJLe7Xuo68WoVNT3Me
 8Ne94A96BAxEA+uOyXsDnQEj2AMGsrc2aXvZ2Iol6LVy5cDvV/g8jzVgU29/ZKni2HUlZHAOMiWkY
 M+CfenU0Zso5c4m24fXw3GH9TO3dR5ZQcNkBcwpFn4iK02DowxPBMZBoIGP6dYIj1aN0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fyDOoV80LddEb4WpM1AbyeCv/Bnq/dGBk+skXR9gMgc=; b=k6cwkzOukLvj9+FVafjmkIu0YO
 +DyM+8tIFQxCRJA5d9BC7kKn5fBLyEL28LUuO9lQW6c4WiT0RdUYAp12yx/3AZW3VWmUO2c7at/qZ
 sQzXNMVMkkf4eE1h2dfXQL4B8/5/Xabj6IpqDqpZH+2y4ez4cdyX4kEH3Z5NQRJE93HE=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x9z3R-0004qM-6N for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 06:05:06 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 68P64w6n002251
 for <openvpn-devel@lists.sourceforge.net>; Fri, 25 Sep 2026 08:04:58 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 68P64w30002250
 for openvpn-devel@lists.sourceforge.net; Fri, 25 Sep 2026 08:04:58 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 25 Sep 2026 08:04:52 +0200
Message-ID: <20260925060457.2236-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1782693360000.Ia7894fc360b12c5a0f63fad2abb9bbb1ad9c2bd5@gerrit.openvpn.net>
References: <gerrit.1782693360000.Ia7894fc360b12c5a0f63fad2abb9bbb1ad9c2bd5@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1x9z3R-0004qM-6N
Subject: [Openvpn-devel] [PATCH v1] dco_linux: read multicast notifications
 on a dedicated netlink socket
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

From: Antonio Quartulli <antonio@mandelbit.com>

ovpn-dco shared a single netlink socket for both synchronous
request/reply transactions (peer create/delete/get, key operations,
stats) and the asynchronous multicast notification group (peer
del/float, key swap). Because every ovpn_nl_msg_send() drains its reply
with nl_recvmsgs() on that same socket, a notification queued by the
kernel could be dispatched re-entrantly in the middle of an unrelated
request/reply: the NL_CB_VALID handler runs ovpn_handle_msg() ->
multi_process_incoming_dco() -> multi_close_instance() while the caller
is still walking an instance collection. For example multi_print_status()
refreshes stats with dco_get_peer_stats_multi() and then iterates
m->hash, and multi_delete_dup() iterates m->instances[] while closing
duplicates; an instance freed underneath either iterator becomes a
use-after-free and the server crashes (observed under mass simultaneous
client reconnects).

Subscribe the multicast group on a dedicated socket (nl_sock_notify) and
read it only from dco_read_and_process(), the top-level event-loop point
where closing an instance is safe. The request/reply socket is no longer
a member of the group, so parsing a command or stats reply can never
dispatch a notification. The event loop now monitors the notification
socket; the request/reply socket keeps being drained synchronously by
ovpn_nl_msg_send().

Change-Id: Ia7894fc360b12c5a0f63fad2abb9bbb1ad9c2bd5
GitHub: closes OpenVPN/openvpn#1067
Signed-off-by: Antonio Quartulli <antonio.quartulli@openvpn.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1737
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1737
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 40746bd..7a0f620 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -134,12 +134,8 @@
 }
 
 static int
-ovpn_nl_recvmsgs(dco_context_t *dco, const char *prefix)
+ovpn_nl_recvmsgs_report(int ret, const char *prefix)
 {
-    __is_locked = true;
-    int ret = nl_recvmsgs(dco->nl_sock, dco->nl_cb);
-    __is_locked = false;
-
     switch (ret)
     {
         case -NLE_INTR:
@@ -174,6 +170,16 @@
     return ret;
 }
 
+static int
+ovpn_nl_recvmsgs(dco_context_t *dco, const char *prefix)
+{
+    __is_locked = true;
+    int ret = nl_recvmsgs(dco->nl_sock, dco->nl_cb);
+    __is_locked = false;
+
+    return ovpn_nl_recvmsgs_report(ret, prefix);
+}
+
 /**
  * Send a prepared netlink message.
  *
@@ -398,9 +404,11 @@
     }
 
     /* Register for ovpn-dco specific multicast messages that the kernel may
-     * send
+     * send. These are subscribed on the dedicated notification socket only, so
+     * that they are never delivered while a request/reply transaction on
+     * dco->nl_sock is being parsed.
      */
-    int ret = nl_socket_add_membership(dco->nl_sock, dco->ovpn_dco_mcast_id);
+    int ret = nl_socket_add_membership(dco->nl_sock_notify, dco->ovpn_dco_mcast_id);
     if (ret)
     {
         msg(M_FATAL, "%s: failed to join groups: %d", __func__, ret);
@@ -449,17 +457,49 @@
     nl_cb_set(dco->nl_cb, NL_CB_ACK, NL_CB_CUSTOM, ovpn_nl_cb_finish, &dco->status);
     nl_cb_set(dco->nl_cb, NL_CB_VALID, NL_CB_CUSTOM, ovpn_handle_msg, dco);
 
+    /* Set up the dedicated multicast notification socket. It shares the message
+     * handler (ovpn_handle_msg) with the request/reply socket, but is read only
+     * from dco_read_and_process() in the event loop, so notifications never
+     * fire while a request/reply transaction is being parsed. */
+    dco->nl_sock_notify = nl_socket_alloc();
+    if (!dco->nl_sock_notify)
+    {
+        msg(M_FATAL, "Cannot create netlink notification socket");
+    }
+
+    ret = genl_connect(dco->nl_sock_notify);
+    if (ret)
+    {
+        msg(M_FATAL, "Cannot connect to generic netlink (notify): %s", nl_geterror(ret));
+    }
+
+    set_cloexec(nl_socket_get_fd(dco->nl_sock_notify));
+    set_nonblock(nl_socket_get_fd(dco->nl_sock_notify));
+
+    dco->nl_cb_notify = nl_cb_alloc(NL_CB_DEFAULT);
+    if (!dco->nl_cb_notify)
+    {
+        msg(M_FATAL, "failed to allocate netlink notification callback");
+    }
+
+    nl_socket_set_cb(dco->nl_sock_notify, dco->nl_cb_notify);
+    nl_cb_err(dco->nl_cb_notify, NL_CB_CUSTOM, ovpn_nl_cb_error, &dco->status);
+    nl_cb_set(dco->nl_cb_notify, NL_CB_VALID, NL_CB_CUSTOM, ovpn_handle_msg, dco);
+
     ovpn_dco_register(dco);
 
     /* The async PACKET messages confuse libnl and it will drop them with
      * wrong sequence numbers (NLE_SEQ_MISMATCH), so disable libnl's sequence
-     * number check */
+     * number check. Multicast notifications are unsolicited and likewise carry
+     * no matching sequence number, so disable the check on both sockets. */
     nl_socket_disable_seq_check(dco->nl_sock);
+    nl_socket_disable_seq_check(dco->nl_sock_notify);
 
     /* nl library sets the buffer size to 32k/32k by default which is sometimes
      * overrun with very fast connecting/disconnecting clients.
      * TODO: fix this in a better and more reliable way */
     ASSERT(!nl_socket_set_buffer_size(dco->nl_sock, 1024 * 1024, 1024 * 1024));
+    ASSERT(!nl_socket_set_buffer_size(dco->nl_sock_notify, 1024 * 1024, 1024 * 1024));
 }
 
 bool
@@ -495,8 +535,12 @@
     nl_socket_free(dco->nl_sock);
     dco->nl_sock = NULL;
 
+    nl_socket_free(dco->nl_sock_notify);
+    dco->nl_sock_notify = NULL;
+
     /* Decrease reference count */
     nl_cb_put(dco->nl_cb);
+    nl_cb_put(dco->nl_cb_notify);
 
     CLEAR(dco);
 }
@@ -1164,7 +1208,13 @@
 {
     msg(D_DCO_DEBUG, __func__);
 
-    return ovpn_nl_recvmsgs(dco, __func__);
+    /* Drain the multicast notification socket. This is the only place where
+     * asynchronous notifications (peer del/float, key swap) are processed, so
+     * the multi_close_instance() they may trigger happens at a safe point in
+     * the event loop rather than re-entrantly inside a request/reply. */
+    int ret = nl_recvmsgs(dco->nl_sock_notify, dco->nl_cb_notify);
+
+    return ovpn_nl_recvmsgs_report(ret, __func__);
 }
 
 static int
@@ -1326,9 +1376,12 @@
 void
 dco_event_set(dco_context_t *dco, struct event_set *es, void *arg)
 {
-    if (dco && dco->nl_sock)
+    if (dco && dco->nl_sock_notify)
     {
-        event_ctl(es, nl_socket_get_fd(dco->nl_sock), EVENT_READ, arg);
+        /* Only the notification socket is monitored by the event loop. The
+         * request/reply socket (dco->nl_sock) is drained synchronously by
+         * ovpn_nl_msg_send(). */
+        event_ctl(es, nl_socket_get_fd(dco->nl_sock_notify), EVENT_READ, arg);
     }
 }
 
diff --git a/src/openvpn/dco_linux.h b/src/openvpn/dco_linux.h
index e3e4824..c487581 100644
--- a/src/openvpn/dco_linux.h
+++ b/src/openvpn/dco_linux.h
@@ -62,8 +62,18 @@
 
 typedef struct
 {
+    /* socket used for synchronous request/reply transactions (commands and
+     * stats queries). It is NOT subscribed to the multicast group, so its
+     * recvmsgs never dispatch an asynchronous notification. */
     struct nl_sock *nl_sock;
     struct nl_cb *nl_cb;
+    /* socket dedicated to multicast notifications (peer del/float, key swap).
+     * It is read only at the top-level dco_read_and_process() point, where it
+     * is safe to close instances. Keeping it separate from nl_sock prevents
+     * notifications from being processed re-entrantly while a request/reply is
+     * in flight. */
+    struct nl_sock *nl_sock_notify;
+    struct nl_cb *nl_cb_notify;
     int status;
 
     struct context *c;


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
