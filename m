Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF183C55174
	for <openvpn-devel@archiver.kernel.org>; Sat,  8 Aug 2026 06:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=teg4OEx7sCSXkk8dEf5gbtBa9pzCuZqiDOZFP0muXzw=; b=MKjfDnLrFVACHTaYp6xlbJHKgW
	JOXm2TDXDRv3cVixtp5KlnARrT0ikVNr6Lo3EfpRfuuWpXP7tcGrG4lheyV1zSZngqfSgXV+jQdX0
	KYbSrD4XgxcryUfDOAoCrtf9+H6Uq2Yv2Rahnqnm94QeubfZvEgxa+CtnRZXOw6dBrZk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsama-0004E6-SK;
	Sat, 08 Aug 2026 06:43:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wsama-0004Dz-C3
 for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 06:43:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kWEngDxZa1wvC/oAdcL4NIaylm5MevsuCYC937VxcOc=; b=jbeo/PjFjJnXSCyhca2dyeYNSy
 9IjMY9F5Wtfy2w3P0ZKrZbC7n3b121cPePxXnIRx5lgmyeaWfFFPCLuI7dMgmBjaqdxBFPXIgh1wl
 34bzV0CjkgFkHLvoFba8V0ciU3DILi6NkJaWvj6E0hlLs/QgRtdorZTMaLi/mpJKhA10=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kWEngDxZa1wvC/oAdcL4NIaylm5MevsuCYC937VxcOc=; b=L9AcZOt4uijZ+f5qgyuq/wa8QA
 vTJa7vaG4ZgprZta1b28vprFGGjtaWd+e9OBsaIncUPzj2+wQsjN9ilU6Dtim22u/jrXiU1WYdDFd
 3J922wH8Ct0MN/dmiv9yWlM54APSkJhXCDTrsxHKPIDuU/9He11sg8PfPqfNC0FlxNf4=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wsamY-0006kq-G0 for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 06:43:48 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6786hdpA052460;
 Sat, 8 Aug 2026 08:43:39 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6786hdVo052459;
 Sat, 8 Aug 2026 08:43:39 +0200 (CEST) (envelope-from gert)
Date: Sat, 8 Aug 2026 08:43:39 +0200 (CEST)
Message-Id: <202608080643.6786hdVo052459@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20260806153230.65971-1-frank@lichtenheld.com>
References: <20260806153230.65971-1-frank@lichtenheld.com>
X-Headers-End: 1wsamY-0006kq-G0
Subject: [Openvpn-devel] [PATCH applied] Re: Use OpenSSL's SIPHASH
 implementation to double check our implementation
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

This does not actually *do* anything for "man openvpn" yet - it adds
unit test code verifying that the "siphash implementation used in main"
(currently only reference) tests correctly against OpenSSL siphash - tested
this on Gentoo with OpenSSL 3.5.7

PASS: crypto_testdriver
..
[ RUN      ] test_siphash
[       OK ] test_siphash
[ RUN      ] test_siphash_openssl
[       OK ] test_siphash_openssl
[==========] crypto tests: 21 test(s) run.

Also tested "make distcheck" (as this adds a few new files and we like to
forget to bundle them...)

=================================================
openvpn-2.8_git archives ready for distribution: 
openvpn-2.8_git.tar.gz
=================================================


Your patch has been applied to the master branch.

commit f129a7807408b1cb2975e47e99f594c587ba4576
Author: Arne Schwabe
Date:   Thu Aug 6 17:32:30 2026 +0200

     Use OpenSSL's SIPHASH implementation to double check our implementation

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/31
     Message-Id: <20260806153230.65971-1-frank@lichtenheld.com>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38180.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
