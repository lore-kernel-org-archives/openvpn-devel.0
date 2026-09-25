Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC3DFC9830D
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 09:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qw0CoE5cVA28b/TeY0Mb7qAhz9kIiGzQ/Jy6G4KvJtA=; b=lwHoKKfJySHQ/4ms9kmGMzn+IA
	CWt8Pe5dzsge3LyVx/MxEO31ycCIJWpfNP+GccyD6ZIN5bChkL3XTmD0Q3jPTHYlWKpDL8JBWPXT5
	bA3SmVKDU4JKyGrg74dDABOOqM9K5Jpanv7O+LH/y4xAgHDMPypMM3KOG4oy6xlOPbJY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xA2T7-0003LD-Ee;
	Fri, 25 Sep 2026 09:43:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xA2T5-0003L5-UY
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 09:43:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Hl+doYRbVyvTkE0AfV8VgrnlJHprrKV5shPYZe75+0w=; b=eyEgAmSkcY1FYKBxnz6ptfH7kd
 qD2kVtTTl+DqgeH8zNARbErWFTmFwB0ePV9fQmW8QTorpMx33cG9ONz1uSYgkLU3POghN8qBH+SJs
 VZ9Auh6oPAGwm96FfgJeyMV/tqMcxHYAOa68cBqq0+bFpsR4pazaPoyJMKCl6r21bKSI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Hl+doYRbVyvTkE0AfV8VgrnlJHprrKV5shPYZe75+0w=; b=P
 Kk+ypj0kVrWQJWOzFrXla7Q1TkwTewG1W2VgwUr62AQURNIqTekIvvHX/wb04QmawVp7lcz/vfjAq
 V4ik/gbtiycZmB3wAxTZIs5yVSd+cxUcOCImyyXBU4E7iwuHGrElRf2xlHFH2+CpawV0PeU6K8BcU
 xVBLYnBGLTXMIuTI=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xA2T1-0003Md-Rl for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 09:43:45 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48586861639so331761f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 25 Sep 2026 02:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790329417; x=1790934217; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Hl+doYRbVyvTkE0AfV8VgrnlJHprrKV5shPYZe75+0w=;
 b=A6Fn9BYJB1pd8HVwxOAi/Xp/4A760P3d6kuFPwhA2QNHWB+kK08pj24qHf7TlAdIhC
 A80tgHqlNhMxgV/neIePfagJ55zjXStvPwC7WDguljx3WJ3LebOuWL+9dJk84obz2zQC
 jvDn+AEKz52gniRzCjX1pY9WZCRF+kbQvNM0Q09zJgTMMJ/jnhYug6LAK8g404nfhxpq
 sBmNvEDd7QRoDmIkMp8CxEJSI77xqB7qG4QXIGKK/UysZOaxeNbrMVBY7MN6kCMpQ2zP
 BE95ZzPG54/cqgcAAyUXzr3emfg/J2q7V9UctuQG3aJmXI7Tc50vshG60wFHKPxjdhfk
 /N3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790329417; x=1790934217;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Hl+doYRbVyvTkE0AfV8VgrnlJHprrKV5shPYZe75+0w=;
 b=zaKFYJpEWZKfp1COMffdlOm6mnggIUYhO3Dm4iSKQIp6P0e2XpiD+2t8x8JM3FI4q/
 79yKneS/OLR85DZOyPM0Bmq80jjmroLXItYCysm3G1QoU0VfBpb1WUFK52qTJRbOtgOM
 CFrnpdHB7NXEmQQ7r1sJeMLkN6l1UrWGEZmYlqizZtn4roOcy2WiP0b7SZKTM3qCO94M
 ISVNW+lqdKWGbIocW4zS4u4NZ58bPkOg6HuZuLLqR9aEzgVYFD3w+fnDT8mUlPTjRjDY
 suGOXRqQP+9iZdmM4A9N/BrFNMvnWiO/otbv2XRgvc+BcfkCG/4hTDCzbcr1955Zd0OY
 LW2w==
X-Forwarded-Encrypted: i=1;
 AKwUvBx2TU+qKOIkYT3XrhBGeh2wTpPS8qpVxR59e1BSf8YCIF6aAjppAPbi7US3BIEkkN3ZQXjyLQaWG19U3pze@lists.sourceforge.net
X-Gm-Message-State: AFuF++nOq6v+qt/xrFlfhW8/DofP/edXlXODUFzIHON3leyNegzUE5YR
 m0M8nJ70Dj93UzFO7d6ua9+gQcQYA0ZXTdVgDIFRigUn1ZPI+0aX5mDOBLqMsqyEXY20IkjDotp
 /za0qa4ngZ4AIhINNoU6riHDNKApDCs5QZ3PIPD6S2bOtgoaBNo/NjYrNYM/enJexsBFsbGEP8s
 19w7AinA==
X-Gm-Gg: AYBFou3NLlDy8raFOPH+0gRqq+axVFEwRWfcq63lb1TwRJBOmbX05nYHoQjnTEL3Zlv
 JXd0yWcAZvuvIlsVsqX1zeGwcEFO6OcJqe4tF80JTp7oo+KG0m5gW+cvjG1/4r885AWebidsYVb
 C6O7Zhvi+/bVj38bPalEd5beQqgIHHsSvNKXgaEaGnysqpH2QfAXoJJY3HUroAiv0jdrW2Y08Wd
 Q9QWmEiUwCGj2eytXT7aezAM0KOMVvB27xfHPNAtfJqMC1uf67RDdU83pOZBLxbXvKt1+z53u/K
 GkVHoZZwz9CSMJPZ42gSZ0xU0hpToMuOavnVtZNpsmo2+ya+Vk2jb/WYDqzNUvpXovzMDGNwZl/
 w2nozD0Yo3hl+uWePxZ6bxuQtcY3PK2ClyIRI/QN/9spiy8nqpKuNN4lVRPToIF3w2ht4PWFz1F
 1LbxkCoALGu/BN/bv7EPctp9OgTPH6JWGpI0F/SOQ+9ZtWvY+LDr7TWAWCblVZ5RpRbW4MVRMdA
 zMXj9K37DwqVz6Xn5KnR2/jGYaux3DsICZMvPnCQQ86XoH2n/3TWWJbqaZgTlgzX5zC7bdxUERO
 lNdliWccfPzgcyvchhumg1lscz+TuP4qRGpFxoTAu6sDKAY64RXeR7cfgUF+
X-Received: by 2002:a05:6000:4919:b0:488:7f61:de0e with SMTP id
 ffacd0b85a97d-4887f61de7dmr2494299f8f.21.1790329415144; 
 Fri, 25 Sep 2026 02:43:35 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a84221bsm5851420f8f.36.2026.09.25.02.43.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 02:43:34 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 25 Sep 2026 09:43:31 +0000
To: chugly <charlie.vigue@openvpn.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I9085c55a7efefd31839b00ec8ec9a6f085574dde
X-Gerrit-Change-Number: 1946
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1946?usp=email>
X-Gerrit-Commit: b5a04e7484242f1d3ac861ce929773c19fd58732
X-Gerrit-Comment-Date: Fri, 25 Sep 2026 09:43:31 +0000
In-Reply-To: <gerrit.1790212215000.I9085c55a7efefd31839b00ec8ec9a6f085574dde@gerrit.openvpn.net>
References: <gerrit.1790212215000.I9085c55a7efefd31839b00ec8ec9a6f085574dde@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMjEyMjE1MDAwLkk5MDg1YzU1YTdlZmVmZDMxODM5YjAwZWM4ZWM5YTZmMDg1NTc0ZGRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0391f8d70069898849ce0e789119af3c8bbe157a-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xA2T1-0003Md-Rl
Subject: [Openvpn-devel] [L] Change in openvpn[master]: tests: add a unit
 test driver for route.c
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
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, charlie.vigue@openvpn.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0364291822490942052=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0364291822490942052==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8PtfkF300VQ="; charset=UTF-8

--8PtfkF300VQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: chugly, razvanc=2E

plaisthos has pos=
ted comments on this change by chugly=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1946?usp=3Demail )

Change subject: tests: add a unit test driver=
 for route=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 2: Code-Review-1

(1 comment)

File CMakeLists=2Etxt:

http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946/comment/18d068a0_27a7fd53?usp=3Dema=
il :
PS2, Line 912:     if (TARGET test_route)
Instead adding a completely =
new test driver that only has three tests could you just add the new test_r=
oute=2Ec to the test_networking target? 

test_misc already does this with =
test_schedule if you need an example=2E



-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: I9085c55a7efefd31839b00ec8ec9a6f085574dde
Gerrit-Chang=
e-Number: 1946
Gerrit-PatchSet: 2
Gerrit-Owner: chugly <charlie=2Evigue@ope=
nvpn=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn=
-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: chugly <charlie=2Evigue=
@openvpn=2Ecom>
Gerrit-Attention: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Co=
mment-Date: Fri, 25 Sep 2026 09:43:31 +0000
Gerrit-HasComments: Yes
Gerrit-=
Has-Labels: Yes

--8PtfkF300VQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: chugly, razvanc=2E </p>
<p>plaisthos has posted comme=
nts on this change by chugly=2E</p><p>Patch set 2:<span style=3D"border-rad=
ius: 3px; display: inline-block; margin: 0 2px; padding: 4px;background-col=
or: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1946?usp=3Demail">View Change</a></p><p>1 comment:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0;"><p>File CMakeLists=2Etxt:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom:=
 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946/comment/18=
d068a0_27a7fd53?usp=3Demail">Patch Set #2, Line 912:</a> <code style=3D"fon=
t-family:monospace,monospace">    if (TARGET test_route)</code></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Instead=
 adding a completely new test driver that only has three tests could you ju=
st add the new test_route=2Ec to the test_networking target? </p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">test_mi=
sc already does this with test_schedule if you need an example=2E</p></li><=
/ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1946?usp=3Demail">change 1946</a>=2E To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1946?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I9085c55a7efefd31839b00ec8ec9a6f085574=
dde </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1946 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display=
:none"> Gerrit-Owner: chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc=
 &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: chugly &lt;charlie=2Evigue@open=
vpn=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: razvanc=
 &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
omment-Date: Fri, 25 Sep 2026 09:43:31 +0000 </div>
<div style=3D"display:n=
one"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Ha=
s-Labels: Yes </div>

</body></html>
--8PtfkF300VQ=--


--===============0364291822490942052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0364291822490942052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0364291822490942052==--

