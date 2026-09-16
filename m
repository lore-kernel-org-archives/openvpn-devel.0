Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20BA0C982C9
	for <openvpn-devel@archiver.kernel.org>; Wed, 16 Sep 2026 16:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=84hL1bBYaK32rvDCYQs19NwNezUEXupx4Denod5iL60=; b=YilHCULlJ2UGy7IHjWpy5Oamqw
	tVE/E9Q7BCBGzNt41/hXSklixu83HC0L5UQcvz1KZbNRSayn4HeWgDgxkMSRRr1I1PZArx0ZXkLDt
	jMKdmylvb+C3xSHQYnQikJg2wJFPsN7Y4oeAlzCQ71VgrrLd0FzRc/lepqjFFmIrqKtc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6s7m-0001Wd-46;
	Wed, 16 Sep 2026 16:04:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x6s7U-0001VB-0o
 for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 16:04:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=YIDDLhaCWrUd10pB9DNszO/6+m3VLnrETqZpgx9WJ6c=; b=CHZhh5AaPWnY3lh266c5Hulhal
 vZ5QTQT2yB5lvdLfMTGwCoz+KZ/w09LwNYjkEYwQx876IvGCueS16fQNiXuc8g2b7EDr/0uVi1pIx
 +6SybycA87iSfLSrj28BQQeBksmQYSw5O/fkw8GwQBbxpm/Cr/9ROON6wEPoLKrxrQig=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=YIDDLhaCWrUd10pB9DNszO/6+m3VLnrETqZpgx9WJ6c=; b=Z
 0Fa27DAU8qoqMSg7k8a8jSrFQaROf/wT05xm0cr8MWE5HIYXh80P+5Aagnp2n3F8zKQ//g5vh8Ebe
 EMwKXQHt5VOw5jz+wgCs1k57Of6MjJzpCvKhAFjt/2GAcvkKEuNdJbato6Hhb45SX5bCcF484CcWw
 +hzzF7xagFsvt+Xg=;
Received: from mail-lf2-f12.google.com ([74.125.229.204])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6s7M-0004Yx-27 for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 16:04:16 +0000
Received: by mail-lf2-f12.google.com with SMTP id
 2adb3069b0e04-5b74d0133e0so1083257e87.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 16 Sep 2026 09:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789574649; x=1790179449; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YIDDLhaCWrUd10pB9DNszO/6+m3VLnrETqZpgx9WJ6c=;
 b=dErlMfNhmyZ2bWM3gW/ye98U33oUv7Dp9V+ncS5TbRP4QDkFd4/9j6VVX1A8R3ur7n
 b5X3NnXOXgcWxbiApkJ2JVpqHCFS7/4Dwd2VkLt/CehtB0Te3IDWI5nCONwegp1oVLT7
 Ju9C8hyi19ntF0u3eylglslb2JmcrrkzL/e+Iv09zGQSY6482zEmqgjYQSAlJRDzmKZe
 FrHBseQjnsq55GaJ2S7cyIZmCMXJmrXKQJR1ebqHuiSJZWUZWNdr1Uv2j6TQGAJsmtdR
 aUGU9sVn0qzfKLgw3a+V2G85EGekvDVsTEPc1vJZpH4DZy9cMbWCNru9zz1CcdPG/iCa
 aW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789574649; x=1790179449;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YIDDLhaCWrUd10pB9DNszO/6+m3VLnrETqZpgx9WJ6c=;
 b=W9XVAqLKhE+92+xumum0Y8oMPOJmJ22EddmeMGT5Ab4iqATGYslLOe+4OKo0DqCIh4
 UM6UFVJ5fxKWbeY0DU1WxUSGS2lVRFuhc9tBUKNSsVsQ/aDw4o9VFYMABcCr89vSty6B
 u/Jrl9tDU8bMMzDxlz/yOEom3ePHdS8EDaQYJxCTM0oMSLK2fkTbMRBma3ylXdXnPdrZ
 AeMV16u358U1Fdy2jjtc7TXGBw3ty4VfSvYM7yzMKe/LnAAXyjNYtpMUnj2sYCh/0S62
 elzQsxkFHD2mwMWoSbc6Ke2I5w8mpqCZo2sLW6YS+aT6JwQ48CNllsFfGGqm3hBOxW98
 KKvg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzMy9C9yUj45teZCUpX1rrfsEa5hzLWwWFJcLi8Gh/+TPfcRp1L08XqkGQx1P9e74/f4k8QvwjVal7hYogo@lists.sourceforge.net
X-Gm-Message-State: AFuF++kks1zggOw46s15tbtjXPusyJUlxhIGeOdmMifXX3ggzToXXo/X
 aaodmcaxmsplMce7umQ0W+bWJZi9+tEhGDDJF1gO0Ddzz+qrj0JVLDoCtuN643Ec0T9WwjLm8l3
 q0lhxUknzNsUeD4OBuP7QeArDZS9eGXNgGIzWi+eBfvF6vbNyZg+/rhsqaC0Y1RjXyPxaus1zw8
 bFr7XgVQ==
X-Gm-Gg: AYBFou0U/7iu0cHy4s2IY59045CN936D4YXHRSMttA60/hgQmdSVtXzwgUvnkxLkUyF
 s9tZGuS5i+dM5kcF24P03wrCvHra+GbpTuwGb2FA1T4XvHDzKW8k1RCbaSTYuAuPMRJUo13qIOG
 yjA+W7MzTWGQBsA9IcEJ2nxY+UUfpHIbPM34YguQJoNxOT8BkoL24c9rqh3yFt21lLblArtCchc
 qV1KhgN6Tefhur4tZVvPl//37wi/v4fWzh9vX+oRYYigZbXhyZKzNkryE0HkDdd3gYo4AsG3bR7
 DJ34mEaxFQlDCR47rCnf7srdFfyvbtV7ShvKvp+RFwNB6Rw/T8hFlHCLqc9HqM0n53UKaQW6q6R
 42/lEt6rIPPZvlz4rQJYtNsKgP8/hC2IVJ5Z+ARA4/8Ja+n0k4GHCkYAWFjexsPA01bbcc3exya
 4xavC2brhPpajdVckkFJUWygMun6k2orhVA5KCWMABz3dnMLco3YCm/VY1SfQNPP54IQnBp7yYE
 pSqm00aO2VSEQv3T669RzKZBwT89/oSr94hykvSP5G9OEhwZeUabfuhHEiqznhhBlBGO0t9u/+p
 gij+Xi/yI3XI3B/zmwarRURpzH9jIXxwMIGqOoPiS0bnqdY/MZMWMOTxa7iEmHsqLMhQ5krv
X-Received: by 2002:a05:600d:6446:10b0:49f:bc43:9e8e with SMTP id
 5b1f17b1804b1-49fbc439f6dmr2847265e9.26.1789560111072; 
 Wed, 16 Sep 2026 05:01:51 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e83d9e77asm72056915e9.7.2026.09.16.05.01.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 05:01:50 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 16 Sep 2026 12:01:49 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I16187153e5b107eb08ccb7c9c9ed4acd6377af0c
X-Gerrit-Change-Number: 1766
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1766?usp=email>
X-Gerrit-Commit: a910137b2e1847e47fe1bdb82df13814f07ce7a8
X-Gerrit-Comment-Date: Wed, 16 Sep 2026 12:01:49 +0000
In-Reply-To: <gerrit.1782992478000.I16187153e5b107eb08ccb7c9c9ed4acd6377af0c@gerrit.openvpn.net>
References: <gerrit.1782992478000.I16187153e5b107eb08ccb7c9c9ed4acd6377af0c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyOTkyNDc4MDAwLkkxNjE4NzE1M2U1YjEwN2ViMDhjY2I3YzljOWVkNGFjZDYzNzdhZjBjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8f0cf4cce126594bf8343c97417d62b7d7d5abf7-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x6s7M-0004Yx-27
Subject: [Openvpn-devel] [S] Change in openvpn[release/2.5]: Backport
 stricter check for valid tokens
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4108853511038070264=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4108853511038070264==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Y1IdFndqmq8="; charset=UTF-8

--Y1IdFndqmq8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: razvanc=2E

plaisthos has posted comm=
ents on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1766?usp=3Demail )

Change subject: Backport stricter check for valid =
tokens
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 2:

(4 comments)

Commit Message:

http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1766/comment/095f4113_22b89ef2?usp=3Demail :
PS1, Line 10: adds a =
few unit tests=2E
> I don't see any actual unit tests in the code=2E
Yeah t=
he backport dropped the tests,  will remark in the commit message


File sr=
c/openvpn/auth_token=2Eh:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1766/c=
omment/89bfb120_c1b1c38f?usp=3Demail :
PS1, Line 120:  * This function will=
 always read as many bytes as SESSION_ID_PREFIX is longer
> "if longer"?
Ac=
knowledged


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1766/comment/cc0a6b7=
e_aa60ef57?usp=3Demail :
PS1, Line 122:  * calling with struct user_pass)
>=
 I am not sure this comment continues to be accurate after the change intro=
duced by this patch, since [=E2=80=A6]
Yeah, removed that part=2E


File sr=
c/openvpn/auth_token=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1766/c=
omment/8f42e43e_d1baf5e2?usp=3Demail :
PS1, Line 39: static_assert(TOKEN_DA=
TA_LEN % 3 =3D=3D 0, "TOKEN_DATA_BASE64_LEN is not a multiple of 3");
> The=
 `static_assert()` tests `TOKEN_DATA_LEN`, but the message says `TOKEN_DATA=
_BASE64_LEN`=2E
Done



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1766?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageT=
ype: comment
Gerrit-Project: openvpn
Gerrit-Branch: release/2=2E5
Gerrit-Ch=
ange-Id: I16187153e5b107eb08ccb7c9c9ed4acd6377af0c
Gerrit-Change-Number: 17=
66
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-C=
C: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: razvanc <razvanc@mailb=
ox=2Eorg>
Gerrit-Comment-Date: Wed, 16 Sep 2026 12:01:49 +0000
Gerrit-HasCo=
mments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: razvanc <razvanc@mai=
lbox=2Eorg>

--Y1IdFndqmq8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: razvanc=2E </p>
<p><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1766?usp=3Demail">View Change</a></p><p>4 comments:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0;"><p>Commit Message:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;">=
<a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1766/comment/095f4113_=
22b89ef2?usp=3Demail">Patch Set #1, Line 10:</a> <code style=3D"font-family=
:monospace,monospace">adds a few unit tests=2E</code></p><p><blockquote sty=
le=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I don&=
#39;t see any actual unit tests in the code=2E</blockquote></p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Yeah the ba=
ckport dropped the tests,  will remark in the commit message</p></li></ul><=
/li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/auth_token=2Eh=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1766/comment/89bfb120_c1b1c38f?usp=3Demail">=
Patch Set #1, Line 120:</a> <code style=3D"font-family:monospace,monospace"=
> * This function will always read as many bytes as SESSION_ID_PREFIX is lo=
nger</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin:=
 10px 0; padding: 0 10px;">&quot;if longer&quot;?</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowl=
edged</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"mar=
gin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1766=
/comment/cc0a6b7e_aa60ef57?usp=3Demail">Patch Set #1, Line 122:</a> <code s=
tyle=3D"font-family:monospace,monospace"> * calling with struct user_pass)<=
/code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px=
 0; padding: 0 10px;">I am not sure this comment continues to be accurate a=
fter the change introduced by this patch, since [=E2=80=A6]</blockquote></p=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">Yeah, removed that part=2E</p></li></ul></li><li style=3D"margin: 0; padd=
ing: 0;"><p>File src/openvpn/auth_token=2Ec:</p><ul style=3D"list-style: no=
ne; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
766/comment/8f42e43e_d1baf5e2?usp=3Demail">Patch Set #1, Line 39:</a> <code=
 style=3D"font-family:monospace,monospace">static_assert(TOKEN_DATA_LEN % 3=
 =3D=3D 0, &quot;TOKEN_DATA_BASE64_LEN is not a multiple of 3&quot;);</code=
></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; p=
adding: 0 10px;">The `static_assert()` tests `TOKEN_DATA_LEN`, but the mess=
age says `TOKEN_DATA_BASE64_LEN`=2E</blockquote></p><p class=3D"blocks" sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li=
></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1766?usp=3Demail">change 1766</a>=2E To unsubscribe, or for help writing =
mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1766?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: release/2=2E5 </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I16187153e5b107eb08ccb7c9c9ed4acd6377a=
f0c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1766 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display=
:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ra=
zvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Comment-Date: Wed, 16 Sep 2026 12:01:49 +0000 </div>
<=
div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"di=
splay:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comm=
ent-In-Reply-To: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></htm=
l>
--Y1IdFndqmq8=--


--===============4108853511038070264==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4108853511038070264==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4108853511038070264==--

