Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25024606A323
	for <openvpn-devel@archiver.kernel.org>; Tue, 20 Oct 2026 15:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=HIHvAg+G;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=HXu6m5fN;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=LCKJgUQb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rLVAY/MQodlerZGsncbaSVY5hhSx9j72KNejYFiDdss=; b=HIHvAg+GnpSLSxkxcAJJwYO0Kc
	TrpWMcWs9pvD9aZhj1eUp6O90gQLYvMl814IPmFNJ+adtV9Yudr04yALShfUSHc68Jkp+3nJ1fE1U
	xJce6SVhwT4O9PWVoGCw6mdMpwfMKaqV4awVu1fWDvB0DH2WZonPM+IX26eWQwDl0Ft8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xJBkg-0000DV-JG;
	Tue, 20 Oct 2026 15:27:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xJBkf-0000DP-95
 for openvpn-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 15:27:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=P3mkniU5Bl9jbUONJSNLIsYeWvQ4hD1EWKB0FHfM2WU=; b=HXu6m5fNhwaM1YGr2Bc/K8KZmK
 nW/xdIiDarf1Iui66+1Va/BYG+fVoJ3eJacqXbUcjgQVdsBCi3BVCygJvEOFMyEf3+75SRMNB4CyN
 j+/eCxNCh3XCAp2wQju0X8teubuAljHAKk8244nn2aSpOwsDq7imJIP/v+ZSe78fZIpU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=P3mkniU5Bl9jbUONJSNLIsYeWvQ4hD1EWKB0FHfM2WU=; b=LCKJgUQbmCuR/en6yLGTO2zY2+
 JICW74a3cO1ju+xJPzqhpo6KEhvSRVwNNhR89fgPKJxS7TlmickjdIRb8RO94KetVlBqr2Su+Q15l
 nI3P8UX5pRCXlVbha2seps9T9HWjP5qkcUjrtryvnCTXaBSA9jDMLmlM7DoQpr5J5VR4=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xJBkY-0008GG-SN for openvpn-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 15:27:42 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69KFRWUf004309
 for <openvpn-devel@lists.sourceforge.net>; Tue, 20 Oct 2026 17:27:32 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69KFRW8Z004308
 for openvpn-devel@lists.sourceforge.net; Tue, 20 Oct 2026 17:27:32 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 20 Oct 2026 17:27:24 +0200
Message-ID: <20261020152730.4293-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1792405183000.I149d0ba7011e62a115a565813e1f5873907d464e@gerrit.openvpn.net>
References: <gerrit.1792405183000.I149d0ba7011e62a115a565813e1f5873907d464e@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xJBkY-0008GG-SN
Subject: [Openvpn-devel] [PATCH v2] automake: Add build-tests recursive
 target
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

So that we can build unit-tests without running them.
Something automake doesn't seem to offer out of the
box.

Change-Id: I149d0ba7011e62a115a565813e1f5873907d464e
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2022
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2022
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/configure.ac b/configure.ac
index 52b0d20..8bf2c8a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -47,6 +47,8 @@
 AC_CANONICAL_HOST
 AC_USE_SYSTEM_EXTENSIONS
 
+AM_EXTRA_RECURSIVE_TARGETS([build-tests])
+
 AX_CODE_COVERAGE
 
 AC_ARG_ENABLE(
diff --git a/tests/unit_tests/example_test/Makefile.am b/tests/unit_tests/example_test/Makefile.am
index 1ae80c8..942e9d1 100644
--- a/tests/unit_tests/example_test/Makefile.am
+++ b/tests/unit_tests/example_test/Makefile.am
@@ -15,3 +15,5 @@
 example2_testdriver_CFLAGS  = @TEST_CFLAGS@
 example2_testdriver_LDFLAGS = @TEST_LDFLAGS@
 example2_testdriver_SOURCES = test2.c
+
+build-tests-local: $(check_PROGRAMS)
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index 38299f5..43a6743 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -445,3 +445,5 @@
 	$(top_srcdir)/src/openvpn/env_set.c \
 	$(top_srcdir)/src/openvpn/run_command.c \
 	$(top_srcdir)/src/openvpn/socket_util.c
+
+build-tests-local: $(check_PROGRAMS)
diff --git a/tests/unit_tests/openvpnserv/Makefile.am b/tests/unit_tests/openvpnserv/Makefile.am
index 19de666..210c9e6 100644
--- a/tests/unit_tests/openvpnserv/Makefile.am
+++ b/tests/unit_tests/openvpnserv/Makefile.am
@@ -14,3 +14,5 @@
 	$(top_srcdir)/src/openvpnserv/validate.c \
 	$(top_srcdir)/src//openvpn/wfp_block.c \
 	$(top_srcdir)/src//openvpn/wfp_block.h
+
+build-tests-local: $(check_PROGRAMS)
diff --git a/tests/unit_tests/plugins/auth-pam/Makefile.am b/tests/unit_tests/plugins/auth-pam/Makefile.am
index 7da299c..fd7cf91 100644
--- a/tests/unit_tests/plugins/auth-pam/Makefile.am
+++ b/tests/unit_tests/plugins/auth-pam/Makefile.am
@@ -12,3 +12,5 @@
 auth_pam_testdriver_SOURCES = test_search_and_replace.c  $(top_srcdir)/src/plugins/auth-pam/utils.h $(top_srcdir)/src/plugins/auth-pam/utils.c
 auth_pam_testdriver_CFLAGS  = @TEST_CFLAGS@ -I$(top_srcdir)/src/plugins/auth-pam
 auth_pam_testdriver_LDFLAGS = @TEST_LDFLAGS@
+
+build-tests-local: $(check_PROGRAMS)


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
