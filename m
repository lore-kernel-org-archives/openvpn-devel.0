Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E4DCD5BD5
	for <openvpn-devel@archiver.kernel.org>; Thu, 28 May 2026 20:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hqCnouO8hVwRG40rBHk7ZbZvybWSz8k77+KXDXi5G+M=; b=inVBHgwRDgC5zllCxfMn9r8KFQ
	wNa/TfyqWbWjs9modok9QhW/VvrXDMl9RS2pS3zedee7AvIBjcy6ZqQlbnn4Qowqi5XMJuoSM3mxB
	fhdRtOLn+cACspPV198OuGeH9RvodrPPfYgTKilpH1MY+DeHdaCKcpI/DalfGKfdH3jQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wSgyf-00020K-BB;
	Thu, 28 May 2026 20:05:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wSgye-000204-2m
 for openvpn-devel@lists.sourceforge.net;
 Thu, 28 May 2026 20:05:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=V5je3safaqZvWHKWBrbnjZ5rq6S24ila2rFNPRDnqhI=; b=Dbk7m3CGagDx6bowSg2U2cS8r/
 pz3DgPXOJy3U97ntwnbwYas+MoXmMn4kV0hHH++4KSF4Q4XyEGUHHY8UeSiBCinBK83+/0FkSNQW1
 MHD/O3WEHahgPepg3fHi2vwbl61JLoUp+DpiCzz68xQ9zR4qRRRzN151h5UbzxYrgD/Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=V5je3safaqZvWHKWBrbnjZ5rq6S24ila2rFNPRDnqhI=; b=h3zSbz44gj1yMXYmB/V8mVtrGz
 bFWsS7AzhtMo2hgPqJ/mJUf7BhdpVM/H6EzJUrG8ce2mh7HF/nyKeWmfvUB2eimNm6tYIMQ0oStah
 COLHpoUFbRyt+8tK7sm3uTY1znD4GyoNPMznWL10s1Nx2m/4gc65gOeYbL1OpFl4F/y4=;
Received: from mout-p-201.mailbox.org ([80.241.56.171])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wSgyd-0006bY-C7 for openvpn-devel@lists.sourceforge.net;
 Thu, 28 May 2026 20:05:12 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gRHXC00mhz9v79;
 Thu, 28 May 2026 22:04:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1779998699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V5je3safaqZvWHKWBrbnjZ5rq6S24ila2rFNPRDnqhI=;
 b=amY8XTQijhx/QvHM5rY4P+bgVH07t7HbuOTLp1Hix5Gcbjd/9EeRsRriuHheAznVn3PQuM
 YUAv5mbUBFHK5by0jI5X4zhRPDIyTyb+eXve3qs7d4gMOEd4ctJE5SEnqWhQEzqp6rBpvZ
 hij/3PO3tXRmOpt9YNQ7Ife+h1FoZmoQpNsYX2HQCfLizwUcun56iuf8P/gRMlQyOEy9Uf
 Itptdqkq2rk4OdwN7Yr+HrVM7gaa5PBSBwgSV2D+gwg9yINmBpwniS5pgcn1X2T1ehn+n5
 TMLhgVmBldTEAWw/bmwJcfaT7NQs6K5mul4Vzk7DDXzao+r5YjW2kWJuT9OiEA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=a@unstable.cc
Message-ID: <05204388-fb35-4aec-bf88-2f66bcf77aed@unstable.cc>
Date: Thu, 28 May 2026 22:04:57 +0200
MIME-Version: 1.0
To: Sabrina Dubroca <sd@queasysnail.net>
References: <20260526231850.2511369-1-a@unstable.cc> <ahiIZX6iG6HjnsiS@krikkit>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: <ahiIZX6iG6HjnsiS@krikkit>
X-Rspamd-Queue-Id: 4gRHXC00mhz9v79
X-Headers-End: 1wSgyd-0006bY-C7
Subject: Re: [Openvpn-devel] [PATCH ovpn net 1/9] ovpn: skip rehash for
 peers already removed from by_id
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

On 28/05/2026 20:24, Sabrina Dubroca wrote:
>> diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
>> index a09d61296425..a472ffe3016b 100644
>> --- a/drivers/net/ovpn/peer.c
>> +++ b/drivers/net/ovpn/peer.c
>> @@ -307,6 +307,16 @@ void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
>>   			return;
>>   		}
>>   
>> +		/* peer may have been concurrently removed between the caller's
>> +		 * initial lookup and our acquisition of ovpn->lock; skip the
>> +		 * rehash so we don't re-insert a removed peer
>> +		 */
>> +		if (unlikely(hlist_unhashed(&peer->hash_entry_id))) {
>> +			spin_unlock_bh(&peer->lock);
>> +			spin_unlock_bh(&peer->ovpn->lock);
>> +			return;
>> +		}
> 
> I'd add an "unlock2" label (or "unlock_both") to unlock both (maybe
> just after the "hlist_nulls_add_head_rcu", before the existing
> unlock). The unlock/return is a bit verbose and we have it 3 times
> after this patch.

Yap, make sense!
I'll respin the patch with this change.

Cheers,


-- 
Antonio Quartulli



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
