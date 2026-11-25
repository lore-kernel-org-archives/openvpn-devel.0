Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3256A606A31E
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 18:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=M3A86Oaq;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=gFFUKjDW;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ZSTHCvRN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=VubbQPldkWg+Etfb9VLJn+pxxXO6txVjyqSYpYFYXOo=; b=M3A86Oaqn4yzgD
	5Hcje4ZPJj4XP6ubvlw/dtNPg7x//EGbUk+uXGKLfVrm5nG5PgrcfwZkDlTu7Bma6IxpZNKbX3Is+
	tcVkmnqOUiTNt5seSd9deZtwGS2724fTVBlBUjZq0KSSnN/TOGV8IXhziVm5KfnDjUxIlhMjzNHzX
	2+I=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWHfZ-000000001vI-2TOV;
	Wed, 25 Nov 2026 18:24:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xWHfZ-000000001vC-09EW for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 18:24:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=o7PoEzLn0WvN5D2RPd1o/U1Ir/0GaWTcN11Vdm2t5JU=; b=gFFUKjDWVWe8Or2BOQWy+6iSZP
 otKMBGRWSmE4UhXfJOqHXkEaiP8TrrtFzY5OGf9wZ6Exx/7KIOPm7cTEN825ljOAk8Uhy5NfJuRW4
 wC54F1O1uv2/dvk32SOCk+RlApOKgBK0gM9vC/6HX+s2fgDVxbRMezJUnVotgyPUS9kY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=o7PoEzLn0WvN5D2RPd1o/U1Ir/0GaWTcN11Vdm2t5JU=; b=ZSTHCvRNXzxkJgHwqoax6OGN5y
 o5J0pel8kZlILEyoPdv9AohV14WTrFyUnfzlfXcOZA6IM5EXef9Y5Nbp6T8C/3ysSTX6s5aakt/PK
 PHnmy8cw/koiXvckT4csuNCY173GIVHugUdPKt5da9VRYqA5po2ewP4UYuVVccuShOzc=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWHfV-000000001Vl-3s5l for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 18:24:36 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6APIOQTv029694
 for <openvpn-devel@lists.sourceforge.net>; Wed, 25 Nov 2026 19:24:26 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6APIOQP4029693
 for openvpn-devel@lists.sourceforge.net; Wed, 25 Nov 2026 19:24:26 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 25 Nov 2026 19:24:20 +0100
Message-ID: <20261125182426.29675-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1795515967000.I7b13d8b5e0babb697191e21adf2998a090c310f4@gerrit.openvpn.net>
References: <gerrit.1795515967000.I7b13d8b5e0babb697191e21adf2998a090c310f4@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xWHfV-000000001Vl-3s5l
Subject: [Openvpn-devel] [PATCH v1] dco_win: use CM_* case labels when
 switching on context mode
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

ovpn_dco_init() switched on c->mode, a CM_* value, but used MODE_*
case labels, which are options modes. This only worked because
CM_P2P/CM_TOP and MODE_POINT_TO_POINT/MODE_SERVER share values.

Change-Id: I7b13d8b5e0babb697191e21adf2998a090c310f4
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Lev Stipakov <lstipakov@gmail.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2335
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2335
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Lev Stipakov <lstipakov@gmail.com>

        
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index a854045..6074552 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -197,12 +197,12 @@
 
     switch (c->mode)
     {
-        case MODE_POINT_TO_POINT:
+        case CM_P2P:
             dco->ifmode = DCO_MODE_P2P;
             dco_p2p_start_vpn(dco->tt);
             break;
 
-        case MODE_SERVER:
+        case CM_TOP:
             ovpn_dco_init_mp(dco, c->options.dev_node);
             break;
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
