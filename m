Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 251CCC55184
	for <openvpn-devel@archiver.kernel.org>; Mon,  3 Aug 2026 11:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wH39s8vTrHXls2ES0c9xEpij37mVk1z8dYNnpAyk6C8=; b=KSUHc4LyyvdSK1wcB7by9rb4Xh
	LA85sWcK0uR4n3W0Weuo9i2UuQAljZtLYNJ/8+uDU33nkx9dQMBeiqesScrrzYV7wpt6UyVoUU3B9
	SjqVZ9hEr4eu3Lv44lfibDIp7VSQLtHweTayMXoHrsf2HuY0FzsTyVS/5l9VMF3fgsP0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wqqf7-0001ea-JR;
	Mon, 03 Aug 2026 11:16:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wqqew-0001eM-Cj
 for openvpn-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 11:16:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=xAyWQ/HiWHzZjSf3M2QF6Um39vQGg6dWe49QGDmwYfo=; b=WiIHmTJd72XjqmGM4oCjohU5+j
 u85DQqbIUHPlpkgBaCK7I9A4u8iG2DEjcZ91HQzS1zq/lDZ7jffk3eOwa6BAkAD9z+oOHhAz4mmWi
 Ne9r+azqGKU4TQUQJNSa54ncie5dJ/yL1LwV3tydCXJGms0xZDgHdxLvZ5vazrpJ6uSo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=xAyWQ/HiWHzZjSf3M2QF6Um39vQGg6dWe49QGDmwYfo=; b=X
 kgIYoUmVXFlkpHrSSuC+wNZmQizOIOs+YsWBzWZPlzweEhBFMG2c9evUAmtmPHn6MpAHCrofjGcD/
 MfR7eJkTQ+3/32D9rHW6FWxPkNzrJ3ePgO6/GXlA4klRrfJTY+5LijgPeN0kSeMlhdQ8grWXRdVfA
 htX54xz9pe9ezBwY=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wqqes-0007jX-L1 for openvpn-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 11:16:36 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-47f64ca1c2dso916438f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 03 Aug 2026 04:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785755788; x=1786360588; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xAyWQ/HiWHzZjSf3M2QF6Um39vQGg6dWe49QGDmwYfo=;
 b=YETc76XaMXX99xHhj/53TbX51lhgasnfXLY3dnBoBf+rA51Rk03/Lg21T93EtHpR8L
 HEmy2t3QHQ68RSMPpqdUjRlMq3XwuCfXjKxCRBiR4lXo7dl1D4Mhsp8EG+x28+O+pMXE
 4qZcStCzlyLYMAFTk5RUhG4In0XjUiOe2YJTNwGI/8gbsdrxXGVY8VcNFKaPsViZzGMW
 7E6RWr9r5aejP8b/yIyCnfCdVBChhgxKmtOPD3KrCfL5aYGSkRMINs3hbdSJfI2+bDai
 xH82czcjcVz6oz33XKsMZiAQ6SqBUdBYCJZPKsaVOxzE7K/sMx0QG95BfCxJ3Bso3GAw
 EVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785755788; x=1786360588;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xAyWQ/HiWHzZjSf3M2QF6Um39vQGg6dWe49QGDmwYfo=;
 b=UWXNO5S7G1npJ2h2t0fbPPoZ652ZdT4XtRBIpLkbmgCs3Xw4OrE2pDMZ4EOKzA7o1x
 KuE6PP4AMbsOU3Pe99PALO/0r1No5CnmLSJZrk2CBarjQwfU25qAmgn/yK+yyl42Qofk
 s4Y1dftTmykmkp3ORycjhkP+1apOK3zWuh5wiQwIxg4nH86df8OxSJx5FgyZqVkZHs9w
 FC0h8AFW9f2iBXC2EzK4Z2j4mBygimEvRkXVmgalIwAlBDvw0/lVaTcLQG/qqtgKrNal
 tlwEp3KRbxlHcBMyHNT3quK8EqB6LWFtKnDzaaBBFFDmcGtDs57aYbt3CUnoxMc+P7R2
 yxdQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrhlbRuNryoKhBy/jEvbsTQqr+0UimmGrxp4W24QLluI97o+6KOEMSI7HMWhSeYGoFsO0M2Wzk0gVLknGFP@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yx8xhwcZk0/G0Ehl/v2GJxChhzOTI4diU54wGW9tZBsfCcVQgyB
 +ab1bN7svsPiBuhfnI5xovo6ii7+lLzMvkrxMktq+RujsifMWd4EKXFpWwpuIoCE8sXDzYLCfq/
 +AKlLdyuXOX5tgTMRG4qu7/lYd2yugoeZiHkwhHlBzxfYwh/sL5X77TaBm3+vZ+x9tP6l
X-Gm-Gg: AR+sD11TbOeUVlJRxtdOvhQ41fqu6F9z/gsZRRfYH2F0FaDHVZf2UuRsrhtN/aep43o
 bKu0z8N/5lKqvdBxS27oC0YMfgaIm5eUNOkn4p7Fwkxw0h5xxlz8HKr9XpwG13NQ03g1ts+73gj
 yd13zSVJpduiUx2Z79o+KpVsP8MZq8Qq8/FhSPkJjJZlDQ3sGeTjZlGQqikOy6TDr8XT+6+/M39
 6WWfBX78MwSVnIWrR2mWOWcz7BXMrWMhS2p3qrIOySIY+DV0vGOZVnZl0i+EooT3BDQW196OJgo
 74ggNjDAa175lvriU8iHVYK28lPLYUBVCxF2/IOiXRoJaca3Yjqf034UEaEh64vtM0b1hEmzmd+
 HK+mukTXzMefxwoTGepQusFm5OD7tpDZ/QazWbHSmEkbhNcCPZoVukTJXlakLfZFBJrw5bevsCk
 u9/eY6zmaCqDfsbUiAJOPPQzbxzQwciVPo/8z370OO1VDL/KgemoBKG2FcKhr2tvPTMK7OWd1PK
 rhcRDUsil+uh+zzhj0fTdRCN05hhDYURcRrM1xSLqcJEoZrUhGr7i9SPIGm+XIA4kaxvaTmCero
 69MlazFpnpktfCgsFh/C0MUrpcC2vxT7b1hfLiVNWHhscK43OfwCzux3XroE6w==
X-Received: by 2002:a05:6000:481c:b0:47f:8ac0:ccd3 with SMTP id
 ffacd0b85a97d-47fd9fa5e61mr22081489f8f.2.1785755788288; 
 Mon, 03 Aug 2026 04:16:28 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd456a5a4sm32516103f8f.20.2026.08.03.04.16.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 04:16:27 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 3 Aug 2026 11:16:25 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I96b5ea3542df77b1be17079874fb9e4970b539ed
X-Gerrit-Change-Number: 1830
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1830?usp=email>
X-Gerrit-Commit: 86bac756964e392febc55fb025cba9a203b8befa
X-Gerrit-Comment-Date: Mon, 3 Aug 2026 11:16:25 +0000
In-Reply-To: <gerrit.1785312487000.I96b5ea3542df77b1be17079874fb9e4970b539ed@gerrit.openvpn.net>
References: <gerrit.1785312487000.I96b5ea3542df77b1be17079874fb9e4970b539ed@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MzEyNDg3MDAwLkk5NmI1ZWEzNTQyZGY3N2IxYmUxNzA3OTg3NGZiOWU0OTcwYjUzOWVkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4b9805147066f5cdb9fcbd3b28038ff9439f43e7-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wqqes-0007jX-L1
Subject: [Openvpn-devel] [S] Change in openvpn[master]: SIGHUP-restart
 instance on UDP write error EADDRNOTAVAIL
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5083984232857511787=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5083984232857511787==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oGFzOU/VS9M="; charset=UTF-8

--oGFzOU/VS9M=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex, plaisthos=2E

cron2 has posted=
 comments on this change by cron2=2E ( http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1830?usp=3Demail )

Change subject: SIGHUP-restart instance on UDP wr=
ite error EADDRNOTAVAIL
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 2:

(6 comments)

Patchset:

PS2: 
> !!!
Done


Commi=
t Message:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1830/comment/e511e034=
_10a29e06?usp=3Demail :
PS2, Line 17: not - so we can notice, and restart t=
he instance=2E  A full SIGHUP restart
> I think SIGHUP is a bit too much he=
re since it reloads the config and other things=2E [=E2=80=A6]
SIGUSR1 does=
 not work (at least not if there is a `--persist-tun` in the config, need t=
o re-test `SIGUSR1 without persist-tun`), as we have no signalling for "rem=
ove all routes, but keep tun, reconnect"=2E

I need to look more closely at=
 logs, it seems, as I thought `--ping-restart` would trigger `SIGHUP`, but =
the documentation tells me otherwise=2E  Wait for v3=2E=2E=2E


File src/op=
envpn/forward=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1830/comment/=
f2b2751a_e3b2d8b0?usp=3Demail :
PS2, Line 1865:         if (size < 0 && err=
no =3D=3D EADDRNOTAVAIL)
> Here you should be checking for `error_code`, no=
t `errno`=2E [=E2=80=A6]
good catch=2E  Will adjust=2E

No idea what window=
s does, but it's not really relevant - this fixes one particular situation =
on one particular platform, while not making things worse for other platfor=
ms (if *that* error comes back, our socket is no longer fit for the purpose=
)=2E


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1830/comment/6ec1208a_91cf=
9db6?usp=3Demail :
PS2, Line 1868:             register_signal(c->sig, SIGH=
UP, "link-changed");
> using SIGHUP this way makes `--config stdin` + `--re=
map-usr1 SIGHUP` a fatal usage error: SIGHUP re- [=E2=80=A6]
I can't follow=
 you=2E  I am not raising SIGUSR1, so why should `remap-usr1` be relevant h=
ere?


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1830/comment/9ca7aeec_dcbc=
3856?usp=3Demail :
PS2, Line 1868:             register_signal(c->sig, SIGH=
UP, "link-changed");
> There is no guard preventing this check to fire on a=
 server=2E=2E=2E=2E [=E2=80=A6]
I'm not sure this can be triggered in a mea=
ningful way on a server - there are no redirect routes for client IPs that =
might stop working on an interface change=2E  It might be triggerable if `-=
-bind` is in use and someone configures away the bound IP address - in whic=
h case, we'll just fail either way=2E  But I can add a guard here=2E


http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1830/comment/8e8a2c47_c038c444?usp=3D=
email :
PS2, Line 1868:             register_signal(c->sig, SIGHUP, "link-c=
hanged");
> have you checked how this SIGHUP interacts with `--connect-retr=
y-max` ? SIGHUP makes openvpn re-read [=E2=80=A6]
In this case, we would do=
 a `SIGHUP` reconnect anyway, just "after `--ping-restart` expires"=2E  No?=
  So nothing changes,



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1830?usp=3Demail
To unsubscribe, or for help writing mail filter=
s, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: I96b5ea3542df77b1be17079874fb9e4970b539ed
Gerrit-Change-Number: 1830
Ger=
rit-PatchSet: 2
Gerrit-Owner: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Review=
er: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-At=
tention: ordex <antonio@mandelbit=2Ecom>
Gerrit-Comment-Date: Mon, 03 Aug 2=
026 11:16:25 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In=
-Reply-To: plaisthos <arne-openvpn@rfc2549=2Eorg>
Comment-In-Reply-To: orde=
x <antonio@mandelbit=2Ecom>

--oGFzOU/VS9M=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex, plaisthos=2E </p>
<p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1830?usp=3Demail">View Change</a></p><p>6 comm=
ents:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4p=
x;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1830?tab=3Dcomment=
s&amp;usp=3Demail">Patch Set #2:</a> </p><p><blockquote style=3D"border-lef=
t: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">!!!</blockquote></p><p=
 class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">D=
one</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>Commit Messag=
e:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; p=
adding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1830/comment/e511e034_10a29e06?usp=3Demail"=
>Patch Set #2, Line 17:</a> <code style=3D"font-family:monospace,monospace"=
>not - so we can notice, and restart the instance=2E  A full SIGHUP restart=
</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10p=
x 0; padding: 0 10px;">I think SIGHUP is a bit too much here since it reloa=
ds the config and other things=2E [=E2=80=A6]</blockquote></p><p class=3D"b=
locks" style=3D"white-space: pre-wrap; word-wrap: break-word;">SIGUSR1 does=
 not work (at least not if there is a `--persist-tun` in the config, need t=
o re-test `SIGUSR1 without persist-tun`), as we have no signalling for &quo=
t;remove all routes, but keep tun, reconnect&quot;=2E</p><p class=3D"blocks=
" style=3D"white-space: pre-wrap; word-wrap: break-word;">I need to look mo=
re closely at logs, it seems, as I thought `--ping-restart` would trigger `=
SIGHUP`, but the documentation tells me otherwise=2E  Wait for v3=2E=2E=2E<=
/p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/=
forward=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"ma=
rgin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1830/comment/f2b2751a_e3b2d8b0?us=
p=3Demail">Patch Set #2, Line 1865:</a> <code style=3D"font-family:monospac=
e,monospace">        if (size &lt; 0 &amp;&amp; errno =3D=3D EADDRNOTAVAIL)=
</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10p=
x 0; padding: 0 10px;">Here you should be checking for `error_code`, not `e=
rrno`=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">good catch=2E  Will adjust=2E</p><p c=
lass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">No =
idea what windows does, but it&#39;s not really relevant - this fixes one p=
articular situation on one particular platform, while not making things wor=
se for other platforms (if *that* error comes back, our socket is no longer=
 fit for the purpose)=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16p=
x;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1830/comment/6ec1208a_91cf9db6?usp=3Demail">Patch Set #2, Li=
ne 1868:</a> <code style=3D"font-family:monospace,monospace">            re=
gister_signal(c-&gt;sig, SIGHUP, &quot;link-changed&quot;);</code></p><p><b=
lockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 =
10px;">using SIGHUP this way makes `--config stdin` + `--remap-usr1 SIGHUP`=
 a fatal usage error: SIGHUP re- [=E2=80=A6]</blockquote></p><p class=3D"bl=
ocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I can&#39;t f=
ollow you=2E  I am not raising SIGUSR1, so why should `remap-usr1` be relev=
ant here?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1830/comment/9ca7aeec_dcbc3856?usp=3Demail">Patch Set #2, Line 1868:</a> <c=
ode style=3D"font-family:monospace,monospace">            register_signal(c=
-&gt;sig, SIGHUP, &quot;link-changed&quot;);</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">There is=
 no guard preventing this check to fire on a server=2E=2E=2E=2E [=E2=80=A6]=
</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-w=
rap: break-word;">I&#39;m not sure this can be triggered in a meaningful wa=
y on a server - there are no redirect routes for client IPs that might stop=
 working on an interface change=2E  It might be triggerable if `--bind` is =
in use and someone configures away the bound IP address - in which case, we=
&#39;ll just fail either way=2E  But I can add a guard here=2E</p></li><li =
style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;">=
<a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1830/comment/8e8a2c47_=
c038c444?usp=3Demail">Patch Set #2, Line 1868:</a> <code style=3D"font-fami=
ly:monospace,monospace">            register_signal(c-&gt;sig, SIGHUP, &quo=
t;link-changed&quot;);</code></p><p><blockquote style=3D"border-left: 1px s=
olid #aaa; margin: 10px 0; padding: 0 10px;">have you checked how this SIGH=
UP interacts with `--connect-retry-max` ? SIGHUP makes openvpn re-read [=E2=
=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">In this case, we would do a `SIGHUP` reconnect any=
way, just &quot;after `--ping-restart` expires&quot;=2E  No?  So nothing ch=
anges,</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1830?usp=3Demail">change 1830</a>=2E To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1830?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I96b5ea3542df77b1be170=
79874fb9e4970b539ed </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1830 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div =
style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@greenie=2Emuc=2Ede&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@man=
delbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plais=
thos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention=
: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Comment-Date: Mon, 03 Aug 2026 11:16:25 +0000 </div>
<div style=3D"=
display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> =
Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-=
To: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Comment-In-Reply-To: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>=


</body></html>
--oGFzOU/VS9M=--


--===============5083984232857511787==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5083984232857511787==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5083984232857511787==--

