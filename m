Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75000606A319
	for <openvpn-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=PMAE2gjZ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=MaYdXh2V;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=dKVg2oJF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=CTisIMnqN/oayAl0RPW474gldyYlz1g5Rjx6rxvT4CI=; b=PMAE2gjZ23u0kn
	pjbp5EakbO+ZDRtxFe1J0ns9jZVEOfXyaHxJbrPbtPbAjJG8589k6QkG3b/UMm8Fe9zccaaY+qheL
	E+sePHZrHQmo7LS/BXQsxaUlzxEQ9NocTAaHyIpVMU1stEKjqZSxkl47eB0W4Y7Gpkk6ofXZ/RXMO
	GoI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xJs13-000000007Jl-23TV;
	Thu, 22 Oct 2026 12:35:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xJs0j-000000007JT-2eeh for openvpn-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 12:35:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KcPgG+KfsBLAAWjO7ReaOzxXynIuGgkYIt00GT5gy/k=; b=MaYdXh2VQBXpryogCQ9dAfueRB
 ypT8N7Q1NEmsrPGX2il4cvFdWbTgjzcYsw+hUIMGRa1q/OGwqKPqYnvPXdg4aY/jkVtUr33rQW2Wy
 O0F+dgpFfi+j1edW9BuYqb3EDPoYyYioBNOaw0QLiLa1K4SH86NTSN66vu6/amXv6gdg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KcPgG+KfsBLAAWjO7ReaOzxXynIuGgkYIt00GT5gy/k=; b=dKVg2oJFgjIv1uYaZX9SGTHzI3
 l80Sfb+SGRfcSyJ/xXQMHyLCu9lE875f7T/YRewGuJ5PNBLDyb7VzDs4xGCVPEjHKdHkY4ApUWESL
 Mmi70t/WwbWHqm5iqLuGBaGTtcPfB4FYpbfeT6xV8ZBmrtP3mfWlmhvuYPnslkRQd1sA=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xJs0i-000000000ql-1Ajj for openvpn-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 12:35:09 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69MCZ1uq027286
 for <openvpn-devel@lists.sourceforge.net>; Thu, 22 Oct 2026 14:35:01 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69MCZ1aI027285
 for openvpn-devel@lists.sourceforge.net; Thu, 22 Oct 2026 14:35:01 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 22 Oct 2026 14:34:55 +0200
Message-ID: <20261022123500.27256-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1792667802000.I20d367dd8251bf39856ae521f380cfdc8df64177@gerrit.openvpn.net>
References: <gerrit.1792667802000.I20d367dd8251bf39856ae521f380cfdc8df64177@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xJs0i-000000000ql-1Ajj
Subject: [Openvpn-devel] [PATCH v1] configure: Call AC_PROG_CC before
 AC_USE_SYSTEM_EXTENSIONS
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

AC_USE_SYSTEM_EXTENSIONS requires AC_PROG_CC, so the later explicit
call expanded it a second time and repeated the C standard checks
as "(cached)".

Change-Id: I20d367dd8251bf39856ae521f380cfdc8df64177
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2028
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2028
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@rfc2549.org>

        
diff --git a/configure.ac b/configure.ac
index e31a7ff..0ac61b4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -45,6 +45,11 @@
 AM_INIT_AUTOMAKE(foreign subdir-objects 1.16) dnl NB: Do not [quote] this parameter.
 AM_SILENT_RULES([yes])
 AC_CANONICAL_HOST
+AC_PROG_CC
+# AC_PROG_CC doesn't output any useful information
+AC_MSG_CHECKING([compiler version])
+CC_version=$($CC --version | head -n1)
+AC_MSG_RESULT([$CC_version])
 AC_USE_SYSTEM_EXTENSIONS
 
 AM_EXTRA_RECURSIVE_TARGETS([build-tests])
@@ -380,11 +385,6 @@
 	pkg_config_found="(${PKG_CONFIG})"
 fi
 
-AC_PROG_CC
-# AC_PROG_CC doesn't output any useful information
-AC_MSG_CHECKING([compiler version])
-CC_version=$($CC --version | head -n1)
-AC_MSG_RESULT([$CC_version])
 AC_PROG_CPP
 AC_PROG_INSTALL
 AC_PROG_LN_S


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
