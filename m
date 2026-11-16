Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4959E606A32F
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=JMQArlwL;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=B2ls4H+v;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=e/fKXO6C
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=un2tyd6UVVPyBKnKLIYFdehKcYS+579D/DGvDC+tmOw=; b=JMQArlwL2SC9DC
	y1RE8ldPSE1LsvdDcvWXp88oHY6KFifwNSk8OyPLkKATukxdEpQnE8kIRsG7xsaenbrkWtSg3fZU1
	SKAOZ9lKn5z6NHMM8qHP3AqmNm5Xd6rScmcjHftnKEh5F28bm0ifMLQUD+BS8y9ZmHLyJcq0Vw04z
	c8s=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xStQk-000000003PT-2tay;
	Mon, 16 Nov 2026 09:55:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xStQj-000000003Mi-125r for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 09:55:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ka7X5xs6BYHVxU31rnjmMnure7eChS5O5xDGc6gxzzs=; b=B2ls4H+vuvbw2YR49Wfr6+2qmG
 kjRLIjAQNY/Vx6I264a2lGuWLSLi64QUtk0ZtKVOZUX7DPHVHftezSP5PpDYkSueS7Xrs4DkrtxhP
 0eLTnJ4f3cp3+NN1+Q4qvN/qpu/hEFQx2PUAjItkrjjH4+TXH0HLhbll4w478WG7S5Sk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ka7X5xs6BYHVxU31rnjmMnure7eChS5O5xDGc6gxzzs=; b=e/fKXO6CnMCpsFfgZngTKe0kCh
 o98cRncvckgWrqbYjqOEm2GLqi5KFwiiHB+w+8zxfuLUfh2/DCfxMrqJik2fpqFPvBgtLS2OjxdqH
 eHH6i2fHw7gZjO+hwfRWEad5Ae4rF1IjrRl55WMityKJKlT2Hc11rlIDxn53hmbU15uI=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xStQD-000000002MI-0qT3 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 09:54:46 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AG9sctO011299
 for <openvpn-devel@lists.sourceforge.net>; Mon, 16 Nov 2026 10:54:38 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AG9scqu011298
 for openvpn-devel@lists.sourceforge.net; Mon, 16 Nov 2026 10:54:38 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 16 Nov 2026 10:54:32 +0100
Message-ID: <20261116095438.11288-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794757486000.Icb79564ae4e0df1dcdd4a3734bd45f9513f56111@gerrit.openvpn.net>
References: <gerrit.1794757486000.Icb79564ae4e0df1dcdd4a3734bd45f9513f56111@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xStQD-000000002MI-0qT3
Subject: [Openvpn-devel] [PATCH v1] contrib,
 sample: drop SysV-era init scripts
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
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Razvan Cojocaru <razvanc@mailbox.org>

multilevel-init.patch patches the init script removed in 57ec6cec
("cleanup: Remove RPM openvpn.spec build approach").
openvpn-startup.sh and openvpn-shutdown.sh are superseded by the
systemd units in distro/systemd.

Change-Id: Icb79564ae4e0df1dcdd4a3734bd45f9513f56111
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2186
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2186
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/contrib/multilevel-init.patch b/contrib/multilevel-init.patch
deleted file mode 100644
index 8d48fbc..0000000
--- a/contrib/multilevel-init.patch
+++ /dev/null
@@ -1,79 +0,0 @@
---- /etc/init.d/openvpn	2004-05-12 20:30:06.000000000 +0200
-+++ openvpn	2004-05-12 20:34:33.000000000 +0200
-@@ -58,13 +58,13 @@
- #     returning success or failure status to caller (James Yonan).
- 
- # Location of openvpn binary
--openvpn="/usr/sbin/openvpn"
-+openvpn=/usr/sbin/openvpn
- 
- # Lockfile
--lock="/var/lock/subsys/openvpn"
-+lock=/var/lock/subsys/openvpn
- 
- # PID directory
--piddir="/var/run/openvpn"
-+piddir=/var/run/openvpn
- 
- # Our working directory
- work=/etc/openvpn
-@@ -106,7 +106,7 @@
- 
- 	if [ -f $lock ]; then
- 	    # we were not shut down correctly
--	    for pidf in `/bin/ls $piddir/*.pid $piddir/*/*.pid 2>/dev/null`; do
-+	    for pidf in `find $piddir -name "*.pid" 2>/dev/null`; do
- 	      if [ -s $pidf ]; then
- 		kill `cat $pidf` >/dev/null 2>&1
- 	      fi
-@@ -116,12 +116,12 @@
- 	    sleep 2
- 	fi
- 
--	rm -f $piddir/*.pid $piddir/*/*.pid
-+	find $piddir -name "*.pid"|xargs rm -f
- 
- 	# Start every .conf in $work and run .sh if exists
- 	errors=0
- 	successes=0
--	for c in `/bin/ls *.conf */*.conf 2>/dev/null`; do
-+	for c in `find * -name "*.conf" 2>/dev/null`; do
- 	    bn=${c%%.conf}
- 	    if [ -f "$bn.sh" ]; then
- 		. $bn.sh
-@@ -147,7 +147,7 @@
- 	;;
-   stop)
- 	echo -n $"Shutting down openvpn: "
--	for pidf in `/bin/ls $piddir/*.pid $piddir/*/*.pid 2>/dev/null`; do
-+	for pidf in `find $piddir -name "*.pid" 2>/dev/null`; do
- 	  if [ -s $pidf ]; then
- 	    kill `cat $pidf` >/dev/null 2>&1
- 	  fi
-@@ -163,7 +163,7 @@
- 	;;
-   reload)
- 	if [ -f $lock ]; then
--	    for pidf in `/bin/ls $piddir/*.pid $piddir/*/*.pid 2>/dev/null`; do
-+	    for pidf in `find $piddir -name "*.pid" 2>/dev/null`; do
- 		if [ -s $pidf ]; then
- 		    kill -HUP `cat $pidf` >/dev/null 2>&1
- 		fi
-@@ -175,7 +175,7 @@
- 	;;
-   reopen)
- 	if [ -f $lock ]; then
--	    for pidf in `/bin/ls $piddir/*.pid $piddir/*/*.pid 2>/dev/null`; do
-+	    for pidf in `find $piddir -name "*.pid" 2>/dev/null`; do
- 		if [ -s $pidf ]; then
- 		    kill -USR1 `cat $pidf` >/dev/null 2>&1
- 		fi
-@@ -195,7 +195,7 @@
- 	;;
-   status)
- 	if [ -f $lock ]; then
--	    for pidf in `/bin/ls $piddir/*.pid $piddir/*/*.pid 2>/dev/null`; do
-+	    for pidf in `find $piddir -name "*.pid" 2>/dev/null`; do
- 		if [ -s $pidf ]; then
- 		    kill -USR2 `cat $pidf` >/dev/null 2>&1
- 		fi
diff --git a/sample/sample-config-files/openvpn-shutdown.sh b/sample/sample-config-files/openvpn-shutdown.sh
deleted file mode 100755
index 8ed2d1d..0000000
--- a/sample/sample-config-files/openvpn-shutdown.sh
+++ /dev/null
@@ -1,5 +0,0 @@
-#!/bin/sh
-
-# stop all openvpn processes
-
-killall -TERM openvpn
diff --git a/sample/sample-config-files/openvpn-startup.sh b/sample/sample-config-files/openvpn-startup.sh
deleted file mode 100755
index 0ee006b..0000000
--- a/sample/sample-config-files/openvpn-startup.sh
+++ /dev/null
@@ -1,34 +0,0 @@
-#!/bin/sh
-
-# A sample OpenVPN startup script
-# for Linux.
-
-# openvpn config file directory
-dir=/etc/openvpn
-
-# load the firewall
-$dir/firewall.sh
-
-# load TUN/TAP kernel module
-modprobe tun
-
-# enable IP forwarding
-echo 1 > /proc/sys/net/ipv4/ip_forward
-
-# Invoke openvpn for each VPN tunnel
-# in daemon mode.  Alternatively,
-# you could remove "--daemon" from
-# the command line and add "daemon"
-# to the config file.
-#
-# Each tunnel should run on a separate
-# UDP port.  Use the "port" option
-# to control this.  Like all of
-# OpenVPN's options, you can
-# specify "--port 8000" on the command
-# line or "port 8000" in the config
-# file.
-
-openvpn --cd $dir --daemon --config vpn1.conf
-openvpn --cd $dir --daemon --config vpn2.conf
-openvpn --cd $dir --daemon --config vpn2.conf


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
