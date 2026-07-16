Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC67C4450A
	for <openvpn-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DWuKatTJFD9agR8r7uc02aUw0oQFchRVhcZdeUFAkwg=; b=ctwildCfJFKOg4SFWHogbuYtmH
	oVbBbSA4YAISjpbe6FM+Ts9RC/qEMW9EL/sR5sy3fZOxQrigDFx6SnDZIYDnxYT9I4HXWhJf2isfD
	N6qx2RfP5bXdwcOqRG34bw4NgONupN4S3zkPcq70EzDqV+l653A/91lM1HBuYnrCbSG4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wkH9z-0002qC-RM;
	Thu, 16 Jul 2026 08:09:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wkH9y-0002q6-5i
 for openvpn-devel@lists.sourceforge.net;
 Thu, 16 Jul 2026 08:09:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=tnim3RUvu2BVML/59ziYXO9pohWbMyXUrgdYDVfAepw=; b=iN0VNuO+KTVQnoIUUxq6nZ3a+1
 VZCLI42rYwRt000cAKWyzB5Zjr8em+pUQ07UVRAXSahoJHmMtgerJ5td6E4GOu4OdpR4XbsL8hdfq
 ii0yvdrzdQ4tnu6VjjekwVib2APl5w/VWBjAnux5BqW1lOKd4VjIhIc0vAOqmngJiB1w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tnim3RUvu2BVML/59ziYXO9pohWbMyXUrgdYDVfAepw=; b=O
 xhTYgn6I1NnDN/FNx8+UFVnVDPOaGfYQW2DePBnQ7Jho3T5dx4TMtwyDStqYryURyjEpB1nkTPHSx
 eubDDT5ZECIL1U1M6LOedejrkQXZVFfeWB7BwsLQimBeHVRUvUxLLNQV7ghjhJLXT7TmlvAuznT+9
 okStp0hFklHS5m7o=;
Received: from mail-lj1-f173.google.com ([209.85.208.173])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wkH9w-0005hy-Vw for openvpn-devel@lists.sourceforge.net;
 Thu, 16 Jul 2026 08:09:34 +0000
Received: by mail-lj1-f173.google.com with SMTP id
 38308e7fff4ca-39c9cbf0719so55527691fa.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 16 Jul 2026 01:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784189366; x=1784794166; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tnim3RUvu2BVML/59ziYXO9pohWbMyXUrgdYDVfAepw=;
 b=IRciQDMCa1pDJT1nHxu3FC7DEdMe+8lzgWLnyjcgZOWXzZdoWL0qhzegm6MPKi3wX0
 cdLWEcio9drn4NfGOqrxRrYklR3SgL+wUY96id88/AHqmb9KzlOpoANKbCwZ9SjimsJ5
 nXVrqxvRs3snXSqhmzqs0fInL0Ems5DPpY/47Wi7VlgWION2sXkxsfwwZ3q3LDP75jEK
 kQ1WpezSEtwAGd5yrK3F4k5a0JTGZEleYuKqr0nXTxyU2W4Nna+BbymFIA31T36Lqnxp
 Pv/XUFqgTh14z5kPgD6yRsBCvW4bnl2nB4I4QdtFT2UDwxKyNc5WPKpbzvLdiY67Y/2L
 k+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784189366; x=1784794166;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=tnim3RUvu2BVML/59ziYXO9pohWbMyXUrgdYDVfAepw=;
 b=pjkhPcgVwuwyB+pt3AHD5rFVjaAgfIujLtcUe5jrb61ypI/cmTiSvEnmgNm4/PBtkw
 COLx7cio5oV4ofN5qMvoxJf8LGJpY8n9aSR8oPijIbtxhdcZ6p4/rhJZ6yTUV55gUJ3S
 wkTXnEVSL5gEKvqWSpQDKzn2/GOP4iy8OYTpq/+2HuammZ3AYar9QXuKFS2DGoSk4oWB
 Sj+JWoRCCpQCpmQV0N5b6jz8M1AE6hYiLb5Xvej3ICqf4ShU5PB1+trjRY43MiQEC2Cd
 WnziWuu9bM+Lr56766Ro5iGRZ1a7SY1NKMDMi1SNHP3dvPrASn6pXCBcG9FtfV38WkFZ
 7vDA==
X-Gm-Message-State: AOJu0YxXzTrBK5cuQCpynHZLBBvS9rJPkaMjF/EzlkbC+BuabFnR67gf
 /KIe8R9i04Vs+TkHgtNFUw+RShpFqlVtucuKC3Kjw65HMobdydZppbAiiyLf96+gXKnfIGZhbH/
 f9cYJmNP219WLLE+pC9gq5SDjxDrhM3k0+uGSYqtY5+5/KL5iQDlNpMj066dt4icQVd5+
X-Gm-Gg: AfdE7clXiMEiQMaOwnZ0Wb/1BSyDaFVw2jCtDEQAzk66u8Yhze1X4ixX7UvbF/Zdz8Y
 mxbtqWHIj9W+pL6mAZh3qWXpDotiCELY5SHWqi7BAbRAv3UJGMiHSeeP/RWPCFdEw7SVRdb8JZ2
 VEK8aDhuUelX7qfJO7hCrn6+C+1uCvZ/QlhbnDXzVXCrWEob5IRMONXoXttRalNbkhmxil8SDli
 Bx06eASZEgcAHdD2khnOIfz3LCZxJQLI7DRg1y1zV6XIHh2fl/Bu/DiTs7K2ou8nqIFaw5XTCMP
 HzbVQbOGbeIZGiCqcDhLzwIl43r/rxTvbxzCIS08ossWN+Ja4AnKm9YicuJnmKFVfQTQ7Ut13D9
 pqx8MRjHG+pZBRemIn3BbvPhHfZ1nnk4WHRK/skhi0syKtsZUlaAstOEm/ySAh6pqrNwU1gnxmu
 ba9va5gf1EPHj1I5QIhosA62/NvtdJ1AInOZpnq50ZMETSPcT2lQNjcdJqY2v7tzjue122q+uT9
 K82jZcuIYRNHmnrYGUTWjmgryhGkB3ATvZ7ChoL9Y7VuaoqFnPRApRZGanROq9zbl90h9n5YFFx
 SjU=
X-Received: by 2002:a05:651c:12c3:b0:39c:710a:a6bd with SMTP id
 38308e7fff4ca-39dadcc1d10mr19117611fa.39.1784189365288; 
 Thu, 16 Jul 2026 01:09:25 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39c84b83dbasm46929181fa.19.2026.07.16.01.09.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 01:09:24 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 16 Jul 2026 08:09:01 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: If04ce09d4c353f5384c0c48f48f63e05869a373f
X-Gerrit-Change-Number: 1745
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1745?usp=email>
X-Gerrit-Commit: 894aa954953b31c11c7a8d8ab9872b609cfbb120
In-Reply-To: <gerrit.1782719911000.If04ce09d4c353f5384c0c48f48f63e05869a373f@gerrit.openvpn.net>
References: <gerrit.1782719911000.If04ce09d4c353f5384c0c48f48f63e05869a373f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklmMDRjZTA5ZDRjMzUzZjUzODRjMGM0OGY0OGY2M2UwNTg2OWEzNzNmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <42e3a661f3b0e6852c147a1caf4984c4d1ee1623-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wkH9w-0005hy-Vw
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
Content-Type: multipart/mixed; boundary="===============6047469045395194281=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6047469045395194281==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9nJpRVI4tcc="; charset=UTF-8

--9nJpRVI4tcc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

Hello flichtenhe=
ld, plaisthos, 

I'd like you to reexamine a change=2E Please visit

    ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1745?usp=3Demail

to look at the ne=
w patch set (#7)=2E

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
/7

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
-PatchSet: 7
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

--9nJpRVI4tcc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>stipa <strong>uploaded pa=
tch set #7</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
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
hanges/45/1745/7</pre><pre style=3D"font-family: monospace,monospace; white=
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
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
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
--9nJpRVI4tcc=--


--===============6047469045395194281==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6047469045395194281==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6047469045395194281==--

