Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93663C79FA0
	for <openvpn-devel@archiver.kernel.org>; Mon,  7 Sep 2026 07:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=QGbSilPZhngOTxOHC9lfls0gG7Z6hMK0hEodhliLNxw=; b=Im8EPbWPQbSx07
	XIQf1it8Z+Ypugvs+/Q1vyk/lFKdBBLD31/0ZWqQkp7xzcsUztyTdl0L9iKrAuHvwBQ3CkGv+i3/B
	8bPIPz/xnnTu2UHhOg2Qu7hJiwa4ytqdprqDfrRG791LROVIP0vTFw/2w/K9TimHYCMGgYg/J2Lg9
	I6k=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3ThH-0001Vh-LN;
	Mon, 07 Sep 2026 07:23:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x3ThE-0001VI-V4
 for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 07:23:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fS5ZUmAuvCgu0t5ePh7P1sZFrNEOff/H8f9Bp3RAltE=; b=d4pINHIUD283FXcHmhemeU2mVr
 36eMN92812NYMqOtcXYk+CWcdKnxcijyzI4aaHKD4Fnt1MtIWEHZaPoSC9o4Q3BpedeW8Wexp+5AJ
 Qa2F77Oye0tOAXLNkOa5aNGvYzqQL+3MRwLYRNVoKYYZjf4iSSCKM0FP352OGLkhXZqk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=fS5ZUmAuvCgu0t5ePh7P1sZFrNEOff/H8f9Bp3RAltE=; b=J
 eX/LXc2QXwdPUiU+8X26ZFRnqDFrfLFu3OoJVlu6i9eA13MHtVcXats9w6WsCA/E2vkzsD2fdDnN5
 gN20uKaGDYrGD3TFiD20DGj8fUDVxmR36rSq4X8P8x6jgYh6SjAxU8ivKqmfN36i6sc6hzBLq7YrG
 tlbW01yMG4PnHwHw=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3ThD-0003X0-3C for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 07:23:17 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-49b0eab380eso28839315e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 07 Sep 2026 00:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788765788; x=1789370588; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fS5ZUmAuvCgu0t5ePh7P1sZFrNEOff/H8f9Bp3RAltE=;
 b=PyZpGJ50pv7pALrCkcgJAmdvDRr5SDTFJOYS355N4MCn/GIB29ww5NjtUVYBgEzJJW
 p0YtW4Cqn81cWyyHIpCVSCulNfXDIK3qjopOuXF1KoE73pOVmDMiw78EnAZz+dJWjrla
 kI9NyBzRlYNOfrTHcwLZM+PYLy+c/o3ULcfa3Oxv8QuQYWdCHDJonbyJZulXPx42HDll
 9S4egnLH/nVu8q5FYn9UTnx+BvNxU0X+dV3z2PYLrQXCEzewsP/4CijzxFBj/Oq+2d3T
 VCcmSa+mGXm0GZWb5TSe7SlGeOaxbFlBLBf6X9vdPNJK9cbEQuXjS3t4YHgd/vEPW4O5
 BWtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788765788; x=1789370588;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fS5ZUmAuvCgu0t5ePh7P1sZFrNEOff/H8f9Bp3RAltE=;
 b=Myv2sxENnq8Xv2z/3PZoCKhbiU2tlSbjtsT4KQ1BsgaGyElSPF7McYI38bLCpH+KNl
 zwoNRp0r4Afh3rKWEgdGQL+r6TFoCxAKsK4ry57AtxmS9aaaHYdhuZZACTukMbvj0trZ
 eIkawl1rtH5pnnoWNAxDIIC+X4s7hyxbaHDaAdcZEVKxUipf39vvf1HN8THG+pyaMg8f
 SwO5vaaKyIuEheJr7RcoI+nZNF2mDUpAYaxyzYGSZUJR2cowL9iCjXr8UrIe/KX5eMAv
 zeSlwK9KV9qQwnpvUFQQHLxxmMu3ok3JSywLmLjjVO9QDJBYD5XKdC9IDDX2ux8qiB2J
 LlWQ==
X-Gm-Message-State: AFuF++mK/a3n5FaSlOMB3QtVntMTOuzz5GxhjRLKECPTwvz6Miqi2Zax
 SuqHPn5uHAC3pJ/8Cv2BsXC51Uvz4obOpMoI7t+/7Pkz/a4ViXVoNsE8RELh7JWPXLUdY4J56L3
 eDLjKeRGwtiU1q1e2nrrgEWLPCZ3wBLLazDzcAXrh9l1KrtNp4OKpgd/m5+kXu78w7KYxu5Q2Sd
 Sl6SqIEg==
X-Gm-Gg: AYBFou12HMj7wo0dveXgfD+nPwJVm0TBm7ZCDo8CRZrZ47olTNKafjOfROyhT5HMq1+
 FarOzN0YIYpzyXcNy5TrVdBVs/Gb31uZ/qrXLL1cRMblx1FoRXJ0JGJMYVyFAansvtMvUVm9hGK
 GH7vL6vnXshUNWfneqcqVE7rhjIrC/kBILwJrBpxPN0deUIlu7tdu5QVfBSFpMFeX3QqSgfyBId
 izrtDS6ZHsazPbaTIqDLP4K2NPV0XR6uOhP79wesstfhHZOS9iTQ8DM+KnOqJq/byP82zRXs+Ei
 DMbjBZ/L7YVh+3SKbiCjI/mG12mJFRC06HzVjEbEZgLX0x5OS6f4ipTY9sgjBvyT9v9FEyzcr+s
 fGkA/iGaWL6wrxd/x3bdW0mvx3VmeKL6D72zVU9CzueZQOLjxxx+VNW9hsv7Ob7+j2SDsMC9WA3
 hxpbrxzuAJQUysdR6y1DaMtBqVL3DP1aqnQP4D28M3IzcCzjlBCVZfu4KOP+h85JQsiMW4a9N0A
 BCSh6LGiUEp3hjo/JYjybZfDd7lAC/kvJWQa/CtQXTXR4k+sfp6nprYE49tyHnWo0BtqJ44Wd9Y
 Xnp0PErc3c3huBjLh9JXywLOQ/Gg7kMhVo5jlWb4CDbbPoXQO8B4Bun5sTKcIw==
X-Received: by 2002:a05:600d:8497:10b0:49c:f13e:e4f with SMTP id
 5b1f17b1804b1-49cf891bce9mr134789855e9.12.1788765788220; 
 Mon, 07 Sep 2026 00:23:08 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce5927b68sm379388785e9.1.2026.09.07.00.23.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 00:23:07 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 7 Sep 2026 07:23:07 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I63c141075d89ae6a07872e784faff817dd3350b1
X-Gerrit-Change-Number: 1901
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1901?usp=email>
X-Gerrit-Commit: f82b16705f3b7628d7891d7930b7452668835cab
References: <gerrit.1788765781000.I63c141075d89ae6a07872e784faff817dd3350b1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NzY1NzgxMDAwLkk2M2MxNDEwNzVkODlhZTZhMDc4NzJlNzg0ZmFmZjgxN2RkMzM1MGIxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8ca2f5b2a284916123e4fb88d1c33460e84383e1-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x3ThD-0003X0-3C
Subject: [Openvpn-devel] [M] Change in openvpn[master]: reliable: fix the
 send window width
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1350381672586638409=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1350381672586638409==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JBFFDCsu0RU="; charset=UTF-8

--JBFFDCsu0RU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1901?usp=3Demail

to review the following change=2E


Chang=
e subject: reliable: fix the send window width
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

reliable: fix the send window width

The=
 check accepted the 11 ids below rel->packet_id where its documentation
sai=
d RELIABLE_CAPACITY=2E Twelve is right: reliable_get_buf_output_sequenced()=

issues an id while it is less than rel->size beyond the oldest unacknowled=
ged
one, so an entry can sit a full rel->size below rel->packet_id, and rel=
->size
may be RELIABLE_CAPACITY=2E

No effect today, TLS_RELIABLE_N_SEND_BU=
FFERS being 6=2E Raising the send buffer
count to RELIABLE_CAPACITY, which =
reliable_init() permits, would have
discarded the ACK for the oldest outsta=
nding packet=2E

The width is now the extent passed to reliable_pid_in_rang=
e() rather than a
comparison operator=2E

Also renames validate_packet_id_w=
indow() to reliable_pid_in_send_window(),
returning bool and taking a const=
 struct reliable * like its neighbours, and
the same const on reliable_get_=
num_output_sequenced_available()=2E

Three doc comments described what the =
code does not do: the window bounds,
reliable_wont_break_sequentiality()'s =
reference id, subtract_pid()'s argument
order=2E reliable_mark_active_incom=
ing() now states the precondition it asserts=2E

Change-Id: I63c141075d89ae=
6a07872e784faff817dd3350b1
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=
=2Eorg>
---
M src/openvpn/reliable=2Ec
M src/openvpn/reliable=2Eh
M tests/u=
nit_tests/openvpn/test_packet_id=2Ec
3 files changed, 67 insertions(+), 54 =
deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/=
changes/01/1901/1

diff --git a/src/openvpn/reliable=2Ec b/src/openvpn/reli=
able=2Ec
index 6e10211=2E=2E7ddc03a 100644
--- a/src/openvpn/reliable=2Ec
+=
++ b/src/openvpn/reliable=2Ec
@@ -38,8 +38,8 @@
 
 #include "memdbg=2Eh"
 
=
-/* calculates test - base while allowing for base or test wraparound=2E te=
st is
- * assumed to be higher than base */
+/* test - base in the packet i=
d space, wrapping around=2E Only meaningful against
+ * an explicit bound: =
on its own it does not say which id came first=2E */
 static inline packet_=
id_type
 subtract_pid(const packet_id_type test, const packet_id_type base)=

 {
@@ -356,12 +356,11 @@
     return true;
 }
 
-int
-validate_packet_id_w=
indow(struct reliable *rel, packet_id_type pid)
+bool
+reliable_pid_in_send=
_window(const struct reliable *rel, packet_id_type pid)
 {
-    const packe=
t_id_type dist =3D subtract_pid(rel->packet_id, pid);
-
-    return dist > =
0 && dist < RELIABLE_CAPACITY;
+    return reliable_pid_in_range(pid, subtr=
act_pid(rel->packet_id, RELIABLE_CAPACITY),
+                              =
   RELIABLE_CAPACITY);
 }
 
 /* del acknowledged items from send buf */
@@ =
-376,7 +375,7 @@
         packet_id_type pid =3D ack->packet_id[i];
 
 
-  =
      if (!validate_packet_id_window(rel, pid))
+        if (!reliable_pid_=
in_send_window(rel, pid))
         {
             if (out_of_window =3D=3D =
0)
             {
@@ -566,7 +565,7 @@
 }
 
 int
-reliable_get_num_output_se=
quenced_available(struct reliable *rel)
+reliable_get_num_output_sequenced_=
available(const struct reliable *rel)
 {
     return rel->size - (int)relia=
ble_oldest_active_distance(rel);
 }
diff --git a/src/openvpn/reliable=2Eh b=
/src/openvpn/reliable=2Eh
index 04f3372=2E=2E534feb3 100644
--- a/src/openv=
pn/reliable=2Eh
+++ b/src/openvpn/reliable=2Eh
@@ -190,15 +190,20 @@
 }
 
 =
/**
- * check that pid is inside the window of possible outstanding packets=

- * of size RELIABLE_CAPACITY, ie inside the range
- * [rel->packet_id - R=
ELIABLE_CAPACITY, rel->packet_id)=2E
+ * Check whether pid is one of the RE=
LIABLE_CAPACITY ids below rel->packet_id,
+ * and so could still be outstan=
ding=2E rel->packet_id is the *next* id to be
+ * sent, so it is not itself=
 in the window=2E
  *
- * rel->packet is the *next* packet id to be sent ou=
t, so it is not
- * included in the valid range=2E
+ * pid comes off the wi=
re; all 2^32 values are handled=2E
+ *
+ * @param rel The reliable structur=
e holding this tunnel's sent packets=2E
+ * @param pid A packet ID from a r=
eceived acknowledgment=2E
+ *
+ * @return
+ * @li True, if pid is inside th=
e window=2E
+ * @li False, otherwise=2E
  */
-int
-validate_packet_id_windo=
w(struct reliable *rel, packet_id_type pid);
+bool reliable_pid_in_send_win=
dow(const struct reliable *rel, packet_id_type pid);
 
 /**
  * Returns the=
 number of packets that need to be acked=2E
@@ -305,14 +310,15 @@
  * Check=
 that a received packet's ID can safely be stored in
  *     the reliable s=
tructure's processing window=2E
  *
- * This function checks the difference=
 between the received packet's ID
- * and the lowest non-acknowledged packe=
t ID in the given reliable
- * structure=2E  If that difference is larger t=
han the total number of
- * packets which can be stored, then this packet c=
annot be stored safely,
- * because the reliable structure could possibly f=
ill up without leaving
- * room for all intervening packets=2E  In that cas=
e, this received packet
- * could break the reliable structure's sequential=
ity, and must therefore
- * be discarded=2E
+ * Checks the received packet'=
s ID against rel->packet_id, the next ID the
+ * reliability layer expects =
to hand upwards=2E One too far ahead could fill the
+ * structure without l=
eaving room for the intervening packets, so it is
+ * discarded=2E
+ *
+ * =
IDs numerically below rel->packet_id are accepted here, an absolute
+ * com=
parison that an ID from before a wraparound does not pass=2E
+ * reliable_n=
ot_replay() rejects them, and they are still acknowledged so a
+ * peer who=
se ACK was lost stops retransmitting=2E
  *
  * @param rel The reliable str=
ucture for handling this VPN tunnel's
  *     received packets=2E
@@ -354,6=
 +360,10 @@
  * Mark the %reliable entry associated with the given buffer a=
s active
  * incoming=2E
  *
+ * pid must be less than rel->size ahead of r=
el->packet_id=2E This is asserted,
+ * so run reliable_wont_break_sequentia=
lity() and reliable_not_replay()
+ * first=2E
+ *
  * @param rel The reliab=
le structure associated with this packet=2E
  * @param buf The buffer into =
which the packet has been copied=2E
  * @param pid The packet's packet ID=
=2E
@@ -446,7 +456,7 @@
  *  @return the number of buffer that are availabl=
e for sending without
  *             breaking ack sequence
  * */
-int rel=
iable_get_num_output_sequenced_available(struct reliable *rel);
+int reliab=
le_get_num_output_sequenced_available(const struct reliable *rel);
 
 /**
 =
 * Mark the reliable entry associated with the given buffer as
diff --git a=
/tests/unit_tests/openvpn/test_packet_id=2Ec b/tests/unit_tests/openvpn/tes=
t_packet_id=2Ec
index 7df74d9=2E=2Ee101412 100644
--- a/tests/unit_tests/op=
envpn/test_packet_id=2Ec
+++ b/tests/unit_tests/openvpn/test_packet_id=2Ec
=
@@ -331,44 +331,50 @@
     struct reliable rel =3D { 0 };
     rel=2Epacket=
_id =3D 1;
 
-    assert_true(validate_packet_id_window(&rel, 0));
+    ass=
ert_true(reliable_pid_in_send_window(&rel, 0));
 
     /* packet id 1 is ou=
tside the window as it is the *next* packet id */
-    assert_false(validat=
e_packet_id_window(&rel, 1));
+    assert_false(reliable_pid_in_send_window=
(&rel, 1));
 
     /* wrapped around packet id, "-2" */
-    assert_true(va=
lidate_packet_id_window(&rel, 0xFFFFFFFD));
+    assert_true(reliable_pid_i=
n_send_window(&rel, 0xFFFFFFFD));
 
     /* wrapped around packet id, "-10"=
 */
-    assert_true(validate_packet_id_window(&rel, 0xFFFFFFF6));
+    ass=
ert_true(reliable_pid_in_send_window(&rel, 0xFFFFFFF6));
 
-    /* wrapped =
around packet id, "-11" */
-    assert_false(validate_packet_id_window(&rel=
, 0xFFFFFFF5));
-    assert_false(validate_packet_id_window(&rel, 0x8000000=
0));
+    /* wrapped around packet id, "-11": the oldest id still in the wi=
ndow */
+    assert_true(reliable_pid_in_send_window(&rel, 0xFFFFFFF5));
+
=
+    /* one further back is outside it */
+    assert_false(reliable_pid_in=
_send_window(&rel, 0xFFFFFFF4));
+    assert_false(reliable_pid_in_send_win=
dow(&rel, 0x80000000));
 
     rel=2Epacket_id =3D 0x80000000;
 
     /* ne=
ar the signed/usigned integer area */
-    assert_false(validate_packet_id_=
window(&rel, 0x80000001));
-    assert_true(validate_packet_id_window(&rel,=
 0x7fffffff));
-    assert_true(validate_packet_id_window(&rel, 0x7ffffff5)=
);
-    assert_false(validate_packet_id_window(&rel, 0x7ffffff4));
+    ass=
ert_false(reliable_pid_in_send_window(&rel, 0x80000001));
+    assert_true(=
reliable_pid_in_send_window(&rel, 0x7fffffff));
+    assert_true(reliable_p=
id_in_send_window(&rel, 0x7ffffff5));
+    assert_true(reliable_pid_in_send=
_window(&rel, 0x7ffffff4));
+    assert_false(reliable_pid_in_send_window(&=
rel, 0x7ffffff3));
 
     rel=2Epacket_id =3D 0xFFFFFFFD;
-    assert_false=
(validate_packet_id_window(&rel, 0xFFFFFFFD));
-    assert_false(validate_p=
acket_id_window(&rel, 0));
-    assert_false(validate_packet_id_window(&rel=
, 1));
-    assert_false(validate_packet_id_window(&rel, 0xFFFFFFFE));
-   =
 assert_false(validate_packet_id_window(&rel, 0xFFFFFFFF));
-    assert_tru=
e(validate_packet_id_window(&rel, 0xFFFFFFF3));
-    assert_true(validate_p=
acket_id_window(&rel, 0xFFFFFFF2));
-    assert_false(validate_packet_id_wi=
ndow(&rel, 0xFFFFFFF1));
+    assert_false(reliable_pid_in_send_window(&rel=
, 0xFFFFFFFD));
+    assert_false(reliable_pid_in_send_window(&rel, 0));
+ =
   assert_false(reliable_pid_in_send_window(&rel, 1));
+    assert_false(re=
liable_pid_in_send_window(&rel, 0xFFFFFFFE));
+    assert_false(reliable_pi=
d_in_send_window(&rel, 0xFFFFFFFF));
+    assert_true(reliable_pid_in_send_=
window(&rel, 0xFFFFFFF3));
+    assert_true(reliable_pid_in_send_window(&re=
l, 0xFFFFFFF2));
+    assert_true(reliable_pid_in_send_window(&rel, 0xFFFFF=
FF1));
+    assert_false(reliable_pid_in_send_window(&rel, 0xFFFFFFF0));
 
=
     rel=2Epacket_id =3D 500;
-    assert_false(validate_packet_id_window(&=
rel, 501));
-    assert_true(validate_packet_id_window(&rel, 497));
-    as=
sert_true(validate_packet_id_window(&rel, 500 - (RELIABLE_CAPACITY - 1)));
=
-    assert_false(validate_packet_id_window(&rel, 500 - RELIABLE_CAPACITY))=
;
+    assert_false(reliable_pid_in_send_window(&rel, 501));
+    assert_tr=
ue(reliable_pid_in_send_window(&rel, 497));
+    assert_true(reliable_pid_i=
n_send_window(&rel, 500 - (RELIABLE_CAPACITY - 1)));
+    assert_true(relia=
ble_pid_in_send_window(&rel, 500 - RELIABLE_CAPACITY));
+    assert_false(r=
eliable_pid_in_send_window(&rel, 500 - (RELIABLE_CAPACITY + 1)));
 }
 
 
@@=
 -533,21 +539,19 @@
     return (packet_id_type)(p1 - p2) >=3D 0x80000000u;=

 }
 
-/* one short of RELIABLE_CAPACITY, which is what the code accepts to=
day */
-#define CHARACTERIZED_SEND_WINDOW 11
-
 /* TLS_RELIABLE_N_SEND_BUFF=
ERS and P_CONTROL_V1, from ssl_pkt=2Eh, which this
  * test binary does not=
 pull in */
 #define CHAR_N_SEND_BUFFERS    6
 #define CHAR_OPCODE_CONTROL_=
V1 4
 
-/* preserved: the ids validate_packet_id_window() accepts */
+/* in=
troduced: the RELIABLE_CAPACITY ids below rel->packet_id=2E
+ * validate_pa=
cket_id_window() stopped one short of that=2E */
 static bool
 ref_pid_in_s=
end_window(const struct reliable *rel, packet_id_type pid)
 {
     const pa=
cket_id_type dist =3D (packet_id_type)(rel->packet_id - pid);
 
-    return=
 dist >=3D 1 && dist <=3D CHARACTERIZED_SEND_WINDOW;
+    return dist >=3D =
1 && dist <=3D RELIABLE_CAPACITY;
 }
 
 /* preserved: reliable_pid_in_range=
2() */
@@ -798,7 +802,7 @@
                 rel=2Epacket_id =3D anchors[a];=

 
                 assert_int_equal(ref_pid_in_send_window(&rel, ids[i]),
=
-                                 validate_packet_id_window(&rel, ids[i]) !=
=3D 0);
+                                 reliable_pid_in_send_window(&rel,=
 ids[i]));
             }
         }
     }

-- 
To view, visit http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1901?usp=3Demail
To unsubscribe, or for help=
 writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: =
master
Gerrit-Change-Id: I63c141075d89ae6a07872e784faff817dd3350b1
Gerrit-C=
hange-Number: 1901
Gerrit-PatchSet: 1
Gerrit-Owner: razvanc <razvanc@mailbo=
x=2Eorg>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC:=
 openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: =
plaisthos <arne-openvpn@rfc2549=2Eorg>

--JBFFDCsu0RU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>razvanc would like plaisthos to =
<strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1901?usp=3Demail">View Change</a></p><pre class=3D"=
blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
reliable: fix the send window width<br><br>The check accepted the 11 ids be=
low rel-&gt;packet_id where its documentation<br>said RELIABLE_CAPACITY=2E =
Twelve is right: reliable_get_buf_output_sequenced()<br>issues an id while =
it is less than rel-&gt;size beyond the oldest unacknowledged<br>one, so an=
 entry can sit a full rel-&gt;size below rel-&gt;packet_id, and rel-&gt;siz=
e<br>may be RELIABLE_CAPACITY=2E<br><br>No effect today, TLS_RELIABLE_N_SEN=
D_BUFFERS being 6=2E Raising the send buffer<br>count to RELIABLE_CAPACITY,=
 which reliable_init() permits, would have<br>discarded the ACK for the old=
est outstanding packet=2E<br><br>The width is now the extent passed to reli=
able_pid_in_range() rather than a<br>comparison operator=2E<br><br>Also ren=
ames validate_packet_id_window() to reliable_pid_in_send_window(),<br>retur=
ning bool and taking a const struct reliable * like its neighbours, and<br>=
the same const on reliable_get_num_output_sequenced_available()=2E<br><br>T=
hree doc comments described what the code does not do: the window bounds,<b=
r>reliable_wont_break_sequentiality()&#39;s reference id, subtract_pid()&#3=
9;s argument<br>order=2E reliable_mark_active_incoming() now states the pre=
condition it asserts=2E<br><br>Change-Id: I63c141075d89ae6a07872e784faff817=
dd3350b1<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br=
>---<br>M src/openvpn/reliable=2Ec<br>M src/openvpn/reliable=2Eh<br>M tests=
/unit_tests/openvpn/test_packet_id=2Ec<br>3 files changed, 67 insertions(+)=
, 54 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvp=
n=2Enet:29418/openvpn refs/changes/01/1901/1</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openv=
pn/reliable=2Ec b/src/openvpn/reliable=2Ec</span><br><span>index 6e10211=2E=
=2E7ddc03a 100644</span><br><span>--- a/src/openvpn/reliable=2Ec</span><br>=
<span>+++ b/src/openvpn/reliable=2Ec</span><br><span>@@ -38,8 +38,8 @@</spa=
n><br><span> </span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* calculates te=
st - base while allowing for base or test wraparound=2E test is</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * assumed to be higher than base=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* test - base i=
n the packet id space, wrapping around=2E Only meaningful against</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * an explicit bound: on its =
own it does not say which id came first=2E */</span><br><span> static inlin=
e packet_id_type</span><br><span> subtract_pid(const packet_id_type test, c=
onst packet_id_type base)</span><br><span> {</span><br><span>@@ -356,12 +35=
6,11 @@</span><br><span>     return true;</span><br><span> }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-validate_packet_id_window(struct rel=
iable *rel, packet_id_type pid)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+rel=
iable_pid_in_send_window(const struct reliable *rel, packet_id_type pid)</s=
pan><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    c=
onst packet_id_type dist =3D subtract_pid(rel-&gt;packet_id, pid);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    return dist &gt; 0 &amp;&amp; dist &lt; RELIABL=
E_CAPACITY;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retu=
rn reliable_pid_in_range(pid, subtract_pid(rel-&gt;packet_id, RELIABLE_CAPA=
CITY),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
                    RELIABLE_CAPACITY);</span><br><span> }</span><br><span>=
 </span><br><span> /* del acknowledged items from send buf */</span><br><sp=
an>@@ -376,7 +375,7 @@</span><br><span>         packet_id_type pid =3D ack-=
&gt;packet_id[i];</span><br><span> </span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (!validate_packet_id_window(rel,=
 pid))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!=
reliable_pid_in_send_window(rel, pid))</span><br><span>         {</span><br=
><span>             if (out_of_window =3D=3D 0)</span><br><span>           =
  {</span><br><span>@@ -566,7 +565,7 @@</span><br><span> }</span><br><span>=
 </span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-reliable_get_num_output_sequenced_available(struct reliable *rel)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+reliable_get_num_output_sequ=
enced_available(const struct reliable *rel)</span><br><span> {</span><br><s=
pan>     return rel-&gt;size - (int)reliable_oldest_active_distance(rel);</=
span><br><span> }</span><br><span>diff --git a/src/openvpn/reliable=2Eh b/s=
rc/openvpn/reliable=2Eh</span><br><span>index 04f3372=2E=2E534feb3 100644</=
span><br><span>--- a/src/openvpn/reliable=2Eh</span><br><span>+++ b/src/ope=
nvpn/reliable=2Eh</span><br><span>@@ -190,15 +190,20 @@</span><br><span> }<=
/span><br><span> </span><br><span> /**</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- * check that pid is inside the window of possible outstan=
ding packets</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * of siz=
e RELIABLE_CAPACITY, ie inside the range</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * [rel-&gt;packet_id - RELIABLE_CAPACITY, rel-&gt;packe=
t_id)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Check wh=
ether pid is one of the RELIABLE_CAPACITY ids below rel-&gt;packet_id,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * and so could still be=
 outstanding=2E rel-&gt;packet_id is the *next* id to be</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * sent, so it is not itself in the wi=
ndow=2E</span><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * rel-&gt;packet is the *next* packet id to be sent out, so it is no=
t</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * included in the v=
alid range=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * pid=
 comes off the wire; all 2^32 values are handled=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param rel The reliable structure holding this tunnel&#=
39;s sent packets=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * @param pid A packet ID from a received acknowledgment=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @return</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * @li True, if pid is inside the window=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @li False, otherwise=2E</span><br=
><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-validate_packet_id_window(st=
ruct reliable *rel, packet_id_type pid);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+bool reliable_pid_in_send_window(const struct reliable=
 *rel, packet_id_type pid);</span><br><span> </span><br><span> /**</span><b=
r><span>  * Returns the number of packets that need to be acked=2E</span><b=
r><span>@@ -305,14 +310,15 @@</span><br><span>  * Check that a received pac=
ket&#39;s ID can safely be stored in</span><br><span>  *     the reliable s=
tructure&#39;s processing window=2E</span><br><span>  *</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * This function checks the difference be=
tween the received packet&#39;s ID</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * and the lowest non-acknowledged packet ID in the given reli=
able</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * structure=2E  =
If that difference is larger than the total number of</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * packets which can be stored, then this p=
acket cannot be stored safely,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * because the reliable structure could possibly fill up without l=
eaving</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * room for all=
 intervening packets=2E  In that case, this received packet</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * could break the reliable structure=
&#39;s sequentiality, and must therefore</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * be discarded=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Checks the received packet&#39;s ID against rel-&gt;pa=
cket_id, the next ID the</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * reliability layer expects to hand upwards=2E One too far ahead coul=
d fill the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * struct=
ure without leaving room for the intervening packets, so it is</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * discarded=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * IDs numerically below rel-&gt;packet_id are accept=
ed here, an absolute</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * comparison that an ID from before a wraparound does not pass=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * reliable_not_replay() re=
jects them, and they are still acknowledged so a</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * peer whose ACK was lost stops retransmittin=
g=2E</span><br><span>  *</span><br><span>  * @param rel The reliable struct=
ure for handling this VPN tunnel&#39;s</span><br><span>  *     received pac=
kets=2E</span><br><span>@@ -354,6 +360,10 @@</span><br><span>  * Mark the %=
reliable entry associated with the given buffer as active</span><br><span> =
 * incoming=2E</span><br><span>  *</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * pid must be less than rel-&gt;size ahead of rel-&gt;packe=
t_id=2E This is asserted,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * so run reliable_wont_break_sequentiality() and reliable_not_replay=
()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * first=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span>  * @p=
aram rel The reliable structure associated with this packet=2E</span><br><s=
pan>  * @param buf The buffer into which the packet has been copied=2E</spa=
n><br><span>  * @param pid The packet&#39;s packet ID=2E</span><br><span>@@=
 -446,7 +456,7 @@</span><br><span>  *  @return the number of buffer that ar=
e available for sending without</span><br><span>  *             breaking ac=
k sequence</span><br><span>  * */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-int reliable_get_num_output_sequenced_available(struct reliable=
 *rel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int reliable=
_get_num_output_sequenced_available(const struct reliable *rel);</span><br>=
<span> </span><br><span> /**</span><br><span>  * Mark the reliable entry as=
sociated with the given buffer as</span><br><span>diff --git a/tests/unit_t=
ests/openvpn/test_packet_id=2Ec b/tests/unit_tests/openvpn/test_packet_id=
=2Ec</span><br><span>index 7df74d9=2E=2Ee101412 100644</span><br><span>--- =
a/tests/unit_tests/openvpn/test_packet_id=2Ec</span><br><span>+++ b/tests/u=
nit_tests/openvpn/test_packet_id=2Ec</span><br><span>@@ -331,44 +331,50 @@<=
/span><br><span>     struct reliable rel =3D { 0 };</span><br><span>     re=
l=2Epacket_id =3D 1;</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    assert_true(validate_packet_id_window(&amp;rel, 0));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(relia=
ble_pid_in_send_window(&amp;rel, 0));</span><br><span> </span><br><span>   =
  /* packet id 1 is outside the window as it is the *next* packet id */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_false(validate=
_packet_id_window(&amp;rel, 1));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_false(reliable_pid_in_send_window(&amp;rel, 1));</s=
pan><br><span> </span><br><span>     /* wrapped around packet id, &quot;-2&=
quot; */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_tr=
ue(validate_packet_id_window(&amp;rel, 0xFFFFFFFD));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(reliable_pid_in_send_wind=
ow(&amp;rel, 0xFFFFFFFD));</span><br><span> </span><br><span>     /* wrappe=
d around packet id, &quot;-10&quot; */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    assert_true(validate_packet_id_window(&amp;rel, 0xFFFF=
FFF6));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_t=
rue(reliable_pid_in_send_window(&amp;rel, 0xFFFFFFF6));</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* wrapped around p=
acket id, &quot;-11&quot; */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    assert_false(validate_packet_id_window(&amp;rel, 0xFFFFFFF5));</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_false(valida=
te_packet_id_window(&amp;rel, 0x80000000));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* wrapped around packet id, &quot;-11&quot;: t=
he oldest id still in the window */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_true(reliable_pid_in_send_window(&amp;rel, 0xFFF=
FFFF5));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* one further back is out=
side it */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_false(reliable_pid_in_send_window(&amp;rel, 0xFFFFFFF4));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_false(reliable_pid_in_se=
nd_window(&amp;rel, 0x80000000));</span><br><span> </span><br><span>     re=
l=2Epacket_id =3D 0x80000000;</span><br><span> </span><br><span>     /* nea=
r the signed/usigned integer area */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    assert_false(validate_packet_id_window(&amp;rel, 0x80000=
001));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_true=
(validate_packet_id_window(&amp;rel, 0x7fffffff));</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    assert_true(validate_packet_id_window(&amp=
;rel, 0x7ffffff5));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  assert_false(validate_packet_id_window(&amp;rel, 0x7ffffff4));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(reliable_pid_=
in_send_window(&amp;rel, 0x80000001));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_true(reliable_pid_in_send_window(&amp;rel, 0x=
7fffffff));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_true(reliable_pid_in_send_window(&amp;rel, 0x7ffffff5));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_true(reliable_pid_in_sen=
d_window(&amp;rel, 0x7ffffff4));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_false(reliable_pid_in_send_window(&amp;rel, 0x7ffff=
ff3));</span><br><span> </span><br><span>     rel=2Epacket_id =3D 0xFFFFFFF=
D;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_false(va=
lidate_packet_id_window(&amp;rel, 0xFFFFFFFD));</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    assert_false(validate_packet_id_window(&amp;r=
el, 0));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_fa=
lse(validate_packet_id_window(&amp;rel, 1));</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    assert_false(validate_packet_id_window(&amp;rel,=
 0xFFFFFFFE));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ass=
ert_false(validate_packet_id_window(&amp;rel, 0xFFFFFFFF));</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    assert_true(validate_packet_id_wi=
ndow(&amp;rel, 0xFFFFFFF3));</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    assert_true(validate_packet_id_window(&amp;rel, 0xFFFFFFF2));</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_false(validat=
e_packet_id_window(&amp;rel, 0xFFFFFFF1));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_false(reliable_pid_in_send_window(&amp;re=
l, 0xFFFFFFFD));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_false(reliable_pid_in_send_window(&amp;rel, 0));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_false(reliable_pid_in_send_=
window(&amp;rel, 1));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_false(reliable_pid_in_send_window(&amp;rel, 0xFFFFFFFE));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(reliabl=
e_pid_in_send_window(&amp;rel, 0xFFFFFFFF));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_true(reliable_pid_in_send_window(&amp;r=
el, 0xFFFFFFF3));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_true(reliable_pid_in_send_window(&amp;rel, 0xFFFFFFF2));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(reliable_pid_=
in_send_window(&amp;rel, 0xFFFFFFF1));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_false(reliable_pid_in_send_window(&amp;rel, 0=
xFFFFFFF0));</span><br><span> </span><br><span>     rel=2Epacket_id =3D 500=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_false(val=
idate_packet_id_window(&amp;rel, 501));</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    assert_true(validate_packet_id_window(&amp;rel, 497))=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_true(vali=
date_packet_id_window(&amp;rel, 500 - (RELIABLE_CAPACITY - 1)));</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    assert_false(validate_packet=
_id_window(&amp;rel, 500 - RELIABLE_CAPACITY));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_false(reliable_pid_in_send_window(&a=
mp;rel, 501));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_true(reliable_pid_in_send_window(&amp;rel, 497));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_true(reliable_pid_in_send_wi=
ndow(&amp;rel, 500 - (RELIABLE_CAPACITY - 1)));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_true(reliable_pid_in_send_window(&am=
p;rel, 500 - RELIABLE_CAPACITY));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_false(reliable_pid_in_send_window(&amp;rel, 500 - =
(RELIABLE_CAPACITY + 1)));</span><br><span> }</span><br><span> </span><br><=
span> </span><br><span>@@ -533,21 +539,19 @@</span><br><span>     return (p=
acket_id_type)(p1 - p2) &gt;=3D 0x80000000u;</span><br><span> }</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* one short of=
 RELIABLE_CAPACITY, which is what the code accepts today */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#define CHARACTERIZED_SEND_WINDOW 11<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /* T=
LS_RELIABLE_N_SEND_BUFFERS and P_CONTROL_V1, from ssl_pkt=2Eh, which this</=
span><br><span>  * test binary does not pull in */</span><br><span> #define=
 CHAR_N_SEND_BUFFERS    6</span><br><span> #define CHAR_OPCODE_CONTROL_V1 4=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* =
preserved: the ids validate_packet_id_window() accepts */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/* introduced: the RELIABLE_CAPACITY =
ids below rel-&gt;packet_id=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * validate_packet_id_window() stopped one short of that=2E */</=
span><br><span> static bool</span><br><span> ref_pid_in_send_window(const s=
truct reliable *rel, packet_id_type pid)</span><br><span> {</span><br><span=
>     const packet_id_type dist =3D (packet_id_type)(rel-&gt;packet_id - pi=
d);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    return dist &gt;=3D 1 &amp;&amp; dist &lt;=3D CHARACTERIZED_SEND_WINDOW=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return dist &g=
t;=3D 1 &amp;&amp; dist &lt;=3D RELIABLE_CAPACITY;</span><br><span> }</span=
><br><span> </span><br><span> /* preserved: reliable_pid_in_range2() */</sp=
an><br><span>@@ -798,7 +802,7 @@</span><br><span>                 rel=2Epac=
ket_id =3D anchors[a];</span><br><span> </span><br><span>                 a=
ssert_int_equal(ref_pid_in_send_window(&amp;rel, ids[i]),</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                                 valida=
te_packet_id_window(&amp;rel, ids[i]) !=3D 0);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                                 reliable_pid_in=
_send_window(&amp;rel, ids[i]));</span><br><span>             }</span><br><=
span>         }</span><br><span>     }</span><br><span></span><br></pre><p>=
To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1901?us=
p=3Demail">change 1901</a>=2E To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1901?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/><=
/div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </d=
iv>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I63c141075d89ae6a07872e784faff817dd3350b1 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1901 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--JBFFDCsu0RU=--


--===============1350381672586638409==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1350381672586638409==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1350381672586638409==--

