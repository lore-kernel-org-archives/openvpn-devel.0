Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB5ACA5FA1
	for <openvpn-devel@archiver.kernel.org>; Tue, 29 Sep 2026 13:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z2skBg//XSAuYTv6IwUlrkXXALtc00eqEUSSC5lh0JA=; b=DaMg9IGcMdFrwnSDSoNf5SeoaB
	FNcT1jmVwBZP8C4XA0N3ZBkTLfI3EuT2gDF/ReBy3+lZzagK55WjzWwgRZHrOSz7/aQchY65mNh9d
	WgM4T1e8xnAoxTbtlQTp4MUA1HJYDUCQbn4bycpcRlCBaOftEoNptGYwe2TFuSLUkLdI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBXhn-0003dg-L8;
	Tue, 29 Sep 2026 13:17:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBXhk-0003dT-J1
 for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 13:17:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=lRxELwhW/3KUNLrRn3fs0vgkTqmHn+sPKbvHt2OiSVs=; b=iG09UhuJ0ia7n4S49C/xvP6cpT
 ovGBD6QEBVBH1WGNwdVG3gmjgqVcfJVyXbTjWaRoDNKY/PijSd+/PprjuTVzWFrVJLoo5/Psm05hu
 p5pmaXIpeHp/vlZYJVYerCTCoCNCWxyGMi+Kv/Y7bertxjRBNBm6SIH63j7xIBzK1P0s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=lRxELwhW/3KUNLrRn3fs0vgkTqmHn+sPKbvHt2OiSVs=; b=f
 qaIo0VReBJo2y98oHMEAaCxVLQg3b6jqCcXu/odC6XjCaKGsvWM5bTb7KPzhaD+eCBgip/V9itSx+
 VYgm4c8d+duOlcruDqdQXezrGxp8UTa5uTBOR3BjZCRGrNljxUyaTWmhYLhI8ub5ZnuryOWX0LDdL
 ZE0O0gd/tmw12pl0=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBXhh-0007lh-Qx for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 13:17:08 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ffbd83a92so23890905e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 29 Sep 2026 06:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790687819; x=1791292619; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lRxELwhW/3KUNLrRn3fs0vgkTqmHn+sPKbvHt2OiSVs=;
 b=PcKB5XrVuGD0hfEp1xDB8Y2v6rT95ExOBHOgjIno/rbHD63ud8NaT5sjDp4hiF1coX
 LRTQRbV0EIwti6c9L/rlCYA8mHC75st1Io4L8HK50zIitPW8ixZ1XbuYD/s9SLz+2mOh
 aIyibsD9ygvfrbNSLHeiDSKu2R4PtEuaX4g2imA7W8XyI7rzFUCDmCHKkI5RzOHChvvJ
 ENGM2isfYLaVzU1wQjjJ6xLm8oBrRW+qe1x68Jqa1EjhA7nNhVqVKkYRTWXBXaTpqCbW
 2OHHJw5ziYFn0Y+g+Psbm12y1huOxpxaAxtbELZh9oClQ/dR96T8bYUmfERk3Yl/EA+t
 rVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790687819; x=1791292619;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=lRxELwhW/3KUNLrRn3fs0vgkTqmHn+sPKbvHt2OiSVs=;
 b=nMWY+NTYQn4+AsRfo30SSM15N6tUCg/wlaYRi6rJ2ABJEmi4xCEdhiUeMexEw5ERe6
 yx9SzztnZ1Jvq4Hr2LPgrUpR7KhOnfwcxY31jIEu94PUOskzalyJePyn8lOU7XwRbkAR
 X4b8UgZDwP91AB0Gr9XQ5pN03vQ+4cv0mcnwRfIWWd+Rsc3XGTfJALMvjc/PU5vtgrfg
 UJKJxM6esDc4XB87t43d7mRDsK3CQPYaiDymFkA0WqE0gBANgOAMn1XaWrO6rsAvV7FX
 p6tl+aRt3kcWwlD3PcsgfM8K56n4QC2qfadOrixb0khNEVGDJFM9lPbFwWh4RLdYew3v
 /R6Q==
X-Gm-Message-State: AFuF++nMjTIo1aDLTw04+1iLWtfWWDNCSuUkwRck/s0ifLH5pISplyXE
 94nD0dFWr87Cm8Z9I+7rghwE7kxHwNqnQAeHRVjHf9yoK8Sv999FiNrGjFYcth9B1vKQ6hIje/1
 OIKGiXVQhTuo48JX7hp4tF1W9bNZQ0TSviVRr1PowC33EcQOu+mlKdhsIT0fUhNqHMxJy
X-Gm-Gg: AYBFou0orMY4V4IjlqUSb4+5UYQ35R+vHuPVsPbBSk2TuXVbFJlAAgpuAji9N2zKynJ
 znAg31TKMyTQ/P+AtZQym/+g+ZJLa8RDv7jXPZ53rVn2CfVOBFg7alMRuFFQtBuOyUR8GqsDHEH
 pFDdTt/A6GKJtY6XryfN+Cq8C4n7XjHnx3f88iN0UOGeDLYIu144+SUC49yOK95JqlcIoceyrJ3
 9x5U2+W4/Ct+urBJ2+57BwqXs81sjwxSj6GAoTTuFMK0UL/Af2wgPmw3sOiCVmnSJ8QhQt+u7xH
 8nFVfgdJxorHKZfNd+sD4/ABih55Islmedgr3wlYpYNp+L6H+3KgzIaXbRi3lR53pLMR9kVbztI
 GsoV5ux2Y2en8fXsRsXT8eTt9cj9HF0EVbbeBCI04N5xOmDItk+kLKUYriYwbidPDmm2xtKcUw4
 wnq50KQHyjJ8uVDjrFQqgKVmcLh1KWc4eP6oqQQJdnREtwyL62UFR4OmDJerGBpMmSxuSVI+M9w
 rsFUWA4pJ2TKtoZhL/QrfHCr6rYIrfBXlzKC4+7icEWd6hQxWvjfcTRsWAzhV0yHxKbxMBBDfYJ
 mmzVT3m66/358011/n3vZvRTgVhC17vl9LNsYrF1wj2S5idE1ADsDRu+THjTY7Ud+350EtE=
X-Received: by 2002:a05:600c:4f91:b0:49f:fdca:c361 with SMTP id
 5b1f17b1804b1-4a0121a87a3mr28720685e9.12.1790687818866; 
 Tue, 29 Sep 2026 06:16:58 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a013d00570sm3347765e9.3.2026.09.29.06.16.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 06:16:58 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 29 Sep 2026 13:16:31 +0000
To: ralf_lici <ralf@mandelbit.com>,
	plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 31
X-Gerrit-Change-Id: I00208610e0ce4f3ed9a87233e68ece1b3b8a768a
X-Gerrit-Change-Number: 1751
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1751?usp=email>
X-Gerrit-Commit: 58058ae597eb465b6919f75240ae3bb91a40206c
In-Reply-To: <gerrit.1782719911000.I00208610e0ce4f3ed9a87233e68ece1b3b8a768a@gerrit.openvpn.net>
References: <gerrit.1782719911000.I00208610e0ce4f3ed9a87233e68ece1b3b8a768a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkwMDIwODYxMGUwY2U0ZjNlZDlhODcyMzNlNjhlY2UxYjNiOGE3NjhhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6780be094da5979e55a7c33acd36303bc4c50d1a-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBXhh-0007lh-Qx
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
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0846408159193794500=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0846408159193794500==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="88XQwT16DBk="; charset=UTF-8

--88XQwT16DBk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici, stipa=2E

Hello=
 plaisthos, ralf_lici, 

I'd like you to reexamine a change=2E Please visit=


    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1751?usp=3Demail

to look a=
t the new patch set (#31)=2E

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
esolve to several A/AAAA records; --server-probe sent a
SERVER_PROBE only t=
o the first one, so a remote whose first address was
unreachable looked unr=
esponsive even if another address answered, and
the connection could later =
try an address that was never probed=2E

Probe every resolved address of ea=
ch remote in parallel, accept a reply
from any of them (first reply for a r=
emote wins), and resend to all of
a remote's addresses while it is unanswer=
ed=2E An address shared by
several entries is still probed once per round=
=2E

The addresses of one remote are taken to be the same service,
advertis=
ing the same priority, weight and margin; the first of them to
answer speak=
s for the remote, with the round-trip time of the probe it
answers=2E

Chan=
ge-Id: I00208610e0ce4f3ed9a87233e68ece1b3b8a768a
Signed-off-by: Lev Stipako=
v <lev@openvpn=2Enet>
---
M doc/man-sections/client-options=2Erst
M src/ope=
nvpn/oob=2Ec
M src/openvpn/oob=2Eh
M src/openvpn/oob_client=2Ec
M tests/uni=
t_tests/openvpn/test_oob=2Ec
5 files changed, 160 insertions(+), 58 deletio=
ns(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/=
51/1751/31

diff --git a/doc/man-sections/client-options=2Erst b/doc/man-se=
ctions/client-options=2Erst
index f1f004f=2E=2E7749f37 100644
--- a/doc/man=
-sections/client-options=2Erst
+++ b/doc/man-sections/client-options=2Erst
=
@@ -604,7 +604,7 @@
      server-probe
      server-probe max-latency-diff
=
 
-  A small probe message is sent to the first resolved address of every U=
DP
+  A small probe message is sent to every resolved address of every UDP
=
   remote, and each answering server replies with its advertised priority
 =
  and weight=2E Remotes are then reordered following DNS SRV (RFC 2782)
   =
semantics: servers that answered are tried before those that did not,
@@ -6=
20,6 +620,10 @@
   priority group a candidate, since replies only arrive wi=
thin the
   one-second probe window; the group is then ordered by weight al=
one=2E
 
+  The addresses of one remote are expected to be the same service=
 and to
+  advertise the same values; the first of them to answer speaks fo=
r the
+  remote=2E
+
   The probe carries the same control-channel wrapping=
 as a normal
   connection (``--tls-auth`` or ``--tls-crypt``, when configu=
red)=2E With
   ``--tls-crypt-v2`` the remotes are left in their configured=
 order,
diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec
index 20e3fe=
2=2E=2Eb92a182 100644
--- a/src/openvpn/oob=2Ec
+++ b/src/openvpn/oob=2Ec
@=
@ -125,9 +125,16 @@
 {
     for (int i =3D start; i < n; i++)
     {
-     =
   if (targets[i]=2Esent && !results[i]=2Eresponded && addr_port_match(from=
, &targets[i]=2Edest))
+        if (!targets[i]=2Esent || results[i]=2Eresp=
onded)
         {
-            return i;
+            continue;
+        }
=
+        for (int k =3D 0; k < targets[i]=2En_dests; k++)
+        {
+     =
       if (addr_port_match(from, &targets[i]=2Edests[k]))
+            {
+ =
               return i;
+            }
         }
     }
     return -1;
d=
iff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh
index 0070904=2E=2Ef6=
6a1dc 100644
--- a/src/openvpn/oob=2Eh
+++ b/src/openvpn/oob=2Eh
@@ -170,12=
 +170,13 @@
     struct oob_probe_reply reply; /* the values the server adv=
ertised */
 };
 
-/* Where the client probed one connection entry=2E */
+/*=
 Where the client probed one connection entry: its resolved addresses=2E */=

 struct oob_probe_target
 {
-    struct openvpn_sockaddr dest;
-    sockle=
n_t destlen;
-    bool sent;
+    struct openvpn_sockaddr *dests;
+    sock=
len_t *destlens;
+    int n_dests;
+    bool sent; /* at least one address =
was probed */
 };
 
 /* One SERVER_PROBE transmission=2E Its request_id is =
a per-run random base plus
diff --git a/src/openvpn/oob_client=2Ec b/src/op=
envpn/oob_client=2Ec
index 65a4bd0=2E=2Eabf53a0 100644
--- a/src/openvpn/oo=
b_client=2Ec
+++ b/src/openvpn/oob_client=2Ec
@@ -364,6 +364,55 @@
     }
 =
}
 
+/* Does any address of t have a probe socket of its family? */
+static=
 bool
+oob_probe_target_reachable(const struct probe_ctx *pc, const struct =
oob_probe_target *t)
+{
+    for (int k =3D 0; k < t->n_dests; k++)
+    {
=
+        if (pc->sd[probe_af_index(t->dests[k]=2Eaddr=2Esa=2Esa_family)] !=
=3D SOCKET_UNDEFINED)
+        {
+            return true;
+        }
+    =
}
+    return false;
+}
+
+/* Send a probe to every resolved address of t, =
each on the socket matching
+ * its address family=2E An address an earlier=
 entry already probed in this round
+ * is not probed again; that probe's r=
eply covers this entry too=2E Returns true
+ * if at least one address was =
sent to or is already covered=2E */
+static bool
+oob_probe_send_target(str=
uct probe_ctx *pc, struct oob_probe_target *t)
+{
+    bool any_sent =3D fa=
lse;
+    for (int k =3D 0; k < t->n_dests; k++)
+    {
+        const int =
af =3D probe_af_index(t->dests[k]=2Eaddr=2Esa=2Esa_family);
+        socket=
_descriptor_t sd =3D pc->sd[af];
+        if (sd =3D=3D SOCKET_UNDEFINED)
+=
        {
+            continue;
+        }
+#ifdef TARGET_ANDROID
+       =
 /* Keep the probe out of an active tunnel, as the connection socket is=2E
=
+         * protect_fd_nonlocal() declines a local peer, so only a non-loca=
l one
+         * actually protects the socket and may latch the flag=2E */=

+        if (!pc->fd_protected[af] && !addr_local(&t->dests[k]=2Eaddr=2Esa=
))
+        {
+            protect_fd_nonlocal(sd, &t->dests[k]=2Eaddr=2Esa=
);
+            pc->fd_protected[af] =3D true;
+        }
+#endif
+        =
if (oob_probe_sent_this_round(pc, &t->dests[k])
+            || oob_probe_s=
end_to(pc, sd, &t->dests[k], t->destlens[k]))
+        {
+            any_s=
ent =3D true;
+        }
+    }
+    return any_sent;
+}
+
 /* Parse one re=
ceived datagram as a PROBE_REPLY and, if valid and answering one
  * of the=
 probes we sent, record the reply in results=2E */
 static void
@@ -412,9 +=
461,10 @@
         return; /* answers no probe we sent to that address */
 =
    }
 
-    /* Credit the reply to every still-unanswered remote probed at=
 its source
-     * address: several entries can resolve to the same addres=
s, and each takes
-     * the first reply for it=2E */
+    /* Credit the r=
eply to every still-unanswered remote that was probed at its
+     * source=
 address: several entries can resolve to the same address, and each
+     *=
 takes the first reply for it=2E (A remote with several addresses may answe=
r
+     * from more than one; the first one wins=2E) */
     int i =3D oob_=
probe_next_target_at(from, targets, results, n, 0);
     while (i >=3D 0)
 =
    {
@@ -506,23 +556,18 @@
 
 /* Resend the probe to every remote that we =
probed but that has not answered=2E */
 static void
-oob_probe_resend_unans=
wered(struct probe_ctx *pc, const struct oob_probe_target *targets,
+oob_pr=
obe_resend_unanswered(struct probe_ctx *pc, struct oob_probe_target *target=
s,
                             const struct oob_probe_result *results, int=
 n)
 {
-    /* a new round: probe each unanswered address once again, with =
a new
-     * request_id */
+    /* A new round: every unanswered address i=
s probed once more, with a new
+     * request_id=2E A late reply to an ear=
lier round still counts, with the RTT
+     * of the transmission it answer=
s=2E */
     pc->round_start =3D pc->n_sends;
     for (int i =3D 0; i < n;=
 i++)
     {
-        if (!targets[i]=2Esent || results[i]=2Eresponded
-   =
         || oob_probe_sent_this_round(pc, &targets[i]=2Edest))
+        if =
(targets[i]=2Esent && !results[i]=2Eresponded)
         {
-            cont=
inue;
-        }
-        socket_descriptor_t sd =3D pc->sd[probe_af_index(=
targets[i]=2Edest=2Eaddr=2Esa=2Esa_family)];
-        if (sd !=3D SOCKET_UN=
DEFINED)
-        {
-            oob_probe_send_to(pc, sd, &targets[i]=2Ede=
st, targets[i]=2Edestlen);
+            oob_probe_send_target(pc, &targets[=
i]);
         }
     }
 }
@@ -533,7 +578,7 @@
  * each slice but the last w=
e resend to whoever has not answered yet=2E Returns
  * once the window ela=
pses or every sent probe has been answered=2E */
 static void
-oob_probe_co=
llect(struct probe_ctx *pc, const struct oob_probe_target *targets,
+oob_pr=
obe_collect(struct probe_ctx *pc, struct oob_probe_target *targets,
       =
            struct oob_probe_result *results, int n, const struct signal_in=
fo *sig)
 {
     /* number of probes we actually sent: stop early once they=
 all answer */
@@ -707,11 +752,23 @@
             continue;
         }
 
- =
       /* Store the first resolved address natively (no IPv4-mapping); it i=
s
-         * later probed on its family's socket=2E */
-        memcpy(&ta=
rgets[i]=2Edest, ai->ai_addr, ai->ai_addrlen);
-        targets[i]=2Edestle=
n =3D (socklen_t)ai->ai_addrlen;
-        need_af[probe_af_index(ai->ai_fam=
ily)] =3D true;
+        /* Store every resolved address natively (no IPv4-=
mapping); each is later
+         * probed on its family's socket=2E */
+  =
      struct oob_probe_target *t =3D &targets[i];
+        int n_addr =3D 0=
;
+        for (const struct addrinfo *a =3D ai; a; a =3D a->ai_next)
+    =
    {
+            n_addr++;
+        }
+        t->dests =3D gc_malloc(siz=
eof(*t->dests) * n_addr, true, &gc);
+        t->destlens =3D gc_malloc(siz=
eof(*t->destlens) * n_addr, true, &gc);
+        for (const struct addrinfo=
 *a =3D ai; a; a =3D a->ai_next)
+        {
+            memcpy(&t->dests[t=
->n_dests], a->ai_addr, a->ai_addrlen);
+            t->destlens[t->n_dests=
] =3D (socklen_t)a->ai_addrlen;
+            t->n_dests++;
+            nee=
d_af[probe_af_index(a->ai_family)] =3D true;
+        }
         freeaddrin=
fo(ai);
     }
 
@@ -728,43 +785,32 @@
         return;
     }
 
-    /* Se=
nd a probe to each resolved remote, on the socket of its address family=2E
=
-     * An address several entries resolve to is probed once per round; its=
 reply is
-     * credited to each of them=2E */
-    pc=2Emax_sends =3D l-=
>len * (1 + OOB_PROBE_RETRIES); /* each round probes an address once */
+  =
  /* Send a probe to each resolved remote, on the socket of each address=2E=
 */
+    int n_addrs =3D 0;
+    for (int i =3D 0; i < l->len; i++)
+    {
=
+        n_addrs +=3D targets[i]=2En_dests;
+    }
+    /* Each round probe=
s every address at most once=2E */
+    pc=2Emax_sends =3D n_addrs * (1 + O=
OB_PROBE_RETRIES);
     pc=2Esends =3D gc_malloc(sizeof(*pc=2Esends) * pc=
=2Emax_sends, true, &gc);
 
     int sent_count =3D 0;
     for (int i =3D =
0; i < l->len; i++)
     {
         const struct connection_entry *ce =3D l=
->array[i];
-        if (!targets[i]=2Edestlen)
+        struct oob_probe_t=
arget *t =3D &targets[i];
+        if (t->n_dests =3D=3D 0 || !oob_probe_ta=
rget_reachable(&pc, t))
         {
-            continue;
+            cont=
inue; /* nothing resolved, or its family is not probed */
         }
-     =
   const int af =3D probe_af_index(targets[i]=2Edest=2Eaddr=2Esa=2Esa_famil=
y);
-        socket_descriptor_t sd =3D pc=2Esd[af];
-        if (sd =3D=3D=
 SOCKET_UNDEFINED)
-        {
-            continue; /* family not probed, =
see oob_probe_sockets_open() */
-        }
-#ifdef TARGET_ANDROID
-        =
/* Keep the probe out of an active tunnel, as the connection socket is=2E
-=
         * protect_fd_nonlocal() declines a local peer, so only a non-local=
 one
-         * actually protects the socket and may latch the flag=2E */
=
-        if (!pc=2Efd_protected[af] && !addr_local(&targets[i]=2Edest=2Eadd=
r=2Esa))
-        {
-            protect_fd_nonlocal(sd, &targets[i]=2Edest=
=2Eaddr=2Esa);
-            pc=2Efd_protected[af] =3D true;
-        }
-#en=
dif
-        if (!oob_probe_sent_this_round(&pc, &targets[i]=2Edest)
-     =
       && !oob_probe_send_to(&pc, sd, &targets[i]=2Edest, targets[i]=2Edest=
len))
+
+        if (!oob_probe_send_target(&pc, t))
         {
           =
  msg(D_LOW, "server-probe: %s:%s: probe send failed", ce->remote, ce->remo=
te_port);
             continue;
         }
-        targets[i]=2Esent =3D =
true;
+        t->sent =3D true;
         sent_count++;
     }
 
diff --git=
 a/tests/unit_tests/openvpn/test_oob=2Ec b/tests/unit_tests/openvpn/test_oo=
b=2Ec
index e0fae4b=2E=2Ea0efa56 100644
--- a/tests/unit_tests/openvpn/test=
_oob=2Ec
+++ b/tests/unit_tests/openvpn/test_oob=2Ec
@@ -558,10 +558,12 @@
=
     return sa;
 }
 
+/* One probed address per entry=2E */
 static struct =
oob_probe_target
-probe_target(struct openvpn_sockaddr dest, bool sent)
+pr=
obe_target(struct openvpn_sockaddr *dest, bool sent)
 {
-    return (struct=
 oob_probe_target){ =2Edest =3D dest, =2Edestlen =3D sizeof(dest=2Eaddr=2Ei=
n4), =2Esent =3D sent };
+    static socklen_t len =3D sizeof(struct sockad=
dr_in);
+    return (struct oob_probe_target){ =2Edests =3D dest, =2Edestle=
ns =3D &len, =2En_dests =3D 1, =2Esent =3D sent };
 }
 
 /* Two entries res=
olve to the same address=2E The first reply from it is
@@ -570,7 +572,7 @@
=
 test_probe_reply_credits_every_entry_at_address(void **state)
 {
     stru=
ct openvpn_sockaddr a =3D v4_addr(0x7f000001, 1194);
-    struct oob_probe_=
target targets[2] =3D { probe_target(a, true), probe_target(a, true) };
+  =
  struct oob_probe_target targets[2] =3D { probe_target(&a, true), probe_ta=
rget(&a, true) };
     struct oob_probe_result results[2] =3D { 0 };
 
    =
 int i =3D oob_probe_next_target_at(&a, targets, results, 2, 0);
@@ -594,9 =
+596,9 @@
     struct openvpn_sockaddr b =3D v4_addr(0x7f000002, 1194);
   =
  struct openvpn_sockaddr a_other_port =3D v4_addr(0x7f000001, 1195);
     =
struct oob_probe_target targets[3] =3D {
-        probe_target(a, true),
- =
       probe_target(b, true),
-        probe_target(a, false), /* resolved =
but never sent */
+        probe_target(&a, true),
+        probe_target(&b=
, true),
+        probe_target(&a, false), /* resolved but never sent */
  =
   };
     struct oob_probe_result results[3] =3D { 0 };
 
@@ -607,6 +609,2=
1 @@
     assert_int_equal(oob_probe_next_target_at(&a_other_port, targets,=
 results, 3, 0), -1);
 }
 
+/* A remote with several addresses is credited =
whichever of them answers=2E */
+static void
+test_probe_reply_matches_any_=
address_of_entry(void **state)
+{
+    struct openvpn_sockaddr addrs[2] =3D=
 { v4_addr(0x7f000001, 1194), v4_addr(0x7f000002, 1194) };
+    socklen_t l=
ens[2] =3D { sizeof(struct sockaddr_in), sizeof(struct sockaddr_in) };
+   =
 struct oob_probe_target targets[1] =3D {
+        { =2Edests =3D addrs, =
=2Edestlens =3D lens, =2En_dests =3D 2, =2Esent =3D true },
+    };
+    st=
ruct oob_probe_result results[1] =3D { 0 };
+
+    assert_int_equal(oob_pro=
be_next_target_at(&addrs[1], targets, results, 1, 0), 0);
+    assert_int_e=
qual(oob_probe_next_target_at(&addrs[0], targets, results, 1, 0), 0);
+}
+
=
 /* The RTT of a reply is measured from the transmission its request_id nam=
es (as
  * an index into the transmissions), which must have gone to the ad=
dress the
  * reply came from=2E */
@@ -639,6 +656,31 @@
     assert_int_eq=
ual(oob_probe_rtt_ms(sends, 3, 2, &a, &rcv), 0);
 }
 
+/* IPv6 addresses ma=
tch on address and port too=2E */
+static void
+test_probe_addresses_ipv6(v=
oid **state)
+{
+    struct openvpn_sockaddr a =3D { 0 }, b =3D { 0 };
+   =
 a=2Eaddr=2Ein6=2Esin6_family =3D AF_INET6;
+    a=2Eaddr=2Ein6=2Esin6_addr=
=2Es6_addr[15] =3D 1; /* ::1 */
+    a=2Eaddr=2Ein6=2Esin6_port =3D htons(1=
194);
+    b =3D a;
+    b=2Eaddr=2Ein6=2Esin6_port =3D htons(1195);
+    s=
ocklen_t len =3D sizeof(struct sockaddr_in6);
+    struct oob_probe_target =
targets[1] =3D {
+        { =2Edests =3D &a, =2Edestlens =3D &len, =2En_des=
ts =3D 1, =2Esent =3D true },
+    };
+    struct oob_probe_result results[=
1] =3D { 0 };
+
+    assert_int_equal(oob_probe_next_target_at(&a, targets,=
 results, 1, 0), 0);
+    assert_int_equal(oob_probe_next_target_at(&b, tar=
gets, results, 1, 0), -1);
+
+    const struct oob_probe_send sends[1] =3D =
{ { =2Edest =3D a } };
+    const struct timeval rcv =3D { 0 };
+    assert=
_int_equal(oob_probe_rtt_ms(sends, 1, 0, &a, &rcv), 0);
+    assert_int_equ=
al(oob_probe_rtt_ms(sends, 1, 0, &b, &rcv), -1);
+}
+
 /* A PROBE_REPLY car=
rying a probe reply is found by the client scan, with all
  * fields surviv=
ing=2E */
 static void
@@ -1028,7 +1070,9 @@
         cmocka_unit_test(test=
_server_probe_check_no_request),
         cmocka_unit_test(test_probe_reply=
_credits_every_entry_at_address),
         cmocka_unit_test(test_probe_repl=
y_matches_only_its_address),
+        cmocka_unit_test(test_probe_reply_mat=
ches_any_address_of_entry),
         cmocka_unit_test(test_probe_rtt_from_a=
nswered_send),
+        cmocka_unit_test(test_probe_addresses_ipv6),
      =
   cmocka_unit_test(test_client_reply_read_finds_reply),
         cmocka_un=
it_test(test_client_reply_read_skips_unknown),
         cmocka_unit_test(te=
st_client_reply_read_rejects_unknown_mandatory),

-- 
To view, visit http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1751?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-B=
ranch: master
Gerrit-Change-Id: I00208610e0ce4f3ed9a87233e68ece1b3b8a768a
G=
errit-Change-Number: 1751
Gerrit-PatchSet: 31
Gerrit-Owner: stipa <lstipako=
v@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: ralf_lici <ralf@man=
delbit=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Attent=
ion: plaisthos <arne-openvpn@rfc2549=2Eorg>

--88XQwT16DBk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici, stipa=2E </p>
<p>stipa <strong>=
uploaded patch set #31</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1751?usp=3Demail">View Change</a></p><p>T=
he following approvals got outdated and were removed:
Code-Review+1 by ralf=
_lici</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">oob: Probe every resolved address of a remote<br><br=
>A remote can resolve to several A/AAAA records; --server-probe sent a<br>S=
ERVER_PROBE only to the first one, so a remote whose first address was<br>u=
nreachable looked unresponsive even if another address answered, and<br>the=
 connection could later try an address that was never probed=2E<br><br>Prob=
e every resolved address of each remote in parallel, accept a reply<br>from=
 any of them (first reply for a remote wins), and resend to all of<br>a rem=
ote&#39;s addresses while it is unanswered=2E An address shared by<br>sever=
al entries is still probed once per round=2E<br><br>The addresses of one re=
mote are taken to be the same service,<br>advertising the same priority, we=
ight and margin; the first of them to<br>answer speaks for the remote, with=
 the round-trip time of the probe it<br>answers=2E<br><br>Change-Id: I00208=
610e0ce4f3ed9a87233e68ece1b3b8a768a<br>Signed-off-by: Lev Stipakov &lt;lev@=
openvpn=2Enet&gt;<br>---<br>M doc/man-sections/client-options=2Erst<br>M sr=
c/openvpn/oob=2Ec<br>M src/openvpn/oob=2Eh<br>M src/openvpn/oob_client=2Ec<=
br>M tests/unit_tests/openvpn/test_oob=2Ec<br>5 files changed, 160 insertio=
ns(+), 58 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eo=
penvpn=2Enet:29418/openvpn refs/changes/51/1751/31</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/doc=
/man-sections/client-options=2Erst b/doc/man-sections/client-options=2Erst<=
/span><br><span>index f1f004f=2E=2E7749f37 100644</span><br><span>--- a/doc=
/man-sections/client-options=2Erst</span><br><span>+++ b/doc/man-sections/c=
lient-options=2Erst</span><br><span>@@ -604,7 +604,7 @@</span><br><span>   =
   server-probe</span><br><span>      server-probe max-latency-diff</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  A small p=
robe message is sent to the first resolved address of every UDP</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  A small probe message is sent=
 to every resolved address of every UDP</span><br><span>   remote, and each=
 answering server replies with its advertised priority</span><br><span>   a=
nd weight=2E Remotes are then reordered following DNS SRV (RFC 2782)</span>=
<br><span>   semantics: servers that answered are tried before those that d=
id not,</span><br><span>@@ -620,6 +620,10 @@</span><br><span>   priority gr=
oup a candidate, since replies only arrive within the</span><br><span>   on=
e-second probe window; the group is then ordered by weight alone=2E</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+  The add=
resses of one remote are expected to be the same service and to</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  advertise the same values; th=
e first of them to answer speaks for the</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  remote=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span>   The probe carries the same control-channel=
 wrapping as a normal</span><br><span>   connection (``--tls-auth`` or ``--=
tls-crypt``, when configured)=2E With</span><br><span>   ``--tls-crypt-v2``=
 the remotes are left in their configured order,</span><br><span>diff --git=
 a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec</span><br><span>index 20e3fe2=
=2E=2Eb92a182 100644</span><br><span>--- a/src/openvpn/oob=2Ec</span><br><s=
pan>+++ b/src/openvpn/oob=2Ec</span><br><span>@@ -125,9 +125,16 @@</span><b=
r><span> {</span><br><span>     for (int i =3D start; i &lt; n; i++)</span>=
<br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   if (targets[i]=2Esent &amp;&amp; !results[i]=2Eresponded &amp;&amp; addr=
_port_match(from, &amp;targets[i]=2Edest))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if (!targets[i]=2Esent || results[i]=2Erespo=
nded)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            return i;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            continue;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        for (int k =3D 0; k &lt; targets[i]=2En_dests; k++)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            if (addr_port_match(from, &a=
mp;targets[i]=2Edests[k]))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                return i;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            }</span><br><span>         }</span><br><span>     }</spa=
n><br><span>     return -1;</span><br><span>diff --git a/src/openvpn/oob=2E=
h b/src/openvpn/oob=2Eh</span><br><span>index 0070904=2E=2Ef66a1dc 100644</=
span><br><span>--- a/src/openvpn/oob=2Eh</span><br><span>+++ b/src/openvpn/=
oob=2Eh</span><br><span>@@ -170,12 +170,13 @@</span><br><span>     struct o=
ob_probe_reply reply; /* the values the server advertised */</span><br><spa=
n> };</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-/* Where the client probed one connection entry=2E */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/* Where the client probed one connecti=
on entry: its resolved addresses=2E */</span><br><span> struct oob_probe_ta=
rget</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    struct openvpn_sockaddr dest;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    socklen_t destlen;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    bool sent;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct openvpn_sockaddr *dests;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    socklen_t *destlens;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    int n_dests;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    bool sent; /* at least one address was prob=
ed */</span><br><span> };</span><br><span> </span><br><span> /* One SERVER_=
PROBE transmission=2E Its request_id is a per-run random base plus</span><b=
r><span>diff --git a/src/openvpn/oob_client=2Ec b/src/openvpn/oob_client=2E=
c</span><br><span>index 65a4bd0=2E=2Eabf53a0 100644</span><br><span>--- a/s=
rc/openvpn/oob_client=2Ec</span><br><span>+++ b/src/openvpn/oob_client=2Ec<=
/span><br><span>@@ -364,6 +364,55 @@</span><br><span>     }</span><br><span=
> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/* Does any address of t have a probe socket of its family? */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+oob_probe_target_reachable(const struc=
t probe_ctx *pc, const struct oob_probe_target *t)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    for (int k =3D 0; k &lt; t-&gt;n_dests; k++)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if (pc-&gt;sd[probe_af_index(t-&gt;dest=
s[k]=2Eaddr=2Esa=2Esa_family)] !=3D SOCKET_UNDEFINED)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            return true;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/* Send a probe to every resolved =
address of t, each on the socket matching</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * its address family=2E An address an earlier entry =
already probed in this round</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * is not probed again; that probe&#39;s reply covers this entry t=
oo=2E Returns true</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* if at least one address was sent to or is already covered=2E */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+oob_probe_send_target(struct probe_ct=
x *pc, struct oob_probe_target *t)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 bool any_sent =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    for (int k =3D 0; k &lt; t-&gt;n_dests; k++)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        const int af =3D probe_af_index(t-&gt;dests[k]=
=2Eaddr=2Esa=2Esa_family);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        socket_descriptor_t sd =3D pc-&gt;sd[af];</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        if (sd =3D=3D SOCKET_UNDEFINED=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            continue;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#ifdef TARGET_ANDROID</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        /* Keep the probe out of a=
n active tunnel, as the connection socket is=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+         * protect_fd_nonlocal() declines a loc=
al peer, so only a non-local one</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+         * actually protects the socket and may latch the flag=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!=
pc-&gt;fd_protected[af] &amp;&amp; !addr_local(&amp;t-&gt;dests[k]=2Eaddr=
=2Esa))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            protect_fd=
_nonlocal(sd, &amp;t-&gt;dests[k]=2Eaddr=2Esa);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            pc-&gt;fd_protected[af] =3D true;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        if (oob_probe_sent_this_round(pc, &a=
mp;t-&gt;dests[k])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           || oob_probe_send_to(pc, sd, &amp;t-&gt;dests[k], t-&gt;destlens=
[k]))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            any_sent =3D=
 true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return any_sent;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> /* Parse one received datagram as a =
PROBE_REPLY and, if valid and answering one</span><br><span>  * of the prob=
es we sent, record the reply in results=2E */</span><br><span> static void<=
/span><br><span>@@ -412,9 +461,10 @@</span><br><span>         return; /* an=
swers no probe we sent to that address */</span><br><span>     }</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Credit =
the reply to every still-unanswered remote probed at its source</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-     * address: several entries c=
an resolve to the same address, and each takes</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-     * the first reply for it=2E */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* Credit the reply to every s=
till-unanswered remote that was probed at its</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     * source address: several entries can resolv=
e to the same address, and each</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+     * takes the first reply for it=2E (A remote with several a=
ddresses may answer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     * from more than one; the first one wins=2E) */</span><br><span>     i=
nt i =3D oob_probe_next_target_at(from, targets, results, n, 0);</span><br>=
<span>     while (i &gt;=3D 0)</span><br><span>     {</span><br><span>@@ -5=
06,23 +556,18 @@</span><br><span> </span><br><span> /* Resend the probe to =
every remote that we probed but that has not answered=2E */</span><br><span=
> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-oob_prob=
e_resend_unanswered(struct probe_ctx *pc, const struct oob_probe_target *ta=
rgets,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_res=
end_unanswered(struct probe_ctx *pc, struct oob_probe_target *targets,</spa=
n><br><span>                             const struct oob_probe_result *res=
ults, int n)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    /* a new round: probe each unanswered address once again, wit=
h a new</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * request=
_id */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* A new =
round: every unanswered address is probed once more, with a new</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * request_id=2E A late rep=
ly to an earlier round still counts, with the RTT</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     * of the transmission it answers=2E */</=
span><br><span>     pc-&gt;round_start =3D pc-&gt;n_sends;</span><br><span>=
     for (int i =3D 0; i &lt; n; i++)</span><br><span>     {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        if (!targets[i]=2Esent || re=
sults[i]=2Eresponded</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           || oob_probe_sent_this_round(pc, &amp;targets[i]=2Edest))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (targets[i]=2Es=
ent &amp;&amp; !results[i]=2Eresponded)</span><br><span>         {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            continue;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        socket_descriptor_t sd =3D pc-&gt;=
sd[probe_af_index(targets[i]=2Edest=2Eaddr=2Esa=2Esa_family)];</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        if (sd !=3D SOCKET_UNDEFIN=
ED)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            oob_probe_send_to(=
pc, sd, &amp;targets[i]=2Edest, targets[i]=2Edestlen);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            oob_probe_send_target(pc, &a=
mp;targets[i]);</span><br><span>         }</span><br><span>     }</span><br=
><span> }</span><br><span>@@ -533,7 +578,7 @@</span><br><span>  * each slic=
e but the last we resend to whoever has not answered yet=2E Returns</span><=
br><span>  * once the window elapses or every sent probe has been answered=
=2E */</span><br><span> static void</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-oob_probe_collect(struct probe_ctx *pc, const struct oob_prob=
e_target *targets,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+o=
ob_probe_collect(struct probe_ctx *pc, struct oob_probe_target *targets,</s=
pan><br><span>                   struct oob_probe_result *results, int n, c=
onst struct signal_info *sig)</span><br><span> {</span><br><span>     /* nu=
mber of probes we actually sent: stop early once they all answer */</span><=
br><span>@@ -707,11 +752,23 @@</span><br><span>             continue;</span=
><br><span>         }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        /* Store the first resolved address natively (no =
IPv4-mapping); it is</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
        * later probed on its family&#39;s socket=2E */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        memcpy(&amp;targets[i]=2Edest, ai=
-&gt;ai_addr, ai-&gt;ai_addrlen);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        targets[i]=2Edestlen =3D (socklen_t)ai-&gt;ai_addrlen;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        need_af[probe_=
af_index(ai-&gt;ai_family)] =3D true;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        /* Store every resolved address natively (no IPv4=
-mapping); each is later</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+         * probed on its family&#39;s socket=2E */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        struct oob_probe_target *t =3D =
&amp;targets[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     int n_addr =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        for (const struct addrinfo *a =3D ai; a; a =3D a-&gt;ai_next)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            n_addr++;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        t-&gt;dests =3D gc_malloc(sizeof=
(*t-&gt;dests) * n_addr, true, &amp;gc);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        t-&gt;destlens =3D gc_malloc(sizeof(*t-&gt;des=
tlens) * n_addr, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        for (const struct addrinfo *a =3D ai; a; a =3D a-&gt;a=
i_next)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            memcpy(&am=
p;t-&gt;dests[t-&gt;n_dests], a-&gt;ai_addr, a-&gt;ai_addrlen);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            t-&gt;destlens[t-&g=
t;n_dests] =3D (socklen_t)a-&gt;ai_addrlen;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            t-&gt;n_dests++;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            need_af[probe_af_index(a-&gt;=
ai_family)] =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span>         freeaddrinfo(ai);</span><br><span>    =
 }</span><br><span> </span><br><span>@@ -728,43 +785,32 @@</span><br><span>=
         return;</span><br><span>     }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    /* Send a probe to each resolved re=
mote, on the socket of its address family=2E</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-     * An address several entries resolve to is prob=
ed once per round; its reply is</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-     * credited to each of them=2E */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    pc=2Emax_sends =3D l-&gt;len * (1 + OOB_PROBE=
_RETRIES); /* each round probes an address once */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* Send a probe to each resolved remote,=
 on the socket of each address=2E */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    int n_addrs =3D 0;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    for (int i =3D 0; i &lt; l-&gt;len; i++)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        n_addrs +=3D targets[i]=2En_dests;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* Each round probes every addr=
ess at most once=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    pc=2Emax_sends =3D n_addrs * (1 + OOB_PROBE_RETRIES);</span><br><spa=
n>     pc=2Esends =3D gc_malloc(sizeof(*pc=2Esends) * pc=2Emax_sends, true,=
 &amp;gc);</span><br><span> </span><br><span>     int sent_count =3D 0;</sp=
an><br><span>     for (int i =3D 0; i &lt; l-&gt;len; i++)</span><br><span>=
     {</span><br><span>         const struct connection_entry *ce =3D l-&gt=
;array[i];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if =
(!targets[i]=2Edestlen)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        struct oob_probe_target *t =3D &amp;targets[i];</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (t-&gt;n_dests =3D=3D 0 =
|| !oob_probe_target_reachable(&amp;pc, t))</span><br><span>         {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            continue;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            continue; /*=
 nothing resolved, or its family is not probed */</span><br><span>         =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const int af=
 =3D probe_af_index(targets[i]=2Edest=2Eaddr=2Esa=2Esa_family);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        socket_descriptor_t sd =
=3D pc=2Esd[af];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   if (sd =3D=3D SOCKET_UNDEFINED)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            continue; /* family not probed, see oob_probe_sockets_open() *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#ifdef TARGET_ANDROID</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        /* Keep the probe out of=
 an active tunnel, as the connection socket is=2E</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-         * protect_fd_nonlocal() declines a loc=
al peer, so only a non-local one</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-         * actually protects the socket and may latch the flag=
=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!pc=
=2Efd_protected[af] &amp;&amp; !addr_local(&amp;targets[i]=2Edest=2Eaddr=2E=
sa))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            protect_fd_nonloc=
al(sd, &amp;targets[i]=2Edest=2Eaddr=2Esa);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            pc=2Efd_protected[af] =3D true;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        if (!oob_probe_sent_this_round(&amp;pc, &amp;targe=
ts[i]=2Edest)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    &amp;&amp; !oob_probe_send_to(&amp;pc, sd, &amp;targets[i]=2Edest, targ=
ets[i]=2Edestlen))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!oob_pro=
be_send_target(&amp;pc, t))</span><br><span>         {</span><br><span>    =
         msg(D_LOW, &quot;server-probe: %s:%s: probe send failed&quot;, ce-=
&gt;remote, ce-&gt;remote_port);</span><br><span>             continue;</sp=
an><br><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        targets[i]=2Esent =3D true;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        t-&gt;sent =3D true;</span><br><span>         sen=
t_count++;</span><br><span>     }</span><br><span> </span><br><span>diff --=
git a/tests/unit_tests/openvpn/test_oob=2Ec b/tests/unit_tests/openvpn/test=
_oob=2Ec</span><br><span>index e0fae4b=2E=2Ea0efa56 100644</span><br><span>=
--- a/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>+++ b/tests/uni=
t_tests/openvpn/test_oob=2Ec</span><br><span>@@ -558,10 +558,12 @@</span><b=
r><span>     return sa;</span><br><span> }</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/* One probed address per entry=2E=
 */</span><br><span> static struct oob_probe_target</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-probe_target(struct openvpn_sockaddr dest, =
bool sent)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+probe_tar=
get(struct openvpn_sockaddr *dest, bool sent)</span><br><span> {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    return (struct oob_probe_tar=
get){ =2Edest =3D dest, =2Edestlen =3D sizeof(dest=2Eaddr=2Ein4), =2Esent =
=3D sent };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stat=
ic socklen_t len =3D sizeof(struct sockaddr_in);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return (struct oob_probe_target){ =2Edests=
 =3D dest, =2Edestlens =3D &amp;len, =2En_dests =3D 1, =2Esent =3D sent };<=
/span><br><span> }</span><br><span> </span><br><span> /* Two entries resolv=
e to the same address=2E The first reply from it is</span><br><span>@@ -570=
,7 +572,7 @@</span><br><span> test_probe_reply_credits_every_entry_at_addre=
ss(void **state)</span><br><span> {</span><br><span>     struct openvpn_soc=
kaddr a =3D v4_addr(0x7f000001, 1194);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    struct oob_probe_target targets[2] =3D { probe_target(=
a, true), probe_target(a, true) };</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct oob_probe_target targets[2] =3D { probe_target(&a=
mp;a, true), probe_target(&amp;a, true) };</span><br><span>     struct oob_=
probe_result results[2] =3D { 0 };</span><br><span> </span><br><span>     i=
nt i =3D oob_probe_next_target_at(&amp;a, targets, results, 2, 0);</span><b=
r><span>@@ -594,9 +596,9 @@</span><br><span>     struct openvpn_sockaddr b =
=3D v4_addr(0x7f000002, 1194);</span><br><span>     struct openvpn_sockaddr=
 a_other_port =3D v4_addr(0x7f000001, 1195);</span><br><span>     struct oo=
b_probe_target targets[3] =3D {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        probe_target(a, true),</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        probe_target(b, true),</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        probe_target(a, false), /* resolved but=
 never sent */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   probe_target(&amp;a, true),</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        probe_target(&amp;b, true),</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        probe_target(&amp;a, false), /* resolved=
 but never sent */</span><br><span>     };</span><br><span>     struct oob_=
probe_result results[3] =3D { 0 };</span><br><span> </span><br><span>@@ -60=
7,6 +609,21 @@</span><br><span>     assert_int_equal(oob_probe_next_target_=
at(&amp;a_other_port, targets, results, 3, 0), -1);</span><br><span> }</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A r=
emote with several addresses is credited whichever of them answers=2E */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+test_probe_reply_matches_any_a=
ddress_of_entry(void **state)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct openvpn_sockaddr addrs[2] =3D { v4_addr(0x7f000001, 1194), v4_addr(0x7f0=
00002, 1194) };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
socklen_t lens[2] =3D { sizeof(struct sockaddr_in), sizeof(struct sockaddr_=
in) };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oo=
b_probe_target targets[1] =3D {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        { =2Edests =3D addrs, =2Edestlens =3D lens, =2En_dests =
=3D 2, =2Esent =3D true },</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct oob_probe_result results[1] =3D { 0 };</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_int_equal(oob_probe_next_target_at(&amp;addrs[1], targets, =
results, 1, 0), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_int_equal(oob_probe_next_target_at(&amp;addrs[0], targets, resul=
ts, 1, 0), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* Th=
e RTT of a reply is measured from the transmission its request_id names (as=
</span><br><span>  * an index into the transmissions), which must have gone=
 to the address the</span><br><span>  * reply came from=2E */</span><br><sp=
an>@@ -639,6 +656,31 @@</span><br><span>     assert_int_equal(oob_probe_rtt=
_ms(sends, 3, 2, &amp;a, &amp;rcv), 0);</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* IPv6 addresses =
match on address and port too=2E */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+test_probe_addresses_ipv6(void **state)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct openvpn_sockaddr a =3D { 0 }, b =3D { 0 };</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    a=2Eaddr=2Ein6=2Esin6_famil=
y =3D AF_INET6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
a=2Eaddr=2Ein6=2Esin6_addr=2Es6_addr[15] =3D 1; /* ::1 */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    a=2Eaddr=2Ein6=2Esin6_port =3D ht=
ons(1194);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    b =3D=
 a;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    b=2Eaddr=2Ei=
n6=2Esin6_port =3D htons(1195);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    socklen_t len =3D sizeof(struct sockaddr_in6);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_target targ=
ets[1] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 { =2Edests =3D &amp;a, =2Edestlens =3D &amp;len, =2En_dests =3D 1, =2Esent=
 =3D true },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe=
_result results[1] =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_int_equal(oob_probe_next_target_at(&amp;a, targets, results, 1, 0), 0);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(=
oob_probe_next_target_at(&amp;b, targets, results, 1, 0), -1);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    const struct oob_probe_send sends[1] =3D { { =
=2Edest =3D a } };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   const struct timeval rcv =3D { 0 };</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_int_equal(oob_probe_rtt_ms(sends, 1, 0, &amp;=
a, &amp;rcv), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_int_equal(oob_probe_rtt_ms(sends, 1, 0, &amp;b, &amp;rcv), -1);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* A PROBE_REPLY carry=
ing a probe reply is found by the client scan, with all</span><br><span>  *=
 fields surviving=2E */</span><br><span> static void</span><br><span>@@ -10=
28,7 +1070,9 @@</span><br><span>         cmocka_unit_test(test_server_probe=
_check_no_request),</span><br><span>         cmocka_unit_test(test_probe_re=
ply_credits_every_entry_at_address),</span><br><span>         cmocka_unit_t=
est(test_probe_reply_matches_only_its_address),</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_probe_reply_match=
es_any_address_of_entry),</span><br><span>         cmocka_unit_test(test_pr=
obe_rtt_from_answered_send),</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        cmocka_unit_test(test_probe_addresses_ipv6),</span><br><sp=
an>         cmocka_unit_test(test_client_reply_read_finds_reply),</span><br=
><span>         cmocka_unit_test(test_client_reply_read_skips_unknown),</sp=
an><br><span>         cmocka_unit_test(test_client_reply_read_rejects_unkno=
wn_mandatory),</span><br></pre><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1751?usp=3Demail">change 1751</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1751?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I00208610e0ce4f3ed=
9a87233e68ece1b3b8a768a </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1751 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 31 </div>
=
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf=
@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body>=
</html>
--88XQwT16DBk=--


--===============0846408159193794500==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0846408159193794500==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0846408159193794500==--

