Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA23606A324
	for <openvpn-devel@archiver.kernel.org>; Sun,  1 Nov 2026 11:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=iaPaykDD;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Q9pOBcBC;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=NfH8uG4R;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Ol8dJPhE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=84PHDegafvqAjfHQ7//NB/xHafjhbPdFyt5teD4sTfg=; b=iaPaykDDqaWC7U8izZ4mCSOTr6
	gRh9DZQchlLQhZP3V0Y908oNA9s4NZz6ZIYgITlj3nm1Pibw2xXjJhztXTbjvmXjn2ROGLhMXHVx7
	jhI7nAZMwZATVejfw0G7VTHMTPsKT8J86rT9c8oRUUlNvhbbOZ9yjAJm4tmcEl/zRXqE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNU2A-000000007gJ-3YEx;
	Sun, 01 Nov 2026 11:47:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNU2A-000000007gD-0M57
 for openvpn-devel@lists.sourceforge.net;
 Sun, 01 Nov 2026 11:47:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=b8HrHQaNvwsNFPtBJg6kx18VLrvMw4G/ll8cKjk1lDU=; b=Q9pOBcBC6aPVwKhwkLviBoUC0Y
 BcQrfPAzGJK47Tt1IEWXaOp5xkSDylYzJzKNoC4+Pg1GQZNZzPgXDefHUskuEy9SDLAuaAXHVZYqG
 t1smTex6lCQ2WUylg1U7E/KDpmLDnIH22bPhRaWsMit6F1a2aVxcuf68GyvQ7HA2PhPs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=b8HrHQaNvwsNFPtBJg6kx18VLrvMw4G/ll8cKjk1lDU=; b=NfH8uG4R5gHc59lKMXmRlgaUB1
 uKKc8Bgn/DzC81PmfvkklxBq107s7hRMjiFT1Lq1GO5tSqhFmEfGxwfpwTKmWniRy4GtySDuyP6PY
 ODPee+sUe8KlLYYpTidlYxs1ci+AFkndYEzzBpFJUk0E7m0RS13IQH0GTvKI26c02Sl0=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNU29-0000000008j-19J8 for openvpn-devel@lists.sourceforge.net;
 Sun, 01 Nov 2026 11:47:33 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48b042c0759so1029475f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 01 Nov 2026 03:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793533647; x=1794138447; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=b8HrHQaNvwsNFPtBJg6kx18VLrvMw4G/ll8cKjk1lDU=;
 b=Ol8dJPhEMNJBdh+J396h9EOLoFQBCxU8XZVyDZliqK09C6NxE5IckhFsvIfiQKycP4
 +UqpxaIZjS5OFxq1nrl4aph4F/tpcrdCrJuz6+T5fJSJuRTduS5YpDyU4h8kJua/yyYs
 G0p8gqBhnTNPddmXtV5r1/3qZ+3NWhl4q4H9Svp540u3Qssxc6j5/cjN9PrsFxBgyw92
 8IrCZt5wT7GBVT33Z7qdigwGVsv9ojqn/6diVQvM2P5ygnYbCWX9u050mNX/SLmz4eVJ
 0tgrFjkHEWB0Gvfj4xbIAa3qQ+KVfpkkTq1AtXJoN0ygh/qf4ROvuwzUwGN62woTTllz
 4eMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793533647; x=1794138447;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=b8HrHQaNvwsNFPtBJg6kx18VLrvMw4G/ll8cKjk1lDU=;
 b=VxFD2hBERXkSBXy7U/712u/XPVSr1uL431pmNuLut7br9NaMHukFTaIXTniSai/9tG
 4cLLygUc1A/slIovHJ5zzWMqbkR2JVRDXqP+s2+hhGThb931v8qq77BsB5s6jmEeuj/P
 W2keYSnTDuPzRsqqFACxfk1ngYK6ovc6LHate1UdtjIuzmue8IhYI8btHTVbgRJpqp9g
 to1KDR4pmLRc0Z1mr8/yQV+ugRI0V3JW5ItT6afUInmSeQdg1YWcFbQkMJprg6tsh7QK
 DwSe7idb4Xip9dlNDlqg+QENiz+iXHrPDhxgX7tD1OAExiyoHiWgCTD12qr4H3QGDQy/
 0HiQ==
X-Gm-Message-State: APuU4Z+DfUIYpp3sbWIst7wcKOpIn31hU+sSLt6ko8G0m4IzOc7K1xKm
 5ZpnyqmffQ8GlDl9lf6TOASRynleCVbOa32XGosoxWEyer9Xew9f58k3H/qCZbhxSRtYLYDvOw3
 hqHUKpKaHaw9o2vYBwTE6qCFH3eyKbxvBFZ79c0yCGw1+YBJqDKhu1Blhk19UXmMaVjsCpARSXg
 6L/XvOxg==
X-Gm-Gg: AYBFou0qcdpErrAZtR7APY4X3nqXZ21fsSTOadzgJeJQWkJhugTsj5BifRXyRukm1CH
 zIXBeCkocf42yCvFjxupAaVTPACKavfpFO65yChaSEx78uCSRwSPO6M3FqHng8TYyVkzqc9vnz/
 RCL7YF+TSs0aee1+2MdUtMNEc1euThnvVaVUig9Ii6PSWQsfsiiie+sOXb6cf56ftNiwKJaMX7E
 /70tZTBIcdjwTaL0uAnEV4cG6RHXsjCeLBJHzjM+80tMS9panV+uBCbxecY1RQDbmLjyEnGhEk8
 j1A+FymgCCmP9Cfa8OcTAyCiuE/NRueyHSRUrvoUR0y5Lsb+fHg9vZXMHUCDemrgzvRO5+eIiR/
 tbvYeyDAdacA0owmNF8QQtMMb82o1ftL+W+aPU8ovTDV3V4wYeMQP++bGUbnHe1ISaaCw/Uatjt
 gahjaR4WmqwJwvpF5Hq9pDumboG/rx0DatovtZL1+y74nFEhOH8gxztio0p5XR/EL3A9ooAku29
 Zx0yBNzn7xuze/86lkarAuVzOdBlR1ykf/v4M2cq/dmQX1zAR3R7rIwoAIZK4mM11oG++wzJ0X+
 Z+toWDt+I/rDyHo/01/y+01U18yDvcdwgkm+3xG0jCe6jR3/r5oT20riqELS1kGNj2xpG8sMznX
 2UiPi9LqETp+LnlnR+hOipCn6sOhKzRBc2Dn9I8GFYWMlzK+piMbIY1Y68yQF0jOGC5H9gj09Zd
 Xqubgn8AcU1bC455eBQy33cU5V2uPbt0kM54I=
X-Received: by 2002:a05:6000:3111:b0:48e:7b12:ac9f with SMTP id
 ffacd0b85a97d-48e7b313682mr7957527f8f.40.1793533646572; 
 Sun, 01 Nov 2026 03:47:26 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b723bfsm13020738f8f.15.2026.11.01.03.47.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 03:47:26 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 1 Nov 2026 11:47:25 +0000
To: Heiko Hund <heiko@openvpn.net>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I5aa1a838afa924df292e630efb173c3b1dc5b407
X-Gerrit-Change-Number: 2072
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2072?usp=email>
X-Gerrit-Commit: 5f28589175a1cda2f5bf675e93655db229cb4116
In-Reply-To: <gerrit.1793298866000.I5aa1a838afa924df292e630efb173c3b1dc5b407@gerrit.openvpn.net>
References: <gerrit.1793298866000.I5aa1a838afa924df292e630efb173c3b1dc5b407@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMjk4ODY2MDAwLkk1YWExYTgzOGFmYTkyNGRmMjkyZTYzMGVmYjE3M2MzYjFkYzViNDA3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <75bfaca8fcb9709c96c23ba60a5baab81d701b03-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNU29-0000000008j-19J8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: cmake: don't prefix
 the event message DLL with lib
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1996071577333574437=="
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1996071577333574437==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BUoRk+Y2N10="; charset=UTF-8

--BUoRk+Y2N10=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by Heiko Hund=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2072?usp=
=3Demail )

The following approvals got outdated and were removed:
Code-Rev=
iew+2 by R=C4=83zvan Cojocaru


Change subject: cmake: don't prefix the eve=
nt message DLL with lib
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

cmake: don't prefix the event message DLL with lib

MinGW builds=
 named the DLL libopenvpnservmsg=2Edll, while the event log
expects openvpn=
servmsg=2Edll=2E

Change-Id: I5aa1a838afa924df292e630efb173c3b1dc5b407
Sign=
ed-off-by: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Acked-by: Razvan Cojoc=
aru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2072
Message-Id: <20261029221700=2E30289-1-gert@greenie=2Emuc=2Ede>=

URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2E=
net/msg40305=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
-=
--
M src/openvpnserv/CMakeLists=2Etxt
1 file changed, 2 insertions(+), 1 de=
letion(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/72/2072/2

diff --git a/src/openvpnserv/CMakeLists=2Etxt b/src/openvpns=
erv/CMakeLists=2Etxt
index 2cc4a93=2E=2E35f1efe 100644
--- a/src/openvpnser=
v/CMakeLists=2Etxt
+++ b/src/openvpnserv/CMakeLists=2Etxt
@@ -69,7 +69,8 @@=

 if (MSVC)
     set_target_properties(openvpnservmsg PROPERTIES LINK_FLAGS=
 "/NOENTRY")
 else()
-    set_target_properties(openvpnservmsg PROPERTIES L=
INKER_LANGUAGE C OUTPUT_NAME "openvpnservmsg")
+    set_target_properties(o=
penvpnservmsg PROPERTIES LINKER_LANGUAGE C OUTPUT_NAME "openvpnservmsg"
+  =
                                                 PREFIX "")
     target_lin=
k_options(openvpnservmsg PRIVATE
         -Wl,--entry=3D0
         -nostdli=
b

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2072?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5aa1a838af=
a924df292e630efb173c3b1dc5b407
Gerrit-Change-Number: 2072
Gerrit-PatchSet: =
2
Gerrit-Owner: Heiko Hund <heiko@openvpn=2Enet>
Gerrit-Reviewer: Arne Schw=
abe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <raz=
vanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>

--BUoRk+Y2N10=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by Heik=
o Hund=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2072?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">cmake=
: don&#39;t prefix the event message DLL with lib<br><br>MinGW builds named=
 the DLL libopenvpnservmsg=2Edll, while the event log<br>expects openvpnser=
vmsg=2Edll=2E<br><br>Change-Id: I5aa1a838afa924df292e630efb173c3b1dc5b407<b=
r>Signed-off-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt;<br>Acked-b=
y: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2072<br>Message-Id: &lt;20261029221700=2E30=
289-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/=
openvpn-devel@lists=2Esourceforge=2Enet/msg40305=2Ehtml<br>Signed-off-by: G=
ert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpnserv/CMa=
keLists=2Etxt<br>1 file changed, 2 insertions(+), 1 deletion(-)<br><br></pr=
e><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/ch=
anges/72/2072/2</pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;"><span>diff --git a/src/openvpnserv/CMakeLists=2Etxt b/src=
/openvpnserv/CMakeLists=2Etxt</span><br><span>index 2cc4a93=2E=2E35f1efe 10=
0644</span><br><span>--- a/src/openvpnserv/CMakeLists=2Etxt</span><br><span=
>+++ b/src/openvpnserv/CMakeLists=2Etxt</span><br><span>@@ -69,7 +69,8 @@</=
span><br><span> if (MSVC)</span><br><span>     set_target_properties(openvp=
nservmsg PROPERTIES LINK_FLAGS &quot;/NOENTRY&quot;)</span><br><span> else(=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    set_target_prope=
rties(openvpnservmsg PROPERTIES LINKER_LANGUAGE C OUTPUT_NAME &quot;openvpn=
servmsg&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
et_target_properties(openvpnservmsg PROPERTIES LINKER_LANGUAGE C OUTPUT_NAM=
E &quot;openvpnservmsg&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                                                   PREFIX &quot;&q=
uot;)</span><br><span>     target_link_options(openvpnservmsg PRIVATE</span=
><br><span>         -Wl,--entry=3D0</span><br><span>         -nostdlib</spa=
n><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2072?usp=3Demail">change 2072</a>=2E To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2072?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I5aa1a838afa924df292e630efb173c3b1d=
c5b407 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2072 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: Heiko Hund &lt;heiko@openvpn=2Enet&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83=
zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>

</body></html>
--BUoRk+Y2N10=--


--===============1996071577333574437==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1996071577333574437==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1996071577333574437==--

