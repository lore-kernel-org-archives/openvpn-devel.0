Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9743E606A333
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 12:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=RehRk0xh;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=mRldQmIv;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=eOSFQigK;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=JzjI9VBJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=cdm1TWUmHN/vMwjWFBkfXISk3/4TVwQxqNm47FT8n5E=; b=RehRk0xh7bep0J7kKaSSh+1XRs
	HSATInfAk9e0Aa1GyaT2xFHuJBDCc/Ls6w973VgscvkxDnZcMRGB8HDhBHtzWE5num+u9GsRQVRMO
	JF8Zfu3O4W3rB69gBS7DSn4Q874aCAtm2f24cby9UC0Bt61RyiiCP2RAm2AMbAnRjmOI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOZun-000000003HN-0w4r;
	Wed, 04 Nov 2026 12:16:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOZuk-000000003HG-3kXX
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 12:16:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=I9asOROAjQwrhZdXlbIi1dF8Rhz92bFjb5d9DwMVjPU=; b=mRldQmIvM8okKXpace9mPn9pYJ
 nruMrNSgG+lXJ7J7ewfpQGeEQfGWcf1sE22VY7s5C18IqbbdetOc2p3y9xj+3eXAsc01Wj4S78dE2
 Qk9Il+xU3YgBd8UvVxaKGTZlfZUPVrItLhJL3RjlFC7UbrFnTqRcx1DIYaSiHNwLh/jM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=I9asOROAjQwrhZdXlbIi1dF8Rhz92bFjb5d9DwMVjPU=; b=eOSFQigKqKhSNOsmLzHw4x7ZV0
 2+RKAHpIdOPSs3648KqgqZyD58a/kgQ7AymxT7AGpDcVmSSGDGpcr7I2SHIW/mMst0zgg26CEYrQx
 QGaLJUj3nWc8uqkKbpQh7sysDVmDlvLpOa/FDrmRo6fYjCX9iydk4+Qp7GGN6JzTfnqI=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOZuj-000000007zP-2ziu for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 12:16:26 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-48afbd2c386so439840f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 04:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793794579; x=1794399379; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=I9asOROAjQwrhZdXlbIi1dF8Rhz92bFjb5d9DwMVjPU=;
 b=JzjI9VBJUuw3I0KBdlPTHOj0tmV+8KcjToU2rKCIcEhU1MUzeKWHx48afOT7a3DYLL
 XCG5ktMFPxq7OTlgidwtqLtAgG03ybuzFPDwkxoI0P5FLyo2zIdpt2TGLcey3CI+N0IB
 pbYQ8LEWz7kNi+IdIbByRiTqAqd/nwxYjH+xCrE1mSwx5GK1iM2Dj3iWCk+FGnLZq6I0
 KXvxaR8SVvpXEHeX1bpTMNchNMMSQzoJgYsztee2++h3psFn5qxZ3kA/pqM2NccmFn30
 kzQk2nD9Hy/53VshYrPW8dVbwdPHNCHjetWic3pg5sdCpkbBtJqc1ynaEL0g/xou7YR8
 9XmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793794579; x=1794399379;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=I9asOROAjQwrhZdXlbIi1dF8Rhz92bFjb5d9DwMVjPU=;
 b=p2Y5O8nvwhB0h4ZFu7e91h2a+kLho++3SnlohwqTibHJ8VGes+2sTUYda5QMG2ama1
 ZpYMpI/jnp75gRJ1a6GXWLaCu3gfWq8sElqA7LbVbmDDp8CT0x1CUhq9P563H6r6h9nU
 I07FB3AOffQjytT+0OBNbpVVZti/PmYnNyw6+i18Gee25CvPHgB2kU/wUIDVOTtV9jZL
 iE5YdmItDtapys7IZMlCl5agatSxjdHc0b0+88kUXtIL3ZfZeTRdRD0Pknlz6dGmAJli
 /qRqU5G+K8STxab7CGzThpSN76uYgcAmh31BHYwHAznDk8cKsFjsvYf5Op3xxYx2QSfQ
 Es1Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzd8p1rvZd8LExrXtIJhk2dCLGYGaLzfUpqZbCyH/IA9bNaJmSTusOlabcE5b+lPu3p85qb+nfWY3hnH6+c@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8vuLNBQQc4M1nvUFKBPl1HduUmPZPmBElJyQzzzOfKNWkyBNfm
 PJkDZ11lDoyBkWOxkmWlHOu2+dh2hCzAO26TFBWkTjHDi8fbyEFNp0+edjPjKy8KSxcPg+l4Ful
 ZzqZt9fXyh/ESoaRLo/wOuwUwn8cfw+8tHQTyASiS0+RGh0uXtbLkgO9JXejxujuoqFHcoRHoOc
 +2Tmqu3Q==
X-Gm-Gg: AYBFou2LVVaAJm4gJygrM/hGeqKeH7cPmEUdgn84pxfcsI8fV2WlhCczI3AvvwDlfV0
 XLKT40GGKBJlS6zBjim2tjc7qkNtWPBy+U7RjcgYkGde5Ix93cOv6Rn0Y9Oe7XdndVvJcthdAaI
 rKzGg7FiLrBHweruLP6n6bLBGYwP65FE+lS9+SJEESkxZ/O8Jtk9kC5eWrM3E9Zkls+TuY4TAo0
 J4OXlSiwz2uhiGNKGCbimYv2ODDTEdkf8KEfY+Fwsn0wKTKVDyggdNMAoU3qjHXfoE5mdZLguqz
 INbJ86q940A34tLdl3b5db0D8ITwofA8IBcCX/3FGDMQD9c+cdZzZmgjcb6sb4zybCdjCeq+46E
 cBFId/XgiCXfpK3R2v0ZN0qbxh0iNbyHCvPZ72/U6DzIFhcj1bDrEcUABnnxJSzqbt7gN2JHlNR
 DAyuxY7YkDB+xcxZ3ZECZl5XzI4MuSlIVfsJvbFdGn4d+fETnJtn6QpkSFEhBW5hhzlumWLCgXC
 X5XQpNu6zXEzdw+RyWcOC3jSgo3vnlXXnA051wA+GHraoBU33FRT7uW/CqFhpkfrvRCsqLkvzlx
 1MbXUlo64FXFYZ6IkREgztDr3AOyeSu22YGHX82P88/mkgSCGrfR2fffIhlMhHoUwel3tCTHtEx
 AaqVJjEcvBD91K8xtpL702R8dWTRPmBWT6uJvqyj+oLgcWR3oMzZ9GnNsozU7Moa/ZcpV+KHw7r
 yihSZljjtW3zP8Fw==
X-Received: by 2002:a05:600c:630d:b0:4a1:fae2:a8ab with SMTP id
 5b1f17b1804b1-4ac150b38abmr355702515e9.3.1793794578903; 
 Wed, 04 Nov 2026 04:16:18 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2aaa4b85fsm124557105e9.10.2026.11.04.04.16.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 04:16:18 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 12:16:17 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I427bd9ef8b4903cbc1386d3dcef1b68a460b44c8
X-Gerrit-Change-Number: 2116
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2116?usp=email>
X-Gerrit-Commit: ddeed4be229157bdf2cecf378281259794228a17
X-Gerrit-Comment-Date: Wed, 4 Nov 2026 12:16:17 +0000
In-Reply-To: <gerrit.1793776256000.I427bd9ef8b4903cbc1386d3dcef1b68a460b44c8@gerrit.openvpn.net>
References: <gerrit.1793776256000.I427bd9ef8b4903cbc1386d3dcef1b68a460b44c8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzc2MjU2MDAwLkk0MjdiZDllZjhiNDkwM2NiYzEzODZkM2RjZWYxYjY4YTQ2MGI0NGM4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3f2da309518d5d706ac9509cde96cec20084091a-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOZuj-000000007zP-2ziu
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: manage: fix
 "cr-response" typo in unsupported command error
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
Content-Type: multipart/mixed; boundary="===============8543118378184686448=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8543118378184686448==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="B+aegmausVY="; charset=UTF-8

--B+aegmausVY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2116?usp=3Demail )

Cha=
nge subject: manage: fix "cr-response" typo in unsupported command error
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:=
 Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2116?usp=3Demail
To unsubscribe, or for help writing mail filters, visi=
t https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I42=
7bd9ef8b4903cbc1386d3dcef1b68a460b44c8
Gerrit-Change-Number: 2116
Gerrit-Pa=
tchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit=
-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank=
 Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-de=
vel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razv=
anc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Comment-Date: Wed, 04 Nov 2026 12:16:17 +0000
Gerrit-HasComments=
: No
Gerrit-Has-Labels: Yes

--B+aegmausVY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2116?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2116?=
usp=3Demail">change 2116</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2116?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: I427bd9ef8b4903cbc1386d3dcef1b68a460b44c8 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2116 </div>
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
"display:none"> Gerrit-Comment-Date: Wed, 04 Nov 2026 12:16:17 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--B+aegmausVY=--


--===============8543118378184686448==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8543118378184686448==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8543118378184686448==--

