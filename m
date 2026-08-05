Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 978E5C55174
	for <openvpn-devel@archiver.kernel.org>; Wed,  5 Aug 2026 14:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HepJ8qjOo7SG++DRhDnvMkVmb1ki27srsyb0BIu0IdE=; b=btZS6v9UME9zcISIhDyOxDZieG
	P7FTXwtpb2lqAJe9oBJIYIIYnPZx9BA5HStlwFkgBkLDPkYkFCPUruKRpQNUoUod0qnfgtStTZwtY
	SwaCG26Nge35YqEmP2SWHiHxhDcbinhS3vWfzoTwlIWd/sdYWMCOSBrL1wGqHqbC3w8M=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrcQN-0004RH-8R;
	Wed, 05 Aug 2026 14:16:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <frank@lichtenheld.com>) id 1wrcQL-0004R3-PI
 for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 14:16:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=W0jOE+OJMYihPV0wzFNOUYe+UuebRZyK/e9wiD8fzkU=; b=WUA3UUrJGQ5v0ERwLGQvVo7LQx
 Rec688dle4nkGMZhZs9qiZSKdCFaRhEDcMJZwvhZfeHyVHOyn8zsH4kQJGNCGz0oBBRlhtySssyfo
 X39FPdEhlGkDToGb3ib4p7qRsKBkPvG2H6pBVq5DsdaOfNM3CrX0q154SH53yAM3Jxkg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=W0jOE+OJMYihPV0wzFNOUYe+UuebRZyK/e9wiD8fzkU=; b=EsvfmM+soSDfJopidEgED1WDQU
 gKGR7OCfn7d4FjG0dd2F6WoFnAPfYJoyvg0vO0ZmIqae9jYYafFrtLJfqpMOnwxwGkB+3T1YwkEN+
 EaHKShMxE9CooJIU6abxd1pJP08VgrbwF7XtRhYYURdMODrMdkuWqlSjvRgRk150Cz8M=;
Received: from mout-p-102.mailbox.org ([80.241.56.152])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrcQP-0000kU-GY for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 14:16:50 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hFXXV3FSBzKryJ;
 Wed, 05 Aug 2026 16:16:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lichtenheld.com;
 s=MBO0001; t=1785939402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W0jOE+OJMYihPV0wzFNOUYe+UuebRZyK/e9wiD8fzkU=;
 b=aC/H9OaDsMDNLMetVfxe5nmieW4gR6JQ/jLopGdJWfF7YmfhNHq0VeWR0jcAF6knMYojhY
 BXuAHX/3M4EkO1IUhdNUhT4cXyRZK8E0mr393BOSTHQOqF3Mu35Ex6HeMEVlYSN2UIMcT5
 OMnlCeBrQyVGxjU9Z7174OZv+n4XO3YH58Cb92DjZ5Hp6qGXNDPEvazvdY4fYy9wAkp9Yv
 Ld5xdTbuKE8NDrog+tq/AeaInvm+42aYChMFQqJhtyzMi1cXl4NGQ7Ze9LUFstWqw8GVA7
 1tzb3m8l9ng/TeOOyj4k5E+x6hORqHo86SF6oO3aOJAkj4xvnQfNM1GacKLuqQ==
Date: Wed, 5 Aug 2026 16:16:40 +0200
From: Frank Lichtenheld <frank@lichtenheld.com>
To: Marc Leeman <marc.leeman@gmail.com>
Message-ID: <anNFyCPJ1euSKfQu@flichtenheld-TUXEDO-InfinityBook-S-15-17-Gen7>
References: <E1wrZjj-00GxkI-21@paradis.debian.org>
 <CAH+fs=_5F66-XRw5VtdF4eFrt3GOQZvGfE6AZOav+CrusqN1JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAH+fs=_5F66-XRw5VtdF4eFrt3GOQZvGfE6AZOav+CrusqN1JQ@mail.gmail.com>
X-Headers-End: 1wrcQP-0000kU-GY
Subject: Re: [Openvpn-devel] Fwd: Bug#1143682: openvpn3-client: FTBFS:
 ../openvpn3-core/openvpn/common/unicode-impl.hpp:596:47: error: array
 subscript 6 is above array bounds of 'const openvpn::Unicode::UTF32 [6]'
 {aka 'const unsigned int [6]'} [-Werror=array-bounds=]
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

On Wed, Aug 05, 2026 at 03:49:49PM +0200, Marc Leeman wrote:
> ---------- Forwarded message ---------
> From: Santiago Vila <sanvila@debian.org>
> Date: Wed, 5 Aug 2026 at 13:25
> Subject: Bug#1143682: openvpn3-client: FTBFS:
> ../openvpn3-core/openvpn/common/unicode-impl.hpp:596:47: error: array
> subscript 6 is above array bounds of 'const openvpn::Unicode::UTF32
> [6]' {aka 'const unsigned int [6]'} [-Werror=array-bounds=]
> To: Debian BTS <submit@bugs.debian.org>

Interesting. We worked around this in ConvertUTF8toUTF16 in v27.1, but apparently
didn't encounter it in ConvertUTF32toUTF8.

Thanks,
-- 
  Frank Lichtenheld


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
