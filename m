Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E635C61DB9
	for <openvpn-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hL3xqjmvZqRJSOSdS+xLKPGZ2zWgbU89txsMcK0i43c=; b=lwk2QdmLkHncq+OAFkHT1fPbRu
	0Suxj5IgaiIchS6i+2/yzmDk+qj+ViII1+qbq8iQKEdbvyrDTybP4SFbzqm+xKuyQAh9ujXHlFMaZ
	U4WVHlyshnd5rjmOPllqgC0n0e36KGzhcEH2dvkG92fyOXq6mU83aRlVnUGNS267kuJA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzw3U-0000qW-JN;
	Fri, 28 Aug 2026 12:51:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzw3O-0000q3-Ua
 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 12:51:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ro4LRtTrNLfK6mc7kanCeK9miRoI48CUWmGxqbyiKC0=; b=OjKCzr1M189NvEHgmyEcJwDcj0
 x21Y8rM+3rTZf0Bf5jzhHu4QyEh3rq/CP5ZPtHGXg4pkF3wDzPBoeuynLYzj736oHgJ/PDBbCMEGo
 Oiw0eQVRcmCcv8qSI3xspuPnjWkesVgraqSmnM+RIbkjVNHlRBggFJs1uPvSvgpScAPQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ro4LRtTrNLfK6mc7kanCeK9miRoI48CUWmGxqbyiKC0=; b=Q
 +5+x7YpOGcoRhUUPGNBYAxExonljLiYI+wefDRLJMRVaLtmbNkm5iNJoMBd5KEMOmD45uoRP9M5vd
 rRgiw7sxOrEs7PTQSjZ7Kjbqks5ifx9AG1Taw4LpYXTGLMkTMRQYimulEh4JLQgdSyK7V1XRFU+AL
 MDuQHs3vU4WNSAGM=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzw3D-0003Fg-1a for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 12:51:30 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-495590dde14so8882185e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 28 Aug 2026 05:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787921472; x=1788526272; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ro4LRtTrNLfK6mc7kanCeK9miRoI48CUWmGxqbyiKC0=;
 b=TECqufr6guWTdNwvLFTaekXW3zzueBYmjO5LG2PyaF32/BoteNeKPJk8PWVM8n8Ap1
 zpjSt9edFrx5SUmbUH8H4LUQJ3QmE1Wrsf8frHWbG4SRoBXVr0Vl/uSEO/5uDokmd587
 PFhOM0VHjem/jyxPw3+j6auZ7sseOowq3j4UFWveI3OZmmjDnYgyTRoq+ChpPHtcXym/
 r/12segra1QZajeCIEakBBvF/ViLBqQMyh4TzbGm2r+yK4H/AM9Vg1sijIEfzwbW1yvO
 0ewMy0SdrVMVvD4RN98FESLrQ2PB0rs1a0ZaJrEDE9rSXdXQkFNPpnNO9FWy+60tspqG
 CL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787921472; x=1788526272;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ro4LRtTrNLfK6mc7kanCeK9miRoI48CUWmGxqbyiKC0=;
 b=PYgy/2OE3LYQ3IYjvKdk9UszVr41QiDfJuMYxKrXvMgd6Fi/DD/CXHSU9H0fdLVEAH
 qb4dzUoj3TahiG18j1ITylkvybTFbXGHQHxpZUxNABcVXE2pba20EpauKcLSDI0tUpZi
 NjOkgAwsnXdp8AN2ygAzZaQu1muJ1ejzTHLCtB4+XFXfb/Z1+yYaUfJo6qBfMxqKckpW
 gnEq1u1/DRXhicYt7HPROZ5+aJa9+njUQZLgEFL2/y/eD5CctaFVbhw61N8vlaTc14bx
 lu6b8Bf5s4U91Ev2CTi6i4omlQf2H7Oj5t3RwIOOa+pGTSBHK2J8Yyg4LreLTCwqfPj8
 d7AQ==
X-Gm-Message-State: AFuF++mO6jxPpp3xAdq0F50nHiSICRRkb+TkQwSRWaBYnuxT/UE9hHYf
 sA+BUKgloJI/2qY2Y15sgtoVdgsT/oK0V3U9RxdHDGBzqES5Fxhz2hYibqTWVKWxP5JreHOkjqv
 dbfLyGQjjz5OwHHn4eV+nETnr9T0B0NFdtEWB/h+U7GsWTMAM3tbCW5Y8dbs6AMIf6dXbOtVLjN
 tj/h8XeQ==
X-Gm-Gg: AR+sD10WPCLNUy2E2RhKdW1l9fu2xE9kzkmQ+LRykHTugQyRquJZSoupICc/LlVWWQY
 NHxw78sSuPziI+D4+bBSFkCUjhgl6UghVOBmR6Z38WN3VxEWkOtK4f249EXZtzohJExUAx/v/dY
 vSQr3pEAvbIraXc4XJ2noij5DMwVkIzFSo6auZE4QM7q9T9GbDR+Fi4Ozzxkv3n0xFbJ5JMK6wE
 9Q5kFqVApgNtylsCxCI8tK9x98mOpMwYVG6GxNpTHi8B8jSlSmhtfhhUMRgUfcC2bN3T5rM6SEc
 Ma2CKfuWxpyc5+YHZEco5Kk2joUgHn4ic+XA/3HybL3vO1H80ioGrfIHOKKGPPVJK+i78X4zRzm
 r14z0K3XtrPd510pjeX2D9jt1xkz2/KPleWEhLRCAOusa0mlpst5xQ4oP1BHUXadZUTRGt65Dj+
 61Cq0Y4q9BDxmjc1ZgRFp06OED5zD4Jji4PRPoabBMtc4xt/9lD2kkVSJnB9ALnpB2KZiyZspe4
 P145qJ0ZwdqN0+alNd2+qug+VLP3NEMKyq+STQvKSI4ODNl1nsYKhv2TPGns2zMrSdEzvOVOESR
 hYVknEtd1ylZ6wrt81BCdgvm43aKGiCmjdE5Zxz020oBLx+4kDw=
X-Received: by 2002:a05:600c:4715:b0:499:cd34:f7c with SMTP id
 5b1f17b1804b1-49b91c26a01mr95781515e9.5.1787921472329; 
 Fri, 28 Aug 2026 05:51:12 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b95018ee8sm49733255e9.15.2026.08.28.05.51.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 05:51:12 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 28 Aug 2026 12:51:00 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 12
X-Gerrit-Change-Id: If04ce09d4c353f5384c0c48f48f63e05869a373f
X-Gerrit-Change-Number: 1745
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1745?usp=email>
X-Gerrit-Commit: e7f2021d892ea700a998d25f87b8059cec160049
In-Reply-To: <gerrit.1782719911000.If04ce09d4c353f5384c0c48f48f63e05869a373f@gerrit.openvpn.net>
References: <gerrit.1782719911000.If04ce09d4c353f5384c0c48f48f63e05869a373f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklmMDRjZTA5ZDRjMzUzZjUzODRjMGM0OGY0OGY2M2UwNTg2OWEzNzNmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <606761441ca6530d11f942197d43215a05cb7da2-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzw3D-0003Fg-1a
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Add client
 PROBE_REPLY parser
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
Content-Type: multipart/mixed; boundary="===============0681990143522971215=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0681990143522971215==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2ay4nYsi98Q="; charset=UTF-8

--2ay4nYsi98Q=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello fli=
chtenheld, plaisthos, 

I'd like you to reexamine a change=2E Please visit
=

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1745?usp=3Demail

to look at=
 the new patch set (#12)=2E


Change subject: oob: Add client PROBE_REPLY p=
arser
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Ad=
d client PROBE_REPLY parser

Add oob_client_reply_read(), the client-side c=
ounterpart of
oob_server_probe_read(): it scans the TLV payload of a receiv=
ed PROBE_REPLY
for the probe_reply TLV, skipping other/future TLV types tha=
t are marked
optional=2E Both readers use
the shared ctrl_msg_find_tlv() fr=
om control_msg=2Eh for the scan=2E

Exercised by unit tests; the client pro=
be path calls it in a follow-up=2E

Change-Id: If04ce09d4c353f5384c0c48f48f=
63e05869a373f
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M src/ope=
nvpn/oob=2Ec
M src/openvpn/oob=2Eh
M tests/unit_tests/openvpn/test_oob=2Ec
=
3 files changed, 138 insertions(+), 0 deletions(-)


  git pull ssh://gerri=
t=2Eopenvpn=2Enet:29418/openvpn refs/changes/45/1745/12

diff --git a/src/o=
penvpn/oob=2Ec b/src/openvpn/oob=2Ec
index c841d59=2E=2Ebc0e7a3 100644
--- =
a/src/openvpn/oob=2Ec
+++ b/src/openvpn/oob=2Ec
@@ -112,6 +112,23 @@
 }
 
 =
bool
+oob_client_reply_read(struct buffer *payload, struct oob_probe_reply =
*reply)
+{
+    if (!ctrl_msg_read_header(payload, OOB_MSG_PROBE_REPLY))
+ =
   {
+        return false;
+    }
+
+    struct buffer value;
+    if (!ct=
rl_msg_find_tlv(payload, OOB_TLV_PROBE_REPLY, &value))
+    {
+        retu=
rn false;
+    }
+
+    return oob_probe_reply_read(&value, reply);
+}
+
+b=
ool
 oob_timestamp_in_window(uint64_t probe_ts, uint64_t now, uint64_t wind=
ow_secs)
 {
     uint64_t diff =3D (now > probe_ts) ? (now - probe_ts) : (p=
robe_ts - now);
diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh
inde=
x 49d64e8=2E=2E80775a4 100644
--- a/src/openvpn/oob=2Eh
+++ b/src/openvpn/o=
ob=2Eh
@@ -132,6 +132,19 @@
 bool oob_client_reply_write(struct buffer *buf=
, const struct oob_probe_reply *reply);
 
 /**
+ * Read a received OOB PROB=
E_REPLY: verify its message-type header, then scan
+ * for the probe_reply =
TLV; the client-side counterpart of
+ * oob_server_probe_read()=2E TLV type=
s other than probe_reply are skipped=2E
+ * payload is consumed as it is re=
ad=2E
+ *
+ * @param payload  buffer positioned at the start of the OOB mes=
sage payload
+ * @param reply    filled with the parsed probe_reply on succ=
ess
+ * @return true if the header matched and a well-formed probe_reply wa=
s found,
+ *         false otherwise
+ */
+bool oob_client_reply_read(struc=
t buffer *payload, struct oob_probe_reply *reply);
+
+/**
  * Check whether=
 a probe timestamp is within an acceptable window around the
  * current ti=
me=2E Used to cheaply drop replayed or implausibly-timed probes
  * before =
doing any further work (see the probe_parameter timestamp rationale
diff --=
git a/tests/unit_tests/openvpn/test_oob=2Ec b/tests/unit_tests/openvpn/test=
_oob=2Ec
index 3b29b52=2E=2E183e107 100644
--- a/tests/unit_tests/openvpn/t=
est_oob=2Ec
+++ b/tests/unit_tests/openvpn/test_oob=2Ec
@@ -463,6 +463,109 =
@@
     gc_free(&gc);
 }
 
+/* A PROBE_REPLY carrying a probe_reply is foun=
d by the client scan, with all
+ * fields surviving=2E */
+static void
+tes=
t_client_reply_read_finds_reply(void **state)
+{
+    struct gc_arena gc =
=3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    str=
uct oob_probe_reply in =3D {
+        =2Epriority =3D 5,
+        =2Eweight=
 =3D 50,
+        =2Econnect_lifetime =3D 120,
+        =2Eflags =3D 1,
+  =
  };
+    memcpy(in=2Epeer_session_id=2Eid, "SRVREPLY", SID_SIZE);
+    ass=
ert_true(oob_client_reply_write(&buf, &in));
+
+    struct oob_probe_reply =
out =3D { 0 };
+    assert_true(oob_client_reply_read(&buf, &out));
+    as=
sert_memory_equal(out=2Epeer_session_id=2Eid, in=2Epeer_session_id=2Eid, SI=
D_SIZE);
+    assert_int_equal(out=2Epriority, in=2Epriority);
+    assert_=
int_equal(out=2Eweight, in=2Eweight);
+    assert_int_equal(out=2Econnect_l=
ifetime, in=2Econnect_lifetime);
+    assert_int_equal(out=2Eflags, in=2Efl=
ags);
+
+    gc_free(&gc);
+}
+
+/* TLVs other than probe_reply are skipped=
=2E */
+static void
+test_client_reply_read_skips_unknown(void **state)
+{
=
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_=
gc(128, &gc);
+
+    assert_true(buf_write_u16(&buf, OOB_MSG_PROBE_REPLY));=

+    assert_true(ctrl_msg_tlv_write_header(&buf, 0x7ff, true, 4));
+    as=
sert_true(buf_write_u32(&buf, 0xabad1dea));
+    struct oob_probe_reply in =
=3D { =2Epriority =3D 7 };
+    assert_true(oob_probe_reply_write(&buf, &in=
));
+
+    struct oob_probe_reply out =3D { 0 };
+    assert_true(oob_clien=
t_reply_read(&buf, &out));
+    assert_int_equal(out=2Epriority, 7);
+
+   =
 gc_free(&gc);
+}
+
+/* As on the probe side, a mandatory TLV we do not und=
erstand -- here trailing
+ * the probe_reply -- invalidates the reply=2E */=

+static void
+test_client_reply_read_rejects_unknown_mandatory(void **stat=
e)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D allo=
c_buf_gc(128, &gc);
+
+    assert_true(buf_write_u16(&buf, OOB_MSG_PROBE_RE=
PLY));
+    struct oob_probe_reply in =3D { =2Epriority =3D 7 };
+    asser=
t_true(oob_probe_reply_write(&buf, &in));
+    assert_true(ctrl_msg_tlv_wri=
te_header(&buf, 0x7ff, false, 4));
+    assert_true(buf_write_u32(&buf, 0xa=
bad1dea));
+
+    struct oob_probe_reply out =3D { 0 };
+    assert_false(o=
ob_client_reply_read(&buf, &out));
+
+    gc_free(&gc);
+}
+
+/* A payload =
with no probe_reply is rejected=2E */
+static void
+test_client_reply_read_=
missing(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct =
buffer buf =3D alloc_buf_gc(128, &gc);
+
+    assert_true(buf_write_u16(&bu=
f, OOB_MSG_PROBE_REPLY));
+    assert_true(ctrl_msg_tlv_write_header(&buf, =
0x7ff, true, 4));
+    assert_true(buf_write_u32(&buf, 0));
+
+    struct o=
ob_probe_reply out =3D { 0 };
+    assert_false(oob_client_reply_read(&buf,=
 &out));
+
+    gc_free(&gc);
+}
+
+/* Likewise, a PROBE_REPLY reader rejec=
ts a payload with the wrong message
+ * type even when a valid probe_reply =
TLV follows=2E */
+static void
+test_client_reply_read_wrong_msg_type(void =
**state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =
=3D alloc_buf_gc(128, &gc);
+
+    assert_true(buf_write_u16(&buf, OOB_MSG_=
SERVER_PROBE));
+    struct oob_probe_reply in =3D { =2Epriority =3D 7 };
+=
    assert_true(oob_probe_reply_write(&buf, &in));
+
+    struct oob_probe_=
reply out =3D { 0 };
+    assert_false(oob_client_reply_read(&buf, &out));
=
+
+    gc_free(&gc);
+}
+
 int
 main(void)
 {
@@ -485,6 +588,11 @@
        =
 cmocka_unit_test(test_build_probe_reply_valid),
         cmocka_unit_test(=
test_build_probe_reply_stale),
         cmocka_unit_test(test_build_probe_r=
eply_no_parameter),
+        cmocka_unit_test(test_client_reply_read_finds_=
reply),
+        cmocka_unit_test(test_client_reply_read_skips_unknown),
+ =
       cmocka_unit_test(test_client_reply_read_rejects_unknown_mandatory),
=
+        cmocka_unit_test(test_client_reply_read_missing),
+        cmocka_=
unit_test(test_client_reply_read_wrong_msg_type),
     };
 
     return cmo=
cka_run_group_tests_name("oob tests", tests, NULL, NULL);

-- 
To view, vis=
it http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1745?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn=

Gerrit-Branch: master
Gerrit-Change-Id: If04ce09d4c353f5384c0c48f48f63e058=
69a373f
Gerrit-Change-Number: 1745
Gerrit-PatchSet: 12
Gerrit-Owner: stipa =
<lstipakov@gmail=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2E=
com>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: ope=
nvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plai=
sthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@li=
chtenheld=2Ecom>

--2ay4nYsi98Q=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>stipa <strong>uplo=
aded patch set #12</strong> to this change=2E</p><p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1745?usp=3Demail">View Change</a></p><pre cla=
ss=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">oob: Add client PROBE_REPLY parser<br><br>Add oob_client_reply_read()=
, the client-side counterpart of<br>oob_server_probe_read(): it scans the T=
LV payload of a received PROBE_REPLY<br>for the probe_reply TLV, skipping o=
ther/future TLV types that are marked<br>optional=2E Both readers use<br>th=
e shared ctrl_msg_find_tlv() from control_msg=2Eh for the scan=2E<br><br>Ex=
ercised by unit tests; the client probe path calls it in a follow-up=2E<br>=
<br>Change-Id: If04ce09d4c353f5384c0c48f48f63e05869a373f<br>Signed-off-by: =
Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M src/openvpn/oob=2Ec<br>M=
 src/openvpn/oob=2Eh<br>M tests/unit_tests/openvpn/test_oob=2Ec<br>3 files =
changed, 138 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git p=
ull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/45/1745/12</pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><s=
pan>diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec</span><br><span>=
index c841d59=2E=2Ebc0e7a3 100644</span><br><span>--- a/src/openvpn/oob=2Ec=
</span><br><span>+++ b/src/openvpn/oob=2Ec</span><br><span>@@ -112,6 +112,2=
3 @@</span><br><span> }</span><br><span> </span><br><span> bool</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+oob_client_reply_read(struct bu=
ffer *payload, struct oob_probe_reply *reply)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (!ctrl_msg_read_header(payload, OOB_MSG_PROBE_REPLY))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct buffer value;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (!ctrl_msg_find_tlv(payload, OOB_TLV_PROBE_REPLY, &amp;valu=
e))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    return oob_probe_reply_read(&amp;value, reply);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+bool</span><br><span> oob_timestamp_in_window(uint64_t probe_ts, =
uint64_t now, uint64_t window_secs)</span><br><span> {</span><br><span>    =
 uint64_t diff =3D (now &gt; probe_ts) ? (now - probe_ts) : (probe_ts - now=
);</span><br><span>diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh</=
span><br><span>index 49d64e8=2E=2E80775a4 100644</span><br><span>--- a/src/=
openvpn/oob=2Eh</span><br><span>+++ b/src/openvpn/oob=2Eh</span><br><span>@=
@ -132,6 +132,19 @@</span><br><span> bool oob_client_reply_write(struct buf=
fer *buf, const struct oob_probe_reply *reply);</span><br><span> </span><br=
><span> /**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Read =
a received OOB PROBE_REPLY: verify its message-type header, then scan</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * for the probe_reply TL=
V; the client-side counterpart of</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * oob_server_probe_read()=2E TLV types other than probe_repl=
y are skipped=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
payload is consumed as it is read=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @param payload  buffer positioned at the start of the OOB message payloa=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param reply   =
 filled with the parsed probe_reply on success</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @return true if the header matched and a well=
-formed probe_reply was found,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *         false otherwise</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+bool oob_client_reply_read(struct buffer *payload, struct oob_probe_reply=
 *reply);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span>  * Check=
 whether a probe timestamp is within an acceptable window around the</span>=
<br><span>  * current time=2E Used to cheaply drop replayed or implausibly-=
timed probes</span><br><span>  * before doing any further work (see the pro=
be_parameter timestamp rationale</span><br><span>diff --git a/tests/unit_te=
sts/openvpn/test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec</span><br>=
<span>index 3b29b52=2E=2E183e107 100644</span><br><span>--- a/tests/unit_te=
sts/openvpn/test_oob=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/tes=
t_oob=2Ec</span><br><span>@@ -463,6 +463,109 @@</span><br><span>     gc_fre=
e(&amp;gc);</span><br><span> }</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/* A PROBE_REPLY carrying a probe_reply is fou=
nd by the client scan, with all</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * fields surviving=2E */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+test_client_reply_read_finds_reply(void **state)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_g=
c(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_r=
eply in =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  =2Epriority =3D 5,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        =2Eweight =3D 50,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        =2Econnect_lifetime =3D 120,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        =2Eflags =3D 1,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    memcpy(in=2Epeer_session_id=2Eid, &quot;SRVREPLY&quot;, =
SID_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_true(oob_client_reply_write(&amp;buf, &amp;in));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct oob_probe_reply out =3D { 0 };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_client_reply_read(&am=
p;buf, &amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_memory_equal(out=2Epeer_session_id=2Eid, in=2Epeer_session_id=2Ei=
d, SID_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_int_equal(out=2Epriority, in=2Epriority);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_int_equal(out=2Eweight, in=2Eweight);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equa=
l(out=2Econnect_lifetime, in=2Econnect_lifetime);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_int_equal(out=2Eflags, in=2Eflags)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/* TLVs other than probe_reply are skipped=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+test_client_reply_read_skips_unknown(void **state=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer b=
uf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_true(buf_write_u16(&amp;buf, OOB_MSG_PROBE_REPLY));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_h=
eader(&amp;buf, 0x7ff, true, 4));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_true(buf_write_u32(&amp;buf, 0xabad1dea));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_reply =
in =3D { =2Epriority =3D 7 };</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_true(oob_probe_reply_write(&amp;buf, &amp;in));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct oob_probe_reply out =3D { 0 };</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_cli=
ent_reply_read(&amp;buf, &amp;out));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_int_equal(out=2Epriority, 7);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* As on the pro=
be side, a mandatory TLV we do not understand -- here trailing</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * the probe_reply -- invalidate=
s the reply=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_clien=
t_reply_read_rejects_unknown_mandatory(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(12=
8, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_=
u16(&amp;buf, OOB_MSG_PROBE_REPLY));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct oob_probe_reply in =3D { =2Epriority =3D 7 };</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_p=
robe_reply_write(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;buf, 0x7ff=
, false, 4));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_true(buf_write_u32(&amp;buf, 0xabad1dea));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct oob_probe_reply out =3D { 0 };</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_false(oob_client_reply_read(&amp;=
buf, &amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/* A payload with no probe_reply is rejected=2E */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+test_client_reply_read_missing(voi=
d **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D =
gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_true(buf_write_u16(&amp;buf, OOB_MSG_PROBE_REPLY));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tl=
v_write_header(&amp;buf, 0x7ff, true, 4));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;buf, 0));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct oob_probe_reply out =3D { 0 };</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(oob_cli=
ent_reply_read(&amp;buf, &amp;out));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/* Likewise, a PROBE_REPLY reader rej=
ects a payload with the wrong message</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * type even when a valid probe_reply TLV follows=2E */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+test_client_reply_read_wrong_=
msg_type(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_a=
rena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_true(buf_write_u16(&amp;buf, OOB_MSG_SERVER_PRO=
BE));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob=
_probe_reply in =3D { =2Epriority =3D 7 };</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_true(oob_probe_reply_write(&amp;buf, &amp=
;in));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_reply out =
=3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_false(oob_client_reply_read(&amp;buf, &amp;out));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> int</span><br><span> main(void)</span><br><span> {</span><=
br><span>@@ -485,6 +588,11 @@</span><br><span>         cmocka_unit_test(tes=
t_build_probe_reply_valid),</span><br><span>         cmocka_unit_test(test_=
build_probe_reply_stale),</span><br><span>         cmocka_unit_test(test_bu=
ild_probe_reply_no_parameter),</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        cmocka_unit_test(test_client_reply_read_finds_reply),</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_te=
st(test_client_reply_read_skips_unknown),</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        cmocka_unit_test(test_client_reply_read_rejec=
ts_unknown_mandatory),</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        cmocka_unit_test(test_client_reply_read_missing),</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_clie=
nt_reply_read_wrong_msg_type),</span><br><span>     };</span><br><span> </s=
pan><br><span>     return cmocka_run_group_tests_name(&quot;oob tests&quot;=
, tests, NULL, NULL);</span><br><span></span><br></pre><p>To view, visit <a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1745?usp=3Demail">change=
 1745</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1745?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div=
 style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: If04ce09d4c353f5384c0c48f48f63e05869a373f </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1745 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 12 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt=
;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-deve=
l@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-=
Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ec=
om&gt; </div>

</body></html>
--2ay4nYsi98Q=--


--===============0681990143522971215==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0681990143522971215==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0681990143522971215==--

