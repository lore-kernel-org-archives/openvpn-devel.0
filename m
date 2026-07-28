Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 356DAC54F54
	for <openvpn-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YJ+2xYc9EzpivHFPrL5TKUAEhSJVONwMIbqPaWXcAG0=; b=A+ipbJUWcrB6UEZFS/87CFD60+
	PfQsJSXS1ZfXYAdcwRubJtaBBVG9g8l4JV85ehE9Jlso7wlsr34S/yFO6McJ/br459m7mOfarnZee
	gj9B/KvkE7L1oEMBZo9kzIEQ/xg3NzQXQa4MVlkyFiTMC7tWA6mqv0H8y3xoU9mXC5oQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wojLW-0001tf-0w;
	Tue, 28 Jul 2026 15:03:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wojLU-0001tO-EI
 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 15:03:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=tYLt3rCaNGvromPN+Oc2sD/+8PzxMmeP+ry1c9oYVWg=; b=Mq2ZeH8TVCXeGXmfxOxVmLGPXr
 yKhnOmpjYny74bO4kQqP0CUT7yGzL9F5mW7xpJ+N9qQv9Crtq6NE46zECJSWtysPwXhYfWEOGkdlT
 tpqF//1mooJqiqfE51OC4WWOlCzjVfYzEuFC1AsmOUTO6PmhK0T9C4N8V7kFQN0ehlfg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tYLt3rCaNGvromPN+Oc2sD/+8PzxMmeP+ry1c9oYVWg=; b=l
 y77HL77KoU8i4r0PWzWoNXyVbz53q5imMUbNxoXrb5oj0ofvxsWCGts6GDh9UidPjurK/rwcgxQuv
 TNpXAP3iVbo+685BbeR4S27Dhk7C9eDVtqWzl9zWr/Vp9H87QThgu6FROdaBQ6czKIlF3kN87txzl
 9ezCCh/wOd8ROApE=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wojLX-0000QB-4U for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 15:03:53 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4954a9e8490so5976165e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 28 Jul 2026 08:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785251025; x=1785855825; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tYLt3rCaNGvromPN+Oc2sD/+8PzxMmeP+ry1c9oYVWg=;
 b=SmYU4cIx3L9/GxEQVcPHQFOT7tUzQufXYNOXWJtnHGEV4vbE9EfQUglKTT611jOOgr
 /IzVYTkW14pv6FxiglN4jWQalueWEwt5Il7+phs1CzfTIcx71vL31lBy9R0gYmSnjCRW
 FdwJJRqxb+qZOMwJBHsKbgA+v0+zsoctaTsaS+P0/8UbLCYc8Jdv2yynXRb0UrEvMAag
 aUFenr9f6vtf9mwejAdksUoyU/XDfRBcWa1qKUrcaq8WWts+vf4MiIDe4lv7kJc9t5Vx
 HcA3Jo2Jv5pejBuXA2f7v3u48ZFBNeusGInQkya26mKWZ0dXl4vv/AvWMh4dQ09pXT7g
 cHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785251025; x=1785855825;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=tYLt3rCaNGvromPN+Oc2sD/+8PzxMmeP+ry1c9oYVWg=;
 b=n3XQm0zHofbGM7qgVNgzU5rkeK21FV3lr0RVmKGlSHbVTxW61nOa4CVirXp2VxFci/
 qwJT/6WFjEiyxIuWbGkkea/NHaspdtYA6k/LeAZNkJ5Q9n4gXSz3kbJOn2EUcd+RBEVM
 c6dH+BVb4XtN6adFxY+Fwik5eV0YqrUbJzsi29C/y3C9bdFlblxt11vFmvFetX/7am54
 mJUcMDlZI+w3T3kF80M7vZq2fL54OIX6D9RS3bR9+Fpo5y37f6v7FmUJPhkcIrEWXvPz
 a2lrUeNDs4J++s2wQfrrkuR0hR6SaQ9Shkmh/zMTPO1IPS0ZGT05fPEbMTJ0glSawttC
 L8Vg==
X-Gm-Message-State: AOJu0YwD3hRr7RMAkN/gVjGiZDTWapioAn3w8XMVm95hcBzcCad7u78/
 hORXqmr5EwapTcXi8aIbOVZPu61OLnOR57BUzuZgJJPG+QCLna2JPYc3fkvsx5jWWYWQqQFWzP0
 6+yNnleACNEt6f6L1px0K0lKekg7sxsGcFUhmlqGf/37V55D75NuXBNHSN3gpD0FB33bY
X-Gm-Gg: AR+sD13skR2N/yRr4ubTg8TILIhw3mkE5dzGy4vxu9U7Pc+8o9f+VPx057RrhWb9Yfb
 RL45Jv2EbAQaUSr3YHGkJURRVKCHn+L4TI/lwKq5OW7AlaFMp4JhQUPSi0/JCf08VQfUSxW5588
 lLuXlUlMYnM1vn8tKfoP4ivnN8Rj7z0MAmIh7ePAUVDODV62k8PiXoK6LtPNXi8aPsPMXMUFGlX
 sggD9WleeZ+361aLd9iUpwrPTqwcZVmGGPxthJJSeOqU2zHtUSyWUdBYyF1xTN9iywFRQ6ykY37
 Z/opx8GRgtBZaeQQ7DL33mdLncApSMlAy0K1rf4g/dPVxwC72+tCztVgFwtLyTrIriG+3UHgYiX
 djizvFCRpnTsVatkUCegHsEQS9CuQ639F8b3iD4kWjoD5pCf0TAX6mPMvcov84+8LGoRYAMa7+t
 1u+5VLpL2bjjj4PiSxNlfsni4Be/tM/OBWgLf8WN6trx9jA+YMPXd4R1VSiME6Gw13OL8tdi9zt
 zuUMLbLhB0Z2kTff/GE5gWqGdEtok+nsBMBOnDbL5BXs7MRppmMxwqsZcDpuvADO/11
X-Received: by 2002:a05:600c:5291:b0:495:6193:c6c0 with SMTP id
 5b1f17b1804b1-496c658f6cdmr29376665e9.18.1785251024676; 
 Tue, 28 Jul 2026 08:03:44 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957e334f63sm250274925e9.1.2026.07.28.08.03.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 08:03:43 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 28 Jul 2026 15:03:23 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: If04ce09d4c353f5384c0c48f48f63e05869a373f
X-Gerrit-Change-Number: 1745
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1745?usp=email>
X-Gerrit-Commit: 7d80f4557b644c45e9d40edeff4c64e1e19ca1d1
In-Reply-To: <gerrit.1782719911000.If04ce09d4c353f5384c0c48f48f63e05869a373f@gerrit.openvpn.net>
References: <gerrit.1782719911000.If04ce09d4c353f5384c0c48f48f63e05869a373f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklmMDRjZTA5ZDRjMzUzZjUzODRjMGM0OGY0OGY2M2UwNTg2OWEzNzNmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <366200f964cb479343bfd71ab6f6efd5688fe051-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wojLX-0000QB-4U
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
Content-Type: multipart/mixed; boundary="===============4417338900895204456=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4417338900895204456==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="G1Fyd5Yq+Ts="; charset=UTF-8

--G1Fyd5Yq+Ts=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa=2E

He=
llo flichtenheld, plaisthos, 

I'd like you to reexamine a change=2E Please=
 visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1745?usp=3Demail

to =
look at the new patch set (#9)=2E

The following approvals got outdated and=
 were removed:
Code-Review-1 by plaisthos


Change subject: oob: Add client=
 PROBE_REPLY parser
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

oob: Add client PROBE_REPLY parser

Add oob_client_reply_read(), th=
e client-side counterpart of
oob_server_probe_read(): it scans the TLV payl=
oad of a received PROBE_REPLY
for the probe_reply TLV, skipping other/futur=
e TLV types=2E Both readers use
the shared ctrl_msg_find_tlv() from control=
_msg=2Eh for the scan=2E

Change-Id: If04ce09d4c353f5384c0c48f48f63e05869a3=
73f
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M src/openvpn/oob=
=2Ec
M src/openvpn/oob=2Eh
M tests/unit_tests/openvpn/test_oob=2Ec
3 files =
changed, 117 insertions(+), 0 deletions(-)


  git pull ssh://gerrit=2Eopen=
vpn=2Enet:29418/openvpn refs/changes/45/1745/9

diff --git a/src/openvpn/oo=
b=2Ec b/src/openvpn/oob=2Ec
index c841d59=2E=2Ebc0e7a3 100644
--- a/src/ope=
nvpn/oob=2Ec
+++ b/src/openvpn/oob=2Ec
@@ -112,6 +112,23 @@
 }
 
 bool
+oob=
_client_reply_read(struct buffer *payload, struct oob_probe_reply *reply)
+=
{
+    if (!ctrl_msg_read_header(payload, OOB_MSG_PROBE_REPLY))
+    {
+   =
     return false;
+    }
+
+    struct buffer value;
+    if (!ctrl_msg_fi=
nd_tlv(payload, OOB_TLV_PROBE_REPLY, &value))
+    {
+        return false;=

+    }
+
+    return oob_probe_reply_read(&value, reply);
+}
+
+bool
 oob_=
timestamp_in_window(uint64_t probe_ts, uint64_t now, uint64_t window_secs)
=
 {
     uint64_t diff =3D (now > probe_ts) ? (now - probe_ts) : (probe_ts -=
 now);
diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh
index 49d64e8=
=2E=2E80775a4 100644
--- a/src/openvpn/oob=2Eh
+++ b/src/openvpn/oob=2Eh
@@=
 -132,6 +132,19 @@
 bool oob_client_reply_write(struct buffer *buf, const s=
truct oob_probe_reply *reply);
 
 /**
+ * Read a received OOB PROBE_REPLY: =
verify its message-type header, then scan
+ * for the probe_reply TLV; the =
client-side counterpart of
+ * oob_server_probe_read()=2E TLV types other t=
han probe_reply are skipped=2E
+ * payload is consumed as it is read=2E
+ *=

+ * @param payload  buffer positioned at the start of the OOB message payl=
oad
+ * @param reply    filled with the parsed probe_reply on success
+ * @=
return true if the header matched and a well-formed probe_reply was found,
=
+ *         false otherwise
+ */
+bool oob_client_reply_read(struct buffer =
*payload, struct oob_probe_reply *reply);
+
+/**
  * Check whether a probe =
timestamp is within an acceptable window around the
  * current time=2E Use=
d to cheaply drop replayed or implausibly-timed probes
  * before doing any=
 further work (see the probe_parameter timestamp rationale
diff --git a/tes=
ts/unit_tests/openvpn/test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec
=
index 371cbc6=2E=2E48bec2d 100644
--- a/tests/unit_tests/openvpn/test_oob=
=2Ec
+++ b/tests/unit_tests/openvpn/test_oob=2Ec
@@ -434,6 +434,89 @@
     =
gc_free(&gc);
 }
 
+/* A PROBE_REPLY carrying a probe_reply is found by the=
 client scan, with all
+ * fields surviving=2E */
+static void
+test_client=
_reply_read_finds_reply(void **state)
+{
+    struct gc_arena gc =3D gc_new=
();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    struct oob_pr=
obe_reply in =3D {
+        =2Epriority =3D 5,
+        =2Eweight =3D 50,
+=
        =2Econnect_lifetime =3D 120,
+        =2Eflags =3D 1,
+    };
+    =
memcpy(in=2Epeer_session_id=2Eid, "SRVREPLY", SID_SIZE);
+    assert_true(o=
ob_client_reply_write(&buf, &in));
+
+    struct oob_probe_reply out =3D { =
0 };
+    assert_true(oob_client_reply_read(&buf, &out));
+    assert_memor=
y_equal(out=2Epeer_session_id=2Eid, in=2Epeer_session_id=2Eid, SID_SIZE);
+=
    assert_int_equal(out=2Epriority, in=2Epriority);
+    assert_int_equal(=
out=2Eweight, in=2Eweight);
+    assert_int_equal(out=2Econnect_lifetime, i=
n=2Econnect_lifetime);
+    assert_int_equal(out=2Eflags, in=2Eflags);
+
+ =
   gc_free(&gc);
+}
+
+/* TLVs other than probe_reply are skipped=2E */
+st=
atic void
+test_client_reply_read_skips_unknown(void **state)
+{
+    struc=
t gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &g=
c);
+
+    assert_true(buf_write_u16(&buf, OOB_MSG_PROBE_REPLY));
+    asse=
rt_true(ctrl_msg_tlv_write_header(&buf, 0x7ff, false, 4));
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
+/* A payload with no probe_reply is rejected=2E */
+static void=

+test_client_reply_read_missing(void **state)
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
(&buf, 0));
+
+    struct oob_probe_reply out =3D { 0 };
+    assert_false(=
oob_client_reply_read(&buf, &out));
+
+    gc_free(&gc);
+}
+
+/* Likewise,=
 a PROBE_REPLY reader rejects a payload with the wrong message
+ * type eve=
n when a valid probe_reply TLV follows=2E */
+static void
+test_client_repl=
y_read_wrong_msg_type(void **state)
+{
+    struct gc_arena gc =3D gc_new()=
;
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    assert_true(buf=
_write_u16(&buf, OOB_MSG_SERVER_PROBE));
+    struct oob_probe_reply in =3D=
 { =2Epriority =3D 7 };
+    assert_true(oob_probe_reply_write(&buf, &in));=

+
+    struct oob_probe_reply out =3D { 0 };
+    assert_false(oob_client_=
reply_read(&buf, &out));
+
+    gc_free(&gc);
+}
+
 int
 main(void)
 {
@@ -=
455,6 +538,10 @@
         cmocka_unit_test(test_build_probe_reply_valid),
 =
        cmocka_unit_test(test_build_probe_reply_stale),
         cmocka_uni=
t_test(test_build_probe_reply_no_parameter),
+        cmocka_unit_test(test=
_client_reply_read_finds_reply),
+        cmocka_unit_test(test_client_repl=
y_read_skips_unknown),
+        cmocka_unit_test(test_client_reply_read_mis=
sing),
+        cmocka_unit_test(test_client_reply_read_wrong_msg_type),
  =
   };
 
     return cmocka_run_group_tests_name("oob tests", tests, NULL, N=
ULL);

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1745?us=
p=3Demail
To unsubscribe, or for help writing mail filters, visit http://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If04ce09d4c=
353f5384c0c48f48f63e05869a373f
Gerrit-Change-Number: 1745
Gerrit-PatchSet: =
9
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: flichtenheld=
 <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: =
flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Attention: stipa <lstipakov@g=
mail=2Ecom>

--G1Fyd5Yq+Ts=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, stipa=2E </p>
<p>stipa <stro=
ng>uploaded patch set #9</strong> to this change=2E</p><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1745?usp=3Demail">View Change</a></p><p=
>The following approvals got outdated and were removed:
Code-Review-1 by pl=
aisthos</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">oob: Add client PROBE_REPLY parser<br><br>Add oob_=
client_reply_read(), the client-side counterpart of<br>oob_server_probe_rea=
d(): it scans the TLV payload of a received PROBE_REPLY<br>for the probe_re=
ply TLV, skipping other/future TLV types=2E Both readers use<br>the shared =
ctrl_msg_find_tlv() from control_msg=2Eh for the scan=2E<br><br>Change-Id: =
If04ce09d4c353f5384c0c48f48f63e05869a373f<br>Signed-off-by: Lev Stipakov &l=
t;lev@openvpn=2Enet&gt;<br>---<br>M src/openvpn/oob=2Ec<br>M src/openvpn/oo=
b=2Eh<br>M tests/unit_tests/openvpn/test_oob=2Ec<br>3 files changed, 117 in=
sertions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t=2Eopenvpn=2Enet:29418/openvpn refs/changes/45/1745/9</pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec</span><br><span>index c841d59=2E=
=2Ebc0e7a3 100644</span><br><span>--- a/src/openvpn/oob=2Ec</span><br><span=
>+++ b/src/openvpn/oob=2Ec</span><br><span>@@ -112,6 +112,23 @@</span><br><=
span> }</span><br><span> </span><br><span> bool</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+oob_client_reply_read(struct buffer *payload, s=
truct oob_probe_reply *reply)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
!ctrl_msg_read_header(payload, OOB_MSG_PROBE_REPLY))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return false;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
buffer value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (!ctrl_msg_find_tlv(payload, OOB_TLV_PROBE_REPLY, &amp;value))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        return false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    return oob_probe_reply_read(&amp;value, reply);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+boo=
l</span><br><span> oob_timestamp_in_window(uint64_t probe_ts, uint64_t now,=
 uint64_t window_secs)</span><br><span> {</span><br><span>     uint64_t dif=
f =3D (now &gt; probe_ts) ? (now - probe_ts) : (probe_ts - now);</span><br>=
<span>diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh</span><br><spa=
n>index 49d64e8=2E=2E80775a4 100644</span><br><span>--- a/src/openvpn/oob=
=2Eh</span><br><span>+++ b/src/openvpn/oob=2Eh</span><br><span>@@ -132,6 +1=
32,19 @@</span><br><span> bool oob_client_reply_write(struct buffer *buf, c=
onst struct oob_probe_reply *reply);</span><br><span> </span><br><span> /**=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Read a received =
OOB PROBE_REPLY: verify its message-type header, then scan</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * for the probe_reply TLV; the clie=
nt-side counterpart of</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * oob_server_probe_read()=2E TLV types other than probe_reply are skipp=
ed=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * payload is =
consumed as it is read=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param p=
ayload  buffer positioned at the start of the OOB message payload</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @param reply    filled wit=
h the parsed probe_reply on success</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * @return true if the header matched and a well-formed pro=
be_reply was found,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *         false otherwise</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool oob_=
client_reply_read(struct buffer *payload, struct oob_probe_reply *reply);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span>  * Check whether a =
probe timestamp is within an acceptable window around the</span><br><span> =
 * current time=2E Used to cheaply drop replayed or implausibly-timed probe=
s</span><br><span>  * before doing any further work (see the probe_paramete=
r timestamp rationale</span><br><span>diff --git a/tests/unit_tests/openvpn=
/test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>index=
 371cbc6=2E=2E48bec2d 100644</span><br><span>--- a/tests/unit_tests/openvpn=
/test_oob=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_oob=2Ec</=
span><br><span>@@ -434,6 +434,89 @@</span><br><span>     gc_free(&amp;gc);<=
/span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/* A PROBE_REPLY carrying a probe_reply is found by the cl=
ient scan, with all</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * fields surviving=2E */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+te=
st_client_reply_read_finds_reply(void **state)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;=
gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_reply in =3D =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Epriorit=
y =3D 5,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2E=
weight =3D 50,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   =2Econnect_lifetime =3D 120,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        =2Eflags =3D 1,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    memcpy(in=2Epeer_session_id=2Eid, &quot;SRVREPLY&quot;, SID_SIZE);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_c=
lient_reply_write(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct oob_probe_reply out =3D { 0 };</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_true(oob_client_reply_read(&amp;buf, &amp;=
out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_me=
mory_equal(out=2Epeer_session_id=2Eid, in=2Epeer_session_id=2Eid, SID_SIZE)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equ=
al(out=2Epriority, in=2Epriority);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_int_equal(out=2Eweight, in=2Eweight);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(out=2Econn=
ect_lifetime, in=2Econnect_lifetime);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_int_equal(out=2Eflags, in=2Eflags);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* TLVs o=
ther than probe_reply are skipped=2E */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+test_client_reply_read_skips_unknown(void **state)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_b=
uf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(bu=
f_write_u16(&amp;buf, OOB_MSG_PROBE_REPLY));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;buf=
, 0x7ff, false, 4));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_true(buf_write_u32(&amp;buf, 0xabad1dea));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_reply in =3D { =2Ep=
riority =3D 7 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_true(oob_probe_reply_write(&amp;buf, &amp;in));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct oob_probe_reply out =3D { 0 };</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_client_reply_rea=
d(&amp;buf, &amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_int_equal(out=2Epriority, 7);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/* A payload with no probe_re=
ply is rejected=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_c=
lient_reply_read_missing(void **state)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u16(&amp;buf, O=
OB_MSG_PROBE_REPLY));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_true(ctrl_msg_tlv_write_header(&amp;buf, 0x7ff, false, 4));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_wr=
ite_u32(&amp;buf, 0));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_p=
robe_reply out =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_false(oob_client_reply_read(&amp;buf, &amp;out));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Like=
wise, a PROBE_REPLY reader rejects a payload with the wrong message</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * type even when a valid p=
robe_reply TLV follows=2E */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+test_client_reply_read_wrong_msg_type(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(12=
8, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_=
u16(&amp;buf, OOB_MSG_SERVER_PROBE));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct oob_probe_reply in =3D { =2Epriority =3D 7 };<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_=
probe_reply_write(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct oob_probe_reply out =3D { 0 };</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_false(oob_client_reply_read(&amp;buf, &amp=
;out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><span> main(voi=
d)</span><br><span> {</span><br><span>@@ -455,6 +538,10 @@</span><br><span>=
         cmocka_unit_test(test_build_probe_reply_valid),</span><br><span>  =
       cmocka_unit_test(test_build_probe_reply_stale),</span><br><span>    =
     cmocka_unit_test(test_build_probe_reply_no_parameter),</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_clien=
t_reply_read_finds_reply),</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        cmocka_unit_test(test_client_reply_read_skips_unknown),</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test=
(test_client_reply_read_missing),</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        cmocka_unit_test(test_client_reply_read_wrong_msg_typ=
e),</span><br><span>     };</span><br><span> </span><br><span>     return c=
mocka_run_group_tests_name(&quot;oob tests&quot;, tests, NULL, NULL);</span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1745?usp=3Demail">change 1745</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D=
"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemt=
ype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1745?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: If04ce09d4c353f5384c0c4=
8f48f63e05869a373f </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 1745 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: p=
laisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>

<=
/body></html>
--G1Fyd5Yq+Ts=--


--===============4417338900895204456==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4417338900895204456==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4417338900895204456==--

