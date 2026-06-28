Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D20C43458
	for <openvpn-devel@archiver.kernel.org>; Sun, 28 Jun 2026 20:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6Pex9xL5WB2Hq9Vobq3/qmaFh+XGs1PqBqPEhI8TS0o=; b=Dew6fDzWpA4jAPtWyykYfOnzCr
	NjuTg9WrrkNjg1GjTEFnahGia4KZexGrcKDuvBtGRc1nwLwd+XL85jWTJxNOp5Rdwe3fDhhaTpVGZ
	2bYyfoQPqZ32P65taJ/zwxpAFUkXpTporzydL/1g2jebXI6ROo6M+IHi5uisa5YmwdWo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wdwC5-0002ti-3f;
	Sun, 28 Jun 2026 20:33:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wdwC3-0002tc-FD
 for openvpn-devel@lists.sourceforge.net;
 Sun, 28 Jun 2026 20:33:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xeA+LGPhovCwRIYz5OZf12zg3rdXmGu9c59dIFK+RHM=; b=eAPex0gi3JVvjL34vZ+DlvNuea
 fJrxQy3pHIWohKWrJkLxEjIz94tz47CfwhD5C0ugdiSM+kaWHXkk3nDV6VE9yYaG5YWQst5LDlKb5
 h/ysqanPAJdpqKewv4dy8Nke7eXE6mTnf3r44bd6urntL8AnexIRcoWnmUOUZ640S2jk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xeA+LGPhovCwRIYz5OZf12zg3rdXmGu9c59dIFK+RHM=; b=GKq0VBHVsUoogpkuDXXQZyAmH3
 71qLwKmBzufQ2vjI0Vq7NwcZFZtmlu4F+XrgonzQAQsWmUWJA30DbA97t2hONxRpOBkdYJOtzVkYy
 KWGnkJh/BWobX1LJ7vPD8lZb0YKlaRDwcFnEouxdUpHWqYgngMXGj38qOIgajZ9wi7EI=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wdwBy-0003P5-Db for openvpn-devel@lists.sourceforge.net;
 Sun, 28 Jun 2026 20:33:28 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 65SKXFTH017671;
 Sun, 28 Jun 2026 22:33:15 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 65SKXFGT017670;
 Sun, 28 Jun 2026 22:33:15 +0200 (CEST) (envelope-from gert)
Date: Sun, 28 Jun 2026 22:33:15 +0200 (CEST)
Message-Id: <202606282033.65SKXFGT017670@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20260628150320.13244-1-gert@greenie.muc.de>
References: <20260628150320.13244-1-gert@greenie.muc.de>
X-Headers-End: 1wdwBy-0003P5-Db
Subject: [Openvpn-devel] [PATCH applied] Re: Fix building wolfSSL with CMake
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

CMake build system only, ACK from Frank, buildbot is happy with it
(= it does not break anything - we do not have WolfSSL buildbots
today to actually test this).

Your patch has been applied to the master branch.

commit 9e2f3843df1cdacffb20f7ca4e6aba6a784acb05
Author: Arne Schwabe
Date:   Sun Jun 28 17:03:15 2026 +0200

     Fix building wolfSSL with CMake

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1604
     Message-Id: <20260628150320.13244-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37342.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
