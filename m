Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53955C88E7D
	for <openvpn-devel@archiver.kernel.org>; Mon, 14 Sep 2026 14:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rR2N1hoWvSP6sLbc3XOsfYYfnqHj10NSGHQDwftqszM=; b=Gx0nrDuicT+2dm/Fyv4Je6Oa+F
	tWodbqh7QVKyjr6E1nU04nb2Ydg5LaZlU5eYxcz+Rccg3U7CMZal03vEjGr60T6hFXyoRk739vmwk
	TP8k8K9/GQdHsctqXkoKOU14LwGPIKbaFnLDmWEz1pgPCinvgk4dQrrgHRjiyp/cvGsw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x67WQ-0000FY-RQ;
	Mon, 14 Sep 2026 14:19:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x67WI-0000FA-R2
 for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 14:18:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=gcxii2fDAoK5aRO6W5SKVqxQ8rK2SNiw8pIiefFommI=; b=Imhxr+ij/UgPZuHNuITqvEcP9z
 S0yqlpcfx1rbOkumRTEuzg221Ou0dAq9etQu/x4qOPY7yxw89+f9tUE/lUOlYX40b92Txd1o13bad
 bd/RqfqyZyJzj6g+4u+f8qogl7DrRIeHTymeqyHVprUdtxUfxr6LzECxqfG+CRjcdRgk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=gcxii2fDAoK5aRO6W5SKVqxQ8rK2SNiw8pIiefFommI=; b=e
 eVsax+JR5iJNEbdNixi9R7+smp/UX4mOF6NJCHKMKZVX/IDqcGXBiDCwf/RVy/Nu4mypW4hot/dtC
 EH1SecY3qXbbKFEqoemTQj1hsI8hJbRrpX/JUu+9I39Ew3MrlBiOf3QdyWnqxIbGElzV5Wyp+u9zE
 1I5F5aDRT5qWolHA=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x67WD-0001Ro-Tv for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 14:18:52 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e71cdb22bso12106645e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 14 Sep 2026 07:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789395523; x=1790000323; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gcxii2fDAoK5aRO6W5SKVqxQ8rK2SNiw8pIiefFommI=;
 b=F45OFzRUoKTep6y90APQWrueknWfLbSYpkRUv8sFZ3pcCYXa+Cr7A++4pd4RXAJkew
 iGzUwDcIOLA2kHv3+I0rEXBuQIDLiiIov23stIDcJMz2VyuRNvSfn3DS+LB+gmdrCemW
 8Oe+GwMiDUooYmsxIJ4XL2tVY1tvl9Qg7xcjIwD508QXAA2ncohSQd0P+fOlSN3EgZf2
 X41gfK8LHA1nzxYXh3w/sz/QmSxhgG7qAPU0GdcrqvW8I8rTZQAvImvhd1UYmcUUHYAd
 0HFGntuWCDzLWFDz7O8LK/02RfIoKXFTsVpEXj6J8xuZscBsXIUcEh0LSRewbfumtjha
 mTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789395523; x=1790000323;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gcxii2fDAoK5aRO6W5SKVqxQ8rK2SNiw8pIiefFommI=;
 b=iWCFmFnPHYZrN0hjnv+licbIzOdUcvZyfqbtzvwVewAAHadu7XqsA3Z4GONOb39AOX
 GHnlkmxAfYChfp4hs/BP1w7BxcCvBYbAZw0fQ7MpeMqizKEa1o4YkfielQSgtQv3K94Y
 ljxkeiteF4xYbZELoqddXuaG3DpOZtA4tWlhQJAw36CQJuddLxaUUFgSyV0K8l5m9xRp
 K3+Z15eAyXmH4tiRzuW4oS+LBwdEXO/GA1Tyk717iobEESmE1euuBesVkxFMW/xTDu7Y
 50+dpInQhZvbrMFpNfuErLDEHxJ+az2dSO20y1oVJO4Gj2rxnGz70DtbBk4/mZOhugAg
 SA2w==
X-Gm-Message-State: AFuF++n3cfCsZ95hft0rljr5d4piO55L5H61ZHWIEBck5MNtLvykfgwO
 6tBhVnrvi8mXNAj+1P4VrE/5k7F3qWappalgea9srmReGc9B2t+cctqGMZ8cKOEtHHkXqT0oxSh
 gTPlDzkiTYww1RfiAFzec+hgJlPM4J4Wk5ZpPgP0B6PTn8UfrtXMkEJGIDCgCVXebLeh857n9oS
 g9g9jZjg==
X-Gm-Gg: AYBFou3nd7U7dFB4EL03MXouVcZegYnQ7Pp2vSIcDxrtNt6ruIaR8FCDp+2wdwsSx00
 pIbFSaMmuKadWL032kxjN5u5m7/CXTYXCVWKIs9BNs0MZ/MUBqLaFwBUsly6VT3Nxz3ytl4e7XM
 R58prnB2BkQPnWv4GHTNEtPDwNj2H5x7Ef33hwUxPNW3PycL1UQrgufsBKf9u/ePBNuinsP5Yxr
 X0uxMJmEEoq+E5AiKxNXleWaob4yX4zk4GahPKiN3FV5l82xjkCmzB+WMLz2O1K9ySOylXu1Yl8
 ewmzxc7THYLDiMCfG8SGXtXHOfIjpS6oXu4ez1VTqLLqz6OiLa/6AiBiaHyDmq2/fQc78rMH8PT
 wHnbfrCyA80jYQfAjSBppJZQIrdXHOEvcOWOBtap0RbIu6lJcEl0JuzFJrqKDTvRxBs/5094l25
 dcbwTr/ZFoATwgG0Pe7CE6ZQBi/NHIh5LUUd7fhcLqp4fsguV6Yci1PKi9N4+xVnhQ8992wrjqS
 tHs2To+caZwlkXr5HQcbdE7654bpltsy71oX5UINZBuCDwgmTtYt/lqMDQM3K4s18upBPNSDsmU
 hPFVwF/MmdG7p9WXxVt0Z1Jshoxl+NKeRQOXsZ5AfKAdLAfGMfFEsm8BBF4xOA==
X-Received: by 2002:a05:600c:a103:b0:49e:7d25:f397 with SMTP id
 5b1f17b1804b1-49e7d25f42emr3189715e9.15.1789395522846; 
 Mon, 14 Sep 2026 07:18:42 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e7d2acf1asm1448185e9.4.2026.09.14.07.18.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 07:18:42 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 14 Sep 2026 14:18:32 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>,
 ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 15
X-Gerrit-Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30
X-Gerrit-Change-Number: 1742
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1742?usp=email>
X-Gerrit-Commit: 59a6b578f3df7a070b2b213db4f5a1e75a4dc416
In-Reply-To: <gerrit.1782719911000.Iafa9efc1c156974ad9f5752e9de810a8c2f68c30@gerrit.openvpn.net>
References: <gerrit.1782719911000.Iafa9efc1c156974ad9f5752e9de810a8c2f68c30@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklhZmE5ZWZjMWMxNTY5NzRhZDlmNTc1MmU5ZGU4MTBhOGMyZjY4YzMwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <02ecc1cdfa90e4c79de45c11d0b7ea4743e587bd-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x67WD-0001Ro-Tv
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
Content-Type: multipart/mixed; boundary="===============6409618376288304265=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6409618376288304265==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XQy8ni+1jKI="; charset=UTF-8

--XQy8ni+1jKI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, ralf_lici, s=
tipa=2E

Hello flichtenheld, plaisthos, ralf_lici, 

I'd like you to reexam=
ine a change=2E Please visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1742?usp=3Demail

to look at the new patch set (#15)=2E


Change subject: =
oob: Add SERVER_PROBE parsing and the probe-reply decision
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Add SERVER_PROBE parsin=
g and the probe-reply decision

Add the message-level helpers the server needs to answer a probe:

  - oob_server_probe_write() writes a SERVER_PROBE (message-type header
    + probe_parameter TLV); the client uses it later=2E
  - oob_server_probe_read() scans the TLV payload of a received OOB
    SERVER_PROBE for the probe_parameter TLV, skipping other/future TLV
    types that are marked optional, and rejecting malformed or truncated
    input as well as a mandatory TLV it does not understand=2E
  - oob_timestamp_in_window() performs the cheap replay/skew check on
    the probe timestamp described in the wire protocol specification=2E
  - oob_server_probe_accept() combines the two: given a received
    SERVER_PROBE it scans for the probe_parameter and accepts the probe
    unless that is missing or its timestamp is outside the acceptable
    window=2E It reads the probe and nothing else; the reply is the
    caller's to build=2E

A probe whose timestamp falls outside the window is dropped without a
reply, which is what the spec allows: the timestamp is there so a server
may silently drop requests outside an acceptable window and reduce the
replay attack surface=2E The window itself is the caller's choice; the
server path passes --hand-window in a follow-up=2E

These are pure functions exercised by unit tests; the server packet path
calls oob_server_probe_accept() in a follow-up and builds and sends the
reply itself=2E

Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M src/openvpn/oob=2Ec
=
M src/openvpn/oob=2Eh
M tests/unit_tests/openvpn/test_oob=2Ec
3 files chang=
ed, 288 insertions(+), 0 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/42/1742/15

diff --git a/src/openvpn/oob=
=2Ec b/src/openvpn/oob=2Ec
index c807171=2E=2Ec8c7346 100644
--- a/src/open=
vpn/oob=2Ec
+++ b/src/openvpn/oob=2Ec
@@ -81,3 +81,46 @@
     r->flags =3D =
buf_read_u32(buf, NULL);
     return true;
 }
+
+bool
+oob_server_probe_wri=
te(struct buffer *buf, const struct oob_probe_parameter *param)
+{
+    ret=
urn buf_write_u16(buf, OOB_MSG_SERVER_PROBE) && oob_probe_parameter_write(b=
uf, param);
+}
+
+bool
+oob_server_probe_read(struct buffer *payload, struc=
t oob_probe_parameter *param)
+{
+    if (!ctrl_msg_read_header(payload, OO=
B_MSG_SERVER_PROBE))
+    {
+        return false;
+    }
+
+    struct buf=
fer value;
+    if (!ctrl_msg_find_tlv(payload, OOB_TLV_PROBE_PARAMETER, &v=
alue))
+    {
+        return false;
+    }
+
+    return oob_probe_paramet=
er_read(&value, param);
+}
+
+bool
+oob_timestamp_in_window(uint64_t probe_=
ts, uint64_t now, uint64_t window_secs)
+{
+    uint64_t diff =3D (now > pr=
obe_ts) ? (now - probe_ts) : (probe_ts - now);
+    return diff <=3D window=
_secs;
+}
+
+bool
+oob_server_probe_accept(struct buffer *probe_payload, ui=
nt64_t now, uint64_t window_secs)
+{
+    struct oob_probe_parameter param;=

+    if (!oob_server_probe_read(probe_payload, &param))
+    {
+        re=
turn false;
+    }
+
+    /* Drop replayed or implausibly-timed probes befo=
re doing any more work=2E */
+    return oob_timestamp_in_window(param=2Eti=
mestamp, now, window_secs);
+}
diff --git a/src/openvpn/oob=2Eh b/src/openv=
pn/oob=2Eh
index c5396b3=2E=2E8c091fc 100644
--- a/src/openvpn/oob=2Eh
+++ =
b/src/openvpn/oob=2Eh
@@ -107,4 +107,50 @@
  */
 bool oob_probe_reply_read(=
struct buffer *buf, struct oob_probe_reply *r);
 
+/**
+ * Write a complete=
 SERVER_PROBE message (message-type header + probe_parameter
+ * TLV) to bu=
f=2E Sent by the client=2E
+ */
+bool oob_server_probe_write(struct buffer =
*buf, const struct oob_probe_parameter *param);
+
+/**
+ * Read a received =
OOB SERVER_PROBE: verify its message-type header, then scan
+ * for the pro=
be_parameter TLV=2E Unknown TLV types marked optional are skipped;
+ * an u=
nknown mandatory one rejects the probe=2E payload is consumed as it is
+ * =
read=2E
+ *
+ * @param payload  buffer positioned at the start of the OOB m=
essage payload
+ * @param param    filled with the parsed probe_parameter o=
n success
+ * @return true if the header matched and a well-formed probe_pa=
rameter was
+ *         found, false otherwise
+ */
+bool oob_server_probe_=
read(struct buffer *payload, struct oob_probe_parameter *param);
+
+/**
+ *=
 Check whether a probe timestamp is within an acceptable window around the
=
+ * current time=2E Used to cheaply drop replayed or implausibly-timed prob=
es
+ * before doing any further work (see the probe_parameter timestamp rat=
ionale
+ * in the wire protocol specification)=2E
+ *
+ * @param probe_ts  =
   timestamp from the probe_parameter (UNIX seconds)
+ * @param now        =
  current time (UNIX seconds)
+ * @param window_secs  maximum allowed diffe=
rence, in either direction
+ * @return true if |now - probe_ts| <=3D window=
_secs
+ */
+bool oob_timestamp_in_window(uint64_t probe_ts, uint64_t now, u=
int64_t window_secs);
+
+/**
+ * Decide whether a received SERVER_PROBE is =
answered=2E Combines
+ * oob_server_probe_read() and oob_timestamp_in_windo=
w(): the probe is dropped
+ * if its payload has no valid probe_parameter o=
r the timestamp is outside the
+ * acceptable window=2E This is the transpo=
rt-agnostic decision step; the caller
+ * builds and sends the reply=2E
+ *=

+ * @param probe_payload  TLV payload of the received OOB SERVER_PROBE, co=
nsumed
+ * @param now            current time (UNIX seconds)
+ * @param win=
dow_secs    acceptable timestamp skew, in either direction
+ * @return true=
 if a reply should be sent, false to silently drop the probe
+ */
+bool oob=
_server_probe_accept(struct buffer *probe_payload, uint64_t now, uint64_t w=
indow_secs);
+
 #endif /* OOB_H */
diff --git a/tests/unit_tests/openvpn/te=
st_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec
index 70f529e0=2E=2E7254=
557 100644
--- a/tests/unit_tests/openvpn/test_oob=2Ec
+++ b/tests/unit_tes=
ts/openvpn/test_oob=2Ec
@@ -319,6 +319,195 @@
     gc_free(&gc);
 }
 
+/* A=
 SERVER_PROBE carrying just a probe_parameter is found by the scan=2E */
+s=
tatic void
+test_server_probe_read_finds_parameter(void **state)
+{
+    st=
ruct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128,=
 &gc);
+
+    const struct oob_probe_parameter in =3D {
+        =2Etimesta=
mp =3D 0x1122334455667788ULL,
+        =2Eflags =3D 0,
+    };
+    assert_=
true(oob_server_probe_write(&buf, &in));
+
+    struct oob_probe_parameter =
out =3D { 0 };
+    assert_true(oob_server_probe_read(&buf, &out));
+    as=
sert_true(in=2Etimestamp =3D=3D out=2Etimestamp);
+    assert_int_equal(in=
=2Eflags, out=2Eflags);
+
+    gc_free(&gc);
+}
+
+/* TLVs other than probe=
_parameter are skipped, so the scan finds the
+ * probe_parameter even when=
 preceded by an unknown TLV=2E */
+static void
+test_server_probe_read_skip=
s_unknown(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struc=
t buffer buf =3D alloc_buf_gc(128, &gc);
+
+    /* SERVER_PROBE message hea=
der, then an unknown but optional TLV (type
+     * 0x7ff) =2E=2E=2E */
+  =
  assert_true(buf_write_u16(&buf, OOB_MSG_SERVER_PROBE));
+    assert_true(=
ctrl_msg_tlv_write_header(&buf, 0x7ff, true, 4));
+    assert_true(buf_writ=
e_u32(&buf, 0xcafef00d));
+    /* =2E=2E=2E followed by the real probe_para=
meter */
+    const struct oob_probe_parameter in =3D { =2Etimestamp =3D 42=
, =2Eflags =3D 0 };
+    assert_true(oob_probe_parameter_write(&buf, &in));=

+
+    struct oob_probe_parameter out =3D { 0 };
+    assert_true(oob_serv=
er_probe_read(&buf, &out));
+    assert_true(out=2Etimestamp =3D=3D 42);
+
=
+    gc_free(&gc);
+}
+
+/* An unknown TLV that is NOT marked optional carr=
ies something the sender
+ * requires us to act on: the whole message is re=
jected, whether that TLV comes
+ * before or after the one we were looking =
for=2E */
+static void
+test_server_probe_read_rejects_unknown_mandatory(vo=
id **state)
+{
+    struct gc_arena gc =3D gc_new();
+    const struct oob_=
probe_parameter in =3D { =2Etimestamp =3D 42, =2Eflags =3D 0 };
+
+    stru=
ct buffer before =3D alloc_buf_gc(128, &gc);
+    assert_true(buf_write_u16=
(&before, OOB_MSG_SERVER_PROBE));
+    assert_true(ctrl_msg_tlv_write_heade=
r(&before, 0x7ff, false, 4));
+    assert_true(buf_write_u32(&before, 0xcaf=
ef00d));
+    assert_true(oob_probe_parameter_write(&before, &in));
+
+    =
struct buffer after =3D alloc_buf_gc(128, &gc);
+    assert_true(buf_write_=
u16(&after, OOB_MSG_SERVER_PROBE));
+    assert_true(oob_probe_parameter_wr=
ite(&after, &in));
+    assert_true(ctrl_msg_tlv_write_header(&after, 0x7ff=
, false, 4));
+    assert_true(buf_write_u32(&after, 0xcafef00d));
+
+    s=
truct oob_probe_parameter out =3D { 0 };
+    assert_false(oob_server_probe=
_read(&before, &out));
+    assert_false(oob_server_probe_read(&after, &out=
));
+
+    gc_free(&gc);
+}
+
+/* A payload with no probe_parameter must be=
 rejected=2E */
+static void
+test_server_probe_read_missing(void **state)
=
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_b=
uf_gc(128, &gc);
+
+    assert_true(buf_write_u16(&buf, OOB_MSG_SERVER_PROB=
E));
+    assert_true(ctrl_msg_tlv_write_header(&buf, 0x7ff, true, 4));
+  =
  assert_true(buf_write_u32(&buf, 0));
+
+    struct oob_probe_parameter ou=
t =3D { 0 };
+    assert_false(oob_server_probe_read(&buf, &out));
+
+    g=
c_free(&gc);
+}
+
+/* A TLV whose declared length runs past the buffer must=
 be rejected, not
+ * read out of bounds=2E */
+static void
+test_server_pr=
obe_read_truncated(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+=
    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    /* TLV header clai=
ms a 16-byte value but no value bytes follow */
+    assert_true(buf_write_=
u16(&buf, OOB_MSG_SERVER_PROBE));
+    assert_true(ctrl_msg_tlv_write_heade=
r(&buf, 0x7ff, false, 16));
+
+    struct oob_probe_parameter out =3D { 0 }=
;
+    assert_false(oob_server_probe_read(&buf, &out));
+
+    gc_free(&gc)=
;
+}
+
+/* A SERVER_PROBE reader rejects a payload carrying a different mes=
sage type
+ * (here a PROBE_REPLY's), even if it contains a valid probe_par=
ameter TLV=2E */
+static void
+test_server_probe_read_wrong_msg_type(void *=
*state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D=
 alloc_buf_gc(128, &gc);
+
+    assert_true(buf_write_u16(&buf, OOB_MSG_PRO=
BE_REPLY));
+    const struct oob_probe_parameter in =3D { =2Etimestamp =3D=
 42, =2Eflags =3D 0 };
+    assert_true(oob_probe_parameter_write(&buf, &in=
));
+
+    struct oob_probe_parameter out =3D { 0 };
+    assert_false(oob_=
server_probe_read(&buf, &out));
+
+    gc_free(&gc);
+}
+
+/* Timestamp win=
dow check accepts values within the window (either direction)
+ * and rejec=
ts values outside it=2E */
+static void
+test_timestamp_in_window(void **st=
ate)
+{
+    const uint64_t now =3D 1000000;
+    const uint64_t window =3D=
 30;
+
+    assert_true(oob_timestamp_in_window(now, now, window));
+    as=
sert_true(oob_timestamp_in_window(now - window, now, window));      /* boun=
dary, past */
+    assert_true(oob_timestamp_in_window(now + window, now, w=
indow));      /* boundary, future */
+    assert_false(oob_timestamp_in_win=
dow(now - window - 1, now, window)); /* too old */
+    assert_false(oob_ti=
mestamp_in_window(now + window + 1, now, window)); /* too far ahead */
+}
+=

+/* A well-formed probe with an in-window timestamp is accepted=2E */
+sta=
tic void
+test_server_probe_accept_valid(void **state)
+{
+    struct gc_ar=
ena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+=
    const uint64_t now =3D 1000000;
+    const struct oob_probe_parameter p=
robe =3D { =2Etimestamp =3D now, =2Eflags =3D 0 };
+    assert_true(oob_ser=
ver_probe_write(&buf, &probe));
+
+    assert_true(oob_server_probe_accept(=
&buf, now, 30));
+
+    gc_free(&gc);
+}
+
+/* A probe whose timestamp is o=
utside the window is dropped (no reply)=2E */
+static void
+test_server_pro=
be_accept_stale(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+   =
 struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    const uint64_t now =
=3D 1000000;
+    const struct oob_probe_parameter probe =3D { =2Etimestamp=
 =3D now - 1000, =2Eflags =3D 0 };
+    assert_true(oob_server_probe_write(=
&buf, &probe));
+
+    assert_false(oob_server_probe_accept(&buf, now, 30))=
;
+
+    gc_free(&gc);
+}
+
+/* A payload without a probe_parameter is drop=
ped (no reply)=2E */
+static void
+test_server_probe_accept_no_parameter(vo=
id **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf=
 =3D alloc_buf_gc(128, &gc);
+
+    assert_true(buf_write_u16(&buf, OOB_MSG=
_SERVER_PROBE));
+    assert_true(ctrl_msg_tlv_write_header(&buf, 0x7ff, tr=
ue, 4));
+    assert_true(buf_write_u32(&buf, 0));
+
+    assert_false(oob_=
server_probe_accept(&buf, 1000000, 30));
+
+    gc_free(&gc);
+}
+
 int
 ma=
in(void)
 {
@@ -334,6 +523,16 @@
         cmocka_unit_test(test_find_tlv_sk=
ips_optional_after_wanted),
         cmocka_unit_test(test_find_tlv_empty_p=
ayload),
         cmocka_unit_test(test_tlv_header_truncated),
+        cmo=
cka_unit_test(test_server_probe_read_finds_parameter),
+        cmocka_unit=
_test(test_server_probe_read_skips_unknown),
+        cmocka_unit_test(test=
_server_probe_read_rejects_unknown_mandatory),
+        cmocka_unit_test(te=
st_server_probe_read_missing),
+        cmocka_unit_test(test_server_probe_=
read_truncated),
+        cmocka_unit_test(test_server_probe_read_wrong_msg=
_type),
+        cmocka_unit_test(test_timestamp_in_window),
+        cmock=
a_unit_test(test_server_probe_accept_valid),
+        cmocka_unit_test(test=
_server_probe_accept_stale),
+        cmocka_unit_test(test_server_probe_ac=
cept_no_parameter),
     };
 
     return cmocka_run_group_tests_name("oob =
tests", tests, NULL, NULL);

-- 
To view, visit http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1742?usp=3Demail
To unsubscribe, or for help writing mail fi=
lters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mes=
sageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30
Gerrit-Change-Number: =
1742
Gerrit-PatchSet: 15
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

--XQy8ni+1jKI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, ralf_lici, stipa=2E </p>
<p>=
stipa <strong>uploaded patch set #15</strong> to this change=2E</p><p><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail">View Chan=
ge</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">oob: Add SERVER_PROBE parsing and the probe-reply d=
ecision<br><br>Add the message-level helpers the server needs to answer a p=
robe:<br><br>  - oob_server_probe_write() writes a SERVER_PROBE (message-ty=
pe header<br>    + probe_parameter TLV); the client uses it later=2E<br>  -=
 oob_server_probe_read() scans the TLV payload of a received OOB<br>    SER=
VER_PROBE for the probe_parameter TLV, skipping other/future TLV<br>    typ=
es that are marked optional, and rejecting malformed or truncated<br>    in=
put as well as a mandatory TLV it does not understand=2E<br>  - oob_timesta=
mp_in_window() performs the cheap replay/skew check on<br>    the probe tim=
estamp described in the wire protocol specification=2E<br>  - oob_server_pr=
obe_accept() combines the two: given a received<br>    SERVER_PROBE it scan=
s for the probe_parameter and accepts the probe<br>    unless that is missi=
ng or its timestamp is outside the acceptable<br>    window=2E It reads the=
 probe and nothing else; the reply is the<br>    caller&#39;s to build=2E<b=
r><br>A probe whose timestamp falls outside the window is dropped without a=
<br>reply, which is what the spec allows: the timestamp is there so a serve=
r<br>may silently drop requests outside an acceptable window and reduce the=
<br>replay attack surface=2E The window itself is the caller&#39;s choice; =
the<br>server path passes --hand-window in a follow-up=2E<br><br>These are =
pure functions exercised by unit tests; the server packet path<br>calls oob=
_server_probe_accept() in a follow-up and builds and sends the<br>reply its=
elf=2E<br><br>Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30<br>Signe=
d-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M src/openvpn/oo=
b=2Ec<br>M src/openvpn/oob=2Eh<br>M tests/unit_tests/openvpn/test_oob=2Ec<b=
r>3 files changed, 288 insertions(+), 0 deletions(-)<br><br></pre><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/42/17=
42/15</pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec</span>=
<br><span>index c807171=2E=2Ec8c7346 100644</span><br><span>--- a/src/openv=
pn/oob=2Ec</span><br><span>+++ b/src/openvpn/oob=2Ec</span><br><span>@@ -81=
,3 +81,46 @@</span><br><span>     r-&gt;flags =3D buf_read_u32(buf, NULL);<=
/span><br><span>     return true;</span><br><span> }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
oob_server_probe_write(struct buffer *buf, const struct oob_probe_parameter=
 *param)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    return buf_write_u16(buf,=
 OOB_MSG_SERVER_PROBE) &amp;&amp; oob_probe_parameter_write(buf, param);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+oob_server_probe_read(struct buffer *payload, struct oob_probe_parameter *=
param)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (!ctrl_msg_read_header(p=
ayload, OOB_MSG_SERVER_PROBE))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct buffer value;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (!ctrl_msg_find_tlv(pa=
yload, OOB_TLV_PROBE_PARAMETER, &amp;value))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        return false;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return oob_probe=
_parameter_read(&amp;value, param);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+oob_timestamp_in_window(uint64_t pro=
be_ts, uint64_t now, uint64_t window_secs)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    uint64_t diff =3D (now &gt; probe_ts) ? (now - probe_ts) : (probe_=
ts - now);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retur=
n diff &lt;=3D window_secs;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+oob_server_probe_accept(struct buffer *probe=
_payload, uint64_t now, uint64_t window_secs)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct oob_probe_parameter param;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (!oob_server_probe_read(probe_payload, &am=
p;param))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* Drop replayed or implausibly-timed probes before=
 doing any more work=2E */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    return oob_timestamp_in_window(param=2Etimestamp, now, window_se=
cs);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an>diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh</span><br><span>i=
ndex c5396b3=2E=2E8c091fc 100644</span><br><span>--- a/src/openvpn/oob=2Eh<=
/span><br><span>+++ b/src/openvpn/oob=2Eh</span><br><span>@@ -107,4 +107,50=
 @@</span><br><span>  */</span><br><span> bool oob_probe_reply_read(struct =
buffer *buf, struct oob_probe_reply *r);</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * Write a complete SERVER_PROBE message (message-ty=
pe header + probe_parameter</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * TLV) to buf=2E Sent by the client=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+bool oob_server_probe_write(struct buffer *buf, const struct oo=
b_probe_parameter *param);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * Read a received OOB SERVE=
R_PROBE: verify its message-type header, then scan</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * for the probe_parameter TLV=2E Unknown TL=
V types marked optional are skipped;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * an unknown mandatory one rejects the probe=2E payload i=
s consumed as it is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * read=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param payload  buffer =
positioned at the start of the OOB message payload</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * @param param    filled with the parsed pr=
obe_parameter on success</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @return true if the header matched and a well-formed probe_paramete=
r was</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         fou=
nd, false otherwise</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool oob_server_=
probe_read(struct buffer *payload, struct oob_probe_parameter *param);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Check whether a probe timestamp is within an acceptabl=
e window around the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * current time=2E Used to cheaply drop replayed or implausibly-timed probe=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * before doing an=
y further work (see the probe_parameter timestamp rationale</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * in the wire protocol specificati=
on)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param probe_ts     timesta=
mp from the probe_parameter (UNIX seconds)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param now          current time (UNIX seconds)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param window_secs=
  maximum allowed difference, in either direction</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @return true if |now - probe_ts| &lt;=3D w=
indow_secs</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+bool oob_timestamp_in_win=
dow(uint64_t probe_ts, uint64_t now, uint64_t window_secs);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * Decide whether a received SERVER_PROBE is answered=2E Combines</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * oob_server_probe_read=
() and oob_timestamp_in_window(): the probe is dropped</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * if its payload has no valid probe_par=
ameter or the timestamp is outside the</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * acceptable window=2E This is the transport-agnostic d=
ecision step; the caller</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * builds and sends the reply=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * @param probe_payload  TLV payload of the received OOB SERVER_PROBE, con=
sumed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param now =
           current time (UNIX seconds)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * @param window_secs    acceptable timestamp skew, in e=
ither direction</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
return true if a reply should be sent, false to silently drop the probe</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+bool oob_server_probe_accept(struct buf=
fer *probe_payload, uint64_t now, uint64_t window_secs);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* OOB_H */</=
span><br><span>diff --git a/tests/unit_tests/openvpn/test_oob=2Ec b/tests/u=
nit_tests/openvpn/test_oob=2Ec</span><br><span>index 70f529e0=2E=2E7254557 =
100644</span><br><span>--- a/tests/unit_tests/openvpn/test_oob=2Ec</span><b=
r><span>+++ b/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>@@ -319=
,6 +319,195 @@</span><br><span>     gc_free(&amp;gc);</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A=
 SERVER_PROBE carrying just a probe_parameter is found by the scan=2E */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+test_server_probe_read_finds_p=
arameter(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_a=
rena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    const struct oob_probe_parameter in =3D {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        =2Etimestamp =3D 0x11223=
34455667788ULL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    =2Eflags =3D 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tr=
ue(oob_server_probe_write(&amp;buf, &amp;in));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct oob_probe_parameter out =3D { 0 };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_server_probe_read(&am=
p;buf, &amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_true(in=2Etimestamp =3D=3D out=2Etimestamp);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(in=2Eflags, out=2Ef=
lags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/* TLVs other than probe_parameter are skipped, so the scan finds t=
he</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * probe_paramete=
r even when preceded by an unknown TLV=2E */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+test_server_probe_read_skips_unknown(void **state)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D al=
loc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* SERVER=
_PROBE message header, then an unknown but optional TLV (type</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     * 0x7ff) =2E=2E=2E */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_=
u16(&amp;buf, OOB_MSG_SERVER_PROBE));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;buf, 0x7ff=
, true, 4));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_true(buf_write_u32(&amp;buf, 0xcafef00d));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* =2E=2E=2E followed by the real probe_para=
meter */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const s=
truct oob_probe_parameter in =3D { =2Etimestamp =3D 42, =2Eflags =3D 0 };</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_p=
robe_parameter_write(&amp;buf, &amp;in));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct oob_probe_parameter out =3D { 0 };</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_true(oob_server_probe_read(&amp;buf=
, &amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_true(out=2Etimestamp =3D=3D 42);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/* An unknown TLV that is NOT marked=
 optional carries something the sender</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * requires us to act on: the whole message is rejected,=
 whether that TLV comes</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * before or after the one we were looking for=2E */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+test_server_probe_read_rejects_unknown_mandato=
ry(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena g=
c =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
const struct oob_probe_parameter in =3D { =2Etimestamp =3D 42, =2Eflags =3D=
 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct buffer before =3D allo=
c_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_true(buf_write_u16(&amp;before, OOB_MSG_SERVER_PROBE));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg=
_tlv_write_header(&amp;before, 0x7ff, false, 4));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;before, 0x=
cafef00d));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_true(oob_probe_parameter_write(&amp;before, &amp;in));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct buffer after =3D alloc_buf_gc(128, &amp;gc);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_=
write_u16(&amp;after, OOB_MSG_SERVER_PROBE));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_true(oob_probe_parameter_write(&amp;af=
ter, &amp;in));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_true(ctrl_msg_tlv_write_header(&amp;after, 0x7ff, false, 4));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_=
u32(&amp;after, 0xcafef00d));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t oob_probe_parameter out =3D { 0 };</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_false(oob_server_probe_read(&amp;before, &amp;o=
ut));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_fal=
se(oob_server_probe_read(&amp;after, &amp;out));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A payload with no prob=
e_parameter must be rejected=2E */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+test_server_probe_read_missing(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(12=
8, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_=
u16(&amp;buf, OOB_MSG_SERVER_PROBE));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;buf, 0x7ff=
, true, 4));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_true(buf_write_u32(&amp;buf, 0));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct oob_probe_parameter out =3D { 0 };</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_false(oob_server_probe_read(&amp;buf, &=
amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/* A TLV whose declared length runs past the buffer must be rej=
ected, not</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * read o=
ut of bounds=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_serv=
er_probe_read_truncated(void **state)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* TLV header claims a 16-byte value =
but no value bytes follow */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_true(buf_write_u16(&amp;buf, OOB_MSG_SERVER_PROBE));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_m=
sg_tlv_write_header(&amp;buf, 0x7ff, false, 16));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct oob_probe_parameter out =3D { 0 };</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_false(oob_server_probe_read=
(&amp;buf, &amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp=
;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/* A SERVER_PROBE reader rejects a payload carrying=
 a different message type</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * (here a PROBE_REPLY&#39;s), even if it contains a valid probe_para=
meter TLV=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stat=
ic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_server_=
probe_read_wrong_msg_type(void **state)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u16(&amp;buf, O=
OB_MSG_PROBE_REPLY));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    const struct oob_probe_parameter in =3D { =2Etimestamp =3D 42, =2Efla=
gs =3D 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_true(oob_probe_parameter_write(&amp;buf, &amp;in));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct oob_probe_parameter out =3D { 0 };</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_false(oob_server_probe=
_read(&amp;buf, &amp;out));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free=
(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/* Timestamp window check accepts values withi=
n the window (either direction)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * and rejects values outside it=2E */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+test_timestamp_in_window(void **state)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    const uint64_t now =3D 1000000;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    const uint64_t window =3D 30;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_timestamp_in_window(=
now, now, window));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_true(oob_timestamp_in_window(now - window, now, window));      /=
* boundary, past */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_true(oob_timestamp_in_window(now + window, now, window));      /=
* boundary, future */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_false(oob_timestamp_in_window(now - window - 1, now, window));=
 /* too old */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_false(oob_timestamp_in_window(now + window + 1, now, window)); /* too=
 far ahead */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* A well-formed probe with an in-window =
timestamp is accepted=2E */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
test_server_probe_accept_valid(void **state)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    const uint64_t now =3D 1000000;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct oob=
_probe_parameter probe =3D { =2Etimestamp =3D now, =2Eflags =3D 0 };</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_server=
_probe_write(&amp;buf, &amp;probe));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_true(oob_server_probe_accept(&amp;buf, now, 30));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A probe whos=
e timestamp is outside the window is dropped (no reply)=2E */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+test_server_probe_accept_stale(void **sta=
te)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new(=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer=
 buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  const uint64_t now =3D 1000000;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    const struct oob_probe_parameter probe =3D { =2Etimestamp=
 =3D now - 1000, =2Eflags =3D 0 };</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_true(oob_server_probe_write(&amp;buf, &amp;probe)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_false(oob_server_probe_ac=
cept(&amp;buf, now, 30));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&=
amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/* A payload without a probe_parameter is droppe=
d (no reply)=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_serv=
er_probe_accept_no_parameter(void **state)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u16(&amp;buf=
, OOB_MSG_SERVER_PROBE));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;buf, 0x7ff, true, 4));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf=
_write_u32(&amp;buf, 0));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_fa=
lse(oob_server_probe_accept(&amp;buf, 1000000, 30));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> int</span><br><span> main(void)</span><br><span> {</span><=
br><span>@@ -334,6 +523,16 @@</span><br><span>         cmocka_unit_test(tes=
t_find_tlv_skips_optional_after_wanted),</span><br><span>         cmocka_un=
it_test(test_find_tlv_empty_payload),</span><br><span>         cmocka_unit_=
test(test_tlv_header_truncated),</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        cmocka_unit_test(test_server_probe_read_finds_paramete=
r),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_u=
nit_test(test_server_probe_read_skips_unknown),</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_server_probe_read=
_rejects_unknown_mandatory),</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        cmocka_unit_test(test_server_probe_read_missing),</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(tes=
t_server_probe_read_truncated),</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        cmocka_unit_test(test_server_probe_read_wrong_msg_type)=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_uni=
t_test(test_timestamp_in_window),</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        cmocka_unit_test(test_server_probe_accept_valid),</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_tes=
t(test_server_probe_accept_stale),</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        cmocka_unit_test(test_server_probe_accept_no_paramet=
er),</span><br><span>     };</span><br><span> </span><br><span>     return =
cmocka_run_group_tests_name(&quot;oob tests&quot;, tests, NULL, NULL);</spa=
n><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1742?usp=3Demail">change 1742</a>=2E To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail"/><meta itemprop=
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
<div style=3D"display:none"> Gerrit-PatchSet: 15 </div>
=
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;f=
rank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@man=
delbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stip=
a &lt;lstipakov@gmail=2Ecom&gt; </div>

</body></html>
--XQy8ni+1jKI=--


--===============6409618376288304265==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6409618376288304265==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6409618376288304265==--

