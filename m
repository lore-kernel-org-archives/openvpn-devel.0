Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8670FC982FA
	for <openvpn-devel@archiver.kernel.org>; Tue, 22 Sep 2026 16:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jO4iQLjPmw0bTpmFKI6DSQovYNzKI02J29zkZS5J/nY=; b=AJcdldcEi0cc2ud07o05vX/gS/
	t1iV2eZxSSh8s5Ou9t+HPXAwbXCcSWCK0TqNzfKl30zhonLQROgtDN49/tdEcO/8hoe5mpNddB5Zl
	dtGRsEZK7K2kjwPgMPqL48JE5OKmVkTk3NUoMRf3Hxyp06/RpkwLVxqMfALUTMyQIwGU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x93oi-0005pz-LG;
	Tue, 22 Sep 2026 16:58:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1x93og-0005ps-P5
 for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 16:58:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=11ASOmobo29bQwacPaNrSmtr1iPRCsPuGJXVad7Y8x4=; b=d0lo3fTRIX2Rc7kmdoqsfhQV4a
 w1Wd7sgSI5r+YIvjIAq9ngW0BRsuPVTvKy8WYC7z4zE7n5VChEW/bXA1fu8KsfgfdG2+QiaEjhx8H
 lQIoj274ICJxT+YSLP17rX4fJfAhO1m/bzQh+nShycWjp5qZoEHfRCzRyFFC38J54hNg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=11ASOmobo29bQwacPaNrSmtr1iPRCsPuGJXVad7Y8x4=; b=fBxd6nWdmOv9AlPCbHawnYtfFH
 CT+X7sjTEhdNXoKwMG5fYa27Ld/8B+68PpvHxr89kNUzWV7rFyKPGK6xYVuPArj/fHTPuXJvftzCi
 Xn0jFHLVyU+794xuLIh/aTrKIn5otHrTN0CPDr/7DLzUErl0LHR8JzIPtisyt3Eojy74=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x93oe-0005xM-FY for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 16:58:02 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 68MGvhHc087496;
 Tue, 22 Sep 2026 18:57:43 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 68MGvhkc087495;
 Tue, 22 Sep 2026 18:57:43 +0200 (CEST) (envelope-from gert)
Date: Tue, 22 Sep 2026 18:57:43 +0200 (CEST)
Message-Id: <202609221657.68MGvhkc087495@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260922120433.29303-1-gert@greenie.muc.de>
References: <20260922120433.29303-1-gert@greenie.muc.de>
X-Headers-End: 1x93oe-0005xM-FY
Subject: [Openvpn-devel] [PATCH applied] Re: GHA: Maintenance update
 September 2026
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

Tested both the the master and a possible 2.7 version in my GH instance.

The master version worked fine, but the changes (I guess it's "Ubuntu 26")
made the MinGW compile fail on ntlm.c

https://github.com/cron2/openvpn/actions/runs/35753766355/job/106834254994

Error: /home/runner/work/openvpn/openvpn/src/openvpn/proxy.c:770:58: error: unknown conversion type character `z' in format [-Werror=format=]
477
    770 |                 snprintf(get, sizeof(get), "%%*s NTLM %%%zus", sizeof(buf2) - 1);
478
        |                                                          ^

.. thus, only master for now.

Your patch has been applied to the master branch.

commit 0cc99b10b4464bdeaa8c254f8388aeb241e8e8b6 (master)
Author: Frank Lichtenheld
Date:   Tue Sep 22 14:04:27 2026 +0200

     GHA: Maintenance update September 2026

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1922
     Message-Id: <20260922120433.29303-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39391.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
