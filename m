Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F80C5516D
	for <openvpn-devel@archiver.kernel.org>; Thu, 30 Jul 2026 18:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+8KSvyYMIkOEtGNZdWTpbr4D3KJ5UdGDyIwgmsE8OHI=; b=bW72dCAXeyxTW5LMq61DtTjjD3
	/xvnyXFbU76t8/+mGOeEzMagTZhXDkMXkVcc8vscpHii8yak7pf9ddMs2G3vM4EZXlZI1oy1ZFDts
	EZbAZ1qpmwn+a7IB8SedwbsqPCSQc4s/mSEm0JpQ/nfDle/SpU4bAzDHXuR/BswV6J4w=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wpVUB-0000QM-Ia;
	Thu, 30 Jul 2026 18:28:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wpVU2-0000Q2-Sq
 for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 18:27:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=EPjM0/r1m8nwF3yEiGDRbt6z8sP+O/53lcQ8zbi2Yxw=; b=hEBZLxWwuxw73JBwKKrXqOkOFZ
 RrN2gGblEYZkkAxkab38Q74uZoVJDoyuDFKenI26jv2eeQ/Zznx3OvQ6WTcfJY9+p7uEmlHY/CMxe
 OT1AoZ48m3J8OtTm519Entv1YBMLTQayCyToLJ/BT/6k4kf3eIT1gMrZMxeIz0pAVeUk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=EPjM0/r1m8nwF3yEiGDRbt6z8sP+O/53lcQ8zbi2Yxw=; b=M
 k+aTLPc++KeZRFJSovr0CFGMWjZ329AoL92jRNCKRPb2pq1qFk9H5PiPgRzHFBTvIYTFSeWjwwWzM
 8pW5c1mOAxMwq/mWbxq/thvZuTgB1Xb4gc1uAZLa04t0cpVxAhWIKfkDzAuXrJI7bsE77SPrCh/Dv
 KHIgofM6PXTWFOAw=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wpVTz-0003fm-30 for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 18:27:52 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-49545ba3d4eso11261075e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 30 Jul 2026 11:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785436064; x=1786040864; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EPjM0/r1m8nwF3yEiGDRbt6z8sP+O/53lcQ8zbi2Yxw=;
 b=hHlFEG59vfI2ICvkLGvesZRhH1oKRY0RrhxlUnJLAfAwP+h5E1JrCk3PEiH/mFQsFS
 Fg8PMHVWBFl0rXUIZyR+PQ6IIulKZPqCFo/GjFcBtVyMXxwNriYCBtkjH/Jsm9omJQAk
 Z3QSKDAbgB42GcMrrFLxx7kwk+R2/5w7/pGTGZ3DYr+OgZZNeGgCEbh0tq/pou0uOvbu
 W6YeECXPXolSqEN3hceoCALZqAxB3G5hkjpznv3Ex45I+XvMu+aQwdlgvrkxGffxjU8P
 5H98pCKiBPNgiLYW+Cb6t/VqNgnGjQjc5Ca+4JA29X84BS1HNryAxdQr/lyjvJZCYR7f
 vu2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785436064; x=1786040864;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EPjM0/r1m8nwF3yEiGDRbt6z8sP+O/53lcQ8zbi2Yxw=;
 b=RfnXVDyEUWfGEzvXUBitjAkla48ueAf45qb5RX/yQqzxHbs7ugfxIyT/MTlmG4OeQx
 OA199KAODWmaDLO6WFpTlE2RaIzqoNHaZKYbgNhPQdpdS+WgXh4rSr2qEI4d74hEaxq4
 aLnz2y9vdpjDBRXG6V4YVrZbY5eOYIt08EpUXjJ9QbKGWPMXz/avbRYVor+vgylT+4SJ
 /sb35J43GvHJCNpKsUdg3D/R1XWl2+idNIO9cg9DCWIcLXq32/B0qCGMbxhf4GssFsvw
 mB2unOWQ1eebyGe3jH/9TNerS1K2YAbYsIhnXcFj+xzCn4fchHECYNqO5hP7JN8j4rBI
 oH9A==
X-Gm-Message-State: AOJu0Yx6g21EFq1eeF1y8jpSt5dusBn+SZqkc1DlwiE0I+HuWi4sKYrB
 /tA3YfdDNyqmZUmlmwlEeEAXVJNGYp5WjrULmcjmoioWjl/+ZD8wZjjVIM7PKz8YyDJT+JY9tok
 gwaUj7mpjnL018leODrGHrFZEw0vtgnlQpP/hlJmgwKusXY8a0RsCskw3xkOD/FWk3iNT
X-Gm-Gg: AR+sD13u4iGtU6J1OamRk6jo8kQZ4CmyWkffS/ouCMzSOLWB8WdzQf/P1mQEYe7ohD6
 wpxLMPc9MndRTK8jjV90bSjoJjcAbYYpTdjqDiEyxNCIGEHXsNuJExnAYddGjcPZtb9TCskMyB0
 gHzwz0tfBTVvOaxL+g6EHgOl4hq+BjnZbV/z1DdK1jYEz3Csl8CHlidVKTZ6ANBiCp0QrTSm1cs
 Lz0doDAflCDMeQWwsqUP1pMSnaJs98HdluYQsStcxSIF/D6/giQV6vIS0wFvTdlFly/SoehAu/Z
 3+T3bBUvVeQ7CXonEDYGxFQQ/phfT0tV1O3lbd28MNIgHw2aQk2RGDcBXTahB0P24IM/2ZBwljZ
 lklS/+0qqI+rcXPxFW3OixNmAviPWFfRVCkvFzMyZ9Bti6PLeqAPFih0rwd57s4Eq1ogA+pfoHI
 fcvqs+L6w1oKzZnlXB4wMjKxPV8Rhj+1aEeBCx6nVcDgLzI6x2Xr0B5t1nHdGOvCjoJZPbyF+cS
 JhQQxwJfqFHP2JyONKvQcnDhGKxrCsJJ12UhAN7WvTJAvFtrm93FrfASkaCkKvhyX+iz0ondiHD
 969AOvA9IFiud9+bbkzvVqwA8uf7ERm1Y1Mw3aDYENPR+Tacmmw=
X-Received: by 2002:a05:600c:198d:b0:495:5e86:4e59 with SMTP id
 5b1f17b1804b1-49804c531ddmr23453115e9.22.1785436064410; 
 Thu, 30 Jul 2026 11:27:44 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-498011f2b45sm78506955e9.4.2026.07.30.11.27.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 11:27:44 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 30 Jul 2026 18:27:42 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 24
X-Gerrit-Change-Id: I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6
X-Gerrit-Change-Number: 1572
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1572?usp=email>
X-Gerrit-Commit: 6393c1aca225d825e4d2c21bd1d7bafe8790a251
X-Gerrit-Comment-Date: Thu, 30 Jul 2026 18:27:42 +0000
In-Reply-To: <gerrit.1773251317000.I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6@gerrit.openvpn.net>
References: <gerrit.1773251317000.I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjUxMzE3MDAwLkkwNWUyMGY4YzgyNDk0ZTRhYmY5NmZlMWUzYTczZTFjN2I5MTAxYWY2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b6e44cbd776eb7e213e327675ca1bb50d6f13af2-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wpVTz-0003fm-30
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add aws-lc siphash
 implementation
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
Content-Type: multipart/mixed; boundary="===============6048708133812400585=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6048708133812400585==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Of2aIeNNA5c="; charset=UTF-8

--Of2aIeNNA5c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1572?usp=3Demail )

Change subject: Add aws-lc siphash implementa=
tion
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 24: Code-Review+2

(1 comment)

File src/openvpn/siphash=2Eh:

http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1572/comment/840e5c22_91b66536?usp=3Demai=
l :
PS21, Line 57:     return 0;
> I removed the return type as we no longe=
r use OpenSSL and the other two implementation cannot fail a [=E2=80=A6]
Do=
ne



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1572?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerri=
t-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I05e20f8c82494e4=
abf96fe1e3a73e1c7b9101af6
Gerrit-Change-Number: 1572
Gerrit-PatchSet: 24
Ge=
rrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichte=
nheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lis=
ts=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Comment-Date: Thu, 30 Jul 2026 18:27:42 +0000
Gerrit-HasComm=
ents: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: plaisthos <arne-openv=
pn@rfc2549=2Eorg>
Comment-In-Reply-To: flichtenheld <frank@lichtenheld=2Eco=
m>

--Of2aIeNNA5c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 24:<span style=3D"bord=
er-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgrou=
nd-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1572?usp=3Demail">View Change</a></p><p>1 comment=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0;"><p>File src/openvpn/siphash=2Eh:</p><ul style=3D"list-style: non=
e; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/15=
72/comment/840e5c22_91b66536?usp=3Demail">Patch Set #21, Line 57:</a> <code=
 style=3D"font-family:monospace,monospace">    return 0;</code></p><p><bloc=
kquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10p=
x;">I removed the return type as we no longer use OpenSSL and the other two=
 implementation cannot fail a [=E2=80=A6]</blockquote></p><p class=3D"block=
s" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></u=
l></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1572?usp=3Demail">change 1572</a>=2E To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1572?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I05e20f8c82494e4abf96fe1e3a73e1c7b9101=
af6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1572 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 24 </div>
<div style=3D"displa=
y:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichte=
nheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-deve=
l &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 30 Jul 2026 18=
:27:42 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </=
div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=
=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichte=
nheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--Of2aIeNNA5c=--


--===============6048708133812400585==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6048708133812400585==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6048708133812400585==--

