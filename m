Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B5AFCA5FC8
	for <openvpn-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=37ek+uiv9ZOzPC0K6kmIqSGd6gwObwYftCuLQvl/i5M=; b=CkWDu7pnZY9TUSXjyfDmwNBqOC
	5f8g+/ifMPA8D81v/JppS1k4zpb7hKpZLW/+I1ptiKCsVPIRMsVQ4fhIvCFEZyvdIo6pVoY0meWPl
	aI/EAKYVOF5BHNpKGAHmHru+cTL0Jl24Aw49O8w9BVxOEpC3uJlRCkVxrnpqKWGdeh3U=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBpeD-0003Zj-KZ;
	Wed, 30 Sep 2026 08:26:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBpdy-0003YZ-UD
 for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 08:26:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=cTMzzJS3t6dGTPuSs87OFPI+sOXTqpXakbyXG9ds/XY=; b=GciSYmcnA7UVkAcz8+kPRr+Snk
 luIZvZZ7LuqXv/Ohouax55thfPljhQ86t4ztTCfiFs+z2kiDA5oy1fGyW23ui+cg/rH72jt1VEccR
 hEUXbJBPSz+eAFHlHkf6KhPEusTKC56SU/DZ+gyHoKXY0efoj3NaZLQlHn6G/bs5Ai94=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=cTMzzJS3t6dGTPuSs87OFPI+sOXTqpXakbyXG9ds/XY=; b=O
 D/spPZxko5SYNb+zcO3lF+lY5WjtUPsRgiLr7uPz7fy1Rp4xx4bfWLvfDYs0LaaRDOLGCJ88XyV/f
 0z/P1xyc8PUxVex4Brvth9/p2lji+KbTHb3P9MK6cD9QAr3VHTNqkfAQeY0AJ4S+RR7caN8DxmBqV
 IHdMkGl09bwBnBy8=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBpda-0006jx-1i for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 08:26:04 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49b912d3920so37753035e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 30 Sep 2026 01:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790756755; x=1791361555; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cTMzzJS3t6dGTPuSs87OFPI+sOXTqpXakbyXG9ds/XY=;
 b=JA2Bgb4GjCQ5aPfljs/jc5z2vfCVsWmvYvVUJupnNbjW/hSRRjEEQBbFa8VF6yDISH
 kILTSI7i+G9coej5T/t9u+TtQhS03ZiBcaeDmPIiavaCxZblnKo03lq1z8J+RgSp8d8r
 QBvktRjkNBTmmvWrFU/Llj0dgid0hegAzsmM/jw98tLUIhLcTKJ3VLaDSyGpeH6xl+bd
 1I0iQqlWBtFsw/b90tF7byeZFrBiBmW+vUlEyLvAyfcJAnPuWWX4GZQYwEKaZK5TkEQX
 fQ/xkj/cvgu9UK382tVHKmn8vsklQcDt70Zgo0en4ROKcVTqgYXs2E7UNtcW4TfKw2Gs
 xfIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790756755; x=1791361555;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cTMzzJS3t6dGTPuSs87OFPI+sOXTqpXakbyXG9ds/XY=;
 b=kd3Y1KoASiv6dWWs1drMBENLXUYIQxbULBys4ItsJPmQ2e0GgcZaNYs7H6+odxQgs5
 GM/Z1/GXk/e/jyjo62CXod8esN+qvVLNPHTUypLj0AX1KedCYicCh1S3i3cZ3RGMVQSV
 MKhrdQDie15xanG4h0JAycq2ofmrH7+yC98du8I9tkwChyOtRIXZXzLfLZH+OBA9La1q
 VWDl5AHNy8vGi2qhugO1fY/VYQ+qkY+RgvmARBUAlZ0i5YjMqjXhUiKirm6Xq8phsY4o
 +DIIUnukqxGPyTm1sf4pL7kg3qdVl9peWVUU36ev3itxgEyqjC26IyuXS7yxnGPT0f1v
 vn/A==
X-Gm-Message-State: AFuF++lmgV4Lj1pEX+Wi1bojCJtEUEYpvZNJNn19MpSzD41glYqfjM6a
 4Z00zY7zbVAJ/NWix5cA9HL+qBC7myr6a+va949hjQ3fAvo1/MrEqL+ZvlNae9OX8acO9muWIgc
 02u1XEwtTPAHhKGijfLeXI1xUR2G9bukeShCmhv8l4ORxE+q5bm1i5iPOTK9Oiu/bP4tH
X-Gm-Gg: AYBFou0a0C4iCZ1tFq3TmKrFwHfEFJnRcD+Pp5dqM7T3CJO18sPsvsaXS0PbRAdSEAg
 8ethElsQuydbJWTpUiCZMVYF8qFYhCDD+rpW09x+TEGxxLpW82BADQcIID7V6979eFlZOsJV7/o
 9nT6mBVDWbusuqT8irZtLxb86htyLR9ZpXavsqo6XENFWjVgrGcwZCH9dBQDZyxImnwvl4HGha1
 NZKdAqECffqfwJGPA4wQA1KNzIEuXEvQ6zUCaB4uvRXds13d9k+bf7ZALj0YXixI5nvX2DaT+8W
 TsXBUa2nE1TwZbrU0ApPa+rJZeYFlYtnCf0V5I6lKeeVON+3jYZdPkSTdcLbvD1NxID8zbwHALH
 qF7dcNpKoJP2QBcaizFjPuNfiN5eDA9BpgHMvrXwbX/1kBKZDNCcIYec+XZJauG6jsBJXOnhO6x
 Z3w9tHpGmM2TS9tNOxWL5ImOirzGpHeKZYTkQAI/rRysYT4RrolsABLo7YPmnQDuB2RANSaLzWF
 l1Uv3JfMgbuLotaTs3e4DucKmN37vZiD0pN0iN4P6xx2i6f/qWVzQzR5XIlrh9QtCE25GhaCFsO
 ZZE7JST6anlKu5UYNekDQwakUOx0zT56Py4EQaoswRSuQyyTZYXKr3QTOwCE
X-Received: by 2002:a05:600c:1547:b0:4a0:1323:334b with SMTP id
 5b1f17b1804b1-4a01affdf60mr10544585e9.12.1790756754956; 
 Wed, 30 Sep 2026 01:25:54 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a015cd1282sm53089315e9.4.2026.09.30.01.25.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 01:25:54 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 30 Sep 2026 08:25:29 +0000
To: ralf_lici <ralf@mandelbit.com>,
	plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 30
X-Gerrit-Change-Id: I375a41749060b7d006647bc27002c55436c8a8bb
X-Gerrit-Change-Number: 1748
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1748?usp=email>
X-Gerrit-Commit: c32cf79e6d08af6ddccfb73d6dfe9a97877e6889
In-Reply-To: <gerrit.1782719911000.I375a41749060b7d006647bc27002c55436c8a8bb@gerrit.openvpn.net>
References: <gerrit.1782719911000.I375a41749060b7d006647bc27002c55436c8a8bb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkzNzVhNDE3NDkwNjBiN2QwMDY2NDdiYzI3MDAyYzU1NDM2YzhhOGJiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2422ac27ccc68ebac6c0e000eec537e7b824f931-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBpda-0006jx-1i
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
Content-Type: multipart/mixed; boundary="===============3109375674196256496=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3109375674196256496==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Tf3lhfIAS7I="; charset=UTF-8

--Tf3lhfIAS7I=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici, stipa=2E

Hello=
 plaisthos, ralf_lici, 

I'd like you to reexamine a change=2E Please visit=


    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1748?usp=3Demail

to look a=
t the new patch set (#30)=2E


Change subject: oob: Measure probe RTT for c=
andidate-band selection
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

oob: Measure probe RTT for candidate-band selection

Until now t=
he client never measured RTT, so every responder sat in the
candidate band =
and selection was purely weighted-random=2E

Record each probe's round-trip=
 time (the send time of the transmission a
reply answers vs the reply's arr=
ival) and feed it to
oob_rank_probe_results(), where RTT forms the candidat=
e band: responders
within the effective margin of the fastest compete on we=
ight, slower
ones fall behind=2E Log the measured RTT and the effective mar=
gin (with
its source: client or server-advertised) at verb 4=2E

A reply na=
mes the probe it answers by its request_id, so a reply to a
resend is measu=
red from the resend and a late reply to the first send
still reads as slow=
=2E A reply whose request_id names no probe sent to
its source address is d=
ropped=2E Entries that resolve to the same address
share the one probe, and=
 so its RTT=2E

The RTT runs up to the moment the client reads the reply: i=
t compares
servers, it is not a network measurement=2E

Change-Id: I375a417=
49060b7d006647bc27002c55436c8a8bb
Signed-off-by: Lev Stipakov <lev@openvpn=
=2Enet>
---
M doc/man-sections/client-options=2Erst
M src/openvpn/oob=2Ec
M=
 src/openvpn/oob=2Eh
M src/openvpn/oob_client=2Ec
M tests/unit_tests/openvp=
n/test_oob=2Ec
5 files changed, 109 insertions(+), 16 deletions(-)


  git =
pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/48/1748/30

di=
ff --git a/doc/man-sections/client-options=2Erst b/doc/man-sections/client-=
options=2Erst
index c49d184=2E=2E9835403 100644
--- a/doc/man-sections/clie=
nt-options=2Erst
+++ b/doc/man-sections/client-options=2Erst
@@ -608,9 +608=
,17 @@
   remote, and each answering server replies with its advertised pri=
ority
   and weight=2E Remotes are then reordered following DNS SRV (RFC 27=
82)
   semantics: servers that answered are tried before those that did not=
,
-  grouped by priority (lowest first); within a priority group, servers a=
re
-  picked by weighted-random selection=2E Round-trip time is not yet tak=
en
-  into account, so ``max-latency-diff`` has no effect for now=2E
+  gro=
uped by priority (lowest first); within a priority group, servers
+  whose =
measured round-trip time is within ``max-latency-diff``
+  milliseconds of =
the fastest one are picked by weighted-random
+  selection, the others foll=
ow in round-trip-time order=2E When
+  ``max-latency-diff`` is not given, t=
he margin advertised by the fastest
+  server of a priority group applies t=
o that group; the margins of the
+  slower servers play no part=2E A server=
 advertising :code:`0` thus says
+  that, when it is the fastest, only serv=
ers tying it count as equal=2E A
+  value of :code:`1000` or more makes eve=
ry answering server of a
+  priority group a candidate, since replies only =
arrive within the
+  one-second probe window; the group is then ordered by =
weight alone=2E
 
   The probe is currently sent without control-channel wr=
apping, so it only
   works against a server configured without ``--tls-aut=
h``,
diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec
index d5ad8b9=
=2E=2E704be6e 100644
--- a/src/openvpn/oob=2Ec
+++ b/src/openvpn/oob=2Ec
@@=
 -133,6 +133,20 @@
     return -1;
 }
 
+int
+oob_probe_rtt_ms(const struct=
 oob_probe_send *sends, int n_sends, uint32_t index,
+                 cons=
t struct openvpn_sockaddr *from, const struct timeval *rcv)
+{
+    if (ind=
ex >=3D (uint32_t)n_sends || !addr_port_match(from, &sends[index]=2Edest))
=
+    {
+        return -1; /* not a probe we sent, or not to where the repl=
y came from */
+    }
+    const struct timeval *sent_at =3D &sends[index]=
=2Esent_at;
+    const long ms =3D (long)(rcv->tv_sec - sent_at->tv_sec) * =
1000
+                    + (rcv->tv_usec - sent_at->tv_usec) / 1000;
+    =
return (ms > 0) ? (int)ms : 0;
+}
+
 /* Base ordering: responders before no=
n-responders, then by priority (lower
  * first), then by RTT (lower first)=
, then by original index for determinism=2E
  * This groups responders into=
 priority runs pre-sorted by RTT, which the
diff --git a/src/openvpn/oob=2E=
h b/src/openvpn/oob=2Eh
index 918867d=2E=2E5821a1d 100644
--- a/src/openvpn=
/oob=2Eh
+++ b/src/openvpn/oob=2Eh
@@ -180,9 +180,25 @@
 struct oob_probe_s=
end
 {
     struct openvpn_sockaddr dest;
+    struct timeval sent_at;
 };
=
 
 /**
+ * Round-trip time of a reply, measured from the transmission it an=
swers=2E
+ *
+ * @param sends    every transmission so far
+ * @param n_sen=
ds  number of transmissions
+ * @param index    the transmission the reply =
names: its request_id minus the
+ *                 run's base
+ * @param f=
rom     source address of the reply
+ * @param rcv      when the reply arri=
ved
+ * @return milliseconds (0 if the clock went backwards), or -1 if inde=
x names
+ *         no transmission to from
+ */
+int oob_probe_rtt_ms(cons=
t struct oob_probe_send *sends, int n_sends, uint32_t index,
+             =
        const struct openvpn_sockaddr *from, const struct timeval *rcv);
+
=
+/**
  * Find the next entry, from index \p start on, that was probed at \p=
 from and
  * has not answered yet=2E Several entries can resolve to the sa=
me address, so a
  * reply is credited to each of them: call again with the=
 returned index + 1
diff --git a/src/openvpn/oob_client=2Ec b/src/openvpn/o=
ob_client=2Ec
index ab1f5b0=2E=2E276e21a 100644
--- a/src/openvpn/oob_clien=
t=2Ec
+++ b/src/openvpn/oob_client=2Ec
@@ -115,21 +115,29 @@
     return fa=
lse;
 }
 
-/* Send a probe with the next request_id to dest; false if it di=
d not go out=2E */
+/* Send a probe with the next request_id to dest, recor=
ding when it went out so
+ * a reply's RTT is measured from the transmissio=
n it answers; false if it did
+ * not go out=2E */
 static bool
 oob_probe_=
send_to(struct probe_ctx *pc, socket_descriptor_t sd,
                   co=
nst struct openvpn_sockaddr *dest, socklen_t destlen)
 {
     ASSERT(pc->n_=
sends < pc->max_sends);
+    struct oob_probe_send *s =3D &pc->sends[pc->n_=
sends];
     struct buffer probe;
-    if (!oob_probe_build(pc, pc->id_base=
 + (uint32_t)pc->n_sends, &probe)
-        || sendto(sd, (const char *)BPTR=
(&probe), (int)BLEN(&probe), 0,
-                  (const struct sockaddr *=
)dest, destlen)
-               < 0)
+    if (!oob_probe_build(pc, pc->id_b=
ase + (uint32_t)pc->n_sends, &probe))
     {
         return false;
     }
=
-    pc->sends[pc->n_sends++]=2Edest =3D *dest;
+    openvpn_gettimeofday(&=
s->sent_at, NULL);
+    if (sendto(sd, (const char *)BPTR(&probe), (int)BLE=
N(&probe), 0,
+               (const struct sockaddr *)dest, destlen)
+    =
    < 0)
+    {
+        return false;
+    }
+    s->dest =3D *dest;
+    =
pc->n_sends++;
     return true;
 }
 
@@ -284,7 +292,7 @@
     }
 }
 
-/* P=
arse one received datagram as a probe reply and, if valid and matching one
=
+/* Parse one received datagram as a probe reply and, if valid and answerin=
g one
  * of the probes we sent, record the reply in results=2E */
 static =
void
 oob_probe_handle_reply(const struct probe_ctx *pc, const uint8_t *dat=
a, int len,
@@ -308,11 +316,16 @@
     }
 
     /* The reply must echo the =
request_id of a probe sent to the address it came
-     * from; with a rand=
om id_base that also rejects spoofed replies=2E */
-    const uint32_t inde=
x =3D reply=2Erequest_id - pc->id_base;
-    if (index >=3D (uint32_t)pc->n=
_sends || !addr_port_match(from, &pc->sends[index]=2Edest))
+     * from; w=
ith a random id_base that also rejects spoofed replies=2E The RTT
+     * r=
uns from that transmission to now, i=2Ee=2E including any time the reply
+ =
    * waited in the receive queue while we were still sending=2E */
+    st=
ruct timeval rcv;
+    openvpn_gettimeofday(&rcv, NULL);
+    const int ms =
=3D
+        oob_probe_rtt_ms(pc->sends, pc->n_sends, reply=2Erequest_id - =
pc->id_base, from, &rcv);
+    if (ms < 0)
     {
-        return;
+       =
 return; /* answers no probe we sent to that address */
     }
 
     /* Cr=
edit the reply to every still-unanswered remote probed at its source
@@ -32=
2,6 +335,7 @@
     while (i >=3D 0)
     {
         results[i]=2Eresponded =
=3D true;
+        results[i]=2Ertt_ms =3D (unsigned int)ms;
         resul=
ts[i]=2Ereply =3D reply;
 
         i =3D oob_probe_next_target_at(from, ta=
rgets, results, n, i + 1);
@@ -662,8 +676,16 @@
         if (results[i]=2Er=
esponded)
         {
             responded++;
-            msg(D_LOW, "ser=
ver-probe: %s:%s answered (priority %d, weight %d)", ce->remote,
-         =
       ce->remote_port, results[i]=2Ereply=2Epriority, results[i]=2Ereply=
=2Eweight);
+            /* The margin this server advertised, or the clien=
t's override; only
+             * the fastest server's margin applies to i=
ts priority group=2E */
+            int client_margin =3D c->options=2Eser=
ver_probe_latency_margin;
+            int margin =3D oob_effective_margin(=
&results[i], client_margin);
+            const char *margin_src =3D client=
_margin >=3D 0 ? "client" : "server-advertised";
+            msg(D_LOW,
+ =
               "server-probe: %s:%s answered (priority %d, weight %d, rtt %=
u ms;"
+                " latency margin %d ms [%s])",
+                ce-=
>remote, ce->remote_port, results[i]=2Ereply=2Epriority, results[i]=2Ereply=
=2Eweight,
+                results[i]=2Ertt_ms, margin, margin_src);
     =
    }
         else
         {
diff --git a/tests/unit_tests/openvpn/test_o=
ob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec
index dc4070d=2E=2E221d1f0 1=
00644
--- a/tests/unit_tests/openvpn/test_oob=2Ec
+++ b/tests/unit_tests/op=
envpn/test_oob=2Ec
@@ -586,6 +586,38 @@
     assert_int_equal(oob_probe_nex=
t_target_at(&a_other_port, targets, results, 3, 0), -1);
 }
 
+/* The RTT o=
f a reply is measured from the transmission its request_id names (as
+ * an=
 index into the transmissions), which must have gone to the address the
+ *=
 reply came from=2E */
+static void
+test_probe_rtt_from_answered_send(void=
 **state)
+{
+    struct openvpn_sockaddr a =3D v4_addr(0x7f000001, 1194);
=
+    struct openvpn_sockaddr b =3D v4_addr(0x7f000002, 1194);
+    /* A at =
t=3D0 ms, B at t=3D20 ms, then A again at t=3D500 ms (a resend) */
+    con=
st struct oob_probe_send sends[3] =3D {
+        { =2Edest =3D a, =2Esent_a=
t =3D { =2Etv_sec =3D 1000, =2Etv_usec =3D 0 } },
+        { =2Edest =3D b,=
 =2Esent_at =3D { =2Etv_sec =3D 1000, =2Etv_usec =3D 20000 } },
+        { =
=2Edest =3D a, =2Esent_at =3D { =2Etv_sec =3D 1000, =2Etv_usec =3D 500000 }=
 },
+    };
+    struct timeval rcv =3D { =2Etv_sec =3D 1000, =2Etv_usec =
=3D 520000 };
+
+    assert_int_equal(oob_probe_rtt_ms(sends, 3, 2, &a, &rc=
v), 20);  /* the resend */
+    assert_int_equal(oob_probe_rtt_ms(sends, 3,=
 0, &a, &rcv), 520); /* the first send */
+    assert_int_equal(oob_probe_r=
tt_ms(sends, 3, 1, &b, &rcv), 500);
+
+    /* a transmission to another add=
ress, and ids we never sent (below the
+     * base, an id wraps to a huge =
index) */
+    assert_int_equal(oob_probe_rtt_ms(sends, 3, 1, &a, &rcv), -1=
);
+    assert_int_equal(oob_probe_rtt_ms(sends, 3, 3, &a, &rcv), -1);
+   =
 assert_int_equal(oob_probe_rtt_ms(sends, 3, UINT32_MAX, &a, &rcv), -1);
+ =
   assert_int_equal(oob_probe_rtt_ms(sends, 2, 2, &a, &rcv), -1);
+
+    /*=
 a clock that went backwards reads as 0, not as a huge value */
+    rcv=2E=
tv_usec =3D 0;
+    assert_int_equal(oob_probe_rtt_ms(sends, 3, 2, &a, &rcv=
), 0);
+}
+
 /* A payload of just a probe reply is found by the client scan=
, with all
  * fields surviving=2E */
 static void
@@ -974,6 +1006,7 @@
   =
      cmocka_unit_test(test_probe_request_check_no_request),
         cmock=
a_unit_test(test_probe_reply_credits_every_entry_at_address),
         cmoc=
ka_unit_test(test_probe_reply_matches_only_its_address),
+        cmocka_un=
it_test(test_probe_rtt_from_answered_send),
         cmocka_unit_test(test_=
probe_reply_find),
         cmocka_unit_test(test_probe_reply_find_skips_un=
known),
         cmocka_unit_test(test_probe_reply_find_rejects_unknown_man=
datory),

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1748=
?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchs=
et
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I375a417=
49060b7d006647bc27002c55436c8a8bb
Gerrit-Change-Number: 1748
Gerrit-PatchSe=
t: 30
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaistho=
s <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=
=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: stipa =
<lstipakov@gmail=2Ecom>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=
=2Eorg>

--Tf3lhfIAS7I=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici, stipa=2E </p>
<p>stipa <strong>=
uploaded patch set #30</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1748?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">oob: Measure probe RTT for candidate-band selection<br><br>Until =
now the client never measured RTT, so every responder sat in the<br>candida=
te band and selection was purely weighted-random=2E<br><br>Record each prob=
e&#39;s round-trip time (the send time of the transmission a<br>reply answe=
rs vs the reply&#39;s arrival) and feed it to<br>oob_rank_probe_results(), =
where RTT forms the candidate band: responders<br>within the effective marg=
in of the fastest compete on weight, slower<br>ones fall behind=2E Log the =
measured RTT and the effective margin (with<br>its source: client or server=
-advertised) at verb 4=2E<br><br>A reply names the probe it answers by its =
request_id, so a reply to a<br>resend is measured from the resend and a lat=
e reply to the first send<br>still reads as slow=2E A reply whose request_i=
d names no probe sent to<br>its source address is dropped=2E Entries that r=
esolve to the same address<br>share the one probe, and so its RTT=2E<br><br=
>The RTT runs up to the moment the client reads the reply: it compares<br>s=
ervers, it is not a network measurement=2E<br><br>Change-Id: I375a41749060b=
7d006647bc27002c55436c8a8bb<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=
=2Enet&gt;<br>---<br>M doc/man-sections/client-options=2Erst<br>M src/openv=
pn/oob=2Ec<br>M src/openvpn/oob=2Eh<br>M src/openvpn/oob_client=2Ec<br>M te=
sts/unit_tests/openvpn/test_oob=2Ec<br>5 files changed, 109 insertions(+), =
16 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/48/1748/30</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/doc/man-s=
ections/client-options=2Erst b/doc/man-sections/client-options=2Erst</span>=
<br><span>index c49d184=2E=2E9835403 100644</span><br><span>--- a/doc/man-s=
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
color: hsl(120, 100%, 40%);">+  ``max-latency-diff`` is not given, the marg=
in advertised by the fastest</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  server of a priority group applies to that group; the margins of=
 the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  slower server=
s play no part=2E A server advertising :code:`0` thus says</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  that, when it is the fastest, only=
 servers tying it count as equal=2E A</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  value of :code:`1000` or more makes every answering ser=
ver of a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  priority =
group a candidate, since replies only arrive within the</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  one-second probe window; the group is=
 then ordered by weight alone=2E</span><br><span> </span><br><span>   The p=
robe is currently sent without control-channel wrapping, so it only</span><=
br><span>   works against a server configured without ``--tls-auth``,</span=
><br><span>diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec</span><br=
><span>index d5ad8b9=2E=2E704be6e 100644</span><br><span>--- a/src/openvpn/=
oob=2Ec</span><br><span>+++ b/src/openvpn/oob=2Ec</span><br><span>@@ -133,6=
 +133,20 @@</span><br><span>     return -1;</span><br><span> }</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_rtt_ms(const struct =
oob_probe_send *sends, int n_sends, uint32_t index,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                 const struct openvpn_soc=
kaddr *from, const struct timeval *rcv)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (index &gt;=3D (uint32_t)n_sends || !addr_port_match(from, &amp;se=
nds[index]=2Edest))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return=
 -1; /* not a probe we sent, or not to where the reply came from */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const struct timeval *sent_at =3D &am=
p;sends[index]=2Esent_at;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    const long ms =3D (long)(rcv-&gt;tv_sec - sent_at-&gt;tv_sec) * 1=
000</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
    + (rcv-&gt;tv_usec - sent_at-&gt;tv_usec) / 1000;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return (ms &gt; 0) ? (int)ms : 0;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* Base ordering: respo=
nders before non-responders, then by priority (lower</span><br><span>  * fi=
rst), then by RTT (lower first), then by original index for determinism=2E<=
/span><br><span>  * This groups responders into priority runs pre-sorted by=
 RTT, which the</span><br><span>diff --git a/src/openvpn/oob=2Eh b/src/open=
vpn/oob=2Eh</span><br><span>index 918867d=2E=2E5821a1d 100644</span><br><sp=
an>--- a/src/openvpn/oob=2Eh</span><br><span>+++ b/src/openvpn/oob=2Eh</spa=
n><br><span>@@ -180,9 +180,25 @@</span><br><span> struct oob_probe_send</sp=
an><br><span> {</span><br><span>     struct openvpn_sockaddr dest;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct timeval sent_at;<=
/span><br><span> };</span><br><span> </span><br><span> /**</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * Round-trip time of a reply, measu=
red from the transmission it answers=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @param sends    every transmission so far</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @param n_sends  number of transmissions</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param index    the t=
ransmission the reply names: its request_id minus the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *                 run&#39;s base</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param from     source a=
ddress of the reply</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @param rcv      when the reply arrived</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @return milliseconds (0 if the clock went backward=
s), or -1 if index names</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *         no transmission to from</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+int oob_probe_rtt_ms(const struct oob_probe_send *sends, int n_sends, u=
int32_t index,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                const struct openvpn_sockaddr *from, const struct timeval *=
rcv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span>  * Find the =
next entry, from index \p start on, that was probed at \p from and</span><b=
r><span>  * has not answered yet=2E Several entries can resolve to the same=
 address, so a</span><br><span>  * reply is credited to each of them: call =
again with the returned index + 1</span><br><span>diff --git a/src/openvpn/=
oob_client=2Ec b/src/openvpn/oob_client=2Ec</span><br><span>index ab1f5b0=
=2E=2E276e21a 100644</span><br><span>--- a/src/openvpn/oob_client=2Ec</span=
><br><span>+++ b/src/openvpn/oob_client=2Ec</span><br><span>@@ -115,21 +115=
,29 @@</span><br><span>     return false;</span><br><span> }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Send a probe wi=
th the next request_id to dest; false if it did not go out=2E */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/* Send a probe with the next =
request_id to dest, recording when it went out so</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * a reply&#39;s RTT is measured from the tra=
nsmission it answers; false if it did</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * not go out=2E */</span><br><span> static bool</span><b=
r><span> oob_probe_send_to(struct probe_ctx *pc, socket_descriptor_t sd,</s=
pan><br><span>                   const struct openvpn_sockaddr *dest, sockl=
en_t destlen)</span><br><span> {</span><br><span>     ASSERT(pc-&gt;n_sends=
 &lt; pc-&gt;max_sends);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct oob_probe_send *s =3D &amp;pc-&gt;sends[pc-&gt;n_sends];</s=
pan><br><span>     struct buffer probe;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    if (!oob_probe_build(pc, pc-&gt;id_base + (uint32_t)p=
c-&gt;n_sends, &amp;probe)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        || sendto(sd, (const char *)BPTR(&amp;probe), (int)BLEN(&amp;p=
robe), 0,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
      (const struct sockaddr *)dest, destlen)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-               &lt; 0)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (!oob_probe_build(pc, pc-&gt;id_base + (u=
int32_t)pc-&gt;n_sends, &amp;probe))</span><br><span>     {</span><br><span=
>         return false;</span><br><span>     }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    pc-&gt;sends[pc-&gt;n_sends++]=2Edest =3D *des=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_getti=
meofday(&amp;s-&gt;sent_at, NULL);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (sendto(sd, (const char *)BPTR(&amp;probe), (int)BLEN=
(&amp;probe), 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
            (const struct sockaddr *)dest, destlen)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        &lt; 0)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        return false;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    s-&gt;dest =3D *dest;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    pc-&gt;n_sends++;</span><br><span>     return true;</span><br=
><span> }</span><br><span> </span><br><span>@@ -284,7 +292,7 @@</span><br><=
span>     }</span><br><span> }</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-/* Parse one received datagram as a probe reply =
and, if valid and matching one</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/* Parse one received datagram as a probe reply and, if valid an=
d answering one</span><br><span>  * of the probes we sent, record the reply=
 in results=2E */</span><br><span> static void</span><br><span> oob_probe_h=
andle_reply(const struct probe_ctx *pc, const uint8_t *data, int len,</span=
><br><span>@@ -308,11 +316,16 @@</span><br><span>     }</span><br><span> </=
span><br><span>     /* The reply must echo the request_id of a probe sent t=
o the address it came</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
     * from; with a random id_base that also rejects spoofed replies=2E */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const uint32_t ind=
ex =3D reply=2Erequest_id - pc-&gt;id_base;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if (index &gt;=3D (uint32_t)pc-&gt;n_sends || !ad=
dr_port_match(from, &amp;pc-&gt;sends[index]=2Edest))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * from; with a random id_base that a=
lso rejects spoofed replies=2E The RTT</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+     * runs from that transmission to now, i=2Ee=2E incl=
uding any time the reply</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     * waited in the receive queue while we were still sending=2E */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct timeval rc=
v;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_getti=
meofday(&amp;rcv, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    const int ms =3D</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        oob_probe_rtt_ms(pc-&gt;sends, pc-&gt;n_sends, reply=2Ereques=
t_id - pc-&gt;id_base, from, &amp;rcv);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (ms &lt; 0)</span><br><span>     {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        return;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        return; /* answers no probe we =
sent to that address */</span><br><span>     }</span><br><span> </span><br>=
<span>     /* Credit the reply to every still-unanswered remote probed at i=
ts source</span><br><span>@@ -322,6 +335,7 @@</span><br><span>     while (i=
 &gt;=3D 0)</span><br><span>     {</span><br><span>         results[i]=2Ere=
sponded =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      results[i]=2Ertt_ms =3D (unsigned int)ms;</span><br><span>         re=
sults[i]=2Ereply =3D reply;</span><br><span> </span><br><span>         i =
=3D oob_probe_next_target_at(from, targets, results, n, i + 1);</span><br><=
span>@@ -662,8 +676,16 @@</span><br><span>         if (results[i]=2Erespond=
ed)</span><br><span>         {</span><br><span>             responded++;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(D_LOW, &=
quot;server-probe: %s:%s answered (priority %d, weight %d)&quot;, ce-&gt;re=
mote,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
ce-&gt;remote_port, results[i]=2Ereply=2Epriority, results[i]=2Ereply=2Ewei=
ght);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /*=
 The margin this server advertised, or the client&#39;s override; only</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+             * the faste=
st server&#39;s margin applies to its priority group=2E */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            int client_margin =3D c-=
&gt;options=2Eserver_probe_latency_margin;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            int margin =3D oob_effective_margin(&amp=
;results[i], client_margin);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            const char *margin_src =3D client_margin &gt;=3D 0 ? &=
quot;client&quot; : &quot;server-advertised&quot;;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            msg(D_LOW,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                &quot;server-probe: %s:%s=
 answered (priority %d, weight %d, rtt %u ms;&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                &quot; latency margin %d =
ms [%s])&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            ce-&gt;remote, ce-&gt;remote_port, results[i]=2Ereply=2Epriorit=
y, results[i]=2Ereply=2Eweight,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                results[i]=2Ertt_ms, margin, margin_src);</span=
><br><span>         }</span><br><span>         else</span><br><span>       =
  {</span><br><span>diff --git a/tests/unit_tests/openvpn/test_oob=2Ec b/te=
sts/unit_tests/openvpn/test_oob=2Ec</span><br><span>index dc4070d=2E=2E221d=
1f0 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_oob=2Ec</spa=
n><br><span>+++ b/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>@@ =
-586,6 +586,38 @@</span><br><span>     assert_int_equal(oob_probe_next_targ=
et_at(&amp;a_other_port, targets, results, 3, 0), -1);</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* =
The RTT of a reply is measured from the transmission its request_id names (=
as</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * an index into =
the transmissions), which must have gone to the address the</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * reply came from=2E */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+test_probe_rtt_from_answered_send(void=
 **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct openvpn_sockaddr =
a =3D v4_addr(0x7f000001, 1194);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct openvpn_sockaddr b =3D v4_addr(0x7f000002, 1194);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* A at t=3D0 ms,=
 B at t=3D20 ms, then A again at t=3D500 ms (a resend) */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    const struct oob_probe_send sends=
[3] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        { =
=2Edest =3D a, =2Esent_at =3D { =2Etv_sec =3D 1000, =2Etv_usec =3D 0 } },</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        { =2Edest =3D=
 b, =2Esent_at =3D { =2Etv_sec =3D 1000, =2Etv_usec =3D 20000 } },</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        { =2Edest =3D a, =2E=
sent_at =3D { =2Etv_sec =3D 1000, =2Etv_usec =3D 500000 } },</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct timeval rcv =3D { =2Etv_sec =3D 1000=
, =2Etv_usec =3D 520000 };</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_i=
nt_equal(oob_probe_rtt_ms(sends, 3, 2, &amp;a, &amp;rcv), 20);  /* the rese=
nd */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int=
_equal(oob_probe_rtt_ms(sends, 3, 0, &amp;a, &amp;rcv), 520); /* the first =
send */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_i=
nt_equal(oob_probe_rtt_ms(sends, 3, 1, &amp;b, &amp;rcv), 500);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* a transmission to another address, and ids =
we never sent (below the</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     * base, an id wraps to a huge index) */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_int_equal(oob_probe_rtt_ms(sends, =
3, 1, &amp;a, &amp;rcv), -1);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_int_equal(oob_probe_rtt_ms(sends, 3, 3, &amp;a, &amp;r=
cv), -1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_int_equal(oob_probe_rtt_ms(sends, 3, UINT32_MAX, &amp;a, &amp;rcv), -1);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(=
oob_probe_rtt_ms(sends, 2, 2, &amp;a, &amp;rcv), -1);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* a clock that went backwards reads as 0, not as a huge=
 value */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rcv=2E=
tv_usec =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_int_equal(oob_probe_rtt_ms(sends, 3, 2, &amp;a, &amp;rcv), 0);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span> /* A payload of just a pro=
be reply is found by the client scan, with all</span><br><span>  * fields s=
urviving=2E */</span><br><span> static void</span><br><span>@@ -974,6 +1006=
,7 @@</span><br><span>         cmocka_unit_test(test_probe_request_check_no=
_request),</span><br><span>         cmocka_unit_test(test_probe_reply_credi=
ts_every_entry_at_address),</span><br><span>         cmocka_unit_test(test_=
probe_reply_matches_only_its_address),</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        cmocka_unit_test(test_probe_rtt_from_answered_se=
nd),</span><br><span>         cmocka_unit_test(test_probe_reply_find),</spa=
n><br><span>         cmocka_unit_test(test_probe_reply_find_skips_unknown),=
</span><br><span>         cmocka_unit_test(test_probe_reply_find_rejects_un=
known_mandatory),</span><br></pre><p>To view, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1748?usp=3Demail">change 1748</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1748?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:non=
e"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: I375a41749060b7d0=
06647bc27002c55436c8a8bb </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 1748 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 30 </div>=

<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ral=
f@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body=
></html>
--Tf3lhfIAS7I=--


--===============3109375674196256496==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3109375674196256496==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3109375674196256496==--

