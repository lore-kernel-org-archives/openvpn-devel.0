Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D58C5CFDB
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 18:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EvQySc0Gkay47SIPi1BFY84I5VhQvcWCSqsFtw4IvJU=; b=MLGjDVUkl97Al73yWbCrSH5bjf
	1BGnEWzk5CMt0HFhr3HRct/JvtJxgHfh6n8mLRIou2f5JgzDXWEx1cNKQQ6+Ku/DIVnQAhJiG96zT
	YHwDpg6xuLWKBTwMWYjqLa3PKrf1yCMweoTeTPYq4O5PGBm/dT87JKO7BUSapaKzJtKM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuZrE-0001Vc-EP;
	Thu, 13 Aug 2026 18:08:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wuZrC-0001VV-Cd
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 18:08:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QZd7Bjl1KLYGIZik6AGfJf2B325fr+G39U9i9zZLRLE=; b=Fu7+kV9O8E/0AmveQ4jlc1au8r
 KXcwOSi4V5DwFVfCAS6z3D6zqmxEZnvEoSQkJ2L+GvY0F+6O74yDDZENYz/tN2F2imAAR3IQKDePv
 D1DT2AEVSFEPMgZv3zNbOnyonRZE3WPAwgiDx5i1xMCt1bJZQE0ON8F33/BkU+sX+VjQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QZd7Bjl1KLYGIZik6AGfJf2B325fr+G39U9i9zZLRLE=; b=cEU+iKeF+T+atU/9N95flA1Px0
 C3DgxY9evQ7xQheJSeHTHV3o2bzcNmrgbiJNbVdPCFVcE5eSNgXwVbVgaLp54lSojwYWlh3rpdOju
 h+OiIpudPV4V1Vjh32ijGDYJKlnbxaIXqJKn+bS6ftNQbv/rUFthgAwAI42C4mMmx3ck=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wuZrC-0001WS-2G for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 18:08:43 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67DI8ZZE003174
 for <openvpn-devel@lists.sourceforge.net>; Thu, 13 Aug 2026 20:08:35 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67DI8Zlc003173
 for openvpn-devel@lists.sourceforge.net; Thu, 13 Aug 2026 20:08:35 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 13 Aug 2026 20:08:29 +0200
Message-ID: <20260813180835.3160-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1771008896000.I2ca40d0d86599896b38ea1467313b6a6cdc8339c@gerrit.openvpn.net>
References: <gerrit.1771008896000.I2ca40d0d86599896b38ea1467313b6a6cdc8339c@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wuZrC-0001WS-2G
Subject: [Openvpn-devel] [PATCH v9] tun: Avoid sign-compare warning in
 header_modify_read_write_return
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

Since we already check that the value is positive
just make the implicit cast explicit.

Change-Id: I2ca40d0d86599896b38ea1467313b6a6cdc8339c
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1527
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1527
This mail reflects revision 9 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index f46802f..28ec7b8 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1706,17 +1706,12 @@
 #include <netinet/ip.h>
 #include <sys/uio.h>
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 static inline ssize_t
 header_modify_read_write_return(ssize_t len)
 {
     if (len > 0)
     {
-        return len > sizeof(u_int32_t) ? len - sizeof(u_int32_t) : 0;
+        return (size_t)len > sizeof(u_int32_t) ? len - sizeof(u_int32_t) : 0;
     }
     else
     {
@@ -1724,10 +1719,6 @@
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static ssize_t
 write_tun_header(struct tuntap *tt, uint8_t *buf, int len)
 {


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
