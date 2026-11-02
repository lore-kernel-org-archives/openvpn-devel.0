Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21250606A329
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 09:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=VFq22ExL;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=QczHMH0l;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=OOrvTFsv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=GszPiThRf1VLygdPXtXKhLdyQeVmLQSiJm9YXOTTA1c=; b=VFq22ExLQxRysL
	JfD8jqz+v5crlg9VX7SV8DnXQDRutQOBoVR3wdqhFN8oODmmvFD+ZldQki7cNEPfylPWnMYsA7HIR
	eNa38RLbvTyD4yqgKJyNwqgnmwXpePOO4ytZq8Z3oRH2gsOEvKk/U9wueNXsYnd8CP7CmjVcgmaJj
	qMY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNoV2-000000003Jn-3O6j;
	Mon, 02 Nov 2026 09:38:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xNoV1-000000003Jb-35Nk for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 09:38:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wVZ+EO9P5rwvuVAunrt9Pxc2PIDO4rh1VFjHzsQ4viA=; b=QczHMH0lFmSMwv2DpbtC3Cqkp4
 3uFPkzSggb3ErEvhZy/hrxgoXEr4ta5u/pPKFdx3ltfMGkORmk3R7qhZmi+wKvH/zfvEIDN+6iCiN
 uhYeNAOrT7PlkAeptNHDYYwj5BOZJdTHjzDWN32mJgfvwU+gxQffR4hVJnpLH4TWDhZM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wVZ+EO9P5rwvuVAunrt9Pxc2PIDO4rh1VFjHzsQ4viA=; b=OOrvTFsvTZPToGhHLNvKbeEL8M
 f6AvkmMbufYzLLdeUEvAAVOW68v86zGSPzGs9xgp/t2Pjctrywx/eDT8i0QdZwoT4R2IGUjATeaFi
 oiZ4C7gQ1jaAD2cLEnT+VqiOcfTahiPT0HiwzoxXz8jy1WWnwfIBGLq6V8V/Hc/PK7is=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNoV0-000000002Ic-0BIQ for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 09:38:43 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A29cZZv029625
 for <openvpn-devel@lists.sourceforge.net>; Mon, 2 Nov 2026 10:38:35 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A29cZVg029624
 for openvpn-devel@lists.sourceforge.net; Mon, 2 Nov 2026 10:38:35 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  2 Nov 2026 10:38:27 +0100
Message-ID: <20261102093834.29593-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793450471000.I70ebdadd660e41b40ed53f4238be6885f0a7bb8b@gerrit.openvpn.net>
References: <gerrit.1793450471000.I70ebdadd660e41b40ed53f4238be6885f0a7bb8b@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xNoV0-000000002Ic-0BIQ
Subject: [Openvpn-devel] [PATCH v2] port-share: do not write journal file
 through symlinks or hardlinks
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

From: Naveed Khan <dxbnaveed.k@gmail.com>

journal_add() creates <journal dir>/<local ip:port> with
O_CREAT | O_TRUNC and writes the remote client's address into it.
The name is predictable (the proxy connection's ephemeral local port)
and the write is triggered by any TCP client sending non-OpenVPN data
to the shared port. Anyone who can create entries in the journal
directory can therefore plant symlinks or hardlinks and have the
port-share process, which runs as root unless --user is used, truncate
and overwrite an arbitrary file with the client address.

Create the journal file with O_EXCL | O_NOFOLLOW instead. Entries are
removed as soon as the proxied connection is closed, so an existing
entry is either a leftover from a proxy process that exited without
cleaning up, or something planted. Unlink it and retry the exclusive
create once, which keeps the old behavior of replacing stale entries.

Also document that the journal directory must not be writable by other
users.

Github: closes OpenVPN/openvpn#1124
Change-Id: I70ebdadd660e41b40ed53f4238be6885f0a7bb8b
Signed-off-by: Naveed Khan <dxbnaveed.k@gmail.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2074
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2074
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-options.rst
index 9dfa6bd..7a09809 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -489,6 +489,10 @@
   the origin of the connection. Each generated file will be automatically
   deleted when the proxied connection is torn down.
 
+  The files in ``dir`` are created and removed with the privileges of the
+  OpenVPN process, so ``dir`` must not be writable by any user other than
+  the one OpenVPN runs as.
+
   Not implemented on Windows.
 
 --push option
diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index 03c6f48..f8cfe1c5 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -341,7 +341,15 @@
         check_malloc_return(jfn);
         snprintf(jfn, fnlen, "%s/%s", journal_dir, t);
         dmsg(D_PS_PROXY_DEBUG, "PORT SHARE PROXY: client origin %s -> %s", jfn, f);
-        int fd = platform_open(jfn, O_CREAT | O_TRUNC | O_WRONLY, S_IRUSR | S_IWUSR | S_IRGRP);
+        /* never write through a pre-existing symlink or hardlink */
+        const int flags = O_CREAT | O_EXCL | O_WRONLY | O_NOFOLLOW;
+        int fd = platform_open(jfn, flags, S_IRUSR | S_IWUSR | S_IRGRP);
+        if (fd == -1 && errno == EEXIST)
+        {
+            /* stale entry, e.g. left behind by a killed proxy process */
+            unlink(jfn);
+            fd = platform_open(jfn, flags, S_IRUSR | S_IWUSR | S_IRGRP);
+        }
         if (fd != -1)
         {
             ssize_t write_len = strlen(f);


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
