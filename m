Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93A6606A319
	for <openvpn-devel@archiver.kernel.org>; Thu, 22 Oct 2026 19:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=NQs4pdZf;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=K2PT4/C4;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Avi8u1zV;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Tfm6JBfq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=a6lAYLr4PXuKbI+aCfJTgqgGcqh3ctUbqT4vIrxJMZI=; b=NQs4pdZfV1D+cP6Bs9yHgSavYb
	mjptikGnrb5fDO9kDtEe3vu+Wna4Q+T34SapEqtehqfhVZ5qOU0Hh6Q27wrlKpH1KfRAee5Z5SNUj
	qNgUozlIVSkVenpUarP+dFECYK8I42lWbPAdJRswdS72Nv47HpJ+L91u0b7FE5YlV0S4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xJySu-000000006TK-1vZM;
	Thu, 22 Oct 2026 19:28:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xJySs-000000006Sy-2xZG
 for openvpn-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 19:28:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6XBVHJPek9ZdYYqEbWacT8tbzdKUR8RyFN0HaRA1d60=; b=K2PT4/C4VhOyA6dtvlb7BCdVUv
 A1+0RiH728eHm2z1SEfLIsNHQXuZMMcyu9UGgwoKqYG7nrzcFzP2xCm1xvWhR+fyfO6i3gX+P83KE
 t6YT7cJ0XHcqMtHej5Q5Pwgfveoa+Wvvl412aBXt92VKafMRvvHMCkxGXWM319Q/9DO4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6XBVHJPek9ZdYYqEbWacT8tbzdKUR8RyFN0HaRA1d60=; b=Avi8u1zVJU2WmuoDmTm1GV4kcm
 upy2v76vrtlUNjtU0wGH5TLJTfacscV9uC2fLcEUoWp8stutwzRkz+53qb7GXaCRtwwaoSlwaBFce
 iAXf9kaE/iHSzmGWqciVrasa5pTnBxi0wixmlVSpW+HQ7TpxxN5Ips7PINUyJXbMPRc0=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xJySW-0000000024M-30pS for openvpn-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 19:28:18 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-48441a2ba1bso81597f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 22 Oct 2026 12:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792697290; x=1793302090; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6XBVHJPek9ZdYYqEbWacT8tbzdKUR8RyFN0HaRA1d60=;
 b=Tfm6JBfqoSX9pxXXqCYJjYSq/IDZsZg1eFBAtp3R2OR9WzxK2HePDLb9asEkpvekfh
 KOsPf27+iBLPjukxv/nBWr14JzISDCHp+uNUf9NbJ/eTv8iu7V+DLd+/aEe4ov24wKqV
 iZl3gH0OUvDZV+j4J8RT95asU4OmnQ/D/j/rZ3iFttD9yaAnU/n1mXOl6DMwRIQa2D+r
 XZ2fcdAY+/kkOt767UfWQhckH1FpMDFYOgQGVYAgMXHL3cAj7u49BIG52QB1/ASKea+Y
 KSXJnzmJjBQg3cIfBQK9TOoNbRWfceV7+zg4LXiullM0tlNW9TKq1uTMTamh67qwNZIq
 IOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792697290; x=1793302090;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6XBVHJPek9ZdYYqEbWacT8tbzdKUR8RyFN0HaRA1d60=;
 b=JbjxngaZxFlpuFwIgYWfoqjSAeQl7wy6dlC2e8CAxMYaA1eZ2vqTdaDyT4/khJO3ID
 EZczR6/TlVJ4H2ydTQm5oNfi5iFxgZf1B+6QZ5c/p9M/G+gZsIgn0CxQ7OMUGiR7JZh3
 gLH5+Ozea1112yYvuU6ifbsFJ8n1OX2UKU1mZTM2L9+mJ8RRxxV0TTzpd7o1dbr0BgZ2
 PFWBXCyy4joQKR993pWz5TsAWSE501eSYwXLQuwTtLdgUIqQXqFOJ22bzyF9Za4PJhSX
 umwSDm42VBbw8zCD79C0oDXryzGxmhAWrZYwrMGY07XuN35IfzTMYksCKwUr4SxRkx7l
 9Hqg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxbuwIm3uRbg0q/sJ8Xi3Ht10m7mjijPTizfvmIAg2JdBI6f3leKduU+ptZ8wXMRzkIe0be+ShdZi3ilVXU@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLe1g3RBwyEmzg8TfWhPH4vLDX1DQl1KxZCWYoH7LOJxIBXxP8r
 aFoeOKqo64endYceod0g/IejIjlA6BvjvQUwnwvKaA6Th9ALhSS5J09UPuC5vfvwo18HPRfB79X
 taAKtAZTMqJxDA1432zlbpTnhgcUnraNuMSj5ktb5fZ/fFNr2rc/3X11hrhG2elWrQ2HE
X-Gm-Gg: AYBFou2hqFLolH1a78dNqn57tz61ACsl4+M4cjKnLIozJKvSR5Gu6FolZssw0l9Hk/R
 4gP5VU61vHsvXXkmQ7O3YqThG+uL3boujRCBIyP83iNLkn72fF5Os9G59cnM7FoUD+s18CC3juC
 sglYyxUO1qBV/QqI8FJTiC2TcPg1Dlai9EbrW4ndrabtvZ4CYmKnRdMc5Zt//bAk+rHACnUMRD2
 1WoJ0gofO8jhXeTbkRzaI0cOFrDM2Ggvvu1LUQXTCb/r6DGJZloWAU8EuFI72FOD2lalRklhlce
 lPZvJm506uaDw1flXTwXmop1nFj89LSj+OmhorCS3zJRY92CADu8b0vs7f1UVchO2KTjnigAkkJ
 4VkutWEDNvNYEf9UeN82IwuXt8dv4AlKGMXdBdl7lpCOF2jWjoKodpAsFlavWI/pjLI1/ScaqzK
 PmqcP3byXEdSdfMLLkP+Sq7qYFDo5f70ybDCNZsZewuO6ajUAG4mQOu2+zWtal2X3W5eDOWb7cY
 JJlIB+2JnP6Q14f+d1DQRp1jXcyutiDgX/PaccGw1Djxcmm5w1oMOvGD3WXOfQzKF+TFAtS4yKZ
 rFBaq+eXZR3kzAW/WEekpwMOTC8ibMMw9w1vB8ehEYkNcGbklezYX0qynNByrmBHYsYUTIvp5ek
 972T10VDuQStXHV+2BlXWJkRdJMc+Ck7vtnCuDwwdcQ==
X-Received: by 2002:a05:600c:8a1a:20b0:4a2:1e1:d55 with SMTP id
 5b1f17b1804b1-4a211cd5ee3mr703395e9.28.1792697289977; 
 Thu, 22 Oct 2026 12:28:09 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a211f0772asm282645e9.3.2026.10.22.12.28.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 12:28:09 -0700 (PDT)
X-Google-Original-From: "Max Fillinger (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 22 Oct 2026 19:28:07 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I5ebc0d04c501d00dd35e8e23cd25d6696d95d719
X-Gerrit-Change-Number: 2029
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2029?usp=email>
X-Gerrit-Commit: abced4a51301c1228875f58c87e15c7ec4056937
X-Gerrit-Comment-Date: Thu, 22 Oct 2026 19:28:07 +0000
In-Reply-To: <gerrit.1792688397000.I5ebc0d04c501d00dd35e8e23cd25d6696d95d719@gerrit.openvpn.net>
References: <gerrit.1792688397000.I5ebc0d04c501d00dd35e8e23cd25d6696d95d719@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyNjg4Mzk3MDAwLkk1ZWJjMGQwNGM1MDFkMDBkZDM1ZThlMjNjZDI1ZDY2OTZkOTVkNzE5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <43027f35b0a9929db9aa4cf4c043dc29f9c845ea-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xJySW-0000000024M-30pS
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
From: "Max Fillinger \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: max@max-fillinger.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Max Fillinger \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0152905828455059111=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,MXG_THREAD_INDEX_BAD,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0152905828455059111==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zafLHy72W6Y="; charset=UTF-8

--zafLHy72W6Y=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

M=
ax Fillinger has posted comments on this change by Max Fillinger=2E ( https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029?usp=3Demail )

Change subject: R=
emove Mbed TLS 3 compatibility
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 2:

(2 comments)

Patchset:

PS1: 
> There i=
s also a clang-format failure
Done


File src/openvpn/Makefile=2Eam:

https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029/comment/4034ee62_d1ec7d81?usp=3D=
email :
PS1, Line 95: 	mbedtls_compat=2Eh \
> you missed mbedtls_compat=2E =
[=E2=80=A6]
Done



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2029?usp=3Demail
To unsubscribe, or for help writing mail filters, v=
isit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: =
I5ebc0d04c501d00dd35e8e23cd25d6696d95d719
Gerrit-Change-Number: 2029
Gerrit=
-PatchSet: 2
Gerrit-Owner: Max Fillinger <max@max-fillinger=2Enet>
Gerrit-R=
eviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank L=
ichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-deve=
l@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>=

Gerrit-Comment-Date: Thu, 22 Oct 2026 19:28:07 +0000
Gerrit-HasComments: Y=
es
Gerrit-Has-Labels: No
Comment-In-Reply-To: Frank Lichtenheld <frank@lich=
tenheld=2Ecom>

--zafLHy72W6Y=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>Max Fillin=
ger has posted comments on this change by Max Fillinger=2E</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029?usp=3Demail">View Change</=
a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li sty=
le=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none=
; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/20=
29?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p><blockquote sty=
le=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">There =
is also a clang-format failure</blockquote></p><p class=3D"blocks" style=3D=
"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li =
style=3D"margin: 0; padding: 0;"><p>File src/openvpn/Makefile=2Eam:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2029/comment/4034ee62_d1ec7d81?usp=3Demail">Patch Se=
t #1, Line 95:</a> <code style=3D"font-family:monospace,monospace">	mbedtls=
_compat=2Eh \</code></p><p><blockquote style=3D"border-left: 1px solid #aaa=
; margin: 10px 0; padding: 0 10px;">you missed mbedtls_compat=2E [=E2=80=A6=
]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-=
wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029?usp=3Demail">change 2029</=
a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div =
itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5eb=
c0d04c501d00dd35e8e23cd25d6696d95d719 </div>
<div style=3D"display:none"> G=
errit-Change-Number: 2029 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Max Fillinger &lt;m=
ax@max-fillinger=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Eco=
m&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;open=
vpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none">=
 Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Dat=
e: Thu, 22 Oct 2026 19:28:07 +0000 </div>
<div style=3D"display:none"> Gerr=
it-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: =
No </div>
<div style=3D"display:none"> Comment-In-Reply-To: Frank Lichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--zafLHy72W6Y=--


--===============0152905828455059111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0152905828455059111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0152905828455059111==--

