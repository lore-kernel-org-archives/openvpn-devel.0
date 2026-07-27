Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17484C531D0
	for <openvpn-devel@archiver.kernel.org>; Mon, 27 Jul 2026 12:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0eotNvtxmNrY0AZW6K+wFAZ8ycqZuoYFlRyndfIgJ4o=; b=cCLMP5iDRvzGAFoA6GCPLP63xq
	B7+qtujBpV4mehQe/fa/Yhcyg0WJoEdd7dlJLhoVKrI7QQJ2uxSKVTDj9ACEOpLF/8OKmKYJnM80J
	3H7+JiSw705toNHgj+q+9EbJyLbJ9uooIFA5d8ZsDc5fDF7EOGq68gykzocasX029zfw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1woKd6-00059C-8p;
	Mon, 27 Jul 2026 12:40:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1woKd4-000594-06
 for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 12:40:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0Rj2zcqn98jOldeGz0E5K6wRnOBsmt9JdLwvOOzVFh4=; b=CyBKnRiQwUuybZpUBFXstrKgyp
 o6is+K8T8afiIQp+gidvgZPSXGoEMm1ALMyDN2CnS4NXZlkGkmIToMV1GHYBI0zLfL8NwAHl99/5a
 sZDkQmvv5cZoH9UCz27oawfx5jH6AWUazuIm83ceFdIAYevz9ZVc/oyDomN3zJ9s2WfI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0Rj2zcqn98jOldeGz0E5K6wRnOBsmt9JdLwvOOzVFh4=; b=C/lqvGF43zVKo6KWCVqW/H8mEh
 gS7FeiO6FX0MLpsKJyId2pF0R5LqvelFpXcmleLfOAQABwAxWcFzEjWPC0k9dPc+ankh9nOME83h8
 F28I5w6U0jbXDj1Mqi9vgelQ5krTnhbg4DFV2MuRQ8lgfUNtRIzPd1yuxmvciBTjb3k4=;
Received: from mout-p-202.mailbox.org ([80.241.56.172])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1woKcy-0005Eh-Ck for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 12:40:19 +0000
Received: from smtp1.mailbox.org (unknown [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4h7yqD2j8rzMlDv;
 Mon, 27 Jul 2026 14:40:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1785156008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Rj2zcqn98jOldeGz0E5K6wRnOBsmt9JdLwvOOzVFh4=;
 b=kGUZDSaVxH6Zg9f14LSqlkqNkv5jY1uFe5wRJaJLjCRkW13LxQUolznBpWWscDJI1atQi9
 5eQFmquo4cP9WeUz5WMG3b6BeA+G75emRwcxp/s4RaJVUX9fJT9Xmn/lHOSi2F7KH/L9Iv
 4luClqbSPF1v/YVfJFJ63EmQ0TrdZueUC2ALix6bcAfXeyDFSjGhhXbiuaBtQ6qGOJ2U43
 4UoJhM5guo/VuZabFwgw9zVwWNDj+Qj6+CPfvXe1mhkJY6dogojSyg1lUOd+12op0UhaXf
 rF7UtJDFXiNWoqlPBlMwjTXO/13POpvkbP1Ws/kSq7fR1057HrICYvotnzlMSg==
Message-ID: <33cc1af8-e206-4c65-a54c-045d989259c1@unstable.cc>
Date: Mon, 27 Jul 2026 14:40:01 +0200
MIME-Version: 1.0
To: Marco Baffo <marco@mandelbit.com>, openvpn-devel@lists.sourceforge.net
References: <20260727064041.1872159-1-marco@mandelbit.com>
 <20260727064041.1872159-2-marco@mandelbit.com>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: <20260727064041.1872159-2-marco@mandelbit.com>
X-Headers-End: 1woKcy-0005Eh-Ck
Subject: Re: [Openvpn-devel] [PATCH ovpn net-next 2/2] selftests: ovpn: test
 operations in a foreign netns
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
Cc: Antonio Quartulli <antonio@openvpn.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

Hi,

On 27/07/2026 08:40, Marco Baffo wrote:
> Extend ovpn-cli with -n to resolve an interface in a named network
> namespace and include OVPN_A_TARGET_NETNSID in peer and key requests.
> 
> Test peer get and dump requests issued outside the interface network
> namespace, including local lookup and invalid NSID failures.
> 
> Signed-off-by: Marco Baffo <marco@mandelbit.com>

As discussed offline, this batch will be resent with the following 
modifications:
* patch 1/2 - no changes
* patch 2/2 - modify existing tests rather than introducing a totally 
new test
* patch 3/2 - add a new patch that modifies userspace notification by 
adding the TARGET NETNS ID and disambiguate the carried ifindex.

Regards,



-- 
Antonio Quartulli



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
