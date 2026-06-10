Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CDF8CD8CB9
	for <openvpn-devel@archiver.kernel.org>; Wed, 10 Jun 2026 17:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1JD9E25iPW7XUyFi6NTbjp7esE64OIcKny8Ybx6jG7Y=; b=KqueXNPimlTYayc6ZIcDu0YQbe
	Bfw0snYhVuG576U8nGQnDVUNoz85sekZ5i4hRm2k2/tE9jt9+n2X0nxNdRc+wMxaFj7VzNr/rhwdZ
	qxRKo93Rc2ujGCjbDSQmgFXj3OIB2oSLNAN0DV7gGuXAqrUshRDgjRSUok/efD1Mv6AA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wXMPu-0004Ml-3E;
	Wed, 10 Jun 2026 17:08:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wXMPs-0004Mf-Uh
 for openvpn-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 17:08:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3xhIa2IT8z9JWzyAMapKj5xMbfDStkBq6NgS76tWOzA=; b=fGrqL2ReAdSs4rzWcJkleQoF7U
 wfw0TlfkvWAVtXQRjtFlbJnYMh8oc0a1hd3pPlGvj5FH7IhHwqkltc/qUHTtOfC//eHHLi64uflsI
 P675Q63bM2so2fBPZVZu4MM8qjeIEqdNyXkQ1OwX3EyPXidhuuTrKo2PwlBq9R5hjKsg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3xhIa2IT8z9JWzyAMapKj5xMbfDStkBq6NgS76tWOzA=; b=PrZA8ZFI+gEdq3ngX+5Swalv+i
 lks/ZlcUpPlVQ4ycFWIwWzs21UQjy93H2CConlvvMeQ62qOZFWrYdYw6OD70MPkI++LnM2Z+s3Jr8
 Tf9cRaMP0hGZSaRxUhyZYDFB0cQ+fSq0s4lKP/EPJAmrPYA8C5DUXuezxisUfrTTiqMs=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wXMPq-0006dp-4D for openvpn-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 17:08:36 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 65AH8MBB002528;
 Wed, 10 Jun 2026 19:08:22 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 65AH8LtM002527;
 Wed, 10 Jun 2026 19:08:21 +0200 (CEST) (envelope-from gert)
Date: Wed, 10 Jun 2026 19:08:21 +0200 (CEST)
Message-Id: <202606101708.65AH8LtM002527@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Max Fillinger <maximilian.fillinger@sentyron.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260609102407.32590-1-gert@greenie.muc.de>
References: <20260609102407.32590-1-gert@greenie.muc.de>
X-Headers-End: 1wXMPq-0006dp-4D
Subject: [Openvpn-devel] [PATCH applied] Re: Null-terminate tls-crypt client
 keys when testing
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

Technically, this is a buffer read-overrun (strlen() being called on
a non-null-terminated buffer) - but since this happens only at command
line usage ("openvpn --gen-key ...") and this is not done in any sort
of privileged context, the consequences are "none".  So not treated as
security issue, just a bug.

Stared at code, ran a few simple tests ("openvpn --genkey tls-crypt..."),
and unit tests.  The code is not in use in "normal" operation, so not
subjected to t_client/t_server tests (beyond what BB already did).

Your patch has been applied to the master and release/2.7 branch.

commit b2dcffba0820a1a77472658623b5964e88cbb732 (master)
commit 4d22da0260fda3f1797f325f707e438286eebb24 (release/2.7)
commit e13b128112e474beb59f1b38d505a658c054c5b5 (release/2.6)
Author: Max Fillinger
Date:   Tue Jun 9 12:24:01 2026 +0200

     Null-terminate tls-crypt client keys when testing

     Signed-off-by: Max Fillinger <maximilian.fillinger@sentyron.com>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1701
     Message-Id: <20260609102407.32590-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37116.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
