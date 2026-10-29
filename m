Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AE9606A31E
	for <openvpn-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=nRZC4rwT;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=MjGAoLpo;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=KNrgVcxa;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Bc7cDMhE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=BypjvXsUKlww+nPFwxcxu95oM9lf16AGFF7OSEo5uBU=; b=nRZC4rwTRz7P/B44jgp7zC4VsW
	mb26CqWd5sNsEhDmO/NXfY4q4p3/ViXvMx6hgRs8wDekOh7RvEY7fcRyyeO5xddz4ZLURBHrt8Wq2
	ZTLx8Emz/y84K/ZF2NivShtYQntvtUBD4lKiKaeOIAgjZOriRVmPzZWkwqrJgCwB/MRk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMRcv-000000005Py-2UAl;
	Thu, 29 Oct 2026 15:01:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMRce-000000005PJ-01gD
 for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 15:00:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7MQAIyUE/tGsaHgjVyff+UsE6mYW2S6KA8jvYwdljlA=; b=MjGAoLpo6PlW/tRO1I/vobCrWZ
 tuN1mc13WBdlRNwusjGKiA8ddF3ccI3fm/KftetxpK7s+H78IAmDzAzynO/dnqpRx2SzDXjNjWnJO
 K6R0NUjgYAyMKwxa/UxaCPUC+hBA7FSQB7dHYwur8bDX/7rf5k9yW2jGIi9qh7ChWXqQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7MQAIyUE/tGsaHgjVyff+UsE6mYW2S6KA8jvYwdljlA=; b=KNrgVcxai2JWo1n8Qmgrd93Z39
 DY/1oWDng0W2+UnjcCY40HBECBi+WaWjZsk71aCZij3uJf4LWTHG/IA0RXos5fKB2cdKfbFY43404
 X74i0kpTs6BgCr634+y49wyixNfZVKk4pHlOd3qUwcX6eTB+cy/8e2rvoLjw5bTDYa9k=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMRcY-000000005Af-3P7E for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 15:00:52 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a5b2be99a8so19022005e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 29 Oct 2026 08:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793286044; x=1793890844; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7MQAIyUE/tGsaHgjVyff+UsE6mYW2S6KA8jvYwdljlA=;
 b=Bc7cDMhEgpS2tCrrrDOW8DxKNdADUUWbqcULgNhPe68V00sRMRBR82yg3EhaDiv0wo
 x6DDvwnwU6TNhSAZuZixvm2689AZoxppOW/puket56aiqe4q8PvIVPMo/I/uTgxJHsra
 RXi5qhnc+Dpn3Txtx6WMK0HUtQcXKRDu6OfMqb6gayRMSRi0FAv8r+WvDzivPzt8hjJA
 geyqzE/D86wm5dRSW7J1MHNlgbG1xFs063z09a4Jk9cpWRuYfxyW1Mc1FUcMVQOBrWQX
 w5BXD/kUubQKdQBmU7eRnbcddT31RkFa/MtjS2J4bNSmEOZzbCOuPBmGCTaVU8o5yYMI
 kkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793286044; x=1793890844;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7MQAIyUE/tGsaHgjVyff+UsE6mYW2S6KA8jvYwdljlA=;
 b=rAlBZwvi0sgp2XGDkuDEO4PFnF7foGqgiDsFopgu6XGPfk/bQgCrtks9vAXRJQ68L0
 nGmYNfDs395nNOgRt1dQz1S4I9mCwGmXe2+sh3dP3XzxwElDGUqhZxNg3ZQYkgzFqi0p
 Pk2wqwF7W0yc/iw0IzH+wogqNytAOEVh4MvJufmmFRg93S4tN42ugJUjDicQRgMWqHJ8
 m7VtAg2rR6FC9N0EK97P3MwtE/MpFJt6O8rK8gu8W62L07Rz2msjJRjKXIrejMX4eR5y
 PytSKSrx1MZThSoTxsJuxG1MBdXHoll8V+uLk6x1fl6bueOptdepTqTXlX8oGa/gmGtE
 THYA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzzZV94NBe/816JlVwnjFpK22ezWHQEjYnTvGfnzshLoxZwFVM4MetbcM28SmjAeJzhmy5GSQaa5u1kPPa7@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLb37YDSxn0Spwv4MBwU809I6DCRE0ofvRDzqvsuTo7KA636WBr
 NfMfZzD14vNqCExACeLJhUbiIczlFCK8+4NNmIlVX3veELx901JQvVQbHa+7Vi1+4NTp/UiPNIf
 zXq4oDhMF7EASCDpjjBknqYZkvEI82ixqDeLbr21/DTI7PPRa+jTmW5xFsylMGk/JlqQxKNWPwV
 yhHidkZA==
X-Gm-Gg: AYBFou1qkp1h/UrCS/k/vxftNWhpRPpXRzSfeuVftPuaYCchFjKG9XtzndLvbQSuA9G
 VP0HPIBRu2ZeHAhNkdSy5KLBkuJoQq+dW4Szh8bMNwU5cag7qvBQzbXbo9KQBeOor16UL1N6Lda
 1++ULlD3R1IfAVV12/xzXQcDgCq8i/hDfr3B7DYKgEz6pe6SNXnFgCBWZZh0WIJdCcZcW4vnPyD
 xAA1OGDA58WaxmBDjRL/pxENdBNaoQ2rU0gHFF4qwulWRdzf8hikPH9c2JTrqTLxZgXUnFBp/BG
 wC8Ru1lQIyXYJJo+t8ECvACY2xSM739+H4Orxg51a6ucVTmBexiCvKjkSzX60j1WA5EEc6w7CRz
 FiHim9Y/AEq4AngpJKTSorSvV6mmil6PPUicyqUVATOTxbgOCoAGMOqeatBhm+L8FxaPkQWoRTy
 wIs96bhOVlkDTJS0hq1TFPwGl2SfiLQ4w49tblk1w8XYSiHKvES9AbeBkgYwo/wo02//xgtx/uv
 VaY0AOa8GBTMyqMo8m5MC3V6q4iL7y+qzb3ARqWGz37GVF84F+Azb0ydyf/cT80kFrwnuHrccM9
 kBEJ8k8jLtY90ZAsuMWUYqhm7GwHLFOEvmELZoS6if9X6EyYFTB17yTDlxwsZCq1naXh6VOwxYK
 PjRiplVyd0uVXo23XKCnacD5MCJGt31JeI0HhnyMi3MhZ0r2MAlqQo/vAHjg8LZTF5kSDNA1ef5
 NcgIANEib7cdJBn2c=
X-Received: by 2002:a05:600c:348f:b0:4a7:a5db:a93e with SMTP id
 5b1f17b1804b1-4a9643d380dmr135388985e9.4.1793286044069; 
 Thu, 29 Oct 2026 08:00:44 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80f04785sm71877135e9.4.2026.10.29.08.00.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 08:00:43 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 29 Oct 2026 15:00:41 +0000
To: Selva Nair <selva.nair@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iac23d5141a8c29e239d0f2aeea497d3a002e609b
X-Gerrit-Change-Number: 2069
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2069?usp=email>
X-Gerrit-Commit: 08b058611ff00638cee31f0eb2da092826e34c5f
X-Gerrit-Comment-Date: Thu, 29 Oct 2026 15:00:41 +0000
In-Reply-To: <gerrit.1793212962000.Iac23d5141a8c29e239d0f2aeea497d3a002e609b@gerrit.openvpn.net>
References: <gerrit.1793212962000.Iac23d5141a8c29e239d0f2aeea497d3a002e609b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMjEyOTYyMDAwLklhYzIzZDUxNDFhOGMyOWUyMzlkMGYyYWVlYTQ5N2QzYTAwMmU2MDliQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ad4f6c72861d327a4bdee4a0846f71b383d2e951-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMRcY-000000005Af-3P7E
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Optionally indicate
 username in >PASSWORD 'Auth' prompt
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
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org, selva.nair@gmail.com,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2697920747159703295=="
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2697920747159703295==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pfrviitKt+0="; charset=UTF-8

--pfrviitKt+0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Selv=
a Nair=2E

R=C4=83zvan Cojocaru has posted comments on this change by Selva=
 Nair=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2069?usp=3Demail )

C=
hange subject: Optionally indicate username in >PASSWORD 'Auth' prompt
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Co=
de-Review-1

(4 comments)

File doc/management-notes=2Etxt:

https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2069/comment/564f4843_7455126f?usp=3Demail :
P=
S2, Line 402:   These work exactly as Examples 3 and 8, respectively, with =
the following
Example 2?


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2069/=
comment/e0e44b38_cc0f41bd?usp=3Demail :
PS2, Line 413:   as in example 3 or=
 example 8, as applicable=2E
Example 2?


File src/openvpn/manage=2Ec:

htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2069/comment/26d06886_1972b437?usp=
=3Demail :
PS2, Line 3675:             && (man->connection=2Eclient_version=
 >=3D MCV_PREFERRED_USERNAME)
Should this check `type` as well?


https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2069/comment/d94a2e88_e6dc99d7?usp=3Demai=
l :
PS2, Line 3685:                 buf_printf(&alert_msg, " UN:%s", user64=
);
Are we sure `alert_msg` can hold everything it's supposed to legitimatel=
y contain? I see it's allocated as 128 bytes=2E



-- 
To view, visit https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2069?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: Iac23d5141a8c29e239d0f2aeea497d3a002e609b
Ge=
rrit-Change-Number: 2069
Gerrit-PatchSet: 2
Gerrit-Owner: Selva Nair <selva=
=2Enair@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2E=
org>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Re=
viewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Selva Nair <=
selva=2Enair@gmail=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Ge=
rrit-Comment-Date: Thu, 29 Oct 2026 15:00:41 +0000
Gerrit-HasComments: Yes
=
Gerrit-Has-Labels: Yes

--pfrviitKt+0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Selva Nair=2E </p>
<=
p>R=C4=83zvan Cojocaru has posted comments on this change by Selva Nair=2E<=
/p><p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block;=
 margin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</sp=
an></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2069?usp=3D=
email">View Change</a></p><p>4 comments:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>File doc/management-no=
tes=2Etxt:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2069/comment/564f4843_7455126f?usp=
=3Demail">Patch Set #2, Line 402:</a> <code style=3D"font-family:monospace,=
monospace">  These work exactly as Examples 3 and 8, respectively, with the=
 following</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">Example 2?</p></li><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2069/comment/e0e44b38_cc0f41bd?usp=3Demail">Patch S=
et #2, Line 413:</a> <code style=3D"font-family:monospace,monospace">  as i=
n example 3 or example 8, as applicable=2E</code></p><p class=3D"blocks" st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">Example 2?</p></li></=
ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/manage=2Ec=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2069/comment/26d06886_1972b437?usp=3Demail"=
>Patch Set #2, Line 3675:</a> <code style=3D"font-family:monospace,monospac=
e">            &amp;&amp; (man-&gt;connection=2Eclient_version &gt;=3D MCV_=
PREFERRED_USERNAME)</code></p><p class=3D"blocks" style=3D"white-space: pre=
-wrap; word-wrap: break-word;">Should this check `type` as well?</p></li><l=
i style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;=
"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2069/comment/d94a2e=
88_e6dc99d7?usp=3Demail">Patch Set #2, Line 3685:</a> <code style=3D"font-f=
amily:monospace,monospace">                buf_printf(&amp;alert_msg, &quot=
; UN:%s&quot;, user64);</code></p><p class=3D"blocks" style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">Are we sure `alert_msg` can hold everyth=
ing it&#39;s supposed to legitimately contain? I see it&#39;s allocated as =
128 bytes=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2069?usp=3Demail">change 2069</a>=2E To un=
subscribe, or for help writing mail filters, visit <a href=3D"https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope i=
temtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2069?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displa=
y:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iac23d5141a8c29e=
239d0f2aeea497d3a002e609b </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 2069 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>=

<div style=3D"display:none"> Gerrit-Owner: Selva Nair &lt;selva=2Enair@gma=
il=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schw=
abe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razva=
nc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn=
-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: Selva Nair &lt;selva=2Enair@gmail=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-At=
tention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Comment-Date: Thu, 29 Oct 2026 15:00:41 +0000 </=
div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--pfrviitKt+0=--


--===============2697920747159703295==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2697920747159703295==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2697920747159703295==--

