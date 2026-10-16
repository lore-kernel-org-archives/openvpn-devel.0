Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15515CCA464
	for <openvpn-devel@archiver.kernel.org>; Fri, 16 Oct 2026 10:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q4ch47kKXHmfr3CbRQ6iN+P7hA6oOzDV/Kr3qRlq8+U=; b=l5xCMspmdox3BjmNBm/FwYaDNv
	rWYlpYUC/dIS3tXI173Mc784qva2b1KCrhsVyyYd1E5xqvLZm4UeHWFlFz0DxvosQW91k01S226m+
	P9ipxGNWZ1Ccls8mWT5nFFT4wO2qgYw6C3Mak1B1BGhaIwraasjpYHd1X6U3qHgvuS9g=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xHfSx-0007TH-V4;
	Fri, 16 Oct 2026 10:47:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xHfSv-0007TA-TX
 for openvpn-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 10:47:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4QrlTJMiSVSr5vYcbLEPLjwjYkSY8EdclcQvR9IXxXI=; b=d0uw4hc1fWlC2REdZi2r0f6i55
 hWXFK1TY80flK+vISNPZtqNU1TFKJf1Yl85IWauYTzHFaD5TK9Jj+CUjqpKZseQadETt8CTPCCwPo
 CyIIhHiiZYi7IV/SAKVb6k2Xbkuv5DyVwsHOrMHuhKPyx6+UqsG29R5vuboj030dMYIc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4QrlTJMiSVSr5vYcbLEPLjwjYkSY8EdclcQvR9IXxXI=; b=XjkKTKr9izpUzx3yOasZmReqUy
 Zu4YAH8SzfA17syZ97P/clogvN05PsrDxVt60Ac/uqsjzv9jwrqnR+f9aKddz8WByi1FLuTenZ/T4
 8RY2WiIEZZPmxhAdU1I8bjykSBzNtLwJHkCujwsqa5RO88ABWuIXLWrOHnhxiWV5ryFY=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xHfSs-00046i-0W for openvpn-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 10:47:10 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69GAkoRv040889;
 Fri, 16 Oct 2026 12:46:50 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69GAko4S040888;
 Fri, 16 Oct 2026 12:46:50 +0200 (CEST) (envelope-from gert)
Date: Fri, 16 Oct 2026 12:46:50 +0200 (CEST)
Message-Id: <202610161046.69GAko4S040888@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261016084828.26818-1-gert@greenie.muc.de>
References: <20261016084828.26818-1-gert@greenie.muc.de>
X-Headers-End: 1xHfSs-00046i-0W
Subject: [Openvpn-devel] [PATCH applied] Re: Review usage of strncpy
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

Thanks for looking into these, and cleaning up what is needed.

s/where/were/ in the commit message has been done, as instructed.

Tested via a local t_server run and via GHA run in my repo.

Your patch has been applied to the master and release/2.7 branch
(I consider this a bugfix, and all the issues are present in the 2.7
branch as well).

commit 39665ae0965b6a34bd902de864fe41ff23fadce5 (master)
commit 501cfe9024f5253b3f8ce2c91a88682da1153a10 (release/2.7)
Author: Frank Lichtenheld
Date:   Fri Oct 16 10:48:23 2026 +0200

     Review usage of strncpy

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1993
     Message-Id: <20261016084828.26818-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39918.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
