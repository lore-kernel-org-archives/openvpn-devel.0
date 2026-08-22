Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD00C5DF9B
	for <openvpn-devel@archiver.kernel.org>; Sat, 22 Aug 2026 16:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=30z7kk08XAXZKojhV/j51fwfDCGVjK+8YwSTnAfwafE=; b=kuusn4APmrLDL53cEhvrzUIewk
	zJKbRT3P1ddtAJZfKVW8+ckejUJJKE6BclCvjiGspGo7MAacUGv/PcPXv2z8ky4E0QKtlnK7h687Z
	w7O+OARQoRjEwEHwscWVSU/3PaxD+UNH2/lI8CHdXi+Z3SdWq2AKbtifhi+keSm3DoF0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wxo93-0006rD-84;
	Sat, 22 Aug 2026 16:00:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wxo91-0006r5-ES
 for openvpn-devel@lists.sourceforge.net;
 Sat, 22 Aug 2026 16:00:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=5MiUGIaIwGYQbOjMiu06DScmkwJ9QBeHOF2LIxMMRVk=; b=T+7leNqT9t2hRTF3RJ8uD7NZmi
 EUV/5fhXn3bOlJABicv/SuZtiJHKUbIkq2Mu6a9QxHAl0olxey4CfV16HnbV7xr6Z2chFqKWb2j3G
 /jz5wHFO78Z4S378c/drtktvvTkUtbTbNT5JA47QvRTquL6fdLpvA9dk4pRDxpGiC77w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=5MiUGIaIwGYQbOjMiu06DScmkwJ9QBeHOF2LIxMMRVk=; b=U
 3q9RUIJt3pVGUBo7KMN2L00umHL3Mxz1fDME3ZSKgV+DDN//At6ffieMFz0PvmjqyI1Br41hCAEK1
 +Izle1Vxel7zWuX8imqYq6aEN2w1a8TypqHIkYiqzGrWofNKFo+SPQPivZpC10YO6K114lpiDEgJV
 kjQQpZQeZs/vzzYg=;
Received: from mail-ej1-f50.google.com ([209.85.218.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wxo8y-0003Ty-Jm for openvpn-devel@lists.sourceforge.net;
 Sat, 22 Aug 2026 16:00:32 +0000
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-c2055f5a993so235117566b.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 22 Aug 2026 09:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787414422; x=1788019222; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5MiUGIaIwGYQbOjMiu06DScmkwJ9QBeHOF2LIxMMRVk=;
 b=L2Pakf111kG90uhDlSsdoPrJvU/dWQQLD3Kq4wyn30mSVv8uhyoENzPOakrsodVjKv
 uPtr4GiF8Py/3wsB3IJtt77Cpqb4xhER8lAJKGcPSQdYbjkXyfb3WjAzFQvPqzEEnSg+
 YTOUHssn/uXYKOLo5I9o9pEAS0M/hBejzGDwVGOR3Rq0hLwXWhx0917rTKfnauGOabp+
 p7O1qCAL2nDjcxFuO7hWtSUCNEuOcP1daeEniMQPk7V+dPapvneHl3b/xe2IuqvlRlKO
 VRkT22bH1zl8jHCBWhWv/4bhPMjp2NbOV3tB6kbrK7I7YLtZGRQZreVNLj+hGYBgZ3r6
 Qhrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787414422; x=1788019222;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5MiUGIaIwGYQbOjMiu06DScmkwJ9QBeHOF2LIxMMRVk=;
 b=W/T8GwTpxLq1mQ9O1hJ+42dcPsARR9mNdvITJwkzFXXPhdBb+eY1d6RQx1CIV6QAmt
 rDzf0apJ1fpN1/FHcoZsAyLz8a3I9UcBMHfewaj9dz+FCplXh/fR4cVtq7YGUxlhYU3x
 aMSuypFHCrDyK6WbbDWK0FEMWv6Ly5aCKJdnOM1sMMwnxTYFqsA9wv9BRcZb+b39zXMc
 8A9qplLWcRSi71kynH1WdcedDWb9rjlXMkSP6+/lQqRQKC5LgAVhQLcC11rsQMcL+Sdx
 2GSYOEZXlyMwnUVUwVxIK+MosT4dPr6TxLe4vrN2CGNV9DNwpdL6VwhhND0/W6qhgeFu
 diOg==
X-Forwarded-Encrypted: i=1;
 AHgh+RprKkN8LqZVFcMXN/Sz3FTV7vqA1iR4PCHXe2Qjpc48Wgan8VOPxw3fE4Is6d/E1jpLZSGhwRp1MXCtSqyI@lists.sourceforge.net
X-Gm-Message-State: AFuF++lVhvkA7I9B1ASuQT3MOxBhnIG2wZemy3n3Wyqe6boUtnoZFUzK
 IgRCjoqrAU61koXs2aaDbdhTy+spoYSM+kOpUp19I0iZiOqYfvC6vbHxqGAEYfYBQIcINq5VZ7l
 DNN2aClx8yNacrbS5td8pBQ/AWW1d17ZC/OtTwNCxEbl4JP3STR3IZTbBz5bkqDFPSWMA
X-Gm-Gg: AR+sD13eogTK/b0JsjZlbK66Wy0Rl8J0m3AVK0mlh/XNf2yNgpDzsIWHc+MGE93XOUy
 rTwkTPOYCMZmG3qQVb+RTL4JbXATlS3u8OmrAOh1UioNVegmlNUZtleVNw/okO+SqplLVp6gaRC
 VvRIauP3VNFQKYFFZXBwnZF/MyJN34npWcG1cxAhO1iMoaEIg8iNlrTY1EXmR9ONxuGFamQG0Go
 mKyN9SuGcC61RzHkuQwRhUD+jq+6sdueBqLmhG3bLRmkVta9kTvEWCsYmtMY7hOMFd3qW+KNUhX
 1weOD2pg7JgNd9a75AIqycBvIPp5Yx2pVtV5jy63wzlCjgg8QXmhPEN0N/QqiOcYxeMi0fAmRRF
 RW8ALOat1vBT8Jt0WEvSXmprrGFC4fWYpyXbGmVmUgJR7Jkbq3nf9bZ1zyLAlZ3cf2MiPO5Gn1j
 r5xchlUKXiBv7yhXumtO+pIApGMOx/VHYMRIwltyhU7NMzhpd8GvL29/AvagelRGLzmMkPSxRau
 QCcKJFOTUmD0wfRVQt1D1/lZIsJzxkBhQVvPeYpaKpu2ZIHDXdAQDhnd7BdtwbaFrLpbkIaMnRb
 k2IAU9YG2pcXievcig/ZbmujFAFDlzUQqDZ3wb3NNmrO/daHtqc=
X-Received: by 2002:a17:907:3e02:b0:c21:6f8c:2335 with SMTP id
 a640c23a62f3a-c246a6b1745mr1552067666b.16.1787414421616; 
 Sat, 22 Aug 2026 09:00:21 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249629929dsm391556266b.23.2026.08.22.09.00.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 09:00:21 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 22 Aug 2026 16:00:20 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I09ad0d9baaa7351eecb5aafdb5c6e7b47cf7c909
X-Gerrit-Change-Number: 1775
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1775?usp=email>
X-Gerrit-Commit: 3de926089fdebd79b9d25e80c31e45c1e044911d
In-Reply-To: <gerrit.1783600902000.I09ad0d9baaa7351eecb5aafdb5c6e7b47cf7c909@gerrit.openvpn.net>
References: <gerrit.1783600902000.I09ad0d9baaa7351eecb5aafdb5c6e7b47cf7c909@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzNjAwOTAyMDAwLkkwOWFkMGQ5YmFhYTczNTFlZWNiNWFhZmRiNWM2ZTdiNDdjZjdjOTA5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d26544b820d68e764f0a2edb2a5272b1eee1c56b-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wxo8y-0003Ty-Jm
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8830802169860350616=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8830802169860350616==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZsDYud6Lc28="; charset=UTF-8

--ZsDYud6Lc28=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1775?usp=3Demail )

Change subject: options: Move string utility functi=
ons to buffer
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


options: Move string utility functions to buffer

buffer seems to be wher=
e we collect string utility
functions, so move them out of options=2E

Chan=
ge-Id: I09ad0d9baaa7351eecb5aafdb5c6e7b47cf7c909
Signed-off-by: Frank Licht=
enheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1775
Message=
-Id: <20260819211812=2E3214-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Em=
ail-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38541=2Ehtml
S=
igned-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/buff=
er=2Ec
M src/openvpn/buffer=2Eh
M src/openvpn/options=2Ec
M src/openvpn/opt=
ions=2Eh
4 files changed, 35 insertions(+), 34 deletions(-)




diff --git =
a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec
index f14caa2=2E=2E8c1990=
2 100644
--- a/src/openvpn/buffer=2Ec
+++ b/src/openvpn/buffer=2Ec
@@ -1086=
,6 +1086,38 @@
 }
 
 bool
+string_defined_equal(const char *s1, const char =
*s2)
+{
+    if (s1 && s2)
+    {
+        return !strcmp(s1, s2);
+    }
+=
    else
+    {
+        return false;
+    }
+}
+
+char *
+string_substitu=
te(const char *src, char from, char to, struct gc_arena *gc)
+{
+    char *=
ret =3D (char *)gc_malloc(strlen(src) + 1, true, gc);
+    char *dest =3D r=
et;
+    char c;
+
+    do
+    {
+        c =3D *src++;
+        if (c =3D=
=3D from)
+        {
+            c =3D to;
+        }
+        *dest++ =3D=
 c;
+    } while (c);
+    return ret;
+}
+
+bool
 checked_snprintf(char *s=
tr, size_t size, const char *format, =2E=2E=2E)
 {
     va_list arglist;
di=
ff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh
index 85277ff=2E=
=2E651aaed 100644
--- a/src/openvpn/buffer=2Eh
+++ b/src/openvpn/buffer=2Eh=

@@ -1766,6 +1766,9 @@
     return 0 =3D=3D strncmp(str, prefix, strlen(pre=
fix));
 }
 
+bool string_defined_equal(const char *s1, const char *s2);
+ch=
ar *string_substitute(const char *src, char from, char to, struct gc_arena =
*gc);
+
 /**
  * Like snprintf() but returns an boolean=2E
  *
diff --git a=
/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 9bd6f01=2E=2E107b3=
fa9 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -=
1087,25 +1087,6 @@
     return get_ipv6_addr(ipv6_prefix_spec, NULL, NULL, =
M_WARN);
 }
 
-static char *
-string_substitute(const char *src, char from,=
 char to, struct gc_arena *gc)
-{
-    char *ret =3D (char *)gc_malloc(strl=
en(src) + 1, true, gc);
-    char *dest =3D ret;
-    char c;
-
-    do
-  =
  {
-        c =3D *src++;
-        if (c =3D=3D from)
-        {
-        =
    c =3D to;
-        }
-        *dest++ =3D c;
-    } while (c);
-    ret=
urn ret;
-}
-
 /**
  * Parses a hexstring and checks if the string has the =
correct length=2E Return
  * a verify_hash_list containing the parsed hash =
string=2E
@@ -3565,19 +3546,6 @@
     }
 }
 
-bool
-string_defined_equal(co=
nst char *s1, const char *s2)
-{
-    if (s1 && s2)
-    {
-        return =
!strcmp(s1, s2);
-    }
-    else
-    {
-        return false;
-    }
-}
-=

 #if 0
 static void
 ping_rec_err(msglvl_t msglevel)
diff --git a/src/open=
vpn/options=2Eh b/src/openvpn/options=2Eh
index 0fd505a=2E=2Ec23d0b3 100644=

--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -901,8 +901=
,6 @@
 
 void setenv_settings(struct env_set *es, const struct options *o);=

 
-bool string_defined_equal(const char *s1, const char *s2);
-
 void opti=
ons_postprocess(struct options *options, struct env_set *es);
 
 bool optio=
ns_postprocess_pull(struct options *o, struct env_set *es);

-- 
To view, v=
isit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1775?usp=3Demail
To unsubscr=
ibe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Ge=
rrit-Branch: master
Gerrit-Change-Id: I09ad0d9baaa7351eecb5aafdb5c6e7b47cf7=
c909
Gerrit-Change-Number: 1775
Gerrit-PatchSet: 6
Gerrit-Owner: flichtenhe=
ld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openv=
pn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--ZsDYud6Lc28=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1775?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">options: Move string utility functions to =
buffer<br><br>buffer seems to be where we collect string utility<br>functio=
ns, so move them out of options=2E<br><br>Change-Id: I09ad0d9baaa7351eecb5a=
afdb5c6e7b47cf7c909<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenhe=
ld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>=
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1775<br>Message-Id: =
&lt;20260819211812=2E3214-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38541=2Eht=
ml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br=
>M src/openvpn/buffer=2Ec<br>M src/openvpn/buffer=2Eh<br>M src/openvpn/opti=
ons=2Ec<br>M src/openvpn/options=2Eh<br>4 files changed, 35 insertions(+), =
34 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/src/openvpn/buffer=2Ec b/src/=
openvpn/buffer=2Ec</span><br><span>index f14caa2=2E=2E8c19902 100644</span>=
<br><span>--- a/src/openvpn/buffer=2Ec</span><br><span>+++ b/src/openvpn/bu=
ffer=2Ec</span><br><span>@@ -1086,6 +1086,38 @@</span><br><span> }</span><b=
r><span> </span><br><span> bool</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+string_defined_equal(const char *s1, const char *s2)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (s1 &amp;&amp; s2)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return !strcmp(s1, s2);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+char *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+string_substitute(const char *src, char from, char to, struct gc_ar=
ena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    char *ret =3D (char *)gc_=
malloc(strlen(src) + 1, true, gc);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    char *dest =3D ret;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    char c;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    do</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        c =3D *src++;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if (c =3D=3D from)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            c =3D to;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        *dest++ =3D c;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    } while (c);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span=
><br><span> checked_snprintf(char *str, size_t size, const char *format, =
=2E=2E=2E)</span><br><span> {</span><br><span>     va_list arglist;</span><=
br><span>diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh</span=
><br><span>index 85277ff=2E=2E651aaed 100644</span><br><span>--- a/src/open=
vpn/buffer=2Eh</span><br><span>+++ b/src/openvpn/buffer=2Eh</span><br><span=
>@@ -1766,6 +1766,9 @@</span><br><span>     return 0 =3D=3D strncmp(str, pr=
efix, strlen(prefix));</span><br><span> }</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+bool string_defined_equal(const cha=
r *s1, const char *s2);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+char *string_substitute(const char *src, char from, char to, struct gc_=
arena *gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> /**</span><br><span>  * Like snprintf() but returns an boolean=2E=
</span><br><span>  *</span><br><span>diff --git a/src/openvpn/options=2Ec b=
/src/openvpn/options=2Ec</span><br><span>index 9bd6f01=2E=2E107b3fa9 100644=
</span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/op=
envpn/options=2Ec</span><br><span>@@ -1087,25 +1087,6 @@</span><br><span>  =
   return get_ipv6_addr(ipv6_prefix_spec, NULL, NULL, M_WARN);</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-static char *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-strin=
g_substitute(const char *src, char from, char to, struct gc_arena *gc)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    char *ret =3D (char *)gc_malloc(strlen(src=
) + 1, true, gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
char *dest =3D ret;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  char c;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    do</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        c =3D *src++;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        if (c =3D=3D from)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            c =3D to;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
*dest++ =3D c;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    } w=
hile (c);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return r=
et;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /**</span><br><span>=
  * Parses a hexstring and checks if the string has the correct length=2E R=
eturn</span><br><span>  * a verify_hash_list containing the parsed hash str=
ing=2E</span><br><span>@@ -3565,19 +3546,6 @@</span><br><span>     }</span>=
<br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-string_d=
efined_equal(const char *s1, const char *s2)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    if (s1 &amp;&amp; s2)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        r=
eturn !strcmp(s1, s2);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        return false;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span> #if 0</span><br><span> static void</span><br><span> ping_rec_=
err(msglvl_t msglevel)</span><br><span>diff --git a/src/openvpn/options=2Eh=
 b/src/openvpn/options=2Eh</span><br><span>index 0fd505a=2E=2Ec23d0b3 10064=
4</span><br><span>--- a/src/openvpn/options=2Eh</span><br><span>+++ b/src/o=
penvpn/options=2Eh</span><br><span>@@ -901,8 +901,6 @@</span><br><span> </s=
pan><br><span> void setenv_settings(struct env_set *es, const struct option=
s *o);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-bool string_defined_equal(const char *s1, const char *s2);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void options_post=
process(struct options *options, struct env_set *es);</span><br><span> </sp=
an><br><span> bool options_postprocess_pull(struct options *o, struct env_s=
et *es);</span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1775?usp=3Demail">change 1775</a>=2E =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1775?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"dis=
play:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I09ad0d9baaa73=
51eecb5aafdb5c6e7b47cf7c909 </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 1775 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </di=
v>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichte=
nheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaist=
hos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefo=
rge=2Enet&gt; </div>

</body></html>
--ZsDYud6Lc28=--


--===============8830802169860350616==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8830802169860350616==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8830802169860350616==--

