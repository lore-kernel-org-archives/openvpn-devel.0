Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FAADCD98D8
	for <openvpn-devel@archiver.kernel.org>; Fri, 12 Jun 2026 13:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fJYO/6RPbqoBSLsMOt8tbCo+9NxXGZ+nZ9axSkTB0QQ=; b=ZLLoNqr/f7ZBrPwZiwXow5PJlB
	AKLtCn4NkFjrJxOv36CqVACTsrTG4oN+MsiTfsRWL6Qn1mAsGMxrOb0iOvkLG1KeLY5okML/foqbW
	kWfQoQkQbMeb1rOI6yalTaw4qTl+mznIFX49StBFYGtLMcGKYLdO0KKbnREh8iBGvmxk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wY2Gq-0002Nb-GJ;
	Fri, 12 Jun 2026 13:50:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wY2Go-0002NU-Tr
 for openvpn-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 13:50:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=u/sXCCuBg+0/bMEBg193O05kg+c3Qc/Ie5Ib28KZAwg=; b=mVSnkBjn6Dmu5x02fuXAXUPRvF
 6hlK6o7ZnhQ+KS7G522i6LZjTFGeZK8MsCZ4wOJ5mkBAGEdDTLt4JYL75MkMIwXn2Kzc7ao0TGMw+
 nI20+0lLiorPHz6+N4Y507rOpG87ZA/qlCMJFnHI11uvHd6aVRExnh2ZckhPDZxDzJ2c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=u/sXCCuBg+0/bMEBg193O05kg+c3Qc/Ie5Ib28KZAwg=; b=K
 c1C3rv5GDKMTwnuyDghDO33Riy+NuSqb4SDpXhNRVuCI8CsJfdNibXPFHi1SGk61BHiO/JGC9AGN5
 maA3kAcku+oWAvh7loPhgsCA9rwuEi05g9DEgzhdg7bDmJwgHRTD6xniPLGAwjIvhN0HxOFnc7oK3
 2WzuOId3pS1wD+bM=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wY2Gm-00007C-Cf for openvpn-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 13:50:03 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-490be03d47bso10239655e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 12 Jun 2026 06:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781272194; x=1781876994; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u/sXCCuBg+0/bMEBg193O05kg+c3Qc/Ie5Ib28KZAwg=;
 b=ePGCg301Hritf/dROOwZKvNIFNWZdDpvsivdSHIdeEZZQ/pSw5i6+LCwad0nIUyy4X
 vs9wjCui+liukMTgIlmLIWmZr6P4W0atDDvIvbpBLkb1cew1eTrfXBpYjHDBeq2PHpB7
 Cf8Ne765XbjM/RE/vlN+T52GqYyKiSc8+ZZWJPHA1Nbsr4M15MtEEo9LEeXBChXb+zGM
 EKaH6vk5NveQlLsOE7jfbf/ndPFs+7BlUgC6EHEfx5wAL3GG8VOdNGhh11ZkCNYhDlk/
 zFFRm48ybmYKAoNPWw98xK0WKXNos0syCRiGHB1NMiOc1s8zXxr3wN2n53rmL3uGVUkM
 yhsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781272194; x=1781876994;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u/sXCCuBg+0/bMEBg193O05kg+c3Qc/Ie5Ib28KZAwg=;
 b=tDXS6boO+prkRYgYbek2dKRSa5Hl0BToxe+q8plf+mIx1XAxnUOrA/NH4sTS4se4Rp
 rTu8JTc+6xyMMnDQtpcuJJM2RY5IfbnNwNmofvC87X9WcozlssbsnKO/5BU0oZCwqw4a
 Nd95NtGDNprZAxa5zDlGtariiOXJV4e0/pqtVPAirwLdRWFR6NNIVu8aeKY5i3tZLbQN
 JQ6xrZbl1xsaTV3C2ArHxpPxrXAczUlY1DylsdehYj2kDMVyPU3BZg5LpDWu78IorJS+
 FdCoJtLPCtV/Nao4qI3FUp8g7ubRmXa+UQ6HJuC4ha+ILjyOHhg6RL8yHVzfL7Z4NMWd
 Ethg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9GtvFtLTus+lVQpkBKhmmCaFKkx8ovAtFe3tXkQu4y5MHkA8XBHK7xvdSO9KV0n0BfgyB0Y0DXZRuTlnnO@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzVDce/fsItJn0TvUT9pvAtbA685Lq/n6H+48hip994/55US/UD
 OZu87YR9OYi4NQ14rWE9fEovQyLx0Gkm5OuDb8QeLPwzh6jhdDiRaSNjD7tATajlbyzVlt3TyAK
 OVCmEaBjiNWwZvntRMpAiI9Mc9N7zhywWPKbWKizbi/hCpI1VQ5dUu3Q+5wneQOQ4obvv6HaI8a
 wso1zLtw==
X-Gm-Gg: Acq92OGdYmzX7MpE0wazoirC1vdKzO8aHq3hCDthDZcMSpIn9ok8Y2+vE4Ix9IqLpd2
 3vM7dUDTJw+gl3Jp+6oR1U7Av3cTlWniPOH+VdFXGSF2V/sBBMY5dTpYnFxnIi/9LhUkBHBvqDl
 XE87q1ZeY1BaCoXigKGrdABRSInezxqdTr4e59A6aC6O3/iuHHP1l2r+vGw833ha2ejBdDsdG7Q
 J+ld52BLmxsfFOQUfm3+kDSfbvrtQzf0EboFistg23Eaxdhxqcid8ac6yocwbQWOmor3s6aW4Ns
 eEAo+U0IIVKcTVwGIIemE5dwbyaTSA2HUETdfXweQeIFWK9URO45yKjdu7TvzRB60xmNjhGAj5M
 Wp3oWnYGoEFLIm+9h4lBaa48wde8ygXytn2wyxltxVGvF2G8a9TCxWSFDlrR38LaMNxRzZ+fKJ6
 uSP1UlOVcPsxeuoaRofuyWXuDJrovAPb47HKvsJyG74tp7kk/bK55BcJJ356xDWacYD4S9TTSmu
 9q8stW2gnYsXwfn4qF8tqzlnJfskeTR7jcDOn5H5d0L/XVpN3PG+gNJA3uNx2JAG2n3A3AT+3UX
 Z/tjjKNMS9JVwg==
X-Received: by 2002:a05:600c:1d1e:b0:488:ac01:72de with SMTP id
 5b1f17b1804b1-490ec4bfe3emr36284435e9.5.1781272194108; 
 Fri, 12 Jun 2026 06:49:54 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e2d09a85sm146132765e9.14.2026.06.12.06.49.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 06:49:53 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 12 Jun 2026 13:49:53 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I1d4e0233cf1cb09725dbd2caa121acdbf62f0452
X-Gerrit-Change-Number: 1433
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1433?usp=email>
X-Gerrit-Commit: 334938d4aba45bf4dde063f8f8d2c6022edf2a13
In-Reply-To: <gerrit.1765383841000.I1d4e0233cf1cb09725dbd2caa121acdbf62f0452@gerrit.openvpn.net>
References: <gerrit.1765383841000.I1d4e0233cf1cb09725dbd2caa121acdbf62f0452@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzY1MzgzODQxMDAwLkkxZDRlMDIzM2NmMWNiMDk3MjVkYmQyY2FhMTIxYWNkYmY2MmYwNDUyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8cdece99ae84ba5d984337077fe95dcbf2d67f6b-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wY2Gm-00007C-Cf
Subject: [Openvpn-devel] [S] Change in openvpn[master]: mbuf: Fix conversion
 warnings in mbuf and related code
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2785859561950325001=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2785859561950325001==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eG+kQmMxuBs="; charset=UTF-8

--eG+kQmMxuBs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1433?usp=3Demail )

Change subject: mbuf: Fix conversion warnings in mb=
uf and related code
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

mbuf: Fix conversion warnings in mbuf and related code

Mostly thes=
e were actually hidden by casts, but fix
them as well by using more fitting=
 types=2E

Change-Id: I1d4e0233cf1cb09725dbd2caa121acdbf62f0452
Signed-off-=
by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Gert Doering <ger=
t@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1433
Message-Id: <20260612110424=2E27033-1-gert@greenie=2Emuc=2Ede>
URL: =
https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/ms=
g37182=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M s=
rc/openvpn/buffer=2Ec
M src/openvpn/mbuf=2Ec
2 files changed, 5 insertions(=
+), 17 deletions(-)




diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/b=
uffer=2Ec
index 1e19137=2E=2E5f2b233 100644
--- a/src/openvpn/buffer=2Ec
++=
+ b/src/openvpn/buffer=2Ec
@@ -43,7 +43,7 @@
     unsigned long long res =
=3D
         (unsigned long long)m1 * (unsigned long long)m2 + (unsigned lo=
ng long)extra;
     if (unlikely(m1 > limit) || unlikely(m2 > limit) || unl=
ikely(extra > limit)
-        || unlikely(res > (unsigned long long)limit))=

+        || unlikely(res > limit))
     {
         msg(M_FATAL, "attempted=
 allocation of excessively large array");
     }
diff --git a/src/openvpn/m=
buf=2Ec b/src/openvpn/mbuf=2Ec
index 5e1b585=2E=2E7b790ed 100644
--- a/src/=
openvpn/mbuf=2Ec
+++ b/src/openvpn/mbuf=2Ec
@@ -34,11 +34,6 @@
 
 #include =
"memdbg=2Eh"
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC di=
agnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 str=
uct mbuf_set *
 mbuf_init(unsigned int size)
 {
@@ -46,22 +41,17 @@
 
     =
struct mbuf_set *ret;
     ALLOC_OBJ_CLEAR(ret, struct mbuf_set);
-    ret-=
>capacity =3D adjust_power_of_2(size);
+    ret->capacity =3D (unsigned int=
)adjust_power_of_2(size);
     ALLOC_ARRAY(ret->array, struct mbuf_item, re=
t->capacity);
     return ret;
 }
 
-#if defined(__GNUC__) || defined(__cla=
ng__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 mbuf_free(struct mbuf_se=
t *ms)
 {
     if (ms)
     {
-        int i;
-        for (i =3D 0; i < (i=
nt)ms->len; ++i)
+        for (unsigned int i =3D 0; i < ms->len; ++i)
    =
     {
             struct mbuf_item *item =3D &ms->array[MBUF_INDEX(ms->he=
ad, i, ms->capacity)];
             mbuf_free_buf(item->buffer);
@@ -145,8 =
+135,7 @@
     struct multi_instance *ret =3D NULL;
     if (ms)
     {
-  =
      int i;
-        for (i =3D 0; i < (int)ms->len; ++i)
+        for (un=
signed int i =3D 0; i < ms->len; ++i)
         {
             struct mbuf_i=
tem *item =3D &ms->array[MBUF_INDEX(ms->head, i, ms->capacity)];
          =
   if (item->instance)
@@ -164,8 +153,7 @@
 {
     if (ms)
     {
-        =
int i;
-        for (i =3D 0; i < (int)ms->len; ++i)
+        for (unsigned=
 int i =3D 0; i < ms->len; ++i)
         {
             struct mbuf_item *i=
tem =3D &ms->array[MBUF_INDEX(ms->head, i, ms->capacity)];
             if =
(item->instance =3D=3D mi)

-- 
To view, visit http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1433?usp=3Demail
To unsubscribe, or for help writing mail fil=
ters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mess=
ageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: I1d4e0233cf1cb09725dbd2caa121acdbf62f0452
Gerrit-Change-Number: 1433
G=
errit-PatchSet: 7
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerr=
it-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Es=
ourceforge=2Enet>

--eG+kQmMxuBs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1433?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">mbuf: Fix conversion warnings in mbuf and =
related code<br><br>Mostly these were actually hidden by casts, but fix<br>=
them as well by using more fitting types=2E<br><br>Change-Id: I1d4e0233cf1c=
b09725dbd2caa121acdbf62f0452<br>Signed-off-by: Frank Lichtenheld &lt;frank@=
lichtenheld=2Ecom&gt;<br>Acked-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede=
&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1433<br>Mess=
age-Id: &lt;20260612110424=2E27033-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: ht=
tps://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg3=
7182=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<=
br>---<br>M src/openvpn/buffer=2Ec<br>M src/openvpn/mbuf=2Ec<br>2 files cha=
nged, 5 insertions(+), 17 deletions(-)<br><br></pre>
<pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/op=
envpn/buffer=2Ec b/src/openvpn/buffer=2Ec</span><br><span>index 1e19137=2E=
=2E5f2b233 100644</span><br><span>--- a/src/openvpn/buffer=2Ec</span><br><s=
pan>+++ b/src/openvpn/buffer=2Ec</span><br><span>@@ -43,7 +43,7 @@</span><b=
r><span>     unsigned long long res =3D</span><br><span>         (unsigned =
long long)m1 * (unsigned long long)m2 + (unsigned long long)extra;</span><b=
r><span>     if (unlikely(m1 &gt; limit) || unlikely(m2 &gt; limit) || unli=
kely(extra &gt; limit)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        || unlikely(res &gt; (unsigned long long)limit))</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        || unlikely(res &gt; limit))<=
/span><br><span>     {</span><br><span>         msg(M_FATAL, &quot;attempte=
d allocation of excessively large array&quot;);</span><br><span>     }</spa=
n><br><span>diff --git a/src/openvpn/mbuf=2Ec b/src/openvpn/mbuf=2Ec</span>=
<br><span>index 5e1b585=2E=2E7b790ed 100644</span><br><span>--- a/src/openv=
pn/mbuf=2Ec</span><br><span>+++ b/src/openvpn/mbuf=2Ec</span><br><span>@@ -=
34,11 +34,6 @@</span><br><span> </span><br><span> #include &quot;memdbg=2Eh=
&quot;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconv=
ersion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> struct=
 mbuf_set *</span><br><span> mbuf_init(unsigned int size)</span><br><span> =
{</span><br><span>@@ -46,22 +41,17 @@</span><br><span> </span><br><span>   =
  struct mbuf_set *ret;</span><br><span>     ALLOC_OBJ_CLEAR(ret, struct mb=
uf_set);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret-&gt;c=
apacity =3D adjust_power_of_2(size);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    ret-&gt;capacity =3D (unsigned int)adjust_power_of_2(s=
ize);</span><br><span>     ALLOC_ARRAY(ret-&gt;array, struct mbuf_item, ret=
-&gt;capacity);</span><br><span>     return ret;</span><br><span> }</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined=
(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span> void</span><br><span> mbuf_free(struct mbuf_set *ms)</sp=
an><br><span> {</span><br><span>     if (ms)</span><br><span>     {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        int i;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        for (i =3D 0; i &lt; (int)ms=
-&gt;len; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   for (unsigned int i =3D 0; i &lt; ms-&gt;len; ++i)</span><br><span>     =
    {</span><br><span>             struct mbuf_item *item =3D &amp;ms-&gt;a=
rray[MBUF_INDEX(ms-&gt;head, i, ms-&gt;capacity)];</span><br><span>        =
     mbuf_free_buf(item-&gt;buffer);</span><br><span>@@ -145,8 +135,7 @@</s=
pan><br><span>     struct multi_instance *ret =3D NULL;</span><br><span>   =
  if (ms)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        int i;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        for (i =3D 0; i &lt; (int)ms-&gt;len; ++i)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        for (unsigned int i =3D 0; i &lt=
; ms-&gt;len; ++i)</span><br><span>         {</span><br><span>             =
struct mbuf_item *item =3D &amp;ms-&gt;array[MBUF_INDEX(ms-&gt;head, i, ms-=
&gt;capacity)];</span><br><span>             if (item-&gt;instance)</span><=
br><span>@@ -164,8 +153,7 @@</span><br><span> {</span><br><span>     if (ms=
)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        int i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    for (i =3D 0; i &lt; (int)ms-&gt;len; ++i)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        for (unsigned int i =3D 0; i &lt; ms-&gt=
;len; ++i)</span><br><span>         {</span><br><span>             struct m=
buf_item *item =3D &amp;ms-&gt;array[MBUF_INDEX(ms-&gt;head, i, ms-&gt;capa=
city)];</span><br><span>             if (item-&gt;instance =3D=3D mi)</span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1433?usp=3Demail">change 1433</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D=
"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemt=
ype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1433?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project=
: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
=
<div style=3D"display:none"> Gerrit-Change-Id: I1d4e0233cf1cb09725dbd2caa12=
1acdbf62f0452 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 143=
3 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=
=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@gree=
nie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: pla=
isthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt;=
 </div>

</body></html>
--eG+kQmMxuBs=--


--===============2785859561950325001==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2785859561950325001==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2785859561950325001==--

