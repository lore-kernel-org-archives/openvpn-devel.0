Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68444C88E7B
	for <openvpn-devel@archiver.kernel.org>; Mon, 14 Sep 2026 14:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SCcoJh+uW8ODMLxMOonLb3hiwjekycpZz+O3YF+GTns=; b=lJ9Wm5kk0DbJEAzQJk0Kv3inlk
	/iPpnDr8Z0UWF4S2ZEuZM8pyoKDpyBWO+GhU6WAWimY1nq3PuLwyOA0bDX80w4IZWNSp8lxqJfdMu
	FPapuqKJ0s+gZSpsM9rTfrLBUCGszwl2cnLntg/N86IC0Pq7gyjKQnePiLwRIwkjS21Q=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x67Wa-0008Ok-19;
	Mon, 14 Sep 2026 14:19:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x67WY-0008OK-Ch
 for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 14:19:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=JoiUFWSxRzS6CRNpNfnNywwbOuHu6kDAqy2PaOnatUE=; b=UUqM6tWWvfFCy7Ghxm/y4+ZJGc
 3+2IwfwVVtjls4casQKpjyMOQGZ2vBXKRmqfOtECpBIKJW03auawNnAUtK3r3G8PBxHe6xPIH20uI
 S7TYt8Wtyljjt5Sfs2HPELq/ZwBYLZRWLS7tWpW2C8/Z8d79KJ1XWSwy8tTW03KliZWQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=JoiUFWSxRzS6CRNpNfnNywwbOuHu6kDAqy2PaOnatUE=; b=C
 XOw2Ny1kF3rMARBjNGxfDBUxQYIOuhc+L/18Ech78eHrUjJ/5l3ac0bFrHqjcw5ERCogzF/N1QcRt
 2Sbf2FsICLbwFzYiegjbQUofpiMJU2jy/2vZ6U5HQt5H2bsSn1HtlEhz6NiU+pCGYV4D9QR9MkJ9F
 PB6GSqTymc8C8F9I=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x67WO-0006eU-0N for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 14:19:11 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912e2406so8563965e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 14 Sep 2026 07:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789395533; x=1790000333; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JoiUFWSxRzS6CRNpNfnNywwbOuHu6kDAqy2PaOnatUE=;
 b=C/NHsJYBr8ijewGiFumjWuIIiI+LtN3f5HJMacJP/3uqXyA8HHSaAOyuElAyx7+uvo
 Ipejo8/50jE4P+UEdXtS/7Gp8VEIP6b5xCTqL1p6IzrbhE8s/mHr9ncLTaSggnENyLCK
 2pnEQE7NqWgrmbd0j2j3D7fPNDgsIv6NgDozH8+bj7hf3NFxz21GoXhb4UY4cvP2Iquy
 ejVwOJyJ7r4Ydmf24X17pnjh0w8IiuyYr3NE34bYXiAnhx1a4FRXdaGgX7zB0vqJChSJ
 bZ2y3Vh/rKIlzCfVwQGdCVjz4nYFzUJVKGN7mqH39tBJhRy6nHBdcQLiTJ0nGt6j/41P
 q7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789395533; x=1790000333;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=JoiUFWSxRzS6CRNpNfnNywwbOuHu6kDAqy2PaOnatUE=;
 b=U8v9Cyl5d6NpJzLdi3DA6JSIWsq2hIRNF9D1phERcWSmIFXMHiyuNaMtFwyruI84fj
 RrVAD4gYW3UDSvGGIic1OdhIxDxKD7zf0JzdavZK2P6O7CqhsOqMobgP+Rwlu8caqqcu
 hSAfOMGJTRPjltchdXsYM0YdZEybN/JkkoWxzbZc56JePzsMaXj07QJjn90omHBSzkcp
 qHMnM9J8TxSOb8RkYbrkceNkzxl3dq8FyVkvPQ0ApEIDvwPvyceRZm/1EMgsEnFtMzj/
 t2IPRt/nBE9v3KTgOeKCGAyoQbKQl2jeGwprdqA1/K1ehqG7mu7PS/wxRJpwnYHStynH
 7Nog==
X-Gm-Message-State: AFuF++mouIh7UdXCbGAfCgbhnp6ATrGLCoepvmTHfyxrLC1fuIonKZqX
 DctlEMaSwZFzl87mAebndjs5NB7Nad/LxtAs6pvzrUrlvD61fOeACWrnVrCOkTJQWkhrPIb+BeL
 NWJRAF/z6SVQPaz+nphuOVcRN/zNN8qZTzhzYv1zShI8nizwfteuMNT1OMwhlMYUeG1UO
X-Gm-Gg: AYBFou1oRXY301mEPr15/SwE3xsIeHZVdvJr2CLt2foVKiw/w9ARBAOH6ETpGAPmUat
 QKM/4Iqv8d7KUDmabzJXDSXjM/wxrj2FIlHWQy9KOsFbsojzz6yPaGnduqJ7w7jwbsKJaMbpMyq
 a/qV+ohbv7OI9qAMNcJC8RoOZJvTO8yEviK3W67g7bpnWBzO/NhzneqbUTk3OofuQdTmS4JUzgi
 CcW7cAcoc0P3sdxIL+vT9uLuzWZPQ80AwaGTA8o1NzUIrmSfwIecL5c7eh+msDy6MqaKKYTv3T/
 /VEKccPMESH4TeyDB3mthev+LrFtJnrYp7xbLbEA0Sfe4q00zx51p2GIbadDrC0/N/9zA2xtuTj
 fiGT+YABHQyJpNaFMJLawsAoDL0EdZYLApvQhie2tDsxovw18intnbZjiTAthzKE4r6Q5wFVxmd
 SoQDdmkpaBXARIzIOMMg2QZd+czYro9FdNykR50hl1yLkGFZCHjx4os5E+lD3OUxdOQBbtuYhLD
 bfFFMAKSi3fbCbKtSY/dBt+u3l2oKOXie76qB7UMMaTBk6YvZKTfN+1L9RxXOnz45n0SYncxKDe
 vK5ZJ9kS8f7PJf4KD23rtdQgd0xGNtauLzhjcL99XRRi79fYDPEGeRP3BGHIaZY=
X-Received: by 2002:a05:600c:4709:b0:49d:257c:a735 with SMTP id
 5b1f17b1804b1-49e7a67860amr35217985e9.11.1789395533179; 
 Mon, 14 Sep 2026 07:18:53 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e69f053b7sm241394575e9.9.2026.09.14.07.18.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 07:18:52 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 14 Sep 2026 14:18:32 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 22
X-Gerrit-Change-Id: I00208610e0ce4f3ed9a87233e68ece1b3b8a768a
X-Gerrit-Change-Number: 1751
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1751?usp=email>
X-Gerrit-Commit: fe6c39058c9404a28a90736e2878cbd5605ec497
In-Reply-To: <gerrit.1782719911000.I00208610e0ce4f3ed9a87233e68ece1b3b8a768a@gerrit.openvpn.net>
References: <gerrit.1782719911000.I00208610e0ce4f3ed9a87233e68ece1b3b8a768a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkwMDIwODYxMGUwY2U0ZjNlZDlhODcyMzNlNjhlY2UxYjNiOGE3NjhhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0433fdb99cf9b15bb22e66d9dfa9762568f6e7dd-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x67WO-0006eU-0N
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
 openvpn-devel@lists.sourceforge.net
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2926189113155502600=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2926189113155502600==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hOeQOt9FvX4="; charset=UTF-8

--hOeQOt9FvX4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1751?usp=3Demail

to look at the new patch set (#22)=2E
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
5 files changed, 178 insertions(+), 83 deletions(-)


  git pull ssh:/=
/gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/51/1751/22

diff --git a=
/doc/man-sections/client-options=2Erst b/doc/man-sections/client-options=2E=
rst
index 8b6bb2f=2E=2E84a9f51 100644
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
index 20b3a4f=2E=2E7855b71 100644
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
index ebdcd3f=2E=2Ee76745d 100644
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

     struct timeval sent_at; /* when the first probe went out, for the RTT=
 */
 };
diff --git a/src/openvpn/oob_client=2Ec b/src/openvpn/oob_client=2E=
c
index c3e2e2b=2E=2E871b5d9 100644
--- a/src/openvpn/oob_client=2Ec
+++ b/=
src/openvpn/oob_client=2Ec
@@ -321,6 +321,83 @@
     }
 }
 
+/* Does any ad=
dress of t have a probe socket of its family? */
+static bool
+oob_probe_ta=
rget_reachable(const struct probe_ctx *pc, const struct oob_probe_target *t=
)
+{
+    for (int k =3D 0; k < t->n_dests; k++)
+    {
+        if (pc->sd=
[probe_af_index(t->dests[k]=2Eaddr=2Esa=2Esa_family)] !=3D SOCKET_UNDEFINED=
)
+        {
+            return true;
+        }
+    }
+    return false;=

+}
+
+/* Send the probe to every resolved address of t, each on the socket=
 matching
+ * its address family, recording when the first one went out so =
the reply's RTT
+ * is measured from there=2E An address an earlier entry a=
lready probed in this
+ * round is not probed again; that probe's reply cov=
ers this entry too=2E Returns
+ * true if at least one address was sent to =
or is already covered=2E */
+static bool
+oob_probe_send_target(struct prob=
e_ctx *pc, const struct buffer *probe, struct oob_probe_target *t)
+{
+    =
bool any_sent =3D false;
+    /* The RTT runs from the first send=2E A repl=
y carries nothing that ties it to
+     * a send round, so measuring from a=
 resend would report a server slower
+     * than one round as fast=2E */
+=
    bool stamped =3D t->sent;
+    for (int k =3D 0; k < t->n_dests; k++)
+=
    {
+        const int af =3D probe_af_index(t->dests[k]=2Eaddr=2Esa=2Esa=
_family);
+        socket_descriptor_t sd =3D pc->sd[af];
+        if (sd =
=3D=3D SOCKET_UNDEFINED)
+        {
+            continue;
+        }
+#ifd=
ef TARGET_ANDROID
+        /* Keep the probe out of an active tunnel, as th=
e connection socket is=2E
+         * protect_fd_nonlocal() declines a loca=
l peer, so only a non-local one
+         * actually protects the socket an=
d may latch the flag=2E */
+        if (!pc->fd_protected[af] && !addr_loca=
l(&t->dests[k]=2Eaddr=2Esa))
+        {
+            protect_fd_nonlocal(sd=
, &t->dests[k]=2Eaddr=2Esa);
+            pc->fd_protected[af] =3D true;
+ =
       }
+#endif
+        const int seen =3D oob_addr_list_find(pc->probed,=
 pc->n_probed, &t->dests[k]);
+        if (seen >=3D 0)
+        {
+       =
     /* Already probed this round by an earlier entry: share that send
+   =
          * time, so both entries report the same RTT for the one reply=2E =
*/
+            if (!stamped)
+            {
+                t->sent_at =
=3D pc->probed_at[seen];
+                stamped =3D true;
+            }
=
+            any_sent =3D true;
+            continue;
+        }
+        =
struct timeval sent_at;
+        openvpn_gettimeofday(&sent_at, NULL);
+   =
     if (sendto(sd, (const char *)CBPTR(probe), (int)BLEN(probe), 0,
+     =
              (const struct sockaddr *)&t->dests[k], t->destlens[k])
+     =
       >=3D 0)
+        {
+            if (!stamped)
+            {
+      =
          t->sent_at =3D sent_at;
+                stamped =3D true;
+     =
       }
+            pc->probed_at[pc->n_probed] =3D sent_at;
+           =
 pc->probed[pc->n_probed++] =3D t->dests[k];
+            any_sent =3D true=
;
+        }
+    }
+    return any_sent;
+}
+
 /* Parse one received datag=
ram as a PROBE_REPLY and, if valid and matching one
  * of the probes we se=
nt, record the reply in results=2E */
 static void
@@ -363,9 +440,10 @@
   =
      return;
     }
 
-    /* Credit the reply to every still-unanswered r=
emote probed at its source
-     * address: several entries can resolve to =
the same address, and each takes
-     * the first reply for it=2E */
+    =
/* Credit the reply to every still-unanswered remote that was probed at its=

+     * source address: several entries can resolve to the same address, a=
nd each
+     * takes the first reply for it=2E (A remote with several addr=
esses may answer
+     * from more than one; the first one wins=2E) */
    =
 struct timeval rcv;
     openvpn_gettimeofday(&rcv, NULL);
     int i =3D =
oob_probe_next_target_at(from, targets, results, n, 0);
@@ -474,27 +552,9 @=
@
     pc->n_probed =3D 0;
     for (int i =3D 0; i < n; i++)
     {
-     =
   if (!targets[i]=2Esent || results[i]=2Eresponded)
+        if (targets[i=
]=2Esent && !results[i]=2Eresponded)
         {
-            continue;
-   =
     }
-        if (oob_addr_list_find(pc->probed, pc->n_probed, &targets[i=
]=2Edest) >=3D 0)
-        {
-            continue;
-        }
-        soc=
ket_descriptor_t sd =3D pc->sd[probe_af_index(targets[i]=2Edest=2Eaddr=2Esa=
=2Esa_family)];
-        if (sd =3D=3D SOCKET_UNDEFINED)
-        {
-      =
      continue;
-        }
-        struct timeval sent_at;
-        openvp=
n_gettimeofday(&sent_at, NULL);
-        if (sendto(sd, (const char *)CBPTR=
(probe), (int)BLEN(probe), 0,
-                   (const struct sockaddr *)=
&targets[i]=2Edest, targets[i]=2Edestlen)
-            >=3D 0)
-        {
-=
            pc->probed_at[pc->n_probed] =3D sent_at;
-            pc->probe=
d[pc->n_probed++] =3D targets[i]=2Edest;
+            oob_probe_send_target=
(pc, probe, &targets[i]);
         }
     }
 }
@@ -700,11 +760,23 @@
      =
       continue;
         }
 
-        /* Store the first resolved address =
natively (no IPv4-mapping); it is
-         * later probed on its family's =
socket=2E */
-        memcpy(&targets[i]=2Edest, ai->ai_addr, ai->ai_addrle=
n);
-        targets[i]=2Edestlen =3D (socklen_t)ai->ai_addrlen;
-        n=
eed_af[probe_af_index(ai->ai_family)] =3D true;
+        /* Store every res=
olved address natively (no IPv4-mapping); each is later
+         * probed =
on its family's socket=2E */
+        struct oob_probe_target *t =3D &targe=
ts[i];
+        int n_addr =3D 0;
+        for (const struct addrinfo *a =
=3D ai; a; a =3D a->ai_next)
+        {
+            n_addr++;
+        }
+=
        t->dests =3D gc_malloc(sizeof(*t->dests) * n_addr, true, &gc);
+   =
     t->destlens =3D gc_malloc(sizeof(*t->destlens) * n_addr, true, &gc);
+=
        for (const struct addrinfo *a =3D ai; a; a =3D a->ai_next)
+       =
 {
+            memcpy(&t->dests[t->n_dests], a->ai_addr, a->ai_addrlen);
+=
            t->destlens[t->n_dests] =3D (socklen_t)a->ai_addrlen;
+        =
    t->n_dests++;
+            need_af[probe_af_index(a->ai_family)] =3D tr=
ue;
+        }
         freeaddrinfo(ai);
     }
 
@@ -721,58 +793,32 @@
  =
       return;
     }
 
-    /* Send a probe to each resolved remote, on th=
e socket of its address family=2E
-     * An address several entries resolv=
e to is probed once; its reply is
-     * credited to each of them=2E */
- =
   pc=2Eprobed =3D gc_malloc(sizeof(*pc=2Eprobed) * l->len, false, &gc);
- =
   pc=2Eprobed_at =3D gc_malloc(sizeof(*pc=2Eprobed_at) * l->len, false, &g=
c);
+    /* Send a probe to each resolved remote, on the socket of each add=
ress=2E */
+    int n_addrs =3D 0;
+    for (int i =3D 0; i < l->len; i++)
=
+    {
+        n_addrs +=3D targets[i]=2En_dests;
+    }
+    pc=2Eprobed =
=3D gc_malloc(sizeof(*pc=2Eprobed) * n_addrs, false, &gc);
+    pc=2Eprobed=
_at =3D gc_malloc(sizeof(*pc=2Eprobed_at) * n_addrs, false, &gc);
     pc=
=2En_probed =3D 0;
 
     int sent_count =3D 0;
     for (int i =3D 0; i < =
l->len; i++)
     {
         const struct connection_entry *ce =3D l->array=
[i];
-        if (!targets[i]=2Edestlen)
+        struct oob_probe_target *=
t =3D &targets[i];
+        if (t->n_dests =3D=3D 0 || !oob_probe_target_re=
achable(&pc, t))
         {
+            continue; /* nothing resolved, or =
its family is not probed */
+        }
+
+        if (!oob_probe_send_targe=
t(&pc, &probe, t))
+        {
+            msg(D_LOW, "server-probe: %s:%s:=
 probe send failed", ce->remote, ce->remote_port);
             continue;
 =
        }
-        const int af =3D probe_af_index(targets[i]=2Edest=2Eaddr=
=2Esa=2Esa_family);
-        socket_descriptor_t sd =3D pc=2Esd[af];
-     =
   if (sd =3D=3D SOCKET_UNDEFINED)
-        {
-            continue; /* fam=
ily not probed, see oob_probe_sockets_open() */
-        }
-#ifdef TARGET_A=
NDROID
-        /* Keep the probe out of an active tunnel, as the connectio=
n socket is=2E
-         * protect_fd_nonlocal() declines a local peer, so =
only a non-local one
-         * actually protects the socket and may latch=
 the flag=2E */
-        if (!pc=2Efd_protected[af] && !addr_local(&targets=
[i]=2Edest=2Eaddr=2Esa))
-        {
-            protect_fd_nonlocal(sd, &t=
argets[i]=2Edest=2Eaddr=2Esa);
-            pc=2Efd_protected[af] =3D true;=

-        }
-#endif
-        const int seen =3D oob_addr_list_find(pc=2Epro=
bed, pc=2En_probed, &targets[i]=2Edest);
-        if (seen >=3D 0)
-       =
 {
-            /* Already probed this round by an earlier entry: reuse tha=
t send
-             * time, so both entries report the same RTT for the on=
e reply=2E */
-            targets[i]=2Esent_at =3D pc=2Eprobed_at[seen];
-=
        }
-        else
-        {
-            openvpn_gettimeofday(&targe=
ts[i]=2Esent_at, NULL);
-            if (sendto(sd, (const char *)BPTR(&pro=
be), (int)BLEN(&probe), 0,
-                       (struct sockaddr *)&targ=
ets[i]=2Edest, targets[i]=2Edestlen)
-                < 0)
-            {
-=
                msg(D_LOW, "server-probe: %s:%s: probe send failed", ce->re=
mote, ce->remote_port);
-                continue;
-            }
-        =
    pc=2Eprobed_at[pc=2En_probed] =3D targets[i]=2Esent_at;
-            pc=
=2Eprobed[pc=2En_probed++] =3D targets[i]=2Edest;
-        }
-        targe=
ts[i]=2Esent =3D true;
+        t->sent =3D true;
         sent_count++;
  =
   }
 
diff --git a/tests/unit_tests/openvpn/test_oob=2Ec b/tests/unit_test=
s/openvpn/test_oob=2Ec
index 6090d6e=2E=2E7092f94 100644
--- a/tests/unit_t=
ests/openvpn/test_oob=2Ec
+++ b/tests/unit_tests/openvpn/test_oob=2Ec
@@ -5=
18,10 +518,12 @@
     return sa;
 }
 
+/* One probed address per entry=2E *=
/
 static struct oob_probe_target
-probe_target(struct openvpn_sockaddr des=
t, bool sent)
+probe_target(struct openvpn_sockaddr *dest, bool sent)
 {
- =
   return (struct oob_probe_target){ =2Edest =3D dest, =2Edestlen =3D sizeo=
f(dest=2Eaddr=2Ein4), =2Esent =3D sent };
+    static socklen_t len =3D siz=
eof(struct sockaddr_in);
+    return (struct oob_probe_target){ =2Edests =
=3D dest, =2Edestlens =3D &len, =2En_dests =3D 1, =2Esent =3D sent };
 }
 
=
 /* Two entries resolving to the same address are both credited by one repl=
y,
@@ -530,7 +532,7 @@
 test_probe_reply_credits_every_entry_at_address(voi=
d **state)
 {
     struct openvpn_sockaddr a =3D v4_addr(0x7f000001, 1194);=

-    struct oob_probe_target targets[2] =3D { probe_target(a, true), probe=
_target(a, true) };
+    struct oob_probe_target targets[2] =3D { probe_tar=
get(&a, true), probe_target(&a, true) };
     struct oob_probe_result resul=
ts[2] =3D { 0 };
 
     int i =3D oob_probe_next_target_at(&a, targets, res=
ults, 2, 0);
@@ -554,9 +556,9 @@
     struct openvpn_sockaddr b =3D v4_addr=
(0x7f000002, 1194);
     struct openvpn_sockaddr a_other_port =3D v4_addr(0=
x7f000001, 1195);
     struct oob_probe_target targets[3] =3D {
-        pr=
obe_target(a, true),
-        probe_target(b, true),
-        probe_target(=
a, false), /* resolved but never sent */
+        probe_target(&a, true),
+=
        probe_target(&b, true),
+        probe_target(&a, false), /* resolv=
ed but never sent */
     };
     struct oob_probe_result results[3] =3D { =
0 };
 
@@ -567,6 +569,43 @@
     assert_int_equal(oob_probe_next_target_at(=
&a_other_port, targets, results, 3, 0), -1);
 }
 
+/* A remote with several=
 addresses is credited whichever of them answers=2E */
+static void
+test_p=
robe_reply_matches_any_address_of_entry(void **state)
+{
+    struct openvp=
n_sockaddr addrs[2] =3D { v4_addr(0x7f000001, 1194), v4_addr(0x7f000002, 11=
94) };
+    socklen_t lens[2] =3D { sizeof(struct sockaddr_in), sizeof(stru=
ct sockaddr_in) };
+    struct oob_probe_target targets[1] =3D {
+        {=
 =2Edests =3D addrs, =2Edestlens =3D lens, =2En_dests =3D 2, =2Esent =3D tr=
ue },
+    };
+    struct oob_probe_result results[1] =3D { 0 };
+
+    ass=
ert_int_equal(oob_probe_next_target_at(&addrs[1], targets, results, 1, 0), =
0);
+    assert_int_equal(oob_probe_next_target_at(&addrs[0], targets, resu=
lts, 1, 0), 0);
+}
+
+/* IPv6 addresses match on address and port too=2E */=

+static void
+test_probe_addresses_ipv6(void **state)
+{
+    struct openv=
pn_sockaddr a =3D { 0 }, b =3D { 0 };
+    a=2Eaddr=2Ein6=2Esin6_family =3D=
 AF_INET6;
+    a=2Eaddr=2Ein6=2Esin6_addr=2Es6_addr[15] =3D 1; /* ::1 */
+=
    a=2Eaddr=2Ein6=2Esin6_port =3D htons(1194);
+    b =3D a;
+    b=2Eaddr=
=2Ein6=2Esin6_port =3D htons(1195);
+    socklen_t len =3D sizeof(struct so=
ckaddr_in6);
+    struct oob_probe_target targets[1] =3D {
+        { =2Ede=
sts =3D &a, =2Edestlens =3D &len, =2En_dests =3D 1, =2Esent =3D true },
+  =
  };
+    struct oob_probe_result results[1] =3D { 0 };
+
+    assert_int_e=
qual(oob_probe_next_target_at(&a, targets, results, 1, 0), 0);
+    assert_=
int_equal(oob_probe_next_target_at(&b, targets, results, 1, 0), -1);
+    a=
ssert_int_equal(oob_addr_list_find(&a, 1, &a), 0);
+    assert_int_equal(oo=
b_addr_list_find(&a, 1, &b), -1);
+}
+
 /* The per-round list of probed add=
resses compares address and port=2E */
 static void
 test_addr_list_find(vo=
id **state)
@@ -972,6 +1011,8 @@
         cmocka_unit_test(test_server_prob=
e_accept_no_parameter),
         cmocka_unit_test(test_probe_reply_credits_=
every_entry_at_address),
         cmocka_unit_test(test_probe_reply_matches=
_only_its_address),
+        cmocka_unit_test(test_probe_reply_matches_any_=
address_of_entry),
+        cmocka_unit_test(test_probe_addresses_ipv6),
  =
       cmocka_unit_test(test_addr_list_find),
         cmocka_unit_test(tes=
t_client_reply_read_finds_reply),
         cmocka_unit_test(test_client_rep=
ly_read_skips_unknown),

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1751?usp=3Demail
To unsubscribe, or for help writing mail filter=
s, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chan=
ge-Id: I00208610e0ce4f3ed9a87233e68ece1b3b8a768a
Gerrit-Change-Number: 1751=

Gerrit-PatchSet: 22
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Rev=
iewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-ope=
nvpn@rfc2549=2Eorg>

--hOeQOt9FvX4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #22</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
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
nvpn/test_oob=2Ec<br>5 files changed, 178 insertions(+), 83 deletions(-)<br=
><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/51/1751/22</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/doc/man-sections/client-opti=
ons=2Erst b/doc/man-sections/client-options=2Erst</span><br><span>index 8b6=
bb2f=2E=2E84a9f51 100644</span><br><span>--- a/doc/man-sections/client-opti=
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
 20b3a4f=2E=2E7855b71 100644</span><br><span>--- a/src/openvpn/oob=2Ec</spa=
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
n/oob=2Eh b/src/openvpn/oob=2Eh</span><br><span>index ebdcd3f=2E=2Ee76745d =
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
e first probe went out, for the RTT */</span><br><span> };</span><br><span>=
diff --git a/src/openvpn/oob_client=2Ec b/src/openvpn/oob_client=2Ec</span>=
<br><span>index c3e2e2b=2E=2E871b5d9 100644</span><br><span>--- a/src/openv=
pn/oob_client=2Ec</span><br><span>+++ b/src/openvpn/oob_client=2Ec</span><b=
r><span>@@ -321,6 +321,83 @@</span><br><span>     }</span><br><span> }</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Doe=
s any address of t have a probe socket of its family? */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+oob_probe_target_reachable(const struct probe_=
ctx *pc, const struct oob_probe_target *t)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    for (int k =3D 0; k &lt; t-&gt;n_dests; k++)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (pc-&gt;sd[probe_af_index(t-&gt;dests[k]=2Ea=
ddr=2Esa=2Esa_family)] !=3D SOCKET_UNDEFINED)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            return true;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* Send the probe to every resolved addre=
ss of t, each on the socket matching</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * its address family, recording when the first one went o=
ut so the reply&#39;s RTT</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * is measured from there=2E An address an earlier entry already prob=
ed in this</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * round =
is not probed again; that probe&#39;s reply covers this entry too=2E Return=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * true if at leas=
t one address was sent to or is already covered=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+oob_probe_send_target(struct probe_ctx *pc, const=
 struct buffer *probe, struct oob_probe_target *t)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    bool any_sent =3D false;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* The RTT runs from the first send=2E A reply ca=
rries nothing that ties it to</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * a send round, so measuring from a resend would report a se=
rver slower</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * t=
han one round as fast=2E */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    bool stamped =3D t-&gt;sent;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    for (int k =3D 0; k &lt; t-&gt;n_dests; k++)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        const int af =3D probe_af_index=
(t-&gt;dests[k]=2Eaddr=2Esa=2Esa_family);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        socket_descriptor_t sd =3D pc-&gt;sd[af];</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (sd =3D=3D S=
OCKET_UNDEFINED)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            c=
ontinue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef TARGET_ANDROID=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Keep the=
 probe out of an active tunnel, as the connection socket is=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+         * protect_fd_nonlocal()=
 declines a local peer, so only a non-local one</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+         * actually protects the socket and may=
 latch the flag=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        if (!pc-&gt;fd_protected[af] &amp;&amp; !addr_local(&amp;t-&gt;de=
sts[k]=2Eaddr=2Esa))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   protect_fd_nonlocal(sd, &amp;t-&gt;dests[k]=2Eaddr=2Esa);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            pc-&gt;fd_protected[af=
] =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        const int seen =3D oob_=
addr_list_find(pc-&gt;probed, pc-&gt;n_probed, &amp;t-&gt;dests[k]);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (seen &gt;=3D 0=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            /* Already probe=
d this round by an earlier entry: share that send</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+             * time, so both entries report t=
he same RTT for the one reply=2E */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            if (!stamped)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                t-&gt;sent_at =3D pc-&gt;probed_at[seen];</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                stamp=
ed =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            a=
ny_sent =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          continue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        st=
ruct timeval sent_at;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        openvpn_gettimeofday(&amp;sent_at, NULL);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (sendto(sd, (const char *)CBPT=
R(probe), (int)BLEN(probe), 0,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                   (const struct sockaddr *)&amp;t-&gt;dests[k],=
 t-&gt;destlens[k])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            &gt;=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     if (!stamped)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         t-&gt;sent_at =3D sent_at;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                stamped =3D true;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            pc-&gt;probed_at[pc-&gt;n_probed] =3D s=
ent_at;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
pc-&gt;probed[pc-&gt;n_probed++] =3D t-&gt;dests[k];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            any_sent =3D true;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    return any_sent;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span> /* Parse one received datagram as a PROBE_REPLY and, =
if valid and matching one</span><br><span>  * of the probes we sent, record=
 the reply in results=2E */</span><br><span> static void</span><br><span>@@=
 -363,9 +440,10 @@</span><br><span>         return;</span><br><span>     }<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
/* Credit the reply to every still-unanswered remote probed at its source</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * address: several=
 entries can resolve to the same address, and each takes</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-     * the first reply for it=2E */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Credit the reply =
to every still-unanswered remote that was probed at its</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     * source address: several entries =
can resolve to the same address, and each</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     * takes the first reply for it=2E (A remote with=
 several addresses may answer</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * from more than one; the first one wins=2E) */</span><br><s=
pan>     struct timeval rcv;</span><br><span>     openvpn_gettimeofday(&amp=
;rcv, NULL);</span><br><span>     int i =3D oob_probe_next_target_at(from, =
targets, results, n, 0);</span><br><span>@@ -474,27 +552,9 @@</span><br><sp=
an>     pc-&gt;n_probed =3D 0;</span><br><span>     for (int i =3D 0; i &lt=
; n; i++)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        if (!targets[i]=2Esent || results[i]=2Eresponded)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (targets[i]=2Es=
ent &amp;&amp; !results[i]=2Eresponded)</span><br><span>         {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            continue;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        if (oob_addr_list_find(pc-&gt;prob=
ed, pc-&gt;n_probed, &amp;targets[i]=2Edest) &gt;=3D 0)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            continue;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        socket_descriptor_t sd =3D pc-&gt;sd[probe_af_index(targe=
ts[i]=2Edest=2Eaddr=2Esa=2Esa_family)];</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        if (sd =3D=3D SOCKET_UNDEFINED)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            continue;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        struct timeval sent_at;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        openvpn_gettimeofday(&amp;sent_at, NULL);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (sendto(sd, (c=
onst char *)CBPTR(probe), (int)BLEN(probe), 0,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                   (const struct sockaddr *)&amp;t=
argets[i]=2Edest, targets[i]=2Edestlen)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            &gt;=3D 0)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            pc-&gt;probed_at[pc-&gt;n_probed] =3D sent_at;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            pc-&gt;probed[pc-&g=
t;n_probed++] =3D targets[i]=2Edest;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            oob_probe_send_target(pc, probe, &amp;targets[=
i]);</span><br><span>         }</span><br><span>     }</span><br><span> }</=
span><br><span>@@ -700,11 +760,23 @@</span><br><span>             continue;=
</span><br><span>         }</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        /* Store the first resolved address nativel=
y (no IPv4-mapping); it is</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-         * later probed on its family&#39;s socket=2E */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        memcpy(&amp;targets[i]=2Ede=
st, ai-&gt;ai_addr, ai-&gt;ai_addrlen);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        targets[i]=2Edestlen =3D (socklen_t)ai-&gt;ai_add=
rlen;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        need_af[=
probe_af_index(ai-&gt;ai_family)] =3D true;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        /* Store every resolved address natively (n=
o IPv4-mapping); each is later</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+         * probed on its family&#39;s socket=2E */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        struct oob_probe_target *=
t =3D &amp;targets[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        int n_addr =3D 0;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        for (const struct addrinfo *a =3D ai; a; a =3D a-&gt;ai_ne=
xt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            n_addr++;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        t-&gt;dests =3D gc_malloc(=
sizeof(*t-&gt;dests) * n_addr, true, &amp;gc);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        t-&gt;destlens =3D gc_malloc(sizeof(*t-&=
gt;destlens) * n_addr, true, &amp;gc);</span><br><span style=3D"color: hsl(=
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
>     }</span><br><span> </span><br><span>@@ -721,58 +793,32 @@</span><br><=
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
unit_tests/openvpn/test_oob=2Ec</span><br><span>index 6090d6e=2E=2E7092f94 =
100644</span><br><span>--- a/tests/unit_tests/openvpn/test_oob=2Ec</span><b=
r><span>+++ b/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>@@ -518=
,10 +518,12 @@</span><br><span>     return sa;</span><br><span> }</span><br=
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
* Two entries resolving to the same address are both credited by one reply,=
</span><br><span>@@ -530,7 +532,7 @@</span><br><span> test_probe_reply_cred=
its_every_entry_at_address(void **state)</span><br><span> {</span><br><span=
>     struct openvpn_sockaddr a =3D v4_addr(0x7f000001, 1194);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    struct oob_probe_target target=
s[2] =3D { probe_target(a, true), probe_target(a, true) };</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_target targets[=
2] =3D { probe_target(&amp;a, true), probe_target(&amp;a, true) };</span><b=
r><span>     struct oob_probe_result results[2] =3D { 0 };</span><br><span>=
 </span><br><span>     int i =3D oob_probe_next_target_at(&amp;a, targets, =
results, 2, 0);</span><br><span>@@ -554,9 +556,9 @@</span><br><span>     st=
ruct openvpn_sockaddr b =3D v4_addr(0x7f000002, 1194);</span><br><span>    =
 struct openvpn_sockaddr a_other_port =3D v4_addr(0x7f000001, 1195);</span>=
<br><span>     struct oob_probe_target targets[3] =3D {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        probe_target(a, true),</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        probe_target(b, true),</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        probe_target(a,=
 false), /* resolved but never sent */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        probe_target(&amp;a, true),</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        probe_target(&amp;b, true),</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        probe_target(&am=
p;a, false), /* resolved but never sent */</span><br><span>     };</span><b=
r><span>     struct oob_probe_result results[3] =3D { 0 };</span><br><span>=
 </span><br><span>@@ -567,6 +569,43 @@</span><br><span>     assert_int_equa=
l(oob_probe_next_target_at(&amp;a_other_port, targets, results, 3, 0), -1);=
</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/* A remote with several addresses is credited whichever =
of them answers=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_p=
robe_reply_matches_any_address_of_entry(void **state)</span><br><span style=
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
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* IPv6 addresses =
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
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(oob_addr_li=
st_find(&amp;a, 1, &amp;a), 0);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_int_equal(oob_addr_list_find(&amp;a, 1, &amp;b), -1)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* The per-round l=
ist of probed addresses compares address and port=2E */</span><br><span> st=
atic void</span><br><span> test_addr_list_find(void **state)</span><br><spa=
n>@@ -972,6 +1011,8 @@</span><br><span>         cmocka_unit_test(test_serve=
r_probe_accept_no_parameter),</span><br><span>         cmocka_unit_test(tes=
t_probe_reply_credits_every_entry_at_address),</span><br><span>         cmo=
cka_unit_test(test_probe_reply_matches_only_its_address),</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_probe_r=
eply_matches_any_address_of_entry),</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        cmocka_unit_test(test_probe_addresses_ipv6),</span>=
<br><span>         cmocka_unit_test(test_addr_list_find),</span><br><span> =
        cmocka_unit_test(test_client_reply_read_finds_reply),</span><br><sp=
an>         cmocka_unit_test(test_client_reply_read_skips_unknown),</span><=
br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1751?usp=3Demail">change 1751</a>=2E To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1751?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ger=
rit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pro=
ject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Id: I00208610e0ce4f3ed9a8723=
3e68ece1b3b8a768a </div>
<div style=3D"display:none"> Gerrit-Change-Number:=
 1751 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 22 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn=
-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&=
gt; </div>

</body></html>
--hOeQOt9FvX4=--


--===============2926189113155502600==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2926189113155502600==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2926189113155502600==--

