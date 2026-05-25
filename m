Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85063CD5BB1
	for <openvpn-devel@archiver.kernel.org>; Mon, 25 May 2026 14:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CdUVodXmZD0dXiHCCV6nZ82noHQ6JRTCn2YfIDTZzLw=; b=XZKibXI90BOi9goX7Gw5xJ59Sa
	tj2rYfXMoeYFXAoSNQN6v83zLBZ9i03vXcU4k2WBCRJ5OvNH6n8XLS9C0Zph0Oci199p8mLj+efH3
	pZ4ca0r5Iw2kd9sTzpbgojuQWnb5IC2xelx3xFEvxRao6M6vsE8Zs/QsivsZEVtd/EAw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wRWR9-0005Ij-Nx;
	Mon, 25 May 2026 14:37:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wRWR8-0005Ia-ID
 for openvpn-devel@lists.sourceforge.net;
 Mon, 25 May 2026 14:37:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZdaBvBBu2Igrndx3PA+jPv++YZ8tnvDc59YfbwO8tL4=; b=N3QT9zNhtQaGJS5qJeXrhDRKXj
 V82acj1yX/DTLD4cZ9DeREodT5hyWP9rQHiMrMVPpmwsqmzBNYmzhvNH1dmGDdks+J5ifPdzY3726
 I0s20aDeqZSfWQm8R4x/kQvbg/aGOm3fpYd1073o6NJkI/bnQ0j5mO4WKN9Q59sGuLBc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ZdaBvBBu2Igrndx3PA+jPv++YZ8tnvDc59YfbwO8tL4=; b=ZowEmeyS/mFCQAjbwITtKCUeUX
 7BESdoFek338bekxR5GyT4YvpBlGeTsnAfl6kQha3o/VN72SN5Lmp6s8Z370mgNC8s6Ax0C2kbNqr
 GP555ZisX6lSr/AT+j/eTDppDKIyAf7/33/OvJX33tQACkTXZAaadP5Zq9gDJSf5OxRM=;
Received: from mout-p-201.mailbox.org ([80.241.56.171])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wRWR5-0003vd-Cg for openvpn-devel@lists.sourceforge.net;
 Mon, 25 May 2026 14:37:46 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gPJPl1T9Rz9sX2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 25 May 2026 16:37:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1779719851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZdaBvBBu2Igrndx3PA+jPv++YZ8tnvDc59YfbwO8tL4=;
 b=1KQqdiI2cio+BQpJ0QuyiCS+zlg/v09vG7FzyLdI+zVVSd1kM8K4qpMzBVcc0BGkm3uZG5
 T0heXHeAYHXrwR+ScZ0WWTpTPOOAU8wZMpC/ENyGxABeQSIVWmzVLo8NLh4ctRI8GfHUDS
 iLKLOy9LEDoZLY8svcWn5FO/FpVHn+JQtD2lpskrNIgm7ZwgcZVc4JxikW47Wd+4cBCOeh
 wR+ex72eLFm/ybzG8+aiamoFC0LCi1GfaBBrKiWlVVNvg5Lcs8iCENgsYhXSx77H+iICcn
 Hr9EcolgtXZ1+q/XIqq69dxgG3Q7/S3HM9ilKY7NSNco/fdxn3Lae7kSCUcdBA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=a@unstable.cc
Message-ID: <35d11b60-606c-453c-8447-d9b7606afdba@unstable.cc>
Date: Mon, 25 May 2026 16:37:30 +0200
MIME-Version: 1.0
To: openvpn-devel@lists.sourceforge.net
References: <20260525143606.1532168-1-a@unstable.cc>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: <20260525143606.1532168-1-a@unstable.cc>
X-Rspamd-Queue-Id: 4gPJPl1T9Rz9sX2
X-Headers-End: 1wRWR5-0003vd-Cg
Subject: Re: [Openvpn-devel] [PATCH ovpn net-next 1/4] ovpn: account
 user-triggered allocations to memcg
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

Sorry, this series was meant to be tagged with "ovpn net-next"

Regards


-- 
Antonio Quartulli



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
