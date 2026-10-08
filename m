Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA9CCA600E
	for <openvpn-devel@archiver.kernel.org>; Thu,  8 Oct 2026 20:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kn8Nqiz3lW+IIq/nyhyMbauqqHF6NqWP3esKRIel6L0=; b=OZQnh5z4ZkHURM9HSVKEAAckXd
	8rLB+GKRQpSyhEn9fzyF1mEFoPXsWI01rC/orhD8nIZosFfsBUMimQWwfkXIDphT9n582remutCCp
	wnmlJGwRUxIccv1M2aNn9lFYgXk9T/kiakcRwUQr3VTHgnUMk26yaLWd7q8Q4QI/sgFM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xEv4F-0001KC-Up;
	Thu, 08 Oct 2026 20:50:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xEv4E-0001K5-E7
 for openvpn-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 20:50:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HPx4l8GDK6VoGJZa/ObdzScosdcz5K+zqv6BVU6R2hk=; b=BlPgSFOx0xJ7dGH3tShztjY9Vb
 HXQThd1BLvN2wqYPU/uMjroqpRZQneejtjq9A9v9bYMMhvlhK9TFiMlwPxfawHXvTx/6em1Y6bjvu
 +xeEeVeFNOGCb2Srq+3WHOEF6lHjkr9jSBLbaSKehISQ7rWDHbj/NShv8iwWeVwMv8SM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HPx4l8GDK6VoGJZa/ObdzScosdcz5K+zqv6BVU6R2hk=; b=Gk/+az+vXc5PefOXbep6hp0kww
 8pRpR58cuQHCQxUqSwvgq9TLlfMhMsii/4etg6pYFfKSCpVpPN1tUndz5jA08OaAtrJVl/1hZ+OZ0
 HQD0YpuSY5m+3VTk3Kav3hMB7044yQ4n8VfAgQ8sYemmMR245Ho2YKbw+Fscck+lUbak=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xEv4A-0005NV-0N for openvpn-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 20:50:15 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 698Ko7mK028127
 for <openvpn-devel@lists.sourceforge.net>; Thu, 8 Oct 2026 22:50:07 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 698Ko6HJ028126
 for openvpn-devel@lists.sourceforge.net; Thu, 8 Oct 2026 22:50:06 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu,  8 Oct 2026 22:50:00 +0200
Message-ID: <20261008205006.28086-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1791458155000.I8a5349f66f5c1b52889c2f593e01c21824f937f0@gerrit.openvpn.net>
References: <gerrit.1791458155000.I8a5349f66f5c1b52889c2f593e01c21824f937f0@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1xEv4A-0005NV-0N
Subject: [Openvpn-devel] [PATCH v2] config.h.cmake.in: Fix issues with
 string functions
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

- Add missing HAVE_STRTOK_R
- Make HAVE_STRSEP a proper cmakedefine

Change-Id: I8a5349f66f5c1b52889c2f593e01c21824f937f0
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1986
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1986
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/config.h.cmake.in b/config.h.cmake.in
index 6c8660c..8c3088e 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -268,7 +268,10 @@
 #define HAVE_STRING_H 1
 
 /* Define to 1 if you have the `strsep' function. */
-#undef HAVE_STRSEP
+#cmakedefine HAVE_STRSEP
+
+/* Define to 1 if you have the `strtok_r' function. */
+#cmakedefine HAVE_STRTOK_R
 
 /* Define to 1 if you have the `syslog' function. */
 #cmakedefine HAVE_SYSLOG


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
