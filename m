Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E58E5C5DF88
	for <openvpn-devel@archiver.kernel.org>; Wed, 19 Aug 2026 16:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TBWEcyxIRH20sR128RygHOzTiPH4rrfZWtTK2aE7/Ls=; b=loftFR95ON0+s8Cq3hTPAlhNc2
	N6j6WZiSwnvijPz9mfTP9Ya2qmmlH4MosgM4QKb2i0nVYkNYeA5MIiMXK6B2YnOFbmefjRS7HInES
	WmfHthvBfVrqnzI3zeH6/QclWIirRM09PqujYuIMjaESfCu+XsFUepf78VYb2pYNkadg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwj9L-00078W-Ar;
	Wed, 19 Aug 2026 16:28:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wwj9J-00078Q-GH
 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 16:28:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zennZcQVSRPivfv3OF2MEBOSpDhfJjucCPaI8c1ohbA=; b=gqoaxFpeDUJa8TDBtxccbfvC4L
 Dj1vSAHqiz6Wb4qxmYdhw6LEuwfSNuokJve1tgAQqX/x6Bl4wXYeQETBw9bw9kPYH/Uzs3Zte+U9c
 D9L9PDg+vTjd9gTfVT0MLTxqQFaMxcy0G4FUugSuWbsnvUv5LqZn8Y+0/YcJutF0q85A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zennZcQVSRPivfv3OF2MEBOSpDhfJjucCPaI8c1ohbA=; b=KnNkoh8A0CJUA4s2Y9JT6DSXtx
 K3pvanCQKuDEsM9dEIAtyWOh4k0+AE+iE66OhFrinfewpuq89hc4kFvK5Ut53K4gVWTb3yuBDH2JI
 axwWd9ztHNRmIVJtKnh/z9/C35moFb3SdD2Ju7ZWXZLmM76/sIVXP7TcO5btCBn9ms98=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wwj9I-00027m-1O for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 16:28:22 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67JF36ke016382;
 Wed, 19 Aug 2026 17:03:06 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67JF35cT016381;
 Wed, 19 Aug 2026 17:03:05 +0200 (CEST) (envelope-from gert)
Date: Wed, 19 Aug 2026 17:03:05 +0200 (CEST)
Message-Id: <202608191503.67JF35cT016381@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260819132652.24207-1-gert@greenie.muc.de>
References: <20260819132652.24207-1-gert@greenie.muc.de>
X-Headers-End: 1wwj9I-00027m-1O
Subject: [Openvpn-devel] [PATCH applied] Re: gen-release-tarballs.sh: Remove
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
Cc: openvpn-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

Now that was an easy one ;-)

Your patch has been applied to the master branch.

commit 2b3df1ed0f0207a1df6ffa4640457655ab2aa10c
Author: Frank Lichtenheld
Date:   Wed Aug 19 15:26:46 2026 +0200

     gen-release-tarballs.sh: Remove

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1847
     Message-Id: <20260819132652.24207-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38509.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
