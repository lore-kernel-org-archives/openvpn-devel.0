Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B75C4C61DC2
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 11:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E7NFUV57qJd/rvrCrOuhDCcEtClT+Onou2EjMHE7SFY=; b=c3+/MgDcMO13Gb5Tj3wi9R7ADp
	sB3oGOV1vMLt0ryMKMCsmhPHEzsWi1AArTmPN6m+0rzIkiyNntB94/gBnDUffMSQ4XJ5U5EsrFjVB
	qURrM8WfA0F+xvQpEd7GOjUVGBaok2ESVTEVNZhSslylVsivwNl8nKusqp8ylFInXcNo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzCAu-0006F6-7A;
	Wed, 26 Aug 2026 11:52:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzCAs-0006Ez-OI
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 11:52:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=qjEJrjs4abHR6zkECTNUhfjC6i6PFclZOn1loPmpsWw=; b=J2WYlqIXSa+9JtdGoaK29p5LAs
 FQZJ2gG/C4U9FIZJfbXXZ9rl+RfHdyJOMBGtASb6B/3/4Vpn3T4w+RvZzFCiYFwmCwlvkQm0cnD7z
 afaMBHIEgxC5SZ7O6p3BWGhWlwv/AuXOzRxKgIca8gQIko0pGt66+JlI3KxrWKwDOSLs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=qjEJrjs4abHR6zkECTNUhfjC6i6PFclZOn1loPmpsWw=; b=N
 faViJfAgHVrQ7SwCBAjP0NyA3k54lwzlmlktvntyc+3ImGxLZsWj6Nbyh+X4O+Mlc0VWNhOqOm93l
 EsbhqexvfYwwscL6Fa1S1pZY8E74rANgtCDWcTynCRWcxbKzpPHeflqEJq3pInvfNTIyG0szNnsRK
 YeYed0BDKAkYSCuQ=;
Received: from mail-ej1-f43.google.com ([209.85.218.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzCAr-0000yO-5b for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 11:52:10 +0000
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-c250a2bc3b3so104952466b.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 26 Aug 2026 04:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787745122; x=1788349922; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qjEJrjs4abHR6zkECTNUhfjC6i6PFclZOn1loPmpsWw=;
 b=RzTbk3h/xc/Su0JPjTudZFuBYgM/Kfj93nhWq6MLZlGI4t6j1TmyaVdP2rfKLlvU+q
 6jTVpWBMvT+wqlGAD9A7JpR2oCyCHXRuL634bGFJ583zL/z61uRXX7uUbLXJzxdrbRsG
 pF1OcEND1+Shim6UTJUgPiO++V3YMPn0MjthIGOCJW07IsMT4SAzd+yLyY1NedjAv3ts
 +Dn8EkdxuXRS0jP37XB/q+kaXP4oz3+BJdNbgf/3FEshzudMk4a+fp6DI8pGicLOuk3m
 d6ki/treP+M+08QAbjAbuXxtuNO/N+/aw/HpkreLQOny75w74xIe17EMs5I8jHVwJIgZ
 KXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787745122; x=1788349922;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qjEJrjs4abHR6zkECTNUhfjC6i6PFclZOn1loPmpsWw=;
 b=nLQwe3mdjRB2YopDewWnBDVHz3WQ2+5oK1wDhK/jN7IsOJDfqy+Z9B8bgXTFy8bqgq
 mWShIDNf32ZYkC2jt6uGkNeSyh/3H1crNp+kyC0Yo569zXDXNbd4dHKiia57aMuB3RXS
 muLxbPLuv048xtRsSwvEwiF1YwHfHEmUT6lVqgjvMKch54+Uu3NixsdUmot8NWHPoTrg
 N79JONvKJtlWiuZfhTdG+eQ33E9pnCoS68eIDXsxZImhZ3aU5xXKHTLVytuOrAnyr8Av
 me4sT7AKBcEHdlNGsqWq3mYGEht5Jz9CbvcqpTXAH87DCUJzyUNpee+LW/KBIe7kyKaa
 GchA==
X-Gm-Message-State: AFuF++lHMncdizMosww7e537AU7H/VJQrYOvkYeY4KOWiI152FSlVqoE
 H37XyumFcjv4EMkQ/CZg+4FktrLdPYs++8/Z/XDBLDiLXrQzidfFjNb1O2mCP7nuyUC/9jmz/z1
 cyI0NvPb+1QA0hdIPzNNvnT1tRygdvdRaYgdrqAekhWRzt9oSz2lTBhBc1H+ON6HGaf3xntB9GY
 zNXI88zQ==
X-Gm-Gg: AR+sD126KhGvs2AAloTd9P3UqzRNbi4YDdPTnyJA9Vu3RHXzE8nqT/5iGh/B3Z0YAUg
 bb9kCqehyjSf0HKD0CXLTJQp/KavECzuS+UrNeGafOtHrEpesGjkrEoNv+r4qa1YgIaC5UIAIqq
 KxRJ6Bb6AO/FUNDB47aOEBDHJ/KEKJeMyX3nZDa5j5YIIoSEJYSNsA1svGSaxn1W9ltB8iIwGlK
 82y6a15l1hFOpFIRiT0gzHm9uYXiCLV+zf+2g7SeCDnFXxZmrxmJ6jkL8F34e+dRszEiHUbphhI
 n23l7MuNdzcHXLMM/IBb85M0DVzg1g0logokGw5zBgTcchouC+hN4aG8MvcA0ajfJ8l5R76EqAK
 l3fvNNKYcfeuLXGnn6mZRM/0p8AzGo7Wkpzsy+me3IRIH4fKk6yx80sPGfubQV6CHFKQ7650jjw
 QlqW+fqwK6KBWqo4+2tyQrDtFKmHbUZHMFGnGd6/ZOCxx1C6rUCFSsV3DVant541PyGpkYcGivc
 T0+CnG1qlCFJBFG/3WwWXFJXU1o5CSUltyiOsZUQboKZUvw3ppudRETzFXtHmpL8gV88m/sm0Kw
 zqF+3iDhdvjMzDzN4pa6qTQIbXgxxrHaPkviLP4gkiXgtTx/hko=
X-Received: by 2002:a17:907:60d2:b0:c20:2eee:97be with SMTP id
 a640c23a62f3a-c250bb23e58mr823751166b.7.1787745122319; 
 Wed, 26 Aug 2026 04:52:02 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c25185b4d97sm310012566b.34.2026.08.26.04.52.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 04:52:01 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 26 Aug 2026 11:51:43 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I42d8785959c24bf688190965e58b9b98251b8557
X-Gerrit-Change-Number: 1856
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1856?usp=email>
X-Gerrit-Commit: 1e7ef53850e82f41b9691003c30f1f125e2a60fb
In-Reply-To: <gerrit.1787327336000.I42d8785959c24bf688190965e58b9b98251b8557@gerrit.openvpn.net>
References: <gerrit.1787327336000.I42d8785959c24bf688190965e58b9b98251b8557@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0MmQ4Nzg1OTU5YzI0YmY2ODgxOTA5NjVlNThiOWI5ODI1MWI4NTU3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5b2715ae9183ae354071eff3da260dcdccebeb72-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzCAr-0000yO-5b
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Introduce
 get_key_by_management_key_id helper function
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1177692146302073811=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1177692146302073811==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Dn7Lv5a7OMM="; charset=UTF-8

--Dn7Lv5a7OMM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded a new patch set (#6)=2E ( http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1856?usp=3Demail )


Change subject: Introduce get_key_by_m=
anagement_key_id helper function
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

Introduce get_key_by_management_key_id helper function
=

This function allows us to map from a management key id to a key structure=

and also allows this function to be reused=2E

Patch v2: add message when =
key is not found=2E
Patch v3: only consider valid keys

Change-Id: I42d8785=
959c24bf688190965e58b9b98251b8557
Signed-off-by: Arne Schwabe <arne@rfc2549=
=2Eorg>
---
M src/openvpn/ssl_common=2Eh
M src/openvpn/ssl_verify=2Ec
2 fil=
es changed, 32 insertions(+), 10 deletions(-)


  git pull ssh://gerrit=2Eo=
penvpn=2Enet:29418/openvpn refs/changes/56/1856/6

diff --git a/src/openvpn=
/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh
index f6392f9=2E=2Edb61198 100=
644
--- a/src/openvpn/ssl_common=2Eh
+++ b/src/openvpn/ssl_common=2Eh
@@ -7=
59,4 +759,24 @@
     return &multi->session[TM_ACTIVE]=2Ekey[KS_PRIMARY];
 =
}
 
+#ifdef ENABLE_MANAGEMENT
+/**
+ * Gets the \c key_state  object that b=
elong to the management key id or
+ * return NULL if not found=2E
+ */
+sta=
tic inline struct key_state *
+get_key_by_management_key_id(struct tls_mult=
i *multi, unsigned int mda_key_id)
+{
+    for (int i =3D 0; i < KEY_SCAN_S=
IZE; ++i)
+    {
+        struct key_state *ks =3D get_key_scan(multi, i);
=
+        if (ks->mda_key_id =3D=3D mda_key_id && ks->state > S_UNDEF)
+    =
    {
+            return ks;
+        }
+    }
+    return NULL;
+}
+#endi=
f
+
 #endif /* SSL_COMMON_H_ */
diff --git a/src/openvpn/ssl_verify=2Ec b/s=
rc/openvpn/ssl_verify=2Ec
index 063fa5d=2E=2E7375e87 100644
--- a/src/openv=
pn/ssl_verify=2Ec
+++ b/src/openvpn/ssl_verify=2Ec
@@ -1249,22 +1249,24 @@
=
 tls_authenticate_key(struct tls_multi *multi, const unsigned int mda_key_i=
d, const bool auth,
                      const char *client_reason)
 {
-  =
  bool ret =3D false;
+    struct key_state *ks =3D NULL;
     if (multi)
 =
    {
-        int i;
         auth_set_client_reason(multi, client_reason)=
;
-        for (i =3D 0; i < KEY_SCAN_SIZE; ++i)
+        ks =3D get_key_by=
_management_key_id(multi, mda_key_id);
+
+        if (ks)
         {
-     =
       struct key_state *ks =3D get_key_scan(multi, i);
-            if (ks=
->mda_key_id =3D=3D mda_key_id)
-            {
-                ks->mda_sta=
tus =3D auth ? ACF_SUCCEEDED : ACF_FAILED;
-                ret =3D true;
-=
            }
+            ks->mda_status =3D auth ? ACF_SUCCEEDED : ACF_FA=
ILED;
+        }
+        else
+        {
+            msg(D_TLS_DEBUG_LOW,=
 "%s: no key state found for management key id "
+                         =
        "%d",
+                __func__, mda_key_id);
         }
     }
-  =
  return ret;
+    return (bool)ks;
 }
 #endif /* ifdef ENABLE_MANAGEMENT *=
/
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1856?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I42d8785959c=
24bf688190965e58b9b98251b8557
Gerrit-Change-Number: 1856
Gerrit-PatchSet: 6=

Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>

--Dn7Lv5a7OMM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos <strong=
>uploaded patch set #6</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1856?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">Introduce get_key_by_management_key_id helper function<br><br>Thi=
s function allows us to map from a management key id to a key structure<br>=
and also allows this function to be reused=2E<br><br>Patch v2: add message =
when key is not found=2E<br>Patch v3: only consider valid keys<br><br>Chang=
e-Id: I42d8785959c24bf688190965e58b9b98251b8557<br>Signed-off-by: Arne Schw=
abe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/ssl_common=2Eh<br>M =
src/openvpn/ssl_verify=2Ec<br>2 files changed, 32 insertions(+), 10 deletio=
ns(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:2941=
8/openvpn refs/changes/56/1856/6</pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_commo=
n=2Eh b/src/openvpn/ssl_common=2Eh</span><br><span>index f6392f9=2E=2Edb611=
98 100644</span><br><span>--- a/src/openvpn/ssl_common=2Eh</span><br><span>=
+++ b/src/openvpn/ssl_common=2Eh</span><br><span>@@ -759,4 +759,24 @@</span=
><br><span>     return &amp;multi-&gt;session[TM_ACTIVE]=2Ekey[KS_PRIMARY];=
</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * Gets the \c key_state  object that belong to the management key i=
d or</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * return NULL =
if not found=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline struct=
 key_state *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_key=
_by_management_key_id(struct tls_multi *multi, unsigned int mda_key_id)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; KEY_SCAN_SIZ=
E; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        struct key_state *=
ks =3D get_key_scan(multi, i);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (ks-&gt;mda_key_id =3D=3D mda_key_id &amp;&amp; ks-&g=
t;state &gt; S_UNDEF)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    return ks;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    return NULL;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span> #endif /* SSL_COMMON_H_ */</span><br><span>di=
ff --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec</span><b=
r><span>index 063fa5d=2E=2E7375e87 100644</span><br><span>--- a/src/openvpn=
/ssl_verify=2Ec</span><br><span>+++ b/src/openvpn/ssl_verify=2Ec</span><br>=
<span>@@ -1249,22 +1249,24 @@</span><br><span> tls_authenticate_key(struct =
tls_multi *multi, const unsigned int mda_key_id, const bool auth,</span><br=
><span>                      const char *client_reason)</span><br><span> {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool ret =3D false=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct key_sta=
te *ks =3D NULL;</span><br><span>     if (multi)</span><br><span>     {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        int i;</span><br>=
<span>         auth_set_client_reason(multi, client_reason);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        for (i =3D 0; i &lt; KEY_SCA=
N_SIZE; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 ks =3D get_key_by_management_key_id(multi, mda_key_id);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (ks)</span><br><span>         {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            struct key_state *ks =3D=
 get_key_scan(multi, i);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            if (ks-&gt;mda_key_id =3D=3D mda_key_id)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                ks-&gt;mda_status =3D auth ? ACF_=
SUCCEEDED : ACF_FAILED;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                ret =3D true;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            ks-&gt;mda_status =3D auth ? ACF_SUCCEEDED : ACF_FAILED;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            msg(D_TLS_DEBUG_LOW, &quot;%s: no key=
 state found for management key id &quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                                 &quot;%d&quot;,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                __func__=
, mda_key_id);</span><br><span>         }</span><br><span>     }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    return ret;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    return (bool)ks;</span><br><span=
> }</span><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span><br><span> =
</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1856?usp=3Demail">change 1856</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1856?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:non=
e"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: I42d8785959c24bf6=
88190965e58b9b98251b8557 </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 1856 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
=
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &=
lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--Dn7Lv5a7OMM=--


--===============1177692146302073811==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1177692146302073811==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1177692146302073811==--

