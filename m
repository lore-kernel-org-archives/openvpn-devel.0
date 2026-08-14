Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E9A0C5CFC1
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 10:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A8Po4kJY7O+W3MFHoeOcCjgLdxmRTWM4qhDqkh52JtU=; b=asApmJd75/M94j64qqrOn6M/Ok
	sVOrxFrtj+sECmkqBan6o9Hb75U00UiDvQeVUWTW4bPXZ5/TwM8zqP+F3z3sNErBleHhQvBUl8AVx
	za5JcCZonUZlGVkUmo6xiGc9YN6sfNEJcCaX3s0a66TUx02Hjp6yIWXtdrrQRHTPcnMk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wup0P-00006t-NN;
	Fri, 14 Aug 2026 10:19:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wup0N-00006d-N9
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 10:19:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gZIMv9TTOAdlPMcBpM3nUFeXTeFra6OIGQL70/6f7yk=; b=UjwqfiZ6TmSVhZpb+vnTGdA93B
 YgSEZWz+4xVB+6Y4UKI8KkPx07T4FiCYJMONoBysgeveAlFBMWdjxd+7HY0rvLMyKjU6UK9odJRrT
 eZJvxENleuLiSj++uew32BWFC2qzu4ZPelHNnAnpHXxKmpJoolr1bmSklbfXSQ9D4QR0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gZIMv9TTOAdlPMcBpM3nUFeXTeFra6OIGQL70/6f7yk=; b=cH5P6KmqiwmSnR1qPScFTEyMij
 Q92/xyZIiVu8GLO9Gkwm07+GO/Gu2/P/shKqzYReyvyb++ap/LyB5Mpiea8dfzwa6fkbFxgJT4/dG
 WGA3zCGy6JM89M/WcW9xp3dAb1BDzDilHm6DtG4ikJxEjqejEJyhLwrkv77wS0BypS2Y=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wup0L-0001Ay-LT for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 10:19:16 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67EAJ7d4016236;
 Fri, 14 Aug 2026 12:19:07 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67EAJ74n016235;
 Fri, 14 Aug 2026 12:19:07 +0200 (CEST) (envelope-from gert)
Date: Fri, 14 Aug 2026 12:19:07 +0200 (CEST)
Message-Id: <202608141019.67EAJ74n016235@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20260813184950.6709-1-gert@greenie.muc.de>
References: <20260813184950.6709-1-gert@greenie.muc.de>
X-Headers-End: 1wup0L-0001Ay-LT
Subject: [Openvpn-devel] [PATCH applied] Re: Split
 multi_get_create_instance_udp into data and control parts
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

Stared at it for a bit (has a +2 from Frank already), ran the full server
side tests - all pass.  The code duplication is understood and accepted,
as the "control packets" part will be rewritten next.  "git show -w"
helps, too :-)

Your patch has been applied to the master branch.

commit 6ff04417a4250b558da06a3b58b5cda697cd5ee3
Author: Arne Schwabe
Date:   Thu Aug 13 20:49:38 2026 +0200

     Split multi_get_create_instance_udp into data and control parts

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1726
     Message-Id: <20260813184950.6709-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38338.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
