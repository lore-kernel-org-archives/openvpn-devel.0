Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6AD608360B
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=VMGL+9kF;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Crr/vUV0;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=EgcoX0B3;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Wf07JU/+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=jbETRik4rrmsxq3dvxXUL6dbUpxUCwhA/ojKkf+gjLE=; b=VMGL+9kFbrrBS8ZaLconX3ZxbQ
	nSgWMRe57vvpJN4BLgQjUtO/qK0pON5FXFlJ2FwkNSMfBxp7KBFOjwSsr/5h+af7L5jGOWQa/QWYU
	dPfJmR2ZxVgU1eTTnZk8eLRW73RjEjnhm2hm9pG2/uAG4QcKdZtpICYxglMg+32Gw8ig=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNujh-000000002Eq-0RJ8;
	Mon, 02 Nov 2026 16:18:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNujg-000000002Ek-2XmU
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 16:18:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+CEJEEoqma8CMKJKJH2du1eIJpoHqzEi4+JhvulYD1A=; b=Crr/vUV09kPW2kVOi4SD0G9C68
 ZvPhjZf7H0Qh/WZppnSdbPepCI2zBJz3XKwYZ3wCOnTQkgoU5YOVRqBT9Nb9w2Q1T9wXxzRTGl2ZX
 537eBUxYDhiiuiXHkHHWx88IqTm/v3Gml6RYjskBQ79oYLUPy8E7L/KEGQjXH8Qd5eBY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+CEJEEoqma8CMKJKJH2du1eIJpoHqzEi4+JhvulYD1A=; b=EgcoX0B3v6uKfBiqQudlIlUxLD
 PWlhAl5d/d3UEIYYuOoGzQSptUkv7LjMDnmf9kJfOW9pPRk76S4UTIYPETGfBsTaZPm3AW2fTcBGd
 OT7EJ/Vf3n4YWpIx16dYvFMPINd5ni7UXRm6/O8toE5ofeXff59GvUeSLjEw8FdvNc4M=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNujf-000000004mp-49FF for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 16:18:16 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-48e04773687so945698f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 08:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793636289; x=1794241089; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+CEJEEoqma8CMKJKJH2du1eIJpoHqzEi4+JhvulYD1A=;
 b=Wf07JU/+jBTMTWxqE0yhFG0xz3CI/bBrXUA4Q3WvrYxC+r82gZ+Dv4EAvD0PnIj4ST
 SzYnpOC+CchaX49FVvlB9b4eaLfMTG3nPX67k1o7R70PwSxstAr88w5Zv/lrEEHUwoxk
 iiLd8XBgXzS7FmjRYwnyNgWK5kZeLd6oxCF9I7nC7+rq2gUY0MEzyWUr8/Z+4ALdhwwY
 KiKbjDbaUje7812QgqLKN2gn3lL6AwlI90K5I0VLNH5Hx0bveVQ8yZca6By//7yEGru+
 cixhXYmtrEWy8d5iyRwuG8F3A9hfATb007kXTWYwB1OSGBv5iQ4mydSzCjMtardVhymv
 yaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793636289; x=1794241089;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+CEJEEoqma8CMKJKJH2du1eIJpoHqzEi4+JhvulYD1A=;
 b=ymKaHFuU58F9xjacT08iAQWSrOIG+AFwFmQ4jCMhTqTT77Q+sF7KbbJxE2f94tLodp
 h0Ely0VbNKuEBVe6Gl7QVtohM04/XstR85w/5xzTdvDZzarALzzWdsFL2M7ruA+kutpQ
 oOgtrT4BpWgzdwPLlUFszZbckX3gHwBuXUpaU+vwdmKxgEM9wxk3+qwfNdkXYQldN4/K
 tRKKPv1o0ILjAmfHpT+A/WjDXLAtGM6mBlMDLluFhkGTqnLDpm6MBCJLqHvnJqHRGLqY
 t//wpeLOoq8/lGj72x6nNLENXy/QOgZ1DwT1zi3iAa8ZQBfVHLse/jciQ9G6x6mULyjA
 8IZQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxcfqm/X63Py2qFqQnSwqR1m5Q8DgaTbGS1pqOnzYHXEKKJOHPX3dupJZfPgdGWjKcFQjNXug4nNApDQQhP@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/0gMnj2Uv4/LzfqSJSW+t6nju+GjMVmuciCpGnCIqJQ4D9xNlk
 vyzdoefqTIvR/SLd+XyOcVfPGctnxwgZ6pzKnu564bgYUpPAaV4PqPtkQMju9gR8J3qHE2kh6/8
 aNMMomf1vfeZ3pQ7j80lzRCde7dXasB6e8q0WKP32oxjgcMnPrD6xYfIH+BclvArMhtpn3xzwQB
 KUeKfz0w==
X-Gm-Gg: AYBFou2jV3X+hpx8VBBfc1YSgRsra5i/dC6QcZ690mGsXI+hBOTGm+ph9IBUHCYHR/L
 cenIVShsLxwL9HPCNQnDx2YiNa43DmN00ebbregBtZMKp9gAgWXtWciqvYkZrsiaKFR0+a4nopg
 9jX22NROS6h2cd2O7oCg0jaLHllKaPtxOqi8QvW+6vdJS2ftts2ULNmJLUG7gaI1sBnmsrR2A37
 KzSi573Q7cqD+1ydaSZWiZC1yX4xgC9pWbRV0tN3xUg66G4B4HhzuWEvrKGfp6ED5XrmvnHkaAs
 hqVV9/iVtVaTy8/wpaCi2AuBYp3tQnrO5UaAiVCQO4297eLB3SgKKWXO677dhT2DGslB/dbug1Z
 mO1hEzYAgYv01WPvgScY2waWmlEPoPHbUQhL0s0RiRBgdJzl0MRYepsxgN9ao2Vcs2TV9jE79gR
 TVjnaTxYwgcmVf16fDkuVxyzMDrdDE3N/wWXvNjR6waw2YkQ63LQPENfv8/FowTua9cxzh3HMr/
 9WGR4d/24RNz9JYM2TC9ySe0sX9UBJTDTGmmtNlwbqo5a+pUp8WNZR2nMBr7xwwcQe74KiOZtZL
 BxS849Gkcwa4M0U0vJXH5h1Ntv88a5j3OevN3FB9e8DE73ia0y8/5Kse+ocTXQyG0Sjq0uhEn3B
 vECU2i8vpxxAR2b3F+pzGCwV18KPPF+PmrUuu10QC5f1TfJS6Pb99Aqe5FK0ejFH/r1d/gremeE
 Zymr+K+FbDl8fgKGQ=
X-Received: by 2002:a05:6000:2913:b0:48d:f488:f32a with SMTP id
 ffacd0b85a97d-48e6e51837emr23545877f8f.56.1793636288840; 
 Mon, 02 Nov 2026 08:18:08 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm23309096f8f.6.2026.11.02.08.18.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 08:18:07 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 16:18:05 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Ib9164e1c8f5e02a2253bbb3b2363a4f9f31c8bdb
X-Gerrit-Change-Number: 2085
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2085?usp=email>
X-Gerrit-Commit: 15992f390eefad52a497d7de88aa9adc45e75eb9
X-Gerrit-Comment-Date: Mon, 2 Nov 2026 16:18:05 +0000
In-Reply-To: <gerrit.1793619070000.Ib9164e1c8f5e02a2253bbb3b2363a4f9f31c8bdb@gerrit.openvpn.net>
References: <gerrit.1793619070000.Ib9164e1c8f5e02a2253bbb3b2363a4f9f31c8bdb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE5MDcwMDAwLkliOTE2NGUxYzhmNWUwMmEyMjUzYmJiM2IyMzYzYTRmOWYzMWM4YmRiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8c4c50b690ca47f844342bd18a7ff78007767935-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNujf-000000004mp-49FF
Subject: [Openvpn-devel] [S] Change in openvpn[master]: init: check
 parameters for NULL before strlen() in send_cc_message
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
Content-Type: multipart/mixed; boundary="===============7286266236947513687=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7286266236947513687==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="C5SZCS54XAo="; charset=UTF-8

--C5SZCS54XAo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2085?usp=3Demail )

Cha=
nge subject: init: check parameters for NULL before strlen() in send_cc_mes=
sage
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 4: Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2085?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: Ib9164e1c8f5e02a2253bbb3b2363a4f9f31c8bdb
Gerrit-Change-Number: 2085
Ger=
rit-PatchSet: 4
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
=
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer:=
 Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru=
 <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-Comment-Date: Mon, 02 Nov 2026 16:18:05 +0000
Gerrit-HasCo=
mments: No
Gerrit-Has-Labels: Yes

--C5SZCS54XAo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 4:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2085?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2085?=
usp=3Demail">change 2085</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2085?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: Ib9164e1c8f5e02a2253bbb3b2363a4f9f31c8bdb </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2085 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-O=
wner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &l=
t;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Comment-Date: Mon, 02 Nov 2026 16:18:05 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--C5SZCS54XAo=--


--===============7286266236947513687==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7286266236947513687==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7286266236947513687==--

