Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A3D606A907
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 17:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=acKX2h4X;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=bY1HDSWA;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=PiDPrKcu;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=KGDNtUhY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=xD6qbSTDPU2Yvtp4XnjuNvt+n+FfKiE/A3FiED1GuLQ=; b=acKX2h4XkVEw5fAx01lrJ0iVJa
	fbbMYuHdWKMy9llpzPcQpmZxMPG0zBXYY9ALl8WR7cHETW0Wu3gIeGuA86Qm+LKEm5lFKwkRPKRDs
	fgzZl1yf5HXPhM0axHb5PV87N3uzweQmYwCMBECkpNMkNDoe33dUaJf8A4+hbiaqEams=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNvTH-000000003SW-4Bw0;
	Mon, 02 Nov 2026 17:05:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNvTG-000000003SQ-2wk0
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 17:05:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iJDmMQpHhmtb4xxv67bnIpFMgtnucIOr27FZrMZrK5s=; b=bY1HDSWAxnRh7GWH49Z4JvyW5p
 puil5RKkUG60BPGnSJNmI5hE/8cezanzD3I82LO1yRupjtR2smlBAjdzcaDT9OPrUssU/78dUsZNS
 sSCQkrbKTSBsmLr4nX93eljN10G5dbmXScBpM6BRqzpO7xFb691uBwMOgR2nHfCj7KCg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iJDmMQpHhmtb4xxv67bnIpFMgtnucIOr27FZrMZrK5s=; b=PiDPrKcuko3DagE30o6DoFy9ik
 VB1zV9oYXUVvXozNQGeYoK1JORfATRF+WHgD7x9vQZLFkyMqdKz+TL+wMalZBGpc4HAceB5ORE9cE
 mb4UyDNex5WzHwjNLF/Z2oKNQDMXJAxxilf+WG11QTwKOZ1CxrvifkJ1tMukBAFlAXww=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNvTF-0000000064P-0P0y for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 17:05:22 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48e10a70540so1828855f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 09:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793639114; x=1794243914; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iJDmMQpHhmtb4xxv67bnIpFMgtnucIOr27FZrMZrK5s=;
 b=KGDNtUhYmUHfVGfbPbWgCihMPe6+AHqB/BaDqxGzMsgicIWb8eolAgKtim04ikmQ1t
 FR98XzuPbz3T6OcBRmCbgfBFxSzUhMPJrX5PbbxnpltUDBNWLq8tSO+UrdcMsZicCMMG
 OJF6PQnATLjBeF3f/IhqAXD74YdCPa+VcoROj15UFQpQtbv9rUcwDaqlbSdF/dgnBstW
 2pdg5IxbEMB/m+MfcWqBpnCTSzO3CFZzP8Pa1+HMbcu7P9hKgiMg1DTE+ErZoFDN71cD
 SXYhs/XOjb2BGvqoPlsJvmz3rVDfCoPYSIpfwC+8we6Knb7s0YrnNBS+i6A5I6j/IvsX
 c4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793639114; x=1794243914;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=iJDmMQpHhmtb4xxv67bnIpFMgtnucIOr27FZrMZrK5s=;
 b=kmXHq9jqLl56JumjHdJOHIBGqt+C6G5XHepfT6ZH0qS4PJklGXdu2miUqOTNo5EaXZ
 4h1+CKyJmW9BE8Xr4ZeAmeERGTkIgMz7ApMEV6GbuHIOjqES9SZCxubZKh0n813fVKjh
 Us3jeah+r+X4WtZgo+Ou97BsGvXNbCWobNlzm6fZBjBwH+EmA84DEC75T7z0R0S8bvog
 UKV2L+1WHDY5H+6wSeQG094YCrdq22gVErh2A3L4q5TBD67sqw4X4d5jgr4Qdta+fpSK
 3iKQxfuU8W9wobrt6ioRZI4z9z+4sr7XMwvfFuc3AQC56i3dQu6By40X9/ItFLNJPVbc
 zjGQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxtWUbt/eiNZMyUE3nVjgGqnkr0tznmXLmbt6IflAu7aHzRP9yk1lITQOh2LhKpuqIi7pwB6tJ0JKBRliij@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+oJj6G3/9c1k993jlqQkVODp9zAcuWaWaZfOl27v9ChxCQqGqy
 JyBNTwOrRDtwrVQ0tQ291mrNAh9jdAVc+4bVTm0HLO0/LH6rd0MH5x8SkyHpNiJY404uJ3zeSwr
 90JAth+fbfpCcgvpwHO3yaZq3Po32sHPlkH3A2WYyL9uc18N5VWHJ29Ia2rC8GpJxzRKU3AeFEV
 IHIgDIzg==
X-Gm-Gg: AYBFou1jfivmbmHQB13u0HGtLoKhcjSCSTEMLA0PiR0JPzrQ1s5GvELyhbRBFHphnB9
 Dv825ccx6brxwsdglQiY2ZMEjJWfTEGuTsAqrmVVHzJttqRklRLkxYZSdBFrQYwMT8HlFTjMyAW
 EKL7WnIHVnqgHDsT2ICD9RuATSxRwdSW6E284gi/or6OCTt28vgUfGW4p+CJ5Q3f2QOdJ6PZpQI
 otBUNmJQ8WUAu86K4H9981dvy8GQ4GrILbp4AVbvG64+w9qUM95yj2kFB7x7VdRPSaO92TSatF+
 aEDpe6zf7ck+yEtmvS/nnl6pM2Y4VNrtIL00tsBehTBbkPJc9AtcMVysT9oekwC8FnhDKXev51O
 QAvr2COOEesfI3/+GeZAkvefjdpN/+/vaFS8JfdoWOjGmv0lB9shpxd6cl+FoV/tsH5Ve3E5exe
 fsbJymnB7eH7chI/Q5Fb7tBNh60yQgwaAVCciA4l6talEsV100ZTSNbxlo+mI9rMllmrZVdqlDQ
 KaPsGiHzq92pNFzY+l3O/ijj9gSv/cWiYz6JN5/Yadfo5fQZxzeLvS/x9zCyNRx/kBo2g1xIe7O
 WKJq4/rFD+DE6m7YGWf8a+N/51uJJO26QybrQfz8kMFrDkomoI6KHZCdrZFqniPD3Xd+T5GCHah
 ygrYGbSWrn+kiRHDRUMBzNj0Xy+0rEJ2onLd2gmd0AShT0FqQ4uSD+dr/y1z5VEUbCd1dsWz4Nk
 7COVpAfzaYVMjjtTvWvGyoiibuaKrbePPlaUYI
X-Received: by 2002:a05:6000:1acb:b0:48b:a7:6396 with SMTP id
 ffacd0b85a97d-48e6e4f56dbmr23001057f8f.41.1793639114359; 
 Mon, 02 Nov 2026 09:05:14 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71bab1a8sm20802106f8f.57.2026.11.02.09.05.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 09:05:13 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 17:05:12 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I73efe00fddbd919897489c975ec65ed4b4628cc8
X-Gerrit-Change-Number: 2091
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2091?usp=email>
X-Gerrit-Commit: bfa1f80ea633a88876215c570bb9abd54dab52fc
X-Gerrit-Comment-Date: Mon, 2 Nov 2026 17:05:12 +0000
In-Reply-To: <gerrit.1793625001000.I73efe00fddbd919897489c975ec65ed4b4628cc8@gerrit.openvpn.net>
References: <gerrit.1793625001000.I73efe00fddbd919897489c975ec65ed4b4628cc8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjI1MDAxMDAwLkk3M2VmZTAwZmRkYmQ5MTk4OTc0ODljOTc1ZWM2NWVkNGI0NjI4Y2M4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4411d094f40ce7f525324da5994c5ce6a3f5cbce-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNvTF-0000000064P-0P0y
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dns: close first
 pipe if creating the second one fails
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
Content-Type: multipart/mixed; boundary="===============6790551658618681406=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6790551658618681406==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pWZxBwx7pMk="; charset=UTF-8

--pWZxBwx7pMk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2091?usp=3Demail )

Cha=
nge subject: dns: close first pipe if creating the second one fails
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-=
Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/20=
91?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: commen=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I73efe00f=
ddbd919897489c975ec65ed4b4628cc8
Gerrit-Change-Number: 2091
Gerrit-PatchSet=
: 2
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
rrit-Comment-Date: Mon, 02 Nov 2026 17:05:12 +0000
Gerrit-HasComments: No
G=
errit-Has-Labels: Yes

--pWZxBwx7pMk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2091?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2091?=
usp=3Demail">change 2091</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2091?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: I73efe00fddbd919897489c975ec65ed4b4628cc8 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2091 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 2 </div>
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
"display:none"> Gerrit-Comment-Date: Mon, 02 Nov 2026 17:05:12 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--pWZxBwx7pMk=--


--===============6790551658618681406==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6790551658618681406==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6790551658618681406==--

