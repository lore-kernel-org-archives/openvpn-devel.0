Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133D1606A31E
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 18:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=mj7ADEuO;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kJ9WW/Ff;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=XztBUpSo;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=IltC3MVL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=5dNpsMfdjxpkZr0egHAE+jL0m18+JcvEyb9tDXTUuQc=; b=mj7ADEuO6sDP7py71JIjeseGGs
	pxq4lzj439dR7KYFZjSnhqQQNS/vhQxSfF/nDn2BIXRX8Aa1nUBhHs7nmoz5Mtccow/dJuaIff7RE
	61z6HmjSEM0ptYq4CWNXBKdsQ3MWWZ+6qYQ0kAL7d5uFx47o0memjTZxbjx1HsaLG9PU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWHee-000000002Mf-3Cpe;
	Wed, 25 Nov 2026 18:23:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWHed-000000002MY-2AoP
 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 18:23:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HLUCZCe60Jf8j5BvSAfkQx5+yc+aXBcwr5oAR/3QTg8=; b=kJ9WW/FfLKoqiDlHa74zjoH6x6
 E+P0hkoHXZmGimvGxClLAu+6X456HAG53L8OKaPnWgEmIW46qv50HBLfg67djF+WtkyxHi9Glm1nH
 cQPZIQLFDyh6sgHIzm39gojg8+CBn4YRZ6A3L62kQZAJogmV9qB5CmP7C1mSWMf9FUu8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HLUCZCe60Jf8j5BvSAfkQx5+yc+aXBcwr5oAR/3QTg8=; b=XztBUpSo6PvcpF9XVebV21HtOC
 PRsPK9JKHOHY3HyQpLy8I1DuwNRT8tf7USGmp81N6nXjRwhjYYXdljrzpJOh9f8FUPgWZH8EdWEBP
 QhH2bLBglYT4CpT7wmCt4JWBOUZOBrEkT7Jsv0fM/lsB0nlHt9mFv2NIoRUBrVzVLoJo=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWHea-000000006zv-3I1q for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 18:23:39 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4ba013938d7so57301255e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 10:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795631010; x=1796235810; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HLUCZCe60Jf8j5BvSAfkQx5+yc+aXBcwr5oAR/3QTg8=;
 b=IltC3MVLv2lWjyHaqtmaLdgjWGMWqabYO+pwY+FcTZidpb1WnLYdE+6iynrI5jTVn6
 spGKgvvcG1B5i69lPH0ynrw0LKaep5QHxzgn/Lx+QVxxtlPA3SyRn45yiLp8Vgp8W7gv
 pj6hy4GZXtzi/7kk3zeonlXdst1Z9gqSHg36UFLSVcoPo/FAJuz8y/FYEE0BveGY69um
 lAy8PLvoC0i7jzcoAmJkdcfim3RymM4dmFk8TWv8GIE2lGHnJixod+MX5nve0yXER8UJ
 Og+tKyeiXUuzVQRBIrAB5ut3R8XLIJA9u6wJarD1vCc0BLnQMNeaJlH63S268KwAfyPb
 GsGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795631010; x=1796235810;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HLUCZCe60Jf8j5BvSAfkQx5+yc+aXBcwr5oAR/3QTg8=;
 b=PbL9CfhhL3IbCozrijU+DCWcUTuG/b/Rny6XkE3I5nZIIyLrk7Rj2fIGw5FalLl+OC
 e+LVrofHuinqI30Bs1jkNHSwCtUCYiVA94Gg9giUbgR3Inrv0cFNGzGqTNzzBavi4Xz7
 u43RHwMdcs9pA9dOe2M6tElFAac41KwNJldr+Ca9MXyrFfQXemlu+FYy6r1XmYW2OCor
 EGsoTH5nRGiKghnVy6V2oGEcpv7IaQ52hSv0+SNwXOj5Hs24BIs1Vtr9hTkmpbrmlMLi
 r/vEXDxelo3gSpnVck8bIUFGF2u3Q9fZ78Gd8zKozRMQFIiAZUKlv82AGh4chN8YEJcs
 xlvg==
X-Gm-Message-State: APuU4Z9IleQ2vlPQ9UljxkPUVKnQ33oMQfBTqFxHpJn2l6NAdzx5+Utn
 NYwnyqQQ+VwUoI2TS4gBG3UT6Jbvp2s+pf09irUhlOW63EI1spsbJL3aHYbF7fTug2kSSCyyxF5
 7z7gXm9AgqaradFiz2U6qmhQFSxihBrf2T7fIHEdNSymbYODBTH/aaYfF9AQK1Edd+UDX
X-Gm-Gg: AZFdTZfeCUuPj+0LDAv80kHSXGfQ9PnPJtsei0hC2LPsVg6R2wYpWGmUvk77vv3s2kt
 2aIpW2OcTfEZlkkXSGAy4whxODfIir7u57oLAMkLkkkquU0E8aCE/8o6OpSLwflNo9WWeYeJUqE
 zW7kZrF3lXQwjFG9UMpHslCfSTaNHu3IyyyLXfiu6yw6BNe8qFgKNtTn4lK+UlIRw/ob3q4A+Dx
 qnL2C1KsRga/fuIjTs/z62s+x4eHR13PVSoRAQiPv3etTT4Qj5xGQzebsQ708J+Oj6q1xBT8fWZ
 oqH1RH70yYNtvaEjMIkC0jNhIvArcpkCYmeLAIU/8oZWAn0Q0J9OXH5Rngtd2IfXueBuZSq5M/Q
 Dyj/wVW0SjhPsE58WPreMAbkGZqGOOBNpXsfoQ54FrssMHPnlHySXhzG9N/EwA/mw3aiD9cQyQn
 nMuoEBmXcBJOD0XrHPjgVONhTN3X6ShfDoyTNfmnI0zEFIItKuaPRodrsTwVnFgcV1GBYr9KGSN
 yvyTcy/GmOomoJbow10ND7JC7rCieoaLWRcY+5yQ1Yu2TvFaPFX3h/WKiW3CPFrOMOdYmtUwlQ8
 pFWawPeh09iD+Ipy+krV/VBtFj4Ed+RmtLGh9GEXk80cytgYchw4dxYjI/3XuRlA6FZrq8yS2pf
 VFLCO0x/bIeM2bV9vDM3lkdCwiY5XPLvzvFcLkzbgr9crCv88ZhS/6RnMYDZkMs21MIICIwtMjR
 Zw5VRCDhezHLc9kC0=
X-Received: by 2002:a05:600c:6290:b0:4bb:741d:eba with SMTP id
 5b1f17b1804b1-4bb88824a5bmr376522935e9.13.1795631010041; 
 Wed, 25 Nov 2026 10:23:30 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8849247asm545387365e9.7.2026.11.25.10.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 10:23:29 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 25 Nov 2026 18:23:28 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Lev Stipakov <lstipakov@gmail.com>, Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ie902dbc45e4aca0c72bc4b4e8cc1e17d29b47aa1
X-Gerrit-Change-Number: 2334
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2334?usp=email>
X-Gerrit-Commit: 27d9a806e2ceaccf8155a70ee55dc0b1f5ca82b7
In-Reply-To: <gerrit.1795515857000.Ie902dbc45e4aca0c72bc4b4e8cc1e17d29b47aa1@gerrit.openvpn.net>
References: <gerrit.1795515857000.Ie902dbc45e4aca0c72bc4b4e8cc1e17d29b47aa1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTE1ODU3MDAwLkllOTAyZGJjNDVlNGFjYTBjNzJiYzRiNGU4Y2MxZTE3ZDI5YjQ3YWExQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1e62155acb2702bc46f214c59b90f153430ca6bb-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWHea-000000006zv-3I1q
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options: make the
 options mode an enum
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
Content-Type: multipart/mixed; boundary="===============7185765199769716051=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7185765199769716051==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BAPGDgFj2vo="; charset=UTF-8

--BAPGDgFj2vo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2334?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Lev Stipakov


Change subject: options: make the options=
 mode an enum
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


options: make the options mode an enum

Turn the MODE_* defines into enum=
 options_mode and use it for the mode
fields and parameters=2E With both mo=
des being distinct enum types,
-Wenum-compare catches comparing a context m=
ode against an options
mode=2E

Change-Id: Ie902dbc45e4aca0c72bc4b4e8cc1e17=
d29b47aa1
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: =
Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2334
Message-Id: <20261124122559=2E8549-1-gert@greenie=
=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg41880=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/dco=2Ec
M src/openvpn/options=2Ec
M src/open=
vpn/options=2Eh
M src/openvpn/ssl_common=2Eh
4 files changed, 11 insertions=
(+), 7 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn=
 refs/changes/34/2334/3

diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=
=2Ec
index fdee465=2E=2E3c85c11 100644
--- a/src/openvpn/dco=2Ec
+++ b/src/=
openvpn/dco=2Ec
@@ -255,7 +255,7 @@
 }
 
 static bool
-dco_check_option_ce(=
const struct connection_entry *ce, msglvl_t msglevel, int mode)
+dco_check_=
option_ce(const struct connection_entry *ce, msglvl_t msglevel, enum option=
s_mode mode)
 {
     if (ce->fragment)
     {
diff --git a/src/openvpn/opti=
ons=2Ec b/src/openvpn/options=2Ec
index 1a8604e=2E=2E1e0b4d8 100644
--- a/s=
rc/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -2309,7 +2309,7 @@
=
 }
 
 static void
-options_postprocess_mutate_le(const struct connection_en=
try *ce, struct local_entry *le, int mode)
+options_postprocess_mutate_le(c=
onst struct connection_entry *ce, struct local_entry *le, enum options_mode=
 mode)
 {
     /* use the global port if none is specified */
     if (!le-=
>port)
diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh
index=
 b390ebc=2E=2E0112c5f 100644
--- a/src/openvpn/options=2Eh
+++ b/src/openvp=
n/options=2Eh
@@ -252,6 +252,13 @@
     struct verify_hash_list *next;
 };
=
 
+/** Major mode */
+enum options_mode
+{
+    MODE_POINT_TO_POINT,
+    M=
ODE_SERVER,
+};
+
 /* Command line options */
 struct options
 {
@@ -260,10=
 +267,7 @@
     /* first config file */
     const char *config;
 
-    /* =
major mode */
-#define MODE_POINT_TO_POINT 0
-#define MODE_SERVER         1=

-    int mode;
+    enum options_mode mode;
 
     /* enable forward compa=
tibility for post-2=2E1 features */
     bool forward_compatible;
diff --gi=
t a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh
index cfe3fea=
=2E=2Efe333a3 100644
--- a/src/openvpn/ssl_common=2Eh
+++ b/src/openvpn/ssl=
_common=2Eh
@@ -324,7 +324,7 @@
 
     /* from command line */
     bool si=
ngle_session;
-    int mode;
+    enum options_mode mode;
     bool pull;
 =
    /**
      * The detail of info we push in peer info

-- 
To view, visit=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2334?usp=3Demail
To unsubscribe=
, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn=

Gerrit-Branch: master
Gerrit-Change-Id: Ie902dbc45e4aca0c72bc4b4e8cc1e17d2=
9b47aa1
Gerrit-Change-Number: 2334
Gerrit-PatchSet: 3
Gerrit-Owner: R=C4=83=
zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Lev Stipakov <lstipakov@gmail=2Ecom>=

Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--BAPGDgFj2vo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2334?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Lev Stipakov</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">opt=
ions: make the options mode an enum<br><br>Turn the MODE_* defines into enu=
m options_mode and use it for the mode<br>fields and parameters=2E With bot=
h modes being distinct enum types,<br>-Wenum-compare catches comparing a co=
ntext mode against an options<br>mode=2E<br><br>Change-Id: Ie902dbc45e4aca0=
c72bc4b4e8cc1e17d29b47aa1<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mai=
lbox=2Eorg&gt;<br>Acked-by: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt;<br>G=
errit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2334<br>Message-Id: &=
lt;20261124122559=2E8549-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41880=2Eht=
ml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br=
>M src/openvpn/dco=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/option=
s=2Eh<br>M src/openvpn/ssl_common=2Eh<br>4 files changed, 11 insertions(+),=
 7 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/34/2334/3</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
n/dco=2Ec b/src/openvpn/dco=2Ec</span><br><span>index fdee465=2E=2E3c85c11 =
100644</span><br><span>--- a/src/openvpn/dco=2Ec</span><br><span>+++ b/src/=
openvpn/dco=2Ec</span><br><span>@@ -255,7 +255,7 @@</span><br><span> }</spa=
n><br><span> </span><br><span> static bool</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-dco_check_option_ce(const struct connection_entry *ce,=
 msglvl_t msglevel, int mode)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+dco_check_option_ce(const struct connection_entry *ce, msglvl_t m=
sglevel, enum options_mode mode)</span><br><span> {</span><br><span>     if=
 (ce-&gt;fragment)</span><br><span>     {</span><br><span>diff --git a/src/=
openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index 1a8604e=
=2E=2E1e0b4d8 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><b=
r><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -2309,7 +2309,7 @@=
</span><br><span> }</span><br><span> </span><br><span> static void</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-options_postprocess_mutate_le(=
const struct connection_entry *ce, struct local_entry *le, int mode)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+options_postprocess_mutate=
_le(const struct connection_entry *ce, struct local_entry *le, enum options=
_mode mode)</span><br><span> {</span><br><span>     /* use the global port =
if none is specified */</span><br><span>     if (!le-&gt;port)</span><br><s=
pan>diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh</span><b=
r><span>index b390ebc=2E=2E0112c5f 100644</span><br><span>--- a/src/openvpn=
/options=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</span><br><span>=
@@ -252,6 +252,13 @@</span><br><span>     struct verify_hash_list *next;</s=
pan><br><span> };</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/** Major mode */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+enum options_mode</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    MO=
DE_POINT_TO_POINT,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   MODE_SERVER,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* =
Command line options */</span><br><span> struct options</span><br><span> {<=
/span><br><span>@@ -260,10 +267,7 @@</span><br><span>     /* first config f=
ile */</span><br><span>     const char *config;</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    /* major mode */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#define MODE_POINT_TO_POINT 0</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#define MODE_SERVER     =
    1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int mode;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    enum options_mode =
mode;</span><br><span> </span><br><span>     /* enable forward compatibilit=
y for post-2=2E1 features */</span><br><span>     bool forward_compatible;<=
/span><br><span>diff --git a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_c=
ommon=2Eh</span><br><span>index cfe3fea=2E=2Efe333a3 100644</span><br><span=
>--- a/src/openvpn/ssl_common=2Eh</span><br><span>+++ b/src/openvpn/ssl_com=
mon=2Eh</span><br><span>@@ -324,7 +324,7 @@</span><br><span> </span><br><sp=
an>     /* from command line */</span><br><span>     bool single_session;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int mode;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    enum options_mode mode;</=
span><br><span>     bool pull;</span><br><span>     /**</span><br><span>   =
   * The detail of info we push in peer info</span><br></pre><p>To view, vi=
sit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2334?usp=3Demail"=
>change 2334</a>=2E To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</=
a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><=
link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/23=
34?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<d=
iv style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"dis=
play:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerri=
t-Change-Id: Ie902dbc45e4aca0c72bc4b4e8cc1e17d29b47aa1 </div>
<div style=3D=
"display:none"> Gerrit-Change-Number: 2334 </div>
<div style=3D"display:non=
e"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: Lev Stipakov &lt;lsti=
pakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></ht=
ml>
--BAPGDgFj2vo=--


--===============7185765199769716051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7185765199769716051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7185765199769716051==--

