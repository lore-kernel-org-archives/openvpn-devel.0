Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D242606DA99
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 17:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=G69k/kJz;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=nPBsMNRC;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=emTum4kc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=0dpXi5QpWLBARfZERCbgkdkCIHr387YWWCbOLotHN34=; b=G69k/kJzdqdLbX
	0gMK+sEUPQR+zspjIeUowihQCavSWk4tn8avYAuOcUphH/k5KFDBKuZQWamFiLk4zrL6Q1lYDygNk
	8pJ3/Ot/Mlu9qJvwFuMdUIzUDTvJ2puQck9kj3CbH4uqBngoZGSDTVyFG9vhAxZ4WXMtDsQPNJNIn
	Uos=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTjSG-000000008Dy-3FWo;
	Wed, 18 Nov 2026 17:28:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xTjSD-000000008Dh-3IKe for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 17:28:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gch0epSebdlnsfirktfYwR8LpItWgtvbacDTOHbTIxk=; b=nPBsMNRCFwZRxt5RjHIDDb+uGo
 myW4Yiu2X+WbxLPCfN0Eau8bzP0hq3xYocmUojxxSZ/JpLmGj/CWYHHsTz3JpGFl8FzHuv4MaZnMU
 qpMB6wU5PM5ZPjymfB1xGYZy0HjQSo60gOSxEDyKgtrWqTvNDeLbLYP9mujSdTElfIRM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gch0epSebdlnsfirktfYwR8LpItWgtvbacDTOHbTIxk=; b=emTum4kcRdMYK4PL0DGz3B6wOs
 dKbEMS1m+H+HxNnuMajJy31H6HyIHMbE7yTLJQ95IDXjQwbrEC3VcyXy7g0SUrZWB5r/2bpE2ZTbx
 is7ngwv4liL+BfpkVdZEezS8OPDNgcpD701sQ3ZjMCnOCjDJpy+cGMVyloby+AMqyNW8=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTjRw-000000005RK-2Jnx for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 17:28:02 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AIHRrs5029973
 for <openvpn-devel@lists.sourceforge.net>; Wed, 18 Nov 2026 18:27:53 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AIHRrZH029972
 for openvpn-devel@lists.sourceforge.net; Wed, 18 Nov 2026 18:27:53 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 18 Nov 2026 18:27:46 +0100
Message-ID: <20261118172753.29962-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794924454000.I17fafbe65fd3ff510a72ed809c85b0d19343fad2@gerrit.openvpn.net>
References: <gerrit.1794924454000.I17fafbe65fd3ff510a72ed809c85b0d19343fad2@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xTjRw-000000005RK-2Jnx
Subject: [Openvpn-devel] [PATCH v3] multi: raise the open files limit for
 --max-clients
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

From: Gianmarco De Gregori <gianmarco@mandelbit.com>

Every TCP client takes a file descriptor and accept() happens before the
--max-clients check, so with the default limits (soft limit 1024,
--max-clients 1024) the server runs out of descriptors before it can
refuse a client.

When the server has a TCP listener, raise the soft limit to
--max-clients plus some room for the other descriptors, up to the hard
limit, and warn if that is not enough. Processes started by OpenVPN
inherit the new limit.

Not on macOS, where the event loop uses select() and cannot watch
descriptors >= FD_SETSIZE.

GitHub: closes OpenVPN/openvpn#1148
Change-Id: I17fafbe65fd3ff510a72ed809c85b0d19343fad2
Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbit.com>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2211
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2211
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-options.rst
index 7a09809..5c1b129 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -418,6 +418,9 @@
 --max-clients n
   Limit server to a maximum of ``n`` concurrent clients. Defaults to 1024.
 
+  With a TCP listener, the soft limit on open files is raised up to the hard
+  limit if needed to accept ``n`` clients (not on Windows and macOS).
+
 --max-routes-per-client n
   Allow a maximum of ``n`` internal routes per client (default
   :code:`256`). This is designed to help contain DoS attacks where an
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index ad9f9f4..900b5a3 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -270,6 +270,68 @@
 #endif
 
 /*
+ * Every TCP client takes a file descriptor, and accept() happens before the
+ * --max-clients check: raise the soft limit so that --max-clients is reached
+ * first, or warn if the hard limit does not allow it.
+ */
+static void
+multi_check_nofile_limit(const struct context *t)
+{
+#if defined(HAVE_GETRLIMIT) && defined(RLIMIT_NOFILE) && !defined(TARGET_DARWIN)
+    bool tcp = false;
+    for (int i = 0; i < t->c1.link_sockets_num; i++)
+    {
+        if (!proto_is_dgram(t->c2.link_sockets[i]->info.proto))
+        {
+            tcp = true;
+            break;
+        }
+    }
+    if (!tcp)
+    {
+        return;
+    }
+
+    /* room for the tun device, the listeners, log, management, scripts... */
+    const rlim_t needed = (rlim_t)t->options.max_clients + 64;
+
+    struct rlimit rl;
+    if (getrlimit(RLIMIT_NOFILE, &rl) < 0)
+    {
+        msg(M_WARN | M_ERRNO, "WARNING: getrlimit(RLIMIT_NOFILE) failed");
+        return;
+    }
+    if (rl.rlim_cur >= needed)
+    {
+        return;
+    }
+
+    const rlim_t old = rl.rlim_cur;
+    rl.rlim_cur = rl.rlim_max < needed ? rl.rlim_max : needed;
+    if (rl.rlim_cur > old)
+    {
+        if (setrlimit(RLIMIT_NOFILE, &rl) == 0)
+        {
+            msg(M_INFO, "NOTE: raised the open files limit from %lu to %lu", (unsigned long)old,
+                (unsigned long)rl.rlim_cur);
+        }
+        else
+        {
+            msg(M_WARN | M_ERRNO, "WARNING: setrlimit(RLIMIT_NOFILE) failed");
+            rl.rlim_cur = old;
+        }
+    }
+    if (rl.rlim_cur < needed)
+    {
+        msg(M_WARN,
+            "WARNING: the open files limit (soft %lu, hard %lu) is too low for "
+            "--max-clients %" PRIu32 ", TCP clients may be refused before --max-clients is reached",
+            (unsigned long)rl.rlim_cur, (unsigned long)rl.rlim_max, t->options.max_clients);
+    }
+#endif /* if defined(HAVE_GETRLIMIT) && defined(RLIMIT_NOFILE) && !defined(TARGET_DARWIN) */
+}
+
+/*
  * Main initialization function, init multi_context object.
  */
 static void
@@ -398,6 +460,7 @@
      * Per-client limits
      */
     m->max_clients = t->options.max_clients;
+    multi_check_nofile_limit(t);
 
     m->instances = calloc(m->max_clients, sizeof(struct multi_instance *));
     check_malloc_return(m->instances);


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
