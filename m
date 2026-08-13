Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA78C5AC67
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 05:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TS2A0u5IgfzBuw8LVTP23F3ip5XuYNarTHdiWmj0KNM=; b=ROlNeR0KTyqvn9393PpGcjHROh
	Ml0YsNd4u0uR/+1Gdu8H8HVB0Ja5Q4zrvPenVueLLxzzcOOx3FQCJOnlSKSYJn+LMyNWvz00JcL5O
	iRCQOPD3P3Ab3SU005fvGktR+nvSV+mNXTqxMzp6piVT01hHNO40TJ3Z3dog36d6Hdrs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuOSk-00071A-60;
	Thu, 13 Aug 2026 05:58:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wuOSj-000714-9w
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 05:58:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SLxqHV/UA9lOq+4NRZm88RzKhYnZIOGr/4IbhwDWWJg=; b=kqmXl6O2LudHLOFfU5bKxsVaZr
 rjN9YZmQmkpC0uwN4hL4xdjqMD/OLQapQ4PsNTo5IP/r7jcLOwmFbwXr4bMFE60dXwxZAR0MdWkBa
 xMVYvyt6gMxRYZSYnfUIbxTNXkI9JUQDJJwzEd4vEUCLGrYWM5V37cLMTIqqQQerlDwI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=SLxqHV/UA9lOq+4NRZm88RzKhYnZIOGr/4IbhwDWWJg=; b=Lyfg00tFATYRhl3e79Ga0wPIYg
 kE/hNd7SPrl83lhWgQkNY6rZ/7nwto020fwd/FDn7H0cCO6rq1qRXIRAtjd5527p8nT5GDdNCfYI3
 kCqEAJKA+d/0X3A71uHeEYS6HQLowdv5mb3Htm14RYxLdUSDgxCSN7OatdNPfHLI6M3w=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wuOSl-0007ND-KA for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 05:58:45 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67D5wa5q032453
 for <openvpn-devel@lists.sourceforge.net>; Thu, 13 Aug 2026 07:58:36 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67D5waoc032452
 for openvpn-devel@lists.sourceforge.net; Thu, 13 Aug 2026 07:58:36 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 13 Aug 2026 07:58:30 +0200
Message-ID: <20260813055836.32422-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1786540865000.Ia2e238a41526ebc178c53d3807103d8b9da475a5@gerrit.openvpn.net>
References: <gerrit.1786540865000.Ia2e238a41526ebc178c53d3807103d8b9da475a5@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wuOSl-0007ND-KA
Subject: [Openvpn-devel] [PATCH v1] Fix extracting IV_MTU
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

Commit 06ced3fd accidentally broke extracting the MTU from the peer
info while refactoring the code. Before 06ced3fd the code used
iv_mtu as temporary string and extracted the value into client_max_mtu.
The new code never set client_max_mtu and used iv_mtu as integer instead.

Fix this by setting client_max_mtu again with the real MTU value from
the peer.

Change-Id: Ia2e238a41526ebc178c53d3807103d8b9da475a5
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1842
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1842
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index ce2baf2..357b25f 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -717,10 +717,9 @@
     }
 
     /* Push our mtu to the peer if it supports pushable MTUs */
-    int client_max_mtu = 0;
-    unsigned int iv_mtu = peer_info_extract_uint(tls_multi->peer_info, "IV_MTU=");
+    int client_max_mtu = peer_info_extract_uint(tls_multi->peer_info, "IV_MTU=");
 
-    if (iv_mtu != 0)
+    if (client_max_mtu != 0)
     {
         push_option_fmt(gc, push_list, M_USAGE, "tun-mtu %d", o->ce.tun_mtu);
         if (client_max_mtu < o->ce.tun_mtu)


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
