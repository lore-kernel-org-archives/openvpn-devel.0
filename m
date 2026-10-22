Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BEE606A319
	for <openvpn-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MJbQn8PS;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=e/wWWjmA;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=aimNZSph;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=aHVbUHBe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=3rm0FoSx7WbP9WEtNChEjuG3GZTE6KG/5hiJaxkVbVY=; b=MJbQn8PSUdPpGMhNY7Rp1x9fPJ
	QazoNL7huBJXJ6gjkUPBxornP0jZZSEvX2yYCBaCSm7/EnJFKVz9eX8JngLTPuD3dlMtA0e8iJJu1
	KJg/Ul26Bt1atX5CLM8+K6U8XNONcJkDGzSfY6uL5kh3u4da67egC07nbpgycn31kLCk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xJshK-000000008V7-19Vj;
	Thu, 22 Oct 2026 13:19:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xJshI-000000008V0-494J
 for openvpn-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 13:19:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PQqsRrgkb8f/4qKNNTC8ervZLr3Ifeur6cDqg4h2ADM=; b=e/wWWjmAwJgN3kFWPV8U/N8ssC
 +EcoU0PKiiYVG1qb9U6A0iXoBhm8cPt/S2JFtI7Qe5CdKnhEnL4ErtbI1U0IVuaPfVVCnoqMNpE2D
 UTmgmdnEJlY//GLp85Kwbu+wqpYT9kU2107bmp018AJMvVQe2jwiZzir82LB/GZs9Mg8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PQqsRrgkb8f/4qKNNTC8ervZLr3Ifeur6cDqg4h2ADM=; b=aimNZSphFG6TakJj9xKeStq15h
 U2BWYCDZNolW66pFZWZFeBVQH3juMcENleAgENEmZawbAHDyTvKSerUmiAYxRSrFBxEJQhzmQmQow
 QSofx7iH27pL3DKSM5rAwq7cRp/P3mKnQsUkMc/kFfpRPvVRQ3Lj2gLcDRoYP5uEclBI=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xJshH-000000007k4-0ltn for openvpn-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 13:19:08 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso4287715e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 22 Oct 2026 06:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792675141; x=1793279941; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PQqsRrgkb8f/4qKNNTC8ervZLr3Ifeur6cDqg4h2ADM=;
 b=aHVbUHBeHy69YtGjuuQhQ76bjeGe7A15v1dL/Nw54zGIj4tyUZT7c4pDwviYiD7ztv
 qfv9Crld4mQNsEIeI1/jgEfV8UdC/lOxUc0EYTRui2AtznYYgS+RUljVsgWN/Y+oX/gD
 crLgM38FT8JgvsjbCPY/tB0TSoHrsFZ1z3K46rxSspFA/Hs5nS6R/1eGGl8FuufyZDrb
 RVz7pIhzSJJvCK4EJK6+Tn/Fpaf8GXzdt8YuLqWeWN9AUnuKNdF1WQ0k3O5WLLJlKCP1
 Xm2hbxWtPFH/YR7TEs+FB6a6dI1piqkEvNY/msdFDnZpEYuWvMI0hHn6InkR0QaLWKSP
 y1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792675141; x=1793279941;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=PQqsRrgkb8f/4qKNNTC8ervZLr3Ifeur6cDqg4h2ADM=;
 b=zkNfo02c+5M1U5Dryb3T0L8/1p3rQQTUWgPp97SnRz+tQn8kRb3Ojrz2g5RVprSseK
 YWF0VeXTmmIbln5BknFQIrpYS+VnhnnHrj/sHT2gt6x77Zhn1SomlZKopN/krvQFpnxf
 fCrm/ejSR5FTDbqsqCjXsOkQTrbWWY0/DNBD0uOLjUXXDqpU3nyh02yaEdSF9IW1ysgK
 lhXekiRNI5nvGUP+D2NrPKUkJ1+OMij5EnPsGWmhYgZ1VpZxAhnI87qWqpnOpZXisWwz
 j0O+Dv2rDCPd+K9dY9i7HjIi/cLt985+erFyz/R+mqe0RBUqdxBrtlVIxl8kEc8uQ4RQ
 pMvg==
X-Gm-Message-State: AFq9FYLJLxBN4gC1VtKwXlqaWjVjAZm314fOcGjKpr4idini3qEKyl3h
 9UHg0ejq9hYEtkwnYo7RZW2XPtmX6aHbyvkoE1aF5+lsawRZDtjzYNF+90ifg1TlfO00kNkoX5u
 35pW+B/XXTyOddskYarqqge7AkVfERanbRPtFNuRwK80uH0qDhKcMeMoKyrYfojJQz43h
X-Gm-Gg: AYBFou0urBJ8vC/b8ohuVjCmILYZ5HKywX5ujzxINLAtUx6pKqqmtBrNLR8ZPQgIfsl
 cR9LMnqj2LbxafAyelndTbsikJWv8nK8zKE8RV/gaGBE9k4Od0T8Sqc98WjTNijD1J2CJGvcSzD
 mxfcRypYeHoRfAAdhzst7/YuzwQBoWKptNgB5ZFwdSU4X4QjeXupM5c04+7WlAlhNz0e1hidAsq
 g9rZqh764eyaD4sWOb6s3WfxUUl+OdUlB364NgqjB7DyaU1yz+aAly6zkEzNqCtDAOmm/mBEDtd
 /NwUaxU5sBq8XOwaMaLxZuzRMUe+dS+avyXtuPKZgFsN4kgFKUQT73t1EeSnhjyCGcPL5TR3kTW
 ymOSGwxVz/KhnsaJ25fBtz2Q8Y8R/IC+j4MvUJAFUioD7oEgxthErJI910m/DYLfJNiJDCX2uAH
 6AXRYlyWhK5xRBo6UjmcqBkAWVJi7GnRGcCd9xGqAcjgJVCQn3W0JLmtvEqFfIQ4bUnVyeV3c45
 i1DSrs97x2Pv1aAKdRwO6885W1hXrzig0bET9pV9BWBMTVWtYFmIMJSjhzAdROSOzmrL/3HpOPE
 zSiZ4B7+KSkX3uAa68LdmrVq9V1BDGOziaf7/QiwsW97GBmF0tBTUk2h3zevVDh2fVdg1E+waBA
 VPAwbGlL93yRNChQ710mYK+b6vYjxfc8kQt+yfrkWgpc=
X-Received: by 2002:a05:600c:3d8d:b0:4a1:714d:eed with SMTP id
 5b1f17b1804b1-4a1fdb1f027mr102674605e9.14.1792675140216; 
 Thu, 22 Oct 2026 06:19:00 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e254f0bc2sm12129890f8f.1.2026.10.22.06.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 06:18:59 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 22 Oct 2026 13:18:57 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I20d367dd8251bf39856ae521f380cfdc8df64177
X-Gerrit-Change-Number: 2028
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2028?usp=email>
X-Gerrit-Commit: 74ba58631ae2b53668c2b5d372e4f7ed28e02223
In-Reply-To: <gerrit.1792667802000.I20d367dd8251bf39856ae521f380cfdc8df64177@gerrit.openvpn.net>
References: <gerrit.1792667802000.I20d367dd8251bf39856ae521f380cfdc8df64177@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyNjY3ODAyMDAwLkkyMGQzNjdkZDgyNTFiZjM5ODU2YWU1MjFmMzgwY2ZkYzhkZjY0MTc3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4869fd37fcb14e33e2902a8a8e959c5eaaecbbfc-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xJshH-000000007k4-0ltn
Subject: [Openvpn-devel] [S] Change in openvpn[master]: configure: Call
 AC_PROG_CC before AC_USE_SYSTEM_EXTENSIONS
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
Content-Type: multipart/mixed; boundary="===============8899615761625981133=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8899615761625981133==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ol7oIQjPt68="; charset=UTF-8

--ol7oIQjPt68=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2028?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Arne Schwabe, Code-Review+2 by Frank Lichtenheld


Chang=
e subject: configure: Call AC_PROG_CC before AC_USE_SYSTEM_EXTENSIONS
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

configure: Call =
AC_PROG_CC before AC_USE_SYSTEM_EXTENSIONS

AC_USE_SYSTEM_EXTENSIONS requir=
es AC_PROG_CC, so the later explicit
call expanded it a second time and rep=
eated the C standard checks
as "(cached)"=2E

Change-Id: I20d367dd8251bf398=
56ae521f380cfdc8df64177
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eo=
rg>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit URL: https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2028
Message-Id: <20261022123500=2E2725=
6-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-=
devel@lists=2Esourceforge=2Enet/msg40092=2Ehtml
Signed-off-by: Gert Doering=
 <gert@greenie=2Emuc=2Ede>
---
M configure=2Eac
1 file changed, 5 insertion=
s(+), 5 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/28/2028/2

diff --git a/configure=2Eac b/configure=2Eac
inde=
x e31a7ff=2E=2E0ac61b4 100644
--- a/configure=2Eac
+++ b/configure=2Eac
@@ =
-45,6 +45,11 @@
 AM_INIT_AUTOMAKE(foreign subdir-objects 1=2E16) dnl NB: Do=
 not [quote] this parameter=2E
 AM_SILENT_RULES([yes])
 AC_CANONICAL_HOST
+=
AC_PROG_CC
+# AC_PROG_CC doesn't output any useful information
+AC_MSG_CHEC=
KING([compiler version])
+CC_version=3D$($CC --version | head -n1)
+AC_MSG_=
RESULT([$CC_version])
 AC_USE_SYSTEM_EXTENSIONS
 
 AM_EXTRA_RECURSIVE_TARGE=
TS([build-tests])
@@ -380,11 +385,6 @@
 	pkg_config_found=3D"(${PKG_CONFIG}=
)"
 fi
 
-AC_PROG_CC
-# AC_PROG_CC doesn't output any useful information
-A=
C_MSG_CHECKING([compiler version])
-CC_version=3D$($CC --version | head -n1=
)
-AC_MSG_RESULT([$CC_version])
 AC_PROG_CPP
 AC_PROG_INSTALL
 AC_PROG_LN_S=


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2028?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Ger=
rit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I20d367dd8251b=
f39856ae521f380cfdc8df64177
Gerrit-Change-Number: 2028
Gerrit-PatchSet: 2
G=
errit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: =
Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenhel=
d <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>

--ol7oIQjPt68=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2028?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Arne Schwabe, Code-Review+2 by Fr=
ank Lichtenheld</p><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">configure: Call AC_PROG_CC before AC_USE_S=
YSTEM_EXTENSIONS<br><br>AC_USE_SYSTEM_EXTENSIONS requires AC_PROG_CC, so th=
e later explicit<br>call expanded it a second time and repeated the C stand=
ard checks<br>as &quot;(cached)&quot;=2E<br><br>Change-Id: I20d367dd8251bf3=
9856ae521f380cfdc8df64177<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mai=
lbox=2Eorg&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;=
<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2028<br>Message-=
Id: &lt;20261022123500=2E27256-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https:=
//www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40092=
=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>-=
--<br>M configure=2Eac<br>1 file changed, 5 insertions(+), 5 deletions(-)<b=
r><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openv=
pn refs/changes/28/2028/2</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/configure=2Eac b/configure=
=2Eac</span><br><span>index e31a7ff=2E=2E0ac61b4 100644</span><br><span>---=
 a/configure=2Eac</span><br><span>+++ b/configure=2Eac</span><br><span>@@ -=
45,6 +45,11 @@</span><br><span> AM_INIT_AUTOMAKE(foreign subdir-objects 1=
=2E16) dnl NB: Do not [quote] this parameter=2E</span><br><span> AM_SILENT_=
RULES([yes])</span><br><span> AC_CANONICAL_HOST</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+AC_PROG_CC</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+# AC_PROG_CC doesn&#39;t output any useful information</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+AC_MSG_CHECKING([comp=
iler version])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CC_ve=
rsion=3D$($CC --version | head -n1)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+AC_MSG_RESULT([$CC_version])</span><br><span> AC_USE_SYSTEM=
_EXTENSIONS</span><br><span> </span><br><span> AM_EXTRA_RECURSIVE_TARGETS([=
build-tests])</span><br><span>@@ -380,11 +385,6 @@</span><br><span> 	pkg_co=
nfig_found=3D&quot;(${PKG_CONFIG})&quot;</span><br><span> fi</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-AC_PROG_CC</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-# AC_PROG_CC doesn&#39;t outp=
ut any useful information</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-AC_MSG_CHECKING([compiler version])</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-CC_version=3D$($CC --version | head -n1)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-AC_MSG_RESULT([$CC_version])</span><br=
><span> AC_PROG_CPP</span><br><span> AC_PROG_INSTALL</span><br><span> AC_PR=
OG_LN_S</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2028?usp=3Demail">change 2028</a>=2E To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2028?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: I20d367dd8251bf39856ae5=
21f380cfdc8df64177 </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 2028 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailb=
ox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schw=
abe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>

</body></html>
--ol7oIQjPt68=--


--===============8899615761625981133==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8899615761625981133==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8899615761625981133==--

