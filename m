Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6440CC88E77
	for <openvpn-devel@archiver.kernel.org>; Mon, 14 Sep 2026 14:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/lxOlJurHk01twgU/hLGKt6x2V/tUMxiaRLJk8M61uQ=; b=VMBvJc+MUZga0/JMq2FU+VlSjO
	71rCPPcFgnSTKbI7TA+mxQsSfC+aKoJAbqjSqm6khot9+RXjwJ+DRdaxBbz8g8mfGRTjro7Hej7Ji
	V1p5fEGOEZlYFxIIAQEwEdc7BhJE+gRy1szRO9hGFEo4Jlvm6+2shlkM4d3i0voN0UU0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x67WL-0008La-Af;
	Mon, 14 Sep 2026 14:18:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x67WJ-0008LM-Mi
 for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 14:18:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=9rhTbcyaGrQNqN2nfAvzuy47XZym1ZQyn1p4+Ob0ekE=; b=TL2RAIAKXrimU9P/3Rc25pi0Li
 9bbeICngrf/fVj5p/WsJ2uvHWIx+pAGLotcLLIKm9iezDUxH22TOikEuf0dIrhW61yuoVS6kbBxM/
 s5VgcV1nM0WUIFGFYuh9u1xoRKLeKtVhb8H6DWseJ+KVPcz/0QV3HRhPntP2A17P5CDg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=9rhTbcyaGrQNqN2nfAvzuy47XZym1ZQyn1p4+Ob0ekE=; b=b
 giVqv706e0c3tu3iFYgacF0RBXJfHJU3t+C3SJjNrAHwKqSOHr/fl47bofm1cFeTRqdeuBsgBpGmf
 AfqXQ4hkHx+EmTy1kznaIve8T8P4IKroS9MUUWAWhQ4t2khmtiLPg8cNZIiODgQokyCyfoCjaSYgD
 p4EnnUZ71gYldMkI=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x67WG-0001Rr-L0 for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 14:18:56 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-49b965570d7so43627405e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 14 Sep 2026 07:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789395526; x=1790000326; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9rhTbcyaGrQNqN2nfAvzuy47XZym1ZQyn1p4+Ob0ekE=;
 b=NUI8e2XSJWlrlQXUVUWq2gelzej2kr2KI/QucFiE2788LfmzlP7MvsiZoITAEMx6CA
 W1VC2jKvQQzHz+ofUXKfl6S4NgWQKANuLfyetKerbfslq+MqN+XDmOgSWEswj82ewBe0
 fQHvVZpNk2E8VRXpVhSIkr/WZ6ks4oXPfHN7xITcX3dodWQT6ARQhAFjfHqamQfZ8Jp3
 RkQTFC3cRvD+8ImDb3smx5nrDS1wOF9f/U2ToypRIr849dEignT0NqhT+vKZrDOzyfU+
 aU7qGqcf8JrZJLxOlg+KbhjtNoEcILTbvnI5hzJrZ50VDYURrw62AUJsckcKx8G70YgV
 c92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789395526; x=1790000326;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=9rhTbcyaGrQNqN2nfAvzuy47XZym1ZQyn1p4+Ob0ekE=;
 b=Y+FQ5YnCRjCorJ7BfTq8yUnSjvt8aM83ywhOksl+ZTSwzZqtDS9tihMAYKt3HbLR31
 8wajcvLywcHphnDzoRTFJmBdaRNH0bZAkTW4RA2WRtyvcPk7iXomEed9zXXNTje2L90y
 CnSIGzgqhYYnsGiEPC4AR3C0fmdJ1PD/ItwDZT9O6NBl6JmyEY9QQz1XeJcFiZzHVzp5
 GXiyF94gUMTyE+/GH5Ky6PIeqipft3lQpKJ6LlVj4/IOTJ6KYzRvGuH1xuOrLmR/Jp4X
 xPiKsqN4rXkile+EvNdT4WD+qUJ1IOc4MigIQ1KWNjl18305YnRqphXEJnaB2enUDtnr
 Qinw==
X-Gm-Message-State: AFuF++l/s77qQDSKMlAS+9bhj2ug4DsC5umwrNflBBMx5qV7uei6Ru73
 o6F5Fp0dVzkahlACFbsW7l2XGyM0w7kZjBwcdD4NxZkqmwOWgzb0UlzT49/CmF9XYKThMUWrTDK
 ktGjwIlfY1D2ZNm1Yj0qkxDe63abu4AHYPIZ+87Ja3x8x+SiAQU6ytNWWGRTeTHin4PZ4O7Ky3t
 qhFLnETg==
X-Gm-Gg: AYBFou1utn9GDZt/ZCrEHV9BicOn2j45LejLeKhInCHSiGY4GVD0WslPSeYFrFS9y32
 qvB5HbJNepiCoN643yDo7jY9baOHwWNKFK4/H1cADuPR5rRxiKuzGR20I1qE4ioLrYvMU4i/lo6
 DiSvyiEZKX5SHHwR9x45KG0DXakN2QmNYTdY2yEaLFdERbMy/vSa0VNAlGiA9AuIGUSxg9oujk2
 55D1ZGW0GX2bO+bq7N4/PYzIqeAJKbzfjZ79fpzbFbNZb6OPlVyU1vHKMfanlxd+NyXV/bP1W5x
 O5P/8I037ec9vb3PIclPrsCTEAtfRkgl6nVWZG+pXPfE0BfqXdUZdMMZ54a0YqOV69eOEKJD9Qz
 Jgvvb5MYe9o6tubcRx2pN4oX4ZaUNbAPPMpPINrLz1UAiTQ24Ikxl55pPAskZ6cQYV1D3COsv+H
 8YGWoWJVFF4nQKLoUwH2jsHeHOa1eCOxh7sI3mMHpee0Sn3a4OMJ5vvUz+QF9nAZMX8/byqvUsK
 492Xox09ZXBXrmFmCd/I/g5P+1HrAu5GQcKlnWCNC8ONuQavy09ybz/uTt9i7T1NwIBIKLaimYy
 +/9QubOz2Z79tcPE/MGd7Wr7pzMO8WowptqdYlhHaZwbV0fbjGTDrq4yYnpRyQ==
X-Received: by 2002:a05:600c:3b9c:b0:49d:1842:f001 with SMTP id
 5b1f17b1804b1-49e7a64b779mr43112355e9.14.1789395525758; 
 Mon, 14 Sep 2026 07:18:45 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e7a29826fsm64667015e9.4.2026.09.14.07.18.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 07:18:45 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 14 Sep 2026 14:18:32 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>,
 ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 15
X-Gerrit-Change-Id: If04ce09d4c353f5384c0c48f48f63e05869a373f
X-Gerrit-Change-Number: 1745
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1745?usp=email>
X-Gerrit-Commit: 614803bd35c56b363a664eedf5f2377196b4cf27
In-Reply-To: <gerrit.1782719911000.If04ce09d4c353f5384c0c48f48f63e05869a373f@gerrit.openvpn.net>
References: <gerrit.1782719911000.If04ce09d4c353f5384c0c48f48f63e05869a373f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklmMDRjZTA5ZDRjMzUzZjUzODRjMGM0OGY0OGY2M2UwNTg2OWEzNzNmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <01ae6af0703efc7b645d6f24c59f56c12bfc199e-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x67WG-0001Rr-L0
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com, ralf@mandelbit.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5829493747559414125=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5829493747559414125==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Bi++CH76C9U="; charset=UTF-8

--Bi++CH76C9U=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, ralf_lici, s=
tipa=2E

Hello flichtenheld, plaisthos, ralf_lici, 

I'd like you to reexam=
ine a change=2E Please visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1745?usp=3Demail

to look at the new patch set (#15)=2E

The following app=
rovals got outdated and were removed:
Code-Review+1 by ralf_lici


Change s=
ubject: oob: Add client PROBE_REPLY parser
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Add client PROBE_REPLY parser

Add oob_client_reply_read(), the client-side counterpart of
oob_server_probe_read(): it scans the TLV payload of a received PROBE_REPL=
Y
for the probe_reply TLV, skipping other/future TLV types that are marked
optional=2E Both readers use
the shared ctrl_msg_find_tlv() from control_msg=2Eh for the scan=2E

Exercised by unit tests; the client probe path calls it in a follow-up=2E

Change-Id: If04ce09d4c353f5384c0c48f48f63e05869a373f
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M src/openvpn/oob=2Ec
=
M src/openvpn/oob=2Eh
M tests/unit_tests/openvpn/test_oob=2Ec
3 files chang=
ed, 140 insertions(+), 0 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/45/1745/15

diff --git a/src/openvpn/oob=
=2Ec b/src/openvpn/oob=2Ec
index 3d48276=2E=2E45e3908 100644
--- a/src/open=
vpn/oob=2Ec
+++ b/src/openvpn/oob=2Ec
@@ -112,6 +112,23 @@
 }
 
 bool
+oob_=
client_reply_read(struct buffer *payload, struct oob_probe_reply *reply)
+{=

+    if (!ctrl_msg_read_header(payload, OOB_MSG_PROBE_REPLY))
+    {
+    =
    return false;
+    }
+
+    struct buffer value;
+    if (!ctrl_msg_fin=
d_tlv(payload, OOB_TLV_PROBE_REPLY, &value))
+    {
+        return false;
=
+    }
+
+    return oob_probe_reply_read(&value, reply);
+}
+
+bool
 oob_t=
imestamp_in_window(uint64_t probe_ts, uint64_t now, uint64_t window_secs)
 =
{
     uint64_t diff =3D (now > probe_ts) ? (now - probe_ts) : (probe_ts - =
now);
diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh
index 95bb594=
=2E=2E2c69fb6 100644
--- a/src/openvpn/oob=2Eh
+++ b/src/openvpn/oob=2Eh
@@=
 -133,6 +133,19 @@
 bool oob_client_reply_write(struct buffer *buf, const s=
truct oob_probe_reply *reply);
 
 /**
+ * Read a received OOB PROBE_REPLY: =
verify its message-type header, then scan
+ * for the probe_reply TLV; the =
client-side counterpart of
+ * oob_server_probe_read()=2E Unknown TLV types=
 marked optional are skipped; an
+ * unknown mandatory one rejects the repl=
y=2E payload is consumed as it is read=2E
+ *
+ * @param payload  buffer po=
sitioned at the start of the OOB message payload
+ * @param reply    filled=
 with the parsed probe_reply on success
+ * @return true if the header matc=
hed and a well-formed probe_reply was found,
+ *         false otherwise
+ =
*/
+bool oob_client_reply_read(struct buffer *payload, struct oob_probe_rep=
ly *reply);
+
+/**
  * Check whether a probe timestamp is within an accepta=
ble window around the
  * current time=2E Used to cheaply drop replayed or =
implausibly-timed probes
  * before doing any further work (see the probe_p=
arameter timestamp rationale
diff --git a/tests/unit_tests/openvpn/test_oob=
=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec
index 7254557=2E=2Eacfd6f6 100=
644
--- a/tests/unit_tests/openvpn/test_oob=2Ec
+++ b/tests/unit_tests/open=
vpn/test_oob=2Ec
@@ -508,6 +508,111 @@
     gc_free(&gc);
 }
 
+/* A PROBE_=
REPLY carrying a probe_reply is found by the client scan, with all
+ * fiel=
ds surviving=2E */
+static void
+test_client_reply_read_finds_reply(void **=
state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D =
alloc_buf_gc(128, &gc);
+
+    struct oob_probe_reply in =3D {
+        =2E=
priority =3D 5,
+        =2Eweight =3D 50,
+        =2Emax_latency_diff =3D=
 25,
+        =2Econnect_lifetime =3D 120,
+        =2Eflags =3D 1,
+    };=

+    memcpy(in=2Epeer_session_id=2Eid, "SRVREPLY", SID_SIZE);
+    assert_=
true(oob_client_reply_write(&buf, &in));
+
+    struct oob_probe_reply out =
=3D { 0 };
+    assert_true(oob_client_reply_read(&buf, &out));
+    assert=
_memory_equal(out=2Epeer_session_id=2Eid, in=2Epeer_session_id=2Eid, SID_SI=
ZE);
+    assert_int_equal(out=2Epriority, in=2Epriority);
+    assert_int_=
equal(out=2Eweight, in=2Eweight);
+    assert_int_equal(out=2Emax_latency_d=
iff, in=2Emax_latency_diff);
+    assert_int_equal(out=2Econnect_lifetime, =
in=2Econnect_lifetime);
+    assert_int_equal(out=2Eflags, in=2Eflags);
+
+=
    gc_free(&gc);
+}
+
+/* TLVs other than probe_reply are skipped=2E */
+s=
tatic void
+test_client_reply_read_skips_unknown(void **state)
+{
+    stru=
ct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &=
gc);
+
+    assert_true(buf_write_u16(&buf, OOB_MSG_PROBE_REPLY));
+    ass=
ert_true(ctrl_msg_tlv_write_header(&buf, 0x7ff, true, 4));
+    assert_true=
(buf_write_u32(&buf, 0xabad1dea));
+    struct oob_probe_reply in =3D { =2E=
priority =3D 7 };
+    assert_true(oob_probe_reply_write(&buf, &in));
+
+  =
  struct oob_probe_reply out =3D { 0 };
+    assert_true(oob_client_reply_r=
ead(&buf, &out));
+    assert_int_equal(out=2Epriority, 7);
+
+    gc_free(=
&gc);
+}
+
+/* As on the probe side, a mandatory TLV we do not understand -=
- here trailing
+ * the probe_reply -- invalidates the reply=2E */
+static =
void
+test_client_reply_read_rejects_unknown_mandatory(void **state)
+{
+  =
  struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(=
128, &gc);
+
+    assert_true(buf_write_u16(&buf, OOB_MSG_PROBE_REPLY));
+ =
   struct oob_probe_reply in =3D { =2Epriority =3D 7 };
+    assert_true(oo=
b_probe_reply_write(&buf, &in));
+    assert_true(ctrl_msg_tlv_write_header=
(&buf, 0x7ff, false, 4));
+    assert_true(buf_write_u32(&buf, 0xabad1dea))=
;
+
+    struct oob_probe_reply out =3D { 0 };
+    assert_false(oob_client=
_reply_read(&buf, &out));
+
+    gc_free(&gc);
+}
+
+/* A payload with no p=
robe_reply is rejected=2E */
+static void
+test_client_reply_read_missing(v=
oid **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer bu=
f =3D alloc_buf_gc(128, &gc);
+
+    assert_true(buf_write_u16(&buf, OOB_MS=
G_PROBE_REPLY));
+    assert_true(ctrl_msg_tlv_write_header(&buf, 0x7ff, tr=
ue, 4));
+    assert_true(buf_write_u32(&buf, 0));
+
+    struct oob_probe_=
reply out =3D { 0 };
+    assert_false(oob_client_reply_read(&buf, &out));
=
+
+    gc_free(&gc);
+}
+
+/* Likewise, a PROBE_REPLY reader rejects a payl=
oad with the wrong message
+ * type even when a valid probe_reply TLV follo=
ws=2E */
+static void
+test_client_reply_read_wrong_msg_type(void **state)
=
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_b=
uf_gc(128, &gc);
+
+    assert_true(buf_write_u16(&buf, OOB_MSG_SERVER_PROB=
E));
+    struct oob_probe_reply in =3D { =2Epriority =3D 7 };
+    assert_=
true(oob_probe_reply_write(&buf, &in));
+
+    struct oob_probe_reply out =
=3D { 0 };
+    assert_false(oob_client_reply_read(&buf, &out));
+
+    gc_=
free(&gc);
+}
+
 int
 main(void)
 {
@@ -533,6 +638,11 @@
         cmocka_un=
it_test(test_server_probe_accept_valid),
         cmocka_unit_test(test_ser=
ver_probe_accept_stale),
         cmocka_unit_test(test_server_probe_accept=
_no_parameter),
+        cmocka_unit_test(test_client_reply_read_finds_repl=
y),
+        cmocka_unit_test(test_client_reply_read_skips_unknown),
+     =
   cmocka_unit_test(test_client_reply_read_rejects_unknown_mandatory),
+   =
     cmocka_unit_test(test_client_reply_read_missing),
+        cmocka_unit=
_test(test_client_reply_read_wrong_msg_type),
     };
 
     return cmocka_=
run_group_tests_name("oob tests", tests, NULL, NULL);

-- 
To view, visit h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1745?usp=3Demail
To unsubscribe, o=
r for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: If04ce09d4c353f5384c0c48f48f63e05869a3=
73f
Gerrit-Change-Number: 1745
Gerrit-PatchSet: 15
Gerrit-Owner: stipa <lst=
ipakov@gmail=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>=

Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: r=
alf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lis=
ts=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Att=
ention: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: stipa <lstipakov=
@gmail=2Ecom>

--Bi++CH76C9U=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, ralf_lici, stipa=2E </p>
<p>=
stipa <strong>uploaded patch set #15</strong> to this change=2E</p><p><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1745?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Re=
view+1 by ralf_lici</p><pre class=3D"blocks" style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">oob: Add client PROBE_REPLY parser<br>=
<br>Add oob_client_reply_read(), the client-side counterpart of<br>oob_serv=
er_probe_read(): it scans the TLV payload of a received PROBE_REPLY<br>for =
the probe_reply TLV, skipping other/future TLV types that are marked<br>opt=
ional=2E Both readers use<br>the shared ctrl_msg_find_tlv() from control_ms=
g=2Eh for the scan=2E<br><br>Exercised by unit tests; the client probe path=
 calls it in a follow-up=2E<br><br>Change-Id: If04ce09d4c353f5384c0c48f48f6=
3e05869a373f<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>--=
-<br>M src/openvpn/oob=2Ec<br>M src/openvpn/oob=2Eh<br>M tests/unit_tests/o=
penvpn/test_oob=2Ec<br>3 files changed, 140 insertions(+), 0 deletions(-)<b=
r><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openv=
pn refs/changes/45/1745/15</pre><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/oob=2Ec b/src/o=
penvpn/oob=2Ec</span><br><span>index 3d48276=2E=2E45e3908 100644</span><br>=
<span>--- a/src/openvpn/oob=2Ec</span><br><span>+++ b/src/openvpn/oob=2Ec</=
span><br><span>@@ -112,6 +112,23 @@</span><br><span> }</span><br><span> </s=
pan><br><span> bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
oob_client_reply_read(struct buffer *payload, struct oob_probe_reply *reply=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (!ctrl_msg_read_header(payloa=
d, OOB_MSG_PROBE_REPLY))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
eturn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct buffer value;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (!ctrl_msg_find_tlv(payload,=
 OOB_TLV_PROBE_REPLY, &amp;value))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return oob_probe_reply_rea=
d(&amp;value, reply);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span> oob_timestamp=
_in_window(uint64_t probe_ts, uint64_t now, uint64_t window_secs)</span><br=
><span> {</span><br><span>     uint64_t diff =3D (now &gt; probe_ts) ? (now=
 - probe_ts) : (probe_ts - now);</span><br><span>diff --git a/src/openvpn/o=
ob=2Eh b/src/openvpn/oob=2Eh</span><br><span>index 95bb594=2E=2E2c69fb6 100=
644</span><br><span>--- a/src/openvpn/oob=2Eh</span><br><span>+++ b/src/ope=
nvpn/oob=2Eh</span><br><span>@@ -133,6 +133,19 @@</span><br><span> bool oob=
_client_reply_write(struct buffer *buf, const struct oob_probe_reply *reply=
);</span><br><span> </span><br><span> /**</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * Read a received OOB PROBE_REPLY: verify its messag=
e-type header, then scan</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * for the probe_reply TLV; the client-side counterpart of</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * oob_server_probe_read()=2E U=
nknown TLV types marked optional are skipped; an</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * unknown mandatory one rejects the reply=2E =
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
<span>index 7254557=2E=2Eacfd6f6 100644</span><br><span>--- a/tests/unit_te=
sts/openvpn/test_oob=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/tes=
t_oob=2Ec</span><br><span>@@ -508,6 +508,111 @@</span><br><span>     gc_fre=
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
0%);">+        =2Emax_latency_diff =3D 25,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        =2Econnect_lifetime =3D 120,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        =2Eflags =3D 1,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    memcpy(in=2Epeer_session_id=2Eid, &quot;=
SRVREPLY&quot;, SID_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_true(oob_client_reply_write(&amp;buf, &amp;in));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct oob_probe_reply out =3D { 0 };</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_clien=
t_reply_read(&amp;buf, &amp;out));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_memory_equal(out=2Epeer_session_id=2Eid, in=2Epee=
r_session_id=2Eid, SID_SIZE);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_int_equal(out=2Epriority, in=2Epriority);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(out=2Eweigh=
t, in=2Eweight);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_int_equal(out=2Emax_latency_diff, in=2Emax_latency_diff);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(out=2Eco=
nnect_lifetime, in=2Econnect_lifetime);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_int_equal(out=2Eflags, in=2Eflags);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* TLVs=
 other than probe_reply are skipped=2E */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+test_client_reply_read_skips_unknown(void **state)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc=
_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(=
buf_write_u16(&amp;buf, OOB_MSG_PROBE_REPLY));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;b=
uf, 0x7ff, true, 4));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_true(buf_write_u32(&amp;buf, 0xabad1dea));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_reply in =3D { =2E=
priority =3D 7 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_true(oob_probe_reply_write(&amp;buf, &amp;in));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct oob_probe_reply out =3D { 0 };</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_client_reply_re=
ad(&amp;buf, &amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_int_equal(out=2Epriority, 7);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/* As on the probe side, a m=
andatory TLV we do not understand -- here trailing</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * the probe_reply -- invalidates the reply=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_client_reply_rea=
d_rejects_unknown_mandatory(void **state)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u16(&amp;buf,=
 OOB_MSG_PROBE_REPLY));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct oob_probe_reply in =3D { =2Epriority =3D 7 };</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_probe_reply_wr=
ite(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_true(ctrl_msg_tlv_write_header(&amp;buf, 0x7ff, false, 4));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf=
_write_u32(&amp;buf, 0xabad1dea));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct oob_probe_reply out =3D { 0 };</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_false(oob_client_reply_read(&amp;buf, &amp;out=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/* A payload with no probe_reply is rejected=2E */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+test_client_reply_read_missing(void **state)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =
=3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_true(buf_write_u16(&amp;buf, OOB_MSG_PROBE_REPLY));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_head=
er(&amp;buf, 0x7ff, true, 4));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_true(buf_write_u32(&amp;buf, 0));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct oob_probe_reply out =3D { 0 };</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_false(oob_client_reply_re=
ad(&amp;buf, &amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&a=
mp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/* Likewise, a PROBE_REPLY reader rejects a paylo=
ad with the wrong message</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * type even when a valid probe_reply TLV follows=2E */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+test_client_reply_read_wrong_msg_type(voi=
d **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D =
gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_true(buf_write_u16(&amp;buf, OOB_MSG_SERVER_PROBE));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_reply=
 in =3D { =2Epriority =3D 7 };</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_true(oob_probe_reply_write(&amp;buf, &amp;in));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct oob_probe_reply out =3D { 0 };</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(oob_c=
lient_reply_read(&amp;buf, &amp;out));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
> int</span><br><span> main(void)</span><br><span> {</span><br><span>@@ -53=
3,6 +638,11 @@</span><br><span>         cmocka_unit_test(test_server_probe_=
accept_valid),</span><br><span>         cmocka_unit_test(test_server_probe_=
accept_stale),</span><br><span>         cmocka_unit_test(test_server_probe_=
accept_no_parameter),</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        cmocka_unit_test(test_client_reply_read_finds_reply),</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_c=
lient_reply_read_skips_unknown),</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        cmocka_unit_test(test_client_reply_read_rejects_unknow=
n_mandatory),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  cmocka_unit_test(test_client_reply_read_missing),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_client_repl=
y_read_wrong_msg_type),</span><br><span>     };</span><br><span> </span><br=
><span>     return cmocka_run_group_tests_name(&quot;oob tests&quot;, tests=
, NULL, NULL);</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1745?usp=3Demail">change 1745=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1745?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
f04ce09d4c353f5384c0c48f48f63e05869a373f </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1745 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 15 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstip=
akov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: f=
lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lich=
tenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ral=
f_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>

</body></html>
--Bi++CH76C9U=--


--===============5829493747559414125==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5829493747559414125==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5829493747559414125==--

