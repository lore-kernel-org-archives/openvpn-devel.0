Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF622C53219
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 18:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kACZwtwoWsAOSXOLHa+F+hHFbFDtd0LFdlXfYxLHLXE=; b=ONaAS3Nislbqy5RFKtFSDOWJnP
	iRWnFYr6wl90y6RHfzKF62UO1CyHiQjCzppiiQFOVCXymewmOVeiilboWeKHHwfNKAetPltMMR5Ab
	nusipolQP3vVNyM3N7Yg02UFLoApDp7vNuZ97JHhHe+8KnSGDHAvpI0/btoSL3jvMa5o=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wp9EJ-00069Y-O0;
	Wed, 29 Jul 2026 18:42:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wp9EI-00069R-8Z
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 18:42:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=fr0yFgzd5byG/HNg/eGM++JnSBvdjb1JxLHpO6Kgfko=; b=Ibe1pGFeFX2mecHCytLxiQ74v6
 NZeXcfJEL6ocEk1k4xEUpcZKJJzTNTam1JJ7p+aOxj6ycUd5Yy3R0d8DZ7hM1oXNbjsaXwopVEUzV
 GGWcNmz9XZlEyKth7eyLhGxDklzAagu1d79rccgWW9M5+HHdXDyYy3gwyFVilAr9Jpok=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=fr0yFgzd5byG/HNg/eGM++JnSBvdjb1JxLHpO6Kgfko=; b=W
 e9B5fi4zgQPBvqYmpXLOtgD1SouaRbINb0L30LWfNKrXgHKA20tFfEaJO8KrVtTtkauCkdYS6mIoY
 IyQX1s7/QtJiq9m6SwHg17qm3Wkl2fOGc2+5ojAbOFCtf/DfTYUsArYx3ZZNvfF+4N4D4pa4cGy38
 RBeA7dhFgBADkNwM=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wp9EH-0006hO-SG for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 18:42:07 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4954afac04bso14495205e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 29 Jul 2026 11:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785350520; x=1785955320; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fr0yFgzd5byG/HNg/eGM++JnSBvdjb1JxLHpO6Kgfko=;
 b=QgvTjFiUoHL5QsEqqzT6KoQN0XStXkzlc9+Qx/SGMcfO5BguUKV0KdWH3XXzqn1h+R
 miXFnL5pF2HF/AXeyDG0D4chegb+Wrki39KBpgnV5pIwrDxYkdMQfJaYTNNkpQCRYxq3
 YKqezCRLREaj/QHntEsteFcYTgEEJ7WBbeZsN1GGrpjeRTxR7Fkv0RjCXWK/Q4O3G6mJ
 ozNu/J+7LLe7mnvtu/ws/sdiwXO8V9UNem08QaK/+PlPQDkVGY4KghcghkrG/4fpZQog
 ffC5Vt5SLnInVW14vXpk4agpCnjE8thFpd2GOIZS7dccnc33J8T98mx6mzhWhxvdHhdf
 pSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785350520; x=1785955320;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fr0yFgzd5byG/HNg/eGM++JnSBvdjb1JxLHpO6Kgfko=;
 b=ntEF7upLzjH1Cvpcy5sEVl6UCHDxRNVklD9SxIodWR0j9jm8mFBG+GzeNR4XO8sZQB
 4pR22DRKdsw9SWJVn+18vx0+Cjt7PKmVDkN9p7AUUunTsVYcJ2+jvJTpQi2iUEYydiWW
 wsDhHTikjFwTqWHA8OO6zCpcIBT0rcOdqUCUDmB2ZPXQ10pvLCnhjJb6LoGhVg4/lLTD
 uOAP155Zzt5oid+r+tXFVj0CeChELmyYAoEHB5U1FOoZHRuBMKcfFxpStOeidsBlrnVn
 rXVwKj2ZaFVTcN+iLcuZ0umZgpEzfsI4iEc13cvMq/3BeEpDaW96jYFxijD3xYrbUD7G
 6JHQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpcZX6rR9sv/r0nnZKLOHxoeJU/jg+XpVomtSS7AWN6/eF9CL43BoQHTB5NU3McsJcEDfZECxZiI74SZ/Cs@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwaQeqLO3xFO7JCs+B52HiifLSyVD4EDHEQ8g00i9B68DGqAhp6
 zGa/X6ONDua6gG7R8UYZO+FL6tRjDYHlIiyO9IbNSyeZ9+IoIExjOZHWqPUQM3gvHabBShmEukU
 9e8j3+8uQRY5Y1pqVFAezWcEb/7zdL/TdINHdfodgIxY8h0YGT7k3AELHOWtysTO6yBXgu+xS7R
 sebmj/Dw==
X-Gm-Gg: AR+sD124fcdXFxS+a7tRb85zOvzZGTuogQkAdKa/d9G1xJuqO/2r1K/SEkrnpj55M3k
 rhq8gMQNQiAjbsK3K5YcwWBRFMId9vSZNAkW7h5ahaQCuwnzDeScZMgyFf3ev83jxzaGC5WhWHi
 5MCSLLVf5y+hCzlyvihuNlh3JIGVLf2b63JwqaluPMDPNO196k/R6Si16To5SIjzGFM8e0vrGZD
 5wbazbmqu+DXrMBdAsDJtp7OBZX/2rm3glaiNeHvutQbAtRtD9AzPigej3zA4GItINpKyYRseBx
 Ue5EPyhmg2wugaPvBNTAEF2PEY0Um2zeZNlLX/1DuZIhtX38DX0N0mD8cEKj9tIkXAbpLd+hAOO
 KAfgtstN+t4nKp4bjalcY9WssMjn4WIneUW1/+5zUCHEfgKbWz7fql2yum3hFt++YlJ+pfGUzkH
 8vm1xJia0hEyXqUBmHGQSOB1l3N7u0JhIUhD/IZE8yyoa6h//qu2USOfT8/ocZ0ezCLxfBaQETb
 0o2RuQQN+KNI1TKeVAplbKYI46GIMq7mGDhKDAz/uK8CGjKrEId5pabVqS1CTgCNuJzsgL7jK1S
 HMTB4aenLG7fnsYsViMR/96oPeiZKlnHbBQclhnmZawzc1T+uJY=
X-Received: by 2002:a05:600c:8b2e:b0:495:4dd3:ca97 with SMTP id
 5b1f17b1804b1-496c659f843mr106271555e9.29.1785350519617; 
 Wed, 29 Jul 2026 11:41:59 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6aa392asm9650237f8f.5.2026.07.29.11.41.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 11:41:59 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 29 Jul 2026 18:41:56 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Ie33aea26026e07c860da7d79880cef6b27b7b0e8
X-Gerrit-Change-Number: 1828
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1828?usp=email>
X-Gerrit-Commit: a106971f5cf6983ff862a7c0d8de831cd05b6bb2
X-Gerrit-Comment-Date: Wed, 29 Jul 2026 18:41:56 +0000
In-Reply-To: <gerrit.1785239387000.Ie33aea26026e07c860da7d79880cef6b27b7b0e8@gerrit.openvpn.net>
References: <gerrit.1785239387000.Ie33aea26026e07c860da7d79880cef6b27b7b0e8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MjM5Mzg3MDAwLkllMzNhZWEyNjAyNmUwN2M4NjBkYTdkNzk4ODBjZWY2YjI3YjdiMGU4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <67151777ab6f6b0ce79cd3128e6ddbfbc4c26f92-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wp9EH-0006hO-SG
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Move schedule test
 to a unit test
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7767750567626729621=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7767750567626729621==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="iqUncAMpLAQ="; charset=UTF-8

--iqUncAMpLAQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1828?usp=3Demail )

Change subject: Move schedule test to a unit =
test
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 4:

(3 comments)

File tests/unit_tests/openvpn/test_schedule=2Ec:

htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1828/comment/f593a9d2_556a11ff?usp=
=3Demail :
PS4, Line 91:         ASSERT(e !=3D e->lt);
> We should change t=
hese to proper cmocka asserts, but not sure whether it is better to do that=
 in a s [=E2=80=A6]
Done=2E I think it is okay to in the same commit as thi=
s is a unit test rather than code that is run in production=2E


http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1828/comment/c52a43d2_a945fe3a?usp=3Demail =
:
PS4, Line 168: #else  /* if 1 */
> Does this code still have value? If so=
, then we should integrate it into the test=2E [=E2=80=A6]
Done


http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1828/comment/8118172d_b4beb993?usp=3Demail=
 :
PS4, Line 173:     struct gc_arena gc =3D gc_new();
> gc seems to be unu=
sed?
Done



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
828?usp=3Demail
To unsubscribe, or for help writing mail filters, visit htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: commen=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie33aea26=
026e07c860da7d79880cef6b27b7b0e8
Gerrit-Change-Number: 1828
Gerrit-PatchSet=
: 4
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: f=
lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <frank@lichten=
held=2Ecom>
Gerrit-Comment-Date: Wed, 29 Jul 2026 18:41:56 +0000
Gerrit-Has=
Comments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <fran=
k@lichtenheld=2Ecom>

--iqUncAMpLAQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1828?usp=3Demail">View Change</a></p><p>3 comments:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0;"><p>File tests/unit_tests/openvpn/test_schedule=2Ec:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1828/comment/f593a9d2_556a11ff?usp=3Demail">Patch Set #4=
, Line 91:</a> <code style=3D"font-family:monospace,monospace">        ASSE=
RT(e !=3D e-&gt;lt);</code></p><p><blockquote style=3D"border-left: 1px sol=
id #aaa; margin: 10px 0; padding: 0 10px;">We should change these to proper=
 cmocka asserts, but not sure whether it is better to do that in a s [=E2=
=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Done=2E I think it is okay to in the same commit a=
s this is a unit test rather than code that is run in production=2E</p></li=
><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4=
px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1828/comment/c52a=
43d2_a945fe3a?usp=3Demail">Patch Set #4, Line 168:</a> <code style=3D"font-=
family:monospace,monospace">#else  /* if 1 */</code></p><p><blockquote styl=
e=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Does th=
is code still have value? If so, then we should integrate it into the test=
=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1828/comment/8118172d_b4beb993?usp=3Demail">Pa=
tch Set #4, Line 173:</a> <code style=3D"font-family:monospace,monospace"> =
   struct gc_arena gc =3D gc_new();</code></p><p><blockquote style=3D"borde=
r-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">gc seems to be un=
used?</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1828?usp=3Demail">change 182=
8</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><di=
v itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1828?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie33=
aea26026e07c860da7d79880cef6b27b7b0e8 </div>
<div style=3D"display:none"> G=
errit-Change-Number: 1828 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2E=
net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld =
&lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
Comment-Date: Wed, 29 Jul 2026 18:41:56 +0000 </div>
<div style=3D"display:=
none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-H=
as-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flic=
htenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--iqUncAMpLAQ=--


--===============7767750567626729621==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7767750567626729621==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7767750567626729621==--

