Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB019CA5FA2
	for <openvpn-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R8uzdhquNBZGK4IY75pJMqGAmYvJ/lNX9tstLyiuE3U=; b=EvX5OwbD671/EL9mIZSQbtLZr1
	gGpTBsTubrUiksDt/d2qYN2dvRMqUkR/uS94pZV5dCDgiV34u0Xw8hpl379czFMLUQZDb+uEN9w7S
	/cRPbQGcVQYHNKWtTiAWPLvT13ic0jcrLBpwbEM1BrmuS5stTkbxX06Mm6I4KMsHqvPo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBBah-0002ga-Ky;
	Mon, 28 Sep 2026 13:40:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBBaQ-0002fH-Lo
 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 13:40:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=M5s737MHoUSsXZbDmJCjnTSNyxs4qT2qSK+micSAInA=; b=AjC9hvH79c0AvY42ZGNP3wjh8a
 rtpdDQvlOHGRXvUHDX8W9gjeYflxFmz80wi7oroW9nBSriND2hEnGHL14cgFn2hh9HixX2bmYYcDP
 LQKvUOZLS/479JnA116yvQIvdyj419J1otwUmJtGIAa3qvnHtCIzd3cTR+xfRzkhREGY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=M5s737MHoUSsXZbDmJCjnTSNyxs4qT2qSK+micSAInA=; b=j
 zftmyff2P2QDg6qofF7NIuKTaaiFmLGIZcyHaVz6s8B0DGXpDxTyAqvdv7+PiHdNvUsqhzvaishk5
 30kFJ6L064iVeoNWEXwPV215w21CNHlfw8tYPG7XiswsnCzzTmzbiq3W3aFw/ct30jPJyR0Vapp8a
 OnJXu63cdyhSrPjg=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBBaE-0002yv-5n for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 13:39:55 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912d391aso22324025e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 28 Sep 2026 06:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790602787; x=1791207587; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=M5s737MHoUSsXZbDmJCjnTSNyxs4qT2qSK+micSAInA=;
 b=PrbC/LF8USmKxR6bq/PuLEQBWa7eNt43brVWiO/JQivKq8Ihsr4Qn+zj0wPqDjtgl+
 2xhrr+AIJ4lWFR54RoNl5SpUPVBCviUlNvbxb+hddN4rIEMsXaqSkHkkYnOhwgGG9li1
 wKDX9e8DiJAEh2mMJODqp0BCjFRrqd/Fimmbh9CXk2z2l4EHuRx5ByCn/QaFHtX3yiB4
 IgZxf2DaJDiHszkIIYM/tpjIEJg0yjbWFKrGW650rNs8SFJAuJt2yWPFcoWqnmHA1Bz0
 PDGKWJZtW4Q0MbFrF5H6GvT4rJdsY+CbWNxbjdDehaCxWW/S+89c6yMVJXFE81dIk3xH
 KgTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790602787; x=1791207587;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=M5s737MHoUSsXZbDmJCjnTSNyxs4qT2qSK+micSAInA=;
 b=ngYRdXNIakQk8o/Y09Pk9TwGNg4oNbFFbTWK7UiLi6n9I5Wkg2Ky91BzvZlDX1rAF9
 4B8EJHvZ8QTef6hEU09GK17jvgqTy2EYoYKaZDvZ3nDp/BXfYFv1k4VVOLNWGb5VJjvw
 buWoHmUQJVg+JtUf/l3P7Q0zNN6DeFnMOZ3/ulF4eAOXXxHpBC/y10VkMyRLCxMcPTLy
 4rgS+LIysxPGnQ4+wMBBhHHUbkmSQqj7BG95kQRhKr7XDJto87QNPHudJnYkTGYAJ2nK
 GfsvZUuXVxxkJ8bWG/2fhmCnPWvRUOy1zgjqI3Bvpbnn3Kn9FwjmTQH0SrafvNXUg15N
 GwCQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwtfrK4YwP1eNvkXqojwUIlH+3pHPsuEqqbtVgnZXb6ni8LteD2bnMRBSfiDuquNXgw7Q+bLk3uS8GWzf+l@lists.sourceforge.net
X-Gm-Message-State: AFuF++mOFaq0GjI8ypm39Cgv72gsLLHAAgjaxkLqtg6PcLORdvQlaj0f
 6TTRTfqmsHBEwlCjxVx0KFDGf70oZqhFZrp2934pKeRWe7gPumezA8IAPBvVvceQRKK9CdTAd2W
 5lurVywf3/ETULf5YhNdcbDfy/7rbZVUGAYc+F3Mu3Kguhu4QsbeRLUOz7O3ZFELFiO+oXvESOX
 62MUnzUA==
X-Gm-Gg: AYBFou3FzfpaENqjIP42w0eRniEMSsspzj7c9sIczqBsJNJqpMbSfccnK3FPFmSf52b
 L3/SWl4MjQuSvdKlf+bQtPsIXZeUqvwi7z0u+8phVp9gg5lvigaNQcGUlEhCDE69c33udtlMsmj
 ip6RczGr31T0owAS+OW2qlVNWXS6ZVthVwsNrLI3SbZ5lPyt4HJc/q72dmKaMHOYaXhMj+v5eEf
 yfc6MkFpAkd+SJLXeXMDLtlMI86MVAod5NuONjfJd1bPnXtpiJDXMCDUPNYg5sJ6ZS1ytPSek6b
 NU/f4l3H7QSTIbx7+SwFwQmy0/+QJGclnvf2oKAClMFCq2d2+XC9sylJth+H9FxYcqXPrZ9WYu0
 b0zO0oxr/YuHg4QCB5khdTRpABDwQVs6+ELa9OqVVhxJgFaunhX0ZUquiT8DoEj1ieimDgVL9Bm
 9dDJs9Dz3NSSgIazn79EfArXm4UJ++KWopLpjQy9CGNakdHhlu1ShdOFkEughk0LeSj6E8CsTRc
 nqTqjY3C3gDoPO+zi1fpogrMeRMySiircCbF5qGi1bCOShHWV13qYQTuGo8FrzUB9bTZ5mvZxOP
 +4+xVY0DeO2ZVeW84cDH8Vn0mGJkxfMYsaRDU6GVZD8LyLBvcDGrM0Iodkm5pQ==
X-Received: by 2002:a05:600c:c177:b0:49c:fc6c:be19 with SMTP id
 5b1f17b1804b1-49fe67080b1mr243425125e9.31.1790602787364; 
 Mon, 28 Sep 2026 06:39:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a349fa1sm40170210f8f.8.2026.09.28.06.39.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 06:39:46 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 28 Sep 2026 13:39:44 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iacbba3dabd8049901212adaf7551abc554b00226
X-Gerrit-Change-Number: 1956
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1956?usp=email>
X-Gerrit-Commit: 26a34ab6630a0828b1b505968eeb24c4b408047c
X-Gerrit-Comment-Date: Mon, 28 Sep 2026 13:39:44 +0000
In-Reply-To: <gerrit.1790601772000.Iacbba3dabd8049901212adaf7551abc554b00226@gerrit.openvpn.net>
References: <gerrit.1790601772000.Iacbba3dabd8049901212adaf7551abc554b00226@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNjAxNzcyMDAwLklhY2JiYTNkYWJkODA0OTkwMTIxMmFkYWY3NTUxYWJjNTU0YjAwMjI2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1cfe614c67619c60a99e4bac3cf0bd758cc18b33-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBBaE-0002yv-5n
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco: refresh peer
 stats before userspace disconnect
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
From: "ralf_lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3644648919683080125=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3644648919683080125==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DkyHSsdg5eI="; charset=UTF-8

--DkyHSsdg5eI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

ralf_lici has posted co=
mments on this change by ralf_lici=2E ( http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1956?usp=3Demail )

Change subject: dco: refresh peer stats before u=
serspace disconnect
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 1:

(1 comment)

Patchset:

PS1: 
Tested with explicit `=
client-kill <id> HALT` (HALT is for asking the client to not reconnect imme=
diately):

```
=2E=2E=2E
MANAGEMENT: CMD 'client-kill 0 HALT'
Delayed exit =
in 5 seconds
SENT CONTROL [client]: 'HALT' (status=3D1)
client/udp4:10=2E10=
=2E10=2E2:42046 rx-peer-id=3D0 UDPv4 WRITE [65] to [AF_INET]10=2E10=2E10=2E=
2:42046: P_CONTROL_V1 kid=3D0 [ 4 3 2 1 ] pid=3D7 DATA len=3D27
client/udp4=
:10=2E10=2E10=2E2:42046 rx-peer-id=3D0 UDPv4 WRITE [65] to [AF_INET]10=2E10=
=2E10=2E2:42046: P_CONTROL_V1 kid=3D0 [ 4 3 2 1 ] pid=3D7 DATA len=3D27
reg=
ister signal: SIGTERM (delayed-exit)
client/udp4:10=2E10=2E10=2E2:42046 rx-=
peer-id=3D0 SIGTERM[soft,delayed-exit] received, client-instance exiting
dc=
o_get_peer: peer-id 0
ovpn-dco: received netlink message type=3D48 cmd=3D3 =
flags=3D0000
ovpn_handle_peer: parsing message for peer 0=2E=2E=2E
dco_upda=
te_peer_stat / dco_read_bytes: 554
dco_update_peer_stat / dco_write_bytes: =
410
dco_update_peer_stat / tun_read_bytes: 290
dco_update_peer_stat / tun_w=
rite_bytes: 290
register signal: SIGTERM (close_context)
dco_del_peer: peer=
-id 0
dco_read_and_process
ovpn-dco: received netlink message type=3D48 cmd=
=3D5 flags=3D0000
ovpn-dco: received CMD_PEER_DEL_NTF, ifindex: 2, peer-id =
0, reason: 1
Received DCO message for unknown peer-id: 0, type 5, del_peer_=
reason 1
```

And the negative path (with a peer expiring in the kernel):
`=
``
=2E=2E=2E
client/udp4:10=2E10=2E10=2E2:51969 rx-peer-id=3D0 Timers: ping=
 5, ping-restart 20
client/udp4:10=2E10=2E10=2E2:51969 rx-peer-id=3D0 Proto=
col options: protocol-flags cc-exit tls-ekm dyn-tls-crypt
dco_read_and_proc=
ess
ovpn-dco: received netlink message type=3D48 cmd=3D5 flags=3D0000
ovpn-=
dco: received CMD_PEER_DEL_NTF, ifindex: 2, peer-id 0, reason: 2
client/udp=
4:10=2E10=2E10=2E2:51969 rx-peer-id=3D0 SIGTERM[soft,ovpn-dco: ping expired=
] received, client-instance exiting
register signal: SIGTERM (close_context=
)
```

There are no dco_get_peer call during closure, and no redundant dco_=
del_peer, because dco_peer_id was reset to -1=2E



-- 
To view, visit http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1956?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Bra=
nch: master
Gerrit-Change-Id: Iacbba3dabd8049901212adaf7551abc554b00226
Ger=
rit-Change-Number: 1956
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@ma=
ndelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atten=
tion: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Mon, 28 S=
ep 2026 13:39:44 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--DkyHSsdg5eI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>ralf_lici has posted comments on=
 this change by ralf_lici=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1956?usp=3Demail">View Change</a></p><p>1 comment:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p=
>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1956?tab=3Dcomments&amp;usp=3Demail=
">Patch Set #1:</a> </p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Tested with explicit `client-kill &lt;id&gt; HALT`=
 (HALT is for asking the client to not reconnect immediately):</p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">```<br>=
=2E=2E=2E<br>MANAGEMENT: CMD &#39;client-kill 0 HALT&#39;<br>Delayed exit i=
n 5 seconds<br>SENT CONTROL [client]: &#39;HALT&#39; (status=3D1)<br>client=
/udp4:10=2E10=2E10=2E2:42046 rx-peer-id=3D0 UDPv4 WRITE [65] to [AF_INET]10=
=2E10=2E10=2E2:42046: P_CONTROL_V1 kid=3D0 [ 4 3 2 1 ] pid=3D7 DATA len=3D2=
7<br>client/udp4:10=2E10=2E10=2E2:42046 rx-peer-id=3D0 UDPv4 WRITE [65] to =
[AF_INET]10=2E10=2E10=2E2:42046: P_CONTROL_V1 kid=3D0 [ 4 3 2 1 ] pid=3D7 D=
ATA len=3D27<br>register signal: SIGTERM (delayed-exit)<br>client/udp4:10=
=2E10=2E10=2E2:42046 rx-peer-id=3D0 SIGTERM[soft,delayed-exit] received, cl=
ient-instance exiting<br>dco_get_peer: peer-id 0<br>ovpn-dco: received netl=
ink message type=3D48 cmd=3D3 flags=3D0000<br>ovpn_handle_peer: parsing mes=
sage for peer 0=2E=2E=2E<br>dco_update_peer_stat / dco_read_bytes: 554<br>d=
co_update_peer_stat / dco_write_bytes: 410<br>dco_update_peer_stat / tun_re=
ad_bytes: 290<br>dco_update_peer_stat / tun_write_bytes: 290<br>register si=
gnal: SIGTERM (close_context)<br>dco_del_peer: peer-id 0<br>dco_read_and_pr=
ocess<br>ovpn-dco: received netlink message type=3D48 cmd=3D5 flags=3D0000<=
br>ovpn-dco: received CMD_PEER_DEL_NTF, ifindex: 2, peer-id 0, reason: 1<br=
>Received DCO message for unknown peer-id: 0, type 5, del_peer_reason 1<br>=
```</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">And the negative path (with a peer expiring in the kernel):<br>```<=
br>=2E=2E=2E<br>client/udp4:10=2E10=2E10=2E2:51969 rx-peer-id=3D0 Timers: p=
ing 5, ping-restart 20<br>client/udp4:10=2E10=2E10=2E2:51969 rx-peer-id=3D0=
 Protocol options: protocol-flags cc-exit tls-ekm dyn-tls-crypt<br>dco_read=
_and_process<br>ovpn-dco: received netlink message type=3D48 cmd=3D5 flags=
=3D0000<br>ovpn-dco: received CMD_PEER_DEL_NTF, ifindex: 2, peer-id 0, reas=
on: 2<br>client/udp4:10=2E10=2E10=2E2:51969 rx-peer-id=3D0 SIGTERM[soft,ovp=
n-dco: ping expired] received, client-instance exiting<br>register signal: =
SIGTERM (close_context)<br>```</p><p class=3D"blocks" style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">There are no dco_get_peer call during cl=
osure, and no redundant dco_del_peer, because dco_peer_id was reset to -1=
=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1956?usp=3Demail">change 1956</a>=2E To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1956?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ger=
rit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project=
: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
=
<div style=3D"display:none"> Gerrit-Change-Id: Iacbba3dabd8049901212adaf755=
1abc554b00226 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 195=
6 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=
=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 28 Sep 202=
6 13:39:44 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Ye=
s </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body>=
</html>
--DkyHSsdg5eI=--


--===============3644648919683080125==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3644648919683080125==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3644648919683080125==--

