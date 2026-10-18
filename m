Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EDFBCCF2C9
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 19:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mgHI8NWHPBlsrua7MarWRLXYPRcp8lzuZ8NdUQ57ItU=; b=TUBQ/biNrdpAwvzhBtNu1uiD+9
	MPnn/E1Qg9RBf3JNjY754bze05KMeA2mJUCrw4dY0s6qeF4Oij1sqz3DJHHS0B1CD4ZxZs7yE20Q9
	ZZhiJsMtuULe7B6/2JU+ml8x8ORt+u5jwdEPOwCO6iO6yjgrhE23AdvtJOaDBs1WDrvk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIX1M-0000sx-VD;
	Sun, 18 Oct 2026 19:58:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIX1L-0000sq-P9
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 19:58:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=5Q+mDtN7Ei9FcR6RciRBhCEhlQJCs3cSPcB2mMqH26s=; b=DB7+uIcKmTOC9ozFJHchu9scmN
 PSkqa8E3PzYcChbnpAci2Jzz7DszLeZ/VOHHM85GZByMesYXFU5Z1fUL7zbpSHkFqTDEBkzpcds2L
 GGd3l/D52FNTNv6EojkR0yHgLpFtqr8cRYBKtvlR0BdxabQxCWg/0uqhr4Aon75tzQVw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=5Q+mDtN7Ei9FcR6RciRBhCEhlQJCs3cSPcB2mMqH26s=; b=R
 swGZNXmVGng2buBE9aRVPjvPj4knjOaNU4oKTUmVR/vTtQMEoyTh/GVbVFnDxjYuvoj4J9HQRLYqt
 U43b+PXiDQvVdHLm3fj0JFlD29aJ/TWnEEt8tmtjCgi3uF3GrBfFHdmaaEQmHOoprmk7mIywt2y3S
 1fEYbanrBzlCHXEA=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIX1L-0006aD-8R for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 19:58:16 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48df54150dfso1003164f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 12:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792353489; x=1792958289; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5Q+mDtN7Ei9FcR6RciRBhCEhlQJCs3cSPcB2mMqH26s=;
 b=BPzQdy5IGJAFnEcGQqrKCHFwdV5pr4J13akRZiG/uPX64dm2icikHESRr8A0D7kLRP
 aCgbfVElGK3FJR7n/pLyUOxj/WH1ge4h+aX2L25Qx9MpZphTljyBdKUaPTVXd8pjkmTU
 5LgyOpFSO+7BVdxT81iNhnC2zmkVpOkYhW9WliBqOR62TuCA8bb7jCuDMGUsBNHA/kpK
 tIcQ9/6/i3ZjLSfz0Ycipf7FORI5GKKwkTZlydLlkom8NKJgCVt35r1Tw+E02/S7wv5M
 XHbyvXIakxE1a6Vx/UhoWbrjNvZU576Um6Bqxztw/7WUMkrDGPor+3mj5lFydNPvhBtx
 0Z7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792353489; x=1792958289;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5Q+mDtN7Ei9FcR6RciRBhCEhlQJCs3cSPcB2mMqH26s=;
 b=Rd3BXcJljKXLN+G01Og1gyUEwxNo5is5HwGo6y1gk3UZfQSrapY5iSUMoi1yIgxyo4
 roJgMxObNfXZJviMkJuGV/nqk76h0HrUP3vSD6mc2xvBFFwGCTqLLK+N5rfD+KyOhC12
 VrIlOOqJ/QSnFSvwJWUsXhoE79rhGrmwqKpEQi14deLubuLVCNrrqZ2SCcQwssG7+aO3
 wxtnQD+7OeD5+Q/dLzWZUU6gq6+snY0Pi8gl3H9WvKsRArOlTC+IQPzDrQictodx7vJu
 C2bDP9gx6WwDalMysxR/iDQd36jjFzV//t8h9dql/GannJIQ56FRUtWYK+8g/vHr2aA1
 TicQ==
X-Gm-Message-State: AFq9FYJKtBOHT6FPiYAk/7r/Hi2GaoVJMjnFElE2wGIZIDS7BKLBBTuc
 yHvwenCvTNMJb5/TL9UMb7khA2PQ6DX7VDIV13V+2te/90kcPrq5Dv0eRwQ+n2RNW4lZ/jzYeFc
 /z1ydU7JEC/JI0FyeD4JfVnD51kcODmenlBvT9rGO+8HpBffjwEpUlKxDcB7/AQSGVggL
X-Gm-Gg: AYBFou36ixoLcZqExCbAs7bIcrl2yZkTG7vxBf8ZNyf4GKbqACv/21wEm0QlPn2sN15
 7RxWwuZpTKNX5TaZdirquJkuDj3WYpEXoIqxoa9KMlkjYSKWpdxb1h9sZpJ1vr/TWLmn49v7Gjo
 LO8tXUkuhEFC7CxlwoI3vpBN2t062aOmSxlSmRhq1IMYvWE0YJn7nsPy3+psKuraVgo9MH4VLbu
 dn+w0rxY/QaAdUkSEFNR3zuQCPmb6vz0XKzwGchNSct1NdIm/7wFHic4Rusz8+JLx60JjBOcqSz
 rrlNmi2hmVGKQtLSdrQOxeNrD6zrMpnhi+h6axxXM+Hs33L+GZ7w9Dr05dF+VszG0MGWxr3QiER
 TaayKTTWywJP5CtuWUy6wbmXLWZOszVyKSl172FOV7ckLYLgMGec1/A85ntNDvWpNe/kC98d2Pc
 G55l98sp/Y17NL4kQJE+ksz/I5GnSIcp4uXRyV1afAHyrUbmnoghPwtNlFDla7pM4s7tlPZx3VT
 tr+FMTXnuDDleYgVpAIe6QwVc1Pr7+HRimmORH8Fvgpm2iQaaoRqO/H7DffZ0S5VVxAyLIUtAdY
 3K1dfleCtiutTgN03zHgDGRqwE5HXTQvYbuy7FDZYICnStZsJ29mLU1FvDJwTWKg9aLAw+U=
X-Received: by 2002:a05:6000:29ca:b0:48d:f6d2:9c88 with SMTP id
 ffacd0b85a97d-48e07f9eaa7mr7916222f8f.47.1792353488398; 
 Sun, 18 Oct 2026 12:58:08 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4ee183sm18490481f8f.29.2026.10.18.12.58.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 12:58:07 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 19:58:06 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I33e55d88d561393ebfbc73a995f700056e19a436
X-Gerrit-Change-Number: 1628
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1628?usp=email>
X-Gerrit-Commit: 8f3f66f79264acbd13d539bdcec1c12e24e2e7f7
In-Reply-To: <gerrit.1776267299000.I33e55d88d561393ebfbc73a995f700056e19a436@gerrit.openvpn.net>
References: <gerrit.1776267299000.I33e55d88d561393ebfbc73a995f700056e19a436@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc2MjY3Mjk5MDAwLkkzM2U1NWQ4OGQ1NjEzOTNlYmZiYzczYTk5NWY3MDAwNTZlMTlhNDM2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <99cb76928e447b479e89ebbb0f9c4833479a49b5-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIX1L-0006aD-8R
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: sitnl: use
 RTM_SETLINK for updating existing interfaces
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5941348015451701633=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5941348015451701633==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gaiv/qrEciE="; charset=UTF-8

--gaiv/qrEciE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by Gianmarco De Gregori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1628?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Arne Schwabe


Change subject: sitnl: use RTM_SETLINK fo=
r updating existing interfaces
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

sitnl: use RTM_SETLINK for updating existing interfaces=


RTM_NEWLINK is primarily intended for link creation and initialization,
w=
hile RTM_SETLINK is the canonical interface for modifying attributes of
an =
already existing link=2E

Even though the kernel may accept RTM_NEWLINK for=
 updates, using
RTM_SETLINK better reflects the intended netlink semantics =
and follows
the dedicated update path in the kernel=2E

This makes the beha=
vior more explicit and consistent with how link
configuration changes are e=
xpected to be performed=2E

Change-Id: I33e55d88d561393ebfbc73a995f700056e1=
9a436
Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Acked=
-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1628
Message-Id: <20261011202439=2E15128-1-ger=
t@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@l=
ists=2Esourceforge=2Enet/msg39831=2Ehtml
Signed-off-by: Gert Doering <gert@=
greenie=2Emuc=2Ede>
---
M src/openvpn/networking_sitnl=2Ec
1 file changed, =
3 insertions(+), 3 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:2=
9418/openvpn refs/changes/28/1628/2

diff --git a/src/openvpn/networking_si=
tnl=2Ec b/src/openvpn/networking_sitnl=2Ec
index bbdfcb7=2E=2E0c99d38 10064=
4
--- a/src/openvpn/networking_sitnl=2Ec
+++ b/src/openvpn/networking_sitnl=
=2Ec
@@ -691,7 +691,7 @@
 
     req=2En=2Enlmsg_len =3D NLMSG_LENGTH(sizeof=
(req=2Ei));
     req=2En=2Enlmsg_flags =3D NLM_F_REQUEST;
-    req=2En=2Enl=
msg_type =3D RTM_NEWLINK;
+    req=2En=2Enlmsg_type =3D RTM_SETLINK;
 
    =
 req=2Ei=2Eifi_family =3D AF_PACKET;
     req=2Ei=2Eifi_index =3D ifindex;
=
@@ -727,7 +727,7 @@
 
     req=2En=2Enlmsg_len =3D NLMSG_LENGTH(sizeof(req=
=2Ei));
     req=2En=2Enlmsg_flags =3D NLM_F_REQUEST;
-    req=2En=2Enlmsg_=
type =3D RTM_NEWLINK;
+    req=2En=2Enlmsg_type =3D RTM_SETLINK;
 
     req=
=2Ei=2Eifi_family =3D AF_PACKET;
     req=2Ei=2Eifi_index =3D ifindex;
@@ -=
758,7 +758,7 @@
 
     req=2En=2Enlmsg_len =3D NLMSG_LENGTH(sizeof(req=2Ei)=
);
     req=2En=2Enlmsg_flags =3D NLM_F_REQUEST;
-    req=2En=2Enlmsg_type =
=3D RTM_NEWLINK;
+    req=2En=2Enlmsg_type =3D RTM_SETLINK;
 
     req=2Ei=
=2Eifi_family =3D AF_PACKET;
     req=2Ei=2Eifi_index =3D ifindex;

-- 
To =
view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1628?usp=3Demail
To =
unsubscribe, or for help writing mail filters, visit https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Proje=
ct: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I33e55d88d561393ebfbc73=
a995f700056e19a436
Gerrit-Change-Number: 1628
Gerrit-PatchSet: 2
Gerrit-Own=
er: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne =
Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-deve=
l@lists=2Esourceforge=2Enet>

--gaiv/qrEciE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by Gian=
marco De Gregori=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1628?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Arne Schwabe</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">sit=
nl: use RTM_SETLINK for updating existing interfaces<br><br>RTM_NEWLINK is =
primarily intended for link creation and initialization,<br>while RTM_SETLI=
NK is the canonical interface for modifying attributes of<br>an already exi=
sting link=2E<br><br>Even though the kernel may accept RTM_NEWLINK for upda=
tes, using<br>RTM_SETLINK better reflects the intended netlink semantics an=
d follows<br>the dedicated update path in the kernel=2E<br><br>This makes t=
he behavior more explicit and consistent with how link<br>configuration cha=
nges are expected to be performed=2E<br><br>Change-Id: I33e55d88d561393ebfb=
c73a995f700056e19a436<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@=
mandelbit=2Ecom&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1628<br>Mes=
sage-Id: &lt;20261011202439=2E15128-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: h=
ttps://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg=
39831=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;=
<br>---<br>M src/openvpn/networking_sitnl=2Ec<br>1 file changed, 3 insertio=
ns(+), 3 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eop=
envpn=2Enet:29418/openvpn refs/changes/28/1628/2</pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/o=
penvpn/networking_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec</span><br><s=
pan>index bbdfcb7=2E=2E0c99d38 100644</span><br><span>--- a/src/openvpn/net=
working_sitnl=2Ec</span><br><span>+++ b/src/openvpn/networking_sitnl=2Ec</s=
pan><br><span>@@ -691,7 +691,7 @@</span><br><span> </span><br><span>     re=
q=2En=2Enlmsg_len =3D NLMSG_LENGTH(sizeof(req=2Ei));</span><br><span>     r=
eq=2En=2Enlmsg_flags =3D NLM_F_REQUEST;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    req=2En=2Enlmsg_type =3D RTM_NEWLINK;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    req=2En=2Enlmsg_type =3D RTM_SE=
TLINK;</span><br><span> </span><br><span>     req=2Ei=2Eifi_family =3D AF_P=
ACKET;</span><br><span>     req=2Ei=2Eifi_index =3D ifindex;</span><br><spa=
n>@@ -727,7 +727,7 @@</span><br><span> </span><br><span>     req=2En=2Enlms=
g_len =3D NLMSG_LENGTH(sizeof(req=2Ei));</span><br><span>     req=2En=2Enlm=
sg_flags =3D NLM_F_REQUEST;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    req=2En=2Enlmsg_type =3D RTM_NEWLINK;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    req=2En=2Enlmsg_type =3D RTM_SETLINK;</span=
><br><span> </span><br><span>     req=2Ei=2Eifi_family =3D AF_PACKET;</span=
><br><span>     req=2Ei=2Eifi_index =3D ifindex;</span><br><span>@@ -758,7 =
+758,7 @@</span><br><span> </span><br><span>     req=2En=2Enlmsg_len =3D NL=
MSG_LENGTH(sizeof(req=2Ei));</span><br><span>     req=2En=2Enlmsg_flags =3D=
 NLM_F_REQUEST;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    re=
q=2En=2Enlmsg_type =3D RTM_NEWLINK;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    req=2En=2Enlmsg_type =3D RTM_SETLINK;</span><br><span> =
</span><br><span>     req=2Ei=2Eifi_family =3D AF_PACKET;</span><br><span> =
    req=2Ei=2Eifi_index =3D ifindex;</span><br></pre><p>To view, visit <a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1628?usp=3Demail">change =
1628</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1628?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I33e55d88d561393ebfbc73a995f700056e19a436 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 1628 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Gianmarc=
o De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-deve=
l@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--gaiv/qrEciE=--


--===============5941348015451701633==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5941348015451701633==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5941348015451701633==--

