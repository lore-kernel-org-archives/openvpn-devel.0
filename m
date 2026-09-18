Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA8EC88E75
	for <openvpn-devel@archiver.kernel.org>; Fri, 18 Sep 2026 08:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UdbCDQILb6HIB4z3c82D4qiL6KZwAA91HrXIW0Hjj1I=; b=gqrRJvC9OGRIU/tagPVeJT4fkF
	wdVCHagjxdbfIQsvQXpFiiBqI79++PMVxLR26XJ7SPPoud3iakOeDwfLnflfSd3BUGAlTki+kjtBZ
	GPFnqrFqG8DBXk+HdR8DNqxbzR2JfWuMWs5FBnmpU1ZAJipPM38raVCblouKw6LlPxXE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x7U0p-00060F-Sj;
	Fri, 18 Sep 2026 08:32:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x7U0n-000600-UH
 for openvpn-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 08:32:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=lXVYC+w9FW0evy+B3+Y1IcGhTNHBAczBTNCtk3w8lfU=; b=b2EwJ6tOaMQlSiVktgMpvLgDB1
 QSz8TIQWKyPafav3Zdwv5gR5rK1xnGHawzj+UOJ9ZihZUV1QTTWLD6bGiQ2WjZhHGucF+Ux4M/0MX
 HTWQuPZ13hhCmJfQgdodO1LjNkhnfVEOJ3m5LEYqDQgTOoDk55TmCYPo5iVI1HoLiehk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=lXVYC+w9FW0evy+B3+Y1IcGhTNHBAczBTNCtk3w8lfU=; b=U
 ycaRb8fAMuCmZWHpdmPqSE5d5EC//fAvgCAfFKv9+fKE64W5uKkoQtVbfklwsllf88HdMxMgYvwDm
 M2SzusJ+rUHrE3ahmsx2RykyyB5BCWrD4a6kenGO6uANiMzOiSX6d4/QGCjAI+3URI+wgrOdvRigL
 kyBs0iJSF4eC82G4=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x7U0l-0003Nx-3X for openvpn-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 08:32:02 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49b912d37b5so2924385e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 18 Sep 2026 01:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789720312; x=1790325112; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lXVYC+w9FW0evy+B3+Y1IcGhTNHBAczBTNCtk3w8lfU=;
 b=QC7hpoqogIQUZak5ChkOQH8mgBtsm2aau0CCJo+i+neXdc/NeOSC8rHXqay8bFqbFl
 2rB7jEPjkiKTIWJO90/rP+Y183tyLzuNEFy9l8SAIJexn6HcKgPQOU/5wLAoa2tZfD3M
 VVKHlF626NcO74N59mBAtW4lSlPSOEzgzGdEMlfe9pJWxvKOe5FLB0elFZR+qlTNLfRe
 ZKM1rcV9lQrYOjmfpq4w3vlqjgE7FlGC9iovqa6FuJKUEDAMKVTAARXummMb0houaGdd
 m/wT2AGmBouaH8OhmoGYupu9euGPZr3xYr8pm2kp7/gPJABduh+mhMjUkgAlHi0nPKs3
 nKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789720312; x=1790325112;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=lXVYC+w9FW0evy+B3+Y1IcGhTNHBAczBTNCtk3w8lfU=;
 b=wLmppqbdzAp65H5iqV1LNa/JSlR0Gh7McO55j8KtwhdobpeluhVydBxWerhXkfYQO0
 lcRymmWJwbUxXwF8O3+aa6rYPS0BN4eVaiwWjWdczkX2RS6UjXXSmlGNd6i3zLAQfjMU
 U4/L6IfX8nfJA3qECsgRd/sfw/bfbfdwOsWEGdLr07EXBtyuJk7mD952HCO4aU12xItD
 34FVPt8J2Vh0WfYcDDZbrbHh9bDplSwmqzW1nrEdutsHccKMI/Jxg6qBEXZuPUgf/9Ab
 fdeooVqCJPedb2sEp9EeT+k8DDMFZlFBVAmGIlDrYAonLbORV8l3gCm7D76/4Pwk0Bd8
 8Blw==
X-Gm-Message-State: AFuF++mY/W9iZzxl5nxYXRy6I3c79oceDQ1tTt8ueyhazxeqfuG+P9/k
 LSMMEqtFOEl3tdWUhhIsR9RfVw8M+xhC0RiSMkdUWWwW5r9zM1+MGgOOfgNdbDjEYdBoLDKXSUu
 9Q5FFiNzP3NXLmqGsAOvh6V6FPIafzbn5a299xx6C2GePT5BrHDbW4XMVIqWITkoIp+AH
X-Gm-Gg: AYBFou1oJ5EZcaO9z+3Lpd3zB5wOiZ4lhj4sRQIZowH2F5IeqHeenlZUZFDWJae6+xu
 sTy9r6iGFQZMajD7andwiTo8rqvF6mQPUerskWXOMjvU8jfmkIChvZG91QpAVegkpLRc+t91CAG
 GKtYHMV5ZjT9igTMOcuAJ7Yp/+TByOHbFRFcJFCOmPH6bHqQmQ+jE+X5LU3Cg70sXPi6fB3YFTL
 Qf14KchlvYH8Fl5hSNghzR8xyJBVju+yiPJ+u4NDHYTFp+EfWspVxNl8U84JP+7ItlHA84TP76m
 /IROrqfX5YyV8ZhYI5voG8Qp44TiGgp2ASlwO8VufBXLUtFNy3Ma8S1nWUuKeVBo9Q3NC/bZ6Ww
 u0OvJc/QmYjt1NrgdPGNyorOjbxnoGPIemEFs6dyjPyN1Pp23614vx4sygZ4JeEb6V+mYxczKsR
 23+G2PNV7wvjSPnOMTYgWyQTUAlyZf27mWiNIbeilHQ8KDN7zNgAL4fsubPglnHgGpUIdaGlkBT
 JSyQEMX52p12Lfuqvpxfsd86pORV2VQqCmfzVJGgT66l3k3nyk+hR8KtRN1YS6QzmUB6mytFtWm
 5z3Znlymgd/XC1T1M/14Y7NzdEquxLiNq2UytUO5kFsc+H3O6bVFrhUsPsSgDA==
X-Received: by 2002:a05:600c:4e50:b0:49c:ee20:e787 with SMTP id
 5b1f17b1804b1-49fc566443emr46192535e9.1.1789720312322; 
 Fri, 18 Sep 2026 01:31:52 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc7d1cca3sm32282565e9.11.2026.09.18.01.31.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 01:31:51 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 18 Sep 2026 08:31:39 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>,
 ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 17
X-Gerrit-Change-Id: If04ce09d4c353f5384c0c48f48f63e05869a373f
X-Gerrit-Change-Number: 1745
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1745?usp=email>
X-Gerrit-Commit: aa2e40a596f149e904cb65b62b1105983971e6f3
In-Reply-To: <gerrit.1782719911000.If04ce09d4c353f5384c0c48f48f63e05869a373f@gerrit.openvpn.net>
References: <gerrit.1782719911000.If04ce09d4c353f5384c0c48f48f63e05869a373f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklmMDRjZTA5ZDRjMzUzZjUzODRjMGM0OGY0OGY2M2UwNTg2OWEzNzNmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7501e717a72332279e403ceb1fb1d256859f2580-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x7U0l-0003Nx-3X
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
Content-Type: multipart/mixed; boundary="===============2080275191732035372=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2080275191732035372==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fqgtPdJoPSw="; charset=UTF-8

--fqgtPdJoPSw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, ralf_lici, s=
tipa=2E

Hello flichtenheld, plaisthos, ralf_lici, 

I'd like you to reexam=
ine a change=2E Please visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1745?usp=3Demail

to look at the new patch set (#17)=2E


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
45/1745/17

diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec
index 75=
ee840=2E=2E57542ad 100644
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
index d1f3828=2E=2E6fcf084 100644
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
 /* The OOB tests =
run as a second group of pkt_testdriver; see test_pkt=2Ec=2E */
 int
 run_o=
ob_tests(void)
@@ -534,6 +639,11 @@
         cmocka_unit_test(test_server_p=
robe_check_valid),
         cmocka_unit_test(test_server_probe_check_stale)=
,
         cmocka_unit_test(test_server_probe_check_no_parameter),
+       =
 cmocka_unit_test(test_client_reply_read_finds_reply),
+        cmocka_unit=
_test(test_client_reply_read_skips_unknown),
+        cmocka_unit_test(test=
_client_reply_read_rejects_unknown_mandatory),
+        cmocka_unit_test(te=
st_client_reply_read_missing),
+        cmocka_unit_test(test_client_reply_=
read_wrong_msg_type),
     };
 
     return cmocka_run_group_tests_name("oo=
b tests", tests, NULL, NULL);

-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1745?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: If04ce09d4c353f5384c0c48f48f63e05869a373f
Gerrit-Change-Numb=
er: 1745
Gerrit-PatchSet: 17
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Ge=
rrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plai=
sthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelb=
it=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet=
>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention=
: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Attention: ralf_lici <ralf@=
mandelbit=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>

--fqgtPdJoPSw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, ralf_lici, stipa=2E </p>
<p>=
stipa <strong>uploaded patch set #17</strong> to this change=2E</p><p><a hr=
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
es/45/1745/17</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2E=
c</span><br><span>index 75ee840=2E=2E57542ad 100644</span><br><span>--- a/s=
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
x d1f3828=2E=2E6fcf084 100644</span><br><span>--- a/tests/unit_tests/openvp=
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
> /* The OOB tests run as a second group of pkt_testdriver; see test_pkt=2E=
c=2E */</span><br><span> int</span><br><span> run_oob_tests(void)</span><br=
><span>@@ -534,6 +639,11 @@</span><br><span>         cmocka_unit_test(test_=
server_probe_check_valid),</span><br><span>         cmocka_unit_test(test_s=
erver_probe_check_stale),</span><br><span>         cmocka_unit_test(test_se=
rver_probe_check_no_parameter),</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        cmocka_unit_test(test_client_reply_read_finds_reply),</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_t=
est(test_client_reply_read_skips_unknown),</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        cmocka_unit_test(test_client_reply_read_reje=
cts_unknown_mandatory),</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        cmocka_unit_test(test_client_reply_read_missing),</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_cli=
ent_reply_read_wrong_msg_type),</span><br><span>     };</span><br><span> </=
span><br><span>     return cmocka_run_group_tests_name(&quot;oob tests&quot=
;, tests, NULL, NULL);</span><br><span></span><br></pre><p>To view, visit <=
a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1745?usp=3Demail">chang=
e 1745</a>=2E To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1745?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: If04ce09d4c353f5384c0c48f48f63e05869a373f </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 1745 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 17 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &=
lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@man=
delbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-dev=
el &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;fran=
k@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attentio=
n: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>

</body></h=
tml>
--fqgtPdJoPSw=--


--===============2080275191732035372==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2080275191732035372==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2080275191732035372==--

