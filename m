Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52305606A32C
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 08:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Hog0x3qZ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Z3wOiaO1;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FHjw3GCD;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Vh9CHckR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=2Al+CwYdXs+OIcbAeMYqTngBdN8EFXzXrQ9QGVUbWT8=; b=Hog0x3qZHCagGhMlJsq6Xgu+so
	PpI3C2D5fULrD/uT08uM6KrdtUrkA8Ib+KIJ54dit4sbEz5rD3jpP5G/KxjX9PyLMuVIOdwh4hXzE
	DwAWA8y2kGhbPRdxvAnXoOgZGHRIJ/IPj5hUYMvY5d1nCrtOF8ds1RoKD2dqECcz4EO4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xO9dN-000000005eD-4ASo;
	Tue, 03 Nov 2026 08:12:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xO9dM-000000005dx-14DX
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 08:12:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vgPi+98hflHNKevKjiLsGfNcdrwtYbB5qJQBcxnEyhQ=; b=Z3wOiaO1ggOJmgyHvziHc7pRa8
 4xzMpsh/Skkj429j0oBhlKHg09HOLElv/c8SKW5jGW+6xsFW/udlBLdDklN3v4P7OuyBTEp1UkDpo
 OY0uuDKL2ajmMmwe06BjRTnYGnUhmB/5HLJWxH5/0edA7xKIYVzCNOYB9VUM1s/wT0b4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vgPi+98hflHNKevKjiLsGfNcdrwtYbB5qJQBcxnEyhQ=; b=FHjw3GCDePEUVEuFxbUAaly609
 ftusRK+8ai1b/UyqAoT2A8oOYa3X8ZVh+QMEZ3nYl4ny2zE6u6ZmhI1cuJZs9n3P26ZlkbbOW4HzQ
 ZJjq0D6Lgajn3fyu8aq3q6E8A39ArMd9AbeR+8UKW5A5OPNd5TggWzzslpOYIOBhBMO0=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xO9dI-000000003VQ-1Tii for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 08:12:44 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48c4d870d54so2291612f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 00:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793693554; x=1794298354; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vgPi+98hflHNKevKjiLsGfNcdrwtYbB5qJQBcxnEyhQ=;
 b=Vh9CHckRRWPhsYMWj+qQhidlqjEiZNXrfE+3s0sEjA4fUcrTo0r0SB5OesYiYQAN/A
 Lcy7iu6DvTtgRjR702XO+YrgHbi+aBqRbgE44d/D5wt1iJsY7iFeeCYFvbcM68CFNT72
 c1WEtBoNhH2qX8j2Z6P905HVrAKdmEPUkkWCcJtxdgasCuiZYmWPEgr1KoCO2ZK2WiF8
 YFjMdaIXa0m1pUCIDswz4RgbDBn9mshDLK8w3K8cJOC5Vhv1tbJehOBKZvlp4TrKrEv2
 CJkponWGefjFI690E4bZoZHH1mV4kfpYLlM7tnkOsW79BFytNXI0HLEGE12/Cm4TjlNH
 71Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793693554; x=1794298354;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vgPi+98hflHNKevKjiLsGfNcdrwtYbB5qJQBcxnEyhQ=;
 b=kgwxMCm97wTm7pwJl09HQE991XwaoMuDpjkqlgQwRnbRRoaDyg3mmz13+0DRhl3yqo
 EbumENqK5sOtzq4kE2d9WczFDyax8d4sTKqcw/7zvastgcFx0FJxSN/TQPsfDgxnmr9x
 kdCKYWdGRUp3Rb+dY1Ryz5H0m5nneuCTUQUOa/+OjUYl1n010qHuK5m+eUi8YRRR6dwc
 42curvgm4e7Ms27ui6REtuTs5Lqdt72h+8Kc5WfxDC8vB9N3PrzzAS9lY9VJJM3V/Ua6
 nhSs+Ei+QrUDFRiGBm/6mh/rb736OsHoHISSnpy5wuPI2pbCg/G4ZtzUeGryyTSO8qhz
 97Hg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzme6a792FeCLLPiiXL77+TYjDmuJ4bbRAnLtQ4adnYBKodsLHZ1mFVViDKzAib2sPzmk11THzRiYjVQsQZ@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8V8CVGoJly9pgaLaO2cU2JJtml3NV9iKLsFdb71opH1ZD9LbxH
 7xMpW1BHpsl1RjZTPGbsFWxGG8NLmxh2miEvg8/T/XnbrOUO0BZExJpPLXFQDgJi7V3uVf2f7hN
 IyQxVp6BR9L75Yqwosk1Sxkh7fpBzkZa6nM+gG/QcTZWLSZaF/GqrebtHthV0nG0YKSJJ
X-Gm-Gg: AYBFou0bUEpnPxzEu78vL+NfhQ7gDC7el+hBV67MnHRefgCsCbAc0P2hU5dbvS5FNDU
 eqzU3nDBx0ecy2Noo1AaWyjff0/Vdm8nFeGxJyWikAV2vX4MwwUUbNGtC6lnCmpuy+Wn28VQ3nL
 7U8NLykFkj6Rz2AxeXyBU8RdQ4m7P0k63ewR4q5SUK1FJWCW7BVH01LDxKlziKN1ki8zQZTzByi
 JPOvOBTGlEmaVeo4a5Tv97Tch8ezzkCb20l7W/hUWc0Zbfov1renZ/gKYLMdgGlx7vtqTb/BK6m
 nHIN8ww0+SXqdUgIDIdMSkme/jQUrZO1NB0ODstrf0a7TH1fACRmW/hdWCUuSTjPbcGqCirPRL8
 UfRYakLZ9rFV0aLEhYGcLmkK69Catr96HJwESvnfifdBgtO3s+CJsLd1wzjinwHlQAfs8cPp7To
 suRiZybQoEfgaR7dqa1GaH3G675cLeV0QnL5Qe3MOWt1Oqk59+lQGN2qGtz4r3mZpZW4mUvR95C
 4ZmGtuGLHHUhRnpdImqnj5ds141cceeAvMhTPzsxkkOiD1/Sn6P8ipx10yWK2xoFV+FjDE8YXTB
 Z40tAH7B3De1KEHAvHNyOh2KhlCzHXO1nVm2o4HpjQTyBmpk0tVhN1JpzCHJNy+IjKG4bitO8VL
 OcRHxALACBTx4YQp4Wx2Kmyx6PMfZwKvdxuZin5SdTfdySc89fa5KYJmYOBgxaNG3mGTNx0CPYL
 k1lr0WDb2uKr2nSQ==
X-Received: by 2002:a05:600c:6087:b0:49f:f099:6fb1 with SMTP id
 5b1f17b1804b1-4ac17753befmr276121315e9.15.1793693553742; 
 Tue, 03 Nov 2026 00:12:33 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abe7706516sm213786575e9.0.2026.11.03.00.12.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 00:12:33 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 08:12:31 +0000
To: Selva Nair <selva.nair@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I3c8c62c7d90c2b94dd1cd149b4c13b383a2303e9
X-Gerrit-Change-Number: 2096
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2096?usp=email>
X-Gerrit-Commit: eb4fd0629a34094437f4e3d3f0d0816fa9649114
X-Gerrit-Comment-Date: Tue, 3 Nov 2026 08:12:31 +0000
In-Reply-To: <gerrit.1793666730000.I3c8c62c7d90c2b94dd1cd149b4c13b383a2303e9@gerrit.openvpn.net>
References: <gerrit.1793666730000.I3c8c62c7d90c2b94dd1cd149b4c13b383a2303e9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjY2NzMwMDAwLkkzYzhjNjJjN2Q5MGMyYjk0ZGQxY2QxNDliNGMxM2IzODNhMjMwM2U5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e87bd646d7cde8245a25767b58dc4286e01f5bb2-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xO9dI-000000003VQ-1Tii
Subject: [Openvpn-devel] [M] Change in openvpn[master]: misc: Fix username
 overflow spilling into password
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
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org, selva.nair@gmail.com,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7484519215181539327=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7484519215181539327==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="da921u3mWOw="; charset=UTF-8

--da921u3mWOw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Selva Nair=2E

R=C4=83z=
van Cojocaru has posted comments on this change by Selva Nair=2E ( https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2096?usp=3Demail )

Change subject: misc=
: Fix username overflow spilling into password
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
To vie=
w, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2096?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I3c8c62c7d90c2b94dd1cd149b4c1=
3b383a2303e9
Gerrit-Change-Number: 2096
Gerrit-PatchSet: 2
Gerrit-Owner: Se=
lva Nair <selva=2Enair@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: Selva Nair <selva=2Enair@gmail=2Ecom>
Gerrit-Attention: A=
rne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Tue, 03 Nov 2=
026 08:12:31 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--da921u3mWOw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Selva Nair=2E </p>
<p>R=C4=83zvan Cojoc=
aru has posted comments on this change by Selva Nair=2E</p><p>Patch set 2:<=
span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; pad=
ding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2096?usp=3Demail">View Chang=
e</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2096?usp=3Demail">ch=
ange 2096</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2096=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I3c8c62c7d90c2b94dd1cd149b4c13b383a2303e9 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2096 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Selva Na=
ir &lt;selva=2Enair@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@ma=
ilbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-deve=
l &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: Selva Nair &lt;selva=2Enair@gmail=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment=
-Date: Tue, 03 Nov 2026 08:12:31 +0000 </div>
<div style=3D"display:none"> =
Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Label=
s: Yes </div>

</body></html>
--da921u3mWOw=--


--===============7484519215181539327==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7484519215181539327==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7484519215181539327==--

