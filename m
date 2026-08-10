Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41D4C5AD55
	for <openvpn-devel@archiver.kernel.org>; Mon, 10 Aug 2026 12:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=It0Qd241+87JttC/Ppl76MXtBlT6+Ohafaufu08pOVA=; b=GEqIjU+yNLK2zAq+AND5LYXZpu
	WEgyOQX9qQuiFB0O6JbaG+kz8Ok6bShjSdxc2MWJJRZgqDfQ8IFejP9dNAG0W24lxEJI956j/bprt
	pDUEtPBawchfTu3/gUmKandFD8VUXutrhFGW9Lj6iH2w56qoPhrKoQHCFw17UumJ+D8A=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wtPCd-0003XM-18;
	Mon, 10 Aug 2026 12:34:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wtPCb-0003X8-JK
 for openvpn-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 12:34:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=i8aPZner8zzs9bB9s1d1XgtvmOjCffbPmVSVvir96IY=; b=lRFW1lPRpgTugh1FNQkInSQ/N9
 H+6rzMJfG1Rpiyrd2tHFsChnnCvN5DyWdtzxrUNnUb5s/nWDZ9mu0jTWHtAKdGI3779ZnkBTG9MZ+
 H8jf0G1qOHTciATS4+XEBwb7kc7HNsSPTxDwpDB6o205hA49muuzAJ/AFOHkoBaZaaL8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=i8aPZner8zzs9bB9s1d1XgtvmOjCffbPmVSVvir96IY=; b=aJrNFvWyc4EXj2ITlf5F/ELe/A
 gKjJCc6Jn1hdUTMQ5uJOt41X3tEKTneBnGPO7Ogw0Z766KZAzdr7W+2MD6GmIZlvFhR2OvgmKCvGx
 FlixzcjmwmDczrZOaQlsLavqHsStXiZAias7hCRGShEFcMDm1uR+VCgZ5aXCbAMrmfdg=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wtPCe-0002i2-1z for openvpn-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 12:34:02 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67ACXjn9035253;
 Mon, 10 Aug 2026 14:33:45 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67ACXjL0035252;
 Mon, 10 Aug 2026 14:33:45 +0200 (CEST) (envelope-from gert)
Date: Mon, 10 Aug 2026 14:33:45 +0200 (CEST)
Message-Id: <202608101233.67ACXjL0035252@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260810120941.31423-1-gert@greenie.muc.de>
References: <20260810120941.31423-1-gert@greenie.muc.de>
X-Headers-End: 1wtPCe-0002i2-1z
Subject: [Openvpn-devel] [PATCH applied] Re: doc: add Doxygen documentation
 to buffer.h
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

Documentation is always welcome :-) - I have not tried to apply this 
to release/2.7, as too much refactoring etc. went into buffer.h in the
meantime.  I don't think it's crucially important ("developer docs", and
those developers should work on master anyway).

Nothing to functionally test here, and one of our CI tests does ensure
that there are no doxygen warnings - something could still be incorrect,
but I trust that Arne would have caught it.

Your patch has been applied to the master branch.

commit 21ef7fa82a39895a7b65459078fd78bdd3a43e27
Author: Frank Lichtenheld
Date:   Mon Aug 10 14:09:35 2026 +0200

     doc: add Doxygen documentation to buffer.h

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1581
     Message-Id: <20260810120941.31423-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38269.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
