Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA9E606A31E
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 14:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=c77XLZRv;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=JTBPwiNN;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Cmx4A+oA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=zzDWLE0r8SuKmtQ7iY0nuOgdd+VX4fRkQaXO6RKFTBU=; b=c77XLZRv7IwNEH
	DnPyX5Ou+3wJJyhRxrfLiDWnaOF/vpOzAfxH1Zm/j567W8REpeNTqrhvMfmw48GJcA6TPdmCj4d50
	zCjNSnCUPSSixQkpzW1wuLtMSieFWgZTkH2EBQZn3thYQp5K6nDUTo8J1FWaxEPrn+h+vhGz1iG8x
	nlY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVUsb-0000000055r-2Bfs;
	Mon, 23 Nov 2026 14:18:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xVUsa-0000000055c-11uA for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 14:18:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=T1ue0F+CytvJ5RbAdjLzATM73qZARp28jJVYDbVLj/k=; b=JTBPwiNNdjw5v3sHEY/gPna+Si
 kEFUpjiOv3orGFXgSN9nFfLoP5oPobKMLfOn8a3qK7tIKEqlO+qukPo428vTBHBjQbZQ4BvNHw/a6
 3vijDBXlHMDy57iN0wYYKW1yp3PkZ5fXAIwwaNHTFEgpqjx1EUTAV6sKiUI1DFfgA4YI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=T1ue0F+CytvJ5RbAdjLzATM73qZARp28jJVYDbVLj/k=; b=Cmx4A+oAXnxIKXCCffykaJDV6b
 +LfiHo+a27d6W5NQUyZQoTlqpxfVhGzSBeFg41O+iGP9CJdwm1FwdC1zTZnaAkxCXFCD2qjcNm7uf
 Zet58xg/k+NIIWsHlOQbTprAFa4lVOz48EbEB4LpO0aEexApSRA7M3MIfLntsR2DrGeU=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVUsY-000000004DE-1dQz for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 14:18:48 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6ANEIbnF002726
 for <openvpn-devel@lists.sourceforge.net>; Mon, 23 Nov 2026 15:18:37 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ANEIbD5002725
 for openvpn-devel@lists.sourceforge.net; Mon, 23 Nov 2026 15:18:37 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 23 Nov 2026 15:18:31 +0100
Message-ID: <20261123141837.2675-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1795443399000.Ibab5e329d386651ba0dd0e2f4f9bc61c357cdebb@gerrit.openvpn.net>
References: <gerrit.1795443399000.Ibab5e329d386651ba0dd0e2f4f9bc61c357cdebb@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xVUsY-000000004DE-1dQz
Subject: [Openvpn-devel] [PATCH v1] tun: drop unused is_ip_packet_valid()
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

Its last caller went away with Wintun support in ad7a6945
("win: remove Wintun support").

Change-Id: Ibab5e329d386651ba0dd0e2f4f9bc61c357cdebb
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2329
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2329
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 61fe943..d8680c6 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -502,33 +502,6 @@
 int tun_write_win32(struct tuntap *tt, const struct buffer *buf);
 
 static inline bool
-is_ip_packet_valid(const struct buffer *buf)
-{
-    const struct openvpn_iphdr *ih = (const struct openvpn_iphdr *)CBPTR(buf);
-
-    if (OPENVPN_IPH_GET_VER(ih->version_len) == 4)
-    {
-        if (BLENZ(buf) < sizeof(struct openvpn_iphdr))
-        {
-            return false;
-        }
-    }
-    else if (OPENVPN_IPH_GET_VER(ih->version_len) == 6)
-    {
-        if (BLENZ(buf) < sizeof(struct openvpn_ipv6hdr))
-        {
-            return false;
-        }
-    }
-    else
-    {
-        return false;
-    }
-
-    return true;
-}
-
-static inline bool
 tuntap_is_dco_win(const struct tuntap *tt)
 {
     return tt && tt->backend_driver == DRIVER_DCO;


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
