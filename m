Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2928CC54F51
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 12:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rKgoUPZNsSx9B0bzv+lE7VXvp51cJ80CWJH/7uMLZ04=; b=UDRE/6bFfmdmoKb+jzGvsyibKB
	w5ihk/eT8JsdSeW7Jo8U6DjI0Eep8TENbvWrCdA1bUm7PlWm0DSQw0I7imzo+TUrirN5RSMufJ5EE
	7qNkAkoNny6nZ72pOOZHLfr9wtB3vDr22eJByHWWDKYkssZZb0idvItIij57oIwACujk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wp3Ji-00026Y-RJ;
	Wed, 29 Jul 2026 12:23:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wp3Jh-00026J-AB
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 12:23:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=hZga8SubxtFmXQauUXWu/RlLKAKwCCuqkUFo+QH1w6A=; b=EghD4WbgP3l73jQHXNRbSoM8TW
 TokPIgQKWnBNrBVuSckmfLUsGl2TDNpiUO/8kcMT9EMVGiIqYeq7281QODYncewF+yBv60ncNKMgJ
 BFGMlYrGMV90xr2hqx0CUSUo0cRkLXKlnKaOWmL4uCIYXH5xv1pyz+7KdSZCd76Zz06k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=hZga8SubxtFmXQauUXWu/RlLKAKwCCuqkUFo+QH1w6A=; b=M
 n5WaY3GAJncM/VfTPtLmOLrS1sUyhhXZkEDtBEGVJOjzUy0OSgcNEtWnuafh/fYX0CTkhAF6jHfsL
 8Hay6lONYSaMKVNwrYoE2N18lVqDXyYVBf5tVUQ8V3w8kBcngovUC459cm/lMpcQHmop9AvB1mrMx
 k19aAZcGUb3KlH70=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wp3Jj-0005LE-U1 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 12:23:21 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4954df200ddso5224785e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 29 Jul 2026 05:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785327794; x=1785932594; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hZga8SubxtFmXQauUXWu/RlLKAKwCCuqkUFo+QH1w6A=;
 b=V3vJfLPDLRN2JHsU/wilQMsNaFr7YltXnGi/08OnBDk1TKcsI3ln8B+EMk6s72iYhH
 p7jMqdgPCuBe1L+T1d4zT6wlx2sXULA4doEugbBdr62bg0vTFncsqzqZQ6EIfoKPF8yu
 bhN2V12NZ2wzQyBynSuUa2CGmZj2jI659sNaIG24psR3At5x7mF1oxDWdfNzMbaVJ9kk
 eYQ2hjvK+3E+ftPWFXl1pImUr7UzRoTcYspqWS/JHpnTpNEXMEJDANWsSMnM4ieTo1+b
 qPRPZ4AhPNeHCKWzU+0Jxu9jkE1UguyHcsKWL0bglLJ6RQPafMzyX/zQlNg5cwxfqjoI
 Kpyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785327794; x=1785932594;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=hZga8SubxtFmXQauUXWu/RlLKAKwCCuqkUFo+QH1w6A=;
 b=V6FinEiBASJcKN2dQDjb2oxbm+jBtSvktl/xJgJwas0o6ZJYi0RZhjeBffamwe8ODf
 jmohuy0LGpmf3UEIwmMM5vg+w26DxuzDKJ8XAv/sERVdAHZDCaUqZUzQNmDisZdTH3+5
 EXFtXAwM9rR63SvqAKNcRwCGAoyQYoCVv3FbO8nczX3kRZZEECTnHct7G882KXHciA+I
 n/XQ1kCi3O3UvQxmqOiNr/Vul5UcBUmnKDokD9VkqnL9cD/qhW6inucVLZJdGG8o5Z5A
 fq8PY8XFJRf+WcCHIfTGghgRiLpTexntpQPGSIXLCSFFNeuuyci0C3FBCAhKsNB5AsiE
 A2kw==
X-Gm-Message-State: AOJu0YziBPme5pZ6uKlVWFVjP+A8p+6sKM2ahhL86NxhVKjfAHZDOERb
 R0OZwjedq1BevETL/rfO52456+iVbcsXKTOJb++SIIHozK7IWltRoenwFmTV/1onpriQp9YDaeR
 pgeW4BTvIFhLH12a+ShzwGvr/cB1VfedUBuxrdaQgUywqf3x98ac0xPMhev5Bj9Ro6vkuOBUzHa
 nK6maAQw==
X-Gm-Gg: AR+sD10zEGbOoBniKfhzsODwvbn0UjZam+a6TYsOejovL4vLD85bpQMs80/BNsv1/hT
 0rwlMzJTuZhF1H6dEm0K2+N6nYYxR20M9hVXpxDb4xAi3TH0oV5nii9ghqZNiNBn811eswk1n9T
 JWWbRJY1ZA1FGvJVpLND5f6YbYpa9lPGm28l0eRyW5IgGuMYtAIWjfuT6uRUCG0U2+NiGoZc0yL
 vjIl1tq+4+jRxCZLJu4ZNIBx3u2QvtzfqoW2GYrTYSd9NyCqgmlkrJzFSxoqE77FIzBGASjajiZ
 AOZLuT0Sm9LpMPsjRR1BALc/jw+35qqA6TyWWn+ZFH3mj76PU8DIMPGsZEnISFbJmG6VvuBlIpl
 OcXzmVEFoN9chZX6ZdKnEdpDxRPGmC2KGSq+z/IzYaDwuh+uOUEXEkFv6lv506vKGgsico/IzzL
 vl+MB5hJP8uKAJPFpVNX8BmDmgo0qN1j6wXcAaxst/iYNlCL4u0da1olxLmCfws2DRzL0atNBn5
 myYEfK1ZLN1m9ye4Cai/rvVzu3JMRKz1TFsAe2ndPKZNwRUigZae/0XhKE/eaDdX2aIDl3wnYbX
 v/VjtcbeRWXYb2LwoUUs/k1VFChhkRJYsFz821kDjtlk7Q0IClTn
X-Received: by 2002:a05:600c:1384:b0:496:c441:1354 with SMTP id
 5b1f17b1804b1-496c65744f0mr78161805e9.29.1785327793536; 
 Wed, 29 Jul 2026 05:23:13 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496e905fa40sm46909065e9.2.2026.07.29.05.23.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 05:23:12 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 29 Jul 2026 12:22:54 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 10
X-Gerrit-Change-Id: If04ce09d4c353f5384c0c48f48f63e05869a373f
X-Gerrit-Change-Number: 1745
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1745?usp=email>
X-Gerrit-Commit: 363a9e9e502bee415af934684db1c2088453f23f
In-Reply-To: <gerrit.1782719911000.If04ce09d4c353f5384c0c48f48f63e05869a373f@gerrit.openvpn.net>
References: <gerrit.1782719911000.If04ce09d4c353f5384c0c48f48f63e05869a373f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklmMDRjZTA5ZDRjMzUzZjUzODRjMGM0OGY0OGY2M2UwNTg2OWEzNzNmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9db6fb0731d49b17ab32e0071aa0fa5a27ba15d4-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wp3Jj-0005LE-U1
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
Content-Type: multipart/mixed; boundary="===============3770097776259194412=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3770097776259194412==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RIeYWC5O+qA="; charset=UTF-8

--RIeYWC5O+qA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello fli=
chtenheld, plaisthos, 

I'd like you to reexamine a change=2E Please visit
=

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1745?usp=3Demail

to look at=
 the new patch set (#10)=2E


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
for the probe_reply TLV, skipping other/future TLV types=2E =
Both readers use
the shared ctrl_msg_find_tlv() from control_msg=2Eh for th=
e scan=2E

Exercised by unit tests; the client probe path calls it in a fol=
low-up=2E

Change-Id: If04ce09d4c353f5384c0c48f48f63e05869a373f
Signed-off-=
by: Lev Stipakov <lev@openvpn=2Enet>
---
M src/openvpn/oob=2Ec
M src/openvp=
n/oob=2Eh
M tests/unit_tests/openvpn/test_oob=2Ec
3 files changed, 117 inse=
rtions(+), 0 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/o=
penvpn refs/changes/45/1745/10

diff --git a/src/openvpn/oob=2Ec b/src/open=
vpn/oob=2Ec
index c841d59=2E=2Ebc0e7a3 100644
--- a/src/openvpn/oob=2Ec
+++=
 b/src/openvpn/oob=2Ec
@@ -112,6 +112,23 @@
 }
 
 bool
+oob_client_reply_re=
ad(struct buffer *payload, struct oob_probe_reply *reply)
+{
+    if (!ctrl=
_msg_read_header(payload, OOB_MSG_PROBE_REPLY))
+    {
+        return fals=
e;
+    }
+
+    struct buffer value;
+    if (!ctrl_msg_find_tlv(payload, =
OOB_TLV_PROBE_REPLY, &value))
+    {
+        return false;
+    }
+
+    r=
eturn oob_probe_reply_read(&value, reply);
+}
+
+bool
 oob_timestamp_in_win=
dow(uint64_t probe_ts, uint64_t now, uint64_t window_secs)
 {
     uint64_t=
 diff =3D (now > probe_ts) ? (now - probe_ts) : (probe_ts - now);
diff --gi=
t a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh
index 49d64e8=2E=2E80775a4 10=
0644
--- a/src/openvpn/oob=2Eh
+++ b/src/openvpn/oob=2Eh
@@ -132,6 +132,19 =
@@
 bool oob_client_reply_write(struct buffer *buf, const struct oob_probe_=
reply *reply);
 
 /**
+ * Read a received OOB PROBE_REPLY: verify its messa=
ge-type header, then scan
+ * for the probe_reply TLV; the client-side coun=
terpart of
+ * oob_server_probe_read()=2E TLV types other than probe_reply =
are skipped=2E
+ * payload is consumed as it is read=2E
+ *
+ * @param payl=
oad  buffer positioned at the start of the OOB message payload
+ * @param r=
eply    filled with the parsed probe_reply on success
+ * @return true if t=
he header matched and a well-formed probe_reply was found,
+ *         fals=
e otherwise
+ */
+bool oob_client_reply_read(struct buffer *payload, struct=
 oob_probe_reply *reply);
+
+/**
  * Check whether a probe timestamp is wit=
hin an acceptable window around the
  * current time=2E Used to cheaply dro=
p replayed or implausibly-timed probes
  * before doing any further work (s=
ee the probe_parameter timestamp rationale
diff --git a/tests/unit_tests/op=
envpn/test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec
index 371cbc6=2E=
=2E48bec2d 100644
--- a/tests/unit_tests/openvpn/test_oob=2Ec
+++ b/tests/u=
nit_tests/openvpn/test_oob=2Ec
@@ -434,6 +434,89 @@
     gc_free(&gc);
 }
 =

+/* A PROBE_REPLY carrying a probe_reply is found by the client scan, with=
 all
+ * fields surviving=2E */
+static void
+test_client_reply_read_finds_=
reply(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct bu=
ffer buf =3D alloc_buf_gc(128, &gc);
+
+    struct oob_probe_reply in =3D {=

+        =2Epriority =3D 5,
+        =2Eweight =3D 50,
+        =2Econnect=
_lifetime =3D 120,
+        =2Eflags =3D 1,
+    };
+    memcpy(in=2Epeer_s=
ession_id=2Eid, "SRVREPLY", SID_SIZE);
+    assert_true(oob_client_reply_wr=
ite(&buf, &in));
+
+    struct oob_probe_reply out =3D { 0 };
+    assert_t=
rue(oob_client_reply_read(&buf, &out));
+    assert_memory_equal(out=2Epeer=
_session_id=2Eid, in=2Epeer_session_id=2Eid, SID_SIZE);
+    assert_int_equ=
al(out=2Epriority, in=2Epriority);
+    assert_int_equal(out=2Eweight, in=
=2Eweight);
+    assert_int_equal(out=2Econnect_lifetime, in=2Econnect_life=
time);
+    assert_int_equal(out=2Eflags, in=2Eflags);
+
+    gc_free(&gc);=

+}
+
+/* TLVs other than probe_reply are skipped=2E */
+static void
+test_=
client_reply_read_skips_unknown(void **state)
+{
+    struct gc_arena gc =
=3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    ass=
ert_true(buf_write_u16(&buf, OOB_MSG_PROBE_REPLY));
+    assert_true(ctrl_m=
sg_tlv_write_header(&buf, 0x7ff, false, 4));
+    assert_true(buf_write_u32=
(&buf, 0xabad1dea));
+    struct oob_probe_reply in =3D { =2Epriority =3D 7=
 };
+    assert_true(oob_probe_reply_write(&buf, &in));
+
+    struct oob_p=
robe_reply out =3D { 0 };
+    assert_true(oob_client_reply_read(&buf, &out=
));
+    assert_int_equal(out=2Epriority, 7);
+
+    gc_free(&gc);
+}
+
+/*=
 A payload with no probe_reply is rejected=2E */
+static void
+test_client_=
reply_read_missing(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+=
    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    assert_true(buf_wr=
ite_u16(&buf, OOB_MSG_PROBE_REPLY));
+    assert_true(ctrl_msg_tlv_write_he=
ader(&buf, 0x7ff, false, 4));
+    assert_true(buf_write_u32(&buf, 0));
+
+=
    struct oob_probe_reply out =3D { 0 };
+    assert_false(oob_client_repl=
y_read(&buf, &out));
+
+    gc_free(&gc);
+}
+
+/* Likewise, a PROBE_REPLY =
reader rejects a payload with the wrong message
+ * type even when a valid =
probe_reply TLV follows=2E */
+static void
+test_client_reply_read_wrong_ms=
g_type(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct b=
uffer buf =3D alloc_buf_gc(128, &gc);
+
+    assert_true(buf_write_u16(&buf=
, OOB_MSG_SERVER_PROBE));
+    struct oob_probe_reply in =3D { =2Epriority =
=3D 7 };
+    assert_true(oob_probe_reply_write(&buf, &in));
+
+    struct =
oob_probe_reply out =3D { 0 };
+    assert_false(oob_client_reply_read(&buf=
, &out));
+
+    gc_free(&gc);
+}
+
 int
 main(void)
 {
@@ -455,6 +538,10 @=
@
         cmocka_unit_test(test_build_probe_reply_valid),
         cmocka_=
unit_test(test_build_probe_reply_stale),
         cmocka_unit_test(test_bui=
ld_probe_reply_no_parameter),
+        cmocka_unit_test(test_client_reply_r=
ead_finds_reply),
+        cmocka_unit_test(test_client_reply_read_skips_un=
known),
+        cmocka_unit_test(test_client_reply_read_missing),
+       =
 cmocka_unit_test(test_client_reply_read_wrong_msg_type),
     };
 
     re=
turn cmocka_run_group_tests_name("oob tests", tests, NULL, NULL);

-- 
To v=
iew, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1745?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If04ce09d4c353f5384c0c48f=
48f63e05869a373f
Gerrit-Change-Number: 1745
Gerrit-PatchSet: 10
Gerrit-Owne=
r: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@licht=
enheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attent=
ion: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld =
<frank@lichtenheld=2Ecom>

--RIeYWC5O+qA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>stipa <strong>uplo=
aded patch set #10</strong> to this change=2E</p><p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1745?usp=3Demail">View Change</a></p><pre cla=
ss=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">oob: Add client PROBE_REPLY parser<br><br>Add oob_client_reply_read()=
, the client-side counterpart of<br>oob_server_probe_read(): it scans the T=
LV payload of a received PROBE_REPLY<br>for the probe_reply TLV, skipping o=
ther/future TLV types=2E Both readers use<br>the shared ctrl_msg_find_tlv()=
 from control_msg=2Eh for the scan=2E<br><br>Exercised by unit tests; the c=
lient probe path calls it in a follow-up=2E<br><br>Change-Id: If04ce09d4c35=
3f5384c0c48f48f63e05869a373f<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=
=2Enet&gt;<br>---<br>M src/openvpn/oob=2Ec<br>M src/openvpn/oob=2Eh<br>M te=
sts/unit_tests/openvpn/test_oob=2Ec<br>3 files changed, 117 insertions(+), =
0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/45/1745/10</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openv=
pn/oob=2Ec b/src/openvpn/oob=2Ec</span><br><span>index c841d59=2E=2Ebc0e7a3=
 100644</span><br><span>--- a/src/openvpn/oob=2Ec</span><br><span>+++ b/src=
/openvpn/oob=2Ec</span><br><span>@@ -112,6 +112,23 @@</span><br><span> }</s=
pan><br><span> </span><br><span> bool</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+oob_client_reply_read(struct buffer *payload, struct oob_=
probe_reply *reply)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!ctrl_msg_=
read_header(payload, OOB_MSG_PROBE_REPLY))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        return false;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer valu=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!ctrl_msg=
_find_tlv(payload, OOB_TLV_PROBE_REPLY, &amp;value))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return false;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return =
oob_probe_reply_read(&amp;value, reply);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><=
span> oob_timestamp_in_window(uint64_t probe_ts, uint64_t now, uint64_t win=
dow_secs)</span><br><span> {</span><br><span>     uint64_t diff =3D (now &g=
t; probe_ts) ? (now - probe_ts) : (probe_ts - now);</span><br><span>diff --=
git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh</span><br><span>index 49d64=
e8=2E=2E80775a4 100644</span><br><span>--- a/src/openvpn/oob=2Eh</span><br>=
<span>+++ b/src/openvpn/oob=2Eh</span><br><span>@@ -132,6 +132,19 @@</span>=
<br><span> bool oob_client_reply_write(struct buffer *buf, const struct oob=
_probe_reply *reply);</span><br><span> </span><br><span> /**</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * Read a received OOB PROBE_REPLY=
: verify its message-type header, then scan</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * for the probe_reply TLV; the client-side counter=
part of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * oob_serve=
r_probe_read()=2E TLV types other than probe_reply are skipped=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * payload is consumed as it =
is read=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param payload  buffer =
positioned at the start of the OOB message payload</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * @param reply    filled with the parsed pr=
obe_reply on success</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * @return true if the header matched and a well-formed probe_reply was fo=
und,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         fals=
e otherwise</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+bool oob_client_reply_re=
ad(struct buffer *payload, struct oob_probe_reply *reply);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/**</span><br><span>  * Check whether a probe timestamp=
 is within an acceptable window around the</span><br><span>  * current time=
=2E Used to cheaply drop replayed or implausibly-timed probes</span><br><sp=
an>  * before doing any further work (see the probe_parameter timestamp rat=
ionale</span><br><span>diff --git a/tests/unit_tests/openvpn/test_oob=2Ec b=
/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>index 371cbc6=2E=2E4=
8bec2d 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_oob=2Ec</=
span><br><span>+++ b/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>=
@@ -434,6 +434,89 @@</span><br><span>     gc_free(&amp;gc);</span><br><span=
> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/* A PROBE_REPLY carrying a probe_reply is found by the client scan, with=
 all</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * fields survi=
ving=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static vo=
id</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_client_reply=
_read_finds_reply(void **state)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct oob_probe_reply in =3D {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        =2Epriority =3D 5,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Eweight =3D 50,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Econnect_l=
ifetime =3D 120,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     =2Eflags =3D 1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(i=
n=2Epeer_session_id=2Eid, &quot;SRVREPLY&quot;, SID_SIZE);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_client_reply_wri=
te(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_=
probe_reply out =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_true(oob_client_reply_read(&amp;buf, &amp;out));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(out=
=2Epeer_session_id=2Eid, in=2Epeer_session_id=2Eid, SID_SIZE);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(out=2Eprior=
ity, in=2Epriority);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_int_equal(out=2Eweight, in=2Eweight);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_int_equal(out=2Econnect_lifetime, =
in=2Econnect_lifetime);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_int_equal(out=2Eflags, in=2Eflags);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/* TLVs other than prob=
e_reply are skipped=2E */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+te=
st_client_reply_read_skips_unknown(void **state)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &am=
p;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u16(&a=
mp;buf, OOB_MSG_PROBE_REPLY));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;buf, 0x7ff, false=
, 4));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tr=
ue(buf_write_u32(&amp;buf, 0xabad1dea));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct oob_probe_reply in =3D { =2Epriority =3D 7 =
};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(o=
ob_probe_reply_write(&amp;buf, &amp;in));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct oob_probe_reply out =3D { 0 };</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_true(oob_client_reply_read(&amp;buf, &a=
mp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_int_equal(out=2Epriority, 7);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_f=
ree(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* A payload with no probe_reply is rejec=
ted=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static voi=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_client_reply_=
read_missing(void **state)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_true(buf_write_u16(&amp;buf, OOB_MSG_PROBE_=
REPLY));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
true(ctrl_msg_tlv_write_header(&amp;buf, 0x7ff, false, 4));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;=
buf, 0));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_reply ou=
t =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_false(oob_client_reply_read(&amp;buf, &amp;out));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Likewise, a PROBE=
_REPLY reader rejects a payload with the wrong message</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * type even when a valid probe_reply TL=
V follows=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stat=
ic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_client_=
reply_read_wrong_msg_type(void **state)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u16(&amp;buf, O=
OB_MSG_SERVER_PROBE));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct oob_probe_reply in =3D { =2Epriority =3D 7 };</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_probe_reply_wri=
te(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_=
probe_reply out =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_false(oob_client_reply_read(&amp;buf, &amp;out));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span> int</span><br><span> main(void)</span><br><s=
pan> {</span><br><span>@@ -455,6 +538,10 @@</span><br><span>         cmocka=
_unit_test(test_build_probe_reply_valid),</span><br><span>         cmocka_u=
nit_test(test_build_probe_reply_stale),</span><br><span>         cmocka_uni=
t_test(test_build_probe_reply_no_parameter),</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_client_reply_read_fi=
nds_reply),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
cmocka_unit_test(test_client_reply_read_skips_unknown),</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_client_re=
ply_read_missing),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       cmocka_unit_test(test_client_reply_read_wrong_msg_type),</span><br><=
span>     };</span><br><span> </span><br><span>     return cmocka_run_group=
_tests_name(&quot;oob tests&quot;, tests, NULL, NULL);</span><br><span></sp=
an><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1745?usp=3Demail">change 1745</a>=2E To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1745?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: If04ce09d4c353f5384c0c48f48f63e0586=
9a373f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1745 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
<div style=3D"dis=
play:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flic=
htenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--RIeYWC5O+qA=--


--===============3770097776259194412==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3770097776259194412==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3770097776259194412==--

