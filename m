Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E72ECD8CAA
	for <openvpn-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fi2O7UCOX4O52Q0no7Fz8lbHgmY1xO8ssgb944cngIk=; b=Fk6cUcgcpHdVpysL8d4o3WIwp+
	gG01cohC8QVSc2Zp5wOXrxsD+Mx0rUX+eMvhsajL3DzTsPvSc6NYF3MUt1t6XrBiunXTPAkugYq5+
	SBXO1L/LKrDT/rJLdKeL1anEEUOxcIux01iixECD7qgLKp9b3e3jR/GUw5S2mKJumZ2s=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWxIy-0005QN-AT;
	Tue, 09 Jun 2026 14:19:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wWxIs-0005Pm-IG
 for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 14:19:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5LYgL4RGkssCknz9+wtTlcxo0oJaaCCJk5mV4vUG91o=; b=IkYd/Jyg0zqiodi+w0YLHJw3/H
 OO4j8WFjlJv1RzRVD5UWt7FMaydbGaU9lQWWh/VMK6ElxxrTulwqN0jXSLlK8VMUf4PtCcY27fVDO
 FwJippe5splMYTJnQN+amk2bxcFAcUogytODwWdKvs6S1g6CjJxd1NSlaG4NZ1jkihEs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5LYgL4RGkssCknz9+wtTlcxo0oJaaCCJk5mV4vUG91o=; b=f75IW4eMlK+Fra7D5Aax7MLryl
 ko+8AhdPRgXBKir9be/z5QYg+GKUOaXN3fwRsi0ug8VEAhXuemwjkaUa9mGmHc0CcST1EGWPDJ4Cs
 GnYCZzfZkJ9xt4hTGXq6ToXF62GIhTIkXM4Lk2ecgQY4MWZzwlFLxeKstDPKY2pjftbA=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wWxIr-00014z-FK for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 14:19:43 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6599ipeP028681
 for <openvpn-devel@lists.sourceforge.net>; Tue, 9 Jun 2026 11:44:51 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6599ipku028680
 for openvpn-devel@lists.sourceforge.net; Tue, 9 Jun 2026 11:44:51 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue,  9 Jun 2026 11:44:42 +0200
Message-ID: <20260609094450.28667-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1779265416000.I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f@gerrit.openvpn.net>
References: <gerrit.1779265416000.I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wWxIr-00014z-FK
Subject: [Openvpn-devel] [PATCH v5] dco: remove iroute at client exit time
 instead of delayed exit
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

When a client exits due to one of the following reasons:
* EEN received
* AUTH_FAILED sent
* RESTART sent
OpenVPN will perform some minimal cleanup and will
then postpone the actual instance purge by 5 seconds.

If iroutes are configured for the exiting client, the actual DCO
iroutes removal is also postponed.

If during this time window the same client reconnects, a new
instance is created (for example because --duplicate-cn is set or
because the same username is provided upon authentication) and the
same IP is assigned, then OpenVPN will:

* create the new client instance;
* attempt adding the related DCO iroutes (which will fail because
  EEXIST);
* 5 seconds timeout fires -> execute the delayed exit routine and
  delete the DCO iroutes;
* no iroutes exists anymore on the server despite the client being
  fully connected.

Note that this issue is DCO specific, because without DCO OpenVPN
creates virtual routes (no system routing table involved) and makes
the last connecting client own them.
This means that the delayed exit routine won't have any iroute to
delete.

With this patch we move the DCO iroutes deletion to the actual
client exit time in order to avoid racing with a possible addition
being executed when the client reconnects. The new flow will be:

* client exits (due to EEN or timeout)
* DCO iroutes are immediately deleted
* client re-connects -> new instance created
* DCO iroutes are added -> SUCCESS
* 5 seconds timeout fires -> old instance client is fully purged
* client is connected and iroutes are in place as expected

This issue was reported by OpenVPN Access Server developers after
observing erratic iroutes disappearance with DCO in place.

Change-Id: I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f
GitHub: closes openvpn/OpenVPN#1040
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1683
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1683
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@rfc2549.org>

        
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 1e6638b..403ba2f 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -733,6 +733,7 @@
     }
     ASSERT(TUNNEL_TYPE(c->c1.tuntap) == DEV_TYPE_TUN);
 
+    msg(D_DCO, "DCO: attempt removing iroutes from system table");
 
     if (c->c2.push_ifconfig_defined)
     {
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 27cfd36..6c5ab4d 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -525,7 +525,7 @@
  * Schedule a SIGTERM signal c->options.scheduled_exit_interval seconds from now.
  */
 bool
-schedule_exit(struct context *c)
+schedule_exit(openvpn_net_ctx_t *net_ctx, struct context *c)
 {
     const int n_seconds = c->options.scheduled_exit_interval;
     /* don't reschedule if already scheduled. */
@@ -533,6 +533,23 @@
     {
         return false;
     }
+
+    /* DCO iroutes must be removed now, because the delay introduced by this
+     * timer can create a race condition:
+     * the same client may reconnect before the old instance is purged, leading
+     * to DCO iroutes removal *after* reconnection, thus killing the routes
+     * for the new instance too.
+     *
+     * Standard/virtual iroutes (non-DCO case) are not affected because the
+     * last connecting client claiming the iroutes takes ownership. Therefore
+     * they are not removed during delayed cleanup.
+     */
+    if (c->did_dco_iroutes)
+    {
+        c->did_dco_iroutes = false;
+        dco_delete_iroutes(net_ctx, c);
+    }
+
     tls_set_single_session(c->c2.tls_multi);
     update_time();
     reset_coarse_timers(c);
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 0d3e492..374e1df 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -331,7 +331,7 @@
 void process_ip_header(struct context *c, unsigned int flags, struct buffer *buf,
                        struct link_socket *sock);
 
-bool schedule_exit(struct context *c);
+bool schedule_exit(openvpn_net_ctx_t *net_ctx, struct context *c);
 
 static inline struct link_socket_info *
 get_link_socket_info(struct context *c)
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index a72dcd1..ac9b986 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -479,7 +479,12 @@
     const struct iroute *ir;
     const struct iroute_ipv6 *ir6;
 
-    dco_delete_iroutes(&m->top.net_ctx, &mi->context);
+    /* check if DCO iroutes were already removed when scheduling a delayed exit */
+    if (mi->context.did_dco_iroutes)
+    {
+        mi->context.did_dco_iroutes = false;
+        dco_delete_iroutes(&m->top.net_ctx, &mi->context);
+    }
 
     if (TUNNEL_TYPE(mi->context.c1.tuntap) == DEV_TYPE_TUN)
     {
@@ -1278,6 +1283,8 @@
     if (TUNNEL_TYPE(mi->context.c1.tuntap) == DEV_TYPE_TUN)
     {
         mi->did_iroutes = true;
+        /* multi_learn_in{6}_addr_t takes care of installing the DCO iroute */
+        mi->context.did_dco_iroutes = true;
         for (ir = mi->context.options.iroutes; ir != NULL; ir = ir->next)
         {
             if (ir->netbits >= 0)
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index fa00822..5747175 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -507,6 +507,8 @@
     bool did_we_daemonize;       /**< Whether demonization has already
                                   *   taken place. */
 
+    bool did_dco_iroutes;        /**< Whether DCO iroutes have been installed */
+
     struct context_persist persist;
     /**< Persistent %context. */
     struct context_0 *c0; /**< Level 0 %context. */
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 564ce86..50053e9 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -202,7 +202,7 @@
      * */
     if (c->options.mode == MODE_SERVER)
     {
-        if (!schedule_exit(c))
+        if (!schedule_exit(&c->net_ctx, c))
         {
             /* Return early when we don't need to notify management */
             return;
@@ -392,7 +392,7 @@
 void
 send_auth_failed(struct context *c, const char *client_reason)
 {
-    if (!schedule_exit(c))
+    if (!schedule_exit(&c->net_ctx, c))
     {
         msg(D_TLS_DEBUG, "exit already scheduled for context");
         return;
@@ -493,7 +493,7 @@
 void
 send_restart(struct context *c, const char *kill_msg)
 {
-    schedule_exit(c);
+    schedule_exit(&c->net_ctx, c);
     send_control_channel_string(c, kill_msg ? kill_msg : "RESTART", D_PUSH);
 }
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
