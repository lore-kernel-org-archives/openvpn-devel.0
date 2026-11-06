Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CF76082BC9
	for <openvpn-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=gZ7w/E7W;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=T7uVndpe;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=QkwqlP2X;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=IvgleUKn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=0iOo3YZcwMHhiOchwVzDwYeya1nIq+UAp7QeHKUhUp0=; b=gZ7w/E7WGdsP+50kdLsEJDH09d
	H2gLQOcQCzD5ZBQKiUZtttVdk4Npf3fayWRWl2fr6IQGGeU8mBm86rwS5UUO5wb95SKxYFV52G34r
	93465S7GVyUPRMeGCYb7fBiMEF0pufQOBuw2/LLU5Y3sNP7aw1tLDCKYgx1f9CveebfU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPKFM-000000007UT-0kVH;
	Fri, 06 Nov 2026 13:44:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPKFK-000000007UJ-1oT3
 for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 13:44:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PVo2PbJmRB5VU7QeaXQB/MqWgZ4/k7jI6UypaoRADAE=; b=T7uVndpe3UyYv6ikKPJR6j9Koe
 uA+5kyu+sQoDU8L+0CLVuOmQm8H4O/yx5xhriSilr3LUc7Zs7boSgF62+B0ZYQZ2LgoxdoLQI4kHp
 B3E3En+mkilfEr3vRzf3GJDE82EOCshmRc/bwxBelkIhdyE9BrkpJI8Y0qBvPVTihU+U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PVo2PbJmRB5VU7QeaXQB/MqWgZ4/k7jI6UypaoRADAE=; b=QkwqlP2XcFakOAc74uBG64X/SL
 NeNCfeEQxmdoxZRvGds1sAnJhBIm9e8y/4cRMr+o8YBNLtlmEVVneTfUD35858B53yja6k6fYDw6n
 kEi9Hj4qczjFOsd+Xh/dmwkzWv9OdtqtTGQW8Xf2jEWoiiv/6V/z/RonhmvUcUPyD4U0=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPKFE-000000003np-0Mfk for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 13:44:41 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a5036bbac7so4013625e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 06 Nov 2026 05:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793972673; x=1794577473; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PVo2PbJmRB5VU7QeaXQB/MqWgZ4/k7jI6UypaoRADAE=;
 b=IvgleUKnuT6E3gvXU3SroJDDzHzUCetFEBBWiLfsO2M603JGZ/DWFjirSwWZgVuWXj
 y2TuElYosmxeRXXSPieu0OUIf3Coc7yrr2j8X9Xo0grIkajIl+YQ35d2D7C164qqMhHQ
 +0z5+zVeFpnE1My8uLecG9CH7sqj0+8Ksv8KzkehTI1Z5cGZNm7+SIMDLSAISA4TGmtO
 dmw95U3pZF/dA9+eFGF9TksFKMB2NYUl8l7hiHxjrIZqnmWKeBgOiwTwCiP8WEEBai84
 zxfK/Fz5YZHvWhVZ+KPCR8OOIxyO6FdExHVVqYTVK/+xltDMs8i1iZoZ99r+yuncf11K
 TEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793972673; x=1794577473;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PVo2PbJmRB5VU7QeaXQB/MqWgZ4/k7jI6UypaoRADAE=;
 b=BzpEIjRFUJCw5Rxpcx4m7RNCyfn+/vi3WK7RxTyvE1vungY3Vbjy2LEnVYzgurRR2I
 DvKH2MdIwrXxoU9mqqSwac0FQZ2vSnD3OLOBLs9SqBbJu5vTJMf7jIyMkaxs24YtqbVI
 5htdKRDeUQziCd6kLnQlBc8oNJuiJzs2cdbid8LFSd8u21dY3N1oztqWH4ysyKVM6x4H
 FpB4eIbCfV4R3R+ZxYLxCrZ0v4CGJi5/npLvT4zsdX4gzdYvtGUuLM7evOYv4vGCZLyU
 E2jLBlj0ItGjy5klNoHQQgKaTww3gbJc9pz415ntPx9QM0d3TtzzyL/c9s28hczP8MlJ
 c1nA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzeC+fZHX0TA9bRiad1NdqDZ5Znw1AcBllUeDFX4nmOCsln7A9VM7Id0/+We6foJqR4DldFcovSKCUWWnJh@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+b5oTGqqt9aeQDT0pBllmKfr1WUkt+d19dzyhE9YCpgSuKid01
 MlGLRCmjQ5X22tCue5Ooat7BlzZqe2u3Qafzl5mZEs2QzdDNumoNxzXAKw/z+dUK+6rvt6099Wz
 ktS4yG15XAZfPCr63uNUsW1j9lACGuMF66HwyRt2b6PCkd466qTqR0CtRuWyFMXTFC17rUlxhwK
 7Q5Lh7KA==
X-Gm-Gg: AYBFou39zGaN1QRst8CSmmO7sQVnCDHtyqla/HFpFwiR3cDIqXisw5rXqxd3C8qB0EK
 ztDXe4g1XOcM1oYGuV5rET1FW2ORq7TdGA8ub1E+eoK1ZwbClAsRKPpjaEkDPdCBRnM0x3xw9e8
 XEc/uHZZ4buzqj5E8T2lYAb6cZX9SmeDyqaizkm3UvuwsMxukqo8t3hFNAiPm47WKEzn/wcGiCe
 RfQuk4fNmq+9q/MipG338FfqzSq+hUdAqtjZkghQQB/oQYzTpgWXn3QA01HpPMCEKlYYsI/ocQN
 mHOgaPaiUSnvOPX6qc8D85zZ2v6lIYsXubFvIk+9tBdII6C/ycN2wln4ENwP+7npajdywckz/lY
 a960UQ/GDwRYiF7QE75Q3VHwyysErh9/ClmnZg4V3+BYi9K+bjleNRz6p+3hiMBQ0WgA8TYw6KK
 RLZ7ltHVpc2fVEM1R/C5I89FHBGgXioEBX7Dc1l5RZ6QCPEgG/LoxgA2q19+xA842gDffaIU1rU
 WjzDalj8aESsfI08/b8fCt8X3sHLb3KfqXH6gbDy5FSa36Zd2sobtOru3Rx5+YDEzarzMKIaQYD
 YJESjBtKPqSUqP6l6PZHbsg78QrSRnqTBBR6nde01O2QW8OZqpzMTWIBhN1T2py++tC3UUndzYh
 mhIuHg+Y6xY2FgQWNwkprwzZIrEboBgXC9UsgSOllBp15Pmk10tpvjj8pJ1+u7KvtLVmRZhnWjM
 zwoNUdEIkVF6bg+Q==
X-Received: by 2002:a05:600c:5285:b0:4b0:a307:46f8 with SMTP id
 5b1f17b1804b1-4b6de4a6f90mr44439485e9.10.1793972673218; 
 Fri, 06 Nov 2026 05:44:33 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b73d28cb10sm20005325e9.0.2026.11.06.05.44.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 05:44:32 -0800 (PST)
X-Google-Original-From: "Lev Stipakov (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 6 Nov 2026 13:44:30 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 23
X-Gerrit-Change-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0
X-Gerrit-Change-Number: 1744
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1744?usp=email>
X-Gerrit-Commit: 1f96baff85475aa28360a45022d6a93106f23bf8
X-Gerrit-Comment-Date: Fri, 6 Nov 2026 13:44:30 +0000
In-Reply-To: <gerrit.1782719911000.I930d3789e0313aa0c3bc51ee5fd1d108343d59f0@gerrit.openvpn.net>
References: <gerrit.1782719911000.I930d3789e0313aa0c3bc51ee5fd1d108343d59f0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk5MzBkMzc4OWUwMzEzYWEwYzNiYzUxZWU1ZmQxZDEwODM0M2Q1OWYwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c94a079f672804f4ac4347ea36c5a0487ff52b8f-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xPKFE-000000003np-0Mfk
Subject: [Openvpn-devel] [L] Change in openvpn[master]: probe: Answer probe
 requests on the server (P_CONTROL_V2)
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Lev Stipakov \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, frank@lichtenheld.com
Cc: "Lev Stipakov \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4796572792508335245=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4796572792508335245==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yhSJ+uBcc3k="; charset=UTF-8

--yhSJ+uBcc3k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Ralf=
 Lici, R=C4=83zvan Cojocaru=2E

Lev Stipakov has posted comments on this ch=
ange by Lev Stipakov=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?u=
sp=3Demail )

Change subject: probe: Answer probe requests on the server (P=
_CONTROL_V2)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 23:

(1 comment)

File src/openvpn/mudp=2Ec:

https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1744/comment/a5ef98ef_81ca1f39?usp=3Demail :
P=
S20, Line 235:     else if (verdict =3D=3D VERDICT_VALID_OOB_V1)
> Do we wa=
nt to also gate the following logic on some option being enabled? This look=
s like any valid  [=E2=80=A6]
I don't think we want to gate it=2E It is not=
 a new exposure - a server without tls-auth/crypt will already answer any w=
ell-formed RESET_V2 with the HMAC cookie over the same path=2E There is no =
amplification and server keeps no state per probe=2E



-- 
To view, visit =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerr=
it-Branch: master
Gerrit-Change-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59=
f0
Gerrit-Change-Number: 1744
Gerrit-PatchSet: 23
Gerrit-Owner: Lev Stipako=
v <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-Reviewer: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-CC: Fran=
k Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: R=C4=83zvan Cojocaru <ra=
zvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>
Gerrit-Attention: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Atte=
ntion: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne =
Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <f=
rank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Fri, 06 Nov 2026 13:44:30 +000=
0
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>

--yhSJ+uBcc3k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Ralf Lici, R=C4=83zv=
an Cojocaru=2E </p>
<p>Lev Stipakov has posted comments on this change by L=
ev Stipakov=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1744?usp=3Demail">View Change</a></p><p>1 comment:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/ope=
nvpn/mudp=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"=
margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744/comment/a5ef98ef_81ca1f=
39?usp=3Demail">Patch Set #20, Line 235:</a> <code style=3D"font-family:mon=
ospace,monospace">    else if (verdict =3D=3D VERDICT_VALID_OOB_V1)</code><=
/p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; pad=
ding: 0 10px;">Do we want to also gate the following logic on some option b=
eing enabled? This looks like any valid  [=E2=80=A6]</blockquote></p><p cla=
ss=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I don=
&#39;t think we want to gate it=2E It is not a new exposure - a server with=
out tls-auth/crypt will already answer any well-formed RESET_V2 with the HM=
AC cookie over the same path=2E There is no amplification and server keeps =
no state per probe=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3Demail">change 1744</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I930d3=
789e0313aa0c3bc51ee5fd1d108343d59f0 </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 1744 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 23 </div>
<div style=3D"display:none"> Gerrit-Owner: Lev Stipakov &lt;lst=
ipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Reviewer: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-CC: Frank Lichtenheld &lt;frank@lichtenhe=
ld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: R=C4=83zvan Coj=
ocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div=
>
<div style=3D"display:none"> Gerrit-Attention: Ralf Lici &lt;ralf@mandelb=
it=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83z=
van Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;fran=
k@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-=
Date: Fri, 06 Nov 2026 13:44:30 +0000 </div>
<div style=3D"display:none"> G=
errit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Label=
s: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: R=C4=83zvan =
Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--yhSJ+uBcc3k=--


--===============4796572792508335245==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4796572792508335245==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4796572792508335245==--

