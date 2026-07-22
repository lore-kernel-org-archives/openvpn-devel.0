Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12124C44536
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 14:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:To:From:Date:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8BnEheE2CLgf9L7jFR6hBDkQV1c5hUR48sxsqIsXTbE=; b=X/fTMRGUHZQCiIGS2e7wkuGrWd
	KgSrn4NAqYtEMmN/2dKdqkJBN599AUQtYjJUhywukUB2a3BeEdgXuzunmYgv2A/I5n9M0MDgmTm+E
	VEyjaJrxL5Wx5yZSF/FJUwkQ/BZoc9czPlCo2/l5TsLyXxVZpotrYPcqgTMP7V621KR0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmXVj-0000ew-CF;
	Wed, 22 Jul 2026 14:01:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <frank@lichtenheld.com>) id 1wmXVg-0000en-DY
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 14:01:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Subject:To:
 From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Y8fVtpI8L6E9ZSOZml206K4ijGgQ1P5OpdkX/FJjetU=; b=BKtWEChd/34p/KtXphsJDrnveT
 mTZabh6qSmh9cj9oqOK8ZYsiJIX8zm5SFCQRE/2268HR0mZbaodUen0Se5n9dgyRrj3y8N8IbD/s2
 NOqliiyF2m52KVhtPbjmq6D9Bs5S8LlOd6NtUsBsbmb4a4xW1iiPV8Uiy2GfdzAkWymU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Y8fVtpI8L6E9ZSOZml206K4ijGgQ1P5OpdkX/FJjetU=; b=W
 0TF+SjdVWqPkJ0hrq8wrBJoHfxMltc9+N8dJdHiMTQx3Qjka/4PCK9Efcy7RwuNuLGnNS2F5qygK7
 ci0NLfK3swgYjCXjBZ3rn8iEeVFETi99Hw2KZVAsLGMgK5ZswN9gU8gwot47qwv0Ks0lPEoZZL6C9
 jp4buO6Fam9KAYG8=;
Received: from mout-p-202.mailbox.org ([80.241.56.172])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wmXVd-0000cQ-Ak for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 14:01:20 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4h4ws11QlszMlFf
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 22 Jul 2026 16:01:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lichtenheld.com;
 s=MBO0001; t=1784728869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=Y8fVtpI8L6E9ZSOZml206K4ijGgQ1P5OpdkX/FJjetU=;
 b=gL1i2zraz+uC7gVHldD+Q4Y9qrn8JnxIH/BiAPFIE2ZI+3yiCLGpqedwbB7UjcAH6lZC/A
 E1dTbNvKbrNE+2VcP8ROTYTvZWsWMo02/Zw/y1MjN4Z74V8U80pAgMdJ1O+5cNvi6VY9mm
 TI3xcLHlsYT3Bc2biudCoKgki6K7UFdea9U/c1uNPqJvH4madydOveTntH53F8svxhYMOQ
 HZXkHowSAhTZG327yhji0DeVKQqlEjgxMIFS7Bg7820MD3eue9kekHO+HcrJVKKZUBo+W+
 /+wl8qoCVJDfDCMmvJGm7+kjitbdljBKTPBNCOM1tXyZg1pIVv/yot3u69Hxeg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of frank@lichtenheld.com designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=frank@lichtenheld.com
Date: Wed, 22 Jul 2026 16:01:07 +0200
From: Frank Lichtenheld <frank@lichtenheld.com>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <amDNI_-UbfdAGTnR@flichtenheld-TUXEDO-InfinityBook-S-15-17-Gen7>
MIME-Version: 1.0
Content-Disposition: inline
X-Rspamd-Queue-Id: 4h4ws11QlszMlFf
X-Headers-End: 1wmXVd-0000cQ-Ak
Subject: [Openvpn-devel] IRC community meeting summary (July 22)
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

* Updated: 2.7.6 release

We want to do another release soonish due to some pending security fixes.
But we're not ready this week so it is planned for next week (~ July 29).

One of the two security fixes doesn't seem to be worth an embargo, so we
decided to handle the review through Gerrit. MaxF will move his PR to there.

Will need a 2.6.22 as well

Regards,
-- 
  Frank Lichtenheld


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
