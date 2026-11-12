Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855C2606A331
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 18:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Mld4+drG;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=FiFeAEBY;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=L2MEb93t;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ZWB+iYQz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=8u79GUbHBD9Xn1O+ip2A06q7uq/VCcProJ1u15Cp7o0=; b=Mld4+drGyrFhU2gozD2Fx5NiM5
	KEW8Kf8wYzVYaYPwniIUfG1YftCyXt9s/TnZoj7PJ4S3w8xDJmk/0rft3TH6taoaIItt/U6B54jhB
	PBoLEDno7vZd5mwaa9gmYy7XDMXgZBGUP2sVAhhELHnympQgtXkoajDz5Ydk4SE1IGMY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRZ7o-000000004Zz-0IyK;
	Thu, 12 Nov 2026 18:02:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRZ7m-000000004Zt-3GL3
 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 18:02:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WWIoIZbfQgBdxEimYBAIf8jHDxjFb6bUPqhYdlVZktE=; b=FiFeAEBYMkPNmL5wEIpkHSd6mR
 A4uL4PKvabvUkxmyfwPj3kaoW3ztIvJ/14zbuE+XgsqGLjiXKjR/F2ETRZI85hpPuJnSGobIAtuTx
 Zig9AAJE6DKtM/l2aCT3v20IwphigG9PXWC67DVu2iLKt//ns+4Gkvo3Q+9tHI5rjS7g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WWIoIZbfQgBdxEimYBAIf8jHDxjFb6bUPqhYdlVZktE=; b=L2MEb93t03vKmjYNEltXwOdune
 DQHqv56/z6ul9VNzJBUQYuAwF+Xwoh9ujX92WbfEPklViy7tQg5HWdiTt59HIJy9Cke/I7MFEiQEB
 XTFW2uRHJ3zcZsWJvN70aHdxer5AxgTUKdS6XhcEgbFWkB9UN/hfeNuZDmyspLo+JOYk=;
Received: from mail-ej1-f53.google.com ([209.85.218.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRZ7m-000000004KG-0MvZ for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 18:02:14 +0000
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-c4d58c50743so1407766b.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 10:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794506527; x=1795111327; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WWIoIZbfQgBdxEimYBAIf8jHDxjFb6bUPqhYdlVZktE=;
 b=ZWB+iYQzK11SNfcDk0RPqmjeZR9Nj1oV6qN3+ACdrflBzgQUx46kBZp5rGmQkL8d87
 yicT/Z/V7I689J34owZh8jrEQ9v6NKfHb0VbcLfa4BcUCM41ylXR3AIMbA736719NCMI
 55sQB7yrh1Fl5tbbRjFDcUtNr7IiD/fAu65yZqqYHCYSVyasWpfHT6tgmsDtgy6/BJZm
 Xd9hf/g55GYogH5eaYtWcW9G/4w97m2Yp+ebMyCSjFP+4pbytpdB7wuiI06x5QoavqCj
 g9yKvJr0ipDafhyf9xptycf/kIyjClhHLiS19NqheutFXJ4HWqm7NN7EhZGom/GV0+GN
 wS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794506527; x=1795111327;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WWIoIZbfQgBdxEimYBAIf8jHDxjFb6bUPqhYdlVZktE=;
 b=igoq8ZGxQBMeOixoxA59bNSXV5EnlDhT08o7vH8wWVFp8WbsgHJMVMbduXj4thcv1L
 xHUXk68sUPqk4dW02EaKnSbeIcour0PJHukmtXWZKpF9gK6BrQA/zTZiXoQs5P2MwEtu
 AeM37PQdkz1+gI8SUt0afJbl+2uaLtZ35442SE+9TpI2Y1YJcg9v9jAsFq8q718NfoGw
 7nnRN2YLJ06cFi+pufts/C0WNpf0UUY6lv0/2XVM66slGYNBBXI8E/uIRHXfSz8iq/cQ
 RYYC43xfCs8q7Ws6oKgfi0sG2W3n6/yeozPuZNaG0rqXKf2QweDThp+kFw3WLYkw0V+j
 CkRg==
X-Forwarded-Encrypted: i=1;
 AL+hErFmLMUlSwOD6D+i1Ng208OjmY0a6GXyKj8w7E/bunNzAdFIWLCDV2vyAavohlwwYBR7d44T1MmDJM62utqn@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8Km6BCVJOkyR9t2XLeddxRtgDmxMA2waO2+F0iI996RPdkyjIg
 p3XwyvLxyPhkTbt3E4Xo+Bp6EwWoFMEazZ/srMAqYIZ0rysDIWDCoSjcXTvphQhAfziTR2DetGV
 a0ZSr3fYbhCSEZiE8fEnUdoE782z2ewUt//hDa/1kc5oeM9dJuCN6bPAsdGTw1nQ1i357638Oni
 I68dV4Qw==
X-Gm-Gg: AYBFou3mMNjCFxWe18RtykoCGAy2CyH1rFgdPB8C/JOs07O8j9rBm/e7qoVX5kiSrBA
 kik1RvvpxsWcJNy4huv9MRK3KB6IU9P+5SiV90uGbfKjf+KXebDyiXLUBRNfvEuHVPFoYcQ7eZu
 u9e7r7hYMboLsfIXBIf39O7tzdV0dbLuqXl957PO9O3n1VZpYu5dcRIhjaWFC+kLbigRzUTgDgO
 RgMhr3/s1uxvldBoCbHW0RrzbRbkox6XFgmUF5fNmVeO0rqKPxHve9z0J/QJ/+41itQAzjuviRC
 PavTo/uqq+zyKLwY/J0paAPgpSIOGO4O3vVWKDSoXVopgFCC4bno3eUDpWp/ACk1xDoAIYsT85l
 vbK3CVya5bzoSd5TWc6P6FmBm8REBpR0FJMbL6zMh0ltUCP7qE5DkA9LMQ2GErrbsIDQbIj//e8
 eNcuwynxxHnTaSqXiiF/QBqvSSUfJVJ9LFaHD+b3y5mpN+XDBCj5IkerkFbQHiSl1jyOPgnkTq0
 s5zCIzAc9C/eRtQBvoYK4vOAD6tJmCoU5nzdCqd6W8CiQYuRa6Rz1AQVu4bOlI4kHwfMoooxbJ8
 3Kdj2NO0ddfFi7e1Z21Bw7xnFC1jTdSEobzmai/dsKPX+fsyHGO+qUJh1fhHOSPhOerlKOqV+A6
 9iMrQJNm4OaaRFHUk93zAo19+BZxqFLVK+CgGUsuhE4dFzVTOINW7Fqpt2sdXh15YIDu+5zu/to
 HweG81DmTOdjPCWC0=
X-Received: by 2002:a17:906:f58f:b0:c42:82ac:b6a9 with SMTP id
 a640c23a62f3a-c509643abd1mr1147766b.29.1794506527166; 
 Thu, 12 Nov 2026 10:02:07 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c60da11c5sm474855f8f.54.2026.11.12.10.02.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 10:02:06 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 12 Nov 2026 18:02:04 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I57469ca50c551ad475510690ecfa2d5e7cf9cfcf
X-Gerrit-Change-Number: 2159
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2159?usp=email>
X-Gerrit-Commit: a8daf527aea3e6b2ba8405f3fd2fb14b961414a8
X-Gerrit-Comment-Date: Thu, 12 Nov 2026 18:02:04 +0000
In-Reply-To: <gerrit.1794300772000.I57469ca50c551ad475510690ecfa2d5e7cf9cfcf@gerrit.openvpn.net>
References: <gerrit.1794300772000.I57469ca50c551ad475510690ecfa2d5e7cf9cfcf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzAwNzcyMDAwLkk1NzQ2OWNhNTBjNTUxYWQ0NzU1MTA2OTBlY2ZhMmQ1ZTdjZjljZmNmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f7e1a8c0d331c33471fdbfdd63dada0cff9151e4-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xRZ7m-000000004KG-0MvZ
Subject: [Openvpn-devel] [M] Change in openvpn[master]: openvpnserv: reject
 a config file passed without --config
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
 openvpn-devel@lists.sourceforge.net, heiko@ist.eigentlich.net,
 antonio@mandelbit.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3091645884182244372=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3091645884182244372==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OEQbJILjiuE="; charset=UTF-8

--OEQbJILjiuE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe, Heik=
o Hund=2E

R=C4=83zvan Cojocaru has posted comments on this change by R=C4=
=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?usp=
=3Demail )

Change subject: openvpnserv: reject a config file passed withou=
t --config
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 6:

(1 comment)

File src/openvpnserv/interactive=2Ec:

https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2159/comment/28d42a47_9074fb43?usp=3Demai=
l :
PS5, Line 358:  * openvpn=2Eexe takes a lone argument as the config fil=
e only when there are
> Can you make this doxygen, please
Done



-- 
To vi=
ew, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I57469ca50c551ad475510690ecfa=
2d5e7cf9cfcf
Gerrit-Change-Number: 2159
Gerrit-PatchSet: 6
Gerrit-Owner: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Antonio Quartu=
lli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-CC: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-C=
C: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention=
: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Attention: Heiko Hund =
<heiko@ist=2Eeigentlich=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-Comment-Date: Thu, 12 Nov 2026 18:02:04 +0000
Gerrit=
-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: Heiko Hund <he=
iko@ist=2Eeigentlich=2Enet>

--OEQbJILjiuE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe, Heiko Hund=2E </p>
<=
p>R=C4=83zvan Cojocaru has posted comments on this change by R=C4=83zvan Co=
jocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?=
usp=3Demail">View Change</a></p><p>1 comment:</p><ul style=3D"list-style: n=
one; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpns=
erv/interactive=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li sty=
le=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159/comment/28d42a47_90=
74fb43?usp=3Demail">Patch Set #5, Line 358:</a> <code style=3D"font-family:=
monospace,monospace"> * openvpn=2Eexe takes a lone argument as the config f=
ile only when there are</code></p><p><blockquote style=3D"border-left: 1px =
solid #aaa; margin: 10px 0; padding: 0 10px;">Can you make this doxygen, pl=
ease</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?usp=3Demail">change 215=
9</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5=
7469ca50c551ad475510690ecfa2d5e7cf9cfcf </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 2159 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojoc=
aru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: Heiko Hund &lt;=
heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit=
-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<=
div style=3D"display:none"> Gerrit-Attention: Antonio Quartulli &lt;antonio=
@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 12 Nov 2026 1=
8:02:04 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes <=
/div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=
=3D"display:none"> Comment-In-Reply-To: Heiko Hund &lt;heiko@ist=2Eeigentli=
ch=2Enet&gt; </div>

</body></html>
--OEQbJILjiuE=--


--===============3091645884182244372==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3091645884182244372==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3091645884182244372==--

