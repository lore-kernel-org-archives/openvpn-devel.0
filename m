Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295FA606A32C
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Nl1btivQ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Ot+mMgHr;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Usyjh6zp;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=H3rz4MI3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=zqwv8zxx06D+L8bC8AahtfRUYD8NkoFX3SrFeVpDesI=; b=Nl1btivQpM1K8nnkiVEjNfpeY6
	zNgb0iQfcF8zfVhPuA3eSbnhoIa3fH/tN0c7IGp97MenhTxS2vnO06tO4ySpLn2DxIGiEyLsUUfLr
	YSX/6mEGTOvpQL5TaFOKwCOgCVRwJIe8OvRuUIZTEFRJ1uLt3XNzR3eICZqn/zi13S98=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNst4-000000008O2-1Tbn;
	Mon, 02 Nov 2026 14:19:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNst3-000000008Nu-2AZX
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 14:19:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Kic38xYug9B2Q8F6IOUyKaYwd+RVhDowepbVNVhsHsk=; b=Ot+mMgHr9kVsvt5DJsnDArV1S6
 VLaSwDtltiRecqtjDavGsndUrDPYo8jhjgG9lQZT/WF0tPx7vbT4hz6ykN+7VnGDi4cqFe99GOser
 yq2lwzFddxjLvrgp8uOnUE8cvix4K/htGRyiAiyk1D8+wSr94f+Tj2VQ8Y/KNdciR0dg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Kic38xYug9B2Q8F6IOUyKaYwd+RVhDowepbVNVhsHsk=; b=Usyjh6zpH3mvfkFiBBgRC45l7J
 hUhHEpwpeOTSt9DTHIE6BKXLSQr1BrCAvM3yH+4Z7MB2xwgOpHdEX6flCAcb+uWGdTVWnCc/rIZeB
 NhNJZY7razjGiLoExVNElK6OGJhBWEkW8YA6iT6L9eAlDAvKLtH2n4FhE4qZt4msHAX0=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNst0-000000001P5-2Gvh for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 14:19:49 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a20bdaf39cso35560055e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 06:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793629180; x=1794233980; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Kic38xYug9B2Q8F6IOUyKaYwd+RVhDowepbVNVhsHsk=;
 b=H3rz4MI3TVcf5p9uM3z7QjIHzawOl+UmwNW3IE9+69u2QS89CeGw6X7tx4PGTPsiCi
 o7C7cHw1lCeaBdEBZpvHg7mgZVyIWZPOjj2jgL6/vqDY30dVC8YdffzOIi++tUyFV7dd
 PBmhsab4Mf6mUMH4CBEdo/gBGlC4aDcn9fEU0JduM7lAWQUy1GqT2CqyHjeM7CGLyOnr
 XGrbRBFajVHSrFnFbE7GQJuA4XxCIVWJkPgWT5GE+WH0npiPQ/2axB/QpOip+13fa7Rq
 FJXFf3Wzfhq0shyExmXr634cJpJVDc6nBzeJRIN5rP8RZBlmbSMZehIlQNGxa7FF/B3m
 cLKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793629180; x=1794233980;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Kic38xYug9B2Q8F6IOUyKaYwd+RVhDowepbVNVhsHsk=;
 b=dXsm+gHGMhYdVxWdZcdbkZloMFw8PcCTY+JumgvVx2EcC3C+uRsheFHsAZtFUxmFlM
 WEHbnUW0oZ35iPWdz7DTEsSN2jci2xPx8MgRZMUFgkGvA3HTVPUtTPHCVRGazz6fYc4h
 L5McOMPEP7s1v/Go1bimcwrV8OuozirPioYxDMgFlZYqOgkeY5D50r2bdBDwILaOpnrS
 58tIYw5Bn2IrcwD2qLX8AvqJAbARO6ESdve+c2TQDgu6gNQPcFd1EHQPU05j4n4apfp/
 KIzT5e9yiRUa+Mdo9pCm+wtmxv1KDfDMaEfLZBfMP05lymwXdwDf3IuFQdQITaa/OCot
 cZTw==
X-Forwarded-Encrypted: i=1;
 AKwUvByq6t8D2SBwiSfMbedgB89ugIL+Y+V/g8oncGZYjytyCLYtC8zoou61fMaZ4c0YWzs9HxyPNnOqt9gKFsAs@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKqBFj76TJFC1l9JzorHMdinAAxUw6LrJW3vPNz+ZSK1s36MLCU
 oNIlc1pH0qR+dbZWAsgPT3CB78+dgxqst5ZavMDspmBe60bgI9HzvGp8OxV/9zOQt4r2FerFxb5
 vEy2k8LHdfpjB91rYfiOPWpHvp6BEKdi/4EGHJcMyX8GX9DTWakDhb61pXuQcxyn7beYn
X-Gm-Gg: AYBFou1PzfTnOLjFGhjZLM1b4MzrJNl7kwyoI1wBtyL46q1hyVnRTRYYzBFTmHEFs+C
 ZWluAgfn2lhodQGsd5j7hES1M9PNM5fRMJPdz6HhJ10qmDT7zMo2ZaBDIqnAfCa4qBet9lK0AVJ
 6jNfWNNzPmM/COtrEUuFPsR5ORRwzl0HCcK+y26SL7pvMA6vWCjEI3bu0BhYJAH9HIs/7SYU0aD
 LbtEi99B8+fxj+6CT16lWVNtc6+eavxJglw+YcVcdPuUA5Mvrn7X+8QbmGvDrv3eumv8I9sHTz2
 p/oZ6708NyfUgx4uDs6aEkgS4luzOlUD4vH5/gLRXfcTAApnJ/QGrxu+mB2ptuH3cvCV1KMWHoW
 u6nNTgt6s0rR6AScJ4BcS4e2QAfskHUUiZAdV4Vc1lufP8VYDuThTtFTa09gTskCTwebNhONmga
 RjdOxbaaorxSfyfCrcQXi6RX3fclSWEnLG/pQ7XHGVdc3WyxV9ydSjQpaf6zXQ7qDY6y4Lav1wG
 NYj6vJD/KaLy6ro/rfb7DkWw9dBDJsTm/a8MNFnc28n55IYAodZNdSjCFN+5yP4/QAEdXzECVpH
 0ou2XLAGEsU6Svs49UEWeBCDXNpbbuPl6G/eUFuo9Q/T90co2eCJ7Rm0QshUBn4HqBJOdfK3hgr
 GpOPgaeHFfugrm+99nFE9cTeJCVoahErm6l5/GdM6BRIiL/qbT/Jv2H9DPGnCR6cqS6jDdDme03
 wR7wyqq68ySzQz4A==
X-Received: by 2002:a05:600c:a00d:b0:4a1:83f0:7c91 with SMTP id
 5b1f17b1804b1-4ac185bc336mr225104865e9.18.1793629179884; 
 Mon, 02 Nov 2026 06:19:39 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80f047bfsm345625445e9.3.2026.11.02.06.19.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 06:19:39 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 14:19:37 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I5ee231d157459e6406f1f4c12cd6c6e0fce93815
X-Gerrit-Change-Number: 2082
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2082?usp=email>
X-Gerrit-Commit: 91fa622ab369ada456c49f4ebdf802dae4aa828a
X-Gerrit-Comment-Date: Mon, 2 Nov 2026 14:19:37 +0000
In-Reply-To: <gerrit.1793618230000.I5ee231d157459e6406f1f4c12cd6c6e0fce93815@gerrit.openvpn.net>
References: <gerrit.1793618230000.I5ee231d157459e6406f1f4c12cd6c6e0fce93815@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4MjMwMDAwLkk1ZWUyMzFkMTU3NDU5ZTY0MDZmMWY0YzEyY2Q2YzZlMGZjZTkzODE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e62bc2453d8b1790e1996709517ae8a5ab70668a-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNst0-000000001P5-2Gvh
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove replay-persist
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0812652678162609140=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0812652678162609140==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8iTBRAJ69sI="; charset=UTF-8

--8iTBRAJ69sI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Arne Schwabe=2E (=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=3Demail )

Change subj=
ect: Remove replay-persist
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 2: Code-Review-1

(6 comments)

Patchset:

PS2: 
W=
e can now probably stop including `sys/file=2Eh` and checking for it=2E Gre=
pping for it also finds config=2Eh=2Ecmake=2Ein and syshead=2Eh=2E


Commit=
 Message:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082/comment/de45a662=
_c8edbeb3?usp=3Demail :
PS2, Line 12: This features saves a single packet i=
d to the persist-replay file=2E
"This feature saves"


https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2082/comment/a6c4d51d_c2625a87?usp=3Demail :
PS2, Li=
ne 12: This features saves a single packet id to the persist-replay file=2E=

"replay-persist file"


File configure=2Eac:

https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2082/comment/9967cb86_248db279?usp=3Demail :
PS2, Line 456: =
	sys/mman=2Eh sys/file=2Eh sys/wait=2Eh \
Since we're no longer using `floc=
k()` the check for `sys/file=2Eh` can no go too=2E


File doc/man-sections/=
unsupported-options=2Erst:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082=
/comment/ede383b9_8e95cce4?usp=3Demail :
PS2, Line 83:   It is now ignored =
if present in the configuration file=2E
This file now lost the newline at t=
he end=2E


File src/openvpn/packet_id=2Eh:

https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2082/comment/71eb7c87_914c5a54?usp=3Demail :
PS2, Line 234: 
R=
emoving the block above now results in two blank lines=2E



-- 
To view, v=
isit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=3Demail
To unsubsc=
ribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Ene=
t/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn=

Gerrit-Branch: master
Gerrit-Change-Id: I5ee231d157459e6406f1f4c12cd6c6e0f=
ce93815
Gerrit-Change-Number: 2082
Gerrit-PatchSet: 2
Gerrit-Owner: Arne Sc=
hwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <fran=
k@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attentio=
n: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Mon, 02=
 Nov 2026 14:19:37 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--8iTBRAJ69sI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Arne Schwabe=2E</p><p>Patc=
h set 2:<span style=3D"border-radius: 3px; display: inline-block; margin: 0=
 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p>=
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=3Demail">Vie=
w Change</a></p><p>6 comments:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2082?tab=3Dcomments&amp;usp=3Demail">Patch Set #2:</a> </p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">We can =
now probably stop including `sys/file=2Eh` and checking for it=2E Grepping =
for it also finds config=2Eh=2Ecmake=2Ein and syshead=2Eh=2E</p></li></ul><=
/li><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2082/comment/de45a662_c8edbeb3?usp=3Demail">Patch Set #2, Li=
ne 12:</a> <code style=3D"font-family:monospace,monospace">This features sa=
ves a single packet id to the persist-replay file=2E</code></p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">&quot;This =
feature saves&quot;</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2082/comment/a6c4d51d_c2625a87?usp=3Demail">Patch Set #2, Line 1=
2:</a> <code style=3D"font-family:monospace,monospace">This features saves =
a single packet id to the persist-replay file=2E</code></p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">&quot;replay-pe=
rsist file&quot;</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>=
File configure=2Eac:</p><ul style=3D"list-style: none; padding: 0;"><li sty=
le=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082/comment/9967cb86_24=
8db279?usp=3Demail">Patch Set #2, Line 456:</a> <code style=3D"font-family:=
monospace,monospace">	sys/mman=2Eh sys/file=2Eh sys/wait=2Eh \</code></p><p=
 class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">S=
ince we&#39;re no longer using `flock()` the check for `sys/file=2Eh` can n=
o go too=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File =
doc/man-sections/unsupported-options=2Erst:</p><ul style=3D"list-style: non=
e; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
082/comment/ede383b9_8e95cce4?usp=3Demail">Patch Set #2, Line 83:</a> <code=
 style=3D"font-family:monospace,monospace">  It is now ignored if present i=
n the configuration file=2E</code></p><p class=3D"blocks" style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">This file now lost the newline at th=
e end=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src=
/openvpn/packet_id=2Eh:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;">=
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082/comment/71eb7c87=
_914c5a54?usp=3Demail">Patch Set #2, Line 234:</a> <code style=3D"font-fami=
ly:monospace,monospace"></code></p><p class=3D"blocks" style=3D"white-space=
: pre-wrap; word-wrap: break-word;">Removing the block above now results in=
 two blank lines=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=3Demail">change 2082</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5ee23=
1d157459e6406f1f4c12cd6c6e0fce93815 </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 2082 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;fr=
ank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Commen=
t-Date: Mon, 02 Nov 2026 14:19:37 +0000 </div>
<div style=3D"display:none">=
 Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Lab=
els: Yes </div>

</body></html>
--8iTBRAJ69sI=--


--===============0812652678162609140==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0812652678162609140==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0812652678162609140==--

