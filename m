Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75854606A31F
	for <openvpn-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=OQHrFGLj;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kSoHrMv7;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=JW8p7udm;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=F/VJiIol
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=hFyoeHK5a8cYLPZ/4laZZue9wo7XdGUj/ir9qJQkG1c=; b=OQHrFGLjlAY69qT009O1RWnP4c
	6P7nomibUKq/Diwn8ZfxQzNRXEnVtkrXObIXh6i4Kmhusrirec2VAoZMYVJnn1pCCw9uyUJX3u9KX
	0Xqbl/De4WK9o0aGSbmPJVa5JDCyyLpv4daaT51UPcaW98yCK5tvDrtlATsetX5QTdBM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMU7Z-000000002fx-3HhI;
	Thu, 29 Oct 2026 17:41:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMU7X-000000002fm-44Sl
 for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 17:40:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LdluSwoZ1Th8jDNOx4IEHxry3lDvbFm1YkRCXd3euvE=; b=kSoHrMv7fQiD0+yWEtX+HusmKw
 SjGWLw3Uz57ktnMYY+5qoMpVl1yZzO1t3c4jKjPRe0w0Vg/VDY1GCcvaH9UaW9wEDU6cVuIvyLpl1
 c9bc36jX8VOXZJcsV59bHaQPWFdHg1dDjOEQUCJ399evkEe38wpXiNFWe81UOYaiZUmM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LdluSwoZ1Th8jDNOx4IEHxry3lDvbFm1YkRCXd3euvE=; b=JW8p7udmZRRy8BMF0lqau16/5n
 3Z9RZ9d6DSRwyH1nz7+5lejjn+xOrexzxaoH4UE+fjsSfnU+CMcar+D6hBKX6nRoDHk1THfUvEOKy
 CN/uKPQAX9uZ/nM/G7QCGpN1Oo7UPCq32Q6k75MDVngeXfUt/EqiPzWWzarBNgbMw2Wo=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMU7X-000000001Qg-14ai for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 17:40:59 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso1935066f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 29 Oct 2026 10:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793295653; x=1793900453; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LdluSwoZ1Th8jDNOx4IEHxry3lDvbFm1YkRCXd3euvE=;
 b=F/VJiIolO+IxFkAXRzMezTgWfAFsX86if1hQkfpf96j2WgGzwbj20N/8RMMFBnnqeK
 mJ6xOX1PrnlqjDKsQaJAOp0/Dhc0sP1gXll6NvO1Q15aeSbsIhpF7jbc6OsjwSuCMAIg
 qJtofpo+VLco9ppEnuM3LCaqr1zZ1CXR5Sh/vNKi3ny2DHGhVbv7qeBVSVrIVUzYDtFW
 BvjtNrrWUscp6cnfWwzk1h0u3m1Mxeg5k7yTJK94gp/U+ET/T+H2zRTI5aV9qrTvoRF2
 7p7+eRMKmCY8cOVus7tfA4NHhk6Wjjvi5cnnVyrljd/iMCADXbRLwlRCL05pZe2XnaHz
 NkmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793295653; x=1793900453;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LdluSwoZ1Th8jDNOx4IEHxry3lDvbFm1YkRCXd3euvE=;
 b=nMi6epBzItfTWYH54ER+k86iMJpiflnX+9P9wnoMJB8zcUKkCgVf1EInlUOsHcyymv
 +7dW/WeXxV3c5Sct7OohwienJJzrjYGU56uN7kG5j0bUVdTGkxhr6FqSE5fPSl8izLYZ
 XpSr2iLTJBoGsGmScGMzQmdwIS2KcOHiRNu2F25dapK/f4en9/q9pADwuAbDclaWymjG
 tYlcVv7kJBOJK2cWELGurknkq6cXrQ9H/HW1LlY7X29cJbg8gcnmp0kf9CZbAZuAwIOB
 Av7rbMe0IKfKwCSdtyuVwdlPdA8OPWpJpiMw1QTiAzszeaHx3vzeK1dySPLYw3Q1JsO2
 7Evw==
X-Gm-Message-State: AFq9FYKeGFzltivAAwDp+YtaTl4eMM3npjEm6wICVZMuT7iq2T7JVVjk
 oXLHgZPlT06Q3PYIYOqu0xh2x9/L7zR0yt6lvMeT13LvklY6WizX2Fpifv6+ZqcSRUKjeM5O4ah
 MHzqIYW+C1EBqM5KdOkih3u7PMB5QBEImdKz8SwbPTwp1EuG0xYOrH/eeChE85Nw5Ohrz
X-Gm-Gg: AYBFou23/tCKP+x31n1F3JWYjlwfLauekaHDjyUo9O32Cp3IdVfXGoG/QLHuokUfx9p
 LFc0a2fw8ZfUf6UrEB0ZnD6rmi1aOlqid66hZgrVfc6ihE8LW51dUbRA0H8iRs+vA26HLdmuVG8
 lUeC/aQCElNZFpdBAGVn+WMJJEcmR1TaZHZomoaLBDVZDhntCbofsdKhjcjEG9O/gQk2CGH+gus
 7q2qr9lAfGvQ7eT2mlmoiC0Xoe5LtAuGJpZ5ef9Zm50BqBymEOa2qg42FVhsQvcrlJVF7ZhrBdv
 ZS2rruBulxUkk8NXmatC8CTQkVv/4e+kVCv2bUYCFhIGOH6M2FtIL+oahZaADU8tAQIZfHFdVd5
 w19AjPMCEDwrcL2jYUeYXQx/q/FrERnJ8YFTtvutjpV0QgU9yrKrcw6Xi5CmKADMYy5bovZJa44
 e09MnO35cOmuSUfl1k9jhJ6YYi1UES++YPdMsuHGvW/8P+L1/jfvn4tDLUi9yTYjrqFBA/+lkYl
 1FKM55NdeR/x5wAFElZ8cW4kCPQCviu/r5XCT9I7ix751719l70/mkcIiT/75+BBqRgS50x1Ej0
 tQq5lb3f1ekU9VBUVhEv48C5hsPgIoF4PhoENs/gdQWdAE5Pn4KoOlPwlQYwJGRprIT+BtB8d1F
 3wylRu88eWKwUcIsO3Ec1X6oVISMk1AlwMUcuZEy1+fhCn5lMalxm5D2W9+AQrXVaorgdTa7Kx9
 XRw4k2+N7B7bjJSXpqPnixPV4hWTNH7GBhQwzlrQ==
X-Received: by 2002:a5d:6f0e:0:b0:48c:7ee3:e07d with SMTP id
 ffacd0b85a97d-48e6e529f9amr163436f8f.52.1793295652422; 
 Thu, 29 Oct 2026 10:40:52 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e6dfba340sm486457f8f.48.2026.10.29.10.40.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 10:40:52 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 29 Oct 2026 17:40:51 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: If8ae9cbc971f60800a998abf2f97da0384c023f3
X-Gerrit-Change-Number: 2067
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2067?usp=email>
X-Gerrit-Commit: 50b033788abbd0a65d9a8c4c22cbfb923309badc
X-Gerrit-Comment-Date: Thu, 29 Oct 2026 17:40:51 +0000
In-Reply-To: <gerrit.1793206499000.If8ae9cbc971f60800a998abf2f97da0384c023f3@gerrit.openvpn.net>
References: <gerrit.1793206499000.If8ae9cbc971f60800a998abf2f97da0384c023f3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMjA2NDk5MDAwLklmOGFlOWNiYzk3MWY2MDgwMGE5OThhYmYyZjk3ZGEwMzg0YzAyM2YzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d6d726000574c278cf1da8c601c105fc3ae4a7fc-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMU7X-000000001Qg-14ai
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Do not hash real
 addresses of TCP connection
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
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2120616219217734452=="
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2120616219217734452==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wtXFiM2AXdQ="; charset=UTF-8

--wtXFiM2AXdQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

R=C4=83zvan Cojocaru=
 has posted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2067?usp=3Demail )

Change subject: Do not hash re=
al addresses of TCP connection
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2

(2 comments)

File src/ope=
nvpn/multi=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2067/comment/7f=
9494d6_9e410408?usp=3Demail :
PS2, Line 2459:  * If the address is already =
taken this steps fails=2E
Typo: "this step fails"=2E


https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2067/comment/c2d8ddf0_6e0f49ac?usp=3Demail :
PS2, Li=
ne 2467:         /* For TCP connection we neither need to be able to map in=
coming
Typo: "For TCP connections"



-- 
To view, visit https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2067?usp=3Demail
To unsubscribe, or for help writi=
ng mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail
=

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
=
Gerrit-Change-Id: If8ae9cbc971f60800a998abf2f97da0384c023f3
Gerrit-Change-N=
umber: 2067
Gerrit-PatchSet: 2
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-At=
tention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Thu=
, 29 Oct 2026 17:40:51 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes=


--wtXFiM2AXdQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru has post=
ed comments on this change by Arne Schwabe=2E</p><p>Patch set 2:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2067?usp=3Demail">View Change</a></p><p>=
2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>File src/openvpn/multi=2Ec:</p><ul style=3D"list-st=
yle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2067/comment/7f9494d6_9e410408?usp=3Demail">Patch Set #2, Line 2459:=
</a> <code style=3D"font-family:monospace,monospace"> * If the address is a=
lready taken this steps fails=2E</code></p><p class=3D"blocks" style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">Typo: &quot;this step fails&quo=
t;=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"mar=
gin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/206=
7/comment/c2d8ddf0_6e0f49ac?usp=3Demail">Patch Set #2, Line 2467:</a> <code=
 style=3D"font-family:monospace,monospace">        /* For TCP connection we=
 neither need to be able to map incoming</code></p><p class=3D"blocks" styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">Typo: &quot;For TCP con=
nections&quot;</p></li></ul></li></ul><p>To view, visit <a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2067?usp=3Demail">change 2067</a>=2E To =
unsubscribe, or for help writing mail filters, visit <a href=3D"https://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2067?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"disp=
lay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If8ae9cbc971f6=
0800a998abf2f97da0384c023f3 </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 2067 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </di=
v>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Comment-Date: Thu, 29 Oct 2026 17:40:51 +0000 </div>
<div style=3D"di=
splay:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Ge=
rrit-Has-Labels: Yes </div>

</body></html>
--wtXFiM2AXdQ=--


--===============2120616219217734452==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2120616219217734452==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2120616219217734452==--

