Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C26CCF2CA
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 19:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/aNrju+T40loFEbwjjIsimaXzbmAMgDoXi+QNzHFoEs=; b=YRF1ukColPh8uZ4uL/tfHDnmsD
	bVJRA/vkaCp8Ef25pea633eFE+OZTCp14DFkvxqvfzuU9OdpnTOVO0NYj8TNCylQNuEJJUtopQzgL
	DEeyy+oToxiV5Qcsr6wOoaG8VjvGEM/IBmikN59/kPqmbLe85DNfRePaabDY05NoVbaY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIX1O-0007DI-OL;
	Sun, 18 Oct 2026 19:58:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIX1M-0007DC-Ok
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 19:58:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=vtoM7kX3MOnYpewgFukY/uY7y3ObLp7Zm7YHCirRNv0=; b=E/ic2MDigQCU2tvJqJtJRg2vxR
 +TisYqDKc/Yh7s94AjNHg0q0ndJewXRQHqZKwu/CKSROlsfWSn1DmWdeTPv9LUOQschoM+yi3YMiX
 BEpyFy/StiPzSttQALvt+wrHLqtkIWgbggzjWJ2kSYBilvxHSLyLuUTRcyhLn1binbuU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=vtoM7kX3MOnYpewgFukY/uY7y3ObLp7Zm7YHCirRNv0=; b=d
 6+D90Tcw7Q+JKDMyVZjfaV8SBQoalMTInfI4lT6amTb+aSrSFvIRPKvglYBt+OJ/S+9bp1jSVAuuf
 0Ea+wZiSUSkzSYUco63dk+rqBdEfPu+O+9vVXbyF/9oJKGG2GNCt2EgvvKVNlYMUCRTkKeVUUv3ah
 pxD0HqB56p+uKnhE=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIX1L-0004J1-Us for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 19:58:16 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a1e3098ee2so6033715e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 12:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792353489; x=1792958289; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vtoM7kX3MOnYpewgFukY/uY7y3ObLp7Zm7YHCirRNv0=;
 b=eQHxtHRdEKrAdqGnuTvhdMjvJypICkY+UMMgZ6MBTp1Llgii7bgCL7a5ou1vlBgx3j
 I4faT9qkyfDX0wgCzMtnrLfHlLb5+0t+w+gB3j5RkEadPksmonHQPM2zWEremRxmhE9e
 nWoTI9K9jVeYLb1Kt4j/QGY3/6dsyaGGH9YthLNXNV8erHXGSiUe+WH+f8gVac3cWMVR
 gam8AxxAB5R64k16MW3BVBy/EVuJ7bKrDwmOLq8B29Z/+hD7C6RRvtp5WfxXRcfVrm9S
 chNw9zDb7251hocxnA4QWlHjKMF7Dz1yC7p+Uj4r+tQWrF8Csft0ZpIrlRvpo0w7sRwm
 Q6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792353489; x=1792958289;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vtoM7kX3MOnYpewgFukY/uY7y3ObLp7Zm7YHCirRNv0=;
 b=0ZCOffV37b57uQsSpvVlbsAQYSfetsgAj3I7vUiwRXZ3q6dxGTsYZ7eWPEFfy6NK/A
 Bt81uacs8EtQ92Of+zy3wtEtfvGMaw0yVwHOiT3CyxT2rkhLaX88GbVjgRjn445tW2I0
 QVwAYYLBNXDlqG5JMHSlzthQZ+kng5P2J2H32JIC0frtQS3wf86/o7nwGgRQHTRYX8iI
 MLF1VLp+EwFGErh9H7oinhk+Z2MYBAfYR3UoB/P9qtpf336Mo/lp7J4ij15YPpz3Q+5N
 52PsjVX+10NHDNYgVTuo/UE1CzA86nRhiP5kjMqSg4Mp8FpbemHKEu86wjFwZiO0hRkY
 Y1wg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwctuKnTx5jpIJgfu+1YA9Z1Ek+mk41Be4UESJuRW5Kkkt01G2oUi2a07GZQBZ1laE+EpbBR+jJWwRuInUA@lists.sourceforge.net
X-Gm-Message-State: AFq9FYItpjvuhUPcaLIMXC/hwzItcUs/r2zzp0+DtEoC+Krth2ZdqaQS
 Uo1mHF5d/h1YWOWnt9m0hlpZ804HJHi819y51t52XdazNX9pAN1NwV7NhohKh9IVuGm0um7Rmla
 S2+xJ4A9bwZCkt2Ne4wdwbl7KKK3/pHuu+9izopQSwWXvR4kOsGTGKNuOKSZtw8v4uotz
X-Gm-Gg: AYBFou0B+A0iViLGqqIiLgvpB4sof7j/qzdkwW/0NY5NGFsWdrvkf0lWxt0dX0ToaMR
 VDxjGaHnmZg5JruVgAgbVWQiy+ib0mv+oLn8yQ5d4ERyAWEOooN+qlZJfNj8ZU6lOMHubF4iN55
 Ci6J+ggHvFEO1alng83D5bK4KHBqO0q8GdHv9YpcMH1DQeLL5O6ouxLL0bmOxX3UejDuDFrfOT3
 XtMBJLfZs6bB26fC4zCE0qfPkHRW2aaQa18dIxIhM6Z4848xiMbcajAc40UtTx4oQXlgy9tSNts
 bFJ3uCb2oh2U4GPDYoI8ZyMmAsxPwROTbmpaxrYoMXlXUqmsNGQdqxAxU95+45e5pQKH9t3voHa
 zF5mNB6SytmS6gPsF8Wn13vW665oufdoZcxFox/K4u48FwFn4dlKUV/2l/3rSHXH2fs0tF66LEi
 xPj+/nalQOpwUR/9rc5ryfJsklbwmp2Xii+XZR2iQRh5C0QVj+tTq7b7Ylc95jfsCd5rAe2cJ6f
 qsJs2pAOXe4l3xAVNPevoTh2E309Rem4bXzb2Qocn6ZAN9V85Q3ufk6WSAknwPIJNyq/lB8DoXg
 eN6N2SpsSasUJEV0AlsWxtDVwOqk8CYWp7rJvakm3om7ohmGfwPsOY1km24k
X-Received: by 2002:a05:600c:190e:b0:4a1:90d7:88a8 with SMTP id
 5b1f17b1804b1-4a1d76106c0mr127692125e9.25.1792353489270; 
 Sun, 18 Oct 2026 12:58:09 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd9b8ebdsm348573245e9.10.2026.10.18.12.58.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 12:58:08 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 19:58:08 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I33e55d88d561393ebfbc73a995f700056e19a436
X-Gerrit-Change-Number: 1628
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1628?usp=email>
X-Gerrit-Commit: 8f3f66f79264acbd13d539bdcec1c12e24e2e7f7
In-Reply-To: <gerrit.1776267299000.I33e55d88d561393ebfbc73a995f700056e19a436@gerrit.openvpn.net>
References: <gerrit.1776267299000.I33e55d88d561393ebfbc73a995f700056e19a436@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc2MjY3Mjk5MDAwLkkzM2U1NWQ4OGQ1NjEzOTNlYmZiYzczYTk5NWY3MDAwNTZlMTlhNDM2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <99cb76928e447b479e89ebbb0f9c4833479a49b5-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIX1L-0004J1-Us
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7546031404209254306=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7546031404209254306==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kJjHEKfNcAw="; charset=UTF-8

--kJjHEKfNcAw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1628?usp=3Demail )

Change subject: sitnl: use RTM_SETLINK for =
updating existing interfaces
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

sitnl: use RTM_SETLINK for updating existing interfaces

R=
TM_NEWLINK is primarily intended for link creation and initialization,
whil=
e RTM_SETLINK is the canonical interface for modifying attributes of
an alr=
eady existing link=2E

Even though the kernel may accept RTM_NEWLINK for up=
dates, using
RTM_SETLINK better reflects the intended netlink semantics and=
 follows
the dedicated update path in the kernel=2E

This makes the behavio=
r more explicit and consistent with how link
configuration changes are expe=
cted to be performed=2E

Change-Id: I33e55d88d561393ebfbc73a995f700056e19a4=
36
Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Acked-by=
: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit URL: https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1628
Message-Id: <20261011202439=2E15128-1-gert@gre=
enie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg39831=2Ehtml
Signed-off-by: Gert Doering <gert@gree=
nie=2Emuc=2Ede>
---
M src/openvpn/networking_sitnl=2Ec
1 file changed, 3 in=
sertions(+), 3 deletions(-)




diff --git a/src/openvpn/networking_sitnl=
=2Ec b/src/openvpn/networking_sitnl=2Ec
index bbdfcb7=2E=2E0c99d38 100644
-=
-- a/src/openvpn/networking_sitnl=2Ec
+++ b/src/openvpn/networking_sitnl=2E=
c
@@ -691,7 +691,7 @@
 
     req=2En=2Enlmsg_len =3D NLMSG_LENGTH(sizeof(re=
q=2Ei));
     req=2En=2Enlmsg_flags =3D NLM_F_REQUEST;
-    req=2En=2Enlmsg=
_type =3D RTM_NEWLINK;
+    req=2En=2Enlmsg_type =3D RTM_SETLINK;
 
     re=
q=2Ei=2Eifi_family =3D AF_PACKET;
     req=2Ei=2Eifi_index =3D ifindex;
@@ =
-727,7 +727,7 @@
 
     req=2En=2Enlmsg_len =3D NLMSG_LENGTH(sizeof(req=2Ei=
));
     req=2En=2Enlmsg_flags =3D NLM_F_REQUEST;
-    req=2En=2Enlmsg_type=
 =3D RTM_NEWLINK;
+    req=2En=2Enlmsg_type =3D RTM_SETLINK;
 
     req=2Ei=
=2Eifi_family =3D AF_PACKET;
     req=2Ei=2Eifi_index =3D ifindex;
@@ -758,=
7 +758,7 @@
 
     req=2En=2Enlmsg_len =3D NLMSG_LENGTH(sizeof(req=2Ei));
 =
    req=2En=2Enlmsg_flags =3D NLM_F_REQUEST;
-    req=2En=2Enlmsg_type =3D =
RTM_NEWLINK;
+    req=2En=2Enlmsg_type =3D RTM_SETLINK;
 
     req=2Ei=2Eif=
i_family =3D AF_PACKET;
     req=2Ei=2Eifi_index =3D ifindex;

-- 
To view,=
 visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1628?usp=3Demail
To unsub=
scribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvp=
n
Gerrit-Branch: master
Gerrit-Change-Id: I33e55d88d561393ebfbc73a995f70005=
6e19a436
Gerrit-Change-Number: 1628
Gerrit-PatchSet: 2
Gerrit-Owner: Gianma=
rco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2E=
sourceforge=2Enet>

--kJjHEKfNcAw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1628?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">sitnl: use RTM_SETLINK for updatin=
g existing interfaces<br><br>RTM_NEWLINK is primarily intended for link cre=
ation and initialization,<br>while RTM_SETLINK is the canonical interface f=
or modifying attributes of<br>an already existing link=2E<br><br>Even thoug=
h the kernel may accept RTM_NEWLINK for updates, using<br>RTM_SETLINK bette=
r reflects the intended netlink semantics and follows<br>the dedicated upda=
te path in the kernel=2E<br><br>This makes the behavior more explicit and c=
onsistent with how link<br>configuration changes are expected to be perform=
ed=2E<br><br>Change-Id: I33e55d88d561393ebfbc73a995f700056e19a436<br>Signed=
-off-by: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt;<br>Acked-by=
: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Gerrit URL: https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1628<br>Message-Id: &lt;20261011202439=2E1=
5128-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom=
/openvpn-devel@lists=2Esourceforge=2Enet/msg39831=2Ehtml<br>Signed-off-by: =
Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/networ=
king_sitnl=2Ec<br>1 file changed, 3 insertions(+), 3 deletions(-)<br><br></=
pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/src/openvpn/networking_sitnl=2Ec b/src/openvpn/network=
ing_sitnl=2Ec</span><br><span>index bbdfcb7=2E=2E0c99d38 100644</span><br><=
span>--- a/src/openvpn/networking_sitnl=2Ec</span><br><span>+++ b/src/openv=
pn/networking_sitnl=2Ec</span><br><span>@@ -691,7 +691,7 @@</span><br><span=
> </span><br><span>     req=2En=2Enlmsg_len =3D NLMSG_LENGTH(sizeof(req=2Ei=
));</span><br><span>     req=2En=2Enlmsg_flags =3D NLM_F_REQUEST;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    req=2En=2Enlmsg_type =3D RT=
M_NEWLINK;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    req=
=2En=2Enlmsg_type =3D RTM_SETLINK;</span><br><span> </span><br><span>     r=
eq=2Ei=2Eifi_family =3D AF_PACKET;</span><br><span>     req=2Ei=2Eifi_index=
 =3D ifindex;</span><br><span>@@ -727,7 +727,7 @@</span><br><span> </span><=
br><span>     req=2En=2Enlmsg_len =3D NLMSG_LENGTH(sizeof(req=2Ei));</span>=
<br><span>     req=2En=2Enlmsg_flags =3D NLM_F_REQUEST;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    req=2En=2Enlmsg_type =3D RTM_NEWLINK;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    req=2En=2Enlmsg=
_type =3D RTM_SETLINK;</span><br><span> </span><br><span>     req=2Ei=2Eifi=
_family =3D AF_PACKET;</span><br><span>     req=2Ei=2Eifi_index =3D ifindex=
;</span><br><span>@@ -758,7 +758,7 @@</span><br><span> </span><br><span>   =
  req=2En=2Enlmsg_len =3D NLMSG_LENGTH(sizeof(req=2Ei));</span><br><span>  =
   req=2En=2Enlmsg_flags =3D NLM_F_REQUEST;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    req=2En=2Enlmsg_type =3D RTM_NEWLINK;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    req=2En=2Enlmsg_type =3D RT=
M_SETLINK;</span><br><span> </span><br><span>     req=2Ei=2Eifi_family =3D =
AF_PACKET;</span><br><span>     req=2Ei=2Eifi_index =3D ifindex;</span><br>=
</pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1628?usp=3Demail">change 1628</a>=2E To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1628?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<=
div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Id: I33e55d88d561393ebfbc73a995f700056e19a436 </di=
v>
<div style=3D"display:none"> Gerrit-Change-Number: 1628 </div>
<div styl=
e=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> =
Gerrit-Owner: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html=
>
--kJjHEKfNcAw=--


--===============7546031404209254306==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7546031404209254306==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7546031404209254306==--

