Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D15ECA5FC6
	for <openvpn-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UWewxOeVbN5cPRysbJc0xhVVHveg3TzZIEBwZUzum9I=; b=Bmo2u25eUJ4+bRbFP6P8Fk3IcL
	iY3fcPLxxsHDmjRa+++it1qAauBFWuPlbRgI16xHG3tHJJ0F3D4K69qdwvuu2abOp/ZZGjPK/6Wsa
	I+Rsb2GBjZ/0Hg3oB0xXTlnBrD/Z3TUrZBg0EYQmaT94xMz3CQSBzg63iZMImhWFLXCI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBpeN-0003NJ-GN;
	Wed, 30 Sep 2026 08:26:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBpe2-0003FT-44
 for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 08:26:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ikpm2Gr/Bo59Wb3f+be3+bA5L9driwxPU/XgUBXkjbk=; b=TUJUIouiL50qeGVpS2lJkfFD2q
 cASWknrcEBeJviMz1vk4QLQvSH3MHBblyQ3/fMG7g3Jc8Y9zdPdUz8rB7dcOsGWtZ2irce0zQ2j+G
 5IQCO+kjUUPCXEtjykzThzb0bFBi4rhEVl+k/n76ERMW8fyGF4LAlk5Un6ac1vhRhWgw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ikpm2Gr/Bo59Wb3f+be3+bA5L9driwxPU/XgUBXkjbk=; b=c
 REBlKSNkokmMaHNSJRSvpjWRmiSJwP071yASTOd376vwfPBO72z+ggH5w8VvAOn6Wm9YSUTclf5hM
 3YNvvAhEmxYEkcTgAnmfFSW0dW9rARDwVJiz5VUgsuEL95hieR8PdR0izFg2No5DvQ+H9V2pMkTCE
 J8yuZBEqm2LNbBeg=;
Received: from mail-wr2-f35.google.com ([74.125.225.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBpdS-0006jQ-90 for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 08:25:58 +0000
Received: by mail-wr2-f35.google.com with SMTP id
 ffacd0b85a97d-4885a1480a2so2996409f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 30 Sep 2026 01:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790756748; x=1791361548; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ikpm2Gr/Bo59Wb3f+be3+bA5L9driwxPU/XgUBXkjbk=;
 b=LYrovDtliMcgv82jiautIHT7q68jS5zObW0v9zQ83Dc+rzLFNFuwsKS8PcpWTf5dSv
 gBblBI4j2G2CvUhRKszT5iW3jAANV/Ak041NRivMaLoblcbF305LkOWtytCwjugQN8YH
 9bSW2ohyp6xPsZ50TvyWSd3zzfMFRT6MCsvXiJwDByS3yEpofE+G4fcOxFvdbvuUR5il
 XCOPBV2AQ6rS6wUuBzxzo/UbwMO3nH2+JZJ1IlWdU83ztAHSQEe8ZSuAj4MO5kIiC/bw
 QUPvKZPw6V41sPZShoSzPeuGKFe/fv6bRCkh92FgjqXCLC1vnqjMWW3UchhjvjhnaxA1
 ijDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790756748; x=1791361548;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ikpm2Gr/Bo59Wb3f+be3+bA5L9driwxPU/XgUBXkjbk=;
 b=WSXYZx4AyhWbhvFVz9z2h7Sc8KdLukQ2wDJY8lrxD1VM/D/kEKF1nFDOcuZmXwDt3q
 xUjnbryZ/nSeDqOy3JZKSVEe/MQUssa5c7s0XSQ4LGn3dJAkcH3+URGsACVNV8vXVIEv
 SYUwHK3LqAOyIzP9ksZ4JgTzm7gFME2rjtxFpAmbE6WbriYcQX7DQvPVuB55yXLHzWgw
 4FaxgZcrJruGBebjuq6clM0fZ7f7kZvSWNJzqLx39beSqJ7Wk2lrtmuFmMlsIkMTnKoF
 KUrJfcxfVSPeWbGrH+S7VdwDzMljXxkwAtVLL7GXylkBLEQ1h/uFE/br+gtuH25vBh3b
 wDpQ==
X-Gm-Message-State: AFq9FYJNOWrzVq+067z6+oQtAhOBq58qSxrCzFB2AHSsg96fy00I//BD
 JiNeY1IzY8adteD040lfhkUIzzKNxFhZVNH0gDi3m30BqKesPqBvERigYJTxYWaxI0nDsuti7i6
 zMSj36QvGfSyO5S5thavJNThghr8lD3r59o0vimnjErx2QdwNS9gnYKv7Cv07H0ppCFhq
X-Gm-Gg: AYBFou06KcrjVXv/kSgQa/2ePe8sCg0fJxwsyN5gmsPSaTGgiLb0/EoY2WimBvUomae
 WAhUMZuu2rM89IENsnIuGY81YOB+gGQODbTrAoONj+3zIcYykN6eo6EtyI0ZW9BRrS8s1+8cp1z
 tHD0x+ATrfyD+d3yD+UvVv0o5VMxWZs74mG/ywubvTaNJAOCOsXMZHkbzizV0B+eWxkVE0aiffS
 nvi89hTcAZbKOwzVQv4ahAkQjf2Zn8l1EYTuT2ofAwjDy0kdXhXLBcoUs/6mBaRtNrP6fy8fXFV
 mFohWs73Rk05hhEC3VnMpb5CAeFZlbAKbE+IvQO/bxr7VMs+bT/pDHtFC98jFfYlEeXrUvfY15u
 nkuMw6vDKesgORzLJZ1omull1C4qlckCrxlSchO71VXLkgoBAZs9ZqbITHzFwSv7Yl6nnu+HFH8
 zhot5jwDNuCwX5sJqm2VoxBM/lsyzJkjrnGLRzeeYnSJqD6KbYdZpuj64jo1+MBh9qE5r5xGRns
 ggQRSueeyAeEXhPWh/8aXbGL2r1lXDztKMiFjcDbVD7jmLn9J91A5n1QOAmUoTua5JtkybsZJLI
 8z2FDQrQx4Hh7b62Ct7hfGlz36ic/0KIFMjo5aLKkprvyP1S/ksHqlYiMKLg
X-Received: by 2002:a05:6000:3c7:b0:485:8ee5:5ffa with SMTP id
 ffacd0b85a97d-48b02546054mr1357569f8f.38.1790756747556; 
 Wed, 30 Sep 2026 01:25:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b02a0d8bfsm1440172f8f.36.2026.09.30.01.25.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 01:25:47 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 30 Sep 2026 08:25:29 +0000
To: ralf_lici <ralf@mandelbit.com>, plaisthos <arne-openvpn@rfc2549.org>,
 flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 20
X-Gerrit-Change-Id: If04ce09d4c353f5384c0c48f48f63e05869a373f
X-Gerrit-Change-Number: 1745
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1745?usp=email>
X-Gerrit-Commit: b8f89d082547bc326614472e943b08150b2df26d
In-Reply-To: <gerrit.1782719911000.If04ce09d4c353f5384c0c48f48f63e05869a373f@gerrit.openvpn.net>
References: <gerrit.1782719911000.If04ce09d4c353f5384c0c48f48f63e05869a373f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklmMDRjZTA5ZDRjMzUzZjUzODRjMGM0OGY0OGY2M2UwNTg2OWEzNzNmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b864db192de567c0e4268d25eed16151dfa5c33b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBpdS-0006jQ-90
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Add client
 probe reply parser
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
Content-Type: multipart/mixed; boundary="===============5898074696464107012=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5898074696464107012==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Sy2imMVU3p0="; charset=UTF-8

--Sy2imMVU3p0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, ralf_lici, s=
tipa=2E

Hello flichtenheld, plaisthos, ralf_lici, 

I'd like you to reexam=
ine a change=2E Please visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1745?usp=3Demail

to look at the new patch set (#20)=2E


Change subject: =
oob: Add client probe reply parser
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

oob: Add client probe reply parser

Add oob_probe_re=
ply_find(), the client-side counterpart of
oob_probe_request_find(): it sca=
ns a received OOB message for the probe
reply TLV, skipping other and futur=
e TLV types that are marked
optional=2E The reply's request_id names the pr=
obe it answers, with
which the client matches the reply to its probe=2E

Ex=
ercised by unit tests; the client probe path calls it in a follow-up=2E

Ch=
ange-Id: If04ce09d4c353f5384c0c48f48f63e05869a373f
Signed-off-by: Lev Stipa=
kov <lev@openvpn=2Enet>
---
M src/openvpn/oob=2Ec
M src/openvpn/oob=2Eh
M t=
ests/unit_tests/openvpn/test_oob=2Ec
3 files changed, 123 insertions(+), 0 =
deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/c=
hanges/45/1745/20

diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec
i=
ndex 954694a=2E=2E5bd3ea6 100644
--- a/src/openvpn/oob=2Ec
+++ b/src/openvp=
n/oob=2Ec
@@ -93,6 +93,14 @@
 }
 
 bool
+oob_probe_reply_find(struct buffer=
 *payload, struct oob_probe_reply *reply)
+{
+    struct buffer value;
+   =
 return ctrl_msg_find_tlv(payload, TLV_TYPE_PROBE_REPLY, &value)
+         =
  && oob_probe_reply_read(&value, reply);
+}
+
+bool
 oob_timestamp_in_wind=
ow(uint64_t probe_ts, uint64_t now, uint64_t window_secs)
 {
     uint64_t =
diff =3D (now > probe_ts) ? (now - probe_ts) : (probe_ts - now);
diff --git=
 a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh
index 95b3afc=2E=2Ea388e61 100=
644
--- a/src/openvpn/oob=2Eh
+++ b/src/openvpn/oob=2Eh
@@ -111,6 +111,16 @=
@
 bool oob_probe_request_find(struct buffer *payload, struct oob_probe_req=
uest *req);
 
 /**
+ * Scan the payload of a received OOB message for the p=
robe reply TLV; the
+ * client-side counterpart of oob_probe_request_find()=
=2E
+ *
+ * @param payload  buffer positioned at the start of the OOB messa=
ge payload
+ * @param reply    filled with the parsed probe reply on succes=
s
+ * @return true if a well-formed probe reply was found, false otherwise
=
+ */
+bool oob_probe_reply_find(struct buffer *payload, struct oob_probe_re=
ply *reply);
+
+/**
  * Check whether a probe timestamp is within an accept=
able window around the
  * current time=2E Used to cheaply drop replayed or=
 implausibly-timed probes
  * before doing any further work (see the probe =
request timestamp rationale
diff --git a/tests/unit_tests/openvpn/test_oob=
=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec
index 8af595d=2E=2Ef1e64b7 100=
644
--- a/tests/unit_tests/openvpn/test_oob=2Ec
+++ b/tests/unit_tests/open=
vpn/test_oob=2Ec
@@ -527,6 +527,106 @@
     gc_free(&gc);
 }
 
+/* A payloa=
d of just a probe reply is found by the client scan, with all
+ * fields su=
rviving=2E */
+static void
+test_probe_reply_find(void **state)
+{
+    str=
uct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, =
&gc);
+
+    struct oob_probe_reply in =3D {
+        =2Erequest_id =3D 7,
=
+        =2Epriority =3D 5,
+        =2Eweight =3D 50,
+        =2Emax_late=
ncy_diff =3D 25,
+        =2Econnect_lifetime =3D 120,
+        =2Eflags =
=3D 1,
+    };
+    assert_true(oob_probe_reply_write(&buf, &in));
+
+    s=
truct oob_probe_reply out =3D { 0 };
+    assert_true(oob_probe_reply_find(=
&buf, &out));
+    assert_int_equal(out=2Erequest_id, in=2Erequest_id);
+  =
  assert_int_equal(out=2Epriority, in=2Epriority);
+    assert_int_equal(ou=
t=2Eweight, in=2Eweight);
+    assert_int_equal(out=2Emax_latency_diff, in=
=2Emax_latency_diff);
+    assert_int_equal(out=2Econnect_lifetime, in=2Eco=
nnect_lifetime);
+    assert_int_equal(out=2Eflags, in=2Eflags);
+
+    gc_=
free(&gc);
+}
+
+/* TLVs other than the probe reply are skipped=2E */
+stat=
ic void
+test_probe_reply_find_skips_unknown(void **state)
+{
+    struct g=
c_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);=

+
+    assert_true(ctrl_msg_tlv_write_header(&buf, 0x7ff, true, 4));
+    =
assert_true(buf_write_u32(&buf, 0xabad1dea));
+    struct oob_probe_reply i=
n =3D { =2Epriority =3D 7 };
+    assert_true(oob_probe_reply_write(&buf, &=
in));
+
+    struct oob_probe_reply out =3D { 0 };
+    assert_true(oob_pro=
be_reply_find(&buf, &out));
+    assert_int_equal(out=2Epriority, 7);
+
+  =
  gc_free(&gc);
+}
+
+/* As on the probe side, a mandatory TLV we do not un=
derstand -- here trailing
+ * the probe reply -- invalidates the reply=2E *=
/
+static void
+test_probe_reply_find_rejects_unknown_mandatory(void **stat=
e)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D allo=
c_buf_gc(128, &gc);
+
+    struct oob_probe_reply in =3D { =2Epriority =3D =
7 };
+    assert_true(oob_probe_reply_write(&buf, &in));
+    assert_true(c=
trl_msg_tlv_write_header(&buf, 0x7ff, false, 4));
+    assert_true(buf_writ=
e_u32(&buf, 0xabad1dea));
+
+    struct oob_probe_reply out =3D { 0 };
+   =
 assert_false(oob_probe_reply_find(&buf, &out));
+
+    gc_free(&gc);
+}
+
=
+/* A payload with no probe reply is rejected=2E */
+static void
+test_prob=
e_reply_find_missing(void **state)
+{
+    struct gc_arena gc =3D gc_new();=

+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    assert_true(ctrl=
_msg_tlv_write_header(&buf, 0x7ff, true, 4));
+    assert_true(buf_write_u3=
2(&buf, 0));
+
+    struct oob_probe_reply out =3D { 0 };
+    assert_false=
(oob_probe_reply_find(&buf, &out));
+
+    gc_free(&gc);
+}
+
+/* Likewise,=
 a payload carrying a probe request instead holds no probe reply=2E */
+sta=
tic void
+test_probe_reply_find_request_tlv(void **state)
+{
+    struct gc=
_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
=
+
+    const struct oob_probe_request in =3D { =2Erequest_id =3D 7 };
+    =
assert_true(oob_probe_request_write(&buf, &in));
+
+    struct oob_probe_re=
ply out =3D { 0 };
+    assert_false(oob_probe_reply_find(&buf, &out));
+
+=
    gc_free(&gc);
+}
+
 /* The OOB tests run as a second group of pkt_testd=
river; see test_pkt=2Ec=2E */
 int
 run_oob_tests(void)
@@ -552,6 +652,11 @=
@
         cmocka_unit_test(test_probe_request_check_valid),
         cmock=
a_unit_test(test_probe_request_check_stale),
         cmocka_unit_test(test=
_probe_request_check_no_request),
+        cmocka_unit_test(test_probe_repl=
y_find),
+        cmocka_unit_test(test_probe_reply_find_skips_unknown),
+ =
       cmocka_unit_test(test_probe_reply_find_rejects_unknown_mandatory),
+=
        cmocka_unit_test(test_probe_reply_find_missing),
+        cmocka_un=
it_test(test_probe_reply_find_request_tlv),
     };
 
     return cmocka_ru=
n_group_tests_name("oob tests", tests, NULL, NULL);

-- 
To view, visit htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1745?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerri=
t-Branch: master
Gerrit-Change-Id: If04ce09d4c353f5384c0c48f48f63e05869a373=
f
Gerrit-Change-Number: 1745
Gerrit-PatchSet: 20
Gerrit-Owner: stipa <lstip=
akov@gmail=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
G=
errit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ral=
f_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: ralf_lici <ralf@mandelbit=2Ecom>
Ge=
rrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Attention: plaisthos <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenhe=
ld=2Ecom>

--Sy2imMVU3p0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, ralf_lici, stipa=2E </p>
<p>=
stipa <strong>uploaded patch set #20</strong> to this change=2E</p><p><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1745?usp=3Demail">View Chan=
ge</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">oob: Add client probe reply parser<br><br>Add oob_p=
robe_reply_find(), the client-side counterpart of<br>oob_probe_request_find=
(): it scans a received OOB message for the probe<br>reply TLV, skipping ot=
her and future TLV types that are marked<br>optional=2E The reply&#39;s req=
uest_id names the probe it answers, with<br>which the client matches the re=
ply to its probe=2E<br><br>Exercised by unit tests; the client probe path c=
alls it in a follow-up=2E<br><br>Change-Id: If04ce09d4c353f5384c0c48f48f63e=
05869a373f<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<=
br>M src/openvpn/oob=2Ec<br>M src/openvpn/oob=2Eh<br>M tests/unit_tests/ope=
nvpn/test_oob=2Ec<br>3 files changed, 123 insertions(+), 0 deletions(-)<br>=
<br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn=
 refs/changes/45/1745/20</pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/src/openvpn/oob=2Ec b/src/ope=
nvpn/oob=2Ec</span><br><span>index 954694a=2E=2E5bd3ea6 100644</span><br><s=
pan>--- a/src/openvpn/oob=2Ec</span><br><span>+++ b/src/openvpn/oob=2Ec</sp=
an><br><span>@@ -93,6 +93,14 @@</span><br><span> }</span><br><span> </span>=
<br><span> bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_=
probe_reply_find(struct buffer *payload, struct oob_probe_reply *reply)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer value;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    return ctrl_msg_find_tlv(payload=
, TLV_TYPE_PROBE_REPLY, &amp;value)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+           &amp;&amp; oob_probe_reply_read(&amp;value, repl=
y);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+bool</span><br><span> oob_timestamp_in_window(uint64_=
t probe_ts, uint64_t now, uint64_t window_secs)</span><br><span> {</span><b=
r><span>     uint64_t diff =3D (now &gt; probe_ts) ? (now - probe_ts) : (pr=
obe_ts - now);</span><br><span>diff --git a/src/openvpn/oob=2Eh b/src/openv=
pn/oob=2Eh</span><br><span>index 95b3afc=2E=2Ea388e61 100644</span><br><spa=
n>--- a/src/openvpn/oob=2Eh</span><br><span>+++ b/src/openvpn/oob=2Eh</span=
><br><span>@@ -111,6 +111,16 @@</span><br><span> bool oob_probe_request_fin=
d(struct buffer *payload, struct oob_probe_request *req);</span><br><span> =
</span><br><span> /**</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * Scan the payload of a received OOB message for the probe reply TLV; th=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * client-side cou=
nterpart of oob_probe_request_find()=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @param payload  buffer positioned at the start of the OOB message pay=
load</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param reply=
    filled with the parsed probe reply on success</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @return true if a well-formed probe reply =
was found, false otherwise</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool oob_=
probe_reply_find(struct buffer *payload, struct oob_probe_reply *reply);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span>  * Check whether a p=
robe timestamp is within an acceptable window around the</span><br><span>  =
* current time=2E Used to cheaply drop replayed or implausibly-timed probes=
</span><br><span>  * before doing any further work (see the probe request t=
imestamp rationale</span><br><span>diff --git a/tests/unit_tests/openvpn/te=
st_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>index 8a=
f595d=2E=2Ef1e64b7 100644</span><br><span>--- a/tests/unit_tests/openvpn/te=
st_oob=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_oob=2Ec</spa=
n><br><span>@@ -527,6 +527,106 @@</span><br><span>     gc_free(&amp;gc);</s=
pan><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* A payload of just a probe reply is found by the client sc=
an, with all</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * fiel=
ds surviving=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_prob=
e_reply_find(void **state)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct oob_probe_reply in =3D {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        =2Erequest_id =3D 7,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        =2Epriority =3D 5,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Eweight =3D =
50,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Emax_l=
atency_diff =3D 25,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        =2Econnect_lifetime =3D 120,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        =2Eflags =3D 1,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_true(oob_probe_reply_write(&amp;buf, &amp;in));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct oob_probe_reply out =3D { 0 };</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_probe=
_reply_find(&amp;buf, &amp;out));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_int_equal(out=2Erequest_id, in=2Erequest_id);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(out=
=2Epriority, in=2Epriority);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_int_equal(out=2Eweight, in=2Eweight);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(out=2Emax_latenc=
y_diff, in=2Emax_latency_diff);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_int_equal(out=2Econnect_lifetime, in=2Econnect_lifet=
ime);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int=
_equal(out=2Eflags, in=2Eflags);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc=
_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* TLVs other than the probe reply are sk=
ipped=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static v=
oid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_probe_reply=
_find_skips_unknown(void **state)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;=
buf, 0x7ff, true, 4));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_true(buf_write_u32(&amp;buf, 0xabad1dea));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_reply in =3D { =
=2Epriority =3D 7 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_true(oob_probe_reply_write(&amp;buf, &amp;in));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct oob_probe_reply out =3D { 0 };</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_probe_reply_=
find(&amp;buf, &amp;out));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_int_equal(out=2Epriority, 7);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/* As on the probe side, a=
 mandatory TLV we do not understand -- here trailing</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * the probe reply -- invalidates the rep=
ly=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_probe_reply_fi=
nd_rejects_unknown_mandatory(void **state)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_reply in =3D { =
=2Epriority =3D 7 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_true(oob_probe_reply_write(&amp;buf, &amp;in));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_=
header(&amp;buf, 0x7ff, false, 4));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_true(buf_write_u32(&amp;buf, 0xabad1dea));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct oob_probe_reply out =3D { 0 };</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(oob_p=
robe_reply_find(&amp;buf, &amp;out));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/* A payload with no probe reply is =
rejected=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stati=
c void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_probe_re=
ply_find_missing(void **state)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;buf=
, 0x7ff, true, 4));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_true(buf_write_u32(&amp;buf, 0));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct oob_probe_reply out =3D { 0 };</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_false(oob_probe_reply_find(&amp;buf,=
 &amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* Likewise, a payload carrying a probe request instead hold=
s no probe reply=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_=
probe_reply_find_request_tlv(void **state)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    const struct oob_probe_request in =
=3D { =2Erequest_id =3D 7 };</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_true(oob_probe_request_write(&amp;buf, &amp;in));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct oob_probe_reply out =3D { 0 };</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(oob_p=
robe_reply_find(&amp;buf, &amp;out));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
 /* The OOB tests run as a second group of pkt_testdriver; see test_pkt=2Ec=
=2E */</span><br><span> int</span><br><span> run_oob_tests(void)</span><br>=
<span>@@ -552,6 +652,11 @@</span><br><span>         cmocka_unit_test(test_p=
robe_request_check_valid),</span><br><span>         cmocka_unit_test(test_p=
robe_request_check_stale),</span><br><span>         cmocka_unit_test(test_p=
robe_request_check_no_request),</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        cmocka_unit_test(test_probe_reply_find),</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_prob=
e_reply_find_skips_unknown),</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        cmocka_unit_test(test_probe_reply_find_rejects_unknown_man=
datory),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmo=
cka_unit_test(test_probe_reply_find_missing),</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_probe_reply_find_re=
quest_tlv),</span><br><span>     };</span><br><span> </span><br><span>     =
return cmocka_run_group_tests_name(&quot;oob tests&quot;, tests, NULL, NULL=
);</span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1745?usp=3Demail">change 1745</a>=2E To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://s=
chema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1745?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: o=
penvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<di=
v style=3D"display:none"> Gerrit-Change-Id: If04ce09d4c353f5384c0c48f48f63e=
05869a373f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1745 <=
/div>
<div style=3D"display:none"> Gerrit-PatchSet: 20 </div>
<div style=3D=
"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenh=
eld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaistho=
s &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"=
display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefor=
ge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lic=
i &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-A=
ttention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lic=
htenheld=2Ecom&gt; </div>

</body></html>
--Sy2imMVU3p0=--


--===============5898074696464107012==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5898074696464107012==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5898074696464107012==--

