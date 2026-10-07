Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91EA4CA5FFC
	for <openvpn-devel@archiver.kernel.org>; Wed,  7 Oct 2026 19:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:To:From:Date:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=U22UmH28PbBXLWl1Pi2K9d72P4ZBSdm+cz1L0yVntXw=; b=RfG5vVaPWIyUrJfHRfNItd1Gkt
	3Pfc2rW0ZNjtC7KH9vee3t/dmvGsDIdh8EQ1I1TolNkraUSXM1ND2gg9HdqRpVMdVB/j6MktSOfqo
	/OQX8Q8CUIA0z2FxqvEAbcTEvEVswvhK4m/OKP1kk4mriJ2tB+IiRB9UxB2sD7Tn3MGo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xEWv0-0003MD-U2;
	Wed, 07 Oct 2026 19:03:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <root@relay.chelinvest.ru>) id 1xEWuz-0003Ll-9w;
 Wed, 07 Oct 2026 19:03:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:
 List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
 MIME-Version:Message-ID:To:From:Date:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Owner;
 bh=a3gQ97fr8qKEqHLvvD7fiKA+hLwyPDEJU9FDTnQVSkU=; b=IUusd8jXmmNq1F4tZ0Lo/8vqtN
 XMGlLjfuDUigrPL+Mg/SiHqkggWJmeqmugsWBLRovsaouFmet4quCKTtFyfw7KqoT7eOXHZvls1re
 ZtIRwNblvOHu5Y6BwFGBlU8h4R2SyXjrj4MXqiJbKGZImd1wKFzmeijWHBqiXP2KjWpk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Subject:Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:
 List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:To:
 From:Date:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Owner; bh=a3gQ97fr8qKEqHLvvD7fiKA+hLwyPDEJU9FDTnQVSkU=; b=Nko
 wvHITAdxP9VyIFGK055QT9RmwKYfB9DtHTLIIZqluf6LFwx6qIeIglPBmnFySvr/qSZoMz0KbBx/y
 Du14qJsDSdC+eZXmHlu8C2Xi024ikZhGdxWW1923OjaUoycWbZrgAEM7RgXmp/dgbRJorDLqz+pke
 ljZjZOg+EkLpLc=;
Received: from relay.chelinvest.ru ([195.54.10.10])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps (TLS1:DHE-RSA-AES256-SHA:256)
 (Exim 4.95) id 1xEWuw-0007G5-KU; Wed, 07 Oct 2026 19:03:10 +0000
Received: from relay.chelinvest.ru (localhost.localdomain [127.0.0.1])
 by relay.chelinvest.ru (8.14.3/8.14.3/Debian-9.4) with ESMTP id 697J2vJV012938
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
 Thu, 8 Oct 2026 00:02:58 +0500
Received: (from root@localhost)
 by relay.chelinvest.ru (8.14.3/8.14.3/Submit) id 697J2vQ5012937;
 Thu, 8 Oct 2026 00:02:57 +0500
Received: from ksmg2.chelinvest.ru ( ksmg2.chelinvest.ru [193.105.39.121] ) 
 by relay (Dr.Web (R) milter module ver.6.0.2.8)
 ; Wed, 07 Oct 2026 21:51:37 +0500
Received: from ksmg2.chelinvest.ru (localhost [127.0.0.1])
 by ksmg2.chelinvest.ru (Postfix) with ESMTP id 3E33D180094
 for <virus@chelinvest.ru>; Wed,  7 Oct 2026 21:44:07 +0500 (+05)
Received: from lists.sourceforge.net (unknown [216.105.38.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ksmg2.chelinvest.ru (Postfix) with ESMTPS
 for <virus@chelinvest.ru>; Wed,  7 Oct 2026 21:43:54 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=lists.sourceforge.net; s=beta;
 h=Content-Transfer-Encoding:Content-Type:
 List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
 Subject:MIME-Version:Message-ID:To:From:Date:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Owner;
 bh=a3gQ97fr8qKEqHLvvD7fiKA+hLwyPDEJU9FDTnQVSkU=;
 b=dPfGpXbUY6FkbICUGQLO45UX26
 c3w7aFv51UE1k++GMWIXm8W9VG1wOvI+QOsZ4GRjqgyYY4aRUghZgufxtAYAP4639YeZP+UlXhk/m
 Ddf0Qb+GZVfcwV5TCEjgC4oM+7/lCM57KSCuqMg5jz2D6S2Bdk09V7UL6UyHLc9QoZFE=
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
 (envelope-from <openvpn-announce-bounces@lists.sourceforge.net>)
 id 1xEUiG-0003y3-D7; Wed, 07 Oct 2026 16:41:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <frank@lichtenheld.com>) id 1xEUgn-0002Mo-BQ;
 Wed, 07 Oct 2026 16:40:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x;
 h=Content-Type:MIME-Version:Message-ID:Subject:To:
 From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=69RTuYMdUgoL85mgr0GKGOZuCJd6UHFhPUia+3G5umQ=;
 b=lY+9rwq76SD74rwHgkI38bzSg7
 eORUgSkEJupRxGckLsA8TKURDGaKJ2PWlBv3rJp63SU4Ag7AenNEUxJcaZxnLBO8Wt6YjgAChmQ96
 L8ftWYNAiCXR5c5L1Yq2/fnc7BxP6aiakowu+qIfcdHHAtWI3AvFLQStnqiAWxIoecl8=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x;
 h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive;
 bh=69RTuYMdUgoL85mgr0GKGOZuCJd6UHFhPUia+3G5umQ=; b=J
 GeSicZj94//7cpFqoqRjpDbZSMThxc6N7L3WLfyn1k+zxlf/Bp0oWriQCHTS8Tf9uJthnEwvmwtLr
 cOAONwumKu9hF7ucO2w30Uo9hravxyakWqbV8MCJIa18bjas3m+MKFn2wr58pLBUbseP1PW1+zTTT
 U8+qNrZxyXLbgzXI=
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
 UQAbhXG661OupKY+1Xu4eIOLwzyuQuFSSBWTUBZ/HC8fSNi8zKAMQiG//S1Bs8cgXMzr4z;
 qCz9DYwSWJaIKa6u4tGuc9CFsLsAowIPuurBfEMWa4yPBtFMbAFkXAoXSx6tBQ==
Authentication-Results: outgoing_mbo_mout; dkim=none; spf=pass;
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
X-Mailman-Approved-At: Wed, 07 Oct 2026 16:41:52 +0000
X-BeenThere: openvpn-announce@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
X-KSMG-AntiPhishing: NotDetected, bases: 2026/10/07 15:45:00
X-KSMG-AntiSpam-Auth: dmarc=none header.from=lichtenheld.com;
 spf=pass smtp.mailfrom=lists.sourceforge.net;
 dkim=pass header.d=lists.sourceforge.net; dkim=fail header.d=sourceforge.net;
 dkim=neutral header.d=sf.net; dkim=fail header.d=lichtenheld.com
X-KSMG-AntiSpam-Envelope-From: openvpn-announce-bounces@lists.sourceforge.net
X-KSMG-AntiSpam-Info: LuaCore: 127 0.3.127
 0884f7b061fa529b810563f359267cd65d2ec05c
X-KSMG-AntiSpam-Info: {rep_avail}
X-KSMG-AntiSpam-Info: {dkim_exist_silent}
X-KSMG-AntiSpam-Info: {Tracking_phishing_bb}
X-KSMG-AntiSpam-Info: {Tracking_cat_phish}
X-KSMG-AntiSpam-Info: {Tracking_smtp_not_equal_from}
X-KSMG-AntiSpam-Info: {Tracking_list_headers}
X-KSMG-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSMG-AntiSpam-Info: {Tracking_marketers}
X-KSMG-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSMG-AntiSpam-Info: community.openvpn.net:7.1.1; github.com:7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; lists.sourceforge.net:7.1.1,5.0.1;
 openvpn.net:7.1.1; 216.105.38.7:7.1.2; 127.0.0.199:7.1.2;
 lichtenheld.com:7.1.1
X-KSMG-AntiSpam-Info: {Tracking_smtp_domain_mismatch}
X-KSMG-AntiSpam-Info: {Tracking_smtp_domain_2level_mismatch}
X-KSMG-AntiSpam-Info: {Tracking_white_helo}
X-KSMG-AntiSpam-Info: FromAlignment: n
X-KSMG-AntiSpam-Info: ApMailHostAddress: 216.105.38.7
X-KSMG-AntiSpam-Info: {DNS response errors}
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 206508 [Oct 07 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.27
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 3.1.0.9599,
 bases: 2026/10/07 12:29:00 #28661701
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-KATA-Status: Not Scanned
X-KSMG-LinksScanning: NotDetected, bases: 2026/10/07 15:46:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 7
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7
 (relay.chelinvest.ru [127.0.0.1]); Thu, 08 Oct 2026 00:02:58 +0500 (YEKT)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7
 (relay.chelinvest.ru [193.105.39.10]); Wed, 07 Oct 2026 21:51:38 +0500 (YEKT)
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
X-Headers-End: 1xEWuw-0007G5-KU
Subject: [Openvpn-devel] [DKIM bad!] [Openvpn-announce] OpenVPN 2.7.8
 released
X-BeenThere: openvpn-devel@lists.sourceforge.net
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
Message-ID: <20261007163958.PgHMQi3QE1q7itfpydZraTYIZR1l-jYJywMd_Ou41T8@z>

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
Openvpn-announce mailing list
Openvpn-announce@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-announce


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
