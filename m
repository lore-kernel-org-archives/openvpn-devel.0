Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD7AC5DF9C
	for <openvpn-devel@archiver.kernel.org>; Mon, 24 Aug 2026 16:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jwcGTrezQpED/rMmm5JCAvXgtAfDNcGcgTRabHh3+ZU=; b=jODKzyAgK5NO4QbaSHOAf7+M+T
	joutFTfhmG8er0O4NYupOoNqbXDtWVSBFtVI43YVYCNgUnHBVupRsa9RI3Nn4jJUvlRnhNgyXnP8k
	dFDsm4v6eIpmgZHZlmbwbqsybB6Q5v+3l5zGiHVnL/P2gF9oEnJLLjYqKf0PKcFYnkag=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyXKo-00031Y-Vh;
	Mon, 24 Aug 2026 16:15:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wyXKn-00031E-MM
 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 16:15:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hJ9JyzUEVBZdeW79a12p4xWM7pPi+Kxxaedh8yYQZXU=; b=XFtbfPr36Njy92TnbdzvHQFenu
 x4THNW0dMF3vJo085v4kScHbHixHQPp8B0OmAgyr4rLniMXD523K6ODwSw7wkBbtElSWms0p90LVT
 y/6VC7XivreN3YzwmkhgVf9SZuByrRSYE+Nek5zXzqo2QDfGZse6uxk7qn0W6IBD/E/Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hJ9JyzUEVBZdeW79a12p4xWM7pPi+Kxxaedh8yYQZXU=; b=TWtYqVfnQlP9QkOrRC1+UByGOi
 91G/4Kgc7mqkCe7x7TFqtPazlx/QPyTHHW2hMg2wz6a8Cup6EX+J2TkUXwVAEyS7O+I5CZ/h8uiTZ
 WQYfU2T5TmawzeMmfdd3uNWaOuVYbimxqCXiZI9Oql86hvBKPqkFBmCaSGwSsmfH5L60=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wyXKQ-0001Zv-S2 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 16:15:19 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67OGFCoW001750
 for <openvpn-devel@lists.sourceforge.net>; Mon, 24 Aug 2026 18:15:12 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67OGFCGQ001749
 for openvpn-devel@lists.sourceforge.net; Mon, 24 Aug 2026 18:15:12 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 24 Aug 2026 18:15:05 +0200
Message-ID: <20260824161512.1720-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1787570563000.I395cc722d53201d775c20ae3cf9d50149bfc90ed@gerrit.openvpn.net>
References: <gerrit.1787570563000.I395cc722d53201d775c20ae3cf9d50149bfc90ed@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wyXKQ-0001Zv-S2
Subject: [Openvpn-devel] [PATCH v1] dco_win: Remove unused dco_start_tun
 declaration
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

This function was removed in commit
1625d927fc79e2926015ded06a01fd8e460a4bc7, but the
declaration and the non-Windows definition were
left behind.

Identified by cppcheck.

Change-Id: I395cc722d53201d775c20ae3cf9d50149bfc90ed
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1863
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1863
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/src/openvpn/dco_win.h b/src/openvpn/dco_win.h
index ac3ce33..a92e5ad 100644
--- a/src/openvpn/dco_win.h
+++ b/src/openvpn/dco_win.h
@@ -65,8 +65,6 @@
 void dco_p2p_new_peer(HANDLE handle, OVERLAPPED *ov, struct link_socket *sock,
                       struct signal_info *sig_info);
 
-void dco_start_tun(struct tuntap *tt);
-
 bool dco_win_supports_multipeer(void);
 
 void dco_win_add_iroute_ipv4(dco_context_t *dco, in_addr_t dst, unsigned int netbits,
@@ -79,13 +77,5 @@
 
 void dco_win_del_iroute_ipv6(dco_context_t *dco, struct in6_addr dst, unsigned int netbits);
 
-#else  /* if defined(ENABLE_DCO) && defined(_WIN32) */
-
-static inline void
-dco_start_tun(struct tuntap *tt)
-{
-    ASSERT(false);
-}
-
 #endif /* defined(_WIN32) */
 #endif /* ifndef DCO_H */


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
