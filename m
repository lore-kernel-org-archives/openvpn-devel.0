Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09043C4451B
	for <openvpn-devel@archiver.kernel.org>; Mon, 20 Jul 2026 09:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=S0Dcqy9QDpuuj6k0wl2Lgr12msbq4ln3MzbQHlGwdzw=; b=ldc/lBmKccZvPa
	unv/O6ThhUoLkCskBLcZ4/ndyp5A0MRhLtHfJFmlF5GvzGj1FXjOQSg6ce7nGrjEeOmBUDXNfBFTn
	6eA1m4bcg/+mfxYJqTnl7Wt5IJIiGjGM1VQyWE1Wga2/8pBgDRkignv7N0affXRqJBYpxG58eHW9v
	SoQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wljqv-0003z7-CG;
	Mon, 20 Jul 2026 08:59:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wljqt-0003yx-Dx
 for openvpn-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 08:59:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0Kmxqnu3qWqd48zU4qEksbTzJ8keWXEVxMNOQe2ILQo=; b=kJMfkKJSi4bDNk8+kix/67OYHg
 zLFwxiHwkGxkHMM4S5JOc31MSROoog6sA6HmNS1Ja9/MTwobfTPCOU+lRqSlmYrfPPST9rBCXq7LV
 11qT6Kka6HcH61LMhFYd0jOvTf3F8x/iD8OdOg7GQDzq7NdtFDLCt9p7xS8/BR1sWIXk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=0Kmxqnu3qWqd48zU4qEksbTzJ8keWXEVxMNOQe2ILQo=; b=k
 97/bdZGH+YaMEqm9OZavNZ6k3/TICPWcFpHHzXjn3YIPXdoCUgWJGFbpw77jTvgXfOk4FT4QqVZh1
 Nl/cG8uOZmNi8vCsift2cyMQSlsIsDB+arK6msCiE2/6xJSpYU1xSZ8jIN7PmBjWlX3uzZTaV4m+0
 2NjTc91T6TnVKuN4=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wljqr-0007sZ-6c for openvpn-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 08:59:55 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-495590ba856so9191395e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 20 Jul 2026 01:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784537987; x=1785142787; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0Kmxqnu3qWqd48zU4qEksbTzJ8keWXEVxMNOQe2ILQo=;
 b=V5Z+4MHbEKAIS6Q6/CNNA0qnuHhIpsPzjfJi2KS4FPyZv4VJInQ/y3wZlTXgb98E2N
 bqgodX6fHS8eNNSRGMzjK6q3ifnnxN/AuT9iEvF/ZMZPlcag2DuiphuZPpW4XaHewtOm
 LV08Nj/KQy/OBpNFg4LEt6cs5ZLWXKyaQ3zP5eAkNiSj0r/jJh0Jmf3xQbICIh37t08p
 kntA7SDV5mNw2Agtja7seRoQVDv4FWY+LodzOUIlWAjO2icd2hmXn5r92Xc8a7BVgGfA
 lppbsQBwcSEjbOpSXEmD3Kn254kOkiGorpOo++db+j2gz8MBC29Kxb+ldAp+Wgm/gjbu
 GO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784537987; x=1785142787;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0Kmxqnu3qWqd48zU4qEksbTzJ8keWXEVxMNOQe2ILQo=;
 b=Sjli4UpaA+0RCZLl0oEC9zS0Bqgb+xIH76U08q7FSn75x91wB8rGufuUVmQT32eQKW
 V27M5XmOfckNbLs08Z2IBwMYE8IlLY5U9P8EExo9f7/v+1tQ56MpTzulxoR9qOAHiGcP
 OeEepyhijo3zcQ2DnWNoMO/eXLack++yDW9es3MiS5nij/W/lzhgJtxByFuYeSLPt28N
 8+LowXtlanTntNFdh7gezjs/hMSDLLrRoUrGVWtWO77Gm9eMnUK8C5uGDrgEw5hbxdh1
 LssyHlApCw9Wweu5OsXwVhXzMfrgHuBCN5KUkPthg7RAGx8SXCoFlm698jCC9IvxZmke
 R2Cg==
X-Gm-Message-State: AOJu0YzJzGUeatpjciotz5stPk+dOb0YtkLO5qQcAWp6y3COLfSA/QA7
 ew3kO3iToJVEXl2AYEE0vt2NFOJ2ujc7nocAIRO6MJWoMaVdgBTID2dRWNI6zKbwviPVnBS6NnP
 0/4GD1ZJdJiL/y3L2m/4LPyMgmbLip2Ou/jat99b9kOFLhIrs7mbo5Oru4l7Qdv+TygTdgUCSut
 qk8b9SwA==
X-Gm-Gg: AfdE7cnsCuKg+7omS/HG2fS2O2ZyhXpuueVU0KrQtuL8XvMe3DhX1vPg3XOVxnBLM94
 WDnA6Q9ehsiGFCRUqmgIxO4pp9Tq+pXzlLJpNyyypuw6XNg2E0rE58ZRI2B/uI5pt23UuI89dPy
 AfatR07cHEnP+LixAJ8qwgt4H8VXB5xYP5o35Nrzj8ymcMynCPJf9DAIANl/fNGM8y4YST/xdx9
 R3m9ybI4Wbca/YGYgK9rfbG5imqaDw7FWUKy3iV5CQvNaNoKVMCJlcM2qB+8bFSOqVe4bPQjVhU
 3emcICJ7xYrU0ppEaU8bZYlSaBi7VDMaxMn4i3byADr9s6DVciqAov6sgqEC5RFvbvAsbYo+jGJ
 OOBpQTMhxBP46MtKxBFi39ucnJS5+fmdkz3niFncp9kaihykGHHHDYu43dCFnETj114MuGW2GnE
 fmrCG8h2W6iWGhKne97IdsMV2FvoNChCF3xyPA9OU3DVIgHo8/wnoHiCDW3S2Sa7unzUaLOAfZs
 6d4eMT1tkwsv3nwDwYraFfTr+l4UOPfYS39e8NCCbd9dAX9W59UcDVYJggSqNH2spH4
X-Received: by 2002:a05:600c:138f:b0:493:b243:8ffc with SMTP id
 5b1f17b1804b1-4954a50d685mr155438245e9.35.1784537986428; 
 Mon, 20 Jul 2026 01:59:46 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4955a9e5f26sm78081185e9.0.2026.07.20.01.59.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 01:59:45 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 20 Jul 2026 08:59:45 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I5295e5d26c5bf60cd9607da4c804d04f2144634a
X-Gerrit-Change-Number: 1796
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1796?usp=email>
X-Gerrit-Commit: 316652044266c047e9199abb3e831c67f0edfbeb
References: <gerrit.1784537981000.I5295e5d26c5bf60cd9607da4c804d04f2144634a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0NTM3OTgxMDAwLkk1Mjk1ZTVkMjZjNWJmNjBjZDk2MDdkYTRjODA0ZDA0ZjIxNDQ2MzRhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <77f7ec1a600089f5c170c1f1716cf655fe7d5344-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wljqr-0007sZ-6c
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: silence autoconf
 warnings about openvpnserv_testdriver_CFLAGS etc
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
 openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1141886112395559153=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1141886112395559153==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YnjDt+vfpn0="; charset=UTF-8

--YnjDt+vfpn0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1796?usp=3Demail

to review the following change=2E


Chang=
e subject: silence autoconf warnings about openvpnserv_testdriver_CFLAGS et=
c
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

silence au=
toconf warnings about openvpnserv_testdriver_CFLAGS etc

Github: OpenVPN/op=
envpn#1079

Change-Id: I5295e5d26c5bf60cd9607da4c804d04f2144634a
Signed-off=
-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M tests/unit_tests/openvpns=
erv/Makefile=2Eam
1 file changed, 1 insertion(+), 0 deletions(-)



  git p=
ull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/96/1796/1

diff=
 --git a/tests/unit_tests/openvpnserv/Makefile=2Eam b/tests/unit_tests/open=
vpnserv/Makefile=2Eam
index 6294c52=2E=2E19de666 100644
--- a/tests/unit_te=
sts/openvpnserv/Makefile=2Eam
+++ b/tests/unit_tests/openvpnserv/Makefile=
=2Eam
@@ -5,6 +5,7 @@
 if WIN32
 test_binaries =3D openvpnserv_testdriver
 =
endif
+check_PROGRAMS =3D $(test_binaries)
 
 openvpnserv_testdriver_CFLAGS=
  =3D -I$(top_srcdir)/include -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/s=
rc/compat -I$(top_srcdir)/src/openvpnserv @TEST_CFLAGS@
 openvpnserv_testdr=
iver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn

-- 
To view, v=
isit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1796?usp=3Demail
To unsubscr=
ibe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn=

Gerrit-Branch: master
Gerrit-Change-Id: I5295e5d26c5bf60cd9607da4c804d04f2=
144634a
Gerrit-Change-Number: 1796
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <=
gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--YnjDt+vfpn0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>cron2 would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1796?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">si=
lence autoconf warnings about openvpnserv_testdriver_CFLAGS etc<br><br>Gith=
ub: OpenVPN/openvpn#1079<br><br>Change-Id: I5295e5d26c5bf60cd9607da4c804d04=
f2144634a<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br=
>---<br>M tests/unit_tests/openvpnserv/Makefile=2Eam<br>1 file changed, 1 i=
nsertion(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t=2Eopenvpn=2Enet:29418/openvpn refs/changes/96/1796/1</pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/tests/unit_tests/openvpnserv/Makefile=2Eam b/tests/unit_tests/openvpnserv/=
Makefile=2Eam</span><br><span>index 6294c52=2E=2E19de666 100644</span><br><=
span>--- a/tests/unit_tests/openvpnserv/Makefile=2Eam</span><br><span>+++ b=
/tests/unit_tests/openvpnserv/Makefile=2Eam</span><br><span>@@ -5,6 +5,7 @@=
</span><br><span> if WIN32</span><br><span> test_binaries =3D openvpnserv_t=
estdriver</span><br><span> endif</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+check_PROGRAMS =3D $(test_binaries)</span><br><span> </span><b=
r><span> openvpnserv_testdriver_CFLAGS  =3D -I$(top_srcdir)/include -I$(top=
_srcdir)/src/openvpn -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn=
serv @TEST_CFLAGS@</span><br><span> openvpnserv_testdriver_LDFLAGS =3D @TES=
T_LDFLAGS@ -L$(top_srcdir)/src/openvpn</span><br><span></span><br></pre><p>=
To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1796?us=
p=3Demail">change 1796</a>=2E To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1796?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/><=
/div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </d=
iv>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I5295e5d26c5bf60cd9607da4c804d04f2144634a </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1796 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--YnjDt+vfpn0=--


--===============1141886112395559153==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1141886112395559153==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1141886112395559153==--

