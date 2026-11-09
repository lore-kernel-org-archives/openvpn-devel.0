Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CECA606A325
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 19:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=dFWE46Hi;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=mlrHP7gi;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Xk+PtBha;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=edMuysDj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=yFoIJOC3o74+YUAYaYkqEIYYPs1DWGoPqx4z1gKpM2I=; b=dFWE46Hip9efZXIiHqr2RMlSP5
	mO8U/G3lB6hJL4dZvWy65QoC08bH0dYAF63WSVLm/qZdpV2OHmO49oFHOvUs4zdtLw2thbB0m0Bc1
	4kmqKJK+qho0o8mXiT2sB+dtFUlUzzBhRjTG4yEPUC/9Ux6iBfOROMUJiEUPBjSEhZPg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQUvz-000000005Vk-2esp;
	Mon, 09 Nov 2026 19:21:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQUvx-000000005Vb-0phx
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 19:21:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3nYkZU/rF1biw2QDXGdcYDXxGAdp7Cd1dgPK60pTji8=; b=mlrHP7giGKw+U/5P0d9AZzU0jM
 wTlw+oWyQKogInN7l75TUCTMZcjrWk/v4ywTOiUPBzV4eAGjpqwUlCPb3eI22HpbLNwQ9/VwZb5lW
 8LjHm9y9XtaUBh4NHofgtODv7S/jfoAbESoTCZ1QP7DvicQcg4Yi1M1gT1vHIeDCm01s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3nYkZU/rF1biw2QDXGdcYDXxGAdp7Cd1dgPK60pTji8=; b=Xk+PtBhaACliECIrCSr/WAN2TL
 TjGpImFlV59fTRJZxApYSKRnLfii6ER9VyY4BF7j/Z7LdDl2qSguUdO5xsAtzGwI7Km3HCTNsLECG
 ze/yMQ+DmJ5fZVzjG5TZ+pVv9BujpZ4rlSLWLRZU3kb/C8o0S7PM2Lcri4FEtZAiBDpY=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQUvv-000000007xv-2z6e for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 19:21:37 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso9777295e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 11:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794252089; x=1794856889; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3nYkZU/rF1biw2QDXGdcYDXxGAdp7Cd1dgPK60pTji8=;
 b=edMuysDjCG0RczuMF19/OjdQR6euhHymptoAvfvy8jFWrRCVxHQWcBA8xKWOQNaNKT
 YczuDHd3AtO/S/Y0m8xU2tgwzQ/Fii89OJU8Zylz16IhQn+8vDorFH/SHGRL4jhcP3Hh
 7fICLAumA03FVHuRBJOoqYb5f/iwXZtdjWKPQfwygGiB8+AvRiQrHeVbit3J0Dy65Dry
 QTFuoBtOHekEGrssobNjkWTpS3CuF5TstDRxUmLQ2GkMvNy81KaoNZXdm6kal39BkKgi
 0vXjAbCoKpTzWhUYVSWPG3Du81MY8GjZ0WGuAZOITvFFZDcNygcDBJA2B0yBPlgphpWy
 IWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794252089; x=1794856889;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=3nYkZU/rF1biw2QDXGdcYDXxGAdp7Cd1dgPK60pTji8=;
 b=KRFM/b69Nks0TmI17m0I6nmLjzf22yzE8n2V4ORXkNrRCx8ZXu2hKyo5yugdVWE5N5
 aGX4y3aDUhSPNVWeRmmOvVYcwfkkPWu3EgW5Zw5YFBqCHQ2Oa6RYU2VrQkmaCFjhjwGv
 k4D7wtL24F8GdOBrSvxjs6Fug6YJ3SHePgtQeEAj/kyg8YD8wESApTdPJKWo30xx3nIW
 O9QV/Flxj/81lRtDXJc+1s2HtTziNHTMrSOIJUiexWCTQn/ayrEnwk+89nWNWJV4+aJ1
 ruY+p4jXfJrtoxX8dSPD75mCZEdNc0sRcMiMNiqjxt5EZKeuhN6fthPyTkVE2Hg22hWQ
 bDOQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGiQt4qZN7VrcUjLDgK8xW0XhldDlgGzRcZJ/BJw9xR7DmFkdt52aYYofe8r7quTPEYg+3vQpFLpO43YpDh@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/O9O3OW6JhXXyo+IvGj050w72AsxTjFNaqXy20Z3+YJV6UBaA4
 VkKCTn7ytub1/DXriDiqNa0Uws/wZpcc/TPNBYVU8s7NY+X8ArmzNrjKdN72bRZGG7BwJYx4qle
 zjeFVIO0PbbxH+eGY/YVpJ+kLfsTtbiFv0Lr10DgFV5Qf+UB/GjcC5U64354Z1TCHANMy
X-Gm-Gg: AYBFou2H1H56ZYhLiEv6xBGDsAl7A3gi7u9Mcq/sd40F78WVtV+qvKZYsSL4XSxxgSG
 F/aDtdPq94d0rr4AlyJGxISKrF61O/QWQ2smmSql7k0iQnLOKrGFhrc+gyvdjRWWmWu5hgr6yUw
 W9mNRcL2BvsI3iKSPAOJKD0MBsLgGoGF79UKNQ28lF2U8dUd1vqhU+ybqznBRvXqnEZ0y+OgKra
 GwLyJQ92WIGnDieBfpcjMyBSmIDwimQA9uMiSNbTkp0NpIOJKGlwR9SSXurLLx/20uy/pV6+k4Q
 Q/UxiedkU2OUhqpwib7oc3b7edcJpNxCyYpMnC+XEsGSihalw8VZEoZoZvcKQl64Z9AH9p5BTDg
 S6bMWQ9ajSK9m+N1uGS0Vb/lLAHGXGrHyx2GIVH2DO3fbpAk9PcjVWetUQ8LJE4heqhzYwA85Mj
 ngZ4HRUojnvW4WaMDgnbMcAdSd9FnC4IP6Np8uGQAXer0ssM0oRtOroHMyYRYvfrJ39iiTqNP7S
 0/wEXMoANwqK+4sVVbpbIy7UWdH/K+AwFsYXk62eQ4dZ5dGIPTWY1ynGLTtzKj4R+UbObJNOC1b
 CMl1OLJFlVT6DYIgcWKr7282H/poGvaMI90f8bfa71ECXhkNwPV/JTB0dlyEbNEqoFp6SR5POH+
 wzhzuokRGZ6/H2oEuW8D4nx/b+0Rj3MriibPWuJP3xSl9BsPsj4DRqc21Xz0B5KcmkPHDAru40p
 E9WwpI38vwP4a7SJXmlG9YM7pq+lq2FZDb8Vo=
X-Received: by 2002:a05:600c:1c02:b0:4a7:d9b1:b684 with SMTP id
 5b1f17b1804b1-4ba0230cc8emr4822525e9.2.1794252088871; 
 Mon, 09 Nov 2026 11:21:28 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01fe2f09sm10400755e9.4.2026.11.09.11.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 11:21:28 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 9 Nov 2026 19:21:26 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: Icadbee50a3af55f0f2069f6d6f1ccc746180f368
X-Gerrit-Change-Number: 2081
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2081?usp=email>
X-Gerrit-Commit: 37bc5e99832e79ab44eb53acf01dceca295bc9d9
X-Gerrit-Comment-Date: Mon, 9 Nov 2026 19:21:26 +0000
In-Reply-To: <gerrit.1793618230000.Icadbee50a3af55f0f2069f6d6f1ccc746180f368@gerrit.openvpn.net>
References: <gerrit.1793618230000.Icadbee50a3af55f0f2069f6d6f1ccc746180f368@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4MjMwMDAwLkljYWRiZWU1MGEzYWY1NWYwZjIwNjlmNmQ2ZjFjY2M3NDYxODBmMzY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a5fec96082b45f4d7cf1697631e0be026ec22200-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQUvv-000000007xv-2z6e
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove support for
 --secret
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
Content-Type: multipart/mixed; boundary="===============4428918928982990941=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4428918928982990941==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9nGrJN1TKSU="; charset=UTF-8

--9nGrJN1TKSU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Arne Schwabe=2E (=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Demail )

Change subj=
ect: Remove support for --secret
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 7: Code-Review-1

(6 comments)

File src/ope=
nvpn/crypto=2Eh:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081/comment/9=
452977f_f8557e07?usp=3Demail :
PS7, Line 67:  * [ * packet payload * ] </tt=
>
This line seems to be a leftover now=2E


https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2081/comment/a0850095_3bff5d62?usp=3Demail :
PS7, Line 110:  * =
static key mode are supported=2E No encryption will be performed on the pac=
ket,
Paragraph still says "both TLS-mode and static key mode are supported"=
=2E


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081/comment/7f2849f1_0299=
08e4?usp=3Demail :
PS7, Line 113:  * <tt> [ HMAC ] [ - packet ID - ] [ - pa=
cket payload - ] </tt> \n *
There seems to be a stray `*` here=2E


File sr=
c/openvpn/crypto_mbedtls=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
081/comment/301243a1_361f34b6?usp=3Demail :
PS7, Line 1016:            "GCM=
 or CBC mode is recommended=2E \n\n");
Probably stray space before the firs=
t `\n`=2E


File src/openvpn/init=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2081/comment/6ecfa9e1_f8f4cf62?usp=3Demail :
PS7, Line 1016:       =
      options->genkey_filename ? options->genkey_filename : "stdout");
Shou=
ld this be `genkey_filename` (instead of `options->genkey_filename`)?


Fil=
e src/openvpn/options=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081=
/comment/013d601b_9cf96d3a?usp=3Demail :
PS7, Line 565:     "--cipher alg  =
  : Ignored=2E You should usually use --data-ciphers instead=2E\n"
`--ciphe=
r` still works in p2p mode in options=2Ec, so it doesn't seem to be complet=
ely ignored=2E

Maybe we should say something like "Deprecated, use --data-=
ciphers / --data-ciphers-fallback instead=2E"



-- 
To view, visit https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Bran=
ch: master
Gerrit-Change-Id: Icadbee50a3af55f0f2069f6d6f1ccc746180f368
Gerr=
it-Change-Number: 2081
Gerrit-PatchSet: 7
Gerrit-Owner: Arne Schwabe <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenhel=
d=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerr=
it-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atten=
tion: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lic=
htenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Mon, 09 Nov 2026 19=
:21:26 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--9nGrJN1TKSU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Arne Schwabe=2E</p><p>Patc=
h set 7:<span style=3D"border-radius: 3px; display: inline-block; margin: 0=
 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p>=
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Demail">Vie=
w Change</a></p><p>6 comments:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/crypto=2Eh:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2081/comment/9452977f_f8557e07?usp=3Demail">Pa=
tch Set #7, Line 67:</a> <code style=3D"font-family:monospace,monospace"> *=
 [ * packet payload * ] &lt;/tt&gt;</code></p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">This line seems to be a left=
over now=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2081/comment/a0850095_3bff5d62?usp=3Demail">Patch Set #7, Line 110:</a>=
 <code style=3D"font-family:monospace,monospace"> * static key mode are sup=
ported=2E No encryption will be performed on the packet,</code></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Paragra=
ph still says &quot;both TLS-mode and static key mode are supported&quot;=
=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081/=
comment/7f2849f1_029908e4?usp=3Demail">Patch Set #7, Line 113:</a> <code st=
yle=3D"font-family:monospace,monospace"> * &lt;tt&gt; [ HMAC ] [ - packet I=
D - ] [ - packet payload - ] &lt;/tt&gt; \n *</code></p><p class=3D"blocks"=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">There seems to be =
a stray `*` here=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;">=
<p>File src/openvpn/crypto_mbedtls=2Ec:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081/=
comment/301243a1_361f34b6?usp=3Demail">Patch Set #7, Line 1016:</a> <code s=
tyle=3D"font-family:monospace,monospace">           &quot;GCM or CBC mode i=
s recommended=2E \n\n&quot;);</code></p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">Probably stray space before the fi=
rst `\n`=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File =
src/openvpn/init=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081/comment/6ecfa9e1_f=
8f4cf62?usp=3Demail">Patch Set #7, Line 1016:</a> <code style=3D"font-famil=
y:monospace,monospace">            options-&gt;genkey_filename ? options-&g=
t;genkey_filename : &quot;stdout&quot;);</code></p><p class=3D"blocks" styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">Should this be `genkey_=
filename` (instead of `options-&gt;genkey_filename`)?</p></li></ul></li><li=
 style=3D"margin: 0; padding: 0;"><p>File src/openvpn/options=2Ec:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2081/comment/013d601b_9cf96d3a?usp=3Demail">Patch Set=
 #7, Line 565:</a> <code style=3D"font-family:monospace,monospace">    &quo=
t;--cipher alg    : Ignored=2E You should usually use --data-ciphers instea=
d=2E\n&quot;</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; =
word-wrap: break-word;">`--cipher` still works in p2p mode in options=2Ec, =
so it doesn&#39;t seem to be completely ignored=2E</p><p class=3D"blocks" s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">Maybe we should say =
something like &quot;Deprecated, use --data-ciphers / --data-ciphers-fallba=
ck instead=2E&quot;</p></li></ul></li></ul><p>To view, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Demail">change 2081</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icadbe=
e50a3af55f0f2069f6d6f1ccc746180f368 </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 2081 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 7 </div>
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
t-Date: Mon, 09 Nov 2026 19:21:26 +0000 </div>
<div style=3D"display:none">=
 Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Lab=
els: Yes </div>

</body></html>
--9nGrJN1TKSU=--


--===============4428918928982990941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4428918928982990941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4428918928982990941==--

