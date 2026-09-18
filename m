Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D0CC982D2
	for <openvpn-devel@archiver.kernel.org>; Fri, 18 Sep 2026 08:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K2yQrXLWjS97lIOfVSZfVn+R4YOtvL6Z/nbUc7rXjsw=; b=SvTTnH3Rg8Jjz4N+2MDYgwJxBh
	eTwwcO4uQsVrGnIsNQk6Z62nCQFzNLYeRgIA+7sxUYLLYzf9iNIZZ9xPEgIM9wJTSyJrdWbsBUN2e
	Z/02X6yd2+dImY77nNCgMElATm4bKs1d1CdE+WTDvZVFacbb5gfD5g07TQQK/xxXKk3E=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x7U0u-0008QC-1I;
	Fri, 18 Sep 2026 08:32:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x7U0p-0008OC-6y
 for openvpn-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 08:32:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=tTKolACPz7fvCBTS3pnS+sSW1T1tJjClhCPZk6dExu4=; b=JCibN2SGmj7YLyAXKzRFe0oYEy
 Q8WTayM4w5z9+EsNuf6SVBMgyG74cnMewkfX7SymifqRSoNPcpp+1dAfhDflMHyHdKzukThpvf1An
 fO8suX5+bQeuv7pjQh1Gze+VXhaAvNuwKhZ+DhzCM6VpgdxDEmf82kybpUB7TITwBTWQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tTKolACPz7fvCBTS3pnS+sSW1T1tJjClhCPZk6dExu4=; b=b
 D32lkjepkYNziKRv4KeB0nk9vLPpEdg6wMVBcxOrKaqHWNc9yJCAQRHHpccLcUW3YZ1wE+UM1zqxb
 I84j+DRoDRhaOFWEZ9GO11jEemQRBnHXwzXPSdij+fdzzq4uG0rkYpmCvVgdprgQ0JiRJJaL2+NWQ
 pnKhmQEwAjrCgz2k=;
Received: from mail-wr2-f20.google.com ([74.125.225.84])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x7U0j-0004Gh-0L for openvpn-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 08:32:00 +0000
Received: by mail-wr2-f20.google.com with SMTP id
 ffacd0b85a97d-482f6356256so161139f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 18 Sep 2026 01:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789720310; x=1790325110; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tTKolACPz7fvCBTS3pnS+sSW1T1tJjClhCPZk6dExu4=;
 b=bwSvgXowkWV05xWeAnufa9pTGJYi0AXTlc2L3jAeMfQ2Zhto+JY46R0GYfAlghuS1T
 jVGsq9IF7Ms+Pz8lEdgPgTXvvnQqVdHEue6iBKPGLhEcw+9PZt6OVqUI06Cbl0isGl5C
 esvCm2IvdsEvFiUheetr2zz1aTUjcRYAsyWCOA5PrkV0V7RFGDqodU8ey4Iq9HSNEeY+
 w7apzMt3Dx+H2rikXl+hC4ITKCtyL3UL5CML+ZF3+ZgTy3VOwMjBrXErmY3nbryy7cwB
 /XEL6+iB+ljL/yRlqHIqUXd+TceT5Ncy6Qrn/T3C9iKu/R95tl4EMIEiR7QXKdMq7z7B
 i0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789720310; x=1790325110;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=tTKolACPz7fvCBTS3pnS+sSW1T1tJjClhCPZk6dExu4=;
 b=r/IJLUBuhcHlN34y669NCbPicWgeG5dCNCi8QQ7pLL4nHeygHn5QcXJfJ88WGsuJWx
 hsBqxZ7hepzX/62elkBO+2HKfWb1deG73WBXhgGvxeeOMst8OYGuiVg4/bOi09aypN95
 6JfFgtkbZh36AJVNkCXuxNq1AqOFU/2yAcwEjqOhyhbgFrzGHj7zItAOV+VUyxGnOa+v
 HZokWLFjMIfNQVOhzLlqMVRIemvjfYLFEvgjHqr5VPLmwyL8FwtAHyV47HGCUflrqNzb
 xoDbIXWKfGOHlMWGfML6g/diGbBK+cg5Q9YMFVub3SSTup2wWNgwyWPBgV8Y+wzbKqLW
 +tDw==
X-Gm-Message-State: AFuF++ldyTdq93UJj8j3bmXxGRHZnW3IRXBpS9jXX/fFyR6JoltvE2Ge
 SP2b7Rvsov+tu1Nr007/AKvQkZAF5ZVzDZoAhEfOTCP9cBa13veJUgR1IGOhKs9HdX3aiS1lrTU
 s0yZMPjtyrdhc/Os5Hf30mq0R987s1SuqURjnWOSym8Zc9JGlu1VKOBgt5N1ZoE7vJVqn
X-Gm-Gg: AYBFou3mcBIwM7aerKn/RwUs++TjeZ1TY81hfGT3Nej/t0/dYIKZL3WvsBqKtW+w7a+
 WyaJBNVW+OAGLAzihlMNknB7iuinah/HZWqJ5nPRfi85rCMXHIxnJHCNOYzaxkQt6HtuyEikmvl
 Ry/pkWCaB3hVtMDw9yS6bt/DrDSdGoTJBO3DfK/JEve1UPPIXkunjIQ7FvU2InLHEXUAsXx+ofF
 TVVI1u06lRMJqBptLw2T8esL+6qEeQbe5eSCmao7LbHNXq+gSPZHhta7FsL6cGu2AU38giQZinM
 J1bHM65uuYQUf1Q1aaHr5hwkXyrK4F+DyrXesYodF2gh8svjVVj5O4t4LyXB1z82gbGkwL06JMT
 Eq2nPsSBTOQY0jart81W+SFqBzwdGVxRgNM6VK5vcs3rLuPQyHp2uxbzgAbikXmee9z8zmL1lSx
 WzINYML5MohlWw6MQLrrEhXas/ZXU5baxH5ls/KnzUVO6Dcy3WGd+0Nxm/NViFlxH0tXprgw8Ah
 39hanxtuCxxJ/diuLX8jMXNYmjEss8he3eOZhMSmukRDDKIcpSP0RjrHaPNiJo7C9AuqrZS8jPR
 dug9jfzJkTugrggDynM9rG83Epin8Lzs9Zxpvip3Bgeargnsjp29Zc0o/Xkaig==
X-Received: by 2002:a05:600c:3510:b0:49e:6836:5386 with SMTP id
 5b1f17b1804b1-49fc4eef2dfmr23356685e9.0.1789720310174; 
 Fri, 18 Sep 2026 01:31:50 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd22dbf2sm132704485e9.10.2026.09.18.01.31.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 01:31:49 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 18 Sep 2026 08:31:39 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>,
 ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 17
X-Gerrit-Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30
X-Gerrit-Change-Number: 1742
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1742?usp=email>
X-Gerrit-Commit: caff45b39c8172a2ae51c446d79e48effcc1ce7c
In-Reply-To: <gerrit.1782719911000.Iafa9efc1c156974ad9f5752e9de810a8c2f68c30@gerrit.openvpn.net>
References: <gerrit.1782719911000.Iafa9efc1c156974ad9f5752e9de810a8c2f68c30@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklhZmE5ZWZjMWMxNTY5NzRhZDlmNTc1MmU5ZGU4MTBhOGMyZjY4YzMwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9e14707af1724daf75a781e734f86e6099ffb553-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x7U0j-0004Gh-0L
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
Content-Type: multipart/mixed; boundary="===============3023254979243082024=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3023254979243082024==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ATN6qBY4fdk="; charset=UTF-8

--ATN6qBY4fdk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, ralf_lici=2E=


Hello flichtenheld, plaisthos, ralf_lici, 

I'd like you to reexamine a c=
hange=2E Please visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?u=
sp=3Demail

to look at the new patch set (#17)=2E


Change subject: oob: Ad=
d SERVER_PROBE parsing and the probe-reply decision
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Add SERVER_PROBE parsing and =
the probe-reply decision

Add the message-level helpers the server needs to=
 answer a probe:

  - oob_server_probe_write() writes a SERVER_PROBE (messa=
ge-type header
    + probe_parameter TLV); the client uses it later=2E
  - =
oob_server_probe_read() scans the TLV payload of a received OOB
    SERVER_=
PROBE for the probe_parameter TLV, skipping other/future TLV
    types that=
 are marked optional, and rejecting malformed or truncated
    input as wel=
l as a mandatory TLV it does not understand=2E
  - oob_timestamp_in_window(=
) performs the cheap replay/skew check on
    the probe timestamp described=
 in the wire protocol specification=2E
  - oob_server_probe_accept() combin=
es the two: given a received
    SERVER_PROBE it scans for the probe_parame=
ter and accepts the probe
    unless that is missing or its timestamp is ou=
tside the acceptable
    window=2E It reads the probe and nothing else; the=
 reply is the
    caller's to build=2E

A probe whose timestamp falls outsi=
de the window is dropped without a
reply, which is what the spec allows: th=
e timestamp is there so a server
may silently drop requests outside an acce=
ptable window and reduce the
replay attack surface=2E The window itself is =
the caller's choice; the
server path passes --hand-window in a follow-up=2E=


These are pure functions exercised by unit tests; the server packet path
=
calls oob_server_probe_accept() in a follow-up and builds and sends the
rep=
ly itself=2E

Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30
Signed-o=
ff-by: Lev Stipakov <lev@openvpn=2Enet>
---
M src/openvpn/oob=2Ec
M src/ope=
nvpn/oob=2Eh
M tests/unit_tests/openvpn/test_oob=2Ec
3 files changed, 293 i=
nsertions(+), 0 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:2941=
8/openvpn refs/changes/42/1742/17

diff --git a/src/openvpn/oob=2Ec b/src/o=
penvpn/oob=2Ec
index c807171=2E=2Ea1b9258 100644
--- a/src/openvpn/oob=2Ec
=
+++ b/src/openvpn/oob=2Ec
@@ -81,3 +81,45 @@
     r->flags =3D buf_read_u32=
(buf, NULL);
     return true;
 }
+
+bool
+oob_server_probe_write(struct bu=
ffer *buf, const struct oob_probe_parameter *param)
+{
+    return buf_writ=
e_u16(buf, OOB_MSG_SERVER_PROBE) && oob_probe_parameter_write(buf, param);
=
+}
+
+bool
+oob_server_probe_read(struct buffer *payload, struct oob_probe_=
parameter *param)
+{
+    if (!ctrl_msg_read_header(payload, OOB_MSG_SERVER=
_PROBE))
+    {
+        return false;
+    }
+
+    struct buffer value;
+=
    if (!ctrl_msg_find_tlv(payload, OOB_TLV_PROBE_PARAMETER, &value))
+    =
{
+        return false;
+    }
+
+    return oob_probe_parameter_read(&val=
ue, param);
+}
+
+bool
+oob_timestamp_in_window(uint64_t probe_ts, uint64_t=
 now, uint64_t window_secs)
+{
+    uint64_t diff =3D (now > probe_ts) ? (n=
ow - probe_ts) : (probe_ts - now);
+    return diff <=3D window_secs;
+}
+
=
+enum oob_probe_verdict
+oob_server_probe_check(struct buffer *probe_payloa=
d, uint64_t now, uint64_t window_secs)
+{
+    struct oob_probe_parameter p=
aram;
+    if (!oob_server_probe_read(probe_payload, &param))
+    {
+     =
   return OOB_PROBE_INVALID;
+    }
+    return oob_timestamp_in_window(par=
am=2Etimestamp, now, window_secs) ? OOB_PROBE_OK
+                         =
                                             : OOB_PROBE_STALE;
+}
diff --g=
it a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh
index c5396b3=2E=2E6d83eca 1=
00644
--- a/src/openvpn/oob=2Eh
+++ b/src/openvpn/oob=2Eh
@@ -107,4 +107,55=
 @@
  */
 bool oob_probe_reply_read(struct buffer *buf, struct oob_probe_re=
ply *r);
 
+/**
+ * Write a complete SERVER_PROBE message (message-type hea=
der + probe_parameter
+ * TLV) to buf=2E Sent by the client=2E
+ */
+bool o=
ob_server_probe_write(struct buffer *buf, const struct oob_probe_parameter =
*param);
+
+/**
+ * Read a received OOB SERVER_PROBE: verify its message-ty=
pe header, then scan
+ * for the probe_parameter TLV=2E Unknown TLV types m=
arked optional are skipped;
+ * an unknown mandatory one rejects the probe=
=2E payload is consumed as it is
+ * read=2E
+ *
+ * @param payload  buffer=
 positioned at the start of the OOB message payload
+ * @param param    fil=
led with the parsed probe_parameter on success
+ * @return true if the head=
er matched and a well-formed probe_parameter was
+ *         found, false o=
therwise
+ */
+bool oob_server_probe_read(struct buffer *payload, struct oo=
b_probe_parameter *param);
+
+/**
+ * Check whether a probe timestamp is wi=
thin an acceptable window around the
+ * current time=2E Used to cheaply dr=
op replayed or implausibly-timed probes
+ * before doing any further work (=
see the probe_parameter timestamp rationale
+ * in the wire protocol specif=
ication)=2E
+ *
+ * @param probe_ts     timestamp from the probe_parameter =
(UNIX seconds)
+ * @param now          current time (UNIX seconds)
+ * @par=
am window_secs  maximum allowed difference, in either direction
+ * @return=
 true if |now - probe_ts| <=3D window_secs
+ */
+bool oob_timestamp_in_wind=
ow(uint64_t probe_ts, uint64_t now, uint64_t window_secs);
+
+enum oob_prob=
e_verdict
+{
+    OOB_PROBE_INVALID, /**< no valid probe_parameter: drop */=

+    OOB_PROBE_STALE,   /**< well-formed, timestamp outside the window */
=
+    OOB_PROBE_OK,      /**< well-formed, timestamp within the window */
+}=
;
+
+/**
+ * Classify a received SERVER_PROBE=2E Combines oob_server_probe_=
read() and
+ * oob_timestamp_in_window()=2E This is the transport-agnostic =
decision step;
+ * the caller decides what to do with a stale probe and bui=
lds the reply=2E
+ *
+ * @param probe_payload  TLV payload of the received =
OOB SERVER_PROBE, consumed
+ * @param now            current time (UNIX sec=
onds)
+ * @param window_secs    acceptable timestamp skew, in either direct=
ion
+ */
+enum oob_probe_verdict oob_server_probe_check(struct buffer *prob=
e_payload, uint64_t now,
+                                              uin=
t64_t window_secs);
+
 #endif /* OOB_H */
diff --git a/tests/unit_tests/ope=
nvpn/test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec
index f81158e=2E=
=2Ed1f3828 100644
--- a/tests/unit_tests/openvpn/test_oob=2Ec
+++ b/tests/u=
nit_tests/openvpn/test_oob=2Ec
@@ -319,6 +319,196 @@
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
+/* A well-formed probe with an in-window timestamp is answered=
=2E */
+static void
+test_server_probe_check_valid(void **state)
+{
+    st=
ruct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128,=
 &gc);
+
+    const uint64_t now =3D 1000000;
+    const struct oob_probe_p=
arameter probe =3D { =2Etimestamp =3D now, =2Eflags =3D 0 };
+    assert_tr=
ue(oob_server_probe_write(&buf, &probe));
+
+    assert_int_equal(oob_serve=
r_probe_check(&buf, now, 30), OOB_PROBE_OK);
+
+    gc_free(&gc);
+}
+
+/* =
A well-formed probe whose timestamp is outside the window is stale; the
+ *=
 caller decides whether it still gets an answer=2E */
+static void
+test_se=
rver_probe_check_stale(void **state)
+{
+    struct gc_arena gc =3D gc_new(=
);
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    const uint64_t=
 now =3D 1000000;
+    const struct oob_probe_parameter probe =3D { =2Etime=
stamp =3D now - 1000, =2Eflags =3D 0 };
+    assert_true(oob_server_probe_w=
rite(&buf, &probe));
+
+    assert_int_equal(oob_server_probe_check(&buf, n=
ow, 30), OOB_PROBE_STALE);
+
+    gc_free(&gc);
+}
+
+/* A payload without =
a probe_parameter is invalid (no reply)=2E */
+static void
+test_server_pro=
be_check_no_parameter(void **state)
+{
+    struct gc_arena gc =3D gc_new()=
;
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    assert_true(buf=
_write_u16(&buf, OOB_MSG_SERVER_PROBE));
+    assert_true(ctrl_msg_tlv_writ=
e_header(&buf, 0x7ff, true, 4));
+    assert_true(buf_write_u32(&buf, 0));
=
+
+    assert_int_equal(oob_server_probe_check(&buf, 1000000, 30), OOB_PROB=
E_INVALID);
+
+    gc_free(&gc);
+}
+
 /* The OOB tests run as a second gro=
up of pkt_testdriver; see test_pkt=2Ec=2E */
 int
 run_oob_tests(void)
@@ -=
334,6 +524,16 @@
         cmocka_unit_test(test_find_tlv_skips_optional_aft=
er_wanted),
         cmocka_unit_test(test_find_tlv_empty_payload),
       =
  cmocka_unit_test(test_tlv_header_truncated),
+        cmocka_unit_test(te=
st_server_probe_read_finds_parameter),
+        cmocka_unit_test(test_serve=
r_probe_read_skips_unknown),
+        cmocka_unit_test(test_server_probe_re=
ad_rejects_unknown_mandatory),
+        cmocka_unit_test(test_server_probe_=
read_missing),
+        cmocka_unit_test(test_server_probe_read_truncated),=

+        cmocka_unit_test(test_server_probe_read_wrong_msg_type),
+       =
 cmocka_unit_test(test_timestamp_in_window),
+        cmocka_unit_test(test=
_server_probe_check_valid),
+        cmocka_unit_test(test_server_probe_che=
ck_stale),
+        cmocka_unit_test(test_server_probe_check_no_parameter),=

     };
 
     return cmocka_run_group_tests_name("oob tests", tests, NULL=
, NULL);

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742=
?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchs=
et
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iafa9efc=
1c156974ad9f5752e9de810a8c2f68c30
Gerrit-Change-Number: 1742
Gerrit-PatchSe=
t: 17
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: flichten=
held <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: op=
envpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: pla=
isthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-Attention: ralf_lici <ralf@mandelbit=2Ecom>

--ATN6qBY4fdk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, ralf_lici=2E </p>
<p>stipa <=
strong>uploaded patch set #17</strong> to this change=2E</p><p><a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">oob: Add SERVER_PROBE parsing and the probe-reply decision=
<br><br>Add the message-level helpers the server needs to answer a probe:<b=
r><br>  - oob_server_probe_write() writes a SERVER_PROBE (message-type head=
er<br>    + probe_parameter TLV); the client uses it later=2E<br>  - oob_se=
rver_probe_read() scans the TLV payload of a received OOB<br>    SERVER_PRO=
BE for the probe_parameter TLV, skipping other/future TLV<br>    types that=
 are marked optional, and rejecting malformed or truncated<br>    input as =
well as a mandatory TLV it does not understand=2E<br>  - oob_timestamp_in_w=
indow() performs the cheap replay/skew check on<br>    the probe timestamp =
described in the wire protocol specification=2E<br>  - oob_server_probe_acc=
ept() combines the two: given a received<br>    SERVER_PROBE it scans for t=
he probe_parameter and accepts the probe<br>    unless that is missing or i=
ts timestamp is outside the acceptable<br>    window=2E It reads the probe =
and nothing else; the reply is the<br>    caller&#39;s to build=2E<br><br>A=
 probe whose timestamp falls outside the window is dropped without a<br>rep=
ly, which is what the spec allows: the timestamp is there so a server<br>ma=
y silently drop requests outside an acceptable window and reduce the<br>rep=
lay attack surface=2E The window itself is the caller&#39;s choice; the<br>=
server path passes --hand-window in a follow-up=2E<br><br>These are pure fu=
nctions exercised by unit tests; the server packet path<br>calls oob_server=
_probe_accept() in a follow-up and builds and sends the<br>reply itself=2E<=
br><br>Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30<br>Signed-off-b=
y: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M src/openvpn/oob=2Ec<b=
r>M src/openvpn/oob=2Eh<br>M tests/unit_tests/openvpn/test_oob=2Ec<br>3 fil=
es changed, 293 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/42/1742/17</=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
><span>diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec</span><br><sp=
an>index c807171=2E=2Ea1b9258 100644</span><br><span>--- a/src/openvpn/oob=
=2Ec</span><br><span>+++ b/src/openvpn/oob=2Ec</span><br><span>@@ -81,3 +81=
,45 @@</span><br><span>     r-&gt;flags =3D buf_read_u32(buf, NULL);</span>=
<br><span>     return true;</span><br><span> }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_ser=
ver_probe_write(struct buffer *buf, const struct oob_probe_parameter *param=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    return buf_write_u16(buf, OOB_MS=
G_SERVER_PROBE) &amp;&amp; oob_probe_parameter_write(buf, param);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_se=
rver_probe_read(struct buffer *payload, struct oob_probe_parameter *param)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (!ctrl_msg_read_header(payload,=
 OOB_MSG_SERVER_PROBE))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
turn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer value;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (!ctrl_msg_find_tlv(payload, =
OOB_TLV_PROBE_PARAMETER, &amp;value))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        return false;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    return oob_probe_parame=
ter_read(&amp;value, param);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+oob_timestamp_in_window(uint64_t probe_ts=
, uint64_t now, uint64_t window_secs)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    uint64_t diff =3D (now &gt; probe_ts) ? (now - probe_ts) : (probe_ts - =
now);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return dif=
f &lt;=3D window_secs;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+enum oob_probe_verdict</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+oob_server_probe_check(struct b=
uffer *probe_payload, uint64_t now, uint64_t window_secs)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct oob_probe_parameter param;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (!oob_server_probe_read(probe_=
payload, &amp;param))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retu=
rn OOB_PROBE_INVALID;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return o=
ob_timestamp_in_window(param=2Etimestamp, now, window_secs) ? OOB_PROBE_OK<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
                                                  : OOB_PROBE_STALE;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --g=
it a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh</span><br><span>index c5396b=
3=2E=2E6d83eca 100644</span><br><span>--- a/src/openvpn/oob=2Eh</span><br><=
span>+++ b/src/openvpn/oob=2Eh</span><br><span>@@ -107,4 +107,55 @@</span><=
br><span>  */</span><br><span> bool oob_probe_reply_read(struct buffer *buf=
, struct oob_probe_reply *r);</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * Write a complete SERVER_PROBE message (message-type header +=
 probe_parameter</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
TLV) to buf=2E Sent by the client=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+bool oob_server_probe_write(struct buffer *buf, const struct oob_probe_par=
ameter *param);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * Read a received OOB SERVER_PROBE: ve=
rify its message-type header, then scan</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * for the probe_parameter TLV=2E Unknown TLV types mar=
ked optional are skipped;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * an unknown mandatory one rejects the probe=2E payload is consumed =
as it is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * read=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param payload  buffer positioned =
at the start of the OOB message payload</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @param param    filled with the parsed probe_paramet=
er on success</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @re=
turn true if the header matched and a well-formed probe_parameter was</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         found, false o=
therwise</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+bool oob_server_probe_read(=
struct buffer *payload, struct oob_probe_parameter *param);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * Check whether a probe timestamp is within an acceptable window arou=
nd the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * current ti=
me=2E Used to cheaply drop replayed or implausibly-timed probes</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * before doing any further wor=
k (see the probe_parameter timestamp rationale</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * in the wire protocol specification)=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param probe_ts     timestamp from the=
 probe_parameter (UNIX seconds)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param now          current time (UNIX seconds)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @param window_secs  maximum a=
llowed difference, in either direction</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * @return true if |now - probe_ts| &lt;=3D window_secs<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+bool oob_timestamp_in_window(uint64_=
t probe_ts, uint64_t now, uint64_t window_secs);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+enum oob_probe_verdict</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    O=
OB_PROBE_INVALID, /**&lt; no valid probe_parameter: drop */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    OOB_PROBE_STALE,   /**&lt; well=
-formed, timestamp outside the window */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    OOB_PROBE_OK,      /**&lt; well-formed, timestamp =
within the window */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * Classify a received SERVER_PROBE=2E Combines oob=
_server_probe_read() and</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * oob_timestamp_in_window()=2E This is the transport-agnostic decisio=
n step;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the calle=
r decides what to do with a stale probe and builds the reply=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @param probe_payload  TLV payload of the rece=
ived OOB SERVER_PROBE, consumed</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param now            current time (UNIX seconds)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param window_secs    accep=
table timestamp skew, in either direction</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+enum oob_probe_verdict oob_server_probe_check(struct buffer *probe_pa=
yload, uint64_t now,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                                              uint64_t window_secs);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif =
/* OOB_H */</span><br><span>diff --git a/tests/unit_tests/openvpn/test_oob=
=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>index f81158e=
=2E=2Ed1f3828 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_oo=
b=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_oob=2Ec</span><br=
><span>@@ -319,6 +319,196 @@</span><br><span>     gc_free(&amp;gc);</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/* A SERVER_PROBE carrying just a probe_parameter is found by the=
 scan=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static v=
oid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_server_prob=
e_read_finds_parameter(void **state)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    const struct oob_probe_parameter in =3D =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Etimesta=
mp =3D 0x1122334455667788ULL,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        =2Eflags =3D 0,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_true(oob_server_probe_write(&amp;buf, &amp;in));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct oob_probe_parameter out =3D { 0 };</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_server_=
probe_read(&amp;buf, &amp;out));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_true(in=2Etimestamp =3D=3D out=2Etimestamp);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(in=2E=
flags, out=2Eflags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/* TLVs other than probe_parameter are skipped, so th=
e scan finds the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
probe_parameter even when preceded by an unknown TLV=2E */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+test_server_probe_read_skips_unknown(void **=
state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_n=
ew();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buf=
fer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* SERVER_PROBE message header, then an unknown but optional TLV (type=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * 0x7ff) =2E=
=2E=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_true(buf_write_u16(&amp;buf, OOB_MSG_SERVER_PROBE));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_header=
(&amp;buf, 0x7ff, true, 4));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_true(buf_write_u32(&amp;buf, 0xcafef00d));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* =2E=2E=2E followed by the=
 real probe_parameter */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    const struct oob_probe_parameter in =3D { =2Etimestamp =3D 42, =2E=
flags =3D 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_true(oob_probe_parameter_write(&amp;buf, &amp;in));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct oob_probe_parameter out =3D { 0 };</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_server_pro=
be_read(&amp;buf, &amp;out));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_true(out=2Etimestamp =3D=3D 42);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* An unknown TLV th=
at is NOT marked optional carries something the sender</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * requires us to act on: the whole mess=
age is rejected, whether that TLV comes</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * before or after the one we were looking for=2E */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+test_server_probe_read_rejects=
_unknown_mandatory(void **state)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    const struct oob_probe_parameter in =3D { =2Etimestamp =3D =
42, =2Eflags =3D 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer=
 before =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_true(buf_write_u16(&amp;before, OOB_MSG_SERV=
ER_PROBE));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_true(ctrl_msg_tlv_write_header(&amp;before, 0x7ff, false, 4));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32=
(&amp;before, 0xcafef00d));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_true(oob_probe_parameter_write(&amp;before, &amp;in));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct buffer after =3D alloc_buf_gc=
(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_true(buf_write_u16(&amp;after, OOB_MSG_SERVER_PROBE));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_probe_paramet=
er_write(&amp;after, &amp;in));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;after, 0x7ff, fa=
lse, 4));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_true(buf_write_u32(&amp;after, 0xcafef00d));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct oob_probe_parameter out =3D { 0 };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_false(oob_server_probe_read(&a=
mp;before, &amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_false(oob_server_probe_read(&amp;after, &amp;out));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A pay=
load with no probe_parameter must be rejected=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+test_server_probe_read_missing(void **state)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =
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
th an in-window timestamp is answered=2E */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+test_server_probe_check_valid(void **state)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_=
gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint64_t no=
w =3D 1000000;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onst struct oob_probe_parameter probe =3D { =2Etimestamp =3D now, =2Eflags =
=3D 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
true(oob_server_probe_write(&amp;buf, &amp;probe));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_int_equal(oob_server_probe_check(&amp;buf, now, 3=
0), OOB_PROBE_OK);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/* A well-formed probe whose timestamp is outside the w=
indow is stale; the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * caller decides whether it still gets an answer=2E */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+test_server_probe_check_stale(void **state)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =
=3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st uint64_t now =3D 1000000;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    const struct oob_probe_parameter probe =3D { =2Etimestamp =3D =
now - 1000, =2Eflags =3D 0 };</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_true(oob_server_probe_write(&amp;buf, &amp;probe));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(oob_server_probe_che=
ck(&amp;buf, now, 30), OOB_PROBE_STALE);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/* A payload without a probe_para=
meter is invalid (no reply)=2E */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+test_server_probe_check_no_parameter(void **state)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(=
128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_writ=
e_u16(&amp;buf, OOB_MSG_SERVER_PROBE));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;buf, 0x7=
ff, true, 4));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_true(buf_write_u32(&amp;buf, 0));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_int_equal(oob_server_probe_check(&amp;buf, 1000000, 30), OOB_PR=
OBE_INVALID);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* The OOB tests run as=
 a second group of pkt_testdriver; see test_pkt=2Ec=2E */</span><br><span> =
int</span><br><span> run_oob_tests(void)</span><br><span>@@ -334,6 +524,16 =
@@</span><br><span>         cmocka_unit_test(test_find_tlv_skips_optional_a=
fter_wanted),</span><br><span>         cmocka_unit_test(test_find_tlv_empty=
_payload),</span><br><span>         cmocka_unit_test(test_tlv_header_trunca=
ted),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka=
_unit_test(test_server_probe_read_finds_parameter),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_server_prob=
e_read_skips_unknown),</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        cmocka_unit_test(test_server_probe_read_rejects_unknown_mandator=
y),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_u=
nit_test(test_server_probe_read_missing),</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        cmocka_unit_test(test_server_probe_read_trunc=
ated),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmock=
a_unit_test(test_server_probe_read_wrong_msg_type),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_timestamp_i=
n_window),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c=
mocka_unit_test(test_server_probe_check_valid),</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_server_probe_chec=
k_stale),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cm=
ocka_unit_test(test_server_probe_check_no_parameter),</span><br><span>     =
};</span><br><span> </span><br><span>     return cmocka_run_group_tests_nam=
e(&quot;oob tests&quot;, tests, NULL, NULL);</span><br><span></span><br></p=
re><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
742?usp=3Demail">change 1742</a>=2E To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eor=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1742?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatc=
hset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<di=
v style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30 </div>=

<div style=3D"display:none"> Gerrit-Change-Number: 1742 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 17 </div>
<div style=3D"display:none"> =
Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: r=
alf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>

</bo=
dy></html>
--ATN6qBY4fdk=--


--===============3023254979243082024==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3023254979243082024==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3023254979243082024==--

