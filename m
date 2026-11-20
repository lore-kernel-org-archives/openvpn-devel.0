Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69116606A32A
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=erJyIHcq;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=F4frhNLF;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=iHvSZ5nT;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=VU6fVMJZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=OWfNAGCW4mD8G/LD7BJ5rjEwGEdQsg6j+dYMVj67Oi0=; b=erJyIHcqoV14aGNweRyl+UMio9
	50kSNJFthFWrej4w8sRY4CmUBSgjrEf6uYzgcHIkSOJ3QqF3CSYycwWDTkb30h0/ozzEpw+k/vUvY
	nFEL3zW1HHdA9I6mcOWJW0nRD26NBniKdf/yGgvPn6ubNmRpdPwRsdbUmdsiuTYMfREQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUO9f-000000004YU-0gUT;
	Fri, 20 Nov 2026 12:55:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUO9d-000000004YM-03N5
 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 12:55:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=29s6/TZpWUmHEFMY06deSuppi55rOtuz7KhEZQJ4hBc=; b=F4frhNLFPaYGocH7CcDqY4BIvu
 nqvU+36KiuvjlN/U5LmDn/eXouWIlJdLKfQgUh7nlYGpgW2Sn7e1so1PL90rKkrJ0290F+q/tTu6Y
 zMYCRnhgncIoY/6/Sfw88PlyznzzXggTMhigavO96APrGjHxHhATvfsT/Aqbp5rLca94=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=29s6/TZpWUmHEFMY06deSuppi55rOtuz7KhEZQJ4hBc=; b=iHvSZ5nTgosc+lkXBoeNHXL16s
 b1seHfjOLH2NiXxMjudf7TEX5ESC7uxebS8bq3sYCAfXpBZE3AdavPyOINV3jPDIZEbV5GylxFl9l
 frgYxQrSvBTi0VEF+KV75Vun/7uYRTC/0M1QmBpghL6SmVkHnYL2WJvK32UeDTBqV4Xw=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUO9b-000000006m3-2wlV for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 12:55:48 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48dee593f18so733864f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 04:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795179341; x=1795784141; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=29s6/TZpWUmHEFMY06deSuppi55rOtuz7KhEZQJ4hBc=;
 b=VU6fVMJZO4dZQeez4fy5I+jBT/kCNNsgxMa4OYMlnDruhhE5A6oSSN1w/uTUK2pmcl
 zzzbK+ovBjqTcCMxgF7KmS9tI4R0DEsydMw2O0BLIx434Onf/lTbOQbI1N/jqNosgzf3
 cBUHeRBQnZUrYdpVEylcj/Av7YPV8hha4dIMTA/TJyBl9vNwiGq5oqChWsLMYbVatkOA
 l+b96nyolaEJQY5EanMqFPyqzpJzF1IcoqjyUaXnDK5ePafotZgebIdnGE75XghyRg/n
 WaeMP7I8MSUsch/fS8twdXdsH+KRNGrfhr+CV3DLfY6OkOPlPx/9k7MkgesOEg3ic1ug
 SxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795179341; x=1795784141;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=29s6/TZpWUmHEFMY06deSuppi55rOtuz7KhEZQJ4hBc=;
 b=SnQ1YnzXL6m+4b3j7z5ull1ok2ytnCcs4KSkVWeSz07pCrIxO3hZ1rY79t0YJEV0gw
 U+A4gvvmvGCrwhDsl1B1GucTaH1+nRF+RD2uRuq9B0jxnWruHSzOnzZ6Ey0AIr8wEZZz
 MC0lb2ab8RGVUIrQcS/zdyLjXkNtAG6wtWHNWtyiPaSA/UmaXrEeoa1uCK+FBXfv5PBs
 QwarAQSjdIovjKkjgUNgGAHnoM34gSNWWpO1RlDozJdx+9cWiAvGcRkACiT2ess7HBQe
 kP2bx/WPqUNwuALxHG0mPDVuWpBTBIirAyDrwnyFqL/59KvRWVLvmlEXSiK3BCXQ1ekl
 BrIQ==
X-Gm-Message-State: APuU4Z8Zq0m4u0ry1Rf5tWsUNNZCYUlGvoAboWi9prcBalv2sgg8TrD1
 UpOyt1+WUJgQ2zaFkZo3SqjbJM8HycWb07aGS4+PiMUIFnUJ6Hwe1PejFl2NCYUloJgUCDxeRiH
 lM8f7jRzXgWYIr96lN3w394fvvknM5gTBgf+wSOqAoz59i2EhZM5e2AcPtngXRlhMe4z445i0ME
 MbDJLc0Q==
X-Gm-Gg: AZFdTZcq9GlHBocwxkEjvLJAKO+VOnqfUquJcOKayT8BGFuHyJd7iviszEoSTrqNWDT
 1LHiYYGHlzPblPKyBAl9dbbyb+zsQiPmPnQxQAawyyG0/rrQiebW/Gd8qysEu6Lvpqi0UkbrRgR
 4utAFQi76NTO1XUwimtUMgctiLEbNNjnrpLdG+uByvqKf3RzwCTowGTXVidMspiz51gn0/qZ1KK
 yzHypoSBviW2+rtPKSFAE2vjLeZJhUgIH6WP2pMvC/ny8RI8UiitchbZkhc7FGJGculaTbAgdG3
 3om2mXxJ6PXLP55hIGUJAuNRrIrDy1xwlZwpqyfKdXlZc9GAgN5yKWYVyonDsBh3GCsELvmrq0x
 nJa8XLXux5Dtsh/Fy4X70281Xlq3jCQ4Bgoq5rAC5F3CF4AjCAC+O+8mpB8Z02L5tlQiAwfHRMJ
 6rK05L1/A1ivFONiZ1qLg5xgIWAnfF2ZJ6gbekass/cJ8tKGeQwQToVl+Fk/ECYyMdjtjq3WSHA
 P1LHe4wTI5uru6av9O0oDjKpQA8DUTn/vFfOQTK4w3DY6QOXhFQHBRZllOGtM9YQrEb/rlKCTQZ
 +SxYkwByuWKYFk9/Vu7e882jS9tU3ceZB+gYwMMeoKdbc1v0utH8zXn9GTBOtVW13r5z6R09UPz
 JkeAn4Z29ELncmFNyTx8AN/63Ft5qeaDYVIeZLHeAqoQkpbCZda7Z6QYqBcvcmnkBJZE8UomsPM
 T5BfSoGnO0f3Scw+jn6yjtBds9C/Flq/chNFWU
X-Received: by 2002:a05:6000:29c6:b0:49b:b93d:9631 with SMTP id
 ffacd0b85a97d-4abb4b85a51mr4633712f8f.48.1795179340793; 
 Fri, 20 Nov 2026 04:55:40 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab5ffcad11sm5564223f8f.0.2026.11.20.04.55.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 04:55:40 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 20 Nov 2026 12:55:40 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ie074a6f52589f9bb3c0c98b95def5e8115a7c621
X-Gerrit-Change-Number: 2230
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2230?usp=email>
X-Gerrit-Commit: cb7a5101e1ce4335e73d6054bf89d7f731df8548
References: <gerrit.1795179338000.Ie074a6f52589f9bb3c0c98b95def5e8115a7c621@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MTc5MzM4MDAwLkllMDc0YTZmNTI1ODlmOWJiM2MwYzk4Yjk1ZGVmNWU4MTE1YTdjNjIxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fdd061593bb60048657bd06cb2a60fe51b49b86b-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xUO9b-000000006m3-2wlV
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3604463524289653861=="
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3604463524289653861==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EKM+WMrCi2E="; charset=UTF-8

--EKM+WMrCi2E=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2230?usp=3Demail

to review the following change=2E
=


Change subject: Remove orphaned ring_buffer=2Eh and ffdhe2048=2Epem
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Remove orphaned =
ring_buffer=2Eh and ffdhe2048=2Epem

ring_buffer=2Eh was deleted with Wintu=
n support in ad7a6945 but came back
with the clang-format reformat in 3cca3=
367=2E Nothing includes it=2E Also
drop the unused TUN_IOCTL_REGISTER_RINGS=
 define in interactive=2Ec=2E

ffdhe2048=2Epem was added for the t_server_n=
ull tests in b60ba20c, which
switched to --dh none in 494fb718=2E Nothing r=
eferences it=2E

Change-Id: Ie074a6f52589f9bb3c0c98b95def5e8115a7c621
Signe=
d-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
D sample/sample-keys/=
ffdhe2048=2Epem
D src/openvpn/ring_buffer=2Eh
M src/openvpnserv/interactive=
=2Ec
3 files changed, 0 insertions(+), 135 deletions(-)



  git pull ssh:/=
/gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/30/2230/1

diff --git a/=
sample/sample-keys/ffdhe2048=2Epem b/sample/sample-keys/ffdhe2048=2Epem
del=
eted file mode 100644
index 9b182b7=2E=2E0000000
--- a/sample/sample-keys/f=
fdhe2048=2Epem
+++ /dev/null
@@ -1,8 +0,0 @@
------BEGIN DH PARAMETERS-----=

-MIIBCAKCAQEA//////////+t+FRYortKmq/cViAnPTzx2LnFg84tNpWp4TZBFGQz
-+8yTnc4=
kmz75fS/jY2MMddj2gbICrsRhetPfHtXV/WVhJDP1H18GbtCFY2VVPe0a
-87VXE15/V8k1mE8M=
cODmi3fipona8+/och3xWKE2rec1MKzKT0g6eXq8CrGCsyT7
-YdEIqUuyyOP7uWrat2DX9GgdT=
0Kj3jlN9K5W7edjcrsZCwenyO4KbXCeAvzhzffi
-7MA0BM0oNC9hkXL+nOmFg/+OTxIy7vKBg8=
P+OxtMb61zO7X8vC7CIAXFjvGDfRaD
-ssbzSibBsu/6iGtCOGEoXJf//////////wIBAg=3D=
=3D
------END DH PARAMETERS-----
diff --git a/src/openvpn/ring_buffer=2Eh b=
/src/openvpn/ring_buffer=2Eh
deleted file mode 100644
index aebcd9c=2E=2E00=
00000
--- a/src/openvpn/ring_buffer=2Eh
+++ /dev/null
@@ -1,124 +0,0 @@
-/*=

- *  OpenVPN -- An application to securely tunnel IP networks
- *         =
    over a single UDP port, with support for SSL/TLS-based
- *             =
session authentication and key exchange,
- *             packet encryption,=
 packet authentication, and
- *             packet compression=2E
- *
- *  =
Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
- *              =
  2019 Lev Stipakov <lev@openvpn=2Enet>
- *
- *  This program is free softw=
are; you can redistribute it and/or modify
- *  it under the terms of the G=
NU General Public License version 2
- *  as published by the Free Software =
Foundation=2E
- *
- *  This program is distributed in the hope that it will=
 be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warrant=
y of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
-=
 *  GNU General Public License for more details=2E
- *
- *  You should have=
 received a copy of the GNU General Public License along
- *  with this pro=
gram; if not, write to the Free Software Foundation, Inc=2E,
- *  51 Frankl=
in Street, Fifth Floor, Boston, MA 02110-1301 USA=2E
- */
-
-#ifdef _WIN32
=
-#ifndef OPENVPN_RING_BUFFER_H
-#define OPENVPN_RING_BUFFER_H
-
-#include <=
windows=2Eh>
-#include <winioctl=2Eh>
-
-#include <stdint=2Eh>
-#include <s=
tdbool=2Eh>
-
-/*
- * Values below are taken from Wireguard Windows client
=
- * https://github=2Ecom/WireGuard/wireguard-go/blob/master/tun/wintun/ring=
_windows=2Ego#L14
- */
-#define WINTUN_RING_CAPACITY       0x800000
-#defin=
e WINTUN_RING_TRAILING_BYTES 0x10000
-#define WINTUN_MAX_PACKET_SIZE     0x=
ffff
-#define WINTUN_PACKET_ALIGN        4
-
-#define TUN_IOCTL_REGISTER_RI=
NGS \
-    CTL_CODE(51820U, 0x970U, METHOD_BUFFERED, FILE_READ_DATA | FILE_=
WRITE_DATA)
-
-/**
- * Wintun ring buffer
- * See https://github=2Ecom/Wire=
Guard/wintun#ring-layout
- */
-struct tun_ring
-{
-    volatile ULONG head;=

-    volatile ULONG tail;
-    volatile LONG alertable;
-    UCHAR data[WI=
NTUN_RING_CAPACITY + WINTUN_RING_TRAILING_BYTES];
-};
-
-/**
- * Struct for=
 ring buffers registration
- * See https://github=2Ecom/WireGuard/wintun#re=
gistering-rings
- */
-struct tun_register_rings
-{
-    struct
-    {
-    =
    ULONG ring_size;
-        struct tun_ring *ring;
-        HANDLE tail_m=
oved;
-    } send, receive;
-};
-
-struct TUN_PACKET_HEADER
-{
-    uint32_=
t size;
-};
-
-struct TUN_PACKET
-{
-    uint32_t size;
-    UCHAR data[WIN=
TUN_MAX_PACKET_SIZE];
-};
-
-/**
- * Registers ring buffers used to exchang=
e data between
- * userspace openvpn process and wintun kernel driver,
- * =
see https://github=2Ecom/WireGuard/wintun#registering-rings
- *
- * @param =
device              handle to opened wintun device
- * @param send_ring    =
       pointer to send ring
- * @param receive_ring        pointer to recei=
ve ring
- * @param send_tail_moved     event set by wintun to signal openvp=
n
- *                            that data is available for reading in send=
 ring
- * @param receive_tail_moved  event set by openvpn to signal wintun
=
- *                            that data has been written to receive ring
-=
 * @return                    true if registration is successful, false oth=
erwise - use
- * GetLastError()
- */
-static inline bool
-register_ring_buf=
fers(HANDLE device, struct tun_ring *send_ring, struct tun_ring *receive_ri=
ng,
-                      HANDLE send_tail_moved, HANDLE receive_tail_move=
d)
-{
-    struct tun_register_rings rr;
-    BOOL res;
-    DWORD bytes_re=
turned;
-
-    ZeroMemory(&rr, sizeof(rr));
-
-    rr=2Esend=2Ering =3D sen=
d_ring;
-    rr=2Esend=2Ering_size =3D sizeof(struct tun_ring);
-    rr=2Es=
end=2Etail_moved =3D send_tail_moved;
-
-    rr=2Ereceive=2Ering =3D receiv=
e_ring;
-    rr=2Ereceive=2Ering_size =3D sizeof(struct tun_ring);
-    rr=
=2Ereceive=2Etail_moved =3D receive_tail_moved;
-
-    res =3D DeviceIoCont=
rol(device, TUN_IOCTL_REGISTER_RINGS, &rr, sizeof(rr), NULL, 0,
-          =
                &bytes_returned, NULL);
-
-    return res !=3D FALSE;
-}
-
=
-#endif /* ifndef OPENVPN_RING_BUFFER_H */
-#endif /* ifdef _WIN32 */
diff =
--git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec
i=
ndex 354fe09=2E=2E6bd679f 100644
--- a/src/openvpnserv/interactive=2Ec
+++ =
b/src/openvpnserv/interactive=2Ec
@@ -55,9 +55,6 @@
 static HANDLE rdns_sem=
aphore =3D NULL;
 #define RDNS_TIMEOUT 600 /* seconds to wait for the semap=
hore */
 
-#define TUN_IOCTL_REGISTER_RINGS \
-    CTL_CODE(51820U, 0x970U,=
 METHOD_BUFFERED, FILE_READ_DATA | FILE_WRITE_DATA)
-
 openvpn_service_t in=
teractive_service =3D { interactive, _L(PACKAGE_NAME) L"ServiceInteractive"=
,
                                           _L(PACKAGE_NAME) L" Interactiv=
e Service",
                                           SERVICE_DEPENDENCIES=
, SERVICE_AUTO_START };

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2230?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chan=
ge-Id: Ie074a6f52589f9bb3c0c98b95def5e8115a7c621
Gerrit-Change-Number: 2230=

Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eo=
rg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: o=
penvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>

--EKM+WMrCi2E=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2230?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">Remove orphaned ring_buffer=2Eh and ffdhe2048=2Epem<br>=
<br>ring_buffer=2Eh was deleted with Wintun support in ad7a6945 but came ba=
ck<br>with the clang-format reformat in 3cca3367=2E Nothing includes it=2E =
Also<br>drop the unused TUN_IOCTL_REGISTER_RINGS define in interactive=2Ec=
=2E<br><br>ffdhe2048=2Epem was added for the t_server_null tests in b60ba20=
c, which<br>switched to --dh none in 494fb718=2E Nothing references it=2E<b=
r><br>Change-Id: Ie074a6f52589f9bb3c0c98b95def5e8115a7c621<br>Signed-off-by=
: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>D sample/sample-k=
eys/ffdhe2048=2Epem<br>D src/openvpn/ring_buffer=2Eh<br>M src/openvpnserv/i=
nteractive=2Ec<br>3 files changed, 0 insertions(+), 135 deletions(-)<br><br=
></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/30/2230/1</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/sample/sample-keys/ffdhe2048=2Epe=
m b/sample/sample-keys/ffdhe2048=2Epem</span><br><span>deleted file mode 10=
0644</span><br><span>index 9b182b7=2E=2E0000000</span><br><span>--- a/sampl=
e/sample-keys/ffdhe2048=2Epem</span><br><span>+++ /dev/null</span><br><span=
>@@ -1,8 +0,0 @@</span><br><span>------BEGIN DH PARAMETERS-----</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-MIIBCAKCAQEA//////////+t+FRYortKm=
q/cViAnPTzx2LnFg84tNpWp4TZBFGQz</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-+8yTnc4kmz75fS/jY2MMddj2gbICrsRhetPfHtXV/WVhJDP1H18GbtCFY2VVPe0a<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-87VXE15/V8k1mE8McODmi3=
fipona8+/och3xWKE2rec1MKzKT0g6eXq8CrGCsyT7</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-YdEIqUuyyOP7uWrat2DX9GgdT0Kj3jlN9K5W7edjcrsZCwenyO4KbX=
CeAvzhzffi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-7MA0BM0oNC9=
hkXL+nOmFg/+OTxIy7vKBg8P+OxtMb61zO7X8vC7CIAXFjvGDfRaD</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-ssbzSibBsu/6iGtCOGEoXJf//////////wIBAg=3D=
=3D</span><br><span>------END DH PARAMETERS-----</span><br><span>diff --git=
 a/src/openvpn/ring_buffer=2Eh b/src/openvpn/ring_buffer=2Eh</span><br><spa=
n>deleted file mode 100644</span><br><span>index aebcd9c=2E=2E0000000</span=
><br><span>--- a/src/openvpn/ring_buffer=2Eh</span><br><span>+++ /dev/null<=
/span><br><span>@@ -1,124 +0,0 @@</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  Ope=
nVPN -- An application to securely tunnel IP networks</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *             over a single UDP port, with=
 support for SSL/TLS-based</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- *             session authentication and key exchange,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- *             packet encryption, pa=
cket authentication, and</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- *             packet compression=2E</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
*  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- *                2019 Lev Sti=
pakov &lt;lev@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  This =
program is free software; you can redistribute it and/or modify</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- *  it under the terms of the GNU=
 General Public License version 2</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- *  as published by the Free Software Foundation=2E</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- *  This program is distributed in the hope that it =
will be useful,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  bu=
t WITHOUT ANY WARRANTY; without even the implied warranty of</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- *  MERCHANTABILITY or FITNESS FOR A=
 PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- *  GNU General Public License for more details=2E</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- *  You should have received a copy of the GNU General =
Public License along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
*  with this program; if not, write to the Free Software Foundation, Inc=2E=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  51 Franklin Stre=
et, Fifth Floor, Boston, MA 02110-1301 USA=2E</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef _WIN32</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifndef OPENVPN_RING_BU=
FFER_H</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define OPENVPN=
_RING_BUFFER_H</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;windows=2Eh&gt;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;winioctl=
=2Eh&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#include &lt;stdint=2Eh&gt;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;stdbool=2Eh&gt;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * Values below are taken from Wireguard Windows client</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- * https://github=2Ecom/Wir=
eGuard/wireguard-go/blob/master/tun/wintun/ring_windows=2Ego#L14</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#define WINTUN_RING_CAPACITY       0x800000</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#define WINTUN_RING_TRAILING=
_BYTES 0x10000</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define=
 WINTUN_MAX_PACKET_SIZE     0xffff</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#define WINTUN_PACKET_ALIGN        4</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#define TUN_IOCTL_REGISTER_RINGS \</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    CTL_CODE(51820U, 0x970U, METHOD_BUFFERED, FILE_READ=
_DATA | FILE_WRITE_DATA)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * Wintun ring buffer</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * See https://github=2Ecom/WireGuar=
d/wintun#ring-layout</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-struct tun_ring</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    volatile ULONG head;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    volatile ULONG tail;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    volatile LONG alertable;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    UCHAR data[WINTUN_RING_CAP=
ACITY + WINTUN_RING_TRAILING_BYTES];</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-};</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * Struct for ring buffers registration</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * See https://github=2Ec=
om/WireGuard/wintun#registering-rings</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-st=
ruct tun_register_rings</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        ULONG ring_size;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        struct tun_ring *ring;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        HANDLE tail_moved;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    } send, receive;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-};</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-struct TUN_PACKET_HEADER</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint3=
2_t size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-};</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-struct TUN_PACKET</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   uint32_t size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
UCHAR data[WINTUN_MAX_PACKET_SIZE];</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-};</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * Registers ring buffers used to exchange =
data between</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * usersp=
ace openvpn process and wintun kernel driver,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * see https://github=2Ecom/WireGuard/wintun#regist=
ering-rings</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * @param device             =
 handle to opened wintun device</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * @param send_ring           pointer to send ring</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * @param receive_ring        pointe=
r to receive ring</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @=
param send_tail_moved     event set by wintun to signal openvpn</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- *                            tha=
t data is available for reading in send ring</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- * @param receive_tail_moved  event set by openvpn t=
o signal wintun</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *    =
                        that data has been written to receive ring</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * @return                    =
true if registration is successful, false otherwise - use</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * GetLastError()</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-static inline bool</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-register_ring_buffers(HANDLE device, struct tun_ring *send_ring,=
 struct tun_ring *receive_ring,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                      HANDLE send_tail_moved, HANDLE receive_tail=
_moved)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    struct tun_register_rings rr;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    BOOL res;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    DWORD bytes_returned;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    ZeroMemory(&amp;rr, sizeof(rr));</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    rr=2Esend=2Ering =3D send_ring;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    rr=2Esend=2Ering_size =3D sizeof(st=
ruct tun_ring);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    rr=
=2Esend=2Etail_moved =3D send_tail_moved;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   rr=2Ereceive=2Ering =3D receive_ring;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    rr=2Ereceive=2Ering_size =3D sizeof(struct tun_ring)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    rr=2Ereceive=2Et=
ail_moved =3D receive_tail_moved;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    res =
=3D DeviceIoControl(device, TUN_IOCTL_REGISTER_RINGS, &amp;rr, sizeof(rr), =
NULL, 0,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
             &amp;bytes_returned, NULL);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  return res !=3D FALSE;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#endif /* ifndef OPENVPN_RING_BUFFER_H=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ifdef _W=
IN32 */</span><br><span>diff --git a/src/openvpnserv/interactive=2Ec b/src/=
openvpnserv/interactive=2Ec</span><br><span>index 354fe09=2E=2E6bd679f 1006=
44</span><br><span>--- a/src/openvpnserv/interactive=2Ec</span><br><span>++=
+ b/src/openvpnserv/interactive=2Ec</span><br><span>@@ -55,9 +55,6 @@</span=
><br><span> static HANDLE rdns_semaphore =3D NULL;</span><br><span> #define=
 RDNS_TIMEOUT 600 /* seconds to wait for the semaphore */</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define TUN_IOCTL_REG=
ISTER_RINGS \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    CTL_=
CODE(51820U, 0x970U, METHOD_BUFFERED, FILE_READ_DATA | FILE_WRITE_DATA)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> openvpn=
_service_t interactive_service =3D { interactive, _L(PACKAGE_NAME) L&quot;S=
erviceInteractive&quot;,</span><br><span>                                  =
         _L(PACKAGE_NAME) L&quot; Interactive Service&quot;,</span><br><spa=
n>                                           SERVICE_DEPENDENCIES, SERVICE_=
AUTO_START };</span><br></pre><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2230?usp=3Demail">change 2230</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2230?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie074a6f52589f9bb3=
c0c98b95def5e8115a7c621 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 2230 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<=
div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@=
mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--EKM+WMrCi2E=--


--===============3604463524289653861==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3604463524289653861==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3604463524289653861==--

