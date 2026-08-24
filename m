Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D085EC61DB6
	for <openvpn-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=NHKQqLnXVhFFIty9WBgB0mGoCiwtmtvIMAJAZXsKpNE=; b=MAGeduNXI/cdWc
	EtzMxTbWPO28z/XCJg7cfs4P+YX9e4iSGSujXC+Ue3tK84qq14M5IE7wTb5H8r1bg9G7yA+zW8kbb
	pAwv2ZyFEoZv7LMf09Tfqpi0jNhVoyQdC6ZhIYhqEsFtHzmI3p2FpMLuz1tNI2hSmm4CbukEM0Cdd
	Ubk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wySm4-0001op-PK;
	Mon, 24 Aug 2026 11:23:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wySm3-0001of-Tg
 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 11:23:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=c1lpmPWlB5Ronnmb0VRujM6c3WlyQcnnuIWAZGyREuY=; b=hHas1oj3fhMtnAhEtp8hdtubfl
 fOmxbiRgsKDaUQzUYnnkd922fPq/tV3mZA/8uTAUXtzmuT8E67qVE0ijdO8bWdn2edKWlARs3uT3K
 jCRcNIY8LsOP8Jc4v+5W47LG+X5kbe3juHmLtXSiQbcf0NFC3zO6KcrBiYET+DMXkqn8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=c1lpmPWlB5Ronnmb0VRujM6c3WlyQcnnuIWAZGyREuY=; b=P
 Nuh0jzs2bUrBOx/CT9N5060m52ETgltsnfLWAkSCSWFiEDwI9UXAnw8yOE0HLV8ZZo3OlWaJFvbK+
 kR1LONRAjNw/ENWYWfs8yfJrkPcJk55fP1a7zPHQ1JDCeGpZOnFd3U0qYe7hvE2Izobga5tC1WxVC
 WdV+QtO8Pur5PZT8=;
Received: from mail-ej1-f51.google.com ([209.85.218.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wySm0-0003vu-0p for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 11:23:29 +0000
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-c15f020a223so486666666b.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 04:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787570601; x=1788175401; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=c1lpmPWlB5Ronnmb0VRujM6c3WlyQcnnuIWAZGyREuY=;
 b=GTut3H1gp0IZK6x4PNoce64t88re4ScWAcZWAZqasSyzEOCqCoWzzHXjI1QGC8xnYo
 A1afS6DPJgc3NTO7dDQjzniwDIveil7xKk8fdyPr6JxNxxyEMf37+N6/YvdHk8S9vVN5
 AtBQxRllHh1HbOj9LlYc9+esR34ouCDV2XIZdf9JmLKbDVmPh6FuswoOrGEdPOuRdbwC
 eBOXU7nS7AdEb78GiFiPsn2V47VL0MN/KTf0toRSkk1zyqhBQBa54v7/MRHTRsGCo+8O
 iuAf8wbVU/Mbe+5atyv0UZIM+VRLcQYRCucl1+U5ZmczaizapmyyHsaMMv2sMu7i6gWw
 461Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787570601; x=1788175401;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c1lpmPWlB5Ronnmb0VRujM6c3WlyQcnnuIWAZGyREuY=;
 b=iLW2yv5hFlL/vzT5vX0sIP90Geo/zp9RQD1Qg+pyEpfqqg0lw+bqrQZFJ/I7/Qsrza
 pBGYGzih1hzkrLaDl/objf3bNwYi8ypjP3TGjHpJI8UuQTORRY0W2jAsHJn/kZa/XsBF
 11Dy2rgVzkVI19ItxVqLJ8xgZSqFGB+KS6mpooKMXcNZAgB5MAJ1ryClP1tcHSQnO7es
 GmSDzYu7mph5gyIwiuDVv+8NWX0a+7LWUxN3pPpB/OHNJlXcGFex6IDgu20cZNjbPyBO
 UVtMWLAzXT49RqQmyfaR/pxon/TTr0WO3fbhBtOnbZ2liLMYOS+B63mJgbUKq0jLo6d9
 X6Lw==
X-Gm-Message-State: AFuF++kCPvTo4vMvojNNIvZBuCpkDOvH+5L0JaKFlu4RXad3h0Thmsr6
 oiotsJaS2NFnURo3DiKu5FBN2hJVjSPB20BdltVs1ncu7mSkiZn+A0qlGtKm+H94SdjDVx1kVFI
 fIqOfx/Au8CD1JLocZ7ifmrguhAHWqIdYgSdXaye1MT2fi8zKEb/ZQgMrYgmOUD0e2wua3YJIRI
 MMHeEOmA==
X-Gm-Gg: AR+sD12tseWs8FSNuyEScrxOJQR/9FEJpyYJ0i5c0xfyoaupZYYneyfArWUGKwt01JI
 1Pr5S8ZGR65PS3VDQI5bv/erwYqLEjWV0iVPg/l1CAHALXH8tN+ZtEy41RtZhKiXIaDAqXqLvit
 NxVZ91SqalLaEW/jce6afiWILRSbzdLFPvSz5qGNPIJot7KYmSoOfZIHDeaml7/4oJST89DYU2e
 BcTBKQLUt6CP75jjJxiymNA3OOwRR6CnUDiVPQj2kiixbuyI4TyKI+BxhueHKJvTPgGTygaVIOp
 UIDtbBHXHv69vlJNwEbjU7MWanJQ5/lGmdV+yXaiOgyMC8WEt7Gy/m++2d2lWEMd8wJ62nyjMBq
 ICPOMtySKA9FPTPAWvnA7Y52zv2NhhMjs9GAOJKdWGI6PMbgYA7x5MlLBe2Yp+ZvT4KuFMUcR6W
 tVVougMjPGMwPmfDI8ysA5ZZtKETpB58wC36a+NjDOvvMWzJA2uqmYSWbb0Lg2NWfe/4NESSqa1
 G7XernPzxVjAeWdMFftWYRfa9eFeS6SKtMusp5oTFROhbXMvxpbFitvj0KLXxCmMw8TAkMEGZAp
 q7H+TP/6LZf2VpoufzPInMy1CAKDGqmnHVahqf+GuKfMQIFmM2WisbTM+eIg1w==
X-Received: by 2002:a17:907:1c1f:b0:c20:31d1:a899 with SMTP id
 a640c23a62f3a-c246a4ad97emr2967150566b.4.1787570601354; 
 Mon, 24 Aug 2026 04:23:21 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249606a8fasm1350893766b.8.2026.08.24.04.23.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 04:23:20 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 24 Aug 2026 11:23:20 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iad13c3bf73dbe073e52ede504ced7fb2f6a9b71d
X-Gerrit-Change-Number: 1866
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1866?usp=email>
X-Gerrit-Commit: f849b0a40256ce97961b9da5ff2ca96626e37a3e
References: <gerrit.1787570563000.Iad13c3bf73dbe073e52ede504ced7fb2f6a9b71d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3NTcwNTYzMDAwLklhZDEzYzNiZjczZGJlMDczZTUyZWRlNTA0Y2VkN2ZiMmY2YTliNzFkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <615c22bba7ccf0b16d49284915c458a812f7fe92-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wySm0-0003vu-0p
Subject: [Openvpn-devel] [S] Change in openvpn[master]: mroute: Remove
 unused functions
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
Content-Type: multipart/mixed; boundary="===============3005547051101004821=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3005547051101004821==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8mg+8NC9wRs="; charset=UTF-8

--8mg+8NC9wRs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1866?usp=3Demail

to review the following change=2E


Chang=
e subject: mroute: Remove unused functions
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

mroute: Remove unused functions

Both of th=
ese have been unused since commit
1308ccec9f85418b088723bb870855c0a933311b
=
("Remove support for PF")=2E
The first is ipv4 specific and very limited in=
 scope=2E
The second is equivalent to just using CLEAR (at least
in actual =
usage)=2E
So I think both can safely be removed=2E

Identified by cppcheck=
=2E

Change-Id: Iad13c3bf73dbe073e52ede504ced7fb2f6a9b71d
Signed-off-by: Fr=
ank Lichtenheld <frank@lichtenheld=2Ecom>
---
M src/openvpn/mroute=2Eh
1 fi=
le changed, 0 insertions(+), 20 deletions(-)



  git pull ssh://gerrit=2Eo=
penvpn=2Enet:29418/openvpn refs/changes/66/1866/1

diff --git a/src/openvpn=
/mroute=2Eh b/src/openvpn/mroute=2Eh
index 639281b=2E=2E9d61b22 100644
--- =
a/src/openvpn/mroute=2Eh
+++ b/src/openvpn/mroute=2Eh
@@ -249,24 +249,4 @@
=
     dest->v4=2Eaddr =3D htonl(src);
 }
 
-static inline in_addr_t
-in_addr=
_t_from_mroute_addr(const struct mroute_addr *addr)
-{
-    if ((addr->type=
 & MR_ADDR_MASK) =3D=3D MR_ADDR_IPV4 && addr->netbits =3D=3D 0 && addr->len=
 =3D=3D 4)
-    {
-        return ntohl(addr->v4=2Eaddr);
-    }
-    else
=
-    {
-        return 0;
-    }
-}
-
-static inline void
-mroute_addr_rese=
t(struct mroute_addr *ma)
-{
-    ma->len =3D 0;
-    ma->type =3D MR_ADDR_=
NONE;
-}
-
 #endif /* MROUTE_H */

-- 
To view, visit http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1866?usp=3Demail
To unsubscribe, or for help writing m=
ail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerr=
it-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: Iad13c3bf73dbe073e52ede504ced7fb2f6a9b71d
Gerrit-Change-Numb=
er: 1866
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: p=
laisthos <arne-openvpn@rfc2549=2Eorg>

--8mg+8NC9wRs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1866?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">mroute: Remove unused functions<br><br>Both of these have been unused =
since commit<br>1308ccec9f85418b088723bb870855c0a933311b<br>(&quot;Remove s=
upport for PF&quot;)=2E<br>The first is ipv4 specific and very limited in s=
cope=2E<br>The second is equivalent to just using CLEAR (at least<br>in act=
ual usage)=2E<br>So I think both can safely be removed=2E<br><br>Identified=
 by cppcheck=2E<br><br>Change-Id: Iad13c3bf73dbe073e52ede504ced7fb2f6a9b71d=
<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---=
<br>M src/openvpn/mroute=2Eh<br>1 file changed, 0 insertions(+), 20 deletio=
ns(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:2941=
8/openvpn refs/changes/66/1866/1</pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/mroute=2E=
h b/src/openvpn/mroute=2Eh</span><br><span>index 639281b=2E=2E9d61b22 10064=
4</span><br><span>--- a/src/openvpn/mroute=2Eh</span><br><span>+++ b/src/op=
envpn/mroute=2Eh</span><br><span>@@ -249,24 +249,4 @@</span><br><span>     =
dest-&gt;v4=2Eaddr =3D htonl(src);</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline in_addr_t</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-in_addr_t_from_mroute_a=
ddr(const struct mroute_addr *addr)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if=
 ((addr-&gt;type &amp; MR_ADDR_MASK) =3D=3D MR_ADDR_IPV4 &amp;&amp; addr-&g=
t;netbits =3D=3D 0 &amp;&amp; addr-&gt;len =3D=3D 4)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        return ntohl(addr-&gt;v4=2Eaddr);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        r=
eturn 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-static inline void</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-mroute_addr_reset(struct mroute_addr *ma)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    ma-&gt;len =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    ma-&gt;type =3D MR_ADDR_NONE;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span> #endif /* MROUTE_H */</span><br><span></span><br></pre><p>To vi=
ew, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1866?usp=3De=
mail">change 1866</a>=2E To unsubscribe, or for help writing mail filters, =
visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settin=
gs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1866?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<=
div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"di=
splay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerr=
it-Change-Id: Iad13c3bf73dbe073e52ede504ced7fb2f6a9b71d </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1866 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--8mg+8NC9wRs=--


--===============3005547051101004821==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3005547051101004821==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3005547051101004821==--

