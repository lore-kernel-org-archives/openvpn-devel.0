Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD75C61DBD
	for <openvpn-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=reKpVV/y+xh0J//xlx487EzP1L2GO1QaWqFyH/rBtN4=; b=eTfJ4wvNhlH6H8sxh316Qlztd4
	KN1q+aG5yGupmbtMTSBUeUxVz8H7+1QDYKcJ5cUT2pWTVGeeY4ZChYYBxodZQycuQgzj5A0a4nbwk
	HydS6FB5B3g5pvCVuKoaLl57aUJpTSAVyOv2koi5DUJIbGhFlqn+ONbHShrsZI93sz2s=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzw3J-0002q6-Cb;
	Fri, 28 Aug 2026 12:51:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzw3H-0002pz-Ld
 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 12:51:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=nKl+xfHUnItzCGPfVFOdzDjijQg9G7FbYZuREs7+7Pc=; b=g79pbD3dzCj6VK4AlnIcCcwv0T
 OnIQPzqH4CuaCW7XGif4emH/3IKi2Qcrbb2tuN1lt4BV8ahVfc7VGa19vLR/g85KOoHaEwa6F+/XW
 iB5BBDPaeQyyOTcSQfHfiqf8lsLk08ZiTIFprTnLxWOCamYkMVz0Icx6zCdy971mAB9M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=nKl+xfHUnItzCGPfVFOdzDjijQg9G7FbYZuREs7+7Pc=; b=H
 bbHO6vyluChrXZnC2I7m1Al2KRBBC6Dy/zJwbEHheCUDLnUnO7HPmFp/0QM8ZpaeyLBlHuh+ms5ua
 DZ34g2V/8D/jLlaYlR3WmybLd8w8HmLYrQy3f8UxZ+wR3SgEENIRYzBJvq0TOM6isboveRIx9vLLy
 ddzjncnpoPj9XZtc=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzw3A-0005Fx-G6 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 12:51:21 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-49b8ce9b733so6814275e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 28 Aug 2026 05:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787921470; x=1788526270; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nKl+xfHUnItzCGPfVFOdzDjijQg9G7FbYZuREs7+7Pc=;
 b=QFXtXnHOaeOSKvsBhCmx/tr3jqs58RYr3tk5oOdzsilw4w2Ie2hNeWQsH31KiVmRow
 bI+I16VVXGF9aExwSL/zUI6nIRgPeKKncWxh/gNr4XnPhcBmSjZfr6nfZWlcb9ODldzh
 ldxeWPqOXR1jxfpTMhaWnAYI1P3lwAyCokX1dtNwR1P1bfCNDfms8tG2U5ZZhoSbtyYF
 /zbxsl425SBMTIzfnhs41+IwqsGI5cutCxkY42cHhKy/K8ebVI6WUkLJF4rhGuEogrCP
 oNvUJBa6dEJRkORBOGFO0GErMJSkZOx+3uSQ2YwNGicMTqWNRzizdSNipntBcQqUb2k2
 LanQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787921470; x=1788526270;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=nKl+xfHUnItzCGPfVFOdzDjijQg9G7FbYZuREs7+7Pc=;
 b=Fx63B02656pmKrvIU+ynhEeOLjX1rCdcED1RkPf9bqb/aiF21q80pGGBEwF4c0ChJ1
 DAIXQKVRDm9W5yb8Y8ygQRaWXOdTZMgfQHKvxf/uQ3zeTASMMlXxCv6berL6qCpy+X4Y
 hFQFYFPQOPTMM0uCwIjqUHQ4zGmJIO8vdRBYroBiW13INmbjdFEAoWmvplVCb0fAo9NI
 qbN10jZrpHOdjyWlK26ur89TtG2Mj94SH7/sgcrqfcnxdU7z26Xp2q/N1qZsnGe0ejcP
 XquI0A5VzKgqoxHrbrNYPaIol0ciKm6IqU7A2fGQBqnHdL5ftVBPRYkpG8HQsLtydlIQ
 aWTA==
X-Gm-Message-State: AFuF++k0PIygnJ9NE/k5fo74tUajownwDVsZekd27idq4n/mcfC2tWfS
 MgP3k9GDO6nKYNvsEpiNu2E9vSxpPf7lMFEoE7IUxxhuUawkspnXYfkyYbCd77LYQytabBsg3iw
 GjuEehXktCu8wU4MDa76IGOK1X0sTwHIqCwLrfP/XVx0a+zf+voPZI7BRu6HQWhX9YRndL8ckN3
 6/1wDJdw==
X-Gm-Gg: AR+sD13JxHOVXlBEYFE7pgqtkpeikPVqj2XeMSbVwDrgPYHVtuYLoQTK+hr9sEiqpAx
 qz9JxeKgefAu+u/kzOiqIN/Uc6Cv3Vj9Cb7iaVfkDbAAwHuL0NQQVN7xPugCZQ8EWZkNFXlfRLc
 OSShQvBe48q7mnoSf4kgQ7tH9kQPxrmma4oYHi/IkZMDNyV3gu2QruHHYQxhr3iReAZf4QkSvzz
 BynfAwTtioOjG+quHt5URhRglxNgA/kzvs6C/TFJK8tvhF5KaFYuFFxb5jQWAfsQJMRzuxu6RPP
 s4p1BRMQLSwdeKZFeBxU2dO0QFqCYz2sLiMOeQHVnq+Cds5jWGHvSUiqQJsh3kLHY99OHw7YfSk
 CqDefIhM9jISMLFLyHCXlnlKhOvQPlyOcbgcjvv+jtMxbLhlF/r0tXscnUV3+7EnIQVh6AzrDRW
 f1yaXI9zMcYmqyNMj/7M59Trud40mG8/WmUe3/a/RhtsgPlnkjZElGtGfcwUha2NZ6GqdLPWRlC
 5ZQZ/67Wso66Z5c+mF54I9Ms0Y1fI5UtvSr1gYOpR8MnR3XhC9ifL59YgX05Twz1twKeufJELqR
 mmYRpSnovsFv0BMOd7ik0ICsohkeVKleB9Sspie53fCMr+3oOWw=
X-Received: by 2002:a05:600c:609a:b0:49b:9032:9c94 with SMTP id
 5b1f17b1804b1-49b91bd41eemr103637965e9.0.1787921469607; 
 Fri, 28 Aug 2026 05:51:09 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cc8e06808sm10089685e9.8.2026.08.28.05.51.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 05:51:09 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 28 Aug 2026 12:51:00 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 12
X-Gerrit-Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30
X-Gerrit-Change-Number: 1742
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1742?usp=email>
X-Gerrit-Commit: 8a45bcacebf903eea3c03773a73159560a6ea3ee
In-Reply-To: <gerrit.1782719911000.Iafa9efc1c156974ad9f5752e9de810a8c2f68c30@gerrit.openvpn.net>
References: <gerrit.1782719911000.Iafa9efc1c156974ad9f5752e9de810a8c2f68c30@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklhZmE5ZWZjMWMxNTY5NzRhZDlmNTc1MmU5ZGU4MTBhOGMyZjY4YzMwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <eac7a192d6c7796ce88c1d37bc5423890fc06754-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzw3A-0005Fx-G6
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
Content-Type: multipart/mixed; boundary="===============0566951941435169539=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0566951941435169539==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hgu0UK0ISq0="; charset=UTF-8

--hgu0UK0ISq0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello fli=
chtenheld, plaisthos, 

I'd like you to reexamine a change=2E Please visit
=

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail

to look at=
 the new patch set (#12)=2E


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
    types that are marked optional, an=
d rejecting malformed or truncated
    input as well as a mandatory TLV it =
does not understand=2E
  - oob_timestamp_in_window() performs the cheap rep=
lay/skew check on the
    probe timestamp described in the wire protocol sp=
ecification=2E
  - oob_build_probe_reply() composes the two: given a receiv=
ed SERVER_PROBE
    it scans for the probe_parameter, drops the probe if it=
 is missing or
    its timestamp is outside the acceptable window, and othe=
rwise populates
    the probe_reply (echoing the peer's session id) to send=
 back=2E

A probe whose timestamp falls outside the window is dropped witho=
ut a reply,
which is what the spec allows: the timestamp is there so a serv=
er may silently
drop requests outside an acceptable window and reduce the r=
eplay attack surface=2E
The window itself is the caller's choice; the serve=
r path passes --hand-window in
a follow-up=2E

These are pure functions exe=
rcised by unit tests; the server packet path
calls oob_build_probe_reply() =
in a follow-up, which performs the actual send=2E

Change-Id: Iafa9efc1c156=
974ad9f5752e9de810a8c2f68c30
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet=
>
---
M src/openvpn/oob=2Ec
M src/openvpn/oob=2Eh
M tests/unit_tests/openvp=
n/test_oob=2Ec
3 files changed, 319 insertions(+), 0 deletions(-)


  git p=
ull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/42/1742/12

dif=
f --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec
index c807171=2E=2E930b=
213 100644
--- a/src/openvpn/oob=2Ec
+++ b/src/openvpn/oob=2Ec
@@ -81,3 +81=
,54 @@
     r->flags =3D buf_read_u32(buf, NULL);
     return true;
 }
+
+b=
ool
+oob_server_probe_write(struct buffer *buf, const struct oob_probe_para=
meter *param)
+{
+    return buf_write_u16(buf, OOB_MSG_SERVER_PROBE) && oo=
b_probe_parameter_write(buf, param);
+}
+
+bool
+oob_server_probe_read(stru=
ct buffer *payload, struct oob_probe_parameter *param)
+{
+    if (!ctrl_ms=
g_read_header(payload, OOB_MSG_SERVER_PROBE))
+    {
+        return false;=

+    }
+
+    struct buffer value;
+    if (!ctrl_msg_find_tlv(payload, OO=
B_TLV_PROBE_PARAMETER, &value))
+    {
+        return false;
+    }
+
+   =
 return oob_probe_parameter_read(&value, param);
+}
+
+bool
+oob_timestamp_=
in_window(uint64_t probe_ts, uint64_t now, uint64_t window_secs)
+{
+    ui=
nt64_t diff =3D (now > probe_ts) ? (now - probe_ts) : (probe_ts - now);
+  =
  return diff <=3D window_secs;
+}
+
+bool
+oob_build_probe_reply(struct bu=
ffer *probe_payload, uint64_t now, uint64_t window_secs,
+                 =
     const struct session_id *peer_sid, struct oob_probe_reply *reply)
+{
+=
    struct oob_probe_parameter param;
+    if (!oob_server_probe_read(probe=
_payload, &param))
+    {
+        return false;
+    }
+
+    /* Drop repl=
ayed or implausibly-timed probes before doing any more work=2E */
+    if (=
!oob_timestamp_in_window(param=2Etimestamp, now, window_secs))
+    {
+    =
    return false;
+    }
+
+    /* the caller's advertised values are kept;=
 only the echo is ours to fill */
+    reply->peer_session_id =3D *peer_sid=
;
+    return true;
+}
diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=
=2Eh
index 0a9a4bb=2E=2E1afabbd 100644
--- a/src/openvpn/oob=2Eh
+++ b/src/=
openvpn/oob=2Eh
@@ -107,4 +107,58 @@
  */
 bool oob_probe_reply_read(struct=
 buffer *buf, struct oob_probe_reply *r);
 
+/**
+ * Write a complete SERVE=
R_PROBE message (message-type header + probe_parameter
+ * TLV) to buf=2E S=
ent by the client=2E
+ */
+bool oob_server_probe_write(struct buffer *buf, =
const struct oob_probe_parameter *param);
+
+/**
+ * Read a received OOB SE=
RVER_PROBE: verify its message-type header, then scan
+ * for the probe_par=
ameter TLV=2E TLV types other than probe_parameter are
+ * skipped=2E paylo=
ad is consumed as it is read=2E
+ *
+ * @param payload  buffer positioned a=
t the start of the OOB message payload
+ * @param param    filled with the =
parsed probe_parameter on success
+ * @return true if the header matched an=
d a well-formed probe_parameter was
+ *         found, false otherwise
+ */=

+bool oob_server_probe_read(struct buffer *payload, struct oob_probe_param=
eter *param);
+
+/**
+ * Check whether a probe timestamp is within an accep=
table window around the
+ * current time=2E Used to cheaply drop replayed o=
r implausibly-timed probes
+ * before doing any further work (see the probe=
_parameter timestamp rationale
+ * in the wire protocol specification)=2E
+=
 *
+ * @param probe_ts     timestamp from the probe_parameter (UNIX seconds=
)
+ * @param now          current time (UNIX seconds)
+ * @param window_sec=
s  maximum allowed difference, in either direction
+ * @return true if |now=
 - probe_ts| <=3D window_secs
+ */
+bool oob_timestamp_in_window(uint64_t p=
robe_ts, uint64_t now, uint64_t window_secs);
+
+/**
+ * Process the TLV pa=
yload of a received SERVER_PROBE and decide whether to
+ * answer it=2E Com=
bines oob_server_probe_read() and oob_timestamp_in_window():
+ * the probe =
is dropped (false returned) if it has no valid probe_parameter or
+ * its t=
imestamp is outside the acceptable window=2E
+ *
+ * reply carries the valu=
es the server advertises (priority, weight,
+ * max_latency_diff, connect_l=
ifetime, flags) in, and is deliberately not
+ * cleared: on success only th=
e peer's session id is filled in, leaving the
+ * reply ready to be wrapped=
 and sent=2E
+ *
+ * This is the transport-agnostic decision step; the call=
er performs the send=2E
+ *
+ * @param probe_payload  TLV payload of the re=
ceived OOB SERVER_PROBE
+ * @param now            current time (UNIX second=
s)
+ * @param window_secs    acceptable timestamp skew, in either direction=

+ * @param peer_sid       session id of the requesting peer (echoed in the=
 reply)
+ * @param reply          in: the values to advertise; out: the rep=
ly to send
+ * @return true if a reply should be sent, false to silently dr=
op the probe
+ */
+bool oob_build_probe_reply(struct buffer *probe_payload,=
 uint64_t now, uint64_t window_secs,
+                           const stru=
ct session_id *peer_sid, struct oob_probe_reply *reply);
+
 #endif /* OOB_H=
 */
diff --git a/tests/unit_tests/openvpn/test_oob=2Ec b/tests/unit_tests/o=
penvpn/test_oob=2Ec
index aa4eb23=2E=2E3b29b52 100644
--- a/tests/unit_test=
s/openvpn/test_oob=2Ec
+++ b/tests/unit_tests/openvpn/test_oob=2Ec
@@ -259,=
6 +259,210 @@
     gc_free(&gc);
 }
 
+/* A SERVER_PROBE carrying just a pr=
obe_parameter is found by the scan=2E */
+static void
+test_server_probe_re=
ad_finds_parameter(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+=
    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    const struct oob_p=
robe_parameter in =3D {
+        =2Etimestamp =3D 0x1122334455667788ULL,
+ =
       =2Eflags =3D 0,
+    };
+    assert_true(oob_server_probe_write(&buf=
, &in));
+
+    struct oob_probe_parameter out =3D { 0 };
+    assert_true(=
oob_server_probe_read(&buf, &out));
+    assert_true(in=2Etimestamp =3D=3D =
out=2Etimestamp);
+    assert_int_equal(in=2Eflags, out=2Eflags);
+
+    gc=
_free(&gc);
+}
+
+/* TLVs other than probe_parameter are skipped, so the sc=
an finds the
+ * probe_parameter even when preceded by an unknown TLV=2E */=

+static void
+test_server_probe_read_skips_unknown(void **state)
+{
+    s=
truct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128=
, &gc);
+
+    /* SERVER_PROBE message header, then an unknown but optional=
 TLV (type
+     * 0x7ff) =2E=2E=2E */
+    assert_true(buf_write_u16(&buf,=
 OOB_MSG_SERVER_PROBE));
+    assert_true(ctrl_msg_tlv_write_header(&buf, 0=
x7ff, true, 4));
+    assert_true(buf_write_u32(&buf, 0xcafef00d));
+    /*=
 =2E=2E=2E followed by the real probe_parameter */
+    const struct oob_pr=
obe_parameter in =3D { =2Etimestamp =3D 42, =2Eflags =3D 0 };
+    assert_t=
rue(oob_probe_parameter_write(&buf, &in));
+
+    struct oob_probe_paramete=
r out =3D { 0 };
+    assert_true(oob_server_probe_read(&buf, &out));
+    =
assert_true(out=2Etimestamp =3D=3D 42);
+
+    gc_free(&gc);
+}
+
+/* An un=
known TLV that is NOT marked optional carries something the sender
+ * requ=
ires us to act on: the whole message is rejected, whether that TLV comes
+ =
* before or after the one we were looking for=2E */
+static void
+test_serv=
er_probe_read_rejects_unknown_mandatory(void **state)
+{
+    struct gc_are=
na gc =3D gc_new();
+    const struct oob_probe_parameter in =3D { =2Etimes=
tamp =3D 42, =2Eflags =3D 0 };
+
+    struct buffer before =3D alloc_buf_gc=
(128, &gc);
+    assert_true(buf_write_u16(&before, OOB_MSG_SERVER_PROBE));=

+    assert_true(ctrl_msg_tlv_write_header(&before, 0x7ff, false, 4));
+  =
  assert_true(buf_write_u32(&before, 0xcafef00d));
+    assert_true(oob_pro=
be_parameter_write(&before, &in));
+
+    struct buffer after =3D alloc_buf=
_gc(128, &gc);
+    assert_true(buf_write_u16(&after, OOB_MSG_SERVER_PROBE)=
);
+    assert_true(oob_probe_parameter_write(&after, &in));
+    assert_tr=
ue(ctrl_msg_tlv_write_header(&after, 0x7ff, false, 4));
+    assert_true(bu=
f_write_u32(&after, 0xcafef00d));
+
+    struct oob_probe_parameter out =3D=
 { 0 };
+    assert_false(oob_server_probe_read(&before, &out));
+    asser=
t_false(oob_server_probe_read(&after, &out));
+
+    gc_free(&gc);
+}
+
+/*=
 A payload with no probe_parameter must be rejected=2E */
+static void
+tes=
t_server_probe_read_missing(void **state)
+{
+    struct gc_arena gc =3D gc=
_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    assert_tr=
ue(buf_write_u16(&buf, OOB_MSG_SERVER_PROBE));
+    assert_true(ctrl_msg_tl=
v_write_header(&buf, 0x7ff, true, 4));
+    assert_true(buf_write_u32(&buf,=
 0));
+
+    struct oob_probe_parameter out =3D { 0 };
+    assert_false(oo=
b_server_probe_read(&buf, &out));
+
+    gc_free(&gc);
+}
+
+/* A TLV whose=
 declared length runs past the buffer must be rejected, not
+ * read out of=
 bounds=2E */
+static void
+test_server_probe_read_truncated(void **state)
=
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_b=
uf_gc(128, &gc);
+
+    /* TLV header claims a 16-byte value but no value b=
ytes follow */
+    assert_true(buf_write_u16(&buf, OOB_MSG_SERVER_PROBE));=

+    assert_true(ctrl_msg_tlv_write_header(&buf, 0x7ff, false, 16));
+
+  =
  struct oob_probe_parameter out =3D { 0 };
+    assert_false(oob_server_pr=
obe_read(&buf, &out));
+
+    gc_free(&gc);
+}
+
+/* A SERVER_PROBE reader =
rejects a payload carrying a different message type
+ * (here a PROBE_REPLY=
's), even if it contains a valid probe_parameter TLV=2E */
+static void
+te=
st_server_probe_read_wrong_msg_type(void **state)
+{
+    struct gc_arena g=
c =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    a=
ssert_true(buf_write_u16(&buf, OOB_MSG_PROBE_REPLY));
+    const struct oob=
_probe_parameter in =3D { =2Etimestamp =3D 42, =2Eflags =3D 0 };
+    asser=
t_true(oob_probe_parameter_write(&buf, &in));
+
+    struct oob_probe_param=
eter out =3D { 0 };
+    assert_false(oob_server_probe_read(&buf, &out));
+=

+    gc_free(&gc);
+}
+
+/* Timestamp window check accepts values within t=
he window (either direction)
+ * and rejects values outside it=2E */
+stati=
c void
+test_timestamp_in_window(void **state)
+{
+    const uint64_t now =
=3D 1000000;
+    const uint64_t window =3D 30;
+
+    assert_true(oob_time=
stamp_in_window(now, now, window));
+    assert_true(oob_timestamp_in_windo=
w(now - window, now, window));      /* boundary, past */
+    assert_true(o=
ob_timestamp_in_window(now + window, now, window));      /* boundary, futur=
e */
+    assert_false(oob_timestamp_in_window(now - window - 1, now, windo=
w)); /* too old */
+    assert_false(oob_timestamp_in_window(now + window +=
 1, now, window)); /* too far ahead */
+}
+
+/* A valid, in-window SERVER_P=
ROBE yields a reply that echoes the peer's
+ * session id and zeroes the re=
maining fields=2E */
+static void
+test_build_probe_reply_valid(void **stat=
e)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D allo=
c_buf_gc(128, &gc);
+
+    const uint64_t now =3D 1000000;
+    const struc=
t oob_probe_parameter probe =3D { =2Etimestamp =3D now, =2Eflags =3D 0 };
+=
    assert_true(oob_server_probe_write(&buf, &probe));
+
+    struct sessio=
n_id peer;
+    memcpy(peer=2Eid, "PEER1234", SID_SIZE);
+
+    /* left as =
the caller set them: the function only fills the session id */
+    struct =
oob_probe_reply reply =3D { 0 };
+    assert_true(oob_build_probe_reply(&bu=
f, now, 30, &peer, &reply));
+    assert_memory_equal(reply=2Epeer_session_=
id=2Eid, peer=2Eid, SID_SIZE);
+    assert_int_equal(reply=2Epriority, 0);
=
+    assert_int_equal(reply=2Eweight, 0);
+    assert_int_equal(reply=2Econ=
nect_lifetime, 0);
+    assert_int_equal(reply=2Eflags, 0);
+
+    gc_free(=
&gc);
+}
+
+/* A probe whose timestamp is outside the window is dropped (no=
 reply)=2E */
+static void
+test_build_probe_reply_stale(void **state)
+{
+=
    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_g=
c(128, &gc);
+
+    const uint64_t now =3D 1000000;
+    const struct oob_p=
robe_parameter probe =3D { =2Etimestamp =3D now - 1000, =2Eflags =3D 0 };
+=
    assert_true(oob_server_probe_write(&buf, &probe));
+
+    struct sessio=
n_id peer =3D { 0 };
+    struct oob_probe_reply reply =3D { 0 };
+    asse=
rt_false(oob_build_probe_reply(&buf, now, 30, &peer, &reply));
+
+    gc_fr=
ee(&gc);
+}
+
+/* A payload without a probe_parameter is dropped (no reply)=
=2E */
+static void
+test_build_probe_reply_no_parameter(void **state)
+{
+=
    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_g=
c(128, &gc);
+
+    assert_true(buf_write_u16(&buf, OOB_MSG_SERVER_PROBE));=

+    assert_true(ctrl_msg_tlv_write_header(&buf, 0x7ff, true, 4));
+    as=
sert_true(buf_write_u32(&buf, 0));
+
+    struct session_id peer =3D { 0 };=

+    struct oob_probe_reply reply =3D { 0 };
+    assert_false(oob_build_p=
robe_reply(&buf, 1000000, 30, &peer, &reply));
+
+    gc_free(&gc);
+}
+
 i=
nt
 main(void)
 {
@@ -271,6 +475,16 @@
         cmocka_unit_test(test_probe=
_parameter_too_short),
         cmocka_unit_test(test_find_tlv_value_trunca=
ted),
         cmocka_unit_test(test_tlv_header_truncated),
+        cmocka=
_unit_test(test_server_probe_read_finds_parameter),
+        cmocka_unit_te=
st(test_server_probe_read_skips_unknown),
+        cmocka_unit_test(test_se=
rver_probe_read_rejects_unknown_mandatory),
+        cmocka_unit_test(test_=
server_probe_read_missing),
+        cmocka_unit_test(test_server_probe_rea=
d_truncated),
+        cmocka_unit_test(test_server_probe_read_wrong_msg_ty=
pe),
+        cmocka_unit_test(test_timestamp_in_window),
+        cmocka_u=
nit_test(test_build_probe_reply_valid),
+        cmocka_unit_test(test_buil=
d_probe_reply_stale),
+        cmocka_unit_test(test_build_probe_reply_no_p=
arameter),
     };
 
     return cmocka_run_group_tests_name("oob tests", t=
ests, NULL, NULL);

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1742?usp=3Demail
To unsubscribe, or for help writing mail filters, vi=
sit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType:=
 newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id=
: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30
Gerrit-Change-Number: 1742
Gerr=
it-PatchSet: 12
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer=
: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourc=
eforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Attention: flichtenheld <frank@lichtenheld=2Ecom>

--hgu0UK0ISq0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>stipa <strong>uplo=
aded patch set #12</strong> to this change=2E</p><p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail">View Change</a></p><pre cla=
ss=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">oob: Add SERVER_PROBE parsing and the probe-reply decision<br><br>Add=
 the message-level helpers the server needs to answer a probe:<br><br>  - o=
ob_server_probe_write() writes a SERVER_PROBE (message-type header +<br>   =
 probe_parameter TLV); the client uses it later=2E<br>  - oob_server_probe_=
read() scans the TLV payload of a received OOB<br>    SERVER_PROBE for the =
probe_parameter TLV, skipping other/future TLV<br>    types that are marked=
 optional, and rejecting malformed or truncated<br>    input as well as a m=
andatory TLV it does not understand=2E<br>  - oob_timestamp_in_window() per=
forms the cheap replay/skew check on the<br>    probe timestamp described i=
n the wire protocol specification=2E<br>  - oob_build_probe_reply() compose=
s the two: given a received SERVER_PROBE<br>    it scans for the probe_para=
meter, drops the probe if it is missing or<br>    its timestamp is outside =
the acceptable window, and otherwise populates<br>    the probe_reply (echo=
ing the peer&#39;s session id) to send back=2E<br><br>A probe whose timesta=
mp falls outside the window is dropped without a reply,<br>which is what th=
e spec allows: the timestamp is there so a server may silently<br>drop requ=
ests outside an acceptable window and reduce the replay attack surface=2E<b=
r>The window itself is the caller&#39;s choice; the server path passes --ha=
nd-window in<br>a follow-up=2E<br><br>These are pure functions exercised by=
 unit tests; the server packet path<br>calls oob_build_probe_reply() in a f=
ollow-up, which performs the actual send=2E<br><br>Change-Id: Iafa9efc1c156=
974ad9f5752e9de810a8c2f68c30<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=
=2Enet&gt;<br>---<br>M src/openvpn/oob=2Ec<br>M src/openvpn/oob=2Eh<br>M te=
sts/unit_tests/openvpn/test_oob=2Ec<br>3 files changed, 319 insertions(+), =
0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/42/1742/12</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openv=
pn/oob=2Ec b/src/openvpn/oob=2Ec</span><br><span>index c807171=2E=2E930b213=
 100644</span><br><span>--- a/src/openvpn/oob=2Ec</span><br><span>+++ b/src=
/openvpn/oob=2Ec</span><br><span>@@ -81,3 +81,54 @@</span><br><span>     r-=
&gt;flags =3D buf_read_u32(buf, NULL);</span><br><span>     return true;</s=
pan><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+oob_server_probe_write(struct buffer =
*buf, const struct oob_probe_parameter *param)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    return buf_write_u16(buf, OOB_MSG_SERVER_PROBE) &amp;&amp; oob=
_probe_parameter_write(buf, param);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+oob_server_probe_read(struct buffer =
*payload, struct oob_probe_parameter *param)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (!ctrl_msg_read_header(payload, OOB_MSG_SERVER_PROBE))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct buffer value;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (!ctrl_msg_find_tlv(payload, OOB_TLV_PROBE_PARAMETER, &amp;=
value))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    return oob_probe_parameter_read(&amp;value, param);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+oob_timestamp_in_window(uint64_t probe_ts, uint64_t now, uint64_t window_=
secs)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    uint64_t diff =3D (now &gt; =
probe_ts) ? (now - probe_ts) : (probe_ts - now);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return diff &lt;=3D window_secs;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_bu=
ild_probe_reply(struct buffer *probe_payload, uint64_t now, uint64_t window=
_secs,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
         const struct session_id *peer_sid, struct oob_probe_reply *reply)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_parameter param;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!oob_server_=
probe_read(probe_payload, &amp;param))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        return false;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Drop replayed or im=
plausibly-timed probes before doing any more work=2E */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (!oob_timestamp_in_window(param=
=2Etimestamp, now, window_secs))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* the caller&#39;s advertis=
ed values are kept; only the echo is ours to fill */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    reply-&gt;peer_session_id =3D *peer_s=
id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>d=
iff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh</span><br><span>index=
 0a9a4bb=2E=2E1afabbd 100644</span><br><span>--- a/src/openvpn/oob=2Eh</spa=
n><br><span>+++ b/src/openvpn/oob=2Eh</span><br><span>@@ -107,4 +107,58 @@<=
/span><br><span>  */</span><br><span> bool oob_probe_reply_read(struct buff=
er *buf, struct oob_probe_reply *r);</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * Write a complete SERVER_PROBE message (message-type h=
eader + probe_parameter</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * TLV) to buf=2E Sent by the client=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+bool oob_server_probe_write(struct buffer *buf, const struct oob_pr=
obe_parameter *param);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * Read a received OOB SERVER_PR=
OBE: verify its message-type header, then scan</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * for the probe_parameter TLV=2E TLV types othe=
r than probe_parameter are</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * skipped=2E payload is consumed as it is read=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param payload  buffer positioned at the start of t=
he OOB message payload</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @param param    filled with the parsed probe_parameter on success</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return true if the =
header matched and a well-formed probe_parameter was</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *         found, false otherwise</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool oob_server_probe_read(struct buffer =
*payload, struct oob_probe_parameter *param);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Check =
whether a probe timestamp is within an acceptable window around the</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * current time=2E Used to =
cheaply drop replayed or implausibly-timed probes</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * before doing any further work (see the pro=
be_parameter timestamp rationale</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * in the wire protocol specification)=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @param probe_ts     timestamp from the probe_parameter=
 (UNIX seconds)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
param now          current time (UNIX seconds)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @param window_secs  maximum allowed differenc=
e, in either direction</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @return true if |now - probe_ts| &lt;=3D window_secs</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+bool oob_timestamp_in_window(uint64_t probe_ts, uint=
64_t now, uint64_t window_secs);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Process the TLV pay=
load of a received SERVER_PROBE and decide whether to</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * answer it=2E Combines oob_server_probe=
_read() and oob_timestamp_in_window():</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * the probe is dropped (false returned) if it has no va=
lid probe_parameter or</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * its timestamp is outside the acceptable window=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * reply carries the values the server advertises (prior=
ity, weight,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * max_=
latency_diff, connect_lifetime, flags) in, and is deliberately not</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * cleared: on success only =
the peer&#39;s session id is filled in, leaving the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * reply ready to be wrapped and sent=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * This is the transport-agnostic dec=
ision step; the caller performs the send=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * @param probe_payload  TLV payload of the received OOB SERVER_PROB=
E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param now     =
       current time (UNIX seconds)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * @param window_secs    acceptable timestamp skew, in eithe=
r direction</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @para=
m peer_sid       session id of the requesting peer (echoed in the reply)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param reply       =
   in: the values to advertise; out: the reply to send</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @return true if a reply should be sen=
t, false to silently drop the probe</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
bool oob_build_probe_reply(struct buffer *probe_payload, uint64_t now, uint=
64_t window_secs,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                         const struct session_id *peer_sid, struct oob_prob=
e_reply *reply);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span> #endif /* OOB_H */</span><br><span>diff --git a/tests/unit_t=
ests/openvpn/test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec</span><br=
><span>index aa4eb23=2E=2E3b29b52 100644</span><br><span>--- a/tests/unit_t=
ests/openvpn/test_oob=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/te=
st_oob=2Ec</span><br><span>@@ -259,6 +259,210 @@</span><br><span>     gc_fr=
ee(&amp;gc);</span><br><span> }</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/* A SERVER_PROBE carrying just a probe_param=
eter is found by the scan=2E */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+test_server_probe_read_finds_parameter(void **state)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(=
128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct oob_pro=
be_parameter in =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        =2Etimestamp =3D 0x1122334455667788ULL,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        =2Eflags =3D 0,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_true(oob_server_probe_write(&amp;buf, &amp;=
in));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_parameter ou=
t =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_true(oob_server_probe_read(&amp;buf, &amp;out));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(in=2Etimestamp =3D=3D out=
=2Etimestamp);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_int_equal(in=2Eflags, out=2Eflags);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/* TLVs other than probe_paramet=
er are skipped, so the scan finds the</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * probe_parameter even when preceded by an unknown TLV=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_server_probe_rea=
d_skips_unknown(void **state)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* SERVER_PROBE message header, then an unknown=
 but optional TLV (type</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * 0x7ff) =2E=2E=2E */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_true(buf_write_u16(&amp;buf, OOB_MSG_SERVER_PROBE));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl=
_msg_tlv_write_header(&amp;buf, 0x7ff, true, 4));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;buf, 0xcaf=
ef00d));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =2E=
=2E=2E followed by the real probe_parameter */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    const struct oob_probe_parameter in =3D { =
=2Etimestamp =3D 42, =2Eflags =3D 0 };</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_true(oob_probe_parameter_write(&amp;buf, &amp=
;in));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_parameter o=
ut =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_true(oob_server_probe_read(&amp;buf, &amp;out));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(out=2Etimestamp =3D=3D 42=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/* An unknown TLV that is NOT marked optional carries something the sen=
der</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * requires us t=
o act on: the whole message is rejected, whether that TLV comes</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * before or after the one we w=
ere looking for=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_s=
erver_probe_read_rejects_unknown_mandatory(void **state)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const struct oob_probe_parameter in=
 =3D { =2Etimestamp =3D 42, =2Eflags =3D 0 };</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct buffer before =3D alloc_buf_gc(128, &amp;gc);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u16(&=
amp;before, OOB_MSG_SERVER_PROBE));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;before, 0x7f=
f, false, 4));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_true(buf_write_u32(&amp;before, 0xcafef00d));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_probe_parameter_write=
(&amp;before, &amp;in));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buf=
fer after =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_true(buf_write_u16(&amp;after, OOB_MSG_SER=
VER_PROBE));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_true(oob_probe_parameter_write(&amp;after, &amp;in));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_he=
ader(&amp;after, 0x7ff, false, 4));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_true(buf_write_u32(&amp;after, 0xcafef00d));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_parameter out =3D { =
0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_fals=
e(oob_server_probe_read(&amp;before, &amp;out));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_false(oob_server_probe_read(&amp;af=
ter, &amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/* A payload with no probe_parameter must be rejected=2E =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+test_server_probe_read_mi=
ssing(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_aren=
a gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_true(buf_write_u16(&amp;buf, OOB_MSG_SERVER_PROBE=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(=
ctrl_msg_tlv_write_header(&amp;buf, 0x7ff, true, 4));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;buf, 0=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_parameter out =
=3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_false(oob_server_probe_read(&amp;buf, &amp;out));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A TLV whose decla=
red length runs past the buffer must be rejected, not</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * read out of bounds=2E */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+test_server_probe_read_truncated(void **s=
tate)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_ne=
w();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buff=
er buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* TLV header claims a 16-byte value but no value bytes follow */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write=
_u16(&amp;buf, OOB_MSG_SERVER_PROBE));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;buf, 0x7f=
f, false, 16));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_pa=
rameter out =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_false(oob_server_probe_read(&amp;buf, &amp;out));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A SERVE=
R_PROBE reader rejects a payload carrying a different message type</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * (here a PROBE_REPLY&#39;s=
), even if it contains a valid probe_parameter TLV=2E */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+test_server_probe_read_wrong_msg_type(void **s=
tate)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_ne=
w();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buff=
er buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_true(buf_write_u16(&amp;buf, OOB_MSG_PROBE_REPLY));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    const struct oob_probe_param=
eter in =3D { =2Etimestamp =3D 42, =2Eflags =3D 0 };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_probe_parameter_write=
(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_pr=
obe_parameter out =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_false(oob_server_probe_read(&amp;buf, &amp;out));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* =
Timestamp window check accepts values within the window (either direction)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * and rejects value=
s outside it=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_time=
stamp_in_window(void **state)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cons=
t uint64_t now =3D 1000000;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    const uint64_t window =3D 30;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_true(oob_timestamp_in_window(now, now, window));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_timestamp_in=
_window(now - window, now, window));      /* boundary, past */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_timestamp_in=
_window(now + window, now, window));      /* boundary, future */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(oob_timestamp=
_in_window(now - window - 1, now, window)); /* too old */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_false(oob_timestamp_in_win=
dow(now + window + 1, now, window)); /* too far ahead */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/* A valid, in-window SERVER_PROBE yields a reply that echoes the peer&#39;=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * session id and =
zeroes the remaining fields=2E */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+test_build_probe_reply_valid(void **state)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &am=
p;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    const uint64_t now =3D 10000=
00;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct=
 oob_probe_parameter probe =3D { =2Etimestamp =3D now, =2Eflags =3D 0 };</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_se=
rver_probe_write(&amp;buf, &amp;probe));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct session_id peer;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    memcpy(peer=2Eid, &quot;PEER1234&quot;, SID_SIZE);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* left as the caller set them: the function =
only fills the session id */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct oob_probe_reply reply =3D { 0 };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_build_probe_reply(&am=
p;buf, now, 30, &amp;peer, &amp;reply));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_memory_equal(reply=2Epeer_session_id=2Eid, =
peer=2Eid, SID_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_int_equal(reply=2Epriority, 0);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_int_equal(reply=2Eweight, 0);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(reply=2E=
connect_lifetime, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_int_equal(reply=2Eflags, 0);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/* A probe whose timestamp is ou=
tside the window is dropped (no reply)=2E */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+test_build_probe_reply_stale(void **state)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_=
gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint64_t no=
w =3D 1000000;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onst struct oob_probe_parameter probe =3D { =2Etimestamp =3D now - 1000, =
=2Eflags =3D 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_true(oob_server_probe_write(&amp;buf, &amp;probe));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct session_id peer =3D { 0 };</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_reply reply =
=3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_false(oob_build_probe_reply(&amp;buf, now, 30, &amp;peer, &amp;reply));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/* A payload without a probe_parameter is dropped (no reply)=2E */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+test_build_probe_reply_no_parameter(=
void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =
=3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_true(buf_write_u16(&amp;buf, OOB_MSG_SERVER_PROBE));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_m=
sg_tlv_write_header(&amp;buf, 0x7ff, true, 4));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;buf, 0));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct session_id peer =3D { 0 };</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_re=
ply reply =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_false(oob_build_probe_reply(&amp;buf, 1000000, 30, &amp;peer, &=
amp;reply));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><span> ma=
in(void)</span><br><span> {</span><br><span>@@ -271,6 +475,16 @@</span><br>=
<span>         cmocka_unit_test(test_probe_parameter_too_short),</span><br>=
<span>         cmocka_unit_test(test_find_tlv_value_truncated),</span><br><=
span>         cmocka_unit_test(test_tlv_header_truncated),</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_server=
_probe_read_finds_parameter),</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        cmocka_unit_test(test_server_probe_read_skips_unknown),</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_t=
est(test_server_probe_read_rejects_unknown_mandatory),</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_server_pro=
be_read_missing),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      cmocka_unit_test(test_server_probe_read_truncated),</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_server_=
probe_read_wrong_msg_type),</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        cmocka_unit_test(test_timestamp_in_window),</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_build=
_probe_reply_valid),</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        cmocka_unit_test(test_build_probe_reply_stale),</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_build_pr=
obe_reply_no_parameter),</span><br><span>     };</span><br><span> </span><b=
r><span>     return cmocka_run_group_tests_name(&quot;oob tests&quot;, test=
s, NULL, NULL);</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail">change 1742=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
afa9efc1c156974ad9f5752e9de810a8c2f68c30 </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1742 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 12 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstip=
akov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: f=
lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; <=
/div>

</body></html>
--hgu0UK0ISq0=--


--===============0566951941435169539==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0566951941435169539==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0566951941435169539==--

