Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF5DCD98F2
	for <openvpn-devel@archiver.kernel.org>; Mon, 22 Jun 2026 14:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=49RX9H3CfZxRMuLkDTOWPNrG75uiyzi9G1DH02EiNEY=; b=TCk9ngUiiyvzR5Sfbw3mPb2l+n
	i+b/utFucXniizF2bnez7jP2WJ3EjwPKz3mOtvgn9MsJ2v+2SOwWWiSJHn3rX64U09V4DGa+nPsBh
	Mh3fFlbdkNymOnOzK7yZH+bFQO52GiqZxyd/wjycLmOlljuiTA/49t7d4e9bU72m9uGA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbfau-0005pc-AG;
	Mon, 22 Jun 2026 14:25:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbfaa-0005p8-Uh
 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 14:25:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=SE0dTOpuBo2xqXLtdTAxRuom2ZcWZtWWPXRPgbjPPcc=; b=HgItUwyPmWRzIxESusXAZpnj5L
 uX0R7zC84lNnmG0IEZb48dXgYmjOVG7iC4UTd5wePNtfJxCDYjoPv0atp3dYf84e/+U/6fLzCGioS
 JDQ3ewPcJ8PYepGMHGh0lgglTSIIlnTTG3Vif8p7D1M/bY07KGm8d7OD019OFqdnhPSY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=SE0dTOpuBo2xqXLtdTAxRuom2ZcWZtWWPXRPgbjPPcc=; b=F
 5Me6B25BaiAcBDnGIuxpBmpiF+HhVOV8EdH9Uw2WxJt8A19g9/+2RXbeYPY3RwfhyTb3A8V8Qccsn
 jqbGWauIbads97kBU8kt69K5mXFcJXeeJHbQvnzn+QZ6M/HegsuLvOikux8GjOROo7dmzY/rlH7BT
 MDxe4JbUezHa/P5c=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbfaG-00043Y-2B for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 14:25:11 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-492329c5514so17982755e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 07:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782138297; x=1782743097; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SE0dTOpuBo2xqXLtdTAxRuom2ZcWZtWWPXRPgbjPPcc=;
 b=NLcOBhZ9DhJCicPUp4TzjdQClGKvAbXRRPhvYzbbHgTVIe86ceMJSs4B1MkjZwntCv
 VX9/jSppL700s7+aSA+Rfn77TwokcKGa9u5iCNLJTqfIslM8d99V45ptVGY0z9c8b/aB
 2UFnuJx/Cvc0/fvMIEvDhnA4d3LKr9Yxovr4/OKZXkQujBLiTm9NoVN15BGVJMc/q1sZ
 HTmz2kS3m8zZWDXLeDMTn4h1Nx1Hhm42oX7UGHXdpa6TS9BbsryVJQrTHwMah8iJNClw
 oTsaxghrEkPdt0uGSPWu2js1in3zG8ShzK/qNUZ2IpxcJYD27sQVIIJLsAmalJEiP3s0
 BDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782138297; x=1782743097;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SE0dTOpuBo2xqXLtdTAxRuom2ZcWZtWWPXRPgbjPPcc=;
 b=RchZG9WuZq/lBPNiyIcM0VxkxS07v/QGWo2m50K9uDCiw/1XIqdT53370V3IhR8DLJ
 MSvkTwCAj+E74Idmxq6jXN3Ns7tAkdCeHijM1u/VgiPZ7u+5DxOEjIpInhSlOYn9elza
 eFkPXsRzhYDh/sIXcmJQ1BlvBRTlepiUQRId11vTi1KO1A0A4SXZkXr5pHWyZgRVPyZx
 2FuB9RIKQFrecyofbJuigU9JfnRZsLonfl1Fx9xhcepvIeGJR8NmcYBzIeFPa5tt68fe
 DkumH2S1818dLncMPVAZGW1AoZNYmjkZZNlvp+L3+2DnWOTrPscxhB2Bsy5V1dzS0c19
 Sw1w==
X-Gm-Message-State: AOJu0Yxnvjx3kt2ZQiEDPDlSOs8FWtfvrh97iD4DZnfXFBdv8GTgrbSv
 /8XBRwBPZ/J5J2aRe0y58JmbClo+usDSlm+dIyJ0MTD//Gi5rmLlaCIFsEHJ57ajhyH57dz8t6i
 Zul3cK7itrkJe0J4PPatXa4YykX8laX/hpagpoXf/+CXJTUlvbgF5u73xFo5uMbJZr/kW
X-Gm-Gg: AfdE7ckSA8pNeZJZSR9rrT5i189K0LLOiRrndyZwSfoMMJ4JTYnhOecuWpQF6vIlOrx
 RDLK4bYaX93xbagQJhNYsN8Mv5qlw5hurF0+uvaSO2eA9zLaFTts0NcFqfEj59qsBx5ejkfOBNs
 Ol5CBIaJ+40geD8pER+XIiPkSbN4hZuHpC5Od13O9l7Zbs9lysNIyzs64Whh81qLfKs8CPr1QK/
 Kly9cNlsrec72w3OxGjFXUQ+iclmFBtqYHID6EqY+CNA4QjjD+iqE1y2NDHAF1grglCYKcrDB8n
 QLyvvoLHSNo75WBoHe+UpYlQCHgaC1tSIylZgh1DebwvYpjpS9fWIUwq7SSWCDKyBZVz9Tgkz7V
 kO/S29aBv7C4eTdg3uGDo9CSBBxAR8NA6pYAXVogbXrbpX0CDLfWZy/WvPGL88Z3BJ5nlAfmYKZ
 CUYc/TyLeYJiZUJF1x6UO+PPTXOIeTY1lEBy/hpUHXVCxVJGq++tjHEoMJSYwRmWFY4KSpXMB9m
 T2LAqIJrEskP4NwpWhgZcmTCx/A5re6ApBPwOwpTwAz4IvzZodeHos3cDEjZxwUcNW9lRoTy27M
 zco=
X-Received: by 2002:a05:600c:4e4f:b0:48f:e230:29f5 with SMTP id
 5b1f17b1804b1-49240a486cemr186549955e9.16.1782138295929; 
 Mon, 22 Jun 2026 07:24:55 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49249207dabsm373456095e9.0.2026.06.22.07.24.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 07:24:55 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 22 Jun 2026 14:24:54 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I0737b769e78e6d271ec874cadb9fbd81bfefdec1
X-Gerrit-Change-Number: 1634
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1634?usp=email>
X-Gerrit-Commit: 6203816bd2bb8c1c1d5236f4f008697dbf402f6b
X-Gerrit-Comment-Date: Mon, 22 Jun 2026 14:24:54 +0000
In-Reply-To: <gerrit.1776768003000.I0737b769e78e6d271ec874cadb9fbd81bfefdec1@gerrit.openvpn.net>
References: <gerrit.1776768003000.I0737b769e78e6d271ec874cadb9fbd81bfefdec1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc2NzY4MDAzMDAwLkkwNzM3Yjc2OWU3OGU2ZDI3MWVjODc0Y2FkYjlmYmQ4MWJmZWZkZWMxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ff21927a45d3bc8dde2c4d2f4ce7bde78a5b2996-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbfaG-00043Y-2B
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Only announce
 support push updates/IV_NCP when actually supporting it
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
Content-Type: multipart/mixed; boundary="===============5180812034116303304=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5180812034116303304==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UO7bQbXj2Xk="; charset=UTF-8

--UO7bQbXj2Xk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1634?usp=3Demail )

Change subject: Only announce support push up=
dates/IV_NCP when actually supporting it
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3: Code-Review+2

(2 comments)

Fil=
e src/openvpn/ssl=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1634/comm=
ent/f68afcba_f0324f2d?usp=3Demail :
PS1, Line 1951:              * of IV_CI=
PHERS */
> missing closing parenthesis
Done


http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1634/comment/c67440a8_2d6c4410?usp=3Demail :
PS1, Line 1960:  =
           /* We are not using pull or p2mp server, instead do P2P NCP */
>=
 comment is now out-of-sync with code
Done



-- 
To view, visit http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1634?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: m=
aster
Gerrit-Change-Id: I0737b769e78e6d271ec874cadb9fbd81bfefdec1
Gerrit-Ch=
ange-Number: 1634
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerr=
it-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atten=
tion: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Mon, 22 J=
un 2026 14:24:54 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comme=
nt-In-Reply-To: flichtenheld <frank@lichtenheld=2Ecom>

--UO7bQbXj2Xk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 3:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1634?usp=3Demail">View Change</a></p><p>2 comments=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0;"><p>File src/openvpn/ssl=2Ec:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1634/c=
omment/f68afcba_f0324f2d?usp=3Demail">Patch Set #1, Line 1951:</a> <code st=
yle=3D"font-family:monospace,monospace">             * of IV_CIPHERS */</co=
de></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0;=
 padding: 0 10px;">missing closing parenthesis</blockquote></p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></l=
i><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: =
4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1634/comment/c67=
440a8_2d6c4410?usp=3Demail">Patch Set #1, Line 1960:</a> <code style=3D"fon=
t-family:monospace,monospace">            /* We are not using pull or p2mp =
server, instead do P2P NCP */</code></p><p><blockquote style=3D"border-left=
: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">comment is now out-of-s=
ync with code</blockquote></p><p class=3D"blocks" style=3D"white-space: pre=
-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visi=
t <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1634?usp=3Demail">ch=
ange 1634</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1634?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div styl=
e=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:no=
ne"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Id: I0737b769e78e6d271ec874cadb9fbd81bfefdec1 </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Number: 1634 </div>
<div style=3D"display:none"> Ger=
rit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos=
 &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esour=
ceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: pla=
isthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Comment-Date: Mon, 22 Jun 2026 14:24:54 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-R=
eply-To: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html=
>
--UO7bQbXj2Xk=--


--===============5180812034116303304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5180812034116303304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5180812034116303304==--

