Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6398ECCF2DE
	for <openvpn-devel@archiver.kernel.org>; Mon, 19 Oct 2026 13:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F9MHTzN/hRp/DjE4x6T5HbniHtheDUtLDZjFM9Clqz0=; b=E/R7E7bFCHu0Fp5h4UjhBjhgfB
	m6RV2OchnE+OWEQySQjB7nqHNU3D6KOj6cm5YJ49tjRbwENftZaBA592QxfBkjOVpS1Hucq9Kn6aZ
	kG5MUmFV0hZNn4XzHOztuzeTiCLs1NSFwJmbIVsWIm2cTjIqxOlVrBG5IqKMhhalGrcU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xImya-0003Pe-QT;
	Mon, 19 Oct 2026 13:00:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xImyO-0003Op-Dn
 for openvpn-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 13:00:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dHEl3uhs3UlA788dPgwZLLWZj8TG/fkLggFOL44KodE=; b=AAzZZH0p5FRPVxObzoGVuxgYOA
 s2ZjT3o4Nwa/OyTK858PdKj2JwfRPM0sSMly/+ljwyfl3Or8tcKQpkT6lyO6TsiD1rU0ooIQVy6Ti
 8CxovVnXD1i3iwwdwSG9wIunSmwSxJ6wgiWIaeXuyVntQAQPoHBSD3Q2r8qH3Bt+Hkxg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dHEl3uhs3UlA788dPgwZLLWZj8TG/fkLggFOL44KodE=; b=NZAFvIf/lpC1ckeTIUQy/Ph900
 by4iOYywgIPt3SSwkArxFV9CWkzgH0cyj9ZD9ulIoM/LS2OzeuQY0QGflAxmdyS2aNva8x7kktmlZ
 mUwRBxLoIPWmXkGJUUOUkjUG3YAOS2eZr/ftBEkUFLtEofLzhvEJsLnlZli2mJOEXdbU=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xImyN-0007SJ-Cg for openvpn-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 13:00:17 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69JD026c055602;
 Mon, 19 Oct 2026 15:00:02 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69JD02Zh055601;
 Mon, 19 Oct 2026 15:00:02 +0200 (CEST) (envelope-from gert)
Date: Mon, 19 Oct 2026 15:00:02 +0200 (CEST)
Message-Id: <202610191300.69JD02Zh055601@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261018154358.23797-1-gert@greenie.muc.de>
References: <20261018154358.23797-1-gert@greenie.muc.de>
X-Headers-End: 1xImyN-0007SJ-Cg
Subject: [Openvpn-devel] [PATCH applied] Re: crypto_openssl: Avoid
 conversion warning in hmac_ctx_size (1.1.1 variant)
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

Straightforward enough, another one of those :-)

Your patch has been applied to the master branch.

commit 47ac47f50bd439606ad5f28299627c969f1bade2
Author: Frank Lichtenheld
Date:   Sun Oct 18 17:43:53 2026 +0200

     crypto_openssl: Avoid conversion warning in hmac_ctx_size (1.1.1 variant)

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2006
     Message-Id: <20261018154358.23797-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40019.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
