Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2169B606A324
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 17:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=l+PPVv40;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=MsBTncoC;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FlACCoEi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=d0HVtby5GlfpKIhQD4wykh9jjLr+ptSAOCabxrAArLY=; b=l+PPVv40q5t9Uf
	zQFtlJZZTySk36ce6ubvNFsZrdVOwZ1cT/M4eRk5K+ZCFFX45Sq5cjcb3L3SfZCUuwg0eFgvSP0zC
	dQZfKtsDMDQnyXdOBJrEbV2jGwxJXOWo+v3KjlSC+ym7nFECrRHjUPJBPolr0XBlnaDg/0aga0W2k
	mXA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOI8x-000000001DJ-4BAp;
	Tue, 03 Nov 2026 17:17:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xOI8w-000000001DD-2cJr for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 17:17:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Zlf7nRvY4z3QnFlUlUSHTNm3ro94G7Qb9n7JF3/3Lho=; b=M
 sBTncoC/hkOnWAkFdU+BZNMK9R+bjYfACiwRAgNOzDikJVdFNItEODMJIIZvb8IK9OhQfVQGZyCYQ
 +Sg3NJZD+KV119fa9sNWwzbK1eoEmEY7tFH+G6xkl21uY+fcbJ1XBoNNDp9gJpYq+iCIzvr3Rme0a
 fC5nt9JWARMftCpk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Zlf7nRvY4z3QnFlUlUSHTNm3ro94G7Qb9n7JF3/3Lho=; b=FlACCoEisx3w4Oi2xQLKrGZr6+
 k2bKiBjvMTJyCnBhe38xEPc4pgRSOV4CG/LWH3WJuHpAyVi/rk9kgUrr6oeyMlFosCmthwSCHRaW+
 LgIDrPgl1A3tIaQlRSaxjCqcEm7uYBWcefdysmuWZGQdd7xgc015MsDNlUdhoq1gXJcI=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOI8v-000000000xM-25tW for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 17:17:54 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A3HHkLh051261;
 Tue, 3 Nov 2026 18:17:46 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A3HHkW3051260;
 Tue, 3 Nov 2026 18:17:46 +0100 (CET) (envelope-from gert)
Date: Tue, 3 Nov 2026 18:17:46 +0100 (CET)
Message-Id: <202611031717.6A3HHkW3051260@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261103121903.2369-1-gert@greenie.muc.de>
References: <20261103121903.2369-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xOI8v-000000000xM-25tW
Subject: [Openvpn-devel] [PATCH applied] Re: console_systemd: free argv when
 openvpn_popen() fails
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

Good catch, and the resulting code is easier to read anyway :-) - haven't
seen if I can actually trigger it.

As it's in the (unlikely) error path, and it's just a mem leak, keeping
this to master.  Not tested, just stared at the code a bit (and BB all green).

Your patch has been applied to the master branch.

commit 4a6bd5f532195ca89550c3e930576734ac7ff486
Author: Razvan Cojocaru
Date:   Tue Nov 3 13:18:58 2026 +0100

     console_systemd: free argv when openvpn_popen() fails

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2097
     Message-Id: <20261103121903.2369-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40566.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
