Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB2BC5DF7E
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oPSRezAsfCStZARBupkmtUaQWclUT8Dy4e+M9yQI89c=; b=N2G7LdVhDHQN6N/vSLHItO1pIr
	SSwxaoSx+liwOco+jb++6Adva2CzWPQ5LXAonvjdbTbuO9o+oy09NDFMHc5m9f9lO/EMzDCJ9B+Ic
	vYGB7eTkTusB14ehrZRviuxXJmC591A4gt+G/163AOp6iNPsCZgBlXfieoCUIYuwNSU4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvw94-0004xh-Fk;
	Mon, 17 Aug 2026 12:08:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wvw93-0004xb-5I
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 12:08:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=OEGOU0JkcNLbvvA931wy0IVv0Zxhu7465FhhqTsgCtc=; b=jGvtQkgM3OhpceLDDbs26A22Pw
 8iW6kwVIaAGvx9qE83TNgOYiUFCcOq0g7Lyl15L0WyxxlYXP5fkVgIFVlqD6zrSjMzutR0BVbB3q1
 6J4jVWmgbXSF20nuNo5H45wZXrXxpDUyaWOhJoEK9aFI3rZGA4+3H8XEbVmp+W/955IQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=OEGOU0JkcNLbvvA931wy0IVv0Zxhu7465FhhqTsgCtc=; b=c
 ZWV8VUkhfuMbtrxi8J4+MioPH1uebJ6ZM7aDU8LccBLQiQvjmoSSIVX2cIpqNrboWabbgw0i93dXp
 iEx5G9Rj94DRYZp7HqV6Dhek3LWY/hvgfml+WG9tr0p+ebk/97q+lCVMhQCVvwNOZRJ5bSDoM9ral
 LcF3IQnWTA9ODjZQ=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wvw95-0001pP-Rx for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 12:08:49 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4998590d392so35508635e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 05:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786968522; x=1787573322; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OEGOU0JkcNLbvvA931wy0IVv0Zxhu7465FhhqTsgCtc=;
 b=XPiVP+TyFMy4ymKILLshP4v6eKH+eNRTc6uq+4jGkMAowfVDVBhCat2BBCE4bVvWDW
 uNRiAQoWsmpmy72M3EwtM2zSqj8/us2wxpYbBqNZVJJZfrW39whpvoxvKyVaqauZGJ9v
 kyfuO9UJQJ8Fa+YJVG84SgtDEDs/SYjSO+e3FKdTfaFxb68JECYAHp7Nw8o8DW1twcFM
 Blpw9o4ffhHIwJzg1TLTc7lrx137FjWZ+tpSultr4ttPSSBCshMtIMgnipa4yp80O0Yq
 ISrqeUfEJQ8qqynJReSAB6W6hc7b/SjdpBIEA6gAFVH+OJBDWtd9fle+a7EBoRbuC2JK
 hbaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786968522; x=1787573322;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=OEGOU0JkcNLbvvA931wy0IVv0Zxhu7465FhhqTsgCtc=;
 b=ebt1lPMQgdk/Zq9TxHDNOdPM2RobYitU5nAplT8KGM+HwgYbH4327GnmNPTApmQxNQ
 kZS42NhC5IddPnK94nA7InOfeG4L86bY/1fVX8nSBKshsBlPSmolxkkz1TkVronczriA
 lplPQ+G7eKx59M/fAEnogZuDUnGM71eLwC6sYc//mkwL7TB7+r5Ovt0G4BaCB50n43lG
 I2r6s+A+4eYufCfwu/w06Jaf3YZXbjSFzUsO8+5+iywW9sgZnlPC31vgve8MNDeu/U6h
 AWeBtv99w7EVkMc0w30VtdAAUDGAdOV2H/Oaxh0MdhtTLMLgtj1KqTvZ5sH/C6dm++pD
 EfVA==
X-Gm-Message-State: AOJu0YxZZRaoXXv1w3wyHkhB9SmfinRu3Ms3YmBtKVz5QMFkwPCGsDGt
 zf9zisU7m30IJWG2Jg00Uj/nTh6IaY4MF6EWBjm2ObobngTGANUvoSWxXjbQ9BvTS3mzFG1becY
 nC6fm9Ibv/t5Caf+a+lz+yrX/vghE3oQEqe+HRWJKs7QrHpJM45xEoPUfLNC40NcSwHckUK9Z/4
 jxsasz3A==
X-Gm-Gg: AR+sD11+6311JzA5AJIEeIufGGIaBw7I840Y4LmYjuNbWVlV6q3fd7bPjU6euPGNTt+
 Qzcr9MYT3IDTTy6ZVpvDtTN1nCrVrl6IVoOa8eFVYil3ntkgld/rzLcplPerlzUDCQznBryGuhG
 OeLUyJnptoQ3xaqlwwnuW3dO/9BybwqnNjavRJP579W+ryfuRn7mKEbqRR6P7sGmIdhnNPxO06X
 LcQJFMMEl6AgFo6134JIKdZc0u0C+oPWMOo0+H+ch0oHDEOjmOISFvg/MhTE8UOIeGWchkMPKRJ
 o/XWUS43ycxJTPas/LQmDAJo+GLQ38sUuWjhUB504DEe2i7IL8VvZlYjuMt7KcnMXK/BnUORe+3
 lX0D12H2gwawMaHW0INUuAzfO9O594LPYYTxH1p0PVMgNhhPPqPJf8yUKgNHiLm7UnpDMll6wMo
 b1j2cddkrSDLh+hH6e543wSW4VBuFHqSUdrL6tKwPIQg4kabQ/6+bPS/V5/tuwJsbyMXNXLq6aa
 TRjERjOq+mRRffuqBLsYtxUh00QWMArzITxlGkqlNqozGWG7Hrl8FNgbpCiSQamAZ3dq7CbZCgX
 ZNGvFzwHhK6zZ3ejQZa4dF5HzpWqEyPXKbjM1GtesPrClOLAjZE=
X-Received: by 2002:a05:600c:3113:b0:499:83f1:398 with SMTP id
 5b1f17b1804b1-49987977373mr338520945e9.9.1786968520498; 
 Mon, 17 Aug 2026 05:08:40 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999d06167csm37830805e9.3.2026.08.17.05.08.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 05:08:40 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 17 Aug 2026 12:08:15 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I09ad0d9baaa7351eecb5aafdb5c6e7b47cf7c909
X-Gerrit-Change-Number: 1775
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1775?usp=email>
X-Gerrit-Commit: fbc7c22c0298983a1fd66591b87b04edd465799c
In-Reply-To: <gerrit.1783600902000.I09ad0d9baaa7351eecb5aafdb5c6e7b47cf7c909@gerrit.openvpn.net>
References: <gerrit.1783600902000.I09ad0d9baaa7351eecb5aafdb5c6e7b47cf7c909@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzNjAwOTAyMDAwLkkwOWFkMGQ5YmFhYTczNTFlZWNiNWFhZmRiNWM2ZTdiNDdjZjdjOTA5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ddf5de585a146d5b89a5a045c2adb75eb9721270-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wvw95-0001pP-Rx
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1723239021551156441=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1723239021551156441==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3NpkyIGKHwg="; charset=UTF-8

--3NpkyIGKHwg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello pla=
isthos, razvanc, 

I'd like you to reexamine a change=2E Please visit

    =
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1775?usp=3Demail

to look at the =
new patch set (#3)=2E

The change is no longer submittable: checks~ChecksSu=
bmitRule is unsatisfied now=2E


Change subject: options: Move string utili=
ty functions to buffer
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

options: Move string utility functions to buffer

buffer seems t=
o be where we collect string utility
functions, so move them out of options=
=2E

Change-Id: I09ad0d9baaa7351eecb5aafdb5c6e7b47cf7c909
Signed-off-by: Fr=
ank Lichtenheld <frank@lichtenheld=2Ecom>
---
M src/openvpn/buffer=2Ec
M sr=
c/openvpn/buffer=2Eh
M src/openvpn/options=2Ec
M src/openvpn/options=2Eh
4 =
files changed, 35 insertions(+), 34 deletions(-)


  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/75/1775/3

diff --git a/src/ope=
nvpn/buffer=2Ec b/src/openvpn/buffer=2Ec
index 87d3094=2E=2Ea004b60 100644
=
--- a/src/openvpn/buffer=2Ec
+++ b/src/openvpn/buffer=2Ec
@@ -1086,6 +1086,=
38 @@
 }
 
 bool
+string_defined_equal(const char *s1, const char *s2)
+{
+=
    if (s1 && s2)
+    {
+        return !strcmp(s1, s2);
+    }
+    else
=
+    {
+        return false;
+    }
+}
+
+char *
+string_substitute(const =
char *src, char from, char to, struct gc_arena *gc)
+{
+    char *ret =3D (=
char *)gc_malloc(strlen(src) + 1, true, gc);
+    char *dest =3D ret;
+    =
char c;
+
+    do
+    {
+        c =3D *src++;
+        if (c =3D=3D from)=

+        {
+            c =3D to;
+        }
+        *dest++ =3D c;
+    =
} while (c);
+    return ret;
+}
+
+bool
 checked_snprintf(char *str, size_=
t size, const char *format, =2E=2E=2E)
 {
     va_list arglist;
diff --git =
a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh
index 81e247b=2E=2Eab8c23=
9 100644
--- a/src/openvpn/buffer=2Eh
+++ b/src/openvpn/buffer=2Eh
@@ -1766=
,6 +1766,9 @@
     return 0 =3D=3D strncmp(str, prefix, strlen(prefix));
 }=

 
+bool string_defined_equal(const char *s1, const char *s2);
+char *strin=
g_substitute(const char *src, char from, char to, struct gc_arena *gc);
+
 =
/**
  * Like snprintf() but returns an boolean=2E
  *
diff --git a/src/open=
vpn/options=2Ec b/src/openvpn/options=2Ec
index 3382138=2E=2E74b1f25 100644=

--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -1104,25 +1=
104,6 @@
     return get_ipv6_addr(ipv6_prefix_spec, NULL, NULL, M_WARN);
 =
}
 
-static char *
-string_substitute(const char *src, char from, char to, =
struct gc_arena *gc)
-{
-    char *ret =3D (char *)gc_malloc(strlen(src) + =
1, true, gc);
-    char *dest =3D ret;
-    char c;
-
-    do
-    {
-     =
   c =3D *src++;
-        if (c =3D=3D from)
-        {
-            c =3D =
to;
-        }
-        *dest++ =3D c;
-    } while (c);
-    return ret;
-=
}
-
 /**
  * Parses a hexstring and checks if the string has the correct le=
ngth=2E Return
  * a verify_hash_list containing the parsed hash string=2E
=
@@ -3582,19 +3563,6 @@
     }
 }
 
-bool
-string_defined_equal(const char *=
s1, const char *s2)
-{
-    if (s1 && s2)
-    {
-        return !strcmp(s1=
, s2);
-    }
-    else
-    {
-        return false;
-    }
-}
-
 #if 0
 s=
tatic void
 ping_rec_err(msglvl_t msglevel)
diff --git a/src/openvpn/option=
s=2Eh b/src/openvpn/options=2Eh
index 0fd505a=2E=2Ec23d0b3 100644
--- a/src=
/openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -901,8 +901,6 @@
 
 v=
oid setenv_settings(struct env_set *es, const struct options *o);
 
-bool s=
tring_defined_equal(const char *s1, const char *s2);
-
 void options_postpr=
ocess(struct options *options, struct env_set *es);
 
 bool options_postpro=
cess_pull(struct options *o, struct env_set *es);

-- 
To view, visit http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1775?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-=
Branch: master
Gerrit-Change-Id: I09ad0d9baaa7351eecb5aafdb5c6e7b47cf7c909
=
Gerrit-Change-Number: 1775
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <f=
rank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2E=
org>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenhe=
ld=2Ecom>

--3NpkyIGKHwg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>flichtenheld <stro=
ng>uploaded patch set #3</strong> to this change=2E</p><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1775?usp=3Demail">View Change</a></p><p=
>The change is no longer submittable: checks~ChecksSubmitRule is unsatisfie=
d now=2E</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">options: Move string utility functions to buffer<=
br><br>buffer seems to be where we collect string utility<br>functions, so =
move them out of options=2E<br><br>Change-Id: I09ad0d9baaa7351eecb5aafdb5c6=
e7b47cf7c909<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Eco=
m&gt;<br>---<br>M src/openvpn/buffer=2Ec<br>M src/openvpn/buffer=2Eh<br>M s=
rc/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>4 files changed, 35 =
insertions(+), 34 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ge=
rrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/75/1775/3</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec</span><br><span>index=
 87d3094=2E=2Ea004b60 100644</span><br><span>--- a/src/openvpn/buffer=2Ec</=
span><br><span>+++ b/src/openvpn/buffer=2Ec</span><br><span>@@ -1086,6 +108=
6,38 @@</span><br><span> }</span><br><span> </span><br><span> bool</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+string_defined_equal(const c=
har *s1, const char *s2)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (s1 &a=
mp;&amp; s2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return !strcm=
p(s1, s2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+char *</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+string_substitute(const char *src, =
char from, char to, struct gc_arena *gc)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    char *ret =3D (char *)gc_malloc(strlen(src) + 1, true, gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    char *dest =3D ret;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    char c;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    do</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     c =3D *src++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (c =3D=3D from)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        c =3D to;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *des=
t++ =3D c;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    } whi=
le (c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return r=
et;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+bool</span><br><span> checked_snprintf(char *str, siz=
e_t size, const char *format, =2E=2E=2E)</span><br><span> {</span><br><span=
>     va_list arglist;</span><br><span>diff --git a/src/openvpn/buffer=2Eh =
b/src/openvpn/buffer=2Eh</span><br><span>index 81e247b=2E=2Eab8c239 100644<=
/span><br><span>--- a/src/openvpn/buffer=2Eh</span><br><span>+++ b/src/open=
vpn/buffer=2Eh</span><br><span>@@ -1766,6 +1766,9 @@</span><br><span>     r=
eturn 0 =3D=3D strncmp(str, prefix, strlen(prefix));</span><br><span> }</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool =
string_defined_equal(const char *s1, const char *s2);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+char *string_substitute(const char *src, =
char from, char to, struct gc_arena *gc);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  * Like snprin=
tf() but returns an boolean=2E</span><br><span>  *</span><br><span>diff --g=
it a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>inde=
x 3382138=2E=2E74b1f25 100644</span><br><span>--- a/src/openvpn/options=2Ec=
</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -1104,25 =
+1104,6 @@</span><br><span>     return get_ipv6_addr(ipv6_prefix_spec, NULL=
, NULL, M_WARN);</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static char *</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-string_substitute(const char *src, char from, char =
to, struct gc_arena *gc)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char *ret =3D=
 (char *)gc_malloc(strlen(src) + 1, true, gc);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    char *dest =3D ret;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    char c;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
do</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        c =3D *src++;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        if (c =3D=3D from)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            c =3D to;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        *dest++ =3D c;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    } while (c);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    return ret;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span> /**</span><br><span>  * Parses a hexstring and checks if the strin=
g has the correct length=2E Return</span><br><span>  * a verify_hash_list c=
ontaining the parsed hash string=2E</span><br><span>@@ -3582,19 +3563,6 @@<=
/span><br><span>     }</span><br><span> }</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-bool</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-string_defined_equal(const char *s1, const char *s2)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (s1 &amp;&amp; s2)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        return !strcmp(s1, s2);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        retur=
n false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span> #if 0</span><br><span> static v=
oid</span><br><span> ping_rec_err(msglvl_t msglevel)</span><br><span>diff -=
-git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh</span><br><span>in=
dex 0fd505a=2E=2Ec23d0b3 100644</span><br><span>--- a/src/openvpn/options=
=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -901,=
8 +901,6 @@</span><br><span> </span><br><span> void setenv_settings(struct =
env_set *es, const struct options *o);</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-bool string_defined_equal(const char *s1=
, const char *s2);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span> void options_postprocess(struct options *options, struct env=
_set *es);</span><br><span> </span><br><span> bool options_postprocess_pull=
(struct options *o, struct env_set *es);</span><br><span></span><br></pre><=
p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1775?=
usp=3Demail">change 1775</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail"=
>settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1775?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset=
 </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div st=
yle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Id: I09ad0d9baaa7351eecb5aafdb5c6e7b47cf7c909 </div>
<di=
v style=3D"display:none"> Gerrit-Change-Number: 1775 </div>
<div style=3D"d=
isplay:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit=
-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@m=
ailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-dev=
el &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;fran=
k@lichtenheld=2Ecom&gt; </div>

</body></html>
--3NpkyIGKHwg=--


--===============1723239021551156441==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1723239021551156441==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1723239021551156441==--

