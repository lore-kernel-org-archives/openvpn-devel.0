Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82E9606A326
	for <openvpn-devel@archiver.kernel.org>; Sat,  7 Nov 2026 16:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=fyR9TMtl;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=YG1GVhxp;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ayMruT0p;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=TO8Y6sfv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=1s8tn6L2188jrxoclICV6KSstuqFSd9QGR+7VqgHo7w=; b=fyR9TMtlI6mTUY0i4PTTv6FHP8
	sGalmf7hxqWy/EyghrCgrsxChLBYV3wXmKb4+omgq4UMt4xLeNBUliGJ6hVdGDSVn2I9YBejzloaz
	DU2bQrXpcDKBNYKFPFABMFZdF675u8RyqakNUPx1nOSyXQNYQL5SJZoQMfDA4WFD8ruA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPjND-000000006ui-1ns6;
	Sat, 07 Nov 2026 16:34:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPjNC-000000006uc-3cVN
 for openvpn-devel@lists.sourceforge.net;
 Sat, 07 Nov 2026 16:34:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G1H65yu91eg1wMysT3lnliyq0KPOW76/hpMTJEg//BM=; b=YG1GVhxpv3D4NU+2wgzmCPVT5w
 6fkgkS1HDu5rnz4/811PzEWtNITtDUHfwwOskI6OjuKsvMdX27OnelPgJIi1nOzw3CbRaEhUtcpGL
 Oy4Z+N2y8HQCj2b+rFVTCD532dTyWZJEcXpw3o0RMocjUFFxfPkU6CoMwm/WylKe/uUc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G1H65yu91eg1wMysT3lnliyq0KPOW76/hpMTJEg//BM=; b=ayMruT0pgYHthZLzvvSULCpqYM
 E8ybkGUgb3H4qTs/TkYaw9ixBhE4380Z9lk6ifyEfkmwuM61+WEdzx7AK42kvQ8zRAnc/cPGMh+3z
 Hgfqw/5NUTqMF+7Dutrayfom5lEy4rOv1tFyIbTMztrpyXZVEWYyt0U25CX9kwWhrFzI=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPjNC-0000000064M-0prc for openvpn-devel@lists.sourceforge.net;
 Sat, 07 Nov 2026 16:34:34 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-492f563d1c6so427961f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 07 Nov 2026 08:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794069267; x=1794674067; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=G1H65yu91eg1wMysT3lnliyq0KPOW76/hpMTJEg//BM=;
 b=TO8Y6sfvr1+DhUBiXQR3dlB3S3ysm8rJTmFMwrXM/87M/5FTSg52KwsN1iYV2bC8EW
 tnh6vT0R5T+c3n/ySp3W6W91IlnNM7COC2WD7kw8okS64PO09/AXHWcK+JmeyowMeuYy
 gNOTIpAI6trqzKCqYdbWyt/RKbV4sQprk5b9VDbHcsMbj73YUlO6v9MC0yh2mEXx++ED
 RR1daR5V6uMxxN4w6dGfps4tiHMOi5Do+Zk/0OO5mERule1qJAJsRhCzIRp5iFKX9diX
 jpDTgzw69OEbf8DYxiV5zS/hceTxiJb4ll6YxDVEIsFzMAtPK2VeJxzseJO+y6viN+4x
 oa0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794069267; x=1794674067;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=G1H65yu91eg1wMysT3lnliyq0KPOW76/hpMTJEg//BM=;
 b=GxyxEw4KhPxWGIHr4xGwVvAtk+a99a0MR5ZYEUIpWwYxq7zUJuJ+qbZ6M9kfyn/MXx
 FcaCm0l4pj0b+fpyue55EPrTP19sDUxehtipLFEhxEnovjnsiwsBJh+ZqvyGBGNZlC3Z
 D2iELAn5R3sagQp+pddnYnfi0WVAO5f1ttJRWmBM+GYNUlFlE+mznvtGK49+pPh/wg9Z
 MMRvzn33ZVEYM8JfOmQ1uOEpwtxUvP4f0M++xeciDODyt7w5Y0yJIUUgBEzMAq4BoRkT
 CATcQGaJliJVreM3g8BZYIz3ToqOYfho+f3+6fNCrhfcuqFKG+urxinUOIEbk6LXdW4I
 dmrQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHryG4zBqlUtHfJpaqJDLed9ThTdRXDCHA4B+tUktEEQxe9BLNcjsg9i974pK8PQh327Nwqzvo5du4wlU2a@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8qnSWaAafKDlKdCiXehQJFvB2N3wecBdur5oMc96hAAbNKhGMM
 oXtd2ERucWGumi9sGsX1tpK9ky3Dl4budzC0thkkssDoqDQCfhkvwa9r2LdBqcUKdcKAPxME5s3
 XOo8WNdRW+I9K4JLucBNA+qAmF1PMQaoVkNd+d71nPl2zia81DTKacw/C5Jw2PCEF12L/CFUayD
 wjq5xR0A==
X-Gm-Gg: AYBFou26dg8zTGhZEglrYqkaQK+MhGzb2CL9Mmb6WyJFeFMun3g4zIgNiLY7QbeBy45
 328r4OVntwtZaYDlOCwt4GP1oAo8xjdWcUrAYhRs0JXwpZgU5H14KMnj5aJwfLU3jegvIFhLxBa
 +FV7GuNuvL6KUGG19G20YHJjqgg48P3003Bn4neWDS+VATvbpUzqCo5Z5xhAi0NT6h8TJWTs6cI
 ccnBEcKo2kTG0emrOQkRF7LxVKqH+F21o3eL2MUh+AIE+6fkdcWhG2FAS3eQuKWCH6VyQHZ1adX
 zfQc7EZBzMK+HOF22lU8BMzQPirdsC/Uh3pIaYPH3WAwJcHOFdFannT5hRsfh+itQFdk+0c1ZrV
 wWyksd7YK5JAvny53KqbF3xI1b2KWS/ZKLmaE9xiQcDHMAkceImEPMgAhiBo9yRiE3st48orLQ0
 6HBQkUmqDs90BPmiyFNcW68N2p2rRo561LJZxaEdkA77GHwBPtFdpA+hy7o7zfK5UJ7UkkHL+08
 8kLUS7rmzCuFk36yNtKfhkH4/TiOTnhsdoN0Sw263SbdphJzhYaz04T7j9hMctwPOlSztAf81vL
 bGkHk6SR/HXq6vxcMSiQFxtAqIrF+MGOeoog1zhjPFNi1eOdBlLuKWTBI0BZ+MeE/8guTUsHXM5
 r6gWGbNcWUzMmadPcKtUufy18O+d9LTUME+7jqaJy0AU0UXYBXMdYteGy6NT0WTXGUm5aNRfDng
 pDDEOtTTm1b7qNCw==
X-Received: by 2002:a05:6000:200c:b0:493:e0db:b507 with SMTP id
 ffacd0b85a97d-493e0dbb59cmr5102403f8f.7.1794069267019; 
 Sat, 07 Nov 2026 08:34:27 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d723310fsm10342648f8f.32.2026.11.07.08.34.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 08:34:26 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 7 Nov 2026 16:34:25 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: abandon
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ie9b2723486214232aad33991b267dc0ff4d1c535
X-Gerrit-Change-Number: 2150
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2150?usp=email>
X-Gerrit-Commit: b84bdc3874918f404db839989973dffa373a0859
In-Reply-To: <gerrit.1794064436000.Ie9b2723486214232aad33991b267dc0ff4d1c535@gerrit.openvpn.net>
References: <gerrit.1794064436000.Ie9b2723486214232aad33991b267dc0ff4d1c535@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MDY0NDM2MDAwLkllOWIyNzIzNDg2MjE0MjMyYWFkMzM5OTFiMjY3ZGMwZmY0ZDFjNTM1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fcdadc6d2928cd631740d1ea0a9e45f8dc852497-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xPjNC-0000000064M-0prc
Subject: [Openvpn-devel] [M] Change in openvpn[master]: route: add
 route_exec() for the per-OS route commands
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0757612225344301293=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0757612225344301293==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DLn5jAM3Cr8="; charset=UTF-8

--DLn5jAM3Cr8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

R=C4=83zvan Cojocaru has abandoned this change=2E ( https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2150?usp=3Demail )

Change subject: route: add route_ex=
ec() for the per-OS route commands
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Abandoned

Will go another way with the FreeBSD rou=
te code, as discussed with cron2=2E
-- 
To view, visit https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2150?usp=3Demail
To unsubscribe, or for help writing=
 mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: abandon
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: Ie9b2723486214232aad33991b267dc0ff4d1c535
Gerrit-Change-Num=
ber: 2150
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@ma=
ilbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--DLn5jAM3Cr8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>R=C4=83zvan Cojoc=
aru <strong>abandoned</strong> this change=2E</p><p><a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2150?usp=3Demail">View Change</a></p><div st=
yle=3D"white-space:pre-wrap">Abandoned

Will go another way with the FreeBS=
D route code, as discussed with cron2=2E</div><p>To view, visit <a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2150?usp=3Demail">change 2150</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div i=
temscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2150?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: abandon </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie9b=
2723486214232aad33991b267dc0ff4d1c535 </div>
<div style=3D"display:none"> G=
errit-Change-Number: 2150 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocar=
u &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>

</body></html>
--DLn5jAM3Cr8=--


--===============0757612225344301293==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0757612225344301293==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0757612225344301293==--

