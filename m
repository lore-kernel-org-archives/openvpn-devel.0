Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24BBCC88E53
	for <openvpn-devel@archiver.kernel.org>; Tue, 15 Sep 2026 12:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=er/2VtQvIQ/roC9ogZ6DIHexbHtHDLNL88Jbr5aLkdc=; b=C7DFR1k7BRmhPKxKYmRiTQcnu7
	yckj0EtYiezt5LfGRwroWg1qQRQanKhS7FFxSa9tWPKAMTDtLE2yZNK/fMyLgJgyO/HgqBl2rNYC1
	t5SxqTq0kVcxI5DRPn2HAE6invU80MQP+TWOggoa2n2kgao2IZN4dwkb9XQmYWsP5gvk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6Sl9-0004kj-43;
	Tue, 15 Sep 2026 12:59:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x6Sl6-0004kc-My
 for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 12:59:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=uBbgmsZLEsPMCfr3FaFkPcMmBPK/Jwg+tZVBgOPrtJw=; b=nEqkMp/WaiDFEXOIVpqV+Htfer
 99hf7aF0Dh46lOowHaGNaNzB//o2M2aFJIaLIZ4xNMYBtbFUxVk0jP6E4Uqfv3Ts1s4dw9t163nh9
 ylPlhXqITjBhx4szqFCA7HjXnc6WVVRllxemOVNFhezsQ838VLYMiJkGhJd5/j/nQ5Ko=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=uBbgmsZLEsPMCfr3FaFkPcMmBPK/Jwg+tZVBgOPrtJw=; b=c
 c3nJJX5HhDkR2iFzknWxuTtSf6m+NM0BW6/GvaodtSjthqhqG01yCRRvu2oFO+q/MVPfmIGJVSKfi
 gccI5lg/ztKrvUzOfE4U/bl/8bXmpu68H0oJxalTiOXsMgS+IhHfVwB/6cYt+zwPupSrYTZzVOdEq
 PqO3n0UXMoOPt7xQ=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6Sl5-0002jZ-GP for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 12:59:37 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f6350faaso1542816f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 15 Sep 2026 05:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789477169; x=1790081969; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uBbgmsZLEsPMCfr3FaFkPcMmBPK/Jwg+tZVBgOPrtJw=;
 b=MTqzstMhMb2/8MJEe8rmvI8/fbt8iTLR9qKQu9iYjnSo154iuWtPAZ8AnImZVb57uN
 4EqFTnR/zjx+3qgNRRAgIz5B46RKDvMVzdDEJcOgKgvu2Sbgsxb4AyL647/8vFeheCtm
 kaoToJst6Rv29Kr1I+2r6/bgJ2KnzvhC0MlfYXu1DqnnqWo/R4OuvKMryRsexHMwPuq4
 mJ7ZGHWIN3TCmVyoWjqQeWrPmQH7Glf0hPznHZbZ3S6LZ0+fzunoluGH76VHcmjylqbb
 fbChAu1JuQ6sbvWUbA+NOxY1zRXwO0/hRnmJowUDLxGK5jjzpU7gxIiFwErpkU/gr33b
 XsOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789477169; x=1790081969;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=uBbgmsZLEsPMCfr3FaFkPcMmBPK/Jwg+tZVBgOPrtJw=;
 b=pLSD/FjLKft99tU7rVw+Y8wTh5OPr1srZP0hlZmKYpIKhqU8tLppNyfyK/bNKRRZ5+
 FVNhXCPfy3YrvSmcAe1jgGrSQnmRw0ClqdNxQYprH4csdfx9UL/YcluxAFDB1+JYvS3T
 koY1eJ00WBrJU5QSq1BorZGB0HOvcbiWdnW9uKH9ntHj1d96kEi28p7Ut1ljAX7L3RmD
 ydZqo+R/ieVa6Idv4lUfrrWudmXPBoXGGxhlSoILv541OFaROCUIkduUGIHqYe51ewBc
 rqNfUxakUWUZZluwPtjQ8o8bv5PKRcT3DY+cZwF4yAvywQFdbeh5+DDijjrBJlrs/mYR
 7vGg==
X-Gm-Message-State: AFuF++kWpk+8H3QnDVuJsws4EQfNmG4TWFl70rR5xttxXKgiUhXlhSA4
 wMhZJj5UYXojZqLJFp/BCHVi4tJGiyxAdfROSXHVRtrJsVOYUmuDIWLcn4J4iY0I09G2iOJ2ELo
 H2PBvlMXY/nTrCwCW/KVjsdvdNvNIY47OMsWf+i8EkUdMPhMWou7n7cevfsz6p7q7wsNl
X-Gm-Gg: AYBFou1UQE3TDOqQMNBNXQdfsphsm9V9V/M8WsOvANKDpUo3rwYG2qv+xvEMBRTtj95
 uyiNFj8mAWl9KHezAhOKa+jJJ2r0/GLD7IbKn6qae6TDPWf7o0UnOM+q/Ik3dStvdijfhhqhuaD
 0STKhpuuSFbxzFxxP3CNgWqKRf0wCMAFiIw8/4DDBf1GJN/GK64lc8oFsqBdhKzNvix9BkcCDjb
 auFy7kAFraFO3QEe3inzcw/UCWUcBlxXcxFoquz0WTHySjOmbq4eBHv0Jb6MeakWmKZ3eerDa6s
 4NHO/cDn5n8X0MoWoimgpQ2GUl8r61VE/c/5j3Q/1GiHmWSw67mhzCQdZZCF4redOfbo8Ko3Y3R
 s0DMOE9Dmdl87zA/kj7kFRtNjhOABA2VSACnw0eoF5+nS9yAes9fGUlo5l0cCYZBs5luE++Kpg4
 YNLiBGeK5Gkuzo/E8luK5C9N5g8CswJGMJ5cqaQd4W5CVmmyRc+Ec93DLw4n2yFXAG2aYxxhUOO
 9PLT/9bVeraL7ZX1lFT0+Knll/IyTr4EjzjyYz4XfxMXQbFmFW4ni2D53XdqOWnRmAN8zOmWN3Y
 Kx21NdWNqaz4ZUAe3vEYWgTYiMUh/CkrwUObAwaHNUpZ008QehidDjlqr8C5WnknoujRcVM6
X-Received: by 2002:a05:6000:470c:b0:485:8547:5060 with SMTP id
 ffacd0b85a97d-48702aae835mr8407107f8f.15.1789477168644; 
 Tue, 15 Sep 2026 05:59:28 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb2ecf23sm35406179f8f.5.2026.09.15.05.59.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 05:59:28 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 15 Sep 2026 12:59:19 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 23
X-Gerrit-Change-Id: I375a41749060b7d006647bc27002c55436c8a8bb
X-Gerrit-Change-Number: 1748
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1748?usp=email>
X-Gerrit-Commit: 4837e091bf32a36f36a33ca053afffbaa5304173
In-Reply-To: <gerrit.1782719911000.I375a41749060b7d006647bc27002c55436c8a8bb@gerrit.openvpn.net>
References: <gerrit.1782719911000.I375a41749060b7d006647bc27002c55436c8a8bb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkzNzVhNDE3NDkwNjBiN2QwMDY2NDdiYzI3MDAyYzU1NDM2YzhhOGJiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <42992afb083d63f257468f795faee833181ca3cb-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x6Sl5-0002jZ-GP
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Measure probe
 RTT for candidate-band selection
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
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8886792205530369606=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8886792205530369606==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="j7kw3YscCKU="; charset=UTF-8

--j7kw3YscCKU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici, stipa=2E

Hello=
 plaisthos, ralf_lici, 

I'd like you to reexamine a change=2E Please visit=


    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1748?usp=3Demail

to look a=
t the new patch set (#23)=2E


Change subject: oob: Measure probe RTT for c=
andidate-band selection
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

oob: Measure probe RTT for candidate-band selection

Record each=
 probe's round-trip time (per-target send timestamp vs reply
arrival) and f=
eed it to oob_rank_probe_results(), where RTT forms the
candidate band: res=
ponders within the effective margin of the fastest
compete on weight, slowe=
r ones fall behind=2E Log the measured RTT and the
effective margin (with i=
ts source: client or server-advertised) at verb
4=2E

Before this the clien=
t never measured RTT, so every responder sat in the
band and selection was =
purely weighted-random; with real measurements
the latency-based candidate =
selection takes effect=2E

The timestamp is taken at the first send=2E A re=
ply carries nothing that
ties it to a send round, so measuring from a resen=
d would report a
server slower than one round as fast, and could rank it ah=
ead of a
genuinely faster one=2E Entries that resolve to the same address s=
hare the
send time of the single probe=2E

The RTT therefore runs from the =
first send to the moment the client
reads the reply: it compares servers, i=
t is not a network measurement=2E A
probe that needed a resend reads high; =
the resend exists so that a
dropped probe does not make a live server look =
dead, not to refine the
measurement=2E

Change-Id: I375a41749060b7d006647bc=
27002c55436c8a8bb
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M doc=
/man-sections/client-options=2Erst
M src/openvpn/oob=2Eh
M src/openvpn/oob_=
client=2Ec
3 files changed, 65 insertions(+), 17 deletions(-)


  git pull =
ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/48/1748/23

diff --=
git a/doc/man-sections/client-options=2Erst b/doc/man-sections/client-optio=
ns=2Erst
index d07f8de=2E=2Eaeeea37 100644
--- a/doc/man-sections/client-op=
tions=2Erst
+++ b/doc/man-sections/client-options=2Erst
@@ -608,9 +608,17 @=
@
   remote, and each answering server replies with its advertised priority=

   and weight=2E Remotes are then reordered following DNS SRV (RFC 2782)
 =
  semantics: servers that answered are tried before those that did not,
-  =
grouped by priority (lowest first); within a priority group, servers are
- =
 picked by weighted-random selection=2E Round-trip time is not yet taken
- =
 into account, so ``max-latency-diff`` has no effect for now=2E
+  grouped =
by priority (lowest first); within a priority group, servers
+  whose measu=
red round-trip time is within ``max-latency-diff``
+  milliseconds of the f=
astest one are picked by weighted-random
+  selection, the others follow in=
 round-trip-time order=2E When
+  ``max-latency-diff`` is not given, each a=
nswering server's own
+  advertised margin decides whether that server stay=
s a candidate, so a
+  server advertising :code:`0` asks to be considered o=
nly while it ties
+  the fastest of its priority group, without constrainin=
g the others=2E A
+  value of :code:`1000` or more makes every answering se=
rver of a
+  priority group a candidate, since replies only arrive within t=
he
+  one-second probe window; the group is then ordered by weight alone=2E=

 
   The probe is currently sent without control-channel wrapping, so it o=
nly
   works against a server configured without ``--tls-auth``,
diff --git=
 a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh
index e0016ee=2E=2E52c1de2 100=
644
--- a/src/openvpn/oob=2Eh
+++ b/src/openvpn/oob=2Eh
@@ -196,6 +196,7 @@=

     struct openvpn_sockaddr dest;
     socklen_t destlen;
     bool sent;=

+    struct timeval sent_at; /* when the first probe went out, for the RTT=
 */
 };
 
 /**
diff --git a/src/openvpn/oob_client=2Ec b/src/openvpn/oob_cl=
ient=2Ec
index 16217c7=2E=2E61e2602 100644
--- a/src/openvpn/oob_client=2Ec=

+++ b/src/openvpn/oob_client=2Ec
@@ -60,9 +60,11 @@
 struct probe_ctx
 {
 =
    socket_descriptor_t sd[PROBE_AF_COUNT]; /* SOCKET_UNDEFINED if that AF =
is unavailable */
-    /* Addresses probed so far in the current send round=
: an address several
-     * entries resolve to is probed once, and its rep=
ly is credited to each=2E */
+    /* Addresses probed so far in the current=
 send round, with the time each
+     * went out: an address several entrie=
s resolve to is probed once, and its
+     * reply is credited to each of t=
hem with the same RTT=2E */
     struct openvpn_sockaddr *probed;
+    stru=
ct timeval *probed_at;
     int n_probed;
 #ifdef TARGET_ANDROID
     bool =
fd_protected[PROBE_AF_COUNT]; /* VPNService protect(), once per socket */
@=
@ -277,10 +279,18 @@
     /* Credit the reply to every still-unanswered rem=
ote probed at its source
      * address: several entries can resolve to th=
e same address, and each takes
      * the first reply for it=2E */
+    st=
ruct timeval rcv;
+    openvpn_gettimeofday(&rcv, NULL);
     int i =3D oob=
_probe_next_target_at(from, targets, results, n, 0);
     while (i >=3D 0)
=
     {
+        /* From this round's send to now, i=2Ee=2E including any ti=
me the reply
+         * waited in the receive queue while we were still se=
nding=2E */
+        long ms =3D (long)(rcv=2Etv_sec - targets[i]=2Esent_at=
=2Etv_sec) * 1000
+                  + (rcv=2Etv_usec - targets[i]=2Esent_a=
t=2Etv_usec) / 1000;
+
         results[i]=2Eresponded =3D true;
+        r=
esults[i]=2Ertt_ms =3D (ms > 0) ? (unsigned int)ms : 0;
         results[i]=
=2Ereply =3D reply;
 
         i =3D oob_probe_next_target_at(from, targets=
, results, n, i + 1);
@@ -368,23 +378,34 @@
 /* Resend the probe to every r=
emote that we probed but that has not answered=2E */
 static void
 oob_prob=
e_resend_unanswered(struct probe_ctx *pc, const struct buffer *probe,
-    =
                        const struct oob_probe_target *targets,
+          =
                  struct oob_probe_target *targets,
                       =
      const struct oob_probe_result *results, int n)
 {
-    pc->n_probed =
=3D 0; /* a new round: probe each unanswered address once again */
+    /* =
A new round: every unanswered address is probed once more=2E The send time
=
+     * is left alone, so the RTT keeps measuring from the first send=2E */=

+    pc->n_probed =3D 0;
     for (int i =3D 0; i < n; i++)
     {
-      =
  if (!targets[i]=2Esent || results[i]=2Eresponded
-            || oob_addr=
_list_find(pc->probed, pc->n_probed, &targets[i]=2Edest) >=3D 0)
+        i=
f (!targets[i]=2Esent || results[i]=2Eresponded)
+        {
+            co=
ntinue;
+        }
+        if (oob_addr_list_find(pc->probed, pc->n_probed=
, &targets[i]=2Edest) >=3D 0)
         {
             continue;
         }
=
         socket_descriptor_t sd =3D pc->sd[probe_af_index(targets[i]=2Edest=
=2Eaddr=2Esa=2Esa_family)];
-        if (sd !=3D SOCKET_UNDEFINED
-        =
    && sendto(sd, (const char *)CBPTR(probe), (int)BLEN(probe), 0,
-       =
               (const struct sockaddr *)&targets[i]=2Edest, targets[i]=2Ede=
stlen)
-                   >=3D 0)
+        if (sd =3D=3D SOCKET_UNDEFINED)=

         {
+            continue;
+        }
+        struct timeval sent_=
at;
+        openvpn_gettimeofday(&sent_at, NULL);
+        if (sendto(sd, =
(const char *)CBPTR(probe), (int)BLEN(probe), 0,
+                   (const=
 struct sockaddr *)&targets[i]=2Edest, targets[i]=2Edestlen)
+            >=
=3D 0)
+        {
+            pc->probed_at[pc->n_probed] =3D sent_at;
   =
          pc->probed[pc->n_probed++] =3D targets[i]=2Edest;
         }
    =
 }
@@ -397,7 +418,7 @@
  * once the window elapses or every sent probe has =
been answered=2E */
 static void
 oob_probe_collect(struct probe_ctx *pc, c=
onst struct buffer *probe,
-                  const struct session_id *clie=
nt_sid, const struct oob_probe_target *targets,
+                  const st=
ruct session_id *client_sid, struct oob_probe_target *targets,
            =
       struct oob_probe_result *results, int n,
                   const st=
ruct signal_info *sig)
 {
@@ -572,6 +593,7 @@
      * An address several en=
tries resolve to is probed once; its reply is
      * credited to each of t=
hem=2E */
     pc=2Eprobed =3D gc_malloc(sizeof(*pc=2Eprobed) * l->len, fal=
se, &gc);
+    pc=2Eprobed_at =3D gc_malloc(sizeof(*pc=2Eprobed_at) * l->le=
n, false, &gc);
     pc=2En_probed =3D 0;
 
     int sent_count =3D 0;
@@ -=
598,8 +620,16 @@
             pc=2Efd_protected[af] =3D true;
         }
 #=
endif
-        if (oob_addr_list_find(pc=2Eprobed, pc=2En_probed, &targets[=
i]=2Edest) < 0)
+        const int seen =3D oob_addr_list_find(pc=2Eprobed,=
 pc=2En_probed, &targets[i]=2Edest);
+        if (seen >=3D 0)
         {
+=
            /* Already probed this round by an earlier entry: reuse that se=
nd
+             * time, so both entries report the same RTT for the one re=
ply=2E */
+            targets[i]=2Esent_at =3D pc=2Eprobed_at[seen];
+    =
    }
+        else
+        {
+            openvpn_gettimeofday(&targets[i=
]=2Esent_at, NULL);
             if (sendto(sd, (const char *)BPTR(&probe),=
 (int)BLEN(&probe), 0,
                        (struct sockaddr *)&targets[=
i]=2Edest, targets[i]=2Edestlen)
                 < 0)
@@ -607,6 +637,7 @@
=
                 msg(D_LOW, "server-probe: %s:%s: probe send failed", ce->r=
emote, ce->remote_port);
                 continue;
             }
+       =
     pc=2Eprobed_at[pc=2En_probed] =3D targets[i]=2Esent_at;
             p=
c=2Eprobed[pc=2En_probed++] =3D targets[i]=2Edest;
         }
         targ=
ets[i]=2Esent =3D true;
@@ -632,8 +663,16 @@
         if (results[i]=2Eresp=
onded)
         {
             responded++;
-            msg(D_LOW, "server=
-probe: %s:%s answered (priority %d, weight %d)", ce->remote,
-            =
    ce->remote_port, results[i]=2Ereply=2Epriority, results[i]=2Ereply=2Ewe=
ight);
+            /* Effective candidate-band margin and where it came fr=
om: the
+             * client's own setting wins, else the server's advert=
ised value=2E */
+            int client_margin =3D c->options=2Eserver_pro=
be_latency_margin;
+            int margin =3D oob_effective_margin(&result=
s[i], client_margin);
+            const char *margin_src =3D client_margin=
 >=3D 0 ? "client" : "server-advertised";
+            msg(D_LOW,
+        =
        "server-probe: %s:%s answered (priority %d, weight %d, rtt %u ms;"
=
+                " latency margin %d ms [%s])",
+                ce->remote=
, ce->remote_port, results[i]=2Ereply=2Epriority, results[i]=2Ereply=2Eweig=
ht,
+                results[i]=2Ertt_ms, margin, margin_src);
         }
 =
        else
         {

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1748?usp=3Demail
To unsubscribe, or for help writing mail filter=
s, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chan=
ge-Id: I375a41749060b7d006647bc27002c55436c8a8bb
Gerrit-Change-Number: 1748=

Gerrit-PatchSet: 23
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Rev=
iewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <r=
alf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Attention: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: stipa <lsti=
pakov@gmail=2Ecom>

--j7kw3YscCKU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici, stipa=2E </p>
<p>stipa <strong>=
uploaded patch set #23</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1748?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">oob: Measure probe RTT for candidate-band selection<br><br>Record=
 each probe&#39;s round-trip time (per-target send timestamp vs reply<br>ar=
rival) and feed it to oob_rank_probe_results(), where RTT forms the<br>cand=
idate band: responders within the effective margin of the fastest<br>compet=
e on weight, slower ones fall behind=2E Log the measured RTT and the<br>eff=
ective margin (with its source: client or server-advertised) at verb<br>4=
=2E<br><br>Before this the client never measured RTT, so every responder sa=
t in the<br>band and selection was purely weighted-random; with real measur=
ements<br>the latency-based candidate selection takes effect=2E<br><br>The =
timestamp is taken at the first send=2E A reply carries nothing that<br>tie=
s it to a send round, so measuring from a resend would report a<br>server s=
lower than one round as fast, and could rank it ahead of a<br>genuinely fas=
ter one=2E Entries that resolve to the same address share the<br>send time =
of the single probe=2E<br><br>The RTT therefore runs from the first send to=
 the moment the client<br>reads the reply: it compares servers, it is not a=
 network measurement=2E A<br>probe that needed a resend reads high; the res=
end exists so that a<br>dropped probe does not make a live server look dead=
, not to refine the<br>measurement=2E<br><br>Change-Id: I375a41749060b7d006=
647bc27002c55436c8a8bb<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet=
&gt;<br>---<br>M doc/man-sections/client-options=2Erst<br>M src/openvpn/oob=
=2Eh<br>M src/openvpn/oob_client=2Ec<br>3 files changed, 65 insertions(+), =
17 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/48/1748/23</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/doc/man-s=
ections/client-options=2Erst b/doc/man-sections/client-options=2Erst</span>=
<br><span>index d07f8de=2E=2Eaeeea37 100644</span><br><span>--- a/doc/man-s=
ections/client-options=2Erst</span><br><span>+++ b/doc/man-sections/client-=
options=2Erst</span><br><span>@@ -608,9 +608,17 @@</span><br><span>   remot=
e, and each answering server replies with its advertised priority</span><br=
><span>   and weight=2E Remotes are then reordered following DNS SRV (RFC 2=
782)</span><br><span>   semantics: servers that answered are tried before t=
hose that did not,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  g=
rouped by priority (lowest first); within a priority group, servers are</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-  picked by weighted-rand=
om selection=2E Round-trip time is not yet taken</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-  into account, so ``max-latency-diff`` has no e=
ffect for now=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  g=
rouped by priority (lowest first); within a priority group, servers</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  whose measured round-trip=
 time is within ``max-latency-diff``</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  milliseconds of the fastest one are picked by weighted-r=
andom</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  selection, t=
he others follow in round-trip-time order=2E When</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  ``max-latency-diff`` is not given, each ans=
wering server&#39;s own</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  advertised margin decides whether that server stays a candidate, so a=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  server advertisin=
g :code:`0` asks to be considered only while it ties</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  the fastest of its priority group, with=
out constraining the others=2E A</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  value of :code:`1000` or more makes every answering server o=
f a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  priority group=
 a candidate, since replies only arrive within the</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  one-second probe window; the group is then=
 ordered by weight alone=2E</span><br><span> </span><br><span>   The probe =
is currently sent without control-channel wrapping, so it only</span><br><s=
pan>   works against a server configured without ``--tls-auth``,</span><br>=
<span>diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh</span><br><spa=
n>index e0016ee=2E=2E52c1de2 100644</span><br><span>--- a/src/openvpn/oob=
=2Eh</span><br><span>+++ b/src/openvpn/oob=2Eh</span><br><span>@@ -196,6 +1=
96,7 @@</span><br><span>     struct openvpn_sockaddr dest;</span><br><span>=
     socklen_t destlen;</span><br><span>     bool sent;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct timeval sent_at; /* when the=
 first probe went out, for the RTT */</span><br><span> };</span><br><span> =
</span><br><span> /**</span><br><span>diff --git a/src/openvpn/oob_client=
=2Ec b/src/openvpn/oob_client=2Ec</span><br><span>index 16217c7=2E=2E61e260=
2 100644</span><br><span>--- a/src/openvpn/oob_client=2Ec</span><br><span>+=
++ b/src/openvpn/oob_client=2Ec</span><br><span>@@ -60,9 +60,11 @@</span><b=
r><span> struct probe_ctx</span><br><span> {</span><br><span>     socket_de=
scriptor_t sd[PROBE_AF_COUNT]; /* SOCKET_UNDEFINED if that AF is unavailabl=
e */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Addresses =
probed so far in the current send round: an address several</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-     * entries resolve to is probed o=
nce, and its reply is credited to each=2E */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* Addresses probed so far in the current send=
 round, with the time each</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+     * went out: an address several entries resolve to is probed onc=
e, and its</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * re=
ply is credited to each of them with the same RTT=2E */</span><br><span>   =
  struct openvpn_sockaddr *probed;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct timeval *probed_at;</span><br><span>     int n_pr=
obed;</span><br><span> #ifdef TARGET_ANDROID</span><br><span>     bool fd_p=
rotected[PROBE_AF_COUNT]; /* VPNService protect(), once per socket */</span=
><br><span>@@ -277,10 +279,18 @@</span><br><span>     /* Credit the reply t=
o every still-unanswered remote probed at its source</span><br><span>      =
* address: several entries can resolve to the same address, and each takes<=
/span><br><span>      * the first reply for it=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct timeval rcv;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    openvpn_gettimeofday(&amp;rcv, NU=
LL);</span><br><span>     int i =3D oob_probe_next_target_at(from, targets,=
 results, n, 0);</span><br><span>     while (i &gt;=3D 0)</span><br><span> =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Fro=
m this round&#39;s send to now, i=2Ee=2E including any time the reply</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+         * waited in the =
receive queue while we were still sending=2E */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        long ms =3D (long)(rcv=2Etv_sec - targe=
ts[i]=2Esent_at=2Etv_sec) * 1000</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                  + (rcv=2Etv_usec - targets[i]=2Esent_at=2Etv=
_usec) / 1000;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span>         results[i]=2Eresponded =3D true;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        results[i]=2Ertt_ms =3D (ms &gt; =
0) ? (unsigned int)ms : 0;</span><br><span>         results[i]=2Ereply =3D =
reply;</span><br><span> </span><br><span>         i =3D oob_probe_next_targ=
et_at(from, targets, results, n, i + 1);</span><br><span>@@ -368,23 +378,34=
 @@</span><br><span> /* Resend the probe to every remote that we probed but=
 that has not answered=2E */</span><br><span> static void</span><br><span> =
oob_probe_resend_unanswered(struct probe_ctx *pc, const struct buffer *prob=
e,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
         const struct oob_probe_target *targets,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                            struct oob_probe_t=
arget *targets,</span><br><span>                             const struct o=
ob_probe_result *results, int n)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    pc-&gt;n_probed =3D 0; /* a new round: =
probe each unanswered address once again */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* A new round: every unanswered address is pro=
bed once more=2E The send time</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     * is left alone, so the RTT keeps measuring from the first =
send=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pc-&g=
t;n_probed =3D 0;</span><br><span>     for (int i =3D 0; i &lt; n; i++)</sp=
an><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      if (!targets[i]=2Esent || results[i]=2Eresponded</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            || oob_addr_list_find(pc-&gt;p=
robed, pc-&gt;n_probed, &amp;targets[i]=2Edest) &gt;=3D 0)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if (!targets[i]=2Esent || re=
sults[i]=2Eresponded)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    continue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (oob_=
addr_list_find(pc-&gt;probed, pc-&gt;n_probed, &amp;targets[i]=2Edest) &gt;=
=3D 0)</span><br><span>         {</span><br><span>             continue;</s=
pan><br><span>         }</span><br><span>         socket_descriptor_t sd =
=3D pc-&gt;sd[probe_af_index(targets[i]=2Edest=2Eaddr=2Esa=2Esa_family)];</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (sd !=3D SOC=
KET_UNDEFINED</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    &amp;&amp; sendto(sd, (const char *)CBPTR(probe), (int)BLEN(probe), 0,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
(const struct sockaddr *)&amp;targets[i]=2Edest, targets[i]=2Edestlen)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                   &gt;=3D=
 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (sd =
=3D=3D SOCKET_UNDEFINED)</span><br><span>         {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            continue;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        struct timeval sent_at;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        openvpn_gettimeofday(&amp;sen=
t_at, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if (sendto(sd, (const char *)CBPTR(probe), (int)BLEN(probe), 0,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                   (const stru=
ct sockaddr *)&amp;targets[i]=2Edest, targets[i]=2Edestlen)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            &gt;=3D 0)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            pc-&gt;probed_at[pc-&gt;n_pro=
bed] =3D sent_at;</span><br><span>             pc-&gt;probed[pc-&gt;n_probe=
d++] =3D targets[i]=2Edest;</span><br><span>         }</span><br><span>    =
 }</span><br><span>@@ -397,7 +418,7 @@</span><br><span>  * once the window =
elapses or every sent probe has been answered=2E */</span><br><span> static=
 void</span><br><span> oob_probe_collect(struct probe_ctx *pc, const struct=
 buffer *probe,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
            const struct session_id *client_sid, const struct oob_probe_tar=
get *targets,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
            const struct session_id *client_sid, struct oob_probe_target *t=
argets,</span><br><span>                   struct oob_probe_result *results=
, int n,</span><br><span>                   const struct signal_info *sig)<=
/span><br><span> {</span><br><span>@@ -572,6 +593,7 @@</span><br><span>    =
  * An address several entries resolve to is probed once; its reply is</spa=
n><br><span>      * credited to each of them=2E */</span><br><span>     pc=
=2Eprobed =3D gc_malloc(sizeof(*pc=2Eprobed) * l-&gt;len, false, &amp;gc);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pc=2Eprobed_at =
=3D gc_malloc(sizeof(*pc=2Eprobed_at) * l-&gt;len, false, &amp;gc);</span><=
br><span>     pc=2En_probed =3D 0;</span><br><span> </span><br><span>     i=
nt sent_count =3D 0;</span><br><span>@@ -598,8 +620,16 @@</span><br><span> =
            pc=2Efd_protected[af] =3D true;</span><br><span>         }</spa=
n><br><span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      if (oob_addr_list_find(pc=2Eprobed, pc=2En_probed, &amp;targets[i]=2E=
dest) &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  const int seen =3D oob_addr_list_find(pc=2Eprobed, pc=2En_probed, &amp;ta=
rgets[i]=2Edest);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if (seen &gt;=3D 0)</span><br><span>         {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            /* Already probed this round =
by an earlier entry: reuse that send</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+             * time, so both entries report the same RTT f=
or the one reply=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            targets[i]=2Esent_at =3D pc=2Eprobed_at[seen];</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            openvpn_gettimeofday(&amp;targets[i]=2Esent_at=
, NULL);</span><br><span>             if (sendto(sd, (const char *)BPTR(&am=
p;probe), (int)BLEN(&amp;probe), 0,</span><br><span>                       =
 (struct sockaddr *)&amp;targets[i]=2Edest, targets[i]=2Edestlen)</span><br=
><span>                 &lt; 0)</span><br><span>@@ -607,6 +637,7 @@</span><=
br><span>                 msg(D_LOW, &quot;server-probe: %s:%s: probe send =
failed&quot;, ce-&gt;remote, ce-&gt;remote_port);</span><br><span>         =
        continue;</span><br><span>             }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            pc=2Eprobed_at[pc=2En_probed] =3D =
targets[i]=2Esent_at;</span><br><span>             pc=2Eprobed[pc=2En_probe=
d++] =3D targets[i]=2Edest;</span><br><span>         }</span><br><span>    =
     targets[i]=2Esent =3D true;</span><br><span>@@ -632,8 +663,16 @@</span=
><br><span>         if (results[i]=2Eresponded)</span><br><span>         {<=
/span><br><span>             responded++;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            msg(D_LOW, &quot;server-probe: %s:%s answer=
ed (priority %d, weight %d)&quot;, ce-&gt;remote,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                ce-&gt;remote_port, results[i]=
=2Ereply=2Epriority, results[i]=2Ereply=2Eweight);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            /* Effective candidate-band marg=
in and where it came from: the</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+             * client&#39;s own setting wins, else the server&#3=
9;s advertised value=2E */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            int client_margin =3D c-&gt;options=2Eserver_probe_laten=
cy_margin;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   int margin =3D oob_effective_margin(&amp;results[i], client_margin);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            const char =
*margin_src =3D client_margin &gt;=3D 0 ? &quot;client&quot; : &quot;server=
-advertised&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           msg(D_LOW,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                &quot;server-probe: %s:%s answered (priority %d, weight %=
d, rtt %u ms;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                &quot; latency margin %d ms [%s])&quot;,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                ce-&gt;remote, ce-&gt;=
remote_port, results[i]=2Ereply=2Epriority, results[i]=2Ereply=2Eweight,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                result=
s[i]=2Ertt_ms, margin, margin_src);</span><br><span>         }</span><br><s=
pan>         else</span><br><span>         {</span><br><span></span><br></p=
re><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
748?usp=3Demail">change 1748</a>=2E To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eor=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1748?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatc=
hset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<di=
v style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Id: I375a41749060b7d006647bc27002c55436c8a8bb </div>=

<div style=3D"display:none"> Gerrit-Change-Number: 1748 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 23 </div>
<div style=3D"display:none"> =
Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mande=
lbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@mand=
elbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa=
 &lt;lstipakov@gmail=2Ecom&gt; </div>

</body></html>
--j7kw3YscCKU=--


--===============8886792205530369606==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8886792205530369606==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8886792205530369606==--

