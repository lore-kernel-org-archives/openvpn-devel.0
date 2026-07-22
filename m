Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E609FC44536
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 20:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L2My94H4fAcRmTDVUftwA170biUQtqwjqZNeSAmHTls=; b=M94cEkz+R89xf9cDVWtfAguF9P
	dx0NU1rMDBh77hofk9P6LuhnVUWfRyti5rkJkGrp9IOvUG2p+4bifNO5JJ+a9KvPrFeilut1Le+Kl
	8MYoN79It3s0mY85n77AE69OdOlowsGQ8jZbH3EbqltS9D1YaJ4dfGJBsIqb5tu9xhLU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmdvV-0000Tp-1C;
	Wed, 22 Jul 2026 20:52:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wmdvU-0000Tc-1Q
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 20:52:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=r79B/l67aoGavDUCoE7+cKPI6v3EVuqpZB80Xdn8SMA=; b=XlhDtXXt9M/Bsamr2lNpXKuMPE
 KpbNe3ufEScDQcBYk/8eZlgEne8QQkqPmuv5zfBSGBiamffF/+2D1wbhmaJVs5taNzbbCGdrB/9q6
 byBQEQ5Fc/GKQDJdMfyofJidbmih1910yp79YSv8nU3K5lU/KzOnfKCEmChN1zk7Z+NM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=r79B/l67aoGavDUCoE7+cKPI6v3EVuqpZB80Xdn8SMA=; b=mMs8lghLkooxuODAd1p1kKx5Ac
 oxZXcg0mkENlDFgmTwK/oSPoJJ8cB83KDk1RPywQvfH1XjhDxDaGkbkF9M+UywUkZvynN0istwLr6
 Pu7u9DMarForRRiMe3SAhE05Y/mZbhwRPy4tTezKqjLstoGnCZQ7yn7QT76N0lWUNzK0=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wmdvT-0006Po-4H for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 20:52:24 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 66MKqBhG008085
 for <openvpn-devel@lists.sourceforge.net>; Wed, 22 Jul 2026 22:52:11 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 66MKqB4W008084
 for openvpn-devel@lists.sourceforge.net; Wed, 22 Jul 2026 22:52:11 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 22 Jul 2026 22:52:05 +0200
Message-ID: <20260722205210.8060-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1784699722000.Ib18e1ed0851bc0fe6d8448e601d11d6abaa710c1@gerrit.openvpn.net>
References: <gerrit.1784699722000.Ib18e1ed0851bc0fe6d8448e601d11d6abaa710c1@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wmdvT-0006Po-4H
Subject: [Openvpn-devel] [PATCH v1] options: limit ping and keepalive values
 to one day
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

From: Marco Baffo <marco@mandelbit.com>

A correct configuration should not require such large ping intervals or
timeouts, and an upper limit of one day is already generous.

Limit --ping, --ping-exit, --ping-restart and --keepalive values to
86400 seconds. Since --keepalive doubles the timeout in server mode,
limit its timeout argument to 43200 seconds there.

Related: https://lore.kernel.org/all/20260722044756.872870-1-marco@mandelbit.com/

Change-Id: Ib18e1ed0851bc0fe6d8448e601d11d6abaa710c1
Signed-off-by: Marco Baffo <marco@mandelbit.com>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1798
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1798
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-options.rst
index df8c917..77c3c41 100644
--- a/doc/man-sections/link-options.rst
+++ b/doc/man-sections/link-options.rst
@@ -74,7 +74,9 @@
      keepalive interval timeout
 
   Send ping once every ``interval`` seconds, restart if ping is not received
-  for ``timeout`` seconds.
+  for ``timeout`` seconds. Both values are limited to 86400 seconds. Since the
+  server-side timeout is doubled, ``timeout`` is limited to 43200 seconds in
+  server mode.
 
   This option can be used on both client and server side, but it is enough
   to add this on the server side as it will push appropriate ``--ping``
@@ -247,6 +249,8 @@
   cause ping packets to be sent in both directions since OpenVPN ping
   packets are not echoed like IP ping packets).
 
+  The maximum value for ``n`` is 86400 seconds.
+
   This option has two intended uses:
 
   (1)  Compatibility with stateful firewalls. The periodic ping will ensure
@@ -264,6 +268,8 @@
   ``--inactive``, ``--ping`` and ``--ping-exit`` to create a two-tiered
   inactivity disconnect.
 
+  The maximum value for ``n`` is 86400 seconds.
+
   For example,
   ::
 
@@ -278,6 +284,8 @@
   ``n`` seconds pass without reception of a ping or other packet from
   remote.
 
+  The maximum value for ``n`` is 86400 seconds.
+
   This option is useful in cases where the remote peer has a dynamic IP
   address and a low-TTL DNS name is used to track the IP address using a
   service such as https://www.nsupdate.info/ + a dynamic DNS client such as
diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
index 4c540a6..6fd2689 100644
--- a/src/openvpn/helper.c
+++ b/src/openvpn/helper.c
@@ -563,6 +563,12 @@
             msg(M_USAGE,
                 "--keepalive conflicts with --ping, --ping-exit, or --ping-restart.  If you use --keepalive, you don't need any of the other --ping directives.");
         }
+        if (o->mode == MODE_SERVER && o->keepalive_timeout > PING_TIMEOUT_MAX / 2)
+        {
+            msg(M_USAGE,
+                "The second parameter to --keepalive must not exceed %d in server mode.",
+                PING_TIMEOUT_MAX / 2);
+        }
 
         /*
          * Expand.
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 87218d4..003b460 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -6789,24 +6789,29 @@
     else if (streq(p[0], "keepalive") && p[1] && p[2] && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        atoi_constrained(p[1], &options->keepalive_ping, "keepalive ping", 1, INT_MAX, msglevel);
-        atoi_constrained(p[2], &options->keepalive_timeout, "keepalive timeout", 1, INT_MAX, msglevel);
+        atoi_constrained(p[1], &options->keepalive_ping, "keepalive ping",
+                         1, PING_TIMEOUT_MAX, msglevel);
+        atoi_constrained(p[2], &options->keepalive_timeout, "keepalive timeout",
+                         1, PING_TIMEOUT_MAX, msglevel);
     }
     else if (streq(p[0], "ping") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_TIMER);
-        options->ping_send_timeout = positive_atoi(p[1], msglevel);
+        atoi_constrained(p[1], &options->ping_send_timeout, p[0],
+                         0, PING_TIMEOUT_MAX, msglevel);
     }
     else if (streq(p[0], "ping-exit") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_TIMER);
-        options->ping_rec_timeout = positive_atoi(p[1], msglevel);
+        atoi_constrained(p[1], &options->ping_rec_timeout, p[0],
+                         0, PING_TIMEOUT_MAX, msglevel);
         options->ping_rec_timeout_action = PING_EXIT;
     }
     else if (streq(p[0], "ping-restart") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_TIMER);
-        options->ping_rec_timeout = positive_atoi(p[1], msglevel);
+        atoi_constrained(p[1], &options->ping_rec_timeout, p[0],
+                         0, PING_TIMEOUT_MAX, msglevel);
         options->ping_rec_timeout_action = PING_RESTART;
     }
     else if (streq(p[0], "ping-timer-rem") && !p[1])
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index a111cf8..2f7fe30 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -56,6 +56,8 @@
 #define OPTION_PARM_SIZE 256
 #define OPTION_LINE_SIZE 256
 
+#define PING_TIMEOUT_MAX 86400 /* one day (in seconds) */
+
 extern const char title_string[];
 
 /* certain options are saved before --pull modifications are applied */


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
