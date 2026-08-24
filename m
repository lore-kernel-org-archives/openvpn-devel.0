Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF7E0C5DF9C
	for <openvpn-devel@archiver.kernel.org>; Mon, 24 Aug 2026 18:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ry5esWBDNmJvSJ2FwaDN2KOrBu6dz9lDmpnbGum5Z78=; b=jjOKD4aeIlmBAiuHOgJ71CEucZ
	HAMXXdllr680NMAtIvU99s6W82Hp8AkCPt/V1yfbn4kTMXnZmbVt2inykvH9QwipmrxZuOAT4awpp
	mrscfBV61CeBBS36j5rnFVd/7XtlZurgUhm7mf1nR5fadUh6SIMAd3h/NxS72DoKuobg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyZ2e-0004zD-2n;
	Mon, 24 Aug 2026 18:05:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wyZ2d-0004z2-8o
 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 18:05:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=q4eWgSMItE/mTtr6+tRU/MWWuVEtl1CcZ3XNPp0ylrw=; b=b7KKW9kuYJt351rlltxSaJnarE
 xUKqgFFHM4BZr+Kd9/jIdB76p0slCea4SGU3dOGXWYK5BfZn6kwW7uNssor8VlQhxstBTukjM4Wxb
 mKRgEPcGy2xZ0bfTe9wGPWZOsP1EVOAyiZsFlJxNsYfSPbHDPw7byxIMVHGaxUItjBJM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=q4eWgSMItE/mTtr6+tRU/MWWuVEtl1CcZ3XNPp0ylrw=; b=L57rFo5Lur36tQbizlr84aoBGF
 IU6DAuFc2nZxD09dsl/Urq511yA1/oLZ6ZjlLu48fz9yhP3tS3eT/wW5C0WnxyQ4WZrY5OubX5PbG
 H0tg7bXHXT+AqPD5TaAHaGsaWnF5p2B4bdoPAgZef8s9TkpubKBJ6UL+hbiyG5ObPB3w=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wyZ2b-000633-V7 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 18:05:03 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67OI4t6M012212
 for <openvpn-devel@lists.sourceforge.net>; Mon, 24 Aug 2026 20:04:55 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67OI4td6012211
 for openvpn-devel@lists.sourceforge.net; Mon, 24 Aug 2026 20:04:55 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 24 Aug 2026 20:04:48 +0200
Message-ID: <20260824180454.12181-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1787438913000.Iec392a47123d618c0dbc3a5241c39da4ac83d880@gerrit.openvpn.net>
References: <gerrit.1787438913000.Iec392a47123d618c0dbc3a5241c39da4ac83d880@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wyZ2b-000633-V7
Subject: [Openvpn-devel] [PATCH v1] openvpnserv: fix log lines format string
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

From: Heiko Hund <heiko@ist.eigentlich.net>

The interface name is UTF-8 encoded. In order to log it correctly,
it needs to be converted to UTF-16 first.

Change-Id: Iec392a47123d618c0dbc3a5241c39da4ac83d880
Signed-off-by: Heiko Hund <heiko@ist.eigentlich.net>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1861
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1861
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 32c1b9c..b120fa2 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1224,19 +1224,25 @@
     err = InterfaceLuid(itf_name, &luid);
     if (err)
     {
-        MsgToEventLog(M_ERR, L"%S: failed to convert itf alias '%s'", __func__, itf_name);
+        PWSTR wide_name = utf8to16(itf_name);
+        MsgToEventLog(M_ERR, L"%S: failed to convert itf alias '%s'", __func__, wide_name);
+        free(wide_name);
         goto out;
     }
     err = ConvertInterfaceLuidToGuid(&luid, &guid);
     if (err)
     {
-        MsgToEventLog(M_ERR, L"%S: Failed to convert itf '%s' LUID", __func__, itf_name);
+        PWSTR wide_name = utf8to16(itf_name);
+        MsgToEventLog(M_ERR, L"%S: Failed to convert itf '%s' LUID", __func__, wide_name);
+        free(wide_name);
         goto out;
     }
 
     if (StringFromIID(&guid, &iid_str) != S_OK)
     {
-        MsgToEventLog(M_ERR, L"%S: Failed to convert itf '%s' IID", __func__, itf_name);
+        PWSTR wide_name = utf8to16(itf_name);
+        MsgToEventLog(M_ERR, L"%S: Failed to convert itf '%s' IID", __func__, wide_name);
+        free(wide_name);
         err = ERROR_OUTOFMEMORY;
         goto out;
     }


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
