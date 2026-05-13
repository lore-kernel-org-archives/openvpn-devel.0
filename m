Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BAD5CD4F24
	for <openvpn-devel@archiver.kernel.org>; Wed, 13 May 2026 15:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UETEskdXC/N8LFlReqR3kb6tqHoUKOQu056ez4veA/c=; b=c0DZLOkNq2drZ/kyeYNFy+zQqa
	pUZh0mJPrgoNo/E2GG7ERNsOdqDpJ0ICMRwHbf+uQZIWfxlIh+lVrn8gGyn4y6BFH5hgOjlVZ5qjE
	MnoritatcDrfhwbbsCICXVvhX93ETuYqe+Uuzi8b0umxokIcyjC5I787tZ37WeyoPvg4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wNBCy-0005fN-D7;
	Wed, 13 May 2026 15:09:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wNBCx-0005fH-1Q
 for openvpn-devel@lists.sourceforge.net;
 Wed, 13 May 2026 15:09:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=orE1wyo6e16LJZiAjbdYE6HRw/DR5D59sIRFaZWeiok=; b=JWe5itTeNhF7MEs37XbZmxWH4c
 5USnapcaIqE3mcHihBSwhU50S20bCqEROitmfnppB/VZmpBIBXnkB3/+Ko7YPDzzZcyD9GpXD0Y4Z
 GDdL5jFdGZkM3f+lnBZxE2VFYIpFqov/4qR2BiaKhsW1t2/x1q/bLpS2LT47M6KIWK4g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=orE1wyo6e16LJZiAjbdYE6HRw/DR5D59sIRFaZWeiok=; b=DhtcOfvoQHE6dKbR5zMiMXyeL8
 9Se7Fy9yVhmDUh4Q/lkF91QXYLTMikIjd8BnNsHfYKIhql5gyBjnHWZw103hPy5IpoUdhE+4yCM6K
 GzLIRaWNWYVp2nRP8JEFF9fA7XcUa/Jm1JiM/jIyeoSF2qqVaOgxSKLfoeMglIKk7w3g=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wNBCv-0006kn-A4 for openvpn-devel@lists.sourceforge.net;
 Wed, 13 May 2026 15:09:11 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 64DF93Gd027461
 for <openvpn-devel@lists.sourceforge.net>; Wed, 13 May 2026 17:09:03 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.1/8.18.1/Submit) id 64DF93QO027460
 for openvpn-devel@lists.sourceforge.net; Wed, 13 May 2026 17:09:03 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 13 May 2026 17:08:57 +0200
Message-ID: <20260513150902.27447-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <gerrit.1778239616000.Ida6d4fa8c5c5ffbd7909d6afd51b1b6f32ca2d9f@gerrit.openvpn.net>
References: <gerrit.1778239616000.Ida6d4fa8c5c5ffbd7909d6afd51b1b6f32ca2d9f@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wNBCv-0006kn-A4
Subject: [Openvpn-devel] [PATCH v2] openvpnserv: Address some uninitVariable
 warnings from cppcheck
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

In the first case this is about helping cppcheck
remember that msg->addr_len and addr_len are the same
thing, but we use them in confusing ways.

In the second case there is indeed a theoretical
code path where we use an uninitialized buffer. So
make the code safer.

Change-Id: Ida6d4fa8c5c5ffbd7909d6afd51b1b6f32ca2d9f
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Heiko Hund <heiko@openvpn.net>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1674
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1674
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Heiko Hund <heiko@openvpn.net>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index bd310e4..781391c 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1876,7 +1876,7 @@
         return err; /* job done */
     }
 
-    if (msg->addr_len > 0)
+    if (addr_len > 0)
     {
         /* prepare the comma separated address list */
         /* cannot use max_addrs here as that is not considered compile
@@ -2647,25 +2647,28 @@
         free(wide_search_domains);
     }
 
-    /* Create address string list */
-    CHAR addr_list[NRPT_ADDR_NUM * NRPT_ADDR_SIZE];
-    PSTR pos = addr_list;
-    for (int i = 0; i < NRPT_ADDR_NUM && addresses[i][0]; ++i)
+    if (addresses[0][0])
     {
-        if (i != 0)
+        /* Create address string list */
+        CHAR addr_list[NRPT_ADDR_NUM * NRPT_ADDR_SIZE];
+        PSTR pos = addr_list;
+        for (int i = 0; i < NRPT_ADDR_NUM && addresses[i][0]; ++i)
         {
-            *pos++ = ';';
+            if (i != 0)
+            {
+                *pos++ = ';';
+            }
+            strcpy(pos, addresses[i]);
+            pos += strlen(pos);
         }
-        strcpy(pos, addresses[i]);
-        pos += strlen(pos);
-    }
 
-    WCHAR subkey[MAX_PATH];
-    swprintf(subkey, _countof(subkey), L"OpenVPNDNSRouting-%lu", ovpn_pid);
-    err = SetNrptRule(nrpt_key, subkey, addr_list, wide_domains, dom_size, dnssec);
-    if (err)
-    {
-        MsgToEventLog(M_ERR, L"%S: failed to set rule %s (%lu)", __func__, subkey, err);
+        WCHAR subkey[MAX_PATH];
+        swprintf(subkey, _countof(subkey), L"OpenVPNDNSRouting-%lu", ovpn_pid);
+        err = SetNrptRule(nrpt_key, subkey, addr_list, wide_domains, dom_size, dnssec);
+        if (err)
+        {
+            MsgToEventLog(M_ERR, L"%S: failed to set rule %s (%lu)", __func__, subkey, err);
+        }
     }
 
     if (domains[0])


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
