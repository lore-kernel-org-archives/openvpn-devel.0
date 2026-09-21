Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A229DC982ED
	for <openvpn-devel@archiver.kernel.org>; Mon, 21 Sep 2026 13:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=33+WKALIHey+9NTWQPfSM8gghAUMUZr2jToA99A+4Bg=; b=QaDk5176gLvXPmETb0UTcW64zf
	nUKPA5gWSLDGzjJtrebD0hO18l7x2rPFlsiDa/vUXyUnjdcKNh58BKWePB8fQOmM1NcHq2sZ4VrNK
	gfQRJINSzjA53VNLkEW3CBK6XkSqFHT+NyHLz3XvODwa2pRsFJmcfNN16ytQkgYvktR0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x8eHo-0005vE-Hy;
	Mon, 21 Sep 2026 13:42:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <frank@lichtenheld.com>) id 1x8eHm-0005v6-5R
 for openvpn-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 13:42:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=x3vE5kky+PbQxIPpsKQjt1gkt/FmC4EOeMTm4GRVk4U=; b=BLH0wB2gwtsIIDAFxbW0W9eZoA
 1M0NW8ZCqQq4E4ttBBTOxfa3j+thtaH+aXaQYnONAjmK4C3IiE+ucPlZ4LsJ5MT++14iItmMO39R5
 zBnj4wRyBJ0yfcanP3m3FjeldK1GxNz5NQxEOtamleBr3ciV0ENa7163a4mxR5Q3XUj8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=x3vE5kky+PbQxIPpsKQjt1gkt/FmC4EOeMTm4GRVk4U=; b=A
 8MyGzApC4WsJHrJ4/VBFsgcWhkrXTYE2FdLm+PGseHwVwz9GxrJIm3zC6eDttQjHK/6Cr8ml1euYp
 bvgHiLfcE7+9ffaa0NQi2AVrt0ZY3YpIHJEwtOYGHcN0uG8sCSRcfV/xKX9oLMgwawqmUAjsXyQ1o
 cNQX3z93kR6kSjoY=;
Received: from mout-p-102.mailbox.org ([80.241.56.152])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x8eHi-0007oy-9t for openvpn-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 13:42:19 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hpPXy3lhrzKmRL;
 Mon, 21 Sep 2026 15:42:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lichtenheld.com;
 s=MBO0001; t=1789998130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=x3vE5kky+PbQxIPpsKQjt1gkt/FmC4EOeMTm4GRVk4U=;
 b=RDgDQxSJ70n/IMEwCpy3nUuhduflPRNcFwG4fp9EtpoTL/qZ0PvdEseCXmcaDhNfmpYRsJ
 xJTqJex6+jDrp0fmgClnQVnETszBueyRNX0lRZENDjylc0IDvmKtWQGcCcaq3YSpjP47Hv
 3I6Xcnt6lmeYZ2tA3hwfuE26YkRl0wcVJmih8IbjHxfzxRraczl3xd43MnFFLYYNdvVkgN
 UXMcmVSfLMQ/OAli6yfC19es4uJ1tH3iK/g6d9AuiBxoBBpjQ9lG6ZqEwwRbTAkiiX42LU
 YcGDc9VFtaHWm7eFJZtGQi8YKdfR0EdWgeQeU9QhKlfZCSFazYbgwKI9KCT98g==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of frank@lichtenheld.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=frank@lichtenheld.com
From: Frank Lichtenheld <frank@lichtenheld.com>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 21 Sep 2026 15:42:08 +0200
Message-ID: <20260921134208.54064-1-frank@lichtenheld.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4hpPXy3lhrzKmRL
X-Headers-End: 1x8eHi-0007oy-9t
Subject: [Openvpn-devel] [PATCH] doc: document optional message parameter
 for management command client-kill
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
Cc: Sarvagya Chaturvedi <sarvagya0624@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

From: Sarvagya Chaturvedi <sarvagya0624@gmail.com>

The client-kill command in the management interface accepts an optional
message parameter (M), which is sent to the client as a control channel
command before terminating the session on the server.

Document the syntax of client-kill, the message format (RESTART or HALT
with optional flags [P] and [N] and human-readable message), and the
resulting notifications emitted on the client management interface.

Github: OpenVPN/openvpn#1096
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Change-Id: Ied848552f6e9618ca6541d74e20aa1d340027999
Signed-off-by: Sarvagya Chaturvedi <sarvagya0624@gmail.com>
---
 doc/management-notes.txt | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index 11264684..412b79bc 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -828,11 +828,36 @@ COMMAND -- client-kill  (OpenVPN 2.1 or higher)
 
 Immediately kill a client instance by CID.
 
-  client-kill {CID}
+  client-kill {CID} [M]
 
 CID -- client ID.  See documentation for ">CLIENT:" notification for more
 info.
 
+M -- optional message to send to the client before termination
+(defaults to "RESTART"). The format of M is:
+
+  RESTART|HALT[,[flags][human-readable-message]]
+
+RESTART instructs the client to perform a restart (SIGUSR1).
+HALT instructs the client to exit (SIGTERM).
+
+Optional flags in brackets:
+- [P] -- preserve cached passwords and credentials on client (avoids purging auth).
+- [N] -- advance to the next remote server entry in client configuration.
+
+If a human-readable message string is included after the comma, it is
+logged by the client and forwarded to the client's management interface
+via a ">NOTIFY:" event:
+
+  >NOTIFY:info,server-pushed-connection-reset,<msg>  (for RESTART)
+  >NOTIFY:info,server-pushed-halt,<msg>              (for HALT)
+
+If the message parameter contains spaces, it should be enclosed in double
+quotes, for example:
+
+  client-kill 1 "HALT,Server shutting down for maintenance"
+  client-kill 1 "RESTART,[P]Reconnecting to update configuration"
+
 COMMAND -- remote-entry-count (OpenVPN 2.6+ management version > 3)
 -------------------------------------------------------------------
 
-- 
2.43.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
