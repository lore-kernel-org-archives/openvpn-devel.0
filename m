Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109ED606A326
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 12:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=dYZENcuT;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kQ/Q0ZtD;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=SwgOYgyt;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=LtTMMZ2v
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=eqRXfe0eLS7b53tvhPTlCvVjnToJ3YOWnfmXkKZ3vUU=; b=dYZENcuTumYY/iCppwTS4GWm0p
	S5B+zY7sC63Cmpa/Zedr3k1xSn1DJivz21KLcWWFdOQBuOCuinTM9oy88srV6IX3cvaDoe8q1Zzfe
	vZV52SLrOyFzXjXvdAGJgLuh7A9RWZyJ594UjhE4JhiQ14ugedtZMsAfxMP2am/YUT/M=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOZxX-000000005h5-2HkL;
	Wed, 04 Nov 2026 12:19:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOZxW-000000005gz-2IUL
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 12:19:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tQSw5kG/S6IwlwUqsDu9fXZZ8uR8W+o9d4yZi79qDy8=; b=kQ/Q0ZtDpjQule5sQ9VgI2HcPv
 aGN4ZEh29sonQwwPfUdCKEn2OIioRfAzqabeZMpnQ5X7PPhPtrlON+/X4XpiXktDfP0Ti+5EMrkFU
 0IDRJBRGQ/xQpAGATuN6Y6mhV48/PpL7lSbuodRIt3ObOrCevpfVjSc11HPd0NEwZk6Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tQSw5kG/S6IwlwUqsDu9fXZZ8uR8W+o9d4yZi79qDy8=; b=SwgOYgytD1KYFXg1bmfVRwbODL
 dw2ttSZeiAeoGcQzqzPf6weNx8rxNGXN+NVoqc7xy4UpHkTmjskBnULm9aQAkTDf2PwPkkIqYwBoA
 mZ58C8vTe7OXEjy8CdVHUkpaebz/5UnpmRpq0Z5PiAQSbBgoCx0pAgjZSsizgHfDnavA=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOZxV-0000000085F-0ZgG for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 12:19:18 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-48e10a70540so380339f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 04:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793794750; x=1794399550; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tQSw5kG/S6IwlwUqsDu9fXZZ8uR8W+o9d4yZi79qDy8=;
 b=LtTMMZ2vaHv/c0toQwxW1I6PNf053DFvB6bj9ARqsIdR3vB3euch52Mj3MH9VxWhSv
 NYo0PlNPpiOkHPKRyTanmYt5epX+5D1dDmJp3BluNOHRwxaLj7aqYiTecMu/lyXvengy
 S4AXdE424aEiruM7oQvrpJ/SE1WOQvcKhyI2iAA37mo8DbUOfr3TFq3hWfvGWCDTqwEW
 8TGxoVZwKuRzyaZVfeWSRjJErKmzdbtAByvFfzYcUyRQU8wfREhJyKInzpSdoeYP1yNA
 iUWcLjALnWK3/0dd6nTfqPP6QvdTZv0DsTif+A/SBjG7plwppXCaa6IG6yXqzJtq2PYe
 NgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793794750; x=1794399550;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=tQSw5kG/S6IwlwUqsDu9fXZZ8uR8W+o9d4yZi79qDy8=;
 b=DpNQIieMwP3lwTUHzrzpBhch+F/aL6uV9Ua5P0DNPkr6kRBUdSBbzeaBi/dBry765f
 QB3TmCVw55ZUzqitZB++DKQuep8UJgAHpJJYj2q6VzXILe/bjNaqxCv/sgGY3x0P6Gk+
 FzE1/6yQjjdAlBGihTGT3g0bkM9aHDSiw/HYQjQ3pcMYPBl0UKrEZm1Gyq1e5SqYB3C9
 UV21lb0U1hjjHD8Vkgx4tw4mPkG16aPZhaCOjWlacX/I4sdrW2r21eTN2VeSOABgrTQb
 e+UFFZ3RCrDosdXXqP/Cg7TxEOlcL3jJqsqPlELX6GZBAkXQ2PNvORyeZ/y7l+PNN36M
 VnNw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwxxwyieOXN+L9/vMl3J8LOM09Rk2ig7YT6W99w8eKV+h1POGHaaO/SuRL6gpxXfzpgtqpmLyp5BNJdFyUy@lists.sourceforge.net
X-Gm-Message-State: APuU4Z80RD3fFedDDwwL0JOijCQbdBMamhEmMOp7s6rn1ORnPw0Ys4oM
 OEHM+ntTCoAwVAY/ggYXU+EVcELcs3FniIV6QOko7dq47NgP+C9sGrqq9YNACpTAqCnrshTkIGq
 vLI7qb7fwTV+c229b6bAN05ikSFMElAdKl50aTxyGr+qToMjnk1PPjfOy6kDdcMZ1O9vt
X-Gm-Gg: AYBFou1xKzmFThdHtiHdN3uW7+7CxACe+XX77NJfylFqCBuB6AEWJWjgiqOwlwLYhtU
 1eBeeY+cs5PBuA5MGdAxG4tCJdVr4x9lvtz23QGPBLv/pDCqfjPLu5/sZ0KQkR7swUB8nUPMStB
 qw216kPg8K3JMXe0MpOInatfEr2qmHiNZ7bV/o3Wv94dt3NtxXirIZdo6sj9wZ0k18aTlDnDZxY
 1dfXNsJS1UvQ5w7G7Z0KMQq5Du/Num4ulQOQ1KAvfjVO3QT4LC9yIonyTyZN+KSw72P4mbQr7xS
 SpEGRyJXnp7NeDYgE1pq8k+JW5VnFURs0nZpzvwNF39u2451F4AHvOdYohe4DsTucIbuBhfuEFx
 l3IN2/EHEe096wymvD0jxPbnjiAdQIElZ/RBBTgroCaJPWOIz/f78IxeJbhSTcee6MM3f5dFL9g
 tjLgRRzA+iefCCwp7kXpOqUJ51laZuDr9wSKn97p1OaPZ+N9AgIbr4dfx/6RW2qP94Sj8AXCB9s
 RRgvy2tqrjFoM5iQQqwSMrwHUOoG0Akkah7tsa9G1AhvRLPNVaAHfCSUQZ9MLqdq///WCNWpcs1
 qsV2kgJY3PaYBO+bh3Cq6YEMrUGsjpEMgwvsaYDzTmbyb0/0CXtp8Devg3TRsskFal1wEYx5eXf
 X/oHmcaZU7OyXFgGY0In3PYnVzmw4RvM+uQMNY4R9GfSahJE6h6NCH56Ehj77clRh9IkvM77BMn
 /qhQZF/lZpBK3duA==
X-Received: by 2002:a05:6000:4013:b0:48e:6264:c388 with SMTP id
 ffacd0b85a97d-48e6e2ff911mr33924209f8f.23.1793794750373; 
 Wed, 04 Nov 2026 04:19:10 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fee968763sm3670834f8f.56.2026.11.04.04.19.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 04:19:10 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 12:19:08 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I04c128a934e9a2e767394dbe82427df2ee886178
X-Gerrit-Change-Number: 2118
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2118?usp=email>
X-Gerrit-Commit: c15ec8f549542ccdcee1f4eae0afd5076c77bb24
X-Gerrit-Comment-Date: Wed, 4 Nov 2026 12:19:08 +0000
In-Reply-To: <gerrit.1793776591000.I04c128a934e9a2e767394dbe82427df2ee886178@gerrit.openvpn.net>
References: <gerrit.1793776591000.I04c128a934e9a2e767394dbe82427df2ee886178@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzc2NTkxMDAwLkkwNGMxMjhhOTM0ZTlhMmU3NjczOTRkYmU4MjQyN2RmMmVlODg2MTc4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c853fb81adc3e62cb3770cce3ae2da82ba1d259c-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOZxV-0000000085F-0ZgG
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl_verify: drop
 dead retval in verify_user_pass_management()
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4822359114890622072=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4822359114890622072==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="iVbxOK/4yg4="; charset=UTF-8

--iVbxOK/4yg4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2118?usp=3Demail )

Cha=
nge subject: ssl_verify: drop dead retval in verify_user_pass_management()
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:=
 Code-Review-1

(1 comment)

File src/openvpn/ssl_verify=2Ec:

https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2118/comment/5552c70a_2baebd77?usp=3Demail :=

PS1, Line 1532: static int
Why not remove the return value completely?



=
-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2118?usp=3Dem=
ail
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I04c128a934e9a2e767=
394dbe82427df2ee886178
Gerrit-Change-Number: 2118
Gerrit-PatchSet: 1
Gerrit=
-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne =
Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <fr=
ank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eor=
g>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comme=
nt-Date: Wed, 04 Nov 2026 12:19:08 +0000
Gerrit-HasComments: Yes
Gerrit-Has=
-Labels: Yes

--iVbxOK/4yg4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2118?usp=3Dem=
ail">View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; pad=
ding: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_veri=
fy=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2118/comment/5552c70a_2baebd77?usp=3D=
email">Patch Set #1, Line 1532:</a> <code style=3D"font-family:monospace,mo=
nospace">static int</code></p><p class=3D"blocks" style=3D"white-space: pre=
-wrap; word-wrap: break-word;">Why not remove the return value completely?<=
/p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2118?usp=3Demail">change 2118</a>=2E To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2118?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Projec=
t: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>=

<div style=3D"display:none"> Gerrit-Change-Id: I04c128a934e9a2e767394dbe82=
427df2ee886178 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 21=
18 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=
=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 04 Nov=
 2026 12:19:08 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments=
: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</=
body></html>
--iVbxOK/4yg4=--


--===============4822359114890622072==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4822359114890622072==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4822359114890622072==--

