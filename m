Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC14BC43458
	for <openvpn-devel@archiver.kernel.org>; Thu,  9 Jul 2026 15:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=56Y77s0yXdSLOCb2xOtX5Vynpa0nbXAt/tCIfJERf6Q=; b=YaQ8gGnCKuABGI
	tnzUg8LKz7yNDBT6JZdXQ3WQ/m7gDrG88edR4E729LnYVLMBvYxZRpTqtQQChSUFu5gJW/BzNp9gt
	wxj5LnCM2ObtxIVBm9vPfRUvrTyZQTgWCxGRxIxeMUryThFSMJ47qMc0M91mZ4f1nb1ZMSn10oE36
	FJQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1whqmo-0007dH-Bf;
	Thu, 09 Jul 2026 15:35:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1whqmn-0007dB-6y
 for openvpn-devel@lists.sourceforge.net;
 Thu, 09 Jul 2026 15:35:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5NfKuuv0fLfHuOKN3naxEuqe2adCX71RMPDc33ycYJk=; b=e3RDZK0R7QgslCegn72pklECmD
 BYD1ftcuDRRlehb9M3AHF5/rW3iy8v0lX/UvoxeE50tSozhApdnfJWyYb63b4LhWTiBVWeRARF55K
 J9KR2ppwyvRlFiHpWCqItFj9q9XOwleqVG0Bkn43LrlmE8vueRn9FdbvMVJetw9svXAA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=5NfKuuv0fLfHuOKN3naxEuqe2adCX71RMPDc33ycYJk=; b=X
 0TRJ/nE/gV7CeXQ70s9UmQRs2uOKEFId8mDoXZRg6pHiO5fgMMqM6vQRUi9+HfbdW5fHuYQwER26e
 P8/8cBsKzMBHn2m6z+GSD/mV9hDyGHbLeneMbbFu/vgEZivYaCmjt1z6SV0cIaUtZZxx2ZB8BG+fP
 Sbn9/HQiBDnC8doY=;
Received: from mail-ej1-f50.google.com ([209.85.218.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1whqml-0000I7-R7 for openvpn-devel@lists.sourceforge.net;
 Thu, 09 Jul 2026 15:35:37 +0000
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-c15f6d667bcso4728566b.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 09 Jul 2026 08:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783611329; x=1784216129; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5NfKuuv0fLfHuOKN3naxEuqe2adCX71RMPDc33ycYJk=;
 b=R9rE1gpi7E307r7n8Ca1oDMdNJ2mPCb+y7PKa6HLHl0pVo1VPitz9H8dDWmQ9EfxIa
 lJnDuDHoic7c0hFlsBFGO9Y+izpOGt1d/UNj2ZwKimmVg87hIqiH/zXdSQk9JMNa7Tn9
 VPphQzzmlpFaaFiNa/qUEd7zCUPkDkVpMj6JFSfqzJYSLUV6fWPASeDL+AmC7CaEmD4W
 y831lEzlz1DOJfyoeDk0giw2ShSPcYc03k+2+9igvaanO5ig+WZf+6CRXbMfs+JKyTAa
 VUB4SWCf3AyoJXC5aBICrCva1ynjx8UTZIbd7EnFL2AG91rCZVyGkWm9UdrzCq/qu1zJ
 Dn/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783611329; x=1784216129;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5NfKuuv0fLfHuOKN3naxEuqe2adCX71RMPDc33ycYJk=;
 b=ssX1ehE5w31NHd8PQJJQCEG1oNMVZ4C4vtMks/K9HTSzGaN9ddjVWoSP8RvzCEyLwy
 qsO0pvh2Cv69KvtHXqgaMeqBg6GnglQlRGKuGYPrE73atCXpXR6JU1U36ad8rgAKSvO1
 WrvhrajUd2l9hC9apeQHjRjSVe9nRQtg71KS9Zsko6+oLsCiuoL4e7wx9LLeUn/bjrUP
 qRiZeHfjm+NCBRno1w4jkBTZJ5PvRGFGzQhSwHxqqep9YrFyG0fgJOio+95BlOeeha0y
 OvVSN+kSgg6wrS9dd0ionWxf6Umb9r7YhsWihh5t0wK9B47/OLS8TCjlf+9icJeBdECA
 Z3Mg==
X-Gm-Message-State: AOJu0Yzf2reS9dqXC0DU53o1dEp54XJFTCv9zo7mWjdcBIDkqg5XW98t
 e6oo6t7NLqLxFHINLHgw46ery0bKDd5pe4L0IJilGGprAbZBL85j0mzqTvXsVCm8nStC2FxEhf+
 TAY9xjzz2+FiL2WmOkF+ynQlg7zCfjvm7SZ69wfQX2I1uJcPJuL3wbP3pjj96FLlQdGoLpOrKC1
 phLudF+w==
X-Gm-Gg: AfdE7clr1gf3xGWoJCJelHrqzRlq6q1QdAFxl1M+C16eekOcHYh/mG4TLe2F5UFXmfu
 a9N81LAkkLsHYxY9s0nvPQ8bV6NMc/fStf8AADG1kNG/ebmUemHPjkDRMif0U2mPOPQI6HMIBSJ
 Fjw1m8l4XeOwI8nIgWJimK+gihoAi8DWGM9u+cq/lS/yusZeqvyICD187DjnTF9RI5EmcsTdJIg
 2UEgA2GCDZcsWCRzXdPcZoLQvBw/173SWc0GsNoEpSFX5z2ro7lziDzThfDP8FwYKEdkstFqobv
 YcgSb+Gr+WE4XOvi5qZXlAjtzs5Mybe0UAmAQIwc7u4e++adlizFBWnNvNC9CH9wXIyIHkADLhz
 1UhJIPJXz+vJbg/p5Qh2w47AcEx/J7t/fx9aOsgT0DYsIg+r/j3IBYUnvBwNEpv0swUU0jHlLoD
 4nlLeF6z8JSLN5IPWfYMUQfGdF61LdmZLo18HfPg+MyPD7nsl9P5tyq8BByzb3uZlpsnjzYDVtU
 GvCGQe0toJaZrhqnE/2a89rRrko+ylJiZ1elymA9UdDh30tigyLgcuzYpkJdjD2c0veqkEIhotw
 7i0=
X-Received: by 2002:a05:6000:2c06:b0:475:f100:3607 with SMTP id
 ffacd0b85a97d-47df081c95bmr7821039f8f.54.1783600914169; 
 Thu, 09 Jul 2026 05:41:54 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039ae44sm49095756f8f.23.2026.07.09.05.41.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 05:41:53 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 9 Jul 2026 12:41:53 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I09ad0d9baaa7351eecb5aafdb5c6e7b47cf7c909
X-Gerrit-Change-Number: 1775
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1775?usp=email>
X-Gerrit-Commit: 1e3604a608de45832008b30989cbbec33a48db98
References: <gerrit.1783600902000.I09ad0d9baaa7351eecb5aafdb5c6e7b47cf7c909@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzNjAwOTAyMDAwLkkwOWFkMGQ5YmFhYTczNTFlZWNiNWFhZmRiNWM2ZTdiNDdjZjdjOTA5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b8d6d2335a579809a11a6f08f0a3ceade56cf450-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1whqml-0000I7-R7
Subject: [Openvpn-devel] [M] Change in openvpn[master]: options: Move string
 utility functions to buffer
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6279899766173181258=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6279899766173181258==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SS/IaheHUWc="; charset=UTF-8

--SS/IaheHUWc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1775?usp=3Demail

to review the following change=2E


Chang=
e subject: options: Move string utility functions to buffer
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

options: Move string utility=
 functions to buffer

buffer seems to be where we collect string utility
fu=
nctions, so move them out of options=2E

Change-Id: I09ad0d9baaa7351eecb5aa=
fdb5c6e7b47cf7c909
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Eco=
m>
---
M src/openvpn/buffer=2Ec
M src/openvpn/buffer=2Eh
M src/openvpn/opti=
ons=2Ec
M src/openvpn/options=2Eh
4 files changed, 35 insertions(+), 34 del=
etions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/cha=
nges/75/1775/1

diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2E=
c
index 2f4d037=2E=2E6531f3e 100644
--- a/src/openvpn/buffer=2Ec
+++ b/src/=
openvpn/buffer=2Ec
@@ -1142,6 +1142,38 @@
 }
 
 bool
+string_defined_equal(=
const char *s1, const char *s2)
+{
+    if (s1 && s2)
+    {
+        retur=
n !strcmp(s1, s2);
+    }
+    else
+    {
+        return false;
+    }
+}=

+
+char *
+string_substitute(const char *src, char from, char to, struct g=
c_arena *gc)
+{
+    char *ret =3D (char *)gc_malloc(strlen(src) + 1, true,=
 gc);
+    char *dest =3D ret;
+    char c;
+
+    do
+    {
+        c =3D=
 *src++;
+        if (c =3D=3D from)
+        {
+            c =3D to;
+   =
     }
+        *dest++ =3D c;
+    } while (c);
+    return ret;
+}
+
+boo=
l
 checked_snprintf(char *str, size_t size, const char *format, =2E=2E=2E)
=
 {
     va_list arglist;
diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/=
buffer=2Eh
index 9bdb36a=2E=2E2776bfc 100644
--- a/src/openvpn/buffer=2Eh
+=
++ b/src/openvpn/buffer=2Eh
@@ -952,6 +952,9 @@
     return 0 =3D=3D strncm=
p(str, prefix, strlen(prefix));
 }
 
+bool string_defined_equal(const char =
*s1, const char *s2);
+char *string_substitute(const char *src, char from, =
char to, struct gc_arena *gc);
+
 /**
  * Like snprintf() but returns an bo=
olean=2E
  *
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec=

index 03cda5a=2E=2Ea95b6e0 100644
--- a/src/openvpn/options=2Ec
+++ b/src/=
openvpn/options=2Ec
@@ -1101,25 +1101,6 @@
     return get_ipv6_addr(ipv6_p=
refix_spec, NULL, NULL, M_WARN);
 }
 
-static char *
-string_substitute(con=
st char *src, char from, char to, struct gc_arena *gc)
-{
-    char *ret =
=3D (char *)gc_malloc(strlen(src) + 1, true, gc);
-    char *dest =3D ret;
=
-    char c;
-
-    do
-    {
-        c =3D *src++;
-        if (c =3D=3D =
from)
-        {
-            c =3D to;
-        }
-        *dest++ =3D c;
=
-    } while (c);
-    return ret;
-}
-
 /**
  * Parses a hexstring and che=
cks if the string has the correct length=2E Return
  * a verify_hash_list c=
ontaining the parsed hash string=2E
@@ -3574,19 +3555,6 @@
     }
 }
 
-boo=
l
-string_defined_equal(const char *s1, const char *s2)
-{
-    if (s1 && s=
2)
-    {
-        return !strcmp(s1, s2);
-    }
-    else
-    {
-       =
 return false;
-    }
-}
-
 #if 0
 static void
 ping_rec_err(msglvl_t msgle=
vel)
diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh
index d=
950a67=2E=2E90a422b 100644
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/=
options=2Eh
@@ -896,8 +896,6 @@
 
 void setenv_settings(struct env_set *es,=
 const struct options *o);
 
-bool string_defined_equal(const char *s1, con=
st char *s2);
-
 void options_postprocess(struct options *options, struct e=
nv_set *es);
 
 bool options_postprocess_pull(struct options *o, struct env=
_set *es);

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/17=
75?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchan=
ge
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I09ad0d9=
baaa7351eecb5aafdb5c6e7b47cf7c909
Gerrit-Change-Number: 1775
Gerrit-PatchSe=
t: 1
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: =
plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-de=
vel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rf=
c2549=2Eorg>

--SS/IaheHUWc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1775?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">options: Move string utility functions to buffer<br><br>buffer seems t=
o be where we collect string utility<br>functions, so move them out of opti=
ons=2E<br><br>Change-Id: I09ad0d9baaa7351eecb5aafdb5c6e7b47cf7c909<br>Signe=
d-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M src=
/openvpn/buffer=2Ec<br>M src/openvpn/buffer=2Eh<br>M src/openvpn/options=2E=
c<br>M src/openvpn/options=2Eh<br>4 files changed, 35 insertions(+), 34 del=
etions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:=
29418/openvpn refs/changes/75/1775/1</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/buffe=
r=2Ec b/src/openvpn/buffer=2Ec</span><br><span>index 2f4d037=2E=2E6531f3e 1=
00644</span><br><span>--- a/src/openvpn/buffer=2Ec</span><br><span>+++ b/sr=
c/openvpn/buffer=2Ec</span><br><span>@@ -1142,6 +1142,38 @@</span><br><span=
> }</span><br><span> </span><br><span> bool</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+string_defined_equal(const char *s1, const char *s2=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (s1 &amp;&amp; s2)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        return !strcmp(s1, s2);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        return false;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+char *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+string_substitute(const char *src, char from, char to, str=
uct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *ret =3D (c=
har *)gc_malloc(strlen(src) + 1, true, gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    char *dest =3D ret;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    char c;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        c =3D *src++;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (c =3D=3D fro=
m)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            c =3D to;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        *dest++ =3D c;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    } while (c);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+b=
ool</span><br><span> checked_snprintf(char *str, size_t size, const char *f=
ormat, =2E=2E=2E)</span><br><span> {</span><br><span>     va_list arglist;<=
/span><br><span>diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2E=
h</span><br><span>index 9bdb36a=2E=2E2776bfc 100644</span><br><span>--- a/s=
rc/openvpn/buffer=2Eh</span><br><span>+++ b/src/openvpn/buffer=2Eh</span><b=
r><span>@@ -952,6 +952,9 @@</span><br><span>     return 0 =3D=3D strncmp(st=
r, prefix, strlen(prefix));</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+bool string_defined_equal(cons=
t char *s1, const char *s2);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+char *string_substitute(const char *src, char from, char to, struc=
t gc_arena *gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span> /**</span><br><span>  * Like snprintf() but returns an boole=
an=2E</span><br><span>  *</span><br><span>diff --git a/src/openvpn/options=
=2Ec b/src/openvpn/options=2Ec</span><br><span>index 03cda5a=2E=2Ea95b6e0 1=
00644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/s=
rc/openvpn/options=2Ec</span><br><span>@@ -1101,25 +1101,6 @@</span><br><sp=
an>     return get_ipv6_addr(ipv6_prefix_spec, NULL, NULL, M_WARN);</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-static char *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
string_substitute(const char *src, char from, char to, struct gc_arena *gc)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    char *ret =3D (char *)gc_malloc(strle=
n(src) + 1, true, gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    char *dest =3D ret;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    char c;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    do</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        c =3D *src++;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        if (c =3D=3D from)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            c =3D to;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     *dest++ =3D c;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  } while (c);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret=
urn ret;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /**</span><br><=
span>  * Parses a hexstring and checks if the string has the correct length=
=2E Return</span><br><span>  * a verify_hash_list containing the parsed has=
h string=2E</span><br><span>@@ -3574,19 +3555,6 @@</span><br><span>     }</=
span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-str=
ing_defined_equal(const char *s1, const char *s2)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if (s1 &amp;&amp; s2)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    return !strcmp(s1, s2);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        return false;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span> #if 0</span><br><span> static void</span><br><span> ping_=
rec_err(msglvl_t msglevel)</span><br><span>diff --git a/src/openvpn/options=
=2Eh b/src/openvpn/options=2Eh</span><br><span>index d950a67=2E=2E90a422b 1=
00644</span><br><span>--- a/src/openvpn/options=2Eh</span><br><span>+++ b/s=
rc/openvpn/options=2Eh</span><br><span>@@ -896,8 +896,6 @@</span><br><span>=
 </span><br><span> void setenv_settings(struct env_set *es, const struct op=
tions *o);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-bool string_defined_equal(const char *s1, const char *s2);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void options_=
postprocess(struct options *options, struct env_set *es);</span><br><span> =
</span><br><span> bool options_postprocess_pull(struct options *o, struct e=
nv_set *es);</span><br><span></span><br></pre><p>To view, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1775?usp=3Demail">change 1775</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1775?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:=
none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-B=
ranch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I09ad0d=
9baaa7351eecb5aafdb5c6e7b47cf7c909 </div>
<div style=3D"display:none"> Gerr=
it-Change-Number: 1775 </div>
<div style=3D"display:none"> Gerrit-PatchSet:=
 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank=
@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--SS/IaheHUWc=--


--===============6279899766173181258==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6279899766173181258==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6279899766173181258==--

