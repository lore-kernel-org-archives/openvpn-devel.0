Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8966C5AD4E
	for <openvpn-devel@archiver.kernel.org>; Sun,  9 Aug 2026 15:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J4gaTx28Ebe7Bg4jYImt92LqD4J1iCe5Ll8q3cjN7BI=; b=kPQHQzU6ZxFqKBVn9jxkjzZFdx
	bHUZSxke7Ba3xpDYlEN8bf9S91bXuAQbiJFBkGs954Crib5Ua1+z/jT7KlpSL0flgtKXDFtMqILcQ
	7ddxJQZ/GDPAjIsqgq6FbB8qALmvfBdRiZ+Gc8yAEinUocVI6F+p2pHNGGeHwjBPxf2A=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wt5MH-00011B-H8;
	Sun, 09 Aug 2026 15:22:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wt5MF-000114-VA
 for openvpn-devel@lists.sourceforge.net;
 Sun, 09 Aug 2026 15:22:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4vQa261rPap0yPKkEkTBMLT+gMDJ0Nlj4C2+7sZfluA=; b=USXP6DHMA8p2voabOwrmlJulI4
 /1TYI9X7TyBir7Ehi0Ea0/wCKEjqY4l7o184o/m1RyCBoXOAPVevUkoYFpKsr3oeKn2MFv/LWkMd+
 apJTnSVKsFGysZSs323e+BocqGC9jT2kHw0Ij8zKJbu99A00kMK60E+pyhlCWMKQfjxE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4vQa261rPap0yPKkEkTBMLT+gMDJ0Nlj4C2+7sZfluA=; b=PSbNYAfC12MqW1pdyUubAOzlIb
 LnzOJxuExdDjHLI4d42CFS9bPN3OOxXzyxgHg4kMnK/jURgcY1chB2bgHuh3Aqn/zivxDQjTpWvXq
 BnmsmTsZulghR1sNQiuCn8gE/DNyb1jlJBmzdHOIezxUm/gzeM8OOFeEFP2wuAknChWs=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wt5ME-0004KM-OK for openvpn-devel@lists.sourceforge.net;
 Sun, 09 Aug 2026 15:22:40 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 679FMWIv019449;
 Sun, 9 Aug 2026 17:22:32 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 679FMW0m019448;
 Sun, 9 Aug 2026 17:22:32 +0200 (CEST) (envelope-from gert)
Date: Sun, 9 Aug 2026 17:22:32 +0200 (CEST)
Message-Id: <202608091522.679FMW0m019448@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20260731100815.3406-1-gert@greenie.muc.de>
References: <20260731100815.3406-1-gert@greenie.muc.de>
X-Headers-End: 1wt5ME-0004KM-OK
Subject: [Openvpn-devel] [PATCH applied] Re: Add check that username is
 identical to multi float
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

"Makes sense", close one edge case... - in theory this could go to
2.7 as well, but I don't think it's so important to have, and the patch
"as it is" won't go in without all the refactoring we do not want to
have in 2.7.

Did not actually test this with floating clients with an address conflict
(hard to setup).

Technically this refers to "v15" of the patch while gerrit has a "v19",
but everything after v3 is code-identical rebases.

Your patch has been applied to the master branch.

commit d42a9912c1d62006323a12af86baa148c77592e9
Author: Arne Schwabe
Date:   Fri Jul 31 12:08:09 2026 +0200

     Add check that username is identical to multi float

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1724
     Message-Id: <20260731100815.3406-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38095.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
