Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3434C5DF74
	for <openvpn-devel@archiver.kernel.org>; Tue, 18 Aug 2026 14:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XxCSt2xIHqvHnkREKjybPPz9KlCYGYfp9ZkpPlW8v/U=; b=MwhN+5TzgcXxk4dBFrI8TA6h3Z
	wh/HD1Ol3CgF1TtSCvGnAeuyX3QF/jYZKIBaF3aQSyIhVK23ZCLYXm3dHyowTtS3SEcVzU4fU1wzc
	ZELewiC/g5dpMcIRJWOzg9WF7ZKPCUjNkCQqdpETFkhP7MsCrWNWGY7+TKGX59gdtDjA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwLAD-0008GN-28;
	Tue, 18 Aug 2026 14:51:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwLA8-0008GC-9U
 for openvpn-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 14:51:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=DFmJOC2zXVtAolU6aZNoEslde3kKmK7XoCeSB33Gnzw=; b=VI34wox7SQpWem7uwXryenEal3
 qD4/67a8lxqSucDbCXTi+Q7O3nxpVFsKD/Xos+3kKE5+3W5sVl7lZYnVF37hTtkMyJAeJBatrsDp2
 GZ9EmTiNXDWNMsUc2+Rn/PDQ5eRkiCoPVZbR3KloFUzkXlPo2WoWhGY0XxN5UJw1He20=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=DFmJOC2zXVtAolU6aZNoEslde3kKmK7XoCeSB33Gnzw=; b=T
 uNmMq9e8LiW9pDElK/Nibhdq8Si3KM1QZ9WaAvVH6K39taI0qB5vPGWN8u0tQiF8B8wqqtNbTlrZi
 ORovv5gyAfVoJ8VE1GRl8/AdWxIqaEPgIaPu8LvIHdv/r294LAvUzoNf9byHYHd/uyy9iQoI35h/d
 yd4SGKZupMJbfpnE=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwLA7-0007L0-9S for openvpn-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 14:51:36 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-495757ccbc1so43556815e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 18 Aug 2026 07:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787064689; x=1787669489; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DFmJOC2zXVtAolU6aZNoEslde3kKmK7XoCeSB33Gnzw=;
 b=P6c9ySmOjO6vvxe5Sk0SC24ZjzSLX7ewrpj11HJKlOAPyQ6bd/iFCylnFGbdQSBY+8
 3GmsfCX4586lzIqFt55Fp/xAbZ687Q6B5xWWmWv2qyiWjD9qgzZHeeEnmDlAcTabbiJt
 931RQFEt8PX5zdFDy7zd4GluiNXy6XSmqugWlMNEE/DXGODo9n2i3v3kIbMGbqI54JTw
 IF/MFmUYIHPLqdVhXtKy8/bXcXH6MmktaxUb+oMwCczvZyioqWU5tVzShjIg04lX5xAu
 eFwemCNt+P3MmF41hCPG+xPldjn39+E20syqEYQgbtJGbJiyvNRhh/TgatJmlkU5+Uvy
 6C8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787064689; x=1787669489;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=DFmJOC2zXVtAolU6aZNoEslde3kKmK7XoCeSB33Gnzw=;
 b=kbklooKVKDwgxRlX8HW6gUUDn+5oTtAtAfVNdLEdq4SmUEGG3rr28kQ9MdSsFvj/O+
 l8quENYXFNUYCZ5h4VttOy+TTAtBrgRdbo0GrU609ZcBJ+J2hEwsu/i5LwFeKsNV1v7u
 4MKs0gE/X55WzROXkkVYyzxQlgW5Y+8AgFT4sm42R8mOKCurRnONgm+IGCvjeLSIT+T+
 FGPi6hwVGhNCgk/3/OgK6+bniMMgbEn0erm1qLledD+NrbEiItjnlOc1O8vaN9z27lT/
 /I7kuxScKdeBG36FowUSm2iarI8BjyUFbP3MKKF1tXSIPq55oVFrhbgno5Oy4vYkqRea
 nNgg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrwnqfd0Tmp7TqvA1hJbeaGbufOrO3VOW/+bHwRBbtlz13ry3WYGZzibZuI2GXQTKs7Ozv++2cZz+1csTYL@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yx3TQrJ4JxKjv6QONetd1nacJhmF7b6DMziYA7Fj0QggQazk7x1
 yoBtEgd7g8eFxxmvZdj73RgFIA2ayA3K8w2b8xK8Pt3Vvzc5xRiMFFpAvnAiBKKpytqA1bqM2o1
 AU80Nvn7fUOhj8Hd7i4UsbBTP9eiHCBU3RjfOb2W3ILBV6aj0+drrXplCyojH/BSLM/1R
X-Gm-Gg: AR+sD13X2pHvSFWU328LGeM/BuGTuTupElpix9idhRwUwLaW4xfdY8fZQ7ye8pwZojb
 WX8KiHBbsFVnFh0ZnjmIGLWDMxJEd5uzYPytsh3b0Es2eLROngITguY4d7dZNX9ChZUcArKbnD+
 wTltcU57x134Mag6UiB/zgbZFWL2VYCQwCKkyeFkzx1XlX5Jqv20p1pyF6gb1ZX326rhIcYkYid
 f3o1AWzhVW28Kjnfjrg1dlMCaomi9jOxaDCOeWoZ3djPE9XyNxYabu8UFC1EXiYIWAC9pZ18XOR
 kObuOK9X/1gl/Q72MG+4WjkKeS+LjlqT/zRfsEO6zfyePMLYiO5Ww4StBg9v7rYrNtPRJwY3zZn
 03pXFORv6Cdv2TsKAuRio0JZnTDjWh3cSGvQvm/PJAJ34qr5dMSS87336RRPYZpknfxE/tlhLtW
 MQXjWSo6C1tuoDcdZH0umLrh12g5UcwwP1oKAqy/giy0yEkq7J7VW6z43CnmWvfzVlW9ofT7hcQ
 5Yr8WWQZc2FeHeyXrKmFEB8xHFCaDFdxFiC3/FzcwGbDF892w2yp07gvyVixaEuqwGW4JnOKX9V
 V9Ae7RnilhviI2bpDwg87b91VAu25kvv2KbCHqu+U/PWhvAk0+g=
X-Received: by 2002:a05:600c:6290:b0:495:4689:1e98 with SMTP id
 5b1f17b1804b1-4998e074297mr492608585e9.10.1787064687657; 
 Tue, 18 Aug 2026 07:51:27 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999d0fb867sm158710405e9.10.2026.08.18.07.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 07:51:27 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 18 Aug 2026 14:51:25 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac
X-Gerrit-Change-Number: 1407
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1407?usp=email>
X-Gerrit-Commit: 8535abbeca3e048d7a90af0e14bd5d812649fe86
X-Gerrit-Comment-Date: Tue, 18 Aug 2026 14:51:25 +0000
In-Reply-To: <gerrit.1764168347000.Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac@gerrit.openvpn.net>
References: <gerrit.1764168347000.Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzY0MTY4MzQ3MDAwLkliMDU4NGU4NzI4NzAxY2NhMTBhYzU2NzVjOWNiMGU2ZjVlYjkwMWFjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <395acd3e87a392ce7a7f99e3c9eb02632d93a421-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwLA7-0007L0-9S
Subject: [Openvpn-devel] [M] Change in openvpn[master]: packet_id: Avoid
 conversion warnings
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3681739324458842106=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3681739324458842106==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mitDxcglR9o="; charset=UTF-8

--mitDxcglR9o=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1407?usp=3Demail )

Change subject: packet_id: Avoid conversio=
n warnings
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 8:

(2 comments)

File src/openvpn/circ_list=2Eh:

http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1407/comment/2e08c787_250f00f9?usp=3Demail :
P=
S8, Line 63:         const size_t so =3D sizeof(list_type) + sizeof((dest)-=
>x_list[0]) * (size); \
> Strictly speaking, if `size` is `int` this still =
breaks `-Wsign-conversion`, but we're using `-Wno-s [=E2=80=A6]
maybe then =
we could just have an explicit cast to size_t here?


File src/openvpn/circ=
_list=2Eh:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1407/comment/492532d5=
_ddbc4d93?usp=3Demail :
PS7, Line 51:                (obj)->x_cap)
> This i=
s wrong=2E [=E2=80=A6]
So I would rather than have x_sizeof removed if we r=
eally do not use it appart from a debug statement as I don't think mixing t=
he types is good here=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1407?usp=3Demail
To unsubscribe, or for help writing mail fil=
ters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mess=
ageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chang=
e-Id: Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac
Gerrit-Change-Number: 1407
=
Gerrit-PatchSet: 8
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Ger=
rit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razva=
nc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2E=
sourceforge=2Enet>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>=

Gerrit-Comment-Date: Tue, 18 Aug 2026 14:51:25 +0000
Gerrit-HasComments: Y=
es
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@rfc25=
49=2Eorg>
Comment-In-Reply-To: flichtenheld <frank@lichtenheld=2Ecom>
Comme=
nt-In-Reply-To: razvanc <razvanc@mailbox=2Eorg>

--mitDxcglR9o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1407?usp=3Demail">View Change</a></p><p>2 comments:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0;"><p>File src/openvpn/circ_list=2Eh:</p><ul style=3D"list-style: no=
ne; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
407/comment/2e08c787_250f00f9?usp=3Demail">Patch Set #8, Line 63:</a> <code=
 style=3D"font-family:monospace,monospace">        const size_t so =3D size=
of(list_type) + sizeof((dest)-&gt;x_list[0]) * (size); \</code></p><p><bloc=
kquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10p=
x;">Strictly speaking, if `size` is `int` this still breaks `-Wsign-convers=
ion`, but we&#39;re using `-Wno-s [=E2=80=A6]</blockquote></p><p class=3D"b=
locks" style=3D"white-space: pre-wrap; word-wrap: break-word;">maybe then w=
e could just have an explicit cast to size_t here?</p></li></ul></li><li st=
yle=3D"margin: 0; padding: 0;"><p>File src/openvpn/circ_list=2Eh:</p><ul st=
yle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1407/comment/492532d5_ddbc4d93?usp=3Demail">Patch Set #=
7, Line 51:</a> <code style=3D"font-family:monospace,monospace">           =
    (obj)-&gt;x_cap)</code></p><p><blockquote style=3D"border-left: 1px sol=
id #aaa; margin: 10px 0; padding: 0 10px;">This is wrong=2E [=E2=80=A6]</bl=
ockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">So I would rather than have x_sizeof removed if we really do =
not use it appart from a debug statement as I don&#39;t think mixing the ty=
pes is good here=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1407?usp=3Demail">change 1407</a>=2E=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"http://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsc=
ope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1407?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"=
display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:non=
e"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bran=
ch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib0584e872=
8701cca10ac5675c9cb0e6f5eb901ac </div>
<div style=3D"display:none"> Gerrit-=
Change-Number: 1407 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 =
</div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@li=
chtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: pl=
aisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esour=
ceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: fli=
chtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Comment-Date: Tue, 18 Aug 2026 14:51:25 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Re=
ply-To: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Comment-In-Reply-To: flichtenheld &lt;frank@lichtenheld=2Ecom=
&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: razvanc &lt;r=
azvanc@mailbox=2Eorg&gt; </div>

</body></html>
--mitDxcglR9o=--


--===============3681739324458842106==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3681739324458842106==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3681739324458842106==--

