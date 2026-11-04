Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835F2606A336
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 16:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=XVa231K6;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=amg+CDCf;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=TShCtGKC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Zc/fw9fQxkCma3feLGVMF5N1fpfW0rDKpf/M1ljSS40=; b=XVa231K6ynNbF4
	wFRmPTkniq5lj4KLFIY6Uc/u3NefdmEVOhD2aGGXFkHNz26H8ZX8UjFMk09vneuy43hsTy8IGaGSn
	k8kAsI+SBGjnl0ZhRCwKZyHJh4/V393l8RRfWNra6s7BW8+Vi1CTCzRouWCAKOyxnqKXjzaWvB0UM
	ojM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOeBG-000000005bP-2TcC;
	Wed, 04 Nov 2026 16:49:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xOeBE-000000005bJ-2wwL for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 16:49:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ikYMPkXtRLbqHmfsgk6CJ5O9Ds+3o4ed+2M7u4AEzZw=; b=a
 mg+CDCfLYzUygw2QrKdUOG4vMk8VNLZYIhBZZvGISoOKnKw0jNr3utSRsP3qI7oNqLNcg4o3n6nZa
 bagU1FSnmI38jdEW2VO1ji8yu00VBVMoEkZr4zdcd2jtJPodwHWW0u1v0wdZ1D8Hp8fwDkTX2FshC
 8LVJnaW6lDvDEXi0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ikYMPkXtRLbqHmfsgk6CJ5O9Ds+3o4ed+2M7u4AEzZw=; b=TShCtGKC2wi5xcpIowLcAqWuu5
 YcWK6FKsVwLU8d2xXRB1Neu1EnEgCrXAgW/sGd4IaaK1kVpITzgcmiz1dfoplyp4uAGQ7WZ0fueJ5
 wfCwO57znKUeK5WsT5YTU1ni/OMvKOkElEr0VkpfnfxZepbw46hsYOeyGuoeg6UPt5pE=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOeBC-0000000071q-47yI for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 16:49:44 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A4Gna98096732;
 Wed, 4 Nov 2026 17:49:36 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A4GnZ7n096731;
 Wed, 4 Nov 2026 17:49:35 +0100 (CET) (envelope-from gert)
Date: Wed, 4 Nov 2026 17:49:35 +0100 (CET)
Message-Id: <202611041649.6A4GnZ7n096731@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261104105737.7333-1-gert@greenie.muc.de>
References: <20261104105737.7333-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xOeBC-0000000071q-47yI
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnserv: don't return freed
 token groups from GetTokenGroups()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel@lists.sourceforge.net
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Good hygiene, and a possible double-free() crash in the error path, so
"should go to 2.7"

Your patch has been applied to the master and release/2.7 branch (bugfix).

commit 21efe909a89fd6eb13b04849505301312a22c35a (master)
commit ad175f9bd32e76587abe82aec1fce0a7e0797715 (release/2.7)
Author: Razvan Cojocaru
Date:   Wed Nov 4 11:57:32 2026 +0100

     openvpnserv: don't return freed token groups from GetTokenGroups()

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2128
     Message-Id: <20261104105737.7333-1-gert@greenie.muc.de>
     URL: https://lore.kernel.org/openvpn-devel/20261104105737.7333-1-gert@greenie.muc.de
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
