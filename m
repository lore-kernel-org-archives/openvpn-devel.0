Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F7EC5CFDB
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 20:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FQCwpOakyNH+PxtDpdMCRgHzADGpPOVjoz59TGqR9Pc=; b=N/vpDwhTkqWUJnvbebySXE4rw7
	pgBXPuQz20eV8X96J668eMz3OZrrsQZCUtj5zlC0tb8fel6mUNrkCBB7SiuAxhI1rDAMbFpsYgrQ9
	cxaw0UjfJLi5IXyMgyr8syVVul47MN9TQgcH6iM/T43ZHp/Guiy9myI0HRf5b2JH+JXc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wubiS-00033Q-K1;
	Thu, 13 Aug 2026 20:07:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wubiR-00033I-BD
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 20:07:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=oPs33K8XKTT42N6/LA3tCiv+neYHKZEooM7hUfz4AVw=; b=ETkSKfPRLX11ePaw1pVu5wQ5Ij
 SB27SY4hoiQUsewtWUDXKVJQon76tLec71Tbr4RRz8xeUu8HVktKSBbRz1y7Be5sSjn4VmYpe4SYY
 qcj0kIcR/W0h7R8dv1fEpCJR7oHdh6j4FZxzXjYTz94D2793PcK+IUHaXoC1Vjuzx2bc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=oPs33K8XKTT42N6/LA3tCiv+neYHKZEooM7hUfz4AVw=; b=e
 dYc1qgGwlsJ3k78k6ahHiduAzbvLOnYmlyRIv9Jzk49lcFK7zuOgFdRaPWg/PjswwYaizHrgY/JCy
 D4dINAdIRt6vfBg9dy3FArNgus5E8GqBnnRf7Pj8WESjE97HsFNNXNRs21yjqIahkIkGTrpkJc2zm
 SiLfiCT4trBeyYiY=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wubiO-0005AQ-RU for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 20:07:51 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-49557167508so2877995e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 13 Aug 2026 13:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786651659; x=1787256459; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=oPs33K8XKTT42N6/LA3tCiv+neYHKZEooM7hUfz4AVw=;
 b=L10fRELbxl5rR9MOc2wAx5+zQNv0WXOl0+maruSMLTovph7va9LBwzvs0FGj53TUH4
 i0aKLGhZPhF5PViP9hhKt+djTOeoTBeuoLfIzCkkllQliwVEt/GyZa9PS7Bru8UXDyi0
 dIoXRk7Y7+yTdkwbAOlvBFVjTAhZ9riqHle49VJvCRimbNt1mvn381+7Po3n7iQltaoN
 uFwfYKeZOOCidP6oGXDME2ULd0V1rSXEHCI4D4nfk8nhdwvWRgCSaNZDM5Iwiv7MPBkQ
 wtxwHlk1Wg+T0hIVSHB5led58aixpM7l3WKCHB3jXX0Y2gJyiAd8Ijd7/DySohJtipqy
 KExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786651659; x=1787256459;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=oPs33K8XKTT42N6/LA3tCiv+neYHKZEooM7hUfz4AVw=;
 b=C2RhyNn8dFltEheEYsYsxnAZmVvclWTjrZO9qA3k1VQoOgBwHd2BilcQDfARDrknlp
 54f2rcuihXf/1068B0x4eCPDDMVtm7QgGrU/ciH7yYHweq7lOWeAFa1gIKouU2soU8X1
 zUcSxAKi30TvNmEtl7Q+9mI+v0rYvbnzW399W9ImRY1GjF9Ch6s5OV5JZo7t+/E19bu0
 J9KfYUlYkZzWt17+JqQzz92HWvJsFBK8oE58lWI/hj8ePz4E1/zBCj+JWOxLysFivhqN
 b0MPsgFnx6D/aBAz4D1uQaiUoYVHIrcl3THFJMPfINEgbfR8Rom/6/Iw6LrdnfiRtEfD
 Krew==
X-Gm-Message-State: AOJu0Yyz/MGy+ySj5nA3DK9/qNOJca0OadiLQwCYYpc2iN4JN3zjvmDp
 Bw+kIj+uz3w8BLnWzsWGi/2ReaNZCh18zqv8hGuXMuC/kfYeo69kmYTjYFS4GG6X458sg05skQY
 6npxzyopF0kvh80RGslcBipU6vATrTOqrdQFOSf/tpT9xAObjoTbAMYYrLhjCfIkhon16
X-Gm-Gg: AR+sD10Xgu5Y7fIYum5Sd2f+7988lZxoRLXH/Zm3aVufaTTtAx8/9HaxR+wWuduUHWy
 5BwSpkQX3GuFfA2hCFNXq49k+wizL0FytRkqSYoKuUIFMgThh56V/HGHLmaWyOBvM4J8QYDFKnH
 czZDmJPEfJsw1SuqvmzIV/AEgDn8OWz0u7dFN4AbviZl+Fx5ZIhdm2MOb5C5gByknofG0O9auhX
 ZQ5RGT6/TcGLryHeOfdYF6xGW0wbidmDCmkDbOA7L+PkAEG+uLOFGVjJb4qDKzZ9VHcxyqBBtH0
 /7Q9bSdaYtL84twFWd+QJcrzZCpdxZduqdsIdfIf9Cq7/TbrnjteO3Lp0XSJuo/NLejrdcNvCre
 zDN/aiOE1cijSsaY56VCRIzpaO2T4JIBGQr3G6Kj+ZjBUx72wo9+dyZkrAlk64zL9QDp2A9cMc/
 WMCqEN33lcRTfjuHpSg9DHTAc1xeCLDg+1LjD9Zj/ZNQDUkKIyFn6GLY+voPRHcc5OwaQSu8kOs
 djJETWqY9EtVV65YG2oaPw73N/1zSOmhaUZIfomAaegMXywjEYegTQrSoAeuW84pGNOkf5d2+im
 irK4i2tFabwbhqoLXGhUAPVQN/oMXO6tHWHo9M1x4T1hGNv7clfcwG89vXzBmD4=
X-Received: by 2002:a7b:c013:0:b0:499:51b8:d649 with SMTP id
 5b1f17b1804b1-49987941a3fmr8027715e9.3.1786651658563; 
 Thu, 13 Aug 2026 13:07:38 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981b0f4afsm104579475e9.5.2026.08.13.13.07.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 13:07:38 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 13 Aug 2026 20:07:36 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I16187153e5b107eb08ccb7c9c9ed4acd6377af0c
X-Gerrit-Change-Number: 1766
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1766?usp=email>
X-Gerrit-Commit: abf505b43e81379893327db19314920f5271556e
X-Gerrit-Comment-Date: Thu, 13 Aug 2026 20:07:36 +0000
In-Reply-To: <gerrit.1782992478000.I16187153e5b107eb08ccb7c9c9ed4acd6377af0c@gerrit.openvpn.net>
References: <gerrit.1782992478000.I16187153e5b107eb08ccb7c9c9ed4acd6377af0c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyOTkyNDc4MDAwLkkxNjE4NzE1M2U1YjEwN2ViMDhjY2I3YzljOWVkNGFjZDYzNzdhZjBjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cca7616832769b88eb8cbe4910e64069674c5f0e-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wubiO-0005AQ-RU
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4015880458251134686=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4015880458251134686==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UVlzWOpjUE0="; charset=UTF-8

--UVlzWOpjUE0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

razvanc has posted comm=
ents on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1766?usp=3Demail )

Change subject: Backport stricter check for valid =
tokens
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 1:

(6 comments)

Patchset:

PS1: 
Found a few minor doc / comments =
mishaps=2E


Commit Message:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/176=
6/comment/4ca12898_8d5a5656?usp=3Demail :
PS1, Line 10: adds a few unit tes=
ts=2E
I don't see any actual unit tests in the code=2E


File src/openvpn/a=
uth_token=2Eh:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1766/comment/1522=
94e2_edfeeab8?usp=3Demail :
PS1, Line 120:  * This function will always rea=
d as many bytes as SESSION_ID_PREFIX is longer
"if longer"?


http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1766/comment/5671ea79_2e7d4fa5?usp=3Demail :
P=
S1, Line 122:  * calling with struct user_pass)
I am not sure this comment =
continues to be accurate after the change introduced by this patch, since t=
he new implementation now does `strlen(password)`=2E


File src/openvpn/aut=
h_token=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1766/comment/4c1daf=
45_5720bb19?usp=3Demail :
PS1, Line 27: static_assert(AUTH_TOKEN_SESSION_ID=
_LEN % 3 =3D=3D 0, "AUTH_TOKEN_SESSION_ID_LEN needs to be multiple a 3");
T=
ypo ("multiple a 3")=2E


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1766/co=
mment/5e77a2ff_dcc86f93?usp=3Demail :
PS1, Line 39: static_assert(TOKEN_DAT=
A_LEN % 3 =3D=3D 0, "TOKEN_DATA_BASE64_LEN is not a multiple of 3");
The `s=
tatic_assert()` tests `TOKEN_DATA_LEN`, but the message says `TOKEN_DATA_BA=
SE64_LEN`=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1766?usp=3Demail
To unsubscribe, or for help writing mail filters, visit =
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: com=
ment
Gerrit-Project: openvpn
Gerrit-Branch: release/2=2E5
Gerrit-Change-Id:=
 I16187153e5b107eb08ccb7c9c9ed4acd6377af0c
Gerrit-Change-Number: 1766
Gerri=
t-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-C=
C: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: razva=
nc <razvanc@mailbox=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-Comment-Date: Thu, 13 Aug 2026 20:07:36 +0000
Gerrit-HasCom=
ments: Yes
Gerrit-Has-Labels: No

--UVlzWOpjUE0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1766?usp=3Demail">View Change</a></p><p>6 comments:</p=
><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddin=
g: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li styl=
e=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1766?tab=3Dcomments&amp;us=
p=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" style=3D"white-space: =
pre-wrap; word-wrap: break-word;">Found a few minor doc / comments mishaps=
=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>Commit Messag=
e:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; p=
adding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1766/comment/4ca12898_8d5a5656?usp=3Demail"=
>Patch Set #1, Line 10:</a> <code style=3D"font-family:monospace,monospace"=
>adds a few unit tests=2E</code></p><p class=3D"blocks" style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">I don&#39;t see any actual unit tests =
in the code=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>Fi=
le src/openvpn/auth_token=2Eh:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom:=
 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1766/comment/15=
2294e2_edfeeab8?usp=3Demail">Patch Set #1, Line 120:</a> <code style=3D"fon=
t-family:monospace,monospace"> * This function will always read as many byt=
es as SESSION_ID_PREFIX is longer</code></p><p class=3D"blocks" style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">&quot;if longer&quot;?</p></li=
><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4=
px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1766/comment/5671=
ea79_2e7d4fa5?usp=3Demail">Patch Set #1, Line 122:</a> <code style=3D"font-=
family:monospace,monospace"> * calling with struct user_pass)</code></p><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I =
am not sure this comment continues to be accurate after the change introduc=
ed by this patch, since the new implementation now does `strlen(password)`=
=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/open=
vpn/auth_token=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li styl=
e=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1766/comment/4c1daf45_5720=
bb19?usp=3Demail">Patch Set #1, Line 27:</a> <code style=3D"font-family:mon=
ospace,monospace">static_assert(AUTH_TOKEN_SESSION_ID_LEN % 3 =3D=3D 0, &qu=
ot;AUTH_TOKEN_SESSION_ID_LEN needs to be multiple a 3&quot;);</code></p><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Ty=
po (&quot;multiple a 3&quot;)=2E</p></li><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1766/comment/5e77a2ff_dcc86f93?usp=3Demail">Patch Se=
t #1, Line 39:</a> <code style=3D"font-family:monospace,monospace">static_a=
ssert(TOKEN_DATA_LEN % 3 =3D=3D 0, &quot;TOKEN_DATA_BASE64_LEN is not a mul=
tiple of 3&quot;);</code></p><p class=3D"blocks" style=3D"white-space: pre-=
wrap; word-wrap: break-word;">The `static_assert()` tests `TOKEN_DATA_LEN`,=
 but the message says `TOKEN_DATA_BASE64_LEN`=2E</p></li></ul></li></ul><p>=
To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1766?us=
p=3Demail">change 1766</a>=2E To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1766?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/><=
/div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div=
>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D=
"display:none"> Gerrit-Branch: release/2=2E5 </div>
<div style=3D"display:n=
one"> Gerrit-Change-Id: I16187153e5b107eb08ccb7c9c9ed4acd6377af0c </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Number: 1766 </div>
<div style=3D"=
display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerri=
t-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefor=
ge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: razvanc &lt;raz=
vanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention=
: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-Comment-Date: Thu, 13 Aug 2026 20:07:36 +0000 </div>
<div st=
yle=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:=
none"> Gerrit-Has-Labels: No </div>

</body></html>
--UVlzWOpjUE0=--


--===============4015880458251134686==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4015880458251134686==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4015880458251134686==--

