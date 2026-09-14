Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE5AC982C4
	for <openvpn-devel@archiver.kernel.org>; Mon, 14 Sep 2026 14:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yLzaboLu1IKQ/9yeFib81VbcOTWXfbc1ZQ8YzEduCXs=; b=SkuXj1CWokvB0nnu9v7gUmEMws
	OJSOQkVDc1aKerYp/jqRHsGCrGPQ1KOuQ48e+nA25DQp0liuHWCZl5X6lfun2HlTqP7EzMdSd4luD
	Ip+GWinlE0HlvwU0X+HcKif1Q9xcYg1mlWkYJdw988TnXNOgTKCf7s7r+4cwd4rV3Rw8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x67Wc-0006fu-32;
	Mon, 14 Sep 2026 14:19:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x67WY-0006fY-8B
 for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 14:19:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=BfL8aDdZ2GsAGy+CnamZ1iXNrYtGHQ3KxLpx04lJaQ4=; b=XW2nFaWCkQ0Tc3crOaP/VkDM6Y
 nmXSt6YQEBVHIHJjw2kiIg97zAqhd1ainfvEa2z9+Zr4RbN/PfPW2OkXrkcttSOs1jSl97oy82LX5
 FpMFYldKXRfyPydmjlH4prslheXFsvRc1MMoutSpC38tL0PUBRPLOLzXDKCdqgdNK5IM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=BfL8aDdZ2GsAGy+CnamZ1iXNrYtGHQ3KxLpx04lJaQ4=; b=h
 rA9S0nPr79JFaYVEOZlrA3p0+vY+j2DfTWdL+JgJNqKjCGPhYd0XYF9LrcZ02fF+amGEOftuLjHqC
 fG+3KzHjfrf3/IC+LdQdQ1bnDjbv3tzsW7mqHyjWuoskxR9eGb/0ORKYIZz8b2iIp+ENMC33D4JVt
 aEYvV8qkwn5cMk0k=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x67WI-0001Rt-3Z for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 14:19:10 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-484366874b0so1163085f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 14 Sep 2026 07:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789395527; x=1790000327; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BfL8aDdZ2GsAGy+CnamZ1iXNrYtGHQ3KxLpx04lJaQ4=;
 b=BDWKoIWQZjRk7vDN4Thjj8EqrH1VsdUjyeYZNZFgFj0iCS4zu0f2BRgzOAbIdFwpK/
 QMRvkn7seva5vJU+HwtWEWVtQneVxr14LqV5cTwOq9MTDm1unYol1rQqFD3tXuGvcSI9
 EXcBsQTXeWmEPjWyuzQ6IpTRqXge7eZVD64dCpyFfUlQLBhmOA1wx/nRn3Mm1Aolj5WH
 TAyamecVmGxspvf3U3MKO2urKDUXzA5HBuKv1LtGe+eW7DmeFxI6ofRNrvLiIiTGhNc6
 WeV2hlsUcULXX3UR+x20VHDMJwWg3G2d76H+nIXL5AsXRoR3YSUTnhgNBUJsBjldZAxO
 XaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789395527; x=1790000327;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BfL8aDdZ2GsAGy+CnamZ1iXNrYtGHQ3KxLpx04lJaQ4=;
 b=lnlL6Qo2zTaZzHNjaTLV8b0DDgfTrybnQEs8Z9NePWgLpi9pUrHk3jrzgg+2zg7aoS
 nOD/7MJQjGzmFjbNTARFNfnHL+ToAcxJQi2FBwF+9+/TGD2se3rYcJCrZSzTXFGCVkDw
 iLKTVPALjkMLt2yHKwO3LNkKXaTcABQxjGDVud4KDUl1xwtjHHyUoCrgv3q95yftA0Rd
 DPgdi96XSSve8yD8KUox166CDXFeiNVWFQqBYvb56JnIL6p9ViSedTFweveCNETjTfa4
 r8SbpTb8oBGDtMLId9AXn181+RyEkLRTLDcMuwWiXXahEGfZATsMQhynjG9wIl+Y8K6O
 mw/w==
X-Gm-Message-State: AFuF++nC7MWPmrX74nsbSEHxxrIGD2ctQcadKVZ9aO1ugogezocEH5Li
 FA+hSFw3NAL/SPYaJVJdsfAec7LDtqWkV88zPvGiKUkjWkOZILEu8x7llJF8Tdbq6x8fLW9b1DX
 F9c8EicexFRxa8a7ab4ZN9n00EVtQhb/UmL2NLdfref4W4zKvvMhxG5i7oL2lONelYhvM
X-Gm-Gg: AYBFou2GRhxw45LWgxF2INV3qmm9Vw8GHhRwXmpPshY5D+tEfTjGv4oCoW4oDhKCK+0
 Nuk2c379R8eB9/3Q+EnugaeYQkEdL3uNcO84ot/BzWCHZTZjhIfiztkpu0vVOu0w2zD7/C9QXGo
 nBxLFO28NLxRDqJUnfUPfWIEcw3Dtwno3ORlUy0En3ntATnq1o1l3Enw2/KB7/wt/d0waT8w9jK
 6416Rx9+AKbRbEaCbl52+2aQLsQafvatqtNygroprQMkypirrzyeQ6why1WnsLejVHtxiKt125n
 0JuHRmp6U3/D7tPElPJTa/Vh9R0dqzIZn92RyBYc3fNH7COCxk3DZ4rsWHH/gQDupIJUvnc64mS
 jE67dzUfSkoRTnK7bqBtFi/ZMsRIo/8drTIpuQiAv7YwiYKEmIyU2KrHbjP84e5gNaPEiLdMsnI
 Tt7U/9NQ915bL6WKoOL5NTgBzqjDadNS9lkQ0ncWk3tY72FhHJbSQQcZvgels/gcIa4OAkIKk5P
 qHv5V+TsVDjbKgf3q1loISvHPBIA0M2iV1519K4t2eF+fX+Zuh5FXnpVhhMuiQb7dvLuRZNjCIO
 zvlDqIaM50qKxTph6gR9gTer5HuYnZbodrG1cZvHN6zVlvDwuiBK16GAmq7D9g==
X-Received: by 2002:a05:6000:471a:b0:485:892b:bdad with SMTP id
 ffacd0b85a97d-48702b0c8d1mr7452858f8f.12.1789395527059; 
 Mon, 14 Sep 2026 07:18:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb350686sm30084601f8f.27.2026.09.14.07.18.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 07:18:46 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 14 Sep 2026 14:18:32 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 17
X-Gerrit-Change-Id: I55da68cc341bcfc707fd34ca2f84ff9b6a55501f
X-Gerrit-Change-Number: 1746
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1746?usp=email>
X-Gerrit-Commit: 59fcf447804ec104eda104c0c9fb99db61d40348
In-Reply-To: <gerrit.1782719911000.I55da68cc341bcfc707fd34ca2f84ff9b6a55501f@gerrit.openvpn.net>
References: <gerrit.1782719911000.I55da68cc341bcfc707fd34ca2f84ff9b6a55501f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk1NWRhNjhjYzM0MWJjZmM3MDdmZDM0Y2EyZjg0ZmY5YjZhNTU1MDFmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <874a4695b58dad3da57fa9d9b86704fa02e2f63e-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x67WI-0001Rt-3Z
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
Content-Type: multipart/mixed; boundary="===============5308850040036013276=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5308850040036013276==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bSqxvh78aKI="; charset=UTF-8

--bSqxvh78aKI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici, stipa=2E

Hello=
 plaisthos, ralf_lici, 

I'd like you to reexamine a change=2E Please visit=


    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1746?usp=3Demail

to look a=
t the new patch set (#17)=2E


Change subject: oob: Add probe-result rankin=
g for server selection
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

oob: Add probe-result ranking for server selection

Add oob_rank=
_probe_results(), which orders remotes best-first from their
probe results,=
 following the DNS-SRV (RFC 2782) semantics of the
probe_reply TLV:

  - re=
motes that answered rank before those that did not (non-responders
    keep=
 their original relative order, last);
  - responders are grouped by priori=
ty, lowest value first (an absolute
    ordering, never overridden by laten=
cy or weight);
  - within a priority group the "candidates" are the respond=
ers whose
    RTT is no more than a margin larger than the fastest, so the =
fastest
    is always one; candidates rank ahead of non-candidates;
  - can=
didates are ordered by RFC-2782 weighted-random selection by
    weight, so=
 a server is chosen first with probability proportional to
    its weight (=
load distribution); non-candidates follow, ordered by
    RTT=2E

oob_effec=
tive_margin() decides that margin: the client's --server-probe
value if it =
set one, otherwise the server's advertised max_latency_diff,
where 0 admits=
 only the fastest responder and whatever ties with it=2E

The RNG is inject=
ed as a function pointer so this module stays free of
the crypto layer and =
the weighted ordering is deterministically
unit-testable (the client will p=
ass get_random; the tests pass stubs)=2E

Exercised by unit tests; the clie=
nt probe path calls it in a follow-up,
which also populates RTT -- until th=
en every responder sits in the band
and selection is purely weighted-random=
=2E

Change-Id: I55da68cc341bcfc707fd34ca2f84ff9b6a55501f
Signed-off-by: Le=
v Stipakov <lev@openvpn=2Enet>
---
M src/openvpn/oob=2Ec
M src/openvpn/oob=
=2Eh
M tests/unit_tests/openvpn/test_oob=2Ec
3 files changed, 486 insertion=
s(+), 0 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/46/1746/17

diff --git a/src/openvpn/oob=2Ec b/src/openvpn/o=
ob=2Ec
index 45e3908=2E=2Ec0c8955 100644
--- a/src/openvpn/oob=2Ec
+++ b/sr=
c/openvpn/oob=2Ec
@@ -147,3 +147,167 @@
     /* Drop replayed or implausibl=
y-timed probes before doing any more work=2E */
     return oob_timestamp_i=
n_window(param=2Etimestamp, now, window_secs);
 }
+
+/* Base ordering: resp=
onders before non-responders, then by priority (lower
+ * first), then by R=
TT (lower first), then by original index for determinism=2E
+ * This groups=
 responders into priority runs pre-sorted by RTT, which the
+ * candidate-b=
and step below relies on (run[0] is the fastest in its group)=2E */
+static=
 int
+oob_probe_result_compare(const void *a, const void *b)
+{
+    const =
struct oob_probe_result *ra =3D a;
+    const struct oob_probe_result *rb =
=3D b;
+
+    if (ra->responded && rb->responded)
+    {
+        /* both a=
nswered: lowest priority first, then lowest RTT */
+        if (ra->reply=
=2Epriority !=3D rb->reply=2Epriority)
+        {
+            return ra->r=
eply=2Epriority < rb->reply=2Epriority ? -1 : 1;
+        }
+        if (ra=
->rtt_ms !=3D rb->rtt_ms)
+        {
+            return ra->rtt_ms < rb->r=
tt_ms ? -1 : 1;
+        }
+    }
+    else if (ra->responded)
+    {
+    =
    return -1; /* only a answered: it ranks first */
+    }
+    else if (r=
b->responded)
+    {
+        return 1; /* only b answered */
+    }
+
+   =
 /* neither answered, or all keys equal: keep the configured order */
+    =
return ra->index - rb->index;
+}
+
+int
+oob_effective_margin(const struct =
oob_probe_result *r, int client_margin)
+{
+    if (client_margin >=3D 0)
+=
    {
+        return client_margin;              /* the client's own setti=
ng is authoritative */
+    }
+    return (int)r->reply=2Emax_latency_diff;=
 /* else the server's advertised value */
+}
+
+/* Reorder the index list i=
dx[0=2E=2Em) into DNS-SRV (RFC 2782) weighted-random
+ * order by results[i=
dx[k]]=2Ereply=2Eweight: each position is filled by a remaining entry
+ * c=
hosen with probability proportional to its weight=2E When all remaining
+ *=
 weights are 0 the current (RTT-sorted) order is kept=2E */
+static void
+o=
ob_weighted_order(const struct oob_probe_result *results, int *idx, int m, =
int64_t (*rng)(void))
+{
+    for (int pos =3D 0; pos < m; pos++)
+    {
+ =
       long sum =3D 0;
+        for (int k =3D pos; k < m; k++)
+        {
=
+            sum +=3D results[idx[k]]=2Ereply=2Eweight;
+        }
+       =
 int chosen =3D pos;
+        if (sum > 0)
+        {
+            int64_t =
r =3D rng() % sum; /* uniform in [0, sum) */
+            long acc =3D 0;
+=
            for (int k =3D pos; k < m; k++)
+            {
+               =
 acc +=3D results[idx[k]]=2Ereply=2Eweight;
+                if (acc > r)
+=
                {
+                    chosen =3D k;
+                    b=
reak;
+                }
+            }
+        }
+        /* Move the cho=
sen entry to pos and shift the ones it jumped over down
+         * by one=
=2E RFC 2782 removes the selected entry from the list, so the
+         * r=
est keep their RTT order; a swap would fling the displaced entry to
+      =
   * the far end and can leave the fastest server tried last=2E */
+       =
 int sel =3D idx[chosen];
+        for (int k =3D chosen; k > pos; k--)
+  =
      {
+            idx[k] =3D idx[k - 1];
+        }
+        idx[pos] =
=3D sel;
+    }
+}
+
+/* Reorder one priority run (run[0=2E=2Em), already R=
TT-sorted) in place:
+ * candidates (RTT within the band of the fastest) fi=
rst, ordered by weighted
+ * random; then non-candidates in RTT order=2E */=

+static void
+oob_order_priority_run(struct oob_probe_result *run, int m, =
int client_margin, int64_t (*rng)(void),
+                       struct gc_=
arena *gc)
+{
+    if (m <=3D 1)
+    {
+        return;
+    }
+
+    unsi=
gned int best_rtt =3D run[0]=2Ertt_ms; /* run is RTT-sorted: [0] is fastest=
 */
+
+    int *cand =3D gc_malloc(sizeof(int) * m, false, gc);
+    int *n=
on =3D gc_malloc(sizeof(int) * m, false, gc);
+    int nc =3D 0;
+    int n=
n =3D 0;
+    for (int k =3D 0; k < m; k++)
+    {
+        /* "no more tha=
n their max_latency_diff larger than the lowest RTT", so the
+         * co=
mparison includes the margin itself=2E That also keeps the fastest of
+    =
     * the run a candidate when it advertises 0: announcing 0 asks not to b=
e
+         * compared on weight, not to be ranked behind a slower server=
=2E */
+        unsigned int gap =3D run[k]=2Ertt_ms - best_rtt;
+        i=
f (gap <=3D (unsigned int)oob_effective_margin(&run[k], client_margin))
+  =
      {
+            cand[nc++] =3D k;
+        }
+        else
+        {
=
+            non[nn++] =3D k;
+        }
+    }
+
+    oob_weighted_order(r=
un, cand, nc, rng);
+
+    struct oob_probe_result *tmp =3D gc_malloc(sizeo=
f(*tmp) * m, false, gc);
+    int t =3D 0;
+    for (int k =3D 0; k < nc; k=
++)
+    {
+        tmp[t++] =3D run[cand[k]];
+    }
+    for (int k =3D 0=
; k < nn; k++)
+    {
+        tmp[t++] =3D run[non[k]];
+    }
+    memcpy=
(run, tmp, sizeof(*run) * m);
+}
+
+void
+oob_rank_probe_results(struct oob=
_probe_result *results, int n, int client_margin,
+                       i=
nt64_t (*rng)(void), struct gc_arena *gc)
+{
+    if (n <=3D 1)
+    {
+   =
     return;
+    }
+
+    /* Base order: responders first, grouped by prio=
rity, RTT-sorted within=2E */
+    qsort(results, (size_t)n, sizeof(*result=
s), oob_probe_result_compare);
+
+    /* Reorder each priority run of respo=
nders by candidate-band + weight=2E */
+    int i =3D 0;
+    while (i < n =
&& results[i]=2Eresponded)
+    {
+        int j =3D i;
+        while (j <=
 n && results[j]=2Eresponded
+               && results[j]=2Ereply=2Epriori=
ty =3D=3D results[i]=2Ereply=2Epriority)
+        {
+            j++;
+    =
    }
+        oob_order_priority_run(results + i, j - i, client_margin, rn=
g, gc);
+        i =3D j;
+    }
+}
diff --git a/src/openvpn/oob=2Eh b/src/=
openvpn/oob=2Eh
index 2c69fb6=2E=2Ee637b90 100644
--- a/src/openvpn/oob=2Eh=

+++ b/src/openvpn/oob=2Eh
@@ -172,4 +172,56 @@
  */
 bool oob_server_probe=
_accept(struct buffer *probe_payload, uint64_t now, uint64_t window_secs);
=
 
+/* Candidate-band margin (ms) a server advertises when --server-probe-re=
ply does
+ * not set one=2E Announcing 0 is a valid choice with a distinct =
meaning -- only
+ * the lowest-latency server is a candidate -- so an uncon=
figured server has to
+ * announce something else; the spec suggests 10 to =
20 ms=2E */
+#define OOB_DEFAULT_LATENCY_MARGIN_MS 10
+
+/* Outcome of prob=
ing one remote, used to order remotes best-first=2E @index is
+ * the calle=
r's identifier for the remote (e=2Eg=2E its position in the connection
+ * =
list); priority/weight are only meaningful when @responded is true=2E */
+s=
truct oob_probe_result
+{
+    int index;
+    bool responded;
+    unsigne=
d int rtt_ms;          /* probe round-trip time in ms (responders only) */
=
+    struct oob_probe_reply reply; /* the values the server advertised */
+=
};
+
+/**
+ * Order results best-first, in place, per the server-probe sele=
ction policy:
+ *   - remotes that responded rank before those that did not=
 (non-responders keep
+ *     their original relative order, last);
+ *   -=
 responders are grouped by priority, lowest priority value first (an
+ *   =
  absolute ordering, never overridden by latency or weight);
+ *   - within=
 a priority group, the "candidates" are the responders whose RTT is
+ *    =
 no more than a margin larger than the fastest in the group (see
+ *     oo=
b_effective_margin()), so the fastest is always one=2E Candidates are
+ *  =
   ordered ahead of non-candidates;
+ *   - candidates are ordered by DNS-S=
RV (RFC 2782) weighted-random selection by
+ *     weight, so a server is c=
hosen first with probability proportional to its
+ *     weight (load distr=
ibution)=2E Non-candidates follow, ordered by RTT=2E
+ *
+ * @param results=
        results to reorder in place
+ * @param n              number of res=
ults
+ * @param client_margin  client's candidate-band margin in ms, or < 0=
 if the
+ *                        client did not set one (see oob_effectiv=
e_margin())
+ * @param rng            returns a non-negative random value (=
e=2Eg=2E get_random);
+ *                       injected so this module sta=
ys free of the crypto layer
+ *                       and the weighted orde=
ring is deterministically testable
+ * @param gc             arena for scra=
tch allocation
+ */
+void oob_rank_probe_results(struct oob_probe_result *r=
esults, int n, int client_margin,
+                            int64_t (*rn=
g)(void), struct gc_arena *gc);
+
+/**
+ * The candidate-band margin (ms) t=
hat applies to one probed remote -- how much
+ * slower than the group's fa=
stest that remote may be and still be a candidate=2E
+ * It is per-remote: =
the client's own setting is authoritative, and when
+ * client_margin < 0 e=
ach remote is judged by the max_latency_diff its own server
+ * advertised=
=2E 0 then admits only the fastest remote and whatever ties with it=2E
+ */=

+int oob_effective_margin(const struct oob_probe_result *r, int client_mar=
gin);
+
 #endif /* OOB_H */
diff --git a/tests/unit_tests/openvpn/test_oob=
=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec
index acfd6f6=2E=2E0b0ce96 100=
644
--- a/tests/unit_tests/openvpn/test_oob=2Ec
+++ b/tests/unit_tests/open=
vpn/test_oob=2Ec
@@ -613,6 +613,264 @@
     gc_free(&gc);
 }
 
+/* Determin=
istic RNG stubs for the weighted-selection ordering=2E rank_rng_zero
+ * ma=
kes the weighted draw always pick the first remaining candidate, preserving=

+ * order; rank_rng_fixed returns a value we set to land in a chosen weigh=
t slice=2E */
+static int64_t
+rank_rng_zero(void)
+{
+    return 0;
+}
+
+=
static int64_t rank_rng_value;
+static int64_t
+rank_rng_fixed(void)
+{
+  =
  return rank_rng_value;
+}
+
+/* Picking a weighted entry must not disturb=
 the RTT order of the entries it
+ * was picked ahead of: RFC 2782 removes =
the selection, it does not swap=2E */
+static void
+test_rank_weighted_keep=
s_rtt_order_of_rest(void **state)
+{
+    struct gc_arena gc =3D gc_new();
=
+    /* same priority, all in band; only the slowest advertises a weight, s=
o it
+     * is drawn first and the two weight-0 entries must follow in RTT=
 order=2E */
+    struct oob_probe_result r[] =3D {
+        { =2Eindex =3D=
 0, =2Eresponded =3D true, =2Ertt_ms =3D 20, =2Ereply =3D { =2Epriority =3D=
 10, =2Eweight =3D 0 } },
+        { =2Eindex =3D 1, =2Eresponded =3D true,=
 =2Ertt_ms =3D 30, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 0 } },
=
+        { =2Eindex =3D 2, =2Eresponded =3D true, =2Ertt_ms =3D 40, =2Erepl=
y =3D { =2Epriority =3D 10, =2Eweight =3D 10 } },
+    };
+
+    rank_rng_v=
alue =3D 0;
+    oob_rank_probe_results(r, 3, 100, rank_rng_fixed, &gc);
+
=
+    assert_int_equal(r[0]=2Eindex, 2); /* the only weighted entry wins the=
 draw */
+    assert_int_equal(r[1]=2Eindex, 0); /* 20 ms before 30 ms */
+=
    assert_int_equal(r[2]=2Eindex, 1);
+
+    gc_free(&gc);
+}
+
+/* Respon=
ders rank ahead of non-responders regardless of index order=2E */
+static v=
oid
+test_rank_responder_before_nonresponder(void **state)
+{
+    struct g=
c_arena gc =3D gc_new();
+    struct oob_probe_result r[] =3D {
+        { =
=2Eindex =3D 0, =2Eresponded =3D false },
+        { =2Eindex =3D 1, =2Eres=
ponded =3D true, =2Ereply =3D { =2Epriority =3D 100, =2Eweight =3D 50 } },
=
+    };
+    oob_rank_probe_results(r, 2, 10, rank_rng_zero, &gc);
+    ass=
ert_int_equal(r[0]=2Eindex, 1);
+    assert_int_equal(r[1]=2Eindex, 0);
+  =
  gc_free(&gc);
+}
+
+/* Among responders, the lowest priority value wins (=
an absolute ordering)=2E */
+static void
+test_rank_by_priority(void **stat=
e)
+{
+    struct gc_arena gc =3D gc_new();
+    struct oob_probe_result r[=
] =3D {
+        { =2Eindex =3D 0, =2Eresponded =3D true, =2Ereply =3D { =
=2Epriority =3D 20, =2Eweight =3D 50 } },
+        { =2Eindex =3D 1, =2Eres=
ponded =3D true, =2Ereply =3D { =2Epriority =3D 5, =2Eweight =3D 50 } },
+ =
       { =2Eindex =3D 2, =2Eresponded =3D true, =2Ereply =3D { =2Epriority =
=3D 10, =2Eweight =3D 50 } },
+    };
+    oob_rank_probe_results(r, 3, 10,=
 rank_rng_zero, &gc);
+    assert_int_equal(r[0]=2Eindex, 1); /* priority 5=
 */
+    assert_int_equal(r[1]=2Eindex, 2); /* priority 10 */
+    assert_i=
nt_equal(r[2]=2Eindex, 0); /* priority 20 */
+    gc_free(&gc);
+}
+
+/* Wi=
thin a priority, only servers within the latency margin of the fastest are
=
+ * candidates; a slower (out-of-band) server ranks behind a faster one no =
matter
+ * how large its weight=2E */
+static void
+test_rank_candidate_ban=
d(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct oob_pr=
obe_result r[] =3D {
+        { =2Eindex =3D 0, =2Eresponded =3D true, =2Er=
tt_ms =3D 100, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 1000 } },
+=
        { =2Eindex =3D 1, =2Eresponded =3D true, =2Ertt_ms =3D 20, =2Ereply=
 =3D { =2Epriority =3D 10, =2Eweight =3D 1 } },
+    };
+    /* margin 10ms=
: 20ms is fastest; 100ms is 80ms slower -> out of band */
+    oob_rank_pro=
be_results(r, 2, 10, rank_rng_zero, &gc);
+    assert_int_equal(r[0]=2Einde=
x, 1); /* fast, in-band, despite tiny weight */
+    assert_int_equal(r[1]=
=2Eindex, 0); /* slow, out-of-band, despite huge weight */
+    gc_free(&gc=
);
+}
+
+/* A server widens its own band via the advertised max_latency_dif=
f, joining the
+ * candidate set even when it is well behind the fastest; i=
t then participates in
+ * the weighted selection=2E */
+/* A client margin=
, even 0, overrides whatever the servers advertise=2E */
+static void
+test=
_rank_client_margin_overrides_advertised(void **state)
+{
+    struct gc_ar=
ena gc =3D gc_new();
+    struct oob_probe_result r[] =3D {
+        { =2Ei=
ndex =3D 0, =2Eresponded =3D true, =2Ertt_ms =3D 20, =2Ereply =3D { =2Eprio=
rity =3D 10, =2Eweight =3D 1 } },
+        { =2Eindex =3D 1,
+          =2E=
responded =3D true,
+          =2Ertt_ms =3D 100,
+          =2Ereply =3D {=
 =2Epriority =3D 10, =2Eweight =3D 1000, =2Emax_latency_diff =3D 200 } },
+=
    };
+    /* With the advertised 200 ms the slow server would be a candid=
ate (see
+     * test_rank_advertised_margin); the client's 0 leaves only t=
he fastest=2E */
+    rank_rng_value =3D 500;
+    oob_rank_probe_results(r=
, 2, 0, rank_rng_fixed, &gc);
+    assert_int_equal(r[0]=2Eindex, 0);
+    =
assert_int_equal(r[1]=2Eindex, 1);
+    gc_free(&gc);
+}
+
+static void
+te=
st_rank_advertised_margin(void **state)
+{
+    struct gc_arena gc =3D gc_n=
ew();
+    struct oob_probe_result r[] =3D {
+        { =2Eindex =3D 0, =2E=
responded =3D true, =2Ertt_ms =3D 20, =2Ereply =3D { =2Epriority =3D 10, =
=2Eweight =3D 1 } },
+        { =2Eindex =3D 1,
+          =2Eresponded =3D=
 true,
+          =2Ertt_ms =3D 100,
+          =2Ereply =3D { =2Epriority =
=3D 10, =2Eweight =3D 1000, =2Emax_latency_diff =3D 200 } },
+    };
+    /=
* Client did not set a margin (-1), so each server's advertised value
+    =
 * applies: the 100ms server advertises 200 -> it is a candidate 80ms behin=
d
+     * the fastest; with weight 1000 (slice [1,1001)) a draw of 500 sele=
cts it
+     * first=2E */
+    rank_rng_value =3D 500;
+    oob_rank_probe=
_results(r, 2, -1, rank_rng_fixed, &gc);
+    assert_int_equal(r[0]=2Eindex=
, 1);
+    gc_free(&gc);
+}
+
+/* Among candidates, weight drives RFC-2782 =
proportional selection: a draw is
+ * mapped to the server whose cumulative=
 weight slice it falls in=2E */
+static void
+test_rank_weighted_selection(=
void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    /* equal priori=
ty and RTT -> both in band; weights 30 and 70, sum 100:
+     * index 0 own=
s [0,30), index 1 owns [30,100)=2E */
+    const struct oob_probe_result ba=
se[] =3D {
+        { =2Eindex =3D 0, =2Eresponded =3D true, =2Ertt_ms =3D =
20, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 30 } },
+        { =2E=
index =3D 1, =2Eresponded =3D true, =2Ertt_ms =3D 20, =2Ereply =3D { =2Epri=
ority =3D 10, =2Eweight =3D 70 } },
+    };
+    struct oob_probe_result r[=
2];
+
+    memcpy(r, base, sizeof(base));
+    rank_rng_value =3D 10; /* fa=
lls in index 0's slice */
+    oob_rank_probe_results(r, 2, 50, rank_rng_fi=
xed, &gc);
+    assert_int_equal(r[0]=2Eindex, 0);
+
+    memcpy(r, base, s=
izeof(base));
+    rank_rng_value =3D 50; /* falls in index 1's slice */
+ =
   oob_rank_probe_results(r, 2, 50, rank_rng_fixed, &gc);
+    assert_int_e=
qual(r[0]=2Eindex, 1);
+
+    gc_free(&gc);
+}
+
+/* An advertised max_late=
ncy_diff of 0 means "compare on latency alone": the
+ * server's own band i=
s empty, so weight cannot float it ahead of a faster peer=2E
+ * The same p=
air with a band advertised does let weight decide=2E */
+static void
+test_=
rank_advertised_zero_margin(void **state)
+{
+    struct gc_arena gc =3D gc=
_new();
+    const struct oob_probe_result base[] =3D {
+        { =2Eindex=
 =3D 0, =2Eresponded =3D true, =2Ertt_ms =3D 20, =2Ereply =3D { =2Epriority=
 =3D 10, =2Eweight =3D 1 } },
+        { =2Eindex =3D 1, =2Eresponded =3D t=
rue, =2Ertt_ms =3D 40, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 100=
0 } },
+    };
+    struct oob_probe_result r[2];
+
+    memcpy(r, base, si=
zeof(base));
+    rank_rng_value =3D 500;
+    oob_rank_probe_results(r, 2,=
 -1, rank_rng_fixed, &gc);
+    assert_int_equal(r[0]=2Eindex, 0); /* both =
advertise 0 -> fastest wins */
+
+    memcpy(r, base, sizeof(base));
+    r=
[0]=2Ereply=2Emax_latency_diff =3D 50;
+    r[1]=2Ereply=2Emax_latency_diff=
 =3D 50;
+    rank_rng_value =3D 500;            /* falls in the weight-100=
0 slice [1,1001) */
+    oob_rank_probe_results(r, 2, -1, rank_rng_fixed, &=
gc);
+    assert_int_equal(r[0]=2Eindex, 1); /* 20ms behind but inside a 50=
ms band */
+
+    gc_free(&gc);
+}
+
+/* The fastest remote is a candidate =
even when it advertises 0: it competes with
+ * a slower remote whose own b=
and covers the gap instead of being ranked behind
+ * it outright=2E Neithe=
r carries weight here, so the candidate order is RTT order
+ * -- had the f=
astest fallen out of the band, the slower one would lead=2E */
+static void=

+test_rank_zero_margin_keeps_fastest_a_candidate(void **state)
+{
+    str=
uct gc_arena gc =3D gc_new();
+    struct oob_probe_result r[] =3D {
+     =
   { =2Eindex =3D 0, =2Eresponded =3D true, =2Ertt_ms =3D 50, =2Ereply =3D =
{ =2Epriority =3D 10, =2Eweight =3D 0, =2Emax_latency_diff =3D 0 } },
+    =
    { =2Eindex =3D 1, =2Eresponded =3D true, =2Ertt_ms =3D 100, =2Ereply =
=3D { =2Epriority =3D 10, =2Eweight =3D 0, =2Emax_latency_diff =3D 100 } },=

+    };
+    oob_rank_probe_results(r, 2, -1, rank_rng_zero, &gc);
+    as=
sert_int_equal(r[0]=2Eindex, 0);
+    gc_free(&gc);
+}
+
+/* Remotes tied a=
t the fastest RTT are all candidates even at margin 0, so weight
+ * still =
distributes load between them=2E */
+static void
+test_rank_zero_margin_wei=
ghts_ties(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struc=
t oob_probe_result r[] =3D {
+        { =2Eindex =3D 0, =2Eresponded =3D tr=
ue, =2Ertt_ms =3D 20, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 1, =
=2Emax_latency_diff =3D 0 } },
+        { =2Eindex =3D 1, =2Eresponded =3D =
true, =2Ertt_ms =3D 20, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 10=
00, =2Emax_latency_diff =3D 0 } },
+    };
+    rank_rng_value =3D 500; /* =
falls in the weight-1000 slice [1,1001) */
+    oob_rank_probe_results(r, 2=
, -1, rank_rng_fixed, &gc);
+    assert_int_equal(r[0]=2Eindex, 1);
+    gc=
_free(&gc);
+}
+
+/* A remote exactly its advertised margin behind the fast=
est is still a candidate
+ * ("no more than max_latency_diff larger than th=
e lowest RTT")=2E */
+static void
+test_rank_margin_boundary_is_inclusive(v=
oid **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct oob_probe=
_result r[] =3D {
+        { =2Eindex =3D 0, =2Eresponded =3D true, =2Ertt_=
ms =3D 20, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 1, =2Emax_laten=
cy_diff =3D 10 } },
+        { =2Eindex =3D 1, =2Eresponded =3D true, =2Ert=
t_ms =3D 30, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 1000, =2Emax_=
latency_diff =3D 10 } },
+    };
+    rank_rng_value =3D 500;
+    oob_rank=
_probe_results(r, 2, -1, rank_rng_fixed, &gc);
+    assert_int_equal(r[0]=
=2Eindex, 1); /* exactly 10ms behind, in band, wins on weight */
+    gc_fr=
ee(&gc);
+}
+
+/* Non-responders are placed last, keeping their original re=
lative order=2E */
+static void
+test_rank_nonresponders_last(void **state)=

+{
+    struct gc_arena gc =3D gc_new();
+    struct oob_probe_result r[] =
=3D {
+        { =2Eindex =3D 0, =2Eresponded =3D false },
+        { =2Ein=
dex =3D 1, =2Eresponded =3D true, =2Ertt_ms =3D 20, =2Ereply =3D { =2Eprior=
ity =3D 10, =2Eweight =3D 50 } },
+        { =2Eindex =3D 2, =2Eresponded =
=3D false },
+        { =2Eindex =3D 3, =2Eresponded =3D true, =2Ertt_ms =
=3D 20, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 50 } },
+    };
+ =
   oob_rank_probe_results(r, 4, 10, rank_rng_zero, &gc);
+    assert_int_eq=
ual(r[0]=2Eindex, 1); /* responder (rng_zero keeps order) */
+    assert_in=
t_equal(r[1]=2Eindex, 3); /* responder */
+    assert_int_equal(r[2]=2Einde=
x, 0); /* non-responder, original order kept */
+    assert_int_equal(r[3]=
=2Eindex, 2);
+    gc_free(&gc);
+}
+
 int
 main(void)
 {
@@ -643,6 +901,18=
 @@
         cmocka_unit_test(test_client_reply_read_rejects_unknown_mandat=
ory),
         cmocka_unit_test(test_client_reply_read_missing),
         c=
mocka_unit_test(test_client_reply_read_wrong_msg_type),
+        cmocka_uni=
t_test(test_rank_responder_before_nonresponder),
+        cmocka_unit_test(=
test_rank_by_priority),
+        cmocka_unit_test(test_rank_candidate_band)=
,
+        cmocka_unit_test(test_rank_advertised_margin),
+        cmocka_u=
nit_test(test_rank_client_margin_overrides_advertised),
+        cmocka_uni=
t_test(test_rank_advertised_zero_margin),
+        cmocka_unit_test(test_ra=
nk_zero_margin_keeps_fastest_a_candidate),
+        cmocka_unit_test(test_r=
ank_zero_margin_weights_ties),
+        cmocka_unit_test(test_rank_margin_b=
oundary_is_inclusive),
+        cmocka_unit_test(test_rank_weighted_selecti=
on),
+        cmocka_unit_test(test_rank_weighted_keeps_rtt_order_of_rest),=

+        cmocka_unit_test(test_rank_nonresponders_last),
     };
 
     re=
turn cmocka_run_group_tests_name("oob tests", tests, NULL, NULL);

-- 
To v=
iew, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1746?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I55da68cc341bcfc707fd34ca=
2f84ff9b6a55501f
Gerrit-Change-Number: 1746
Gerrit-PatchSet: 17
Gerrit-Owne=
r: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: ralf_lici <ralf@man=
delbit=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>

--bSqxvh78aKI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici, stipa=2E </p>
<p>stipa <strong>=
uploaded patch set #17</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1746?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">oob: Add probe-result ranking for server selection<br><br>Add oob=
_rank_probe_results(), which orders remotes best-first from their<br>probe =
results, following the DNS-SRV (RFC 2782) semantics of the<br>probe_reply T=
LV:<br><br>  - remotes that answered rank before those that did not (non-re=
sponders<br>    keep their original relative order, last);<br>  - responder=
s are grouped by priority, lowest value first (an absolute<br>    ordering,=
 never overridden by latency or weight);<br>  - within a priority group the=
 &quot;candidates&quot; are the responders whose<br>    RTT is no more than=
 a margin larger than the fastest, so the fastest<br>    is always one; can=
didates rank ahead of non-candidates;<br>  - candidates are ordered by RFC-=
2782 weighted-random selection by<br>    weight, so a server is chosen firs=
t with probability proportional to<br>    its weight (load distribution); n=
on-candidates follow, ordered by<br>    RTT=2E<br><br>oob_effective_margin(=
) decides that margin: the client&#39;s --server-probe<br>value if it set o=
ne, otherwise the server&#39;s advertised max_latency_diff,<br>where 0 admi=
ts only the fastest responder and whatever ties with it=2E<br><br>The RNG i=
s injected as a function pointer so this module stays free of<br>the crypto=
 layer and the weighted ordering is deterministically<br>unit-testable (the=
 client will pass get_random; the tests pass stubs)=2E<br><br>Exercised by =
unit tests; the client probe path calls it in a follow-up,<br>which also po=
pulates RTT -- until then every responder sits in the band<br>and selection=
 is purely weighted-random=2E<br><br>Change-Id: I55da68cc341bcfc707fd34ca2f=
84ff9b6a55501f<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>=
---<br>M src/openvpn/oob=2Ec<br>M src/openvpn/oob=2Eh<br>M tests/unit_tests=
/openvpn/test_oob=2Ec<br>3 files changed, 486 insertions(+), 0 deletions(-)=
<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/ope=
nvpn refs/changes/46/1746/17</pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;"><span>diff --git a/src/openvpn/oob=2Ec b/src=
/openvpn/oob=2Ec</span><br><span>index 45e3908=2E=2Ec0c8955 100644</span><b=
r><span>--- a/src/openvpn/oob=2Ec</span><br><span>+++ b/src/openvpn/oob=2Ec=
</span><br><span>@@ -147,3 +147,167 @@</span><br><span>     /* Drop replaye=
d or implausibly-timed probes before doing any more work=2E */</span><br><s=
pan>     return oob_timestamp_in_window(param=2Etimestamp, now, window_secs=
);</span><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Base ordering:=
 responders before non-responders, then by priority (lower</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * first), then by RTT (lower first)=
, then by original index for determinism=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * This groups responders into priority runs pre-so=
rted by RTT, which the</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * candidate-band step below relies on (run[0] is the fastest in its gro=
up)=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static int=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_result_co=
mpare(const void *a, const void *b)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  const struct oob_probe_result *ra =3D a;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    const struct oob_probe_result *rb =3D b;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (ra-&gt;responded &amp;&amp; rb-&gt;res=
ponded)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        /* both answered: =
lowest priority first, then lowest RTT */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if (ra-&gt;reply=2Epriority !=3D rb-&gt;reply=
=2Epriority)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            retur=
n ra-&gt;reply=2Epriority &lt; rb-&gt;reply=2Epriority ? -1 : 1;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (ra-&gt;rtt_ms !=3D rb-&gt;rt=
t_ms)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            return ra-&g=
t;rtt_ms &lt; rb-&gt;rtt_ms ? -1 : 1;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    el=
se if (ra-&gt;responded)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
eturn -1; /* only a answered: it ranks first */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    else if (rb-&gt;responded)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        return 1; /* only b answered */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /* neither answered, or all keys equal: keep the configured order */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ra-&gt;index =
- rb-&gt;index;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+oob_effective_margin(const struct oob_probe_result *r, in=
t client_margin)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (client_margin=
 &gt;=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        return client_=
margin;              /* the client&#39;s own setting is authoritative */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    return (int)r-&gt;reply=2Emax_la=
tency_diff; /* else the server&#39;s advertised value */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/* Reorder the index list idx[0=2E=2Em) into DNS-SRV (RFC 2782) weighted-ra=
ndom</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * order by res=
ults[idx[k]]=2Ereply=2Eweight: each position is filled by a remaining entry=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * chosen with prob=
ability proportional to its weight=2E When all remaining</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * weights are 0 the current (RTT-sort=
ed) order is kept=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_=
weighted_order(const struct oob_probe_result *results, int *idx, int m, int=
64_t (*rng)(void))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int pos =
=3D 0; pos &lt; m; pos++)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
long sum =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    for (int k =3D pos; k &lt; m; k++)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            sum +=3D results[idx[k]]=2Ereply=2Eweight;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        int chosen =3D pos;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if (sum &gt; 0)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            int64_t r =3D rng() % sum; =
/* uniform in [0, sum) */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            long acc =3D 0;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            for (int k =3D pos; k &lt; m; k++)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                acc +=3D results[idx[k]]=
=2Ereply=2Eweight;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               if (acc &gt; r)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                    chosen =3D k;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                    break;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        /* Move the chosen entry to pos and shift the ones it j=
umped over down</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
     * by one=2E RFC 2782 removes the selected entry from the list, so the<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * rest keep=
 their RTT order; a swap would fling the displaced entry to</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+         * the far end and can leav=
e the fastest server tried last=2E */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        int sel =3D idx[chosen];</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        for (int k =3D chosen; k &gt; pos; k=
--)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            idx[k] =3D idx=
[k - 1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        idx[pos] =3D =
sel;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/* Reorder one priority run (run[0=2E=2Em), already RTT-sorted) in=
 place:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * candidate=
s (RTT within the band of the fastest) first, ordered by weighted</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * random; then non-candidate=
s in RTT order=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_ord=
er_priority_run(struct oob_probe_result *run, int m, int client_margin, int=
64_t (*rng)(void),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                      struct gc_arena *gc)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (m &lt;=3D 1)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    unsigned int best_rtt =3D run[0]=2Ertt_ms=
; /* run is RTT-sorted: [0] is fastest */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    int *cand =3D gc_malloc(sizeof(int) * m, false, gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    int *non =3D gc_malloc(sizeof(i=
nt) * m, false, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    int nc =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   int nn =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 for (int k =3D 0; k &lt; m; k++)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        /* &quot;no more than their max_latency_diff larger than the lowest=
 RTT&quot;, so the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
        * comparison includes the margin itself=2E That also keeps the fast=
est of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * th=
e run a candidate when it advertises 0: announcing 0 asks not to be</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+         * compared on weig=
ht, not to be ranked behind a slower server=2E */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        unsigned int gap =3D run[k]=2Ertt_ms =
- best_rtt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if (gap &lt;=3D (unsigned int)oob_effective_margin(&amp;run[k], client_marg=
in))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            cand[nc++] =
=3D k;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            non[nn++] =3D k;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    oob_weighted_order(run, cand, nc, rng);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct oob_probe_result *tmp =3D gc_malloc(sizeof(*tmp) * m, fals=
e, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int t =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int =
k =3D 0; k &lt; nc; k++)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        t=
mp[t++] =3D run[cand[k]];</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for =
(int k =3D 0; k &lt; nn; k++)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    tmp[t++] =3D run[non[k]];</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
memcpy(run, tmp, sizeof(*run) * m);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+oob_rank_probe_results(struct oob_pr=
obe_result *results, int n, int client_margin,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                       int64_t (*rng)(void), str=
uct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (n &lt;=3D 1)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /* Base order: responders first, grouped by priority, RTT-sorted w=
ithin=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    qsor=
t(results, (size_t)n, sizeof(*results), oob_probe_result_compare);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* Reorder each priority run of responders =
by candidate-band + weight=2E */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    int i =3D 0;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    while (i &lt; n &amp;&amp; results[i]=2Eresponded)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        int j =3D i;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        while (j &lt; n &amp;&amp; result=
s[j]=2Eresponded</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
            &amp;&amp; results[j]=2Ereply=2Epriority =3D=3D results[i]=2Ere=
ply=2Epriority)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            j+=
+;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        oob_order_priority_=
run(results + i, j - i, client_margin, rng, gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        i =3D j;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span>diff --git a/src/openvpn/oob=2Eh b/src/openvp=
n/oob=2Eh</span><br><span>index 2c69fb6=2E=2Ee637b90 100644</span><br><span=
>--- a/src/openvpn/oob=2Eh</span><br><span>+++ b/src/openvpn/oob=2Eh</span>=
<br><span>@@ -172,4 +172,56 @@</span><br><span>  */</span><br><span> bool o=
ob_server_probe_accept(struct buffer *probe_payload, uint64_t now, uint64_t=
 window_secs);</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+/* Candidate-band margin (ms) a server advertises when --serve=
r-probe-reply does</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* not set one=2E Announcing 0 is a valid choice with a distinct meaning -- =
only</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the lowest-l=
atency server is a candidate -- so an unconfigured server has to</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * announce something else; th=
e spec suggests 10 to 20 ms=2E */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#define OOB_DEFAULT_LATENCY_MARGIN_MS 10</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/* Outcome of probing one remote, used to order remotes bes=
t-first=2E @index is</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * the caller&#39;s identifier for the remote (e=2Eg=2E its position in th=
e connection</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * list=
); priority/weight are only meaningful when @responded is true=2E */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+struct oob_probe_result</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    int index;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    bool responded;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    unsigned int rtt_ms;          /* probe ro=
und-trip time in ms (responders only) */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct oob_probe_reply reply; /* the values the se=
rver advertised */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * Order results best-first, in place, per the server=
-probe selection policy:</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *   - remotes that responded rank before those that did not (non-resp=
onders keep</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *     t=
heir original relative order, last);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *   - responders are grouped by priority, lowest priority=
 value first (an</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
    absolute ordering, never overridden by latency or weight);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *   - within a priority group, =
the &quot;candidates&quot; are the responders whose RTT is</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *     no more than a margin larger =
than the fastest in the group (see</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *     oob_effective_margin()), so the fastest is always one=
=2E Candidates are</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*     ordered ahead of non-candidates;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *   - candidates are ordered by DNS-SRV (RFC 2782) weig=
hted-random selection by</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *     weight, so a server is chosen first with probability proportion=
al to its</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *     wei=
ght (load distribution)=2E Non-candidates follow, ordered by RTT=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * @param results        results to reorder =
in place</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param n=
              number of results</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param client_margin  client&#39;s candidate-band margin in =
ms, or &lt; 0 if the</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *                        client did not set one (see oob_effective_margin=
())</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param rng   =
         returns a non-negative random value (e=2Eg=2E get_random);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *                       in=
jected so this module stays free of the crypto layer</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *                       and the weighted=
 ordering is deterministically testable</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @param gc             arena for scratch allocation</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+void oob_rank_probe_results(struct oo=
b_probe_result *results, int n, int client_margin,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                            int64_t (*rng)(v=
oid), struct gc_arena *gc);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * The candidate-band margi=
n (ms) that applies to one probed remote -- how much</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * slower than the group&#39;s fastest th=
at remote may be and still be a candidate=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * It is per-remote: the client&#39;s own setting =
is authoritative, and when</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * client_margin &lt; 0 each remote is judged by the max_latency_dif=
f its own server</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
advertised=2E 0 then admits only the fastest remote and whatever ties with =
it=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+int oob_effective_margin(const=
 struct oob_probe_result *r, int client_margin);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span> #endif /* OOB_H */</span><br=
><span>diff --git a/tests/unit_tests/openvpn/test_oob=2Ec b/tests/unit_test=
s/openvpn/test_oob=2Ec</span><br><span>index acfd6f6=2E=2E0b0ce96 100644</s=
pan><br><span>--- a/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>+=
++ b/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>@@ -613,6 +613,2=
64 @@</span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Determinis=
tic RNG stubs for the weighted-selection ordering=2E rank_rng_zero</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * makes the weighted draw a=
lways pick the first remaining candidate, preserving</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * order; rank_rng_fixed returns a value =
we set to land in a chosen weight slice=2E */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static int64_t</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+rank_rng_zero(void)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+static int64_t rank_rng_value;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static int64_t</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+rank_rng_fixed(void)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    return rank_rng_value;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Pic=
king a weighted entry must not disturb the RTT order of the entries it</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * was picked ahead of: =
RFC 2782 removes the selection, it does not swap=2E */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+test_rank_weighted_keeps_rtt_order_of_rest(void =
**state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc=
_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* same =
priority, all in band; only the slowest advertises a weight, so it</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+     * is drawn first and th=
e two weight-0 entries must follow in RTT order=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_result r[] =3D {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        { =2Eindex =3D =
0, =2Eresponded =3D true, =2Ertt_ms =3D 20, =2Ereply =3D { =2Epriority =3D =
10, =2Eweight =3D 0 } },</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        { =2Eindex =3D 1, =2Eresponded =3D true, =2Ertt_ms =3D 30, =2E=
reply =3D { =2Epriority =3D 10, =2Eweight =3D 0 } },</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        { =2Eindex =3D 2, =2Eresponded =
=3D true, =2Ertt_ms =3D 40, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =
=3D 10 } },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    rank_rng_value =3D 0;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    oob_rank_probe_results(r, 3, 1=
00, rank_rng_fixed, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_int_equal(r[0]=2Eindex, 2); /* the only weighted entry wins the draw */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(=
r[1]=2Eindex, 0); /* 20 ms before 30 ms */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_int_equal(r[2]=2Eindex, 1);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Responder=
s rank ahead of non-responders regardless of index order=2E */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+test_rank_responder_before_nonresponder(=
void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =
=3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct oob_probe_result r[] =3D {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        { =2Eindex =3D 0, =2Eresponded =3D false },</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        { =2Eindex =3D 1, =2Ere=
sponded =3D true, =2Ereply =3D { =2Epriority =3D 100, =2Eweight =3D 50 } },=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    oob_rank_probe_results(r, 2,=
 10, rank_rng_zero, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_int_equal(r[0]=2Eindex, 1);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_int_equal(r[1]=2Eindex, 0);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* Among responders, the lowest priority value wins (an abso=
lute ordering)=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_ra=
nk_by_priority(void **state)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct oob_probe_result r[] =3D {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        { =2Eindex =3D 0, =2Eresponded =3D true, =
=2Ereply =3D { =2Epriority =3D 20, =2Eweight =3D 50 } },</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        { =2Eindex =3D 1, =2Eresponded=
 =3D true, =2Ereply =3D { =2Epriority =3D 5, =2Eweight =3D 50 } },</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        { =2Eindex =3D 2, =
=2Eresponded =3D true, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 50 =
} },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    oob_rank_probe_results(r=
, 3, 10, rank_rng_zero, &amp;gc);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_int_equal(r[0]=2Eindex, 1); /* priority 5 */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(r[1]=
=2Eindex, 2); /* priority 10 */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_int_equal(r[2]=2Eindex, 0); /* priority 20 */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* Within a priority, only servers within the latency margin=
 of the fastest are</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * candidates; a slower (out-of-band) server ranks behind a faster one no m=
atter</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * how large i=
ts weight=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stat=
ic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_rank_ca=
ndidate_band(void **state)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct oob_probe_result r[] =3D {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        { =2Eindex =3D 0, =2Eresponded =3D true, =
=2Ertt_ms =3D 100, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 1000 } =
},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        { =2Einde=
x =3D 1, =2Eresponded =3D true, =2Ertt_ms =3D 20, =2Ereply =3D { =2Epriorit=
y =3D 10, =2Eweight =3D 1 } },</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /* margin 10ms: 20ms is fastest; 100ms is 80ms slower -&gt; out of band *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    oob_rank_probe=
_results(r, 2, 10, rank_rng_zero, &amp;gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_int_equal(r[0]=2Eindex, 1); /* fast, in-=
band, despite tiny weight */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_int_equal(r[1]=2Eindex, 0); /* slow, out-of-band, despi=
te huge weight */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/* A server widens its own band via t=
he advertised max_latency_diff, joining the</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * candidate set even when it is well behind the fa=
stest; it then participates in</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * the weighted selection=2E */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/* A client margin, even 0, overrides whatever the s=
ervers advertise=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_=
rank_client_margin_overrides_advertised(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_result r[] =3D {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        { =2Eindex =3D =
0, =2Eresponded =3D true, =2Ertt_ms =3D 20, =2Ereply =3D { =2Epriority =3D =
10, =2Eweight =3D 1 } },</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        { =2Eindex =3D 1,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+          =2Eresponded =3D true,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+          =2Ertt_ms =3D 100,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+          =2Ereply =3D { =2Epriority =3D =
10, =2Eweight =3D 1000, =2Emax_latency_diff =3D 200 } },</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* With the advertised 200 ms the slow server w=
ould be a candidate (see</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     * test_rank_advertised_margin); the client&#39;s 0 leaves only th=
e fastest=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
rank_rng_value =3D 500;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    oob_rank_probe_results(r, 2, 0, rank_rng_fixed, &amp;gc);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(r[0]=2Ei=
ndex, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_int_equal(r[1]=2Eindex, 1);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+test_rank_advertised_margin(void *=
*state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_=
new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oo=
b_probe_result r[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        { =2Eindex =3D 0, =2Eresponded =3D true, =2Ertt_ms =3D 20, =2E=
reply =3D { =2Epriority =3D 10, =2Eweight =3D 1 } },</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        { =2Eindex =3D 1,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+          =2Eresponded =3D true,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+          =2Ertt_ms =
=3D 100,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
=2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 1000, =2Emax_latency_diff =
=3D 200 } },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Client did no=
t set a margin (-1), so each server&#39;s advertised value</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     * applies: the 100ms server adv=
ertises 200 -&gt; it is a candidate 80ms behind</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     * the fastest; with weight 1000 (slice [1,=
1001)) a draw of 500 selects it</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+     * first=2E */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    rank_rng_value =3D 500;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    oob_rank_probe_results(r, 2, -1, rank_rng_fixed, &am=
p;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_in=
t_equal(r[0]=2Eindex, 1);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/* Among candidates, weight d=
rives RFC-2782 proportional selection: a draw is</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * mapped to the server whose cumulative weigh=
t slice it falls in=2E */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+te=
st_rank_weighted_selection(void **state)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* equal priority and RTT -&gt; both in band; weigh=
ts 30 and 70, sum 100:</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * index 0 owns [0,30), index 1 owns [30,100)=2E */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    const struct oob_probe_result ba=
se[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
 =2Eindex =3D 0, =2Eresponded =3D true, =2Ertt_ms =3D 20, =2Ereply =3D { =
=2Epriority =3D 10, =2Eweight =3D 30 } },</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        { =2Eindex =3D 1, =2Eresponded =3D true, =2Er=
tt_ms =3D 20, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 70 } },</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_result r[2];</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    memcpy(r, base, sizeof(base));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    rank_rng_value =3D 10;=
 /* falls in index 0&#39;s slice */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    oob_rank_probe_results(r, 2, 50, rank_rng_fixed, &amp;g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_e=
qual(r[0]=2Eindex, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(r, ba=
se, sizeof(base));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   rank_rng_value =3D 50; /* falls in index 1&#39;s slice */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    oob_rank_probe_results(r, 2, 5=
0, rank_rng_fixed, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_int_equal(r[0]=2Eindex, 1);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/* An advertised max_laten=
cy_diff of 0 means &quot;compare on latency alone&quot;: the</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * server&#39;s own band is empty,=
 so weight cannot float it ahead of a faster peer=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * The same pair with a band advertised d=
oes let weight decide=2E */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
test_rank_advertised_zero_margin(void **state)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    const struct oob_probe_result base[] =3D {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        { =2Eindex =3D=
 0, =2Eresponded =3D true, =2Ertt_ms =3D 20, =2Ereply =3D { =2Epriority =3D=
 10, =2Eweight =3D 1 } },</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        { =2Eindex =3D 1, =2Eresponded =3D true, =2Ertt_ms =3D 40, =
=2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 1000 } },</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct oob_probe_result r[2];</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    memcpy(r, base, sizeof(base));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    rank_rng_value =3D 500;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    oob_rank_probe_results(r, 2=
, -1, rank_rng_fixed, &amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_int_equal(r[0]=2Eindex, 0); /* both advertise 0 -&gt=
; fastest wins */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(r, base, s=
izeof(base));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r[=
0]=2Ereply=2Emax_latency_diff =3D 50;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    r[1]=2Ereply=2Emax_latency_diff =3D 50;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    rank_rng_value =3D 500;      =
      /* falls in the weight-1000 slice [1,1001) */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    oob_rank_probe_results(r, 2, -1, rank=
_rng_fixed, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_int_equal(r[0]=2Eindex, 1); /* 20ms behind but inside a 50ms b=
and */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/* The fastest remote is a candidate even when it advertises 0: it =
competes with</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * a s=
lower remote whose own band covers the gap instead of being ranked behind</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * it outright=2E Nei=
ther carries weight here, so the candidate order is RTT order</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * -- had the fastest fallen out =
of the band, the slower one would lead=2E */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+test_rank_zero_margin_keeps_fastest_a_candidate(void **sta=
te)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new(=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_pr=
obe_result r[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        { =2Eindex =3D 0, =2Eresponded =3D true, =2Ertt_ms =3D 50, =2Erepl=
y =3D { =2Epriority =3D 10, =2Eweight =3D 0, =2Emax_latency_diff =3D 0 } },=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        { =2Eindex =
=3D 1, =2Eresponded =3D true, =2Ertt_ms =3D 100, =2Ereply =3D { =2Epriority=
 =3D 10, =2Eweight =3D 0, =2Emax_latency_diff =3D 100 } },</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    oob_rank_probe_results(r, 2, -1, rank_rng_zer=
o, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_int_equal(r[0]=2Eindex, 0);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Remotes tied at the =
fastest RTT are all candidates even at margin 0, so weight</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * still distributes load between th=
em=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_rank_zero_marg=
in_weights_ties(void **state)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct oob_probe_result r[] =3D {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        { =2Eindex =3D 0, =2Eresponded =3D true,=
 =2Ertt_ms =3D 20, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 1, =2Em=
ax_latency_diff =3D 0 } },</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        { =2Eindex =3D 1, =2Eresponded =3D true, =2Ertt_ms =3D 20, =
=2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 1000, =2Emax_latency_diff =
=3D 0 } },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    rank_rng_value =3D=
 500; /* falls in the weight-1000 slice [1,1001) */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    oob_rank_probe_results(r, 2, -1, rank=
_rng_fixed, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_int_equal(r[0]=2Eindex, 1);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A remote ex=
actly its advertised margin behind the fastest is still a candidate</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * (&quot;no more than max_=
latency_diff larger than the lowest RTT&quot;)=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+test_rank_margin_boundary_is_inclusive(void **sta=
te)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new(=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_pr=
obe_result r[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        { =2Eindex =3D 0, =2Eresponded =3D true, =2Ertt_ms =3D 20, =2Erepl=
y =3D { =2Epriority =3D 10, =2Eweight =3D 1, =2Emax_latency_diff =3D 10 } }=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        { =2Eindex=
 =3D 1, =2Eresponded =3D true, =2Ertt_ms =3D 30, =2Ereply =3D { =2Epriority=
 =3D 10, =2Eweight =3D 1000, =2Emax_latency_diff =3D 10 } },</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    rank_rng_value =3D 500;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    oob_rank_probe_results(r, 2, -1, ra=
nk_rng_fixed, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_int_equal(r[0]=2Eindex, 1); /* exactly 10ms behind, in band,=
 wins on weight */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/* Non-responders are placed last, k=
eeping their original relative order=2E */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+test_rank_nonresponders_last(void **state)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_result r[] =3D {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        { =2Eindex =
=3D 0, =2Eresponded =3D false },</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        { =2Eindex =3D 1, =2Eresponded =3D true, =2Ertt_ms =3D=
 20, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 50 } },</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        { =2Eindex =3D 2, =2Eresp=
onded =3D false },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       { =2Eindex =3D 3, =2Eresponded =3D true, =2Ertt_ms =3D 20, =2Ereply =
=3D { =2Epriority =3D 10, =2Eweight =3D 50 } },</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    oob_rank_probe_results(r, 4, 10, rank_rng_zero, &amp;gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equ=
al(r[0]=2Eindex, 1); /* responder (rng_zero keeps order) */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(r[1]=2Eindex, =
3); /* responder */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_int_equal(r[2]=2Eindex, 0); /* non-responder, original order kep=
t */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_=
equal(r[3]=2Eindex, 2);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span> int</span><br><span> main(void)</span><br><span> {</span><br><span>@@=
 -643,6 +901,18 @@</span><br><span>         cmocka_unit_test(test_client_re=
ply_read_rejects_unknown_mandatory),</span><br><span>         cmocka_unit_t=
est(test_client_reply_read_missing),</span><br><span>         cmocka_unit_t=
est(test_client_reply_read_wrong_msg_type),</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        cmocka_unit_test(test_rank_responder_before=
_nonresponder),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    cmocka_unit_test(test_rank_by_priority),</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_rank_candidate_band)=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_uni=
t_test(test_rank_advertised_margin),</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        cmocka_unit_test(test_rank_client_margin_overrides=
_advertised),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  cmocka_unit_test(test_rank_advertised_zero_margin),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_rank_zero_m=
argin_keeps_fastest_a_candidate),</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        cmocka_unit_test(test_rank_zero_margin_weights_ties),=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit=
_test(test_rank_margin_boundary_is_inclusive),</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_rank_weighted_sele=
ction),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmoc=
ka_unit_test(test_rank_weighted_keeps_rtt_order_of_rest),</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_rank_no=
nresponders_last),</span><br><span>     };</span><br><span> </span><br><spa=
n>     return cmocka_run_group_tests_name(&quot;oob tests&quot;, tests, NUL=
L, NULL);</span><br><span></span><br></pre><p>To view, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1746?usp=3Demail">change 1746</a>=2E=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"http://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsc=
ope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1746?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"=
display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I55da6=
8cc341bcfc707fd34ca2f84ff9b6a55501f </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 1746 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 17 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@=
gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaist=
hos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
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
--bSqxvh78aKI=--


--===============5308850040036013276==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5308850040036013276==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5308850040036013276==--

