Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE139C982D2
	for <openvpn-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vrfyeOVp2piulvmt3sHRh9zPKW6DvLvLv8QTIE/V4/g=; b=f3xl/L9fsG7EGRJN+WNop7+jfz
	5PAj0a/4anol6UAq/8JMtu8LsAeEFvKpZLnl89BVowwxJ7vLG7F8APAUcgkvS9m87fwtQkZ9ZNjP2
	ZcXXtH3EHQ8a6jN7Uah1S0lWhw+yNoSF6JyDkaJkz1Dd7wA+AoupaCQfPMX4VWCWkEds=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x767m-0007ZH-1Q;
	Thu, 17 Sep 2026 07:01:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x767l-0007ZA-Bs
 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 07:01:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=3jNtBD9EAAUcded/HRAs3tJIbvzE0G5jP0jZDJHSBSY=; b=m9sS5D2JPKrvW+ekd4GLwSpkw8
 6nntpWMdX0SKNF3WN/VGkEalIoSImkPAJ+amW1E43ZA2EsoC1t7rcsfR0TZLF6F4/RAS5OgWbGZEB
 tu60RSe8XM2yiYnN96Hg9335MX+DqRPqFRGymjCkhNcEcoPe+jDpb8TWuTEmu99+IEpk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=3jNtBD9EAAUcded/HRAs3tJIbvzE0G5jP0jZDJHSBSY=; b=Q
 5wQ6Ubhgu6vPnTjQEItge/ExZH6zseMFtx+Uy11b/QYpa4fT3EhpgEqyMwyzGgi8XTsqtro6N8w15
 Eo8XFStrkfpPd0lmVLyd4+5KSdMbWs+xXqUcPokaqlH6RfLIbp7MBzoQMo/4zENoQz2QCwc4CH6g9
 48uwMdfZ7t9JNNA0=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x767d-0003qZ-9R for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 07:01:33 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49cd4ba9f68so6229125e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 17 Sep 2026 00:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789628483; x=1790233283; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3jNtBD9EAAUcded/HRAs3tJIbvzE0G5jP0jZDJHSBSY=;
 b=L0choYyyDE+HkoBwNKcOlyJGcwo7CNpxX2L1RM/OxlmbttDYkTJcxZon0qmkXgnnQJ
 lxScjwsnHutHWQVC17rVyJGfRNQJDVW1FLW/IHO/xK6ybX6y+tsBuxDykW303lt2IVvq
 SxSTFz5bYHdVwAapOxcFgzwmmHZ85+i7zew2Vo2ogBbNPaWHYxNQdi50tcPOsjwaESDO
 TIuK15KDT1XnuRMu56Zx+pqU6x74HGE4BSyZlnGfn5YoZSh1PlpnQypy4CGkG6fSKwHj
 lTBQU5C55B1Klh7oZnHP/rOuUFrHcPGDaQNrCby1F7FOek3fwNJE5ChvSaYh+1SmgIKS
 ae3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789628483; x=1790233283;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=3jNtBD9EAAUcded/HRAs3tJIbvzE0G5jP0jZDJHSBSY=;
 b=g4NmUKWgQc/r8W+/vqdmCuQJvhgfKSh3mgVC02LYzMDZ1grsTtIxM4RvMI27JQvSt2
 AraKfp3PpsFqd1Ee54a2ogBI2+lv7XOCZPXA5kRYQUkIDsFnffAAtEEYZRYQaBDcvCwZ
 aAtwKC/oVK+CCufexItwkNmt/WPbGf/ymKAxy1DX8issmOsF4lEZjoIKhOW/PH7V4CFq
 97zmy/XEyhwLLRzx9fSyNTIKSMJbLFUHdlgB3Hs4Nbj6IaV23/1bYlrdT02lNypVoA5a
 56SZHPeGrD08wcpyL5lxPwouSpqvDGE4vG/YEBiPEHLIGWV/NaM7CK5JJy5QdBtnR2sn
 t6aA==
X-Gm-Message-State: AFuF++k2NfXOE25peFX2OdjLa0YGZcJZHk9iJuocQ9YN9I/OQSe8oSo4
 HUSCviJ9hRfhh/8H0TD5TMXoZXqqHG6rb0qkZlEmcA0i6gkjv9Fj555/W3+q4p7JS5wTEQl6hx4
 mUsoWBhnC6/qcGdlRfTpnqEVsOTeVhC5LRk/vdrMlNnkhT7RDw2vg2pUfhFyHHQKtEaB3
X-Gm-Gg: AYBFou2ECMj4uKiFQyqGBE/CsYcnhStvU7OvOK71DvC5Pnj9DV71sNGRU9eYLDPR5Hf
 1urLGHrYS/WTRREAlnD9KWGFzlnnW2zFNLyusy2Q23uPsBmVgsPlrKLXNbpFribCzlapzzwMr7B
 sjRIKH4J56uI7b1jrbc/AXjAMPxXNuDgzz82KUDODyf2mGEnGOHv5WaJ/bdO0GszHWhy+vFid3r
 yRw3gp6iLM9/ZgClKOhWvgQ1y/Qpf0j8lEUL6aMMSeWgrF1GohuVB3MSVzWvhqE+VMG+pS82E7S
 J6qvVpwYmOc+m+6QZjR3jPqv8Iww8nk8neWSqYyRf+bD/NAZ22wM9wGC4rExEPCIRt/LdvlhPJL
 4msJ019KCQ3uoMvK83f01mC6P+vv4ewa8+PS+Fj4oEHksghN/TvssSiabJbtKGISvJcmPmHa3fU
 c4ZoeDbeTWxVugwQHfU/Kj61aCFxNnCXZFZkZY4eUKeYzMiUK/j09hOTLrhqW8GKq3CP/xC7FyQ
 W/JidoFhLl6MgTHdCeOz2+bzw7kikp9dSkxE5kC3PK8L+tz3vpkFTSTTkjW05Z4q58QKIYolk7b
 lAzk+rgk+XtObb5pvLrU/E9TugondK/sFdZq+CeT/zYnTtx4SnAj7DP2wDLikA==
X-Received: by 2002:a05:600c:83cd:b0:49e:732e:6b79 with SMTP id
 5b1f17b1804b1-49ec0543929mr54968835e9.32.1789628482230; 
 Thu, 17 Sep 2026 00:01:22 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbbcf5277sm67727525e9.3.2026.09.17.00.01.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 00:01:21 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 17 Sep 2026 07:01:11 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>,
 ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 16
X-Gerrit-Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30
X-Gerrit-Change-Number: 1742
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1742?usp=email>
X-Gerrit-Commit: ec37a5e65da7ada1e6e470eaa6af7c187a3da8bf
In-Reply-To: <gerrit.1782719911000.Iafa9efc1c156974ad9f5752e9de810a8c2f68c30@gerrit.openvpn.net>
References: <gerrit.1782719911000.Iafa9efc1c156974ad9f5752e9de810a8c2f68c30@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklhZmE5ZWZjMWMxNTY5NzRhZDlmNTc1MmU5ZGU4MTBhOGMyZjY4YzMwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <387694258e8f511fb9735466e00b0d91810960e5-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x767d-0003qZ-9R
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
Content-Type: multipart/mixed; boundary="===============1287082676029251237=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1287082676029251237==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NbP+GkqT/Vo="; charset=UTF-8

--NbP+GkqT/Vo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ralf_lici, stipa=2E

He=
llo flichtenheld, plaisthos, ralf_lici, 

I'd like you to reexamine a chang=
e=2E Please visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=
=3Demail

to look at the new patch set (#16)=2E


Change subject: oob: Add =
SERVER_PROBE parsing and the probe-reply decision
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Add SERVER_PROBE parsing and the=
 probe-reply decision

Add the message-level helpers the server needs to an=
swer a probe:

  - oob_server_probe_write() writes a SERVER_PROBE (message-=
type header
    + probe_parameter TLV); the client uses it later=2E
  - oob=
_server_probe_read() scans the TLV payload of a received OOB
    SERVER_PRO=
BE for the probe_parameter TLV, skipping other/future TLV
    types that ar=
e marked optional, and rejecting malformed or truncated
    input as well a=
s a mandatory TLV it does not understand=2E
  - oob_timestamp_in_window() p=
erforms the cheap replay/skew check on
    the probe timestamp described in=
 the wire protocol specification=2E
  - oob_server_probe_accept() combines =
the two: given a received
    SERVER_PROBE it scans for the probe_parameter=
 and accepts the probe
    unless that is missing or its timestamp is outsi=
de the acceptable
    window=2E It reads the probe and nothing else; the re=
ply is the
    caller's to build=2E

A probe whose timestamp falls outside =
the window is dropped without a
reply, which is what the spec allows: the t=
imestamp is there so a server
may silently drop requests outside an accepta=
ble window and reduce the
replay attack surface=2E The window itself is the=
 caller's choice; the
server path passes --hand-window in a follow-up=2E

T=
hese are pure functions exercised by unit tests; the server packet path
cal=
ls oob_server_probe_accept() in a follow-up and builds and sends the
reply =
itself=2E

Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30
Signed-off-=
by: Lev Stipakov <lev@openvpn=2Enet>
---
M src/openvpn/oob=2Ec
M src/openvp=
n/oob=2Eh
M tests/unit_tests/openvpn/test_oob=2Ec
3 files changed, 293 inse=
rtions(+), 0 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/o=
penvpn refs/changes/42/1742/16

diff --git a/src/openvpn/oob=2Ec b/src/open=
vpn/oob=2Ec
index c807171=2E=2E655c791 100644
--- a/src/openvpn/oob=2Ec
+++=
 b/src/openvpn/oob=2Ec
@@ -81,3 +81,45 @@
     r->flags =3D buf_read_u32(bu=
f, NULL);
     return true;
 }
+
+bool
+oob_server_probe_write(struct buffe=
r *buf, const struct oob_probe_parameter *param)
+{
+    return buf_write_u=
16(buf, OOB_MSG_SERVER_PROBE) && oob_probe_parameter_write(buf, param);
+}
=
+
+bool
+oob_server_probe_read(struct buffer *payload, struct oob_probe_par=
ameter *param)
+{
+    if (!ctrl_msg_read_header(payload, OOB_MSG_SERVER_PR=
OBE))
+    {
+        return false;
+    }
+
+    struct buffer value;
+   =
 if (!ctrl_msg_find_tlv(payload, OOB_TLV_PROBE_PARAMETER, &value))
+    {
+=
        return false;
+    }
+
+    return oob_probe_parameter_read(&value,=
 param);
+}
+
+bool
+oob_timestamp_in_window(uint64_t probe_ts, uint64_t no=
w, uint64_t window_secs)
+{
+    uint64_t diff =3D (now > probe_ts) ? (now =
- probe_ts) : (probe_ts - now);
+    return diff <=3D window_secs;
+}
+
+en=
um oob_probe_verdict
+oob_server_probe_check(struct buffer *probe_payload, =
uint64_t now, uint64_t window_secs)
+{
+    struct oob_probe_parameter para=
m;
+    if (!oob_server_probe_read(probe_payload, &param))
+    {
+        =
return OOB_PROBE_INVALID;
+    }
+    return oob_timestamp_in_window(param=
=2Etimestamp, now, window_secs) ? OOB_PROBE_OK
+                           =
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
index 70f529e0=2E=
=2Ed98d86c 100644
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
 int
 main(void)
 {
@@ -334,6 +524,16=
 @@
         cmocka_unit_test(test_find_tlv_skips_optional_after_wanted),
 =
        cmocka_unit_test(test_find_tlv_empty_payload),
         cmocka_unit=
_test(test_tlv_header_truncated),
+        cmocka_unit_test(test_server_pro=
be_read_finds_parameter),
+        cmocka_unit_test(test_server_probe_read_=
skips_unknown),
+        cmocka_unit_test(test_server_probe_read_rejects_un=
known_mandatory),
+        cmocka_unit_test(test_server_probe_read_missing)=
,
+        cmocka_unit_test(test_server_probe_read_truncated),
+        cmo=
cka_unit_test(test_server_probe_read_wrong_msg_type),
+        cmocka_unit_=
test(test_timestamp_in_window),
+        cmocka_unit_test(test_server_probe=
_check_valid),
+        cmocka_unit_test(test_server_probe_check_stale),
+ =
       cmocka_unit_test(test_server_probe_check_no_parameter),
     };
 
  =
   return cmocka_run_group_tests_name("oob tests", tests, NULL, NULL);

-- =

To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Pro=
ject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iafa9efc1c156974ad9f5=
752e9de810a8c2f68c30
Gerrit-Change-Number: 1742
Gerrit-PatchSet: 16
Gerrit-=
Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
G=
errit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <=
openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <fr=
ank@lichtenheld=2Ecom>
Gerrit-Attention: ralf_lici <ralf@mandelbit=2Ecom>
G=
errit-Attention: stipa <lstipakov@gmail=2Ecom>

--NbP+GkqT/Vo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, ralf_lici, stipa=2E </p>
<p>stipa <stro=
ng>uploaded patch set #16</strong> to this change=2E</p><p><a href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail">View Change</a></p><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">oob: Add SERVER_PROBE parsing and the probe-reply decision<br>=
<br>Add the message-level helpers the server needs to answer a probe:<br><b=
r>  - oob_server_probe_write() writes a SERVER_PROBE (message-type header<b=
r>    + probe_parameter TLV); the client uses it later=2E<br>  - oob_server=
_probe_read() scans the TLV payload of a received OOB<br>    SERVER_PROBE f=
or the probe_parameter TLV, skipping other/future TLV<br>    types that are=
 marked optional, and rejecting malformed or truncated<br>    input as well=
 as a mandatory TLV it does not understand=2E<br>  - oob_timestamp_in_windo=
w() performs the cheap replay/skew check on<br>    the probe timestamp desc=
ribed in the wire protocol specification=2E<br>  - oob_server_probe_accept(=
) combines the two: given a received<br>    SERVER_PROBE it scans for the p=
robe_parameter and accepts the probe<br>    unless that is missing or its t=
imestamp is outside the acceptable<br>    window=2E It reads the probe and =
nothing else; the reply is the<br>    caller&#39;s to build=2E<br><br>A pro=
be whose timestamp falls outside the window is dropped without a<br>reply, =
which is what the spec allows: the timestamp is there so a server<br>may si=
lently drop requests outside an acceptable window and reduce the<br>replay =
attack surface=2E The window itself is the caller&#39;s choice; the<br>serv=
er path passes --hand-window in a follow-up=2E<br><br>These are pure functi=
ons exercised by unit tests; the server packet path<br>calls oob_server_pro=
be_accept() in a follow-up and builds and sends the<br>reply itself=2E<br><=
br>Change-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30<br>Signed-off-by: L=
ev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M src/openvpn/oob=2Ec<br>M =
src/openvpn/oob=2Eh<br>M tests/unit_tests/openvpn/test_oob=2Ec<br>3 files c=
hanged, 293 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pu=
ll ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/42/1742/16</pre>=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec</span><br><span>i=
ndex c807171=2E=2E655c791 100644</span><br><span>--- a/src/openvpn/oob=2Ec<=
/span><br><span>+++ b/src/openvpn/oob=2Ec</span><br><span>@@ -81,3 +81,45 @=
@</span><br><span>     r-&gt;flags =3D buf_read_u32(buf, NULL);</span><br><=
span>     return true;</span><br><span> }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_server_p=
robe_write(struct buffer *buf, const struct oob_probe_parameter *param)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return buf_write_u16(buf, OOB_MSG_SER=
VER_PROBE) &amp;&amp; oob_probe_parameter_write(buf, param);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_server_=
probe_read(struct buffer *payload, struct oob_probe_parameter *param)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!ctrl_msg_read_header(payload, OO=
B_MSG_SERVER_PROBE))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retur=
n false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct buffer value;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (!ctrl_msg_find_tlv(payload, OOB=
_TLV_PROBE_PARAMETER, &amp;value))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return oob_probe_parameter=
_read(&amp;value, param);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+oob_timestamp_in_window(uint64_t probe_ts, uin=
t64_t now, uint64_t window_secs)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    u=
int64_t diff =3D (now &gt; probe_ts) ? (now - probe_ts) : (probe_ts - now);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return diff &lt=
;=3D window_secs;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+enum oob_probe_verdict</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+oob_server_probe_check(struct buffer=
 *probe_payload, uint64_t now, uint64_t window_secs)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct oob_probe_parameter param;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!oob_server_probe_read(probe_payl=
oad, &amp;param))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return O=
OB_PROBE_INVALID;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return oob_t=
imestamp_in_window(param=2Etimestamp, now, window_secs) ? OOB_PROBE_OK</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
                                                : OOB_PROBE_STALE;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git=
 a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh</span><br><span>index c5396b3=
=2E=2E6d83eca 100644</span><br><span>--- a/src/openvpn/oob=2Eh</span><br><s=
pan>+++ b/src/openvpn/oob=2Eh</span><br><span>@@ -107,4 +107,55 @@</span><b=
r><span>  */</span><br><span> bool oob_probe_reply_read(struct buffer *buf,=
 struct oob_probe_reply *r);</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * Write a complete SERVER_PROBE message (message-type header + =
probe_parameter</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * T=
LV) to buf=2E Sent by the client=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
bool oob_server_probe_write(struct buffer *buf, const struct oob_probe_para=
meter *param);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * Read a received OOB SERVER_PROBE: ver=
ify its message-type header, then scan</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * for the probe_parameter TLV=2E Unknown TLV types mark=
ed optional are skipped;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * an unknown mandatory one rejects the probe=2E payload is consumed a=
s it is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * read=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @param payload  buffer positioned a=
t the start of the OOB message payload</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * @param param    filled with the parsed probe_paramete=
r on success</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @ret=
urn true if the header matched and a well-formed probe_parameter was</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *         found, false ot=
herwise</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+bool oob_server_probe_read(s=
truct buffer *payload, struct oob_probe_parameter *param);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * Check whether a probe timestamp is within an acceptable window aroun=
d the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * current tim=
e=2E Used to cheaply drop replayed or implausibly-timed probes</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * before doing any further work=
 (see the probe_parameter timestamp rationale</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * in the wire protocol specification)=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * @param probe_ts     timestamp from the pr=
obe_parameter (UNIX seconds)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param now          current time (UNIX seconds)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * @param window_secs  maximum allo=
wed difference, in either direction</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * @return true if |now - probe_ts| &lt;=3D window_secs</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+bool oob_timestamp_in_window(uint64_t p=
robe_ts, uint64_t now, uint64_t window_secs);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+enum oob_probe_verdict</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OOB_=
PROBE_INVALID, /**&lt; no valid probe_parameter: drop */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    OOB_PROBE_STALE,   /**&lt; well-fo=
rmed, timestamp outside the window */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    OOB_PROBE_OK,      /**&lt; well-formed, timestamp wit=
hin the window */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * Classify a received SERVER_PROBE=2E Combines oob_se=
rver_probe_read() and</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * oob_timestamp_in_window()=2E This is the transport-agnostic decision s=
tep;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the caller d=
ecides what to do with a stale probe and builds the reply=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @param probe_payload  TLV payload of the receive=
d OOB SERVER_PROBE, consumed</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param now            current time (UNIX seconds)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param window_secs    acceptab=
le timestamp skew, in either direction</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+enum oob_probe_verdict oob_server_probe_check(struct buffer *probe_paylo=
ad, uint64_t now,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                                            uint64_t window_secs);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* =
OOB_H */</span><br><span>diff --git a/tests/unit_tests/openvpn/test_oob=2Ec=
 b/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>index 70f529e0=2E=
=2Ed98d86c 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_oob=
=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_oob=2Ec</span><br>=
<span>@@ -319,6 +319,196 @@</span><br><span>     gc_free(&amp;gc);</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/* A SERVER_PROBE carrying just a probe_parameter is found by the =
scan=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static vo=
id</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_server_probe=
_read_finds_parameter(void **state)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    const struct oob_probe_parameter in =3D {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Etimestam=
p =3D 0x1122334455667788ULL,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        =2Eflags =3D 0,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_true(oob_server_probe_write(&amp;buf, &amp;in));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct oob_probe_parameter out =3D { 0 };</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_server_p=
robe_read(&amp;buf, &amp;out));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_true(in=2Etimestamp =3D=3D out=2Etimestamp);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(in=2Ef=
lags, out=2Eflags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/* TLVs other than probe_parameter are skipped, so the=
 scan finds the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * p=
robe_parameter even when preceded by an unknown TLV=2E */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+test_server_probe_read_skips_unknown(void **s=
tate)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_ne=
w();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buff=
er buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* SERVER_PROBE message header, then an unknown but optional TLV (type<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * 0x7ff) =2E=2E=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tr=
ue(buf_write_u16(&amp;buf, OOB_MSG_SERVER_PROBE));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_header(&a=
mp;buf, 0x7ff, true, 4));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_true(buf_write_u32(&amp;buf, 0xcafef00d));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* =2E=2E=2E followed by the re=
al probe_parameter */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    const struct oob_probe_parameter in =3D { =2Etimestamp =3D 42, =2Efla=
gs =3D 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_true(oob_probe_parameter_write(&amp;buf, &amp;in));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct oob_probe_parameter out =3D { 0 };</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_server_probe_=
read(&amp;buf, &amp;out));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_true(out=2Etimestamp =3D=3D 42);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/* An unknown TLV that =
is NOT marked optional carries something the sender</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * requires us to act on: the whole messa=
ge is rejected, whether that TLV comes</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * before or after the one we were looking for=2E */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+test_server_probe_read_rejects_=
unknown_mandatory(void **state)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const struct oob_probe_parameter in =3D { =2Etimestamp =3D 4=
2, =2Eflags =3D 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer =
before =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_true(buf_write_u16(&amp;before, OOB_MSG_SERVE=
R_PROBE));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_true(ctrl_msg_tlv_write_header(&amp;before, 0x7ff, false, 4));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(=
&amp;before, 0xcafef00d));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_true(oob_probe_parameter_write(&amp;before, &amp;in));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer after =3D alloc_buf_gc(=
128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_true(buf_write_u16(&amp;after, OOB_MSG_SERVER_PROBE));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_probe_paramete=
r_write(&amp;after, &amp;in));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;after, 0x7ff, fal=
se, 4));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
true(buf_write_u32(&amp;after, 0xcafef00d));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct oob_probe_parameter out =3D { 0 };</span><br><span style=
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
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><span> ma=
in(void)</span><br><span> {</span><br><span>@@ -334,6 +524,16 @@</span><br>=
<span>         cmocka_unit_test(test_find_tlv_skips_optional_after_wanted),=
</span><br><span>         cmocka_unit_test(test_find_tlv_empty_payload),</s=
pan><br><span>         cmocka_unit_test(test_tlv_header_truncated),</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(te=
st_server_probe_read_finds_parameter),</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        cmocka_unit_test(test_server_probe_read_skips_un=
known),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmoc=
ka_unit_test(test_server_probe_read_rejects_unknown_mandatory),</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_s=
erver_probe_read_missing),</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        cmocka_unit_test(test_server_probe_read_truncated),</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(tes=
t_server_probe_read_wrong_msg_type),</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        cmocka_unit_test(test_timestamp_in_window),</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(t=
est_server_probe_check_valid),</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        cmocka_unit_test(test_server_probe_check_stale),</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(te=
st_server_probe_check_no_parameter),</span><br><span>     };</span><br><spa=
n> </span><br><span>     return cmocka_run_group_tests_name(&quot;oob tests=
&quot;, tests, NULL, NULL);</span><br><span></span><br></pre><p>To view, vi=
sit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?usp=3Demail">=
change 1742</a>=2E To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1742?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div =
style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displa=
y:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-C=
hange-Id: Iafa9efc1c156974ad9f5752e9de810a8c2f68c30 </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Number: 1742 </div>
<div style=3D"display:none">=
 Gerrit-PatchSet: 16 </div>
<div style=3D"display:none"> Gerrit-Owner: stip=
a &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@=
mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf=
@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
stipa &lt;lstipakov@gmail=2Ecom&gt; </div>

</body></html>
--NbP+GkqT/Vo=--


--===============1287082676029251237==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1287082676029251237==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1287082676029251237==--

