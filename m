Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BACAC53200
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 12:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gmASZ2uLuDZcWKzJx8IXkt/umRZG8stWkTjlmPjvF9E=; b=fqhZPhx2JfQ8r5N2Gfc2kEI2Vi
	92FjwGpIyGRJMRAsb9qK/MfFJmDxuyNm+ClJUk7DsqaMXzm6ijo9J44dYpAg/myAtkK93dNt2YRMz
	WQk99JB/+4ZUr7U7bJa0/LxE1k03S9IDDE5amIF74ZE5vXtZXv/ZT8Kdx0qi6dk54a68=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wp3Jh-0001Fv-Tg;
	Wed, 29 Jul 2026 12:23:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wp3Jg-0001FX-Ac
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 12:23:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=y8qLwnAQn6Uf5zNJ4OVMd1rJBKywzLwmfMo0gekCzYs=; b=JsE62xd9wvb8309UW9bsZsJ5vm
 0qx3OHg74nxYVIeRezOKUpdMxTWyBnnP5CBNHxGtQQJHoMKxrdbgZXBSHV9BHRfvWdo8a8CqyQxkV
 TK/LgKnlwHZLFKQoO6oWukUQDXOjanvcdcVxWWZBTGvwh/ajWvPXl/GGmx0yncNfvNaU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=y8qLwnAQn6Uf5zNJ4OVMd1rJBKywzLwmfMo0gekCzYs=; b=l
 Frop4mCAypLq29JQ0SJsrLS4tSXovRilj02k2JQkK7ALy78tGFM5/BTJ3DWOb8k6vdUH88yB8+u9e
 Z169/BCBztKCiXJmD/w9uOu4kYlv8nDzcMKBa6MxaWvZ3aNa6zXYYc+zXUM7FcIXHTtqviUtxSBAX
 04YfA5TfPj3uSeDc=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wp3Jb-0006Nt-D2 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 12:23:21 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-49554ebb87dso7813485e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 29 Jul 2026 05:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785327789; x=1785932589; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=y8qLwnAQn6Uf5zNJ4OVMd1rJBKywzLwmfMo0gekCzYs=;
 b=Mxdz8sAcvJGokUg1cuE6N7N9i0TjzsJxw5tq2OK083OVchAPRGbIQO3GfQA3VbQQYs
 qa6km3zZ0fs3XQrg67/kmT9NNIWcjijGk4uotsn0kPZAA5QlXDzomwvd0An4mcWXoqQI
 vcoa6E2WTN87HPzEcm9KsCdwtJhD+cHrEy72G90Md7sAGTit/hhYQDkZlrWhjAB9C4XY
 QJ3xSbHyXQyO8cbcFmI5KjJ1XztAx5LoE2rq7eYy/06uz+uQhMxM2m4nhk1PZG67a7DP
 Z4Fd3yp4MhJP9N3erBVPsofD3dtbMSEDay4rgiy9tDSNpsAw29lbSYBw7Toyn3BlbCiZ
 nVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785327789; x=1785932589;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=y8qLwnAQn6Uf5zNJ4OVMd1rJBKywzLwmfMo0gekCzYs=;
 b=NzePDCRDNoVeg7K3O0SVEbfm4tjIG0pUgDYEdifLSyCSKLICppZN9rrBBHM0a8Iz7s
 s+/8Ny8SM+/atckRLJsVQa7xAawieVO7wKi5MYIcYPteGup7NEb7ZrPXflG+ionaCaDD
 /+RIszWN8Z2Dqp8xXlUKE10oH5sbSJzxrQ0gsBTZdIIkoJcauZ9OvQtWSab5oUyM16vt
 ZBdvusA93iOAoEjYULy1eo0zoB5qX09yawNcMTj4Ah2DSpfUdr09qwYuF9cafF9Tn1Kj
 yI+xWxXYXvtsB+9IOJ/m0V5jbj85OHmyHKys46u9IrYzJsa9le+YteJonyVRZAojdOhV
 kDIQ==
X-Gm-Message-State: AOJu0YxTkQbX1aZcgaGwLc7Wz2ogbyUYFhI8/cA5iMkyfolIVv1cq/wh
 EnNXMcZ8skAJagDWNcO+vrnpbRlOM9I/lmwwJHDMtGjL9ZCPjBA3ZrfA0+Z/5EptUXNCsnqOWzS
 dRqLQUdo5QTxNfrW92xzRYKt8kloezGcTlxAoPsL2+apbAkn0xUluHgRN4ZnUqs2U0P1d
X-Gm-Gg: AR+sD12FIJPiKL+eGdXVWS3Lh3Vf4/IWrSTijmBS4zGJTOrxmsmsAAq2dA50kCgYBpv
 YkeaplQtUIzkrJfxcpoG0M0So04yCQ0v6IbWSaifKlrzJl7ANk6DldTja8UyjrfdQlCiT5SOT/v
 a/XwIf9mHafFjnLdGZR7erL0EfH7orqAzIEGYT01ogsZNSTJjQ5dNl53PcOmYmf9kSCGYFluAZ3
 q7UrBZ+pF4mVmXv7fG5q7LupiIN15Aum5LmVXzPNKPvhH2LS2J+U3CVtPsHSaHaGf+ecxGr3fOZ
 zgQ5YLLeLEb8OWz5xj5FWNI15YHXdX2G74ca3CVgq4BkqBTay1qlAkvexff6S9hwv2XCI1k/7WG
 T+U4BlCD8GR7+nDyC0lP6rhTFi5xYaNxe7qZnlJ3q0xTvSGaOvh96P9SrREHzQbPBEfMT09pfwd
 E+sNgtyInmbBftQ1PSDg2Pj3UIXeNySCNILwyJ+pLs67wqP4uED+cv5SSXUKoeJW3nhnY+W66l0
 EtgsLGt5B2wj+vFHJIv8sEdHuxF5MdFdttrI1sGcKf/n/1Pwmb+UeSDje+Z2TIswTEmKfiMbwaz
 9nIRSTOgL2O4OjI4p/4DaAzN9LlVzzEIU1FEfvX8dbPU8CoxQsKJ67dAcRiSnw==
X-Received: by 2002:a05:600c:6992:b0:493:a438:7f98 with SMTP id
 5b1f17b1804b1-496c6590745mr71385315e9.18.1785327788514; 
 Wed, 29 Jul 2026 05:23:08 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49764d70042sm51014105e9.1.2026.07.29.05.23.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 05:23:07 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 29 Jul 2026 12:22:54 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 10
X-Gerrit-Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30
X-Gerrit-Change-Number: 1742
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1742?usp=email>
X-Gerrit-Commit: d55580f6aab38e65976ed4b7f53359bbce443d71
In-Reply-To: <gerrit.1782719911000.Iafa9efc1c156974ad9f5752e9de810a8c2f68c30@gerrit.openvpn.net>
References: <gerrit.1782719911000.Iafa9efc1c156974ad9f5752e9de810a8c2f68c30@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklhZmE5ZWZjMWMxNTY5NzRhZDlmNTc1MmU5ZGU4MTBhOGMyZjY4YzMwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3afb905ddca2801d9026d528e5988459a233daea-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wp3Jb-0006Nt-D2
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
Content-Type: multipart/mixed; boundary="===============4548603142499845786=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4548603142499845786==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vyKnPnI6aSw="; charset=UTF-8

--vyKnPnI6aSw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello fli=
chtenheld, plaisthos, 

I'd like you to reexamine a change=2E Please visit
=

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail

to look at=
 the new patch set (#10)=2E


Change subject: oob: Add SERVER_PROBE parsing=
 and the probe-reply decision
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

oob: Add SERVER_PROBE parsing and the probe-reply decision=


Add the message-level helpers the server needs to answer a probe:

  - oo=
b_server_probe_write() writes a SERVER_PROBE (message-type header +
    pro=
be_parameter TLV); the client uses it later=2E
  - oob_server_probe_read() =
scans the TLV payload of a received OOB
    SERVER_PROBE for the probe_para=
meter TLV, skipping other/future TLV
    types and rejecting malformed or t=
runcated input=2E
  - oob_timestamp_in_window() performs the cheap replay/s=
kew check on the
    probe timestamp described in the wire protocol specifi=
cation=2E
  - oob_build_probe_reply() composes the two: given a received SE=
RVER_PROBE
    it scans for the probe_parameter, drops the probe if it is m=
issing or
    its timestamp is outside the acceptable window, and otherwise=
 populates
    the probe_reply (echoing the peer's session id) to send back=
=2E

A probe whose timestamp falls outside the window is dropped without a =
reply,
which is what the spec allows: the timestamp is there so a server ma=
y silently
drop requests outside an acceptable window and reduce the replay=
 attack surface=2E
The window itself is the caller's choice; the server pat=
h passes --hand-window in
a follow-up=2E

These are pure functions exercise=
d by unit tests; the server packet path
calls oob_build_probe_reply() in a =
follow-up, which performs the actual send=2E

Change-Id: Iafa9efc1c156974ad=
9f5752e9de810a8c2f68c30
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---=

M src/openvpn/oob=2Ec
M src/openvpn/oob=2Eh
M tests/unit_tests/openvpn/tes=
t_oob=2Ec
3 files changed, 289 insertions(+), 0 deletions(-)


  git pull s=
sh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/42/1742/10

diff --g=
it a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec
index c807171=2E=2E930b213 1=
00644
--- a/src/openvpn/oob=2Ec
+++ b/src/openvpn/oob=2Ec
@@ -81,3 +81,54 @=
@
     r->flags =3D buf_read_u32(buf, NULL);
     return true;
 }
+
+bool
+=
oob_server_probe_write(struct buffer *buf, const struct oob_probe_parameter=
 *param)
+{
+    return buf_write_u16(buf, OOB_MSG_SERVER_PROBE) && oob_pro=
be_parameter_write(buf, param);
+}
+
+bool
+oob_server_probe_read(struct bu=
ffer *payload, struct oob_probe_parameter *param)
+{
+    if (!ctrl_msg_rea=
d_header(payload, OOB_MSG_SERVER_PROBE))
+    {
+        return false;
+   =
 }
+
+    struct buffer value;
+    if (!ctrl_msg_find_tlv(payload, OOB_TLV=
_PROBE_PARAMETER, &value))
+    {
+        return false;
+    }
+
+    retu=
rn oob_probe_parameter_read(&value, param);
+}
+
+bool
+oob_timestamp_in_wi=
ndow(uint64_t probe_ts, uint64_t now, uint64_t window_secs)
+{
+    uint64_=
t diff =3D (now > probe_ts) ? (now - probe_ts) : (probe_ts - now);
+    ret=
urn diff <=3D window_secs;
+}
+
+bool
+oob_build_probe_reply(struct buffer =
*probe_payload, uint64_t now, uint64_t window_secs,
+                      =
const struct session_id *peer_sid, struct oob_probe_reply *reply)
+{
+    s=
truct oob_probe_parameter param;
+    if (!oob_server_probe_read(probe_payl=
oad, &param))
+    {
+        return false;
+    }
+
+    /* Drop replayed =
or implausibly-timed probes before doing any more work=2E */
+    if (!oob_=
timestamp_in_window(param=2Etimestamp, now, window_secs))
+    {
+        r=
eturn false;
+    }
+
+    /* the caller's advertised values are kept; only=
 the echo is ours to fill */
+    reply->peer_session_id =3D *peer_sid;
+  =
  return true;
+}
diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh
in=
dex 0a9a4bb=2E=2E1afabbd 100644
--- a/src/openvpn/oob=2Eh
+++ b/src/openvpn=
/oob=2Eh
@@ -107,4 +107,58 @@
  */
 bool oob_probe_reply_read(struct buffer=
 *buf, struct oob_probe_reply *r);
 
+/**
+ * Write a complete SERVER_PROBE=
 message (message-type header + probe_parameter
+ * TLV) to buf=2E Sent by =
the client=2E
+ */
+bool oob_server_probe_write(struct buffer *buf, const s=
truct oob_probe_parameter *param);
+
+/**
+ * Read a received OOB SERVER_PR=
OBE: verify its message-type header, then scan
+ * for the probe_parameter =
TLV=2E TLV types other than probe_parameter are
+ * skipped=2E payload is c=
onsumed as it is read=2E
+ *
+ * @param payload  buffer positioned at the s=
tart of the OOB message payload
+ * @param param    filled with the parsed =
probe_parameter on success
+ * @return true if the header matched and a wel=
l-formed probe_parameter was
+ *         found, false otherwise
+ */
+bool =
oob_server_probe_read(struct buffer *payload, struct oob_probe_parameter *p=
aram);
+
+/**
+ * Check whether a probe timestamp is within an acceptable w=
indow around the
+ * current time=2E Used to cheaply drop replayed or impla=
usibly-timed probes
+ * before doing any further work (see the probe_parame=
ter timestamp rationale
+ * in the wire protocol specification)=2E
+ *
+ * =
@param probe_ts     timestamp from the probe_parameter (UNIX seconds)
+ * @=
param now          current time (UNIX seconds)
+ * @param window_secs  maxi=
mum allowed difference, in either direction
+ * @return true if |now - prob=
e_ts| <=3D window_secs
+ */
+bool oob_timestamp_in_window(uint64_t probe_ts=
, uint64_t now, uint64_t window_secs);
+
+/**
+ * Process the TLV payload o=
f a received SERVER_PROBE and decide whether to
+ * answer it=2E Combines o=
ob_server_probe_read() and oob_timestamp_in_window():
+ * the probe is drop=
ped (false returned) if it has no valid probe_parameter or
+ * its timestam=
p is outside the acceptable window=2E
+ *
+ * reply carries the values the =
server advertises (priority, weight,
+ * max_latency_diff, connect_lifetime=
, flags) in, and is deliberately not
+ * cleared: on success only the peer'=
s session id is filled in, leaving the
+ * reply ready to be wrapped and se=
nt=2E
+ *
+ * This is the transport-agnostic decision step; the caller perf=
orms the send=2E
+ *
+ * @param probe_payload  TLV payload of the received =
OOB SERVER_PROBE
+ * @param now            current time (UNIX seconds)
+ * =
@param window_secs    acceptable timestamp skew, in either direction
+ * @p=
aram peer_sid       session id of the requesting peer (echoed in the reply)=

+ * @param reply          in: the values to advertise; out: the reply to s=
end
+ * @return true if a reply should be sent, false to silently drop the =
probe
+ */
+bool oob_build_probe_reply(struct buffer *probe_payload, uint64=
_t now, uint64_t window_secs,
+                           const struct sess=
ion_id *peer_sid, struct oob_probe_reply *reply);
+
 #endif /* OOB_H */
dif=
f --git a/tests/unit_tests/openvpn/test_oob=2Ec b/tests/unit_tests/openvpn/=
test_oob=2Ec
index aa4eb23=2E=2E371cbc6 100644
--- a/tests/unit_tests/openv=
pn/test_oob=2Ec
+++ b/tests/unit_tests/openvpn/test_oob=2Ec
@@ -259,6 +259,=
181 @@
     gc_free(&gc);
 }
 
+/* A SERVER_PROBE carrying just a probe_par=
ameter is found by the scan=2E */
+static void
+test_server_probe_read_find=
s_parameter(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    str=
uct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    const struct oob_probe_pa=
rameter in =3D {
+        =2Etimestamp =3D 0x1122334455667788ULL,
+        =
=2Eflags =3D 0,
+    };
+    assert_true(oob_server_probe_write(&buf, &in))=
;
+
+    struct oob_probe_parameter out =3D { 0 };
+    assert_true(oob_ser=
ver_probe_read(&buf, &out));
+    assert_true(in=2Etimestamp =3D=3D out=2Et=
imestamp);
+    assert_int_equal(in=2Eflags, out=2Eflags);
+
+    gc_free(&=
gc);
+}
+
+/* TLVs other than probe_parameter are skipped, so the scan find=
s the
+ * probe_parameter even when preceded by an unknown TLV=2E */
+stati=
c void
+test_server_probe_read_skips_unknown(void **state)
+{
+    struct g=
c_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);=

+
+    /* SERVER_PROBE message header, then an unknown TLV (type 0x7ff) =
=2E=2E=2E */
+    assert_true(buf_write_u16(&buf, OOB_MSG_SERVER_PROBE));
+=
    assert_true(ctrl_msg_tlv_write_header(&buf, 0x7ff, false, 4));
+    ass=
ert_true(buf_write_u32(&buf, 0xcafef00d));
+    /* =2E=2E=2E followed by th=
e real probe_parameter */
+    const struct oob_probe_parameter in =3D { =
=2Etimestamp =3D 42, =2Eflags =3D 0 };
+    assert_true(oob_probe_parameter=
_write(&buf, &in));
+
+    struct oob_probe_parameter out =3D { 0 };
+    a=
ssert_true(oob_server_probe_read(&buf, &out));
+    assert_true(out=2Etimes=
tamp =3D=3D 42);
+
+    gc_free(&gc);
+}
+
+/* A payload with no probe_para=
meter must be rejected=2E */
+static void
+test_server_probe_read_missing(v=
oid **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer bu=
f =3D alloc_buf_gc(128, &gc);
+
+    assert_true(buf_write_u16(&buf, OOB_MS=
G_SERVER_PROBE));
+    assert_true(ctrl_msg_tlv_write_header(&buf, 0x7ff, f=
alse, 4));
+    assert_true(buf_write_u32(&buf, 0));
+
+    struct oob_prob=
e_parameter out =3D { 0 };
+    assert_false(oob_server_probe_read(&buf, &o=
ut));
+
+    gc_free(&gc);
+}
+
+/* A TLV whose declared length runs past t=
he buffer must be rejected, not
+ * read out of bounds=2E */
+static void
+=
test_server_probe_read_truncated(void **state)
+{
+    struct gc_arena gc =
=3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    /* =
TLV header claims a 16-byte value but no value bytes follow */
+    assert_=
true(buf_write_u16(&buf, OOB_MSG_SERVER_PROBE));
+    assert_true(ctrl_msg_=
tlv_write_header(&buf, 0x7ff, false, 16));
+
+    struct oob_probe_paramete=
r out =3D { 0 };
+    assert_false(oob_server_probe_read(&buf, &out));
+
+ =
   gc_free(&gc);
+}
+
+/* A SERVER_PROBE reader rejects a payload carrying =
a different message type
+ * (here a PROBE_REPLY's), even if it contains a =
valid probe_parameter TLV=2E */
+static void
+test_server_probe_read_wrong_=
msg_type(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct=
 buffer buf =3D alloc_buf_gc(128, &gc);
+
+    assert_true(buf_write_u16(&b=
uf, OOB_MSG_PROBE_REPLY));
+    const struct oob_probe_parameter in =3D { =
=2Etimestamp =3D 42, =2Eflags =3D 0 };
+    assert_true(oob_probe_parameter=
_write(&buf, &in));
+
+    struct oob_probe_parameter out =3D { 0 };
+    a=
ssert_false(oob_server_probe_read(&buf, &out));
+
+    gc_free(&gc);
+}
+
+=
/* Timestamp window check accepts values within the window (either directio=
n)
+ * and rejects values outside it=2E */
+static void
+test_timestamp_in_=
window(void **state)
+{
+    const uint64_t now =3D 1000000;
+    const uin=
t64_t window =3D 30;
+
+    assert_true(oob_timestamp_in_window(now, now, w=
indow));
+    assert_true(oob_timestamp_in_window(now - window, now, window=
));      /* boundary, past */
+    assert_true(oob_timestamp_in_window(now =
+ window, now, window));      /* boundary, future */
+    assert_false(oob_=
timestamp_in_window(now - window - 1, now, window)); /* too old */
+    ass=
ert_false(oob_timestamp_in_window(now + window + 1, now, window)); /* too f=
ar ahead */
+}
+
+/* A valid, in-window SERVER_PROBE yields a reply that ec=
hoes the peer's
+ * session id and zeroes the remaining fields=2E */
+stati=
c void
+test_build_probe_reply_valid(void **state)
+{
+    struct gc_arena =
gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    =
const uint64_t now =3D 1000000;
+    const struct oob_probe_parameter probe=
 =3D { =2Etimestamp =3D now, =2Eflags =3D 0 };
+    assert_true(oob_server_=
probe_write(&buf, &probe));
+
+    struct session_id peer;
+    memcpy(peer=
=2Eid, "PEER1234", SID_SIZE);
+
+    /* left as the caller set them: the fu=
nction only fills the session id */
+    struct oob_probe_reply reply =3D {=
 0 };
+    assert_true(oob_build_probe_reply(&buf, now, 30, &peer, &reply))=
;
+    assert_memory_equal(reply=2Epeer_session_id=2Eid, peer=2Eid, SID_SIZ=
E);
+    assert_int_equal(reply=2Epriority, 0);
+    assert_int_equal(reply=
=2Eweight, 0);
+    assert_int_equal(reply=2Econnect_lifetime, 0);
+    ass=
ert_int_equal(reply=2Eflags, 0);
+
+    gc_free(&gc);
+}
+
+/* A probe whos=
e timestamp is outside the window is dropped (no reply)=2E */
+static void
=
+test_build_probe_reply_stale(void **state)
+{
+    struct gc_arena gc =3D =
gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    const u=
int64_t now =3D 1000000;
+    const struct oob_probe_parameter probe =3D { =
=2Etimestamp =3D now - 1000, =2Eflags =3D 0 };
+    assert_true(oob_server_=
probe_write(&buf, &probe));
+
+    struct session_id peer =3D { 0 };
+    s=
truct oob_probe_reply reply =3D { 0 };
+    assert_false(oob_build_probe_re=
ply(&buf, now, 30, &peer, &reply));
+
+    gc_free(&gc);
+}
+
+/* A payload=
 without a probe_parameter is dropped (no reply)=2E */
+static void
+test_b=
uild_probe_reply_no_parameter(void **state)
+{
+    struct gc_arena gc =3D =
gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    assert_=
true(buf_write_u16(&buf, OOB_MSG_SERVER_PROBE));
+    assert_true(ctrl_msg_=
tlv_write_header(&buf, 0x7ff, false, 4));
+    assert_true(buf_write_u32(&b=
uf, 0));
+
+    struct session_id peer =3D { 0 };
+    struct oob_probe_rep=
ly reply =3D { 0 };
+    assert_false(oob_build_probe_reply(&buf, 1000000, =
30, &peer, &reply));
+
+    gc_free(&gc);
+}
+
 int
 main(void)
 {
@@ -271,=
6 +446,15 @@
         cmocka_unit_test(test_probe_parameter_too_short),
   =
      cmocka_unit_test(test_find_tlv_value_truncated),
         cmocka_unit=
_test(test_tlv_header_truncated),
+        cmocka_unit_test(test_server_pro=
be_read_finds_parameter),
+        cmocka_unit_test(test_server_probe_read_=
skips_unknown),
+        cmocka_unit_test(test_server_probe_read_missing),
=
+        cmocka_unit_test(test_server_probe_read_truncated),
+        cmock=
a_unit_test(test_server_probe_read_wrong_msg_type),
+        cmocka_unit_te=
st(test_timestamp_in_window),
+        cmocka_unit_test(test_build_probe_re=
ply_valid),
+        cmocka_unit_test(test_build_probe_reply_stale),
+     =
   cmocka_unit_test(test_build_probe_reply_no_parameter),
     };
 
     re=
turn cmocka_run_group_tests_name("oob tests", tests, NULL, NULL);

-- 
To v=
iew, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iafa9efc1c156974ad9f5752e=
9de810a8c2f68c30
Gerrit-Change-Number: 1742
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

--vyKnPnI6aSw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>stipa <strong>uplo=
aded patch set #10</strong> to this change=2E</p><p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail">View Change</a></p><pre cla=
ss=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">oob: Add SERVER_PROBE parsing and the probe-reply decision<br><br>Add=
 the message-level helpers the server needs to answer a probe:<br><br>  - o=
ob_server_probe_write() writes a SERVER_PROBE (message-type header +<br>   =
 probe_parameter TLV); the client uses it later=2E<br>  - oob_server_probe_=
read() scans the TLV payload of a received OOB<br>    SERVER_PROBE for the =
probe_parameter TLV, skipping other/future TLV<br>    types and rejecting m=
alformed or truncated input=2E<br>  - oob_timestamp_in_window() performs th=
e cheap replay/skew check on the<br>    probe timestamp described in the wi=
re protocol specification=2E<br>  - oob_build_probe_reply() composes the tw=
o: given a received SERVER_PROBE<br>    it scans for the probe_parameter, d=
rops the probe if it is missing or<br>    its timestamp is outside the acce=
ptable window, and otherwise populates<br>    the probe_reply (echoing the =
peer&#39;s session id) to send back=2E<br><br>A probe whose timestamp falls=
 outside the window is dropped without a reply,<br>which is what the spec a=
llows: the timestamp is there so a server may silently<br>drop requests out=
side an acceptable window and reduce the replay attack surface=2E<br>The wi=
ndow itself is the caller&#39;s choice; the server path passes --hand-windo=
w in<br>a follow-up=2E<br><br>These are pure functions exercised by unit te=
sts; the server packet path<br>calls oob_build_probe_reply() in a follow-up=
, which performs the actual send=2E<br><br>Change-Id: Iafa9efc1c156974ad9f5=
752e9de810a8c2f68c30<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&g=
t;<br>---<br>M src/openvpn/oob=2Ec<br>M src/openvpn/oob=2Eh<br>M tests/unit=
_tests/openvpn/test_oob=2Ec<br>3 files changed, 289 insertions(+), 0 deleti=
ons(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn refs/changes/42/1742/10</pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/oob=2Ec=
 b/src/openvpn/oob=2Ec</span><br><span>index c807171=2E=2E930b213 100644</s=
pan><br><span>--- a/src/openvpn/oob=2Ec</span><br><span>+++ b/src/openvpn/o=
ob=2Ec</span><br><span>@@ -81,3 +81,54 @@</span><br><span>     r-&gt;flags =
=3D buf_read_u32(buf, NULL);</span><br><span>     return true;</span><br><s=
pan> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+oob_server_probe_write(struct buffer *buf, cons=
t struct oob_probe_parameter *param)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   return buf_write_u16(buf, OOB_MSG_SERVER_PROBE) &amp;&amp; oob_probe_par=
ameter_write(buf, param);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+oob_server_probe_read(struct buffer *payload, =
struct oob_probe_parameter *param)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (!ctrl_msg_read_header(payload, OOB_MSG_SERVER_PROBE))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct buffer value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (!ctrl_msg_find_tlv(payload, OOB_TLV_PROBE_PARAMETER, &amp;value))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    return oob_probe_parameter_read(&amp;value, param);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_time=
stamp_in_window(uint64_t probe_ts, uint64_t now, uint64_t window_secs)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    uint64_t diff =3D (now &gt; probe_ts)=
 ? (now - probe_ts) : (probe_ts - now);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return diff &lt;=3D window_secs;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_build_probe=
_reply(struct buffer *probe_payload, uint64_t now, uint64_t window_secs,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
const struct session_id *peer_sid, struct oob_probe_reply *reply)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct oob_probe_parameter param;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (!oob_server_probe_rea=
d(probe_payload, &amp;param))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* Drop replayed or implausibly=
-timed probes before doing any more work=2E */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (!oob_timestamp_in_window(param=2Etimesta=
mp, now, window_secs))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret=
urn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* the caller&#39;s advertised values=
 are kept; only the echo is ours to fill */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    reply-&gt;peer_session_id =3D *peer_sid;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git =
a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh</span><br><span>index 0a9a4bb=
=2E=2E1afabbd 100644</span><br><span>--- a/src/openvpn/oob=2Eh</span><br><s=
pan>+++ b/src/openvpn/oob=2Eh</span><br><span>@@ -107,4 +107,58 @@</span><b=
r><span>  */</span><br><span> bool oob_probe_reply_read(struct buffer *buf,=
 struct oob_probe_reply *r);</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * Write a complete SERVER_PROBE message (message-type header + =
probe_parameter</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * T=
LV) to buf=2E Sent by the client=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
bool oob_server_probe_write(struct buffer *buf, const struct oob_probe_para=
meter *param);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * Read a received OOB SERVER_PROBE: ver=
ify its message-type header, then scan</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * for the probe_parameter TLV=2E TLV types other than p=
robe_parameter are</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* skipped=2E payload is consumed as it is read=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @param payload  buffer positioned at the start of the OOB m=
essage payload</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p=
aram param    filled with the parsed probe_parameter on success</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @return true if the header m=
atched and a well-formed probe_parameter was</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *         found, false otherwise</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+bool oob_server_probe_read(struct buffer *payload, s=
truct oob_probe_parameter *param);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Check whether a p=
robe timestamp is within an acceptable window around the</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * current time=2E Used to cheaply dro=
p replayed or implausibly-timed probes</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * before doing any further work (see the probe_paramete=
r timestamp rationale</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * in the wire protocol specification)=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * @param probe_ts     timestamp from the probe_parameter (UNIX seco=
nds)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param now  =
        current time (UNIX seconds)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * @param window_secs  maximum allowed difference, in eithe=
r direction</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @retu=
rn true if |now - probe_ts| &lt;=3D window_secs</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+bool oob_timestamp_in_window(uint64_t probe_ts, uint64_t now, u=
int64_t window_secs);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * Process the TLV payload of a r=
eceived SERVER_PROBE and decide whether to</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * answer it=2E Combines oob_server_probe_read() and=
 oob_timestamp_in_window():</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * the probe is dropped (false returned) if it has no valid probe_p=
arameter or</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * its t=
imestamp is outside the acceptable window=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * reply carries the values the server advertises (priority, weight=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * max_latency_dif=
f, connect_lifetime, flags) in, and is deliberately not</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * cleared: on success only the peer&#3=
9;s session id is filled in, leaving the</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * reply ready to be wrapped and sent=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * This is the transport-agnostic decision step; t=
he caller performs the send=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @pa=
ram probe_payload  TLV payload of the received OOB SERVER_PROBE</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @param now            curren=
t time (UNIX seconds)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param window_secs    acceptable timestamp skew, in either direction</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param peer_sid   =
    session id of the requesting peer (echoed in the reply)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * @param reply          in: the va=
lues to advertise; out: the reply to send</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @return true if a reply should be sent, false to s=
ilently drop the probe</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool oob_buil=
d_probe_reply(struct buffer *probe_payload, uint64_t now, uint64_t window_s=
ecs,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
            const struct session_id *peer_sid, struct oob_probe_reply *repl=
y);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
> #endif /* OOB_H */</span><br><span>diff --git a/tests/unit_tests/openvpn/=
test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>index =
aa4eb23=2E=2E371cbc6 100644</span><br><span>--- a/tests/unit_tests/openvpn/=
test_oob=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_oob=2Ec</s=
pan><br><span>@@ -259,6 +259,181 @@</span><br><span>     gc_free(&amp;gc);<=
/span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/* A SERVER_PROBE carrying just a probe_parameter is found=
 by the scan=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_serv=
er_probe_read_finds_parameter(void **state)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    const struct oob_probe_parameter =
in =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2E=
timestamp =3D 0x1122334455667788ULL,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        =2Eflags =3D 0,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_true(oob_server_probe_write(&amp;buf, &amp;in));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct oob_probe_parameter out =3D { 0 };<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_=
server_probe_read(&amp;buf, &amp;out));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_true(in=2Etimestamp =3D=3D out=2Etimestamp);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equa=
l(in=2Eflags, out=2Eflags);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free=
(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/* TLVs other than probe_parameter are skipped=
, so the scan finds the</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * probe_parameter even when preceded by an unknown TLV=2E */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+test_server_probe_read_skips_unknown(=
void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =
=3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* SERVER_PROBE message header, then an unknown TLV (type 0x7f=
f) =2E=2E=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_true(buf_write_u16(&amp;buf, OOB_MSG_SERVER_PROBE));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_=
header(&amp;buf, 0x7ff, false, 4));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_true(buf_write_u32(&amp;buf, 0xcafef00d));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =2E=2E=2E followed=
 by the real probe_parameter */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    const struct oob_probe_parameter in =3D { =2Etimestamp =3D =
42, =2Eflags =3D 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_true(oob_probe_parameter_write(&amp;buf, &amp;in));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct oob_probe_parameter out =3D { 0 };</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_ser=
ver_probe_read(&amp;buf, &amp;out));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_true(out=2Etimestamp =3D=3D 42);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A payload =
with no probe_parameter must be rejected=2E */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+test_server_probe_read_missing(void **state)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_=
buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(b=
uf_write_u16(&amp;buf, OOB_MSG_SERVER_PROBE));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;b=
uf, 0x7ff, false, 4));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_true(buf_write_u32(&amp;buf, 0));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct oob_probe_parameter out =3D { 0 };</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_false(oob_server_probe_read(&=
amp;buf, &amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/* A TLV whose declared length runs past the buffer m=
ust be rejected, not</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * read out of bounds=2E */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+test_server_probe_read_truncated(void **state)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp=
;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* TLV header claims a 16-byt=
e value but no value bytes follow */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_true(buf_write_u16(&amp;buf, OOB_MSG_SERVER_PRO=
BE));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tru=
e(ctrl_msg_tlv_write_header(&amp;buf, 0x7ff, false, 16));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct oob_probe_parameter out =3D { 0 };</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(oob_server_pr=
obe_read(&amp;buf, &amp;out));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_f=
ree(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* A SERVER_PROBE reader rejects a payloa=
d carrying a different message type</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * (here a PROBE_REPLY&#39;s), even if it contains a valid =
probe_parameter TLV=2E */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+te=
st_server_probe_read_wrong_msg_type(void **state)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &a=
mp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u16(&=
amp;buf, OOB_MSG_PROBE_REPLY));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    const struct oob_probe_parameter in =3D { =2Etimestamp =3D =
42, =2Eflags =3D 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_true(oob_probe_parameter_write(&amp;buf, &amp;in));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct oob_probe_parameter out =3D { 0 };</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(oob_se=
rver_probe_read(&amp;buf, &amp;out));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/* Timestamp window check accepts va=
lues within the window (either direction)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * and rejects values outside it=2E */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+test_timestamp_in_window(void **state)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    const uint64_t now =3D 1000000;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint64_t windo=
w =3D 30;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_timestamp=
_in_window(now, now, window));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_true(oob_timestamp_in_window(now - window, now, windo=
w));      /* boundary, past */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_true(oob_timestamp_in_window(now + window, now, windo=
w));      /* boundary, future */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_false(oob_timestamp_in_window(now - window - 1, now=
, window)); /* too old */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_false(oob_timestamp_in_window(now + window + 1, now, windo=
w)); /* too far ahead */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/* A valid, in-window SERVER_PRO=
BE yields a reply that echoes the peer&#39;s</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * session id and zeroes the remaining fields=2E *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+test_build_probe_reply_val=
id(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena g=
c =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const uint64_t now =3D 1000000;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    const struct oob_probe_parameter probe =3D {=
 =2Etimestamp =3D now, =2Eflags =3D 0 };</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_true(oob_server_probe_write(&amp;buf, &amp;=
probe));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct session_id peer;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(peer=2Eid, =
&quot;PEER1234&quot;, SID_SIZE);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
 left as the caller set them: the function only fills the session id */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_re=
ply reply =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_true(oob_build_probe_reply(&amp;buf, now, 30, &amp;peer, &amp;r=
eply));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_m=
emory_equal(reply=2Epeer_session_id=2Eid, peer=2Eid, SID_SIZE);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(reply=2Epr=
iority, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_int_equal(reply=2Eweight, 0);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_int_equal(reply=2Econnect_lifetime, 0);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(reply=2Efl=
ags, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/* A probe whose timestamp is outside the window is dropped (no r=
eply)=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static v=
oid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_build_probe=
_reply_stale(void **state)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const uint64_t now =3D 1000000;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    const struct oob_probe_parameter p=
robe =3D { =2Etimestamp =3D now - 1000, =2Eflags =3D 0 };</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_server_probe_writ=
e(&amp;buf, &amp;probe));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct se=
ssion_id peer =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct oob_probe_reply reply =3D { 0 };</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_false(oob_build_probe_reply(&amp;bu=
f, now, 30, &amp;peer, &amp;reply));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/* A payload without a probe_paramete=
r is dropped (no reply)=2E */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+test_build_probe_reply_no_parameter(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(12=
8, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_=
u16(&amp;buf, OOB_MSG_SERVER_PROBE));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;buf, 0x7ff=
, false, 4));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_true(buf_write_u32(&amp;buf, 0));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct session_id peer =3D { 0 };</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct oob_probe_reply reply =3D { 0 };</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_false(oob_build_probe_=
reply(&amp;buf, 1000000, 30, &amp;peer, &amp;reply));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> int</span><br><span> main(void)</span><br><span> {</span><=
br><span>@@ -271,6 +446,15 @@</span><br><span>         cmocka_unit_test(tes=
t_probe_parameter_too_short),</span><br><span>         cmocka_unit_test(tes=
t_find_tlv_value_truncated),</span><br><span>         cmocka_unit_test(test=
_tlv_header_truncated),</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        cmocka_unit_test(test_server_probe_read_finds_parameter),</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(=
test_server_probe_read_skips_unknown),</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        cmocka_unit_test(test_server_probe_read_missing)=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_uni=
t_test(test_server_probe_read_truncated),</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        cmocka_unit_test(test_server_probe_read_wrong=
_msg_type),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
cmocka_unit_test(test_timestamp_in_window),</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        cmocka_unit_test(test_build_probe_reply_val=
id),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_=
unit_test(test_build_probe_reply_stale),</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        cmocka_unit_test(test_build_probe_reply_no_par=
ameter),</span><br><span>     };</span><br><span> </span><br><span>     ret=
urn cmocka_run_group_tests_name(&quot;oob tests&quot;, tests, NULL, NULL);<=
/span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail">change 1742</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iafa9efc1c156974ad=
9f5752e9de810a8c2f68c30 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1742 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
=
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;f=
rank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body><=
/html>
--vyKnPnI6aSw=--


--===============4548603142499845786==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4548603142499845786==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4548603142499845786==--

