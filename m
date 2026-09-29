Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95DF3CA5FAC
	for <openvpn-devel@archiver.kernel.org>; Tue, 29 Sep 2026 13:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lYbUe/uX2Ak8XaVukOOyWHKcKIIdGZCsQkmSMjSmy9M=; b=K81olQ99KMCe+Z1ctgXKpUYywn
	ZaeMli+mSDJrfFsnspoa3ubj9S79W7S/rbeRrRo7r1Ggeg4WgKSsH7aqaWJvEDU5M5bqFw9LdpGq2
	WCgGNlGFgTekEqTo1cyFsV8YlXBE4OFV/q7APTnzAD+izTr3Of5gHuC5Wd1Da404BcRQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBXhf-0005TU-SF;
	Tue, 29 Sep 2026 13:17:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBXha-0005T3-32
 for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 13:16:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=iuQj6Y7JuDU9XoN7OELbZ82zb1bYi0s+B5id9QQ4qRg=; b=AFF7zjsh+eeME5mc1N/VacNOZy
 uzlwwOwGGpbrJ78b1YdCbgA411uAC9vYD9CitnIVe/iZHI5KBXcLcQyFvNfaIvXb3NO4VquHj8ktB
 TNB/ZfqjqjFZo/ifaPNxUq3Tvyld0Og4W1eqMOlq+baHGDyf5oOehm7/SgM5z7/5mdQw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=iuQj6Y7JuDU9XoN7OELbZ82zb1bYi0s+B5id9QQ4qRg=; b=c
 rLDQ8L4Ugr/rIBpXJLTu23eg12kyD6YdhxyiqdzOpVbh8ybsbcp8GZLZl/YyKY7vUcpxzqehdPBXF
 PcGNTrPU86DEMeyvdLE+03uW51EFgD1OCEvrVHBVean3LCh+SSNU4BDNvo7aS6rWMWIziJwRGfHY3
 TOhAyQNfRDEsTL0o=;
Received: from mail-wr2-f26.google.com ([74.125.225.90])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBXhX-0001FZ-MA for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 13:16:58 +0000
Received: by mail-wr2-f26.google.com with SMTP id
 ffacd0b85a97d-4843f22dc83so3509668f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 29 Sep 2026 06:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790687809; x=1791292609; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iuQj6Y7JuDU9XoN7OELbZ82zb1bYi0s+B5id9QQ4qRg=;
 b=QwxkfMO6MULv9ClWIdwYeElVhnq1Luue5adzLh/n6Mrj558OfERGkNum2sJ9SULLwy
 57kOFV5sT3Bc+3khpIFPgM/CWdMBAqkCJrOpMkLDI3lOCDC7HXeojLAMDf73qhdakYv9
 ahaB/zGIA2P8FHJhhYMiwdmS2gP16IOxkHPa+sKqIaNWDpQUTWCU8c/EwSdctgpGftNf
 WVIUqCJBr/i6udWWz3jEdRPpaFjSi/1b3UyQbXh9Nz+XVYJg8n2z7o2MatOfxK2SIRXp
 f2a1zbBlelg0Wq5+93m8jvLfKNCNyVWT/NYSHVqlGXYa9rAkgsd8MxhBlD6Vc0v5pMK2
 +2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790687809; x=1791292609;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=iuQj6Y7JuDU9XoN7OELbZ82zb1bYi0s+B5id9QQ4qRg=;
 b=2ACTh4uQpquzauDcBmWDE7mfGAvoizVDeL5bv5Fe4PxoEJKI0tym21wrahwRG8sHg4
 UQmBxJTJB314usF8gmLI9xd5+zrW1EGHnjOtLSQy7rukZm5C/C7d2w/1eYA+IEazPnYw
 h3FhWIzHHLt6GZGon1g/XAw+PurRxc94nwhzbh8kDrlD/TGdkPCkCElRl/hL/jGQmLmm
 bDRJ/9Ki2nRvdEaO1Z86hmWykylPkSw8PwGiSPLHCfKmweaMPVEQA3czRTCHzf1nLLQc
 rrQhEFPVIqUCtOWfDiocxxLLa7I+08SL9H0m9JV2x3OrOraSdKsbzpSZVZA66wt9JZkI
 3UzA==
X-Gm-Message-State: AFq9FYKISV2Ogg/w8LWxcc1psmaxFJOVGaA06gSVwIG8C7iZCSWp9Tbg
 3NrXOGMenWJwqr/3QfNK52mYtAnTgmu4AF+YEZUKJ6oNKPzsGLf3XV69f1j3o1vdtFJ3TUUU6bg
 xBuzCOX2L7XwTooaXlbWsyAiOCxLVhMjFXkdYRAn9QUguBBSnF7Y/nkjRUxYBRGZvhhG8
X-Gm-Gg: AYBFou3NbRO28N37JYxmxsu1ZvD+t7uNsqy3tlKC131GTdkojsPQ6Zp05+tgYh1ddlD
 5csDS/yd+j7qoBC2CQn3ewQ4PzTDyvLk7234BK/dG8LrAfL5gxKTHXHr2MFARQdnylF7t+R7gN9
 HIgY+x4hpnF7VfLbIrY/dSUExJcVjcMuL49iJpBYOxSuRAiGZE6MTbs8+C5HMhujbbwEJ6gLXxk
 d0mg01q499GOTF16838Tt6+UCxCqcviN4+jTlKkS72a6TqLy8v97Mi0rbl2FV59grk9OLntOdFO
 2ex5u1npVqFErxbwpkSHGGzHD4ATJSPsBnFOvf2ul157zhdOfqzBoEFMwr8/gxF5TBSFT46xE++
 rbEmpyKmmdC/CvYi+JzJMxbiXXdzc8f8SWuEg4hPTpLQx6Nw45+8iOTbOL4n/z7SEF79XzuvBNl
 MTWiGUo1ctfdz66r+DBgdZsRnzhoSW/Qp0a9l37wewYCZffaOYq9k1fpCtUjsecPtyHj0pfWRZD
 WrrQAtYU0nAiBu0A7hJNJt+hxmzcTVJPqKw22pgkzHlp8uw6cKVTpTPydKPKMtaxIMxZkGGFs3m
 T7uRgALORSvuAZjsbcLjtoH8GtFcEQ+pAJFSHtfnpBtdECeGJXfpr51u/sdh
X-Received: by 2002:a5d:588f:0:b0:488:ba61:e3be with SMTP id
 ffacd0b85a97d-488ba61e623mr13469394f8f.46.1790687807679; 
 Tue, 29 Sep 2026 06:16:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af4f88352sm4347857f8f.4.2026.09.29.06.16.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 06:16:47 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 29 Sep 2026 13:16:31 +0000
To: ralf_lici <ralf@mandelbit.com>,
	plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 23
X-Gerrit-Change-Id: I55da68cc341bcfc707fd34ca2f84ff9b6a55501f
X-Gerrit-Change-Number: 1746
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1746?usp=email>
X-Gerrit-Commit: ef2dda6b6946c457b100dad25d990b27fa2b2387
In-Reply-To: <gerrit.1782719911000.I55da68cc341bcfc707fd34ca2f84ff9b6a55501f@gerrit.openvpn.net>
References: <gerrit.1782719911000.I55da68cc341bcfc707fd34ca2f84ff9b6a55501f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk1NWRhNjhjYzM0MWJjZmM3MDdmZDM0Y2EyZjg0ZmY5YjZhNTU1MDFmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a332b5802fcb201f80cdddaaf733311047838cee-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBXhX-0001FZ-MA
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
Content-Type: multipart/mixed; boundary="===============2470088804155428979=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2470088804155428979==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9oAQ98ZuL0E="; charset=UTF-8

--9oAQ98ZuL0E=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici=2E

Hello plaist=
hos, ralf_lici, 

I'd like you to reexamine a change=2E Please visit

    h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1746?usp=3Demail

to look at the n=
ew patch set (#23)=2E


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
s are ordered by RFC 2782 weighted-random selection by
    weight, so a ser=
ver is chosen first with probability proportional to
    its weight (load d=
istribution); non-candidates follow, ordered by
    RTT=2E

oob_effective_m=
argin() decides that margin: the client's own margin if
it set one (--serve=
r-probe, added later), otherwise the max_latency_diff
advertised by the fas=
test server of the group, where 0 admits only the
servers tying it=2E

The =
RNG is injected as a function pointer so this module stays free of
the cryp=
to layer and the weighted ordering is deterministically
unit-testable=2E

E=
xercised by unit tests; the client probe path calls it in a follow-up,
and =
measures RTT in a later one -- until then every responder sits in
the band =
and selection is purely weighted-random=2E

Change-Id: I55da68cc341bcfc707f=
d34ca2f84ff9b6a55501f
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M=
 src/openvpn/oob=2Ec
M src/openvpn/oob=2Eh
M tests/unit_tests/openvpn/test_=
oob=2Ec
3 files changed, 480 insertions(+), 0 deletions(-)


  git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/46/1746/23

diff --git=
 a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec
index a02ce51=2E=2E6920801 100=
644
--- a/src/openvpn/oob=2Ec
+++ b/src/openvpn/oob=2Ec
@@ -118,3 +118,164 =
@@
     return oob_timestamp_in_window(req->timestamp, now, window_secs) ? =
OOB_PROBE_OK
                                                              =
        : OOB_PROBE_STALE;
 }
+
+/* Base ordering: responders before non-re=
sponders, then by priority (lower
+ * first), then by RTT (lower first), th=
en by original index for determinism=2E
+ * This groups responders into pri=
ority runs pre-sorted by RTT, which the
+ * candidate-band step below relie=
s on (run[0] is the fastest in its group)=2E */
+static int
+oob_probe_resu=
lt_compare(const void *a, const void *b)
+{
+    const struct oob_probe_res=
ult *ra =3D a;
+    const struct oob_probe_result *rb =3D b;
+
+    if (ra-=
>responded && rb->responded)
+    {
+        /* both answered: lowest prior=
ity first, then lowest RTT */
+        if (ra->reply=2Epriority !=3D rb->re=
ply=2Epriority)
+        {
+            return ra->reply=2Epriority < rb->r=
eply=2Epriority ? -1 : 1;
+        }
+        if (ra->rtt_ms !=3D rb->rtt_m=
s)
+        {
+            return ra->rtt_ms < rb->rtt_ms ? -1 : 1;
+      =
  }
+    }
+    else if (ra->responded)
+    {
+        return -1; /* only =
a answered: it ranks first */
+    }
+    else if (rb->responded)
+    {
+ =
       return 1; /* only b answered */
+    }
+
+    /* neither answered, o=
r all keys equal: keep the configured order */
+    return ra->index - rb->=
index;
+}
+
+int
+oob_effective_margin(const struct oob_probe_result *r, in=
t client_margin)
+{
+    if (client_margin >=3D 0)
+    {
+        return c=
lient_margin;              /* the client's own setting is authoritative */
=
+    }
+    return (int)r->reply=2Emax_latency_diff; /* else what the faste=
st remote advertised */
+}
+
+/* Reorder the index list idx[0=2E=2Em) into =
DNS-SRV (RFC 2782) weighted-random
+ * order by results[idx[k]]=2Ereply=2Ew=
eight: each position is filled by a remaining entry
+ * chosen with probabi=
lity proportional to its weight=2E When all remaining
+ * weights are 0 the=
 current (RTT-sorted) order is kept=2E */
+static void
+oob_weighted_order(=
const struct oob_probe_result *results, int *idx, int m, int64_t (*rng)(voi=
d))
+{
+    for (int pos =3D 0; pos < m; pos++)
+    {
+        long sum =
=3D 0;
+        for (int k =3D pos; k < m; k++)
+        {
+            sum=
 +=3D results[idx[k]]=2Ereply=2Eweight;
+        }
+        int chosen =3D =
pos;
+        if (sum > 0)
+        {
+            int64_t r =3D rng() % su=
m; /* uniform in [0, sum) */
+            long acc =3D 0;
+            for =
(int k =3D pos; k < m; k++)
+            {
+                acc +=3D result=
s[idx[k]]=2Ereply=2Eweight;
+                if (acc > r)
+                =
{
+                    chosen =3D k;
+                    break;
+         =
       }
+            }
+        }
+        /* Move the chosen entry to pos=
, keeping the rest in RTT order (RFC 2782
+         * removes the selected =
entry from the list)=2E */
+        int sel =3D idx[chosen];
+        for (=
int k =3D chosen; k > pos; k--)
+        {
+            idx[k] =3D idx[k - =
1];
+        }
+        idx[pos] =3D sel;
+    }
+}
+
+/* Reorder one prior=
ity run (run[0=2E=2Em), already RTT-sorted) in place:
+ * candidates (RTT w=
ithin the band of the fastest) first, ordered by weighted
+ * random; then =
non-candidates in RTT order=2E */
+static void
+oob_order_priority_run(stru=
ct oob_probe_result *run, int m, int client_margin, int64_t (*rng)(void),
+=
                       struct gc_arena *gc)
+{
+    if (m <=3D 1)
+    {
+ =
       return;
+    }
+
+    unsigned int best_rtt =3D run[0]=2Ertt_ms; /* =
run is RTT-sorted: [0] is fastest */
+
+    int *cand =3D gc_malloc(sizeof(=
int) * m, false, gc);
+    int *non =3D gc_malloc(sizeof(int) * m, false, g=
c);
+    int nc =3D 0;
+    int nn =3D 0;
+    /* The fastest remote's marg=
in sets the band; inclusive, so the fastest is
+     * always a candidate, =
also when it advertises 0=2E */
+    const unsigned int margin =3D (unsigne=
d int)oob_effective_margin(&run[0], client_margin);
+    for (int k =3D 0; =
k < m; k++)
+    {
+        unsigned int gap =3D run[k]=2Ertt_ms - best_rtt=
;
+        if (gap <=3D margin)
+        {
+            cand[nc++] =3D k;
+=
        }
+        else
+        {
+            non[nn++] =3D k;
+        }=

+    }
+
+    oob_weighted_order(run, cand, nc, rng);
+
+    struct oob_pr=
obe_result *tmp =3D gc_malloc(sizeof(*tmp) * m, false, gc);
+    int t =3D =
0;
+    for (int k =3D 0; k < nc; k++)
+    {
+        tmp[t++] =3D run[can=
d[k]];
+    }
+    for (int k =3D 0; k < nn; k++)
+    {
+        tmp[t++] =
=3D run[non[k]];
+    }
+    memcpy(run, tmp, sizeof(*run) * m);
+}
+
+void=

+oob_rank_probe_results(struct oob_probe_result *results, int n, int clien=
t_margin,
+                       int64_t (*rng)(void), struct gc_arena *gc=
)
+{
+    if (n <=3D 1)
+    {
+        return;
+    }
+
+    /* Base order=
: responders first, grouped by priority, RTT-sorted within=2E */
+    qsort=
(results, (size_t)n, sizeof(*results), oob_probe_result_compare);
+
+    /*=
 Reorder each priority run of responders by candidate-band + weight=2E */
+=
    int i =3D 0;
+    while (i < n && results[i]=2Eresponded)
+    {
+     =
   int j =3D i;
+        while (j < n && results[j]=2Eresponded
+          =
     && results[j]=2Ereply=2Epriority =3D=3D results[i]=2Ereply=2Epriority)=

+        {
+            j++;
+        }
+        oob_order_priority_run(re=
sults + i, j - i, client_margin, rng, gc);
+        i =3D j;
+    }
+}
diff=
 --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh
index 3677149=2E=2Ef7e9e=
d6 100644
--- a/src/openvpn/oob=2Eh
+++ b/src/openvpn/oob=2Eh
@@ -158,4 +15=
8,50 @@
 enum oob_probe_verdict oob_server_probe_check(struct buffer *probe=
_payload, uint64_t now,
                                               uint=
64_t window_secs, struct oob_probe_request *req);
 
+/* Outcome of probing =
one remote, used to order remotes best-first=2E @index is
+ * the caller's =
identifier for the remote (e=2Eg=2E its position in the connection
+ * list=
); priority/weight are only meaningful when @responded is true=2E */
+struc=
t oob_probe_result
+{
+    int index;
+    bool responded;
+    unsigned in=
t rtt_ms;          /* probe round-trip time in ms (responders only) */
+   =
 struct oob_probe_reply reply; /* the values the server advertised */
+};
+=

+/**
+ * Order results best-first, in place, per the server-probe selectio=
n policy:
+ *   - remotes that responded rank before those that did not (no=
n-responders keep
+ *     their original relative order, last);
+ *   - res=
ponders are grouped by priority, lowest priority value first (an
+ *     ab=
solute ordering, never overridden by latency or weight);
+ *   - within a p=
riority group, the "candidates" are the responders whose RTT is
+ *     no =
more than the fastest remote's margin larger than its RTT (see
+ *     oob_=
effective_margin()), so the fastest is always one=2E Candidates are
+ *    =
 ordered ahead of non-candidates;
+ *   - candidates are ordered by DNS-SRV=
 (RFC 2782) weighted-random selection by
+ *     weight, so a server is cho=
sen first with probability proportional to its
+ *     weight (load distrib=
ution)=2E Non-candidates follow, ordered by RTT=2E
+ *
+ * @param results  =
      results to reorder in place
+ * @param n              number of resul=
ts
+ * @param client_margin  client's candidate-band margin in ms, or < 0 i=
f the
+ *                        client did not set one (see oob_effective_=
margin())
+ * @param rng            returns a non-negative random value (e=
=2Eg=2E get_random);
+ *                       injected so this module stay=
s free of the crypto layer
+ *                       and the weighted order=
ing is deterministically testable
+ * @param gc             arena for scrat=
ch allocation
+ */
+void oob_rank_probe_results(struct oob_probe_result *re=
sults, int n, int client_margin,
+                            int64_t (*rng=
)(void), struct gc_arena *gc);
+
+/**
+ * The candidate-band margin (ms) of=
 a priority group -- how much slower than
+ * the group's fastest remote an=
other remote may be and still be a candidate=2E
+ * The client's own settin=
g is authoritative; when client_margin < 0 the
+ * max_latency_diff adverti=
sed by the fastest remote (r) applies to the whole
+ * group=2E 0 then admi=
ts only remotes tying the fastest=2E
+ */
+int oob_effective_margin(const s=
truct oob_probe_result *r, int client_margin);
+
 #endif /* OOB_H */
diff -=
-git a/tests/unit_tests/openvpn/test_oob=2Ec b/tests/unit_tests/openvpn/tes=
t_oob=2Ec
index 130022a=2E=2E22826b4 100644
--- a/tests/unit_tests/openvpn/=
test_oob=2Ec
+++ b/tests/unit_tests/openvpn/test_oob=2Ec
@@ -648,6 +648,267=
 @@
     gc_free(&gc);
 }
 
+/* Deterministic RNG stubs for the weighted-se=
lection ordering=2E rank_rng_zero
+ * makes the weighted draw always pick t=
he first remaining candidate, preserving
+ * order; rank_rng_fixed returns =
a value we set to land in a chosen weight slice=2E */
+static int64_t
+rank=
_rng_zero(void)
+{
+    return 0;
+}
+
+static int64_t rank_rng_value;
+sta=
tic int64_t
+rank_rng_fixed(void)
+{
+    return rank_rng_value;
+}
+
+/* P=
icking a weighted entry must not disturb the RTT order of the entries it
+ =
* was picked ahead of: RFC 2782 removes the selection, it does not swap=2E =
*/
+static void
+test_rank_weighted_keeps_rtt_order_of_rest(void **state)
+=
{
+    struct gc_arena gc =3D gc_new();
+    /* same priority, all in band;=
 only the slowest advertises a weight, so it
+     * is drawn first and the=
 two weight-0 entries must follow in RTT order=2E */
+    struct oob_probe_=
result r[] =3D {
+        { =2Eindex =3D 0, =2Eresponded =3D true, =2Ertt_m=
s =3D 20, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 0 } },
+        =
{ =2Eindex =3D 1, =2Eresponded =3D true, =2Ertt_ms =3D 30, =2Ereply =3D { =
=2Epriority =3D 10, =2Eweight =3D 0 } },
+        { =2Eindex =3D 2, =2Eresp=
onded =3D true, =2Ertt_ms =3D 40, =2Ereply =3D { =2Epriority =3D 10, =2Ewei=
ght =3D 10 } },
+    };
+
+    rank_rng_value =3D 0;
+    oob_rank_probe_re=
sults(r, 3, 100, rank_rng_fixed, &gc);
+
+    assert_int_equal(r[0]=2Eindex=
, 2); /* the only weighted entry wins the draw */
+    assert_int_equal(r[1=
]=2Eindex, 0); /* 20 ms before 30 ms */
+    assert_int_equal(r[2]=2Eindex,=
 1);
+
+    gc_free(&gc);
+}
+
+/* Responders rank ahead of non-responders =
regardless of index order=2E */
+static void
+test_rank_responder_before_no=
nresponder(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    stru=
ct oob_probe_result r[] =3D {
+        { =2Eindex =3D 0, =2Eresponded =3D f=
alse },
+        { =2Eindex =3D 1, =2Eresponded =3D true, =2Ereply =3D { =
=2Epriority =3D 100, =2Eweight =3D 50 } },
+    };
+    oob_rank_probe_resu=
lts(r, 2, 10, rank_rng_zero, &gc);
+    assert_int_equal(r[0]=2Eindex, 1);
=
+    assert_int_equal(r[1]=2Eindex, 0);
+    gc_free(&gc);
+}
+
+/* Among r=
esponders, the lowest priority value wins (an absolute ordering)=2E */
+sta=
tic void
+test_rank_by_priority(void **state)
+{
+    struct gc_arena gc =
=3D gc_new();
+    struct oob_probe_result r[] =3D {
+        { =2Eindex =
=3D 0, =2Eresponded =3D true, =2Ereply =3D { =2Epriority =3D 20, =2Eweight =
=3D 50 } },
+        { =2Eindex =3D 1, =2Eresponded =3D true, =2Ereply =3D =
{ =2Epriority =3D 5, =2Eweight =3D 50 } },
+        { =2Eindex =3D 2, =2Ere=
sponded =3D true, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 50 } },
=
+    };
+    oob_rank_probe_results(r, 3, 10, rank_rng_zero, &gc);
+    ass=
ert_int_equal(r[0]=2Eindex, 1); /* priority 5 */
+    assert_int_equal(r[1]=
=2Eindex, 2); /* priority 10 */
+    assert_int_equal(r[2]=2Eindex, 0); /* =
priority 20 */
+    gc_free(&gc);
+}
+
+/* Within a priority, only servers =
within the latency margin of the fastest are
+ * candidates; a slower (out-=
of-band) server ranks behind a faster one no matter
+ * how large its weigh=
t=2E */
+static void
+test_rank_candidate_band(void **state)
+{
+    struct=
 gc_arena gc =3D gc_new();
+    struct oob_probe_result r[] =3D {
+        =
{ =2Eindex =3D 0, =2Eresponded =3D true, =2Ertt_ms =3D 100, =2Ereply =3D { =
=2Epriority =3D 10, =2Eweight =3D 1000 } },
+        { =2Eindex =3D 1, =2Er=
esponded =3D true, =2Ertt_ms =3D 20, =2Ereply =3D { =2Epriority =3D 10, =2E=
weight =3D 1 } },
+    };
+    /* margin 10ms: 20ms is fastest; 100ms is 80=
ms slower -> out of band */
+    oob_rank_probe_results(r, 2, 10, rank_rng_=
zero, &gc);
+    assert_int_equal(r[0]=2Eindex, 1); /* fast, in-band, despi=
te tiny weight */
+    assert_int_equal(r[1]=2Eindex, 0); /* slow, out-of-b=
and, despite huge weight */
+    gc_free(&gc);
+}
+
+/* A server widens its=
 own band via the advertised max_latency_diff, joining the
+ * candidate se=
t even when it is well behind the fastest; it then participates in
+ * the =
weighted selection=2E */
+/* A client margin, even 0, overrides whatever th=
e servers advertise=2E */
+static void
+test_rank_client_margin_overrides_a=
dvertised(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struc=
t oob_probe_result r[] =3D {
+        { =2Eindex =3D 0, =2Eresponded =3D tr=
ue, =2Ertt_ms =3D 20, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 1 } =
},
+        { =2Eindex =3D 1,
+          =2Eresponded =3D true,
+          =
=2Ertt_ms =3D 100,
+          =2Ereply =3D { =2Epriority =3D 10, =2Eweight =
=3D 1000, =2Emax_latency_diff =3D 200 } },
+    };
+    /* With the adverti=
sed 200 ms the slow server would be a candidate (see
+     * test_rank_adve=
rtised_margin); the client's 0 leaves only the fastest=2E */
+    rank_rng_=
value =3D 500;
+    oob_rank_probe_results(r, 2, 0, rank_rng_fixed, &gc);
+=
    assert_int_equal(r[0]=2Eindex, 0);
+    assert_int_equal(r[1]=2Eindex, =
1);
+    gc_free(&gc);
+}
+
+static void
+test_rank_advertised_margin(void =
**state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct oob_probe_res=
ult r[] =3D {
+        { =2Eindex =3D 0,
+          =2Eresponded =3D true,
=
+          =2Ertt_ms =3D 20,
+          =2Ereply =3D { =2Epriority =3D 10, =
=2Eweight =3D 1, =2Emax_latency_diff =3D 200 } },
+        { =2Eindex =3D 1=
, =2Eresponded =3D true, =2Ertt_ms =3D 100, =2Ereply =3D { =2Epriority =3D =
10, =2Eweight =3D 1000 } },
+    };
+    /* Client did not set a margin (-1=
), so the fastest server's advertised
+     * value applies: it says 200, s=
o the 100ms server is a candidate 80ms
+     * behind it; with weight 1000 =
(slice [1,1001)) a draw of 500 selects it
+     * first=2E */
+    rank_rng=
_value =3D 500;
+    oob_rank_probe_results(r, 2, -1, rank_rng_fixed, &gc);=

+    assert_int_equal(r[0]=2Eindex, 1);
+    gc_free(&gc);
+}
+
+/* A slow=
er server's own margin does not admit it: with the fastest advertising
+ * =
0, the 100ms server is no candidate however wide its margin or heavy its
+ =
* weight=2E */
+static void
+test_rank_slower_servers_margin_has_no_effect(=
void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct oob_prob=
e_result r[] =3D {
+        { =2Eindex =3D 0, =2Eresponded =3D true, =2Ertt=
_ms =3D 20, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 1 } },
+      =
  { =2Eindex =3D 1,
+          =2Eresponded =3D true,
+          =2Ertt_ms =
=3D 100,
+          =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 1000, =
=2Emax_latency_diff =3D 200 } },
+    };
+    rank_rng_value =3D 500;
+    =
oob_rank_probe_results(r, 2, -1, rank_rng_fixed, &gc);
+    assert_int_equa=
l(r[0]=2Eindex, 0);
+    gc_free(&gc);
+}
+
+/* Among candidates, weight dr=
ives RFC-2782 proportional selection: a draw is
+ * mapped to the server wh=
ose cumulative weight slice it falls in=2E */
+static void
+test_rank_weigh=
ted_selection(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    /=
* equal priority and RTT -> both in band; weights 30 and 70, sum 100:
+    =
 * index 0 owns [0,30), index 1 owns [30,100)=2E */
+    const struct oob_p=
robe_result base[] =3D {
+        { =2Eindex =3D 0, =2Eresponded =3D true, =
=2Ertt_ms =3D 20, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 30 } },
=
+        { =2Eindex =3D 1, =2Eresponded =3D true, =2Ertt_ms =3D 20, =2Erepl=
y =3D { =2Epriority =3D 10, =2Eweight =3D 70 } },
+    };
+    struct oob_p=
robe_result r[2];
+
+    memcpy(r, base, sizeof(base));
+    rank_rng_value=
 =3D 10; /* falls in index 0's slice */
+    oob_rank_probe_results(r, 2, 5=
0, rank_rng_fixed, &gc);
+    assert_int_equal(r[0]=2Eindex, 0);
+
+    mem=
cpy(r, base, sizeof(base));
+    rank_rng_value =3D 50; /* falls in index 1=
's slice */
+    oob_rank_probe_results(r, 2, 50, rank_rng_fixed, &gc);
+  =
  assert_int_equal(r[0]=2Eindex, 1);
+
+    gc_free(&gc);
+}
+
+/* The fast=
est advertising 0 means "compare on latency alone": the band is
+ * empty, =
so weight cannot float a slower peer ahead of it=2E The same pair with a
+ =
* band advertised does let weight decide=2E */
+static void
+test_rank_adve=
rtised_zero_margin(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+=
    const struct oob_probe_result base[] =3D {
+        { =2Eindex =3D 0, =
=2Eresponded =3D true, =2Ertt_ms =3D 20, =2Ereply =3D { =2Epriority =3D 10,=
 =2Eweight =3D 1 } },
+        { =2Eindex =3D 1, =2Eresponded =3D true, =2E=
rtt_ms =3D 40, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 1000 } },
+=
    };
+    struct oob_probe_result r[2];
+
+    memcpy(r, base, sizeof(bas=
e));
+    rank_rng_value =3D 500;
+    oob_rank_probe_results(r, 2, -1, ran=
k_rng_fixed, &gc);
+    assert_int_equal(r[0]=2Eindex, 0); /* both advertis=
e 0 -> fastest wins */
+
+    memcpy(r, base, sizeof(base));
+    r[0]=2Ere=
ply=2Emax_latency_diff =3D 50;
+    r[1]=2Ereply=2Emax_latency_diff =3D 50;=

+    rank_rng_value =3D 500;            /* falls in the weight-1000 slice =
[1,1001) */
+    oob_rank_probe_results(r, 2, -1, rank_rng_fixed, &gc);
+  =
  assert_int_equal(r[0]=2Eindex, 1); /* 20ms behind but inside a 50ms band =
*/
+
+    gc_free(&gc);
+}
+
+/* Remotes tied at the fastest RTT are all ca=
ndidates even at margin 0, so weight
+ * still distributes load between the=
m=2E */
+static void
+test_rank_zero_margin_weights_ties(void **state)
+{
+=
    struct gc_arena gc =3D gc_new();
+    struct oob_probe_result r[] =3D {=

+        { =2Eindex =3D 0, =2Eresponded =3D true, =2Ertt_ms =3D 20, =2Erep=
ly =3D { =2Epriority =3D 10, =2Eweight =3D 1, =2Emax_latency_diff =3D 0 } }=
,
+        { =2Eindex =3D 1, =2Eresponded =3D true, =2Ertt_ms =3D 20, =2Ere=
ply =3D { =2Epriority =3D 10, =2Eweight =3D 1000, =2Emax_latency_diff =3D 0=
 } },
+    };
+    rank_rng_value =3D 500; /* falls in the weight-1000 slic=
e [1,1001) */
+    oob_rank_probe_results(r, 2, -1, rank_rng_fixed, &gc);
+=
    assert_int_equal(r[0]=2Eindex, 1);
+    gc_free(&gc);
+}
+
+/* A remote=
 exactly its advertised margin behind the fastest is still a candidate
+ * =
("no more than max_latency_diff larger than the lowest RTT")=2E */
+static =
void
+test_rank_margin_boundary_is_inclusive(void **state)
+{
+    struct g=
c_arena gc =3D gc_new();
+    struct oob_probe_result r[] =3D {
+        { =
=2Eindex =3D 0, =2Eresponded =3D true, =2Ertt_ms =3D 20, =2Ereply =3D { =2E=
priority =3D 10, =2Eweight =3D 1, =2Emax_latency_diff =3D 10 } },
+        =
{ =2Eindex =3D 1, =2Eresponded =3D true, =2Ertt_ms =3D 30, =2Ereply =3D { =
=2Epriority =3D 10, =2Eweight =3D 1000, =2Emax_latency_diff =3D 10 } },
+  =
  };
+    rank_rng_value =3D 500;
+    oob_rank_probe_results(r, 2, -1, ran=
k_rng_fixed, &gc);
+    assert_int_equal(r[0]=2Eindex, 1); /* exactly 10ms =
behind, in band, wins on weight */
+    gc_free(&gc);
+}
+
+/* Non-responde=
rs are placed last, keeping their original relative order=2E */
+static voi=
d
+test_rank_nonresponders_last(void **state)
+{
+    struct gc_arena gc =
=3D gc_new();
+    struct oob_probe_result r[] =3D {
+        { =2Eindex =
=3D 0, =2Eresponded =3D false },
+        { =2Eindex =3D 1, =2Eresponded =
=3D true, =2Ertt_ms =3D 20, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =
=3D 50 } },
+        { =2Eindex =3D 2, =2Eresponded =3D false },
+        {=
 =2Eindex =3D 3, =2Eresponded =3D true, =2Ertt_ms =3D 20, =2Ereply =3D { =
=2Epriority =3D 10, =2Eweight =3D 50 } },
+    };
+    oob_rank_probe_resul=
ts(r, 4, 10, rank_rng_zero, &gc);
+    assert_int_equal(r[0]=2Eindex, 1); /=
* responder (rng_zero keeps order) */
+    assert_int_equal(r[1]=2Eindex, 3=
); /* responder */
+    assert_int_equal(r[2]=2Eindex, 0); /* non-responder=
, original order kept */
+    assert_int_equal(r[3]=2Eindex, 2);
+    gc_fr=
ee(&gc);
+}
+
 /* The OOB tests run as a second group of pkt_testdriver; se=
e test_pkt=2Ec=2E */
 int
 run_oob_tests(void)
@@ -679,6 +940,18 @@
       =
  cmocka_unit_test(test_client_reply_read_rejects_unknown_mandatory),
     =
    cmocka_unit_test(test_client_reply_read_missing),
         cmocka_unit_=
test(test_client_reply_read_request_tlv),
+        cmocka_unit_test(test_ra=
nk_responder_before_nonresponder),
+        cmocka_unit_test(test_rank_by_p=
riority),
+        cmocka_unit_test(test_rank_candidate_band),
+        cmo=
cka_unit_test(test_rank_advertised_margin),
+        cmocka_unit_test(test_=
rank_client_margin_overrides_advertised),
+        cmocka_unit_test(test_ra=
nk_advertised_zero_margin),
+        cmocka_unit_test(test_rank_slower_serv=
ers_margin_has_no_effect),
+        cmocka_unit_test(test_rank_zero_margin_=
weights_ties),
+        cmocka_unit_test(test_rank_margin_boundary_is_inclu=
sive),
+        cmocka_unit_test(test_rank_weighted_selection),
+        cm=
ocka_unit_test(test_rank_weighted_keeps_rtt_order_of_rest),
+        cmocka=
_unit_test(test_rank_nonresponders_last),
     };
 
     return cmocka_run_=
group_tests_name("oob tests", tests, NULL, NULL);

-- 
To view, visit http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1746?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-=
Branch: master
Gerrit-Change-Id: I55da68cc341bcfc707fd34ca2f84ff9b6a55501f
=
Gerrit-Change-Number: 1746
Gerrit-PatchSet: 23
Gerrit-Owner: stipa <lstipak=
ov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <op=
envpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: ralf_lici <ralf@ma=
ndelbit=2Ecom>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--9oAQ98ZuL0E=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici=2E </p>
<p>stipa <strong>uploade=
d patch set #23</strong> to this change=2E</p><p><a href=3D"http://gerrit=
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
es rank ahead of non-candidates;<br>  - candidates are ordered by RFC 2782 =
weighted-random selection by<br>    weight, so a server is chosen first wit=
h probability proportional to<br>    its weight (load distribution); non-ca=
ndidates follow, ordered by<br>    RTT=2E<br><br>oob_effective_margin() dec=
ides that margin: the client&#39;s own margin if<br>it set one (--server-pr=
obe, added later), otherwise the max_latency_diff<br>advertised by the fast=
est server of the group, where 0 admits only the<br>servers tying it=2E<br>=
<br>The RNG is injected as a function pointer so this module stays free of<=
br>the crypto layer and the weighted ordering is deterministically<br>unit-=
testable=2E<br><br>Exercised by unit tests; the client probe path calls it =
in a follow-up,<br>and measures RTT in a later one -- until then every resp=
onder sits in<br>the band and selection is purely weighted-random=2E<br><br=
>Change-Id: I55da68cc341bcfc707fd34ca2f84ff9b6a55501f<br>Signed-off-by: Lev=
 Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M src/openvpn/oob=2Ec<br>M sr=
c/openvpn/oob=2Eh<br>M tests/unit_tests/openvpn/test_oob=2Ec<br>3 files cha=
nged, 480 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/46/1746/23</pre><p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span=
>diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec</span><br><span>ind=
ex a02ce51=2E=2E6920801 100644</span><br><span>--- a/src/openvpn/oob=2Ec</s=
pan><br><span>+++ b/src/openvpn/oob=2Ec</span><br><span>@@ -118,3 +118,164 =
@@</span><br><span>     return oob_timestamp_in_window(req-&gt;timestamp, n=
ow, window_secs) ? OOB_PROBE_OK</span><br><span>                           =
                                           : OOB_PROBE_STALE;</span><br><sp=
an> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/* Base ordering: responders befo=
re non-responders, then by priority (lower</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * first), then by RTT (lower first), then by origin=
al index for determinism=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * This groups responders into priority runs pre-sorted by RTT, whi=
ch the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * candidate-=
band step below relies on (run[0] is the fastest in its group)=2E */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+oob_probe_result_compare(const void=
 *a, const void *b)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct o=
ob_probe_result *ra =3D a;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    const struct oob_probe_result *rb =3D b;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (ra-&gt;responded &amp;&amp; rb-&gt;responded)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        /* both answered: lowest priorit=
y first, then lowest RTT */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if (ra-&gt;reply=2Epriority !=3D rb-&gt;reply=2Epriority)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            return ra-&gt;reply=
=2Epriority &lt; rb-&gt;reply=2Epriority ? -1 : 1;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if (ra-&gt;rtt_ms !=3D rb-&gt;rtt_ms)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            return ra-&gt;rtt_ms &lt; =
rb-&gt;rtt_ms ? -1 : 1;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (ra-&gt;=
responded)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        return -1; /* o=
nly a answered: it ranks first */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    else if (rb-&gt;responded)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     return 1; /* only b answered */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* neither a=
nswered, or all keys equal: keep the configured order */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    return ra-&gt;index - rb-&gt;index=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+oob_effective_margin(const struct oob_probe_result *r, int client_margi=
n)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (client_margin &gt;=3D 0)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return client_margin;       =
       /* the client&#39;s own setting is authoritative */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    return (int)r-&gt;reply=2Emax_latency_diff; /*=
 else what the fastest remote advertised */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Reorder th=
e index list idx[0=2E=2Em) into DNS-SRV (RFC 2782) weighted-random</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * order by results[idx[k]]=
=2Ereply=2Eweight: each position is filled by a remaining entry</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * chosen with probability prop=
ortional to its weight=2E When all remaining</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * weights are 0 the current (RTT-sorted) order is=
 kept=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static v=
oid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_weighted_ord=
er(const struct oob_probe_result *results, int *idx, int m, int64_t (*rng)(=
void))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    for (int pos =3D 0; pos &lt=
; m; pos++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        long sum =3D 0=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (int k=
 =3D pos; k &lt; m; k++)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       sum +=3D results[idx[k]]=2Ereply=2Eweight;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        int chosen =3D pos;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if (sum &gt; 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            int64_t r =3D rng() % sum; /* uniform i=
n [0, sum) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      long acc =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            for (int k =3D pos; k &lt; m; k++)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                acc +=3D results[idx[k]]=2Ereply=2Ew=
eight;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   if (acc &gt; r)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                 chosen =3D k;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                    break;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        /* Move the chosen entry to pos, keeping the rest in RTT order (RFC=
 2782</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * rem=
oves the selected entry from the list)=2E */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        int sel =3D idx[chosen];</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        for (int k =3D chosen; k &gt;=
 pos; k--)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            idx[k] =
=3D idx[k - 1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        idx[po=
s] =3D sel;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/* Reorder one priority run (run[0=2E=2Em), already RTT-sor=
ted) in place:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * ca=
ndidates (RTT within the band of the fastest) first, ordered by weighted</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * random; then non-ca=
ndidates in RTT order=2E */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
oob_order_priority_run(struct oob_probe_result *run, int m, int client_marg=
in, int64_t (*rng)(void),</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                       struct gc_arena *gc)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (m &lt;=3D 1)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    unsigned int best_rtt =3D run[0]=
=2Ertt_ms; /* run is RTT-sorted: [0] is fastest */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    int *cand =3D gc_malloc(sizeof(int) * m, false, gc);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    int *non =3D gc_malloc=
(sizeof(int) * m, false, gc);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    int nc =3D 0;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    int nn =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* The fastest remote&#39;s margin sets the band; inclusive, so t=
he fastest is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *=
 always a candidate, also when it advertises 0=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const unsigned int margin =3D (unsign=
ed int)oob_effective_margin(&amp;run[0], client_margin);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    for (int k =3D 0; k &lt; m; k++)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        unsigned int gap =3D run[k]=
=2Ertt_ms - best_rtt;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        if (gap &lt;=3D margin)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            cand[nc++] =3D k;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            n=
on[nn++] =3D k;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    oob_weighted_order(run, cand, nc, rng);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
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
openvpn/oob=2Eh b/src/openvpn/oob=2Eh</span><br><span>index 3677149=2E=2Ef7=
e9ed6 100644</span><br><span>--- a/src/openvpn/oob=2Eh</span><br><span>+++ =
b/src/openvpn/oob=2Eh</span><br><span>@@ -158,4 +158,50 @@</span><br><span>=
 enum oob_probe_verdict oob_server_probe_check(struct buffer *probe_payload=
, uint64_t now,</span><br><span>                                           =
    uint64_t window_secs, struct oob_probe_request *req);</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Outcome of probi=
ng one remote, used to order remotes best-first=2E @index is</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * the caller&#39;s identifier for=
 the remote (e=2Eg=2E its position in the connection</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * list); priority/weight are only meanin=
gful when @responded is true=2E */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+struct oob_probe_result</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    int index;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
bool responded;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
unsigned int rtt_ms;          /* probe round-trip time in ms (responders on=
ly) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oo=
b_probe_reply reply; /* the values the server advertised */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Order res=
ults best-first, in place, per the server-probe selection policy:</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *   - remotes that responded=
 rank before those that did not (non-responders keep</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *     their original relative order, las=
t);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   - responder=
s are grouped by priority, lowest priority value first (an</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *     absolute ordering, never over=
ridden by latency or weight);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *   - within a priority group, the &quot;candidates&quot; are th=
e responders whose RTT is</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *     no more than the fastest remote&#39;s margin larger than its R=
TT (see</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *     oob_e=
ffective_margin()), so the fastest is always one=2E Candidates are</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *     ordered ahead of non-=
candidates;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   - c=
andidates are ordered by DNS-SRV (RFC 2782) weighted-random selection by</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *     weight, so a se=
rver is chosen first with probability proportional to its</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *     weight (load distribution)=2E =
Non-candidates follow, ordered by RTT=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @param results        results to reorder in place</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @param n              number of res=
ults</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param clien=
t_margin  client&#39;s candidate-band margin in ms, or &lt; 0 if the</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *                        =
client did not set one (see oob_effective_margin())</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param rng            returns a non-ne=
gative random value (e=2Eg=2E get_random);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *                       injected so this module sta=
ys free of the crypto layer</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *                       and the weighted ordering is deterministic=
ally testable</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @pa=
ram gc             arena for scratch allocation</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+void oob_rank_probe_results(struct oob_probe_result *results, i=
nt n, int client_margin,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                            int64_t (*rng)(void), struct gc_arena *gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * The candidate-band margin (ms) of a priority group=
 -- how much slower than</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * the group&#39;s fastest remote another remote may be and still be a=
 candidate=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The=
 client&#39;s own setting is authoritative; when client_margin &lt; 0 the</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * max_latency_diff a=
dvertised by the fastest remote (r) applies to the whole</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * group=2E 0 then admits only remotes=
 tying the fastest=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int oob_effect=
ive_margin(const struct oob_probe_result *r, int client_margin);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* OO=
B_H */</span><br><span>diff --git a/tests/unit_tests/openvpn/test_oob=2Ec b=
/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>index 130022a=2E=2E2=
2826b4 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_oob=2Ec</=
span><br><span>+++ b/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>=
@@ -648,6 +648,267 @@</span><br><span>     gc_free(&amp;gc);</span><br><spa=
n> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/* Deterministic RNG stubs for the weighted-selection ordering=2E rank_r=
ng_zero</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * makes the=
 weighted draw always pick the first remaining candidate, preserving</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * order; rank_rng_fixed r=
eturns a value we set to land in a chosen weight slice=2E */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static int64_t</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+rank_rng_zero(void)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    return 0;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+static int64_t rank_rng_v=
alue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static int64_t=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+rank_rng_fixed(void=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    return rank_rng_value;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/* Picking a weighted entry must not disturb the RTT order of the =
entries it</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * was pi=
cked ahead of: RFC 2782 removes the selection, it does not swap=2E */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+test_rank_weighted_keeps_rtt_orde=
r_of_rest(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_=
arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* same priority, all in band; only the slowest advertises a weight,=
 so it</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * is dra=
wn first and the two weight-0 entries must follow in RTT order=2E */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_resul=
t r[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
{ =2Eindex =3D 0, =2Eresponded =3D true, =2Ertt_ms =3D 20, =2Ereply =3D { =
=2Epriority =3D 10, =2Eweight =3D 0 } },</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        { =2Eindex =3D 1, =2Eresponded =3D true, =2Ert=
t_ms =3D 30, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 0 } },</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        { =2Eindex =3D 2, =
=2Eresponded =3D true, =2Ertt_ms =3D 40, =2Ereply =3D { =2Epriority =3D 10,=
 =2Eweight =3D 10 } },</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    rank_rng_value =3D 0;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    oob_rank_probe_resu=
lts(r, 3, 100, rank_rng_fixed, &amp;gc);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_int_equal(r[0]=2Eindex, 2); /* the only weighted entry wins th=
e draw */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_int_equal(r[1]=2Eindex, 0); /* 20 ms before 30 ms */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(r[2]=2Eindex, 1);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
* Responders rank ahead of non-responders regardless of index order=2E */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+test_rank_responder_before_no=
nresponder(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc=
_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct oob_probe_result r[] =3D {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        { =2Eindex =3D 0, =2Eresponded =3D false },</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        { =2Eindex =
=3D 1, =2Eresponded =3D true, =2Ereply =3D { =2Epriority =3D 100, =2Eweight=
 =3D 50 } },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    oob_rank_probe_r=
esults(r, 2, 10, rank_rng_zero, &amp;gc);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_int_equal(r[0]=2Eindex, 1);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(r[1]=2Eindex,=
 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&am=
p;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/* Among responders, the lowest priority value win=
s (an absolute ordering)=2E */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+test_rank_by_priority(void **state)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct oob_probe_result r[] =3D {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        { =2Eindex =3D 0, =2Eresponded =
=3D true, =2Ereply =3D { =2Epriority =3D 20, =2Eweight =3D 50 } },</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        { =2Eindex =3D 1, =
=2Eresponded =3D true, =2Ereply =3D { =2Epriority =3D 5, =2Eweight =3D 50 }=
 },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        { =2Eind=
ex =3D 2, =2Eresponded =3D true, =2Ereply =3D { =2Epriority =3D 10, =2Eweig=
ht =3D 50 } },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    oob_rank_probe=
_results(r, 3, 10, rank_rng_zero, &amp;gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_int_equal(r[0]=2Eindex, 1); /* priority =
5 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_=
equal(r[1]=2Eindex, 2); /* priority 10 */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_int_equal(r[2]=2Eindex, 0); /* priority 20=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp=
;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/* Within a priority, only servers within the laten=
cy margin of the fastest are</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * candidates; a slower (out-of-band) server ranks behind a faster=
 one no matter</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * ho=
w large its weight=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tes=
t_rank_candidate_band(void **state)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct oob_probe_result r[] =3D {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        { =2Eindex =3D 0, =2Eresponded =
=3D true, =2Ertt_ms =3D 100, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =
=3D 1000 } },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  { =2Eindex =3D 1, =2Eresponded =3D true, =2Ertt_ms =3D 20, =2Ereply =3D {=
 =2Epriority =3D 10, =2Eweight =3D 1 } },</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* margin 10ms: 20ms is fastest; 100ms is 80ms slower -&gt; ou=
t of band */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    oob=
_rank_probe_results(r, 2, 10, rank_rng_zero, &amp;gc);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(r[0]=2Eindex, 1); /=
* fast, in-band, despite tiny weight */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_int_equal(r[1]=2Eindex, 0); /* slow, out-of-=
band, despite huge weight */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/* A server widens its own=
 band via the advertised max_latency_diff, joining the</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * candidate set even when it is well be=
hind the fastest; it then participates in</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * the weighted selection=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* A client margin, even 0, overrides wha=
tever the servers advertise=2E */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+test_rank_client_margin_overrides_advertised(void **state)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_result r[]=
 =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        { =2E=
index =3D 0, =2Eresponded =3D true, =2Ertt_ms =3D 20, =2Ereply =3D { =2Epri=
ority =3D 10, =2Eweight =3D 1 } },</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        { =2Eindex =3D 1,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+          =2Eresponded =3D true,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+          =2Ertt_ms =3D 100,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+          =2Ereply =3D { =2Eprio=
rity =3D 10, =2Eweight =3D 1000, =2Emax_latency_diff =3D 200 } },</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* With the advertised 200 ms the slo=
w server would be a candidate (see</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * test_rank_advertised_margin); the client&#39;s 0 leav=
es only the fastest=2E */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    rank_rng_value =3D 500;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    oob_rank_probe_results(r, 2, 0, rank_rng_fixed, &amp;gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equa=
l(r[0]=2Eindex, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_int_equal(r[1]=2Eindex, 1);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+test_rank_advertised_mar=
gin(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena =
gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct oob_probe_result r[] =3D {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        { =2Eindex =3D 0,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+          =2Eresponded =3D true,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+          =2Ertt_ms =3D 20,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+          =2Ereply =3D { =2Eprior=
ity =3D 10, =2Eweight =3D 1, =2Emax_latency_diff =3D 200 } },</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        { =2Eindex =3D 1, =2Eresp=
onded =3D true, =2Ertt_ms =3D 100, =2Ereply =3D { =2Epriority =3D 10, =2Ewe=
ight =3D 1000 } },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Client =
did not set a margin (-1), so the fastest server&#39;s advertised</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     * value applies: it says=
 200, so the 100ms server is a candidate 80ms</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     * behind it; with weight 1000 (slice [1,1001=
)) a draw of 500 selects it</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     * first=2E */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    rank_rng_value =3D 500;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    oob_rank_probe_results(r, 2, -1, rank_rng_fixed, &amp;gc=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_eq=
ual(r[0]=2Eindex, 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/* A slower server&#39;s own marg=
in does not admit it: with the fastest advertising</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * 0, the 100ms server is no candidate howev=
er wide its margin or heavy its</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * weight=2E */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
test_rank_slower_servers_margin_has_no_effect(void **state)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_result r[] =3D =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        { =2Eindex=
 =3D 0, =2Eresponded =3D true, =2Ertt_ms =3D 20, =2Ereply =3D { =2Epriority=
 =3D 10, =2Eweight =3D 1 } },</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        { =2Eindex =3D 1,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+          =2Eresponded =3D true,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+          =2Ertt_ms =3D 100,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+          =2Ereply =3D { =2Epriority =
=3D 10, =2Eweight =3D 1000, =2Emax_latency_diff =3D 200 } },</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    rank_rng_value =3D 500;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    oob_rank_probe_results(r, 2, -1, ra=
nk_rng_fixed, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_int_equal(r[0]=2Eindex, 0);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Among can=
didates, weight drives RFC-2782 proportional selection: a draw is</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * mapped to the server whose=
 cumulative weight slice it falls in=2E */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+test_rank_weighted_selection(void **state)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* equal priority and RTT -&gt; bo=
th in band; weights 30 and 70, sum 100:</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     * index 0 owns [0,30), index 1 owns [30,100)=2E */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct oo=
b_probe_result base[] =3D {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        { =2Eindex =3D 0, =2Eresponded =3D true, =2Ertt_ms =3D 20, =
=2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 30 } },</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        { =2Eindex =3D 1, =2Eresponded=
 =3D true, =2Ertt_ms =3D 20, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =
=3D 70 } },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_=
result r[2];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(r, base, sizeof=
(base));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rank_rn=
g_value =3D 10; /* falls in index 0&#39;s slice */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    oob_rank_probe_results(r, 2, 50, rank_rn=
g_fixed, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_int_equal(r[0]=2Eindex, 0);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   memcpy(r, base, sizeof(base));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    rank_rng_value =3D 50; /* falls in index 1&#39;s slice */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    oob_rank_probe_=
results(r, 2, 50, rank_rng_fixed, &amp;gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_int_equal(r[0]=2Eindex, 1);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* The fast=
est advertising 0 means &quot;compare on latency alone&quot;: the band is</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * empty, so weight c=
annot float a slower peer ahead of it=2E The same pair with a</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * band advertised does let weigh=
t decide=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stati=
c void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_rank_adv=
ertised_zero_margin(void **state)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    const struct oob_probe_result base[] =3D {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        { =2Eindex =3D 0, =2Erespon=
ded =3D true, =2Ertt_ms =3D 20, =2Ereply =3D { =2Epriority =3D 10, =2Eweigh=
t =3D 1 } },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 { =2Eindex =3D 1, =2Eresponded =3D true, =2Ertt_ms =3D 40, =2Ereply =3D { =
=2Epriority =3D 10, =2Eweight =3D 1000 } },</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct oob_probe_result r[2];</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    memcpy(r, base, sizeof(base));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    rank_rng_value =3D 500;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    oob_rank_probe_results(r, 2, -1, rank_rng_=
fixed, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_int_equal(r[0]=2Eindex, 0); /* both advertise 0 -&gt; fastest wins =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    memcpy(r, base, sizeof(base));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r[0]=2Ereply=2Ema=
x_latency_diff =3D 50;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    r[1]=2Ereply=2Emax_latency_diff =3D 50;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    rank_rng_value =3D 500;            /* falls =
in the weight-1000 slice [1,1001) */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    oob_rank_probe_results(r, 2, -1, rank_rng_fixed, &amp;=
gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_=
equal(r[0]=2Eindex, 1); /* 20ms behind but inside a 50ms band */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Remote=
s tied at the fastest RTT are all candidates even at margin 0, so weight</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * still distributes l=
oad between them=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_=
rank_zero_margin_weights_ties(void **state)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct oob_probe_result r[] =3D {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        { =2Eindex =3D 0, =2Erespo=
nded =3D true, =2Ertt_ms =3D 20, =2Ereply =3D { =2Epriority =3D 10, =2Eweig=
ht =3D 1, =2Emax_latency_diff =3D 0 } },</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        { =2Eindex =3D 1, =2Eresponded =3D true, =2Ert=
t_ms =3D 20, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 1000, =2Emax_=
latency_diff =3D 0 } },</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rank_=
rng_value =3D 500; /* falls in the weight-1000 slice [1,1001) */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    oob_rank_probe_results(r, =
2, -1, rank_rng_fixed, &amp;gc);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_int_equal(r[0]=2Eindex, 1);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
* A remote exactly its advertised margin behind the fastest is still a cand=
idate</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * (&quot;no m=
ore than max_latency_diff larger than the lowest RTT&quot;)=2E */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+test_rank_margin_boundary_is_inclusiv=
e(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc=
 =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct oob_probe_result r[] =3D {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        { =2Eindex =3D 0, =2Eresponded =3D true, =2Ertt_ms =3D=
 20, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 1, =2Emax_latency_dif=
f =3D 10 } },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  { =2Eindex =3D 1, =2Eresponded =3D true, =2Ertt_ms =3D 30, =2Ereply =3D {=
 =2Epriority =3D 10, =2Eweight =3D 1000, =2Emax_latency_diff =3D 10 } },</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    rank_rng_value =3D 500;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    oob_rank_probe_results(=
r, 2, -1, rank_rng_fixed, &amp;gc);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_int_equal(r[0]=2Eindex, 1); /* exactly 10ms behi=
nd, in band, wins on weight */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Non-responders are pl=
aced last, keeping their original relative order=2E */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+test_rank_nonresponders_last(void **state)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_res=
ult r[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  { =2Eindex =3D 0, =2Eresponded =3D false },</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        { =2Eindex =3D 1, =2Eresponded =3D true, =
=2Ertt_ms =3D 20, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 50 } },<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        { =2Eindex =
=3D 2, =2Eresponded =3D false },</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        { =2Eindex =3D 3, =2Eresponded =3D true, =2Ertt_ms =3D=
 20, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 50 } },</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    oob_rank_probe_results(r, 4, 10, rank_rng_=
zero, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_int_equal(r[0]=2Eindex, 1); /* responder (rng_zero keeps order) */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(=
r[1]=2Eindex, 3); /* responder */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_int_equal(r[2]=2Eindex, 0); /* non-responder, orig=
inal order kept */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_int_equal(r[3]=2Eindex, 2);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span> /* The OOB tests run as a second group of pkt_testdrive=
r; see test_pkt=2Ec=2E */</span><br><span> int</span><br><span> run_oob_tes=
ts(void)</span><br><span>@@ -679,6 +940,18 @@</span><br><span>         cmoc=
ka_unit_test(test_client_reply_read_rejects_unknown_mandatory),</span><br><=
span>         cmocka_unit_test(test_client_reply_read_missing),</span><br><=
span>         cmocka_unit_test(test_client_reply_read_request_tlv),</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(te=
st_rank_responder_before_nonresponder),</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        cmocka_unit_test(test_rank_by_priority),</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(t=
est_rank_candidate_band),</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        cmocka_unit_test(test_rank_advertised_margin),</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_rank=
_client_margin_overrides_advertised),</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        cmocka_unit_test(test_rank_advertised_zero_margin=
),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_un=
it_test(test_rank_slower_servers_margin_has_no_effect),</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_rank_zero=
_margin_weights_ties),</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        cmocka_unit_test(test_rank_margin_boundary_is_inclusive),</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(t=
est_rank_weighted_selection),</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        cmocka_unit_test(test_rank_weighted_keeps_rtt_order_of_re=
st),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_=
unit_test(test_rank_nonresponders_last),</span><br><span>     };</span><br>=
<span> </span><br><span>     return cmocka_run_group_tests_name(&quot;oob t=
ests&quot;, tests, NULL, NULL);</span><br></pre><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1746?usp=3Demail">change 1746=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1746?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
55da68cc341bcfc707fd34ca2f84ff9b6a55501f </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1746 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 23 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstip=
akov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: p=
laisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Eso=
urceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: r=
alf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</bod=
y></html>
--9oAQ98ZuL0E=--


--===============2470088804155428979==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2470088804155428979==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2470088804155428979==--

