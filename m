Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 358A5C54F51
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 14:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q8tPDShQUw7WsmkPncmJaDK819zd1lRmOZezPf02bbI=; b=l1TZjcojCnkyRj8yVM9QxTdZce
	6smgaIeNtJRwlX+JuA2G4uSwZ+AVC8VLF2o7m2TtetOLzJdJVw4PiFpljhtJ8T6ZRf34yUZX8Mz2w
	a5kkJy9Gt5Fr+EpZdd13tXw0vAZcfKLuIjl3WX48419tUWzK2q7yjlhq0LbCxC15K6j8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wp50U-0006QH-Fk;
	Wed, 29 Jul 2026 14:11:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wp50A-0006Oi-3C
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 14:11:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rYRwwAtd6kuHU0h7oMIVhWL9cLDVgbyUPn8xPzKHdGo=; b=MS9R4A2P+Hrk39Z54MbU9Pzjd7
 fnE35b88+hFvRnK+OCdUV06zF+/xFoM5yE07lZwejHYFxblTTHNcNIvhB9Csjmcm0WXFYEZVNajRv
 8GBlnyw1EEsJJw1U1ehm5LeYmF1oKxqdu20lkK/PfjGqcaXjpkG1HwDLqDgLvEjD8klw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=rYRwwAtd6kuHU0h7oMIVhWL9cLDVgbyUPn8xPzKHdGo=; b=BYD4ARkeK6tcWzAMZm5cL2LxJs
 44ESp3XHPcGZhIzhopyfkQrhqB8i5wo6+5oOTakYV8Oxbc4jgr3PyGdd4jjsRsaStio3PAsk7k7ri
 3L8Z7ykH03wufXFD9dHT0P+BotdYXaxPgPF1D5KiAnzappZtQTJV+lSnz3w/nMVMbI1Y=;
Received: from mout-p-202.mailbox.org ([80.241.56.172])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wp509-0000LM-Br for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 14:11:18 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4h9DlK33NPzMlLr;
 Wed, 29 Jul 2026 16:11:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1785334269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rYRwwAtd6kuHU0h7oMIVhWL9cLDVgbyUPn8xPzKHdGo=;
 b=05PBEzqxothAsWMwLTviAClCO/NNdaXd65jvzOQsponb/klh3uOC/uO//2Nxjx/3hGD3Nv
 BmKQgwsNBC+J75z4+SQHKcXDgLyvpnRhusQK/j8Ffc2p7W5cZbAUe/Ga4YHtPfwJDWhBLz
 Lsjy0mNET14R+Vi/hyQfXxxpUYFCP5uua4eEwPIvkhR2yIuilLlAW5IzWGl8avtoiqgmof
 CpEuaRK9FoDVpYruXF10F5sKpFbBf1TfhK5QmkN4/CFsFOYMJ/hYTqjpIXbk+B1UMzs/RH
 wOljTDMnO5WCVYkUOULcGqWHPUUAH2Qp/L9LWq6KcJf9sbZwj2K+kGFfLTgrcw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=a@unstable.cc
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net,
	Ralf Lici <ralf@mandelbit.com>
Date: Wed, 29 Jul 2026 16:11:06 +0200
Message-ID: <178533425550.3340055.9915636485928308820.b4-ty@b4>
In-Reply-To: <bd44d25247e13a6f0c7d72a17db03cbf17b351e6.1785330764.git.ralf@mandelbit.com>
References: <bd44d25247e13a6f0c7d72a17db03cbf17b351e6.1785330764.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4h9DlK33NPzMlLr
X-Headers-End: 1wp509-0000LM-Br
Subject: Re: [Openvpn-devel] [PATCH ovpn net v2 1/2] ovpn: add missing
 rtnl_link_ops->get_size callback
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

From: Antonio Quartulli <antonio@openvpn.net>


On Wed, 29 Jul 2026 15:41:30 +0200, Ralf Lici wrote:
> ovpn_fill_info emits IFLA_OVPN_MODE inside IFLA_INFO_DATA, but
> ovpn_link_ops does not provide a get_size callback. Consequently,
> rtnetlink's size estimate for ovpn link messages does not include the
> nested mode attribute.
> 
> Available skb tailroom may hide this mismatch. When the remaining space
> is insufficient, however, ovpn_fill_info returns -EMSGSIZE and message
> construction fails.
> 
> [...]

Applied, thanks!

[1/2] ovpn: add missing rtnl_link_ops->get_size callback
      commit: 6e9f539e4f01153651dd77609b5ccadd44b74df8
[2/2] selftests: ovpn: add rtnl link mode check
      commit: f4a57dae061c8542dc29de1a72168a0048d29283

Best regards,
-- 
Antonio Quartulli <antonio@openvpn.net>


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
