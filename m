Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41C3BC88E53
	for <openvpn-devel@archiver.kernel.org>; Tue, 15 Sep 2026 10:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lViFCHcNWAktFmFeb6X2BnufmMyw2idXDA5Kk3j8zWI=; b=KQ6A9XQ1ZU1MzMRbpaX7wU6ae0
	oGEwXIDCFZ1yq5DboULWjh8Bq8TLcytJr/MmPESNLD915nxPetLoroprVK57m83ySjeX0SxsB8+RQ
	3zlVxPBbx9XfW3nuKSO3GDh5R2eNJyqJQBvAvlqpw/93YSAdroemNaVb0VxL6oRnyd3k=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6QT0-00083J-H4;
	Tue, 15 Sep 2026 10:32:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x6QSy-00083B-Pm
 for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 10:32:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=0unUnIdIRU8FLUsU8cfs9nWoesQUM/Rm3u1VIhaU/H8=; b=UFcUBSI/eJmc6Y8PpBNmd3D6gJ
 QWLI1eiqjKwZMWxVjvJwTxIYYvPP2Sb8Fkx49vTZIXCAmrO2COXQkYQMqEIKDIul5kRnBgkWg5tOI
 6JnssoqzMZ0QAVlSupZGfsSLiNdYNKv90mv8gkejpaC58wDnLdjvy8lBYgFbsFJAWxnE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=0unUnIdIRU8FLUsU8cfs9nWoesQUM/Rm3u1VIhaU/H8=; b=d
 RHAGQXSi3G9cuZRB8FoIIpLjHTEyxvEJJGKaQg5SCR/bLEXrewDXVzNvsjBdrexLPBn406DwIEnoZ
 RXJapMZf0EiwSJSRYqbRn1xJRdPdz6QX/ORMjTepx91Jdh8JMrhGjMItAI6fFLCw5/2oZFBSfijP9
 7SBhPi8yK5pXN8To=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6QSx-0006zK-C3 for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 10:32:44 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e7bcb94d3so856015e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 15 Sep 2026 03:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789468357; x=1790073157; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0unUnIdIRU8FLUsU8cfs9nWoesQUM/Rm3u1VIhaU/H8=;
 b=J7rXUzwRuZffkCZCyPpeoMHkrc94+fcJ8ilLcPHZREDCa3rcMPqibC+SidDUaUtKNs
 rXE2tWABi40ttrthx1qqCciUEYN+IUXUrPc4vhJ+PPeOgexSaaH/JRbQ67oZ7ytdG1AS
 jelG0wj+R2mHipZENVoN7VfJ+O4eAFQDUY2azFlJfmSkm4y2QFK/3bi7ZUfzYwSohI5+
 M85inHShSJOqnvA0Osr/yDRxoi89yHAw6VFZ/ee84mOzmJcO4FD3ukB1XyZVI3MZbAFw
 H91aEW04leyAgtZN6GpOICPK5sYXfvxHOLqomB19zzjb34/xzIR7Xtw21mEH8/YzRfGk
 VFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789468357; x=1790073157;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0unUnIdIRU8FLUsU8cfs9nWoesQUM/Rm3u1VIhaU/H8=;
 b=hShStH2F45Po3mXTI0WCAg+hFsvAVmeuAVTDF+QRTjdIV2L+cAgXtq0sOnOAFSSF89
 YUOgKxzNdPFX0tziv+3++YI5FzBuJyPs6V6lczvqWIznykSVjnlnV0kofDhgjk95SKTK
 bYbkFw+k+P7HNI6YU0o9UNE/jUxYEi21TrbFlvIpTR2nvF9vbyAhSZ/OpDkOABakOmAG
 jL9esahEkcmKTgId4h6xl6IqhQSAE0S+2VKdUrgP7M2Ja6qKq+0uxWBgJXlnju5tw8oF
 R9FLUAO7Yp0JaMEJGM9EDPeMwolYxRjw5EMYdmYpbDeQ5WtQi7R8uAjJ8Rw8YpSLREkt
 kOww==
X-Forwarded-Encrypted: i=1;
 AKwUvBxB5jCeYgYJjBtRXZmt1gP9vtqGTeo4zn3awnPt1/GX5m+y79bH3Rnk6ogqDio+EfkjSNDgHGxhVlxFdK1a@lists.sourceforge.net
X-Gm-Message-State: AFuF++m//O1JLddW7KebQhHEnoNZuckZgA2WRj+cenJtiPle9DlQ1NxM
 iFmley9B+rnq/ExqQfsXpE2LSAKXK0bLvh/2rnWLdbv04j1uWQztmqks6PVcLOnokVT0szapCz4
 xCOJ8ko6mLSM+56dUhxYw7cgQj9a2AGfiwh0wpqHwWd+gHl+ERb8PHNiaUMbZvCqt0eZLtXvEWt
 MSnVedqw==
X-Gm-Gg: AYBFou0usLEfF9vryQ6Z6Wky9hFimEBHimWW5v2xTbwdlb14Xt+0RjtPRKDTINvYCdU
 fzO+Kuvpc/bvsiFocJGVSPHYoF2HHJ3M2jZnactKB6fvvNuNWL4J0xCiUO7wqxqQuvz5NBXchwy
 Ee/xUTBllu3GrWED1auYIUAdlsNwBflfWESP2MXJnpJsm/D4zu6MyfyVUD1RnZ44x2gyLC46jSz
 hXdaJpPYSPwkl5YwPnTY5qWIHv9ZuXFgMSrRKWIfYg9TQS+6s8iW3rrnBSrD4lMdLPDkCRslDYs
 wYDd/nK2mRB5pUKLdja2jPSKUmn6XeeLwOiKBELYg3fkATG8hVX+7O8TF/+PF+epVO6EXOpcLWJ
 Vj8qRXPKndDQxaDRiR4L+/V9/cBg2Sobp+tO00L1wwlBZyVvYAu7TufTzYxthPWmstW06UmvLMq
 MUUiJUq/E3zLNYhUvZHrFLnNja5xLsF0Prh3HyI+9I7MVvS7188HbCtJcH68O7hHP/14G9Ew4p0
 igAdiPROuwSXmpCem1FR2qnQDcRo3hbx8WfSwEnp9utTNZI8eJ3iy3gplRE/AK2kA2h0A0vUb93
 478vuO2OfwZotrcyOM4bu827VXLe3L9XTMazvY38sYsV3wbJASpq5RPZwMXohw==
X-Received: by 2002:a05:600c:c4a2:b0:49d:1842:f001 with SMTP id
 5b1f17b1804b1-49e8224ff79mr7777485e9.14.1789468355743; 
 Tue, 15 Sep 2026 03:32:35 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e7d695677sm61660325e9.5.2026.09.15.03.32.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 03:32:35 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 15 Sep 2026 10:32:33 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 22
X-Gerrit-Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2
X-Gerrit-Change-Number: 1747
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1747?usp=email>
X-Gerrit-Commit: 0e4f26ec62f719eb61db55882e367f47586a8483
X-Gerrit-Comment-Date: Tue, 15 Sep 2026 10:32:33 +0000
In-Reply-To: <gerrit.1782719911000.I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2@gerrit.openvpn.net>
References: <gerrit.1782719911000.I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk1YTdlOWUxM2I5Zjk1NDhiN2ZmNzE3ZGFhZTJiNGE5Y2RlM2MwNmYyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <adaab00fabf21e1bc7298bc3409a4438309670ed-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x6QSx-0006zK-C3
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Add
 --server-probe to order client remotes by probe
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
 ralf@mandelbit.com, lstipakov@gmail.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7660043842938838128=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7660043842938838128==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cuv9xgTsCgI="; charset=UTF-8

--cuv9xgTsCgI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: stipa=2E

plaisthos has posted commen=
ts on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
747?usp=3Demail )

Change subject: oob: Add --server-probe to order client =
remotes by probe
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 22: Code-Review-1

(11 comments)

Patchset:

PS22: 
I did a=
 quick read through the commit but not a full review but already found a nu=
mber of issues that should be fixed first=2E


Commit Message:

http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1747/comment/5e2b0b35_46e51f5d?usp=3Demail :=

PS22, Line 11: PROBE_REPLYs within a short window, and reorders the connec=
tion list so
Is that short window documented


File doc/man-sections/client=
-options=2Erst:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747/comment/0a3=
b73e5_829dcd00?usp=3Demail :
PS22, Line 624:   skipped and the configured o=
rder is used=2E Remotes that answered are tried first, in the
so this imple=
mentation breaks with dual stack? That sounds like a pretty big omission=2E=



http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747/comment/296e8b62_ededbb8b=
?usp=3Demail :
PS22, Line 627:   attempt; a restart does not probe again=2E=

restart? What kind of restart are you talking about yeah, restarting the o=
penvpn definitively will run the probe again=2E


http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1747/comment/a2086cb4_3cacb127?usp=3Demail :
PS22, Line =
632:   client whose clock is badly wrong receives no replies and keeps the
=
The RFC draft has a different stance on this=2E Is the implementation here =
different from the RFC or is the documentation wrong?


http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1747/comment/ccb384f9_65f1fb7f?usp=3Demail :
PS22, L=
ine 634:   ``--remote-random`` produced=2E See ``--server-probe-reply`` for=
 the
Yet, I see no warning for using both together=2E


File src/openvpn/oo=
b_client=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747/comment/4ab4a=
ed0_dae8713d?usp=3Demail :
PS22, Line 523:      * get a probe socket=2E */
=
This duplicates the do_preresolve code=2E What is the reason you could not =
just set that flag when using this code but had implement your own preresol=
ve loop here?


File src/openvpn/options=2Ec:

http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1747/comment/1035552f_ab991838?usp=3Demail :
PS22, Line 818: =
     * the built-in default) applies=2E */
> otherwise each server's advert=
ised margin

This is again different from the RFC, in the RFC iirc we use t=
he the margin of the best candidate=2E This sounds like you are using the m=
argin of each server=2E 

Both approaches are valid but we should either ch=
ange the implementation or the RFC to match each other=2E


http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1747/comment/2260c1a2_ab0f0d67?usp=3Demail :
P=
S22, Line 5102:                 msg(msglevel, "--server-probe: max-latency-=
diff must be 0 to 65535 ms");
This sounds like you could have values over 1=
000ms while the man page and documenntation says that you spend a maximum o=
f 1000ms to actually probe servers=2E Is this for later allowing to extend =
the window? 

Otherwise it should at least give a warning that server over =
1000ms are ignored anyway because of the short probe timeout=2E


File src/=
openvpn/socket=2Eh:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747/comment=
/c4a7a63d_5278fcd8?usp=3Demail :
PS22, Line 413:  * Hand @p fd to the VPNSe=
rvice API as a protected socket, so its traffic is not
I remember we typica=
lly use \p instead of @p in OpenVPN 2=2Ex Not sure if we have an agreement =
but I mostly see the \keyword variant=2E


File tests/unit_tests/openvpn/te=
st_oob=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747/comment/c104f29=
0_98fd8b7d?usp=3Demail :
PS22, Line 528:  * and a second reply from that ad=
dress credits nothing more=2E */
> * and a second reply from that address c=
redits nothing more=2E */

Can you rephrase that? That is really hard to un=
derstand what you mean here=2E



-- 
To view, visit http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1747?usp=3Demail
To unsubscribe, or for help writing ma=
il filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2
Gerrit-Change-Number:=
 1747
Gerrit-PatchSet: 22
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerri=
t-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_li=
ci <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Es=
ourceforge=2Enet>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Co=
mment-Date: Tue, 15 Sep 2026 10:32:33 +0000
Gerrit-HasComments: Yes
Gerrit-=
Has-Labels: Yes

--cuv9xgTsCgI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: stipa=2E </p>
<p>Patch set 22:<span style=3D"border-r=
adius: 3px; display: inline-block; margin: 0 2px; padding: 4px;background-c=
olor: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1747?usp=3Demail">View Change</a></p><p>11 comments:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747?tab=3Dcomments&amp;=
usp=3Demail">Patch Set #22:</a> </p><p class=3D"blocks" style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">I did a quick read through the commit =
but not a full review but already found a number of issues that should be f=
ixed first=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>Com=
mit Message:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"ma=
rgin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747/comment/5e2b0b35_46e51f5d?us=
p=3Demail">Patch Set #22, Line 11:</a> <code style=3D"font-family:monospace=
,monospace">PROBE_REPLYs within a short window, and reorders the connection=
 list so</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word=
-wrap: break-word;">Is that short window documented</p></li></ul></li><li s=
tyle=3D"margin: 0; padding: 0;"><p>File doc/man-sections/client-options=2Er=
st:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; =
padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1747/comment/0a3b73e5_829dcd00?usp=3Demail=
">Patch Set #22, Line 624:</a> <code style=3D"font-family:monospace,monospa=
ce">  skipped and the configured order is used=2E Remotes that answered are=
 tried first, in the</code></p><p class=3D"blocks" style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">so this implementation breaks with dual sta=
ck? That sounds like a pretty big omission=2E</p></li><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747/comment/296e8b62_ededbb8b?usp=3Dem=
ail">Patch Set #22, Line 627:</a> <code style=3D"font-family:monospace,mono=
space">  attempt; a restart does not probe again=2E</code></p><p class=3D"b=
locks" style=3D"white-space: pre-wrap; word-wrap: break-word;">restart? Wha=
t kind of restart are you talking about yeah, restarting the openvpn defini=
tively will run the probe again=2E</p></li><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1747/comment/a2086cb4_3cacb127?usp=3Demail">Patch =
Set #22, Line 632:</a> <code style=3D"font-family:monospace,monospace">  cl=
ient whose clock is badly wrong receives no replies and keeps the</code></p=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">The RFC draft has a different stance on this=2E Is the implementation her=
e different from the RFC or is the documentation wrong?</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747/comment/ccb384f9_65f1f=
b7f?usp=3Demail">Patch Set #22, Line 634:</a> <code style=3D"font-family:mo=
nospace,monospace">  ``--remote-random`` produced=2E See ``--server-probe-r=
eply`` for the</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap=
; word-wrap: break-word;">Yet, I see no warning for using both together=2E<=
/p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/=
oob_client=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D=
"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747/comment/4ab4aed0_dae8713=
d?usp=3Demail">Patch Set #22, Line 523:</a> <code style=3D"font-family:mono=
space,monospace">     * get a probe socket=2E */</code></p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">This duplicates=
 the do_preresolve code=2E What is the reason you could not just set that f=
lag when using this code but had implement your own preresolve loop here?</=
p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/o=
ptions=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747/comment/1035552f_ab991838?usp=
=3Demail">Patch Set #22, Line 818:</a> <code style=3D"font-family:monospace=
,monospace">     * the built-in default) applies=2E */</code></p><blockquot=
e class=3D"blocks" style=3D"border-left: 1px solid #aaa; margin: 10px 0; pa=
dding: 0 10px;"><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wr=
ap: break-word;">otherwise each server&#39;s advertised margin</p></blockqu=
ote><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">This is again different from the RFC, in the RFC iirc we use the the m=
argin of the best candidate=2E This sounds like you are using the margin of=
 each server=2E </p><p class=3D"blocks" style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">Both approaches are valid but we should either change =
the implementation or the RFC to match each other=2E</p></li><li style=3D"m=
argin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747/comment/2260c1a2_ab0f0d67?u=
sp=3Demail">Patch Set #22, Line 5102:</a> <code style=3D"font-family:monosp=
ace,monospace">                msg(msglevel, &quot;--server-probe: max-late=
ncy-diff must be 0 to 65535 ms&quot;);</code></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">This sounds like you cou=
ld have values over 1000ms while the man page and documenntation says that =
you spend a maximum of 1000ms to actually probe servers=2E Is this for late=
r allowing to extend the window? </p><p class=3D"blocks" style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">Otherwise it should at least give a w=
arning that server over 1000ms are ignored anyway because of the short prob=
e timeout=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File=
 src/openvpn/socket=2Eh:</p><ul style=3D"list-style: none; padding: 0;"><li=
 style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"=
><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747/comment/c4a7a63d=
_5278fcd8?usp=3Demail">Patch Set #22, Line 413:</a> <code style=3D"font-fam=
ily:monospace,monospace"> * Hand @p fd to the VPNService API as a protected=
 socket, so its traffic is not</code></p><p class=3D"blocks" style=3D"white=
-space: pre-wrap; word-wrap: break-word;">I remember we typically use \p in=
stead of @p in OpenVPN 2=2Ex Not sure if we have an agreement but I mostly =
see the \keyword variant=2E</p></li></ul></li><li style=3D"margin: 0; paddi=
ng: 0;"><p>File tests/unit_tests/openvpn/test_oob=2Ec:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1747/comment/c104f290_98fd8b7d?usp=3Demail">Patch Set #22, Line 52=
8:</a> <code style=3D"font-family:monospace,monospace"> * and a second repl=
y from that address credits nothing more=2E */</code></p><blockquote class=
=3D"blocks" style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: =
0 10px;"><ul class=3D"blocks"><li>and a second reply from that address cred=
its nothing more=2E */</li></ul></blockquote><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">Can you rephrase that? That i=
s really hard to understand what you mean here=2E</p></li></ul></li></ul><p=
>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747?u=
sp=3Demail">change 1747</a>=2E To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">=
settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1747?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1747 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 22 </div>
<div style=3D"display:none"> Gerrit-O=
wner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;ope=
nvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Tue, 15 Sep 2026 10:32:33 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--cuv9xgTsCgI=--


--===============7660043842938838128==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7660043842938838128==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7660043842938838128==--

