Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7719CA600B
	for <openvpn-devel@archiver.kernel.org>; Wed,  7 Oct 2026 20:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Dht0J+NXzs77pHF04t5HKkwBRLvRpibkM5SLjy+LQjk=; b=BUhDBS3/c1hi9D9wBOKN97XnaU
	vF5tukWJtk4/PYArQ01ItWJSabN0ikY2rXUGfkL+CVgD8dvq+WacGlizAbpZdcSeON1KoOT2o0rvH
	T0TBWRGEobgK3F1ccJcoaJZLCjjUGXGU7tjrdEQd3u/4XvLHvs1kTi6ggIZNk4LuaKW4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xEXtP-0008Iq-Gk;
	Wed, 07 Oct 2026 20:05:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xEXtN-0008Ia-RS
 for openvpn-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 20:05:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=J/0dAkaFCRAqS20u3xAkQn5B+o5Gmk/+7myU8K9AgPw=; b=SyzTR55qr6/6oq/nIOJeXqm/Wq
 C1rPtPWO7/qT2KzLV1T79wDnhQVFJpKhSzJaTeUnTNgYuOmVtKy+TPBzkw7GQKoLUr6eQ2PEBVwJY
 ITGRxZDZIuy0PD7HYU7nDTheZwIpwLl47nfH7Bm2Wz3H1reyYNdxRbWoKtlX/fpL+ZVI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=J/0dAkaFCRAqS20u3xAkQn5B+o5Gmk/+7myU8K9AgPw=; b=f
 lk5CjVixh7ItHTEAHYUoG8iVXzRuOFfMtdy99eZT+eDVfzdxzQ5NK4ATgLtiU530MCbXHd8F40ARk
 J8/Ucp6jvtcjIr5thnot7WBd8OoCCgr2URqnoJIqNxImZSJJbjhcJlt0tNPDBVhif5U0t54CMX8PU
 4MTuKx22AEBdLhfQ=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xEXtK-0004BD-RA for openvpn-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 20:05:34 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a166199820so92285e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 07 Oct 2026 13:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791403524; x=1792008324; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=J/0dAkaFCRAqS20u3xAkQn5B+o5Gmk/+7myU8K9AgPw=;
 b=XVOV6CffAarCnyreMaOE7i6kJR6lDjo32gY7J9L3+nzpZmJTELpK43e2oGbJ5zCF2C
 1TxznOnZZ7H8JtmCUvkIkPL5+PpjPYT6Chx1bUhm9/aiaRoKuUDTPa2zMMcBffDeb5rq
 3eLGaUJE5cf3ZCkgJ/AXRFID8YyZLSqmyH4h0gZYZj3glPXMEEvu3IqXZBQtSV/az1UG
 tKEiCI+6LCxCaXXKC+tTboLGG6hKbPLlCMHphqx1DDjGUQCcJ2dEg7o3kvn8yxByv4A+
 5LaaGLdJBhCiDYYYuZOhQF/kMujBCGmvYd5jm4aEcMJdXEmJxOpDhMWa/3cgdsXcHaF4
 MgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791403524; x=1792008324;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=J/0dAkaFCRAqS20u3xAkQn5B+o5Gmk/+7myU8K9AgPw=;
 b=idKeiSu+O+BO3G98CythAri5Qg66og59g3RNwhTTS2VCQlBpOBEhXZXqA5Rusa5f1w
 IKojS9uXzeOiCNn76VjMk3HMQdnSaTRc5U+k4Olm3lsKGuX+Wm4BatZ7KzBCIMKmKSU2
 Uqjz5SwaLxfDlMv+AkpIMZ6nEQRuWOLIAdR6xdgu+r1DeR+4exf37bzU2/uTxNmCexPv
 X4u1MP0XbNCnEDdvye8c0YBkTaEl/OVNi39b/Oy8S6yPgwihQqTyGZnaILBxfcgn6PTj
 J164XWtBUi/KAV7JTjP0gMIeIlr8fjRVxFOZQHLKUY4aMA43jwLjGgXnMOsfEDShg9sQ
 8/YA==
X-Gm-Message-State: AFuF++n1VBVtd18pgzblG+mHbp0+QEyA1dcWkqrarcKNs80nw7V0PWos
 NJhTGlEhvt/A3LfyGbdCD8WVcwylEsbQR243Byd1pMhv0G36yGezQjnm5MEoTEtXuK2CDGIacY0
 LnVl1t790lj/aind1c3OXAfI37vI/hdKATsEa3NT5iG+Sn5NyrMcnJJbL0emOn7eWEkX27l408X
 Wb5V/E2w==
X-Gm-Gg: AYBFou1AGEL3HivGDfwlzfAC8OtQqRqH22Xu0RTracACiE2M5r8bXa1clesKoP6kzHO
 WRfIHjQRMNceL0U+8h4jO9A4HjgDps9qo2MyWy/sCQL/LHuxbsMLQDoUR5h7jRBz5qZjvJ3s+Dn
 nuVI7f5B1xHxQ+rk1S1ZY8LCaJvOg3ZUaIvYMdDzmTFmyPbjVAluZAuQRV9twAJ/gPSwbs6QuQQ
 CvqR3JFjDOMbyyTMQRfNWSAISkuxQ79G1Vo/R0fjEXCJwzewMw4T4c+FYv2wLcyF98BeYBJxF26
 fnAAXhESOKgB1PyvS3wq86flAgo9s4WSq20N9A4bnv5oJGHhVqE6q4IWZYjtXdxii5v1WwJ6Z7h
 qtEAuqWcB2RT4kLqw9YPFNfM35ydEFcg5npp0HDo/3ojkoX7J+9BxOh2Dp02KS2kHojXw/cRYJk
 Zu1vyC8Rs8v/D0zCr0X8Z82FiMpzQWsnSLzZBFeldPZqNAJiBhmdOqLmngKK7TBbhuAfGtQ63W0
 Lz0wtzLFpV6KiBcz1+6lS6G0QxA9feAzId2SIYtTaNTfhHxzzb2ihDg2IM7aQvc09lWrWIuDL0Q
 VFklKZbS0NEqf2OIME3RrMkWphawfSDLLfYcCYTIK0vMYBs+XFB+TTT0snUJ
X-Received: by 2002:a05:600c:3d8f:b0:49e:6581:7baf with SMTP id
 5b1f17b1804b1-4a1851a3ebcmr5731895e9.2.1791403523938; 
 Wed, 07 Oct 2026 13:05:23 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1843e3356sm12432205e9.14.2026.10.07.13.05.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 13:05:22 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 7 Oct 2026 20:05:18 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Iaaa0af7d678eb447bc93741add8120d9f348d9eb
X-Gerrit-Change-Number: 1900
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1900?usp=email>
X-Gerrit-Commit: b3498ac23db3d94543a33fa766ccba64d10c1183
In-Reply-To: <gerrit.1788765781000.Iaaa0af7d678eb447bc93741add8120d9f348d9eb@gerrit.openvpn.net>
References: <gerrit.1788765781000.Iaaa0af7d678eb447bc93741add8120d9f348d9eb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NzY1NzgxMDAwLklhYWEwYWY3ZDY3OGViNDQ3YmM5Mzc0MWFkZDgxMjBkOWYzNDhkOWViQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ef277b47b1191208f75663e736d4c8996501b7af-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xEXtK-0004BD-RA
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0159490901426114274=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0159490901426114274==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="f5DipzXMEyY="; charset=UTF-8

--f5DipzXMEyY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: R=C4=83zvan Cojocaru=2E

Hello Arne S=
chwabe, 

I'd like you to reexamine a change=2E Please visit

    https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1900?usp=3Demail

to look at the new patc=
h set (#3)=2E

The change is no longer submittable: checks~ChecksSubmitRule=
 is unsatisfied now=2E


Change subject: reliable: drop the half-space pack=
et id comparisons
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

reliable: drop the half-space packet id comparisons

Every comparison =
becomes a modular distance against a stated bound=2E
subtract_pid() stays a=
nd reliable_pid_in_range1() loses its suffix;
reliable_pid_min() and reliab=
le_pid_in_range2() go, and with them the last
0x80000000 in the file=2E

Th=
e three scans for the oldest unacknowledged entry now track the largest
dis=
tance below rel->packet_id, bounded by rel->size, in
reliable_oldest_active=
_distance()=2E reliable_wont_break_sequentiality() bounds
the distance ahea=
d and accepts past ids outright, as the old comparison did
without the 0x80=
000000 bias=2E

reliable_can_send() counts the same entries without the win=
dow bound and its
caller asserts on the result, so reliable_send() falls ba=
ck to any eligible
entry when the bound leaves nothing=2E

Equivalent for e=
very reachable input=2E Four deliberate differences:

- Once rel->packet_id=
 + rel->size overflows, the absolute clause makes
  reliable_wont_break_seq=
uentiality() permissive: ids the old bias branch
  rejected are acknowledge=
d=2E Nothing more is stored, reliable_not_replay()
  still bounding that to=
 the receive window, which wraps with rel->packet_id=2E
  Needs ~2^32 contr=
ol channel packets in one key state=2E
- Above 2^31, an id absolutely below=
 rel->packet_id + rel->size but more than
  rel->size ahead is acknowledged=
 and no longer stored: it can never equal
  rel->packet_id, so its slot was=
 held for the rest of the key state=2E Needs
  ~2^31 such packets; test_rec=
v_filter_high_base's oracle switches to the new
  rule there, pinning behav=
iour rather than equivalence=2E
- The ASSERT in reliable_mark_active_incomi=
ng() is the receive window rather
  than a half space, and runs before the =
entry is touched=2E Unobservable: it
  repeats the check reliable_not_repla=
y() makes immediately before it=2E
- A send entry more than rel->size below=
 rel->packet_id is ignored by the
  scans instead of taken for a very old o=
ne, so
  reliable_get_num_output_sequenced_available() can no longer go neg=
ative=2E
  reliable_get_buf_output_sequenced() keeps every distance within =
rel->size,
  so it never could=2E

Change-Id: Iaaa0af7d678eb447bc93741add81=
20d9f348d9eb
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M s=
rc/openvpn/reliable=2Ec
M src/openvpn/reliable=2Eh
M tests/unit_tests/openv=
pn/test_packet_id=2Ec
3 files changed, 210 insertions(+), 94 deletions(-)

=

  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/00/1900=
/3

diff --git a/src/openvpn/reliable=2Ec b/src/openvpn/reliable=2Ec
index =
b5315ff=2E=2E645fbfd 100644
--- a/src/openvpn/reliable=2Ec
+++ b/src/openvp=
n/reliable=2Ec
@@ -50,46 +50,12 @@
  * verify that test - base < extent whi=
le allowing for base or test wraparound
  */
 static inline bool
-reliable_=
pid_in_range1(const packet_id_type test, const packet_id_type base,
-      =
                 const unsigned int extent)
+reliable_pid_in_range(const pa=
cket_id_type test, const packet_id_type base,
+                      const =
unsigned int extent)
 {
     return subtract_pid(test, base) < extent;
 }
 =

-/*
- * verify that test < base + extent while allowing for base or test w=
raparound
- */
-static inline bool
-reliable_pid_in_range2(const packet_id_=
type test, const packet_id_type base,
-                       const unsigne=
d int extent)
-{
-    if (base + extent >=3D base)
-    {
-        if (test=
 < base + extent)
-        {
-            return true;
-        }
-    }
- =
   else
-    {
-        if ((test + 0x80000000u) < (base + 0x80000000u) + e=
xtent)
-        {
-            return true;
-        }
-    }
-
-    return=
 false;
-}
-
-/*
- * verify that p1 < p2  while allowing for p1 or p2 wrapa=
round
- */
-static inline bool
-reliable_pid_min(const packet_id_type p1, c=
onst packet_id_type p2)
-{
-    return !reliable_pid_in_range1(p1, p2, 0x80=
000000u);
-}
-
 /* check if a particular packet_id is present in ack */
 st=
atic inline bool
 reliable_ack_packet_id_present(struct reliable_ack *ack, =
packet_id_type pid)
@@ -393,8 +359,9 @@
 int
 validate_packet_id_window(str=
uct reliable *rel, packet_id_type pid)
 {
-    return reliable_pid_min(pid,=
 rel->packet_id)
-           && reliable_pid_min(subtract_pid(rel->packet_i=
d, RELIABLE_CAPACITY), pid);
+    const packet_id_type dist =3D subtract_pi=
d(rel->packet_id, pid);
+
+    return dist > 0 && dist < RELIABLE_CAPACITY;=

 }
 
 /* del acknowledged items from send buf */
@@ -440,14 +407,17 @@
   =
              e->active =3D false;
             }
 
-            if (e->act=
ive && reliable_pid_min(e->packet_id, pid))
+            /* Order the two b=
y their distance below rel->packet_id, as
+             * comparing the ids=
 directly misorders them across the wrap=2E
+             * Entries further=
 back than rel->size are outside the send window
+             * and left a=
lone=2E An ACK for a higher pid means this packet
+             * arrived o=
ut of order or was lost, and enough of them trigger
+             * the ear=
ly resend=2E */
+            const packet_id_type e_dist =3D subtract_pid(r=
el->packet_id, e->packet_id);
+
+            if (e->active && e_dist <=3D (=
packet_id_type)rel->size
+                && e_dist > subtract_pid(rel->pac=
ket_id, pid))
             {
-                /* We have received an ACK fo=
r a packet with a higher PID=2E Either
-                 * we have received=
 ACKs out of or order or the packet has been
-                 * lost=2E We=
 count the number of ACKs to determine if we should
-                 * res=
end it early=2E The comparison needs to be wraparound aware,
-             =
    * otherwise a peer can inflate n_acks with an ACK for a pid from
-     =
            * the lower half of the id space and force a retransmit=2E */
 =
                e->n_acks++;
             }
         }
@@ -505,7 +475,9 @@
=
 reliable_not_replay(const struct reliable *rel, packet_id_type id)
 {
    =
 struct gc_arena gc =3D gc_new();
-    if (reliable_pid_min(id, rel->packet=
_id))
+
+    /* outside the receive window: already consumed, or too far ah=
ead to store */
+    if (!reliable_pid_in_range(id, rel->packet_id, rel->si=
ze))
     {
         goto bad;
     }
@@ -531,7 +503,12 @@
 bool
 reliable_=
wont_break_sequentiality(const struct reliable *rel, packet_id_type id)
 {
=
-    const int ret =3D reliable_pid_in_range2(id, rel->packet_id, rel->size=
);
+    /* The first clause is the receive window=2E The second is an absol=
ute
+     * comparison, kept so that already consumed ids still reach
+    =
 * reliable_ack_acknowledge_packet_id() and a peer whose ACK was lost stops=

+     * retransmitting; reliable_not_replay() rejects them=2E */
+    cons=
t bool ret =3D (subtract_pid(id, rel->packet_id) < (packet_id_type)rel->siz=
e
+                      || id < rel->packet_id);
 
     if (!ret)
     {
@=
@ -562,57 +539,46 @@
     return NULL;
 }
 
-int
-reliable_get_num_output_s=
equenced_available(struct reliable *rel)
+/* Distance below rel->packet_id =
of the oldest unacknowledged entry, 0 if there
+ * is none=2E Entries more =
than rel->size away are outside the sequencing window
+ * and ignored, rath=
er than taken for very old ones=2E */
+static packet_id_type
+reliable_olde=
st_active_distance(const struct reliable *rel)
 {
-    packet_id_type min_i=
d =3D 0;
-    bool min_id_defined =3D false;
+    packet_id_type max_dist =
=3D 0;
 
-    /* find minimum active packet_id */
     for (int i =3D 0; i =
< rel->size; ++i)
     {
         const struct reliable_entry *e =3D &rel->=
array[i];
-        if (e->active)
+        if (!e->active)
         {
-    =
        if (!min_id_defined || reliable_pid_min(e->packet_id, min_id))
-   =
         {
-                min_id_defined =3D true;
-                min_i=
d =3D e->packet_id;
-            }
+            continue;
+        }
+
+   =
     const packet_id_type dist =3D subtract_pid(rel->packet_id, e->packet_i=
d);
+        if (dist <=3D (packet_id_type)rel->size && dist > max_dist)
+ =
       {
+            max_dist =3D dist;
         }
     }
 
-    int ret =
=3D rel->size;
-    if (min_id_defined)
-    {
-        ret -=3D subtract_p=
id(rel->packet_id, min_id);
-    }
-    return ret;
+    return max_dist;
+=
}
+
+int
+reliable_get_num_output_sequenced_available(struct reliable *rel)=

+{
+    return rel->size - (int)reliable_oldest_active_distance(rel);
 }
 =

 /* grab a free buffer, fail if buffer clogged by unacknowledged low packe=
t IDs */
 struct buffer *
 reliable_get_buf_output_sequenced(struct reliabl=
e *rel)
 {
-    packet_id_type min_id =3D 0;
-    bool min_id_defined =3D f=
alse;
     struct buffer *ret =3D NULL;
 
-    /* find minimum active packe=
t_id */
-    for (int i =3D 0; i < rel->size; ++i)
-    {
-        const st=
ruct reliable_entry *e =3D &rel->array[i];
-        if (e->active)
-       =
 {
-            if (!min_id_defined || reliable_pid_min(e->packet_id, min_i=
d))
-            {
-                min_id_defined =3D true;
-             =
   min_id =3D e->packet_id;
-            }
-        }
-    }
-
-    if (!mi=
n_id_defined || reliable_pid_in_range1(rel->packet_id, min_id, rel->size))
=
+    /* keep the next id within rel->size of the oldest unacknowledged one =
*/
+    if (reliable_oldest_active_distance(rel) < (packet_id_type)rel->siz=
e)
     {
         ret =3D reliable_get_buf(rel);
     }
@@ -671,6 +637,8 @=
@
 reliable_send(struct reliable *rel, int *opcode)
 {
     struct reliable=
_entry *best =3D NULL;
+    struct reliable_entry *eligible =3D NULL;
+    =
packet_id_type best_dist =3D 0;
     const time_t local_now =3D now;
 
    =
 for (int i =3D 0; i < rel->size; ++i)
@@ -682,13 +650,29 @@
          * no=
t expired yet=2E */
         if (e->active && (e->n_acks >=3D N_ACK_RETRANS=
MIT || local_now >=3D e->next_try))
         {
-            if (!best || re=
liable_pid_min(e->packet_id, best->packet_id))
+            /* oldest =3D f=
urthest below rel->packet_id, within the window */
+            const packe=
t_id_type dist =3D subtract_pid(rel->packet_id, e->packet_id);
+           =
 if (dist <=3D (packet_id_type)rel->size && dist > best_dist)
             =
{
                 best =3D e;
+                best_dist =3D dist;
+      =
      }
+
+            if (!eligible)
+            {
+                eligi=
ble =3D e;
             }
         }
     }
 
+    /* reliable_can_send() p=
romises a non-NULL result for these same entries
+     * without applying t=
he window bound, and its caller asserts on that, so
+     * never come back=
 empty while one of them is eligible=2E */
+    if (!best)
+    {
+        =
best =3D eligible;
+    }
+
     if (best)
     {
         /* The initial t=
imeout is bounded by RELIABLE_MAX_INITIAL_TIMEOUT, so
@@ -776,14 +760,14 @@=

         struct reliable_entry *e =3D &rel->array[i];
         if (buf =3D=
=3D &e->buf)
         {
+            /* storable and not yet consumed, chec=
ked before touching the entry */
+            ASSERT(reliable_pid_in_range(=
pid, rel->packet_id, rel->size));
+
             e->active =3D true;
 
    =
         /* packets may not arrive in sequential order */
             e->p=
acket_id =3D pid;
 
-            /* check for replay */
-            ASSERT=
(!reliable_pid_min(pid, rel->packet_id));
-
             e->opcode =3D opco=
de;
             e->next_try =3D 0;
             e->timeout =3D 0;
diff --g=
it a/src/openvpn/reliable=2Eh b/src/openvpn/reliable=2Eh
index a85f2e9=2E=
=2E04f3372 100644
--- a/src/openvpn/reliable=2Eh
+++ b/src/openvpn/reliable=
=2Eh
@@ -288,15 +288,16 @@
 bool reliable_can_get(const struct reliable *re=
l);
 
 /**
- * Check that a received packet's ID is not a replay=2E
+ * Che=
ck that a received packet's ID is not a replay and is inside the receive
+ =
* window=2E
  *
  * @param rel The reliable structure for handling this VPN=
 tunnel's
  *     received packets=2E
  * @param id The packet ID of the re=
ceived packet=2E
  *
  * @return
- * @li True, if the packet ID is not a re=
play=2E
- * @li False, if the packet ID is a replay=2E
+ * @li True, if the=
 packet ID is new and inside the receive window=2E
+ * @li False, if it is =
a replay, or too far ahead to be stored=2E
  */
 bool reliable_not_replay(c=
onst struct reliable *rel, packet_id_type id);
 
diff --git a/tests/unit_te=
sts/openvpn/test_packet_id=2Ec b/tests/unit_tests/openvpn/test_packet_id=2E=
c
index aabb555=2E=2Eac6c710 100644
--- a/tests/unit_tests/openvpn/test_pac=
ket_id=2Ec
+++ b/tests/unit_tests/openvpn/test_packet_id=2Ec
@@ -517,13 +51=
7,16 @@
 }
 
 /*
- * Reference implementations of the packet id comparisons=
 as they behave today=2E
- * The sweeps below assert reliable=2Ec agrees wi=
th them at the anchors swept, so
- * a change to an accepted id set there f=
ails a test=2E Keep them standalone:
- * expressing them in terms of reliab=
le=2Ec would make the sweeps tautologies=2E
+ * Independent models of the i=
d sets the packet id comparisons accept=2E The
+ * sweeps below assert reli=
able=2Ec agrees with them at the anchors swept, so a
+ * change to an accep=
ted id set there fails a test=2E Each model is tagged
+ * "preserved" or "i=
ntroduced" against the comparisons that came before=2E Keep
+ * them standa=
lone: expressing them in terms of reliable=2Ec would make the
+ * sweeps ta=
utologies=2E
  */
 
-/* "p1 < p2" with the 2^31 horizon, i=2Ee=2E ((int32_t=
)(p1 - p2) < 0) */
+/* the dropped reliable_pid_min(): "p1 < p2" with the 2=
^31 horizon,
+ * i=2Ee=2E ((int32_t)(p1 - p2) < 0) */
 static bool
 ref_pid=
_min(packet_id_type p1, packet_id_type p2)
 {
@@ -538,6 +541,7 @@
 #define =
CHAR_N_SEND_BUFFERS    6
 #define CHAR_OPCODE_CONTROL_V1 4
 
+/* preserved:=
 the ids validate_packet_id_window() accepts */
 static bool
 ref_pid_in_se=
nd_window(const struct reliable *rel, packet_id_type pid)
 {
@@ -546,6 +550=
,7 @@
     return dist >=3D 1 && dist <=3D CHARACTERIZED_SEND_WINDOW;
 }
 
=
+/* preserved: reliable_pid_in_range2() */
 static bool
 ref_wont_break_seq=
uentiality(const struct reliable *rel, packet_id_type id)
 {
@@ -559,6 +564=
,7 @@
     return id < base + extent;
 }
 
+/* preserved: the horizon check=
, then the slot scan */
 static bool
 ref_not_replay(const struct reliable =
*rel, packet_id_type id)
 {
@@ -691,6 +697,54 @@
     }
 }
 
+/* Once rel->=
packet_id + rel->size overflows, the absolute clause makes
+ * reliable_won=
t_break_sequentiality() permissive; what may be stored is still
+ * the rec=
eive window, which wraps with it=2E */
+static void
+test_recv_window_bound=
ed_at_wrap(void **state)
+{
+    struct reliable rel =3D { 0 };
+    rel=2E=
size =3D RELIABLE_CAPACITY;
+    rel=2Epacket_id =3D 0xFFFFFFF8;
+
+    ass=
ert_int_equal(RECV_STORE, recv_filter(&rel, 0xFFFFFFF8));
+    assert_int_e=
qual(RECV_STORE, recv_filter(&rel, 0xFFFFFFFF));
+    assert_int_equal(RECV=
_STORE, recv_filter(&rel, 3));
+
+    /* one past the window, and one behin=
d it: acknowledged, never stored */
+    assert_int_equal(RECV_ACK_ONLY, re=
cv_filter(&rel, 4));
+    assert_int_equal(RECV_ACK_ONLY, recv_filter(&rel,=
 0xFFFFFFF7));
+}
+
+/* The id the receiver is next waiting for has to be s=
torable at every base,
+ * the packet id wrap included=2E */
+static void
+=
test_wont_break_sequentiality_accepts_next_id(void **state)
+{
+    const p=
acket_id_type bases[] =3D {
+        0,
+        1,
+        500,
+        =
0x7FFFFFFF,
+        0x80000000,
+        0xFFFFFFF3,
+        0xFFFFFFF4,
=
+        0xFFFFFFF8,
+        0xFFFFFFFE,
+        0xFFFFFFFF,
+    };
+
+ =
   for (size_t i =3D 0; i < SIZE(bases); i++)
+    {
+        struct reliab=
le rel =3D { 0 };
+        rel=2Esize =3D RELIABLE_CAPACITY;
+        rel=
=2Epacket_id =3D bases[i];
+
+        assert_true(reliable_wont_break_seque=
ntiality(&rel, rel=2Epacket_id));
+        assert_true(reliable_not_replay(=
&rel, rel=2Epacket_id));
+    }
+}
+
 /* bases at or below 2^31, where old =
and new agree; never to change */
 static void
 test_recv_filter_characteri=
zation(void **state)
@@ -698,12 +752,31 @@
     sweep_recv_filter(char_anch=
ors, SIZE(char_anchors), ref_recv_filter);
 }
 
+/* Introduced, for the bas=
es above 2^31 only: storing also requires the id to
+ * be inside the recei=
ve window=2E The ids between one further ahead and
+ * rel->packet_id canno=
t all fit alongside it, so rel->packet_id never reaches
+ * it and the slot=
 is held for the rest of the key state=2E Still ACKed, like a
+ * replay=2E=
 */
+static enum recv_verdict
+ref_recv_filter_bounded(const struct reliabl=
e *rel, packet_id_type id)
+{
+    const enum recv_verdict verdict =3D ref_=
recv_filter(rel, id);
+
+    if (verdict =3D=3D RECV_STORE
+        && (pac=
ket_id_type)(id - rel->packet_id) >=3D (packet_id_type)rel->size)
+    {
+ =
       return RECV_ACK_ONLY;
+    }
+
+    return verdict;
+}
+
 /* bases a=
bove 2^31, where they diverge, kept apart so a change confined
  * there to=
uches one test */
 static void
 test_recv_filter_high_base(void **state)
 {=

-    sweep_recv_filter(char_anchors_high, SIZE(char_anchors_high), ref_rec=
v_filter);
+    sweep_recv_filter(char_anchors_high, SIZE(char_anchors_high=
), ref_recv_filter_bounded);
 }
 
 static void
@@ -739,6 +812,60 @@
     sw=
eep_send_window(char_anchors_high, SIZE(char_anchors_high));
 }
 
+/* The w=
indow bound in the selection is what stops an entry sitting ahead of
+ * re=
l->packet_id from being taken for the oldest one: its distance below
+ * re=
l->packet_id is then nearly the whole id space=2E array[0] cannot arise
+ *=
 through the API; array[1] is an ordinary outstanding packet=2E */
+static =
void
+test_reliable_send_ignores_entry_ahead(void **state)
+{
+    now =3D =
1000;
+
+    struct reliable rel =3D { 0 };
+    rel=2Esize =3D CHAR_N_SEND=
_BUFFERS;
+    rel=2Einitial_timeout =3D 2;
+    rel=2Epacket_id =3D 3;
+
+=
    /* scanned first, and outside the window */
+    rel=2Earray[0]=2Eactiv=
e =3D true;
+    rel=2Earray[0]=2Epacket_id =3D 0x40000000;
+    rel=2Earra=
y[0]=2Etimeout =3D 2;
+    rel=2Earray[0]=2Enext_try =3D 0;
+
+    /* a gen=
uine outstanding packet, two below rel->packet_id */
+    rel=2Earray[1]=2E=
active =3D true;
+    rel=2Earray[1]=2Epacket_id =3D 1;
+    rel=2Earray[1]=
=2Etimeout =3D 2;
+    rel=2Earray[1]=2Enext_try =3D 0;
+
+    int opcode =
=3D 0;
+    assert_ptr_equal(&rel=2Earray[1]=2Ebuf, reliable_send(&rel, &op=
code));
+}
+
+/* reliable_can_send() promises reliable_send() will hand bac=
k a buffer, and
+ * its caller asserts on that=2E The state below cannot ar=
ise through the API --
+ * the entry sits outside the send window -- but th=
e two must not be able to
+ * disagree=2E */
+static void
+test_reliable_se=
nd_matches_can_send(void **state)
+{
+    now =3D 1000;
+
+    struct relia=
ble rel =3D { 0 };
+    rel=2Esize =3D CHAR_N_SEND_BUFFERS;
+    rel=2Einit=
ial_timeout =3D 2;
+    rel=2Epacket_id =3D 3;
+
+    rel=2Earray[0]=2Eacti=
ve =3D true;
+    rel=2Earray[0]=2Epacket_id =3D 0x40000000;
+    rel=2Earr=
ay[0]=2Etimeout =3D 2;
+    rel=2Earray[0]=2Enext_try =3D 0;
+
+    int opc=
ode =3D 0;
+    assert_true(reliable_can_send(&rel));
+    assert_non_null(=
reliable_send(&rel, &opcode));
+}
+
 /* reliable_send() picks the oldest el=
igible entry, across the wrap and the
  * signed midpoint */
 static void
@=
@ -880,10 +1007,14 @@
         cmocka_unit_test(test_reliable_backoff_is_bo=
unded),
         cmocka_unit_test(test_reliable_purge_ignores_forged_acks),=

         cmocka_unit_test(test_reliable_purge_legitimate_ack),
+        cm=
ocka_unit_test(test_wont_break_sequentiality_accepts_next_id),
+        cmo=
cka_unit_test(test_recv_window_bounded_at_wrap),
         cmocka_unit_test(=
test_recv_filter_characterization),
         cmocka_unit_test(test_recv_fil=
ter_high_base),
         cmocka_unit_test(test_send_window_characterization=
),
         cmocka_unit_test(test_reliable_send_picks_oldest),
+        cmo=
cka_unit_test(test_reliable_send_ignores_entry_ahead),
+        cmocka_unit=
_test(test_reliable_send_matches_can_send),
         cmocka_unit_test(test_=
get_buf_output_sequenced_boundary),
         cmocka_unit_test(test_mark_act=
ive_incoming_accepts_window),
 #ifndef _MSC_VER

-- 
To view, visit https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1900?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-=
Branch: master
Gerrit-Change-Id: Iaaa0af7d678eb447bc93741add8120d9f348d9eb
=
Gerrit-Change-Number: 1900
Gerrit-PatchSet: 3
Gerrit-Owner: R=C4=83zvan Coj=
ocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>

--f5DipzXMEyY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: R=C4=83zvan Cojocaru=2E </p>
<p>R=C4=83zvan Cojocaru =
<strong>uploaded patch set #3</strong> to this change=2E</p><p><a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1900?usp=3Demail">View Change</a>=
</p><p>The change is no longer submittable: checks~ChecksSubmitRule is unsa=
tisfied now=2E</p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">reliable: drop the half-space packet id com=
parisons<br><br>Every comparison becomes a modular distance against a state=
d bound=2E<br>subtract_pid() stays and reliable_pid_in_range1() loses its s=
uffix;<br>reliable_pid_min() and reliable_pid_in_range2() go, and with them=
 the last<br>0x80000000 in the file=2E<br><br>The three scans for the oldes=
t unacknowledged entry now track the largest<br>distance below rel-&gt;pack=
et_id, bounded by rel-&gt;size, in<br>reliable_oldest_active_distance()=2E =
reliable_wont_break_sequentiality() bounds<br>the distance ahead and accept=
s past ids outright, as the old comparison did<br>without the 0x80000000 bi=
as=2E<br><br>reliable_can_send() counts the same entries without the window=
 bound and its<br>caller asserts on the result, so reliable_send() falls ba=
ck to any eligible<br>entry when the bound leaves nothing=2E<br><br>Equival=
ent for every reachable input=2E Four deliberate differences:<br><br>- Once=
 rel-&gt;packet_id + rel-&gt;size overflows, the absolute clause makes<br> =
 reliable_wont_break_sequentiality() permissive: ids the old bias branch<br=
>  rejected are acknowledged=2E Nothing more is stored, reliable_not_replay=
()<br>  still bounding that to the receive window, which wraps with rel-&gt=
;packet_id=2E<br>  Needs ~2^32 control channel packets in one key state=2E<=
br>- Above 2^31, an id absolutely below rel-&gt;packet_id + rel-&gt;size bu=
t more than<br>  rel-&gt;size ahead is acknowledged and no longer stored: i=
t can never equal<br>  rel-&gt;packet_id, so its slot was held for the rest=
 of the key state=2E Needs<br>  ~2^31 such packets; test_recv_filter_high_b=
ase&#39;s oracle switches to the new<br>  rule there, pinning behaviour rat=
her than equivalence=2E<br>- The ASSERT in reliable_mark_active_incoming() =
is the receive window rather<br>  than a half space, and runs before the en=
try is touched=2E Unobservable: it<br>  repeats the check reliable_not_repl=
ay() makes immediately before it=2E<br>- A send entry more than rel-&gt;siz=
e below rel-&gt;packet_id is ignored by the<br>  scans instead of taken for=
 a very old one, so<br>  reliable_get_num_output_sequenced_available() can =
no longer go negative=2E<br>  reliable_get_buf_output_sequenced() keeps eve=
ry distance within rel-&gt;size,<br>  so it never could=2E<br><br>Change-Id=
: Iaaa0af7d678eb447bc93741add8120d9f348d9eb<br>Signed-off-by: Razvan Cojoca=
ru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/reliable=2Ec<br>M =
src/openvpn/reliable=2Eh<br>M tests/unit_tests/openvpn/test_packet_id=2Ec<b=
r>3 files changed, 210 insertions(+), 94 deletions(-)<br><br></pre><pre cla=
ss=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/00/1=
900/3</pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/src/openvpn/reliable=2Ec b/src/openvpn/reliable=
=2Ec</span><br><span>index b5315ff=2E=2E645fbfd 100644</span><br><span>--- =
a/src/openvpn/reliable=2Ec</span><br><span>+++ b/src/openvpn/reliable=2Ec</=
span><br><span>@@ -50,46 +50,12 @@</span><br><span>  * verify that test - b=
ase &lt; extent while allowing for base or test wraparound</span><br><span>=
  */</span><br><span> static inline bool</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-reliable_pid_in_range1(const packet_id_type test, const =
packet_id_type base,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                      const unsigned int extent)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+reliable_pid_in_range(const packet_id_type tes=
t, const packet_id_type base,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                      const unsigned int extent)</span><br><span>=
 {</span><br><span>     return subtract_pid(test, base) &lt; extent;</span>=
<br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * verify =
that test &lt; base + extent while allowing for base or test wraparound</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static inline bool</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-reliable_pid_in_range2(const packet_id_type te=
st, const packet_id_type base,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                       const unsigned int extent)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    if (base + extent &gt;=3D base)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        if (test &lt; base + extent)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            return true;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    e=
lse</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        if ((test + 0x80000000u) &=
lt; (base + 0x80000000u) + extent)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            return true;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return false;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- * verify that p1 &lt; p2  while=
 allowing for p1 or p2 wraparound</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static=
 inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-reliable_=
pid_min(const packet_id_type p1, const packet_id_type p2)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    return !reliable_pid_in_range1(p1, p2, 0x80000000u);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /* check if a particular =
packet_id is present in ack */</span><br><span> static inline bool</span><b=
r><span> reliable_ack_packet_id_present(struct reliable_ack *ack, packet_id=
_type pid)</span><br><span>@@ -393,8 +359,9 @@</span><br><span> int</span><=
br><span> validate_packet_id_window(struct reliable *rel, packet_id_type pi=
d)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    return reliable_pid_min(pid, rel-&gt;packet_id)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-           &amp;&amp; reliable_pid_min(subt=
ract_pid(rel-&gt;packet_id, RELIABLE_CAPACITY), pid);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const packet_id_type dist =3D subtrac=
t_pid(rel-&gt;packet_id, pid);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retu=
rn dist &gt; 0 &amp;&amp; dist &lt; RELIABLE_CAPACITY;</span><br><span> }</=
span><br><span> </span><br><span> /* del acknowledged items from send buf *=
/</span><br><span>@@ -440,14 +407,17 @@</span><br><span>                 e-=
&gt;active =3D false;</span><br><span>             }</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (e-&gt;acti=
ve &amp;&amp; reliable_pid_min(e-&gt;packet_id, pid))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            /* Order the two by their dis=
tance below rel-&gt;packet_id, as</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+             * comparing the ids directly misorders them acro=
ss the wrap=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
        * Entries further back than rel-&gt;size are outside the send windo=
w</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             * and=
 left alone=2E An ACK for a higher pid means this packet</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+             * arrived out of order or=
 was lost, and enough of them trigger</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+             * the early resend=2E */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            const packet_id_type e_dist=
 =3D subtract_pid(rel-&gt;packet_id, e-&gt;packet_id);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            if (e-&gt;active &amp;&amp; e_dist &lt;=3D (pac=
ket_id_type)rel-&gt;size</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                &amp;&amp; e_dist &gt; subtract_pid(rel-&gt;packet_id,=
 pid))</span><br><span>             {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                /* We have received an ACK for a packet wit=
h a higher PID=2E Either</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                 * we have received ACKs out of or order or the packet h=
as been</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
   * lost=2E We count the number of ACKs to determine if we should</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                 * resend it e=
arly=2E The comparison needs to be wraparound aware,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                 * otherwise a peer can inf=
late n_acks with an ACK for a pid from</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                 * the lower half of the id space and forc=
e a retransmit=2E */</span><br><span>                 e-&gt;n_acks++;</span=
><br><span>             }</span><br><span>         }</span><br><span>@@ -50=
5,7 +475,9 @@</span><br><span> reliable_not_replay(const struct reliable *r=
el, packet_id_type id)</span><br><span> {</span><br><span>     struct gc_ar=
ena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (reliable_pid_min(id, rel-&gt;packet_id))</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* outside the receive window: already consumed, or too far ah=
ead to store */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (!reliable_pid_in_range(id, rel-&gt;packet_id, rel-&gt;size))</span><br>=
<span>     {</span><br><span>         goto bad;</span><br><span>     }</spa=
n><br><span>@@ -531,7 +503,12 @@</span><br><span> bool</span><br><span> rel=
iable_wont_break_sequentiality(const struct reliable *rel, packet_id_type i=
d)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    const int ret =3D reliable_pid_in_range2(id, rel-&gt;packet_id, rel-&gt=
;size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* The f=
irst clause is the receive window=2E The second is an absolute</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     * comparison, kept so that =
already consumed ids still reach</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+     * reliable_ack_acknowledge_packet_id() and a peer whose A=
CK was lost stops</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   * retransmitting; reliable_not_replay() rejects them=2E */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    const bool ret =3D (subtract_=
pid(id, rel-&gt;packet_id) &lt; (packet_id_type)rel-&gt;size</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                      || id &lt; r=
el-&gt;packet_id);</span><br><span> </span><br><span>     if (!ret)</span><=
br><span>     {</span><br><span>@@ -562,57 +539,46 @@</span><br><span>     =
return NULL;</span><br><span> }</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-reliable_get_num_output_sequenced_available(struct reliable *rel)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Distance below r=
el-&gt;packet_id of the oldest unacknowledged entry, 0 if there</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * is none=2E Entries more than=
 rel-&gt;size away are outside the sequencing window</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * and ignored, rather than taken for ver=
y old ones=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic packet_id_type</span><br><span style=3D"color: hsl(120, 100%, 40%);">+r=
eliable_oldest_active_distance(const struct reliable *rel)</span><br><span>=
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    packet_id_type =
min_id =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool=
 min_id_defined =3D false;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    packet_id_type max_dist =3D 0;</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    /* find minimum active packet_id =
*/</span><br><span>     for (int i =3D 0; i &lt; rel-&gt;size; ++i)</span><=
br><span>     {</span><br><span>         const struct reliable_entry *e =3D=
 &amp;rel-&gt;array[i];</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        if (e-&gt;active)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if (!e-&gt;active)</span><br><span>         {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            if (!min_id_defined || =
reliable_pid_min(e-&gt;packet_id, min_id))</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                min_id_defined =3D true;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                min_id =3D e-&gt;packet_id;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            continue;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        const packet_id_type dist =3D subtract_pid(rel=
-&gt;packet_id, e-&gt;packet_id);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        if (dist &lt;=3D (packet_id_type)rel-&gt;size &amp;&a=
mp; dist &gt; max_dist)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      max_dist =3D dist;</span><br><span>         }</span><br><span>     }<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
int ret =3D rel-&gt;size;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    if (min_id_defined)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        re=
t -=3D subtract_pid(rel-&gt;packet_id, min_id);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    return ret;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return max_dist;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+reliable_get_num_output_sequenced_available(st=
ruct reliable *rel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return rel-&gt=
;size - (int)reliable_oldest_active_distance(rel);</span><br><span> }</span=
><br><span> </span><br><span> /* grab a free buffer, fail if buffer clogged=
 by unacknowledged low packet IDs */</span><br><span> struct buffer *</span=
><br><span> reliable_get_buf_output_sequenced(struct reliable *rel)</span><=
br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    packet=
_id_type min_id =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    bool min_id_defined =3D false;</span><br><span>     struct buffer *ret=
 =3D NULL;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    /* find minimum active packet_id */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    for (int i =3D 0; i &lt; rel-&gt;size; ++i)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        const struct reliable_entry *e =
=3D &amp;rel-&gt;array[i];</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        if (e-&gt;active)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         if (!min_id_defined || reliable_pid_min(e-&gt;packet_id, min_id))<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                min_id_defined=
 =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
     min_id =3D e-&gt;packet_id;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (!min_id_defined || reliable_pid_in_ran=
ge1(rel-&gt;packet_id, min_id, rel-&gt;size))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* keep the next id within rel-&gt;size of th=
e oldest unacknowledged one */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (reliable_oldest_active_distance(rel) &lt; (packet_id_typ=
e)rel-&gt;size)</span><br><span>     {</span><br><span>         ret =3D rel=
iable_get_buf(rel);</span><br><span>     }</span><br><span>@@ -671,6 +637,8=
 @@</span><br><span> reliable_send(struct reliable *rel, int *opcode)</span=
><br><span> {</span><br><span>     struct reliable_entry *best =3D NULL;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct reliable_en=
try *eligible =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    packet_id_type best_dist =3D 0;</span><br><span>     const time_t l=
ocal_now =3D now;</span><br><span> </span><br><span>     for (int i =3D 0; =
i &lt; rel-&gt;size; ++i)</span><br><span>@@ -682,13 +650,29 @@</span><br><=
span>          * not expired yet=2E */</span><br><span>         if (e-&gt;a=
ctive &amp;&amp; (e-&gt;n_acks &gt;=3D N_ACK_RETRANSMIT || local_now &gt;=
=3D e-&gt;next_try))</span><br><span>         {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            if (!best || reliable_pid_min(e-&gt;p=
acket_id, best-&gt;packet_id))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            /* oldest =3D furthest below rel-&gt;packet_id, with=
in the window */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         const packet_id_type dist =3D subtract_pid(rel-&gt;packet_id, e-&g=
t;packet_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      if (dist &lt;=3D (packet_id_type)rel-&gt;size &amp;&amp; dist &gt; be=
st_dist)</span><br><span>             {</span><br><span>                 be=
st =3D e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      best_dist =3D dist;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!el=
igible)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                el=
igible =3D e;</span><br><span>             }</span><br><span>         }</sp=
an><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* reliable_can_send() promises a non-NULL result for=
 these same entries</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     * without applying the window bound, and its caller asserts on that, s=
o</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * never come =
back empty while one of them is eligible=2E */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (!best)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        best =3D eligible;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span>     if (best)</span><br><span>     {</span><br><span>   =
      /* The initial timeout is bounded by RELIABLE_MAX_INITIAL_TIMEOUT, so=
</span><br><span>@@ -776,14 +760,14 @@</span><br><span>         struct reli=
able_entry *e =3D &amp;rel-&gt;array[i];</span><br><span>         if (buf =
=3D=3D &amp;e-&gt;buf)</span><br><span>         {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            /* storable and not yet consumed,=
 checked before touching the entry */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            ASSERT(reliable_pid_in_range(pid, rel-&gt;pac=
ket_id, rel-&gt;size));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span>             e-&gt;active =3D true;</span><br><span> <=
/span><br><span>             /* packets may not arrive in sequential order =
*/</span><br><span>             e-&gt;packet_id =3D pid;</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* check f=
or replay */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   ASSERT(!reliable_pid_min(pid, rel-&gt;packet_id));</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span>             e-&gt;opcode =
=3D opcode;</span><br><span>             e-&gt;next_try =3D 0;</span><br><s=
pan>             e-&gt;timeout =3D 0;</span><br><span>diff --git a/src/open=
vpn/reliable=2Eh b/src/openvpn/reliable=2Eh</span><br><span>index a85f2e9=
=2E=2E04f3372 100644</span><br><span>--- a/src/openvpn/reliable=2Eh</span><=
br><span>+++ b/src/openvpn/reliable=2Eh</span><br><span>@@ -288,15 +288,16 =
@@</span><br><span> bool reliable_can_get(const struct reliable *rel);</spa=
n><br><span> </span><br><span> /**</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * Check that a received packet&#39;s ID is not a replay=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Check that a receiv=
ed packet&#39;s ID is not a replay and is inside the receive</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * window=2E</span><br><span>  *</=
span><br><span>  * @param rel The reliable structure for handling this VPN =
tunnel&#39;s</span><br><span>  *     received packets=2E</span><br><span>  =
* @param id The packet ID of the received packet=2E</span><br><span>  *</sp=
an><br><span>  * @return</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * @li True, if the packet ID is not a replay=2E</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * @li False, if the packet ID is a replay=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @li True, if =
the packet ID is new and inside the receive window=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @li False, if it is a replay, or too f=
ar ahead to be stored=2E</span><br><span>  */</span><br><span> bool reliabl=
e_not_replay(const struct reliable *rel, packet_id_type id);</span><br><spa=
n> </span><br><span>diff --git a/tests/unit_tests/openvpn/test_packet_id=2E=
c b/tests/unit_tests/openvpn/test_packet_id=2Ec</span><br><span>index aabb5=
55=2E=2Eac6c710 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_=
packet_id=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_packet_id=
=2Ec</span><br><span>@@ -517,13 +517,16 @@</span><br><span> }</span><br><sp=
an> </span><br><span> /*</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * Reference implementations of the packet id comparisons as they behave=
 today=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * The sweep=
s below assert reliable=2Ec agrees with them at the anchors swept, so</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- * a change to an accepted =
id set there fails a test=2E Keep them standalone:</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * expressing them in terms of reliable=2Ec wo=
uld make the sweeps tautologies=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * Independent models of the id sets the packet id compariso=
ns accept=2E The</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
sweeps below assert reliable=2Ec agrees with them at the anchors swept, so =
a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * change to an ac=
cepted id set there fails a test=2E Each model is tagged</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * &quot;preserved&quot; or &quot;intr=
oduced&quot; against the comparisons that came before=2E Keep</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * them standalone: expressing th=
em in terms of reliable=2Ec would make the</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * sweeps tautologies=2E</span><br><span>  */</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* &quot;p=
1 &lt; p2&quot; with the 2^31 horizon, i=2Ee=2E ((int32_t)(p1 - p2) &lt; 0)=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* the dropped r=
eliable_pid_min(): &quot;p1 &lt; p2&quot; with the 2^31 horizon,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * i=2Ee=2E ((int32_t)(p1 - p2=
) &lt; 0) */</span><br><span> static bool</span><br><span> ref_pid_min(pack=
et_id_type p1, packet_id_type p2)</span><br><span> {</span><br><span>@@ -53=
8,6 +541,7 @@</span><br><span> #define CHAR_N_SEND_BUFFERS    6</span><br><=
span> #define CHAR_OPCODE_CONTROL_V1 4</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/* preserved: the ids validate_packet_=
id_window() accepts */</span><br><span> static bool</span><br><span> ref_pi=
d_in_send_window(const struct reliable *rel, packet_id_type pid)</span><br>=
<span> {</span><br><span>@@ -546,6 +550,7 @@</span><br><span>     return di=
st &gt;=3D 1 &amp;&amp; dist &lt;=3D CHARACTERIZED_SEND_WINDOW;</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+/* preserved: reliable_pid_in_range2() */</span><br><span> static boo=
l</span><br><span> ref_wont_break_sequentiality(const struct reliable *rel,=
 packet_id_type id)</span><br><span> {</span><br><span>@@ -559,6 +564,7 @@<=
/span><br><span>     return id &lt; base + extent;</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* pres=
erved: the horizon check, then the slot scan */</span><br><span> static boo=
l</span><br><span> ref_not_replay(const struct reliable *rel, packet_id_typ=
e id)</span><br><span> {</span><br><span>@@ -691,6 +697,54 @@</span><br><sp=
an>     }</span><br><span> }</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/* Once rel-&gt;packet_id + rel-&gt;size overflo=
ws, the absolute clause makes</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * reliable_wont_break_sequentiality() permissive; what may be st=
ored is still</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the=
 receive window, which wraps with it=2E */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+test_recv_window_bounded_at_wrap(void **state)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct reliable rel =3D { 0 };</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    rel=2Esize =3D RELIABLE_CAPACITY=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rel=2Epacket_i=
d =3D 0xFFFFFFF8;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(=
RECV_STORE, recv_filter(&amp;rel, 0xFFFFFFF8));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_int_equal(RECV_STORE, recv_filter(&a=
mp;rel, 0xFFFFFFFF));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_int_equal(RECV_STORE, recv_filter(&amp;rel, 3));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* one past the window, and one behind it: ackno=
wledged, never stored */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_int_equal(RECV_ACK_ONLY, recv_filter(&amp;rel, 4));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(RECV_A=
CK_ONLY, recv_filter(&amp;rel, 0xFFFFFFF7));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* The id th=
e receiver is next waiting for has to be storable at every base,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * the packet id wrap included=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_wont_break_seque=
ntiality_accepts_next_id(void **state)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const packet_id_type bases[] =3D {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        0,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        1,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        500,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   0x7FFFFFFF,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   0x80000000,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   0xFFFFFFF3,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   0xFFFFFFF4,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   0xFFFFFFF8,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   0xFFFFFFFE,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   0xFFFFFFFF,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; SIZE(=
bases); i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct reliab=
le rel =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      rel=2Esize =3D RELIABLE_CAPACITY;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        rel=2Epacket_id =3D bases[i];</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        assert_true(reliable_wont_break_sequentiality(&a=
mp;rel, rel=2Epacket_id));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        assert_true(reliable_not_replay(&amp;rel, rel=2Epacket_id));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> /* bases at or below 2^31, where =
old and new agree; never to change */</span><br><span> static void</span><b=
r><span> test_recv_filter_characterization(void **state)</span><br><span>@@=
 -698,12 +752,31 @@</span><br><span>     sweep_recv_filter(char_anchors, SI=
ZE(char_anchors), ref_recv_filter);</span><br><span> }</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Introduced, for the=
 bases above 2^31 only: storing also requires the id to</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * be inside the receive window=2E The =
ids between one further ahead and</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * rel-&gt;packet_id cannot all fit alongside it, so rel-&gt;=
packet_id never reaches</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * it and the slot is held for the rest of the key state=2E Still ACKed=
, like a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * replay=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static enum r=
ecv_verdict</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ref_recv=
_filter_bounded(const struct reliable *rel, packet_id_type id)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    const enum recv_verdict verdict =3D ref_recv_f=
ilter(rel, id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (verdict =3D=3D =
RECV_STORE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &=
amp;&amp; (packet_id_type)(id - rel-&gt;packet_id) &gt;=3D (packet_id_type)=
rel-&gt;size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return RECV_=
ACK_ONLY;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return verdict;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> /* bases above 2^31, where they diverge, =
kept apart so a change confined</span><br><span>  * there touches one test =
*/</span><br><span> static void</span><br><span> test_recv_filter_high_base=
(void **state)</span><br><span> {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    sweep_recv_filter(char_anchors_high, SIZE(char_anchors_high=
), ref_recv_filter);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    sweep_recv_filter(char_anchors_high, SIZE(char_anchors_high), ref_recv=
_filter_bounded);</span><br><span> }</span><br><span> </span><br><span> sta=
tic void</span><br><span>@@ -739,6 +812,60 @@</span><br><span>     sweep_se=
nd_window(char_anchors_high, SIZE(char_anchors_high));</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* =
The window bound in the selection is what stops an entry sitting ahead of</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * rel-&gt;packet_id =
from being taken for the oldest one: its distance below</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * rel-&gt;packet_id is then nearly the=
 whole id space=2E array[0] cannot arise</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * through the API; array[1] is an ordinary outstandin=
g packet=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stati=
c void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_reliable=
_send_ignores_entry_ahead(void **state)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    now =3D 1000;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct reliable=
 rel =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
rel=2Esize =3D CHAR_N_SEND_BUFFERS;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    rel=2Einitial_timeout =3D 2;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    rel=2Epacket_id =3D 3;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* scanned first, and outside the window */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    rel=2Earray[0]=2Eactive =
=3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rel=2E=
array[0]=2Epacket_id =3D 0x40000000;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    rel=2Earray[0]=2Etimeout =3D 2;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    rel=2Earray[0]=2Enext_try =3D 0;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* a genuine outstanding packet, two =
below rel-&gt;packet_id */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    rel=2Earray[1]=2Eactive =3D true;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    rel=2Earray[1]=2Epacket_id =3D 1;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    rel=2Earray[1]=2Etimeout =3D=
 2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rel=2Earray[=
1]=2Enext_try =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int opcode =3D=
 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_e=
qual(&amp;rel=2Earray[1]=2Ebuf, reliable_send(&amp;rel, &amp;opcode));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* reliable_can_send() promises reliable_send() will hand ba=
ck a buffer, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
its caller asserts on that=2E The state below cannot arise through the API =
--</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the entry sits=
 outside the send window -- but the two must not be able to</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * disagree=2E */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+test_reliable_send_matches_can_send(void **st=
ate)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    now =3D 1000;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct reliable rel =3D { 0 };</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    rel=2Esize =3D CHAR_N_SEND_BUFFERS;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rel=2Einitial_t=
imeout =3D 2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
l=2Epacket_id =3D 3;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rel=2Earray[0]=
=2Eactive =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    rel=2Earray[0]=2Epacket_id =3D 0x40000000;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    rel=2Earray[0]=2Etimeout =3D 2;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    rel=2Earray[0]=2Enext_try =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    int opcode =3D 0;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(reliable_can_s=
end(&amp;rel));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_non_null(reliable_send(&amp;rel, &amp;opcode));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span> /* reliable_send() picks the oldest elig=
ible entry, across the wrap and the</span><br><span>  * signed midpoint */<=
/span><br><span> static void</span><br><span>@@ -880,10 +1007,14 @@</span><=
br><span>         cmocka_unit_test(test_reliable_backoff_is_bounded),</span=
><br><span>         cmocka_unit_test(test_reliable_purge_ignores_forged_ack=
s),</span><br><span>         cmocka_unit_test(test_reliable_purge_legitimat=
e_ack),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmoc=
ka_unit_test(test_wont_break_sequentiality_accepts_next_id),</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_recv=
_window_bounded_at_wrap),</span><br><span>         cmocka_unit_test(test_re=
cv_filter_characterization),</span><br><span>         cmocka_unit_test(test=
_recv_filter_high_base),</span><br><span>         cmocka_unit_test(test_sen=
d_window_characterization),</span><br><span>         cmocka_unit_test(test_=
reliable_send_picks_oldest),</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        cmocka_unit_test(test_reliable_send_ignores_entry_ahead),<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_=
test(test_reliable_send_matches_can_send),</span><br><span>         cmocka_=
unit_test(test_get_buf_output_sequenced_boundary),</span><br><span>        =
 cmocka_unit_test(test_mark_active_incoming_accepts_window),</span><br><spa=
n> #ifndef _MSC_VER</span><br></pre><p>To view, visit <a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1900?usp=3Demail">change 1900</a>=2E To un=
subscribe, or for help writing mail filters, visit <a href=3D"https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope i=
temtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1900?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displa=
y:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"=
> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch=
: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iaaa0af7d678=
eb447bc93741add8120d9f348d9eb </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Number: 1900 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </=
div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;ra=
zvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--f5DipzXMEyY=--


--===============0159490901426114274==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0159490901426114274==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0159490901426114274==--

