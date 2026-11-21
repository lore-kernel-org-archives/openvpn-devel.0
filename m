Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FB5606A330
	for <openvpn-devel@archiver.kernel.org>; Sat, 21 Nov 2026 17:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jS7Q7fF7;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=epEdN3mK;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=B83t5wE/;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=JEd7oBGu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=77iupI9JxROlddWzd4PPYGXErpI2eC0MqZCMMDTxidQ=; b=jS7Q7fF77lrrTRWvl59WVMBTXL
	UunOtrZu5EsVjK5KeJLNwB0aAmqxMOKyrRwUwv0Vpc4TwFVKho2cpJPyDm/ZkqPO+Wv/pHc3R6Hs5
	LwW2NJ2GiaoqfnwnZByPC5Yp8kMxezwK6ilCH/Bt7tanI8Z5lp+ndD1fmIdhzJVCpyhA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUpKO-000000000c8-0Lrz;
	Sat, 21 Nov 2026 17:56:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUpKM-000000000br-1oLg
 for openvpn-devel@lists.sourceforge.net;
 Sat, 21 Nov 2026 17:56:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MlOD/PzfvYAwKLjoE28oeE8Cqatb1ixj/hBJ6SfvFM4=; b=epEdN3mK3vBqbZx3PKZ2v5A7pJ
 VowpZQQUwZ77KnOVnkieXYDOhNcC587/KUaCvWGJlybC9MAfuc4jVe/OXB90Dlq+fFIeLXlTXy6Im
 RAfCSvyDvbnIq6N5RSjiAEpQVGGs4WXTjBeVeKW8C0WU190Iy9zDkJ2ZhofMHQgGqji4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MlOD/PzfvYAwKLjoE28oeE8Cqatb1ixj/hBJ6SfvFM4=; b=B83t5wE/Bud4yaVkxfWTNudmOt
 HrqWLHOBFAHsPimYOFNq1l+z+DY228H7L1A113UNth4UZcSwQtDDy7BKQOb2hNAOKk8gx3hBsv+S6
 wZ6q8BBIR8uUnWZaZQ+pjHIew1LBPtavuA9SkpfGG+favYhd3JNkMXYXb/1+NtB3upTk=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUpKL-000000007xn-02tP for openvpn-devel@lists.sourceforge.net;
 Sat, 21 Nov 2026 17:56:42 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so19033155e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 21 Nov 2026 09:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795283794; x=1795888594; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MlOD/PzfvYAwKLjoE28oeE8Cqatb1ixj/hBJ6SfvFM4=;
 b=JEd7oBGud9q1vZzDvkRejx4ovKtXnRw+xBb0sTFaUXJvCsv/PBHupZcWryCFux0Rr2
 ACwZskDowcgw571WrFVWQ6RtR+d4yNd41VX6ACx2VpPF5hF4HM7G73L8jjL0N6idlAjK
 EKHSEp9lH8jEVN5ZZFO2JfognAkTTec1gpdeSyWAEW+MqyFPE86eiM6yxgUmGY9We4o2
 RMD2XegXUHJ5HwGC79OHUP7USs6PURnFW7z8Om1bPAKb4wX9sr5WSD2pRLp3mmd1l40K
 5sI7xynraSQhpLrrAP+aXfN/xKPKlV3p5tfT4AWYJN7vpA8/T2TVWvXZsWZrrSgKDgwJ
 Rsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795283794; x=1795888594;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=MlOD/PzfvYAwKLjoE28oeE8Cqatb1ixj/hBJ6SfvFM4=;
 b=zp5ZhMALhwbPUz4tWXYzmMpnzesy2D1rh6A38qRnmUFrYSOBoQMlw7hdj9cvBDcRW8
 sy4DYCXcLpm1igTo2LRynDkSqDDTrH6sXldKbdhbo4PuevkBa0PEiYD2yU4XX4Eccusy
 3y2Zfz9CNxWEJtXxHRm/B+nbb0xsISTptgQRBIqSFmA5368ImpbG/hSR2b/BvgSCNpNR
 COV9tOvTor7zJlv7JudHin0sT6YHm0OgDv2jJeGTqghkQ36VXkz4+B4MhupXazz1JHIb
 1Soi7pTVtz0OhWVjpq4yTg9WmAfKmvMJIaBFeK5ngu24E9Xu8PnHd164sKuS2Pky+W9a
 uCzg==
X-Forwarded-Encrypted: i=1;
 AL+hErFmjov4zDRW/Z8DoZxzS3OUxuv+0qBMRluwTQepY27nqjjVSCM66HPfwXjvjIG13ucpWkpS26RglMcFQTKT@lists.sourceforge.net
X-Gm-Message-State: APuU4Z80XicLBrIV+W6EmznxN7hRKNWtAak7z4vKtSpk9PfCc+kPYM6I
 ynE+tgGpcs8BSwMR6zMx+hjTQK9sc2LfDX8J3lLewEDdTlvHYMvNwpnlW/RwzNFyS/rbBzCyska
 i19ugmG/6AcmvJn6niGzt9gnPQHPkfpZaFxvaGjBTVaJVLSdX1Wj2fL9GdMaa9flwg3bW33r+QX
 aHn5kuBw==
X-Gm-Gg: AZFdTZeu6EFXvIPD9/qsNW/ZsJPRrFZ+Hs6SpfwQhHCYJVYzkHrfCMCJjK3G1SkQsG0
 I4losEko6Waz5FobIAAO02igAZE3lp4XUD3A7JgOEQaGQimUbq1y5inqSzU/ye5UBAiqTyQmXWP
 i/vKjYmQXVFF1fHkNC2ZwsM9ovjJBQeiC7bCZ3U68M1NXnHj799Bl2eMWI8ZHnxXMd1mbp+v1NO
 poM1HsZlKcVLl9K74Ps8Lxj1LdieQeTpWDOP805AvsrCjJrxwQ1KeL9QhqJVX6wkajl5TGztaF5
 NC3/fvVpxfCgWHaAmG9Fgk2/C0t5gomQChRydW3oUG34dPctM2kV3NlQ/K7j84B4xCerRaDAo4/
 GwF9lr/qbZTFRPe9L4374G5c0Ghui2kbjMpxHw3ExyEK1gMquI0AY+8fpULmhQlL6RIJwC0vsrf
 9EdjEaPZyJy/vxXmaVof5D/9U6FaKCMlqui2v23cLktVJNJD2saxcUrfiqsXnjHd4clb0tJX6iK
 HO/Mne1nTArw18YNFFfA7RgvKHCBVLmu2TPbJrky5X0MiYF02bWa00oXGsnxKRJeECnQyNv5WyO
 X9l6Hlkl4DxkLqzTT7HwYdt/CQzV1Q+LjWVf3WwSHATB44dGMhf2fGjdZitqqF8sLtWcJOqY9mE
 KxGyPB7QcGwDBYCyF/W/SSetW9AU4tkWqNmpIVDoBynEW2Not23/FYa6gqJMekYHMsxDBsSDkf9
 YtLo6Beduwt/2VWmENSve8cQZkQoPmLktyLog9
X-Received: by 2002:a05:600c:4584:b0:4bb:5de1:e90f with SMTP id
 5b1f17b1804b1-4bb88819bcdmr145785545e9.31.1795283794198; 
 Sat, 21 Nov 2026 09:56:34 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884c3063sm198679815e9.15.2026.11.21.09.56.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 09:56:33 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 21 Nov 2026 17:56:33 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ie074a6f52589f9bb3c0c98b95def5e8115a7c621
X-Gerrit-Change-Number: 2230
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2230?usp=email>
X-Gerrit-Commit: 3b508e18deb47b5fdcef21cbe74db6b853facddc
In-Reply-To: <gerrit.1795179338000.Ie074a6f52589f9bb3c0c98b95def5e8115a7c621@gerrit.openvpn.net>
References: <gerrit.1795179338000.Ie074a6f52589f9bb3c0c98b95def5e8115a7c621@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MTc5MzM4MDAwLkllMDc0YTZmNTI1ODlmOWJiM2MwYzk4Yjk1ZGVmNWU4MTE1YTdjNjIxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <913a7014d6c803c97d0b1a485194d394f6cf9dfb-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xUpKL-000000007xn-02tP
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7405728366529161059=="
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7405728366529161059==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="llX2WQioscA="; charset=UTF-8

--llX2WQioscA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2230?usp=3Demail )

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




diff --git a/sample/sample-keys/ffdhe2=
048=2Epem b/sample/sample-keys/ffdhe2048=2Epem
deleted file mode 100644
ind=
ex 9b182b7=2E=2E0000000
--- a/sample/sample-keys/ffdhe2048=2Epem
+++ /dev/n=
ull
@@ -1,8 +0,0 @@
------BEGIN DH PARAMETERS-----
-MIIBCAKCAQEA//////////+=
t+FRYortKmq/cViAnPTzx2LnFg84tNpWp4TZBFGQz
-+8yTnc4kmz75fS/jY2MMddj2gbICrsRh=
etPfHtXV/WVhJDP1H18GbtCFY2VVPe0a
-87VXE15/V8k1mE8McODmi3fipona8+/och3xWKE2r=
ec1MKzKT0g6eXq8CrGCsyT7
-YdEIqUuyyOP7uWrat2DX9GgdT0Kj3jlN9K5W7edjcrsZCwenyO=
4KbXCeAvzhzffi
-7MA0BM0oNC9hkXL+nOmFg/+OTxIy7vKBg8P+OxtMb61zO7X8vC7CIAXFjvG=
DfRaD
-ssbzSibBsu/6iGtCOGEoXJf//////////wIBAg=3D=3D
------END DH PARAMETERS=
-----
diff --git a/src/openvpn/ring_buffer=2Eh b/src/openvpn/ring_buffer=2E=
h
deleted file mode 100644
index aebcd9c=2E=2E0000000
--- a/src/openvpn/rin=
g_buffer=2Eh
+++ /dev/null
@@ -1,124 +0,0 @@
-/*
- *  OpenVPN -- An applica=
tion to securely tunnel IP networks
- *             over a single UDP port,=
 with support for SSL/TLS-based
- *             session authentication and =
key exchange,
- *             packet encryption, packet authentication, and=

- *             packet compression=2E
- *
- *  Copyright (C) 2002-2026 Ope=
nVPN Inc <sales@openvpn=2Enet>
- *                2019 Lev Stipakov <lev@op=
envpn=2Enet>
- *
- *  This program is free software; you can redistribute i=
t and/or modify
- *  it under the terms of the GNU General Public License v=
ersion 2
- *  as published by the Free Software Foundation=2E
- *
- *  This=
 program is distributed in the hope that it will be useful,
- *  but WITHOU=
T ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY o=
r FITNESS FOR A PARTICULAR PURPOSE=2E  See the
- *  GNU General Public Lice=
nse for more details=2E
- *
- *  You should have received a copy of the GNU=
 General Public License along
- *  with this program; if not, write to the =
Free Software Foundation, Inc=2E,
- *  51 Franklin Street, Fifth Floor, Bos=
ton, MA 02110-1301 USA=2E
- */
-
-#ifdef _WIN32
-#ifndef OPENVPN_RING_BUFFE=
R_H
-#define OPENVPN_RING_BUFFER_H
-
-#include <windows=2Eh>
-#include <win=
ioctl=2Eh>
-
-#include <stdint=2Eh>
-#include <stdbool=2Eh>
-
-/*
- * Value=
s below are taken from Wireguard Windows client
- * https://github=2Ecom/Wi=
reGuard/wireguard-go/blob/master/tun/wintun/ring_windows=2Ego#L14
- */
-#de=
fine WINTUN_RING_CAPACITY       0x800000
-#define WINTUN_RING_TRAILING_BYTE=
S 0x10000
-#define WINTUN_MAX_PACKET_SIZE     0xffff
-#define WINTUN_PACKET=
_ALIGN        4
-
-#define TUN_IOCTL_REGISTER_RINGS \
-    CTL_CODE(51820U,=
 0x970U, METHOD_BUFFERED, FILE_READ_DATA | FILE_WRITE_DATA)
-
-/**
- * Wint=
un ring buffer
- * See https://github=2Ecom/WireGuard/wintun#ring-layout
- =
*/
-struct tun_ring
-{
-    volatile ULONG head;
-    volatile ULONG tail;
=
-    volatile LONG alertable;
-    UCHAR data[WINTUN_RING_CAPACITY + WINTUN=
_RING_TRAILING_BYTES];
-};
-
-/**
- * Struct for ring buffers registration
=
- * See https://github=2Ecom/WireGuard/wintun#registering-rings
- */
-struc=
t tun_register_rings
-{
-    struct
-    {
-        ULONG ring_size;
-     =
   struct tun_ring *ring;
-        HANDLE tail_moved;
-    } send, receive;=

-};
-
-struct TUN_PACKET_HEADER
-{
-    uint32_t size;
-};
-
-struct TUN_P=
ACKET
-{
-    uint32_t size;
-    UCHAR data[WINTUN_MAX_PACKET_SIZE];
-};
-=

-/**
- * Registers ring buffers used to exchange data between
- * userspac=
e openvpn process and wintun kernel driver,
- * see https://github=2Ecom/Wi=
reGuard/wintun#registering-rings
- *
- * @param device              handle =
to opened wintun device
- * @param send_ring           pointer to send ring=

- * @param receive_ring        pointer to receive ring
- * @param send_tai=
l_moved     event set by wintun to signal openvpn
- *                      =
      that data is available for reading in send ring
- * @param receive_ta=
il_moved  event set by openvpn to signal wintun
- *                        =
    that data has been written to receive ring
- * @return                 =
   true if registration is successful, false otherwise - use
- * GetLastErr=
or()
- */
-static inline bool
-register_ring_buffers(HANDLE device, struct =
tun_ring *send_ring, struct tun_ring *receive_ring,
-                      =
HANDLE send_tail_moved, HANDLE receive_tail_moved)
-{
-    struct tun_regis=
ter_rings rr;
-    BOOL res;
-    DWORD bytes_returned;
-
-    ZeroMemory(&=
rr, sizeof(rr));
-
-    rr=2Esend=2Ering =3D send_ring;
-    rr=2Esend=2Eri=
ng_size =3D sizeof(struct tun_ring);
-    rr=2Esend=2Etail_moved =3D send_t=
ail_moved;
-
-    rr=2Ereceive=2Ering =3D receive_ring;
-    rr=2Ereceive=
=2Ering_size =3D sizeof(struct tun_ring);
-    rr=2Ereceive=2Etail_moved =
=3D receive_tail_moved;
-
-    res =3D DeviceIoControl(device, TUN_IOCTL_RE=
GISTER_RINGS, &rr, sizeof(rr), NULL, 0,
-                          &bytes_r=
eturned, NULL);
-
-    return res !=3D FALSE;
-}
-
-#endif /* ifndef OPENVP=
N_RING_BUFFER_H */
-#endif /* ifdef _WIN32 */
diff --git a/src/openvpnserv/=
interactive=2Ec b/src/openvpnserv/interactive=2Ec
index 354fe09=2E=2E6bd679=
f 100644
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/intera=
ctive=2Ec
@@ -55,9 +55,6 @@
 static HANDLE rdns_semaphore =3D NULL;
 #defin=
e RDNS_TIMEOUT 600 /* seconds to wait for the semaphore */
 
-#define TUN_I=
OCTL_REGISTER_RINGS \
-    CTL_CODE(51820U, 0x970U, METHOD_BUFFERED, FILE_R=
EAD_DATA | FILE_WRITE_DATA)
-
 openvpn_service_t interactive_service =3D { =
interactive, _L(PACKAGE_NAME) L"ServiceInteractive",
                      =
                     _L(PACKAGE_NAME) L" Interactive Service",
            =
                               SERVICE_DEPENDENCIES, SERVICE_AUTO_START };
=

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2230?usp=3De=
mail
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Pr=
oject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie074a6f52589f9bb3c0=
c98b95def5e8115a7c621
Gerrit-Change-Number: 2230
Gerrit-PatchSet: 2
Gerrit-=
Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Heiko Hund <heiko@ist=
=2Eeigentlich=2Enet>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>

--llX2WQioscA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2230?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Remove orphaned ring_buffer=2Eh an=
d ffdhe2048=2Epem<br><br>ring_buffer=2Eh was deleted with Wintun support in=
 ad7a6945 but came back<br>with the clang-format reformat in 3cca3367=2E No=
thing includes it=2E Also<br>drop the unused TUN_IOCTL_REGISTER_RINGS defin=
e in interactive=2Ec=2E<br><br>ffdhe2048=2Epem was added for the t_server_n=
ull tests in b60ba20c, which<br>switched to --dh none in 494fb718=2E Nothin=
g references it=2E<br><br>Change-Id: Ie074a6f52589f9bb3c0c98b95def5e8115a7c=
621<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acke=
d-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt;<br>Gerrit URL: https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2230<br>Message-Id: &lt;20261121113446=
=2E6828-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2E=
com/openvpn-devel@lists=2Esourceforge=2Enet/msg41756=2Ehtml<br>Signed-off-b=
y: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>D sample/sample-k=
eys/ffdhe2048=2Epem<br>D src/openvpn/ring_buffer=2Eh<br>M src/openvpnserv/i=
nteractive=2Ec<br>3 files changed, 0 insertions(+), 135 deletions(-)<br><br=
></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;"><span>diff --git a/sample/sample-keys/ffdhe2048=2Epem b/sample/sample-=
keys/ffdhe2048=2Epem</span><br><span>deleted file mode 100644</span><br><sp=
an>index 9b182b7=2E=2E0000000</span><br><span>--- a/sample/sample-keys/ffdh=
e2048=2Epem</span><br><span>+++ /dev/null</span><br><span>@@ -1,8 +0,0 @@</=
span><br><span>------BEGIN DH PARAMETERS-----</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-MIIBCAKCAQEA//////////+t+FRYortKmq/cViAnPTzx2LnFg84=
tNpWp4TZBFGQz</span><br><span style=3D"color: hsl(0, 100%, 40%);">-+8yTnc4k=
mz75fS/jY2MMddj2gbICrsRhetPfHtXV/WVhJDP1H18GbtCFY2VVPe0a</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-87VXE15/V8k1mE8McODmi3fipona8+/och3xWKE2=
rec1MKzKT0g6eXq8CrGCsyT7</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-YdEIqUuyyOP7uWrat2DX9GgdT0Kj3jlN9K5W7edjcrsZCwenyO4KbXCeAvzhzffi</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-7MA0BM0oNC9hkXL+nOmFg/+OTxIy7=
vKBg8P+OxtMb61zO7X8vC7CIAXFjvGDfRaD</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-ssbzSibBsu/6iGtCOGEoXJf//////////wIBAg=3D=3D</span><br><span>=
------END DH PARAMETERS-----</span><br><span>diff --git a/src/openvpn/ring_=
buffer=2Eh b/src/openvpn/ring_buffer=2Eh</span><br><span>deleted file mode =
100644</span><br><span>index aebcd9c=2E=2E0000000</span><br><span>--- a/src=
/openvpn/ring_buffer=2Eh</span><br><span>+++ /dev/null</span><br><span>@@ -=
1,124 +0,0 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- *  OpenVPN -- An applicati=
on to securely tunnel IP networks</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- *             over a single UDP port, with support for SSL/TLS=
-based</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *             =
session authentication and key exchange,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- *             packet encryption, packet authentication,=
 and</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *             pa=
cket compression=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  Copyright (C) 200=
2-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- *                2019 Lev Stipakov &lt;lev@openvp=
n=2Enet&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- *  This program is free soft=
ware; you can redistribute it and/or modify</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- *  it under the terms of the GNU General Public Lice=
nse version 2</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  as p=
ublished by the Free Software Foundation=2E</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- *  This program is distributed in the hope that it will be useful,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- *  but WITHOUT ANY WARRAN=
TY; without even the implied warranty of</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=
=2E  See the</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  GNU G=
eneral Public License for more details=2E</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- *  You should have received a copy of the GNU General Public License alon=
g</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this progra=
m; if not, write to the Free Software Foundation, Inc=2E,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Street, Fifth Floor, Bo=
ston, MA 02110-1301 USA=2E</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#ifdef _WIN32</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#ifndef OPENVPN_RING_BUFFER_H</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#define OPENVPN_RING_BUFFER_H</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#include &lt;windows=2Eh&gt;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#include &lt;winioctl=2Eh&gt;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#include &lt;stdint=2Eh&gt;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#include &lt;stdbool=2Eh&gt;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Va=
lues below are taken from Wireguard Windows client</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * https://github=2Ecom/WireGuard/wireguard-go=
/blob/master/tun/wintun/ring_windows=2Ego#L14</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#define WINTUN_RING_CAPACITY       0x800000</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#define WINTUN_RING_TRAILING_BYTES 0x10000</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#define WINTUN_MAX_PACKET_=
SIZE     0xffff</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defin=
e WINTUN_PACKET_ALIGN        4</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define TUN_=
IOCTL_REGISTER_RINGS \</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    CTL_CODE(51820U, 0x970U, METHOD_BUFFERED, FILE_READ_DATA | FILE_WRITE_=
DATA)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- * Wintun ring buffer</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- * See https://github=2Ecom/WireGuard/wintun#ring-layou=
t</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-struct tun_ring</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    volatile ULONG head;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    volatile ULONG tail;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    volatile LONG alertable;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    UCHAR data[WINTUN_RING_CAPACITY + WINTUN_RING_=
TRAILING_BYTES];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-};</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * Struct for ring buffers registration</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * See https://github=2Ecom/WireGuard/wintu=
n#registering-rings</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-struct tun_register_=
rings</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    struct</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        ULONG ring_size;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        struct tun_ring *ring;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        HANDLE tail_moved;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    } send, receive;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-};</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-struct TUN_P=
ACKET_HEADER</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    uint32_t size;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-};</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-struct TUN_PACKET</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint32_t size;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    UCHAR data[WINTUN_MA=
X_PACKET_SIZE];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-};</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- * Registers ring buffers used to exchange data between</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * userspace openvpn process a=
nd wintun kernel driver,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * see https://github=2Ecom/WireGuard/wintun#registering-rings</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * @param device              handle to opened win=
tun device</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param s=
end_ring           pointer to send ring</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- * @param receive_ring        pointer to receive ring</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param send_tail_moved=
     event set by wintun to signal openvpn</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- *                            that data is available f=
or reading in send ring</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- * @param receive_tail_moved  event set by openvpn to signal wintun</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- *                         =
   that data has been written to receive ring</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * @return                    true if registration =
is successful, false otherwise - use</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * GetLastError()</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static =
inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-register_r=
ing_buffers(HANDLE device, struct tun_ring *send_ring, struct tun_ring *rec=
eive_ring,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
           HANDLE send_tail_moved, HANDLE receive_tail_moved)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    struct tun_register_rings rr;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    BOOL res;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    DWORD bytes_returned;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    ZeroMemory(&amp;rr, sizeof(rr));</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    rr=2Esend=2Ering =3D send_ring;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    rr=2Esend=2Ering_size =3D sizeof(struct tun_ring);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    rr=2Esend=2Etail_moved =
=3D send_tail_moved;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    rr=2Ereceive=2Erin=
g =3D receive_ring;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  rr=2Ereceive=2Ering_size =3D sizeof(struct tun_ring);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    rr=2Ereceive=2Etail_moved =3D receive=
_tail_moved;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    res =3D DeviceIoControl(de=
vice, TUN_IOCTL_REGISTER_RINGS, &amp;rr, sizeof(rr), NULL, 0,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                          &amp;byte=
s_returned, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    return res !=3D FALS=
E;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#endif /* ifndef OPENVPN_RING_BUFFER_H */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#endif /* ifdef _WIN32 */</span><br><spa=
n>diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactiv=
e=2Ec</span><br><span>index 354fe09=2E=2E6bd679f 100644</span><br><span>---=
 a/src/openvpnserv/interactive=2Ec</span><br><span>+++ b/src/openvpnserv/in=
teractive=2Ec</span><br><span>@@ -55,9 +55,6 @@</span><br><span> static HAN=
DLE rdns_semaphore =3D NULL;</span><br><span> #define RDNS_TIMEOUT 600 /* s=
econds to wait for the semaphore */</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define TUN_IOCTL_REGISTER_RINGS \</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    CTL_CODE(51820U, 0x970U, M=
ETHOD_BUFFERED, FILE_READ_DATA | FILE_WRITE_DATA)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span> openvpn_service_t interactive=
_service =3D { interactive, _L(PACKAGE_NAME) L&quot;ServiceInteractive&quot=
;,</span><br><span>                                           _L(PACKAGE_NA=
ME) L&quot; Interactive Service&quot;,</span><br><span>                    =
                       SERVICE_DEPENDENCIES, SERVICE_AUTO_START };</span><b=
r></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2230?usp=3Demail">change 2230</a>=2E To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eo=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2230?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType:=
 merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: Ie074a6f52589f9bb3c0c98b95def5e8115a7c621 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 2230 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none">=
 Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Heiko=
 Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div style=3D"display:non=
e"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt=
; </div>

</body></html>
--llX2WQioscA=--


--===============7405728366529161059==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7405728366529161059==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7405728366529161059==--

