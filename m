Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB370C5CFC1
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oRrE9VqvdDr3m/ZJqQ5Bpger+CxsX5U0seO/WSqa8PA=; b=kCfJuWKqfJeq5bSgRzhEYWjwzX
	UFNtUJZVc54kSfA1lKsw4WsJNEYaW3lKruKJJxwAg9M0dtdgcWQrXsuCPN5i8AC3GX5asEnxLQrj6
	umezjp+/trEQUQNIsNwau1AyNJOAIjKpsXDE3O7BtUAO+wdNkg7fezJnISrPAGi7VzjA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wumV4-0006k3-4E;
	Fri, 14 Aug 2026 07:38:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wumV2-0006jx-OC
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 07:38:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zdqaxX49yb4jRPrZQ70KzP1Y8gJsHwAVrmUs0WoGsnI=; b=eRo2cyqSHtTCkqxyFCPuXw2WFs
 kI7SYoIM8yXYxrfW8Nt9WkTUd4rF+9HLxdpYHCeRhVJuuxsaPQt3BIhqPkQmsSiR9WlqtoVgYYco0
 NGaJnb+xWgg2DYJIWo/Nri3krgpKkhH/UpajBD8MuWd+aBmwPMuBwkvp/lFQZbJvlCy4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zdqaxX49yb4jRPrZQ70KzP1Y8gJsHwAVrmUs0WoGsnI=; b=A40uBT6fC4OwtmNn7E4VxnT/X7
 v2Wjwctrlw6fJXaufjTeaWlsplJkDb7Tv5NTXi5pceEHeqAm/3U/1evGSJS37pj44s1UIGiWyXEqd
 64n0afIOLWbskqYIGPR2gAxXau1/0FuDj4wTa3DN0q6azsV6VaaKWv7dU1fAk2EVz78I=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wumV2-0003Bl-CX for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 07:38:42 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67E7cQBL011437;
 Fri, 14 Aug 2026 09:38:26 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67E7cQQq011436;
 Fri, 14 Aug 2026 09:38:26 +0200 (CEST) (envelope-from gert)
Date: Fri, 14 Aug 2026 09:38:26 +0200 (CEST)
Message-Id: <202608140738.67E7cQQq011436@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260813180835.3160-1-gert@greenie.muc.de>
References: <20260813180835.3160-1-gert@greenie.muc.de>
X-Headers-End: 1wumV2-0003Bl-CX
Subject: [Openvpn-devel] [PATCH applied] Re: tun: Avoid sign-compare warning
 in header_modify_read_write_return
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

Not sure why this was left out in the sun for so long... seems I ran
out of steam for the integers.  Anyway, thanks to Razvan for looking
at this - and yes, this should not really be needed ("the compiler knows
that 'len' is a positive integer at this point") but it's not too ugly,
and gets rid of one pair of #pragmas

Your patch has been applied to the master branch.

commit 8f2c2fac6cebe453166666fd73c0f58fac1f4a29
Author: Frank Lichtenheld
Date:   Thu Aug 13 20:08:29 2026 +0200

     tun: Avoid sign-compare warning in header_modify_read_write_return

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1527
     Message-Id: <20260813180835.3160-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38330.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
