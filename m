Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80B2606A333
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 12:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MTX0LLBt;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=S+F4aT33;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=d5DscXld;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Dcd72ON9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=kPyunz0W4/+iHMtpImApSdtUJBz3uoQaMh1V1O2VjRg=; b=MTX0LLBtb1ov91QMplA7NhhJpt
	4x8Bj/aUhISJSUqg62V5bz1NuYtb5O6x5gz7i+jX3FgiPgPnIhpFU9z0hbalGWtwEqtutAT0ugeN/
	vJrZEGORpkqEIrlv+EyRit6oUNa+f7uDsfqaVOt+H1fsLA8pILeIeq0fmoTEDB/bYKl4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQlCL-000000001lP-2r2d;
	Tue, 10 Nov 2026 12:43:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQlC2-000000001l6-3ZyR
 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 12:43:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M2cuGg5isM8eBvDRj26EivzfV8ZT3gO7pjFmKHzRSbo=; b=S+F4aT33fSxUZfCqTJ14odYKOW
 h0pF1iMDrB4p8DPCHJ77CzP5US8j8qCNZ0mNZ769oaAsuEvzlRmYywZZy86epAdBTKkPisEniM1gw
 /olhJ7ZY9Sg5DBBDTMF4UcahMUkBrD8xbmvgPyqNFlancWUa11SC/9aY81KoB1VaCQig=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M2cuGg5isM8eBvDRj26EivzfV8ZT3gO7pjFmKHzRSbo=; b=d5DscXldk8b2tKrWdfMXYeYy0t
 F4n6+W/13vOf8vVpPNGsC0dSGVjlzTIpM14nP1DIwdUI3QZXu+nHoo40yv1rZobQSLN1u8wyhGnrq
 iGqNNTn04+EbEZNmtTsyPLn5p38NYlbqf7AltFoe4G9SEemt10iqCP+fL62/sJiOp0Qk=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQlBy-000000005yE-2IjE for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 12:43:16 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-492f0a1b685so1329619f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 10 Nov 2026 04:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794314588; x=1794919388; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=M2cuGg5isM8eBvDRj26EivzfV8ZT3gO7pjFmKHzRSbo=;
 b=Dcd72ON9EV34LXSddekdZY3ZIKgeP2AMmzOx5TExdL9k48oo2HLYDmdtdBXO6F2sWN
 jacMweUKpOLph7RrTQsrlA+7dKEcNOcyEbQadXsWWw/AZMfspa0vcZs8CyprKdtR8nok
 HloQpR7YfjcHH8jN1j0s7kqWUEAroPpV8Td09IpzPA79sRTVERUCHKOJYywHbjHemri5
 +SHd8Uo+j1gc3JwWznY9h3SYqW8bS2ekAhJesr+Fb348Rvvo2p2X0tKlZdrjsfptCCQW
 I3i79WwF3uOpAwOFmJdJ3l50n2nFhbuMzwkbArFEqap0Zo3qkRSJHw2yiPvMNeohRlgo
 yGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794314588; x=1794919388;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=M2cuGg5isM8eBvDRj26EivzfV8ZT3gO7pjFmKHzRSbo=;
 b=FG27p3Zrkqc21mEMCU2MFV1gvN3+ny7XgCWu9p2IDIn73BXpXhzf08d6Y0XeNK0Eut
 r93jaq9KevkllqiHILMu/M2BqJTOjGhz+5KoyyLfdj1TELvapVjecoYaBYYRwnhqs/Ya
 24FWQB95I6S2FNlUjYyWETJcPF+r35QayttJ4qRVP84FKwVHjWqV5m+6DWNd50I8GP7t
 TVHsc7vkJIYx1+HOUPEipHslR4olc1kVDLV3z0ceLpB38BVZHZqeQ2FcV8FSPLY6u2/F
 k2AQZYIA8Z2CtDMK1K3gHVybqhVUhOE6zB5Ic8NG1CnfeYLau1fFXxZxlzR3uVe5wdYQ
 RMkQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFC0OFWh4tX76UhpHO8fm0LhnOjfVKFeDQPX5iEGZwC3NX7HblphfzunqM19GsUjMf27wGz4CtsVPmqSsGw@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+OSnPz8u2eksz8Qx0DAxJMRtLqDKIgriYgE+y+Qei6QmW2tnrg
 ohNOHJjHaoELAXchILmT9NsiZHfSTKp3E2mJP0rNWAzYTHqSFqyvaK4zHGpgXNCzwB5EkOt1jLy
 mGoQWBNcp8tJzTizvxm9hENdHaY36NeBEM9i6XR0xJDkvvureMchV4pkmodR64X2VxCy1
X-Gm-Gg: AYBFou3IbNFGIs5HBgn0CnigB/x46l795J3FRUrf/Vg5da3aODlpcL9Iy6R5mFtCxjL
 35dCij3QDRwbdyQVrBNK0y6LsV4Zs4LBDWUDhWO7OXROi3L6yg6/YQwNFOXYHvKaNdjiWu3xom+
 RKggs5I279gw5qg71ghNkKmjAmiQRBSPiTduT7Dki5ALlOyMl4U+FIdrN/MlzKraQA8kDq0q3Zk
 f4KFJMaMtF9jpau6q2Ez1zLSbmJW8O5Vir8E13y/xAysM8f1Ho/9G8Fw7Fw0/7efZDyE2s2YlXe
 H+lZ3d1CRL/vFhEI9h5qXinoeiwsOP6q5S0Vjyt6ZDirFT2Gntp0DD37qBmRTw3KFg2lUxgYB0z
 GTaXO3W0+IUt7eTSIGBEfvWD6sBImT0t8niawB/QApi5ArWwNZeCwlCAhnlsrg85K4WDo0Z4QKT
 anQjg0UEqm8CMM/MWXWnuUP1LWyNShSr45CV4Rb1mU48QdWuLb2Pk9eygzYnOfu36c989GwID+g
 MjLpZdDeRAQQXlQlzi5ZuA3+RoFLxy+NHCXVbyqu5jQ7XJPEyZfkazjahgBcN+UT3u+Qg/ZBya/
 xhIewoTA+3y0DOo0Td3pTXSKcolHvrc9eR30HXC/jG046Dy7TG+TF9Z/IcnFL9UfpBaXlff2T6f
 iF/6A0Hx41RIZ9fLPl7e+MJUKg7UdJbfpWbUk83npm+/PrOdOBmo2YrQ8f/P8goipwta0BetaIU
 NKufPrL8P0MV+P+wE=
X-Received: by 2002:a05:6000:3102:b0:48f:fcac:a5e2 with SMTP id
 ffacd0b85a97d-498303f151bmr4748249f8f.38.1794314587840; 
 Tue, 10 Nov 2026 04:43:07 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4983f7801bbsm4748249f8f.5.2026.11.10.04.43.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 04:43:07 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 10 Nov 2026 12:43:06 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I02f8df01f8f33cb9cd04cd844d1f1893688f51e8
X-Gerrit-Change-Number: 2157
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2157?usp=email>
X-Gerrit-Commit: 94b2972fcbcc524c37769e2337e72a221255d075
X-Gerrit-Comment-Date: Tue, 10 Nov 2026 12:43:06 +0000
In-Reply-To: <gerrit.1794261747000.I02f8df01f8f33cb9cd04cd844d1f1893688f51e8@gerrit.openvpn.net>
References: <gerrit.1794261747000.I02f8df01f8f33cb9cd04cd844d1f1893688f51e8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MjYxNzQ3MDAwLkkwMmY4ZGYwMWY4ZjMzY2I5Y2QwNGNkODQ0ZDFmMTg5MzY4OGY1MWU4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <86785366165754878f3ae8538a57a2747cf43083-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQlBy-000000005yE-2IjE
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Various trivial
 -Wsign-conversion fixes
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4991655176960145369=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4991655176960145369==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="c9rIethtMbY="; charset=UTF-8

--c9rIethtMbY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2157?usp=3Demail )

Change=
 subject: Various trivial -Wsign-conversion fixes
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3: Code-Review-1

(3 comme=
nts)

File tests/unit_tests/openvpn/test_crypto=2Ec:

https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2157/comment/6ea1b23f_be593c60?usp=3Demail :
PS3, Lin=
e 528:     ovpn_hkdf_expand(prk, info, sizeof(info), out, L);
`test_crypto=
=2Ec:528:52: error: conversion to 'size_t' from 'int' may change the sign o=
f the result [-Werror=3Dsign-conversion]`


https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2157/comment/3c5b44a7_a19e88d3?usp=3Demail :
PS3, Line 530:    =
 assert_memory_equal(out, okm, L);
`test_crypto=2Ec:530:35: error: conversi=
on to 'size_t' from 'int' may change the sign of the result [-Werror=3Dsign=
-conversion]`


File tests/unit_tests/openvpn/test_networking=2Ec:

https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2157/comment/3d3f1394_d5ed73d0?usp=3Dem=
ail :
PS3, Line 46:     printf("CMD: ip link set %s mtu %d\n", iface, mtu);=

`%u` now?



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2157?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: com=
ment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I02f8d=
f01f8f33cb9cd04cd844d1f1893688f51e8
Gerrit-Change-Number: 2157
Gerrit-Patch=
Set: 3
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Rev=
iewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zv=
an Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel=
@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
=
Gerrit-Comment-Date: Tue, 10 Nov 2026 12:43:06 +0000
Gerrit-HasComments: Ye=
s
Gerrit-Has-Labels: Yes

--c9rIethtMbY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 3:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2157?usp=3Demail=
">View Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/openv=
pn/test_crypto=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li styl=
e=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2157/comment/6ea1b23f_be5=
93c60?usp=3Demail">Patch Set #3, Line 528:</a> <code style=3D"font-family:m=
onospace,monospace">    ovpn_hkdf_expand(prk, info, sizeof(info), out, L);<=
/code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">`test_crypto=2Ec:528:52: error: conversion to &#39;size_t&#39; f=
rom &#39;int&#39; may change the sign of the result [-Werror=3Dsign-convers=
ion]`</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"mar=
gin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/215=
7/comment/3c5b44a7_a19e88d3?usp=3Demail">Patch Set #3, Line 530:</a> <code =
style=3D"font-family:monospace,monospace">    assert_memory_equal(out, okm,=
 L);</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wra=
p: break-word;">`test_crypto=2Ec:530:35: error: conversion to &#39;size_t&#=
39; from &#39;int&#39; may change the sign of the result [-Werror=3Dsign-co=
nversion]`</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File t=
ests/unit_tests/openvpn/test_networking=2Ec:</p><ul style=3D"list-style: no=
ne; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2157/comment/3d3f1394_d5ed73d0?usp=3Demail">Patch Set #3, Line 46:</a> <cod=
e style=3D"font-family:monospace,monospace">    printf(&quot;CMD: ip link s=
et %s mtu %d\n&quot;, iface, mtu);</code></p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">`%u` now?</p></li></ul></li><=
/ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2157?usp=3Demail">change 2157</a>=2E To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2157?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I02f8df01f8f33cb9cd04cd844d1f1893688f51e8 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 2157 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none">=
 Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &l=
t;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit=
-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Comment-Date: Tue, 10 Nov 2026 12:43:06 +0000=
 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div st=
yle=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--c9rIethtMbY=--


--===============4991655176960145369==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4991655176960145369==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4991655176960145369==--

