Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F40DC5AC80
	for <openvpn-devel@archiver.kernel.org>; Sun,  9 Aug 2026 12:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nNmlR3tEmxYCezvqWGDqJ4M7VF/XEUTqL63aLckcLgk=; b=h6P340encxygcER2xk9MDGfjFn
	YCLZcgCn+T7Moi5vsxmUxYH/g56TOeeJ40t7YG3yTHzKMO/Qslb1IBYqP/0vmfBjkSxCi1QCSp98n
	oAR4nMl+MabmoYaSIwWQTn3dtJxNmNecuzedHibbCZLGQX9dUB17GYrnbiDVX3Vf+bfs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wt2Y1-0007Ho-7p;
	Sun, 09 Aug 2026 12:22:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wt2Xg-0007HW-Es
 for openvpn-devel@lists.sourceforge.net;
 Sun, 09 Aug 2026 12:22:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=d1tzw8cGRGFyCVysAFvNIIjipTC/hDdivzTwGqkyD6k=; b=eeCLb2SgBsfCM5OyXwZR4wPZZ4
 GdOlkbh/esKqyIeBm9181np1rDA0UndQSVmZyUTxlnkx+vmjwb+uVtC99hKo2uEkZzeOgdmf8Y1bs
 jhFNWDQImx1v8ZlD+tBcJ0Pml306DfiYxAETSBAzfvMwVhCLLsC7bmpCdRXFmqERM9PU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=d1tzw8cGRGFyCVysAFvNIIjipTC/hDdivzTwGqkyD6k=; b=RAd9OkjxQlU4UUbvKyX3wy/R71
 XnOGbBiet/Q1pT8CKu2JTUzXlvpwNhHQ3szXlgjNfg8WzHaPcwXt0X73C2gh0DhGEEgqY+cB7hcTu
 zzrFi+ugk/J9sOPX5Uc7r2HSjjJmpesrfpR/Ug0kgeizodtdBAMv2sNUEdhkd8UR/Chg=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wt2Xf-0005kp-K2 for openvpn-devel@lists.sourceforge.net;
 Sun, 09 Aug 2026 12:22:13 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 679CM5hT014297;
 Sun, 9 Aug 2026 14:22:05 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 679CM4OC014296;
 Sun, 9 Aug 2026 14:22:04 +0200 (CEST) (envelope-from gert)
Date: Sun, 9 Aug 2026 14:22:04 +0200 (CEST)
Message-Id: <202608091222.679CM4OC014296@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20260731100758.3368-1-gert@greenie.muc.de>
References: <20260731100758.3368-1-gert@greenie.muc.de>
X-Headers-End: 1wt2Xf-0005kp-K2
Subject: [Openvpn-devel] [PATCH applied] Re: Extract
 multi_check_dest_addr_allowed from multi_process_float
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

Fairly straightforward - extract the check bits, introduce an early
return (so indent changes, of course) but "same code overall".

BB agrees, including t_server test...

(Technically this is in reply to the v15 that was sent to the list,
but v19 is the very same change after 4 extra rebases...)

Your patch has been applied to the master branch.

commit fdff1c41dfff6d1233df5e638c0e31a7db99dfb6
Author: Arne Schwabe
Date:   Fri Jul 31 12:07:52 2026 +0200

     Extract multi_check_dest_addr_allowed from multi_process_float

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1723
     Message-Id: <20260731100758.3368-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38094.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
