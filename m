Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8B5606A326
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 12:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=TGJgJsTU;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=YSvvXQXy;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bPeaF7MY;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=MRz6tZ5R
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=oX3a4b+/VpAr08qT7ekPOXXJqkxhK0TGRJ7GLPCAh98=; b=TGJgJsTUohR98UwKDEFKvIRA2/
	/eYHrJ2Kk8TzAle3vNZpt9nWQavbm74LHxbYalHeX0FkLky1YMWZcmv0GcPNmk6cF0a0yiZjW0M02
	WDOApm+IX1krdYfDe9HoRw5r1eTmBzM6QCNoBnAqe1VGoAZ/xvblRRjHL7FLjtJkJzs4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xODTB-000000000JG-171y;
	Tue, 03 Nov 2026 12:18:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xODT4-000000000Ie-0GyB
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 12:18:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PT1nEGebz8CIVHcYaVlqBcJtt8IByqseDHW1F1KSPKc=; b=YSvvXQXyJBvUrlQ2NhO6p0lUqX
 QmfSswAqNgfmgDQQMZ0A+zqFFRqCEFoVnPEtDmmQqY6+gxa+BctRBABbdgWsWrnYecsCD7oV8XXu+
 czGG+zDJn4gUSWh+u9383OshlreAwSV4KJy01jH8By//52nHHs68C8OHkAkROsCSmLuw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PT1nEGebz8CIVHcYaVlqBcJtt8IByqseDHW1F1KSPKc=; b=bPeaF7MYQn6u30X0cQJkJ27TyE
 qLC6dZMNyvZyZPLCMGyn6ikGIDw04Q3NiqgD/iXivA69JmA0YKreRtK4OlKWYn/8oByY1p26XpPDU
 b9SeYVWd4j9xDijWpHCAJxIaycWMVJ09arXY2nk/6xcjCxtmRHtKavJpjTair7HKFPAA=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xODT2-000000001lp-3vNB for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 12:18:21 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so26638555e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 04:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793708294; x=1794313094; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PT1nEGebz8CIVHcYaVlqBcJtt8IByqseDHW1F1KSPKc=;
 b=MRz6tZ5RBoy71oke4ybFJw5bYnEhmjsrGA/c+P0JERXhr78EiKqwi3HedT29BOuaDP
 kjLs6xsJO9BzN/3Fe9p68YPHDF/xna8zpDOtTucTJ78zvTBRkHvpGNBbDwZSf5tWEYH4
 2lmsBSiNGp1FWRECNP/aqOvm0c9USHhpvEOStAjnhOJH2PeCGX78j0YFodEr8Luj/Qkc
 fb3v+O/SsQkUfMuQUgtbfGGmfud8lo+0/9xThs7mlE7FIBHijlTdAQneQ6/gFCQWMsr3
 mNJdKvaxrYpPfHDPzoca8KP2Z83ypfcdY3NEn7kZPAn0utotZ+vRwpvCNMCZATjiRwEA
 opOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793708294; x=1794313094;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=PT1nEGebz8CIVHcYaVlqBcJtt8IByqseDHW1F1KSPKc=;
 b=lQRy1tJpGkKbUunSw28iBZumRUtmtkSvzuL45GYwq81PiitnDvLyLr3qCp8aGjxs2C
 w6J8gzbYwbPAWUpJm7Cv2Uwp78DUUBPXRIz8D7AUoUp/OWJH1tXmpv+B0rsnKQHws144
 pxwBSwC4TPpeNKQLykv88L0p5LP6c2Rz5OmchZlZSb+cs2nahe+HfjL0FSMhAyGZokMz
 NIVsGjC86Fgzes0E5pd82NKZ2qYoL3u5Z6DDz7Z0mfzPKVCxjQTe/0nNlIyBbuUjkaI5
 cLCHem+3+i43fDjk2IKMbo6brz2dUEwtLvDTO8phSfOmbAqvxU1qepdYdk8FBL+SM9km
 Lzsg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzSbpX36w+6O6LU9N4L/ZVFQghELc0lBAIOw2L0kGShnou6AVa/EA+eUQSG2qSiBp3M1kkmxviT+kbCnDA6@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8CToJ+Frm6ECjfOIcx1Eoyo/q0PyIPPnS6bgkDk5mcN5QyGDgI
 YKepZZ4z3Ku7gtKQIrt7g66t69oVHnC5RcYlSbgNYlyuCdCtvoKYPUYeOnNEMTnv6NPp1YzugGj
 jWpLi3EO7sm7JEFkqQrVXuHvisdF5J1RdwkCnggCqEXc1GTv5+JAM4xYAlmYK+MarhAhW
X-Gm-Gg: AYBFou2Txa0j/BFyw/Ev2JfXhd6rlDOy0kLHAx3/PSwEx+3fPrAlOXgMEOLRThxcjLa
 drd7qfyZRVGF260fXT1A/dW56zNPVINGmjXvtREFRAvM42Hxp64DcahhzgLMukkFyHdYlgNDJ2E
 AWojJEYaCE0Lmhe53q9GrgcTlWjA9AWdpt6KW+UtbUuSGU2nWkbCYwNQ9RbgiSBlWW1I82m4Jn9
 uJp8NBYDH8HR7oM8rUikajki6/XSBHE1YMPxGr0BpIqQQajze+V0rqXQf/e1Qnf5oFnKesXiTY2
 VDvco9iB9Ie1yrqzCg3yoT0QGLXbC16pPFuhnz1AwB15mcQKp7mIqfbwKXmO7OiGqynYIazUv+U
 wwY+mR6Cf0BnSOwH0MFbUWnuDAeI74nLSl7yAcgWxsjN4Op4AgDkHgvhYXwwX2isIjH1eCKKjRP
 N3jXjZdFXcfQGnSM7ylr/fk+blidK+q63hXMaRFCnyZYI2kLq61T2QrdctYLzOUi74ye39cJw0g
 av+pyhlAsFpDXUjxzYZmwyQlJOTkiJAS3gD4xdLzC7ebBsy+Kg4ihIjZiRUCb4Z9JPOjW99Gynp
 BZv9TMPUy465X6Gm4Q8wMqAEqtXs2qiXILxdB4GhQJQDLkSsCuB6N25Uw4bFAVgJ+l3Z1nouYax
 /paVEuBYgs4NzMA2AneiDb5GezONUNCCaZEVlZ0XkycVcuNWV50NMOta3MZ8oHUcylNCc6gEg1r
 c+3yF2ZkNYAl4GfLsmkK/nW6YPe+GTUsVUfbE=
X-Received: by 2002:a05:600c:8b55:b0:4a2:1655:87e2 with SMTP id
 5b1f17b1804b1-4ac17b2b023mr316343955e9.19.1793708294223; 
 Tue, 03 Nov 2026 04:18:14 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a9bd5d9fsm51606405e9.15.2026.11.03.04.18.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 04:18:13 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 12:18:12 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iad78e78cf51812c392f53cd58b33b54cb99cc6a8
X-Gerrit-Change-Number: 2097
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2097?usp=email>
X-Gerrit-Commit: 7aadd396e305f8cc1b26497066b6601385a62b1f
X-Gerrit-Comment-Date: Tue, 3 Nov 2026 12:18:12 +0000
In-Reply-To: <gerrit.1793686207000.Iad78e78cf51812c392f53cd58b33b54cb99cc6a8@gerrit.openvpn.net>
References: <gerrit.1793686207000.Iad78e78cf51812c392f53cd58b33b54cb99cc6a8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjg2MjA3MDAwLklhZDc4ZTc4Y2Y1MTgxMmMzOTJmNTNjZDU4YjMzYjU0Y2I5OWNjNmE4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <429659917ac32bdf38312f5a94b4ab79f024a831-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xODT2-000000001lp-3vNB
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: console_systemd:
 free argv when openvpn_popen() fails
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
Content-Type: multipart/mixed; boundary="===============4987234761769541385=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4987234761769541385==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HXZyfTYGP1U="; charset=UTF-8

--HXZyfTYGP1U=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2097?usp=3Demail )

Cha=
nge subject: console_systemd: free argv when openvpn_popen() fails
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-=
Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/20=
97?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: commen=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iad78e78c=
f51812c392f53cd58b33b54cb99cc6a8
Gerrit-Change-Number: 2097
Gerrit-PatchSet=
: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Revie=
wer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Licht=
enheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@ma=
ilbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Comment-Date: Tue, 03 Nov 2026 12:18:12 +0000
Gerrit-HasComments: No
G=
errit-Has-Labels: Yes

--HXZyfTYGP1U=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2097?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2097?=
usp=3Demail">change 2097</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2097?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: Iad78e78cf51812c392f53cd58b33b54cb99cc6a8 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2097 </div>
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
"display:none"> Gerrit-Comment-Date: Tue, 03 Nov 2026 12:18:12 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--HXZyfTYGP1U=--


--===============4987234761769541385==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4987234761769541385==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4987234761769541385==--

