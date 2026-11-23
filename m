Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1E2606A33F
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 17:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=VLyLnhL7;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=I8ELxmex;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=DsU5HFRB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=XvfF88eSvCmuWu34UPiEr5mJimZOBarnLRE08o5oiOU=; b=VLyLnhL7EQD6RL
	FmlOD3jfaRlOQTNuR4ClEQSWehJiocZrjysIWnR1rLhST4mKY658SmsGkUrnb9Chjw8/EgadB50yI
	v5IXCbzqTS3cblZfL+yyOA3QpSZzQYWlzSrGWeSLk4WwAXGi5Khk+VL11M3wq9oAuXvMQLtX7IYaA
	hiw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVY9D-000000000lH-1Bmx;
	Mon, 23 Nov 2026 17:48:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xVY9C-000000000lB-0mdm for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 17:48:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=pDN2a+5TAVc/+/Z6iVb3QAVqIE4Nh/weQo9rHOZX0rQ=; b=I
 8ELxmex5vwWO2RRPVG9Pshh2IeiY0AvJrsBtAT5iupdQruNNGKS7g85QsbvY6G5x8Edp4EDbmZene
 VSTilAlMEocTL1yMQCkOTAbbOYcSvlRMR2hg3JCno60NqV5U7kdzJr2qJXnxif5YfHj3zmeJddXro
 PTpuFR402p4MeHp4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pDN2a+5TAVc/+/Z6iVb3QAVqIE4Nh/weQo9rHOZX0rQ=; b=DsU5HFRBERgqiltPPa6DpKNkAU
 lNqO1MTaer/S8VGKLdYWpMq1jPubSApCXERvOdDk9Br4/el+Buq4YDM8mtqycgJccJhYlJFlh+MwC
 k2sbQkxSdAVTabuZaf6WGAKIOfCY4YmhZojZvMRLb/LTh4uaYrmo9reWCNQA+ZNFFLq0=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVY9A-0000000029R-1KoM for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 17:48:10 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6ANHm1tk085904;
 Mon, 23 Nov 2026 18:48:01 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ANHm1i3085903;
 Mon, 23 Nov 2026 18:48:01 +0100 (CET) (envelope-from gert)
Date: Mon, 23 Nov 2026 18:48:01 +0100 (CET)
Message-Id: <202611231748.6ANHm1i3085903@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261123152105.9130-1-gert@greenie.muc.de>
References: <20261123152105.9130-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xVY9A-0000000029R-1KoM
Subject: [Openvpn-devel] [PATCH applied] Re: ssl_common: drop unused
 key_state.acf_last_mod
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

And another really easy one...  interesting reference commit.

Your patch has been applied to the master branch.

commit f7a56d3206481b5aa8bb39723cdab03e3c503446
Author: Razvan Cojocaru
Date:   Mon Nov 23 16:20:59 2026 +0100

     ssl_common: drop unused key_state.acf_last_mod

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2330
     Message-Id: <20261123152105.9130-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41836.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
