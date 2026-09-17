Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A61A6C982D2
	for <openvpn-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gqvmXCH/xIKV+/hAzgQrYenVkHluWHE7t03WiaC1JnY=; b=c8hVwY6eucYppcI8FX4VUQ9dsy
	QkOA/gpJZ+CLcgWaetEyz5cRZTT1yxacSDb+uqM9ws0Rz/buzC3QyFc4Xgf3kTZbJux4GnaPSHSZk
	6Te0x+C8y1sZTdlWwdujth/DesR6V7xT9EsyHDvmzs6KeE6dlTDjmlQS4ujv642Yld/w=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x767w-00062q-JF;
	Thu, 17 Sep 2026 07:01:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x767t-00062Z-Jn
 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 07:01:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=i2nAUMTA+yIjd7rLw9cCafuU4GY6mU9SivXgB0oNIUQ=; b=aEb4SOs8JN7k6WTRpIcraRQ9LF
 Bh7STOpyyDB1F2VwyoLTyigMWd8MS+Pto2zuI5Janl2L9eqNmSAnPcyuqUJhkhaCJWESrh1AVaITx
 UhAP53udm4zXlmAlMa6461X/pC5KHH4/qMUTbn7okZfK8sZrV/k6Y0ie4W2q825AUmW4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=i2nAUMTA+yIjd7rLw9cCafuU4GY6mU9SivXgB0oNIUQ=; b=k
 PliOIIT5Z0VY3mK/eFF/R/81p5Ow5Ab/zHfxSpLo0ZwuYPCPd56z671Dgf4t+VkYmbHsLQKF4Nb9n
 OzcLnMxcvze0yLDYEAgnWQWGvj4dG1YUkr7qrHCYCFxKxS0zLCn1iKNFPk1JBsqSt7gNTfvorEbXd
 M3AZQD5JWduMTFAs=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x767s-0006nt-8w for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 07:01:45 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843cedd129so306642f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 17 Sep 2026 00:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789628498; x=1790233298; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=i2nAUMTA+yIjd7rLw9cCafuU4GY6mU9SivXgB0oNIUQ=;
 b=F2AqNt08ypL01pKcIvvBu6k7MQ3RJNbPP2eRnbbQG3A8Baix3FtLsvTfSFoxo7cQe0
 wS09m3hUmbTHL7yuYgA1lOOd7IQ7HZNtidua1LvPujBCLkxBZtktfKkPWeNu/soBM8Gv
 fXwTOCbT4+VCQEwBqwoS6DlWOi9VsZKiAnGpXJSbKdPs9BedOs82NuiCLc4fwgs1C452
 zaRUWz3QP2/NukPh7vZUkgofsi270N7L/i1w/PpV1cIENnmCEE4mFhb7jMuneGPftLJt
 82YxXOBpKjvF0PfmxBqNoa/tfojYF5L76dfVkOuHX73UEsbEJi9tvoEt5ELr1cJiYxKh
 Tbxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789628498; x=1790233298;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=i2nAUMTA+yIjd7rLw9cCafuU4GY6mU9SivXgB0oNIUQ=;
 b=IfBAdX+b2HduMtKomTo3WfxBhGnGh2KHNHfmGJI8y20gwnlQCzcQA3peibhVOzt440
 G0lqI/+3yGh4fV/tbsDPmfuGtg+bSRsslg2TwrwVRQo9piidomgF8n37GF/1g4q6bmdY
 tP9oJ+VYGRfhCgacNMsDGezNliRxkDwa/GMJv0R5NMOPJEDErGi7zJ2xeuulrS5tk5aU
 mSQqrKEhb714XaLLXEgAAhL7eg6ztGagpUy9ZBjRduCHQJjFvbHtBLhqnkCqgTzFQe8h
 wS6i4uCriCrtwxq7gqD7YfcEe5KNX9quVEkiWRZki1GWoLbwaiMzRr1llfCBAlRshR+s
 cY3g==
X-Forwarded-Encrypted: i=1;
 AKwUvBx5eDdfLvFM/swUzGN/gsJNmIaTYP8MrJkuqCXpjXjh2tdDqveB9GZ2sKN8ydQ2AIBaOIoOxEEl8g788MtI@lists.sourceforge.net
X-Gm-Message-State: AFuF++moRFCtRP0EBOqmBtlWj4QEPcZf1LIMOXmXuC5htR5AzU0Zf7+g
 Cfr4ZXLNZR5YqFSl2DNy9RwEF1ExL7G2cUUFuX9s4DoiDROCcBC0+xZgXI64z7VEhbXapfWfoPo
 gyvEgNVdjBswMEsc2S4Z7CX3iPgggnY3H2NXg+gOBqPqek4nV9sGedYdU28AgWv8UVwGi
X-Gm-Gg: AYBFou1lQvjjInKZbcffDWu4GqOiUQ9L/CjMkrLlJ1bgYdmuHT3fRAMJDaLO88wG2Dn
 UoVnd8kLLwB0SjMxpPyYvirCKcDhLT0o9Y9KnRIQiuT8u+Y+dulD2pgXbYApZDwf8D/H4Ng18yY
 ErETm60iTHECcOlWrxqYnhRnObD14yWVN1IUmin73mdV6YvjjRu9mJZDlZ/Mi+Goyn5KjG+F3fH
 g3w1r2G73W5MTu7Kj7QGeELHZbxZIj8V6ohT1mPkNTEFn5d6P/OVOZgIOrT21fqfT3Lyb5qqOYY
 PZase4byraq39xRFZciaIUXSZmE1iICZgWJDtHtkkzXWpBmczJUbZ+XaWpbo6Q4R6xVYUVLaXeL
 2uYs/Kf4d7D3jFoceeMEe99UhVIO3G79GZ+i7ay6xJk7o6bF7lxP57F1h8cPbLRnVMes7i9cyys
 DI2Dng2ShlCMuBLd5G3CRUPai07vsUEDQniLtLbc5WSmWOi3KzHHWRqgUrjmHFdnYZluIn8D/27
 WGEiAcjA3goZgxsghInRg80eR3SS+y/bb1UslFc57xZEauVMKRdj450jmCJR673DUtFZj48jbel
 OEf+UBwndLu0MiU6GUSFGugG+X3jBh9T2gxIYQbD6hLQ7VKMsANC48ANQGDKcA==
X-Received: by 2002:a05:6000:2408:b0:486:f301:11df with SMTP id
 ffacd0b85a97d-4870cee0b72mr14690721f8f.6.1789628497499; 
 Thu, 17 Sep 2026 00:01:37 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf1f98csm12331371f8f.11.2026.09.17.00.01.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 00:01:36 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 17 Sep 2026 07:01:30 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 15
X-Gerrit-Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30
X-Gerrit-Change-Number: 1742
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1742?usp=email>
X-Gerrit-Commit: 59a6b578f3df7a070b2b213db4f5a1e75a4dc416
X-Gerrit-Comment-Date: Thu, 17 Sep 2026 07:01:30 +0000
In-Reply-To: <gerrit.1782719911000.Iafa9efc1c156974ad9f5752e9de810a8c2f68c30@gerrit.openvpn.net>
References: <gerrit.1782719911000.Iafa9efc1c156974ad9f5752e9de810a8c2f68c30@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklhZmE5ZWZjMWMxNTY5NzRhZDlmNTc1MmU5ZGU4MTBhOGMyZjY4YzMwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c217b9f841f21f861503f9211eb187c745a3821d-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x767s-0006nt-8w
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Add
 SERVER_PROBE parsing and the probe-reply decision
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, frank@lichtenheld.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5284905318650304152=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5284905318650304152==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CpRxg83M+6E="; charset=UTF-8

--CpRxg83M+6E=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, ralf_lici=2E=


stipa has posted comments on this change by stipa=2E ( http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1742?usp=3Demail )

Change subject: oob: Add SERVER=
_PROBE parsing and the probe-reply decision
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 15:

(1 comment)

File src/openv=
pn/oob=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742/comment/ac62c5a=
2_e2a74462?usp=3Demail :
PS8, Line 226:     }
> The spec got changed/revise=
d after the first draft and now explicitly states that the server should  [=
=E2=80=A6]
Done=2E The server now classifies a probe as invalid, stale or o=
k; a stale one (timestamp more than --hand-window off) is still answered wi=
thin a small server-wide budget, 1/20 of --connect-freq-initial per period,=
 i=2Ee=2E 5 per 10 s by default, the spec's own example=2E It reuses the in=
itial-packet rate limiter with a new quiet flag, since a replayed probe hit=
ting the limit is not worth the --connect-freq-initial warning=2E Implement=
ed in 1743, man pages updated in 1747 and 1752=2E



-- 
To view, visit htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30
Ge=
rrit-Change-Number: 1742
Gerrit-PatchSet: 15
Gerrit-Owner: stipa <lstipakov=
@gmail=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerri=
t-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_li=
ci <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Es=
ourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Attention: =
ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Comment-Date: Thu, 17 Sep 2026 07:0=
1:30 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-T=
o: plaisthos <arne-openvpn@rfc2549=2Eorg>
Comment-In-Reply-To: stipa <lstip=
akov@gmail=2Ecom>

--CpRxg83M+6E=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, ralf_lici=2E </p>
<p><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail">View Change=
</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li st=
yle=3D"margin: 0; padding: 0;"><p>File src/openvpn/oob=2Ec:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1742/comment/ac62c5a2_e2a74462?usp=3Demail">Patch Set #8, Lin=
e 226:</a> <code style=3D"font-family:monospace,monospace">    }</code></p>=
<p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddin=
g: 0 10px;">The spec got changed/revised after the first draft and now expl=
icitly states that the server should  [=E2=80=A6]</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done=2E=
 The server now classifies a probe as invalid, stale or ok; a stale one (ti=
mestamp more than --hand-window off) is still answered within a small serve=
r-wide budget, 1/20 of --connect-freq-initial per period, i=2Ee=2E 5 per 10=
 s by default, the spec&#39;s own example=2E It reuses the initial-packet r=
ate limiter with a new quiet flag, since a replayed probe hitting the limit=
 is not worth the --connect-freq-initial warning=2E Implemented in 1743, ma=
n pages updated in 1747 and 1752=2E</p></li></ul></li></ul><p>To view, visi=
t <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail">ch=
ange 1742</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div styl=
e=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:no=
ne"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30 </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Number: 1742 </div>
<div style=3D"display:none"> Ger=
rit-PatchSet: 15 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &l=
t;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mand=
elbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-deve=
l &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank=
@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention=
: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Comment-Date: Thu, 17 Sep 2026 07:01:30 +0000 </div>
<div style=3D=
"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none">=
 Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply=
-To: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Comment-In-Reply-To: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
=

</body></html>
--CpRxg83M+6E=--


--===============5284905318650304152==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5284905318650304152==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5284905318650304152==--

