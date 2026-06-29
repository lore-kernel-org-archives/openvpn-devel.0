Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0267C44501
	for <openvpn-devel@archiver.kernel.org>; Mon, 29 Jun 2026 07:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=u6xQ6w2wYtK8tVwwR4zKhYLmW70b80H7GEg868tH764=; b=YvfhvQOrx27UOF
	jRSNFrsU/9GFTrDsodck+nlRpe9wMyODrx0+UM7jCwxViVvf5ZCztVoA7JbmRzRB1ubDrgVnODQor
	ND+o9+60ybK3xlyZtDyveENo7gG8OYNrungfQKnyBd7jZ5CaUACemO4zjO+nRU4e2G+x0YhU6PIcp
	cpg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1we6ti-0001EX-2j;
	Mon, 29 Jun 2026 07:59:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1we6tg-0001EK-UU
 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 07:59:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=o4ZIKPVEDRwkLcgaLPhPluv6itjtyqjnmraYAornivM=; b=hOuZkQAcQpRGVZwC+WbtWR6Vlz
 yMCZ+i5g9Z8cQ9Xk16RfydChM59G/PYuM1AKbrNYp6Hv3nbiS1ip2Q4EiwY5dfb47PCt3JX0o3IZR
 Onf9tIDM0akN9A8CEwsPAZrrr0C4R79fLt/NdZoZEc3J5Lh4gg+uO/0HaQmJIuloR8Uw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=o4ZIKPVEDRwkLcgaLPhPluv6itjtyqjnmraYAornivM=; b=Y
 gvn52q0s/KompKf6WHqyh1rxX+DvAdaGknpkngsz4Eo5kWkxPeaV3zyjzH7WcmcM6XOPt3l7UdViV
 Ewb/BAUiJCZ6oPj+eP4+FTzKA7I4QDDm3bRZ5MxyTvi7w/sG8HA0tugafYuC98Ml7nbYLGkAye2EJ
 iVK+DSSeYGV5nJjw=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1we6tb-0008Na-1X for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 07:59:16 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-472055b0efaso1148522f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 29 Jun 2026 00:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782719940; x=1783324740; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o4ZIKPVEDRwkLcgaLPhPluv6itjtyqjnmraYAornivM=;
 b=HQUuxgNf5h3Fn66ocMEcb+dt0Oi7XN25h3YY5VkLjyvnlgtCQbE/CYKXN46UjA0N3s
 5pOq/es7MF4ZiU92CptL04gBY75GNV7iOekMvfJEP6gPNF3GuUbcBAV4SC+CMk5n8tkg
 YEnvdcNGPiiTZ/P0oZK23D2WytyedKI38IaIgGYMYQE9LCzmi/DVdheK6XV6fzTf7lTP
 CYvQYeupHGwvZiv7UPlOVMFPgc5yXc+TzzA80cxkCl5c1fLLtSLYHFmYC5b5iDD9MRn2
 SlGOA5m8h37x93N5UfEcPsTBhB9NctPyDKzexJgwbEANXz+KELdxTKTFeTUDjcpBv8Lv
 mYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782719940; x=1783324740;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o4ZIKPVEDRwkLcgaLPhPluv6itjtyqjnmraYAornivM=;
 b=JDdA2H5zk5YeYJlpEK0iYr4CYxWJkkLgzOa/6tCtdUsaM9DBEs9FwHq0lPyYYVqHff
 IlamEZTUEhAYwhziIZs2Nqt7U7rEhp0dAapNr1aP8enS/S0SKlVictWnRyreFTHKgoTD
 9Ubuvl3ErfnEsOyRxddyprWW7WHK16IA0gExTbahK8A6glDXcSo3qQ6763fXRoCXCH4C
 b0Smx6Lz9MFWwlpc2MbjRmIWyiFduWe/e+rJseUgJYeK9QVaLSSInlxl1arS53TEflle
 IHBSOsgXI300rKYYGw9DRPf2aSv67hxuCZPTOQHNF69q+4ARTbk0RJamW23dKHj7vcmw
 oTGw==
X-Gm-Message-State: AOJu0YwyfQlD4m9sc438ccjE/HIdl301O43ADuoWUmrgx1MDP6AvhH5k
 +zwGo4nHyXBdZ28UKyB7hXqQZ1EdkNNMsNeVW7TnvcveVQNgrE91YThkkayK0ffMSWJuBTuAR4g
 IDsYAClKRPJhAvVlBuFSUERxHwEgcskzaXn/qPB4Cww0OtuQoUx9+Fp6lzHDP710OwHky70NAQd
 jvwfHkdQ==
X-Gm-Gg: AfdE7ckjuDG3reKgK2MI9YniLa8SRautEr8QaB/WfCKcIDpCiMx9qIzAWJpRQDueTqR
 H+DIjWVxlnNkdIb6xgT8OaV+ORF9eDMnpJw84QMZK88/4v1tLJTU3ODnlyup2PQKGzuIhMxrVmQ
 SAF89FQbCqqhQIz8G1h1Wwf7UD9S1VViPilzqge4tEL/2fpDa14lniLCkWotpxRKe7w3Sahc+FT
 kSFMcLKU/rfMurJp6kMLG2Gno0l7CvD7f+ULb2RXHzZ3+3ZM6YKvjSFV7IWwtJK3ZPDMp7BJTus
 34NJ9ZglkupcNW+uRBTUnw9R7xCmWwogJVxNuP05iPODcYkLSkkTBQCu18pyIUmgvfYrSS3cvHH
 rNs+//pSJqq2EadPIAAfLKNetYWGpxStyOojEyW+nLgEOQgfYkTff1zeimc5VuRAiAiTKwOv9RM
 RwkvUgBkjRoG3+k4p1/Hcc5U8gA3ocBsIXwLnpq+VuC2LNRnFH+4j8JWm2cbnPbAMG3cWXmWXcO
 YjwhOtkZdSucFD3vKlfsnI8EUFE1hmlw17+1oRVmJjhZUWMmzOBYrk3V+qmfFYAJIYQSs4SQPkH
 JAs=
X-Received: by 2002:a05:6000:250e:b0:473:a376:815e with SMTP id
 ffacd0b85a97d-473a37681edmr3896752f8f.33.1782719939773; 
 Mon, 29 Jun 2026 00:58:59 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4701835b625sm25619657f8f.36.2026.06.29.00.58.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 00:58:59 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 29 Jun 2026 07:58:59 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: If04ce09d4c353f5384c0c48f48f63e05869a373f
X-Gerrit-Change-Number: 1745
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1745?usp=email>
X-Gerrit-Commit: 37dc5fef7fc916feb3d6c8b3ed6576111ddcc2f4
References: <gerrit.1782719911000.If04ce09d4c353f5384c0c48f48f63e05869a373f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklmMDRjZTA5ZDRjMzUzZjUzODRjMGM0OGY0OGY2M2UwNTg2OWEzNzNmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2c8e59c48c6f3aa081eb36757515bd21f5f753eb-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1we6tb-0008Na-1X
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
 openvpn-devel@lists.sourceforge.net
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7358202814060382212=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7358202814060382212==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+RpeiVA35+4="; charset=UTF-8

--+RpeiVA35+4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1745?usp=3Demail

to review the following change=2E


Chang=
e subject: oob: Add client PROBE_REPLY parser
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Add client PROBE_REPLY parser

Add =
oob_client_reply_read(), the client-side counterpart of
oob_server_probe_re=
ad(): it scans the TLV payload of a received PROBE_REPLY
for the probe_repl=
y TLV, skipping other/future TLV types=2E

Factor the shared TLV scan used =
by both into a static oob_find_tlv() helper
so the two readers no longer du=
plicate the loop=2E

Change-Id: If04ce09d4c353f5384c0c48f48f63e05869a373f
S=
igned-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M src/openvpn/oob=2Ec
M =
src/openvpn/oob=2Eh
M tests/unit_tests/openvpn/test_oob=2Ec
3 files changed=
, 130 insertions(+), 15 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/45/1745/1

diff --git a/src/openvpn/oob=
=2Ec b/src/openvpn/oob=2Ec
index f7af0ef=2E=2E9cc7c42 100644
--- a/src/open=
vpn/oob=2Ec
+++ b/src/openvpn/oob=2Ec
@@ -160,31 +160,28 @@
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
-    /* A TLV header is 4 bytes (type + l=
ength)=2E Loop until we either find the
-     * probe_parameter or run out =
of well-formed TLVs=2E */
+    /* A TLV header is 4 bytes (type + length)=
=2E */
     while (BLEN(payload) >=3D 4)
     {
         uint16_t type;
   =
      bool optional;
-        uint16_t value_len;
-        if (!oob_tlv_rea=
d_header(payload, &type, &optional, &value_len))
+        if (!oob_tlv_read=
_header(payload, &type, &optional, value_len))
         {
             retu=
rn false;
         }
-        if (type =3D=3D OOB_TLV_PROBE_PARAMETER)
+   =
     if (type =3D=3D wanted_type)
         {
-            return oob_probe_=
parameter_read(payload, param, value_len);
+            return true;
      =
   }
-        /* not the TLV we are looking for: skip its value and keep sc=
anning */
-        if (!buf_advance(payload, value_len))
+        /* not th=
e TLV we want: skip its value and keep scanning */
+        if (!buf_advanc=
e(payload, *value_len))
         {
             return false;
         }
@@=
 -193,12 +190,30 @@
 }
 
 bool
+oob_server_probe_read(struct buffer *payloa=
d, struct oob_probe_parameter *param)
+{
+    uint16_t value_len;
+    retu=
rn oob_msg_read_header(payload, OOB_MSG_SERVER_PROBE)
+           && oob_fi=
nd_tlv(payload, OOB_TLV_PROBE_PARAMETER, &value_len)
+           && oob_pro=
be_parameter_read(payload, param, value_len);
+}
+
+bool
 oob_client_reply_=
write(struct buffer *buf, const struct oob_probe_reply *reply)
 {
     retu=
rn oob_msg_write_header(buf, OOB_MSG_PROBE_REPLY) && oob_probe_reply_write(=
buf, reply);
 }
 
 bool
+oob_client_reply_read(struct buffer *payload, stru=
ct oob_probe_reply *reply)
+{
+    uint16_t value_len;
+    return oob_msg_=
read_header(payload, OOB_MSG_PROBE_REPLY)
+           && oob_find_tlv(paylo=
ad, OOB_TLV_PROBE_REPLY, &value_len)
+           && oob_probe_reply_read(pa=
yload, reply, value_len);
+}
+
+bool
 oob_timestamp_in_window(uint64_t prob=
e_ts, uint64_t now, uint64_t window_secs)
 {
     uint64_t diff =3D (now > =
probe_ts) ? (now - probe_ts) : (probe_ts - now);
diff --git a/src/openvpn/o=
ob=2Eh b/src/openvpn/oob=2Eh
index 93c44b0=2E=2E9040416 100644
--- a/src/op=
envpn/oob=2Eh
+++ b/src/openvpn/oob=2Eh
@@ -170,6 +170,19 @@
 bool oob_clie=
nt_reply_write(struct buffer *buf, const struct oob_probe_reply *reply);
 
=
 /**
+ * Read a received OOB PROBE_REPLY: verify its message-type header, t=
hen scan
+ * for the probe_reply TLV; the client-side counterpart of
+ * oo=
b_server_probe_read()=2E TLV types other than probe_reply are skipped=2E
+ =
* @p payload is consumed as it is read=2E
+ *
+ * @param payload  buffer po=
sitioned at the start of the OOB message payload
+ * @param reply    filled=
 with the parsed probe_reply on success
+ * @return true if the header matc=
hed and a well-formed probe_reply was found,
+ *         false otherwise
+ =
*/
+bool oob_client_reply_read(struct buffer *payload, struct oob_probe_rep=
ly *reply);
+
+/**
  * Check whether a probe timestamp is within an accepta=
ble window around the
  * current time=2E Used to cheaply drop replayed or =
implausibly-timed probes
  * before doing any further work (see the probe_p=
arameter timestamp rationale
diff --git a/tests/unit_tests/openvpn/test_oob=
=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec
index a9998d2=2E=2E1029399 100=
644
--- a/tests/unit_tests/openvpn/test_oob=2Ec
+++ b/tests/unit_tests/open=
vpn/test_oob=2Ec
@@ -346,6 +346,89 @@
     gc_free(&gc);
 }
 
+/* A PROBE_R=
EPLY carrying a probe_reply is found by the client scan, with all
+ * field=
s surviving=2E */
+static void
+test_client_reply_read_finds_reply(void **s=
tate)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D a=
lloc_buf_gc(128, &gc);
+
+    struct oob_probe_reply in =3D {
+        =2Ep=
riority =3D 5,
+        =2Eweight =3D 50,
+        =2Econnect_lifetime =3D =
120,
+        =2Eflags =3D 1,
+    };
+    memcpy(in=2Epeer_session_id=2Eid=
, "SRVREPLY", SID_SIZE);
+    assert_true(oob_client_reply_write(&buf, &in)=
);
+
+    struct oob_probe_reply out =3D { 0 };
+    assert_true(oob_client=
_reply_read(&buf, &out));
+    assert_memory_equal(out=2Epeer_session_id=2E=
id, in=2Epeer_session_id=2Eid, SID_SIZE);
+    assert_int_equal(out=2Eprior=
ity, in=2Epriority);
+    assert_int_equal(out=2Eweight, in=2Eweight);
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
+    assert_true(oob_msg_w=
rite_header(&buf, OOB_MSG_PROBE_REPLY));
+    assert_true(oob_tlv_write_hea=
der(&buf, 0x7ff, false, 4));
+    assert_true(buf_write_u32(&buf, 0xabad1de=
a));
+    struct oob_probe_reply in =3D { =2Epriority =3D 7 };
+    assert_=
true(oob_probe_reply_write(&buf, &in));
+
+    struct oob_probe_reply out =
=3D { 0 };
+    assert_true(oob_client_reply_read(&buf, &out));
+    assert=
_int_equal(out=2Epriority, 7);
+
+    gc_free(&gc);
+}
+
+/* A payload with=
 no probe_reply is rejected=2E */
+static void
+test_client_reply_read_miss=
ing(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buff=
er buf =3D alloc_buf_gc(128, &gc);
+
+    assert_true(oob_msg_write_header(=
&buf, OOB_MSG_PROBE_REPLY));
+    assert_true(oob_tlv_write_header(&buf, 0x=
7ff, false, 4));
+    assert_true(buf_write_u32(&buf, 0));
+
+    struct oo=
b_probe_reply out =3D { 0 };
+    assert_false(oob_client_reply_read(&buf, =
&out));
+
+    gc_free(&gc);
+}
+
+/* Likewise, a PROBE_REPLY reader reject=
s a payload with the wrong message
+ * type even when a valid probe_reply T=
LV follows=2E */
+static void
+test_client_reply_read_wrong_msg_type(void *=
*state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D=
 alloc_buf_gc(128, &gc);
+
+    assert_true(oob_msg_write_header(&buf, OOB_=
MSG_SERVER_PROBE));
+    struct oob_probe_reply in =3D { =2Epriority =3D 7 =
};
+    assert_true(oob_probe_reply_write(&buf, &in));
+
+    struct oob_pr=
obe_reply out =3D { 0 };
+    assert_false(oob_client_reply_read(&buf, &out=
));
+
+    gc_free(&gc);
+}
+
 int
 main(void)
 {
@@ -365,6 +448,10 @@
    =
     cmocka_unit_test(test_build_probe_reply_valid),
         cmocka_unit_t=
est(test_build_probe_reply_stale),
         cmocka_unit_test(test_build_pro=
be_reply_no_parameter),
+        cmocka_unit_test(test_client_reply_read_fi=
nds_reply),
+        cmocka_unit_test(test_client_reply_read_skips_unknown)=
,
+        cmocka_unit_test(test_client_reply_read_missing),
+        cmock=
a_unit_test(test_client_reply_read_wrong_msg_type),
     };
 
     return c=
mocka_run_group_tests_name("oob tests", tests, NULL, NULL);

-- 
To view, v=
isit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1745?usp=3Demail
To unsubscr=
ibe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn=

Gerrit-Branch: master
Gerrit-Change-Id: If04ce09d4c353f5384c0c48f48f63e058=
69a373f
Gerrit-Change-Number: 1745
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <=
lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerr=
it-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--+RpeiVA35+4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1745?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">oo=
b: Add client PROBE_REPLY parser<br><br>Add oob_client_reply_read(), the cl=
ient-side counterpart of<br>oob_server_probe_read(): it scans the TLV paylo=
ad of a received PROBE_REPLY<br>for the probe_reply TLV, skipping other/fut=
ure TLV types=2E<br><br>Factor the shared TLV scan used by both into a stat=
ic oob_find_tlv() helper<br>so the two readers no longer duplicate the loop=
=2E<br><br>Change-Id: If04ce09d4c353f5384c0c48f48f63e05869a373f<br>Signed-o=
ff-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M src/openvpn/oob=
=2Ec<br>M src/openvpn/oob=2Eh<br>M tests/unit_tests/openvpn/test_oob=2Ec<br=
>3 files changed, 130 insertions(+), 15 deletions(-)<br><br></pre><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/45/17=
45/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec</span><=
br><span>index f7af0ef=2E=2E9cc7c42 100644</span><br><span>--- a/src/openvp=
n/oob=2Ec</span><br><span>+++ b/src/openvpn/oob=2Ec</span><br><span>@@ -160=
,31 +160,28 @@</span><br><span>            &amp;&amp; oob_probe_parameter_w=
rite(buf, param);</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-bool</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-oob_server_probe_read(struct buffer *payload, struct oob_pr=
obe_parameter *param)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/* Scan @p payload for the first TLV of type @p wanted_type, skipping any=
 other</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * (e=2Eg=2E =
future) TLV types=2E On success @p payload is left positioned at that</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * TLV&#39;s value and *v=
alue_len is its declared length=2E Returns false if the TLV</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * is not found or a header/length =
is malformed=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_find_=
tlv(struct buffer *payload, uint16_t wanted_type, uint16_t *value_len)</spa=
n><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if =
(!oob_msg_read_header(payload, OOB_MSG_SERVER_PROBE))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        return false;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* A TLV header i=
s 4 bytes (type + length)=2E Loop until we either find the</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-     * probe_parameter or run out of w=
ell-formed TLVs=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* A TLV header is 4 bytes (type + length)=2E */</span><br><span>    =
 while (BLEN(payload) &gt;=3D 4)</span><br><span>     {</span><br><span>   =
      uint16_t type;</span><br><span>         bool optional;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        uint16_t value_len;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        if (!oob_tlv_read_head=
er(payload, &amp;type, &amp;optional, &amp;value_len))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (!oob_tlv_read_header(payload=
, &amp;type, &amp;optional, value_len))</span><br><span>         {</span><b=
r><span>             return false;</span><br><span>         }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        if (type =3D=3D OOB_TLV_PRO=
BE_PARAMETER)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if (type =3D=3D wanted_type)</span><br><span>         {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            return oob_probe_parameter_=
read(payload, param, value_len);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            return true;</span><br><span>         }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        /* not the TLV we are lo=
oking for: skip its value and keep scanning */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        if (!buf_advance(payload, value_len))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* not the TLV w=
e want: skip its value and keep scanning */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if (!buf_advance(payload, *value_len))</spa=
n><br><span>         {</span><br><span>             return false;</span><br=
><span>         }</span><br><span>@@ -193,12 +190,30 @@</span><br><span> }<=
/span><br><span> </span><br><span> bool</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+oob_server_probe_read(struct buffer *payload, struct oo=
b_probe_parameter *param)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t=
 value_len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retu=
rn oob_msg_read_header(payload, OOB_MSG_SERVER_PROBE)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; oob_find_tlv(payloa=
d, OOB_TLV_PROBE_PARAMETER, &amp;value_len)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+           &amp;&amp; oob_probe_parameter_read(payl=
oad, param, value_len);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span> oob_client_=
reply_write(struct buffer *buf, const struct oob_probe_reply *reply)</span>=
<br><span> {</span><br><span>     return oob_msg_write_header(buf, OOB_MSG_=
PROBE_REPLY) &amp;&amp; oob_probe_reply_write(buf, reply);</span><br><span>=
 }</span><br><span> </span><br><span> bool</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+oob_client_reply_read(struct buffer *payload, struct=
 oob_probe_reply *reply)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t =
value_len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retur=
n oob_msg_read_header(payload, OOB_MSG_PROBE_REPLY)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; oob_find_tlv(payloa=
d, OOB_TLV_PROBE_REPLY, &amp;value_len)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+           &amp;&amp; oob_probe_reply_read(payload, rep=
ly, value_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span> oob_timestamp_in_wi=
ndow(uint64_t probe_ts, uint64_t now, uint64_t window_secs)</span><br><span=
> {</span><br><span>     uint64_t diff =3D (now &gt; probe_ts) ? (now - pro=
be_ts) : (probe_ts - now);</span><br><span>diff --git a/src/openvpn/oob=2Eh=
 b/src/openvpn/oob=2Eh</span><br><span>index 93c44b0=2E=2E9040416 100644</s=
pan><br><span>--- a/src/openvpn/oob=2Eh</span><br><span>+++ b/src/openvpn/o=
ob=2Eh</span><br><span>@@ -170,6 +170,19 @@</span><br><span> bool oob_clien=
t_reply_write(struct buffer *buf, const struct oob_probe_reply *reply);</sp=
an><br><span> </span><br><span> /**</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * Read a received OOB PROBE_REPLY: verify its message-type=
 header, then scan</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* for the probe_reply TLV; the client-side counterpart of</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * oob_server_probe_read()=2E TLV typ=
es other than probe_reply are skipped=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @p payload is consumed as it is read=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @param payload  buffer positioned at the star=
t of the OOB message payload</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param reply    filled with the parsed probe_reply on success</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return true if th=
e header matched and a well-formed probe_reply was found,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *         false otherwise</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+bool oob_client_reply_read(struct buffer *payl=
oad, struct oob_probe_reply *reply);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
*</span><br><span>  * Check whether a probe timestamp is within an acceptab=
le window around the</span><br><span>  * current time=2E Used to cheaply dr=
op replayed or implausibly-timed probes</span><br><span>  * before doing an=
y further work (see the probe_parameter timestamp rationale</span><br><span=
>diff --git a/tests/unit_tests/openvpn/test_oob=2Ec b/tests/unit_tests/open=
vpn/test_oob=2Ec</span><br><span>index a9998d2=2E=2E1029399 100644</span><b=
r><span>--- a/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>+++ b/t=
ests/unit_tests/openvpn/test_oob=2Ec</span><br><span>@@ -346,6 +346,89 @@</=
span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A PROBE_REPLY car=
rying a probe_reply is found by the client scan, with all</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * fields surviving=2E */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+test_client_reply_read_finds_reply(void=
 **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D g=
c_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct oob_probe_reply in =3D {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        =2Epriority =3D 5,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        =2Eweight =3D 50,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        =2Econnect_lifetime =3D 120,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Eflags =3D 1,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    memcpy(in=2Epeer_session_id=
=2Eid, &quot;SRVREPLY&quot;, SID_SIZE);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_true(oob_client_reply_write(&amp;buf, &amp;i=
n));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_reply out =3D=
 { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_t=
rue(oob_client_reply_read(&amp;buf, &amp;out));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_memory_equal(out=2Epeer_session_id=
=2Eid, in=2Epeer_session_id=2Eid, SID_SIZE);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_int_equal(out=2Epriority, in=2Epriority=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_eq=
ual(out=2Eweight, in=2Eweight);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_int_equal(out=2Econnect_lifetime, in=2Econnect_lifet=
ime);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int=
_equal(out=2Eflags, in=2Eflags);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc=
_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* TLVs other than probe_reply are skippe=
d=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_client_reply_re=
ad_skips_unknown(void **state)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_true(oob_msg_write_header(&amp;buf, OOB=
_MSG_PROBE_REPLY));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_true(oob_tlv_write_header(&amp;buf, 0x7ff, false, 4));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32=
(&amp;buf, 0xabad1dea));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct oob_probe_reply in =3D { =2Epriority =3D 7 };</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_probe_reply_w=
rite(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oo=
b_probe_reply out =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_true(oob_client_reply_read(&amp;buf, &amp;out));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(out=
=2Epriority, 7);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/* A payload with no probe_reply is rejected=2E */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+test_client_reply_read_missing(voi=
d **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D =
gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_true(oob_msg_write_header(&amp;buf, OOB_MSG_PROBE_REPLY));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_=
tlv_write_header(&amp;buf, 0x7ff, false, 4));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;buf, 0));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_reply out =3D { 0 };=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(oo=
b_client_reply_read(&amp;buf, &amp;out));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/* Likewise, a PROBE_REPLY reade=
r rejects a payload with the wrong message</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * type even when a valid probe_reply TLV follows=2E=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+test_client_reply_read_w=
rong_msg_type(void **state)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_true(oob_msg_write_header(&amp;buf, OOB_MS=
G_SERVER_PROBE));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct oob_probe_reply in =3D { =2Epriority =3D 7 };</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_probe_reply_write(&a=
mp;buf, &amp;in));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe=
_reply out =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_false(oob_client_reply_read(&amp;buf, &amp;out));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span> int</span><br><span> main(void)</span><br><span> =
{</span><br><span>@@ -365,6 +448,10 @@</span><br><span>         cmocka_unit=
_test(test_build_probe_reply_valid),</span><br><span>         cmocka_unit_t=
est(test_build_probe_reply_stale),</span><br><span>         cmocka_unit_tes=
t(test_build_probe_reply_no_parameter),</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        cmocka_unit_test(test_client_reply_read_finds_r=
eply),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmock=
a_unit_test(test_client_reply_read_skips_unknown),</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_client_reply_r=
ead_missing),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  cmocka_unit_test(test_client_reply_read_wrong_msg_type),</span><br><span>=
     };</span><br><span> </span><br><span>     return cmocka_run_group_test=
s_name(&quot;oob tests&quot;, tests, NULL, NULL);</span><br><span></span><b=
r></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1745?usp=3Demail">change 1745</a>=2E To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1745?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div=
>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Id: If04ce09d4c353f5384c0c48f48f63e05869a373f <=
/div>
<div style=3D"display:none"> Gerrit-Change-Number: 1745 </div>
<div s=
tyle=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none=
"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-d=
evel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body><=
/html>
--+RpeiVA35+4=--


--===============7358202814060382212==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7358202814060382212==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7358202814060382212==--

