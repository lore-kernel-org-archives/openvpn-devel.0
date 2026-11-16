Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00FD606A332
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 12:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Htwg6UTb;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=E3k3/Irj;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=lnxx4VZa;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=UdJi7iBH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=gRcpuy4u9lGLIFBZymLDBN1tEQ2jm3g4oAPV/UeXXt0=; b=Htwg6UTb+SKWlDQaJpZXEp8KKk
	K2q1kfUIaq8tP/b/ipljxIkMQtvlOIvuaCpdGS8L1M00V/Pfs7/lKGYzjVNaHdtlPqXhx5Y1+1NHl
	0WZsdnVLOLiVL/7uRnMihc5u6tJG51c1hlNA4X8tS0Yd0HnaleknSj1cMq9iwKQCb9zM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSvp5-000000003zQ-1BeH;
	Mon, 16 Nov 2026 12:28:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSvoP-000000003wv-3z6T
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 12:27:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1qW35K4ud0QfSuxDedRnccRn9HlXyoyRiv78boE3OsY=; b=E3k3/IrjKCHsf79ugU88NUTGs4
 ai0jW/C9o0VyUdVyAXpgXicQ+iUgShnV9D9BvT56sxghuAgjEFvNFmaYgzyVCfpsTi04O9/Imy/8z
 JOtn6yDCvWvFM55y1Do9hmvvZ4X5YE6zmEq9XtGdqXqqpzC70dyAizT10kIk/csZ1ZtY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1qW35K4ud0QfSuxDedRnccRn9HlXyoyRiv78boE3OsY=; b=lnxx4VZaAIE8XiQLSfd1xLOZG5
 OESe4X2WRtcTxQb8IdqXhKU9uQg3jSko+su6TZwgnoerhlAv7+ECm1glgxuUfy9VUWYnQU3jPuHuo
 xOaeEyPPOfx2SOex1u7ZqmT2QEA6zduCOooxrOu7DYV4SXLf3f9ofW2rE38BJ8HEbO4o=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSvoJ-000000003SD-3OmZ for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 12:27:53 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-492690dd5daso3248094f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 04:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794832061; x=1795436861; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1qW35K4ud0QfSuxDedRnccRn9HlXyoyRiv78boE3OsY=;
 b=UdJi7iBHzhiL6butyHpYk6ywAD/qOOdw/4yE7A4yfxgTEy+qKUgS6Uh7t4VEQ96wkM
 t1BahBHm44DD4GRqwjghbKjPTJ+/cjmnTRjGundAwwRYb8Ch4/aiIW70dudody7wVA0M
 rS5A9RbSlYSI9HmvcUhUw1KdZmJxvBb28hobZbqs2FstpYYLROZsNFMP26hGkNyK8hsa
 CjyJbx48iU3lw/9H8A1q3JSXOzyuDEanR4gpU9oxlotwoJGcyNu6Rh4NrnYo81XeBQqH
 3ATjEvHg5FyLM48gwzOx0uYete21wo0LkDZVrGIgdK1VKKz86+qZ/k0wVFq+cbqTnDDT
 3VNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794832061; x=1795436861;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=1qW35K4ud0QfSuxDedRnccRn9HlXyoyRiv78boE3OsY=;
 b=ac2wS8GYhYY0XASLL0de2+XtyqKDVFWPvC2Kpa1dds/T4kKQen5JchK8JmtTrmyOo5
 +YpmcyMhYIg2ahA4ZaYJN+nU6PECE0COB3n554oJkh3v0xQfEDUGE2osZaCAAbHbLi0i
 lPUpxxfyaSAG8F5SvrkOzKIHzO1s2hhZvMpwXnM2XMqz8N01wHWoDKHU2q7+T7YgjLwc
 efwCWo775GHca/vgUR7A3AjoP3tj8qQlr7qs0rwHFrpxN5uvoYSBOszge6jbbJWTE0gk
 6M++ICqu03ra43jJda1DpdQN+pXYJxv+fCNbQsVvgVEjd8cCnSkxMxdooNUqQbXHHJbv
 X8vA==
X-Forwarded-Encrypted: i=1;
 AL+hErELDvU9ggL9SH49iaKZXwFWnVglDp75EFUggYTmfx4fgRmFJCCp4WEux1nvhbkmMFXR/Li9elnNTbbAEDmG@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8aMHLrnLEz00B6YUtpkYZ1XxThChHdXaeocNZ2zM9Su7LUDTjy
 a7euwIrRgCHCaxsngzruFXsSRI2K1DBojWR/TmIxuxxLx/v+nPIJa6fJXYH1QkH4wUAzx1hv/pt
 JNhfB3Y3KLP31JwvASK5vP9p9bQs4USfF9OKuOGtm6WI2c1IrotlYSv9NiSTOCMXNNdbb
X-Gm-Gg: AZFdTZfzapUTtYJKzVi4QmjrokxLccjYKDxUKuajz/vME4bekZmqlUoxgvoBkZAFuqd
 bOV87yeYH1sTEgdkg052+wvBTSxIPVVXGf0efjDscrYw0Wyp3ppgLySuQEc8jHSqBRncCTchgmK
 eUIyaGOx2BKrL1NXbq5/1c2wi4NzmXD2FKh56RvaT0axUvpmRCyo8C5xAtjRqPx2blXkFfiH2tO
 Gy4NOhMYIC86ty/5WaRJcjpX7la8eU3hLdqkIspFzW3rpQukVpgURSZp9Ssjz1//6IYmU0sEdSo
 6DY7tADCNmL1KhxgfNhA/JGitkW/RJUlvIBaEHPsVNH4/61ZW2s6upNcTk09Bb1rMG1XbNUgNVj
 YPKEKHXX75pOOSF+0oJ3uKjmz3WHFnj/4FfJK7HTqxNpdgEJq7GP0jwzOygXKJeM2a5SIYpC6+3
 6syjM1EgK/h50cg2U6S+TmaC2hQHU7lYWdAIiOeoRz4U7/dvPJ3ESiq3d34WITV7i3a6R7B6qpx
 SU6P+XkpSS7iUXiGdx7AVC/VxZnhBivB7RybLmfnoNwIK59djCLcqiH5YE6Cc4RK0K304cIw9VA
 JBXRPMZC+6tO1Bqt3Vti1JVY1g3WRKiZXUU9BefaM3QGhgc+izkMTWvMLVjMNBzNsE21yKUIwaX
 sE/uYfaj79yodgK/FBIrUYXVmGfgucu/vwLYDSIqlZPRLmZXgfWa4lDtfiucwzqJE8I/KkdsSfW
 K/EgKcvTMiMbDXbAY=
X-Received: by 2002:a05:6000:98c:b0:491:49c2:3b3 with SMTP id
 ffacd0b85a97d-49c71d48644mr20603198f8f.51.1794832060950; 
 Mon, 16 Nov 2026 04:27:40 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5f1c1797sm24381645f8f.11.2026.11.16.04.27.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 04:27:40 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 12:27:40 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Icb79564ae4e0df1dcdd4a3734bd45f9513f56111
X-Gerrit-Change-Number: 2186
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2186?usp=email>
X-Gerrit-Commit: b0668301ed71e90dfed96c4e5bfafdbe2000ed93
In-Reply-To: <gerrit.1794757486000.Icb79564ae4e0df1dcdd4a3734bd45f9513f56111@gerrit.openvpn.net>
References: <gerrit.1794757486000.Icb79564ae4e0df1dcdd4a3734bd45f9513f56111@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0NzU3NDg2MDAwLkljYjc5NTY0YWU0ZTBkZjFkY2RkNGEzNzM0YmQ0NWY5NTEzZjU2MTExQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f536c0bbd5efae3d719c2a68662906876aba8bd3-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSvoJ-000000003SD-3OmZ
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7831298988746242647=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7831298988746242647==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AM4QZF7a290="; charset=UTF-8

--AM4QZF7a290=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2186?usp=3Demail )

Change subject: contrib, sample: drop SysV-=
era init scripts
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

contrib, sample: drop SysV-era init scripts

multilevel-init=2Epatch p=
atches the init script removed in 57ec6cec
("cleanup: Remove RPM openvpn=2E=
spec build approach")=2E
openvpn-startup=2Esh and openvpn-shutdown=2Esh are=
 superseded by the
systemd units in distro/systemd=2E

Change-Id: Icb79564a=
e4e0df1dcdd4a3734bd45f9513f56111
Signed-off-by: Razvan Cojocaru <razvanc@ma=
ilbox=2Eorg>
Acked-by: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL: h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2186
Message-Id: <20261116095438=
=2E11288-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/o=
penvpn-devel@lists=2Esourceforge=2Enet/msg41407=2Ehtml
Signed-off-by: Gert =
Doering <gert@greenie=2Emuc=2Ede>
---
D contrib/multilevel-init=2Epatch
D s=
ample/sample-config-files/openvpn-shutdown=2Esh
D sample/sample-config-file=
s/openvpn-startup=2Esh
3 files changed, 0 insertions(+), 118 deletions(-)

=



diff --git a/contrib/multilevel-init=2Epatch b/contrib/multilevel-init=
=2Epatch
deleted file mode 100644
index 8d48fbc=2E=2E0000000
--- a/contrib/=
multilevel-init=2Epatch
+++ /dev/null
@@ -1,79 +0,0 @@
---- /etc/init=2Ed/o=
penvpn	2004-05-12 20:30:06=2E000000000 +0200
-+++ openvpn	2004-05-12 20:34:=
33=2E000000000 +0200
-@@ -58,13 +58,13 @@
- #     returning success or fail=
ure status to caller (James Yonan)=2E
- 
- # Location of openvpn binary
--o=
penvpn=3D"/usr/sbin/openvpn"
-+openvpn=3D/usr/sbin/openvpn
- 
- # Lockfile
=
--lock=3D"/var/lock/subsys/openvpn"
-+lock=3D/var/lock/subsys/openvpn
- 
- =
# PID directory
--piddir=3D"/var/run/openvpn"
-+piddir=3D/var/run/openvpn
-=
 
- # Our working directory
- work=3D/etc/openvpn
-@@ -106,7 +106,7 @@
- 
-=
 	if [ -f $lock ]; then
- 	    # we were not shut down correctly
--	    for=
 pidf in `/bin/ls $piddir/*=2Epid $piddir/*/*=2Epid 2>/dev/null`; do
-+	   =
 for pidf in `find $piddir -name "*=2Epid" 2>/dev/null`; do
- 	      if [ -=
s $pidf ]; then
- 		kill `cat $pidf` >/dev/null 2>&1
- 	      fi
-@@ -116,1=
2 +116,12 @@
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
rit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerri=
t-Change-Id: Icb79564ae4e0df1dcdd4a3734bd45f9513f56111
Gerrit-Change-Number=
: 2186
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailb=
ox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel =
<openvpn-devel@lists=2Esourceforge=2Enet>

--AM4QZF7a290=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2186?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">contrib, sample: drop SysV-era ini=
t scripts<br><br>multilevel-init=2Epatch patches the init script removed in=
 57ec6cec<br>(&quot;cleanup: Remove RPM openvpn=2Espec build approach&quot;=
)=2E<br>openvpn-startup=2Esh and openvpn-shutdown=2Esh are superseded by th=
e<br>systemd units in distro/systemd=2E<br><br>Change-Id: Icb79564ae4e0df1d=
cdd4a3734bd45f9513f56111<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mail=
box=2Eorg&gt;<br>Acked-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>=
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2186<br>Message-Id: =
&lt;20261116095438=2E11288-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://ww=
w=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41407=2Eh=
tml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<b=
r>D contrib/multilevel-init=2Epatch<br>D sample/sample-config-files/openvpn=
-shutdown=2Esh<br>D sample/sample-config-files/openvpn-startup=2Esh<br>3 fi=
les changed, 0 insertions(+), 118 deletions(-)<br><br></pre>
<pre style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git =
a/contrib/multilevel-init=2Epatch b/contrib/multilevel-init=2Epatch</span><=
br><span>deleted file mode 100644</span><br><span>index 8d48fbc=2E=2E000000=
0</span><br><span>--- a/contrib/multilevel-init=2Epatch</span><br><span>+++=
 /dev/null</span><br><span>@@ -1,79 +0,0 @@</span><br><span>---- /etc/init=
=2Ed/openvpn	2004-05-12 20:30:06=2E000000000 +0200</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-+++ openvpn	2004-05-12 20:34:33=2E000000000 +0=
200</span><br><span style=3D"color: hsl(0, 100%, 40%);">-@@ -58,13 +58,13 @=
@</span><br><span style=3D"color: hsl(0, 100%, 40%);">- #     returning suc=
cess or failure status to caller (James Yonan)=2E</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- </span><br><span style=3D"color: hsl(0, 100%, =
40%);">- # Location of openvpn binary</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">--openvpn=3D&quot;/usr/sbin/openvpn&quot;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-+openvpn=3D/usr/sbin/openvpn</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- # Lockfile</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">--lock=3D&quot;/var/lock/subsys/openvpn&quot;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-+lock=3D/var/lock/subsys/openvpn</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- # PID directory</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">--piddir=3D&quot;/var/run/openvpn&quot;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-+piddir=3D/var/run/openvpn</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- # Our working directory</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- work=3D/etc/openvpn</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-@@ -106,7 +106,7 @@</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- 	if [ -f $lock ]; then</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- 	    # we were not shut down correctly</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">--	    for pidf in `/bin/ls $piddir/*=2Epid $piddir/*=
/*=2Epid 2&gt;/dev/null`; do</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-+	    for pidf in `find $piddir -name &quot;*=2Epid&quot; 2&gt;/dev/=
null`; do</span><br><span style=3D"color: hsl(0, 100%, 40%);">- 	      if [=
 -s $pidf ]; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">- 		k=
ill `cat $pidf` &gt;/dev/null 2&gt;&amp;1</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- 	      fi</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-@@ -116,12 +116,12 @@</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- 	    sleep 2</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- 	fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">- </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">--	rm -f $piddir/*=2Epid $piddir/*/*=
=2Epid</span><br><span style=3D"color: hsl(0, 100%, 40%);">-+	find $piddir =
-name &quot;*=2Epid&quot;|xargs rm -f</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- </span><br><span style=3D"color: hsl(0, 100%, 40%);">- 	# =
Start every =2Econf in $work and run =2Esh if exists</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- 	errors=3D0</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- 	successes=3D0</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">--	for c in `/bin/ls *=2Econf */*=2Econf 2&gt;/dev/null`; d=
o</span><br><span style=3D"color: hsl(0, 100%, 40%);">-+	for c in `find * -=
name &quot;*=2Econf&quot; 2&gt;/dev/null`; do</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- 	    bn=3D${c%%=2Econf}</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- 	    if [ -f &quot;$bn=2Esh&quot; ]; then</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- 		=2E $bn=2Esh</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-@@ -147,7 +147,7 @@</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- 	;;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-   stop)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- 	echo -n $&quot;Shutting down openvpn: &quot;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">--	for pidf in `/bin/ls $piddir/*=2Epid $=
piddir/*/*=2Epid 2&gt;/dev/null`; do</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-+	for pidf in `find $piddir -name &quot;*=2Epid&quot; 2&gt;/=
dev/null`; do</span><br><span style=3D"color: hsl(0, 100%, 40%);">- 	  if [=
 -s $pidf ]; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">- 	  =
  kill `cat $pidf` &gt;/dev/null 2&gt;&amp;1</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- 	  fi</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-@@ -163,7 +163,7 @@</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- 	;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   reload)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- 	if [ -f $lock ]; the=
n</span><br><span style=3D"color: hsl(0, 100%, 40%);">--	    for pidf in `/=
bin/ls $piddir/*=2Epid $piddir/*/*=2Epid 2&gt;/dev/null`; do</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-+	    for pidf in `find $piddir -nam=
e &quot;*=2Epid&quot; 2&gt;/dev/null`; do</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- 		if [ -s $pidf ]; then</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- 		    kill -HUP `cat $pidf` &gt;/dev/null 2&gt;&amp=
;1</span><br><span style=3D"color: hsl(0, 100%, 40%);">- 		fi</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-@@ -175,7 +175,7 @@</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- 	;;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-   reopen)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- 	if [ -f $lock ]; then</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">--	    for pidf in `/bin/ls $piddir/*=2Epid $piddir/*/*=2Epid 2&=
gt;/dev/null`; do</span><br><span style=3D"color: hsl(0, 100%, 40%);">-+	  =
  for pidf in `find $piddir -name &quot;*=2Epid&quot; 2&gt;/dev/null`; do</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- 		if [ -s $pidf ]; the=
n</span><br><span style=3D"color: hsl(0, 100%, 40%);">- 		    kill -USR1 `c=
at $pidf` &gt;/dev/null 2&gt;&amp;1</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- 		fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-@@=
 -195,7 +195,7 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);">- 	;;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   status)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- 	if [ -f $lock ]; then</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">--	    for pidf in `/bin/ls $pi=
ddir/*=2Epid $piddir/*/*=2Epid 2&gt;/dev/null`; do</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-+	    for pidf in `find $piddir -name &quot;*=
=2Epid&quot; 2&gt;/dev/null`; do</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- 		if [ -s $pidf ]; then</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- 		    kill -USR2 `cat $pidf` &gt;/dev/null 2&gt;&amp;1</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- 		fi</span><br><span>diff =
--git a/sample/sample-config-files/openvpn-shutdown=2Esh b/sample/sample-co=
nfig-files/openvpn-shutdown=2Esh</span><br><span>deleted file mode 100755</=
span><br><span>index 8ed2d1d=2E=2E0000000</span><br><span>--- a/sample/samp=
le-config-files/openvpn-shutdown=2Esh</span><br><span>+++ /dev/null</span><=
br><span>@@ -1,5 +0,0 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#!/bin/sh</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-# stop all openvpn processes</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-killall -TERM openvpn</span><br><span>diff =
--git a/sample/sample-config-files/openvpn-startup=2Esh b/sample/sample-con=
fig-files/openvpn-startup=2Esh</span><br><span>deleted file mode 100755</sp=
an><br><span>index 0ee006b=2E=2E0000000</span><br><span>--- a/sample/sample=
-config-files/openvpn-startup=2Esh</span><br><span>+++ /dev/null</span><br>=
<span>@@ -1,34 +0,0 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#!/bin/sh</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-# A sample OpenVPN startup scrip=
t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# for Linux=2E</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-# openvpn config file directory</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-dir=3D/etc/openvpn</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-# load the firewall</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-$dir/firewall=2Esh</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# load TUN/TA=
P kernel module</span><br><span style=3D"color: hsl(0, 100%, 40%);">-modpro=
be tun</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-# enable IP forwarding</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-echo 1 &gt; /proc/sys/net/ipv4/ip_f=
orward</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-# Invoke openvpn for each VPN tunnel=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# in daemon mode=2E  =
Alternatively,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# you c=
ould remove &quot;--daemon&quot; from</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-# the command line and add &quot;daemon&quot;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-# to the config file=2E</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-# Each tunnel should run on a separate</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-# UDP port=2E  Use the &quot;port&qu=
ot; option</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# to contro=
l this=2E  Like all of</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-# OpenVPN&#39;s options, you can</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-# specify &quot;--port 8000&quot; on the command</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-# line or &quot;port 8000&quot; in t=
he config</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# file=2E</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-openvpn --cd $dir --daemon --config vpn1=2E=
conf</span><br><span style=3D"color: hsl(0, 100%, 40%);">-openvpn --cd $dir=
 --daemon --config vpn2=2Econf</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-openvpn --cd $dir --daemon --config vpn2=2Econf</span><br></pre><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2186?=
usp=3Demail">change 2186</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2186?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Icb79564ae4e0df1dcdd4a3734bd45f9513f56111 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2186 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doerin=
g &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=

</body></html>
--AM4QZF7a290=--


--===============7831298988746242647==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7831298988746242647==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7831298988746242647==--

