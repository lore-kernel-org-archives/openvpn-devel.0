Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53833C5AC7A
	for <openvpn-devel@archiver.kernel.org>; Fri,  7 Aug 2026 15:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:To:From:Date:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+dDU09EX8d5vq6CRt8iI88zXLP2VrGruJetr/H0oWr4=; b=jZ9A8NIvjoUs+qjpwTxpTQm0SC
	akyN6KQH9xcGJj+lXf9MtbQp/0CkL/v6brF7YEU5UQFpfQlQPlfTPqTHxysZU6H0oFJ744JGDZPzb
	urTZ57K1piQ+y7vJ83HSULhiGeFSprpE98gxeDALL28h4y+hTVgzlmAJxEf4upXQa09o=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsM8G-0007MP-6u;
	Fri, 07 Aug 2026 15:05:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <frank@lichtenheld.com>) id 1wsM8D-0007MG-4i
 for openvpn-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 15:05:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Subject:To:
 From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kG2jubB9+mYjRDZj0SPFVX5AKmtSA67xYu4ihBjjy9Q=; b=RptOQuWU5xhAI1V1sVKegf4Vq1
 r5poZH+AqiYvpGD0aT3wRpVWSED70cawpuRLEeznRBVLwG+t6ryBZk3iX4xH56YWcmatJ0leJjvnV
 yirV/PAeNoE/9gjYs6Mw/ovf8P7TrcJdKati8tg/bQzLzcwxpNfjpWpKYieWzuskV5Rs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=kG2jubB9+mYjRDZj0SPFVX5AKmtSA67xYu4ihBjjy9Q=; b=C
 i1MMJ/VKVvgWsaqOuB9rq9d5A+JXdJSFMYSdcAVUe9SDx4NL5NDb61QRBZzwQ302XNaCnIgUndL3d
 Cvl1Ks1g09i+OP3PbETLDcaxdy1Au7DXMihMYSM5C+I6QYfwOfX3+NvoE/6JtP1cd3XulwX5/ABeS
 FcyRcSKuBzIEUWkw=;
Received: from mout-p-202.mailbox.org ([80.241.56.172])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wsM87-0006Ei-T1 for openvpn-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 15:05:05 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hGlpN0hSNzMlMk
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 07 Aug 2026 15:47:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lichtenheld.com;
 s=MBO0001; t=1786110476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=kG2jubB9+mYjRDZj0SPFVX5AKmtSA67xYu4ihBjjy9Q=;
 b=ftmtbCfPEzaO91+5uaEpcVwg+qi1Njqo0wvvp89yzkwppXnnSfLsHw8iN1hAtvDH3QInXv
 RHaCT6Bw7oSR0y/vnaCvFOKse0x5vHB4j8OdwjsVb40oW7huD0vMcWaow7z1a0SOOCs7Qq
 eB6Wt9tr6KyAUiBRELMCG2dKVMMToAMs3kwsdqbFA8cm1m9AjpnySPefARyuClZraqRPlK
 NNbw9M6CblKmAt7bMoOsfqlmm8Lc1Nlfyc/qt6RmD1u72Gf0zKSDuFS092nd81tws0vkFZ
 Rvc7pRH2ZL0V7bpUXyMh3Sc4hxi/FwueZUMeYVp714SxcC8VUHGF+V3ilAfIIA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of frank@lichtenheld.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=frank@lichtenheld.com
Date: Fri, 7 Aug 2026 15:47:52 +0200
From: Frank Lichtenheld <frank@lichtenheld.com>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <anXiCNoyD6jRQ7n6@flichtenheld-TUXEDO-InfinityBook-S-15-17-Gen7>
MIME-Version: 1.0
Content-Disposition: inline
X-Rspamd-Queue-Id: 4hGlpN0hSNzMlMk
X-Headers-End: 1wsM87-0006Ei-T1
Subject: [Openvpn-devel] [RFC] Refactoring options.c
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

Hi.

I think the current format of options.c is a problem. Much of the
logic is hidden in C code, difficult to compare to the documentation,
and the if-else-if hell is hard to read, even for some parsers (cppcheck
is an example for that).

When adding new options we always go through the same steps and errors
(e.g. forgetting to add usage text).

So I would guess most people would be open for something better. But
how should that look like? I have been looking into a declarative
approach with code-generation. We could document the options in e.g.
a YAML document and then generate code out of that. Ideally not a
repeat of the current code but something a bit better. I was thinking
of an getopt_long-style approach with an array that describes the
options.

One limitation of this approach is that clearly this can only describe
a subset of the semantics of the options. Many options have too much
logic behind their parsing that can not reasonably be expressed in a
declarative way. But I think it still would be much preferable to
the current state.

I did some manual tests for both the YAML and the options array and
then also let write Claude a full spec based on these ideas. You
can find it here:
https://github.com/flichtenheld/openvpn/blob/options-schema-doc/doc/options-schema.md
The interesting part (and what I have mostly reviewed and improved
so far) are the actual example results in section 5 (YAML,
https://github.com/flichtenheld/openvpn/blob/options-schema-doc/doc/options-schema.md#5-worked-examples)
and section 6 (C, https://github.com/flichtenheld/openvpn/blob/options-schema-doc/doc/options-schema.md#6-generated-artifact-shape)

Before going any deeper into this rabbit hole I would be curious
if people think this general approach could have merit? Or whether
there are other ideas where to take this?

Thanks,
-- 
  Frank Lichtenheld


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
