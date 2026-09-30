Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F3B0CA5FC4
	for <openvpn-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PraMXHbK5Nnv49zCkxOmI6S3MGZRtPn4kQVgQy3zlX4=; b=KVLQ+RF2UVxrpeTEcwKNqbyzph
	+If/g2FWIO2gKcgBd95ZMDCZRPSO/nKf8a+L5wCijnVUnA7Td57HjW7+QsegHnq3Ne0qnopZdI4/Z
	Lqjn80w91qLNOyKnvuGundwtESzkadJAq8PPYaiL3gmX0b5gaBgxBgUYokOlffyky/0w=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBpe9-0001Xb-Bk;
	Wed, 30 Sep 2026 08:26:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBpdz-0001WY-L1
 for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 08:26:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=KmQZ+OOZqUF31Y1kxuFiuWhDcIOBLD8TKDlvk/LiPms=; b=h8mTLpP31Vhk8PEKd/YIawkfgi
 6OF8jVvpJzGx2qRWGSnzt5LNcXiDMSnCThEDMexVHNwICVzHLokfsicyl8fBebVFsfEVp/B6BOpfE
 hOJV9C0VACSP1zJ+W7LTJ9yK/kjLWYM7i2hSDPbz+u8TXfzV30KXGfsip37mpN8KEEQo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=KmQZ+OOZqUF31Y1kxuFiuWhDcIOBLD8TKDlvk/LiPms=; b=R
 e9C40HYgid6rqx5F1D3uaEwsceNMmf0Rlz3PP8jaBl8UqJgQHcehdGkeTBN5Bx4NtEKa0rN6BOeDU
 l/nSRglQZmefMqACzWu2VxTGB0Fiuhynwv+cXpMvcOtvWfKOg7R8j2EFs1sx6UgKolas06ZYBAcav
 OGP1YV7GUhhZexJM=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBpdh-0006kA-Iw for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 08:26:12 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e6c0fce17so27089625e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 30 Sep 2026 01:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790756763; x=1791361563; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KmQZ+OOZqUF31Y1kxuFiuWhDcIOBLD8TKDlvk/LiPms=;
 b=EvyhSRUamnFql9LXH/5Lc+qxzDNi0XvohjBhxK80bwLZ9LuO/4ULOvbDnNwNF9cXTU
 CStCfc+dBv7JkoSoYWUJibuEz76Pr1XtJFuEkPdGFNJXJtlLnSEUei4e+BmDmCP1vBGR
 5CsAxAITxR5oysxFLJbu+sGtZ7vRvaIQ+XXLahLJIjFTO0lF3bxSWrN0sRZkQpwpeGC3
 FLTy+s/FOKJD3jv1T64i2CaJsfjT4WNLCGylvQEYZJKgl5ZsHFpwPFCSXp90hUnGx+00
 qTuTmZPYXODxszLJ2f8+QJmEFv9uOfisplYBZTZuLHhUAebJ0ghVostNF1l56bxLhiFC
 plxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790756763; x=1791361563;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=KmQZ+OOZqUF31Y1kxuFiuWhDcIOBLD8TKDlvk/LiPms=;
 b=C7nx5H0Yg+Q7SPccLbGeJo80oEnyMhVOH8A5vV76psABGQu9zePAFWmnCZWNaYyp/o
 HDvQUZKWBbffmv0QXab7ikvkYb5EEgxfNuDvnL1KIxXmj/N3eRnWfDG9+WXew/Ges4wx
 WKR8g+iD4zgNfS26Mo7l+sWeVBF7d1opID4V5ThM5nQkntA2ZLEQDjTVvvS4dh4WytpF
 yr60g+gRExEZI7KqAiRGDK/asOo/hYbODyZ1nwtJ4cHZevUArnZbbM8nEUv3Z58N+P7A
 Wk02tywCNIefFyNg8QnQtkK7YQfWmVZ5q5+ECDXj3yngofktRKCnV4nGi9+JlmVnwzuw
 dS4A==
X-Gm-Message-State: AFuF++kIT/HP7eK/VWK+2T3xxtT8hNDXE8dzkaUtLfSpR5Ejz0gS+CzN
 3H3LFKnpFeuTyIvqT6juKO7xm+WfuROF6jLPNeinJZkCqRbcJEhC/3wPB/fIBD9873kC+Io19dO
 LeDD8cNXqC474Ma5CuM7dmqjRtk4MRtsrA4kq2A7qBB/oqygyCX7rOTViY8tfE+YIpoIK
X-Gm-Gg: AYBFou084HLphUd8RuSJAVPr7t7D6r7kb7dYqnjju3dNsOKLm9LVzgI3fZEfeSqrYAu
 e36oaONO6e/sWaDxDNT9Fl1LBdmzBBfZUMyohRuBZB4y+UwvXBdUBm1bvrMf7KfUhpf0iGAK5JP
 2ivEytlSQdoCLOTAf6WAAIJbhuXOY8ewoRfg40fpvZnBvg9udtoap6HjpssvyoaE/ZuYwcpGRao
 bLOABNHLvGMPsve1P6KrmumSjHe4ZiGq1Bp6Im2Z/2ixbV3/nBMl+2E4gE1NR7tZuXUgEcfnJNl
 A8PofEvcIeRoD0tScjOb2hvvFE1la3n3btfowhEFYjQswxgGwHU2+0dlC1/PkkadxQrafd27Zxm
 1zNCgNYbeldicdlW0i2qVCSyrTIcMo/cO7ef4J4qC8U6XVcgCT3pCBR5iZ5WRZJq5pmHs/j6L65
 sOxrMnm/pw4MCT6HmFj8JaCK+JYu2AIf5VxJw3/tvAzjpsaiBnz6mGiywK8oLC6S8YoVLv9HapC
 V5UrD3axfRIpBhJNzqRPraBWH6oHfRcisLo4vU+Ukd7BOa8mbV+vaztlVN9lfyIKBZpDaQ1bHbR
 Wzk41jVcJE4QfSKarlKL62TUv1o83/EfyJhfpS1gf1p/sUeJF6PAiOJY2PkY
X-Received: by 2002:a05:600c:c162:b0:49f:ff32:8044 with SMTP id
 5b1f17b1804b1-4a01addecdfmr9423895e9.7.1790756762786; 
 Wed, 30 Sep 2026 01:26:02 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a015df7c36sm28124745e9.3.2026.09.30.01.26.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 01:26:02 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 30 Sep 2026 08:25:29 +0000
To: ralf_lici <ralf@mandelbit.com>,
	plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 32
X-Gerrit-Change-Id: I00208610e0ce4f3ed9a87233e68ece1b3b8a768a
X-Gerrit-Change-Number: 1751
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1751?usp=email>
X-Gerrit-Commit: 82b0c70d333ab84dc85e40f4e387c0fb199bda38
In-Reply-To: <gerrit.1782719911000.I00208610e0ce4f3ed9a87233e68ece1b3b8a768a@gerrit.openvpn.net>
References: <gerrit.1782719911000.I00208610e0ce4f3ed9a87233e68ece1b3b8a768a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkwMDIwODYxMGUwY2U0ZjNlZDlhODcyMzNlNjhlY2UxYjNiOGE3NjhhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <325c0dd6e2a0ad839be5d2ae714814a3721009b0-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBpdh-0006kA-Iw
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
Content-Type: multipart/mixed; boundary="===============7775639815373670499=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7775639815373670499==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="O1vkyXnFuas="; charset=UTF-8

--O1vkyXnFuas=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici, stipa=2E

Hello=
 plaisthos, ralf_lici, 

I'd like you to reexamine a change=2E Please visit=


    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1751?usp=3Demail

to look a=
t the new patch set (#32)=2E


Change subject: oob: Probe every resolved ad=
dress of a remote
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

oob: Probe every resolved address of a remote

A remote can resolve to=
 several A/AAAA records; --server-probe sent a
probe request only to the fi=
rst one, so a remote whose first address was
unreachable looked unresponsiv=
e even if another address answered, and
the connection could later try an a=
ddress that was never probed=2E

Probe every resolved address of each remot=
e in parallel, accept a reply
from any of them (first reply for a remote wi=
ns), and resend to all of
a remote's addresses while it is unanswered=2E An=
 address shared by
several entries is still probed once per round=2E

The a=
ddresses of one remote are taken to be the same service,
advertising the sa=
me priority, weight and margin; the first of them to
answer speaks for the =
remote, with the round-trip time of the probe it
answers=2E

Change-Id: I00=
208610e0ce4f3ed9a87233e68ece1b3b8a768a
Signed-off-by: Lev Stipakov <lev@ope=
nvpn=2Enet>
---
M doc/man-sections/client-options=2Erst
M src/openvpn/oob=
=2Ec
M src/openvpn/oob=2Eh
M src/openvpn/oob_client=2Ec
M tests/unit_tests/=
openvpn/test_oob=2Ec
5 files changed, 160 insertions(+), 58 deletions(-)


=
  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/51/1751/=
32

diff --git a/doc/man-sections/client-options=2Erst b/doc/man-sections/c=
lient-options=2Erst
index f1f004f=2E=2E7749f37 100644
--- a/doc/man-section=
s/client-options=2Erst
+++ b/doc/man-sections/client-options=2Erst
@@ -604,=
7 +604,7 @@
      server-probe
      server-probe max-latency-diff
 
-  A s=
mall probe message is sent to the first resolved address of every UDP
+  A =
small probe message is sent to every resolved address of every UDP
   remot=
e, and each answering server replies with its advertised priority
   and we=
ight=2E Remotes are then reordered following DNS SRV (RFC 2782)
   semantic=
s: servers that answered are tried before those that did not,
@@ -620,6 +62=
0,10 @@
   priority group a candidate, since replies only arrive within the=

   one-second probe window; the group is then ordered by weight alone=2E
 =

+  The addresses of one remote are expected to be the same service and to
=
+  advertise the same values; the first of them to answer speaks for the
+ =
 remote=2E
+
   The probe carries the same control-channel wrapping as a no=
rmal
   connection (``--tls-auth`` or ``--tls-crypt``, when configured)=2E =
With
   ``--tls-crypt-v2`` the remotes are left in their configured order,
=
diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec
index 704be6e=2E=2Ea=
7cfcd9 100644
--- a/src/openvpn/oob=2Ec
+++ b/src/openvpn/oob=2Ec
@@ -125,9=
 +125,16 @@
 {
     for (int i =3D start; i < n; i++)
     {
-        if (t=
argets[i]=2Esent && !results[i]=2Eresponded && addr_port_match(from, &targe=
ts[i]=2Edest))
+        if (!targets[i]=2Esent || results[i]=2Eresponded)
 =
        {
-            return i;
+            continue;
+        }
+       =
 for (int k =3D 0; k < targets[i]=2En_dests; k++)
+        {
+            i=
f (addr_port_match(from, &targets[i]=2Edests[k]))
+            {
+         =
       return i;
+            }
         }
     }
     return -1;
diff --gi=
t a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh
index 5821a1d=2E=2Ed5cc1a2 10=
0644
--- a/src/openvpn/oob=2Eh
+++ b/src/openvpn/oob=2Eh
@@ -166,12 +166,13=
 @@
     struct oob_probe_reply reply; /* the values the server advertised =
*/
 };
 
-/* Where the client probed one connection entry=2E */
+/* Where t=
he client probed one connection entry: its resolved addresses=2E */
 struct=
 oob_probe_target
 {
-    struct openvpn_sockaddr dest;
-    socklen_t dest=
len;
-    bool sent;
+    struct openvpn_sockaddr *dests;
+    socklen_t *d=
estlens;
+    int n_dests;
+    bool sent; /* at least one address was prob=
ed */
 };
 
 /* One probe request transmission=2E Its request_id is a per-r=
un random base plus
diff --git a/src/openvpn/oob_client=2Ec b/src/openvpn/o=
ob_client=2Ec
index 2ac3faa=2E=2E2c8b6e8 100644
--- a/src/openvpn/oob_clien=
t=2Ec
+++ b/src/openvpn/oob_client=2Ec
@@ -364,6 +364,55 @@
     }
 }
 
+/*=
 Does any address of t have a probe socket of its family? */
+static bool
+=
oob_probe_target_reachable(const struct probe_ctx *pc, const struct oob_pro=
be_target *t)
+{
+    for (int k =3D 0; k < t->n_dests; k++)
+    {
+      =
  if (pc->sd[probe_af_index(t->dests[k]=2Eaddr=2Esa=2Esa_family)] !=3D SOCK=
ET_UNDEFINED)
+        {
+            return true;
+        }
+    }
+    r=
eturn false;
+}
+
+/* Send a probe to every resolved address of t, each on =
the socket matching
+ * its address family=2E An address an earlier entry a=
lready probed in this round
+ * is not probed again; that probe's reply cov=
ers this entry too=2E Returns true
+ * if at least one address was sent to =
or is already covered=2E */
+static bool
+oob_probe_send_target(struct prob=
e_ctx *pc, struct oob_probe_target *t)
+{
+    bool any_sent =3D false;
+  =
  for (int k =3D 0; k < t->n_dests; k++)
+    {
+        const int af =3D p=
robe_af_index(t->dests[k]=2Eaddr=2Esa=2Esa_family);
+        socket_descrip=
tor_t sd =3D pc->sd[af];
+        if (sd =3D=3D SOCKET_UNDEFINED)
+        =
{
+            continue;
+        }
+#ifdef TARGET_ANDROID
+        /* Keep=
 the probe out of an active tunnel, as the connection socket is=2E
+       =
  * protect_fd_nonlocal() declines a local peer, so only a non-local one
+ =
        * actually protects the socket and may latch the flag=2E */
+      =
  if (!pc->fd_protected[af] && !addr_local(&t->dests[k]=2Eaddr=2Esa))
+    =
    {
+            protect_fd_nonlocal(sd, &t->dests[k]=2Eaddr=2Esa);
+    =
        pc->fd_protected[af] =3D true;
+        }
+#endif
+        if (oob_=
probe_sent_this_round(pc, &t->dests[k])
+            || oob_probe_send_to(p=
c, sd, &t->dests[k], t->destlens[k]))
+        {
+            any_sent =3D =
true;
+        }
+    }
+    return any_sent;
+}
+
 /* Parse one received d=
atagram as a probe reply and, if valid and answering one
  * of the probes =
we sent, record the reply in results=2E */
 static void
@@ -412,9 +461,10 @=
@
         return; /* answers no probe we sent to that address */
     }
 
=
-    /* Credit the reply to every still-unanswered remote probed at its sou=
rce
-     * address: several entries can resolve to the same address, and e=
ach takes
-     * the first reply for it=2E */
+    /* Credit the reply to =
every still-unanswered remote that was probed at its
+     * source address=
: several entries can resolve to the same address, and each
+     * takes t=
he first reply for it=2E (A remote with several addresses may answer
+     =
* from more than one; the first one wins=2E) */
     int i =3D oob_probe_ne=
xt_target_at(from, targets, results, n, 0);
     while (i >=3D 0)
     {
@@=
 -506,23 +556,18 @@
 
 /* Resend the probe to every remote that we probed b=
ut that has not answered=2E */
 static void
-oob_probe_resend_unanswered(st=
ruct probe_ctx *pc, const struct oob_probe_target *targets,
+oob_probe_rese=
nd_unanswered(struct probe_ctx *pc, struct oob_probe_target *targets,
     =
                        const struct oob_probe_result *results, int n)
 {
-=
    /* a new round: probe each unanswered address once again, with a new
- =
    * request_id */
+    /* A new round: every unanswered address is probed=
 once more, with a new
+     * request_id=2E A late reply to an earlier rou=
nd still counts, with the RTT
+     * of the transmission it answers=2E */
=
     pc->round_start =3D pc->n_sends;
     for (int i =3D 0; i < n; i++)
  =
   {
-        if (!targets[i]=2Esent || results[i]=2Eresponded
-           =
 || oob_probe_sent_this_round(pc, &targets[i]=2Edest))
+        if (targets=
[i]=2Esent && !results[i]=2Eresponded)
         {
-            continue;
- =
       }
-        socket_descriptor_t sd =3D pc->sd[probe_af_index(targets[=
i]=2Edest=2Eaddr=2Esa=2Esa_family)];
-        if (sd !=3D SOCKET_UNDEFINED)=

-        {
-            oob_probe_send_to(pc, sd, &targets[i]=2Edest, targ=
ets[i]=2Edestlen);
+            oob_probe_send_target(pc, &targets[i]);
   =
      }
     }
 }
@@ -533,7 +578,7 @@
  * each slice but the last we resend=
 to whoever has not answered yet=2E Returns
  * once the window elapses or =
every sent probe has been answered=2E */
 static void
-oob_probe_collect(st=
ruct probe_ctx *pc, const struct oob_probe_target *targets,
+oob_probe_coll=
ect(struct probe_ctx *pc, struct oob_probe_target *targets,
               =
    struct oob_probe_result *results, int n, const struct signal_info *sig)=

 {
     /* number of probes we actually sent: stop early once they all ans=
wer */
@@ -707,11 +752,23 @@
             continue;
         }
 
-        /=
* Store the first resolved address natively (no IPv4-mapping); it is
-     =
    * later probed on its family's socket=2E */
-        memcpy(&targets[i]=
=2Edest, ai->ai_addr, ai->ai_addrlen);
-        targets[i]=2Edestlen =3D (s=
ocklen_t)ai->ai_addrlen;
-        need_af[probe_af_index(ai->ai_family)] =
=3D true;
+        /* Store every resolved address natively (no IPv4-mappin=
g); each is later
+         * probed on its family's socket=2E */
+        =
struct oob_probe_target *t =3D &targets[i];
+        int n_addr =3D 0;
+   =
     for (const struct addrinfo *a =3D ai; a; a =3D a->ai_next)
+        {
=
+            n_addr++;
+        }
+        t->dests =3D gc_malloc(sizeof(*t=
->dests) * n_addr, true, &gc);
+        t->destlens =3D gc_malloc(sizeof(*t=
->destlens) * n_addr, true, &gc);
+        for (const struct addrinfo *a =
=3D ai; a; a =3D a->ai_next)
+        {
+            memcpy(&t->dests[t->n_=
dests], a->ai_addr, a->ai_addrlen);
+            t->destlens[t->n_dests] =
=3D (socklen_t)a->ai_addrlen;
+            t->n_dests++;
+            need_=
af[probe_af_index(a->ai_family)] =3D true;
+        }
         freeaddrinfo=
(ai);
     }
 
@@ -728,43 +785,32 @@
         return;
     }
 
-    /* Send=
 a probe to each resolved remote, on the socket of its address family=2E
- =
    * An address several entries resolve to is probed once per round; its r=
eply is
-     * credited to each of them=2E */
-    pc=2Emax_sends =3D l->l=
en * (1 + OOB_PROBE_RETRIES); /* each round probes an address once */
+    =
/* Send a probe to each resolved remote, on the socket of each address=2E *=
/
+    int n_addrs =3D 0;
+    for (int i =3D 0; i < l->len; i++)
+    {
+ =
       n_addrs +=3D targets[i]=2En_dests;
+    }
+    /* Each round probes =
every address at most once=2E */
+    pc=2Emax_sends =3D n_addrs * (1 + OOB=
_PROBE_RETRIES);
     pc=2Esends =3D gc_malloc(sizeof(*pc=2Esends) * pc=2Em=
ax_sends, true, &gc);
 
     int sent_count =3D 0;
     for (int i =3D 0; i=
 < l->len; i++)
     {
         const struct connection_entry *ce =3D l->ar=
ray[i];
-        if (!targets[i]=2Edestlen)
+        struct oob_probe_targe=
t *t =3D &targets[i];
+        if (t->n_dests =3D=3D 0 || !oob_probe_target=
_reachable(&pc, t))
         {
-            continue;
+            continue=
; /* nothing resolved, or its family is not probed */
         }
-        c=
onst int af =3D probe_af_index(targets[i]=2Edest=2Eaddr=2Esa=2Esa_family);
=
-        socket_descriptor_t sd =3D pc=2Esd[af];
-        if (sd =3D=3D SOC=
KET_UNDEFINED)
-        {
-            continue; /* family not probed, see =
oob_probe_sockets_open() */
-        }
-#ifdef TARGET_ANDROID
-        /* K=
eep the probe out of an active tunnel, as the connection socket is=2E
-    =
     * protect_fd_nonlocal() declines a local peer, so only a non-local one=

-         * actually protects the socket and may latch the flag=2E */
-   =
     if (!pc=2Efd_protected[af] && !addr_local(&targets[i]=2Edest=2Eaddr=2E=
sa))
-        {
-            protect_fd_nonlocal(sd, &targets[i]=2Edest=2Ea=
ddr=2Esa);
-            pc=2Efd_protected[af] =3D true;
-        }
-#endif
=
-        if (!oob_probe_sent_this_round(&pc, &targets[i]=2Edest)
-         =
   && !oob_probe_send_to(&pc, sd, &targets[i]=2Edest, targets[i]=2Edestlen)=
)
+
+        if (!oob_probe_send_target(&pc, t))
         {
             ms=
g(D_LOW, "server-probe: %s:%s: probe send failed", ce->remote, ce->remote_p=
ort);
             continue;
         }
-        targets[i]=2Esent =3D true=
;
+        t->sent =3D true;
         sent_count++;
     }
 
diff --git a/t=
ests/unit_tests/openvpn/test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2E=
c
index 221d1f0=2E=2E0597541 100644
--- a/tests/unit_tests/openvpn/test_oob=
=2Ec
+++ b/tests/unit_tests/openvpn/test_oob=2Ec
@@ -537,10 +537,12 @@
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
@@ -549,7 +551,7 @@
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
@@ -573,9 +57=
5,9 @@
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
 
@@ -586,6 +588,21 @=
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
 /* T=
he RTT of a reply is measured from the transmission its request_id names (a=
s
  * an index into the transmissions), which must have gone to the address=
 the
  * reply came from=2E */
@@ -618,6 +635,31 @@
     assert_int_equal(o=
ob_probe_rtt_ms(sends, 3, 2, &a, &rcv), 0);
 }
 
+/* IPv6 addresses match o=
n address and port too=2E */
+static void
+test_probe_addresses_ipv6(void *=
*state)
+{
+    struct openvpn_sockaddr a =3D { 0 }, b =3D { 0 };
+    a=2E=
addr=2Ein6=2Esin6_family =3D AF_INET6;
+    a=2Eaddr=2Ein6=2Esin6_addr=2Es6=
_addr[15] =3D 1; /* ::1 */
+    a=2Eaddr=2Ein6=2Esin6_port =3D htons(1194);=

+    b =3D a;
+    b=2Eaddr=2Ein6=2Esin6_port =3D htons(1195);
+    sockle=
n_t len =3D sizeof(struct sockaddr_in6);
+    struct oob_probe_target targe=
ts[1] =3D {
+        { =2Edests =3D &a, =2Edestlens =3D &len, =2En_dests =
=3D 1, =2Esent =3D true },
+    };
+    struct oob_probe_result results[1] =
=3D { 0 };
+
+    assert_int_equal(oob_probe_next_target_at(&a, targets, re=
sults, 1, 0), 0);
+    assert_int_equal(oob_probe_next_target_at(&b, target=
s, results, 1, 0), -1);
+
+    const struct oob_probe_send sends[1] =3D { {=
 =2Edest =3D a } };
+    const struct timeval rcv =3D { 0 };
+    assert_in=
t_equal(oob_probe_rtt_ms(sends, 1, 0, &a, &rcv), 0);
+    assert_int_equal(=
oob_probe_rtt_ms(sends, 1, 0, &b, &rcv), -1);
+}
+
 /* A payload of just a =
probe reply is found by the client scan, with all
  * fields surviving=2E *=
/
 static void
@@ -1006,7 +1048,9 @@
         cmocka_unit_test(test_probe_r=
equest_check_no_request),
         cmocka_unit_test(test_probe_reply_credit=
s_every_entry_at_address),
         cmocka_unit_test(test_probe_reply_match=
es_only_its_address),
+        cmocka_unit_test(test_probe_reply_matches_an=
y_address_of_entry),
         cmocka_unit_test(test_probe_rtt_from_answered=
_send),
+        cmocka_unit_test(test_probe_addresses_ipv6),
         cmoc=
ka_unit_test(test_probe_reply_find),
         cmocka_unit_test(test_probe_r=
eply_find_skips_unknown),
         cmocka_unit_test(test_probe_reply_find_r=
ejects_unknown_mandatory),

-- 
To view, visit http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1751?usp=3Demail
To unsubscribe, or for help writing mail fil=
ters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mess=
ageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-C=
hange-Id: I00208610e0ce4f3ed9a87233e68ece1b3b8a768a
Gerrit-Change-Number: 1=
751
Gerrit-PatchSet: 32
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-=
Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici=
 <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esou=
rceforge=2Enet>
Gerrit-Attention: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-A=
ttention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Attention: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>

--O1vkyXnFuas=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici, stipa=2E </p>
<p>stipa <strong>=
uploaded patch set #32</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1751?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">oob: Probe every resolved address of a remote<br><br>A remote can=
 resolve to several A/AAAA records; --server-probe sent a<br>probe request =
only to the first one, so a remote whose first address was<br>unreachable l=
ooked unresponsive even if another address answered, and<br>the connection =
could later try an address that was never probed=2E<br><br>Probe every reso=
lved address of each remote in parallel, accept a reply<br>from any of them=
 (first reply for a remote wins), and resend to all of<br>a remote&#39;s ad=
dresses while it is unanswered=2E An address shared by<br>several entries i=
s still probed once per round=2E<br><br>The addresses of one remote are tak=
en to be the same service,<br>advertising the same priority, weight and mar=
gin; the first of them to<br>answer speaks for the remote, with the round-t=
rip time of the probe it<br>answers=2E<br><br>Change-Id: I00208610e0ce4f3ed=
9a87233e68ece1b3b8a768a<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Ene=
t&gt;<br>---<br>M doc/man-sections/client-options=2Erst<br>M src/openvpn/oo=
b=2Ec<br>M src/openvpn/oob=2Eh<br>M src/openvpn/oob_client=2Ec<br>M tests/u=
nit_tests/openvpn/test_oob=2Ec<br>5 files changed, 160 insertions(+), 58 de=
letions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet=
:29418/openvpn refs/changes/51/1751/32</pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;"><span>diff --git a/doc/man-section=
s/client-options=2Erst b/doc/man-sections/client-options=2Erst</span><br><s=
pan>index f1f004f=2E=2E7749f37 100644</span><br><span>--- a/doc/man-section=
s/client-options=2Erst</span><br><span>+++ b/doc/man-sections/client-option=
s=2Erst</span><br><span>@@ -604,7 +604,7 @@</span><br><span>      server-pr=
obe</span><br><span>      server-probe max-latency-diff</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-  A small probe message=
 is sent to the first resolved address of every UDP</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  A small probe message is sent to every =
resolved address of every UDP</span><br><span>   remote, and each answering=
 server replies with its advertised priority</span><br><span>   and weight=
=2E Remotes are then reordered following DNS SRV (RFC 2782)</span><br><span=
>   semantics: servers that answered are tried before those that did not,</=
span><br><span>@@ -620,6 +620,10 @@</span><br><span>   priority group a can=
didate, since replies only arrive within the</span><br><span>   one-second =
probe window; the group is then ordered by weight alone=2E</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+  The addresses of=
 one remote are expected to be the same service and to</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  advertise the same values; the first o=
f them to answer speaks for the</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  remote=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span>   The probe carries the same control-channel wrapping=
 as a normal</span><br><span>   connection (``--tls-auth`` or ``--tls-crypt=
``, when configured)=2E With</span><br><span>   ``--tls-crypt-v2`` the remo=
tes are left in their configured order,</span><br><span>diff --git a/src/op=
envpn/oob=2Ec b/src/openvpn/oob=2Ec</span><br><span>index 704be6e=2E=2Ea7cf=
cd9 100644</span><br><span>--- a/src/openvpn/oob=2Ec</span><br><span>+++ b/=
src/openvpn/oob=2Ec</span><br><span>@@ -125,9 +125,16 @@</span><br><span> {=
</span><br><span>     for (int i =3D start; i &lt; n; i++)</span><br><span>=
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (tar=
gets[i]=2Esent &amp;&amp; !results[i]=2Eresponded &amp;&amp; addr_port_matc=
h(from, &amp;targets[i]=2Edest))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        if (!targets[i]=2Esent || results[i]=2Eresponded)</spa=
n><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            return i;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            continue;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   for (int k =3D 0; k &lt; targets[i]=2En_dests; k++)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            if (addr_port_match(from, &amp;targets=
[i]=2Edests[k]))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       return i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         }</span><br><span>         }</span><br><span>     }</span><br><spa=
n>     return -1;</span><br><span>diff --git a/src/openvpn/oob=2Eh b/src/op=
envpn/oob=2Eh</span><br><span>index 5821a1d=2E=2Ed5cc1a2 100644</span><br><=
span>--- a/src/openvpn/oob=2Eh</span><br><span>+++ b/src/openvpn/oob=2Eh</s=
pan><br><span>@@ -166,12 +166,13 @@</span><br><span>     struct oob_probe_r=
eply reply; /* the values the server advertised */</span><br><span> };</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Where=
 the client probed one connection entry=2E */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/* Where the client probed one connection entry: =
its resolved addresses=2E */</span><br><span> struct oob_probe_target</span=
><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    stru=
ct openvpn_sockaddr dest;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    socklen_t destlen;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    bool sent;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct openvpn_sockaddr *dests;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    socklen_t *destlens;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    int n_dests;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    bool sent; /* at least one address was probed */</spa=
n><br><span> };</span><br><span> </span><br><span> /* One probe request tra=
nsmission=2E Its request_id is a per-run random base plus</span><br><span>d=
iff --git a/src/openvpn/oob_client=2Ec b/src/openvpn/oob_client=2Ec</span><=
br><span>index 2ac3faa=2E=2E2c8b6e8 100644</span><br><span>--- a/src/openvp=
n/oob_client=2Ec</span><br><span>+++ b/src/openvpn/oob_client=2Ec</span><br=
><span>@@ -364,6 +364,55 @@</span><br><span>     }</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Does=
 any address of t have a probe socket of its family? */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+oob_probe_target_reachable(const struct probe_c=
tx *pc, const struct oob_probe_target *t)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    for (int k =3D 0; k &lt; t-&gt;n_dests; k++)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (pc-&gt;sd[probe_af_index(t-&gt;dests[k]=2Ea=
ddr=2Esa=2Esa_family)] !=3D SOCKET_UNDEFINED)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            return true;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* Send a probe to every resolved address=
 of t, each on the socket matching</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * its address family=2E An address an earlier entry already=
 probed in this round</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * is not probed again; that probe&#39;s reply covers this entry too=2E R=
eturns true</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * if at=
 least one address was sent to or is already covered=2E */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+oob_probe_send_target(struct probe_ctx *pc, =
struct oob_probe_target *t)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool a=
ny_sent =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   for (int k =3D 0; k &lt; t-&gt;n_dests; k++)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        const int af =3D probe_af_index(t-&gt;dests[k]=2Eaddr=
=2Esa=2Esa_family);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        socket_descriptor_t sd =3D pc-&gt;sd[af];</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (sd =3D=3D SOCKET_UNDEFINED)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            continue;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifdef TARGET_ANDROID</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        /* Keep the probe out of an act=
ive tunnel, as the connection socket is=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+         * protect_fd_nonlocal() declines a local pe=
er, so only a non-local one</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+         * actually protects the socket and may latch the flag=2E *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!pc-&g=
t;fd_protected[af] &amp;&amp; !addr_local(&amp;t-&gt;dests[k]=2Eaddr=2Esa))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            protect_fd_nonloc=
al(sd, &amp;t-&gt;dests[k]=2Eaddr=2Esa);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            pc-&gt;fd_protected[af] =3D true;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if (oob_probe_sent_this_round(pc, &amp;t-&g=
t;dests[k])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    || oob_probe_send_to(pc, sd, &amp;t-&gt;dests[k], t-&gt;destlens[k]))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            any_sent =3D true;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    return any_sent;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> /* Parse one received datagram as a probe=
 reply and, if valid and answering one</span><br><span>  * of the probes we=
 sent, record the reply in results=2E */</span><br><span> static void</span=
><br><span>@@ -412,9 +461,10 @@</span><br><span>         return; /* answers=
 no probe we sent to that address */</span><br><span>     }</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Credit the r=
eply to every still-unanswered remote probed at its source</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-     * address: several entries can re=
solve to the same address, and each takes</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-     * the first reply for it=2E */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* Credit the reply to every still-=
unanswered remote that was probed at its</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * source address: several entries can resolve to =
the same address, and each</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+     * takes the first reply for it=2E (A remote with several addres=
ses may answer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
* from more than one; the first one wins=2E) */</span><br><span>     int i =
=3D oob_probe_next_target_at(from, targets, results, n, 0);</span><br><span=
>     while (i &gt;=3D 0)</span><br><span>     {</span><br><span>@@ -506,23=
 +556,18 @@</span><br><span> </span><br><span> /* Resend the probe to every=
 remote that we probed but that has not answered=2E */</span><br><span> sta=
tic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-oob_probe_res=
end_unanswered(struct probe_ctx *pc, const struct oob_probe_target *targets=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_resend_u=
nanswered(struct probe_ctx *pc, struct oob_probe_target *targets,</span><br=
><span>                             const struct oob_probe_result *results,=
 int n)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    /* a new round: probe each unanswered address once again, with a n=
ew</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * request_id *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* A new round=
: every unanswered address is probed once more, with a new</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     * request_id=2E A late reply to=
 an earlier round still counts, with the RTT</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * of the transmission it answers=2E */</span>=
<br><span>     pc-&gt;round_start =3D pc-&gt;n_sends;</span><br><span>     =
for (int i =3D 0; i &lt; n; i++)</span><br><span>     {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        if (!targets[i]=2Esent || results=
[i]=2Eresponded</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      || oob_probe_sent_this_round(pc, &amp;targets[i]=2Edest))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (targets[i]=2Esent &=
amp;&amp; !results[i]=2Eresponded)</span><br><span>         {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            continue;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        socket_descriptor_t sd =3D pc-&gt;sd[pr=
obe_af_index(targets[i]=2Edest=2Eaddr=2Esa=2Esa_family)];</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        if (sd !=3D SOCKET_UNDEFINED)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            oob_probe_send_to(pc, s=
d, &amp;targets[i]=2Edest, targets[i]=2Edestlen);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            oob_probe_send_target(pc, &amp;ta=
rgets[i]);</span><br><span>         }</span><br><span>     }</span><br><spa=
n> }</span><br><span>@@ -533,7 +578,7 @@</span><br><span>  * each slice but=
 the last we resend to whoever has not answered yet=2E Returns</span><br><s=
pan>  * once the window elapses or every sent probe has been answered=2E */=
</span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-oob_probe_collect(struct probe_ctx *pc, const struct oob_probe_targ=
et *targets,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_pro=
be_collect(struct probe_ctx *pc, struct oob_probe_target *targets,</span><b=
r><span>                   struct oob_probe_result *results, int n, const s=
truct signal_info *sig)</span><br><span> {</span><br><span>     /* number o=
f probes we actually sent: stop early once they all answer */</span><br><sp=
an>@@ -707,11 +752,23 @@</span><br><span>             continue;</span><br><=
span>         }</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        /* Store the first resolved address natively (no IPv4-m=
apping); it is</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
  * later probed on its family&#39;s socket=2E */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        memcpy(&amp;targets[i]=2Edest, ai-&gt;a=
i_addr, ai-&gt;ai_addrlen);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        targets[i]=2Edestlen =3D (socklen_t)ai-&gt;ai_addrlen;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        need_af[probe_af_ind=
ex(ai-&gt;ai_family)] =3D true;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        /* Store every resolved address natively (no IPv4-mappi=
ng); each is later</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
        * probed on its family&#39;s socket=2E */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        struct oob_probe_target *t =3D &amp;t=
argets[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
nt n_addr =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     for (const struct addrinfo *a =3D ai; a; a =3D a-&gt;ai_next)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            n_addr++;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        t-&gt;dests =3D gc_malloc(sizeof(*t-&g=
t;dests) * n_addr, true, &amp;gc);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        t-&gt;destlens =3D gc_malloc(sizeof(*t-&gt;destlens)=
 * n_addr, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        for (const struct addrinfo *a =3D ai; a; a =3D a-&gt;ai_next=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            memcpy(&amp;t-&g=
t;dests[t-&gt;n_dests], a-&gt;ai_addr, a-&gt;ai_addrlen);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            t-&gt;destlens[t-&gt;n_de=
sts] =3D (socklen_t)a-&gt;ai_addrlen;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            t-&gt;n_dests++;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            need_af[probe_af_index(a-&gt;ai_fami=
ly)] =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   }</span><br><span>         freeaddrinfo(ai);</span><br><span>     }</spa=
n><br><span> </span><br><span>@@ -728,43 +785,32 @@</span><br><span>       =
  return;</span><br><span>     }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    /* Send a probe to each resolved remote, o=
n the socket of its address family=2E</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-     * An address several entries resolve to is probed once=
 per round; its reply is</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-     * credited to each of them=2E */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    pc=2Emax_sends =3D l-&gt;len * (1 + OOB_PROBE_RETRIE=
S); /* each round probes an address once */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* Send a probe to each resolved remote, on the=
 socket of each address=2E */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    int n_addrs =3D 0;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    for (int i =3D 0; i &lt; l-&gt;len; i++)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        n_addrs +=3D targets[i]=2En_dests;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Each round probes every address at=
 most once=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 pc=2Emax_sends =3D n_addrs * (1 + OOB_PROBE_RETRIES);</span><br><span>    =
 pc=2Esends =3D gc_malloc(sizeof(*pc=2Esends) * pc=2Emax_sends, true, &amp;=
gc);</span><br><span> </span><br><span>     int sent_count =3D 0;</span><br=
><span>     for (int i =3D 0; i &lt; l-&gt;len; i++)</span><br><span>     {=
</span><br><span>         const struct connection_entry *ce =3D l-&gt;array=
[i];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!targ=
ets[i]=2Edestlen)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      struct oob_probe_target *t =3D &amp;targets[i];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (t-&gt;n_dests =3D=3D 0 || !oo=
b_probe_target_reachable(&amp;pc, t))</span><br><span>         {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            continue;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            continue; /* nothi=
ng resolved, or its family is not probed */</span><br><span>         }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        const int af =3D p=
robe_af_index(targets[i]=2Edest=2Eaddr=2Esa=2Esa_family);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        socket_descriptor_t sd =3D pc=
=2Esd[af];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if =
(sd =3D=3D SOCKET_UNDEFINED)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       continue; /* family not probed, see oob_probe_sockets_open() */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#ifdef TARGET_ANDROID</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        /* Keep the probe out of an ac=
tive tunnel, as the connection socket is=2E</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-         * protect_fd_nonlocal() declines a local pee=
r, so only a non-local one</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-         * actually protects the socket and may latch the flag=2E */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!pc=2Efd_pr=
otected[af] &amp;&amp; !addr_local(&amp;targets[i]=2Edest=2Eaddr=2Esa))</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            protect_fd_nonlocal(sd, &=
amp;targets[i]=2Edest=2Eaddr=2Esa);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            pc=2Efd_protected[af] =3D true;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        if (!oob_probe_sent_this_round(&amp;pc, &amp;targets[i]=2E=
dest)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            &amp=
;&amp; !oob_probe_send_to(&amp;pc, sd, &amp;targets[i]=2Edest, targets[i]=
=2Edestlen))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!oob_probe_sen=
d_target(&amp;pc, t))</span><br><span>         {</span><br><span>          =
   msg(D_LOW, &quot;server-probe: %s:%s: probe send failed&quot;, ce-&gt;re=
mote, ce-&gt;remote_port);</span><br><span>             continue;</span><br=
><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    targets[i]=2Esent =3D true;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        t-&gt;sent =3D true;</span><br><span>         sent_coun=
t++;</span><br><span>     }</span><br><span> </span><br><span>diff --git a/=
tests/unit_tests/openvpn/test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=
=2Ec</span><br><span>index 221d1f0=2E=2E0597541 100644</span><br><span>--- =
a/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>+++ b/tests/unit_te=
sts/openvpn/test_oob=2Ec</span><br><span>@@ -537,10 +537,12 @@</span><br><s=
pan>     return sa;</span><br><span> }</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/* One probed address per entry=2E */<=
/span><br><span> static struct oob_probe_target</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-probe_target(struct openvpn_sockaddr dest, bool s=
ent)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+probe_target(st=
ruct openvpn_sockaddr *dest, bool sent)</span><br><span> {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    return (struct oob_probe_target){ =
=2Edest =3D dest, =2Edestlen =3D sizeof(dest=2Eaddr=2Ein4), =2Esent =3D sen=
t };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    static sock=
len_t len =3D sizeof(struct sockaddr_in);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    return (struct oob_probe_target){ =2Edests =3D de=
st, =2Edestlens =3D &amp;len, =2En_dests =3D 1, =2Esent =3D sent };</span><=
br><span> }</span><br><span> </span><br><span> /* Two entries resolve to th=
e same address=2E The first reply from it is</span><br><span>@@ -549,7 +551=
,7 @@</span><br><span> test_probe_reply_credits_every_entry_at_address(void=
 **state)</span><br><span> {</span><br><span>     struct openvpn_sockaddr a=
 =3D v4_addr(0x7f000001, 1194);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    struct oob_probe_target targets[2] =3D { probe_target(a, true=
), probe_target(a, true) };</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct oob_probe_target targets[2] =3D { probe_target(&amp;a, t=
rue), probe_target(&amp;a, true) };</span><br><span>     struct oob_probe_r=
esult results[2] =3D { 0 };</span><br><span> </span><br><span>     int i =
=3D oob_probe_next_target_at(&amp;a, targets, results, 2, 0);</span><br><sp=
an>@@ -573,9 +575,9 @@</span><br><span>     struct openvpn_sockaddr b =3D v=
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
_result results[3] =3D { 0 };</span><br><span> </span><br><span>@@ -586,6 +=
588,21 @@</span><br><span>     assert_int_equal(oob_probe_next_target_at(&a=
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
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* The RTT=
 of a reply is measured from the transmission its request_id names (as</spa=
n><br><span>  * an index into the transmissions), which must have gone to t=
he address the</span><br><span>  * reply came from=2E */</span><br><span>@@=
 -618,6 +635,31 @@</span><br><span>     assert_int_equal(oob_probe_rtt_ms(s=
ends, 3, 2, &amp;a, &amp;rcv), 0);</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/* IPv6 addresses match=
 on address and port too=2E */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+test_probe_addresses_ipv6(void **state)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct openvpn_sockaddr a =3D { 0 }, b =3D { 0 };</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    a=2Eaddr=2Ein6=2Esin6_family =3D=
 AF_INET6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=2Ea=
ddr=2Ein6=2Esin6_addr=2Es6_addr[15] =3D 1; /* ::1 */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    a=2Eaddr=2Ein6=2Esin6_port =3D htons(=
1194);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    b =3D a;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    b=2Eaddr=2Ein6=
=2Esin6_port =3D htons(1195);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    socklen_t len =3D sizeof(struct sockaddr_in6);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_target target=
s[1] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
 =2Edests =3D &amp;a, =2Edestlens =3D &amp;len, =2En_dests =3D 1, =2Esent =
=3D true },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_=
result results[1] =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_int_equal(oob_probe_next_target_at(&amp;a, targets, results, 1, 0), 0);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(o=
ob_probe_next_target_at(&amp;b, targets, results, 1, 0), -1);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    const struct oob_probe_send sends[1] =3D { { =2E=
dest =3D a } };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
const struct timeval rcv =3D { 0 };</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_int_equal(oob_probe_rtt_ms(sends, 1, 0, &amp;a, =
&amp;rcv), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_int_equal(oob_probe_rtt_ms(sends, 1, 0, &amp;b, &amp;rcv), -1);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* A payload of just a =
probe reply is found by the client scan, with all</span><br><span>  * field=
s surviving=2E */</span><br><span> static void</span><br><span>@@ -1006,7 +=
1048,9 @@</span><br><span>         cmocka_unit_test(test_probe_request_chec=
k_no_request),</span><br><span>         cmocka_unit_test(test_probe_reply_c=
redits_every_entry_at_address),</span><br><span>         cmocka_unit_test(t=
est_probe_reply_matches_only_its_address),</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        cmocka_unit_test(test_probe_reply_matches_an=
y_address_of_entry),</span><br><span>         cmocka_unit_test(test_probe_r=
tt_from_answered_send),</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        cmocka_unit_test(test_probe_addresses_ipv6),</span><br><span>  =
       cmocka_unit_test(test_probe_reply_find),</span><br><span>         cm=
ocka_unit_test(test_probe_reply_find_skips_unknown),</span><br><span>      =
   cmocka_unit_test(test_probe_reply_find_rejects_unknown_mandatory),</span=
><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1751?usp=3Demail">change 1751</a>=2E To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2E=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1751?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType:=
 newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </=
div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I00208610e0ce4f3ed9a87233e68ece1b3b8a7=
68a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1751 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 32 </div>
<div style=3D"displa=
y:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;r=
alf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: open=
vpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@=
gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plais=
thos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--O1vkyXnFuas=--


--===============7775639815373670499==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7775639815373670499==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7775639815373670499==--

