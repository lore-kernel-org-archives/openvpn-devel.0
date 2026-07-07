Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 861A5C43458
	for <openvpn-devel@archiver.kernel.org>; Tue,  7 Jul 2026 10:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=264jHEqB1SvPqkg/HofJNPNHBfXZ8Hm0nOYn0H43tQk=; b=iKF/rtvbKatXNMrC1tk2Vi8zDh
	hvIcgPRj0WQQH3iUcuT8xB7KbrZdqlsujh+PFBCvu8aDqG0XtxtXjqUZVrM8WR0/31dukcRj/2MkC
	2RyrS8nHN4X+6tQgX7X4mbqqEqOJ171D58Cl2P6s2MJiDMcUGMXwGYdEZLICCTRqNayc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wh35G-0003p8-FD;
	Tue, 07 Jul 2026 10:31:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sd@queasysnail.net>) id 1wh354-0003on-NI
 for openvpn-devel@lists.sourceforge.net;
 Tue, 07 Jul 2026 10:31:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YX5w09be0Ky7s0QfSj4L80HdiEs7blhQzepdkAe9JxE=; b=AlW/eRxD8JihBbfnS2Dbtos+gA
 7HGVAuJPxVMyLFIq0/h/mMWz3tOkIcUaPl6tzJpT9AaAJGK7i1pSY8XMRi8ZQMaKgz9gXkE7jF7mr
 TN6s/0v2LIhWVs3tle/5obWqOCiJqf95pOTyoJTfGLt2TuG6SETMAJMBwKZi2YQub2CU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YX5w09be0Ky7s0QfSj4L80HdiEs7blhQzepdkAe9JxE=; b=PZgzllwxLZZi42HQWY2PQMShsh
 3y5ov4TDFDheeHq2g6+vjmqva6AyOrIP9B6JxxWSanOv9yrnFDhKqDikDgBz9G1cPojHI7F8BygkU
 /BR/9lEXgw1Z1uK6lX1isdR5CpgzJOr7blQAUZrEyfoP2i1Ygv70cjxwLWTuQbDC0CQs=;
Received: from fout-a6-smtp.messagingengine.com ([103.168.172.149])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wh351-0000Av-IJ for openvpn-devel@lists.sourceforge.net;
 Tue, 07 Jul 2026 10:31:10 +0000
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfout.phl.internal (Postfix) with ESMTP id 5ED4DEC0193;
 Tue,  7 Jul 2026 06:31:02 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Tue, 07 Jul 2026 06:31:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1783420262; x=
 1783506662; bh=YX5w09be0Ky7s0QfSj4L80HdiEs7blhQzepdkAe9JxE=; b=B
 aGjU39t2BXoLfS42xAYNpf38D1/utl7W5TFzQjoy/W+0WECjDt2eZVZENAyNXEDr
 Hp4M0BLB8XVXf3FKJ2NWYFF2b9BZR04nB5CgfPWRhNjnyUweOu2rESmf++RET9Bu
 I+5JF51LflfngIOfiHoWfUWrjQyCcRjjsjCzmeJ5od+6E0BJUjiYBqnDx7NVRzAx
 lOzRg18j3FA+MbBoCXopER1g0BeEx72iAKH3iHeQqKnCPzv4mTSgPqd8ABE37kW7
 bUEfV72qgftb+QtuV4BVJZMXgwIs/CkaJAVbnYBy+ikxe852qfDm0GFwOHyK+bJU
 CZyq/4k0eGUL+2iqoPlEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1783420262; x=1783506662; bh=YX5w09be0Ky7s0QfSj4L80HdiEs7blhQzep
 dkAe9JxE=; b=WF0ew+6Oeoev8e17+G6nS9PMxCWPBBl4EP1ZXfvPjtIDlVToIsF
 6iU1Iva2YwziPms11XnRP7xLabUBDyhRplWi1xMRV3ev6gyu5M9K2lqdW24qTtzi
 1/2yRlcmK+GChcfiTwaAfmuv8CsuDM/f2f1EYkU/bK7Feo4j9xPZYmYLNyeijWXL
 oIlq/Act8RbKpjMAV7mLnY2XsJdrwLFUaL4zmsFNuWMCg6FrPgAul6wEa2nhCC5g
 ma6ZnRT9W9M3A5ghnTJVG09+fHFtgOyGt18UeVjOoiMdqisLEdNM2cHZFWH/ckFS
 cIJOOM24clIYVeEtdpzz9lRsaFBqonLyiyQ==
X-ME-Sender: <xms:ZtVMatukRs5oY2lGYrmwA9h7YqEeIf4v0_RyOwf7ZHXdN9vJX-X5Tg>
 <xme:ZtVMaseSqAgvCbN_LPpBHsVIz0IcOwJwMQ9XY-l2GH49bZWjlG3WGIrxMlD1TUfGc
 7LQucM_fkMdXV0vAWM5gRkFQ3ipzg-312hb-NBfKkuDRxe5XvOHj_A>
X-ME-Received: <xmr:ZtVMauY-Yjkcdr6tQnkUZ1O94FSigR2eJSLyKUp1NHRNeqy5DgF-r1fYcS4>
X-ME-Proxy-Cause: dmFkZTGNYE0RGdTsl1U7U/hAlQiot15VWc3NrBaAgVi41FKW/t7mH34KOUngBzbhjU96oF
 mxn9HQPtgQKXl0GPWdsCYd4vhCw5d1D3rlZj3LJxxtrPpxue7OFDpuVBOh8Zbuv/kmHEZT
 uhmwAG9zXBV2oWpkg0CTR6ZzGJ0zdoN0zlqdVuAIh1ZfNgrAiP6Zq2m+mvAQ2UmvRo07gj
 tU231LNM+H09bSORNehC3YR70mixic3cxlx4c9mNb02xkvtt6OD6NETYxE5e3eIW/P8IWu
 og8kvmMOezoYQwFBadOGmpbeR1vjnFq18yCEsoFwAMPW9UXg6cVzK6jg2cCwSEyYdU6rOm
 avWnS5jc0YUrguZElDrNgczb9BsF7+pUDXKQogtHgyP12jISnCmDcN+8Zl/i+DXU3YvaO+
 N4BhZwE6jJIB/MWr1IRtpZCMK3wkm36SEa/kLDB2o//oTdKc1etW5WlMLvoygvOsr6zjTm
 tHew6WCXtHAdI3tf2a/dKWEVlbq/cCg7GTAsynoYPEu5VPtYO+q88t69Q8xhrctQ7AnOf7
 XhBrNf/81Ujq1hJJBnxptDtrFAtixAVAb5d9hUWFb83vKjfMMjBzVddFdsTSWAJ29SLCfR
 2YUqgAujM+8g2BitACg00NG1wGpjmXbRQQP//obEUx+VM71qlJBEzCzusctQ
X-ME-Proxy: <xmx:ZtVMavW0OUtfpERc-2L_2Ifn_btxVKfg0mXi-LdVwf7vgfwGYBIpvQ>
 <xmx:ZtVMagioyBEekMagKiMIV7nPsMdA9hTVp06Wt1iKp726A_XMeYjrGw>
 <xmx:ZtVMatWmXk7iiDUtseRvb6HuPnC9UhtfAM_oTfSuthOUFx6jieX7qA>
 <xmx:ZtVManMZIcZJWF_z-cXvUzSJPWnxoDc5fxpmWWKzoKHpDKpujTPwJg>
 <xmx:ZtVMakc2_oue27I744-gSjbJiyx18ABScO4Nxd6GR1u07LQbztLpo2w0>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 06:31:01 -0400 (EDT)
Date: Tue, 7 Jul 2026 12:30:59 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Ralf Lici <ralf@mandelbit.com>
Message-ID: <akzVY1HGSEELwvis@krikkit>
References: <cover.1783336121.git.ralf@mandelbit.com>
 <6e44855f0fcd704da43dd83b42a1236cb804c76e.1783336121.git.ralf@mandelbit.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6e44855f0fcd704da43dd83b42a1236cb804c76e.1783336121.git.ralf@mandelbit.com>
X-Headers-End: 1wh351-0000Av-IJ
Subject: Re: [Openvpn-devel] [PATCH ovpn net v5 2/6] ovpn: use nla_put_u32
 for the key ID attribute in ovpn_nl_key_swap_notify
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

2026-07-06, 13:34:00 +0200, Ralf Lici wrote:
> Currently, in ovpn_nl_key_swap_notify, the OVPN_A_KEYCONF_KEY_ID
> attribute is packed as a 16-bit value despite being defined as a 32-bit
> u32 attribute in the YAML policy.
> 
> Fix this inconsistency by using nla_put_u32.

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
