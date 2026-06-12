Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7237DCD8CA8
	for <openvpn-devel@archiver.kernel.org>; Fri, 12 Jun 2026 18:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OVAmbfMKLrnzQjAuKd/qXjB2xZe58maFRvr6DvCmJV0=; b=LLRqWU8EuzQWEEmzAcv8BAWAWj
	3FTZdJmCodV7Cn129IJT/FEeV6dNqXHnwU6L0DsQV4he8C5a7yW04pZUMY1ALdPF3cRSmls5dhpqE
	qsJCbPelj6kuId6yk9XZitXAVxrkfrINSP69lU4Wj+MgSNxrDiSx2C58ohMr4qb8QAgM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wY6GK-0004u9-IO;
	Fri, 12 Jun 2026 18:05:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wY6G2-0004tj-1j
 for openvpn-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 18:05:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=BtWSUmF4HpEOuRbp75N+4T+geXwBDTjUdwE+gFAk/A4=; b=aQrnFag3Gw05pBf15H1sqUWjSy
 N8qNT+rTiid40jVf6jDKuaGNiIt9whbnjaCuFqbS59EI5HgVm44naJJN0zhibaplduj0sqxoGx6qT
 /f5ljnbhe9zD6Pi+dTpfBcOc0X5GSW421HbS79uSKjSitBZajNTm48PLtz9Gvh/+mOfc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=BtWSUmF4HpEOuRbp75N+4T+geXwBDTjUdwE+gFAk/A4=; b=A
 aDkYWfd6i6j3Gj2ipM5ySOsFiC6qDW38h1CWSnQKrHhztLMCfZ3uPuV3kSR4e9ewksaeUBMVlVxYS
 XUqjZxGIS5X1tXEidljXxFVTsszd6doDp2F4L4smJdLzxoU2h/aLJxuCWRDoOXE7vbXDvJLCtWbDB
 PvXeVR7Yp2CSxyG0=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wY6Fp-0002B0-9d for openvpn-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 18:05:19 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-45eea68dd6fso761001f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 12 Jun 2026 11:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781287511; x=1781892311; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BtWSUmF4HpEOuRbp75N+4T+geXwBDTjUdwE+gFAk/A4=;
 b=TO3OZnurVz9zPcuCq/KTje9Kfr52OsbhWtxpoFjfqB2R4oMp1uLOvbJ5EMoXItoUi8
 hLTibX5maOx1cCTT+Z/qAFKIYVj+SAzuIkAy1HQweAG9ihkyUsuS8ue4duiuQFsw9iqv
 SMGjqpaMIkWgk2t9pZBLSFVKqE6D8Xc1cisF0EILGnYxSVghy+OGQtdPktdW2j0qgMC4
 8fta3m0X/J6vlHaJn8BM3d6guFdzjrybVcU8k4vHrwUAJ3Qtd3V9tFZDr97kf8X/EALN
 /RlbP7Qq978dAJNuRxv7nyDki1jIW6kR6kexQLSqFzTQejvVrgvWkrwM2Ov894nf7pd2
 hdDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781287511; x=1781892311;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BtWSUmF4HpEOuRbp75N+4T+geXwBDTjUdwE+gFAk/A4=;
 b=rX/YYu1dME41wWoffMElHB+D2tTDaqnOLFEZuSNbpCQqLI4kFTH9qTXjAqsq07SWG3
 JAo8WcmGcgaH8slObCXpe2jHZ+W3g+S4jZdRuH1HtB3ZN2Mq2O2rJqVeMLEqbAfu/ICx
 9KgJxjxl+a8aQor5F8BnZWD6sc1rvR7LhbrnjKF8pvU7BTPhLeRqh5l6pg0c2QL4PbS6
 gkcdDvh5paLE3QDgWK6zbfdqsgXy9U1Ac3S5rhmianL1ocCFG/34yqHeli0pzh2Cs/qn
 +SrOyAiPWyjBGWWaoS8qg/GeRNoqO2XqkdiUAe05wucyXjW5Ws/RkYHHqIWuPUkSTE8J
 Hqqg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+J9nD7TsHmkAPWLVeQfDPH5mp0UX9ZfC3HNws3s8S1Gimlxedo+J5aWix0E+nqiD8cquM/O5974cxix8P+@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxAYSFA00UlZBfZMAsW8gt/iYKQsxrhSSZVg5oI6Nw1vfb3+K7S
 WvaPkZoAXW1IorQTUYRi3MimrsnYwycaKEmH7D9F3UTjljzvCmwSmQLmGdv7aBt+X2Q1zHlRaRT
 ZvDYw5o7VVIsGt9JqFWdhD3oi4I5LOrl1ddu9gu832Uy4HPR+U3/qpQ1G0PlHN5mNI0PD
X-Gm-Gg: Acq92OEBwWL1g31HSE06++bXxM/oUHAl/RYuEnoWlxqOQhkwDNo3H+VPuhFTRYTjQHv
 yb7nfPNOYzzVMkcJftyR78srTpYsgXDF2VyX4qCY+RaeDrWPByA9EyyO8WseqsDpQwJO4jKbEm/
 tEuHpmQAAaRiR0fhOURhKDsMLpxoGGzCK9VFNl1ZtKmu1OOkI2dMmfTB+uQqc8lEDcCiZ01+VLS
 L/BUcHj2GQTVVD8TcaRBDOy1riwNzCbJavVvrLqXpL7jL9JbaT3TVZi1PAGnVwH++9qvuvQrknq
 VLPca7bupn76vDEvEXt0l2ZazpHyYa9grz8KIuJLbJLvVdk7PkZgiJpf3DnF4hoJFhT59zBkyJ3
 qFMuEJtJ32h+YqE6MRiiuOmGSfsnDSm7F7i8CcVYrgEkjlqoG9Kv7AjVqZD4aqk6xpuHINKjz7w
 1qNxdxmnvwPymVNy0YrfGtQdkPCvrVOxRb9D26JlxJvPRRaA0WVgfGrmJZakkEfV+P6UtzQHou5
 6563cjHIQCbnmpuExdvJonX6j3C/sZuzanGkRljP6MC6vvmevNxxxHBRU7OGebRvoFzioF3oJj4
 +P1l5PuY0LQ4zw==
X-Received: by 2002:a05:6000:4690:b0:451:3b12:9bca with SMTP id
 ffacd0b85a97d-4606db98901mr4056509f8f.25.1781287510810; 
 Fri, 12 Jun 2026 11:05:10 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f263945sm8201741f8f.8.2026.06.12.11.05.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 11:05:10 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 12 Jun 2026 18:05:08 +0000
To: its_Giaan <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I6b303805a3688b6f6363140c76853a58badecd8f
X-Gerrit-Change-Number: 1635
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1635?usp=email>
X-Gerrit-Commit: 6e690c619252e5d88271ace9b302f8abd626c965
X-Gerrit-Comment-Date: Fri, 12 Jun 2026 18:05:08 +0000
In-Reply-To: <gerrit.1776783100000.I6b303805a3688b6f6363140c76853a58badecd8f@gerrit.openvpn.net>
References: <gerrit.1776783100000.I6b303805a3688b6f6363140c76853a58badecd8f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc2NzgzMTAwMDAwLkk2YjMwMzgwNWEzNjg4YjZmNjM2MzE0MGM3Njg1M2E1OGJhZGVjZDhmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ec5806e541e5936b57e01d8664cb68f22baa45af-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wY6Fp-0002B0-9d
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Multisocket: use
 event engine rwflags for UDP I/O
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
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net,
 antonio@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6855394019453171980=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6855394019453171980==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/LLS3slxIMM="; charset=UTF-8

--/LLS3slxIMM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan, ordex, plaisthos=2E

cron2=
 has posted comments on this change by its_Giaan=2E ( http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1635?usp=3Demail )

Change subject: Multisocket: use e=
vent engine rwflags for UDP I/O
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 5: Code-Review-1

(5 comments)

File src/ope=
nvpn/forward=2Eh:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1635/comment/2=
9dd8fc7_d3d600d3?usp=3Demail :
PS5, Line 78: 
can we have proper documentat=
ion comments here?


File src/openvpn/forward=2Ec:

http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1635/comment/7defcd1c_cc9f7cff?usp=3Demail :
PS5, Line 2=
035: {
This function most definitely needs a comment to explain what it doe=
s, and where it is called from (here or in forward=2Eh)=2E


http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1635/comment/0a8e9c78_fb46a0ad?usp=3Demail :
P=
S5, Line 2132:  */
We need to extend this comment a bit - the fact that it =
deals with only one socket confuses me every time, and then I go "git grep"=
 and read up on the callers=2E

Maybe something like `it is either called f=
rom tunnel_point_to_point() (p2p mode) or with the per-client-context from =
multi_io=2Ec` or something like that=2E


File src/openvpn/mudp=2Ec:

http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1635/comment/e3384f44_0cc9c3e9?usp=3De=
mail :
PS5, Line 364: p2mp_iow_flags(const struct multi_context *m, struct =
link_socket *sock)
let's move this function to multi_io=2Ec - this is the o=
nly place it's called from


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1635=
/comment/6767bb95_e5e79af3?usp=3Demail :
PS5, Line 375:         if (LINK_OU=
T(&m->pending->context) && m->pending->context=2Ec2=2Elink_sockets[0] =3D=
=3D sock)
I have my doubts about this change - IOW, I am not understanding =
this at all=2E

We call this function in a loop "for all UDP sockets", and =
then this part does nothing unless the socket passed in happens to be "link=
_sockets[0]"=2E  This is really hard to understand code - and if link_socke=
ts[0] happens to be a TCP socket, this does nothing at all=2E  No?

In any =
case this needs a comment :-) - if I can't understand it, how can we expect=
 future maintainers to understand it=2E



-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1635?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: I6b303805a3688b6f6363140c76853a58badecd8f
Gerrit-Chang=
e-Number: 1635
Gerrit-PatchSet: 5
Gerrit-Owner: its_Giaan <gianmarco@mandel=
bit=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer=
: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Att=
ention: its_Giaan <gianmarco@mandelbit=2Ecom>
Gerrit-Attention: ordex <anto=
nio@mandelbit=2Ecom>
Gerrit-Comment-Date: Fri, 12 Jun 2026 18:05:08 +0000
G=
errit-HasComments: Yes
Gerrit-Has-Labels: Yes

--/LLS3slxIMM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: its_Giaan, ordex, plaisthos=2E </p>
<p>Patch set 5:<s=
pan style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padd=
ing: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1635?usp=3Demail">View Change</a=
></p><p>5 comments:</p><ul style=3D"list-style: none; padding: 0;"><li styl=
e=3D"margin: 0; padding: 0;"><p>File src/openvpn/forward=2Eh:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1635/comment/29dd8fc7_d3d600d3?usp=3Demail">Patch Set #5=
, Line 78:</a> <code style=3D"font-family:monospace,monospace"></code></p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
can we have proper documentation comments here?</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/forward=2Ec:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1635/comment/7defcd1c_cc9f7cff?usp=3Demail">Patch Set #5=
, Line 2035:</a> <code style=3D"font-family:monospace,monospace">{</code></=
p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word=
;">This function most definitely needs a comment to explain what it does, a=
nd where it is called from (here or in forward=2Eh)=2E</p></li><li style=3D=
"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1635/comment/0a8e9c78_fb46a0a=
d?usp=3Demail">Patch Set #5, Line 2132:</a> <code style=3D"font-family:mono=
space,monospace"> */</code></p><p class=3D"blocks" style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">We need to extend this comment a bit - the =
fact that it deals with only one socket confuses me every time, and then I =
go &quot;git grep&quot; and read up on the callers=2E</p><p class=3D"blocks=
" style=3D"white-space: pre-wrap; word-wrap: break-word;">Maybe something l=
ike `it is either called from tunnel_point_to_point() (p2p mode) or with th=
e per-client-context from multi_io=2Ec` or something like that=2E</p></li><=
/ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/mudp=2Ec:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1635/comment/e3384f44_0cc9c3e9?usp=3Demail">P=
atch Set #5, Line 364:</a> <code style=3D"font-family:monospace,monospace">=
p2mp_iow_flags(const struct multi_context *m, struct link_socket *sock)</co=
de></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">let&#39;s move this function to multi_io=2Ec - this is the only pla=
ce it&#39;s called from</p></li><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1635/comment/6767bb95_e5e79af3?usp=3Demail">Patch Set #5, Lin=
e 375:</a> <code style=3D"font-family:monospace,monospace">        if (LINK=
_OUT(&amp;m-&gt;pending-&gt;context) &amp;&amp; m-&gt;pending-&gt;context=
=2Ec2=2Elink_sockets[0] =3D=3D sock)</code></p><p class=3D"blocks" style=3D=
"white-space: pre-wrap; word-wrap: break-word;">I have my doubts about this=
 change - IOW, I am not understanding this at all=2E</p><p class=3D"blocks"=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">We call this funct=
ion in a loop &quot;for all UDP sockets&quot;, and then this part does noth=
ing unless the socket passed in happens to be &quot;link_sockets[0]&quot;=
=2E  This is really hard to understand code - and if link_sockets[0] happen=
s to be a TCP socket, this does nothing at all=2E  No?</p><p class=3D"block=
s" style=3D"white-space: pre-wrap; word-wrap: break-word;">In any case this=
 needs a comment :-) - if I can&#39;t understand it, how can we expect futu=
re maintainers to understand it=2E</p></li></ul></li></ul><p>To view, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1635?usp=3Demail">cha=
nge 1635</a>=2E To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E=
</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1635?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I6b303805a3688b6f6363140c76853a58badecd8f </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1635 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan =
&lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel =
&lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@=
mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: o=
rdex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Comment-Date: Fri, 12 Jun 2026 18:05:08 +0000 </div>
<div style=3D"dis=
play:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Ger=
rit-Has-Labels: Yes </div>

</body></html>
--/LLS3slxIMM=--


--===============6855394019453171980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6855394019453171980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6855394019453171980==--

