Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC0FDCA9EC7
	for <openvpn-devel@archiver.kernel.org>; Sun, 11 Oct 2026 15:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ePuMGnb4Lx5ZBsBAs6EJ6vqd0FOFvlFALJqohMlmqhU=; b=GmFd+usgp9XpaQ2Un9S7jaNXcp
	e185XgWpfY83JhDrki82060ZWhxtkoWhtQO/sPVbLG3r/hj0QI4MZD7t7hQHwz7kSOKPdxwKmhB+v
	QU2Ss20T+JJJT+io+s+8HhvjDfKC9qSvnFWz/RXQBY4zcjjxxftkBI5FseK1ms3Cpa+A=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xFvww-0007hJ-IZ;
	Sun, 11 Oct 2026 15:58:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xFvwv-0007hC-G4
 for openvpn-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 15:58:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=FIW7cs3i+wIzard2L3YFEnkqsH3Fm7ypSnjCG7XONmI=; b=EUNe+1jxOkH4BSFZmpuJ1r4mH2
 u4sFTHkYizl70DQztksknFEPG/60S9x53t6hIaFkNgFs2Y0ytGmwcx61kPih77TDzYcofkbsYod9E
 Pc9Ojfoz50nIXy6NgCHCNNE8S0a+Z+LTyHsQMZLWDDoYoeZJOF7CwT+s+84q3WTFyJhg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=FIW7cs3i+wIzard2L3YFEnkqsH3Fm7ypSnjCG7XONmI=; b=k
 srkNSjkEYiV5VqqCzZTVBj4xmBagiCXypwY0fq6yNJqe0uztM3lTECnppsMb6DId8RST8aqAowtrb
 PoWncQrfmvw3pNoK0TyI+6nYm0qU51dGE88G8W0cgArWpEhwoelnH0sfgLwALh0Q/4v0e58qYv0e4
 XrENVetYoa6KsrP8=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xFvws-0006wU-3v for openvpn-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 15:58:57 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a02753c04fso5763965e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 11 Oct 2026 08:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791734327; x=1792339127; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FIW7cs3i+wIzard2L3YFEnkqsH3Fm7ypSnjCG7XONmI=;
 b=ds15Pes538Nb/51g1jci9Gocw/Lo/YrQqYcf2DPeKbvpjdRf1iDPlrE52MbCiBDFWe
 Hp3Ls+v+nFWBxpD7Oyz1Cz0G7uNycB663C2Z9xA+sEIlcjRT2dqz7NzH+iWOzxiLm2yi
 1OrVJCvWMKQGqSevDtfZo1slPGZ4MRSAVsKgSDR0i9KxjCK+xez5oJakl07LAb4j8c0p
 /AF2lg7j/ZB9hWRcDru5qY5M86bisraVqIiT8LbSGfA2wdWuyBgzvHP2iHEsAMcmjph9
 eVmtyvKu/Og7qjEYFTX7FWkbC7FkDPFy+Cmx32xzAxj8FU20XQlCl2ql7HIDFOR4hsfw
 QLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791734327; x=1792339127;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=FIW7cs3i+wIzard2L3YFEnkqsH3Fm7ypSnjCG7XONmI=;
 b=d3Kdg5fN4DuKD2M2QWywiO8N5FqZx+hhOJR/yHn6bHmRRE9aykR8PZCH2A3d72tAuv
 Nb7MWw5i4Oyiv1W9P+u4MBCc0h+LsTi4vxK9yGXgitrIFxGBLGnp1xTxfYd8yRMdl1Xd
 Cq9PriccfmhWYHb094kfZeTBUil0v8MyjRniFLcIMxGYeOrrAOGZ2WHuXmHqcMqfdlci
 MeGD02dirPTPlX3I3BDe2NxjeWjqrPZAqyeB1HuAFyDnTKMiQPET12kQIYlG0zRzGXVC
 unSziIqIcMwvBUVI8+COKpGBSBeVV6ALS8MFaMVDwbmeflQhxhx2bOwuk30PMfJA3Iqs
 T8Pg==
X-Gm-Message-State: AFq9FYJYhkF4TIRn6HNXbx8ru020BjQP7RCeU5nm03xAVAmjGgC7tZMS
 OJb+QcwM2dppfj/m/SDgvQbMNohVtOyqqm57DTOmabCSrEN//I7ZL+VH//+y/I0O7qfVjIUmM8p
 33zTSfRiJ7M3wKC0N+pYFxXNw0BKl7ybP2Es5HRibXIyiJA6AksH3IEpuDYkdrPsGXtSDabaUHf
 8BzuMVIw==
X-Gm-Gg: AYBFou27a7nr/t/oo457WhRe1Vq1Wm31xs4ic+6cBRKtH+Og1yYcq6o+ylB3VXh84Xa
 pm8x6S/Xv3YiICwxhWXCJLnFwgu+/kl7WahF/wZsA3gD90e2vf628GROrSoITUfpAb5rm6YI2kg
 bnNQIzIuuMHO9Ochc7QPv/5eshd8arEMHsH08uV++UioANipUczFzn2E4tCXhqctmP9Eoi2LK88
 7ZweT/euGUEoP8WainQKFKNyn/HXkqoDhmlT3m8i3ua7PvDYPVOVeeReVBErsIUtnsUhjV5FL31
 uk0MlSJeQEsvzz4pNl2geOvXXo1xXAGYjZTFTt2AuIsxUG2rmo4XC4XgFKtCs7ndi7U45gY4fDU
 CuIlKfF6b+TvQgws150U33HWd5XqD9X2ricNlckknYSRNNlh7woMNpFLdmkua6QhPF81yElh7LX
 qp+omAt+Tf7mdG9Vzqy/hMO+5HNFh/zp2wSeVZOq9fd/Y5GBa7VCxhtbYEJSsu0CUToQkx1PE2E
 FB1sl45JY2Dq/82Au4kBbnFBNvo7mnkWIdbIWw8B/C2zJM8UBs3G8UahIc14+r0fn8D6g9lt0wo
 QngDM7Ua4ssUOA9mu3lwEhCjPlj5RSvUgYwVeeP8keSY63hnpEpxTgeyPxtC
X-Received: by 2002:a05:600c:3e0f:b0:4a0:1b21:2628 with SMTP id
 5b1f17b1804b1-4a18e4b60d8mr131950035e9.23.1791734327097; 
 Sun, 11 Oct 2026 08:58:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be97d1esm348051845e9.8.2026.10.11.08.58.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 08:58:46 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 11 Oct 2026 15:58:45 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Iaaa0af7d678eb447bc93741add8120d9f348d9eb
X-Gerrit-Change-Number: 1900
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1900?usp=email>
X-Gerrit-Commit: 2318e3366392d0d066c2a8cfa1b3d1f332935334
In-Reply-To: <gerrit.1788765781000.Iaaa0af7d678eb447bc93741add8120d9f348d9eb@gerrit.openvpn.net>
References: <gerrit.1788765781000.Iaaa0af7d678eb447bc93741add8120d9f348d9eb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NzY1NzgxMDAwLklhYWEwYWY3ZDY3OGViNDQ3YmM5Mzc0MWFkZDgxMjBkOWYzNDhkOWViQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e63e67c5852a6ffd1aeed78cf8bb245af0af3ded-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xFvws-0006wU-3v
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5846495029566629889=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5846495029566629889==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FO/rhiRuHGc="; charset=UTF-8

--FO/rhiRuHGc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#4) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1900?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Arne Schwabe


Change subject: reliable: drop the half-s=
pace packet id comparisons
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


  git pull ssh://gerrit=2Eopenvpn=2Enet:29=
418/openvpn refs/changes/00/1900/4

diff --git a/src/openvpn/reliable=2Ec b=
/src/openvpn/reliable=2Ec
index b5315ff=2E=2E645fbfd 100644
--- a/src/openv=
pn/reliable=2Ec
+++ b/src/openvpn/reliable=2Ec
@@ -50,46 +50,12 @@
  * veri=
fy that test - base < extent while allowing for base or test wraparound
  *=
/
 static inline bool
-reliable_pid_in_range1(const packet_id_type test, co=
nst packet_id_type base,
-                       const unsigned int extent)=

+reliable_pid_in_range(const packet_id_type test, const packet_id_type bas=
e,
+                      const unsigned int extent)
 {
     return subtrac=
t_pid(test, base) < extent;
 }
 
-/*
- * verify that test < base + extent w=
hile allowing for base or test wraparound
- */
-static inline bool
-reliabl=
e_pid_in_range2(const packet_id_type test, const packet_id_type base,
-    =
                   const unsigned int extent)
-{
-    if (base + extent >=
=3D base)
-    {
-        if (test < base + extent)
-        {
-           =
 return true;
-        }
-    }
-    else
-    {
-        if ((test + 0x800=
00000u) < (base + 0x80000000u) + extent)
-        {
-            return tru=
e;
-        }
-    }
-
-    return false;
-}
-
-/*
- * verify that p1 < p2 =
 while allowing for p1 or p2 wraparound
- */
-static inline bool
-reliable_=
pid_min(const packet_id_type p1, const packet_id_type p2)
-{
-    return !r=
eliable_pid_in_range1(p1, p2, 0x80000000u);
-}
-
 /* check if a particular =
packet_id is present in ack */
 static inline bool
 reliable_ack_packet_id_=
present(struct reliable_ack *ack, packet_id_type pid)
@@ -393,8 +359,9 @@
 =
int
 validate_packet_id_window(struct reliable *rel, packet_id_type pid)
 {=

-    return reliable_pid_min(pid, rel->packet_id)
-           && reliable_=
pid_min(subtract_pid(rel->packet_id, RELIABLE_CAPACITY), pid);
+    const p=
acket_id_type dist =3D subtract_pid(rel->packet_id, pid);
+
+    return dis=
t > 0 && dist < RELIABLE_CAPACITY;
 }
 
 /* del acknowledged items from sen=
d buf */
@@ -440,14 +407,17 @@
                 e->active =3D false;
      =
       }
 
-            if (e->active && reliable_pid_min(e->packet_id, pid=
))
+            /* Order the two by their distance below rel->packet_id, as=

+             * comparing the ids directly misorders them across the wrap=
=2E
+             * Entries further back than rel->size are outside the sen=
d window
+             * and left alone=2E An ACK for a higher pid means th=
is packet
+             * arrived out of order or was lost, and enough of t=
hem trigger
+             * the early resend=2E */
+            const packe=
t_id_type e_dist =3D subtract_pid(rel->packet_id, e->packet_id);
+
+       =
     if (e->active && e_dist <=3D (packet_id_type)rel->size
+              =
  && e_dist > subtract_pid(rel->packet_id, pid))
             {
-          =
      /* We have received an ACK for a packet with a higher PID=2E Either
-=
                 * we have received ACKs out of or order or the packet has =
been
-                 * lost=2E We count the number of ACKs to determine i=
f we should
-                 * resend it early=2E The comparison needs to =
be wraparound aware,
-                 * otherwise a peer can inflate n_ack=
s with an ACK for a pid from
-                 * the lower half of the id s=
pace and force a retransmit=2E */
                 e->n_acks++;
           =
  }
         }
@@ -505,7 +475,9 @@
 reliable_not_replay(const struct reliab=
le *rel, packet_id_type id)
 {
     struct gc_arena gc =3D gc_new();
-    i=
f (reliable_pid_min(id, rel->packet_id))
+
+    /* outside the receive wind=
ow: already consumed, or too far ahead to store */
+    if (!reliable_pid_i=
n_range(id, rel->packet_id, rel->size))
     {
         goto bad;
     }
@@=
 -531,7 +503,12 @@
 bool
 reliable_wont_break_sequentiality(const struct re=
liable *rel, packet_id_type id)
 {
-    const int ret =3D reliable_pid_in_r=
ange2(id, rel->packet_id, rel->size);
+    /* The first clause is the recei=
ve window=2E The second is an absolute
+     * comparison, kept so that alr=
eady consumed ids still reach
+     * reliable_ack_acknowledge_packet_id() =
and a peer whose ACK was lost stops
+     * retransmitting; reliable_not_re=
play() rejects them=2E */
+    const bool ret =3D (subtract_pid(id, rel->pa=
cket_id) < (packet_id_type)rel->size
+                      || id < rel->pa=
cket_id);
 
     if (!ret)
     {
@@ -562,57 +539,46 @@
     return NULL;
 =
}
 
-int
-reliable_get_num_output_sequenced_available(struct reliable *rel)=

+/* Distance below rel->packet_id of the oldest unacknowledged entry, 0 if=
 there
+ * is none=2E Entries more than rel->size away are outside the sequ=
encing window
+ * and ignored, rather than taken for very old ones=2E */
+s=
tatic packet_id_type
+reliable_oldest_active_distance(const struct reliable=
 *rel)
 {
-    packet_id_type min_id =3D 0;
-    bool min_id_defined =3D fa=
lse;
+    packet_id_type max_dist =3D 0;
 
-    /* find minimum active pack=
et_id */
     for (int i =3D 0; i < rel->size; ++i)
     {
         const s=
truct reliable_entry *e =3D &rel->array[i];
-        if (e->active)
+      =
  if (!e->active)
         {
-            if (!min_id_defined || reliable_p=
id_min(e->packet_id, min_id))
-            {
-                min_id_define=
d =3D true;
-                min_id =3D e->packet_id;
-            }
+     =
       continue;
+        }
+
+        const packet_id_type dist =3D subtra=
ct_pid(rel->packet_id, e->packet_id);
+        if (dist <=3D (packet_id_typ=
e)rel->size && dist > max_dist)
+        {
+            max_dist =3D dist;
=
         }
     }
 
-    int ret =3D rel->size;
-    if (min_id_defined)
- =
   {
-        ret -=3D subtract_pid(rel->packet_id, min_id);
-    }
-    re=
turn ret;
+    return max_dist;
+}
+
+int
+reliable_get_num_output_sequence=
d_available(struct reliable *rel)
+{
+    return rel->size - (int)reliable_=
oldest_active_distance(rel);
 }
 
 /* grab a free buffer, fail if buffer cl=
ogged by unacknowledged low packet IDs */
 struct buffer *
 reliable_get_bu=
f_output_sequenced(struct reliable *rel)
 {
-    packet_id_type min_id =3D =
0;
-    bool min_id_defined =3D false;
     struct buffer *ret =3D NULL;
 
=
-    /* find minimum active packet_id */
-    for (int i =3D 0; i < rel->si=
ze; ++i)
-    {
-        const struct reliable_entry *e =3D &rel->array[i];=

-        if (e->active)
-        {
-            if (!min_id_defined || rel=
iable_pid_min(e->packet_id, min_id))
-            {
-                min_id=
_defined =3D true;
-                min_id =3D e->packet_id;
-            }=

-        }
-    }
-
-    if (!min_id_defined || reliable_pid_in_range1(rel=
->packet_id, min_id, rel->size))
+    /* keep the next id within rel->size =
of the oldest unacknowledged one */
+    if (reliable_oldest_active_distanc=
e(rel) < (packet_id_type)rel->size)
     {
         ret =3D reliable_get_bu=
f(rel);
     }
@@ -671,6 +637,8 @@
 reliable_send(struct reliable *rel, int=
 *opcode)
 {
     struct reliable_entry *best =3D NULL;
+    struct reliabl=
e_entry *eligible =3D NULL;
+    packet_id_type best_dist =3D 0;
     const=
 time_t local_now =3D now;
 
     for (int i =3D 0; i < rel->size; ++i)
@@ =
-682,13 +650,29 @@
          * not expired yet=2E */
         if (e->active=
 && (e->n_acks >=3D N_ACK_RETRANSMIT || local_now >=3D e->next_try))
      =
   {
-            if (!best || reliable_pid_min(e->packet_id, best->packet_=
id))
+            /* oldest =3D furthest below rel->packet_id, within the w=
indow */
+            const packet_id_type dist =3D subtract_pid(rel->packe=
t_id, e->packet_id);
+            if (dist <=3D (packet_id_type)rel->size &=
& dist > best_dist)
             {
                 best =3D e;
+          =
      best_dist =3D dist;
+            }
+
+            if (!eligible)
+   =
         {
+                eligible =3D e;
             }
         }
     =
}
 
+    /* reliable_can_send() promises a non-NULL result for these same e=
ntries
+     * without applying the window bound, and its caller asserts on=
 that, so
+     * never come back empty while one of them is eligible=2E */=

+    if (!best)
+    {
+        best =3D eligible;
+    }
+
     if (best)=

     {
         /* The initial timeout is bounded by RELIABLE_MAX_INITIAL_=
TIMEOUT, so
@@ -776,14 +760,14 @@
         struct reliable_entry *e =3D &re=
l->array[i];
         if (buf =3D=3D &e->buf)
         {
+            /* st=
orable and not yet consumed, checked before touching the entry */
+        =
    ASSERT(reliable_pid_in_range(pid, rel->packet_id, rel->size));
+
      =
       e->active =3D true;
 
             /* packets may not arrive in sequ=
ential order */
             e->packet_id =3D pid;
 
-            /* check =
for replay */
-            ASSERT(!reliable_pid_min(pid, rel->packet_id));
=
-
             e->opcode =3D opcode;
             e->next_try =3D 0;
      =
       e->timeout =3D 0;
diff --git a/src/openvpn/reliable=2Eh b/src/openvp=
n/reliable=2Eh
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

Gerrit-MessageType: newpatchse=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iaaa0af7d=
678eb447bc93741add8120d9f348d9eb
Gerrit-Change-Number: 1900
Gerrit-PatchSet=
: 4
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Revie=
wer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <op=
envpn-devel@lists=2Esourceforge=2Enet>

--FO/rhiRuHGc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #4</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1900?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Arne Schwabe</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">rel=
iable: drop the half-space packet id comparisons<br><br>Every comparison be=
comes a modular distance against a stated bound=2E<br>subtract_pid() stays =
and reliable_pid_in_range1() loses its suffix;<br>reliable_pid_min() and re=
liable_pid_in_range2() go, and with them the last<br>0x80000000 in the file=
=2E<br><br>The three scans for the oldest unacknowledged entry now track th=
e largest<br>distance below rel-&gt;packet_id, bounded by rel-&gt;size, in<=
br>reliable_oldest_active_distance()=2E reliable_wont_break_sequentiality()=
 bounds<br>the distance ahead and accepts past ids outright, as the old com=
parison did<br>without the 0x80000000 bias=2E<br><br>reliable_can_send() co=
unts the same entries without the window bound and its<br>caller asserts on=
 the result, so reliable_send() falls back to any eligible<br>entry when th=
e bound leaves nothing=2E<br><br>Equivalent for every reachable input=2E Fo=
ur deliberate differences:<br><br>- Once rel-&gt;packet_id + rel-&gt;size o=
verflows, the absolute clause makes<br>  reliable_wont_break_sequentiality(=
) permissive: ids the old bias branch<br>  rejected are acknowledged=2E Not=
hing more is stored, reliable_not_replay()<br>  still bounding that to the =
receive window, which wraps with rel-&gt;packet_id=2E<br>  Needs ~2^32 cont=
rol channel packets in one key state=2E<br>- Above 2^31, an id absolutely b=
elow rel-&gt;packet_id + rel-&gt;size but more than<br>  rel-&gt;size ahead=
 is acknowledged and no longer stored: it can never equal<br>  rel-&gt;pack=
et_id, so its slot was held for the rest of the key state=2E Needs<br>  ~2^=
31 such packets; test_recv_filter_high_base&#39;s oracle switches to the ne=
w<br>  rule there, pinning behaviour rather than equivalence=2E<br>- The AS=
SERT in reliable_mark_active_incoming() is the receive window rather<br>  t=
han a half space, and runs before the entry is touched=2E Unobservable: it<=
br>  repeats the check reliable_not_replay() makes immediately before it=2E=
<br>- A send entry more than rel-&gt;size below rel-&gt;packet_id is ignore=
d by the<br>  scans instead of taken for a very old one, so<br>  reliable_g=
et_num_output_sequenced_available() can no longer go negative=2E<br>  relia=
ble_get_buf_output_sequenced() keeps every distance within rel-&gt;size,<br=
>  so it never could=2E<br><br>Change-Id: Iaaa0af7d678eb447bc93741add8120d9=
f348d9eb<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br=
>Acked-by: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Gerrit URL: h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1900<br>Message-Id: &lt;202610082=
05143=2E28452-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-arch=
ive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39796=2Ehtml<br>Signed=
-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openv=
pn/reliable=2Ec<br>M src/openvpn/reliable=2Eh<br>M tests/unit_tests/openvpn=
/test_packet_id=2Ec<br>3 files changed, 210 insertions(+), 94 deletions(-)<=
br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/open=
vpn refs/changes/00/1900/4</pre><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/reliable=2Ec b/=
src/openvpn/reliable=2Ec</span><br><span>index b5315ff=2E=2E645fbfd 100644<=
/span><br><span>--- a/src/openvpn/reliable=2Ec</span><br><span>+++ b/src/op=
envpn/reliable=2Ec</span><br><span>@@ -50,46 +50,12 @@</span><br><span>  * =
verify that test - base &lt; extent while allowing for base or test wraparo=
und</span><br><span>  */</span><br><span> static inline bool</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-reliable_pid_in_range1(const packet_=
id_type test, const packet_id_type base,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                       const unsigned int extent)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+reliable_pid_in_range(cons=
t packet_id_type test, const packet_id_type base,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                      const unsigned int exte=
nt)</span><br><span> {</span><br><span>     return subtract_pid(test, base)=
 &lt; extent;</span><br><span> }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * verify that test &lt; base + extent while allowing for base or=
 test wraparound</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline bool</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-reliable_pid_in_range2(con=
st packet_id_type test, const packet_id_type base,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                       const unsigned int exte=
nt)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    if (base + extent &gt;=3D base)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        if (test &lt; base + extent)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            return true;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if ((tes=
t + 0x80000000u) &lt; (base + 0x80000000u) + extent)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            return true;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    return false;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * verify that =
p1 &lt; p2  while allowing for p1 or p2 wraparound</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-static inline bool</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-reliable_pid_min(const packet_id_type p1, const packet_id_type p2)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    return !reliable_pid_in_range1(p1, p2,=
 0x80000000u);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /* check =
if a particular packet_id is present in ack */</span><br><span> static inli=
ne bool</span><br><span> reliable_ack_packet_id_present(struct reliable_ack=
 *ack, packet_id_type pid)</span><br><span>@@ -393,8 +359,9 @@</span><br><s=
pan> int</span><br><span> validate_packet_id_window(struct reliable *rel, p=
acket_id_type pid)</span><br><span> {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    return reliable_pid_min(pid, rel-&gt;packet_id)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-           &amp;&amp; reliabl=
e_pid_min(subtract_pid(rel-&gt;packet_id, RELIABLE_CAPACITY), pid);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    const packet_id_type di=
st =3D subtract_pid(rel-&gt;packet_id, pid);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return dist &gt; 0 &amp;&amp; dist &lt; RELIABLE_CAPACITY;</span>=
<br><span> }</span><br><span> </span><br><span> /* del acknowledged items f=
rom send buf */</span><br><span>@@ -440,14 +407,17 @@</span><br><span>     =
            e-&gt;active =3D false;</span><br><span>             }</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
if (e-&gt;active &amp;&amp; reliable_pid_min(e-&gt;packet_id, pid))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            /* Order the tw=
o by their distance below rel-&gt;packet_id, as</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+             * comparing the ids directly misor=
ders them across the wrap=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+             * Entries further back than rel-&gt;size are outside =
the send window</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
         * and left alone=2E An ACK for a higher pid means this packet</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+             * arrived o=
ut of order or was lost, and enough of them trigger</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+             * the early resend=2E */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            const packe=
t_id_type e_dist =3D subtract_pid(rel-&gt;packet_id, e-&gt;packet_id);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (e-&gt;active &amp;&amp; e=
_dist &lt;=3D (packet_id_type)rel-&gt;size</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                &amp;&amp; e_dist &gt; subtract_pid(=
rel-&gt;packet_id, pid))</span><br><span>             {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                /* We have received an AC=
K for a packet with a higher PID=2E Either</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                 * we have received ACKs out of or ord=
er or the packet has been</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                 * lost=2E We count the number of ACKs to determine if =
we should</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
     * resend it early=2E The comparison needs to be wraparound aware,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                 * otherwi=
se a peer can inflate n_acks with an ACK for a pid from</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                 * the lower half of the =
id space and force a retransmit=2E */</span><br><span>                 e-&g=
t;n_acks++;</span><br><span>             }</span><br><span>         }</span=
><br><span>@@ -505,7 +475,9 @@</span><br><span> reliable_not_replay(const s=
truct reliable *rel, packet_id_type id)</span><br><span> {</span><br><span>=
     struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (reliable_pid_min(id, rel-&gt;packet_id))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* outside the receive window: already consum=
ed, or too far ahead to store */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (!reliable_pid_in_range(id, rel-&gt;packet_id, rel-&gt;=
size))</span><br><span>     {</span><br><span>         goto bad;</span><br>=
<span>     }</span><br><span>@@ -531,7 +503,12 @@</span><br><span> bool</sp=
an><br><span> reliable_wont_break_sequentiality(const struct reliable *rel,=
 packet_id_type id)</span><br><span> {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    const int ret =3D reliable_pid_in_range2(id, rel-&gt;p=
acket_id, rel-&gt;size);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /* The first clause is the receive window=2E The second is an abso=
lute</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * comparis=
on, kept so that already consumed ids still reach</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     * reliable_ack_acknowledge_packet_id() a=
nd a peer whose ACK was lost stops</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * retransmitting; reliable_not_replay() rejects them=2E=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const bool r=
et =3D (subtract_pid(id, rel-&gt;packet_id) &lt; (packet_id_type)rel-&gt;si=
ze</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
     || id &lt; rel-&gt;packet_id);</span><br><span> </span><br><span>     =
if (!ret)</span><br><span>     {</span><br><span>@@ -562,57 +539,46 @@</spa=
n><br><span>     return NULL;</span><br><span> }</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-reliable_get_num_output_sequenced_available(stru=
ct reliable *rel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
 Distance below rel-&gt;packet_id of the oldest unacknowledged entry, 0 if =
there</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * is none=2E =
Entries more than rel-&gt;size away are outside the sequencing window</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * and ignored, rather th=
an taken for very old ones=2E */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+static packet_id_type</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+reliable_oldest_active_distance(const struct reliable *rel)<=
/span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 packet_id_type min_id =3D 0;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    bool min_id_defined =3D false;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    packet_id_type max_dist =3D 0;</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* find minimum a=
ctive packet_id */</span><br><span>     for (int i =3D 0; i &lt; rel-&gt;si=
ze; ++i)</span><br><span>     {</span><br><span>         const struct relia=
ble_entry *e =3D &amp;rel-&gt;array[i];</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        if (e-&gt;active)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if (!e-&gt;active)</span><br><span>        =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (!mi=
n_id_defined || reliable_pid_min(e-&gt;packet_id, min_id))</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                min_id_defined =3D true;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                min_id =3D =
e-&gt;packet_id;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 continue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        const packet_id_type dist =3D =
subtract_pid(rel-&gt;packet_id, e-&gt;packet_id);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (dist &lt;=3D (packet_id_type)rel-=
&gt;size &amp;&amp; dist &gt; max_dist)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            max_dist =3D dist;</span><br><span>         }</span><=
br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    int ret =3D rel-&gt;size;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    if (min_id_defined)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        ret -=3D subtract_pid(rel-&gt;packet_id, min_id);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    return ret;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    return max_dist;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+reliable_get_num_output_sequen=
ced_available(struct reliable *rel)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return rel-&gt;size - (int)reliable_oldest_active_distance(rel);</span><b=
r><span> }</span><br><span> </span><br><span> /* grab a free buffer, fail i=
f buffer clogged by unacknowledged low packet IDs */</span><br><span> struc=
t buffer *</span><br><span> reliable_get_buf_output_sequenced(struct reliab=
le *rel)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    packet_id_type min_id =3D 0;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    bool min_id_defined =3D false;</span><br><span>     st=
ruct buffer *ret =3D NULL;</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    /* find minimum active packet_id */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    for (int i =3D 0; i &lt; rel-&=
gt;size; ++i)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        const struct rel=
iable_entry *e =3D &amp;rel-&gt;array[i];</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        if (e-&gt;active)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            if (!min_id_defined || reliable_pid_min(e-&gt;packe=
t_id, min_id))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 min_id_defined =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                min_id =3D e-&gt;packet_id;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    if (!min_id_defined || reli=
able_pid_in_range1(rel-&gt;packet_id, min_id, rel-&gt;size))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* keep the next id within rel=
-&gt;size of the oldest unacknowledged one */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (reliable_oldest_active_distance(rel) &lt;=
 (packet_id_type)rel-&gt;size)</span><br><span>     {</span><br><span>     =
    ret =3D reliable_get_buf(rel);</span><br><span>     }</span><br><span>@=
@ -671,6 +637,8 @@</span><br><span> reliable_send(struct reliable *rel, int=
 *opcode)</span><br><span> {</span><br><span>     struct reliable_entry *be=
st =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct reliable_entry *eligible =3D NULL;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    packet_id_type best_dist =3D 0;</span><br><span>    =
 const time_t local_now =3D now;</span><br><span> </span><br><span>     for=
 (int i =3D 0; i &lt; rel-&gt;size; ++i)</span><br><span>@@ -682,13 +650,29=
 @@</span><br><span>          * not expired yet=2E */</span><br><span>     =
    if (e-&gt;active &amp;&amp; (e-&gt;n_acks &gt;=3D N_ACK_RETRANSMIT || l=
ocal_now &gt;=3D e-&gt;next_try))</span><br><span>         {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            if (!best || reliable_pi=
d_min(e-&gt;packet_id, best-&gt;packet_id))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            /* oldest =3D furthest below rel-&gt;pa=
cket_id, within the window */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            const packet_id_type dist =3D subtract_pid(rel-&gt;pa=
cket_id, e-&gt;packet_id);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            if (dist &lt;=3D (packet_id_type)rel-&gt;size &amp;&amp;=
 dist &gt; best_dist)</span><br><span>             {</span><br><span>      =
           best =3D e;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                best_dist =3D dist;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      if (!eligible)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           eligible =3D e;</span><br><span>             }</span><br><span> =
        }</span><br><span>     }</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* reliable_can_send() promises a non-NU=
LL result for these same entries</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+     * without applying the window bound, and its caller asser=
ts on that, so</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
* never come back empty while one of them is eligible=2E */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (!best)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        best =3D eligible;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span>     if (best)</span><br><span>     {</span>=
<br><span>         /* The initial timeout is bounded by RELIABLE_MAX_INITIA=
L_TIMEOUT, so</span><br><span>@@ -776,14 +760,14 @@</span><br><span>       =
  struct reliable_entry *e =3D &amp;rel-&gt;array[i];</span><br><span>     =
    if (buf =3D=3D &amp;e-&gt;buf)</span><br><span>         {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            /* storable and not y=
et consumed, checked before touching the entry */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            ASSERT(reliable_pid_in_range(pid,=
 rel-&gt;packet_id, rel-&gt;size));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span>             e-&gt;active =3D true;</span>=
<br><span> </span><br><span>             /* packets may not arrive in seque=
ntial order */</span><br><span>             e-&gt;packet_id =3D pid;</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  /* check for replay */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            ASSERT(!reliable_pid_min(pid, rel-&gt;packet_id));</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>             e=
-&gt;opcode =3D opcode;</span><br><span>             e-&gt;next_try =3D 0;<=
/span><br><span>             e-&gt;timeout =3D 0;</span><br><span>diff --gi=
t a/src/openvpn/reliable=2Eh b/src/openvpn/reliable=2Eh</span><br><span>ind=
ex a85f2e9=2E=2E04f3372 100644</span><br><span>--- a/src/openvpn/reliable=
=2Eh</span><br><span>+++ b/src/openvpn/reliable=2Eh</span><br><span>@@ -288=
,15 +288,16 @@</span><br><span> bool reliable_can_get(const struct reliable=
 *rel);</span><br><span> </span><br><span> /**</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * Check that a received packet&#39;s ID is not a =
replay=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Check t=
hat a received packet&#39;s ID is not a replay and is inside the receive</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * window=2E</span><br=
><span>  *</span><br><span>  * @param rel The reliable structure for handli=
ng this VPN tunnel&#39;s</span><br><span>  *     received packets=2E</span>=
<br><span>  * @param id The packet ID of the received packet=2E</span><br><=
span>  *</span><br><span>  * @return</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * @li True, if the packet ID is not a replay=2E</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * @li False, if the packet ID is=
 a replay=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @li =
True, if the packet ID is new and inside the receive window=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @li False, if it is a replay,=
 or too far ahead to be stored=2E</span><br><span>  */</span><br><span> boo=
l reliable_not_replay(const struct reliable *rel, packet_id_type id);</span=
><br><span> </span><br><span>diff --git a/tests/unit_tests/openvpn/test_pac=
ket_id=2Ec b/tests/unit_tests/openvpn/test_packet_id=2Ec</span><br><span>in=
dex aabb555=2E=2Eac6c710 100644</span><br><span>--- a/tests/unit_tests/open=
vpn/test_packet_id=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_=
packet_id=2Ec</span><br><span>@@ -517,13 +517,16 @@</span><br><span> }</spa=
n><br><span> </span><br><span> /*</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- * Reference implementations of the packet id comparisons as th=
ey behave today=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
The sweeps below assert reliable=2Ec agrees with them at the anchors swept,=
 so</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * a change to an =
accepted id set there fails a test=2E Keep them standalone:</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * expressing them in terms of reliab=
le=2Ec would make the sweeps tautologies=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * Independent models of the id sets the packet id =
comparisons accept=2E The</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * sweeps below assert reliable=2Ec agrees with them at the anchors s=
wept, so a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * change=
 to an accepted id set there fails a test=2E Each model is tagged</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * &quot;preserved&quot; or &=
quot;introduced&quot; against the comparisons that came before=2E Keep</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * them standalone: expr=
essing them in terms of reliable=2Ec would make the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * sweeps tautologies=2E</span><br><span>=
  */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-/* &quot;p1 &lt; p2&quot; with the 2^31 horizon, i=2Ee=2E ((int32_t)(p1 - =
p2) &lt; 0) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* th=
e dropped reliable_pid_min(): &quot;p1 &lt; p2&quot; with the 2^31 horizon,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * i=2Ee=2E ((int32=
_t)(p1 - p2) &lt; 0) */</span><br><span> static bool</span><br><span> ref_p=
id_min(packet_id_type p1, packet_id_type p2)</span><br><span> {</span><br><=
span>@@ -538,6 +541,7 @@</span><br><span> #define CHAR_N_SEND_BUFFERS    6<=
/span><br><span> #define CHAR_OPCODE_CONTROL_V1 4</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/* preserved: the ids valid=
ate_packet_id_window() accepts */</span><br><span> static bool</span><br><s=
pan> ref_pid_in_send_window(const struct reliable *rel, packet_id_type pid)=
</span><br><span> {</span><br><span>@@ -546,6 +550,7 @@</span><br><span>   =
  return dist &gt;=3D 1 &amp;&amp; dist &lt;=3D CHARACTERIZED_SEND_WINDOW;<=
/span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/* preserved: reliable_pid_in_range2() */</span><br><span>=
 static bool</span><br><span> ref_wont_break_sequentiality(const struct rel=
iable *rel, packet_id_type id)</span><br><span> {</span><br><span>@@ -559,6=
 +564,7 @@</span><br><span>     return id &lt; base + extent;</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/* preserved: the horizon check, then the slot scan */</span><br><span>=
 static bool</span><br><span> ref_not_replay(const struct reliable *rel, pa=
cket_id_type id)</span><br><span> {</span><br><span>@@ -691,6 +697,54 @@</s=
pan><br><span>     }</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/* Once rel-&gt;packet_id + rel-&gt;s=
ize overflows, the absolute clause makes</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * reliable_wont_break_sequentiality() permissive; wha=
t may be stored is still</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * the receive window, which wraps with it=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+test_recv_window_bounded_at_wrap(void **state)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct reliable rel =3D { 0 };</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    rel=2Esize =3D RELIAB=
LE_CAPACITY;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rel=
=2Epacket_id =3D 0xFFFFFFF8;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_int_equal(RECV_STORE, recv_filter(&amp;rel, 0xFFFFFFF8));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(RECV_STORE, rec=
v_filter(&amp;rel, 0xFFFFFFFF));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_int_equal(RECV_STORE, recv_filter(&amp;rel, 3));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* one past the window, and one behin=
d it: acknowledged, never stored */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_int_equal(RECV_ACK_ONLY, recv_filter(&amp;rel, 4=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_e=
qual(RECV_ACK_ONLY, recv_filter(&amp;rel, 0xFFFFFFF7));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
* The id the receiver is next waiting for has to be storable at every base,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the packet id wr=
ap included=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_wont_=
break_sequentiality_accepts_next_id(void **state)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    const packet_id_type bases[] =3D {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        0,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        1,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        500,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        0x7FFFFFFF,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        0x80000000,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        0xFFFFFFF3,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        0xFFFFFFF4,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        0xFFFFFFF8,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        0xFFFFFFFE,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        0xFFFFFFFF,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i=
 &lt; SIZE(bases); i++)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        st=
ruct reliable rel =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        rel=2Esize =3D RELIABLE_CAPACITY;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        rel=2Epacket_id =3D bases[i];</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        assert_true(reliable_wont_break_seque=
ntiality(&amp;rel, rel=2Epacket_id));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        assert_true(reliable_not_replay(&amp;rel, rel=2Ep=
acket_id));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* bases at or below 2=
^31, where old and new agree; never to change */</span><br><span> static vo=
id</span><br><span> test_recv_filter_characterization(void **state)</span><=
br><span>@@ -698,12 +752,31 @@</span><br><span>     sweep_recv_filter(char_=
anchors, SIZE(char_anchors), ref_recv_filter);</span><br><span> }</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Introduc=
ed, for the bases above 2^31 only: storing also requires the id to</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * be inside the receive win=
dow=2E The ids between one further ahead and</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * rel-&gt;packet_id cannot all fit alongside it, =
so rel-&gt;packet_id never reaches</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * it and the slot is held for the rest of the key state=2E =
Still ACKed, like a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * replay=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stat=
ic enum recv_verdict</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ref_recv_filter_bounded(const struct reliable *rel, packet_id_type id)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const enum recv_verdict verdict =3D r=
ef_recv_filter(rel, id);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (verdic=
t =3D=3D RECV_STORE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        &amp;&amp; (packet_id_type)(id - rel-&gt;packet_id) &gt;=3D (packet=
_id_type)rel-&gt;size)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret=
urn RECV_ACK_ONLY;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    return verdict;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span> /* bases above 2^31, where they di=
verge, kept apart so a change confined</span><br><span>  * there touches on=
e test */</span><br><span> static void</span><br><span> test_recv_filter_hi=
gh_base(void **state)</span><br><span> {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    sweep_recv_filter(char_anchors_high, SIZE(char_ancho=
rs_high), ref_recv_filter);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    sweep_recv_filter(char_anchors_high, SIZE(char_anchors_high), r=
ef_recv_filter_bounded);</span><br><span> }</span><br><span> </span><br><sp=
an> static void</span><br><span>@@ -739,6 +812,60 @@</span><br><span>     s=
weep_send_window(char_anchors_high, SIZE(char_anchors_high));</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/* The window bound in the selection is what stops an entry sitting ahe=
ad of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * rel-&gt;pac=
ket_id from being taken for the oldest one: its distance below</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * rel-&gt;packet_id is then nea=
rly the whole id space=2E array[0] cannot arise</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * through the API; array[1] is an ordinary out=
standing packet=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_r=
eliable_send_ignores_entry_ahead(void **state)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    now =3D 1000;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct r=
eliable rel =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    rel=2Esize =3D CHAR_N_SEND_BUFFERS;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    rel=2Einitial_timeout =3D 2;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    rel=2Epacket_id =3D 3;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* scanned first, and outside the window */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    rel=2Earray[0]=2Eac=
tive =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
el=2Earray[0]=2Epacket_id =3D 0x40000000;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    rel=2Earray[0]=2Etimeout =3D 2;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    rel=2Earray[0]=2Enext_try =3D 0;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* a genuine outstanding packet, tw=
o below rel-&gt;packet_id */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    rel=2Earray[1]=2Eactive =3D true;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    rel=2Earray[1]=2Epacket_id =3D 1;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    rel=2Earray[1]=2Etimeout =
=3D 2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rel=2Earr=
ay[1]=2Enext_try =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int opcode =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_pt=
r_equal(&amp;rel=2Earray[1]=2Ebuf, reliable_send(&amp;rel, &amp;opcode));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/* reliable_can_send() promises reliable_send() will hand =
back a buffer, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* its caller asserts on that=2E The state below cannot arise through the AP=
I --</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the entry si=
ts outside the send window -- but the two must not be able to</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * disagree=2E */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+test_reliable_send_matches_can_send(void =
**state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    now =3D 1000;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct reliable rel =3D { 0 };</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    rel=2Esize =3D CHAR_N_SEND_BUFF=
ERS;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rel=2Einiti=
al_timeout =3D 2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  rel=2Epacket_id =3D 3;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rel=2Earra=
y[0]=2Eactive =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    rel=2Earray[0]=2Epacket_id =3D 0x40000000;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    rel=2Earray[0]=2Etimeout =3D 2;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    rel=2Earray[0]=2Enext_tr=
y =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    int opcode =3D 0;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(reliable_can=
_send(&amp;rel));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_non_null(reliable_send(&amp;rel, &amp;opcode));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span> /* reliable_send() picks the oldest el=
igible entry, across the wrap and the</span><br><span>  * signed midpoint *=
/</span><br><span> static void</span><br><span>@@ -880,10 +1007,14 @@</span=
><br><span>         cmocka_unit_test(test_reliable_backoff_is_bounded),</sp=
an><br><span>         cmocka_unit_test(test_reliable_purge_ignores_forged_a=
cks),</span><br><span>         cmocka_unit_test(test_reliable_purge_legitim=
ate_ack),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cm=
ocka_unit_test(test_wont_break_sequentiality_accepts_next_id),</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_re=
cv_window_bounded_at_wrap),</span><br><span>         cmocka_unit_test(test_=
recv_filter_characterization),</span><br><span>         cmocka_unit_test(te=
st_recv_filter_high_base),</span><br><span>         cmocka_unit_test(test_s=
end_window_characterization),</span><br><span>         cmocka_unit_test(tes=
t_reliable_send_picks_oldest),</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        cmocka_unit_test(test_reliable_send_ignores_entry_ahead)=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_uni=
t_test(test_reliable_send_matches_can_send),</span><br><span>         cmock=
a_unit_test(test_get_buf_output_sequenced_boundary),</span><br><span>      =
   cmocka_unit_test(test_mark_active_incoming_accepts_window),</span><br><s=
pan> #ifndef _MSC_VER</span><br></pre><p>To view, visit <a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1900?usp=3Demail">change 1900</a>=2E To =
unsubscribe, or for help writing mail filters, visit <a href=3D"https://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1900?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"disp=
lay:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:non=
e"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bran=
ch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iaaa0af7d6=
78eb447bc93741add8120d9f348d9eb </div>
<div style=3D"display:none"> Gerrit-=
Change-Number: 1900 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 =
</div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;=
razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>

</body></html>
--FO/rhiRuHGc=--


--===============5846495029566629889==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5846495029566629889==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5846495029566629889==--

