Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCB6606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 14:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=O6k2ymPO;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=S3bnOiM2;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=gAwOrw06;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=U0+dALXM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=th3yaNySKbnQljFnGb31PlN7uJVpHhYIMlJO+kMnYdk=; b=O6k2ymPOEp7e91JdqkWUbjimsR
	/9ZAma1wOzdxGmjFMhTWISHxXrs6n1zYuxNE6QXW/YLXac1uDm/wMygqzFiEo9F6IL8TFmaraZwHw
	FvLQn1w+xp8GHvkB+w7TUmbCM+Yg/jDj7GTm6GAIQDqxPWZgXY3cI/OWavRaarM5T2uA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVV1v-000000004ll-3TQy;
	Mon, 23 Nov 2026 14:28:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVV1t-000000004lc-208n
 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 14:28:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=i+AjXQd7UWhZyq5gXF8hkG50oRs1rc1IFn2r+Y0pnL8=; b=S3bnOiM24IaEGQKELllc3FoNZx
 +j/uQMu4vj2O5Ws5jqXLDIqpfRe14Z+Nds7WQ1y4Gg1PSMoIexJXd95kHWoWfWwezuUcWWdrp8SHG
 eeqbXZDnS/EWKzQuUQiUSgjLVefwQEOMQQpV16BuFSf4tFHhkSy8mM8O6FYwUIkihWRU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=i+AjXQd7UWhZyq5gXF8hkG50oRs1rc1IFn2r+Y0pnL8=; b=gAwOrw06MR4Lic7HVksiAzZiK9
 D6wj5cGU7c6pZ8eW/SyRcKbMCGSMhWfUixhUUEv4rj9yv9vm/9u/XwhOQ5t5S4pLADgbn8dBksra8
 IDvTLnf+ik6/o3c5T1caaLfQdGq5CrAcYVW7iJYL7ypGT8xGBKYe0nfnGSKMWP14EPR4=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVV1s-000000004wa-2h02 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 14:28:25 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so24243785e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 06:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795444098; x=1796048898; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=i+AjXQd7UWhZyq5gXF8hkG50oRs1rc1IFn2r+Y0pnL8=;
 b=U0+dALXMuRLfHPl+t4PKql4+J2Huv9JdL7qzE0aAyKyiq9w9o/FinKF/pgkSKuCwai
 ISrPYg5jgihlyl48j7byDYMIYFMqpH9OAjzsFvxMXIyrarSST7SsMHVk0AnEi7EPCVpj
 hObEMhc30cplGrsDWG3N4PxwGRj7dfvIiLFI8ZqMmX5/d0qFNoF6gpwZVY7nd8PqXmVA
 lt25t+b6h/1G29fbjK/lk5r8Tp1Wb6pJLv0qnUJ+HeLnk9iYo3FN/g834AgpWkNODofN
 WhbMeOieEL3ettFM6blqJnH4+JUL6dQe2lsZ0ynejeOaQgorGtL5Y4rxUSnw+D2oQjnB
 Ou+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795444098; x=1796048898;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=i+AjXQd7UWhZyq5gXF8hkG50oRs1rc1IFn2r+Y0pnL8=;
 b=YqSseq7QZMpTB/4GIIK2HoNvOECMTzoTbBdPLJtXoAq3FMbnt+EH92PmRA+PgITudC
 +CRUT1KgfqQCSndpFE+0C9lQfZIDEJgBtxk5OE/af1D6vHn3/eUncasMBCdqgY2zR03X
 mio/Dh8jGvVQCYXEN8FRtyyL6plylvqhjQUTeZjR/me0dc8AUNRtZ2SD7dVAO/H28ReI
 lThZ9CIewDbELfI0ZhUz3PWDkP+bKEcmw0P6lOfb7CTeWKy1XmUA1lQKZAwpu0XkGUDX
 1jiw8Lq3KtWKygnwhOUt/NhdiDg5Mr+KFCohxul2jhUl37R+AAwCh46cjt1uGUcFMEed
 aJow==
X-Forwarded-Encrypted: i=1;
 AL+hErHBB/mnRkVbS6MWcQGxG6/kpROn77EDO1Z4aVFT4tG/LgH9SHVnE54lUoPZDinq4LEBb1LkJ5TNA9eM44JU@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/2h/6DApNi6z9YuUTmTpJW2yewIWNm9bW4xXWLdoKmjHObikKn
 UfTs6rhQRKcBu/o8spX7Oa0JsZ9Iw6RO4vHQfNDY+NeYmH9fF7OqxNgJGn8QFuCjK6sLgcXjpIe
 7KsKQ8R1frzAyP33l7mdYoxJUBKryUoccpFOFGVV0pC7RgEDZSSQtGaKvVma1fGmdu2se
X-Gm-Gg: AZFdTZdrrE994FCDwVYCPDxp6+zNxAuA0FseowWYfIEZlrv9hvpcxrZRWSqybUFOmHY
 HGqugSiXSf5egz3om68IdFWNpzSmqRoIm9hIKYm6F8PnJQaF6L1QUNgr3MH9ydya6mh9NAxhfcQ
 80EQWh62I2KPpOQuS7esOzvFdrxobfC8yYTVzoNk6S8ZCoqzJwkVFe6L1rz/r7nf3lmny8ZuHRe
 Hw5/lUQyN1kmlB2uSworysD2hk7ZgtkyKX22JePz5J6zfXbPtIUVJ4AyrNelMx0KGdTnpq1kn+/
 mZG2NXKrnHswIDGJY3H/51jn5fmyrKmIurb94nkxeR6r5/ZWi2ErDOd8TBSipV+eHa2HpHDhsXf
 88wN7j+YRHJdWl8FcTEDbCcsEE0ed1/lLK5WAvBuSEWcEh68FogcALipxRrtpA79fvfvs4OmwGi
 a6IjvFYe0jDz/7B157MqaVFxT1re5R85Cyvtr+wlI6ShBw+A9VRJHcc8b15fnJZyLGWBBvczAeC
 PUDxwm600mZtINlO0xZ2lKC5HHgUOmuFDt8hxdMEC5AZEc1kZfhnfOyG5zfCytzbRWyA4h1QiVg
 jaumPHeP/oUGQqa+2U52z4ZzmFwmlj6M863fBHQW1h8t0RPmPjqCYszIlDl/8JDPLa8LzxvnRjm
 +y8Zh3CLI5xyEj0CVFGtb1tQAtEgEWStdKo0mSrF0pb5kEBPHzO3eKAvOvh92a5/Fx1XOdMxlU6
 ucIzQ3Piw2N1fIjXk=
X-Received: by 2002:a05:600c:848a:b0:4a1:fbd2:f689 with SMTP id
 5b1f17b1804b1-4bb8880993amr234891115e9.7.1795444097354; 
 Mon, 23 Nov 2026 06:28:17 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853ca452sm351063145e9.15.2026.11.23.06.28.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 06:28:17 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 23 Nov 2026 14:28:15 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I189f3a311719b5c4476351702a44870d485d10d8
X-Gerrit-Change-Number: 2328
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2328?usp=email>
X-Gerrit-Commit: 1d2b577cca721d4e3ef5d17bc56f51f7935d73f2
X-Gerrit-Comment-Date: Mon, 23 Nov 2026 14:28:15 +0000
In-Reply-To: <gerrit.1795442905000.I189f3a311719b5c4476351702a44870d485d10d8@gerrit.openvpn.net>
References: <gerrit.1795442905000.I189f3a311719b5c4476351702a44870d485d10d8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NDQyOTA1MDAwLkkxODlmM2EzMTE3MTliNWM0NDc2MzUxNzAyYTQ0ODcwZDQ4NWQxMGQ4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <07d34de9a2359f54a5d5e5fc45ad6f98029b3c61-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVV1s-000000004wa-2h02
Subject: [Openvpn-devel] [M] Change in openvpn[master]: comp: drop
 compression on send leftovers
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
Content-Type: multipart/mixed; boundary="===============6779086909744547994=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6779086909744547994==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OaTQgjN/ln8="; charset=UTF-8

--OaTQgjN/ln8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2328?usp=3Demail )

Cha=
nge subject: comp: drop compression on send leftovers
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
=
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2328?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit https://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I189f3a311719b5c44763517=
02a44870d485d10d8
Gerrit-Change-Number: 2328
Gerrit-PatchSet: 1
Gerrit-Owne=
r: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwa=
be <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Ge=
rrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Da=
te: Mon, 23 Nov 2026 14:28:15 +0000
Gerrit-HasComments: No
Gerrit-Has-Label=
s: Yes

--OaTQgjN/ln8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2328?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2328?=
usp=3Demail">change 2328</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2328?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: I189f3a311719b5c4476351702a44870d485d10d8 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2328 </div>
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
"display:none"> Gerrit-Comment-Date: Mon, 23 Nov 2026 14:28:15 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--OaTQgjN/ln8=--


--===============6779086909744547994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6779086909744547994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6779086909744547994==--

