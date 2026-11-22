Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B113606A32A
	for <openvpn-devel@archiver.kernel.org>; Sun, 22 Nov 2026 11:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=N857XOrA;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=c9pg+ZV/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ajoeta0G;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=LHDvRkHT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Twau3lkieNuS2GyN6GYKgLGi2P+k74HUzf0bxGfpm0I=; b=N857XOrAZ9yLzwlAR88hWnJD6S
	qMULN6tIBR13W1Dp7aOGc80KZFiOn1/T866IemyLmV08W/aoqsn63h1Rd2S9SWeU6T6s1Sp/jI2yY
	z4BQLFm8tGLapdCdFYmkZ1LKaP+fzUliofSQ5DmIxDoZvECbi+d68fzuiJDBU+CmDb4g=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xV5Z3-000000003vJ-0jNE;
	Sun, 22 Nov 2026 11:16:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xV5Z0-000000003v9-3g8C
 for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 11:16:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7KDzBFfpCOisZhMB/f+UmDmi5LYAHpAqMKZwfkp8nwI=; b=c9pg+ZV/dNO8xX8NWwd0mfjozx
 E3p985UNeXcUmst396/0GSyGA0hvabg2pPqdDSXjZActxcg2O3oQEa8V06OoQEl1ZDH67Qdhk1jLL
 39lML7i83Gj7yrabo/kwcHnSAnCIY8J/fuJBRXRJSWCPAvenrEIiPlwqlzawx5G9Bo54=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7KDzBFfpCOisZhMB/f+UmDmi5LYAHpAqMKZwfkp8nwI=; b=ajoeta0GqyaAUaa7ImmNduJ8aM
 /3HD7pMop1Us2OKvZv0TyFEXzLTqS/nsSkEOrfFm97IxPrefRWUa0eIByGhoFkWuKLXWHp26ASYsl
 Igo4vVGTSKaM+8Rj5TJqtsWcuQp2j6LPtqdSJSLyF50qLPR9xqYFmingarxFaiPIl/og=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xV5Yz-000000005OT-3MUW for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 11:16:54 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-490c3ae81d3so1436810f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 22 Nov 2026 03:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795346207; x=1795951007; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7KDzBFfpCOisZhMB/f+UmDmi5LYAHpAqMKZwfkp8nwI=;
 b=LHDvRkHTYgzdKMrachoxZ0D3n+QlYgDePwvX2mFpUIbFlrlOnc+tWQaTQCm9LxhnIf
 DO/UbXOnu66yyc9UfEHVa48EGyv6zMuuv+o36R2htc+A8DbRCYQn1h+ltD2mlNP1+SFO
 UlxHbOD5dNWLgYQGHdyq/2gW7cJfue5r/x3MwvSCoRzCl0z6Y6MeC7hdaso7Pa4wuZEI
 0k6ZMhd95mC+I8gdd2Eqj3Vk9HT/8zTX96MxWEzokVY8YR0Mnbywq888ty/5ckslK5bv
 z2X0c2LG0nHto68mIBS0JxZsAw2tecQR0dDjcXmhNvQayT/6mW3CPPusihe42FxAhUUL
 vCdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795346207; x=1795951007;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7KDzBFfpCOisZhMB/f+UmDmi5LYAHpAqMKZwfkp8nwI=;
 b=cpYCdCgw1km5/C5h5lpvxwEXPhaJZ3tmNnxDRiDTXhd3QopRRN7W0GQlSzIiAff3Fl
 CG+tlktY5eAZmDFqHu+uRYlWJ8RAg3Au/oPCKxdFGI6bGnN4mlb9EO7hY8FTuyxTBWl2
 A2fWymnxX7t1WQgUGUOu1+EIwBuFm0OStBg4lTnalqUjsl2+Dqas0/HbQsp/gr6f+WiC
 rMyAbJYcmTX7GQOD31bMpgA7rKuDEvKkTWEjaMxp6KZgH7qU7M1oCQvUu/CUESTdkKVN
 zoCA2rFzNZ5caefvPFdsjAu3C+ZlwoHb6XEAyS0rFolOkDz3dPV5jdNln7X7suWYaPWA
 RApQ==
X-Gm-Message-State: APuU4Z92zVJdxPjmuLR++HlPwJfFq/SpnI7vsCyb38p/fmor58sML3Ei
 SvJT2ljgfr6zhI+odDeasYu5pcnsiKPS2WcM3rdI+v230mUktLg9b3IJrZxVpdokzxC8vJ0afpd
 /VcsOrUWhG0zdu4t3nKHigRuhko0A6J4vA3X6a2rHtumBHUWEiUv6tNK3N3oQdlLUAYVLdBcton
 rkTwqbfw==
X-Gm-Gg: AZFdTZdLdXNuOePVRzAfNkinkxPlvLntFZ9KlI6Y9uMfGLblqBwQTi5Rld8UgxA4Fso
 UPVseJVDY5zPa1VhsKaiRrCm5+u/4FdJmo0cGXWaVVe4zwH/yyIkaC3CCPIa+crHBMGHD/auvwN
 A3RuFb1pNn+JQB3/3a3/cXpRYIs96/gwK6Re118KK1M+UHQuPfqVRqY6c8IIi3mPTdB8xQMuqSo
 s+TFmYNx28GioVUkiJc1T+FYvDOMOp+7MOPmEJzivhbv9E/gZHB1SLRmrykXz8GPZeNAiIjEUaG
 pZRgZgxu1O6jydExBwTF2I7q+C/yNDWKP9DuXGznbSec0blIAzdJjtTyXMOA2FDdHJaZHnm9c6B
 NZAm1pp20SVzJdYvYQ1l4zN6pWS4JPxyCXJphAnPEisNvdR+8DFoSnLlnDrMJZVHpA0uCbjVKB0
 MpkFiBQ+I8s1RjCCQzeDjJ2K86DRqnFkSdvXIwLwJLHTancosQVOOy5BBzPEyiS9PMxd4/646Ki
 +1tuSKFWXW3tHCnxwpu1yc89Dp7C7Wv4CCbS40WchcWrWZ7MKotonV9n0YGNlN0DLnjAzMpppX4
 EW5X4MgskU7FhDjNYP1ij3rDzHX6hU8juFa+OI1ymE3OkGC8pDDDV/AIhU/+NqvVn64c7M4+RpA
 qtRWfh58d8UybE4g1blYlZFoPOxciny1GUE8l2YJVy9AoFIqPnlBRoI40f5vkTkfitYgs+qUhYJ
 fV9ahLhD2VVUH+4xY=
X-Received: by 2002:a05:6000:4616:b0:4a8:cf12:6f34 with SMTP id
 ffacd0b85a97d-4abaab6318fmr17636296f8f.4.1795346207009; 
 Sun, 22 Nov 2026 03:16:47 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67fe75sm18080292f8f.24.2026.11.22.03.16.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 03:16:46 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 22 Nov 2026 11:16:45 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I1d516b1acee3edc2a69c670d62f49e3cd34d6dc7
X-Gerrit-Change-Number: 2227
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2227?usp=email>
X-Gerrit-Commit: fb4ef462b3e88579aac06ae13c6144018768d120
In-Reply-To: <gerrit.1795173017000.I1d516b1acee3edc2a69c670d62f49e3cd34d6dc7@gerrit.openvpn.net>
References: <gerrit.1795173017000.I1d516b1acee3edc2a69c670d62f49e3cd34d6dc7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MTczMDE3MDAwLkkxZDUxNmIxYWNlZTNlZGMyYTY5YzY3MGQ2MmY0OWUzY2QzNGQ2ZGM3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6d7b62aa0066442be133547ed5fea2064e28a599-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xV5Yz-000000005OT-3MUW
Subject: [Openvpn-devel] [XS] Change in openvpn[release/2.7]: route:
 initialize the table of block-local routes
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
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6442286063176282683=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6442286063176282683==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="idFeIQtKTU0="; charset=UTF-8

--idFeIQtKTU0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2227?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Gert Doering


Change subject: route: initialize the tab=
le of block-local routes
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

route: initialize the table of block-local routes

add_block_=
local_item() allocates the routes without clearing them and
left table_id u=
nset, so the routes went to a garbage table=2E Use 0, the
default table, li=
ke the other internal routes=2E

Change-Id: I1d516b1acee3edc2a69c670d62f49e=
3cd34d6dc7
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by:=
 Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2227
Message-Id: <20261121144850=2E26734-1-gert@greenie=
=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg41757=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/route=2Ec
1 file changed, 1 insertion(+), 0 =
deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/c=
hanges/27/2227/2

diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2E=
c
index 4dfdd5f=2E=2E5b1d012 100644
--- a/src/openvpn/route=2Ec
+++ b/src/o=
penvpn/route=2Ec
@@ -557,6 +557,7 @@
         /* split a route into two sma=
ller blocking routes, and direct them to target */
         l2 =3D ((~gatew=
ay->netmask) + 1) >> 1;
         r1->flags =3D RT_DEFINED;
+        r1->tab=
le_id =3D 0;
         r1->gateway =3D target;
         r1->network =3D gate=
way->addr & gateway->netmask;
         r1->netmask =3D ~(l2 - 1);

-- 
To v=
iew, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2227?usp=3Demail
To u=
nsubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Projec=
t: openvpn
Gerrit-Branch: release/2=2E7
Gerrit-Change-Id: I1d516b1acee3edc2=
a69c670d62f49e3cd34d6dc7
Gerrit-Change-Number: 2227
Gerrit-PatchSet: 2
Gerr=
it-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arn=
e Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@=
greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>

--idFeIQtKTU0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2227?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Gert Doering</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">rou=
te: initialize the table of block-local routes<br><br>add_block_local_item(=
) allocates the routes without clearing them and<br>left table_id unset, so=
 the routes went to a garbage table=2E Use 0, the<br>default table, like th=
e other internal routes=2E<br><br>Change-Id: I1d516b1acee3edc2a69c670d62f49=
e3cd34d6dc7<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;=
<br>Acked-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2227<br>Message-Id: &lt;202611211=
44850=2E26734-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-arch=
ive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41757=2Ehtml<br>Signed=
-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openv=
pn/route=2Ec<br>1 file changed, 1 insertion(+), 0 deletions(-)<br><br></pre=
><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/cha=
nges/27/2227/2</pre><pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;"><span>diff --git a/src/openvpn/route=2Ec b/src/openvpn/rou=
te=2Ec</span><br><span>index 4dfdd5f=2E=2E5b1d012 100644</span><br><span>--=
- a/src/openvpn/route=2Ec</span><br><span>+++ b/src/openvpn/route=2Ec</span=
><br><span>@@ -557,6 +557,7 @@</span><br><span>         /* split a route in=
to two smaller blocking routes, and direct them to target */</span><br><spa=
n>         l2 =3D ((~gateway-&gt;netmask) + 1) &gt;&gt; 1;</span><br><span>=
         r1-&gt;flags =3D RT_DEFINED;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        r1-&gt;table_id =3D 0;</span><br><span>         r=
1-&gt;gateway =3D target;</span><br><span>         r1-&gt;network =3D gatew=
ay-&gt;addr &amp; gateway-&gt;netmask;</span><br><span>         r1-&gt;netm=
ask =3D ~(l2 - 1);</span><br></pre><p>To view, visit <a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2227?usp=3Demail">change 2227</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2227?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 release/2=2E7 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1d516=
b1acee3edc2a69c670d62f49e3cd34d6dc7 </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 2227 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru =
&lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ed=
e&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;open=
vpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--idFeIQtKTU0=--


--===============6442286063176282683==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6442286063176282683==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6442286063176282683==--

