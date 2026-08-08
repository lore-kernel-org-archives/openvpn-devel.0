Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 737DCC55174
	for <openvpn-devel@archiver.kernel.org>; Sat,  8 Aug 2026 15:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RaNFUx94njtpFwaNuiYXV3bdb2wojMGLhLNTzr7okN4=; b=ImqIPOu7wfpmhhH9eETsbxU89y
	iBXcYepSKfq4E5L4Yx6wRmbhtfeju7OqQX4Rro58YUjkYDrIfkW3DQGycaipM9O+l5TbDFOWdRmQz
	xemc4IZxV216ER+HMMchSX73fDUjkM8KYweIJLGZKXDTsj8C+aRI+Oe+112W/I4+k0Z4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsjD8-0007wf-JR;
	Sat, 08 Aug 2026 15:43:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wsjD1-0007wU-Ec
 for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 15:43:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wd6/radLuXROrftg6Kn6/yDzk1qu0D01R7LwMdj5GKI=; b=bVTDe+VRZ2nzCvEuSdmzIDlNhX
 sNjq2lEmLThv+NdZ7Fb1/7qDRUwlT6vWS+3xUfJUy1Pazw7B0tDAgqMbnFTQuXD4AolKVGFmRLNpB
 Yjij/QESu+tluMzcoRnxpKUVRkFWFV1xZVGBSAQ7v+ROUHh9alzjEFX1J3Axwm3hSN/0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=wd6/radLuXROrftg6Kn6/yDzk1qu0D01R7LwMdj5GKI=; b=UlcKeZs85lkXX3JO/DZ0TQBxxa
 nq1DDWmwJ62DgXwfZilT79ajnx/pscY7b77UeQ5Me7hwvzaeccke90SIIGPWeMZDprKCZLuzcV0SJ
 G1+wE+HcZPVSzu+pbaLUs9sv5O7r5ycI34ckR6jlFfSeW5WrkQsMeqK3HxLpoU4ZBrxc=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wsjD0-0004Wf-Pk for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 15:43:36 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 678FhStt072963;
 Sat, 8 Aug 2026 17:43:28 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 678FhSxv072962;
 Sat, 8 Aug 2026 17:43:28 +0200 (CEST) (envelope-from gert)
Date: Sat, 8 Aug 2026 17:43:28 +0200 (CEST)
Message-Id: <202608081543.678FhSxv072962@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260728122355.2566-1-gert@greenie.muc.de>
References: <20260728122355.2566-1-gert@greenie.muc.de>
X-Headers-End: 1wsjD0-0004Wf-Pk
Subject: [Openvpn-devel] [PATCH applied] Re: multipeer: introduce asymmetric
 peer-id
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

28 rounds of stare-at-code-and-rewrite... we did stare very thoroughly
at v28, and thanks for integrating that feedback.

I have not even tried to understand all possible client/server/p2p/p2mp
combinations involved here (and I hope that Arne's +2 covers all
these...) - what I have done is an extensive t_client/t_server test
run, against 2.3...master peers to verify that it does not impact
existing scenarios (all green).

This patch touches many places that conflict with later patches I want
to have out of the way, so even if it might not be perfect in all places,
it needs to go in now, and be perfected when more experience using this
materializes... (we'll see p2p improvements, and that will also test this).

Your patch has been applied to the master branch.

commit fc2d2f2458df63b59e93052d26a112e4fb158049
Author: Gianmarco De Gregori
Date:   Tue Jul 28 14:23:50 2026 +0200

     multipeer: introduce asymmetric peer-id

     Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbit.com>
     Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1089
     Message-Id: <20260728122355.2566-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37944.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
