Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3957C61DD6
	for <openvpn-devel@archiver.kernel.org>; Tue,  1 Sep 2026 07:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=99Png0moeVN5mQPSOWlcJOuOu0s7OPMHABK716qk3B0=; b=I73bV9/9d+kjQcVkONHkzp5MEg
	/gAMSmjfhP7HaYtRcw9gn/LkzYGneWRCB1ogy2Qo/55S9mLJcZ2klRlNUr+2n4LhuQ+YD/0CGbdLM
	hc6Yj73Bich2OJhXTS2/BG1ijMExk4r2XQuTfouBX+wD2VG+R8glEI0LGGFdadNblpwc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1Ifq-0001Yu-QV;
	Tue, 01 Sep 2026 07:12:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x1Ifp-0001Yo-Jw
 for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 07:12:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=yCSP5PJX28C2g4pIDVMeABcTOOHS7Rq+4VBQ87NPvNI=; b=XIyZ1CUKSgcxVoXyQYBVyKKx/4
 h3264V0bw6o+uUf/ujNyruBBLsJwyREcuo+HXY6DNYlmlPcVRMLGUrN/+gpNf5pvdsBFRt0X+NTei
 glsYg4Q37dM5G9otBbT3us3eeEy3+H76qsmTAJtj611E8ZRc0yqajqB201sj3iOBVSGo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=yCSP5PJX28C2g4pIDVMeABcTOOHS7Rq+4VBQ87NPvNI=; b=m
 JT2qE9Ryd7XvhJqEDOoKltiH4e99HjVlc2/CtX4sMUAcApk/lP+FtScrTexr2ApEhjxdJsilWIuha
 pJrCVrdAJ4+QX8CzArvccRRHLs07LBoWlhzXaqpvJOhh2QhBnUWQtKWZc/72EeEF6GmOuzLl6DC1G
 EnTPQ5Av496y2mi0=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1Ifl-00060N-Aj for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 07:12:47 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-49557167508so46903175e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 01 Sep 2026 00:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788246759; x=1788851559; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yCSP5PJX28C2g4pIDVMeABcTOOHS7Rq+4VBQ87NPvNI=;
 b=ZjyLKpZy66l7vCwPU1RKmw0pyUowifKSq5iNNwbPoJ3eVUXTNJNpyVhec3HZnTBOtj
 6dl4JUSQ7WhvvGym88mzN1ZSCU9b45+PtcISj6/0XfKNuht9H0otY/q2dXZKv7d/i+G1
 ibQfanMjiWGjyoY4Fw3jJ6DyVeUtgDE56XULQkvQefk477WWjI77FQASavivRW5OfVfS
 PBR8ammfSvbHW74berTe9Vyl6H/kPFXrn5icZyPOh1jgi1zo+50x8QGkrQGfuqQ625qM
 TmcAPOmWL6xL80/6jR1JkiY9jTzrn9UlGTGgpUPXlxaJYA2HsISX41L2QiY3tA550n+l
 A8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788246759; x=1788851559;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=yCSP5PJX28C2g4pIDVMeABcTOOHS7Rq+4VBQ87NPvNI=;
 b=PnAwxQM4hI+hQWzkLI6vEbR684N2assyeffJSUYWHsiN9fY9f3204g07j/O/EyHO1j
 VnRxwxYij+5ZEbW4+pSgoTuFAke+eJOnuCduybRXE74LzYBfIscp8P4bVi2ZJ+O2fepe
 zpOYVCqjn2eKRVnphylFD7wuebGhOpeiE3ExnqhudWCS/aIM/jgZITkd6CWy0LAhgkUd
 syFM6+n5kmVWHUcLZHr8O/jENUdiucRo2zFhFGDCa0gic3Q2+Eaw579i7KtavuKBb97o
 /1UYlSRWhUUV65bBvVGW+rtRuNyDc5vSuMs8Y14lpzXkTpLm/hYxFcTuqZLuVOfnrNhL
 PLlQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp8cfpF/w9vcopH/USKZsrt6fG03qc1etbhYo5yeE/FnPOvO3plF8BO8boi+BlJI1L2tIqSg+ze2Eb3StQw@lists.sourceforge.net
X-Gm-Message-State: AFuF++ko3YgnCmQxc9KvX5KppCs8wNGuywFAJveFBFJ3kattLyUFSXlX
 V9WbAA8ArDziF6Ua9To3A36Vt2EM/uMdeVPynU5jtuuDYYhJ+/OB4yPxf8JEdlDSvYbDrShyxVO
 Dw8lkhX8mCqcyAKfL6a12OyMsutT3Vx7669K0A+RHSMVMPcExtPWHUfkU6WFA/Sc1DSJMR5XSJf
 geee/qTA==
X-Gm-Gg: AR+sD10fwQpSopBKX8vHNKhpq/OiJ4XW7/gTWcBHSe+tPopH0WDiCQVpH5680HxreFE
 vXxwb57iYCaMhWnxsqiDYcA9veb2E1X8Xc0CrZEbcmw7cvSpMr+oGBK0x2lhn3AVaWqCnHck+/r
 jYkCD7VdlKlWHFMMzgOCv6O98DSVV7/b4nAJbzZa7aCmI3TPaLSLmrbFfY0BN4fTxv07eYny+XH
 ZPY4cpqueqKvTkKfwGyN6QJAq4lE191kwGpe2X3lV7nH/fVEdyB+aBCgMc5vJppohy6YztnE6kM
 KNb93Yl3fcgCYYK9wpdkLmxS+/tbtuH/3Ll0EfOFtKgH2C9InNE8ErYVmaRHcjfDrwkGlZLHw97
 VckGRzZyIoa6NaxjQkzeMP5wNJGmAUEoKnNwy8t+7QCZjjiuBeWvsUSrZLSP04D4js7eTXUmCgm
 kl3U6EedYymow8n2fd0uVdBfDvwamTgH/yrigfChFJ6w5MnQF75JS4m9rOo30CatBmrEmRw/TKW
 R4WYRkNVfIWT70yRex7G4kEXLzhO7j/sqQ0AF3Sb4qvekUJA+i5yRteHyfpZxaDMRHEE4cr848B
 023i8xPIM47iDriegMoO6I8PCEvNMnKm+OxlXMyrfmZ5MzMq6SM=
X-Received: by 2002:a05:600c:a418:b0:499:b65e:49c9 with SMTP id
 5b1f17b1804b1-49cdc558513mr99199295e9.10.1788246758583; 
 Tue, 01 Sep 2026 00:12:38 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce44ea9sm43924855e9.14.2026.09.01.00.12.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 00:12:37 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 1 Sep 2026 07:12:36 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ie7352dd136cccda2bd6b6e1a36db1a5f27afd8f7
X-Gerrit-Change-Number: 1782
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1782?usp=email>
X-Gerrit-Commit: 5c717bb8efc141e6f2354a4bf5cea832f94e43eb
X-Gerrit-Comment-Date: Tue, 1 Sep 2026 07:12:36 +0000
In-Reply-To: <gerrit.1783977723000.Ie7352dd136cccda2bd6b6e1a36db1a5f27afd8f7@gerrit.openvpn.net>
References: <gerrit.1783977723000.Ie7352dd136cccda2bd6b6e1a36db1a5f27afd8f7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzOTc3NzIzMDAwLkllNzM1MmRkMTM2Y2NjZGEyYmQ2YjZlMWEzNmRiMWE1ZjI3YWZkOGY3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <77430b2ddcd015c491af5bea7d996c2b5cf2dd44-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x1Ifl-00060N-Aj
Subject: [Openvpn-devel] [S] Change in openvpn[master]: networking_sitnl:
 validate netlink replies against the request
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
From: "ralf_lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5093805430461924436=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5093805430461924436==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ETLRjmCEyEM="; charset=UTF-8

--ETLRjmCEyEM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex, plaisthos=2E

ralf_lici has po=
sted comments on this change by ordex=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1782?usp=3Demail )

Change subject: networking_sitnl: validate ne=
tlink replies against the request
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2

(1 comment)

Patchset:
=

PS1: 
The change looks good to me=2E

Just a minor nit: it would be useful=
 to add a comment in sitnl_bind explaining why we copy nl_pid from the resu=
lt after bind (that is, we let the kernel pick a unique pid for the socket)=
=2E But I wouldn't block on this=2E



-- 
To view, visit http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1782?usp=3Demail
To unsubscribe, or for help writi=
ng mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

=
Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
G=
errit-Change-Id: Ie7352dd136cccda2bd6b6e1a36db1a5f27afd8f7
Gerrit-Change-Nu=
mber: 1782
Gerrit-PatchSet: 1
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>=

Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: r=
alf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lis=
ts=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Attention: ordex <antonio@mandelbit=2Ecom>
Gerrit-Comment-Da=
te: Tue, 01 Sep 2026 07:12:36 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labe=
ls: Yes

--ETLRjmCEyEM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex, plaisthos=2E </p>
<p>Patch set 1:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1782?usp=3Demail">View Change</a></p><p>1=
 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margi=
n: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom=
: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1782?tab=3Dcom=
ments&amp;usp=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">The change looks good to me=
=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">Just a minor nit: it would be useful to add a comment in sitnl_bind=
 explaining why we copy nl_pid from the result after bind (that is, we let =
the kernel pick a unique pid for the socket)=2E But I wouldn&#39;t block on=
 this=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1782?usp=3Demail">change 1782</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1782?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie7352dd136cccda2bd6b6=
e1a36db1a5f27afd8f7 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1782 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div =
style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attentio=
n: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Comment-Date: Tue, 01 Sep 2026 07:12:36 +0000 </div>
<div style=3D=
"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none">=
 Gerrit-Has-Labels: Yes </div>

</body></html>
--ETLRjmCEyEM=--


--===============5093805430461924436==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5093805430461924436==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5093805430461924436==--

