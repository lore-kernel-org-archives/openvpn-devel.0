Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2DE606A326
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 12:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=kmApec5v;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Op2gRffW;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=LXQN09I6;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Ij3AmHnw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=c8Ke8rzOfjJkd9jnXbmvgWLIKO5h9EdD7twc3AelpUw=; b=kmApec5v62nrBRUJS9RUl6rr0v
	VwqRYDbEgNMMdL5uT0f4bCyF5jJOvZ9oQm3FoWjG6wtvAh1fPSpHoLETyzhNfTYHCL9WdrFrREFit
	JLAA/40z0RBduGdtk9XvHpz+ARkTN5mvpQonI2DunyEuOI0MOEjW8BLE9w7ZkZGq6D6g=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOaDX-000000008Ru-1QJs;
	Wed, 04 Nov 2026 12:35:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOaDV-000000008Rn-2hrm
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 12:35:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SRHrWq9Bf+J9AXAccjQ4uI+dy42pCQ/7E5IhmHKTPns=; b=Op2gRffWmDrvoczsjjSUJuevNw
 vQo3Xl2b0hUwBWz0ERrVQ55nBIt1RufNNZNVLGZbSVQc7H4m1dNw/KHyPhStaye7HWLVFwp9jxV0o
 GL8cXGkUeRJfws+haszNm1rDc3zt2bH6c8VYeEdtAQg1xx+nOtqH4nlrJ8rlex3yDoIc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SRHrWq9Bf+J9AXAccjQ4uI+dy42pCQ/7E5IhmHKTPns=; b=LXQN09I6MR4zBjHqgCqHuxXAeQ
 /Pdi9/SOEhDTq0+Ym+r4GrPUqrEFKvJ9Q/YnDL3k9erVSiabAHIqTBRMidbIZIai7ItkIpb3VVDbR
 vn1ZNJSHOErM5ToYKKZ7czA/y2RB28Fe2Oa2nGcPmoY+Cp6J6ib4/i4nDmTNVonQD2zY=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOaDU-0000000009R-16AJ for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 12:35:49 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a549cd7fd2so5772985e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 04:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793795742; x=1794400542; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SRHrWq9Bf+J9AXAccjQ4uI+dy42pCQ/7E5IhmHKTPns=;
 b=Ij3AmHnw0E4YuBYcLftEVka+Q39THezju2DXwNs4eZJBYv47u/OQR9QsMNYG2q9lod
 zfqYCcmOxFhJCLpqXwG3XnGF46WbHXCPQwzyXtIl9ae3Z3LrOEhnktEZ+kbShaSQiQKh
 4ucT9mPTsLKqGA2PqcavLpwFf+POLg9EHACUc2sxHjdbTACtU/6uclqWhQAHM1OFToK+
 mPI6xX0u4fERqKyDnhqBupI3E2eNUJ1Mx3o0tm5Fv2vzpzr7SiCQqmUpVgDy4QhVvk+B
 398OzI/RNOEQADUdkY7Zcf5VLVPqVU0/ETiUnNuMclL+HwKljr1GKL9NXWX6S5SqWeat
 7R8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793795742; x=1794400542;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=SRHrWq9Bf+J9AXAccjQ4uI+dy42pCQ/7E5IhmHKTPns=;
 b=X89Lmg32l3XSAJvRu7wkFs6Hc4L7thowIB75rFwzrn0Ea1aPmra5N/fRy9ErQ24hPf
 D6pKYAif8w/aZC6sv9Ql8DxHx2lM7jGoAfCL9Wy9dsidA8ceokoRFgcbiTlX0tUCI/XN
 V5s3tC1FZAXTSzLza7zVieq5SZyf/c709fs91Xs9i79XS1LpnGchOSEWpqMI1QAeO9MO
 IUlB6t9KjNc79sTAVH42V6gPsgIJ3iJE12NMhtqTiHfl6i9ZjTOtq5T+R6tgj6g9inIa
 4twr7SKYFzMd0ik2O2nd+a00+trNXgmrlGNOqCfx1fVXLDMsF351Z198GGcXs8E/yNPW
 oC7w==
X-Forwarded-Encrypted: i=1;
 AKwUvByjnF3qXxxkSFqagpsUGhUsNjMtYrkmAIcR3H8freD6A7Xn0+NU/8wmY41QcvFo57iW4obL6Ey/cKD55/cG@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/Z2u3q6Q0Ez/sooLXDisqlX8d7hpNi2gf7BIVJDvb572O0GV0L
 Y7kcUp05MmLUrCuhcWWXnMF1wF0Muw+I8wTo24iojpcTw8WBFiXyt3mKkmbQTWMTT9gzCCLpazF
 HGT2AvDWh5IlAJ2SOBMXppk+jfNa3mpzTWPr8LZ8unKcEepma7NF20n9hamE9ev9quZ4n
X-Gm-Gg: AYBFou29b/nC0qsbNr8L/AE8oAkzM69EVywSLVbek4P4YoMjMkuxALXWdrsrTnUQp7l
 NqA85ACJaNbb/perFOOP94DdzymxdpvrY2/HwN8i40Tqstnxu8UwwkRVr76TDwkmvPKOSUhkdE+
 lAw+GWEn6ZJ7e8seI5yugmRXZGrYPUrCrx8ootZ78GktGqz8OmrY/4Udt0efIgBAXYenFWScgY8
 rwgI3rCFTW1XIKmiFerbkwCAWA96+lCaIRLNEkXimEaKWG04GU8taE+wQpBkibD8BgAdrxdI5II
 CPH7dJem6e/FPgeSM1ZzEFwtX54/bnWAW0Y9uD18cwWrEl0U6KpPH8VxvZO5F+QrNO4Yi81JpKo
 xo9+8sfhGLXENQB6IE3abKB+7D/xMKHn+9xTDZofmmSE70caaohF6+8vBiaq6v6m9ExI1DRAZv4
 S6AJNGFde+qbhJ0wn1IVdP9D5AMAculM8dULnCOZsRwT0R5TCFsTHv6HwDyRsDNigQaUeF2+oTV
 /gZ0C9OSia5s4D99auGPRwIYePdq5w4iJIFSSwMIBcIJbfTlRDZv+ABIEshyPAL6bCzBDzYjWA1
 wWOJpX53H+HKcsLr1eCnGWYbY/wRz6Bnfro1azj1su1Js8UyfTZSo6Fqthe2QHcJjdC4K14U+Rx
 ZApZqr8Gj1sugh2Z2wvYn1bilL9tIXVrhpcBLwwFdGQPPd2vUNuheVM45RkysSepP1yGq1IM0rD
 hsRQrnvnLJO6UxJA==
X-Received: by 2002:a05:600c:37c8:b0:4a2:18c4:61a5 with SMTP id
 5b1f17b1804b1-4ac16acd93cmr371366035e9.6.1793795741519; 
 Wed, 04 Nov 2026 04:35:41 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2ab00ff3dsm250545655e9.14.2026.11.04.04.35.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 04:35:41 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 12:35:39 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I1a36c382af05c8db6d342b9bdfb2dc0aae2d10df
X-Gerrit-Change-Number: 2129
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2129?usp=email>
X-Gerrit-Commit: c4d6d41cbc97ac2f137750aa49d1a77548daebca
X-Gerrit-Comment-Date: Wed, 4 Nov 2026 12:35:39 +0000
In-Reply-To: <gerrit.1793785416000.I1a36c382af05c8db6d342b9bdfb2dc0aae2d10df@gerrit.openvpn.net>
References: <gerrit.1793785416000.I1a36c382af05c8db6d342b9bdfb2dc0aae2d10df@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzg1NDE2MDAwLkkxYTM2YzM4MmFmMDVjOGRiNmQzNDJiOWJkZmIyZGMwYWFlMmQxMGRmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <98397fd18fe8581d232f88e31b1a88a16def25b6-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOaDU-0000000009R-16AJ
Subject: [Openvpn-devel] [S] Change in openvpn[master]: route: remove
 never-returned LR_ERROR
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
Content-Type: multipart/mixed; boundary="===============5269397353880017085=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5269397353880017085==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1L7+6NRGkpU="; charset=UTF-8

--1L7+6NRGkpU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2129?usp=3Demail )

Cha=
nge subject: route: remove never-returned LR_ERROR
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To =
view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2129?usp=3Demail
To =
unsubscribe, or for help writing mail filters, visit https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: =
openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1a36c382af05c8db6d342b9bdf=
b2dc0aae2d10df
Gerrit-Change-Number: 2129
Gerrit-PatchSet: 1
Gerrit-Owner: =
R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lich=
tenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerr=
it-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date=
: Wed, 04 Nov 2026 12:35:39 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels:=
 Yes

--1L7+6NRGkpU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2129?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2129?=
usp=3Demail">change 2129</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2129?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: I1a36c382af05c8db6d342b9bdfb2dc0aae2d10df </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2129 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 1 </div>
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
"display:none"> Gerrit-Comment-Date: Wed, 04 Nov 2026 12:35:39 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--1L7+6NRGkpU=--


--===============5269397353880017085==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5269397353880017085==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5269397353880017085==--

