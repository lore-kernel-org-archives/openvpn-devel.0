Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F407DC54F51
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 14:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gJHHh0aZFU5SXkliVsQyIG35u8qDSP1QSt/at9oPjgw=; b=ObZ7AcvjnevB8jl/uvg4ezQ5Bs
	Kj6a2IrTFKxmkTu+q5xJIm2iB409wk9Dwmv0Y9fSqj6N7cy5nZmn+LmCfjB/k15TVan+nXjMH5Gig
	qNl99b67kU2Z+vIlw4/D52ALbJbuZlL5ehqpJboP/2sVLFFelyvnqNjreOdbdXzZgKW8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wp5MY-0003aR-13;
	Wed, 29 Jul 2026 14:34:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wp5MD-0003VO-68
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 14:34:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=S4ti8PsyearXr6FGXxlzKyMmvG4PSty5QRjfv4pR29M=; b=E+i45XNiJOuyzRC5A9Pn613sq3
 wMVxoDiniDGZSYgvrZnFpkguxTUYnk/BOmI4hv9dsOWFXIDGuN1hTVUefSdI8FNQ0bGnB2rXyJSIS
 X3Sx9W590vJjUPTOXHxUHrebxrMFnuMd0hZUsdQc2BzQIuf/kBgGYRoC8d2SZ+skkRYs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=S4ti8PsyearXr6FGXxlzKyMmvG4PSty5QRjfv4pR29M=; b=khejrethknHIfckybA3Nka7x0U
 6JSlqtTHnkdcQFNAoEY94uPqC3H+HneumSTVvIglqQjYwtzxPX43FRkk0A9JA+jqlyHR0WLwoyKv5
 AriwzQ4zUVoqw8N5apGa8pQDBqqAyfADFszJ1DfJi4x2syHjpcTjWplmqaV1l2vHzxE0=;
Received: from mout-p-202.mailbox.org ([80.241.56.172])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wp5Lx-00011L-Ri for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 14:33:51 +0000
Received: from smtp2.mailbox.org (unknown [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4h9FFL0P3SzMlKf;
 Wed, 29 Jul 2026 16:33:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1785335622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S4ti8PsyearXr6FGXxlzKyMmvG4PSty5QRjfv4pR29M=;
 b=K8gB3kDWvQfnA/zilNXJY37m4R6pW1OqW+Y5DTDPND5XYzSNzrEXQvaBNTBscLkDlDtECa
 aD+NyceaFMLtkRGtB1CaP3u9wZojwdFes0nYbNuaqmX41ciCBKrwOB7gEfbHjGNoPl58zB
 T/MpWkHvgQUd4K46xJsFYCAj9DXUO5KW9HadEaZtRrclaRGh+wb5DdmGeKHnOtNXH7kn8j
 t0S3icqgxCYoSbVErHSi54qwdtMfLvvZrYf0pFNRBAsrrjpPddq7utTuR9imJ/WRS3EFVo
 F5h+K2yzToU2rVBdMgARLE3NrqqdfFCh5eCa//QazXvywSDLKEwfGx+CaN0OKg==
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net,
 Antonio Quartulli <antonio@mandelbit.com>
Date: Wed, 29 Jul 2026 16:33:39 +0200
Message-ID: <178533560781.3423195.3410161947677343297.b4-ty@b4>
In-Reply-To: <20260728114855.1323861-1-a@unstable.cc>
References: <20260728114855.1323861-1-a@unstable.cc>
MIME-Version: 1.0
X-Headers-End: 1wp5Lx-00011L-Ri
Subject: Re: [Openvpn-devel] (subset) [PATCH ovpn net v4 0/9] ovpn: assorted
 net fixes
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


On Tue, 28 Jul 2026 13:48:46 +0200, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@openvpn.net>
> 
> Hi all,
> 
> This is v4 of the collected ovpn fixes for net, sent here for review
> (and sashiko re-review) before submission to netdev as a pull request.
> 
> [...]

Applied, thanks!

[1/9] ovpn: skip rehash for peers already removed from by_id
      commit: 0fafa38e783ad5e9449e4bdf88ca0f244ef8e779
[2/9] ovpn: rehash peer in by_transp_addr table on CMD_PEER_SET
      commit: e2b7734c71642a89efadfcf9551ab520ad321f4b
[3/9] ovpn: fix data race reading cached local endpoint on TX path
      commit: f186e6c20e6662f31e491033f14b713deddf56c5
[4/9] ovpn: ensure socket is owned by ovpn before deref sk_user_data
      commit: bdd361f524ec4ecfdb3a42c86f452433aa5299b2
[5/9] ovpn: zero-initialize sockaddr before learning a floated endpoint
      commit: 34b1bd4d42295a8451c72b3c7838b2e122b4c989
[6/9] ovpn: hash floated peer by transport identity only
      commit: f2da4f5d5effeaf465486ff29faa3fab3b30f9f6
[7/9] ovpn: disable IPv4 redirects on MP interfaces
      commit: 635c25927d98186813c2e0e3d5781ae64bc8d45f
[8/9] ovpn: ensure TCP vars are initialized first
      commit: a6b96b20e356138d932e2e44eebe15bf01506c15

Best regards,
-- 
Antonio Quartulli <antonio@openvpn.net>


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
