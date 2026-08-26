Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D113C61DBD
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 15:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tlT3UkZfbjhX0KDYeCDd+5n1V6GKRoMT7fdTVMnFZYU=; b=Qij7LAnO1PTcu/VU+gXctn6QkX
	xPDBceM5wbih7PrD8H3q5ra2oozHv5eM7e+IBiR1rGyT15HKXiJuDnS02X+mcp1DiQ9IrzhlyQ/rs
	5WVplnQZiQIR9L7CXlFq5IbkKCJ/e/TwuajSb6eDruvT4NISzKJgw8SHCfp5Rl2vjah8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzFRn-0007Qb-H3;
	Wed, 26 Aug 2026 15:21:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzFRm-0007QG-1B
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 15:21:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=cmJAvvfRShjGUtDE5Z+TZnMrRSBQiqdiMdsfuXB6GCU=; b=JqeHuWyK60D1nKG1t7RRcIiXh+
 1B9TxOR3GzWFHBnVtQOvoWDWi72iwgR4w2Okn+Qjf6E6/P2GFWKgh1WrU7dNVUrIzK/GIvx+Mh0cW
 FWjFrX2meRDXG5yDcnk2plFq+fwHN9NAtMwCJlrGxWoQIshY6Ls/XehFQIyUiOAGT0Vw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=cmJAvvfRShjGUtDE5Z+TZnMrRSBQiqdiMdsfuXB6GCU=; b=Z
 pmmiy0dLMM6MCOTEPlGQ9hOqhQfC3sgLtzLTyUwOs+clqGxEGsLIID8UYTgv0miNLBOfYFE5YuMTU
 98NTkc1adVef7ccmOHtxSneTZEESS+ehhsTAqUC5hbrdHBCkJm0vvJHMhdloVSHMcOm3n5BYbH4ln
 eFSSgxObxW/LzeRI=;
Received: from mail-ed1-f41.google.com ([209.85.208.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzFRM-00077n-KC for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 15:21:26 +0000
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-6a1542cdb53so1293494a12.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 26 Aug 2026 08:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787757678; x=1788362478; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cmJAvvfRShjGUtDE5Z+TZnMrRSBQiqdiMdsfuXB6GCU=;
 b=DE0ISOeAXkiGTI+fnUhE8WF2dmJ6f5QqmnVXh7lJ2Tnx/5a5vywvRNrfe1e6/HxlFf
 VF/2wiOZ7bOV7W2sBwhP/e5zDMZSsCP0gJVNRK8FyPe3v+rOa7c0gyVxi0rq58KrGfxK
 NvGMR2TmZnI6rancsiG8pXqGrzptHGj23lmeAKs74xQxY4ObbNK1niGhz7SOFTM6+Tr3
 OyAeAHLo/0m7f6RpSuNc9wL6lUDWWobQwfbxSZQZy4gKD4zF1HPNqGLxytdXDJ3xyZFR
 hCKzSPwDuzVpLFq520JDJhaqKnav0uDBj/kjRnEUS9zQozC6tVeBd0bIp5mXKBCwV6VC
 tKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787757678; x=1788362478;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cmJAvvfRShjGUtDE5Z+TZnMrRSBQiqdiMdsfuXB6GCU=;
 b=pxL0GTA/uvl8DjlaUd2zmsrTifBxr+OV6vDINZpOTe3SlETC9fiMs+tpGrdQF8QVjf
 UmaR9fM+6Lx2a4fk5BciIUZAUa/7CTJBZCIo9R+MTBBw2xxvGE4c30FZP5HgqXLnz0Ym
 S0ESmlE5rwRtf4/2clAKjKGLNRU7dw2wncub3zfDezWGTmsWeHR/zvjphwZD9jKnYYPE
 W4ndtfK8evbazDSSvsB3t9YBgNGkoW+RYmJaseAkSutSVAgx6HGLrD7U48VgKPn87hrD
 Jbdc1TkbozfH2+pa8CzfCZgckpoTIkGLsuYlT6FMO6+f72CxGV0X/8oehWzh6PTY8uc/
 I+7w==
X-Forwarded-Encrypted: i=1;
 AHgh+RpslkY7cGaJfUutvV8bCY/JVwrGFCtZV2c8Wpi9z5Vyfm+Qe1J+ywOSLfppfwx4x/0yu+tXin/66vztFAve@lists.sourceforge.net
X-Gm-Message-State: AFuF++kdzZhhQhRog/0MsUWFKeV2/Utyg1o3ire0Tkt+EerG7zrxnhNV
 Fnc4oXFg1K8ju0Paj62rZVvKdn06ymoDJvKaw+zfJhjV0OriODleISd93n0tZD6s112lUZl0Xqt
 KsRHMgZWT8yOpkMfSKbAW2/KOYoZb0uP+eALZ9NdSBt2tlJptFqsDV+1jBpJvm3lY35ht
X-Gm-Gg: AR+sD11p9EUpMD2iiPONQoOWcy0Ul3Yo32y0H7IIh0WdfI0IufBnUCg70rb1/RlXkT3
 8f4NGNQNP4LdqxCozC1p0etlcp0y3QEOTJD0Oeom7AV7RYnkVdfvOCjPEWbD45jTJ/tbCg89W0+
 sjWLVp3KISb6AJg6hd6AKkJn6Vh7gsb861y0z9sWb41UH+X6P3ZLH6Ol5+NDnyexi/xVANnnnQa
 4ggjq/peEZfcza/setLRkvMWPkiNF9Ll6vJZE/fp8p8lWhFP6loFubjOvsLItARRtnafSAfkuYb
 anIuJV09rPC/xoPsKa2Q3SSfIED5G6iVJ19V5akKrRrMIq9uUej3rrhy7Ptb1KIvWndyc0b6lbd
 ck4vYlgvEJavxPQPsXjBdbqQnMcPWPxYPxRGU4uI4BUKu0S6TT9mhhmvtF8skgHetPBMG/Q3x4o
 QHzML8y25e06vXuUeN+cJVNkeeIDUolRWCQZAaD/zBlVvoKvvRX3ZwMDIVq3FdAh+F/ecL1U4UM
 kbmbcUEaE4AV751F18dz8Sc5Aq+MkR69vPMLzL9pJjfZ4aUolKJQk/NbhR/w99klPBu8UTa69kg
 jVTvaap9yCzyQC74cMRbTpewLL88HOTnSOcpNKihMj4NbOdNpHc=
X-Received: by 2002:a05:6402:254c:b0:69f:b1d3:3903 with SMTP id
 4fb4d7f45d1cf-6a5df5e323amr8439530a12.8.1787757677868; 
 Wed, 26 Aug 2026 08:21:17 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5dea83a30sm4057442a12.15.2026.08.26.08.21.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 08:21:17 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 26 Aug 2026 15:21:14 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea
X-Gerrit-Change-Number: 1855
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1855?usp=email>
X-Gerrit-Commit: 08677f114c3ac26073656d1be4ba3ce62e3583fa
X-Gerrit-Comment-Date: Wed, 26 Aug 2026 15:21:14 +0000
In-Reply-To: <gerrit.1787327336000.Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea@gerrit.openvpn.net>
References: <gerrit.1787327336000.Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLklmZGQyMTIyYTNlNjBjZGIxMWNjOWRmNjc1NzBhYjU2MjhiZmNkZWVhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b7809a1fc3bbf97d3cddfe2c2b4a8ae75a579a53-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzFRM-00077n-KC
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add helper method to
 extra a field from a buffer
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
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5761769155789671775=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5761769155789671775==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ExGzKCV5XWM="; charset=UTF-8

--ExGzKCV5XWM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, razvanc=2E

plaisthos has post=
ed comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1855?usp=3Demail )

Change subject: Add helper method to extra =
a field from a buffer
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 6:

(8 comments)

Commit Message:

http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1855/comment/30e8d51d_4a25b93d?usp=3Demail :
PS6, L=
ine 7: Add helper method to extra a field from a buffer
> Typo: "extract"
D=
one


File src/openvpn/buffer=2Eh:

http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1855/comment/07419209_4e236540?usp=3Demail :
PS6, Line 2247:  * Extract =
a field from buf that end with the \c sep character=2E The
> Typo: "ends"=
=2E
Done


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855/comment/b545da4b_=
f16087b2?usp=3Demail :
PS6, Line 2255: #endif /* BUFFER_H */
> Probably wan=
t a newline between the function name and `#endif`=2E
Done


File src/openv=
pn/buffer=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855/comment/b669=
dcc3_014be768?usp=3Demail :
PS6, Line 1389: extract_field(struct buffer *bu=
f, char sep, struct gc_arena *gc)
> Just a nitpick, and possibly wrong but =
just in case you think it's worth a think: most other functio [=E2=80=A6]
D=
one


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855/comment/0ff47b8b_5240d=
8dc?usp=3Demail :
PS6, Line 1391:     const uint8_t *seppos =3D memchr(BPTR=
(buf), sep, buf_len(buf));
> `BPTR(buf)` seems capable of returning `NULL`,=
 so should we check we're not passing `NULL` to `memch [=E2=80=A6]
Done


h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855/comment/800b7982_7b1d4015?usp=
=3Demail :
PS6, Line 1400:     strncpy(field, BSTR(buf), field_len);
> We a=
lready know the length (don't need to look for `NUL` characters anymore), s=
o `memcpy(field, BPTR [=E2=80=A6]
Done


http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1855/comment/a731563a_5dbba3a2?usp=3Demail :
PS6, Line 1403:     bu=
f_advance(buf, (int)field_len + 1);
> The `(int)` cast is unnecessary, `buf=
_advance()` already takes a `size_t` parameter there=2E
That happens when a=
 patch sits almost 3 years in a branch =2E=2E=2E=2E That only changed last =
year=2E


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855/comment/1347b60a_f=
b12a568?usp=3Demail :
PS6, Line 1405: }
> Minor nitpick: this lost the trai=
ling endline=2E
Done



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1855?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageT=
ype: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id=
: Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea
Gerrit-Change-Number: 1855
Gerr=
it-PatchSet: 6
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
CC: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel=
@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerr=
it-Attention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Attention: razvanc <ra=
zvanc@mailbox=2Eorg>
Gerrit-Comment-Date: Wed, 26 Aug 2026 15:21:14 +0000
G=
errit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: razvanc <=
razvanc@mailbox=2Eorg>

--ExGzKCV5XWM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, razvanc=2E </p>
<p><a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1855?usp=3Demail">View Change</a></p><p>8 comment=
s:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; p=
adding: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom:=
 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855/comment/30=
e8d51d_4a25b93d?usp=3Demail">Patch Set #6, Line 7:</a> <code style=3D"font-=
family:monospace,monospace">Add helper method to extra a field from a buffe=
r</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10=
px 0; padding: 0 10px;">Typo: &quot;extract&quot;</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p=
></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/bu=
ffer=2Eh:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margi=
n: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855/comment/07419209_4e236540?usp=
=3Demail">Patch Set #6, Line 2247:</a> <code style=3D"font-family:monospace=
,monospace"> * Extract a field from buf that end with the \c sep character=
=2E The</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; marg=
in: 10px 0; padding: 0 10px;">Typo: &quot;ends&quot;=2E</blockquote></p><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Do=
ne</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855/co=
mment/b545da4b_f16087b2?usp=3Demail">Patch Set #6, Line 2255:</a> <code sty=
le=3D"font-family:monospace,monospace">#endif /* BUFFER_H */</code></p><p><=
blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0=
 10px;">Probably want a newline between the function name and `#endif`=2E</=
blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wra=
p: break-word;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"=
><p>File src/openvpn/buffer=2Ec:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855/comment/=
b669dcc3_014be768?usp=3Demail">Patch Set #6, Line 1389:</a> <code style=3D"=
font-family:monospace,monospace">extract_field(struct buffer *buf, char sep=
, struct gc_arena *gc)</code></p><p><blockquote style=3D"border-left: 1px s=
olid #aaa; margin: 10px 0; padding: 0 10px;">Just a nitpick, and possibly w=
rong but just in case you think it&#39;s worth a think: most other functio =
[=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-w=
rap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1855/comment/0ff47b8b_5240d8dc?usp=3Demail">Patch S=
et #6, Line 1391:</a> <code style=3D"font-family:monospace,monospace">    c=
onst uint8_t *seppos =3D memchr(BPTR(buf), sep, buf_len(buf));</code></p><p=
><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding:=
 0 10px;">`BPTR(buf)` seems capable of returning `NULL`, so should we check=
 we&#39;re not passing `NULL` to `memch [=E2=80=A6]</blockquote></p><p clas=
s=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</=
p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bot=
tom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855/commen=
t/800b7982_7b1d4015?usp=3Demail">Patch Set #6, Line 1400:</a> <code style=
=3D"font-family:monospace,monospace">    strncpy(field, BSTR(buf), field_le=
n);</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: =
10px 0; padding: 0 10px;">We already know the length (don&#39;t need to loo=
k for `NUL` characters anymore), so `memcpy(field, BPTR [=E2=80=A6]</blockq=
uote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1855/comment/a731563a_5dbba3a2?usp=3Demail">Patch Set #6, Line 1403:</=
a> <code style=3D"font-family:monospace,monospace">    buf_advance(buf, (in=
t)field_len + 1);</code></p><p><blockquote style=3D"border-left: 1px solid =
#aaa; margin: 10px 0; padding: 0 10px;">The `(int)` cast is unnecessary, `b=
uf_advance()` already takes a `size_t` parameter there=2E</blockquote></p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
That happens when a patch sits almost 3 years in a branch =2E=2E=2E=2E That=
 only changed last year=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1855/comment/1347b60a_fb12a568?usp=3Demail">Patch Set #6=
, Line 1405:</a> <code style=3D"font-family:monospace,monospace">}</code></=
p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padd=
ing: 0 10px;">Minor nitpick: this lost the trailing endline=2E</blockquote>=
</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1855?usp=3Demail">change 1855</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifdd2122a3e60cdb11cc9d=
f67570ab5628bfcdeea </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1855 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div =
style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@green=
ie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-de=
vel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: razvanc &lt;razva=
nc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Dat=
e: Wed, 26 Aug 2026 15:21:14 +0000 </div>
<div style=3D"display:none"> Gerr=
it-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: =
No </div>
<div style=3D"display:none"> Comment-In-Reply-To: razvanc &lt;raz=
vanc@mailbox=2Eorg&gt; </div>

</body></html>
--ExGzKCV5XWM=--


--===============5761769155789671775==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5761769155789671775==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5761769155789671775==--

