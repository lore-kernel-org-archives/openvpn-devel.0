Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2AB7C61DCB
	for <openvpn-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K5pkFTgCF3Fey7EMy09v2QWAo5OAXLnHsFjkkctnf3U=; b=CZrPRx3eS7PDr2El8Hey4R/27z
	EzU1aaSqd8ig9JW0w0byu4gLt+ndim1AFt99SHY1mt1bkhks19xE9nr07jfLM2SXHpVc+6c5BH0bP
	2ujEwi6z66mMpVSYHD7fGwOl7hrz4Hc8W5cKvUSG3uGxD8iB/8LO2LPV1qqfhkrn3FT0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzw2y-0000or-Vc;
	Fri, 28 Aug 2026 12:51:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzw2m-0000oR-C4
 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 12:50:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=LCRblt156g5R9HXbzJvAeUPUWVzNheZ/68zzxEv6qoc=; b=Z0m/MX4Qp0JubqmpGTMkMAb/se
 kD+71Iqo4a9ccjeHiblOYx1+GVMfvACiIRXAyFa21lbYehSknKeDjL0Mz/t4OjQV0Z7iCTD6GVvrm
 EISaA55vvdZMRfzM/ZXLqy39GVzG7tFQxlUOpn0rFhjq/ZaMal8Oa6+Ndv25DpRp5ljY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=LCRblt156g5R9HXbzJvAeUPUWVzNheZ/68zzxEv6qoc=; b=L
 6/3V5jycAaB/WInbTJJRYagVQJ2yMJG2H4PrG8hcGL2tjdNP4t/BL8EhxNR75tLM789Po7rP2TtO+
 Hvo5uv5/CLvIOcAQWCCl32DJRwf+Esc596cEfFMRp1GYlaxAjH2hlp+s6a2RkqYxMwkkDkqwhrcl/
 6G2gUs869o6+ZV6U=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzw2k-0005FP-P0 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 12:50:52 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-49556f97a9dso5917145e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 28 Aug 2026 05:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787921444; x=1788526244; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LCRblt156g5R9HXbzJvAeUPUWVzNheZ/68zzxEv6qoc=;
 b=QvOctFSQfZTePn5ePXlaOQnpsr2wYgmTzET7dit8yyyCDUQiZOLoJQKp6+WTksCJLV
 e1bm4BKw99nYFqEIwJIPLmUxjs2+ItyXydWF5OzL5+HrKEXyLUKhPIwVUIAVdtKdPqsC
 qq7xLCJ8ukbSpA4hDFaGCX0EEWC3xH0TO0gHBZmjT6jeQwbmmXd/AxgFBpSF+9IPc/tN
 sIwVsNKmS8QoYte6p69SqkQCuWUdNcbC+acf25YaoooINFTKYfW9/YkiwYaNwwbsTjx1
 GViYyD8tphSqzGLHvglNup9R3Sq+Djs++6M9WsrkG4aJxO0GQTSXOofFJOrfGG7daZGP
 fTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787921444; x=1788526244;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LCRblt156g5R9HXbzJvAeUPUWVzNheZ/68zzxEv6qoc=;
 b=mLqcQTZ5CWnuIZO/CA66WbDMHz1GetyqPi8p3/SArcME7wITuEDTlURxb56Lf0d2pQ
 dsVnou4uUVBY8SpiJ5tJj7uYSLE/y/mvaSKW3aa5aPLpCczYs6EPHJhiAdnHbr7Bh4bF
 7g8f3y0r7c3XVoFhtwSv9pWKw15hLhcDEwAuRjJ8QOQk1dSdcehCmYxFWzQRNTm69VNJ
 oEvorowOxcIhWV+UVDwQdjei6Ds9IJZ9SVLxm0ialqQWsEj+XW62avQ7QiWW+lR6gMmh
 /zo2gCkU9xorWLb1nI2Q7SmZp3y4YX6h3NdzKC4kl92U2cjOYxzD2ajzZ+VJBmjxxXfB
 ltew==
X-Forwarded-Encrypted: i=1;
 AHgh+RpwBJDG2Cd58rkEqHdQXv9mfu+zIHbl3gvDgm+yioIF+TPrZXJAyiQXDphfzUgYKayhNfSrdfFZQbMuXZGV@lists.sourceforge.net
X-Gm-Message-State: AFuF++lV5ojs74lhAfsQUNX7oUufpt0AUmbbSslQNlTQO2GuBStkyhS7
 lg43G15Z2XBDEsW7hafj3i31MlG2pjEVynKfrdYnz+WmT8ufT+O2ToRHqaTOmAbvPXnKJmtCs3k
 qH0EHkfZm6XMnlr0wveWV6IKBcUqC43iN23Trn44eRfh8blMRTvQJ9UKw6PSFVznlhvDDRGUyaH
 ZMJnF+Hw==
X-Gm-Gg: AR+sD12o4IToe8nogmHC67iiV3nmNwARNpI4ikEdT1FrysUA9aeTaGmCgfdidwXv4YC
 ZjMylAXp0y/iGkRiU+LjCPOY9tnm3eaJCjK3pMBilFEDIerrnYg5EgudxRPqixE59h+C2GvJJc3
 h1qOAHzr60dGj2jsVx7rAIUUz70MsfJHtE83zoOlekmZPm0r2bZG5J5yOOXhjeOP2KaNDlkJjQK
 oDSNvbJnGMOS1JXxRo3wBa5+UDPH/Y7LgPAdGGC3S2Hp/qQeHdnWWHSxYY7Ku2Ax5pbl3NRuB2s
 w76f52lZQvF1qUgyYu0/oTuakvOwWS3qFdsXUCutzjFfNUWzovxrSKiXh8P9FwD/lzyRpRpLoc7
 J5wfDvZoFX/WCswQWMiCWQfQi1UJ/2BX0atgMXKCrPlzAJ/CNy+vcNUsRF0OxQwlcjVr96Movyz
 qHGODAyIN2o21B9eCjnRsWwQE54tbMOy8ChmOXP8lZnjJhX5DcYxpNxP6JjPb1Q3G9PDFFwSllA
 1NPHgVbhlFrShoEIktgkdlJ5Pf3bYHO//mOjOd8NzzMFyMpBbLAf63JE+znwgqyPOXz6imZ7c/S
 rQ9OXFkouZp5S7v1TglHnck4u9V3B2Tqla3NhrWbiPQJQTqmvtI=
X-Received: by 2002:a05:600c:4ecb:b0:499:d95a:44d with SMTP id
 5b1f17b1804b1-49b91bd885fmr102840975e9.0.1787921443820; 
 Fri, 28 Aug 2026 05:50:43 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbac8e61sm3951331f8f.13.2026.08.28.05.50.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 05:50:43 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 28 Aug 2026 12:50:42 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I694410615958afbb422d9ead71f04c1a60edc640
X-Gerrit-Change-Number: 1849
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1849?usp=email>
X-Gerrit-Commit: 63603d64043f4ffc0761d964988ccddc36772709
X-Gerrit-Comment-Date: Fri, 28 Aug 2026 12:50:42 +0000
In-Reply-To: <gerrit.1787150248000.I694410615958afbb422d9ead71f04c1a60edc640@gerrit.openvpn.net>
References: <gerrit.1787150248000.I694410615958afbb422d9ead71f04c1a60edc640@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MTUwMjQ4MDAwLkk2OTQ0MTA2MTU5NThhZmJiNDIyZDllYWQ3MWYwNGMxYTYwZWRjNjQwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <827766ffa086afcda8410130346bf6ddf28daebc-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzw2k-0005FP-P0
Subject: [Openvpn-devel] [S] Change in openvpn[master]: mbedtls: Work-around
 bug in mbedtls 4.1.0 and 4.2.0
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
 openvpn-devel@lists.sourceforge.net, max@max-fillinger.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>, MaxF <max@max-fillinger.net>
Content-Type: multipart/mixed; boundary="===============7174473477228383318=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7174473477228383318==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3lGcLqgS/Gg="; charset=UTF-8

--3lGcLqgS/Gg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, plaisthos, razvanc=2E

flichten=
held has posted comments on this change by flichtenheld=2E ( http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1849?usp=3Demail )

Change subject: mbedtls: W=
ork-around bug in mbedtls 4=2E1=2E0 and 4=2E2=2E0
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment)

File src/=
openvpn/mbedtls_compat=2Eh:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1849=
/comment/c1453d20_61b493b0?usp=3Demail :
PS1, Line 240:                    =
                          (size_t *)&prv->MBEDTLS_PRIVATE(pub_raw_len))));
=
> If I understand it correctly, we'll only need to do this for versions 4=
=2E1 and 4=2E2=2E0=2E [=E2=80=A6]
Done



-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1849?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: I694410615958afbb422d9ead71f04c1a60edc640
Gerrit-Chang=
e-Number: 1849
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@lichten=
held=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
CC: MaxF <max@max-fillinger=2Enet>
Gerrit-CC: openvpn-devel <openvpn-devel@=
lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerri=
t-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: razva=
nc <razvanc@mailbox=2Eorg>
Gerrit-Attention: MaxF <max@max-fillinger=2Enet>=

Gerrit-Comment-Date: Fri, 28 Aug 2026 12:50:42 +0000
Gerrit-HasComments: Y=
es
Gerrit-Has-Labels: No
Comment-In-Reply-To: razvanc <razvanc@mailbox=2Eor=
g>
Comment-In-Reply-To: MaxF <max@max-fillinger=2Enet>

--3lGcLqgS/Gg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF, plaisthos, razvanc=2E </p>
<p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1849?usp=3Demail">View Change</a></p><p=
>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>File src/openvpn/mbedtls_compat=2Eh:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1849/comment/c1453d20_61b493b0?usp=3Demail">Patch Set #1=
, Line 240:</a> <code style=3D"font-family:monospace,monospace">           =
                                  (size_t *)&amp;prv-&gt;MBEDTLS_PRIVATE(pu=
b_raw_len))));</code></p><p><blockquote style=3D"border-left: 1px solid #aa=
a; margin: 10px 0; padding: 0 10px;">If I understand it correctly, we&#39;l=
l only need to do this for versions 4=2E1 and 4=2E2=2E0=2E [=E2=80=A6]</blo=
ckquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: =
break-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1849?usp=3Demail">change 1849</a>=2E T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscop=
e itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" =
href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1849?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"disp=
lay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I694410615958a=
fbb422d9ead71f04c1a60edc640 </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 1849 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </di=
v>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichte=
nheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaist=
hos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2En=
et&gt; </div>
<div style=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@m=
ailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: MaxF &lt;max@max-fillinger=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 28 Aug 2026 12=
:50:42 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </=
div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=
=3D"display:none"> Comment-In-Reply-To: razvanc &lt;razvanc@mailbox=2Eorg&g=
t; </div>
<div style=3D"display:none"> Comment-In-Reply-To: MaxF &lt;max@ma=
x-fillinger=2Enet&gt; </div>

</body></html>
--3lGcLqgS/Gg=--


--===============7174473477228383318==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7174473477228383318==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7174473477228383318==--

