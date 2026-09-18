Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B5CC982D9
	for <openvpn-devel@archiver.kernel.org>; Fri, 18 Sep 2026 08:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ejleXUCXb5v/3StlEwSUEzxwswlDCGO+7VCSFg6SZ3A=; b=aYz4UEP7jFuYF9zxZFrXuC5HCD
	E4M/2/I69lh6Rw16gj8+IoUU6mODmEwSuJE1DTaUInOm5qGzd8YHZ3MMIQTx97a8dclUCX5PL/HBx
	iAGn6z0SzQ+sKWcwDdS3rLD4gbbni+vhHSqLyTQWLYW1ihJV2YsdjbzICRLvGMc+kieI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x7U0v-0005jX-71;
	Fri, 18 Sep 2026 08:32:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x7U0t-0005jQ-Nb
 for openvpn-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 08:32:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=wllQ5YS9GL0eeIpKoXp4gAd5MXBqun86gXP7AA9Ff6I=; b=lehMckz4PgFhQBgrKZVC/boxF2
 qEhGIGNZ2+sr3XOdy6vtwee5MSK8jQUj8Ds3HgoxVA8VVAeB3L2O8cL/rRmUD9OVA64d5GljqubtH
 FaC/EiIeLz/24iZlxlSnF1WSPLCLEgjKoyNq9Kx55ABYCPilHVtzVxNNXdiul2Ym29yw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=wllQ5YS9GL0eeIpKoXp4gAd5MXBqun86gXP7AA9Ff6I=; b=H
 FeSo9KF0m3u5pMRxPkT1BbJdN5+cfIktfi3dko/gxR6y70/2ZQLeaJSkUUsW4V27dLtKa45S1wa0H
 GHoErDh4s522SQQ/ynPAbPBkMV7Sl9v/78CY/SyjTniAcfa5QIiZjlIK/3iEYngrhV9CGoQBqVLsZ
 IDbjXYBKSzgKYJvk=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x7U0q-0004Gt-2S for openvpn-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 08:32:07 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912d3931so3379555e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 18 Sep 2026 01:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789720317; x=1790325117; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wllQ5YS9GL0eeIpKoXp4gAd5MXBqun86gXP7AA9Ff6I=;
 b=TC3875wcswi9XAlj0PQKniQYfprXXqQljNNqWNy/TSy0N9L9p0bBu2vCReOj3XOv70
 qzkMDCoGnK9Vo6q6lmY9cbPlFi4W8qfRTZtxSWFQFDAmPCcXwOlEixy8hnqBN/yYfOuB
 CEIQHcINd1Z3AP+SJnEH4J5YvHtAJk3uLxqeeANL2s9bx7ka+jgqLjxyMvy8sR5jHpBG
 3H2EQlhO8kjcHoNtuCpiVIqXqKHicTUOEzAIje2fye1VEc4ZJSf3GoRC/DFxJUZLaiHr
 6llk+e0EtcrUu+vkKTB832X1bfXItr1mo5DbavKZLnvPavc9FbTqn5FMpKJwLfG+5CZF
 3LIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789720317; x=1790325117;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wllQ5YS9GL0eeIpKoXp4gAd5MXBqun86gXP7AA9Ff6I=;
 b=GkdDmsnm+LmCOw7gnB3ewEy4TeS6QiFVKrDxpl77e0e4TTKSoxy/NEwdHYfDrh8sml
 XGFSrV3kvt2mo/M9KRqauY5jN6DiWcHf5PgOX2HtPezGA15REPH34CvRkLr89R0EGlgq
 ooRGHcG+gutsDUHfZCYxB2r3+hLNlOcSmDLYDDfqhRX7UChKdW21PuunU9cTlvrlVN2N
 Qrd3VbNSP/cGm6vmghioWXTgiMDkTMKe1CzW0DllXeANIQiwYpwj7p7Jc/heKyqHEI/K
 xxtCfrJ6JsWQKKH+epb6vY0UK2ZTvbpbxBE54gZk0F7wpiuQlShZgKlnvyK9nL/eMNOB
 lz/w==
X-Gm-Message-State: AFuF++l65+jWwkJ4HbsK5vRqts0nkUCSIi7489ZnPX5tZHAp8rLu/8Xu
 VFNpK6MDxhmLh+EOW9W50cHNtJ70jsa4XFfmWfIMrQx3r46gBvkcfbw9C0gQRCUIt8nhKQqNtkL
 BaNOIGRYgdA9AncpnQwtT9fLlFG5wTMrSA8txouuuotgVie7vXOzcOu78amc5vavVxDAj
X-Gm-Gg: AYBFou3cYc0CzjOK5044mwRqm9TqHWDPL6854of/bgGAZnKnjdn/bfe3o1WHeeBfKbW
 So1yWZz0QISkgpovRqly7u56Hi+ChlFCzu72LpFQ9HvjE+G5yHZ99OIEDVPAzzuRKwk4JWrC+Ec
 tPImD1Ii8Pf0LlOsAmc/WdvrbLMtkyvpTZG243/Q+njNEExSxgLNuyzJUZcd8TtlBZC4ugu92eA
 /04D8TZ5J3wHicxzPc4cM/9nhB9tqFRgkZvWImhayPN6lIaNuF/MkQ6bu3nyqif0deISXLoKdpE
 d9xR9Ir9/n+mU5hnwwfiQrhDb4kjZVYq4p0ci9UC3U+Sb9ctVBKGnEDG+Jbf5CaW3B3xKK8UFD7
 wUPDFlHdV9fzbuJGYM7yg+Uc7gUgsXSRjOIs+rszHarbAJXa0quHfwSLZqTLskKHsRKbkTr4IhE
 QIKEZdGFLsDK2jirBG0WgnQcb3fE2a4cjS3m0Ofu1TL2K8MjXok/pbuYn+mXpI0YsP3LIOIiE6T
 H/aT4QRWgQTDzAdYFoBfoHDA5zj6R+Kw8xoQY7pYLJ4QemvQL65gnb+mSlE5CiG+1RZ2dJwNgJT
 S+AO4NznruV4Mms6XmzQi5wXo1CQlmW/DH1fxWQ9CMXIy1I5GXcPVQUqiZMtdYXf0IdA52BH
X-Received: by 2002:a05:600c:c493:b0:49e:74b6:740f with SMTP id
 5b1f17b1804b1-49fc573603amr19016315e9.17.1789720317042; 
 Fri, 18 Sep 2026 01:31:57 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc7ce0050sm39844405e9.4.2026.09.18.01.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 01:31:56 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 18 Sep 2026 08:31:39 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 29
X-Gerrit-Change-Id: I00208610e0ce4f3ed9a87233e68ece1b3b8a768a
X-Gerrit-Change-Number: 1751
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1751?usp=email>
X-Gerrit-Commit: 1b0b7e8e90804b64fa6997b2c5c1cdc7d03a5941
In-Reply-To: <gerrit.1782719911000.I00208610e0ce4f3ed9a87233e68ece1b3b8a768a@gerrit.openvpn.net>
References: <gerrit.1782719911000.I00208610e0ce4f3ed9a87233e68ece1b3b8a768a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkwMDIwODYxMGUwY2U0ZjNlZDlhODcyMzNlNjhlY2UxYjNiOGE3NjhhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <19795207cd6cdc9e382413cb5818fe20d34b87e9-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x7U0q-0004Gt-2S
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Probe every
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
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3930236607239781858=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3930236607239781858==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="S19tpWx8rJE="; charset=UTF-8

--S19tpWx8rJE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici, stipa=2E

Hello=
 plaisthos, ralf_lici, 

I'd like you to reexamine a change=2E Please visit=


    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1751?usp=3Demail

to look a=
t the new patch set (#29)=2E

The following approvals got outdated and were=
 removed:
Code-Review+1 by ralf_lici


Change subject: oob: Probe every res=
olved address of a remote
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

oob: Probe every resolved address of a remote

A remote can r=
esolve to several A/AAAA records; --server-probe
previously sent a SERVER_P=
ROBE only to the first one, so a remote whose
first address was unreachable=
 looked unresponsive even if another
address answered, and the connection c=
ould later try an address that was
never probed=2E

Probe every resolved ad=
dress of each remote in parallel (per-remote
storage is sized to the resolv=
ed address count, no fixed cap), accept a
reply from any of them (first rep=
ly for a remote wins), and resend to
all of a remote's addresses while it i=
s unanswered=2E The per-address send
moves into oob_probe_send_target(), wh=
ich keeps the
one-probe-per-address rule across the addresses of all entrie=
s=2E

The addresses of one remote are taken to be the same service, adverti=
sing
the same priority, weight and margin; the first of them to answer spea=
ks
for the remote, and its round-trip time is measured from the probe sent =
to
that address=2E

Change-Id: I00208610e0ce4f3ed9a87233e68ece1b3b8a768a
Si=
gned-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M doc/man-sections/client=
-options=2Erst
M src/openvpn/oob=2Ec
M src/openvpn/oob=2Eh
M src/openvpn/oo=
b_client=2Ec
M tests/unit_tests/openvpn/test_oob=2Ec
5 files changed, 249 i=
nsertions(+), 89 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn refs/changes/51/1751/29

diff --git a/doc/man-sections/client-op=
tions=2Erst b/doc/man-sections/client-options=2Erst
index eaa7d99=2E=2Ec1af=
ac7 100644
--- a/doc/man-sections/client-options=2Erst
+++ b/doc/man-sectio=
ns/client-options=2Erst
@@ -604,7 +604,7 @@
      server-probe
      server=
-probe max-latency-diff
 
-  A small probe message is sent to the first res=
olved address of every UDP
+  A small probe message is sent to every resolv=
ed address of every UDP
   remote, and each answering server replies with i=
ts advertised priority
   and weight=2E Remotes are then reordered followin=
g DNS SRV (RFC 2782)
   semantics: servers that answered are tried before t=
hose that did not,
@@ -620,6 +620,10 @@
   priority group a candidate, sinc=
e replies only arrive within the
   one-second probe window; the group is t=
hen ordered by weight alone=2E
 
+  The addresses of one remote are expecte=
d to be the same service and to
+  advertise the same values; the first of =
them to answer speaks for the
+  remote=2E
+
   The probe carries the same =
control-channel wrapping as a normal
   connection (``--tls-auth`` or ``--t=
ls-crypt``, when configured)=2E With
   ``--tls-crypt-v2`` the remotes are =
left in their configured order,
diff --git a/src/openvpn/oob=2Ec b/src/open=
vpn/oob=2Ec
index 2cee2a0=2E=2E974b1b3 100644
--- a/src/openvpn/oob=2Ec
+++=
 b/src/openvpn/oob=2Ec
@@ -153,9 +153,16 @@
 {
     for (int i =3D start; i=
 < n; i++)
     {
-        if (targets[i]=2Esent && !results[i]=2Eresponded=
 && addr_port_match(from, &targets[i]=2Edest))
+        if (!targets[i]=2Es=
ent || results[i]=2Eresponded)
         {
-            return i;
+         =
   continue;
+        }
+        for (int k =3D 0; k < targets[i]=2En_dests=
; k++)
+        {
+            if (addr_port_match(from, &targets[i]=2Edest=
s[k]))
+            {
+                return i;
+            }
         }
=
     }
     return -1;
@@ -174,6 +181,20 @@
     return -1;
 }
 
+int
+oob_=
probe_rtt_ms(const struct oob_probe_target *t, const struct openvpn_sockadd=
r *from,
+                 const struct timeval *rcv)
+{
+    const int k =
=3D oob_addr_list_find(t->dests, t->n_dests, from);
+    if (k < 0 || oob_s=
ent_at_unset(&t->sent_at[k]))
+    {
+        return -1; /* not this remote=
's address, or never probed */
+    }
+    const long ms =3D (long)(rcv->tv=
_sec - t->sent_at[k]=2Etv_sec) * 1000
+                    + (rcv->tv_usec =
- t->sent_at[k]=2Etv_usec) / 1000;
+    return (ms > 0) ? (int)ms : 0;
+}
+=

 /* Base ordering: responders before non-responders, then by priority (low=
er
  * first), then by RTT (lower first), then by original index for determ=
inism=2E
  * This groups responders into priority runs pre-sorted by RTT, w=
hich the
diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh
index 42002=
dc=2E=2Eae0663c 100644
--- a/src/openvpn/oob=2Eh
+++ b/src/openvpn/oob=2Eh
=
@@ -195,15 +195,37 @@
     struct oob_probe_reply reply; /* the values the =
server advertised */
 };
 
-/* Where the client probed one connection entry=
=2E */
+/* Where the client probed one connection entry: its resolved addre=
sses=2E */
 struct oob_probe_target
 {
-    struct openvpn_sockaddr dest;
-=
    socklen_t destlen;
-    bool sent;
-    struct timeval sent_at; /* when=
 the first probe went out, for the RTT */
+    struct openvpn_sockaddr *des=
ts;
+    socklen_t *destlens;
+    struct timeval *sent_at; /* per address:=
 when its first probe went out (zero: never) */
+    int n_dests;
+    bool=
 sent;               /* at least one address was probed */
 };
 
+/* An add=
ress's first-send time; zero until a probe went out to it=2E */
+static inl=
ine bool
+oob_sent_at_unset(const struct timeval *tv)
+{
+    return tv->tv=
_sec =3D=3D 0 && tv->tv_usec =3D=3D 0;
+}
+
+/**
+ * Round-trip time of a r=
eply, measured from the first probe sent to the
+ * address it came from --=
 not from the first probe sent for the remote, as
+ * the addresses of one =
remote go out one after another=2E
+ *
+ * @param t     the probed entry
+ =
* @param from  source address of the reply
+ * @param rcv   when the reply =
arrived
+ * @return milliseconds (0 if the clock went backwards), or -1 if =
from is not
+ *         an address of t or no probe was sent to it
+ */
+in=
t oob_probe_rtt_ms(const struct oob_probe_target *t, const struct openvpn_s=
ockaddr *from,
+                     const struct timeval *rcv);
+
 /**
  *=
 Find the next entry, from index \p start on, that was probed at \p from an=
d
  * has not answered yet=2E Several entries can resolve to the same addre=
ss, so a
diff --git a/src/openvpn/oob_client=2Ec b/src/openvpn/oob_client=
=2Ec
index cac244a=2E=2E75116ce 100644
--- a/src/openvpn/oob_client=2Ec
+++=
 b/src/openvpn/oob_client=2Ec
@@ -322,6 +322,81 @@
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
+ * its address family, recording when each address was first =
sent so a reply's
+ * RTT is measured from the probe to the address that an=
swered=2E An address an
+ * earlier entry already probed in this round is n=
ot probed again; that probe's
+ * reply covers this entry too=2E Returns tr=
ue if at least one address was sent
+ * to or is already covered=2E */
+sta=
tic bool
+oob_probe_send_target(struct probe_ctx *pc, const struct buffer *=
probe, struct oob_probe_target *t)
+{
+    bool any_sent =3D false;
+    /*=
 The RTT runs from an address's first send=2E A reply carries nothing that
=
+     * ties it to a send round, so measuring from a resend would report a
=
+     * server slower than one round as fast=2E */
+    for (int k =3D 0; k=
 < t->n_dests; k++)
+    {
+        const int af =3D probe_af_index(t->dest=
s[k]=2Eaddr=2Esa=2Esa_family);
+        socket_descriptor_t sd =3D pc->sd[a=
f];
+        if (sd =3D=3D SOCKET_UNDEFINED)
+        {
+            contin=
ue;
+        }
+#ifdef TARGET_ANDROID
+        /* Keep the probe out of an =
active tunnel, as the connection socket is=2E
+         * protect_fd_nonloc=
al() declines a local peer, so only a non-local one
+         * actually pr=
otects the socket and may latch the flag=2E */
+        if (!pc->fd_protect=
ed[af] && !addr_local(&t->dests[k]=2Eaddr=2Esa))
+        {
+            pr=
otect_fd_nonlocal(sd, &t->dests[k]=2Eaddr=2Esa);
+            pc->fd_protec=
ted[af] =3D true;
+        }
+#endif
+        const int seen =3D oob_addr_l=
ist_find(pc->probed, pc->n_probed, &t->dests[k]);
+        if (seen >=3D 0)=

+        {
+            /* Already probed this round by an earlier entry: =
share that send
+             * time, so both entries report the same RTT f=
or the one reply=2E */
+            if (oob_sent_at_unset(&t->sent_at[k]))
=
+            {
+                t->sent_at[k] =3D pc->probed_at[seen];
+   =
         }
+            any_sent =3D true;
+            continue;
+        =
}
+        struct timeval sent_at;
+        openvpn_gettimeofday(&sent_at, =
NULL);
+        if (sendto(sd, (const char *)CBPTR(probe), (int)BLEN(probe)=
, 0,
+                   (const struct sockaddr *)&t->dests[k], t->destlens=
[k])
+            >=3D 0)
+        {
+            if (oob_sent_at_unset(&t-=
>sent_at[k]))
+            {
+                t->sent_at[k] =3D sent_at;
+ =
           }
+            pc->probed_at[pc->n_probed] =3D sent_at;
+       =
     pc->probed[pc->n_probed++] =3D t->dests[k];
+            any_sent =3D =
true;
+        }
+    }
+    return any_sent;
+}
+
 /* Parse one received d=
atagram as a PROBE_REPLY and, if valid and matching one
  * of the probes w=
e sent, record the reply in results=2E */
 static void
@@ -364,18 +439,18 @=
@
         return;
     }
 
-    /* Credit the reply to every still-unanswe=
red remote probed at its source
-     * address: several entries can resolv=
e to the same address, and each takes
-     * the first reply for it=2E */
=
+    /* Credit the reply to every still-unanswered remote that was probed a=
t its
+     * source address: several entries can resolve to the same addre=
ss, and each
+     * takes the first reply for it=2E (A remote with several=
 addresses may answer
+     * from more than one; the first one wins, and i=
ts RTT is that address's=2E) */
     struct timeval rcv;
     openvpn_getti=
meofday(&rcv, NULL);
     int i =3D oob_probe_next_target_at(from, targets,=
 results, n, 0);
     while (i >=3D 0)
     {
-        /* From this round's=
 send to now, i=2Ee=2E including any time the reply
-         * waited in t=
he receive queue while we were still sending=2E */
-        long ms =3D (lo=
ng)(rcv=2Etv_sec - targets[i]=2Esent_at=2Etv_sec) * 1000
-                 =
 + (rcv=2Etv_usec - targets[i]=2Esent_at=2Etv_usec) / 1000;
+        /* Fro=
m the first send to this address to now, i=2Ee=2E including any time
+     =
    * the reply waited in the receive queue while we were still sending=2E =
*/
+        const int ms =3D oob_probe_rtt_ms(&targets[i], from, &rcv);
 
 =
        results[i]=2Eresponded =3D true;
         results[i]=2Ertt_ms =3D (=
ms > 0) ? (unsigned int)ms : 0;
@@ -475,27 +550,9 @@
     pc->n_probed =3D =
0;
     for (int i =3D 0; i < n; i++)
     {
-        if (!targets[i]=2Esen=
t || results[i]=2Eresponded)
+        if (targets[i]=2Esent && !results[i]=
=2Eresponded)
         {
-            continue;
-        }
-        if (oob=
_addr_list_find(pc->probed, pc->n_probed, &targets[i]=2Edest) >=3D 0)
-    =
    {
-            continue;
-        }
-        socket_descriptor_t sd =3D=
 pc->sd[probe_af_index(targets[i]=2Edest=2Eaddr=2Esa=2Esa_family)];
-      =
  if (sd =3D=3D SOCKET_UNDEFINED)
-        {
-            continue;
-      =
  }
-        struct timeval sent_at;
-        openvpn_gettimeofday(&sent_at=
, NULL);
-        if (sendto(sd, (const char *)CBPTR(probe), (int)BLEN(prob=
e), 0,
-                   (const struct sockaddr *)&targets[i]=2Edest, tar=
gets[i]=2Edestlen)
-            >=3D 0)
-        {
-            pc->probed_=
at[pc->n_probed] =3D sent_at;
-            pc->probed[pc->n_probed++] =3D t=
argets[i]=2Edest;
+            oob_probe_send_target(pc, probe, &targets[i]=
);
         }
     }
 }
@@ -701,11 +758,24 @@
             continue;
      =
   }
 
-        /* Store the first resolved address natively (no IPv4-mappi=
ng); it is
-         * later probed on its family's socket=2E */
-        m=
emcpy(&targets[i]=2Edest, ai->ai_addr, ai->ai_addrlen);
-        targets[i]=
=2Edestlen =3D (socklen_t)ai->ai_addrlen;
-        need_af[probe_af_index(a=
i->ai_family)] =3D true;
+        /* Store every resolved address natively =
(no IPv4-mapping); each is later
+         * probed on its family's socket=
=2E */
+        struct oob_probe_target *t =3D &targets[i];
+        int n_=
addr =3D 0;
+        for (const struct addrinfo *a =3D ai; a; a =3D a->ai_n=
ext)
+        {
+            n_addr++;
+        }
+        t->dests =3D gc_=
malloc(sizeof(*t->dests) * n_addr, true, &gc);
+        t->destlens =3D gc_=
malloc(sizeof(*t->destlens) * n_addr, true, &gc);
+        t->sent_at =3D g=
c_malloc(sizeof(*t->sent_at) * n_addr, true, &gc);
+        for (const stru=
ct addrinfo *a =3D ai; a; a =3D a->ai_next)
+        {
+            memcpy(=
&t->dests[t->n_dests], a->ai_addr, a->ai_addrlen);
+            t->destlens=
[t->n_dests] =3D (socklen_t)a->ai_addrlen;
+            t->n_dests++;
+    =
        need_af[probe_af_index(a->ai_family)] =3D true;
+        }
        =
 freeaddrinfo(ai);
     }
 
@@ -722,58 +792,32 @@
         return;
     }
 =

-    /* Send a probe to each resolved remote, on the socket of its address=
 family=2E
-     * An address several entries resolve to is probed once; it=
s reply is
-     * credited to each of them=2E */
-    pc=2Eprobed =3D gc_m=
alloc(sizeof(*pc=2Eprobed) * l->len, false, &gc);
-    pc=2Eprobed_at =3D g=
c_malloc(sizeof(*pc=2Eprobed_at) * l->len, false, &gc);
+    /* Send a prob=
e to each resolved remote, on the socket of each address=2E */
+    int n_a=
ddrs =3D 0;
+    for (int i =3D 0; i < l->len; i++)
+    {
+        n_addrs=
 +=3D targets[i]=2En_dests;
+    }
+    pc=2Eprobed =3D gc_malloc(sizeof(*p=
c=2Eprobed) * n_addrs, false, &gc);
+    pc=2Eprobed_at =3D gc_malloc(sizeo=
f(*pc=2Eprobed_at) * n_addrs, false, &gc);
     pc=2En_probed =3D 0;
 
    =
 int sent_count =3D 0;
     for (int i =3D 0; i < l->len; i++)
     {
     =
    const struct connection_entry *ce =3D l->array[i];
-        if (!target=
s[i]=2Edestlen)
+        struct oob_probe_target *t =3D &targets[i];
+     =
   if (t->n_dests =3D=3D 0 || !oob_probe_target_reachable(&pc, t))
        =
 {
+            continue; /* nothing resolved, or its family is not probed =
*/
+        }
+
+        if (!oob_probe_send_target(&pc, &probe, t))
+     =
   {
+            msg(D_LOW, "server-probe: %s:%s: probe send failed", ce->=
remote, ce->remote_port);
             continue;
         }
-        const =
int af =3D probe_af_index(targets[i]=2Edest=2Eaddr=2Esa=2Esa_family);
-    =
    socket_descriptor_t sd =3D pc=2Esd[af];
-        if (sd =3D=3D SOCKET_U=
NDEFINED)
-        {
-            continue; /* family not probed, see oob_p=
robe_sockets_open() */
-        }
-#ifdef TARGET_ANDROID
-        /* Keep t=
he probe out of an active tunnel, as the connection socket is=2E
-         =
* protect_fd_nonlocal() declines a local peer, so only a non-local one
-   =
      * actually protects the socket and may latch the flag=2E */
-        =
if (!pc=2Efd_protected[af] && !addr_local(&targets[i]=2Edest=2Eaddr=2Esa))
=
-        {
-            protect_fd_nonlocal(sd, &targets[i]=2Edest=2Eaddr=
=2Esa);
-            pc=2Efd_protected[af] =3D true;
-        }
-#endif
-  =
      const int seen =3D oob_addr_list_find(pc=2Eprobed, pc=2En_probed, &ta=
rgets[i]=2Edest);
-        if (seen >=3D 0)
-        {
-            /* Alre=
ady probed this round by an earlier entry: reuse that send
-             * =
time, so both entries report the same RTT for the one reply=2E */
-        =
    targets[i]=2Esent_at =3D pc=2Eprobed_at[seen];
-        }
-        else=

-        {
-            openvpn_gettimeofday(&targets[i]=2Esent_at, NULL);=

-            if (sendto(sd, (const char *)BPTR(&probe), (int)BLEN(&probe),=
 0,
-                       (struct sockaddr *)&targets[i]=2Edest, targets[=
i]=2Edestlen)
-                < 0)
-            {
-                msg(D_L=
OW, "server-probe: %s:%s: probe send failed", ce->remote, ce->remote_port);=

-                continue;
-            }
-            pc=2Eprobed_at[pc=
=2En_probed] =3D targets[i]=2Esent_at;
-            pc=2Eprobed[pc=2En_prob=
ed++] =3D targets[i]=2Edest;
-        }
-        targets[i]=2Esent =3D true=
;
+        t->sent =3D true;
         sent_count++;
     }
 
diff --git a/t=
ests/unit_tests/openvpn/test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2E=
c
index 660f6ba=2E=2E6d38adb 100644
--- a/tests/unit_tests/openvpn/test_oob=
=2Ec
+++ b/tests/unit_tests/openvpn/test_oob=2Ec
@@ -519,10 +519,12 @@
    =
 return sa;
 }
 
+/* One probed address per entry=2E */
 static struct oob_=
probe_target
-probe_target(struct openvpn_sockaddr dest, bool sent)
+probe_=
target(struct openvpn_sockaddr *dest, bool sent)
 {
-    return (struct oob=
_probe_target){ =2Edest =3D dest, =2Edestlen =3D sizeof(dest=2Eaddr=2Ein4),=
 =2Esent =3D sent };
+    static socklen_t len =3D sizeof(struct sockaddr_i=
n);
+    return (struct oob_probe_target){ =2Edests =3D dest, =2Edestlens =
=3D &len, =2En_dests =3D 1, =2Esent =3D sent };
 }
 
 /* Two entries resolv=
e to the same address=2E The first reply from it is
@@ -531,7 +533,7 @@
 te=
st_probe_reply_credits_every_entry_at_address(void **state)
 {
     struct =
openvpn_sockaddr a =3D v4_addr(0x7f000001, 1194);
-    struct oob_probe_tar=
get targets[2] =3D { probe_target(a, true), probe_target(a, true) };
+    s=
truct oob_probe_target targets[2] =3D { probe_target(&a, true), probe_targe=
t(&a, true) };
     struct oob_probe_result results[2] =3D { 0 };
 
     in=
t i =3D oob_probe_next_target_at(&a, targets, results, 2, 0);
@@ -555,9 +55=
7,9 @@
     struct openvpn_sockaddr b =3D v4_addr(0x7f000002, 1194);
     s=
truct openvpn_sockaddr a_other_port =3D v4_addr(0x7f000001, 1195);
     str=
uct oob_probe_target targets[3] =3D {
-        probe_target(a, true),
-    =
    probe_target(b, true),
-        probe_target(a, false), /* resolved but=
 never sent */
+        probe_target(&a, true),
+        probe_target(&b, t=
rue),
+        probe_target(&a, false), /* resolved but never sent */
     =
};
     struct oob_probe_result results[3] =3D { 0 };
 
@@ -568,6 +570,70 @=
@
     assert_int_equal(oob_probe_next_target_at(&a_other_port, targets, re=
sults, 3, 0), -1);
 }
 
+/* A remote with several addresses is credited whi=
chever of them answers=2E */
+static void
+test_probe_reply_matches_any_add=
ress_of_entry(void **state)
+{
+    struct openvpn_sockaddr addrs[2] =3D { =
v4_addr(0x7f000001, 1194), v4_addr(0x7f000002, 1194) };
+    socklen_t lens=
[2] =3D { sizeof(struct sockaddr_in), sizeof(struct sockaddr_in) };
+    st=
ruct oob_probe_target targets[1] =3D {
+        { =2Edests =3D addrs, =2Ede=
stlens =3D lens, =2En_dests =3D 2, =2Esent =3D true },
+    };
+    struct =
oob_probe_result results[1] =3D { 0 };
+
+    assert_int_equal(oob_probe_ne=
xt_target_at(&addrs[1], targets, results, 1, 0), 0);
+    assert_int_equal(=
oob_probe_next_target_at(&addrs[0], targets, results, 1, 0), 0);
+}
+
+/* T=
he RTT of a reply is measured from the probe sent to the address that
+ * a=
nswered, not from the first probe sent for the remote=2E */
+static void
+t=
est_probe_rtt_per_address(void **state)
+{
+    struct openvpn_sockaddr add=
rs[2] =3D { v4_addr(0x7f000001, 1194), v4_addr(0x7f000002, 1194) };
+    so=
cklen_t lens[2] =3D { sizeof(struct sockaddr_in), sizeof(struct sockaddr_in=
) };
+    /* A went out at t=3D0 ms, B 20 ms later */
+    struct timeval s=
ent_at[2] =3D { { =2Etv_sec =3D 1000, =2Etv_usec =3D 0 }, { =2Etv_sec =3D 1=
000, =2Etv_usec =3D 20000 } };
+    struct oob_probe_target t =3D { =2Edest=
s =3D addrs, =2Edestlens =3D lens, =2Esent_at =3D sent_at, =2En_dests =3D 2=
, =2Esent =3D true };
+    struct timeval rcv =3D { =2Etv_sec =3D 1000, =2E=
tv_usec =3D 25000 };
+
+    assert_int_equal(oob_probe_rtt_ms(&t, &addrs[1]=
, &rcv), 5);  /* B: 25 - 20 */
+    assert_int_equal(oob_probe_rtt_ms(&t, &=
addrs[0], &rcv), 25); /* A: 25 - 0 */
+
+    /* an address of the remote th=
at was never sent to, and a stranger */
+    sent_at[1] =3D (struct timeval=
){ 0 };
+    assert_int_equal(oob_probe_rtt_ms(&t, &addrs[1], &rcv), -1);
+=
    struct openvpn_sockaddr other =3D v4_addr(0x7f000003, 1194);
+    asser=
t_int_equal(oob_probe_rtt_ms(&t, &other, &rcv), -1);
+
+    /* a clock that=
 went backwards reads as 0, not as a huge value */
+    rcv=2Etv_usec =3D 0=
;
+    sent_at[0]=2Etv_usec =3D 5000;
+    assert_int_equal(oob_probe_rtt_m=
s(&t, &addrs[0], &rcv), 0);
+}
+
+/* IPv6 addresses match on address and po=
rt too=2E */
+static void
+test_probe_addresses_ipv6(void **state)
+{
+    =
struct openvpn_sockaddr a =3D { 0 }, b =3D { 0 };
+    a=2Eaddr=2Ein6=2Esin=
6_family =3D AF_INET6;
+    a=2Eaddr=2Ein6=2Esin6_addr=2Es6_addr[15] =3D 1;=
 /* ::1 */
+    a=2Eaddr=2Ein6=2Esin6_port =3D htons(1194);
+    b =3D a;
+=
    b=2Eaddr=2Ein6=2Esin6_port =3D htons(1195);
+    socklen_t len =3D size=
of(struct sockaddr_in6);
+    struct oob_probe_target targets[1] =3D {
+   =
     { =2Edests =3D &a, =2Edestlens =3D &len, =2En_dests =3D 1, =2Esent =3D=
 true },
+    };
+    struct oob_probe_result results[1] =3D { 0 };
+
+    =
assert_int_equal(oob_probe_next_target_at(&a, targets, results, 1, 0), 0);
=
+    assert_int_equal(oob_probe_next_target_at(&b, targets, results, 1, 0),=
 -1);
+    assert_int_equal(oob_addr_list_find(&a, 1, &a), 0);
+    assert_=
int_equal(oob_addr_list_find(&a, 1, &b), -1);
+}
+
 /* The per-round list o=
f probed addresses compares address and port=2E */
 static void
 test_addr_=
list_find(void **state)
@@ -976,6 +1042,9 @@
         cmocka_unit_test(test=
_server_probe_check_no_parameter),
         cmocka_unit_test(test_probe_rep=
ly_credits_every_entry_at_address),
         cmocka_unit_test(test_probe_re=
ply_matches_only_its_address),
+        cmocka_unit_test(test_probe_reply_m=
atches_any_address_of_entry),
+        cmocka_unit_test(test_probe_rtt_per_=
address),
+        cmocka_unit_test(test_probe_addresses_ipv6),
         cm=
ocka_unit_test(test_addr_list_find),
         cmocka_unit_test(test_client_=
reply_read_finds_reply),
         cmocka_unit_test(test_client_reply_read_s=
kips_unknown),

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1751?usp=3Demail
To unsubscribe, or for help writing mail filters, visit =
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: new=
patchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0=
0208610e0ce4f3ed9a87233e68ece1b3b8a768a
Gerrit-Change-Number: 1751
Gerrit-P=
atchSet: 29
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: pl=
aisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mande=
lbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2En=
et>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attenti=
on: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: stipa <lstipakov@gma=
il=2Ecom>

--S19tpWx8rJE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici, stipa=2E </p>
<p>stipa <strong>=
uploaded patch set #29</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1751?usp=3Demail">View Change</a></p><p>T=
he following approvals got outdated and were removed:
Code-Review+1 by ralf=
_lici</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">oob: Probe every resolved address of a remote<br><br=
>A remote can resolve to several A/AAAA records; --server-probe<br>previous=
ly sent a SERVER_PROBE only to the first one, so a remote whose<br>first ad=
dress was unreachable looked unresponsive even if another<br>address answer=
ed, and the connection could later try an address that was<br>never probed=
=2E<br><br>Probe every resolved address of each remote in parallel (per-rem=
ote<br>storage is sized to the resolved address count, no fixed cap), accep=
t a<br>reply from any of them (first reply for a remote wins), and resend t=
o<br>all of a remote&#39;s addresses while it is unanswered=2E The per-addr=
ess send<br>moves into oob_probe_send_target(), which keeps the<br>one-prob=
e-per-address rule across the addresses of all entries=2E<br><br>The addres=
ses of one remote are taken to be the same service, advertising<br>the same=
 priority, weight and margin; the first of them to answer speaks<br>for the=
 remote, and its round-trip time is measured from the probe sent to<br>that=
 address=2E<br><br>Change-Id: I00208610e0ce4f3ed9a87233e68ece1b3b8a768a<br>=
Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M doc/man-s=
ections/client-options=2Erst<br>M src/openvpn/oob=2Ec<br>M src/openvpn/oob=
=2Eh<br>M src/openvpn/oob_client=2Ec<br>M tests/unit_tests/openvpn/test_oob=
=2Ec<br>5 files changed, 249 insertions(+), 89 deletions(-)<br><br></pre><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/change=
s/51/1751/29</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/doc/man-sections/client-options=2Erst b/d=
oc/man-sections/client-options=2Erst</span><br><span>index eaa7d99=2E=2Ec1a=
fac7 100644</span><br><span>--- a/doc/man-sections/client-options=2Erst</sp=
an><br><span>+++ b/doc/man-sections/client-options=2Erst</span><br><span>@@=
 -604,7 +604,7 @@</span><br><span>      server-probe</span><br><span>      =
server-probe max-latency-diff</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-  A small probe message is sent to the first reso=
lved address of every UDP</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  A small probe message is sent to every resolved address of every UD=
P</span><br><span>   remote, and each answering server replies with its adv=
ertised priority</span><br><span>   and weight=2E Remotes are then reordere=
d following DNS SRV (RFC 2782)</span><br><span>   semantics: servers that a=
nswered are tried before those that did not,</span><br><span>@@ -620,6 +620=
,10 @@</span><br><span>   priority group a candidate, since replies only ar=
rive within the</span><br><span>   one-second probe window; the group is th=
en ordered by weight alone=2E</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  The addresses of one remote are expected to b=
e the same service and to</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  advertise the same values; the first of them to answer speaks for t=
he</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  remote=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>   The p=
robe carries the same control-channel wrapping as a normal</span><br><span>=
   connection (``--tls-auth`` or ``--tls-crypt``, when configured)=2E With<=
/span><br><span>   ``--tls-crypt-v2`` the remotes are left in their configu=
red order,</span><br><span>diff --git a/src/openvpn/oob=2Ec b/src/openvpn/o=
ob=2Ec</span><br><span>index 2cee2a0=2E=2E974b1b3 100644</span><br><span>--=
- a/src/openvpn/oob=2Ec</span><br><span>+++ b/src/openvpn/oob=2Ec</span><br=
><span>@@ -153,9 +153,16 @@</span><br><span> {</span><br><span>     for (in=
t i =3D start; i &lt; n; i++)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (targets[i]=2Esent &amp;&amp; !r=
esults[i]=2Eresponded &amp;&amp; addr_port_match(from, &amp;targets[i]=2Ede=
st))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!ta=
rgets[i]=2Esent || results[i]=2Eresponded)</span><br><span>         {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            return i;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            continue;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        for (int k =3D 0; k &lt; =
targets[i]=2En_dests; k++)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         if (addr_port_match(from, &amp;targets[i]=2Edests[k]))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                return i;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span> =
        }</span><br><span>     }</span><br><span>     return -1;</span><br>=
<span>@@ -174,6 +181,20 @@</span><br><span>     return -1;</span><br><span>=
 }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_rtt_m=
s(const struct oob_probe_target *t, const struct openvpn_sockaddr *from,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                 const=
 struct timeval *rcv)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const int k =
=3D oob_addr_list_find(t-&gt;dests, t-&gt;n_dests, from);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (k &lt; 0 || oob_sent_at_unset=
(&amp;t-&gt;sent_at[k]))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
eturn -1; /* not this remote&#39;s address, or never probed */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    const long ms =3D (long)(rcv-&gt;tv_sec - =
t-&gt;sent_at[k]=2Etv_sec) * 1000</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                    + (rcv-&gt;tv_usec - t-&gt;sent_at[k]=2Et=
v_usec) / 1000;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return (ms &gt; 0) ? (int)ms : 0;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span> /* Base ordering: responders before non-responders, then by p=
riority (lower</span><br><span>  * first), then by RTT (lower first), then =
by original index for determinism=2E</span><br><span>  * This groups respon=
ders into priority runs pre-sorted by RTT, which the</span><br><span>diff -=
-git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh</span><br><span>index 4200=
2dc=2E=2Eae0663c 100644</span><br><span>--- a/src/openvpn/oob=2Eh</span><br=
><span>+++ b/src/openvpn/oob=2Eh</span><br><span>@@ -195,15 +195,37 @@</spa=
n><br><span>     struct oob_probe_reply reply; /* the values the server adv=
ertised */</span><br><span> };</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-/* Where the client probed one connection entry=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Where the =
client probed one connection entry: its resolved addresses=2E */</span><br>=
<span> struct oob_probe_target</span><br><span> {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    struct openvpn_sockaddr dest;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    socklen_t destlen;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    bool sent;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    struct timeval sent_at; /* when the f=
irst probe went out, for the RTT */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct openvpn_sockaddr *dests;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    socklen_t *destlens;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct timeval *sent_at; /* per =
address: when its first probe went out (zero: never) */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    int n_dests;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    bool sent;               /* at least =
one address was probed */</span><br><span> };</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/* An address&#39;s first-send =
time; zero until a probe went out to it=2E */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static inline bool</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+oob_sent_at_unset(const struct timeval *tv)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    return tv-&gt;tv_sec =3D=3D 0 &amp;&amp;=
 tv-&gt;tv_usec =3D=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * Round-trip time of a reply, measured from th=
e first probe sent to the</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * address it came from -- not from the first probe sent for the remo=
te, as</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the addres=
ses of one remote go out one after another=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param t     the probed entry</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @param from  source address of the reply</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @param rcv   when the repl=
y arrived</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return=
 milliseconds (0 if the clock went backwards), or -1 if from is not</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *         an address of t =
or no probe was sent to it</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int oob_p=
robe_rtt_ms(const struct oob_probe_target *t, const struct openvpn_sockaddr=
 *from,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
         const struct timeval *rcv);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span> /**</span><br><span>  * Find the next en=
try, from index \p start on, that was probed at \p from and</span><br><span=
>  * has not answered yet=2E Several entries can resolve to the same addres=
s, so a</span><br><span>diff --git a/src/openvpn/oob_client=2Ec b/src/openv=
pn/oob_client=2Ec</span><br><span>index cac244a=2E=2E75116ce 100644</span><=
br><span>--- a/src/openvpn/oob_client=2Ec</span><br><span>+++ b/src/openvpn=
/oob_client=2Ec</span><br><span>@@ -322,6 +322,81 @@</span><br><span>     }=
</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/* Does any address of t have a probe socket of its famil=
y? */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_target_reach=
able(const struct probe_ctx *pc, const struct oob_probe_target *t)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    for (int k =3D 0; k &lt; t-&gt;n_dests; k+=
+)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (pc-&gt;sd[probe_af_=
index(t-&gt;dests[k]=2Eaddr=2Esa=2Esa_family)] !=3D SOCKET_UNDEFINED)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            return true;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    return false;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Send the probe =
to every resolved address of t, each on the socket matching</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * its address family, recording wh=
en each address was first sent so a reply&#39;s</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * RTT is measured from the probe to the addres=
s that answered=2E An address an</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * earlier entry already probed in this round is not probed ag=
ain; that probe&#39;s</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * reply covers this entry too=2E Returns true if at least one address wa=
s sent</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * to or is a=
lready covered=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_pro=
be_send_target(struct probe_ctx *pc, const struct buffer *probe, struct oob=
_probe_target *t)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool any_sent =
=3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Th=
e RTT runs from an address&#39;s first send=2E A reply carries nothing that=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * ties it to a=
 send round, so measuring from a resend would report a</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * server slower than one round as f=
ast=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (i=
nt k =3D 0; k &lt; t-&gt;n_dests; k++)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        const int af =3D probe_af_index(t-&gt;dests[k]=2Eaddr=2Esa=2Es=
a_family);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        s=
ocket_descriptor_t sd =3D pc-&gt;sd[af];</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if (sd =3D=3D SOCKET_UNDEFINED)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            continue;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#ifdef TARGET_ANDROID</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        /* Keep the probe out of an active tunnel=
, as the connection socket is=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+         * protect_fd_nonlocal() declines a local peer, so onl=
y a non-local one</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
       * actually protects the socket and may latch the flag=2E */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if (!pc-&gt;fd_prote=
cted[af] &amp;&amp; !addr_local(&amp;t-&gt;dests[k]=2Eaddr=2Esa))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            protect_fd_nonlocal(sd, &am=
p;t-&gt;dests[k]=2Eaddr=2Esa);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            pc-&gt;fd_protected[af] =3D true;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        const int seen =3D oob_addr_list_find(pc-&gt;probed, =
pc-&gt;n_probed, &amp;t-&gt;dests[k]);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        if (seen &gt;=3D 0)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            /* Already probed this round by an earlier ent=
ry: share that send</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
             * time, so both entries report the same RTT for the one reply=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            i=
f (oob_sent_at_unset(&amp;t-&gt;sent_at[k]))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                t-&gt;sent_at[k] =3D pc-&gt;probed_at[se=
en];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            any_sent =
=3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  continue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct tim=
eval sent_at;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  openvpn_gettimeofday(&amp;sent_at, NULL);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if (sendto(sd, (const char *)CBPTR(probe), =
(int)BLEN(probe), 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                   (const struct sockaddr *)&amp;t-&gt;dests[k], t-&gt;des=
tlens[k])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  &gt;=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (o=
ob_sent_at_unset(&amp;t-&gt;sent_at[k]))</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                t-&gt;sent_at[k] =3D sent_at;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            pc-&gt;probed_at[pc-&gt;n_pr=
obed] =3D sent_at;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           pc-&gt;probed[pc-&gt;n_probed++] =3D t-&gt;dests[k];</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            any_sent =3D true;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    return any_sent;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> /* Parse one received datagram as a PROBE=
_REPLY and, if valid and matching one</span><br><span>  * of the probes we =
sent, record the reply in results=2E */</span><br><span> static void</span>=
<br><span>@@ -364,18 +439,18 @@</span><br><span>         return;</span><br>=
<span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    /* Credit the reply to every still-unanswered remote probed at=
 its source</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * add=
ress: several entries can resolve to the same address, and each takes</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-     * the first reply for =
it=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Cred=
it the reply to every still-unanswered remote that was probed at its</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * source address: sev=
eral entries can resolve to the same address, and each</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * takes the first reply for it=2E (=
A remote with several addresses may answer</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * from more than one; the first one wins, and i=
ts RTT is that address&#39;s=2E) */</span><br><span>     struct timeval rcv=
;</span><br><span>     openvpn_gettimeofday(&amp;rcv, NULL);</span><br><spa=
n>     int i =3D oob_probe_next_target_at(from, targets, results, n, 0);</s=
pan><br><span>     while (i &gt;=3D 0)</span><br><span>     {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        /* From this round&#39;s se=
nd to now, i=2Ee=2E including any time the reply</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-         * waited in the receive queue while we =
were still sending=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        long ms =3D (long)(rcv=2Etv_sec - targets[i]=2Esent_at=2Etv_sec)=
 * 1000</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
    + (rcv=2Etv_usec - targets[i]=2Esent_at=2Etv_usec) / 1000;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        /* From the first send t=
o this address to now, i=2Ee=2E including any time</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+         * the reply waited in the receive q=
ueue while we were still sending=2E */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        const int ms =3D oob_probe_rtt_ms(&amp;targets[i=
], from, &amp;rcv);</span><br><span> </span><br><span>         results[i]=
=2Eresponded =3D true;</span><br><span>         results[i]=2Ertt_ms =3D (ms=
 &gt; 0) ? (unsigned int)ms : 0;</span><br><span>@@ -475,27 +550,9 @@</span=
><br><span>     pc-&gt;n_probed =3D 0;</span><br><span>     for (int i =3D =
0; i &lt; n; i++)</span><br><span>     {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        if (!targets[i]=2Esent || results[i]=2Eresponded=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (target=
s[i]=2Esent &amp;&amp; !results[i]=2Eresponded)</span><br><span>         {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            continue;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        if (oob_addr_list_find(pc-=
&gt;probed, pc-&gt;n_probed, &amp;targets[i]=2Edest) &gt;=3D 0)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            continue;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        socket_descriptor_t sd =3D pc-&gt;sd[probe_af_i=
ndex(targets[i]=2Edest=2Eaddr=2Esa=2Esa_family)];</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        if (sd =3D=3D SOCKET_UNDEFINED)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            continue;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        struct timeval sent_at;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        openvpn_gettimeofday(&amp;sent_at, =
NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (sen=
dto(sd, (const char *)CBPTR(probe), (int)BLEN(probe), 0,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                   (const struct sockadd=
r *)&amp;targets[i]=2Edest, targets[i]=2Edestlen)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            &gt;=3D 0)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            pc-&gt;probed_at[pc-&gt;n_probed] =3D sent_at;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            pc-&gt;pr=
obed[pc-&gt;n_probed++] =3D targets[i]=2Edest;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            oob_probe_send_target(pc, probe, &am=
p;targets[i]);</span><br><span>         }</span><br><span>     }</span><br>=
<span> }</span><br><span>@@ -701,11 +758,24 @@</span><br><span>            =
 continue;</span><br><span>         }</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        /* Store the first resolved addre=
ss natively (no IPv4-mapping); it is</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-         * later probed on its family&#39;s socket=2E */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        memcpy(&amp;targe=
ts[i]=2Edest, ai-&gt;ai_addr, ai-&gt;ai_addrlen);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        targets[i]=2Edestlen =3D (socklen_t)ai-=
&gt;ai_addrlen;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  need_af[probe_af_index(ai-&gt;ai_family)] =3D true;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* Store every resolved address n=
atively (no IPv4-mapping); each is later</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+         * probed on its family&#39;s socket=2E */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct oob_prob=
e_target *t =3D &amp;targets[i];</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        int n_addr =3D 0;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        for (const struct addrinfo *a =3D ai; a; a =3D a=
-&gt;ai_next)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            n_ad=
dr++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        t-&gt;dests =3D =
gc_malloc(sizeof(*t-&gt;dests) * n_addr, true, &amp;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        t-&gt;destlens =3D gc_malloc(s=
izeof(*t-&gt;destlens) * n_addr, true, &amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        t-&gt;sent_at =3D gc_malloc(sizeof(*t-=
&gt;sent_at) * n_addr, true, &amp;gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        for (const struct addrinfo *a =3D ai; a; a =3D a=
-&gt;ai_next)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            memc=
py(&amp;t-&gt;dests[t-&gt;n_dests], a-&gt;ai_addr, a-&gt;ai_addrlen);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            t-&gt;destlen=
s[t-&gt;n_dests] =3D (socklen_t)a-&gt;ai_addrlen;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            t-&gt;n_dests++;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            need_af[probe_af_index(a=
-&gt;ai_family)] =3D true;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        }</span><br><span>         freeaddrinfo(ai);</span><br><span=
>     }</span><br><span> </span><br><span>@@ -722,58 +792,32 @@</span><br><=
span>         return;</span><br><span>     }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    /* Send a probe to each resolv=
ed remote, on the socket of its address family=2E</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-     * An address several entries resolve to is=
 probed once; its reply is</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-     * credited to each of them=2E */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    pc=2Eprobed =3D gc_malloc(sizeof(*pc=2Eprobed) * l=
-&gt;len, false, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    pc=2Eprobed_at =3D gc_malloc(sizeof(*pc=2Eprobed_at) * l-&gt;len, =
false, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* Send a probe to each resolved remote, on the socket of each address=2E =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int n_addrs =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int =
i =3D 0; i &lt; l-&gt;len; i++)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      n_addrs +=3D targets[i]=2En_dests;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    pc=2Eprobed =3D gc_malloc(sizeof(*pc=2Eprobed) * n_addrs, false,=
 &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pc=2E=
probed_at =3D gc_malloc(sizeof(*pc=2Eprobed_at) * n_addrs, false, &amp;gc);=
</span><br><span>     pc=2En_probed =3D 0;</span><br><span> </span><br><spa=
n>     int sent_count =3D 0;</span><br><span>     for (int i =3D 0; i &lt; =
l-&gt;len; i++)</span><br><span>     {</span><br><span>         const struc=
t connection_entry *ce =3D l-&gt;array[i];</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        if (!targets[i]=2Edestlen)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        struct oob_probe_target *t =3D =
&amp;targets[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (t-&gt;n_dests =3D=3D 0 || !oob_probe_target_reachable(&amp;pc, t))=
</span><br><span>         {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            continue; /* nothing resolved, or its family is not pro=
bed */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (!oob_probe_send_target(&amp;p=
c, &amp;probe, t))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 msg(D_LOW, &quot;server-probe: %s:%s: probe send failed&quot;, ce-&gt;remo=
te, ce-&gt;remote_port);</span><br><span>             continue;</span><br><=
span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  const int af =3D probe_af_index(targets[i]=2Edest=2Eaddr=2Esa=2Esa_family=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        socket_desc=
riptor_t sd =3D pc=2Esd[af];</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        if (sd =3D=3D SOCKET_UNDEFINED)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            continue; /* family not probed, see oob_probe_sock=
ets_open() */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef TARGET_ANDROI=
D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* Keep the =
probe out of an active tunnel, as the connection socket is=2E</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-         * protect_fd_nonlocal() de=
clines a local peer, so only a non-local one</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-         * actually protects the socket and may latc=
h the flag=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   if (!pc=2Efd_protected[af] &amp;&amp; !addr_local(&amp;targets[i]=2Edest=
=2Eaddr=2Esa))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            protect=
_fd_nonlocal(sd, &amp;targets[i]=2Edest=2Eaddr=2Esa);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            pc=2Efd_protected[af] =3D true;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        const int seen =3D oob_addr_list_find(pc=
=2Eprobed, pc=2En_probed, &amp;targets[i]=2Edest);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        if (seen &gt;=3D 0)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            /* Already probed this round by an earli=
er entry: reuse that send</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-             * time, so both entries report the same RTT for the one re=
ply=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
targets[i]=2Esent_at =3D pc=2Eprobed_at[seen];</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        else</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    openvpn_gettimeofday(&amp;targets[i]=2Esent_at, NULL);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            if (sendto(sd, (const char=
 *)BPTR(&amp;probe), (int)BLEN(&amp;probe), 0,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                       (struct sockaddr *)&amp;tar=
gets[i]=2Edest, targets[i]=2Edestlen)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                &lt; 0)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                msg(D_LOW, &quot;server-probe: %s:%s: probe send =
failed&quot;, ce-&gt;remote, ce-&gt;remote_port);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                continue;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            pc=2Eprobed_at[pc=2En_probed] =3D targe=
ts[i]=2Esent_at;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       pc=2Eprobed[pc=2En_probed++] =3D targets[i]=2Edest;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        targets[i]=2Esent =3D true;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        t-&gt;sent =3D true;</span=
><br><span>         sent_count++;</span><br><span>     }</span><br><span> <=
/span><br><span>diff --git a/tests/unit_tests/openvpn/test_oob=2Ec b/tests/=
unit_tests/openvpn/test_oob=2Ec</span><br><span>index 660f6ba=2E=2E6d38adb =
100644</span><br><span>--- a/tests/unit_tests/openvpn/test_oob=2Ec</span><b=
r><span>+++ b/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>@@ -519=
,10 +519,12 @@</span><br><span>     return sa;</span><br><span> }</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* One prob=
ed address per entry=2E */</span><br><span> static struct oob_probe_target<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-probe_target(struct op=
envpn_sockaddr dest, bool sent)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+probe_target(struct openvpn_sockaddr *dest, bool sent)</span><b=
r><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return =
(struct oob_probe_target){ =2Edest =3D dest, =2Edestlen =3D sizeof(dest=2Ea=
ddr=2Ein4), =2Esent =3D sent };</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    static socklen_t len =3D sizeof(struct sockaddr_in);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return (struct oob_pro=
be_target){ =2Edests =3D dest, =2Edestlens =3D &amp;len, =2En_dests =3D 1, =
=2Esent =3D sent };</span><br><span> }</span><br><span> </span><br><span> /=
* Two entries resolve to the same address=2E The first reply from it is</sp=
an><br><span>@@ -531,7 +533,7 @@</span><br><span> test_probe_reply_credits_=
every_entry_at_address(void **state)</span><br><span> {</span><br><span>   =
  struct openvpn_sockaddr a =3D v4_addr(0x7f000001, 1194);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    struct oob_probe_target targets[2]=
 =3D { probe_target(a, true), probe_target(a, true) };</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_target targets[2] =
=3D { probe_target(&amp;a, true), probe_target(&amp;a, true) };</span><br><=
span>     struct oob_probe_result results[2] =3D { 0 };</span><br><span> </=
span><br><span>     int i =3D oob_probe_next_target_at(&amp;a, targets, res=
ults, 2, 0);</span><br><span>@@ -555,9 +557,9 @@</span><br><span>     struc=
t openvpn_sockaddr b =3D v4_addr(0x7f000002, 1194);</span><br><span>     st=
ruct openvpn_sockaddr a_other_port =3D v4_addr(0x7f000001, 1195);</span><br=
><span>     struct oob_probe_target targets[3] =3D {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        probe_target(a, true),</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        probe_target(b, true),</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        probe_target(a, f=
alse), /* resolved but never sent */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        probe_target(&amp;a, true),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        probe_target(&amp;b, true),</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        probe_target(&amp=
;a, false), /* resolved but never sent */</span><br><span>     };</span><br=
><span>     struct oob_probe_result results[3] =3D { 0 };</span><br><span> =
</span><br><span>@@ -568,6 +570,70 @@</span><br><span>     assert_int_equal=
(oob_probe_next_target_at(&amp;a_other_port, targets, results, 3, 0), -1);<=
/span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/* A remote with several addresses is credited whichever o=
f them answers=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_pr=
obe_reply_matches_any_address_of_entry(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct openvpn_sockaddr addrs[2] =3D { v4_addr(0x7f0000=
01, 1194), v4_addr(0x7f000002, 1194) };</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    socklen_t lens[2] =3D { sizeof(struct sockaddr_in),=
 sizeof(struct sockaddr_in) };</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct oob_probe_target targets[1] =3D {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        { =2Edests =3D addrs, =2Edestle=
ns =3D lens, =2En_dests =3D 2, =2Esent =3D true },</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct oob_probe_result results[1] =3D { 0 };</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_int_equal(oob_probe_next_target_at(=
&amp;addrs[1], targets, results, 1, 0), 0);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_int_equal(oob_probe_next_target_at(&amp;=
addrs[0], targets, results, 1, 0), 0);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* The RTT of a re=
ply is measured from the probe sent to the address that</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * answered, not from the first probe s=
ent for the remote=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tes=
t_probe_rtt_per_address(void **state)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct openvpn_sockaddr addrs[2] =3D { v4_addr(0x7f000001, 1194), v4_ad=
dr(0x7f000002, 1194) };</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    socklen_t lens[2] =3D { sizeof(struct sockaddr_in), sizeof(struct s=
ockaddr_in) };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
* A went out at t=3D0 ms, B 20 ms later */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct timeval sent_at[2] =3D { { =2Etv_sec =3D =
1000, =2Etv_usec =3D 0 }, { =2Etv_sec =3D 1000, =2Etv_usec =3D 20000 } };</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_=
target t =3D { =2Edests =3D addrs, =2Edestlens =3D lens, =2Esent_at =3D sen=
t_at, =2En_dests =3D 2, =2Esent =3D true };</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct timeval rcv =3D { =2Etv_sec =3D 1000, =
=2Etv_usec =3D 25000 };</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_=
equal(oob_probe_rtt_ms(&amp;t, &amp;addrs[1], &amp;rcv), 5);  /* B: 25 - 20=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_e=
qual(oob_probe_rtt_ms(&amp;t, &amp;addrs[0], &amp;rcv), 25); /* A: 25 - 0 *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* an address of the remote that =
was never sent to, and a stranger */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    sent_at[1] =3D (struct timeval){ 0 };</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(oob_probe_rtt_m=
s(&amp;t, &amp;addrs[1], &amp;rcv), -1);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct openvpn_sockaddr other =3D v4_addr(0x7f0000=
03, 1194);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_int_equal(oob_probe_rtt_ms(&amp;t, &amp;other, &amp;rcv), -1);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* a clock that went backwards reads as 0, no=
t as a huge value */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    rcv=2Etv_usec =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    sent_at[0]=2Etv_usec =3D 5000;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_int_equal(oob_probe_rtt_ms(&amp;t, &amp;add=
rs[0], &amp;rcv), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/* IPv6 addresses match on address =
and port too=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_prob=
e_addresses_ipv6(void **state)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct openvpn_sockaddr a =3D { 0 }, b =3D { 0 };</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    a=2Eaddr=2Ein6=2Esin6_family =3D AF_INET6;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=2Eaddr=2Ein6=2E=
sin6_addr=2Es6_addr[15] =3D 1; /* ::1 */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    a=2Eaddr=2Ein6=2Esin6_port =3D htons(1194);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    b =3D a;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    b=2Eaddr=2Ein6=2Esin6_port =
=3D htons(1195);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 socklen_t len =3D sizeof(struct sockaddr_in6);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct oob_probe_target targets[1] =3D {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        { =2Edests =3D=
 &amp;a, =2Edestlens =3D &amp;len, =2En_dests =3D 1, =2Esent =3D true },</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_result results=
[1] =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(oob=
_probe_next_target_at(&amp;a, targets, results, 1, 0), 0);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(oob_probe_next_=
target_at(&amp;b, targets, results, 1, 0), -1);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_int_equal(oob_addr_list_find(&amp;a,=
 1, &amp;a), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_int_equal(oob_addr_list_find(&amp;a, 1, &amp;b), -1);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> /* The per-round list of probed a=
ddresses compares address and port=2E */</span><br><span> static void</span=
><br><span> test_addr_list_find(void **state)</span><br><span>@@ -976,6 +10=
42,9 @@</span><br><span>         cmocka_unit_test(test_server_probe_check_n=
o_parameter),</span><br><span>         cmocka_unit_test(test_probe_reply_cr=
edits_every_entry_at_address),</span><br><span>         cmocka_unit_test(te=
st_probe_reply_matches_only_its_address),</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        cmocka_unit_test(test_probe_reply_matches_any=
_address_of_entry),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        cmocka_unit_test(test_probe_rtt_per_address),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_probe_addre=
sses_ipv6),</span><br><span>         cmocka_unit_test(test_addr_list_find),=
</span><br><span>         cmocka_unit_test(test_client_reply_read_finds_rep=
ly),</span><br><span>         cmocka_unit_test(test_client_reply_read_skips=
_unknown),</span><br><span></span><br></pre><p>To view, visit <a href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1751?usp=3Demail">change 1751</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1751?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0020=
8610e0ce4f3ed9a87233e68ece1b3b8a768a </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1751 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 29 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov=
@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plais=
thos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; <=
/div>

</body></html>
--S19tpWx8rJE=--


--===============3930236607239781858==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3930236607239781858==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3930236607239781858==--

