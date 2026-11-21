Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F39606A320
	for <openvpn-devel@archiver.kernel.org>; Sat, 21 Nov 2026 17:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Dyuv01KF;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=TFk0ImzH;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=UkuSx3DY;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=DYj/tr/t
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=scSqiPECX4xuSeh33g7ALTpMRdgLFB7e50HrUcy03bM=; b=Dyuv01KF9IdjKPFtEIvK7CfEB5
	P9ttxg9aGKg8b+O5EJvMLI6CNOPzF3Ounj6UAFolWwJATlaPPwyUv/DektTv0nnv4L+b/gxlq+ZEW
	d+4mMdXQTKi6DEvuQiuG65+tfSMh5cLqyN9pJS/4LqVUok+kfg/fHEjspV7hSiKRicBk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUpKM-000000008MB-46g1;
	Sat, 21 Nov 2026 17:56:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUpKL-000000008G4-0QGj
 for openvpn-devel@lists.sourceforge.net;
 Sat, 21 Nov 2026 17:56:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4JczyEQuNOt0Q8hGWv9hmd/nd84znBgy/eokvZMVwCU=; b=TFk0ImzHe2b8OuRNVM7SjEYy+W
 Ycuko/qsO4j0a/rzF9KpoGKpro/WwUUcvtkr+49XU6dMuXDzvguECKT6acsCwZT0AeXXnJc/UwYEw
 mgFigIfog+1QVMKAc1Ds55CkdT+9K/AhLNWFCrnbl9Ttbx/G3+aHtFm9b5vZr/HUsFiI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4JczyEQuNOt0Q8hGWv9hmd/nd84znBgy/eokvZMVwCU=; b=UkuSx3DYw/MOa0OhEQnOxIk6eb
 l8e+O18hiYoFp8VS24XirtKV18PSsVg69UFGGPMd+b/Y9We1lm2VetJwbZxF9WYZGuDJwQ9Epdlhn
 Ql0+IUvse4PdqzladhycRAUwr6BCr/Bi1hSNbx+9jBWCkvAOluW1TKL1ea6Y1dy0Zwo4=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUpKJ-000000003id-2W2T for openvpn-devel@lists.sourceforge.net;
 Sat, 21 Nov 2026 17:56:40 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-4aa5833c263so1816285f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 21 Nov 2026 09:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795283793; x=1795888593; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4JczyEQuNOt0Q8hGWv9hmd/nd84znBgy/eokvZMVwCU=;
 b=DYj/tr/tC1P52bVODrvMRSKvkr9bkdw3uhtkA7Xzg3ao9HAlssP+WUAo/EAIeOS6mm
 5OgJ7teVvUH+Bmb7jQ+ytLyB7gQ0akwB0tT9Xf3qTEi4qTR2O97XLvRU5Rk6VAO/35VF
 54AuGHg2VBUrOxGGg6FO3dYfIXSn7UruQFJvfDVXjyTuu4AXSJK3Z8RDuWOOkcNKl14E
 //xnUK/PuIJPdS6e2PGnloqx1ObW7aYPX1k1Nwua8zL2mahgXY4vAVmMFvtEcaNFhAvv
 VZwRmDLhgKaSHLu0A2HZkokutkxNg9ZoLgiQOA+G4qLnGDfHw1aUnOCiEOc1EIriUeQE
 p7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795283793; x=1795888593;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4JczyEQuNOt0Q8hGWv9hmd/nd84znBgy/eokvZMVwCU=;
 b=xbiWnbMnWFfoPOrUe0nLCyOlkEHMje1l112ZElPEQo+4K11ssE/yTv4U6fAUg8QZVF
 Y0GtprgaojyUr3zmFlopnSE/GBz3uq1Z+d7Y7zZXkF+fX4AhbSQbzPLc/k3EVHTWiKYm
 ORnecf0JmrMQKOy8+3LqYxtYuPLbgg34XuGPN64hwCz/oV7sOIZD9+hxLtIbprerU64q
 8b3ENiWHHRP1idU2pyT8YhIBCEVQhdSpPOpzo77S2zIVY3pCXRFavBIlc95Hp934pOV+
 mHQ82jteamJ38V0xVddofFZT8sYYUuR7/9PuJ+vwaVMl8za8pnz2mELGo2E88Akhil7m
 OMog==
X-Gm-Message-State: APuU4Z/+44gRpLGoIJlgRhaG/Tppuw3AadhcndG5KqgegcXuuzuTEAuj
 bzNOC1nK39pv8WB37PBwfBOTFqyzrMu5q97JmmcWvdIpyA9Z/Qx9npeZnlneuXaYgdKcSQ5Pomf
 721+d7z1fo7pNs1qTrgiF7F8qoFtvakZQVTrzccGjSDLn1JXtJK4tC2CrT8Ry7MKgLjlB
X-Gm-Gg: AZFdTZc4mUfCio1KzeiyLyGiOrizK7Fhsm4AzQF2R15wQD+jzcyJw9pQ2mMhUtpLO1X
 YO+pg5E9fuuU6WP7hufyebvFUzIzF1SeJA/RA5FKdmACq5cSTMTY8dYex/G8NiWvO6vH1vgpkyA
 eLRdZfVy7EHa4+naFalOHz+6xQ8ycHGT0zUauVtnxO8tjmlx9LJ4aFqdco0fevJFJSODJ3buh09
 fQCfNE8fEhHRC6AQo8lMVlYtVwRrT0EzPRgSmrKK/xQdtLFpVK31pGAYZdbNog0GZ+fkE7SN9mC
 F8dYmB+GPP/jCNIL9/OpdYq5qArcXn2IwSfMTeYayN/tsVtUggJcHqAiTfdEpxtVhSQcxY53vDI
 Nohaz5nLIu07XHbgnZRjH75MSDV5d8N2AH5nd6A8rDFpKSEzA6eJMu7rRXQ8Id0GBJ8vSCWTiXG
 dm1NKuAvIA1+sMvpP/oYAgRTYVMg9MmyGDztyLABBoRbwTBOsf2699C6ViqMOJ8NMU3tf0aor+3
 wAla+LEh2hXacRLCHe/BygNOlL7K1npddQdSW4S4rQ9puiFQmeKELYUyGMpcjTGUmCG4h0u+HjR
 /Rm+EcPDhbgejSZKKZF0L7qIyzbD+TPLHlYpvfNg+4kjmfZyLSZxFae0jlHTzn8g1OMJwNC9lmG
 NxnRdC9IUl2DBFktdlGvlTPnBf1QaPaM8R1Ei75o3SK0uMCpFXGoRyLFU9bhDhLD6pEe6ygwa7c
 sTRJPEioTjIvIA2nU=
X-Received: by 2002:a05:600c:45d4:b0:4bb:6994:abf0 with SMTP id
 5b1f17b1804b1-4bb88817d91mr158020175e9.23.1795283792789; 
 Sat, 21 Nov 2026 09:56:32 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb906d6a13sm59825915e9.3.2026.11.21.09.56.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 09:56:32 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 21 Nov 2026 17:56:31 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ie074a6f52589f9bb3c0c98b95def5e8115a7c621
X-Gerrit-Change-Number: 2230
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2230?usp=email>
X-Gerrit-Commit: 3b508e18deb47b5fdcef21cbe74db6b853facddc
In-Reply-To: <gerrit.1795179338000.Ie074a6f52589f9bb3c0c98b95def5e8115a7c621@gerrit.openvpn.net>
References: <gerrit.1795179338000.Ie074a6f52589f9bb3c0c98b95def5e8115a7c621@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MTc5MzM4MDAwLkllMDc0YTZmNTI1ODlmOWJiM2MwYzk4Yjk1ZGVmNWU4MTE1YTdjNjIxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <913a7014d6c803c97d0b1a485194d394f6cf9dfb-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xUpKJ-000000003id-2W2T
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Remove orphaned
 ring_buffer.h and ffdhe2048.pem
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
 openvpn-devel@lists.sourceforge.net, heiko@ist.eigentlich.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0130893530132321689=="
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0130893530132321689==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SQg8ag+loxQ="; charset=UTF-8

--SQg8ag+loxQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2230?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Heiko Hund


Change subject: Remove orphaned ring_buffer=
=2Eh and ffdhe2048=2Epem
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

Remove orphaned ring_buffer=2Eh and ffdhe2048=2Epem

ring_buf=
fer=2Eh was deleted with Wintun support in ad7a6945 but came back
with the =
clang-format reformat in 3cca3367=2E Nothing includes it=2E Also
drop the u=
nused TUN_IOCTL_REGISTER_RINGS define in interactive=2Ec=2E

ffdhe2048=2Epe=
m was added for the t_server_null tests in b60ba20c, which
switched to --dh=
 none in 494fb718=2E Nothing references it=2E

Change-Id: Ie074a6f52589f9bb=
3c0c98b95def5e8115a7c621
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2E=
org>
Acked-by: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit URL: https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2230
Message-Id: <20261121113446=2E682=
8-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-=
devel@lists=2Esourceforge=2Enet/msg41756=2Ehtml
Signed-off-by: Gert Doering=
 <gert@greenie=2Emuc=2Ede>
---
D sample/sample-keys/ffdhe2048=2Epem
D src/o=
penvpn/ring_buffer=2Eh
M src/openvpnserv/interactive=2Ec
3 files changed, 0=
 insertions(+), 135 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:=
29418/openvpn refs/changes/30/2230/2

diff --git a/sample/sample-keys/ffdhe=
2048=2Epem b/sample/sample-keys/ffdhe2048=2Epem
deleted file mode 100644
in=
dex 9b182b7=2E=2E0000000
--- a/sample/sample-keys/ffdhe2048=2Epem
+++ /dev/=
null
@@ -1,8 +0,0 @@
------BEGIN DH PARAMETERS-----
-MIIBCAKCAQEA//////////=
+t+FRYortKmq/cViAnPTzx2LnFg84tNpWp4TZBFGQz
-+8yTnc4kmz75fS/jY2MMddj2gbICrsR=
hetPfHtXV/WVhJDP1H18GbtCFY2VVPe0a
-87VXE15/V8k1mE8McODmi3fipona8+/och3xWKE2=
rec1MKzKT0g6eXq8CrGCsyT7
-YdEIqUuyyOP7uWrat2DX9GgdT0Kj3jlN9K5W7edjcrsZCweny=
O4KbXCeAvzhzffi
-7MA0BM0oNC9hkXL+nOmFg/+OTxIy7vKBg8P+OxtMb61zO7X8vC7CIAXFjv=
GDfRaD
-ssbzSibBsu/6iGtCOGEoXJf//////////wIBAg=3D=3D
------END DH PARAMETER=
S-----
diff --git a/src/openvpn/ring_buffer=2Eh b/src/openvpn/ring_buffer=
=2Eh
deleted file mode 100644
index aebcd9c=2E=2E0000000
--- a/src/openvpn/=
ring_buffer=2Eh
+++ /dev/null
@@ -1,124 +0,0 @@
-/*
- *  OpenVPN -- An appl=
ication to securely tunnel IP networks
- *             over a single UDP po=
rt, with support for SSL/TLS-based
- *             session authentication a=
nd key exchange,
- *             packet encryption, packet authentication, =
and
- *             packet compression=2E
- *
- *  Copyright (C) 2002-2026 =
OpenVPN Inc <sales@openvpn=2Enet>
- *                2019 Lev Stipakov <lev=
@openvpn=2Enet>
- *
- *  This program is free software; you can redistribut=
e it and/or modify
- *  it under the terms of the GNU General Public Licens=
e version 2
- *  as published by the Free Software Foundation=2E
- *
- *  T=
his program is distributed in the hope that it will be useful,
- *  but WIT=
HOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILIT=
Y or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
- *  GNU General Public L=
icense for more details=2E
- *
- *  You should have received a copy of the =
GNU General Public License along
- *  with this program; if not, write to t=
he Free Software Foundation, Inc=2E,
- *  51 Franklin Street, Fifth Floor, =
Boston, MA 02110-1301 USA=2E
- */
-
-#ifdef _WIN32
-#ifndef OPENVPN_RING_BU=
FFER_H
-#define OPENVPN_RING_BUFFER_H
-
-#include <windows=2Eh>
-#include <=
winioctl=2Eh>
-
-#include <stdint=2Eh>
-#include <stdbool=2Eh>
-
-/*
- * Va=
lues below are taken from Wireguard Windows client
- * https://github=2Ecom=
/WireGuard/wireguard-go/blob/master/tun/wintun/ring_windows=2Ego#L14
- */
-=
#define WINTUN_RING_CAPACITY       0x800000
-#define WINTUN_RING_TRAILING_B=
YTES 0x10000
-#define WINTUN_MAX_PACKET_SIZE     0xffff
-#define WINTUN_PAC=
KET_ALIGN        4
-
-#define TUN_IOCTL_REGISTER_RINGS \
-    CTL_CODE(5182=
0U, 0x970U, METHOD_BUFFERED, FILE_READ_DATA | FILE_WRITE_DATA)
-
-/**
- * W=
intun ring buffer
- * See https://github=2Ecom/WireGuard/wintun#ring-layout=

- */
-struct tun_ring
-{
-    volatile ULONG head;
-    volatile ULONG tai=
l;
-    volatile LONG alertable;
-    UCHAR data[WINTUN_RING_CAPACITY + WIN=
TUN_RING_TRAILING_BYTES];
-};
-
-/**
- * Struct for ring buffers registrati=
on
- * See https://github=2Ecom/WireGuard/wintun#registering-rings
- */
-st=
ruct tun_register_rings
-{
-    struct
-    {
-        ULONG ring_size;
-  =
      struct tun_ring *ring;
-        HANDLE tail_moved;
-    } send, recei=
ve;
-};
-
-struct TUN_PACKET_HEADER
-{
-    uint32_t size;
-};
-
-struct TU=
N_PACKET
-{
-    uint32_t size;
-    UCHAR data[WINTUN_MAX_PACKET_SIZE];
-}=
;
-
-/**
- * Registers ring buffers used to exchange data between
- * users=
pace openvpn process and wintun kernel driver,
- * see https://github=2Ecom=
/WireGuard/wintun#registering-rings
- *
- * @param device              hand=
le to opened wintun device
- * @param send_ring           pointer to send r=
ing
- * @param receive_ring        pointer to receive ring
- * @param send_=
tail_moved     event set by wintun to signal openvpn
- *                   =
         that data is available for reading in send ring
- * @param receive=
_tail_moved  event set by openvpn to signal wintun
- *                     =
       that data has been written to receive ring
- * @return              =
      true if registration is successful, false otherwise - use
- * GetLast=
Error()
- */
-static inline bool
-register_ring_buffers(HANDLE device, stru=
ct tun_ring *send_ring, struct tun_ring *receive_ring,
-                   =
   HANDLE send_tail_moved, HANDLE receive_tail_moved)
-{
-    struct tun_re=
gister_rings rr;
-    BOOL res;
-    DWORD bytes_returned;
-
-    ZeroMemor=
y(&rr, sizeof(rr));
-
-    rr=2Esend=2Ering =3D send_ring;
-    rr=2Esend=
=2Ering_size =3D sizeof(struct tun_ring);
-    rr=2Esend=2Etail_moved =3D s=
end_tail_moved;
-
-    rr=2Ereceive=2Ering =3D receive_ring;
-    rr=2Erece=
ive=2Ering_size =3D sizeof(struct tun_ring);
-    rr=2Ereceive=2Etail_moved=
 =3D receive_tail_moved;
-
-    res =3D DeviceIoControl(device, TUN_IOCTL_R=
EGISTER_RINGS, &rr, sizeof(rr), NULL, 0,
-                          &bytes_=
returned, NULL);
-
-    return res !=3D FALSE;
-}
-
-#endif /* ifndef OPENV=
PN_RING_BUFFER_H */
-#endif /* ifdef _WIN32 */
diff --git a/src/openvpnserv=
/interactive=2Ec b/src/openvpnserv/interactive=2Ec
index 354fe09=2E=2E6bd67=
9f 100644
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/inter=
active=2Ec
@@ -55,9 +55,6 @@
 static HANDLE rdns_semaphore =3D NULL;
 #defi=
ne RDNS_TIMEOUT 600 /* seconds to wait for the semaphore */
 
-#define TUN_=
IOCTL_REGISTER_RINGS \
-    CTL_CODE(51820U, 0x970U, METHOD_BUFFERED, FILE_=
READ_DATA | FILE_WRITE_DATA)
-
 openvpn_service_t interactive_service =3D {=
 interactive, _L(PACKAGE_NAME) L"ServiceInteractive",
                     =
                      _L(PACKAGE_NAME) L" Interactive Service",
           =
                                SERVICE_DEPENDENCIES, SERVICE_AUTO_START };=


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2230?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Ger=
rit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie074a6f52589f=
9bb3c0c98b95def5e8115a7c621
Gerrit-Change-Number: 2230
Gerrit-PatchSet: 2
G=
errit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: =
Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Heiko Hund <heik=
o@ist=2Eeigentlich=2Enet>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Es=
ourceforge=2Enet>

--SQg8ag+loxQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2230?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Heiko Hund</p><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Remov=
e orphaned ring_buffer=2Eh and ffdhe2048=2Epem<br><br>ring_buffer=2Eh was d=
eleted with Wintun support in ad7a6945 but came back<br>with the clang-form=
at reformat in 3cca3367=2E Nothing includes it=2E Also<br>drop the unused T=
UN_IOCTL_REGISTER_RINGS define in interactive=2Ec=2E<br><br>ffdhe2048=2Epem=
 was added for the t_server_null tests in b60ba20c, which<br>switched to --=
dh none in 494fb718=2E Nothing references it=2E<br><br>Change-Id: Ie074a6f5=
2589f9bb3c0c98b95def5e8115a7c621<br>Signed-off-by: Razvan Cojocaru &lt;razv=
anc@mailbox=2Eorg&gt;<br>Acked-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2E=
net&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2230<br>M=
essage-Id: &lt;20261121113446=2E6828-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: =
https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/ms=
g41756=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt=
;<br>---<br>D sample/sample-keys/ffdhe2048=2Epem<br>D src/openvpn/ring_buff=
er=2Eh<br>M src/openvpnserv/interactive=2Ec<br>3 files changed, 0 insertion=
s(+), 135 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eo=
penvpn=2Enet:29418/openvpn refs/changes/30/2230/2</pre><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/samp=
le/sample-keys/ffdhe2048=2Epem b/sample/sample-keys/ffdhe2048=2Epem</span><=
br><span>deleted file mode 100644</span><br><span>index 9b182b7=2E=2E000000=
0</span><br><span>--- a/sample/sample-keys/ffdhe2048=2Epem</span><br><span>=
+++ /dev/null</span><br><span>@@ -1,8 +0,0 @@</span><br><span>------BEGIN D=
H PARAMETERS-----</span><br><span style=3D"color: hsl(0, 100%, 40%);">-MIIB=
CAKCAQEA//////////+t+FRYortKmq/cViAnPTzx2LnFg84tNpWp4TZBFGQz</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-+8yTnc4kmz75fS/jY2MMddj2gbICrsRhetPf=
HtXV/WVhJDP1H18GbtCFY2VVPe0a</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-87VXE15/V8k1mE8McODmi3fipona8+/och3xWKE2rec1MKzKT0g6eXq8CrGCsyT7</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-YdEIqUuyyOP7uWrat2DX9GgdT=
0Kj3jlN9K5W7edjcrsZCwenyO4KbXCeAvzhzffi</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-7MA0BM0oNC9hkXL+nOmFg/+OTxIy7vKBg8P+OxtMb61zO7X8vC7CIAXFj=
vGDfRaD</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ssbzSibBsu/6iG=
tCOGEoXJf//////////wIBAg=3D=3D</span><br><span>------END DH PARAMETERS-----=
</span><br><span>diff --git a/src/openvpn/ring_buffer=2Eh b/src/openvpn/rin=
g_buffer=2Eh</span><br><span>deleted file mode 100644</span><br><span>index=
 aebcd9c=2E=2E0000000</span><br><span>--- a/src/openvpn/ring_buffer=2Eh</sp=
an><br><span>+++ /dev/null</span><br><span>@@ -1,124 +0,0 @@</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- *  OpenVPN -- An application to securely tunnel IP net=
works</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *             o=
ver a single UDP port, with support for SSL/TLS-based</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *             session authentication and k=
ey exchange,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *       =
      packet encryption, packet authentication, and</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *             packet compression=2E</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sal=
es@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
*                2019 Lev Stipakov &lt;lev@openvpn=2Enet&gt;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- *  This program is free software; you can redistribute=
 it and/or modify</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  =
it under the terms of the GNU General Public License version 2</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- *  as published by the Free Softw=
are Foundation=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  This program is dis=
tributed in the hope that it will be useful,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- *  but WITHOUT ANY WARRANTY; without even the impli=
ed warranty of</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  MER=
CHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- *  GNU General Public License for m=
ore details=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- *  You should have receiv=
ed a copy of the GNU General Public License along</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- *  with this program; if not, write to the Fre=
e Software Foundation, Inc=2E,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#ifdef _WIN32</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#ifndef OPENVPN_RING_BUFFER_H</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#define OPENVPN_RING_BUFFER_H</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#include &lt;windows=2Eh&gt;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#include &lt;winioctl=2Eh&gt;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#incl=
ude &lt;stdint=2Eh&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#include &lt;stdbool=2Eh&gt;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- * Values below are taken from W=
ireguard Windows client</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- * https://github=2Ecom/WireGuard/wireguard-go/blob/master/tun/wintun/rin=
g_windows=2Ego#L14</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define WINTUN_RING_C=
APACITY       0x800000</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#define WINTUN_RING_TRAILING_BYTES 0x10000</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#define WINTUN_MAX_PACKET_SIZE     0xffff</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#define WINTUN_PACKET_ALIGN      =
  4</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#define TUN_IOCTL_REGISTER_RINGS \</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    CTL_CODE(51820U, 0x970=
U, METHOD_BUFFERED, FILE_READ_DATA | FILE_WRITE_DATA)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Wint=
un ring buffer</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * See =
https://github=2Ecom/WireGuard/wintun#ring-layout</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-struct tun_ring</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    volatile ULO=
NG head;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    volatile =
ULONG tail;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    volati=
le LONG alertable;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 UCHAR data[WINTUN_RING_CAPACITY + WINTUN_RING_TRAILING_BYTES];</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-};</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Struct for ri=
ng buffers registration</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- * See https://github=2Ecom/WireGuard/wintun#registering-rings</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-struct tun_register_rings</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    struct</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ULONG ring=
_size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct =
tun_ring *ring;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  HANDLE tail_moved;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   } send, receive;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-};=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-struct TUN_PACKET_HEADER</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    uint32_t size;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-};</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-struct TUN_PACKET</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    uint32_t size;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    UCHAR data[WINTUN_MAX_PACKET_SIZE];</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-};</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/=
**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Registers ring b=
uffers used to exchange data between</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * userspace openvpn process and wintun kernel driver,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- * see https://github=2Ecom=
/WireGuard/wintun#registering-rings</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @p=
aram device              handle to opened wintun device</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * @param send_ring           pointer to =
send ring</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param re=
ceive_ring        pointer to receive ring</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- * @param send_tail_moved     event set by wintun to si=
gnal openvpn</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *       =
                     that data is available for reading in send ring</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * @param receive_tail_moved=
  event set by openvpn to signal wintun</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- *                            that data has been written =
to receive ring</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @re=
turn                    true if registration is successful, false otherwise=
 - use</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * GetLastError=
()</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-static inline bool</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-register_ring_buffers(HANDLE device, str=
uct tun_ring *send_ring, struct tun_ring *receive_ring,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                      HANDLE send_tail_mo=
ved, HANDLE receive_tail_moved)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct=
 tun_register_rings rr;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    BOOL res;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    DW=
ORD bytes_returned;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ZeroMemory(&amp;rr,=
 sizeof(rr));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    rr=2Esend=2Ering =3D send=
_ring;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    rr=2Esend=
=2Ering_size =3D sizeof(struct tun_ring);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    rr=2Esend=2Etail_moved =3D send_tail_moved;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    rr=2Ereceive=2Ering =3D receive_ring;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    rr=2Ereceive=2Ering_size =
=3D sizeof(struct tun_ring);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    rr=2Ereceive=2Etail_moved =3D receive_tail_moved;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    res =3D DeviceIoControl(device, TUN_IOCTL_REGISTER_RI=
NGS, &amp;rr, sizeof(rr), NULL, 0,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                          &amp;bytes_returned, NULL);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    return res !=3D FALSE;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* if=
ndef OPENVPN_RING_BUFFER_H */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#endif /* ifdef _WIN32 */</span><br><span>diff --git a/src/openvpns=
erv/interactive=2Ec b/src/openvpnserv/interactive=2Ec</span><br><span>index=
 354fe09=2E=2E6bd679f 100644</span><br><span>--- a/src/openvpnserv/interact=
ive=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=2Ec</span><br><sp=
an>@@ -55,9 +55,6 @@</span><br><span> static HANDLE rdns_semaphore =3D NULL=
;</span><br><span> #define RDNS_TIMEOUT 600 /* seconds to wait for the sema=
phore */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#define TUN_IOCTL_REGISTER_RINGS \</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    CTL_CODE(51820U, 0x970U, METHOD_BUFFERED, FILE_READ_D=
ATA | FILE_WRITE_DATA)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span> openvpn_service_t interactive_service =3D { interactive,=
 _L(PACKAGE_NAME) L&quot;ServiceInteractive&quot;,</span><br><span>        =
                                   _L(PACKAGE_NAME) L&quot; Interactive Ser=
vice&quot;,</span><br><span>                                           SERV=
ICE_DEPENDENCIES, SERVICE_AUTO_START };</span><br></pre><p>To view, visit <=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2230?usp=3Demail">chan=
ge 2230</a>=2E To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E=
</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link =
itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2230?us=
p=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

=
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div st=
yle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:=
none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Id: Ie074a6f52589f9bb3c0c98b95def5e8115a7c621 </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Number: 2230 </div>
<div style=3D"display:none"> G=
errit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83=
zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: Heiko Hund &lt;heiko@ist=2E=
eigentlich=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn=
-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></htm=
l>
--SQg8ag+loxQ=--


--===============0130893530132321689==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0130893530132321689==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0130893530132321689==--

