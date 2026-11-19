Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD12606A324
	for <openvpn-devel@archiver.kernel.org>; Thu, 19 Nov 2026 10:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ITUpFviK;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=XEpRhcXL;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jC5l1LSs;
	dkim=neutral header.d=unstable.cc header.i=@unstable.cc header.a=rsa-sha256 header.s=MBO0001 header.b=xE5yjx1h
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=oEcXgbnQxd69DX4pynr+iMuls8JxZN4gHfvwVAG6SDY=; b=ITUpFviKunde6BK0aWOaks6zn7
	Q8Wypml2sFHchu7A8nWMviQFmG/xUWtHWzwoyG03WKTx7hRNs5/v4UEUfoiYvAQ/v2SUpLgmEGEW8
	+XLXJ/Oz8mLyoco7GXYkUjFkCN/xfgr5YwD+miH0z2fveO+1TxrWfl6+P+Ss0W3w8Fg8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTzWf-000000004UC-3Kdk;
	Thu, 19 Nov 2026 10:37:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <a@unstable.cc>) id 1xTzWd-000000004U2-1dhe
 for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 10:37:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UoxEx8v0q+L9nVC/qLMN1gdqujh5EQ0SZWlit5cYj+Y=; b=XEpRhcXLBqVQKHuW1UkAGNq5md
 q8527XWu/xNXi5bOFeafYbIqEQ67ayQUXpYz8+c/tWKI4sox67ndiGtQ6rG6mqLCj8TFKS5Jk52yX
 7yC2aZ4j8LTuDA3gUS3KiYoosOAwtqzxq1zIxYTsMunMDIzDW3MmqdL2/rDdPPTn7Rvw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UoxEx8v0q+L9nVC/qLMN1gdqujh5EQ0SZWlit5cYj+Y=; b=jC5l1LSsZRE6l+UB/kOvhEzQHr
 LxhDcmj+GKchxXOMmvzPexD0y1rfsACMKKnxOi7F1djFQAqOG3mQpjZdkZLEioL1oCY93MGBTxNtc
 EqYoK9ewIBzeVNaqyH+hPiXSrUuOeXUO2YE4XPdu39t6rnFsTFOl7F0hH5W5mYiu37cc=;
Received: from mout-p-102.mailbox.org ([80.241.56.152])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTzWa-000000005ix-1KY5 for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 10:37:55 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jVZfv6pmvzKqg8;
 Thu, 19 Nov 2026 11:37:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1795084664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UoxEx8v0q+L9nVC/qLMN1gdqujh5EQ0SZWlit5cYj+Y=;
 b=xE5yjx1hMLa2/pfRIGFHnJYPAxCTkfgI7/KE3H0g5mb4/H8LEOBXuTl91MHNRlk9r+g62C
 Y+7/w5Xn9RkoO3WJT9WdagFVJoVHrWdb4oeAbDz/gdrIg2Zkv1ofZuAFMNUqSOwEWikQaL
 gVERuHlHZSVWbMH5IqaU06SpsZt908fQ1bVmlCYjHtoB0x1/OQ2CRQSs2j6nWZbBAmVU13
 4IGkg8qUnPEHxknm927bhn15l63Vm4Tx8qQuJUKB5Y37wx1mJP8GUu9js/1eH7pesJzKVn
 8y0pEomd/7orj4RhKJYBkiJtRV3slCBKFb07kHxIodM+AEk/mz6f3aIhlUFAzg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=a@unstable.cc
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 19 Nov 2026 11:37:41 +0100
Message-ID: <179508465244.3875260.17897001461413318961.b4-ty@b4>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <tencent_DB0ADABF741A42D32620ADE82AF77005FC09@qq.com>
References: <tencent_DB0ADABF741A42D32620ADE82AF77005FC09@qq.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jVZfv6pmvzKqg8
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xTzWa-000000005ix-1KY5
Subject: Re: [Openvpn-devel] [PATCH] ovpn-dco: fix IPv6 VPN address
 comparison in peer lookup
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Antonio Quartulli <antonio@mandelbit.com>, antonio@openvpn.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Antonio Quartulli <antonio@mandelbit.com>


On Thu, 19 Nov 2026 12:40:08 +0800, Liu Chong via Openvpn-devel wrote:
> In ovpn_peer_lookup_vpn_addr6() the word-by-word comparison uses
> 'continue' on mismatch, but it only skips to the next word of the
> inner loop, not to the next peer. The comparison therefore has no
> effect and the first holdable peer in the bucket is returned even
> if its IPv6 address does not match.
> 
> In multi-peer mode a packet can be sent to the wrong peer whenever
> two IPv6 peers share a hash bucket (with a single peer per bucket
> the bug is masked).
> 
> [...]

Applied, thanks!

[1/1] ovpn-dco: fix IPv6 VPN address comparison in peer lookup
      commit: 846f066640bb16abdc8a8b0f9cf0efc8437be774

Best regards,
-- 
Antonio Quartulli <antonio@mandelbit.com>


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
