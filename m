Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB5A606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ImYIPaGo;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Stf/7CoO;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bqWnz5ZU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=4O+zjqcfJ1I0UziYBuY/IyC0CRQc13YalyY7wLbm1gw=; b=ImYIPaGomiP187
	uZXtyYbhwytxIT16Uys25AjK1xPSi/HLHduYOLYMd8ePGb+l5+KV9GVE52SLR7XwZRDm+hE8u8u2d
	gWFjfWr+1yayupyngme4ZdjJAo5qeIkpWxsVvwaSJq1TVn9sIsW6T+dd4UloAPmaMw1e8FRTq6Mej
	0VA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQQVY-0000000036a-2MK7;
	Mon, 09 Nov 2026 14:38:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xQQVX-0000000036U-18UL for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 14:38:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=YHMpYJ8A/5JGHGBDLOP6ZqhWLTRbqjevpNe+T4tCIpM=; b=S
 tf/7CoO+OOJqYpz2UcsmpTrq+tiU6mA8trU+vsBzKbfqeNb0JSqRMCuQNGisosReNYJWcJPhgQNXb
 547Lhvb18rC24RXdx8JNVqmE/DEemiQ6cqnC734IBuIRl/0OzKcud59hNtU6OV9hrhNyr3Svbs/6I
 Otu0nsK72CYKOVv0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YHMpYJ8A/5JGHGBDLOP6ZqhWLTRbqjevpNe+T4tCIpM=; b=bqWnz5ZU5aYK5Uf5qqgd4V1TrE
 NyvMYn53bNQNzxgXsiABnwOZxaMch7TZibddpe1AhWqO+oNyJUV+NW5mOh1ZE1vBvtBxxo4FsjhJW
 9F/7287kpQRJWniUC6Q2i2W6h+8CEomXrUsvdVNKUliMQXq8+8RwgZOr931czMoJo/+o=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQQVU-000000000Td-49rT for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 14:38:03 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A9EbsdQ020588;
 Mon, 9 Nov 2026 15:37:54 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A9EbrFX020579;
 Mon, 9 Nov 2026 15:37:53 +0100 (CET) (envelope-from gert)
Date: Mon, 9 Nov 2026 15:37:53 +0100 (CET)
Message-Id: <202611091437.6A9EbrFX020579@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261106162251.2926-1-gert@greenie.muc.de>
References: <20261106162251.2926-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xQQVU-000000000Td-49rT
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnserv: close the NRPT
 base key in HandleDNSConfigNrptMessage()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel@lists.sourceforge.net
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Looks good.  BB all green, and 2.7 backport test compiled fine.

To my understanding, this leaks on every call, not just on the error path
-> so 2.7 it is.

Your patch has been applied to the master and release/2.7 branch.

commit a2af48f89c00c1de24770fb4789f7cb5436e98f7 (master)
commit f352a1bb385abfe4e81220cf1757e22bc4626808 (release/2.7)
Author: Razvan Cojocaru
Date:   Fri Nov 6 17:22:44 2026 +0100

     openvpnserv: close the NRPT base key in HandleDNSConfigNrptMessage()

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2144
     Message-Id: <20261106162251.2926-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40830.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
