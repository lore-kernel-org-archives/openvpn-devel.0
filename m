Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45144CA5FC1
	for <openvpn-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uRShQjFxn53QEn+Yiz61sz8WcK/WEyRZmb78Hr/8UQQ=; b=IfsrtvL5Fps79LHJhi4O1jp7Lc
	PNgldCX6QSUlc6d1iZpwH4YLZm2SuR5auLJiAg/yPdd47vNVyuxdS3lTecqB1QKlEdRtvQGCz3NL5
	vFJkxIW/afrqkRVjqYin+kf5Q4KyHaDZ+mroxR66xq5SfRq0P1vnPZKoYbTU4K+IhVa0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBpe2-0003Gk-AO;
	Wed, 30 Sep 2026 08:26:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBpdT-0003DV-Bj
 for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 08:25:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=7ixJq6h5Vnc5vutUptsEj0fMk3yuXS5rwLvLlMeqqTM=; b=PajCip8t0JdtUdBmh9MawRK6Pr
 ia65pEKX+XwzgQx/amMvfQEYx7gT7OX4WYhfNOrRAPMRMMF+S1E7u8B3oMAR3ABAGV6gnr90rtAjF
 Colhwncy1PQaUGozDQaFW2eSjdRt4Hf9+sCi0tpz5/cKLNA0A+Cl7lzgpOWAuMFpbeM4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=7ixJq6h5Vnc5vutUptsEj0fMk3yuXS5rwLvLlMeqqTM=; b=R
 rY2IbGVTXdx/7rjAFZ6vWvJvUva/e6PxQSU94LIatMVgJx6tGFT3GCMRuBXXSRYlGSLSprZREDy/Q
 gaS/Ic+HBk9S2ZESw7AJKeQGmN3Cfb/9wGID6rD5O0bhDOu+iT/UelUiVlAqfuGBKC+Kyl+USASB6
 poPhfRPcQGdJUoPo=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBpdO-0005nH-Gr for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 08:25:52 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49b912d37b6so27703005e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 30 Sep 2026 01:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790756744; x=1791361544; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7ixJq6h5Vnc5vutUptsEj0fMk3yuXS5rwLvLlMeqqTM=;
 b=E2oaieG04axpYfHUkwElDCvQ3lqGwBNEaWaXUzK+Lm6DEUplOvIQIn/S5MIVoQhoXl
 AWpQCghUEzxf3WH+JBzuCYEeQfn3bqL/W/+88UgQ+UYVKLeEXbNbMbtAf6PUKMxGxsTP
 mQC+WYOr5nsfjFnlXhbc+TUxWBmcykw+J0H9ikzEmmQiSqm9de/OmWkvX63P6oLZKFSJ
 W1aVaFFfapr2MWRTJ6PtHRV6mWEiRCUb422+dTGqKdHytMKNw4Gk8Xtq1ZQgElol0adF
 gbWGA6SLU82txH5/37AkMBrLqpMwueKI3/VQCwHleISXi0jLBczSZa4he32n/iH+VXxO
 HvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790756744; x=1791361544;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7ixJq6h5Vnc5vutUptsEj0fMk3yuXS5rwLvLlMeqqTM=;
 b=pU36L/isuC+0JDPhOFP6z3QO2FWz61mC2hMbXpy+cd9hV/UdBt+REGVi0Wgvdxpphh
 Pitq2VZbrqyOwWOfmdSuWxF6VmvzQ65Y+TNbPjfCHhHU+xyzV+aFZ9n3G4o+UxXC0B6I
 WCBVWCM/vPMnB4HII1rw6dzhzo9hZzvMB/IFPL24crUDC+k2dqRCquBU0s8M8F8aKB3i
 1LgaYIG7iETSaubodbN7QRCqiozKeUdSb7LTBdILki2Luih0HuRv1j7qPvn/suGo4ZG5
 0BfeUwMZhMtM4NSpo0TDsE3GkLxZnYGE5r0ZDL8H7zxk0jWjYbYczxtNyi3xv7lBGt6I
 d7KQ==
X-Gm-Message-State: AFuF++k1cxFkUf1so8uWebzH8wzfdCZTqbJZOaN3U0ASyB6G1Qd34z7F
 U1yJCYNmA31RJ0V7znpTnu7KpJDr/lWGlGWv4CJOKL+OGMLQqVySq3JiNP1Xo0TDzljUkVWd5FY
 ylQtR4yKS9Ns1sqCKqmGtO2m7SwloATS04K5rJaMncQCuq9mbE/T9QKgWP02lXHq7/v2T
X-Gm-Gg: AYBFou20eX7loNoqPPb+WBIclS1J+tOtXaDyhKtpluL5k1tWYYx12CptFOHcB1nrwdM
 xvetYJHPfePsJZmT12wJXzFFXYUA90zPm2ehxVKgpUqelps673tRV6wyTiN1TL66hBO3rYoTF1v
 WsWt95bmY9rgcUXIoPUnKxaJ5gS/1oYyKAeWGQH6Fmz1VeMwDKi+S/sdGmGvJTgyHGCv/m3kwpM
 dcqmO5LbOE2tTygqPNCcUT/zucmhvcoNVnAusCPJ3tCuzsoGqJIpq4YeJYeVOX0VPKdSyN27slV
 LoWfr+xrVLC2CwvYbFKFKp6G+RY6ephXPxXRRhP5rE56tHwD+Xe1jJRH2GCN1fXX6oEjg6ZA4WC
 xjkk7h3F1jBITRm/7MSaFiY27BlXBXtXoSP91Ec8Hxq8jS6pvkzWhK1tt7nEYQzTpj5JBOZxQms
 aIkOh+I9EcjYcV9tBZlJ3mF1SOWafj0HiqVHdbsbFAR/2jH0qY6uLL6PUxEXGK0UaPrQJVDpH0y
 A4NoFBTD4Aq60bf2DdGulh3iStG2pm3CtHf0zVUPkA9vxeO4BFIqPn9Lr9GqRuwz00y4RA7D8sk
 gTlEMH8uSrS5pRl/mzOLoF7DWp5MlnKVU/h6o1rsrSnpSFY3ER0aWyuGCMeD5rHTdBor4T4=
X-Received: by 2002:a05:600d:82e1:b0:4a0:313:3a12 with SMTP id
 5b1f17b1804b1-4a01b1162d3mr10981715e9.20.1790756743786; 
 Wed, 30 Sep 2026 01:25:43 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b02949cf1sm1735455f8f.5.2026.09.30.01.25.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 01:25:43 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 30 Sep 2026 08:25:29 +0000
To: ralf_lici <ralf@mandelbit.com>, plaisthos <arne-openvpn@rfc2549.org>,
 flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 19
X-Gerrit-Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30
X-Gerrit-Change-Number: 1742
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1742?usp=email>
X-Gerrit-Commit: 970640f977539543ecd8fe58ab07cc900cc4669e
In-Reply-To: <gerrit.1782719911000.Iafa9efc1c156974ad9f5752e9de810a8c2f68c30@gerrit.openvpn.net>
References: <gerrit.1782719911000.Iafa9efc1c156974ad9f5752e9de810a8c2f68c30@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklhZmE5ZWZjMWMxNTY5NzRhZDlmNTc1MmU5ZGU4MTBhOGMyZjY4YzMwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8f62c1db1c5cbd60191a05b51eadb424c618bb6d-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBpdO-0005nH-Gr
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Add probe
 request parsing and the probe-reply decision
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
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, frank@lichtenheld.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7540606256938606627=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7540606256938606627==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="psTWkxJu53U="; charset=UTF-8

--psTWkxJu53U=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, ralf_lici=2E=


Hello flichtenheld, plaisthos, ralf_lici, 

I'd like you to reexamine a c=
hange=2E Please visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?u=
sp=3Demail

to look at the new patch set (#19)=2E


Change subject: oob: Ad=
d probe request parsing and the probe-reply decision
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Add probe request parsing and=
 the probe-reply decision

Add the message-level helpers the server needs t=
o answer a probe:
oob_probe_request_find() for the probe request TLV,
oob_t=
imestamp_in_window() for the replay/skew check on its timestamp,
and oob_pr=
obe_request_check(), which combines the two and classifies a
received probe=
 as invalid, stale or OK=2E

The reader returns the probe request, whose re=
quest_id the reply
echoes, so a client can tell which of its probes a reply=
 answers=2E

A stale probe, one whose timestamp is outside the window, is r=
eported
separately rather than dropped: the timestamp lets a server drop
re=
played requests, but a client with a skewed clock sends the same
thing, so =
the server path decides (a follow-up answers a few per
period)=2E The windo=
w itself is the caller's choice; the server path
passes --hand-window=2E

T=
hese are pure functions exercised by unit tests; the server packet
path use=
s them in a follow-up and builds and sends the reply itself=2E

Change-Id: =
Iafa9efc1c156974ad9f5752e9de810a8c2f68c30
Signed-off-by: Lev Stipakov <lev@=
openvpn=2Enet>
---
M src/openvpn/oob=2Ec
M src/openvpn/oob=2Eh
M tests/unit=
_tests/openvpn/test_oob=2Ec
3 files changed, 271 insertions(+), 0 deletions=
(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/42=
/1742/19

diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec
index 5f62=
4be=2E=2E954694a 100644
--- a/src/openvpn/oob=2Ec
+++ b/src/openvpn/oob=2Ec=

@@ -83,3 +83,30 @@
     r->flags =3D (uint16_t)buf_read_u16(buf);
     ret=
urn true;
 }
+
+bool
+oob_probe_request_find(struct buffer *payload, struct=
 oob_probe_request *req)
+{
+    struct buffer value;
+    return ctrl_msg_=
find_tlv(payload, TLV_TYPE_PROBE_REQUEST, &value)
+           && oob_probe_=
request_read(&value, req);
+}
+
+bool
+oob_timestamp_in_window(uint64_t pro=
be_ts, uint64_t now, uint64_t window_secs)
+{
+    uint64_t diff =3D (now >=
 probe_ts) ? (now - probe_ts) : (probe_ts - now);
+    return diff <=3D win=
dow_secs;
+}
+
+enum oob_probe_verdict
+oob_probe_request_check(struct buff=
er *probe_payload, uint64_t now, uint64_t window_secs,
+                   =
     struct oob_probe_request *req)
+{
+    if (!oob_probe_request_find(pro=
be_payload, req))
+    {
+        return OOB_PROBE_INVALID;
+    }
+    ret=
urn oob_timestamp_in_window(req->timestamp, now, window_secs) ? OOB_PROBE_O=
K
+                                                                     : O=
OB_PROBE_STALE;
+}
diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh
i=
ndex e3e4144=2E=2E95b3afc 100644
--- a/src/openvpn/oob=2Eh
+++ b/src/openvp=
n/oob=2Eh
@@ -99,4 +99,49 @@
  */
 bool oob_probe_reply_read(struct buffer =
*buf, struct oob_probe_reply *r);
 
+/**
+ * Scan the payload of a received=
 OOB message for the probe request TLV=2E
+ * Unknown TLV types marked opti=
onal are skipped; an unknown mandatory one
+ * rejects the message=2E paylo=
ad is consumed as it is read=2E
+ *
+ * @param payload  buffer positioned a=
t the start of the OOB message payload
+ * @param req      filled with the =
parsed probe request on success
+ * @return true if a well-formed probe req=
uest was found, false otherwise
+ */
+bool oob_probe_request_find(struct bu=
ffer *payload, struct oob_probe_request *req);
+
+/**
+ * Check whether a p=
robe timestamp is within an acceptable window around the
+ * current time=
=2E Used to cheaply drop replayed or implausibly-timed probes
+ * before do=
ing any further work (see the probe request timestamp rationale
+ * in the =
wire protocol specification)=2E
+ *
+ * @param probe_ts     timestamp from =
the probe request (UNIX seconds)
+ * @param now          current time (UNIX=
 seconds)
+ * @param window_secs  maximum allowed difference, in either dir=
ection
+ * @return true if |now - probe_ts| <=3D window_secs
+ */
+bool oob=
_timestamp_in_window(uint64_t probe_ts, uint64_t now, uint64_t window_secs)=
;
+
+enum oob_probe_verdict
+{
+    OOB_PROBE_INVALID, /**< no valid probe =
request: drop */
+    OOB_PROBE_STALE,   /**< well-formed, timestamp outsid=
e the window */
+    OOB_PROBE_OK,      /**< well-formed, timestamp within =
the window */
+};
+
+/**
+ * Classify a received probe request=2E Combines =
oob_probe_request_find() and
+ * oob_timestamp_in_window()=2E This is the t=
ransport-agnostic decision step;
+ * the caller decides what to do with a s=
tale probe and builds the reply=2E
+ *
+ * @param probe_payload  payload of=
 the received OOB message, consumed
+ * @param now            current time =
(UNIX seconds)
+ * @param window_secs    acceptable timestamp skew, in eith=
er direction
+ * @param req            filled with the probe request unless=
 the verdict is
+ *                       OOB_PROBE_INVALID, for the reply =
to echo its request_id
+ */
+enum oob_probe_verdict oob_probe_request_check=
(struct buffer *probe_payload, uint64_t now,
+                             =
                  uint64_t window_secs, struct oob_probe_request *req);
+
 =
#endif /* OOB_H */
diff --git a/tests/unit_tests/openvpn/test_oob=2Ec b/tes=
ts/unit_tests/openvpn/test_oob=2Ec
index 4e06cfd=2E=2E8af595d 100644
--- a/=
tests/unit_tests/openvpn/test_oob=2Ec
+++ b/tests/unit_tests/openvpn/test_o=
ob=2Ec
@@ -338,6 +338,195 @@
     gc_free(&gc);
 }
 
+/* A payload of just =
a probe request is found by the scan, along with its
+ * request_id=2E */
+=
static void
+test_probe_request_find(void **state)
+{
+    struct gc_arena =
gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    =
const struct oob_probe_request in =3D {
+        =2Erequest_id =3D 42,
+   =
     =2Etimestamp =3D 0x1122334455667788ULL,
+        =2Eflags =3D 0,
+    =
};
+    assert_true(oob_probe_request_write(&buf, &in));
+
+    struct oob_=
probe_request out =3D { 0 };
+    assert_true(oob_probe_request_find(&buf, =
&out));
+    assert_int_equal(out=2Erequest_id, 42);
+    assert_true(in=2E=
timestamp =3D=3D out=2Etimestamp);
+    assert_int_equal(in=2Eflags, out=2E=
flags);
+
+    gc_free(&gc);
+}
+
+/* TLVs other than probe request are ski=
pped, so the scan finds the
+ * probe request even when preceded by an unkn=
own TLV=2E */
+static void
+test_probe_request_find_skips_unknown(void **st=
ate)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D al=
loc_buf_gc(128, &gc);
+
+    /* An unknown but optional TLV (type 0x7ff) =
=2E=2E=2E */
+    assert_true(ctrl_msg_tlv_write_header(&buf, 0x7ff, true, =
4));
+    assert_true(buf_write_u32(&buf, 0xcafef00d));
+    /* =2E=2E=2E f=
ollowed by the real probe request */
+    const struct oob_probe_request in=
 =3D { =2Etimestamp =3D 42, =2Eflags =3D 0 };
+    assert_true(oob_probe_re=
quest_write(&buf, &in));
+
+    struct oob_probe_request out =3D { 0 };
+  =
  assert_true(oob_probe_request_find(&buf, &out));
+    assert_true(out=2Et=
imestamp =3D=3D 42);
+
+    gc_free(&gc);
+}
+
+/* An unknown TLV that is N=
OT marked optional carries something the sender
+ * requires us to act on: =
the whole message is rejected, whether that TLV comes
+ * before or after t=
he one we were looking for=2E */
+static void
+test_probe_request_find_reje=
cts_unknown_mandatory(void **state)
+{
+    struct gc_arena gc =3D gc_new()=
;
+    const struct oob_probe_request in =3D { =2Etimestamp =3D 42, =2Eflag=
s =3D 0 };
+
+    struct buffer before =3D alloc_buf_gc(128, &gc);
+    ass=
ert_true(ctrl_msg_tlv_write_header(&before, 0x7ff, false, 4));
+    assert_=
true(buf_write_u32(&before, 0xcafef00d));
+    assert_true(oob_probe_reques=
t_write(&before, &in));
+
+    struct buffer after =3D alloc_buf_gc(128, &g=
c);
+    assert_true(oob_probe_request_write(&after, &in));
+    assert_tru=
e(ctrl_msg_tlv_write_header(&after, 0x7ff, false, 4));
+    assert_true(buf=
_write_u32(&after, 0xcafef00d));
+
+    struct oob_probe_request out =3D { =
0 };
+    assert_false(oob_probe_request_find(&before, &out));
+    assert_=
false(oob_probe_request_find(&after, &out));
+
+    gc_free(&gc);
+}
+
+/* =
A payload with no probe request must be rejected=2E */
+static void
+test_p=
robe_request_find_missing(void **state)
+{
+    struct gc_arena gc =3D gc_n=
ew();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    assert_true=
(ctrl_msg_tlv_write_header(&buf, 0x7ff, true, 4));
+    assert_true(buf_wri=
te_u32(&buf, 0));
+
+    struct oob_probe_request out =3D { 0 };
+    asser=
t_false(oob_probe_request_find(&buf, &out));
+
+    gc_free(&gc);
+}
+
+/* =
A TLV whose declared length runs past the buffer must be rejected, not
+ * =
read out of bounds=2E */
+static void
+test_probe_request_find_truncated(vo=
id **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf=
 =3D alloc_buf_gc(128, &gc);
+
+    /* TLV header claims a 16-byte value bu=
t no value bytes follow */
+    assert_true(ctrl_msg_tlv_write_header(&buf,=
 0x7ff, false, 16));
+
+    struct oob_probe_request out =3D { 0 };
+    as=
sert_false(oob_probe_request_find(&buf, &out));
+
+    gc_free(&gc);
+}
+
+=
/* A payload carrying a probe reply instead holds no probe request=2E */
+s=
tatic void
+test_probe_request_find_reply_tlv(void **state)
+{
+    struct =
gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc)=
;
+
+    const struct oob_probe_reply in =3D { =2Erequest_id =3D 42 };
+   =
 assert_true(oob_probe_reply_write(&buf, &in));
+
+    struct oob_probe_req=
uest out =3D { 0 };
+    assert_false(oob_probe_request_find(&buf, &out));
=
+
+    gc_free(&gc);
+}
+
+/* Timestamp window check accepts values within =
the window (either direction)
+ * and rejects values outside it=2E */
+stat=
ic void
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
+/* A well-formed probe with an=
 in-window timestamp is answered=2E */
+static void
+test_probe_request_che=
ck_valid(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct=
 buffer buf =3D alloc_buf_gc(128, &gc);
+
+    const uint64_t now =3D 10000=
00;
+    const struct oob_probe_request probe =3D { =2Erequest_id =3D 1, =
=2Etimestamp =3D now, =2Eflags =3D 0 };
+    assert_true(oob_probe_request_=
write(&buf, &probe));
+
+    struct oob_probe_request req =3D { 0 };
+    a=
ssert_int_equal(oob_probe_request_check(&buf, now, 30, &req), OOB_PROBE_OK)=
;
+    assert_int_equal(req=2Erequest_id, 1);
+
+    gc_free(&gc);
+}
+
+/*=
 A well-formed probe whose timestamp is outside the window is stale; the
+ =
* caller decides whether it still gets an answer=2E */
+static void
+test_p=
robe_request_check_stale(void **state)
+{
+    struct gc_arena gc =3D gc_ne=
w();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    const uint64=
_t now =3D 1000000;
+    const struct oob_probe_request probe =3D { =2Erequ=
est_id =3D 7, =2Etimestamp =3D now - 1000, =2Eflags =3D 0 };
+    assert_tr=
ue(oob_probe_request_write(&buf, &probe));
+
+    struct oob_probe_request =
req =3D { 0 };
+    assert_int_equal(oob_probe_request_check(&buf, now, 30,=
 &req), OOB_PROBE_STALE);
+    assert_int_equal(req=2Erequest_id, 7); /* a =
stale probe may still be answered */
+
+    gc_free(&gc);
+}
+
+/* A payloa=
d without a probe request is invalid (no reply)=2E */
+static void
+test_pr=
obe_request_check_no_request(void **state)
+{
+    struct gc_arena gc =3D g=
c_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    assert_t=
rue(ctrl_msg_tlv_write_header(&buf, 0x7ff, true, 4));
+    assert_true(buf_=
write_u32(&buf, 0));
+
+    struct oob_probe_request req;
+    assert_int_e=
qual(oob_probe_request_check(&buf, 1000000, 30, &req), OOB_PROBE_INVALID);
=
+
+    gc_free(&gc);
+}
+
 /* The OOB tests run as a second group of pkt_te=
stdriver; see test_pkt=2Ec=2E */
 int
 run_oob_tests(void)
@@ -353,6 +542,1=
6 @@
         cmocka_unit_test(test_find_tlv_trailing_bytes),
         cmoc=
ka_unit_test(test_find_tlv_skips_optional_after_wanted),
         cmocka_un=
it_test(test_find_tlv_empty_payload),
+        cmocka_unit_test(test_probe_=
request_find),
+        cmocka_unit_test(test_probe_request_find_skips_unkn=
own),
+        cmocka_unit_test(test_probe_request_find_rejects_unknown_man=
datory),
+        cmocka_unit_test(test_probe_request_find_missing),
+     =
   cmocka_unit_test(test_probe_request_find_truncated),
+        cmocka_uni=
t_test(test_probe_request_find_reply_tlv),
+        cmocka_unit_test(test_t=
imestamp_in_window),
+        cmocka_unit_test(test_probe_request_check_val=
id),
+        cmocka_unit_test(test_probe_request_check_stale),
+        cm=
ocka_unit_test(test_probe_request_check_no_request),
     };
 
     return =
cmocka_run_group_tests_name("oob tests", tests, NULL, NULL);

-- 
To view, =
visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail
To unsubsc=
ribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: open=
vpn
Gerrit-Branch: master
Gerrit-Change-Id: Iafa9efc1c156974ad9f5752e9de810=
a8c2f68c30
Gerrit-Change-Number: 1742
Gerrit-PatchSet: 19
Gerrit-Owner: sti=
pa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revi=
ewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-de=
vel@lists=2Esourceforge=2Enet>
Gerrit-Attention: ralf_lici <ralf@mandelbit=
=2Ecom>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Att=
ention: flichtenheld <frank@lichtenheld=2Ecom>

--psTWkxJu53U=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, ralf_lici=2E </p>
<p>stipa <=
strong>uploaded patch set #19</strong> to this change=2E</p><p><a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">oob: Add probe request parsing and the probe-reply decisio=
n<br><br>Add the message-level helpers the server needs to answer a probe:<=
br>oob_probe_request_find() for the probe request TLV,<br>oob_timestamp_in_=
window() for the replay/skew check on its timestamp,<br>and oob_probe_reque=
st_check(), which combines the two and classifies a<br>received probe as in=
valid, stale or OK=2E<br><br>The reader returns the probe request, whose re=
quest_id the reply<br>echoes, so a client can tell which of its probes a re=
ply answers=2E<br><br>A stale probe, one whose timestamp is outside the win=
dow, is reported<br>separately rather than dropped: the timestamp lets a se=
rver drop<br>replayed requests, but a client with a skewed clock sends the =
same<br>thing, so the server path decides (a follow-up answers a few per<br=
>period)=2E The window itself is the caller&#39;s choice; the server path<b=
r>passes --hand-window=2E<br><br>These are pure functions exercised by unit=
 tests; the server packet<br>path uses them in a follow-up and builds and s=
ends the reply itself=2E<br><br>Change-Id: Iafa9efc1c156974ad9f5752e9de810a=
8c2f68c30<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<b=
r>M src/openvpn/oob=2Ec<br>M src/openvpn/oob=2Eh<br>M tests/unit_tests/open=
vpn/test_oob=2Ec<br>3 files changed, 271 insertions(+), 0 deletions(-)<br><=
br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn =
refs/changes/42/1742/19</pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;"><span>diff --git a/src/openvpn/oob=2Ec b/src/open=
vpn/oob=2Ec</span><br><span>index 5f624be=2E=2E954694a 100644</span><br><sp=
an>--- a/src/openvpn/oob=2Ec</span><br><span>+++ b/src/openvpn/oob=2Ec</spa=
n><br><span>@@ -83,3 +83,30 @@</span><br><span>     r-&gt;flags =3D (uint16=
_t)buf_read_u16(buf);</span><br><span>     return true;</span><br><span> }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+oob_probe_request_find(struct buffer *payload, struct =
oob_probe_request *req)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buf=
fer value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retur=
n ctrl_msg_find_tlv(payload, TLV_TYPE_PROBE_REQUEST, &amp;value)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; oob_prob=
e_request_read(&amp;value, req);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+oob_timestamp_in_window(uint64_t probe_=
ts, uint64_t now, uint64_t window_secs)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    uint64_t diff =3D (now &gt; probe_ts) ? (now - probe_ts) : (probe_ts =
- now);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return d=
iff &lt;=3D window_secs;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+enum oob_probe_verdict</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_request_check(struc=
t buffer *probe_payload, uint64_t now, uint64_t window_secs,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                        struct oob=
_probe_request *req)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!oob_prob=
e_request_find(probe_payload, req))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        return OOB_PROBE_INVALID;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    return oob_timestamp_in_window(req-&gt;timestamp, now, window_secs) ?=
 OOB_PROBE_OK</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                                                               : OOB_PROBE_=
STALE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span>diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh</span><br><span=
>index e3e4144=2E=2E95b3afc 100644</span><br><span>--- a/src/openvpn/oob=2E=
h</span><br><span>+++ b/src/openvpn/oob=2Eh</span><br><span>@@ -99,4 +99,49=
 @@</span><br><span>  */</span><br><span> bool oob_probe_reply_read(struct =
buffer *buf, struct oob_probe_reply *r);</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * Scan the payload of a received OOB message for th=
e probe request TLV=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * Unknown TLV types marked optional are skipped; an unknown mandatory o=
ne</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * rejects the me=
ssage=2E payload is consumed as it is read=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param payload  buffer positioned at the start of the OOB messa=
ge payload</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param=
 req      filled with the parsed probe request on success</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @return true if a well-formed prob=
e request was found, false otherwise</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+bool oob_probe_request_find(struct buffer *payload, struct oob_probe_reque=
st *req);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * Check whether a probe timestamp is within =
an acceptable window around the</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * current time=2E Used to cheaply drop replayed or implausibly=
-timed probes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * bef=
ore doing any further work (see the probe request timestamp rationale</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * in the wire protocol s=
pecification)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param probe_ts  =
   timestamp from the probe request (UNIX seconds)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * @param now          current time (UNIX se=
conds)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param win=
dow_secs  maximum allowed difference, in either direction</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @return true if |now - probe_ts| &=
lt;=3D window_secs</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool oob_timestam=
p_in_window(uint64_t probe_ts, uint64_t now, uint64_t window_secs);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+enum oob_probe_verdict</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    OOB_PROBE_INVALID, /**&lt; no valid probe request: drop=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OOB_PROBE_ST=
ALE,   /**&lt; well-formed, timestamp outside the window */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    OOB_PROBE_OK,      /**&lt; well=
-formed, timestamp within the window */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * Classify a received probe req=
uest=2E Combines oob_probe_request_find() and</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * oob_timestamp_in_window()=2E This is the trans=
port-agnostic decision step;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * the caller decides what to do with a stale probe and builds the=
 reply=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param probe_payload  pa=
yload of the received OOB message, consumed</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @param now            current time (UNIX seconds=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param window_s=
ecs    acceptable timestamp skew, in either direction</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param req            filled with the =
probe request unless the verdict is</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *                       OOB_PROBE_INVALID, for the reply t=
o echo its request_id</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+enum oob_probe=
_verdict oob_probe_request_check(struct buffer *probe_payload, uint64_t now=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
                             uint64_t window_secs, struct oob_probe_request=
 *req);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span> #endif /* OOB_H */</span><br><span>diff --git a/tests/unit_tests/open=
vpn/test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>in=
dex 4e06cfd=2E=2E8af595d 100644</span><br><span>--- a/tests/unit_tests/open=
vpn/test_oob=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_oob=2E=
c</span><br><span>@@ -338,6 +338,195 @@</span><br><span>     gc_free(&amp;g=
c);</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/* A payload of just a probe request is found by the s=
can, along with its</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * request_id=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_pro=
be_request_find(void **state)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    const struct oob_probe_request in =3D {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Erequest_id =3D 4=
2,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Etimest=
amp =3D 0x1122334455667788ULL,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        =2Eflags =3D 0,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_true(oob_probe_request_write(&amp;buf, &amp;in));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct oob_probe_request out =3D { 0 };</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_probe_r=
equest_find(&amp;buf, &amp;out));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_int_equal(out=2Erequest_id, 42);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_true(in=2Etimestamp =3D=3D=
 out=2Etimestamp);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_int_equal(in=2Eflags, out=2Eflags);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/* TLVs other than probe req=
uest are skipped, so the scan finds the</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * probe request even when preceded by an unknown TLV=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_probe_request_fi=
nd_skips_unknown(void **state)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* An unknown but optional TLV (type 0x7ff) =
=2E=2E=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_true(ctrl_msg_tlv_write_header(&amp;buf, 0x7ff, true, 4));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&a=
mp;buf, 0xcafef00d));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* =2E=2E=2E followed by the real probe request */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    const struct oob_probe_request in =
=3D { =2Etimestamp =3D 42, =2Eflags =3D 0 };</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_true(oob_probe_request_write(&amp;buf, =
&amp;in));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_request=
 out =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_true(oob_probe_request_find(&amp;buf, &amp;out));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_true(out=2Etimestamp =3D=3D=
 42);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/* An unknown TLV that is NOT marked optional carries something the =
sender</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * requires u=
s to act on: the whole message is rejected, whether that TLV comes</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * before or after the one w=
e were looking for=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tes=
t_probe_request_find_rejects_unknown_mandatory(void **state)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    const struct oob_probe_request =
in =3D { =2Etimestamp =3D 42, =2Eflags =3D 0 };</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct buffer before =3D alloc_buf_gc(128, &amp;gc);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_=
write_header(&amp;before, 0x7ff, false, 4));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;before, 0xcafef=
00d));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tr=
ue(oob_probe_request_write(&amp;before, &amp;in));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct buffer after =3D alloc_buf_gc(128, &amp;gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_probe_r=
equest_write(&amp;after, &amp;in));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;after, 0x7ff=
, false, 4));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_true(buf_write_u32(&amp;after, 0xcafef00d));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct oob_probe_request out =3D { 0 };</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_false(oob_probe_request_find(=
&amp;before, &amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_false(oob_probe_request_find(&amp;after, &amp;out));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* =
A payload with no probe request must be rejected=2E */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+test_probe_request_find_missing(void **state)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =
=3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_true(ctrl_msg_tlv_write_header(&amp;buf, 0x7ff, true, 4));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&a=
mp;buf, 0));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_reque=
st out =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_false(oob_probe_request_find(&amp;buf, &amp;out));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A TLV whose=
 declared length runs past the buffer must be rejected, not</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * read out of bounds=2E */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+test_probe_request_find_truncated(v=
oid **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =
=3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* TLV header claims a 16-byte value but no value bytes follow=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(=
ctrl_msg_tlv_write_header(&amp;buf, 0x7ff, false, 16));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct oob_probe_request out =3D { 0 };</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_false(oob_probe_request=
_find(&amp;buf, &amp;out));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free=
(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/* A payload carrying a probe reply instead ho=
lds no probe request=2E */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+t=
est_probe_request_find_reply_tlv(void **state)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;=
gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    const struct oob_probe_reply i=
n =3D { =2Erequest_id =3D 42 };</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_true(oob_probe_reply_write(&amp;buf, &amp;in));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_request out =3D { 0 =
};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(=
oob_probe_request_find(&amp;buf, &amp;out));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/* Timestamp window check acc=
epts values within the window (either direction)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * and rejects values outside it=2E */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+test_timestamp_in_window(void **sta=
te)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    const uint64_t now =3D 1000000=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint64_t=
 window =3D 30;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_tim=
estamp_in_window(now, now, window));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_true(oob_timestamp_in_window(now - window, now,=
 window));      /* boundary, past */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_true(oob_timestamp_in_window(now + window, now,=
 window));      /* boundary, future */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_false(oob_timestamp_in_window(now - window - =
1, now, window)); /* too old */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_false(oob_timestamp_in_window(now + window + 1, now,=
 window)); /* too far ahead */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/* A well-formed probe wit=
h an in-window timestamp is answered=2E */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+test_probe_request_check_valid(void **state)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_=
gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint64_t no=
w =3D 1000000;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onst struct oob_probe_request probe =3D { =2Erequest_id =3D 1, =2Etimestamp=
 =3D now, =2Eflags =3D 0 };</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_true(oob_probe_request_write(&amp;buf, &amp;probe));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_request req =3D { 0 =
};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_eq=
ual(oob_probe_request_check(&amp;buf, now, 30, &amp;req), OOB_PROBE_OK);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(r=
eq=2Erequest_id, 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/* A well-formed probe whose timestamp is outside the=
 window is stale; the</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * caller decides whether it still gets an answer=2E */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+test_probe_request_check_stale(void **state)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf=
 =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst uint64_t now =3D 1000000;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    const struct oob_probe_request probe =3D { =2Erequest_id =3D =
7, =2Etimestamp =3D now - 1000, =2Eflags =3D 0 };</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_true(oob_probe_request_write(&amp;=
buf, &amp;probe));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe=
_request req =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_int_equal(oob_probe_request_check(&amp;buf, now, 30, &amp;re=
q), OOB_PROBE_STALE);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_int_equal(req=2Erequest_id, 7); /* a stale probe may still be =
answered */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* A payload without a probe request is invalid (no reply)=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_probe_request_ch=
eck_no_request(void **state)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;buf, =
0x7ff, true, 4));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_true(buf_write_u32(&amp;buf, 0));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct oob_probe_request req;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_int_equal(oob_probe_request_check(&amp;buf, 10=
00000, 30, &amp;req), OOB_PROBE_INVALID);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan> /* The OOB tests run as a second group of pkt_testdriver; see test_pkt=
=2Ec=2E */</span><br><span> int</span><br><span> run_oob_tests(void)</span>=
<br><span>@@ -353,6 +542,16 @@</span><br><span>         cmocka_unit_test(te=
st_find_tlv_trailing_bytes),</span><br><span>         cmocka_unit_test(test=
_find_tlv_skips_optional_after_wanted),</span><br><span>         cmocka_uni=
t_test(test_find_tlv_empty_payload),</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        cmocka_unit_test(test_probe_request_find),</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(te=
st_probe_request_find_skips_unknown),</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        cmocka_unit_test(test_probe_request_find_rejects_=
unknown_mandatory),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        cmocka_unit_test(test_probe_request_find_missing),</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_probe_=
request_find_truncated),</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        cmocka_unit_test(test_probe_request_find_reply_tlv),</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test=
_timestamp_in_window),</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        cmocka_unit_test(test_probe_request_check_valid),</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_prob=
e_request_check_stale),</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        cmocka_unit_test(test_probe_request_check_no_request),</span><b=
r><span>     };</span><br><span> </span><br><span>     return cmocka_run_gr=
oup_tests_name(&quot;oob tests&quot;, tests, NULL, NULL);</span><br></pre><=
p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?=
usp=3Demail">change 1742</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail"=
>settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1742?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset=
 </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div st=
yle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30 </div>
<di=
v style=3D"display:none"> Gerrit-Change-Number: 1742 </div>
<div style=3D"d=
isplay:none"> Gerrit-PatchSet: 19 </div>
<div style=3D"display:none"> Gerri=
t-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ralf_l=
ici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<=
div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@mandelbit=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body><=
/html>
--psTWkxJu53U=--


--===============7540606256938606627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7540606256938606627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7540606256938606627==--

