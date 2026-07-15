Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 381ABC44508
	for <openvpn-devel@archiver.kernel.org>; Wed, 15 Jul 2026 16:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UI12gzPRXsLC2q8tQ5s13vFYKwkexg9veTJxlyvOxYc=; b=BrdK1h6qZIP0Zd4o6i3VbBiien
	d4iJGEP7tJK8WExW5BwCXfPd37EWPoIqU61g8lmfeXwXyHIG/3emkjucvv+PTVTzNMlzQkHMebIhY
	DKvm6nXq5GTws7Gu6qM/VZhfLNgt70vxD4wcfrlGhFGvDMOmtvGRwnOiOIUeDE+tb9EM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wk2Dh-00021p-Ef;
	Wed, 15 Jul 2026 16:12:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wk2Dg-00021f-9U
 for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 16:12:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=C4XEFmBYDFCyKcjOyTQS3fvyZerP6f0zWhEFLUYZoB0=; b=Gc0zTBy1WVCgbGuYKOIOrh3KoV
 1is93YVebiU/TYKLozBnmRJ+vlILiXiv66pfW0eDe0Wfn1167JMezx2d+7USCUw+Te0sRiEPDcw/2
 NmIGQV5RMaM/yKBoTjSIoXqMtZQeZg7/sECGEnCU5qq9clHl3mkyIQQvIhUQNEcJd3rw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=C4XEFmBYDFCyKcjOyTQS3fvyZerP6f0zWhEFLUYZoB0=; b=l
 xB3zIygSAg2fUamCSRMPXi707h2uC+5BrJR+TePsm07KDd//IxtwBNDn8gZrngUaQbutGWH8QUEmm
 ToPPfEOhuhjFiD7XvCeLzhp2Pnrcy/lYb73GWqjR6nlJ6cF0GOKKT/zoD51jMXPmbt1izM745mYWP
 OqFO0+S04QGjfnLI=;
Received: from mail-lj1-f172.google.com ([209.85.208.172])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wk2Df-0002ht-Fp for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 16:12:25 +0000
Received: by mail-lj1-f172.google.com with SMTP id
 38308e7fff4ca-39d4c864bfbso26191931fa.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 15 Jul 2026 09:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784131937; x=1784736737; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=C4XEFmBYDFCyKcjOyTQS3fvyZerP6f0zWhEFLUYZoB0=;
 b=FY2paZ1TcsKb93k4cG8X94EUQ+vseQGu4a3AJox1EKRrgT0aCv+9DLmC5rBAeU5IZn
 OXDzx/skOYw/Iv4oeW1BGtx5jtwl45uX9wfRuBY62j72Sm/zDgop2JKPvldyPGCRBPS1
 yE7HB2BcsylDnBEIBJm16vBoPLAfdM4gGfsyvtQ4uCIPJlYoU04ER6mkqV0UjhOnwlbo
 5xUK2pUBrkodUrk1CB+hCE0RVu4G6UnRJ3DgC7x+yKC0axAqpi7Xth1d3z9rZVqI1Q9P
 7mbOrBBmI6u0M4Ka6JAVEJB01OrT+Dm7WhGe9hAqPs3qJm7c2H1d/lrcZEpNxk1Ki4A9
 EwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784131937; x=1784736737;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=C4XEFmBYDFCyKcjOyTQS3fvyZerP6f0zWhEFLUYZoB0=;
 b=P7gJxLOtmXx81qzQqOuKn3pQLd7I7ZNAgEEBL//OEGz6AYac0TV7Vr6p5/+Vt+rASC
 yl5zMXhrxjAG/vipjxkXzE/Bag25W4mFzNybnUM7YIyTtP2VNl93v7eCzMl00U8L82w8
 lLyNeJb5zZ9FentGYPR0buPWSSxTWpAlDY/zUE4b44lNddYo+AS5iYPqumqwZoSD+HU3
 EZubJEoxAS1seu0FFiOomjzDqAeHscqEuP7HPoJOoks4XbwqUV6PJv79mXFyupTAGPsv
 V/AsCFJfzLi64BYzF4SYYI1d4WiKTvBt7fumKhd2WPaFbanI6qLT0ZjX3wxtsAnh7KgC
 bpOg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrpsoLwTuDOsKRWaQSga61Xbi4X4ME1ka8SiTOvJY3Qu0kvJERjhj9b76YfYx5GPQoQEdnTd63w1xFKZQwA@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwmJfhm51LpA/57jUdn89mjGcBul+h1rXcxYG2hWNBlg+2d5/ik
 3Ku4TcgqAnvlj5sjd7Smc3ggL0LHjg98wx7+RESnxaVCr9KIMls7jr7BuTs1jJ6g5khyUFxWofU
 /UqCtMZZ1/AVDTDY0wFwFoDecY1TitfVlMPULxoB3JgrKn/NkHAr23KiCtzQ1OZmRc6CEcEYpIG
 6MaMmCuA==
X-Gm-Gg: AfdE7cmsKpiPtB/Jngr/VXyHEaGD3eB3SxO0xdqCk4o/dFnclpjsmLN29yY+YRJ1Q27
 fq1kzH5WNlk3t59GzGVQSx5kWhTEoUPTNmbeQRE58VMaICNHQmChNIJx3ljwPloHtAF6sT+WRM+
 hGtWiaIt+XYx5wWx93FFTAhqE8yARVhhuoTOtswJ+16lC/mHOA/sLbHo80JIe4XCodg4/eOGgiL
 rd+k6sAy+YdhCj1eXhkdFHOwav5KiohTwnLqqYnrwLPHsZtDbFwiSSvI2vQ3c1sL5opckU3z1pl
 nA+RQaiB5R7pMnAsD/FUsfJYptE3CxoqEMQAGcSi4owC2I4vvkmVJjpvND5+6839rvc6rp1MOKj
 HZSQ2ZvWSLUPZSeaQ+Zc7pfWk48i3mzj4w/V3kGEZxfn+R7OpUSJWEH51ZCNDewrhXTtPOl/VTJ
 f+PmGDuYtq0iRgySwOGV2peTqsmr1AAm7UARy5KPBpaqeScBC2nFkxGF4IZDWWa7qAJGoM38h/E
 csu3BEnhl6RNKVzHAgo7q4AilLvrCaksCwiK8bu27OqsTQ/4ZySzpawMcsITt4CCIjSGaWQ3JsG
 /sJ9IeF+t6Efiw==
X-Received: by 2002:a05:600c:45c3:b0:495:3e08:ad19 with SMTP id
 5b1f17b1804b1-4953e08adb6mr17987065e9.9.1784117938669; 
 Wed, 15 Jul 2026 05:18:58 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4953c599049sm43801355e9.0.2026.07.15.05.18.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 05:18:57 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 15 Jul 2026 12:18:56 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I8e9923b51b77f184c7d49d697004cb02d2b5cfc3
X-Gerrit-Change-Number: 1726
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1726?usp=email>
X-Gerrit-Commit: d501861ad4ca12f7c402c999e914430ee48fc480
X-Gerrit-Comment-Date: Wed, 15 Jul 2026 12:18:56 +0000
In-Reply-To: <gerrit.1782134588000.I8e9923b51b77f184c7d49d697004cb02d2b5cfc3@gerrit.openvpn.net>
References: <gerrit.1782134588000.I8e9923b51b77f184c7d49d697004cb02d2b5cfc3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkk4ZTk5MjNiNTFiNzdmMTg0YzdkNDlkNjk3MDA0Y2IwMmQyYjVjZmMzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d2f1c5db536a88f698dfb2a6314499a48c198d64-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wk2Df-0002ht-Fp
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Split
 multi_get_create_instance_udp into data and control parts
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
Content-Type: multipart/mixed; boundary="===============6408212316399953507=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6408212316399953507==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4JVF8+10MFs="; charset=UTF-8

--4JVF8+10MFs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1726?usp=3Demail )

Change subject: Split multi_get_create_instan=
ce_udp into data and control parts
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 5:

(1 comment)

File src/openvpn/mudp=2E=
c:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1726/comment/203660ce_40aeaa0=
f?usp=3Demail :
PS4, Line 364:     if (!mroute_extract_openvpn_sockaddr(&re=
al, &m->top=2Ec2=2Efrom=2Edest, true) || m->top=2Ec2=2Ebuf=2Elen =3D=3D 0)
=
> Yes I overlooked that || m->top=2Ec2=2Ebuf=2Elen =3D=3D 0) part during re=
factor being critical=2E  [=E2=80=A6]
Done



-- 
To view, visit http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1726?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: m=
aster
Gerrit-Change-Id: I8e9923b51b77f184c7d49d697004cb02d2b5cfc3
Gerrit-Ch=
ange-Number: 1726
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerr=
it-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atten=
tion: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Wed, 15 J=
ul 2026 12:18:56 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Commen=
t-In-Reply-To: plaisthos <arne-openvpn@rfc2549=2Eorg>
Comment-In-Reply-To: =
flichtenheld <frank@lichtenheld=2Ecom>

--4JVF8+10MFs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1726?usp=3Demail">View Change</a></p><p>1 comment:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0;"><p>File src/openvpn/mudp=2Ec:</p><ul style=3D"list-style: none; pa=
dding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1726/co=
mment/203660ce_40aeaa0f?usp=3Demail">Patch Set #4, Line 364:</a> <code styl=
e=3D"font-family:monospace,monospace">    if (!mroute_extract_openvpn_socka=
ddr(&amp;real, &amp;m-&gt;top=2Ec2=2Efrom=2Edest, true) || m-&gt;top=2Ec2=
=2Ebuf=2Elen =3D=3D 0)</code></p><p><blockquote style=3D"border-left: 1px s=
olid #aaa; margin: 10px 0; padding: 0 10px;">Yes I overlooked that || m-&gt=
;top=2Ec2=2Ebuf=2Elen =3D=3D 0) part during refactor being critical=2E  [=
=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visit <=
a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1726?usp=3Demail">chang=
e 1726</a>=2E To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1726?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I8e9923b51b77f184c7d49d697004cb02d2b5cfc3 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1726 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flic=
htenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Comment-Date: Wed, 15 Jul 2026 12:18:56 +0000 </div>
<div style=3D=
"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none">=
 Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply=
-To: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Comment-In-Reply-To: flichtenheld &lt;frank@lichtenheld=2Ecom&gt=
; </div>

</body></html>
--4JVF8+10MFs=--


--===============6408212316399953507==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6408212316399953507==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6408212316399953507==--

