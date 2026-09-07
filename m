Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB4BCC79F99
	for <openvpn-devel@archiver.kernel.org>; Mon,  7 Sep 2026 18:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q6sanmngPO2GNs8BHEFr44koUOe9cVpxZ1v3a6njW3I=; b=LCo8Pn6z5yKhf9Zph7QFRdRY5u
	kmkYbV7Q93iqAsdMo/10BqvDlPsOA4tv+hoNBjL8lCwZh8Tg8P+f5CGd/FPfU1ZnRC2fYhvSomVNO
	ceLx5GI2A1Dxjya03psLu8PGGNoG1w5E3pXdfmINg5lzC+U7//sYD6uzyfl+uHxQlCq0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3dqz-0002Tc-9F;
	Mon, 07 Sep 2026 18:14:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1x3dqw-0002TU-Tr
 for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 18:13:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/5kbKkyQ5DDMrt+QHnJ47x5dBlQCqVFxkkvrTNK3QMY=; b=E4CCh+68Wn3YQMaTDoXO3W031O
 SCpmhn62voFy2i25WRGxj1ObftuiSx3FiPdy8cVu5Bv0Kiju/gyJ9Mo3aAt0aebbqOTHAYr3U555N
 91+50RE8qQdyWiO16TjE8qbXAxbH3Hndzk774w6Zw5HXiRkXz25H6Stw28f5JxQ3EMSo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/5kbKkyQ5DDMrt+QHnJ47x5dBlQCqVFxkkvrTNK3QMY=; b=kO4cW55h+926Iy2oLc7ejjyuut
 Drv5wGURvThkQ7CYotXdpw34YmrTnXql8A63VJV4LCbxZ6/QnmmIKiVPZKjwLMMZoPY+j0Jzz1SF+
 UZAtMMndBpYjhfSY1821jfplXrzKvjqlDFECBUV0GxF98DvJ9CodWSyYNlf1nE1PxUDM=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x3dqv-00056K-91 for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 18:13:59 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 687IDgDA038539;
 Mon, 7 Sep 2026 20:13:42 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 687IDgCV038538;
 Mon, 7 Sep 2026 20:13:42 +0200 (CEST) (envelope-from gert)
Date: Mon, 7 Sep 2026 20:13:42 +0200 (CEST)
Message-Id: <202609071813.687IDgCV038538@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260907154412.29523-1-gert@greenie.muc.de>
References: <20260907154412.29523-1-gert@greenie.muc.de>
X-Headers-End: 1x3dqv-00056K-91
Subject: [Openvpn-devel] [PATCH applied] Re: Convert Changes.rst to Markdown
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

Nothing to test here :-)  (except for "distcheck" but that should be fine).

Your patch has been applied to the master branch.

Do we want to do that for 2.7 as well?

commit 57b1f870a76dbe94dbf8dc6a4d22d1a225a42578
Author: Frank Lichtenheld
Date:   Mon Sep 7 17:44:07 2026 +0200

     Convert Changes.rst to Markdown

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1767
     Message-Id: <20260907154412.29523-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38990.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
