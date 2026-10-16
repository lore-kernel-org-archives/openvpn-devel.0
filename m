Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12780CCA464
	for <openvpn-devel@archiver.kernel.org>; Fri, 16 Oct 2026 06:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u77eQayruHIpVYYPXgDm2hDpvU7yaKoTYq7qmeb7BtU=; b=f9rRy8oFCgJfU+wlfkFXxgbjKI
	2l6jcGNfVFCbE85g6mJowFpXfjXLP+ED7Bj3wxyDlPTzPPIbzg7RzIOfAatGNDCBfM47JUHDWZFk6
	byAkiTdocU2LK++rixJj3Ethy0fxy/s5qqVqa+VszI0CRJQIuhGi6TnGvpnmwj7ellYQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xHb2B-0002aE-5C;
	Fri, 16 Oct 2026 06:03:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xHb29-0002a4-A6
 for openvpn-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 06:03:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=LT2G2vjPs0xcFxSNuDVdMn0gjMEDEh8J6vUPDvO2/+k=; b=dmSRNHyN2e1qho9Rpm+Wy8vbNE
 gCffobJhIeSYgKc1H2l3IG0XhTuTFxZr0sgLLU3c32bwhWPS76TxkFSQ0w4UiGxiX0Dab40/+CcfP
 aBB91QvkmrumThUzRRBPOiylEntQL0HXCZWlJg3HgC93p0PrRqKKGfz3iyxsrl1jSI6c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=LT2G2vjPs0xcFxSNuDVdMn0gjMEDEh8J6vUPDvO2/+k=; b=c
 93SuaNncYQwMd4D9NMCgHv5vQ8UEJiKZWL/T7dMy1IkfOMA/7hT16NtyAa7ElJMK+LdmlVe3iBgNB
 obmmO1AFwvJyl3VJcF48/q/8PepOEiknDWUQoUkElnxQYvxNWoqVOFBhDlq8uLIF7DNRsfAm0Axd1
 hNScYel7eJDHRRLw=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xHb28-00032q-MF for openvpn-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 06:03:14 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4980fe6b3beso3752225e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 15 Oct 2026 23:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792130586; x=1792735386; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LT2G2vjPs0xcFxSNuDVdMn0gjMEDEh8J6vUPDvO2/+k=;
 b=Kdnyf5oX8A0iHFEiiyiVwyx2Ku2fbZo9/hX0YdM+5NEP5N5gfg4RCwX7zrT/AU0Hg+
 vusPd6GbkAeC6nHWv/FJ8US5e28aDL5ZMu2kyUTR34qxBlCeY25imwlX2pb/bq22i4wX
 n9YeEqNJD+3juCfpIheTYEek4Trc2ID3Wvw1q71bX+przCiGvMSOwPMNXbXNcb54nzCT
 to/gVkH/Td7QewzUyw/ZS/Nz+8w/87WAq1XLgO9BY3wg0VQs6yIUGiIp9FR1iTSzf3b+
 rJkTbt5OKzAMB1uyUFnXyEmoP5wA6iUUVE8Srx13vRsYHF1be0KsCCiAAfWaXzuwuqN1
 K1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792130586; x=1792735386;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LT2G2vjPs0xcFxSNuDVdMn0gjMEDEh8J6vUPDvO2/+k=;
 b=XMS5rf4U1+p5Cg9KnFTVNw2/bp2We+RcewYKHid64F83nrxlpe39Vqmv6D4VsmZu/h
 PPoCKIo4gBHoE4os3fHgCm3z8lxOaVS/KOJoQSV9wcWhC5f64ibJhJva1hi781HgnHtf
 dawQtHR/vEBPdlw2knxKVBYyOr1mn5f3kV1KpyyftqoeaZHObDPY1LVqnc2Q2fhQshn+
 TpCxTDLyyssRKTZo/V4AUuH1tw7YN48AshiOwCZOfptxHk3BYkiraMrMKFfGlj7wWxT1
 cvWXstlATDuCBbEN2/o8+yluyqYALFSg547xYCeX/2fMT98lWL5s56xf2NtlT6Yv3xos
 mDag==
X-Forwarded-Encrypted: i=1;
 AKwUvBzVn3tuGB1+vi5ca+yimuSSAeZixyG0riBYPspoMdaqfm/K23uTs63dLEN1soZAZa3OIK2AYOE40lEx2qOv@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJX0oVYN4biimrd6y2+mpFvNSL+VaP/qBez2oCEwvEC8olAA6ec
 159/pT0n17FyrMA3nueUlr79DfSAyPtwS7K2OFktCV5UFQmWqwVj7z0DCIUC6F0LlE9/kOcqncg
 v9lEVR2naXqnGlm4OEOyy7Ug/aCcKOAypbjsVZMyrHAJM9JR+n9M/KDfeW6fLStxMQRLx
X-Gm-Gg: AYBFou28+JOsmAoE1OD1FJLlrlijj6vyHO7tXTuXpSjlYJ7eA0xrRxUmgFtxOJ0Hpbd
 t7nW8VHEODCglDG6JOkaUldyEX9sXYAEIXFUxd8QN7WrtoMpl5zElZeARQZRlBIt5UORj9t49SL
 CM5VclL91TOAGKc2qbTuZ/1Qlb2K80WJTYsohAPoY7Mn7yq6BQaGTgTgAaHbDGGhaQM9+nqX/TG
 SCHskPERxP/7L98uSEdoc0OSDgkPPk4zNgTvQHpsq3yNQd5bJEIsQ0PNeJwrmrssC7VUL2DJCxj
 3TNnh6yXyF6TYuB9pZw3ID4N8SXekFK5OJx6QxJQO2k9O331W5THxqPJJP6n/0L/UkKE45YLPTv
 XvLf1h2FIdeuovRhzcpKZsKwe+l2rxbP/DxTvBOI0PaAOYEmNHNlPVzje50tVQ97OXqBB/1UJxq
 U1yIb7sQ9S7TJPdsaL2VBu/cpS7EnR2tj7HaLQgLvGz6zG86OMB8PJ+hnAMjXqYmhZmR0nU24ra
 nccU9eE47D1xtwiiQeXxD7h6xJO1/DJWgbD3RZ2qOUPlQWDo08llTgyPobHjplpsICqe5JdwPcF
 8zNAx5GqvWeQqh3ZT/Gl01ZmjcJIfWbM7/9zGpWmltIrjY9PI5+tsHd7S/DG
X-Received: by 2002:a05:600c:1f86:b0:4a1:c27d:e1a8 with SMTP id
 5b1f17b1804b1-4a1c6672f2emr43094015e9.10.1792130585848; 
 Thu, 15 Oct 2026 23:03:05 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd9b35a6sm116532675e9.6.2026.10.15.23.03.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 23:03:04 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 16 Oct 2026 06:03:04 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I9a3598382ecf928aa81f027b55352175ad93165c
X-Gerrit-Change-Number: 2000
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2000?usp=email>
X-Gerrit-Commit: 50ac5998955c3931a2a241e75a0926bed5e2ebbb
In-Reply-To: <gerrit.1792079013000.I9a3598382ecf928aa81f027b55352175ad93165c@gerrit.openvpn.net>
References: <gerrit.1792079013000.I9a3598382ecf928aa81f027b55352175ad93165c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMDc5MDEzMDAwLkk5YTM1OTgzODJlY2Y5MjhhYTgxZjAyN2I1NTM1MjE3NWFkOTMxNjVjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2d7d40e5d44f6674e5e63588035305d89a77dbc2-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xHb28-00032q-MF
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: repair const
 mismatch in siphash_openssl_available() prototype
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0449502375581994732=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0449502375581994732==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7ZqnKfLh/m0="; charset=UTF-8

--7ZqnKfLh/m0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2000?usp=3Demail )

Change subject: repair const mismatch in si=
phash_openssl_available() prototype
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

repair const mismatch in siphash_openssl_available()=
 prototype

commit 571caa34e2f added the "const" to the function declaratio=
n but
for whatever reason the necessary change in the prototype was lost, s=
o
"make check" failsed to compile the siphash parts of crypto_testdriver=2E=


Fix=2E

Change-Id: I9a3598382ecf928aa81f027b55352175ad93165c
Signed-off-b=
y: Gert Doering <gert@greenie=2Emuc=2Ede>
Acked-by: Arne Schwabe <arne-open=
vpn@rfc2549=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
000
Message-Id: <20261015200214=2E32007-1-gert@greenie=2Emuc=2Ede>
URL: htt=
ps://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39=
907=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M test=
s/unit_tests/openvpn/siphash_openssl=2Eh
1 file changed, 1 insertion(+), 1 =
deletion(-)




diff --git a/tests/unit_tests/openvpn/siphash_openssl=2Eh b=
/tests/unit_tests/openvpn/siphash_openssl=2Eh
index 49c6a9d=2E=2Ea44457e 10=
0644
--- a/tests/unit_tests/openvpn/siphash_openssl=2Eh
+++ b/tests/unit_te=
sts/openvpn/siphash_openssl=2Eh
@@ -60,5 +60,5 @@
  *
  */
 bool
-siphash_o=
penssl_available(void *sip_context);
+siphash_openssl_available(const void =
*sip_context);
 #endif /* ifndef SIPHASH_OPENSSL_H */

-- 
To view, visit h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2000?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: I9a3598382ecf928aa81f027b55352175ad93165c=

Gerrit-Change-Number: 2000
Gerrit-PatchSet: 2
Gerrit-Owner: Gert Doering <=
gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>=


--7ZqnKfLh/m0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2000?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">repair const mismatch in siphash_o=
penssl_available() prototype<br><br>commit 571caa34e2f added the &quot;cons=
t&quot; to the function declaration but<br>for whatever reason the necessar=
y change in the prototype was lost, so<br>&quot;make check&quot; failsed to=
 compile the siphash parts of crypto_testdriver=2E<br><br>Fix=2E<br><br>Cha=
nge-Id: I9a3598382ecf928aa81f027b55352175ad93165c<br>Signed-off-by: Gert Do=
ering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Acked-by: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2000<br>Message-Id: &lt;20261015200214=2E32007-1-gert@greenie=2Emuc=
=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg39907=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@gre=
enie=2Emuc=2Ede&gt;<br>---<br>M tests/unit_tests/openvpn/siphash_openssl=2E=
h<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre>
<pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/tests/unit_tests/openvpn/siphash_openssl=2Eh b/tests/unit_tests/openv=
pn/siphash_openssl=2Eh</span><br><span>index 49c6a9d=2E=2Ea44457e 100644</s=
pan><br><span>--- a/tests/unit_tests/openvpn/siphash_openssl=2Eh</span><br>=
<span>+++ b/tests/unit_tests/openvpn/siphash_openssl=2Eh</span><br><span>@@=
 -60,5 +60,5 @@</span><br><span>  *</span><br><span>  */</span><br><span> b=
ool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-siphash_openssl_av=
ailable(void *sip_context);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+siphash_openssl_available(const void *sip_context);</span><br><span=
> #endif /* ifndef SIPHASH_OPENSSL_H */</span><br></pre><p>To view, visit <=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2000?usp=3Demail">chan=
ge 2000</a>=2E To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E=
</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link =
itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2000?us=
p=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

=
<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I9a3598382ecf928aa81f027b55352175ad93165c </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2000 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Gert Doeri=
ng &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Eso=
urceforge=2Enet&gt; </div>

</body></html>
--7ZqnKfLh/m0=--


--===============0449502375581994732==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0449502375581994732==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0449502375581994732==--

