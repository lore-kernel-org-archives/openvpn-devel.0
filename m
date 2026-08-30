Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23CE6C61DD9
	for <openvpn-devel@archiver.kernel.org>; Sun, 30 Aug 2026 17:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uhlx7cURDKG300AdRkNu+o3rF8bhSUqPC4XW2sYWNOc=; b=Xd9AH8Am5/60W9ogYiE3QH/GAk
	V8Jlw7N375/LK1v3PqVd+4D63FJc7PdbyJUjYIbnV2QUXTi3aGNQf7jBjiPCdBYIlLLK3k28XEX44
	hzkAZKbcNCwlzbgDLn5rlPSWP1ynkio8G6K6cOm/6rVThmBifJHNfPNT1Buqs/QTIXVk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x0j4a-0006pw-9r;
	Sun, 30 Aug 2026 17:11:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1x0j4Y-0006po-G4
 for openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 17:11:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SE4VQ8E4ICsMXhUXZZsq94Fl8E5JYSUW5HR85OrBx+E=; b=STpMN4vJTCxrNZ2vFryppXOTHs
 88hhZ/gdiBawdDdGQskmlA09agEFyqq6ajDIGccCOTWJ8NJgO5aNON5F8KqDmWEhwpzbq4jqhrXrv
 z3xyq9QUVBy367YdfUt0Z7jyBbKcXsJugK28dKzpSi8//U//sXK3lG4Drdd8BvCVOYiE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=SE4VQ8E4ICsMXhUXZZsq94Fl8E5JYSUW5HR85OrBx+E=; b=jQb1QrO2ynJKfGjAQOxJF8s2t0
 45GIIKvK5uUN4t/o88YTTuBg6GVxA9FmbPW/MYbib6W22Gq6mjNl7crE7qtI2YBldkV4G1GMucWA9
 plrcZqo7+1daVz6996COYqYJMhRPyf1RY8I3v7oDbUGB2vKkYW6BExDnxndIE5jRNv4c=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x0j4U-00044j-3i for openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 17:11:55 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67UHBcSQ081244;
 Sun, 30 Aug 2026 19:11:38 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67UHBcpY081243;
 Sun, 30 Aug 2026 19:11:38 +0200 (CEST) (envelope-from gert)
Date: Sun, 30 Aug 2026 19:11:38 +0200 (CEST)
Message-Id: <202608301711.67UHBcpY081243@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260824180353.12076-1-gert@greenie.muc.de>
References: <20260824180353.12076-1-gert@greenie.muc.de>
X-Headers-End: 1x0j4U-00044j-3i
Subject: [Openvpn-devel] [PATCH applied] Re: t_client.sh.in: Allow to
 override the location of t_client_ips.rc
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

"Makes sense" :-) - I can't remember having to run into *this*, but it
definitely looks good, applies fine (now), and does not break anything.

(As for the previous t_client patch, we should bring "the total" back
in a joint commit to release/2.7)

Your patch has been applied to the master branch.

commit dc162485236b70ecfe1be639dbd9db8244a85d54
Author: Frank Lichtenheld
Date:   Mon Aug 24 20:03:47 2026 +0200

     t_client.sh.in: Allow to override the location of t_client_ips.rc

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1756
     Message-Id: <20260824180353.12076-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38649.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
