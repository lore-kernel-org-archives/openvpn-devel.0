Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A4B5C61DD6
	for <openvpn-devel@archiver.kernel.org>; Wed,  2 Sep 2026 15:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FXmKGQ6BWOG7rrYcljxrJAhGdpSD0Cs9SXho4jykIxc=; b=ZaXpssxQ+nuu2b4doCmLA0k76Y
	izFvmwZ3Ic4xlwrvsifdh+JvN4OliPTGWZOWwHnFWAR1AmN9z/MDWcVxX/U5haCIvMVX7cfAQYRnU
	AJwymxurKVidldF5X/idloSjZQRicRfzMC9WoxWojITfcrGXRBiTFZ8QgdRqtwSV55eU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1n91-0006An-GD;
	Wed, 02 Sep 2026 15:45:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1x1n90-0006Ag-7p
 for openvpn-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 15:44:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4r68Ox0HAF70nxPg1ykVE73fcLrF5sReQloytpeUuAk=; b=aCSclQsR2ICvsf8ZtKhfiaa4yD
 JfMUH0E9w//DE2VXqYMcz0wNVbe0cafu1bSYSrFddlD+s2cNy7fmNbeK0yqoNUY0KyEDxvl3wMsQo
 lz0q0AoBRexOjsSXjlcSEt0WT6OmXKdet4AP9mV8lTGLXvRA9bHYrX+HtAjq2N30Jy64=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4r68Ox0HAF70nxPg1ykVE73fcLrF5sReQloytpeUuAk=; b=igRbYZXXtLFP/78+NCT8CWLK3h
 fR/1Anwq+dZ6puNM423ET3ZoPNVdzcapP6QSN1zYZEuepghmpRXKYry5ewu6Ox+InWwsfCaxVFHUB
 A0pNUSGr2s7rf3HgURebC4gXKiYgtab3dij2v/xG4q4olx9EjsH5iDNRwd1MPbXVr1kY=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x1n8x-0005he-FZ for openvpn-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 15:44:58 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 682FimQ6009186;
 Wed, 2 Sep 2026 17:44:48 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 682FimtD009185;
 Wed, 2 Sep 2026 17:44:48 +0200 (CEST) (envelope-from gert)
Date: Wed, 2 Sep 2026 17:44:48 +0200 (CEST)
Message-Id: <202609021544.682FimtD009185@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Lev Stipakov <lev@openvpn.net>
X-Patchwork-State: Accepted
In-Reply-To: <20260902141002.16513-1-gert@greenie.muc.de>
References: <20260902141002.16513-1-gert@greenie.muc.de>
X-Headers-End: 1x1n8x-0005he-FZ
Subject: [Openvpn-devel] [PATCH applied] Re: win32: unit-test the
 CreateProcess() command line quoting
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

Unit tests are most welcome, of course :-)  (and I've tested them via GHA
build, of course).

Your patch has been applied to the master and release/2.7 branch.

I have not backported this to release/2.6, as it wouldn't go without
coercing, and I don't see this as a crucial change for 2.6 - the bugfix,
yes, the unit test, debatable  (tell me if you disagree).

commit 3496ee3fb3d21ec8790abd2ebee6e5b15e7dc5d7 (master)
commit eb2469f7de77f7bb23c16d97ea610c0b7b7486b8 (release/2.7)
Author: Lev Stipakov
Date:   Wed Sep 2 16:09:55 2026 +0200

     win32: unit-test the CreateProcess() command line quoting

     Signed-off-by: Lev Stipakov <lev@openvpn.net>
     Acked-by: Heiko Hund <heiko@openvpn.net>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1892
     Message-Id: <20260902141002.16513-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38899.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
