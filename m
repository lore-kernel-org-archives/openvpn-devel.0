Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA2ACCF2C4
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 13:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8mo/ioykgojwIvN8VC1DaDBEtK6OPVRFWeGZ56FBNds=; b=mSXt2mm3363JeLlnsbGLf4gP5B
	mU11YGJFKcDIkmuECpOxaHkNdkEfO7yudqZCtgcKa8qnIL/yDlQ1Z7G6sNhXNk3YEx3AmyUPL4mDN
	RLc+kmRTBjcwZP5ebEC7QkRV6rSpmI04CFQNCcBmpQUQrFY84R6ZUP/UeXLSOkrSpc6U=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIRD0-0008Lj-Bu;
	Sun, 18 Oct 2026 13:45:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xIRCv-0008La-IS
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 13:45:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sousMlFiuRL7BbwVT365jq7XmOmtqHnnuvRnxFYwbxw=; b=I4//ZZk1UiHfF3my3ZUw9lz6M/
 0uKrZk8v5lLjEI9jFaqsGqO0HpZE4VW0HKEvVTNjWdMdjl43LwLKJxOxxpjD9DjuYihfX99QdH1L9
 aPWkMZ7It4Naty3f28zhTUM1wUKVDs3ROKT5lDSfXxBOL3M4N3F8n+8X45aW2duxRaIo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sousMlFiuRL7BbwVT365jq7XmOmtqHnnuvRnxFYwbxw=; b=ehotxkaRAodtS1Q/mG79eA9dem
 bLiyNe+6J7w3OuLAq3HMQaruFyaBKU1ojy5qBqKAtCasQ/LzWIfCk60oJHjk0K7Ytjnm5/gcu/jmH
 +cVzUV8DJ4yQ52Wcy7BqM/nqcbs8OxiG1YEsLDrh6yGdis4balwrR3OgiHl9xX84mxvA=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xIRCr-0007Ev-28 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 13:45:47 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69IDjchS021749;
 Sun, 18 Oct 2026 15:45:38 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69IDjc2d021748;
 Sun, 18 Oct 2026 15:45:38 +0200 (CEST) (envelope-from gert)
Date: Sun, 18 Oct 2026 15:45:38 +0200 (CEST)
Message-Id: <202610181345.69IDjc2d021748@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261017163328.12832-1-gert@greenie.muc.de>
References: <20261017163328.12832-1-gert@greenie.muc.de>
X-Headers-End: 1xIRCr-0007Ev-28
Subject: [Openvpn-devel] [PATCH applied] Re: Add
 --debug-aead-usage-limit-override option
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

This does not actually *do* anything by itself, which is good for a debug
option :-) - so just stared lightly at it, +2'ed by Antonio, and BB all
green.

Your patch has been applied to the master branch.

commit 43aee864957280d3fd060d477f90cb977708ddf9
Author: Arne Schwabe
Date:   Sat Oct 17 18:33:23 2026 +0200

     Add --debug-aead-usage-limit-override option

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Antonio Quartulli <antonio@mandelbit.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1941
     Message-Id: <20261017163328.12832-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39949.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
