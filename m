Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717C5606A31B
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 12:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=YZWwnFu7;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=LILCxtgs;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=QDlTsd0J;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ZeK6gvFd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=19ev7zHp+kRHTilQzO8JhRSQQMJuDFgG2/8Hpb00XyU=; b=YZWwnFu7QoBUxflA61xq6hAPV7
	YAMxATSB50V5W0IDwc3jlt2k0ABIrbnJP6D++F282Yba3b+3V1sr2Ns/ANEDWZgA7g6/f3uBn8kCV
	4WFqkDB7pIKhDmLSLQ4/jqvq9B1qMYXs+JO4Hk1oKBFjtVgeYqGjMDnElYG5bZ2dzSEE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOaTE-000000000JP-3Tvn;
	Wed, 04 Nov 2026 12:52:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOaTC-000000000JI-3Sry
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 12:52:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=p9414c1QoZPkHzeabaJYK6uBoHt7FR6+Cvy2AuzA2AM=; b=LILCxtgs4HR5upXgqg0likbxcO
 zfZBpE2p3CrjuHlMyJi5VyfjltI5kvnhyQfOrvIykzi3rRZgaKY0IdeXb5EdNlDdksNq91Qq4G62L
 w7lRA5qLuNR0YLeyKVlT1uJxZLvwRV2h6eaq+alGZAZLoWzZoBGNi9LagJSqYBtes0Es=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=p9414c1QoZPkHzeabaJYK6uBoHt7FR6+Cvy2AuzA2AM=; b=QDlTsd0Jv3D+D3KIfrG1tz8QdC
 Uuny79BFlSHNZp+mCbiREXZpy7VNzQ6zBPbQ2KEk8HZPa3ApxTjcE1WLdMw2sv5a0lx3dK9RYHg2o
 miTcxv4k/yVDvc5pgAyZ0Wrn4pdOzpN0t4hIwB2XXyhKhxLmUZvDm7uGDKAaK9JDzRtM=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOaTB-000000000Xv-47R8 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 12:52:02 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-48e00eee27dso367423f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 04:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793796715; x=1794401515; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=p9414c1QoZPkHzeabaJYK6uBoHt7FR6+Cvy2AuzA2AM=;
 b=ZeK6gvFdNJXcNTifBOqZhVVERoYoiVgV6/sMUJt/q5Psoykhi9iz6oG/I3xjIIK1dx
 MIBHSKiF9194y5hzWAwYrrObzjPZsi4AnDDGpdGIBFS0gPTaGhpCvQlUyqU0LhQvFpsn
 JRk7fqFwPjFGA9OIItAsDMk7gQolHkdwF92fOb1QuXkvR6wj3TvFdlX15uUvhaAoHfNH
 b0xvfMNQysyeuG6CgS9taLrpOqbGwQZ0LUSn3ts4pIKqYVXw0F+efVYM/YmBmKFAVyE5
 hfIyLNO+nNeJp5US7mIZ9iFdGf98gohhjNgnDRBkMpZ0TsYJzXQ2Y/ok0X77nKjvx+i7
 6LvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793796715; x=1794401515;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=p9414c1QoZPkHzeabaJYK6uBoHt7FR6+Cvy2AuzA2AM=;
 b=zAT2rxv9cMZefhVXQEWr0jAJudTZjSC90Cs5n4RsqWPWsP2qdzJlsc688CnarwfT6i
 wQSChScQND0jwL3ikJG6jPT0CqvqaLaxx+mPKMpMf/sCFBmaQDDtOF8BedobL4KiBriL
 vr5koAoT3IY6JXupZraM6bjmp0e/MqK8M4aYeEm2LhGIjRRt2kDwdHDQyiO2jghr76SK
 I4J94vpRsbVLffEtHz4NFVlp0aUmOJ0vzTHoen1pRTYnSe98TDSi6w8vMFHqY5KdKzKH
 mGZjpCFKReOcoxEY92Ccuym36uSMt95sstuKoR33fw9BsakTPFq0yx/4csPenjGuiaVc
 OX1g==
X-Forwarded-Encrypted: i=1;
 AKwUvBx/vXwtOBxGBQFRc9g2Uma2i89UySA1RA0YtcEJilg3TQLuCGem21eu1JShtGRW99VIonue90mNHqM+CMZk@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9HMm50ocz7VTgxOS9D+eB2Kx364+GVjtLcMJneB1Qsi3ciJYqf
 mYhhOdESDIqBDVq6xxfNYCqWTINEzqWk62Ukbw4VNLBqo8kjepoKcqn9MYe2r9hYlvSxeLVmsjs
 mPSTjC3DqFdGdW3qWl9eqeIC1TsVU3sk+Pbsas63d0Gpz+6Fpj6SyRLZJYsPME99gTebWkyPBOk
 W2Brkx1A==
X-Gm-Gg: AYBFou2kz7dBjb5KTsN40o08UHOrsqS/Ly2uRL0jK9mHjsXNbsnUFGCVNoclT1M+hmI
 R+alcBvqEyhzRaJvUfzl1/Veuh3Q62pdbqpD1Mu8ZA27J/Vbs6sQMG6cgvBEbO/2E1OBLwAcWAI
 0u6tRpX2xh/WK4kK6M7kpjrQ0MIb9E4ulM2jFYIZ9Ms6VacsDQSuQWXjolb0EBE4bD3bhstbp0s
 ERCwLK9qe18Okj0EBGQK5MHPo/0uGeK82HvRqq/5pF1gbmgWEOr4cB4J4unaIG3Y91pjJi26VfR
 TIaM5PoAf7/CutFMUOH5dSVfpygLSuNCgyxPfoSFqaB8mDlATXuyM2DPgS5zg8VWh9e0ymrtlLX
 sukbe1hIlZnBOFeNM62Vz54dvg2AgHT6mDAFyC2w9As/8prOcKAph6gvw9D8JC8015IHvu/wTGp
 AUjdcOe8wQ3MsDxQD3cM9T554k7c82bbHrPnaEORBXI+5985R8eDahY/aSLUGa/1I8slZOJ3cT8
 mxMYk2ymODAn9yfGn9O0j5ofdHVMxXnZ4vdJWNbUuyZwDau4UmJ3iAYWn/fQSb3zvHfP+7VZ6yi
 /7lFmk9otoktmTrJ2Y5S0sWKRoSXln19IHIuqBjRX0YD8HrLX8irsyVkj6enYgqyaN8KWVJpZVb
 BTOyrW5FzQgOHO+zax41RMOXTPuT9lG2ooaO0/zdFy7MG+BhvqagExDWz2rqEuithFujOikVO5h
 mo/dRArUaqP/p7oQ==
X-Received: by 2002:a5d:5e0a:0:b0:48e:84e8:88c3 with SMTP id
 ffacd0b85a97d-48e84e8895emr17088168f8f.5.1793796715190; 
 Wed, 04 Nov 2026 04:51:55 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fed551dc5sm3842448f8f.34.2026.11.04.04.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 04:51:54 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 12:51:53 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I04c128a934e9a2e767394dbe82427df2ee886178
X-Gerrit-Change-Number: 2118
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2118?usp=email>
X-Gerrit-Commit: a95c2533fd931037fa021b38a42d7cbe6f334cef
X-Gerrit-Comment-Date: Wed, 4 Nov 2026 12:51:53 +0000
In-Reply-To: <gerrit.1793776591000.I04c128a934e9a2e767394dbe82427df2ee886178@gerrit.openvpn.net>
References: <gerrit.1793776591000.I04c128a934e9a2e767394dbe82427df2ee886178@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzc2NTkxMDAwLkkwNGMxMjhhOTM0ZTlhMmU3NjczOTRkYmU4MjQyN2RmMmVlODg2MTc4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b0c0aa66cae71953d450e610f2478e4467538c91-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xOaTB-000000000Xv-47R8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl_verify: drop the
 return value of verify_user_pass_management()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4374565614452393221=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4374565614452393221==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6r7WtGKvmIw="; charset=UTF-8

--6r7WtGKvmIw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2118?usp=3Demail )

Cha=
nge subject: ssl_verify: drop the return value of verify_user_pass_manageme=
nt()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 2:

(1 comment)

File src/openvpn/ssl_verify=2Ec:

https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2118/comment/1d2e5446_37412e0c?usp=3Demail :
PS1, Li=
ne 1532: static int
> Why not remove the return value completely?
Done



-=
- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2118?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I04c128a934e9a2e767=
394dbe82427df2ee886178
Gerrit-Change-Number: 2118
Gerrit-PatchSet: 2
Gerrit=
-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne =
Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <fr=
ank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Commen=
t-Date: Wed, 04 Nov 2026 12:51:53 +0000
Gerrit-HasComments: Yes
Gerrit-Has-=
Labels: No
Comment-In-Reply-To: Frank Lichtenheld <frank@lichtenheld=2Ecom>=


--6r7WtGKvmIw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2118?usp=3Demail"=
>View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_verify=
=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2118/comment/1d2e5446_37412e0c?usp=3Dem=
ail">Patch Set #1, Line 1532:</a> <code style=3D"font-family:monospace,mono=
space">static int</code></p><p><blockquote style=3D"border-left: 1px solid =
#aaa; margin: 10px 0; padding: 0 10px;">Why not remove the return value com=
pletely?</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap=
; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2118?usp=3Demail">change=
 2118</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2118?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I04c128a934e9a2e767394dbe82427df2ee886178 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2118 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@li=
chtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Comment-Date: Wed, 04 Nov 2026 12:51:53 +0000 </div>
<div style=3D"displ=
ay:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerri=
t-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: F=
rank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--6r7WtGKvmIw=--


--===============4374565614452393221==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4374565614452393221==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4374565614452393221==--

