Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B289C61DD3
	for <openvpn-devel@archiver.kernel.org>; Thu,  3 Sep 2026 06:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=F6sbikzuJEUefF6n1N4EDtvEhuHy1PTLt5+pLBSiFGQ=; b=XhocYhKiZU87r7
	3L71SlSYsph5u15zPQA3GiTTLyZu89qIyDty7WH8iBntklcE/Fk3K09pcvZyWQcnBWRa7OKYRvHfx
	jZ1VHki0jCyD+Isg2TpnECLPvQgNjiam6DOuY/75A9mVnaDpChniTuZ/cxtYyOmeVJ/b3nVS3ymaS
	aB0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x20lL-0006EK-Kq;
	Thu, 03 Sep 2026 06:17:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x20l4-0006CZ-6g
 for openvpn-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 06:17:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0A7QdveeHgEqv67N58KZzaHMpUI6yZpM8ygTo/SkUhw=; b=HJw70f2af0y9TZmXywHhTCRycq
 BKVmIzt7V+16uywJdHFlU8JtjThGPb4AX8LXyaEb59LquDJ5C+zme0hW9yy6//E1c8/5ZHWcmREh1
 KtORXDGp2eRtsyLgBc8z4P5DAsUbTuRoimYhUSoYxKxHGPI3ToSkvrbQlX+YNWb5kOSg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=0A7QdveeHgEqv67N58KZzaHMpUI6yZpM8ygTo/SkUhw=; b=Y
 LkUVNPCgFpnd6u1hX6QBlwKQvPblSKvvbfrP1ZQ2f6J4N6aAmgLRzzNHIOvMuhUXijbx61pPtTzN+
 erFhxgzb8scajpgJDAJt6r4mgmrt3K5YnmVHdtY23sbqY1FqgexxmUE2wNlcKHDUMY7jVpGN7ipXb
 u9jBFw8NU5CBmdCo=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x20kt-000357-0E for openvpn-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 06:17:00 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48441fa5c37so1332180f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 02 Sep 2026 23:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788416212; x=1789021012; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0A7QdveeHgEqv67N58KZzaHMpUI6yZpM8ygTo/SkUhw=;
 b=P62T+UF68igH8r+d8Z4yG7NQrFffMrx5zzewtzZCAbyoMI4cG/Mql4eDu8fPSc9MNk
 ux7Y28EEkoa6qsp+9SvkHAMgKb9yJm4Kwe7bZUfb6ykUoC9A3fvWEhBLov2tgdUOo4Dj
 0TgqgutCmRKXZQufo3rMWXC+7A34oEJAKVfzPg8qzigzC9O8buMQiiIOstzgzObZ+ywN
 PW1btdJbK90KboyHKyW8YwMBE4/mxAgPKA/Tbo/LOJYd+ePC9XsmKxzoBeTJ4Y57sCsd
 ISVZqTabZlPZNLe4rHZd+dk6x7oRNwztPAwEVG1zRyblc5nwXb2frZBqmXWP1hXIKaqW
 YfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788416212; x=1789021012;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0A7QdveeHgEqv67N58KZzaHMpUI6yZpM8ygTo/SkUhw=;
 b=UUDCq4blUXGRRhgdC/Oya9/hwNBpK+6RA0M/9WYSaMHFGsrXSGgTnGmlomaUZTj2H4
 wf/GFro0aUqFz2UW6oXQ17FWC7zTZIV4IMlHSpqjRdjRjwJnXUZXUChbMpa4FEWzmk0K
 TeSrUqPIE2K9fj4He6J4qbSAu76gHN9ne+RIkPjtcA4xo7N2wA4nxUV7eTchqa7yLtj3
 ohKDomR672H0ChqaUZL0xS5ZOzjD0UEQOkIWaL+pY30NoTwst+p4CAoxgj2ttFOsgtWA
 lMv9a01KNjgG+hbu1/EqzPozFJ/smOJVOdwomKgE8J/xAMub8O2/ymMmCk4zMK5rehCA
 z3qA==
X-Gm-Message-State: AFuF++ncxqJzurChiggcYBzbgRqFb25zbsVJPQblLx8MQkfb+5h+Q5oz
 3ELVO70SzU0QqUPEwpbU9EzzVuL2SMHQS/5FKzfENHWqRwQX8PI5vJ47uW+Vd8TB0J7EDEDj5di
 RkOGronUzBAXQyTOPukngp7SqkPzM4uG9sUlMx/oQ5pNr+YLs1gaGPISAXEGycKMtMw8xV4aqsY
 0BET5QCQ==
X-Gm-Gg: AYBFou32meBzTDZtGn5ctY42KAFQalj7Tn0xyRRODTR6Hlq672ZhcNiEzUlKAgeOE32
 BSzEc7DSGhZgJyh4z3MDpnkhkvZv+U9pVXYYMv6qm8bcAoiu03Bd/LiR+aNFnxs4/dJvMRGtfdI
 5SKNh2d7IjToPLtVbQQoQPN7PBK2CH+14msdgAqRTlMvJ4UqnsBIm5nW3ZrYG0WAOJB5mDg/dUF
 V1NCmlk5fw/TRc6kWby0lZJIHFV4+31yJIr0wBpnDTYU6bcWPjAxM+adoDDLqdrPcXicXYfYoAU
 HV3WlXOKJAtpWbB9OSN2EeVh7u/m50YS0VmFzoEdSP1BI4DntO96MrD1GWJD3EI8kN62IbFA6so
 0IAeaRzt0HrLSS9n/fUhrwf32QBxHygGSE7TXlG9iZlSUsB7k3K9A8UEuhZsmbYPO46Vs5GgNEj
 0lN/fo30v9IT69hvq04r0nB8IdHuxiSOTov8MuPMc6S216pHSdjfKDQ0ipCzWUyKjvnfEptqE46
 heaTuvIUr0uKuFBf+WY7abK6q82avcTW+SAtxfQqjXraKI56TQEMypdlMO7/J09JdNZ6uWM9mZA
 qfb4odHmwM0EbgSiCXdTQMgYMb7wU3BwvjTUUzvk55+8eJK6fAU=
X-Received: by 2002:a05:600c:474a:b0:493:aa0a:45ad with SMTP id
 5b1f17b1804b1-49ce55ecebemr132869765e9.2.1788416212005; 
 Wed, 02 Sep 2026 23:16:52 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce551bf7asm66853495e9.2.2026.09.02.23.16.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 23:16:51 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 3 Sep 2026 06:16:51 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I3c6ad247614fb204a279b73e98f8c4704e16da2a
X-Gerrit-Change-Number: 1894
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1894?usp=email>
X-Gerrit-Commit: 93eeb81420a4a26ddf2a0c19970a821aa1d8aef6
References: <gerrit.1788416209000.I3c6ad247614fb204a279b73e98f8c4704e16da2a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NDE2MjA5MDAwLkkzYzZhZDI0NzYxNGZiMjA0YTI3OWI3M2U5OGY4YzQ3MDRlMTZkYTJhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <95ea58c58bd4e561f01618eb8e433d1e88d9b132-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x20kt-000357-0E
Subject: [Openvpn-devel] [M] Change in openvpn[master]: reliable: add unit
 tests for ACK and backoff DoS hardening
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5890312007048269393=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5890312007048269393==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VGNEQ77eZ7g="; charset=UTF-8

--VGNEQ77eZ7g=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1894?usp=3Demail

to review the following change=2E


Chang=
e subject: reliable: add unit tests for ACK and backoff DoS hardening
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

reliable: add un=
it tests for ACK and backoff DoS hardening

Add regression coverage for the=
 reliability-layer denial-of-service fix:

 - the retransmission timeout mu=
st stay positive and bounded no matter how
   often the fast-retransmit pat=
h is forced, so it can no longer overflow;
 - reliable_send_purge() must ig=
nore ACKs for packet IDs that could never
   have been in flight (out of th=
e send window, or wrapped-around), so a
   peer cannot inflate n_acks and f=
orce early retransmits;
 - a legitimate ACK for a real higher packet ID sti=
ll removes that entry
   and counts towards fast retransmit (positive contr=
ol)=2E

These tests fail on the unfixed code and pass with the fix=2E

Sign=
ed-off-by: Lev Stipakov <lev@openvpn=2Enet>
Change-Id: I3c6ad247614fb204a27=
9b73e98f8c4704e16da2a
---
M CMakeLists=2Etxt
M tests/unit_tests/openvpn/Mak=
efile=2Eam
A tests/unit_tests/openvpn/test_reliable=2Ec
3 files changed, 21=
8 insertions(+), 0 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:=
29418/openvpn refs/changes/94/1894/1

diff --git a/CMakeLists=2Etxt b/CMake=
Lists=2Etxt
index 6eb5954=2E=2E429f143 100644
--- a/CMakeLists=2Etxt
+++ b/=
CMakeLists=2Etxt
@@ -680,6 +680,7 @@
         "test_options_parse"
        =
 "test_packet_id"
         "test_pkt"
+        "test_reliable"
         "te=
st_provider"
         "test_socket"
         "test_ssl"
@@ -881,6 +882,14 @=
@
         src/openvpn/session_id=2Ec
         )
 
+    target_sources(test=
_reliable PRIVATE
+        tests/unit_tests/openvpn/mock_get_random=2Ec
+  =
      src/openvpn/otime=2Ec
+        src/openvpn/packet_id=2Ec
+        src=
/openvpn/reliable=2Ec
+        src/openvpn/session_id=2Ec
+        )
+
    =
 target_sources(test_pkt PRIVATE
         tests/unit_tests/openvpn/mock_win=
32_execve=2Ec
         src/openvpn/argv=2Ec
diff --git a/tests/unit_tests/o=
penvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index 5954902=
=2E=2E44614ae 100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tes=
ts/unit_tests/openvpn/Makefile=2Eam
@@ -17,6 +17,7 @@
 	options_parse_testd=
river \
 	packet_id_testdriver \
 	pkt_testdriver \
+	reliable_testdriver \=

 	provider_testdriver \
 	push_update_msg_testdriver \
 	socket_testdriver=
 \
@@ -153,6 +154,21 @@
 	$(top_srcdir)/src/openvpn/win32-util=2Ec \
 	$(to=
p_srcdir)/src/openvpn/session_id=2Ec
 
+reliable_testdriver_CFLAGS  =3D \
+=
	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/ope=
nvpn \
+	@TEST_CFLAGS@
+reliable_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
+rel=
iable_testdriver_SOURCES =3D test_reliable=2Ec \
+	mock_msg=2Ec mock_msg=2E=
h test_common=2Eh \
+	mock_get_random=2Ec \
+	$(top_srcdir)/src/openvpn/buf=
fer=2Ec \
+	$(top_srcdir)/src/openvpn/otime=2Ec \
+	$(top_srcdir)/src/openv=
pn/packet_id=2Ec \
+	$(top_srcdir)/src/openvpn/platform=2Ec \
+	$(top_srcdi=
r)/src/openvpn/reliable=2Ec \
+	$(top_srcdir)/src/openvpn/win32-util=2Ec \
=
+	$(top_srcdir)/src/openvpn/session_id=2Ec
+
 pkt_testdriver_CFLAGS  =3D \
=
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/op=
envpn \
 	@TEST_CFLAGS@
diff --git a/tests/unit_tests/openvpn/test_reliable=
=2Ec b/tests/unit_tests/openvpn/test_reliable=2Ec
new file mode 100644
inde=
x 0000000=2E=2Efa85906
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_re=
liable=2Ec
@@ -0,0 +1,193 @@
+/*
+ *  OpenVPN -- An application to securely=
 tunnel IP networks
+ *             over a single UDP port, with support fo=
r SSL/TLS-based
+ *             session authentication and key exchange,
+ =
*             packet encryption, packet authentication, and
+ *            =
 packet compression=2E
+ *
+ *  Copyright (C) 2026 OpenVPN Inc <sales@openv=
pn=2Enet>
+ *
+ *  This program is free software; you can redistribute it a=
nd/or modify
+ *  it under the terms of the GNU General Public License vers=
ion 2
+ *  as published by the Free Software Foundation=2E
+ *
+ *  This pr=
ogram is distributed in the hope that it will be useful,
+ *  but WITHOUT A=
NY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or F=
ITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License=
 for more details=2E
+ *
+ *  You should have received a copy of the GNU Ge=
neral Public License
+ *  along with this program (see the file COPYING inc=
luded with this
+ *  distribution); if not, see <https://www=2Egnu=2Eorg/li=
censes/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+=
#include "syshead=2Eh"
+
+#include <stdarg=2Eh>
+#include <stddef=2Eh>
+#in=
clude <setjmp=2Eh>
+#include <cmocka=2Eh>
+
+#include "reliable=2Eh"
+#incl=
ude "test_common=2Eh"
+
+/* The fix keeps the timeout well below this; the =
broken code grows past it=2E
+ * A plain number, so the test builds with or=
 without the fix=2E */
+#define SANE_TIMEOUT_BOUND (10 * 1000 * 1000)
+
+st=
atic struct reliable *
+test_reliable_new(void)
+{
+    struct reliable *re=
l =3D malloc(sizeof(struct reliable));
+    assert_non_null(rel);
+    /* r=
eliable_init() zeroes everything, so each test only sets the
+     * fields=
 it actually needs=2E */
+    reliable_init(rel, 100, 50, 8, false);
+    r=
el->initial_timeout =3D 2;
+    return rel;
+}
+
+/*
+ * Each retransmit do=
ubles the timeout=2E If a peer keeps forcing retransmits,
+ * the broken co=
de doubles it forever: after about 30 rounds it overflows and
+ * turns zer=
o or negative, and then the packet is resent nonstop (the flood)=2E
+ * The=
 fix caps the doubling=2E This test forces many retransmits and checks the
=
+ * timeout never overflows or grows without limit=2E
+ */
+static void
+te=
st_reliable_backoff_is_bounded(void **state)
+{
+    (void)state;
+    now =
=3D 1000;
+
+    struct reliable *rel =3D test_reliable_new();
+
+    struc=
t reliable_entry *e =3D &rel->array[0];
+    e->active =3D true;
+    e->pa=
cket_id =3D 1;
+    e->timeout =3D rel->initial_timeout;
+    rel->packet_i=
d =3D 2;
+
+    for (int i =3D 0; i < 40; ++i)
+    {
+        /* make the =
packet due for a fast retransmit */
+        e->n_acks =3D N_ACK_RETRANSMIT=
;
+
+        int opcode;
+        struct buffer *buf =3D reliable_send(rel,=
 &opcode);
+        /* our one active packet is the one picked to send */
+=
        assert_ptr_equal(buf, &e->buf);
+
+        /* a zero or negative ti=
meout would resend with no delay (the flood) */
+        assert_true(e->tim=
eout > 0);
+        /* the timeout must stop growing, not double forever */=

+        assert_true(e->timeout <=3D SANE_TIMEOUT_BOUND);
+    }
+
+    re=
liable_free(rel);
+}
+
+/*
+ * An ACK should only count if it is for a pack=
et we actually sent=2E If the
+ * broken code accepts ACKs for packets that=
 were never sent, a peer can force
+ * early retransmits at will (which the=
n feeds the timeout overflow above)=2E
+ * These two cases send such bogus =
ACKs and check they are ignored=2E
+ */
+static void
+test_reliable_purge_i=
gnores_forged_acks(void **state)
+{
+    (void)state;
+
+    /* Case (a): a=
n ACK for pid 0x40000000, which we never sent (we only sent
+     * 0 and 1=
)=2E The old "e->packet_id < pid" check treats it as newer and
+     * coun=
ts it=2E It should be ignored=2E */
+    {
+        struct reliable *rel =
=3D test_reliable_new();
+        struct reliable_entry *e =3D &rel->array[=
0];
+        e->active =3D true;
+        e->packet_id =3D 1;
+        rel-=
>packet_id =3D 2; /* only pids 0 and 1 were ever sent */
+
+        struct =
reliable_ack ack =3D { =2Elen =3D 1, =2Epacket_id =3D { 0x40000000 } };
+  =
      reliable_send_purge(rel, &ack);
+
+        /* the bogus ACK must not =
be counted */
+        assert_int_equal(e->n_acks, 0);
+        /* and must=
 not drop our real packet */
+        assert_true(e->active);
+        reli=
able_free(rel);
+    }
+
+    /* Case (b): an ACK for pid 0xFFFFFFFF=2E It =
is a big number, so a plain "<"
+     * thinks it is newer than our pid 1=
=2E But ids wrap around, and 0xFFFFFFFF
+     * is really older than 1, so =
it should be ignored=2E */
+    {
+        struct reliable *rel =3D test_re=
liable_new();
+        struct reliable_entry *e =3D &rel->array[0];
+      =
  e->active =3D true;
+        e->packet_id =3D 1;
+        rel->packet_id =
=3D 2;
+
+        struct reliable_ack ack =3D { =2Elen =3D 1, =2Epacket_id =
=3D { 0xFFFFFFFF } };
+        reliable_send_purge(rel, &ack);
+
+        /=
* the bogus ACK must not be counted */
+        assert_int_equal(e->n_acks,=
 0);
+        /* and must not drop our real packet */
+        assert_true(=
e->active);
+        reliable_free(rel);
+    }
+}
+
+/*
+ * Sanity check: =
a real ACK must still work=2E Acknowledging a higher packet
+ * should drop=
 that packet and count once towards resending the older one=2E
+ * The fix =
must not break this=2E
+ */
+static void
+test_reliable_purge_legitimate_ac=
k(void **state)
+{
+    (void)state;
+
+    struct reliable *rel =3D test_r=
eliable_new();
+
+    struct reliable_entry *e0 =3D &rel->array[0];
+    e0=
->active =3D true;
+    e0->packet_id =3D 1;
+
+    struct reliable_entry *=
e1 =3D &rel->array[1];
+    e1->active =3D true;
+    e1->packet_id =3D 2;
=
+
+    rel->packet_id =3D 3; /* pids 0,1,2 sent; 1 and 2 still waiting */
+=

+    struct reliable_ack ack =3D { =2Elen =3D 1, =2Epacket_id =3D { 2 } };=

+    reliable_send_purge(rel, &ack);
+
+    /* packet 2 was acked, so it i=
s dropped */
+    assert_false(e1->active);
+    /* packet 1 is older, so i=
t gets one ACK towards an early resend */
+    assert_int_equal(e0->n_acks,=
 1);
+    /* packet 1 was not acked, so it stays */
+    assert_true(e0->ac=
tive);
+
+    reliable_free(rel);
+}
+
+int
+main(void)
+{
+    openvpn_uni=
t_test_setup();
+
+    const struct CMUnitTest tests[] =3D {
+        cmock=
a_unit_test(test_reliable_backoff_is_bounded),
+        cmocka_unit_test(te=
st_reliable_purge_ignores_forged_acks),
+        cmocka_unit_test(test_reli=
able_purge_legitimate_ack),
+    };
+
+    return cmocka_run_group_tests_na=
me("reliable tests", tests, NULL, NULL);
+}

-- 
To view, visit http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1894?usp=3Demail
To unsubscribe, or for help=
 writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: =
master
Gerrit-Change-Id: I3c6ad247614fb204a279b73e98f8c4704e16da2a
Gerrit-C=
hange-Number: 1894
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert@greenie=2Em=
uc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC:=
 openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: =
plaisthos <arne-openvpn@rfc2549=2Eorg>

--VGNEQ77eZ7g=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>cron2 would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1894?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">re=
liable: add unit tests for ACK and backoff DoS hardening<br><br>Add regress=
ion coverage for the reliability-layer denial-of-service fix:<br><br> - the=
 retransmission timeout must stay positive and bounded no matter how<br>   =
often the fast-retransmit path is forced, so it can no longer overflow;<br>=
 - reliable_send_purge() must ignore ACKs for packet IDs that could never<b=
r>   have been in flight (out of the send window, or wrapped-around), so a<=
br>   peer cannot inflate n_acks and force early retransmits;<br> - a legit=
imate ACK for a real higher packet ID still removes that entry<br>   and co=
unts towards fast retransmit (positive control)=2E<br><br>These tests fail =
on the unfixed code and pass with the fix=2E<br><br>Signed-off-by: Lev Stip=
akov &lt;lev@openvpn=2Enet&gt;<br>Change-Id: I3c6ad247614fb204a279b73e98f8c=
4704e16da2a<br>---<br>M CMakeLists=2Etxt<br>M tests/unit_tests/openvpn/Make=
file=2Eam<br>A tests/unit_tests/openvpn/test_reliable=2Ec<br>3 files change=
d, 218 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/94/1894/1</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index 6eb5954=
=2E=2E429f143 100644</span><br><span>--- a/CMakeLists=2Etxt</span><br><span=
>+++ b/CMakeLists=2Etxt</span><br><span>@@ -680,6 +680,7 @@</span><br><span=
>         &quot;test_options_parse&quot;</span><br><span>         &quot;tes=
t_packet_id&quot;</span><br><span>         &quot;test_pkt&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        &quot;test_reliable&quo=
t;</span><br><span>         &quot;test_provider&quot;</span><br><span>     =
    &quot;test_socket&quot;</span><br><span>         &quot;test_ssl&quot;</=
span><br><span>@@ -881,6 +882,14 @@</span><br><span>         src/openvpn/se=
ssion_id=2Ec</span><br><span>         )</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    target_sources(test_reliable PRIV=
ATE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tests/un=
it_tests/openvpn/mock_get_random=2Ec</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        src/openvpn/otime=2Ec</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        src/openvpn/packet_id=2Ec</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/reliable=2Ec</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/s=
ession_id=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  )</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
>     target_sources(test_pkt PRIVATE</span><br><span>         tests/unit_t=
ests/openvpn/mock_win32_execve=2Ec</span><br><span>         src/openvpn/arg=
v=2Ec</span><br><span>diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b=
/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>index 5954902=2E=2E=
44614ae 100644</span><br><span>--- a/tests/unit_tests/openvpn/Makefile=2Eam=
</span><br><span>+++ b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><sp=
an>@@ -17,6 +17,7 @@</span><br><span> 	options_parse_testdriver \</span><br=
><span> 	packet_id_testdriver \</span><br><span> 	pkt_testdriver \</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+	reliable_testdriver \</span=
><br><span> 	provider_testdriver \</span><br><span> 	push_update_msg_testdr=
iver \</span><br><span> 	socket_testdriver \</span><br><span>@@ -153,6 +154=
,21 @@</span><br><span> 	$(top_srcdir)/src/openvpn/win32-util=2Ec \</span><=
br><span> 	$(top_srcdir)/src/openvpn/session_id=2Ec</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+reliable_testdriver_CFLAG=
S  =3D \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	-I$(top_sr=
cdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+	@TEST_CFLAGS@</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+reliable_testdriver_LDFLAGS =
=3D @TEST_LDFLAGS@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+r=
eliable_testdriver_SOURCES =3D test_reliable=2Ec \</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+	mock_msg=2Ec mock_msg=2Eh test_common=2Eh \=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_get_random=2E=
c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/s=
rc/openvpn/buffer=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+	$(top_srcdir)/src/openvpn/otime=2Ec \</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/packet_id=2Ec \</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/pl=
atform=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_=
srcdir)/src/openvpn/reliable=2Ec \</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+	$(top_srcdir)/src/openvpn/win32-util=2Ec \</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/session_i=
d=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an> pkt_testdriver_CFLAGS  =3D \</span><br><span> 	-I$(top_srcdir)/include =
-I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \</span><br><span> 	=
@TEST_CFLAGS@</span><br><span>diff --git a/tests/unit_tests/openvpn/test_re=
liable=2Ec b/tests/unit_tests/openvpn/test_reliable=2Ec</span><br><span>new=
 file mode 100644</span><br><span>index 0000000=2E=2Efa85906</span><br><spa=
n>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/test_reliabl=
e=2Ec</span><br><span>@@ -0,0 +1,193 @@</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  OpenVPN -- An application to securely tunnel IP networks</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *             over a single UD=
P port, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *             session authentication and key exchange,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packe=
t encryption, packet authentication, and</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *             packet compression=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  Copyright (C) 2026 OpenVPN Inc &lt;sales@openvpn=
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
 Public License</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
along with this program (see the file COPYING included with this</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  distribution); if not, see=
 &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HA=
VE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include=
 &quot;config=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdarg=2Eh&gt;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stddef=2Eh&gt=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;setjm=
p=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &=
lt;cmocka=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;reliab=
le=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#includ=
e &quot;test_common=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* The fi=
x keeps the timeout well below this; the broken code grows past it=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * A plain number, so the=
 test builds with or without the fix=2E */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define SANE_TIMEOUT_BOUND (10 * 1000 * 1000)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static struct reliable *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+test_reliable_new(void)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct reliable *rel =3D malloc(sizeof(struct reli=
able));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_n=
on_null(rel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
 reliable_init() zeroes everything, so each test only sets the</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     * fields it actually needs=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    reliable_=
init(rel, 100, 50, 8, false);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    rel-&gt;initial_timeout =3D 2;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    return rel;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * Each retransmit doubles the ti=
meout=2E If a peer keeps forcing retransmits,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * the broken code doubles it forever: after abou=
t 30 rounds it overflows and</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * turns zero or negative, and then the packet is resent nonstop (=
the flood)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The=
 fix caps the doubling=2E This test forces many retransmits and checks the<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * timeout never ove=
rflows or grows without limit=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_reliab=
le_backoff_is_bounded(void **state)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  (void)state;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    n=
ow =3D 1000;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct reliable *rel =
=3D test_reliable_new();</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct rel=
iable_entry *e =3D &amp;rel-&gt;array[0];</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    e-&gt;active =3D true;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    e-&gt;packet_id =3D 1;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    e-&gt;timeout =3D rel-&gt;initial_t=
imeout;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rel-&gt;=
packet_id =3D 2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; =
i &lt; 40; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* make th=
e packet due for a fast retransmit */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        e-&gt;n_acks =3D N_ACK_RETRANSMIT;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        int opcode;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        struct buffer *buf =3D reliable_send(rel, &am=
p;opcode);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /=
* our one active packet is the one picked to send */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        assert_ptr_equal(buf, &amp;e-&gt;=
buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        /* a zero or negative tim=
eout would resend with no delay (the flood) */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        assert_true(e-&gt;timeout &gt; 0);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* the timeout mu=
st stop growing, not double forever */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        assert_true(e-&gt;timeout &lt;=3D SANE_TIMEOUT_B=
OUND);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    reliable_free(rel);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * An ACK should onl=
y count if it is for a packet we actually sent=2E If the</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * broken code accepts ACKs for packet=
s that were never sent, a peer can force</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * early retransmits at will (which then feeds the tim=
eout overflow above)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * These two cases send such bogus ACKs and check they are ignored=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+test_reliable_purge_ignores_forged_acks(void =
**state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    (void)state;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* Case (a): an ACK for pid 0x40000000, which w=
e never sent (we only sent</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+     * 0 and 1)=2E The old &quot;e-&gt;packet_id &lt; pid&quot; chec=
k treats it as newer and</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     * counts it=2E It should be ignored=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        struct reliable *rel =3D test_reliable_new();</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct reliab=
le_entry *e =3D &amp;rel-&gt;array[0];</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        e-&gt;active =3D true;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        e-&gt;packet_id =3D 1;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        rel-&gt;packet_id =3D 2; /=
* only pids 0 and 1 were ever sent */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       struct reliable_ack ack =3D { =2Elen =3D 1, =2Epacket_id =3D { 0x400=
00000 } };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
eliable_send_purge(rel, &amp;ack);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    /* the bogus ACK must not be counted */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        assert_int_equal(e-&gt;n_acks, 0);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        /* and must not drop=
 our real packet */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        assert_true(e-&gt;active);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        reliable_free(rel);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Cas=
e (b): an ACK for pid 0xFFFFFFFF=2E It is a big number, so a plain &quot;&l=
t;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * thin=
ks it is newer than our pid 1=2E But ids wrap around, and 0xFFFFFFFF</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * is really older tha=
n 1, so it should be ignored=2E */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        struct reliable *rel =3D test_reliable_new();</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        struct reliable_entry *e =3D &am=
p;rel-&gt;array[0];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        e-&gt;active =3D true;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        e-&gt;packet_id =3D 1;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        rel-&gt;packet_id =3D 2;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        struct reliable_ack ack =3D { =2Elen =3D 1, =2Epack=
et_id =3D { 0xFFFFFFFF } };</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        reliable_send_purge(rel, &amp;ack);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        /* the bogus ACK must not be counted */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        assert_int_equal(e-&gt;n=
_acks, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /=
* and must not drop our real packet */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        assert_true(e-&gt;active);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        reliable_free(rel);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * Sanity check: a real AC=
K must still work=2E Acknowledging a higher packet</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * should drop that packet and count once to=
wards resending the older one=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * The fix must not break this=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+test_reliable_purge_legitimate_ack(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    (void)state;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct reliable *rel =3D test_reliable_new();</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct reliable_entry *e0 =3D &amp;rel-&gt;array[0];</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    e0-&gt;active =3D true;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    e0-&gt;packet_id =3D =
1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct reliable_entry *e1 =3D &a=
mp;rel-&gt;array[1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    e1-&gt;active =3D true;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    e1-&gt;packet_id =3D 2;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  rel-&gt;packet_id =3D 3; /* pids 0,1,2 sent; 1 and 2 still waiting */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct reliable_ack ack =3D { =2Elen =
=3D 1, =2Epacket_id =3D { 2 } };</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    reliable_send_purge(rel, &amp;ack);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* packet 2 was acked, so it is dropped */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_false(e1-&gt;active);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* packet 1 is o=
lder, so it gets one ACK towards an early resend */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(e0-&gt;n_acks, 1);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* packet 1 was n=
ot acked, so it stays */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_true(e0-&gt;active);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  reliable_free(rel);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+main(void)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 openvpn_unit_test_setup();</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const s=
truct CMUnitTest tests[] =3D {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        cmocka_unit_test(test_reliable_backoff_is_bounded),</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test=
(test_reliable_purge_ignores_forged_acks),</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        cmocka_unit_test(test_reliable_purge_legitim=
ate_ack),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return cmocka_run_group_tests_name(&q=
uot;reliable tests&quot;, tests, NULL, NULL);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span></span><br></pre><p>To view, vi=
sit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1894?usp=3Demail">=
change 1894</a>=2E To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1894?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div st=
yle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:=
none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Id: I3c6ad247614fb204a279b73e98f8c4704e16da2a </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Number: 1894 </div>
<div style=3D"display:none"> G=
errit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &=
lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefor=
ge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaistho=
s &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--VGNEQ77eZ7g=--


--===============5890312007048269393==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5890312007048269393==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5890312007048269393==--

