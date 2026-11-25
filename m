Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0310D60A2603
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 19:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=HGkZ6fWH;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=j/t64JKF;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=CjfQQHhh;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=gcOjdB8w
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=3Qye0kMgERbg6G5opqY/sJppzHx+5AWWB7n4eGdp0hg=; b=HGkZ6fWHziVMgY33BDIf1KUDEs
	eCSkk3ALpGPqWJLWYFTlT4rAVxXnD8Z1Q/Zif8KOUFBHx3f0uwZa0z8qh4p7ouJRnLlN3Qi7wDLS3
	4sz0Zz/kkgfrUVH4pEmZmh/8KDYa+CbFaRMyieRMvDXARGUjgzikuSJsmXm4SLWwR7o8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWIbx-000000005iH-2x42;
	Wed, 25 Nov 2026 19:24:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWIbu-000000005hr-3qpL
 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 19:24:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QzvQkKBOAzwQpH7NaPQvYiBlFJp5p6UpAnZl9AqNkco=; b=j/t64JKFgDee6ezMqKdGGdtigC
 hvUuSUyhCbsK1Qcp53yor0+HKFC+QVzXeFwe6BV+JFCrUz7cEkkhPqeUOI7P7zkSVW16sl4x1DnTr
 qp1cLxE63632jDCsRqFOy175puI3yU/7qJUpFUVcVB79E5ZsPxs8uxXcQJlBvU3QMQiU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QzvQkKBOAzwQpH7NaPQvYiBlFJp5p6UpAnZl9AqNkco=; b=CjfQQHhhXuP5nOjvGVyiNKFRZ6
 lBXn0vqR8IzQkmQJQr50dvw4fz9eWO8PshDiCuLkbSIbAD5jK3k9n04qWLx4T+jjmUetSh6aFuI+Y
 I40lkArXBmzhnbl2OkMp66KlZSjmQr1JaVhvylWDEd9uRK7Xe1wwkIq916Wo3kTfbm44=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWIbt-000000002jL-45jO for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 19:24:54 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4bb606491faso33204575e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 11:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795634687; x=1796239487; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QzvQkKBOAzwQpH7NaPQvYiBlFJp5p6UpAnZl9AqNkco=;
 b=gcOjdB8wj6dLE/Cex3VRZir4wnwHAPu4WuGDBFfu7mHkUMn5S5WSAzofhmOZiKc/gh
 HvNdm8GZBG4y2tF/LxClYEzOLuPTjNp7nMqR0/RceUp2s8fBYlgYyNHCfFF70WuMfk19
 qxE4au2GfPiYueevdDDNe3KLiKdRzSVNfkR1Ejx2oWegOv8a0VoblY83UcYXWNEH+dUD
 MgSjqJpSxg/o4a1zmn9CrT3QdsOzsy++KlqkuNT5KQq3O8RvvnN/d9Im+87BmTs/e5TD
 bdWHX9jY/JxG4hV71h7nQ2TJcPNNLsMIVwba0krvxtdnWLtzgjgmSX7X9sS63H3lMKCF
 f9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795634687; x=1796239487;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=QzvQkKBOAzwQpH7NaPQvYiBlFJp5p6UpAnZl9AqNkco=;
 b=FJngqOmrDbWbzjVJxKRp8IHrVTbEZJHOhi/22ZWsjLmirXhkAqQ3v/3CngqQ6oHgfB
 5oGbKGA5YK/3xZU72NKoASeOo11OvZSORF0z3XgslR8Mzb/cJes2pOcqIV7VlNfi6tmr
 YlAo8eTVGHvvbEqDaTH6ibnvaVFu7IgMEklFMYnWJ+gcK1k5e4D24C+RQfgfqfIOrhSS
 IcmkwSvGqxcxEbls5G7KxY4oBVSmkzcuSl00E1erAICGcX9QyZG9TZ7OlVeMmLD4rYoE
 UY5DKsXaQ14E/+M74AvNqo9N3Al00/ob8Y0ufai/mqJ5wqmOxm+xSDzkSaWt5GXDUfLJ
 SvWQ==
X-Gm-Message-State: APuU4Z8lEIUEllCCFJevUFl6kN26sX6D5Zg5DmcnlFo3FvZYxU4pEXwt
 kcU/cKIcA0x14h9a2x9H6PWC7cs9J9LoOEYjTpZERg0UtSO6Uyn9ZWAVVFuMyge1XT7Jon5B/xq
 Y9jCk8Gn5HyvPeN8KUYAgmH2apX+BYsXo1c3R1RGuRK1IFOIKp/wPH9hqOw70jdwUpz8rbD0E0l
 qz0W5FPA==
X-Gm-Gg: AZFdTZceVzckd1Ng5mBCBkHe/XeQn8eiavhEXZ13CIEZTCB89W9jTXPL7tz+PrG+aNo
 bAjr7ufaNQUmbh/jvIMn5ji9+5Tsc5JbEPA7An5oUogMX8GdjXIREIUVL0a7CdKN1+NMn8XPbxb
 7MI9S5DkCrKMPgcOeETK03CAIlHwN7NSAW1GUFDQBaHVblDZxpf87hiNcC5D+9nXmFf39eKVS3H
 G8+d2sEFyza2zWn+Gh7ZtiMtg4DqDJvo8/1ohsyqL/wcSHYBGnGO0qjUD1mVehZjfE4YvETUZug
 TuJZVMG57y9P6TRj9OqF8yrOJYaNmPwRTMRkmEu6L4hlhpFLFVcRBl2DKqRFhKyfoZ3Ci133p8i
 +Y8osFdoKXxHbeoZ55Il2eC6vEDJd79HJakaREwKirp5p4UsbxVTnJtxNAhk7P8lElo9njx0CAW
 9a5MQtdoT8mYjmdu52fV8YVZRhEpz3vAGaWS0bFuUoE+WFCdDFRSO9lVn67/CydynkuF2uJDlY3
 f4cDnS7LjR3HI2OHl8b7rSuX76f2Ct7212Mc7tzxZIb1cQeoKUsjDnUsNUYM/vseUB/9jEbNi3t
 zOXGD/P1vcPrn+TgxBg8q+YL5xI7r3KtxjzFqs6ZIIajGn3lQBsze4BGM/vlTl7XU9N4E97hdZx
 91RXJHv6VKAfD8b/QL292CD8i0GuISDVzB6gVQXjP5+XgUepo+z7JU8qb6EpmpZCIFA1j7/kmkU
 sxNfE4oNC8YYkbIHk=
X-Received: by 2002:a05:600c:4e0d:b0:4a5:e6fd:65e5 with SMTP id
 5b1f17b1804b1-4bb88922a67mr373554385e9.31.1795634687245; 
 Wed, 25 Nov 2026 11:24:47 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853c9170sm609352795e9.14.2026.11.25.11.24.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 11:24:46 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 25 Nov 2026 19:24:45 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Lev Stipakov <lstipakov@gmail.com>, Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I7b13d8b5e0babb697191e21adf2998a090c310f4
X-Gerrit-Change-Number: 2335
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2335?usp=email>
X-Gerrit-Commit: 99ee0917a97c06d30e46900467e9cea83bfe7003
In-Reply-To: <gerrit.1795515967000.I7b13d8b5e0babb697191e21adf2998a090c310f4@gerrit.openvpn.net>
References: <gerrit.1795515967000.I7b13d8b5e0babb697191e21adf2998a090c310f4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTE1OTY3MDAwLkk3YjEzZDhiNWUwYmFiYjY5NzE5MWUyMWFkZjI5OThhMDkwYzMxMGY0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <31bfa6187cd2dcb102f557a43a4b7f60f0bacebf-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWIbt-000000002jL-45jO
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dco_win: use CM_*
 case labels when switching on context mode
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7226789539049273557=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7226789539049273557==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Lla+CY6zArg="; charset=UTF-8

--Lla+CY6zArg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2335?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Lev Stipakov


Change subject: dco_win: use CM_* case la=
bels when switching on context mode
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

dco_win: use CM_* case labels when switching on cont=
ext mode

ovpn_dco_init() switched on c->mode, a CM_* value, but used MODE_=
*
case labels, which are options modes=2E This only worked because
CM_P2P/C=
M_TOP and MODE_POINT_TO_POINT/MODE_SERVER share values=2E

Change-Id: I7b13=
d8b5e0babb697191e21adf2998a090c310f4
Signed-off-by: Razvan Cojocaru <razvan=
c@mailbox=2Eorg>
Acked-by: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit URL:=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2335
Message-Id: <2026112518242=
6=2E29675-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/=
openvpn-devel@lists=2Esourceforge=2Enet/msg41962=2Ehtml
Signed-off-by: Gert=
 Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/dco_win=2Ec
1 file cha=
nged, 2 insertions(+), 2 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/35/2335/2

diff --git a/src/openvpn/dco_w=
in=2Ec b/src/openvpn/dco_win=2Ec
index a854045=2E=2E6074552 100644
--- a/sr=
c/openvpn/dco_win=2Ec
+++ b/src/openvpn/dco_win=2Ec
@@ -197,12 +197,12 @@
 =

     switch (c->mode)
     {
-        case MODE_POINT_TO_POINT:
+        c=
ase CM_P2P:
             dco->ifmode =3D DCO_MODE_P2P;
             dco_p2p=
_start_vpn(dco->tt);
             break;
 
-        case MODE_SERVER:
+    =
    case CM_TOP:
             ovpn_dco_init_mp(dco, c->options=2Edev_node);=

             break;
 

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2335?usp=3Demail
To unsubscribe, or for help writing mail filter=
s, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Cha=
nge-Id: I7b13d8b5e0babb697191e21adf2998a090c310f4
Gerrit-Change-Number: 233=
5
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2E=
org>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revi=
ewer: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-CC: openvpn-devel <openvp=
n-devel@lists=2Esourceforge=2Enet>

--Lla+CY6zArg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2335?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Lev Stipakov</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">dco=
_win: use CM_* case labels when switching on context mode<br><br>ovpn_dco_i=
nit() switched on c-&gt;mode, a CM_* value, but used MODE_*<br>case labels,=
 which are options modes=2E This only worked because<br>CM_P2P/CM_TOP and M=
ODE_POINT_TO_POINT/MODE_SERVER share values=2E<br><br>Change-Id: I7b13d8b5e=
0babb697191e21adf2998a090c310f4<br>Signed-off-by: Razvan Cojocaru &lt;razva=
nc@mailbox=2Eorg&gt;<br>Acked-by: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt=
;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2335<br>Message=
-Id: &lt;20261125182426=2E29675-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https=
://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg4196=
2=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>=
---<br>M src/openvpn/dco_win=2Ec<br>1 file changed, 2 insertions(+), 2 dele=
tions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:2=
9418/openvpn refs/changes/35/2335/2</pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dco_wi=
n=2Ec b/src/openvpn/dco_win=2Ec</span><br><span>index a854045=2E=2E6074552 =
100644</span><br><span>--- a/src/openvpn/dco_win=2Ec</span><br><span>+++ b/=
src/openvpn/dco_win=2Ec</span><br><span>@@ -197,12 +197,12 @@</span><br><sp=
an> </span><br><span>     switch (c-&gt;mode)</span><br><span>     {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        case MODE_POINT_TO_P=
OINT:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case C=
M_P2P:</span><br><span>             dco-&gt;ifmode =3D DCO_MODE_P2P;</span>=
<br><span>             dco_p2p_start_vpn(dco-&gt;tt);</span><br><span>     =
        break;</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        case MODE_SERVER:</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        case CM_TOP:</span><br><span>             ovpn_dco=
_init_mp(dco, c-&gt;options=2Edev_node);</span><br><span>             break=
;</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2335?usp=3Demail">change 2335</a>=2E To unsubscribe, or for =
help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://=
schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2335?usp=3Demail"/><meta itemprop=3D"name" co=
ntent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Me=
ssageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: =
openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Id: I7b13d8b5e0babb697191e21adf299=
8a090c310f4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2335 =
</div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D=
"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt=
;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforg=
e=2Enet&gt; </div>

</body></html>
--Lla+CY6zArg=--


--===============7226789539049273557==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7226789539049273557==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7226789539049273557==--

