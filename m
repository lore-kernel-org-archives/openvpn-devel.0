Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25BB606A32D
	for <openvpn-devel@archiver.kernel.org>; Fri,  6 Nov 2026 15:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=PaxW7PiP;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=QS0jAvH5;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=mN9PNbfd;
	dkim=neutral header.d=lichtenheld.com header.i=@lichtenheld.com header.a=rsa-sha256 header.s=MBO0001 header.b=0DP0AGk/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:To:From:Date:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=63So9oOFPBPzNkvstBJUGYmOJFl0R63j08tGuM6jIgw=; b=PaxW7PiPm8ghxrCR6RBV6sV5Ah
	aqgFVxj2hA5f25g9W1fgNCBw47THRGcJCS2mYc+pphdaiWbAngyDVMzjZXIqgfVW5QITfH6zcPGWV
	OfwJlgdzvMRqJq5p58cBpQqwCk+WZ3oDVVofehwTaNfKkAFLozOUm3XzAIgl7G4sQh8k=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPLcN-000000000Fh-1WMG;
	Fri, 06 Nov 2026 15:12:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <frank@lichtenheld.com>) id 1xPLcI-000000000FR-1Zv7;
 Fri, 06 Nov 2026 15:12:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Subject:To:
 From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/9ZVBQiKTxDGiU9jFkUVO04MFdyyd/OVTMg99CNZcas=; b=QS0jAvH58RcW5OWsuTnGNXN6we
 fmbzQ2/qxFfrhH2fiIBEljI7CRpLOVekYejEA4eTdI6daXY8lcTug+hFXdpgMJin70EymjogOmPno
 e0AwTq8e7axor8j+vk3VaPdes0jyAhOiyt0bEmAywRMLjqRaWY/4I5i+AXMux1g82WnE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/9ZVBQiKTxDGiU9jFkUVO04MFdyyd/OVTMg99CNZcas=; b=mN9PNbfdPsXP2PHbCfSHEyVuQ1
 6C3ztGMW7mbO65sMBPqI4SwRVww6bPDVOMo6xkol8Z3YlxEZ05Q09rrB0RdDF+QU506iqfgiiez9C
 MRjDc4lfvvxRhlmWg0ZikFkEmZglOHxqH7//U7101CJA7XGvcHMNKtCfCeDzkeCYK/OA=;
Received: from mout-p-202.mailbox.org ([80.241.56.172])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xPLcF-000000005lC-3td5; Fri, 06 Nov 2026 15:12:34 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jLjMq4WJHzMlJf;
 Fri, 06 Nov 2026 16:12:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lichtenheld.com;
 s=MBO0001; t=1793977943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=/9ZVBQiKTxDGiU9jFkUVO04MFdyyd/OVTMg99CNZcas=;
 b=0DP0AGk/nRm+gkzj3p35hRAIbfTvox6J60o4S6yIyDvoy7kRi2lDYJoFUpBDjEulX2xgwn
 AdqpC8kytf8L4dwwjCBZImRAomxfliFOZ4Iw54eIGXerFPxfhGn4eDUx2ao3NwW5CERNgt
 +9hATbRIfdVQ5Ze8KjpfXjHordGTuh1F3bYamb8vPva5nFRAaApfcaJZRQ2I/HvOIZY4Qy
 Z5/zTiMj36uu0tZUzyVdm9/gGuBK/4ELbeljRfwDvvk723pL/FrmcMfbUojQana1EF32/3
 QR8ZAFItGEQl6cH/WTvX3ncFVANBjMXy9NINZ0sQLGfBC1y+kME7TF6CWmW2ZQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of frank@lichtenheld.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=frank@lichtenheld.com
Date: Fri, 6 Nov 2026 16:12:21 +0100
From: Frank Lichtenheld <frank@lichtenheld.com>
To: Openvpn-announce@lists.sourceforge.net,
 Openvpn-devel@lists.sourceforge.net, Openvpn-users@lists.sourceforge.net
Message-ID: <au3uVRN74rEtJejQ@flichtenheld-TUXEDO-InfinityBook-S-15-17-Gen7>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
X-Rspamd-Queue-Id: 4jLjMq4WJHzMlJf
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xPLcF-000000005lC-3td5
Subject: [Openvpn-devel] OpenVPN 2.7.9 released
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The OpenVPN community project team is proud to release OpenVPN 2.7.9. This is a 
bugfix release fixing several security issues.

Security fixes:

* win32: restrict loading plugin dependencies (DLLs) to plugin, app and system 
  directories.
* win32: run openvpn.exe from the interactive service at "high integrity level", 
  that is, process memory of openvpn.exe and all its threads are protected from 
  tampering. Signals/Events are still permitted.
* win32: openvpnserv: strictly filter user-defined environment variables before 
  passing to openvpn.exe (CVE-2026-121720)
  (Issue found by @refiaa)
* win32: openvpnserv: make validation of openvpn command line more robust to 
  invalid-quoting attacks (CVE-2026-115342)
* win32: openvpn.exe: change parsing of commandline to use the same function that 
  the interactive service uses (CommandLineToArgvW()) (CVE-2026-115342)
  (Issues found by Heiko Hund)

Bug fixes:

* Username/Password parsing from --auth-user-pass file (or inline) left parts of 
  overlong usernames in the password field. Fix. (GH OpenVPN/openvpn#1140)
* win32: openvpnserv: fix memory leak for security descriptors
* win32: repair logging of errors in Windows tun_read_queue()
* win32: avoid accessing uninitialized structure data if GetInterfaceInfo() or 
  GetPerAdapterInfo() fail
* win32: openvpnserv: avoid double free() if GetTokenInformation() fails
* win32: openvpnserv: avoid potential format-string issue on registry defaults
* win32: openvpnserv: repair error reporting on RegGetValueA() failures inside 
  GetItfDnsServersV4()
* win32: openvpnserv: fix inet_ntop() return code check in GetItfDnsServersV6(), 
  making it ignore DHCP-provided DNS servers.
* route: repair printing of ROUTE_GATEWAY/ROUTE6_GATEWAY info - the actual gateway 
  handling was correct, just not printing anything anymore.
* config: check_file_access: fix --extra-certs access check
* win32: tun: free gc arena in windows_set_mtu() (mem leak in error path)
* route: close socket in Haiku get_default_gateway() (FD leak)
* win32: openvpnserv: skip conversion of empty domain names
* win32: cmake+mingw: don't prefix the event message DLL with lib (it was building 
  'libopenvpnservmsg.dll' instead of 'openvpnservmsg.dll')
* win32: pass the buffer size in bytes to get_openvpn_reg_value()
* PUSH_UPDATE server: free temporary options after sending message (memleak)

User-visible Changes:

* Linux: set IFF_BACKPRESSURE on Linux (if available)
  This helps the kernel tun/tap to apply proper prioritization (qdisc etc) to 
  incoming packets if userspace is slow to process them. Without the flag, the 
  kernel would just drop everything.
* Management/GUI: Optionally indicate username in >PASSWORD '<UP_TYPE>' prompts
  If an openvpn config has a username set but no password, and OpenVPN wants to 
  prompt for the password, the GUI could not see the username today and prompted for 
  both. With this change, OpenVPN sends a hint to the management interface, so a GUI 
  can pre-fill the username field, or only prompt for the password.
  This is only done if the management interface client announces support for it 
  (compatibility level >= 6).

Code improvements/general hardening:

* crypto_epoch: wipe key material with secure_memzero()
* do not look up "none" cipher in OpenSSL - this avoids leaving an "error" on the 
  OpenSSL error stack, which can then later lead to spurious SSL error prints on CRL 
  loading.
* Make CRL reload EOF detection independent of stale error queue entries (GH: 
  OpenVPN/openvpn#1104)
* tls_crypt: fix handling of "cipher final output" (which is always empty on today's 
  SSL libraries, so no impact today, but might not be in future)
* crypto: ASSERT() opt before first use in openvpn_decrypt_aead()
* auth_token: wipe the server secret key after loading it
* port-share: do not write journal file through symlinks or hardlinks (and also 
  document how port-share directory should be set up) (GH OpenVPN/openvpn#1124)
* dns-updown: close first pipe if creating the second one fails (avoid leaking file 
  descriptors on error)
* init: check parameters for NULL before strlen() in send_cc_message (not 
  triggerable today)
* crypto_openssl: Clear PEM decoded key data before freeing it
* Increase the buffer size for alert-message in management user-pass query (so long 
  usernames can be hinted towards the GUI)
* win32: openvpnserv: validate message size for dns/nrpt/wins handlers (GH: 
  OpenVPN/openvpn#1129)
* win32: plugin: detect too long plugin paths on Windows
* win32: openvpnserv: null-terminate iface.name in address and route handlers
  (GH: OpenVPN/openvpn#1130)

Documentation improvements:

* Fix numbering of examples in management-notes.txt
* Document "notify" as auth pending method
* Convert Changes.rst to Markdown (2.7)

Long-term code maintenance:

* OpenSSL 4.1 compatibility: use ASN1_STRING_get_length() now, providing a fallback 
  to ASN1_STRING_length() for older SSL libraries.
* Linux: sitnl: use RTM_SETLINK for updating existing interfaces (instead of 
  RTM_NEWLINK)
* gen-sample-keys.sh: Don't apply server extensions to CSRs
* review all usages of strncpy() (change to strncpynt(), memcpy(), etc. where 
  appropriate)

Windows MSI changes since 2.7.8-I001:

* Improve setting ACLs for non-"Program Files" installation directories.
  There were some configurations where the intended ACLs were not applied.
  (GH: OpenVPN/openvpn-build#1520)
  (Issue found by @refiaa)
* Update included openvpn-gui to 11.67
  * Support username indication in communication with OpenVPN (see above). Prefills 
     the username in prompt to user. (GH: OpenVPN/openvpn-gui#719)
  * Fix tray tooltip and popup positioning on non-primary monitors (GH: 
     OpenVPN/openvpn-gui#836)
  * Improve Swedish translation (GH: OpenVPN/openvpn-gui#828)

More details can be found in the Changes document:

<https://github.com/OpenVPN/openvpn/blob/v2.7.9/Changes.md>

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
