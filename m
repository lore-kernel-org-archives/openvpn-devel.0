Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5896E606A32C
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 12:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=kHgRzIdS;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ePW5L0P4;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=HiuBadbZ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=RpkQ5stz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=xC7iELlXffsVg/aLvnzThpNxMcXsXlJN4ueSzyBOYyo=; b=kHgRzIdSx9p93zRLkxMiboj90j
	JMe3trDeTY1B641N23h+cxeJqSYKtZtWuXSHogZPi9Jw42z8LemJqzFl4hn4iSnyFf4HUyuPJ7kW6
	PGxRvF6jxcOCbEcu8c1JC5PH8Tgb9rOAP7nFLcMvA13eNxjOySqcmWRN3knDjmycst5g=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xODWs-000000003Ib-1IxN;
	Tue, 03 Nov 2026 12:22:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xODWd-000000003IE-2HR7
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 12:22:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7OpJ9MARoOdTh7SxC91a/60bwnGjKY1XkWAry3QKKdU=; b=ePW5L0P431CXOpgcRDrX3t7z1Z
 GG/0hCWJRoQKleMhrgmDYXvGytF1Qxw4+pfEDELZYm9fEMXELH2lfA2hiKyXs10v9nQNMSPVQEZlw
 Ga3OVyURIFDTt9yF7JGl4PwZmCDlmXOAWHhKIg1KoTEk9euevCeIucMps54FoLe98Hzg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7OpJ9MARoOdTh7SxC91a/60bwnGjKY1XkWAry3QKKdU=; b=HiuBadbZ5i/e+y/6LTIHSG3FsD
 xayrEwFugNvHBb2SCYHMrXWR2AImivEMnY7czptToPKfJa9ntBr5wwXCIb5KB/EhOIy/2bM2ua8Fx
 0KbxUDmBewZYYxoWIoMqr0NdB88O013QLikw+yp4r38N7ySOogL5p3di9DVlR5g2XYcA=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xODWX-000000001qT-0U92 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 12:22:00 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a4dc547987so21024315e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 04:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793708510; x=1794313310; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7OpJ9MARoOdTh7SxC91a/60bwnGjKY1XkWAry3QKKdU=;
 b=RpkQ5stzXnfsRRM18X5eN01WfnZTmzAJUMyu0s4tH55vNENlQRYL02x9m7y7FugKMX
 PHKWnwnw70bGZgg6u1CTnbMNWHEpSrHMZWk6qTO77t03Lrw2YwdRTc0wnHqgyaKevpmn
 D+fBaTzIiuD9/3GDgBG+TvWNMSLU4uLWprrHdUKM2Y1ElvcHskRLlnLPImshzOnq05Mz
 zQExzHbzudfPbWZZrbQrkw4NAwTH9U0XkWGG7l33Gbn182gcHVgRCLgeCIJ9olF2Jybe
 x4iIhRK1U/nom/sr58H+nKtO55AWbOdHbfaTfx7e0wLCiLGkLUZUE15G2iFZavlzIHiZ
 hV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793708510; x=1794313310;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7OpJ9MARoOdTh7SxC91a/60bwnGjKY1XkWAry3QKKdU=;
 b=rQrydoCs+heqlAplrHVgOQcVVcE98zhlDx165+BG2XxdXpqXCZyVilJDw+BxISJlmr
 YAuqRwDUdzeTvHllBo1JfDDxfhX6zXPImfko7//LizdHg+iYbCEDtiZjPxlvcPPJ5g4f
 1fdoQdujOSSmMfEiidDBzUmAqszkm5JtQ2T6jcFfWMV2nkngDjtoXM9umjPxaQDU7s4f
 c4zVP5dVnnwlq1c5BJ5QrPr33ONDJglPN6KB5U6hbwuY2SjKZzasY566hiuOLFu7q3zl
 h5Amgc1RoOrIvkQKJsWP0DXE+iAvcAs1SvkT+H/3hFZqQupiF1j6VS/hhQrKw5dBAW1H
 eoyA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwg+dg5JDySiO9MLfLndZKxqFbTYZ/jQ2/mru4CctGziU9d/k38r0y30ZYwxByefarbFGBahdBH5t93DGRT@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8QW8FseH5MNauW7wwbWzvuzS5lNH5kbsPWzRD92A0D4YztnQml
 GR3ls+ZxbWkPrBwZSviqjLF1R/zDej8UNL6SJJ/jvWZO2El805Y3VIQW2SjTrNiEWdVLSA5jhKY
 OPLpXS+9aRe/5bRqUV72AGo1J/QGHyH7P9BWXy4XZ6vSGkvpaLNfb4vIUvrE6xgpgiWKo
X-Gm-Gg: AYBFou2ZZmcuFWghzqQMXCpP0N/LJNhMZf0QzikDXIg0wWOUTUmCoznCZSahHKixRCM
 Z4y1uoYJITDhPq212m2RdNMKTH9ZFpg/kQypqLJvoCLyJGJ791JtRFwuUjP/1RW2iouLV/9yDM9
 n9OQ8ijqTZ0Vfx9N/aOyY+rLBeO0oWMJp4wVnk+ISA6+ILDnRfyBjPu4bH6DRGogCEPBoSbLe4l
 dcXjKXfKv5rf52/UOjHbwVqwyLQZjfuRvZYtFU9paLkis7KKeb6sUBpGYDiSHpMZGhyjxH/xpHf
 Q6f5fh42W+gdeJOe3W82xJaXHj11mVDTBujyI2gm80sIGxLpzGuELRID3PEZXK2VndVrmnNa/La
 c31JASzegxpNh1vuhN2/vNwRQjOMPhJkgiHfMHy+Zpozk2XnpQPjC2STbYNBRVF8tYTYNsGebjx
 +8Ys6/CjpeAi5l2RO+CanCTfW+V5uIgnQcwBcF5fbtuK6RobSWLCNLFhBa64XCPOcq4LwmAZVHK
 UQ1puJ48GKHgnGHUfQAF43OJ9BNBDXgO3Z4cZV3OkYN+vF1UgJnlGCGzkiHvKbiDbe0FgVC2J/a
 r9nxAv8Mm1qsCtINC3tnXPQB3pJqZPskRcWHpkgashGN/MJWUabN2JFZQuN0K1TFC1Aepb+/GJN
 Ylv94V80K0t/M//uvGghjB9FzlbAez0v5R9Sq0Xe86RPXHPm3x0sXmDMz/rjK0diRQt652I6cJX
 vOiHnElLIKBAaQiw==
X-Received: by 2002:a05:600c:468c:b0:4a3:59c9:a750 with SMTP id
 5b1f17b1804b1-4ac17d168bcmr299702655e9.9.1793708510433; 
 Tue, 03 Nov 2026 04:21:50 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a93232f0sm54569245e9.10.2026.11.03.04.21.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 04:21:50 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 12:21:48 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I5ee231d157459e6406f1f4c12cd6c6e0fce93815
X-Gerrit-Change-Number: 2082
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2082?usp=email>
X-Gerrit-Commit: 32fe3f7efec282f7536150bfcee804658ac0206c
X-Gerrit-Comment-Date: Tue, 3 Nov 2026 12:21:48 +0000
In-Reply-To: <gerrit.1793618230000.I5ee231d157459e6406f1f4c12cd6c6e0fce93815@gerrit.openvpn.net>
References: <gerrit.1793618230000.I5ee231d157459e6406f1f4c12cd6c6e0fce93815@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4MjMwMDAwLkk1ZWUyMzFkMTU3NDU5ZTY0MDZmMWY0YzEyY2Q2YzZlMGZjZTkzODE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7fb1f085b642fb43c389d46247db646bd6716e90-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xODWX-000000001qT-0U92
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 gert@greenie.muc.de
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7023463749369569917=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7023463749369569917==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dqefoGH28XM="; charset=UTF-8

--dqefoGH28XM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Gert=
 Doering=2E

R=C4=83zvan Cojocaru has posted comments on this change by Arn=
e Schwabe=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=3Demail =
)

Change subject: Remove replay-persist
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 4: Code-Review-1

(2 comments)

Fil=
e doc/man-sections/unsupported-options=2Erst:

https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2082/comment/4ef036a7_32945b3e?usp=3Demail :
PS4, Line 84:  =
 Removed OpenVPN 2=2E8=2E This option never really worked well with ``--ser=
ver``
"Removed in OpenVPN 2=2E8"?


File src/openvpn/init=2Ec:

https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2082/comment/2fe0ffad_4c316cc5?usp=3Demail =
:
PS4, Line 2954:     const unsigned int flags =3D 0;
This local variable i=
s unused=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2082?usp=3Demail
To unsubscribe, or for help writing mail filters, visit =
https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: co=
mment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5ee2=
31d157459e6406f1f4c12cd6c6e0fce93815
Gerrit-Change-Number: 2082
Gerrit-Patc=
hSet: 4
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revi=
ewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Gert Doe=
ring <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razva=
nc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Attention: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Attention: Frank=
 Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Tue, 03 Nov 202=
6 12:21:48 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--dqefoGH28XM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Gert Doering=2E </p>=

<p>R=C4=83zvan Cojocaru has posted comments on this change by Arne Schwabe=
=2E</p><p>Patch set 4:<span style=3D"border-radius: 3px; display: inline-bl=
ock; margin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1=
</span></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?us=
p=3Demail">View Change</a></p><p>2 comments:</p><ul style=3D"list-style: no=
ne; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>File doc/man-secti=
ons/unsupported-options=2Erst:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom:=
 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082/comment/4=
ef036a7_32945b3e?usp=3Demail">Patch Set #4, Line 84:</a> <code style=3D"fon=
t-family:monospace,monospace">  Removed OpenVPN 2=2E8=2E This option never =
really worked well with ``--server``</code></p><p class=3D"blocks" style=3D=
"white-space: pre-wrap; word-wrap: break-word;">&quot;Removed in OpenVPN 2=
=2E8&quot;?</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File =
src/openvpn/init=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082/comment/2fe0ffad_4=
c316cc5?usp=3Demail">Patch Set #4, Line 2954:</a> <code style=3D"font-famil=
y:monospace,monospace">    const unsigned int flags =3D 0;</code></p><p cla=
ss=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">This =
local variable is unused=2E</p></li></ul></li></ul><p>To view, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=3Demail">change 20=
82</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I5ee231d157459e6406f1f4c12cd6c6e0fce93815 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2082 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &l=
t;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit=
-Attention: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 0=
3 Nov 2026 12:21:48 +0000 </div>
<div style=3D"display:none"> Gerrit-HasCom=
ments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div=
>

</body></html>
--dqefoGH28XM=--


--===============7023463749369569917==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7023463749369569917==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7023463749369569917==--

