Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 572D8CA5FAC
	for <openvpn-devel@archiver.kernel.org>; Tue, 29 Sep 2026 13:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y0KEkLUYrbv2cBNZJI3BS3is0bjqh+pXyjqbCajnUic=; b=eNbe4z1XRXn27G1Wp79xrLqvVL
	OS4I7GfFCWDYdociSqG7b8Ten9tJ9oKEnfpZdqwnawtmAc96s/9enBdCpD/zXvLsKjQcPvFPr62ym
	eS44jAq4upk5EE/21e7hTJE6SB0YtLIQUkOWGoul9bRkKHMxOq9HZs2rJVcInlSTCo+Q=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBXhY-0002t8-5d;
	Tue, 29 Sep 2026 13:16:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBXhW-0002t1-MF
 for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 13:16:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ZKauJN0yWDBYrTVLG0aZSo6Bv0ZBpsL8F04TK2fyQvc=; b=k3dEgGbgYrWKu43e8az/zlPlxs
 ru6tH+/5n3Pvh6CX/Y18GGVaA5jQXoKC1IRMX7s1lLzeQkB20aDctRIOCdRdS76yrFWzE0Wzxz0GA
 QAzxmUrtF2CUcrpdty4/ZWtUi+1jCilkHZjNegCglfQv9YZSqnCM3ErXY3Y0+bHjdiPw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ZKauJN0yWDBYrTVLG0aZSo6Bv0ZBpsL8F04TK2fyQvc=; b=C
 OJCy9Lpjgr/r4URmkFjAKC5dRs/nKM6hQ3clhIO1BOMheHdOP5adniM+X+a+r4cCIAHEFll9NzNo1
 eS3N/tIrEXvaujaxxa1fFg74elb1Ku+akYY5boIK1k56YuHOvZZg5byGiwbNeG8Q8VEJHFzqB6lct
 eTdPvRlO4aIaizgw=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBXhR-0007lE-Me for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 13:16:52 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49b912d3920so31238015e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 29 Sep 2026 06:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790687803; x=1791292603; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZKauJN0yWDBYrTVLG0aZSo6Bv0ZBpsL8F04TK2fyQvc=;
 b=TNLLS7es8U4ZsqvU2zOSgTOFUhPXcFC8v3Wl6cEDovDTHVc6ieUpLt+Yyz8zplZGDy
 O49lVUhjpAuviJZ1yLy12GY7R979oVC1fj0O2jNDkK09ohJbmJ14PtZcgHu85bfNAg51
 v2PnNvpgdSyqCKL3xjGAUyyNLqWWXsw21ycNg9lUhb0/CaZR8tABBo/4w5cQwmh5th01
 uTEB0YjNS2rWC7LzV6FqiTqFuJyBq2xgkISdIhZNCTH8cvl7rIE3eICHtQIQDvKREG7S
 10jZZYbV/XkFNvXPmdzrAA6ex90DQeJbrSEPC1tXIQJgZ4rHuUPR6SJU+peh2kGYHH2U
 QxPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790687803; x=1791292603;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ZKauJN0yWDBYrTVLG0aZSo6Bv0ZBpsL8F04TK2fyQvc=;
 b=Oc62bVg4wgy1Lrp0Ri293mGovFz/qJvQXJP3f0pk3s29IM5HtAONMA+08a3uvtO5Du
 BToPblQlUE+6umJ6BrMOQ+LRx3Kb1PQbI1KxDqcvGFqkIPpIYPaiVsSlJkBbtdzfa/6f
 QnXXeuv2LhOjqQSKLFoEjKl5+Z5rRCWGUV8AWZfK0j7KedA5z9oOdb8GC/xPw0BlgxsD
 9Whl1a7L8tzqbjdBLuaVZtKAQqDRJt2IWzymyN4LqSb6baPZoOUPTXsMRe5HbJ6U3dre
 1GnzDtbWKzc1CzXj7lsyNo2GbwPPEwtrjntxl0KvZP3yQmyB1K/ZG8s9xFN/LBYhm8bZ
 VS9Q==
X-Gm-Message-State: AFuF++nXEBweZkwydhW0tKI2OZwkR2ZyG0km8fHjZRmOdf+3VoxcvBai
 7nIqeBkYl+kcn1pS9DKRKamJogHdTut5QEwMl8eVNuq+zNH9Z+zBVfCJgPexCpNu1qeQHQBZCRp
 I+npwSHZBkv2n0eVKxmd3LOBCIGU06A6D+1q81lumyTj5NYmDqOaN4VqO5GB3KsYr/VyH
X-Gm-Gg: AYBFou03QfiQgv19u3vcI/XhVfgMpUp9P7h8ClZONBNtEToyYNLnPixUL6/YI7HEpdS
 u9MkdR0EeGDfWy31+7uwuEsKjqqNMQyRdWZOajDp3o8G8ZeVNT7Zg2zt9pbEyv/gUT1Fl5odmc3
 VSMnmENhqbbOL9QXtsY5V9kLmt5lEMn4s03/SgpGaYYtgSga8QiAQhP1HiAKgFtx7rT8s4klTkL
 oKyZg7SToJxmJ2XZOWaPmqNYDMVsCE/++ijzLJcKZTELq0a7s/M7ohYfMQi7JSzuoPsaQFnLFFv
 ammANz0UW5wemdVtGpopaZTAyEEkfBo51ySFnKBu3HY3SG/N1NfXTQvAzHuiiY3ox7XSexMUYBd
 wurYbM4+iCCy9rwHiV0jOyB8z43qYS1A8d0KOwBTZvDkAXobnMCzKvHtjOYm12JOfD4pETJnvJf
 UC0XAmKkkpS3lfggnHMrmECUTyhFro2sbu4P/nKQgcq+eyqLFpQ6rBSVvlCRtHKT3aVFeJRImLj
 mpGy6GQipKacimurvK1PdNLse/hLQCJzAIs5rRmgx+rabYGvQNDy/wQxcL+vTmJR82Hh3Rz4gfg
 TnRIyvpxWfKG8i9/bacbxwP4Op+dW1WikpcAbfnInkSDpRxnwDH/8HVZkXJ1V14JR/WVgw4=
X-Received: by 2002:a05:600c:37c6:b0:49e:81db:4926 with SMTP id
 5b1f17b1804b1-49fe66ca0d1mr268472645e9.5.1790687802706; 
 Tue, 29 Sep 2026 06:16:42 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a013d2d048sm2006935e9.3.2026.09.29.06.16.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 06:16:42 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 29 Sep 2026 13:16:31 +0000
To: ralf_lici <ralf@mandelbit.com>, plaisthos <arne-openvpn@rfc2549.org>,
 flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 18
X-Gerrit-Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30
X-Gerrit-Change-Number: 1742
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1742?usp=email>
X-Gerrit-Commit: ccc37cf08d2a5c5c96443e43deb35051a7cdb115
In-Reply-To: <gerrit.1782719911000.Iafa9efc1c156974ad9f5752e9de810a8c2f68c30@gerrit.openvpn.net>
References: <gerrit.1782719911000.Iafa9efc1c156974ad9f5752e9de810a8c2f68c30@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklhZmE5ZWZjMWMxNTY5NzRhZDlmNTc1MmU5ZGU4MTBhOGMyZjY4YzMwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1ae740c63cf3f1ff49385f6b6d01fd78f95c46fb-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBXhR-0007lE-Me
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
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, frank@lichtenheld.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5707665692625352295=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5707665692625352295==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KfA+SUarjno="; charset=UTF-8

--KfA+SUarjno=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, ralf_lici=2E=


Hello flichtenheld, plaisthos, ralf_lici, 

I'd like you to reexamine a c=
hange=2E Please visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?u=
sp=3Demail

to look at the new patch set (#18)=2E


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
oob_server_probe_read() for the SERVER_PROBE message,
oob_=
timestamp_in_window() for the replay/skew check on its timestamp,
and oob_s=
erver_probe_check(), which combines the two and classifies a
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
/1742/18

diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec
index 68d1=
63e=2E=2E9d45d64 100644
--- a/src/openvpn/oob=2Ec
+++ b/src/openvpn/oob=2Ec=

@@ -83,3 +83,30 @@
     r->flags =3D (uint16_t)buf_read_u16(buf);
     ret=
urn true;
 }
+
+bool
+oob_server_probe_read(struct buffer *payload, struct =
oob_probe_request *req)
+{
+    struct buffer value;
+    return ctrl_msg_f=
ind_tlv(payload, OOB_TLV_PROBE_REQUEST, &value)
+           && oob_probe_re=
quest_read(&value, req);
+}
+
+bool
+oob_timestamp_in_window(uint64_t probe=
_ts, uint64_t now, uint64_t window_secs)
+{
+    uint64_t diff =3D (now > p=
robe_ts) ? (now - probe_ts) : (probe_ts - now);
+    return diff <=3D windo=
w_secs;
+}
+
+enum oob_probe_verdict
+oob_server_probe_check(struct buffer =
*probe_payload, uint64_t now, uint64_t window_secs,
+                      =
 struct oob_probe_request *req)
+{
+    if (!oob_server_probe_read(probe_pa=
yload, req))
+    {
+        return OOB_PROBE_INVALID;
+    }
+    return o=
ob_timestamp_in_window(req->timestamp, now, window_secs) ? OOB_PROBE_OK
+  =
                                                                   : OOB_PR=
OBE_STALE;
+}
diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh
index =
c13ae17=2E=2Ec5ebad0 100644
--- a/src/openvpn/oob=2Eh
+++ b/src/openvpn/oob=
=2Eh
@@ -103,4 +103,49 @@
  */
 bool oob_probe_reply_read(struct buffer *bu=
f, struct oob_probe_reply *r);
 
+/**
+ * Read a received OOB SERVER_PROBE:=
 scan its payload for the probe request
+ * TLV=2E Unknown TLV types marked=
 optional are skipped; an unknown mandatory one
+ * rejects the probe=2E pa=
yload is consumed as it is read=2E
+ *
+ * @param payload  buffer positione=
d at the start of the OOB message payload
+ * @param req      filled with t=
he parsed probe request on success
+ * @return true if a well-formed probe =
request was found, false otherwise
+ */
+bool oob_server_probe_read(struct =
buffer *payload, struct oob_probe_request *req);
+
+/**
+ * Check whether a=
 probe timestamp is within an acceptable window around the
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
+ * Classify a received SERVER_PROBE=2E Combines o=
ob_server_probe_read() and
+ * oob_timestamp_in_window()=2E This is the tra=
nsport-agnostic decision step;
+ * the caller decides what to do with a sta=
le probe and builds the reply=2E
+ *
+ * @param probe_payload  payload of t=
he received OOB SERVER_PROBE, consumed
+ * @param now            current ti=
me (UNIX seconds)
+ * @param window_secs    acceptable timestamp skew, in e=
ither direction
+ * @param req            filled with the probe request unl=
ess the verdict is
+ *                       OOB_PROBE_INVALID, for the rep=
ly to echo its request_id
+ */
+enum oob_probe_verdict oob_server_probe_che=
ck(struct buffer *probe_payload, uint64_t now,
+                           =
                   uint64_t window_secs, struct oob_probe_request *req);
+
=
 #endif /* OOB_H */
diff --git a/tests/unit_tests/openvpn/test_oob=2Ec b/te=
sts/unit_tests/openvpn/test_oob=2Ec
index 656cb21=2E=2E0c9e79b 100644
--- a=
/tests/unit_tests/openvpn/test_oob=2Ec
+++ b/tests/unit_tests/openvpn/test_=
oob=2Ec
@@ -359,6 +359,195 @@
     gc_free(&gc);
 }
 
+/* A SERVER_PROBE ca=
rrying just a probe request is found by the scan, along
+ * with its reques=
t_id=2E */
+static void
+test_server_probe_read_finds_request(void **state)=

+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_=
buf_gc(128, &gc);
+
+    const struct oob_probe_request in =3D {
+        =
=2Erequest_id =3D 42,
+        =2Etimestamp =3D 0x1122334455667788ULL,
+   =
     =2Eflags =3D 0,
+    };
+    assert_true(oob_probe_request_write(&buf,=
 &in));
+
+    struct oob_probe_request out =3D { 0 };
+    assert_true(oob=
_server_probe_read(&buf, &out));
+    assert_int_equal(out=2Erequest_id, 42=
);
+    assert_true(in=2Etimestamp =3D=3D out=2Etimestamp);
+    assert_int=
_equal(in=2Eflags, out=2Eflags);
+
+    gc_free(&gc);
+}
+
+/* TLVs other t=
han probe request are skipped, so the scan finds the
+ * probe request even=
 when preceded by an unknown TLV=2E */
+static void
+test_server_probe_read=
_skips_unknown(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    =
struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    /* An unknown but opti=
onal TLV (type 0x7ff) =2E=2E=2E */
+    assert_true(ctrl_msg_tlv_write_head=
er(&buf, 0x7ff, true, 4));
+    assert_true(buf_write_u32(&buf, 0xcafef00d)=
);
+    /* =2E=2E=2E followed by the real probe request */
+    const struc=
t oob_probe_request in =3D { =2Etimestamp =3D 42, =2Eflags =3D 0 };
+    as=
sert_true(oob_probe_request_write(&buf, &in));
+
+    struct oob_probe_requ=
est out =3D { 0 };
+    assert_true(oob_server_probe_read(&buf, &out));
+  =
  assert_true(out=2Etimestamp =3D=3D 42);
+
+    gc_free(&gc);
+}
+
+/* An =
unknown TLV that is NOT marked optional carries something the sender
+ * re=
quires us to act on: the whole message is rejected, whether that TLV comes
=
+ * before or after the one we were looking for=2E */
+static void
+test_se=
rver_probe_read_rejects_unknown_mandatory(void **state)
+{
+    struct gc_a=
rena gc =3D gc_new();
+    const struct oob_probe_request in =3D { =2Etimes=
tamp =3D 42, =2Eflags =3D 0 };
+
+    struct buffer before =3D alloc_buf_gc=
(128, &gc);
+    assert_true(ctrl_msg_tlv_write_header(&before, 0x7ff, fals=
e, 4));
+    assert_true(buf_write_u32(&before, 0xcafef00d));
+    assert_t=
rue(oob_probe_request_write(&before, &in));
+
+    struct buffer after =3D =
alloc_buf_gc(128, &gc);
+    assert_true(oob_probe_request_write(&after, &i=
n));
+    assert_true(ctrl_msg_tlv_write_header(&after, 0x7ff, false, 4));
=
+    assert_true(buf_write_u32(&after, 0xcafef00d));
+
+    struct oob_prob=
e_request out =3D { 0 };
+    assert_false(oob_server_probe_read(&before, &=
out));
+    assert_false(oob_server_probe_read(&after, &out));
+
+    gc_fr=
ee(&gc);
+}
+
+/* A payload with no probe request must be rejected=2E */
+s=
tatic void
+test_server_probe_read_missing(void **state)
+{
+    struct gc_=
arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+=

+    assert_true(ctrl_msg_tlv_write_header(&buf, 0x7ff, true, 4));
+    as=
sert_true(buf_write_u32(&buf, 0));
+
+    struct oob_probe_request out =3D =
{ 0 };
+    assert_false(oob_server_probe_read(&buf, &out));
+
+    gc_free=
(&gc);
+}
+
+/* A TLV whose declared length runs past the buffer must be re=
jected, not
+ * read out of bounds=2E */
+static void
+test_server_probe_re=
ad_truncated(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    st=
ruct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    /* TLV header claims a 1=
6-byte value but no value bytes follow */
+    assert_true(ctrl_msg_tlv_wri=
te_header(&buf, 0x7ff, false, 16));
+
+    struct oob_probe_request out =3D=
 { 0 };
+    assert_false(oob_server_probe_read(&buf, &out));
+
+    gc_fre=
e(&gc);
+}
+
+/* A payload carrying a probe reply instead is not a SERVER_P=
ROBE=2E */
+static void
+test_server_probe_read_reply_tlv(void **state)
+{
=
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_=
gc(128, &gc);
+
+    const struct oob_probe_reply in =3D { =2Erequest_id =
=3D 42 };
+    assert_true(oob_probe_reply_write(&buf, &in));
+
+    struct=
 oob_probe_request out =3D { 0 };
+    assert_false(oob_server_probe_read(&=
buf, &out));
+
+    gc_free(&gc);
+}
+
+/* Timestamp window check accepts v=
alues within the window (either direction)
+ * and rejects values outside i=
t=2E */
+static void
+test_timestamp_in_window(void **state)
+{
+    const =
uint64_t now =3D 1000000;
+    const uint64_t window =3D 30;
+
+    assert_=
true(oob_timestamp_in_window(now, now, window));
+    assert_true(oob_times=
tamp_in_window(now - window, now, window));      /* boundary, past */
+    =
assert_true(oob_timestamp_in_window(now + window, now, window));      /* bo=
undary, future */
+    assert_false(oob_timestamp_in_window(now - window - =
1, now, window)); /* too old */
+    assert_false(oob_timestamp_in_window(n=
ow + window + 1, now, window)); /* too far ahead */
+}
+
+/* A well-formed =
probe with an in-window timestamp is answered=2E */
+static void
+test_serv=
er_probe_check_valid(void **state)
+{
+    struct gc_arena gc =3D gc_new();=

+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    const uint64_t n=
ow =3D 1000000;
+    const struct oob_probe_request probe =3D { =2Erequest_=
id =3D 1, =2Etimestamp =3D now, =2Eflags =3D 0 };
+    assert_true(oob_prob=
e_request_write(&buf, &probe));
+
+    struct oob_probe_request req =3D { 0=
 };
+    assert_int_equal(oob_server_probe_check(&buf, now, 30, &req), OOB_=
PROBE_OK);
+    assert_int_equal(req=2Erequest_id, 1);
+
+    gc_free(&gc);=

+}
+
+/* A well-formed probe whose timestamp is outside the window is stal=
e; the
+ * caller decides whether it still gets an answer=2E */
+static voi=
d
+test_server_probe_check_stale(void **state)
+{
+    struct gc_arena gc =
=3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    con=
st uint64_t now =3D 1000000;
+    const struct oob_probe_request probe =3D =
{ =2Erequest_id =3D 7, =2Etimestamp =3D now - 1000, =2Eflags =3D 0 };
+    =
assert_true(oob_probe_request_write(&buf, &probe));
+
+    struct oob_probe=
_request req =3D { 0 };
+    assert_int_equal(oob_server_probe_check(&buf, =
now, 30, &req), OOB_PROBE_STALE);
+    assert_int_equal(req=2Erequest_id, 7=
); /* a stale probe may still be answered */
+
+    gc_free(&gc);
+}
+
+/* =
A payload without a probe request is invalid (no reply)=2E */
+static void
=
+test_server_probe_check_no_request(void **state)
+{
+    struct gc_arena g=
c =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    a=
ssert_true(ctrl_msg_tlv_write_header(&buf, 0x7ff, true, 4));
+    assert_tr=
ue(buf_write_u32(&buf, 0));
+
+    struct oob_probe_request req;
+    asser=
t_int_equal(oob_server_probe_check(&buf, 1000000, 30, &req), OOB_PROBE_INVA=
LID);
+
+    gc_free(&gc);
+}
+
 /* The OOB tests run as a second group of =
pkt_testdriver; see test_pkt=2Ec=2E */
 int
 run_oob_tests(void)
@@ -375,6 =
+564,16 @@
         cmocka_unit_test(test_find_tlv_skips_optional_after_wan=
ted),
         cmocka_unit_test(test_find_tlv_empty_payload),
         cmoc=
ka_unit_test(test_tlv_header_truncated),
+        cmocka_unit_test(test_ser=
ver_probe_read_finds_request),
+        cmocka_unit_test(test_server_probe_=
read_skips_unknown),
+        cmocka_unit_test(test_server_probe_read_rejec=
ts_unknown_mandatory),
+        cmocka_unit_test(test_server_probe_read_mis=
sing),
+        cmocka_unit_test(test_server_probe_read_truncated),
+      =
  cmocka_unit_test(test_server_probe_read_reply_tlv),
+        cmocka_unit_=
test(test_timestamp_in_window),
+        cmocka_unit_test(test_server_probe=
_check_valid),
+        cmocka_unit_test(test_server_probe_check_stale),
+ =
       cmocka_unit_test(test_server_probe_check_no_request),
     };
 
    =
 return cmocka_run_group_tests_name("oob tests", tests, NULL, NULL);

-- 
T=
o view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail
To=
 unsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Proje=
ct: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iafa9efc1c156974ad9f575=
2e9de810a8c2f68c30
Gerrit-Change-Number: 1742
Gerrit-PatchSet: 18
Gerrit-Ow=
ner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lic=
htenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <op=
envpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: ralf_lici <ralf@ma=
ndelbit=2Ecom>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Attention: flichtenheld <frank@lichtenheld=2Ecom>

--KfA+SUarjno=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, ralf_lici=2E </p>
<p>stipa <=
strong>uploaded patch set #18</strong> to this change=2E</p><p><a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">oob: Add SERVER_PROBE parsing and the probe-reply decision=
<br><br>Add the message-level helpers the server needs to answer a probe:<b=
r>oob_server_probe_read() for the SERVER_PROBE message,<br>oob_timestamp_in=
_window() for the replay/skew check on its timestamp,<br>and oob_server_pro=
be_check(), which combines the two and classifies a<br>received probe as in=
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
refs/changes/42/1742/18</pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;"><span>diff --git a/src/openvpn/oob=2Ec b/src/open=
vpn/oob=2Ec</span><br><span>index 68d163e=2E=2E9d45d64 100644</span><br><sp=
an>--- a/src/openvpn/oob=2Ec</span><br><span>+++ b/src/openvpn/oob=2Ec</spa=
n><br><span>@@ -83,3 +83,30 @@</span><br><span>     r-&gt;flags =3D (uint16=
_t)buf_read_u16(buf);</span><br><span>     return true;</span><br><span> }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+oob_server_probe_read(struct buffer *payload, struct o=
ob_probe_request *req)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buff=
er value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return=
 ctrl_msg_find_tlv(payload, OOB_TLV_PROBE_REQUEST, &amp;value)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; oob_probe_=
request_read(&amp;value, req);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+oob_timestamp_in_window(uint64_t probe_ts=
, uint64_t now, uint64_t window_secs)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    uint64_t diff =3D (now &gt; probe_ts) ? (now - probe_ts) : (probe_ts - =
now);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return dif=
f &lt;=3D window_secs;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+enum oob_probe_verdict</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+oob_server_probe_check(struct b=
uffer *probe_payload, uint64_t now, uint64_t window_secs,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                       struct oob_pro=
be_request *req)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!oob_server_p=
robe_read(probe_payload, req))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     return OOB_PROBE_INVALID;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 return oob_timestamp_in_window(req-&gt;timestamp, now, window_secs) ? OOB_=
PROBE_OK</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                                                          : OOB_PROBE_STALE=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>=
diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh</span><br><span>inde=
x c13ae17=2E=2Ec5ebad0 100644</span><br><span>--- a/src/openvpn/oob=2Eh</sp=
an><br><span>+++ b/src/openvpn/oob=2Eh</span><br><span>@@ -103,4 +103,49 @@=
</span><br><span>  */</span><br><span> bool oob_probe_reply_read(struct buf=
fer *buf, struct oob_probe_reply *r);</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * Read a received OOB SERVER_PROBE: scan its payload f=
or the probe request</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * TLV=2E Unknown TLV types marked optional are skipped; an unknown mandat=
ory one</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * rejects t=
he probe=2E payload is consumed as it is read=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param payload  buffer positioned at the start of the OOB me=
ssage payload</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @pa=
ram req      filled with the parsed probe request on success</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @return true if a well-formed p=
robe request was found, false otherwise</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+bool oob_server_probe_read(struct buffer *payload, struct oob_probe_req=
uest *req);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Check whether a probe timestamp is wit=
hin an acceptable window around the</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * current time=2E Used to cheaply drop replayed or implaus=
ibly-timed probes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 before doing any further work (see the probe request timestamp rationale</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * in the wire protoc=
ol specification)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param probe_=
ts     timestamp from the probe request (UNIX seconds)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @param now          current time (UNI=
X seconds)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param=
 window_secs  maximum allowed difference, in either direction</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @return true if |now - probe_t=
s| &lt;=3D window_secs</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool oob_time=
stamp_in_window(uint64_t probe_ts, uint64_t now, uint64_t window_secs);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+enum oob_probe_verdict</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    OOB_PROBE_INVALID, /**&lt; no valid probe request: d=
rop */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OOB_PROBE=
_STALE,   /**&lt; well-formed, timestamp outside the window */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    OOB_PROBE_OK,      /**&lt; w=
ell-formed, timestamp within the window */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * Classify a received SERVER=
_PROBE=2E Combines oob_server_probe_read() and</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * oob_timestamp_in_window()=2E This is the tran=
sport-agnostic decision step;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * the caller decides what to do with a stale probe and builds th=
e reply=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param probe_payload  p=
ayload of the received OOB SERVER_PROBE, consumed</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @param now            current time (UNIX s=
econds)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param wi=
ndow_secs    acceptable timestamp skew, in either direction</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * @param req            filled wit=
h the probe request unless the verdict is</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *                       OOB_PROBE_INVALID, for the r=
eply to echo its request_id</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+enum oob=
_probe_verdict oob_server_probe_check(struct buffer *probe_payload, uint64_=
t now,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
                                 uint64_t window_secs, struct oob_probe_req=
uest *req);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> #endif /* OOB_H */</span><br><span>diff --git a/tests/unit_tests/=
openvpn/test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec</span><br><spa=
n>index 656cb21=2E=2E0c9e79b 100644</span><br><span>--- a/tests/unit_tests/=
openvpn/test_oob=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_oo=
b=2Ec</span><br><span>@@ -359,6 +359,195 @@</span><br><span>     gc_free(&a=
mp;gc);</span><br><span> }</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/* A SERVER_PROBE carrying just a probe request is=
 found by the scan, along</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * with its request_id=2E */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+test_server_probe_read_finds_request(void **state)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc=
(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct oob_pr=
obe_request in =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        =2Erequest_id =3D 42,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        =2Etimestamp =3D 0x1122334455667788ULL,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        =2Eflags =3D 0,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_true(oob_probe_request_write(&amp;=
buf, &amp;in));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_re=
quest out =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_true(oob_server_probe_read(&amp;buf, &amp;out));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(out=2Erequest=
_id, 42);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_true(in=2Etimestamp =3D=3D out=2Etimestamp);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_int_equal(in=2Eflags, out=2Eflags);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
* TLVs other than probe request are skipped, so the scan finds the</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * probe request even when p=
receded by an unknown TLV=2E */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+test_server_probe_read_skips_unknown(void **state)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(12=
8, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* An unknown but opti=
onal TLV (type 0x7ff) =2E=2E=2E */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;buf, 0x7ff, t=
rue, 4));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_true(buf_write_u32(&amp;buf, 0xcafef00d));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* =2E=2E=2E followed by the real probe request=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct=
 oob_probe_request in =3D { =2Etimestamp =3D 42, =2Eflags =3D 0 };</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_probe_re=
quest_write(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct oob_probe_request out =3D { 0 };</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_true(oob_server_probe_read(&amp;buf, &amp;out)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(o=
ut=2Etimestamp =3D=3D 42);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(=
&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/* An unknown TLV that is NOT marked optional c=
arries something the sender</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * requires us to act on: the whole message is rejected, whether th=
at TLV comes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * befo=
re or after the one we were looking for=2E */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+test_server_probe_read_rejects_unknown_mandatory(void **s=
tate)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_ne=
w();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struc=
t oob_probe_request in =3D { =2Etimestamp =3D 42, =2Eflags =3D 0 };</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct buffer before =3D alloc_buf_gc(128,=
 &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_true(ctrl_msg_tlv_write_header(&amp;before, 0x7ff, false, 4));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(=
&amp;before, 0xcafef00d));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_true(oob_probe_request_write(&amp;before, &amp;in));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer after =3D alloc_buf_gc(=
128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_true(oob_probe_request_write(&amp;after, &amp;in));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_he=
ader(&amp;after, 0x7ff, false, 4));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_true(buf_write_u32(&amp;after, 0xcafef00d));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_request out =3D { 0 =
};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(=
oob_server_probe_read(&amp;before, &amp;out));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_false(oob_server_probe_read(&amp;afte=
r, &amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/* A payload with no probe request must be rejected=2E */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+test_server_probe_read_missin=
g(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc=
 =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;buf, 0x7ff, true, =
4));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true=
(buf_write_u32(&amp;buf, 0));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t oob_probe_request out =3D { 0 };</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_false(oob_server_probe_read(&amp;buf, &amp;out));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/* A TLV whose declared length runs past the buffer must be rejected, not=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * read out of boun=
ds=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_server_probe_r=
ead_truncated(void **state)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* TLV header claims a 16-byte value but no value=
 bytes follow */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_true(ctrl_msg_tlv_write_header(&amp;buf, 0x7ff, false, 16));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct oob_probe_request out =3D { 0 };</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(oob_=
server_probe_read(&amp;buf, &amp;out));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/* A payload carrying a probe repl=
y instead is not a SERVER_PROBE=2E */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+test_server_probe_read_reply_tlv(void **state)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(=
128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct oob_pro=
be_reply in =3D { =2Erequest_id =3D 42 };</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_true(oob_probe_reply_write(&amp;buf, &amp;=
in));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_request out =
=3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_false(oob_server_probe_read(&amp;buf, &amp;out));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Timestamp window =
check accepts values within the window (either direction)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * and rejects values outside it=2E *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+test_timestamp_in_window(v=
oid **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint64_t now =
=3D 1000000;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st uint64_t window =3D 30;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_t=
rue(oob_timestamp_in_window(now, now, window));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_true(oob_timestamp_in_window(now - w=
indow, now, window));      /* boundary, past */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_true(oob_timestamp_in_window(now + w=
indow, now, window));      /* boundary, future */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_false(oob_timestamp_in_window(now =
- window - 1, now, window)); /* too old */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_false(oob_timestamp_in_window(now + windo=
w + 1, now, window)); /* too far ahead */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A well-forme=
d probe with an in-window timestamp is answered=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+test_server_probe_check_valid(void **state)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =
=3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st uint64_t now =3D 1000000;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    const struct oob_probe_request probe =3D { =2Erequest_id =3D 1=
, =2Etimestamp =3D now, =2Eflags =3D 0 };</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_true(oob_probe_request_write(&amp;buf, &am=
p;probe));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_request=
 req =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_int_equal(oob_server_probe_check(&amp;buf, now, 30, &amp;req), OOB_P=
ROBE_OK);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_int_equal(req=2Erequest_id, 1);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc=
_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* A well-formed probe whose timestamp is=
 outside the window is stale; the</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * caller decides whether it still gets an answer=2E */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+test_server_probe_check_stale(voi=
d **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D =
gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    const uint64_t now =3D 1000000;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const struct oob_probe_request probe =3D { =2Erequ=
est_id =3D 7, =2Etimestamp =3D now - 1000, =2Eflags =3D 0 };</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_probe_request_=
write(&amp;buf, &amp;probe));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t oob_probe_request req =3D { 0 };</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_int_equal(oob_server_probe_check(&amp;buf, now, 3=
0, &amp;req), OOB_PROBE_STALE);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_int_equal(req=2Erequest_id, 7); /* a stale probe may=
 still be answered */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;=
gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/* A payload without a probe request is invalid (no =
reply)=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static =
void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_server_pro=
be_check_no_request(void **state)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;=
buf, 0x7ff, true, 4));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_true(buf_write_u32(&amp;buf, 0));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct oob_probe_request req;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_int_equal(oob_server_probe_check(&amp;buf=
, 1000000, 30, &amp;req), OOB_PROBE_INVALID);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span> /* The OOB tests run as a second group of pkt_testdriver; see test=
_pkt=2Ec=2E */</span><br><span> int</span><br><span> run_oob_tests(void)</s=
pan><br><span>@@ -375,6 +564,16 @@</span><br><span>         cmocka_unit_tes=
t(test_find_tlv_skips_optional_after_wanted),</span><br><span>         cmoc=
ka_unit_test(test_find_tlv_empty_payload),</span><br><span>         cmocka_=
unit_test(test_tlv_header_truncated),</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        cmocka_unit_test(test_server_probe_read_finds_req=
uest),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmock=
a_unit_test(test_server_probe_read_skips_unknown),</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_server_probe_r=
ead_rejects_unknown_mandatory),</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        cmocka_unit_test(test_server_probe_read_missing),</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(=
test_server_probe_read_truncated),</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        cmocka_unit_test(test_server_probe_read_reply_tlv),<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_=
test(test_timestamp_in_window),</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        cmocka_unit_test(test_server_probe_check_valid),</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(t=
est_server_probe_check_stale),</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        cmocka_unit_test(test_server_probe_check_no_request),</s=
pan><br><span>     };</span><br><span> </span><br><span>     return cmocka_=
run_group_tests_name(&quot;oob tests&quot;, tests, NULL, NULL);</span><br><=
/pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1742?usp=3Demail">change 1742</a>=2E To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1742?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpa=
tchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<=
div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30 </di=
v>
<div style=3D"display:none"> Gerrit-Change-Number: 1742 </div>
<div styl=
e=3D"display:none"> Gerrit-PatchSet: 18 </div>
<div style=3D"display:none">=
 Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@mand=
elbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plais=
thos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</b=
ody></html>
--KfA+SUarjno=--


--===============5707665692625352295==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5707665692625352295==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5707665692625352295==--

