Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC2CC5B572
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8iLltjb7yl9ps8z/xno7jKdY76BtaFpAAe2NZmFWXsc=; b=I0JH8DVvNYII3tMZ1qj8K3M2hu
	ofug1Av44Yh6IzehCH/BIssNVsGBGjmD9+QUC3hf6ZmzBAXxcm6bvpCPM1EkK7IoKWBZFlb1IsYZW
	iTgm0pwzJwfwqf9sCOP4kk2ZoFDmctRWqATNDwD6S/5UIEcXwi4TAHg5qJVUR7CpQHoc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wulxz-0002KU-91;
	Fri, 14 Aug 2026 07:04:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wulxx-0002KG-OK
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 07:04:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CmesD7+vtOsQoQbA2zdvzCaKP2W5toSWho+D5n6oStE=; b=K0DuKYhkZ42a0XOrgNZM/LY5Bk
 Sf3PbNqVTvQhz83si3JfayPA5/YWBnszNxyvwF/DDVt2o+weOowJVnw+3sZG2Fq24Cneijc6JWOyo
 weVO2cM26VDuLsgLmp4iFvo0n0cxymCpe681+L5gJq59b2fIR5LU3QJ81deEvzhrEumA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=CmesD7+vtOsQoQbA2zdvzCaKP2W5toSWho+D5n6oStE=; b=HXo6XLQS4Se7y5pZZhJhmxFpDC
 0zBeOMhu9dRuJBaL6rk0/cE263YT/Ge6W6mv6n/U/m6+htn+gu7Poz+BQkpqXs5jRquLgW0ZhzTuq
 oDvTuh151/2d2fLwVB7gEUd9ZUVFcWk6AjpnK49J/mEiERpYb4lriWA0B9B73MLMqyZI=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wulxw-0000ZS-74 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 07:04:34 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67E74Pje009842;
 Fri, 14 Aug 2026 09:04:25 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67E74PdD009841;
 Fri, 14 Aug 2026 09:04:25 +0200 (CEST) (envelope-from gert)
Date: Fri, 14 Aug 2026 09:04:25 +0200 (CEST)
Message-Id: <202608140704.67E74PdD009841@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20260813185258.7084-1-gert@greenie.muc.de>
References: <20260813185258.7084-1-gert@greenie.muc.de>
X-Headers-End: 1wulxw-0000ZS-74
Subject: [Openvpn-devel] [PATCH applied] Re: Do not differentiate TLS server
 and client context initialisation
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

This definitely simplifys quite a bit of the initialization stuff, and
still passes all the client/server tests I threw at it :-)

Your patch has been applied to the master branch.

commit 37acc42ce769a1c7415311eaf40b9013316d8a61
Author: Arne Schwabe
Date:   Thu Aug 13 20:52:51 2026 +0200

     Do not differentiate TLS server and client context initialisation

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1728
     Message-Id: <20260813185258.7084-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38340.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
