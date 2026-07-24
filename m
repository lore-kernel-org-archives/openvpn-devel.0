Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF60C531FA
	for <openvpn-devel@archiver.kernel.org>; Fri, 24 Jul 2026 08:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wOpFlPE9+j8ERWEojyzOqJ2LzYyibl257n57LerQSms=; b=f8BdgeG5CYz3hy5UQtS6vrIuyK
	LSi7L2McrvJ2TAHBqJRVmAJfODzZpZFlenekiKySwZ29Yr6Qhk+1T81hLxK2DsmNPA/FyRh6zzXNU
	s88ha95WR9y9q9uSQs5WquSIFAGhlAEE/VnJA+7r9LRvyWM1ITHrWES2eABPeTNbdiw8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wnB57-00012w-Uy;
	Fri, 24 Jul 2026 08:16:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qingfang.deng@linux.dev>) id 1wnB54-00012o-C9
 for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 08:16:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bPfmwQz7q0+n0RsLyTb0L6MAJmrJA1QXZEfcbqpcTj0=; b=WoFXiS6WX6pRcITp6rpsMdc41F
 +cDr0DDrQ6mJcdzBuUh1nBij82apvEDfxGEX0pNFi6rA/n5uPnQhtVZRRWcLsrAfenjXXuNfMDJWP
 1IuDHlP0EOSrT1dlV343ypdcpy0px7Z5F0UX1A92Z9UX0xTY63y58jWtaMjCG2b61exE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bPfmwQz7q0+n0RsLyTb0L6MAJmrJA1QXZEfcbqpcTj0=; b=Ok+SlRERmP2iMwiwrwV/KSd/Je
 3xKPHmumsXD2kFMJn61zu68aRUmOANINEYQ5xfYVA4MhPXsM1FkD5JK1eRiBjZXs+rZe0H7lWojCM
 CWc5YJ9B7C+i1hFINggXtH4hbl0Tm33TQ6BlsV3aSLLztuwI4ofWb0PVh6sEWr0VdFbk=;
Received: from out-178.mta1.migadu.com ([95.215.58.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wnB52-0006oL-B1 for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 08:16:30 +0000
Message-ID: <dca9174a-341b-4610-9a7f-bb3df2fb196d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1784880980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bPfmwQz7q0+n0RsLyTb0L6MAJmrJA1QXZEfcbqpcTj0=;
 b=UUVIDjnIXVom3/AZsWsL1EIgof2w+1FHgNt71bJbz9orQta6yfjP17etSYFP6aBgWj9y8f
 oYxjSilTgEDzE5tdOJ13KaYYlahIR/56K84fnW7kFoxOyMMEQpw4Ip/P4DxBgcS56HvpOq
 UoApnAtFs8QvK8EyICPY7kTo2NXyrwg=
Date: Fri, 24 Jul 2026 16:15:52 +0800
MIME-Version: 1.0
To: Antonio Quartulli <a@unstable.cc>, Ralf Lici <ralf@mandelbit.com>
References: <7141b546-fa56-4bcc-8ed5-3ffdb0728e25@linux.dev>
 <20260723075913.101036-1-ralf@mandelbit.com>
 <b6f20704-8463-4b20-a2ba-abc8800d9867@linux.dev>
 <7DF3B941-0E29-4DFD-B799-651720A0828D@unstable.cc>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <7DF3B941-0E29-4DFD-B799-651720A0828D@unstable.cc>
X-Migadu-Flow: FLOW_OUT
X-Headers-End: 1wnB52-0006oL-B1
Subject: Re: [Openvpn-devel] [PATCH ovpn-net] ovpn: fix incorrect use of
 rcu_access_pointer()
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
Cc: Antonio Quartulli <antonio@openvpn.net>,
 openvpn-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

On 2026/7/24 14:42, Antonio Quartulli wrote:
> hi Qingfang,
>
> When resending, please split the subject as "ovpn net" so that our patchwork can pick it up correctly.
Oops, I resent too early..
>
> Thanks a lot!
>
> Antonio Quartulli
> Edited on mobile, please excuse typos and brevity.


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
