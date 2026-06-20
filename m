Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E4FCDB46B
	for <openvpn-devel@archiver.kernel.org>; Sat, 20 Jun 2026 14:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=j7khk7rYK3tswNsJGusPqrxNm8w+JjThfAfzdiHLy8w=; b=NPyfjFKQ2SfQHF
	9l0i3JSHWmA9BlyRkTmUWecZ0MydT7KwVVtkJK7AWWSC7wYuF4xgbWZhEUhrCEj7vJrq85FycUtMG
	b8JUEtThmQ2D0q/xXE3wSZ2naVcQMrlHBiW9W5Lmt/OUTRd1LctMiQwQ4TsRjL56VvN6qryAaDY8I
	kvg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wawjU-0001NV-OO;
	Sat, 20 Jun 2026 14:31:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wawjT-0001NJ-KJ
 for openvpn-devel@lists.sourceforge.net;
 Sat, 20 Jun 2026 14:31:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RBX8gnan7lF2JXB5zoZMLVR4lhflz5MAHYNz1uRx84E=; b=Y0loCvAPmVFTCFAd4BdGhNBZTI
 u3HhAmpBmKRuqzEi6GJI/0pBPRtCdRWjMcUOd/xYvSZGYjKTnxdDGlX6BeLf6eT4UlUBtTFP7IP1y
 Xo5s1irYU+ekaYagwzR7Lci6aGrYcFtijiicBw2mrlMYAaoAVfpO5dmWwpYMdr+Fb2cQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=RBX8gnan7lF2JXB5zoZMLVR4lhflz5MAHYNz1uRx84E=; b=n
 Lj6VvilDzuhoKUJP906cjH6ZxucjmPAAbva04hFbdBY0QkDXcD9hTJtG9CMrLmgwssqWsEuKXlR05
 v9+PZeLOhakNCQZ7pySOfsKucHEwnrnWBgqfIkMeCWvmjlcsiE5PrW5yTm55vNkKIDSaPjg/LLaFS
 45R2weovzYcJ3/O4=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wawjR-0004u9-Or for openvpn-devel@lists.sourceforge.net;
 Sat, 20 Jun 2026 14:31:40 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-490b64c8311so28475475e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 20 Jun 2026 07:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781965892; x=1782570692; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RBX8gnan7lF2JXB5zoZMLVR4lhflz5MAHYNz1uRx84E=;
 b=PrqNmseAf+WhbH7mN+vj7V7eg5dRr7ZY0q1AH4Pdd93pYmyqBbFA24AMSTUwiK8/yD
 e6gebciqIwXhXWmje085zsZloIYch3PEGEs0APNnafudY8EF1OB22X2yGqCj1QxhOfv8
 yatZPHMDWuJQTIoRhy7nMIiyPjNU8ZrNGn2nRrZwBVh8kELDWw7nYtBoUSp2zCNauNY1
 tExv4pQlEM5vatye9UcpwJuFt1MG4XCZ+qsQmn72rFMWtfWIWBa2dTQqcGTGP3CckEvq
 +A+M4ygm6o64WpTSn4BtUDj7/+rTwYLp2g3awqhzFZq69pLHVf9xT64guaQoA1sVwiwx
 Ytfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781965892; x=1782570692;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RBX8gnan7lF2JXB5zoZMLVR4lhflz5MAHYNz1uRx84E=;
 b=CVwykmzUoUyt/UT44u5pRCAoE9BPhsjpS8Q8vQZOTy5xe7nBQkLE8/AVSl7Zkw+oCH
 kBK54wNuiAS1d0/YaWKCKdOno3Dr4He42X8ZvfLAmIaD3urdq2LIjiij09usx1NjyGZK
 vhetXrRpwHJkg4qKezUK3+Qw2Up4JZEvb18dFu+r6Hpy8uAiZ+QemEn9X6G8xTvLAF6C
 UJsb3bQMPBLEY2e2h3kqRgzbedqv2zV8+Y49/cLWgMMx7MRsGgWfS/bX++ba5QgRH90T
 3A1CVILsZ2AzF1cYGi/HjUGzCDOnYmf8Q44WgPF3zlf1/+y0p7LavSjspQhSi4mfwjr7
 FIPQ==
X-Gm-Message-State: AOJu0YwhnF8gnfFlzC7yG6/LS+1zMKgtxtBWDJCC9fUGcdJJoeGfYOS0
 hUnzQhb35sXve0QagUN96f1rtTBfW6PEcfKbDuZentE3l2pfe6wVNSY4jqPnQFyVEMTEVcg4djH
 7ORvPDj1ueY3GRpw5k5usucRsB/4ccGPIriw45kF6zF1YK/ZKkggQ0xDGt7mZuYXAf2ZILKpIOw
 1cpbJPpQ==
X-Gm-Gg: AfdE7cnvYBQ0403/5bvzPYAmpOUXoRkLiG4A5113jqs1J0ENdvy6yu8QGcHJ+1Y+/4e
 w8QfK3Kmmo/1dzTv8a2wuROivEQHkiVXF32ohMkaRZ/wcprBfnD18Ft9jEikbqIngrRQSGNXclu
 ltlPEKK9UvjtU9VVC0SHWJDKHinSqLhX2V5nQbntV6QXrC+tywpEPu5DGjM6wPaqJmAdmBuar2C
 6fkYKK+3ox29rMkORuz6N1HA795juBS58XzI+UVMf8+VcSjjsOZI9RN67zDiYDn+RvkaxGGuyP2
 HmGKz9vWI9PT1uSSQEK+I9/T4UPrdk8SAi9scpvfdAveBQOh62tvjwISXaQ2sHbMRgCW6JxIfYc
 7YY/3r6XgFE4UQVQ2NwguOZ/KJQvxwU0cYkZzJLaDlnAV4vI4mLDxhPd3U+7juoCuWcyviykpw2
 zmEVP2IuQ7fhs40U3YEBwWzCOK11kOdID53ZtY2vRcGtp8T3gccgvd1ADDwGUeOXUqbEs527oCI
 eAG4F4kSgpMq2hXc3l9VAgCDmIPO3uF23oTsMATJHZ1sDfBbGLMC+ZC/+S20uOnfYjDBpo9EhpU
 6rg=
X-Received: by 2002:a05:600c:1588:b0:490:adb6:793d with SMTP id
 5b1f17b1804b1-49240e6c4f3mr80329895e9.26.1781965890539; 
 Sat, 20 Jun 2026 07:31:30 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-466643f4e9esm8121589f8f.1.2026.06.20.07.31.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 07:31:30 -0700 (PDT)
X-Google-Original-From: "selvanair (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 20 Jun 2026 14:31:29 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I52609b71deb8810a3fea639494b5fa13d9e5a493
X-Gerrit-Change-Number: 1714
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1714?usp=email>
X-Gerrit-Commit: e34dc4e6dfe7657b690f015d88c570214f9f9dd6
References: <gerrit.1781965887000.I52609b71deb8810a3fea639494b5fa13d9e5a493@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgxOTY1ODg3MDAwLkk1MjYwOWI3MWRlYjg4MTBhM2ZlYTYzOTQ5NGI1ZmExM2Q5ZTVhNDkzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <793d0ffa08aaeea4337beb8012498e23112f1d05-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wawjR-0004u9-Or
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Whitelist configs in
 autostart_config_dir
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
From: "selvanair \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: selva.nair@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "selvanair \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3355509619816676822=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3355509619816676822==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IBbMnbjNCcw="; charset=UTF-8

--IBbMnbjNCcw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1714?usp=3Demail

to review the following change=2E


Chang=
e subject: Whitelist configs in autostart_config_dir
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Whitelist configs in autostart_con=
fig_dir

We currently whitelist these configs by checking that the user is
=
NT Service\<ovpn_service_user>, which defaults to OpenVPNService=2E
In some=
 setups one may need to change this service user to, say,
NT Authority\Loca=
l Service, in which case the validation fails=2E

Make it easier to change =
the service user by whitelisting all
configs in autostart_config_dir=2E

Se=
e also: Github OpenVPN/openvpn#1056

Change-Id: I52609b71deb8810a3fea639494=
b5fa13d9e5a493
---
M src/openvpnserv/common=2Ec
M src/openvpnserv/service=
=2Eh
M src/openvpnserv/validate=2Ec
3 files changed, 10 insertions(+), 2 de=
letions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/ch=
anges/14/1714/1

diff --git a/src/openvpnserv/common=2Ec b/src/openvpnserv/=
common=2Ec
index 7fc8c14=2E=2E5db5891 100644
--- a/src/openvpnserv/common=
=2Ec
+++ b/src/openvpnserv/common=2Ec
@@ -115,6 +115,13 @@
         goto ou=
t;
     }
 
+    swprintf(default_value, _countof(default_value), L"%ls\\co=
nfig-auto\\", install_path);
+    error =3D GetRegString(key, L"autostart_c=
onfig_dir", s->autostart_config_dir, sizeof(s->autostart_config_dir), defau=
lt_value);
+    if (error !=3D ERROR_SUCCESS || !ensure_trailing_backslash(=
s->autostart_config_dir, _countof(s->autostart_config_dir)))
+    {
+      =
  goto out;
+    }
+
     swprintf(default_value, _countof(default_value), =
L"%ls\\bin\\", install_path);
     error =3D GetRegString(key, L"bin_dir", =
s->bin_dir, sizeof(s->bin_dir), default_value);
     if (error !=3D ERROR_S=
UCCESS || !ensure_trailing_backslash(s->bin_dir, _countof(s->bin_dir)))
dif=
f --git a/src/openvpnserv/service=2Eh b/src/openvpnserv/service=2Eh
index c=
67d67f=2E=2E9ef9744 100644
--- a/src/openvpnserv/service=2Eh
+++ b/src/open=
vpnserv/service=2Eh
@@ -65,6 +65,7 @@
 {
     WCHAR exe_path[MAX_PATH];
   =
  WCHAR config_dir[MAX_PATH];
+    WCHAR autostart_config_dir[MAX_PATH];
  =
   WCHAR bin_dir[MAX_PATH];
     WCHAR ext_string[16];
     WCHAR log_dir[M=
AX_PATH];
diff --git a/src/openvpnserv/validate=2Ec b/src/openvpnserv/valid=
ate=2Ec
index 5cf8325=2E=2E8f7adcd 100644
--- a/src/openvpnserv/validate=2E=
c
+++ b/src/openvpnserv/validate=2Ec
@@ -54,7 +54,7 @@
 static PTOKEN_GROUP=
S GetTokenGroups(const HANDLE token);
 
 /*
- * Check that config path is i=
nside config_dir
+ * Check that config path is inside config_dir or autosta=
rt_config_dir
  * The logic here is simple: if the path isn't prefixed with=
 config_dir it's rejected
  */
 static BOOL
@@ -78,7 +78,7 @@
         res =
=3D PathCchCanonicalize(config_path, _countof(config_path), fname);
     }
=
 
-    return res =3D=3D S_OK && wcsnicmp(config_path, s->config_dir, wcsle=
n(s->config_dir)) =3D=3D 0;
+    return res =3D=3D S_OK && (wcsnicmp(config=
_path, s->config_dir, wcslen(s->config_dir)) =3D=3D 0 || wcsnicmp(config_pa=
th, s->autostart_config_dir, wcslen(s->autostart_config_dir)) =3D=3D 0);
 }=

 
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1714?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Ger=
rit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I52609b71deb88=
10a3fea639494b5fa13d9e5a493
Gerrit-Change-Number: 1714
Gerrit-PatchSet: 1
G=
errit-Owner: selvanair <selva=2Enair@gmail=2Ecom>
Gerrit-Reviewer: plaistho=
s <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@list=
s=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2E=
org>

--IBbMnbjNCcw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>selvanair would like plaisthos t=
o <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1714?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Whitelist configs in autostart_config_dir<br><br>We currently whitelist=
 these configs by checking that the user is<br>NT Service\&lt;ovpn_service_=
user&gt;, which defaults to OpenVPNService=2E<br>In some setups one may nee=
d to change this service user to, say,<br>NT Authority\Local Service, in wh=
ich case the validation fails=2E<br><br>Make it easier to change the servic=
e user by whitelisting all<br>configs in autostart_config_dir=2E<br><br>See=
 also: Github OpenVPN/openvpn#1056<br><br>Change-Id: I52609b71deb8810a3fea6=
39494b5fa13d9e5a493<br>---<br>M src/openvpnserv/common=2Ec<br>M src/openvpn=
serv/service=2Eh<br>M src/openvpnserv/validate=2Ec<br>3 files changed, 10 i=
nsertions(+), 2 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerr=
it=2Eopenvpn=2Enet:29418/openvpn refs/changes/14/1714/1</pre><pre style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git =
a/src/openvpnserv/common=2Ec b/src/openvpnserv/common=2Ec</span><br><span>i=
ndex 7fc8c14=2E=2E5db5891 100644</span><br><span>--- a/src/openvpnserv/comm=
on=2Ec</span><br><span>+++ b/src/openvpnserv/common=2Ec</span><br><span>@@ =
-115,6 +115,13 @@</span><br><span>         goto out;</span><br><span>     }=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   swprintf(default_value, _countof(default_value), L&quot;%ls\\config-auto=
\\&quot;, install_path);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    error =3D GetRegString(key, L&quot;autostart_config_dir&quot;, s-&=
gt;autostart_config_dir, sizeof(s-&gt;autostart_config_dir), default_value)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (error !=3D=
 ERROR_SUCCESS || !ensure_trailing_backslash(s-&gt;autostart_config_dir, _c=
ountof(s-&gt;autostart_config_dir)))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        goto out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan>     swprintf(default_value, _countof(default_value), L&quot;%ls\\bin\\=
&quot;, install_path);</span><br><span>     error =3D GetRegString(key, L&q=
uot;bin_dir&quot;, s-&gt;bin_dir, sizeof(s-&gt;bin_dir), default_value);</s=
pan><br><span>     if (error !=3D ERROR_SUCCESS || !ensure_trailing_backsla=
sh(s-&gt;bin_dir, _countof(s-&gt;bin_dir)))</span><br><span>diff --git a/sr=
c/openvpnserv/service=2Eh b/src/openvpnserv/service=2Eh</span><br><span>ind=
ex c67d67f=2E=2E9ef9744 100644</span><br><span>--- a/src/openvpnserv/servic=
e=2Eh</span><br><span>+++ b/src/openvpnserv/service=2Eh</span><br><span>@@ =
-65,6 +65,7 @@</span><br><span> {</span><br><span>     WCHAR exe_path[MAX_P=
ATH];</span><br><span>     WCHAR config_dir[MAX_PATH];</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    WCHAR autostart_config_dir[MAX_PATH]=
;</span><br><span>     WCHAR bin_dir[MAX_PATH];</span><br><span>     WCHAR =
ext_string[16];</span><br><span>     WCHAR log_dir[MAX_PATH];</span><br><sp=
an>diff --git a/src/openvpnserv/validate=2Ec b/src/openvpnserv/validate=2Ec=
</span><br><span>index 5cf8325=2E=2E8f7adcd 100644</span><br><span>--- a/sr=
c/openvpnserv/validate=2Ec</span><br><span>+++ b/src/openvpnserv/validate=
=2Ec</span><br><span>@@ -54,7 +54,7 @@</span><br><span> static PTOKEN_GROUP=
S GetTokenGroups(const HANDLE token);</span><br><span> </span><br><span> /*=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Check that config =
path is inside config_dir</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * Check that config path is inside config_dir or autostart_config_di=
r</span><br><span>  * The logic here is simple: if the path isn&#39;t prefi=
xed with config_dir it&#39;s rejected</span><br><span>  */</span><br><span>=
 static BOOL</span><br><span>@@ -78,7 +78,7 @@</span><br><span>         res=
 =3D PathCchCanonicalize(config_path, _countof(config_path), fname);</span>=
<br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    return res =3D=3D S_OK &amp;&amp; wcsnicmp(config_path, s-=
&gt;config_dir, wcslen(s-&gt;config_dir)) =3D=3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return res =3D=3D S_OK &amp;&amp; (wc=
snicmp(config_path, s-&gt;config_dir, wcslen(s-&gt;config_dir)) =3D=3D 0 ||=
 wcsnicmp(config_path, s-&gt;autostart_config_dir, wcslen(s-&gt;autostart_c=
onfig_dir)) =3D=3D 0);</span><br><span> }</span><br><span> </span><br><span=
> </span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1714?usp=3Demail">change 1714</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1714?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I52609b71deb8810=
a3fea639494b5fa13d9e5a493 </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 1714 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>=

<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva=2Enair@gmai=
l=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>

</body></html>
--IBbMnbjNCcw=--


--===============3355509619816676822==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3355509619816676822==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3355509619816676822==--

