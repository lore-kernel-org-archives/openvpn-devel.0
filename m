Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8587D606A31A
	for <openvpn-devel@archiver.kernel.org>; Sun, 25 Oct 2026 18:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=SYbfHj8y;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=aq5phqPJ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FO40M7e7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=xncv0Xq2LWpilDuWASAxFEZYO1uyaT9DD0K4FjwuZ2s=; b=SYbfHj8y364/ct
	tueYP9tTXnPP0kY8+7+pg53XFqmEWxVW1nyBxBazkcy5yw0YyUPIjW4/tohTDPTNQWjV+XogPUl6H
	TRA1OSAjnDo3es1nkoB/95ATZS8zt8Mrn0ZT0S5aKfnNYeeXGZCwb0oc4x2OsFZ2bu4yeQEhOD5CO
	b9w=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xL3A9-000000005jJ-1MqH;
	Sun, 25 Oct 2026 18:41:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xL3A7-000000005jB-1CuG for openvpn-devel@lists.sourceforge.net;
 Sun, 25 Oct 2026 18:41:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CCpLN1RHWk3FiJK797+hVlQRt95cY4iXHdj0De0X2yw=; b=aq5phqPJcq7TCs4lR4S2RGOafG
 Vwdp3EbpUHdbugFsQq91Aycq4Tvbl2OjXBlQ3X0LNs6byQb3RVUpAb9Ee8jPPR81aKC+xCeSjdBdh
 YT0ltymxM8jcSmterjVLiLe9vcy6DPdtIzTjBeh9pjuMGCDijIEuAx3lIkPfsE75MHLc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CCpLN1RHWk3FiJK797+hVlQRt95cY4iXHdj0De0X2yw=; b=FO40M7e7N5ZoFNNagsLn1xLM49
 sF5Sm58e0mM2rDvbo+Y/SbsAwHJpPnU4x0/19ox3IwVpXuYQHZ1LbA6ynHVO6LqxCc+OuP7RIoQBA
 CALQpOmmVMWRy9JJQcJv9rfPXFq0M5FC7fK3fQt74ET9Xh9vdTKQEL++tJgItP6tIiZw=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xL3A5-000000002ID-48l9 for openvpn-devel@lists.sourceforge.net;
 Sun, 25 Oct 2026 18:41:43 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69PIfYYp023179
 for <openvpn-devel@lists.sourceforge.net>; Sun, 25 Oct 2026 19:41:34 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69PIfYBi023178
 for openvpn-devel@lists.sourceforge.net; Sun, 25 Oct 2026 19:41:34 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sun, 25 Oct 2026 19:41:28 +0100
Message-ID: <20261025184134.23156-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1792256506000.I2f1d25198792c71e9b3a53c505d5c5648da606ed@gerrit.openvpn.net>
References: <gerrit.1792256506000.I2f1d25198792c71e9b3a53c505d5c5648da606ed@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xL3A5-000000002ID-48l9
Subject: [Openvpn-devel] [PATCH v1] openvpn-msg.h: remove
 deprecated_msg_register_ring_buffers
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Heiko Hund <heiko@ist.eigentlich.net>

The message type was only kept as a placeholder after Wintun support
was removed in 2.7 to keep the numbering of the following message types
stable. Openvpn and the interactive service are always shipped and
updated together, so there is no need to keep the protocol numbering
compatible across versions.

Change-Id: I2f1d25198792c71e9b3a53c505d5c5648da606ed
Signed-off-by: Heiko Hund <heiko@ist.eigentlich.net>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2008
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2008
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/include/openvpn-msg.h b/include/openvpn-msg.h
index ca3267e8..1be8008 100644
--- a/include/openvpn-msg.h
+++ b/include/openvpn-msg.h
@@ -44,7 +44,6 @@
     msg_del_wfp_block,
     msg_register_dns,
     msg_enable_dhcp,
-    deprecated_msg_register_ring_buffers,
     msg_set_mtu,
     msg_add_wins_cfg,
     msg_del_wins_cfg,


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
