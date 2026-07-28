Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1503EC54F4C
	for <openvpn-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W3Ww63+wFVcqRVd5fKZiTNKRw+z3O2rDfQxCKWlVkbk=; b=c/FewvFZYvUiil0aUqDOZZ0xDJ
	1pvOD/FGwnsH9aUaw2jI+KwGQVo/nQfkTx3FLwDuRugWMg7gzPKT7Q2+AeR61xoTi/ZZcCXlJHb39
	nhH9GZ3NuVgR/ew7yu8ZEL5QyNiOo+PZ+GS1fEz9DJLoSyHb/EObX87jc5sCsaPdGzn0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wojLQ-0001sm-A7;
	Tue, 28 Jul 2026 15:03:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wojLP-0001se-TX
 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 15:03:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=pcK7YI8VlEWK6iUk9wkLyp2xLRnjBNGMpsnYMwXtRJc=; b=K/ENMWs6IvIu8iT3xA+2X/dY+a
 Q5cwsbcLsUaacnkJ/KH86T2yt0+VkHIq1Wh5t3/YpeopWpBNxb25zpVoPbZQ9E8DtfJ9TPTtZ/+8u
 I+kpGdQoXQwGgptyL90Fa1jHNaImsk1qAA5tockz0SvnUVKp+nsWnwoe6U9qqyjQpaho=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=pcK7YI8VlEWK6iUk9wkLyp2xLRnjBNGMpsnYMwXtRJc=; b=A
 dr+S/HtbLEz0iIV5vi0tyPLcExcnkTUsl4/UYVMWImKPgfRGXvirU5WG5W2XxqfGXnOmmht0EcvlF
 BB8NU7FKNxUHBWwTuRXkZlbMt8eTenniT1EKB1FfEBmJaUxh9/fmgE+UULZhaoGZs0NzGyJFvTu/h
 sk6PJiMAx8ECIuCA=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wojLQ-0000Pz-L8 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 15:03:47 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-495757ccbc1so36257475e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 28 Jul 2026 08:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785251018; x=1785855818; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pcK7YI8VlEWK6iUk9wkLyp2xLRnjBNGMpsnYMwXtRJc=;
 b=HQ0PWvrqWAjGQEEAezk3+YXuzmh4IpeggCMxRpSnfoPXAugQvppkYjwCXLXlSgmhwt
 J91X+Lh2WmiG5wqNBVItoZmbhJ+hpEcWreUScqhP+UlElYuibwlsddpXcLIdMq+LSnZ0
 fdtd70ZXx7ToA+rRSdh+3y8g8AOXzs+dIjQ0SnGf5gAf23dP1wDO427sP0wir39osDDY
 qmr9O5qm7Qr619h9NwBrP7XrtGfHDtwzfsKNBEBCY7EfTeiRONuTMWC0ECO/P6h6Eahc
 fT+aHUMIFNroxK4y6qZIIszTmsRaCVmSdtsklG4dn1R79zEuB1HdGTiJ/JSbTn9ST2yY
 31wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785251018; x=1785855818;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=pcK7YI8VlEWK6iUk9wkLyp2xLRnjBNGMpsnYMwXtRJc=;
 b=ffer8AMP6laGGs5ncunwiAS6QFD4oDMqvHTnyz4swsOH+8Y7xHXzv/77hpfgDAMYcn
 fzEJbiRANLiBfPolc3mla7Zakh/hcOJjqyW1vcoMMVtOnfiREoWFJHr7fwPuwwDHjxZV
 i4k/DswaC9Lg+9McelHZr1t2k6t3LaiC9Nuw9WoUo8WPfkQvBATd0g8NI8FTTJQ7uHbL
 Zl0Fe0ts3XfohvkSu8R2DD+BUAubXvTcwOLBBNoYtt09K+XN46PQIhVN4KlR4wYl74NG
 Er6Q8xPExVxpN5ug8gd+6tE3GQAJ+oxVnubgR1ZOMxc0N+WmVsqTNz8zF2fJpI/CTad2
 EWcA==
X-Gm-Message-State: AOJu0YwvpzRnpYYfYtSwJBlYxT4QsYqeXGHHSq242DtmD8TtG3ouKhwC
 2ZJ6DX6m0KXWZrXYDJs0ZwFIrMG9sEPgDFUjGoSZvOGa57he3W0zv/LLBDH3JAlxcAugXm7Y99E
 JQADt11r/RlgK2jZqv0KJghxIcFwMxBtNEss3GJ25xuF+ElR/Ll/I+P7g6jl2jtq7jU8E
X-Gm-Gg: AR+sD13UBqSbvaz2tbG4Ura6VeEi/vT/UqbaqLKl2fR6PFir878LEYRcxqrU7Xn93uM
 SFnUthFSx1FcBCrfG9rwt5prZJKHcPAkMSiRvWqUK1Qm6tKfR33HcP+Dzsr1OBfArffWkOsoW86
 P4k1FXjnTL679qUos6yYfYlIDBz39kP6zsHx9B/wyxPEm5FO8TYFiwoiyFB1R2T8QQUgTZmnUn1
 leTOG0mBk4ECqYnmYt1eCaqVasJiTc6VU9TLYgVaHWE2p3sBUokIJfkC1O0iGHXKgynv7PknPQk
 cJJk9BoMr+vRT87WAHAQHVzoflwgcbwdyy69KZ4sMwVWC6H4lg8wqWSccCjUeSZME/Hv5ONAVvP
 DCanKh+HQnjJmjJg2C+5IBxPRQMz4i7kwTghwZPwTGuvRdGr9mKTK/+LOjVKgdTEz/yPIVTdgoq
 tDr/kdtsRS3lQPX4ABSOFaHpWjkYV1UWJhMf+6MtNts1AvybW5IOkegBm3IT8CYpEDkdrorjbhK
 Wdgf2mP85ct4TeI6r+fpDgg8xy/uY5y5q6qu1VDpo55sRs0jELuzXQa8M4AsRjrhkW5
X-Received: by 2002:a05:600c:3103:b0:493:f278:ba2f with SMTP id
 5b1f17b1804b1-496c643219amr29717355e9.9.1785251018134; 
 Tue, 28 Jul 2026 08:03:38 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c462512dsm78527895e9.13.2026.07.28.08.03.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 08:03:37 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 28 Jul 2026 15:03:23 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30
X-Gerrit-Change-Number: 1742
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1742?usp=email>
X-Gerrit-Commit: a342918fab203bb635bcb53c314871e141eeb4d4
In-Reply-To: <gerrit.1782719911000.Iafa9efc1c156974ad9f5752e9de810a8c2f68c30@gerrit.openvpn.net>
References: <gerrit.1782719911000.Iafa9efc1c156974ad9f5752e9de810a8c2f68c30@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklhZmE5ZWZjMWMxNTY5NzRhZDlmNTc1MmU5ZGU4MTBhOGMyZjY4YzMwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <08a55a9de3548f84b53fd5fd72f7526fed43d544-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wojLQ-0000Pz-L8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Add
 SERVER_PROBE parsing and the probe-reply decision
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
Content-Type: multipart/mixed; boundary="===============1682716147966230387=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1682716147966230387==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="L9iYQIp5Isw="; charset=UTF-8

--L9iYQIp5Isw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, stipa=2E

Hello flichte=
nheld, plaisthos, 

I'd like you to reexamine a change=2E Please visit

   =
 http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail

to look at the=
 new patch set (#9)=2E

The following approvals got outdated and were remov=
ed:
Code-Review+2 by flichtenheld


Change subject: oob: Add SERVER_PROBE p=
arsing and the probe-reply decision
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

oob: Add SERVER_PROBE parsing and the probe-reply de=
cision

Add the message-level helpers the server needs to answer a probe:

=
  - oob_server_probe_read() scans the TLV payload of a received OOB
    SER=
VER_PROBE for the probe_parameter TLV, skipping other/future TLV
    types =
and rejecting malformed or truncated input=2E
  - oob_timestamp_in_window()=
 performs the cheap replay/skew check on the
    probe timestamp described =
in the wire protocol specification=2E
  - oob_build_probe_reply() composes =
the two: given a received SERVER_PROBE
    it scans for the probe_parameter=
, drops the probe if it is missing or
    its timestamp is outside the acce=
ptable window, and otherwise populates
    the probe_reply (echoing the pee=
r's session id) to send back=2E

These are pure functions exercised by unit=
 tests; the server packet path
calls oob_build_probe_reply() in a follow-up=
, which performs the actual send=2E

Change-Id: Iafa9efc1c156974ad9f5752e9d=
e810a8c2f68c30
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M src/op=
envpn/oob=2Ec
M src/openvpn/oob=2Eh
M tests/unit_tests/openvpn/test_oob=2Ec=

3 files changed, 289 insertions(+), 0 deletions(-)


  git pull ssh://gerr=
it=2Eopenvpn=2Enet:29418/openvpn refs/changes/42/1742/9

diff --git a/src/o=
penvpn/oob=2Ec b/src/openvpn/oob=2Ec
index c807171=2E=2E930b213 100644
--- =
a/src/openvpn/oob=2Ec
+++ b/src/openvpn/oob=2Ec
@@ -81,3 +81,54 @@
     r->=
flags =3D buf_read_u32(buf, NULL);
     return true;
 }
+
+bool
+oob_server=
_probe_write(struct buffer *buf, const struct oob_probe_parameter *param)
+=
{
+    return buf_write_u16(buf, OOB_MSG_SERVER_PROBE) && oob_probe_paramet=
er_write(buf, param);
+}
+
+bool
+oob_server_probe_read(struct buffer *payl=
oad, struct oob_probe_parameter *param)
+{
+    if (!ctrl_msg_read_header(p=
ayload, OOB_MSG_SERVER_PROBE))
+    {
+        return false;
+    }
+
+    =
struct buffer value;
+    if (!ctrl_msg_find_tlv(payload, OOB_TLV_PROBE_PAR=
AMETER, &value))
+    {
+        return false;
+    }
+
+    return oob_pro=
be_parameter_read(&value, param);
+}
+
+bool
+oob_timestamp_in_window(uint6=
4_t probe_ts, uint64_t now, uint64_t window_secs)
+{
+    uint64_t diff =3D=
 (now > probe_ts) ? (now - probe_ts) : (probe_ts - now);
+    return diff <=
=3D window_secs;
+}
+
+bool
+oob_build_probe_reply(struct buffer *probe_pay=
load, uint64_t now, uint64_t window_secs,
+                      const stru=
ct session_id *peer_sid, struct oob_probe_reply *reply)
+{
+    struct oob_=
probe_parameter param;
+    if (!oob_server_probe_read(probe_payload, &para=
m))
+    {
+        return false;
+    }
+
+    /* Drop replayed or implaus=
ibly-timed probes before doing any more work=2E */
+    if (!oob_timestamp_=
in_window(param=2Etimestamp, now, window_secs))
+    {
+        return fals=
e;
+    }
+
+    /* the caller's advertised values are kept; only the echo =
is ours to fill */
+    reply->peer_session_id =3D *peer_sid;
+    return t=
rue;
+}
diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh
index 0a9a4b=
b=2E=2E1afabbd 100644
--- a/src/openvpn/oob=2Eh
+++ b/src/openvpn/oob=2Eh
@=
@ -107,4 +107,58 @@
  */
 bool oob_probe_reply_read(struct buffer *buf, str=
uct oob_probe_reply *r);
 
+/**
+ * Write a complete SERVER_PROBE message (=
message-type header + probe_parameter
+ * TLV) to buf=2E Sent by the client=
=2E
+ */
+bool oob_server_probe_write(struct buffer *buf, const struct oob_=
probe_parameter *param);
+
+/**
+ * Read a received OOB SERVER_PROBE: verif=
y its message-type header, then scan
+ * for the probe_parameter TLV=2E TLV=
 types other than probe_parameter are
+ * skipped=2E payload is consumed as=
 it is read=2E
+ *
+ * @param payload  buffer positioned at the start of th=
e OOB message payload
+ * @param param    filled with the parsed probe_para=
meter on success
+ * @return true if the header matched and a well-formed p=
robe_parameter was
+ *         found, false otherwise
+ */
+bool oob_server=
_probe_read(struct buffer *payload, struct oob_probe_parameter *param);
+
+=
/**
+ * Check whether a probe timestamp is within an acceptable window arou=
nd the
+ * current time=2E Used to cheaply drop replayed or implausibly-tim=
ed probes
+ * before doing any further work (see the probe_parameter timest=
amp rationale
+ * in the wire protocol specification)=2E
+ *
+ * @param pro=
be_ts     timestamp from the probe_parameter (UNIX seconds)
+ * @param now =
         current time (UNIX seconds)
+ * @param window_secs  maximum allowe=
d difference, in either direction
+ * @return true if |now - probe_ts| <=3D=
 window_secs
+ */
+bool oob_timestamp_in_window(uint64_t probe_ts, uint64_t=
 now, uint64_t window_secs);
+
+/**
+ * Process the TLV payload of a receiv=
ed SERVER_PROBE and decide whether to
+ * answer it=2E Combines oob_server_=
probe_read() and oob_timestamp_in_window():
+ * the probe is dropped (false=
 returned) if it has no valid probe_parameter or
+ * its timestamp is outsi=
de the acceptable window=2E
+ *
+ * reply carries the values the server adv=
ertises (priority, weight,
+ * max_latency_diff, connect_lifetime, flags) i=
n, and is deliberately not
+ * cleared: on success only the peer's session =
id is filled in, leaving the
+ * reply ready to be wrapped and sent=2E
+ *
=
+ * This is the transport-agnostic decision step; the caller performs the s=
end=2E
+ *
+ * @param probe_payload  TLV payload of the received OOB SERVER=
_PROBE
+ * @param now            current time (UNIX seconds)
+ * @param win=
dow_secs    acceptable timestamp skew, in either direction
+ * @param peer_=
sid       session id of the requesting peer (echoed in the reply)
+ * @para=
m reply          in: the values to advertise; out: the reply to send
+ * @r=
eturn true if a reply should be sent, false to silently drop the probe
+ */=

+bool oob_build_probe_reply(struct buffer *probe_payload, uint64_t now, ui=
nt64_t window_secs,
+                           const struct session_id *pe=
er_sid, struct oob_probe_reply *reply);
+
 #endif /* OOB_H */
diff --git a/=
tests/unit_tests/openvpn/test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=
=2Ec
index aa4eb23=2E=2E371cbc6 100644
--- a/tests/unit_tests/openvpn/test_=
oob=2Ec
+++ b/tests/unit_tests/openvpn/test_oob=2Ec
@@ -259,6 +259,181 @@
 =
    gc_free(&gc);
 }
 
+/* A SERVER_PROBE carrying just a probe_parameter i=
s found by the scan=2E */
+static void
+test_server_probe_read_finds_parame=
ter(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buff=
er buf =3D alloc_buf_gc(128, &gc);
+
+    const struct oob_probe_parameter =
in =3D {
+        =2Etimestamp =3D 0x1122334455667788ULL,
+        =2Eflags=
 =3D 0,
+    };
+    assert_true(oob_server_probe_write(&buf, &in));
+
+   =
 struct oob_probe_parameter out =3D { 0 };
+    assert_true(oob_server_prob=
e_read(&buf, &out));
+    assert_true(in=2Etimestamp =3D=3D out=2Etimestamp=
);
+    assert_int_equal(in=2Eflags, out=2Eflags);
+
+    gc_free(&gc);
+}
=
+
+/* TLVs other than probe_parameter are skipped, so the scan finds the
+ =
* probe_parameter even when preceded by an unknown TLV=2E */
+static void
+=
test_server_probe_read_skips_unknown(void **state)
+{
+    struct gc_arena =
gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    =
/* SERVER_PROBE message header, then an unknown TLV (type 0x7ff) =2E=2E=2E =
*/
+    assert_true(buf_write_u16(&buf, OOB_MSG_SERVER_PROBE));
+    assert=
_true(ctrl_msg_tlv_write_header(&buf, 0x7ff, false, 4));
+    assert_true(b=
uf_write_u32(&buf, 0xcafef00d));
+    /* =2E=2E=2E followed by the real pro=
be_parameter */
+    const struct oob_probe_parameter in =3D { =2Etimestamp=
 =3D 42, =2Eflags =3D 0 };
+    assert_true(oob_probe_parameter_write(&buf,=
 &in));
+
+    struct oob_probe_parameter out =3D { 0 };
+    assert_true(o=
ob_server_probe_read(&buf, &out));
+    assert_true(out=2Etimestamp =3D=3D =
42);
+
+    gc_free(&gc);
+}
+
+/* A payload with no probe_parameter must b=
e rejected=2E */
+static void
+test_server_probe_read_missing(void **state)=

+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_=
buf_gc(128, &gc);
+
+    assert_true(buf_write_u16(&buf, OOB_MSG_SERVER_PRO=
BE));
+    assert_true(ctrl_msg_tlv_write_header(&buf, 0x7ff, false, 4));
+=
    assert_true(buf_write_u32(&buf, 0));
+
+    struct oob_probe_parameter =
out =3D { 0 };
+    assert_false(oob_server_probe_read(&buf, &out));
+
+   =
 gc_free(&gc);
+}
+
+/* A TLV whose declared length runs past the buffer mu=
st be rejected, not
+ * read out of bounds=2E */
+static void
+test_server_=
probe_read_truncated(void **state)
+{
+    struct gc_arena gc =3D gc_new();=

+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    /* TLV header cl=
aims a 16-byte value but no value bytes follow */
+    assert_true(buf_writ=
e_u16(&buf, OOB_MSG_SERVER_PROBE));
+    assert_true(ctrl_msg_tlv_write_hea=
der(&buf, 0x7ff, false, 16));
+
+    struct oob_probe_parameter out =3D { 0=
 };
+    assert_false(oob_server_probe_read(&buf, &out));
+
+    gc_free(&g=
c);
+}
+
+/* A SERVER_PROBE reader rejects a payload carrying a different m=
essage type
+ * (here a PROBE_REPLY's), even if it contains a valid probe_p=
arameter TLV=2E */
+static void
+test_server_probe_read_wrong_msg_type(void=
 **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =
=3D alloc_buf_gc(128, &gc);
+
+    assert_true(buf_write_u16(&buf, OOB_MSG_=
PROBE_REPLY));
+    const struct oob_probe_parameter in =3D { =2Etimestamp =
=3D 42, =2Eflags =3D 0 };
+    assert_true(oob_probe_parameter_write(&buf, =
&in));
+
+    struct oob_probe_parameter out =3D { 0 };
+    assert_false(o=
ob_server_probe_read(&buf, &out));
+
+    gc_free(&gc);
+}
+
+/* Timestamp =
window check accepts values within the window (either direction)
+ * and re=
jects values outside it=2E */
+static void
+test_timestamp_in_window(void *=
*state)
+{
+    const uint64_t now =3D 1000000;
+    const uint64_t window =
=3D 30;
+
+    assert_true(oob_timestamp_in_window(now, now, window));
+   =
 assert_true(oob_timestamp_in_window(now - window, now, window));      /* b=
oundary, past */
+    assert_true(oob_timestamp_in_window(now + window, now=
, window));      /* boundary, future */
+    assert_false(oob_timestamp_in_=
window(now - window - 1, now, window)); /* too old */
+    assert_false(oob=
_timestamp_in_window(now + window + 1, now, window)); /* too far ahead */
+=
}
+
+/* A valid, in-window SERVER_PROBE yields a reply that echoes the peer=
's
+ * session id and zeroes the remaining fields=2E */
+static void
+test_=
build_probe_reply_valid(void **state)
+{
+    struct gc_arena gc =3D gc_new=
();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    const uint64_=
t now =3D 1000000;
+    const struct oob_probe_parameter probe =3D { =2Etim=
estamp =3D now, =2Eflags =3D 0 };
+    assert_true(oob_server_probe_write(&=
buf, &probe));
+
+    struct session_id peer;
+    memcpy(peer=2Eid, "PEER1=
234", SID_SIZE);
+
+    /* left as the caller set them: the function only f=
ills the session id */
+    struct oob_probe_reply reply =3D { 0 };
+    as=
sert_true(oob_build_probe_reply(&buf, now, 30, &peer, &reply));
+    assert=
_memory_equal(reply=2Epeer_session_id=2Eid, peer=2Eid, SID_SIZE);
+    asse=
rt_int_equal(reply=2Epriority, 0);
+    assert_int_equal(reply=2Eweight, 0)=
;
+    assert_int_equal(reply=2Econnect_lifetime, 0);
+    assert_int_equal=
(reply=2Eflags, 0);
+
+    gc_free(&gc);
+}
+
+/* A probe whose timestamp i=
s outside the window is dropped (no reply)=2E */
+static void
+test_build_p=
robe_reply_stale(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+  =
  struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    const uint64_t now =
=3D 1000000;
+    const struct oob_probe_parameter probe =3D { =2Etimestamp=
 =3D now - 1000, =2Eflags =3D 0 };
+    assert_true(oob_server_probe_write(=
&buf, &probe));
+
+    struct session_id peer =3D { 0 };
+    struct oob_pr=
obe_reply reply =3D { 0 };
+    assert_false(oob_build_probe_reply(&buf, no=
w, 30, &peer, &reply));
+
+    gc_free(&gc);
+}
+
+/* A payload without a p=
robe_parameter is dropped (no reply)=2E */
+static void
+test_build_probe_r=
eply_no_parameter(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+ =
   struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    assert_true(buf_wri=
te_u16(&buf, OOB_MSG_SERVER_PROBE));
+    assert_true(ctrl_msg_tlv_write_he=
ader(&buf, 0x7ff, false, 4));
+    assert_true(buf_write_u32(&buf, 0));
+
+=
    struct session_id peer =3D { 0 };
+    struct oob_probe_reply reply =3D=
 { 0 };
+    assert_false(oob_build_probe_reply(&buf, 1000000, 30, &peer, &=
reply));
+
+    gc_free(&gc);
+}
+
 int
 main(void)
 {
@@ -271,6 +446,15 @@=

         cmocka_unit_test(test_probe_parameter_too_short),
         cmocka=
_unit_test(test_find_tlv_value_truncated),
         cmocka_unit_test(test_t=
lv_header_truncated),
+        cmocka_unit_test(test_server_probe_read_find=
s_parameter),
+        cmocka_unit_test(test_server_probe_read_skips_unknow=
n),
+        cmocka_unit_test(test_server_probe_read_missing),
+        cmo=
cka_unit_test(test_server_probe_read_truncated),
+        cmocka_unit_test(=
test_server_probe_read_wrong_msg_type),
+        cmocka_unit_test(test_time=
stamp_in_window),
+        cmocka_unit_test(test_build_probe_reply_valid),
=
+        cmocka_unit_test(test_build_probe_reply_stale),
+        cmocka_un=
it_test(test_build_probe_reply_no_parameter),
     };
 
     return cmocka_=
run_group_tests_name("oob tests", tests, NULL, NULL);

-- 
To view, visit h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail
To unsubscribe, o=
r for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68=
c30
Gerrit-Change-Number: 1742
Gerrit-PatchSet: 9
Gerrit-Owner: stipa <lsti=
pakov@gmail=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
=
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-=
devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenh=
eld <frank@lichtenheld=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=2Eco=
m>

--L9iYQIp5Isw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, stipa=2E </p>
<p>stipa <strong>uploaded=
 patch set #9</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1742?usp=3Demail">View Change</a></p><p>The follow=
ing approvals got outdated and were removed:
Code-Review+2 by flichtenheld<=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">oob: Add SERVER_PROBE parsing and the probe-reply decision=
<br><br>Add the message-level helpers the server needs to answer a probe:<b=
r><br>  - oob_server_probe_read() scans the TLV payload of a received OOB<b=
r>    SERVER_PROBE for the probe_parameter TLV, skipping other/future TLV<b=
r>    types and rejecting malformed or truncated input=2E<br>  - oob_timest=
amp_in_window() performs the cheap replay/skew check on the<br>    probe ti=
mestamp described in the wire protocol specification=2E<br>  - oob_build_pr=
obe_reply() composes the two: given a received SERVER_PROBE<br>    it scans=
 for the probe_parameter, drops the probe if it is missing or<br>    its ti=
mestamp is outside the acceptable window, and otherwise populates<br>    th=
e probe_reply (echoing the peer&#39;s session id) to send back=2E<br><br>Th=
ese are pure functions exercised by unit tests; the server packet path<br>c=
alls oob_build_probe_reply() in a follow-up, which performs the actual send=
=2E<br><br>Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30<br>Signed-o=
ff-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M src/openvpn/oob=
=2Ec<br>M src/openvpn/oob=2Eh<br>M tests/unit_tests/openvpn/test_oob=2Ec<br=
>3 files changed, 289 insertions(+), 0 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/42/174=
2/9</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec</span><b=
r><span>index c807171=2E=2E930b213 100644</span><br><span>--- a/src/openvpn=
/oob=2Ec</span><br><span>+++ b/src/openvpn/oob=2Ec</span><br><span>@@ -81,3=
 +81,54 @@</span><br><span>     r-&gt;flags =3D buf_read_u32(buf, NULL);</s=
pan><br><span>     return true;</span><br><span> }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob=
_server_probe_write(struct buffer *buf, const struct oob_probe_parameter *p=
aram)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return buf_write_u16(buf, OO=
B_MSG_SERVER_PROBE) &amp;&amp; oob_probe_parameter_write(buf, param);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
oob_server_probe_read(struct buffer *payload, struct oob_probe_parameter *p=
aram)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (!ctrl_msg_read_header(pa=
yload, OOB_MSG_SERVER_PROBE))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct buffer value;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (!ctrl_msg_find_tlv(pay=
load, OOB_TLV_PROBE_PARAMETER, &amp;value))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        return false;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return oob_probe_=
parameter_read(&amp;value, param);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+oob_timestamp_in_window(uint64_t prob=
e_ts, uint64_t now, uint64_t window_secs)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    uint64_t diff =3D (now &gt; probe_ts) ? (now - probe_ts) : (probe_t=
s - now);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return=
 diff &lt;=3D window_secs;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+oob_build_probe_reply(struct buffer *probe_pa=
yload, uint64_t now, uint64_t window_secs,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                      const struct session_id *peer_=
sid, struct oob_probe_reply *reply)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct oob_probe_parameter param;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (!oob_server_probe_read(probe_payload, &amp;param))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* Drop replayed or implausibly-timed probes before doing any=
 more work=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (!oob_timestamp_in_window(param=2Etimestamp, now, window_secs))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* the caller&#39;s advertised values are kept; only the echo is our=
s to fill */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rep=
ly-&gt;peer_session_id =3D *peer_sid;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    return true;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span>diff --git a/src/openvpn/oob=2Eh b/src/ope=
nvpn/oob=2Eh</span><br><span>index 0a9a4bb=2E=2E1afabbd 100644</span><br><s=
pan>--- a/src/openvpn/oob=2Eh</span><br><span>+++ b/src/openvpn/oob=2Eh</sp=
an><br><span>@@ -107,4 +107,58 @@</span><br><span>  */</span><br><span> boo=
l oob_probe_reply_read(struct buffer *buf, struct oob_probe_reply *r);</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Write a complete SE=
RVER_PROBE message (message-type header + probe_parameter</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * TLV) to buf=2E Sent by the client=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+bool oob_server_probe_write(stru=
ct buffer *buf, const struct oob_probe_parameter *param);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * Read a received OOB SERVER_PROBE: verify its message-type header, the=
n scan</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * for the pr=
obe_parameter TLV=2E TLV types other than probe_parameter are</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * skipped=2E payload is consumed=
 as it is read=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param payload  =
buffer positioned at the start of the OOB message payload</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param param    filled with the pa=
rsed probe_parameter on success</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @return true if the header matched and a well-formed probe_p=
arameter was</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *     =
    found, false otherwise</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool oob_=
server_probe_read(struct buffer *payload, struct oob_probe_parameter *param=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * Check whether a probe timestamp is within an acce=
ptable window around the</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * current time=2E Used to cheaply drop replayed or implausibly-timed =
probes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * before doi=
ng any further work (see the probe_parameter timestamp rationale</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * in the wire protocol specif=
ication)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param probe_ts     ti=
mestamp from the probe_parameter (UNIX seconds)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @param now          current time (UNIX secon=
ds)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param window=
_secs  maximum allowed difference, in either direction</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @return true if |now - probe_ts| &lt;=
=3D window_secs</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool oob_timestamp_i=
n_window(uint64_t probe_ts, uint64_t now, uint64_t window_secs);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * Process the TLV payload of a received SERVER_PROBE and decide =
whether to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * answer=
 it=2E Combines oob_server_probe_read() and oob_timestamp_in_window():</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the probe is dropped =
(false returned) if it has no valid probe_parameter or</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * its timestamp is outside the acceptab=
le window=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * reply carries the val=
ues the server advertises (priority, weight,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * max_latency_diff, connect_lifetime, flags) in, =
and is deliberately not</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * cleared: on success only the peer&#39;s session id is filled in, lea=
ving the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * reply re=
ady to be wrapped and sent=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This=
 is the transport-agnostic decision step; the caller performs the send=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @param probe_payload  TLV payload o=
f the received OOB SERVER_PROBE</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param now            current time (UNIX seconds)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param window_secs    accep=
table timestamp skew, in either direction</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @param peer_sid       session id of the requesting=
 peer (echoed in the reply)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @param reply          in: the values to advertise; out: the repl=
y to send</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return=
 true if a reply should be sent, false to silently drop the probe</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+bool oob_build_probe_reply(struct buffer *pro=
be_payload, uint64_t now, uint64_t window_secs,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                           const struct session=
_id *peer_sid, struct oob_probe_reply *reply);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span> #endif /* OOB_H */</span><br><=
span>diff --git a/tests/unit_tests/openvpn/test_oob=2Ec b/tests/unit_tests/=
openvpn/test_oob=2Ec</span><br><span>index aa4eb23=2E=2E371cbc6 100644</spa=
n><br><span>--- a/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>+++=
 b/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>@@ -259,6 +259,181=
 @@</span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A SERVER_PRO=
BE carrying just a probe_parameter is found by the scan=2E */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+test_server_probe_read_finds_parameter(vo=
id **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D=
 gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    const struct oob_probe_parameter in =3D {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        =2Etimestamp =3D 0x11223344556677=
88ULL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Efl=
ags =3D 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_se=
rver_probe_write(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct oob_probe_parameter out =3D { 0 };</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_true(oob_server_probe_read(&amp;buf, &a=
mp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_true(in=2Etimestamp =3D=3D out=2Etimestamp);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_int_equal(in=2Eflags, out=2Eflags);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
* TLVs other than probe_parameter are skipped, so the scan finds the</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * probe_parameter even wh=
en preceded by an unknown TLV=2E */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+test_server_probe_read_skips_unknown(void **state)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_g=
c(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* SERVER_PROBE me=
ssage header, then an unknown TLV (type 0x7ff) =2E=2E=2E */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u16(&amp;=
buf, OOB_MSG_SERVER_PROBE));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;buf, 0x7ff, false, =
4));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true=
(buf_write_u32(&amp;buf, 0xcafef00d));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* =2E=2E=2E followed by the real probe_parameter */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct oo=
b_probe_parameter in =3D { =2Etimestamp =3D 42, =2Eflags =3D 0 };</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_probe_par=
ameter_write(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct oob_probe_parameter out =3D { 0 };</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_true(oob_server_probe_read(&amp;buf, &amp;o=
ut));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tru=
e(out=2Etimestamp =3D=3D 42);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_fr=
ee(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/* A payload with no probe_parameter must be=
 rejected=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stat=
ic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_server_=
probe_read_missing(void **state)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_true(buf_write_u16(&amp;buf, OOB_MSG_=
SERVER_PROBE));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_true(ctrl_msg_tlv_write_header(&amp;buf, 0x7ff, false, 4));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u3=
2(&amp;buf, 0));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_p=
arameter out =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_false(oob_server_probe_read(&amp;buf, &amp;out));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A TLV =
whose declared length runs past the buffer must be rejected, not</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * read out of bounds=2E */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+test_server_probe_read_truncat=
ed(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena g=
c =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* TLV header claims a 16-byte value but no value bytes foll=
ow */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tru=
e(buf_write_u16(&amp;buf, OOB_MSG_SERVER_PROBE));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_header(&am=
p;buf, 0x7ff, false, 16));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct o=
ob_probe_parameter out =3D { 0 };</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_false(oob_server_probe_read(&amp;buf, &amp;out));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/* A SERVER_PROBE reader rejects a payload carrying a different message ty=
pe</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * (here a PROBE_=
REPLY&#39;s), even if it contains a valid probe_parameter TLV=2E */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+test_server_probe_read_wrong_msg_ty=
pe(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena g=
c =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_true(buf_write_u16(&amp;buf, OOB_MSG_PROBE_REPLY));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct oob_=
probe_parameter in =3D { =2Etimestamp =3D 42, =2Eflags =3D 0 };</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_probe_param=
eter_write(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct oob_probe_parameter out =3D { 0 };</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_false(oob_server_probe_read(&amp;buf, &amp;ou=
t));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+/* Timestamp window check accepts values within the window (either di=
rection)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * and reje=
cts values outside it=2E */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
test_timestamp_in_window(void **state)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const uint64_t now =3D 1000000;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    const uint64_t window =3D 30;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_true(oob_timestamp_in_window(now, now, window));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_tim=
estamp_in_window(now - window, now, window));      /* boundary, past */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_tim=
estamp_in_window(now + window, now, window));      /* boundary, future */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(oob_=
timestamp_in_window(now - window - 1, now, window)); /* too old */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(oob_timesta=
mp_in_window(now + window + 1, now, window)); /* too far ahead */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/* A valid, in-window SERVER_PROBE yields a reply that echoes the =
peer&#39;s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * sessio=
n id and zeroes the remaining fields=2E */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+test_build_probe_reply_valid(void **state)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc=
(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint64_t now =
=3D 1000000;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st struct oob_probe_parameter probe =3D { =2Etimestamp =3D now, =2Eflags =
=3D 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
true(oob_server_probe_write(&amp;buf, &amp;probe));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct session_id peer;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    memcpy(peer=2Eid, &quot;PEER1234&quot;, SID_SIZE=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* left as the caller set them: =
the function only fills the session id */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct oob_probe_reply reply =3D { 0 };</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_build_pro=
be_reply(&amp;buf, now, 30, &amp;peer, &amp;reply));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(reply=2Epeer_sess=
ion_id=2Eid, peer=2Eid, SID_SIZE);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_int_equal(reply=2Epriority, 0);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(reply=2Eweight, =
0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_e=
qual(reply=2Econnect_lifetime, 0);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_int_equal(reply=2Eflags, 0);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A probe whose ti=
mestamp is outside the window is dropped (no reply)=2E */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+test_build_probe_reply_stale(void **state)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =
=3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st uint64_t now =3D 1000000;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    const struct oob_probe_parameter probe =3D { =2Etimestamp =3D =
now - 1000, =2Eflags =3D 0 };</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_true(oob_server_probe_write(&amp;buf, &amp;probe));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct session_id peer =3D { 0 };</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_re=
ply reply =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_false(oob_build_probe_reply(&amp;buf, now, 30, &amp;peer, &amp;=
reply));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/* A payload without a probe_parameter is dropped (no reply)=2E *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+test_build_probe_reply_no_=
parameter(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_=
arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_true(buf_write_u16(&amp;buf, OOB_MSG_SERVER_PR=
OBE));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tr=
ue(ctrl_msg_tlv_write_header(&amp;buf, 0x7ff, false, 4));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;bu=
f, 0));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct session_id peer =3D =
{ 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oo=
b_probe_reply reply =3D { 0 };</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_false(oob_build_probe_reply(&amp;buf, 1000000, 30, &a=
mp;peer, &amp;reply));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp=
;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</span><br>=
<span> main(void)</span><br><span> {</span><br><span>@@ -271,6 +446,15 @@</=
span><br><span>         cmocka_unit_test(test_probe_parameter_too_short),</=
span><br><span>         cmocka_unit_test(test_find_tlv_value_truncated),</s=
pan><br><span>         cmocka_unit_test(test_tlv_header_truncated),</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(te=
st_server_probe_read_finds_parameter),</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        cmocka_unit_test(test_server_probe_read_skips_un=
known),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmoc=
ka_unit_test(test_server_probe_read_missing),</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_server_probe_read_t=
runcated),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c=
mocka_unit_test(test_server_probe_read_wrong_msg_type),</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_timestamp=
_in_window),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 cmocka_unit_test(test_build_probe_reply_valid),</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_build_probe_repl=
y_stale),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cm=
ocka_unit_test(test_build_probe_reply_no_parameter),</span><br><span>     }=
;</span><br><span> </span><br><span>     return cmocka_run_group_tests_name=
(&quot;oob tests&quot;, tests, NULL, NULL);</span><br><span></span><br></pr=
e><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/17=
42?usp=3Demail">change 1742</a>=2E To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1742?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatch=
set </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div=
 style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display=
:none"> Gerrit-Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30 </div>
=
<div style=3D"display:none"> Gerrit-Change-Number: 1742 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> G=
errit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipako=
v@gmail=2Ecom&gt; </div>

</body></html>
--L9iYQIp5Isw=--


--===============1682716147966230387==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1682716147966230387==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1682716147966230387==--

