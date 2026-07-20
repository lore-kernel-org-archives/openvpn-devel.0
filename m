Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB152C44515
	for <openvpn-devel@archiver.kernel.org>; Mon, 20 Jul 2026 11:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oUM0gdTFNc4qMN1Crludj4ViEv9y2cK/zyTn/jD+4pM=; b=fs1NkE0oApIwKJYKWHjcuOlhRF
	2AMOYCt23cZI9PBYW6K3Gk1n3R5YJM2JEmgUOBAT0tGXtDclPsNCHepN4I8YdedexL5P/8rZ0ZpVE
	4ZqSq2nJg6gjzSvIGjZmaprd5cWNLdmEje46kCMyh9GefdRTWugbFGeuDMd6lpWk1SYY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wlmKj-0001jp-Nx;
	Mon, 20 Jul 2026 11:38:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wlmKi-0001ji-CB
 for openvpn-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 11:38:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3xZ4BDvfUTJ7v53aWVw/llOpVCZSCHkV7bYtVwdc1Dg=; b=M3UU944oVycYBQTZpl6uWhmirz
 KqZrBY2xaZSsvJ07u04/33yXz/25PVxris+Q27myqVwNUJbDFkljlrJ1ZZrgm62vZxF7xU307u0hU
 LhMVTrve88llnP2gVVI9KB02iYFyCaNDNoM24dXLjlbJA6KvEsSn2Sm8LIG6TliyCL9k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3xZ4BDvfUTJ7v53aWVw/llOpVCZSCHkV7bYtVwdc1Dg=; b=AcSBfjTH8x/LHqW2zP+mPWcgdw
 n70iic5kkSozVsz2z6mmfRoEnNWOBu9Ub/YuIoCzYdMNr1RY/O8oqpp/nVfsq9YRLvGpVoYpjCj15
 nl+qoiVwDn6CQw4h9BIf4thcNZQ9eeHESS3qWlo+6f+eERO+62aU83AseWAthcK8fCPg=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wlmKh-0006Mb-Hd for openvpn-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 11:38:53 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 66KBcc3E019707
 for <openvpn-devel@lists.sourceforge.net>; Mon, 20 Jul 2026 13:38:38 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 66KBccsC019706
 for openvpn-devel@lists.sourceforge.net; Mon, 20 Jul 2026 13:38:38 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 20 Jul 2026 13:38:32 +0200
Message-ID: <20260720113838.19668-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1784537981000.I5295e5d26c5bf60cd9607da4c804d04f2144634a@gerrit.openvpn.net>
References: <gerrit.1784537981000.I5295e5d26c5bf60cd9607da4c804d04f2144634a@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wlmKh-0006Mb-Hd
Subject: [Openvpn-devel] [PATCH v1] silence autoconf warnings about
 openvpnserv_testdriver_CFLAGS etc
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

Github: OpenVPN/openvpn#1079

Change-Id: I5295e5d26c5bf60cd9607da4c804d04f2144634a
Signed-off-by: Gert Doering <gert@greenie.muc.de>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1796
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1796
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/tests/unit_tests/openvpnserv/Makefile.am b/tests/unit_tests/openvpnserv/Makefile.am
index 6294c52..19de666 100644
--- a/tests/unit_tests/openvpnserv/Makefile.am
+++ b/tests/unit_tests/openvpnserv/Makefile.am
@@ -5,6 +5,7 @@
 if WIN32
 test_binaries = openvpnserv_testdriver
 endif
+check_PROGRAMS = $(test_binaries)
 
 openvpnserv_testdriver_CFLAGS  = -I$(top_srcdir)/include -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpnserv @TEST_CFLAGS@
 openvpnserv_testdriver_LDFLAGS = @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
