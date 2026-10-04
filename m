Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B000CCA5FEC
	for <openvpn-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vT0EAyk7K5J28/ZnHnWZegyNVJ1okVRpGtCWQPCq9Dc=; b=ePsCm6RUj9CnPI2DfoJSr+isys
	GlNcH7/tBGsjGBO1Xcuj6TUNnlJ+VcDQRxvd9dztIvoGAPbrMVhOAsv4WdaoThe7fMlbnnErc/6ua
	8D0zv0fWz2P3M5XNGQfs09okPw/3mvhPeUYhb674dOYyp9kPMfNT4eghqIvBPOPQ4jAU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xDJP5-0005r5-4Q;
	Sun, 04 Oct 2026 10:25:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xDJP0-0005qi-Lt
 for openvpn-devel@lists.sourceforge.net;
 Sun, 04 Oct 2026 10:25:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3EsTukJrsWAIUBcegSIDaTZj+avCOsmr2Jh9daTG4HQ=; b=H7qT6YD7s6qdl/QA+xPTLuE3YG
 hkUEku/ByylUzybxTlAlGvvX0m04+1WorP/FnZV0c/El0I5BbpgC6qxR59cYFf3clfVfKuvpwNZjP
 f5IbfGqeAM29Aiz8QBbbX9LjWYgbPM8kVrDEvOle3goTIB3Wj8wrdkHTYcSK+Er1el4M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3EsTukJrsWAIUBcegSIDaTZj+avCOsmr2Jh9daTG4HQ=; b=N1Xwwd+NVy994taHhE9YoqbNxM
 vvlIrNGgxbxTm1KFaYIKF4NeljXDcNYedV2wJnZJ6+3gt35c8Szf8WgxRe2f4HlvGQsH89yfkAoz8
 GzjFv4mFQIZhovJmNUnEN2EgXfunR5Vm1CfdU8KJPgAeTlWQmyK0IK8RmKSXDnp1ePL8=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xDJOz-0006UM-Rr for openvpn-devel@lists.sourceforge.net;
 Sun, 04 Oct 2026 10:25:07 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 694AOxRR089713;
 Sun, 4 Oct 2026 12:24:59 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 694AOx1j089712;
 Sun, 4 Oct 2026 12:24:59 +0200 (CEST) (envelope-from gert)
Date: Sun, 4 Oct 2026 12:24:59 +0200 (CEST)
Message-Id: <202610041024.694AOx1j089712@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261004100035.860-1-gert@greenie.muc.de>
References: <20261004100035.860-1-gert@greenie.muc.de>
X-Headers-End: 1xDJOz-0006UM-Rr
Subject: [Openvpn-devel] [PATCH applied] Re: Always use a 0.0.0.0/0 default
 on Android instead of def1
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

I was reluctant on merging v1 because it added even more paths to 
"route.c", and we want this cleaned up instead ;-) - v3 is nicely
non-intrusive by just silently ignoring the "def1" flag 
#ifdef TARGET_ANDROID.

I *do* wonder if this is really still necessary on less-than-5-year-old
handsets, but then, Samsung, what do I know...  Arne is the one that gets
all the bug reports.

Your patch has been applied to the master branch.

commit cb0aa9691012e936da7a1099e6e3e746500e531e
Author: Arne Schwabe
Date:   Sun Oct 4 12:00:29 2026 +0200

     Always use a 0.0.0.0/0 default on Android instead of def1

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/890
     Message-Id: <20261004100035.860-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39688.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
