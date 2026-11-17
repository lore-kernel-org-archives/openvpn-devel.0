Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A868606A31C
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 18:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=iKrd4AK3;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NySDHtW+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=N1Jl9hHm;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=UdUudjzL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=eXyUdDWOpGHBoJse0miFHeZJDHr1Gf4tVEQlI/Rg4qs=; b=iKrd4AK3LBe7jsYkfOi0JTJoFY
	A+wdcvGZuScPthW1avmU66epwRA/EKN3B2q23WiN5YfJn/qb80Ru7C+vJEUjeMQ3pq3ge5jsrVOWv
	Uf10EuWmgEjpYXcJG1huBIda3VSP79MGoUOXzuCjihYzaxDg5DGn4SFSBY5Fy2H3xWqE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTNnM-000000004Oz-2kc3;
	Tue, 17 Nov 2026 18:20:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTNn5-000000004Oh-0IQL
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 18:20:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dTcJz4+wSZXE4Tz0CMYv/nLFzh+o+0XlNh1cRPUp5UQ=; b=NySDHtW+3xm1OR3+yoeomy2a4O
 qVc/vX/OaQlP1wPH8qNwjPxBlUoUq2zRSoeg5gQ8pDu1sx1vNMR2FbUK6z3HOm2FUPvDHoIxQ38u7
 bz1DLrQkFKuIBVZif+cUlItQMGH+vTRGoHXm/qyqQ7ORAU/AE0QFykJwmqQorQXFPZME=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dTcJz4+wSZXE4Tz0CMYv/nLFzh+o+0XlNh1cRPUp5UQ=; b=N1Jl9hHm+ZumFsZcFsPy6EOQ/k
 uaMuNZlMH7/6bXzVWNq+VcvJ7OK3Qz3VBDGyHgWYDTC9bgT4dot/d4HtOlAfPsDkx1l6GQUhO9m+3
 u2TcQ91jjHqrNidHD03QuHd3ADLVglC6fDiY0x7WQhk8yzNeuswqCJgUKNauCfWr+Fgs=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTNn0-0000000067N-2zdb for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 18:20:20 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4bb6886d30aso1371045e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 10:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794939612; x=1795544412; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dTcJz4+wSZXE4Tz0CMYv/nLFzh+o+0XlNh1cRPUp5UQ=;
 b=UdUudjzLHqMH2dG1u/lCqQknaHNShiXxHP1raATfcJclJZKlBnDwIqoYCd5jROuGIA
 mkfBBGb/Fz4KAOF1A5+x7yekaKjAuAWHDPgga/VbYH7PjlHfjDDVGPNs3DZs91NYzsGa
 v0mDLQdLWRmI7x9TGYzshphtIbSQzFhT4bmtZPbtI/3+HR70wyyEaamRhOvCC5NfMCk6
 FW15mvZNELv7uZMsmWP0MS/Qr6ToTfvuOIhoUiNUxHN7dod2ov8UiFU8kn+VoYncMI7V
 ZWPuRWZI7BTJwCLz6h9i1vQOKO1QJWmvLww3NB6l0oqzV4XOX/Sw8ku/dFR8rEETdURq
 Vw6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794939612; x=1795544412;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dTcJz4+wSZXE4Tz0CMYv/nLFzh+o+0XlNh1cRPUp5UQ=;
 b=l2UbYdfP07VGt3M9rG51fRw08S+rpTANcuw4g5ipG1NlUDxMm7jHFRkfvr6iUa1DZ6
 INcIHotMmsMmifpQmfu+dU4tuySGLpb2NzIN2F8+3SSO+aVKBoAEpf9sO4LnK4W26Pb7
 KrHcV0TQBOjY0zuNfIsQ/cL9zDg+XrHFuY8NRpGkrmjzf2fEZ71/MCzI1jsFmZDty35L
 6FMeU/QzB8goUIBHxpdmPUukdoKABdqyKTlWJww/7IIozUYv9YvR0hY5Oi49yQUrv/8O
 NNWdN9iXNxXm52ZycvB56A4UvUlwkcE5JERVE/fS+V75d+FlZQRVrZnFXl57ytmteyGu
 NoPQ==
X-Forwarded-Encrypted: i=1;
 AL+hErE7yd0oQhHyiPJAq9w1AffbaWaa/vw6xPl1SSkDOX77fPfjMjjJIJaIi9ACZbTUtgkjvP8h7Q6UenO50jqu@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+HoLcKre2JwxOr+CH1yRyzTP8twvob7/gs5lhfZNmE6x3/zBhI
 1Z6kKceMCAnskucEwjCNBKqyX8PgLfnWdYiulONlu7tH3Oo11qWnhS1JfuYaQ33tSQs4V5QToJU
 RDYwAI3X87nfToRgxom8khbrr/v7xukodFjIh31ttcvADdYT8BKggng40zSi9TrQObSHnxtPwCb
 z7bPstqQ==
X-Gm-Gg: AYBFou2RpWfAqcNHJqz3xzbUOIyn/wvzXbbsQDOiXvLIi46s6eQALAZqCpB1Vribn50
 N9LxXJXD3iFj40atKt9tFR41hNul1+dNrxdGlcXNlzLHldc62P7kAqWEkE5XSKYp/+H/pPxb9yv
 Euo50LkVL03Tz7bh+gN+7hr3eo/EGzexJtAnCFDGvXgNnpdTJ75bl0V7yqRrA/w/B4CIw8YUbp+
 lPh+Qv5S1jYVZ39kPL8Q6Ad2SCuKzeVVFwIVOrc7c8PA1NfdyHsG8eNJpI2hfUHETU0SNaVsm7E
 orivwAKSnOCkeaRRL+EVK8X6lIPIIENlGFKz5gCXa4c7xRIN0hNKf7BL0LkPHCx1PjdKGQZ6EN4
 WXdzFcdWmtWbPUwgZF+ziTCMqpZF6B2hGqnJbucVxy7VIqowVeTx7nDYUr62GmvWA+aJXKKQm/z
 wliz68u4w7HeC2DY8RiBXgIf1C1gfMYpJaBiTUFByEUCyfZtM0JI1myic2/pnKNzlz0TYHjKH2m
 uQZgsFdBe6f6u6HfmLBZKnooATtN1Phrcy0rQ+VG5M6NNIC1fo5dsIVyW3BfkdTazup63yxhM1w
 uYVIuw2gRKMaXJ4K0aB4l4UEvSCKFY7ap+vlUvR1SCtaM7Rq3PBSjMVAp2povcjspOxHTKc2rWe
 3/41q8OHm2jr1HQ/cfkdYoR8WZ5fOz+5o+Y6S+WCAJPv+TpsrDxPpHeFpJnva9gjMO8+ldAkX9v
 n5vUhda8RadF6GUCM=
X-Received: by 2002:a05:600c:c166:b0:4ba:6d8:df8f with SMTP id
 5b1f17b1804b1-4bb55a832c0mr342302155e9.15.1794939611867; 
 Tue, 17 Nov 2026 10:20:11 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb783f8154sm91446625e9.4.2026.11.17.10.20.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 10:20:11 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 18:20:09 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Id3a58112fffc8679978ddf5adb44e7be9083e17a
X-Gerrit-Change-Number: 2112
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2112?usp=email>
X-Gerrit-Commit: db5ed398462510e1e818420deb2c75d56018bd34
X-Gerrit-Comment-Date: Tue, 17 Nov 2026 18:20:09 +0000
In-Reply-To: <gerrit.1793747232000.Id3a58112fffc8679978ddf5adb44e7be9083e17a@gerrit.openvpn.net>
References: <gerrit.1793747232000.Id3a58112fffc8679978ddf5adb44e7be9083e17a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzQ3MjMyMDAwLklkM2E1ODExMmZmZmM4Njc5OTc4ZGRmNWFkYjQ0ZTdiZTkwODNlMTdhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ded4461b1fb3ac8d4a3b651ad17ac5b3d6bb6a8f-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xTNn0-0000000067N-2zdb
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpnserv: hold
 the service pipe name with a private instance
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
 openvpn-devel@lists.sourceforge.net, heiko@ist.eigentlich.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0981568612164562472=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0981568612164562472==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rqoG9KgWjTE="; charset=UTF-8

--rqoG9KgWjTE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Heiko Hund=2E

R=C4=83z=
van Cojocaru has posted comments on this change by Heiko Hund=2E ( https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2112?usp=3Demail )

Change subject: open=
vpnserv: hold the service pipe name with a private instance
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2
=


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2112?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-=
Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id3a58112fffc86799=
78ddf5adb44e7be9083e17a
Gerrit-Change-Number: 2112
Gerrit-PatchSet: 1
Gerri=
t-Owner: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-Reviewer: Arne Sc=
hwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <r=
azvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourc=
eforge=2Enet>
Gerrit-Attention: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
G=
errit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-D=
ate: Tue, 17 Nov 2026 18:20:09 +0000
Gerrit-HasComments: No
Gerrit-Has-Labe=
ls: Yes

--rqoG9KgWjTE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Heiko Hund=2E </p>
<p>R=C4=83zvan Cojoc=
aru has posted comments on this change by Heiko Hund=2E</p><p>Patch set 1:<=
span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; pad=
ding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2112?usp=3Demail">View Chang=
e</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2112?usp=3Demail">ch=
ange 2112</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2112=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: Id3a58112fffc8679978ddf5adb44e7be9083e17a </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2112 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Heiko Hu=
nd &lt;heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvan=
c@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &l=
t;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit=
-Comment-Date: Tue, 17 Nov 2026 18:20:09 +0000 </div>
<div style=3D"display=
:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-H=
as-Labels: Yes </div>

</body></html>
--rqoG9KgWjTE=--


--===============0981568612164562472==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0981568612164562472==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0981568612164562472==--

