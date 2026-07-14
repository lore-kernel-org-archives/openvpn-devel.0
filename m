Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C276C44501
	for <openvpn-devel@archiver.kernel.org>; Tue, 14 Jul 2026 09:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3Xoglo19R1KcgDXez8TZAKOnxm9IChoqh+krD5ggPbY=; b=chjKXGeioLYLJqJkB9PcAHUrHJ
	ImVa0kcvnlNogCTqvTQGn4tN8do9TeAXSNhaG7o7XssYPsFoUOqSZQJz5E66Rx2llUB9F1BAnx5or
	m+I7DbBAHKCbaWs0J2TrXLpUADJ75DjUhtm2frvZ4XuLxny95ER5RXOsMXHck9lzY8Hg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjZZF-0005QX-7M;
	Tue, 14 Jul 2026 09:36:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wjZZE-0005QR-1l
 for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 09:36:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=owSm1xRymcDTlKnUgOC5nc2O9ynvlw2JD2bdd0qegsA=; b=lDxd0qJa92YSJvyDs/19BPUC2T
 n+oivvXJeX47CkSfH4JQwS+tohsLUF8YwWZ/x9jLKlCnlb36GrSIUtYjhk0ivt8p1ChvKApDmdd8+
 r1mIci+31zphygiXMWXRRriDmukJDQtChdnT6o4lC/l7Yjh0S5F77OGgAca3OSK/IjLs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=owSm1xRymcDTlKnUgOC5nc2O9ynvlw2JD2bdd0qegsA=; b=Hb1rttG6cOkRyPPcReJcfG3FfW
 +OaDG3j1RJ3TpjRAyVwGbS0MgTsjERamPt9Kw9UGzQe9MyQmsI4XCsKszcUkyxR5ZN3GpTmY2GVri
 skvcW6O5HbhokvcMiAgTJKQFueCTAaaLBKLxdbMPx2kLochIu0mHdDTd/OtzMjo8+X7Y=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wjZZA-00049B-Lk for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 09:36:43 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 66E9aQO6009931;
 Tue, 14 Jul 2026 11:36:26 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 66E9aQCw009930;
 Tue, 14 Jul 2026 11:36:26 +0200 (CEST) (envelope-from gert)
Date: Tue, 14 Jul 2026 11:36:26 +0200 (CEST)
Message-Id: <202607140936.66E9aQCw009930@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260713151816.22005-1-gert@greenie.muc.de>
References: <20260713151816.22005-1-gert@greenie.muc.de>
X-Headers-End: 1wjZZA-00049B-Lk
Subject: [Openvpn-devel] [PATCH applied] Re: t_client.sh.in: Do not run
 resolvectl if systemd is not running
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

Are Linux distributions not great to code for... but anyway, this is
a reasonable addition, avoiding non-useful error message in test output
in that scenario, and harmless otherwise.

Your patch has been applied to the master and release/2.7 branch
("improve test infra").

commit 162f19112702d1c8045efd17c5b09022fe1e04fb (master)
commit 2e63ed332ea80e6e4b344ab426ce34f74aa4de95 (release/2.7)
Author: Frank Lichtenheld
Date:   Mon Jul 13 17:18:11 2026 +0200

     t_client.sh.in: Do not run resolvectl if systemd is not running

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1778
     Message-Id: <20260713151816.22005-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37566.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
