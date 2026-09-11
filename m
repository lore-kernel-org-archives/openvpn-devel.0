Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E5FC88E58
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ATH9h3BCxlv35c6zPOJJmPl0ZI+hUutBTgZ0/PbgQ2E=; b=Ev2Dm49JVKnDRKZ6GBTZtwZav9
	X/La6bHvCLJBPzkYcNl1kVpqvozv9qIxyWJlZjf/aqNFLNuo+LXMOvHur7Qy6OfSsR1ZNhbc+eCMq
	TpngFzi1ngkUmsooTBn4abxUMHLL5i4Z3FC7WZvFYWq0xSlWp6WsQSM7ZC7ASD2s5JZo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4xIL-0006xQ-5i;
	Fri, 11 Sep 2026 09:11:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4xIF-0006wL-GQ
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 09:11:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=27M2aHfosIyUxu/nxQa105yJEoRIOERZ+DelC/ZOUFs=; b=h4WqI8LBvg8FNtYzeNE3vFKwyk
 DD/jZNUes0mWKML60ijyekZB/0NXeIoOPxXNlrvzDywcO+eOfbYJQYi/0bvyHm0UB20vEZSQQHS6V
 YJUPKO4Scw6Z6wm8aosGC52rB1tEIRlRXRy3vFjImXdU3kbc+l5gpxg2wO00p5BQ2em4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=27M2aHfosIyUxu/nxQa105yJEoRIOERZ+DelC/ZOUFs=; b=B
 CvFY7LU0vJLbcEnC4/B4tlwQbcx1xvjQhCrKvnUk6RvljfgXNaENGG9w/ZBqhdaB0eoaevKPO55na
 n5Yw/vglEsSAPp6jrvxhTBPvz0DFdH383D7yLNeY318wVLwg7stA84vd0EKloh/NX+Owba75kOnC7
 70ymmxFdR6HErCLk=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4xI4-0006cO-HI for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 09:11:36 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-4843f205a5bso389860f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 02:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789117878; x=1789722678; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=27M2aHfosIyUxu/nxQa105yJEoRIOERZ+DelC/ZOUFs=;
 b=NYi5jfRVKx6+hAGZgTLFB/JevFOAzdvs8qUtG4gHYOL6xTJVkrt5oFlE8t/gZOjK7r
 +RGM1w/VlWcS5Fb7AbQxxTI9fhac9ZQsNzkhakfrzDGbX9+Hsnzoxe/wqp9N06XPh2QW
 i+5u34LfW7ohSGcovnuu0OvFcsf0JbLM9dZeMqmibwMrfCxWM9AiwaOqBFJN06fTYszD
 z9PlaFcBOWzywRjU2XR0/VbvJApt9zT0xFrygkCVjl1fcPZJuKbATR6OOC0QjO7xo8dr
 qNMeNo05UEnTqmRY/AjOlmBrUE/30wNwo9nbx0zZbnZcKD6H2MyBDchBUcWpR64QBOjX
 s7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117878; x=1789722678;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=27M2aHfosIyUxu/nxQa105yJEoRIOERZ+DelC/ZOUFs=;
 b=c0frvTmRbiQPsQlSCX9hzIyV5rRJImYJGJGHLTv6Kslz3/aPpTe2ZUh9GMlj5FeOJz
 aEN1Tv7XtslwudVEnGE/PFsDleuE2o+XYlPYZKubChOxGDd5aaNRB1oV0oRfx7Ho/YwU
 QjKikfAMlgg7Zqn7n0BRG6G01nBqN9EZJxSho3WTzi4E3bEf0G7ns6Kue27pRxQej0tL
 8LzDgsLayyCMyiP6cw9mOw54Lg6CJ4T5pBp3Xf2BJ8m/Ej5ivaSyzoM04OVUzsLNL14Z
 eu1OcvWDavEl9BWgHvxB5kVWhYnT1qNtWWGaHV7O57d/nQ7FMhpHJk8MWtEyG7LM7Lau
 EdXA==
X-Gm-Message-State: AFuF++k9dcDlKIGGxDaHc60jqDWcAwfeMlROnrTJ5yP/A2JebGaPGmeR
 sV3+g8l2YwN7gULa05TWvrPm65Az4F/0a14LYACjfOApDG1buUWawQv3KzplMM4lSNt51jzHif2
 DdwMfYvzbIAI9iNq6zSkcHoMbT2QhCyWcYbpjBq63N/UMPAC7W6vjSgWrn8ILG7yQ3Lte
X-Gm-Gg: AYBFou0ZwbcKjo+FmXQVSIh4x7elyHit/VJmkYj9MVtwfqw226ihgQo6hgaBjWLyHzC
 KUMUNzUvJV/EC2ETp6GWxR47ZvijtjqCX9MT9t4fo25VEqe0BkE++OOo0czNsEBD6csDU063Zww
 B5QT7RMqL6xx1e79/7Zht+1ILtorwwwYl0E9t4Hsgos4cmRMyCju0iiq1qklGt18uqQwnPyyla1
 Ui93E0NifdBqlapxTsBrTz3/S5i+hLu6/xKXMENESbO3ONEmvsl0AL+iqnFhsOaikyD7En+Y/zc
 XqDa9IlxJctPLfPX4z9MVz12AM8+tlY382cHMnWhWnU8sa1EaoNmOMkrBdbMwnzOifbUB/gkicj
 yhKZdH3CNdcxKrh7YXdYrpMckrx6esdkhvo+w7i80kYh/pBYyBo9O72B3UkYRH7bBkt71jrnvTD
 3jxbWJJWfbHCJ1wM0gP8g4ENsRZWiMPXYU6pPtBhO9+5b7UBpG5xmY1HYNd8QwJgbmXFvUbdaRI
 buaAcZd1JktIs3afBILhgFkL1t36yWwz7/p0HXerJgFk2s1fZdSL2yJiVsI+iAGWe1bMUMCRehq
 Q3fL8yxfbTSne+lqeRTFqT+JEL//kUbsMc0kJSNuKTL0jmTL9Kyo8eD/XkqkrQ==
X-Received: by 2002:adf:e18d:0:b0:486:e558:604 with SMTP id
 ffacd0b85a97d-486eb357f79mr3532784f8f.57.1789117877478; 
 Fri, 11 Sep 2026 02:11:17 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb34f1f7sm4481248f8f.24.2026.09.11.02.11.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:11:17 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 09:11:03 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 19
X-Gerrit-Change-Id: I00208610e0ce4f3ed9a87233e68ece1b3b8a768a
X-Gerrit-Change-Number: 1751
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1751?usp=email>
X-Gerrit-Commit: 8a22eb71f87a513f95ffc467599d634ab3b55562
In-Reply-To: <gerrit.1782719911000.I00208610e0ce4f3ed9a87233e68ece1b3b8a768a@gerrit.openvpn.net>
References: <gerrit.1782719911000.I00208610e0ce4f3ed9a87233e68ece1b3b8a768a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkwMDIwODYxMGUwY2U0ZjNlZDlhODcyMzNlNjhlY2UxYjNiOGE3NjhhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <87a2de68ab7d2fe29b6b76a53790dd656421d4a4-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4xI4-0006cO-HI
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Probe every
 resolved address of a remote
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
 openvpn-devel@lists.sourceforge.net
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6987455417942845950=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6987455417942845950==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4ualN3Ntagc="; charset=UTF-8

--4ualN3Ntagc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1751?usp=3Demail

to look at the new patch set (#19)=2E
=


Change subject: oob: Probe every resolved address of a remote
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Probe every resol=
ved address of a remote

A remote can resolve to several A/AAAA records; --=
server-probe
previously sent a SERVER_PROBE only to the first one, so a rem=
ote whose
first address was unreachable looked unresponsive even if another=

address answered, and the connection could later try an address that was
n=
ever probed=2E

Probe every resolved address of each remote in parallel (pe=
r-remote
storage is sized to the resolved address count, no fixed cap), acc=
ept a
reply from any of them (first reply for a remote wins), and resend to=

all of a remote's addresses while it is unanswered=2E The per-address send=

moves into oob_probe_send_target(), which keeps the
one-probe-per-address =
rule across the addresses of all entries=2E

Change-Id: I00208610e0ce4f3ed9=
a87233e68ece1b3b8a768a
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
=
M doc/man-sections/client-options=2Erst
M src/openvpn/oob=2Ec
M src/openvpn=
/oob=2Eh
M src/openvpn/oob_client=2Ec
M tests/unit_tests/openvpn/test_oob=
=2Ec
5 files changed, 123 insertions(+), 54 deletions(-)


  git pull ssh:/=
/gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/51/1751/19

diff --git a=
/doc/man-sections/client-options=2Erst b/doc/man-sections/client-options=2E=
rst
index f582dc9=2E=2Ecf9883f 100644
--- a/doc/man-sections/client-options=
=2Erst
+++ b/doc/man-sections/client-options=2Erst
@@ -604,7 +604,7 @@
    =
  server-probe
      server-probe max-latency-diff
 
-  A small probe messa=
ge is sent to the first resolved address of every UDP
+  A small probe mess=
age is sent to every resolved address of every UDP
   remote, and each answ=
ering server replies with its advertised priority
   and weight=2E Remotes =
are then reordered following DNS SRV (RFC 2782)
   semantics: servers that =
answered are tried before those that did not,
diff --git a/src/openvpn/oob=
=2Ec b/src/openvpn/oob=2Ec
index 344f370=2E=2E2835c73 100644
--- a/src/open=
vpn/oob=2Ec
+++ b/src/openvpn/oob=2Ec
@@ -154,9 +154,16 @@
 {
     for (int=
 i =3D start; i < n; i++)
     {
-        if (targets[i]=2Esent && !results=
[i]=2Eresponded && addr_port_match(from, &targets[i]=2Edest))
+        if (=
!targets[i]=2Esent || results[i]=2Eresponded)
         {
-            retur=
n i;
+            continue;
+        }
+        for (int k =3D 0; k < targe=
ts[i]=2En_dests; k++)
+        {
+            if (addr_port_match(from, &ta=
rgets[i]=2Edests[k]))
+            {
+                return i;
+          =
  }
         }
     }
     return -1;
diff --git a/src/openvpn/oob=2Eh b/sr=
c/openvpn/oob=2Eh
index af0670a=2E=2E27ae02a 100644
--- a/src/openvpn/oob=
=2Eh
+++ b/src/openvpn/oob=2Eh
@@ -190,11 +190,12 @@
     struct oob_probe_=
reply reply; /* the values the server advertised */
 };
 
-/* Where the cli=
ent probed one connection entry=2E */
+/* Where the client probed one conne=
ction entry: its resolved addresses=2E */
 struct oob_probe_target
 {
-    =
struct openvpn_sockaddr dest;
-    socklen_t destlen;
+    struct openvpn_s=
ockaddr *dests;
+    socklen_t *destlens;
+    int n_dests;
     bool sent;=

     struct timeval sent_at; /* when the probe was sent, for RTT measureme=
nt */
 };
diff --git a/src/openvpn/oob_client=2Ec b/src/openvpn/oob_client=
=2Ec
index 2916032=2E=2E9690d0e 100644
--- a/src/openvpn/oob_client=2Ec
+++=
 b/src/openvpn/oob_client=2Ec
@@ -265,6 +265,51 @@
     }
 }
 
+/* Does any=
 address of t have a probe socket of its family? */
+static bool
+oob_probe=
_target_reachable(const struct probe_ctx *pc, const struct oob_probe_target=
 *t)
+{
+    for (int k =3D 0; k < t->n_dests; k++)
+    {
+        if (pc-=
>sd[probe_af_index(t->dests[k]=2Eaddr=2Esa=2Esa_family)] !=3D SOCKET_UNDEFI=
NED)
+        {
+            return true;
+        }
+    }
+    return fal=
se;
+}
+
+/* Send the probe to every resolved address of t, each on the soc=
ket matching
+ * its address family=2E An address an earlier entry already =
probed in this round
+ * is not probed again; that probe's reply covers thi=
s entry too=2E Returns true
+ * if at least one address was sent to or is a=
lready covered=2E */
+static bool
+oob_probe_send_target(struct probe_ctx *=
pc, const struct buffer *probe, const struct oob_probe_target *t)
+{
+    b=
ool any_sent =3D false;
+    for (int k =3D 0; k < t->n_dests; k++)
+    {
=
+        socket_descriptor_t sd =3D pc->sd[probe_af_index(t->dests[k]=2Eadd=
r=2Esa=2Esa_family)];
+        if (sd =3D=3D SOCKET_UNDEFINED)
+        {
+=
            continue;
+        }
+        if (oob_addr_list_contains(pc->pr=
obed, pc->n_probed, &t->dests[k]))
+        {
+            any_sent =3D tru=
e;
+            continue;
+        }
+        if (sendto(sd, (const char *)=
BPTR(probe), (int)BLEN(probe), 0,
+                   (const struct sockadd=
r *)&t->dests[k], t->destlens[k])
+            >=3D 0)
+        {
+        =
    pc->probed[pc->n_probed++] =3D t->dests[k];
+            any_sent =3D t=
rue;
+        }
+    }
+    return any_sent;
+}
+
 /* Parse one received da=
tagram as a PROBE_REPLY and, if valid and matching one
  * of the probes we=
 sent, record the reply in results=2E */
 static void
@@ -307,9 +352,10 @@
=
         return;
     }
 
-    /* Credit the reply to every still-unanswere=
d remote probed at its source
-     * address: several entries can resolve =
to the same address, and each takes
-     * the first reply for it=2E */
+ =
   /* Credit the reply to every still-unanswered remote that was probed at =
its
+     * source address: several entries can resolve to the same address=
, and each
+     * takes the first reply for it=2E (A remote with several a=
ddresses may answer
+     * from more than one; the first one wins=2E) */
 =
    struct timeval rcv;
     openvpn_gettimeofday(&rcv, NULL);
     int i =
=3D oob_probe_next_target_at(from, targets, results, n, 0);
@@ -414,18 +460=
,9 @@
     pc->n_probed =3D 0; /* a new round: probe each unanswered addres=
s once again */
     for (int i =3D 0; i < n; i++)
     {
-        if (!tar=
gets[i]=2Esent || results[i]=2Eresponded
-            || oob_addr_list_cont=
ains(pc->probed, pc->n_probed, &targets[i]=2Edest))
+        if (targets[i]=
=2Esent && !results[i]=2Eresponded)
         {
-            continue;
-    =
    }
-        socket_descriptor_t sd =3D pc->sd[probe_af_index(targets[i]=
=2Edest=2Eaddr=2Esa=2Esa_family)];
-        if (sd !=3D SOCKET_UNDEFINED
- =
           && sendto(sd, (const char *)BPTR(probe), (int)BLEN(probe), 0,
- =
                     (const struct sockaddr *)&targets[i]=2Edest, targets[i=
]=2Edestlen)
-                   >=3D 0)
-        {
-            pc->probed=
[pc->n_probed++] =3D targets[i]=2Edest;
+            oob_probe_send_target(=
pc, probe, &targets[i]);
         }
     }
 }
@@ -612,11 +649,23 @@
       =
      continue;
         }
 
-        /* Store the first resolved address n=
atively (no IPv4-mapping); it is
-         * later probed on its family's s=
ocket=2E */
-        memcpy(&targets[i]=2Edest, ai->ai_addr, ai->ai_addrlen=
);
-        targets[i]=2Edestlen =3D (socklen_t)ai->ai_addrlen;
-        ne=
ed_af[probe_af_index(ai->ai_family)] =3D true;
+        /* Store every reso=
lved address natively (no IPv4-mapping); each is later
+         * probed o=
n its family's socket=2E */
+        struct oob_probe_target *t =3D &target=
s[i];
+        int n_addr =3D 0;
+        for (const struct addrinfo *a =3D=
 ai; a; a =3D a->ai_next)
+        {
+            n_addr++;
+        }
+   =
     t->dests =3D gc_malloc(sizeof(*t->dests) * n_addr, true, &gc);
+      =
  t->destlens =3D gc_malloc(sizeof(*t->destlens) * n_addr, true, &gc);
+   =
     for (const struct addrinfo *a =3D ai; a; a =3D a->ai_next)
+        {
=
+            memcpy(&t->dests[t->n_dests], a->ai_addr, a->ai_addrlen);
+   =
         t->destlens[t->n_dests] =3D (socklen_t)a->ai_addrlen;
+           =
 t->n_dests++;
+            need_af[probe_af_index(a->ai_family)] =3D true;=

+        }
         freeaddrinfo(ai);
     }
 
@@ -633,38 +682,32 @@
     =
    return;
     }
 
-    /* Send a probe to each resolved remote, on the s=
ocket of its address family=2E
-     * An address several entries resolve t=
o is probed once; its reply is
-     * credited to each of them=2E */
-    =
pc=2Eprobed =3D gc_malloc(sizeof(*pc=2Eprobed) * l->len, false, &gc);
+    =
/* Send a probe to each resolved remote, on the socket of each address=2E *=
/
+    int n_addrs =3D 0;
+    for (int i =3D 0; i < l->len; i++)
+    {
+ =
       n_addrs +=3D targets[i]=2En_dests;
+    }
+    pc=2Eprobed =3D gc_ma=
lloc(sizeof(*pc=2Eprobed) * n_addrs, false, &gc);
     pc=2En_probed =3D 0;=

 
     int sent_count =3D 0;
     for (int i =3D 0; i < l->len; i++)
     =
{
         const struct connection_entry *ce =3D l->array[i];
-        if (=
!targets[i]=2Edestlen)
+        struct oob_probe_target *t =3D &targets[i];=

+        if (t->n_dests =3D=3D 0 || !oob_probe_target_reachable(&pc, t))
 =
        {
+            continue; /* nothing resolved, or its family is not =
probed */
+        }
+
+        if (!oob_probe_send_target(&pc, &probe, t))=

+        {
+            msg(D_LOW, "server-probe: %s:%s: probe send failed=
", ce->remote, ce->remote_port);
             continue;
         }
-       =
 socket_descriptor_t sd =3D pc=2Esd[probe_af_index(targets[i]=2Edest=2Eaddr=
=2Esa=2Esa_family)];
-        if (sd =3D=3D SOCKET_UNDEFINED)
-        {
- =
           continue; /* family not probed, see oob_probe_sockets_open() */
=
-        }
-        if (!oob_addr_list_contains(pc=2Eprobed, pc=2En_probed,=
 &targets[i]=2Edest))
-        {
-            if (sendto(sd, (const char *)=
BPTR(&probe), (int)BLEN(&probe), 0,
-                       (struct sockadd=
r *)&targets[i]=2Edest, targets[i]=2Edestlen)
-                < 0)
-      =
      {
-                msg(D_LOW, "server-probe: %s:%s: probe send failed=
", ce->remote, ce->remote_port);
-                continue;
-            }
=
-            pc=2Eprobed[pc=2En_probed++] =3D targets[i]=2Edest;
-        }=

-        openvpn_gettimeofday(&targets[i]=2Esent_at, NULL);
-        targe=
ts[i]=2Esent =3D true;
+        openvpn_gettimeofday(&t->sent_at, NULL);
+ =
       t->sent =3D true;
         sent_count++;
     }
 
diff --git a/tests=
/unit_tests/openvpn/test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec
in=
dex df973ec=2E=2E0752717 100644
--- a/tests/unit_tests/openvpn/test_oob=2Ec=

+++ b/tests/unit_tests/openvpn/test_oob=2Ec
@@ -518,10 +518,12 @@
     ret=
urn sa;
 }
 
+/* One probed address per entry=2E */
 static struct oob_prob=
e_target
-probe_target(struct openvpn_sockaddr dest, bool sent)
+probe_targ=
et(struct openvpn_sockaddr *dest, bool sent)
 {
-    return (struct oob_pro=
be_target){ =2Edest =3D dest, =2Edestlen =3D sizeof(dest=2Eaddr=2Ein4), =2E=
sent =3D sent };
+    static socklen_t len =3D sizeof(struct sockaddr_in);
=
+    return (struct oob_probe_target){ =2Edests =3D dest, =2Edestlens =3D &=
len, =2En_dests =3D 1, =2Esent =3D sent };
 }
 
 /* Two entries resolving t=
o the same address are both credited by one reply,
@@ -530,7 +532,7 @@
 tes=
t_probe_reply_credits_every_entry_at_address(void **state)
 {
     struct o=
penvpn_sockaddr a =3D v4_addr(0x7f000001, 1194);
-    struct oob_probe_targ=
et targets[2] =3D { probe_target(a, true), probe_target(a, true) };
+    st=
ruct oob_probe_target targets[2] =3D { probe_target(&a, true), probe_target=
(&a, true) };
     struct oob_probe_result results[2] =3D { 0 };
 
     int=
 i =3D oob_probe_next_target_at(&a, targets, results, 2, 0);
@@ -554,9 +556=
,9 @@
     struct openvpn_sockaddr b =3D v4_addr(0x7f000002, 1194);
     st=
ruct openvpn_sockaddr a_other_port =3D v4_addr(0x7f000001, 1195);
     stru=
ct oob_probe_target targets[3] =3D {
-        probe_target(a, true),
-     =
   probe_target(b, true),
-        probe_target(a, false), /* resolved but =
never sent */
+        probe_target(&a, true),
+        probe_target(&b, tr=
ue),
+        probe_target(&a, false), /* resolved but never sent */
     }=
;
     struct oob_probe_result results[3] =3D { 0 };
 
@@ -567,6 +569,21 @@=

     assert_int_equal(oob_probe_next_target_at(&a_other_port, targets, res=
ults, 3, 0), -1);
 }
 
+/* A remote with several addresses is credited whic=
hever of them answers=2E */
+static void
+test_probe_reply_matches_any_addr=
ess_of_entry(void **state)
+{
+    struct openvpn_sockaddr addrs[2] =3D { v=
4_addr(0x7f000001, 1194), v4_addr(0x7f000002, 1194) };
+    socklen_t lens[=
2] =3D { sizeof(struct sockaddr_in), sizeof(struct sockaddr_in) };
+    str=
uct oob_probe_target targets[1] =3D {
+        { =2Edests =3D addrs, =2Edes=
tlens =3D lens, =2En_dests =3D 2, =2Esent =3D true },
+    };
+    struct o=
ob_probe_result results[1] =3D { 0 };
+
+    assert_int_equal(oob_probe_nex=
t_target_at(&addrs[1], targets, results, 1, 0), 0);
+    assert_int_equal(o=
ob_probe_next_target_at(&addrs[0], targets, results, 1, 0), 0);
+}
+
 /* Th=
e per-round list of probed addresses compares address and port=2E */
 stati=
c void
 test_addr_list_contains(void **state)
@@ -927,6 +944,7 @@
         =
cmocka_unit_test(test_server_probe_accept_no_parameter),
         cmocka_un=
it_test(test_probe_reply_credits_every_entry_at_address),
         cmocka_u=
nit_test(test_probe_reply_matches_only_its_address),
+        cmocka_unit_t=
est(test_probe_reply_matches_any_address_of_entry),
         cmocka_unit_te=
st(test_addr_list_contains),
         cmocka_unit_test(test_client_reply_re=
ad_finds_reply),
         cmocka_unit_test(test_client_reply_read_skips_unk=
nown),

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1751?u=
sp=3Demail
To unsubscribe, or for help writing mail filters, visit http://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset=

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I00208610e=
0ce4f3ed9a87233e68ece1b3b8a768a
Gerrit-Change-Number: 1751
Gerrit-PatchSet:=
 19
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>

--4ualN3Ntagc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #19</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1751?usp=3Demail">View Change</a></p><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">oob: Pro=
be every resolved address of a remote<br><br>A remote can resolve to severa=
l A/AAAA records; --server-probe<br>previously sent a SERVER_PROBE only to =
the first one, so a remote whose<br>first address was unreachable looked un=
responsive even if another<br>address answered, and the connection could la=
ter try an address that was<br>never probed=2E<br><br>Probe every resolved =
address of each remote in parallel (per-remote<br>storage is sized to the r=
esolved address count, no fixed cap), accept a<br>reply from any of them (f=
irst reply for a remote wins), and resend to<br>all of a remote&#39;s addre=
sses while it is unanswered=2E The per-address send<br>moves into oob_probe=
_send_target(), which keeps the<br>one-probe-per-address rule across the ad=
dresses of all entries=2E<br><br>Change-Id: I00208610e0ce4f3ed9a87233e68ece=
1b3b8a768a<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<=
br>M doc/man-sections/client-options=2Erst<br>M src/openvpn/oob=2Ec<br>M sr=
c/openvpn/oob=2Eh<br>M src/openvpn/oob_client=2Ec<br>M tests/unit_tests/ope=
nvpn/test_oob=2Ec<br>5 files changed, 123 insertions(+), 54 deletions(-)<br=
><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/51/1751/19</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/doc/man-sections/client-opti=
ons=2Erst b/doc/man-sections/client-options=2Erst</span><br><span>index f58=
2dc9=2E=2Ecf9883f 100644</span><br><span>--- a/doc/man-sections/client-opti=
ons=2Erst</span><br><span>+++ b/doc/man-sections/client-options=2Erst</span=
><br><span>@@ -604,7 +604,7 @@</span><br><span>      server-probe</span><br=
><span>      server-probe max-latency-diff</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-  A small probe message is sent to t=
he first resolved address of every UDP</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  A small probe message is sent to every resolved addres=
s of every UDP</span><br><span>   remote, and each answering server replies=
 with its advertised priority</span><br><span>   and weight=2E Remotes are =
then reordered following DNS SRV (RFC 2782)</span><br><span>   semantics: s=
ervers that answered are tried before those that did not,</span><br><span>d=
iff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec</span><br><span>index=
 344f370=2E=2E2835c73 100644</span><br><span>--- a/src/openvpn/oob=2Ec</spa=
n><br><span>+++ b/src/openvpn/oob=2Ec</span><br><span>@@ -154,9 +154,16 @@<=
/span><br><span> {</span><br><span>     for (int i =3D start; i &lt; n; i++=
)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        if (targets[i]=2Esent &amp;&amp; !results[i]=2Eresponded &amp;&a=
mp; addr_port_match(from, &amp;targets[i]=2Edest))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        if (!targets[i]=2Esent || results[i]=
=2Eresponded)</span><br><span>         {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            return i;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            continue;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        for (int k =3D 0; k &lt; targets[i]=2En_dests; k++)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            if (addr_port_match(=
from, &amp;targets[i]=2Edests[k]))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                return i;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            }</span><br><span>         }</span><br><span>   =
  }</span><br><span>     return -1;</span><br><span>diff --git a/src/openvp=
n/oob=2Eh b/src/openvpn/oob=2Eh</span><br><span>index af0670a=2E=2E27ae02a =
100644</span><br><span>--- a/src/openvpn/oob=2Eh</span><br><span>+++ b/src/=
openvpn/oob=2Eh</span><br><span>@@ -190,11 +190,12 @@</span><br><span>     =
struct oob_probe_reply reply; /* the values the server advertised */</span>=
<br><span> };</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-/* Where the client probed one connection entry=2E */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/* Where the client probed one =
connection entry: its resolved addresses=2E */</span><br><span> struct oob_=
probe_target</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    struct openvpn_sockaddr dest;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    socklen_t destlen;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct openvpn_sockaddr *dests;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    socklen_t *destlens;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    int n_dests;</span><br><s=
pan>     bool sent;</span><br><span>     struct timeval sent_at; /* when th=
e probe was sent, for RTT measurement */</span><br><span> };</span><br><spa=
n>diff --git a/src/openvpn/oob_client=2Ec b/src/openvpn/oob_client=2Ec</spa=
n><br><span>index 2916032=2E=2E9690d0e 100644</span><br><span>--- a/src/ope=
nvpn/oob_client=2Ec</span><br><span>+++ b/src/openvpn/oob_client=2Ec</span>=
<br><span>@@ -265,6 +265,51 @@</span><br><span>     }</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* D=
oes any address of t have a probe socket of its family? */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+oob_probe_target_reachable(const struct prob=
e_ctx *pc, const struct oob_probe_target *t)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    for (int k =3D 0; k &lt; t-&gt;n_dests; k++)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if (pc-&gt;sd[probe_af_index(t-&gt;dests[k]=
=2Eaddr=2Esa=2Esa_family)] !=3D SOCKET_UNDEFINED)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            return true;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/* Send the probe to every resolved ad=
dress of t, each on the socket matching</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * its address family=2E An address an earlier entry al=
ready probed in this round</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * is not probed again; that probe&#39;s reply covers this entry too=
=2E Returns true</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
if at least one address was sent to or is already covered=2E */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+oob_probe_send_target(struct probe_ctx =
*pc, const struct buffer *probe, const struct oob_probe_target *t)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    bool any_sent =3D false;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    for (int k =3D 0; k &lt; t-&gt;n_=
dests; k++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        socket_descrip=
tor_t sd =3D pc-&gt;sd[probe_af_index(t-&gt;dests[k]=2Eaddr=2Esa=2Esa_famil=
y)];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (sd =
=3D=3D SOCKET_UNDEFINED)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       continue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (o=
ob_addr_list_contains(pc-&gt;probed, pc-&gt;n_probed, &amp;t-&gt;dests[k]))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            any_sent =3D true=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            contin=
ue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (sendto(sd, (co=
nst char *)BPTR(probe), (int)BLEN(probe), 0,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                   (const struct sockaddr *)&amp;t=
-&gt;dests[k], t-&gt;destlens[k])</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            &gt;=3D 0)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            pc-&gt;probed[pc-&gt;n_probed++] =3D t-&gt;dests[k];</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            any_sent =
=3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    return any_sent;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> /* Parse one received datagram as=
 a PROBE_REPLY and, if valid and matching one</span><br><span>  * of the pr=
obes we sent, record the reply in results=2E */</span><br><span> static voi=
d</span><br><span>@@ -307,9 +352,10 @@</span><br><span>         return;</sp=
an><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    /* Credit the reply to every still-unanswered remote pr=
obed at its source</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
  * address: several entries can resolve to the same address, and each take=
s</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * the first rep=
ly for it=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* Credit the reply to every still-unanswered remote that was probed at its=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * source addre=
ss: several entries can resolve to the same address, and each</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     * takes the first reply for =
it=2E (A remote with several addresses may answer</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     * from more than one; the first one wins=
=2E) */</span><br><span>     struct timeval rcv;</span><br><span>     openv=
pn_gettimeofday(&amp;rcv, NULL);</span><br><span>     int i =3D oob_probe_n=
ext_target_at(from, targets, results, n, 0);</span><br><span>@@ -414,18 +46=
0,9 @@</span><br><span>     pc-&gt;n_probed =3D 0; /* a new round: probe ea=
ch unanswered address once again */</span><br><span>     for (int i =3D 0; =
i &lt; n; i++)</span><br><span>     {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        if (!targets[i]=2Esent || results[i]=2Eresponded</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            || oob_addr_=
list_contains(pc-&gt;probed, pc-&gt;n_probed, &amp;targets[i]=2Edest))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (targets[i]=
=2Esent &amp;&amp; !results[i]=2Eresponded)</span><br><span>         {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            continue;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        socket_descriptor_t sd =3D pc-=
&gt;sd[probe_af_index(targets[i]=2Edest=2Eaddr=2Esa=2Esa_family)];</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        if (sd !=3D SOCKET_UND=
EFINED</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            &am=
p;&amp; sendto(sd, (const char *)BPTR(probe), (int)BLEN(probe), 0,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                      (const s=
truct sockaddr *)&amp;targets[i]=2Edest, targets[i]=2Edestlen)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                   &gt;=3D 0)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            pc-&gt;probed[pc-&gt;n_pro=
bed++] =3D targets[i]=2Edest;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            oob_probe_send_target(pc, probe, &amp;targets[i]);</s=
pan><br><span>         }</span><br><span>     }</span><br><span> }</span><b=
r><span>@@ -612,11 +649,23 @@</span><br><span>             continue;</span>=
<br><span>         }</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        /* Store the first resolved address natively (no I=
Pv4-mapping); it is</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
       * later probed on its family&#39;s socket=2E */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        memcpy(&amp;targets[i]=2Edest, ai-=
&gt;ai_addr, ai-&gt;ai_addrlen);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        targets[i]=2Edestlen =3D (socklen_t)ai-&gt;ai_addrlen;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        need_af[probe_a=
f_index(ai-&gt;ai_family)] =3D true;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        /* Store every resolved address natively (no IPv4-=
mapping); each is later</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+         * probed on its family&#39;s socket=2E */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        struct oob_probe_target *t =3D &=
amp;targets[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    int n_addr =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        for (const struct addrinfo *a =3D ai; a; a =3D a-&gt;ai_next)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            n_addr++;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        t-&gt;dests =3D gc_malloc(sizeof(=
*t-&gt;dests) * n_addr, true, &amp;gc);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        t-&gt;destlens =3D gc_malloc(sizeof(*t-&gt;dest=
lens) * n_addr, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        for (const struct addrinfo *a =3D ai; a; a =3D a-&gt;ai=
_next)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            memcpy(&amp=
;t-&gt;dests[t-&gt;n_dests], a-&gt;ai_addr, a-&gt;ai_addrlen);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            t-&gt;destlens[t-&gt=
;n_dests] =3D (socklen_t)a-&gt;ai_addrlen;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            t-&gt;n_dests++;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            need_af[probe_af_index(a-&gt;=
ai_family)] =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span>         freeaddrinfo(ai);</span><br><span>    =
 }</span><br><span> </span><br><span>@@ -633,38 +682,32 @@</span><br><span>=
         return;</span><br><span>     }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    /* Send a probe to each resolved re=
mote, on the socket of its address family=2E</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-     * An address several entries resolve to is prob=
ed once; its reply is</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
     * credited to each of them=2E */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    pc=2Eprobed =3D gc_malloc(sizeof(*pc=2Eprobed) * l-&gt;=
len, false, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* Send a probe to each resolved remote, on the socket of each addres=
s=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int n_ad=
drs =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (=
int i =3D 0; i &lt; l-&gt;len; i++)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        n_addrs +=3D targets[i]=2En_dests;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    pc=2Eprobed =3D gc_malloc(sizeof(*pc=2Eprobed) * n_addrs, fa=
lse, &amp;gc);</span><br><span>     pc=2En_probed =3D 0;</span><br><span> <=
/span><br><span>     int sent_count =3D 0;</span><br><span>     for (int i =
=3D 0; i &lt; l-&gt;len; i++)</span><br><span>     {</span><br><span>      =
   const struct connection_entry *ce =3D l-&gt;array[i];</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        if (!targets[i]=2Edestlen)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct oob_probe_=
target *t =3D &amp;targets[i];</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (t-&gt;n_dests =3D=3D 0 || !oob_probe_target_reachabl=
e(&amp;pc, t))</span><br><span>         {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            continue; /* nothing resolved, or its fam=
ily is not probed */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if (!oob_probe_send_=
target(&amp;pc, &amp;probe, t))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            msg(D_LOW, &quot;server-probe: %s:%s: probe send failed&quot;=
, ce-&gt;remote, ce-&gt;remote_port);</span><br><span>             continue=
;</span><br><span>         }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        socket_descriptor_t sd =3D pc=2Esd[probe_af_index(targets[i]=
=2Edest=2Eaddr=2Esa=2Esa_family)];</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        if (sd =3D=3D SOCKET_UNDEFINED)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            continue; /* family not probed, see oob_pro=
be_sockets_open() */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!=
oob_addr_list_contains(pc=2Eprobed, pc=2En_probed, &amp;targets[i]=2Edest))=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            if (sendto(sd, (const=
 char *)BPTR(&amp;probe), (int)BLEN(&amp;probe), 0,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                       (struct sockaddr *)&=
amp;targets[i]=2Edest, targets[i]=2Edestlen)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                &lt; 0)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                msg(D_LOW, &quot;server-probe: %s:%s: prob=
e send failed&quot;, ce-&gt;remote, ce-&gt;remote_port);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                continue;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            pc=2Eprobed[pc=2En_probed++] =
=3D targets[i]=2Edest;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ope=
nvpn_gettimeofday(&amp;targets[i]=2Esent_at, NULL);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        targets[i]=2Esent =3D true;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        openvpn_gettimeofda=
y(&amp;t-&gt;sent_at, NULL);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        t-&gt;sent =3D true;</span><br><span>         sent_count++=
;</span><br><span>     }</span><br><span> </span><br><span>diff --git a/tes=
ts/unit_tests/openvpn/test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec<=
/span><br><span>index df973ec=2E=2E0752717 100644</span><br><span>--- a/tes=
ts/unit_tests/openvpn/test_oob=2Ec</span><br><span>+++ b/tests/unit_tests/o=
penvpn/test_oob=2Ec</span><br><span>@@ -518,10 +518,12 @@</span><br><span> =
    return sa;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* One probed address per entry=2E */</sp=
an><br><span> static struct oob_probe_target</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-probe_target(struct openvpn_sockaddr dest, bool sent=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+probe_target(struc=
t openvpn_sockaddr *dest, bool sent)</span><br><span> {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    return (struct oob_probe_target){ =2E=
dest =3D dest, =2Edestlen =3D sizeof(dest=2Eaddr=2Ein4), =2Esent =3D sent }=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    static socklen=
_t len =3D sizeof(struct sockaddr_in);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    return (struct oob_probe_target){ =2Edests =3D dest,=
 =2Edestlens =3D &amp;len, =2En_dests =3D 1, =2Esent =3D sent };</span><br>=
<span> }</span><br><span> </span><br><span> /* Two entries resolving to the=
 same address are both credited by one reply,</span><br><span>@@ -530,7 +53=
2,7 @@</span><br><span> test_probe_reply_credits_every_entry_at_address(voi=
d **state)</span><br><span> {</span><br><span>     struct openvpn_sockaddr =
a =3D v4_addr(0x7f000001, 1194);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    struct oob_probe_target targets[2] =3D { probe_target(a, tru=
e), probe_target(a, true) };</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct oob_probe_target targets[2] =3D { probe_target(&amp;a, =
true), probe_target(&amp;a, true) };</span><br><span>     struct oob_probe_=
result results[2] =3D { 0 };</span><br><span> </span><br><span>     int i =
=3D oob_probe_next_target_at(&amp;a, targets, results, 2, 0);</span><br><sp=
an>@@ -554,9 +556,9 @@</span><br><span>     struct openvpn_sockaddr b =3D v=
4_addr(0x7f000002, 1194);</span><br><span>     struct openvpn_sockaddr a_ot=
her_port =3D v4_addr(0x7f000001, 1195);</span><br><span>     struct oob_pro=
be_target targets[3] =3D {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        probe_target(a, true),</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        probe_target(b, true),</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        probe_target(a, false), /* resolved but neve=
r sent */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        pr=
obe_target(&amp;a, true),</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        probe_target(&amp;b, true),</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        probe_target(&amp;a, false), /* resolved but =
never sent */</span><br><span>     };</span><br><span>     struct oob_probe=
_result results[3] =3D { 0 };</span><br><span> </span><br><span>@@ -567,6 +=
569,21 @@</span><br><span>     assert_int_equal(oob_probe_next_target_at(&a=
mp;a_other_port, targets, results, 3, 0), -1);</span><br><span> }</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A remote=
 with several addresses is credited whichever of them answers=2E */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+test_probe_reply_matches_any_addres=
s_of_entry(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct op=
envpn_sockaddr addrs[2] =3D { v4_addr(0x7f000001, 1194), v4_addr(0x7f000002=
, 1194) };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sockl=
en_t lens[2] =3D { sizeof(struct sockaddr_in), sizeof(struct sockaddr_in) }=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_pro=
be_target targets[1] =3D {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        { =2Edests =3D addrs, =2Edestlens =3D lens, =2En_dests =3D 2=
, =2Esent =3D true },</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
oob_probe_result results[1] =3D { 0 };</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_int_equal(oob_probe_next_target_at(&amp;addrs[1], targets, resul=
ts, 1, 0), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_int_equal(oob_probe_next_target_at(&amp;addrs[0], targets, results, 1=
, 0), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* The per=
-round list of probed addresses compares address and port=2E */</span><br><=
span> static void</span><br><span> test_addr_list_contains(void **state)</s=
pan><br><span>@@ -927,6 +944,7 @@</span><br><span>         cmocka_unit_test=
(test_server_probe_accept_no_parameter),</span><br><span>         cmocka_un=
it_test(test_probe_reply_credits_every_entry_at_address),</span><br><span> =
        cmocka_unit_test(test_probe_reply_matches_only_its_address),</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(t=
est_probe_reply_matches_any_address_of_entry),</span><br><span>         cmo=
cka_unit_test(test_addr_list_contains),</span><br><span>         cmocka_uni=
t_test(test_client_reply_read_finds_reply),</span><br><span>         cmocka=
_unit_test(test_client_reply_read_skips_unknown),</span><br><span></span><b=
r></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1751?usp=3Demail">change 1751</a>=2E To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1751?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: I00208610e0ce4f3ed9a87233e68ece1b3b8a768a=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1751 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 19 </div>
<div style=3D"display:n=
one"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;open=
vpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none">=
 Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</b=
ody></html>
--4ualN3Ntagc=--


--===============6987455417942845950==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6987455417942845950==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6987455417942845950==--

