Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E17C43458
	for <openvpn-devel@archiver.kernel.org>; Tue,  7 Jul 2026 06:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CLOcRjZqoaew51ypt6kyIj379r/PKn/LdIanPvmtaPE=; b=fXgfAGh+S7q6JTWR/Z9oH0jF1C
	iyKs3wv0RMJzFQ5mtRmqxO1Oix1V6lX/zMP4pGF/gmh9DVaFTUA/476BBbJLhLxN+BM9FZA8F8hJW
	EwJDn75YfGC6BnVFK35Z3GcV4cXqGpsr4Dh8lPbNr9WeTdj7BQAjxBXEmfXvILFpymic=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wgzaY-0002h1-Pd;
	Tue, 07 Jul 2026 06:47:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wgzaW-0002gv-SJ
 for openvpn-devel@lists.sourceforge.net;
 Tue, 07 Jul 2026 06:47:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=bfLwQ9XBTOSDWxJd356MBCCHvT/cL0o1OvRUUR/06D8=; b=aUN/sLkpmPXgf9pbEqb008Mois
 aJCJiy044ufSMKowMAwAO6owfFccrhJTTMsKWKd6+zQ3ooKyfHGZtghP5p2+ksooTLW+k90GK5hkt
 mWH3a5f2daOgwIgoUp8ZfmuoTldV4ueIRHKdQmEuDpLDdJdLyUlTLMGuRhof/gRMmfOc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=bfLwQ9XBTOSDWxJd356MBCCHvT/cL0o1OvRUUR/06D8=; b=K
 Co2bKiDOF32yAl3Xkte6xwMmuTXU+VRY2EbCsqBAknuI4tyjtr3LMfTlu4LaAiCP64ZH3XvZ3+5vk
 rQtW+5xyMpqIH1htT3WrfcHGGXKTotqVll5hGRZ/8rBcPC+aWsZH4qyZP/9PSpdxfIvtwmXTP9fiy
 9FFzpSZA20kz7ReQ=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wgzaV-0001S3-BY for openvpn-devel@lists.sourceforge.net;
 Tue, 07 Jul 2026 06:47:25 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-490cf3000f0so36726695e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 06 Jul 2026 23:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783406837; x=1784011637; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bfLwQ9XBTOSDWxJd356MBCCHvT/cL0o1OvRUUR/06D8=;
 b=B1fcg/nFaI4yAqPXpXik3EdJAQ/rfd5KNThBbQvlsfbRxbaaM/tQH9Htg1yXpgMjJ+
 Igi5Xi6Wnn9ae+afYY8k46E+RywbtazUao4bsLM28u3xvLUuCPcffoN1c/Jc99tA6vyy
 /jSlbpTL+ABGWK5X2+GMYiPpKrqs28XsALmTqFEupSSn+KJ8+kvp78zU+L4/m8C7kays
 QPxgspcPQufcAaPtd3PgEQIXbsFk/VA3aSZ+8eQn2OCFo5kUx8BBYSnkmgzlpoNMGLNt
 c5d5RfnC4yWio7kov7O+QNPTPiX/E997H6/yCB96liCS8nxdPjtDCyPNpqnzBlcrJiBJ
 YTBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783406837; x=1784011637;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bfLwQ9XBTOSDWxJd356MBCCHvT/cL0o1OvRUUR/06D8=;
 b=YRBBwzoXol6AXhG7a6YsMLIO9Q14IphJixELLsMnqvxKmEqMdAnWAVFVqYKilx4UXQ
 ELoo+rHkB5C0mkMcgmEJ9/S0YsPZ+o7Ptw3IikhRxIAGbaEUE0OFIAot7I9D7IDfjMw6
 0O9QfiUFJv0OCkWESYsLjeioZGWPfV2eZDrToQrkmyovGDQUtvIHx8iXg9m2HenhB5Um
 YazST3SkSM0RL1kIrEdjJ82RY2TYsIxOG516iGC0zKlRRccsxUhLJWNFLhVCCxFbG4MW
 fZwGope4szbiuv3Q50IpGMhQqgibP8yY5+d+Kd7d0Myg9osAFT9wzQP18kikwE+q59TV
 Wtzg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqHYciJTtCTtK5ip041Ii6iBLe69zNOhYFE2Lc0rnwBIWJYbEDp7/3QAxjIDDlyXNaQbUAGOrUy8hNBkeE1@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxxUnfWes9lCQ8zx30GFY+IOSviip+kjyYP7FsQsNpfcU9EZpni
 3O63TbNyLZMcGO8UERFMrnQ3UwP6R64w1pgboJubNz7EK0gzSpUpeLL8Rb+QgoLENQrnEgVPf9N
 pEwD3JAYoRD2gob3of+1/vjE5qQbDN08UfFxg6Ichxhjd6I7lnrSwW5OXXGzTa7kGCkpp
X-Gm-Gg: AfdE7cnqMcuXmSMLMjPDCxl7Q4cYCpbm3MeUVTL+9u/NOSNess3uVj9GGvNMGLfLRcR
 lov07ljinCF7dLk14guELfoI+Wsh2uH/0CIj9tsE4b2KBepEAWFuuoVdyul10+mrFgo72gpuGyM
 2BlmF3FAkKGAdeab0DMigojlb+sXbGVpMu1vocKHaYOPMIdozM40o16mfW4M6t4mpNeuDU0cMSI
 SVVVC0iio1F0CFV99PNF9s+StmVegBCiSbLua6oqsVhZ8LLuxK+Q+svqwzLsYistcLvcnetsATA
 4s1qoYEPqi1g2wOWN8zx2pjaw2S0Ojetf/S9ure6PQ2Z0fosPMH5Xt3HK2x8BYndEJMM5qhMehg
 lEHMF3arcx+RMvlIMB831fYWIrlyL+tTYPKqizr84SmpNOmeTUKq7GK3eMUktqKj+2xG+vlaMd9
 ueSa1+ojV+wy3KE71QNcjsvViQj2EBQ6+PqWvN7QQ5i0ubzABU9i4klkmaKqdHbFTyg9JrE9SZ6
 JOQPGGI36QFcda4S1C93q3HIOlvLd3YegJ9PPai+RFJ5tHc80k5vab7D7S+hKplao/BZIZ/rV8M
 Ytg=
X-Received: by 2002:a05:600c:4ecf:b0:493:aaa2:f034 with SMTP id
 5b1f17b1804b1-493df099c39mr30745225e9.26.1783406837070; 
 Mon, 06 Jul 2026 23:47:17 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0f3677asm28836385e9.4.2026.07.06.23.47.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 23:47:16 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 7 Jul 2026 06:47:13 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I704c560fa23c03237d0f8adc30908a617265a5a1
X-Gerrit-Change-Number: 1478
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1478?usp=email>
X-Gerrit-Commit: e3676dbba60cf1e453dae83018200bf362eb604f
X-Gerrit-Comment-Date: Tue, 7 Jul 2026 06:47:13 +0000
In-Reply-To: <gerrit.1768848003000.I704c560fa23c03237d0f8adc30908a617265a5a1@gerrit.openvpn.net>
References: <gerrit.1768848003000.I704c560fa23c03237d0f8adc30908a617265a5a1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzY4ODQ4MDAzMDAwLkk3MDRjNTYwZmEyM2MwMzIzN2QwZjhhZGMzMDkwOGE2MTcyNjVhNWExQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6433871a7b324753e72520642967f9922e572b50-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wgzaV-0001S3-BY
Subject: [Openvpn-devel] [S] Change in openvpn[master]: tls: reject incoming
 reneg request if primary key is not fully valid
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
 openvpn-devel@lists.sourceforge.net
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6423783321798930405=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6423783321798930405==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xuIA3C8MP5A="; charset=UTF-8

--xuIA3C8MP5A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

ralf_lici has posted comments on this change by ralf_lici=2E ( http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1478?usp=3Demail )

Change subject: tls: reje=
ct incoming reneg request if primary key is not fully valid
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3:

(1 comment)

=
Patchset:

PS3: 
Looking at this change again I realized `goto error` marks=
 this scenario as a fatal error in TCP causing an instance restart=2E Are w=
e ok with that or should we `goto done`?



-- 
To view, visit http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1478?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: I704c560fa23c03237d0f8adc30908a617265a5a1
Gerrit-Chan=
ge-Number: 1478
Gerrit-PatchSet: 3
Gerrit-Owner: ralf_lici <ralf@mandelbit=
=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Comment-Date=
: Tue, 07 Jul 2026 06:47:13 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels=
: No

--xuIA3C8MP5A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1478?usp=3Demail">View Change</a></p><p=
>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1478?tab=3Dc=
omments&amp;usp=3Demail">Patch Set #3:</a> </p><p class=3D"blocks" style=3D=
"white-space: pre-wrap; word-wrap: break-word;">Looking at this change agai=
n I realized `goto error` marks this scenario as a fatal error in TCP causi=
ng an instance restart=2E Are we ok with that or should we `goto done`?</p>=
</li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1478?usp=3Demail">change 1478</a>=2E To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://=
schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1478?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I704c560fa23c03237d0f8adc30908a6172=
65a5a1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1478 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:=
none"> Gerrit-Comment-Date: Tue, 07 Jul 2026 06:47:13 +0000 </div>
<div sty=
le=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:n=
one"> Gerrit-Has-Labels: No </div>

</body></html>
--xuIA3C8MP5A=--


--===============6423783321798930405==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6423783321798930405==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6423783321798930405==--

