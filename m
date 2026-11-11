Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2C6606A31C
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 10:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=nR6nMRC8;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=cXiS7Vjj;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=l6b5hnUz;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=WRsdpWJ6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=57j/N5eobvMICiYCdqKM45heipywpMJFxL0F3LPxsF8=; b=nR6nMRC80/FA3GB4TWUx7gWnj6
	NZyuuFdBiEIcI+9i8+kH8TfYNsL/CVLEQ/q0FEsH4O85oL6iArPyEhHIwan4bLCVsQ7qdEoL7gaYs
	DdRUDbrso/MGq18H9ITRHU4Y1UOTcs70GU9BJ5mFx1OT2m9zKIavn76I6mCYzjvx2Hjw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xR5O9-000000002Qv-2CMW;
	Wed, 11 Nov 2026 10:17:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xR5O8-000000002Ql-2tNC
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 10:17:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zUOCk3uS7aOUDDoNSuJyKrGdpeB87zAj0PZAz1tF/Zk=; b=cXiS7Vjj6IAhjBWVa94YPQQj7P
 NJAXlF8paS8GBvwiAocrZN+6xC4SoMv0iVTI90QZJ/mIfqZseJU5oEzwkmg3eg22o9YibrDOwF4Wy
 5P20ZMQJjKGmK1kRpT4GLBTKuMM2Zc9gm0aA6VPh4QZact8enNUj4I83j8sbZ/hoscgU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zUOCk3uS7aOUDDoNSuJyKrGdpeB87zAj0PZAz1tF/Zk=; b=l6b5hnUzc4f8cvxzvLnYzfps14
 4375lo5EaFPY8qfGaQ1pEJmj64Uwlep4fZCaumHrWD6A1BaE5hvWsbJciU8OExlNNqxO4xRqrFH73
 6fm+mHANuUK+3NQBMzHj2Tgcq3UfvY/GaqALq0MFEjcP8gF8CfwvWFfSy7Uvpz0OsfbI=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xR5O7-000000004CL-15uP for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 10:17:08 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4b467581b98so27505405e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 02:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794392221; x=1794997021; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zUOCk3uS7aOUDDoNSuJyKrGdpeB87zAj0PZAz1tF/Zk=;
 b=WRsdpWJ6tXdoATH+kcr0ddjTJXEiTfzM5YjZjo78ToT1vZqKII8GsDWpQd29EsB+P2
 FSDK2spnEraIYEnkhMilfYas1GdolyCV9ikbWZTtcMp2aN7mxh0fUi6eRZBxggqb2HDO
 ofVTTed3G1+hdvYMYzAgdldbd9IInav5psBPLqxJwsOcJG3vHWHqpNhT5Rh3GxKwhGHX
 q5leh1luCSwI7gtsfZGMIq+KGwcPbpub6lmQLjep+ZELpyCf5jjqdw9htH1IoI8b0cQJ
 ZOW1DfFajX8i3KJQIGJ5pCFsS6zBji0D6V8DhPld+WW/WKjj2sRagfbUylsBFz3TzZIO
 4H7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794392221; x=1794997021;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zUOCk3uS7aOUDDoNSuJyKrGdpeB87zAj0PZAz1tF/Zk=;
 b=cOA73+QkmSxAK0VnDoO+z7ZynhAjysIUwJzjnHbgrUP4SYQaIYCCp020yomNQb5H4X
 wHY/JZ+HhbbtL+V2JUtRz35uQYaVll+QKmht6fHVQOzhW57FDUudjMCfxIGqbKk6T0lt
 pgf6vFOGRy33KISZnHykC/GpEKM3YV692i+CheZmQBo8WZPXeU5vEJOa3U2Y3/I4lvPl
 CWuUn+jptjN62rszNgR4goSB7C8VKrAQc0W93XReLVI+71p6lcT7FLap4eSCzGQ85gz1
 DDvv5smnype7EZtijtQyZl7iLAMAG3VxlVHWdtPI5eYm2DMWsSmFZGS2EWBKSbi70Kpk
 o4sw==
X-Forwarded-Encrypted: i=1;
 AL+hErGWXK5e6375dgZRzYgA8e+h8tvrQcLVFlWcH7KaIBVrEecuv7xIm584y66uX0uMzXhPHvYCnIW7TVtb5cGU@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/IG6VnRxbVxDGZE2GyPVBKjjKqC3ZOR6L7z3WGDj06brC2/f4E
 VLfPXG4sP9xYk/Ydxzx1ZQzzSM/v5io9Kv/LG1ytR8ykLUyFO5ZKPDQeTVYWtqA0A9O62bGqi3k
 qdQ7IFMV3CVjCGkdq5UbIdXQHVXyc85ZnKmaT9KbjKm2BnnpgK/n8irDs9tztVf/DX2BL09ZAO8
 PLIlBO3Q==
X-Gm-Gg: AYBFou3j6NCRxm5Kn9A0vTuH9v7KEz83dWsA1l9kpeQ4AlBuRj3KOngzSoPna3tGZGx
 6bUpmK/tW0ktc1Lke/quXQfvnhIyBo0ybBslGIth4skGNmF02kdv4T0Zy218E//8RidqlA3FI4z
 9soZq4Z5HCpdCfrLELKlubvsSlg0YagRldk+v50SD3TYGAx9X20PQzV4+hBvqxTbmKl/7CJxhr/
 lwdhIeMzFq7GGuTCAQ/H22ZUQrS3P4McIAAsY5Exdw2A9ndt01wQv9m+LSSpAXzSuuUnfEa/JT/
 37Toysyd6V4GX5LId4dhrvWSeNUGNz5FHTX8uLDZs/Q0Zy3TFob6p936jL2aynWvuC0fhnIBLr/
 ehALQc+xu4XkcGMVFYmgSBwJ8JknTiKN72yDNUNqMnWN2RBpxdaIOf5lVTHU8liVjOjoK68/goR
 wBMPfdBJPYKyXm4Qs/12HQ1fcmcp4y/jjm0BNOL3qPllWqxM5l81lSF7iPdkrbUD38CBegNfEK3
 z5w9D7HwRKyRaXqAETNpU5fAa62VVRsu0asA+p+LJtftGahsclHlBbSHavJSgsCeoQaBePa2cHT
 qwEu+LlNzWrHj5SpM7ItPI9ciHW7+8Dzs3HZ5PCiMSpeYdcz1+ST74ivSxJb2ORIhFY3/4ocr9H
 c1XrFnYN5EPVeK+a3MGHPhSbsR/A6DSfCYGsHakajC7vZfgrZPo67iH8Cm82/Y+BMqBISBRvmH1
 a7uHerl7KdNELU7Qmf
X-Received: by 2002:a05:600c:620c:b0:4a7:9044:a87 with SMTP id
 5b1f17b1804b1-4ba093ab877mr31000695e9.27.1794392220604; 
 Wed, 11 Nov 2026 02:17:00 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba0204784esm164187635e9.10.2026.11.11.02.17.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 02:17:00 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 10:16:58 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I7ffae4da3b29521844a31d234fe6a9dd08954cf4
X-Gerrit-Change-Number: 2161
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2161?usp=email>
X-Gerrit-Commit: 193f1deedeb81851852f64a578c1e8518fd05343
X-Gerrit-Comment-Date: Wed, 11 Nov 2026 10:16:58 +0000
In-Reply-To: <gerrit.1794301782000.I7ffae4da3b29521844a31d234fe6a9dd08954cf4@gerrit.openvpn.net>
References: <gerrit.1794301782000.I7ffae4da3b29521844a31d234fe6a9dd08954cf4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzAxNzgyMDAwLkk3ZmZhZTRkYTNiMjk1MjE4NDRhMzFkMjM0ZmU2YTlkZDA4OTU0Y2Y0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <007d3cd0b6b504df93c9fa473f7d0887a4edbe4f-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xR5O7-000000004CL-15uP
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpnserv: only
 remove search domains that were added
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
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1379258195539166669=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1379258195539166669==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="M65jmMb6hzA="; charset=UTF-8

--M65jmMb6hzA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2161?usp=3Demail )

Cha=
nge subject: openvpnserv: only remove search domains that were added
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(1 c=
omment)

File src/openvpnserv/interactive=2Ec:

https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2161/comment/cf8087ab_032b3022?usp=3Demail :
PS1, Line 1826=
:         const BOOL added =3D AddDnsSearchDomains(list_key, have_list, wid=
e_domains);
> wouldn't be cleaner (and safer, so we don't risk re-introduci=
ng similar bugs) to take the same appro [=E2=80=A6]
Makes sense, done=2E Th=
anks!



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2161=
?usp=3Demail
To unsubscribe, or for help writing mail filters, visit https:=
//gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7ffae4da3b=
29521844a31d234fe6a9dd08954cf4
Gerrit-Change-Number: 2161
Gerrit-PatchSet: =
2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewe=
r: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwab=
e <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@list=
s=2Esourceforge=2Enet>
Gerrit-Attention: Antonio Quartulli <antonio@mandelb=
it=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Comment-Date: Wed, 11 Nov 2026 10:16:58 +0000
Gerrit-HasComments: Yes
Ger=
rit-Has-Labels: No
Comment-In-Reply-To: Antonio Quartulli <antonio@mandelbi=
t=2Ecom>

--M65jmMb6hzA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2161?usp=3Demail"=
>View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpnserv/interact=
ive=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin=
: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2161/comment/cf8087ab_032b3022?usp=
=3Demail">Patch Set #1, Line 1826:</a> <code style=3D"font-family:monospace=
,monospace">        const BOOL added =3D AddDnsSearchDomains(list_key, have=
_list, wide_domains);</code></p><p><blockquote style=3D"border-left: 1px so=
lid #aaa; margin: 10px 0; padding: 0 10px;">wouldn&#39;t be cleaner (and sa=
fer, so we don&#39;t risk re-introducing similar bugs) to take the same app=
ro [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">Makes sense, done=2E Thanks!</p></li></ul><=
/li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2161?usp=3Demail">change 2161</a>=2E To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2E=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2161?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType=
: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div=
>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Id: I7ffae4da3b29521844a31d234fe6a9dd08954cf4 <=
/div>
<div style=3D"display:none"> Gerrit-Change-Number: 2161 </div>
<div s=
tyle=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none=
"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: Antonio Quartulli &lt;antonio=
@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: A=
rne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Antonio Quartul=
li &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Comment-Date: Wed, 11 Nov 2026 10:16:58 +0000=
 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div st=
yle=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:no=
ne"> Comment-In-Reply-To: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt;=
 </div>

</body></html>
--M65jmMb6hzA=--


--===============1379258195539166669==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1379258195539166669==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1379258195539166669==--

