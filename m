Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21529C61DD6
	for <openvpn-devel@archiver.kernel.org>; Wed,  2 Sep 2026 07:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VF23cJH73C2B/Wt6/Uv+bvpV8syExE1Eqokbk39t1TU=; b=mddF324cX9S/SleyzNrQxHIeMV
	5pQOhqPbZS45VTwgzV5hpa5pXeMmr5DqKbplt70jnXsiUdxorEj4v9i2NidfoU1zW91a53k/Li9Nu
	7EmhD0uubQ85AkjD6I3bHKobGBnzu/jipWPyv/h4G3zdJKju8kr6aXFjOJAKa9SKtv4s=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1fJ7-0001Vh-Gb;
	Wed, 02 Sep 2026 07:22:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1x1fIv-0001VV-Fg
 for openvpn-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 07:22:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fhzydyjx9NaQn0ijnzk1fptc0UAN3BeEUXl3eTp6ntE=; b=gHdXwLbbKXpZUbddMKFcqV792r
 LZjV/TWmSShdNLmxxiZw/Y45REmh/yjxcW6vfQkzX1qVRloJahXK3CvS8px1MKs9j8Uato1Eg838G
 phfqPb+PKKZ1T/2O9CG88h/693IYCcHl/dm3QMfb0ZDVMOVV4OyXym3/BiSMSNj2fD4E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fhzydyjx9NaQn0ijnzk1fptc0UAN3BeEUXl3eTp6ntE=; b=PM7YA9v0YxkBHuQb7ebjbcEuj7
 v6CXVOqhipQ+pTgzEeGCtIHW5MvwFwtOlyKd0mj8h5oC+o1+sGAQRIP1P6HQlakIefyoHXxvh75eM
 50BGSZYdba56ZiX4LJkawday1HU+JEoyQ4W4hcwkuW//N3XrcV1vrQp7VMnPnth0B118=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x1fIr-0002Kc-E1 for openvpn-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 07:22:38 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6827MTsv093865;
 Wed, 2 Sep 2026 09:22:29 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6827MTiB093864;
 Wed, 2 Sep 2026 09:22:29 +0200 (CEST) (envelope-from gert)
Date: Wed, 2 Sep 2026 09:22:29 +0200 (CEST)
Message-Id: <202609020722.6827MTiB093864@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Heiko Hund <heiko@ist.eigentlich.net>
X-Patchwork-State: Accepted
In-Reply-To: <20260901202854.13746-1-gert@greenie.muc.de>
References: <20260901202854.13746-1-gert@greenie.muc.de>
X-Headers-End: 1x1fIr-0002Kc-E1
Subject: [Openvpn-devel] [PATCH applied] Re: win: don't use NULL DACL with
 system objects
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

Thanks for fixing this, and thanks Lev for reviewing and +2'ing

I have only had a light stare at the code, and it's all magic windows
foo - and the netsh.exe sempaphore only applies to "setups without iservice",
which we want to get rid of anyway.

I did test builds via GHA, but no actual test runs.

Your patch has been applied to the master, release/2.7 and release/2.6
branch (we declared that we do not want to do another 2.6 windows installer
release, but should we ever do, it has this as well).

commit 23396ac49bdd390d2e559e74fec16e8763650b78 (master)
commit 73fb222a295e95d4c8a70b756db39bea70bf9156 (release/2.7)
commit 78a1a7bd965e940001b040ea8ec127ea2dfc00a2 (release/2.6)
Author: Heiko Hund
Date:   Tue Sep 1 22:28:49 2026 +0200

     win: don't use NULL DACL with system objects

     Signed-off-by: Heiko Hund <heiko@ist.eigentlich.net>
     Acked-by: Lev Stipakov <lstipakov@gmail.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1889
     Message-Id: <20260901202854.13746-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38886.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
