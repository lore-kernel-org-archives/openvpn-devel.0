Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A064C9830E
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 15:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Cn1o0TldWx1c5Ta24vTEVpc9JsCfix47XeoEuA960GY=; b=fcck+esXajow/NJ7D2k3yl2z2z
	qWt0+NNug1MzGwx25U9XMC4TvjZvY9agvZQOfvEPMNeijL4zE1FJ8ZSpbLbkwMMUXddm7HX8f1LmU
	LRTJ0jovCZ49+Q+9AVWVheTVZlqe/JR3b1e+13sigJQME440Cu4Q/0mZDtAyz3VpVR3A=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xA7w1-0002CK-Aw;
	Fri, 25 Sep 2026 15:34:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xA7vu-0002Bx-BU
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 15:33:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=bYM6ZFlfIZaBuEiWH35OZ41ba/woJ0pw09A1QUda7WU=; b=EM9zvy03413TKQqve8wHbbhW0H
 4rPtIe/zPJ7p+XLsbzuBPlzv5IeXtXOMaMxsQpkF9+ZXQqFGguZmPEl6wbhbDP0D86L74w6yyH04X
 dvHG7MHRoviVbORXPrmUXchZDO1k9UFM1MhOLjhbunstaZ+gMsbtG2iK5CKJvDedF5bA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=bYM6ZFlfIZaBuEiWH35OZ41ba/woJ0pw09A1QUda7WU=; b=f
 IE9NzqSU8L3Bt82uoNZNk2kxZBy30CfDlRgEfpGeF7C7TN9xEMTSXGrejuJn5HwxmM/8spQ7rlJYn
 JzLuxetsRQ+kRkeR2QkEQTXZznera9o86ouXtK8eNRe0XJKnG8MtjxgiaqBng5+D8bvK41Gao6hnP
 1FEB7mlPsNHR2q54=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xA7vs-0000QZ-F1 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 15:33:55 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49b912e64ccso7366375e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 25 Sep 2026 08:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790350426; x=1790955226; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bYM6ZFlfIZaBuEiWH35OZ41ba/woJ0pw09A1QUda7WU=;
 b=GmA3ib3nrtt5adsv87gqT3cLvJY9Hz7EcV1MPDn8yinXVccLDRbC6k8w1Ro2LrW+/m
 fw5jQUD6YgPbFcWqo2m3Mgs++lZ+dsu8IiQfv7toayNjez3pG3OgWqAdtRwqlv0En7N0
 0bicEJGpjmoo0EGmeDiKQ8RjYKSgJ9a8u8g1fjQTV1sf76kfj8RSXe0S6zhea7LZJRPu
 Woldc/IXxf8FoGqQ5jondSfqEVEqsb2LRsSDnBhS56e6WnhZmi0P35Xup70796fBpI9R
 Rl2VFr7dk5AYtj2tDCgVornArnM5l8YCaZ7Rj3vXgP5LUUVK4hEMKdNxoZieKnY16tHQ
 jkXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790350426; x=1790955226;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bYM6ZFlfIZaBuEiWH35OZ41ba/woJ0pw09A1QUda7WU=;
 b=kLx+DZAIl+ygkVigYioFSaJP2k7P72BM5yKd1p/hN2xbaA2PZ3t8eX+/vqaT+NlgQH
 heqJ+mtDnj5YcTltAYDg+4eBExl/RIbx0LGHJysYJFBviDTivhSnMbPekL5w0psrRf9F
 eSCuR+0ugPgMON09XzGX0zDX05E4wANi5IY+kB4KOTZeKeX8sJIRnQQD2dy+HUs2y13o
 U/kUfRpZ/ViOGivT7Bns7+XKAIZhFdH6v+sHNSalI86v1HzSaw9chavpjQUxA6uDr54s
 BWTneid5s8fG39xEjg7U5dOZ2Qa3/QhLP1ucpFgY0kyHHpBnL2VOXTusi3Ci6nWqRfNN
 IcqQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxnfgb6OhFywCiBImSoGK+cA2iVhlr5/FDoMHh+N24FHpTZ5EazHalZNbbMEnqmvTxhTBI6lzPNNcY+s5at@lists.sourceforge.net
X-Gm-Message-State: AFuF++kiYsJrnolP36HsSWrhQR4ObrjzLe8LT/0Ve2zOTodQEslwzAAw
 xF+Xgx6GWL7pbVrsx4JFa2+2B7BhP2qcwTfCp9Qpx7gkuDctMNr3SQHyc3Y+N66GQjyc5peNcJ3
 ezqUW3Glc1Xg06zvpRAHHWCXVvIvvHkcl4bw5XG8NH4djCYrj09EgJAsELk1CQImu2oHA
X-Gm-Gg: AYBFou1fRxRmUvS5xiLYNWOvT0zxKiqKIvkDDEMVK77sDGIEth/cZQH7+1VskaBw7Ka
 2cii5sMmZ/QEHoZQtJtfW4orp7K3Ct5wYT7OlZOi1eER/Y1zXpZhigodMvqkDhHOYIWK7jOkpAk
 /muugvKS+8osLaDJor8o+DG3GciiJzgvhEK4g4+0/xgWJQ6gfWi3F3U9EUoHHis1I+1fSStZ2/Q
 2Av0851Af/6qvX+lbqafs0vK0v9gGxXticP3rBrJlnZ0Rrj4sui5jLAWs/L2jD6Y/tSWvQiJUBy
 hacYGmUZEjDNiMVJMSQrhHGPsKfAWbI/vXhJNBY7gbalMXTQFARnhQSl2NgmIF893MGdS75L6mW
 w9xNehmIDNdJdwSq2U629JqqqOgFwU5VgnDBr3oR7gGjij2BlywZdE/V1v78y/9cisDSKX2bic1
 xsSahCQDHlv71HZqtvrHv7aQB9cPd+L5cNWjf7JqJuIUAaxe7Eod9/s/a1LuaxgBjyLzC0Dt8Ww
 JGEhuwfxpuJY2QTm9SYyHWeZA8HCT+xSjVPtvobANqIwfRKLdYF9F9qTWBOBPJSuqKY+oTkO+to
 VTolbaTjufu7zBQjlMX5y0Nf3oj4N9jL7wBa4I8e3Td2tAX0NLd/X8a+Z4D8
X-Received: by 2002:a05:600c:8b8b:b0:49c:f512:2361 with SMTP id
 5b1f17b1804b1-49fe66d470emr114432075e9.14.1790350425682; 
 Fri, 25 Sep 2026 08:33:45 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a64f9bcsm7988965f8f.32.2026.09.25.08.33.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 08:33:45 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 25 Sep 2026 15:33:44 +0000
To: ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ic535bb1f0da1739f87e9d6bef6fd1061247b05de
X-Gerrit-Change-Number: 1952
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1952?usp=email>
X-Gerrit-Commit: 62781dc17328af91c589e6aa2b3c276188e2383a
X-Gerrit-Comment-Date: Fri, 25 Sep 2026 15:33:44 +0000
In-Reply-To: <gerrit.1790344336000.Ic535bb1f0da1739f87e9d6bef6fd1061247b05de@gerrit.openvpn.net>
References: <gerrit.1790344336000.Ic535bb1f0da1739f87e9d6bef6fd1061247b05de@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMzQ0MzM2MDAwLkljNTM1YmIxZjBkYTE3MzlmODdlOWQ2YmVmNmZkMTA2MTI0N2IwNWRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <04ac50b36dddbb8c3e886cd6e3b319d86a8b4e44-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xA7vs-0000QZ-F1
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco: stop fetching
 peer stats during client disconnect
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, antonio@mandelbit.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5967175698343351800=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5967175698343351800==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5lCrjSX/vgA="; charset=UTF-8

--5lCrjSX/vgA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex, plaisthos, ralf_lici=2E

razva=
nc has posted comments on this change by ralf_lici=2E ( http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1952?usp=3Demail )

Change subject: dco: stop fetchi=
ng peer stats during client disconnect
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2

(1 comment)

Patchse=
t:

PS2: 
LGTM!



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1952?usp=3Demail
To unsubscribe, or for help writing mail filters, vis=
it http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic5=
35bb1f0da1739f87e9d6bef6fd1061247b05de
Gerrit-Change-Number: 1952
Gerrit-Pa=
tchSet: 2
Gerrit-Owner: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Reviewer: o=
rdex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: ope=
nvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: ralf=
_lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: ordex <antonio@mandelbit=2Ec=
om>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment=
-Date: Fri, 25 Sep 2026 15:33:44 +0000
Gerrit-HasComments: Yes
Gerrit-Has-L=
abels: Yes

--5lCrjSX/vgA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex, plaisthos, ralf_lici=2E </p>
<p>razvanc has po=
sted comments on this change by ralf_lici=2E</p><p>Patch set 2:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1952?usp=3Demail">View Change</a></p><p>1=
 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margi=
n: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom=
: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1952?tab=3Dcom=
ments&amp;usp=3Demail">Patch Set #2:</a> </p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">LGTM!</p></li></ul></li></ul>=
<p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1952=
?usp=3Demail">change 1952</a>=2E To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1952?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Ic535bb1f0da1739f87e9d6bef6fd1061247b05de </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1952 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;ra=
zvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: open=
vpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@ma=
ndelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: pla=
isthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Comment-Date: Fri, 25 Sep 2026 15:33:44 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: Yes </div>

</body></html>
--5lCrjSX/vgA=--


--===============5967175698343351800==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5967175698343351800==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5967175698343351800==--

