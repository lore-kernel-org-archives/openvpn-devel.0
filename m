Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF119C55182
	for <openvpn-devel@archiver.kernel.org>; Mon,  3 Aug 2026 13:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8ZhIYq5ucAWnJX/4OOqI3NWzkO8XkUgqEjwl665fu4A=; b=DlrsQtnXSNh50dHOhuP8jKChJQ
	19xhFlc6Cmisyzua3+L6Oa8B3A5e3GjYsEfMYL/YpQ3NqQXQ0Nl+uwnYnMBj6Z22UqYtYRDZfkxbq
	p+XjuQEF4ySh2FkIx28OmQMhObhFqHFwXHR/2g2h2GV1W8ZfnYFcbuyU/2hqeZW/BWyg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wqshl-0001FL-PI;
	Mon, 03 Aug 2026 13:27:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wqshk-0001FD-Nh
 for openvpn-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 13:27:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Q+dEUAj1D581Qla8ZfpQOg1Gs5D7TC64pQ6Ku3yG60M=; b=RsLgQ5KRZIeY07NnB0p6r5GNzX
 zzhO0X4dBqJjklR7vSvd8Awic7neq9qO7051b5JxFXF166Eh4gyF0LVJyc/fo+KDLTuN4VW2Ucznr
 VZgHB/imXhAKPGkdoAOnjudqm7jLVArm09yPqeEb22bOr55kKdUQCQ54BHZoEn+efnAU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Q+dEUAj1D581Qla8ZfpQOg1Gs5D7TC64pQ6Ku3yG60M=; b=b
 4NO1sdDZCpb6dD0MTCOHYrCbZ7kmoVUbEfBPYECtzhKnFZAnZwam8za3Tv9pwBpjpD1oeh0Ntuq8+
 SaZdkIsyj1Ug87bmbJ8RPETqn9b6fKlu/VvSMuei7Cea8YUfkCQ3vm5D/OEy0X3E6JV7g3RXaKUrM
 8oBxwtIKDHvOfFrM=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wqshj-0003Vm-7s for openvpn-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 13:27:44 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4954d29264cso10841235e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 03 Aug 2026 06:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785763657; x=1786368457; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Q+dEUAj1D581Qla8ZfpQOg1Gs5D7TC64pQ6Ku3yG60M=;
 b=cUq98iBA28wCgSn2J7ZP0tWTAf9cAtJ4RJ5XlPO1z+ql8AAHv5OmEOIi9g3erD8utm
 HZhEhwTHNKeTtckars76vQwLrLkdhGxOSWti0gk7sbDkfAsSfN5rS917kasj5XcyvtJP
 2dYimwNKZahXVqcd222hTQuMjmv1IpZReN12Av/jdQDuZCipWR5iHKsaKlwrgmHXypP2
 cLDm6rrYBn3DHrc/Wqp0JSTsW4mZNTaYRP6YR4EV93Pv5Dsg/j01hNu5ph6hxjDLXVvV
 N/UfbDOEdEQy8fvvqeh5SGZfn9KTc3L9dRjsjzOOJE0chu5rInZ7sdlU3epcBFl5iXmq
 wPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785763657; x=1786368457;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Q+dEUAj1D581Qla8ZfpQOg1Gs5D7TC64pQ6Ku3yG60M=;
 b=Zbkna+wwSsMkkLl+QjgKEERIUhRRjaq1BK6/IePBNszMlEDwM+UzPcHwQY8DPvW8Mo
 nFup4fXO2zW34YB8kI1184tZaxyD00M6WGQZCT4r+p08ouQZqcAp9aYKIiXO+1qUfwLU
 ZO/xLrPQlrS1HHP2GTKzGoEH4nn5UA+zcR+bZyYBsydVI3NJfo2ya2j9MHqpvrWR4z6T
 snmGv/gElczTQD6nAW/WXayoL5XKQoCa6k64fMsbTGKyb7/WfOCj8m8mbbXfyvip4e4o
 MZipfqbmMfIEKtks+KT2Udh6n9kd9gKeJfwaf/bqT/HSpeaUXNR/Are5Z/4U6M5tjug/
 ihSw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqIzpQqD/FUY56GKS3i4y41tNgOmvevWTPzDpg9LK7DQW2tT6IiqSKuYKMT//mbEgoUC2piADFJx5Y9I6j6@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzAChzuQY6z+suBwrgdLyLW6GBgtTCpb/oitPCO+xfTy1Xi9glP
 4WLDaOkQGZsL68YagmBTZxXe2F9Xfa3kZ9PuOGrsueJyPUGhnZ1IjTf/NToNgqoT8UxGdS2+Crd
 bdSgn9aX0XPlB7E1xKzsgoxMJUsxBF2bTwMcrmJvcVg9f6Ax6F5PVdEhtipw6/KYTSn8G
X-Gm-Gg: AR+sD10jHnOJptzwyQTqp0GyqKiamYyhA5yDnY8xf22UtMeCY4tN7hGE55czPetGOrp
 FqFGXxiiFwBRGEyH2EmjSr5d1FtFc9vcschGuxtxsvO+NqbkL06JCBJSlv218nMvljOhpdH+eIG
 EJoPg1B81LUfE8PUIluGG/iETLSw/JJGjCN8iuXQTNIkQS+M0+si+U1JeyJqIcfT09bjgDRMu8P
 n/LI4Mz4XLjc+fYDR0L7gyW6MUxsqLDR38IxUTYbJNSxXKFQTALSNR1KjthjTb1JY6zKJ7JJ7Ya
 8UdWo2qxK8lTq7wrWaBzR9XfAUPCD0VhukdOC/CW9oQFCS+PUtgW4wsalX3oYlnQlvzuiAqam5w
 zRhB+CVsvU2tP+yJmPlCaHSaZPq/aySJpEqeNGjUJD7VT+batFvOXdeb+VAcXUgzbqw3I7jmoDa
 LfTxenHfYYUBtZwb35E/Mr6NGtRXKXJy7ysf/WW+pMoSHTV8ThP1d7rV4hdORem+MlhNHfkOUUQ
 NUJd5hZD2MkN3rMh26fxST4TdjdI9z5TU6qjxrUnqDU4Ymd6Ztt2TEr1Pj+NQ94QvbNtjsH1iUu
 EXBTK9qVLVV1YfMcuoOFJb/xyKSqCrHx9LJg75tykwRsilJKvHg=
X-Received: by 2002:a05:600c:1504:b0:498:273:3271 with SMTP id
 5b1f17b1804b1-4980c66d9e0mr120204145e9.1.1785763656097; 
 Mon, 03 Aug 2026 06:27:36 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49807b98284sm232336965e9.12.2026.08.03.06.27.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 06:27:35 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 3 Aug 2026 13:27:33 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I96b5ea3542df77b1be17079874fb9e4970b539ed
X-Gerrit-Change-Number: 1830
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1830?usp=email>
X-Gerrit-Commit: 86bac756964e392febc55fb025cba9a203b8befa
X-Gerrit-Comment-Date: Mon, 3 Aug 2026 13:27:33 +0000
In-Reply-To: <gerrit.1785312487000.I96b5ea3542df77b1be17079874fb9e4970b539ed@gerrit.openvpn.net>
References: <gerrit.1785312487000.I96b5ea3542df77b1be17079874fb9e4970b539ed@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MzEyNDg3MDAwLkk5NmI1ZWEzNTQyZGY3N2IxYmUxNzA3OTg3NGZiOWU0OTcwYjUzOWVkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6f4a0b9c18d762752e1f6c72ed6bdf0c28e9f577-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wqshj-0003Vm-7s
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
Content-Type: multipart/mixed; boundary="===============4482147940872725147=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4482147940872725147==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hIidO5n9U2o="; charset=UTF-8

--hIidO5n9U2o=
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


Patch Set 2:

(4 comments)

File src/openvpn/forward=2Ec:

http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1830/comment/572a9546_aa6773b9?usp=3D=
email :
PS2, Line 1865:         if (size < 0 && errno =3D=3D EADDRNOTAVAIL)=

> good catch=2E  Will adjust=2E [=E2=80=A6]
well, unless EADDRNOTAVAIL on =
Windows is equal to some WSRANDOMTHING that may be returned under other cir=
cumstances, no (hopefully not)?


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1830/comment/c7127dda_9938ba98?usp=3Demail :
PS2, Line 1868:             r=
egister_signal(c->sig, SIGHUP, "link-changed");
> I can't follow you=2E [=
=E2=80=A6]
you're right=2E I was testing with `--config stdin` and the othe=
r option was already there in my harness, but it's indeed irrelevant=2E

At=
 the same time I searched this pattern across the code and I saw other spot=
s where we register SIGHUP without checking if config is coming from stdin=
=2E So this patch has indeed this issue, but it's not new :-D !!!

You can =
decide if you want to add a guard here or if this should be fixed later on =
along the other spots=2E

Moreover, the other spots where we register SIGHU=
P have a `c->persist=2Erestart_sleep_seconds =3D 10;` right after, so that =
we do not busy loop in case of permanent error=2E Worth adding here too?


=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1830/comment/8a5b06fd_81757e6d?us=
p=3Demail :
PS2, Line 1868:             register_signal(c->sig, SIGHUP, "li=
nk-changed");
> In this case, we would do a `SIGHUP` reconnect anyway, just=
 "after `--ping-restart` expires"=2E [=E2=80=A6]
When we hit `connect_retry=
_max` attempts, we have an M_FATAL that stops everything=2E
With this patch=
 we'll keep looping=2E

Note, as I said in the other comment, there are oth=
er areas of the code where we register SIGHUP and also in those cases we do=
n't honor `connect-max-reply`=2E=2E=2E


http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1830/comment/1f257674_6a405be6?usp=3Demail :
PS2, Line 1868:       =
      register_signal(c->sig, SIGHUP, "link-changed");
> I'm not sure this =
can be triggered in a meaningful way on a server - there are no redirect ro=
utes fo [=E2=80=A6]
Agreed this might be difficult, but there might be othe=
r scenarios (which we are not seeing now) that may trigger this error=2E Th=
anks!



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1830?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Ge=
rrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I96b5ea3542df=
77b1be17079874fb9e4970b539ed
Gerrit-Change-Number: 1830
Gerrit-PatchSet: 2
=
Gerrit-Owner: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: ordex <anton=
io@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>=

Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-=
Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: cron2 <=
gert@greenie=2Emuc=2Ede>
Gerrit-Comment-Date: Mon, 03 Aug 2026 13:27:33 +00=
00
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2=
 <gert@greenie=2Emuc=2Ede>
Comment-In-Reply-To: ordex <antonio@mandelbit=2E=
com>

--hIidO5n9U2o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, plaisthos=2E </p>
<p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1830?usp=3Demail">View Change</a></p><p>4 comm=
ents:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0;"><p>File src/openvpn/forward=2Ec:</p><ul style=3D"list-style:=
 none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1830/comment/572a9546_aa6773b9?usp=3Demail">Patch Set #2, Line 1865:</a>=
 <code style=3D"font-family:monospace,monospace">        if (size &lt; 0 &a=
mp;&amp; errno =3D=3D EADDRNOTAVAIL)</code></p><p><blockquote style=3D"bord=
er-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">good catch=2E  W=
ill adjust=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">well, unless EADDRNOTAVAIL on Wi=
ndows is equal to some WSRANDOMTHING that may be returned under other circu=
mstances, no (hopefully not)?</p></li><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1830/comment/c7127dda_9938ba98?usp=3Demail">Patch Set #=
2, Line 1868:</a> <code style=3D"font-family:monospace,monospace">         =
   register_signal(c-&gt;sig, SIGHUP, &quot;link-changed&quot;);</code></p>=
<p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddin=
g: 0 10px;">I can&#39;t follow you=2E [=E2=80=A6]</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">you&#39=
;re right=2E I was testing with `--config stdin` and the other option was a=
lready there in my harness, but it&#39;s indeed irrelevant=2E</p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">At the =
same time I searched this pattern across the code and I saw other spots whe=
re we register SIGHUP without checking if config is coming from stdin=2E So=
 this patch has indeed this issue, but it&#39;s not new :-D !!!</p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">You can=
 decide if you want to add a guard here or if this should be fixed later on=
 along the other spots=2E</p><p class=3D"blocks" style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Moreover, the other spots where we register S=
IGHUP have a `c-&gt;persist=2Erestart_sleep_seconds =3D 10;` right after, s=
o that we do not busy loop in case of permanent error=2E Worth adding here =
too?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1830/=
comment/8a5b06fd_81757e6d?usp=3Demail">Patch Set #2, Line 1868:</a> <code s=
tyle=3D"font-family:monospace,monospace">            register_signal(c-&gt;=
sig, SIGHUP, &quot;link-changed&quot;);</code></p><p><blockquote style=3D"b=
order-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">In this case,=
 we would do a `SIGHUP` reconnect anyway, just &quot;after `--ping-restart`=
 expires&quot;=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">When we hit `connect_retry_m=
ax` attempts, we have an M_FATAL that stops everything=2E<br>With this patc=
h we&#39;ll keep looping=2E</p><p class=3D"blocks" style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">Note, as I said in the other comment, there=
 are other areas of the code where we register SIGHUP and also in those cas=
es we don&#39;t honor `connect-max-reply`=2E=2E=2E</p></li><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1830/comment/1f257674_6a405be6?usp=
=3Demail">Patch Set #2, Line 1868:</a> <code style=3D"font-family:monospace=
,monospace">            register_signal(c-&gt;sig, SIGHUP, &quot;link-chang=
ed&quot;);</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; m=
argin: 10px 0; padding: 0 10px;">I&#39;m not sure this can be triggered in =
a meaningful way on a server - there are no redirect routes fo [=E2=80=A6]<=
/blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wr=
ap: break-word;">Agreed this might be difficult, but there might be other s=
cenarios (which we are not seeing now) that may trigger this error=2E Thank=
s!</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1830?usp=3Demail">change 1830</a>=2E To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1830?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ger=
rit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project=
: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
=
<div style=3D"display:none"> Gerrit-Change-Id: I96b5ea3542df77b1be17079874f=
b9e4970b539ed </div>
<div style=3D"display:none"> Gerrit-Change-Number: 183=
0 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=
=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@mandelbi=
t=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cro=
n2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerr=
it-Comment-Date: Mon, 03 Aug 2026 13:27:33 +0000 </div>
<div style=3D"displ=
ay:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerri=
t-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: c=
ron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Co=
mment-In-Reply-To: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>

</body></h=
tml>
--hIidO5n9U2o=--


--===============4482147940872725147==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4482147940872725147==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4482147940872725147==--

