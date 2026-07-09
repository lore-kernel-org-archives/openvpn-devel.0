Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E78C43458
	for <openvpn-devel@archiver.kernel.org>; Thu,  9 Jul 2026 15:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=meDkfmaCj3/yuUUcO6ee2N1zSBwfIuTH3X+jz/Z2nkY=; b=IELDXZsmLHW5PocqjwCuwjF0iG
	unYcThD6PkSoCkOrgNNbe2tkpdmtqQFcay58PStDZoQp0KmjQpaXjO0ChXRST0b3mfX6yrCDL6rez
	LYSc4r2ByK3HPsXuGVgZiSRt/2hNiTkuA6GZEOhP+I4Ai6KuCPCicWSKX1zGuWPajJ5E=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1whqh7-0007QT-2Y;
	Thu, 09 Jul 2026 15:29:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1whqh5-0007QM-Mq
 for openvpn-devel@lists.sourceforge.net;
 Thu, 09 Jul 2026 15:29:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=QlolZ5EcOAqF89ksbI524Qn5eh/bgkNN5z9lVv++taw=; b=LOETaQrB+rZgToO+stu2D9m/1u
 pJ3uQabchUblgQbDO19sGT1kVMkfOwdKDuzokQbFM12Vlseru4ZAawGp4t6hpTc2YXGWfYc+J9BXd
 /6/SiuvsE18uNZxrF0S9fROxCjIPIUWUQKd5veT/7frS9KIckMByraWbxzL7g9skTfQs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=QlolZ5EcOAqF89ksbI524Qn5eh/bgkNN5z9lVv++taw=; b=k
 uz/eMFFuDPBxrWiBKhs2DcNdEA39jFNf5brD214LU7DzI05diRKU2NdN5Sqodl/mFrQqchAOhYPPM
 t3Z9G8WiHCmSBNOnZQ21utcZ4a9lIdvAmbxjDiEWcJfvD+dT2AoAPwunvPX4q5NzQQVYKr17tKXzI
 vNssv7JNUddHYvOk=;
Received: from mail-ed1-f46.google.com ([209.85.208.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1whqh4-0008Jh-Hf for openvpn-devel@lists.sourceforge.net;
 Thu, 09 Jul 2026 15:29:44 +0000
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-699fbcd23ccso2984296a12.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 09 Jul 2026 08:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783610971; x=1784215771; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QlolZ5EcOAqF89ksbI524Qn5eh/bgkNN5z9lVv++taw=;
 b=gnZaVSKlUdZuD6eJoMNotRZwmMgCLVWduZiKhjquSrmGwpp/5ytwxWpcFRB+HMf8wE
 ZHNPFYdG8NXScxFcoK+EKC3O/yOkAx49RZ+zzDTr8vilOYyfaRfe2ILPl0MjqY0eFlqP
 qSvk/PmAJownYy7UOypwil3i9n88YVBJcWWQEGgY8sAMwZlWISHQUZBaouW7FJhG82V8
 LPfDU1R3VHcH//2H6N5kDkl1Y//HH+YyB9zh3BSlyU0OuUuXguMKgWN9RGIIEA6OwUsT
 HD6l0cGHnHzz/u3yKic/PjcQWGWOeqtXUf25nYg6Ewjbsf/GXo/J5HmCScX0U665Sb0s
 HymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783610971; x=1784215771;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=QlolZ5EcOAqF89ksbI524Qn5eh/bgkNN5z9lVv++taw=;
 b=ZuiwHXy+PS0g8sMIx+T9Xb7e8NhbcpJHMbqLf6VhgwzWegmiPBIF9MsrhqEsyRfQfH
 DH50DjzeyNwbonSpo9qnKInljA0UQndzInaw/e+cyhYhJtpwd+viaRVEl+lbsDNQax2Z
 SDmljX5q5IqZ+aLf8GFZ9PlHFX8QmOkW1t4Oyv8JSl5s85HGRtA514ns5XtOZ/LhWuCI
 DQpfrpAvxGZwAm+7iCT0K9uHeUueiip7OWfl0qWJAeESIA/NW6+yw4Tcu6IIAHI9X7ES
 y1/zGfUb5Q+qKf3JtkbZlILp0EowFRCEZit+Vp3yOFohp2RA6wMBdjAD/5ONFuhCtpsu
 xb/A==
X-Gm-Message-State: AOJu0YzQ5u/tXuumpcdj36WDzTHnREFjvlCejiX1R1l0FsJBXRazw51E
 WJ6DzR7BUZWNgsvx2QMGZVC4NMnUHIGuz3EwVHR6vD4h6y1XwAaREwRrCZcJLER4GO3F/JghQX+
 UunQ5lAUp/97rIinbQmU16y+oG1ZBpChh1TLeMhu2tOvY7whXi41ELmsBbVUg7ntHO8KDoVc3Lv
 +ksjKtCw==
X-Gm-Gg: AfdE7clodchXb9sIFuMsnwGy3jH+mZWiTztta0U1pCVDAfYS3Fax8YFWeyAmCuxfXV3
 ePsZatq6qWW4bUMBXrELH3n4WRMwP8fMozKPaNnWeZa0jQzLz4Kz+hzEPsWxcTpEF2LsTbIXUSs
 gJsKDsSeD9SWiJdsuoqq66/XHW+BMEiBuxwK5HkcD+5dDnOwbuU4GP9LgCRDj/gJ2RAtivZbNwV
 TGuAWkgIzU2AwcLKNzCPZujb25smpKPj+0loZZZ+h+UWBvGdTzO1tro7UeuBw/xEof/XEWHzlQA
 FlnPVYiHIsBZsPIn49mK8O3lCggGSIbqE/PKvOmWnLyjs32wPvpG4YnpFSC91zGpB/Dk7/wQMAG
 kHBB8XICsslCWgSSE6vLALT8PzlBaAX4s1KTqe97JsmcDxNqezCmZCoHsLFghHgK7nkuUD74Sng
 gdUA+vqHd/6LThfF8KpAWix34o5bafmbFkpisXcVFJpKyJv0ftN5VWczMtpLadvKf8gmZ1KGnL1
 wkOHeUTa6bBCEkb1rr8e64uBYChqtoorjkQ4BdHdHUeUz5PC1qx+TTQuhoF1e9z+ArRLf8xqjZO
 jsE=
X-Received: by 2002:a05:6000:4304:b0:46f:960b:b711 with SMTP id
 ffacd0b85a97d-47df0797962mr7932765f8f.45.1783604855272; 
 Thu, 09 Jul 2026 06:47:35 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d843csm50843228f8f.14.2026.07.09.06.47.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 06:47:34 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 9 Jul 2026 13:47:21 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: If04ce09d4c353f5384c0c48f48f63e05869a373f
X-Gerrit-Change-Number: 1745
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1745?usp=email>
X-Gerrit-Commit: 17aeb88328b35b5e61ad53228a082682a5091f30
In-Reply-To: <gerrit.1782719911000.If04ce09d4c353f5384c0c48f48f63e05869a373f@gerrit.openvpn.net>
References: <gerrit.1782719911000.If04ce09d4c353f5384c0c48f48f63e05869a373f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklmMDRjZTA5ZDRjMzUzZjUzODRjMGM0OGY0OGY2M2UwNTg2OWEzNzNmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <11113dffc321d6e24f89c959ad70d21ae5b164fe-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1whqh4-0008Jh-Hf
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
Content-Type: multipart/mixed; boundary="===============1516819210977630528=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1516819210977630528==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ma+IF7rJCBo="; charset=UTF-8

--ma+IF7rJCBo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

Hello flichtenhe=
ld, plaisthos, 

I'd like you to reexamine a change=2E Please visit

    ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1745?usp=3Demail

to look at the ne=
w patch set (#4)=2E

The change is no longer submittable: checks~ChecksSubm=
itRule is unsatisfied now=2E


Change subject: oob: Add client PROBE_REPLY =
parser
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob:=
 Add client PROBE_REPLY parser

Add oob_client_reply_read(), the client-sid=
e counterpart of
oob_server_probe_read(): it scans the TLV payload of a rec=
eived PROBE_REPLY
for the probe_reply TLV, skipping other/future TLV types=
=2E

Factor the shared TLV scan used by both into a static oob_find_tlv() h=
elper
so the two readers no longer duplicate the loop=2E

Change-Id: If04ce=
09d4c353f5384c0c48f48f63e05869a373f
Signed-off-by: Lev Stipakov <lev@openvp=
n=2Enet>
---
M src/openvpn/oob=2Ec
M src/openvpn/oob=2Eh
M tests/unit_tests=
/openvpn/test_oob=2Ec
3 files changed, 130 insertions(+), 15 deletions(-)

=

  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/45/1745=
/4

diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec
index b3b4151=2E=
=2Efe168b2 100644
--- a/src/openvpn/oob=2Ec
+++ b/src/openvpn/oob=2Ec
@@ -1=
74,31 +174,28 @@
            && oob_probe_parameter_write(buf, param);
 }
 =

-bool
-oob_server_probe_read(struct buffer *payload, struct oob_probe_para=
meter *param)
+/* Scan @p payload for the first TLV of type @p wanted_type,=
 skipping any other
+ * (e=2Eg=2E future) TLV types=2E On success @p payloa=
d is left positioned at that
+ * TLV's value and *value_len is its declared=
 length=2E Returns false if the TLV
+ * is not found or a header/length is =
malformed=2E */
+static bool
+oob_find_tlv(struct buffer *payload, uint16_t=
 wanted_type, uint16_t *value_len)
 {
-    if (!oob_msg_read_header(payload=
, OOB_MSG_SERVER_PROBE))
-    {
-        return false;
-    }
-
-    /* A T=
LV header is 4 bytes (type + length)=2E Loop until we either find the
-    =
 * probe_parameter or run out of well-formed TLVs=2E */
+    /* A TLV heade=
r is 4 bytes (type + length)=2E */
     while (BLEN(payload) >=3D 4)
     {=

         uint16_t type;
         bool optional;
-        uint16_t value_le=
n;
-        if (!oob_tlv_read_header(payload, &type, &optional, &value_len)=
)
+        if (!oob_tlv_read_header(payload, &type, &optional, value_len))
=
         {
             return false;
         }
-        if (type =3D=3D O=
OB_TLV_PROBE_PARAMETER)
+        if (type =3D=3D wanted_type)
         {
- =
           return oob_probe_parameter_read(payload, param, value_len);
+   =
         return true;
         }
-        /* not the TLV we are looking for=
: skip its value and keep scanning */
-        if (!buf_advance(payload, va=
lue_len))
+        /* not the TLV we want: skip its value and keep scanning=
 */
+        if (!buf_advance(payload, *value_len))
         {
            =
 return false;
         }
@@ -207,12 +204,30 @@
 }
 
 bool
+oob_server_prob=
e_read(struct buffer *payload, struct oob_probe_parameter *param)
+{
+    u=
int16_t value_len;
+    return oob_msg_read_header(payload, OOB_MSG_SERVER_=
PROBE)
+           && oob_find_tlv(payload, OOB_TLV_PROBE_PARAMETER, &value=
_len)
+           && oob_probe_parameter_read(payload, param, value_len);
+=
}
+
+bool
 oob_client_reply_write(struct buffer *buf, const struct oob_prob=
e_reply *reply)
 {
     return oob_msg_write_header(buf, OOB_MSG_PROBE_REPL=
Y) && oob_probe_reply_write(buf, reply);
 }
 
 bool
+oob_client_reply_read(=
struct buffer *payload, struct oob_probe_reply *reply)
+{
+    uint16_t val=
ue_len;
+    return oob_msg_read_header(payload, OOB_MSG_PROBE_REPLY)
+    =
       && oob_find_tlv(payload, OOB_TLV_PROBE_REPLY, &value_len)
+         =
  && oob_probe_reply_read(payload, reply, value_len);
+}
+
+bool
 oob_times=
tamp_in_window(uint64_t probe_ts, uint64_t now, uint64_t window_secs)
 {
  =
   uint64_t diff =3D (now > probe_ts) ? (now - probe_ts) : (probe_ts - now)=
;
diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh
index 3180bd4=2E=
=2E97dedbb 100644
--- a/src/openvpn/oob=2Eh
+++ b/src/openvpn/oob=2Eh
@@ -1=
75,6 +175,19 @@
 bool oob_client_reply_write(struct buffer *buf, const stru=
ct oob_probe_reply *reply);
 
 /**
+ * Read a received OOB PROBE_REPLY: ver=
ify its message-type header, then scan
+ * for the probe_reply TLV; the cli=
ent-side counterpart of
+ * oob_server_probe_read()=2E TLV types other than=
 probe_reply are skipped=2E
+ * @p payload is consumed as it is read=2E
+ *=

+ * @param payload  buffer positioned at the start of the OOB message payl=
oad
+ * @param reply    filled with the parsed probe_reply on success
+ * @=
return true if the header matched and a well-formed probe_reply was found,
=
+ *         false otherwise
+ */
+bool oob_client_reply_read(struct buffer =
*payload, struct oob_probe_reply *reply);
+
+/**
  * Check whether a probe =
timestamp is within an acceptable window around the
  * current time=2E Use=
d to cheaply drop replayed or implausibly-timed probes
  * before doing any=
 further work (see the probe_parameter timestamp rationale
diff --git a/tes=
ts/unit_tests/openvpn/test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec
=
index 4412389=2E=2E639e862 100644
--- a/tests/unit_tests/openvpn/test_oob=
=2Ec
+++ b/tests/unit_tests/openvpn/test_oob=2Ec
@@ -366,6 +366,89 @@
     =
gc_free(&gc);
 }
 
+/* A PROBE_REPLY carrying a probe_reply is found by the=
 client scan, with all
+ * fields surviving=2E */
+static void
+test_client=
_reply_read_finds_reply(void **state)
+{
+    struct gc_arena gc =3D gc_new=
();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    struct oob_pr=
obe_reply in =3D {
+        =2Epriority =3D 5,
+        =2Eweight =3D 50,
+=
        =2Econnect_lifetime =3D 120,
+        =2Eflags =3D 1,
+    };
+    =
memcpy(in=2Epeer_session_id=2Eid, "SRVREPLY", SID_SIZE);
+    assert_true(o=
ob_client_reply_write(&buf, &in));
+
+    struct oob_probe_reply out =3D { =
0 };
+    assert_true(oob_client_reply_read(&buf, &out));
+    assert_memor=
y_equal(out=2Epeer_session_id=2Eid, in=2Epeer_session_id=2Eid, SID_SIZE);
+=
    assert_int_equal(out=2Epriority, in=2Epriority);
+    assert_int_equal(=
out=2Eweight, in=2Eweight);
+    assert_int_equal(out=2Econnect_lifetime, i=
n=2Econnect_lifetime);
+    assert_int_equal(out=2Eflags, in=2Eflags);
+
+ =
   gc_free(&gc);
+}
+
+/* TLVs other than probe_reply are skipped=2E */
+st=
atic void
+test_client_reply_read_skips_unknown(void **state)
+{
+    struc=
t gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &g=
c);
+
+    assert_true(oob_msg_write_header(&buf, OOB_MSG_PROBE_REPLY));
+ =
   assert_true(oob_tlv_write_header(&buf, 0x7ff, false, 4));
+    assert_tr=
ue(buf_write_u32(&buf, 0xabad1dea));
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
-PatchSet: 4
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: f=
lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefo=
rge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Attention: stipa <lstipakov@gmail=2Ecom>

--ma+IF7rJCBo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>stipa <strong>uploaded pa=
tch set #4</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1745?usp=3Demail">View Change</a></p><p>The change is=
 no longer submittable: checks~ChecksSubmitRule is unsatisfied now=2E</p><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">oob: Add client PROBE_REPLY parser<br><br>Add oob_client_reply_=
read(), the client-side counterpart of<br>oob_server_probe_read(): it scans=
 the TLV payload of a received PROBE_REPLY<br>for the probe_reply TLV, skip=
ping other/future TLV types=2E<br><br>Factor the shared TLV scan used by bo=
th into a static oob_find_tlv() helper<br>so the two readers no longer dupl=
icate the loop=2E<br><br>Change-Id: If04ce09d4c353f5384c0c48f48f63e05869a37=
3f<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M src=
/openvpn/oob=2Ec<br>M src/openvpn/oob=2Eh<br>M tests/unit_tests/openvpn/tes=
t_oob=2Ec<br>3 files changed, 130 insertions(+), 15 deletions(-)<br><br></p=
re><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/c=
hanges/45/1745/4</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=
=2Ec</span><br><span>index b3b4151=2E=2Efe168b2 100644</span><br><span>--- =
a/src/openvpn/oob=2Ec</span><br><span>+++ b/src/openvpn/oob=2Ec</span><br><=
span>@@ -174,31 +174,28 @@</span><br><span>            &amp;&amp; oob_probe=
_parameter_write(buf, param);</span><br><span> }</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-bool</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-oob_server_probe_read(struct buffer *payload, s=
truct oob_probe_parameter *param)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+/* Scan @p payload for the first TLV of type @p wanted_type, =
skipping any other</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* (e=2Eg=2E future) TLV types=2E On success @p payload is left positioned a=
t that</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * TLV&#39;s =
value and *value_len is its declared length=2E Returns false if the TLV</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * is not found or a he=
ader/length is malformed=2E */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+oob_find_tlv(struct buffer *payload, uint16_t wanted_type, uint16_t *val=
ue_len)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if (!oob_msg_read_header(payload, OOB_MSG_SERVER_PROBE))</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        return false;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* A =
TLV header is 4 bytes (type + length)=2E Loop until we either find the</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-     * probe_parameter or =
run out of well-formed TLVs=2E */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    /* A TLV header is 4 bytes (type + length)=2E */</span><b=
r><span>     while (BLEN(payload) &gt;=3D 4)</span><br><span>     {</span><=
br><span>         uint16_t type;</span><br><span>         bool optional;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        uint16_t value_l=
en;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!oob_t=
lv_read_header(payload, &amp;type, &amp;optional, &amp;value_len))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if (!oob_tlv_read_he=
ader(payload, &amp;type, &amp;optional, value_len))</span><br><span>       =
  {</span><br><span>             return false;</span><br><span>         }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (type =3D=3D=
 OOB_TLV_PROBE_PARAMETER)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (type =3D=3D wanted_type)</span><br><span>         {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            return oob_prob=
e_parameter_read(payload, param, value_len);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            return true;</span><br><span>         =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* not the T=
LV we are looking for: skip its value and keep scanning */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        if (!buf_advance(payload, valu=
e_len))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* n=
ot the TLV we want: skip its value and keep scanning */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        if (!buf_advance(payload, *valu=
e_len))</span><br><span>         {</span><br><span>             return fals=
e;</span><br><span>         }</span><br><span>@@ -207,12 +204,30 @@</span><=
br><span> }</span><br><span> </span><br><span> bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+oob_server_probe_read(struct buffer *payl=
oad, struct oob_probe_parameter *param)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    uint16_t value_len;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return oob_msg_read_header(payload, OOB_MSG_SERVER_PROBE)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; oob_f=
ind_tlv(payload, OOB_TLV_PROBE_PARAMETER, &amp;value_len)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; oob_probe_param=
eter_read(payload, param, value_len);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><spa=
n> oob_client_reply_write(struct buffer *buf, const struct oob_probe_reply =
*reply)</span><br><span> {</span><br><span>     return oob_msg_write_header=
(buf, OOB_MSG_PROBE_REPLY) &amp;&amp; oob_probe_reply_write(buf, reply);</s=
pan><br><span> }</span><br><span> </span><br><span> bool</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+oob_client_reply_read(struct buffer *p=
ayload, struct oob_probe_reply *reply)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    uint16_t value_len;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    return oob_msg_read_header(payload, OOB_MSG_PROBE_REPLY)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; oob_fin=
d_tlv(payload, OOB_TLV_PROBE_REPLY, &amp;value_len)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; oob_probe_reply_rea=
d(payload, reply, value_len);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span> oob_t=
imestamp_in_window(uint64_t probe_ts, uint64_t now, uint64_t window_secs)</=
span><br><span> {</span><br><span>     uint64_t diff =3D (now &gt; probe_ts=
) ? (now - probe_ts) : (probe_ts - now);</span><br><span>diff --git a/src/o=
penvpn/oob=2Eh b/src/openvpn/oob=2Eh</span><br><span>index 3180bd4=2E=2E97d=
edbb 100644</span><br><span>--- a/src/openvpn/oob=2Eh</span><br><span>+++ b=
/src/openvpn/oob=2Eh</span><br><span>@@ -175,6 +175,19 @@</span><br><span> =
bool oob_client_reply_write(struct buffer *buf, const struct oob_probe_repl=
y *reply);</span><br><span> </span><br><span> /**</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * Read a received OOB PROBE_REPLY: verify it=
s message-type header, then scan</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * for the probe_reply TLV; the client-side counterpart of</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * oob_server_probe_rea=
d()=2E TLV types other than probe_reply are skipped=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @p payload is consumed as it is read=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param payload  buffer positio=
ned at the start of the OOB message payload</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @param reply    filled with the parsed probe_rep=
ly on success</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @re=
turn true if the header matched and a well-formed probe_reply was found,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         false other=
wise</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+bool oob_client_reply_read(stru=
ct buffer *payload, struct oob_probe_reply *reply);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/**</span><br><span>  * Check whether a probe timestamp is w=
ithin an acceptable window around the</span><br><span>  * current time=2E U=
sed to cheaply drop replayed or implausibly-timed probes</span><br><span>  =
* before doing any further work (see the probe_parameter timestamp rational=
e</span><br><span>diff --git a/tests/unit_tests/openvpn/test_oob=2Ec b/test=
s/unit_tests/openvpn/test_oob=2Ec</span><br><span>index 4412389=2E=2E639e86=
2 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_oob=2Ec</span>=
<br><span>+++ b/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>@@ -3=
66,6 +366,89 @@</span><br><span>     gc_free(&amp;gc);</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* =
A PROBE_REPLY carrying a probe_reply is found by the client scan, with all<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * fields surviving=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_client_reply_rea=
d_finds_reply(void **state)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct oob_probe_reply in =3D {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        =2Epriority =3D 5,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        =2Eweight =3D 50,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Econnect_lifet=
ime =3D 120,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 =2Eflags =3D 1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(in=2E=
peer_session_id=2Eid, &quot;SRVREPLY&quot;, SID_SIZE);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_client_reply_write(&=
amp;buf, &amp;in));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_prob=
e_reply out =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_true(oob_client_reply_read(&amp;buf, &amp;out));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(out=2Epe=
er_session_id=2Eid, in=2Epeer_session_id=2Eid, SID_SIZE);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(out=2Epriority, =
in=2Epriority);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_int_equal(out=2Eweight, in=2Eweight);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_int_equal(out=2Econnect_lifetime, in=2E=
connect_lifetime);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_int_equal(out=2Eflags, in=2Eflags);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/* TLVs other than probe_rep=
ly are skipped=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_cl=
ient_reply_read_skips_unknown(void **state)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_msg_write_header(=
&amp;buf, OOB_MSG_PROBE_REPLY));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_true(oob_tlv_write_header(&amp;buf, 0x7ff, false, 4=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(=
buf_write_u32(&amp;buf, 0xabad1dea));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct oob_probe_reply in =3D { =2Epriority =3D 7 };<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_=
probe_reply_write(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct oob_probe_reply out =3D { 0 };</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_true(oob_client_reply_read(&amp;buf, &amp;=
out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_in=
t_equal(out=2Epriority, 7);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free=
(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/* A payload with no probe_reply is rejected=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_client_reply_rea=
d_missing(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_=
arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_true(oob_msg_write_header(&amp;buf, OOB_MSG_PR=
OBE_REPLY));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_true(oob_tlv_write_header(&amp;buf, 0x7ff, false, 4));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;b=
uf, 0));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_reply out=
 =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_false(oob_client_reply_read(&amp;buf, &amp;out));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Likewise, a PROBE=
_REPLY reader rejects a payload with the wrong message</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * type even when a valid probe_reply TL=
V follows=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stat=
ic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_client_=
reply_read_wrong_msg_type(void **state)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_msg_write_header(&amp=
;buf, OOB_MSG_SERVER_PROBE));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct oob_probe_reply in =3D { =2Epriority =3D 7 };</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_probe_re=
ply_write(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct oob_probe_reply out =3D { 0 };</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_false(oob_client_reply_read(&amp;buf, &amp;out));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span> int</span><br><span> main(void)</span=
><br><span> {</span><br><span>@@ -386,6 +469,10 @@</span><br><span>        =
 cmocka_unit_test(test_build_probe_reply_valid),</span><br><span>         c=
mocka_unit_test(test_build_probe_reply_stale),</span><br><span>         cmo=
cka_unit_test(test_build_probe_reply_no_parameter),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_client_repl=
y_read_finds_reply),</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        cmocka_unit_test(test_client_reply_read_skips_unknown),</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_=
client_reply_read_missing),</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        cmocka_unit_test(test_client_reply_read_wrong_msg_type),</s=
pan><br><span>     };</span><br><span> </span><br><span>     return cmocka_=
run_group_tests_name(&quot;oob tests&quot;, tests, NULL, NULL);</span><br><=
span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1745?usp=3Demail">change 1745</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1745?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Proje=
ct: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div=
>
<div style=3D"display:none"> Gerrit-Change-Id: If04ce09d4c353f5384c0c48f4=
8f63e05869a373f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1=
745 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div styl=
e=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lich=
tenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attentio=
n: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>

</body></html>
--ma+IF7rJCBo=--


--===============1516819210977630528==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1516819210977630528==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1516819210977630528==--

