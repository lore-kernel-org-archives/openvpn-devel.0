Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF5DC88E7C
	for <openvpn-devel@archiver.kernel.org>; Mon, 14 Sep 2026 14:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W4o+gOHsgK7ootjJNxG0ieSM338ZiBJi4wLLHLO0dUQ=; b=i8s98Fm1IaDRPWhbUKGd2SbOss
	MySzCO87lX/cd/ArSDmxHuMDE4IoV1DGVu3hCdltabX+KJQxrDO2+3RzDZLl00l+lqvp2Oft9jWwS
	mptOLUf6y0zV3aVkgQTrZty2Ymmfe2j/9yFMt2raGsHHU+O7MN+a0ENM2eLUMe/fbbfA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x67WO-0008M7-3T;
	Mon, 14 Sep 2026 14:19:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x67WN-0008Lv-AK
 for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 14:19:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=mhtr6Aij2XVlJkdRYQ0Yg2xZviYQqTxlgh3CwDQttqA=; b=OBm3Tez/+Ke+20mtJSAw6CptvX
 y+6dhJ/UdxaPNGxDlE/JTp1n3UpDhMn8BUk6DLHMXJ9IHSSDIX2ZRDF3HiUmfa66WIs4BgOuE+Jfn
 Ak8QE5mSJbrn0r6iuz8vWI/7YzyhCjSKxyrSe72o3TGvVW8tQjqE1HnhAxDeKweWKKJc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=mhtr6Aij2XVlJkdRYQ0Yg2xZviYQqTxlgh3CwDQttqA=; b=f
 o5e5toRmaWZewNV/Wc9Vk3EH5/kzw91+I6U54XZnn7aCwzf/nTqW8nVqNNfmccs2cnVFx0ws3BTqA
 z71fsu52JflDRuarsrvJEeEeWCiC2aHxWG1ZsfpCNHp2KK2/44WLPTAuQFRVk7+6WCmsobfkIIzyZ
 ZUc2AGN1yYIGLY/o=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x67WK-0006eH-EA for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 14:19:00 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-49e6b280cadso27678255e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 14 Sep 2026 07:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789395530; x=1790000330; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mhtr6Aij2XVlJkdRYQ0Yg2xZviYQqTxlgh3CwDQttqA=;
 b=JdvkUWn/TzJQmZ3pE6+rUg5Osj/yeIehrl9Qjh9JAhLJCFZYmtBSeZ4l3M0y3Yz0wk
 W2JWJueZUqymLZXoiXjeZqZS9kv86Crlu0ShwdijLFANk8HsvFCff+OXQo4o9UiWhr7w
 s+Omz3adot14LlkFa2LWu7L9/zPWc5ZqISKgR1pSCPGyz0/TmFjYBx/MOwpoI35YPH9r
 SfTNyVBrZZCYs0QiijPVJV0lhws29iqX24udN4Xk/m88z8J09NTvD+u18DW1PBpoIbbk
 7eXFKj/RL/czkULyIXinS+jZW4S4uuM5//LhGqnN2j9n/V6oJsZJoOvaEf6khkui3/lK
 eLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789395530; x=1790000330;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=mhtr6Aij2XVlJkdRYQ0Yg2xZviYQqTxlgh3CwDQttqA=;
 b=m7HbW5XIqYhjF9QPKY84UUG/2tVOPunznjyoHrKZ3t6UcY4BtgPpZrfpXeoguitgoj
 JblPJs+CzJpoVl2EuPVYqsOT0sYVLChkIzzH9b6biZ/HfDfCueWHoaM1w+Lt1CD6AVCk
 cXyPfCmuPHQf+Swj+jze3gORrZcbbrOOJCuIhmx2/YZBV+KxsNaxnlTDhFjAcSBvR6rD
 1XUP0VqlZ+8u20uKOUbWDJ65T82qhK+aE7YWfom36nULWWlFrCyXOXcD62GxTEq4s+Ca
 FglmggUb9JXFFe363OKGP6GgwXwG49LTAkL5O/jd4rw2Uu9EoWlpnlFGGQVNecziVn0p
 M2iA==
X-Gm-Message-State: AFuF++ke93bJAakBhFUUQgrd0Oy9MvS6v4wXO8W6pex+NX/Oy8UYuw1l
 kUOnUtwQ5A2jEeXwy8B0yGy+tXusAb91u/atpQJaHNOJsIE3thlx3UGq+TnHiz1sDmyVmX/8Mwx
 SSqYI66Q1DhSSGhM9BjTSMQwpcVwVy7ggTPqVSWeJtYMh971o8VKGeorNUbNjhDqk13Ql
X-Gm-Gg: AYBFou1m1nmnLUrVHF1efYb2akQ57Ks224WoRf5dsAm0Ovg6SqnzlzROcwuHyUEert+
 7LBZPORhTk59bFfgHQNnwdRoxDqCFSVnRy2K3WI6tNOqSrxzJCxD1UBM/uvB/yPuTX6uZcnqazx
 0+7tFnE6vLKbpgCTIZ4fRDLLi3q/WmoRndRGdKG8zITRJ8ns/sHrr5na+sl5rniaxAUYgdEJS9A
 SuG+SvwLfyC+ISFFzeiwsZLczhHFr0VjYrxwvdKPfdNp8shZcvC15x9K96MiW/XRV3sUMXDfZw5
 yyUDpa5ahlLJYiqB9DdxYSidhOra0wsvqWEfj9Y8xYMrQtQegrRmfcCWNdUs/nC86YbcB9UlWLa
 ng1eyvlnbuMDU0eZ+xIvVdsksfCDnSNC9r+Q27uZxkRiFPVaYwDKBRb+URzfXcblPLhDgCDfnf3
 yvplmerAJSxAN29nQpwTXMGo/S1AnvrgTfVZ0vUKyke5GGylz5IToBvkREjb9Oq4i4b5EkmwP71
 00XfLNv+FKck7S9UjfdQDB3hGDCu33QZskb5Wh9YdvcAoPbuAPsd9o4wFxE/9SNAl+CRKP9hdDd
 yWrafmreq0UrhR9FnJ7r13IVAvCLWR7HGU9+mi9F37BcuLIIqPuRCdk0942i1Q==
X-Received: by 2002:a05:600c:4709:b0:49d:433:c3b6 with SMTP id
 5b1f17b1804b1-49e7a67831dmr35839465e9.27.1789395529571; 
 Mon, 14 Sep 2026 07:18:49 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e6ca584f8sm219005555e9.6.2026.09.14.07.18.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 07:18:49 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 14 Sep 2026 14:18:32 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 22
X-Gerrit-Change-Id: I375a41749060b7d006647bc27002c55436c8a8bb
X-Gerrit-Change-Number: 1748
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1748?usp=email>
X-Gerrit-Commit: db934865ff5bd847977f39b3823d18e6662241fc
In-Reply-To: <gerrit.1782719911000.I375a41749060b7d006647bc27002c55436c8a8bb@gerrit.openvpn.net>
References: <gerrit.1782719911000.I375a41749060b7d006647bc27002c55436c8a8bb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkzNzVhNDE3NDkwNjBiN2QwMDY2NDdiYzI3MDAyYzU1NDM2YzhhOGJiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5ca99ccfe284ebdb14efa2bdea3053a0910ad354-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x67WK-0006eH-EA
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
Content-Type: multipart/mixed; boundary="===============5416001901639939170=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5416001901639939170==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oFWAf4n+s+c="; charset=UTF-8

--oFWAf4n+s+c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici, stipa=2E

Hello=
 plaisthos, ralf_lici, 

I'd like you to reexamine a change=2E Please visit=


    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1748?usp=3Demail

to look a=
t the new patch set (#22)=2E

The following approvals got outdated and were=
 removed:
Code-Review-1 by ralf_lici


Change subject: oob: Measure probe R=
TT for candidate-band selection
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

oob: Measure probe RTT for candidate-band selection

Re=
cord each probe's round-trip time (per-target send timestamp vs reply
arriv=
al) and feed it to oob_rank_probe_results(), where RTT forms the
candidate =
band: responders within the effective margin of the fastest
compete on weig=
ht, slower ones fall behind=2E Log the measured RTT and the
effective margi=
n (with its source: client or server-advertised) at verb
4=2E

Before this =
the client never measured RTT, so every responder sat in the
band and selec=
tion was purely weighted-random; with real measurements
the latency-based c=
andidate selection takes effect=2E

The timestamp is taken at the first sen=
d=2E A reply carries nothing that
ties it to a send round, so measuring fro=
m a resend would report a
server slower than one round as fast, and could r=
ank it ahead of a
genuinely faster one=2E Entries that resolve to the same =
address share the
send time of the single probe=2E

The RTT therefore runs =
from the first send to the moment the client
reads the reply: it compares s=
ervers, it is not a network measurement=2E A
probe that needed a resend rea=
ds high; the resend exists so that a
dropped probe does not make a live ser=
ver look dead, not to refine the
measurement=2E

Change-Id: I375a41749060b7=
d006647bc27002c55436c8a8bb
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
=
---
M doc/man-sections/client-options=2Erst
M src/openvpn/oob=2Eh
M src/ope=
nvpn/oob_client=2Ec
3 files changed, 62 insertions(+), 17 deletions(-)


  =
git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/48/1748/22=


diff --git a/doc/man-sections/client-options=2Erst b/doc/man-sections/cli=
ent-options=2Erst
index 6eff520=2E=2E766e3bc 100644
--- a/doc/man-sections/=
client-options=2Erst
+++ b/doc/man-sections/client-options=2Erst
@@ -608,9 =
+608,14 @@
   remote, and each answering server replies with its advertised=
 priority
   and weight=2E Remotes are then reordered following DNS SRV (RF=
C 2782)
   semantics: servers that answered are tried before those that did=
 not,
-  grouped by priority (lowest first); within a priority group, serve=
rs are
-  picked by weighted-random selection=2E Round-trip time is not yet=
 taken
-  into account, so ``max-latency-diff`` has no effect for now=2E
+ =
 grouped by priority (lowest first); within a priority group, servers
+  wh=
ose measured round-trip time is within ``max-latency-diff``
+  milliseconds=
 of the fastest one are picked by weighted-random
+  selection, the others =
follow in round-trip-time order=2E When
+  ``max-latency-diff`` is not give=
n, each answering server's own
+  advertised margin decides whether that se=
rver stays a candidate, so a
+  server advertising :code:`0` asks to be con=
sidered only while it ties
+  the fastest of its priority group, without co=
nstraining the others=2E
 
   The probe is currently sent without control-c=
hannel wrapping, so it only
   works against a server configured without ``=
--tls-auth``,
diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh
index =
2eb8d4f=2E=2Eebdcd3f 100644
--- a/src/openvpn/oob=2Eh
+++ b/src/openvpn/oob=
=2Eh
@@ -196,6 +196,7 @@
     struct openvpn_sockaddr dest;
     socklen_t =
destlen;
     bool sent;
+    struct timeval sent_at; /* when the first pro=
be went out, for the RTT */
 };
 
 /**
diff --git a/src/openvpn/oob_client=
=2Ec b/src/openvpn/oob_client=2Ec
index 16217c7=2E=2E61e2602 100644
--- a/s=
rc/openvpn/oob_client=2Ec
+++ b/src/openvpn/oob_client=2Ec
@@ -60,9 +60,11 =
@@
 struct probe_ctx
 {
     socket_descriptor_t sd[PROBE_AF_COUNT]; /* SOC=
KET_UNDEFINED if that AF is unavailable */
-    /* Addresses probed so far =
in the current send round: an address several
-     * entries resolve to is=
 probed once, and its reply is credited to each=2E */
+    /* Addresses pro=
bed so far in the current send round, with the time each
+     * went out: =
an address several entries resolve to is probed once, and its
+     * reply=
 is credited to each of them with the same RTT=2E */
     struct openvpn_so=
ckaddr *probed;
+    struct timeval *probed_at;
     int n_probed;
 #ifdef =
TARGET_ANDROID
     bool fd_protected[PROBE_AF_COUNT]; /* VPNService protec=
t(), once per socket */
@@ -277,10 +279,18 @@
     /* Credit the reply to e=
very still-unanswered remote probed at its source
      * address: several =
entries can resolve to the same address, and each takes
      * the first r=
eply for it=2E */
+    struct timeval rcv;
+    openvpn_gettimeofday(&rcv, =
NULL);
     int i =3D oob_probe_next_target_at(from, targets, results, n, 0=
);
     while (i >=3D 0)
     {
+        /* From this round's send to now, =
i=2Ee=2E including any time the reply
+         * waited in the receive que=
ue while we were still sending=2E */
+        long ms =3D (long)(rcv=2Etv_s=
ec - targets[i]=2Esent_at=2Etv_sec) * 1000
+                  + (rcv=2Etv_u=
sec - targets[i]=2Esent_at=2Etv_usec) / 1000;
+
         results[i]=2Erespo=
nded =3D true;
+        results[i]=2Ertt_ms =3D (ms > 0) ? (unsigned int)ms=
 : 0;
         results[i]=2Ereply =3D reply;
 
         i =3D oob_probe_nex=
t_target_at(from, targets, results, n, i + 1);
@@ -368,23 +378,34 @@
 /* Re=
send the probe to every remote that we probed but that has not answered=2E =
*/
 static void
 oob_probe_resend_unanswered(struct probe_ctx *pc, const st=
ruct buffer *probe,
-                            const struct oob_probe_tar=
get *targets,
+                            struct oob_probe_target *targets=
,
                             const struct oob_probe_result *results, int =
n)
 {
-    pc->n_probed =3D 0; /* a new round: probe each unanswered addres=
s once again */
+    /* A new round: every unanswered address is probed onc=
e more=2E The send time
+     * is left alone, so the RTT keeps measuring f=
rom the first send=2E */
+    pc->n_probed =3D 0;
     for (int i =3D 0; i =
< n; i++)
     {
-        if (!targets[i]=2Esent || results[i]=2Eresponded
=
-            || oob_addr_list_find(pc->probed, pc->n_probed, &targets[i]=2E=
dest) >=3D 0)
+        if (!targets[i]=2Esent || results[i]=2Eresponded)
+ =
       {
+            continue;
+        }
+        if (oob_addr_list_find(=
pc->probed, pc->n_probed, &targets[i]=2Edest) >=3D 0)
         {
          =
   continue;
         }
         socket_descriptor_t sd =3D pc->sd[probe_af=
_index(targets[i]=2Edest=2Eaddr=2Esa=2Esa_family)];
-        if (sd !=3D SO=
CKET_UNDEFINED
-            && sendto(sd, (const char *)CBPTR(probe), (int)=
BLEN(probe), 0,
-                      (const struct sockaddr *)&targets[i]=
=2Edest, targets[i]=2Edestlen)
-                   >=3D 0)
+        if (sd =
=3D=3D SOCKET_UNDEFINED)
         {
+            continue;
+        }
+    =
    struct timeval sent_at;
+        openvpn_gettimeofday(&sent_at, NULL);
=
+        if (sendto(sd, (const char *)CBPTR(probe), (int)BLEN(probe), 0,
+ =
                  (const struct sockaddr *)&targets[i]=2Edest, targets[i]=
=2Edestlen)
+            >=3D 0)
+        {
+            pc->probed_at[pc->=
n_probed] =3D sent_at;
             pc->probed[pc->n_probed++] =3D targets[=
i]=2Edest;
         }
     }
@@ -397,7 +418,7 @@
  * once the window elapse=
s or every sent probe has been answered=2E */
 static void
 oob_probe_colle=
ct(struct probe_ctx *pc, const struct buffer *probe,
-                  con=
st struct session_id *client_sid, const struct oob_probe_target *targets,
+=
                  const struct session_id *client_sid, struct oob_probe_tar=
get *targets,
                   struct oob_probe_result *results, int n,
 =
                  const struct signal_info *sig)
 {
@@ -572,6 +593,7 @@
   =
   * An address several entries resolve to is probed once; its reply is
   =
   * credited to each of them=2E */
     pc=2Eprobed =3D gc_malloc(sizeof(*=
pc=2Eprobed) * l->len, false, &gc);
+    pc=2Eprobed_at =3D gc_malloc(sizeo=
f(*pc=2Eprobed_at) * l->len, false, &gc);
     pc=2En_probed =3D 0;
 
     =
int sent_count =3D 0;
@@ -598,8 +620,16 @@
             pc=2Efd_protected[a=
f] =3D true;
         }
 #endif
-        if (oob_addr_list_find(pc=2Eprobed=
, pc=2En_probed, &targets[i]=2Edest) < 0)
+        const int seen =3D oob_a=
ddr_list_find(pc=2Eprobed, pc=2En_probed, &targets[i]=2Edest);
+        if =
(seen >=3D 0)
         {
+            /* Already probed this round by an ea=
rlier entry: reuse that send
+             * time, so both entries report t=
he same RTT for the one reply=2E */
+            targets[i]=2Esent_at =3D p=
c=2Eprobed_at[seen];
+        }
+        else
+        {
+            openv=
pn_gettimeofday(&targets[i]=2Esent_at, NULL);
             if (sendto(sd, (=
const char *)BPTR(&probe), (int)BLEN(&probe), 0,
                        (s=
truct sockaddr *)&targets[i]=2Edest, targets[i]=2Edestlen)
                =
 < 0)
@@ -607,6 +637,7 @@
                 msg(D_LOW, "server-probe: %s:%s:=
 probe send failed", ce->remote, ce->remote_port);
                 continu=
e;
             }
+            pc=2Eprobed_at[pc=2En_probed] =3D targets[i]=
=2Esent_at;
             pc=2Eprobed[pc=2En_probed++] =3D targets[i]=2Edest=
;
         }
         targets[i]=2Esent =3D true;
@@ -632,8 +663,16 @@
    =
     if (results[i]=2Eresponded)
         {
             responded++;
-    =
        msg(D_LOW, "server-probe: %s:%s answered (priority %d, weight %d)",=
 ce->remote,
-                ce->remote_port, results[i]=2Ereply=2Epriorit=
y, results[i]=2Ereply=2Eweight);
+            /* Effective candidate-band m=
argin and where it came from: the
+             * client's own setting wins=
, else the server's advertised value=2E */
+            int client_margin =
=3D c->options=2Eserver_probe_latency_margin;
+            int margin =3D o=
ob_effective_margin(&results[i], client_margin);
+            const char *m=
argin_src =3D client_margin >=3D 0 ? "client" : "server-advertised";
+     =
       msg(D_LOW,
+                "server-probe: %s:%s answered (priority =
%d, weight %d, rtt %u ms;"
+                " latency margin %d ms [%s])",
=
+                ce->remote, ce->remote_port, results[i]=2Ereply=2Epriority=
, results[i]=2Ereply=2Eweight,
+                results[i]=2Ertt_ms, margin=
, margin_src);
         }
         else
         {

-- 
To view, visit http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1748?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: I375a41749060b7d006647bc27002c55436c8a8bb=

Gerrit-Change-Number: 1748
Gerrit-PatchSet: 22
Gerrit-Owner: stipa <lstipa=
kov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Attention: ralf_lici <ralf@mandelbit=2Ecom>
Ge=
rrit-Attention: stipa <lstipakov@gmail=2Ecom>

--oFWAf4n+s+c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici, stipa=2E </p>
<p>stipa <strong>=
uploaded patch set #22</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1748?usp=3Demail">View Change</a></p><p>T=
he following approvals got outdated and were removed:
Code-Review-1 by ralf=
_lici</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">oob: Measure probe RTT for candidate-band selection<=
br><br>Record each probe&#39;s round-trip time (per-target send timestamp v=
s reply<br>arrival) and feed it to oob_rank_probe_results(), where RTT form=
s the<br>candidate band: responders within the effective margin of the fast=
est<br>compete on weight, slower ones fall behind=2E Log the measured RTT a=
nd the<br>effective margin (with its source: client or server-advertised) a=
t verb<br>4=2E<br><br>Before this the client never measured RTT, so every r=
esponder sat in the<br>band and selection was purely weighted-random; with =
real measurements<br>the latency-based candidate selection takes effect=2E<=
br><br>The timestamp is taken at the first send=2E A reply carries nothing =
that<br>ties it to a send round, so measuring from a resend would report a<=
br>server slower than one round as fast, and could rank it ahead of a<br>ge=
nuinely faster one=2E Entries that resolve to the same address share the<br=
>send time of the single probe=2E<br><br>The RTT therefore runs from the fi=
rst send to the moment the client<br>reads the reply: it compares servers, =
it is not a network measurement=2E A<br>probe that needed a resend reads hi=
gh; the resend exists so that a<br>dropped probe does not make a live serve=
r look dead, not to refine the<br>measurement=2E<br><br>Change-Id: I375a417=
49060b7d006647bc27002c55436c8a8bb<br>Signed-off-by: Lev Stipakov &lt;lev@op=
envpn=2Enet&gt;<br>---<br>M doc/man-sections/client-options=2Erst<br>M src/=
openvpn/oob=2Eh<br>M src/openvpn/oob_client=2Ec<br>3 files changed, 62 inse=
rtions(+), 17 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/48/1748/22</pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/doc/man-sections/client-options=2Erst b/doc/man-sections/client-options=2E=
rst</span><br><span>index 6eff520=2E=2E766e3bc 100644</span><br><span>--- a=
/doc/man-sections/client-options=2Erst</span><br><span>+++ b/doc/man-sectio=
ns/client-options=2Erst</span><br><span>@@ -608,9 +608,14 @@</span><br><spa=
n>   remote, and each answering server replies with its advertised priority=
</span><br><span>   and weight=2E Remotes are then reordered following DNS =
SRV (RFC 2782)</span><br><span>   semantics: servers that answered are trie=
d before those that did not,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-  grouped by priority (lowest first); within a priority group, serve=
rs are</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  picked by wei=
ghted-random selection=2E Round-trip time is not yet taken</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-  into account, so ``max-latency-diff`=
` has no effect for now=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  grouped by priority (lowest first); within a priority group, serve=
rs</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  whose measured =
round-trip time is within ``max-latency-diff``</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  milliseconds of the fastest one are picked by =
weighted-random</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  se=
lection, the others follow in round-trip-time order=2E When</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  ``max-latency-diff`` is not given=
, each answering server&#39;s own</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  advertised margin decides whether that server stays a candi=
date, so a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  server =
advertising :code:`0` asks to be considered only while it ties</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  the fastest of its priority gr=
oup, without constraining the others=2E</span><br><span> </span><br><span> =
  The probe is currently sent without control-channel wrapping, so it only<=
/span><br><span>   works against a server configured without ``--tls-auth``=
,</span><br><span>diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh</s=
pan><br><span>index 2eb8d4f=2E=2Eebdcd3f 100644</span><br><span>--- a/src/o=
penvpn/oob=2Eh</span><br><span>+++ b/src/openvpn/oob=2Eh</span><br><span>@@=
 -196,6 +196,7 @@</span><br><span>     struct openvpn_sockaddr dest;</span>=
<br><span>     socklen_t destlen;</span><br><span>     bool sent;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct timeval sent_at; /=
* when the first probe went out, for the RTT */</span><br><span> };</span><=
br><span> </span><br><span> /**</span><br><span>diff --git a/src/openvpn/oo=
b_client=2Ec b/src/openvpn/oob_client=2Ec</span><br><span>index 16217c7=2E=
=2E61e2602 100644</span><br><span>--- a/src/openvpn/oob_client=2Ec</span><b=
r><span>+++ b/src/openvpn/oob_client=2Ec</span><br><span>@@ -60,9 +60,11 @@=
</span><br><span> struct probe_ctx</span><br><span> {</span><br><span>     =
socket_descriptor_t sd[PROBE_AF_COUNT]; /* SOCKET_UNDEFINED if that AF is u=
navailable */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* A=
ddresses probed so far in the current send round: an address several</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-     * entries resolve to is=
 probed once, and its reply is credited to each=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Addresses probed so far in the cur=
rent send round, with the time each</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * went out: an address several entries resolve to is p=
robed once, and its</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     * reply is credited to each of them with the same RTT=2E */</span><br>=
<span>     struct openvpn_sockaddr *probed;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct timeval *probed_at;</span><br><span>    =
 int n_probed;</span><br><span> #ifdef TARGET_ANDROID</span><br><span>     =
bool fd_protected[PROBE_AF_COUNT]; /* VPNService protect(), once per socket=
 */</span><br><span>@@ -277,10 +279,18 @@</span><br><span>     /* Credit th=
e reply to every still-unanswered remote probed at its source</span><br><sp=
an>      * address: several entries can resolve to the same address, and ea=
ch takes</span><br><span>      * the first reply for it=2E */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct timeval rcv;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_gettimeofday(&amp=
;rcv, NULL);</span><br><span>     int i =3D oob_probe_next_target_at(from, =
targets, results, n, 0);</span><br><span>     while (i &gt;=3D 0)</span><br=
><span>     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  /* From this round&#39;s send to now, i=2Ee=2E including any time the rep=
ly</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * waited=
 in the receive queue while we were still sending=2E */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        long ms =3D (long)(rcv=2Etv_sec=
 - targets[i]=2Esent_at=2Etv_sec) * 1000</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                  + (rcv=2Etv_usec - targets[i]=2Esent=
_at=2Etv_usec) / 1000;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span>         results[i]=2Eresponded =3D true;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        results[i]=2Ertt_ms =3D (=
ms &gt; 0) ? (unsigned int)ms : 0;</span><br><span>         results[i]=2Ere=
ply =3D reply;</span><br><span> </span><br><span>         i =3D oob_probe_n=
ext_target_at(from, targets, results, n, i + 1);</span><br><span>@@ -368,23=
 +378,34 @@</span><br><span> /* Resend the probe to every remote that we pr=
obed but that has not answered=2E */</span><br><span> static void</span><br=
><span> oob_probe_resend_unanswered(struct probe_ctx *pc, const struct buff=
er *probe,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
                 const struct oob_probe_target *targets,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                            struct oob=
_probe_target *targets,</span><br><span>                             const =
struct oob_probe_result *results, int n)</span><br><span> {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    pc-&gt;n_probed =3D 0; /* a new r=
ound: probe each unanswered address once again */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* A new round: every unanswered address =
is probed once more=2E The send time</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     * is left alone, so the RTT keeps measuring from the =
first send=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 pc-&gt;n_probed =3D 0;</span><br><span>     for (int i =3D 0; i &lt; n; i+=
+)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        if (!targets[i]=2Esent || results[i]=2Eresponded</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            || oob_addr_list_find(pc=
-&gt;probed, pc-&gt;n_probed, &amp;targets[i]=2Edest) &gt;=3D 0)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if (!targets[i]=2Esent=
 || results[i]=2Eresponded)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          continue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if=
 (oob_addr_list_find(pc-&gt;probed, pc-&gt;n_probed, &amp;targets[i]=2Edest=
) &gt;=3D 0)</span><br><span>         {</span><br><span>             contin=
ue;</span><br><span>         }</span><br><span>         socket_descriptor_t=
 sd =3D pc-&gt;sd[probe_af_index(targets[i]=2Edest=2Eaddr=2Esa=2Esa_family)=
];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (sd !=3D=
 SOCKET_UNDEFINED</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        &amp;&amp; sendto(sd, (const char *)CBPTR(probe), (int)BLEN(probe),=
 0,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
    (const struct sockaddr *)&amp;targets[i]=2Edest, targets[i]=2Edestlen)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   &gt=
;=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (=
sd =3D=3D SOCKET_UNDEFINED)</span><br><span>         {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            continue;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        struct timeval sent_at;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        openvpn_gettimeofday(&amp;se=
nt_at, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if (sendto(sd, (const char *)CBPTR(probe), (int)BLEN(probe), 0,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                   (const str=
uct sockaddr *)&amp;targets[i]=2Edest, targets[i]=2Edestlen)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            &gt;=3D 0)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
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
=3D"display:none"> Gerrit-PatchSet: 22 </div>
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
--oFWAf4n+s+c=--


--===============5416001901639939170==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5416001901639939170==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5416001901639939170==--

