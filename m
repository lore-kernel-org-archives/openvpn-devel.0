Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99970C43327
	for <openvpn-devel@archiver.kernel.org>; Thu,  2 Jul 2026 12:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CjErc5YJeC5KTMNSQ1CN/27Y6M9lxyYBFYERifc1UxA=; b=iEVoXN9dIaw3AR5GUBUnbRcNxr
	oAHAuud5aSPvh/jvmeNG7pKCfezL0NadayMsELCdWz/9/98HIRgVaS/uVE6pbh41J9z+mSqndFm2w
	DuFaa5XsG+6X+i2l8Ygd+SIE0bDCmWytYPI1EtsuLyvtC2wg6z+soxopUhLEKkyBPR+s=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wfGZa-0002Vt-Ek;
	Thu, 02 Jul 2026 12:31:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wfGZD-0002VP-US
 for openvpn-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 12:30:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=GRVZq6udrKr7R5chJ4Jg+lls7FBnBanGUUIOyPpQMi0=; b=V+zQ4XKdm7n2O4oFRZHMbZcdMI
 AQKTmbBoH1QlWctJ6uX+feUJN9I4sJ3bitxGPdsNntJUwb2tEZOUJ8uQNG7mrs3CYqM1uNNIr7PVy
 y8Cy0n7Jb8FrsJJ+WKsuDGu3XB05xtw6C0LAQE8VFczZ7xfHFQ9B08OTfhvB9W4hHvPk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=GRVZq6udrKr7R5chJ4Jg+lls7FBnBanGUUIOyPpQMi0=; b=f
 ud/rZIDgA7fSudbd+zl/QeRgBEJduNMK/Xig3D7XYyvdtHNTKX4BRaFeRGU4WugEglpOy8ec0YvIS
 LdlR7qIVX+liZj9CUOoHQj4VHOFOgd0DHpvA24tXU4UZXXJA99eqiXkeOAxBWHaGECQkJ3B9stdRH
 OFZxHZ2/APWhcn+U=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wfGZA-0006k2-Ht for openvpn-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 12:30:56 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-493c55d5c7aso6802535e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 02 Jul 2026 05:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782995441; x=1783600241; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GRVZq6udrKr7R5chJ4Jg+lls7FBnBanGUUIOyPpQMi0=;
 b=RATCn77U60OSSiAbaMPNZDfhs2matJR/fIC4We4MFGoTk3VKc4TFZujBiQw6nLXKVd
 pMk5xIwf9kEWoG547A+WLXvvH8y0mM9+3KKzEgOwhsO0oCS+wPmPTTPv5MbCAoMS0oNy
 Ndz3r3oifMVZkdD7tasZMKSqFHJMxUwDUswjmdXVVcswOREp0ovICea88s+VQepYHNuM
 0S/6rYSadoh+cnsM90GjZAiABf6YsjMsjYf1NMnmwMOTpYOP4IlGFaTLSbnnYs4Kfy2c
 otMMXwx/6bxsIdhKBvN7E2ptdWOb5UC6iiNoWYLnXn+FcwpHSAK4vWws1HY8845foWZj
 N80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782995441; x=1783600241;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GRVZq6udrKr7R5chJ4Jg+lls7FBnBanGUUIOyPpQMi0=;
 b=YZARl8dkYwJUtLBFfYsRDfNHSe+I4vuChiVzvGJrxKvinWssNjIqqki7gsCSSuy8hA
 6eygHjOjt6ppR4qOKhByrqxEXpuRe9DSh27mZ3AfA/jd8kkViYmIzVpCfYHkqLVHEK6j
 BYLGJWymtxDc85CYsgyrL6CHLxpD3Hdd1qyE33OOBSXodDNzXSago6pX5aTfLYES2nhG
 4Oe8OPqHOKz4K9fwL+FXwlfRxGi0EhhG8qPzTU0JbTrc2q4dXJegF+w3XW4YsZUtycl0
 ZA1L0a0tvdUmJbMDIo6MtcbJsJFZz1DV3lWmJehH9QizdX9qOqrPe5dVoSGbCowC79Gn
 O9dQ==
X-Gm-Message-State: AOJu0Yxaw0dKETV65KP3ECYXr1YGEInoLQ/o1OHLv7P3yZae+th2svIF
 SRUlP/vtdzcLOyO90JeY/7zo0te9bmxhjA9gCe8RkbK4ECKRdJPttbp6eEEt/h6mw+6aUBVL3cU
 WvwvbeSlAHdZQ9zAl/krOrRQKm4uQZMUMjXV04fuGy5iprpKJ+0fnJ8XgK5d6rJ9HGkIo
X-Gm-Gg: AfdE7ckj+dSw9FL2qWbZn5hAn4dfsdtsnsYiwKbFMO8hRS7VBtr/j4CErgf5tqsEvwn
 pnJrZD81DJTCV9ellMlDJoCF3OZQF3Bw7lUxmxQ4E/1M/3+Qq715Tu3asmEuqQDNs2vlJZplG09
 b/tN6VMSBveCjvt08qaK2h71RcoEjG+ekqoNYbfmGQRRtbhneYIx9nHxgAtVxus5Kisj20H8Qbi
 1nxMGHpNZkP4r6ByDH6NUPp8abKlHLrSux6DQhqw0rUS3+6mgyxVQK6YYYr5q0rx65CusOZsQMS
 9R0L0WhnCYLre5kJNzOwO5npQkDiAxvisi9MHCgF8E+3w+GLGw9BSE2rjjBHwdrVwu5ygzYk0po
 sQV6vXj7NsDpSCY6x8DYGQu1L6lfa/A30Ig/fOcKlxnCZi51a9ms8SrB0rpsaBQv8DscVAYEV3c
 mC0n0huRIythZ/d998DCOMP0265ZwTOoZbqO8bfbvrkXfXaQlTrpdq6KNMt/ihkMIZb/uUzZ3Qo
 4npKfdiQm7J2XJT1127ln3f1E71oL/BsURzl8NGfqj4tnPF+o4IxR9m5JxJnTIu0aic7Gswoana
 hsM=
X-Received: by 2002:a05:600c:5247:b0:493:c378:18b3 with SMTP id
 5b1f17b1804b1-493c37818b6mr79034165e9.32.1782995441016; 
 Thu, 02 Jul 2026 05:30:41 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c635c41dsm87524675e9.5.2026.07.02.05.30.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 05:30:40 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 2 Jul 2026 12:30:33 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
X-Gerrit-Change-Number: 1741
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1741?usp=email>
X-Gerrit-Commit: 493aec58151150b86fbdc1665e116706b34dcfcf
In-Reply-To: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxYzhkMzAyYWM1N2M1NjAzZDYyMmE3YmUxNGJlMzY5NDM3Mzg4MjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b4872dc5819410ac50d3a0301e5a8a7b19000609-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wfGZA-0006k2-Ht
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Add control
 message TLV encoding (P_CONTROL_OOB_V1)
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7059788726403394588=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7059788726403394588==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="a3o5nEdJFeA="; charset=UTF-8

--a3o5nEdJFeA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa=2E

He=
llo flichtenheld, plaisthos, 

I'd like you to reexamine a change=2E Please=
 visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail

to =
look at the new patch set (#3)=2E

The following approvals got outdated and=
 were removed:
Code-Review-1 by flichtenheld


Change subject: oob: Add con=
trol message TLV encoding (P_CONTROL_OOB_V1)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Add control message TLV encoding (P_CO=
NTROL_OOB_V1)

Reserve opcode 12 (P_CONTROL_OOB_V1) for out-of-band control=
 messages and
add encoding/decoding for the SERVER_PROBE / PROBE_REPLY TLVs=
 used for
server latency checks:

  - probe_parameter (0x200): client times=
tamp + capability flags
  - probe_reply    (0x201): echoed session id, DNS-=
SRV style priority and
                            weight, connect_lifetime=
 and behaviour flags

Each TLV has a 4-byte header (15-bit type plus an opt=
ional flag, then a
16-bit value length)=2E Readers enforce the minimum valu=
e length and skip
trailing bytes they do not understand, so the format stay=
s forward
compatible and multi-TLV framing resynchronises=2E

P_LAST_OPCODE=
 is deliberately left at 11: opcode 12 is not yet accepted by
tls_pre_decry=
pt()=2E The legal-opcode range is widened together with the
receive handler=
 in a follow-up, which also wires oob=2Ec into the openvpn
build=2E For now=
 the codec is exercised only by the unit tests=2E

See the OOB control mess=
age section of the OpenVPN wire protocol
specification (openvpn-rfc PR #30)=
=2E

Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
Signed-off-by: Le=
v Stipakov <lev@openvpn=2Enet>
---
M CMakeLists=2Etxt
M src/openvpn/Makefil=
e=2Eam
A src/openvpn/oob=2Ec
A src/openvpn/oob=2Eh
M src/openvpn/ssl_pkt=2E=
h
M tests/unit_tests/openvpn/Makefile=2Eam
A tests/unit_tests/openvpn/test_=
oob=2Ec
7 files changed, 529 insertions(+), 0 deletions(-)


  git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/41/1741/3

diff --git =
a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 8de836a=2E=2E608e39e4 100644
--=
- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -518,6 +518,8 @@
     src/op=
envpn/multi_io=2Ec
     src/openvpn/occ=2Ec
     src/openvpn/occ=2Eh
+    s=
rc/openvpn/oob=2Ec
+    src/openvpn/oob=2Eh
     src/openvpn/openvpn=2Ec
  =
   src/openvpn/openvpn=2Eh
     src/openvpn/openvpn_win32_resources=2Erc
@@=
 -665,6 +667,7 @@
         "test_mbuf"
         "test_misc"
         "test_=
ncp"
+        "test_oob"
         "test_options_parse"
         "test_packe=
t_id"
         "test_pkt"
@@ -855,6 +858,12 @@
         src/openvpn/session=
_id=2Ec
         )
 
+    target_sources(test_oob PRIVATE
+        tests/un=
it_tests/openvpn/mock_get_random=2Ec
+        src/openvpn/oob=2Ec
+        =
src/openvpn/session_id=2Ec
+        )
+
     target_sources(test_pkt PRIVAT=
E
         tests/unit_tests/openvpn/mock_win32_execve=2Ec
         src/open=
vpn/argv=2Ec
diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=
=2Eam
index ff8cc54=2E=2Eb4b1b92 100644
--- a/src/openvpn/Makefile=2Eam
+++=
 b/src/openvpn/Makefile=2Eam
@@ -106,6 +106,7 @@
 	pkcs11=2Ec pkcs11=2Eh pk=
cs11_backend=2Eh \
 	pkcs11_openssl=2Ec \
 	pkcs11_mbedtls=2Ec \
+	oob=2Ec =
oob=2Eh \
 	openvpn=2Ec openvpn=2Eh \
 	options=2Ec options=2Eh \
 	options=
_util=2Ec options_util=2Eh \
diff --git a/src/openvpn/oob=2Ec b/src/openvpn=
/oob=2Ec
new file mode 100644
index 0000000=2E=2E9f123e2
--- /dev/null
+++ =
b/src/openvpn/oob=2Ec
@@ -0,0 +1,154 @@
+/*
+ *  OpenVPN -- An application =
to securely tunnel IP networks
+ *             over a single TCP/UDP port, =
with support for SSL/TLS-based
+ *             session authentication and k=
ey exchange,
+ *             packet encryption, packet authentication, and
=
+ *             packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 Open=
VPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free software; you c=
an redistribute it and/or modify
+ *  it under the terms of the GNU General=
 Public License version 2
+ *  as published by the Free Software Foundation=
=2E
+ *
+ *  This program is distributed in the hope that it will be useful=
,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  =
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU Ge=
neral Public License for more details=2E
+ *
+ *  You should have received =
a copy of the GNU General Public License along
+ *  with this program; if n=
ot, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H=

+#include "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include "oob=
=2Eh"
+
+/* Consume @p value_len bytes of TLV value, of which @p consumed h=
ave already
+ * been read, ignoring (skipping) any trailing bytes that this=
 version does not
+ * understand=2E Fails if fewer than @p consumed bytes w=
ere declared=2E */
+static bool
+oob_skip_trailing(struct buffer *buf, uint=
16_t value_len, int consumed)
+{
+    if (value_len < consumed)
+    {
+   =
     return false;
+    }
+    return buf_advance(buf, value_len - consumed=
);
+}
+
+bool
+oob_msg_write_header(struct buffer *buf, uint16_t msg_type)
=
+{
+    return buf_write_u16(buf, msg_type);
+}
+
+bool
+oob_msg_read_heade=
r(struct buffer *buf, uint16_t expected_msg_type)
+{
+    int msg_type =3D =
buf_read_u16(buf);
+    return msg_type >=3D 0 && (uint16_t)msg_type =3D=3D=
 expected_msg_type;
+}
+
+bool
+oob_tlv_write_header(struct buffer *buf, ui=
nt16_t type, bool optional, uint16_t value_len)
+{
+    uint16_t field =3D =
type & OOB_TLV_TYPE_MASK;
+    if (optional)
+    {
+        field |=3D OOB=
_TLV_OPTIONAL_FLAG;
+    }
+    return buf_write_u16(buf, field) && buf_wri=
te_u16(buf, value_len);
+}
+
+bool
+oob_tlv_read_header(struct buffer *buf,=
 uint16_t *type, bool *optional, uint16_t *value_len)
+{
+    int field =3D=
 buf_read_u16(buf);
+    if (field < 0)
+    {
+        return false;
+    =
}
+    int len =3D buf_read_u16(buf);
+    if (len < 0)
+    {
+        ret=
urn false;
+    }
+    *type =3D (uint16_t)(field & OOB_TLV_TYPE_MASK);
+  =
  *optional =3D (field & OOB_TLV_OPTIONAL_FLAG) !=3D 0;
+    *value_len =3D=
 (uint16_t)len;
+    return true;
+}
+
+bool
+oob_probe_parameter_write(str=
uct buffer *buf, const struct oob_probe_parameter *p)
+{
+    return oob_tl=
v_write_header(buf, OOB_TLV_PROBE_PARAMETER, false, OOB_PROBE_PARAMETER_LEN=
)
+           && buf_write_u64(buf, p->timestamp)
+           && buf_write_=
u32(buf, p->flags);
+}
+
+bool
+oob_probe_parameter_read(struct buffer *buf=
, struct oob_probe_parameter *p, uint16_t value_len)
+{
+    if (value_len =
< OOB_PROBE_PARAMETER_LEN)
+    {
+        return false;
+    }
+    bool o=
k =3D true;
+    p->timestamp =3D buf_read_u64(buf, &ok);
+    p->flags =3D=
 buf_read_u32(buf, &ok);
+    if (!ok)
+    {
+        return false;
+    }=

+    return oob_skip_trailing(buf, value_len, OOB_PROBE_PARAMETER_LEN);
+}=

+
+bool
+oob_probe_reply_write(struct buffer *buf, const struct oob_probe_=
reply *r)
+{
+    return oob_tlv_write_header(buf, OOB_TLV_PROBE_REPLY, fal=
se, OOB_PROBE_REPLY_LEN)
+           && session_id_write(&r->peer_session_i=
d, buf)
+           && buf_write_u16(buf, r->priority)
+           && buf_w=
rite_u16(buf, r->weight)
+           && buf_write_u16(buf, r->connect_lifet=
ime)
+           && buf_write_u32(buf, r->flags)
+           && buf_write_u=
16(buf, r->max_latency_diff);
+}
+
+bool
+oob_probe_reply_read(struct buffe=
r *buf, struct oob_probe_reply *r, uint16_t value_len)
+{
+    if (value_le=
n < OOB_PROBE_REPLY_LEN)
+    {
+        return false;
+    }
+    if (!ses=
sion_id_read(&r->peer_session_id, buf))
+    {
+        return false;
+    =
}
+    int priority =3D buf_read_u16(buf);
+    int weight =3D buf_read_u16=
(buf);
+    int connect_lifetime =3D buf_read_u16(buf);
+    if (priority <=
 0 || weight < 0 || connect_lifetime < 0)
+    {
+        return false;
+  =
  }
+    bool ok =3D true;
+    r->flags =3D buf_read_u32(buf, &ok);
+    i=
nt max_latency_diff =3D buf_read_u16(buf);
+    if (!ok || max_latency_diff=
 < 0)
+    {
+        return false;
+    }
+    r->priority =3D (uint16_t)p=
riority;
+    r->weight =3D (uint16_t)weight;
+    r->connect_lifetime =3D =
(uint16_t)connect_lifetime;
+    r->max_latency_diff =3D (uint16_t)max_late=
ncy_diff;
+    return oob_skip_trailing(buf, value_len, OOB_PROBE_REPLY_LEN=
);
+}
diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh
new file mode =
100644
index 0000000=2E=2Efa32c33
--- /dev/null
+++ b/src/openvpn/oob=2Eh
@=
@ -0,0 +1,149 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP n=
etworks
+ *             over a single TCP/UDP port, with support for SSL/TL=
S-based
+ *             session authentication and key exchange,
+ *       =
      packet encryption, packet authentication, and
+ *             packet =
compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=
=2Enet>
+ *
+ *  This program is free software; you can redistribute it and=
/or modify
+ *  it under the terms of the GNU General Public License versio=
n 2
+ *  as published by the Free Software Foundation=2E
+ *
+ *  This prog=
ram is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY=
 WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FIT=
NESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License f=
or more details=2E
+ *
+ *  You should have received a copy of the GNU Gene=
ral Public License along
+ *  with this program; if not, see <https://www=
=2Egnu=2Eorg/licenses/>=2E
+ */
+
+/**
+ * @file
+ * Encoding/decoding of o=
ut-of-band (P_CONTROL_OOB_V1) control messages=2E
+ *
+ * An OOB message pa=
yload starts with a 16-bit message type (the 0x1xx space:
+ * SERVER_PROBE,=
 PROBE_REPLY, =2E=2E=2E) followed by a sequence of TLV entries=2E
+ *
+ * E=
ach TLV starts with a 4-byte header: a 16-bit field whose most significant
=
+ * bit is the "optional" flag and whose remaining 15 bits are the type (th=
e
+ * 0x2xx space), followed by a 16-bit length giving the size of the valu=
e that
+ * follows the header=2E
+ *
+ * This slice implements the SERVER_P=
ROBE / PROBE_REPLY pair used for server
+ * latency checks=2E Other message=
/TLV types are added as the feature grows=2E
+ */
+
+#ifndef OOB_H
+#define=
 OOB_H
+
+#include "buffer=2Eh"
+#include "session_id=2Eh"
+
+/* OOB messag=
e types: the 16-bit value at the start of an OOB payload, before
+ * its TL=
V entries=2E Distinct from the TLV-type space (0x2xx); see the "Messages"
+=
 * table in the OOB section of the wire protocol spec=2E */
+#define OOB_MS=
G_SERVER_PROBE 0x100
+#define OOB_MSG_PROBE_REPLY  0x101
+
+/* TLV header b=
it layout of the first 16-bit field */
+#define OOB_TLV_OPTIONAL_FLAG 0x800=
0
+#define OOB_TLV_TYPE_MASK     0x7fff
+
+/* TLV types (see the OOB contro=
l message section of the wire protocol spec) */
+#define OOB_TLV_PROBE_PARA=
METER 0x200
+#define OOB_TLV_PROBE_REPLY     0x201
+
+/* Minimum on-wire va=
lue length (excluding the 4-byte TLV header) of each TLV=2E
+ * The value m=
ay be longer for forward compatibility; trailing bytes that are
+ * not und=
erstood are ignored on read=2E */
+#define OOB_PROBE_PARAMETER_LEN 12
+#def=
ine OOB_PROBE_REPLY_LEN     20
+
+/* probe parameter TLV (sent by the clien=
t in a SERVER_PROBE) */
+struct oob_probe_parameter
+{
+    uint64_t timest=
amp; /**< client clock as a UNIX timestamp */
+    uint32_t flags;     /**<=
 client capability flags, currently must be 0 */
+};
+
+/* probe reply TLV =
(sent by the server in a PROBE_REPLY) */
+struct oob_probe_reply
+{
+    st=
ruct session_id peer_session_id; /**< echoes the session id of the request =
*/
+    uint16_t priority;                 /**< DNS-SRV style priority (low=
er is preferred) */
+    uint16_t weight;                   /**< DNS-SRV st=
yle weight */
+    uint16_t connect_lifetime;         /**< seconds the prob=
e stays valid as a handshake shortcut */
+    uint32_t flags;              =
      /**< server behaviour flags */
+    uint16_t max_latency_diff;       =
  /**< advertised candidate-band margin in ms;
+                           =
             *   0 means "defer to the client's setting" */
+};
+
+/**
+ * =
Write an OOB message-type header (the 16-bit message type preceding the
+ *=
 TLVs) to @p buf=2E
+ *
+ * @return true on success, false if @p buf has in=
sufficient space=2E
+ */
+bool oob_msg_write_header(struct buffer *buf, uin=
t16_t msg_type);
+
+/**
+ * Read and verify an OOB message-type header from=
 @p buf, advancing past it=2E
+ *
+ * @param buf                buffer posi=
tioned at the OOB message payload
+ * @param expected_msg_type  the message=
 type the payload must carry
+ * @return true if a message type was read an=
d equals @p expected_msg_type,
+ *         false on a short buffer or a mis=
matching type=2E
+ */
+bool oob_msg_read_header(struct buffer *buf, uint16_=
t expected_msg_type);
+
+/**
+ * Write a TLV header (type + optional flag +=
 value length) to @p buf=2E
+ *
+ * @return true on success, false if @p bu=
f has insufficient space=2E
+ */
+bool oob_tlv_write_header(struct buffer *=
buf, uint16_t type, bool optional, uint16_t value_len);
+
+/**
+ * Read a T=
LV header from @p buf, advancing past it=2E
+ *
+ * @param buf        buffe=
r positioned at the TLV header
+ * @param type       set to the 15-bit TLV =
type
+ * @param optional   set to the value of the optional flag
+ * @param=
 value_len  set to the declared value length
+ * @return true on success, f=
alse if there are not enough bytes for a header=2E
+ */
+bool oob_tlv_read_=
header(struct buffer *buf, uint16_t *type, bool *optional, uint16_t *value_=
len);
+
+/**
+ * Write a complete probe parameter TLV (header + value) to @=
p buf=2E
+ */
+bool oob_probe_parameter_write(struct buffer *buf, const str=
uct oob_probe_parameter *p);
+
+/**
+ * Read a probe parameter TLV value of=
 @p value_len bytes from @p buf=2E
+ *
+ * The TLV header must already have=
 been consumed (e=2Eg=2E via
+ * oob_tlv_read_header())=2E @p value_len byt=
es are always consumed on success,
+ * including any trailing bytes beyond =
the fields understood here=2E
+ *
+ * @return true on success, false if @p =
value_len is too short or @p buf is
+ *         truncated=2E
+ */
+bool oob=
_probe_parameter_read(struct buffer *buf, struct oob_probe_parameter *p,
+ =
                             uint16_t value_len);
+
+/**
+ * Write a comple=
te probe reply TLV (header + value) to @p buf=2E
+ */
+bool oob_probe_reply=
_write(struct buffer *buf, const struct oob_probe_reply *r);
+
+/**
+ * Rea=
d a probe reply TLV value of @p value_len bytes from @p buf=2E See
+ * oob_=
probe_parameter_read() for the calling convention=2E
+ */
+bool oob_probe_r=
eply_read(struct buffer *buf, struct oob_probe_reply *r, uint16_t value_len=
);
+
+#endif /* OOB_H */
diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn=
/ssl_pkt=2Eh
index ac9d4be=2E=2E0dab524 100644
--- a/src/openvpn/ssl_pkt=2E=
h
+++ b/src/openvpn/ssl_pkt=2Eh
@@ -58,6 +58,17 @@
  * like P_CONTROL_HARD_=
RESET_CLIENT_V3 */
 #define P_CONTROL_WKC_V1 11
 
+/* Out-of-band control m=
essage that does not belong to an established
+ * control channel session (=
e=2Eg=2E a server probe)=2E Inherently unreliable:
+ * there is no protocol=
-level retransmission=2E
+ *
+ * NOTE: intentionally not yet included in th=
e P_FIRST_OPCODE=2E=2EP_LAST_OPCODE
+ * legal range=2E The range acts as an=
 acceptance gate in tls_pre_decrypt();
+ * widening it before an OOB receiv=
e handler exists would let OOB packets
+ * be misparsed as established-sess=
ion control packets=2E Bump P_LAST_OPCODE
+ * to 12 in the same change that=
 adds the handler=2E */
+#define P_CONTROL_OOB_V1 12
+
 /* define the range=
 of legal opcodes
  * Since we do no longer support key-method 1 we conside=
r
  * the v1 op codes invalid */
@@ -266,6 +277,9 @@
         case P_CONTRO=
L_WKC_V1:
             return "P_CONTROL_WKC_V1";
 
+        case P_CONTROL=
_OOB_V1:
+            return "P_CONTROL_OOB_V1";
+
         case P_ACK_V1:
=
             return "P_ACK_V1";
 
diff --git a/tests/unit_tests/openvpn/Mak=
efile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index 1128eb4=2E=2E7174=
aa8 100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_te=
sts/openvpn/Makefile=2Eam
@@ -14,6 +14,7 @@
 	ncp_testdriver \
 	mbuf_testd=
river \
 	misc_testdriver \
+	oob_testdriver \
 	options_parse_testdriver \=

 	packet_id_testdriver \
 	pkt_testdriver \
@@ -149,6 +150,19 @@
 	$(top_s=
rcdir)/src/openvpn/win32-util=2Ec \
 	$(top_srcdir)/src/openvpn/session_id=
=2Ec
 
+oob_testdriver_CFLAGS  =3D \
+	-I$(top_srcdir)/include -I$(top_srcd=
ir)/src/compat -I$(top_srcdir)/src/openvpn \
+	@TEST_CFLAGS@
+oob_testdrive=
r_LDFLAGS =3D @TEST_LDFLAGS@
+oob_testdriver_SOURCES =3D test_oob=2Ec \
+	m=
ock_msg=2Ec mock_msg=2Eh test_common=2Eh \
+	mock_get_random=2Ec \
+	$(top_=
srcdir)/src/openvpn/buffer=2Ec \
+	$(top_srcdir)/src/openvpn/oob=2Ec \
+	$(=
top_srcdir)/src/openvpn/platform=2Ec \
+	$(top_srcdir)/src/openvpn/session_=
id=2Ec \
+	$(top_srcdir)/src/openvpn/win32-util=2Ec
+
 pkt_testdriver_CFLAG=
S  =3D \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdi=
r)/src/openvpn \
 	@TEST_CFLAGS@
diff --git a/tests/unit_tests/openvpn/test=
_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec
new file mode 100644
index=
 0000000=2E=2E40dcaf9
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_oob=
=2Ec
@@ -0,0 +1,188 @@
+/*
+ *  OpenVPN -- An application to securely tunne=
l IP networks
+ *             over a single TCP/UDP port, with support for =
SSL/TLS-based
+ *             session authentication and key exchange,
+ * =
            packet encryption, packet authentication, and
+ *             p=
acket compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@op=
envpn=2Enet>
+ *
+ *  This program is free software; you can redistribute i=
t and/or modify
+ *  it under the terms of the GNU General Public License v=
ersion 2
+ *  as published by the Free Software Foundation=2E
+ *
+ *  This=
 program is distributed in the hope that it will be useful,
+ *  but WITHOU=
T ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY o=
r FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public Lice=
nse for more details=2E
+ *
+ *  You should have received a copy of the GNU=
 General Public License along
+ *  with this program; if not, see <https://=
www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "confi=
g=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include <stdarg=2Eh>
+#include=
 <stddef=2Eh>
+#include <setjmp=2Eh>
+#include <cmocka=2Eh>
+
+#include "oo=
b=2Eh"
+#include "test_common=2Eh"
+
+/* Write a probe parameter TLV and re=
ad it back; fields must survive the
+ * round trip and the whole buffer mus=
t be consumed=2E */
+static void
+test_probe_parameter_roundtrip(void **sta=
te)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D all=
oc_buf_gc(128, &gc);
+
+    const struct oob_probe_parameter in =3D {
+    =
    =2Etimestamp =3D 0x0123456789abcdefULL,
+        =2Eflags =3D 0,
+    }=
;
+    assert_true(oob_probe_parameter_write(&buf, &in));
+    /* header (4=
) + value (12) */
+    assert_int_equal(BLEN(&buf), 4 + OOB_PROBE_PARAMETER=
_LEN);
+
+    uint16_t type;
+    bool optional;
+    uint16_t value_len;
+=
    assert_true(oob_tlv_read_header(&buf, &type, &optional, &value_len));
+=
    assert_int_equal(type, OOB_TLV_PROBE_PARAMETER);
+    assert_false(opti=
onal);
+    assert_int_equal(value_len, OOB_PROBE_PARAMETER_LEN);
+
+    st=
ruct oob_probe_parameter out =3D { 0 };
+    assert_true(oob_probe_paramete=
r_read(&buf, &out, value_len));
+    assert_true(in=2Etimestamp =3D=3D out=
=2Etimestamp);
+    assert_int_equal(in=2Eflags, out=2Eflags);
+    assert_=
int_equal(BLEN(&buf), 0);
+
+    gc_free(&gc);
+}
+
+/* Write a probe reply=
 TLV and read it back=2E */
+static void
+test_probe_reply_roundtrip(void *=
*state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D=
 alloc_buf_gc(128, &gc);
+
+    struct oob_probe_reply in =3D {
+        =
=2Epriority =3D 10,
+        =2Eweight =3D 100,
+        =2Econnect_lifetim=
e =3D 30,
+        =2Eflags =3D 1,
+        =2Emax_latency_diff =3D 25,
+  =
  };
+    memcpy(in=2Epeer_session_id=2Eid, "ABCDEFGH", SID_SIZE);
+
+    a=
ssert_true(oob_probe_reply_write(&buf, &in));
+    assert_int_equal(BLEN(&b=
uf), 4 + OOB_PROBE_REPLY_LEN);
+
+    uint16_t type;
+    bool optional;
+ =
   uint16_t value_len;
+    assert_true(oob_tlv_read_header(&buf, &type, &o=
ptional, &value_len));
+    assert_int_equal(type, OOB_TLV_PROBE_REPLY);
+ =
   assert_int_equal(value_len, OOB_PROBE_REPLY_LEN);
+
+    struct oob_prob=
e_reply out =3D { 0 };
+    assert_true(oob_probe_reply_read(&buf, &out, va=
lue_len));
+    assert_memory_equal(in=2Epeer_session_id=2Eid, out=2Epeer_s=
ession_id=2Eid, SID_SIZE);
+    assert_int_equal(in=2Epriority, out=2Eprior=
ity);
+    assert_int_equal(in=2Eweight, out=2Eweight);
+    assert_int_equ=
al(in=2Econnect_lifetime, out=2Econnect_lifetime);
+    assert_int_equal(in=
=2Eflags, out=2Eflags);
+    assert_int_equal(in=2Emax_latency_diff, out=2E=
max_latency_diff);
+    assert_int_equal(BLEN(&buf), 0);
+
+    gc_free(&gc=
);
+}
+
+/* A TLV with a longer-than-known value must still parse: the know=
n fields are
+ * read and the trailing bytes are skipped (forward compatibi=
lity)=2E */
+static void
+test_probe_parameter_forward_compat(void **state)=

+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_=
buf_gc(128, &gc);
+
+    const uint16_t extended_len =3D OOB_PROBE_PARAMETE=
R_LEN + 4;
+    assert_true(oob_tlv_write_header(&buf, OOB_TLV_PROBE_PARAME=
TER, false, extended_len));
+    assert_true(buf_write_u32(&buf, 0));      =
    /* timestamp high */
+    assert_true(buf_write_u32(&buf, 0xdeadbeef));=
 /* timestamp low */
+    assert_true(buf_write_u32(&buf, 0));          /* =
flags */
+    assert_true(buf_write_u32(&buf, 0x11223344)); /* unknown trai=
ling field */
+
+    uint16_t type;
+    bool optional;
+    uint16_t value=
_len;
+    assert_true(oob_tlv_read_header(&buf, &type, &optional, &value_l=
en));
+    assert_int_equal(value_len, extended_len);
+
+    struct oob_pro=
be_parameter out =3D { 0 };
+    assert_true(oob_probe_parameter_read(&buf,=
 &out, value_len));
+    assert_true(out=2Etimestamp =3D=3D 0xdeadbeefULL);=

+    assert_int_equal(out=2Eflags, 0);
+    /* the unknown trailing field =
must have been consumed */
+    assert_int_equal(BLEN(&buf), 0);
+
+    gc_=
free(&gc);
+}
+
+/* A declared value length shorter than the mandatory mini=
mum must be rejected=2E */
+static void
+test_probe_parameter_too_short(voi=
d **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =
=3D alloc_buf_gc(128, &gc);
+
+    struct oob_probe_parameter out =3D { 0 }=
;
+    assert_false(oob_probe_parameter_read(&buf, &out, OOB_PROBE_PARAMETE=
R_LEN - 1));
+
+    gc_free(&gc);
+}
+
+/* Reading a header from a buffer t=
hat is too small must fail rather than read
+ * past the end=2E */
+static =
void
+test_tlv_header_truncated(void **state)
+{
+    struct gc_arena gc =
=3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    uin=
t16_t type;
+    bool optional;
+    uint16_t value_len;
+
+    /* empty bu=
ffer */
+    assert_false(oob_tlv_read_header(&buf, &type, &optional, &valu=
e_len));
+
+    /* only the type field present, no length */
+    assert_tr=
ue(buf_write_u16(&buf, OOB_TLV_PROBE_PARAMETER));
+    assert_false(oob_tlv=
_read_header(&buf, &type, &optional, &value_len));
+
+    gc_free(&gc);
+}
=
+
+int
+main(void)
+{
+    openvpn_unit_test_setup();
+    const struct CMU=
nitTest tests[] =3D {
+        cmocka_unit_test(test_probe_parameter_roundt=
rip),
+        cmocka_unit_test(test_probe_reply_roundtrip),
+        cmock=
a_unit_test(test_probe_parameter_forward_compat),
+        cmocka_unit_test=
(test_probe_parameter_too_short),
+        cmocka_unit_test(test_tlv_header=
_truncated),
+    };
+
+    return cmocka_run_group_tests_name("oob tests",=
 tests, NULL, NULL);
+}

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1741?usp=3Demail
To unsubscribe, or for help writing mail filter=
s, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chan=
ge-Id: I1c8d302ac57c5603d622a7be14be369437388268
Gerrit-Change-Number: 1741=

Gerrit-PatchSet: 3
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Revi=
ewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Es=
ourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Attention: =
stipa <lstipakov@gmail=2Ecom>

--a3o5nEdJFeA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, stipa=2E </p>
<p>stipa <stro=
ng>uploaded patch set #3</strong> to this change=2E</p><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">View Change</a></p><p=
>The following approvals got outdated and were removed:
Code-Review-1 by fl=
ichtenheld</p><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">oob: Add control message TLV encoding (P_CONTRO=
L_OOB_V1)<br><br>Reserve opcode 12 (P_CONTROL_OOB_V1) for out-of-band contr=
ol messages and<br>add encoding/decoding for the SERVER_PROBE / PROBE_REPLY=
 TLVs used for<br>server latency checks:<br><br>  - probe_parameter (0x200)=
: client timestamp + capability flags<br>  - probe_reply    (0x201): echoed=
 session id, DNS-SRV style priority and<br>                            weig=
ht, connect_lifetime and behaviour flags<br><br>Each TLV has a 4-byte heade=
r (15-bit type plus an optional flag, then a<br>16-bit value length)=2E Rea=
ders enforce the minimum value length and skip<br>trailing bytes they do no=
t understand, so the format stays forward<br>compatible and multi-TLV frami=
ng resynchronises=2E<br><br>P_LAST_OPCODE is deliberately left at 11: opcod=
e 12 is not yet accepted by<br>tls_pre_decrypt()=2E The legal-opcode range =
is widened together with the<br>receive handler in a follow-up, which also =
wires oob=2Ec into the openvpn<br>build=2E For now the codec is exercised o=
nly by the unit tests=2E<br><br>See the OOB control message section of the =
OpenVPN wire protocol<br>specification (openvpn-rfc PR #30)=2E<br><br>Chang=
e-Id: I1c8d302ac57c5603d622a7be14be369437388268<br>Signed-off-by: Lev Stipa=
kov &lt;lev@openvpn=2Enet&gt;<br>---<br>M CMakeLists=2Etxt<br>M src/openvpn=
/Makefile=2Eam<br>A src/openvpn/oob=2Ec<br>A src/openvpn/oob=2Eh<br>M src/o=
penvpn/ssl_pkt=2Eh<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>A tests/u=
nit_tests/openvpn/test_oob=2Ec<br>7 files changed, 529 insertions(+), 0 del=
etions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:=
29418/openvpn refs/changes/41/1741/3</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt =
b/CMakeLists=2Etxt</span><br><span>index 8de836a=2E=2E608e39e4 100644</span=
><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</s=
pan><br><span>@@ -518,6 +518,8 @@</span><br><span>     src/openvpn/multi_io=
=2Ec</span><br><span>     src/openvpn/occ=2Ec</span><br><span>     src/open=
vpn/occ=2Eh</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/=
openvpn/oob=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
src/openvpn/oob=2Eh</span><br><span>     src/openvpn/openvpn=2Ec</span><br>=
<span>     src/openvpn/openvpn=2Eh</span><br><span>     src/openvpn/openvpn=
_win32_resources=2Erc</span><br><span>@@ -665,6 +667,7 @@</span><br><span> =
        &quot;test_mbuf&quot;</span><br><span>         &quot;test_misc&quot=
;</span><br><span>         &quot;test_ncp&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        &quot;test_oob&quot;</span><br><span>  =
       &quot;test_options_parse&quot;</span><br><span>         &quot;test_p=
acket_id&quot;</span><br><span>         &quot;test_pkt&quot;</span><br><spa=
n>@@ -855,6 +858,12 @@</span><br><span>         src/openvpn/session_id=2Ec<=
/span><br><span>         )</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    target_sources(test_oob PRIVATE</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        tests/unit_tests/openvpn/m=
ock_get_random=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       src/openvpn/oob=2Ec</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        src/openvpn/session_id=2Ec</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        )</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span>     target_sources(test_pkt PRIVATE</span><br=
><span>         tests/unit_tests/openvpn/mock_win32_execve=2Ec</span><br><s=
pan>         src/openvpn/argv=2Ec</span><br><span>diff --git a/src/openvpn/=
Makefile=2Eam b/src/openvpn/Makefile=2Eam</span><br><span>index ff8cc54=2E=
=2Eb4b1b92 100644</span><br><span>--- a/src/openvpn/Makefile=2Eam</span><br=
><span>+++ b/src/openvpn/Makefile=2Eam</span><br><span>@@ -106,6 +106,7 @@<=
/span><br><span> 	pkcs11=2Ec pkcs11=2Eh pkcs11_backend=2Eh \</span><br><spa=
n> 	pkcs11_openssl=2Ec \</span><br><span> 	pkcs11_mbedtls=2Ec \</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+	oob=2Ec oob=2Eh \</span><br><s=
pan> 	openvpn=2Ec openvpn=2Eh \</span><br><span> 	options=2Ec options=2Eh \=
</span><br><span> 	options_util=2Ec options_util=2Eh \</span><br><span>diff=
 --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec</span><br><span>new file=
 mode 100644</span><br><span>index 0000000=2E=2E9f123e2</span><br><span>---=
 /dev/null</span><br><span>+++ b/src/openvpn/oob=2Ec</span><br><span>@@ -0,=
0 +1,154 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An applica=
tion to securely tunnel IP networks</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *             over a single TCP/UDP port, with support for=
 SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   =
          session authentication and key exchange,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *             packet encryption, packet aut=
hentication, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
            packet compression=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
 Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  This program is free software; you can redi=
stribute it and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  it under the terms of the GNU General Public License version 2</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by th=
e Free Software Foundation=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Thi=
s program is distributed in the hope that it will be useful,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; with=
out even the implied warranty of</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  Se=
e the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU Genera=
l Public License for more details=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  You should have received a copy of the GNU General Public License along=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this progr=
am; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#include &quot;config=2Eh&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quo=
t;syshead=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;oob=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/* Consume @p value_len byte=
s of TLV value, of which @p consumed have already</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * been read, ignoring (skipping) any trailin=
g bytes that this version does not</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * understand=2E Fails if fewer than @p consumed bytes were =
declared=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stati=
c bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_skip_trai=
ling(struct buffer *buf, uint16_t value_len, int consumed)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (value_len &lt; consumed)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return false;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    return buf_advance(buf, value_len - consumed);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_msg_write=
_header(struct buffer *buf, uint16_t msg_type)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    return buf_write_u16(buf, msg_type);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_msg_read_header(st=
ruct buffer *buf, uint16_t expected_msg_type)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    int msg_type =3D buf_read_u16(buf);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    return msg_type &gt;=3D 0 &amp;&amp; (uint1=
6_t)msg_type =3D=3D expected_msg_type;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+oob_tlv_write_header(struct buffe=
r *buf, uint16_t type, bool optional, uint16_t value_len)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    uint16_t field =3D type &amp; OOB_TLV_TYPE_MASK;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (optional)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        field |=3D OOB_TLV_OPTIONAL_FL=
AG;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return buf_write_u16(buf, =
field) &amp;&amp; buf_write_u16(buf, value_len);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_tlv_read_header(str=
uct buffer *buf, uint16_t *type, bool *optional, uint16_t *value_len)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int field =3D buf_read_u16(buf);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (field &lt; 0)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    int len =3D buf_read_u16(buf);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (len &lt; 0)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    *type =3D (uint16_t)(field &amp; OOB_TLV_TYPE_MASK);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    *optional =3D (fie=
ld &amp; OOB_TLV_OPTIONAL_FLAG) !=3D 0;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    *value_len =3D (uint16_t)len;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_parameter_w=
rite(struct buffer *buf, const struct oob_probe_parameter *p)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    return oob_tlv_write_header(buf, OOB_TLV_PROBE_=
PARAMETER, false, OOB_PROBE_PARAMETER_LEN)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u64(buf, p-&gt;times=
tamp)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           &am=
p;&amp; buf_write_u32(buf, p-&gt;flags);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_parameter_read(struct=
 buffer *buf, struct oob_probe_parameter *p, uint16_t value_len)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (value_len &lt; OOB_PROBE_PARAMETER_LEN)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    bool ok =3D true;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    p-&gt;timestamp =3D buf_read_u64(buf, &a=
mp;ok);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    p-&gt;fl=
ags =3D buf_read_u32(buf, &amp;ok);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (!ok)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return oob_sk=
ip_trailing(buf, value_len, OOB_PROBE_PARAMETER_LEN);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+boo=
l</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_reply_wr=
ite(struct buffer *buf, const struct oob_probe_reply *r)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    return oob_tlv_write_header(buf, OOB_TLV_PROBE_REPLY=
, false, OOB_PROBE_REPLY_LEN)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+           &amp;&amp; session_id_write(&amp;r-&gt;peer_session_id=
, buf)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           &a=
mp;&amp; buf_write_u16(buf, r-&gt;priority)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u16(buf, r-&gt;weig=
ht)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           &amp;=
&amp; buf_write_u16(buf, r-&gt;connect_lifetime)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u32(buf, r-&gt=
;flags)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           &=
amp;&amp; buf_write_u16(buf, r-&gt;max_latency_diff);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+boo=
l</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_reply_re=
ad(struct buffer *buf, struct oob_probe_reply *r, uint16_t value_len)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (value_len &lt; OOB_PROBE_REPLY_LE=
N)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!session_id_read(&amp;r-&gt;peer_=
session_id, buf))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return f=
alse;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    int priority =3D buf_rea=
d_u16(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int =
weight =3D buf_read_u16(buf);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    int connect_lifetime =3D buf_read_u16(buf);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (priority &lt; 0 || weight &lt=
; 0 || connect_lifetime &lt; 0)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool ok =
=3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r-&gt;=
flags =3D buf_read_u32(buf, &amp;ok);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    int max_latency_diff =3D buf_read_u16(buf);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (!ok || max_latency_di=
ff &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    r-&gt;priority =3D (uint16_t)pr=
iority;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r-&gt;we=
ight =3D (uint16_t)weight;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    r-&gt;connect_lifetime =3D (uint16_t)connect_lifetime;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    r-&gt;max_latency_diff =
=3D (uint16_t)max_latency_diff;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return oob_skip_trailing(buf, value_len, OOB_PROBE_REPLY_LE=
N);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n>diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh</span><br><span>ne=
w file mode 100644</span><br><span>index 0000000=2E=2Efa32c33</span><br><sp=
an>--- /dev/null</span><br><span>+++ b/src/openvpn/oob=2Eh</span><br><span>=
@@ -0,0 +1,149 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An a=
pplication to securely tunnel IP networks</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *             over a single TCP/UDP port, with suppo=
rt for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *             session authentication and key exchange,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption, pack=
et authentication, and</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *             packet compression=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; you ca=
n redistribute it and/or modify</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  it under the terms of the GNU General Public License versio=
n 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published=
 by the Free Software Foundation=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  This program is distributed in the hope that it will be useful,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY=
; without even the implied warranty of</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=
=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU=
 General Public License for more details=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  You should have received a copy of the GNU General Public Licens=
e along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with thi=
s program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Encoding/=
decoding of out-of-band (P_CONTROL_OOB_V1) control messages=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * An OOB message payload starts with a 16-bit me=
ssage type (the 0x1xx space:</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * SERVER_PROBE, PROBE_REPLY, =2E=2E=2E) followed by a sequence of=
 TLV entries=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Each TLV starts wi=
th a 4-byte header: a 16-bit field whose most significant</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * bit is the &quot;optional&quot; fl=
ag and whose remaining 15 bits are the type (the</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * 0x2xx space), followed by a 16-bit length g=
iving the size of the value that</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * follows the header=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * This slice implements the SERVER_PROBE / PROBE_REPLY pair used for serv=
er</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * latency checks=
=2E Other message/TLV types are added as the feature grows=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#ifndef OOB_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#define OOB_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;buffer=2E=
h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &qu=
ot;session_id=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* OOB message =
types: the 16-bit value at the start of an OOB payload, before</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * its TLV entries=2E Distinct f=
rom the TLV-type space (0x2xx); see the &quot;Messages&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * table in the OOB section of the=
 wire protocol spec=2E */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#define OOB_MSG_SERVER_PROBE 0x100</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#define OOB_MSG_PROBE_REPLY  0x101</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/* TLV header bit layout of the first 16-bit field */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OOB_TLV_OPTIONAL=
_FLAG 0x8000</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define=
 OOB_TLV_TYPE_MASK     0x7fff</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* TLV ty=
pes (see the OOB control message section of the wire protocol spec) */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OOB_TLV_PROBE_PA=
RAMETER 0x200</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defin=
e OOB_TLV_PROBE_REPLY     0x201</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Mini=
mum on-wire value length (excluding the 4-byte TLV header) of each TLV=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The value may be l=
onger for forward compatibility; trailing bytes that are</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * not understood are ignored on read=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OOB_P=
ROBE_PARAMETER_LEN 12</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#define OOB_PROBE_REPLY_LEN     20</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
 probe parameter TLV (sent by the client in a SERVER_PROBE) */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+struct oob_probe_parameter</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    uint64_t timestamp; /**&lt; client cl=
ock as a UNIX timestamp */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    uint32_t flags;     /**&lt; client capability flags, currently m=
ust be 0 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/* probe reply TLV (sent by the server in a =
PROBE_REPLY) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stru=
ct oob_probe_reply</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct session_=
id peer_session_id; /**&lt; echoes the session id of the request */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t priority;     =
            /**&lt; DNS-SRV style priority (lower is preferred) */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t weight;        =
           /**&lt; DNS-SRV style weight */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    uint16_t connect_lifetime;         /**&lt; secon=
ds the probe stays valid as a handshake shortcut */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    uint32_t flags;                    /*=
*&lt; server behaviour flags */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    uint16_t max_latency_diff;         /**&lt; advertised candi=
date-band margin in ms;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                                        *   0 means &quot;defer to the =
client&#39;s setting&quot; */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Write an OOB message-type header (the =
16-bit message type preceding the</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * TLVs) to @p buf=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @return true on success, false if @p buf has insufficient space=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool oob_msg_write_header(struct buffer *=
buf, uint16_t msg_type);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * Read and verify an OOB mess=
age-type header from @p buf, advancing past it=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @param buf                buffer positioned at the OOB mess=
age payload</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @para=
m expected_msg_type  the message type the payload must carry</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @return true if a message type =
was read and equals @p expected_msg_type,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *         false on a short buffer or a mismatching t=
ype=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+bool oob_msg_read_header(stru=
ct buffer *buf, uint16_t expected_msg_type);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Write a=
 TLV header (type + optional flag + value length) to @p buf=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @return true on success, false if @p buf has i=
nsufficient space=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool oob_tlv_wr=
ite_header(struct buffer *buf, uint16_t type, bool optional, uint16_t value=
_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * Read a TLV header from @p buf, advancing past=
 it=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf        buffer po=
sitioned at the TLV header</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * @param type       set to the 15-bit TLV type</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @param optional   set to the value of=
 the optional flag</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @param value_len  set to the declared value length</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @return true on success, false if ther=
e are not enough bytes for a header=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+bool oob_tlv_read_header(struct buffer *buf, uint16_t *type, bool *optio=
nal, uint16_t *value_len);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * Write a complete probe pa=
rameter TLV (header + value) to @p buf=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+bool oob_probe_parameter_write(struct buffer *buf, const struct oob_p=
robe_parameter *p);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * Read a probe parameter TLV value=
 of @p value_len bytes from @p buf=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * The TLV header must already have been consumed (e=2Eg=2E via</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * oob_tlv_read_header())=2E @=
p value_len bytes are always consumed on success,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * including any trailing bytes beyond the fi=
elds understood here=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return tr=
ue on success, false if @p value_len is too short or @p buf is</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *         truncated=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+bool oob_probe_parameter_read(struct buffer =
*buf, struct oob_probe_parameter *p,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                              uint16_t value_len);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * Write a complete probe reply TLV (header + value) to @p buf=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+bool oob_probe_reply_write(struc=
t buffer *buf, const struct oob_probe_reply *r);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Rea=
d a probe reply TLV value of @p value_len bytes from @p buf=2E See</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * oob_probe_parameter_read(=
) for the calling convention=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool=
 oob_probe_reply_read(struct buffer *buf, struct oob_probe_reply *r, uint16=
_t value_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* OOB_H */</span=
><br><span>diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh</=
span><br><span>index ac9d4be=2E=2E0dab524 100644</span><br><span>--- a/src/=
openvpn/ssl_pkt=2Eh</span><br><span>+++ b/src/openvpn/ssl_pkt=2Eh</span><br=
><span>@@ -58,6 +58,17 @@</span><br><span>  * like P_CONTROL_HARD_RESET_CLI=
ENT_V3 */</span><br><span> #define P_CONTROL_WKC_V1 11</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Out-of-band control=
 message that does not belong to an established</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * control channel session (e=2Eg=2E a server p=
robe)=2E Inherently unreliable:</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * there is no protocol-level retransmission=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * NOTE: intentionally not yet included in the P_FIR=
ST_OPCODE=2E=2EP_LAST_OPCODE</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * legal range=2E The range acts as an acceptance gate in tls_pre_=
decrypt();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * wideni=
ng it before an OOB receive handler exists would let OOB packets</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * be misparsed as established=
-session control packets=2E Bump P_LAST_OPCODE</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * to 12 in the same change that adds the handle=
r=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define P_CO=
NTROL_OOB_V1 12</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span> /* define the range of legal opcodes</span><br><span>  * Sinc=
e we do no longer support key-method 1 we consider</span><br><span>  * the =
v1 op codes invalid */</span><br><span>@@ -266,6 +277,9 @@</span><br><span>=
         case P_CONTROL_WKC_V1:</span><br><span>             return &quot;P=
_CONTROL_WKC_V1&quot;;</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        case P_CONTROL_OOB_V1:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            return &quot;P_CONTROL_OOB_V1=
&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span>         case P_ACK_V1:</span><br><span>             return &quot;P_AC=
K_V1&quot;;</span><br><span> </span><br><span>diff --git a/tests/unit_tests=
/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><=
span>index 1128eb4=2E=2E7174aa8 100644</span><br><span>--- a/tests/unit_tes=
ts/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn/Mak=
efile=2Eam</span><br><span>@@ -14,6 +14,7 @@</span><br><span> 	ncp_testdriv=
er \</span><br><span> 	mbuf_testdriver \</span><br><span> 	misc_testdriver =
\</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	oob_testdriver \<=
/span><br><span> 	options_parse_testdriver \</span><br><span> 	packet_id_te=
stdriver \</span><br><span> 	pkt_testdriver \</span><br><span>@@ -149,6 +15=
0,19 @@</span><br><span> 	$(top_srcdir)/src/openvpn/win32-util=2Ec \</span>=
<br><span> 	$(top_srcdir)/src/openvpn/session_id=2Ec</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_testdriver_CFLAGS  =
=3D \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	-I$(top_srcdi=
r)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+	@TEST_CFLAGS@</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+oob_testdriver_LDFLAGS =3D @TEST=
_LDFLAGS@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_testdr=
iver_SOURCES =3D test_oob=2Ec \</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+	mock_msg=2Ec mock_msg=2Eh test_common=2Eh \</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+	mock_get_random=2Ec \</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/buffer=
=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir=
)/src/openvpn/oob=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+	$(top_srcdir)/src/openvpn/platform=2Ec \</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/session_id=2Ec \</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvp=
n/win32-util=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span> pkt_testdriver_CFLAGS  =3D \</span><br><span> 	-I$(top_srcdi=
r)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \</span><=
br><span> 	@TEST_CFLAGS@</span><br><span>diff --git a/tests/unit_tests/open=
vpn/test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>ne=
w file mode 100644</span><br><span>index 0000000=2E=2E40dcaf9</span><br><sp=
an>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/test_oob=2E=
c</span><br><span>@@ -0,0 +1,188 @@</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  OpenVPN -- An application to securely tunnel IP networks</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP/UD=
P port, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *             session authentication and key exchange,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packe=
t encryption, packet authentication, and</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *             packet compression=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@open=
vpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is fre=
e software; you can redistribute it and/or modify</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General Pub=
lic License version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  as published by the Free Software Foundation=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  This program is distributed in the hope that it will b=
e useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WI=
THOUT ANY WARRANTY; without even the implied warranty of</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A P=
ARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  GNU General Public License for more details=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  You should have received a copy of the GNU Gene=
ral Public License along</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/license=
s/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#include &quot;syshead=2Eh&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#include &lt;stdarg=2Eh&gt;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#include &lt;stddef=2Eh&gt;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#include &lt;setjmp=2Eh&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#include &lt;cmocka=2Eh&gt;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &quot;oob=2Eh&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#include &quot;test_common=2Eh&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/* Write a probe parameter TLV and read it back; f=
ields must survive the</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * round trip and the whole buffer must be consumed=2E */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+test_probe_parameter_roundtrip(void **sta=
te)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new(=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer=
 buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  const struct oob_probe_parameter in =3D {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        =2Etimestamp =3D 0x0123456789abcdefULL,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Eflags =3D 0,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_probe_parame=
ter_write(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* header (4) + value (12) */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;buf), 4 + OOB_PROBE=
_PARAMETER_LEN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t type;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool optional;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t value_len;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_=
tlv_read_header(&amp;buf, &amp;type, &amp;optional, &amp;value_len));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(type=
, OOB_TLV_PROBE_PARAMETER);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_false(optional);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_int_equal(value_len, OOB_PROBE_PARAMETER_LEN);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_parameter out =3D {=
 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tru=
e(oob_probe_parameter_read(&amp;buf, &amp;out, value_len));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_true(in=2Etimestamp =3D=
=3D out=2Etimestamp);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_int_equal(in=2Eflags, out=2Eflags);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;buf), 0);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* =
Write a probe reply TLV and read it back=2E */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+test_probe_reply_roundtrip(void **state)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_=
gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_=
reply in =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   =2Epriority =3D 10,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        =2Eweight =3D 100,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        =2Econnect_lifetime =3D 30,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        =2Eflags =3D 1,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        =2Emax_latency_diff =3D 25,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    memcpy(in=2Epeer_session_id=2Eid, &qu=
ot;ABCDEFGH&quot;, SID_SIZE);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_true(oob_probe_reply_write(&amp;buf, &amp;in));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;buf), 4 + OOB_=
PROBE_REPLY_LEN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t type;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool optional;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t value_len;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob=
_tlv_read_header(&amp;buf, &amp;type, &amp;optional, &amp;value_len));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(typ=
e, OOB_TLV_PROBE_REPLY);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_int_equal(value_len, OOB_PROBE_REPLY_LEN);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct oob_probe_reply out =3D { 0 };</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_probe_reply_r=
ead(&amp;buf, &amp;out, value_len));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_memory_equal(in=2Epeer_session_id=2Eid, out=2Ep=
eer_session_id=2Eid, SID_SIZE);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_int_equal(in=2Epriority, out=2Epriority);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(in=2Eweig=
ht, out=2Eweight);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_int_equal(in=2Econnect_lifetime, out=2Econnect_lifetime);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(in=2Ef=
lags, out=2Eflags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_int_equal(in=2Emax_latency_diff, out=2Emax_latency_diff);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(=
&amp;buf), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/* A TLV with a longer-than-known value must still parse: t=
he known fields are</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * read and the trailing bytes are skipped (forward compatibility)=2E */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+test_probe_parameter_forward_c=
ompat(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_aren=
a gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const uint16_t extended_len =3D OOB_PROBE_PARAMETER_LEN =
+ 4;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true=
(oob_tlv_write_header(&amp;buf, OOB_TLV_PROBE_PARAMETER, false, extended_le=
n));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true=
(buf_write_u32(&amp;buf, 0));          /* timestamp high */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;=
buf, 0xdeadbeef)); /* timestamp low */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;buf, 0));          /*=
 flags */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_true(buf_write_u32(&amp;buf, 0x11223344)); /* unknown trailing field */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    uint16_t type;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    bool optional;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    uint16_t value_len;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_tlv_read_header(&=
amp;buf, &amp;type, &amp;optional, &amp;value_len));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(value_len, extended_=
len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_parameter ou=
t =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_true(oob_probe_parameter_read(&amp;buf, &amp;out, value_len));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(out=2Etimest=
amp =3D=3D 0xdeadbeefULL);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_int_equal(out=2Eflags, 0);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* the unknown trailing field must have been c=
onsumed */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_int_equal(BLEN(&amp;buf), 0);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_=
free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* A declared value length shorter than t=
he mandatory minimum must be rejected=2E */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+test_probe_parameter_too_short(void **state)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf=
_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe=
_parameter out =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_false(oob_probe_parameter_read(&amp;buf, &amp;out, OOB_PRO=
BE_PARAMETER_LEN - 1));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&am=
p;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/* Reading a header from a buffer that is too smal=
l must fail rather than read</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * past the end=2E */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+test_tlv_header_truncated(void **state)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    uint16_t type;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    bool optional;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    uint16_t value_len;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* empty buffer */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_false(oob_tlv_read_header(&amp;buf, &amp;=
type, &amp;optional, &amp;value_len));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* only the type field present, no length */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_true(buf_write_u16(&amp;buf, OOB_TL=
V_PROBE_PARAMETER));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_false(oob_tlv_read_header(&amp;buf, &amp;type, &amp;optional, &=
amp;value_len));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+main(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_unit_test_set=
up();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const stru=
ct CMUnitTest tests[] =3D {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        cmocka_unit_test(test_probe_parameter_roundtrip),</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test=
_probe_reply_roundtrip),</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        cmocka_unit_test(test_probe_parameter_forward_compat),</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(te=
st_probe_parameter_too_short),</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        cmocka_unit_test(test_tlv_header_truncated),</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return cmocka_run_group_tests_name(&quot;oob tests&quot;, t=
ests, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">change 1741</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:non=
e"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1c8d302ac57c5603=
d622a7be14be369437388268 </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 1741 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
=
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;f=
rank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; <=
/div>

</body></html>
--a3o5nEdJFeA=--


--===============7059788726403394588==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7059788726403394588==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7059788726403394588==--

