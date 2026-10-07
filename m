Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 941E3CA6004
	for <openvpn-devel@archiver.kernel.org>; Wed,  7 Oct 2026 20:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JUo3G0CkKJXb6h4Zp2Ot2EhtSuoihRLQAqhb1KA5eUI=; b=VaWfFiEZu5Zy/XHESY5jPU7OYp
	xSJBObg4no9MINEnRZIDa1gWK1QyNpE/yJ5IUoE2uCmqOgBYKJtyEagFO2tJrst8TVis7JoJmLZ2O
	upcJXkYk67Zz48YivwMbkXawBKsR8h4E+/fTfIIggK+hh/ziVCWi3Y23T7FMk26id0Rg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xEXtQ-0006vg-DK;
	Wed, 07 Oct 2026 20:05:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xEXtP-0006va-2F
 for openvpn-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 20:05:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=p48NY3V8pTcBGQ6YNcdxcem4IiFVBybGHOYPKzQGoCk=; b=bXclh7fMbAjCnKrexm42aD+Cy0
 +8pD4jeOejpmIlUb9RAECaX1po3CWEVmcHJ7Qzo2Ch+zZISZCAz/FUcxPs0oRUrdnCXLok1oDa5qJ
 KXSgZXNxS6G3wVKH5gJe3x3f591AFD/RoySeaDhlvaAZG7qnULpamsKcRODA8a6LE/Uw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=p48NY3V8pTcBGQ6YNcdxcem4IiFVBybGHOYPKzQGoCk=; b=M
 Ri+95x3t6MbqWXAbS75PgqLons+VfTkvk9IC0R4BxtufTOpH8yyGN7fI+iee1sJ/bfcbkV9N5WFt6
 +C73NVGbUyh4ACrsjpCW4gXd6x3BLPhWdHht6Z+QLcIDM3Y/btD+9bti4tLWXILw/aHjU7c5IVIvM
 geLr95Me0Lk5Hp0U=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xEXtM-0004BE-AQ for openvpn-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 20:05:34 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a16bc2278aso17027845e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 07 Oct 2026 13:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791403526; x=1792008326; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=p48NY3V8pTcBGQ6YNcdxcem4IiFVBybGHOYPKzQGoCk=;
 b=EvZsTLK1c+SlF9zRBlbeTYjKMJYM0eFKERofMKFTMTB0B2o9h/tz7P4ZqWNVoOoN4l
 rmQAyHTPCm7mAymM+GyOE/gOdG3hXbPMjcSr/4Sm9P+mkjvJCroSwa4fX7BsvFOzpsAa
 D/KrLpZRnOsLZ7lSWmd6c0dzPlLxIzOd187dFmtxj7GeQ4NkjdUorLLxVUA2FP7hiY4q
 gU3EedKQ0jsHb7vXm0wEFY8GpXqVwMr2cMg8hAlxdxmb3AbMxKLXs8xCr6AhtkJsHZir
 eniY37r78IdE8NP9YNN06DlignNn1r7CF/w/DrWJLeRIvRDgat2Tgc7Ezlmo4/VrxHpf
 FIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791403526; x=1792008326;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=p48NY3V8pTcBGQ6YNcdxcem4IiFVBybGHOYPKzQGoCk=;
 b=kFsEClp0KDVsT2pNd5OlwUm2o93sWpY+T80dkwYdTGQKT75NLdFTyrCv/tl6tmliW6
 wQXlOWtpnDnYmMyI6ETLkcVv+faZuJ5GHVc2Xr22HSSysV6Uze1OIV4lfEvwuKlRgneh
 7flgxmx+xJAmVdi3o0G0a4fjD5nGMLWnJxZzEGkXGSDmbkw0EqUSrwakIu+m+UHLrbEI
 mar8r7WDQZyo19dya+VvsuO/gyycWnlc73IUJ26/sZ6aAzJMnEDujcDFpIiuIQIg5UrT
 RvallG16jz8NpOKNRHkWmioCO0FAwkxqi5D5LD1/78mLelLKAzESEquxjEXzFJEaUUKO
 cfWw==
X-Gm-Message-State: AFuF++n2Djg2n4USisI20Bp8ipGn30+bOEsMgTCbq1Oh6Vinj3Y2x6RO
 HDq+pD9oixfG0fkOoIEiIazKikDytpke2hAJlBSp0N9PONQ4dvqi9DIaBOOoP8SiYiyH0o8D3+9
 yYKKtJ2KwAhHNl1pC1Uae1SxJ/6IZrc6b9IacxysjHiYb+fzNZNiagbMe/5yDziq7CFZT
X-Gm-Gg: AYBFou1F/VuDxoIBXqXLvEy55tCtjn6PE6Uwn31p+B4p4DeZnX0h3V8dXrIMxQnNZEj
 e1S7qcIRsTDg+sJ44SKP2PnmKLXN2hho6jLzZ5qLEmrve/0S1gqaQNdOB+kR95DpJo3tB+puxGl
 MJnkaDp9b+77yhI77um2jv4WzTKenFBFk+EGYHq3pjUwOTiDiBsejGaWzeVQDYNohmmRAfAq2Aq
 1mMjHm+jUskIjxQzUpRFfUjGQorKHTkzji6khEzxUkIsr/4bOsH687kWGTyWR8EAaxhGGUKA0F4
 kFXbXKVpXhZcMBGS690xbCELo8nC3vItzJlOr8QSgdQ5N4yJDrbABZqqkkyNIYaiyvOHPGZ8sKw
 Gi4HP+lTfMSIjrNe/tbsKzLqWcicDhxZCkfIvh0mDpd+7ARnmp6nAwIXlx5Ffe6E1uRzSwIwkW2
 sNG8wG+rLb4vm/zV24oayFYpTCrQzF+F2wX0avWWQEJcdsBNTjVKUIoA7MxqcqziEL9iTBI1JkC
 a0zPNNazikzfk3qhrunZwBEKiqUx5AEM6tpQ6hfBibHIY9qk/qGB4J/1ze+FLUv+x83uR9rMW9/
 WtenxxC21rGvd77R45Oox6DrYAMnjY6hdKSX1494dr7aqaBwgD4GvlWf98yT
X-Received: by 2002:a05:600c:a00e:b0:4a0:1a18:b742 with SMTP id
 5b1f17b1804b1-4a1800d3de4mr62487915e9.2.1791403525379; 
 Wed, 07 Oct 2026 13:05:25 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17f4482c4sm159956665e9.0.2026.10.07.13.05.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 13:05:25 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 7 Oct 2026 20:05:18 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I63c141075d89ae6a07872e784faff817dd3350b1
X-Gerrit-Change-Number: 1901
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1901?usp=email>
X-Gerrit-Commit: e8b3f9aeeddf74dc15ebbb0e21003b4d1a25f833
In-Reply-To: <gerrit.1788765781000.I63c141075d89ae6a07872e784faff817dd3350b1@gerrit.openvpn.net>
References: <gerrit.1788765781000.I63c141075d89ae6a07872e784faff817dd3350b1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NzY1NzgxMDAwLkk2M2MxNDEwNzVkODlhZTZhMDc4NzJlNzg0ZmFmZjgxN2RkMzM1MGIxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9bd15e21097a312deea2c0772ec047dfbfc6b175-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xEXtM-0004BE-AQ
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7047156171818533970=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7047156171818533970==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kuuxWkisytg="; charset=UTF-8

--kuuxWkisytg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Hello Arne Schwabe, 

I'd like you to reexamine a change=2E Please visit
=

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1901?usp=3Demail

to look a=
t the new patch set (#3)=2E

The following approvals got outdated and were =
removed:
Code-Review+2 by Arne Schwabe

The change is no longer submittable=
: Code-Review and checks~ChecksSubmitRule are unsatisfied now=2E


Change s=
ubject: reliable: fix the send window width
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

reliable: fix the send window width

The ch=
eck accepted the 11 ids below rel->packet_id where its documentation
said R=
ELIABLE_CAPACITY=2E Twelve is right: reliable_get_buf_output_sequenced()
is=
sues an id while it is less than rel->size beyond the oldest unacknowledged=

one, so an entry can sit a full rel->size below rel->packet_id, and rel->s=
ize
may be RELIABLE_CAPACITY=2E

No effect today, TLS_RELIABLE_N_SEND_BUFFE=
RS being 6=2E Raising the send buffer
count to RELIABLE_CAPACITY, which rel=
iable_init() permits, would have
discarded the ACK for the oldest outstandi=
ng packet=2E

The width is now the extent passed to reliable_pid_in_range()=
 rather than a
comparison operator=2E

Also renames validate_packet_id_wind=
ow() to reliable_pid_in_send_window(),
returning bool and taking a const st=
ruct reliable * like its neighbours, and
the same const on reliable_get_num=
_output_sequenced_available()=2E

Three doc comments described what the cod=
e does not do: the window bounds,
reliable_wont_break_sequentiality()'s ref=
erence id, subtract_pid()'s argument
order=2E reliable_mark_active_incoming=
() now states the precondition it asserts=2E

Change-Id: I63c141075d89ae6a0=
7872e784faff817dd3350b1
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eo=
rg>
---
M src/openvpn/reliable=2Ec
M src/openvpn/reliable=2Eh
M tests/unit_=
tests/openvpn/test_packet_id=2Ec
3 files changed, 68 insertions(+), 54 dele=
tions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/01/1901/3

diff --git a/src/openvpn/reliable=2Ec b/src/openvpn/reliable=
=2Ec
index 645fbfd=2E=2Ec268cce 100644
--- a/src/openvpn/reliable=2Ec
+++ b=
/src/openvpn/reliable=2Ec
@@ -38,8 +38,9 @@
 
 #include "memdbg=2Eh"
 
-/* =
calculates test - base while allowing for base or test wraparound=2E test i=
s
- * assumed to be higher than base */
+/* calculates test - base while al=
lowing for base or test wraparound=2E The
+ * result is only meaningful com=
pared against a bound: on its own it does not
+ * say which id came first=
=2E */
 static inline packet_id_type
 subtract_pid(const packet_id_type tes=
t, const packet_id_type base)
 {
@@ -356,12 +357,11 @@
     return true;
 }=

 
-int
-validate_packet_id_window(struct reliable *rel, packet_id_type pid=
)
+bool
+reliable_pid_in_send_window(const struct reliable *rel, packet_id_=
type pid)
 {
-    const packet_id_type dist =3D subtract_pid(rel->packet_id=
, pid);
-
-    return dist > 0 && dist < RELIABLE_CAPACITY;
+    return rel=
iable_pid_in_range(pid, subtract_pid(rel->packet_id, RELIABLE_CAPACITY),
+ =
                                RELIABLE_CAPACITY);
 }
 
 /* del acknowledg=
ed items from send buf */
@@ -376,7 +376,7 @@
         packet_id_type pid =
=3D ack->packet_id[i];
 
 
-        if (!validate_packet_id_window(rel, pid=
))
+        if (!reliable_pid_in_send_window(rel, pid))
         {
        =
     if (out_of_window =3D=3D 0)
             {
@@ -566,7 +566,7 @@
 }
 
 i=
nt
-reliable_get_num_output_sequenced_available(struct reliable *rel)
+reli=
able_get_num_output_sequenced_available(const struct reliable *rel)
 {
    =
 return rel->size - (int)reliable_oldest_active_distance(rel);
 }
diff --gi=
t a/src/openvpn/reliable=2Eh b/src/openvpn/reliable=2Eh
index 04f3372=2E=2E=
534feb3 100644
--- a/src/openvpn/reliable=2Eh
+++ b/src/openvpn/reliable=2E=
h
@@ -190,15 +190,20 @@
 }
 
 /**
- * check that pid is inside the window o=
f possible outstanding packets
- * of size RELIABLE_CAPACITY, ie inside the=
 range
- * [rel->packet_id - RELIABLE_CAPACITY, rel->packet_id)=2E
+ * Chec=
k whether pid is one of the RELIABLE_CAPACITY ids below rel->packet_id,
+ *=
 and so could still be outstanding=2E rel->packet_id is the *next* id to be=

+ * sent, so it is not itself in the window=2E
  *
- * rel->packet is the =
*next* packet id to be sent out, so it is not
- * included in the valid ran=
ge=2E
+ * pid comes off the wire; all 2^32 values are handled=2E
+ *
+ * @p=
aram rel The reliable structure holding this tunnel's sent packets=2E
+ * @=
param pid A packet ID from a received acknowledgment=2E
+ *
+ * @return
+ *=
 @li True, if pid is inside the window=2E
+ * @li False, otherwise=2E
  */
=
-int
-validate_packet_id_window(struct reliable *rel, packet_id_type pid);
=
+bool reliable_pid_in_send_window(const struct reliable *rel, packet_id_typ=
e pid);
 
 /**
  * Returns the number of packets that need to be acked=2E
@=
@ -305,14 +310,15 @@
  * Check that a received packet's ID can safely be st=
ored in
  *     the reliable structure's processing window=2E
  *
- * This =
function checks the difference between the received packet's ID
- * and the=
 lowest non-acknowledged packet ID in the given reliable
- * structure=2E  =
If that difference is larger than the total number of
- * packets which can=
 be stored, then this packet cannot be stored safely,
- * because the relia=
ble structure could possibly fill up without leaving
- * room for all inter=
vening packets=2E  In that case, this received packet
- * could break the r=
eliable structure's sequentiality, and must therefore
- * be discarded=2E
+=
 * Checks the received packet's ID against rel->packet_id, the next ID the
=
+ * reliability layer expects to hand upwards=2E One too far ahead could fi=
ll the
+ * structure without leaving room for the intervening packets, so i=
t is
+ * discarded=2E
+ *
+ * IDs numerically below rel->packet_id are acce=
pted here, an absolute
+ * comparison that an ID from before a wraparound d=
oes not pass=2E
+ * reliable_not_replay() rejects them, and they are still =
acknowledged so a
+ * peer whose ACK was lost stops retransmitting=2E
  *
 =
 * @param rel The reliable structure for handling this VPN tunnel's
  *    =
 received packets=2E
@@ -354,6 +360,10 @@
  * Mark the %reliable entry asso=
ciated with the given buffer as active
  * incoming=2E
  *
+ * pid must be =
less than rel->size ahead of rel->packet_id=2E This is asserted,
+ * so run=
 reliable_wont_break_sequentiality() and reliable_not_replay()
+ * first=2E=

+ *
  * @param rel The reliable structure associated with this packet=2E
 =
 * @param buf The buffer into which the packet has been copied=2E
  * @para=
m pid The packet's packet ID=2E
@@ -446,7 +456,7 @@
  *  @return the number=
 of buffer that are available for sending without
  *             breaking =
ack sequence
  * */
-int reliable_get_num_output_sequenced_available(struct=
 reliable *rel);
+int reliable_get_num_output_sequenced_available(const str=
uct reliable *rel);
 
 /**
  * Mark the reliable entry associated with the =
given buffer as
diff --git a/tests/unit_tests/openvpn/test_packet_id=2Ec b/=
tests/unit_tests/openvpn/test_packet_id=2Ec
index ac6c710=2E=2E245c357 1006=
44
--- a/tests/unit_tests/openvpn/test_packet_id=2Ec
+++ b/tests/unit_tests=
/openvpn/test_packet_id=2Ec
@@ -331,44 +331,50 @@
     struct reliable rel =
=3D { 0 };
     rel=2Epacket_id =3D 1;
 
-    assert_true(validate_packet_i=
d_window(&rel, 0));
+    assert_true(reliable_pid_in_send_window(&rel, 0));=

 
     /* packet id 1 is outside the window as it is the *next* packet id =
*/
-    assert_false(validate_packet_id_window(&rel, 1));
+    assert_false=
(reliable_pid_in_send_window(&rel, 1));
 
     /* wrapped around packet id,=
 "-2" */
-    assert_true(validate_packet_id_window(&rel, 0xFFFFFFFD));
+  =
  assert_true(reliable_pid_in_send_window(&rel, 0xFFFFFFFD));
 
     /* wra=
pped around packet id, "-10" */
-    assert_true(validate_packet_id_window(=
&rel, 0xFFFFFFF6));
+    assert_true(reliable_pid_in_send_window(&rel, 0xFF=
FFFFF6));
 
-    /* wrapped around packet id, "-11" */
-    assert_false(va=
lidate_packet_id_window(&rel, 0xFFFFFFF5));
-    assert_false(validate_pack=
et_id_window(&rel, 0x80000000));
+    /* wrapped around packet id, "-11": t=
he oldest id still in the window */
+    assert_true(reliable_pid_in_send_w=
indow(&rel, 0xFFFFFFF5));
+
+    /* one further back is outside it */
+    =
assert_false(reliable_pid_in_send_window(&rel, 0xFFFFFFF4));
+    assert_fa=
lse(reliable_pid_in_send_window(&rel, 0x80000000));
 
     rel=2Epacket_id =
=3D 0x80000000;
 
     /* near the signed/usigned integer area */
-    asse=
rt_false(validate_packet_id_window(&rel, 0x80000001));
-    assert_true(val=
idate_packet_id_window(&rel, 0x7fffffff));
-    assert_true(validate_packet=
_id_window(&rel, 0x7ffffff5));
-    assert_false(validate_packet_id_window(=
&rel, 0x7ffffff4));
+    assert_false(reliable_pid_in_send_window(&rel, 0x8=
0000001));
+    assert_true(reliable_pid_in_send_window(&rel, 0x7fffffff));=

+    assert_true(reliable_pid_in_send_window(&rel, 0x7ffffff5));
+    asse=
rt_true(reliable_pid_in_send_window(&rel, 0x7ffffff4));
+    assert_false(r=
eliable_pid_in_send_window(&rel, 0x7ffffff3));
 
     rel=2Epacket_id =3D 0=
xFFFFFFFD;
-    assert_false(validate_packet_id_window(&rel, 0xFFFFFFFD));
=
-    assert_false(validate_packet_id_window(&rel, 0));
-    assert_false(va=
lidate_packet_id_window(&rel, 1));
-    assert_false(validate_packet_id_win=
dow(&rel, 0xFFFFFFFE));
-    assert_false(validate_packet_id_window(&rel, 0=
xFFFFFFFF));
-    assert_true(validate_packet_id_window(&rel, 0xFFFFFFF3));=

-    assert_true(validate_packet_id_window(&rel, 0xFFFFFFF2));
-    assert=
_false(validate_packet_id_window(&rel, 0xFFFFFFF1));
+    assert_false(reli=
able_pid_in_send_window(&rel, 0xFFFFFFFD));
+    assert_false(reliable_pid_=
in_send_window(&rel, 0));
+    assert_false(reliable_pid_in_send_window(&re=
l, 1));
+    assert_false(reliable_pid_in_send_window(&rel, 0xFFFFFFFE));
+=
    assert_false(reliable_pid_in_send_window(&rel, 0xFFFFFFFF));
+    asser=
t_true(reliable_pid_in_send_window(&rel, 0xFFFFFFF3));
+    assert_true(rel=
iable_pid_in_send_window(&rel, 0xFFFFFFF2));
+    assert_true(reliable_pid_=
in_send_window(&rel, 0xFFFFFFF1));
+    assert_false(reliable_pid_in_send_w=
indow(&rel, 0xFFFFFFF0));
 
     rel=2Epacket_id =3D 500;
-    assert_false=
(validate_packet_id_window(&rel, 501));
-    assert_true(validate_packet_id=
_window(&rel, 497));
-    assert_true(validate_packet_id_window(&rel, 500 -=
 (RELIABLE_CAPACITY - 1)));
-    assert_false(validate_packet_id_window(&re=
l, 500 - RELIABLE_CAPACITY));
+    assert_false(reliable_pid_in_send_window=
(&rel, 501));
+    assert_true(reliable_pid_in_send_window(&rel, 497));
+  =
  assert_true(reliable_pid_in_send_window(&rel, 500 - (RELIABLE_CAPACITY - =
1)));
+    assert_true(reliable_pid_in_send_window(&rel, 500 - RELIABLE_CAP=
ACITY));
+    assert_false(reliable_pid_in_send_window(&rel, 500 - (RELIABL=
E_CAPACITY + 1)));
 }
 
 
@@ -533,21 +539,19 @@
     return (packet_id_type=
)(p1 - p2) >=3D 0x80000000u;
 }
 
-/* one short of RELIABLE_CAPACITY, which=
 is what the code accepts today */
-#define CHARACTERIZED_SEND_WINDOW 11
-
=
 /* TLS_RELIABLE_N_SEND_BUFFERS and P_CONTROL_V1, from ssl_pkt=2Eh, which t=
his
  * test binary does not pull in */
 #define CHAR_N_SEND_BUFFERS    6
 =
#define CHAR_OPCODE_CONTROL_V1 4
 
-/* preserved: the ids validate_packet_i=
d_window() accepts */
+/* introduced: the RELIABLE_CAPACITY ids below rel->=
packet_id=2E
+ * validate_packet_id_window() stopped one short of that=2E *=
/
 static bool
 ref_pid_in_send_window(const struct reliable *rel, packet_i=
d_type pid)
 {
     const packet_id_type dist =3D (packet_id_type)(rel->pac=
ket_id - pid);
 
-    return dist >=3D 1 && dist <=3D CHARACTERIZED_SEND_WI=
NDOW;
+    return dist >=3D 1 && dist <=3D RELIABLE_CAPACITY;
 }
 
 /* pres=
erved: reliable_pid_in_range2() */
@@ -798,7 +802,7 @@
                 rel=
=2Epacket_id =3D anchors[a];
 
                 assert_int_equal(ref_pid_in=
_send_window(&rel, ids[i]),
-                                 validate_pack=
et_id_window(&rel, ids[i]) !=3D 0);
+                                 relia=
ble_pid_in_send_window(&rel, ids[i]));
             }
         }
     }

--=
 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1901?usp=3Demai=
l
To unsubscribe, or for help writing mail filters, visit https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-=
Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I63c141075d89ae6a0=
7872e784faff817dd3350b1
Gerrit-Change-Number: 1901
Gerrit-PatchSet: 3
Gerri=
t-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne=
 Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razva=
nc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eor=
g>

--kuuxWkisytg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>R=C4=83=
zvan Cojocaru <strong>uploaded patch set #3</strong> to this change=2E</p><=
p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1901?usp=3Demail">V=
iew Change</a></p><p>The following approvals got outdated and were removed:=

Code-Review+2 by Arne Schwabe</p><p>The change is no longer submittable: C=
ode-Review and checks~ChecksSubmitRule are unsatisfied now=2E</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">reliable: fix the send window width<br><br>The check accepted the 11 id=
s below rel-&gt;packet_id where its documentation<br>said RELIABLE_CAPACITY=
=2E Twelve is right: reliable_get_buf_output_sequenced()<br>issues an id wh=
ile it is less than rel-&gt;size beyond the oldest unacknowledged<br>one, s=
o an entry can sit a full rel-&gt;size below rel-&gt;packet_id, and rel-&gt=
;size<br>may be RELIABLE_CAPACITY=2E<br><br>No effect today, TLS_RELIABLE_N=
_SEND_BUFFERS being 6=2E Raising the send buffer<br>count to RELIABLE_CAPAC=
ITY, which reliable_init() permits, would have<br>discarded the ACK for the=
 oldest outstanding packet=2E<br><br>The width is now the extent passed to =
reliable_pid_in_range() rather than a<br>comparison operator=2E<br><br>Also=
 renames validate_packet_id_window() to reliable_pid_in_send_window(),<br>r=
eturning bool and taking a const struct reliable * like its neighbours, and=
<br>the same const on reliable_get_num_output_sequenced_available()=2E<br><=
br>Three doc comments described what the code does not do: the window bound=
s,<br>reliable_wont_break_sequentiality()&#39;s reference id, subtract_pid(=
)&#39;s argument<br>order=2E reliable_mark_active_incoming() now states the=
 precondition it asserts=2E<br><br>Change-Id: I63c141075d89ae6a07872e784faf=
f817dd3350b1<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt=
;<br>---<br>M src/openvpn/reliable=2Ec<br>M src/openvpn/reliable=2Eh<br>M t=
ests/unit_tests/openvpn/test_packet_id=2Ec<br>3 files changed, 68 insertion=
s(+), 54 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eop=
envpn=2Enet:29418/openvpn refs/changes/01/1901/3</pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/o=
penvpn/reliable=2Ec b/src/openvpn/reliable=2Ec</span><br><span>index 645fbf=
d=2E=2Ec268cce 100644</span><br><span>--- a/src/openvpn/reliable=2Ec</span>=
<br><span>+++ b/src/openvpn/reliable=2Ec</span><br><span>@@ -38,8 +38,9 @@<=
/span><br><span> </span><br><span> #include &quot;memdbg=2Eh&quot;</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* calculate=
s test - base while allowing for base or test wraparound=2E test is</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * assumed to be higher than =
base */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* calculate=
s test - base while allowing for base or test wraparound=2E The</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * result is only meaningful co=
mpared against a bound: on its own it does not</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * say which id came first=2E */</span><br><span=
> static inline packet_id_type</span><br><span> subtract_pid(const packet_i=
d_type test, const packet_id_type base)</span><br><span> {</span><br><span>=
@@ -356,12 +357,11 @@</span><br><span>     return true;</span><br><span> }<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-validate_packet_id_win=
dow(struct reliable *rel, packet_id_type pid)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+reliable_pid_in_send_window(const struct reliable *rel, packet_i=
d_type pid)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    const packet_id_type dist =3D subtract_pid(rel-&gt;packet_id, =
pid);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    return dist &gt; 0 &amp;&amp; dis=
t &lt; RELIABLE_CAPACITY;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return reliable_pid_in_range(pid, subtract_pid(rel-&gt;packet_id,=
 RELIABLE_CAPACITY),</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                                 RELIABLE_CAPACITY);</span><br><span> }</s=
pan><br><span> </span><br><span> /* del acknowledged items from send buf */=
</span><br><span>@@ -376,7 +376,7 @@</span><br><span>         packet_id_typ=
e pid =3D ack-&gt;packet_id[i];</span><br><span> </span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!validate_packet_=
id_window(rel, pid))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (!reliable_pid_in_send_window(rel, pid))</span><br><span>      =
   {</span><br><span>             if (out_of_window =3D=3D 0)</span><br><sp=
an>             {</span><br><span>@@ -566,7 +566,7 @@</span><br><span> }</s=
pan><br><span> </span><br><span> int</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-reliable_get_num_output_sequenced_available(struct reliable =
*rel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+reliable_get_n=
um_output_sequenced_available(const struct reliable *rel)</span><br><span> =
{</span><br><span>     return rel-&gt;size - (int)reliable_oldest_active_di=
stance(rel);</span><br><span> }</span><br><span>diff --git a/src/openvpn/re=
liable=2Eh b/src/openvpn/reliable=2Eh</span><br><span>index 04f3372=2E=2E53=
4feb3 100644</span><br><span>--- a/src/openvpn/reliable=2Eh</span><br><span=
>+++ b/src/openvpn/reliable=2Eh</span><br><span>@@ -190,15 +190,20 @@</span=
><br><span> }</span><br><span> </span><br><span> /**</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * check that pid is inside the window of p=
ossible outstanding packets</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * of size RELIABLE_CAPACITY, ie inside the range</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * [rel-&gt;packet_id - RELIABLE_CAPACITY=
, rel-&gt;packet_id)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * Check whether pid is one of the RELIABLE_CAPACITY ids below rel-&gt;=
packet_id,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * and so=
 could still be outstanding=2E rel-&gt;packet_id is the *next* id to be</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * sent, so it is not i=
tself in the window=2E</span><br><span>  *</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- * rel-&gt;packet is the *next* packet id to be sent o=
ut, so it is not</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * in=
cluded in the valid range=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * pid comes off the wire; all 2^32 values are handled=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @param rel The reliable structure holding =
this tunnel&#39;s sent packets=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @param pid A packet ID from a received acknowledgment=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @return</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @li True, if pid is inside the window=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @li False, otherwise=
=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-validate_packet=
_id_window(struct reliable *rel, packet_id_type pid);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool reliable_pid_in_send_window(const st=
ruct reliable *rel, packet_id_type pid);</span><br><span> </span><br><span>=
 /**</span><br><span>  * Returns the number of packets that need to be acke=
d=2E</span><br><span>@@ -305,14 +310,15 @@</span><br><span>  * Check that a=
 received packet&#39;s ID can safely be stored in</span><br><span>  *     t=
he reliable structure&#39;s processing window=2E</span><br><span>  *</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * This function checks the =
difference between the received packet&#39;s ID</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * and the lowest non-acknowledged packet ID in t=
he given reliable</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * s=
tructure=2E  If that difference is larger than the total number of</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * packets which can be stored=
, then this packet cannot be stored safely,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- * because the reliable structure could possibly fill=
 up without leaving</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
 room for all intervening packets=2E  In that case, this received packet</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * could break the relia=
ble structure&#39;s sequentiality, and must therefore</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * be discarded=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * Checks the received packet&#39;s ID again=
st rel-&gt;packet_id, the next ID the</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * reliability layer expects to hand upwards=2E One too f=
ar ahead could fill the</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * structure without leaving room for the intervening packets, so it is=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * discarded=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * IDs numerically below rel-&gt;packet_=
id are accepted here, an absolute</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * comparison that an ID from before a wraparound does not pa=
ss=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * reliable_no=
t_replay() rejects them, and they are still acknowledged so a</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * peer whose ACK was lost stops =
retransmitting=2E</span><br><span>  *</span><br><span>  * @param rel The re=
liable structure for handling this VPN tunnel&#39;s</span><br><span>  *    =
 received packets=2E</span><br><span>@@ -354,6 +360,10 @@</span><br><span> =
 * Mark the %reliable entry associated with the given buffer as active</spa=
n><br><span>  * incoming=2E</span><br><span>  *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * pid must be less than rel-&gt;size ahead of =
rel-&gt;packet_id=2E This is asserted,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * so run reliable_wont_break_sequentiality() and reliab=
le_not_replay()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * f=
irst=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span>  * @param rel The reliable structure associated with this packet=2E=
</span><br><span>  * @param buf The buffer into which the packet has been c=
opied=2E</span><br><span>  * @param pid The packet&#39;s packet ID=2E</span=
><br><span>@@ -446,7 +456,7 @@</span><br><span>  *  @return the number of b=
uffer that are available for sending without</span><br><span>  *           =
  breaking ack sequence</span><br><span>  * */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-int reliable_get_num_output_sequenced_available(st=
ruct reliable *rel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+int reliable_get_num_output_sequenced_available(const struct reliable *rel=
);</span><br><span> </span><br><span> /**</span><br><span>  * Mark the reli=
able entry associated with the given buffer as</span><br><span>diff --git a=
/tests/unit_tests/openvpn/test_packet_id=2Ec b/tests/unit_tests/openvpn/tes=
t_packet_id=2Ec</span><br><span>index ac6c710=2E=2E245c357 100644</span><br=
><span>--- a/tests/unit_tests/openvpn/test_packet_id=2Ec</span><br><span>++=
+ b/tests/unit_tests/openvpn/test_packet_id=2Ec</span><br><span>@@ -331,44 =
+331,50 @@</span><br><span>     struct reliable rel =3D { 0 };</span><br><s=
pan>     rel=2Epacket_id =3D 1;</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    assert_true(validate_packet_id_window(&amp;=
rel, 0));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_true(reliable_pid_in_send_window(&amp;rel, 0));</span><br><span> </span><b=
r><span>     /* packet id 1 is outside the window as it is the *next* packe=
t id */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_fal=
se(validate_packet_id_window(&amp;rel, 1));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_false(reliable_pid_in_send_window(&amp;r=
el, 1));</span><br><span> </span><br><span>     /* wrapped around packet id=
, &quot;-2&quot; */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  assert_true(validate_packet_id_window(&amp;rel, 0xFFFFFFFD));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(reliable_pid_in=
_send_window(&amp;rel, 0xFFFFFFFD));</span><br><span> </span><br><span>    =
 /* wrapped around packet id, &quot;-10&quot; */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    assert_true(validate_packet_id_window(&amp;r=
el, 0xFFFFFFF6));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_true(reliable_pid_in_send_window(&amp;rel, 0xFFFFFFF6));</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* wrappe=
d around packet id, &quot;-11&quot; */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    assert_false(validate_packet_id_window(&amp;rel, 0xFFF=
FFFF5));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_fa=
lse(validate_packet_id_window(&amp;rel, 0x80000000));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* wrapped around packet id, &quot;-1=
1&quot;: the oldest id still in the window */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_true(reliable_pid_in_send_window(&amp;=
rel, 0xFFFFFFF5));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* one further b=
ack is outside it */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_false(reliable_pid_in_send_window(&amp;rel, 0xFFFFFFF4));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(reliable=
_pid_in_send_window(&amp;rel, 0x80000000));</span><br><span> </span><br><sp=
an>     rel=2Epacket_id =3D 0x80000000;</span><br><span> </span><br><span> =
    /* near the signed/usigned integer area */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    assert_false(validate_packet_id_window(&amp;re=
l, 0x80000001));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    a=
ssert_true(validate_packet_id_window(&amp;rel, 0x7fffffff));</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    assert_true(validate_packet_id_w=
indow(&amp;rel, 0x7ffffff5));</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    assert_false(validate_packet_id_window(&amp;rel, 0x7ffffff4));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(rel=
iable_pid_in_send_window(&amp;rel, 0x80000001));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_true(reliable_pid_in_send_window(&a=
mp;rel, 0x7fffffff));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_true(reliable_pid_in_send_window(&amp;rel, 0x7ffffff5));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(reliable_=
pid_in_send_window(&amp;rel, 0x7ffffff4));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_false(reliable_pid_in_send_window(&amp;re=
l, 0x7ffffff3));</span><br><span> </span><br><span>     rel=2Epacket_id =3D=
 0xFFFFFFFD;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    asser=
t_false(validate_packet_id_window(&amp;rel, 0xFFFFFFFD));</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    assert_false(validate_packet_id_win=
dow(&amp;rel, 0));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 assert_false(validate_packet_id_window(&amp;rel, 1));</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    assert_false(validate_packet_id_window=
(&amp;rel, 0xFFFFFFFE));</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    assert_false(validate_packet_id_window(&amp;rel, 0xFFFFFFFF));</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_true(validate_pa=
cket_id_window(&amp;rel, 0xFFFFFFF3));</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    assert_true(validate_packet_id_window(&amp;rel, 0xFFFF=
FFF2));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_fal=
se(validate_packet_id_window(&amp;rel, 0xFFFFFFF1));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_false(reliable_pid_in_send_win=
dow(&amp;rel, 0xFFFFFFFD));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_false(reliable_pid_in_send_window(&amp;rel, 0));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(reliable_p=
id_in_send_window(&amp;rel, 1));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_false(reliable_pid_in_send_window(&amp;rel, 0xFFFFF=
FFE));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_fa=
lse(reliable_pid_in_send_window(&amp;rel, 0xFFFFFFFF));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_true(reliable_pid_in_send_wi=
ndow(&amp;rel, 0xFFFFFFF3));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_true(reliable_pid_in_send_window(&amp;rel, 0xFFFFFFF2))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(re=
liable_pid_in_send_window(&amp;rel, 0xFFFFFFF1));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_false(reliable_pid_in_send_window(=
&amp;rel, 0xFFFFFFF0));</span><br><span> </span><br><span>     rel=2Epacket=
_id =3D 500;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    asser=
t_false(validate_packet_id_window(&amp;rel, 501));</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    assert_true(validate_packet_id_window(&amp=
;rel, 497));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    asser=
t_true(validate_packet_id_window(&amp;rel, 500 - (RELIABLE_CAPACITY - 1)));=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_false(vali=
date_packet_id_window(&amp;rel, 500 - RELIABLE_CAPACITY));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_false(reliable_pid_in_sen=
d_window(&amp;rel, 501));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_true(reliable_pid_in_send_window(&amp;rel, 497));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(reliable_pid=
_in_send_window(&amp;rel, 500 - (RELIABLE_CAPACITY - 1)));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_true(reliable_pid_in_send=
_window(&amp;rel, 500 - RELIABLE_CAPACITY));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_false(reliable_pid_in_send_window(&amp;=
rel, 500 - (RELIABLE_CAPACITY + 1)));</span><br><span> }</span><br><span> <=
/span><br><span> </span><br><span>@@ -533,21 +539,19 @@</span><br><span>   =
  return (packet_id_type)(p1 - p2) &gt;=3D 0x80000000u;</span><br><span> }<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* o=
ne short of RELIABLE_CAPACITY, which is what the code accepts today */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CHARACTERIZED_SEND=
_WINDOW 11</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span> /* TLS_RELIABLE_N_SEND_BUFFERS and P_CONTROL_V1, from ssl_pkt=2Eh, w=
hich this</span><br><span>  * test binary does not pull in */</span><br><sp=
an> #define CHAR_N_SEND_BUFFERS    6</span><br><span> #define CHAR_OPCODE_C=
ONTROL_V1 4</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-/* preserved: the ids validate_packet_id_window() accepts */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/* introduced: the RELIABL=
E_CAPACITY ids below rel-&gt;packet_id=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * validate_packet_id_window() stopped one short of t=
hat=2E */</span><br><span> static bool</span><br><span> ref_pid_in_send_win=
dow(const struct reliable *rel, packet_id_type pid)</span><br><span> {</spa=
n><br><span>     const packet_id_type dist =3D (packet_id_type)(rel-&gt;pac=
ket_id - pid);</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    return dist &gt;=3D 1 &amp;&amp; dist &lt;=3D CHARACTERIZED_=
SEND_WINDOW;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret=
urn dist &gt;=3D 1 &amp;&amp; dist &lt;=3D RELIABLE_CAPACITY;</span><br><sp=
an> }</span><br><span> </span><br><span> /* preserved: reliable_pid_in_rang=
e2() */</span><br><span>@@ -798,7 +802,7 @@</span><br><span>               =
  rel=2Epacket_id =3D anchors[a];</span><br><span> </span><br><span>       =
          assert_int_equal(ref_pid_in_send_window(&amp;rel, ids[i]),</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                            =
     validate_packet_id_window(&amp;rel, ids[i]) !=3D 0);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                                 reli=
able_pid_in_send_window(&amp;rel, ids[i]));</span><br><span>             }<=
/span><br><span>         }</span><br><span>     }</span><br></pre><p>To vie=
w, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1901?usp=3De=
mail">change 1901</a>=2E To unsubscribe, or for help writing mail filters, =
visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setti=
ngs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActi=
on"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1901?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I63c141075d89ae6a07872e784faff817dd3350b1 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1901 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--kuuxWkisytg=--


--===============7047156171818533970==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7047156171818533970==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7047156171818533970==--

