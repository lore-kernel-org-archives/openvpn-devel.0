Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D24C5DF6A
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 16:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ShyNN8J1j+qz61p/wgSqa++KxwbfF04D6aLgRWizd8w=; b=PaQXIOjZx/igwIXoiMBHopNBbx
	8MzSnZz38ZXsyMh55Un9SAYsMLNlfS1vpDWGbNtUZnVxgrWTVOcpUo72FW0W/9SJ0sMEc5AqSZyTZ
	uGG6cRN8JSNso9W8yaUL7WBLuoaUVUIpVM97fl7+6lGvq+YrVork23ew+F54i6JIBia0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuYip-0002CP-2j;
	Thu, 13 Aug 2026 16:56:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wuYio-0002CI-5g
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 16:56:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iSB7TAtinq0kL7q80YL34K27QqJgNgav1+S2lT2G21M=; b=Xvb3Bepskp8vfNnw9NT2aJkrQz
 Lzuvx3+87eqLqYt9Dqla3fvF17GcZWF4FNGT51aFyBVOcDFNQtvVRmhqTezoc7tSqtwTwkwmX6Ty4
 2iCcZ9C8dSnaBcIU5te5KPvzuqkxUt4I6wvXQbi2F1AzdBL0M6LjX51e4T3icWkG5l64=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iSB7TAtinq0kL7q80YL34K27QqJgNgav1+S2lT2G21M=; b=hr+9lmmcyYbHWOSDHm/ZPyert/
 2k0MQeuYcy/LHLpSongAtsCMPuumoq9pwpjVktxS2aZJ1YNMSYZki/U0gopwqli7GrZg8hfB3Dbm2
 Z6NL65uRyZbRNeNeXsLiRaB4I0m2Y6A1i9dIQvx+rrOUjvk6xch4NK4SX/A4EFHT4LnU=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wuYir-0007eH-0E for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 16:56:02 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67DGtskG081132;
 Thu, 13 Aug 2026 18:55:54 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67DGtsBn081131;
 Thu, 13 Aug 2026 18:55:54 +0200 (CEST) (envelope-from gert)
Date: Thu, 13 Aug 2026 18:55:54 +0200 (CEST)
Message-Id: <202608131655.67DGtsBn081131@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20260731100844.3467-1-gert@greenie.muc.de>
References: <20260731100844.3467-1-gert@greenie.muc.de>
X-Headers-End: 1wuYir-0007eH-0E
Subject: [Openvpn-devel] [PATCH applied] Re: Extract
 multi_get_instance_udp_real method
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

Code reorg, no actual functionality change.

Technically the +2 was for v4, the patch sent to the list is v15, and
the latest version in gerrit is v19 - but v4..v19 do not differ except
in "rebased, new parent".  Same code change.

BB is happy with all 19 versions...

Your patch has been applied to the master branch.

commit ac70ce4ad161b3840edbb4e9d89fb979b06d6562
Author: Arne Schwabe
Date:   Fri Jul 31 12:08:39 2026 +0200

     Extract multi_get_instance_udp_real method

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1725
     Message-Id: <20260731100844.3467-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38096.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
