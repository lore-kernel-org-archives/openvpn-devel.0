Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7171EC61DD3
	for <openvpn-devel@archiver.kernel.org>; Thu,  3 Sep 2026 14:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cWbvv8WUMNjgxcV3qMB3KRDRugSvoGBJYWT2dgj6ohI=; b=QOOYKvD17nZTaOKdsFxk2O/dYf
	8mELd64xXdwaiDVxWSKy/OMEjHt6xJCJmhP8b36VA87WHzlFDQ9mTaYqNfZQs674DId9TBzr4pN79
	YVu3mZH8SLSAtj41WjqM9zGeW48fvW5ObX8nOFqQFvE6xhuHrT4YxB1AMLkBgr7vevW4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x28RV-00061B-S7;
	Thu, 03 Sep 2026 14:29:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x28RU-000615-9E
 for openvpn-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 14:29:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ULcmfv7zG/pS+6Zf2gA4XCEN46XpRlp0gXCF7cIq3gA=; b=egx8WOqTTpqc7UOJ17mpcnB/iJ
 QLjYFkJvO8o+DxpyP+VtRjbrfJZc9LnrZKseyeYi7rZNceo9VWpkha0ctNFjlhi8JUiDnz+10CP73
 FNLyWKHM/FN3hszPNKAtZDOEcxAiurJWSBhYr6A7kaS8gXDymsMy+KPfbVWL73XBEoAo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ULcmfv7zG/pS+6Zf2gA4XCEN46XpRlp0gXCF7cIq3gA=; b=m
 r4MspbOATH5UInHu4MSftXnZxCvL6b+OTVMRa1WjkjscR0W0s3M2+mXyAwJU4P+0Vj+Q4tQ5AdaXP
 loYnB4dB3R5wTTAIaQyrQYbhm/AeNVs7QvVFFFOElAbzzM7iMoIfBq2pzLMUNa08ofg2JY4t00ngF
 2X7hBdaKpXbDcEAk=;
Received: from mail-lj1-f179.google.com ([209.85.208.179])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x28RP-0006Od-Tr for openvpn-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 14:29:25 +0000
Received: by mail-lj1-f179.google.com with SMTP id
 38308e7fff4ca-3a1f628b1d1so19616451fa.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 03 Sep 2026 07:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788445757; x=1789050557; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ULcmfv7zG/pS+6Zf2gA4XCEN46XpRlp0gXCF7cIq3gA=;
 b=ZfcxiASb3CRzU73VdaZ/ttDVL5oMX4MVKzjYvMt32v1RiJC+bnS233L3cXEre5+khu
 GC/fqfhk9Ytvtd8cKvxlUeg9pzdbW6ynJi670nq7F6CUb7tH2OKE9WSU/2ZpK6ArBGUn
 QAA8a079OHSYM5Bi+aTiwAooppP3z4O6UJ1/CEjKkF1sYS9siESnR6lJtUtN7wdrhdQl
 GnMXwkoajXnV2Mh1ffhQefehm+u3VULFSDzvx90l4L49ChuxlF/97ZxgD142uvQUhhIo
 MT6gYVwYvmhza4Yfth6kW19dJHQwksd74rZpxEukdVIZfLPZtgLqddcROuLeFNIB8Db5
 4Dhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788445757; x=1789050557;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ULcmfv7zG/pS+6Zf2gA4XCEN46XpRlp0gXCF7cIq3gA=;
 b=AW5Dhp+7qACp6QRhqdp4ZGXxurXgYeLEbKZy4TJJn2WGcYpgwcZX2W2RHHuFvo73XR
 eQLIFfxlLVYfmjA5fiIy75WWPPoX7N/hDjVBSKw3J/yN6RbCsUhwUH1nb2s2bj7pTHOG
 BPrlCEHiz/Gn4tkEE1MAEqGun7cGG7eUzq4XiP/uhU8EKiLligBW98sW4AcXKPxQ7c0c
 EpPgAwLOEn/g06GPU/XSkrmIPmClzhuGhy4iXD+A66bHzDb2Pl4FnggEV0u8TQTrBzs4
 O0V2L46SzZjDE7O3JdBTel4o4TC/99d3rXXwJbZU5FlIKCetLb585r02Jqpgm415cwBd
 +mUA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxTjIcOg9trmDaRylebc8cJ/nOkMW/AKB05tK7Omnkrm/rqPtVv55GjWQwFtcpe8slwntu3KGVfGSB6NDp9@lists.sourceforge.net
X-Gm-Message-State: AFuF++mEHjSecy6NoaCZnq5NzW7E/2anPx8nwE7CA6Ba8r0zSZKBXgYa
 atti6kjUb2eqwfwjjS+aBsXbLnwdBm+Li0t6Z6sgovwTPog2JkbFcOBCj+nRGfqQT2MVGFQ7kQW
 t4d6nGkKlMmghR63CPCL5H2JVU5R3jYFeVoQtDt0ECRP815Ev9z1TPlWeHt6hY+mMUdxgH5Mo5L
 Gq0X8Htw==
X-Gm-Gg: AYBFou2PbcvZGn0PFxYP698WFveqdOXeMPbbAGY5mSfWB4uk2NeRDTk3PMrYkCq+Z5V
 rB43uZWikCSFHM6O0pS7h1XsYV3SvR7fBCY7bGCETVzotdqqfvIR5ZbxJVyI38bJZhg1MJc5055
 NEWkLOdzhQTLazCDWp81fsk5hA7GESd1PAOvXfLCM8lvYKHva0bw1NtZ0X7MNgdq5rgEpg4Mwm8
 mhQ/uAunsNsCkQhsfctm44ZOFvGms7ofRDJXAARafsIw1uH9rbkWxkXlQ2Spk02C+eCGNJZcJKI
 2LmLDLKYJEVnRbg8TE+jzTFkSWVGa3/4a1aZZyHVneWIXJcbp3rbCV+kseUvSzTeanJDFjGcSI1
 h/Bpd/6vFvqVlAUXoRGKms7bWv+CSlcNbG0PN1MebxJbpYOH3UpX23CgK1judI30IZvRH75C+5Q
 d6NzsYiasXBFicZbr5qRYZTou5GmdpMVQv6Re7aNhuar3Us/ItaLyue5ukUbFgyNk+vD4x1iuz6
 mKb01REGbwOrBb3y0OnSA+fAexQs9xZIv1pOTidY5Sbftp/YbwWom0qyZEMQkAW1dBXZREfRL8m
 0z9HcLnWYLhKrT2ipAEp/c7ZQrsmEw1Rt+Ebh5+ba8J3S29mZZ0=
X-Received: by 2002:a05:600c:350c:b0:49c:f5c0:aa76 with SMTP id
 5b1f17b1804b1-49cf5c0ab40mr978665e9.5.1788444013952; 
 Thu, 03 Sep 2026 07:00:13 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e7f8f9sm14019435f8f.9.2026.09.03.07.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 07:00:13 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 3 Sep 2026 14:00:11 +0000
To: ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I72302403bddee4b0b0ee2441ae9e246f48d0bc81
X-Gerrit-Change-Number: 1734
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1734?usp=email>
X-Gerrit-Commit: 2902b94906e9b21e9288d9e43b24a3c6b5775e17
X-Gerrit-Comment-Date: Thu, 3 Sep 2026 14:00:11 +0000
In-Reply-To: <gerrit.1782545314000.I72302403bddee4b0b0ee2441ae9e246f48d0bc81@gerrit.openvpn.net>
References: <gerrit.1782545314000.I72302403bddee4b0b0ee2441ae9e246f48d0bc81@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNTQ1MzE0MDAwLkk3MjMwMjQwM2JkZGVlNGIwYjBlZTI0NDFhZTllMjQ2ZjQ4ZDBiYzgxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1d73bd8cfd1d94bdfa9c9698e32b6add40e26d90-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x28RP-0006Od-Tr
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Support pre-existing
 Linux DCO interfaces
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8830589055089421107=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8830589055089421107==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HQMLcXQRweA="; charset=UTF-8

--HQMLcXQRweA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici=2E

ordex has po=
sted comments on this change by ralf_lici=2E ( http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1734?usp=3Demail )

Change subject: Support pre-existing Linu=
x DCO interfaces
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 1:

(2 comments)

File src/openvpn/dco_linux=2Ec:

http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1734/comment/a605f1be_6b97fa8b?usp=3Demai=
l :
PS1, Line 516:     else if (ret =3D=3D -EEXIST)
else not needed=2E Prev=
ious branch has a return (easier on my brain too)


http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1734/comment/30d0fd8d_7f0291c2?usp=3Demail :
PS1, Line 5=
18:         const char *expected =3D tt->dco=2Eifmode =3D=3D OVPN_MODE_MP ?=
 "server" : "p2p";
move this only inside the if-block where we use it



--=
 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1734?usp=3Demail=

To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I72302403bddee4b0b0ee244=
1ae9e246f48d0bc81
Gerrit-Change-Number: 1734
Gerrit-PatchSet: 1
Gerrit-Owne=
r: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>
Gerrit-CC: ordex <antonio@mandelbit=2Ecom>
Gerrit-Attention: plais=
thos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: ralf_lici <ralf@mandelb=
it=2Ecom>
Gerrit-Comment-Date: Thu, 03 Sep 2026 14:00:11 +0000
Gerrit-HasCo=
mments: Yes
Gerrit-Has-Labels: No

--HQMLcXQRweA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici=2E </p>
<p><a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1734?usp=3Demail">View Change</a></p><p>2 c=
omments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin=
: 0; padding: 0;"><p>File src/openvpn/dco_linux=2Ec:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1734/comment/a605f1be_6b97fa8b?usp=3Demail">Patch Set #1, Line 516:<=
/a> <code style=3D"font-family:monospace,monospace">    else if (ret =3D=3D=
 -EEXIST)</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">else not needed=2E Previous branch has a return (easie=
r on my brain too)</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1734/comment/30d0fd8d_7f0291c2?usp=3Demail">Patch Set #1, Line 518=
:</a> <code style=3D"font-family:monospace,monospace">        const char *e=
xpected =3D tt-&gt;dco=2Eifmode =3D=3D OVPN_MODE_MP ? &quot;server&quot; : =
&quot;p2p&quot;;</code></p><p class=3D"blocks" style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">move this only inside the if-block where we use=
 it</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1734?usp=3Demail">change 1734</a>=2E To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1734?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ger=
rit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project=
: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
=
<div style=3D"display:none"> Gerrit-Change-Id: I72302403bddee4b0b0ee2441ae9=
e246f48d0bc81 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 173=
4 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=
=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"=
display:none"> Gerrit-CC: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lic=
i &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-C=
omment-Date: Thu, 03 Sep 2026 14:00:11 +0000 </div>
<div style=3D"display:n=
one"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Ha=
s-Labels: No </div>

</body></html>
--HQMLcXQRweA=--


--===============8830589055089421107==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8830589055089421107==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8830589055089421107==--

