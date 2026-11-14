Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05623606A329
	for <openvpn-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=WriI/78v;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=MdnuHA5u;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=AgUXLhC9;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=BVG8BKxt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=nBxqaCkj+U/3Jf9vFYEOnEyehIqRD5phu6AugfCZ/9c=; b=WriI/78vQf8OJy7EK0t0WMFMFm
	0ouA2afBwhBkKxN3L8VzBpsI1XLRixdqwBChClX89zGc4F4GvfppN3dQctDF5khFdV4vwEHbJblY0
	0XYNrRxfnsCSqqQMqs9OctOYQtvOSVHV9k3Bf8DZo3EVBrcOsnPA8Zx2zLswJjpM3i3U=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSGmM-0000000075g-2mx7;
	Sat, 14 Nov 2026 16:39:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSGmK-0000000075P-2TT2
 for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 16:39:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vISBUyHfv6kFF82zOKi4JI07/ilb6kIJMS43Gi48nXY=; b=MdnuHA5uE8T7ZLQY2lwpcMaFmu
 dfRfVxVeMO4FBE4/C3CTZp3hhoCOdhmC5D8+JwaVNK6xx1UehcrA13SrNAv9KzJA3pDUAw947fhtH
 M1NXJydeAfpLLiqDnciFMpa6HNFHsHHkqvwM++8VFK9UpZh+RBwJ/fo8I8/e7WtFXVVI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vISBUyHfv6kFF82zOKi4JI07/ilb6kIJMS43Gi48nXY=; b=AgUXLhC9b+5m4cfs5prhhAkeFN
 +0eQU54fmATztVNOBmswrTuPX8buFt9xVAHZCJ9QZWILP35qrkK6LAG3pSQvoPYFdezX9zbivCQva
 ClanLQ5PLLvL/NFxwOkOPAqKreBWDNxQXcGCIV9IepmG3LtG5kUwEkJTgUm0vvIfQP/Y=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSGmJ-000000001Bp-35gn for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 16:39:00 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso13505575e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 14 Nov 2026 08:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794674333; x=1795279133; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vISBUyHfv6kFF82zOKi4JI07/ilb6kIJMS43Gi48nXY=;
 b=BVG8BKxtAx7a9ZdW5k3NO2Hzy7JWEhlZWY1iVG9jQjKFfC5a1jHCH2RTM8pwgCJRbp
 JO2YKXjsodXNohjK9zL2/AG1klzqdRRsd4bDW20U+YSoeyYEzb5Q6KQu0eUtMEU4BTHF
 c4iyzRTBoCi3IH2xrBiXuvLtHzXYxcLjumIFFaQ5vMDc8WbLtujGF4sMyetThcNa75oV
 P3MphrYIZ3RmKnPnWReAiduyHiiGdU/NvD29JAINJfDnm2himjQ2sFaQpspNBWkLnW//
 0Ur1VRwZyYiJYKZ/s5zIWIaCZm/+KcGJ+J2nIXoIioxRFng69MWbPnHWyo6UIV6JomdQ
 MCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794674333; x=1795279133;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vISBUyHfv6kFF82zOKi4JI07/ilb6kIJMS43Gi48nXY=;
 b=jD/tw/dOvYrnxLSHKCYPdkObrMv3PGWKtjBj+JgOGDgvLZqn2o9SaMjQZBKh3p9sOu
 ejerxA1ZVcwnqo3+G6LnpRlZ3tkzLgnxuPPwxSucHq2qlaq4TZrcLtvFr/aQh+wgesc5
 GBithyurBxwm3a58MjCFmPcuT3MydccS8cBvGwvSEZKJMW5L8qzEuzK1n6Gchswk4pJu
 0ODQDQV0zOJ9sWH6vDQa2Hkj3J/GzKP0plmFh+Zy+UkjMcwGzx3Dhniv857623c/Br9L
 x6QLoGgt5CjS3u9ZwbJqPNsF2o1IlPXV6JR1JAdht7FFhHinZS2q/RB6ViJjKVX/Mdf2
 m/iQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGW0gq99hH2EAEOiwXSTZAqcKUclb3fbPny+tePI4k1eQThxlnwafFV1y9nj2LPH7pU/pAComU7VoLmCeHN@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8qlB7gBb3jpFyRC95JuPZxvkymxzK10BN+tn93wkuE/ItHeivd
 MxU6cjz9Glx0ajwkwt63God7b7vaYtHLU7NdorrxdFUmcrNG37wyPM+FQNAtYc6/5kKC1P/CNdx
 wS46Fu3Nid3xoqBAB9q4hkePDJeIc6S0NP9jF9IYmE0eEfjYlV3yv6VGLOmtRHZ1bZ++6
X-Gm-Gg: AYBFou2CYGetbuL/keTG0t/dGeiazdYzvXOsmPE+9QEfIhETgoRcNFzTo81u3enKuNG
 vSf+9/fpQzEDxGVCD7ppnFGseVGAf+YAFMwYMCL8Kf4Qy8koh43DT2j/MnBP1TdKCum2qh+vklz
 1aPxMXmzGq+ndfyhhbqjw9S51LvacMlwDJEt/2++BbpckFGx4iOeY7k1FySbI0r6Bol3WIbOzTo
 nbcfVXMoXMT6IYkZsxOrU2C7Ps7AYgDJWny+GnOlZWcBaKiZTMyLQ0GBQ9VQSW/HN+iqo1msv/t
 yDZsche6tYMbbMJrqLdNXBA9Iiif10eYTgQY+CvnLS3idGiT4nPgOV7JGgawZ+7wv/rp3q5uEkz
 /Dn+ZK/gv4+cPrI5vn/dvgab0sfBIC+pTIyBul6h7J/kKwlFMOiWqiga4zJ5iW9Dq064pUQIR/t
 Nh4hXPGXXGH/IUkehpzBL160waF7o9HBGpF61wpLbqAhABkF+8JULjowhTF7NGfzn/TyxVlPZFa
 /kQ5EeVZ7/hxGSx+CE7fXJnge+voOejtOoNZMSAi6e4Jt/R6tMIYgEfbIebq5m3ys5qFbohqhSq
 fhAlEUXQmltG2gID+3vER/L4jW99EbrMA7z7WpUk5ukO2X8po1xlCYCye+V1ruDRuXA6uOoXyE/
 9uNO3U+JL2BZhVeMv1bXx9sUciCYsnXXWaHq9lJmBz0KB7oseOEi558njCUr1n3wZolwO/ay80/
 uJ7g3YccG6ZL/Khv8=
X-Received: by 2002:a05:600c:3487:b0:4a4:f48e:78fa with SMTP id
 5b1f17b1804b1-4bb55a4ea9dmr129917925e9.12.1794674332982; 
 Sat, 14 Nov 2026 08:38:52 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c608c5debsm11358869f8f.42.2026.11.14.08.38.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 08:38:52 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 14 Nov 2026 16:38:52 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ib33ce23448959673affdfd462b4c2cfa9a015f55
X-Gerrit-Change-Number: 2132
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2132?usp=email>
X-Gerrit-Commit: cb1a5c6bf7043a5c330b15679fa6fe22090ee3d0
In-Reply-To: <gerrit.1793800715000.Ib33ce23448959673affdfd462b4c2cfa9a015f55@gerrit.openvpn.net>
References: <gerrit.1793800715000.Ib33ce23448959673affdfd462b4c2cfa9a015f55@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzODAwNzE1MDAwLkliMzNjZTIzNDQ4OTU5NjczYWZmZGZkNDYyYjRjMmNmYTlhMDE1ZjU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fa6a0ffe376862517c5f675e8bb69180f23eb361-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSGmJ-000000001Bp-35gn
Subject: [Openvpn-devel] [S] Change in openvpn[master]: push_util: use
 string_alloc() instead of a local gc_strdup()
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8483380361587483376=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8483380361587483376==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UG8Z6OFVXGQ="; charset=UTF-8

--UG8Z6OFVXGQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2132?usp=3Demail )

Change subject: push_util: use string_alloc=
() instead of a local gc_strdup()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

push_util: use string_alloc() instead of a local gc_=
strdup()

gc_strdup() duplicated string_alloc() for its only caller=2E Whil=
e here,
fix the typos in the message_splitter() comment=2E

Change-Id: Ib33=
ce23448959673affdfd462b4c2cfa9a015f55
Signed-off-by: Razvan Cojocaru <razva=
nc@mailbox=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Ger=
rit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2132
Message-Id: <20261=
104174327=2E15221-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archiv=
e=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40715=2Ehtml
Signed-off-=
by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/push_util=2Ec
=
1 file changed, 3 insertions(+), 12 deletions(-)




diff --git a/src/openv=
pn/push_util=2Ec b/src/openvpn/push_util=2Ec
index 34cb26c=2E=2E0c27575 100=
644
--- a/src/openvpn/push_util=2Ec
+++ b/src/openvpn/push_util=2Ec
@@ -78,=
17 +78,8 @@
     return buf;
 }
 
-static char *
-gc_strdup(const char *src=
, struct gc_arena *gc)
-{
-    char *ret =3D gc_malloc((strlen(src) + 1) * =
sizeof(char), true, gc);
-
-    strcpy(ret, src);
-    return ret;
-}
-
-/*=
 It split the messagge (if necessary) and fill msgs with the message chunks=
=2E
- * Return `false` on failure an `true` on success=2E
+/* Split the mes=
sage (if necessary) and fill msgs with the message chunks=2E
+ * Return `fa=
lse` on failure and `true` on success=2E
  */
 static bool
 message_splitte=
r(const char *s, struct buffer_list *msgs, struct gc_arena *gc, const size_=
t safe_cap)
@@ -98,7 +89,7 @@
         return false;
     }
 
-    char *st=
r =3D gc_strdup(s, gc);
+    char *str =3D string_alloc(s, gc);
 
     whil=
e (*str)
     {

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2132?usp=3Demail
To unsubscribe, or for help writing mail filters, visi=
t https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib33=
ce23448959673affdfd462b4c2cfa9a015f55
Gerrit-Change-Number: 2132
Gerrit-Pat=
chSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-=
Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank =
Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>

--UG8Z6OFVXGQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2132?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">push_util: use string_alloc() inst=
ead of a local gc_strdup()<br><br>gc_strdup() duplicated string_alloc() for=
 its only caller=2E While here,<br>fix the typos in the message_splitter() =
comment=2E<br><br>Change-Id: Ib33ce23448959673affdfd462b4c2cfa9a015f55<br>S=
igned-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Fr=
ank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2132<br>Message-Id: &lt;20261104174327=2E152=
21-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/o=
penvpn-devel@lists=2Esourceforge=2Enet/msg40715=2Ehtml<br>Signed-off-by: Ge=
rt Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/push_uti=
l=2Ec<br>1 file changed, 3 insertions(+), 12 deletions(-)<br><br></pre>
<pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/src/openvpn/push_util=2Ec b/src/openvpn/push_util=2Ec</span><b=
r><span>index 34cb26c=2E=2E0c27575 100644</span><br><span>--- a/src/openvpn=
/push_util=2Ec</span><br><span>+++ b/src/openvpn/push_util=2Ec</span><br><s=
pan>@@ -78,17 +78,8 @@</span><br><span>     return buf;</span><br><span> }<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-stat=
ic char *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-gc_strdup(co=
nst char *src, struct gc_arena *gc)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ch=
ar *ret =3D gc_malloc((strlen(src) + 1) * sizeof(char), true, gc);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    strcpy(ret, src);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    return ret;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* It split the messagg=
e (if necessary) and fill msgs with the message chunks=2E</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * Return `false` on failure an `true` =
on success=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Spl=
it the message (if necessary) and fill msgs with the message chunks=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Return `false` on fai=
lure and `true` on success=2E</span><br><span>  */</span><br><span> static =
bool</span><br><span> message_splitter(const char *s, struct buffer_list *m=
sgs, struct gc_arena *gc, const size_t safe_cap)</span><br><span>@@ -98,7 +=
89,7 @@</span><br><span>         return false;</span><br><span>     }</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char =
*str =3D gc_strdup(s, gc);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    char *str =3D string_alloc(s, gc);</span><br><span> </span><br><=
span>     while (*str)</span><br><span>     {</span><br></pre><p>To view, v=
isit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2132?usp=3Demail=
">change 2132</a>=2E To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings<=
/a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction">=
<link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
132?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div s=
tyle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display=
:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Id: Ib33ce23448959673affdfd462b4c2cfa9a015f55 </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Number: 2132 </div>
<div style=3D"display:none"> =
Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;fr=
ank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body>=
</html>
--UG8Z6OFVXGQ=--


--===============8483380361587483376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8483380361587483376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8483380361587483376==--

