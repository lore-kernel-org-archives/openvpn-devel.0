Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5120E606A31D
	for <openvpn-devel@archiver.kernel.org>; Mon, 26 Oct 2026 20:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Svsx6VtK;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Kqfyk0Yx;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jyA8MVoW;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=TWKRgCt3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=/7Il8lZgSPhDiGmCDRR5Cj+Q5rIRwrDMErYf1IQfnbA=; b=Svsx6VtKjuFEHqGhRtSVDUI5Gu
	W1dznkX/lOyrrLZsMM9uVqc4QEo4unS42/lrTDI6SdgxLDjCSOeprnsPuLBcS3yEVnju0WtMHxZ7n
	f/Uaz7te9JINXWmuaPUwNgGqGkUDe77JkjCZN52p9d3+WtmB3HuODZA9/yzn+CtWV0MQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLR5u-000000004QZ-0mSN;
	Mon, 26 Oct 2026 20:14:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLR5d-000000004QH-3ftn
 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 20:14:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9/wlY+grozIsFQ1+nb46jMvFFc36qA1xm8FqukFgFsI=; b=Kqfyk0YxpYui3ynH8C95a8dEBv
 EIg8+DQckdlQxbBiS0cZGKJD8Odb4y7chPkk2aYgppqxfQcHYpAY04+hzLWLD6/SkhtyIr1+4vqsr
 GuC70tuKK0nQdcjTrZEqrpstO4fhwWXien5+B3x2RawOzxe3+r2bFr2xAGlnT66iLGCo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9/wlY+grozIsFQ1+nb46jMvFFc36qA1xm8FqukFgFsI=; b=jyA8MVoWvv9+WWW2/1womLEkR8
 U9ts9WxQUuvJe6xgyIULsayKhfKP/tpnpDEvrjn+ykZGBCMBB9MVAh7UjswoFSf/+sXqsEJ7ufokG
 W19NBdxL545uhZSjBuGToa5io8Wd9Xech1+J23zSsC6FebcYzxbU2bggN5Syu7fQmbI8=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLR5Z-000000003BO-1Cvo for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 20:14:41 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso3106758f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2026 13:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793045671; x=1793650471; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9/wlY+grozIsFQ1+nb46jMvFFc36qA1xm8FqukFgFsI=;
 b=TWKRgCt31Ws+Mq7mOp1GBeLcKAavcAvXQ5iyq6CA+gVGm6UQ8Y86wrytfB7UakWjKl
 jtLMoC189w+CSmUfBwkrN2INm6iMZHFHpPG/RvRczwiOC/2z7HNEYy4+agyjxDlL4Sgu
 K3FODOskQxhzM1AJzEFJQ1bU5rV7Uu/wGbZxVFltfDyHtd+e3LKWX3WaJq5GenW1Vbn5
 ctlO35OE7jeuVvq7GqqCalSfeOLSJuXJBskvnPZwpuCNSiEVHfEbFvyC+1pNoTezv4O+
 rxn0pJYThNVmOtf4VNzf/Y6uT6grfgjFCoOHiXEY2f1x7YFzsNDe8m3FTeDhjauPHj+U
 DXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793045671; x=1793650471;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9/wlY+grozIsFQ1+nb46jMvFFc36qA1xm8FqukFgFsI=;
 b=bcg+OykYCyXLL7DByMe+GPCwkujEQ3F9ZGNaPrgtUWlsGNuJMzAO2Jh1j24u05v14j
 lJ7naztQsDp3FTk1vARhAtXdfADDAgCysuWOItn9NQbzItabnzl9DLJoJEeGZxja6Vi4
 DoFMKb28NxTj9C5OQ4+ElLGE/1ctwG0IR0KSgOq1BZRCS+khfg7ywmnUjPVgWMFzw7wG
 dWM1WgWAAMRTzIbXS9kBHN0/ULft+IT/g7ADBIdFbVeVEFeOqL6DmBOdOdFoMVKS+TPK
 mrVCZ2KFv74SaoM4GhKXSHwQ0xbxKP8WCcs+BGHNlR+F565/Ipv6+7PMVdPejU2F6di8
 Ec5A==
X-Gm-Message-State: AFq9FYKI1+tJun00/7vYU5xmCOqkIaCpMSkos3AJ3pE2ZsdymdxfH/iO
 a4rRCFzdBBWq+Vzx7e631zdcwVg25wQVXM3HbCbVf1i2YXSNO3NdSalI9zhSGeNH9vigZbJiBiG
 h+ivBQI9DOgeh/fLB7vcilAxREPc3fErgYdhE6xHWFaSy7fpQdjEpvsRwGiaK/7mx5xDmaIoP2j
 xu1MWSkg==
X-Gm-Gg: AYBFou30eb46LJOii11b8XxlMLAK+6TRfjUXI+aqKL7ltnn9bfQltwGR3sbvG8/+U28
 Cp/TWRq543ct26yXX+5RDWtNPIJlDIMyxGOzRp/lCRuOqXFY2XNRXgDklfioPNZEMPS3Yf+VXbQ
 d78HAZ0MNsTGIp7B1P0bhcbKaW9k7PYOc4u1QaRTBKBcV8wb0z9BH3afuNCGi2xYw3g8E5E1lts
 4pYo+bQCfoUaCAUR/bOAf4+hY2MJvldo39cZrp3MF2uHMkd62gUa5qxXtIKUIc3MqkDvW7Kn3ug
 SCHi8O69OjhL2MyQNUCVN5PC14xZPl+ZjqYXDEHug44Fj0I8QGiMrTlaIQ9OJ5wq+2E9j9eItic
 3Wxll+mtjh3+walPa1/rRS+v4Qtoe61GaKg3jxb67vU9OPrJC2yTCsusfF3Jgpq6B2aIohVntmF
 EeAC8dkN1UesXdaRrJQFd5j8knCJyHJ4TvmtothwLBCu98mhb8bu/2+ceDDiSXO24xHb2zMe34v
 UBXrEeLNjmDBudn6NdwQrOa/b/hySXYkYI5/6946qmmjF+jTrKl+f1Ojm4lE2eYN+fludTWe4/e
 bRreBJtnjvkA3lXhr1gHjePkZ3KBOCffdloO4q0A6Drs2N6QU7pmafxHvqJoDTfXUsszjMLoXyV
 kWnC6RDh9Dh+VzSBwyBOVsUx7ZuLXxw8uzgzc7SnUow==
X-Received: by 2002:a05:6000:24c8:b0:48d:f831:2681 with SMTP id
 ffacd0b85a97d-48e3eb922a2mr14541439f8f.38.1793045670562; 
 Mon, 26 Oct 2026 13:14:30 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd37f4sm21485338f8f.44.2026.10.26.13.14.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 13:14:30 -0700 (PDT)
X-Google-Original-From: "Heiko Hund (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 26 Oct 2026 20:14:29 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ifa4497963989c2d6ba68d75942d368c112ac6f67
X-Gerrit-Change-Number: 2038
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2038?usp=email>
X-Gerrit-Commit: a4627d79a6e6f81c96143f6dd38944e28de70c5e
References: <gerrit.1793045668000.Ifa4497963989c2d6ba68d75942d368c112ac6f67@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDQ1NjY4MDAwLklmYTQ0OTc5NjM5ODljMmQ2YmE2OGQ3NTk0MmQzNjhjMTEyYWM2ZjY3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7395f4fc69c3e90e899fdd6c083f153fbcb7c0ec-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xLR5Z-000000003BO-1Cvo
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: win32: pass the
 buffer size in bytes to get_openvpn_reg_value()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Heiko Hund \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: heiko@openvpn.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Heiko Hund \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0144682204099974781=="
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0144682204099974781==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="spKntX2gFwA="; charset=UTF-8

--spKntX2gFwA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2038?usp=3Demail

to review the following change=2E
=


Change subject: win32: pass the buffer size in bytes to get_openvpn_reg_v=
alue()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

win3=
2: pass the buffer size in bytes to get_openvpn_reg_value()

get_openvpn_re=
g_value() expects the size of the value buffer in bytes,
as documented and =
as RegGetValueW() expects it=2E All callers passed the
number of characters=
 instead, so only half of the buffer was used=2E

Pass sizeof() of the buff=
ers instead of _countof()=2E

Change-Id: Ifa4497963989c2d6ba68d75942d368c11=
2ac6f67
Signed-off-by: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
---
M src/=
openvpn/win32=2Ec
1 file changed, 3 insertions(+), 3 deletions(-)



  git =
pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/38/2038/1

dif=
f --git a/src/openvpn/win32=2Ec b/src/openvpn/win32=2Ec
index fde6412=2E=2E=
3af58ed 100644
--- a/src/openvpn/win32=2Ec
+++ b/src/openvpn/win32=2Ec
@@ -=
1491,7 +1491,7 @@
 set_openssl_env_vars(void)
 {
     WCHAR install_path[MA=
X_PATH] =3D { 0 };
-    if (!get_openvpn_reg_value(NULL, install_path, _cou=
ntof(install_path)))
+    if (!get_openvpn_reg_value(NULL, install_path, si=
zeof(install_path)))
     {
         const WCHAR *ssl_fallback_dir =3D L"C:=
\\Windows\\System32";
         /* if we cannot find installation path from =
the registry,
@@ -1585,8 +1585,8 @@
 
     /* Attempt to retrieve the trust=
ed plugin directory path from the registry,
      * using installation path=
 as a fallback */
-    if (!get_openvpn_reg_value(L"plugin_dir", plugin_dir=
, _countof(plugin_dir))
-        && !get_openvpn_reg_value(NULL, plugin_dir=
, _countof(plugin_dir)))
+    if (!get_openvpn_reg_value(L"plugin_dir", plu=
gin_dir, sizeof(plugin_dir))
+        && !get_openvpn_reg_value(NULL, plugi=
n_dir, sizeof(plugin_dir)))
     {
         msg(M_WARN, "Installation path =
could not be determined=2E");
     }

-- 
To view, visit https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2038?usp=3Demail
To unsubscribe, or for help writi=
ng mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail
=

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: maste=
r
Gerrit-Change-Id: Ifa4497963989c2d6ba68d75942d368c112ac6f67
Gerrit-Change=
-Number: 2038
Gerrit-PatchSet: 1
Gerrit-Owner: Heiko Hund <heiko@openvpn=2E=
net>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: A=
rne Schwabe <arne-openvpn@rfc2549=2Eorg>

--spKntX2gFwA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Heiko Hund would like Arne Sc=
hwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2038?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">win32: pass the buffer size in bytes to get_openvpn_reg_value()<b=
r><br>get_openvpn_reg_value() expects the size of the value buffer in bytes=
,<br>as documented and as RegGetValueW() expects it=2E All callers passed t=
he<br>number of characters instead, so only half of the buffer was used=2E<=
br><br>Pass sizeof() of the buffers instead of _countof()=2E<br><br>Change-=
Id: Ifa4497963989c2d6ba68d75942d368c112ac6f67<br>Signed-off-by: Heiko Hund =
&lt;heiko@ist=2Eeigentlich=2Enet&gt;<br>---<br>M src/openvpn/win32=2Ec<br>1=
 file changed, 3 insertions(+), 3 deletions(-)<br><br></pre><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">g=
it pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/38/2038/1</=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
><span>diff --git a/src/openvpn/win32=2Ec b/src/openvpn/win32=2Ec</span><br=
><span>index fde6412=2E=2E3af58ed 100644</span><br><span>--- a/src/openvpn/=
win32=2Ec</span><br><span>+++ b/src/openvpn/win32=2Ec</span><br><span>@@ -1=
491,7 +1491,7 @@</span><br><span> set_openssl_env_vars(void)</span><br><spa=
n> {</span><br><span>     WCHAR install_path[MAX_PATH] =3D { 0 };</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    if (!get_openvpn_reg_value(=
NULL, install_path, _countof(install_path)))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (!get_openvpn_reg_value(NULL, install_path,=
 sizeof(install_path)))</span><br><span>     {</span><br><span>         con=
st WCHAR *ssl_fallback_dir =3D L&quot;C:\\Windows\\System32&quot;;</span><b=
r><span>         /* if we cannot find installation path from the registry,<=
/span><br><span>@@ -1585,8 +1585,8 @@</span><br><span> </span><br><span>   =
  /* Attempt to retrieve the trusted plugin directory path from the registr=
y,</span><br><span>      * using installation path as a fallback */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!get_openvpn_reg_valu=
e(L&quot;plugin_dir&quot;, plugin_dir, _countof(plugin_dir))</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        &amp;&amp; !get_openvpn_reg_=
value(NULL, plugin_dir, _countof(plugin_dir)))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (!get_openvpn_reg_value(L&quot;plugin_dir=
&quot;, plugin_dir, sizeof(plugin_dir))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        &amp;&amp; !get_openvpn_reg_value(NULL, plugin_=
dir, sizeof(plugin_dir)))</span><br><span>     {</span><br><span>         m=
sg(M_WARN, &quot;Installation path could not be determined=2E&quot;);</span=
><br><span>     }</span><br></pre><p>To view, visit <a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2038?usp=3Demail">change 2038</a>=2E To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2038?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> G=
errit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: m=
aster </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifa4497963989c2=
d6ba68d75942d368c112ac6f67 </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Number: 2038 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div=
>
<div style=3D"display:none"> Gerrit-Owner: Heiko Hund &lt;heiko@openvpn=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--spKntX2gFwA=--


--===============0144682204099974781==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0144682204099974781==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0144682204099974781==--

