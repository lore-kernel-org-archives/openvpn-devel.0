Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3471C606A31C
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=fSh7Bnc1;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=CzNEUDQ9;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=e+sjqyVP;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=aQkf3wbw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=P4ohI5Ij3fVIBjti9nM/erMtPO6m0cncmILAO4gK8D4=; b=fSh7Bnc1EDPrVyj5kEjItc5c7T
	HPMVJ/YaMgV+t4pd8kOpEusbKvjc758jWzrN/LwB/yOStac0uutZz2p55XMEsdEVjW8MiLvTfE347
	qkBsu+fRGKUu9b0XcpeKjf6ypbyMW7Nn1C+drPR1KtBi1SPjf6dJuxdKbZ3oNw3alqNY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xR3fP-000000003PT-3MlO;
	Wed, 11 Nov 2026 08:26:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xR3fO-000000003PH-0TpA
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 08:26:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VAgKO+1zuVj+0X9awQVdCQTBM2+y/1FYCdclCKHRpds=; b=CzNEUDQ9cZuo3RPGK4HMUYiHBi
 0jjWBAB7Ag5VLczhFqHvTHNkut7rXjudP4tvx885Ncoy2b7zScZQ+2O1DHS6ArfMyZXWso1MGPzQo
 9v6rIYjOzWvwH9cvDjsPlcYpDwJSlP3ZG70fdD1o82WXLA3ZLUPC5TOTZHJdB7YLZQrU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VAgKO+1zuVj+0X9awQVdCQTBM2+y/1FYCdclCKHRpds=; b=e+sjqyVPFR1vNhRb66bT6r2eHg
 Bcwc5Ke8+qec929yRcgqQyqS3ZX7w1pZth/X1x6ogJO9W43XevTbMfZCzV2oRqEOE4eDLYyI21tGr
 O4AlX6q+MBJwDn6prmIl08U1R3OIVXn1tm6jvfM/6vLlkGLuPl6RgG4Z6qoqhinw4BIc=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xR3f1-000000005Up-3s8y for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 08:26:50 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so19610375e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 00:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794385581; x=1794990381; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VAgKO+1zuVj+0X9awQVdCQTBM2+y/1FYCdclCKHRpds=;
 b=aQkf3wbwmK91LuQ4S9g6CAaV5mZAzkmDyLHVR3l8TOzFnrCfA21c+G23vSHLUkwSbI
 E4Wt+I+n7GyoBg3gt8o5MKUk/nNvHO6GIHrxtg79YI4qVSO7azY/TCa/ocblmk4xFZjK
 j5GvbCzVo8hroGWfFJEE8EfK9Md3RqmxTt/hJu/Sp8gXRCYZhaVb0F2LVoKvg4FpfSDo
 lC02h5MZTRIYRCuIX88KLuqy25kiK/AfB2y07zHFLQWpQh4LxG+/ufUkGC+UTY/REbmD
 bQhdXFkgnmLkYExljy3uOXmQ0x2H0IVuJV1X+PZ5+n7ntu80UCftWyH/G7FcHwvkQKV/
 fIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794385581; x=1794990381;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=VAgKO+1zuVj+0X9awQVdCQTBM2+y/1FYCdclCKHRpds=;
 b=TLr8bUv+JGBp7PREjUcPoM3nM7x0heiXauyisdKWAZzGKS42O5OqT/IOa8zPw1Kht1
 TxIw2Y+s8FBKUR9efaPFMHMcKtA6+TlApDWKSznUhtl0+67jXazM8Qum+OXv8qg4rXBM
 kT+sC4o/AUjeFUdkGI9ZUM+wGnBs+UPK/0zKPygGDavM60DsaqpPv1w+jGm0VJYWIF2r
 Sye9bTHc9n+k6CzTzu5YkSF/SwmFe2YFsVK4Ysr1lBVC1X+kE/mzFNod870EvZ6UUHl2
 0yH/dreQYCaDQkHBXA1GZF+Po5akDpBFikjUsloIo7ttFWwIiRtxKvPljqCjeUhTay0u
 3kxA==
X-Forwarded-Encrypted: i=1;
 AL+hErGyqG71KVWdiqesEXaSdcrqaw323bqVLf/0yVfNN1gTx+TEcrAgbomQacNZn2uNnG8Mt93XEEyOnMAUdBo6@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+QtR3lTNty3XosO2ZW/bSaYZuW5rhdSXZ3l2I99u//Fwbfu5Ok
 3bX0f4gRKuOrL7q2CiG8+4mKYhhdFebbDNn1gVCYDPsjLfTQp97k/3cldA3wIOv98nS3g5Q+Ykg
 tVv5vNePsUfLjvM22Bi5KA8m9JEVR/NYT2nQxVDve57NNjgI7v+ljjqnSPo7c3VzbC778
X-Gm-Gg: AYBFou3bVzQUHtVKaF6swnC05maSKnmUdnEgwGChvuM9KVOHg2QCQ8uuLERBP/mWcsC
 OycckLdmTBcoo8imWOKYHlYSYRB+FNaCfNm5jFM5tu9nSyaPvDaWQ9zEc3IGrdzb4qBGjpG1aAV
 K335ToYOYlqTNWvd3NNWyZutzUs040lAh/S29Ya7ikIP+64XmgbicGMTtyWWRuqyRBAdfCKkdOj
 bSWl8g/gZlh2OW0jvzHpo59fZz2sppuYMhR2sdfyyj03Ybf3tLOsPAAxP5ypddJPNskI677YP3m
 w5R1LRT/+0mMw5xnySwLWu85LAJoyN1GMxmeVzjguvdBlytXbk+vSdEJccsI057D5CZd1mmKlNS
 7O//a1FiZ3u83IXVYvx5QOUDgRklczMa3QIJOWNYuEtAt+ij8bSMiAxJ8REC4DB2kcJEvgTyoFP
 2QYVBstBX3c2rwqNJto9sVc4Cb2stz1GqHMZmOoGjLKOV2DnHrpj0hy61QcyRMAtHwEwcUjjMv4
 Lcil+3O1gIMnYmbjUut/Y9Uy79grcRT77yaUwHWuml0db8mJDfBlc8ieB9906W0SsQc258YnH5s
 AQZsuxJKFsr8cipVzyS2qpQMPzW2hP2/l5Y55/NENhLWVrXFQAAHUNAqxzEO2Ee6NbOZNHAIW6g
 mGBj0JInXjZiqjoVFWtKBFb0DtUrSZXEKiCvovsmAX8s2FKfUQ8n/0CX/v1qIMoxzK4iYK7yZ4T
 yiZIhuekl6cSPzvqE=
X-Received: by 2002:a05:600c:19d0:b0:4a1:ddaa:571e with SMTP id
 5b1f17b1804b1-4ba093aa687mr28179995e9.15.1794385581189; 
 Wed, 11 Nov 2026 00:26:21 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba0950f3casm25627785e9.3.2026.11.11.00.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 00:26:20 -0800 (PST)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 08:26:19 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I1295d911c993a02397565e26cece0f0861a2e5f8
X-Gerrit-Change-Number: 2171
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2171?usp=email>
X-Gerrit-Commit: 2fb1c6db2baabc706c18413fa078d7af5a05cf81
X-Gerrit-Comment-Date: Wed, 11 Nov 2026 08:26:19 +0000
In-Reply-To: <gerrit.1794384773000.I1295d911c993a02397565e26cece0f0861a2e5f8@gerrit.openvpn.net>
References: <gerrit.1794384773000.I1295d911c993a02397565e26cece0f0861a2e5f8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0Mzg0NzczMDAwLkkxMjk1ZDkxMWM5OTNhMDIzOTc1NjVlMjZjZWNlMGYwODYxYTJlNWY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <464ab894fbda449ecf24b78371db900dd49605ad-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xR3f1-000000005Up-3s8y
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: init: free
 actual_name when replacing the Android tuntap
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7645905437656970437=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7645905437656970437==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gbpFTtQtG/M="; charset=UTF-8

--gbpFTtQtG/M=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Antonio Quartulli has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2171?usp=3Demail )

Cha=
nge subject: init: free actual_name when replacing the Android tuntap
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Co=
de-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2171?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: com=
ment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1295d=
911c993a02397565e26cece0f0861a2e5f8
Gerrit-Change-Number: 2171
Gerrit-Patch=
Set: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Re=
viewer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel=
@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc=
@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>=

Gerrit-Comment-Date: Wed, 11 Nov 2026 08:26:19 +0000
Gerrit-HasComments: N=
o
Gerrit-Has-Labels: Yes

--gbpFTtQtG/M=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Antonio=
 Quartulli has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2171?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2171?=
usp=3Demail">change 2171</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2171?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: I1295d911c993a02397565e26cece0f0861a2e5f8 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2171 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-O=
wner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Antonio Quartulli &lt;antonio@mandelbit=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;=
razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Comment-Date: Wed, 11 Nov 2026 08:26:19 +0000 </div>
<=
div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"dis=
play:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--gbpFTtQtG/M=--


--===============7645905437656970437==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7645905437656970437==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7645905437656970437==--

