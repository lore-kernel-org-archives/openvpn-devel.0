Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A8BC982DE
	for <openvpn-devel@archiver.kernel.org>; Mon, 21 Sep 2026 10:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h3owXRyaebDqHsP1K5n3VWsEkmQcHXZohwqtsU7gMBE=; b=g0tUmnLEsbzRkYs1WTOFQZTqEg
	djOM1hjWfvJ0A6/j/M1nCRIOW7nRcolS+mE69aPhiaWAstI/qi4COblMFEJvqHUy2mfbZFpc3hGbC
	f6UveH4SX71qGs3k3GbVv8eO++afhYzqGdSIVpd2pLrbgvvOcK0JLo+hRkzhtmVDV5mc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x8bCu-0006u1-5g;
	Mon, 21 Sep 2026 10:25:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x8bCs-0006tt-P7
 for openvpn-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 10:25:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=O4T/Y699V/lO99SdwbcYPgll0RDUtFZAiOvDxWwPGxE=; b=P3e2HvJxQe4JrI2hkrPfcokfSH
 Gd0LONpDIU1ojVetJAmVfdSwgCrpRS6lrJZNABp3HiLPk1FT5d/WR9EJtV5kcgSZ0FHxg36vGim40
 DHQ6/49xCreJzK6AUKBe8Ddr2KOdgKE2mWfLI4luLUVOUdUKx93UxGlHxEj3+e7ReTYM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=O4T/Y699V/lO99SdwbcYPgll0RDUtFZAiOvDxWwPGxE=; b=Z
 YrBwneewdoWgPyrNPcy8AkkweP+EtuJFxOXHHRHJJ/Z9RrcguT3/F+afZhkW/N20/kMZnLs/bfWSF
 WQswWaoIVAHkfrfz5jeHy+R8zl3TrUvSVDlGrsfBwetYaO4WCFiS4Efj9VsWEhInYieMpRCs1ixdI
 WU49h2aHtfmdeYKA=;
Received: from mail-wr2-f35.google.com ([74.125.225.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x8bCo-0003og-VH for openvpn-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 10:25:04 +0000
Received: by mail-wr2-f35.google.com with SMTP id
 ffacd0b85a97d-4885d4825adso234400f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 21 Sep 2026 03:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789986296; x=1790591096; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=O4T/Y699V/lO99SdwbcYPgll0RDUtFZAiOvDxWwPGxE=;
 b=GzrL44iJfPEPw/Gt8tP8+Q3IV8J/KW6B5zcna5qLk16h7//LIlzW9D1ewwq+iNx0O6
 PEXCDp6aB3LOu2aeepdLPEd35ma55RVgJ9hniAm579ChwsqIeGYWwFi2lonc2uFw3VCx
 AFHLQdZjOhfQw8HWyq2O552WXbClSbHrUQE2Lz6/LYxiyaKhUixlvkffC5xukdquAybC
 Vy/+2yJ2YdsTBVDcEKy95js5+otdepCE2mdnAW/GVKciQtaWENlKZl/loMMOkkFpkgiD
 ieLd4d2Lfl9Nc+TsmkXuI8QJIqdUw+OPwB7bSz3YK4lDNXK2QyLQtK/rzsTENIoqZk5d
 b5kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789986296; x=1790591096;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=O4T/Y699V/lO99SdwbcYPgll0RDUtFZAiOvDxWwPGxE=;
 b=NImEAHIs44BAIYwjyd4WOcs2aqoOQ8Jey/43LpOujm46xo6rDc/xOVsm9M9+BSEit0
 qt+CWCsHZUJuhy21e9bKCM1omS7rcDpXUOqZPXYvWySU0LvCzDHrS24IvpNRmdEGlVo1
 1NnfPvZ4A+/5TlVOsmqS2S0W5D+KQHJ9saZLwVIebLUd7aYoA86hPPuFjzLnY98nxAq4
 FQAaL5pm9MBPV8IO/UeoasotZbzV9YJTGlfbyJxsfzeEvjI/nrCK3hNtDx/eKB7koZxZ
 z4tke2QlaKhRWJ/ACgBzfYbq0bDNePxUSLZc0Iu8jKEN5+QELSR5XqlDUvAKwtG7PJYp
 TKbw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxb4LqgFft8UrC7c3uMu/PUKcblU68OsccXQQd7dNLnPVslgHD8pLFdbSOLlFilp4o55+/iFxC4AgmfSMBE@lists.sourceforge.net
X-Gm-Message-State: AFuF++kgi1Q8nx59+8+nZ72qM+MdnSjF6MYBTaLsW590qqtbJeIkO5bM
 5A6d9kTS6bv2VeJs5l6gTuBcVVvSZ18LNZwwW+aZHjVdhEgiPWJDySCN3VtFeku8vqgvd10fwLv
 txkm/JE7ViCNn1Ikeuf9vV72g1z3yuy4RUh4LQC9sEDd8kMgqlQ3kxmZlg7J19KD79nMx
X-Gm-Gg: AYBFou2eJdThfN1zijY3XQKukIxvuwN9Z5tV1YN3e5/RE8eTzT8nFID2OxYp9eXBf3z
 eotlYoSgHH84eKWXTf2fUMA/umJnzSwybV7Ok/0IHeQ3xLWPNvNAd0jN/Lx6LPdW41GkQPG4SE6
 Doe2f+WpuOZmxfV2sebRfjKELq3aVuWsK4CdfhDUoez8JuygXIFiiS0xSpXD/gcY459v3D8arP5
 Mh6q5vVIu0t6ks6eHDdXx2+Ux3w/lDJd0yIICp/+mE16lyVD/WnQxG956tyCBl0Q2qO7gnaZ+Qe
 AlhGUCOSxTYREuE9uHlzks3uEd40eBQnZWzMsiPmNgMz4mOQk2XC33Jo4s9LVERSfqewE3gwtsF
 LN1ZgUi65O5Ih/maYZLEekei5nD6LEhcCH/W5RyeF8WaZ8CTJgTxnOWvX22A45qXLW5MSoLezJ0
 GX+whHppAXWDPuTHCSHiiqCLn58Fvs7tNO7PnhQS/yitbDn5WgncPqSL3DYC5S+/JAR9XCmSdvF
 l/r777WmxM9MNWzYU0dAYDzMqgeC6QfT9pspjwbvNMYW7DP+wjLkRb9nGrKpwLjw2jtzo6cWDBo
 fqfIWmzmyYYG1s3RkCwjTEsjv2jSztiWLu6883y6KxRHm6WA8I7ZpRVsQtHXVGaA6y+J/P8=
X-Received: by 2002:a05:6000:40ce:b0:486:e787:9b88 with SMTP id
 ffacd0b85a97d-4871e3730abmr14416461f8f.53.1789986296235; 
 Mon, 21 Sep 2026 03:24:56 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48724564565sm21401847f8f.19.2026.09.21.03.24.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 03:24:55 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 21 Sep 2026 10:24:54 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 27
X-Gerrit-Change-Id: I375a41749060b7d006647bc27002c55436c8a8bb
X-Gerrit-Change-Number: 1748
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1748?usp=email>
X-Gerrit-Commit: e341e3134d523bec7b04ac998cad8c2a9b284616
X-Gerrit-Comment-Date: Mon, 21 Sep 2026 10:24:54 +0000
In-Reply-To: <gerrit.1782719911000.I375a41749060b7d006647bc27002c55436c8a8bb@gerrit.openvpn.net>
References: <gerrit.1782719911000.I375a41749060b7d006647bc27002c55436c8a8bb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkzNzVhNDE3NDkwNjBiN2QwMDY2NDdiYzI3MDAyYzU1NDM2YzhhOGJiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ab6ab2565fcd1623aac8bae5a9d862576cfdac9c-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x8bCo-0003og-VH
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Measure probe
 RTT for candidate-band selection
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
From: "ralf_lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7775059737390174027=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7775059737390174027==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HuAAYky+Fiw="; charset=UTF-8

--HuAAYky+Fiw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

ralf_lici has po=
sted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1748?usp=3Demail )

Change subject: oob: Measure probe RTT for ca=
ndidate-band selection
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 27: Code-Review-1

(1 comment)

Patchset:

PS27: 
Giv=
en the discussion on IRC and RFC PR #39, I'm withdrawing the +1 as this req=
uires a wire format change rather than just a follow-up extension=2E



-- =

To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1748?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I375a41749060b7d006647bc2=
7002c55436c8a8bb
Gerrit-Change-Number: 1748
Gerrit-PatchSet: 27
Gerrit-Owne=
r: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: stipa <lstipakov@gm=
ail=2Ecom>
Gerrit-Comment-Date: Mon, 21 Sep 2026 10:24:54 +0000
Gerrit-HasC=
omments: Yes
Gerrit-Has-Labels: Yes

--HuAAYky+Fiw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>Patch set 27:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1748?usp=3Demail">View Change</a></p><p>1=
 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margi=
n: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom=
: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1748?tab=3Dcom=
ments&amp;usp=3Demail">Patch Set #27:</a> </p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">Given the discussion on IRC =
and RFC PR #39, I&#39;m withdrawing the +1 as this requires a wire format c=
hange rather than just a follow-up extension=2E</p></li></ul></li></ul><p>T=
o view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1748?usp=
=3Demail">change 1748</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1748?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>=

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"=
display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ge=
rrit-Change-Id: I375a41749060b7d006647bc27002c55436c8a8bb </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1748 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 27 </div>
<div style=3D"display:none"> Gerrit-Owner=
: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 21 Sep 2026 =
10:24:54 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes =
</div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body><=
/html>
--HuAAYky+Fiw=--


--===============7775059737390174027==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7775059737390174027==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7775059737390174027==--

