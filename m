Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE389606A334
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 12:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=hGvISTml;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ko8tnmhl;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=E7nvI1Rx;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ZTz4BAY9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=lPmwdCOx0uk7/EnB3DG3oXZFyGBSQP0C6vijZKvhWyw=; b=hGvISTmlH6F4sG23eeaJK0Q0W2
	2AS6LshAQQoWnCw0KJ3ftViWMbNlUGOYN+MOjau0AjgOz6eT9gFpBPLnYntC8pgYwPKaLB4GdT8Zz
	8JwCh9/Dj+J5zQtLAgG30EFBI7wTWWv80iUc9U9dMAiIBwllEiaNaxKK8QpFG8FJNH5s=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSvoR-000000007Vw-1fvh;
	Mon, 16 Nov 2026 12:27:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSvoP-000000007Vp-3z0O
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 12:27:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=agKqQHDoGVfP6ewnpU2o8UeAMM9vYwneQR8pNMPjAQw=; b=ko8tnmhlqaGZRb2UYTwXWtldty
 6FuyZOs6fodAIyYaw+wfHhzdBmVKhjvLZ3zMKpH9qDQ77hjFjrGf3x/9YekWUwLYJUVI/2qJPpB8u
 Iu1S3KFO4JtifPMUpIlnEqpC9Gr92cK+5N6aKfBKC8rEtJlSl58HuXV4iR9YvyKWIoN0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=agKqQHDoGVfP6ewnpU2o8UeAMM9vYwneQR8pNMPjAQw=; b=E7nvI1RxiLs0icOg3APs+dzjSN
 byBeSJIlgUMaWq/J0ffjNMj+z4NFsEERXfDymQn8nbxiyTImAt/uTn/lTMvyFNcW+rGFsECkSZ2dJ
 kiMRZbpsNcR02Bg8vDQixcyBPrcOI9jSxlPzoPxkKjHHAGPTqzfRcCpShz5v+NwKt+H4=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSvoJ-000000005us-0ECA for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 12:27:53 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so34996295e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 04:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794832060; x=1795436860; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=agKqQHDoGVfP6ewnpU2o8UeAMM9vYwneQR8pNMPjAQw=;
 b=ZTz4BAY9tmn9bIhy5v8+JzTAACINaPMFc/np+0ZPj2d5qb94zxglq7ofpiZYb+tygX
 VZuo49OJjzjufOSYLA3lxAjydQ7h+OJbYrY8pzKoSeJWfdXWjEMfvsracDsqM7khritl
 +RsoAIVG82ZIzLFTQH660DpkY9VYJGtLJnAEqRn3JD3zer+1xMMe3nBZ4juH+Fer8Lmx
 o4ZUk6kwC7BHfg9HHajCvtwgDFZ1f/C2TCZiCws7tJTuekicUJt+qivNO42IQxQRAjzu
 VTheGEehIg0OogWP/1Tug/1lmkfk+OfH+fI0DMUlQ1jCm4Mazap20tOQcUUimX1BwGP7
 uRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794832060; x=1795436860;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=agKqQHDoGVfP6ewnpU2o8UeAMM9vYwneQR8pNMPjAQw=;
 b=j+ucQC9wxWhWHslA9XkMcTE9JPHLHf1/gEFzQVywlygklOQDj4aDdklhp9tXcdEAI2
 jL0JY2/jgoudk+FZ0d+JqfsD21WUcq8WHoYRsXf6Rvuno+gMSLpfUezxkDT3ygNobJKu
 WpDvFNO6moh9JHYoAqcH2I52sP8Vl+bkuf+WCcFAQ59IySyqTGeLMSw/PuOhdu0Yl7C0
 Cc6rQafGhawey81UFKHN3dM0D/Gne0HwKtSA1hSR4K6AjZ1+zLHQlNfoJHuz+he/G+iK
 sowOg0Wo6YH79UicaqMfPwQN0hglKVhT7n25kGR5jSQdh/FS2/ONk23IQsiogeeB6cI7
 TE4g==
X-Gm-Message-State: APuU4Z/dXaPGzmMAUZRRvsnibvdhoADLfaDRF59ItmL4Ux3qffboBO3B
 Haj18GIGmpxHyE7o02TVr1I1ebUT7jEXnTuw4Pl3DYaHeNE9bNXZfoonftibg/Im7nVwrhAytgD
 //g+JeMCFMWKKBQbhd8EoZlsMdIPXQ5RdNzc7sFsmPOxHFcTVpeL4CB2kiK3p456khKCL
X-Gm-Gg: AYBFou1E1HHVJ0JFwq/mTr/8n67wrUG9t8DbHUWMANF0L7PMflUyF9brUlKqyGXnSLW
 +apARC+w5crzeKtau3INGunM2l8Hf90kPRxWRwog3Rqa54amUs6/YEnN6D90gGYWC+Lgr8yuJ4C
 na5/ttsvpSFNYs07z7ELm/WoKj/4nuENSVn+XjN4Ud9vFszzmYDPAV5KOsXNikTMR1DM6AX9BXP
 8eDbZpDPULfBnpYB1285yGVtercHX98erMHL4vQCNHGF+NSaEvIzrN6G66soUfq89WkdHO7nRAg
 PhP3Iai0o1a0U1hgOd/pOE5uaObyuXJ5eejJztNiyAvYfwTs4DV2Ky96Q3RKlzAQ5hTpskA6W80
 aKqZwk/UI6QzeyzsJJ8JH5WLQfDRMULsbxxyOfl9OiGhoB/SYmGz2dhx+ypg+GXrWUxE+UxT3wx
 pxoEz1qHlB9IAkCZyv3YH5CA3sRrR8taIxraxjetj3FZsQqApIoR2sn2ciVtuL3/B+8iXbCukBS
 f8VMghF0/FGwAV6ZYW7q0/zHogSNoWpNJgOPp/i2W0gumczipiTAB/4CSMFktfzqgIa13oSnLex
 AYUF7oJq3kB4Qf5LF4LQJIoWe/pt4uBNeglBPK5ERKg5i89lL6mUxKaa11vjpvcpsDnIEFy5y86
 BCkC7Poat1NSRoschujPoBI7EzNLrlrozx3i8KJiBzXqwqck0uZoYu2RAlNtfnDmiGyjLjkY5v2
 JUM/LJWKBuPTip55o=
X-Received: by 2002:a05:600c:3b16:b0:4a2:1960:6fa with SMTP id
 5b1f17b1804b1-4bb55a6116bmr226675525e9.4.1794832060127; 
 Mon, 16 Nov 2026 04:27:40 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55ae5299sm303947935e9.11.2026.11.16.04.27.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 04:27:39 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 12:27:37 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Icb79564ae4e0df1dcdd4a3734bd45f9513f56111
X-Gerrit-Change-Number: 2186
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2186?usp=email>
X-Gerrit-Commit: b0668301ed71e90dfed96c4e5bfafdbe2000ed93
In-Reply-To: <gerrit.1794757486000.Icb79564ae4e0df1dcdd4a3734bd45f9513f56111@gerrit.openvpn.net>
References: <gerrit.1794757486000.Icb79564ae4e0df1dcdd4a3734bd45f9513f56111@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0NzU3NDg2MDAwLkljYjc5NTY0YWU0ZTBkZjFkY2RkNGEzNzM0YmQ0NWY5NTEzZjU2MTExQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f536c0bbd5efae3d719c2a68662906876aba8bd3-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSvoJ-000000005us-0ECA
Subject: [Openvpn-devel] [M] Change in openvpn[master]: contrib,
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2497630131482307184=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2497630131482307184==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PihZZ/R7FdQ="; charset=UTF-8

--PihZZ/R7FdQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2186?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Gert Doering


Change subject: contrib, sample: drop Sys=
V-era init scripts
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

contrib, sample: drop SysV-era init scripts

multilevel-init=2Epatc=
h patches the init script removed in 57ec6cec
("cleanup: Remove RPM openvpn=
=2Espec build approach")=2E
openvpn-startup=2Esh and openvpn-shutdown=2Esh =
are superseded by the
systemd units in distro/systemd=2E

Change-Id: Icb795=
64ae4e0df1dcdd4a3734bd45f9513f56111
Signed-off-by: Razvan Cojocaru <razvanc=
@mailbox=2Eorg>
Acked-by: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL=
: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2186
Message-Id: <202611160954=
38=2E11288-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom=
/openvpn-devel@lists=2Esourceforge=2Enet/msg41407=2Ehtml
Signed-off-by: Ger=
t Doering <gert@greenie=2Emuc=2Ede>
---
D contrib/multilevel-init=2Epatch
D=
 sample/sample-config-files/openvpn-shutdown=2Esh
D sample/sample-config-fi=
les/openvpn-startup=2Esh
3 files changed, 0 insertions(+), 118 deletions(-)=



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/86/21=
86/2

diff --git a/contrib/multilevel-init=2Epatch b/contrib/multilevel-ini=
t=2Epatch
deleted file mode 100644
index 8d48fbc=2E=2E0000000
--- a/contrib=
/multilevel-init=2Epatch
+++ /dev/null
@@ -1,79 +0,0 @@
---- /etc/init=2Ed/=
openvpn	2004-05-12 20:30:06=2E000000000 +0200
-+++ openvpn	2004-05-12 20:34=
:33=2E000000000 +0200
-@@ -58,13 +58,13 @@
- #     returning success or fai=
lure status to caller (James Yonan)=2E
- 
- # Location of openvpn binary
--=
openvpn=3D"/usr/sbin/openvpn"
-+openvpn=3D/usr/sbin/openvpn
- 
- # Lockfile=

--lock=3D"/var/lock/subsys/openvpn"
-+lock=3D/var/lock/subsys/openvpn
- 
-=
 # PID directory
--piddir=3D"/var/run/openvpn"
-+piddir=3D/var/run/openvpn
=
- 
- # Our working directory
- work=3D/etc/openvpn
-@@ -106,7 +106,7 @@
- 
=
- 	if [ -f $lock ]; then
- 	    # we were not shut down correctly
--	    fo=
r pidf in `/bin/ls $piddir/*=2Epid $piddir/*/*=2Epid 2>/dev/null`; do
-+	  =
  for pidf in `find $piddir -name "*=2Epid" 2>/dev/null`; do
- 	      if [ =
-s $pidf ]; then
- 		kill `cat $pidf` >/dev/null 2>&1
- 	      fi
-@@ -116,=
12 +116,12 @@
- 	    sleep 2
- 	fi
- 
--	rm -f $piddir/*=2Epid $piddir/*/*=
=2Epid
-+	find $piddir -name "*=2Epid"|xargs rm -f
- 
- 	# Start every =2Ec=
onf in $work and run =2Esh if exists
- 	errors=3D0
- 	successes=3D0
--	for =
c in `/bin/ls *=2Econf */*=2Econf 2>/dev/null`; do
-+	for c in `find * -nam=
e "*=2Econf" 2>/dev/null`; do
- 	    bn=3D${c%%=2Econf}
- 	    if [ -f "$bn=
=2Esh" ]; then
- 		=2E $bn=2Esh
-@@ -147,7 +147,7 @@
- 	;;
-   stop)
- 	ech=
o -n $"Shutting down openvpn: "
--	for pidf in `/bin/ls $piddir/*=2Epid $pi=
ddir/*/*=2Epid 2>/dev/null`; do
-+	for pidf in `find $piddir -name "*=2Epid=
" 2>/dev/null`; do
- 	  if [ -s $pidf ]; then
- 	    kill `cat $pidf` >/dev=
/null 2>&1
- 	  fi
-@@ -163,7 +163,7 @@
- 	;;
-   reload)
- 	if [ -f $lock =
]; then
--	    for pidf in `/bin/ls $piddir/*=2Epid $piddir/*/*=2Epid 2>/de=
v/null`; do
-+	    for pidf in `find $piddir -name "*=2Epid" 2>/dev/null`; =
do
- 		if [ -s $pidf ]; then
- 		    kill -HUP `cat $pidf` >/dev/null 2>&1
=
- 		fi
-@@ -175,7 +175,7 @@
- 	;;
-   reopen)
- 	if [ -f $lock ]; then
--	 =
   for pidf in `/bin/ls $piddir/*=2Epid $piddir/*/*=2Epid 2>/dev/null`; do
=
-+	    for pidf in `find $piddir -name "*=2Epid" 2>/dev/null`; do
- 		if [ =
-s $pidf ]; then
- 		    kill -USR1 `cat $pidf` >/dev/null 2>&1
- 		fi
-@@ =
-195,7 +195,7 @@
- 	;;
-   status)
- 	if [ -f $lock ]; then
--	    for pidf=
 in `/bin/ls $piddir/*=2Epid $piddir/*/*=2Epid 2>/dev/null`; do
-+	    for =
pidf in `find $piddir -name "*=2Epid" 2>/dev/null`; do
- 		if [ -s $pidf ];=
 then
- 		    kill -USR2 `cat $pidf` >/dev/null 2>&1
- 		fi
diff --git a/sa=
mple/sample-config-files/openvpn-shutdown=2Esh b/sample/sample-config-files=
/openvpn-shutdown=2Esh
deleted file mode 100755
index 8ed2d1d=2E=2E0000000
=
--- a/sample/sample-config-files/openvpn-shutdown=2Esh
+++ /dev/null
@@ -1,=
5 +0,0 @@
-#!/bin/sh
-
-# stop all openvpn processes
-
-killall -TERM openv=
pn
diff --git a/sample/sample-config-files/openvpn-startup=2Esh b/sample/sa=
mple-config-files/openvpn-startup=2Esh
deleted file mode 100755
index 0ee00=
6b=2E=2E0000000
--- a/sample/sample-config-files/openvpn-startup=2Esh
+++ /=
dev/null
@@ -1,34 +0,0 @@
-#!/bin/sh
-
-# A sample OpenVPN startup script
-=
# for Linux=2E
-
-# openvpn config file directory
-dir=3D/etc/openvpn
-
-# =
load the firewall
-$dir/firewall=2Esh
-
-# load TUN/TAP kernel module
-modp=
robe tun
-
-# enable IP forwarding
-echo 1 > /proc/sys/net/ipv4/ip_forward
=
-
-# Invoke openvpn for each VPN tunnel
-# in daemon mode=2E  Alternatively=
,
-# you could remove "--daemon" from
-# the command line and add "daemon"
=
-# to the config file=2E
-#
-# Each tunnel should run on a separate
-# UDP =
port=2E  Use the "port" option
-# to control this=2E  Like all of
-# OpenVP=
N's options, you can
-# specify "--port 8000" on the command
-# line or "po=
rt 8000" in the config
-# file=2E
-
-openvpn --cd $dir --daemon --config vp=
n1=2Econf
-openvpn --cd $dir --daemon --config vpn2=2Econf
-openvpn --cd $d=
ir --daemon --config vpn2=2Econf

-- 
To view, visit https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2186?usp=3Demail
To unsubscribe, or for help writing m=
ail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ger=
rit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
=
Gerrit-Change-Id: Icb79564ae4e0df1dcdd4a3734bd45f9513f56111
Gerrit-Change-N=
umber: 2186
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@=
mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
G=
errit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>

--PihZZ/R7FdQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2186?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Gert Doering</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">con=
trib, sample: drop SysV-era init scripts<br><br>multilevel-init=2Epatch pat=
ches the init script removed in 57ec6cec<br>(&quot;cleanup: Remove RPM open=
vpn=2Espec build approach&quot;)=2E<br>openvpn-startup=2Esh and openvpn-shu=
tdown=2Esh are superseded by the<br>systemd units in distro/systemd=2E<br><=
br>Change-Id: Icb79564ae4e0df1dcdd4a3734bd45f9513f56111<br>Signed-off-by: R=
azvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Gert Doering &lt;=
gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2186<br>Message-Id: &lt;20261116095438=2E11288-1-gert@greenie=2E=
muc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg41407=2Ehtml<br>Signed-off-by: Gert Doering &lt;ger=
t@greenie=2Emuc=2Ede&gt;<br>---<br>D contrib/multilevel-init=2Epatch<br>D s=
ample/sample-config-files/openvpn-shutdown=2Esh<br>D sample/sample-config-f=
iles/openvpn-startup=2Esh<br>3 files changed, 0 insertions(+), 118 deletion=
s(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418=
/openvpn refs/changes/86/2186/2</pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/contrib/multilevel-ini=
t=2Epatch b/contrib/multilevel-init=2Epatch</span><br><span>deleted file mo=
de 100644</span><br><span>index 8d48fbc=2E=2E0000000</span><br><span>--- a/=
contrib/multilevel-init=2Epatch</span><br><span>+++ /dev/null</span><br><sp=
an>@@ -1,79 +0,0 @@</span><br><span>---- /etc/init=2Ed/openvpn	2004-05-12 2=
0:30:06=2E000000000 +0200</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-+++ openvpn	2004-05-12 20:34:33=2E000000000 +0200</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-@@ -58,13 +58,13 @@</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- #     returning success or failure status =
to caller (James Yonan)=2E</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- </span><br><span style=3D"color: hsl(0, 100%, 40%);">- # Location of =
openvpn binary</span><br><span style=3D"color: hsl(0, 100%, 40%);">--openvp=
n=3D&quot;/usr/sbin/openvpn&quot;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-+openvpn=3D/usr/sbin/openvpn</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
# Lockfile</span><br><span style=3D"color: hsl(0, 100%, 40%);">--lock=3D&qu=
ot;/var/lock/subsys/openvpn&quot;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-+lock=3D/var/lock/subsys/openvpn</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- # PID directory</span><br><span style=3D"color: hsl(0, 100%, 40%);">--p=
iddir=3D&quot;/var/run/openvpn&quot;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-+piddir=3D/var/run/openvpn</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 # Our working directory</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- work=3D/etc/openvpn</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-@@ -106,7 +106,7 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">- 	if [ -f $lock ]; t=
hen</span><br><span style=3D"color: hsl(0, 100%, 40%);">- 	    # we were no=
t shut down correctly</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
-	    for pidf in `/bin/ls $piddir/*=2Epid $piddir/*/*=2Epid 2&gt;/dev/null=
`; do</span><br><span style=3D"color: hsl(0, 100%, 40%);">-+	    for pidf i=
n `find $piddir -name &quot;*=2Epid&quot; 2&gt;/dev/null`; do</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- 	      if [ -s $pidf ]; then</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- 		kill `cat $pidf` &gt;/de=
v/null 2&gt;&amp;1</span><br><span style=3D"color: hsl(0, 100%, 40%);">- 	 =
     fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-@@ -116,12 +11=
6,12 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);">- 	    sleep 2<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- 	fi</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">--	rm -f $piddir/*=2Epid $piddir/*/*=2Epid</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-+	find $piddir -name &quot;*=2Epid&quot=
;|xargs rm -f</span><br><span style=3D"color: hsl(0, 100%, 40%);">- </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- 	# Start every =2Econf in $=
work and run =2Esh if exists</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- 	errors=3D0</span><br><span style=3D"color: hsl(0, 100%, 40%);">- 	=
successes=3D0</span><br><span style=3D"color: hsl(0, 100%, 40%);">--	for c =
in `/bin/ls *=2Econf */*=2Econf 2&gt;/dev/null`; do</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-+	for c in `find * -name &quot;*=2Econf&quo=
t; 2&gt;/dev/null`; do</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- 	    bn=3D${c%%=2Econf}</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- 	    if [ -f &quot;$bn=2Esh&quot; ]; then</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- 		=2E $bn=2Esh</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-@@ -147,7 +147,7 @@</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- 	;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
   stop)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- 	echo -n $&q=
uot;Shutting down openvpn: &quot;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">--	for pidf in `/bin/ls $piddir/*=2Epid $piddir/*/*=2Epid 2&gt;/=
dev/null`; do</span><br><span style=3D"color: hsl(0, 100%, 40%);">-+	for pi=
df in `find $piddir -name &quot;*=2Epid&quot; 2&gt;/dev/null`; do</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- 	  if [ -s $pidf ]; then</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- 	    kill `cat $pidf` &gt;=
/dev/null 2&gt;&amp;1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 	  fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-@@ -163,7 +163,=
7 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);">- 	;;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-   reload)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- 	if [ -f $lock ]; then</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">--	    for pidf in `/bin/ls $piddir/*=2Epi=
d $piddir/*/*=2Epid 2&gt;/dev/null`; do</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-+	    for pidf in `find $piddir -name &quot;*=2Epid&quot;=
 2&gt;/dev/null`; do</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
		if [ -s $pidf ]; then</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- 		    kill -HUP `cat $pidf` &gt;/dev/null 2&gt;&amp;1</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- 		fi</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-@@ -175,7 +175,7 @@</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- 	;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
   reopen)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- 	if [ -f $=
lock ]; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">--	    for=
 pidf in `/bin/ls $piddir/*=2Epid $piddir/*/*=2Epid 2&gt;/dev/null`; do</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-+	    for pidf in `find $=
piddir -name &quot;*=2Epid&quot; 2&gt;/dev/null`; do</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- 		if [ -s $pidf ]; then</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- 		    kill -USR1 `cat $pidf` &gt;/dev/n=
ull 2&gt;&amp;1</span><br><span style=3D"color: hsl(0, 100%, 40%);">- 		fi<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-@@ -195,7 +195,7 @@</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- 	;;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-   status)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- 	if [ -f $lock ]; then</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">--	    for pidf in `/bin/ls $piddir/*=2Epid $piddir=
/*/*=2Epid 2&gt;/dev/null`; do</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-+	    for pidf in `find $piddir -name &quot;*=2Epid&quot; 2&gt;/de=
v/null`; do</span><br><span style=3D"color: hsl(0, 100%, 40%);">- 		if [ -s=
 $pidf ]; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">- 		    =
kill -USR2 `cat $pidf` &gt;/dev/null 2&gt;&amp;1</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- 		fi</span><br><span>diff --git a/sample/sample=
-config-files/openvpn-shutdown=2Esh b/sample/sample-config-files/openvpn-sh=
utdown=2Esh</span><br><span>deleted file mode 100755</span><br><span>index =
8ed2d1d=2E=2E0000000</span><br><span>--- a/sample/sample-config-files/openv=
pn-shutdown=2Esh</span><br><span>+++ /dev/null</span><br><span>@@ -1,5 +0,0=
 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#!/bin/sh</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-# stop all openvpn processes</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-killall -TERM openvpn</span><br><span>diff --git a/sample/sample=
-config-files/openvpn-startup=2Esh b/sample/sample-config-files/openvpn-sta=
rtup=2Esh</span><br><span>deleted file mode 100755</span><br><span>index 0e=
e006b=2E=2E0000000</span><br><span>--- a/sample/sample-config-files/openvpn=
-startup=2Esh</span><br><span>+++ /dev/null</span><br><span>@@ -1,34 +0,0 @=
@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#!/bin/sh</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-# A sample OpenVPN startup script</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-# for Linux=2E</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-# openvpn config file directory</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-dir=3D/etc/openvpn</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# load t=
he firewall</span><br><span style=3D"color: hsl(0, 100%, 40%);">-$dir/firew=
all=2Esh</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-# load TUN/TAP kernel module</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-modprobe tun</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-# enable IP forwarding</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-echo 1 &gt; /proc/sys/net/ipv4/ip_forward</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-# Invoke openvpn for each VPN tunnel</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-# in daemon mode=2E  Alternatively,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-# you could remove &quot;--d=
aemon&quot; from</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# the=
 command line and add &quot;daemon&quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-# to the config file=2E</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-# Each tunnel should run on a separate</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-# UDP port=2E  Use the &quot;port&quot; option</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-# to control this=2E  Like all o=
f</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# OpenVPN&#39;s opti=
ons, you can</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# specify=
 &quot;--port 8000&quot; on the command</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-# line or &quot;port 8000&quot; in the config</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-# file=2E</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-openvpn --cd $dir --daemon --config vpn1=2Econf</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-openvpn --cd $dir --daemon --config vp=
n2=2Econf</span><br><span style=3D"color: hsl(0, 100%, 40%);">-openvpn --cd=
 $dir --daemon --config vpn2=2Econf</span><br></pre><p>To view, visit <a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2186?usp=3Demail">change 2=
186</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2186?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: Icb79564ae4e0df1dcdd4a3734bd45f9513f56111 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2186 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83z=
van Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greeni=
e=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-dev=
el &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--PihZZ/R7FdQ=--


--===============2497630131482307184==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2497630131482307184==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2497630131482307184==--

