Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0833DC5DF81
	for <openvpn-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qeHNIYg5hkmKvJ3Vc52zN1CERHrwFZ565vqETKQx0gY=; b=lvP90stXww9AUVMd0TUvSlk9b2
	3RMgKhfKtxyNDwowoDGcY3YBJxu9OlNemyjDgdza1sn1Iu/B6Cf0/GzdsKrUetjbmVO3xwg9Nkmgt
	A/L07afydFV0iNQ1mekdKI0preUI7zBUjco49cDP/VSlTFPX+e/yTQQ4aaYz04Opw2e0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyWFh-0001VL-4l;
	Mon, 24 Aug 2026 15:06:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wyWFf-0001VE-T3
 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 15:06:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Q0+ghoCOJWcWSZL3xjg2ekfBYZEIcpcwOIEHabpoy6c=; b=a26ddmbwbwTCO5fWUo+F2vMf18
 d5fCaCFPu3xxLi9e+QMidLsAuPUjHAL9/cM0/9W65h0Q7dhfYmsy1Ml1+jZGgMSzjJQ5dUS6OmsUH
 eqkchju4WgBbqjj1j9qtKK5hLqHLGnP0HwH/AhGgt0keKK9wxlNu9sxjkdYbg4D8NnZk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Q0+ghoCOJWcWSZL3xjg2ekfBYZEIcpcwOIEHabpoy6c=; b=i
 RDN1OwDfM6Sy6y6G4+V3Vo+xVbfJPo/ylfbBnamnf12jOAfFwTsQnVCXLCewRlxQL+g3DQkNuzmLS
 gy6sP8aRioTtxlwGSMc4stz+lOnegQX9CDpgSRWaPGByIIRd4Y0hBpgV1FiVQjBu4K9fO8f/ILLpo
 TETwc/u7QbxyPO3c=;
Received: from mail-ed1-f42.google.com ([209.85.208.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyWFd-0004BK-9z for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 15:06:19 +0000
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-6a0a4aa99bdso6127915a12.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 08:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787583971; x=1788188771; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Q0+ghoCOJWcWSZL3xjg2ekfBYZEIcpcwOIEHabpoy6c=;
 b=PJGSg0H+QV4J5DBsfaX/eX2/vahAnUYPJktuntzZVjt+6UiQjwpWgnAqJGBo7sKvIM
 DT6GaI4olBS1FgwSdGMIIpyhApPymaQmSmCO1S7RJ5y6oOww5rWgE+LL3FwmPMxXDgso
 qPD6ii+d/vWSrH0IG3JrV6mNCNSI5ER5VNlbndiRvnOm3/Kc0wn6xBWArZpSBgQqIwPU
 LU6lyzmZSKUNOU4Otv3Xw5fdrh3LlMCpjS8K5BQfEK4vjfuCFiQPmH8M3JoOmB+wPcb1
 +WOVGjH9+D5Iacc7W3RodOG5XLlYXQ1dgw3O1PPG5yb1GcWc3XkIuGsh5CaDd/PXbLcw
 g0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787583971; x=1788188771;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Q0+ghoCOJWcWSZL3xjg2ekfBYZEIcpcwOIEHabpoy6c=;
 b=PjJtFnu5k0zlmnrp20TjwciVBii2LL0/XSzsy9VhkiPWa1P1rC/DbwhQeEb0y9B4sW
 Ct6dYAgZIHESyEq9iW5bk4EkU5DwzBJwCBz6WpbtCuf4qKQMTiGdpnwz7jV9ooGHMpLY
 jFFGqhwKULFYwS+HCbzUJZy29YKsIAkQWLiJt4M3ctYnNMGB+V6EFyuZAl6SyQKM9j1T
 DKR93xjFJ1Dk74LvJk2MnnUxEw+vql2ZB4SWVwKC+ul+3PEGV6S4OXXVNa4Y1pT+6mpC
 1qFRVP/Kiw8vUDVLKBuvj8mMimMRlz3YD9kRUmaYbrp9sfl/NIUGKX93gxMAa7QQCLu/
 TdRw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq7TcxKPb3YlLtX1NRaaJt3wITy2fNumpuupgNaDKJK7aznsCmM1BQihcFaFtdFRrImczOd5IHQQ2bmS9GD@lists.sourceforge.net
X-Gm-Message-State: AFuF++mjTH9r658BjFYOwUo6gN9XrwAU2+cCoQqViPeJtGT4bGwZEMI9
 b46He0Mri3FYvueMuFgFzsofL7PZo36O7yhK8TSlMr4Cfsg7YtHci5WFhxmNh20I+eXoZwRQtdL
 TExakT0fMEvgem/VaMa7+g59Wbsj1q6UkcFVf4aJGczigVjeaJkf3ssgfgdv7sXAP6V8T
X-Gm-Gg: AR+sD11RSexzJKUlvPXx++GpjT9zhJhz6JaZ8pWQhaKl2P/oOb18ulzdiqB/f4TfK2k
 xi3JXi/ZN+01/F1hsnSFXiQU3oZJEn19AqiiqEMdIOnRMiI5UDlfpeWIdGJUdROGf9Jt5O18XeA
 ZC1PAhIELuz7c74/YGCzjWElcJXv2f/EPjik7I9LZqhfBFaxOqb8B1FA6s0/0D6ucyUL69pNGG2
 tklt3uzYOdYgbFJlqg4Zj/P35slHec5ase3WkxgebIeLLiIj9uLDgyrpHXp0tfMJ5Av4WEcTjV7
 PBZV/OauZDUqXyE2/pTRRn51EGIyer5n8NGyFewMvBzeDj1F/65GA5MefvNxdRQpRXhDDwL1L2/
 6pHj9eEN8vq6sqAK9NujUiaOoAK0c4IbhteFwsxYxXBknmFjAJNEUs87+BTVSBEQx4xzAGo6Ek0
 Oul/Ej4tBbkYi+bewOO4MvvhKcE8pmTwTh2Y+wG2ZrM4Z3M/5tUHHw9sSeHijCKX+AgQlXYFEYq
 QBY1lK0M04qnXFNQYMWeHXEAOyw3luaIgqYAJCLtQYSzgUQOUuwPWofM3+Qj7fkhjaDqN9Q5Phx
 fQEsgoK4nVP7GJ7+X5UAd8B2rRrhU/WHQH9IYL03kMQqUG5Ci0c=
X-Received: by 2002:a05:6402:1f4f:b0:6a4:b50:f8f2 with SMTP id
 4fb4d7f45d1cf-6a582b8fc84mr23825197a12.16.1787583970453; 
 Mon, 24 Aug 2026 08:06:10 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e012f84sm13385461a12.8.2026.08.24.08.06.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:06:10 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 24 Aug 2026 15:06:08 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I79b2dc4a550b1c5068a45407976b0dfc2f765b33
X-Gerrit-Change-Number: 1592
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1592?usp=email>
X-Gerrit-Commit: f56747651fa06686bce6339595aa241adc83e990
X-Gerrit-Comment-Date: Mon, 24 Aug 2026 15:06:08 +0000
In-Reply-To: <gerrit.1774451380000.I79b2dc4a550b1c5068a45407976b0dfc2f765b33@gerrit.openvpn.net>
References: <gerrit.1774451380000.I79b2dc4a550b1c5068a45407976b0dfc2f765b33@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc0NDUxMzgwMDAwLkk3OWIyZGM0YTU1MGIxYzUwNjhhNDU0MDc5NzZiMGRmYzJmNzY1YjMzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c06e53157275078e29340510a0ae0e5b6ee9d4ed-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wyWFd-0004BK-9z
Subject: [Openvpn-devel] [M] Change in openvpn[master]: configure: Add
 --enable-code-coverage
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8059781946978882486=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8059781946978882486==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fEtVpAONMEY="; charset=UTF-8

--fEtVpAONMEY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

flichtenheld h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1592?usp=3Demail )

Change subject: configure: Add --=
enable-code-coverage
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 5:

(3 comments)

File =2Egitignore:

http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1592/comment/4eee09ac_cb606273?usp=3Demail :
PS4, L=
ine 4: *=2Egcno
> Should we also include `*=2Egcov`, `*-coverage=2E [=E2=80=
=A6]
Why *=2Egcov? We do not seem to generate any such files?


File config=
ure=2Eac:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1592/comment/ea5961ef_=
07c90e9d?usp=3Demail :
PS4, Line 1243:    [CFLAGS=3D"`echo $CFLAGS | $SED -=
e 's/-O[s0-9]\\?//g'`"]
> This actually only matches numerical optimization=
 levels (like `O3`, etc=2E [=E2=80=A6]
Done


File src/openvpn/Makefile=2Ea=
m:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1592/comment/a6d383dd_1342d5d=
0?usp=3Demail :
PS4, Line 38: AM_LIBS =3D $(CODE_COVERAGE_LIBS)
> Is `AM_LI=
BS` a thing? I can't find it in the Automake docs and it doesn't seem to be=
 referenced anyw [=E2=80=A6]
Hmm, I assume I meant AM_LDFLAGS=2E
It doesn't=
 really matter since we include AM_CFLAGS in LINK as well, but will fix=2E
=



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1592?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I79b2dc4a550b1c5068=
a45407976b0dfc2f765b33
Gerrit-Change-Number: 1592
Gerrit-PatchSet: 5
Gerrit=
-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit=
-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: razvan=
c <razvanc@mailbox=2Eorg>
Gerrit-Comment-Date: Mon, 24 Aug 2026 15:06:08 +0=
000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: razv=
anc <razvanc@mailbox=2Eorg>

--fEtVpAONMEY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1592?usp=3Demail">View Change</a></p><p>3 com=
ments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0;"><p>File =2Egitignore:</p><ul style=3D"list-style: none; pad=
ding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1592/com=
ment/4eee09ac_cb606273?usp=3Demail">Patch Set #4, Line 4:</a> <code style=
=3D"font-family:monospace,monospace">*=2Egcno</code></p><p><blockquote styl=
e=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Should =
we also include `*=2Egcov`, `*-coverage=2E [=E2=80=A6]</blockquote></p><p c=
lass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Why=
 *=2Egcov? We do not seem to generate any such files?</p></li></ul></li><li=
 style=3D"margin: 0; padding: 0;"><p>File configure=2Eac:</p><ul style=3D"l=
ist-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1592/comment/ea5961ef_07c90e9d?usp=3Demail">Patch Set #4, Line =
1243:</a> <code style=3D"font-family:monospace,monospace">   [CFLAGS=3D&quo=
t;`echo $CFLAGS | $SED -e &#39;s/-O[s0-9]\\?//g&#39;`&quot;]</code></p><p><=
blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0=
 10px;">This actually only matches numerical optimization levels (like `O3`=
, etc=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"m=
argin: 0; padding: 0;"><p>File src/openvpn/Makefile=2Eam:</p><ul style=3D"l=
ist-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1592/comment/a6d383dd_1342d5d0?usp=3Demail">Patch Set #4, Line =
38:</a> <code style=3D"font-family:monospace,monospace">AM_LIBS =3D $(CODE_=
COVERAGE_LIBS)</code></p><p><blockquote style=3D"border-left: 1px solid #aa=
a; margin: 10px 0; padding: 0 10px;">Is `AM_LIBS` a thing? I can&#39;t find=
 it in the Automake docs and it doesn&#39;t seem to be referenced anyw [=E2=
=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Hmm, I assume I meant AM_LDFLAGS=2E<br>It doesn&#3=
9;t really matter since we include AM_CFLAGS in LINK as well, but will fix=
=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1592?usp=3Demail">change 1592</a>=2E To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1592?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ger=
rit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project=
: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
=
<div style=3D"display:none"> Gerrit-Change-Id: I79b2dc4a550b1c5068a45407976=
b0dfc2f765b33 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 159=
2 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=
=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Comment-Date: Mon, 24 Aug 2026 15:06:08 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Re=
ply-To: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--fEtVpAONMEY=--


--===============8059781946978882486==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8059781946978882486==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8059781946978882486==--

