Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17319C54FD2
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 12:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mw4R3nVLmwjM7XIhX5IUBBUjF83ZQi6B27Z8P2DoKM8=; b=YZpCtg4CvO/idNDpFsQtE96c2G
	SxBVTarGWGOChqhT83BLtcL9J+1YLS+kIQY0jnAwlb+kdYGaa7m7cRTzywkYm7FPP7EzDmNTsDVl5
	gAxyXxf82qeWJL6HomJN2maRaS7AmYNG8nZAIfkZJ5INV5sDbTcRvHIqVXTHE7ft1XoQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wp3Jt-0003ZO-KC;
	Wed, 29 Jul 2026 12:23:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wp3Jr-0003Z6-0a
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 12:23:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=DZRPuibrOJDzBmFF/9gMbz3djbhvWGzD6Hi9Al9iS9E=; b=I1f3kkPygWt9GrukGI5FVvOIul
 xnuYQjJqOH20zjHScrAeR2R5GvOYCRXuWy5iXL6Q4sjRKdWgtfNX2b87PaMqTlr/YJYH2pz6WWT+p
 XbNMZ60yBnDoMLuRUOlygrSkluHxrGD8Hqjw5b1EomlVsBrkg7I+2+MefFkvaJLbS3Ko=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=DZRPuibrOJDzBmFF/9gMbz3djbhvWGzD6Hi9Al9iS9E=; b=m
 +14fk0DWl9Hse32EMsmtd0YqwC5yX+kpCOPnMybZw+zSzl6k9XR4ms6YNomtiZdFonTD3/jkHaa3G
 Ki/G2DzNQfUh10gNMDZmaE1ZqGvXaExzMKKOsVPZSgvudXmfkb52bILgH65Fe90Pimo10rrB2liqA
 kNUVAQj2Qtuboihk=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wp3Jj-0006O7-OI for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 12:23:28 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-47f97d310caso850157f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 29 Jul 2026 05:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785327797; x=1785932597; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DZRPuibrOJDzBmFF/9gMbz3djbhvWGzD6Hi9Al9iS9E=;
 b=IJhUG5uJtuIOPWOHKiYy5/q7jKGhS3vROZrjyotM3eRK5d+1ecA60PcnhSSpIFQW0Z
 VDuGKK64H5aSRQVQhiNGFpZOgxL6Tww6YjLA+wBVmWfMalEllnmX1wmZbNN04ml9cLfT
 HpbCfsvW6t9ZpBAclu+mpz9xvjHmHUQmeJYuM4d6WkxzgYun/fvbfoZ8V1iou4auq7Vt
 3+FHSrCWxaycgr04U7lUtHb/6kNl9xFrLboq/gOIBfojbOUGq9ySRAcM3oisHXxTj6d0
 dni0ztGZjKIGzWm1q8n+FapRh1P6PlBQGHD3mlobOvvVO4X16vcSYzhUN0dIxY38AgEV
 aBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785327797; x=1785932597;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=DZRPuibrOJDzBmFF/9gMbz3djbhvWGzD6Hi9Al9iS9E=;
 b=Xbk9XeEEf8R9unM+zori9GPMcTqvnAUDi2bB1/CzY0GU/VhMQKjOR9I/bqTNoaHcr/
 EesSmNSzekWFm7GkiZXi60aYjASFEJOA19CSFjgh0BphE19PMAjGoNcKHZK322GBeHvM
 au0CVrsLIkXnaIcRdZzHuRPqmDq/nIHYGazCBvKTNzeMYKZXHMtlzrjY3+9fB4kCbGvp
 wyWtuWRbYbp/7gB8CLYnkXjbEOVhjl9qzqaGO7LePPjTyDgIFhAM9o+gb9hMNj4vK0xt
 YUN5GgcoLrNt5Gm2H49gb0kR60P2QhIvPEXp2+ONQD6RS4WD8l5jOIi7ubigwV+wbTqb
 UJqg==
X-Gm-Message-State: AOJu0YwSroNRhtQ0Iza+EqV/Grm1eqvaBa3f72LMj/KEECg8IHHhnOGQ
 MwBsUk5K3BLEQm09BLiEyiu2rz+qW7C3QaLrmSfJrsM0qZSgU+8gti/fvV0XQizz1UP4liO/SeI
 LmJcUEZ0mMQDHShvwc1/A3MaOEinKl/iHOzbKgjD/lltGL/HtmXgnfKzrOPVyoFHs3kLNkVpbjx
 w8yYzQ8g==
X-Gm-Gg: AR+sD10PvKw3QrdgqJYHZvsGW0ofRMB7TTXXtnIUjViatIykZKfX+bKjZQfLW19c/vu
 6xpvi1rxolbVY7/0zMmXPufkb7rrP5ZDfJFd3/w+FRaSYsuQanWWSNNKsoPM0hEZyXOgyZ24BN6
 4KLUYT84Z2JEE4z//eprRzA6y3b0BVNCU+nIbegwOWg241/aLWlsdj4dWX+ADLUv6iPDy1sWLx1
 PzYTvIlg9l9O2x8ZXlq5oJ1mZwd/etP5zfT4U+uOLnPUN0KTFo25m7hVVUuGya9hwwhZ/fXCYAA
 7xKkERyOnAuxSdEUoncd/IrbvXg71IXaJZfrKY3Xsma420dgJVhYlTrNPgiPXaeZutlII0VHbww
 MincBzlMyOwYF+8yrfxdy8Vd1icWk5px06f84LauDo/qyh3JmAE9UZTqRkndarDowrhNISMV6uV
 Y0yn81PAmfF4fKNt+CSzcnHFxJBCrWcGo4j1At4HHK7WIzYVjSqGIoR9gaVREifM+j7GyxV8gsl
 fnRda6R4+1hMBuxqFQY2t/qSyi1y7Jx3TyGVlOc2+UERbe3JNjK2FvZz7poS1WNNuPIBAiKwn90
 gK4FOBO3+dE3D7ggeo65DkYMMtFXmslNS46f+l2JoBCU1bOc+Pk=
X-Received: by 2002:a05:6000:26c3:b0:47f:83ee:e56f with SMTP id
 ffacd0b85a97d-47fb1e927e0mr7771463f8f.18.1785327796634; 
 Wed, 29 Jul 2026 05:23:16 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6aa3940sm7970732f8f.7.2026.07.29.05.23.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 05:23:16 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 29 Jul 2026 12:22:54 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 14
X-Gerrit-Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2
X-Gerrit-Change-Number: 1747
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1747?usp=email>
X-Gerrit-Commit: 1876e81cb28fde69faef28b9f71bcc89002b1471
In-Reply-To: <gerrit.1782719911000.I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2@gerrit.openvpn.net>
References: <gerrit.1782719911000.I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk1YTdlOWUxM2I5Zjk1NDhiN2ZmNzE3ZGFhZTJiNGE5Y2RlM2MwNmYyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <963558b9b47b3d8bd7add50841227900ae917ad9-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wp3Jj-0006O7-OI
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8191409036035243238=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8191409036035243238==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7wRBsTd8KqU="; charset=UTF-8

--7wRBsTd8KqU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1747?usp=3Demail

to look at the new patch set (#14)=2E
=


Change subject: oob: Add --server-probe to order client remotes by probe
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Add --se=
rver-probe to order client remotes by probe

With --server-probe [max-laten=
cy-diff], before connecting a client sends an
out-of-band SERVER_PROBE to a=
ll configured UDP remotes, collects the PROBE_REPLYs
within a short window,=
 and reorders the connection list so the best-responding
server is tried fi=
rst=2E Unanswered probes are resent once within that window to
ride out pac=
ket loss=2E The option is off by default; its optional argument
overrides t=
he margin the server advertises=2E

The probe phase is self-contained in oo=
b_client=2Ec behind a single call from
init=2Ec (before next_connection_ent=
ry())=2E It opens one native UDP socket per
address family (the IPv6 socket=
 with IPV6_V6ONLY set, so no IPv4-mapped
traffic crosses it) to fan probes =
out and collect replies, matches each reply
to its remote by source address=
, and rejects spoofed replies via the session
id the server echoes back=2E =
Ranking and reordering use oob_rank_probe_results()=2E

For now the probe i=
s sent unwrapped, so it only works against a server without
tls-auth/tls-cr=
ypt (wrapping is a follow-up); only UDP remotes are probed; and
probing run=
s once, before the first connection=2E

Change-Id: I5a7e9e13b9f9548b7ff717d=
aae2b4a9cde3c06f2
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M CMa=
keLists=2Etxt
M doc/man-sections/client-options=2Erst
M src/openvpn/Makefil=
e=2Eam
M src/openvpn/init=2Ec
A src/openvpn/oob_client=2Ec
A src/openvpn/oo=
b_client=2Eh
M src/openvpn/options=2Ec
M src/openvpn/options=2Eh
8 files ch=
anged, 583 insertions(+), 0 deletions(-)


  git pull ssh://gerrit=2Eopenvp=
n=2Enet:29418/openvpn refs/changes/47/1747/14

diff --git a/CMakeLists=2Etx=
t b/CMakeLists=2Etxt
index f4b1b22=2E=2E39c9024 100644
--- a/CMakeLists=2Et=
xt
+++ b/CMakeLists=2Etxt
@@ -524,6 +524,8 @@
     src/openvpn/occ=2Eh
    =
 src/openvpn/oob=2Ec
     src/openvpn/oob=2Eh
+    src/openvpn/oob_client=
=2Ec
+    src/openvpn/oob_client=2Eh
     src/openvpn/openvpn=2Ec
     src/=
openvpn/openvpn=2Eh
     src/openvpn/openvpn_win32_resources=2Erc
diff --gi=
t a/doc/man-sections/client-options=2Erst b/doc/man-sections/client-options=
=2Erst
index 87c138a=2E=2E82e7b22 100644
--- a/doc/man-sections/client-opti=
ons=2Erst
+++ b/doc/man-sections/client-options=2Erst
@@ -595,6 +595,31 @@
=
   seconds for a response before trying the next server=2E The default valu=
e
   is :code:`120`=2E This timeout includes proxy and TCP connect timeouts=
=2E
 
+--server-probe args
+  Before the first connection attempt, probe al=
l configured UDP remotes
+  out-of-band and reorder the connection list bas=
ed on the replies=2E
+
+  Valid syntaxes::
+
+     server-probe
+     serve=
r-probe max-latency-diff
+
+  A small probe message is sent to the first re=
solved address of every UDP
+  remote, and each answering server replies wi=
th its advertised priority
+  and weight=2E Remotes are then reordered foll=
owing DNS SRV (RFC 2782)
+  semantics: servers that answered are tried befo=
re those that did not,
+  grouped by priority (lowest first); within a prio=
rity group, servers are
+  picked by weighted-random selection=2E Round-tri=
p time is not yet taken
+  into account, so ``max-latency-diff`` has no eff=
ect for now=2E
+
+  The probe is currently sent without control-channel wra=
pping, so it only
+  works against a server configured without ``--tls-auth=
``,
+  ``--tls-crypt`` or ``--tls-crypt-v2``=2E
+
+  Only UDP remotes are p=
robed; TCP remotes keep their configured
+  position=2E Probing runs once, =
before the first connection attempt=2E
+  See ``--server-probe-reply`` for =
the server side=2E
+
 --static-challenge args
   Enable static challenge/re=
sponse protocol
 
diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Make=
file=2Eam
index a67d478=2E=2Ecf421ca 100644
--- a/src/openvpn/Makefile=2Eam=

+++ b/src/openvpn/Makefile=2Eam
@@ -108,6 +108,7 @@
 	pkcs11_openssl=2Ec \=

 	pkcs11_mbedtls=2Ec \
 	oob=2Ec oob=2Eh \
+	oob_client=2Ec oob_client=2Eh=
 \
 	openvpn=2Ec openvpn=2Eh \
 	options=2Ec options=2Eh \
 	options_util=
=2Ec options_util=2Eh \
diff --git a/src/openvpn/init=2Ec b/src/openvpn/ini=
t=2Ec
index caaa769=2E=2E274c86a 100644
--- a/src/openvpn/init=2Ec
+++ b/sr=
c/openvpn/init=2Ec
@@ -48,6 +48,7 @@
 #include "ssl_ncp=2Eh"
 #include "tls=
_crypt=2Eh"
 #include "forward=2Eh"
+#include "oob_client=2Eh"
 #include "a=
uth_token=2Eh"
 #include "mss=2Eh"
 #include "mudp=2Eh"
@@ -4474,6 +4475,10=
 @@
         }
     }
 
+    /* Probe configured remotes and reorder them b=
est-first (--server-probe);
+     * no-op otherwise=2E Must run before next=
_connection_entry() picks a remote=2E */
+    client_probe_and_order_remote=
s(c);
+
     /* Resets all values to the initial values from the config whe=
re needed */
     pre_connect_restore(&c->options, &c->c2=2Egc);
 
diff --g=
it a/src/openvpn/oob_client=2Ec b/src/openvpn/oob_client=2Ec
new file mode =
100644
index 0000000=2E=2E4b8c576
--- /dev/null
+++ b/src/openvpn/oob_clien=
t=2Ec
@@ -0,0 +1,481 @@
+/*
+ *  OpenVPN -- An application to securely tunn=
el IP networks
+ *             over a single TCP/UDP port, with support for=
 SSL/TLS-based
+ *             session authentication and key exchange,
+ *=
             packet encryption, packet authentication, and
+ *             =
packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@o=
penvpn=2Enet>
+ *
+ *  This program is free software; you can redistribute =
it and/or modify
+ *  it under the terms of the GNU General Public License =
version 2
+ *  as published by the Free Software Foundation=2E
+ *
+ *  Thi=
s program is distributed in the hope that it will be useful,
+ *  but WITHO=
UT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY =
or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public Lic=
ense for more details=2E
+ *
+ *  You should have received a copy of the GN=
U General Public License along
+ *  with this program; if not, see <https:/=
/www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "conf=
ig=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include "oob_client=2Eh"
+#in=
clude "openvpn=2Eh"
+#include "oob=2Eh"
+#include "ssl_pkt=2Eh"
+#include "=
session_id=2Eh"
+#include "socket=2Eh"
+#include "socket_util=2Eh"
+#includ=
e "otime=2Eh"
+#include "fdmisc=2Eh"
+#include "crypto=2Eh"
+#include "erro=
r=2Eh"
+
+#include "memdbg=2Eh"
+
+/* Total time we wait for probe replies =
before giving up and connecting=2E */
+#define OOB_PROBE_WINDOW_MS 1000
+
+=
/* Number of times an unanswered probe is resent within the window, to ride=
 out
+ * UDP packet loss=2E With this set to 1, each remote is probed up to=
 2 times,
+ * which removes the single-packet-loss false negative; further =
retries give
+ * sharply diminishing returns for a low-stakes selection=2E =
*/
+#define OOB_PROBE_RETRIES 1
+
+/* Where we sent a probe, so a reply's s=
ource address can be matched back to the
+ * connection-list entry it belon=
gs to=2E */
+struct probe_target
+{
+    struct sockaddr_storage dest;
+   =
 socklen_t destlen;
+    bool sent;
+};
+
+/* The probe uses one native soc=
ket per address family, so every remote is probed
+ * on an AF-native socke=
t (no IPv4-mapped addresses)=2E The winning remote's socket
+ * can then be=
 reused as its connection socket, presenting the same source
+ * IP+port th=
e server bound its handshake cookie to=2E */
+#define PROBE_AF_V4    0
+#de=
fine PROBE_AF_V6    1
+#define PROBE_AF_COUNT 2
+
+struct probe_ctx
+{
+   =
 socket_descriptor_t sd[PROBE_AF_COUNT]; /* SOCKET_UNDEFINED if that AF is =
unavailable */
+};
+
+/* af is an int (not sa_family_t) so callers can pass=
 addrinfo::ai_family
+ * directly without a narrowing conversion (-Werror=
=3Dconversion)=2E */
+static int
+probe_af_index(int af)
+{
+    return (af=
 =3D=3D AF_INET6) ? PROBE_AF_V6 : PROBE_AF_V4;
+}
+
+/* Build a plaintext S=
ERVER_PROBE packet:
+ *   [opcode | key_id=3D0] [client session id] [SERVER=
_PROBE message]
+ * This is the unauthenticated OOB wire format; adding tls=
-auth/tls-crypt
+ * wrapping for the probe is a follow-up (it only works ag=
ainst a server with
+ * no control-channel wrapping for now)=2E */
+static =
bool
+oob_probe_build_packet(struct buffer *buf, const struct session_id *c=
lient_sid)
+{
+    const struct oob_probe_parameter param =3D {
+        =
=2Etimestamp =3D (uint64_t)now,
+        =2Eflags =3D 0,
+    };
+    uint8=
_t header =3D (uint8_t)(P_CONTROL_OOB_V1 << P_OPCODE_SHIFT);
+    return bu=
f_write_u8(buf, header) && session_id_write(client_sid, buf)
+           &&=
 oob_server_probe_write(buf, &param);
+}
+
+/* Open one native UDP probe so=
cket per address family (v4 and v6)=2E Each is
+ * AF-native (the v6 socket=
 is set IPV6_V6ONLY so no IPv4-mapped traffic crosses
+ * it), so a remote =
is always probed on a socket that can later serve as its
+ * connection soc=
ket=2E Unavailable families are left SOCKET_UNDEFINED=2E Returns the
+ * nu=
mber of sockets opened=2E */
+static int
+oob_probe_sockets_open(struct pro=
be_ctx *pc)
+{
+    int opened =3D 0;
+
+    pc->sd[PROBE_AF_V4] =3D socket=
(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
+    if (pc->sd[PROBE_AF_V4] !=3D SOCKE=
T_UNDEFINED)
+    {
+        set_cloexec(pc->sd[PROBE_AF_V4]);
+        ope=
ned++;
+    }
+
+    pc->sd[PROBE_AF_V6] =3D socket(AF_INET6, SOCK_DGRAM, I=
PPROTO_UDP);
+    if (pc->sd[PROBE_AF_V6] !=3D SOCKET_UNDEFINED)
+    {
+  =
      set_cloexec(pc->sd[PROBE_AF_V6]);
+        int on =3D 1;
+        if =
(setsockopt(pc->sd[PROBE_AF_V6], IPPROTO_IPV6, IPV6_V6ONLY, (void *)&on, si=
zeof(on)) !=3D 0)
+        {
+            msg(D_LOW, "server-probe: could n=
ot set IPV6_V6ONLY on probe socket");
+        }
+        opened++;
+    }
=
+
+    return opened;
+}
+
+static void
+oob_probe_sockets_close(struct pro=
be_ctx *pc)
+{
+    for (int i =3D 0; i < PROBE_AF_COUNT; i++)
+    {
+    =
    if (pc->sd[i] !=3D SOCKET_UNDEFINED)
+        {
+            openvpn_cl=
ose_socket(pc->sd[i]);
+            pc->sd[i] =3D SOCKET_UNDEFINED;
+      =
  }
+    }
+}
+
+/* Parse one received datagram as a PROBE_REPLY and, if va=
lid and matching one
+ * of the probes we sent, record the reply in results=
=2E */
+static void
+oob_probe_handle_reply(const uint8_t *data, int len, c=
onst struct session_id *client_sid,
+                       const struct so=
ckaddr_storage *from, const struct probe_target *targets,
+                =
       struct oob_probe_result *results, int n)
+{
+    /* Need at least th=
e opcode byte and the session id=2E */
+    if (len < 1 + (int)SID_SIZE || =
(data[0] >> P_OPCODE_SHIFT) !=3D P_CONTROL_OOB_V1)
+    {
+        return;
=
+    }
+
+    struct buffer buf;
+    buf_set_read(&buf, data, (size_t)len)=
;
+    buf_advance(&buf, 1 + SID_SIZE); /* skip opcode + server session id =
*/
+
+    struct oob_probe_reply reply;
+    if (!oob_client_reply_read(&bu=
f, &reply))
+    {
+        return;
+    }
+
+    /* Reject spoofed replies=
: the reply must echo our probe's session id=2E */
+    if (!session_id_equ=
al(&reply=2Epeer_session_id, client_sid))
+    {
+        return;
+    }
+
=
+    /* Match the reply's source address to the remote we probed=2E */
+   =
 for (int i =3D 0; i < n; i++)
+    {
+        if (targets[i]=2Esent
+     =
       && addr_port_match((const struct openvpn_sockaddr *)(const void *)fr=
om,
+                               (const struct openvpn_sockaddr *)(const=
 void *)&targets[i]=2Edest))
+        {
+            results[i]=2Eresponded=
 =3D true;
+            results[i]=2Ereply =3D reply;
+            break;
+=
        }
+    }
+}
+
+/* Count how many of the probes we sent have been an=
swered so far=2E */
+static int
+oob_count_answered(const struct probe_targ=
et *targets, const struct oob_probe_result *results,
+                   in=
t n)
+{
+    int answered =3D 0;
+    for (int i =3D 0; i < n; i++)
+    {
=
+        answered +=3D (targets[i]=2Esent && results[i]=2Eresponded) ? 1 : =
0;
+    }
+    return answered;
+}
+
+/* Receive replies for one time slice=
 (until deadline), recording each that
+ * matches a probe we sent=2E Retur=
ns true if every sent probe has been answered=2E */
+static bool
+oob_probe=
_receive_slice(const struct probe_ctx *pc, const struct timeval *deadline,
=
+                        const struct session_id *client_sid, const struct =
probe_target *targets,
+                        struct oob_probe_result *re=
sults, int n, int outstanding)
+{
+    while (true)
+    {
+        struct =
timeval tnow, timeout;
+        openvpn_gettimeofday(&tnow, NULL);
+       =
 timeout=2Etv_sec =3D deadline->tv_sec - tnow=2Etv_sec;
+        timeout=2E=
tv_usec =3D deadline->tv_usec - tnow=2Etv_usec;
+        if (timeout=2Etv_u=
sec < 0)
+        {
+            timeout=2Etv_sec -=3D 1;
+            time=
out=2Etv_usec +=3D 1000000;
+        }
+        if (timeout=2Etv_sec < 0)
+=
        {
+            return false; /* slice elapsed */
+        }
+
+    =
    fd_set readfds;
+        FD_ZERO(&readfds);
+        socket_descriptor_=
t maxsd =3D 0;
+        for (int i =3D 0; i < PROBE_AF_COUNT; i++)
+       =
 {
+            if (pc->sd[i] !=3D SOCKET_UNDEFINED)
+            {
+      =
          openvpn_fd_set(pc->sd[i], &readfds);
+                if (pc->sd[=
i] > maxsd)
+                {
+                    maxsd =3D pc->sd[i];
+ =
               }
+            }
+        }
+        if (openvpn_select((int=
)maxsd + 1, &readfds, NULL, NULL, &timeout) <=3D 0)
+        {
+           =
 return false; /* slice timed out, or error */
+        }
+
+        for (i=
nt i =3D 0; i < PROBE_AF_COUNT; i++)
+        {
+            if (pc->sd[i] =
=3D=3D SOCKET_UNDEFINED || !FD_ISSET(pc->sd[i], &readfds))
+            {
+=
                continue;
+            }
+            uint8_t data[256];
+ =
           struct sockaddr_storage from;
+            socklen_t fromlen =3D=
 sizeof(from);
+            int len =3D (int)recvfrom(pc->sd[i], (char *)da=
ta, (int)sizeof(data), 0,
+                                    (struct sock=
addr *)&from, &fromlen);
+            if (len > 0)
+            {
+        =
        oob_probe_handle_reply(data, len, client_sid, &from, targets, resul=
ts, n);
+            }
+        }
+        if (oob_count_answered(targets, =
results, n) >=3D outstanding)
+        {
+            return true; /* every=
 probe we sent has been answered */
+        }
+    }
+}
+
+/* Resend the p=
robe to every remote that we probed but that has not answered=2E */
+static=
 void
+oob_probe_resend_unanswered(const struct probe_ctx *pc, const struct=
 buffer *probe,
+                            const struct probe_target *tar=
gets,
+                            const struct oob_probe_result *results, =
int n)
+{
+    for (int i =3D 0; i < n; i++)
+    {
+        if (targets[i]=
=2Esent && !results[i]=2Eresponded)
+        {
+            socket_descript=
or_t sd =3D pc->sd[probe_af_index(targets[i]=2Edest=2Ess_family)];
+       =
     if (sd !=3D SOCKET_UNDEFINED)
+            {
+                sendto(s=
d, (const char *)BPTR(probe), (int)BLEN(probe), 0,
+                       =
(const struct sockaddr *)&targets[i]=2Edest, targets[i]=2Edestlen);
+      =
      }
+        }
+    }
+}
+
+/* Collect replies over the probe window, r=
esending unanswered probes up to
+ * OOB_PROBE_RETRIES times (UDP is lossy =
and a probe carries no retransmission
+ * of its own)=2E The window is spli=
t into equal slices, one per send round; after
+ * each slice but the last =
we resend to whoever has not answered yet=2E Returns
+ * once the window el=
apses or every sent probe has been answered=2E */
+static void
+oob_probe_c=
ollect(const struct probe_ctx *pc, const struct buffer *probe,
+           =
       const struct session_id *client_sid, const struct probe_target *targ=
ets,
+                  struct oob_probe_result *results, int n)
+{
+    /*=
 number of probes we actually sent: stop early once they all answer */
+   =
 int want =3D 0;
+    for (int i =3D 0; i < n; i++)
+    {
+        want +=
=3D targets[i]=2Esent ? 1 : 0;
+    }
+
+    const int slices =3D 1 + OOB_P=
ROBE_RETRIES;
+    const long slice_ms =3D OOB_PROBE_WINDOW_MS / slices;
+
=
+    for (int slice =3D 0; slice < slices; slice++)
+    {
+        struct =
timeval deadline;
+        openvpn_gettimeofday(&deadline, NULL);
+        =
deadline=2Etv_sec +=3D slice_ms / 1000;
+        deadline=2Etv_usec +=3D (s=
lice_ms % 1000) * 1000;
+        if (deadline=2Etv_usec >=3D 1000000)
+    =
    {
+            deadline=2Etv_sec +=3D 1;
+            deadline=2Etv_use=
c -=3D 1000000;
+        }
+
+        if (oob_probe_receive_slice(pc, &dead=
line, client_sid, targets, results, n, want))
+        {
+            retur=
n; /* all answered */
+        }
+
+        if (slice + 1 < slices)
+      =
  {
+            oob_probe_resend_unanswered(pc, probe, targets, results, n=
);
+        }
+    }
+}
+
+/* Permute the connection list so entries appear=
 in ranked order=2E */
+static void
+oob_apply_order(struct connection_list=
 *l, const struct oob_probe_result *ranked,
+                struct gc_aren=
a *gc)
+{
+    struct connection_entry **reordered =3D gc_malloc(sizeof(*re=
ordered) * l->len, false, gc);
+    for (int i =3D 0; i < l->len; i++)
+   =
 {
+        reordered[i] =3D l->array[ranked[i]=2Eindex];
+    }
+    memcp=
y(l->array, reordered, sizeof(*l->array) * l->len);
+}
+
+void
+client_prob=
e_and_order_remotes(struct context *c)
+{
+    /* Probe only once, before t=
he first connection attempt=2E */
+    if (!c->options=2Eserver_probe || !c=
->first_time)
+    {
+        return;
+    }
+
+    struct connection_list =
*l =3D c->options=2Econnection_list;
+    if (!l || l->len <=3D 1)
+    {
+=
        return; /* nothing to choose between */
+    }
+
+    struct gc_are=
na gc =3D gc_new();
+
+    /* A single random session id identifies all of =
our probes; servers echo it
+     * back in the reply's peer_session_id, le=
tting us reject spoofed replies=2E */
+    struct session_id client_sid;
+ =
   session_id_random(&client_sid);
+
+    struct probe_ctx pc =3D { =2Esd =
=3D { SOCKET_UNDEFINED, SOCKET_UNDEFINED } };
+    if (oob_probe_sockets_op=
en(&pc) =3D=3D 0)
+    {
+        msg(D_LOW, "server-probe: could not open =
probe socket; using configured order");
+        gc_free(&gc);
+        ret=
urn;
+    }
+
+    struct probe_target *targets =3D gc_malloc(sizeof(*targe=
ts) * l->len, true, &gc);
+    struct oob_probe_result *results =3D gc_mall=
oc(sizeof(*results) * l->len, true, &gc);
+
+    struct buffer probe =3D al=
loc_buf_gc(256, &gc);
+    if (!oob_probe_build_packet(&probe, &client_sid)=
)
+    {
+        msg(D_LOW, "server-probe: could not build probe packet; u=
sing configured order");
+        oob_probe_sockets_close(&pc);
+        gc=
_free(&gc);
+        return;
+    }
+
+    msg(D_LOW, "server-probe: probin=
g %d remote(s) with a %d ms window", l->len,
+        OOB_PROBE_WINDOW_MS);=

+
+    /* Send a probe to each configured remote=2E */
+    int sent_count=
 =3D 0;
+    for (int i =3D 0; i < l->len; i++)
+    {
+        results[i]=
=2Eindex =3D i;
+        results[i]=2Eresponded =3D false;
+
+        const=
 struct connection_entry *ce =3D l->array[i];
+        if (!ce->remote)
+  =
      {
+            continue; /* nothing to probe (e=2Eg=2E a connection b=
lock with no --remote) */
+        }
+        if (!proto_is_udp(ce->proto))=

+        {
+            msg(D_LOW, "server-probe: %s:%s: skipping (not a U=
DP remote)", ce->remote,
+                ce->remote_port);
+            co=
ntinue;
+        }
+
+        struct addrinfo *ai =3D NULL;
+        int st=
atus =3D openvpn_getaddrinfo(GETADDR_RESOLVE | GETADDR_TRY_ONCE | GETADDR_D=
ATAGRAM,
+                                         ce->remote, ce->remote_p=
ort, 0, NULL, AF_UNSPEC, &ai);
+        if (status !=3D 0 || !ai)
+        =
{
+            msg(D_LOW, "server-probe: %s:%s: could not resolve", ce->rem=
ote, ce->remote_port);
+            continue;
+        }
+
+        /* Prob=
e the first resolved address on the socket matching its address
+         *=
 family (stored natively; no IPv4-mapping)=2E */
+        socket_descriptor=
_t sd =3D pc=2Esd[probe_af_index(ai->ai_family)];
+        if (sd =3D=3D SO=
CKET_UNDEFINED)
+        {
+            msg(D_LOW, "server-probe: %s:%s: no=
t reachable by the probe socket", ce->remote,
+                ce->remote_p=
ort);
+        }
+        else
+        {
+            memcpy(&targets[i]=
=2Edest, ai->ai_addr, ai->ai_addrlen);
+            socklen_t destlen =3D (=
socklen_t)ai->ai_addrlen;
+            if (sendto(sd, (const char *)BPTR(&p=
robe), (int)BLEN(&probe), 0,
+                       (struct sockaddr *)&ta=
rgets[i]=2Edest, destlen)
+                < 0)
+            {
+           =
     msg(D_LOW, "server-probe: %s:%s: probe send failed", ce->remote, ce->r=
emote_port);
+            }
+            else
+            {
+             =
   targets[i]=2Edestlen =3D destlen;
+                targets[i]=2Esent =3D=
 true;
+                sent_count++;
+            }
+        }
+        fr=
eeaddrinfo(ai);
+    }
+
+    if (sent_count > 0)
+    {
+        oob_probe=
_collect(&pc, &probe, &client_sid, targets, results, l->len);
+    }
+    o=
ob_probe_sockets_close(&pc);
+
+    /* Log each remote's outcome while resu=
lts[i] still maps to array[i]=2E */
+    int responded =3D 0;
+    for (int=
 i =3D 0; i < l->len; i++)
+    {
+        const struct connection_entry *c=
e =3D l->array[i];
+        if (results[i]=2Eresponded)
+        {
+       =
     responded++;
+            msg(D_LOW, "server-probe: %s:%s answered (pr=
iority %d, weight %d)", ce->remote,
+                ce->remote_port, resul=
ts[i]=2Ereply=2Epriority, results[i]=2Ereply=2Eweight);
+        }
+       =
 else
+        {
+            msg(D_LOW, "server-probe: %s:%s did not answe=
r", ce->remote, ce->remote_port);
+        }
+    }
+
+    /* Rank best-fir=
st and reorder the connection list accordingly=2E */
+    oob_rank_probe_re=
sults(results, l->len, c->options=2Eserver_probe_latency_margin, get_random=
, &gc);
+    oob_apply_order(l, results, &gc);
+
+    msg(D_LOW, "server-pr=
obe: connecting in this order:");
+    for (int i =3D 0; i < l->len; i++)
+=
    {
+        msg(D_LOW, "server-probe:   %d=2E %s:%s", i + 1, l->array[i]=
->remote,
+            l->array[i]->remote_port);
+    }
+
+    msg(M_INFO,=
 "server-probe: %d of %d remote(s) answered; connecting best-first", respon=
ded,
+        l->len);
+
+    gc_free(&gc);
+}
diff --git a/src/openvpn/oob=
_client=2Eh b/src/openvpn/oob_client=2Eh
new file mode 100644
index 0000000=
=2E=2Eac44cdb
--- /dev/null
+++ b/src/openvpn/oob_client=2Eh
@@ -0,0 +1,44 =
@@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *   =
          over a single TCP/UDP port, with support for SSL/TLS-based
+ *   =
          session authentication and key exchange,
+ *             packet e=
ncryption, packet authentication, and
+ *             packet compression=2E=

+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *=
  This program is free software; you can redistribute it and/or modify
+ * =
 it under the terms of the GNU General Public License version 2
+ *  as pub=
lished by the Free Software Foundation=2E
+ *
+ *  This program is distribu=
ted in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; with=
out even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PART=
ICULAR PURPOSE=2E  See the
+ *  GNU General Public License for more details=
=2E
+ *
+ *  You should have received a copy of the GNU General Public Lice=
nse along
+ *  with this program; if not, see <https://www=2Egnu=2Eorg/lice=
nses/>=2E
+ */
+
+/**
+ * @file
+ * Client-side server-probe phase: before =
connecting, optionally probe all
+ * configured remotes with an out-of-band=
 SERVER_PROBE and order them
+ * best-first, so the connection loop tries t=
he most suitable server first=2E
+ */
+
+#ifndef OOB_CLIENT_H
+#define OOB_=
CLIENT_H
+
+struct context;
+
+/**
+ * Probe all configured remotes and reo=
rder the connection list best-first=2E
+ *
+ * Does nothing unless --server=
-probe is enabled=2E On any failure (or if no
+ * server answers), the conf=
igured remote order is left unchanged and the
+ * normal connection sequenc=
e proceeds=2E
+ */
+void client_probe_and_order_remotes(struct context *c);=

+
+#endif /* OOB_CLIENT_H */
diff --git a/src/openvpn/options=2Ec b/src/op=
envpn/options=2Ec
index 87218d4=2E=2Edc88a55 100644
--- a/src/openvpn/optio=
ns=2Ec
+++ b/src/openvpn/options=2Ec
@@ -804,6 +804,11 @@
     o->topology =
=3D TOP_UNDEF;
     o->ce=2Eproto =3D PROTO_UDP;
     o->ce=2Eaf =3D AF_UNS=
PEC;
+
+    /* The client latency margin is -1 =3D "not set": the client's =
value is
+     * authoritative when given, otherwise each server's advertis=
ed margin (or
+     * the built-in default) applies=2E */
+    o->server_pr=
obe_latency_margin =3D -1;
     o->ce=2Ebind_ipv6_only =3D false;
     o->c=
e=2Econnect_retry_seconds =3D 1;
     o->ce=2Econnect_retry_seconds_max =3D=
 300;
@@ -6507,6 +6512,21 @@
         VERIFY_PERMISSION(OPT_P_GENERAL);
   =
      options->mtu_test =3D true;
     }
+    else if (streq(p[0], "server-=
probe") && !p[2])
+    {
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+      =
  options->server_probe =3D true;
+        if (p[1])
+        {
+          =
  int margin =3D positive_atoi(p[1], msglevel);
+            if (margin > 0=
xffff)
+            {
+                msg(msglevel, "--server-probe: max-l=
atency-diff must be 0 to 65535 ms");
+                goto err;
+          =
  }
+            options->server_probe_latency_margin =3D margin;
+        =
}
+    }
     else if (streq(p[0], "nice") && p[1] && !p[2])
     {
       =
  VERIFY_PERMISSION(OPT_P_NICE);
diff --git a/src/openvpn/options=2Eh b/src=
/openvpn/options=2Eh
index a111cf8=2E=2E6b1120a 100644
--- a/src/openvpn/op=
tions=2Eh
+++ b/src/openvpn/options=2Eh
@@ -335,6 +335,11 @@
 
     bool mt=
u_test;
 
+    bool server_probe; /* client: probe remotes (--server-probe)=
 and connect best-first */
+    /* client: default candidate-band margin in=
 ms (--server-probe [max-latency-diff]):
+     * servers within this RTT of=
 the fastest are treated as equally fast */
+    int server_probe_latency_m=
argin;
+
     bool mlock;
 
     int keepalive_ping; /* a proxy for ping/pi=
ng-restart */

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1747?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttp://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newp=
atchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5a=
7e9e13b9f9548b7ff717daae2b4a9cde3c06f2
Gerrit-Change-Number: 1747
Gerrit-Pa=
tchSet: 14
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: pla=
isthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel=
@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc25=
49=2Eorg>

--7wRBsTd8KqU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #14</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1747?usp=3Demail">View Change</a></p><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">oob: Add=
 --server-probe to order client remotes by probe<br><br>With --server-probe=
 [max-latency-diff], before connecting a client sends an<br>out-of-band SER=
VER_PROBE to all configured UDP remotes, collects the PROBE_REPLYs<br>withi=
n a short window, and reorders the connection list so the best-responding<b=
r>server is tried first=2E Unanswered probes are resent once within that wi=
ndow to<br>ride out packet loss=2E The option is off by default; its option=
al argument<br>overrides the margin the server advertises=2E<br><br>The pro=
be phase is self-contained in oob_client=2Ec behind a single call from<br>i=
nit=2Ec (before next_connection_entry())=2E It opens one native UDP socket =
per<br>address family (the IPv6 socket with IPV6_V6ONLY set, so no IPv4-map=
ped<br>traffic crosses it) to fan probes out and collect replies, matches e=
ach reply<br>to its remote by source address, and rejects spoofed replies v=
ia the session<br>id the server echoes back=2E Ranking and reordering use o=
ob_rank_probe_results()=2E<br><br>For now the probe is sent unwrapped, so i=
t only works against a server without<br>tls-auth/tls-crypt (wrapping is a =
follow-up); only UDP remotes are probed; and<br>probing runs once, before t=
he first connection=2E<br><br>Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cd=
e3c06f2<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>=
M CMakeLists=2Etxt<br>M doc/man-sections/client-options=2Erst<br>M src/open=
vpn/Makefile=2Eam<br>M src/openvpn/init=2Ec<br>A src/openvpn/oob_client=2Ec=
<br>A src/openvpn/oob_client=2Eh<br>M src/openvpn/options=2Ec<br>M src/open=
vpn/options=2Eh<br>8 files changed, 583 insertions(+), 0 deletions(-)<br><b=
r></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn r=
efs/changes/47/1747/14</pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=
=2Etxt</span><br><span>index f4b1b22=2E=2E39c9024 100644</span><br><span>--=
- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span=
>@@ -524,6 +524,8 @@</span><br><span>     src/openvpn/occ=2Eh</span><br><sp=
an>     src/openvpn/oob=2Ec</span><br><span>     src/openvpn/oob=2Eh</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/oob_client=
=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn=
/oob_client=2Eh</span><br><span>     src/openvpn/openvpn=2Ec</span><br><spa=
n>     src/openvpn/openvpn=2Eh</span><br><span>     src/openvpn/openvpn_win=
32_resources=2Erc</span><br><span>diff --git a/doc/man-sections/client-opti=
ons=2Erst b/doc/man-sections/client-options=2Erst</span><br><span>index 87c=
138a=2E=2E82e7b22 100644</span><br><span>--- a/doc/man-sections/client-opti=
ons=2Erst</span><br><span>+++ b/doc/man-sections/client-options=2Erst</span=
><br><span>@@ -595,6 +595,31 @@</span><br><span>   seconds for a response b=
efore trying the next server=2E The default value</span><br><span>   is :co=
de:`120`=2E This timeout includes proxy and TCP connect timeouts=2E</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+--server-=
probe args</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Before =
the first connection attempt, probe all configured UDP remotes</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  out-of-band and reorder the co=
nnection list based on the replies=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 Valid syntaxes::</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     server-probe</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     server-probe max-l=
atency-diff</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  A small probe message is =
sent to the first resolved address of every UDP</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  remote, and each answering server replies wit=
h its advertised priority</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  and weight=2E Remotes are then reordered following DNS SRV (RFC 278=
2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  semantics: serv=
ers that answered are tried before those that did not,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  grouped by priority (lowest first); wi=
thin a priority group, servers are</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  picked by weighted-random selection=2E Round-trip time is =
not yet taken</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  into=
 account, so ``max-latency-diff`` has no effect for now=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  The probe is currently sent without control-channel w=
rapping, so it only</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  works against a server configured without ``--tls-auth``,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  ``--tls-crypt`` or ``--tls-crypt-=
v2``=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  Only UDP remotes are probed; =
TCP remotes keep their configured</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  position=2E Probing runs once, before the first connection =
attempt=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  See ``-=
-server-probe-reply`` for the server side=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span> --static-challenge args</span><b=
r><span>   Enable static challenge/response protocol</span><br><span> </spa=
n><br><span>diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=
=2Eam</span><br><span>index a67d478=2E=2Ecf421ca 100644</span><br><span>---=
 a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/Makefile=2Ea=
m</span><br><span>@@ -108,6 +108,7 @@</span><br><span> 	pkcs11_openssl=2Ec =
\</span><br><span> 	pkcs11_mbedtls=2Ec \</span><br><span> 	oob=2Ec oob=2Eh =
\</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	oob_client=2Ec oo=
b_client=2Eh \</span><br><span> 	openvpn=2Ec openvpn=2Eh \</span><br><span>=
 	options=2Ec options=2Eh \</span><br><span> 	options_util=2Ec options_util=
=2Eh \</span><br><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=
=2Ec</span><br><span>index caaa769=2E=2E274c86a 100644</span><br><span>--- =
a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br=
><span>@@ -48,6 +48,7 @@</span><br><span> #include &quot;ssl_ncp=2Eh&quot;<=
/span><br><span> #include &quot;tls_crypt=2Eh&quot;</span><br><span> #inclu=
de &quot;forward=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#include &quot;oob_client=2Eh&quot;</span><br><span> #include &quot;=
auth_token=2Eh&quot;</span><br><span> #include &quot;mss=2Eh&quot;</span><b=
r><span> #include &quot;mudp=2Eh&quot;</span><br><span>@@ -4474,6 +4475,10 =
@@</span><br><span>         }</span><br><span>     }</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Probe configured =
remotes and reorder them best-first (--server-probe);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * no-op otherwise=2E Must run before=
 next_connection_entry() picks a remote=2E */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    client_probe_and_order_remotes(c);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* Reset=
s all values to the initial values from the config where needed */</span><b=
r><span>     pre_connect_restore(&amp;c-&gt;options, &amp;c-&gt;c2=2Egc);</=
span><br><span> </span><br><span>diff --git a/src/openvpn/oob_client=2Ec b/=
src/openvpn/oob_client=2Ec</span><br><span>new file mode 100644</span><br><=
span>index 0000000=2E=2E4b8c576</span><br><span>--- /dev/null</span><br><sp=
an>+++ b/src/openvpn/oob_client=2Ec</span><br><span>@@ -0,0 +1,481 @@</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely=
 tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *             over a single TCP/UDP port, with support for SSL/TLS-based</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             sessio=
n authentication and key exchange,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *             packet encryption, packet authentication, and=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             pack=
et compression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2=
002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  This program is free software; you can redistribute it and/=
or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it und=
er the terms of the GNU General Public License version 2</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Software =
Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is dis=
tributed in the hope that it will be useful,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the imp=
lied warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License=
 for more details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should h=
ave received a copy of the GNU General Public License along</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see =
&lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAV=
E_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;config=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &quot;oob_client=2Eh&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;open=
vpn=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inclu=
de &quot;oob=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#include &quot;ssl_pkt=2Eh&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#include &quot;session_id=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;socket=2Eh&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;socket_util=2E=
h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &qu=
ot;otime=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
include &quot;fdmisc=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#include &quot;crypto=2Eh&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &quot;error=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &quot;memdbg=2Eh&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/* Total time we wait for probe replies before giving up and connec=
ting=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define O=
OB_PROBE_WINDOW_MS 1000</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Number of ti=
mes an unanswered probe is resent within the window, to ride out</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * UDP packet loss=2E With thi=
s set to 1, each remote is probed up to 2 times,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * which removes the single-packet-loss false =
negative; further retries give</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * sharply diminishing returns for a low-stakes selection=2E */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OOB_PROBE_RE=
TRIES 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/* Where we sent a probe, so a =
reply&#39;s source address can be matched back to the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * connection-list entry it belongs to=2E=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct probe_tar=
get</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct sockaddr_storage dest;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    socklen_t destle=
n;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool sent;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/* The probe uses one native socket per address family, so=
 every remote is probed</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * on an AF-native socket (no IPv4-mapped addresses)=2E The winning rem=
ote&#39;s socket</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
can then be reused as its connection socket, presenting the same source</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * IP+port the server b=
ound its handshake cookie to=2E */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#define PROBE_AF_V4    0</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#define PROBE_AF_V6    1</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#define PROBE_AF_COUNT 2</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+struct probe_ctx</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    socket=
_descriptor_t sd[PROBE_AF_COUNT]; /* SOCKET_UNDEFINED if that AF is unavail=
able */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/* af is an int (not sa_family_t) so callers can=
 pass addrinfo::ai_family</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * directly without a narrowing conversion (-Werror=3Dconversion)=2E =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+probe_af_index(int af)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return (af =3D=3D AF_INET6) ? PROBE_A=
F_V6 : PROBE_AF_V4;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/* Build a plaintext SERVER_PROBE pac=
ket:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   [opcode | =
key_id=3D0] [client session id] [SERVER_PROBE message]</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * This is the unauthenticated OOB wire =
format; adding tls-auth/tls-crypt</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * wrapping for the probe is a follow-up (it only works again=
st a server with</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
no control-channel wrapping for now)=2E */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+oob_probe_build_packet(struct buffer *buf, const struct sess=
ion_id *client_sid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct o=
ob_probe_parameter param =3D {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        =2Etimestamp =3D (uint64_t)now,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        =2Eflags =3D 0,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    uint8_t header =3D (uint8_t)(P_CONTROL_OOB_V1 &lt=
;&lt; P_OPCODE_SHIFT);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    return buf_write_u8(buf, header) &amp;&amp; session_id_write(client_=
sid, buf)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
 &amp;&amp; oob_server_probe_write(buf, &amp;param);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* =
Open one native UDP probe socket per address family (v4 and v6)=2E Each is<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * AF-native (the v6=
 socket is set IPV6_V6ONLY so no IPv4-mapped traffic crosses</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * it), so a remote is always prob=
ed on a socket that can later serve as its</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * connection socket=2E Unavailable families are lef=
t SOCKET_UNDEFINED=2E Returns the</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * number of sockets opened=2E */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+oob_probe_sockets_open(struct probe_ctx *pc)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    int opened =3D 0;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    pc-&gt;sd[PROBE_AF_V4] =3D socket(AF_INET, SOCK_DGRAM, IPPROTO=
_UDP);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (pc-&g=
t;sd[PROBE_AF_V4] !=3D SOCKET_UNDEFINED)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        set_cloexec(pc-&gt;sd[PROBE_AF_V4]);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        opened++;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    pc-&gt;sd[PROBE_AF_V6] =3D socket(AF_INET6, SOCK_DGRAM, IPPROTO_UDP);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (pc-&gt;sd[PR=
OBE_AF_V6] !=3D SOCKET_UNDEFINED)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        set_cloexec(pc-&gt;sd[PROBE_AF_V6]);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        int on =3D 1;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (setsockopt(pc-&gt;sd[PROBE_AF_V6], I=
PPROTO_IPV6, IPV6_V6ONLY, (void *)&amp;on, sizeof(on)) !=3D 0)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(D_LOW, &quot;server-probe=
: could not set IPV6_V6ONLY on probe socket&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        opened++;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return =
opened;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+oob_probe_sockets_close(struct probe_ctx *pc)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; PROBE_AF_COUNT; i++)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if (pc-&gt;sd[i] !=3D SOC=
KET_UNDEFINED)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ope=
nvpn_close_socket(pc-&gt;sd[i]);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            pc-&gt;sd[i] =3D SOCKET_UNDEFINED;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Parse one received=
 datagram as a PROBE_REPLY and, if valid and matching one</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * of the probes we sent, record the =
reply in results=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_p=
robe_handle_reply(const uint8_t *data, int len, const struct session_id *cl=
ient_sid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
             const struct sockaddr_storage *from, const struct probe_target=
 *targets,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
              struct oob_probe_result *results, int n)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* Need at least the opcode byte and the session id=2E=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (len &lt;=
 1 + (int)SID_SIZE || (data[0] &gt;&gt; P_OPCODE_SHIFT) !=3D P_CONTROL_OOB_=
V1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct buffer buf;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    buf_set_read(&amp;buf, data, (size_t)len);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    buf_advance(&amp;buf, 1 + SID_SIZ=
E); /* skip opcode + server session id */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct oob_probe_reply reply;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (!oob_client_reply_read(&amp;buf, &amp;reply))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* Reject spoofed replies: the reply must echo our probe&#39;s session=
 id=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!s=
ession_id_equal(&amp;reply=2Epeer_session_id, client_sid))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Match=
 the reply&#39;s source address to the remote we probed=2E */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; n; i=
++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if (targets[i]=2Esent<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &amp;&am=
p; addr_port_match((const struct openvpn_sockaddr *)(const void *)from,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
        (const struct openvpn_sockaddr *)(const void *)&amp;targets[i]=2Ede=
st))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            results[i]=2E=
responded =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            results[i]=2Ereply =3D reply;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            break;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/* Count how many of the probes we sent =
have been answered so far=2E */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+static int</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+oob_count_answered(const struct probe_target *targets, const struct oob_=
probe_result *results,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                   int n)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int a=
nswered =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    f=
or (int i =3D 0; i &lt; n; i++)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      answered +=3D (targets[i]=2Esent &amp;&amp; results[i]=2Eresponded) ?=
 1 : 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return answered;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* Receive replies for one time slice (until deadline), reco=
rding each that</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * m=
atches a probe we sent=2E Returns true if every sent probe has been answere=
d=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_receive_sl=
ice(const struct probe_ctx *pc, const struct timeval *deadline,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                        const s=
truct session_id *client_sid, const struct probe_target *targets,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                        struc=
t oob_probe_result *results, int n, int outstanding)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    while (true)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       struct timeval tnow, timeout;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        openvpn_gettimeofday(&amp;tnow, NULL);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        timeout=2Etv_sec =3D de=
adline-&gt;tv_sec - tnow=2Etv_sec;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        timeout=2Etv_usec =3D deadline-&gt;tv_usec - tnow=2E=
tv_usec;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
(timeout=2Etv_usec &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         timeout=2Etv_sec -=3D 1;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            timeout=2Etv_usec +=3D 1000000;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if (timeout=2Etv_sec &lt; 0)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            return false; /* slice elaps=
ed */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        fd_set readfds;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        FD_ZERO(&amp;readfds);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        socket_descriptor_=
t maxsd =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   for (int i =3D 0; i &lt; PROBE_AF_COUNT; i++)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            if (pc-&gt;sd[i] !=3D SOCKET_UNDEFINED)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                openvpn_fd_set=
(pc-&gt;sd[i], &amp;readfds);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                if (pc-&gt;sd[i] &gt; maxsd)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    maxsd =3D pc-&gt;sd[i=
];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (openvpn_select((int)max=
sd + 1, &amp;readfds, NULL, NULL, &amp;timeout) &lt;=3D 0)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            return false; /* slice timed out, =
or error */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D 0; i &lt; PROB=
E_AF_COUNT; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            i=
f (pc-&gt;sd[i] =3D=3D SOCKET_UNDEFINED || !FD_ISSET(pc-&gt;sd[i], &amp;rea=
dfds))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                con=
tinue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            uint8_t=
 data[256];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    struct sockaddr_storage from;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            socklen_t fromlen =3D sizeof(from);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            int len =3D (int)recv=
from(pc-&gt;sd[i], (char *)data, (int)sizeof(data), 0,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                                    (str=
uct sockaddr *)&amp;from, &amp;fromlen);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            if (len &gt; 0)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                oob_probe_handle_reply(data, len, cl=
ient_sid, &amp;from, targets, results, n);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (oob_count_answered(targets, results, n) &gt;=3D outstand=
ing)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            return true; =
/* every probe we sent has been answered */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/* Resend the probe to every remote t=
hat we probed but that has not answered=2E */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+oob_probe_resend_unanswered(const struct probe_ctx *pc, c=
onst struct buffer *probe,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                            const struct probe_target *targets,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
    const struct oob_probe_result *results, int n)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    for (int i =3D 0; i &lt; n; i++)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (targets[i]=2Esent &amp;&amp; !results[i]=2Eresp=
onded)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            socket_desc=
riptor_t sd =3D pc-&gt;sd[probe_af_index(targets[i]=2Edest=2Ess_family)];</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (sd !=
=3D SOCKET_UNDEFINED)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            sendto(sd, (const char *)BPTR(probe), (int)BLEN(probe), 0,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                       (=
const struct sockaddr *)&amp;targets[i]=2Edest, targets[i]=2Edestlen);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Collect repli=
es over the probe window, resending unanswered probes up to</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * OOB_PROBE_RETRIES times (UDP is =
lossy and a probe carries no retransmission</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * of its own)=2E The window is split into equal sl=
ices, one per send round; after</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * each slice but the last we resend to whoever has not answere=
d yet=2E Returns</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
once the window elapses or every sent probe has been answered=2E */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+oob_probe_collect(const struct prob=
e_ctx *pc, const struct buffer *probe,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                  const struct session_id *client_sid, c=
onst struct probe_target *targets,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                  struct oob_probe_result *results, int n)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* number of probes we actually sen=
t: stop early once they all answer */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    int want =3D 0;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    for (int i =3D 0; i &lt; n; i++)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        want +=3D targets[i]=2Esent ? 1 : 0;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const int slices =3D 1 + OOB_PROBE_RETRIES;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    const long slice_ms =3D OOB_=
PROBE_WINDOW_MS / slices;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int =
slice =3D 0; slice &lt; slices; slice++)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        struct timeval deadline;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        openvpn_gettimeofday(&amp;deadline, NULL);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        deadline=2Etv_se=
c +=3D slice_ms / 1000;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        deadline=2Etv_usec +=3D (slice_ms % 1000) * 1000;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if (deadline=2Etv_usec &g=
t;=3D 1000000)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            dea=
dline=2Etv_sec +=3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            deadline=2Etv_usec -=3D 1000000;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (oob_probe_receive_slice(pc, &amp;deadline, client_sid, targets, =
results, n, want))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 return; /* all answered */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (slice + 1=
 &lt; slices)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            oob_=
probe_resend_unanswered(pc, probe, targets, results, n);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Permute the connectio=
n list so entries appear in ranked order=2E */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+oob_apply_order(struct connection_list *l, const struct =
oob_probe_result *ranked,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                struct gc_arena *gc)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct connection_entry **reordered =3D gc_malloc(sizeof(*reordere=
d) * l-&gt;len, false, gc);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    for (int i =3D 0; i &lt; l-&gt;len; i++)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        reordered[i] =3D l-&gt;array[ranked[i]=2Eindex]=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    memcpy(l-&gt;array, reordere=
d, sizeof(*l-&gt;array) * l-&gt;len);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+client_probe_and_order_remotes(str=
uct context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Probe only once=
, before the first connection attempt=2E */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (!c-&gt;options=2Eserver_probe || !c-&gt;fir=
st_time)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct connection_list *l =3D c-&gt;options=2Econnection=
_list;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!l ||=
 l-&gt;len &lt;=3D 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retu=
rn; /* nothing to choose between */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_are=
na gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* A single ran=
dom session id identifies all of our probes; servers echo it</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     * back in the reply&#39;s pee=
r_session_id, letting us reject spoofed replies=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct session_id client_sid;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    session_id_random(&amp;=
client_sid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct probe_ctx pc =
=3D { =2Esd =3D { SOCKET_UNDEFINED, SOCKET_UNDEFINED } };</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (oob_probe_sockets_open(&amp;p=
c) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_LOW, &q=
uot;server-probe: could not open probe socket; using configured order&quot;=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&=
amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret=
urn;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct probe_target *targets =3D gc_malloc(s=
izeof(*targets) * l-&gt;len, true, &amp;gc);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct oob_probe_result *results =3D gc_malloc=
(sizeof(*results) * l-&gt;len, true, &amp;gc);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct buffer probe =3D alloc_buf_gc(256, &amp;gc);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (!oob_probe_build_packet=
(&amp;probe, &amp;client_sid))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     msg(D_LOW, &quot;server-probe: could not build probe packet; using con=
figured order&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        oob_probe_sockets_close(&amp;pc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg=
(D_LOW, &quot;server-probe: probing %d remote(s) with a %d ms window&quot;,=
 l-&gt;len,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
OOB_PROBE_WINDOW_MS);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Send a pro=
be to each configured remote=2E */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    int sent_count =3D 0;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    for (int i =3D 0; i &lt; l-&gt;len; i++)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        results[i]=2Eindex =3D i;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        results[i]=2Erespon=
ded =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        const struct con=
nection_entry *ce =3D l-&gt;array[i];</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (!ce-&gt;remote)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            continue; /* nothing to probe (e=2Eg=2E a conne=
ction block with no --remote) */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if (!proto_is_udp(ce-&gt;proto))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            msg(D_LOW, &quot;server-probe: %s:%s: skipping (n=
ot a UDP remote)&quot;, ce-&gt;remote,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                ce-&gt;remote_port);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            continue;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        struct addrinfo *ai =3D NULL;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        int status =3D openvpn_getaddrinfo(GETAD=
DR_RESOLVE | GETADDR_TRY_ONCE | GETADDR_DATAGRAM,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                                         ce-&=
gt;remote, ce-&gt;remote_port, 0, NULL, AF_UNSPEC, &amp;ai);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if (status !=3D 0 || !ai)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_LOW, &quot;s=
erver-probe: %s:%s: could not resolve&quot;, ce-&gt;remote, ce-&gt;remote_p=
ort);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            co=
ntinue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* Probe the first resolved addre=
ss on the socket matching its address</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+         * family (stored natively; no IPv4-mapping)=2E *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        socket_des=
criptor_t sd =3D pc=2Esd[probe_af_index(ai-&gt;ai_family)];</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (sd =3D=3D SOCKET_UNDEFI=
NED)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_LOW, &q=
uot;server-probe: %s:%s: not reachable by the probe socket&quot;, ce-&gt;re=
mote,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  ce-&gt;remote_port);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            memcpy(&amp;=
targets[i]=2Edest, ai-&gt;ai_addr, ai-&gt;ai_addrlen);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            socklen_t destlen =3D (sockl=
en_t)ai-&gt;ai_addrlen;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            if (sendto(sd, (const char *)BPTR(&amp;probe), (int)BLEN(&a=
mp;probe), 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                 (struct sockaddr *)&amp;targets[i]=2Edest, destlen)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                &lt; 0)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                msg(D_LOW, &=
quot;server-probe: %s:%s: probe send failed&quot;, ce-&gt;remote, ce-&gt;re=
mote_port);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            el=
se</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                targets=
[i]=2Edestlen =3D destlen;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                targets[i]=2Esent =3D true;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                sent_count++;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        freeaddrinfo(ai);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (sent_count &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        o=
ob_probe_collect(&amp;pc, &amp;probe, &amp;client_sid, targets, results, l-=
&gt;len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    oob_probe_sockets_cl=
ose(&amp;pc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Log each remote&#3=
9;s outcome while results[i] still maps to array[i]=2E */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    int responded =3D 0;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; l-&=
gt;len; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const struct =
connection_entry *ce =3D l-&gt;array[i];</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if (results[i]=2Eresponded)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            responded++;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(D_LOW, &quot;server-probe=
: %s:%s answered (priority %d, weight %d)&quot;, ce-&gt;remote,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                ce-&gt;remote_p=
ort, results[i]=2Ereply=2Epriority, results[i]=2Ereply=2Eweight);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            msg(D_LOW, &quot;server-probe: %s:%s did not=
 answer&quot;, ce-&gt;remote, ce-&gt;remote_port);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Rank =
best-first and reorder the connection list accordingly=2E */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    oob_rank_probe_results(results=
, l-&gt;len, c-&gt;options=2Eserver_probe_latency_margin, get_random, &amp;=
gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    oob_apply_o=
rder(l, results, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_LO=
W, &quot;server-probe: connecting in this order:&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; l-&gt;len=
; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_LOW, &quot;se=
rver-probe:   %d=2E %s:%s&quot;, i + 1, l-&gt;array[i]-&gt;remote,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            l-&gt;array[i]-&=
gt;remote_port);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    msg(M_INFO, &quot;server-probe: =
%d of %d remote(s) answered; connecting best-first&quot;, responded,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        l-&gt;len);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/src/openvp=
n/oob_client=2Eh b/src/openvpn/oob_client=2Eh</span><br><span>new file mode=
 100644</span><br><span>index 0000000=2E=2Eac44cdb</span><br><span>--- /dev=
/null</span><br><span>+++ b/src/openvpn/oob_client=2Eh</span><br><span>@@ -=
0,0 +1,44 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An applic=
ation to securely tunnel IP networks</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *             over a single TCP/UDP port, with support fo=
r SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
           session authentication and key exchange,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption, packet =
authentication, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *             packet compression=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  This program is free software; you can r=
edistribute it and/or modify</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  it under the terms of the GNU General Public License version 2=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by=
 the Free Software Foundation=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
This program is distributed in the hope that it will be useful,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; w=
ithout even the implied warranty of</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E =
 See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU Gen=
eral Public License for more details=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  You should have received a copy of the GNU General Public License al=
ong</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this pr=
ogram; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @fil=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Client-side ser=
ver-probe phase: before connecting, optionally probe all</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * configured remotes with an out-of-b=
and SERVER_PROBE and order them</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * best-first, so the connection loop tries the most suitable s=
erver first=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#ifndef OOB_CLIENT_H</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#define OOB_CLIENT_H</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+struct context;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Probe all configur=
ed remotes and reorder the connection list best-first=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * Does nothing unless --server-probe is enabled=2E On =
any failure (or if no</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * server answers), the configured remote order is left unchanged and the=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * normal connectio=
n sequence proceeds=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void client_p=
robe_and_order_remotes(struct context *c);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#endif /* OOB_CLIENT_H */</span><br><span>diff --git a/src/openvpn/opti=
ons=2Ec b/src/openvpn/options=2Ec</span><br><span>index 87218d4=2E=2Edc88a5=
5 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ =
b/src/openvpn/options=2Ec</span><br><span>@@ -804,6 +804,11 @@</span><br><s=
pan>     o-&gt;topology =3D TOP_UNDEF;</span><br><span>     o-&gt;ce=2Eprot=
o =3D PROTO_UDP;</span><br><span>     o-&gt;ce=2Eaf =3D AF_UNSPEC;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* The client latency margin is -1 =3D &quo=
t;not set&quot;: the client&#39;s value is</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * authoritative when given, otherwise each serv=
er&#39;s advertised margin (or</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     * the built-in default) applies=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    o-&gt;server_probe_latency_margin =3D=
 -1;</span><br><span>     o-&gt;ce=2Ebind_ipv6_only =3D false;</span><br><s=
pan>     o-&gt;ce=2Econnect_retry_seconds =3D 1;</span><br><span>     o-&gt=
;ce=2Econnect_retry_seconds_max =3D 300;</span><br><span>@@ -6507,6 +6512,2=
1 @@</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><=
span>         options-&gt;mtu_test =3D true;</span><br><span>     }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &q=
uot;server-probe&quot;) &amp;&amp; !p[2])</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        options-&gt;server_probe =3D true;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (p[1])</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            int margin =3D positiv=
e_atoi(p[1], msglevel);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            if (margin &gt; 0xffff)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                msg(msglevel, &quot;--server-probe: max-laten=
cy-diff must be 0 to 65535 ms&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                goto err;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            options-&gt;server_probe_latency_margin =3D m=
argin;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> =
    else if (streq(p[0], &quot;nice&quot;) &amp;&amp; p[1] &amp;&amp; !p[2]=
)</span><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_N=
ICE);</span><br><span>diff --git a/src/openvpn/options=2Eh b/src/openvpn/op=
tions=2Eh</span><br><span>index a111cf8=2E=2E6b1120a 100644</span><br><span=
>--- a/src/openvpn/options=2Eh</span><br><span>+++ b/src/openvpn/options=2E=
h</span><br><span>@@ -335,6 +335,11 @@</span><br><span> </span><br><span>  =
   bool mtu_test;</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    bool server_probe; /* client: probe remotes (--server-p=
robe) and connect best-first */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* client: default candidate-band margin in ms (--server-pr=
obe [max-latency-diff]):</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     * servers within this RTT of the fastest are treated as equally f=
ast */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int serve=
r_probe_latency_margin;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span>     bool mlock;</span><br><span> </span><br><span>   =
  int keepalive_ping; /* a proxy for ping/ping-restart */</span><br><span><=
/span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1747?usp=3Demail">change 1747</a>=2E To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sche=
ma=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1747?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde=
3c06f2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1747 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 14 </div>
<div style=3D"dis=
play:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=


</body></html>
--7wRBsTd8KqU=--


--===============8191409036035243238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8191409036035243238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8191409036035243238==--

