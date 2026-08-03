Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C02F3C55184
	for <openvpn-devel@archiver.kernel.org>; Mon,  3 Aug 2026 10:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cVs5zI45R25ZV0WjO7JOqFY+tbGxedrSJ7LKUEwKBHo=; b=lY07Oov5+9wzDlTFBOd+qJHQVm
	JUIPUvzqSSCHFvqI+/F9+UK56nA6GcThN57LHgByLD3+hFaWI49TBp9NER8Y3kHS09sPj+uv91YCe
	z9dsOfWw4nqzHU1/1FnWePOoDLUsH4xr06JxaSZAuC4e5bCs01LMW+Sn2azSEX3uz1y8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wqpTn-0005Sj-AF;
	Mon, 03 Aug 2026 10:01:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wqpTm-0005Sc-8e
 for openvpn-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 10:01:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=m5irRYpFFuIape3Uogx2EideDEyhJoujhwmS7qe3FNQ=; b=nV0vSHtDOSjUt7o+7DK+QeiZxQ
 0XwzmTqeQa7HLCjEkXvs9e/yCmbhfF/8g4ml1AZqs4abo+p6qX903arxutBGx+J/ZYjrUEg40O0NG
 Xw8NyOhVcqOtYDYSo3r6hjuvTjzOmt7aw+tLXKqBMyobctlMj5jiDFomDJH1byCL+y0M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=m5irRYpFFuIape3Uogx2EideDEyhJoujhwmS7qe3FNQ=; b=I
 Vi4Fd4COL7iYOxVNA+KiLSpb3mfaV+9eyTBxdngAhCkIyw12CmieY2MoCyUT+NKf0jShHouO9rMyR
 gHu8WfESZhKU4PgrNzc+IAGRxFQbwR/1pDhy8in4uN9kjMXV3uNdHB58346R7bKh2ACKe8CySr+A8
 4IyzdHqzvL+g2Oz8=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wqpTj-0004qx-Rv for openvpn-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 10:01:06 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-4798bea72f9so2245907f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 03 Aug 2026 03:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785751257; x=1786356057; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=m5irRYpFFuIape3Uogx2EideDEyhJoujhwmS7qe3FNQ=;
 b=BdR5ancWGInOQ2B2XZ7zy5gUT3h9AgQLPjsOYUuY4FzcWqtREXLi0znjEVj6IseDja
 Z5Q+f6YI9OS4q1V1fw/6vdjh0rlXjLbhpA38iDbbr9TZVGjwoWBfnKRyW3FTgZMqyfP+
 BOoqVhSnaJH8Q1QnRFg7zkvgEO1Vl3I8qR3Dd1EFim+16u5Pz3xPbde+9oClB7KqwHHw
 kBNj9jOL4OZMPTmG9oNFM5zH7uClFIr0XXwL2/0ReRSvWZIWBrtkxlsfdWSm38ly4Px/
 5R5kYxq1H9NkcttOKq5xXJnq/TijLynjLrJ8whhzM+1pu00543IgRwykxLmXjBTkyLwG
 XPHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785751257; x=1786356057;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=m5irRYpFFuIape3Uogx2EideDEyhJoujhwmS7qe3FNQ=;
 b=BAHelTcDSt35ESjGnxc9mDUHyV3Y6zZOdpYMIIutZlGkY39WreRvp7JrKhLfAkqPXv
 8Q9H+tDvH7Sy5H2LTsh5QbK3GVMXp851n1vLRBQIAwVX12OBFhRpekKL4G/sBT1hkDEa
 l2FsQOE8QuKBHM+9Gbc42xisimvkwpUBGS2z6kuRW16BcHcg61JXd4cu85WByRUSiNBk
 1iw3alYretBSR/DsQBjBXqKnWRO6CqjDK9n7rhNfvRGnWz6fzrQ2aYc1WgLa+7QmLtPC
 ujCFDK5hdfWXd7mWagPt1enithfor/jPDYqi4aZ2xw0xRWnCAzwev4UjBqUKEZ85t8CM
 e90w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrvGAXwz/+EI7N2Pofbn6LBiKwqP9cZI2mIxqIRVcxjzPEqF8e7zr0K54+whcvGwS+oWxc6xrnVx5X/NdAA@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yx1A7hOpT+8c/zHJ5NfvMyKVVrFgw59AG4GBBnWJaA46+qJeNtU
 NKCcEUM6rweOnuBchMceVid+184zlFlXs/OQoXz1wEY9iUBo8DL99YO8mIlx09jsQctBw5gtEG+
 04CuK4v8aLNyVxlHRyyoaNoLRo0UyEa/UGDnRVUxrYCqHFiABFKviLFFkiSr+/tYISR1r
X-Gm-Gg: AR+sD10OjWeSCWV7mqApT8mxhDXFgcZhPFWwOaid2I3WXhxUeM2YXBjn+ENVdFFgbcU
 Z8q/wsGZaEjLRM+6yW28AkXM9U/b2I5vCoalXHUj2mBpfB5lfZRV4v8X4n1v3PtnThGDurQmyIW
 cA267kttF/GMEYBnkeRsX18ZAeoL17aM2UpydqrKAmQq6pj5oT74iY5IN2IKGoM44P7TB8lDiip
 7u5w9tK1/dOvPznBNkwIT/swKjPmzVRkb99O1Z5ZDnPlqDjBmvW5j0pATLOxIVftGSG/BGX6ftQ
 UWQW60B1d05HNm9PVLAtRr/yzp2K+B/QLUdIZVlOWPBbhcL7KR7dfX3K8JEJ+y7eCUBPfj/1UAT
 9dyupnhCZnb5p7PP8Zo7LwbsIFyOosciDjDDkMZS/fL+WCr5uCbts5rEss8ONcXv06aTtPyVkHh
 M0sLkX3XQw7YAnYbKm0UMfR4KTv0kyAAn9Tz2x4qX3qf/GGHpJsg9GQl0T7caHeTJET4x1vQEy6
 xjEWRhiZixgfh5xQZ5dQVbI5xDpa2mbnX/Bmq20URaDuuUFWMH5nUiHHGjjD6i2V8PIHWrFNRpB
 XEv45gTDsxNQFDnTavduzsNy0qGywbiLqygn3GNXPi2KgoUje4E=
X-Received: by 2002:a05:600c:840f:b0:495:4b24:1b64 with SMTP id
 5b1f17b1804b1-4980c601d19mr189674415e9.0.1785751256224; 
 Mon, 03 Aug 2026 03:00:56 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49808191be8sm326206245e9.2.2026.08.03.03.00.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 03:00:55 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 3 Aug 2026 10:00:52 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I96b5ea3542df77b1be17079874fb9e4970b539ed
X-Gerrit-Change-Number: 1830
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1830?usp=email>
X-Gerrit-Commit: 86bac756964e392febc55fb025cba9a203b8befa
X-Gerrit-Comment-Date: Mon, 3 Aug 2026 10:00:52 +0000
In-Reply-To: <gerrit.1785312487000.I96b5ea3542df77b1be17079874fb9e4970b539ed@gerrit.openvpn.net>
References: <gerrit.1785312487000.I96b5ea3542df77b1be17079874fb9e4970b539ed@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MzEyNDg3MDAwLkk5NmI1ZWEzNTQyZGY3N2IxYmUxNzA3OTg3NGZiOWU0OTcwYjUzOWVkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <75dcf8ff794a08aac1d81038bfa48b2d307e358e-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wqpTj-0004qx-Rv
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6029125125371713725=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6029125125371713725==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Urqlc+pU4CE="; charset=UTF-8

--Urqlc+pU4CE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos=2E

ordex has posted=
 comments on this change by cron2=2E ( http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1830?usp=3Demail )

Change subject: SIGHUP-restart instance on UDP wr=
ite error EADDRNOTAVAIL
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 2: Code-Review-2

(5 comments)

Patchset:

PS2: 
!!!
=


File src/openvpn/forward=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1830/comment/c67a9662_957cf4b1?usp=3Demail :
PS2, Line 1865:         if (si=
ze < 0 && errno =3D=3D EADDRNOTAVAIL)
Here you should be checking for `erro=
r_code`, not `errno`=2E check_status() mangles errno on Linux/Android, thus=
 making this check wrong/no-op on those platforms=2E
I presume on macOS it =
works by accident=2E

What about Windows? =F0=9F=98=84 do we need the same =
dance as above with `WSAEADDRNOTAVAIL`?


http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1830/comment/a68ccbf3_e4b9715b?usp=3Demail :
PS2, Line 1868:      =
       register_signal(c->sig, SIGHUP, "link-changed");
There is no guard p=
reventing this check to fire on a server=2E=2E=2E=2EIf that happens we are =
restarting the whole top instance =F0=9F=98=8A I presume this can also happ=
en on a per server-client-instance=2E In that case we'd drop the client, bu=
t it may be what we wanted=2E

To fix the server problem, maybe you could a=
dd a simple `&& c->options=2Emode =3D=3D MODE_POINT_TO_POINT` to the check?=



http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1830/comment/fca69be4_0e3abe9f=
?usp=3Demail :
PS2, Line 1868:             register_signal(c->sig, SIGHUP, =
"link-changed");
have you checked how this SIGHUP interacts with `--connect=
-retry-max` ? SIGHUP makes openvpn re-read the config and re-init its state=
, which translates in ignoring the retry-max configured option=2E It's a ra=
re hit, but still this patch bypasses that logic=2E

If by any chance this =
error becomes persistent, the client would never exit instead of bailing ou=
t out the maximum retries=2E


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/18=
30/comment/2d503b5e_02d2c130?usp=3Demail :
PS2, Line 1868:             regi=
ster_signal(c->sig, SIGHUP, "link-changed");
using SIGHUP this way makes `-=
-config stdin` + `--remap-usr1 SIGHUP` a fatal usage error: SIGHUP re-reads=
 the config, but stdin is at EOF=2E
This patch registers SIGHUP without che=
cking both options=2E=2E=2EYou can check by issuing SIGHUP on a stdin-confi=
g daemon and it will die with `Options error: blah blah blah`=2E



-- 
To =
view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1830?usp=3Demail
To u=
nsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I96b5ea3542df77b1be17079874fb=
9e4970b539ed
Gerrit-Change-Number: 1830
Gerrit-PatchSet: 2
Gerrit-Owner: cr=
on2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: ordex <antonio@mandelbit=2Ec=
om>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: open=
vpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plais=
thos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: cron2 <gert@greenie=2Em=
uc=2Ede>
Gerrit-Comment-Date: Mon, 03 Aug 2026 10:00:52 +0000
Gerrit-HasCom=
ments: Yes
Gerrit-Has-Labels: Yes

--Urqlc+pU4CE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, plaisthos=2E </p>
<p>Patch set 2:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #ffd4d4;">Code-Review -2</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1830?usp=3Demail">View Change</a></p><p>5=
 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1830?tab=3Dco=
mments&amp;usp=3Demail">Patch Set #2:</a> </p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">!!!</p></li></ul></li><li st=
yle=3D"margin: 0; padding: 0;"><p>File src/openvpn/forward=2Ec:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1830/comment/c67a9662_957cf4b1?usp=3Demail">Patch Set #2=
, Line 1865:</a> <code style=3D"font-family:monospace,monospace">        if=
 (size &lt; 0 &amp;&amp; errno =3D=3D EADDRNOTAVAIL)</code></p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Here you sh=
ould be checking for `error_code`, not `errno`=2E check_status() mangles er=
rno on Linux/Android, thus making this check wrong/no-op on those platforms=
=2E<br>I presume on macOS it works by accident=2E</p><p class=3D"blocks" st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">What about Windows? =
=F0=9F=98=84 do we need the same dance as above with `WSAEADDRNOTAVAIL`?</p=
></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1830/comment=
/a68ccbf3_e4b9715b?usp=3Demail">Patch Set #2, Line 1868:</a> <code style=3D=
"font-family:monospace,monospace">            register_signal(c-&gt;sig, SI=
GHUP, &quot;link-changed&quot;);</code></p><p class=3D"blocks" style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">There is no guard preventing th=
is check to fire on a server=2E=2E=2E=2EIf that happens we are restarting t=
he whole top instance =F0=9F=98=8A I presume this can also happen on a per =
server-client-instance=2E In that case we&#39;d drop the client, but it may=
 be what we wanted=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap=
; word-wrap: break-word;">To fix the server problem, maybe you could add a =
simple `&amp;&amp; c-&gt;options=2Emode =3D=3D MODE_POINT_TO_POINT` to the =
check?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/183=
0/comment/fca69be4_0e3abe9f?usp=3Demail">Patch Set #2, Line 1868:</a> <code=
 style=3D"font-family:monospace,monospace">            register_signal(c-&g=
t;sig, SIGHUP, &quot;link-changed&quot;);</code></p><p class=3D"blocks" sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">have you checked how t=
his SIGHUP interacts with `--connect-retry-max` ? SIGHUP makes openvpn re-r=
ead the config and re-init its state, which translates in ignoring the retr=
y-max configured option=2E It&#39;s a rare hit, but still this patch bypass=
es that logic=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">If by any chance this error becomes persistent, the cl=
ient would never exit instead of bailing out out the maximum retries=2E</p>=
</li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1830/comment/=
2d503b5e_02d2c130?usp=3Demail">Patch Set #2, Line 1868:</a> <code style=3D"=
font-family:monospace,monospace">            register_signal(c-&gt;sig, SIG=
HUP, &quot;link-changed&quot;);</code></p><p class=3D"blocks" style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">using SIGHUP this way makes `--c=
onfig stdin` + `--remap-usr1 SIGHUP` a fatal usage error: SIGHUP re-reads t=
he config, but stdin is at EOF=2E<br>This patch registers SIGHUP without ch=
ecking both options=2E=2E=2EYou can check by issuing SIGHUP on a stdin-conf=
ig daemon and it will die with `Options error: blah blah blah`=2E</p></li><=
/ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1830?usp=3Demail">change 1830</a>=2E To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1830?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I96b5ea3542df77b1be17079874fb9e4970b53=
9ed </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1830 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display=
:none"> Gerrit-Owner: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@mandelbit=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: open=
vpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert=
@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-=
Date: Mon, 03 Aug 2026 10:00:52 +0000 </div>
<div style=3D"display:none"> G=
errit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Label=
s: Yes </div>

</body></html>
--Urqlc+pU4CE=--


--===============6029125125371713725==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6029125125371713725==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6029125125371713725==--

