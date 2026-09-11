Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF55C88E53
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O15Ll2Lha6ys+TF8uO7dI9clrQNWcB8ccMvpYA/hFAU=; b=IpImeLKJzgjppx/XpBkZJeEoO+
	C2uQ+DeO0TCMJLKG1dsRhcLH36YjemMrQX8uT/+9JobRzZvG2Ixy8ABZGZKmGb90gP4pRUQCazs8h
	HFcyr9RrQevBh8+wDtoMR0R0SUUEy2Robu0vU8Khzqc2naCbMJFbkAa8G3pVzqwFoMIQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4xID-0008A9-OG;
	Fri, 11 Sep 2026 09:11:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4xI3-00089q-5z
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 09:11:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=F8qXNiEwdT0rXJQe1LMvp2GUR4XaktSQOgAdq6P1ZzM=; b=aNrL2HV4EoP8mW5Dn9qXCcEj3u
 TP4riQkszOkJK7sHnS2NP79gvmbjs0zxOoEfL4ppQBvhB+EEri64BJX0sirTnfOyTWat99G7rM5oB
 e99S5xuUbKQfEMl5BNPAG1C13LhFhoJ9f/psTlXB/9V9bXwvhA3DcBCJjbRBny+ExgEU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=F8qXNiEwdT0rXJQe1LMvp2GUR4XaktSQOgAdq6P1ZzM=; b=b
 vcp/u7/tLKTXH+314wCynliwjrXGmRZH07hk7Y6kv52O1uUMXMu7ayjBJx34ziDubozskoDOwGSN9
 s+0U+bAUZ80yNWv3G21ZNaSxskvfWUgkk/PFg0h2Oj1egfME648KY38gcBdhk+05c4i6XN8CAmsJy
 uBNMaB7EX+uK8l6Q=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4xHz-0006cG-Vt for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 09:11:23 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-49cf4f81d86so5266005e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 02:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789117873; x=1789722673; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=F8qXNiEwdT0rXJQe1LMvp2GUR4XaktSQOgAdq6P1ZzM=;
 b=QePbSWrslfmMyERFE91qpXDNs4m2OCvQvZyE2RWgL+iV+kd2SGQWGMWuuGoho8Tiu4
 +Hj0RemIQ6/LVD2Z4OL10JA4M8RVhhYJjYYoCKXD6BcK5dGF0A7dz2zQTuA6clfDXySi
 zZDIYiYcyrxkJtHmLF/sh2ElbMKRWEDreA9RHwQnlCDTFVFWuQcHHL2S7AgCvcwUQV8s
 H7BlEKxs6iIhsveemIU1eij7DkdHcleiPPe4JV5a1DxOLx2UkKpt7Edsc9T032H+2Xlm
 UAsE1m7p//i4a7dT8t/0SPnbjOuWOCjzhECdL/Vs/dyc4ylnWCPqUjyC8YqbwWOFI0yk
 wWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117873; x=1789722673;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=F8qXNiEwdT0rXJQe1LMvp2GUR4XaktSQOgAdq6P1ZzM=;
 b=pVuvlFlV4zMNvXztDTYyhQyUMLAf0JpmzjdYWayQpmqNgLcyqTC/Hb/ZZLM6jbp1Y3
 DQJKW/fL0VL+nptzk/xJUXbTZql88U/K7fmLyLGXJMugYxOukKeHieQoJdJVxN8esgkU
 COKRekTlscbGpLkqaNfknfwtM39cMY3OLpY9TdaKLHoz1Y9T9WafyDVPxpDd89CBrtU+
 nMcGKqe49/IsUf1Ldx1RVs0u8b6xA6pErKpQ+h8yK/6/Kesxb8eTte7SJwY9rw9VraGj
 b2KV6LhQ3q15p0fUQ4xmXIYojCbZmQv9yQPFwxJfvx+67AEiDr/yfmjgMKsk92W/P3Zr
 pMQg==
X-Gm-Message-State: AFuF++mi+OVRlIzxcg9vkSJX6bVQ1+gJ3F1Enhn3W8q87+/ZV1AgH3ze
 OVa10tpAFzWYsKdhROmLWb5EBWIpu14qREcQncSTsVA+r+bnFUJnW4Onm3O0VCclk2kThRP2Zl+
 9c46Gxo9sKPhrZKqcRwOp5OKSqGBCEbNUTHJSbNyVD9RULeqz5pbuZUGrhM1JuiL1q9fy
X-Gm-Gg: AYBFou22s3jRCvFn1m0qSq6oY2KGZUMLoioqDhASRi0/q6NrBU0B5VbXeSVBqY4rCRa
 XG2Gdwek5jDYFWdfZtGm6F7EaZGEGXjSNHjWS7/wA7Ho42k/dN9w0T7YddjJ7RfcZNAM3x6eypZ
 iS5LIo1FsLY49uaP6DG0MN653kaOyd8HspEHlrfv+TdI/cCSI2r5igr8o7TP8EORRlTIHoskEDz
 NrhcS1oElYRFTWewwye39EMBevBxcA2fiul4b5UIKztp96ySSaCXAb8vGhcoqcl0pyijxlP7Yio
 zwFhyEw6DLqCVAYUoX8bgKa+rni0unPAeCk+/CoBhZQZzWRWDuNVp6aJ8XpLT93Si5ArX3JegQg
 /XUfkfvhXDhbkd+UKHTR+z4vWy6Rv/t1ZTzFcWoiUKgbw2na9hcE+jTzTvZWzy1p+GErKF4QbuP
 WwQda3zNOuv2+k9Vyt3fYPfakyKz//Sw+MVxq0liWjyO/Xgh5o6ggHEGLBAnBJ96s23WORrda2D
 ca7hFa8Psu69VY2M3hiPPks9jKmvYDJb4IpXKPINSkuh5QMzz5/QyDQKaJV8aD8ET6LzSvsA49+
 Exb+hGSiO8g7Q8pzuWnmksvJIF//ID6QGl2RaA9md/eC/YajhyCfdqLTyL1Gbg==
X-Received: by 2002:a05:600c:4714:b0:49c:c96a:d36b with SMTP id
 5b1f17b1804b1-49e61988ce5mr35721675e9.12.1789117873158; 
 Fri, 11 Sep 2026 02:11:13 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60ad08fcsm59664765e9.11.2026.09.11.02.11.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:11:12 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 09:11:03 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>,
 ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 14
X-Gerrit-Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30
X-Gerrit-Change-Number: 1742
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1742?usp=email>
X-Gerrit-Commit: 21a93d5823d18cf501738360450ae56c0574b5bd
In-Reply-To: <gerrit.1782719911000.Iafa9efc1c156974ad9f5752e9de810a8c2f68c30@gerrit.openvpn.net>
References: <gerrit.1782719911000.Iafa9efc1c156974ad9f5752e9de810a8c2f68c30@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklhZmE5ZWZjMWMxNTY5NzRhZDlmNTc1MmU5ZGU4MTBhOGMyZjY4YzMwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f0c73463fa64eb5ef0a99a16c726fe36e788e85d-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4xHz-0006cG-Vt
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com, ralf@mandelbit.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3516531080751036106=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3516531080751036106==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wDXL3Xy/k7Q="; charset=UTF-8

--wDXL3Xy/k7Q=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, ralf_lici, s=
tipa=2E

Hello flichtenheld, plaisthos, ralf_lici, 

I'd like you to reexam=
ine a change=2E Please visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1742?usp=3Demail

to look at the new patch set (#14)=2E

The following app=
rovals got outdated and were removed:
Code-Review+1 by ralf_lici


Change s=
ubject: oob: Add SERVER_PROBE parsing and the probe-reply decision
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Add SERVER_PRO=
BE parsing and the probe-reply decision

Add the message-level helpers the =
server needs to answer a probe:

  - oob_server_probe_write() writes a SERV=
ER_PROBE (message-type header
    + probe_parameter TLV); the client uses i=
t later=2E
  - oob_server_probe_read() scans the TLV payload of a received =
OOB
    SERVER_PROBE for the probe_parameter TLV, skipping other/future TLV=

    types that are marked optional, and rejecting malformed or truncated
 =
   input as well as a mandatory TLV it does not understand=2E
  - oob_times=
tamp_in_window() performs the cheap replay/skew check on
    the probe time=
stamp described in the wire protocol specification=2E
  - oob_server_probe_=
accept() combines the two: given a received
    SERVER_PROBE it scans for t=
he probe_parameter and accepts the probe
    unless that is missing or its =
timestamp is outside the acceptable
    window=2E It reads the probe and no=
thing else; the reply is the
    caller's to build=2E

A probe whose timest=
amp falls outside the window is dropped without a
reply, which is what the =
spec allows: the timestamp is there so a server
may silently drop requests =
outside an acceptable window and reduce the
replay attack surface=2E The wi=
ndow itself is the caller's choice; the
server path passes --hand-window in=
 a follow-up=2E

These are pure functions exercised by unit tests; the serv=
er packet path
calls oob_server_probe_accept() in a follow-up and builds an=
d sends the
reply itself=2E

Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2=
f68c30
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M src/openvpn/oo=
b=2Ec
M src/openvpn/oob=2Eh
M tests/unit_tests/openvpn/test_oob=2Ec
3 files=
 changed, 288 insertions(+), 0 deletions(-)


  git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/42/1742/14

diff --git a/src/openvpn/=
oob=2Ec b/src/openvpn/oob=2Ec
index c807171=2E=2Ec8c7346 100644
--- a/src/o=
penvpn/oob=2Ec
+++ b/src/openvpn/oob=2Ec
@@ -81,3 +81,46 @@
     r->flags =
=3D buf_read_u32(buf, NULL);
     return true;
 }
+
+bool
+oob_server_probe=
_write(struct buffer *buf, const struct oob_probe_parameter *param)
+{
+   =
 return buf_write_u16(buf, OOB_MSG_SERVER_PROBE) && oob_probe_parameter_wri=
te(buf, param);
+}
+
+bool
+oob_server_probe_read(struct buffer *payload, s=
truct oob_probe_parameter *param)
+{
+    if (!ctrl_msg_read_header(payload=
, OOB_MSG_SERVER_PROBE))
+    {
+        return false;
+    }
+
+    struct=
 buffer value;
+    if (!ctrl_msg_find_tlv(payload, OOB_TLV_PROBE_PARAMETER=
, &value))
+    {
+        return false;
+    }
+
+    return oob_probe_par=
ameter_read(&value, param);
+}
+
+bool
+oob_timestamp_in_window(uint64_t pr=
obe_ts, uint64_t now, uint64_t window_secs)
+{
+    uint64_t diff =3D (now =
> probe_ts) ? (now - probe_ts) : (probe_ts - now);
+    return diff <=3D wi=
ndow_secs;
+}
+
+bool
+oob_server_probe_accept(struct buffer *probe_payload=
, uint64_t now, uint64_t window_secs)
+{
+    struct oob_probe_parameter pa=
ram;
+    if (!oob_server_probe_read(probe_payload, &param))
+    {
+      =
  return false;
+    }
+
+    /* Drop replayed or implausibly-timed probes =
before doing any more work=2E */
+    return oob_timestamp_in_window(param=
=2Etimestamp, now, window_secs);
+}
diff --git a/src/openvpn/oob=2Eh b/src/=
openvpn/oob=2Eh
index c5396b3=2E=2E8c091fc 100644
--- a/src/openvpn/oob=2Eh=

+++ b/src/openvpn/oob=2Eh
@@ -107,4 +107,50 @@
  */
 bool oob_probe_reply_=
read(struct buffer *buf, struct oob_probe_reply *r);
 
+/**
+ * Write a com=
plete SERVER_PROBE message (message-type header + probe_parameter
+ * TLV) =
to buf=2E Sent by the client=2E
+ */
+bool oob_server_probe_write(struct bu=
ffer *buf, const struct oob_probe_parameter *param);
+
+/**
+ * Read a rece=
ived OOB SERVER_PROBE: verify its message-type header, then scan
+ * for th=
e probe_parameter TLV=2E Unknown TLV types marked optional are skipped;
+ *=
 an unknown mandatory one rejects the probe=2E payload is consumed as it is=

+ * read=2E
+ *
+ * @param payload  buffer positioned at the start of the =
OOB message payload
+ * @param param    filled with the parsed probe_parame=
ter on success
+ * @return true if the header matched and a well-formed pro=
be_parameter was
+ *         found, false otherwise
+ */
+bool oob_server_p=
robe_read(struct buffer *payload, struct oob_probe_parameter *param);
+
+/*=
*
+ * Check whether a probe timestamp is within an acceptable window around=
 the
+ * current time=2E Used to cheaply drop replayed or implausibly-timed=
 probes
+ * before doing any further work (see the probe_parameter timestam=
p rationale
+ * in the wire protocol specification)=2E
+ *
+ * @param probe=
_ts     timestamp from the probe_parameter (UNIX seconds)
+ * @param now   =
       current time (UNIX seconds)
+ * @param window_secs  maximum allowed =
difference, in either direction
+ * @return true if |now - probe_ts| <=3D w=
indow_secs
+ */
+bool oob_timestamp_in_window(uint64_t probe_ts, uint64_t n=
ow, uint64_t window_secs);
+
+/**
+ * Decide whether a received SERVER_PROB=
E is answered=2E Combines
+ * oob_server_probe_read() and oob_timestamp_in_=
window(): the probe is dropped
+ * if its payload has no valid probe_parame=
ter or the timestamp is outside the
+ * acceptable window=2E This is the tr=
ansport-agnostic decision step; the caller
+ * builds and sends the reply=
=2E
+ *
+ * @param probe_payload  TLV payload of the received OOB SERVER_PR=
OBE, consumed
+ * @param now            current time (UNIX seconds)
+ * @pa=
ram window_secs    acceptable timestamp skew, in either direction
+ * @retu=
rn true if a reply should be sent, false to silently drop the probe
+ */
+b=
ool oob_server_probe_accept(struct buffer *probe_payload, uint64_t now, uin=
t64_t window_secs);
+
 #endif /* OOB_H */
diff --git a/tests/unit_tests/ope=
nvpn/test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec
index 70f529e0=2E=
=2E7254557 100644
--- a/tests/unit_tests/openvpn/test_oob=2Ec
+++ b/tests/u=
nit_tests/openvpn/test_oob=2Ec
@@ -319,6 +319,195 @@
     gc_free(&gc);
 }
=
 
+/* A SERVER_PROBE carrying just a probe_parameter is found by the scan=
=2E */
+static void
+test_server_probe_read_finds_parameter(void **state)
+=
{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_bu=
f_gc(128, &gc);
+
+    const struct oob_probe_parameter in =3D {
+        =
=2Etimestamp =3D 0x1122334455667788ULL,
+        =2Eflags =3D 0,
+    };
+ =
   assert_true(oob_server_probe_write(&buf, &in));
+
+    struct oob_probe_=
parameter out =3D { 0 };
+    assert_true(oob_server_probe_read(&buf, &out)=
);
+    assert_true(in=2Etimestamp =3D=3D out=2Etimestamp);
+    assert_int=
_equal(in=2Eflags, out=2Eflags);
+
+    gc_free(&gc);
+}
+
+/* TLVs other t=
han probe_parameter are skipped, so the scan finds the
+ * probe_parameter =
even when preceded by an unknown TLV=2E */
+static void
+test_server_probe_=
read_skips_unknown(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+=
    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    /* SERVER_PROBE me=
ssage header, then an unknown but optional TLV (type
+     * 0x7ff) =2E=2E=
=2E */
+    assert_true(buf_write_u16(&buf, OOB_MSG_SERVER_PROBE));
+    as=
sert_true(ctrl_msg_tlv_write_header(&buf, 0x7ff, true, 4));
+    assert_tru=
e(buf_write_u32(&buf, 0xcafef00d));
+    /* =2E=2E=2E followed by the real =
probe_parameter */
+    const struct oob_probe_parameter in =3D { =2Etimest=
amp =3D 42, =2Eflags =3D 0 };
+    assert_true(oob_probe_parameter_write(&b=
uf, &in));
+
+    struct oob_probe_parameter out =3D { 0 };
+    assert_tru=
e(oob_server_probe_read(&buf, &out));
+    assert_true(out=2Etimestamp =3D=
=3D 42);
+
+    gc_free(&gc);
+}
+
+/* An unknown TLV that is NOT marked op=
tional carries something the sender
+ * requires us to act on: the whole me=
ssage is rejected, whether that TLV comes
+ * before or after the one we we=
re looking for=2E */
+static void
+test_server_probe_read_rejects_unknown_m=
andatory(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    const =
struct oob_probe_parameter in =3D { =2Etimestamp =3D 42, =2Eflags =3D 0 };
=
+
+    struct buffer before =3D alloc_buf_gc(128, &gc);
+    assert_true(bu=
f_write_u16(&before, OOB_MSG_SERVER_PROBE));
+    assert_true(ctrl_msg_tlv_=
write_header(&before, 0x7ff, false, 4));
+    assert_true(buf_write_u32(&be=
fore, 0xcafef00d));
+    assert_true(oob_probe_parameter_write(&before, &in=
));
+
+    struct buffer after =3D alloc_buf_gc(128, &gc);
+    assert_true=
(buf_write_u16(&after, OOB_MSG_SERVER_PROBE));
+    assert_true(oob_probe_p=
arameter_write(&after, &in));
+    assert_true(ctrl_msg_tlv_write_header(&a=
fter, 0x7ff, false, 4));
+    assert_true(buf_write_u32(&after, 0xcafef00d)=
);
+
+    struct oob_probe_parameter out =3D { 0 };
+    assert_false(oob_s=
erver_probe_read(&before, &out));
+    assert_false(oob_server_probe_read(&=
after, &out));
+
+    gc_free(&gc);
+}
+
+/* A payload with no probe_parame=
ter must be rejected=2E */
+static void
+test_server_probe_read_missing(voi=
d **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =
=3D alloc_buf_gc(128, &gc);
+
+    assert_true(buf_write_u16(&buf, OOB_MSG_=
SERVER_PROBE));
+    assert_true(ctrl_msg_tlv_write_header(&buf, 0x7ff, tru=
e, 4));
+    assert_true(buf_write_u32(&buf, 0));
+
+    struct oob_probe_p=
arameter out =3D { 0 };
+    assert_false(oob_server_probe_read(&buf, &out)=
);
+
+    gc_free(&gc);
+}
+
+/* A TLV whose declared length runs past the =
buffer must be rejected, not
+ * read out of bounds=2E */
+static void
+tes=
t_server_probe_read_truncated(void **state)
+{
+    struct gc_arena gc =3D =
gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    /* TLV =
header claims a 16-byte value but no value bytes follow */
+    assert_true=
(buf_write_u16(&buf, OOB_MSG_SERVER_PROBE));
+    assert_true(ctrl_msg_tlv_=
write_header(&buf, 0x7ff, false, 16));
+
+    struct oob_probe_parameter ou=
t =3D { 0 };
+    assert_false(oob_server_probe_read(&buf, &out));
+
+    g=
c_free(&gc);
+}
+
+/* A SERVER_PROBE reader rejects a payload carrying a di=
fferent message type
+ * (here a PROBE_REPLY's), even if it contains a vali=
d probe_parameter TLV=2E */
+static void
+test_server_probe_read_wrong_msg_=
type(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buf=
fer buf =3D alloc_buf_gc(128, &gc);
+
+    assert_true(buf_write_u16(&buf, =
OOB_MSG_PROBE_REPLY));
+    const struct oob_probe_parameter in =3D { =2Eti=
mestamp =3D 42, =2Eflags =3D 0 };
+    assert_true(oob_probe_parameter_writ=
e(&buf, &in));
+
+    struct oob_probe_parameter out =3D { 0 };
+    assert=
_false(oob_server_probe_read(&buf, &out));
+
+    gc_free(&gc);
+}
+
+/* Ti=
mestamp window check accepts values within the window (either direction)
+ =
* and rejects values outside it=2E */
+static void
+test_timestamp_in_windo=
w(void **state)
+{
+    const uint64_t now =3D 1000000;
+    const uint64_t=
 window =3D 30;
+
+    assert_true(oob_timestamp_in_window(now, now, window=
));
+    assert_true(oob_timestamp_in_window(now - window, now, window));  =
    /* boundary, past */
+    assert_true(oob_timestamp_in_window(now + win=
dow, now, window));      /* boundary, future */
+    assert_false(oob_times=
tamp_in_window(now - window - 1, now, window)); /* too old */
+    assert_f=
alse(oob_timestamp_in_window(now + window + 1, now, window)); /* too far ah=
ead */
+}
+
+/* A well-formed probe with an in-window timestamp is accepted=
=2E */
+static void
+test_server_probe_accept_valid(void **state)
+{
+    s=
truct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128=
, &gc);
+
+    const uint64_t now =3D 1000000;
+    const struct oob_probe_=
parameter probe =3D { =2Etimestamp =3D now, =2Eflags =3D 0 };
+    assert_t=
rue(oob_server_probe_write(&buf, &probe));
+
+    assert_true(oob_server_pr=
obe_accept(&buf, now, 30));
+
+    gc_free(&gc);
+}
+
+/* A probe whose tim=
estamp is outside the window is dropped (no reply)=2E */
+static void
+test=
_server_probe_accept_stale(void **state)
+{
+    struct gc_arena gc =3D gc_=
new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    const uint=
64_t now =3D 1000000;
+    const struct oob_probe_parameter probe =3D { =2E=
timestamp =3D now - 1000, =2Eflags =3D 0 };
+    assert_true(oob_server_pro=
be_write(&buf, &probe));
+
+    assert_false(oob_server_probe_accept(&buf, =
now, 30));
+
+    gc_free(&gc);
+}
+
+/* A payload without a probe_paramete=
r is dropped (no reply)=2E */
+static void
+test_server_probe_accept_no_par=
ameter(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct b=
uffer buf =3D alloc_buf_gc(128, &gc);
+
+    assert_true(buf_write_u16(&buf=
, OOB_MSG_SERVER_PROBE));
+    assert_true(ctrl_msg_tlv_write_header(&buf, =
0x7ff, true, 4));
+    assert_true(buf_write_u32(&buf, 0));
+
+    assert_f=
alse(oob_server_probe_accept(&buf, 1000000, 30));
+
+    gc_free(&gc);
+}
+=

 int
 main(void)
 {
@@ -334,6 +523,16 @@
         cmocka_unit_test(test_fi=
nd_tlv_skips_optional_after_wanted),
         cmocka_unit_test(test_find_tl=
v_empty_payload),
         cmocka_unit_test(test_tlv_header_truncated),
+  =
      cmocka_unit_test(test_server_probe_read_finds_parameter),
+        cm=
ocka_unit_test(test_server_probe_read_skips_unknown),
+        cmocka_unit_=
test(test_server_probe_read_rejects_unknown_mandatory),
+        cmocka_uni=
t_test(test_server_probe_read_missing),
+        cmocka_unit_test(test_serv=
er_probe_read_truncated),
+        cmocka_unit_test(test_server_probe_read_=
wrong_msg_type),
+        cmocka_unit_test(test_timestamp_in_window),
+    =
    cmocka_unit_test(test_server_probe_accept_valid),
+        cmocka_unit_=
test(test_server_probe_accept_stale),
+        cmocka_unit_test(test_server=
_probe_accept_no_parameter),
     };
 
     return cmocka_run_group_tests_n=
ame("oob tests", tests, NULL, NULL);

-- 
To view, visit http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1742?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: maste=
r
Gerrit-Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30
Gerrit-Change=
-Number: 1742
Gerrit-PatchSet: 14
Gerrit-Owner: stipa <lstipakov@gmail=2Eco=
m>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer:=
 plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@ma=
ndelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Att=
ention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Attention: ralf_lici =
<ralf@mandelbit=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>

--wDXL3Xy/k7Q=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, ralf_lici, stipa=2E </p>
<p>=
stipa <strong>uploaded patch set #14</strong> to this change=2E</p><p><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Re=
view+1 by ralf_lici</p><pre class=3D"blocks" style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">oob: Add SERVER_PROBE parsing and the =
probe-reply decision<br><br>Add the message-level helpers the server needs =
to answer a probe:<br><br>  - oob_server_probe_write() writes a SERVER_PROB=
E (message-type header<br>    + probe_parameter TLV); the client uses it la=
ter=2E<br>  - oob_server_probe_read() scans the TLV payload of a received O=
OB<br>    SERVER_PROBE for the probe_parameter TLV, skipping other/future T=
LV<br>    types that are marked optional, and rejecting malformed or trunca=
ted<br>    input as well as a mandatory TLV it does not understand=2E<br>  =
- oob_timestamp_in_window() performs the cheap replay/skew check on<br>    =
the probe timestamp described in the wire protocol specification=2E<br>  - =
oob_server_probe_accept() combines the two: given a received<br>    SERVER_=
PROBE it scans for the probe_parameter and accepts the probe<br>    unless =
that is missing or its timestamp is outside the acceptable<br>    window=2E=
 It reads the probe and nothing else; the reply is the<br>    caller&#39;s =
to build=2E<br><br>A probe whose timestamp falls outside the window is drop=
ped without a<br>reply, which is what the spec allows: the timestamp is the=
re so a server<br>may silently drop requests outside an acceptable window a=
nd reduce the<br>replay attack surface=2E The window itself is the caller&#=
39;s choice; the<br>server path passes --hand-window in a follow-up=2E<br><=
br>These are pure functions exercised by unit tests; the server packet path=
<br>calls oob_server_probe_accept() in a follow-up and builds and sends the=
<br>reply itself=2E<br><br>Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f6=
8c30<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M s=
rc/openvpn/oob=2Ec<br>M src/openvpn/oob=2Eh<br>M tests/unit_tests/openvpn/t=
est_oob=2Ec<br>3 files changed, 288 insertions(+), 0 deletions(-)<br><br></=
pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/=
changes/42/1742/14</pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/src/openvpn/oob=2Ec b/src/openvpn/o=
ob=2Ec</span><br><span>index c807171=2E=2Ec8c7346 100644</span><br><span>--=
- a/src/openvpn/oob=2Ec</span><br><span>+++ b/src/openvpn/oob=2Ec</span><br=
><span>@@ -81,3 +81,46 @@</span><br><span>     r-&gt;flags =3D buf_read_u32=
(buf, NULL);</span><br><span>     return true;</span><br><span> }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+oob_server_probe_write(struct buffer *buf, const struct oob_pro=
be_parameter *param)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return buf_wr=
ite_u16(buf, OOB_MSG_SERVER_PROBE) &amp;&amp; oob_probe_parameter_write(buf=
, param);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+oob_server_probe_read(struct buffer *payload, struct oob_probe=
_parameter *param)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!ctrl_msg_r=
ead_header(payload, OOB_MSG_SERVER_PROBE))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        return false;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer valu=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!ctrl_msg=
_find_tlv(payload, OOB_TLV_PROBE_PARAMETER, &amp;value))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retu=
rn oob_probe_parameter_read(&amp;value, param);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_timestamp_in_window(=
uint64_t probe_ts, uint64_t now, uint64_t window_secs)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    uint64_t diff =3D (now &gt; probe_ts) ? (now - probe_t=
s) : (probe_ts - now);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    return diff &lt;=3D window_secs;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+oob_server_probe_accept(struct b=
uffer *probe_payload, uint64_t now, uint64_t window_secs)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct oob_probe_parameter param;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (!oob_server_probe_read(probe_=
payload, &amp;param))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retu=
rn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Drop replayed or implausibly-timed=
 probes before doing any more work=2E */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    return oob_timestamp_in_window(param=2Etimestamp, =
now, window_secs);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span>diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh</sp=
an><br><span>index c5396b3=2E=2E8c091fc 100644</span><br><span>--- a/src/op=
envpn/oob=2Eh</span><br><span>+++ b/src/openvpn/oob=2Eh</span><br><span>@@ =
-107,4 +107,50 @@</span><br><span>  */</span><br><span> bool oob_probe_repl=
y_read(struct buffer *buf, struct oob_probe_reply *r);</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * Write a complete SERVER_PROBE messa=
ge (message-type header + probe_parameter</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * TLV) to buf=2E Sent by the client=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+bool oob_server_probe_write(struct buffer *buf, c=
onst struct oob_probe_parameter *param);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Read a rece=
ived OOB SERVER_PROBE: verify its message-type header, then scan</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * for the probe_parameter TLV=
=2E Unknown TLV types marked optional are skipped;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * an unknown mandatory one rejects the prob=
e=2E payload is consumed as it is</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * read=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param pa=
yload  buffer positioned at the start of the OOB message payload</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param param    filled with=
 the parsed probe_parameter on success</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * @return true if the header matched and a well-formed =
probe_parameter was</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *         found, false otherwise</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bo=
ol oob_server_probe_read(struct buffer *payload, struct oob_probe_parameter=
 *param);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * Check whether a probe timestamp is within =
an acceptable window around the</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * current time=2E Used to cheaply drop replayed or implausibly=
-timed probes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * bef=
ore doing any further work (see the probe_parameter timestamp rationale</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * in the wire protocol=
 specification)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param probe_ts=
     timestamp from the probe_parameter (UNIX seconds)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @param now          current time (UNI=
X seconds)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param=
 window_secs  maximum allowed difference, in either direction</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @return true if |now - probe_t=
s| &lt;=3D window_secs</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool oob_time=
stamp_in_window(uint64_t probe_ts, uint64_t now, uint64_t window_secs);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Decide whether a received SERVER_PROBE is answered=2E =
Combines</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * oob_serv=
er_probe_read() and oob_timestamp_in_window(): the probe is dropped</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * if its payload has no va=
lid probe_parameter or the timestamp is outside the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * acceptable window=2E This is the trans=
port-agnostic decision step; the caller</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * builds and sends the reply=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param probe_payload  TLV payload of the received OOB S=
ERVER_PROBE, consumed</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param now            current time (UNIX seconds)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @param window_secs    acceptable time=
stamp skew, in either direction</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @return true if a reply should be sent, false to silently dr=
op the probe</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+bool oob_server_probe_a=
ccept(struct buffer *probe_payload, uint64_t now, uint64_t window_secs);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #end=
if /* OOB_H */</span><br><span>diff --git a/tests/unit_tests/openvpn/test_o=
ob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>index 70f529=
e0=2E=2E7254557 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_=
oob=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_oob=2Ec</span><=
br><span>@@ -319,6 +319,195 @@</span><br><span>     gc_free(&amp;gc);</span=
><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/* A SERVER_PROBE carrying just a probe_parameter is found by t=
he scan=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static=
 void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_server_pr=
obe_read_finds_parameter(void **state)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const struct oob_probe_parameter in =
=3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Etim=
estamp =3D 0x1122334455667788ULL,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        =2Eflags =3D 0,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_true(oob_server_probe_write(&amp;buf, &amp;in));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct oob_probe_parameter out =3D { 0 };</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_ser=
ver_probe_read(&amp;buf, &amp;out));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_true(in=2Etimestamp =3D=3D out=2Etimestamp);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(i=
n=2Eflags, out=2Eflags);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&a=
mp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/* TLVs other than probe_parameter are skipped, s=
o the scan finds the</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * probe_parameter even when preceded by an unknown TLV=2E */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+test_server_probe_read_skips_unknown(voi=
d **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D =
gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /* SERVER_PROBE message header, then an unknown but optional TLV (=
type</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * 0x7ff) =
=2E=2E=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_true(buf_write_u16(&amp;buf, OOB_MSG_SERVER_PROBE));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_hea=
der(&amp;buf, 0x7ff, true, 4));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_true(buf_write_u32(&amp;buf, 0xcafef00d));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* =2E=2E=2E followed by =
the real probe_parameter */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    const struct oob_probe_parameter in =3D { =2Etimestamp =3D 42, =
=2Eflags =3D 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_true(oob_probe_parameter_write(&amp;buf, &amp;in));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct oob_probe_parameter out =3D { 0 };</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_server_=
probe_read(&amp;buf, &amp;out));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_true(out=2Etimestamp =3D=3D 42);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* An unknown TLV=
 that is NOT marked optional carries something the sender</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * requires us to act on: the whole m=
essage is rejected, whether that TLV comes</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * before or after the one we were looking for=2E */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+test_server_probe_read_reje=
cts_unknown_mandatory(void **state)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const struct oob_probe_parameter in =3D { =2Etimestamp =
=3D 42, =2Eflags =3D 0 };</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct bu=
ffer before =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_true(buf_write_u16(&amp;before, OOB_MSG_=
SERVER_PROBE));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_true(ctrl_msg_tlv_write_header(&amp;before, 0x7ff, false, 4));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write=
_u32(&amp;before, 0xcafef00d));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_true(oob_probe_parameter_write(&amp;before, &amp;in)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct buffer after =3D alloc_bu=
f_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_true(buf_write_u16(&amp;after, OOB_MSG_SERVER_PROBE));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_probe_par=
ameter_write(&amp;after, &amp;in));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;after, 0x7ff=
, false, 4));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_true(buf_write_u32(&amp;after, 0xcafef00d));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct oob_probe_parameter out =3D { 0 };</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_false(oob_server_probe_read=
(&amp;before, &amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_false(oob_server_probe_read(&amp;after, &amp;out));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* =
A payload with no probe_parameter must be rejected=2E */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+test_server_probe_read_missing(void **state)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =
=3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_true(buf_write_u16(&amp;buf, OOB_MSG_SERVER_PROBE));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_hea=
der(&amp;buf, 0x7ff, true, 4));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_true(buf_write_u32(&amp;buf, 0));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct oob_probe_parameter out =3D { 0 };</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(oob_server_pro=
be_read(&amp;buf, &amp;out));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_fr=
ee(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/* A TLV whose declared length runs past the=
 buffer must be rejected, not</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * read out of bounds=2E */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+test_server_probe_read_truncated(void **state)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(=
128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* TLV header claims=
 a 16-byte value but no value bytes follow */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_true(buf_write_u16(&amp;buf, OOB_MSG_S=
ERVER_PROBE));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_true(ctrl_msg_tlv_write_header(&amp;buf, 0x7ff, false, 16));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct oob_probe_parameter out =3D { 0 };</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(oob_=
server_probe_read(&amp;buf, &amp;out));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/* A SERVER_PROBE reader rejects a=
 payload carrying a different message type</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * (here a PROBE_REPLY&#39;s), even if it contains a=
 valid probe_parameter TLV=2E */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+test_server_probe_read_wrong_msg_type(void **state)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(=
128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_writ=
e_u16(&amp;buf, OOB_MSG_PROBE_REPLY));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const struct oob_probe_parameter in =3D { =2Etimesta=
mp =3D 42, =2Eflags =3D 0 };</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_true(oob_probe_parameter_write(&amp;buf, &amp;in));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_parameter out =3D { =
0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_fals=
e(oob_server_probe_read(&amp;buf, &amp;out));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/* Timestamp window check ac=
cepts values within the window (either direction)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * and rejects values outside it=2E */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+test_timestamp_in_window(void **st=
ate)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    const uint64_t now =3D 100000=
0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint64_=
t window =3D 30;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_ti=
mestamp_in_window(now, now, window));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_true(oob_timestamp_in_window(now - window, now=
, window));      /* boundary, past */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_true(oob_timestamp_in_window(now + window, now=
, window));      /* boundary, future */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_false(oob_timestamp_in_window(now - window -=
 1, now, window)); /* too old */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_false(oob_timestamp_in_window(now + window + 1, now=
, window)); /* too far ahead */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A well-formed probe wi=
th an in-window timestamp is accepted=2E */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+test_server_probe_accept_valid(void **state)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf=
_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint64_t n=
ow =3D 1000000;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
const struct oob_probe_parameter probe =3D { =2Etimestamp =3D now, =2Eflags=
 =3D 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_true(oob_server_probe_write(&amp;buf, &amp;probe));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_true(oob_server_probe_accept(&amp;buf, now, 30));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/* A probe whose timestamp is outside the window is dropped (no reply)=2E=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+test_server_probe_accept=
_stale(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_are=
na gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const uint64_t now =3D 1000000;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    const struct oob_probe_parameter probe =
=3D { =2Etimestamp =3D now - 1000, =2Eflags =3D 0 };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_server_probe_write(&a=
mp;buf, &amp;probe));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(=
oob_server_probe_accept(&amp;buf, now, 30));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/* A payload without a probe_=
parameter is dropped (no reply)=2E */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+test_server_probe_accept_no_parameter(void **state)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_bu=
f_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf=
_write_u16(&amp;buf, OOB_MSG_SERVER_PROBE));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;buf=
, 0x7ff, true, 4));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_true(buf_write_u32(&amp;buf, 0));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_false(oob_server_probe_accept(&amp;buf, 1000000, 30));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span> int</span><br><span> main(void)</span><=
br><span> {</span><br><span>@@ -334,6 +523,16 @@</span><br><span>         c=
mocka_unit_test(test_find_tlv_skips_optional_after_wanted),</span><br><span=
>         cmocka_unit_test(test_find_tlv_empty_payload),</span><br><span>  =
       cmocka_unit_test(test_tlv_header_truncated),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_server_prob=
e_read_finds_parameter),</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        cmocka_unit_test(test_server_probe_read_skips_unknown),</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(t=
est_server_probe_read_rejects_unknown_mandatory),</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_server_probe_re=
ad_missing),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 cmocka_unit_test(test_server_probe_read_truncated),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_server_prob=
e_read_wrong_msg_type),</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        cmocka_unit_test(test_timestamp_in_window),</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_server_pr=
obe_accept_valid),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       cmocka_unit_test(test_server_probe_accept_stale),</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_server_p=
robe_accept_no_parameter),</span><br><span>     };</span><br><span> </span>=
<br><span>     return cmocka_run_group_tests_name(&quot;oob tests&quot;, te=
sts, NULL, NULL);</span><br><span></span><br></pre><p>To view, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail">change 174=
2</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><di=
v itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"d=
isplay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> G=
errit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: =
Iafa9efc1c156974ad9f5752e9de810a8c2f68c30 </div>
<div style=3D"display:none=
"> Gerrit-Change-Number: 1742 </div>
<div style=3D"display:none"> Gerrit-Pa=
tchSet: 14 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lsti=
pakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=
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
--wDXL3Xy/k7Q=--


--===============3516531080751036106==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3516531080751036106==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3516531080751036106==--

