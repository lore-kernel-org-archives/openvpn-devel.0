Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9F7606A321
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 07:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=IiyzNiRG;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=FY4a/c9k;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=cIM//mox;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XAyonPnQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=Pbm8KCH13crVJcaTFGakS1zrLeSKlEhAaIiHhv+EJvU=; b=IiyzNiRGvvnDKXpamHZu58v/J4
	x1cBmjV6i30fz0kl4Wb2ekWPkyrE7BrBjL8L1zC5g7uQpXXUQLdANfX1zkV6vAefWWkfmOam0g/4U
	VfB3t7ddA3ZkL+C8iYs2TubJYfSlpX0zfvjQQIirM/NS5IiGkS6aEMCPnkxAPClOnhx0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVlF4-000000006KA-3pGn;
	Tue, 24 Nov 2026 07:47:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <kirthikaditya@gmail.com>) id 1xVlF3-000000006K3-3XVb
 for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 07:47:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=T7VvU9H0kEDyG0aZ8fbcbLfUNBsANLU52VYlic3iz+Y=; b=FY4a/c9kE5Lzud6ysHJY9jZJto
 vcYiGvhHlKx+Op58JsoYiWaKaLzaEQU7LyQA7Gy0se3U86KdR3kJ33uTAttm1DHV2mBUYS4XqS9mk
 cgSIY9FdDNt9C50GOmeoq//6wKQ9pqtvJg5YGZLC7dN1OHXLHsoip61uJdg3FgbWLXIE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=T7VvU9H0kEDyG0aZ8fbcbLfUNBsANLU52VYlic3iz+Y=; b=cIM//moxuTt7iTYvQ7w1tw04GQ
 d2tjm3CFwWapLgnd0h/nKWXz4mqNSQjwAfEHzrG/A5vSiAQdNQaXu7XoYFkW3EyJbBQ1V8aIkV1rc
 Is00J3TWwPbA6zVcqrUCf83RQ3iRw+ReIUdz4knLeeGEjqCFSC18/7qF+bGs6vAA0sN8=;
Received: from mail-dy1-f182.google.com ([74.125.82.182])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVlF3-000000000d9-0iR4 for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 07:47:05 +0000
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-33fb4680717so11201870eec.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 23:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795506419; x=1796111219; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=T7VvU9H0kEDyG0aZ8fbcbLfUNBsANLU52VYlic3iz+Y=;
 b=XAyonPnQlymfQjzubCmU9LC3K376/2UmyAwe10nYRMQMdzw692d3tGUDdZLbHG8P6i
 LJuHg5NOYwbkmNA7FjS5EPht180wkRT/1halGJ7A862lfZ0tvvoGhsF5nOjMubj19vch
 bY/DoS0+x33wJFykJDQWvswxDgUy5lv9cQx0/DzwSyIk8Ue+68tKYkjupMixI74V9R9T
 Xh6NFo84zLaombiHCNjqyV8dub3W/uk2GONYwCIeqT6Oxg3iSCeg/rHs0MRYRsivbz+k
 PninDo3NxllrdeqeeumqG91t9KRCFIQU8Gcx0nl/8ySUIzZEr3TSQGym2NZ4ROf1Srbu
 Pxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795506419; x=1796111219;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T7VvU9H0kEDyG0aZ8fbcbLfUNBsANLU52VYlic3iz+Y=;
 b=JMoh84dxFoaLvoI0VGNGQEJHyChd1+5HtJut465MiE57RoH5KRplpC9dxCf5aJ82AR
 dI27E9kAuBxixMgwmiVEHmQpPiCjcYnq0Sd2v+QP506fq2wCmp8whBuvAt02Mrr9Ekin
 c0P2kbh4cVhc18VGX7SYw1e4qYRw4vtlX+2MC1lKw/jPMsQykmNUkvRAm9B/ebDbBVO6
 ftMdsx51GzLBC8yThVI0+t7qKspNxKdlPP+Pcd5La7UvWUOq3iV1E6NnB6RCB8RWJ6Ix
 xKEozZbke8xmrZFvFes1ddNtF0QXEk3o+7zxpPbPxdvyJd43d3LHiji64eZST0nVfuCo
 8klw==
X-Gm-Message-State: APuU4Z+z3FztlVyYY/ryhwJpFJsRZixA6n4px/NfSf3EWPwL5qaTn1jx
 43hxfi8A0uq8PoBVjv6/qwJhkinQ717AjHw37bJQJzB+Y+8v7l5fBMcvY2+gbSYZ
X-Gm-Gg: AZFdTZeglCPbUH0b6P9XK3j1b2hYQiGB6NWwKubiRb7+NHLYbJrUqbwkQVqX33dS3ry
 xvuRLE3aTcQtBZ2JYbFH1Gs2oDmWnjnrFi11X2fdRcqAjHGqb32rRAOk1ytr1qhT4aQMfLdxsHW
 nMmDdV6hsPm9ApHhk7wnOf4tVhL8VHPY7APX2u7SFovMV8BlRJTSyQ3t1f9HkJtULmRoA/MdYQC
 t4414aqlTNNrE71KqSgWELPsBGh/yihQQiPMu4nY5W1yazs3Aos0ttZyezRV+/1sJcjGjceGww0
 6smP9KHMP0qS844cSuyDo5lOmJp9w8l7bUA/iaTvMLpHf+wX3byIGWOGxxQ60LieY0GjZZXsf4U
 xdRYxHcGX/ASIlB3NX4ih/kH/3Tz7W4v+qnmyuKvAg1iW7ev9xjOnthGaDf6XIaSNEuvLI2l3q2
 euR+xXvQUwANBdq7CV1rXM61w/E8qfvSowK34z3/HUq4/EIbaK12FagBI7975WjSGMemiiv6SCG
 zxL4nNdrEtqiteEmMUf0dTs5ZMu21PMNhfzgqCcnsDj+nQRQwsC/m1MpWr9+0/DkQga9nXKS6aG
 2aWtQaJVyq/VLgtyVoJkgIr7hfDxGN2oHUQu0+dkSgpW
X-Received: by 2002:a05:7023:a41:b0:184:5f2e:aa52 with SMTP id
 a92af1059eb24-1b556894f1fmr14694989c88.16.1795506419336; 
 Mon, 23 Nov 2026 23:46:59 -0800 (PST)
Received: from localhost.localdomain ([121.200.55.39])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b55682d301sm33385920c88.10.2026.11.23.23.46.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 23:46:58 -0800 (PST)
From: Kirthik Aditya <kirthikaditya@gmail.com>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 24 Nov 2026 13:16:10 +0530
Message-ID: <20261124074641.24803-1-kirthikaditya@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xVlF3-000000000d9-0iR4
Subject: [Openvpn-devel] [PATCH] multi: send RESTART,
 [P]: on restart when auth-gen-token is used
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When a UDP server using --explicit-exit-notify restarts (SIGUSR1/SIGHUP)
or exits, it sends a bare RESTART to connected clients. OpenVPN 3
clients treat this as a request to discard their auth-token, so users
relying on SSO have to authenticate again, even when the server can
still validate their token using --auth-gen-token-secret.

When --auth-gen-token is enabled, send RESTART,[P]: instead to ask
clients to keep their auth-token across the restart. OpenVPN 3 only
recognises this exact prefix. The next-server case ([N]) is left
unchanged because OpenVPN 3 does not support it.

If the token is no longer valid after the restart, the client receives
AUTH_FAILED and falls back to normal authentication.

GitHub: closes OpenVPN/openvpn#1099

Signed-off-by: Kirthik Aditya <kirthikaditya@gmail.com>
---
Discussion: https://github.com/OpenVPN/openvpn/issues/1099
Branch: https://github.com/spryzz3n/openvpn/tree/restart-preserve-auth-token
Tested with OpenVPN 2.x client on localhost; not yet with OpenVPN Connect.

 Changes.md                          |  8 ++++++++
 doc/man-sections/client-options.rst |  6 ++++++
 src/openvpn/multi.c                 | 15 +++++++++++++--
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/Changes.md b/Changes.md
index 89a72fe4..54c6385c 100644
--- a/Changes.md
+++ b/Changes.md
@@ -2,6 +2,14 @@
 
 ## User-visible Changes
 
+* **`explicit-exit-notify` preserves auth-tokens on server restart**
+
+  When a UDP server with `--explicit-exit-notify 1` and `--auth-gen-token`
+  restarts or exits, it now sends `RESTART,[P]:` instead of a bare `RESTART`.
+  This lets OpenVPN 3 based clients (e.g. OpenVPN Connect) reconnect with
+  their auth-token instead of asking the user to authenticate again.
+  OpenVPN 2.x clients now also keep their cached username/password.
+
 * **Parsing Distinguished Names in certificates**
 
   (OpenSSL backend:) OpenVPN now rejects certificates that have a null-byte
diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-options.rst
index 16309f90..c8596c41 100644
--- a/doc/man-sections/client-options.rst
+++ b/doc/man-sections/client-options.rst
@@ -285,6 +285,12 @@ configuration.
   reconnect to the same server, with ``n`` = :code:`2` client will advance
   to the next server.
 
+  If ``--auth-gen-token`` is also used and ``n`` = :code:`1`, the server
+  sends :code:`RESTART,[P]:` instead, asking clients to keep their cached
+  credentials and auth-token. Clients can then reconnect with the token
+  without user interaction, provided the token is still valid after the
+  restart (see ``--auth-gen-token-secret``).
+
   OpenVPN will not send any exit notifications unless this option is
   enabled.
 
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 900b5a3b..c6dc932b 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3926,14 +3926,25 @@ is_exit_restart(int sig)
 static void
 multi_push_restart_schedule_exit(struct multi_context *m, bool next_server)
 {
+    /* Preserve auth-token on restart for OpenVPN 3 clients.
+     * Keep the next-server case unchanged for compatibility. */
+    const char *restart_msg = "RESTART";
+    if (next_server)
+    {
+        restart_msg = "RESTART,[N]";
+    }
+    else if (m->top.options.auth_token_generate)
+    {
+        restart_msg = "RESTART,[P]:";
+    }
+
     /* tell all clients to restart */
     for (uint32_t i = 0; i <= m->max_peerid; i++)
     {
         struct multi_instance *mi = m->instances[i];
         if (mi && !mi->halt && proto_is_dgram(mi->context.c2.link_sockets[0]->info.proto))
         {
-            send_control_channel_string(&mi->context, next_server ? "RESTART,[N]" : "RESTART",
-                                        D_PUSH);
+            send_control_channel_string(&mi->context, restart_msg, D_PUSH);
             multi_schedule_context_wakeup(m, mi);
         }
     }
-- 
2.43.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
