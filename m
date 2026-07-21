Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C5CC4452F
	for <openvpn-devel@archiver.kernel.org>; Tue, 21 Jul 2026 12:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ubLn8zokgcaHv6ZcULbaJcre66eih4lYBlCF9xjCUpk=; b=HsdW6fKshhMSyPjCJCaRJ2KNBS
	0gHbSwNBmBs9c8vWmHTx32qoqkgvsd9UOnxzHFHFp5Q/ddXk9svatAYwB34S3zNrYm2zJc0zqx2Qe
	164ituTulhgPIsXu1OCLru2POR2vB261QnSXYra+ca6Pscufms2DCcaXfplduLHvNSlo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wm9hN-0005q9-IX;
	Tue, 21 Jul 2026 12:35:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wm9hM-0005pv-3n
 for openvpn-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 12:35:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=bMvDXuRmQFXw+YI5zJjXFN1M2IA5O0IxlCmB1i4kawY=; b=RhIxR1PDfSHIF3qveujJWPIprV
 9W7dF96740Cos7scpMyhLJLSW2rOrdPI5TN5OO8Y1J5Al6jHm2R69h5L67/rx3Em01uUGXc4JylRQ
 dkWWk5zvYfnaCcekCOP9ZqJj4oe1S+JqG4McAJuJhUb/TACrYXeGuFJBk6yK/XnM4GaU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=bMvDXuRmQFXw+YI5zJjXFN1M2IA5O0IxlCmB1i4kawY=; b=E
 qz9zLGmGSmNGUhvx/jezCN0413yLSaCtCU+zDJcUT7YoJFLNWvJHY7uE7rACcg7QuX3r3yOL39qOj
 WAgFzRzQjdlLs2d9tNXYdtgCXuUyM3Xlne/YRgRIa2xnmty4Kz0/1t4o1NLtS9BPG1x1fc5rWQU8s
 OnSJfwkWpaCFBIYg=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wm9hK-0001k1-Bb for openvpn-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 12:35:48 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-493f6de72faso34075735e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 21 Jul 2026 05:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784637340; x=1785242140; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bMvDXuRmQFXw+YI5zJjXFN1M2IA5O0IxlCmB1i4kawY=;
 b=JyOKcCfR4hZSna4EiheRboeY9ItM5RrJ+fv4NI2HCtdyGFaaQtThxyXzp0Qnd3cU3O
 jpgTpfupl2bYrESVMSKOcrIFY7tlLrS3XUH+E1nmiuiCXPwXYQaSkEw7faESpI3u8Npp
 tLNSdrzbh7FKqRVTo0SsVknxB7LQ3rh4iHzfAmSMq3ojXT08lwfYVpVGx0O9RXBWnve0
 4wIZFOVYK+xuFTCGyJ2SSj5LWwGdzwT8ZS5NphU0e6oa5n0Bhix2lf7bF7Cpsxf8Bip8
 eSwwXy8TWXOMBatm6t0hIdtnjkFB4hXRGy0zg3gfuvkAlGNmsSJDLIJyu3LLT1wqYwzc
 6Fgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784637340; x=1785242140;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bMvDXuRmQFXw+YI5zJjXFN1M2IA5O0IxlCmB1i4kawY=;
 b=o+7K51QFHuIXZl02DI2CM8aQpIVslF4JnuWYXNuKY3P+z70aHlK6gTnua/VTGHQv8G
 LyxGS4wIqdYU6/ze94A6WTrnZ4L+ZJOYRM/2MfH0e5bUuatbA7yx7ULRVYTfgnt4Z6ac
 +yRtzi6PAuVdhaeOJjFh2XCVi0WvaKGuQuLgJlZReqey26hPo50ZtDLg+N21a5SymFH3
 JwJu8iYnBnGGAUa5uHsrweiYZ4LkOHO0XHyn9UFcJdO1e8RqJ0LLiM0casWmCM/p/gTI
 jEs5hE8SX8rdNPwzHKvGYHAGMICGjb28eLucgljpaxkxP3BZsDnc2nwkuzEN1bE0ffY0
 dKOw==
X-Gm-Message-State: AOJu0Yx3LJl2rf5EKZ0jUZV+mouMU8HXpakDW87vQOf1QBPoyC0UCt6u
 vzMmqn/i4HKJ1ygDhklbm9JjHqxPotScFGgEWbJFeTKhI4bMigxhfieoh2qIrzDlvsxa2aGUl5f
 RhEfNsJ1uNJQ0ct1E6ERTE2OM13XNT7lYniSQAUBV+p0v+iuDVDQ5olCaM3Ek/vpsw7xr
X-Gm-Gg: AfdE7ck4TcGscGS69fDpnmH1K0dymGAMWNasLxv2jWqSE6t/cazHSQJYP+gv/O0rtod
 c+BFcwF2JR21U7P8UgFFjWkAiOR9H0mAmjww4PHV2Yb0v9xWKL8e0g+Q4UYD3X56EMF5LWEi/yS
 xfHG33O2N2idJKOf4oKvvAg0Q1EDR7lYuPJjbBlfK+byOqxjq3sYZt+BMUbzUxEQ+wWG4MDrY7u
 lN/iPIA+B0FEQ4YDx3wx8Mrv+jlogd1dUHYWRHjK8SUkIORxCBA+WMUe66/CwJySH2aFdp6hfXW
 euW3OiwA6Ns/80bWwhMK6MendRbtnH9cL8hqAHbcyKE6x6/uNBbZ8CEeNiw0vcAr7bScMJBCxb5
 BxyM25WccUDu8OzDE62TGbKpwA3oBuJL/9Qk5H726iYzoEULuPGVQUD5vv4ko9ucFvC3h52ZENJ
 WfvAGIpT+uthOMxbrYxBsH8yrNaU7P9FdEz/zc4e/BoXiiBpT2iKy7nebyNL/TnfxrvFRMHMByN
 tMu8uQHc4rzniVs+T53WdtOaj4XYIuQiMMt7GS7r2ZeoTJFX0UmyjQrJ1YtggN8+oz4
X-Received: by 2002:a05:600c:4e8b:b0:495:501a:fcf8 with SMTP id
 5b1f17b1804b1-495501afdc8mr158547465e9.9.1784637339388; 
 Tue, 21 Jul 2026 05:35:39 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956546db86sm65092715e9.2.2026.07.21.05.35.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 05:35:38 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 21 Jul 2026 12:35:24 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30
X-Gerrit-Change-Number: 1742
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1742?usp=email>
X-Gerrit-Commit: 2e79a47e4bad09cf3952c4df0be13742908f2437
In-Reply-To: <gerrit.1782719911000.Iafa9efc1c156974ad9f5752e9de810a8c2f68c30@gerrit.openvpn.net>
References: <gerrit.1782719911000.Iafa9efc1c156974ad9f5752e9de810a8c2f68c30@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklhZmE5ZWZjMWMxNTY5NzRhZDlmNTc1MmU5ZGU4MTBhOGMyZjY4YzMwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7f64a6b9f8199a74a99763bdbf62675e256023da-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wm9hK-0001k1-Bb
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
Content-Type: multipart/mixed; boundary="===============4405221986518233392=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4405221986518233392==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uUce7GTxLYI="; charset=UTF-8

--uUce7GTxLYI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa=2E

He=
llo flichtenheld, plaisthos, 

I'd like you to reexamine a change=2E Please=
 visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail

to =
look at the new patch set (#8)=2E

The following approvals got outdated and=
 were removed:
Code-Review-1 by flichtenheld


Change subject: oob: Add SER=
VER_PROBE parsing and the probe-reply decision
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Add SERVER_PROBE parsing and the pr=
obe-reply decision

Add the message-level helpers the server needs to answe=
r a probe:

  - oob_server_probe_read() scans the TLV payload of a received=
 OOB
    SERVER_PROBE for the probe_parameter TLV, skipping other/future TL=
V
    types and rejecting malformed or truncated input=2E
  - oob_timestamp=
_in_window() performs the cheap replay/skew check on the
    probe timestam=
p described in the wire protocol specification=2E
  - oob_build_probe_reply=
() composes the two: given a received SERVER_PROBE
    it scans for the pro=
be_parameter, drops the probe if it is missing or
    its timestamp is outs=
ide the acceptable window, and otherwise populates
    the probe_reply (ech=
oing the peer's session id) to send back=2E

These are pure functions exerc=
ised by unit tests; the server packet path
calls oob_build_probe_reply() in=
 a follow-up, which performs the actual send=2E

Change-Id: Iafa9efc1c15697=
4ad9f5752e9de810a8c2f68c30
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
=
---
M src/openvpn/oob=2Ec
M src/openvpn/oob=2Eh
M tests/unit_tests/openvpn/=
test_oob=2Ec
3 files changed, 299 insertions(+), 0 deletions(-)


  git pul=
l ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/42/1742/8

diff -=
-git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec
index b01f4ee=2E=2Ea885453=
 100644
--- a/src/openvpn/oob=2Ec
+++ b/src/openvpn/oob=2Ec
@@ -166,3 +166,=
67 @@
     r->max_latency_diff =3D (uint16_t)max_latency_diff;
     return =
oob_skip_trailing(buf, value_len, OOB_PROBE_REPLY_LEN);
 }
+
+bool
+oob_ser=
ver_probe_write(struct buffer *buf, const struct oob_probe_parameter *param=
)
+{
+    return oob_msg_write_header(buf, OOB_MSG_SERVER_PROBE)
+         =
  && oob_probe_parameter_write(buf, param);
+}
+
+bool
+oob_server_probe_re=
ad(struct buffer *payload, struct oob_probe_parameter *param)
+{
+    if (!=
oob_msg_read_header(payload, OOB_MSG_SERVER_PROBE))
+    {
+        return =
false;
+    }
+
+    /* Loop until we either find the probe_parameter or ru=
n out of
+     * well-formed TLVs=2E */
+    uint16_t type;
+    bool optio=
nal;
+    uint16_t value_len;
+    while (oob_tlv_read_header(payload, &typ=
e, &optional, &value_len))
+    {
+        if (type =3D=3D OOB_TLV_PROBE_PA=
RAMETER)
+        {
+            return oob_probe_parameter_read(payload, p=
aram, value_len);
+        }
+        /* not the TLV we are looking for: sk=
ip its value and keep scanning */
+        if (!buf_advance(payload, value_=
len))
+        {
+            return false;
+        }
+    }
+    return f=
alse;
+}
+
+bool
+oob_timestamp_in_window(uint64_t probe_ts, uint64_t now, =
uint64_t window_secs)
+{
+    uint64_t diff =3D (now > probe_ts) ? (now - p=
robe_ts) : (probe_ts - now);
+    return diff <=3D window_secs;
+}
+
+bool
=
+oob_build_probe_reply(struct buffer *probe_payload, uint64_t now, uint64_t=
 window_secs,
+                      const struct session_id *peer_sid, str=
uct oob_probe_reply *reply)
+{
+    struct oob_probe_parameter param;
+    =
if (!oob_server_probe_read(probe_payload, &param))
+    {
+        return f=
alse;
+    }
+
+    /* Drop replayed or implausibly-timed probes before doi=
ng any more work=2E */
+    if (!oob_timestamp_in_window(param=2Etimestamp,=
 now, window_secs))
+    {
+        return false;
+    }
+
+    CLEAR(*repl=
y);
+    reply->peer_session_id =3D *peer_sid;
+    /* priority/weight/conn=
ect_lifetime/flags left at 0 for now */
+    return true;
+}
diff --git a/s=
rc/openvpn/oob=2Eh b/src/openvpn/oob=2Eh
index 6880665=2E=2Ec5d13e4 100644
=
--- a/src/openvpn/oob=2Eh
+++ b/src/openvpn/oob=2Eh
@@ -149,4 +149,56 @@
  =
*/
 bool oob_probe_reply_read(struct buffer *buf, struct oob_probe_reply *r=
, uint16_t value_len);
 
+/**
+ * Write a complete SERVER_PROBE message (me=
ssage-type header + probe_parameter
+ * TLV) to @p buf=2E Sent by the clien=
t=2E
+ */
+bool oob_server_probe_write(struct buffer *buf, const struct oob=
_probe_parameter *param);
+
+/**
+ * Read a received OOB SERVER_PROBE: veri=
fy its message-type header, then scan
+ * for the probe_parameter TLV=2E TL=
V types other than probe_parameter are
+ * skipped, so the scan tolerates a=
dditional/future TLVs=2E @p payload is consumed
+ * as it is read=2E
+ *
+ =
* @param payload  buffer positioned at the start of the OOB message payload=

+ * @param param    filled with the parsed probe_parameter on success
+ * =
@return true if the header matched and a well-formed probe_parameter was
+ =
*         found, false otherwise
+ */
+bool oob_server_probe_read(struct bu=
ffer *payload, struct oob_probe_parameter *param);
+
+/**
+ * Check whether=
 a probe timestamp is within an acceptable window around the
+ * current ti=
me=2E Used to cheaply drop replayed or implausibly-timed probes
+ * before =
doing any further work (see the probe_parameter timestamp rationale
+ * in =
the wire protocol specification)=2E
+ *
+ * @param probe_ts     timestamp f=
rom the probe_parameter (UNIX seconds)
+ * @param now          current time=
 (UNIX seconds)
+ * @param window_secs  maximum allowed difference, in eith=
er direction
+ * @return true if |now - probe_ts| <=3D window_secs
+ */
+bo=
ol oob_timestamp_in_window(uint64_t probe_ts, uint64_t now, uint64_t window=
_secs);
+
+/**
+ * Process the TLV payload of a received SERVER_PROBE and d=
ecide whether to
+ * answer it=2E Combines oob_server_probe_read() and oob_=
timestamp_in_window():
+ * the probe is dropped (false returned) if it has =
no valid probe_parameter or
+ * its timestamp is outside the acceptable win=
dow=2E On success @p reply is
+ * populated with the peer's session id echo=
ed back and the remaining fields
+ * zeroed, ready to be wrapped and sent=
=2E
+ *
+ * This is the transport-agnostic decision step; the caller perfor=
ms the send=2E
+ *
+ * @param probe_payload  TLV payload of the received OO=
B SERVER_PROBE
+ * @param now            current time (UNIX seconds)
+ * @p=
aram window_secs    acceptable timestamp skew, in either direction
+ * @par=
am peer_sid       session id of the requesting peer (echoed in the reply)
+=
 * @param reply          filled with the reply to send on success
+ * @retu=
rn true if a reply should be sent, false to silently drop the probe
+ */
+b=
ool oob_build_probe_reply(struct buffer *probe_payload, uint64_t now, uint6=
4_t window_secs,
+                           const struct session_id *peer_=
sid, struct oob_probe_reply *reply);
+
 #endif /* OOB_H */
diff --git a/tes=
ts/unit_tests/openvpn/test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec
=
index 48dfd6e=2E=2E4412389 100644
--- a/tests/unit_tests/openvpn/test_oob=
=2Ec
+++ b/tests/unit_tests/openvpn/test_oob=2Ec
@@ -192,6 +192,180 @@
    =
 gc_free(&gc);
 }
 
+/* A SERVER_PROBE carrying just a probe_parameter is f=
ound by the scan=2E */
+static void
+test_server_probe_read_finds_parameter=
(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer =
buf =3D alloc_buf_gc(128, &gc);
+
+    const struct oob_probe_parameter in =
=3D {
+        =2Etimestamp =3D 0x1122334455667788ULL,
+        =2Eflags =
=3D 0,
+    };
+    assert_true(oob_server_probe_write(&buf, &in));
+
+    =
struct oob_probe_parameter out =3D { 0 };
+    assert_true(oob_server_probe=
_read(&buf, &out));
+    assert_true(in=2Etimestamp =3D=3D out=2Etimestamp)=
;
+    assert_int_equal(in=2Eflags, out=2Eflags);
+
+    gc_free(&gc);
+}
+=

+/* TLVs other than probe_parameter are skipped, so the scan finds the
+ *=
 probe_parameter even when preceded by an unknown TLV=2E */
+static void
+t=
est_server_probe_read_skips_unknown(void **state)
+{
+    struct gc_arena g=
c =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    /=
* SERVER_PROBE message header, then an unknown TLV (type 0x7ff) =2E=2E=2E *=
/
+    assert_true(oob_msg_write_header(&buf, OOB_MSG_SERVER_PROBE));
+    =
assert_true(oob_tlv_write_header(&buf, 0x7ff, false, 4));
+    assert_true(=
buf_write_u32(&buf, 0xcafef00d));
+    /* =2E=2E=2E followed by the real pr=
obe_parameter */
+    const struct oob_probe_parameter in =3D { =2Etimestam=
p =3D 42, =2Eflags =3D 0 };
+    assert_true(oob_probe_parameter_write(&buf=
, &in));
+
+    struct oob_probe_parameter out =3D { 0 };
+    assert_true(=
oob_server_probe_read(&buf, &out));
+    assert_true(out=2Etimestamp =3D=3D=
 42);
+
+    gc_free(&gc);
+}
+
+/* A payload with no probe_parameter must =
be rejected=2E */
+static void
+test_server_probe_read_missing(void **state=
)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc=
_buf_gc(128, &gc);
+
+    assert_true(oob_msg_write_header(&buf, OOB_MSG_SE=
RVER_PROBE));
+    assert_true(oob_tlv_write_header(&buf, 0x7ff, false, 4))=
;
+    assert_true(buf_write_u32(&buf, 0));
+
+    struct oob_probe_paramet=
er out =3D { 0 };
+    assert_false(oob_server_probe_read(&buf, &out));
+
+=
    gc_free(&gc);
+}
+
+/* A TLV whose declared length runs past the buffer=
 must be rejected, not
+ * read out of bounds=2E */
+static void
+test_serv=
er_probe_read_truncated(void **state)
+{
+    struct gc_arena gc =3D gc_new=
();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    /* TLV header=
 claims a 16-byte value but no value bytes follow */
+    assert_true(oob_m=
sg_write_header(&buf, OOB_MSG_SERVER_PROBE));
+    assert_true(oob_tlv_writ=
e_header(&buf, 0x7ff, false, 16));
+
+    struct oob_probe_parameter out =
=3D { 0 };
+    assert_false(oob_server_probe_read(&buf, &out));
+
+    gc_=
free(&gc);
+}
+
+/* A SERVER_PROBE reader rejects a payload carrying a diff=
erent message type
+ * (here a PROBE_REPLY's), even if it contains a valid =
probe_parameter TLV=2E */
+static void
+test_server_probe_read_wrong_msg_ty=
pe(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffe=
r buf =3D alloc_buf_gc(128, &gc);
+
+    assert_true(oob_msg_write_header(&=
buf, OOB_MSG_PROBE_REPLY));
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
+    struct oob_probe_reply reply;
+    ass=
ert_true(oob_build_probe_reply(&buf, now, 30, &peer, &reply));
+    assert_=
memory_equal(reply=2Epeer_session_id=2Eid, peer=2Eid, SID_SIZE);
+    asser=
t_int_equal(reply=2Epriority, 0);
+    assert_int_equal(reply=2Eweight, 0);=

+    assert_int_equal(reply=2Econnect_lifetime, 0);
+    assert_int_equal(=
reply=2Eflags, 0);
+
+    gc_free(&gc);
+}
+
+/* A probe whose timestamp is=
 outside the window is dropped (no reply)=2E */
+static void
+test_build_pr=
obe_reply_stale(void **state)
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
+    struct session_id peer =3D { 0 };
+    struct oob_pr=
obe_reply reply;
+    assert_false(oob_build_probe_reply(&buf, now, 30, &pe=
er, &reply));
+
+    gc_free(&gc);
+}
+
+/* A payload without a probe_param=
eter is dropped (no reply)=2E */
+static void
+test_build_probe_reply_no_pa=
rameter(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct =
buffer buf =3D alloc_buf_gc(128, &gc);
+
+    assert_true(oob_msg_write_hea=
der(&buf, OOB_MSG_SERVER_PROBE));
+    assert_true(oob_tlv_write_header(&bu=
f, 0x7ff, false, 4));
+    assert_true(buf_write_u32(&buf, 0));
+
+    stru=
ct session_id peer =3D { 0 };
+    struct oob_probe_reply reply;
+    asser=
t_false(oob_build_probe_reply(&buf, 1000000, 30, &peer, &reply));
+
+    gc=
_free(&gc);
+}
+
 int
 main(void)
 {
@@ -203,6 +377,15 @@
         cmocka_u=
nit_test(test_probe_parameter_too_short),
         cmocka_unit_test(test_pr=
obe_parameter_truncated_buffer),
         cmocka_unit_test(test_tlv_header_=
truncated),
+        cmocka_unit_test(test_server_probe_read_finds_paramete=
r),
+        cmocka_unit_test(test_server_probe_read_skips_unknown),
+     =
   cmocka_unit_test(test_server_probe_read_missing),
+        cmocka_unit_t=
est(test_server_probe_read_truncated),
+        cmocka_unit_test(test_serve=
r_probe_read_wrong_msg_type),
+        cmocka_unit_test(test_timestamp_in_w=
indow),
+        cmocka_unit_test(test_build_probe_reply_valid),
+        c=
mocka_unit_test(test_build_probe_reply_stale),
+        cmocka_unit_test(te=
st_build_probe_reply_no_parameter),
     };
 
     return cmocka_run_group_=
tests_name("oob tests", tests, NULL, NULL);

-- 
To view, visit http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail
To unsubscribe, or for help=
 writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30
Gerrit=
-Change-Number: 1742
Gerrit-PatchSet: 8
Gerrit-Owner: stipa <lstipakov@gmai=
l=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Rev=
iewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom=
>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>

--uUce7GTxLYI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, stipa=2E </p>
<p>stipa <stro=
ng>uploaded patch set #8</strong> to this change=2E</p><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail">View Change</a></p><p=
>The following approvals got outdated and were removed:
Code-Review-1 by fl=
ichtenheld</p><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">oob: Add SERVER_PROBE parsing and the probe-rep=
ly decision<br><br>Add the message-level helpers the server needs to answer=
 a probe:<br><br>  - oob_server_probe_read() scans the TLV payload of a rec=
eived OOB<br>    SERVER_PROBE for the probe_parameter TLV, skipping other/f=
uture TLV<br>    types and rejecting malformed or truncated input=2E<br>  -=
 oob_timestamp_in_window() performs the cheap replay/skew check on the<br> =
   probe timestamp described in the wire protocol specification=2E<br>  - o=
ob_build_probe_reply() composes the two: given a received SERVER_PROBE<br> =
   it scans for the probe_parameter, drops the probe if it is missing or<br=
>    its timestamp is outside the acceptable window, and otherwise populate=
s<br>    the probe_reply (echoing the peer&#39;s session id) to send back=
=2E<br><br>These are pure functions exercised by unit tests; the server pac=
ket path<br>calls oob_build_probe_reply() in a follow-up, which performs th=
e actual send=2E<br><br>Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c3=
0<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M src/=
openvpn/oob=2Ec<br>M src/openvpn/oob=2Eh<br>M tests/unit_tests/openvpn/test=
_oob=2Ec<br>3 files changed, 299 insertions(+), 0 deletions(-)<br><br></pre=
><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/cha=
nges/42/1742/8</pre><pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;"><span>diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=
=2Ec</span><br><span>index b01f4ee=2E=2Ea885453 100644</span><br><span>--- =
a/src/openvpn/oob=2Ec</span><br><span>+++ b/src/openvpn/oob=2Ec</span><br><=
span>@@ -166,3 +166,67 @@</span><br><span>     r-&gt;max_latency_diff =3D (=
uint16_t)max_latency_diff;</span><br><span>     return oob_skip_trailing(bu=
f, value_len, OOB_PROBE_REPLY_LEN);</span><br><span> }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+oob_server_probe_write(struct buffer *buf, const struct oob_probe_paramete=
r *param)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    return oob_msg_write_hea=
der(buf, OOB_MSG_SERVER_PROBE)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+           &amp;&amp; oob_probe_parameter_write(buf, param);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
oob_server_probe_read(struct buffer *payload, struct oob_probe_parameter *p=
aram)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (!oob_msg_read_header(pay=
load, OOB_MSG_SERVER_PROBE))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* Loop until we either find the=
 probe_parameter or run out of</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     * well-formed TLVs=2E */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    uint16_t type;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    bool optional;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    uint16_t value_len;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    while (oob_tlv_read_header(payload, &amp;type, &=
amp;optional, &amp;value_len))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (type =3D=3D OOB_TLV_PROBE_PARAMETER)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            return oob_probe_parameter_read(payload, param,=
 value_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* not th=
e TLV we are looking for: skip its value and keep scanning */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if (!buf_advance(payload,=
 value_len))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            retur=
n false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    return false;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_timestamp_=
in_window(uint64_t probe_ts, uint64_t now, uint64_t window_secs)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    uint64_t diff =3D (now &gt; probe_ts) ? (now=
 - probe_ts) : (probe_ts - now);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    return diff &lt;=3D window_secs;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_build_probe_reply(=
struct buffer *probe_payload, uint64_t now, uint64_t window_secs,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                      const s=
truct session_id *peer_sid, struct oob_probe_reply *reply)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct oob_probe_parameter param;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (!oob_server_probe_read(probe=
_payload, &amp;param))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret=
urn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Drop replayed or implausibly-timed=
 probes before doing any more work=2E */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (!oob_timestamp_in_window(param=2Etimestamp, no=
w, window_secs))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return fa=
lse;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    CLEAR(*reply);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    reply-&gt;peer_session_id =3D *peer_sid;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* priority/weight/c=
onnect_lifetime/flags left at 0 for now */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return true;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span>diff --git a/src/openvpn/oob=2Eh b/sr=
c/openvpn/oob=2Eh</span><br><span>index 6880665=2E=2Ec5d13e4 100644</span><=
br><span>--- a/src/openvpn/oob=2Eh</span><br><span>+++ b/src/openvpn/oob=2E=
h</span><br><span>@@ -149,4 +149,56 @@</span><br><span>  */</span><br><span=
> bool oob_probe_reply_read(struct buffer *buf, struct oob_probe_reply *r, =
uint16_t value_len);</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * Write a complete SERVER_PROBE message (message-type header + probe_pa=
rameter</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * TLV) to @=
p buf=2E Sent by the client=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool =
oob_server_probe_write(struct buffer *buf, const struct oob_probe_parameter=
 *param);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * Read a received OOB SERVER_PROBE: verify i=
ts message-type header, then scan</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * for the probe_parameter TLV=2E TLV types other than probe_=
parameter are</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * ski=
pped, so the scan tolerates additional/future TLVs=2E @p payload is consume=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * as it is read=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param payload  buffer positio=
ned at the start of the OOB message payload</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @param param    filled with the parsed probe_par=
ameter on success</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @return true if the header matched and a well-formed probe_parameter was</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         found, fal=
se otherwise</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+bool oob_server_probe_r=
ead(struct buffer *payload, struct oob_probe_parameter *param);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * Check whether a probe timestamp is within an acceptable window =
around the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * curren=
t time=2E Used to cheaply drop replayed or implausibly-timed probes</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * before doing any further=
 work (see the probe_parameter timestamp rationale</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * in the wire protocol specification)=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @param probe_ts     timestamp from t=
he probe_parameter (UNIX seconds)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @param now          current time (UNIX seconds)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param window_secs  maximum=
 allowed difference, in either direction</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @return true if |now - probe_ts| &lt;=3D window_sec=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+bool oob_timestamp_in_window(uint6=
4_t probe_ts, uint64_t now, uint64_t window_secs);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * P=
rocess the TLV payload of a received SERVER_PROBE and decide whether to</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * answer it=2E Combine=
s oob_server_probe_read() and oob_timestamp_in_window():</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * the probe is dropped (false returne=
d) if it has no valid probe_parameter or</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * its timestamp is outside the acceptable window=2E O=
n success @p reply is</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * populated with the peer&#39;s session id echoed back and the remaining=
 fields</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * zeroed, r=
eady to be wrapped and sent=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Thi=
s is the transport-agnostic decision step; the caller performs the send=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param probe_payload  TLV payload =
of the received OOB SERVER_PROBE</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @param now            current time (UNIX seconds)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @param window_secs    acce=
ptable timestamp skew, in either direction</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param peer_sid       session id of the requestin=
g peer (echoed in the reply)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param reply          filled with the reply to send on success<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return true if a=
 reply should be sent, false to silently drop the probe</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+bool oob_build_probe_reply(struct buffer *probe_payload=
, uint64_t now, uint64_t window_secs,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                           const struct session_id *peer_=
sid, struct oob_probe_reply *reply);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span> #endif /* OOB_H */</span><br><span>diff =
--git a/tests/unit_tests/openvpn/test_oob=2Ec b/tests/unit_tests/openvpn/te=
st_oob=2Ec</span><br><span>index 48dfd6e=2E=2E4412389 100644</span><br><spa=
n>--- a/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>+++ b/tests/u=
nit_tests/openvpn/test_oob=2Ec</span><br><span>@@ -192,6 +192,180 @@</span>=
<br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A SERVER_PROBE carryin=
g just a probe_parameter is found by the scan=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+test_server_probe_read_finds_parameter(void **sta=
te)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new(=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer=
 buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  const struct oob_probe_parameter in =3D {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        =2Etimestamp =3D 0x1122334455667788ULL,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Eflags =3D 0,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_server_probe=
_write(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
oob_probe_parameter out =3D { 0 };</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_true(oob_server_probe_read(&amp;buf, &amp;out));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(in=
=2Etimestamp =3D=3D out=2Etimestamp);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_int_equal(in=2Eflags, out=2Eflags);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* TLVs o=
ther than probe_parameter are skipped, so the scan finds the</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * probe_parameter even when prece=
ded by an unknown TLV=2E */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
test_server_probe_read_skips_unknown(void **state)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &=
amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* SERVER_PROBE message he=
ader, then an unknown TLV (type 0x7ff) =2E=2E=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_msg_write_header(&amp=
;buf, OOB_MSG_SERVER_PROBE));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_true(oob_tlv_write_header(&amp;buf, 0x7ff, false, 4));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf=
_write_u32(&amp;buf, 0xcafef00d));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* =2E=2E=2E followed by the real probe_parameter */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct oob_pr=
obe_parameter in =3D { =2Etimestamp =3D 42, =2Eflags =3D 0 };</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_probe_paramet=
er_write(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t oob_probe_parameter out =3D { 0 };</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_true(oob_server_probe_read(&amp;buf, &amp;out))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ou=
t=2Etimestamp =3D=3D 42);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&=
amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/* A payload with no probe_parameter must be rej=
ected=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static v=
oid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_server_prob=
e_read_missing(void **state)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_true(oob_msg_write_header(&amp;buf, OOB_M=
SG_SERVER_PROBE));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_true(oob_tlv_write_header(&amp;buf, 0x7ff, false, 4));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(=
&amp;buf, 0));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_par=
ameter out =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_false(oob_server_probe_read(&amp;buf, &amp;out));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A TLV wh=
ose declared length runs past the buffer must be rejected, not</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * read out of bounds=2E */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+test_server_probe_read_truncated=
(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =
=3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* TLV header claims a 16-byte value but no value bytes follow=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(=
oob_msg_write_header(&amp;buf, OOB_MSG_SERVER_PROBE));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_tlv_write_header(&am=
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
%, 40%);">+    assert_true(oob_msg_write_header(&amp;buf, OOB_MSG_PROBE_REP=
LY));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const stru=
ct oob_probe_parameter in =3D { =2Etimestamp =3D 42, =2Eflags =3D 0 };</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_prob=
e_parameter_write(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct oob_probe_parameter out =3D { 0 };</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_false(oob_server_probe_read(&amp;buf, =
&amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* Timestamp window check accepts values within the window (=
either direction)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 and rejects values outside it=2E */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+test_timestamp_in_window(void **state)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    const uint64_t now =3D 1000000;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    const uint64_t window =3D 30;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_true(oob_timestamp_in_window(now, now, wind=
ow));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tru=
e(oob_timestamp_in_window(now - window, now, window));      /* boundary, pa=
st */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tru=
e(oob_timestamp_in_window(now + window, now, window));      /* boundary, fu=
ture */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_f=
alse(oob_timestamp_in_window(now - window - 1, now, window)); /* too old */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(oo=
b_timestamp_in_window(now + window + 1, now, window)); /* too far ahead */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/* A valid, in-window SERVER_PROBE yields a reply that ec=
hoes the peer&#39;s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * session id and zeroes the remaining fields=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+test_build_probe_reply_valid(void **state)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D a=
lloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const ui=
nt64_t now =3D 1000000;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    const struct oob_probe_parameter probe =3D { =2Etimestamp =3D now, =
=2Eflags =3D 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_true(oob_server_probe_write(&amp;buf, &amp;probe));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct session_id peer;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    memcpy(peer=2Eid, &quot;PEER1234&quot;, S=
ID_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_reply re=
ply;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true=
(oob_build_probe_reply(&amp;buf, now, 30, &amp;peer, &amp;reply));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(repl=
y=2Epeer_session_id=2Eid, peer=2Eid, SID_SIZE);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_int_equal(reply=2Epriority, 0);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(rep=
ly=2Eweight, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_int_equal(reply=2Econnect_lifetime, 0);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_int_equal(reply=2Eflags, 0);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A p=
robe whose timestamp is outside the window is dropped (no reply)=2E */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+test_build_probe_reply_stale(voi=
d **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D =
gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    const uint64_t now =3D 1000000;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const struct oob_probe_parameter probe =3D { =2Eti=
mestamp =3D now - 1000, =2Eflags =3D 0 };</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_true(oob_server_probe_write(&amp;buf, &amp=
;probe));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct session_id peer =
=3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t oob_probe_reply reply;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_false(oob_build_probe_reply(&amp;buf, now, 30, &amp;peer, &=
amp;reply));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* A payload without a probe_parameter is dropped (no reply)=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_build_probe_repl=
y_no_parameter(void **state)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_true(oob_msg_write_header(&amp;buf, OOB_M=
SG_SERVER_PROBE));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_true(oob_tlv_write_header(&amp;buf, 0x7ff, false, 4));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(=
&amp;buf, 0));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct session_id pe=
er =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct oob_probe_reply reply;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_false(oob_build_probe_reply(&amp;buf, 1000000, 30, &amp;=
peer, &amp;reply));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><sp=
an> main(void)</span><br><span> {</span><br><span>@@ -203,6 +377,15 @@</spa=
n><br><span>         cmocka_unit_test(test_probe_parameter_too_short),</spa=
n><br><span>         cmocka_unit_test(test_probe_parameter_truncated_buffer=
),</span><br><span>         cmocka_unit_test(test_tlv_header_truncated),</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_te=
st(test_server_probe_read_finds_parameter),</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        cmocka_unit_test(test_server_probe_read_ski=
ps_unknown),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 cmocka_unit_test(test_server_probe_read_missing),</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_server_probe_r=
ead_truncated),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    cmocka_unit_test(test_server_probe_read_wrong_msg_type),</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_time=
stamp_in_window),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      cmocka_unit_test(test_build_probe_reply_valid),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_build_probe=
_reply_stale),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   cmocka_unit_test(test_build_probe_reply_no_parameter),</span><br><span> =
    };</span><br><span> </span><br><span>     return cmocka_run_group_tests=
_name(&quot;oob tests&quot;, tests, NULL, NULL);</span><br><span></span><br=
></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1742?usp=3Demail">change 1742</a>=2E To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1742?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1742 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>

</body></html>
--uUce7GTxLYI=--


--===============4405221986518233392==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4405221986518233392==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4405221986518233392==--

