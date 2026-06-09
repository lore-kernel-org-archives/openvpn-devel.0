Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE58DCD8CA4
	for <openvpn-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=sd2VpgyYH+b+B60UnV/BhHngNNbdKooHH/fAu1mmk4o=; b=F6gtn/MeuRbDUM
	Sw6uAqX/5Xi2ITjjoRXBWpor2gi0Pw4pR+eSXebYnxf4xN26pRZRELnioAVEVcgm9sFDNiCOXJwHs
	06h0KernzfQfPeogl9nGSy8RWFgs28fzgB3Csj1SLuXCEfjj3ZGwgDGwFC0j5WyaoStxqyMAMyUvI
	IMA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWxux-0006HV-GR;
	Tue, 09 Jun 2026 14:59:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wWxuw-0006HN-4X
 for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 14:59:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Yt4CxjL0AzIdb3EC0M/8RMANoHWSufDamV5lp/krL38=; b=ZQGyPk9FbOm8CvvxcyPMXtcRBu
 Rbfp4svc9k+hgC43x6rUgWegRX6glaW2EUfNpRyYhyZH8Io9jXF7yVeW6/Un4XOGbI4te68s540Ik
 9QpkQBV6jcMhhZ40bSCbFOuv6uOWzFDgrQDAinWXvhG+koTXoemun+TDzg0F3s2TwErs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Yt4CxjL0AzIdb3EC0M/8RMANoHWSufDamV5lp/krL38=; b=N
 m/qlCfY0zsvK/t+L+TaN/RxZ5iq1AkIsnCtKemtGSgBJApkdVoQJZPwCYt/WAgYXC1/Wf5OMjXSBS
 Qxia6qH1QreLDULErQ3iajYlr/pN/HO8e53cJ/U3JKVzAXFDRAFmsgQk1B0ml4zMLRvU6IjatOGOB
 NUDIAcKwZcY9voxw=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wWxut-00006Z-SH for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 14:59:02 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-490b613a17bso55654815e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 09 Jun 2026 07:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781017129; x=1781621929; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yt4CxjL0AzIdb3EC0M/8RMANoHWSufDamV5lp/krL38=;
 b=GWch32HcCFDsRXNqLW0l7zAI/uP70ACcmNLg+AXALt/Al24ULtWiOZXsVklvIBcWqy
 G0RkhwsIjSbI1fcJ42jMBc7cTYxwYtYDAdwuQOinqfr0TOsHVI0BsabfD0xJpYO6nGCW
 RyQ2ttUONBT9+cUcPUkAE2ayd3YeuX3eMRHw1l2WoLH3CvYM7iI3VvlKIgXMkXtm18XO
 sFJIBA4UWXoxpZXY+JSsYho8aOwiUAGd85Flbh6EhncHHR1wd2A+0BvQwHmPvZ04ZL41
 9qYPwwjUCMtR95NLeCGyAoiddeCbuF+g4F4ixsULdI3yfZozNxMeoo+Kp3bbgOagPyKa
 UrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781017129; x=1781621929;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Yt4CxjL0AzIdb3EC0M/8RMANoHWSufDamV5lp/krL38=;
 b=CFit1HywsxUW77sPkeBytA9fopf91cUCn0oG67nW3Kr+ssAdUe5FfS/HdoznbbpFIU
 8Eabg0xvuKsA1OyhuZK5Og5ZSOKBa4yDZTOZZLi83PbQavYP+ut7vS3Z517FpGXXN6Mx
 eKpdyu6B6SQfDxr89v+3GGjNMzcVJTWKw3sMpeepuLRy7LIyn9ZJGCovj+WM1QEwmRiH
 9OPxyHIg06FI/wKS1IFGp2YMTyK/+6zPbPKXjBd8qIPJ5jFmX0xARV+BoK5+Adp1iRn1
 F0iK1tOd01i9w1MSwMXRrHZKdbvSFS2ta3QWB+Vtx3RyShH3WXxSlmkdekhA+jo7mffn
 Rnqw==
X-Gm-Message-State: AOJu0Yz3TXnRHY2IylQZFQoVSlgmUowJDpNBpqlxlfhHJoOPvsQKOo/D
 n/B/Ag8l0sXWmKRaTvYmpYdV4ZwSNgGs9e3Mv6QYGb2aHKW+2QaijMrE0vy83/2ELNLCw/oJW4p
 EhF9ii8l5iqpQZwu0IHE2fXhkfgHmdruoQ+R0cM4m7NLTgFx8BodeAP9t7q10nuarLvUx
X-Gm-Gg: Acq92OFlYQOodp8BFijYME0CkJhXAxxOlfEyxX3oav2Y0ZS6aEZTN08ejfcdxRAuolJ
 IsgItJVrW8UFJZOy/ELzyr7s3ebkGpFaHflsBIOsRaF3ESXQtfI6x9aIOb1JWmZsRluqfnlTfP0
 J7VmhLfVnBIpIyCIYM6lc2ESK0ObsGlUSWdDFI12yPYKow3a5MQ56z8ENtp/JUuUQO9WDNAcNP6
 0S0ZoFcmaIUk20cJWeqDlH/uElUJMxK7qa4QX8Nj7OQreQq9GoNhSZZVDYiwejfY5RWuua7OYbu
 iXjzuKn4935q28fTfnvsrp3QkVJx7Q3BnfROCsSKtVaKxyVBhVtdhHsly8nfn4L+7fQCcrebyYs
 a4OPy7KLi1uBTdJfcxPt9hzvzkH/lFq1zZEc3wBNy5U9PG6npJIbTc6+0wKX0xOyEuMxJQAHR5y
 IM1Tnt+n/JiqhEo+Ugi2SfWQzmbb4przUnnVFcSVvO2zhIyJ1mkWEuTooJVGtU/Mb8E3XWDHsPh
 14tklefPYUGjn8J7ff45Fq5JA3PBF4J6/qpk0WGzkGpB90Vg8Q4Svr8GnDclqzlzNJZ6AONqvpl
 N5zmoexLrpnDYtlU69ojClhT
X-Received: by 2002:a05:600c:5250:b0:490:b642:ce2c with SMTP id
 5b1f17b1804b1-490d720455bmr36231535e9.14.1781017128718; 
 Tue, 09 Jun 2026 07:58:48 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490be1f69bcsm526763745e9.8.2026.06.09.07.58.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 07:58:47 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 9 Jun 2026 14:58:47 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I668b96afae9dda5692c46db14634b3b8c03056e5
X-Gerrit-Change-Number: 1709
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1709?usp=email>
X-Gerrit-Commit: 1bf7e92ed09e06e587a10c474ec760775a16947e
References: <gerrit.1781017122000.I668b96afae9dda5692c46db14634b3b8c03056e5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgxMDE3MTIyMDAwLkk2NjhiOTZhZmFlOWRkYTU2OTJjNDZkYjE0NjM0YjNiOGMwMzA1NmU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0cc5961fc4dd5750ea7c7b07ff19f9e00ef9d799-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wWxut-00006Z-SH
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: renovate: Fix typo
 in regex manager
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
Content-Type: multipart/mixed; boundary="===============9210483299898041514=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============9210483299898041514==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ay6Nvzmwxj4="; charset=UTF-8

--ay6Nvzmwxj4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1709?usp=3Demail

to review the following change=2E


Chang=
e subject: renovate: Fix typo in regex manager
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

renovate: Fix typo in regex manager

Bro=
ken since commit 8485518dce6b7ebeda6295fcdf3bc7476b7b9117
("GHA: Factor out=
 building SSL libs to a reusable workflow")

Change-Id: I668b96afae9dda5692=
c46db14634b3b8c03056e5
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
---
M renovate=2Ejson
1 file changed, 1 insertion(+), 1 deletion(-)=




  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/09/1=
709/1

diff --git a/renovate=2Ejson b/renovate=2Ejson
index 3bd0917=2E=2E5b=
6e0d0 100644
--- a/renovate=2Ejson
+++ b/renovate=2Ejson
@@ -40,7 +40,7 @@
=
                 "/^\\=2Egithub/workflows/=2E+\\=2Eya?ml$/"
             ],=

             "matchStrings": [
-                "versioning=3D(?<versionin=
g>=2E*?)\\n\\s*ghrepo:\\s*(?<depName>=2E*?)\\n\\s*gitrepo:\\s*(?<currentVal=
ue>=2E*?)\\n"
+                "versioning=3D(?<versioning>=2E*?)\\n\\s*ghr=
epo:\\s*(?<depName>=2E*?)\\n\\s*gitref:\\s*(?<currentValue>=2E*?)\\n"
     =
        ],
             "datasourceTemplate": "github-tags"
         }

-- =

To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1709?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Proje=
ct: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I668b96afae9dda5692c46d=
b14634b3b8c03056e5
Gerrit-Change-Number: 1709
Gerrit-PatchSet: 1
Gerrit-Own=
er: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esou=
rceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--ay6Nvzmwxj4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1709?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">renovate: Fix typo in regex manager<br><br>Broken since commit 8485518=
dce6b7ebeda6295fcdf3bc7476b7b9117<br>(&quot;GHA: Factor out building SSL li=
bs to a reusable workflow&quot;)<br><br>Change-Id: I668b96afae9dda5692c46db=
14634b3b8c03056e5<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=
=2Ecom&gt;<br>---<br>M renovate=2Ejson<br>1 file changed, 1 insertion(+), 1=
 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/09/1709/1</pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/renovate=2Ejso=
n b/renovate=2Ejson</span><br><span>index 3bd0917=2E=2E5b6e0d0 100644</span=
><br><span>--- a/renovate=2Ejson</span><br><span>+++ b/renovate=2Ejson</spa=
n><br><span>@@ -40,7 +40,7 @@</span><br><span>                 &quot;/^\\=
=2Egithub/workflows/=2E+\\=2Eya?ml$/&quot;</span><br><span>             ],<=
/span><br><span>             &quot;matchStrings&quot;: [</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                &quot;versioning=3D(?&lt=
;versioning&gt;=2E*?)\\n\\s*ghrepo:\\s*(?&lt;depName&gt;=2E*?)\\n\\s*gitrep=
o:\\s*(?&lt;currentValue&gt;=2E*?)\\n&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                &quot;versioning=3D(?&lt;versioning=
&gt;=2E*?)\\n\\s*ghrepo:\\s*(?&lt;depName&gt;=2E*?)\\n\\s*gitref:\\s*(?&lt;=
currentValue&gt;=2E*?)\\n&quot;</span><br><span>             ],</span><br><=
span>             &quot;datasourceTemplate&quot;: &quot;github-tags&quot;</=
span><br><span>         }</span><br><span></span><br></pre><p>To view, visi=
t <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1709?usp=3Demail">ch=
ange 1709</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1709?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div st=
yle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:=
none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Id: I668b96afae9dda5692c46db14634b3b8c03056e5 </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Number: 1709 </div>
<div style=3D"display:none"> G=
errit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichte=
nheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Eso=
urceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: p=
laisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--ay6Nvzmwxj4=--


--===============9210483299898041514==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9210483299898041514==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9210483299898041514==--

