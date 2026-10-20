Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611AE606A31A
	for <openvpn-devel@archiver.kernel.org>; Tue, 20 Oct 2026 14:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=M4ogbD30;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=GIar3lr0;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bdYifOn3;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=XDUejNlN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jdjT1gt0oO4UvgIUCnkWhwFvL0A4WbSLOYcWBR4cNJA=; b=M4ogbD30wCzNyWja4zhmGtpci3
	LjIoKxISVeafqlukuULHwlV2ThdLJEZOQi/KhcIqAGTwPdvT07pkgn8DvhALrpYdqIXu+l3xUNNoK
	fxgu8F/2jh9pyAfCiNsIrRZBKmUpBsWsgB09rWHofXsFrXHcdb6KdOd2ZOKxeROm2HFY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xJBHr-0000GF-C4;
	Tue, 20 Oct 2026 14:57:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xJBHp-0000G5-E4
 for openvpn-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 14:57:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=tJd+BeShiJt81K2DgZuR2sGAjNVEOfx6+4lWIS4tYGo=; b=GIar3lr0o9+MUqRyy0DBMuQE2V
 BkDQVkfgZXtsTNvLR3rQkgoe5X1pAEGMfNnqcZjWRFxqC2mkySthqqteAE5cWTJX5O6wxNKFw4Jde
 9fWMe+dKb8wP1RWFa1FUZMiB7xCFuiEaDSGrNW5ssriRBl0ASNY/1AOTB2mF64FtB5ts=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tJd+BeShiJt81K2DgZuR2sGAjNVEOfx6+4lWIS4tYGo=; b=b
 dYifOn3pDOmOpi+MB7t48fCUPcU/C/Um4amRKVuVguhBudlIErgJ0e6RXPTnkLysbO3kaGsjCzDwB
 xVFVMc7T9jR4vbokUN6mZjC/dqRrAPc7EtgbQnSbPj93ZhSElUc4nUuZVg9UW75usww9ZpTS+mu25
 aZLP0BHcMl2NXmsQ=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xJBHn-0007VE-HM for openvpn-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 14:57:57 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48e0d1c095dso1957050f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 20 Oct 2026 07:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792508269; x=1793113069; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tJd+BeShiJt81K2DgZuR2sGAjNVEOfx6+4lWIS4tYGo=;
 b=XDUejNlNH57ioNQYlpzJnwZs+/0JMHRZr3UJWbsq+fDkp+3Gyd5ZZ/SW+MZ/Y/tcNl
 jxcsCD+tf9yEDIyq4G/hGwlVZFTuGosj+48qZcgDjuV0GPr3H4CXTvnzf99sdYylvfj7
 ew+2p2E3Zjhhe+F6NlNJCsS8LrkRz944FjL03kVeVQX1uST9SmOElu7r0IV6Ryz1IT7Z
 oVB0QdUuY9FhyQHt3dupl8jdJtrqg4EDBG7nzxsx2RcZ+vV0EcAwj+Lop1/G+XHBxbvz
 NJRDBGc5L0Jw2jqZvkqnGyKdtZ9jSd4pWEyH9cd5WiB4K8TS4JHkHVUUy+a1z+XXRiLU
 bWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792508269; x=1793113069;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=tJd+BeShiJt81K2DgZuR2sGAjNVEOfx6+4lWIS4tYGo=;
 b=BYEZeqiTXI4XWyX9nAHkTkCiPB7LQXDzgxtvMhmE3LXoutEmN+9qgv2NzyTEBmabim
 LrwDLUTweg5mQKyWPIkOB2H4mSHHyV3lIJyLGiDSyNr2q3vRhE6A3aGnz6m+aZJOj2Yy
 s6YuryWZoqg1w8yP5WSHOTJ/rjEV6hhaGw4pIQDEX8zAT1AjkSb0sm8mrbPVtUnpOCGe
 QienlbWvKTf4tfKAb1tj5j3eo6g4bfbx1ye6F8cVnRZsgHhGTMm9QVWYHmVwlVi1CVOG
 Ek0Omar/rz37RCBkS6TcSVanGx8kAuzYAV5yCbQriSIT7MM2kUDgbwekbVd17tWEc8dl
 Ll4Q==
X-Gm-Message-State: AFq9FYIu/yN+uQ2bF7CIZlN5VzLrw7E2A7fgzOuW8F+M68/dgllnrKT1
 wK2exM5xITQW0RzCfz9XIRDsWZVU4DVGx6RHT+NA9B585Qi5hllzSUR/gy0U6unSF8yck0V+Ze7
 S/w6g1FhSYM633CprVhxHY/Crq2bchjupHOgy8YyZYZegRkaQ3+CyKKsylbxNfz0S7eaJ
X-Gm-Gg: AYBFou1SZFRaxwnUWxr5/rYzk3xXmSVK0qcG6OwYZy+/KXwxEUOsUEIYYfSl0FW8ok7
 9auaVFn4yebef+vhTRSi/eZ5q8uStLx03w7QWi7zs5rWoPbYQLeRfLYhLAp7Yv4W79Ia08yVncy
 bVBMOByQohi8NAVgRSXwy0DB1iE1ZdCz5+l3/DoeC/Rw6ESNcKTPl9QRVI4XQD7QZXRklMShHGy
 wHaw3yxNqCPx/PDzZEYgxQJAk1tffVdzJLQeBYR31QAzV1yu/7zs8Zfk8cmYHIGoZicBazZkYOI
 TyLs5vndi/tZytrjwiF4H0jxU6ZAWjVW3dzQVT/4qwF01VV0tFYFFzZJo7WZZeIeZ98VlLs7GY5
 LjveCApGguS/HZzU62M05QPMfxtuBF0krCC00xdwSC8J9xVzhXCbeJ698HzBbgamyLVafd9M+Uj
 zh1iylWgAM/rIHVfab5VjTzyagkstQsslTQqk/y6Gen7S92BXwPxFUQLxF3OHPd3d4NnTE5MucM
 y2bbTAtjzbJFZT7UHsxjznDTqV15YSX19sMKvPsEPWT/ddtbpIK5JQmiEbLDPLbdRPvJ6n6Z6fY
 4WpkaZP1Qb8cinJW27PeQwrGsSuLZd/TnXCJE7gyey4U/IJ2JPgzNRMPVeaSpphodhmbqks=
X-Received: by 2002:a05:6000:2204:b0:48d:f9dd:e3de with SMTP id
 ffacd0b85a97d-48e07fdb62amr23162072f8f.45.1792508268735; 
 Tue, 20 Oct 2026 07:57:48 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d6dbf92sm5827559f8f.6.2026.10.20.07.57.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 07:57:48 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 20 Oct 2026 14:57:46 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ib92282b5a4c3c8da7b5818d3ce78e91660a13cbf
X-Gerrit-Change-Number: 2024
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2024?usp=email>
X-Gerrit-Commit: b50d336d00c93853ad542702516c1e0b99149fde
In-Reply-To: <gerrit.1792500876000.Ib92282b5a4c3c8da7b5818d3ce78e91660a13cbf@gerrit.openvpn.net>
References: <gerrit.1792500876000.Ib92282b5a4c3c8da7b5818d3ce78e91660a13cbf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyNTAwODc2MDAwLkliOTIyODJiNWE0YzNjOGRhN2I1ODE4ZDNjZTc4ZTkxNjYwYTEzY2JmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b2f68c4467e44826fc20eb30d84bc3427d3ca52d-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xJBHn-0007VE-HM
Subject: [Openvpn-devel] [S] Change in openvpn[master]: configure: Require
 automake 1.16
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2368778160498824448=="
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2368778160498824448==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LvDLiJhRbqE="; charset=UTF-8

--LvDLiJhRbqE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by Frank Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
024?usp=3Demail )

The following approvals got outdated and were removed:
C=
ode-Review+2 by R=C4=83zvan Cojocaru


Change subject: configure: Require a=
utomake 1=2E16
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


configure: Require automake 1=2E16

Removes some ugly compat code=2E auto=
make 1=2E16 is
in EOL distros like Ubuntu 20=2E04 and Debian 11,
so this sh=
ould be fine on all our current distros=2E

Change-Id: Ib92282b5a4c3c8da7b5=
818d3ce78e91660a13cbf
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2024
Message-Id: <20261020131943=2E24=
892-1-gert@greenie=2Emuc=2Ede>
URL: https://lore=2Ekernel=2Eorg/openvpn-dev=
el/20261020131943=2E24892-1-gert@greenie=2Emuc=2Ede/
Signed-off-by: Gert Do=
ering <gert@greenie=2Emuc=2Ede>
---
M configure=2Eac
1 file changed, 1 inse=
rtion(+), 13 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/o=
penvpn refs/changes/24/2024/2

diff --git a/configure=2Eac b/configure=2Eac=

index e83aba7=2E=2E52b0d20 100644
--- a/configure=2Eac
+++ b/configure=2Ea=
c
@@ -40,21 +40,9 @@
 AC_CONFIG_SRCDIR([src/openvpn/syshead=2Eh])
 AC_CONFI=
G_MACRO_DIR([m4])
 
-dnl Automake 1=2E14+ warns if sources are in sub-direc=
tories but subdir-objects
-dnl options is not enabled=2E However, automake =
before 1=2E15a has a bug that causes
-dnl variable expansion to fail in foo=
_SOURCES when this option is used=2E
-dnl As most of our build systems are =
now likely to use automake 1=2E16+ add a
-dnl work around to conditionally =
add subdir-objects option=2E
-m4_define([subdir_objects], [
-    m4_esyscmd=
([automake --version |
-                head -1 |
-                awk '{sp=
lit ($NF,a,"=2E"); if (a[1] =3D=3D 1 && a[2] >=3D 16) { print "subdir-objec=
ts" }}'
-    ])
-])
-
 # This foreign option prevents autoreconf from overr=
iding our COPYING and
 # INSTALL targets:
-AM_INIT_AUTOMAKE(foreign subdir_=
objects 1=2E9) dnl NB: Do not [quote] this parameter=2E
+AM_INIT_AUTOMAKE(f=
oreign subdir-objects 1=2E16) dnl NB: Do not [quote] this parameter=2E
 AM_=
SILENT_RULES([yes])
 AC_CANONICAL_HOST
 AC_USE_SYSTEM_EXTENSIONS

-- 
To vi=
ew, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2024?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib92282b5a4c3c8da7b5818d3=
ce78e91660a13cbf
Gerrit-Change-Number: 2024
Gerrit-PatchSet: 2
Gerrit-Owner=
: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvan=
c@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>

--LvDLiJhRbqE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by Fran=
k Lichtenheld=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2024?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">configure: Require automake 1=2E16<br><br>Removes some ugly compat code=
=2E automake 1=2E16 is<br>in EOL distros like Ubuntu 20=2E04 and Debian 11,=
<br>so this should be fine on all our current distros=2E<br><br>Change-Id: =
Ib92282b5a4c3c8da7b5818d3ce78e91660a13cbf<br>Signed-off-by: Frank Lichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc=
@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2024<br>Message-Id: &lt;20261020131943=2E24892-1-gert@greenie=2Emuc=2Ede&=
gt;<br>URL: https://lore=2Ekernel=2Eorg/openvpn-devel/20261020131943=2E2489=
2-1-gert@greenie=2Emuc=2Ede/<br>Signed-off-by: Gert Doering &lt;gert@greeni=
e=2Emuc=2Ede&gt;<br>---<br>M configure=2Eac<br>1 file changed, 1 insertion(=
+), 13 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopen=
vpn=2Enet:29418/openvpn refs/changes/24/2024/2</pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/configu=
re=2Eac b/configure=2Eac</span><br><span>index e83aba7=2E=2E52b0d20 100644<=
/span><br><span>--- a/configure=2Eac</span><br><span>+++ b/configure=2Eac</=
span><br><span>@@ -40,21 +40,9 @@</span><br><span> AC_CONFIG_SRCDIR([src/op=
envpn/syshead=2Eh])</span><br><span> AC_CONFIG_MACRO_DIR([m4])</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-dnl Automake 1=
=2E14+ warns if sources are in sub-directories but subdir-objects</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-dnl options is not enabled=2E H=
owever, automake before 1=2E15a has a bug that causes</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-dnl variable expansion to fail in foo_SOURC=
ES when this option is used=2E</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-dnl As most of our build systems are now likely to use automake 1=
=2E16+ add a</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dnl work =
around to conditionally add subdir-objects option=2E</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-m4_define([subdir_objects], [</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    m4_esyscmd([automake --version =
|</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                head=
 -1 |</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
awk &#39;{split ($NF,a,&quot;=2E&quot;); if (a[1] =3D=3D 1 &amp;&amp; a[2] =
&gt;=3D 16) { print &quot;subdir-objects&quot; }}&#39;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    ])</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span> # This foreign option prevents autoreconf from overriding =
our COPYING and</span><br><span> # INSTALL targets:</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-AM_INIT_AUTOMAKE(foreign subdir_objects 1=
=2E9) dnl NB: Do not [quote] this parameter=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+AM_INIT_AUTOMAKE(foreign subdir-objects 1=2E16) =
dnl NB: Do not [quote] this parameter=2E</span><br><span> AM_SILENT_RULES([=
yes])</span><br><span> AC_CANONICAL_HOST</span><br><span> AC_USE_SYSTEM_EXT=
ENSIONS</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2024?usp=3Demail">change 2024</a>=2E To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2024?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib92282b5a4c3c8da7b5818=
d3ce78e91660a13cbf </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 2024 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>

</body></html>
--LvDLiJhRbqE=--


--===============2368778160498824448==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2368778160498824448==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2368778160498824448==--

