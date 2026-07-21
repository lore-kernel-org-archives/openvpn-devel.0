Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 353A8C4451C
	for <openvpn-devel@archiver.kernel.org>; Tue, 21 Jul 2026 12:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w15JutmI8uQWQDmEhcQnKR8/qQ6UXrdoK/bWlH7qPvY=; b=XmFyiyXxImbi1URajAkD5l35mX
	gwpM5S8Lwxw54CuUiHGsUnUd6LINWnYlvCo9fvF1DJewRV6vOJpJaipuXzjtgXz9tOzOnUNUN7jTs
	IaOxw6S4Mjms4bY+CzCI0L6CSc5T8CrqSDaOubjBytJvlBnlCW4nYGoYdpR4j/sdjnv0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wm9hS-0003Jw-MA;
	Tue, 21 Jul 2026 12:35:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wm9hR-0003Jq-Ly
 for openvpn-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 12:35:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=VQqgCL74mCEz8K5WfMes44g5ecgjsVcoyi5yLOMCR00=; b=gdQamiMLROHdjz7pUXpguItgi9
 08Q2WOpv4GryIAYqKu9XQ8zP9vCZwMFU1jurkxTQuRoiafWRJvv6EGX4LLW0zSaUebQouoQ1ukTpV
 VlNIVMqSvls0JjYGs5iggS1P81aq81jYv3KYVx0FF35uZEDQ9Az/91bbiN5NOF6UY4QU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=VQqgCL74mCEz8K5WfMes44g5ecgjsVcoyi5yLOMCR00=; b=a
 fDEqhXyBKOPODTyhRJ0/ktgmd3pp8r2ohPNFWnBXungoDjxLv8m9FE13cRl6GdT5S2BWPjIpveQNS
 g3AIqjU6T2gDAHvnu4FvLuTDbq1jmBGNWSzpf4TjVgZg4SVs2wvXVqWSPXk+tkTbO9d0AyiN7GhAq
 +bGyUKQ6itPKOkAQ=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wm9hO-0001kE-RG for openvpn-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 12:35:53 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4954df200ddso23750785e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 21 Jul 2026 05:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784637344; x=1785242144; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VQqgCL74mCEz8K5WfMes44g5ecgjsVcoyi5yLOMCR00=;
 b=DL5urgkK7kX1uEVJ5tc7AO8G487xptrSHsYLqyLaLozGYiwYyKGkziBM/PQejP5Rpf
 +Pyc1/pxqazz5899SqenbQ9PyEudqFQUF7tqs4Vr5x+JFsF3vy6APGfUmuroOCgJAhE2
 LiWNNFMAuItV0BKe5YX9D4vvHVxtMbdOtLP2ikFQFK8AjQlIIh+Xw62NK5BSriWji+Og
 pGqMNemUY9SGNNDs8a363Lfwumlw28SutmXs9ZTDtcSY77ScLPZXMvhlsRWpU8oPsyKD
 K9ExCFFOu4eHMVtYmNHkpLLalkWlLRLZq4n+RQ495ytKAt2Eof8Qw0CWWDvh5/yqSVOe
 U/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784637344; x=1785242144;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=VQqgCL74mCEz8K5WfMes44g5ecgjsVcoyi5yLOMCR00=;
 b=VS+1DrHAe792AC2XNqab/HMzCa996EVlKa077tijyf/YhzFdMxYkZsu0hkUEya+jIC
 hqqGiDgWdsbhL1Z9RdgresXJkYVDNFqbGvwEKjmPJnSV2ruhwrCIAEPUs12OufS3okvi
 XdxL2Iz1HzvH3dEGxHUu1/E2BYvRqT3VhFFS0+tQW5vnxalAKLf+uZxW35aL9xmD3IDx
 M6d3nDgeosmbdUIw+MneespSyC6Be5E30AJiAmBXRY/OmzplBb66WQZ3YZoZ/HKKWfcm
 MAGYc4F1mZkKlGOJdVLMv+AR/W55come3YYuml4wq2QALfsa/8o85yu2YzGqaekWtEul
 9w+A==
X-Gm-Message-State: AOJu0YxNCjctkBDKOKapCJrEK/1VVKtZd1r4dDOicCOQNZQb1OZM4fwm
 34snobLsqqmjDYQY+9vd2DrBoIsky1ZjtrNxMLxDuKypfYnSwUHYj4i5AG/Vhg5d6LAhEVbE21Z
 3tsprK7kZQUAZRdPH5WHoEGOUf6dcx/iy3ucbunqPDZ6aXGmaLOvyndb3uE9NsNnQtQZT
X-Gm-Gg: AfdE7clcVXFZaHZR1rTwUn2K2UUet5wFfhqjhPDXPEcCZi++lSWCB/dykzzyr3YIjKE
 cMs3jfuhBQmLLV62XU/lpqY4fF7ZWoRglL7Gy8oTZ0DiV8QrNKFDnGV2FTlgh+XhInXUx2HBwgc
 paxV3bhpG/8SMqZneYjoyI4cds0NCwal7zt6JbIWKx7ErqZNnG1CYm7+i40z+02O7tll77H34tk
 J7o6IxFdhO147t7c1SaL6eWjIX3PLPslBBoN8vXqNEyXqn5hEascCt+f8OmXsge8Kb8+RALqBhS
 xHs2BnVinbqexteij3OtThS2TgYjrRH/u6R43drrIyMSsKW9zu2i0JcM50h/KfKYFyD0IgNr4u/
 NftCC5KqTyGMszj4eFNmqrzPwppH6zEbwznp3JInmhL/xAocZ3XJf1Xx4+SyLGhb+PdPq/j2MIY
 2XJBdistLmrvR5VBpLHBpjhkLGhzU0FpfV7gMab/lMgK0kvUfAQ6F1ARwwb1L5uG2qwEGmb5qUN
 KLwv2btQRrfwWCsZach8GjpjTzWT4pOXENLB279zweNA2Ig7735Tga8mKl1COw5w/CbL6g9XqGD
 o34=
X-Received: by 2002:a05:600c:4fc2:b0:495:5b02:23b0 with SMTP id
 5b1f17b1804b1-4955b0224c7mr132358855e9.26.1784637344079; 
 Tue, 21 Jul 2026 05:35:44 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4955de8895dsm148939555e9.4.2026.07.21.05.35.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 05:35:42 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 21 Jul 2026 12:35:24 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: If04ce09d4c353f5384c0c48f48f63e05869a373f
X-Gerrit-Change-Number: 1745
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1745?usp=email>
X-Gerrit-Commit: dc49b3ff37024a0bb810a18c1c03e2ec6f9df2e2
In-Reply-To: <gerrit.1782719911000.If04ce09d4c353f5384c0c48f48f63e05869a373f@gerrit.openvpn.net>
References: <gerrit.1782719911000.If04ce09d4c353f5384c0c48f48f63e05869a373f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklmMDRjZTA5ZDRjMzUzZjUzODRjMGM0OGY0OGY2M2UwNTg2OWEzNzNmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6d3628fee71c0c3fd915ab79f9c3d4051bb4aa26-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wm9hO-0001kE-RG
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5884288977563402885=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5884288977563402885==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RJol3AC4XqI="; charset=UTF-8

--RJol3AC4XqI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa=2E

He=
llo flichtenheld, plaisthos, 

I'd like you to reexamine a change=2E Please=
 visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1745?usp=3Demail

to =
look at the new patch set (#8)=2E

The following approvals got outdated and=
 were removed:
Code-Review+2 by flichtenheld

The change is no longer submi=
ttable: Code-Review and checks~ChecksSubmitRule are unsatisfied now=2E


Ch=
ange subject: oob: Add client PROBE_REPLY parser
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Add client PROBE_REPLY parser

A=
dd oob_client_reply_read(), the client-side counterpart of
oob_server_probe=
_read(): it scans the TLV payload of a received PROBE_REPLY
for the probe_r=
eply TLV, skipping other/future TLV types=2E

Factor the shared TLV scan us=
ed by both into a static oob_find_tlv() helper
so the two readers no longer=
 duplicate the loop=2E

Change-Id: If04ce09d4c353f5384c0c48f48f63e05869a373=
f
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M src/openvpn/oob=2Ec=

M src/openvpn/oob=2Eh
M tests/unit_tests/openvpn/test_oob=2Ec
3 files chan=
ged, 129 insertions(+), 15 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/45/1745/8

diff --git a/src/openvpn/oob=
=2Ec b/src/openvpn/oob=2Ec
index 7470616=2E=2E863917f 100644
--- a/src/open=
vpn/oob=2Ec
+++ b/src/openvpn/oob=2Ec
@@ -174,27 +174,23 @@
            && =
oob_probe_parameter_write(buf, param);
 }
 
-bool
-oob_server_probe_read(st=
ruct buffer *payload, struct oob_probe_parameter *param)
+/* Scan @p payloa=
d for the first TLV of type @p wanted_type, skipping any other
+ * (e=2Eg=
=2E future) TLV types=2E On success @p payload is left positioned at that
+=
 * TLV's value and *value_len is its declared length=2E Returns false if th=
e TLV
+ * is not found or a header/length is malformed=2E */
+static bool
+=
oob_find_tlv(struct buffer *payload, uint16_t wanted_type, uint16_t *value_=
len)
 {
-    if (!oob_msg_read_header(payload, OOB_MSG_SERVER_PROBE))
-    =
{
-        return false;
-    }
-
-    /* Loop until we either find the pro=
be_parameter or run out of
-     * well-formed TLVs=2E */
     uint16_t typ=
e;
     bool optional;
-    uint16_t value_len;
-    while (oob_tlv_read_he=
ader(payload, &type, &optional, &value_len))
+    while (oob_tlv_read_heade=
r(payload, &type, &optional, value_len))
     {
-        if (type =3D=3D OO=
B_TLV_PROBE_PARAMETER)
+        if (type =3D=3D wanted_type)
         {
-  =
          return oob_probe_parameter_read(payload, param, value_len);
+    =
        return true;
         }
-        /* not the TLV we are looking for:=
 skip its value and keep scanning */
-        if (!buf_advance(payload, val=
ue_len))
+        /* not the TLV we want: skip its value and keep scanning =
*/
+        if (!buf_advance(payload, *value_len))
         {
             =
return false;
         }
@@ -203,12 +199,30 @@
 }
 
 bool
+oob_server_probe=
_read(struct buffer *payload, struct oob_probe_parameter *param)
+{
+    ui=
nt16_t value_len;
+    return oob_msg_read_header(payload, OOB_MSG_SERVER_P=
ROBE)
+           && oob_find_tlv(payload, OOB_TLV_PROBE_PARAMETER, &value_=
len)
+           && oob_probe_parameter_read(payload, param, value_len);
+}=

+
+bool
 oob_client_reply_write(struct buffer *buf, const struct oob_probe=
_reply *reply)
 {
     return oob_msg_write_header(buf, OOB_MSG_PROBE_REPLY=
) && oob_probe_reply_write(buf, reply);
 }
 
 bool
+oob_client_reply_read(s=
truct buffer *payload, struct oob_probe_reply *reply)
+{
+    uint16_t valu=
e_len;
+    return oob_msg_read_header(payload, OOB_MSG_PROBE_REPLY)
+     =
      && oob_find_tlv(payload, OOB_TLV_PROBE_REPLY, &value_len)
+          =
 && oob_probe_reply_read(payload, reply, value_len);
+}
+
+bool
 oob_timest=
amp_in_window(uint64_t probe_ts, uint64_t now, uint64_t window_secs)
 {
   =
  uint64_t diff =3D (now > probe_ts) ? (now - probe_ts) : (probe_ts - now);=

diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh
index 3180bd4=2E=2E=
97dedbb 100644
--- a/src/openvpn/oob=2Eh
+++ b/src/openvpn/oob=2Eh
@@ -175,=
6 +175,19 @@
 bool oob_client_reply_write(struct buffer *buf, const struct =
oob_probe_reply *reply);
 
 /**
+ * Read a received OOB PROBE_REPLY: verify=
 its message-type header, then scan
+ * for the probe_reply TLV; the client=
-side counterpart of
+ * oob_server_probe_read()=2E TLV types other than pr=
obe_reply are skipped=2E
+ * @p payload is consumed as it is read=2E
+ *
+ =
* @param payload  buffer positioned at the start of the OOB message payload=

+ * @param reply    filled with the parsed probe_reply on success
+ * @ret=
urn true if the header matched and a well-formed probe_reply was found,
+ *=
         false otherwise
+ */
+bool oob_client_reply_read(struct buffer *pa=
yload, struct oob_probe_reply *reply);
+
+/**
  * Check whether a probe tim=
estamp is within an acceptable window around the
  * current time=2E Used t=
o cheaply drop replayed or implausibly-timed probes
  * before doing any fu=
rther work (see the probe_parameter timestamp rationale
diff --git a/tests/=
unit_tests/openvpn/test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec
ind=
ex 4412389=2E=2E639e862 100644
--- a/tests/unit_tests/openvpn/test_oob=2Ec
=
+++ b/tests/unit_tests/openvpn/test_oob=2Ec
@@ -366,6 +366,89 @@
     gc_fr=
ee(&gc);
 }
 
+/* A PROBE_REPLY carrying a probe_reply is found by the clie=
nt scan, with all
+ * fields surviving=2E */
+static void
+test_client_repl=
y_read_finds_reply(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+=
    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    struct oob_probe_r=
eply in =3D {
+        =2Epriority =3D 5,
+        =2Eweight =3D 50,
+     =
   =2Econnect_lifetime =3D 120,
+        =2Eflags =3D 1,
+    };
+    memcp=
y(in=2Epeer_session_id=2Eid, "SRVREPLY", SID_SIZE);
+    assert_true(oob_cl=
ient_reply_write(&buf, &in));
+
+    struct oob_probe_reply out =3D { 0 };
=
+    assert_true(oob_client_reply_read(&buf, &out));
+    assert_memory_equ=
al(out=2Epeer_session_id=2Eid, in=2Epeer_session_id=2Eid, SID_SIZE);
+    a=
ssert_int_equal(out=2Epriority, in=2Epriority);
+    assert_int_equal(out=
=2Eweight, in=2Eweight);
+    assert_int_equal(out=2Econnect_lifetime, in=
=2Econnect_lifetime);
+    assert_int_equal(out=2Eflags, in=2Eflags);
+
+  =
  gc_free(&gc);
+}
+
+/* TLVs other than probe_reply are skipped=2E */
+sta=
tic void
+test_client_reply_read_skips_unknown(void **state)
+{
+    struct=
 gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc=
);
+
+    assert_true(oob_msg_write_header(&buf, OOB_MSG_PROBE_REPLY));
+  =
  assert_true(oob_tlv_write_header(&buf, 0x7ff, false, 4));
+    assert_tru=
e(buf_write_u32(&buf, 0xabad1dea));
+    struct oob_probe_reply in =3D { =
=2Epriority =3D 7 };
+    assert_true(oob_probe_reply_write(&buf, &in));
+
=
+    struct oob_probe_reply out =3D { 0 };
+    assert_true(oob_client_repl=
y_read(&buf, &out));
+    assert_int_equal(out=2Epriority, 7);
+
+    gc_fr=
ee(&gc);
+}
+
+/* A payload with no probe_reply is rejected=2E */
+static v=
oid
+test_client_reply_read_missing(void **state)
+{
+    struct gc_arena g=
c =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    a=
ssert_true(oob_msg_write_header(&buf, OOB_MSG_PROBE_REPLY));
+    assert_tr=
ue(oob_tlv_write_header(&buf, 0x7ff, false, 4));
+    assert_true(buf_write=
_u32(&buf, 0));
+
+    struct oob_probe_reply out =3D { 0 };
+    assert_fa=
lse(oob_client_reply_read(&buf, &out));
+
+    gc_free(&gc);
+}
+
+/* Likew=
ise, a PROBE_REPLY reader rejects a payload with the wrong message
+ * type=
 even when a valid probe_reply TLV follows=2E */
+static void
+test_client_=
reply_read_wrong_msg_type(void **state)
+{
+    struct gc_arena gc =3D gc_n=
ew();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    assert_true=
(oob_msg_write_header(&buf, OOB_MSG_SERVER_PROBE));
+    struct oob_probe_r=
eply in =3D { =2Epriority =3D 7 };
+    assert_true(oob_probe_reply_write(&=
buf, &in));
+
+    struct oob_probe_reply out =3D { 0 };
+    assert_false(=
oob_client_reply_read(&buf, &out));
+
+    gc_free(&gc);
+}
+
 int
 main(vo=
id)
 {
@@ -386,6 +469,10 @@
         cmocka_unit_test(test_build_probe_repl=
y_valid),
         cmocka_unit_test(test_build_probe_reply_stale),
        =
 cmocka_unit_test(test_build_probe_reply_no_parameter),
+        cmocka_uni=
t_test(test_client_reply_read_finds_reply),
+        cmocka_unit_test(test_=
client_reply_read_skips_unknown),
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
-PatchSet: 8
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: f=
lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefo=
rge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Attention: stipa <=
lstipakov@gmail=2Ecom>

--RJol3AC4XqI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, stipa=2E </p>
<p>stipa <stro=
ng>uploaded patch set #8</strong> to this change=2E</p><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1745?usp=3Demail">View Change</a></p><p=
>The following approvals got outdated and were removed:
Code-Review+2 by fl=
ichtenheld</p><p>The change is no longer submittable: Code-Review and check=
s~ChecksSubmitRule are unsatisfied now=2E</p><pre class=3D"blocks" style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">oob: Add client =
PROBE_REPLY parser<br><br>Add oob_client_reply_read(), the client-side coun=
terpart of<br>oob_server_probe_read(): it scans the TLV payload of a receiv=
ed PROBE_REPLY<br>for the probe_reply TLV, skipping other/future TLV types=
=2E<br><br>Factor the shared TLV scan used by both into a static oob_find_t=
lv() helper<br>so the two readers no longer duplicate the loop=2E<br><br>Ch=
ange-Id: If04ce09d4c353f5384c0c48f48f63e05869a373f<br>Signed-off-by: Lev St=
ipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M src/openvpn/oob=2Ec<br>M src/o=
penvpn/oob=2Eh<br>M tests/unit_tests/openvpn/test_oob=2Ec<br>3 files change=
d, 129 insertions(+), 15 deletions(-)<br><br></pre><pre class=3D"blocks" st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull s=
sh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/45/1745/8</pre><pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>di=
ff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec</span><br><span>index =
7470616=2E=2E863917f 100644</span><br><span>--- a/src/openvpn/oob=2Ec</span=
><br><span>+++ b/src/openvpn/oob=2Ec</span><br><span>@@ -174,27 +174,23 @@<=
/span><br><span>            &amp;&amp; oob_probe_parameter_write(buf, param=
);</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-oob_server_probe_read(struct buffer *payload, struct oob_probe_parameter *=
param)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Scan @p pa=
yload for the first TLV of type @p wanted_type, skipping any other</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * (e=2Eg=2E future) TLV typ=
es=2E On success @p payload is left positioned at that</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * TLV&#39;s value and *value_len is its=
 declared length=2E Returns false if the TLV</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * is not found or a header/length is malformed=2E=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_find_tlv(struct buff=
er *payload, uint16_t wanted_type, uint16_t *value_len)</span><br><span> {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!oob_msg_read_=
header(payload, OOB_MSG_SERVER_PROBE))</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        return false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    /* Loop until we either find the=
 probe_parameter or run out of</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-     * well-formed TLVs=2E */</span><br><span>     uint16_t type;<=
/span><br><span>     bool optional;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    uint16_t value_len;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    while (oob_tlv_read_header(payload, &amp;type, &amp;opt=
ional, &amp;value_len))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    while (oob_tlv_read_header(payload, &amp;type, &amp;optional, value=
_len))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        if (type =3D=3D OOB_TLV_PROBE_PARAMETER)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        if (type =3D=3D wanted_type)</=
span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            return oob_probe_parameter_read(payload, param, value_len);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return =
true;</span><br><span>         }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        /* not the TLV we are looking for: skip its value and ke=
ep scanning */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 if (!buf_advance(payload, value_len))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        /* not the TLV we want: skip its value and keep =
scanning */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if (!buf_advance(payload, *value_len))</span><br><span>         {</span><br=
><span>             return false;</span><br><span>         }</span><br><spa=
n>@@ -203,12 +199,30 @@</span><br><span> }</span><br><span> </span><br><spa=
n> bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_server_p=
robe_read(struct buffer *payload, struct oob_probe_parameter *param)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    uint16_t value_len;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    return oob_msg_read_header(payload, =
OOB_MSG_SERVER_PROBE)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+           &amp;&amp; oob_find_tlv(payload, OOB_TLV_PROBE_PARAMETER, &amp=
;value_len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
   &amp;&amp; oob_probe_parameter_read(payload, param, value_len);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+bool</span><br><span> oob_client_reply_write(struct buffer *buf, =
const struct oob_probe_reply *reply)</span><br><span> {</span><br><span>   =
  return oob_msg_write_header(buf, OOB_MSG_PROBE_REPLY) &amp;&amp; oob_prob=
e_reply_write(buf, reply);</span><br><span> }</span><br><span> </span><br><=
span> bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_clien=
t_reply_read(struct buffer *payload, struct oob_probe_reply *reply)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    uint16_t value_len;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return oob_msg_read_header(payload, O=
OB_MSG_PROBE_REPLY)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
           &amp;&amp; oob_find_tlv(payload, OOB_TLV_PROBE_REPLY, &amp;value=
_len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           &am=
p;&amp; oob_probe_reply_read(payload, reply, value_len);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
bool</span><br><span> oob_timestamp_in_window(uint64_t probe_ts, uint64_t n=
ow, uint64_t window_secs)</span><br><span> {</span><br><span>     uint64_t =
diff =3D (now &gt; probe_ts) ? (now - probe_ts) : (probe_ts - now);</span><=
br><span>diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh</span><br><=
span>index 3180bd4=2E=2E97dedbb 100644</span><br><span>--- a/src/openvpn/oo=
b=2Eh</span><br><span>+++ b/src/openvpn/oob=2Eh</span><br><span>@@ -175,6 +=
175,19 @@</span><br><span> bool oob_client_reply_write(struct buffer *buf, =
const struct oob_probe_reply *reply);</span><br><span> </span><br><span> /*=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Read a received=
 OOB PROBE_REPLY: verify its message-type header, then scan</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * for the probe_reply TLV; the cli=
ent-side counterpart of</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * oob_server_probe_read()=2E TLV types other than probe_reply are skip=
ped=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p payload=
 is consumed as it is read=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par=
am payload  buffer positioned at the start of the OOB message payload</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param reply    filled=
 with the parsed probe_reply on success</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @return true if the header matched and a well-formed=
 probe_reply was found,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *         false otherwise</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool =
oob_client_reply_read(struct buffer *payload, struct oob_probe_reply *reply=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span>  * Check whethe=
r a probe timestamp is within an acceptable window around the</span><br><sp=
an>  * current time=2E Used to cheaply drop replayed or implausibly-timed p=
robes</span><br><span>  * before doing any further work (see the probe_para=
meter timestamp rationale</span><br><span>diff --git a/tests/unit_tests/ope=
nvpn/test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>i=
ndex 4412389=2E=2E639e862 100644</span><br><span>--- a/tests/unit_tests/ope=
nvpn/test_oob=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_oob=
=2Ec</span><br><span>@@ -366,6 +366,89 @@</span><br><span>     gc_free(&amp=
;gc);</span><br><span> }</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/* A PROBE_REPLY carrying a probe_reply is found by =
the client scan, with all</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * fields surviving=2E */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+test_client_reply_read_finds_reply(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(12=
8, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_reply=
 in =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
=2Epriority =3D 5,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       =2Eweight =3D 50,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        =2Econnect_lifetime =3D 120,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        =2Eflags =3D 1,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    memcpy(in=2Epeer_session_id=2Eid, &quot;SRVREPLY&quot;, SI=
D_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
true(oob_client_reply_write(&amp;buf, &amp;in));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct oob_probe_reply out =3D { 0 };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_client_reply_read(&am=
p;buf, &amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_memory_equal(out=2Epeer_session_id=2Eid, in=2Epeer_session_id=2Ei=
d, SID_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_int_equal(out=2Epriority, in=2Epriority);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_int_equal(out=2Eweight, in=2Eweight);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equa=
l(out=2Econnect_lifetime, in=2Econnect_lifetime);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_int_equal(out=2Eflags, in=2Eflags)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/* TLVs other than probe_reply are skipped=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+test_client_reply_read_skips_unknown(void **state=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer b=
uf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_true(oob_msg_write_header(&amp;buf, OOB_MSG_PROBE_REPLY));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_tlv_write=
_header(&amp;buf, 0x7ff, false, 4));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_true(buf_write_u32(&amp;buf, 0xabad1dea));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_rep=
ly in =3D { =2Epriority =3D 7 };</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_true(oob_probe_reply_write(&amp;buf, &amp;in));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_reply out =3D { 0 };=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob=
_client_reply_read(&amp;buf, &amp;out));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_int_equal(out=2Epriority, 7);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A payload=
 with no probe_reply is rejected=2E */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+test_client_reply_read_missing(void **state)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(1=
28, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_msg_w=
rite_header(&amp;buf, OOB_MSG_PROBE_REPLY));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_true(oob_tlv_write_header(&amp;buf, 0x7=
ff, false, 4));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_true(buf_write_u32(&amp;buf, 0));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct oob_probe_reply out =3D { 0 };</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_false(oob_client_reply_read(&amp;buf, &a=
mp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/* Likewise, a PROBE_REPLY reader rejects a payload with the wro=
ng message</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * type e=
ven when a valid probe_reply TLV follows=2E */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+test_client_reply_read_wrong_msg_type(void **state)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =
=3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_true(oob_msg_write_header(&amp;buf, OOB_MSG_SERVER_PROBE));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_reply in =
=3D { =2Epriority =3D 7 };</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_true(oob_probe_reply_write(&amp;buf, &amp;in));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct oob_probe_reply out =3D { 0 };</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(oob_clien=
t_reply_read(&amp;buf, &amp;out));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> in=
t</span><br><span> main(void)</span><br><span> {</span><br><span>@@ -386,6 =
+469,10 @@</span><br><span>         cmocka_unit_test(test_build_probe_reply=
_valid),</span><br><span>         cmocka_unit_test(test_build_probe_reply_s=
tale),</span><br><span>         cmocka_unit_test(test_build_probe_reply_no_=
parameter),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
cmocka_unit_test(test_client_reply_read_finds_reply),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_client_repl=
y_read_skips_unknown),</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        cmocka_unit_test(test_client_reply_read_missing),</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_clie=
nt_reply_read_wrong_msg_type),</span><br><span>     };</span><br><span> </s=
pan><br><span>     return cmocka_run_group_tests_name(&quot;oob tests&quot;=
, tests, NULL, NULL);</span><br><span></span><br></pre><p>To view, visit <a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1745?usp=3Demail">change=
 1745</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1745?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div=
 style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: If04ce09d4c353f5384c0c48f48f63e05869a373f </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1745 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;=
lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel=
@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-A=
ttention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipak=
ov@gmail=2Ecom&gt; </div>

</body></html>
--RJol3AC4XqI=--


--===============5884288977563402885==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5884288977563402885==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5884288977563402885==--

