Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3706C43327
	for <openvpn-devel@archiver.kernel.org>; Mon, 29 Jun 2026 07:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=Ahn7GfUfGsw3xlcxE6XnP0S/8tII6cbvpr6QiaM6AIY=; b=E15mM9RjOsUteX
	ZSvCiC9iffGFeIFOFE7EjwotBr60lrwwB7XR69qZtvAX9uBPYDTxgbbmAJSnFVe9vRaXsr0p8NlHo
	Buenn4y37P9oSEf7GY8w9Q6oX4c1AVvL81EQk17Js4uvOZ+sNZu2ibEHBskC4E+Ob1tCDpSghghvS
	f40=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1we6tY-0004ur-PO;
	Mon, 29 Jun 2026 07:59:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1we6tX-0004ul-9t
 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 07:59:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yQPchfVEiSizzs5R+lZj+DcNj8r5ZLIn7P9mxKt6ezI=; b=kIKpRFPMLb9/aBpmZJn56QTcE+
 QT2j8fYdCsyI37mZYmC9kCjjS3ADGi860mUxHInZHngaGi2kVRvfXzRTpyXybBq+DauQyGksNYjVV
 tAqyTd9JuC8/kP0yNBP92EgrvNw6YAGCm6RJDcCQhJEOSbePJk91BRqYR1Dn2WCGSlws=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=yQPchfVEiSizzs5R+lZj+DcNj8r5ZLIn7P9mxKt6ezI=; b=X
 fC9LzOlUJ+ifHfVTUgOgUDKADcGL4N70tLcnxMNiiNaQvn+Q7E6oudIrx3b0MKdl5TOyygOjtkpsi
 /k7aR1fGqi5jzr4fEYL3DTgg1fUq7WX+pw8tgn4HA1koXXGpl0w1Ov5UPNETkFvjH7kn4RA/wJgcl
 RCzkwANkqrWbNHsg=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1we6tV-0008NH-J0 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 07:59:07 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-4728c12ba97so629911f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 29 Jun 2026 00:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782719934; x=1783324734; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yQPchfVEiSizzs5R+lZj+DcNj8r5ZLIn7P9mxKt6ezI=;
 b=Ts4r85bGuoMP6jt4pzU4HROQS3RcGs1JLFUE2EB0h96F+irB1cVaFuKeOR8CvmFtFh
 26pfeKkj/dIrm2dxI1Y2jblsmtocrFqDNLEXx2LCp8cE/5Eq6zd96WvhwFrPEtH+Jve1
 lP0XVkokrng2gTb38dxwVKTXXyk/PJ5/IBjKxr3hopNc8kcwetXrqdC/P0rmosXRrGLm
 17Hk1E6STgrTPhRtu/zymJfuCiaPWKYZTFzpGN4x24JtBe6toykzBpBr3EV1tlVceHEB
 opesnFI/asyUCvPH2AntNGIHFIcaQewBLcma0evaGiL5oh88u0mrDccuqy/m1+K/Q24w
 mFZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782719934; x=1783324734;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yQPchfVEiSizzs5R+lZj+DcNj8r5ZLIn7P9mxKt6ezI=;
 b=jOCUiliUNrYHS4Z7wO38jBuhz9Ote8eMo2MTa0LdB0o3Xdg6zg71bIZr16+AK95f3p
 GRaVvMwywu2z2cmPHVBSvNjiC4iPZaibht3VrOGVdDsflelQTOKkL48piJ7jGbd+3YNr
 6KQK+MpOopS40qNGBFmIo/tzUNK+U4YjnAX93edD4cxGudwtjJaUl/4awK0efWgHUi2W
 kQauQmGIP3z9XioXp3K/YOLkQOLNSHSnKw7N04/lvc2G1xxGuMv0hpj4Mx8rmSrm1H4D
 wSQ/T+WX+ZyRP6wL7rb1ThUoHkVPhJqvMxKJK11xj8f1bNgDzYEFoBsBI4vqIzj9cqqu
 OYSQ==
X-Gm-Message-State: AOJu0YwcnKayme9hQ3GMDO1Qj3MJ3EIKA8/QJV0kSSxarPrB9ED7TZIN
 SFahNTHb70N0YYBMLomLSsXsED4XT7j8P/camkSrHHQBvhedJMYKZVJvy7RhlfWQeV+dTtow1O/
 s78nZjv26u2r3oU2zickBr5OWUaBN3wib2jf63DU5/CunA52bZSNMV1PiDwwe3T92SgNSPQBz22
 YeTaZcTg==
X-Gm-Gg: AfdE7cm04j/5ch7AtalMaAX4tdZZ89ql+EbvJ2bCPYOipb7mKvAEiUKcRDDV3I+MJ18
 +1eZISenNybCTATWWb6cM1/cQ2IwlP/eXvRSnN1YXThvIxpTUPpos2VGvPNU9qCT6VVnAaMgHdO
 C1BKLanOs+KawiYcyaV2JbFcHaYSZb1V1GtkXSTaIOBrHbM8dEB31A3hVqLsZ7L7WF+oJp7HD6A
 mimWEQ/fYADKGwaz1C7fbKYHbEjJy6sXXPQp8HPOeh3lW0I79nOZZsgnaQotMRb4IYOKADNuk3k
 PYmUKWM9/twdFljIgjPE5rtjGSUKHXgnPWRO56E6Z/QXHHfLBK63Aan+DhCdnHMdxCbjUyDp1+a
 eeIbv5F0ohuNGOecQGbhTj8XnfkhkRwg0+vD9o2PUodLnD9P4B/eZMd72rY4HdxQhNJBHawu0q1
 IVQUuWu3NiJm3i1NQijywMCyDYQd6i5DaTc230WZ4VI9heFSz23MmCbsSSBK65r4oCOobz8ECjl
 KoDZ+tfliZxtsjSgv02BURmM2gPeJ1DfcYojVwv9NBJk5ijNn+Xaap21IB/a99YlgIBC/VD3VBx
 rC8=
X-Received: by 2002:a5d:588b:0:b0:461:a16c:d88d with SMTP id
 ffacd0b85a97d-46dc0efe59dmr25419010f8f.26.1782719934339; 
 Mon, 29 Jun 2026 00:58:54 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47327c47122sm11755637f8f.34.2026.06.29.00.58.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 00:58:53 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 29 Jun 2026 07:58:53 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30
X-Gerrit-Change-Number: 1742
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1742?usp=email>
X-Gerrit-Commit: caefe6c905a8f9a6fecf18b0301daa8fdc444f51
References: <gerrit.1782719911000.Iafa9efc1c156974ad9f5752e9de810a8c2f68c30@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklhZmE5ZWZjMWMxNTY5NzRhZDlmNTc1MmU5ZGU4MTBhOGMyZjY4YzMwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <46eddd63a2788d0d6674974b2d202d4c452c2ead-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1we6tV-0008NH-J0
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
 openvpn-devel@lists.sourceforge.net
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3363803169997427189=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3363803169997427189==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NsZUieySTeo="; charset=UTF-8

--NsZUieySTeo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1742?usp=3Demail

to review the following change=2E


Chang=
e subject: oob: Add SERVER_PROBE parsing and the probe-reply decision
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Add SERVER_=
PROBE parsing and the probe-reply decision

Add the message-level helpers t=
he server needs to answer a probe:

  - oob_server_probe_read() scans the T=
LV payload of a received OOB
    SERVER_PROBE for the probe_parameter TLV, =
skipping other/future TLV
    types and rejecting malformed or truncated in=
put=2E
  - oob_timestamp_in_window() performs the cheap replay/skew check o=
n the
    probe timestamp described in the wire protocol specification=2E
 =
 - oob_build_probe_reply() composes the two: given a received SERVER_PROBE
=
    it scans for the probe_parameter, drops the probe if it is missing or
 =
   its timestamp is outside the acceptable window, and otherwise populates
=
    the probe_reply (echoing the peer's session id) to send back=2E

These =
are pure functions exercised by unit tests; the server packet path
calls oo=
b_build_probe_reply() in a follow-up, which performs the actual send=2E

Ch=
ange-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30
Signed-off-by: Lev Stipa=
kov <lev@openvpn=2Enet>
---
M src/openvpn/oob=2Ec
M src/openvpn/oob=2Eh
M t=
ests/unit_tests/openvpn/test_oob=2Ec
3 files changed, 303 insertions(+), 0 =
deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/=
changes/42/1742/1

diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec
i=
ndex 9f123e2=2E=2E58d47c0 100644
--- a/src/openvpn/oob=2Ec
+++ b/src/openvp=
n/oob=2Ec
@@ -152,3 +152,71 @@
     r->max_latency_diff =3D (uint16_t)max_l=
atency_diff;
     return oob_skip_trailing(buf, value_len, OOB_PROBE_REPLY_=
LEN);
 }
+
+bool
+oob_server_probe_write(struct buffer *buf, const struct o=
ob_probe_parameter *param)
+{
+    return oob_msg_write_header(buf, OOB_MSG=
_SERVER_PROBE)
+           && oob_probe_parameter_write(buf, param);
+}
+
+=
bool
+oob_server_probe_read(struct buffer *payload, struct oob_probe_parame=
ter *param)
+{
+    if (!oob_msg_read_header(payload, OOB_MSG_SERVER_PROBE)=
)
+    {
+        return false;
+    }
+
+    /* A TLV header is 4 bytes (t=
ype + length)=2E Loop until we either find the
+     * probe_parameter or r=
un out of well-formed TLVs=2E */
+    while (BLEN(payload) >=3D 4)
+    {
+=
        uint16_t type;
+        bool optional;
+        uint16_t value_len;=

+        if (!oob_tlv_read_header(payload, &type, &optional, &value_len))
=
+        {
+            return false;
+        }
+        if (type =3D=3D O=
OB_TLV_PROBE_PARAMETER)
+        {
+            return oob_probe_parameter_=
read(payload, param, value_len);
+        }
+        /* not the TLV we are =
looking for: skip its value and keep scanning */
+        if (!buf_advance(=
payload, value_len))
+        {
+            return false;
+        }
+    =
}
+    return false;
+}
+
+bool
+oob_timestamp_in_window(uint64_t probe_ts,=
 uint64_t now, uint64_t window_secs)
+{
+    uint64_t diff =3D (now > probe=
_ts) ? (now - probe_ts) : (probe_ts - now);
+    return diff <=3D window_se=
cs;
+}
+
+bool
+oob_build_probe_reply(struct buffer *probe_payload, uint64_=
t now, uint64_t window_secs,
+                      const struct session_id=
 *peer_sid, struct oob_probe_reply *reply)
+{
+    struct oob_probe_paramet=
er param;
+    if (!oob_server_probe_read(probe_payload, &param))
+    {
+ =
       return false;
+    }
+
+    /* Drop replayed or implausibly-timed pr=
obes before doing any more work=2E */
+    if (!oob_timestamp_in_window(par=
am=2Etimestamp, now, window_secs))
+    {
+        return false;
+    }
+
+=
    memset(reply, 0, sizeof(*reply));
+    reply->peer_session_id =3D *peer=
_sid;
+    /* priority/weight/connect_lifetime/flags left at 0 for now */
+=
    return true;
+}
diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh
=
index c32a7db=2E=2E48fcfa1 100644
--- a/src/openvpn/oob=2Eh
+++ b/src/openv=
pn/oob=2Eh
@@ -144,4 +144,56 @@
  */
 bool oob_probe_reply_read(struct buff=
er *buf, struct oob_probe_reply *r, uint16_t value_len);
 
+/**
+ * Write a=
 complete SERVER_PROBE message (message-type header + probe_parameter
+ * T=
LV) to @p buf=2E Sent by the client=2E
+ */
+bool oob_server_probe_write(st=
ruct buffer *buf, const struct oob_probe_parameter *param);
+
+/**
+ * Read=
 a received OOB SERVER_PROBE: verify its message-type header, then scan
+ *=
 for the probe_parameter TLV=2E TLV types other than probe_parameter are
+ =
* skipped, so the scan tolerates additional/future TLVs=2E @p payload is co=
nsumed
+ * as it is read=2E
+ *
+ * @param payload  buffer positioned at th=
e start of the OOB message payload
+ * @param param    filled with the pars=
ed probe_parameter on success
+ * @return true if the header matched and a =
well-formed probe_parameter was
+ *         found, false otherwise
+ */
+bo=
ol oob_server_probe_read(struct buffer *payload, struct oob_probe_parameter=
 *param);
+
+/**
+ * Check whether a probe timestamp is within an acceptabl=
e window around the
+ * current time=2E Used to cheaply drop replayed or im=
plausibly-timed probes
+ * before doing any further work (see the probe_par=
ameter timestamp rationale
+ * in the wire protocol specification)=2E
+ *
+=
 * @param probe_ts     timestamp from the probe_parameter (UNIX seconds)
+ =
* @param now          current time (UNIX seconds)
+ * @param window_secs  m=
aximum allowed difference, in either direction
+ * @return true if |now - p=
robe_ts| <=3D window_secs
+ */
+bool oob_timestamp_in_window(uint64_t probe=
_ts, uint64_t now, uint64_t window_secs);
+
+/**
+ * Process the TLV payloa=
d of a received SERVER_PROBE and decide whether to
+ * answer it=2E Combine=
s oob_server_probe_read() and oob_timestamp_in_window():
+ * the probe is d=
ropped (false returned) if it has no valid probe_parameter or
+ * its times=
tamp is outside the acceptable window=2E On success @p reply is
+ * populat=
ed with the peer's session id echoed back and the remaining fields
+ * zero=
ed, ready to be wrapped and sent=2E
+ *
+ * This is the transport-agnostic =
decision step; the caller performs the send=2E
+ *
+ * @param probe_payload=
  TLV payload of the received OOB SERVER_PROBE
+ * @param now            cu=
rrent time (UNIX seconds)
+ * @param window_secs    acceptable timestamp sk=
ew, in either direction
+ * @param peer_sid       session id of the request=
ing peer (echoed in the reply)
+ * @param reply          filled with the re=
ply to send on success
+ * @return true if a reply should be sent, false to=
 silently drop the probe
+ */
+bool oob_build_probe_reply(struct buffer *pr=
obe_payload, uint64_t now, uint64_t window_secs,
+                         =
  const struct session_id *peer_sid, struct oob_probe_reply *reply);
+
 #en=
dif /* OOB_H */
diff --git a/tests/unit_tests/openvpn/test_oob=2Ec b/tests/=
unit_tests/openvpn/test_oob=2Ec
index 40dcaf9=2E=2Ea9998d2 100644
--- a/tes=
ts/unit_tests/openvpn/test_oob=2Ec
+++ b/tests/unit_tests/openvpn/test_oob=
=2Ec
@@ -172,6 +172,180 @@
     gc_free(&gc);
 }
 
+/* A SERVER_PROBE carry=
ing just a probe_parameter is found by the scan=2E */
+static void
+test_se=
rver_probe_read_finds_parameter(void **state)
+{
+    struct gc_arena gc =
=3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    con=
st struct oob_probe_parameter in =3D {
+        =2Etimestamp =3D 0x11223344=
55667788ULL,
+        =2Eflags =3D 0,
+    };
+    assert_true(oob_server_p=
robe_write(&buf, &in));
+
+    struct oob_probe_parameter out =3D { 0 };
+ =
   assert_true(oob_server_probe_read(&buf, &out));
+    assert_true(in=2Eti=
mestamp =3D=3D out=2Etimestamp);
+    assert_int_equal(in=2Eflags, out=2Efl=
ags);
+
+    gc_free(&gc);
+}
+
+/* TLVs other than probe_parameter are ski=
pped, so the scan finds the
+ * probe_parameter even when preceded by an un=
known TLV=2E */
+static void
+test_server_probe_read_skips_unknown(void **s=
tate)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D a=
lloc_buf_gc(128, &gc);
+
+    /* SERVER_PROBE message header, then an unkno=
wn TLV (type 0x7ff) =2E=2E=2E */
+    assert_true(oob_msg_write_header(&buf=
, OOB_MSG_SERVER_PROBE));
+    assert_true(oob_tlv_write_header(&buf, 0x7ff=
, false, 4));
+    assert_true(buf_write_u32(&buf, 0xcafef00d));
+    /* =
=2E=2E=2E followed by the real probe_parameter */
+    const struct oob_pro=
be_parameter in =3D { =2Etimestamp =3D 42, =2Eflags =3D 0 };
+    assert_tr=
ue(oob_probe_parameter_write(&buf, &in));
+
+    struct oob_probe_parameter=
 out =3D { 0 };
+    assert_true(oob_server_probe_read(&buf, &out));
+    a=
ssert_true(out=2Etimestamp =3D=3D 42);
+
+    gc_free(&gc);
+}
+
+/* A payl=
oad with no probe_parameter must be rejected=2E */
+static void
+test_serve=
r_probe_read_missing(void **state)
+{
+    struct gc_arena gc =3D gc_new();=

+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    assert_true(oob_=
msg_write_header(&buf, OOB_MSG_SERVER_PROBE));
+    assert_true(oob_tlv_wri=
te_header(&buf, 0x7ff, false, 4));
+    assert_true(buf_write_u32(&buf, 0))=
;
+
+    struct oob_probe_parameter out =3D { 0 };
+    assert_false(oob_se=
rver_probe_read(&buf, &out));
+
+    gc_free(&gc);
+}
+
+/* A TLV whose dec=
lared length runs past the buffer must be rejected, not
+ * read out of bou=
nds=2E */
+static void
+test_server_probe_read_truncated(void **state)
+{
+=
    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_g=
c(128, &gc);
+
+    /* TLV header claims a 16-byte value but no value bytes=
 follow */
+    assert_true(oob_msg_write_header(&buf, OOB_MSG_SERVER_PROBE=
));
+    assert_true(oob_tlv_write_header(&buf, 0x7ff, false, 16));
+
+    =
struct oob_probe_parameter out =3D { 0 };
+    assert_false(oob_server_prob=
e_read(&buf, &out));
+
+    gc_free(&gc);
+}
+
+/* A SERVER_PROBE reader re=
jects a payload carrying a different message type
+ * (here a PROBE_REPLY's=
), even if it contains a valid probe_parameter TLV=2E */
+static void
+test=
_server_probe_read_wrong_msg_type(void **state)
+{
+    struct gc_arena gc =
=3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    ass=
ert_true(oob_msg_write_header(&buf, OOB_MSG_PROBE_REPLY));
+    const struc=
t oob_probe_parameter in =3D { =2Etimestamp =3D 42, =2Eflags =3D 0 };
+    =
assert_true(oob_probe_parameter_write(&buf, &in));
+
+    struct oob_probe_=
parameter out =3D { 0 };
+    assert_false(oob_server_probe_read(&buf, &out=
));
+
+    gc_free(&gc);
+}
+
+/* Timestamp window check accepts values wit=
hin the window (either direction)
+ * and rejects values outside it=2E */
+=
static void
+test_timestamp_in_window(void **state)
+{
+    const uint64_t =
now =3D 1000000;
+    const uint64_t window =3D 30;
+
+    assert_true(oob_=
timestamp_in_window(now, now, window));
+    assert_true(oob_timestamp_in_w=
indow(now - window, now, window));      /* boundary, past */
+    assert_tr=
ue(oob_timestamp_in_window(now + window, now, window));      /* boundary, f=
uture */
+    assert_false(oob_timestamp_in_window(now - window - 1, now, w=
indow)); /* too old */
+    assert_false(oob_timestamp_in_window(now + wind=
ow + 1, now, window)); /* too far ahead */
+}
+
+/* A valid, in-window SERV=
ER_PROBE yields a reply that echoes the peer's
+ * session id and zeroes th=
e remaining fields=2E */
+static void
+test_build_probe_reply_valid(void **=
state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D =
alloc_buf_gc(128, &gc);
+
+    const uint64_t now =3D 1000000;
+    const s=
truct oob_probe_parameter probe =3D { =2Etimestamp =3D now, =2Eflags =3D 0 =
};
+    assert_true(oob_server_probe_write(&buf, &probe));
+
+    struct se=
ssion_id peer;
+    memcpy(peer=2Eid, "PEER1234", SID_SIZE);
+
+    struct =
oob_probe_reply reply;
+    assert_true(oob_build_probe_reply(&buf, now, 30=
, &peer, &reply));
+    assert_memory_equal(reply=2Epeer_session_id=2Eid, p=
eer=2Eid, SID_SIZE);
+    assert_int_equal(reply=2Epriority, 0);
+    asser=
t_int_equal(reply=2Eweight, 0);
+    assert_int_equal(reply=2Econnect_lifet=
ime, 0);
+    assert_int_equal(reply=2Eflags, 0);
+
+    gc_free(&gc);
+}
+=

+/* A probe whose timestamp is outside the window is dropped (no reply)=2E=
 */
+static void
+test_build_probe_reply_stale(void **state)
+{
+    struct=
 gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc=
);
+
+    const uint64_t now =3D 1000000;
+    const struct oob_probe_param=
eter probe =3D { =2Etimestamp =3D now - 1000, =2Eflags =3D 0 };
+    assert=
_true(oob_server_probe_write(&buf, &probe));
+
+    struct session_id peer =
=3D { 0 };
+    struct oob_probe_reply reply;
+    assert_false(oob_build_p=
robe_reply(&buf, now, 30, &peer, &reply));
+
+    gc_free(&gc);
+}
+
+/* A =
payload without a probe_parameter is dropped (no reply)=2E */
+static void
=
+test_build_probe_reply_no_parameter(void **state)
+{
+    struct gc_arena =
gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    =
assert_true(oob_msg_write_header(&buf, OOB_MSG_SERVER_PROBE));
+    assert_=
true(oob_tlv_write_header(&buf, 0x7ff, false, 4));
+    assert_true(buf_wri=
te_u32(&buf, 0));
+
+    struct session_id peer =3D { 0 };
+    struct oob_=
probe_reply reply;
+    assert_false(oob_build_probe_reply(&buf, 1000000, 3=
0, &peer, &reply));
+
+    gc_free(&gc);
+}
+
 int
 main(void)
 {
@@ -182,6=
 +356,15 @@
         cmocka_unit_test(test_probe_parameter_forward_compat),=

         cmocka_unit_test(test_probe_parameter_too_short),
         cmocka=
_unit_test(test_tlv_header_truncated),
+        cmocka_unit_test(test_serve=
r_probe_read_finds_parameter),
+        cmocka_unit_test(test_server_probe_=
read_skips_unknown),
+        cmocka_unit_test(test_server_probe_read_missi=
ng),
+        cmocka_unit_test(test_server_probe_read_truncated),
+        =
cmocka_unit_test(test_server_probe_read_wrong_msg_type),
+        cmocka_un=
it_test(test_timestamp_in_window),
+        cmocka_unit_test(test_build_pro=
be_reply_valid),
+        cmocka_unit_test(test_build_probe_reply_stale),
+=
        cmocka_unit_test(test_build_probe_reply_no_parameter),
     };
 
  =
   return cmocka_run_group_tests_name("oob tests", tests, NULL, NULL);

-- =

To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Proje=
ct: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iafa9efc1c156974ad9f575=
2e9de810a8c2f68c30
Gerrit-Change-Number: 1742
Gerrit-PatchSet: 1
Gerrit-Own=
er: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--NsZUieySTeo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1742?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">oo=
b: Add SERVER_PROBE parsing and the probe-reply decision<br><br>Add the mes=
sage-level helpers the server needs to answer a probe:<br><br>  - oob_serve=
r_probe_read() scans the TLV payload of a received OOB<br>    SERVER_PROBE =
for the probe_parameter TLV, skipping other/future TLV<br>    types and rej=
ecting malformed or truncated input=2E<br>  - oob_timestamp_in_window() per=
forms the cheap replay/skew check on the<br>    probe timestamp described i=
n the wire protocol specification=2E<br>  - oob_build_probe_reply() compose=
s the two: given a received SERVER_PROBE<br>    it scans for the probe_para=
meter, drops the probe if it is missing or<br>    its timestamp is outside =
the acceptable window, and otherwise populates<br>    the probe_reply (echo=
ing the peer&#39;s session id) to send back=2E<br><br>These are pure functi=
ons exercised by unit tests; the server packet path<br>calls oob_build_prob=
e_reply() in a follow-up, which performs the actual send=2E<br><br>Change-I=
d: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30<br>Signed-off-by: Lev Stipakov=
 &lt;lev@openvpn=2Enet&gt;<br>---<br>M src/openvpn/oob=2Ec<br>M src/openvpn=
/oob=2Eh<br>M tests/unit_tests/openvpn/test_oob=2Ec<br>3 files changed, 303=
 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ge=
rrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/42/1742/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec</span><br><span>index 9f123=
e2=2E=2E58d47c0 100644</span><br><span>--- a/src/openvpn/oob=2Ec</span><br>=
<span>+++ b/src/openvpn/oob=2Ec</span><br><span>@@ -152,3 +152,71 @@</span>=
<br><span>     r-&gt;max_latency_diff =3D (uint16_t)max_latency_diff;</span=
><br><span>     return oob_skip_trailing(buf, value_len, OOB_PROBE_REPLY_LE=
N);</span><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+oob_server_probe_write(struct b=
uffer *buf, const struct oob_probe_parameter *param)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return oob_msg_write_header(buf, OOB_MSG_SERVER_PROBE)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp=
; oob_probe_parameter_write(buf, param);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+oob_server_probe_read(struct bu=
ffer *payload, struct oob_probe_parameter *param)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (!oob_msg_read_header(payload, OOB_MSG_SERVER_PROBE))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* A TLV header is 4 bytes (type + length)=2E Loop until we eit=
her find the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * =
probe_parameter or run out of well-formed TLVs=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    while (BLEN(payload) &gt;=3D 4)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        uint16_t type;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        bool optional;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        uint16_t value_len;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!oob_tlv_read=
_header(payload, &amp;type, &amp;optional, &amp;value_len))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            return false;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if (type =3D=3D OOB_TLV_PROBE_PARAMETER)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            return oob_probe_p=
arameter_read(payload, param, value_len);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        /* not the TLV we are looking for: skip its value and k=
eep scanning */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    if (!buf_advance(payload, value_len))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            return false;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
turn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+oob_timestamp_in_window(uint64_t probe_ts, uint64_t now, uin=
t64_t window_secs)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t diff =
=3D (now &gt; probe_ts) ? (now - probe_ts) : (probe_ts - now);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return diff &lt;=3D window_s=
ecs;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+oob_build_probe_reply(struct buffer *probe_payload, uint64_t now, u=
int64_t window_secs,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                      const struct session_id *peer_sid, struct oob_probe_=
reply *reply)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_par=
ameter param;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (!oob_server_probe_read(probe_payload, &amp;param))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return false;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Drop=
 replayed or implausibly-timed probes before doing any more work=2E */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!oob_timestamp_i=
n_window(param=2Etimestamp, now, window_secs))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        return false;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    memset(reply, =
0, sizeof(*reply));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    reply-&gt;peer_session_id =3D *peer_sid;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* priority/weight/connect_lifetime/flags left=
 at 0 for now */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span>diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh</span><b=
r><span>index c32a7db=2E=2E48fcfa1 100644</span><br><span>--- a/src/openvpn=
/oob=2Eh</span><br><span>+++ b/src/openvpn/oob=2Eh</span><br><span>@@ -144,=
4 +144,56 @@</span><br><span>  */</span><br><span> bool oob_probe_reply_rea=
d(struct buffer *buf, struct oob_probe_reply *r, uint16_t value_len);</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Write a complete SER=
VER_PROBE message (message-type header + probe_parameter</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * TLV) to @p buf=2E Sent by the clien=
t=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+bool oob_server_probe_write(str=
uct buffer *buf, const struct oob_probe_parameter *param);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * Read a received OOB SERVER_PROBE: verify its message-type header, th=
en scan</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * for the p=
robe_parameter TLV=2E TLV types other than probe_parameter are</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * skipped, so the scan tolerate=
s additional/future TLVs=2E @p payload is consumed</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * as it is read=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @param payload  buffer positioned at the start of the OOB =
message payload</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
param param    filled with the parsed probe_parameter on success</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @return true if the header =
matched and a well-formed probe_parameter was</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *         found, false otherwise</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+bool oob_server_probe_read(struct buffer *payload, =
struct oob_probe_parameter *param);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Check whether a =
probe timestamp is within an acceptable window around the</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * current time=2E Used to cheaply dr=
op replayed or implausibly-timed probes</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * before doing any further work (see the probe_paramet=
er timestamp rationale</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * in the wire protocol specification)=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @param probe_ts     timestamp from the probe_parameter (UNIX sec=
onds)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param now =
         current time (UNIX seconds)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param window_secs  maximum allowed difference, in eith=
er direction</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @ret=
urn true if |now - probe_ts| &lt;=3D window_secs</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+bool oob_timestamp_in_window(uint64_t probe_ts, uint64_t now, =
uint64_t window_secs);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * Process the TLV payload of a =
received SERVER_PROBE and decide whether to</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * answer it=2E Combines oob_server_probe_read() an=
d oob_timestamp_in_window():</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * the probe is dropped (false returned) if it has no valid probe_=
parameter or</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * its =
timestamp is outside the acceptable window=2E On success @p reply is</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * populated with the peer=
&#39;s session id echoed back and the remaining fields</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * zeroed, ready to be wrapped and sent=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * This is the transport-agnostic=
 decision step; the caller performs the send=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @param probe_payload  TLV payload of the received OOB SERVER_=
PROBE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param now =
           current time (UNIX seconds)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * @param window_secs    acceptable timestamp skew, in e=
ither direction</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
param peer_sid       session id of the requesting peer (echoed in the reply=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param reply   =
       filled with the reply to send on success</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @return true if a reply should be sent, fals=
e to silently drop the probe</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool oo=
b_build_probe_reply(struct buffer *probe_payload, uint64_t now, uint64_t wi=
ndow_secs,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                  const struct session_id *peer_sid, struct oob_probe_reply=
 *reply);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> #endif /* OOB_H */</span><br><span>diff --git a/tests/unit_tests/op=
envpn/test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>=
index 40dcaf9=2E=2Ea9998d2 100644</span><br><span>--- a/tests/unit_tests/op=
envpn/test_oob=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_oob=
=2Ec</span><br><span>@@ -172,6 +172,180 @@</span><br><span>     gc_free(&am=
p;gc);</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/* A SERVER_PROBE carrying just a probe_parameter i=
s found by the scan=2E */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+te=
st_server_probe_read_finds_parameter(void **state)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &=
amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    const struct oob_probe_par=
ameter in =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    =2Etimestamp =3D 0x1122334455667788ULL,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        =2Eflags =3D 0,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_true(oob_server_probe_write(&amp;buf, &amp;in));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_parameter out =3D =
{ 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tr=
ue(oob_server_probe_read(&amp;buf, &amp;out));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_true(in=2Etimestamp =3D=3D out=2Etime=
stamp);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_i=
nt_equal(in=2Eflags, out=2Eflags);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/* TLVs other than probe_parameter are =
skipped, so the scan finds the</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * probe_parameter even when preceded by an unknown TLV=2E */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+test_server_probe_read_skips_u=
nknown(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_are=
na gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* SERVER_PROBE message header, then an unknown TLV (typ=
e 0x7ff) =2E=2E=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_true(oob_msg_write_header(&amp;buf, OOB_MSG_SERVER_PROBE));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_tl=
v_write_header(&amp;buf, 0x7ff, false, 4));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;buf, 0xcafef00d)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =2E=2E=2E =
followed by the real probe_parameter */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    const struct oob_probe_parameter in =3D { =2Etimest=
amp =3D 42, =2Eflags =3D 0 };</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_true(oob_probe_parameter_write(&amp;buf, &amp;in));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_parameter out =3D { =
0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true=
(oob_server_probe_read(&amp;buf, &amp;out));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_true(out=2Etimestamp =3D=3D 42);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* =
A payload with no probe_parameter must be rejected=2E */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+test_server_probe_read_missing(void **state)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =
=3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_true(oob_msg_write_header(&amp;buf, OOB_MSG_SERVER_PROBE));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_tlv_write_h=
eader(&amp;buf, 0x7ff, false, 4));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_true(buf_write_u32(&amp;buf, 0));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct oob_probe_parameter out =3D { 0 };</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(oob_server_=
probe_read(&amp;buf, &amp;out));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc=
_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* A TLV whose declared length runs past =
the buffer must be rejected, not</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * read out of bounds=2E */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+test_server_probe_read_truncated(void **state)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_=
gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* TLV header cla=
ims a 16-byte value but no value bytes follow */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_true(oob_msg_write_header(&amp;buf,=
 OOB_MSG_SERVER_PROBE));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_true(oob_tlv_write_header(&amp;buf, 0x7ff, false, 16));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_parameter out =3D { =
0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_fals=
e(oob_server_probe_read(&amp;buf, &amp;out));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/* A SERVER_PROBE reader rej=
ects a payload carrying a different message type</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * (here a PROBE_REPLY&#39;s), even if it cont=
ains a valid probe_parameter TLV=2E */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+test_server_probe_read_wrong_msg_type(void **state)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_b=
uf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oo=
b_msg_write_header(&amp;buf, OOB_MSG_PROBE_REPLY));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const struct oob_probe_parameter in =
=3D { =2Etimestamp =3D 42, =2Eflags =3D 0 };</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_true(oob_probe_parameter_write(&amp;buf=
, &amp;in));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_param=
eter out =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_false(oob_server_probe_read(&amp;buf, &amp;out));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Timestamp =
window check accepts values within the window (either direction)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * and rejects values outside =
it=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_timestamp_in_w=
indow(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint64_t=
 now =3D 1000000;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  const uint64_t window =3D 30;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_true(oob_timestamp_in_window(now, now, window));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_timestamp_in_window(n=
ow - window, now, window));      /* boundary, past */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_timestamp_in_window(n=
ow + window, now, window));      /* boundary, future */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_false(oob_timestamp_in_windo=
w(now - window - 1, now, window)); /* too old */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_false(oob_timestamp_in_window(now +=
 window + 1, now, window)); /* too far ahead */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A vali=
d, in-window SERVER_PROBE yields a reply that echoes the peer&#39;s</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * session id and zeroes th=
e remaining fields=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tes=
t_build_probe_reply_valid(void **state)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const uint64_t now =3D 1000000;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct oob_prob=
e_parameter probe =3D { =2Etimestamp =3D now, =2Eflags =3D 0 };</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_server_prob=
e_write(&amp;buf, &amp;probe));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct session_id peer;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    memcpy(peer=2Eid, &quot;PEER1234&quot;, SID_SIZE);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct oob_probe_reply reply;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_true(oob_build_probe_reply(&amp;b=
uf, now, 30, &amp;peer, &amp;reply));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_memory_equal(reply=2Epeer_session_id=2Eid, pee=
r=2Eid, SID_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_int_equal(reply=2Epriority, 0);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_int_equal(reply=2Eweight, 0);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(reply=2Econ=
nect_lifetime, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_int_equal(reply=2Eflags, 0);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/* A probe whose timestamp is outsi=
de the window is dropped (no reply)=2E */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+test_build_probe_reply_stale(void **state)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(=
128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint64_t now =
=3D 1000000;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st struct oob_probe_parameter probe =3D { =2Etimestamp =3D now - 1000, =2Ef=
lags =3D 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_true(oob_server_probe_write(&amp;buf, &amp;probe));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct session_id peer =3D { 0 };</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_reply reply;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(oob_buil=
d_probe_reply(&amp;buf, now, 30, &amp;peer, &amp;reply));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A payload wit=
hout a probe_parameter is dropped (no reply)=2E */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+test_build_probe_reply_no_parameter(void **state)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =
=3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_true(oob_msg_write_header(&amp;buf, OOB_MSG_SERVER_PROBE));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_tlv_write_h=
eader(&amp;buf, 0x7ff, false, 4));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_true(buf_write_u32(&amp;buf, 0));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct session_id peer =3D { 0 };</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_reply reply;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(oob_b=
uild_probe_reply(&amp;buf, 1000000, 30, &amp;peer, &amp;reply));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> int</span><br><span> main(void)</span><br><span=
> {</span><br><span>@@ -182,6 +356,15 @@</span><br><span>         cmocka_un=
it_test(test_probe_parameter_forward_compat),</span><br><span>         cmoc=
ka_unit_test(test_probe_parameter_too_short),</span><br><span>         cmoc=
ka_unit_test(test_tlv_header_truncated),</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        cmocka_unit_test(test_server_probe_read_finds_=
parameter),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
cmocka_unit_test(test_server_probe_read_skips_unknown),</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_server_pr=
obe_read_missing),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       cmocka_unit_test(test_server_probe_read_truncated),</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_server=
_probe_read_wrong_msg_type),</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        cmocka_unit_test(test_timestamp_in_window),</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_buil=
d_probe_reply_valid),</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        cmocka_unit_test(test_build_probe_reply_stale),</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_build_p=
robe_reply_no_parameter),</span><br><span>     };</span><br><span> </span><=
br><span>     return cmocka_run_group_tests_name(&quot;oob tests&quot;, tes=
ts, NULL, NULL);</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail">change 1742=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"disp=
lay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerr=
it-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iaf=
a9efc1c156974ad9f5752e9de810a8c2f68c30 </div>
<div style=3D"display:none"> =
Gerrit-Change-Number: 1742 </div>
<div style=3D"display:none"> Gerrit-Patch=
Set: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipako=
v@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>

</body></html>
--NsZUieySTeo=--


--===============3363803169997427189==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3363803169997427189==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3363803169997427189==--

