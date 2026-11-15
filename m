Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A210606A31D
	for <openvpn-devel@archiver.kernel.org>; Sun, 15 Nov 2026 16:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=RkTK5nRL;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=WeK3P06a;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=BtdUdw2E;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Zb349fKL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=JM8L9eirafqNopRf64+JkLsDWjXEaRdn79Koh7pNSg8=; b=RkTK5nRLNMXmnv9k54w8D2OxrE
	AzSVEBA9PlTugui8vIUD4YcF5Au+C4HAZnR3LwrVcYQg6c1IkC0vgFZcl9YgBN9j9WG3MJ85Jeu04
	BoUE3Tg0upex0gGN6IHnmfc7Cqvm1CzYkODwhSLyVTcpUIM4pWqgNgNEJxgc/SBG3B4s=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSdBZ-000000002dj-07AA;
	Sun, 15 Nov 2026 16:34:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSdBY-000000002dd-0Qqj
 for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 16:34:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2wmKrgWVxa1b+YTlRgrxvY/uBVPEXv4a4MXBh3w+Pmk=; b=WeK3P06a5KNCpCfNHJ5aJtzqX8
 g1kEXCMMI6ae7AzRP2e2RDKn2kl5GwHTt4vQB9hPE4I+8IfpjPfxm8nmzegrrzDB6IC89/b1A4gzT
 /29LRQaXEhh+hqN6sanlA/urh1i98yORgWE39E412oMB5+/irFpusf3Ux3wEIQFlRgYs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2wmKrgWVxa1b+YTlRgrxvY/uBVPEXv4a4MXBh3w+Pmk=; b=BtdUdw2E99RTQEXzekHMGbeagA
 rDp7D3dBfwc5Ozs0+Y/3ZxT2kVf0WWMRmPlYev1SoBKg4JzvbIiiphF+5YTmihkLAif7l9N49c8VS
 QZqBMvHHfMBo5easDmO4Tii3UNGPthAM4P4fnmNGI3hSK1RideataqDgD1/Ew2CwOv0w=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSdBW-000000004Td-3I8T for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 16:34:31 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-49134c8509fso2709738f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 08:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794760464; x=1795365264; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2wmKrgWVxa1b+YTlRgrxvY/uBVPEXv4a4MXBh3w+Pmk=;
 b=Zb349fKLGyEUdlzik8Jp4XLUJu+eFXnckgOF0ZufZZMqqmEuKDGBMRv5v8+e8vEkHk
 tNiDiC53mOYSTAGNK9bPCE5mISAY8jA69051nqAVecuu4+QS4r2WBA/YEloTdATKRcFD
 VIl1Uvu27ZXkjU+rg1uUeq6EttwJBN5u4CwNrru0zs9DGUB+2m1VDdZsCLU/4P2xCcl7
 twkvWNzKaTYB17JqUJjEY9IOQTJu/6rIAPIKtrfgkolvZfrs7rvUcNjTOa8SdeEw3u+K
 uyNuszFw0K0JaYaBlpiB0po4ffX3NoxBkne+jVjyXzohZj3n5w+LqjYgeWRJexgzgspq
 IUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794760464; x=1795365264;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2wmKrgWVxa1b+YTlRgrxvY/uBVPEXv4a4MXBh3w+Pmk=;
 b=H2PMiKt9NyKbhNpXPd+13FySsfbhpJL4gJxOpZtByTy2xACZGyFFmNz2XtyuMSKSUh
 5t8leuI+X4TN6hYAmCLHtGiXh4/+LXDV4ezvxkWfBntF37WQDO0HHZtFCy8eaOjOWAMN
 8GltDa+nLSifqq/T/ToQaKLlZIZtbDZIDBy7uukJKZ/jBCZDd2zFxRvb1X2E7yPoGjmv
 q0OMSDlu3lbu1N/3sJV1HxbseOp3dn1jzULRcEOiCHDVoysrHm+mCRqUK0KKFOoMg1VB
 mqv/nFO0JRpYyiCNmTnmIg/J3mKLaYrK9zs9t03SO/six6M2xd7kL6qPvT54rq/22hAz
 sTBg==
X-Forwarded-Encrypted: i=1;
 AL+hErGsAq33Z2mZXkrOnvzVam1ADMqik0VPIImZf0R88zOLap6KByXbyqm9hrlvtB2Dj9qAbyZ+ExBI7fwI9mah@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/SaT0FsqTgZkAT1RzEn0lpogbEe09ywho6lmoPyalwYWljkbAN
 /AtW9jdYKwVb7G4PXWy3uKQkFbAqCNFGlj90bSxykLBvjY/JUAPeb490Nj7es/KzTy6XRx9fDWF
 mnVKHqR6OybwFB+bdxwV1NIqrL8dqmtM92icNT64kzZEZ4ErlMR87EMZacwscJBV1YLEh
X-Gm-Gg: AYBFou3ne+553eXXydauqGoTcpk5cwHelITAbRWcpgr2M27E6YLx79Ll4bnc7mQC9n+
 RZh+djOsSVXZnZOA37VfCYj0nZmH3zOk3XWD3Sfy3mi9rj42yP8klyk2FICb6gnx1tIX8nHqzK2
 hbsl2Hvid7tYBvsbQYpGSXEVn4GhVPBdnhJMPYcHAHC21FK8cycwWrxNvBpwDGdSD/eGK45R9lL
 VqTDBuexbIaI0xNGM5NBSK75cmId4HrgdRbi9GTqH1M+g9OsaFScP6xxvHJ1HrNv0IXDIplDlb2
 rZrhCT7eqUP8+Q4JHz2umSX759YTNUiNaNMVl+thTaeU85YSB9e9yIU3OYW2M9FNXbrIQBi+kye
 Ry9VlYg9EjEmaGlZ5I0eVYbVzecaAVXUx4o2DfdB3qR1g2pCehQag8Re0bAWyt5qmnzsFmi3K7w
 6OmuLcGdi1oWwu6wz7mP/WcD5D4H4G51miaYJAXTUh5pgX9ohVk9C/eV0qJRysSP57BPNRW+P6I
 i8LESFVZaQcixgPb3+R1apjHqjvEEg3B7Jxd6pyXR74gY7QOXomEPkpcdpKH91UvGb6lQp1isLp
 RBQh5V4LSUUDFGxAuzUQkj8NeFDc+egC8m9A5U34EKfalAVcsRLa8W+qLmDsEGcNTbOBIPwsjTJ
 uwjyWo6cQQOGtNzklf0XlUttxetHSUF3+MlF4goNM/pH2ijIk1ekJSam1dv7VbCZKmPlk+EjIro
 uUk1ShiYpguvXhaFDI
X-Received: by 2002:a05:6000:46c2:b0:48f:db47:6ebf with SMTP id
 ffacd0b85a97d-49c729bb31fmr12136451f8f.38.1794760464045; 
 Sun, 15 Nov 2026 08:34:24 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c77393700sm16600979f8f.18.2026.11.15.08.34.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 08:34:23 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 15 Nov 2026 16:34:22 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I5ab959e7101cf801ac93e5185855e75db0fb6225
X-Gerrit-Change-Number: 2170
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2170?usp=email>
X-Gerrit-Commit: a52f1c50b0e6ac0fc9d4b565389aada48da696b5
X-Gerrit-Comment-Date: Sun, 15 Nov 2026 16:34:22 +0000
In-Reply-To: <gerrit.1794340380000.I5ab959e7101cf801ac93e5185855e75db0fb6225@gerrit.openvpn.net>
References: <gerrit.1794340380000.I5ab959e7101cf801ac93e5185855e75db0fb6225@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzQwMzgwMDAwLkk1YWI5NTllNzEwMWNmODAxYWM5M2U1MTg1ODU1ZTc1ZGIwZmI2MjI1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a4b3605c7c0cb2a68c55e15de4877b2c99fe4329-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xSdBW-000000004Td-3I8T
Subject: [Openvpn-devel] [M] Change in openvpn[master]: DragonFly: bring
 things back into a working state
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2792343495042494170=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2792343495042494170==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HD6ix2hTTS8="; charset=UTF-8

--HD6ix2hTTS8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Gert Doering has posted comments on this change by Gert Doering=2E ( http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2170?usp=3Demail )

Change subject: =
DragonFly: bring things back into a working state
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3:

(2 comments)

File src=
/openvpn/tun=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2170/comment/=
201bf7df_6b687953?usp=3Demail :
PS2, Line 1018:           defined(TARGET_OP=
ENBSD) */
> The comment on the `#endif` no longer matches the comment on th=
e `#if`=2E
Done


File tests/t_client=2Esh=2Ein:

https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2170/comment/b1a093a2_b84115cb?usp=3Demail :
PS2, Line 2=
15:         FreeBSD | DragonFly | NetBSD | Darwin )
> There's a stray space=
 in `Darwin )` that the other cases don't use=2E
Done



-- 
To view, visit=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2170?usp=3Demail
To unsubscribe=
, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: I5ab959e7101cf801ac93e5185855e75db0fb6=
225
Gerrit-Change-Number: 2170
Gerrit-PatchSet: 3
Gerrit-Owner: Gert Doerin=
g <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-At=
tention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arn=
e Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Sun, 15 Nov 202=
6 16:34:22 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-R=
eply-To: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>

--HD6ix2hTTS8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Gert Do=
ering has posted comments on this change by Gert Doering=2E</p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2170?usp=3Demail">View Chang=
e</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0;"><p>File src/openvpn/tun=2Ec:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2170/comment/201bf7df_6b687953?usp=3Demail">Patch Set #2=
, Line 1018:</a> <code style=3D"font-family:monospace,monospace">          =
defined(TARGET_OPENBSD) */</code></p><p><blockquote style=3D"border-left: 1=
px solid #aaa; margin: 10px 0; padding: 0 10px;">The comment on the `#endif=
` no longer matches the comment on the `#if`=2E</blockquote></p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></=
li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File tests/t_client=2E=
sh=2Ein:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin=
: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2170/comment/b1a093a2_b84115cb?usp=
=3Demail">Patch Set #2, Line 215:</a> <code style=3D"font-family:monospace,=
monospace">        FreeBSD | DragonFly | NetBSD | Darwin )</code></p><p><bl=
ockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 1=
0px;">There&#39;s a stray space in `Darwin )` that the other cases don&#39;=
t use=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap=
; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2170?usp=3Demail">change=
 2170</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2170?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I5ab959e7101cf801ac93e5185855e75db0fb6225 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2170 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Gert Doeri=
ng &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mai=
lbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
omment-Date: Sun, 15 Nov 2026 16:34:22 +0000 </div>
<div style=3D"display:n=
one"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Ha=
s-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--HD6ix2hTTS8=--


--===============2792343495042494170==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2792343495042494170==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2792343495042494170==--

