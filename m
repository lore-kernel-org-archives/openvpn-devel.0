Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46A7606A31C
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 10:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=lpljfwsC;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=efr+mDvP;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=RQ6HDl77;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Hnfy9kmm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=5P8SHlVLwggHa5QUmxAVA/TjSzq+hijT/i1CM067opE=; b=lpljfwsCESznnr7F4gQ/qefG3G
	5WUzE8FjAeOlWBMzn3634Ejj0qt/D4b7Oj5EzOlcIEWdUeKarGCh7UfUHXMq2iGLMhf60yOTxdG0g
	gYZD+mrc10R5Z2GeQXfnaKI/wXj6yf4UoOZrKTCNMaY3QgMolGHk/onQg6dWirn1z5JI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQjXU-000000000fu-2zLX;
	Tue, 10 Nov 2026 10:57:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQjXT-000000000fn-1p73
 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 10:57:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6+YoFmcqIYzTpNDsO/s7//auVRlFzbGIQRy62mNMQio=; b=efr+mDvPMsKF5Bi6UyGS0RUXxg
 2cOhpuk634kiPJJnrjzF69HCTRW32EsD4/Nazp38NnuCIiMgKrM+d1MzNQ6kxXtuLNfUJw+dxDjK8
 BcMj3VCS1gqsfKIgyX+qDWoEA6g9EQCIj+m+s4ICu8nWiXeFZQQjYG69Hfl5lu8pJO8w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6+YoFmcqIYzTpNDsO/s7//auVRlFzbGIQRy62mNMQio=; b=RQ6HDl77CL5UgD+zi4rdGgXnwQ
 ds/8fuK059GwrQC+OuPMidO3UcIRN5+25p6QfJN3h75YlTGauphiHZGa0hMpgvFhAAXRwuv5tyeRk
 e0d2H20ud9NRYvTbS3/KneFw3+OTCdjSAxq294zw8iXpGr7s1OA+RewBt/wLqqd1DT1U=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQjXQ-000000003kf-2S79 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 10:57:18 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a5036bbac7so12078635e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 10 Nov 2026 02:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794308230; x=1794913030; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6+YoFmcqIYzTpNDsO/s7//auVRlFzbGIQRy62mNMQio=;
 b=Hnfy9kmmokpdheO6XOKVj+0bvVkMO+gVGkYRgi7IryEy45nhC10L3/bf79NSOzx6Wz
 SRyLVWtVfkjtdZpy7MgDC/F1smtvqDJ8Wcyok1trTbxed9Q0W1DnQLxTYAztc03SKGP5
 9XtV1Bw/xQiV5ozoRp0REUqmR4hzl7yV1vvrSQdnAoJHPYuupq4/SHyVaScrJz95bOdy
 FjVHI2YeIzJqv88u0VJX0AVY4yqmkj0Bf8GvxOUgwmaBI4paOaGMgKM7/fhECwyqjnsz
 814czc25NdjL0o87W/jwrHy1UZNTjnuu3moT7Pn91g4fsiZAv7dBSlUJ8DnBk/hLcWRd
 c/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794308230; x=1794913030;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6+YoFmcqIYzTpNDsO/s7//auVRlFzbGIQRy62mNMQio=;
 b=ORWux2q1CWnV1BOqDV6w5kJ3+0vD8Y6kYabX4lWH82RMh3c0Riay01l+aQcCowPLPM
 Do5PipaqDdKzilzdPBNWW+xMlSsqhmUw+AY3GW4hBGIfwZgz1EjeNGAafKgjgRb1qw9w
 gWVN370+3H85boRpyoZzb6UtxI/jDRgnOvLpVLLFss5ubZd5h1zaDux9IQo5ydFliz/1
 +7WyY/jQpbbJVpAId9Kd6RbNqnaF/k4EwgInpN2yJ8ba2uIkbZR8AotBtLVmlKDDUJTL
 Ctirl5UJ4uo75fjw/T8xocNtW1nn2Z2zzxitZVKReQh45j/OHhO41DwwgDcBF5pze128
 34bA==
X-Forwarded-Encrypted: i=1;
 AL+hErGoqZVoOiOsmw/0di41EBX/7pMjbsw0eoblT3kL93qOKzgdW3gWawo63oHfWlGdgk+acsdRnUVfZgFTeSC/@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+7LSSmbkIXVKtNAmQ606bCF2Mnwu1PgRwnnWish84cg5nqVVYO
 V5TNmtsnfsvT0nBo5U8dsqf+1ePLUcRRZf4YpuJtMC3OxwVnu4jhqyZhMDy6UfaEMEdQUSRro77
 n5mKAvHhlCnscNaZu+Y1DDwhvKUBCmq4fQ16a/67DwJao0p5Dnwtzwaq2vJOABeH1G64vGLrfbk
 LVDLsE8g==
X-Gm-Gg: AYBFou1b90bS1c4CJ//S8KO8VwBtMCpzybmqh39HxEAfUv/eNBFNtDbTme3btZz67KF
 OIFaMGkNqQntBpnYwS5sYxfopsn8JuIGl439LJvE/97XEbRB7lrI95nVHvKz2jKsFrJjPz2EHpR
 LhNIJRyHqSSyspbBWBrwg1kJxbSTYSGiWoq1jhxIy36HbcWgKkG9aHA+UclgHijRymahr5ERDPy
 I5t22CnlfEu5ZYQCuTWlZd5VIuh4tw+EzGNlNlDkIb1i4dSmawBTomw2ZuFbTNeLIRrSQR0jnej
 p6uGGEPtUgSrpekxflD8Y/mx8Ip0MLRex+a6g6TjgzGvV2V7S2GqpXu+g1tXFsGIlYIW8FQUkjr
 pHrRlRDm2sLHPxTmIgFI3ETDVaty3nRWqg7P1ajnWHY7Q1fyb/xhN8A6ZLM99fSU0DYpIA4q3Px
 RIWdtmKGNqLhoDDFmyCDEM9BFMmNRc/K8HZV3kdbnArtPFv1DwWmXQDCTC4rVCDXHCacBwwKHQd
 Qd4JMhCVr4aPz/5X0Jo3rZBdKMZyX0UwkCDFJSfmrLbB+5gLWc+X3cFSlvZ6lQphjB2YygAw4Ol
 GpJjTnABEUDMIn5Ierdw73ejqoIN94Q8W9yC+gDNbEsahV41TNkKe9jLXdF5O8iB1c0FsYovpxz
 10Rj6BRfIHkyG9G06WVACy6uOauOter/qF4yHodGC/5UFxub6W+4TFuCHnGonpCgr/cRobY7GP7
 WZ1JP/oo0H5dAJWUg=
X-Received: by 2002:a05:600c:3143:b0:4a1:78c5:79f5 with SMTP id
 5b1f17b1804b1-4ba02355f49mr32455655e9.33.1794308229852; 
 Tue, 10 Nov 2026 02:57:09 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498365cbfc6sm4654194f8f.41.2026.11.10.02.57.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 02:57:09 -0800 (PST)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 10 Nov 2026 10:57:08 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I5c52cc5c3aaad21d1c22f36f6451235302ea6c4f
X-Gerrit-Change-Number: 2163
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2163?usp=email>
X-Gerrit-Commit: 0f6899deddd6d9cf92cd27ed4feaa20ba7745a81
X-Gerrit-Comment-Date: Tue, 10 Nov 2026 10:57:08 +0000
In-Reply-To: <gerrit.1794307698000.I5c52cc5c3aaad21d1c22f36f6451235302ea6c4f@gerrit.openvpn.net>
References: <gerrit.1794307698000.I5c52cc5c3aaad21d1c22f36f6451235302ea6c4f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzA3Njk4MDAwLkk1YzUyY2M1YzNhYWFkMjFkMWMyMmYzNmY2NDUxMjM1MzAyZWE2YzRmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1ccc4f13adb30762f404aac47196b4233c5b260b-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQjXQ-000000003kf-2S79
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: sitnl: put the IPv6
 member first in inet_address_t
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
Content-Type: multipart/mixed; boundary="===============1911267253088891486=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1911267253088891486==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="d5nOGnDh0uk="; charset=UTF-8

--d5nOGnDh0uk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Antonio Quartulli has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2163?usp=3Demail )

Cha=
nge subject: sitnl: put the IPv6 member first in inet_address_t
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Rev=
iew-1

(1 comment)

Patchset:

PS1: 
please, let's use CLEAR() to make it m=
ore obvious and avoid hitting this bug in the future=2E



-- 
To view, vis=
it https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2163?usp=3Demail
To unsubscri=
be, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: I5c52cc5c3aaad21d1c22f36f6451235302e=
a6c4f
Gerrit-Change-Number: 2163
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zv=
an Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Antonio Quartulli <ant=
onio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Atten=
tion: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Tue, 1=
0 Nov 2026 10:57:08 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--d5nOGnDh0uk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Antonio=
 Quartulli has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2163?usp=3Dem=
ail">View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; pad=
ding: 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2163?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
please, let&#39;s use CLEAR() to make it more obvious and avoid hitting thi=
s bug in the future=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2163?usp=3Demail">change 2163</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div i=
temscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2163?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5c5=
2cc5c3aaad21d1c22f36f6451235302ea6c4f </div>
<div style=3D"display:none"> G=
errit-Change-Number: 2163 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocar=
u &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comme=
nt-Date: Tue, 10 Nov 2026 10:57:08 +0000 </div>
<div style=3D"display:none"=
> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-La=
bels: Yes </div>

</body></html>
--d5nOGnDh0uk=--


--===============1911267253088891486==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1911267253088891486==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1911267253088891486==--

