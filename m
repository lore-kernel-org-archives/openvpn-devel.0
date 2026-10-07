Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B974CA5FFC
	for <openvpn-devel@archiver.kernel.org>; Wed,  7 Oct 2026 16:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:To:From:Date:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=W7GRAYN9oxlXuaBCW4OqkFHNI/wxgkbcP5OsSfKee60=; b=j7j+Yff06LPxEF0CTMagm3o3+F
	oDF7tzO9vdEdGGmXISUZ4nmRlX6N/W6PTGUFehu+/OyhI1Pj9F9YVDDbYqEVvsNZvTcUuGijSfzbc
	r5YT3C3tVr6+RbvfKajoViL/oBachQzlwR86zcxWnqMXvSADOcCi4gCg4uXYZJlPclzw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xEUh8-0002NI-Q2;
	Wed, 07 Oct 2026 16:40:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <frank@lichtenheld.com>) id 1xEUgn-0002Mo-BQ;
 Wed, 07 Oct 2026 16:40:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Subject:To:
 From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=69RTuYMdUgoL85mgr0GKGOZuCJd6UHFhPUia+3G5umQ=; b=lY+9rwq76SD74rwHgkI38bzSg7
 eORUgSkEJupRxGckLsA8TKURDGaKJ2PWlBv3rJp63SU4Ag7AenNEUxJcaZxnLBO8Wt6YjgAChmQ96
 L8ftWYNAiCXR5c5L1Yq2/fnc7BxP6aiakowu+qIfcdHHAtWI3AvFLQStnqiAWxIoecl8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=69RTuYMdUgoL85mgr0GKGOZuCJd6UHFhPUia+3G5umQ=; b=J
 GeSicZj94//7cpFqoqRjpDbZSMThxc6N7L3WLfyn1k+zxlf/Bp0oWriQCHTS8Tf9uJthnEwvmwtLr
 cOAONwumKu9hF7ucO2w30Uo9hravxyakWqbV8MCJIa18bjas3m+MKFn2wr58pLBUbseP1PW1+zTTT
 U8+qNrZxyXLbgzXI=;
Received: from mout-p-102.mailbox.org ([80.241.56.152])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xEUgb-0003jo-8i; Wed, 07 Oct 2026 16:40:11 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4j0Jkm183hzKvhm;
 Wed, 07 Oct 2026 18:40:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lichtenheld.com;
 s=MBO0001; t=1791391200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=69RTuYMdUgoL85mgr0GKGOZuCJd6UHFhPUia+3G5umQ=;
 b=tUdJorPxcwz2ISj/N2H8GwJuTDS68IOLaLwCyQGaRSx4M4xI3oVTG7LjlZpAQhhoF6wW6J
 pLxV+rXBdzfYKaPIQ6DuXN74CNPbYOQgimT/Q4w9XBxJSbb7UJBBZVVRs3Xw3zmXjlD1YC
 Wjrpn6/EFynBQD1xTJrDwvlr+4/GkRU8dGIjQxdrzo+kD6+tuzEovr5g5RAIHb5MusaJvW
 UQAbhXG661OupKY+1Xu4eIOLwzyuQuFSSBWTUBZ/HC8fSNi8zKAMQiG//S1Bs8cgXMzr4z
 qCz9DYwSWJaIKa6u4tGuc9CFsLsAowIPuurBfEMWa4yPBtFMbAFkXAoXSx6tBQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of frank@lichtenheld.com designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=frank@lichtenheld.com
Date: Wed, 7 Oct 2026 18:39:58 +0200
From: Frank Lichtenheld <frank@lichtenheld.com>
To: Openvpn-announce@lists.sourceforge.net,
 Openvpn-devel@lists.sourceforge.net, Openvpn-users@lists.sourceforge.net
Message-ID: <asZ13tD1_12Cbd6Z@flichtenheld-TUXEDO-InfinityBook-S-15-17-Gen7>
MIME-Version: 1.0
Content-Disposition: inline
X-Rspamd-Queue-Id: 4j0Jkm183hzKvhm
X-Headers-End: 1xEUgb-0003jo-8i
Subject: [Openvpn-devel] OpenVPN 2.7.8 released
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

The OpenVPN community project team is proud to release OpenVPN 2.7.8.
This is a bugfix release fixing several security issues.

Security fixes:

* Check for NULL-Bytes in certificate subjects - refuse all such certificates now as 
  "invalid" (CVE-2026-84790).
  (Bug reported by Vivek Parikh)
* TLS handshake with tls-crypt-v2: do not try to add a wrapped client key if no key 
  material is available (client bug in response to an ill-behaving server).
  (No CVE assigned as "a malicious server can stop the client from working properly" 
  is not considered a CVE-worthy security issue according to the CRA guidelines)
* options: fix unsigned underflow when clearing domain_search_list (CVE-2026-88964)
  (Bug reported and fix contributed by Cole Munz)
* win32: stop cmd.exe from expanding variables in quoted arguments (CVE-2026-84256)
  (Bug reported by Darren Carreras)

User-visible Changes:

* Certificate validation is now stricter regarding NULL bytes in strings (see 
  above). This might break existing installations if such certificates exist and 
  OpenSSL builds are used. mbedTLS builds always rejected this.
* On a certificate with duplicate fields (multiple CN, for example) OpenSSL builds 
  would use the last one, mbedTLS builds use the first one - changed in the mbedTLS 
  build so behaviour is identical.

Bugfixes:

* DCO: remove installed iroutes at client exit time, not at delayed multi instance 
  cleanup time - otherwise there is a race with reconnecting clients, possibly ending 
  up having "no iroutes installed in the system at all". Bug reported by OpenVPN Inc 
  Access Server team.
* DCO Linux: fix remaining races between synchronous netlink operations and incoming 
  asynchronous notifications, by adding a second netlink socket and strictly
  separating sync/async operations.
* Client: refuse incoming pushed option combination of epoch data format with non-AEAD ciphers 
  (restart session instead of aborting with a fatal error).
* DCO (Linux and Windows): on failures to set up a new peer or install key materials for a 
  peer, do not exit OpenVPN with a fatal error. Instead, signal the error up the call-chain and 
  restart the (multi) instance.
* The handshake is inherently racy when a peer is removed kernel-side due to transport errors 
  or timeouts, and userland does not yet know this and wants to, for example, install new keys. 
  This is fatal for the particular client instance, but must not end the whole server process.
* DCO: stop fetching peer stats during client disconnect The intention of the original code 
  was to ensure reported counters are always correct, but it did not work (because at query 
  time, the peer in kernel is already gone, so we only got an error message) - and very 
  inefficiently so (because we queried all the peers all the time). End-of-session final counter 
  values will be implemented properly by a followup patch leveraging counters piggybacked on the 
  kernel's "DEL_PEER" notification message.
* p2mp server: improve handling of mbuf lists in the face of broadcast or multicast traffic, 
  and fix a bug on client exit that could lead to a server queue deadlock in very particular 
  scenarios.

Windows MSI changes since 2.7.7-I001:

* Update included dco-win driver to v2.8.13
  * CVE-2026-105390 - a locking flaw allowed a local user with access to the driver's device 
    to cause a system deadlock and denial of service, hanging the host until it was 
    power-cycled.
  * Performance improvements by moving to multi-core data processing.
  * See <https://github.com/OpenVPN/ovpn-dco-win/releases/tag/2.8.13> for details.
* Update included OpenSSL to 3.6.5
* Update included Easy-RSA to 3.2.7

More details can be found in the Changes document:

<https://github.com/OpenVPN/openvpn/blob/v2.7.8/Changes.rst>

Source code and Windows installers can be downloaded from our download page:

<https://openvpn.net/community/>

Packages for Debian, Ubuntu, Fedora, RHEL, and openSUSE are available in the various
official Community repositories:

<https://community.openvpn.net/Pages/OpenVPN%20software%20repos>

Kind regards,
-- 
  Frank Lichtenheld


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
