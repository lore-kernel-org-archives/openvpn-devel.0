Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B76AC5B572
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 18:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GDg85Dzd+IfUadwr22U+IlJGN7sX49awxzp3R7zL8vE=; b=bH1tkKob2H4GhXMOnnI7nHxPMH
	eV3wPDoxMXyiKjmgHCrCMUoZW+EMY27s6JDo5vqhiJNNzgSn9b9impEbHwUAf3vYyEfh0asm2v54b
	gkB0Hg1MGORyXVYmGg+1dJ2fDxjhTf5aq5GCLIOXa5M5dZd8j/UoGI14QsGhX+nb6Rdk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuaTQ-0002cX-R7;
	Thu, 13 Aug 2026 18:48:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wuaTP-0002cI-Gx
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 18:48:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=g+yOMVY+ppslxcL9FGJ+NA9AiFej8TbbCxfc0N4T8W8=; b=bbiBfOGuIYyfmsDdVKfc4ZDv0k
 IcqJJ601z10cDvL/w84uaiG/N5X4r5AK0vJrucwqImxiAGSNupkJ9vaVW6CSfB05ov3VLnSvNqRCp
 J5lkE9IZq3qquvRMo+sqnyOEk1zh+DD7rfII2Z7ZoO3Jfno1NENghcnsiWEV91QDAo4g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=g+yOMVY+ppslxcL9FGJ+NA9AiFej8TbbCxfc0N4T8W8=; b=RiWnmdZg+ImK/pZVmXvhd0oysq
 7K+AALBWIvZ0ypStRf0gZO7Ni2kua9qFezDI4IAU5tpotSJ7JK14IZEy1A85pHEPX/p+BwRbMCPZ0
 WQcyPfJ8G4LwHOS2HJJh22yREhwqIUYDuJpTuA0RS0v/Zg4K8dqpekvDvNDcPstPTUpY=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wuaTN-0000FO-Sm for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 18:48:15 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67DIm7pw087573;
 Thu, 13 Aug 2026 20:48:07 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67DIm7Tr087572;
 Thu, 13 Aug 2026 20:48:07 +0200 (CEST) (envelope-from gert)
Date: Thu, 13 Aug 2026 20:48:07 +0200 (CEST)
Message-Id: <202608131848.67DIm7Tr087572@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20260813170211.29576-1-gert@greenie.muc.de>
References: <20260813170211.29576-1-gert@greenie.muc.de>
X-Headers-End: 1wuaTN-0000FO-Sm
Subject: [Openvpn-devel] [PATCH applied] Re: Replace SHA256 with SIPHASH24
 in HMAC cookie approach
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

I will not claim to understand the details here, or that I have actually
verified proper outgoing hashes - I have seen that the unit tests works,
that the memory operations seem safe (everything uses SIPHASH_KEY_SIZE,
the reference implementation does 2x 8 byte loads), that my t_server
test bed still happily talks to tls-crypt(-v2) clients.

"Being faster than SHA256" is the key here - the old implementation
exposes servers to a certain amount of "CPU exhaustion DoS" (due to
"work has to be done on each incoming packet to see if it's a reply
or not").  With the faster implementation, the bottleneck is now more
likely "the OS TCP/IP stack", and not something we can do anything about.

This is a master / 2.8-to-be feature, as lots of new infrastructure is not
in release/2.7.

Your patch has been applied to the master branch.

commit ffa0e712eadab73b7e7b94de637d88c539cf6bc6
Author: Arne Schwabe
Date:   Thu Aug 13 19:02:05 2026 +0200

     Replace SHA256 with SIPHASH24 in HMAC cookie approach

     Signed-off-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1827
     Message-Id: <20260813170211.29576-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38316.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
