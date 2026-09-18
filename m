Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A471BC88E75
	for <openvpn-devel@archiver.kernel.org>; Fri, 18 Sep 2026 08:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ngLq0jpRpMgIL0IglRIl1UOisnzKXw+rWkIX1mCezTs=; b=XsgkF8Y3Fjv0hA0EvTQ39Y8yTc
	Fj9rXnA5Q0TftR8AWK9UKBKd46EOU9dRPK32ebh01cbHWWg+5GJFfgHEWjYnxtNCUUwpTu26Qqavw
	y7GrXu86F7cGQ7Gs7esf/BQYN8ySR0UJUqYSsu+bMXpVp9GfszAbDjZY/DKyAmT/gXHY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x7U0w-00061K-GE;
	Fri, 18 Sep 2026 08:32:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x7U0t-00060k-02
 for openvpn-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 08:32:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=aiIFnIKvqAZSdKXCNS3Jbt+AJXuE1MYBYA++PNCBGks=; b=aSCDfkiaxkZF3i64UCINeg00DR
 Bnq5zlkEOP65K1XfsMfB2qIM2VVMcFuZSP6/foeS+gM8sJgsUpHiR6QnPly8sxRYcAP79uPotHWnU
 63rzZtHwwt/NWnGgws0OKOn7kKHo6gQbVpt9FNwNCVnxajgVtv7n4UsImNZSpZ6FBL8M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=aiIFnIKvqAZSdKXCNS3Jbt+AJXuE1MYBYA++PNCBGks=; b=i
 sxjxli5PqRFVURvIDavm+lY8FQqOeHIiWlVv3iCE3UvWB7B4HbH68UKGd/VPAd5LoRZs1QEntKJHn
 +9pPpdhBWR+hBOQ+pciZVLSPUPyHWHBTBd7VG3gZ20Xeh+tzBAdtxTpsUqsBy/H5NRrQuXAFXwEqo
 yPRW5d32Hz/uaWg8=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x7U0n-0003O2-Dg for openvpn-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 08:32:07 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f633ece3so322332f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 18 Sep 2026 01:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789720315; x=1790325115; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=aiIFnIKvqAZSdKXCNS3Jbt+AJXuE1MYBYA++PNCBGks=;
 b=D/5nvBwLSO3HgLoLB5RV6QTPpUjh0uXvCjRuws223sCo20laMT6HhMPZfCLiKsFpDT
 PClFZ25Uwkp9k8J3KDQTZGw66PH7N/Y4BduG8digUr+pXns6I4FW60Ni9WC66EemsGDV
 umDuv1juNv0gPfeCk4KYCWQs/YtY5ctUhXUKlGFwVjyf6/ZNNjF1FARYOhbMzCe+mENa
 BjlxZSZ3IDAg82EWbumEdq4fcXLZLW3y9Wzmoyylq3c9Iej4Yq628/M9NMa1GTLfEzJK
 yTgBTyI9Gt+CAoyrZW6JHS+QKLWZc+RJJ0R8VfzPPsegVP/V4HhaYvAuUzqUQieRN/8G
 Ebjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789720315; x=1790325115;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=aiIFnIKvqAZSdKXCNS3Jbt+AJXuE1MYBYA++PNCBGks=;
 b=pVnyW5upL9STgjE8ZfUiV0nPRPKHCwkiDrrb+i9fQl1BzXAlPM+NFyl61Wj667UjJh
 U5iBRIvbttY5709LYf30x/Q31nd75ouygx+0IFaxz8xZ3V+6jvMSRtthiCH8g6DPu7yQ
 tCpggg/jbOeu2KEvieGHRcpAl7ymh6ggbsAdhfyDaJNqn5fjuRO0pTyJ6rfZBjJo8rnL
 /oRZFTfNVC1wuH/7dLETvXLgucHpnt4xTpPCHuX9l9dV43LSEtQqXP7VcBzZf8gqPFK9
 HZeDpDmLk1YPb2z7TjdeCjslfETku2ko6Jxivx9GTyw8EbGg4JSR85Vb8Mknrz0NO9+e
 gnuQ==
X-Gm-Message-State: AFuF++mkPeceleeh/jLCiRr7dwTDMQyJ3o10dgeB8epLCwMzayCZU/be
 i66PCzOo8h2BaIvqXOboZJQithUFfc50Tu9DAkdLfpOEznlQKgGMKjF/ZqoGZTKqejyniJ8MouD
 07stucRHo5A4TPCyPvh8sFhmLuz/6R0u/6hMGEcaKpCVH8UBdITQnetwcY4mnrVfJ22Ox
X-Gm-Gg: AYBFou06Rw/9jorJBj7p/dSBW5wPgmLm6m0DMBAgQrquXuODxURU9cSVZ+L4ATjAhl8
 qeXuDo77tAjUKvHtowQnAVvHwX0/pX/z8OBWTvYn8QE6FZEFtvoqTF0GKyHRlE68M9K+LZWEGGb
 lhsm+vMPIEZAqMrzimF9mWPlEv9rV8+IvcVQGK6a2+fbve6OPtey/9viZBIHkewXsIE3palNezq
 BnZXhUbsD3bvgJ7anR+iWS8OXLZxLAnELP8BbgvbWeNZB45aBEuXmZ7tOiQDmciPcLpohqswW/l
 CpNoDMspZJxL8i0E9szr3Ba53BoLtxg8TADWhEaDBqPatDe4EUHGdoQFv06Zx4hQm7DUIyiwXCb
 YQAJIO3/NLzDl3RNgNV7QC8gxMfeXKPJlOkyqQh7Ypb5MtI9bJF7YtqfKarye1tAT7vagqaZUzm
 G4BYpd+qVHW19ppc/a94Ryz01LDgvD5PdZPOMfNhEGSEdstEOjALpLx65kOBvAj5ndkDivl6Ir5
 MMXEcYAEIN96MLGMKrgk5QuHJ+ITiO2pn1d2NmDwyP7nswLbqyKwV5CWDTUvOUU+722arg9i0Zl
 As0xxrmnzoVuAap4NsaCcgJ5+H6ngmCQ9u5p+2M8HZ1opK+/OAtFEi8j7urH
X-Received: by 2002:a05:6000:41d9:b0:487:f6e:e766 with SMTP id
 ffacd0b85a97d-4871e38375amr2034333f8f.56.1789720314096; 
 Fri, 18 Sep 2026 01:31:54 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4872008160csm2608611f8f.32.2026.09.18.01.31.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 01:31:53 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 18 Sep 2026 08:31:39 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 21
X-Gerrit-Change-Id: I55da68cc341bcfc707fd34ca2f84ff9b6a55501f
X-Gerrit-Change-Number: 1746
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1746?usp=email>
X-Gerrit-Commit: 1ea6db7a275b05608d479bc3a2a4f54c20921221
In-Reply-To: <gerrit.1782719911000.I55da68cc341bcfc707fd34ca2f84ff9b6a55501f@gerrit.openvpn.net>
References: <gerrit.1782719911000.I55da68cc341bcfc707fd34ca2f84ff9b6a55501f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk1NWRhNjhjYzM0MWJjZmM3MDdmZDM0Y2EyZjg0ZmY5YjZhNTU1MDFmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6991f456033a19c647cc5c7f1e2d11910a525070-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x7U0n-0003O2-Dg
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Add
 probe-result ranking for server selection
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
Content-Type: multipart/mixed; boundary="===============6115943114606647007=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6115943114606647007==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6xYnELYzPok="; charset=UTF-8

--6xYnELYzPok=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici=2E

Hello plaist=
hos, ralf_lici, 

I'd like you to reexamine a change=2E Please visit

    h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1746?usp=3Demail

to look at the n=
ew patch set (#21)=2E


Change subject: oob: Add probe-result ranking for s=
erver selection
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

oob: Add probe-result ranking for server selection

Add oob_rank_probe=
_results(), which orders remotes best-first from their
probe results, follo=
wing the DNS-SRV (RFC 2782) semantics of the
probe_reply TLV:

  - remotes =
that answered rank before those that did not (non-responders
    keep their=
 original relative order, last);
  - responders are grouped by priority, lo=
west value first (an absolute
    ordering, never overridden by latency or =
weight);
  - within a priority group the "candidates" are the responders wh=
ose
    RTT is no more than a margin larger than the fastest, so the fastes=
t
    is always one; candidates rank ahead of non-candidates;
  - candidate=
s are ordered by RFC-2782 weighted-random selection by
    weight, so a ser=
ver is chosen first with probability proportional to
    its weight (load d=
istribution); non-candidates follow, ordered by
    RTT=2E

oob_effective_m=
argin() decides that margin: the client's --server-probe
value if it set on=
e, otherwise the server's advertised max_latency_diff,
where 0 admits only =
the fastest responder and whatever ties with it=2E

The RNG is injected as =
a function pointer so this module stays free of
the crypto layer and the we=
ighted ordering is deterministically
unit-testable (the client will pass ge=
t_random; the tests pass stubs)=2E

Exercised by unit tests; the client pro=
be path calls it in a follow-up,
which also populates RTT -- until then eve=
ry responder sits in the band
and selection is purely weighted-random=2E

C=
hange-Id: I55da68cc341bcfc707fd34ca2f84ff9b6a55501f
Signed-off-by: Lev Stip=
akov <lev@openvpn=2Enet>
---
M src/openvpn/oob=2Ec
M src/openvpn/oob=2Eh
M =
tests/unit_tests/openvpn/test_oob=2Ec
3 files changed, 491 insertions(+), 0=
 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/=
changes/46/1746/21

diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec
=
index 57542ad=2E=2E887f6de7 100644
--- a/src/openvpn/oob=2Ec
+++ b/src/open=
vpn/oob=2Ec
@@ -146,3 +146,169 @@
     return oob_timestamp_in_window(param=
=2Etimestamp, now, window_secs) ? OOB_PROBE_OK
                            =
                                           : OOB_PROBE_STALE;
 }
+
+/* Base=
 ordering: responders before non-responders, then by priority (lower
+ * fi=
rst), then by RTT (lower first), then by original index for determinism=2E
=
+ * This groups responders into priority runs pre-sorted by RTT, which the
=
+ * candidate-band step below relies on (run[0] is the fastest in its group=
)=2E */
+static int
+oob_probe_result_compare(const void *a, const void *b)=

+{
+    const struct oob_probe_result *ra =3D a;
+    const struct oob_pro=
be_result *rb =3D b;
+
+    if (ra->responded && rb->responded)
+    {
+   =
     /* both answered: lowest priority first, then lowest RTT */
+        i=
f (ra->reply=2Epriority !=3D rb->reply=2Epriority)
+        {
+            =
return ra->reply=2Epriority < rb->reply=2Epriority ? -1 : 1;
+        }
+  =
      if (ra->rtt_ms !=3D rb->rtt_ms)
+        {
+            return ra->rt=
t_ms < rb->rtt_ms ? -1 : 1;
+        }
+    }
+    else if (ra->responded)
=
+    {
+        return -1; /* only a answered: it ranks first */
+    }
+  =
  else if (rb->responded)
+    {
+        return 1; /* only b answered */
+=
    }
+
+    /* neither answered, or all keys equal: keep the configured or=
der */
+    return ra->index - rb->index;
+}
+
+int
+oob_effective_margin(c=
onst struct oob_probe_result *r, int client_margin)
+{
+    if (client_marg=
in >=3D 0)
+    {
+        return client_margin;              /* the client=
's own setting is authoritative */
+    }
+    return (int)r->reply=2Emax_l=
atency_diff; /* else what the fastest remote advertised */
+}
+
+/* Reorder=
 the index list idx[0=2E=2Em) into DNS-SRV (RFC 2782) weighted-random
+ * o=
rder by results[idx[k]]=2Ereply=2Eweight: each position is filled by a rema=
ining entry
+ * chosen with probability proportional to its weight=2E When =
all remaining
+ * weights are 0 the current (RTT-sorted) order is kept=2E *=
/
+static void
+oob_weighted_order(const struct oob_probe_result *results, =
int *idx, int m, int64_t (*rng)(void))
+{
+    for (int pos =3D 0; pos < m;=
 pos++)
+    {
+        long sum =3D 0;
+        for (int k =3D pos; k < m;=
 k++)
+        {
+            sum +=3D results[idx[k]]=2Ereply=2Eweight;
+ =
       }
+        int chosen =3D pos;
+        if (sum > 0)
+        {
+   =
         int64_t r =3D rng() % sum; /* uniform in [0, sum) */
+            =
long acc =3D 0;
+            for (int k =3D pos; k < m; k++)
+            {=

+                acc +=3D results[idx[k]]=2Ereply=2Eweight;
+             =
   if (acc > r)
+                {
+                    chosen =3D k;
+    =
                break;
+                }
+            }
+        }
+      =
  /* Move the chosen entry to pos and shift the ones it jumped over down
+ =
        * by one=2E RFC 2782 removes the selected entry from the list, so t=
he
+         * rest keep their RTT order; a swap would fling the displaced =
entry to
+         * the far end and can leave the fastest server tried las=
t=2E */
+        int sel =3D idx[chosen];
+        for (int k =3D chosen; k=
 > pos; k--)
+        {
+            idx[k] =3D idx[k - 1];
+        }
+   =
     idx[pos] =3D sel;
+    }
+}
+
+/* Reorder one priority run (run[0=2E=
=2Em), already RTT-sorted) in place:
+ * candidates (RTT within the band of=
 the fastest) first, ordered by weighted
+ * random; then non-candidates in=
 RTT order=2E */
+static void
+oob_order_priority_run(struct oob_probe_resu=
lt *run, int m, int client_margin, int64_t (*rng)(void),
+                 =
      struct gc_arena *gc)
+{
+    if (m <=3D 1)
+    {
+        return;
+ =
   }
+
+    unsigned int best_rtt =3D run[0]=2Ertt_ms; /* run is RTT-sorted=
: [0] is fastest */
+
+    int *cand =3D gc_malloc(sizeof(int) * m, false, =
gc);
+    int *non =3D gc_malloc(sizeof(int) * m, false, gc);
+    int nc =
=3D 0;
+    int nn =3D 0;
+    /* The band is the fastest remote's: its mar=
gin says how much slower another
+     * remote may be and still count as e=
qual to it, weight then deciding between
+     * them=2E A slower remote's =
own margin plays no part=2E The comparison is
+     * inclusive ("no more t=
han max_latency_diff larger than the lowest RTT"),
+     * so the fastest i=
s always a candidate, also when it advertises 0=2E */
+    const unsigned i=
nt margin =3D (unsigned int)oob_effective_margin(&run[0], client_margin);
+=
    for (int k =3D 0; k < m; k++)
+    {
+        unsigned int gap =3D run[=
k]=2Ertt_ms - best_rtt;
+        if (gap <=3D margin)
+        {
+         =
   cand[nc++] =3D k;
+        }
+        else
+        {
+            non[n=
n++] =3D k;
+        }
+    }
+
+    oob_weighted_order(run, cand, nc, rng)=
;
+
+    struct oob_probe_result *tmp =3D gc_malloc(sizeof(*tmp) * m, false=
, gc);
+    int t =3D 0;
+    for (int k =3D 0; k < nc; k++)
+    {
+      =
  tmp[t++] =3D run[cand[k]];
+    }
+    for (int k =3D 0; k < nn; k++)
+  =
  {
+        tmp[t++] =3D run[non[k]];
+    }
+    memcpy(run, tmp, sizeof(=
*run) * m);
+}
+
+void
+oob_rank_probe_results(struct oob_probe_result *res=
ults, int n, int client_margin,
+                       int64_t (*rng)(void=
), struct gc_arena *gc)
+{
+    if (n <=3D 1)
+    {
+        return;
+    =
}
+
+    /* Base order: responders first, grouped by priority, RTT-sorted w=
ithin=2E */
+    qsort(results, (size_t)n, sizeof(*results), oob_probe_resu=
lt_compare);
+
+    /* Reorder each priority run of responders by candidate=
-band + weight=2E */
+    int i =3D 0;
+    while (i < n && results[i]=2Ere=
sponded)
+    {
+        int j =3D i;
+        while (j < n && results[j]=
=2Eresponded
+               && results[j]=2Ereply=2Epriority =3D=3D result=
s[i]=2Ereply=2Epriority)
+        {
+            j++;
+        }
+        o=
ob_order_priority_run(results + i, j - i, client_margin, rng, gc);
+       =
 i =3D j;
+    }
+}
diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh
=
index 21af63f=2E=2Eb902363 100644
--- a/src/openvpn/oob=2Eh
+++ b/src/openv=
pn/oob=2Eh
@@ -177,4 +177,56 @@
 enum oob_probe_verdict oob_server_probe_ch=
eck(struct buffer *probe_payload, uint64_t now,
                           =
                    uint64_t window_secs);
 
+/* Candidate-band margin (ms)=
 a server advertises when --server-probe-reply does
+ * not set one=2E Anno=
uncing 0 is a valid choice with a distinct meaning -- only
+ * the lowest-l=
atency server is a candidate -- so an unconfigured server has to
+ * announ=
ce something else; the spec suggests 10 to 20 ms=2E */
+#define OOB_DEFAULT=
_LATENCY_MARGIN_MS 10
+
+/* Outcome of probing one remote, used to order re=
motes best-first=2E @index is
+ * the caller's identifier for the remote (e=
=2Eg=2E its position in the connection
+ * list); priority/weight are only =
meaningful when @responded is true=2E */
+struct oob_probe_result
+{
+    i=
nt index;
+    bool responded;
+    unsigned int rtt_ms;          /* probe =
round-trip time in ms (responders only) */
+    struct oob_probe_reply repl=
y; /* the values the server advertised */
+};
+
+/**
+ * Order results best=
-first, in place, per the server-probe selection policy:
+ *   - remotes th=
at responded rank before those that did not (non-responders keep
+ *     th=
eir original relative order, last);
+ *   - responders are grouped by prior=
ity, lowest priority value first (an
+ *     absolute ordering, never overr=
idden by latency or weight);
+ *   - within a priority group, the "candidat=
es" are the responders whose RTT is
+ *     no more than the fastest remote=
's margin larger than its RTT (see
+ *     oob_effective_margin()), so the =
fastest is always one=2E Candidates are
+ *     ordered ahead of non-candid=
ates;
+ *   - candidates are ordered by DNS-SRV (RFC 2782) weighted-random =
selection by
+ *     weight, so a server is chosen first with probability p=
roportional to its
+ *     weight (load distribution)=2E Non-candidates fol=
low, ordered by RTT=2E
+ *
+ * @param results        results to reorder in =
place
+ * @param n              number of results
+ * @param client_margin =
 client's candidate-band margin in ms, or < 0 if the
+ *                   =
     client did not set one (see oob_effective_margin())
+ * @param rng    =
        returns a non-negative random value (e=2Eg=2E get_random);
+ *     =
                  injected so this module stays free of the crypto layer
+ =
*                       and the weighted ordering is deterministically test=
able
+ * @param gc             arena for scratch allocation
+ */
+void oob_=
rank_probe_results(struct oob_probe_result *results, int n, int client_marg=
in,
+                            int64_t (*rng)(void), struct gc_arena *gc)=
;
+
+/**
+ * The candidate-band margin (ms) of a priority group -- how much=
 slower than
+ * the group's fastest remote another remote may be and still=
 be a candidate=2E
+ * The client's own setting is authoritative; when clie=
nt_margin < 0 the
+ * max_latency_diff advertised by the fastest remote (r)=
 applies to the whole
+ * group=2E 0 then admits only remotes tying the fas=
test=2E
+ */
+int oob_effective_margin(const struct oob_probe_result *r, in=
t client_margin);
+
 #endif /* OOB_H */
diff --git a/tests/unit_tests/openv=
pn/test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec
index 6fcf084=2E=2E=
87ff9cb 100644
--- a/tests/unit_tests/openvpn/test_oob=2Ec
+++ b/tests/unit=
_tests/openvpn/test_oob=2Ec
@@ -614,6 +614,267 @@
     gc_free(&gc);
 }
 
+=
/* Deterministic RNG stubs for the weighted-selection ordering=2E rank_rng_=
zero
+ * makes the weighted draw always pick the first remaining candidate,=
 preserving
+ * order; rank_rng_fixed returns a value we set to land in a c=
hosen weight slice=2E */
+static int64_t
+rank_rng_zero(void)
+{
+    retur=
n 0;
+}
+
+static int64_t rank_rng_value;
+static int64_t
+rank_rng_fixed(v=
oid)
+{
+    return rank_rng_value;
+}
+
+/* Picking a weighted entry must =
not disturb the RTT order of the entries it
+ * was picked ahead of: RFC 27=
82 removes the selection, it does not swap=2E */
+static void
+test_rank_we=
ighted_keeps_rtt_order_of_rest(void **state)
+{
+    struct gc_arena gc =3D=
 gc_new();
+    /* same priority, all in band; only the slowest advertises =
a weight, so it
+     * is drawn first and the two weight-0 entries must fo=
llow in RTT order=2E */
+    struct oob_probe_result r[] =3D {
+        { =
=2Eindex =3D 0, =2Eresponded =3D true, =2Ertt_ms =3D 20, =2Ereply =3D { =2E=
priority =3D 10, =2Eweight =3D 0 } },
+        { =2Eindex =3D 1, =2Erespond=
ed =3D true, =2Ertt_ms =3D 30, =2Ereply =3D { =2Epriority =3D 10, =2Eweight=
 =3D 0 } },
+        { =2Eindex =3D 2, =2Eresponded =3D true, =2Ertt_ms =3D=
 40, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 10 } },
+    };
+
+  =
  rank_rng_value =3D 0;
+    oob_rank_probe_results(r, 3, 100, rank_rng_fix=
ed, &gc);
+
+    assert_int_equal(r[0]=2Eindex, 2); /* the only weighted en=
try wins the draw */
+    assert_int_equal(r[1]=2Eindex, 0); /* 20 ms befor=
e 30 ms */
+    assert_int_equal(r[2]=2Eindex, 1);
+
+    gc_free(&gc);
+}
=
+
+/* Responders rank ahead of non-responders regardless of index order=2E =
*/
+static void
+test_rank_responder_before_nonresponder(void **state)
+{
+=
    struct gc_arena gc =3D gc_new();
+    struct oob_probe_result r[] =3D {=

+        { =2Eindex =3D 0, =2Eresponded =3D false },
+        { =2Eindex =
=3D 1, =2Eresponded =3D true, =2Ereply =3D { =2Epriority =3D 100, =2Eweight=
 =3D 50 } },
+    };
+    oob_rank_probe_results(r, 2, 10, rank_rng_zero, &=
gc);
+    assert_int_equal(r[0]=2Eindex, 1);
+    assert_int_equal(r[1]=2Ei=
ndex, 0);
+    gc_free(&gc);
+}
+
+/* Among responders, the lowest priority=
 value wins (an absolute ordering)=2E */
+static void
+test_rank_by_priorit=
y(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct oob_pr=
obe_result r[] =3D {
+        { =2Eindex =3D 0, =2Eresponded =3D true, =2Er=
eply =3D { =2Epriority =3D 20, =2Eweight =3D 50 } },
+        { =2Eindex =
=3D 1, =2Eresponded =3D true, =2Ereply =3D { =2Epriority =3D 5, =2Eweight =
=3D 50 } },
+        { =2Eindex =3D 2, =2Eresponded =3D true, =2Ereply =3D =
{ =2Epriority =3D 10, =2Eweight =3D 50 } },
+    };
+    oob_rank_probe_res=
ults(r, 3, 10, rank_rng_zero, &gc);
+    assert_int_equal(r[0]=2Eindex, 1);=
 /* priority 5 */
+    assert_int_equal(r[1]=2Eindex, 2); /* priority 10 */=

+    assert_int_equal(r[2]=2Eindex, 0); /* priority 20 */
+    gc_free(&gc=
);
+}
+
+/* Within a priority, only servers within the latency margin of th=
e fastest are
+ * candidates; a slower (out-of-band) server ranks behind a =
faster one no matter
+ * how large its weight=2E */
+static void
+test_rank=
_candidate_band(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+   =
 struct oob_probe_result r[] =3D {
+        { =2Eindex =3D 0, =2Eresponded =
=3D true, =2Ertt_ms =3D 100, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =
=3D 1000 } },
+        { =2Eindex =3D 1, =2Eresponded =3D true, =2Ertt_ms =
=3D 20, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 1 } },
+    };
+  =
  /* margin 10ms: 20ms is fastest; 100ms is 80ms slower -> out of band */
+=
    oob_rank_probe_results(r, 2, 10, rank_rng_zero, &gc);
+    assert_int_e=
qual(r[0]=2Eindex, 1); /* fast, in-band, despite tiny weight */
+    assert=
_int_equal(r[1]=2Eindex, 0); /* slow, out-of-band, despite huge weight */
+=
    gc_free(&gc);
+}
+
+/* A server widens its own band via the advertised =
max_latency_diff, joining the
+ * candidate set even when it is well behind=
 the fastest; it then participates in
+ * the weighted selection=2E */
+/* =
A client margin, even 0, overrides whatever the servers advertise=2E */
+st=
atic void
+test_rank_client_margin_overrides_advertised(void **state)
+{
+ =
   struct gc_arena gc =3D gc_new();
+    struct oob_probe_result r[] =3D {
=
+        { =2Eindex =3D 0, =2Eresponded =3D true, =2Ertt_ms =3D 20, =2Erepl=
y =3D { =2Epriority =3D 10, =2Eweight =3D 1 } },
+        { =2Eindex =3D 1,=

+          =2Eresponded =3D true,
+          =2Ertt_ms =3D 100,
+         =
 =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 1000, =2Emax_latency_diff=
 =3D 200 } },
+    };
+    /* With the advertised 200 ms the slow server wo=
uld be a candidate (see
+     * test_rank_advertised_margin); the client's =
0 leaves only the fastest=2E */
+    rank_rng_value =3D 500;
+    oob_rank_=
probe_results(r, 2, 0, rank_rng_fixed, &gc);
+    assert_int_equal(r[0]=2Ei=
ndex, 0);
+    assert_int_equal(r[1]=2Eindex, 1);
+    gc_free(&gc);
+}
+
+=
static void
+test_rank_advertised_margin(void **state)
+{
+    struct gc_ar=
ena gc =3D gc_new();
+    struct oob_probe_result r[] =3D {
+        { =2Ei=
ndex =3D 0,
+          =2Eresponded =3D true,
+          =2Ertt_ms =3D 20,
=
+          =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 1, =2Emax_laten=
cy_diff =3D 200 } },
+        { =2Eindex =3D 1, =2Eresponded =3D true, =2Er=
tt_ms =3D 100, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 1000 } },
+=
    };
+    /* Client did not set a margin (-1), so the fastest server's ad=
vertised
+     * value applies: it says 200, so the 100ms server is a candi=
date 80ms
+     * behind it; with weight 1000 (slice [1,1001)) a draw of 50=
0 selects it
+     * first=2E */
+    rank_rng_value =3D 500;
+    oob_rank=
_probe_results(r, 2, -1, rank_rng_fixed, &gc);
+    assert_int_equal(r[0]=
=2Eindex, 1);
+    gc_free(&gc);
+}
+
+/* A slower server's own margin does=
 not admit it: with the fastest advertising
+ * 0, the 100ms server is no c=
andidate however wide its margin or heavy its
+ * weight=2E */
+static void=

+test_rank_slower_servers_margin_has_no_effect(void **state)
+{
+    struc=
t gc_arena gc =3D gc_new();
+    struct oob_probe_result r[] =3D {
+       =
 { =2Eindex =3D 0, =2Eresponded =3D true, =2Ertt_ms =3D 20, =2Ereply =3D { =
=2Epriority =3D 10, =2Eweight =3D 1 } },
+        { =2Eindex =3D 1,
+      =
    =2Eresponded =3D true,
+          =2Ertt_ms =3D 100,
+          =2Erepl=
y =3D { =2Epriority =3D 10, =2Eweight =3D 1000, =2Emax_latency_diff =3D 200=
 } },
+    };
+    rank_rng_value =3D 500;
+    oob_rank_probe_results(r, 2=
, -1, rank_rng_fixed, &gc);
+    assert_int_equal(r[0]=2Eindex, 0);
+    gc=
_free(&gc);
+}
+
+/* Among candidates, weight drives RFC-2782 proportional =
selection: a draw is
+ * mapped to the server whose cumulative weight slice=
 it falls in=2E */
+static void
+test_rank_weighted_selection(void **state)=

+{
+    struct gc_arena gc =3D gc_new();
+    /* equal priority and RTT ->=
 both in band; weights 30 and 70, sum 100:
+     * index 0 owns [0,30), ind=
ex 1 owns [30,100)=2E */
+    const struct oob_probe_result base[] =3D {
+ =
       { =2Eindex =3D 0, =2Eresponded =3D true, =2Ertt_ms =3D 20, =2Ereply =
=3D { =2Epriority =3D 10, =2Eweight =3D 30 } },
+        { =2Eindex =3D 1, =
=2Eresponded =3D true, =2Ertt_ms =3D 20, =2Ereply =3D { =2Epriority =3D 10,=
 =2Eweight =3D 70 } },
+    };
+    struct oob_probe_result r[2];
+
+    me=
mcpy(r, base, sizeof(base));
+    rank_rng_value =3D 10; /* falls in index =
0's slice */
+    oob_rank_probe_results(r, 2, 50, rank_rng_fixed, &gc);
+ =
   assert_int_equal(r[0]=2Eindex, 0);
+
+    memcpy(r, base, sizeof(base));=

+    rank_rng_value =3D 50; /* falls in index 1's slice */
+    oob_rank_p=
robe_results(r, 2, 50, rank_rng_fixed, &gc);
+    assert_int_equal(r[0]=2Ei=
ndex, 1);
+
+    gc_free(&gc);
+}
+
+/* The fastest advertising 0 means "co=
mpare on latency alone": the band is
+ * empty, so weight cannot float a sl=
ower peer ahead of it=2E The same pair with a
+ * band advertised does let =
weight decide=2E */
+static void
+test_rank_advertised_zero_margin(void **s=
tate)
+{
+    struct gc_arena gc =3D gc_new();
+    const struct oob_probe_=
result base[] =3D {
+        { =2Eindex =3D 0, =2Eresponded =3D true, =2Ert=
t_ms =3D 20, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 1 } },
+     =
   { =2Eindex =3D 1, =2Eresponded =3D true, =2Ertt_ms =3D 40, =2Ereply =3D =
{ =2Epriority =3D 10, =2Eweight =3D 1000 } },
+    };
+    struct oob_probe=
_result r[2];
+
+    memcpy(r, base, sizeof(base));
+    rank_rng_value =3D=
 500;
+    oob_rank_probe_results(r, 2, -1, rank_rng_fixed, &gc);
+    asse=
rt_int_equal(r[0]=2Eindex, 0); /* both advertise 0 -> fastest wins */
+
+  =
  memcpy(r, base, sizeof(base));
+    r[0]=2Ereply=2Emax_latency_diff =3D 5=
0;
+    r[1]=2Ereply=2Emax_latency_diff =3D 50;
+    rank_rng_value =3D 500=
;            /* falls in the weight-1000 slice [1,1001) */
+    oob_rank_pr=
obe_results(r, 2, -1, rank_rng_fixed, &gc);
+    assert_int_equal(r[0]=2Ein=
dex, 1); /* 20ms behind but inside a 50ms band */
+
+    gc_free(&gc);
+}
+=

+/* Remotes tied at the fastest RTT are all candidates even at margin 0, s=
o weight
+ * still distributes load between them=2E */
+static void
+test_r=
ank_zero_margin_weights_ties(void **state)
+{
+    struct gc_arena gc =3D g=
c_new();
+    struct oob_probe_result r[] =3D {
+        { =2Eindex =3D 0, =
=2Eresponded =3D true, =2Ertt_ms =3D 20, =2Ereply =3D { =2Epriority =3D 10,=
 =2Eweight =3D 1, =2Emax_latency_diff =3D 0 } },
+        { =2Eindex =3D 1,=
 =2Eresponded =3D true, =2Ertt_ms =3D 20, =2Ereply =3D { =2Epriority =3D 10=
, =2Eweight =3D 1000, =2Emax_latency_diff =3D 0 } },
+    };
+    rank_rng_=
value =3D 500; /* falls in the weight-1000 slice [1,1001) */
+    oob_rank_=
probe_results(r, 2, -1, rank_rng_fixed, &gc);
+    assert_int_equal(r[0]=2E=
index, 1);
+    gc_free(&gc);
+}
+
+/* A remote exactly its advertised marg=
in behind the fastest is still a candidate
+ * ("no more than max_latency_d=
iff larger than the lowest RTT")=2E */
+static void
+test_rank_margin_bound=
ary_is_inclusive(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+  =
  struct oob_probe_result r[] =3D {
+        { =2Eindex =3D 0, =2Eresponded=
 =3D true, =2Ertt_ms =3D 20, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =
=3D 1, =2Emax_latency_diff =3D 10 } },
+        { =2Eindex =3D 1, =2Erespon=
ded =3D true, =2Ertt_ms =3D 30, =2Ereply =3D { =2Epriority =3D 10, =2Eweigh=
t =3D 1000, =2Emax_latency_diff =3D 10 } },
+    };
+    rank_rng_value =3D=
 500;
+    oob_rank_probe_results(r, 2, -1, rank_rng_fixed, &gc);
+    asse=
rt_int_equal(r[0]=2Eindex, 1); /* exactly 10ms behind, in band, wins on wei=
ght */
+    gc_free(&gc);
+}
+
+/* Non-responders are placed last, keeping =
their original relative order=2E */
+static void
+test_rank_nonresponders_l=
ast(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct oob_=
probe_result r[] =3D {
+        { =2Eindex =3D 0, =2Eresponded =3D false },=

+        { =2Eindex =3D 1, =2Eresponded =3D true, =2Ertt_ms =3D 20, =2Erep=
ly =3D { =2Epriority =3D 10, =2Eweight =3D 50 } },
+        { =2Eindex =3D =
2, =2Eresponded =3D false },
+        { =2Eindex =3D 3, =2Eresponded =3D tr=
ue, =2Ertt_ms =3D 20, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 50 }=
 },
+    };
+    oob_rank_probe_results(r, 4, 10, rank_rng_zero, &gc);
+   =
 assert_int_equal(r[0]=2Eindex, 1); /* responder (rng_zero keeps order) */
=
+    assert_int_equal(r[1]=2Eindex, 3); /* responder */
+    assert_int_equ=
al(r[2]=2Eindex, 0); /* non-responder, original order kept */
+    assert_i=
nt_equal(r[3]=2Eindex, 2);
+    gc_free(&gc);
+}
+
 /* The OOB tests run as=
 a second group of pkt_testdriver; see test_pkt=2Ec=2E */
 int
 run_oob_tes=
ts(void)
@@ -644,6 +905,18 @@
         cmocka_unit_test(test_client_reply_r=
ead_rejects_unknown_mandatory),
         cmocka_unit_test(test_client_reply=
_read_missing),
         cmocka_unit_test(test_client_reply_read_wrong_msg_=
type),
+        cmocka_unit_test(test_rank_responder_before_nonresponder),
=
+        cmocka_unit_test(test_rank_by_priority),
+        cmocka_unit_test=
(test_rank_candidate_band),
+        cmocka_unit_test(test_rank_advertised_=
margin),
+        cmocka_unit_test(test_rank_client_margin_overrides_advert=
ised),
+        cmocka_unit_test(test_rank_advertised_zero_margin),
+      =
  cmocka_unit_test(test_rank_slower_servers_margin_has_no_effect),
+       =
 cmocka_unit_test(test_rank_zero_margin_weights_ties),
+        cmocka_unit=
_test(test_rank_margin_boundary_is_inclusive),
+        cmocka_unit_test(te=
st_rank_weighted_selection),
+        cmocka_unit_test(test_rank_weighted_k=
eeps_rtt_order_of_rest),
+        cmocka_unit_test(test_rank_nonresponders_=
last),
     };
 
     return cmocka_run_group_tests_name("oob tests", tests=
, NULL, NULL);

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1746?usp=3Demail
To unsubscribe, or for help writing mail filters, visit =
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: new=
patchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5=
5da68cc341bcfc707fd34ca2f84ff9b6a55501f
Gerrit-Change-Number: 1746
Gerrit-P=
atchSet: 21
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

--6xYnELYzPok=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici=2E </p>
<p>stipa <strong>uploade=
d patch set #21</strong> to this change=2E</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1746?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">oob: Add probe-result ranking for server selection<br><br>Add oob_rank=
_probe_results(), which orders remotes best-first from their<br>probe resul=
ts, following the DNS-SRV (RFC 2782) semantics of the<br>probe_reply TLV:<b=
r><br>  - remotes that answered rank before those that did not (non-respond=
ers<br>    keep their original relative order, last);<br>  - responders are=
 grouped by priority, lowest value first (an absolute<br>    ordering, neve=
r overridden by latency or weight);<br>  - within a priority group the &quo=
t;candidates&quot; are the responders whose<br>    RTT is no more than a ma=
rgin larger than the fastest, so the fastest<br>    is always one; candidat=
es rank ahead of non-candidates;<br>  - candidates are ordered by RFC-2782 =
weighted-random selection by<br>    weight, so a server is chosen first wit=
h probability proportional to<br>    its weight (load distribution); non-ca=
ndidates follow, ordered by<br>    RTT=2E<br><br>oob_effective_margin() dec=
ides that margin: the client&#39;s --server-probe<br>value if it set one, o=
therwise the server&#39;s advertised max_latency_diff,<br>where 0 admits on=
ly the fastest responder and whatever ties with it=2E<br><br>The RNG is inj=
ected as a function pointer so this module stays free of<br>the crypto laye=
r and the weighted ordering is deterministically<br>unit-testable (the clie=
nt will pass get_random; the tests pass stubs)=2E<br><br>Exercised by unit =
tests; the client probe path calls it in a follow-up,<br>which also populat=
es RTT -- until then every responder sits in the band<br>and selection is p=
urely weighted-random=2E<br><br>Change-Id: I55da68cc341bcfc707fd34ca2f84ff9=
b6a55501f<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<b=
r>M src/openvpn/oob=2Ec<br>M src/openvpn/oob=2Eh<br>M tests/unit_tests/open=
vpn/test_oob=2Ec<br>3 files changed, 491 insertions(+), 0 deletions(-)<br><=
br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn =
refs/changes/46/1746/21</pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;"><span>diff --git a/src/openvpn/oob=2Ec b/src/open=
vpn/oob=2Ec</span><br><span>index 57542ad=2E=2E887f6de7 100644</span><br><s=
pan>--- a/src/openvpn/oob=2Ec</span><br><span>+++ b/src/openvpn/oob=2Ec</sp=
an><br><span>@@ -146,3 +146,169 @@</span><br><span>     return oob_timestam=
p_in_window(param=2Etimestamp, now, window_secs) ? OOB_PROBE_OK</span><br><=
span>                                                                      =
 : OOB_PROBE_STALE;</span><br><span> }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/* Base ordering: responders before non-responders, then by priority (lower=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * first), then by =
RTT (lower first), then by original index for determinism=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * This groups responders into pri=
ority runs pre-sorted by RTT, which the</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * candidate-band step below relies on (run[0] is the f=
astest in its group)=2E */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oo=
b_probe_result_compare(const void *a, const void *b)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    const struct oob_probe_result *ra =3D a;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    const struct oob_probe_result =
*rb =3D b;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (ra-&gt;responded &am=
p;&amp; rb-&gt;responded)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
/* both answered: lowest priority first, then lowest RTT */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (ra-&gt;reply=2Epriority=
 !=3D rb-&gt;reply=2Epriority)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            return ra-&gt;reply=2Epriority &lt; rb-&gt;reply=2Epriority ? =
-1 : 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (ra-&gt;rtt=
_ms !=3D rb-&gt;rtt_ms)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      return ra-&gt;rtt_ms &lt; rb-&gt;rtt_ms ? -1 : 1;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    else if (ra-&gt;responded)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        return -1; /* only a answered: it ranks first */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else if (rb-&gt;responded)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        return 1; /* only b answered */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* neither answered, or all keys equal: keep the conf=
igured order */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return ra-&gt;index - rb-&gt;index;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+oob_effective_margin(const struct oob=
_probe_result *r, int client_margin)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (client_margin &gt;=3D 0)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      return client_margin;              /* the client&#39;s own setting is=
 authoritative */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (int)=
r-&gt;reply=2Emax_latency_diff; /* else what the fastest remote advertised =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/* Reorder the index list idx[0=2E=2Em) into DNS-SRV (=
RFC 2782) weighted-random</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * order by results[idx[k]]=2Ereply=2Eweight: each position is filled=
 by a remaining entry</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * chosen with probability proportional to its weight=2E When all remaini=
ng</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * weights are 0 =
the current (RTT-sorted) order is kept=2E */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+oob_weighted_order(const struct oob_probe_result *results,=
 int *idx, int m, int64_t (*rng)(void))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    for (int pos =3D 0; pos &lt; m; pos++)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        long sum =3D 0;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        for (int k =3D pos; k &lt; m; k++)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            sum +=3D results[idx[k]]=2Ereply=2E=
weight;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        int chosen =3D=
 pos;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (su=
m &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            int64_t =
r =3D rng() % sum; /* uniform in [0, sum) */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            long acc =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            for (int k =3D pos; k &lt; m;=
 k++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                acc =
+=3D results[idx[k]]=2Ereply=2Eweight;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                if (acc &gt; r)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                    chosen =3D k;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                    break;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* Move the chosen entry to pos a=
nd shift the ones it jumped over down</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+         * by one=2E RFC 2782 removes the selected entry =
from the list, so the</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+         * rest keep their RTT order; a swap would fling the displaced en=
try to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * th=
e far end and can leave the fastest server tried last=2E */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        int sel =3D idx[chosen];</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (int k =3D=
 chosen; k &gt; pos; k--)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        idx[k] =3D idx[k - 1];</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        idx[pos] =3D sel;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/* Reorder one priority run (run[0=2E=2Em), =
already RTT-sorted) in place:</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * candidates (RTT within the band of the fastest) first, ordered=
 by weighted</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * rand=
om; then non-candidates in RTT order=2E */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+oob_order_priority_run(struct oob_probe_result *run, int m, =
int client_margin, int64_t (*rng)(void),</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                       struct gc_arena *gc)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (m &lt;=3D 1)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int best_r=
tt =3D run[0]=2Ertt_ms; /* run is RTT-sorted: [0] is fastest */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    int *cand =3D gc_malloc(sizeof(int) * m, false=
, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int *non =
=3D gc_malloc(sizeof(int) * m, false, gc);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    int nc =3D 0;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    int nn =3D 0;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* The band is the fastest remote&#39;s: its margin =
says how much slower another</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     * remote may be and still count as equal to it, weight then d=
eciding between</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * them=2E A slower remote&#39;s own margin plays no part=2E The comparison=
 is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * inclusive=
 (&quot;no more than max_latency_diff larger than the lowest RTT&quot;),</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * so the fastest =
is always a candidate, also when it advertises 0=2E */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    const unsigned int margin =3D (unsig=
ned int)oob_effective_margin(&amp;run[0], client_margin);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    for (int k =3D 0; k &lt; m; k++)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        unsigned int gap =3D run[k=
]=2Ertt_ms - best_rtt;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if (gap &lt;=3D margin)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            cand[nc++] =3D k;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
non[nn++] =3D k;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    oob_weighted_order(run, cand, nc, rng);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_result *tmp =3D gc_m=
alloc(sizeof(*tmp) * m, false, gc);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    int t =3D 0;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    for (int k =3D 0; k &lt; nc; k++)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        tmp[t++] =3D run[cand[k]];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    for (int k =3D 0; k &lt; nn; k++)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        tmp[t++] =3D run[non[k]];</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    memcpy(run, tmp, sizeof(*run) * m);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_rank=
_probe_results(struct oob_probe_result *results, int n, int client_margin,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
   int64_t (*rng)(void), struct gc_arena *gc)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (n &lt;=3D 1)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Base order: responders first, grou=
ped by priority, RTT-sorted within=2E */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    qsort(results, (size_t)n, sizeof(*results), oob_pr=
obe_result_compare);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Reorder eac=
h priority run of responders by candidate-band + weight=2E */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    int i =3D 0;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    while (i &lt; n &amp;&amp; resul=
ts[i]=2Eresponded)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int j =
=3D i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        while=
 (j &lt; n &amp;&amp; results[j]=2Eresponded</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+               &amp;&amp; results[j]=2Ereply=2Epri=
ority =3D=3D results[i]=2Ereply=2Epriority)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            j++;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        oob_order_priority_run(results + i, j - i, client_margin, rng, gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i =3D j;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/src/=
openvpn/oob=2Eh b/src/openvpn/oob=2Eh</span><br><span>index 21af63f=2E=2Eb9=
02363 100644</span><br><span>--- a/src/openvpn/oob=2Eh</span><br><span>+++ =
b/src/openvpn/oob=2Eh</span><br><span>@@ -177,4 +177,56 @@</span><br><span>=
 enum oob_probe_verdict oob_server_probe_check(struct buffer *probe_payload=
, uint64_t now,</span><br><span>                                           =
    uint64_t window_secs);</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/* Candidate-band margin (ms) a server advertises =
when --server-probe-reply does</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * not set one=2E Announcing 0 is a valid choice with a distinct=
 meaning -- only</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
the lowest-latency server is a candidate -- so an unconfigured server has t=
o</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * announce someth=
ing else; the spec suggests 10 to 20 ms=2E */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#define OOB_DEFAULT_LATENCY_MARGIN_MS 10</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/* Outcome of probing one remote, used to order=
 remotes best-first=2E @index is</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * the caller&#39;s identifier for the remote (e=2Eg=2E its po=
sition in the connection</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * list); priority/weight are only meaningful when @responded is true=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct oob_pr=
obe_result</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    int index;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    bool responded;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    unsigned int rtt_ms;        =
  /* probe round-trip time in ms (responders only) */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_reply reply; /* the =
values the server advertised */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * Order results best-first, in place, p=
er the server-probe selection policy:</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *   - remotes that responded rank before those that did =
not (non-responders keep</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *     their original relative order, last);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *   - responders are grouped by priority, lo=
west priority value first (an</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *     absolute ordering, never overridden by latency or weight);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   - within a pri=
ority group, the &quot;candidates&quot; are the responders whose RTT is</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *     no more than the=
 fastest remote&#39;s margin larger than its RTT (see</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *     oob_effective_margin()), so the fa=
stest is always one=2E Candidates are</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *     ordered ahead of non-candidates;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *   - candidates are ordered by DNS-=
SRV (RFC 2782) weighted-random selection by</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *     weight, so a server is chosen first with pro=
bability proportional to its</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *     weight (load distribution)=2E Non-candidates follow, ordere=
d by RTT=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param results        =
results to reorder in place</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @param n              number of results</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * @param client_margin  client&#39;s candid=
ate-band margin in ms, or &lt; 0 if the</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *                        client did not set one (see o=
ob_effective_margin())</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @param rng            returns a non-negative random value (e=2Eg=2E g=
et_random);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *      =
                 injected so this module stays free of the crypto layer</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *                     =
  and the weighted ordering is deterministically testable</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param gc             arena for sc=
ratch allocation</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void oob_rank_probe=
_results(struct oob_probe_result *results, int n, int client_margin,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
  int64_t (*rng)(void), struct gc_arena *gc);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The ca=
ndidate-band margin (ms) of a priority group -- how much slower than</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * the group&#39;s fastest=
 remote another remote may be and still be a candidate=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * The client&#39;s own setting is au=
thoritative; when client_margin &lt; 0 the</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * max_latency_diff advertised by the fastest remote=
 (r) applies to the whole</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * group=2E 0 then admits only remotes tying the fastest=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+int oob_effective_margin(const struct oob_pro=
be_result *r, int client_margin);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span> #endif /* OOB_H */</span><br><span>diff --g=
it a/tests/unit_tests/openvpn/test_oob=2Ec b/tests/unit_tests/openvpn/test_=
oob=2Ec</span><br><span>index 6fcf084=2E=2E87ff9cb 100644</span><br><span>-=
-- a/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>+++ b/tests/unit=
_tests/openvpn/test_oob=2Ec</span><br><span>@@ -614,6 +614,267 @@</span><br=
><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/* Deterministic RNG stubs f=
or the weighted-selection ordering=2E rank_rng_zero</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * makes the weighted draw always pick th=
e first remaining candidate, preserving</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * order; rank_rng_fixed returns a value we set to land=
 in a chosen weight slice=2E */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+static int64_t</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+rank_rng_zero(void)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return =
0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+static int64_t rank_rng_value;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static int64_t</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+rank_rng_fixed(void)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return rank_rng_value;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Picking a weigh=
ted entry must not disturb the RTT order of the entries it</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * was picked ahead of: RFC 2782 rem=
oves the selection, it does not swap=2E */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+test_rank_weighted_keeps_rtt_order_of_rest(void **state)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* same priority, al=
l in band; only the slowest advertises a weight, so it</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * is drawn first and the two weight=
-0 entries must follow in RTT order=2E */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct oob_probe_result r[] =3D {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        { =2Eindex =3D 0, =2Erespon=
ded =3D true, =2Ertt_ms =3D 20, =2Ereply =3D { =2Epriority =3D 10, =2Eweigh=
t =3D 0 } },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 { =2Eindex =3D 1, =2Eresponded =3D true, =2Ertt_ms =3D 30, =2Ereply =3D { =
=2Epriority =3D 10, =2Eweight =3D 0 } },</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        { =2Eindex =3D 2, =2Eresponded =3D true, =2Ert=
t_ms =3D 40, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 10 } },</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    rank_rng_value =3D 0;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    oob_rank_probe_results(r, 3, 100, rank_rng_fixe=
d, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(r[0]=
=2Eindex, 2); /* the only weighted entry wins the draw */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(r[1]=2Eindex, 0)=
; /* 20 ms before 30 ms */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_int_equal(r[2]=2Eindex, 1);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/* Responders rank ahead of =
non-responders regardless of index order=2E */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+test_rank_responder_before_nonresponder(void **state)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_re=
sult r[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   { =2Eindex =3D 0, =2Eresponded =3D false },</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        { =2Eindex =3D 1, =2Eresponded =3D true,=
 =2Ereply =3D { =2Epriority =3D 100, =2Eweight =3D 50 } },</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    oob_rank_probe_results(r, 2, 10, rank_rng_zer=
o, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_int_equal(r[0]=2Eindex, 1);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_int_equal(r[1]=2Eindex, 0);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* =
Among responders, the lowest priority value wins (an absolute ordering)=2E =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+test_rank_by_priority(voi=
d **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D =
gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 oob_probe_result r[] =3D {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        { =2Eindex =3D 0, =2Eresponded =3D true, =2Ereply =3D { =2E=
priority =3D 20, =2Eweight =3D 50 } },</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        { =2Eindex =3D 1, =2Eresponded =3D true, =2Erepl=
y =3D { =2Epriority =3D 5, =2Eweight =3D 50 } },</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        { =2Eindex =3D 2, =2Eresponded =3D tru=
e, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 50 } },</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    oob_rank_probe_results(r, 3, 10, rank_rng_ze=
ro, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_int_equal(r[0]=2Eindex, 1); /* priority 5 */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_int_equal(r[1]=2Eindex, 2); /* pri=
ority 10 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_int_equal(r[2]=2Eindex, 0); /* priority 20 */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Wit=
hin a priority, only servers within the latency margin of the fastest are</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * candidates; a slow=
er (out-of-band) server ranks behind a faster one no matter</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * how large its weight=2E */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+test_rank_candidate_band(void **s=
tate)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_ne=
w();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_=
probe_result r[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        { =2Eindex =3D 0, =2Eresponded =3D true, =2Ertt_ms =3D 100, =2Er=
eply =3D { =2Epriority =3D 10, =2Eweight =3D 1000 } },</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        { =2Eindex =3D 1, =2Eresponded =
=3D true, =2Ertt_ms =3D 20, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =
=3D 1 } },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* margin 10ms: 20=
ms is fastest; 100ms is 80ms slower -&gt; out of band */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    oob_rank_probe_results(r, 2, 10, r=
ank_rng_zero, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_int_equal(r[0]=2Eindex, 1); /* fast, in-band, despite tiny w=
eight */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
int_equal(r[1]=2Eindex, 0); /* slow, out-of-band, despite huge weight */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/* A server widens its own band via the advertised max_la=
tency_diff, joining the</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * candidate set even when it is well behind the fastest; it then parti=
cipates in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the we=
ighted selection=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/* A client margin, even 0, overrides whatever the servers advertise=2E =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+test_rank_client_margin_o=
verrides_advertised(void **state)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct oob_probe_result r[] =3D {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        { =2Eindex =3D 0, =2Eresponded =3D t=
rue, =2Ertt_ms =3D 20, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 1 }=
 },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        { =2Eind=
ex =3D 1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
=2Eresponded =3D true,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+          =2Ertt_ms =3D 100,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+          =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 1000=
, =2Emax_latency_diff =3D 200 } },</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* With the advertised 200 ms the slow server would be a candidate (s=
ee</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * test_rank_=
advertised_margin); the client&#39;s 0 leaves only the fastest=2E */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    rank_rng_value =3D 500=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    oob_rank_probe=
_results(r, 2, 0, rank_rng_fixed, &amp;gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_int_equal(r[0]=2Eindex, 0);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(r[1]=2Einde=
x, 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&=
amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+test_rank_advertised_margin(void **state)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_result r[] =3D=
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        { =2Einde=
x =3D 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
=2Eresponded =3D true,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+          =2Ertt_ms =3D 20,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+          =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 1, =
=2Emax_latency_diff =3D 200 } },</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        { =2Eindex =3D 1, =2Eresponded =3D true, =2Ertt_ms =3D=
 100, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 1000 } },</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Client did not set a margin (-1), =
so the fastest server&#39;s advertised</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+     * value applies: it says 200, so the 100ms server i=
s a candidate 80ms</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    * behind it; with weight 1000 (slice [1,1001)) a draw of 500 selects it=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * first=2E */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rank_rng_value =
=3D 500;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    oob_ran=
k_probe_results(r, 2, -1, rank_rng_fixed, &amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(r[0]=2Eindex, 1);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/* A slower server&#39;s own margin does not admit it: wi=
th the fastest advertising</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * 0, the 100ms server is no candidate however wide its margin or he=
avy its</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * weight=2E=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+test_rank_slower_servers=
_margin_has_no_effect(void **state)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct oob_probe_result r[] =3D {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        { =2Eindex =3D 0, =2Eresponded =
=3D true, =2Ertt_ms =3D 20, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =
=3D 1 } },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
 =2Eindex =3D 1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
       =2Eresponded =3D true,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+          =2Ertt_ms =3D 100,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+          =2Ereply =3D { =2Epriority =3D 10, =2Eweight =
=3D 1000, =2Emax_latency_diff =3D 200 } },</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    rank_rng_value =3D 500;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    oob_rank_probe_results(r, 2, -1, rank_rng_fixed, &amp=
;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int=
_equal(r[0]=2Eindex, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/* Among candidates, weight dr=
ives RFC-2782 proportional selection: a draw is</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * mapped to the server whose cumulative weight=
 slice it falls in=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tes=
t_rank_weighted_selection(void **state)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* equal priority and RTT -&gt; both in band; weight=
s 30 and 70, sum 100:</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     * index 0 owns [0,30), index 1 owns [30,100)=2E */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    const struct oob_probe_result bas=
e[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        { =
=2Eindex =3D 0, =2Eresponded =3D true, =2Ertt_ms =3D 20, =2Ereply =3D { =2E=
priority =3D 10, =2Eweight =3D 30 } },</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        { =2Eindex =3D 1, =2Eresponded =3D true, =2Ertt_=
ms =3D 20, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 70 } },</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_result r[2];</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    memcpy(r, base, sizeof(base));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    rank_rng_value =3D 10; /* =
falls in index 0&#39;s slice */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    oob_rank_probe_results(r, 2, 50, rank_rng_fixed, &amp;gc);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal=
(r[0]=2Eindex, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(r, base, =
sizeof(base));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
ank_rng_value =3D 50; /* falls in index 1&#39;s slice */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    oob_rank_probe_results(r, 2, 50, r=
ank_rng_fixed, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_int_equal(r[0]=2Eindex, 1);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/* The fastest advertising 0 m=
eans &quot;compare on latency alone&quot;: the band is</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * empty, so weight cannot float a slowe=
r peer ahead of it=2E The same pair with a</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * band advertised does let weight decide=2E */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+test_rank_advertised_zero_margin=
(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =
=3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst struct oob_probe_result base[] =3D {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        { =2Eindex =3D 0, =2Eresponded =3D true, =2Ert=
t_ms =3D 20, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 1 } },</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        { =2Eindex =3D 1, =
=2Eresponded =3D true, =2Ertt_ms =3D 40, =2Ereply =3D { =2Epriority =3D 10,=
 =2Eweight =3D 1000 } },</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct oob_probe_result r[2];</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(r,=
 base, sizeof(base));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    rank_rng_value =3D 500;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    oob_rank_probe_results(r, 2, -1, rank_rng_fixed, &amp;gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(r=
[0]=2Eindex, 0); /* both advertise 0 -&gt; fastest wins */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    memcpy(r, base, sizeof(base));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    r[0]=2Ereply=2Emax_latency_diff =3D =
50;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r[1]=2Ereply=
=2Emax_latency_diff =3D 50;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    rank_rng_value =3D 500;            /* falls in the weight-1000 =
slice [1,1001) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  oob_rank_probe_results(r, 2, -1, rank_rng_fixed, &amp;gc);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(r[0]=2Eindex,=
 1); /* 20ms behind but inside a 50ms band */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/* Remotes tied at the faste=
st RTT are all candidates even at margin 0, so weight</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * still distributes load between them=2E=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+test_rank_zero_margin_we=
ights_ties(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc=
_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct oob_probe_result r[] =3D {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        { =2Eindex =3D 0, =2Eresponded =3D true, =2Er=
tt_ms =3D 20, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 1, =2Emax_la=
tency_diff =3D 0 } },</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        { =2Eindex =3D 1, =2Eresponded =3D true, =2Ertt_ms =3D 20, =2Erep=
ly =3D { =2Epriority =3D 10, =2Eweight =3D 1000, =2Emax_latency_diff =3D 0 =
} },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    rank_rng_value =3D 500; =
/* falls in the weight-1000 slice [1,1001) */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    oob_rank_probe_results(r, 2, -1, rank_rng_fix=
ed, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_int_equal(r[0]=2Eindex, 1);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A remote exactly it=
s advertised margin behind the fastest is still a candidate</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * (&quot;no more than max_latency_=
diff larger than the lowest RTT&quot;)=2E */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+test_rank_margin_boundary_is_inclusive(void **state)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_res=
ult r[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  { =2Eindex =3D 0, =2Eresponded =3D true, =2Ertt_ms =3D 20, =2Ereply =3D {=
 =2Epriority =3D 10, =2Eweight =3D 1, =2Emax_latency_diff =3D 10 } },</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        { =2Eindex =3D 1,=
 =2Eresponded =3D true, =2Ertt_ms =3D 30, =2Ereply =3D { =2Epriority =3D 10=
, =2Eweight =3D 1000, =2Emax_latency_diff =3D 10 } },</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    rank_rng_value =3D 500;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    oob_rank_probe_results(r, 2, -1, rank_rng_=
fixed, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_int_equal(r[0]=2Eindex, 1); /* exactly 10ms behind, in band, wins o=
n weight */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_f=
ree(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* Non-responders are placed last, keepin=
g their original relative order=2E */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+test_rank_nonresponders_last(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_result r[] =3D {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        { =2Eindex =3D =
0, =2Eresponded =3D false },</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        { =2Eindex =3D 1, =2Eresponded =3D true, =2Ertt_ms =3D 20,=
 =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 50 } },</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        { =2Eindex =3D 2, =2Eresponde=
d =3D false },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   { =2Eindex =3D 3, =2Eresponded =3D true, =2Ertt_ms =3D 20, =2Ereply =3D =
{ =2Epriority =3D 10, =2Eweight =3D 50 } },</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    oob_rank_probe_results(r, 4, 10, rank_rng_zero, &amp;gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(r=
[0]=2Eindex, 1); /* responder (rng_zero keeps order) */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(r[1]=2Eindex, 3); =
/* responder */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_int_equal(r[2]=2Eindex, 0); /* non-responder, original order kept */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equa=
l(r[3]=2Eindex, 2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
> /* The OOB tests run as a second group of pkt_testdriver; see test_pkt=2E=
c=2E */</span><br><span> int</span><br><span> run_oob_tests(void)</span><br=
><span>@@ -644,6 +905,18 @@</span><br><span>         cmocka_unit_test(test_=
client_reply_read_rejects_unknown_mandatory),</span><br><span>         cmoc=
ka_unit_test(test_client_reply_read_missing),</span><br><span>         cmoc=
ka_unit_test(test_client_reply_read_wrong_msg_type),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_rank_respon=
der_before_nonresponder),</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        cmocka_unit_test(test_rank_by_priority),</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_rank_candi=
date_band),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
cmocka_unit_test(test_rank_advertised_margin),</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_rank_client_margin=
_overrides_advertised),</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        cmocka_unit_test(test_rank_advertised_zero_margin),</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_r=
ank_slower_servers_margin_has_no_effect),</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        cmocka_unit_test(test_rank_zero_margin_weight=
s_ties),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmo=
cka_unit_test(test_rank_margin_boundary_is_inclusive),</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_rank_weigh=
ted_selection),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    cmocka_unit_test(test_rank_weighted_keeps_rtt_order_of_rest),</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test=
_rank_nonresponders_last),</span><br><span>     };</span><br><span> </span>=
<br><span>     return cmocka_run_group_tests_name(&quot;oob tests&quot;, te=
sts, NULL, NULL);</span><br><span></span><br></pre><p>To view, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1746?usp=3Demail">change 174=
6</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><di=
v itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1746?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"d=
isplay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> G=
errit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: =
I55da68cc341bcfc707fd34ca2f84ff9b6a55501f </div>
<div style=3D"display:none=
"> Gerrit-Change-Number: 1746 </div>
<div style=3D"display:none"> Gerrit-Pa=
tchSet: 21 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lsti=
pakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>

</bo=
dy></html>
--6xYnELYzPok=--


--===============6115943114606647007==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6115943114606647007==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6115943114606647007==--

