Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F70C982CD
	for <openvpn-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RIGvLDaqAY6iUOmuB+8QW1cuZmwVaRXVy6NXqGS1OkE=; b=aJ6MfnHFYIDIhCLyfEHSkYqC/R
	jsj2krC0iG4DS55PH5P7L3twECV+1m0THerXboGfFKVzQqIfG9jnb6weeGFE9G6Z9FUNbgyKGhisB
	KU69cO1t68D8SPozV0Z1QYg9BcanPJ5UkrgSNjwqAoOoatJGs+jUHSqprRjILv1Avui8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x767m-000624-LW;
	Thu, 17 Sep 2026 07:01:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x767j-00061x-Ez
 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 07:01:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=cQHjhcIYgyoC9UlCVr0h9gcTTYud8tw8Mq6WzVuCNX0=; b=RX2rylGmvOclrwHqjHi91abSZ0
 2lKLSc5LhExRQ+CcNfZqis3/JDiuRnIhwTUPUDvTyBp28bL7Tg35PM4REtkab95Z/MootwFeuSFQZ
 HYy9ukWKQrxaBmGfqt3EWHh5V6VfNB+BQYXJ2In7giTBRTfv4zBf332eV4UqQkflwIM4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=cQHjhcIYgyoC9UlCVr0h9gcTTYud8tw8Mq6WzVuCNX0=; b=Q
 05ok8RQeQR7ddNLWiDwgr7UYG4is+QZ/pPI0iOc8I1cpwCCgfZivjZRuXJCOnXn88VYammnEJsqNO
 ObTgijJ0Fg2iaH8krF5dhrqYOVX1s/K16BTdC8HPp5C5oEY6fjDX+gUg7ROdP0QKkOV9sb5M4CWm8
 3tYZLiT7pvSkSK30=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x767g-0003qa-7v for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 07:01:36 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912d391aso3594365e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 17 Sep 2026 00:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789628486; x=1790233286; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cQHjhcIYgyoC9UlCVr0h9gcTTYud8tw8Mq6WzVuCNX0=;
 b=OLk0L3+gJdH139BaW3xQ//YIK0QCaruGV1CFbBIyyeWIcUmLMwFFX+yuwQJ6NCFQKz
 Sc4Nw20MVKgFAaMoFTUNpQxfVKORRtAxRrvlX3n1JioHm77ZDrzj4v/RFz4QcMNTtGnS
 WNK/Yy0n7inSAdt1scu4RyvxiGWYv41iRKDb5HmZzc0AhDeCyCCxGu50pA+vIxcFL+Ua
 2ZPjKTh3Jh3hnhyU4cqc7SLuwniglIzeLqdm6ANR0VTiorYynGpjkNcYWx3YAQkfBVIG
 0nb6rTXeqgOQUYtrDghJj+l2wft1ihU8HW+VDfA/LK30oFgnR5T+V3C8jdC5o8tyUZHP
 UiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789628486; x=1790233286;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cQHjhcIYgyoC9UlCVr0h9gcTTYud8tw8Mq6WzVuCNX0=;
 b=kJ0FWqWdJ2TuLXy3KsW45qey5GQXpuYlTcF8PPwUDgYS2GlAIztwbV+U3bnQA8vJAy
 yDWRPxYfTt/NAUQ8ktRwY4/Pa3TjzH1JUsXxIDp5O6KnJRgg/OBfMekQiWf56v/Yh8Bs
 pOPP8wD/xL7al2yKrwrgoQWgxg0KR3Tai0QbNTnOR1j0NHu1tk0FK2joNiCsDpfDwEym
 bhefsN+E0uZSUF7FZp8dOuopFWSLhxQ+TV7Q5HksC95DppUPOjwW89LQ2TPIJnKfZOv8
 dY2TT5kgo1r7WUIlLqgafcF6rVMeMxrt+C67tN2E/D8ls5KMnbAOxGy5unpo81Kz53mJ
 BsTA==
X-Gm-Message-State: AFuF++mTI1GJpe+/R5ez9MDeBobtZYIdYweBGggryqeDmT4E7M6+/PEr
 1w7fLL0ljnJUcdIEvqODvDU9QOgbZBb42ONOnhLKFAe5n7yU4s4KYrGe47TkzUqeetg2QdwkVqP
 aZ33kDlLX/fOBLKv3Yo9crRj6h2gwv3FtJeEw0P3mrC77ddcrBSD/5UDn+7Rxlp8mmYG2IYSBnr
 YU/SQXDw==
X-Gm-Gg: AYBFou0vDrTOezbTJBQ8ygEDZI00hfeM73lJyrnEBt0bfHJNvG9NRYqQlTVBFCGdO5c
 CVlk5/j7Y9e6Uo5jCftPY6b5aL7E83+kE9PuINF+tOqWR3n52WJzN/2GYsH5RmjD9zungc377GM
 h6XlU/zO7eWb6ZbU8wVyKQ6LhCWaPE4ESxujiNMPoiM0k0yDnBr/rRXiEuL9mLccmFQravcjPsW
 sjpxJ4z7hohugg1LNt5rDw14qJ6OGVEJ81oGFHJU3fl9czs9ob1ZO2zSFC+EQIK540u0EsnjE5R
 l/DgHXdI0INEpIvOKJnrCpMMly8yo8VktwsF1FapJANKPBuk7QN1eSx9zh8p54oJhEoOHxhKR94
 wxlE3i6W99UcLNVRtBpoLb+1XMoiem92Iau0hMZwKqOVBsKbdp21EbitQ/SQBlcSiB4LqJ+wc8/
 40teXUWyPOe6JAiZiTPowq9HA+IcO/kCV/X0d2Cy5DRXfvBMRMb14jgvx+TSOKBg2ArqOTCGpQV
 uWFMB+kGVyqXgcJnY3vOQgmxdDmovPbZHO6dDs/tV+Q/3mfBN6ldv2cBYUU5F804L9vg4S1fb9u
 agn1mfBpqdqKrVVBZLICEcnG/PzW/WVq+LrgTAziJi5EUTSLR9+NnTiiAcyogw==
X-Received: by 2002:a05:600c:19c9:b0:49d:34:420d with SMTP id
 5b1f17b1804b1-49eb732e47fmr61673265e9.20.1789628485405; 
 Thu, 17 Sep 2026 00:01:25 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd17051fsm52751845e9.0.2026.09.17.00.01.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 00:01:24 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 17 Sep 2026 07:01:11 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>,
 ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 16
X-Gerrit-Change-Id: If04ce09d4c353f5384c0c48f48f63e05869a373f
X-Gerrit-Change-Number: 1745
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1745?usp=email>
X-Gerrit-Commit: a582e09d78c49d79f9ee9c107c43a015485796e5
In-Reply-To: <gerrit.1782719911000.If04ce09d4c353f5384c0c48f48f63e05869a373f@gerrit.openvpn.net>
References: <gerrit.1782719911000.If04ce09d4c353f5384c0c48f48f63e05869a373f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklmMDRjZTA5ZDRjMzUzZjUzODRjMGM0OGY0OGY2M2UwNTg2OWEzNzNmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f4c5d86995ee2c2a7c821132941e4a6014d8e004-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x767g-0003qa-7v
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
Content-Type: multipart/mixed; boundary="===============6745731772296302901=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6745731772296302901==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SL5HWtaMNBU="; charset=UTF-8

--SL5HWtaMNBU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, ralf_lici, s=
tipa=2E

Hello flichtenheld, plaisthos, ralf_lici, 

I'd like you to reexam=
ine a change=2E Please visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1745?usp=3Demail

to look at the new patch set (#16)=2E


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
ns the TLV payload of a received PROBE_REPLY
for the probe_reply TLV, skipp=
ing other/future TLV types that are marked
optional=2E Both readers use
the=
 shared ctrl_msg_find_tlv() from control_msg=2Eh for the scan=2E

Exercised=
 by unit tests; the client probe path calls it in a follow-up=2E

Change-Id=
: If04ce09d4c353f5384c0c48f48f63e05869a373f
Signed-off-by: Lev Stipakov <le=
v@openvpn=2Enet>
---
M src/openvpn/oob=2Ec
M src/openvpn/oob=2Eh
M tests/un=
it_tests/openvpn/test_oob=2Ec
3 files changed, 140 insertions(+), 0 deletio=
ns(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/=
45/1745/16

diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec
index c3=
e4bc9=2E=2E369e500 100644
--- a/src/openvpn/oob=2Ec
+++ b/src/openvpn/oob=
=2Ec
@@ -112,6 +112,23 @@
 }
 
 bool
+oob_client_reply_read(struct buffer *=
payload, struct oob_probe_reply *reply)
+{
+    if (!ctrl_msg_read_header(p=
ayload, OOB_MSG_PROBE_REPLY))
+    {
+        return false;
+    }
+
+    s=
truct buffer value;
+    if (!ctrl_msg_find_tlv(payload, OOB_TLV_PROBE_REPL=
Y, &value))
+    {
+        return false;
+    }
+
+    return oob_probe_re=
ply_read(&value, reply);
+}
+
+bool
 oob_timestamp_in_window(uint64_t probe=
_ts, uint64_t now, uint64_t window_secs)
 {
     uint64_t diff =3D (now > p=
robe_ts) ? (now - probe_ts) : (probe_ts - now);
diff --git a/src/openvpn/oo=
b=2Eh b/src/openvpn/oob=2Eh
index d8eca60=2E=2E21af63f 100644
--- a/src/ope=
nvpn/oob=2Eh
+++ b/src/openvpn/oob=2Eh
@@ -133,6 +133,19 @@
 bool oob_clien=
t_reply_write(struct buffer *buf, const struct oob_probe_reply *reply);
 
 =
/**
+ * Read a received OOB PROBE_REPLY: verify its message-type header, th=
en scan
+ * for the probe_reply TLV; the client-side counterpart of
+ * oob=
_server_probe_read()=2E Unknown TLV types marked optional are skipped; an
+=
 * unknown mandatory one rejects the reply=2E payload is consumed as it is =
read=2E
+ *
+ * @param payload  buffer positioned at the start of the OOB m=
essage payload
+ * @param reply    filled with the parsed probe_reply on su=
ccess
+ * @return true if the header matched and a well-formed probe_reply =
was found,
+ *         false otherwise
+ */
+bool oob_client_reply_read(str=
uct buffer *payload, struct oob_probe_reply *reply);
+
+/**
  * Check wheth=
er a probe timestamp is within an acceptable window around the
  * current =
time=2E Used to cheaply drop replayed or implausibly-timed probes
  * befor=
e doing any further work (see the probe_parameter timestamp rationale
diff =
--git a/tests/unit_tests/openvpn/test_oob=2Ec b/tests/unit_tests/openvpn/te=
st_oob=2Ec
index d98d86c=2E=2E5805cb5 100644
--- a/tests/unit_tests/openvpn=
/test_oob=2Ec
+++ b/tests/unit_tests/openvpn/test_oob=2Ec
@@ -509,6 +509,11=
1 @@
     gc_free(&gc);
 }
 
+/* A PROBE_REPLY carrying a probe_reply is fo=
und by the client scan, with all
+ * fields surviving=2E */
+static void
+t=
est_client_reply_read_finds_reply(void **state)
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
+        =2Emax_latency_diff =3D 25,
+        =2Econnect_lifetime =
=3D 120,
+        =2Eflags =3D 1,
+    };
+    memcpy(in=2Epeer_session_id=
=2Eid, "SRVREPLY", SID_SIZE);
+    assert_true(oob_client_reply_write(&buf,=
 &in));
+
+    struct oob_probe_reply out =3D { 0 };
+    assert_true(oob_c=
lient_reply_read(&buf, &out));
+    assert_memory_equal(out=2Epeer_session_=
id=2Eid, in=2Epeer_session_id=2Eid, SID_SIZE);
+    assert_int_equal(out=2E=
priority, in=2Epriority);
+    assert_int_equal(out=2Eweight, in=2Eweight);=

+    assert_int_equal(out=2Emax_latency_diff, in=2Emax_latency_diff);
+   =
 assert_int_equal(out=2Econnect_lifetime, in=2Econnect_lifetime);
+    asse=
rt_int_equal(out=2Eflags, in=2Eflags);
+
+    gc_free(&gc);
+}
+
+/* TLVs o=
ther than probe_reply are skipped=2E */
+static void
+test_client_reply_rea=
d_skips_unknown(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+   =
 struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    assert_true(buf_write=
_u16(&buf, OOB_MSG_PROBE_REPLY));
+    assert_true(ctrl_msg_tlv_write_heade=
r(&buf, 0x7ff, true, 4));
+    assert_true(buf_write_u32(&buf, 0xabad1dea))=
;
+    struct oob_probe_reply in =3D { =2Epriority =3D 7 };
+    assert_tru=
e(oob_probe_reply_write(&buf, &in));
+
+    struct oob_probe_reply out =3D =
{ 0 };
+    assert_true(oob_client_reply_read(&buf, &out));
+    assert_int=
_equal(out=2Epriority, 7);
+
+    gc_free(&gc);
+}
+
+/* As on the probe si=
de, a mandatory TLV we do not understand -- here trailing
+ * the probe_rep=
ly -- invalidates the reply=2E */
+static void
+test_client_reply_read_reje=
cts_unknown_mandatory(void **state)
+{
+    struct gc_arena gc =3D gc_new()=
;
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    assert_true(buf=
_write_u16(&buf, OOB_MSG_PROBE_REPLY));
+    struct oob_probe_reply in =3D =
{ =2Epriority =3D 7 };
+    assert_true(oob_probe_reply_write(&buf, &in));
=
+    assert_true(ctrl_msg_tlv_write_header(&buf, 0x7ff, false, 4));
+    as=
sert_true(buf_write_u32(&buf, 0xabad1dea));
+
+    struct oob_probe_reply o=
ut =3D { 0 };
+    assert_false(oob_client_reply_read(&buf, &out));
+
+    =
gc_free(&gc);
+}
+
+/* A payload with no probe_reply is rejected=2E */
+sta=
tic void
+test_client_reply_read_missing(void **state)
+{
+    struct gc_ar=
ena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+=
    assert_true(buf_write_u16(&buf, OOB_MSG_PROBE_REPLY));
+    assert_true=
(ctrl_msg_tlv_write_header(&buf, 0x7ff, true, 4));
+    assert_true(buf_wri=
te_u32(&buf, 0));
+
+    struct oob_probe_reply out =3D { 0 };
+    assert_=
false(oob_client_reply_read(&buf, &out));
+
+    gc_free(&gc);
+}
+
+/* Lik=
ewise, a PROBE_REPLY reader rejects a payload with the wrong message
+ * ty=
pe even when a valid probe_reply TLV follows=2E */
+static void
+test_clien=
t_reply_read_wrong_msg_type(void **state)
+{
+    struct gc_arena gc =3D gc=
_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    assert_tr=
ue(buf_write_u16(&buf, OOB_MSG_SERVER_PROBE));
+    struct oob_probe_reply =
in =3D { =2Epriority =3D 7 };
+    assert_true(oob_probe_reply_write(&buf, =
&in));
+
+    struct oob_probe_reply out =3D { 0 };
+    assert_false(oob_c=
lient_reply_read(&buf, &out));
+
+    gc_free(&gc);
+}
+
 int
 main(void)
 =
{
@@ -534,6 +639,11 @@
         cmocka_unit_test(test_server_probe_check_va=
lid),
         cmocka_unit_test(test_server_probe_check_stale),
         cm=
ocka_unit_test(test_server_probe_check_no_parameter),
+        cmocka_unit_=
test(test_client_reply_read_finds_reply),
+        cmocka_unit_test(test_cl=
ient_reply_read_skips_unknown),
+        cmocka_unit_test(test_client_reply=
_read_rejects_unknown_mandatory),
+        cmocka_unit_test(test_client_rep=
ly_read_missing),
+        cmocka_unit_test(test_client_reply_read_wrong_ms=
g_type),
     };
 
     return cmocka_run_group_tests_name("oob tests", tes=
ts, NULL, NULL);

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1745?usp=3Demail
To unsubscribe, or for help writing mail filters, visi=
t http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: n=
ewpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: =
If04ce09d4c353f5384c0c48f48f63e05869a373f
Gerrit-Change-Number: 1745
Gerrit=
-PatchSet: 16
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: =
flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attent=
ion: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld =
<frank@lichtenheld=2Ecom>
Gerrit-Attention: ralf_lici <ralf@mandelbit=2Ecom=
>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>

--SL5HWtaMNBU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, ralf_lici, stipa=2E </p>
<p>=
stipa <strong>uploaded patch set #16</strong> to this change=2E</p><p><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1745?usp=3Demail">View Chan=
ge</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">oob: Add client PROBE_REPLY parser<br><br>Add oob_c=
lient_reply_read(), the client-side counterpart of<br>oob_server_probe_read=
(): it scans the TLV payload of a received PROBE_REPLY<br>for the probe_rep=
ly TLV, skipping other/future TLV types that are marked<br>optional=2E Both=
 readers use<br>the shared ctrl_msg_find_tlv() from control_msg=2Eh for the=
 scan=2E<br><br>Exercised by unit tests; the client probe path calls it in =
a follow-up=2E<br><br>Change-Id: If04ce09d4c353f5384c0c48f48f63e05869a373f<=
br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M src/op=
envpn/oob=2Ec<br>M src/openvpn/oob=2Eh<br>M tests/unit_tests/openvpn/test_o=
ob=2Ec<br>3 files changed, 140 insertions(+), 0 deletions(-)<br><br></pre><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/45/1745/16</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2E=
c</span><br><span>index c3e4bc9=2E=2E369e500 100644</span><br><span>--- a/s=
rc/openvpn/oob=2Ec</span><br><span>+++ b/src/openvpn/oob=2Ec</span><br><spa=
n>@@ -112,6 +112,23 @@</span><br><span> }</span><br><span> </span><br><span=
> bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_client_re=
ply_read(struct buffer *payload, struct oob_probe_reply *reply)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (!ctrl_msg_read_header(payload, OOB_MSG_PR=
OBE_REPLY))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct buffer value;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (!ctrl_msg_find_tlv(payload, OOB_TLV_PROB=
E_REPLY, &amp;value))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retu=
rn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return oob_probe_reply_read(&amp;valu=
e, reply);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+bool</span><br><span> oob_timestamp_in_window(=
uint64_t probe_ts, uint64_t now, uint64_t window_secs)</span><br><span> {</=
span><br><span>     uint64_t diff =3D (now &gt; probe_ts) ? (now - probe_ts=
) : (probe_ts - now);</span><br><span>diff --git a/src/openvpn/oob=2Eh b/sr=
c/openvpn/oob=2Eh</span><br><span>index d8eca60=2E=2E21af63f 100644</span><=
br><span>--- a/src/openvpn/oob=2Eh</span><br><span>+++ b/src/openvpn/oob=2E=
h</span><br><span>@@ -133,6 +133,19 @@</span><br><span> bool oob_client_rep=
ly_write(struct buffer *buf, const struct oob_probe_reply *reply);</span><b=
r><span> </span><br><span> /**</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * Read a received OOB PROBE_REPLY: verify its message-type head=
er, then scan</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * for=
 the probe_reply TLV; the client-side counterpart of</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * oob_server_probe_read()=2E Unknown TLV=
 types marked optional are skipped; an</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * unknown mandatory one rejects the reply=2E payload is=
 consumed as it is read=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param =
payload  buffer positioned at the start of the OOB message payload</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @param reply    filled wi=
th the parsed probe_reply on success</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @return true if the header matched and a well-formed pr=
obe_reply was found,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *         false otherwise</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool oob=
_client_reply_read(struct buffer *payload, struct oob_probe_reply *reply);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span>  * Check whether a=
 probe timestamp is within an acceptable window around the</span><br><span>=
  * current time=2E Used to cheaply drop replayed or implausibly-timed prob=
es</span><br><span>  * before doing any further work (see the probe_paramet=
er timestamp rationale</span><br><span>diff --git a/tests/unit_tests/openvp=
n/test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>inde=
x d98d86c=2E=2E5805cb5 100644</span><br><span>--- a/tests/unit_tests/openvp=
n/test_oob=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_oob=2Ec<=
/span><br><span>@@ -509,6 +509,111 @@</span><br><span>     gc_free(&amp;gc)=
;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/* A PROBE_REPLY carrying a probe_reply is found by the =
client scan, with all</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * fields surviving=2E */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
test_client_reply_read_finds_reply(void **state)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &am=
p;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_reply in =
=3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Epri=
ority =3D 5,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 =2Eweight =3D 50,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       =2Emax_latency_diff =3D 25,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        =2Econnect_lifetime =3D 120,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        =2Eflags =3D 1,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    memcpy(in=2Epeer_session_id=2Eid, &quot;SRVREP=
LY&quot;, SID_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_true(oob_client_reply_write(&amp;buf, &amp;in));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct oob_probe_reply out =3D { 0 };</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_client_repl=
y_read(&amp;buf, &amp;out));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_memory_equal(out=2Epeer_session_id=2Eid, in=2Epeer_sess=
ion_id=2Eid, SID_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_int_equal(out=2Epriority, in=2Epriority);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(out=2Eweight, in=
=2Eweight);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_int_equal(out=2Emax_latency_diff, in=2Emax_latency_diff);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(out=2Econnect=
_lifetime, in=2Econnect_lifetime);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_int_equal(out=2Eflags, in=2Eflags);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* TLVs othe=
r than probe_reply are skipped=2E */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+test_client_reply_read_skips_unknown(void **state)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_=
gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_w=
rite_u16(&amp;buf, OOB_MSG_PROBE_REPLY));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;buf, 0=
x7ff, true, 4));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_true(buf_write_u32(&amp;buf, 0xabad1dea));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct oob_probe_reply in =3D { =2Eprior=
ity =3D 7 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_true(oob_probe_reply_write(&amp;buf, &amp;in));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct oob_probe_reply out =3D { 0 };</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_client_reply_read(=
&amp;buf, &amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_int_equal(out=2Epriority, 7);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/* As on the probe side, a mand=
atory TLV we do not understand -- here trailing</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * the probe_reply -- invalidates the reply=2E =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+test_client_reply_read_re=
jects_unknown_mandatory(void **state)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u16(&amp;buf, O=
OB_MSG_PROBE_REPLY));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct oob_probe_reply in =3D { =2Epriority =3D 7 };</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_probe_reply_writ=
e(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_true(ctrl_msg_tlv_write_header(&amp;buf, 0x7ff, false, 4));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_w=
rite_u32(&amp;buf, 0xabad1dea));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct oob_probe_reply out =3D { 0 };</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_false(oob_client_reply_read(&amp;buf, &amp;out))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/* A payload with no probe_reply is rejected=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+test_client_reply_read_missing(void **state)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =
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
4,6 +639,11 @@</span><br><span>         cmocka_unit_test(test_server_probe_=
check_valid),</span><br><span>         cmocka_unit_test(test_server_probe_c=
heck_stale),</span><br><span>         cmocka_unit_test(test_server_probe_ch=
eck_no_parameter),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       cmocka_unit_test(test_client_reply_read_finds_reply),</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_clie=
nt_reply_read_skips_unknown),</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        cmocka_unit_test(test_client_reply_read_rejects_unknown_m=
andatory),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c=
mocka_unit_test(test_client_reply_read_missing),</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_client_reply_rea=
d_wrong_msg_type),</span><br><span>     };</span><br><span> </span><br><spa=
n>     return cmocka_run_group_tests_name(&quot;oob tests&quot;, tests, NUL=
L, NULL);</span><br><span></span><br></pre><p>To view, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1745?usp=3Demail">change 1745</a>=2E=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"http://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsc=
ope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1745?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"=
display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If04ce=
09d4c353f5384c0c48f48f63e05869a373f </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 1745 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 16 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@=
gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flicht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvp=
n-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici =
&lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>

</body></html>
--SL5HWtaMNBU=--


--===============6745731772296302901==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6745731772296302901==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6745731772296302901==--

