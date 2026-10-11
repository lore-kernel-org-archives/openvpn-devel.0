Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A5DFCA9EBD
	for <openvpn-devel@archiver.kernel.org>; Sun, 11 Oct 2026 15:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bhPF8FCWmTa/cK1DwUlhHmc+FM+3CQ7D0SK9E+2zuXY=; b=jvBR23B7KoK/1GoUCYmwqsHDaA
	rLhzvKAuqp7LfUqmdvtWjVjDy3aSu3ns2/3+CVvxqbLU5/xGpHTMR2uAYnpOEyH70Xd3h2fst7b5x
	FW9ShWr/uLxpAv0G3uopQCxav/YBXTM8cx1AhfLzOmVw+lbWP/tz3kFHP5vpKcP3/iBM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xFvx0-0007b2-39;
	Sun, 11 Oct 2026 15:58:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xFvwz-0007au-0v
 for openvpn-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 15:58:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=G7c+q6EhmZJdZNShtxfAdy7jsJUVQT/VilEbnbCVGmI=; b=FGoMhSOZ82rdQheQ3InPcE3MP3
 45hV+kulg9C8ea+yYbkkME0HiXBotkwtl2uPUlXVl7GMCguoNvUkz/Y226vPavbAlYKtcgt4FAps6
 /+02vVGxe7Ml3HDUYZ2uUVckgfARavxga9jwpVYm0r9U5ANXMbsI3irbq4mN2ytAIE10=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=G7c+q6EhmZJdZNShtxfAdy7jsJUVQT/VilEbnbCVGmI=; b=N
 YJ2uW6aKPdKoyX9Bt9iAWkMuQdFikTvil5yWVkN3sdH61EB+5Yhe/laITMq8P1nwyZPwAd9p2Qpjp
 E3YCEdCzhB8L3/JisxrBgEYS3BufMBpPxg6p2rG3lm8L+xI6fNQJ2stBJbElaLF0opMxIHEzh7F32
 wm+DRqAc2GuT3pKs=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xFvwt-0005cG-2c for openvpn-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 15:58:58 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-486e70f2457so460853f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 11 Oct 2026 08:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791734328; x=1792339128; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=G7c+q6EhmZJdZNShtxfAdy7jsJUVQT/VilEbnbCVGmI=;
 b=AOtZvbBHM+StgQfwFJfh66yMwK8Kj6JBWtik+detPdIi2s1CfeWDp0p9LcBvgluxnw
 3SP0JXKtrXJWUUc9fBPzd3x4uBXhphch1GV8dzxHWE34NCbktdWMCRwfDB05/eYHHTC7
 BeerT7cizGulijD8t6AxlUr3HGOfAlZFZEwBaltBpWOKvuUfjzEt2S1Yy4dWidP5Etrc
 RemTYGDU3Rehpg4n3ZmPqDyIomUplLCn3K/9q2s4Lo/Auzu6RT1HGOQVadMImy8p/+hA
 w3tzE9LYAUzKtHn680+2qTFQFY3tFFTDnGByIFKVlip8pwyelvtX5mWEuk59IoomIZS8
 gAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791734328; x=1792339128;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=G7c+q6EhmZJdZNShtxfAdy7jsJUVQT/VilEbnbCVGmI=;
 b=aRn2iOpHuvX1yM/9v4rXh+yOblAcBUT/tlSnhUslRkSddqj4ZbwJxcpxvzb1miFadV
 rT6WJiAaTXXkbwxRKCPvu1yz8rOkTCUk/ijjMa2s8oB+cbd9lEMG3MzJ3xt2HNlsfGju
 TgCD7EaUSMLQA3sO3wnZO1xArcenIJr4JmtSvb/umUqIEMaB1MujeVXl1+EqgsY6F56G
 ldW6NVKztUxEoxjRiszQuYUMaoTFnlhssM46rtjo/GKP9ZqtgIqHCBEYGZvmc0REz+7k
 D7fmLVZJEcZJhfZGOARq78/yn/jTHZMm+wP9hc2IERny115xABG0ob+czALSbp06SR3H
 t+lA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx8LHuiiNSECCpEEzIK89xT6i0dYVoHUkhi2uEV9+zP3Fg8lT4FvMIVCZyLBfHJTo2cO59si0yabFML1TzF@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLTg/qGyNCTv//daOMjNPkHqJvVmFXs/Oz69kFkws5hUZv5RCve
 l9j/QZ0f1kxdXqexWWbHgMBpVAhyBshqxMlDqyx26Ro22FDWHxsH3yBk4fkgYwMdT4FVm9pWbGQ
 66MjS4AcyzIIhrfoor4eVmINCDNxNNFS5jW2dbUGa9NgJc7GB2ANuYc62Dm5X+dL4LRJT
X-Gm-Gg: AYBFou1ZC3+u7cAYyxFCEL9BljnhIs4/xINqKzQxo2Db4uJb1uVwLcnYA6EE0CeVfVE
 DREkuW9TqplUs4E5D3uRrdnhhCnZlWNOvuy2hFfUtiL8srX9Cqdi3fhii1r/b9CNJDuBFjWFX5Z
 7Wfqw8bkovYkZOc64C0RO72U14aJDr+7a3l3AhJibQF5vbmO4vgRStlv2MvevKpBa5d2k/q2MSR
 h/1jzj539kDUnUCceGAHzKv+eSDWqnk48oLMF/gRPDBl/jILnV9sZCzPRZ9HKCRrmXacRBqagWL
 bX3FwJ+NwlEyPk29gSL8isAFUyzDRWyUoiptlmm4ydos6GRYSf4f3WAcLZd+Ia6JOs0pxE/yMzQ
 C22ARhXs3BnE5XTuuQjNlAxfufNclGOs4sar2jL/WOK+8vLwbBoYz59RvXbRvBJsdLZFotW+OI+
 KzC9UhlDyfxMEi7n0qYIF8SLJ6McrAbNjytw4Kfc/+GtRlyYkLFNliyTwROa0iZppS8gqJEn5rV
 KWe7y5YoLaXt7ezqsUwhwCh2Y46OkECXu5iPCNF1VNaJhaT+gtGgM2eQoikUw2Der4CdFy5a1Cq
 kTdL/8CNYpbjqvwBzr7Dw7lgTzeG2GGl8Phrve4JofKh0Z0KTpR/3y1yIo72
X-Received: by 2002:a05:600c:3d96:b0:4a1:746e:5898 with SMTP id
 5b1f17b1804b1-4a18e4835e7mr122547475e9.13.1791734327975; 
 Sun, 11 Oct 2026 08:58:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be97d1esm348053315e9.8.2026.10.11.08.58.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 08:58:47 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 11 Oct 2026 15:58:47 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Iaaa0af7d678eb447bc93741add8120d9f348d9eb
X-Gerrit-Change-Number: 1900
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1900?usp=email>
X-Gerrit-Commit: 2318e3366392d0d066c2a8cfa1b3d1f332935334
In-Reply-To: <gerrit.1788765781000.Iaaa0af7d678eb447bc93741add8120d9f348d9eb@gerrit.openvpn.net>
References: <gerrit.1788765781000.Iaaa0af7d678eb447bc93741add8120d9f348d9eb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NzY1NzgxMDAwLklhYWEwYWY3ZDY3OGViNDQ3YmM5Mzc0MWFkZDgxMjBkOWYzNDhkOWViQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e63e67c5852a6ffd1aeed78cf8bb245af0af3ded-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xFvwt-0005cG-2c
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2078631354693651566=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2078631354693651566==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3VhNgTtkzws="; charset=UTF-8

--3VhNgTtkzws=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1900?usp=3Demail )

Change subject: reliable: drop the half-spa=
ce packet id comparisons
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

reliable: drop the half-space packet id comparisons

Every co=
mparison becomes a modular distance against a stated bound=2E
subtract_pid(=
) stays and reliable_pid_in_range1() loses its suffix;
reliable_pid_min() a=
nd reliable_pid_in_range2() go, and with them the last
0x80000000 in the fi=
le=2E

The three scans for the oldest unacknowledged entry now track the la=
rgest
distance below rel->packet_id, bounded by rel->size, in
reliable_olde=
st_active_distance()=2E reliable_wont_break_sequentiality() bounds
the dist=
ance ahead and accepts past ids outright, as the old comparison did
without=
 the 0x80000000 bias=2E

reliable_can_send() counts the same entries withou=
t the window bound and its
caller asserts on the result, so reliable_send()=
 falls back to any eligible
entry when the bound leaves nothing=2E

Equival=
ent for every reachable input=2E Four deliberate differences:

- Once rel->=
packet_id + rel->size overflows, the absolute clause makes
  reliable_wont_=
break_sequentiality() permissive: ids the old bias branch
  rejected are ac=
knowledged=2E Nothing more is stored, reliable_not_replay()
  still boundin=
g that to the receive window, which wraps with rel->packet_id=2E
  Needs ~2=
^32 control channel packets in one key state=2E
- Above 2^31, an id absolut=
ely below rel->packet_id + rel->size but more than
  rel->size ahead is ack=
nowledged and no longer stored: it can never equal
  rel->packet_id, so its=
 slot was held for the rest of the key state=2E Needs
  ~2^31 such packets;=
 test_recv_filter_high_base's oracle switches to the new
  rule there, pinn=
ing behaviour rather than equivalence=2E
- The ASSERT in reliable_mark_acti=
ve_incoming() is the receive window rather
  than a half space, and runs be=
fore the entry is touched=2E Unobservable: it
  repeats the check reliable_=
not_replay() makes immediately before it=2E
- A send entry more than rel->s=
ize below rel->packet_id is ignored by the
  scans instead of taken for a v=
ery old one, so
  reliable_get_num_output_sequenced_available() can no long=
er go negative=2E
  reliable_get_buf_output_sequenced() keeps every distanc=
e within rel->size,
  so it never could=2E

Change-Id: Iaaa0af7d678eb447bc9=
3741add8120d9f348d9eb
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg=
>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit URL: https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1900
Message-Id: <20261008205143=2E28452-=
1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-de=
vel@lists=2Esourceforge=2Enet/msg39796=2Ehtml
Signed-off-by: Gert Doering <=
gert@greenie=2Emuc=2Ede>
---
M src/openvpn/reliable=2Ec
M src/openvpn/relia=
ble=2Eh
M tests/unit_tests/openvpn/test_packet_id=2Ec
3 files changed, 210 =
insertions(+), 94 deletions(-)




diff --git a/src/openvpn/reliable=2Ec b/=
src/openvpn/reliable=2Ec
index b5315ff=2E=2E645fbfd 100644
--- a/src/openvp=
n/reliable=2Ec
+++ b/src/openvpn/reliable=2Ec
@@ -50,46 +50,12 @@
  * verif=
y that test - base < extent while allowing for base or test wraparound
  */=

 static inline bool
-reliable_pid_in_range1(const packet_id_type test, con=
st packet_id_type base,
-                       const unsigned int extent)
=
+reliable_pid_in_range(const packet_id_type test, const packet_id_type base=
,
+                      const unsigned int extent)
 {
     return subtract=
_pid(test, base) < extent;
 }
 
-/*
- * verify that test < base + extent wh=
ile allowing for base or test wraparound
- */
-static inline bool
-reliable=
_pid_in_range2(const packet_id_type test, const packet_id_type base,
-     =
                  const unsigned int extent)
-{
-    if (base + extent >=3D=
 base)
-    {
-        if (test < base + extent)
-        {
-            re=
turn true;
-        }
-    }
-    else
-    {
-        if ((test + 0x800000=
00u) < (base + 0x80000000u) + extent)
-        {
-            return true;
=
-        }
-    }
-
-    return false;
-}
-
-/*
- * verify that p1 < p2  wh=
ile allowing for p1 or p2 wraparound
- */
-static inline bool
-reliable_pid=
_min(const packet_id_type p1, const packet_id_type p2)
-{
-    return !reli=
able_pid_in_range1(p1, p2, 0x80000000u);
-}
-
 /* check if a particular pac=
ket_id is present in ack */
 static inline bool
 reliable_ack_packet_id_pre=
sent(struct reliable_ack *ack, packet_id_type pid)
@@ -393,8 +359,9 @@
 int=

 validate_packet_id_window(struct reliable *rel, packet_id_type pid)
 {
- =
   return reliable_pid_min(pid, rel->packet_id)
-           && reliable_pid=
_min(subtract_pid(rel->packet_id, RELIABLE_CAPACITY), pid);
+    const pack=
et_id_type dist =3D subtract_pid(rel->packet_id, pid);
+
+    return dist >=
 0 && dist < RELIABLE_CAPACITY;
 }
 
 /* del acknowledged items from send b=
uf */
@@ -440,14 +407,17 @@
                 e->active =3D false;
         =
    }
 
-            if (e->active && reliable_pid_min(e->packet_id, pid))
=
+            /* Order the two by their distance below rel->packet_id, as
+ =
            * comparing the ids directly misorders them across the wrap=2E
=
+             * Entries further back than rel->size are outside the send wi=
ndow
+             * and left alone=2E An ACK for a higher pid means this p=
acket
+             * arrived out of order or was lost, and enough of them =
trigger
+             * the early resend=2E */
+            const packet_id=
_type e_dist =3D subtract_pid(rel->packet_id, e->packet_id);
+
+           =
 if (e->active && e_dist <=3D (packet_id_type)rel->size
+                &&=
 e_dist > subtract_pid(rel->packet_id, pid))
             {
-              =
  /* We have received an ACK for a packet with a higher PID=2E Either
-    =
             * we have received ACKs out of or order or the packet has been=

-                 * lost=2E We count the number of ACKs to determine if we=
 should
-                 * resend it early=2E The comparison needs to be w=
raparound aware,
-                 * otherwise a peer can inflate n_acks wi=
th an ACK for a pid from
-                 * the lower half of the id space=
 and force a retransmit=2E */
                 e->n_acks++;
             }
=
         }
@@ -505,7 +475,9 @@
 reliable_not_replay(const struct reliable *=
rel, packet_id_type id)
 {
     struct gc_arena gc =3D gc_new();
-    if (r=
eliable_pid_min(id, rel->packet_id))
+
+    /* outside the receive window: =
already consumed, or too far ahead to store */
+    if (!reliable_pid_in_ra=
nge(id, rel->packet_id, rel->size))
     {
         goto bad;
     }
@@ -53=
1,7 +503,12 @@
 bool
 reliable_wont_break_sequentiality(const struct reliab=
le *rel, packet_id_type id)
 {
-    const int ret =3D reliable_pid_in_range=
2(id, rel->packet_id, rel->size);
+    /* The first clause is the receive w=
indow=2E The second is an absolute
+     * comparison, kept so that already=
 consumed ids still reach
+     * reliable_ack_acknowledge_packet_id() and =
a peer whose ACK was lost stops
+     * retransmitting; reliable_not_replay=
() rejects them=2E */
+    const bool ret =3D (subtract_pid(id, rel->packet=
_id) < (packet_id_type)rel->size
+                      || id < rel->packet=
_id);
 
     if (!ret)
     {
@@ -562,57 +539,46 @@
     return NULL;
 }
 
=
-int
-reliable_get_num_output_sequenced_available(struct reliable *rel)
+/*=
 Distance below rel->packet_id of the oldest unacknowledged entry, 0 if the=
re
+ * is none=2E Entries more than rel->size away are outside the sequenci=
ng window
+ * and ignored, rather than taken for very old ones=2E */
+stati=
c packet_id_type
+reliable_oldest_active_distance(const struct reliable *re=
l)
 {
-    packet_id_type min_id =3D 0;
-    bool min_id_defined =3D false;=

+    packet_id_type max_dist =3D 0;
 
-    /* find minimum active packet_i=
d */
     for (int i =3D 0; i < rel->size; ++i)
     {
         const struc=
t reliable_entry *e =3D &rel->array[i];
-        if (e->active)
+        if=
 (!e->active)
         {
-            if (!min_id_defined || reliable_pid_m=
in(e->packet_id, min_id))
-            {
-                min_id_defined =
=3D true;
-                min_id =3D e->packet_id;
-            }
+       =
     continue;
+        }
+
+        const packet_id_type dist =3D subtract=
_pid(rel->packet_id, e->packet_id);
+        if (dist <=3D (packet_id_type)=
rel->size && dist > max_dist)
+        {
+            max_dist =3D dist;
  =
       }
     }
 
-    int ret =3D rel->size;
-    if (min_id_defined)
-   =
 {
-        ret -=3D subtract_pid(rel->packet_id, min_id);
-    }
-    retu=
rn ret;
+    return max_dist;
+}
+
+int
+reliable_get_num_output_sequenced_=
available(struct reliable *rel)
+{
+    return rel->size - (int)reliable_ol=
dest_active_distance(rel);
 }
 
 /* grab a free buffer, fail if buffer clog=
ged by unacknowledged low packet IDs */
 struct buffer *
 reliable_get_buf_=
output_sequenced(struct reliable *rel)
 {
-    packet_id_type min_id =3D 0;=

-    bool min_id_defined =3D false;
     struct buffer *ret =3D NULL;
 
- =
   /* find minimum active packet_id */
-    for (int i =3D 0; i < rel->size=
; ++i)
-    {
-        const struct reliable_entry *e =3D &rel->array[i];
-=
        if (e->active)
-        {
-            if (!min_id_defined || relia=
ble_pid_min(e->packet_id, min_id))
-            {
-                min_id_d=
efined =3D true;
-                min_id =3D e->packet_id;
-            }
-=
        }
-    }
-
-    if (!min_id_defined || reliable_pid_in_range1(rel->=
packet_id, min_id, rel->size))
+    /* keep the next id within rel->size of=
 the oldest unacknowledged one */
+    if (reliable_oldest_active_distance(=
rel) < (packet_id_type)rel->size)
     {
         ret =3D reliable_get_buf(=
rel);
     }
@@ -671,6 +637,8 @@
 reliable_send(struct reliable *rel, int *=
opcode)
 {
     struct reliable_entry *best =3D NULL;
+    struct reliable_=
entry *eligible =3D NULL;
+    packet_id_type best_dist =3D 0;
     const t=
ime_t local_now =3D now;
 
     for (int i =3D 0; i < rel->size; ++i)
@@ -6=
82,13 +650,29 @@
          * not expired yet=2E */
         if (e->active &=
& (e->n_acks >=3D N_ACK_RETRANSMIT || local_now >=3D e->next_try))
        =
 {
-            if (!best || reliable_pid_min(e->packet_id, best->packet_id=
))
+            /* oldest =3D furthest below rel->packet_id, within the win=
dow */
+            const packet_id_type dist =3D subtract_pid(rel->packet_=
id, e->packet_id);
+            if (dist <=3D (packet_id_type)rel->size && =
dist > best_dist)
             {
                 best =3D e;
+            =
    best_dist =3D dist;
+            }
+
+            if (!eligible)
+     =
       {
+                eligible =3D e;
             }
         }
     }
=
 
+    /* reliable_can_send() promises a non-NULL result for these same ent=
ries
+     * without applying the window bound, and its caller asserts on t=
hat, so
+     * never come back empty while one of them is eligible=2E */
+=
    if (!best)
+    {
+        best =3D eligible;
+    }
+
     if (best)
 =
    {
         /* The initial timeout is bounded by RELIABLE_MAX_INITIAL_TI=
MEOUT, so
@@ -776,14 +760,14 @@
         struct reliable_entry *e =3D &rel-=
>array[i];
         if (buf =3D=3D &e->buf)
         {
+            /* stor=
able and not yet consumed, checked before touching the entry */
+          =
  ASSERT(reliable_pid_in_range(pid, rel->packet_id, rel->size));
+
        =
     e->active =3D true;
 
             /* packets may not arrive in sequen=
tial order */
             e->packet_id =3D pid;
 
-            /* check fo=
r replay */
-            ASSERT(!reliable_pid_min(pid, rel->packet_id));
-
=
             e->opcode =3D opcode;
             e->next_try =3D 0;
        =
     e->timeout =3D 0;
diff --git a/src/openvpn/reliable=2Eh b/src/openvpn/=
reliable=2Eh
index a85f2e9=2E=2E04f3372 100644
--- a/src/openvpn/reliable=
=2Eh
+++ b/src/openvpn/reliable=2Eh
@@ -288,15 +288,16 @@
 bool reliable_ca=
n_get(const struct reliable *rel);
 
 /**
- * Check that a received packet'=
s ID is not a replay=2E
+ * Check that a received packet's ID is not a repl=
ay and is inside the receive
+ * window=2E
  *
  * @param rel The reliable =
structure for handling this VPN tunnel's
  *     received packets=2E
  * @p=
aram id The packet ID of the received packet=2E
  *
  * @return
- * @li Tru=
e, if the packet ID is not a replay=2E
- * @li False, if the packet ID is a=
 replay=2E
+ * @li True, if the packet ID is new and inside the receive win=
dow=2E
+ * @li False, if it is a replay, or too far ahead to be stored=2E
 =
 */
 bool reliable_not_replay(const struct reliable *rel, packet_id_type id=
);
 
diff --git a/tests/unit_tests/openvpn/test_packet_id=2Ec b/tests/unit_=
tests/openvpn/test_packet_id=2Ec
index aabb555=2E=2Eac6c710 100644
--- a/te=
sts/unit_tests/openvpn/test_packet_id=2Ec
+++ b/tests/unit_tests/openvpn/te=
st_packet_id=2Ec
@@ -517,13 +517,16 @@
 }
 
 /*
- * Reference implementatio=
ns of the packet id comparisons as they behave today=2E
- * The sweeps belo=
w assert reliable=2Ec agrees with them at the anchors swept, so
- * a chang=
e to an accepted id set there fails a test=2E Keep them standalone:
- * exp=
ressing them in terms of reliable=2Ec would make the sweeps tautologies=2E
=
+ * Independent models of the id sets the packet id comparisons accept=2E T=
he
+ * sweeps below assert reliable=2Ec agrees with them at the anchors swe=
pt, so a
+ * change to an accepted id set there fails a test=2E Each model =
is tagged
+ * "preserved" or "introduced" against the comparisons that came=
 before=2E Keep
+ * them standalone: expressing them in terms of reliable=
=2Ec would make the
+ * sweeps tautologies=2E
  */
 
-/* "p1 < p2" with the=
 2^31 horizon, i=2Ee=2E ((int32_t)(p1 - p2) < 0) */
+/* the dropped reliabl=
e_pid_min(): "p1 < p2" with the 2^31 horizon,
+ * i=2Ee=2E ((int32_t)(p1 - =
p2) < 0) */
 static bool
 ref_pid_min(packet_id_type p1, packet_id_type p2)=

 {
@@ -538,6 +541,7 @@
 #define CHAR_N_SEND_BUFFERS    6
 #define CHAR_OPC=
ODE_CONTROL_V1 4
 
+/* preserved: the ids validate_packet_id_window() accep=
ts */
 static bool
 ref_pid_in_send_window(const struct reliable *rel, pack=
et_id_type pid)
 {
@@ -546,6 +550,7 @@
     return dist >=3D 1 && dist <=3D=
 CHARACTERIZED_SEND_WINDOW;
 }
 
+/* preserved: reliable_pid_in_range2() */=

 static bool
 ref_wont_break_sequentiality(const struct reliable *rel, pac=
ket_id_type id)
 {
@@ -559,6 +564,7 @@
     return id < base + extent;
 }
 =

+/* preserved: the horizon check, then the slot scan */
 static bool
 ref_=
not_replay(const struct reliable *rel, packet_id_type id)
 {
@@ -691,6 +697=
,54 @@
     }
 }
 
+/* Once rel->packet_id + rel->size overflows, the absol=
ute clause makes
+ * reliable_wont_break_sequentiality() permissive; what m=
ay be stored is still
+ * the receive window, which wraps with it=2E */
+st=
atic void
+test_recv_window_bounded_at_wrap(void **state)
+{
+    struct re=
liable rel =3D { 0 };
+    rel=2Esize =3D RELIABLE_CAPACITY;
+    rel=2Epac=
ket_id =3D 0xFFFFFFF8;
+
+    assert_int_equal(RECV_STORE, recv_filter(&rel=
, 0xFFFFFFF8));
+    assert_int_equal(RECV_STORE, recv_filter(&rel, 0xFFFFF=
FFF));
+    assert_int_equal(RECV_STORE, recv_filter(&rel, 3));
+
+    /* o=
ne past the window, and one behind it: acknowledged, never stored */
+    a=
ssert_int_equal(RECV_ACK_ONLY, recv_filter(&rel, 4));
+    assert_int_equal=
(RECV_ACK_ONLY, recv_filter(&rel, 0xFFFFFFF7));
+}
+
+/* The id the receive=
r is next waiting for has to be storable at every base,
+ * the packet id w=
rap included=2E */
+static void
+test_wont_break_sequentiality_accepts_next=
_id(void **state)
+{
+    const packet_id_type bases[] =3D {
+        0,
+ =
       1,
+        500,
+        0x7FFFFFFF,
+        0x80000000,
+        =
0xFFFFFFF3,
+        0xFFFFFFF4,
+        0xFFFFFFF8,
+        0xFFFFFFFE,
=
+        0xFFFFFFFF,
+    };
+
+    for (size_t i =3D 0; i < SIZE(bases); i=
++)
+    {
+        struct reliable rel =3D { 0 };
+        rel=2Esize =3D =
RELIABLE_CAPACITY;
+        rel=2Epacket_id =3D bases[i];
+
+        assert=
_true(reliable_wont_break_sequentiality(&rel, rel=2Epacket_id));
+        a=
ssert_true(reliable_not_replay(&rel, rel=2Epacket_id));
+    }
+}
+
 /* bas=
es at or below 2^31, where old and new agree; never to change */
 static vo=
id
 test_recv_filter_characterization(void **state)
@@ -698,12 +752,31 @@
 =
    sweep_recv_filter(char_anchors, SIZE(char_anchors), ref_recv_filter);
 =
}
 
+/* Introduced, for the bases above 2^31 only: storing also requires th=
e id to
+ * be inside the receive window=2E The ids between one further ahe=
ad and
+ * rel->packet_id cannot all fit alongside it, so rel->packet_id ne=
ver reaches
+ * it and the slot is held for the rest of the key state=2E St=
ill ACKed, like a
+ * replay=2E */
+static enum recv_verdict
+ref_recv_filt=
er_bounded(const struct reliable *rel, packet_id_type id)
+{
+    const enu=
m recv_verdict verdict =3D ref_recv_filter(rel, id);
+
+    if (verdict =3D=
=3D RECV_STORE
+        && (packet_id_type)(id - rel->packet_id) >=3D (pack=
et_id_type)rel->size)
+    {
+        return RECV_ACK_ONLY;
+    }
+
+    r=
eturn verdict;
+}
+
 /* bases above 2^31, where they diverge, kept apart so=
 a change confined
  * there touches one test */
 static void
 test_recv_fi=
lter_high_base(void **state)
 {
-    sweep_recv_filter(char_anchors_high, S=
IZE(char_anchors_high), ref_recv_filter);
+    sweep_recv_filter(char_ancho=
rs_high, SIZE(char_anchors_high), ref_recv_filter_bounded);
 }
 
 static vo=
id
@@ -739,6 +812,60 @@
     sweep_send_window(char_anchors_high, SIZE(char=
_anchors_high));
 }
 
+/* The window bound in the selection is what stops a=
n entry sitting ahead of
+ * rel->packet_id from being taken for the oldest=
 one: its distance below
+ * rel->packet_id is then nearly the whole id spa=
ce=2E array[0] cannot arise
+ * through the API; array[1] is an ordinary ou=
tstanding packet=2E */
+static void
+test_reliable_send_ignores_entry_ahead=
(void **state)
+{
+    now =3D 1000;
+
+    struct reliable rel =3D { 0 };
=
+    rel=2Esize =3D CHAR_N_SEND_BUFFERS;
+    rel=2Einitial_timeout =3D 2;
=
+    rel=2Epacket_id =3D 3;
+
+    /* scanned first, and outside the window=
 */
+    rel=2Earray[0]=2Eactive =3D true;
+    rel=2Earray[0]=2Epacket_id =
=3D 0x40000000;
+    rel=2Earray[0]=2Etimeout =3D 2;
+    rel=2Earray[0]=2E=
next_try =3D 0;
+
+    /* a genuine outstanding packet, two below rel->pack=
et_id */
+    rel=2Earray[1]=2Eactive =3D true;
+    rel=2Earray[1]=2Epacke=
t_id =3D 1;
+    rel=2Earray[1]=2Etimeout =3D 2;
+    rel=2Earray[1]=2Enext=
_try =3D 0;
+
+    int opcode =3D 0;
+    assert_ptr_equal(&rel=2Earray[1]=
=2Ebuf, reliable_send(&rel, &opcode));
+}
+
+/* reliable_can_send() promise=
s reliable_send() will hand back a buffer, and
+ * its caller asserts on th=
at=2E The state below cannot arise through the API --
+ * the entry sits ou=
tside the send window -- but the two must not be able to
+ * disagree=2E */=

+static void
+test_reliable_send_matches_can_send(void **state)
+{
+    no=
w =3D 1000;
+
+    struct reliable rel =3D { 0 };
+    rel=2Esize =3D CHAR_=
N_SEND_BUFFERS;
+    rel=2Einitial_timeout =3D 2;
+    rel=2Epacket_id =3D =
3;
+
+    rel=2Earray[0]=2Eactive =3D true;
+    rel=2Earray[0]=2Epacket_id=
 =3D 0x40000000;
+    rel=2Earray[0]=2Etimeout =3D 2;
+    rel=2Earray[0]=
=2Enext_try =3D 0;
+
+    int opcode =3D 0;
+    assert_true(reliable_can_s=
end(&rel));
+    assert_non_null(reliable_send(&rel, &opcode));
+}
+
 /* re=
liable_send() picks the oldest eligible entry, across the wrap and the
  * =
signed midpoint */
 static void
@@ -880,10 +1007,14 @@
         cmocka_unit=
_test(test_reliable_backoff_is_bounded),
         cmocka_unit_test(test_rel=
iable_purge_ignores_forged_acks),
         cmocka_unit_test(test_reliable_p=
urge_legitimate_ack),
+        cmocka_unit_test(test_wont_break_sequentiali=
ty_accepts_next_id),
+        cmocka_unit_test(test_recv_window_bounded_at_=
wrap),
         cmocka_unit_test(test_recv_filter_characterization),
      =
   cmocka_unit_test(test_recv_filter_high_base),
         cmocka_unit_test(=
test_send_window_characterization),
         cmocka_unit_test(test_reliable=
_send_picks_oldest),
+        cmocka_unit_test(test_reliable_send_ignores_e=
ntry_ahead),
+        cmocka_unit_test(test_reliable_send_matches_can_send)=
,
         cmocka_unit_test(test_get_buf_output_sequenced_boundary),
      =
   cmocka_unit_test(test_mark_active_incoming_accepts_window),
 #ifndef _MS=
C_VER

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1900?u=
sp=3Demail
To unsubscribe, or for help writing mail filters, visit https://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Ger=
rit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iaaa0af7d678eb=
447bc93741add8120d9f348d9eb
Gerrit-Change-Number: 1900
Gerrit-PatchSet: 4
G=
errit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: =
Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn=
-devel@lists=2Esourceforge=2Enet>

--3VhNgTtkzws=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1900?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">reliable: drop the half-space pack=
et id comparisons<br><br>Every comparison becomes a modular distance agains=
t a stated bound=2E<br>subtract_pid() stays and reliable_pid_in_range1() lo=
ses its suffix;<br>reliable_pid_min() and reliable_pid_in_range2() go, and =
with them the last<br>0x80000000 in the file=2E<br><br>The three scans for =
the oldest unacknowledged entry now track the largest<br>distance below rel=
-&gt;packet_id, bounded by rel-&gt;size, in<br>reliable_oldest_active_dista=
nce()=2E reliable_wont_break_sequentiality() bounds<br>the distance ahead a=
nd accepts past ids outright, as the old comparison did<br>without the 0x80=
000000 bias=2E<br><br>reliable_can_send() counts the same entries without t=
he window bound and its<br>caller asserts on the result, so reliable_send()=
 falls back to any eligible<br>entry when the bound leaves nothing=2E<br><b=
r>Equivalent for every reachable input=2E Four deliberate differences:<br><=
br>- Once rel-&gt;packet_id + rel-&gt;size overflows, the absolute clause m=
akes<br>  reliable_wont_break_sequentiality() permissive: ids the old bias =
branch<br>  rejected are acknowledged=2E Nothing more is stored, reliable_n=
ot_replay()<br>  still bounding that to the receive window, which wraps wit=
h rel-&gt;packet_id=2E<br>  Needs ~2^32 control channel packets in one key =
state=2E<br>- Above 2^31, an id absolutely below rel-&gt;packet_id + rel-&g=
t;size but more than<br>  rel-&gt;size ahead is acknowledged and no longer =
stored: it can never equal<br>  rel-&gt;packet_id, so its slot was held for=
 the rest of the key state=2E Needs<br>  ~2^31 such packets; test_recv_filt=
er_high_base&#39;s oracle switches to the new<br>  rule there, pinning beha=
viour rather than equivalence=2E<br>- The ASSERT in reliable_mark_active_in=
coming() is the receive window rather<br>  than a half space, and runs befo=
re the entry is touched=2E Unobservable: it<br>  repeats the check reliable=
_not_replay() makes immediately before it=2E<br>- A send entry more than re=
l-&gt;size below rel-&gt;packet_id is ignored by the<br>  scans instead of =
taken for a very old one, so<br>  reliable_get_num_output_sequenced_availab=
le() can no longer go negative=2E<br>  reliable_get_buf_output_sequenced() =
keeps every distance within rel-&gt;size,<br>  so it never could=2E<br><br>=
Change-Id: Iaaa0af7d678eb447bc93741add8120d9f348d9eb<br>Signed-off-by: Razv=
an Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1900<br>Message-Id: &lt;20261008205143=2E28452-1-gert@greenie=2E=
muc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg39796=2Ehtml<br>Signed-off-by: Gert Doering &lt;ger=
t@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/reliable=2Ec<br>M src/open=
vpn/reliable=2Eh<br>M tests/unit_tests/openvpn/test_packet_id=2Ec<br>3 file=
s changed, 210 insertions(+), 94 deletions(-)<br><br></pre>
<pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/src/openvpn/reliable=2Ec b/src/openvpn/reliable=2Ec</span><br><span>index =
b5315ff=2E=2E645fbfd 100644</span><br><span>--- a/src/openvpn/reliable=2Ec<=
/span><br><span>+++ b/src/openvpn/reliable=2Ec</span><br><span>@@ -50,46 +5=
0,12 @@</span><br><span>  * verify that test - base &lt; extent while allow=
ing for base or test wraparound</span><br><span>  */</span><br><span> stati=
c inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-reliable=
_pid_in_range1(const packet_id_type test, const packet_id_type base,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                       const=
 unsigned int extent)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+reliable_pid_in_range(const packet_id_type test, const packet_id_type bas=
e,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
     const unsigned int extent)</span><br><span> {</span><br><span>     ret=
urn subtract_pid(test, base) &lt; extent;</span><br><span> }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * verify that test &lt; base + exten=
t while allowing for base or test wraparound</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-static inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-reliable_pid_in_range2(const packet_id_type test, const packet_id_type ba=
se,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
     const unsigned int extent)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (ba=
se + extent &gt;=3D base)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (=
test &lt; base + extent)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   return true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        if ((test + 0x80000000u) &lt; (base + 0x80000000u) + ex=
tent)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            return true;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    return false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * verify that p1 &lt; p2  while allowing for p1 or p2 wraparo=
und</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-static inline bool</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-reliable_pid_min(const packet_id_type p=
1, const packet_id_type p2)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return !re=
liable_pid_in_range1(p1, p2, 0x80000000u);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span> /* check if a particular packet_id is present in ack */<=
/span><br><span> static inline bool</span><br><span> reliable_ack_packet_id=
_present(struct reliable_ack *ack, packet_id_type pid)</span><br><span>@@ -=
393,8 +359,9 @@</span><br><span> int</span><br><span> validate_packet_id_wi=
ndow(struct reliable *rel, packet_id_type pid)</span><br><span> {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    return reliable_pid_min(pid=
, rel-&gt;packet_id)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
          &amp;&amp; reliable_pid_min(subtract_pid(rel-&gt;packet_id, RELIA=
BLE_CAPACITY), pid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const packet_id_type dist =3D subtract_pid(rel-&gt;packet_id, pid);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return dist &gt; 0 &amp;&amp; dist &l=
t; RELIABLE_CAPACITY;</span><br><span> }</span><br><span> </span><br><span>=
 /* del acknowledged items from send buf */</span><br><span>@@ -440,14 +407=
,17 @@</span><br><span>                 e-&gt;active =3D false;</span><br><=
span>             }</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            if (e-&gt;active &amp;&amp; reliable_pid_min(e-=
&gt;packet_id, pid))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            /* Order the two by their distance below rel-&gt;packet_id, as=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             * comp=
aring the ids directly misorders them across the wrap=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+             * Entries further back th=
an rel-&gt;size are outside the send window</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+             * and left alone=2E An ACK for a highe=
r pid means this packet</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+             * arrived out of order or was lost, and enough of them tri=
gger</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             * =
the early resend=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            const packet_id_type e_dist =3D subtract_pid(rel-&gt;packet_=
id, e-&gt;packet_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (e=
-&gt;active &amp;&amp; e_dist &lt;=3D (packet_id_type)rel-&gt;size</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                &amp;&amp; e=
_dist &gt; subtract_pid(rel-&gt;packet_id, pid))</span><br><span>          =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                /=
* We have received an ACK for a packet with a higher PID=2E Either</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                 * we have rec=
eived ACKs out of or order or the packet has been</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                 * lost=2E We count the number =
of ACKs to determine if we should</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                 * resend it early=2E The comparison needs to b=
e wraparound aware,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
               * otherwise a peer can inflate n_acks with an ACK for a pid =
from</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
* the lower half of the id space and force a retransmit=2E */</span><br><sp=
an>                 e-&gt;n_acks++;</span><br><span>             }</span><b=
r><span>         }</span><br><span>@@ -505,7 +475,9 @@</span><br><span> rel=
iable_not_replay(const struct reliable *rel, packet_id_type id)</span><br><=
span> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    if (reliable_pid_min(id, rel-&g=
t;packet_id))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* outside the receiv=
e window: already consumed, or too far ahead to store */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (!reliable_pid_in_range(id, rel=
-&gt;packet_id, rel-&gt;size))</span><br><span>     {</span><br><span>     =
    goto bad;</span><br><span>     }</span><br><span>@@ -531,7 +503,12 @@</=
span><br><span> bool</span><br><span> reliable_wont_break_sequentiality(con=
st struct reliable *rel, packet_id_type id)</span><br><span> {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    const int ret =3D reliable_pid=
_in_range2(id, rel-&gt;packet_id, rel-&gt;size);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* The first clause is the receive window=
=2E The second is an absolute</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * comparison, kept so that already consumed ids still reach<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * reliable_ack_=
acknowledge_packet_id() and a peer whose ACK was lost stops</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+     * retransmitting; reliable_not=
_replay() rejects them=2E */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    const bool ret =3D (subtract_pid(id, rel-&gt;packet_id) &lt; (=
packet_id_type)rel-&gt;size</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                      || id &lt; rel-&gt;packet_id);</span><br><spa=
n> </span><br><span>     if (!ret)</span><br><span>     {</span><br><span>@=
@ -562,57 +539,46 @@</span><br><span>     return NULL;</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-reliable_get_num_output=
_sequenced_available(struct reliable *rel)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/* Distance below rel-&gt;packet_id of the oldest un=
acknowledged entry, 0 if there</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * is none=2E Entries more than rel-&gt;size away are outside th=
e sequencing window</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * and ignored, rather than taken for very old ones=2E */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static packet_id_type</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+reliable_oldest_active_distance(con=
st struct reliable *rel)</span><br><span> {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    packet_id_type min_id =3D 0;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    bool min_id_defined =3D false;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    packet_id_type max_dist=
 =3D 0;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    /* find minimum active packet_id */</span><br><span>     for (int i=
 =3D 0; i &lt; rel-&gt;size; ++i)</span><br><span>     {</span><br><span>  =
       const struct reliable_entry *e =3D &amp;rel-&gt;array[i];</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        if (e-&gt;active)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!e-&gt;active)=
</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            if (!min_id_defined || reliable_pid_min(e-&gt;packet_id, =
min_id))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                min_i=
d_defined =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              min_id =3D e-&gt;packet_id;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            continue;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const=
 packet_id_type dist =3D subtract_pid(rel-&gt;packet_id, e-&gt;packet_id);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (dist &lt=
;=3D (packet_id_type)rel-&gt;size &amp;&amp; dist &gt; max_dist)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            max_dist =3D dist;</span><br=
><span>         }</span><br><span>     }</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    int ret =3D rel-&gt;size;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if (min_id_defined)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        ret -=3D subtract_pid(rel-&gt;packe=
t_id, min_id);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return ret;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    return max_dist;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+reli=
able_get_num_output_sequenced_available(struct reliable *rel)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    return rel-&gt;size - (int)reliable_oldest_acti=
ve_distance(rel);</span><br><span> }</span><br><span> </span><br><span> /* =
grab a free buffer, fail if buffer clogged by unacknowledged low packet IDs=
 */</span><br><span> struct buffer *</span><br><span> reliable_get_buf_outp=
ut_sequenced(struct reliable *rel)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    packet_id_type min_id =3D 0;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    bool min_id_defined =3D fals=
e;</span><br><span>     struct buffer *ret =3D NULL;</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* find minimum active=
 packet_id */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for =
(int i =3D 0; i &lt; rel-&gt;size; ++i)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        const struct reliable_entry *e =3D &amp;rel-&gt;array[i];</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        if (e-&gt;active)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            if (!min_id_defined || re=
liable_pid_min(e-&gt;packet_id, min_id))</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                min_id_defined =3D true;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                min_id =3D e-&gt;packet_id;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 if (!min_id_defined || reliable_pid_in_range1(rel-&gt;packet_id, min_id, r=
el-&gt;size))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
 keep the next id within rel-&gt;size of the oldest unacknowledged one */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (reliable_olde=
st_active_distance(rel) &lt; (packet_id_type)rel-&gt;size)</span><br><span>=
     {</span><br><span>         ret =3D reliable_get_buf(rel);</span><br><s=
pan>     }</span><br><span>@@ -671,6 +637,8 @@</span><br><span> reliable_se=
nd(struct reliable *rel, int *opcode)</span><br><span> {</span><br><span>  =
   struct reliable_entry *best =3D NULL;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct reliable_entry *eligible =3D NULL;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    packet_id_type best_dist=
 =3D 0;</span><br><span>     const time_t local_now =3D now;</span><br><spa=
n> </span><br><span>     for (int i =3D 0; i &lt; rel-&gt;size; ++i)</span>=
<br><span>@@ -682,13 +650,29 @@</span><br><span>          * not expired yet=
=2E */</span><br><span>         if (e-&gt;active &amp;&amp; (e-&gt;n_acks &=
gt;=3D N_ACK_RETRANSMIT || local_now &gt;=3D e-&gt;next_try))</span><br><sp=
an>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    if (!best || reliable_pid_min(e-&gt;packet_id, best-&gt;packet_id))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* oldest =
=3D furthest below rel-&gt;packet_id, within the window */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            const packet_id_type dis=
t =3D subtract_pid(rel-&gt;packet_id, e-&gt;packet_id);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            if (dist &lt;=3D (packet_id=
_type)rel-&gt;size &amp;&amp; dist &gt; best_dist)</span><br><span>        =
     {</span><br><span>                 best =3D e;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                best_dist =3D dist;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            if (!eligible)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                eligible =3D e;</span><br><span=
>             }</span><br><span>         }</span><br><span>     }</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* reli=
able_can_send() promises a non-NULL result for these same entries</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     * without applying the w=
indow bound, and its caller asserts on that, so</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     * never come back empty while one of them =
is eligible=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (!best)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        best =3D elig=
ible;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (be=
st)</span><br><span>     {</span><br><span>         /* The initial timeout =
is bounded by RELIABLE_MAX_INITIAL_TIMEOUT, so</span><br><span>@@ -776,14 +=
760,14 @@</span><br><span>         struct reliable_entry *e =3D &amp;rel-&g=
t;array[i];</span><br><span>         if (buf =3D=3D &amp;e-&gt;buf)</span><=
br><span>         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            /* storable and not yet consumed, checked before touching the e=
ntry */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
ASSERT(reliable_pid_in_range(pid, rel-&gt;packet_id, rel-&gt;size));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         =
    e-&gt;active =3D true;</span><br><span> </span><br><span>             /=
* packets may not arrive in sequential order */</span><br><span>           =
  e-&gt;packet_id =3D pid;</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            /* check for replay */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            ASSERT(!reliable_pid_min(pi=
d, rel-&gt;packet_id));</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span>             e-&gt;opcode =3D opcode;</span><br><span>  =
           e-&gt;next_try =3D 0;</span><br><span>             e-&gt;timeout=
 =3D 0;</span><br><span>diff --git a/src/openvpn/reliable=2Eh b/src/openvpn=
/reliable=2Eh</span><br><span>index a85f2e9=2E=2E04f3372 100644</span><br><=
span>--- a/src/openvpn/reliable=2Eh</span><br><span>+++ b/src/openvpn/relia=
ble=2Eh</span><br><span>@@ -288,15 +288,16 @@</span><br><span> bool reliabl=
e_can_get(const struct reliable *rel);</span><br><span> </span><br><span> /=
**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Check that a rec=
eived packet&#39;s ID is not a replay=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * Check that a received packet&#39;s ID is not a repl=
ay and is inside the receive</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * window=2E</span><br><span>  *</span><br><span>  * @param rel Th=
e reliable structure for handling this VPN tunnel&#39;s</span><br><span>  *=
     received packets=2E</span><br><span>  * @param id The packet ID of the=
 received packet=2E</span><br><span>  *</span><br><span>  * @return</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * @li True, if the packet ID=
 is not a replay=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
 @li False, if the packet ID is a replay=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @li True, if the packet ID is new and inside the=
 receive window=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @li False, if it is a replay, or too far ahead to be stored=2E</span><br>=
<span>  */</span><br><span> bool reliable_not_replay(const struct reliable =
*rel, packet_id_type id);</span><br><span> </span><br><span>diff --git a/te=
sts/unit_tests/openvpn/test_packet_id=2Ec b/tests/unit_tests/openvpn/test_p=
acket_id=2Ec</span><br><span>index aabb555=2E=2Eac6c710 100644</span><br><s=
pan>--- a/tests/unit_tests/openvpn/test_packet_id=2Ec</span><br><span>+++ b=
/tests/unit_tests/openvpn/test_packet_id=2Ec</span><br><span>@@ -517,13 +51=
7,16 @@</span><br><span> }</span><br><span> </span><br><span> /*</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- * Reference implementations of =
the packet id comparisons as they behave today=2E</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * The sweeps below assert reliable=2Ec agrees =
with them at the anchors swept, so</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * a change to an accepted id set there fails a test=2E Keep t=
hem standalone:</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * exp=
ressing them in terms of reliable=2Ec would make the sweeps tautologies=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Independent model=
s of the id sets the packet id comparisons accept=2E The</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * sweeps below assert reliable=2Ec ag=
rees with them at the anchors swept, so a</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * change to an accepted id set there fails a test=2E=
 Each model is tagged</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * &quot;preserved&quot; or &quot;introduced&quot; against the comparison=
s that came before=2E Keep</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * them standalone: expressing them in terms of reliable=2Ec would m=
ake the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * sweeps ta=
utologies=2E</span><br><span>  */</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-/* &quot;p1 &lt; p2&quot; with the 2^31 hor=
izon, i=2Ee=2E ((int32_t)(p1 - p2) &lt; 0) */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/* the dropped reliable_pid_min(): &quot;p1 &lt; =
p2&quot; with the 2^31 horizon,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * i=2Ee=2E ((int32_t)(p1 - p2) &lt; 0) */</span><br><span> sta=
tic bool</span><br><span> ref_pid_min(packet_id_type p1, packet_id_type p2)=
</span><br><span> {</span><br><span>@@ -538,6 +541,7 @@</span><br><span> #d=
efine CHAR_N_SEND_BUFFERS    6</span><br><span> #define CHAR_OPCODE_CONTROL=
_V1 4</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/* preserved: the ids validate_packet_id_window() accepts */</span><br>=
<span> static bool</span><br><span> ref_pid_in_send_window(const struct rel=
iable *rel, packet_id_type pid)</span><br><span> {</span><br><span>@@ -546,=
6 +550,7 @@</span><br><span>     return dist &gt;=3D 1 &amp;&amp; dist &lt;=
=3D CHARACTERIZED_SEND_WINDOW;</span><br><span> }</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/* preserved: reliable_pid_=
in_range2() */</span><br><span> static bool</span><br><span> ref_wont_break=
_sequentiality(const struct reliable *rel, packet_id_type id)</span><br><sp=
an> {</span><br><span>@@ -559,6 +564,7 @@</span><br><span>     return id &l=
t; base + extent;</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/* preserved: the horizon check, then th=
e slot scan */</span><br><span> static bool</span><br><span> ref_not_replay=
(const struct reliable *rel, packet_id_type id)</span><br><span> {</span><b=
r><span>@@ -691,6 +697,54 @@</span><br><span>     }</span><br><span> }</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Onc=
e rel-&gt;packet_id + rel-&gt;size overflows, the absolute clause makes</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * reliable_wont_break_=
sequentiality() permissive; what may be stored is still</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * the receive window, which wraps with=
 it=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static voi=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_recv_window_b=
ounded_at_wrap(void **state)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t reliable rel =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    rel=2Esize =3D RELIABLE_CAPACITY;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    rel=2Epacket_id =3D 0xFFFFFFF8;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_int_equal(RECV_STORE, recv_filter(&amp;rel,=
 0xFFFFFFF8));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_int_equal(RECV_STORE, recv_filter(&amp;rel, 0xFFFFFFFF));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(RECV_STORE=
, recv_filter(&amp;rel, 3));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* one=
 past the window, and one behind it: acknowledged, never stored */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(RECV_AC=
K_ONLY, recv_filter(&amp;rel, 4));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_int_equal(RECV_ACK_ONLY, recv_filter(&amp;rel, 0x=
FFFFFFF7));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/* The id the receiver is next waiting for ha=
s to be storable at every base,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * the packet id wrap included=2E */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+test_wont_break_sequentiality_accepts_next_id(void **s=
tate)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    const packet_id_type bases[]=
 =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        0,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        1,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        500,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        0x7FFFFFFF,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        0x80000000,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        0xFFFFFFF3,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        0xFFFFFFF4,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        0xFFFFFFF8,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        0xFFFFFFFE,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        0xFFFFFFFF,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    for (size_t i =3D 0; i &lt; SIZE(bases); i++)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        struct reliable rel =3D { 0 };</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        rel=2Esize =3D RELIABLE_CAP=
ACITY;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        rel=
=2Epacket_id =3D bases[i];</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        asse=
rt_true(reliable_wont_break_sequentiality(&amp;rel, rel=2Epacket_id));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_true(reli=
able_not_replay(&amp;rel, rel=2Epacket_id));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span> /* bases at or below 2^31, where old and new agree; never to cha=
nge */</span><br><span> static void</span><br><span> test_recv_filter_chara=
cterization(void **state)</span><br><span>@@ -698,12 +752,31 @@</span><br><=
span>     sweep_recv_filter(char_anchors, SIZE(char_anchors), ref_recv_filt=
er);</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/* Introduced, for the bases above 2^31 only: storing=
 also requires the id to</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * be inside the receive window=2E The ids between one further ahead a=
nd</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * rel-&gt;packet=
_id cannot all fit alongside it, so rel-&gt;packet_id never reaches</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * it and the slot is held =
for the rest of the key state=2E Still ACKed, like a</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * replay=2E */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static enum recv_verdict</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ref_recv_filter_bounded(const struct rel=
iable *rel, packet_id_type id)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st enum recv_verdict verdict =3D ref_recv_filter(rel, id);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (verdict =3D=3D RECV_STORE</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; (packet_id_type)(id - =
rel-&gt;packet_id) &gt;=3D (packet_id_type)rel-&gt;size)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        return RECV_ACK_ONLY;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    return verdict;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
 /* bases above 2^31, where they diverge, kept apart so a change confined</=
span><br><span>  * there touches one test */</span><br><span> static void</=
span><br><span> test_recv_filter_high_base(void **state)</span><br><span> {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    sweep_recv_filter=
(char_anchors_high, SIZE(char_anchors_high), ref_recv_filter);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    sweep_recv_filter(char_ancho=
rs_high, SIZE(char_anchors_high), ref_recv_filter_bounded);</span><br><span=
> }</span><br><span> </span><br><span> static void</span><br><span>@@ -739,=
6 +812,60 @@</span><br><span>     sweep_send_window(char_anchors_high, SIZE=
(char_anchors_high));</span><br><span> }</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/* The window bound in the selection=
 is what stops an entry sitting ahead of</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * rel-&gt;packet_id from being taken for the oldest o=
ne: its distance below</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * rel-&gt;packet_id is then nearly the whole id space=2E array[0] canno=
t arise</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * through t=
he API; array[1] is an ordinary outstanding packet=2E */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+test_reliable_send_ignores_entry_ahead(void **=
state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    now =3D 1000;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct reliable rel =3D { 0 };</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    rel=2Esize =3D CHAR_N_SEND_BUFFER=
S;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rel=2Einitial=
_timeout =3D 2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
rel=2Epacket_id =3D 3;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* scanned f=
irst, and outside the window */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    rel=2Earray[0]=2Eactive =3D true;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    rel=2Earray[0]=2Epacket_id =3D 0x40000000=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rel=2Earray[0]=
=2Etimeout =3D 2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  rel=2Earray[0]=2Enext_try =3D 0;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* a genuine outstanding packet, two below rel-&gt;packet_id */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    rel=2Earray[1]=2Eactive =3D=
 true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rel=2Earr=
ay[1]=2Epacket_id =3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    rel=2Earray[1]=2Etimeout =3D 2;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    rel=2Earray[1]=2Enext_try =3D 0;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    int opcode =3D 0;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_ptr_equal(&amp;rel=2Earray[1]=2Ebuf, reliab=
le_send(&amp;rel, &amp;opcode));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/* reliable_can_send() p=
romises reliable_send() will hand back a buffer, and</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * its caller asserts on that=2E The stat=
e below cannot arise through the API --</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * the entry sits outside the send window -- but the tw=
o must not be able to</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * disagree=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_rel=
iable_send_matches_can_send(void **state)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    now =3D 1000;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct reliab=
le rel =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  rel=2Esize =3D CHAR_N_SEND_BUFFERS;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    rel=2Einitial_timeout =3D 2;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    rel=2Epacket_id =3D 3;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    rel=2Earray[0]=2Eactive =3D true;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    rel=2Earray[0]=2Epacket_id =3D 0x4=
0000000;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rel=2Ea=
rray[0]=2Etimeout =3D 2;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    rel=2Earray[0]=2Enext_try =3D 0;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    int opcode =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_true(reliable_can_send(&amp;rel));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_non_null(reliable_send(&amp;rel, =
&amp;opcode));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* re=
liable_send() picks the oldest eligible entry, across the wrap and the</spa=
n><br><span>  * signed midpoint */</span><br><span> static void</span><br><=
span>@@ -880,10 +1007,14 @@</span><br><span>         cmocka_unit_test(test_=
reliable_backoff_is_bounded),</span><br><span>         cmocka_unit_test(tes=
t_reliable_purge_ignores_forged_acks),</span><br><span>         cmocka_unit=
_test(test_reliable_purge_legitimate_ack),</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        cmocka_unit_test(test_wont_break_sequentiali=
ty_accepts_next_id),</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        cmocka_unit_test(test_recv_window_bounded_at_wrap),</span><br><spa=
n>         cmocka_unit_test(test_recv_filter_characterization),</span><br><=
span>         cmocka_unit_test(test_recv_filter_high_base),</span><br><span=
>         cmocka_unit_test(test_send_window_characterization),</span><br><s=
pan>         cmocka_unit_test(test_reliable_send_picks_oldest),</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_r=
eliable_send_ignores_entry_ahead),</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        cmocka_unit_test(test_reliable_send_matches_can_send=
),</span><br><span>         cmocka_unit_test(test_get_buf_output_sequenced_=
boundary),</span><br><span>         cmocka_unit_test(test_mark_active_incom=
ing_accepts_window),</span><br><span> #ifndef _MSC_VER</span><br></pre><p>T=
o view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1900?us=
p=3Demail">change 1900</a>=2E To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">=
settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vie=
wAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1900?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Iaaa0af7d678eb447bc93741add8120d9f348d9eb </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1900 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--3VhNgTtkzws=--


--===============2078631354693651566==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2078631354693651566==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2078631354693651566==--

