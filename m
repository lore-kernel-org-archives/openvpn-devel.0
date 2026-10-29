Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E22F606A31E
	for <openvpn-devel@archiver.kernel.org>; Thu, 29 Oct 2026 16:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=fx81Kcqe;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=lMPzOj4H;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=L30K25pI;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Vb2SKO8d
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=p2GOic3e1ZeEcLpsd3mMRjdUOKVygSt3Y0lCJNJItU4=; b=fx81Kcqe/CgUpd0XY1P5RtNoab
	Nf2QwDIdj/RoTl7dYKZcZfb/yBZQ8poRLDgjOHq3nTLtXuf8mS6YFoEIRG/tlp8XjMbOdoq2AH5M7
	CcSBk1KamiUH40oz/s++huJy24iKtgS/b19wT6P/rPIcXdQ9ETrO94WmVbrXwRJVOVZg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMSu4-0000000071X-3ZA0;
	Thu, 29 Oct 2026 16:23:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMSu3-0000000071R-1Mmu
 for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 16:22:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YS5iZTp4v4xuNXgbZhszLMkNR4hJ82ksuqTjy8rP4L4=; b=lMPzOj4HQ2BcKiey1mIyWJBe5n
 kSgDEMzxFL7uhIbvsCVx8AjdBiVaTbDT+UwlXeInMOuOufA04sY5i1d/UJAPa12i5VS6nnnY2EiRd
 b0x2sLUk5ersR0YfFsVQ9zToWzkmuP0HklDqKytozFJ2J98xWjbGvR04oMq1W4BTLrvc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YS5iZTp4v4xuNXgbZhszLMkNR4hJ82ksuqTjy8rP4L4=; b=L30K25pI3TDJy46hlGMQTXs69C
 kLQtWwfdIriU+J8wQu85vpj/9BO+NyBw89MBtfk45SqljedLNZyEqwlx8HeSDprNYGNpYx5aoQWFZ
 aIvZk0EukMDB4G3DdBc/Cm6LgHwIIf0tZoQmW2sOvFHpifYX+ujYLpI15n1BWoogoy6s=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMSty-000000007cq-3oMO for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 16:22:59 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a59100fa83so21599825e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 29 Oct 2026 09:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793290968; x=1793895768; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YS5iZTp4v4xuNXgbZhszLMkNR4hJ82ksuqTjy8rP4L4=;
 b=Vb2SKO8dytLr1CaUslcek8Ss5J/3XtUVoGqhlwZVa0nM0YS6KOibHHkU1OVtYaMC8f
 uAQ20EY3/pHhEj5ReNrGs+kMZtQ9FJBbY7bBmQe7UJKO1lAGyNN9TskDm2fE48hse93B
 z82cc7H8wAJ1Y5TtVAS40TIxpRxUvRRHYvTbXEvO35ONDCRk0uXHitxtZg9EhuHztXF0
 3EyZnge9e0O2XO60DAJ8g0MI32DFaBxZpETkMSxorR+eK4n8RaLYWNMb1fvC2qs5tohK
 rkvbe474cl3XF1uVaZt8lBlUPCgng5TsP4yX8ZsnAselaRWM2x+Np03Yid3jLSN4osWN
 G5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793290968; x=1793895768;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YS5iZTp4v4xuNXgbZhszLMkNR4hJ82ksuqTjy8rP4L4=;
 b=lLKN3gidQCxGaEplbo6deQJkWJ7oB+FnxF9ub6/7nBE9ozjII0hIKJEYvcgS2ShICt
 SwVcpkX1SVvMa500LrEU5g3Zas7Aul6jGX4S5soiPTYMmyAYW0h5j7BEJZffxdW/p2An
 DEk5uTUSLMvW7KMUaNmGmbY7bAjnK4lhT5DTik+o43CYG3KKq6DeuIOq1v/ZtzYs9aoo
 o5nHnuw7PBO87/DLZ6nO4OI1Rs5fjvEAZv+ppwAeigxwk/U9cgF9dIi8+qzsnDK2kJmx
 xAvR2IqI9uI83X2tzzGqcj8H2AOHDlbxvyAvqTakBcliismEyb5E5zYV+ZNpMdeOBlxJ
 J6jg==
X-Forwarded-Encrypted: i=1;
 AKwUvByOotwFc7n44ekTSluk5VIr7UGlm0kSgg9Mn2OqSy+KZDi0isiPj4BpZvJ/dttJY5HLI7+GVkGqtM9jrCAo@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKV90U4MbEpdQFkBwR7XW8Ybsel5wFRry1WU4gOI1O2NlW3D/XN
 jgxAg8RQMyU+NgtsduvQxjJc78RxUa1d+3xzpgVI81DVU2IsEZZSkU5Mua/HHBfcaI8xiWPF5UM
 LjfyzY7A31OcYGr9UjzOxa8KRJ5GlwgRYHS8lc6pKhpv11rBxsbarhoen9PxqyzduvT69
X-Gm-Gg: AYBFou1XQfUPaORk34aoiCe+lucglLXLX+h0EcpS9s40KbPc7dJt1Q3aHzE5iACKWdN
 abraIJiHKLioxAjlEj3IRrI5cipLoIvAvalAbhXWGPSf2lBaaOgyau1Q11Bl0bWMb/6UDHjytID
 RgPvGKUeIS3oHsNFogt0WPmqI/UnF3goW33BKcpjV1oNAmzwDNGDI5t1ziHwZtVrdDWn45z293H
 Z+4gvMdZ8yaOZJ45hlXo/X7NI8jQiymzUQV2aY+RTIBbBR45jbbmvQnxQElJhTcf4eYthZKECO6
 juXPMs5hGSSWZK9RGIv/zTXlbxz/slJw1XEJZvzw07nuRfPhDKv+AaxKOaqzOcCvXScJS9Ar22g
 qRM3/XUPZ7szEX1W8ukOdPsq//am98P9QvMzFIYDJ9UPzIJqt9XBINoMRyUwVTwRtMhoHexvkCh
 rnbhm/M8ewD2m6C+AQRmrVxyv0nAtB3E0TCo6Z+wqmb4px5RxvRIDiBeGHz21jOERND5At2InBy
 IAsyQ5mkXPtCFJWg0HjsUb2QpbZ8A4cugaDP2qJ8GQUecDLwIxHtqOevy7hJGIZXyg7IeGSMeaT
 4FSMkkYTPbu/b0s/1iHr4uZESObUjhGZ8IYx6RWzxfkHrpeiEvQQF4UPO5r1hN4IihlQ6Qv/3PC
 WzThSGqzGkFkfAfHfOAVcbjDQRgppXo727/lEPOanv7b9hyCmYh8KHMOH5cs0SvH38S+XC/ywVn
 6OBIORrpS2Rp1I9Jw=
X-Received: by 2002:a05:600c:6387:b0:4a1:7e77:c382 with SMTP id
 5b1f17b1804b1-4a9660b626fmr136456555e9.5.1793290967993; 
 Thu, 29 Oct 2026 09:22:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80f047bfsm75977695e9.3.2026.10.29.09.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 09:22:47 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 29 Oct 2026 16:22:45 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 22
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: cfb4a164d8c2f37f6f910e0237d470ebd1ee3cdf
X-Gerrit-Comment-Date: Thu, 29 Oct 2026 16:22:45 +0000
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <38679e03c79bea5c00483ad3e2f23bc74da3b4ab-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 1.0 (+)
X-Headers-End: 1xMSty-000000007cq-3oMO
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Implement
 sending/receiving app custom control protocol messages
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 charlie.vigue@openvpn.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 chugly <charlie.vigue@openvpn.com>
Content-Type: multipart/mixed; boundary="===============6163363738645076868=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6163363738645076868==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fRHlmeQvkX0="; charset=UTF-8

--fRHlmeQvkX0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, R=C4=83zvan Cojoca=
ru=2E

Arne Schwabe has posted comments on this change by Arne Schwabe=2E (=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail )

Change subj=
ect: Implement sending/receiving app custom control protocol messages
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 22:

=
(4 comments)

File doc/man-sections/client-options=2Erst:

https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/dc7c4d7b_1b67eba7?usp=3Demail :
P=
S22, Line 443:         as (:code:`A:6`) and the list of configured protocol=
s (e=2Eg=2E
> Still gives `A:6` as an example, but the code sends `6:A` (ss=
l=2E [=E2=80=A6]
Done


File src/openvpn/acc=2Ec:

https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1858/comment/97f92e92_bb769794?usp=3Demail :
PS22, Line =
232:     log_acc_message(c, &buf, payload_len, protocol, flags);
> Should w=
e explicitly check that payloads flagged `6` (`flags & ACC_MESSAGE_FLAGS_BA=
SE64`) are really [=E2=80=A6]
I don't think I want all the extra code here =
to verify all that=2E I will add a note in the management-notes=2Etxt that =
the ACC message might come directly from the peer and that they might not c=
ontain properly encoded base64=2E


https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1858/comment/cbcdb163_dbb20c1f?usp=3Demail :
PS22, Line 250:           =
       const char *msg, bool base64)
> Nit: `msg` shadows the `msg()` macro=
=2E [=E2=80=A6]
renamed it to acc_mesasage_payload


File src/openvpn/manag=
e=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/e95996cb_4c=
f2fd08?usp=3Demail :
PS22, Line 4468:     while ((flag =3D strsep(&encoding=
, ":")))
> Should we reject unknown tokens here rather than sending the mes=
sage as ASCII anyway? [=E2=80=A6]
Yes=2E I added to code to bail out if we =
encounter an unknown flag=2E



-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1858?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
Gerrit-Change-Number:=
 1858
Gerrit-PatchSet: 22
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: chugly <=
charlie=2Evigue@openvpn=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@list=
s=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mail=
box=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Ge=
rrit-Comment-Date: Thu, 29 Oct 2026 16:22:45 +0000
Gerrit-HasComments: Yes
=
Gerrit-Has-Labels: No
Comment-In-Reply-To: R=C4=83zvan Cojocaru <razvanc@ma=
ilbox=2Eorg>

--fRHlmeQvkX0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, R=C4=83zvan Cojocaru=2E </p>
<p>Ar=
ne Schwabe has posted comments on this change by Arne Schwabe=2E</p><p><a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">View Ch=
ange</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>File doc/man-sections/client-options=
=2Erst:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/dc7c4d7b_1b67eba7?usp=3D=
email">Patch Set #22, Line 443:</a> <code style=3D"font-family:monospace,mo=
nospace">        as (:code:`A:6`) and the list of configured protocols (e=
=2Eg=2E</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; marg=
in: 10px 0; padding: 0 10px;">Still gives `A:6` as an example, but the code=
 sends `6:A` (ssl=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/acc=2Ec:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1858/comment/97f92e92_bb769794?usp=3Demail">Patch Set #=
22, Line 232:</a> <code style=3D"font-family:monospace,monospace">    log_a=
cc_message(c, &amp;buf, payload_len, protocol, flags);</code></p><p><blockq=
uote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;=
">Should we explicitly check that payloads flagged `6` (`flags &amp; ACC_ME=
SSAGE_FLAGS_BASE64`) are really [=E2=80=A6]</blockquote></p><p class=3D"blo=
cks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I don&#39;t th=
ink I want all the extra code here to verify all that=2E I will add a note =
in the management-notes=2Etxt that the ACC message might come directly from=
 the peer and that they might not contain properly encoded base64=2E</p></l=
i><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: =
4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/cb=
cdb163_dbb20c1f?usp=3Demail">Patch Set #22, Line 250:</a> <code style=3D"fo=
nt-family:monospace,monospace">                 const char *msg, bool base6=
4)</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 1=
0px 0; padding: 0 10px;">Nit: `msg` shadows the `msg()` macro=2E [=E2=80=A6=
]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-=
wrap: break-word;">renamed it to acc_mesasage_payload</p></li></ul></li><li=
 style=3D"margin: 0; padding: 0;"><p>File src/openvpn/manage=2Ec:</p><ul st=
yle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1858/comment/e95996cb_4cf2fd08?usp=3Demail">Patch Set =
#22, Line 4468:</a> <code style=3D"font-family:monospace,monospace">    whi=
le ((flag =3D strsep(&amp;encoding, &quot;:&quot;)))</code></p><p><blockquo=
te style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">=
Should we reject unknown tokens here rather than sending the message as ASC=
II anyway? [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">Yes=2E I added to code to bail out =
if we encounter an unknown flag=2E</p></li></ul></li></ul><p>To view, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">ch=
ange 1858</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 1858 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 22 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Sc=
hwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;raz=
vanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: chugl=
y &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &=
lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Thu, 29 Oct 2026 16:22:45 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"=
> Comment-In-Reply-To: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; <=
/div>

</body></html>
--fRHlmeQvkX0=--


--===============6163363738645076868==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6163363738645076868==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6163363738645076868==--

