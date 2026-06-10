Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF3F4CD8CB9
	for <openvpn-devel@archiver.kernel.org>; Wed, 10 Jun 2026 11:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F6kzahWkjngHuH2KoSV3a0MbII9UNhvDX4dSt+lutk8=; b=GAZJGzSNLhOsKcaQzZ/Hx0WHit
	fOZoRXGmtnViYNgq9Y8Mi7ONIjq2YEdVj8no5HZTSQgt0KkvWdzUDscO+lbbIjigGRgrICH02gbJT
	vp/+aRqZee7Qxg1Jj2kLjv0W/JjwWRpNi6MODnhf09Uw4zTjfw+vy4mP6rrAt8YgXvWY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wXHDx-00064L-8V;
	Wed, 10 Jun 2026 11:35:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wXHDw-00064E-0e
 for openvpn-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 11:35:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=U8BTAqGVjnajytKZfQbJnN8wHF3sLK+mOgEpSOt/Hng=; b=Onbdpcyn7z/HQ14hWMxfn4IOXu
 tmgzN3djJomqS34AyKjgjNcCiM0Yeo8N9sclTOSm8ZKqrkiAG+Hq+5Z1IvssJeBSou9jWfU0HBKq2
 TiE+OCzqjRRzsWW+jpUpT1z5VC7azt30HNfediGpnsoRQMqdsNFLFG442Ge5p2jDubYQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=U8BTAqGVjnajytKZfQbJnN8wHF3sLK+mOgEpSOt/Hng=; b=N
 aHxf2dGk6YGEb25IXV8Ly/gJ8g9cVHD4ro3t7ssdm1N4vbYM/KEDrv+/zJy+xithrby+g84Mchl4o
 X6e1UanUbkDofHy8EGWcaYK2n1Pg5+/lgTSElhxvnhN+J3yKlh/DMuNVpE5nXx1lBbLnyXGB9KDYw
 DDu7otX5OOVoLfXE=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wXHDs-0000jR-S7 for openvpn-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 11:35:55 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-490a76757e5so43696765e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 10 Jun 2026 04:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781091342; x=1781696142; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U8BTAqGVjnajytKZfQbJnN8wHF3sLK+mOgEpSOt/Hng=;
 b=PcBQ02bfpjaYJAEjK776meDAPAKLD6STKFJdxkURH0TrP+wo/ugN205elU4SmR9ehV
 8s11Dr7FYSqQAJrLbboPNJ7kRBXSn974VghOolT7TzisAzTAELv3Tp6egOG4zcJwkbGP
 coonP+//TdFfFFuf3LvkQPzl10zwKqnI0Gs4PnvUHXMc42LhJWwyulB0rJcjiwK0trVR
 n59X9Hc53OuS46z2GveSHzZxJnYjRqo4H1hynETXLoxGlag0rTREo81zzTkYTUtS0Vkt
 Il3yFgkqbFpNnQ4RsQ5a9W8/ctVh3aVHARCUWgJul8GYd6+HzdqZh0pciQ4ors4FOwxk
 wjcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781091342; x=1781696142;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U8BTAqGVjnajytKZfQbJnN8wHF3sLK+mOgEpSOt/Hng=;
 b=LE7anmtlcyKYYYYk26j9ot9pgsifUuaUwKhm5loHEdggiRs8hSx/MAAykJCBNhyeDn
 Aq6tVUzNde7xIr/WRcEQDk6VQSZEtx6mNTsATf8nLG2jkhyxyz1nhge6LxwMKYEMXbQ4
 SsZ0vEXiZJOdVFeMgyJR/hDTNQq+AXO7zbr+JHzMjOWUu1C/Eh1YMv4cYCT84RKCxX/B
 tjRRN798TIwZzD4oorvLRro0tcqJH675+1RkhcU03N7amPt9xGl7h70kXApGHXa3850z
 GP8rfnzTBY77fUqUnEcxc8ZFlp2U4fDom7EzKQABnl7moueO0NAWJ1YLpDDQs2vfLuUf
 qJfQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+vyPjzEzjtZkQzeeS5JbsZ3k3F2ujea5PqRex1MlQLaIPGwd7sDAaS0L/VVa6sOBvF5M8iGERLNt4xQ3kh@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yx/nf1j09RFnTDS9O0B3c8ihi08EGgJHbnz01X0YgEFCoQvnGnu
 mJOGdKO7Q2MKZ7HI+f2V7m9ivEudHgqevgwxrPiz0Isa/3Aca98/ScJlkHLN+SFRplj+W2JKJd+
 nqRkywynvNZDlNScpzX73lJUN/zqXWmKtv6jl8dyEzKpUMQwNvK8bnnHZikezaoVrtVNe
X-Gm-Gg: Acq92OGuf1whN0zDCfYfL2h3nJAmYp46IgvcziaX2kYced7/JBB5xW8V/oV0NikNERC
 5LVpfFPuhW7zwuc6Lo5Pri75dsOf9GMkFNSgPX3SYcPXrbbueLIUohakYKbUP/ocAVIa6OsJuN6
 Z/k6g429SRiVR5sH7RbUGW7Z36qXY0mV14lF2ii5MyehPGA4C/g2NivaxxUyoksNdBXskT4SLBa
 s7uRQfivCwUfjyKkA0YZX1lwh1dqEHnsxfaU0K0NAFNbISuEFvucdcpnuhvZRzxQSgP1KbE/jD+
 plkvxSo1nzeA4bLXJ7nOHQL/het/eJjHYJM3oK/6a5tfJ3JPMVzq6hh1wpY4M2PGE7d/qsNlNSc
 fFzZs0Lh+QrsY+d5Bx+aUKT7Cgi8S0tZBMOHycMNux/qhFe7zGFte5UiS8Mj2u0a6EEIRk+klU5
 q4xT7e59IQP8jzhGqL8VH1EYBlbsFecXYnf9fTseFCeyp2gYw8c6xQJINCqpyQcAPdfLRQmg83N
 V+0Xp0GvjQspN2H4hixUpEt/jK1PJvnBYHuMj4JNDyjhN6hr2R+tEbyOchSA7XnYI2nmZxNRmwy
 FHkFGB4edMDIHm1ODEvj94My
X-Received: by 2002:a05:600c:3492:b0:490:aeae:1eea with SMTP id
 5b1f17b1804b1-490c2597362mr390323045e9.7.1781091341576; 
 Wed, 10 Jun 2026 04:35:41 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3cc0f8sm551564185e9.8.2026.06.10.04.35.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 04:35:41 -0700 (PDT)
X-Google-Original-From: "its_Giaan (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 10 Jun 2026 11:35:39 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I115a17a2c61c65f48aea41d94150f34ea31f82da
X-Gerrit-Change-Number: 1703
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1703?usp=email>
X-Gerrit-Commit: dcb3bbe0ad6d29ae420af36f86b911f284a8bf06
X-Gerrit-Comment-Date: Wed, 10 Jun 2026 11:35:39 +0000
In-Reply-To: <gerrit.1779797980000.I115a17a2c61c65f48aea41d94150f34ea31f82da@gerrit.openvpn.net>
References: <gerrit.1779797980000.I115a17a2c61c65f48aea41d94150f34ea31f82da@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5Nzk3OTgwMDAwLkkxMTVhMTdhMmM2MWM2NWY0OGFlYTQxZDk0MTUwZjM0ZWEzMWY4MmRhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8a0e8f625b03cadccc1c67bd86bc7f5e31f146a0-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wXHDs-0000jR-S7
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add support for user
 defined L3 master devices
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
From: "its_Giaan \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "its_Giaan \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1714351402483060939=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1714351402483060939==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VzHpfOXj0x0="; charset=UTF-8

--VzHpfOXj0x0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

its_Giaan=
 has posted comments on this change by its_Giaan=2E ( http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1703?usp=3Demail )

Change subject: Add support for us=
er defined L3 master devices
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 2:

(5 comments)

File doc/man-sections/vpn-net=
work-options=2Erst:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1703/comment=
/2140ddc6_b93cfce6?usp=3Demail :
PS1, Line 307: --l3mdev name
> this needs =
an explanation on how it is different to --bind-dev which seems to claim to=
 offer the sam [=E2=80=A6]
Done


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1703/comment/5a39a19c_13dc55b7?usp=3Demail :
PS1, Line 308:    Specify the=
 L3 master device (such as VRF) to which the tunnel 
> trailing whitespace
=
Done


File src/openvpn/networking_sitnl=2Ec:

http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1703/comment/6f90f26b_12ca8a84?usp=3Demail :
PS1, Line 1063: =
    int ifindex, l3mdev_index, ret =3D -1;
> there is no reason to initiali=
ze values to -1 if you do overwrite this immediately=2E [=E2=80=A6]
Done


=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1703/comment/754466b4_0c633fc3?us=
p=3Demail :
PS1, Line 1067:     ifindex =3D if_nametoindex(iface);
> just i=
nitialize the variable here=2E
Done


File src/openvpn/options=2Ec:

http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1703/comment/07015eeb_a463f171?usp=3Dem=
ail :
PS1, Line 6499:     else if (streq(p[0], "l3mdev") && p[1] && !p[2])
=
> Addition to usage string seems to be missing
Done



-- 
To view, visit h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1703?usp=3Demail
To unsubscribe, o=
r for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-=
Branch: master
Gerrit-Change-Id: I115a17a2c61c65f48aea41d94150f34ea31f82da
=
Gerrit-Change-Number: 1703
Gerrit-PatchSet: 2
Gerrit-Owner: its_Giaan <gian=
marco@mandelbit=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ec=
om>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: open=
vpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plais=
thos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lic=
htenheld=2Ecom>
Gerrit-Comment-Date: Wed, 10 Jun 2026 11:35:39 +0000
Gerrit=
-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <=
frank@lichtenheld=2Ecom>

--VzHpfOXj0x0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1703?usp=3Demail">View Change</a></p><p>=
5 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>File doc/man-sections/vpn-network-options=2Erst:</p=
><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1703/comment/2140ddc6_b93cfce6?usp=3Demail">Pa=
tch Set #1, Line 307:</a> <code style=3D"font-family:monospace,monospace">-=
-l3mdev name</code></p><p><blockquote style=3D"border-left: 1px solid #aaa;=
 margin: 10px 0; padding: 0 10px;">this needs an explanation on how it is d=
ifferent to --bind-dev which seems to claim to offer the sam [=E2=80=A6]</b=
lockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap=
: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1703/comment/5a39a19c_13dc55b7?usp=3Demail">Patch Set #1, Line 30=
8:</a> <code style=3D"font-family:monospace,monospace">   Specify the L3 ma=
ster device (such as VRF) to which the tunnel </code></p><p><blockquote sty=
le=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">traili=
ng whitespace</blockquote></p><p class=3D"blocks" style=3D"white-space: pre=
-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin: =
0; padding: 0;"><p>File src/openvpn/networking_sitnl=2Ec:</p><ul style=3D"l=
ist-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1703/comment/6f90f26b_12ca8a84?usp=3Demail">Patch Set #1, Line =
1063:</a> <code style=3D"font-family:monospace,monospace">    int ifindex, =
l3mdev_index, ret =3D -1;</code></p><p><blockquote style=3D"border-left: 1p=
x solid #aaa; margin: 10px 0; padding: 0 10px;">there is no reason to initi=
alize values to -1 if you do overwrite this immediately=2E [=E2=80=A6]</blo=
ckquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: =
break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1703/comment/754466b4_0c633fc3?usp=3Demail">Patch Set #1, Line 1067=
:</a> <code style=3D"font-family:monospace,monospace">    ifindex =3D if_na=
metoindex(iface);</code></p><p><blockquote style=3D"border-left: 1px solid =
#aaa; margin: 10px 0; padding: 0 10px;">just initialize the variable here=
=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0; padding=
: 0;"><p>File src/openvpn/options=2Ec:</p><ul style=3D"list-style: none; pa=
dding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1703/co=
mment/07015eeb_a463f171?usp=3Demail">Patch Set #1, Line 6499:</a> <code sty=
le=3D"font-family:monospace,monospace">    else if (streq(p[0], &quot;l3mde=
v&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Addition=
 to usage string seems to be missing</blockquote></p><p class=3D"blocks" st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></l=
i></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1703?usp=3Demail">change 1703</a>=2E To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1703?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I115a17a2c61c65f48aea41d94150f34ea31f82da </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1703 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none">=
 Gerrit-Owner: its_Giaan &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC=
: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichten=
held &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Comment-Date: Wed, 10 Jun 2026 11:35:39 +0000 </div>
<div style=3D"dis=
play:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Ger=
rit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To:=
 flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--VzHpfOXj0x0=--


--===============1714351402483060939==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1714351402483060939==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1714351402483060939==--

