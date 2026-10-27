Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99B5606A31D
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 11:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=PHM78cH1;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=T3GlB68Q;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=f57eAkpo;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=I96UmUFk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=90rPZHPDOA6epoHJb8CE2MtoAsavkK+fPxmcoVCEGhM=; b=PHM78cH1UMC0AVkYev+kLUhFng
	01ZDaTxC8A9BHJmY127/titkJVZwJpg1YXIAlN3MySkcm8tJhRPfb9of4jVxcamqxzyFRKy/yt+w5
	QbVnxfggP+5l0fDXCuTIILaFjr5mH9BW9geIs+/Nca1+9ayKi7rSfIwfArV852ma3w1E=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLfUN-0000000041G-2Kzd;
	Tue, 27 Oct 2026 11:37:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLfUM-00000000418-1hLA
 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 11:37:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=moJXk9LwAWNIUEhN5KyFsH4ODFfpXS1EDh9iN7LANmk=; b=T3GlB68Qvp1TWUeQ+tvTqXnqri
 UyZkYwGXBNNEs+u2O4uBt75B9GrinULBp8eE5HS+UaoSOGZiDv+2cYYE5zfRaCFcTVdCiudOV+b7D
 mr3z9gy10det+U/dEeXLSQHc9f9pveiW31cZTaeZbo+D79fXhU06WOXtsGv9fwhFWjy8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=moJXk9LwAWNIUEhN5KyFsH4ODFfpXS1EDh9iN7LANmk=; b=f57eAkpoeuobCLDEuUvQd1PZeW
 iv2lIqkbO4q84YtQXgKNUQdqaFoXkSI3dl4IzTtnX7XPp4XAqglvDHfzSH1pNpKEZ4SFATYfIiLNW
 PC1SEFrKYX+jPtKxiT+UwH7pO/z2GsDGGT9cEpkRlFgFT9LbAt5VhjvCM4wnaPVmBsNg=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLfUL-000000004pV-1SL7 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 11:37:10 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so28939955e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 27 Oct 2026 04:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793101023; x=1793705823; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=moJXk9LwAWNIUEhN5KyFsH4ODFfpXS1EDh9iN7LANmk=;
 b=I96UmUFkmPsDT3a6wrQdzEhdD4tof7DIBS5UFFU1KEQDyIRzfThM0R1U32bhe88STs
 VxOw2wF9viPsr9Pzoi2INCLJTq/D23LxbjuLzXvqvcOG9YVc/g2QyrsMGjx0Xwa7fa8n
 D1eJohncfkmXj84XWnW4LtbKwnPjLoEcgnzxFrdJT/SuXl9PaK1lxASHVXpvla9ATB+t
 KwhgBIQwZhdOeRa26b0LOyKwVcJmKm0BjY43TEZKqlPtmSsTqCjaTtK3sN8qMN6nRLsV
 4sHFX92Es5Yp16Vp0kAWy48HjzAONaFDfSbdlavPjwui8GhJlewP1QLqQmR0ot8Ta8Mv
 heLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793101023; x=1793705823;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=moJXk9LwAWNIUEhN5KyFsH4ODFfpXS1EDh9iN7LANmk=;
 b=zKKv4gQHMe+ZUCdGemBstewfx797LDW81vjy6Ji2EsqDVfd5FK3/BfeaVRj83wZmcF
 ynmMyVKTDxwYf0bE2Saw5yWpfJb72/CQY3JP2uv9n+O2mL5qckJwi0LxMNVrfdkCUurA
 bSqXgYmW7YJrGSBBAXp50vfg6+V7yqY/5ASngSedGzWe9l+ovdoRwlqtFdt+RGatVaQI
 9dWnlynpNC6pD6nQm0Tk8pb3XDVteWi91hOPrsVuzkQt2Va5D/VMS1nrA7wP/krqrBbD
 9BtEUGD8jY7fy7vFXhY4Sb0YxcMii3NtQBSHDpoMx3jsE3MVHk9jPulDUHPbxT9hkqw1
 HuZA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxehuBP+RoDhj3T5PMTx+RfhLNOk9ckBVvhVYEpN+dMbz59xruxypOxb8SAURZNgdB69euXdo46Mekn/kEo@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIF7w2/AhHAQXfsu4KDGt6We8zCLUzci81Vq/W0hegkIAHaYZ4Z
 zWH1cCS5XYTFb+TgF5CdPoUh3zDnlmbv5F9JHo3TEICg6Stqu9l3MiE+bbv8rk2oemdMcltEVB1
 EYkbimRbnrOrl3n1mk/aUWGSib+kRQZdl8tjRVCpbyq12ZBqdmfppr9ovcbBH6h9ZBz+Y
X-Gm-Gg: AYBFou2m+cvpy3uDgbsUcVpN7+3DUCoj5aOx34DRivDktrvpZp7iVDO+W69SeBZX5Ej
 X/zCYkOevVVw78gR8n6+mXbzmPVFzVG5q/DarJ4SNuEbdT6k/lV0cyoHdMsRLQdoCTK4SsI2hxy
 ooY2gXkTLf3XoNcBV3DkXR7XNfUvjZUu+gZMyyThf2Kq/EgMtVzl2e4Q4+ocoJltI/OpY0A1Njg
 xAk0BCOIqjHh4MEYtdeKUZyqg18rx6BKfQ0Y1/OovXYRmP2WkGUjT0e1pSAy8j30dRxSdUVO5xl
 eRnc7uTX47iYBdmPQvE0PraWJyeVEda3TuEPjtGHUKyFQ+2LJut2fq2e+j/dpD/96aWfbilt9lM
 EHVL/WV+TYQIPQwVY/vdxf+lWuVDSUDZeTjLWf1u2DfF5pEv+LA9G92FWBLjYBdNeni8RSup2HI
 XmnEYSr+Q3FqRKR9nKFL8m5sz3l4bDtBXq2HhBBXlRykxfOPB8BwPIzd0ToEpmbZGdq4A4NyWAg
 MjLcCH34VwoA4T0pozVOzlH61YTRI8gQv4o1Ei2Eqh32ivzLTqF+w/Er4hyqO5mBlvczKT6ZVvq
 VlVI8vzY0ZAAfovTXPbLdZ/AfwMFBVphKWvjZjVev1eMmOI4fEZUKeHHxdGaWwVNjgGA4GyFLUa
 CltQaPIE/D8DyHIElnjCTbtzncLD7SeDM2ssgWpJ/Lw==
X-Received: by 2002:a05:600c:8595:b0:4a2:14af:1ead with SMTP id
 5b1f17b1804b1-4a35acd5f86mr133839565e9.25.1793101022571; 
 Tue, 27 Oct 2026 04:37:02 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3eb8f305sm20672733f8f.3.2026.10.27.04.37.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 04:37:02 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 27 Oct 2026 11:36:59 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ia7a31ff1c3792104101cb2e828be3b7fd8f44156
X-Gerrit-Change-Number: 2046
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2046?usp=email>
X-Gerrit-Commit: 5219cd07ee23243dbc5ed986ad78aab34458435b
X-Gerrit-Comment-Date: Tue, 27 Oct 2026 11:36:59 +0000
In-Reply-To: <gerrit.1793094393000.Ia7a31ff1c3792104101cb2e828be3b7fd8f44156@gerrit.openvpn.net>
References: <gerrit.1793094393000.Ia7a31ff1c3792104101cb2e828be3b7fd8f44156@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk0MzkzMDAwLklhN2EzMWZmMWMzNzkyMTA0MTAxY2IyZTgyOGJlM2I3ZmQ4ZjQ0MTU2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5c45c285f6b58c5c6d7b25d76ad1bbb103002a0f-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLfUL-000000004pV-1SL7
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multi_io: dispatch
 UDP events through TA_SOCKET_READ/TA_SOCKET_WRITE
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
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8567482547832277580=="
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8567482547832277580==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VDyLJtxTP+U="; charset=UTF-8

--VDyLJtxTP+U=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gianmarco De Gregori=2E=


R=C4=83zvan Cojocaru has posted comments on this change by Gianmarco De G=
regori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2046?usp=3Demail )

=
Change subject: multi_io: dispatch UDP events through TA_SOCKET_READ/TA_SOC=
KET_WRITE
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 1: Code-Review-1

(1 comment)

File src/openvpn/mudp=2Ec:

https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2046/comment/2ca8d0ff_900a37cc?usp=3De=
mail :
PS1, Line 489:         multi_process_outgoing_link(m, mpp_flags);
Th=
is used to do nothing if `m->pending` was `NULL`=2E

Now we are going throu=
gh: `multi_io_write_link()` -> `multi_io_write_link_pre()` where if `m->pen=
ding` is `NULL` we just take the next packet from `m->mbuf`, whatever that =
is (TCP as well?)=2E

It's not fully clear to me how likely that is to be a=
 problem, but it also doesn't seem impossible to occur=2E



-- 
To view, v=
isit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2046?usp=3Demail
To unsubsc=
ribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Ene=
t/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn=

Gerrit-Branch: master
Gerrit-Change-Id: Ia7a31ff1c3792104101cb2e828be3b7fd=
8f44156
Gerrit-Change-Number: 2046
Gerrit-PatchSet: 1
Gerrit-Owner: Gianmar=
co De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@ma=
ilbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2E=
net>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Att=
ention: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Comment-Dat=
e: Tue, 27 Oct 2026 11:36:59 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Label=
s: Yes

--VDyLJtxTP+U=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gianmarco De Gregori=2E </p>
<p>R=C4=83=
zvan Cojocaru has posted comments on this change by Gianmarco De Gregori=2E=
</p><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block=
; margin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</s=
pan></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2046?usp=
=3Demail">View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none=
; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/mud=
p=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2046/comment/2ca8d0ff_900a37cc?usp=3De=
mail">Patch Set #1, Line 489:</a> <code style=3D"font-family:monospace,mono=
space">        multi_process_outgoing_link(m, mpp_flags);</code></p><p clas=
s=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">This u=
sed to do nothing if `m-&gt;pending` was `NULL`=2E</p><p class=3D"blocks" s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">Now we are going thr=
ough: `multi_io_write_link()` -&gt; `multi_io_write_link_pre()` where if `m=
-&gt;pending` is `NULL` we just take the next packet from `m-&gt;mbuf`, wha=
tever that is (TCP as well?)=2E</p><p class=3D"blocks" style=3D"white-space=
: pre-wrap; word-wrap: break-word;">It&#39;s not fully clear to me how like=
ly that is to be a problem, but it also doesn&#39;t seem impossible to occu=
r=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2046?usp=3Demail">change 2046</a>=2E To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2046?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia7a31ff1c3792104101cb=
2e828be3b7fd8f44156 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 2046 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div =
style=3D"display:none"> Gerrit-Owner: Gianmarco De Gregori &lt;gianmarco@ma=
ndelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-deve=
l@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-=
Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: Gianmarco De Gregori &lt;gianmarco@ma=
ndelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: =
Tue, 27 Oct 2026 11:36:59 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes=
 </div>

</body></html>
--VDyLJtxTP+U=--


--===============8567482547832277580==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8567482547832277580==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8567482547832277580==--

