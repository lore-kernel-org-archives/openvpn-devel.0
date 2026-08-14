Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B65F9C5B572
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 08:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=97/YWoJiQpRAM+6cUQHe0HvFGSJ6mWqwxZ1oUIlRM24=; b=KOXludEIXbhu3an5q9XnWl6GeY
	WPeTFA/yVAAhWl9LLsABNOp5y4CuzLBF+Ftop5uNxdVPCErsY6iD5Hc+RvZ7j0DTft3jLzq8V7DTi
	igxBzSzJXxUR5cAMR/doBMKHX11B6sTdFXAz5cmpy6v7ZToIXOR+m1VUrNQ/vkVzJPr0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wun94-000112-MP;
	Fri, 14 Aug 2026 08:20:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wun93-00010p-JE
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 08:20:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Mu9M6Xyj2b2Tmxmx0T+rHnSHUfTmv1fpZT57nrQTcIM=; b=f/+YiZ7hQa8T0/3PS2k1M0mT8j
 PoQJTQdkOV81+DLACADx5ayUxHjTG4lsYC2eu52XXj7w/CW0avLfcc7aBkmK/LEBXfPEdjvzmL8CE
 VEbZNT2G2CNdVD7FVdXwelssL8soVxIa+CXkcABkRLGrNLdKQUa3Kf5TtTCkNN629MWE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Mu9M6Xyj2b2Tmxmx0T+rHnSHUfTmv1fpZT57nrQTcIM=; b=jfUtK/lIt3qDQ6sbk9JGbttsuX
 5E3TqDrZvO4tpY4cbVOOZwQP9wn2CPNdQenpWJ8tE/UfrhQR8146D3Bg/k9xGIi+VGTGQfgDL3CCr
 zRPpv71Q6j6kM1D6TY4RK7Q8brYqdaBM49YWKVSBeDtjWMFFqdxaWLKkeqBoi6NOajf0=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wun92-0003mN-Ce for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 08:20:06 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67E8JnjG012784;
 Fri, 14 Aug 2026 10:19:49 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67E8JnpE012783;
 Fri, 14 Aug 2026 10:19:49 +0200 (CEST) (envelope-from gert)
Date: Fri, 14 Aug 2026 10:19:49 +0200 (CEST)
Message-Id: <202608140819.67E8JnpE012783@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260807131443.53351-1-frank@lichtenheld.com>
References: <20260807131443.53351-1-frank@lichtenheld.com>
X-Headers-End: 1wun92-0003mN-Ce
Subject: [Openvpn-devel] [PATCH applied] Re: t_client.sh.in: Do not try to
 guess the absolute path to LOGDIR
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

For normal "run this in our 'make check' framework" this shouldn't be
necessary, but ISTR that it breaks for the client-VMs for t_server - so
that might originally even be something I had to fix myself...  and it's
good that t_client.sh gets a bit more polish.

Your patch has been applied to the master and release/2.7 branch
("test support").

commit b32d1ab45ec93786191e0dac2c8f5549d6c04258 (master)
commit 5d81653bf2c9ecbf9d168caa2b60fb65ddf25517 (release/2.7)
Author: Frank Lichtenheld
Date:   Fri Aug 7 15:14:43 2026 +0200

     t_client.sh.in: Do not try to guess the absolute path to LOGDIR

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1764
     Message-Id: <20260807131443.53351-1-frank@lichtenheld.com>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38210.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
