Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1886EC43458
	for <openvpn-devel@archiver.kernel.org>; Tue, 14 Jul 2026 10:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rq0OunbdAeAGUUkEpFlVlDiedO9CKiwBnUjI8GEsSG0=; b=ahHu8AfOBRkEUuipA3fuWsO07I
	Px1k+Bd4sO5z4eYBM95i5fsQ/T9O/vAxwhRq/FUBGNbH2LN5VYs+yn/1mWP1fdUkAa38aUZfq6FxS
	+RFQKjnHFIjsacNz7NScheeZAuj5/kYvC43fcx4sU5K7qRN3U0/ZYwUuVWHhBPmoqaII=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjajt-0006re-9z;
	Tue, 14 Jul 2026 10:51:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjajs-0006rS-Ei
 for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 10:51:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=G5qjs3I9WeGCTquKx6QWgdlhwoT4OWuC5ckCOuIZRl0=; b=P9lBlEVVSbHtTdiD7QcqcxlI8z
 OKVM7M/I16Ulu8mCoFVYTrwIp+yurR6SSMDg5ToXijgTSKtbBtvy2pXN7/wcC+FkFJKG+r8sN3rX5
 Ek/2hqeM6kjW6ytC7Mn65n+jOELMwZOKZhJtvrbNGaDu0mg8YAZc6WMvJtmyMBgPN7q4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=G5qjs3I9WeGCTquKx6QWgdlhwoT4OWuC5ckCOuIZRl0=; b=j
 AJawJr4dYmRq13rxUSWYWGraYyegJ6n259yIUs2/XKr2d54JfGZEcfFlyL1Ji/oOUUCG+XUdE5o5n
 txYL7RkbyEXt5wflD/IurejcSo4sq+TnrQ8+PWJz78gN8RT5pCme9rRDxOlODvseA+YDUTJebBIok
 T7tO86cEV5RQxq9Q=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjajk-0001aC-FI for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 10:51:41 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-493bb510ce4so29479535e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 14 Jul 2026 03:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784026289; x=1784631089; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=G5qjs3I9WeGCTquKx6QWgdlhwoT4OWuC5ckCOuIZRl0=;
 b=J3tEa8IMUSsaeBQ9C9uJ78k1TVCPf62QwYxgHs9SpzlmTvt5ZrMIBuGkAiitCPb0Vy
 h4y+Ww6AFnJZw3HY81YDkxYKVGjO0bYQaW3NT9IQpTmykcsZkgw0qLiMALP7wyFSPCHR
 WNfXcwWDfRoTXMZCd2xKBDqIGDhmxknTjaKV9JEUpdjUVIOwLHkFak62wT6NyYYE9eTK
 F9xi/EXPyXM9nV5sRQJpv0jYmsML6uDA17OVSagE9uvOKqFUYXF+hVmVXONcAszRiKT9
 D9T3RB73SwxwH2XmkhksDo+ltfHSdmWLCfNPOWjzpnY8+qEUpxgssL6PJUSA5r1Z7g/k
 Pvpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784026289; x=1784631089;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=G5qjs3I9WeGCTquKx6QWgdlhwoT4OWuC5ckCOuIZRl0=;
 b=So+M1zHA3JXD/8YcO3teZvrPjU6NOzO7EQSpJrhzbnz8+n8ldoRav+Z/honrR32fA3
 DdzKJy7t/J9WB4gIc3suyTlUQRgeJJRaB/EA4TqOOyEbABSPRpSLWA9VcObCtTU33ewn
 9r1Zky86IR5c9qToILKYvSEU7LPQjXJH+lj4XT6dyQ8qP8ytlJqYrykWjZZ+xitEt5vL
 zeQ9l9qQOdb+MbxibmnkYXowohRUpiFi5Ns+HTluyV1DdrOgijbZbJ9DtOADDL+DqRn3
 JGWvvHJ4UklxjoNxqpLSct1XmvkWUQ8pLw9KMMGgms2XT8W5rARPpaI1n2gQ4A6U/KHv
 G0uA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrZF2lnXcR7PDf2PaEkKmMEZPJEyNvTvmk0zRTZDYxnNNiingM6XbZiPDKmDN0Edkkk1zV7W+pj9Sc3Friq@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzPfKfHKjvXp5gvBdZsjWrIK655LOsmaH9Ze1QmQD66UwgjVDa2
 wTQJETZWV6eV0f1JcFyDz4s3sMrYlN2M9bM7dZIA+QUJg36bPzg6hqnukQorIVFp13fFxlQIxwk
 jbORg4nN6XdDUKZ7QDCEXlEtVBT/lDRnNcOaqzQW2hOF120S8rXs91O0EVMveSHKILaXs
X-Gm-Gg: AfdE7cm/ZF6N8hfGU9yONN+cMLtk93NpBk6vHGc24+JoVJEbM2OwQBxB9nGDQMzxNee
 hq7YLo39K8lPUteUtv4SQb3VgcZi5EhawQ6nMo8v8Vx4qSCRbSXOHgYfbV+fD0JWZe4zvUrBvdz
 nofsnsVHMZhtoszMVZ2l+Sx+o12KckpUkvwOuMi+PGcY4XLzIMkqHUfyJGBuYepTtgbcJTe7hUE
 INTm8aX2EjA5rBmdIRaZEYpOnjFABKFSjetqk7Fuh02IQ/go0T/2T7UqkOMUlgZ/vChVTJTSYnt
 Wy79hf0WlsGoUB4Sn81PK9ERyzmvgoXitz98OFsEuCgbtP6hjLmvRo5Ql5Odli7LdcV3JY99XIZ
 m12EbVi7mJAJVPlfshvfmM+vINGtWU5zKCD5RK6yDzcRWOTEr5opQapj72MLYHl3E4s7uALE9AO
 q1JB3pV/UaQfgNwaVsFVq2TCpvVDu58uYQOkGWm7QDrclGuKB6qAOvqJcvnltiL7T3DMLyjx4Bj
 SWz1fZpGQh0bmWPUaG44sdRkR8a2IGa0X/zB14GYx+eS1h8UVHkGcujQeFiqw1Zpxr/4XyIkI/f
 kk4=
X-Received: by 2002:a05:600c:1896:b0:493:f59e:e756 with SMTP id
 5b1f17b1804b1-495389cddabmr13267825e9.29.1784026288835; 
 Tue, 14 Jul 2026 03:51:28 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495086ca93esm64863205e9.0.2026.07.14.03.51.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 03:51:28 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 14 Jul 2026 10:51:27 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Ic677f43fc3eb0052f8e80d9a7f098d34ad03dfe1
X-Gerrit-Change-Number: 1740
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1740?usp=email>
X-Gerrit-Commit: e8d39061007b0a29f78cecce72a0269d6dd3ecde
In-Reply-To: <gerrit.1782719911000.Ic677f43fc3eb0052f8e80d9a7f098d34ad03dfe1@gerrit.openvpn.net>
References: <gerrit.1782719911000.Ic677f43fc3eb0052f8e80d9a7f098d34ad03dfe1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkljNjc3ZjQzZmMzZWIwMDUyZjhlODBkOWE3ZjA5OGQzNGFkMDNkZmUxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <45ee9974c7e8cfdee5b1f965cffa8cf19d9b74cf-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjajk-0001aC-FI
Subject: [Openvpn-devel] [S] Change in openvpn[master]: buffer: Add
 buf_read_u64() and buf_write_u64()
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0650325952890219542=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0650325952890219542==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="u0eeT3Gzs/0="; charset=UTF-8

--u0eeT3Gzs/0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1740?usp=3Demail )

Change subject: buffer: Add buf_read_u64() and buf_=
write_u64()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

b=
uffer: Add buf_read_u64() and buf_write_u64()

Add 64-bit big-endian buffer=
 accessors alongside the existing 8/16/32-bit
helpers, using htonll()/ntohl=
l() for the byte-order conversion=2E

buf_read_u64() reports success via a =
bool out-parameter, mirroring
buf_read_u32()=2E

Change-Id: Ic677f43fc3eb00=
52f8e80d9a7f098d34ad03dfe1
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
=
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1740
Message-Id: <20260714092552=2E18685-=
1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-de=
vel@lists=2Esourceforge=2Enet/msg37578=2Ehtml
Signed-off-by: Gert Doering <=
gert@greenie=2Emuc=2Ede>
---
M src/openvpn/buffer=2Eh
1 file changed, 32 in=
sertions(+), 0 deletions(-)




diff --git a/src/openvpn/buffer=2Eh b/src/o=
penvpn/buffer=2Eh
index fcc923b=2E=2E1db9367 100644
--- a/src/openvpn/buffe=
r=2Eh
+++ b/src/openvpn/buffer=2Eh
@@ -25,6 +25,7 @@
 
 #include "basic=2Eh=
"
 #include "error=2Eh"
+#include "integer=2Eh"
 
 #define BUF_SIZE_MAX 100=
0000
 
@@ -702,6 +703,13 @@
 }
 
 static inline bool
+buf_write_u64(struct =
buffer *dest, uint64_t data)
+{
+    uint64_t u64 =3D htonll(data);
+    re=
turn buf_write(dest, &u64, sizeof(uint64_t));
+}
+
+static inline bool
 buf=
_copy(struct buffer *dest, const struct buffer *src)
 {
     return buf_wri=
te(dest, BPTR(src), BLENZ(src));
@@ -827,6 +835,30 @@
     }
 }
 
+/* Read =
a 64-bit big-endian value (see buf_write_u64())=2E Sets *good to indicate
+=
 * success, like buf_read_u32()=2E */
+static inline uint64_t
+buf_read_u64=
(struct buffer *buf, bool *good)
+{
+    uint64_t ret;
+    if (!buf_read(b=
uf, &ret, sizeof(uint64_t)))
+    {
+        if (good)
+        {
+        =
    *good =3D false;
+        }
+        return 0;
+    }
+    else
+    {
=
+        if (good)
+        {
+            *good =3D true;
+        }
+    =
    return ntohll(ret);
+    }
+}
+
 /** Return true if buffer contents are=
 equal */
 static inline bool
 buf_equal(const struct buffer *a, const stru=
ct buffer *b)

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1740?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttp://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merg=
ed
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic677f43=
fc3eb0052f8e80d9a7f098d34ad03dfe1
Gerrit-Change-Number: 1740
Gerrit-PatchSe=
t: 4
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: cron2 <ge=
rt@greenie=2Emuc=2Ede>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ec=
om>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: open=
vpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--u0eeT3Gzs/0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1740?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">buffer: Add buf_read_u64() and buf_write_u=
64()<br><br>Add 64-bit big-endian buffer accessors alongside the existing 8=
/16/32-bit<br>helpers, using htonll()/ntohll() for the byte-order conversio=
n=2E<br><br>buf_read_u64() reports success via a bool out-parameter, mirror=
ing<br>buf_read_u32()=2E<br><br>Change-Id: Ic677f43fc3eb0052f8e80d9a7f098d3=
4ad03dfe1<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>Acked=
-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1740<br>Message-Id: &lt;2026071409255=
2=2E18685-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37578=2Ehtml<br>Signed-of=
f-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/=
buffer=2Eh<br>1 file changed, 32 insertions(+), 0 deletions(-)<br><br></pre=
>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><=
span>diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh</span><br=
><span>index fcc923b=2E=2E1db9367 100644</span><br><span>--- a/src/openvpn/=
buffer=2Eh</span><br><span>+++ b/src/openvpn/buffer=2Eh</span><br><span>@@ =
-25,6 +25,7 @@</span><br><span> </span><br><span> #include &quot;basic=2Eh&=
quot;</span><br><span> #include &quot;error=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;integer=2Eh&quot;</span><b=
r><span> </span><br><span> #define BUF_SIZE_MAX 1000000</span><br><span> </=
span><br><span>@@ -702,6 +703,13 @@</span><br><span> }</span><br><span> </s=
pan><br><span> static inline bool</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+buf_write_u64(struct buffer *dest, uint64_t data)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    uint64_t u64 =3D htonll(data);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    return buf_write(dest, &amp;u6=
4, sizeof(uint64_t));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static inline bool</span><br><span>=
 buf_copy(struct buffer *dest, const struct buffer *src)</span><br><span> {=
</span><br><span>     return buf_write(dest, BPTR(src), BLENZ(src));</span>=
<br><span>@@ -827,6 +835,30 @@</span><br><span>     }</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* R=
ead a 64-bit big-endian value (see buf_write_u64())=2E Sets *good to indica=
te</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * success, like =
buf_read_u32()=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static inline uint64_t</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+buf_read_u64(struct buffer *buf, bool *good)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    uint64_t ret;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (!buf_read(buf, &amp;ret, sizeof(uint64_t)))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (good)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            *good =3D false;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        return 0;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if (good)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            *good =3D true;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return ntohll(ret);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> /** Return true if buffer contents are equal */=
</span><br><span> static inline bool</span><br><span> buf_equal(const struc=
t buffer *a, const struct buffer *b)</span><br><span></span><br></pre><p>To=
 view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1740?usp=
=3Demail">change 1740</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1740?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
=
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"d=
isplay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ger=
rit-Change-Id: Ic677f43fc3eb0052f8e80d9a7f098d34ad03dfe1 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1740 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: open=
vpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></=
html>
--u0eeT3Gzs/0=--


--===============0650325952890219542==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0650325952890219542==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0650325952890219542==--

