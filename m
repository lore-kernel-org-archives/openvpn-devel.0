Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B078C606A323
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 04:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Fbk/wEGr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=mjOQXSpD;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=LO7bCYBF;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=brib8E5w
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=1PB7XJmq7yU32rAtAniWfzRVv35z5sz91Ohc/R2/XEg=; b=Fbk/wEGrtTnEwTIKU2kkziS1yN
	7m02jRUu1Fr5fNYGEvT4NyKnpUMUHIjyfDuVab4aBPB9k0FM4WUKr/ocg20Pw0EhUqEK0jT/1z7lD
	u7h8Rz1oAdMTerMeADSnTEeUQySy0OOaq+EuwNKvULQ/h1OJT1+/nn8yTj6+Oue7HdNs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRMPs-000000003r5-3ANO;
	Thu, 12 Nov 2026 04:28:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRMPr-000000003qt-1tlW
 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 04:28:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=U7dvVRuYN0Iu6CFHiijCVS2GsAVgY1mWzOcjbk99LJM=; b=mjOQXSpDllzknd0V6Mblj1Y+sm
 gyVTGXNZ8Y86aS2fi/0n4o9Tbh0cNK31Oo1J6l+aZrr1SXvufN27Oi1eX81LTv6uZ/7Subvh2B/Uh
 5lMVJIUwNpSkfRXySNlI+liNMe/VCTAFthvAppR6os0lXreEM+oCmRA5W5CxOaopgeZI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=U7dvVRuYN0Iu6CFHiijCVS2GsAVgY1mWzOcjbk99LJM=; b=LO7bCYBFXSPwN1AIXkrUVEAE25
 MMP21xQ9/IkKDcqieehgRhAoNmeOLxeLVH4dJvNOQDT1WuMKxlEUoNuI8CskbVQJxbiiKZ2Zd0Ekx
 HcXO8qDdva73Ana4eUJTCukU1Z9eT54Aq4AoRWf3oeUK+XzC/JRYq8Z130rfUCLSxrUs=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRMPp-000000003Ft-15vC for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 04:28:03 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a214c5c4c0so37962655e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 20:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794457675; x=1795062475; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=U7dvVRuYN0Iu6CFHiijCVS2GsAVgY1mWzOcjbk99LJM=;
 b=brib8E5wETMjqd3ZgpGHT1YUlUexshQQhgzqJEyim/iMJlfruTzvS/nv6aDFCkt55P
 aApxnjQ2UM/K1O9pyhChZbRc3clpDEk165ODzzrULIQ6GahtwGUxtK464c1lkvdXW8cx
 rkHLHwFMaUP4X0pnRe/01SZ9W6ynZyCtxQsENvpySkdTZKmryiZIQHVvlBpayC7/mo4q
 TDxM1ymjyZyJGT5Spq4J7CJREnTYPiQ9UQCzI1QaZg9yg2rZF7PtZ6ol0ViJEJnTpjHh
 p2CBd4oGQnbcx0d72rr6ststjchatFq+P0cZFQrPXuk2Zgk1GERgM7a0sDmrewytd12V
 DNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794457675; x=1795062475;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=U7dvVRuYN0Iu6CFHiijCVS2GsAVgY1mWzOcjbk99LJM=;
 b=esRRRJXYxeI7VhCcLF3wFoe+WapY0bzcttlCmT5KSDjmfDGr5PFxr1ed0SW+Izm0aF
 1Y+q8vsfdDtk+swQdRIt1t0+k0N5Imss2AINXF1IOdgU7alkPeF1M0u5S3dgjMfXvfFP
 479yhuvbzW6LmBQUlOL2Q/MpSlVL0Yjo7prhu4E4nsdUGQiWvXDqANZJB9xAgcgCLjbC
 dJ92A7J+gSGx/PsN4KvkwPCUDMIcG4/rCE4FL/nUTzTL2XGc+sn80FjWhqPgwXKYBjxX
 mmziJyNsEK8+XDiIqkv7uocD2uYTfW4FYUsVnLqjoe4DpRmBKkdLPcKg/eXEnt64fxC7
 9wnQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEOtdRuJnLzOBo86BekUv32hoe6ZTJ9QQuwDDtJCa00767U4XDf34C3fhVfWXFfg2MpTXNPEMO1EIjPDEdj@lists.sourceforge.net
X-Gm-Message-State: APuU4Z883KzXQwr31vaFeHRNj4fHjM4/bTX+DVXVNAur6Q+kgev1idgf
 0Uy/CTPXya6tr8reyiQYRjgRcx1pVRRTVLGgeA4DByZJUG0s6FYtmIWsFIypEh0Vxev9wTwDWRN
 EfBhJDh/Nj8l1RWed+Ngk3hJY51yb60Dd6m4nT6fFgKkjYGzCii2WRpl7fU+E1MOBNGxu
X-Gm-Gg: AYBFou2Qu2X0ZpImT5bbeAZWBwmmn9mGebWbktIHaA7idjtD1yWYCYtv2ZA5KNCMJ/I
 6kbcaRwk8UvYN5aQIuqCQds5j/vqvZHuyDE+mSDXgwrSK3sj6kRFwVthNKHimTnYTkdTIkSLkVc
 vKcbFI/qcfBqnL7DZr5FjFPiqwfv5RnTteS88TQ94Dd9EGYbPC6BjkfZrFyvjIqt2LYV/mBn7uS
 r1dWMRzHxnT+lekXxySmdCHzFxXGPpE/++Ocm8M9BtvDfOzkoSIfNgTZfYYCYciSUkQNfVBi1KB
 N+t74N2yy8OdI/HfCdwBQoHTPqUUO/XrJ/O0Tf6AYdbo4/NQ6f20cAiWB30HUJ0ZzDG6R5JDZBz
 jBl8ENDHbfxIPSwZbtdQh4No4CWQ4Kq8SrWjRxURg1RVJCR3m/hLYwsKpUhtjf5EJZIqUcItTF3
 PGwhQhjhgNJz2B9HYFFx3CMMdrHSuk1Zo9ANQO4xzfHrfvqF9UsaAhwTFJo1Bc8dKc8Vxy0wOKr
 /ULvnGWXf6UHbSES1BxtNRTX6cRCtaC7m/yfeYUS6qPb+75r0zuJQcfZmSe1Oo7Dw0KJmoW+xv5
 n2p/3qfBcQi/+m3cq9oS0Z3lkVPKrDrmoStIVT3SWVmxM4OQ2brdNWqMm/nU2kYy2DyfY02uzPy
 wVojZiSBqpiz7xBjcPSWgFlOSRD4jAtF/ZGyxdeFsYyL9INatWLOZyUzsR/0wK+xbF1Bw7i3y8i
 atxmpogSwHnuq08f+30nZreiFyAIGOK1Lux9Y+Cg==
X-Received: by 2002:a05:600c:4e45:b0:4a1:7c7d:8881 with SMTP id
 5b1f17b1804b1-4ba093aa4abmr74310615e9.13.1794457674627; 
 Wed, 11 Nov 2026 20:27:54 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba0953d26asm58885375e9.4.2026.11.11.20.27.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 20:27:53 -0800 (PST)
X-Google-Original-From: "Heiko Hund (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 12 Nov 2026 04:27:52 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I57469ca50c551ad475510690ecfa2d5e7cf9cfcf
X-Gerrit-Change-Number: 2159
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2159?usp=email>
X-Gerrit-Commit: 5d019414bc457a8c6d3e9d4bffeb2fe456a44ec0
X-Gerrit-Comment-Date: Thu, 12 Nov 2026 04:27:52 +0000
In-Reply-To: <gerrit.1794300772000.I57469ca50c551ad475510690ecfa2d5e7cf9cfcf@gerrit.openvpn.net>
References: <gerrit.1794300772000.I57469ca50c551ad475510690ecfa2d5e7cf9cfcf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzAwNzcyMDAwLkk1NzQ2OWNhNTBjNTUxYWQ0NzU1MTA2OTBlY2ZhMmQ1ZTdjZjljZmNmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <894c923d3d06741edcf47e309f47bdaec5d040d8-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRMPp-000000003Ft-15vC
Subject: [Openvpn-devel] [M] Change in openvpn[master]: openvpnserv: pass a
 lone config file to openvpn with --config
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Heiko Hund \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: heiko@ist.eigentlich.net, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net,
 antonio@mandelbit.com
Cc: "Heiko Hund \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1369068893564646188=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1369068893564646188==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YimKNDJd5Vg="; charset=UTF-8

--YimKNDJd5Vg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Heiko Hund has posted comments on this change by R=C4=83zvan Cojocaru=2E =
( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?usp=3Demail )

Change sub=
ject: openvpnserv: pass a lone config file to openvpn with --config
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 4:

(1 c=
omment)

Patchset:

PS4: 
I don't think we should make this work=2E Any cal=
ler know to us uses --config explicitly=2E I'd rather error out if there's =
a lone argument=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2159?usp=3Demail
To unsubscribe, or for help writing mail filters,=
 visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageT=
ype: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id=
: I57469ca50c551ad475510690ecfa2d5e7cf9cfcf
Gerrit-Change-Number: 2159
Gerr=
it-PatchSet: 4
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
G=
errit-Reviewer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer=
: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: Heiko Hund <heiko@is=
t=2Eeigentlich=2Enet>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourc=
eforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg=
>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Commen=
t-Date: Thu, 12 Nov 2026 04:27:52 +0000
Gerrit-HasComments: Yes
Gerrit-Has-=
Labels: No

--YimKNDJd5Vg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Heiko H=
und has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p><a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2159?tab=3Dcomments&amp;usp=3Demail">Patch Set #4:</a> </p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I don&#39;t=
 think we should make this work=2E Any caller know to us uses --config expl=
icitly=2E I&#39;d rather error out if there&#39;s a lone argument=2E</p></l=
i></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2159?usp=3Demail">change 2159</a>=2E To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://s=
chema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2159?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I57469ca50c551ad475510690ecfa2d5e7c=
f9cfcf </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2159 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: Antonio Quartulli &lt=
;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-de=
vel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerri=
t-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Th=
u, 12 Nov 2026 04:27:52 +0000 </div>
<div style=3D"display:none"> Gerrit-Ha=
sComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </=
div>

</body></html>
--YimKNDJd5Vg=--


--===============1369068893564646188==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1369068893564646188==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1369068893564646188==--

