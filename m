Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9D9606A31C
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 20:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=c7C02yU+;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=JC+42Jf9;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=f2bwAFmU;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Mm4Jdc4P
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=XB4L/J+pWHRqkb1IjjXT5p8thj9y6dN7XzlRsC9/QW8=; b=c7C02yU+dgaKlO5ftuiBq6XM69
	x3RBbtr92YXctFlOSiDxgZ8GbwconGO/MZUHkTa2xMR1Qheok9Eh8f++EWwiusN/B4zBN06C0FpRL
	vmISISmdIdkw3tTZxdcKUXg1Pfc/NaCqWwnf2L3YzFXS5Rwhc789rZHZVortviJToyCQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMACI-000000004SQ-3xl3;
	Wed, 28 Oct 2026 20:24:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMACH-000000004S9-0RQJ
 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 20:24:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vA8fN6nNh5kcRD+U4RIvcLBS6yprPSV5Cnow+r3H4bE=; b=JC+42Jf9upCGyv9J550sZqYM0x
 9Cdi7eUnHKqU/cFKMMld5B04aCIWIWrUEttdKkzkwPIpvSXQM4z16rPI3wUxzhhSuNajMP8yQWDs3
 GfQVHVf7LlUujhXWW64YRot6MrA6YPZghKCm0xatl32fkvDsrtpmdIFlM/ByCZvEjklc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vA8fN6nNh5kcRD+U4RIvcLBS6yprPSV5Cnow+r3H4bE=; b=f2bwAFmUz2JtgmvMXi5ZZEXxlX
 rGbvs/LePH+NjYuvcyqaHERAbvItHDYfrFImPaw0da4ifTddZqaxsLuyL+dAcwssCf+cxOmsW+7fG
 Na3XiUSEKAZ7RAimq9UU0hwfnhO0ipiCP0C2vh5e8nzbjuV9LMTHGgP6uhjFSRbVFHSY=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMACE-000000003Ww-3da6 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 20:24:33 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso14969465e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 13:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793219064; x=1793823864; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vA8fN6nNh5kcRD+U4RIvcLBS6yprPSV5Cnow+r3H4bE=;
 b=Mm4Jdc4PbfbwVwV8xYPA+Ww1ySyvtdE/dFZJG2Sj0ConQ6FgIreOBlLNbSXeC/SnJd
 RDD8mIdNPZ5UecgRJ0vcVG7WNjPm596IHBH5MZtEEeuc6r+K8K7TKDuDCqW1ylP9c8jF
 72AGm7a++oZzUrX/1rcPQPfQ/tIt6wIaqSRCOIAovveQE6iJdOT395qh06SMpgAbInjM
 rYl4Y7iGmvwDNOYO7RBLKkfIcxX+K+8ePRgTENMv3kIm8Ps5cytuX7IdkblZYi266FU6
 fOp7rGg1pZQAT/nkd6ywkuNVSsoN8zTZaBiiic/O/d2oz3JRos1oUtkIqIwyPsTvAX+G
 67xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793219064; x=1793823864;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vA8fN6nNh5kcRD+U4RIvcLBS6yprPSV5Cnow+r3H4bE=;
 b=iY+EIkVKe3+f0Bbb6BB47OMbs2pjigMkg9XDQq7i/pTpLD36XO2XLMkIfVDRldPnCA
 Qi9rff6HtjdUdpRJHtGtTuOKSBErSaumjgFfAH5O+ZV9jYv29DMT8Hm8n+PLvnJnOxIL
 NhSII6Zpo/MZ4KE0CYecwUOvrjjiDpEohUR4whKn7VwcyEo54G+BDhxriC2oMFPOPW0K
 e9NUtSqwben5TA2pJqL+Tnll8jkdrxx55tEdAEZ/VJ6/7jZ2ysS9Pe0uwly4L/jRqzWd
 nhX2NdtWW/ahRUNI9g0pmageoQMzBigDT/plxJ+UX/GSNNEGpmITngzIS8QHXm4na7lQ
 lGrg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwPRU83jJaGPLXdnQqh4ponMfUaNqwWhisd5q5aNrA71+JkSq//nD6fTKvzRflpPl5LSOoql3/6QqYRc1DI@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIrIuF1bHUTEdwo3qcsOsW8P95DjTGN2zQn9GW0icF8bwK+vfKG
 MLpksfZb+vjceI3E8w6guLRdQplFvUhBlV4YqEp7jzaf08eUua8JpuQ8fz4NdW3yjI6c+OEn+AP
 oN4Ccid2DvbgqU4WupN522On94rZHqgLYrzHQorLG3pk+yCaFHmGE9lkc2wFjAc4+xX2J
X-Gm-Gg: AYBFou3Ttj4h+luYo/7yX9v8VhssTAO4055E7UJJb3gdoXxoW5eVmxSHKyK/6zD1uZ6
 h7QdGZC8qztzmK7SN1dGqsVStB/TPKYM4gjFPX1JUta6lPD03w3pDrnbPcr5FtOOOa7cMLLJqPd
 QiwNZjnH++12qf69KnXoUalKz93BEWmynXVjX76g+uAbSaOatib7ySXQ/ZCzuLDoquYAOyTOmiC
 jMwL1LYIjz2D1rTipbn5y1HvQLGbzaROBaJP2JOOSFToGSzgF+UtO6Up9t7vAZUZ5TL6RUOB8XQ
 cfXWUg4QW9laiPsJ4miHU8nT1Y+2nK27SS4gtVA6cbk9iReLW6MOTvHih0rAbDh1WKX85TlYrV+
 hzoz4PxRtJRPavhI8A0Me4yu310PECJdUnq0suZti9xvey52Dr+pXVtA+6mWl5bPVCNItjYx3/7
 3/F1+KtVBeF2j0UHE8/b8p2rNNQCuJeq4eB/cA0Vh7oepJKmnqDpQv9TIgKHjj9P2DdxB6HY8WG
 qB6Q+s7IeCHa4uBmzNwa2NqK4EhXC6lIUijlt2iffzc8oT9sgObWwav3qsAMgSFOmyIUwtMi6qD
 mCAGuJ5nA439CZc7rGWHKMCoRyzneMLOdtxZQD49YjPzXb3yzba6dRk+2S0yuZ6Z3NJzhOpHBPr
 XVTAwins+Jwq466dbY1yZb6BCXa2VISySARWE9u5O1x8FIOsAy+ffCLe1PAMecg3qHEViP0UJss
 qPD/6WnkkE2/6sv+8=
X-Received: by 2002:a05:600c:83c5:b0:4a8:c6a0:c08f with SMTP id
 5b1f17b1804b1-4a967e8c05emr91418275e9.35.1793219064188; 
 Wed, 28 Oct 2026 13:24:24 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a92de010bcsm63525935e9.0.2026.10.28.13.24.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 13:24:23 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 28 Oct 2026 20:24:22 +0000
To: Max Fillinger <max@max-fillinger.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I5ebc0d04c501d00dd35e8e23cd25d6696d95d719
X-Gerrit-Change-Number: 2029
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2029?usp=email>
X-Gerrit-Commit: 8b3cb6f6ef5d5f8c53dfd77d723ca99118732f1b
X-Gerrit-Comment-Date: Wed, 28 Oct 2026 20:24:22 +0000
In-Reply-To: <gerrit.1792688397000.I5ebc0d04c501d00dd35e8e23cd25d6696d95d719@gerrit.openvpn.net>
References: <gerrit.1792688397000.I5ebc0d04c501d00dd35e8e23cd25d6696d95d719@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyNjg4Mzk3MDAwLkk1ZWJjMGQwNGM1MDFkMDBkZDM1ZThlMjNjZDI1ZDY2OTZkOTVkNzE5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0d3839e9c45636eea1c4d38a98c12754ff6e1c86-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMACE-000000003Ww-3da6
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Remove Mbed TLS 3
 compatibility
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 max@max-fillinger.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1213840914036333523=="
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1213840914036333523==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xX3xKt6DVqQ="; charset=UTF-8

--xX3xKt6DVqQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Max =
Fillinger=2E

Gert Doering has posted comments on this change by Max Fillin=
ger=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029?usp=3Demail )

Cha=
nge subject: Remove Mbed TLS 3 compatibility
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3:

(1 comment)

File src/openvp=
n/ssl_mbedtls=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029/comment=
/101cfb5c_cd9671ae?usp=3Demail :
PS2, Line 156:     return mbed_ok(mbedtls_=
ssl_export_keying_material(ctx, ekm, ekm_size, label, label_size,
> If fail=
ing the build is accepted OpenVPN 2 custom, then that's OK=2E [=E2=80=A6]
I=
f there is an easy way to find "this mbedtls build will not work for OpenVP=
N" we can fail at configure time, but if it's really like "there are 10 opt=
ional components, and you need to have 8 of them 'on' and the other 2 must =
be 'off'" I'm not sure adding this amount of stuff to configure makes sense=
=2E=2E=2E

mbedtls is special anyway in that very few people seem to be usi=
ng it (mostly "Max", that is) and those need to decide how to build it - "d=
efault builds" are working fine for us, though=2E



-- 
To view, visit htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029?usp=3Demail
To unsubscribe, or=
 for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-=
Branch: master
Gerrit-Change-Id: I5ebc0d04c501d00dd35e8e23cd25d6696d95d719
=
Gerrit-Change-Number: 2029
Gerrit-PatchSet: 3
Gerrit-Owner: Max Fillinger <=
max@max-fillinger=2Enet>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerri=
t-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: Gert Do=
ering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lis=
ts=2Esourceforge=2Enet>
Gerrit-Attention: Max Fillinger <max@max-fillinger=
=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date:=
 Wed, 28 Oct 2026 20:24:22 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels:=
 No
Comment-In-Reply-To: Max Fillinger <max@max-fillinger=2Enet>
Comment-In=
-Reply-To: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>

--xX3xKt6DVqQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Max Fillinger=2E </p=
>
<p>Gert Doering has posted comments on this change by Max Fillinger=2E</p=
><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029?usp=3Demail"=
>View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_mbedtls=
=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029/comment/101cfb5c_cd9671ae?usp=3Dem=
ail">Patch Set #2, Line 156:</a> <code style=3D"font-family:monospace,monos=
pace">    return mbed_ok(mbedtls_ssl_export_keying_material(ctx, ekm, ekm_s=
ize, label, label_size,</code></p><p><blockquote style=3D"border-left: 1px =
solid #aaa; margin: 10px 0; padding: 0 10px;">If failing the build is accep=
ted OpenVPN 2 custom, then that&#39;s OK=2E [=E2=80=A6]</blockquote></p><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">If=
 there is an easy way to find &quot;this mbedtls build will not work for Op=
enVPN&quot; we can fail at configure time, but if it&#39;s really like &quo=
t;there are 10 optional components, and you need to have 8 of them &#39;on&=
#39; and the other 2 must be &#39;off&#39;&quot; I&#39;m not sure adding th=
is amount of stuff to configure makes sense=2E=2E=2E</p><p class=3D"blocks"=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">mbedtls is special=
 anyway in that very few people seem to be using it (mostly &quot;Max&quot;=
, that is) and those need to decide how to build it - &quot;default builds&=
quot; are working fine for us, though=2E</p></li></ul></li></ul><p>To view,=
 visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029?usp=3Dema=
il">change 2029</a>=2E To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setting=
s</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction=
"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2029?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<di=
v style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"disp=
lay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit=
-Change-Id: I5ebc0d04c501d00dd35e8e23cd25d6696d95d719 </div>
<div style=3D"=
display:none"> Gerrit-Change-Number: 2029 </div>
<div style=3D"display:none=
"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Max=
 Fillinger &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@=
lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: Max Fillinger &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld=
 &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-Comment-Date: Wed, 28 Oct 2026 20:24:22 +0000 </div>
<div style=3D"display=
:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-=
Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: Max=
 Fillinger &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"display:non=
e"> Comment-In-Reply-To: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;=
 </div>

</body></html>
--xX3xKt6DVqQ=--


--===============1213840914036333523==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1213840914036333523==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1213840914036333523==--

