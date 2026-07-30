Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B102AC531D0
	for <openvpn-devel@archiver.kernel.org>; Thu, 30 Jul 2026 08:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8x2K8S4KNtn6VSqBMyx52RoRqSG5zSFtdd/QW8Sw4Kc=; b=ksN+Je+J2cyvqArYpEOB/aISjw
	+RLOe0fm2UeBTLxjizqAppAksVnPWtxrsi7mczzrfa3meq8d84w8+Pxy2EycrqRAQS5u1piRMx5Qz
	MObu/fW918WLbI2w/xiADIgr5TJo6gb5awGEXcfG9MbeMY2fLCdicyqwNj0qEXMCGq9M=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wpLuY-0000uC-IG;
	Thu, 30 Jul 2026 08:14:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wpLuX-0000ty-HL
 for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 08:14:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qkqF8g9XG66CnlfckOmmXXHApcJkwdMZeRzq/U0sjt4=; b=l0hK9R7lea2amwXfMxyavYmUUe
 eflSrXTgD5yr+J8aLRjZFeIdxhLlA4LdkJ8hfVZIG/afIU8a1ZS5dEvUwulD122gHqvCcbROANO9v
 TAjiVxiICsbYRpyn8C4yo2cgrk07BUCxsCO/brBtkq5OEQH4/VMMuv77P0WnvFASfpRU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qkqF8g9XG66CnlfckOmmXXHApcJkwdMZeRzq/U0sjt4=; b=LYS2olyyEe78BIgeHJVAVKxY8N
 A/oPyWtLq1dpN0e9o2CgAmaScRH+FYlFguP5l7EF5g7gG5YK9VneMiROOIYSejzf5CyvrvSgmgtDv
 Ct37ZkfHaJT4+2JpIKjldu+HjToWssP6leGDD0Ra1fW7vZcmthc1Yza3j9BkeaQRBcsw=;
Received: from mout-p-202.mailbox.org ([80.241.56.172])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wpLuW-00012f-LP for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 08:14:38 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4h9hnK1nkhzMlLd;
 Thu, 30 Jul 2026 10:14:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1785399269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qkqF8g9XG66CnlfckOmmXXHApcJkwdMZeRzq/U0sjt4=;
 b=K0sKZ8XdzvPj19OaOVMKT6C9hQtobvpwJumD101ot2J4vvPbubLCYYWZt3sTSVmJKoAtUX
 1cw3GwQnDPXJyai3GSWJmdsVxSRt8B79Kv9n43RjIqT3gzVxVrhXtUg/lAWfnhUWzEVXBU
 ss0z0pTCuo3JnxZlHEEZgRROU6v0bFkPaQMGJMtyPn1JsOACFwenIfxTS1ZfS6JyZPMfof
 U5KD27v7aQMy92DQyq/wYziI6g2VxXGq0lvtvqlRpnOhJ36saehAmBXd626OunSfg/dKJp
 H5fRrA7F6YRZTSlHw3HcRAosdpZhzEN3pyuoXCfSE54vKF/9wHEaN3KNoBr3/g==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=a@unstable.cc
Message-ID: <165138a1-2c07-41f6-8638-c4dc27ee60b8@unstable.cc>
Date: Thu, 30 Jul 2026 10:12:13 +0200
MIME-Version: 1.0
To: Qingfang Deng <qingfang.deng@linux.dev>,
 openvpn-devel@lists.sourceforge.net, Antonio Quartulli <antonio@openvpn.net>
References: <20260724014926.102443-1-qingfang.deng@linux.dev>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: <20260724014926.102443-1-qingfang.deng@linux.dev>
X-Rspamd-Queue-Id: 4h9hnK1nkhzMlLd
X-Headers-End: 1wpLuW-00012f-LP
Subject: Re: [Openvpn-devel] [PATCH ovpn-net v2] ovpn: fix incorrect use of
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

On 24/07/2026 03:49, Qingfang Deng wrote:
> rcu_access_pointer() should only be used to test the value of a pointer,
> not to dereference it. As it's in a spin_lock_bh() critical section, use
> rcu_dereference_bh() instead, avoiding an extra rcu_read_lock().
> 
> Fixes: f6226ae7a0cd ("ovpn: introduce the ovpn_socket object")
> Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>

Applied, commit 55c6dcf4e97e7fa82b29015378342f6f14657d0b

Thanks!


-- 
Antonio Quartulli



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
