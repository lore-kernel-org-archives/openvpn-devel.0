Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7EC4C88E75
	for <openvpn-devel@archiver.kernel.org>; Tue, 15 Sep 2026 06:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KHHyfx/fOKVnyaarOGjwDFXhS4HpcYMIZJ0tEOiAOg8=; b=kHFz4jwQ71oIV37kBHCi1oo9EM
	dH0VfaRuBMkCcxdQ1kY7mCCWHN1ZTi0237xtdKiHwW06/MXfOdVZvTCn8ChMNa7JMzyweDvltOgfP
	911JC539hIPhiM2Jigo002GBZTWViLjFnbkUP4NBtM/pesnF5Hxt8sj4R9NLy7fbzN2U=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6Mab-0003Rf-8Q;
	Tue, 15 Sep 2026 06:24:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x6Maa-0003RZ-Be
 for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 06:24:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=OHjhoXn87RPzCh2TpeBSzxFdadK9dPHyIYfQSHxEEy4=; b=It3aFa/o8XqLehwcXf6CFGJ+uU
 yaROIbB4a4qt3OXl2rgdGB5iisIfPiKLoqEs0VJ4wtmA2sgKKzkEkMdKf8kcgbPuF1lfMbpcPE/hc
 YFNKM21myT/mC3L58mktiHYK0wAwjuXRGokRfOqpjBixs0IXwpUzcWWMaVyutvtZPqLI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=OHjhoXn87RPzCh2TpeBSzxFdadK9dPHyIYfQSHxEEy4=; b=O
 5RxNLq+HUYFEfKY0BcYVHgVE3eNMhlELUppt7gkaMtKKhv3PjOr+5gZ98GRlEIcIkK6/1eavAEjU5
 bwkqsVHqOsCj1CQyQOxWwCvfiwhSRj/AjZGC3hpMpdRQ53QUIjP1oLWGVZ0ECp8SkSFzzhoTuFPoz
 WKR8Iw0nrkTYjWRA=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6Maa-0007Mc-Da for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 06:24:21 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-482ea739de2so2793874f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 14 Sep 2026 23:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789453454; x=1790058254; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OHjhoXn87RPzCh2TpeBSzxFdadK9dPHyIYfQSHxEEy4=;
 b=ICri+KJfuz4umizZhFgT9YrLs9UJ4pOgs7h/6hxjvSiPSZK/XYFgwRpuKl1N8SNl8/
 Scdvc5aTbtM1juJsj73fntCLpUz0EuVSRYrZPD+WqsBstj0/ICKypz7AaIVmxIAlXBFB
 cVQGF925zRTwdUcvPfD7YyMoiiA0dh53V60eguLcDABNyWwvXVpP5Rp00sqe/a/k+yxh
 ePGlc9DuVSShweF/WK62BH3FE3tUD4fQPJ4HPzId/WlQ008ocyb47tGGI+s/jFKxbyut
 F6K/pmucSwNo4Id/yCc6e+OwHDJcfv1V5+4tHweIF6zJVf+r9Kv2817tb4JYLzzN+D3l
 nqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789453454; x=1790058254;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=OHjhoXn87RPzCh2TpeBSzxFdadK9dPHyIYfQSHxEEy4=;
 b=c2FExQkYBPwgqxeglDTdkSr7vL8dK29uKFSiwuAhUNWSehaTkAgqE0o3kY9SmAxbbw
 4Zpg0gM+Omr0N0bzQ0AdS3YbUABKnNLrqoRrp7UG/58Zq/2HXFeOsWzyl5nKtESLbvn7
 HBXoPmuwPMPd68LPX5vPm3J7qxi5xOe/L2gB77Grl514TPgJA3u2NgYCh2sZuBoJpo5V
 cX6TQQW6fQ1f1+ACfjxUK+0fjRenUSR7CG3DUql+kvS1xw+9fIASRC5RmAM4nDyhnb9t
 0yWUnro32bVgWBCUEh9Vb6lG5S/N91+HJNeQnDSvAaobe6/Hg2HQJdsmz38KHbQ+pKmE
 eaFQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzAmBYaamQ4pzscQVTLiTWuQp2Ca2mK7C0oKm1z34Vd7IcSOr7YmN5wSDo3+LioqQDmU9hN0LMdZvzS2/oV@lists.sourceforge.net
X-Gm-Message-State: AFuF++ncbzZDWosdDPhcZEjaqphXiMZVuLK83JfFjT6DA4cCCGsWoiTd
 RuncAw02R40KCpF7B0BnxpW3j3ktowvDX2balb6CVG1WYDnlZo6chA8ysQ5HyDGbE4TP24kEIrJ
 yhGAjXTXSg++Sv7GXRP2pd5/papwpX2uNieqp1DBgSfGltTtNxbGrljGEseMKJMUCb7wX
X-Gm-Gg: AYBFou2WzoNYfSGF1saTZs6Mbnz4HkJ3TtpRgHkjhsNE/NTv03+QUQMz4BAq67bXfpJ
 D7/FIEbR2Irak9j3TlfT3hIAoUwiIUZ+8DSSMhrkt2vurm8Oujqq24cgnYAyX/4Emx0IKXaxPIX
 38F5F06GZVBn7cVA6GIICxN8E+fH0qxPAYU8xou4dFRRH3Ndn70gwCGSp31Fd3jOYzPN8vYoQ29
 4C4dT7nzFOImZh4wjJKR7MI8SQZUn7EGvVY3Yvz5MyoKUzGWkTPgdP6z8q2bi4ZElrE9Zf5Bfai
 iG/BUOqjGMRFpJB+GZW2rt8ZVb7q+xWetNHiNLbepa7CfI1sez5P2158wuqBCVezGrM88monYzd
 oP0N/IAgqnMM5x1ZCHOqfmdgTXuMLoRdo37QFczIMvmSio2Ce60oFTFoUxGj07mPLXHhER1G79Z
 cR5mpf3Q2XsGjjWduc+dgdRsl5ZlDgG9LFH1+utdO53GbEdaYqa0mc6Wgl2Cf2K4+C2KmyiYNcK
 WFIbFAI5bOoOWfkcbmZffK3JHQg5JcsV8wC9mESIOydJ2UrGwAc2q1ptnQ/gilGmdeUuvs6AnZX
 xKZSdHBCYL/ylWOSpyVwzPogG54LYDP/yGBG/Ei9rhudEvnj7o+O2hUmRy6/LQ==
X-Received: by 2002:a05:6000:240c:b0:486:f907:ebec with SMTP id
 ffacd0b85a97d-48702b16cfamr7676821f8f.31.1789453453774; 
 Mon, 14 Sep 2026 23:24:13 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb2ed0fbsm32616561f8f.3.2026.09.14.23.24.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 23:24:13 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 15 Sep 2026 06:24:11 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 21
X-Gerrit-Change-Id: I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac
X-Gerrit-Change-Number: 1750
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1750?usp=email>
X-Gerrit-Commit: d0fffc509e1a69b7d24ec755451a4d8a8acb23e2
X-Gerrit-Comment-Date: Tue, 15 Sep 2026 06:24:11 +0000
In-Reply-To: <gerrit.1782719911000.I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxZjlkN2I1YTVlYzE5YmY3N2MwYzIxMjc5NWY1ODNjNWJhNGMwM2FjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <46137913ccba04f834f6270fd057a0941381858a-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x6Maa-0007Mc-Da
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Wrap the client
 SERVER_PROBE with tls-auth/tls-crypt
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
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3003669713935581231=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3003669713935581231==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eLIIYR27MJ4="; charset=UTF-8

--eLIIYR27MJ4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici=2E

stipa has po=
sted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1750?usp=3Demail )

Change subject: oob: Wrap the client SERVER_P=
ROBE with tls-auth/tls-crypt
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 21:

(1 comment)

File src/openvpn/oob_client=
=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1750/comment/933edddb_0598=
7e73?usp=3Demail :
PS20, Line 220: entry 0
> nit: probably a leftover from =
the previous implementation
Fixed!



-- 
To view, visit http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1750?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac
Gerrit-Change-Num=
ber: 1750
Gerrit-PatchSet: 21
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
G=
errit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ral=
f_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Attention: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Comment-Date:=
 Tue, 15 Sep 2026 06:24:11 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels:=
 No
Comment-In-Reply-To: ralf_lici <ralf@mandelbit=2Ecom>

--eLIIYR27MJ4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici=2E </p>
<p><a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1750?usp=3Demail">View Change</a></p><p>1 c=
omment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0;"><p>File src/openvpn/oob_client=2Ec:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1750/comment/933edddb_05987e73?usp=3Demail">Patch Set #20, Line 220:=
</a> <code style=3D"font-family:monospace,monospace">entry 0</code></p><p><=
blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0=
 10px;">nit: probably a leftover from the previous implementation</blockquo=
te></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">Fixed!</p></li></ul></li></ul><p>To view, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1750?usp=3Demail">change 1750</a>=2E To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope i=
temtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1750?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1f9d7b5a5ec19bf7=
7c0c212795f583c5ba4c03ac </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 1750 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 21 </div>=

<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Comment-Date: Tue, 15 Sep 2026 06:24:11 +0000 </div>
<div sty=
le=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:n=
one"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-=
Reply-To: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>

</body></html>
--eLIIYR27MJ4=--


--===============3003669713935581231==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3003669713935581231==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3003669713935581231==--

