Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C30C9C43602
	for <openvpn-devel@archiver.kernel.org>; Wed,  8 Jul 2026 06:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4n5kTnFczwLwXvZcNWa6hsqixO2zJWZvhODoTdkoPE8=; b=gIynqEPm8undAdJlxVGAhh773b
	TVtnXRjwVOYIsBuGWK65kL+HKpGM88+0el2n4BL2uXnHUMP2sIAI+rQDOSqITahXh6cq/0G64L7/I
	CpOEvFCYXn2579Kcf/U9mq9UZ5Io+2JAE4PfADRGg/iSvlO8sUsLhzO1CfBbOgQfGSmM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1whMEf-0001UX-Oi;
	Wed, 08 Jul 2026 06:58:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1whMEb-0001UN-Gu
 for openvpn-devel@lists.sourceforge.net;
 Wed, 08 Jul 2026 06:58:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EHADjJgzmqQ8Kg/+VNv9yRzAqO9BMXW4gB7mby5nCAI=; b=Ml7rDfwSFQx5YehSOKCTGwFC5x
 Ww25olezmtjOPLZj3gs+uxYLMolfDWPxuxW2l7i/0DHAHV/OHDLSI1NWlMGnIpW4kecnZIN0k849p
 MvfHbsZulLJYPyBVK3AP25U9/qovrQtwb8ZhLSAMjS8VrzwoiQiScOHg09iqEw3TjiEI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=EHADjJgzmqQ8Kg/+VNv9yRzAqO9BMXW4gB7mby5nCAI=; b=c/mwy4cBmaeZm5WW/Dmu/eWUtU
 ns5hntWylkOs0Ly8maCyXxHaZS0PT57QU8hBEyrv07ghqt5bSwOVLBwLHuSGFkDz+BLUwvaTYDaYf
 6jMkVdpKMX74Tbfp3AQ0wVyNQ6jFAUmivPmU+tXtw70afLjfEp5tNnDff3v4IpmM3I2c=;
Received: from [195.10.208.40] (helo=mout-b-210.mailbox.org)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1whMEZ-0000hY-9M for openvpn-devel@lists.sourceforge.net;
 Wed, 08 Jul 2026 06:58:17 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4gw87H070lzMlwP;
 Wed, 08 Jul 2026 08:58:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1783493883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EHADjJgzmqQ8Kg/+VNv9yRzAqO9BMXW4gB7mby5nCAI=;
 b=UpsAJdeK2pWs5WFFkOOAO7QBC1TZLGQ+PiQ6hVmZML1MQmyVKJ8kNb2hhYgdxflbvQ5xTQ
 CNJamTWhksUJBRH/Qt/m5uuBMPKK+37v3789BDA9OvAviwhMH+rentsWF+GQWeGKIZ22C/
 RZ5CHfyO7YSJsNWvFYk/oxxC4rfQjQxmloNFeFaB/N6MFBTaA+H5Y9E3edIX3wab4WvPOn
 /C11xw1qujGy1K+RWXSi8IGBhtdzLUwag+MMkBMce5RZexx04Rq3zNjYgxiRkJ2/ICNr1Z
 dHPyTpw0XzqqbTKSyqTqaS9t0fMaBbLJffZvNZrwFunP8IR+YouhUeT/rVBz7g==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Date: Wed,  8 Jul 2026 08:57:53 +0200
Message-ID: <20260708065754.54220-1-ralf@mandelbit.com>
In-Reply-To: <akzSYPstl_VoWKV5@krikkit>
References: <akzSYPstl_VoWKV5@krikkit>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4gw87H070lzMlwP
X-Headers-End: 1whMEZ-0000hY-9M
Subject: Re: [Openvpn-devel] [PATCH ovpn net v5 1/6] ovpn: fix NULL
 dereference when killing missing key
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

On Tue, 07 Jul 2026 12:18:08 +0200, Sabrina Dubroca <sd@queasysnail.net> wrote:
> Hi Ralf,
>
> Sorry, I'm slowly catching up with the recent activity here.
>

Hi Sabrina,

No worries, thanks for your time!

> 2026-07-06, 13:33:59 +0200, Ralf Lici wrote:
> > ovpn_crypto_kill_key assumes both crypto slots are populated and
> > dereferences each slot before checking it. That is not guaranteed: a
> > peer can have only one installed key, and the kill path may be asked to
> > remove a key that is not present.
> > 
> > Read each slot once while holding the crypto state lock, check for NULL
> > before looking at key_id, and only replace the slot that actually
> > matches.
> > 
> > Fixes: 89d3c0e4612a ("ovpn: kill key and notify userspace in case of IV exhaustion")
> > Signed-off-by: Ralf Lici <ralf@mandelbit.com>
> > ---
> > Changes since v4 of this series https://lore.kernel.org/openvpn-devel/981d2ea51cca45138210aa52c6e5a0e55c0da7a0.1783099626.git.ralf@mandelbit.com/
> > - Add this previously posted standalone fix to the series so the whole
> >   set can be picked in order.
> > - No changes since v2 of the original single patch
> >   https://lore.kernel.org/openvpn-devel/19318904cf077d067cd4ec628a22bab03ed7dd29.1782993857.git.ralf@mandelbit.com/
> > 
> > Changes since v1 of the original single patch https://lore.kernel.org/openvpn-devel/9fc33e6f9fae10b9e372a3e06934d697edf5b024.1782829171.git.ralf@mandelbit.com/
> > - Remove unnecessary braces around single-statement if/else branches.
> > 
> >  drivers/net/ovpn/crypto.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/net/ovpn/crypto.c b/drivers/net/ovpn/crypto.c
> > index 90580e32052f..8cb7078a1d93 100644
> > --- a/drivers/net/ovpn/crypto.c
> > +++ b/drivers/net/ovpn/crypto.c
> > @@ -58,15 +58,19 @@ void ovpn_crypto_state_release(struct ovpn_crypto_state *cs)
> >  bool ovpn_crypto_kill_key(struct ovpn_crypto_state *cs, u8 key_id)
> >  {
> >  	struct ovpn_crypto_key_slot *ks = NULL;
> > +	struct ovpn_crypto_key_slot *tmp;
> >  
> >  	spin_lock_bh(&cs->lock);
> > -	if (rcu_access_pointer(cs->slots[0])->key_id == key_id) {
> > +	tmp = rcu_access_pointer(cs->slots[0]);
> > +	if (tmp && tmp->key_id == key_id)
> >  		ks = rcu_replace_pointer(cs->slots[0], NULL,
> >  					 lockdep_is_held(&cs->lock));
> > -	} else if (rcu_access_pointer(cs->slots[1])->key_id == key_id) {
> > +	else
> > +		tmp = rcu_access_pointer(cs->slots[1]);
> > +
> > +	if (!ks && tmp && tmp->key_id == key_id)
> >  		ks = rcu_replace_pointer(cs->slots[1], NULL,
> >  					 lockdep_is_held(&cs->lock));
> > -	}
>
> I find the "!ks && tmp" logic really confusing. Maybe something like
> this (untested) would be more readable?
>
>
> 	int slot;
>
> 	spin_lock_bh(&cs->lock);
> 	slot = 0;
> 	tmp = rcu_access_pointer(cs->slots[slot]);
> 	if (!tmp || tmp->key_id != key_id) {
> 		slot = 1;
> 		tmp = rcu_access_pointer(cs->slots[slot]);
> 	}
>
> 	if (tmp && tmp->key_id == key_id)
> 		ks = rcu_replace_pointer(cs->slots[slot], NULL,
> 					 lockdep_is_held(&cs->lock));
> 	spin_unlock_bh(&cs->lock);
> [...]
>

Agreed, this is cleaner. I'll adopt this shape for the next version.

-- 
Ralf Lici
Mandelbit Srl


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
