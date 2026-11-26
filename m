Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4302A606A32E
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 15:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=TzT9sQff;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=HM5lQrEL;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=OKiJzVd0;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=RC8j3d/N
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=V1PSJ5culzNsgHdKRR5DYGQH9z++sF2z0df6opKsup4=; b=TzT9sQffUgnwXVgxNTdOFMJmTf
	JAJzQfux9fDdjKIujDcBEEevjFCO+wP3D3Fyv1UXhZNT47IqBpMhI0RSnlgTzF0JB7Uo8ceT1RJBj
	aGGKQi/iQubEPRfm4N2Db1rJaRjD7YlD8bmktUUPY8+Nq0/37cSI+Ny1YVNf74RU52ZE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWbUc-000000008MF-31Wd;
	Thu, 26 Nov 2026 15:34:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWbUb-000000008M9-13Nj
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 15:34:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ua7KKXctLDt2YLnwIN1Hy0vGT1Q/EfFgLpz/XiVKFQo=; b=HM5lQrEL33Cw1FUxugAMgqxDh/
 WNG7I/GsFI8EUzEjt2CSZkTwqqV3XIHXCPg96WTM0k9CoQtjqocPXyAvVDHkcvPk3e53POze2R04j
 jSz+LvRPbEH0zz5aSAus6Wp4rAZdpfQeKwq5eEagpqBbtwY2vTBxhupy4i4vVbuguDVQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ua7KKXctLDt2YLnwIN1Hy0vGT1Q/EfFgLpz/XiVKFQo=; b=OKiJzVd08VsVva2fDRycswrRw3
 5aXr2UmguPSc1vnWhG5BM3o9ISLO04slhA+247RBgLgkKNYRBfYx0NUGL5l6NPR7njGCr77Iu3UdH
 /c4gUpC4DTYMD0yWzqBvJ7b7NGQvvzducD0+83Yxf8Yv4+xaD0h6CrHPlTNH6BMPczfk=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWbUY-000000002yM-2Kwe for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 15:34:37 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4bb69f5b161so46442015e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 07:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795707268; x=1796312068; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Ua7KKXctLDt2YLnwIN1Hy0vGT1Q/EfFgLpz/XiVKFQo=;
 b=RC8j3d/N1SdE0vVau5HN+i9qosHR5K3eHLJzQDYUfjzIXk86T1EV8oHq2ujxoPWPV/
 8sxjt2I70GbNII+XPTzdUtJdm3Ww4xAAJfbbmUI58BPzegwp+pv11dVM2ZfFsxg93nWP
 SHlIRen5H9iHgJuk7oVDDPc78kODsqWPjTvt6FPwkM2K6lC/1bn3MW9ITHWsGkhFjeRb
 Sfi/Tw/sHCmUIcgEmtRr067HAVm8OM6dDkt2d8EPttS9Bxe8fr05nXFutKpWoHRl43OR
 5zSPW6deud33808BbVmnMaLqNdr0W4hIbVNhBfiXqIui/alFc+2Q1zmKWe2nGjbhbSor
 2tww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795707268; x=1796312068;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Ua7KKXctLDt2YLnwIN1Hy0vGT1Q/EfFgLpz/XiVKFQo=;
 b=y+rDb2kkZoYB40t5NXiFFCOGJf43vsEVSYsVSgqEg3578Grq8CNXfWPKZrBlYc+PPO
 tj9jhCVd7YT6ALqbBi5juMV/UzOf7jr6Ip99Od0/5z4BW7vVdzt8W+sIvFPnsZ2wobAN
 moCr9j+MFjPoy1k9mQlWWJ58Gz8daCTMUj9UV8O0ltsdLJLseUpV5hnbCgEK3yHcolDk
 OcLQltPM4/wLGD5OGLW1JES8oCJZ9hHM4fqa7SSjgffm0fblnmcIhbFD+p4KBorDt5xS
 za67APcFnDK5jkK2Hne46OhRMUPEBf4mXK5z1jeKwxUEdyj7ntBHiZiILBpEhyf7cTbq
 jMVg==
X-Forwarded-Encrypted: i=1;
 AL+hErFR/l5olLC5UcBqkYe+ZnbY65U6DzBvY+rKgMwrZsi/DN+9ZCdlmO22E90GOVZmTe1d6dYTXMvsibAX9b8g@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9+lPdUyJPg+UYGFXEVoztYTovk2tQYFaaLG+Jlftg4ecF5u1GQ
 /apjD1CeP1O9doDQvjLjDDgsziQls8iOJeLK2yaXl0gTTTuHwHWYb/SVRq8rpHTQXWLD/NhYgYA
 xIWQKAZdNcuVStgtkVfqUldVQDq7lbdp+Pxv8kziub8vdFWVzXxjWbMLt99WlXRLD0MvR
X-Gm-Gg: AZFdTZcDr/bAJY4NUCdDpc3Vf4gwbzdFmp1FfPvJN1ZHzuuMr3aD2oWFXQLtBYhJ/4Y
 KaTTbQGgFcJ5b4Cw4rSwlSv3yK0hmdTMafHzO6hZnNc1JDJcKb7sh2Dz/+WOTGQpAe5fmkVjATX
 0LnM5QT1f/gLTnv12BVDnN3TGGXsBF/vFFgI1kf7+H6GdfOSBcVCsgS4/BvxPKjqL1NFKqtXTX5
 O8jSIByJ/dDRAUt2RajlTEH67uz2WnIPwwUOVYkoNasOWGnNbhtfyslB5MlguhplmEEPXUenfXu
 ugja57IMZDD0BKtQdaxhsFPo+bKzuUikO142zWrjmycRK7JmLiwTmrhswzJDMuVITZOgKgq1dlC
 7tI6lOIHiVQJr1XsMkrjboXg2uUcKn3+2ZTYReGGqw9cFIdzbQgAu2l0d1ldnO5eR4xap8PLW7m
 3h73SEZygd9j2FVsqSTElKtms1OQQ6Axui+3Rb6AWVjOBirHgwHNOVrGE58YW8pkpJYsgQc9b0v
 QQCUkyZuRoelLcJ+R8mGKq4yRCMt/UG5vXOAK4eE1Jt246bDx/xEItKX+EMFDQjvvRqXvTrILyD
 q2GR+1vcYcTsoEzZaeBP4Eq8z2A/7aKMCl+zk/Ge8qv4cVG5y9DhI61Z6vuXeGHkrWkAMZbLd1u
 xw/0qxQCQ3eu394IHVWr1ixjudaUrmA+6+6Ju3oNUvIr79Qvc2POkpat8y+AYAV3it9SufP7Nmo
 v7IOiF+Diqs5C5HsrYbvgAGg89ElLrla4KFlGQ
X-Received: by 2002:a05:600c:4e16:b0:4bb:6f77:1e35 with SMTP id
 5b1f17b1804b1-4bb88810991mr461088755e9.21.1795707267797; 
 Thu, 26 Nov 2026 07:34:27 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb90655f5asm391676805e9.1.2026.11.26.07.34.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 07:34:27 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 15:34:25 +0000
To: Aravind O R <aravindor@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2
X-Gerrit-Change-Number: 2213
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2213?usp=email>
X-Gerrit-Commit: 28db47113dd19df5188c5f995d49c648e2c54c0a
X-Gerrit-Comment-Date: Thu, 26 Nov 2026 15:34:25 +0000
In-Reply-To: <gerrit.1794933726000.I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2@gerrit.openvpn.net>
References: <gerrit.1794933726000.I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTMzNzI2MDAwLkk4ZmUyY2JlYWRkZTNiYWQyMTg1YzRjZWU4MjRlZDJmZTMwN2UyOWUyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fc03c276bccfe0324f68f58a1977203ff5720911-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWbUY-000000002yM-2Kwe
Subject: [Openvpn-devel] [M] Change in openvpn[master]: configure: add
 compiler and linker hardening flags
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, aravindor@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4542451412231126983=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4542451412231126983==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wheHQRyHHE0="; charset=UTF-8

--wheHQRyHHE0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Aravind O R, Arne Schwabe=2E

Frank L=
ichtenheld has posted comments on this change by Aravind O R=2E ( https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2213?usp=3Demail )

Change subject: confi=
gure: add compiler and linker hardening flags
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Build-Request+1


-- 
To v=
iew, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2213?usp=3Demail
To u=
nsubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: o=
penvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8fe2cbeadde3bad2185c4cee824=
ed2fe307e29e2
Gerrit-Change-Number: 2213
Gerrit-PatchSet: 2
Gerrit-Owner: A=
ravind O R <aravindor@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2E=
com>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Ger=
rit-Attention: Aravind O R <aravindor@gmail=2Ecom>
Gerrit-Attention: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Thu, 26 Nov 2026 1=
5:34:25 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--wheHQRyHHE0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Aravind O R, Arne Schwabe=2E </p>
<p>Frank Lichtenhel=
d has posted comments on this change by Aravind O R=2E</p><p>Patch set 2:<s=
pan style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padd=
ing: 4px;background-color: #d4ffd4;">Build-Request +1</span></p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2213?usp=3Demail">View Chang=
e</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2213?usp=3Demail">ch=
ange 2213</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2213=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2213 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Aravind =
O R &lt;aravindor@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenhe=
ld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &=
lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: Aravind O R &lt;aravindor@gmail=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date=
: Thu, 26 Nov 2026 15:34:25 +0000 </div>
<div style=3D"display:none"> Gerri=
t-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Ye=
s </div>

</body></html>
--wheHQRyHHE0=--


--===============4542451412231126983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4542451412231126983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4542451412231126983==--

