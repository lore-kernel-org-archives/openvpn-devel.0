Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE903C5AC67
	for <openvpn-devel@archiver.kernel.org>; Thu,  6 Aug 2026 23:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KRvnAgl/28hLJc0/0H8zlxpglB+tIvCFWg8uLaDqkn0=; b=gOMwCNb0+/bFO5xdgLfsBJX8GL
	jI51Tc6j8o5emPqAVU2UfBXi2DOaeAwGuveRMwE/+znfrs253P+StZG1NVAQmSeC+/ToAkTkNe5wU
	ncxG5octD/XtO4ULFtA3+YHnGIHgq6xvSRwTaT0jfpRIboXrxgV4ShUpQAIoXjlnRQYo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1ws7x4-0003jo-I3;
	Thu, 06 Aug 2026 23:56:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1ws7wm-0003jY-W9
 for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 23:56:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9psssIDgVsuq1Yo9yVNoroAGLETJp501Kfctvh8wOqU=; b=IQDA0haFXKe0xLDcgNW7PyG00t
 JaO0lYJDRe3CqXSB/a8LpjFySypCkxnGOcma7tqCMsVPRE2NTzH96PJ7Css80YKA+65aNRrDQsy24
 QTq7nQFwXlWVrW+UhlZTdpQJ2100TLEXu5Dv/wPU7+dEtdFxd46OpftoHP0yqR9JEl9o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9psssIDgVsuq1Yo9yVNoroAGLETJp501Kfctvh8wOqU=; b=b8Hlxw3FRV4tT74vF6kqZkqqql
 k4jEkD7+V7QYlTB1J0Wr9CRyoLDTsP6V7mzBsFdtpIDBlKVtGlFffW8jpNHJbZy3F1ByAkSp1xjGY
 TPX03XWlKJfo8WMDysOEtSXLo0iptXF9L4Z9GcWhnEkx8so2sKrAqv/Qocqjfr6LnhP0=;
Received: from mout-p-102.mailbox.org ([80.241.56.152])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ws7wj-0005y7-Vh for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 23:56:22 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hGPLk03y1zKrsl;
 Fri, 07 Aug 2026 01:56:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1786060574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9psssIDgVsuq1Yo9yVNoroAGLETJp501Kfctvh8wOqU=;
 b=Ur8iUtr9lVVE/YfqI9vECgkjER+tMx4LX2j+Aip9mprs7Y1JaxY/s4EVcu3tq0PMnZL6tE
 DRihynrIDo2uEdX18vIbJ7aQ+OgQLTghNw10rGouwilCfyyC8ZyBCijPYo2Dfkul+5DiMk
 8jLx/GvtayEYzyBsTgbw4pXfiMOT5kmq7QNAfdAMWCi0HVV8R5xc//lzwjbiuthoKzMr+f
 VBHhxCuyQ8CXt/ha2nDkT/WoWepIn5LHBMqKz7SBIH8Z+cUcg34RVMSJCTeUuItVD/rg7b
 FTZoVOrsjRA9Pk/jpNj8gV2Mgu0oZcgY5q1hP6/wPyN4nE+y9jbAInWgWVmN5A==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=a@unstable.cc
Message-ID: <529105ba-c071-4244-bc36-fbbaedb3982c@unstable.cc>
Date: Fri, 7 Aug 2026 01:56:11 +0200
MIME-Version: 1.0
To: Ralf Lici <ralf@mandelbit.com>, openvpn-devel@lists.sourceforge.net
References: <cover.1785318038.git.ralf@mandelbit.com>
 <e7af10c8c2e2ece17a3861d03959336238205fe4.1785318038.git.ralf@mandelbit.com>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: <e7af10c8c2e2ece17a3861d03959336238205fe4.1785318038.git.ralf@mandelbit.com>
X-Rspamd-Queue-Id: 4hGPLk03y1zKrsl
X-Headers-End: 1ws7wj-0005y7-Vh
Subject: Re: [Openvpn-devel] [PATCH ovpn net v6 3/6] ovpn: initialize TCP
 state before registering UAPI
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

Hi,

On 29/07/2026 12:21, Ralf Lici wrote:
> ovpn_tcp_init initializes the TCP proto and proto_ops templates used
> when a TCP socket is attached to an ovpn peer, but ovpn_init registers
> the generic netlink family before initializing those templates. Once the
> family is visible, userspace can create an ovpn device and configure a
> TCP socket while the TCP templates are still zero-initialized.
> 
> Initialize the TCP templates before publishing the netlink interfaces,
> so externally reachable setup paths can only observe initialized TCP
> state.
> 
> Fixes: 11851cbd60ea ("ovpn: implement TCP transport")
> Signed-off-by: Ralf Lici <ralf@mandelbit.com>

This patch was dropped in favour of another patch of mine which was 
basically colliding on the same change.

The mentioned patch has already landed in net.

Regards,


-- 
Antonio Quartulli



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
