Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB7EC9830E
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 13:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qhVbFjwc9kV4TCK/1l2Faxk5ywtSBqe7zppA6pqYnlg=; b=CVnS4y2FXCoyXVtu16UbMX8knJ
	tO+IiXIQ0f3bZXrUmZwpamoc1Zb6OumpBbVoOY/KM73d5OsFuFWV8IScJBGCTp7eANZEf5TFAkZfo
	mFe6kus5HdltA0ZcLQZNGW6IsAVZs0bMfuuF0jH9ov7MH+/MeY7MYxZnuj5OnSFnHChQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xA5p1-0007bv-97;
	Fri, 25 Sep 2026 13:18:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xA5p0-0007bo-1d
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 13:18:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HrVRkpzfUqlROVmBwQk6rqfQ3h+yLnc9kI3NZg3U4Dk=; b=NUKQ9uxuVrteXmx4Jw1xBehlZH
 vv1EceT16jqv2Ja3CB3wdhl/NmGSZOYmjdHuSjIF0YaV8B+Br50X0n8Rt5wsALnyURW5UHii8Y3bR
 jaRHRhaWMAi6S9Lme/40cjrjq880lnWSGVwla4YWfRrbY5ZDxROrHoBb/A3QOhjoKY8Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HrVRkpzfUqlROVmBwQk6rqfQ3h+yLnc9kI3NZg3U4Dk=; b=KFoPdktBVkRbP90brfH+wTF2p2
 zT3bwlWbStTsu98NA3Esa+B/P22UT1sicvkAOrE9y4itGD+uNzt5nLshJYpu+rHmmZVnqeCIsJkNd
 GmD7jmqX05SGW4MEp3mf2JsP/Xx5DAeXy0CrCfIM5K6NcV0Dwy1m+9oL+bMainD+NFD4=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xA5oz-00064h-3P for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 13:18:38 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 68PDIUOn010914
 for <openvpn-devel@lists.sourceforge.net>; Fri, 25 Sep 2026 15:18:30 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 68PDIUQZ010913
 for openvpn-devel@lists.sourceforge.net; Fri, 25 Sep 2026 15:18:30 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 25 Sep 2026 15:18:24 +0200
Message-ID: <20260925131830.10902-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1782693360000.I46a9ef71359f42395d69cf899c948014fb72f65a@gerrit.openvpn.net>
References: <gerrit.1782693360000.I46a9ef71359f42395d69cf899c948014fb72f65a@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1xA5oz-00064h-3P
Subject: [Openvpn-devel] [PATCH v3] dco_linux: drop the now-redundant
 __is_locked re-entrancy guard
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

__is_locked existed only to stop setenv_stats() from issuing a GET_PEER
request/reply while the shared socket was still being drained for a batch
of notifications, which could fail with NLE_BUSY/NLE_NOMEM or re-enter
nl_recvmsgs() on the busy socket. Now that notifications are read on a
dedicated socket and GET_PEER goes to the request/reply socket, the two
never share an nl_recvmsgs() call: the request/reply socket no longer
dispatches notifications, so multi_process_incoming_dco() (the only path
that reaches dco_get_peer() during message parsing) never runs while that
socket is in flight, and the flag is always false at its check. Remove
the flag, its set/clear and the early return.

Change-Id: I46a9ef71359f42395d69cf899c948014fb72f65a
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1738
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1738
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 27f4f99..e583696 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -49,16 +49,6 @@
 #include <netlink/genl/family.h>
 #include <netlink/genl/ctrl.h>
 
-/* When parsing multiple DEL_PEER notifications, openvpn tries to request stats
- * for each DEL_PEER message (see setenv_stats). This triggers a GET_PEER
- * request-reply while we are still parsing the rest of the initial
- * notifications, which can lead to NLE_BUSY or even NLE_NOMEM.
- *
- * This basic lock ensures we don't bite our own tail by issuing a dco_get_peer
- * while still busy receiving and parsing other messages.
- */
-static bool __is_locked = false;
-
 /* libnl < 3.5.0 does not set the NLA_F_NESTED on its own, therefore we
  * have to explicitly do it to prevent the kernel from failing upon
  * parsing of the message
@@ -170,12 +160,16 @@
     return ret;
 }
 
+/**
+ * Drain the request/reply socket. Used to read command/stats replies. This
+ * socket is never subscribed to the multicast group, so it cannot deliver an
+ * asynchronous notification: a reply being parsed here can therefore never
+ * trigger an instance close or a re-entrant request on the same socket.
+ */
 static int
 ovpn_nl_recvmsgs(dco_context_t *dco, const char *prefix)
 {
-    __is_locked = true;
     int ret = nl_recvmsgs(dco->nl_sock, dco->nl_cb);
-    __is_locked = false;
 
     return ovpn_nl_recvmsgs_report(ret, prefix);
 }
@@ -1223,12 +1217,6 @@
 {
     ASSERT(dco);
 
-    if (__is_locked)
-    {
-        msg(D_DCO_DEBUG, "%s: cannot request peer stats while parsing other messages", __func__);
-        return 0;
-    }
-
     /* peer_id == -1 means "dump all peers", but this is allowed in MP mode only.
      * If it happens in P2P mode it means that the DCO peer was deleted and we
      * can simply bail out


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
