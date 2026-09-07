Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93620C79F9E
	for <openvpn-devel@archiver.kernel.org>; Mon,  7 Sep 2026 07:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=pWc1H5uMRANvqMu11/9V8NAHdrw0+lY/xK95LsSHgBw=; b=l4AiNtkvnYDVYp
	gRA2y9sgDiYhI2B7aAfaqLp+IKrqYZwTiNLEIM8UxyiJ6Srd7UHWLNvh09VDWTd3iLs9Tu6dmbGWE
	Yyn6qAU25Xq7Q2bjNyFfa0HicDrg/4ZzYjvW5T2kHxGZWKNMKPGjnwVNJ9K/xkX8NSSQVRUBgpF/0
	css=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3ThF-0005ET-R6;
	Mon, 07 Sep 2026 07:23:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x3ThF-0005EM-43
 for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 07:23:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=p/9O7QYy56BlunLZHCNZedv6vKJUaJ3P5HyTf5J5zJo=; b=eVnqNBjyr1HR2/o7XNzeVKGGcO
 1pn5zv1LY459DjsW5WUWyaX/Luy98jR7s+HRMeei0jaqGpouyLrrZ6UIpa+Js3ilZ3jyOEGQ34PGY
 TgXO2SZc1/aKVdK4kz8hywUqeCqmvghvro+rS4+UUwkMcIjNyMhQBEr4tXn6ErqaKhkk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=p/9O7QYy56BlunLZHCNZedv6vKJUaJ3P5HyTf5J5zJo=; b=E
 fZzc2wlg7Xn6wOLCsfqnNwP9XFKFLZKRMH/s/qqGxnnZG8/RByTCBb/Xdta27e7lmlUdqD01DGmrs
 rx8JcYkG3Sx0f3vudbj1HE54TxUuny0k97PD4acPeLF/PZYC6zhkpgalByfDAVWfhXWdSfFuqW4m4
 N1Mj46ZcniOczfxg=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3ThB-0007NL-5n for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 07:23:16 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-49ccfbe062eso29837425e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 07 Sep 2026 00:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788765786; x=1789370586; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=p/9O7QYy56BlunLZHCNZedv6vKJUaJ3P5HyTf5J5zJo=;
 b=QmGkbsP5W+gsHszSk49ZUz/OLtd1xc66YqiQHpmoDq+nFiUnC4TNdfxSV+sxE5G/Gu
 2EU0g3fx5p71QWQ3JFU7vUhgyYgefM5OhJAHyDbzfZhfekxzqfAqTeluzplcqwAsHUyL
 5MSMeGysZkTxD2N6HxUA13mtaCShldpxSqk/zDPDKRN9wzk8NBVmdM8FyjFO5UwjfNtA
 gUxtsqKEKoZscShoUe5Lefe0XLPxpaedI8cLP+jeNB+xIBcw9OXkTkxxmnpk79jbCsoT
 66ibc9KSAkCYFx550uyJfPQzzlAxVBN1pXR5fv8rAb8qtqnnIjGsZvaKq91hjNaJ823v
 8zbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788765786; x=1789370586;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p/9O7QYy56BlunLZHCNZedv6vKJUaJ3P5HyTf5J5zJo=;
 b=WLBCfXttM8XPfy1xHprNdRAk+/saaREaNIYbR8c/WVvE0gVz2vlqSpqilU6527rwqj
 jzVFyzWAWZn7/T3eUZ02Czw0eTR/MBL0W2sd+PkKpBosWXGcKze9YPlaSEvBNVjNIIl8
 wQGZ1QYmKUGvUh+ITZvFbNal+yijxmsXqHnLGQ6lUeLuOiNC8qGwV5Kpe72Nlsmlzc9m
 6JbEoZJI1pdJ1/uZZutNzYq13ud3NzpXsP8VBxITDTRGoh2aLEz6HWyvONX52irPS5Dl
 QcuioEHw09eYocPm5Ie9xpR1Q5lDeln3VjMBhYRfVQnHnd2WL9xx78hqWsrlVSCMA+fF
 9fmA==
X-Gm-Message-State: AFuF++lvuzg17HRFCdCdt3soyI5RhGsof5eIadWTQup7pMAmNbMfmS5v
 cdQkzHxyAj1AXjdP1jdBt+lxAS0YUy0rjC8uC7Nre6B+OBylwNngvIFRgrZerpnQ/Oj9Bmj1S8h
 lHpHU38AZjWmjsvbg4ohbEV2OkODQRsvEQqk1EOZQ7hcy4yZAfZJDwNgJveOF9HQQ6nl4kRg5Nk
 Bj2cix0A==
X-Gm-Gg: AYBFou3CDNPZ4QCoJgKyS5zOI7hEIG6rByViWZXJU69U/6QF0wvYu7nQ05tFq98Uz0X
 s1Nke+kRBQfiVQuXz0j/Px8pzZ8KzbQO9LpXZKpDMddOstqREYUDmsx6/g8nJIBOgtXaOT+FGR1
 3NtG3N1DEFXtNSPz1KJzyk+dsvEGVykNBgT6lc99S0a7qEChqG4YYwjRwW76zxQMWYddXKN2fL6
 N9nI5XlmfekzVLNbnQYPgDYvXnWOSEINfndX59Kq4vGVm3w7wIDkVaNm2mRwDeWzIfwqBg6vLcD
 6HIA8DbzYw5EQx9nH4Qc/24EHe9Se8Tq76b9aE1XH9gNLZoo71V1AhhuMhC+bbmOYfemuUS3CSO
 LGO9VMz+Jn+kXE6Fb9oNGIy1qE8MRYbuJLF5PaILFiQJRdYmvz8IWGr4/xRL+rpHGDQH1tabTsU
 a2Indby98wkqdIQRPETrOw409DVVgxsiSLh9XyTRtdsNKeIx5LuFd6dXvFNnxtO9aj/vTbQmVtl
 OfdeZOQ7cHi9Uzo/CFeaV5p5Ba5IGJb2ZoMHhLsGbpSqcNwP+5UHR4PhhOXgO3NBzRWmggSD88w
 zivxlYOI8oOQ6oyJ4PKwGB0V9IxhtePhLaPruOaJo3bg9H44Eds=
X-Received: by 2002:a05:600c:83ce:b0:49c:fa20:cbff with SMTP id
 5b1f17b1804b1-49cfa20cd37mr185258365e9.22.1788765786089; 
 Mon, 07 Sep 2026 00:23:06 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf7740d44sm645330675e9.15.2026.09.07.00.23.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 00:23:05 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 7 Sep 2026 07:23:05 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iaaa0af7d678eb447bc93741add8120d9f348d9eb
X-Gerrit-Change-Number: 1900
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1900?usp=email>
X-Gerrit-Commit: 69816164a9b60a38214c21ce64a6cf169d732327
References: <gerrit.1788765781000.Iaaa0af7d678eb447bc93741add8120d9f348d9eb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NzY1NzgxMDAwLklhYWEwYWY3ZDY3OGViNDQ3YmM5Mzc0MWFkZDgxMjBkOWYzNDhkOWViQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9681712831d4ecb9168f14f7a8b6907b47af6f17-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x3ThB-0007NL-5n
Subject: [Openvpn-devel] [L] Change in openvpn[master]: reliable: drop the
 half-space packet id comparisons
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
Content-Type: multipart/mixed; boundary="===============5040544297771564177=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5040544297771564177==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SuHYjZazDfk="; charset=UTF-8

--SuHYjZazDfk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1900?usp=3Demail

to review the following change=2E


Chang=
e subject: reliable: drop the half-space packet id comparisons
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

reliable: drop the half-s=
pace packet id comparisons

Every comparison becomes a modular distance aga=
inst a stated bound=2E
subtract_pid() stays and reliable_pid_in_range1() lo=
ses its suffix;
reliable_pid_min() and reliable_pid_in_range2() go, and wit=
h them the last
0x80000000 in the file=2E

The three scans for the oldest u=
nacknowledged entry now track the largest
distance below rel->packet_id, bo=
unded by rel->size, in
reliable_oldest_active_distance()=2E reliable_wont_b=
reak_sequentiality() bounds
the distance ahead and accepts past ids outrigh=
t, as the old comparison did
without the 0x80000000 bias=2E

reliable_can_s=
end() counts the same entries without the window bound and its
caller asser=
ts on the result, so reliable_send() falls back to any eligible
entry when =
the bound leaves nothing=2E

Equivalent for every reachable input=2E Four d=
eliberate differences:

- Once rel->packet_id + rel->size overflows, the ab=
solute clause makes
  reliable_wont_break_sequentiality() permissive: ids t=
he old bias branch
  rejected are acknowledged=2E Nothing more is stored, r=
eliable_not_replay()
  still bounding that to the receive window, which wra=
ps with rel->packet_id=2E
  Needs ~2^32 control channel packets in one key =
state=2E
- Above 2^31, an id absolutely below rel->packet_id + rel->size bu=
t more than
  rel->size ahead is acknowledged and no longer stored: it can =
never equal
  rel->packet_id, so its slot was held for the rest of the key =
state=2E Needs
  ~2^31 such packets; test_recv_filter_high_base's oracle sw=
itches to the new
  rule there, pinning behaviour rather than equivalence=
=2E
- The ASSERT in reliable_mark_active_incoming() is the receive window r=
ather
  than a half space, and runs before the entry is touched=2E Unobserv=
able: it
  repeats the check reliable_not_replay() makes immediately before=
 it=2E
- A send entry more than rel->size below rel->packet_id is ignored b=
y the
  scans instead of taken for a very old one, so
  reliable_get_num_ou=
tput_sequenced_available() can no longer go negative=2E
  reliable_get_buf_=
output_sequenced() keeps every distance within rel->size,
  so it never cou=
ld=2E

Change-Id: Iaaa0af7d678eb447bc93741add8120d9f348d9eb
Signed-off-by: =
Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn/reliable=2Ec
M sr=
c/openvpn/reliable=2Eh
M tests/unit_tests/openvpn/test_packet_id=2Ec
3 file=
s changed, 210 insertions(+), 94 deletions(-)



  git pull ssh://gerrit=2E=
openvpn=2Enet:29418/openvpn refs/changes/00/1900/1

diff --git a/src/openvp=
n/reliable=2Ec b/src/openvpn/reliable=2Ec
index ced438e=2E=2E6e10211 100644=

--- a/src/openvpn/reliable=2Ec
+++ b/src/openvpn/reliable=2Ec
@@ -50,46 +5=
0,12 @@
  * verify that test - base < extent while allowing for base or tes=
t wraparound
  */
 static inline bool
-reliable_pid_in_range1(const packet_=
id_type test, const packet_id_type base,
-                       const unsi=
gned int extent)
+reliable_pid_in_range(const packet_id_type test, const pa=
cket_id_type base,
+                      const unsigned int extent)
 {
   =
  return subtract_pid(test, base) < extent;
 }
 
-/*
- * verify that test <=
 base + extent while allowing for base or test wraparound
- */
-static inli=
ne bool
-reliable_pid_in_range2(const packet_id_type test, const packet_id_=
type base,
-                       const unsigned int extent)
-{
-    if (b=
ase + extent >=3D base)
-    {
-        if (test < base + extent)
-        =
{
-            return true;
-        }
-    }
-    else
-    {
-        if =
((test + 0x80000000u) < (base + 0x80000000u) + extent)
-        {
-        =
    return true;
-        }
-    }
-
-    return false;
-}
-
-/*
- * verify=
 that p1 < p2  while allowing for p1 or p2 wraparound
- */
-static inline b=
ool
-reliable_pid_min(const packet_id_type p1, const packet_id_type p2)
-{
=
-    return !reliable_pid_in_range1(p1, p2, 0x80000000u);
-}
-
 /* check if=
 a particular packet_id is present in ack */
 static inline bool
 reliable_=
ack_packet_id_present(struct reliable_ack *ack, packet_id_type pid)
@@ -393=
,8 +359,9 @@
 int
 validate_packet_id_window(struct reliable *rel, packet_i=
d_type pid)
 {
-    return reliable_pid_min(pid, rel->packet_id)
-         =
  && reliable_pid_min(subtract_pid(rel->packet_id, RELIABLE_CAPACITY), pid)=
;
+    const packet_id_type dist =3D subtract_pid(rel->packet_id, pid);
+
+=
    return dist > 0 && dist < RELIABLE_CAPACITY;
 }
 
 /* del acknowledged =
items from send buf */
@@ -440,14 +407,17 @@
                 e->active =3D=
 false;
             }
 
-            if (e->active && reliable_pid_min(e->=
packet_id, pid))
+            /* Order the two by their distance below rel-=
>packet_id, as
+             * comparing the ids directly misorders them ac=
ross the wrap=2E
+             * Entries further back than rel->size are ou=
tside the send window
+             * and left alone=2E An ACK for a higher=
 pid means this packet
+             * arrived out of order or was lost, an=
d enough of them trigger
+             * the early resend=2E */
+          =
  const packet_id_type e_dist =3D subtract_pid(rel->packet_id, e->packet_id=
);
+
+            if (e->active && e_dist <=3D (packet_id_type)rel->size
+ =
               && e_dist > subtract_pid(rel->packet_id, pid))
             =
{
-                /* We have received an ACK for a packet with a higher PI=
D=2E Either
-                 * we have received ACKs out of or order or th=
e packet has been
-                 * lost=2E We count the number of ACKs t=
o determine if we should
-                 * resend it early=2E The compari=
son needs to be wraparound aware,
-                 * otherwise a peer can =
inflate n_acks with an ACK for a pid from
-                 * the lower hal=
f of the id space and force a retransmit=2E */
                 e->n_acks++=
;
             }
         }
@@ -505,7 +475,9 @@
 reliable_not_replay(const =
struct reliable *rel, packet_id_type id)
 {
     struct gc_arena gc =3D gc_=
new();
-    if (reliable_pid_min(id, rel->packet_id))
+
+    /* outside the=
 receive window: already consumed, or too far ahead to store */
+    if (!r=
eliable_pid_in_range(id, rel->packet_id, rel->size))
     {
         goto b=
ad;
     }
@@ -531,7 +503,12 @@
 bool
 reliable_wont_break_sequentiality(co=
nst struct reliable *rel, packet_id_type id)
 {
-    const int ret =3D reli=
able_pid_in_range2(id, rel->packet_id, rel->size);
+    /* The first clause=
 is the receive window=2E The second is an absolute
+     * comparison, kep=
t so that already consumed ids still reach
+     * reliable_ack_acknowledge=
_packet_id() and a peer whose ACK was lost stops
+     * retransmitting; re=
liable_not_replay() rejects them=2E */
+    const bool ret =3D (subtract_pi=
d(id, rel->packet_id) < (packet_id_type)rel->size
+                      ||=
 id < rel->packet_id);
 
     if (!ret)
     {
@@ -562,57 +539,46 @@
     r=
eturn NULL;
 }
 
-int
-reliable_get_num_output_sequenced_available(struct r=
eliable *rel)
+/* Distance below rel->packet_id of the oldest unacknowledge=
d entry, 0 if there
+ * is none=2E Entries more than rel->size away are out=
side the sequencing window
+ * and ignored, rather than taken for very old =
ones=2E */
+static packet_id_type
+reliable_oldest_active_distance(const st=
ruct reliable *rel)
 {
-    packet_id_type min_id =3D 0;
-    bool min_id_d=
efined =3D false;
+    packet_id_type max_dist =3D 0;
 
-    /* find minimu=
m active packet_id */
     for (int i =3D 0; i < rel->size; ++i)
     {
   =
      const struct reliable_entry *e =3D &rel->array[i];
-        if (e->ac=
tive)
+        if (!e->active)
         {
-            if (!min_id_defined =
|| reliable_pid_min(e->packet_id, min_id))
-            {
-                =
min_id_defined =3D true;
-                min_id =3D e->packet_id;
-       =
     }
+            continue;
+        }
+
+        const packet_id_type di=
st =3D subtract_pid(rel->packet_id, e->packet_id);
+        if (dist <=3D (=
packet_id_type)rel->size && dist > max_dist)
+        {
+            max_di=
st =3D dist;
         }
     }
 
-    int ret =3D rel->size;
-    if (min_i=
d_defined)
-    {
-        ret -=3D subtract_pid(rel->packet_id, min_id);
-=
    }
-    return ret;
+    return max_dist;
+}
+
+int
+reliable_get_num_ou=
tput_sequenced_available(struct reliable *rel)
+{
+    return rel->size - (=
int)reliable_oldest_active_distance(rel);
 }
 
 /* grab a free buffer, fail=
 if buffer clogged by unacknowledged low packet IDs */
 struct buffer *
 re=
liable_get_buf_output_sequenced(struct reliable *rel)
 {
-    packet_id_typ=
e min_id =3D 0;
-    bool min_id_defined =3D false;
     struct buffer *ret=
 =3D NULL;
 
-    /* find minimum active packet_id */
-    for (int i =3D 0=
; i < rel->size; ++i)
-    {
-        const struct reliable_entry *e =3D &r=
el->array[i];
-        if (e->active)
-        {
-            if (!min_id_d=
efined || reliable_pid_min(e->packet_id, min_id))
-            {
-         =
       min_id_defined =3D true;
-                min_id =3D e->packet_id;
-=
            }
-        }
-    }
-
-    if (!min_id_defined || reliable_pid_=
in_range1(rel->packet_id, min_id, rel->size))
+    /* keep the next id with=
in rel->size of the oldest unacknowledged one */
+    if (reliable_oldest_a=
ctive_distance(rel) < (packet_id_type)rel->size)
     {
         ret =3D re=
liable_get_buf(rel);
     }
@@ -671,6 +637,8 @@
 reliable_send(struct relia=
ble *rel, int *opcode)
 {
     struct reliable_entry *best =3D NULL;
+    s=
truct reliable_entry *eligible =3D NULL;
+    packet_id_type best_dist =3D =
0;
     const time_t local_now =3D now;
 
     for (int i =3D 0; i < rel->s=
ize; ++i)
@@ -682,13 +650,29 @@
          * not expired yet=2E */
         =
if (e->active && (e->n_acks >=3D N_ACK_RETRANSMIT || local_now >=3D e->next=
_try))
         {
-            if (!best || reliable_pid_min(e->packet_id, =
best->packet_id))
+            /* oldest =3D furthest below rel->packet_id,=
 within the window */
+            const packet_id_type dist =3D subtract_p=
id(rel->packet_id, e->packet_id);
+            if (dist <=3D (packet_id_typ=
e)rel->size && dist > best_dist)
             {
                 best =3D e=
;
+                best_dist =3D dist;
+            }
+
+            if (!e=
ligible)
+            {
+                eligible =3D e;
             }
   =
      }
     }
 
+    /* reliable_can_send() promises a non-NULL result for=
 these same entries
+     * without applying the window bound, and its call=
er asserts on that, so
+     * never come back empty while one of them is e=
ligible=2E */
+    if (!best)
+    {
+        best =3D eligible;
+    }
+
 =
    if (best)
     {
         /* The initial timeout is bounded by RELIABLE=
_MAX_INITIAL_TIMEOUT, so
@@ -776,14 +760,14 @@
         struct reliable_ent=
ry *e =3D &rel->array[i];
         if (buf =3D=3D &e->buf)
         {
+    =
        /* storable and not yet consumed, checked before touching the entry=
 */
+            ASSERT(reliable_pid_in_range(pid, rel->packet_id, rel->siz=
e));
+
             e->active =3D true;
 
             /* packets may not a=
rrive in sequential order */
             e->packet_id =3D pid;
 
-        =
    /* check for replay */
-            ASSERT(!reliable_pid_min(pid, rel->=
packet_id));
-
             e->opcode =3D opcode;
             e->next_try =
=3D 0;
             e->timeout =3D 0;
diff --git a/src/openvpn/reliable=2Eh=
 b/src/openvpn/reliable=2Eh
index a85f2e9=2E=2E04f3372 100644
--- a/src/ope=
nvpn/reliable=2Eh
+++ b/src/openvpn/reliable=2Eh
@@ -288,15 +288,16 @@
 boo=
l reliable_can_get(const struct reliable *rel);
 
 /**
- * Check that a rec=
eived packet's ID is not a replay=2E
+ * Check that a received packet's ID =
is not a replay and is inside the receive
+ * window=2E
  *
  * @param rel =
The reliable structure for handling this VPN tunnel's
  *     received pack=
ets=2E
  * @param id The packet ID of the received packet=2E
  *
  * @retur=
n
- * @li True, if the packet ID is not a replay=2E
- * @li False, if the p=
acket ID is a replay=2E
+ * @li True, if the packet ID is new and inside th=
e receive window=2E
+ * @li False, if it is a replay, or too far ahead to b=
e stored=2E
  */
 bool reliable_not_replay(const struct reliable *rel, pack=
et_id_type id);
 
diff --git a/tests/unit_tests/openvpn/test_packet_id=2Ec =
b/tests/unit_tests/openvpn/test_packet_id=2Ec
index 9b62444=2E=2E7df74d9 10=
0644
--- a/tests/unit_tests/openvpn/test_packet_id=2Ec
+++ b/tests/unit_tes=
ts/openvpn/test_packet_id=2Ec
@@ -517,13 +517,16 @@
 }
 
 /*
- * Reference =
implementations of the packet id comparisons as they behave today=2E
- * Th=
e sweeps below assert reliable=2Ec agrees with them at the anchors swept, s=
o
- * a change to an accepted id set there fails a test=2E Keep them standa=
lone:
- * expressing them in terms of reliable=2Ec would make the sweeps ta=
utologies=2E
+ * Independent models of the id sets the packet id comparison=
s accept=2E The
+ * sweeps below assert reliable=2Ec agrees with them at th=
e anchors swept, so a
+ * change to an accepted id set there fails a test=
=2E Each model is tagged
+ * "preserved" or "introduced" against the compar=
isons that came before=2E Keep
+ * them standalone: expressing them in term=
s of reliable=2Ec would make the
+ * sweeps tautologies=2E
  */
 
-/* "p1 <=
 p2" with the 2^31 horizon, i=2Ee=2E ((int32_t)(p1 - p2) < 0) */
+/* the dr=
opped reliable_pid_min(): "p1 < p2" with the 2^31 horizon,
+ * i=2Ee=2E ((i=
nt32_t)(p1 - p2) < 0) */
 static bool
 ref_pid_min(packet_id_type p1, packe=
t_id_type p2)
 {
@@ -538,6 +541,7 @@
 #define CHAR_N_SEND_BUFFERS    6
 #de=
fine CHAR_OPCODE_CONTROL_V1 4
 
+/* preserved: the ids validate_packet_id_w=
indow() accepts */
 static bool
 ref_pid_in_send_window(const struct reliab=
le *rel, packet_id_type pid)
 {
@@ -546,6 +550,7 @@
     return dist >=3D 1=
 && dist <=3D CHARACTERIZED_SEND_WINDOW;
 }
 
+/* preserved: reliable_pid_i=
n_range2() */
 static bool
 ref_wont_break_sequentiality(const struct relia=
ble *rel, packet_id_type id)
 {
@@ -559,6 +564,7 @@
     return id < base +=
 extent;
 }
 
+/* preserved: the horizon check, then the slot scan */
 stat=
ic bool
 ref_not_replay(const struct reliable *rel, packet_id_type id)
 {
@=
@ -691,6 +697,54 @@
     }
 }
 
+/* Once rel->packet_id + rel->size overflo=
ws, the absolute clause makes
+ * reliable_wont_break_sequentiality() permi=
ssive; what may be stored is still
+ * the receive window, which wraps with=
 it=2E */
+static void
+test_recv_window_bounded_at_wrap(void **state)
+{
+=
    struct reliable rel =3D { 0 };
+    rel=2Esize =3D RELIABLE_CAPACITY;
+=
    rel=2Epacket_id =3D 0xFFFFFFF8;
+
+    assert_int_equal(RECV_STORE, rec=
v_filter(&rel, 0xFFFFFFF8));
+    assert_int_equal(RECV_STORE, recv_filter(=
&rel, 0xFFFFFFFF));
+    assert_int_equal(RECV_STORE, recv_filter(&rel, 3))=
;
+
+    /* one past the window, and one behind it: acknowledged, never sto=
red */
+    assert_int_equal(RECV_ACK_ONLY, recv_filter(&rel, 4));
+    ass=
ert_int_equal(RECV_ACK_ONLY, recv_filter(&rel, 0xFFFFFFF7));
+}
+
+/* The i=
d the receiver is next waiting for has to be storable at every base,
+ * th=
e packet id wrap included=2E */
+static void
+test_wont_break_sequentiality=
_accepts_next_id(void **state)
+{
+    const packet_id_type bases[] =3D {
+=
        0,
+        1,
+        500,
+        0x7FFFFFFF,
+        0x800000=
00,
+        0xFFFFFFF3,
+        0xFFFFFFF4,
+        0xFFFFFFF8,
+       =
 0xFFFFFFFE,
+        0xFFFFFFFF,
+    };
+
+    for (size_t i =3D 0; i < S=
IZE(bases); i++)
+    {
+        struct reliable rel =3D { 0 };
+        re=
l=2Esize =3D RELIABLE_CAPACITY;
+        rel=2Epacket_id =3D bases[i];
+
+ =
       assert_true(reliable_wont_break_sequentiality(&rel, rel=2Epacket_id)=
);
+        assert_true(reliable_not_replay(&rel, rel=2Epacket_id));
+    }=

+}
+
 /* bases at or below 2^31, where old and new agree; never to change =
*/
 static void
 test_recv_filter_characterization(void **state)
@@ -698,12=
 +752,31 @@
     sweep_recv_filter(char_anchors, SIZE(char_anchors), ref_re=
cv_filter);
 }
 
+/* Introduced, for the bases above 2^31 only: storing als=
o requires the id to
+ * be inside the receive window=2E The ids between on=
e further ahead and
+ * rel->packet_id cannot all fit alongside it, so rel-=
>packet_id never reaches
+ * it and the slot is held for the rest of the ke=
y state=2E Still ACKed, like a
+ * replay=2E */
+static enum recv_verdict
+=
ref_recv_filter_bounded(const struct reliable *rel, packet_id_type id)
+{
+=
    const enum recv_verdict verdict =3D ref_recv_filter(rel, id);
+
+    if=
 (verdict =3D=3D RECV_STORE
+        && (packet_id_type)(id - rel->packet_i=
d) >=3D (packet_id_type)rel->size)
+    {
+        return RECV_ACK_ONLY;
+ =
   }
+
+    return verdict;
+}
+
 /* bases above 2^31, where they diverge, =
kept apart so a change confined
  * there touches one test */
 static void
=
 test_recv_filter_high_base(void **state)
 {
-    sweep_recv_filter(char_an=
chors_high, SIZE(char_anchors_high), ref_recv_filter);
+    sweep_recv_filt=
er(char_anchors_high, SIZE(char_anchors_high), ref_recv_filter_bounded);
 }=

 
 static void
@@ -739,6 +812,60 @@
     sweep_send_window(char_anchors_hi=
gh, SIZE(char_anchors_high));
 }
 
+/* The window bound in the selection is=
 what stops an entry sitting ahead of
+ * rel->packet_id from being taken f=
or the oldest one: its distance below
+ * rel->packet_id is then nearly the=
 whole id space=2E array[0] cannot arise
+ * through the API; array[1] is a=
n ordinary outstanding packet=2E */
+static void
+test_reliable_send_ignore=
s_entry_ahead(void **state)
+{
+    now =3D 1000;
+
+    struct reliable re=
l =3D { 0 };
+    rel=2Esize =3D CHAR_N_SEND_BUFFERS;
+    rel=2Einitial_ti=
meout =3D 2;
+    rel=2Epacket_id =3D 3;
+
+    /* scanned first, and outsi=
de the window */
+    rel=2Earray[0]=2Eactive =3D true;
+    rel=2Earray[0]=
=2Epacket_id =3D 0x40000000;
+    rel=2Earray[0]=2Etimeout =3D 2;
+    rel=
=2Earray[0]=2Enext_try =3D 0;
+
+    /* a genuine outstanding packet, two b=
elow rel->packet_id */
+    rel=2Earray[1]=2Eactive =3D true;
+    rel=2Ear=
ray[1]=2Epacket_id =3D 1;
+    rel=2Earray[1]=2Etimeout =3D 2;
+    rel=2Ea=
rray[1]=2Enext_try =3D 0;
+
+    int opcode =3D 0;
+    assert_ptr_equal(&r=
el=2Earray[1]=2Ebuf, reliable_send(&rel, &opcode));
+}
+
+/* reliable_can_s=
end() promises reliable_send() will hand back a buffer, and
+ * its caller =
asserts on that=2E The state below cannot arise through the API --
+ * the =
entry sits outside the send window -- but the two must not be able to
+ * d=
isagree=2E */
+static void
+test_reliable_send_matches_can_send(void **stat=
e)
+{
+    now =3D 1000;
+
+    struct reliable rel =3D { 0 };
+    rel=2Es=
ize =3D CHAR_N_SEND_BUFFERS;
+    rel=2Einitial_timeout =3D 2;
+    rel=2Ep=
acket_id =3D 3;
+
+    rel=2Earray[0]=2Eactive =3D true;
+    rel=2Earray[0=
]=2Epacket_id =3D 0x40000000;
+    rel=2Earray[0]=2Etimeout =3D 2;
+    rel=
=2Earray[0]=2Enext_try =3D 0;
+
+    int opcode =3D 0;
+    assert_true(rel=
iable_can_send(&rel));
+    assert_non_null(reliable_send(&rel, &opcode));
=
+}
+
 /* reliable_send() picks the oldest eligible entry, across the wrap a=
nd the
  * signed midpoint */
 static void
@@ -865,10 +992,14 @@
         c=
mocka_unit_test(test_reliable_backoff_is_bounded),
         cmocka_unit_tes=
t(test_reliable_purge_ignores_forged_acks),
         cmocka_unit_test(test_=
reliable_purge_legitimate_ack),
+        cmocka_unit_test(test_wont_break_s=
equentiality_accepts_next_id),
+        cmocka_unit_test(test_recv_window_b=
ounded_at_wrap),
         cmocka_unit_test(test_recv_filter_characterizatio=
n),
         cmocka_unit_test(test_recv_filter_high_base),
         cmocka_=
unit_test(test_send_window_characterization),
         cmocka_unit_test(tes=
t_reliable_send_picks_oldest),
+        cmocka_unit_test(test_reliable_send=
_ignores_entry_ahead),
+        cmocka_unit_test(test_reliable_send_matches=
_can_send),
         cmocka_unit_test(test_get_buf_output_sequenced_boundar=
y),
         cmocka_unit_test(test_mark_active_incoming_rejects_past_ids)
 =


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1900?usp=3De=
mail
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit=
-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iaaa0af7d678eb447=
bc93741add8120d9f348d9eb
Gerrit-Change-Number: 1900
Gerrit-PatchSet: 1
Gerr=
it-Owner: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: plaisthos <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--SuHYjZazDfk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>razvanc would like plaisthos to =
<strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1900?usp=3Demail">View Change</a></p><pre class=3D"=
blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
reliable: drop the half-space packet id comparisons<br><br>Every comparison=
 becomes a modular distance against a stated bound=2E<br>subtract_pid() sta=
ys and reliable_pid_in_range1() loses its suffix;<br>reliable_pid_min() and=
 reliable_pid_in_range2() go, and with them the last<br>0x80000000 in the f=
ile=2E<br><br>The three scans for the oldest unacknowledged entry now track=
 the largest<br>distance below rel-&gt;packet_id, bounded by rel-&gt;size, =
in<br>reliable_oldest_active_distance()=2E reliable_wont_break_sequentialit=
y() bounds<br>the distance ahead and accepts past ids outright, as the old =
comparison did<br>without the 0x80000000 bias=2E<br><br>reliable_can_send()=
 counts the same entries without the window bound and its<br>caller asserts=
 on the result, so reliable_send() falls back to any eligible<br>entry when=
 the bound leaves nothing=2E<br><br>Equivalent for every reachable input=2E=
 Four deliberate differences:<br><br>- Once rel-&gt;packet_id + rel-&gt;siz=
e overflows, the absolute clause makes<br>  reliable_wont_break_sequentiali=
ty() permissive: ids the old bias branch<br>  rejected are acknowledged=2E =
Nothing more is stored, reliable_not_replay()<br>  still bounding that to t=
he receive window, which wraps with rel-&gt;packet_id=2E<br>  Needs ~2^32 c=
ontrol channel packets in one key state=2E<br>- Above 2^31, an id absolutel=
y below rel-&gt;packet_id + rel-&gt;size but more than<br>  rel-&gt;size ah=
ead is acknowledged and no longer stored: it can never equal<br>  rel-&gt;p=
acket_id, so its slot was held for the rest of the key state=2E Needs<br>  =
~2^31 such packets; test_recv_filter_high_base&#39;s oracle switches to the=
 new<br>  rule there, pinning behaviour rather than equivalence=2E<br>- The=
 ASSERT in reliable_mark_active_incoming() is the receive window rather<br>=
  than a half space, and runs before the entry is touched=2E Unobservable: =
it<br>  repeats the check reliable_not_replay() makes immediately before it=
=2E<br>- A send entry more than rel-&gt;size below rel-&gt;packet_id is ign=
ored by the<br>  scans instead of taken for a very old one, so<br>  reliabl=
e_get_num_output_sequenced_available() can no longer go negative=2E<br>  re=
liable_get_buf_output_sequenced() keeps every distance within rel-&gt;size,=
<br>  so it never could=2E<br><br>Change-Id: Iaaa0af7d678eb447bc93741add812=
0d9f348d9eb<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;=
<br>---<br>M src/openvpn/reliable=2Ec<br>M src/openvpn/reliable=2Eh<br>M te=
sts/unit_tests/openvpn/test_packet_id=2Ec<br>3 files changed, 210 insertion=
s(+), 94 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eop=
envpn=2Enet:29418/openvpn refs/changes/00/1900/1</pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/o=
penvpn/reliable=2Ec b/src/openvpn/reliable=2Ec</span><br><span>index ced438=
e=2E=2E6e10211 100644</span><br><span>--- a/src/openvpn/reliable=2Ec</span>=
<br><span>+++ b/src/openvpn/reliable=2Ec</span><br><span>@@ -50,46 +50,12 @=
@</span><br><span>  * verify that test - base &lt; extent while allowing fo=
r base or test wraparound</span><br><span>  */</span><br><span> static inli=
ne bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-reliable_pid_i=
n_range1(const packet_id_type test, const packet_id_type base,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                       const unsig=
ned int extent)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+reli=
able_pid_in_range(const packet_id_type test, const packet_id_type base,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                      c=
onst unsigned int extent)</span><br><span> {</span><br><span>     return su=
btract_pid(test, base) &lt; extent;</span><br><span> }</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * verify that test &lt; base + extent whil=
e allowing for base or test wraparound</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-s=
tatic inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-reli=
able_pid_in_range2(const packet_id_type test, const packet_id_type base,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                       c=
onst unsigned int extent)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (base + e=
xtent &gt;=3D base)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (test &=
lt; base + extent)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ret=
urn true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        if ((test + 0x80000000u) &lt; (base + 0x80000000u) + extent)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            return true;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    r=
eturn false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * verify that p1 &lt; p2  while allowing for p1 or p2 wraparound</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static inline bool</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-reliable_pid_min(const packet_id_type p1, cons=
t packet_id_type p2)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return !reliable_=
pid_in_range1(p1, p2, 0x80000000u);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span> /* check if a particular packet_id is present in ack */</span><=
br><span> static inline bool</span><br><span> reliable_ack_packet_id_presen=
t(struct reliable_ack *ack, packet_id_type pid)</span><br><span>@@ -393,8 +=
359,9 @@</span><br><span> int</span><br><span> validate_packet_id_window(st=
ruct reliable *rel, packet_id_type pid)</span><br><span> {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    return reliable_pid_min(pid, rel-&=
gt;packet_id)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
   &amp;&amp; reliable_pid_min(subtract_pid(rel-&gt;packet_id, RELIABLE_CAP=
ACITY), pid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst packet_id_type dist =3D subtract_pid(rel-&gt;packet_id, pid);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    return dist &gt; 0 &amp;&amp; dist &lt; RELI=
ABLE_CAPACITY;</span><br><span> }</span><br><span> </span><br><span> /* del=
 acknowledged items from send buf */</span><br><span>@@ -440,14 +407,17 @@<=
/span><br><span>                 e-&gt;active =3D false;</span><br><span>  =
           }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            if (e-&gt;active &amp;&amp; reliable_pid_min(e-&gt;pac=
ket_id, pid))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      /* Order the two by their distance below rel-&gt;packet_id, as</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+             * comparing t=
he ids directly misorders them across the wrap=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+             * Entries further back than rel-=
&gt;size are outside the send window</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+             * and left alone=2E An ACK for a higher pid m=
eans this packet</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
          * arrived out of order or was lost, and enough of them trigger</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+             * the ear=
ly resend=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        const packet_id_type e_dist =3D subtract_pid(rel-&gt;packet_id, e-&=
gt;packet_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (e-&gt;ac=
tive &amp;&amp; e_dist &lt;=3D (packet_id_type)rel-&gt;size</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                &amp;&amp; e_dist &=
gt; subtract_pid(rel-&gt;packet_id, pid))</span><br><span>             {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                /* We ha=
ve received an ACK for a packet with a higher PID=2E Either</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                 * we have received A=
CKs out of or order or the packet has been</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                 * lost=2E We count the number of ACKs=
 to determine if we should</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                 * resend it early=2E The comparison needs to be wrapa=
round aware,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
        * otherwise a peer can inflate n_acks with an ACK for a pid from</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                 * the l=
ower half of the id space and force a retransmit=2E */</span><br><span>    =
             e-&gt;n_acks++;</span><br><span>             }</span><br><span=
>         }</span><br><span>@@ -505,7 +475,9 @@</span><br><span> reliable_n=
ot_replay(const struct reliable *rel, packet_id_type id)</span><br><span> {=
</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    if (reliable_pid_min(id, rel-&gt;packe=
t_id))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* outside the receive windo=
w: already consumed, or too far ahead to store */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (!reliable_pid_in_range(id, rel-&gt;pa=
cket_id, rel-&gt;size))</span><br><span>     {</span><br><span>         got=
o bad;</span><br><span>     }</span><br><span>@@ -531,7 +503,12 @@</span><b=
r><span> bool</span><br><span> reliable_wont_break_sequentiality(const stru=
ct reliable *rel, packet_id_type id)</span><br><span> {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    const int ret =3D reliable_pid_in_ran=
ge2(id, rel-&gt;packet_id, rel-&gt;size);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* The first clause is the receive window=2E The =
second is an absolute</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     * comparison, kept so that already consumed ids still reach</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+     * reliable_ack_acknowle=
dge_packet_id() and a peer whose ACK was lost stops</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * retransmitting; reliable_not_repla=
y() rejects them=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    const bool ret =3D (subtract_pid(id, rel-&gt;packet_id) &lt; (packet=
_id_type)rel-&gt;size</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                      || id &lt; rel-&gt;packet_id);</span><br><span> </s=
pan><br><span>     if (!ret)</span><br><span>     {</span><br><span>@@ -562=
,57 +539,46 @@</span><br><span>     return NULL;</span><br><span> }</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-reliable_get_num_output_seque=
nced_available(struct reliable *rel)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/* Distance below rel-&gt;packet_id of the oldest unacknow=
ledged entry, 0 if there</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * is none=2E Entries more than rel-&gt;size away are outside the sequ=
encing window</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * and=
 ignored, rather than taken for very old ones=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static packet_id_type</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+reliable_oldest_active_distance(const s=
truct reliable *rel)</span><br><span> {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    packet_id_type min_id =3D 0;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    bool min_id_defined =3D false;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    packet_id_type max_dist =3D=
 0;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    /* find minimum active packet_id */</span><br><span>     for (int i =3D=
 0; i &lt; rel-&gt;size; ++i)</span><br><span>     {</span><br><span>      =
   const struct reliable_entry *e =3D &amp;rel-&gt;array[i];</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        if (e-&gt;active)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if (!e-&gt;active)</sp=
an><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            if (!min_id_defined || reliable_pid_min(e-&gt;packet_id, min_=
id))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                min_id_de=
fined =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
          min_id =3D e-&gt;packet_id;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            continue;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const pac=
ket_id_type dist =3D subtract_pid(rel-&gt;packet_id, e-&gt;packet_id);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (dist &lt;=3D=
 (packet_id_type)rel-&gt;size &amp;&amp; dist &gt; max_dist)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            max_dist =3D dist;</span><br><sp=
an>         }</span><br><span>     }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    int ret =3D rel-&gt;size;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    if (min_id_defined)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        ret -=3D subtract_pid(rel-&gt;packet_id,=
 min_id);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    return ret;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return max_dist;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+reliable_=
get_num_output_sequenced_available(struct reliable *rel)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    return rel-&gt;size - (int)reliable_oldest_active_di=
stance(rel);</span><br><span> }</span><br><span> </span><br><span> /* grab =
a free buffer, fail if buffer clogged by unacknowledged low packet IDs */</=
span><br><span> struct buffer *</span><br><span> reliable_get_buf_output_se=
quenced(struct reliable *rel)</span><br><span> {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    packet_id_type min_id =3D 0;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    bool min_id_defined =3D false;</s=
pan><br><span>     struct buffer *ret =3D NULL;</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    /* find minimum active pack=
et_id */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (int =
i =3D 0; i &lt; rel-&gt;size; ++i)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     const struct reliable_entry *e =3D &amp;rel-&gt;array[i];</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        if (e-&gt;active)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            if (!min_id_defined || reliabl=
e_pid_min(e-&gt;packet_id, min_id))</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                min_id_defined =3D true;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                min_id =3D e-&gt;packet_id;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!m=
in_id_defined || reliable_pid_in_range1(rel-&gt;packet_id, min_id, rel-&gt;=
size))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* keep t=
he next id within rel-&gt;size of the oldest unacknowledged one */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (reliable_oldest_acti=
ve_distance(rel) &lt; (packet_id_type)rel-&gt;size)</span><br><span>     {<=
/span><br><span>         ret =3D reliable_get_buf(rel);</span><br><span>   =
  }</span><br><span>@@ -671,6 +637,8 @@</span><br><span> reliable_send(stru=
ct reliable *rel, int *opcode)</span><br><span> {</span><br><span>     stru=
ct reliable_entry *best =3D NULL;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    struct reliable_entry *eligible =3D NULL;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    packet_id_type best_dist =3D 0;=
</span><br><span>     const time_t local_now =3D now;</span><br><span> </sp=
an><br><span>     for (int i =3D 0; i &lt; rel-&gt;size; ++i)</span><br><sp=
an>@@ -682,13 +650,29 @@</span><br><span>          * not expired yet=2E */<=
/span><br><span>         if (e-&gt;active &amp;&amp; (e-&gt;n_acks &gt;=3D =
N_ACK_RETRANSMIT || local_now &gt;=3D e-&gt;next_try))</span><br><span>    =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if =
(!best || reliable_pid_min(e-&gt;packet_id, best-&gt;packet_id))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            /* oldest =3D furt=
hest below rel-&gt;packet_id, within the window */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            const packet_id_type dist =3D su=
btract_pid(rel-&gt;packet_id, e-&gt;packet_id);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            if (dist &lt;=3D (packet_id_type)re=
l-&gt;size &amp;&amp; dist &gt; best_dist)</span><br><span>             {</=
span><br><span>                 best =3D e;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                best_dist =3D dist;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            if (!eligible)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                eligible =3D e;</span><br><span>           =
  }</span><br><span>         }</span><br><span>     }</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* reliable_can_sen=
d() promises a non-NULL result for these same entries</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * without applying the window bound,=
 and its caller asserts on that, so</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * never come back empty while one of them is eligible=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!best=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        best =3D eligible;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (best)</span><=
br><span>     {</span><br><span>         /* The initial timeout is bounded =
by RELIABLE_MAX_INITIAL_TIMEOUT, so</span><br><span>@@ -776,14 +760,14 @@</=
span><br><span>         struct reliable_entry *e =3D &amp;rel-&gt;array[i];=
</span><br><span>         if (buf =3D=3D &amp;e-&gt;buf)</span><br><span>  =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 /* storable and not yet consumed, checked before touching the entry */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            ASSERT(reli=
able_pid_in_range(pid, rel-&gt;packet_id, rel-&gt;size));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>             e-&gt;a=
ctive =3D true;</span><br><span> </span><br><span>             /* packets m=
ay not arrive in sequential order */</span><br><span>             e-&gt;pac=
ket_id =3D pid;</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            /* check for replay */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            ASSERT(!reliable_pid_min(pid, rel-&gt;=
packet_id));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span>             e-&gt;opcode =3D opcode;</span><br><span>             =
e-&gt;next_try =3D 0;</span><br><span>             e-&gt;timeout =3D 0;</sp=
an><br><span>diff --git a/src/openvpn/reliable=2Eh b/src/openvpn/reliable=
=2Eh</span><br><span>index a85f2e9=2E=2E04f3372 100644</span><br><span>--- =
a/src/openvpn/reliable=2Eh</span><br><span>+++ b/src/openvpn/reliable=2Eh</=
span><br><span>@@ -288,15 +288,16 @@</span><br><span> bool reliable_can_get=
(const struct reliable *rel);</span><br><span> </span><br><span> /**</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * Check that a received pac=
ket&#39;s ID is not a replay=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * Check that a received packet&#39;s ID is not a replay and is=
 inside the receive</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * window=2E</span><br><span>  *</span><br><span>  * @param rel The reliabl=
e structure for handling this VPN tunnel&#39;s</span><br><span>  *     rece=
ived packets=2E</span><br><span>  * @param id The packet ID of the received=
 packet=2E</span><br><span>  *</span><br><span>  * @return</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- * @li True, if the packet ID is not a=
 replay=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @li Fals=
e, if the packet ID is a replay=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * @li True, if the packet ID is new and inside the receive =
window=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @li Fal=
se, if it is a replay, or too far ahead to be stored=2E</span><br><span>  *=
/</span><br><span> bool reliable_not_replay(const struct reliable *rel, pac=
ket_id_type id);</span><br><span> </span><br><span>diff --git a/tests/unit_=
tests/openvpn/test_packet_id=2Ec b/tests/unit_tests/openvpn/test_packet_id=
=2Ec</span><br><span>index 9b62444=2E=2E7df74d9 100644</span><br><span>--- =
a/tests/unit_tests/openvpn/test_packet_id=2Ec</span><br><span>+++ b/tests/u=
nit_tests/openvpn/test_packet_id=2Ec</span><br><span>@@ -517,13 +517,16 @@<=
/span><br><span> }</span><br><span> </span><br><span> /*</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * Reference implementations of the pack=
et id comparisons as they behave today=2E</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- * The sweeps below assert reliable=2Ec agrees with the=
m at the anchors swept, so</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * a change to an accepted id set there fails a test=2E Keep them stan=
dalone:</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * expressing =
them in terms of reliable=2Ec would make the sweeps tautologies=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * Independent models of the=
 id sets the packet id comparisons accept=2E The</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * sweeps below assert reliable=2Ec agrees wit=
h them at the anchors swept, so a</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * change to an accepted id set there fails a test=2E Each mo=
del is tagged</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * &qu=
ot;preserved&quot; or &quot;introduced&quot; against the comparisons that c=
ame before=2E Keep</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* them standalone: expressing them in terms of reliable=2Ec would make the<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * sweeps tautologie=
s=2E</span><br><span>  */</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-/* &quot;p1 &lt; p2&quot; with the 2^31 horizon, i=2E=
e=2E ((int32_t)(p1 - p2) &lt; 0) */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/* the dropped reliable_pid_min(): &quot;p1 &lt; p2&quot; w=
ith the 2^31 horizon,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * i=2Ee=2E ((int32_t)(p1 - p2) &lt; 0) */</span><br><span> static bool</=
span><br><span> ref_pid_min(packet_id_type p1, packet_id_type p2)</span><br=
><span> {</span><br><span>@@ -538,6 +541,7 @@</span><br><span> #define CHAR=
_N_SEND_BUFFERS    6</span><br><span> #define CHAR_OPCODE_CONTROL_V1 4</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* pre=
served: the ids validate_packet_id_window() accepts */</span><br><span> sta=
tic bool</span><br><span> ref_pid_in_send_window(const struct reliable *rel=
, packet_id_type pid)</span><br><span> {</span><br><span>@@ -546,6 +550,7 @=
@</span><br><span>     return dist &gt;=3D 1 &amp;&amp; dist &lt;=3D CHARAC=
TERIZED_SEND_WINDOW;</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/* preserved: reliable_pid_in_range2(=
) */</span><br><span> static bool</span><br><span> ref_wont_break_sequentia=
lity(const struct reliable *rel, packet_id_type id)</span><br><span> {</spa=
n><br><span>@@ -559,6 +564,7 @@</span><br><span>     return id &lt; base + =
extent;</span><br><span> }</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/* preserved: the horizon check, then the slot sca=
n */</span><br><span> static bool</span><br><span> ref_not_replay(const str=
uct reliable *rel, packet_id_type id)</span><br><span> {</span><br><span>@@=
 -691,6 +697,54 @@</span><br><span>     }</span><br><span> }</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Once rel-&gt;=
packet_id + rel-&gt;size overflows, the absolute clause makes</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * reliable_wont_break_sequential=
ity() permissive; what may be stored is still</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * the receive window, which wraps with it=2E */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+test_recv_window_bounded_at_=
wrap(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct reliable=
 rel =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
rel=2Esize =3D RELIABLE_CAPACITY;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    rel=2Epacket_id =3D 0xFFFFFFF8;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_int_equal(RECV_STORE, recv_filter(&amp;rel, 0xFFFFFFF=
8));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_=
equal(RECV_STORE, recv_filter(&amp;rel, 0xFFFFFFFF));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(RECV_STORE, recv_fil=
ter(&amp;rel, 3));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* one past the =
window, and one behind it: acknowledged, never stored */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(RECV_ACK_ONLY, re=
cv_filter(&amp;rel, 4));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_int_equal(RECV_ACK_ONLY, recv_filter(&amp;rel, 0xFFFFFFF7))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/* The id the receiver is next waiting for has to be st=
orable at every base,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * the packet id wrap included=2E */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+test_wont_break_sequentiality_accepts_next_id(void **state)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const packet_id_type bases[] =3D {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        0,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        1,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        500,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        0x7FFFFFFF,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        0x80000000,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        0xFFFFFFF3,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        0xFFFFFFF4,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        0xFFFFFFF8,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        0xFFFFFFFE,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        0xFFFFFFFF,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
for (size_t i =3D 0; i &lt; SIZE(bases); i++)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        struct reliable rel =3D { 0 };</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        rel=2Esize =3D RELIABLE_CAPACITY;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        rel=2Epacket_i=
d =3D bases[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_true(rel=
iable_wont_break_sequentiality(&amp;rel, rel=2Epacket_id));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        assert_true(reliable_not_re=
play(&amp;rel, rel=2Epacket_id));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
/* bases at or below 2^31, where old and new agree; never to change */</spa=
n><br><span> static void</span><br><span> test_recv_filter_characterization=
(void **state)</span><br><span>@@ -698,12 +752,31 @@</span><br><span>     s=
weep_recv_filter(char_anchors, SIZE(char_anchors), ref_recv_filter);</span>=
<br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/* Introduced, for the bases above 2^31 only: storing also requi=
res the id to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * be =
inside the receive window=2E The ids between one further ahead and</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * rel-&gt;packet_id cannot =
all fit alongside it, so rel-&gt;packet_id never reaches</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * it and the slot is held for the res=
t of the key state=2E Still ACKed, like a</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * replay=2E */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static enum recv_verdict</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ref_recv_filter_bounded(const struct reliable *rel, =
packet_id_type id)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const enum recv=
_verdict verdict =3D ref_recv_filter(rel, id);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (verdict =3D=3D RECV_STORE</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        &amp;&amp; (packet_id_type)(id - rel-&gt;pack=
et_id) &gt;=3D (packet_id_type)rel-&gt;size)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        return RECV_ACK_ONLY;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return v=
erdict;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* bases abo=
ve 2^31, where they diverge, kept apart so a change confined</span><br><spa=
n>  * there touches one test */</span><br><span> static void</span><br><spa=
n> test_recv_filter_high_base(void **state)</span><br><span> {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    sweep_recv_filter(char_anchors=
_high, SIZE(char_anchors_high), ref_recv_filter);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    sweep_recv_filter(char_anchors_high, SIZE=
(char_anchors_high), ref_recv_filter_bounded);</span><br><span> }</span><br=
><span> </span><br><span> static void</span><br><span>@@ -739,6 +812,60 @@<=
/span><br><span>     sweep_send_window(char_anchors_high, SIZE(char_anchors=
_high));</span><br><span> }</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/* The window bound in the selection is what stop=
s an entry sitting ahead of</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * rel-&gt;packet_id from being taken for the oldest one: its dista=
nce below</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * rel-&gt=
;packet_id is then nearly the whole id space=2E array[0] cannot arise</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * through the API; array=
[1] is an ordinary outstanding packet=2E */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+test_reliable_send_ignores_entry_ahead(void **state)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    now =3D 1000;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct reliable rel =3D { 0 };</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    rel=2Esize =3D CHAR_N_SEND_BUFFERS;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    rel=2Einitial_timeout =3D =
2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rel=2Epacket_=
id =3D 3;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* scanned first, and out=
side the window */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   rel=2Earray[0]=2Eactive =3D true;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    rel=2Earray[0]=2Epacket_id =3D 0x40000000;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    rel=2Earray[0]=2Etimeout =
=3D 2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rel=2Earr=
ay[0]=2Enext_try =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* a genuin=
e outstanding packet, two below rel-&gt;packet_id */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    rel=2Earray[1]=2Eactive =3D true;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    rel=2Earray[1]=2Epa=
cket_id =3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
el=2Earray[1]=2Etimeout =3D 2;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    rel=2Earray[1]=2Enext_try =3D 0;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    int opcode =3D 0;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_ptr_equal(&amp;rel=2Earray[1]=2Ebuf, reliable_send(&a=
mp;rel, &amp;opcode));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/* reliable_can_send() promises re=
liable_send() will hand back a buffer, and</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * its caller asserts on that=2E The state below can=
not arise through the API --</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * the entry sits outside the send window -- but the two must not =
be able to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * disagr=
ee=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_reliable_send_=
matches_can_send(void **state)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    now=
 =3D 1000;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct reliable rel =3D =
{ 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rel=2Esiz=
e =3D CHAR_N_SEND_BUFFERS;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    rel=2Einitial_timeout =3D 2;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    rel=2Epacket_id =3D 3;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    rel=2Earray[0]=2Eactive =3D true;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    rel=2Earray[0]=2Epacket_id =3D 0x40000000;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    rel=2Earray[0]=2Et=
imeout =3D 2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
l=2Earray[0]=2Enext_try =3D 0;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int =
opcode =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_true(reliable_can_send(&amp;rel));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_non_null(reliable_send(&amp;rel, &amp;opcode=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* reliable_send=
() picks the oldest eligible entry, across the wrap and the</span><br><span=
>  * signed midpoint */</span><br><span> static void</span><br><span>@@ -86=
5,10 +992,14 @@</span><br><span>         cmocka_unit_test(test_reliable_bac=
koff_is_bounded),</span><br><span>         cmocka_unit_test(test_reliable_p=
urge_ignores_forged_acks),</span><br><span>         cmocka_unit_test(test_r=
eliable_purge_legitimate_ack),</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        cmocka_unit_test(test_wont_break_sequentiality_accepts_n=
ext_id),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmo=
cka_unit_test(test_recv_window_bounded_at_wrap),</span><br><span>         c=
mocka_unit_test(test_recv_filter_characterization),</span><br><span>       =
  cmocka_unit_test(test_recv_filter_high_base),</span><br><span>         cm=
ocka_unit_test(test_send_window_characterization),</span><br><span>        =
 cmocka_unit_test(test_reliable_send_picks_oldest),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_reliable_se=
nd_ignores_entry_ahead),</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        cmocka_unit_test(test_reliable_send_matches_can_send),</span><=
br><span>         cmocka_unit_test(test_get_buf_output_sequenced_boundary),=
</span><br><span>         cmocka_unit_test(test_mark_active_incoming_reject=
s_past_ids)</span><br><span> </span><br><span></span><br></pre><p>To view, =
visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1900?usp=3Demail=
">change 1900</a>=2E To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</=
a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><=
link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/190=
0?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div =
style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displa=
y:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-C=
hange-Id: Iaaa0af7d678eb447bc93741add8120d9f348d9eb </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Number: 1900 </div>
<div style=3D"display:none">=
 Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: razva=
nc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--SuHYjZazDfk=--


--===============5040544297771564177==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5040544297771564177==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5040544297771564177==--

