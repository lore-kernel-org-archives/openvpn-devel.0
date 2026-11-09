Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767F86082BC3
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 15:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=XKMItbYZ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=M4idWQax;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=WyLT541g
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=tLzL6t8ZU1CWMvcmg7CQV1ARWOdDrr5TeEcbW40yvrw=; b=XKMItbYZp0F4o4
	EHoFCF4qV/Rts4VIO+OoQKq155wIj2snMfitjKje6xByst46LMyaOpgRUdk10GdNjDTzEIaOEysD7
	GWR7YiYmz2mJPqBhrigo4sOImHPwg3scHgRCu567pohgekwxREnRR4H0V8QQ0xQFEHGWz5pmXBv/D
	m1Y=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQRYQ-000000000EA-3RX2;
	Mon, 09 Nov 2026 15:45:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xQRY8-000000000Cz-2PQv for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 15:44:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=mcXn4M+NdFDxgTof4/7Ey4oK/wUID+uWckBt5xjGIWw=; b=M
 4idWQaxa3vomLwd1Dh2qd/EwZIfGwnHkn3LJAJaqkHqtuSt0yW0Bk87COb87aTALL1Pwzec/0uToG
 gqDR8xoPv4weXN1vdZbKFCZjEctf2UcKSiQLnYymlDT2ukF4HXy1tJYJcM+xaSBWtP+sthYqclzuY
 pCkbGUPsEFEs4mJs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mcXn4M+NdFDxgTof4/7Ey4oK/wUID+uWckBt5xjGIWw=; b=WyLT541gLpMJkXbK0WC5ovBSks
 N1VBRgBkncLCxoN6HDnhymr7GKuObWG2Nn585IoWrlk2FZIxLn0NyQ8Ixe5FO5ygu7hiDf3ufPqoT
 YKMqYMYMcmOOqJ4R9yttQqVSxf+vflDmFE8Q0XYwlOwQ3nm7EuAcQdkSaWK3/P1A32eA=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQRY4-000000002Tx-0tFg for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 15:44:47 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A9FibWb029029;
 Mon, 9 Nov 2026 16:44:37 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A9Fibp0029028;
 Mon, 9 Nov 2026 16:44:37 +0100 (CET) (envelope-from gert)
Date: Mon, 9 Nov 2026 16:44:37 +0100 (CET)
Message-Id: <202611091544.6A9Fibp0029028@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261031190839.30023-1-gert@greenie.muc.de>
References: <20261031190839.30023-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xQRY4-000000002Tx-0tFg
Subject: [Openvpn-devel] [PATCH applied] Re: Remove PACKET_TRUNCATION_CHECK
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

This looks much larger and more complex than it is, but that's because
clang-format likes to have defines all neat and tidy, and if you remove
the *longest* definition, everything else needs to be reformatted (*sigh*).

"git show -w" shows that the errlevel.h change is really just
"-#define D_PACKET_TRUNC_ERR" and "-#define D_PACKET_TRUNC_DEBUG"...

All the rest is "remove code that is inside #ifdef PACKET_TRUNCATION_CHECK",
so easy to review (or not).  The code was not used in the last 15-ish
years or so, didn't do IPv6, and would have needed an overhaul... but 
the reason it existed in the first place was also lost.  Bye ;-)

Your patch has been applied to the master branch.

commit 91bff1b6be151c20e9db180b791b7ccb2765ce95
Author: Arne Schwabe
Date:   Sat Oct 31 20:08:34 2026 +0100

     Remove PACKET_TRUNCATION_CHECK

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2071
     Message-Id: <20261031190839.30023-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40382.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
