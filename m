Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8225C606A324
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 12:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=NfGv3CXh;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=aNj1jj59;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=l5anYbVR;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=PjSY8i76
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=pBFfyJhW8uvL8V9KItrQ8BMKmhDhJk1tc3Fc4klOMRA=; b=NfGv3CXh+YFe6SlKPFCG84RGXg
	yP1ohAtpeCxtWCF/FwnjcIjkJpcl9HUZRgisl8tQUHDSEpZNjsLz+lWsCTzNyNK0p5q69NnVfJn/O
	TrC4lh6lj0DTUNzWdgxGwdft/ve0C1+wvrl3hMDElj5QkuS9av5f0bxZa5T/SIiDMVCo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNqpN-000000004PT-30Kn;
	Mon, 02 Nov 2026 12:07:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNqpL-000000004PM-2WiH
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 12:07:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QiUbhg/Yg7XmgRKJRfRX0kxjAJ+7a3fbSn9u0Gdcjhw=; b=aNj1jj59eu/K9BUpv38PeU98zx
 1TkpJIdWlhn7pPLgEjyuBUzHCdSu4aeBXylTKZC0ycmLRSR8CxpP61wV9sT3w5gVkKj2Y7lq7grNw
 xNIWZ61tFbM3fvyKyZpjOB4r4pCtFliJYd1K8GvvWQ/LVYMv9/ByUwzUiT/H4PW1J+wA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QiUbhg/Yg7XmgRKJRfRX0kxjAJ+7a3fbSn9u0Gdcjhw=; b=l5anYbVRafoQhCmD8Ddp0hfnkX
 67R+bOaY0tPaGbyiYqQ/5vJMmLQP5HYVoh8JwOWP+4T7hEVWYYxqcEpjV/iFcgHfvSm7TjyirDhK+
 Xzp41VzP9THt+un+I+PjwAKfSNgDScsyNi8B8RvHVZ/vldLBaUITVGVZb2rB1+iSGa2M=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNqpK-000000006Cd-0h6r for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 12:07:51 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48e10a70540so1612280f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 04:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793621263; x=1794226063; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QiUbhg/Yg7XmgRKJRfRX0kxjAJ+7a3fbSn9u0Gdcjhw=;
 b=PjSY8i76cBaljRgfYdn/PyEG43zgIhSTebx1isu5vHosXSbqTu4h2PaV5hFBOA4qgL
 cjmSIRkQaetMXyWbF6EwGjs7jbWd7EA1jicPa5iZVDlu5gJlowCcwsGMXVgM9qa66t8U
 3QKZ6wB9IhpnbAs0jRc2aDoMivmwBXrB7VDuKvna9g1ueIACK0Ejw6o1fXyZniezLLTv
 HM4htPiCJ5pHno7WbmdnJxXpS0phFZignM+FTlO7XSt57N1LetAlH3OMaaIdEJta++jY
 PVAIuAiSi5D0xZGJ1M1T9QnC7cZ+Rd2lx66B4BC2iHobss3HxZ27Sujdcq02USfkPgWM
 nfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793621263; x=1794226063;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=QiUbhg/Yg7XmgRKJRfRX0kxjAJ+7a3fbSn9u0Gdcjhw=;
 b=AECGQvGdc+hFrDnEwSTQ6Rn9STPoHrzq0SYiAtPKdX9aGqYysLw3ituNdfGsOjqvao
 2OA8TCOkhwRt6ylCfWPSesqgWZ0phSH+vgNo3wb6gSe5DsJTAwVYAyt00WNLdQuQ3UbU
 Gr8t8aq3hVEAt8xd2Gdfm663zyXvXEE5x2797Oe5NJ9kq2mwF/aQKgLHH7R5RsQlJTT3
 Ow9/bcr7bbalwpwZf5vJ8SThWb/ePc9N3VqlYYkWcbvYI2aPhqqtDPc1DHlxsWkNtKtK
 meO0sCUIq8lD4MHbI6PboUppEAf2AIC4WraWFJ//59iraCUqzv249tJ6NtU0cdGcjyF/
 upZA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzOr9ZkGLmeuudSIDXmIEPnzpKtaJUHdlKUiUgEJ8krhSmSS2Mc4HGy2eTEIHIfGPZn4dtIVLky6+YXiDPT@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9gX7rWk0pX4xMRlPVgiBRBzmZP1bve9pzeRalUGJl8USRiwJp4
 3vnphbuee/ovXQlnFXW/CSaYTuu/kKgobptDxFyditofR/U6KA+pYuF7muk7cDC1kjtQB60VRUL
 PsNNSwRIKg3tlYENz5lOVJWjfzi8/0wfKSgs1sBbVLkPNg7o5kxVHRvnPGiRXuOcv00+4
X-Gm-Gg: AYBFou2lyG7iS4Zg8eCBlGfkD6OgyezAHvGNRqRU4/1R0nUJ8iDe7A+A7f/jqfatj3I
 a+7KnVTBny9h5jAmad737IXw2GgLmN+IwhBPK2Z5IAHjTR5J7mtUcSxXxFqP+stTpEkLlXktg0N
 w8aODsa/cH5gvR3zm8TSOgz6aAUn1dHJa74oWJQJBor60WB/45k01eT/JFTxADHtZ8sGn6vC+zY
 iFaPG8aItWF+gkN+HSIuIbQaBIHPx4L/mYCtuE3K8poOHUBL98lQyzzYRtSVejQAbLyS5s0qeeD
 BKyLnbW9wEDiVFZDkPCU5z5KRG5dPybQj+HBta1N6aGgmB35FZ60AoG/RQSjrDUQuJonpoEmJ3o
 upaGqPGBURFVpygf+MP8bV8eybSGHoFFjUu0JkQ3V6Ei7hlVmzciAu9y2yuAPRQRDTaXr1OzAz3
 YrLAHI/3Kl2GeoRyoHj+4nQRqFpfA1AXaZZzIR5JAX2j9v+2c3vuS1ztA2xXZrOq14O6A0zHphM
 6EjJBuT/IvFxdP0Jhp/nuC9ic8p2TBxULIHndjR9D/QT3nKUQoqmNJhlYrNgXkKHpqNynr741UE
 aF/cE616dEKAJw8luo8WXLJQ3h424rmZmu78QeMWH4m/z3BdYCv+aj3GXTq945oZOdvGbLCUOAr
 GK+wSAJLBVufO0thY5l/gDLy7qsGo6W3gMcY9aCDiJJGtAlFTIVahtF8jDntFFNgho50oVE7Iiu
 DBtJDwJK21GMCsSA==
X-Received: by 2002:a05:6000:2409:b0:48d:ca32:e90f with SMTP id
 ffacd0b85a97d-48e6e5044fbmr23297073f8f.55.1793621263451; 
 Mon, 02 Nov 2026 04:07:43 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b8a5a7sm20802458f8f.37.2026.11.02.04.07.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 04:07:43 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 12:07:42 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ib9164e1c8f5e02a2253bbb3b2363a4f9f31c8bdb
X-Gerrit-Change-Number: 2085
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2085?usp=email>
X-Gerrit-Commit: c0cb4cd1e1bc6c6fd946387680a5a77edab3898e
X-Gerrit-Comment-Date: Mon, 2 Nov 2026 12:07:42 +0000
In-Reply-To: <gerrit.1793619070000.Ib9164e1c8f5e02a2253bbb3b2363a4f9f31c8bdb@gerrit.openvpn.net>
References: <gerrit.1793619070000.Ib9164e1c8f5e02a2253bbb3b2363a4f9f31c8bdb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE5MDcwMDAwLkliOTE2NGUxYzhmNWUwMmEyMjUzYmJiM2IyMzYzYTRmOWYzMWM4YmRiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <96fcaca2438813aca2e5031963d5e21e587fa629-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNqpK-000000006Cd-0h6r
Subject: [Openvpn-devel] [S] Change in openvpn[master]: init: check
 parameters for NULL before strlen() in send_cc_message
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
Content-Type: multipart/mixed; boundary="===============3337952880397240165=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3337952880397240165==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pgcrs4s/erw="; charset=UTF-8

--pgcrs4s/erw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2085?usp=3Demail )

Cha=
nge subject: init: check parameters for NULL before strlen() in send_cc_mes=
sage
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 2: Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2085?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: Ib9164e1c8f5e02a2253bbb3b2363a4f9f31c8bdb
Gerrit-Change-Number: 2085
Ger=
rit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
=
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer:=
 Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru=
 <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-Comment-Date: Mon, 02 Nov 2026 12:07:42 +0000
Gerrit-HasCo=
mments: No
Gerrit-Has-Labels: Yes

--pgcrs4s/erw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2085?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2085?=
usp=3Demail">change 2085</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2085?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: Ib9164e1c8f5e02a2253bbb3b2363a4f9f31c8bdb </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2085 </div>
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
"display:none"> Gerrit-Comment-Date: Mon, 02 Nov 2026 12:07:42 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--pgcrs4s/erw=--


--===============3337952880397240165==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3337952880397240165==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3337952880397240165==--

