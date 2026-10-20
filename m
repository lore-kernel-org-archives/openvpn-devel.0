Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9626A606A322
	for <openvpn-devel@archiver.kernel.org>; Tue, 20 Oct 2026 13:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=V4g5bayu;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=WjsG7aUb;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=AT8K6TER
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iaNluUfaHjMinmrApeLKdTr3Q/JlMWNqK9b7DJ4/emo=; b=V4g5bayud+tcmhMjZnMz5PrjNc
	Z0lScZQ2Lb41vy8giluuGjLATUtru+mJAZhoVhdq+XNcx6KWIYVMceZTAxriNlmtUxIl0Rc+sR0ZP
	EiGoniVtUEY0Fpi/wMLD+aclVBj5H+PxDkL+ZVB7qTPeq19ConDPO0E2wUtJaLpOzz8Q=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xJ9l1-0007ig-3a;
	Tue, 20 Oct 2026 13:19:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xJ9kz-0007iZ-4E
 for openvpn-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 13:19:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3YG9c5xq/DPftDO/TLsn/p3yOb0XD2txKa1tRuwqTq0=; b=WjsG7aUbE1buux2P/q0BgzWeWF
 O+HSvbckbtto+152RtY0lYX16D0SRrLBb0B28az8y2mNEMSh9m3ug1dsm7IEzINg3dD1l/rxIh3g9
 DCvv0jRTwYPDS+3kVZuw6f6blE4ELzyGHT5HRfF82h9mn9Wzrw6NUx5j90So5izhe1tY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3YG9c5xq/DPftDO/TLsn/p3yOb0XD2txKa1tRuwqTq0=; b=AT8K6TER9FvCXUlNwLvL3M09Nv
 VfN7R/yl4ZmOK/wlo0pep/OslueM27dafbxXpP2HCJzD5hjzfxgJF9QCcf7rDk2TACOPvFOUr39MA
 z48ngyQkOvZ1UzuFvTTdrGqedVXbMydJ7XYgGJexPMtsX6gGVg+dLyrYWu+rH/4SXw6A=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xJ9ks-0001hP-Jj for openvpn-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 13:19:54 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69KDJi0Y024908
 for <openvpn-devel@lists.sourceforge.net>; Tue, 20 Oct 2026 15:19:44 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69KDJiOk024907
 for openvpn-devel@lists.sourceforge.net; Tue, 20 Oct 2026 15:19:44 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 20 Oct 2026 15:19:36 +0200
Message-ID: <20261020131943.24892-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1792500876000.Ib92282b5a4c3c8da7b5818d3ce78e91660a13cbf@gerrit.openvpn.net>
References: <gerrit.1792500876000.Ib92282b5a4c3c8da7b5818d3ce78e91660a13cbf@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xJ9ks-0001hP-Jj
Subject: [Openvpn-devel] [PATCH v1] configure: Require automake 1.16
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Frank Lichtenheld <frank@lichtenheld.com>

Removes some ugly compat code. automake 1.16 is
in EOL distros like Ubuntu 20.04 and Debian 11,
so this should be fine on all our current distros.

Change-Id: Ib92282b5a4c3c8da7b5818d3ce78e91660a13cbf
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2024
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2024
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/configure.ac b/configure.ac
index e83aba7..52b0d20 100644
--- a/configure.ac
+++ b/configure.ac
@@ -40,21 +40,9 @@
 AC_CONFIG_SRCDIR([src/openvpn/syshead.h])
 AC_CONFIG_MACRO_DIR([m4])
 
-dnl Automake 1.14+ warns if sources are in sub-directories but subdir-objects
-dnl options is not enabled. However, automake before 1.15a has a bug that causes
-dnl variable expansion to fail in foo_SOURCES when this option is used.
-dnl As most of our build systems are now likely to use automake 1.16+ add a
-dnl work around to conditionally add subdir-objects option.
-m4_define([subdir_objects], [
-    m4_esyscmd([automake --version |
-                head -1 |
-                awk '{split ($NF,a,"."); if (a[1] == 1 && a[2] >= 16) { print "subdir-objects" }}'
-    ])
-])
-
 # This foreign option prevents autoreconf from overriding our COPYING and
 # INSTALL targets:
-AM_INIT_AUTOMAKE(foreign subdir_objects 1.9) dnl NB: Do not [quote] this parameter.
+AM_INIT_AUTOMAKE(foreign subdir-objects 1.16) dnl NB: Do not [quote] this parameter.
 AM_SILENT_RULES([yes])
 AC_CANONICAL_HOST
 AC_USE_SYSTEM_EXTENSIONS


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
