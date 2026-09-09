Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A5EC79FBD
	for <openvpn-devel@archiver.kernel.org>; Wed,  9 Sep 2026 07:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=02j2+pKO08OcHHbTs0OPtAX1lHC63vrb96O664caEac=; b=FFeRYaWbacqchv6hmrO4XBhEtk
	NSfHj53Cbn8yPLI4MF+LXLz+EPj0lXdpoHX2LIyviXzlcZN/bXnOCT10XB2cnML4EqCQwRy09bXUF
	PXcw3A+F3fzboRGmRQw2hjwhHmw1J1tDjW7q+X0Y+P262TFLfWmw6lC87L3+Uxh27nhg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4Cie-0007ao-Pz;
	Wed, 09 Sep 2026 07:27:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4CiI-0007aP-VB
 for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 07:27:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=uCWQsKknV93+Jy7mHyfdXSqyIamKTX6wX2rzt/o69pE=; b=h92TuskkifdR72Ist5BWHL9vZX
 tKF10dCt0Cz42ronmYzwObE9gtykNnT6nmBkvfBBX84TNOpltN6HK7h+BpK5o8Ke4QfGLuFDcIIQr
 G6NwPg4BzRqjXfdsvRlQrpJ1yS6QeXCaNVCT+qx2QMWhZVgJGlZJcyZL49kgCADMduuQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=uCWQsKknV93+Jy7mHyfdXSqyIamKTX6wX2rzt/o69pE=; b=j
 +PjjvrCO4dQ74ulmluQlVEji5FXcFg2qBiLCiUyKUrwvB/4By5qW0mpw9v7QVMdQ4vrlCgLKpW+zw
 PHzh0mpRHF3JJwNdzWwoinXdC8SKdqMWvV+SKKZigY8J92UzIVsCjjgSRtMc6vb/WzB6KtSH8yoeS
 e5gx+AiozrgB3zxs=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4CiD-0008OB-EZ for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 07:27:20 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-48441a2ba14so4607700f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 09 Sep 2026 00:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788938831; x=1789543631; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uCWQsKknV93+Jy7mHyfdXSqyIamKTX6wX2rzt/o69pE=;
 b=QTg4sc/4wbpFcUN6ZqKH8YIOKa9Qtk8cxAxhHACUohZREyWVeXC4TuK49d8fm2WklR
 KVHsuFRMka1wMuM2QsJQXGdj+E9njs2kziVT8UzP1glgkyPZdHurQfl6thuW9YHTdply
 sJH4+CxQuP07vhxfhUnr5BmZxEQvP4bNLzDSVh33t7fbgoQM5bVWXD0Mp0Eb39EGPDHT
 YucL4KDxUyi8kOPcL8if/G9d6vNjmUilBiU8WBKg4xItLt4yINcNv4Un8z/YcKrz7veT
 QB1+LkzoH/MPFgnMyfbC+jk5IrhMSYGz2bFEvdZ4stGlKCoQC2C/pXLAfFZobvESkWkJ
 NYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788938831; x=1789543631;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=uCWQsKknV93+Jy7mHyfdXSqyIamKTX6wX2rzt/o69pE=;
 b=LoSmEBvDXspwC/+GKLckclCJJBuNElUWzdRc7viZgRP4ZoUNfzqfWk7z8auslaZN9S
 +Mkr3Gpo/BV64gKxaMH567JK1xTOex/qr1dQ7DS9k4EKEhT3Z9uVdUByJWjVGOApqMJY
 CQSGbj2P0tmroi3wt0iMh922Q108pCWjdKCALA71XOoIzY4Yn3hUt9uaXhUsLRfMSvgb
 xSfixUiHS+kUzBhTGjT0HPNkXY1htr6I0XgmBcxzkpbKFY+OV0CCJdba1AphFkyIJ3us
 76BR7sVckwtjqTq7lDpYPTaf7YP9BfEFNZ5VzeylWIrwi8nAmlb5ImpRsJHzjR77vMyl
 Uoeg==
X-Gm-Message-State: AFuF++n+uRMKFiE+oiz0s1+gfAC6AJCBzrcrOXzibRbnD8cciC1RBNqC
 ayVgNSUVF4B58WRMcc+HY2+ML0hDRB4BfxXpTfVyFALt9oXet0k/lHabIU7G8BM1PajSKCZgUR4
 BorjEo2lQ7dZ1BpY3ef9h50GYT1p5D1aI5nFhLfk7my+CaOIHvIMWeHMN5d4aZfeoIuxebv7lok
 INrjs0kQ==
X-Gm-Gg: AYBFou15F1BRVRKKquZlXsj9C0X2f7aMnvv8eywJatZO8qjZJgResLxc5MkrRgnnxUg
 2M/zSFWs8qMsy1jNpYCv5Ij1IlECu4H9mV6gzMf8e5cRrWkKOeacfT4tCdh2ZNQXqcpyH5hiH+j
 AQpFd4fKvkaAg0lixCPG0F0PFxA/iDQ2aUlC7T4ja3KqIMx6Cjcy+s5cSxIjm4IabTkDBB7iJOB
 G7oMlWImd6YP8r5zky/Ha5CM406J2V6/akawCZu/I7PAORFA0S+QHsgQZMTNeSPPUxKBfp3jzkL
 R82SpRV4d5cXtTvWee8ur32ink6jFfm7S/uctQpv5b90cFadQ3qAGGp24IgFiO2zKjxM9GvIVkH
 OZG9rff/gnXIWbaYCkK2eGjz8Pfw4wGXeQp8M1vMbt5gfaeWous5lq5t7j5fYVXWPpBuZXzYzFp
 JPCN32EuOT1oXp74kcvr6vFhbOpT1Q8Wwzc/rD3chByeg4a+Q5/0eUWxK2J21hEMUsRIhU3pR5C
 a+LR8V4VZOL6Kx+jpVjDsN75pyhU+IZ8yiaXtB37n+/9ml9RtJWAlSfWRZ1laYNjLRmPoYkHOeN
 oUER0BJoL/rvE/S3WSl0z1DdXmCBJGDA5MJ+LJ4So8Bv4yr97J/mAgJZQXBq5g==
X-Received: by 2002:a05:6000:4304:b0:484:3310:f395 with SMTP id
 ffacd0b85a97d-485872d2dbamr37140656f8f.24.1788938830562; 
 Wed, 09 Sep 2026 00:27:10 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485958f1493sm30497956f8f.37.2026.09.09.00.27.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 00:27:10 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 9 Sep 2026 07:27:02 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>,
 ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 13
X-Gerrit-Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30
X-Gerrit-Change-Number: 1742
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1742?usp=email>
X-Gerrit-Commit: 8cf9b7955aa320f7fb32dd205689c8c577bf4b43
In-Reply-To: <gerrit.1782719911000.Iafa9efc1c156974ad9f5752e9de810a8c2f68c30@gerrit.openvpn.net>
References: <gerrit.1782719911000.Iafa9efc1c156974ad9f5752e9de810a8c2f68c30@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklhZmE5ZWZjMWMxNTY5NzRhZDlmNTc1MmU5ZGU4MTBhOGMyZjY4YzMwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c88324257af000bd4b8ce922173430559cc2e9cf-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4CiD-0008OB-EZ
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
Content-Type: multipart/mixed; boundary="===============3252855818588947115=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3252855818588947115==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wG2nssRpBw0="; charset=UTF-8

--wG2nssRpBw0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, ralf_lici, s=
tipa=2E

Hello flichtenheld, plaisthos, ralf_lici, 

I'd like you to reexam=
ine a change=2E Please visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1742?usp=3Demail

to look at the new patch set (#13)=2E

The following app=
rovals got outdated and were removed:
Code-Review-1 by ralf_lici


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
ER_PROBE (message-type header +
    probe_parameter TLV); the client uses i=
t later=2E
  - oob_server_probe_read() scans the TLV payload of a received =
OOB
    SERVER_PROBE for the probe_parameter TLV, skipping other/future TLV=

    types that are marked optional, and rejecting malformed or truncated
 =
   input as well as a mandatory TLV it does not understand=2E
  - oob_times=
tamp_in_window() performs the cheap replay/skew check on the
    probe time=
stamp described in the wire protocol specification=2E
  - oob_server_probe_=
accept() combines the two: given a received SERVER_PROBE
    it scans for t=
he probe_parameter and accepts the probe unless that is
    missing or its =
timestamp is outside the acceptable window=2E It reads the
    probe and no=
thing else; the reply is the caller's to build=2E

A probe whose timestamp =
falls outside the window is dropped without a reply,
which is what the spec=
 allows: the timestamp is there so a server may silently
drop requests outs=
ide an acceptable window and reduce the replay attack surface=2E
The window=
 itself is the caller's choice; the server path passes --hand-window in
a f=
ollow-up=2E

These are pure functions exercised by unit tests; the server p=
acket path
calls oob_server_probe_accept() in a follow-up, which builds and=
 sends the
reply=2E

Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30
S=
igned-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M src/openvpn/oob=2Ec
M =
src/openvpn/oob=2Eh
M tests/unit_tests/openvpn/test_oob=2Ec
3 files changed=
, 288 insertions(+), 0 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/42/1742/13

diff --git a/src/openvpn/oob=2Ec =
b/src/openvpn/oob=2Ec
index c807171=2E=2Ec8c7346 100644
--- a/src/openvpn/o=
ob=2Ec
+++ b/src/openvpn/oob=2Ec
@@ -81,3 +81,46 @@
     r->flags =3D buf_r=
ead_u32(buf, NULL);
     return true;
 }
+
+bool
+oob_server_probe_write(st=
ruct buffer *buf, const struct oob_probe_parameter *param)
+{
+    return b=
uf_write_u16(buf, OOB_MSG_SERVER_PROBE) && oob_probe_parameter_write(buf, p=
aram);
+}
+
+bool
+oob_server_probe_read(struct buffer *payload, struct oob=
_probe_parameter *param)
+{
+    if (!ctrl_msg_read_header(payload, OOB_MSG=
_SERVER_PROBE))
+    {
+        return false;
+    }
+
+    struct buffer v=
alue;
+    if (!ctrl_msg_find_tlv(payload, OOB_TLV_PROBE_PARAMETER, &value)=
)
+    {
+        return false;
+    }
+
+    return oob_probe_parameter_re=
ad(&value, param);
+}
+
+bool
+oob_timestamp_in_window(uint64_t probe_ts, u=
int64_t now, uint64_t window_secs)
+{
+    uint64_t diff =3D (now > probe_t=
s) ? (now - probe_ts) : (probe_ts - now);
+    return diff <=3D window_secs=
;
+}
+
+bool
+oob_server_probe_accept(struct buffer *probe_payload, uint64_=
t now, uint64_t window_secs)
+{
+    struct oob_probe_parameter param;
+   =
 if (!oob_server_probe_read(probe_payload, &param))
+    {
+        return =
false;
+    }
+
+    /* Drop replayed or implausibly-timed probes before do=
ing any more work=2E */
+    return oob_timestamp_in_window(param=2Etimesta=
mp, now, window_secs);
+}
diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oo=
b=2Eh
index c5396b3=2E=2E8c091fc 100644
--- a/src/openvpn/oob=2Eh
+++ b/src=
/openvpn/oob=2Eh
@@ -107,4 +107,50 @@
  */
 bool oob_probe_reply_read(struc=
t buffer *buf, struct oob_probe_reply *r);
 
+/**
+ * Write a complete SERV=
ER_PROBE message (message-type header + probe_parameter
+ * TLV) to buf=2E =
Sent by the client=2E
+ */
+bool oob_server_probe_write(struct buffer *buf,=
 const struct oob_probe_parameter *param);
+
+/**
+ * Read a received OOB S=
ERVER_PROBE: verify its message-type header, then scan
+ * for the probe_pa=
rameter TLV=2E Unknown TLV types marked optional are skipped;
+ * an unknow=
n mandatory one rejects the probe=2E payload is consumed as it is
+ * read=
=2E
+ *
+ * @param payload  buffer positioned at the start of the OOB messa=
ge payload
+ * @param param    filled with the parsed probe_parameter on su=
ccess
+ * @return true if the header matched and a well-formed probe_parame=
ter was
+ *         found, false otherwise
+ */
+bool oob_server_probe_read=
(struct buffer *payload, struct oob_probe_parameter *param);
+
+/**
+ * Che=
ck whether a probe timestamp is within an acceptable window around the
+ * =
current time=2E Used to cheaply drop replayed or implausibly-timed probes
+=
 * before doing any further work (see the probe_parameter timestamp rationa=
le
+ * in the wire protocol specification)=2E
+ *
+ * @param probe_ts     t=
imestamp from the probe_parameter (UNIX seconds)
+ * @param now          cu=
rrent time (UNIX seconds)
+ * @param window_secs  maximum allowed differenc=
e, in either direction
+ * @return true if |now - probe_ts| <=3D window_sec=
s
+ */
+bool oob_timestamp_in_window(uint64_t probe_ts, uint64_t now, uint6=
4_t window_secs);
+
+/**
+ * Decide whether a received SERVER_PROBE is answ=
ered=2E Combines
+ * oob_server_probe_read() and oob_timestamp_in_window():=
 the probe is dropped
+ * if its payload has no valid probe_parameter or th=
e timestamp is outside the
+ * acceptable window=2E This is the transport-a=
gnostic decision step; the caller
+ * builds and sends the reply=2E
+ *
+ *=
 @param probe_payload  TLV payload of the received OOB SERVER_PROBE, consum=
ed
+ * @param now            current time (UNIX seconds)
+ * @param window_=
secs    acceptable timestamp skew, in either direction
+ * @return true if =
a reply should be sent, false to silently drop the probe
+ */
+bool oob_ser=
ver_probe_accept(struct buffer *probe_payload, uint64_t now, uint64_t windo=
w_secs);
+
 #endif /* OOB_H */
diff --git a/tests/unit_tests/openvpn/test_o=
ob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec
index 7664639=2E=2E1fdc5f8 1=
00644
--- a/tests/unit_tests/openvpn/test_oob=2Ec
+++ b/tests/unit_tests/op=
envpn/test_oob=2Ec
@@ -283,6 +283,195 @@
     gc_free(&gc);
 }
 
+/* A SERV=
ER_PROBE carrying just a probe_parameter is found by the scan=2E */
+static=
 void
+test_server_probe_read_finds_parameter(void **state)
+{
+    struct =
gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc)=
;
+
+    const struct oob_probe_parameter in =3D {
+        =2Etimestamp =
=3D 0x1122334455667788ULL,
+        =2Eflags =3D 0,
+    };
+    assert_tru=
e(oob_server_probe_write(&buf, &in));
+
+    struct oob_probe_parameter out=
 =3D { 0 };
+    assert_true(oob_server_probe_read(&buf, &out));
+    asser=
t_true(in=2Etimestamp =3D=3D out=2Etimestamp);
+    assert_int_equal(in=2Ef=
lags, out=2Eflags);
+
+    gc_free(&gc);
+}
+
+/* TLVs other than probe_par=
ameter are skipped, so the scan finds the
+ * probe_parameter even when pre=
ceded by an unknown TLV=2E */
+static void
+test_server_probe_read_skips_un=
known(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct bu=
ffer buf =3D alloc_buf_gc(128, &gc);
+
+    /* SERVER_PROBE message header,=
 then an unknown but optional TLV (type
+     * 0x7ff) =2E=2E=2E */
+    as=
sert_true(buf_write_u16(&buf, OOB_MSG_SERVER_PROBE));
+    assert_true(ctrl=
_msg_tlv_write_header(&buf, 0x7ff, true, 4));
+    assert_true(buf_write_u3=
2(&buf, 0xcafef00d));
+    /* =2E=2E=2E followed by the real probe_paramete=
r */
+    const struct oob_probe_parameter in =3D { =2Etimestamp =3D 42, =
=2Eflags =3D 0 };
+    assert_true(oob_probe_parameter_write(&buf, &in));
+=

+    struct oob_probe_parameter out =3D { 0 };
+    assert_true(oob_server=
_probe_read(&buf, &out));
+    assert_true(out=2Etimestamp =3D=3D 42);
+
+ =
   gc_free(&gc);
+}
+
+/* An unknown TLV that is NOT marked optional carrie=
s something the sender
+ * requires us to act on: the whole message is reje=
cted, whether that TLV comes
+ * before or after the one we were looking fo=
r=2E */
+static void
+test_server_probe_read_rejects_unknown_mandatory(void=
 **state)
+{
+    struct gc_arena gc =3D gc_new();
+    const struct oob_pr=
obe_parameter in =3D { =2Etimestamp =3D 42, =2Eflags =3D 0 };
+
+    struct=
 buffer before =3D alloc_buf_gc(128, &gc);
+    assert_true(buf_write_u16(&=
before, OOB_MSG_SERVER_PROBE));
+    assert_true(ctrl_msg_tlv_write_header(=
&before, 0x7ff, false, 4));
+    assert_true(buf_write_u32(&before, 0xcafef=
00d));
+    assert_true(oob_probe_parameter_write(&before, &in));
+
+    st=
ruct buffer after =3D alloc_buf_gc(128, &gc);
+    assert_true(buf_write_u1=
6(&after, OOB_MSG_SERVER_PROBE));
+    assert_true(oob_probe_parameter_writ=
e(&after, &in));
+    assert_true(ctrl_msg_tlv_write_header(&after, 0x7ff, =
false, 4));
+    assert_true(buf_write_u32(&after, 0xcafef00d));
+
+    str=
uct oob_probe_parameter out =3D { 0 };
+    assert_false(oob_server_probe_r=
ead(&before, &out));
+    assert_false(oob_server_probe_read(&after, &out))=
;
+
+    gc_free(&gc);
+}
+
+/* A payload with no probe_parameter must be r=
ejected=2E */
+static void
+test_server_probe_read_missing(void **state)
+{=

+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf=
_gc(128, &gc);
+
+    assert_true(buf_write_u16(&buf, OOB_MSG_SERVER_PROBE)=
);
+    assert_true(ctrl_msg_tlv_write_header(&buf, 0x7ff, true, 4));
+    =
assert_true(buf_write_u32(&buf, 0));
+
+    struct oob_probe_parameter out =
=3D { 0 };
+    assert_false(oob_server_probe_read(&buf, &out));
+
+    gc_=
free(&gc);
+}
+
+/* A TLV whose declared length runs past the buffer must b=
e rejected, not
+ * read out of bounds=2E */
+static void
+test_server_prob=
e_read_truncated(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+  =
  struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    /* TLV header claims=
 a 16-byte value but no value bytes follow */
+    assert_true(buf_write_u1=
6(&buf, OOB_MSG_SERVER_PROBE));
+    assert_true(ctrl_msg_tlv_write_header(=
&buf, 0x7ff, false, 16));
+
+    struct oob_probe_parameter out =3D { 0 };
=
+    assert_false(oob_server_probe_read(&buf, &out));
+
+    gc_free(&gc);
=
+}
+
+/* A SERVER_PROBE reader rejects a payload carrying a different messa=
ge type
+ * (here a PROBE_REPLY's), even if it contains a valid probe_param=
eter TLV=2E */
+static void
+test_server_probe_read_wrong_msg_type(void **s=
tate)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D a=
lloc_buf_gc(128, &gc);
+
+    assert_true(buf_write_u16(&buf, OOB_MSG_PROBE=
_REPLY));
+    const struct oob_probe_parameter in =3D { =2Etimestamp =3D 4=
2, =2Eflags =3D 0 };
+    assert_true(oob_probe_parameter_write(&buf, &in))=
;
+
+    struct oob_probe_parameter out =3D { 0 };
+    assert_false(oob_se=
rver_probe_read(&buf, &out));
+
+    gc_free(&gc);
+}
+
+/* Timestamp windo=
w check accepts values within the window (either direction)
+ * and rejects=
 values outside it=2E */
+static void
+test_timestamp_in_window(void **stat=
e)
+{
+    const uint64_t now =3D 1000000;
+    const uint64_t window =3D 3=
0;
+
+    assert_true(oob_timestamp_in_window(now, now, window));
+    asse=
rt_true(oob_timestamp_in_window(now - window, now, window));      /* bounda=
ry, past */
+    assert_true(oob_timestamp_in_window(now + window, now, win=
dow));      /* boundary, future */
+    assert_false(oob_timestamp_in_windo=
w(now - window - 1, now, window)); /* too old */
+    assert_false(oob_time=
stamp_in_window(now + window + 1, now, window)); /* too far ahead */
+}
+
+=
/* A well-formed probe with an in-window timestamp is accepted=2E */
+stati=
c void
+test_server_probe_accept_valid(void **state)
+{
+    struct gc_aren=
a gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+  =
  const uint64_t now =3D 1000000;
+    const struct oob_probe_parameter pro=
be =3D { =2Etimestamp =3D now, =2Eflags =3D 0 };
+    assert_true(oob_serve=
r_probe_write(&buf, &probe));
+
+    assert_true(oob_server_probe_accept(&b=
uf, now, 30));
+
+    gc_free(&gc);
+}
+
+/* A probe whose timestamp is out=
side the window is dropped (no reply)=2E */
+static void
+test_server_probe=
_accept_stale(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    s=
truct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    const uint64_t now =3D =
1000000;
+    const struct oob_probe_parameter probe =3D { =2Etimestamp =3D=
 now - 1000, =2Eflags =3D 0 };
+    assert_true(oob_server_probe_write(&buf=
, &probe));
+
+    assert_false(oob_server_probe_accept(&buf, now, 30));
+
=
+    gc_free(&gc);
+}
+
+/* A payload without a probe_parameter is dropped =
(no reply)=2E */
+static void
+test_server_probe_accept_no_parameter(void *=
*state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D=
 alloc_buf_gc(128, &gc);
+
+    assert_true(buf_write_u16(&buf, OOB_MSG_SER=
VER_PROBE));
+    assert_true(ctrl_msg_tlv_write_header(&buf, 0x7ff, true, =
4));
+    assert_true(buf_write_u32(&buf, 0));
+
+    assert_false(oob_serv=
er_probe_accept(&buf, 1000000, 30));
+
+    gc_free(&gc);
+}
+
 int
 main(v=
oid)
 {
@@ -296,6 +485,16 @@
         cmocka_unit_test(test_find_tlv_value_=
truncated),
         cmocka_unit_test(test_find_tlv_trailing_bytes),
      =
   cmocka_unit_test(test_tlv_header_truncated),
+        cmocka_unit_test(t=
est_server_probe_read_finds_parameter),
+        cmocka_unit_test(test_serv=
er_probe_read_skips_unknown),
+        cmocka_unit_test(test_server_probe_r=
ead_rejects_unknown_mandatory),
+        cmocka_unit_test(test_server_probe=
_read_missing),
+        cmocka_unit_test(test_server_probe_read_truncated)=
,
+        cmocka_unit_test(test_server_probe_read_wrong_msg_type),
+      =
  cmocka_unit_test(test_timestamp_in_window),
+        cmocka_unit_test(tes=
t_server_probe_accept_valid),
+        cmocka_unit_test(test_server_probe_a=
ccept_stale),
+        cmocka_unit_test(test_server_probe_accept_no_paramet=
er),
     };
 
     return cmocka_run_group_tests_name("oob tests", tests, =
NULL, NULL);

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1742?usp=3Demail
To unsubscribe, or for help writing mail filters, visit ht=
tp://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpa=
tchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iafa=
9efc1c156974ad9f5752e9de810a8c2f68c30
Gerrit-Change-Number: 1742
Gerrit-Pat=
chSet: 13
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: flic=
htenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC=
: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention:=
 plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <fra=
nk@lichtenheld=2Ecom>
Gerrit-Attention: ralf_lici <ralf@mandelbit=2Ecom>
Ge=
rrit-Attention: stipa <lstipakov@gmail=2Ecom>

--wG2nssRpBw0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, ralf_lici, stipa=2E </p>
<p>=
stipa <strong>uploaded patch set #13</strong> to this change=2E</p><p><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Re=
view-1 by ralf_lici</p><pre class=3D"blocks" style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">oob: Add SERVER_PROBE parsing and the =
probe-reply decision<br><br>Add the message-level helpers the server needs =
to answer a probe:<br><br>  - oob_server_probe_write() writes a SERVER_PROB=
E (message-type header +<br>    probe_parameter TLV); the client uses it la=
ter=2E<br>  - oob_server_probe_read() scans the TLV payload of a received O=
OB<br>    SERVER_PROBE for the probe_parameter TLV, skipping other/future T=
LV<br>    types that are marked optional, and rejecting malformed or trunca=
ted<br>    input as well as a mandatory TLV it does not understand=2E<br>  =
- oob_timestamp_in_window() performs the cheap replay/skew check on the<br>=
    probe timestamp described in the wire protocol specification=2E<br>  - =
oob_server_probe_accept() combines the two: given a received SERVER_PROBE<b=
r>    it scans for the probe_parameter and accepts the probe unless that is=
<br>    missing or its timestamp is outside the acceptable window=2E It rea=
ds the<br>    probe and nothing else; the reply is the caller&#39;s to buil=
d=2E<br><br>A probe whose timestamp falls outside the window is dropped wit=
hout a reply,<br>which is what the spec allows: the timestamp is there so a=
 server may silently<br>drop requests outside an acceptable window and redu=
ce the replay attack surface=2E<br>The window itself is the caller&#39;s ch=
oice; the server path passes --hand-window in<br>a follow-up=2E<br><br>Thes=
e are pure functions exercised by unit tests; the server packet path<br>cal=
ls oob_server_probe_accept() in a follow-up, which builds and sends the<br>=
reply=2E<br><br>Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30<br>Sig=
ned-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M src/openvpn/=
oob=2Ec<br>M src/openvpn/oob=2Eh<br>M tests/unit_tests/openvpn/test_oob=2Ec=
<br>3 files changed, 288 insertions(+), 0 deletions(-)<br><br></pre><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/42/=
1742/13</pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;"><span>diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec</spa=
n><br><span>index c807171=2E=2Ec8c7346 100644</span><br><span>--- a/src/ope=
nvpn/oob=2Ec</span><br><span>+++ b/src/openvpn/oob=2Ec</span><br><span>@@ -=
81,3 +81,46 @@</span><br><span>     r-&gt;flags =3D buf_read_u32(buf, NULL)=
;</span><br><span>     return true;</span><br><span> }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+oob_server_probe_write(struct buffer *buf, const struct oob_probe_paramete=
r *param)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    return buf_write_u16(buf=
, OOB_MSG_SERVER_PROBE) &amp;&amp; oob_probe_parameter_write(buf, param);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+oob_server_probe_read(struct buffer *payload, struct oob_probe_parameter =
*param)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (!ctrl_msg_read_header(=
payload, OOB_MSG_SERVER_PROBE))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct buffer value;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (!ctrl_msg_find_tlv(p=
ayload, OOB_TLV_PROBE_PARAMETER, &amp;value))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        return false;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return oob_prob=
e_parameter_read(&amp;value, param);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+oob_timestamp_in_window(uint64_t pr=
obe_ts, uint64_t now, uint64_t window_secs)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    uint64_t diff =3D (now &gt; probe_ts) ? (now - probe_ts) : (probe=
_ts - now);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retu=
rn diff &lt;=3D window_secs;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+oob_server_probe_accept(struct buffer *pr=
obe_payload, uint64_t now, uint64_t window_secs)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct oob_probe_parameter param;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (!oob_server_probe_read(probe_payload, =
&amp;param))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* Drop replayed or implausibly-timed probes bef=
ore doing any more work=2E */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    return oob_timestamp_in_window(param=2Etimestamp, now, window=
_secs);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span>diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh</span><br><spa=
n>index c5396b3=2E=2E8c091fc 100644</span><br><span>--- a/src/openvpn/oob=
=2Eh</span><br><span>+++ b/src/openvpn/oob=2Eh</span><br><span>@@ -107,4 +1=
07,50 @@</span><br><span>  */</span><br><span> bool oob_probe_reply_read(st=
ruct buffer *buf, struct oob_probe_reply *r);</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * Write a complete SERVER_PROBE message (messa=
ge-type header + probe_parameter</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * TLV) to buf=2E Sent by the client=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+bool oob_server_probe_write(struct buffer *buf, const str=
uct oob_probe_parameter *param);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Read a received OOB=
 SERVER_PROBE: verify its message-type header, then scan</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * for the probe_parameter TLV=2E Unkn=
own TLV types marked optional are skipped;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * an unknown mandatory one rejects the probe=2E pay=
load is consumed as it is</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * read=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param payload  b=
uffer positioned at the start of the OOB message payload</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @param param    filled with the par=
sed probe_parameter on success</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @return true if the header matched and a well-formed probe_pa=
rameter was</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *      =
   found, false otherwise</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool oob_s=
erver_probe_read(struct buffer *payload, struct oob_probe_parameter *param)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * Check whether a probe timestamp is within an accep=
table window around the</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * current time=2E Used to cheaply drop replayed or implausibly-timed p=
robes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * before doin=
g any further work (see the probe_parameter timestamp rationale</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * in the wire protocol specifi=
cation)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param probe_ts     tim=
estamp from the probe_parameter (UNIX seconds)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @param now          current time (UNIX second=
s)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param window_=
secs  maximum allowed difference, in either direction</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @return true if |now - probe_ts| &lt;=
=3D window_secs</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool oob_timestamp_i=
n_window(uint64_t probe_ts, uint64_t now, uint64_t window_secs);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * Decide whether a received SERVER_PROBE is answered=2E Combines=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * oob_server_probe=
_read() and oob_timestamp_in_window(): the probe is dropped</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * if its payload has no valid prob=
e_parameter or the timestamp is outside the</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * acceptable window=2E This is the transport-agnos=
tic decision step; the caller</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * builds and sends the reply=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * @param probe_payload  TLV payload of the received OOB SERVER_PROBE=
, consumed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param=
 now            current time (UNIX seconds)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @param window_secs    acceptable timestamp skew,=
 in either direction</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * @return true if a reply should be sent, false to silently drop the prob=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+bool oob_server_probe_accept(struc=
t buffer *probe_payload, uint64_t now, uint64_t window_secs);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* OOB_H=
 */</span><br><span>diff --git a/tests/unit_tests/openvpn/test_oob=2Ec b/te=
sts/unit_tests/openvpn/test_oob=2Ec</span><br><span>index 7664639=2E=2E1fdc=
5f8 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_oob=2Ec</spa=
n><br><span>+++ b/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>@@ =
-283,6 +283,195 @@</span><br><span>     gc_free(&amp;gc);</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/* A SERVER_PROBE carrying just a probe_parameter is found by the scan=2E *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+test_server_probe_read_fin=
ds_parameter(void **state)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const struct oob_probe_parameter in =3D {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        =2Etimestamp =3D 0x1=
122334455667788ULL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        =2Eflags =3D 0,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_true(oob_server_probe_write(&amp;buf, &amp;in));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct oob_probe_parameter out =3D { 0 };</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_server_probe_read=
(&amp;buf, &amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_true(in=2Etimestamp =3D=3D out=2Etimestamp);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(in=2Eflags, out=
=2Eflags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/* TLVs other than probe_parameter are skipped, so the scan fin=
ds the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * probe_para=
meter even when preceded by an unknown TLV=2E */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+test_server_probe_read_skips_unknown(void **state)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =
=3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =
SERVER_PROBE message header, then an unknown but optional TLV (type</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     * 0x7ff) =2E=2E=2E */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_=
write_u16(&amp;buf, OOB_MSG_SERVER_PROBE));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;buf,=
 0x7ff, true, 4));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_true(buf_write_u32(&amp;buf, 0xcafef00d));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* =2E=2E=2E followed by the real pro=
be_parameter */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
const struct oob_probe_parameter in =3D { =2Etimestamp =3D 42, =2Eflags =3D=
 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tru=
e(oob_probe_parameter_write(&amp;buf, &amp;in));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct oob_probe_parameter out =3D { 0 };</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_server_probe_read(&=
amp;buf, &amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_true(out=2Etimestamp =3D=3D 42);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/* An unknown TLV that is NOT=
 marked optional carries something the sender</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * requires us to act on: the whole message is re=
jected, whether that TLV comes</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * before or after the one we were looking for=2E */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+test_server_probe_read_rejects_unknown_=
mandatory(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_=
arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    const struct oob_probe_parameter in =3D { =2Etimestamp =3D 42, =2Efl=
ags =3D 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer before =
=3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_true(buf_write_u16(&amp;before, OOB_MSG_SERVER_PROBE=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(=
ctrl_msg_tlv_write_header(&amp;before, 0x7ff, false, 4));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;be=
fore, 0xcafef00d));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_true(oob_probe_parameter_write(&amp;before, &amp;in));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct buffer after =3D alloc_buf_gc(128, &a=
mp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_t=
rue(buf_write_u16(&amp;after, OOB_MSG_SERVER_PROBE));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_probe_parameter_write=
(&amp;after, &amp;in));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_true(ctrl_msg_tlv_write_header(&amp;after, 0x7ff, false, 4))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(bu=
f_write_u32(&amp;after, 0xcafef00d));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct oob_probe_parameter out =3D { 0 };</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_false(oob_server_probe_read(&amp;before=
, &amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_false(oob_server_probe_read(&amp;after, &amp;out));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A payload with=
 no probe_parameter must be rejected=2E */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+test_server_probe_read_missing(void **state)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_=
gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_w=
rite_u16(&amp;buf, OOB_MSG_SERVER_PROBE));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;buf, =
0x7ff, true, 4));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_true(buf_write_u32(&amp;buf, 0));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct oob_probe_parameter out =3D { 0 };</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_false(oob_server_probe_read(&amp;b=
uf, &amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/* A TLV whose declared length runs past the buffer must b=
e rejected, not</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * r=
ead out of bounds=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test=
_server_probe_read_truncated(void **state)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* TLV header claims a 16-byte val=
ue but no value bytes follow */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_true(buf_write_u16(&amp;buf, OOB_MSG_SERVER_PROBE));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctr=
l_msg_tlv_write_header(&amp;buf, 0x7ff, false, 16));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct oob_probe_parameter out =3D { 0 };</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_false(oob_server_probe_=
read(&amp;buf, &amp;out));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(=
&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/* A SERVER_PROBE reader rejects a payload carr=
ying a different message type</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * (here a PROBE_REPLY&#39;s), even if it contains a valid probe_=
parameter TLV=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_ser=
ver_probe_read_wrong_msg_type(void **state)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u16(&amp;bu=
f, OOB_MSG_PROBE_REPLY));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    const struct oob_probe_parameter in =3D { =2Etimestamp =3D 42, =
=2Eflags =3D 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_true(oob_probe_parameter_write(&amp;buf, &amp;in));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct oob_probe_parameter out =3D { 0 };</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(oob_server=
_probe_read(&amp;buf, &amp;out));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    g=
c_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/* Timestamp window check accepts values=
 within the window (either direction)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * and rejects values outside it=2E */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+test_timestamp_in_window(void **state)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    const uint64_t now =3D 1000000;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    const uint64_t window =3D=
 30;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_timestamp_in_w=
indow(now, now, window));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_true(oob_timestamp_in_window(now - window, now, window)); =
     /* boundary, past */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_true(oob_timestamp_in_window(now + window, now, window)); =
     /* boundary, future */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_false(oob_timestamp_in_window(now - window - 1, now, win=
dow)); /* too old */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_false(oob_timestamp_in_window(now + window + 1, now, window)); =
/* too far ahead */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/* A well-formed probe with an in-win=
dow timestamp is accepted=2E */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+test_server_probe_accept_valid(void **state)</span><br><span style=3D"c=
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
>+    assert_true(oob_server_probe_accept(&amp;buf, now, 30));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A probe =
whose timestamp is outside the window is dropped (no reply)=2E */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+test_server_probe_accept_stale(void *=
*state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_=
new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct bu=
ffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    const uint64_t now =3D 1000000;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    const struct oob_probe_parameter probe =3D { =2Etimes=
tamp =3D now - 1000, =2Eflags =3D 0 };</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_true(oob_server_probe_write(&amp;buf, &amp;pr=
obe));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_false(oob_server_prob=
e_accept(&amp;buf, now, 30));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_fr=
ee(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/* A payload without a probe_parameter is dr=
opped (no reply)=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_=
server_probe_accept_no_parameter(void **state)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;=
gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u16(&amp=
;buf, OOB_MSG_SERVER_PROBE));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;buf, 0x7ff, true, =
4));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true=
(buf_write_u32(&amp;buf, 0));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_false(oob_server_probe_accept(&amp;buf, 1000000, 30));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span> int</span><br><span> main(void)</span><br><span> {</spa=
n><br><span>@@ -296,6 +485,16 @@</span><br><span>         cmocka_unit_test(=
test_find_tlv_value_truncated),</span><br><span>         cmocka_unit_test(t=
est_find_tlv_trailing_bytes),</span><br><span>         cmocka_unit_test(tes=
t_tlv_header_truncated),</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        cmocka_unit_test(test_server_probe_read_finds_parameter),</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test=
(test_server_probe_read_skips_unknown),</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        cmocka_unit_test(test_server_probe_read_rejects=
_unknown_mandatory),</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        cmocka_unit_test(test_server_probe_read_missing),</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_server=
_probe_read_truncated),</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        cmocka_unit_test(test_server_probe_read_wrong_msg_type),</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(t=
est_timestamp_in_window),</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        cmocka_unit_test(test_server_probe_accept_valid),</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_s=
erver_probe_accept_stale),</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        cmocka_unit_test(test_server_probe_accept_no_parameter),</sp=
an><br><span>     };</span><br><span> </span><br><span>     return cmocka_r=
un_group_tests_name(&quot;oob tests&quot;, tests, NULL, NULL);</span><br><s=
pan></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1742?usp=3Demail">change 1742</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Proje=
ct: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div=
>
<div style=3D"display:none"> Gerrit-Change-Id: Iafa9efc1c156974ad9f5752e9=
de810a8c2f68c30 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1=
742 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 13 </div>
<div sty=
le=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lic=
htenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: pla=
isthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esour=
ceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: pla=
isthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@mandelbit=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;=
lstipakov@gmail=2Ecom&gt; </div>

</body></html>
--wG2nssRpBw0=--


--===============3252855818588947115==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3252855818588947115==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3252855818588947115==--

