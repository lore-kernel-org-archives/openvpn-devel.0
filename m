Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FFBC79FA1
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 08:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZhTNRHm0uXWSEEZu8zqEFW4cuEPjj/beReNu5J4tsiU=; b=nS/0mYRYzwqRmqS7qPL9E+9tiL
	y3NY+hG6G1O56xfmL9n5uU4U4F3VgeUz6boXqbfKflblqgRyUlWpTMdkDid/lfZsPuUBtsmULoEad
	PFbz9YJWxQVxLuwBIJq4ps69KCTVUJ4rRbENuHpPJ4JcGYLvUrC3gRyIlHA56sHAD7Ms=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4wSz-0006Ry-W7;
	Fri, 11 Sep 2026 08:18:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4wSy-0006Rq-Kf
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 08:18:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=qez8wqgdGMCmcYXiHGffVDrXIUHUuzgdTYOOkNddOow=; b=fa2m5Je/fS52T24kARbWnubN8k
 uxq5VQJ9/Cy9IL2jxbCWR7i5l0XPUmCNnC90EolW7lEZQo+WZ6NLrlVNDVhncg+/ATRODo+mOJ05P
 7cfvpHEUok4/YTBtc68aai1au6AbMd36ZvskZfN75wd+emb6uHIHNsydbUR4RbnEitU0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=qez8wqgdGMCmcYXiHGffVDrXIUHUuzgdTYOOkNddOow=; b=e
 rZgd4zBzUhBOg1DTxPWHf11iJybjtojSl4RFcJHTMDtbxXt0zU1uFHMgGcK94LCwVUgjUFF/zePRH
 fn0BOxAbEEl10NfqBGP0Okg3nyeoCyre1nKUau9uzZFqXweNVmM9/e5bMM3VFWxVhEDaNyEi7Wmmd
 1AxWRxotxVua17vg=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4wSw-000416-5k for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 08:18:37 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4998b5a63e2so7033875e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 01:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789114708; x=1789719508; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qez8wqgdGMCmcYXiHGffVDrXIUHUuzgdTYOOkNddOow=;
 b=QlED3gIRMmTZV/iDCTYf9lpJX24/wD7mk6DyGx1gfP6HGtSqR8tCmxW9KVuNnjPMU6
 aEzmqUO3qpuUcpYPKFgzWzmHywL6scnMbBrb7WoKzl+cuhDjMr/IBCBK7AgPauD+Hxka
 dZEnJa56mOHl5W4gC5lHAAeEWSZPOmfwS4S+EdGcBsKbayC8ZTGfh7GfkGOXOmw2MJp1
 04V6pHzWqjR0fFFzzAvnGzJ7jEwI/9/QrjLr1cvavwWF4cplcOfrTnrzvVr/zFzKif3h
 XlqUQmzpb2ZX9Y+fsBFPo3E2NXyB9f55nWEsf942SMEYc383R7uz6VinlJdsJkmyr19n
 zdTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789114708; x=1789719508;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qez8wqgdGMCmcYXiHGffVDrXIUHUuzgdTYOOkNddOow=;
 b=ofPNu1+b3gxN0/ycQFq7MNkdkgMGfF33a3AIeQCaUb5DMJvOaaFDwnBtFf4l7WbLk1
 9Zf1YSpt3B/s35M103eXT1Gu+gZmd71sfQlsR4GHYwBVT+Uk1KzYRzXLW2SfEsBazsHl
 8F7cljb7IUgOG0bCXHZEaO2rKelnP6yc+U5NGdyLibCPQxdbchkzRtSGzayjTi/5KEFm
 Ulj/2HCFuyuMXUW1WSmdM+LCRWcmbc+t5fOI4O+IlIdy9Lo1aczoK7+6oetNLUorlN0F
 CUKDsYPqrD70+rxQv0CK/E1y/bZ5Defb5Za5RZ/wrYfs3XQV0AKVl7ktJneerZ2PmdQR
 j1+g==
X-Gm-Message-State: AFuF++lgGJezyXmB/cMMuk77kOtokNFpRAYpcge3mJAftowMET6XQb/q
 em1iXkCz31FqceopCoTOixoZAWmDYV0ho0km5Hh1SA1qwiYUMJM8+kv4JVEY1lP2zW5XPcSimpH
 5HxC3dTlF/kr8hIs9UIN7XXrOQKm/0TwmbyEnGVfDnfXtnRgMvCleb1vM+kpLaumcEt/EHpYrB4
 RQTvVtcw==
X-Gm-Gg: AYBFou0Bl3wmE1bMrn3+ws+zIUD5pP40kM5kRkwi/u07/ST1UTC9nmFowzQFf66sx1r
 /pbJLTVomOC5nQwfNuDAnSRKXK0TqXggI4VVH9hfVB/T9YYRuhlOU4J2odkNuPmhMBpzabm7deT
 pYRqaP5yurKFwGHeOGlxpmVyUfj1TdEsFrGFtcYGZ7/f46N+EphvTEOedquPcTNm3yKhS+x5W7T
 Qih3BCQJRDBfA8ja0FKyjbefVmdNtz3h5dJDPjIPsYjX+BUcLpl+pWrFRWh7uNzG3zI8eg9vjB4
 kyY5KiNANhVdjdxrk0U/Q/7/ZUqmIiDAzag0uzfQtsEeC9MOp+ndaapgcwTu4H3Q5JwbBYz3Qd/
 NnN7btx0S6M0ewyb3UiGZKQs557gbW59kkBcrdoRE1KzT24fgrj0IB5x5lXPogBe9kz2j93bCox
 esN5l5Ig1Xqp89sSyEQV78SlxLdLbAXxvin3UgNpIMSSQaxAmLc8WcmIg9Lhep16S+fkqpQKuSD
 MLzDd8sMsBykI5NWmAj0O/D1GM3L1Rdm+/KOS7CqbabLRs9lD0IKPMw8EZwQhZE3U7mTfHVSxAm
 7eivdl5r97q4uagEMXyOvWC6woOBFZNsW5zIYYvkk5HOQJo3XLH7ptsSfF9DyQ==
X-Received: by 2002:a05:600c:1c21:b0:49e:663c:c69e with SMTP id
 5b1f17b1804b1-49e663cc8bamr6487095e9.24.1789114707289; 
 Fri, 11 Sep 2026 01:18:27 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26be3e35sm132308705e9.2.2026.09.11.01.18.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 01:18:26 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 08:18:16 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 18
X-Gerrit-Change-Id: I00208610e0ce4f3ed9a87233e68ece1b3b8a768a
X-Gerrit-Change-Number: 1751
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1751?usp=email>
X-Gerrit-Commit: 8c07239a84def15eec9f03a76d3ec4a8191e9822
In-Reply-To: <gerrit.1782719911000.I00208610e0ce4f3ed9a87233e68ece1b3b8a768a@gerrit.openvpn.net>
References: <gerrit.1782719911000.I00208610e0ce4f3ed9a87233e68ece1b3b8a768a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkwMDIwODYxMGUwY2U0ZjNlZDlhODcyMzNlNjhlY2UxYjNiOGE3NjhhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4fe50308820248ec895e958e5b6fcd61a65098aa-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4wSw-000416-5k
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
Content-Type: multipart/mixed; boundary="===============5540325175977174164=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5540325175977174164==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gtKRXCSxFn0="; charset=UTF-8

--gtKRXCSxFn0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1751?usp=3Demail

to look at the new patch set (#18)=2E
=


Change subject: oob: Probe every resolved address of a remote
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Probe every resol=
ved address of a remote

A remote can resolve to several A/AAAA records; --=
server-probe previously
sent a SERVER_PROBE only to the first one, so a rem=
ote whose first address
was unreachable looked unresponsive even if another=
 address answered, and
the connection could later try an address that was n=
ever probed=2E

Probe every resolved address of each remote in parallel (pe=
r-remote storage
is sized to the resolved address count, no fixed cap), acc=
ept a reply from
any of them (first reply for a remote wins), and resend to=
 all of a remote's
addresses while it is unanswered=2E

Change-Id: I0020861=
0e0ce4f3ed9a87233e68ece1b3b8a768a
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
5 files changed, 91 insertions(+), 52 deletions(-)


  git p=
ull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/51/1751/18

dif=
f --git a/doc/man-sections/client-options=2Erst b/doc/man-sections/client-o=
ptions=2Erst
index f582dc9=2E=2Ecf9883f 100644
--- a/doc/man-sections/clien=
t-options=2Erst
+++ b/doc/man-sections/client-options=2Erst
@@ -604,7 +604,=
7 @@
      server-probe
      server-probe max-latency-diff
 
-  A small pr=
obe message is sent to the first resolved address of every UDP
+  A small p=
robe message is sent to every resolved address of every UDP
   remote, and =
each answering server replies with its advertised priority
   and weight=2E=
 Remotes are then reordered following DNS SRV (RFC 2782)
   semantics: serv=
ers that answered are tried before those that did not,
diff --git a/src/ope=
nvpn/oob=2Ec b/src/openvpn/oob=2Ec
index 344f370=2E=2E2835c73 100644
--- a/=
src/openvpn/oob=2Ec
+++ b/src/openvpn/oob=2Ec
@@ -154,9 +154,16 @@
 {
     =
for (int i =3D start; i < n; i++)
     {
-        if (targets[i]=2Esent && =
!results[i]=2Eresponded && addr_port_match(from, &targets[i]=2Edest))
+    =
    if (!targets[i]=2Esent || results[i]=2Eresponded)
         {
-         =
   return i;
+            continue;
+        }
+        for (int k =3D 0; k=
 < targets[i]=2En_dests; k++)
+        {
+            if (addr_port_match(f=
rom, &targets[i]=2Edests[k]))
+            {
+                return i;
+  =
          }
         }
     }
     return -1;
diff --git a/src/openvpn/oob=
=2Eh b/src/openvpn/oob=2Eh
index af0670a=2E=2E27ae02a 100644
--- a/src/open=
vpn/oob=2Eh
+++ b/src/openvpn/oob=2Eh
@@ -190,11 +190,12 @@
     struct oob=
_probe_reply reply; /* the values the server advertised */
 };
 
-/* Where =
the client probed one connection entry=2E */
+/* Where the client probed on=
e connection entry: its resolved addresses=2E */
 struct oob_probe_target
 =
{
-    struct openvpn_sockaddr dest;
-    socklen_t destlen;
+    struct op=
envpn_sockaddr *dests;
+    socklen_t *destlens;
+    int n_dests;
     boo=
l sent;
     struct timeval sent_at; /* when the probe was sent, for RTT me=
asurement */
 };
diff --git a/src/openvpn/oob_client=2Ec b/src/openvpn/oob_=
client=2Ec
index 07e13a0=2E=2E878c904 100644
--- a/src/openvpn/oob_client=
=2Ec
+++ b/src/openvpn/oob_client=2Ec
@@ -260,6 +260,37 @@
     }
 }
 
+/* =
Send the probe to every resolved address of t, each on the socket matching
=
+ * its address family=2E An address an earlier entry already probed in thi=
s round
+ * is not probed again; that probe's reply covers this entry too=
=2E Returns true
+ * if at least one address was sent to or is already cove=
red=2E */
+static bool
+oob_probe_send_target(struct probe_ctx *pc, const s=
truct buffer *probe, const struct oob_probe_target *t)
+{
+    bool any_sen=
t =3D false;
+    for (int k =3D 0; k < t->n_dests; k++)
+    {
+        so=
cket_descriptor_t sd =3D pc->sd[probe_af_index(t->dests[k]=2Eaddr=2Esa=2Esa=
_family)];
+        if (sd =3D=3D SOCKET_UNDEFINED)
+        {
+           =
 continue;
+        }
+        if (oob_addr_list_contains(pc->probed, pc->n=
_probed, &t->dests[k]))
+        {
+            any_sent =3D true;
+       =
     continue;
+        }
+        if (sendto(sd, (const char *)BPTR(probe)=
, (int)BLEN(probe), 0,
+                   (const struct sockaddr *)&t->des=
ts[k], t->destlens[k])
+            >=3D 0)
+        {
+            pc->pro=
bed[pc->n_probed++] =3D t->dests[k];
+            any_sent =3D true;
+     =
   }
+    }
+    return any_sent;
+}
+
 /* Parse one received datagram as a=
 PROBE_REPLY and, if valid and matching one
  * of the probes we sent, reco=
rd the reply in results=2E */
 static void
@@ -302,9 +333,10 @@
         re=
turn;
     }
 
-    /* Credit the reply to every still-unanswered remote pr=
obed at its source
-     * address: several entries can resolve to the same=
 address, and each takes
-     * the first reply for it=2E */
+    /* Credi=
t the reply to every still-unanswered remote that was probed at its
+     *=
 source address: several entries can resolve to the same address, and each
=
+     * takes the first reply for it=2E (A remote with several addresses ma=
y answer
+     * from more than one; the first one wins=2E) */
     struct =
timeval rcv;
     openvpn_gettimeofday(&rcv, NULL);
     int i =3D oob_prob=
e_next_target_at(from, targets, results, n, 0);
@@ -409,18 +441,9 @@
     p=
c->n_probed =3D 0; /* a new round: probe each unanswered address once again=
 */
     for (int i =3D 0; i < n; i++)
     {
-        if (!targets[i]=2Ese=
nt || results[i]=2Eresponded
-            || oob_addr_list_contains(pc->pro=
bed, pc->n_probed, &targets[i]=2Edest))
+        if (targets[i]=2Esent && !=
results[i]=2Eresponded)
         {
-            continue;
-        }
-     =
   socket_descriptor_t sd =3D pc->sd[probe_af_index(targets[i]=2Edest=2Eadd=
r=2Esa=2Esa_family)];
-        if (sd !=3D SOCKET_UNDEFINED
-            &&=
 sendto(sd, (const char *)BPTR(probe), (int)BLEN(probe), 0,
-              =
        (const struct sockaddr *)&targets[i]=2Edest, targets[i]=2Edestlen)
=
-                   >=3D 0)
-        {
-            pc->probed[pc->n_probed=
++] =3D targets[i]=2Edest;
+            oob_probe_send_target(pc, probe, &t=
argets[i]);
         }
     }
 }
@@ -607,11 +630,23 @@
             continu=
e;
         }
 
-        /* Store the first resolved address natively (no I=
Pv4-mapping); it is
-         * later probed on its family's socket=2E */
-=
        memcpy(&targets[i]=2Edest, ai->ai_addr, ai->ai_addrlen);
-        t=
argets[i]=2Edestlen =3D (socklen_t)ai->ai_addrlen;
-        need_af[probe_a=
f_index(ai->ai_family)] =3D true;
+        /* Store every resolved address =
natively (no IPv4-mapping); each is later
+         * probed on its family'=
s socket=2E */
+        struct oob_probe_target *t =3D &targets[i];
+      =
  int n_addr =3D 0;
+        for (const struct addrinfo *a =3D ai; a; a =3D=
 a->ai_next)
+        {
+            n_addr++;
+        }
+        t->dests=
 =3D gc_malloc(sizeof(*t->dests) * n_addr, true, &gc);
+        t->destlens=
 =3D gc_malloc(sizeof(*t->destlens) * n_addr, true, &gc);
+        for (con=
st struct addrinfo *a =3D ai; a; a =3D a->ai_next)
+        {
+            =
memcpy(&t->dests[t->n_dests], a->ai_addr, a->ai_addrlen);
+            t->d=
estlens[t->n_dests] =3D (socklen_t)a->ai_addrlen;
+            t->n_dests++=
;
+            need_af[probe_af_index(a->ai_family)] =3D true;
+        }
 =
        freeaddrinfo(ai);
     }
 
@@ -628,38 +663,32 @@
         return;
 =
    }
 
-    /* Send a probe to each resolved remote, on the socket of its =
address family=2E
-     * An address several entries resolve to is probed o=
nce; its reply is
-     * credited to each of them=2E */
-    pc=2Eprobed =
=3D gc_malloc(sizeof(*pc=2Eprobed) * l->len, false, &gc);
+    /* Send a pr=
obe to each resolved remote, on the socket of each address=2E */
+    int n=
_addrs =3D 0;
+    for (int i =3D 0; i < l->len; i++)
+    {
+        n_add=
rs +=3D targets[i]=2En_dests;
+    }
+    pc=2Eprobed =3D gc_malloc(sizeof(=
*pc=2Eprobed) * n_addrs, false, &gc);
     pc=2En_probed =3D 0;
 
     int =
sent_count =3D 0;
     for (int i =3D 0; i < l->len; i++)
     {
         c=
onst struct connection_entry *ce =3D l->array[i];
-        if (!targets[i]=
=2Edestlen)
+        struct oob_probe_target *t =3D &targets[i];
+        i=
f (t->n_dests =3D=3D 0)
         {
             continue;
         }
-     =
   socket_descriptor_t sd =3D pc=2Esd[probe_af_index(targets[i]=2Edest=2Ead=
dr=2Esa=2Esa_family)];
-        if (sd =3D=3D SOCKET_UNDEFINED)
+
+        =
if (!oob_probe_send_target(&pc, &probe, t))
         {
-            continu=
e; /* family not probed, see oob_probe_sockets_open() */
+            msg(D=
_LOW, "server-probe: %s:%s: probe send failed", ce->remote, ce->remote_port=
);
+            continue;
         }
-        if (!oob_addr_list_contains(p=
c=2Eprobed, pc=2En_probed, &targets[i]=2Edest))
-        {
-            if =
(sendto(sd, (const char *)BPTR(&probe), (int)BLEN(&probe), 0,
-            =
           (struct sockaddr *)&targets[i]=2Edest, targets[i]=2Edestlen)
-  =
              < 0)
-            {
-                msg(D_LOW, "server-probe=
: %s:%s: probe send failed", ce->remote, ce->remote_port);
-               =
 continue;
-            }
-            pc=2Eprobed[pc=2En_probed++] =3D tar=
gets[i]=2Edest;
-        }
-        openvpn_gettimeofday(&targets[i]=2Esent=
_at, NULL);
-        targets[i]=2Esent =3D true;
+        openvpn_gettimeof=
day(&t->sent_at, NULL);
+        t->sent =3D true;
         sent_count++;
 =
    }
 
diff --git a/tests/unit_tests/openvpn/test_oob=2Ec b/tests/unit_tes=
ts/openvpn/test_oob=2Ec
index 2728825=2E=2E29f77f5 100644
--- a/tests/unit_=
tests/openvpn/test_oob=2Ec
+++ b/tests/unit_tests/openvpn/test_oob=2Ec
@@ -=
482,10 +482,12 @@
     return sa;
 }
 
+/* One probed address per entry=2E =
*/
 static struct oob_probe_target
-probe_target(struct openvpn_sockaddr de=
st, bool sent)
+probe_target(struct openvpn_sockaddr *dest, bool sent)
 {
-=
    return (struct oob_probe_target){ =2Edest =3D dest, =2Edestlen =3D size=
of(dest=2Eaddr=2Ein4), =2Esent =3D sent };
+    static socklen_t len =3D si=
zeof(struct sockaddr_in);
+    return (struct oob_probe_target){ =2Edests =
=3D dest, =2Edestlens =3D &len, =2En_dests =3D 1, =2Esent =3D sent };
 }
 
=
 /* Two entries resolving to the same address are both credited by one repl=
y,
@@ -494,7 +496,7 @@
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
@@ -518,9 +520,9 @@
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
 18
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>

--gtKRXCSxFn0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #18</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1751?usp=3Demail">View Change</a></p><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">oob: Pro=
be every resolved address of a remote<br><br>A remote can resolve to severa=
l A/AAAA records; --server-probe previously<br>sent a SERVER_PROBE only to =
the first one, so a remote whose first address<br>was unreachable looked un=
responsive even if another address answered, and<br>the connection could la=
ter try an address that was never probed=2E<br><br>Probe every resolved add=
ress of each remote in parallel (per-remote storage<br>is sized to the reso=
lved address count, no fixed cap), accept a reply from<br>any of them (firs=
t reply for a remote wins), and resend to all of a remote&#39;s<br>addresse=
s while it is unanswered=2E<br><br>Change-Id: I00208610e0ce4f3ed9a87233e68e=
ce1b3b8a768a<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>--=
-<br>M doc/man-sections/client-options=2Erst<br>M src/openvpn/oob=2Ec<br>M =
src/openvpn/oob=2Eh<br>M src/openvpn/oob_client=2Ec<br>M tests/unit_tests/o=
penvpn/test_oob=2Ec<br>5 files changed, 91 insertions(+), 52 deletions(-)<b=
r><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openv=
pn refs/changes/51/1751/18</pre><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;"><span>diff --git a/doc/man-sections/client-opt=
ions=2Erst b/doc/man-sections/client-options=2Erst</span><br><span>index f5=
82dc9=2E=2Ecf9883f 100644</span><br><span>--- a/doc/man-sections/client-opt=
ions=2Erst</span><br><span>+++ b/doc/man-sections/client-options=2Erst</spa=
n><br><span>@@ -604,7 +604,7 @@</span><br><span>      server-probe</span><b=
r><span>      server-probe max-latency-diff</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-  A small probe message is sent to =
the first resolved address of every UDP</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  A small probe message is sent to every resolved addre=
ss of every UDP</span><br><span>   remote, and each answering server replie=
s with its advertised priority</span><br><span>   and weight=2E Remotes are=
 then reordered following DNS SRV (RFC 2782)</span><br><span>   semantics: =
servers that answered are tried before those that did not,</span><br><span>=
diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec</span><br><span>inde=
x 344f370=2E=2E2835c73 100644</span><br><span>--- a/src/openvpn/oob=2Ec</sp=
an><br><span>+++ b/src/openvpn/oob=2Ec</span><br><span>@@ -154,9 +154,16 @@=
</span><br><span> {</span><br><span>     for (int i =3D start; i &lt; n; i+=
+)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        if (targets[i]=2Esent &amp;&amp; !results[i]=2Eresponded &amp;&=
amp; addr_port_match(from, &amp;targets[i]=2Edest))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (!targets[i]=2Esent || results=
[i]=2Eresponded)</span><br><span>         {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            return i;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            continue;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        for (int k =3D 0; k &lt; targets[i]=2En_dests; k++)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            if (addr_port_mat=
ch(from, &amp;targets[i]=2Edests[k]))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                return i;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            }</span><br><span>         }</span><br><span>=
     }</span><br><span>     return -1;</span><br><span>diff --git a/src/ope=
nvpn/oob=2Eh b/src/openvpn/oob=2Eh</span><br><span>index af0670a=2E=2E27ae0=
2a 100644</span><br><span>--- a/src/openvpn/oob=2Eh</span><br><span>+++ b/s=
rc/openvpn/oob=2Eh</span><br><span>@@ -190,11 +190,12 @@</span><br><span>  =
   struct oob_probe_reply reply; /* the values the server advertised */</sp=
an><br><span> };</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-/* Where the client probed one connection entry=2E */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/* Where the client probed o=
ne connection entry: its resolved addresses=2E */</span><br><span> struct o=
ob_probe_target</span><br><span> {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    struct openvpn_sockaddr dest;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    socklen_t destlen;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct openvpn_sockaddr *dests;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    socklen_t *destlens;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    int n_dests;</span><br=
><span>     bool sent;</span><br><span>     struct timeval sent_at; /* when=
 the probe was sent, for RTT measurement */</span><br><span> };</span><br><=
span>diff --git a/src/openvpn/oob_client=2Ec b/src/openvpn/oob_client=2Ec</=
span><br><span>index 07e13a0=2E=2E878c904 100644</span><br><span>--- a/src/=
openvpn/oob_client=2Ec</span><br><span>+++ b/src/openvpn/oob_client=2Ec</sp=
an><br><span>@@ -260,6 +260,37 @@</span><br><span>     }</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
* Send the probe to every resolved address of t, each on the socket matchin=
g</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * its address fam=
ily=2E An address an earlier entry already probed in this round</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * is not probed again; that pr=
obe&#39;s reply covers this entry too=2E Returns true</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * if at least one address was sent to or=
 is already covered=2E */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oo=
b_probe_send_target(struct probe_ctx *pc, const struct buffer *probe, const=
 struct oob_probe_target *t)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool =
any_sent =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    for (int k =3D 0; k &lt; t-&gt;n_dests; k++)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        socket_descriptor_t sd =3D pc-&gt;sd[probe_af_index(=
t-&gt;dests[k]=2Eaddr=2Esa=2Esa_family)];</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if (sd =3D=3D SOCKET_UNDEFINED)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            continue;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if (oob_addr_list_contains(pc-&gt;probed,=
 pc-&gt;n_probed, &amp;t-&gt;dests[k]))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            any_sent =3D true;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            continue;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        if (sendto(sd, (const char *)BPTR(probe), (int)BLEN(pr=
obe), 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
        (const struct sockaddr *)&amp;t-&gt;dests[k], t-&gt;destlens[k])</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            &gt;=3D 0)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            pc-&gt;probed[pc-=
&gt;n_probed++] =3D t-&gt;dests[k];</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            any_sent =3D true;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    return any_sent;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an> /* Parse one received datagram as a PROBE_REPLY and, if valid and match=
ing one</span><br><span>  * of the probes we sent, record the reply in resu=
lts=2E */</span><br><span> static void</span><br><span>@@ -302,9 +333,10 @@=
</span><br><span>         return;</span><br><span>     }</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Credit the repl=
y to every still-unanswered remote probed at its source</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-     * address: several entries can resol=
ve to the same address, and each takes</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-     * the first reply for it=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Credit the reply to every still-un=
answered remote that was probed at its</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+     * source address: several entries can resolve to th=
e same address, and each</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     * takes the first reply for it=2E (A remote with several addresse=
s may answer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * =
from more than one; the first one wins=2E) */</span><br><span>     struct t=
imeval rcv;</span><br><span>     openvpn_gettimeofday(&amp;rcv, NULL);</spa=
n><br><span>     int i =3D oob_probe_next_target_at(from, targets, results,=
 n, 0);</span><br><span>@@ -409,18 +441,9 @@</span><br><span>     pc-&gt;n_=
probed =3D 0; /* a new round: probe each unanswered address once again */</=
span><br><span>     for (int i =3D 0; i &lt; n; i++)</span><br><span>     {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!targets[=
i]=2Esent || results[i]=2Eresponded</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            || oob_addr_list_contains(pc-&gt;probed, pc-&gt;n=
_probed, &amp;targets[i]=2Edest))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        if (targets[i]=2Esent &amp;&amp; !results[i]=2Erespon=
ded)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            continue;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      socket_descriptor_t sd =3D pc-&gt;sd[probe_af_index(targets[i]=2Edest=
=2Eaddr=2Esa=2Esa_family)];</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        if (sd !=3D SOCKET_UNDEFINED</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            &amp;&amp; sendto(sd, (const char *)BPTR(p=
robe), (int)BLEN(probe), 0,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                      (const struct sockaddr *)&amp;targets[i]=2Edest=
, targets[i]=2Edestlen)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                   &gt;=3D 0)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          pc-&gt;probed[pc-&gt;n_probed++] =3D targets[i]=2Edest;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            oob_probe_send_ta=
rget(pc, probe, &amp;targets[i]);</span><br><span>         }</span><br><spa=
n>     }</span><br><span> }</span><br><span>@@ -607,11 +630,23 @@</span><br=
><span>             continue;</span><br><span>         }</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* Store the f=
irst resolved address natively (no IPv4-mapping); it is</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-         * later probed on its family&#39=
;s socket=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  memcpy(&amp;targets[i]=2Edest, ai-&gt;ai_addr, ai-&gt;ai_addrlen);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        targets[i]=2Edestlen=
 =3D (socklen_t)ai-&gt;ai_addrlen;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        need_af[probe_af_index(ai-&gt;ai_family)] =3D true;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Store every=
 resolved address natively (no IPv4-mapping); each is later</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+         * probed on its family&#39=
;s socket=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    struct oob_probe_target *t =3D &amp;targets[i];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        int n_addr =3D 0;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        for (const struct addrinfo =
*a =3D ai; a; a =3D a-&gt;ai_next)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            n_addr++;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     t-&gt;dests =3D gc_malloc(sizeof(*t-&gt;dests) * n_addr, true, &amp;gc=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        t-&gt;des=
tlens =3D gc_malloc(sizeof(*t-&gt;destlens) * n_addr, true, &amp;gc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (const struct=
 addrinfo *a =3D ai; a; a =3D a-&gt;ai_next)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            memcpy(&amp;t-&gt;dests[t-&gt;n_dests], a-&gt;ai=
_addr, a-&gt;ai_addrlen);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            t-&gt;destlens[t-&gt;n_dests] =3D (socklen_t)a-&gt;ai_add=
rlen;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            t-=
&gt;n_dests++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       need_af[probe_af_index(a-&gt;ai_family)] =3D true;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>         fr=
eeaddrinfo(ai);</span><br><span>     }</span><br><span> </span><br><span>@@=
 -628,38 +663,32 @@</span><br><span>         return;</span><br><span>     }=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 /* Send a probe to each resolved remote, on the socket of its address fami=
ly=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * An addres=
s several entries resolve to is probed once; its reply is</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-     * credited to each of them=2E */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    pc=2Eprobed =3D gc_=
malloc(sizeof(*pc=2Eprobed) * l-&gt;len, false, &amp;gc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* Send a probe to each resolved =
remote, on the socket of each address=2E */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    int n_addrs =3D 0;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; l-&gt;len; i++)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        n_addrs +=3D targets[i]=2En_d=
ests;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    pc=2Eprobed =3D gc_mallo=
c(sizeof(*pc=2Eprobed) * n_addrs, false, &amp;gc);</span><br><span>     pc=
=2En_probed =3D 0;</span><br><span> </span><br><span>     int sent_count =
=3D 0;</span><br><span>     for (int i =3D 0; i &lt; l-&gt;len; i++)</span>=
<br><span>     {</span><br><span>         const struct connection_entry *ce=
 =3D l-&gt;array[i];</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       if (!targets[i]=2Edestlen)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        struct oob_probe_target *t =3D &amp;targets[i];</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (t-&gt;n_dests=
 =3D=3D 0)</span><br><span>         {</span><br><span>             continue=
;</span><br><span>         }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        socket_descriptor_t sd =3D pc=2Esd[probe_af_index(targets[i]=
=2Edest=2Eaddr=2Esa=2Esa_family)];</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        if (sd =3D=3D SOCKET_UNDEFINED)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (!oob_probe_send_target(&amp;pc, &amp;probe, t))<=
/span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            continue; /* family not probed, see oob_probe_sockets_open=
() */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ms=
g(D_LOW, &quot;server-probe: %s:%s: probe send failed&quot;, ce-&gt;remote,=
 ce-&gt;remote_port);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            continue;</span><br><span>         }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        if (!oob_addr_list_contains(pc=2Eprobe=
d, pc=2En_probed, &amp;targets[i]=2Edest))</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            if (sendto(sd, (const char *)BPTR(&amp;probe), (int)BL=
EN(&amp;probe), 0,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                    (struct sockaddr *)&amp;targets[i]=2Edest, targets[i]=
=2Edestlen)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
      &lt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
msg(D_LOW, &quot;server-probe: %s:%s: probe send failed&quot;, ce-&gt;remot=
e, ce-&gt;remote_port);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                continue;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          pc=2Eprobed[pc=2En_probed++] =3D targets[i]=2Edest;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        openvpn_gettimeofday(&amp;targets[i]=2E=
sent_at, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  targets[i]=2Esent =3D true;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        openvpn_gettimeofday(&amp;t-&gt;sent_at, NULL);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        t-&gt;sent =3D true;<=
/span><br><span>         sent_count++;</span><br><span>     }</span><br><sp=
an> </span><br><span>diff --git a/tests/unit_tests/openvpn/test_oob=2Ec b/t=
ests/unit_tests/openvpn/test_oob=2Ec</span><br><span>index 2728825=2E=2E29f=
77f5 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_oob=2Ec</sp=
an><br><span>+++ b/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>@@=
 -482,10 +482,12 @@</span><br><span>     return sa;</span><br><span> }</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* One=
 probed address per entry=2E */</span><br><span> static struct oob_probe_ta=
rget</span><br><span style=3D"color: hsl(0, 100%, 40%);">-probe_target(stru=
ct openvpn_sockaddr dest, bool sent)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+probe_target(struct openvpn_sockaddr *dest, bool sent)</sp=
an><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    re=
turn (struct oob_probe_target){ =2Edest =3D dest, =2Edestlen =3D sizeof(des=
t=2Eaddr=2Ein4), =2Esent =3D sent };</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    static socklen_t len =3D sizeof(struct sockaddr_in);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (struct oo=
b_probe_target){ =2Edests =3D dest, =2Edestlens =3D &amp;len, =2En_dests =
=3D 1, =2Esent =3D sent };</span><br><span> }</span><br><span> </span><br><=
span> /* Two entries resolving to the same address are both credited by one=
 reply,</span><br><span>@@ -494,7 +496,7 @@</span><br><span> test_probe_rep=
ly_credits_every_entry_at_address(void **state)</span><br><span> {</span><b=
r><span>     struct openvpn_sockaddr a =3D v4_addr(0x7f000001, 1194);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct oob_probe_target=
 targets[2] =3D { probe_target(a, true), probe_target(a, true) };</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_target t=
argets[2] =3D { probe_target(&amp;a, true), probe_target(&amp;a, true) };</=
span><br><span>     struct oob_probe_result results[2] =3D { 0 };</span><br=
><span> </span><br><span>     int i =3D oob_probe_next_target_at(&amp;a, ta=
rgets, results, 2, 0);</span><br><span>@@ -518,9 +520,9 @@</span><br><span>=
     struct openvpn_sockaddr b =3D v4_addr(0x7f000002, 1194);</span><br><sp=
an>     struct openvpn_sockaddr a_other_port =3D v4_addr(0x7f000001, 1195);=
</span><br><span>     struct oob_probe_target targets[3] =3D {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        probe_target(a, true),</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        probe_target(b, t=
rue),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        probe_ta=
rget(a, false), /* resolved but never sent */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        probe_target(&amp;a, true),</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        probe_target(&amp;b, true=
),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        probe_tar=
get(&amp;a, false), /* resolved but never sent */</span><br><span>     };</=
span><br><span>     struct oob_probe_result results[3] =3D { 0 };</span><br=
><span> </span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1751?usp=3Demail">change 1751</a>=2E =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1751?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"dis=
play:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I00208610=
e0ce4f3ed9a87233e68ece1b3b8a768a </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1751 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1=
8 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gma=
il=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos=
 &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div=
>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>

</body></html>
--gtKRXCSxFn0=--


--===============5540325175977174164==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5540325175977174164==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5540325175977174164==--

