Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7046606A325
	for <openvpn-devel@archiver.kernel.org>; Thu, 19 Nov 2026 10:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=i2mEEl6T;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=L7mkrtB1;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=M03A176Q;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=BDFa7Y6R
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=i2nl9buPFFmhfnS7I2mucF9/2+29EA7wHtt2vQD9IUs=; b=i2mEEl6TxZac/Gpyef57TJ0zH2
	pG996kl84E1iVNWJfd92Tth30KKdys0QnuhnmAJYgNbr1qQG4V3I0nGzgeq7AwoX3L5gYOnEi27E3
	EgVGaHtLwwjkIiJtWb91LcLSGjr+IkRC2uz5C55agQAHWYX5xgUZcq3NyKy7d1Ip0luk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTzkc-000000000Gl-1woh;
	Thu, 19 Nov 2026 10:52:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTzkb-000000000Ge-31BB
 for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 10:52:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=crDZqove7eeErHC8mqoOD3UbCPSLAfpRNYu9axS4PeM=; b=L7mkrtB1T4vA8/VKgsKeEECdxq
 OZtGR0JY0JJ1e8Wt8l7ccR9NZBY0ZvwSUT61Lq1UPKHfo8dIMzQSaa3IS5zsWMlwUqpAfBZ5MnoIK
 sFYt8NseCXB9H36xS6k7MfpCLPphoMG/d5tIsfGgVGiv0j3Ctau/29x9zctaLcepuym0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=crDZqove7eeErHC8mqoOD3UbCPSLAfpRNYu9axS4PeM=; b=M03A176QB1Zj/WuYSIqSf6Spvk
 /CfCMdkLXMh8cyu2hYtOuIGZ3D4f8TWLVQ9PozFM8FJHGa1Tg6OV+xB8gErsWMj67w9SJ0gL2us8F
 uHeDgeUXOMBpkopuvARSVnuSKswbjgBnznTGUAq+v6HN4GILBy+20wau9Q0wOyU2WCYA=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTzkO-000000006Um-3lpg for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 10:52:21 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-492fcbfaa88so1335056f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 19 Nov 2026 02:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795085522; x=1795690322; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=crDZqove7eeErHC8mqoOD3UbCPSLAfpRNYu9axS4PeM=;
 b=BDFa7Y6RPpyVM3gsK0jOanAGL/IUQ2LYIhFMKcsVsrjmRogX+wPDI00CZQIWHYzP5B
 Mcd38clUAN7d9C6bm6px8VQLTFp3UQ/Ze+hh8PiAybm0RRiFCmlu1LuSXRiSjAi1njI6
 fylkq9EPaaW+fPIk63lXabepB0PMfluOiSkJw43XE/sEzrpF1KaLsnwH2Wq8H/g4Iys9
 U97NpFEECfeZA0RHx8QwqSSIFBeK808UgK2qMVXrE7S1mYJ3H0OqpUq39yyZk0I9Ohdp
 W0RFoYnt7p2zTaJ8HYE9BBiPvXkatNBiUtHORwYaTLDXV2T93i3TXJjQz/7z5JCAsL0F
 ilMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795085522; x=1795690322;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=crDZqove7eeErHC8mqoOD3UbCPSLAfpRNYu9axS4PeM=;
 b=bgLhUVx/f0SLQO2GC+nhwRDEEpBiD+/FScwGXp1uOrnMtdTeCFh+2+jpHpD/C9S4dY
 EhcF6sgmiokzzaJZVkKaputEBqcZJCu7pTAiZh4MqYW2wE7qQTsoBFKwsiWp6jz+VJFg
 Q+qyoIIYrGuDaTZE6d7fMBQFmEvdTvQ1s1eT7m2SUKf9RGL6I2axAWFUF5HhGwZItAfy
 FNtcRM89q5LR7wBKCILcyG14py/L5X82aFkMl8mwROHWiMeb5prg83Me3bZMTJTdvcGh
 da/LJ3rvgP+DWeqwpHOqKfb8tbOA/a1bc8R8sG7/knHePAb4s8ImPZpp7g96/iFxB/w7
 66zg==
X-Gm-Message-State: APuU4Z+pYtaBMxS2HULiZR4/5UES9Bsh2wYXsP1IAPVjFjqIM2/4w2ak
 kuSD//OWEJW5Iw4xR7Qa+mCCuQge6SuFaMpb9Cyu13XqW610h5Ir3HrZgRP63lm+3FGM9Cb6B1i
 3i8Ip+zz2d4pnFJeiOwOpIoGnYStkjQ6AneSaD54SZZyYNODOdvREN/J22zD3XTPUBZQu
X-Gm-Gg: AZFdTZcLmRuij0nb8z9t2RE/lXG9dVGhcdfzw4htQQYAxmjyvEfNX2YhWdIaqlgo5Jg
 j48QtCRDPYezy+OBCCW2f7AsJwBaTI+GdDHsKlpjxXku675Ey1YnJ8PEvaXT7tAswR6zp84yghE
 m66JL7HMu8Bx/uAEdpmSNS4xb0SPGJXfjonAXbs2ELvHlwBY9CDf14KaSUqtclo4EtMMQRNqpoB
 3eILEPx/9ZaE9D2pcMEOe5oOzhFd8O2DI85aTiCOyhD8HG0EJKqvZ4pTX0nMOnFBCrAkdT/RNUU
 zl7VlfY3aaoB/tTrZPCQatjkj7KUgH4sS8DRM1TjA16S/b3woKhIxfdnQXrmodxhwGt9Cb7kytR
 1bhL7DRU7lUhEoCMfXv7HyI9boBlNXCrsBmw9F8BHrOYygIjNNVuisjDFu31tV/NbBQ/mT5XbLz
 KYKxVuVMr5oMze/c+DJFLG8Mr7g0n82wdpP3cHTTSxk1qZPjonAYDUGkryrdYizio1taAWFgmhM
 X/fE3QyAaJO/fvSXWOFgPajLLi16EA2ln3YlAzcU5KUKhjEOFRdFCvpmKWZRH0UXp7TfCzy0HE9
 UiQHDIadeeDnC9G46tLcGJwmnPGBHLUGA5v4miU4QOsOX/kOtBJqncBu94ses1z0VDtc/L5Yk3X
 w9oqvoOOV1/fAaEs5iTsXvIk3dKBBfV0lY2TMNt9i2uMl3oVXNdMqO9peSDtpCxKNr7ObmmOpYh
 ib2tRop+KiIdy9iog=
X-Received: by 2002:a05:6000:3cf:b0:4a6:5a2a:f5a3 with SMTP id
 ffacd0b85a97d-4a65a3a384dmr12055082f8f.3.1795085521485; 
 Thu, 19 Nov 2026 02:52:01 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a6575a5c28sm10218074f8f.59.2026.11.19.02.52.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 02:52:00 -0800 (PST)
X-Google-Original-From: "Lev Stipakov (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 19 Nov 2026 10:51:58 +0000
To: Ralf Lici <ralf@mandelbit.com>, chugly <charlie.vigue@openvpn.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 28
X-Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
X-Gerrit-Change-Number: 1741
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1741?usp=email>
X-Gerrit-Commit: dda90ce314178fc7e85df6a52ef4842fe1911b6a
In-Reply-To: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxYzhkMzAyYWM1N2M1NjAzZDYyMmE3YmUxNGJlMzY5NDM3Mzg4MjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fac00290345f8dfa28e3b464896fe7a4e9f5bbf8-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTzkO-000000006Um-3lpg
Subject: [Openvpn-devel] [L] Change in openvpn[master]: control_msg: Add
 P_CONTROL_V2 and the probe request and reply TLVs
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
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, frank@lichtenheld.com,
 charlie.vigue@openvpn.com
Cc: "Lev Stipakov \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2291070971074918713=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2291070971074918713==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="P2zT7ynFOqg="; charset=UTF-8

--P2zT7ynFOqg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Lev =
Stipakov, Ralf Lici, R=C4=83zvan Cojocaru, chugly=2E

Hello Arne Schwabe, F=
rank Lichtenheld, Ralf Lici, R=C4=83zvan Cojocaru, chugly, 

I'd like you t=
o reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1741?usp=3Demail

to look at the new patch set (#28)=2E

The foll=
owing approvals got outdated and were removed:
Code-Review+1 by R=C4=83zvan=
 Cojocaru


Change subject: control_msg: Add P_CONTROL_V2 and the probe req=
uest and reply TLVs
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

control_msg: Add P_CONTROL_V2 and the probe request and reply TLVs
=

A client probes a server before connecting by sending a P_CONTROL_V2
messa=
ge carrying a probe request TLV, and the server answers with a
P_CONTROL_V2=
 carrying a probe reply=2E The reply tells the client how the
server wants =
to be ranked against the other remotes, and can also serve
as the second pa=
cket of the three-way handshake=2E

Add the two opcodes and the two TLV cod=
ecs the probe needs=2E P_CONTROL_V2
is framed like P_CONTROL_V1 but without=
 the fields of the reliability
layer: a session id and then the TLVs, with =
no control message id and no
ACK array=2E P_CONTROL_WKC_V2 is the same with=
 the wrapped client key
appended, as P_CONTROL_WKC_V1 is to P_CONTROL_V1=2E=


The TLVs use the shared TLV codec, control_msg=2Ec/h, and their two types=

join the others there=2E The codec gains ctrl_msg_find_tlv(), which scans
=
a payload for the one mandatory TLV of a message=2E The scan is strict: a
t=
runcated TLV header or value, a second TLV of the wanted type, or an
unknow=
n TLV not marked optional rejects the whole message=2E

Both readers accept=
 a value longer than the fields they know and ignore
the excess, which is h=
ow the TLVs are meant to be extended=2E The probe
reply reader does reject =
the two flag combinations the protocol rules
out, as neither can be acted o=
n: the other addresses of a remote cannot
be both the same server and disti=
nct ones, and the connect_lifetime
cannot be extended to those addresses wi=
thout first calling them the
same server=2E

The reliable control path no l=
onger decides what it handles from an
opcode range=2E P_FIRST_OPCODE and P_=
LAST_OPCODE give way to
opcode_is_reliable_control(), which lists the opcod=
es that carry a
message id and an ACK array, and tls_pre_decrypt_verify_opc=
ode() and
write_control_auth() test that instead=2E Defining an opcode ther=
efore no
longer joins it to that set, so the two opcodes added here need no=

carve-out from a range=2E

No opcode changes hands: the old range covered =
exactly the seven listed,
plus the two data channel opcodes, which are hand=
led before the check is
reached=2E

The probe is not sent or answered yet; =
that follows=2E

Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
Signe=
d-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M CMakeLists=2Etxt
M src/ope=
nvpn/Makefile=2Eam
M src/openvpn/control_msg=2Ec
M src/openvpn/control_msg=
=2Eh
A src/openvpn/probe=2Ec
A src/openvpn/probe=2Eh
M src/openvpn/ssl=2Ec
=
M src/openvpn/ssl_pkt=2Ec
M src/openvpn/ssl_pkt=2Eh
M tests/unit_tests/open=
vpn/Makefile=2Eam
M tests/unit_tests/openvpn/test_pkt=2Ec
A tests/unit_test=
s/openvpn/test_probe=2Ec
A tests/unit_tests/openvpn/test_probe=2Eh
13 files=
 changed, 860 insertions(+), 12 deletions(-)


  git pull ssh://gerrit=2Eop=
envpn=2Enet:29418/openvpn refs/changes/41/1741/28

diff --git a/CMakeLists=
=2Etxt b/CMakeLists=2Etxt
index 50b2d68=2E=2Ec6dcf65 100644
--- a/CMakeList=
s=2Etxt
+++ b/CMakeLists=2Etxt
@@ -565,6 +565,8 @@
     src/openvpn/plugin=
=2Eh
     src/openvpn/pool=2Ec
     src/openvpn/pool=2Eh
+    src/openvpn/p=
robe=2Ec
+    src/openvpn/probe=2Eh
     src/openvpn/proto=2Ec
     src/ope=
nvpn/proto=2Eh
     src/openvpn/proxy=2Ec
@@ -899,7 +901,9 @@
     target_s=
ources(test_pkt PRIVATE
         tests/unit_tests/openvpn/mock_win32_execve=
=2Ec
         tests/unit_tests/openvpn/test_control_msg=2Ec
+        tests/=
unit_tests/openvpn/test_probe=2Ec
         src/openvpn/control_msg=2Ec
+   =
     src/openvpn/probe=2Ec
         src/openvpn/argv=2Ec
         src/openv=
pn/base64=2Ec
         src/openvpn/crypto_epoch=2Ec
diff --git a/src/openvp=
n/Makefile=2Eam b/src/openvpn/Makefile=2Eam
index be1044d=2E=2E4c8edea 1006=
44
--- a/src/openvpn/Makefile=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -121,=
6 +121,7 @@
 	ping=2Ec ping=2Eh \
 	plugin=2Ec plugin=2Eh \
 	pool=2Ec pool=
=2Eh \
+	probe=2Ec probe=2Eh \
 	proto=2Ec proto=2Eh \
 	proxy=2Ec proxy=2E=
h \
 	ps=2Ec ps=2Eh \
diff --git a/src/openvpn/control_msg=2Ec b/src/openvp=
n/control_msg=2Ec
index e14355c=2E=2Ea77413f 100644
--- a/src/openvpn/contr=
ol_msg=2Ec
+++ b/src/openvpn/control_msg=2Ec
@@ -91,3 +91,32 @@
     buf_se=
t_read(value, v, hdr->value_len);
     return true;
 }
+
+bool
+ctrl_msg_fi=
nd_tlv(struct buffer *payload, uint16_t wanted_type, struct buffer *value)
=
+{
+    bool found =3D false;
+    while (BLEN(payload) > 0)
+    {
+      =
  struct ctrl_msg_tlv_header hdr;
+        struct buffer v;
+        if (!c=
trl_msg_tlv_next(payload, &hdr, &v))
+        {
+            return false;
=
+        }
+        if (hdr=2Etype =3D=3D wanted_type)
+        {
+        =
    if (found)
+            {
+                return false; /* the TLV may=
 occur only once */
+            }
+            *value =3D v;
+            =
found =3D true;
+        }
+        else if (!hdr=2Eoptional)
+        {
+ =
           return false; /* a mandatory TLV we do not understand, wherever =
it sits */
+        }
+    }
+    return found;
+}
diff --git a/src/openvpn=
/control_msg=2Eh b/src/openvpn/control_msg=2Eh
index 92572cb=2E=2E8ad5530 1=
00644
--- a/src/openvpn/control_msg=2Eh
+++ b/src/openvpn/control_msg=2Eh
@=
@ -41,6 +41,8 @@
 
 /* TLV types */
 #define TLV_TYPE_EARLY_NEG_FLAGS 0x000=
1 /* early negotiation, in the reset packets */
+#define TLV_TYPE_PROBE_REQ=
UEST   0x0002 /* a client probing a server, in P_CONTROL_V2 */
+#define TLV=
_TYPE_PROBE_REPLY     0x0003 /* the server's answer, in P_CONTROL_V2 */
 
 =
/* A TLV header is a 16-bit type/optional field plus a 16-bit length */
 #d=
efine CTRL_MSG_TLV_HEADER_LEN 4
@@ -105,4 +107,28 @@
  */
 bool ctrl_msg_tl=
v_next(struct buffer *buf, struct ctrl_msg_tlv_header *hdr, struct buffer *=
value);
 
+/**
+ * Scan payload for the TLV of type wanted_type, skipping a=
ny other TLV type
+ * that is marked optional=2E
+ *
+ * This is for messag=
es that carry exactly one mandatory TLV, which is what the
+ * probe messag=
es are=2E Any other TLV that is not marked optional invalidates
+ * the mes=
sage wherever it appears, as does a second TLV of wanted_type, so the
+ * w=
hole sequence is walked even once the wanted TLV has been found=2E A messag=
e
+ * carrying several mandatory TLVs walks them with ctrl_msg_tlv_next() i=
nstead=2E
+ *
+ * On success value covers exactly the found TLV's value byt=
es; as in
+ * ctrl_msg_tlv_next(), a header claiming more bytes than payloa=
d holds is
+ * rejected rather than reported as found=2E payload is consume=
d as it is read=2E
+ *
+ * @param payload      buffer positioned at a TLV h=
eader
+ * @param wanted_type  the TLV type to look for
+ * @param value    =
    set to a buffer covering the found TLV's value; it points
+ *          =
           into payload and owns no storage
+ * @return true if the TLV was=
 found, false if it is absent or present more
+ *         than once, if a T=
LV header or value is malformed or truncated, or if
+ *         a TLV we do=
 not understand is not marked optional=2E
+ */
+bool ctrl_msg_find_tlv(stru=
ct buffer *payload, uint16_t wanted_type, struct buffer *value);
+
 #endif =
/* ifndef CONTROL_MSG_H */
diff --git a/src/openvpn/probe=2Ec b/src/openvpn=
/probe=2Ec
new file mode 100644
index 0000000=2E=2E2497b07
--- /dev/null
++=
+ b/src/openvpn/probe=2Ec
@@ -0,0 +1,94 @@
+/*
+ *  OpenVPN -- An applicati=
on to securely tunnel IP networks
+ *             over a single TCP/UDP por=
t, with support for SSL/TLS-based
+ *             session authentication an=
d key exchange,
+ *             packet encryption, packet authentication, a=
nd
+ *             packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 O=
penVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free software; yo=
u can redistribute it and/or modify
+ *  it under the terms of the GNU Gene=
ral Public License version 2
+ *  as published by the Free Software Foundat=
ion=2E
+ *
+ *  This program is distributed in the hope that it will be use=
ful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ =
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU=
 General Public License for more details=2E
+ *
+ *  You should have receiv=
ed a copy of the GNU General Public License along
+ *  with this program; i=
f not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFI=
G_H
+#include "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include "p=
robe=2Eh"
+#include "control_msg=2Eh"
+
+bool
+probe_request_write(struct b=
uffer *buf, const struct probe_request *r)
+{
+    return ctrl_msg_tlv_writ=
e_header(buf, TLV_TYPE_PROBE_REQUEST, false, PROBE_REQUEST_LEN)
+          =
 && buf_write_u64(buf, r->request_id) && buf_write_u64(buf, r->timestamp)
+=
           && buf_write_u32(buf, r->flags);
+}
+
+bool
+probe_request_read(=
struct buffer *buf, struct probe_request *r)
+{
+    /* One bounds check co=
vers the whole value: every field read below then fits
+     * by construct=
ion, PROBE_REQUEST_LEN being the sum of their sizes, so none
+     * of the=
m needs its own error handling=2E Trailing bytes this version does
+     * =
not understand are simply left unread=2E */
+    if (buf_len(buf) < PROBE_R=
EQUEST_LEN)
+    {
+        return false;
+    }
+    r->request_id =3D buf=
_read_u64(buf, NULL);
+    r->timestamp =3D buf_read_u64(buf, NULL);
+    r=
->flags =3D buf_read_u32(buf, NULL);
+    return true;
+}
+
+bool
+probe_re=
ply_write(struct buffer *buf, const struct probe_reply *r)
+{
+    return c=
trl_msg_tlv_write_header(buf, TLV_TYPE_PROBE_REPLY, false, PROBE_REPLY_LEN)=

+           && buf_write_u64(buf, r->request_id) && buf_write_u16(buf, r->=
priority)
+           && buf_write_u16(buf, r->weight) && buf_write_u16(buf=
, r->max_latency_diff)
+           && buf_write_u16(buf, r->connect_lifetim=
e) && buf_write_u16(buf, r->flags);
+}
+
+bool
+probe_reply_read(struct buf=
fer *buf, struct probe_reply *r)
+{
+    /* One bounds check for the whole =
value, as in probe_request_read()=2E */
+    if (buf_len(buf) < PROBE_REPLY=
_LEN)
+    {
+        return false;
+    }
+    r->request_id =3D buf_read_=
u64(buf, NULL);
+    r->priority =3D (uint16_t)buf_read_u16(buf);
+    r->w=
eight =3D (uint16_t)buf_read_u16(buf);
+    r->max_latency_diff =3D (uint16=
_t)buf_read_u16(buf);
+    r->connect_lifetime =3D (uint16_t)buf_read_u16(b=
uf);
+    r->flags =3D (uint16_t)buf_read_u16(buf);
+
+    /* The other add=
resses of the remote cannot be both the same server and
+     * distinct on=
es=2E And LIFETIME_SHARED extends the connect_lifetime to those
+     * oth=
er addresses, which says nothing unless ADDRS_EQUAL has declared them
+    =
 * the same server to begin with=2E */
+    if ((r->flags & PROBE_REPLY_FLA=
G_ADDRS_EQUAL) && (r->flags & PROBE_REPLY_FLAG_PROBE_MORE))
+    {
+       =
 return false;
+    }
+    if ((r->flags & PROBE_REPLY_FLAG_LIFETIME_SHARED=
) && !(r->flags & PROBE_REPLY_FLAG_ADDRS_EQUAL))
+    {
+        return fal=
se;
+    }
+    return true;
+}
diff --git a/src/openvpn/probe=2Eh b/src/op=
envpn/probe=2Eh
new file mode 100644
index 0000000=2E=2E6001774
--- /dev/nu=
ll
+++ b/src/openvpn/probe=2Eh
@@ -0,0 +1,141 @@
+/*
+ *  OpenVPN -- An app=
lication to securely tunnel IP networks
+ *             over a single TCP/U=
DP port, with support for SSL/TLS-based
+ *             session authenticat=
ion and key exchange,
+ *             packet encryption, packet authenticat=
ion, and
+ *             packet compression=2E
+ *
+ *  Copyright (C) 2002-=
2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free softwa=
re; you can redistribute it and/or modify
+ *  it under the terms of the GN=
U General Public License version 2
+ *  as published by the Free Software F=
oundation=2E
+ *
+ *  This program is distributed in the hope that it will =
be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty=
 of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ =
*  GNU General Public License for more details=2E
+ *
+ *  You should have =
received a copy of the GNU General Public License along
+ *  with this prog=
ram; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+/**
+ * @fi=
le
+ * Encoding and decoding of the server probe TLVs=2E
+ *
+ * A client p=
robes a server by sending a P_CONTROL_V2 message whose payload
+ * carries =
a probe request TLV, and the server answers with a P_CONTROL_V2
+ * message=
 carrying a probe reply TLV=2E The reply tells the client how the
+ * serve=
r wants to be ranked against the other remotes, and can also serve
+ * as t=
he second packet of the three-way handshake=2E
+ *
+ * The TLV framing and =
the TLV type space are shared with the other TLV-based
+ * control messages=
 and live in control_msg=2Eh; this file holds the two probe
+ * TLVs and wh=
at their fields mean=2E
+ */
+
+#ifndef PROBE_H
+#define PROBE_H
+
+#includ=
e "buffer=2Eh"
+#include "control_msg=2Eh"
+
+/** probe request flags=2E Th=
e client is only probing: it does not want to
+ * continue into a handshake=
, and the server may forget it right away=2E */
+#define PROBE_REQUEST_FLAG=
_PROBE_ONLY 0x00000001
+
+/* probe reply flags */
+/** complete the handsha=
ke with P_CONTROL_WKC_V1 rather than P_CONTROL_V1 */
+#define PROBE_REPLY_F=
LAG_RESEND_WKC      0x0001
+/** the other addresses of this remote are the =
same server, no need to probe them */
+#define PROBE_REPLY_FLAG_ADDRS_EQUAL=
     0x0002
+/** the connect_lifetime holds against those other addresses t=
oo, so a reply
+ * from one of them can skip the handshake with another=2E =
Only meaningful
+ * together with ADDRS_EQUAL, which is what names those ad=
dresses=2E */
+#define PROBE_REPLY_FLAG_LIFETIME_SHARED 0x0004
+/** the oth=
er addresses of this remote are distinct servers, so probe them too */
+#de=
fine PROBE_REPLY_FLAG_PROBE_MORE      0x0008
+
+/** probe request TLV, sent=
 by a client to probe a server */
+struct probe_request
+{
+    uint64_t re=
quest_id; /**< identifies this probe, echoed in the reply */
+    /** The c=
lient clock as a UNIX timestamp in seconds=2E It is there for the
+     * s=
erver, which uses it to bound how old a request it will answer and so
+    =
 * how long a captured one can be replayed=2E The reply does not echo it: a=

+     * client times the round trip itself, by the request_id=2E */
+    u=
int64_t timestamp;
+    uint32_t flags; /**< PROBE_REQUEST_FLAG_* */
+};
+
=
+/** probe reply TLV, a server's answer to a probe request */
+struct probe=
_reply
+{
+    uint64_t request_id;       /**< echoes the request_id of the=
 request */
+    uint16_t priority;         /**< DNS SRV style priority, lo=
wer is preferred */
+    uint16_t weight;           /**< DNS SRV style weig=
ht */
+    uint16_t max_latency_diff; /**< candidate band in ms around the =
fastest server */
+    /** For how many seconds, counted from the moment th=
e client sent its own
+     * probe request, the server will still treat th=
is exchange as the first
+     * two packets of the handshake=2E Within tha=
t window the client may send the
+     * third packet straight away instead=
 of starting a handshake of its own=2E
+     * 0 means it cannot, so it has=
 to begin a fresh one=2E */
+    uint16_t connect_lifetime;
+    uint16_t f=
lags; /**< PROBE_REPLY_FLAG_* */
+};
+
+/* Smallest on-wire value length (t=
he TLV header not counted) of each TLV: the
+ * sizes of the fixed fields a=
bove, in wire order=2E A value may be longer, which
+ * is how the TLVs are=
 extended; trailing bytes that are not understood are
+ * ignored on read=
=2E */
+
+/** request_id (u64), timestamp (u64), flags (u32) */
+#define PR=
OBE_REQUEST_LEN ((uint16_t)(2 * sizeof(uint64_t) + sizeof(uint32_t)))
+
+/*=
* request_id (u64), then priority, weight, max_latency_diff,
+ * connect_li=
fetime and flags (u16 each) */
+#define PROBE_REPLY_LEN ((uint16_t)(sizeof(=
uint64_t) + 5 * sizeof(uint16_t)))
+
+/**
+ * Write a complete probe reques=
t TLV, header and value, to buf=2E
+ *
+ * @return true on success, false i=
f buf has insufficient space=2E
+ */
+bool probe_request_write(struct buffe=
r *buf, const struct probe_request *r);
+
+/**
+ * Read a probe request TLV=
 value from buf=2E
+ *
+ * buf must cover exactly the TLV's value, as ctrl_=
msg_find_tlv() returns it=2E
+ * Bytes beyond the fields understood here ar=
e ignored, so a longer value from
+ * a future version still parses=2E Flag=
 bits that are not known are kept in
+ * flags rather than rejected, for th=
e same reason=2E
+ *
+ * @return true on success, false if buf is shorter t=
han the mandatory fields=2E
+ */
+bool probe_request_read(struct buffer *bu=
f, struct probe_request *r);
+
+/**
+ * Write a complete probe reply TLV, h=
eader and value, to buf=2E
+ *
+ * @return true on success, false if buf ha=
s insufficient space=2E
+ */
+bool probe_reply_write(struct buffer *buf, co=
nst struct probe_reply *r);
+
+/**
+ * Read a probe reply TLV value from bu=
f=2E The calling convention is that of
+ * probe_request_read()=2E
+ *
+ * =
The two flag combinations the protocol rules out are rejected here, since
+=
 * neither can be acted on: a reply must not call the other addresses of th=
e
+ * remote both the same server and distinct ones, and it must not extend=
 the
+ * connect_lifetime to those addresses without first calling them the=
 same
+ * server=2E
+ *
+ * @return true on success, false if buf is shorte=
r than the mandatory fields
+ *         or the flags contradict each other=
=2E
+ */
+bool probe_reply_read(struct buffer *buf, struct probe_reply *r);=

+
+#endif /* ifndef PROBE_H */
diff --git a/src/openvpn/ssl=2Ec b/src/open=
vpn/ssl=2Ec
index e06659a=2E=2Eda87b3f 100644
--- a/src/openvpn/ssl=2Ec
+++=
 b/src/openvpn/ssl=2Ec
@@ -3746,21 +3746,32 @@
 
 /**
  * Does a very coars=
e check on the received opcode=2E It only checks if the
- * opcode is an al=
lowed op code for the peer to send at all, not if this
- * opcode is valid =
for the current state=2E
+ * opcode is one the peer may send on the reliabl=
e control channel at all,
+ * not if this opcode is valid for the current s=
tate=2E
  */
 static bool
 tls_pre_decrypt_verify_opcode(int op, bool serve=
r, const struct link_socket_actual *from)
 {
-    if (op < P_FIRST_OPCODE |=
| op > P_LAST_OPCODE)
+    if (!opcode_is_reliable_control(op))
     {
    =
     if (op =3D=3D P_CONTROL_HARD_RESET_CLIENT_V1 || op =3D=3D P_CONTROL_HA=
RD_RESET_SERVER_V1)
         {
             msg(D_TLS_ERRORS, "Peer tried u=
nsupported key-method 1");
         }
         struct gc_arena gc =3D gc_ne=
w();
-        msg(D_TLS_ERRORS, "TLS Error: unknown opcode received from %s=
 op=3D%d",
-            print_link_socket_actual(from, &gc), op);
+        =
if (op =3D=3D P_CONTROL_V2 || op =3D=3D P_CONTROL_WKC_V2)
+        {
+     =
       /* a defined opcode, just not one this path can parse */
+          =
  msg(D_TLS_ERRORS,
+                "TLS Error: %s received from %s, which=
 is not part of "
+                "the reliable control channel",
+       =
         packet_opcode_name(op), print_link_socket_actual(from, &gc));
+   =
     }
+        else
+        {
+            msg(D_TLS_ERRORS, "TLS Error: =
unknown opcode received from %s op=3D%d",
+                print_link_socke=
t_actual(from, &gc), op);
+        }
         gc_free(&gc);
         return=
 false;
     }
diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=
=2Ec
index dad58c3=2E=2Eb0377f3 100644
--- a/src/openvpn/ssl_pkt=2Ec
+++ b/=
src/openvpn/ssl_pkt=2Ec
@@ -174,7 +174,8 @@
                    bool prepen=
d_ack)
 {
     ASSERT(ks->key_id >=3D 0 && ks->key_id <=3D P_KEY_ID_MASK);
=
-    ASSERT(opcode >=3D 0 && opcode <=3D P_LAST_OPCODE);
+    /* this write=
s the message id and ACK array, which only these opcodes have */
+    ASSER=
T(opcode_is_reliable_control(opcode));
     uint8_t header =3D (uint8_t)(ks=
->key_id | (opcode << P_OPCODE_SHIFT));
 
     /* Workaround for Softether =
servers=2E Softether has a bug that it only
diff --git a/src/openvpn/ssl_pk=
t=2Eh b/src/openvpn/ssl_pkt=2Eh
index 218c6bb=2E=2E3b45492 100644
--- a/src=
/openvpn/ssl_pkt=2Eh
+++ b/src/openvpn/ssl_pkt=2Eh
@@ -58,11 +58,50 @@
  * =
like P_CONTROL_HARD_RESET_CLIENT_V3 */
 #define P_CONTROL_WKC_V1 11
 
-/* d=
efine the range of legal opcodes
- * Since we do no longer support key-meth=
od 1 we consider
- * the v1 op codes invalid */
-#define P_FIRST_OPCODE 3
-=
#define P_LAST_OPCODE  11
+/* Control channel packet carrying a TLV payload=
, e=2Eg=2E a server probe=2E Framed
+ * like P_CONTROL_V1 but without the f=
ields of the reliability layer: a session
+ * id and then the TLVs, with no=
 message id and no ACK array=2E It is wrapped by
+ * tls-auth or tls-crypt =
like any other control channel packet, and with
+ * neither configured it t=
ravels unauthenticated, as they do=2E */
+#define P_CONTROL_V2 12
+
+/* Var=
iant of P_CONTROL_V2 with the wrapped client key appended,
+ * like P_CONTR=
OL_WKC_V1 is to P_CONTROL_V1 */
+#define P_CONTROL_WKC_V2 13
+
+/**
+ * Is =
a packet with opcode op carried by the reliable control channel?
+ *
+ * Th=
ese opcodes are followed by an ACK array and a control message id, which
+ =
* is what the reliable path reads once it is past the session id=2E An opco=
de
+ * that is not one of them has something else there: P_CONTROL_V2 has i=
ts TLVs=2E
+ * Handing such a packet to that path would read the first byte=
s of that
+ * payload as an ACK count and a message id, and ACK or queue wh=
atever it made
+ * of them=2E
+ *
+ * The opcodes are listed rather than bo=
unded by a range, so that defining one
+ * does not silently add it to the =
set=2E Key method 1 is no longer supported, so
+ * its two reset opcodes ar=
e not here, and the data channel opcodes are handled
+ * before this is rea=
ched=2E
+ */
+static inline bool
+opcode_is_reliable_control(int op)
+{
+  =
  switch (op)
+    {
+        case P_CONTROL_SOFT_RESET_V1:
+        case P=
_CONTROL_V1:
+        case P_ACK_V1:
+        case P_CONTROL_HARD_RESET_CLI=
ENT_V2:
+        case P_CONTROL_HARD_RESET_SERVER_V2:
+        case P_CONTR=
OL_HARD_RESET_CLIENT_V3:
+        case P_CONTROL_WKC_V1:
+            retur=
n true;
+
+        default:
+            return false;
+    }
+}
 
 /*
  * =
Define number of buffers for send and receive in the reliability layer=2E
@=
@ -257,6 +296,12 @@
         case P_CONTROL_WKC_V1:
             return "P_=
CONTROL_WKC_V1";
 
+        case P_CONTROL_V2:
+            return "P_CONTR=
OL_V2";
+
+        case P_CONTROL_WKC_V2:
+            return "P_CONTROL_WK=
C_V2";
+
         case P_ACK_V1:
             return "P_ACK_V1";
 
diff --g=
it a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Make=
file=2Eam
index e3404754=2E=2Eb06ae5e 100644
--- a/tests/unit_tests/openvpn=
/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -166,6 +166,=
7 @@
 pkt_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
 pkt_testdriver_SOURCES =3D=
 test_pkt=2Ec \
 	test_control_msg=2Ec test_control_msg=2Eh \
+	test_probe=
=2Ec test_probe=2Eh \
 	mock_msg=2Ec mock_msg=2Eh mock_win32_execve=2Ec \
 =
	test_common=2Eh \
 	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \
@@ -181,=
6 +182,7 @@
 	$(top_srcdir)/src/openvpn/otime=2Ec \
 	$(top_srcdir)/src/ope=
nvpn/packet_id=2Ec \
 	$(top_srcdir)/src/openvpn/platform=2Ec \
+	$(top_src=
dir)/src/openvpn/probe=2Ec \
 	$(top_srcdir)/src/openvpn/reliable=2Ec \
 	$=
(top_srcdir)/src/openvpn/run_command=2Ec \
 	$(top_srcdir)/src/openvpn/sess=
ion_id=2Ec \
diff --git a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/uni=
t_tests/openvpn/test_pkt=2Ec
index f34bd41=2E=2E5609c67 100644
--- a/tests/=
unit_tests/openvpn/test_pkt=2Ec
+++ b/tests/unit_tests/openvpn/test_pkt=2Ec=

@@ -45,6 +45,7 @@
 #include "reliable=2Eh"
 #include "siphash=2Eh"
 #inclu=
de "test_control_msg=2Eh"
+#include "test_probe=2Eh"
 
 int
 parse_line(con=
st char *line, char **p, const int n, const char *file, const int line_num,=

@@ -841,7 +842,21 @@
         cmocka_unit_test(test_tlv_next_walks_payload=
),
         cmocka_unit_test(test_tlv_next_value_truncated),
         cmock=
a_unit_test(test_tlv_header_truncated),
-        cmocka_unit_test(test_tlv_=
write_no_room)
+        cmocka_unit_test(test_tlv_write_no_room),
+        =
cmocka_unit_test(test_probe_request_roundtrip),
+        cmocka_unit_test(t=
est_probe_request_wire_format),
+        cmocka_unit_test(test_probe_reply_=
roundtrip),
+        cmocka_unit_test(test_probe_reply_wire_format),
+     =
   cmocka_unit_test(test_probe_request_forward_compat),
+        cmocka_uni=
t_test(test_probe_request_too_short),
+        cmocka_unit_test(test_probe_=
reply_too_short),
+        cmocka_unit_test(test_probe_reply_flags_contradi=
ct),
+        cmocka_unit_test(test_find_tlv_value_truncated),
+        cmo=
cka_unit_test(test_find_tlv_trailing_bytes),
+        cmocka_unit_test(test=
_find_tlv_skips_optional_after_wanted),
+        cmocka_unit_test(test_find=
_tlv_rejects_unknown_mandatory),
+        cmocka_unit_test(test_find_tlv_re=
jects_duplicate),
+        cmocka_unit_test(test_find_tlv_empty_payload)
  =
   };
 
     return cmocka_run_group_tests_name("pkt tests", tests, NULL, N=
ULL);
diff --git a/tests/unit_tests/openvpn/test_probe=2Ec b/tests/unit_tes=
ts/openvpn/test_probe=2Ec
new file mode 100644
index 0000000=2E=2E967252c
-=
-- /dev/null
+++ b/tests/unit_tests/openvpn/test_probe=2Ec
@@ -0,0 +1,425 @=
@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *    =
         over a single TCP/UDP port, with support for SSL/TLS-based
+ *    =
         session authentication and key exchange,
+ *             packet en=
cryption, packet authentication, and
+ *             packet compression=2E
=
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ * =
 This program is free software; you can redistribute it and/or modify
+ *  =
it under the terms of the GNU General Public License version 2
+ *  as publ=
ished by the Free Software Foundation=2E
+ *
+ *  This program is distribut=
ed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; witho=
ut even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTI=
CULAR PURPOSE=2E  See the
+ *  GNU General Public License for more details=
=2E
+ *
+ *  You should have received a copy of the GNU General Public Lice=
nse along
+ *  with this program; if not, see <https://www=2Egnu=2Eorg/lice=
nses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#i=
nclude "syshead=2Eh"
+
+#include <stdarg=2Eh>
+#include <stddef=2Eh>
+#incl=
ude <setjmp=2Eh>
+#include <cmocka=2Eh>
+
+#include "control_msg=2Eh"
+#inc=
lude "probe=2Eh"
+#include "test_common=2Eh"
+#include "test_probe=2Eh"
+
+=
/* Write a probe request TLV and read it back; the fields must survive the
=
+ * round trip and the whole buffer must be consumed=2E */
+void
+test_prob=
e_request_roundtrip(void **state)
+{
+    struct gc_arena gc =3D gc_new();
=
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    const struct prob=
e_request in =3D {
+        =2Erequest_id =3D 0xdeadbeefcafef00dULL,
+     =
   =2Etimestamp =3D 0x0123456789abcdefULL,
+        =2Eflags =3D PROBE_REQU=
EST_FLAG_PROBE_ONLY,
+    };
+    assert_true(probe_request_write(&buf, &in=
));
+    assert_int_equal(BLEN(&buf), CTRL_MSG_TLV_HEADER_LEN + PROBE_REQUE=
ST_LEN);
+
+    struct ctrl_msg_tlv_header hdr;
+    assert_true(ctrl_msg_t=
lv_peek_header(&buf, &hdr));
+    assert_int_equal(hdr=2Etype, TLV_TYPE_PRO=
BE_REQUEST);
+    assert_false(hdr=2Eoptional);
+    assert_int_equal(hdr=
=2Evalue_len, PROBE_REQUEST_LEN);
+
+    struct buffer value;
+    assert_t=
rue(ctrl_msg_find_tlv(&buf, TLV_TYPE_PROBE_REQUEST, &value));
+    assert_i=
nt_equal(BLEN(&value), PROBE_REQUEST_LEN);
+
+    struct probe_request out =
=3D { 0 };
+    assert_true(probe_request_read(&value, &out));
+    assert_=
true(in=2Erequest_id =3D=3D out=2Erequest_id);
+    assert_true(in=2Etimest=
amp =3D=3D out=2Etimestamp);
+    assert_int_equal(in=2Eflags, out=2Eflags)=
;
+    /* the scan consumed header and value alike */
+    assert_int_equal=
(BLEN(&buf), 0);
+
+    gc_free(&gc);
+}
+
+/* The probe request wire forma=
t is locked to the field order of the spec
+ * (request_id, timestamp, flag=
s), big-endian=2E */
+void
+test_probe_request_wire_format(void **state)
+{=

+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf=
_gc(128, &gc);
+
+    const struct probe_request in =3D {
+        =2Ereque=
st_id =3D 0x1122334455667788ULL,
+        =2Etimestamp =3D 0x01020304050607=
08ULL,
+        =2Eflags =3D 0,
+    };
+    assert_true(probe_request_writ=
e(&buf, &in));
+
+    /* clang-format off */
+    const uint8_t expected[] =
=3D {
+        0x00, 0x02,                                     /* TLV type =
2, not optional */
+        0x00, 0x14,                                    =
 /* TLV value length =3D 20 */
+        0x11, 0x22, 0x33, 0x44, 0x55, 0x66,=
 0x77, 0x88, /* request_id */
+        0x01, 0x02, 0x03, 0x04, 0x05, 0x06, =
0x07, 0x08, /* timestamp */
+        0x00, 0x00, 0x00, 0x00,               =
          /* flags */
+    };
+    /* clang-format on */
+    assert_int_eq=
ual(BLEN(&buf), sizeof(expected));
+    assert_memory_equal(BPTR(&buf), exp=
ected, sizeof(expected));
+
+    gc_free(&gc);
+}
+
+/* Write a probe reply=
 TLV and read it back=2E */
+void
+test_probe_reply_roundtrip(void **state)=

+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_=
buf_gc(128, &gc);
+
+    const struct probe_reply in =3D {
+        =2Erequ=
est_id =3D 0x1122334455667788ULL,
+        =2Epriority =3D 10,
+        =2E=
weight =3D 100,
+        =2Emax_latency_diff =3D 25,
+        =2Econnect_li=
fetime =3D 30,
+        =2Eflags =3D PROBE_REPLY_FLAG_RESEND_WKC,
+    };
+=

+    assert_true(probe_reply_write(&buf, &in));
+    assert_int_equal(BLEN=
(&buf), CTRL_MSG_TLV_HEADER_LEN + PROBE_REPLY_LEN);
+
+    struct ctrl_msg_=
tlv_header hdr;
+    assert_true(ctrl_msg_tlv_peek_header(&buf, &hdr));
+  =
  assert_int_equal(hdr=2Etype, TLV_TYPE_PROBE_REPLY);
+    assert_false(hdr=
=2Eoptional);
+    assert_int_equal(hdr=2Evalue_len, PROBE_REPLY_LEN);
+
+ =
   struct buffer value;
+    assert_true(ctrl_msg_find_tlv(&buf, TLV_TYPE_P=
ROBE_REPLY, &value));
+
+    struct probe_reply out =3D { 0 };
+    assert_=
true(probe_reply_read(&value, &out));
+    assert_true(in=2Erequest_id =3D=
=3D out=2Erequest_id);
+    assert_int_equal(in=2Epriority, out=2Epriority)=
;
+    assert_int_equal(in=2Eweight, out=2Eweight);
+    assert_int_equal(i=
n=2Emax_latency_diff, out=2Emax_latency_diff);
+    assert_int_equal(in=2Ec=
onnect_lifetime, out=2Econnect_lifetime);
+    assert_int_equal(in=2Eflags,=
 out=2Eflags);
+    assert_int_equal(BLEN(&buf), 0);
+
+    gc_free(&gc);
+=
}
+
+/* The probe reply wire format is locked to the field order of the spe=
c
+ * (request_id, priority, weight, max_latency_diff, connect_lifetime, fl=
ags),
+ * big-endian=2E */
+void
+test_probe_reply_wire_format(void **state=
)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc=
_buf_gc(128, &gc);
+
+    const struct probe_reply in =3D {
+        =2Ereq=
uest_id =3D 0x1122334455667788ULL,
+        =2Epriority =3D 10,
+        =
=2Eweight =3D 100,
+        =2Emax_latency_diff =3D 25,
+        =2Econnect=
_lifetime =3D 30,
+        =2Eflags =3D PROBE_REPLY_FLAG_RESEND_WKC,
+    }=
;
+
+    assert_true(probe_reply_write(&buf, &in));
+
+    /* clang-format =
off */
+    const uint8_t expected[] =3D {
+        0x00, 0x03,            =
                         /* TLV type 3, not optional */
+        0x00, 0x12=
,                                     /* TLV value length =3D 18 */
+      =
  0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, /* request_id */
+       =
 0x00, 0x0a,                                     /* priority =3D 10 */
+   =
     0x00, 0x64,                                     /* weight =3D 100 */
+=
        0x00, 0x19,                                     /* max_latency_diff=
 =3D 25 */
+        0x00, 0x1e,                                     /* conn=
ect_lifetime =3D 30 */
+        0x00, 0x01,                                =
     /* flags =3D RESEND_WKC */
+    };
+    /* clang-format on */
+    ass=
ert_int_equal(BLEN(&buf), sizeof(expected));
+    assert_memory_equal(BPTR(=
&buf), expected, sizeof(expected));
+
+    gc_free(&gc);
+}
+
+/* A TLV wit=
h a longer-than-known value must still parse: the known fields are
+ * read=
 and the trailing bytes are skipped=2E Flag bits we do not know are kept
+ =
* rather than rejected, for the same forward compatibility=2E */
+void
+tes=
t_probe_request_forward_compat(void **state)
+{
+    struct gc_arena gc =3D=
 gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    const =
uint16_t extended_len =3D PROBE_REQUEST_LEN + 4;
+    assert_true(ctrl_msg_=
tlv_write_header(&buf, TLV_TYPE_PROBE_REQUEST, false, extended_len));
+    =
assert_true(buf_write_u64(&buf, 7));             /* request_id */
+    asse=
rt_true(buf_write_u64(&buf, 0xdeadbeefULL)); /* timestamp */
+    assert_tr=
ue(buf_write_u32(&buf, 0x80000000));    /* flags, unknown bit set */
+    a=
ssert_true(buf_write_u32(&buf, 0x11223344));    /* unknown trailing field *=
/
+
+    struct buffer value;
+    assert_true(ctrl_msg_find_tlv(&buf, TLV_=
TYPE_PROBE_REQUEST, &value));
+    assert_int_equal(BLEN(&value), extended_=
len);
+
+    struct probe_request out =3D { 0 };
+    assert_true(probe_req=
uest_read(&value, &out));
+    assert_true(out=2Erequest_id =3D=3D 7);
+   =
 assert_true(out=2Etimestamp =3D=3D 0xdeadbeefULL);
+    assert_true(out=2E=
flags =3D=3D 0x80000000);
+    /* the unknown trailing field must have been=
 consumed from the payload */
+    assert_int_equal(BLEN(&buf), 0);
+
+    =
gc_free(&gc);
+}
+
+/* A value shorter than the mandatory fields must be re=
jected, even when it
+ * holds enough bytes for some of the individual fiel=
ds to read successfully=2E */
+void
+test_probe_request_too_short(void **st=
ate)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D al=
loc_buf_gc(128, &gc);
+
+    /* 8 of the 20 mandatory value bytes: enough f=
or the request_id alone */
+    assert_true(buf_write_u64(&buf, 0xdeadbeefU=
LL));
+
+    struct probe_request out =3D { 0 };
+    assert_false(probe_re=
quest_read(&buf, &out));
+
+    gc_free(&gc);
+}
+
+/* The same for the rep=
ly, one u16 short of its 18 mandatory bytes=2E */
+void
+test_probe_reply_t=
oo_short(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct=
 buffer buf =3D alloc_buf_gc(128, &gc);
+
+    assert_true(buf_write_u64(&b=
uf, 1));
+    for (int i =3D 0; i < 4; i++)
+    {
+        assert_true(buf=
_write_u16(&buf, 0));
+    }
+
+    struct probe_reply out =3D { 0 };
+    =
assert_false(probe_reply_read(&buf, &out));
+
+    gc_free(&gc);
+}
+
+/* T=
he flag combinations the protocol rules out must be rejected: the other
+ *=
 addresses of a remote cannot be both the same server and distinct ones, an=
d
+ * a shared connect_lifetime needs them to have been called equal=2E */
=
+void
+test_probe_reply_flags_contradict(void **state)
+{
+    struct gc_ar=
ena gc =3D gc_new();
+    const uint16_t bad[] =3D {
+        PROBE_REPLY_F=
LAG_ADDRS_EQUAL | PROBE_REPLY_FLAG_PROBE_MORE,
+        PROBE_REPLY_FLAG_LI=
FETIME_SHARED,
+        PROBE_REPLY_FLAG_LIFETIME_SHARED | PROBE_REPLY_FLAG=
_PROBE_MORE,
+    };
+    const uint16_t good[] =3D {
+        0,
+        =
PROBE_REPLY_FLAG_ADDRS_EQUAL,
+        PROBE_REPLY_FLAG_PROBE_MORE,
+      =
  PROBE_REPLY_FLAG_ADDRS_EQUAL | PROBE_REPLY_FLAG_LIFETIME_SHARED,
+    };
=
+
+    for (size_t i =3D 0; i < SIZE(bad) + SIZE(good); i++)
+    {
+      =
  const bool expect_ok =3D i >=3D SIZE(bad);
+        const uint16_t flags =
=3D expect_ok ? good[i - SIZE(bad)] : bad[i];
+
+        struct buffer buf =
=3D alloc_buf_gc(128, &gc);
+        const struct probe_reply in =3D { =2Er=
equest_id =3D 1, =2Eflags =3D flags };
+        assert_true(probe_reply_wri=
te(&buf, &in));
+
+        struct buffer value;
+        assert_true(ctrl_m=
sg_find_tlv(&buf, TLV_TYPE_PROBE_REPLY, &value));
+
+        struct probe_r=
eply out =3D { 0 };
+        assert_int_equal(probe_reply_read(&value, &out=
), expect_ok);
+    }
+
+    gc_free(&gc);
+}
+
+/* A TLV header claiming m=
ore value bytes than the payload holds must be
+ * rejected by the scan rat=
her than reported as found -- for the TLV being
+ * looked for as much as f=
or one that would merely be skipped=2E */
+void
+test_find_tlv_value_trunca=
ted(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buff=
er value;
+
+    /* the wanted TLV declares 20 value bytes, only 8 are pres=
ent */
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+    assert_true(=
ctrl_msg_tlv_write_header(&buf, TLV_TYPE_PROBE_REQUEST, false, PROBE_REQUES=
T_LEN));
+    assert_true(buf_write_u64(&buf, 0xdeadbeefULL));
+    assert_=
false(ctrl_msg_find_tlv(&buf, TLV_TYPE_PROBE_REQUEST, &value));
+
+    /* s=
ame defect on a TLV that would be skipped: the scan must not walk past
+   =
  * the end of the payload looking for the next header */
+    struct buffe=
r buf2 =3D alloc_buf_gc(128, &gc);
+    assert_true(ctrl_msg_tlv_write_head=
er(&buf2, 0x7ff, false, 64));
+    assert_true(buf_write_u32(&buf2, 0));
+ =
   assert_false(ctrl_msg_find_tlv(&buf2, TLV_TYPE_PROBE_REQUEST, &value));
=
+
+    gc_free(&gc);
+}
+
+/* Bytes left over after the last TLV that are t=
oo few for a header make the
+ * message malformed, even when the wanted TL=
V was already found=2E */
+void
+test_find_tlv_trailing_bytes(void **state)=

+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer value;
+
+    =
/* 1 to 3 bytes: less than a 4-byte TLV header */
+    for (int trailing =
=3D 1; trailing < CTRL_MSG_TLV_HEADER_LEN; trailing++)
+    {
+        stru=
ct buffer buf =3D alloc_buf_gc(128, &gc);
+        const struct probe_reque=
st in =3D { =2Erequest_id =3D 1, =2Etimestamp =3D 1 };
+        assert_true=
(probe_request_write(&buf, &in));
+        for (int i =3D 0; i < trailing; =
i++)
+        {
+            assert_true(buf_write_u8(&buf, 0));
+        }=

+        assert_false(ctrl_msg_find_tlv(&buf, TLV_TYPE_PROBE_REQUEST, &val=
ue));
+    }
+
+    gc_free(&gc);
+}
+
+/* An unknown TLV marked optional a=
fter the wanted one is skipped, and the
+ * wanted value is still the one r=
eturned=2E */
+void
+test_find_tlv_skips_optional_after_wanted(void **state=
)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc=
_buf_gc(128, &gc);
+    struct buffer value;
+
+    const struct probe_requ=
est in =3D { =2Erequest_id =3D 1, =2Etimestamp =3D 7 };
+    assert_true(pr=
obe_request_write(&buf, &in));
+    assert_true(ctrl_msg_tlv_write_header(&=
buf, 0x7ff, true, 4));
+    assert_true(buf_write_u32(&buf, 0));
+
+    ass=
ert_true(ctrl_msg_find_tlv(&buf, TLV_TYPE_PROBE_REQUEST, &value));
+    ass=
ert_int_equal(BLEN(&value), PROBE_REQUEST_LEN);
+    struct probe_request o=
ut =3D { 0 };
+    assert_true(probe_request_read(&value, &out));
+    asse=
rt_true(out=2Etimestamp =3D=3D 7);
+
+    gc_free(&gc);
+}
+
+/* A TLV we d=
o not know that is not marked optional carries something its
+ * sender req=
uires us to act on, so the scan rejects the message whether that
+ * TLV co=
mes before or after the wanted one=2E */
+void
+test_find_tlv_rejects_unkno=
wn_mandatory(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    st=
ruct buffer value;
+    const struct probe_request in =3D { =2Erequest_id =
=3D 1, =2Etimestamp =3D 7 };
+
+    struct buffer before =3D alloc_buf_gc(1=
28, &gc);
+    assert_true(ctrl_msg_tlv_write_header(&before, 0x7ff, false,=
 4));
+    assert_true(buf_write_u32(&before, 0xcafef00d));
+    assert_tru=
e(probe_request_write(&before, &in));
+
+    struct buffer after =3D alloc_=
buf_gc(128, &gc);
+    assert_true(probe_request_write(&after, &in));
+    =
assert_true(ctrl_msg_tlv_write_header(&after, 0x7ff, false, 4));
+    asser=
t_true(buf_write_u32(&after, 0xcafef00d));
+
+    assert_false(ctrl_msg_fin=
d_tlv(&before, TLV_TYPE_PROBE_REQUEST, &value));
+    assert_false(ctrl_msg=
_find_tlv(&after, TLV_TYPE_PROBE_REQUEST, &value));
+
+    gc_free(&gc);
+}=

+
+/* The wanted TLV may occur only once: a second one rejects the message=
=2E Repeats
+ * of an unknown TLV marked optional are skipped like any othe=
r=2E */
+void
+test_find_tlv_rejects_duplicate(void **state)
+{
+    struct=
 gc_arena gc =3D gc_new();
+    struct buffer value;
+    const struct prob=
e_request in =3D { =2Erequest_id =3D 1 };
+
+    struct buffer buf =3D allo=
c_buf_gc(128, &gc);
+    assert_true(probe_request_write(&buf, &in));
+    =
assert_true(probe_request_write(&buf, &in));
+    assert_false(ctrl_msg_fin=
d_tlv(&buf, TLV_TYPE_PROBE_REQUEST, &value));
+
+    buf =3D alloc_buf_gc(1=
28, &gc);
+    for (int i =3D 0; i < 2; i++)
+    {
+        assert_true(ct=
rl_msg_tlv_write_header(&buf, 0x7ff, true, 4));
+        assert_true(buf_wr=
ite_u32(&buf, 0));
+    }
+    assert_true(probe_request_write(&buf, &in));=

+    assert_true(ctrl_msg_find_tlv(&buf, TLV_TYPE_PROBE_REQUEST, &value));=

+
+    gc_free(&gc);
+}
+
+/* An empty payload holds no TLV=2E */
+void
+t=
est_find_tlv_empty_payload(void **state)
+{
+    struct gc_arena gc =3D gc_=
new();
+    struct buffer buf =3D alloc_buf_gc(16, &gc);
+    struct buffer=
 value;
+
+    assert_false(ctrl_msg_find_tlv(&buf, TLV_TYPE_PROBE_REQUEST,=
 &value));
+
+    gc_free(&gc);
+}
diff --git a/tests/unit_tests/openvpn/te=
st_probe=2Eh b/tests/unit_tests/openvpn/test_probe=2Eh
new file mode 100644=

index 0000000=2E=2E9c4137d
--- /dev/null
+++ b/tests/unit_tests/openvpn/te=
st_probe=2Eh
@@ -0,0 +1,54 @@
+/*
+ *  OpenVPN -- An application to securel=
y tunnel IP networks
+ *             over a single TCP/UDP port, with suppo=
rt for SSL/TLS-based
+ *             session authentication and key exchang=
e,
+ *             packet encryption, packet authentication, and
+ *       =
      packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <s=
ales@openvpn=2Enet>
+ *
+ *  This program is free software; you can redistr=
ibute it and/or modify
+ *  it under the terms of the GNU General Public Li=
cense version 2
+ *  as published by the Free Software Foundation=2E
+ *
+ =
*  This program is distributed in the hope that it will be useful,
+ *  but=
 WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTAB=
ILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Publ=
ic License for more details=2E
+ *
+ *  You should have received a copy of =
the GNU General Public License along
+ *  with this program; if not, see <h=
ttps://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifndef TEST_PROBE_H
+#define =
TEST_PROBE_H
+
+void test_probe_request_roundtrip(void **state);
+
+void te=
st_probe_request_wire_format(void **state);
+
+void test_probe_reply_roundt=
rip(void **state);
+
+void test_probe_reply_wire_format(void **state);
+
+v=
oid test_probe_request_forward_compat(void **state);
+
+void test_probe_req=
uest_too_short(void **state);
+
+void test_probe_reply_too_short(void **sta=
te);
+
+void test_probe_reply_flags_contradict(void **state);
+
+void test_=
find_tlv_value_truncated(void **state);
+
+void test_find_tlv_trailing_byte=
s(void **state);
+
+void test_find_tlv_skips_optional_after_wanted(void **s=
tate);
+
+void test_find_tlv_rejects_unknown_mandatory(void **state);
+
+vo=
id test_find_tlv_rejects_duplicate(void **state);
+
+void test_find_tlv_emp=
ty_payload(void **state);
+
+#endif

-- 
To view, visit https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1741?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

=
Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
Gerrit-Chang=
e-Number: 1741
Gerrit-PatchSet: 28
Gerrit-Owner: Lev Stipakov <lstipakov@gm=
ail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Ra=
lf Lici <ralf@mandelbit=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razva=
nc@mailbox=2Eorg>
Gerrit-Reviewer: chugly <charlie=2Evigue@openvpn=2Ecom>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-At=
tention: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: Lev Stipakov <l=
stipakov@gmail=2Ecom>
Gerrit-Attention: chugly <charlie=2Evigue@openvpn=2Ec=
om>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-A=
ttention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank=
 Lichtenheld <frank@lichtenheld=2Ecom>

--P2zT7ynFOqg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Lev Stipakov, Ralf L=
ici, R=C4=83zvan Cojocaru, chugly=2E </p>
<p>Lev Stipakov <strong>uploaded =
patch set #28</strong> to this change=2E</p><p><a href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1741?usp=3Demail">View Change</a></p><p>The follo=
wing approvals got outdated and were removed:
Code-Review+1 by R=C4=83zvan =
Cojocaru</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">control_msg: Add P_CONTROL_V2 and the probe reque=
st and reply TLVs<br><br>A client probes a server before connecting by send=
ing a P_CONTROL_V2<br>message carrying a probe request TLV, and the server =
answers with a<br>P_CONTROL_V2 carrying a probe reply=2E The reply tells th=
e client how the<br>server wants to be ranked against the other remotes, an=
d can also serve<br>as the second packet of the three-way handshake=2E<br><=
br>Add the two opcodes and the two TLV codecs the probe needs=2E P_CONTROL_=
V2<br>is framed like P_CONTROL_V1 but without the fields of the reliability=
<br>layer: a session id and then the TLVs, with no control message id and n=
o<br>ACK array=2E P_CONTROL_WKC_V2 is the same with the wrapped client key<=
br>appended, as P_CONTROL_WKC_V1 is to P_CONTROL_V1=2E<br><br>The TLVs use =
the shared TLV codec, control_msg=2Ec/h, and their two types<br>join the ot=
hers there=2E The codec gains ctrl_msg_find_tlv(), which scans<br>a payload=
 for the one mandatory TLV of a message=2E The scan is strict: a<br>truncat=
ed TLV header or value, a second TLV of the wanted type, or an<br>unknown T=
LV not marked optional rejects the whole message=2E<br><br>Both readers acc=
ept a value longer than the fields they know and ignore<br>the excess, whic=
h is how the TLVs are meant to be extended=2E The probe<br>reply reader doe=
s reject the two flag combinations the protocol rules<br>out, as neither ca=
n be acted on: the other addresses of a remote cannot<br>be both the same s=
erver and distinct ones, and the connect_lifetime<br>cannot be extended to =
those addresses without first calling them the<br>same server=2E<br><br>The=
 reliable control path no longer decides what it handles from an<br>opcode =
range=2E P_FIRST_OPCODE and P_LAST_OPCODE give way to<br>opcode_is_reliable=
_control(), which lists the opcodes that carry a<br>message id and an ACK a=
rray, and tls_pre_decrypt_verify_opcode() and<br>write_control_auth() test =
that instead=2E Defining an opcode therefore no<br>longer joins it to that =
set, so the two opcodes added here need no<br>carve-out from a range=2E<br>=
<br>No opcode changes hands: the old range covered exactly the seven listed=
,<br>plus the two data channel opcodes, which are handled before the check =
is<br>reached=2E<br><br>The probe is not sent or answered yet; that follows=
=2E<br><br>Change-Id: I1c8d302ac57c5603d622a7be14be369437388268<br>Signed-o=
ff-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M CMakeLists=2Etxt<=
br>M src/openvpn/Makefile=2Eam<br>M src/openvpn/control_msg=2Ec<br>M src/op=
envpn/control_msg=2Eh<br>A src/openvpn/probe=2Ec<br>A src/openvpn/probe=2Eh=
<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_pkt=2Ec<br>M src/openvpn/ssl=
_pkt=2Eh<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>M tests/unit_tests/=
openvpn/test_pkt=2Ec<br>A tests/unit_tests/openvpn/test_probe=2Ec<br>A test=
s/unit_tests/openvpn/test_probe=2Eh<br>13 files changed, 860 insertions(+),=
 12 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/41/1741/28</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeList=
s=2Etxt b/CMakeLists=2Etxt</span><br><span>index 50b2d68=2E=2Ec6dcf65 10064=
4</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=
=2Etxt</span><br><span>@@ -565,6 +565,8 @@</span><br><span>     src/openvpn=
/plugin=2Eh</span><br><span>     src/openvpn/pool=2Ec</span><br><span>     =
src/openvpn/pool=2Eh</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    src/openvpn/probe=2Ec</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    src/openvpn/probe=2Eh</span><br><span>     src/openvpn/proto=2Ec=
</span><br><span>     src/openvpn/proto=2Eh</span><br><span>     src/openvp=
n/proxy=2Ec</span><br><span>@@ -899,7 +901,9 @@</span><br><span>     target=
_sources(test_pkt PRIVATE</span><br><span>         tests/unit_tests/openvpn=
/mock_win32_execve=2Ec</span><br><span>         tests/unit_tests/openvpn/te=
st_control_msg=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       tests/unit_tests/openvpn/test_probe=2Ec</span><br><span>         src=
/openvpn/control_msg=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        src/openvpn/probe=2Ec</span><br><span>         src/openvpn/arg=
v=2Ec</span><br><span>         src/openvpn/base64=2Ec</span><br><span>     =
    src/openvpn/crypto_epoch=2Ec</span><br><span>diff --git a/src/openvpn/M=
akefile=2Eam b/src/openvpn/Makefile=2Eam</span><br><span>index be1044d=2E=
=2E4c8edea 100644</span><br><span>--- a/src/openvpn/Makefile=2Eam</span><br=
><span>+++ b/src/openvpn/Makefile=2Eam</span><br><span>@@ -121,6 +121,7 @@<=
/span><br><span> 	ping=2Ec ping=2Eh \</span><br><span> 	plugin=2Ec plugin=
=2Eh \</span><br><span> 	pool=2Ec pool=2Eh \</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+	probe=2Ec probe=2Eh \</span><br><span> 	proto=2Ec=
 proto=2Eh \</span><br><span> 	proxy=2Ec proxy=2Eh \</span><br><span> 	ps=
=2Ec ps=2Eh \</span><br><span>diff --git a/src/openvpn/control_msg=2Ec b/sr=
c/openvpn/control_msg=2Ec</span><br><span>index e14355c=2E=2Ea77413f 100644=
</span><br><span>--- a/src/openvpn/control_msg=2Ec</span><br><span>+++ b/sr=
c/openvpn/control_msg=2Ec</span><br><span>@@ -91,3 +91,32 @@</span><br><spa=
n>     buf_set_read(value, v, hdr-&gt;value_len);</span><br><span>     retu=
rn true;</span><br><span> }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ctrl_msg_find_tlv(struct b=
uffer *payload, uint16_t wanted_type, struct buffer *value)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    bool found =3D false;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    while (BLEN(payload) &gt; 0)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        struct ctrl_msg_tlv_header hdr;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        struct buffer v;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!ctrl_msg_t=
lv_next(payload, &amp;hdr, &amp;v))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            return false;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        if (hdr=2Etype =3D=3D wanted_type)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            if (found)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                return false; /* the TLV may occur only once */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            *value =3D v;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            found =
=3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else if (!hd=
r=2Eoptional)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            retu=
rn false; /* a mandatory TLV we do not understand, wherever it sits */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    return found;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/src/openvpn/control=
_msg=2Eh b/src/openvpn/control_msg=2Eh</span><br><span>index 92572cb=2E=2E8=
ad5530 100644</span><br><span>--- a/src/openvpn/control_msg=2Eh</span><br><=
span>+++ b/src/openvpn/control_msg=2Eh</span><br><span>@@ -41,6 +41,8 @@</s=
pan><br><span> </span><br><span> /* TLV types */</span><br><span> #define T=
LV_TYPE_EARLY_NEG_FLAGS 0x0001 /* early negotiation, in the reset packets *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define TLV_TYPE_P=
ROBE_REQUEST   0x0002 /* a client probing a server, in P_CONTROL_V2 */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#define TLV_TYPE_PROBE_R=
EPLY     0x0003 /* the server&#39;s answer, in P_CONTROL_V2 */</span><br><s=
pan> </span><br><span> /* A TLV header is a 16-bit type/optional field plus=
 a 16-bit length */</span><br><span> #define CTRL_MSG_TLV_HEADER_LEN 4</spa=
n><br><span>@@ -105,4 +107,28 @@</span><br><span>  */</span><br><span> bool=
 ctrl_msg_tlv_next(struct buffer *buf, struct ctrl_msg_tlv_header *hdr, str=
uct buffer *value);</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * Scan payload for the TLV of type wanted_type, skipping any other TLV t=
ype</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * that is marke=
d optional=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This is for messages=
 that carry exactly one mandatory TLV, which is what the</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * probe messages are=2E Any other TLV=
 that is not marked optional invalidates</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * the message wherever it appears, as does a second T=
LV of wanted_type, so the</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * whole sequence is walked even once the wanted TLV has been found=
=2E A message</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * car=
rying several mandatory TLVs walks them with ctrl_msg_tlv_next() instead=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * On success value covers exactly t=
he found TLV&#39;s value bytes; as in</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * ctrl_msg_tlv_next(), a header claiming more bytes than=
 payload holds is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 rejected rather than reported as found=2E payload is consumed as it is rea=
d=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @param payload      buffer po=
sitioned at a TLV header</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @param wanted_type  the TLV type to look for</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param value        set to a buffer co=
vering the found TLV&#39;s value; it points</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *                     into payload and owns no sto=
rage</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return true=
 if the TLV was found, false if it is absent or present more</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *         than once, if a TLV hea=
der or value is malformed or truncated, or if</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *         a TLV we do not understand is not mark=
ed optional=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool ctrl_msg_find_tl=
v(struct buffer *payload, uint16_t wanted_type, struct buffer *value);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif=
 /* ifndef CONTROL_MSG_H */</span><br><span>diff --git a/src/openvpn/probe=
=2Ec b/src/openvpn/probe=2Ec</span><br><span>new file mode 100644</span><br=
><span>index 0000000=2E=2E2497b07</span><br><span>--- /dev/null</span><br><=
span>+++ b/src/openvpn/probe=2Ec</span><br><span>@@ -0,0 +1,94 @@</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tunn=
el IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   =
          over a single TCP/UDP port, with support for SSL/TLS-based</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *             session aut=
hentication and key exchange,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *             packet encryption, packet authentication, and</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet co=
mpression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2=
026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  This program is free software; you can redistribute it and/or mo=
dify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under th=
e terms of the GNU General Public License version 2</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Software Fou=
ndation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is distri=
buted in the hope that it will be useful,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implie=
d warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  ME=
RCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License fo=
r more details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have=
 received a copy of the GNU General Public License along</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt=
;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_C=
ONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &qu=
ot;config=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#include &quot;probe=2Eh&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;control_msg=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+probe_request_write(struct buffer *buf, c=
onst struct probe_request *r)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retu=
rn ctrl_msg_tlv_write_header(buf, TLV_TYPE_PROBE_REQUEST, false, PROBE_REQU=
EST_LEN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
&amp;&amp; buf_write_u64(buf, r-&gt;request_id) &amp;&amp; buf_write_u64(bu=
f, r-&gt;timestamp)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
           &amp;&amp; buf_write_u32(buf, r-&gt;flags);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bo=
ol</span><br><span style=3D"color: hsl(120, 100%, 40%);">+probe_request_rea=
d(struct buffer *buf, struct probe_request *r)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* One bounds check covers the whole value: every field read b=
elow then fits</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
* by construction, PROBE_REQUEST_LEN being the sum of their sizes, so none<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * of them needs=
 its own error handling=2E Trailing bytes this version does</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+     * not understand are simply le=
ft unread=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (buf_len(buf) &lt; PROBE_REQUEST_LEN)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        return false;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
-&gt;request_id =3D buf_read_u64(buf, NULL);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    r-&gt;timestamp =3D buf_read_u64(buf, NULL);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r-&gt;flags =3D b=
uf_read_u32(buf, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+probe_reply_write(struct buffer *buf, const struct =
probe_reply *r)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ctrl_msg_tl=
v_write_header(buf, TLV_TYPE_PROBE_REPLY, false, PROBE_REPLY_LEN)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; buf_wri=
te_u64(buf, r-&gt;request_id) &amp;&amp; buf_write_u16(buf, r-&gt;priority)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           &amp;&am=
p; buf_write_u16(buf, r-&gt;weight) &amp;&amp; buf_write_u16(buf, r-&gt;max=
_latency_diff)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
      &amp;&amp; buf_write_u16(buf, r-&gt;connect_lifetime) &amp;&amp; buf_=
write_u16(buf, r-&gt;flags);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+probe_reply_read(struct buffer *buf, stru=
ct probe_reply *r)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* One bounds c=
heck for the whole value, as in probe_request_read()=2E */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (buf_len(buf) &lt; PROBE_REPL=
Y_LEN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    r-&gt;request_id =3D buf_read_u64(b=
uf, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r-&gt=
;priority =3D (uint16_t)buf_read_u16(buf);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    r-&gt;weight =3D (uint16_t)buf_read_u16(buf);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    r-&gt;max_latency_=
diff =3D (uint16_t)buf_read_u16(buf);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    r-&gt;connect_lifetime =3D (uint16_t)buf_read_u16(buf=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r-&gt;flags =
=3D (uint16_t)buf_read_u16(buf);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
 The other addresses of the remote cannot be both the same server and</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * distinct ones=2E A=
nd LIFETIME_SHARED extends the connect_lifetime to those</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     * other addresses, which says not=
hing unless ADDRS_EQUAL has declared them</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     * the same server to begin with=2E */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if ((r-&gt;flags &amp; PRO=
BE_REPLY_FLAG_ADDRS_EQUAL) &amp;&amp; (r-&gt;flags &amp; PROBE_REPLY_FLAG_P=
ROBE_MORE))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if ((r-&gt;flags &amp; PROBE_R=
EPLY_FLAG_LIFETIME_SHARED) &amp;&amp; !(r-&gt;flags &amp; PROBE_REPLY_FLAG_=
ADDRS_EQUAL))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/src/=
openvpn/probe=2Eh b/src/openvpn/probe=2Eh</span><br><span>new file mode 100=
644</span><br><span>index 0000000=2E=2E6001774</span><br><span>--- /dev/nul=
l</span><br><span>+++ b/src/openvpn/probe=2Eh</span><br><span>@@ -0,0 +1,14=
1 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to=
 securely tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *             over a single TCP/UDP port, with support for SSL/TL=
S-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *          =
   session authentication and key exchange,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *             packet encryption, packet authentica=
tion, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *        =
     packet compression=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyri=
ght (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  This program is free software; you can redistribut=
e it and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  it under the terms of the GNU General Public License version 2</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free =
Software Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This progr=
am is distributed in the hope that it will be useful,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without eve=
n the implied warranty of</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Publi=
c License for more details=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You=
 should have received a copy of the GNU General Public License along</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if =
not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @file</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * Encoding and decoding of =
the server probe TLVs=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * A client =
probes a server by sending a P_CONTROL_V2 message whose payload</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * carries a probe request TLV,=
 and the server answers with a P_CONTROL_V2</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * message carrying a probe reply TLV=2E The reply =
tells the client how the</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * server wants to be ranked against the other remotes, and can also s=
erve</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * as the secon=
d packet of the three-way handshake=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * The TLV framing and the TLV type space are shared with the other TLV-b=
ased</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * control mess=
ages and live in control_msg=2Eh; this file holds the two probe</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * TLVs and what their fields m=
ean=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#ifndef PROBE_H</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define PROBE_H</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#include &quot;buffer=2Eh&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#include &quot;control_msg=2Eh&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/** probe request flags=2E The client is only probing: it does no=
t want to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * continu=
e into a handshake, and the server may forget it right away=2E */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#define PROBE_REQUEST_FLAG_PR=
OBE_ONLY 0x00000001</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* probe reply flag=
s */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** complete th=
e handshake with P_CONTROL_WKC_V1 rather than P_CONTROL_V1 */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#define PROBE_REPLY_FLAG_RESEND_W=
KC      0x0001</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** t=
he other addresses of this remote are the same server, no need to probe the=
m */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define PROBE_R=
EPLY_FLAG_ADDRS_EQUAL     0x0002</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+/** the connect_lifetime holds against those other addresses t=
oo, so a reply</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * fr=
om one of them can skip the handshake with another=2E Only meaningful</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * together with ADDRS_EQ=
UAL, which is what names those addresses=2E */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#define PROBE_REPLY_FLAG_LIFETIME_SHARED 0x0004<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** the other addres=
ses of this remote are distinct servers, so probe them too */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#define PROBE_REPLY_FLAG_PROBE_MO=
RE      0x0008</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/** probe request TLV, s=
ent by a client to probe a server */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+struct probe_request</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    uint64_t request_id; /**&lt; identifies this probe, echoed in the reply=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** The clie=
nt clock as a UNIX timestamp in seconds=2E It is there for the</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     * server, which uses it to =
bound how old a request it will answer and so</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     * how long a captured one can be replayed=2E=
 The reply does not echo it: a</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     * client times the round trip itself, by the request_id=2E =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t time=
stamp;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t =
flags; /**&lt; PROBE_REQUEST_FLAG_* */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** probe reply T=
LV, a server&#39;s answer to a probe request */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+struct probe_reply</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    uint64_t request_id;       /**&lt; echoes the request_id of th=
e request */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uin=
t16_t priority;         /**&lt; DNS SRV style priority, lower is preferred =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t weig=
ht;           /**&lt; DNS SRV style weight */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    uint16_t max_latency_diff; /**&lt; candidate =
band in ms around the fastest server */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /** For how many seconds, counted from the moment t=
he client sent its own</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * probe request, the server will still treat this exchange as the f=
irst</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * two pack=
ets of the handshake=2E Within that window the client may send the</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+     * third packet straight=
 away instead of starting a handshake of its own=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * 0 means it cannot, so it has to be=
gin a fresh one=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    uint16_t connect_lifetime;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    uint16_t flags; /**&lt; PROBE_REPLY_FLAG_* */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/* Smallest on-wire value length (the TLV header not counted) of eac=
h TLV: the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * sizes =
of the fixed fields above, in wire order=2E A value may be longer, which</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * is how the TLVs are=
 extended; trailing bytes that are not understood are</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * ignored on read=2E */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/** request_id (u64), timestamp (u64), flags (u32) */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define PROBE_REQUEST=
_LEN ((uint16_t)(2 * sizeof(uint64_t) + sizeof(uint32_t)))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/** request_id (u64), then priority, weight, max_latenc=
y_diff,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * connect_l=
ifetime and flags (u16 each) */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#define PROBE_REPLY_LEN ((uint16_t)(sizeof(uint64_t) + 5 * size=
of(uint16_t)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * Write a complete probe request TLV, h=
eader and value, to buf=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return=
 true on success, false if buf has insufficient space=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+bool probe_request_write(struct buffer *buf, const str=
uct probe_request *r);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * Read a probe request TLV valu=
e from buf=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * buf must cover exact=
ly the TLV&#39;s value, as ctrl_msg_find_tlv() returns it=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * Bytes beyond the fields underst=
ood here are ignored, so a longer value from</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * a future version still parses=2E Flag bits that=
 are not known are kept in</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * flags rather than rejected, for the same reason=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @return true on success, false if buf is shorter=
 than the mandatory fields=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool p=
robe_request_read(struct buffer *buf, struct probe_request *r);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * Write a complete probe reply TLV, header and value, to buf=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @return true on success, false if b=
uf has insufficient space=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool pr=
obe_reply_write(struct buffer *buf, const struct probe_reply *r);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * Read a probe reply TLV value from buf=2E The calling conventi=
on is that of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * pro=
be_request_read()=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The two flag =
combinations the protocol rules out are rejected here, since</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * neither can be acted on: a repl=
y must not call the other addresses of the</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * remote both the same server and distinct ones, an=
d it must not extend the</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * connect_lifetime to those addresses without first calling them the =
same</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * server=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @return true on success, false if bu=
f is shorter than the mandatory fields</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *         or the flags contradict each other=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool probe_reply_read(struct buffer *buf,=
 struct probe_reply *r);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifnd=
ef PROBE_H */</span><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvp=
n/ssl=2Ec</span><br><span>index e06659a=2E=2Eda87b3f 100644</span><br><span=
>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span>=
<br><span>@@ -3746,21 +3746,32 @@</span><br><span> </span><br><span> /**</s=
pan><br><span>  * Does a very coarse check on the received opcode=2E It onl=
y checks if the</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * opc=
ode is an allowed op code for the peer to send at all, not if this</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * opcode is valid for the cur=
rent state=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * opc=
ode is one the peer may send on the reliable control channel at all,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * not if this opcode is v=
alid for the current state=2E</span><br><span>  */</span><br><span> static =
bool</span><br><span> tls_pre_decrypt_verify_opcode(int op, bool server, co=
nst struct link_socket_actual *from)</span><br><span> {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if (op &lt; P_FIRST_OPCODE || op &gt;=
 P_LAST_OPCODE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (!opcode_is_reliable_control(op))</span><br><span>     {</span><br><span=
>         if (op =3D=3D P_CONTROL_HARD_RESET_CLIENT_V1 || op =3D=3D P_CONTR=
OL_HARD_RESET_SERVER_V1)</span><br><span>         {</span><br><span>       =
      msg(D_TLS_ERRORS, &quot;Peer tried unsupported key-method 1&quot;);</=
span><br><span>         }</span><br><span>         struct gc_arena gc =3D g=
c_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D=
_TLS_ERRORS, &quot;TLS Error: unknown opcode received from %s op=3D%d&quot;=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            print_li=
nk_socket_actual(from, &amp;gc), op);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (op =3D=3D P_CONTROL_V2 || op =3D=3D P_CONTROL=
_WKC_V2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* a defi=
ned opcode, just not one this path can parse */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            msg(D_TLS_ERRORS,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                &quot;TLS Error: %s r=
eceived from %s, which is not part of &quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                &quot;the reliable control channel=
&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    packet_opcode_name(op), print_link_socket_actual(from, &amp;gc));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            msg(D_TLS_ERRORS, &quot;TLS Error: unkn=
own opcode received from %s op=3D%d&quot;,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                print_link_socket_actual(from, &amp;=
gc), op);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span>         gc_free(&amp;gc);</span><br><span>         return =
false;</span><br><span>     }</span><br><span>diff --git a/src/openvpn/ssl_=
pkt=2Ec b/src/openvpn/ssl_pkt=2Ec</span><br><span>index dad58c3=2E=2Eb0377f=
3 100644</span><br><span>--- a/src/openvpn/ssl_pkt=2Ec</span><br><span>+++ =
b/src/openvpn/ssl_pkt=2Ec</span><br><span>@@ -174,7 +174,8 @@</span><br><sp=
an>                    bool prepend_ack)</span><br><span> {</span><br><span=
>     ASSERT(ks-&gt;key_id &gt;=3D 0 &amp;&amp; ks-&gt;key_id &lt;=3D P_KEY=
_ID_MASK);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(=
opcode &gt;=3D 0 &amp;&amp; opcode &lt;=3D P_LAST_OPCODE);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* this writes the message id an=
d ACK array, which only these opcodes have */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    ASSERT(opcode_is_reliable_control(opcode));</=
span><br><span>     uint8_t header =3D (uint8_t)(ks-&gt;key_id | (opcode &l=
t;&lt; P_OPCODE_SHIFT));</span><br><span> </span><br><span>     /* Workarou=
nd for Softether servers=2E Softether has a bug that it only</span><br><spa=
n>diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh</span><br>=
<span>index 218c6bb=2E=2E3b45492 100644</span><br><span>--- a/src/openvpn/s=
sl_pkt=2Eh</span><br><span>+++ b/src/openvpn/ssl_pkt=2Eh</span><br><span>@@=
 -58,11 +58,50 @@</span><br><span>  * like P_CONTROL_HARD_RESET_CLIENT_V3 *=
/</span><br><span> #define P_CONTROL_WKC_V1 11</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-/* define the range of legal opc=
odes</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Since we do no=
 longer support key-method 1 we consider</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * the v1 op codes invalid */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#define P_FIRST_OPCODE 3</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define P_LAST_OPCODE  11</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/* Control channel packet carrying a =
TLV payload, e=2Eg=2E a server probe=2E Framed</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * like P_CONTROL_V1 but without the fields of t=
he reliability layer: a session</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * id and then the TLVs, with no message id and no ACK array=2E=
 It is wrapped by</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 tls-auth or tls-crypt like any other control channel packet, and with</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * neither configured it=
 travels unauthenticated, as they do=2E */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define P_CONTROL_V2 12</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/* Variant of P_CONTROL_V2 with the wrapped client key appended,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * like P_CONTROL_WKC_=
V1 is to P_CONTROL_V1 */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#define P_CONTROL_WKC_V2 13</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Is a packet with op=
code op carried by the reliable control channel?</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * These opcodes are followed by an ACK array and a control mes=
sage id, which</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * is=
 what the reliable path reads once it is past the session id=2E An opcode</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * that is not one of=
 them has something else there: P_CONTROL_V2 has its TLVs=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * Handing such a packet to that p=
ath would read the first bytes of that</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * payload as an ACK count and a message id, and ACK or =
queue whatever it made</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * of them=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The opcodes are l=
isted rather than bounded by a range, so that defining one</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * does not silently add it to the s=
et=2E Key method 1 is no longer supported, so</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * its two reset opcodes are not here, and the da=
ta channel opcodes are handled</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * before this is reached=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+static inline bool</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+opcode_is_reliable_control(int op)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    switch (op)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case P_CON=
TROL_SOFT_RESET_V1:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        case P_CONTROL_V1:</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        case P_ACK_V1:</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        case P_CONTROL_HARD_RESET_CLIENT_V2:</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        case P_CONTROL_HARD_RESET_SERVER=
_V2:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case P_=
CONTROL_HARD_RESET_CLIENT_V3:</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        case P_CONTROL_WKC_V1:</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            return true;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        default:</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            return false;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span> </span><br><span> /*</span><br><span>  * Define number of bu=
ffers for send and receive in the reliability layer=2E</span><br><span>@@ -=
257,6 +296,12 @@</span><br><span>         case P_CONTROL_WKC_V1:</span><br>=
<span>             return &quot;P_CONTROL_WKC_V1&quot;;</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case P_CONTRO=
L_V2:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            re=
turn &quot;P_CONTROL_V2&quot;;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
case P_CONTROL_WKC_V2:</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            return &quot;P_CONTROL_WKC_V2&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         case P_ACK_V1:<=
/span><br><span>             return &quot;P_ACK_V1&quot;;</span><br><span> =
</span><br><span>diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/test=
s/unit_tests/openvpn/Makefile=2Eam</span><br><span>index e3404754=2E=2Eb06a=
e5e 100644</span><br><span>--- a/tests/unit_tests/openvpn/Makefile=2Eam</sp=
an><br><span>+++ b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>@=
@ -166,6 +166,7 @@</span><br><span> pkt_testdriver_LDFLAGS =3D @TEST_LDFLAG=
S@</span><br><span> pkt_testdriver_SOURCES =3D test_pkt=2Ec \</span><br><sp=
an> 	test_control_msg=2Ec test_control_msg=2Eh \</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+	test_probe=2Ec test_probe=2Eh \</span><br><sp=
an> 	mock_msg=2Ec mock_msg=2Eh mock_win32_execve=2Ec \</span><br><span> 	te=
st_common=2Eh \</span><br><span> 	$(top_srcdir)/src/compat/compat-strlcpy=
=2Ec \</span><br><span>@@ -181,6 +182,7 @@</span><br><span> 	$(top_srcdir)/=
src/openvpn/otime=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/packet_=
id=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/platform=2Ec \</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/=
probe=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/reliable=2Ec \</spa=
n><br><span> 	$(top_srcdir)/src/openvpn/run_command=2Ec \</span><br><span> =
	$(top_srcdir)/src/openvpn/session_id=2Ec \</span><br><span>diff --git a/te=
sts/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec=
</span><br><span>index f34bd41=2E=2E5609c67 100644</span><br><span>--- a/te=
sts/unit_tests/openvpn/test_pkt=2Ec</span><br><span>+++ b/tests/unit_tests/=
openvpn/test_pkt=2Ec</span><br><span>@@ -45,6 +45,7 @@</span><br><span> #in=
clude &quot;reliable=2Eh&quot;</span><br><span> #include &quot;siphash=2Eh&=
quot;</span><br><span> #include &quot;test_control_msg=2Eh&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_probe=2Eh&=
quot;</span><br><span> </span><br><span> int</span><br><span> parse_line(co=
nst char *line, char **p, const int n, const char *file, const int line_num=
,</span><br><span>@@ -841,7 +842,21 @@</span><br><span>         cmocka_unit=
_test(test_tlv_next_walks_payload),</span><br><span>         cmocka_unit_te=
st(test_tlv_next_value_truncated),</span><br><span>         cmocka_unit_tes=
t(test_tlv_header_truncated),</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        cmocka_unit_test(test_tlv_write_no_room)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_tlv_writ=
e_no_room),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
cmocka_unit_test(test_probe_request_roundtrip),</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_probe_request_wir=
e_format),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c=
mocka_unit_test(test_probe_reply_roundtrip),</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_probe_reply_wire_for=
mat),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka=
_unit_test(test_probe_request_forward_compat),</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_probe_request_too_=
short),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmoc=
ka_unit_test(test_probe_reply_too_short),</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        cmocka_unit_test(test_probe_reply_flags_contr=
adict),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmoc=
ka_unit_test(test_find_tlv_value_truncated),</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_find_tlv_trailing_by=
tes),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka=
_unit_test(test_find_tlv_skips_optional_after_wanted),</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_find_tlv_r=
ejects_unknown_mandatory),</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        cmocka_unit_test(test_find_tlv_rejects_duplicate),</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test=
_find_tlv_empty_payload)</span><br><span>     };</span><br><span> </span><b=
r><span>     return cmocka_run_group_tests_name(&quot;pkt tests&quot;, test=
s, NULL, NULL);</span><br><span>diff --git a/tests/unit_tests/openvpn/test_=
probe=2Ec b/tests/unit_tests/openvpn/test_probe=2Ec</span><br><span>new fil=
e mode 100644</span><br><span>index 0000000=2E=2E967252c</span><br><span>--=
- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/test_probe=2Ec</=
span><br><span>@@ -0,0 +1,425 @@</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
OpenVPN -- An application to securely tunnel IP networks</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP p=
ort, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *             session authentication and key exchange,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet e=
ncryption, packet authentication, and</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *             packet compression=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=
=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free s=
oftware; you can redistribute it and/or modify</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General Public=
 License version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  as published by the Free Software Foundation=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  This program is distributed in the hope that it will be u=
seful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHO=
UT ANY WARRANTY; without even the implied warranty of</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PART=
ICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  GNU General Public License for more details=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  You should have received a copy of the GNU General=
 Public License along</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&=
gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &quot;syshead=2Eh&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#include &lt;stdarg=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#include &lt;stddef=2Eh&gt;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &lt;setjmp=2Eh&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &lt;cmocka=2Eh&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &quot;control_msg=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;probe=2Eh&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_common=2Eh=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quo=
t;test_probe=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Write a probe=
 request TLV and read it back; the fields must survive the</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * round trip and the whole buffer m=
ust be consumed=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_probe_re=
quest_roundtrip(void **state)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    const struct probe_request in =3D {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        =2Erequest_id =3D 0xdea=
dbeefcafef00dULL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      =2Etimestamp =3D 0x0123456789abcdefULL,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        =2Eflags =3D PROBE_REQUEST_FLAG_PROBE_ONL=
Y,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(probe_request_=
write(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_int_equal(BLEN(&amp;buf), CTRL_MSG_TLV_HEADER_LEN + PROBE=
_REQUEST_LEN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ctrl_msg_tlv_=
header hdr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_true(ctrl_msg_tlv_peek_header(&amp;buf, &amp;hdr));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(hdr=2Etype, TLV_TYP=
E_PROBE_REQUEST);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_false(hdr=2Eoptional);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_int_equal(hdr=2Evalue_len, PROBE_REQUEST_LEN);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct buffer value;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_find_tlv(&amp;=
buf, TLV_TYPE_PROBE_REQUEST, &amp;value));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;value), PROBE_REQUEST=
_LEN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct probe_request out =3D=
 { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_t=
rue(probe_request_read(&amp;value, &amp;out));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_true(in=2Erequest_id =3D=3D out=2Ereq=
uest_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_true(in=2Etimestamp =3D=3D out=2Etimestamp);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_int_equal(in=2Eflags, out=2Eflags);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* the scan consum=
ed header and value alike */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_int_equal(BLEN(&amp;buf), 0);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/* The probe request wir=
e format is locked to the field order of the spec</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * (request_id, timestamp, flags), big-endian=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+test_probe_request_wire_form=
at(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena g=
c =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const struct probe_request in =3D {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        =2Erequest_id =3D 0x1122334455667788=
ULL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Etime=
stamp =3D 0x0102030405060708ULL,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        =2Eflags =3D 0,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_true(probe_request_write(&amp;buf, &amp;in));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* clang-format off */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    const uint8_t expected[] =3D {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        0x00, 0x02,            =
                         /* TLV type 2, not optional */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        0x00, 0x14,                    =
                 /* TLV value length =3D 20 */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77=
, 0x88, /* request_id */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, /* timestamp *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        0x00, 0x00=
, 0x00, 0x00,                         /* flags */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* clang-format on */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;buf), sizeof(expected=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memor=
y_equal(BPTR(&amp;buf), expected, sizeof(expected));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Write a probe rep=
ly TLV and read it back=2E */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_=
probe_reply_roundtrip(void **state)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    const struct probe_reply in =3D {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Erequest_id =3D 0=
x1122334455667788ULL,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        =2Epriority =3D 10,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        =2Eweight =3D 100,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        =2Emax_latency_diff =3D 25,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        =2Econnect_lifetime =3D 30,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Eflags =3D PROB=
E_REPLY_FLAG_RESEND_WKC,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(probe_reply=
_write(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_int_equal(BLEN(&amp;buf), CTRL_MSG_TLV_HEADER_LEN + PROB=
E_REPLY_LEN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ctrl_msg_tlv_h=
eader hdr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_true(ctrl_msg_tlv_peek_header(&amp;buf, &amp;hdr));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(hdr=2Etype, TLV_TYPE=
_PROBE_REPLY);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_false(hdr=2Eoptional);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_int_equal(hdr=2Evalue_len, PROBE_REPLY_LEN);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct buffer value;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_find_tlv(&amp;buf, =
TLV_TYPE_PROBE_REPLY, &amp;value));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct probe_reply out =3D { 0 };</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_true(probe_reply_read(&amp;value, &amp;out));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(in=2Ere=
quest_id =3D=3D out=2Erequest_id);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_int_equal(in=2Epriority, out=2Epriority);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(in=2Ew=
eight, out=2Eweight);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_int_equal(in=2Emax_latency_diff, out=2Emax_latency_diff);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(in=
=2Econnect_lifetime, out=2Econnect_lifetime);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_int_equal(in=2Eflags, out=2Eflags);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(B=
LEN(&amp;buf), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/* The probe reply wire format is locked to the field o=
rder of the spec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
(request_id, priority, weight, max_latency_diff, connect_lifetime, flags),<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * big-endian=2E */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+test_probe_reply_wire_format(void *=
*state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_=
new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct bu=
ffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    const struct probe_reply in =3D {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        =2Erequest_id =3D 0x1122334455667788ULL,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Epriority =3D 10=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Eweight =
=3D 100,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2E=
max_latency_diff =3D 25,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        =2Econnect_lifetime =3D 30,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        =2Eflags =3D PROBE_REPLY_FLAG_RESEND_WKC,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_true(probe_reply_write(&amp;buf, &amp;in));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* clang-format off */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t expected[] =3D =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        0x00, 0x03=
,                                     /* TLV type 3, not optional */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        0x00, 0x12,       =
                              /* TLV value length =3D 18 */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        0x11, 0x22, 0x33, 0x44, 0x5=
5, 0x66, 0x77, 0x88, /* request_id */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        0x00, 0x0a,                                     /=
* priority =3D 10 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        0x00, 0x64,                                     /* weight =3D 100 =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        0x00, 0x1=
9,                                     /* max_latency_diff =3D 25 */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        0x00, 0x1e,       =
                              /* connect_lifetime =3D 30 */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        0x00, 0x01,                =
                     /* flags =3D RESEND_WKC */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* clang-format on */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;buf), sizeof(expected))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_=
equal(BPTR(&amp;buf), expected, sizeof(expected));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A TLV with a longer-=
than-known value must still parse: the known fields are</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * read and the trailing bytes are skip=
ped=2E Flag bits we do not know are kept</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * rather than rejected, for the same forward compatib=
ility=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+test_probe_request_forw=
ard_compat(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc=
_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const uint16_t extended_len =3D PROBE_REQUEST_LEN + =
4;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(c=
trl_msg_tlv_write_header(&amp;buf, TLV_TYPE_PROBE_REQUEST, false, extended_=
len));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tr=
ue(buf_write_u64(&amp;buf, 7));             /* request_id */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u64(&amp=
;buf, 0xdeadbeefULL)); /* timestamp */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;buf, 0x80000000));   =
 /* flags, unknown bit set */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_true(buf_write_u32(&amp;buf, 0x11223344));    /* unkno=
wn trailing field */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer =
value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tr=
ue(ctrl_msg_find_tlv(&amp;buf, TLV_TYPE_PROBE_REQUEST, &amp;value));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(=
&amp;value), extended_len);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
probe_request out =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_true(probe_request_read(&amp;value, &amp;out));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(out=2Ereque=
st_id =3D=3D 7);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_true(out=2Etimestamp =3D=3D 0xdeadbeefULL);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(out=2Eflags =3D=3D 0x8000=
0000);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* the un=
known trailing field must have been consumed from the payload */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp=
;buf), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/* A value shorter than the mandatory fields must be rejected, =
even when it</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * hold=
s enough bytes for some of the individual fields to read successfully=2E */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+test_probe_request_too_short(void =
**state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc=
_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct b=
uffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* 8 of the 20 mandatory value bytes: enough for the request_id alon=
e */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true=
(buf_write_u64(&amp;buf, 0xdeadbeefULL));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct probe_request out =3D { 0 };</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_false(probe_request_read(&amp;buf, &amp;o=
ut));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/* The same for the reply, one u16 short of its 18 mandatory bytes=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+test_probe_reply_too_short(v=
oid **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =
=3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_true(buf_write_u64(&amp;buf, 1));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; 4; i++)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        assert_true(buf_write_u16(&amp=
;buf, 0));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct probe_reply out =3D { 0 };</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(probe_=
reply_read(&amp;buf, &amp;out));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc=
_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* The flag combinations the protocol rul=
es out must be rejected: the other</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * addresses of a remote cannot be both the same server and =
distinct ones, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* a shared connect_lifetime needs them to have been called equal=2E */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+test_probe_reply_flags_contradict(void =
**state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc=
_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const ui=
nt16_t bad[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       PROBE_REPLY_FLAG_ADDRS_EQUAL | PROBE_REPLY_FLAG_PROBE_MORE,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        PROBE_REPLY_FLAG_LIF=
ETIME_SHARED,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  PROBE_REPLY_FLAG_LIFETIME_SHARED | PROBE_REPLY_FLAG_PROBE_MORE,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const uint16_t good[] =3D {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        0,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        PROBE_REPLY_FLAG_ADDRS_EQUAL,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        PROBE_REPLY_=
FLAG_PROBE_MORE,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     PROBE_REPLY_FLAG_ADDRS_EQUAL | PROBE_REPLY_FLAG_LIFETIME_SHARED,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    for (size_t i =3D 0; i &lt; SIZE(bad) + SIZE(good); i=
++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        const bool expect_ok =
=3D i &gt;=3D SIZE(bad);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        const uint16_t flags =3D expect_ok ? good[i - SIZE(bad)] : bad=
[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        struct buffer buf =3D allo=
c_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        const struct probe_reply in =3D { =2Erequest_id =3D 1, =2Eflags=
 =3D flags };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  assert_true(probe_reply_write(&amp;buf, &amp;in));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        struct buffer value;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        assert_true(ctrl_msg_find_tlv(&amp;buf, TLV=
_TYPE_PROBE_REPLY, &amp;value));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  struct probe_reply out =3D { 0 };</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        assert_int_equal(probe_reply_read(&amp;value, &amp;=
out), expect_ok);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/* A TLV header claiming more value bytes than the payload holds must =
be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * rejected by th=
e scan rather than reported as found -- for the TLV being</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * looked for as much as for one that=
 would merely be skipped=2E */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test=
_find_tlv_value_truncated(void **state)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct buffer value;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /* the wanted TLV declares 20 value bytes, only 8 are present */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf=
 =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;buf, TLV_TYPE_P=
ROBE_REQUEST, false, PROBE_REQUEST_LEN));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_true(buf_write_u64(&amp;buf, 0xdeadbeefULL=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false=
(ctrl_msg_find_tlv(&amp;buf, TLV_TYPE_PROBE_REQUEST, &amp;value));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* same defect on a TLV that would be skipp=
ed: the scan must not walk past</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+     * the end of the payload looking for the next header */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf2=
 =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;buf2, 0x7ff, fa=
lse, 64));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_true(buf_write_u32(&amp;buf2, 0));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_false(ctrl_msg_find_tlv(&amp;buf2, TLV_TYPE_PRO=
BE_REQUEST, &amp;value));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&=
amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/* Bytes left over after the last TLV that are t=
oo few for a header make the</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * message malformed, even when the wanted TLV was already found=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+test_find_tlv_trailing_bytes=
(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =
=3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct buffer value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* 1 to 3 bytes:=
 less than a 4-byte TLV header */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    for (int trailing =3D 1; trailing &lt; CTRL_MSG_TLV_HEADE=
R_LEN; trailing++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct =
buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        const struct probe_request in =3D { =2Ereque=
st_id =3D 1, =2Etimestamp =3D 1 };</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        assert_true(probe_request_write(&amp;buf, &amp;in));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (int i =
=3D 0; i &lt; trailing; i++)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           assert_true(buf_write_u8(&amp;buf, 0));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        assert_false(ctrl_msg_find_tlv(&amp;buf, TLV_T=
YPE_PROBE_REQUEST, &amp;value));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/* An unknown TLV marked optional after the wanted one =
is skipped, and the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * wanted value is still the one returned=2E */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+test_find_tlv_skips_optional_after_wanted(void **state)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D a=
lloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct buffer value;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st struct probe_request in =3D { =2Erequest_id =3D 1, =2Etimestamp =3D 7 };=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(pro=
be_request_write(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;buf, 0x7ff=
, true, 4));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_true(buf_write_u32(&amp;buf, 0));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_true(ctrl_msg_find_tlv(&amp;buf, TLV_TYPE_PROBE_REQUEST, &amp;val=
ue));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int=
_equal(BLEN(&amp;value), PROBE_REQUEST_LEN);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct probe_request out =3D { 0 };</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(probe_request_=
read(&amp;value, &amp;out));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_true(out=2Etimestamp =3D=3D 7);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A TLV we do not k=
now that is not marked optional carries something its</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * sender requires us to act on, so the s=
can rejects the message whether that</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * TLV comes before or after the wanted one=2E */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+test_find_tlv_rejects_unknown_mandatory(v=
oid **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =
=3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct buffer value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   const struct probe_request in =3D { =2Erequest_id =3D 1, =2Etimestamp =
=3D 7 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer before =3D a=
lloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;before, 0x7ff, false,=
 4));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tru=
e(buf_write_u32(&amp;before, 0xcafef00d));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_true(probe_request_write(&amp;before, &am=
p;in));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer after =3D all=
oc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_true(probe_request_write(&amp;after, &amp;in));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_wr=
ite_header(&amp;after, 0x7ff, false, 4));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;after, 0xcafef00d)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_false(ctrl_msg_find_tlv(&=
amp;before, TLV_TYPE_PROBE_REQUEST, &amp;value));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_false(ctrl_msg_find_tlv(&amp;after=
, TLV_TYPE_PROBE_REQUEST, &amp;value));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/* The wanted TLV may occur only o=
nce: a second one rejects the message=2E Repeats</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * of an unknown TLV marked optional are skipp=
ed like any other=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_find_t=
lv_rejects_duplicate(void **state)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    struct buffer value;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const struct probe_request in =3D { =2Erequest_id =
=3D 1 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D allo=
c_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_true(probe_request_write(&amp;buf, &amp;in));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_true(probe_request_writ=
e(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_false(ctrl_msg_find_tlv(&amp;buf, TLV_TYPE_PROBE_REQUEST, &am=
p;value));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    buf =3D alloc_buf_gc(128=
, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for =
(int i =3D 0; i &lt; 2; i++)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   assert_true(ctrl_msg_tlv_write_header(&amp;buf, 0x7ff, true, 4));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_true(buf_wr=
ite_u32(&amp;buf, 0));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
true(probe_request_write(&amp;buf, &amp;in));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_find_tlv(&amp;buf, TLV_T=
YPE_PROBE_REQUEST, &amp;value));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc=
_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* An empty payload holds no TLV=2E */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+test_find_tlv_empty_payload(void **st=
ate)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new=
();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffe=
r buf =3D alloc_buf_gc(16, &amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct buffer value;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_false(ctrl_msg_find_tlv(&amp;buf, TLV_TYPE_PROBE_REQUEST, &am=
p;value));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --g=
it a/tests/unit_tests/openvpn/test_probe=2Eh b/tests/unit_tests/openvpn/tes=
t_probe=2Eh</span><br><span>new file mode 100644</span><br><span>index 0000=
000=2E=2E9c4137d</span><br><span>--- /dev/null</span><br><span>+++ b/tests/=
unit_tests/openvpn/test_probe=2Eh</span><br><span>@@ -0,0 +1,54 @@</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tun=
nel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
           over a single TCP/UDP port, with support for SSL/TLS-based</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             session au=
thentication and key exchange,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *             packet encryption, packet authentication, and</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet c=
ompression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-=
2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  This program is free software; you can redistribute it and/or m=
odify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under t=
he terms of the GNU General Public License version 2</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Software Fou=
ndation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is distri=
buted in the hope that it will be useful,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implie=
d warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  ME=
RCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License fo=
r more details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have=
 received a copy of the GNU General Public License along</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt=
;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef TEST_=
PROBE_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define TEST=
_PROBE_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+void test_probe_request_roundt=
rip(void **state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+void test_probe_requ=
est_wire_format(void **state);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void tes=
t_probe_reply_roundtrip(void **state);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
void test_probe_reply_wire_format(void **state);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+void test_probe_request_forward_compat(void **state);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+void test_probe_request_too_short(void **state);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+void test_probe_reply_too_short(void **s=
tate);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+void test_probe_reply_flags_cont=
radict(void **state);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void test_find_tl=
v_value_truncated(void **state);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void t=
est_find_tlv_trailing_bytes(void **state);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+void test_find_tlv_skips_optional_after_wanted(void **state);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+void test_find_tlv_rejects_unknown_mandatory(voi=
d **state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+void test_find_tlv_rejects_=
duplicate(void **state);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void test_find=
_tlv_empty_payload(void **state);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endi=
f</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1741?usp=3Demail">change 1741</a>=2E To unsubscribe, or for =
help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://=
schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail"/><meta itemprop=3D"name" co=
ntent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Me=
ssageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: =
openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be3=
69437388268 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1741 =
</div>
<div style=3D"display:none"> Gerrit-PatchSet: 28 </div>
<div style=
=3D"display:none"> Gerrit-Owner: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;=
razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2E=
net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Ralf Lici &lt=
;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt=
;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2E=
com&gt; </div>

</body></html>
--P2zT7ynFOqg=--


--===============2291070971074918713==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2291070971074918713==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2291070971074918713==--

