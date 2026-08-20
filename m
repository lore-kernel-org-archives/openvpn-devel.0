Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC96BC5DF81
	for <openvpn-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vbeBxzqAepZIy+j3e0HePR/OYtk5S2NWJYviPAJaMQk=; b=bkbKdgk+zFFtKLvStZWSPmE1UD
	7oGWM5XBIkts5OysjiKoE2wlJOE0b+kWa2ev5JkCxDtykk0e93xF9anN9yGR506V019/lx4vYpQvg
	/UDd6m+sWiZ5+0emESsxuR8LxYwBNwd/27xiZnMGUtNtQJaaFjfWtSA9caaiwhP2go34=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwzlH-00080l-47;
	Thu, 20 Aug 2026 10:12:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wwzlF-00080e-Hq
 for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 10:12:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MdL+gSRTIIsxHz1mAu72q9pinRCL3fRXdMIUd0s0K4I=; b=OzJMRv2MLEzjjA/1A4BXSRBNU5
 0sDiTza4HQOUoj/s1GBCyJUVNj3bKNCdZB0DzSM7j5u/JGV1xBlKqFolRmE7YdE50jHiSjXUG8hfa
 ghg8q6l1dQLPYD8bnlsTkB1Hw+FsfevBe8ByfasslBkKvnipPzBVpKhG7nx1vKon925k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=MdL+gSRTIIsxHz1mAu72q9pinRCL3fRXdMIUd0s0K4I=; b=PQGBFICMOj9uV+8WL0yKeENof0
 cpAmBcpdQYwJq4T7bkrphVJvjb0D6n3IlZGMNpVO6rYr2oig6vyBFTMN/alunQqApS9ONpkYrqqO6
 DR1bNSgg/eNE6Cte7lfGvwt1AuaXKx9DwXnQkxBr2+CbRnq5r+BwJt8y9jKc90pGaQFA=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wwzlB-0004jh-76 for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 10:12:34 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67KACQUB009598
 for <openvpn-devel@lists.sourceforge.net>; Thu, 20 Aug 2026 12:12:26 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67KACQqj009597
 for openvpn-devel@lists.sourceforge.net; Thu, 20 Aug 2026 12:12:26 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 20 Aug 2026 12:12:21 +0200
Message-ID: <20260820101226.9581-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1787144531000.Ibb80db0547dcc0935964c9bd40222c27aac80439@gerrit.openvpn.net>
References: <gerrit.1787144531000.Ibb80db0547dcc0935964c9bd40222c27aac80439@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wwzlB-0004jh-76
Subject: [Openvpn-devel] [PATCH v2] .clang-format: Convert deprecated
 setting KeepEmptyLinesAtTheStartOfBlocks
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

From: Frank Lichtenheld <frank@lichtenheld.com>

Convert to new KeepEmptyLines settings. This adds
AtStartOfFile setting and applies it.

Change-Id: Ibb80db0547dcc0935964c9bd40222c27aac80439
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1848
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1848
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/.clang-format b/.clang-format
index 4774d1e..0823739 100644
--- a/.clang-format
+++ b/.clang-format
@@ -32,7 +32,10 @@
 IndentWidth: '4'
 IndentWrappedFunctionNames: false
 InsertBraces: true
-KeepEmptyLinesAtTheStartOfBlocks: false
+KeepEmptyLines:
+  AtEndOfFile: false
+  AtStartOfBlock: false
+  AtStartOfFile: false
 MaxEmptyLinesToKeep: '2'
 PointerAlignment: Right
 ReflowComments: true
diff --git a/src/openvpn/crypto_mbedtls.h b/src/openvpn/crypto_mbedtls.h
index 04346a9..5c3b670 100644
--- a/src/openvpn/crypto_mbedtls.h
+++ b/src/openvpn/crypto_mbedtls.h
@@ -1,4 +1,3 @@
-
 /*
  *  OpenVPN -- An application to securely tunnel IP networks
  *             over a single TCP/UDP port, with support for SSL/TLS-based
diff --git a/src/openvpnserv/validate.h b/src/openvpnserv/validate.h
index 12150f1..2da41dc 100644
--- a/src/openvpnserv/validate.h
+++ b/src/openvpnserv/validate.h
@@ -1,4 +1,3 @@
-
 /*
  *  OpenVPN -- An application to securely tunnel IP networks
  *             over a single TCP/UDP port, with support for SSL/TLS-based


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
