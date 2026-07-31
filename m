Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E7FCC54F54
	for <openvpn-devel@archiver.kernel.org>; Fri, 31 Jul 2026 10:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J1IJ3pQd5DATBjDk16hz+t4G8b1lgkX9QOISOYE55Hs=; b=fIL6o3l6n1OdZBrsOTPZU6T17C
	PIxsgPZAAM1E1Ed6FRgXk+S5KRm6BuO5X4aWYCuE80wFLDSb2xgEDuiCBMbB85HYrNt2zuMHlEBcJ
	No6iWxJUzW4t+X7A2+PT4tYO/WSlSFuSBU2BVu1akqOXYFvORLbwOvXCjBEKKDLeGe3w=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wpkAD-0000Tn-EM;
	Fri, 31 Jul 2026 10:08:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wpkAC-0000Th-2j
 for openvpn-devel@lists.sourceforge.net;
 Fri, 31 Jul 2026 10:08:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=l+APi8LxeU+vk9HBxpvije1x2mix48GTgcA0h+OGCf8=; b=LPVNg6e4yzwkAbm5c0N5CSjNmk
 W2zrQFXHJw9Pnf6vuCNtJpNsj8LB+0/sWvroqRMy3ezeJ7T66oDSUb7nb0kcm/R9wyOq1IgCQzuWS
 OYvZb1gcNKslj5SVLVa7sE2O5Fv6MpNvFt3GNpTtdJV8uU0BU11rh/+j3sg4ojuyibs0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=l+APi8LxeU+vk9HBxpvije1x2mix48GTgcA0h+OGCf8=; b=Vr+hxTahpfrFwcjsNPcTCDCySx
 RbowywzpzX4/eO5vN9tUwRUbZzY6+vYtdOQpt7pWZh9+6yLtD/o0JEC60XlwrjAbOSnRit77YLceB
 tFPRxoAKS36lw97+dBFTtiFA6Lkt4kTbWRY/MIJYQdB5NAWWS2x5WUZ0eGpb3emBZ2EI=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wpkAE-0000qH-DE for openvpn-devel@lists.sourceforge.net;
 Fri, 31 Jul 2026 10:08:24 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 66VA8Gbw003420
 for <openvpn-devel@lists.sourceforge.net>; Fri, 31 Jul 2026 12:08:16 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 66VA8Gov003419
 for openvpn-devel@lists.sourceforge.net; Fri, 31 Jul 2026 12:08:16 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 31 Jul 2026 12:08:09 +0200
Message-ID: <20260731100815.3406-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1782134588000.Ie552084638320b3bace76be2f589013f12af3c46@gerrit.openvpn.net>
References: <gerrit.1782134588000.Ie552084638320b3bace76be2f589013f12af3c46@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wpkAE-0000qH-DE
Subject: [Openvpn-devel] [PATCH v15] Add check that username is identical to
 multi float
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

From: Arne Schwabe <arne@rfc2549.org>

This adds an additional safe guard for setups that do not use
client certificates.

Change-Id: Ie552084638320b3bace76be2f589013f12af3c46
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1724
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1724
This mail reflects revision 15 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 9b64598..0560ac5 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3112,6 +3112,18 @@
         goto done;
     }
 
+    /* do not allow if target address has a different username */
+    if (m1->locked_username || m2->locked_username)
+    {
+        if (!m1->locked_username || !m2->locked_username
+            || strcmp(m1->locked_username, m2->locked_username) != 0)
+        {
+            msg(D_MULTI_LOW, "Disallow float to an address taken by another client %s",
+                multi_instance_string(ex_mi, false, &gc));
+            goto done;
+        }
+    }
+
     /* It doesn't make sense to let a peer float to the address it already
      * has, so we disallow it. This can happen if a DCO netlink notification
      * gets lost and we miss a floating step.
@@ -3128,7 +3140,7 @@
 
     msg(D_MULTI_LOW,
         "closing instance %s due to float collision with %s "
-        "using the same certificate",
+        "using the same certificate and username",
         multi_instance_string(ex_mi, false, &gc), multi_instance_string(mi, false, &gc));
     multi_close_instance(m, ex_mi, false);
     ret = true;


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
