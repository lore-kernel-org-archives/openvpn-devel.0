Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F8EC5AE49
	for <openvpn-devel@archiver.kernel.org>; Mon, 10 Aug 2026 13:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Akk8lqVXK4N2xZKg8V0GAgsTzM+Xu+3ziidsNidEreE=; b=ZfcvendQ+9ztjCHQoKoBXUST5H
	ky0mwya7M1bsUBaR+jJQFuBJxuo3jAqDCOGlV89kJJj2w91H33QZL/BeNavF/TDU3PKn8OWbGiarz
	IgXyOZN84jtyfLJ1a+FSBll3ayD2Dx/sduM7GphoDKPv9rRyQ6VBzFKvpeh4XGHzK48Q=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wtPpD-0007hT-Fn;
	Mon, 10 Aug 2026 13:13:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wtPpB-0007hM-Oq
 for openvpn-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 13:13:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UIi8TzTGqJmO5QAQmSLPWQq1YEmA0CbAjwhuMIP1hEo=; b=Dj2HNgcXui14wxlpW+5XYqjkPH
 FMHMgDjBMoaOhqyDoalsbpmEyYaYXU6jumQAEjwk5d4xIHPtIsnWXKfqT9Gd9vQPt+TWnpAnglC+V
 eU5gL5ibOR377+TDPFgfNp4ZXzpHlHcRmDg9eECqednTajmSvt4XT/muWb5JfOA4G+Wc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=UIi8TzTGqJmO5QAQmSLPWQq1YEmA0CbAjwhuMIP1hEo=; b=eq/KxtTJL/7cNP9Wr3dxeefbOo
 9JZq7DPQB6TkfGeDLccdohaRf9UsBALfBfN5onzRr1v+JTscKXwQGumLZAZHDWhZ79yuoMxl6f+49
 lzXNuxYv0CiUh1WpvUqWaMAQfyzPGbostAf+EOVrwXwDgLBEpM0f50mU1XuPI52K2wCc=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wtPp8-0004PJ-5i for openvpn-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 13:13:51 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67ADDWWo041614;
 Mon, 10 Aug 2026 15:13:32 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67ADDWBd041613;
 Mon, 10 Aug 2026 15:13:32 +0200 (CEST) (envelope-from gert)
Date: Mon, 10 Aug 2026 15:13:32 +0200 (CEST)
Message-Id: <202608101313.67ADDWBd041613@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260809153046.14738-1-gert@greenie.muc.de>
References: <20260809153046.14738-1-gert@greenie.muc.de>
X-Headers-End: 1wtPp8-0004PJ-5i
Subject: [Openvpn-devel] [PATCH applied] Re: t_client.sh.in: Use printf
 instead of echo -e
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

Thanks for applying some polish to t_client.sh :-) - and indeed, these
echo incompatibilities are most annoying.  Tested this on FreeBSD,
OpenSolaris and AIX (which are known for a slightly icky shell).

Your patch has been applied to the master and release/2.7 branch
("test infra improvements").

commit da1b2a7081eb2791f3a675945c42d7f3189ef752 (master)
commit 2c0c5809bb1d0e1f4d93927f4a11988f675f22d2 (release/2.7)
Author: Frank Lichtenheld
Date:   Sun Aug 9 17:30:41 2026 +0200

     t_client.sh.in: Use printf instead of echo -e

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1753
     Message-Id: <20260809153046.14738-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38258.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
