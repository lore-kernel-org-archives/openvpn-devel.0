Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978D9606A31C
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 17:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=GVRGVHAI;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=YCJ00UOJ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=JgajfpXu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=qel6GX7SKD499gtGvssscw+b4jk5lt38ngtoTQk1Wtg=; b=GVRGVHAI61iwgU
	etLoU2KqFXLzSYf0qH4S/hOwMER9VPdafKz8242KwO0230Tbv7ZlNvISAqM+Wm7X2Q2i1TKOB3zk+
	5RDn9XWgwoDqC8k/kTR+fWTMPMdcHjedDu5Mnn+fKxnglYzxN5xwLirK0mDXVX61qEvHpsj9oCrdl
	mCs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTNMc-000000003Iy-0N5V;
	Tue, 17 Nov 2026 17:53:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xTNMD-000000003IO-339Z for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 17:52:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XWEmDnNH5UFT/GLjfoOHI50Zk9LrHUrT1J5lfd/M/x8=; b=YCJ00UOJnRkuMVJdWJetqB/Ctc
 AQz4szJ25B/3WrAYTwsDllmci942yUlUXfgFAFv1jjclzvmLjK1Z4XwiUBSguclof2KH2XrMG0pHy
 Rgc+Wbg6bk6BT+O94P+G899ToxOWHMJ6KPR/DO9pdhZ6lJRp6KmB9P4HPRUlcp2VBPJ8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XWEmDnNH5UFT/GLjfoOHI50Zk9LrHUrT1J5lfd/M/x8=; b=JgajfpXuvGAWNn6Pqxua0Oz1l1
 BtvsCseA+Z9S42Xk/Lbc6WYmfWkTnZtfwebhctLzbjGzsVHFwk6vIGklAOV/wn4MRiSbuDBAOE25t
 kyNc9Fmys9FgRxNXdlqtIeKbjWEBW9vjNHLNV8/9aB43Oky51X9zjk2PaI4MBzwcJu9M=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTNM6-000000005F1-2Avv for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 17:52:32 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AHHqOkU014571
 for <openvpn-devel@lists.sourceforge.net>; Tue, 17 Nov 2026 18:52:24 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AHHqNja014570
 for openvpn-devel@lists.sourceforge.net; Tue, 17 Nov 2026 18:52:23 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 17 Nov 2026 18:52:16 +0100
Message-ID: <20261117175223.14555-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794903017000.Ic49db236b36014ea6ee621a09252a534e3d05ef7@gerrit.openvpn.net>
References: <gerrit.1794903017000.Ic49db236b36014ea6ee621a09252a534e3d05ef7@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xTNM6-000000005F1-2Avv
Subject: [Openvpn-devel] [PATCH v2] console_systemd: treat read() error as
 failure
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

read() returning -1 was taken as success, so a failed read from
systemd-ask-password yielded an empty response instead of an error.

Change-Id: Ic49db236b36014ea6ee621a09252a534e3d05ef7
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2205
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2205
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/console_systemd.c b/src/openvpn/console_systemd.c
index f0ca7fa..059686f 100644
--- a/src/openvpn/console_systemd.c
+++ b/src/openvpn/console_systemd.c
@@ -76,7 +76,7 @@
         return false;
     }
     memset(input, 0, capacity);
-    if (read(std_out, input, capacity - 1) != 0)
+    if (read(std_out, input, capacity - 1) > 0)
     {
         chomp(input);
         ret = true;


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
