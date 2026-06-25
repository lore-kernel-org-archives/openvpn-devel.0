Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1EBECDB479
	for <openvpn-devel@archiver.kernel.org>; Thu, 25 Jun 2026 13:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iZmFECS5CoV0E+vMazrMA8tjsRwN+787mff4Vb858ko=; b=HiiXQVNbJeTdSeByofFpfAloQ9
	GzM19G+iAqC3j/xMsPbTXDq8XJhqmb29V00xoHJas4puHbZnyCQ2RaGD82IxdmKsePWZdX/b3SvJr
	6eWxsXoNM+0FHIUFvkNMB7cWx+cTDkFelnXGbk3zwhj3H4KeWZaHVmYj+2Dnj7OiWdhs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wck9i-000464-GC;
	Thu, 25 Jun 2026 13:30:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wck9h-00045y-3f
 for openvpn-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 13:30:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=7GtYveQ9jpyVCyIqTiW4eftOjNibx9R6oNdZ0UZ/z2Q=; b=Fw55GJihfMWBuQ+E/aaF6JwHHA
 r3ngdEUTFVRzIeeYOZHZp3upuRBcEb1QvXCvc4oE3DZxFk0JZ9JCxCGgajYK31YCUFnkf7EHyyN64
 /W51a7TgNTmew0xlomuyyMt4PqK6dtxCA0jS5zbFsZrjN7LdPFVn/5SVJFil4Zkdd9xU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=7GtYveQ9jpyVCyIqTiW4eftOjNibx9R6oNdZ0UZ/z2Q=; b=K
 ior4KIzaNqg5jT1AmaqbI3Z3a1X+Xn9IiUjh9TQrcIUOJFi9twQxewLV8mpKG29lP/8vLJKk1SOJl
 8hsHSbWQKP3rFy6RuQViL3jv8Ps3s2W97AW2gZyAovswiqy+ZXAhlvO8P8HdIezqu2bUWtnYBFw1u
 SSke2mZcFP2XIP24=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wck9f-0000wX-LJ for openvpn-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 13:30:09 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-49261a64cf4so11683485e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 25 Jun 2026 06:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782394196; x=1782998996; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7GtYveQ9jpyVCyIqTiW4eftOjNibx9R6oNdZ0UZ/z2Q=;
 b=glqd/2Jy/uvxSdBUJFR0VdiBqyFxlfrTKQpCxFo2QabrVTp/2y9re7gXTFmvh1ZPi3
 tMCz5ea6yAjm5+qwGAhuDTKswsyC6rwoSS1p5107c9Jh6mroBb1dn0ssxqxVjsnsVIl5
 DW5nR/ogqTAP5cyO20pbhQ8sYH7FcQBwyQ1Q7vKR5ftOP8FDqhffD2WPj31IEnbp+QPb
 yCQctNdm2pJtMc/MdAMFQUkLnHF0Jwukxl7WQpMscZdrwFYX+7x8zhfPYy+DY7kR4zdE
 2vpTXa1L0ihvjy47IQXEcsQgIMutHyYDC2Nk6MV0/LqCgIiyjNybDQ9VL6E51QvMtIE0
 vncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782394196; x=1782998996;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7GtYveQ9jpyVCyIqTiW4eftOjNibx9R6oNdZ0UZ/z2Q=;
 b=AqvqidvoyZKyrT5lde/t/MlwcX6e88bgHFSrd+B5xWNpKfORaMb0dU9uvDAt5vDkAj
 mhrtAtlThPJ1yHht2ckCwPJroG2FiftKbTSC5W9c7GNKr9YFteTXU74yamBhMPVRwSXd
 UkZ+67EqJtqN/+yi6Rsci9ywsLdJKJXzNE+8oXk72oYisLsnNlItpzWm169b+MhqdU2T
 03/oqI83FhXhpeefWfwOHJZKtqTgCEYcWHaSV712jAYTHAHlWa/4SLd6J2Aqt5SBf4ju
 wAFclFBj+vM92hl2BgRM+Fu7pAXw4RvN/0NhzpqFJjRdLLHeb2dNN3sNKSol+VQir/XO
 NbYw==
X-Forwarded-Encrypted: i=1;
 AFNElJ88ndkogQ0Sih/X2388sQgS2rppM1vzeC/+epp1GPvewFQMY75I/NjXKig7ug2z6dylwlflFzpZcqYtNALa@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yy2XCaxcZd0h9ePMO1BDoDUMzzH55Ol1pBNzsCskPh5JcyUEXTW
 MeZWwuhblrmoxURU9P/17MZ2dymAneeqIkgAw1tT+Q4uAPhtCfzuCstu5QWBv9X+T7lacGy8AWC
 7+w/FLtro8ygTcSEVBMj549+E6ykb+sfTMdPq6Gnp2iqqogLtRuC6PIunmtQgl1JC25/JXiQ6hT
 RbyKZcig==
X-Gm-Gg: AfdE7clpmOcecJsW3Ym6uB1zNiq9uZ1MEJVBDb9/zYtkA2pDYNPHgysa1kGaZky92xe
 0btrQkJ+2Ys06sCwQ8nyI+nKjpJWvX91Ij+3H9taPzC43J8ojJdoDvLQso8QppWTAGHhclEDNe9
 3I6/TKIdDrOWYJ1NWiOTLBjQEG8MbcTHdMMwKoywrDgAOY7cZts5RoaDToZ9tebGGilsK08BkZ0
 PIH2vlILRslWvkxEY+UZK38sjQY4/D5jNw2xFzi7YcMdkFZBvbZX6Z+d9ekPSY1hpjqVmvThSc4
 ts2S6PRPVsM9rqoxvS9VlZrKvkV0Ty6jjfT7skL9+i/IPlfYF4ipGwopr2+DVCYPtuCcxxRowa/
 psaoI3pmS3vTv9OlDrxsVfdAlp+Awxx0FUT0UggSqMHMjSKZkeN/te8gq4MU7jaCie02bsa6Df1
 LrOA4LzhiaX7DKeKc89jFAlVcrIIIdxCU8T4JikE+qpSPZDr5Wa2yezrrE/o1Yp6Pc1XsjawlZy
 X/zm/31LmRtoVnAGeUFpVJxSXnB1h+D5BiQi8oTdV6zfNmk8dv+D7qh+DJd5PEVAJs0A6kB9W1H
 8Us=
X-Received: by 2002:a05:600c:1d86:b0:490:d354:bcf4 with SMTP id
 5b1f17b1804b1-49266885dc4mr32856435e9.27.1782394195340; 
 Thu, 25 Jun 2026 06:29:55 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4926401a2dasm81069065e9.2.2026.06.25.06.29.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 06:29:54 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 25 Jun 2026 13:29:53 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ie552084638320b3bace76be2f589013f12af3c46
X-Gerrit-Change-Number: 1724
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1724?usp=email>
X-Gerrit-Commit: 572f2d5cb4d3fd97f70dd0ce9282b9c21eea0a88
X-Gerrit-Comment-Date: Thu, 25 Jun 2026 13:29:53 +0000
In-Reply-To: <gerrit.1782134588000.Ie552084638320b3bace76be2f589013f12af3c46@gerrit.openvpn.net>
References: <gerrit.1782134588000.Ie552084638320b3bace76be2f589013f12af3c46@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkllNTUyMDg0NjM4MzIwYjNiYWNlNzZiZTJmNTg5MDEzZjEyYWYzYzQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6d73c6ed64f0a8426342f810f6dac06edc864449-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wck9f-0000wX-LJ
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Add check that
 username is identical to multi float
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2387457334638146694=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2387457334638146694==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="k9FmKs3MuSA="; charset=UTF-8

--k9FmKs3MuSA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1724?usp=3Demail )

Change subject: Add check that username is id=
entical to multi float
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 2:

(1 comment)

File src/openvpn/multi=2Ec:

http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1724/comment/27ca2ba4_c86e309e?usp=3Dema=
il :
PS2, Line 3149:         }
> goto done missing?
Yes typical case of: Fi=
xed it in my brnanch but put it into a later commit=2E Will fix this=2E



=
-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1724?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Proj=
ect: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie552084638320b3bace76=
be2f589013f12af3c46
Gerrit-Change-Number: 1724
Gerrit-PatchSet: 2
Gerrit-Ow=
ner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <=
frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Eso=
urceforge=2Enet>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
G=
errit-Comment-Date: Thu, 25 Jun 2026 13:29:53 +0000
Gerrit-HasComments: Yes=

Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@lichtenheld=
=2Ecom>

--k9FmKs3MuSA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1724?usp=3Demail">View Change</a></p><p>1 comment:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0;"><p>File src/openvpn/multi=2Ec:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1724/c=
omment/27ca2ba4_c86e309e?usp=3Demail">Patch Set #2, Line 3149:</a> <code st=
yle=3D"font-family:monospace,monospace">        }</code></p><p><blockquote =
style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">got=
o done missing?</blockquote></p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">Yes typical case of: Fixed it in my brnanc=
h but put it into a later commit=2E Will fix this=2E</p></li></ul></li></ul=
><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/172=
4?usp=3Demail">change 1724</a>=2E To unsubscribe, or for help writing mail =
filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demai=
l">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/=
ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1724?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: Ie552084638320b3bace76be2f589013f12af3c46 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 1724 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-O=
wner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-dev=
el@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit=
-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Thu, 25 Jun 2026 13:29:53 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"=
> Comment-In-Reply-To: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
=

</body></html>
--k9FmKs3MuSA=--


--===============2387457334638146694==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2387457334638146694==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2387457334638146694==--

