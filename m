Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64561606A909
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 17:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=i/w/ueNM;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=OUmUqVqh;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=kxmEJ2ja;
	dkim=neutral header.d=lichtenheld.com header.i=@lichtenheld.com header.a=rsa-sha256 header.s=MBO0001 header.b=j5RTW8Uh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=13D7nJbKGpsykU8Lm3aEqdXrsSHZfzSAqZ5c+ucaceg=; b=i/w/ueNMYGV+8f
	w/5+H+20xGf15OJsYgT5PoCsq8gjsbR2FodHbD2dEs537UNsAE0/KmnCG2ViUrDJKLNXLWrW6TxTF
	1K2oq0xoKEzV0FTXaVxj7k4I1PkdgkzjW8Go6kwrOV3goSi/gSwXzVocK2qBCqd2tm0A2nrWeKEAh
	vWU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNvTW-000000001R5-0MLm;
	Mon, 02 Nov 2026 17:05:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <frank@lichtenheld.com>) id 1xNvTU-000000001Qw-1hkc
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 17:05:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BT7iEXWv6nDbhnTO2OfKSw/a7OBHZm1jFk/V8w9mFmc=; b=OUmUqVqhVz2GvWM951xE/5Iw6h
 iL4J2EyIcmdWrxtBOKElV4dCFIBxixTPpcl+HPwx038YEZ87zqdHn2sn+ZaxdWdu/IYIV9pGX+BgP
 S9X73rrDzbNECWkVq2tfMBvmsyHp55Fw9iYf/+PVp0Q0a3UWpGCXa1k5VyfUlovgE+rU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BT7iEXWv6nDbhnTO2OfKSw/a7OBHZm1jFk/V8w9mFmc=; b=kxmEJ2jaKIiYUF3aAhESXztJS4
 XtkcuOFqGYzw1dWkJxdgfGul8zCMv6bOoz0OoMWPktwXWmB+a/r09FwYvml5iPjKpBq54ulZtxm0g
 5AZ4xzzjlrxYv2f7AKgQTHU7rAkMyrH2MJwnKce6AMzto/fBhf+N1qlMt5W5wrA10gbs=;
Received: from mout-p-201.mailbox.org ([80.241.56.171])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNvTS-0000000065H-2yua for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 17:05:36 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jJJ462bB3zMlPN
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 18:05:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lichtenheld.com;
 s=MBO0001; t=1793639126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BT7iEXWv6nDbhnTO2OfKSw/a7OBHZm1jFk/V8w9mFmc=;
 b=j5RTW8UhBGkec7z3dSF96LWENBLuEHeuP4Oi7eRvzi4qSJdzRVscVd7HNE22eTmNl9jhTQ
 IofbaXbJRMfYxbK0qCg4f0LUq1WPO//X885IRNQDmlZUMJ5+YLmE40lgaB74Mwrj9VodEN
 aQGMGi+Jk8xIe55wF9ctXIxkB3PMvwZXQaSPG+pkqWQBdNvoCxCdwzBlx9yJ3+SWiqm+4u
 auqOeL08mECpVUeodKJsjS8uSeC4wjv7yOy1K6U8C2V04pxEHoOiFR9FTgno8Ee2Ed6ESP
 gBahE6EYN2DhOfMXMx1O/epFmE924oglrtqxaujfWXlEzwM0xJlV1ngjqMaPVQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of frank@lichtenheld.com designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=frank@lichtenheld.com
From: Frank Lichtenheld <frank@lichtenheld.com>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  2 Nov 2026 18:05:25 +0100
Message-ID: <20261102170525.112032-1-frank@lichtenheld.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <gerrit.1793625001000.I73efe00fddbd919897489c975ec65ed4b4628cc8@gerrit.openvpn.net>
References: <gerrit.1793625001000.I73efe00fddbd919897489c975ec65ed4b4628cc8@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jJJ462bB3zMlPN
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xNvTS-0000000065H-2yua
Subject: [Openvpn-devel] [PATCH v2] dns: close first pipe if creating the
 second one fails
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Razvan Cojocaru <razvanc@mailbox.org>

run_updown_runner() leaked dns_pipe_fd when pipe(ack_pipe_fd) failed.

Broken since 1dfe8729 ("dns: support running up/down command with
privsep").

Change-Id: I73efe00fddbd919897489c975ec65ed4b4628cc8
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2091
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2091
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index e5ed1bc..abe30ed 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -608,11 +608,18 @@
 {
     int dns_pipe_fd[2];
     int ack_pipe_fd[2];
-    if (pipe(dns_pipe_fd) != 0 || pipe(ack_pipe_fd) != 0)
+    if (pipe(dns_pipe_fd) != 0)
     {
         msg(M_WARN | M_ERRNO, "run_dns_up_down: unable to create pipes");
         return false;
     }
+    if (pipe(ack_pipe_fd) != 0)
+    {
+        msg(M_WARN | M_ERRNO, "run_dns_up_down: unable to create pipes");
+        close(dns_pipe_fd[0]);
+        close(dns_pipe_fd[1]);
+        return false;
+    }
     updown_runner->pid = fork();
     if (updown_runner->pid == -1)
     {


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
