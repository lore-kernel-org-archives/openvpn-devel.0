Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0FE0CD4F25
	for <openvpn-devel@archiver.kernel.org>; Thu, 14 May 2026 09:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SaY2Oj+CJJIbQDpN+IIfyMGaHqb9U/GZSsnsbRWf0h4=; b=a+21Yiq/hpvrTKgiIFGW1ciq4S
	AkTq1w93xuDH2RlTeh4lII4EM9lFlbLHNlazMD5m+op6hB6dmVuLKlIKjYjOOUMJngXKnmTRj73oW
	qneb0ITKo1xLyo64dD6CS64l4wBjwo/g0aBVyfqNcnxCTEV5yvovmjnivL2RMIIcTh8w=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wNSAI-0006oT-Jq;
	Thu, 14 May 2026 09:15:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wNSA9-0006nZ-8w
 for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 09:15:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=y+dhLs3/Z4crxtQyYbGmaSUEI38SVS+ztsm3VL51Ikw=; b=GloQwR762quR8vMPDnIZJ0/npn
 ASTE/m8abUHDl2Jj3g5Iy0AuMCJnOqoXbr7PhnEgW6MHNYzjPlIt3RJY7XpTIt19cnJ3794cCVl4e
 z8DQrhRlY6w8WtKfLdBdg7giQ0L3rulQrjEjIE2OW3sNR2JU/al5CO7lO2nkZrCnf+U8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=y+dhLs3/Z4crxtQyYbGmaSUEI38SVS+ztsm3VL51Ikw=; b=P4mZt+NHgAvNLbq4QdyXYrqeeU
 aGLola8inBCyMtz/2BYV0263DNU9BpZXVdetQaxpPdlh2ReiWoQRkRTY6haG40T1Wp8LOwhcDbSAa
 wNQ/qt+MfdjcASrb/03LGtDm5AjG6z2vipvMYHu1GW8mUeaKAgrrxgFfz5XeH87wf51s=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wNSA7-0002J1-M8 for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 09:15:25 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 64E9FCGB017680
 for <openvpn-devel@lists.sourceforge.net>; Thu, 14 May 2026 11:15:12 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.1/8.18.1/Submit) id 64E9FCgB017679
 for openvpn-devel@lists.sourceforge.net; Thu, 14 May 2026 11:15:12 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 14 May 2026 11:15:06 +0200
Message-ID: <20260514091512.17662-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <gerrit.1778239616000.Iad3f0c36ac3795fa6a13f2d63bd00ad9c2c30d48@gerrit.openvpn.net>
References: <gerrit.1778239616000.Iad3f0c36ac3795fa6a13f2d63bd00ad9c2c30d48@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wNSA7-0002J1-M8
Subject: [Openvpn-devel] [PATCH v2] openvpnserv: Fix memory leak when
 loading DLLs
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

Identified by cppcheck.

Change-Id: Iad3f0c36ac3795fa6a13f2d63bd00ad9c2c30d48
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Heiko Hund <heiko@openvpn.net>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1670
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1670
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Heiko Hund <heiko@openvpn.net>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index ace25b9..e25c511 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1071,6 +1071,7 @@
     publish_fn_t RtlPublishWnfStateData;
     const DWORD WNF_GPOL_SYSTEM_CHANGES_HI = 0x0D891E2A;
     const DWORD WNF_GPOL_SYSTEM_CHANGES_LO = 0xA3BC0875;
+    BOOL ret = FALSE;
 
     HMODULE ntdll = LoadLibraryA("ntdll.dll");
     if (ntdll == NULL)
@@ -1081,16 +1082,19 @@
     RtlPublishWnfStateData = (publish_fn_t)GetProcAddress(ntdll, "RtlPublishWnfStateData");
     if (RtlPublishWnfStateData == NULL)
     {
-        return FALSE;
+        goto cleanup;
     }
 
     if (RtlPublishWnfStateData(WNF_GPOL_SYSTEM_CHANGES_LO, WNF_GPOL_SYSTEM_CHANGES_HI, 0, 0, 0, 0)
         != ERROR_SUCCESS)
     {
-        return FALSE;
+        goto cleanup;
     }
 
-    return TRUE;
+    ret = TRUE;
+cleanup:
+    FreeLibrary(ntdll);
+    return ret;
 }
 
 /**
@@ -1106,6 +1110,7 @@
                                      unsigned int Length, INT64 ExplicitScope);
     publish_fn_t RtlPublishWnfStateData;
     const INT64 WNF_GPOL_SYSTEM_CHANGES = 0x0D891E2AA3BC0875;
+    BOOL ret = FALSE;
 
     HMODULE ntdll = LoadLibraryA("ntdll.dll");
     if (ntdll == NULL)
@@ -1116,15 +1121,18 @@
     RtlPublishWnfStateData = (publish_fn_t)GetProcAddress(ntdll, "RtlPublishWnfStateData");
     if (RtlPublishWnfStateData == NULL)
     {
-        return FALSE;
+        goto cleanup;
     }
 
     if (RtlPublishWnfStateData(WNF_GPOL_SYSTEM_CHANGES, 0, 0, 0, 0) != ERROR_SUCCESS)
     {
-        return FALSE;
+        goto cleanup;
     }
 
-    return TRUE;
+    ret = TRUE;
+cleanup:
+    FreeLibrary(ntdll);
+    return ret;
 }
 
 /**


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
