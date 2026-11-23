Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DB7606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 17:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MKlUq3Ei;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=X+eS1vs9;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Vfz0PR36
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=qQzD/m6Vs/ib7uUtGQjiCCCrAf9WSRJEIgsn9PvAuok=; b=MKlUq3EiI8AXZD
	LFcXo/zeYzQMApE90su94b7Yy5h88DWLsj86fHwfqP869mSAAqyWUKnPgoFIYugmz1YvQKM0RA6g8
	YxNKmJtuqQ523VZ2W6gHJQlCjQQ6b95KbfeUlwZDgxG5Rd6iC7oOPBTaDvtxD0cLvvSFDC8tuuilo
	J2w=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVY7Q-000000007cK-3ypQ;
	Mon, 23 Nov 2026 17:46:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xVY7Q-000000007cD-0qYl for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 17:46:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Dn6+hDBReJeKPTA3PNTKp9AD7lgTe9ZkrGGxcWG8cxc=; b=X
 +eS1vs9+CcJL9SetG2F5CVmpML3vkd52mAnMrupVqxx6ZpoNAGUvp9P8L9GWYBpkCQza0/bfKNfG2
 FAt0hZMhXEEf15f88knlAIFJIwTv+iIbifcCQ1kpCIumxpjwY085QyPzBVxVErW4X7FMmq/b94Hou
 JkBXwqIG1qyGKB3M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Dn6+hDBReJeKPTA3PNTKp9AD7lgTe9ZkrGGxcWG8cxc=; b=Vfz0PR369oMX3Fn4OIKDqscH2h
 F2kXiCVmDNw/wU8n0vLelZSn0BjBmNfdPEaMaV1FZUwepuaud8JRT7o+zwXoudprHpO4VZcMNIC7D
 W5lvNAsfPYOR+NIyuU81QREak+PGaVFQSXi8VJ5GWLZdYnkb5zk4jnbAN197HTZWtDjs=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVY7O-0000000026o-2N3a for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 17:46:20 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6ANHkCYB085703;
 Mon, 23 Nov 2026 18:46:12 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ANHkCdW085702;
 Mon, 23 Nov 2026 18:46:12 +0100 (CET) (envelope-from gert)
Date: Mon, 23 Nov 2026 18:46:12 +0100 (CET)
Message-Id: <202611231746.6ANHkCdW085702@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261123141837.2675-1-gert@greenie.muc.de>
References: <20261123141837.2675-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xVY7O-0000000026o-2N3a
Subject: [Openvpn-devel] [PATCH applied] Re: tun: drop unused
 is_ip_packet_valid()
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

Something easy before dinner... :-) - obviously correct, BB confirms.

Your patch has been applied to the master branch.

commit 8aa208ae714a19708e3c7264409f0cf51bf0f3b3
Author: Razvan Cojocaru
Date:   Mon Nov 23 15:18:31 2026 +0100

     tun: drop unused is_ip_packet_valid()

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2329
     Message-Id: <20261123141837.2675-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41829.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
