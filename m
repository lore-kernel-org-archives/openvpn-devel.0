Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A0CC61DC6
	for <openvpn-devel@archiver.kernel.org>; Thu, 27 Aug 2026 11:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hgqEVN/6q3e2a9B6qV8+4rVgUMEWeDPOnBO6s7pXa28=; b=BzlOSLFE7G3nraNu5PF191+CXU
	dOTD3+iCpJtJNszcH4TpssUuApBAnp49ooWfQ6NQgJm2jpWdE3RZeNUPyVplx/6+5INY+gA4oIcH2
	F7O2NLBoORa3Yh3r/5MjhmBmC9amvHxFDZPcVkCQgO0aKU1EVqN9s5epiFaBDxjjd9O4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzY6z-0002bj-1c;
	Thu, 27 Aug 2026 11:17:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzY6x-0002bc-LP
 for openvpn-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 11:17:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=sRjR1GNpeeX/25kTZr1IR3ZS1byDmSe2Y+c4pluxgPY=; b=Kt1cNRKVmbrkphVb9uYeiqK/Cp
 YhGo44ZstP8HyiR4KxLtqIL+OBWbriuZtwSCk9moM9yWIioamI6KG3ZTjc80eaL89tj8d4xSCx38k
 NSqJ9n1R+0L/CqukznqiaIJoo3z5+hzUK96NmedT/bSuZh+FRuW8XQXt5ZzEuBFECzpM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=sRjR1GNpeeX/25kTZr1IR3ZS1byDmSe2Y+c4pluxgPY=; b=j
 tDDBLwXsubMKYefN9CoCoZjTUHLuwIpR3Fi9JcsQ8AJCaa0skfpZ4nEXSwxsK45msqwToWaAvA+Db
 C8fFCaf4cGnx4AR+V1KmHefxkLbd1nSrUf0lWGARcqske2ZNQNljBn3XL8tSWDnc7ztlU7Hjqmauc
 P7b9stBSkavki8A0=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzY6w-0003VW-5R for openvpn-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 11:17:36 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-49978908b35so14997965e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 27 Aug 2026 04:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787829448; x=1788434248; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sRjR1GNpeeX/25kTZr1IR3ZS1byDmSe2Y+c4pluxgPY=;
 b=QWp/Bu/kG8eFFQM08zhm5Fo/Vw6a9GkK9W8iSb9HIG8g/GrTjGIcBk4BvFai8BGwY5
 kZ8Jxv2Vq03LiQu3zdaIRL6Yr+pNKu2bhN/qlXrF4tAq60UpUoRNRy9kPLg9/cSvwQMg
 8T6q0mFp+Jpt2INYVFdbI+/MBdbPerzmM2+Y9ZEEJIx6Wx6kT8sUnlpwo+eFq4V+xWUo
 W2prz3hputRqXnDlSbz2ncxQ8UGUAx0oFVqZivMzOfgVLTcVEf/yiQMW0fRWYCe/kvAg
 8V9hhIw6dT+L6KzCs5mnTnq/vjr8yxWhdwcL23KjUm3JvxYPotHvuOX4F81j4pgfaWGy
 Y6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787829448; x=1788434248;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=sRjR1GNpeeX/25kTZr1IR3ZS1byDmSe2Y+c4pluxgPY=;
 b=NQIANlNZwWQe2q7YCb9xCJ4kBpofXCkO3Di8J9RKTzurlszPJQEsFdw93lIP3pqTTM
 k8FHE9wTA/PEiNybKg8BDGo3lspl3YUj84Om7r8IvX+vblb7zBTicQGZLvBrKT8cIW3p
 2uYemtXYgMVf5qRyPBqWL8xgArLf8BugowA+0mEwAJUK94C6PQtUd27z7TuV36vjheO/
 +BHZDUW3nGMtrF2omPS9OEBZTrM6u+kNQSgNmcO02Sbbn9ZzGAwWFx4HihXsr/Y32UyJ
 oFa/MaHOoYRdy94GkWUDUsXK4HDaYoVnKd1MoUdgzpn8fv3b8S7ymPMPbQS9BPGHGlrM
 NTag==
X-Forwarded-Encrypted: i=1;
 AHgh+RrWtUiUms5+7Cto1MJFDddbivjBd8om7OuK3/mfft4ehQ2mGknGpaHd8wauew+YYptbMa5gDOdux00vhGwt@lists.sourceforge.net
X-Gm-Message-State: AFuF++mumL73QVGVQ+Y845Xa7SxOVzq8kubxiy6SrBLBFIdaQmiJwSTo
 XWriuhU33blkgcaXiUEoZbA6FQFWTZkrrf+i4kdCIrqiwU4/79DAcGwEn7Q08ICj0dTEdvQsTtF
 2i/OiMvQJmgFtN+Mr0oOOT/j7MkTkkMR5IYTCgIRQ0lZ5LcW/M+ITKVBbVTlnMdR/UlG6
X-Gm-Gg: AR+sD12VLIQ+wVBZjLoLiiYJDbhanW4kUAwJ0q08yW8bF+OqlWvkrjxIOsZdxrAupwP
 IWUyj2SDtOfpqT0X/jxOH/b8u9JC80Rsa/FIGqVPIP8aWfdJMCfgNhGuf9Rk6H0ocBuif8pP+at
 fxofwOSmHE1UKGgHHA9VBb6rMLMOMXXi5mP4eGj9hqzEXzbQFePOLMZVwgskBpJ4wREt64pCl+0
 Y0BYmMGZBZcKjIlKJHfLS2uu8Zt+Jz/causmHg2TtZs8550HupRy3Q4BZfLF0pFEqMxRkU0jfeD
 azHFThRG4xQMYkcOhSgmLMPZsPK9OAPxlhM5TFTsOwcGokA9p6/8C0nDnh5NE7qbRDe0mrBWUKS
 ewaGyHdqVopXge/zMQ/uQqzvBInsBdK3kLqfeaComrSVcDXg8UzkumJwr+S/5JKxB9EjmWvtop5
 0nm7KEhrPvq18RBVtZR5YVMDYXD+ftZNkW3TwShFJ/uoX8NKZd6zahwO1OkQ2ay/4TcHVI+Feq+
 sbkmNvQi9q/I02GyP4SGsAqLYQBaXrrTnoNFh4L3V9uu1nTkYB4tP8yIyGNOqVJo8nOJj5pqVnf
 1tSHL0e7ACl5CBavX27iX8hUR6Ebq7fnnlqm6+t93dVJ21MmYok=
X-Received: by 2002:a05:600c:8b4c:b0:499:a5fc:207e with SMTP id
 5b1f17b1804b1-499dc7044c5mr172662635e9.8.1787829447397; 
 Thu, 27 Aug 2026 04:17:27 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e27ab6d0sm8170647f8f.13.2026.08.27.04.17.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 04:17:26 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 27 Aug 2026 11:17:24 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: Iccdd4cfad090c565aac27e16cdaa9871106c2f89
X-Gerrit-Change-Number: 1826
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1826?usp=email>
X-Gerrit-Commit: 793301a47dcc96dfdd667c31e923d1c416f069e0
X-Gerrit-Comment-Date: Thu, 27 Aug 2026 11:17:24 +0000
In-Reply-To: <gerrit.1785155982000.Iccdd4cfad090c565aac27e16cdaa9871106c2f89@gerrit.openvpn.net>
References: <gerrit.1785155982000.Iccdd4cfad090c565aac27e16cdaa9871106c2f89@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MTU1OTgyMDAwLkljY2RkNGNmYWQwOTBjNTY1YWFjMjdlMTZjZGFhOTg3MTEwNmMyZjg5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <68016bca3aba1a452ab4326ac786595419e47d9f-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzY6w-0003VW-5R
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Make required action
 returned from pre_decrypt_verdict more explicit
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1297077048194589606=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1297077048194589606==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DI2o8+llvVA="; charset=UTF-8

--DI2o8+llvVA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

flichtenheld has=
 posted comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1826?usp=3Demail )

Change subject: Make required action=
 returned from pre_decrypt_verdict more explicit
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 9: Code-Review-1

(3 comme=
nts)

File src/openvpn/mudp=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1826/comment/07cd59a4_a731903c?usp=3Demail :
PS4, Line 83: /* Returns true=
 if this packet should create a new session */
> I added the different stat=
es as doxygen comments in the enum itself=2E [=E2=80=A6]
Done


File src/op=
envpn/mudp=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826/comment/9fd=
8d5e8_9886e72b?usp=3Demail :
PS9, Line 99:     /** This packet creates a ne=
w session normally */
"normally" is not very useful here I think=2E How abo=
ut: "This packet creates a new session to store the Wkc while we wait for c=
ompletion of the challenge=2E"


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1826/comment/3edeef13_ff72c925?usp=3Demail :
PS9, Line 102:      * the thre=
e way handshake */
"This packet creates a new session=2E The challenge has =
already been completed=2E"



-- 
To view, visit http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1826?usp=3Demail
To unsubscribe, or for help writing mail f=
ilters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Me=
ssageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Cha=
nge-Id: Iccdd4cfad090c565aac27e16cdaa9871106c2f89
Gerrit-Change-Number: 182=
6
Gerrit-PatchSet: 9
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
G=
errit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: raz=
vanc <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: stipa <lstipakov@gmail=2Ecom>=

Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-=
Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: stipa <=
lstipakov@gmail=2Ecom>
Gerrit-Comment-Date: Thu, 27 Aug 2026 11:17:24 +0000=

Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: plaist=
hos <arne-openvpn@rfc2549=2Eorg>
Comment-In-Reply-To: flichtenheld <frank@l=
ichtenheld=2Ecom>

--DI2o8+llvVA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>Patch set 9:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1826?usp=3Demail">View Change</a></p><p>3=
 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>File src/openvpn/mudp=2Ec:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1826/comment/07cd59a4_a731903c?usp=3Demail">Patch Set #4, Line 83:</a> =
<code style=3D"font-family:monospace,monospace">/* Returns true if this pac=
ket should create a new session */</code></p><p><blockquote style=3D"border=
-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I added the differ=
ent states as doxygen comments in the enum itself=2E [=E2=80=A6]</blockquot=
e></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-=
word;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File =
src/openvpn/mudp=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1826/comment/9fd8d5e8_98=
86e72b?usp=3Demail">Patch Set #9, Line 99:</a> <code style=3D"font-family:m=
onospace,monospace">    /** This packet creates a new session normally */</=
code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">&quot;normally&quot; is not very useful here I think=2E How about=
: &quot;This packet creates a new session to store the Wkc while we wait fo=
r completion of the challenge=2E&quot;</p></li><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1826/comment/3edeef13_ff72c925?usp=3Demail">Pa=
tch Set #9, Line 102:</a> <code style=3D"font-family:monospace,monospace"> =
    * the three way handshake */</code></p><p class=3D"blocks" style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">&quot;This packet creates a new=
 session=2E The challenge has already been completed=2E&quot;</p></li></ul>=
</li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1826?usp=3Demail">change 1826</a>=2E To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eo=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1826?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: Iccdd4cfad090c565aac27e16cdaa9871106c2f89 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1826 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none">=
 Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;ra=
zvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Comment-Date: Thu, 27 Aug 2026 11:17:24 +0000 </div>
<div style=3D"disp=
lay:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerr=
it-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-Reply-To:=
 plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Comment-In-Reply-To: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>

</body></html>
--DI2o8+llvVA=--


--===============1297077048194589606==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1297077048194589606==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1297077048194589606==--

