Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 499A3C79FB8
	for <openvpn-devel@archiver.kernel.org>; Wed,  9 Sep 2026 07:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fSBumPRf5NsEmxE4R/1NmsEZIlxDv0ptpL0lzRrq7+8=; b=UL3F9Uc6q+oPyuWW3CPFrI1BpM
	0IUyMmYhoPUd4Zva2WSuJHTAZAqcc1YgEDaguu/API1DZjb1kI386dv7nRANYF8p+ibEVfTnPOsI/
	AGspHSzOZiu0gUAWpjWfqOrJfrLXCPFfHEmr5tj3S/2ZLhTIyMR8Ur5sUswgLnYrn2AU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4Cid-00061r-D8;
	Wed, 09 Sep 2026 07:27:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4CiJ-00061U-W0
 for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 07:27:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=boU0HpyeOs9YEACZnq0CyeowYRWIJq1/AHl/4DZwFNc=; b=epSW1tS/2b9ZmGNHb52IVDGbfD
 rivQmC11gEIaJdfF33AwCU8LAJHfwgsaYT5GdL/fsRzJBpCytiH55fzYdiPKIA5SeXj91nkpiq94c
 /V0DGyICQOPm07hlVRMCmJWE/AAco0xbg47IPcZ/1GYTR59eiKBKhrLGW10nuZoXie2s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=boU0HpyeOs9YEACZnq0CyeowYRWIJq1/AHl/4DZwFNc=; b=A
 JHaNrGwkL9J2+uA26yZr7ZVPf2J3WZek7/8tfsVC1yBDqeCJZTAOr4wBp86TTRf71DPsWOd7Sq6Nr
 ppMFcPAHY86mKVIRjLcNcyvY9hTK+aErbRQ7/njbon3Kyjvcoq2xLix5MzCi1g1hnwFqiw0mFGWFh
 +3MZU3tcFhvyTXtw=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4CiG-0008OD-4q for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 07:27:22 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-48586861639so3426417f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 09 Sep 2026 00:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788938833; x=1789543633; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=boU0HpyeOs9YEACZnq0CyeowYRWIJq1/AHl/4DZwFNc=;
 b=K9Yo3Hv5K1SbMCpdRTEd8zKYPEuzq4jAcjA2dYBmJEqXjT8iyHpsYd+TmGEZ5lLLto
 jFU3TAE/8hrxibDLuiTWebtmpD3ZS5gC0bCQvXKamotMps/l8emlWWWfqtiyMYJZVM3u
 myif5HayT/729L5fpLGTXlt4CsmGlQsSJkAIFlxxGMw9OFm4YSEEk1pG90tNKZdGHwqN
 7yu4CMZn7qBzQSPYQKaT8IMqKwxLwVJhyYy2JXB/Q0+DfRXXtT2P0XdAOWoRAwzfo3zk
 zwjxepyx42tRu1/PVygu1NMSSH92YUfs4RBn77ayRCKIwcki9hEFwd+vHIUy8d251TeS
 gd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788938833; x=1789543633;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=boU0HpyeOs9YEACZnq0CyeowYRWIJq1/AHl/4DZwFNc=;
 b=Mn4btgYAo6vDO8sFJI/4/WoozqYVwStd6ndNcsEjw8g4ySr668mNfc79cBm2gapnMu
 qIeRcWePbq6rKE0IJn/XygXX3gBGXH2L7bOgiAypj0XDtmwnlUUZZCTYz1oVumRBfIZ0
 +/1hh495wt+UpOZomidYf2fCirmQyp2+F88rZKZWhGnazz6JXGhkqX15rmI0Y6tk3Ngu
 BjK6Eqi6L4GnS5LlfuCgHf9z4Jsrjny9CFTncza4wnGsxMJmxo6kao7mMGC9qh9J7u0W
 JTzjvH5MTUdCZi/e1AukJzNhMcENtfIsF7CU6g93+lji0/kPyhIs9eMf6W5b8EfDV7eJ
 rUkA==
X-Gm-Message-State: AFuF++lfWstQI2QY7dFG93LDfPkyfudgrgNUJi2KewVk6H+xMZ7O+LLj
 8IBGLkRsx1SSoAS1fugZb+ywQj/yqCKjU7Vl1vELbRepTydPAwNofdfeGhaYI21iLnCUyGgiV9I
 7r4k6f6PG3JiiW+pNbDfw4dTWa6SXU7kgyhf42aLX8T7Aso4fjUi55QyfN4XGjleacRpW
X-Gm-Gg: AYBFou0Nq6lXGiqjYbTK94FA98S8OTsCCwQYsRLvfak+BZP5SFT/s2rZrMMv1UKBv+U
 ER0yg11Mgr/rJd7dL9d8wjMepBgWgegvTZ9RpZhDfExr0RHuBM3Axb5kOhOn1B+xKYxQDCtJ+Z/
 hovYlSuuFhbyhPYIYoHKkqpphKsXM+tW7uvZLEW6yHtHhQ2ozdEulRS+7vD81KKwAyuo0CBH+L3
 DRr7Tk4qGtoI5HkwTCDEQxrA1uwIyGKe0bxuXY82NvFL1FklzaG6cZbGVsTLV3PMxYs+1x8QK/G
 NIAFV6htUePXHWQqKNk6T/sgZG9huWtflQFUziZoN/DqgVVWzdN0JK6ZZxbAEUyv1Y5TU6WOqnt
 6SJrCt8DpX0+ZiQzgIpHAknJJNq+QOnH42JkoHy7kcMg+fgd2X0TSDXz9ytuike+nZxmi82bQOm
 NoAbqVugyZncqOSdrpRCYOhLj+4t1Z8beLtJrj5hkxBjfvTYGNa7vUu2RyHwP7QQv4NdaXx36Y2
 tq+lVcbTqj/04PilBT6fojKPxvqet7vjlwDdhmPyttV+Pj6mno5AjIGcmehORh6KL0MGHLdWo4h
 ZD54GTRneo1mUUFO1n1l5i4+3Z+ocR9Ccpu+F5/i9DXdhQnZsGvG264FjTPMlHDPE41+TEU1hQ=
 =
X-Received: by 2002:a5d:6508:0:b0:47f:e7f7:370f with SMTP id
 ffacd0b85a97d-4857e50ac36mr38665058f8f.10.1788938833282; 
 Wed, 09 Sep 2026 00:27:13 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885bbb51sm44562212f8f.30.2026.09.09.00.27.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 00:27:12 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 9 Sep 2026 07:27:02 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>,
 ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 13
X-Gerrit-Change-Id: If04ce09d4c353f5384c0c48f48f63e05869a373f
X-Gerrit-Change-Number: 1745
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1745?usp=email>
X-Gerrit-Commit: 9fbd7ea4380f1158846bb9346d3b6d35712e7a8f
In-Reply-To: <gerrit.1782719911000.If04ce09d4c353f5384c0c48f48f63e05869a373f@gerrit.openvpn.net>
References: <gerrit.1782719911000.If04ce09d4c353f5384c0c48f48f63e05869a373f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklmMDRjZTA5ZDRjMzUzZjUzODRjMGM0OGY0OGY2M2UwNTg2OWEzNzNmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a9513f78393adb6443a6d5cca58311a2f6e1c819-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4CiG-0008OD-4q
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
Content-Type: multipart/mixed; boundary="===============5567231573114908004=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5567231573114908004==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="naI8ehknEmc="; charset=UTF-8

--naI8ehknEmc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, ralf_lici, s=
tipa=2E

Hello flichtenheld, plaisthos, ralf_lici, 

I'd like you to reexam=
ine a change=2E Please visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1745?usp=3Demail

to look at the new patch set (#13)=2E

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

Add oob=
_client_reply_read(), the client-side counterpart of
oob_server_probe_read(=
): it scans the TLV payload of a received PROBE_REPLY
for the probe_reply T=
LV, skipping other/future TLV types that are marked
optional=2E Both reader=
s use
the shared ctrl_msg_find_tlv() from control_msg=2Eh for the scan=2E

=
Exercised by unit tests; the client probe path calls it in a follow-up=2E

=
Change-Id: If04ce09d4c353f5384c0c48f48f63e05869a373f
Signed-off-by: Lev Sti=
pakov <lev@openvpn=2Enet>
---
M src/openvpn/oob=2Ec
M src/openvpn/oob=2Eh
M=
 tests/unit_tests/openvpn/test_oob=2Ec
3 files changed, 140 insertions(+), =
0 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs=
/changes/45/1745/13

diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec=

index 3d48276=2E=2E45e3908 100644
--- a/src/openvpn/oob=2Ec
+++ b/src/open=
vpn/oob=2Ec
@@ -112,6 +112,23 @@
 }
 
 bool
+oob_client_reply_read(struct b=
uffer *payload, struct oob_probe_reply *reply)
+{
+    if (!ctrl_msg_read_h=
eader(payload, OOB_MSG_PROBE_REPLY))
+    {
+        return false;
+    }
+=

+    struct buffer value;
+    if (!ctrl_msg_find_tlv(payload, OOB_TLV_PRO=
BE_REPLY, &value))
+    {
+        return false;
+    }
+
+    return oob_p=
robe_reply_read(&value, reply);
+}
+
+bool
 oob_timestamp_in_window(uint64_=
t probe_ts, uint64_t now, uint64_t window_secs)
 {
     uint64_t diff =3D (=
now > probe_ts) ? (now - probe_ts) : (probe_ts - now);
diff --git a/src/ope=
nvpn/oob=2Eh b/src/openvpn/oob=2Eh
index 95bb594=2E=2E2c69fb6 100644
--- a/=
src/openvpn/oob=2Eh
+++ b/src/openvpn/oob=2Eh
@@ -133,6 +133,19 @@
 bool oo=
b_client_reply_write(struct buffer *buf, const struct oob_probe_reply *repl=
y);
 
 /**
+ * Read a received OOB PROBE_REPLY: verify its message-type hea=
der, then scan
+ * for the probe_reply TLV; the client-side counterpart of
=
+ * oob_server_probe_read()=2E Unknown TLV types marked optional are skippe=
d; an
+ * unknown mandatory one rejects the reply=2E payload is consumed as=
 it is read=2E
+ *
+ * @param payload  buffer positioned at the start of th=
e OOB message payload
+ * @param reply    filled with the parsed probe_repl=
y on success
+ * @return true if the header matched and a well-formed probe=
_reply was found,
+ *         false otherwise
+ */
+bool oob_client_reply_r=
ead(struct buffer *payload, struct oob_probe_reply *reply);
+
+/**
  * Chec=
k whether a probe timestamp is within an acceptable window around the
  * c=
urrent time=2E Used to cheaply drop replayed or implausibly-timed probes
  =
* before doing any further work (see the probe_parameter timestamp rational=
e
diff --git a/tests/unit_tests/openvpn/test_oob=2Ec b/tests/unit_tests/ope=
nvpn/test_oob=2Ec
index 1fdc5f8=2E=2E4091c9c 100644
--- a/tests/unit_tests/=
openvpn/test_oob=2Ec
+++ b/tests/unit_tests/openvpn/test_oob=2Ec
@@ -472,6 =
+472,111 @@
     gc_free(&gc);
 }
 
+/* A PROBE_REPLY carrying a probe_repl=
y is found by the client scan, with all
+ * fields surviving=2E */
+static =
void
+test_client_reply_read_finds_reply(void **state)
+{
+    struct gc_ar=
ena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+=
    struct oob_probe_reply in =3D {
+        =2Epriority =3D 5,
+        =
=2Eweight =3D 50,
+        =2Emax_latency_diff =3D 25,
+        =2Econnect_=
lifetime =3D 120,
+        =2Eflags =3D 1,
+    };
+    memcpy(in=2Epeer_se=
ssion_id=2Eid, "SRVREPLY", SID_SIZE);
+    assert_true(oob_client_reply_wri=
te(&buf, &in));
+
+    struct oob_probe_reply out =3D { 0 };
+    assert_tr=
ue(oob_client_reply_read(&buf, &out));
+    assert_memory_equal(out=2Epeer_=
session_id=2Eid, in=2Epeer_session_id=2Eid, SID_SIZE);
+    assert_int_equa=
l(out=2Epriority, in=2Epriority);
+    assert_int_equal(out=2Eweight, in=2E=
weight);
+    assert_int_equal(out=2Emax_latency_diff, in=2Emax_latency_dif=
f);
+    assert_int_equal(out=2Econnect_lifetime, in=2Econnect_lifetime);
+=
    assert_int_equal(out=2Eflags, in=2Eflags);
+
+    gc_free(&gc);
+}
+
+/=
* TLVs other than probe_reply are skipped=2E */
+static void
+test_client_r=
eply_read_skips_unknown(void **state)
+{
+    struct gc_arena gc =3D gc_new=
();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    assert_true(b=
uf_write_u16(&buf, OOB_MSG_PROBE_REPLY));
+    assert_true(ctrl_msg_tlv_wri=
te_header(&buf, 0x7ff, true, 4));
+    assert_true(buf_write_u32(&buf, 0xab=
ad1dea));
+    struct oob_probe_reply in =3D { =2Epriority =3D 7 };
+    as=
sert_true(oob_probe_reply_write(&buf, &in));
+
+    struct oob_probe_reply =
out =3D { 0 };
+    assert_true(oob_client_reply_read(&buf, &out));
+    as=
sert_int_equal(out=2Epriority, 7);
+
+    gc_free(&gc);
+}
+
+/* As on the =
probe side, a mandatory TLV we do not understand -- here trailing
+ * the p=
robe_reply -- invalidates the reply=2E */
+static void
+test_client_reply_r=
ead_rejects_unknown_mandatory(void **state)
+{
+    struct gc_arena gc =3D =
gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    assert_=
true(buf_write_u16(&buf, OOB_MSG_PROBE_REPLY));
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
+/* A payload with no probe_reply is rejected=2E=
 */
+static void
+test_client_reply_read_missing(void **state)
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
(buf_write_u32(&buf, 0));
+
+    struct oob_probe_reply out =3D { 0 };
+   =
 assert_false(oob_client_reply_read(&buf, &out));
+
+    gc_free(&gc);
+}
+=

+/* Likewise, a PROBE_REPLY reader rejects a payload with the wrong messag=
e
+ * type even when a valid probe_reply TLV follows=2E */
+static void
+te=
st_client_reply_read_wrong_msg_type(void **state)
+{
+    struct gc_arena g=
c =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    a=
ssert_true(buf_write_u16(&buf, OOB_MSG_SERVER_PROBE));
+    struct oob_prob=
e_reply in =3D { =2Epriority =3D 7 };
+    assert_true(oob_probe_reply_writ=
e(&buf, &in));
+
+    struct oob_probe_reply out =3D { 0 };
+    assert_fal=
se(oob_client_reply_read(&buf, &out));
+
+    gc_free(&gc);
+}
+
 int
 main=
(void)
 {
@@ -495,6 +600,11 @@
         cmocka_unit_test(test_server_probe_=
accept_valid),
         cmocka_unit_test(test_server_probe_accept_stale),
 =
        cmocka_unit_test(test_server_probe_accept_no_parameter),
+        c=
mocka_unit_test(test_client_reply_read_finds_reply),
+        cmocka_unit_t=
est(test_client_reply_read_skips_unknown),
+        cmocka_unit_test(test_c=
lient_reply_read_rejects_unknown_mandatory),
+        cmocka_unit_test(test=
_client_reply_read_missing),
+        cmocka_unit_test(test_client_reply_re=
ad_wrong_msg_type),
     };
 
     return cmocka_run_group_tests_name("oob =
tests", tests, NULL, NULL);

-- 
To view, visit http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1745?usp=3Demail
To unsubscribe, or for help writing mail fi=
lters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mes=
sageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: If04ce09d4c353f5384c0c48f48f63e05869a373f
Gerrit-Change-Number: =
1745
Gerrit-PatchSet: 13
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit=
-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaistho=
s <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=
=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: =
flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Attention: ralf_lici <ralf@ma=
ndelbit=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>

--naI8ehknEmc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, ralf_lici, stipa=2E </p>
<p>=
stipa <strong>uploaded patch set #13</strong> to this change=2E</p><p><a hr=
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
pn refs/changes/45/1745/13</pre><pre style=3D"font-family: monospace,monosp=
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
<span>index 1fdc5f8=2E=2E4091c9c 100644</span><br><span>--- a/tests/unit_te=
sts/openvpn/test_oob=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/tes=
t_oob=2Ec</span><br><span>@@ -472,6 +472,111 @@</span><br><span>     gc_fre=
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
> int</span><br><span> main(void)</span><br><span> {</span><br><span>@@ -49=
5,6 +600,11 @@</span><br><span>         cmocka_unit_test(test_server_probe_=
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
chSet: 13 </div>
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
--naI8ehknEmc=--


--===============5567231573114908004==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5567231573114908004==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5567231573114908004==--

