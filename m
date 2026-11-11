Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFA6606A327
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=PG8fk4ar;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=aV+LQUPH;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=kVb/udQr;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Ipz9QyjN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=viTeUFfa7RbG52bomwbss1egAR63FHpRYE6/xNLAoV0=; b=PG8fk4arNb39kfWMBz5QGL35wV
	fq9iDdg6beNOdI+BRLIc6TNM73EAgsH0E9f4z2BV1TtvOV4JZrdGl36bexhAPk1fDQmJzu2L91FvR
	inorNG93CHyZJEUx/bh95RUYhQac9cgSr8XlozjW8fdr6TTSM8WTVb0P/jGTaOFJIJ1g=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xR4KC-000000000Ea-3Bb7;
	Wed, 11 Nov 2026 09:09:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xR4KB-000000000DJ-1H6l
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 09:08:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YB1abodumueK7gRMEevY6ZoTeOSmtSx4W+xYY89KjqU=; b=aV+LQUPHdLRZEhAjYZ5IeqvY22
 kVP1SwsHYg7Chs7HKXzDwP/8A5hXPtN4FwfQxKM+2SjpvoyyadcRwIJwTfO51/vcM3Lb7uOiiYmmS
 zeiIPnQyEsf8rAlG4XPBUaYjEfVfiW33p7V9EbG3fs7le6lx+0fk5E8Pqt8rgvwjjRhw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YB1abodumueK7gRMEevY6ZoTeOSmtSx4W+xYY89KjqU=; b=kVb/udQripzmrR4PrXjsGqNv6x
 zEFAS7d4zCbJoFamF36qHUOcO6aTbXOi/QObFoxTjwJDS2MjQKnB91G5Sbudp9g0Cl7vy7IcX2X/g
 RT8Qqc0v/A+iXrEuI3rleMgkVZWs4DUd0gq1mtcV/Xth+3IRdjujCb8/zg1Y0eoe76cE=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xR4K9-000000001NI-28IS for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 09:08:58 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so34932145e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 01:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794388131; x=1794992931; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YB1abodumueK7gRMEevY6ZoTeOSmtSx4W+xYY89KjqU=;
 b=Ipz9QyjNIN7eCcRbQJqKEWCnrzxzP8q6Dy48WMjFBCeaK0YxL0jqi67UFN37C0SVtI
 /PLnj6zoQNF5NeTlbFis0Wgc/ZdWeLJGT1m40RgtR8h2owiU3FaG+6GIaiHnfDr3sbx4
 YvtIB4WbVC2IDhTPUNyRQ78KaJeFWLnKKr2Chr/ZKbvZfMUqPQisucmrPlVbgCM4QZqr
 esCaffF10OcY+SIvov71EbGanC38wfcr7rEwBui4nv3Uncu487cTg3BBPRiSUUCC3fB6
 DVOcsOjwJohvqrKrK8QUd9mgpyIPmdSexAAoCvzN5AWEAYfWMhPeLlGi+i/WZqTcC6sS
 QZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794388131; x=1794992931;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YB1abodumueK7gRMEevY6ZoTeOSmtSx4W+xYY89KjqU=;
 b=ONdziFJhJq2kgkZj6o5O2DvoO56PNHGEH1NPSiMKqN6Owvy3ZWxqKV4SvmNV7MZ5/W
 /O1u6hkyTWs0YbYHeO2kmc/cf8JnwAD7QItZZkqGsmSiNx7Y4d9KLZTDrS6tDrzyAeLf
 c5uGSRVIWrJfUSgxcDXAKVqgw5Lj6dSDgek9bbyir+0D7ChJ5H8MoHLHkCgHxWIHHJyC
 GALk7Uxpcj3EINVHVEtPl2pMWotCb+31SEHy685v0O5gq4MOA+Mz4ljMhim38GHlH6Lm
 vVYc0zmEckJ7EMo95aEkPgvSNw0SR7AEYqeIqdxuJxIjUu4Z+svMwDLVRhqITgDpIWNd
 36/Q==
X-Gm-Message-State: APuU4Z9htRpJmmlDU7KdS9KrZ8ZzE53BJHoG2+HGpcDRNyTx9wKnagJN
 jpN0CTsU7bAi2zlSS1IGlwdIuWd8I4Yk7UTRe/bzmJje28e7ui2s5mbUWN4iuVRdx61lEgmEnlY
 AOxjONdxN7tSMrkubXgHKgz8dcrrGNcvNUurGtrzjBMQnEya2hEPwtRD6bJcQTh02KCkK
X-Gm-Gg: AYBFou3Ru5lgvqavUh0ARQDTqVNnJiS3Qd1RAG0ZXTzAwj0fRvDBRrr6d296Da/18Qp
 2ATGNFTUhN2Qphd51TJOJYIIv7ozkuTzQh06RUzypD6G9dcH5ngSy3wCMA4iKIrLysKr7XRHyYK
 xYOmHrmxpVB9XXbUyQYqZZoLQP8TnnfKgHJ7q7xLX32C0sV8i2d3vHhSTF8cnI8vEHsNXszcecv
 BP2Zu9a2jfKJThSl1ghNeRtqtCYMogXmy762F0wpfms471fkC5wiRH5BD3C2zeHCGR+kjLn19cH
 80Ws1TICm1T3oiASYF9JKYSs1OQw3h9X0TIiQNT0JZjqeLB8/L7WMVOzIabRuDG0ukbfk8ZHg2x
 S0xDQ0o+1VwJuRBuVh8QljMJKlll5Pd6xIfkJyiY1whwLTA6UO817nwVNuxn1pONWUo8JubRZoq
 DfihG2OaMKJaJgT6m9SrBw/o8UTx7qukecFY3EJTxP7pgI9ljRLB6269zL9S6Fc8S+uq0JSlP7G
 mhKkuk73wh3132AegkqX0HcGOaK98w8feVW0X33kUJgs7sWUWLlPhQw2ntGfml74ZDo0UsOh2Qd
 2WG9Z8gt0M2SuR1M8ZONDErjHPclw51C3RmMCzlNL91D8FdyBj2F0a+PqzeR7UgX72FpudFJUlO
 S6zuZvUDCDcE4bOsc8IE2n7QAQKEVs97TSs4DT6pZpIVu4rWLfeWq95cxy4oeLQy5IXRmXoMvby
 9Vha4fNlXkKlTMNZE=
X-Received: by 2002:a05:600c:470d:b0:4a2:133:45e1 with SMTP id
 5b1f17b1804b1-4ba09380609mr31018635e9.24.1794388130768; 
 Wed, 11 Nov 2026 01:08:50 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498811fa70esm8606260f8f.19.2026.11.11.01.08.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 01:08:50 -0800 (PST)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 09:08:50 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ia99aacf7ad7b6863b2f2a7297d0229faae529d9f
X-Gerrit-Change-Number: 2174
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2174?usp=email>
X-Gerrit-Commit: d03d45e235cc417983829e81c8a5d3ef98ff380d
References: <gerrit.1794388129000.Ia99aacf7ad7b6863b2f2a7297d0229faae529d9f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0Mzg4MTI5MDAwLklhOTlhYWNmN2FkN2I2ODYzYjJmMmE3Mjk3ZDAyMjlmYWFlNTI5ZDlmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4c2d366975bf9784f95a2cc6cd57bfa0e0dece84-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xR4K9-000000001NI-28IS
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: don't
 leave stale domains in unused NRPT exclude slot
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3507297644457317042=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3507297644457317042==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RUm5oLuP90A="; charset=UTF-8

--RUm5oLuP90A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2174?usp=3Demail

to review the following change=2E
=


Change subject: openvpnserv: don't leave stale domains in unused NRPT exc=
lude slot
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

o=
penvpnserv: don't leave stale domains in unused NRPT exclude slot

GetNrptE=
xcludeData() fills data[i]=2Edomains before it knows whether the
interface =
will be used=2E If the interface is then skipped, because it
has no name se=
rvers or reading them fails, i is not advanced and the
domains stay in data=
[i] until the next interface overwrites them=2E

When the skipped interface=
 is the last one enumerated, nothing
overwrites them=2E SetNrptExcludeRules=
() stops at the first entry with
domains_size =3D=3D 0, so it then creates =
an exclude rule from the stale
domains, with an empty or incomplete name se=
rver list=2E

Clear domains_size of the unused slot on the way out=2E

Brok=
en since 0f3b7d17 ("win: implement --dns option support with
NRPT")=2E

Cha=
nge-Id: Ia99aacf7ad7b6863b2f2a7297d0229faae529d9f
Signed-off-by: Antonio Qu=
artulli <antonio@mandelbit=2Ecom>
---
M src/openvpnserv/interactive=2Ec
1 f=
ile changed, 7 insertions(+), 1 deletion(-)



  git pull ssh://gerrit=2Eop=
envpn=2Enet:29418/openvpn refs/changes/74/2174/1

diff --git a/src/openvpns=
erv/interactive=2Ec b/src/openvpnserv/interactive=2Ec
index 81205d6=2E=2Eff=
48bb7 100644
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/in=
teractive=2Ec
@@ -2482,13 +2482,13 @@
 {
     HKEY v4_itfs =3D INVALID_HAND=
LE_VALUE;
     HKEY v6_itfs =3D INVALID_HANDLE_VALUE;
+    size_t i =3D 0;
=
 
     if (!GetInterfacesKey(AF_INET, &v4_itfs) || !GetInterfacesKey(AF_INE=
T6, &v6_itfs))
     {
         goto out;
     }
 
-    size_t i =3D 0;
    =
 DWORD enum_index =3D 0;
     while (i < data_size)
     {
@@ -2583,6 +2583=
,12 @@
     }
 
 out:
+    /* data[i] is not in use, but may still hold the=
 domains of a skipped
+     * interface=2E Clear them, the caller stops at =
the first empty entry=2E */
+    if (i < data_size)
+    {
+        data[i]=
=2Edomains_size =3D 0;
+    }
     RegCloseKey(v6_itfs);
     RegCloseKey(v=
4_itfs);
 }

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2174?usp=3Demail
To unsubscribe, or for help writing mail filters, visit ht=
tps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newc=
hange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia99a=
acf7ad7b6863b2f2a7297d0229faae529d9f
Gerrit-Change-Number: 2174
Gerrit-Patc=
hSet: 1
Gerrit-Owner: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Re=
viewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel =
<openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <a=
rne-openvpn@rfc2549=2Eorg>

--RUm5oLuP90A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Antonio Quartulli would like =
Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2174?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">openvpnserv: don&#39;t leave stale domains in unused NRPT =
exclude slot<br><br>GetNrptExcludeData() fills data[i]=2Edomains before it =
knows whether the<br>interface will be used=2E If the interface is then ski=
pped, because it<br>has no name servers or reading them fails, i is not adv=
anced and the<br>domains stay in data[i] until the next interface overwrite=
s them=2E<br><br>When the skipped interface is the last one enumerated, not=
hing<br>overwrites them=2E SetNrptExcludeRules() stops at the first entry w=
ith<br>domains_size =3D=3D 0, so it then creates an exclude rule from the s=
tale<br>domains, with an empty or incomplete name server list=2E<br><br>Cle=
ar domains_size of the unused slot on the way out=2E<br><br>Broken since 0f=
3b7d17 (&quot;win: implement --dns option support with<br>NRPT&quot;)=2E<br=
><br>Change-Id: Ia99aacf7ad7b6863b2f2a7297d0229faae529d9f<br>Signed-off-by:=
 Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt;<br>---<br>M src/openvpns=
erv/interactive=2Ec<br>1 file changed, 7 insertions(+), 1 deletion(-)<br><b=
r></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn r=
efs/changes/74/2174/1</pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;"><span>diff --git a/src/openvpnserv/interactive=2Ec =
b/src/openvpnserv/interactive=2Ec</span><br><span>index 81205d6=2E=2Eff48bb=
7 100644</span><br><span>--- a/src/openvpnserv/interactive=2Ec</span><br><s=
pan>+++ b/src/openvpnserv/interactive=2Ec</span><br><span>@@ -2482,13 +2482=
,13 @@</span><br><span> {</span><br><span>     HKEY v4_itfs =3D INVALID_HAN=
DLE_VALUE;</span><br><span>     HKEY v6_itfs =3D INVALID_HANDLE_VALUE;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t i =3D 0;</spa=
n><br><span> </span><br><span>     if (!GetInterfacesKey(AF_INET, &amp;v4_i=
tfs) || !GetInterfacesKey(AF_INET6, &amp;v6_itfs))</span><br><span>     {</=
span><br><span>         goto out;</span><br><span>     }</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t i =3D 0;</s=
pan><br><span>     DWORD enum_index =3D 0;</span><br><span>     while (i &l=
t; data_size)</span><br><span>     {</span><br><span>@@ -2583,6 +2583,12 @@=
</span><br><span>     }</span><br><span> </span><br><span> out:</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /* data[i] is not in use, b=
ut may still hold the domains of a skipped</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * interface=2E Clear them, the caller stops at =
the first empty entry=2E */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (i &lt; data_size)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        data[i]=2Edomains_size =3D 0;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span>     RegCloseKey(v6_itfs);</span><b=
r><span>     RegCloseKey(v4_itfs);</span><br><span> }</span><br></pre><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2174?usp=
=3Demail">change 2174</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2174?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Ia99aacf7ad7b6863b2f2a7297d0229faae529d9f </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2174 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;open=
vpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none">=
 Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

=
</body></html>
--RUm5oLuP90A=--


--===============3507297644457317042==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3507297644457317042==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3507297644457317042==--

