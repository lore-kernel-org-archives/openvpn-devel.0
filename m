Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54DF9C56208
	for <openvpn-devel@archiver.kernel.org>; Thu,  6 Aug 2026 09:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=giVeQDhlsCLGQYVle2zsQcUlQbpfW4LWnkC5JS32v5g=; b=SvMLDRn5fZBhP7SEXIBRed8g2B
	EXtzHuOFDVn3bgnuILhhKUngzbv8rxiECDMquS4j9yIf9zd1uGTn5ci4/1T2DE8Xa/UuWepwxSt6c
	3tWx8vxyR/fuu6L1S3OqZnuEL7zgCQMyL8hIH937nagLaG9LpomAcKhbtxhXtL3Nr4p0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wruhh-0000u4-C2;
	Thu, 06 Aug 2026 09:47:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wruhf-0000rc-DB
 for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 09:47:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dz3KBEy6l7Xw/r6SInh0OKmJzvoFKTfRVBHIMeM2IAI=; b=dG19dXYs2O+jbnEZ1UFdQuNf76
 L+m+zOV6fl3xIlgOOlfazUKZjUKW2JRCYWC1YsVh+QGd7anKklu19aB348XI7lFSH0irmw4fxL7KJ
 x7UlTfC2rQK+RvtwT8xkChQ0B6nTjjG0oCMHm65m7+G/+dRb8dNPmORog/mluqlMndVU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dz3KBEy6l7Xw/r6SInh0OKmJzvoFKTfRVBHIMeM2IAI=; b=ZugjyOgg46O/oQW3KIq4RwGK3l
 voMlBgRwiWGqEL18FfeocdMfXuoE4KSfGP/WgsgRiLXBqRcoTQI2aPD0BKOk8vGRok68VAIE3Ro4j
 QVRtGUQ4g7Vf89mHDIi63cq4f8EisKZeWhUDvd68AvAapyd1ORtw+ong7zH7IuWzBXjk=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wruhe-0007V0-8U for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 09:47:52 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6769lh3x039596;
 Thu, 6 Aug 2026 11:47:43 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6769lhM6039595;
 Thu, 6 Aug 2026 11:47:43 +0200 (CEST) (envelope-from gert)
Date: Thu, 6 Aug 2026 11:47:43 +0200 (CEST)
Message-Id: <202608060947.6769lhM6039595@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Lev Stipakov <lev@openvpn.net>
X-Patchwork-State: Accepted
In-Reply-To: <20260805134614.163847-1-frank@lichtenheld.com>
References: <20260805134614.163847-1-frank@lichtenheld.com>
X-Headers-End: 1wruhe-0007V0-8U
Subject: [Openvpn-devel] [PATCH applied] Re: mudp: extract
 send_standalone_reply() helper
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

Straightforward move, with a few generalizations - unfortunately, too
few lines moved to make "git show --color-moved=zebra" display this in
a nice way.  So verified by stare-at-gerrit...  also, BB all green :-)

Your patch has been applied to the master branch.

commit d169af7f831ea2c20e2c633fe426e51b91b397b3
Author: Lev Stipakov
Date:   Wed Aug 5 15:46:14 2026 +0200

     mudp: extract send_standalone_reply() helper

     Signed-off-by: Lev Stipakov <lev@openvpn.net>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Antonio Quartulli <antonio@mandelbit.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1743
     Message-Id: <20260805134614.163847-1-frank@lichtenheld.com>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38134.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
