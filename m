Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E9DACA5FB1
	for <openvpn-devel@archiver.kernel.org>; Tue, 29 Sep 2026 13:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Sjx49/MoRk93U0WkT/SujOAEMmi2Xpc6gyKl4fZemDw=; b=mRwEjtd74m7t0/FBm1bxjRavUh
	2s0wrETkVjMVDzDRsgv4cCJyL41+JfeBcCH/lSl90YH5RKlsH6jvy4l/MTfgMyRIJLPbn5FHFV7fj
	pyN3rLEq3/KQdJIIeXJkaHkWwAG97aE3E4Pxb6ISiYa9qvs7pLpaYWJZN9pXH5lJDYoA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBXhg-0002tv-OU;
	Tue, 29 Sep 2026 13:17:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBXhc-0002tS-AM
 for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 13:16:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=CtZcOjJDNu40ErM822VuncietH7DAH5HzraRlWiR1TA=; b=ci9bwlGGGgwXfy2icueWrpOwSw
 b0fsOq7d/21O7Z4/JfsQbCKg70jm4iDLNOOcMEUGJmOGvf4PMyB1kPE/f5J51ob9JFK6ziolzTXPc
 7wU3Slej2DSE6ZCcrjWQeeoGzRD2z285aqUHV0jd9WiK43FkirDmzxSnwNXWXvwseXuI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=CtZcOjJDNu40ErM822VuncietH7DAH5HzraRlWiR1TA=; b=R
 lzh9cg3FmGgMKY4nO9BQVqFm+SjLFGvhq3YibrOgfrQeIWXvrQUvICtKbkiT+NSIc4J2svYzNWxGM
 Vzo5oW+O40V5YjFrMNnSk85c0zdeCypcgUPVF2/2QG0dVKTGQnZxfJLDE8wgeq6jzyMgfGs30XRXJ
 nKXQ2UC1O69qiE3Q=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBXhV-0001FT-9S for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 13:16:57 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843f22dc83so3509622f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 29 Sep 2026 06:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790687807; x=1791292607; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CtZcOjJDNu40ErM822VuncietH7DAH5HzraRlWiR1TA=;
 b=AXJhHYUAMLsxlNcO6fbD2LlDQMh5G0X0ggRF3jdA8at8PyGGzds57U2FhWdE4nLm4V
 Zr6lbdZZ/hhZte0SLEUHBqwG9KVjkCwL9mfEO+r5AjNKG/nUH0IFlXrIae9YGUVlncvu
 53m8LptL+09t0FWhrL//gUVbPVB5cZrFIMo4IW6tQneIvZg5inQW4taIlcdbK/RGsRd/
 7a1DAU9+7Y8m248XbjO1DMvPrx95l3qdGEFtNDjQE412/keVr9jUFmzG8MZbkA8uwSW+
 6rp6qcWIzZwF8cMz0p/DSUEJK2PZ4RKdxFrvwCbFEgCR5bUtc6Smc7OnjHEvuDNh77mo
 S/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790687807; x=1791292607;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CtZcOjJDNu40ErM822VuncietH7DAH5HzraRlWiR1TA=;
 b=VauHkMDMlFNop0oAg+CJzisapX/cpIb7+z3FNUNK7KfthYg5KlqA3qdrYsXSFbk/1z
 tLr/pJG2yUSdOLr31fMheQjsCVi9rdahsK3UlzvMFHPMEc1eqa5knheSWekYBNkYa1mp
 huYmFjPtEoNjnks7QQN5A5FX2RZgIb3+ShIsEWA+Gi0IuMfVo8kt3kQ9/KxxTe8xPvnm
 0GFQuWeI7E/yyKxN0Cdg0YYcHm6cDcZV6t7THwylW7gyn4cWWiT/VacplYVm4JNmAOTo
 cmX4m/FVOk36LMdZMHh+PdffSfj1Uyzij2Lof3QKdEbTGg1VBba1RR2KcCummQb1TORY
 Okyw==
X-Gm-Message-State: AFq9FYJGx17PLJWQ3ZrTMoGicc5KCXNbA45vESYjDfVqYbtuga8hzMoX
 MLUKXVY0W2uydbeWpPt8Drgk9NXCEDHwuI4CwCk7xt8ayz7OchxHwITz5FE8bXpaaY51+gCWsUJ
 pzecR9cPkAsI+R7Z6rd6nqb/HYFa3HaR1V/X8sGawyIdPrYIC/4zvK4zvvohZHXyoflXYS7QUvi
 2cIzy/Vg==
X-Gm-Gg: AYBFou3HKwiChr/Je8+a2Zpzw7jMcT5UTJHwZQjPDovbxFzE35Z0ZqsOtyhwYlxdvGh
 QKwPv6JFg8CQbkSfwCHMlvAD0zTE37Y+XJbsjQ0bBguBk6Oh+loO2q6DFZkg1e4lcivRzdLibT4
 qizulZ5fVFNyQB5OZiDecqT3pcgaruXACeN123ufMNVQzOh5hmOG8DgvQWozsURIya9KDtqij8Q
 HK9IslKPH4IUYLlXE4i5RfTckjS8fLNKDfT/4/MigKspQft2LW2nVyQ+PLrwXVtY6k7gYvuuD1k
 UaYCEreSFz+2V2OTbsN434Y8z8AtdREP1T7zz7SUmm9XE62lUYLzetFqXVizUjiP0/hMnl8oMuG
 av++dglVw9FnLBI/T1HaHCPNlu1dgbMd0P1Rc2DlAS2NgSoUoW5VXbJ3dl7nN0tqojkqczyuWXM
 qwprwfll4tvF8GHzn9kPGlmIfHOCl9TV1EdjI9HT9heX85W/Zu+dTLExEKLnxueFf9CSKPcCIce
 pPiXAMmQqY8zyvmZlA4OTMPjcbK8tKR15OeqdG1JVdwXm81u7p3B/BrazLf3ZPDg8A5+qblOHFu
 zKYoPLZUcIj5wngK2LMzRFMt899TKoCNJL1WJLD48X0MLO5u/18dva/c4pdL
X-Received: by 2002:a05:6000:4b1e:b0:488:890f:6f4b with SMTP id
 ffacd0b85a97d-48af0cc8e85mr4464787f8f.10.1790687806508; 
 Tue, 29 Sep 2026 06:16:46 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af5030037sm4683350f8f.8.2026.09.29.06.16.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 06:16:46 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 29 Sep 2026 13:16:31 +0000
To: ralf_lici <ralf@mandelbit.com>, plaisthos <arne-openvpn@rfc2549.org>,
 flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 19
X-Gerrit-Change-Id: If04ce09d4c353f5384c0c48f48f63e05869a373f
X-Gerrit-Change-Number: 1745
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1745?usp=email>
X-Gerrit-Commit: 44eefe30d48e9f18fa1123ae50336228e5e95977
In-Reply-To: <gerrit.1782719911000.If04ce09d4c353f5384c0c48f48f63e05869a373f@gerrit.openvpn.net>
References: <gerrit.1782719911000.If04ce09d4c353f5384c0c48f48f63e05869a373f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklmMDRjZTA5ZDRjMzUzZjUzODRjMGM0OGY0OGY2M2UwNTg2OWEzNzNmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5e3ea1cd20ce49aaa25cd8007426b89f59147627-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBXhV-0001FT-9S
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
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, frank@lichtenheld.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0733490832471506733=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0733490832471506733==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CI7ETFtK0Jc="; charset=UTF-8

--CI7ETFtK0Jc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, ralf_lici, s=
tipa=2E

Hello flichtenheld, plaisthos, ralf_lici, 

I'd like you to reexam=
ine a change=2E Please visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1745?usp=3Demail

to look at the new patch set (#19)=2E


Change subject: =
oob: Add client PROBE_REPLY parser
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

oob: Add client PROBE_REPLY parser

Add oob_client_r=
eply_read(), the client-side counterpart of
oob_server_probe_read(): it sca=
ns a received PROBE_REPLY for the probe
reply TLV, skipping other and futur=
e TLV types that are marked
optional=2E The reply's request_id names the pr=
obe it answers, with
which the client matches the reply to its probe=2E

Ex=
ercised by unit tests; the client probe path calls it in a follow-up=2E

Ch=
ange-Id: If04ce09d4c353f5384c0c48f48f63e05869a373f
Signed-off-by: Lev Stipa=
kov <lev@openvpn=2Enet>
---
M src/openvpn/oob=2Ec
M src/openvpn/oob=2Eh
M t=
ests/unit_tests/openvpn/test_oob=2Ec
3 files changed, 123 insertions(+), 0 =
deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/c=
hanges/45/1745/19

diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec
i=
ndex 9d45d64=2E=2Ea02ce51 100644
--- a/src/openvpn/oob=2Ec
+++ b/src/openvp=
n/oob=2Ec
@@ -93,6 +93,14 @@
 }
 
 bool
+oob_client_reply_read(struct buffe=
r *payload, struct oob_probe_reply *reply)
+{
+    struct buffer value;
+  =
  return ctrl_msg_find_tlv(payload, OOB_TLV_PROBE_REPLY, &value)
+         =
  && oob_probe_reply_read(&value, reply);
+}
+
+bool
 oob_timestamp_in_wind=
ow(uint64_t probe_ts, uint64_t now, uint64_t window_secs)
 {
     uint64_t =
diff =3D (now > probe_ts) ? (now - probe_ts) : (probe_ts - now);
diff --git=
 a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh
index c5ebad0=2E=2E3677149 100=
644
--- a/src/openvpn/oob=2Eh
+++ b/src/openvpn/oob=2Eh
@@ -115,6 +115,16 @=
@
 bool oob_server_probe_read(struct buffer *payload, struct oob_probe_requ=
est *req);
 
 /**
+ * Read a received OOB PROBE_REPLY: scan its payload for=
 the probe reply TLV;
+ * the client-side counterpart of oob_server_probe_r=
ead()=2E
+ *
+ * @param payload  buffer positioned at the start of the OOB =
message payload
+ * @param reply    filled with the parsed probe reply on s=
uccess
+ * @return true if a well-formed probe reply was found, false other=
wise
+ */
+bool oob_client_reply_read(struct buffer *payload, struct oob_pr=
obe_reply *reply);
+
+/**
  * Check whether a probe timestamp is within an =
acceptable window around the
  * current time=2E Used to cheaply drop repla=
yed or implausibly-timed probes
  * before doing any further work (see the =
probe request timestamp rationale
diff --git a/tests/unit_tests/openvpn/tes=
t_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec
index 0c9e79b=2E=2E130022=
a 100644
--- a/tests/unit_tests/openvpn/test_oob=2Ec
+++ b/tests/unit_tests=
/openvpn/test_oob=2Ec
@@ -548,6 +548,106 @@
     gc_free(&gc);
 }
 
+/* A P=
ROBE_REPLY carrying a probe reply is found by the client scan, with all
+ *=
 fields surviving=2E */
+static void
+test_client_reply_read_finds_reply(vo=
id **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf=
 =3D alloc_buf_gc(128, &gc);
+
+    struct oob_probe_reply in =3D {
+      =
  =2Erequest_id =3D 7,
+        =2Epriority =3D 5,
+        =2Eweight =3D 5=
0,
+        =2Emax_latency_diff =3D 25,
+        =2Econnect_lifetime =3D 12=
0,
+        =2Eflags =3D 1,
+    };
+    assert_true(oob_probe_reply_write(=
&buf, &in));
+
+    struct oob_probe_reply out =3D { 0 };
+    assert_true(=
oob_client_reply_read(&buf, &out));
+    assert_int_equal(out=2Erequest_id,=
 in=2Erequest_id);
+    assert_int_equal(out=2Epriority, in=2Epriority);
+ =
   assert_int_equal(out=2Eweight, in=2Eweight);
+    assert_int_equal(out=
=2Emax_latency_diff, in=2Emax_latency_diff);
+    assert_int_equal(out=2Eco=
nnect_lifetime, in=2Econnect_lifetime);
+    assert_int_equal(out=2Eflags, =
in=2Eflags);
+
+    gc_free(&gc);
+}
+
+/* TLVs other than the probe reply =
are skipped=2E */
+static void
+test_client_reply_read_skips_unknown(void *=
*state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D=
 alloc_buf_gc(128, &gc);
+
+    assert_true(ctrl_msg_tlv_write_header(&buf,=
 0x7ff, true, 4));
+    assert_true(buf_write_u32(&buf, 0xabad1dea));
+    =
struct oob_probe_reply in =3D { =2Epriority =3D 7 };
+    assert_true(oob_p=
robe_reply_write(&buf, &in));
+
+    struct oob_probe_reply out =3D { 0 };
=
+    assert_true(oob_client_reply_read(&buf, &out));
+    assert_int_equal(=
out=2Epriority, 7);
+
+    gc_free(&gc);
+}
+
+/* As on the probe side, a m=
andatory TLV we do not understand -- here trailing
+ * the probe reply -- i=
nvalidates the reply=2E */
+static void
+test_client_reply_read_rejects_unk=
nown_mandatory(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    =
struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    struct oob_probe_reply=
 in =3D { =2Epriority =3D 7 };
+    assert_true(oob_probe_reply_write(&buf,=
 &in));
+    assert_true(ctrl_msg_tlv_write_header(&buf, 0x7ff, false, 4));=

+    assert_true(buf_write_u32(&buf, 0xabad1dea));
+
+    struct oob_probe=
_reply out =3D { 0 };
+    assert_false(oob_client_reply_read(&buf, &out));=

+
+    gc_free(&gc);
+}
+
+/* A payload with no probe reply is rejected=2E=
 */
+static void
+test_client_reply_read_missing(void **state)
+{
+    stru=
ct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &=
gc);
+
+    assert_true(ctrl_msg_tlv_write_header(&buf, 0x7ff, true, 4));
+=
    assert_true(buf_write_u32(&buf, 0));
+
+    struct oob_probe_reply out =
=3D { 0 };
+    assert_false(oob_client_reply_read(&buf, &out));
+
+    gc_=
free(&gc);
+}
+
+/* Likewise, a payload carrying a probe request instead is=
 not a PROBE_REPLY=2E */
+static void
+test_client_reply_read_request_tlv(v=
oid **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer bu=
f =3D alloc_buf_gc(128, &gc);
+
+    const struct oob_probe_request in =3D =
{ =2Erequest_id =3D 7 };
+    assert_true(oob_probe_request_write(&buf, &in=
));
+
+    struct oob_probe_reply out =3D { 0 };
+    assert_false(oob_clie=
nt_reply_read(&buf, &out));
+
+    gc_free(&gc);
+}
+
 /* The OOB tests run=
 as a second group of pkt_testdriver; see test_pkt=2Ec=2E */
 int
 run_oob_=
tests(void)
@@ -574,6 +674,11 @@
         cmocka_unit_test(test_server_prob=
e_check_valid),
         cmocka_unit_test(test_server_probe_check_stale),
 =
        cmocka_unit_test(test_server_probe_check_no_request),
+        cmoc=
ka_unit_test(test_client_reply_read_finds_reply),
+        cmocka_unit_test=
(test_client_reply_read_skips_unknown),
+        cmocka_unit_test(test_clie=
nt_reply_read_rejects_unknown_mandatory),
+        cmocka_unit_test(test_cl=
ient_reply_read_missing),
+        cmocka_unit_test(test_client_reply_read_=
request_tlv),
     };
 
     return cmocka_run_group_tests_name("oob tests"=
, tests, NULL, NULL);

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1745?usp=3Demail
To unsubscribe, or for help writing mail filters,=
 visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: If04ce09d4c353f5384c0c48f48f63e05869a373f
Gerrit-Change-Number: 1745
G=
errit-PatchSet: 19
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Revie=
wer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-A=
ttention: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: stipa <lstipak=
ov@gmail=2Ecom>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>

--CI7ETFtK0Jc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, ralf_lici, stipa=2E </p>
<p>=
stipa <strong>uploaded patch set #19</strong> to this change=2E</p><p><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1745?usp=3Demail">View Chan=
ge</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">oob: Add client PROBE_REPLY parser<br><br>Add oob_c=
lient_reply_read(), the client-side counterpart of<br>oob_server_probe_read=
(): it scans a received PROBE_REPLY for the probe<br>reply TLV, skipping ot=
her and future TLV types that are marked<br>optional=2E The reply&#39;s req=
uest_id names the probe it answers, with<br>which the client matches the re=
ply to its probe=2E<br><br>Exercised by unit tests; the client probe path c=
alls it in a follow-up=2E<br><br>Change-Id: If04ce09d4c353f5384c0c48f48f63e=
05869a373f<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<=
br>M src/openvpn/oob=2Ec<br>M src/openvpn/oob=2Eh<br>M tests/unit_tests/ope=
nvpn/test_oob=2Ec<br>3 files changed, 123 insertions(+), 0 deletions(-)<br>=
<br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn=
 refs/changes/45/1745/19</pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/src/openvpn/oob=2Ec b/src/ope=
nvpn/oob=2Ec</span><br><span>index 9d45d64=2E=2Ea02ce51 100644</span><br><s=
pan>--- a/src/openvpn/oob=2Ec</span><br><span>+++ b/src/openvpn/oob=2Ec</sp=
an><br><span>@@ -93,6 +93,14 @@</span><br><span> }</span><br><span> </span>=
<br><span> bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_=
client_reply_read(struct buffer *payload, struct oob_probe_reply *reply)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct buffer value;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    return ctrl_msg_find_tlv(payloa=
d, OOB_TLV_PROBE_REPLY, &amp;value)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+           &amp;&amp; oob_probe_reply_read(&amp;value, repl=
y);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+bool</span><br><span> oob_timestamp_in_window(uint64_=
t probe_ts, uint64_t now, uint64_t window_secs)</span><br><span> {</span><b=
r><span>     uint64_t diff =3D (now &gt; probe_ts) ? (now - probe_ts) : (pr=
obe_ts - now);</span><br><span>diff --git a/src/openvpn/oob=2Eh b/src/openv=
pn/oob=2Eh</span><br><span>index c5ebad0=2E=2E3677149 100644</span><br><spa=
n>--- a/src/openvpn/oob=2Eh</span><br><span>+++ b/src/openvpn/oob=2Eh</span=
><br><span>@@ -115,6 +115,16 @@</span><br><span> bool oob_server_probe_read=
(struct buffer *payload, struct oob_probe_request *req);</span><br><span> <=
/span><br><span> /**</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * Read a received OOB PROBE_REPLY: scan its payload for the probe reply T=
LV;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the client-si=
de counterpart of oob_server_probe_read()=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @param payload  buffer positioned at the start of the OOB messag=
e payload</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param =
reply    filled with the parsed probe reply on success</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @return true if a well-formed probe r=
eply was found, false otherwise</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool=
 oob_client_reply_read(struct buffer *payload, struct oob_probe_reply *repl=
y);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span>  * Check wheth=
er a probe timestamp is within an acceptable window around the</span><br><s=
pan>  * current time=2E Used to cheaply drop replayed or implausibly-timed =
probes</span><br><span>  * before doing any further work (see the probe req=
uest timestamp rationale</span><br><span>diff --git a/tests/unit_tests/open=
vpn/test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>in=
dex 0c9e79b=2E=2E130022a 100644</span><br><span>--- a/tests/unit_tests/open=
vpn/test_oob=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_oob=2E=
c</span><br><span>@@ -548,6 +548,106 @@</span><br><span>     gc_free(&amp;g=
c);</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/* A PROBE_REPLY carrying a probe reply is found by th=
e client scan, with all</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * fields surviving=2E */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+test_client_reply_read_finds_reply(void **state)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &=
amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_reply in =
=3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Ereq=
uest_id =3D 7,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   =2Epriority =3D 5,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        =2Eweight =3D 50,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        =2Emax_latency_diff =3D 25,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        =2Econnect_lifetime =3D 120,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        =2Eflags =3D 1,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_probe_reply_write(&am=
p;buf, &amp;in));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_=
reply out =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_true(oob_client_reply_read(&amp;buf, &amp;out));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(out=2Erequest=
_id, in=2Erequest_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_int_equal(out=2Epriority, in=2Epriority);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(out=2Eweight, in=
=2Eweight);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_int_equal(out=2Emax_latency_diff, in=2Emax_latency_diff);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(out=2Econnect=
_lifetime, in=2Econnect_lifetime);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_int_equal(out=2Eflags, in=2Eflags);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* TLVs othe=
r than the probe reply are skipped=2E */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+test_client_reply_read_skips_unknown(void **state)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_=
buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(c=
trl_msg_tlv_write_header(&amp;buf, 0x7ff, true, 4));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;buf, 0=
xabad1dea));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct oob_probe_reply in =3D { =2Epriority =3D 7 };</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_true(oob_probe_reply_write(&amp;bu=
f, &amp;in));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_repl=
y out =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_true(oob_client_reply_read(&amp;buf, &amp;out));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(out=2Epriority, 7=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/* As on the probe side, a mandatory TLV we do not understand -- here t=
railing</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the probe=
 reply -- invalidates the reply=2E */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+test_client_reply_read_rejects_unknown_mandatory(void **state)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =
=3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct oob_probe_reply in =3D { =2Epriority =3D 7 };</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_true(oob_probe_reply_write(&amp;bu=
f, &amp;in));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_true(ctrl_msg_tlv_write_header(&amp;buf, 0x7ff, false, 4));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(=
&amp;buf, 0xabad1dea));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_=
probe_reply out =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_false(oob_client_reply_read(&amp;buf, &amp;out));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A p=
ayload with no probe reply is rejected=2E */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+test_client_reply_read_missing(void **state)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_bu=
f_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctr=
l_msg_tlv_write_header(&amp;buf, 0x7ff, true, 4));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;buf, 0));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_reply out =3D { 0=
 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false=
(oob_client_reply_read(&amp;buf, &amp;out));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/* Likewise, a payload carryi=
ng a probe request instead is not a PROBE_REPLY=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+test_client_reply_read_request_tlv(void **state)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf=
 =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst struct oob_probe_request in =3D { =2Erequest_id =3D 7 };</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_probe_request_=
write(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct o=
ob_probe_reply out =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_false(oob_client_reply_read(&amp;buf, &amp;out));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span> /* The OOB tests run as a second group =
of pkt_testdriver; see test_pkt=2Ec=2E */</span><br><span> int</span><br><s=
pan> run_oob_tests(void)</span><br><span>@@ -574,6 +674,11 @@</span><br><sp=
an>         cmocka_unit_test(test_server_probe_check_valid),</span><br><spa=
n>         cmocka_unit_test(test_server_probe_check_stale),</span><br><span=
>         cmocka_unit_test(test_server_probe_check_no_request),</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_c=
lient_reply_read_finds_reply),</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        cmocka_unit_test(test_client_reply_read_skips_unknown),<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_=
test(test_client_reply_read_rejects_unknown_mandatory),</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_client_re=
ply_read_missing),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       cmocka_unit_test(test_client_reply_read_request_tlv),</span><br><spa=
n>     };</span><br><span> </span><br><span>     return cmocka_run_group_te=
sts_name(&quot;oob tests&quot;, tests, NULL, NULL);</span><br></pre><p>To v=
iew, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1745?usp=3D=
email">change 1745</a>=2E To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setti=
ngs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActi=
on"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1745?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div=
>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D=
"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> G=
errit-Change-Id: If04ce09d4c353f5384c0c48f48f63e05869a373f </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Number: 1745 </div>
<div style=3D"display=
:none"> Gerrit-PatchSet: 19 </div>
<div style=3D"display:none"> Gerrit-Owne=
r: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ralf_lici &=
lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: =
openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipa=
kov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: p=
laisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
=

</body></html>
--CI7ETFtK0Jc=--


--===============0733490832471506733==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0733490832471506733==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0733490832471506733==--

