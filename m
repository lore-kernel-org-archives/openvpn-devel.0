Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C06606D81F
	for <openvpn-devel@archiver.kernel.org>; Thu,  5 Nov 2026 17:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=e4HG+Pzt;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=PfFOyv4K;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=d8K8khd/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=skeN75OWhanNvRZ39CTp6kIF+g/61PTRJuXCWGHj09k=; b=e4HG+PztQXmkHU
	ZxA55dZAYkaIzHWlOGXhkw+gjW56ln6tQQOZlmF4XGuaZEYH+lHbng97cuHJ2z1T3raOObQJOum1P
	PS+LUgHi6BsJf/z7UtflOtwiyDMjoCLXTpnVbaE9i6GFmm73WLGtlds0RDBxfh0fCieLg3dU8oQam
	9to=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xP0s6-000000003TH-0hhu;
	Thu, 05 Nov 2026 17:03:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xP0s4-000000003TB-3oP3 for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 17:03:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=vUzGOrCwz6tQ3uOBJ8rdFhbnQHgG35bbwtLCHbT9Fvc=; b=P
 fFOyv4KUK9yZt0NDvd9HP8g4OIVTU5/arpnmKzP9bRr48lw5fmKeqZzBwNwHWIunEH/ifu5sXA8uQ
 cDzNKClWpTooDo7VpnqwPqa2AJsu2UDX83k35ulpknYgXSBRTHQnlnIRcaiKPJX5Kw+MbQzCWMIB2
 9gwKnckdtQwAHHnc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vUzGOrCwz6tQ3uOBJ8rdFhbnQHgG35bbwtLCHbT9Fvc=; b=d8K8khd/fVvlZ6KWZ42Sw3SBQl
 IAqvsZpDNGXiQJwT2vWOXk7E5INchCjVf7OIVnUeX6aQTKxei4hA3PnE+A4uaSyFrOf36+F82wW8z
 6JCE2IdMj2jkfY8wLf0TNgZJrqkCgpND0TE5wDgJZg6KIA6jqvzpQI/aop3fBAWsnVsw=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xP0s2-000000007Uy-0p4Y for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 17:03:28 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A5H3IPK048804;
 Thu, 5 Nov 2026 18:03:18 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A5H3Iwo048803;
 Thu, 5 Nov 2026 18:03:18 +0100 (CET) (envelope-from gert)
Date: Thu, 5 Nov 2026 18:03:18 +0100 (CET)
Message-Id: <202611051703.6A5H3Iwo048803@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Hansaem Wi <hansaemw@gmail.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261105093736.11814-1-gert@greenie.muc.de>
References: <20261105093736.11814-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xP0s2-000000007Uy-0p4Y
Subject: [Openvpn-devel] [PATCH applied] Re: crypto: Wipe the struct
 key_parameters copies after use
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

.. and the last one in this series ;-) - missed 2.7.9 release, due to
"day too short" issues, but 2.7.10 will come...

Your patch has been applied to the master and release/2.7 branch.

commit 09fd5ac8e4f679a58b02ed2f883ebf4a4d7205a7 (master)
commit 4608daa51451fd63c52cc2e44371608604259a99 (release/2.7)
Author: Hansaem Wi
Date:   Thu Nov 5 10:37:30 2026 +0100

     crypto: Wipe the struct key_parameters copies after use

     Signed-off-by: Hansaem Wi <hansaemw@gmail.com>
     Acked-by: Steffan Karger <steffan@karger.me>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2078
     Message-Id: <20261105093736.11814-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40749.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
