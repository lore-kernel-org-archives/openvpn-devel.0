Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DD3606A329
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=dDifgpja;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=aFdVy/sk;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=lYnBNLs9;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ER0yeoG2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=nU+kqiW0s4FwM1CJ53sBz/u1OwLfVhamPipLpNnjABU=; b=dDifgpjaXpiADc/yWOnF1PpVHw
	EcMO2URub9nOWXm59Sv5pCkZFa7sOkkB0FTm/1cygLq8WaCcVdhpIL5ydCetFNDmqtt/P68mp7QKs
	ZMHf1yQ5V0xQqDdeaaQlEflJgP/04RWErZAOy1gF8zSlkNGyDtB4IIPrA/kvR/AhVtD8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNsCw-000000004IH-40fx;
	Mon, 02 Nov 2026 13:36:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNsCv-000000004IA-02Q4
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 13:36:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PRq+INv8upKs3pFlrGsKb2dSw33vvodL5suN5SR7bSk=; b=aFdVy/skr5N4fzDzr1kumkJM1G
 YcJyjer883KNaN5MNzby3BFJur0OA4KOnCM+cAqwnAzjBBSMmrm5e1Fg13HcMvMC3Mj4oss4X+3Or
 k/m5YrRuZrBzz5ZQ3wA3cruPk+cEvjCzzWXD+LAhEH+3wXwD2/II9mRWQnuwppqINGko=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PRq+INv8upKs3pFlrGsKb2dSw33vvodL5suN5SR7bSk=; b=lYnBNLs9Dw8e7++rVKB1iTuFfV
 bL01qCpEpMaNb0naIghl+hpmHO8X02VWcWQlfzgi6UMV/exuzr6Hn7eIj1nta+k9FoyaZVGzis+3C
 hpmjL7ZvPeoRf4bdtwXsmlz4KoMtqTzDultkgJoTNo/EOIKt13pBeL3Ymo1efD7OASek=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNsCt-000000000Ew-2PbG for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 13:36:16 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a5036bbac7so18175055e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 05:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793626569; x=1794231369; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PRq+INv8upKs3pFlrGsKb2dSw33vvodL5suN5SR7bSk=;
 b=ER0yeoG2BPmhrpKYBhUlFupqCkdTJ1k8uVGybx7LdJ1PZ2bd1ijbMn4vZZjjpyFkTo
 i0Ctf9TRzKyJ/UB4thZb+5rp3E+xOBUkMVXFY0u1gZgwOUC5tw/kQPr3I6XGh/dH+mw5
 lNJzTQyNdh/G58vRo9+ZFr6vR8+NIqzC1zj6Vtyq1UZdytHJQUuUF4ND26CkwgQfH+s/
 zh3VoqpRvY5xT5GJnwBSKO7hG/m3PlX4f5wQjlk7EZw6bdZ6fkcFelcJUI+yD71qtLA8
 AaLpM6tc/5Y+XRMIehHCdplYNGGoTJn07Sv/PiWQ8MW+ixIG6IwjMhSbIDd02Kb0y+na
 v20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626569; x=1794231369;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=PRq+INv8upKs3pFlrGsKb2dSw33vvodL5suN5SR7bSk=;
 b=INOoQyHcHTtylQyZCtV1E4e7fo+6SvkeV4bskneXYBk9Gs98XUHA/fIod+z67Bo6lQ
 4fCi3+zI+Acaf1c3ZgS1DdY8uugI/59AnIKx6+xEdeUOpcG0aXfHgawFHtIBa1emPLfv
 o9ddf8Q58lY/ZR/RoUB583Q1aXIDXvFH6Gpds51eqIakQ7MKghdhP/7xMA4/X010vXL7
 H0T+vQjomLhxqdM92fi3zCSSadv0Fwa38/YfGzvIIY47wRzt23ikgTF09rDc6v8bDcKW
 nL6xXiskBdETORWrQ7Wn79yYFLeCv7tcpXiM9ja1ca+YAckmmjaEIcPpKhGt1grDP0J0
 oNeg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxt7wGAL0hXB3AB3bjdSla60wJHcdfARvTswN3/DHmPIbZwVe+vKlU1+1qf/B0zpK1hG/8hO0Orp1J7QrPD@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLSKvZvqWW4+eE/2qjJday7b5ec+P97VCO7gec1xlqLsNebZHkC
 Lte7sFiAXsoWtFA6i/47O7T+5hZ/KiePx7xX2rSX5jlmZ52XzmFSOjaWilzQk4+Jo0ytKM7OVZg
 1eGnSKriM5CSSfJPXtodtbWGo1sHQkViToVx0oTvjwUizS1ZaH6K9xrNmSiQyKeaEcQqL
X-Gm-Gg: AYBFou3nbJ9f3SqwFNub5E2AqQbtMuB0Hn8kK1QfV7v8QsXMnbycFql9lUt6/9fQFpe
 ouC3GrGkWcQSVlsr4SBpjBSi3UK7HxkOzPB/jFyJbA/0GptcZFZ/IHZoKo2fhbAL8Twy5qBbn8R
 DZw4hDyPRDHXl5OfxMMMIGPfOY9Ego3KRdKDj46Kv/q5Qm6krsgv79xy4htmCCoUmmdKg3eeo/M
 4vzfF4wpKq5mL39Q6Qmh0ZcxtGbgGqJ6n77+3DYqTfhpCul/s2jpQm7R6okH4kKuGDdmHz3pD/j
 ql01TMjE/VDYHui89vVOYDKBYlQe/tokX8dvwTXM+Duvk0arGTBEEgHQ+vmIyTKdDZWbLynN1en
 udlhda+4bojgef1xysE/7CRuPfdiSi14+HUVWcy1mqEgUuc+X3F0L3FJx2nuQKVxkjzTZsPMoQE
 J/izZqgcz7KZtoq/eYAJNCL98rgJ20PgcdrwHAMYV+NVaxkBh+baTL0AxOF5x9Nvr4Ei+jPiO1H
 THT9NUy+3gu0bRQ1/l4hMwB8aWCHkLY50/KsuZTJbsEKWCdE9kciufWOPoXcZPYIJbtO/FDy0C5
 j5jWlWEdflurvjcFtlJ83+xhNN27fKths/oLg5BiYLEEOq9ZrMh/K0mtemyQxQ/e0k6kAZ7wugM
 towMybKxc/x0f3Hun5cmefBl2c+K82X+XJiXTSZFx6cyVJkzInW+nf/z8rGQoEYx/3SCtvkS1CE
 iHuawnWAC8j7jsoQ==
X-Received: by 2002:a05:600c:3ba0:b0:4a1:e0db:8cf8 with SMTP id
 5b1f17b1804b1-4ac151a84f0mr227019495e9.3.1793626568775; 
 Mon, 02 Nov 2026 05:36:08 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abe77053fesm125737285e9.0.2026.11.02.05.36.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:36:08 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 13:36:06 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 13
X-Gerrit-Change-Id: I42d8785959c24bf688190965e58b9b98251b8557
X-Gerrit-Change-Number: 1856
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1856?usp=email>
X-Gerrit-Commit: 05214690e06dd7da0350e34e5ed43bd72c505040
X-Gerrit-Comment-Date: Mon, 2 Nov 2026 13:36:06 +0000
In-Reply-To: <gerrit.1787327336000.I42d8785959c24bf688190965e58b9b98251b8557@gerrit.openvpn.net>
References: <gerrit.1787327336000.I42d8785959c24bf688190965e58b9b98251b8557@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0MmQ4Nzg1OTU5YzI0YmY2ODgxOTA5NjVlNThiOWI5ODI1MWI4NTU3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <62f80e340f32af15d7fe39348a01c2fdeefd7394-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNsCt-000000000Ew-2PbG
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Introduce
 get_key_by_management_key_id helper function
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7542934446570619244=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7542934446570619244==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8Av6PnL0G34="; charset=UTF-8

--8Av6PnL0G34=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Arne Schwabe=2E (=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1856?usp=3Demail )

Change subj=
ect: Introduce get_key_by_management_key_id helper function
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 13: Code-Review+2=



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1856?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I42d8785959c24b=
f688190965e58b9b98251b8557
Gerrit-Change-Number: 1856
Gerrit-PatchSet: 13
G=
errit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Fra=
nk Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojoc=
aru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerri=
t-Comment-Date: Mon, 02 Nov 2026 13:36:06 +0000
Gerrit-HasComments: No
Gerr=
it-Has-Labels: Yes

--8Av6PnL0G34=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Arne Schwabe=2E</p><p>Patc=
h set 13:<span style=3D"border-radius: 3px; display: inline-block; margin: =
0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1856?usp=3Demail">Vi=
ew Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To vie=
w, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1856?usp=3De=
mail">change 1856</a>=2E To unsubscribe, or for help writing mail filters, =
visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setti=
ngs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActi=
on"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1856?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<=
div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"di=
splay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerr=
it-Change-Id: I42d8785959c24bf688190965e58b9b98251b8557 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1856 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 13 </div>
<div style=3D"display:none"> Gerrit-Owner=
: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocar=
u &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-=
CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Fra=
nk Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display=
:none"> Gerrit-Comment-Date: Mon, 02 Nov 2026 13:36:06 +0000 </div>
<div st=
yle=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:n=
one"> Gerrit-Has-Labels: Yes </div>

</body></html>
--8Av6PnL0G34=--


--===============7542934446570619244==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7542934446570619244==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7542934446570619244==--

