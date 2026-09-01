Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE58C61DD6
	for <openvpn-devel@archiver.kernel.org>; Tue,  1 Sep 2026 07:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ipdw1LzEQ44tLSeduA1zrbugKYhwL0peqoGDPrdDAs8=; b=eEzCIifWUIVDkU21b3Y8IrdE2s
	2JIEPCG0GhCoKnldLaa5QPrYwB1VqyCP0aiiL6NmL2Uh9liwGtpT43Ku4agQHS4rB4V8IKWkCT1CB
	dku2COtwa5oqCC2ItK5XR+leVtsQcD0O2syhxy7ffeJ8A+yIAYXdv9Ivd8wCedszJenQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1JP3-0000I9-VC;
	Tue, 01 Sep 2026 07:59:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1x1JOd-0000Hc-1Z
 for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 07:59:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xqH+b1nbve8DwDNmnvSNyqEnOK/UBYcusdRUYeWGDj8=; b=DYB0Q0iIenF6GG5Zi5mmVdOAsZ
 ezT3he4s3KyYhqldFIFug/mX8uL+eqJ2Kw4qqSpoYA5pgRFEqRcUNzx4AqLlUPeg9kBCl9F+AxvOW
 IHTHUyHZiyBoQeQH0oq2FZOXRlmmZRfLCQ9hm+M90DqM4lcAqd4V/aIegdIRcdGvwKmo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xqH+b1nbve8DwDNmnvSNyqEnOK/UBYcusdRUYeWGDj8=; b=CbdDrGlN5alT1eK1fyCNgzIFRd
 QCFPWjMfgw4mIFpkhrKFz9TAKN5DBxQlNOIL54RdInpEGKPttfu5dJpA6bC9qM+hLUWZNL3Pm5sZ0
 YG37FysC6285iEEEATUMhghZo1PQFpNZGPjhs8o5kcyI8T966twg5+PIFGWlTzoH6PnU=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x1JOb-0006u3-Rg for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 07:59:07 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6817wxTg011229
 for <openvpn-devel@lists.sourceforge.net>; Tue, 1 Sep 2026 09:58:59 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6817ww8E011228
 for openvpn-devel@lists.sourceforge.net; Tue, 1 Sep 2026 09:58:58 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue,  1 Sep 2026 09:58:49 +0200
Message-ID: <20260901075858.11210-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1783977723000.Ie7352dd136cccda2bd6b6e1a36db1a5f27afd8f7@gerrit.openvpn.net>
References: <gerrit.1783977723000.Ie7352dd136cccda2bd6b6e1a36db1a5f27afd8f7@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1x1JOb-0006u3-Rg
Subject: [Openvpn-devel] [PATCH v2] networking_sitnl: validate netlink
 replies against the request
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

sitnl_send() passed every well-formed reply to the callback without
checking it matched the outstanding request: the seq/pid check was
commented out and the sequence number came from time(NULL).

Seed a monotonically increasing sequence number and drop any message
that is not from the kernel (nl_pid 0) or does not echo our port id and
sequence number.

Change-Id: Ie7352dd136cccda2bd6b6e1a36db1a5f27afd8f7
GitHub: fixes OpenVPN/openvpn-private-issues#9
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
Acked-by: Ralf Lici <ralf@mandelbit.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1782
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1782
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Ralf Lici <ralf@mandelbit.com>

        
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index e6e72d0..7d623a4 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -197,7 +197,7 @@
  * Bind socket to Netlink subsystem
  */
 static int
-sitnl_bind(int fd, uint32_t groups)
+sitnl_bind(int fd, uint32_t groups, uint32_t *local_pid)
 {
     socklen_t addr_len;
     struct sockaddr_nl local;
@@ -232,6 +232,14 @@
         return -EINVAL;
     }
 
+    /* We bound with nl_pid=0, so the kernel assigned this socket a unique port
+     * id (it is not the process pid - a process may own several netlink
+     * sockets). getsockname() above is the only way to learn it: hand it back
+     * to the caller, which uses it to check that replies are addressed to this
+     * socket.
+     */
+    *local_pid = local.nl_pid;
+
     return 0;
 }
 
@@ -243,6 +251,7 @@
            void *arg_cb)
 {
     int fd, ret;
+    uint32_t local_pid = 0;
     struct sockaddr_nl nladdr;
     struct nlmsgerr *err;
     struct nlmsghdr *h;
@@ -264,11 +273,17 @@
     nladdr.nl_pid = peer;
     nladdr.nl_groups = groups;
 
-    /* NB: We currently do not verify seq and pid on answers.
-     * If we ever want to start with that we probably need to come up
-     * with something better than "seconds since epoch"...
+    /* Match replies to requests with a monotonically increasing sequence
+     * number, seeded once from wall-clock time so it differs between runs.
+     * The kernel echoes this seq (and our port id) in its replies, letting the
+     * receive loop below discard any unrelated or spoofed message.
      */
-    payload->nlmsg_seq = (uint32_t)time(NULL);
+    static uint32_t sitnl_seq;
+    if (!sitnl_seq)
+    {
+        sitnl_seq = (uint32_t)time(NULL);
+    }
+    uint32_t seq = payload->nlmsg_seq = ++sitnl_seq;
 
     /* no need to send reply */
     if (!cb)
@@ -283,7 +298,7 @@
         return -errno;
     }
 
-    if (sitnl_bind(fd, 0) < 0)
+    if (sitnl_bind(fd, 0, &local_pid) < 0)
     {
         msg(M_WARN | M_ERRNO, "%s: can't bind rtnl socket", __func__);
         ret = -errno;
@@ -357,18 +372,22 @@
                 goto out;
             }
 
-            /*            if (((int)nladdr.nl_pid != peer) || (h->nlmsg_pid != nladdr.nl_pid)
-             *               || (h->nlmsg_seq != seq))
-             *           {
-             *               rcv_len -= NLMSG_ALIGN(len);
-             *               h = (struct nlmsghdr *)((char *)h + NLMSG_ALIGN(len));
-             *               msg(M_DEBUG, "%s: skipping unrelated message. nl_pid:%d (peer:%d)
-             * nl_msg_pid:%d nl_seq:%d seq:%d",
-             *                   __func__, (int)nladdr.nl_pid, peer, h->nlmsg_pid,
-             *                   h->nlmsg_seq, seq);
-             *               continue;
-             *           }
+            /* Discard any message that did not come from the kernel or does
+             * not match the request we sent: only the kernel (nl_pid 0) can
+             * legitimately reply, and a valid reply echoes our port id and
+             * sequence number. This prevents a local process from injecting a
+             * spoofed reply that the callback would otherwise act on.
              */
+            if ((nladdr.nl_pid != 0) || (h->nlmsg_pid != local_pid)
+                || (h->nlmsg_seq != seq))
+            {
+                msg(D_RTNL,
+                    "%s: skipping unrelated message. nl_pid:%u nlmsg_pid:%u (local:%u) nlmsg_seq:%u (seq:%u)",
+                    __func__, nladdr.nl_pid, h->nlmsg_pid, local_pid, h->nlmsg_seq, seq);
+                rcv_len -= NLMSG_ALIGN(len);
+                h = (struct nlmsghdr *)((char *)h + NLMSG_ALIGN(len));
+                continue;
+            }
 
             if (h->nlmsg_type == NLMSG_DONE)
             {


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
