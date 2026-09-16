Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CEEC88E7F
	for <openvpn-devel@archiver.kernel.org>; Wed, 16 Sep 2026 18:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mZ6IeaOk4HRAlUuokmdXcTSUy4YXTDU+X5463QP4cIo=; b=QlZrIcHuobhNDjsxjYEAx47X6+
	sMqtw5utFvxD1G/XYboNrMQEje4OQj+5XmYqt2XcXv/tUzMvyFvWKV46xsBcAQsMD9tDHUCM9kzMn
	kQEGJJNRbzkX+ECF5vetXw6gIcOR4tPO9Y6k/qvhXwAJWS4tdXDX4VgBQPJy4gA4rLUc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6uOJ-0004lr-Gi;
	Wed, 16 Sep 2026 18:29:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1x6uOH-0004li-Rd
 for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 18:29:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oNlkatXbt7vvpkHrEtphdSp1N6EtFaidxea7iQAcXc4=; b=LFyvROIJuWK/rj8F4ALAhYFHs9
 46v9qF8U+ujRIFUN9P+8123iUtFtyDfbIMXd+r0ZsqXEEpkr1OfSYYqroL0DE08R6ElWtePNM3ve0
 DHuUtOoQu9yGsiNXs+9mlYI07BI0Cwl/V4uB61tUbWsdVfmra+Fvv/xvQEasPx/46vAE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=oNlkatXbt7vvpkHrEtphdSp1N6EtFaidxea7iQAcXc4=; b=eQFhgSCBynkmuqmbc0IzSNl35l
 RpVJBm9aW3ZSO46MQ1WaJg2g4AYsU50uheLBlxQ5d0Zx4sEkdQR0TmjDe501Esvx5OrrRWTaX6ZUo
 cZjB3m+/uMRjeebM0pWlJkwdOdEK0lItD3R6refAIVAyuE/nCa3KVeP1aRo9ZdKdfVAY=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x6uOB-0008Up-O6 for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 18:29:51 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 68GITekb013080;
 Wed, 16 Sep 2026 20:29:40 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 68GITeXa013079;
 Wed, 16 Sep 2026 20:29:40 +0200 (CEST) (envelope-from gert)
Date: Wed, 16 Sep 2026 20:29:40 +0200 (CEST)
Message-Id: <202609161829.68GITeXa013079@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20260915163852.3477-1-gert@greenie.muc.de>
References: <20260915163852.3477-1-gert@greenie.muc.de>
X-Headers-End: 1x6uOB-0008Up-O6
Subject: [Openvpn-devel] [PATCH applied] Re: Make required action returned
 from pre_decrypt_verdict more explicit
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

Stared-at-code, ran the t_server testbed (no complaints), +2 from Razvan.

This does not really do much, except rename "true" and "false"
to three more explicit enum values - making it easier to trace and
debug, and the code easier to read... preparing the grounds for the
next one.

Your patch has been applied to the master branch.

commit e46f6dafb372f98c8a12147e51aeeab08736c5a5
Author: Arne Schwabe
Date:   Tue Sep 15 18:38:47 2026 +0200

     Make required action returned from pre_decrypt_verdict more explicit

     Signed-off-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1826
     Message-Id: <20260915163852.3477-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39205.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
