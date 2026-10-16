Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70536CC6B38
	for <openvpn-devel@archiver.kernel.org>; Fri, 16 Oct 2026 06:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HKBwzt2w2j0+yjhZwu7AT+HySD0Qybt7TuLIxA7dW0I=; b=Sg0LGw8B0IoC9lGPp8qQCdYEDz
	9CzkAyEoS/nHDGNXTVyHac+MgBycWi3ruxgjFI1NwAZl/jI5+egeh4gEMGMRVzQlDn/IOrriRYSNl
	EgiB8tT+S4wPCBA5LB2M6ljNoNCYl76ggyFAAtTK0wbvd2vYsOvgkIX48KgDSHvNCbmA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xHb2B-0005K8-MO;
	Fri, 16 Oct 2026 06:03:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xHb2B-0005K1-0t
 for openvpn-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 06:03:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=IpdBEXbZwT1aYR9zHjb5BByyoH//j7/eWcvj8nYQYv0=; b=PKP2rzfC8vs4L/baXuglOZc9Xj
 GyDFWIsskA8R4XOlgAjnzVUK2srx+EvBXRzYkeIvhHt++9TVbYvfFkdUkiiRu3qZIfPt9fZMHvHw7
 Eg4EoPhulmS0KdMah/jDj9BFnzDwVOkhstQXsOFc6mTPVG4QgMEgvZA49RPXah/mIrlk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=IpdBEXbZwT1aYR9zHjb5BByyoH//j7/eWcvj8nYQYv0=; b=c
 7qk6T8TapXiRVmlzqQbwb0QE12eXAetD39Hwy/IXDETaPGyJngX/9qSJjNKTffQqPxFANeZNWBHyc
 oklSeEtYgl5LsbTxC7VK1GJWhaWeFupXC+DRHxGGp9m7vXmP495JEQezTtkjBsQekZ8DESkrpK3SQ
 jZ6MfHyAmESwH378=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xHb27-00032p-3a for openvpn-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 06:03:12 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-48dfdd0678dso217617f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 15 Oct 2026 23:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792130584; x=1792735384; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=IpdBEXbZwT1aYR9zHjb5BByyoH//j7/eWcvj8nYQYv0=;
 b=S6B5HuuPj40D4CeOJ24RiKJ769tkGb3QZlk6XpC+Pdiru1Z0YntFfc1Us0b2PLDWiK
 Fvh60NNfEyylcS4DcQqzTt7RP8PaE2nzs0ny8Mn4pF9Z/bZfowJz0lbh3qZY8twkPDNZ
 u6X1sNtbAV069erFe8R4iK5CcHppvJvec3/IXANAqEV/RktyOfvS1uf9AmE5MPxRGz9t
 TRndGebj02ZNnlxeqSs4djPlRUyX9ZmMB/Mf3UKa9XDTaYxqUrnwps4sjQ+p8UQK0rOI
 ivrLvwCpS79GTbOvWtx/RVQiAYFIT4jMBvfC+047gReS1LtSNuc9L1tF0HkE85EScM1k
 hNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792130584; x=1792735384;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=IpdBEXbZwT1aYR9zHjb5BByyoH//j7/eWcvj8nYQYv0=;
 b=V4JS8IcfneEDimnuAEDHnrgHPit/bNhRztJmsRBvTcJylplZchHn+n9QPLFPCyNTQc
 J++9K2/4otLQA0JqeI6ZS78jvynrNUnOTkIMnVoBcSoUqe4FeVUyd3bJhxXMoJyI0LwC
 pZdwfllnzpm4xtLgQoDfapfhIDMjePNmn4QiPrsCgmW1UIHcdaVp+cqD3HrcpYkuUPjv
 e/ZTMb4hfOTiRB9zQDBNHMcsme9Vm+4Gb5KCBGmNQr5HLmK3lmVzfiArO9wzAbgZhtsq
 TbBQ36nbWTU8h+Mdzvf9R2Rlc+mn2HzHMOQVtiAK4acC4nBRsrTkvaC7Sk2NX4ySjFqS
 2woA==
X-Gm-Message-State: AFq9FYLDhQBzZ/HA6E725iuo8Bfu6GQmI41KJ7vp/OjixJ+cdlf3tp74
 widKBrtn+ASUkT71mXCikFrxFJCdi3Lo7id5pFdeZFdXa1OPGKq8jPW85XOCMSNFbN0kmNTFCrU
 V4Hipb3xfKbT+jURVT6KGBqILPBdzFnUsy3DF/3uSeBYbnb8K2CbnTI3IvwbyxU3xgajG
X-Gm-Gg: AYBFou0GBSeHk17duy4VE15smDvfgBoWmKj8apVGwnGpDKLlXjdb4CuDVvqI3hhnpq2
 i9wFpsxh8c2VIVB0Bvh/5Ex2tNb/hwfQ8+5fsZQdo/8SuXXyXl83ES6RJTiEIC6JsJzUjKwIR9H
 Ii1d2Xnpy6lnFyNdmvxSxtu5eXhBKDLq7S5o+DvU1cDhWTdLpFu6uUOpCC5s0Yg9YLCWGUSht6j
 pk0Eby10NAucm7ZZFoi4PkfX45d1vhBlkV0F9/I8QPCrBxxJRLmhgomscwbwzFU4APeeneDNukP
 sOj/OwJYc1ZVd44INQPjdhwqmta1d7jhMAeISO8UZQkomYbbZvlfq/FnjHtHkidvwaiu89NM+92
 g2L+D74KOfzwOW6zfG1weZGwfU/0VAG6KtsajAB+zcfLhEMnEZhAH8uRysUjbfPLmVA8ArdyIz4
 Yo437iZNiPZ/5ZQgkeN4Hi52xtUUuDb3oaN6Kjagza1YJhOlIdHJr8i7QIKOGnrqIIok2huVJTD
 2JpZU+FV7D8bZPBhC9uYPHAaGJlM3qHH0vNsrYcjcNBi9UJuiZCIbQ8EJa6ntUZXbd+fOrzbiUz
 7kaf4mqzkzM2L0F/XRKhDNMvRBmR/bvcBo4LNp9akLZ+7IQnDrW3pbKY2Zch
X-Received: by 2002:a05:6000:491b:b0:48b:e50:7152 with SMTP id
 ffacd0b85a97d-48df0134f9dmr11769413f8f.28.1792130584326; 
 Thu, 15 Oct 2026 23:03:04 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4e7889sm2687738f8f.24.2026.10.15.23.03.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 23:03:02 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 16 Oct 2026 06:03:01 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I9a3598382ecf928aa81f027b55352175ad93165c
X-Gerrit-Change-Number: 2000
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2000?usp=email>
X-Gerrit-Commit: 50ac5998955c3931a2a241e75a0926bed5e2ebbb
In-Reply-To: <gerrit.1792079013000.I9a3598382ecf928aa81f027b55352175ad93165c@gerrit.openvpn.net>
References: <gerrit.1792079013000.I9a3598382ecf928aa81f027b55352175ad93165c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMDc5MDEzMDAwLkk5YTM1OTgzODJlY2Y5MjhhYTgxZjAyN2I1NTM1MjE3NWFkOTMxNjVjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2d7d40e5d44f6674e5e63588035305d89a77dbc2-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xHb27-00032p-3a
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3669577951338843600=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3669577951338843600==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+/g8h6ZnDN0="; charset=UTF-8

--+/g8h6ZnDN0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello Arne Schwabe, 

I'd like you to reexamine a change=2E Please visit

 =
   https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2000?usp=3Demail

to look at =
the new patch set (#2)=2E

The following approvals got outdated and were re=
moved:
Code-Review+2 by Arne Schwabe


Change subject: repair const mismatc=
h in siphash_openssl_available() prototype
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

repair const mismatch in siphash_openssl_av=
ailable() prototype

commit 571caa34e2f added the "const" to the function d=
eclaration but
for whatever reason the necessary change in the prototype wa=
s lost, so
"make check" failsed to compile the siphash parts of crypto_test=
driver=2E

Fix=2E

Change-Id: I9a3598382ecf928aa81f027b55352175ad93165c
Sig=
ned-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
Acked-by: Arne Schwabe <=
arne-openvpn@rfc2549=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2000
Message-Id: <20261015200214=2E32007-1-gert@greenie=2Emuc=2Ede>=

URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2E=
net/msg39907=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
-=
--
M tests/unit_tests/openvpn/siphash_openssl=2Eh
1 file changed, 1 inserti=
on(+), 1 deletion(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/00/2000/2

diff --git a/tests/unit_tests/openvpn/siphash_ope=
nssl=2Eh b/tests/unit_tests/openvpn/siphash_openssl=2Eh
index 49c6a9d=2E=2E=
a44457e 100644
--- a/tests/unit_tests/openvpn/siphash_openssl=2Eh
+++ b/tes=
ts/unit_tests/openvpn/siphash_openssl=2Eh
@@ -60,5 +60,5 @@
  *
  */
 bool
=
-siphash_openssl_available(void *sip_context);
+siphash_openssl_available(c=
onst void *sip_context);
 #endif /* ifndef SIPHASH_OPENSSL_H */

-- 
To vie=
w, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2000?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9a3598382ecf928aa81f027b=
55352175ad93165c
Gerrit-Change-Number: 2000
Gerrit-PatchSet: 2
Gerrit-Owner=
: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: Arne Schwabe <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Eso=
urceforge=2Enet>

--+/g8h6ZnDN0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2000?usp=3Demail">View Change</a></p>=
<p>The following approvals got outdated and were removed:
Code-Review+2 by =
Arne Schwabe</p><pre class=3D"blocks" style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">repair const mismatch in siphash_openssl_avai=
lable() prototype<br><br>commit 571caa34e2f added the &quot;const&quot; to =
the function declaration but<br>for whatever reason the necessary change in=
 the prototype was lost, so<br>&quot;make check&quot; failsed to compile th=
e siphash parts of crypto_testdriver=2E<br><br>Fix=2E<br><br>Change-Id: I9a=
3598382ecf928aa81f027b55352175ad93165c<br>Signed-off-by: Gert Doering &lt;g=
ert@greenie=2Emuc=2Ede&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@rfc25=
49=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2000=
<br>Message-Id: &lt;20261015200214=2E32007-1-gert@greenie=2Emuc=2Ede&gt;<br=
>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2E=
net/msg39907=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=
=2Ede&gt;<br>---<br>M tests/unit_tests/openvpn/siphash_openssl=2Eh<br>1 fil=
e changed, 1 insertion(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks"=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pul=
l ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/00/2000/2</pre><p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span=
>diff --git a/tests/unit_tests/openvpn/siphash_openssl=2Eh b/tests/unit_tes=
ts/openvpn/siphash_openssl=2Eh</span><br><span>index 49c6a9d=2E=2Ea44457e 1=
00644</span><br><span>--- a/tests/unit_tests/openvpn/siphash_openssl=2Eh</s=
pan><br><span>+++ b/tests/unit_tests/openvpn/siphash_openssl=2Eh</span><br>=
<span>@@ -60,5 +60,5 @@</span><br><span>  *</span><br><span>  */</span><br>=
<span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-siphash_op=
enssl_available(void *sip_context);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+siphash_openssl_available(const void *sip_context);</span><=
br><span> #endif /* ifndef SIPHASH_OPENSSL_H */</span><br></pre><p>To view,=
 visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2000?usp=3Dema=
il">change 2000</a>=2E To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setting=
s</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction=
"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2000?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>=

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"=
display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ge=
rrit-Change-Id: I9a3598382ecf928aa81f027b55352175ad93165c </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 2000 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel=
@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--+/g8h6ZnDN0=--


--===============3669577951338843600==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3669577951338843600==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3669577951338843600==--

