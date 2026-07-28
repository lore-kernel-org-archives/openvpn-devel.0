Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E28C54F4C
	for <openvpn-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E/RDTfW2jstzbP5mRGZGWTw8kn24WzsF2WKA+5KQOT0=; b=Y3PDwkB2Cr+DZsspLaLZIsfn8o
	tfULP+6pKgfXsq94RCeq3YJWUH+M3FV2SGBLdAFpFh6g86BRZdIa0AXvlhFyRg8hA+JwqXaunm8sX
	dBzhHe0GsrXZ4MA2c2qVgOwedWHcmsthsLTHBkBZURssRi+7euNekTZYMyn5bEX+gyU8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wojLZ-0001j7-3L;
	Tue, 28 Jul 2026 15:03:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wojLW-0001iw-WD
 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 15:03:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=H1XdYMoDbKYb2lgpZ5B7O8WoG2NkdtOeRUyBccMuEdQ=; b=HwUEXL8OaPl/GQqJ8KcGaJElqE
 0r7raTcvdoN2jYjsNcmI+LS7KKTqeuaCLXw9seztObIgl1nz3PVu12LcqqyXttGuqR7sxahKi/0pB
 jwwL2RFeg3qthpheTD9Zp7ex/K58P9KV3JqAA2Oa4mFRyju+jLtRiNYzKtJqUf5PeUBw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=H1XdYMoDbKYb2lgpZ5B7O8WoG2NkdtOeRUyBccMuEdQ=; b=H
 MALm11NGI/sJWxifo/vvKiGNy7OMX1sll/UUKTDnGnuabjepxvB7pOO4T1tYTMrPf+0/Zlwi3G1HY
 2n/G5jkNBb5+K0CCYVpDNHj4TUB8/xnhekXs9K7nIWIXUtXJJMiVbdGhtqgPYEehu3cPlysyUJYqY
 YcK9d7i6diSbVf+0=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wojLV-0000O1-Ep for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 15:03:55 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09aaso2302422f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 28 Jul 2026 08:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785251027; x=1785855827; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=H1XdYMoDbKYb2lgpZ5B7O8WoG2NkdtOeRUyBccMuEdQ=;
 b=SRe7vCP38bIb5YKMlwkWd18m0yCXegoWRK/aQb75DwLb8LzzfHB9iuKSN+jBwqFULI
 p0MW7bGCdWwp0xYheippKH4wQr2PhuPb+txKqBvxX2x9SnBzFYlq3iLrJf8shdKPQNdw
 jwjvmrMioXEjAPjNCn1EA9Z7BOqRl7Ox+oIK2iz4uypFTKW17UD2CZtnkBvEujUwT44H
 DQP8ynTnUY+IBVrnlfE4Y+w6UHKOScRoLEJYHHBcFTLqYNx67n5NRmCAGMzK2wKJTqLb
 VfB6+SyIpIddfgOZbfzPeIrfe6kQW8nasqSlxlEiyL20FwvrOsfXFneeA6thIhmccNyS
 haPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785251027; x=1785855827;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=H1XdYMoDbKYb2lgpZ5B7O8WoG2NkdtOeRUyBccMuEdQ=;
 b=jgNHLN+FffTIj3eoXlcm2n1gwMKkb12DDgPMvVR0n+MHCsb3Sts0Kk7ZlSCzvJxrLf
 s345981TbWcUUIRMSlBaf6Aly4kWbvsGaf9eE1ojB7ea0lZfSvr4sWBTzgp9v2MRa4/a
 L9AjNTjVzW16u+0jRemngatAPApN6F2T5aGHXfaBZAAFQ4O59VDfz+cWKph+ipDkUyDj
 QEbdFVS4NaN0HR4lDxYLnAyNx5oS72B5x+Zy+LYUV52rOMpDLt3UzAzIZO22PMjNJBQl
 COu1DNxTqBGHgw+DLuPuqFSmgO+Iv73SLMSEVWM0RsfLQlxV0diPDXc8WiPwoxMdVRhO
 48wg==
X-Gm-Message-State: AOJu0YwBTvvmw4wSsSNC1bfydFF2cysWhsSv6uta5K8NRZGOZGn1HKct
 hJZa6jic5cW+kJonAr6B1PI51eOWYj8vgNm2tqJbx1rpG9JyO2tQhHwwxhup4i4YkvJfrE/UzQ9
 P4MrbSAV1Yly+AIN/3MMJuch9bb0J/PRbG9BD7wPjOgvAHGYqXMK+8RrXuPUv1Cfr0pEz
X-Gm-Gg: AR+sD11a+O97CN6GjA9ONL8VJ7+THXMNB1JCVyxlWgFWNFsuTqZPQ1CRDsmiHD1y9xI
 uaRaRSiib8fGLlEeiJ7gBEk2oP49G7TtCpkmGS8U5d9ouqjUZA7GJrZ0q9nnrSXH4XqmWJoys+e
 89MXJSJfpyfwaeJvT81kPXHgl7jTTjSPwijDZwz2R1s7/yae1F8pCyUsmjRwcYcbRf1wBac0Po8
 SkkSmxdAZ2kauZLFBMHoU21aq5cw8ywJ+/eNUbj653Ajps1BK8y1Dw1h/A0hkWILmzerCWaCdNV
 hgA9tpygjwF38gmNfi74TM8V7ZiKBaGdCadecAmPYN+uCARnKYi9rJaI9pHt/0M6BKPByUJMAZi
 STLa+flWDrCEm2ESRE+JN8rNp262TYpUEjnRZhD09c1+Ia4x5QYiV+QJAiTu6gUFhO+28JmnlZO
 sMUoBvQM7gsukvm6u6/8BNyrvtu3kvjeH4p7WrHEovQwfm51lDM2SkmKIrPWN5oj1RXbQ1L9bs5
 6Nm/cPWGYg0yQRCwwnk7RdiVyomFt/LFeS2c5rAL78g1UEX0WtKYp5NBngDOP4eCQXQGV4JGsKz
 dh0=
X-Received: by 2002:a05:6000:71c:b0:474:3b3b:5e5f with SMTP id
 ffacd0b85a97d-47fb1ed9e12mr3275055f8f.16.1785251026472; 
 Tue, 28 Jul 2026 08:03:46 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a5a2sm64647709f8f.7.2026.07.28.08.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 08:03:45 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 28 Jul 2026 15:03:23 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 10
X-Gerrit-Change-Id: I55da68cc341bcfc707fd34ca2f84ff9b6a55501f
X-Gerrit-Change-Number: 1746
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1746?usp=email>
X-Gerrit-Commit: c5e88395585325f1c756413fc87b21be31a11935
In-Reply-To: <gerrit.1782719911000.I55da68cc341bcfc707fd34ca2f84ff9b6a55501f@gerrit.openvpn.net>
References: <gerrit.1782719911000.I55da68cc341bcfc707fd34ca2f84ff9b6a55501f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk1NWRhNjhjYzM0MWJjZmM3MDdmZDM0Y2EyZjg0ZmY5YjZhNTU1MDFmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <81c87a967bbbeab6df74d7f3439e1750fd625c4c-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wojLV-0000O1-Ep
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
 openvpn-devel@lists.sourceforge.net
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3166382886025775993=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3166382886025775993==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="32jKEq5ZqlM="; charset=UTF-8

--32jKEq5ZqlM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: stipa=2E

Hello plaisthos, 

I'd like=
 you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1746?usp=3Demail

to look at the new patch set (#10)=2E


Ch=
ange subject: oob: Add probe-result ranking for server selection
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Add probe-result =
ranking for server selection

Add oob_rank_probe_results(), which orders re=
motes best-first from their probe
results, following the DNS-SRV (RFC 2782)=
 semantics of the probe_reply TLV:

  - remotes that answered rank before t=
hose that did not (non-responders keep
    their original relative order, l=
ast);
  - responders are grouped by priority, lowest value first (an absolu=
te
    ordering, never overridden by latency or weight);
  - within a prior=
ity group the "candidates" are the responders whose RTT is
    within a mar=
gin of the fastest (see oob_effective_margin()); candidates
    rank ahead =
of non-candidates;
  - candidates are ordered by RFC-2782 weighted-random s=
election by weight, so
    a server is chosen first with probability propor=
tional to its weight (load
    distribution); non-candidates follow, ordere=
d by RTT=2E

The RNG is injected as a function pointer so this module stays=
 free of the
crypto layer and the weighted ordering is deterministically un=
it-testable
(production passes get_random; the tests pass stubs)=2E

RTT is=
 only populated once the client measures it (a later commit); until then
ev=
ery responder sits in the band and selection is purely weighted-random=2E

=
Change-Id: I55da68cc341bcfc707fd34ca2f84ff9b6a55501f
Signed-off-by: Lev Sti=
pakov <lev@openvpn=2Enet>
---
M src/openvpn/oob=2Ec
M src/openvpn/oob=2Eh
M=
 tests/unit_tests/openvpn/test_oob=2Ec
3 files changed, 350 insertions(+), =
0 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs=
/changes/46/1746/10

diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec=

index bc0e7a3=2E=2Ed32eac6 100644
--- a/src/openvpn/oob=2Ec
+++ b/src/open=
vpn/oob=2Ec
@@ -155,3 +155,158 @@
     reply->peer_session_id =3D *peer_sid=
;
     return true;
 }
+
+/* Base ordering: responders before non-responder=
s, then by priority (lower
+ * first), then by RTT (lower first), then by o=
riginal index for determinism=2E
+ * This groups responders into priority r=
uns pre-sorted by RTT, which the
+ * candidate-band step below relies on (r=
un[0] is the fastest in its group)=2E */
+static int
+oob_probe_result_comp=
are(const void *a, const void *b)
+{
+    const struct oob_probe_result *ra=
 =3D a;
+    const struct oob_probe_result *rb =3D b;
+
+    if (ra->respon=
ded && rb->responded)
+    {
+        /* both answered: lowest priority fir=
st, then lowest RTT */
+        if (ra->priority !=3D rb->priority)
+      =
  {
+            return ra->priority < rb->priority ? -1 : 1;
+        }
+ =
       if (ra->rtt_ms !=3D rb->rtt_ms)
+        {
+            return ra->r=
tt_ms < rb->rtt_ms ? -1 : 1;
+        }
+    }
+    else if (ra->responded)=

+    {
+        return -1; /* only a answered: it ranks first */
+    }
+ =
   else if (rb->responded)
+    {
+        return 1; /* only b answered */
=
+    }
+
+    /* neither answered, or all keys equal: keep the configured o=
rder */
+    return ra->index - rb->index;
+}
+
+int
+oob_effective_margin(=
const struct oob_probe_result *r, int client_margin)
+{
+    if (client_mar=
gin >=3D 0)
+    {
+        return client_margin; /* the client's own setti=
ng is authoritative */
+    }
+    if (r->max_latency_diff > 0)
+    {
+   =
     return (int)r->max_latency_diff; /* else the server's advertised value=
 */
+    }
+    return OOB_DEFAULT_LATENCY_MARGIN_MS;
+}
+
+/* Reorder the =
index list idx[0=2E=2Em) into DNS-SRV (RFC 2782) weighted-random
+ * order =
by results[idx[k]]=2Eweight: each position is filled by a remaining entry
+=
 * chosen with probability proportional to its weight=2E When all remaining=

+ * weights are 0 the current (RTT-sorted) order is kept=2E */
+static voi=
d
+oob_weighted_order(const struct oob_probe_result *results, int *idx, int=
 m, int64_t (*rng)(void))
+{
+    for (int pos =3D 0; pos < m; pos++)
+    =
{
+        long sum =3D 0;
+        for (int k =3D pos; k < m; k++)
+      =
  {
+            sum +=3D results[idx[k]]=2Eweight;
+        }
+        int=
 chosen =3D pos;
+        if (sum > 0)
+        {
+            int64_t r =
=3D rng() % sum; /* uniform in [0, sum) */
+            long acc =3D 0;
+  =
          for (int k =3D pos; k < m; k++)
+            {
+                a=
cc +=3D results[idx[k]]=2Eweight;
+                if (acc > r)
+          =
      {
+                    chosen =3D k;
+                    break;
+   =
             }
+            }
+        }
+        int t =3D idx[pos];
+    =
    idx[pos] =3D idx[chosen];
+        idx[chosen] =3D t;
+    }
+}
+
+/* R=
eorder one priority run (run[0=2E=2Em), already RTT-sorted) in place:
+ * c=
andidates (RTT within the band of the fastest) first, ordered by weighted
+=
 * random; then non-candidates in RTT order=2E */
+static void
+oob_order_p=
riority_run(struct oob_probe_result *run, int m, int client_margin, int64_t=
 (*rng)(void),
+                       struct gc_arena *gc)
+{
+    if (m <=
=3D 1)
+    {
+        return;
+    }
+
+    unsigned int best_rtt =3D run[=
0]=2Ertt_ms; /* run is RTT-sorted: [0] is fastest */
+
+    int *cand =3D g=
c_malloc(sizeof(int) * m, false, gc);
+    int *non =3D gc_malloc(sizeof(in=
t) * m, false, gc);
+    int nc =3D 0;
+    int nn =3D 0;
+    for (int k =
=3D 0; k < m; k++)
+    {
+        if (run[k]=2Ertt_ms - best_rtt < (unsign=
ed int)oob_effective_margin(&run[k], client_margin))
+        {
+          =
  cand[nc++] =3D k;
+        }
+        else
+        {
+            non[nn=
++] =3D k;
+        }
+    }
+
+    oob_weighted_order(run, cand, nc, rng);=

+
+    struct oob_probe_result *tmp =3D gc_malloc(sizeof(*tmp) * m, false,=
 gc);
+    int t =3D 0;
+    for (int k =3D 0; k < nc; k++)
+    {
+       =
 tmp[t++] =3D run[cand[k]];
+    }
+    for (int k =3D 0; k < nn; k++)
+   =
 {
+        tmp[t++] =3D run[non[k]];
+    }
+    memcpy(run, tmp, sizeof(*=
run) * m);
+}
+
+void
+oob_rank_probe_results(struct oob_probe_result *resu=
lts, int n, int client_margin,
+                       int64_t (*rng)(void)=
, struct gc_arena *gc)
+{
+    if (n <=3D 1)
+    {
+        return;
+    }=

+
+    /* Base order: responders first, grouped by priority, RTT-sorted wi=
thin=2E */
+    qsort(results, (size_t)n, sizeof(*results), oob_probe_resul=
t_compare);
+
+    /* Reorder each priority run of responders by candidate-=
band + weight=2E */
+    int i =3D 0;
+    while (i < n && results[i]=2Eres=
ponded)
+    {
+        int j =3D i;
+        while (j < n && results[j]=2E=
responded && results[j]=2Epriority =3D=3D results[i]=2Epriority)
+        {=

+            j++;
+        }
+        oob_order_priority_run(results + i, =
j - i, client_margin, rng, gc);
+        i =3D j;
+    }
+}
diff --git a/sr=
c/openvpn/oob=2Eh b/src/openvpn/oob=2Eh
index 80775a4=2E=2Ea8652ea 100644
-=
-- a/src/openvpn/oob=2Eh
+++ b/src/openvpn/oob=2Eh
@@ -180,4 +180,55 @@
 bo=
ol oob_build_probe_reply(struct buffer *probe_payload, uint64_t now, uint64=
_t window_secs,
                            const struct session_id *peer_s=
id, struct oob_probe_reply *reply);
 
+/* Candidate-band margin (ms) used w=
hen neither the client nor the server
+ * specifies one=2E */
+#define OOB_=
DEFAULT_LATENCY_MARGIN_MS 10
+
+/* Outcome of probing one remote, used to o=
rder remotes best-first=2E @index is
+ * the caller's identifier for the re=
mote (e=2Eg=2E its position in the connection
+ * list); priority/weight ar=
e only meaningful when @responded is true=2E */
+struct oob_probe_result
+{=

+    int index;
+    bool responded;
+    uint16_t priority;
+    uint16_t=
 weight;
+    uint16_t max_latency_diff; /* margin advertised by this serve=
r (ms); 0 =3D use client default */
+    unsigned int rtt_ms;       /* prob=
e round-trip time in ms (responders only) */
+};
+
+/**
+ * Order results b=
est-first, in place, per the server-probe selection policy:
+ *   - remotes=
 that responded rank before those that did not (non-responders keep
+ *    =
 their original relative order, last);
+ *   - responders are grouped by pr=
iority, lowest priority value first (an
+ *     absolute ordering, never ov=
erridden by latency or weight);
+ *   - within a priority group, the "candi=
dates" are the responders whose RTT is
+ *     within a margin of the faste=
st in the group (see oob_effective_margin())=2E
+ *     Candidates are orde=
red ahead of non-candidates;
+ *   - candidates are ordered by DNS-SRV (RFC=
 2782) weighted-random selection by
+ *     weight, so a server is chosen f=
irst with probability proportional to its
+ *     weight (load distribution=
)=2E Non-candidates follow, ordered by RTT=2E
+ *
+ * @param results       =
 results to reorder in place
+ * @param n              number of results
+ =
* @param client_margin  client's candidate-band margin in ms, or < 0 if the=

+ *                        client did not set one (see oob_effective_margi=
n())
+ * @param rng            returns a non-negative random value (e=2Eg=
=2E get_random);
+ *                       injected so this module stays fr=
ee of the crypto layer
+ *                       and the weighted ordering =
is deterministically testable
+ * @param gc             arena for scratch a=
llocation
+ */
+void oob_rank_probe_results(struct oob_probe_result *result=
s, int n, int client_margin,
+                            int64_t (*rng)(vo=
id), struct gc_arena *gc);
+
+/**
+ * The candidate-band margin (ms) that a=
pplies to one probed remote=2E The client's
+ * own setting is authoritativ=
e: when client_margin >=3D 0 (the client set
+ * --server-probe with a valu=
e) it is used for every remote=2E Otherwise the
+ * server's advertised max=
_latency_diff is used when non-zero, falling back to
+ * OOB_DEFAULT_LATENC=
Y_MARGIN_MS=2E
+ */
+int oob_effective_margin(const struct oob_probe_result=
 *r, int client_margin);
+
 #endif /* OOB_H */
diff --git a/tests/unit_test=
s/openvpn/test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec
index 48bec2=
d=2E=2E004ad8f 100644
--- a/tests/unit_tests/openvpn/test_oob=2Ec
+++ b/tes=
ts/unit_tests/openvpn/test_oob=2Ec
@@ -517,6 +517,144 @@
     gc_free(&gc);=

 }
 
+/* Deterministic RNG stubs for the weighted-selection ordering=2E ra=
nk_rng_zero
+ * makes the weighted draw always pick the first remaining can=
didate, preserving
+ * order; rank_rng_fixed returns a value we set to land=
 in a chosen weight slice=2E */
+static int64_t
+rank_rng_zero(void)
+{
+  =
  return 0;
+}
+
+static int64_t rank_rng_value;
+static int64_t
+rank_rng_=
fixed(void)
+{
+    return rank_rng_value;
+}
+
+/* Responders rank ahead o=
f non-responders regardless of index order=2E */
+static void
+test_rank_re=
sponder_before_nonresponder(void **state)
+{
+    struct gc_arena gc =3D gc=
_new();
+    struct oob_probe_result r[] =3D {
+        { =2Eindex =3D 0, =
=2Eresponded =3D false },
+        { =2Eindex =3D 1, =2Eresponded =3D true,=
 =2Epriority =3D 100, =2Eweight =3D 50 },
+    };
+    oob_rank_probe_resul=
ts(r, 2, 10, rank_rng_zero, &gc);
+    assert_int_equal(r[0]=2Eindex, 1);
+=
    assert_int_equal(r[1]=2Eindex, 0);
+    gc_free(&gc);
+}
+
+/* Among re=
sponders, the lowest priority value wins (an absolute ordering)=2E */
+stat=
ic void
+test_rank_by_priority(void **state)
+{
+    struct gc_arena gc =3D=
 gc_new();
+    struct oob_probe_result r[] =3D {
+        { =2Eindex =3D 0=
, =2Eresponded =3D true, =2Epriority =3D 20, =2Eweight =3D 50 },
+        {=
 =2Eindex =3D 1, =2Eresponded =3D true, =2Epriority =3D 5, =2Eweight =3D 50=
 },
+        { =2Eindex =3D 2, =2Eresponded =3D true, =2Epriority =3D 10, =
=2Eweight =3D 50 },
+    };
+    oob_rank_probe_results(r, 3, 10, rank_rng_=
zero, &gc);
+    assert_int_equal(r[0]=2Eindex, 1); /* priority 5 */
+    a=
ssert_int_equal(r[1]=2Eindex, 2); /* priority 10 */
+    assert_int_equal(r=
[2]=2Eindex, 0); /* priority 20 */
+    gc_free(&gc);
+}
+
+/* Within a pri=
ority, only servers within the latency margin of the fastest are
+ * candid=
ates; a slower (out-of-band) server ranks behind a faster one no matter
+ *=
 how large its weight=2E */
+static void
+test_rank_candidate_band(void **s=
tate)
+{
+    struct gc_arena gc =3D gc_new();
+    struct oob_probe_result=
 r[] =3D {
+        { =2Eindex =3D 0, =2Eresponded =3D true, =2Epriority =
=3D 10, =2Eweight =3D 1000, =2Ertt_ms =3D 100 },
+        { =2Eindex =3D 1,=
 =2Eresponded =3D true, =2Epriority =3D 10, =2Eweight =3D 1, =2Ertt_ms =3D =
20 },
+    };
+    /* margin 10ms: 20ms is fastest; 100ms is 80ms slower ->=
 out of band */
+    oob_rank_probe_results(r, 2, 10, rank_rng_zero, &gc);
=
+    assert_int_equal(r[0]=2Eindex, 1); /* fast, in-band, despite tiny weig=
ht */
+    assert_int_equal(r[1]=2Eindex, 0); /* slow, out-of-band, despite=
 huge weight */
+    gc_free(&gc);
+}
+
+/* A server widens its own band vi=
a the advertised max_latency_diff, joining the
+ * candidate set even when =
it is well behind the fastest; it then participates in
+ * the weighted sel=
ection=2E */
+static void
+test_rank_advertised_margin(void **state)
+{
+  =
  struct gc_arena gc =3D gc_new();
+    struct oob_probe_result r[] =3D {
+=
        { =2Eindex =3D 0, =2Eresponded =3D true, =2Epriority =3D 10, =2Ewei=
ght =3D 1, =2Ertt_ms =3D 20 },
+        { =2Eindex =3D 1,
+          =2Eres=
ponded =3D true,
+          =2Epriority =3D 10,
+          =2Eweight =3D 10=
00,
+          =2Ertt_ms =3D 100,
+          =2Emax_latency_diff =3D 200 },=

+    };
+    /* Client did not set a margin (-1), so each server's adverti=
sed value
+     * applies: the 100ms server advertises 200 -> it is a candi=
date (the
+     * default 10 would have excluded it); with weight 1000 (sli=
ce [1,1001)) a
+     * draw of 500 selects it first=2E */
+    rank_rng_val=
ue =3D 500;
+    oob_rank_probe_results(r, 2, -1, rank_rng_fixed, &gc);
+  =
  assert_int_equal(r[0]=2Eindex, 1);
+    gc_free(&gc);
+}
+
+/* Among cand=
idates, weight drives RFC-2782 proportional selection: a draw is
+ * mapped=
 to the server whose cumulative weight slice it falls in=2E */
+static void=

+test_rank_weighted_selection(void **state)
+{
+    struct gc_arena gc =3D=
 gc_new();
+    /* equal priority and RTT -> both in band; weights 30 and 7=
0, sum 100:
+     * index 0 owns [0,30), index 1 owns [30,100)=2E */
+    c=
onst struct oob_probe_result base[] =3D {
+        { =2Eindex =3D 0, =2Eres=
ponded =3D true, =2Epriority =3D 10, =2Eweight =3D 30, =2Ertt_ms =3D 20 },
=
+        { =2Eindex =3D 1, =2Eresponded =3D true, =2Epriority =3D 10, =2Ewe=
ight =3D 70, =2Ertt_ms =3D 20 },
+    };
+    struct oob_probe_result r[2];=

+
+    memcpy(r, base, sizeof(base));
+    rank_rng_value =3D 10; /* falls=
 in index 0's slice */
+    oob_rank_probe_results(r, 2, 50, rank_rng_fixed=
, &gc);
+    assert_int_equal(r[0]=2Eindex, 0);
+
+    memcpy(r, base, size=
of(base));
+    rank_rng_value =3D 50; /* falls in index 1's slice */
+    =
oob_rank_probe_results(r, 2, 50, rank_rng_fixed, &gc);
+    assert_int_equa=
l(r[0]=2Eindex, 1);
+
+    gc_free(&gc);
+}
+
+/* Non-responders are placed=
 last, keeping their original relative order=2E */
+static void
+test_rank_=
nonresponders_last(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+=
    struct oob_probe_result r[] =3D {
+        { =2Eindex =3D 0, =2Erespond=
ed =3D false },
+        { =2Eindex =3D 1, =2Eresponded =3D true, =2Epriori=
ty =3D 10, =2Eweight =3D 50, =2Ertt_ms =3D 20 },
+        { =2Eindex =3D 2,=
 =2Eresponded =3D false },
+        { =2Eindex =3D 3, =2Eresponded =3D true=
, =2Epriority =3D 10, =2Eweight =3D 50, =2Ertt_ms =3D 20 },
+    };
+    oo=
b_rank_probe_results(r, 4, 10, rank_rng_zero, &gc);
+    assert_int_equal(r=
[0]=2Eindex, 1); /* responder (rng_zero keeps order) */
+    assert_int_equ=
al(r[1]=2Eindex, 3); /* responder */
+    assert_int_equal(r[2]=2Eindex, 0)=
; /* non-responder, original order kept */
+    assert_int_equal(r[3]=2Eind=
ex, 2);
+    gc_free(&gc);
+}
+
 int
 main(void)
 {
@@ -542,6 +680,12 @@
  =
       cmocka_unit_test(test_client_reply_read_skips_unknown),
         cmo=
cka_unit_test(test_client_reply_read_missing),
         cmocka_unit_test(te=
st_client_reply_read_wrong_msg_type),
+        cmocka_unit_test(test_rank_r=
esponder_before_nonresponder),
+        cmocka_unit_test(test_rank_by_prior=
ity),
+        cmocka_unit_test(test_rank_candidate_band),
+        cmocka_=
unit_test(test_rank_advertised_margin),
+        cmocka_unit_test(test_rank=
_weighted_selection),
+        cmocka_unit_test(test_rank_nonresponders_las=
t),
     };
 
     return cmocka_run_group_tests_name("oob tests", tests, N=
ULL, NULL);

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
746?usp=3Demail
To unsubscribe, or for help writing mail filters, visit htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpat=
chset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I55da=
68cc341bcfc707fd34ca2f84ff9b6a55501f
Gerrit-Change-Number: 1746
Gerrit-Patc=
hSet: 10
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plais=
thos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@l=
ists=2Esourceforge=2Enet>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>

--32jKEq5ZqlM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: stipa=2E </p>
<p>stipa <strong>uploaded patch set #10=
</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1746?usp=3Demail">View Change</a></p><pre class=3D"blocks" styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;">oob: Add pro=
be-result ranking for server selection<br><br>Add oob_rank_probe_results(),=
 which orders remotes best-first from their probe<br>results, following the=
 DNS-SRV (RFC 2782) semantics of the probe_reply TLV:<br><br>  - remotes th=
at answered rank before those that did not (non-responders keep<br>    thei=
r original relative order, last);<br>  - responders are grouped by priority=
, lowest value first (an absolute<br>    ordering, never overridden by late=
ncy or weight);<br>  - within a priority group the &quot;candidates&quot; a=
re the responders whose RTT is<br>    within a margin of the fastest (see o=
ob_effective_margin()); candidates<br>    rank ahead of non-candidates;<br>=
  - candidates are ordered by RFC-2782 weighted-random selection by weight,=
 so<br>    a server is chosen first with probability proportional to its we=
ight (load<br>    distribution); non-candidates follow, ordered by RTT=2E<b=
r><br>The RNG is injected as a function pointer so this module stays free o=
f the<br>crypto layer and the weighted ordering is deterministically unit-t=
estable<br>(production passes get_random; the tests pass stubs)=2E<br><br>R=
TT is only populated once the client measures it (a later commit); until th=
en<br>every responder sits in the band and selection is purely weighted-ran=
dom=2E<br><br>Change-Id: I55da68cc341bcfc707fd34ca2f84ff9b6a55501f<br>Signe=
d-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M src/openvpn/oo=
b=2Ec<br>M src/openvpn/oob=2Eh<br>M tests/unit_tests/openvpn/test_oob=2Ec<b=
r>3 files changed, 350 insertions(+), 0 deletions(-)<br><br></pre><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/46/17=
46/10</pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec</span>=
<br><span>index bc0e7a3=2E=2Ed32eac6 100644</span><br><span>--- a/src/openv=
pn/oob=2Ec</span><br><span>+++ b/src/openvpn/oob=2Ec</span><br><span>@@ -15=
5,3 +155,158 @@</span><br><span>     reply-&gt;peer_session_id =3D *peer_si=
d;</span><br><span>     return true;</span><br><span> }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/* Base ordering: responders before non-responders, then b=
y priority (lower</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 first), then by RTT (lower first), then by original index for determinism=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This groups r=
esponders into priority runs pre-sorted by RTT, which the</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * candidate-band step below relies o=
n (run[0] is the fastest in its group)=2E */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+oob_probe_result_compare(const void *a, const void *b)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const struct oob_probe_result *ra =3D=
 a;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct=
 oob_probe_result *rb =3D b;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ra=
-&gt;responded &amp;&amp; rb-&gt;responded)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        /* both answered: lowest priority first, then lowest RTT =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (ra-&g=
t;priority !=3D rb-&gt;priority)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            return ra-&gt;priority &lt; rb-&gt;priority ? -1 : 1;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if (ra-&gt;rtt_ms !=3D rb-&g=
t;rtt_ms)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return r=
a-&gt;rtt_ms &lt; rb-&gt;rtt_ms ? -1 : 1;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  else if (ra-&gt;responded)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   return -1; /* only a answered: it ranks first */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    else if (rb-&gt;responded)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        return 1; /* only b answered */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* neither answered, or all keys equal: keep the configured order *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ra-&gt;=
index - rb-&gt;index;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+oob_effective_margin(const struct oob_probe_result =
*r, int client_margin)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (client_=
margin &gt;=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return c=
lient_margin; /* the client&#39;s own setting is authoritative */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (r-&gt;max_latency_diff &gt; 0)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return (int)r-&gt;max_latenc=
y_diff; /* else the server&#39;s advertised value */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return OOB_DEFAULT_LATENCY_MARGIN_MS;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/* Reorder the index list idx[0=2E=2Em) into DNS-SRV (RFC 2782) weight=
ed-random</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * order b=
y results[idx[k]]=2Eweight: each position is filled by a remaining entry</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * chosen with probabi=
lity proportional to its weight=2E When all remaining</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * weights are 0 the current (RTT-sorted)=
 order is kept=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_wei=
ghted_order(const struct oob_probe_result *results, int *idx, int m, int64_=
t (*rng)(void))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int pos =3D 0=
; pos &lt; m; pos++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        long =
sum =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        f=
or (int k =3D pos; k &lt; m; k++)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            sum +=3D results[idx[k]]=2Eweight;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        int chosen =3D pos;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if (sum &gt; 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            int64_t r =3D rng() % sum; /* uniform i=
n [0, sum) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      long acc =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            for (int k =3D pos; k &lt; m; k++)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                acc +=3D results[idx[k]]=2Eweight;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                if (a=
cc &gt; r)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
         chosen =3D k;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                    break;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
int t =3D idx[pos];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        idx[pos] =3D idx[chosen];</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        idx[chosen] =3D t;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/* Reorder one priority run (r=
un[0=2E=2Em), already RTT-sorted) in place:</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * candidates (RTT within the band of the fastest) =
first, ordered by weighted</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * random; then non-candidates in RTT order=2E */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+oob_order_priority_run(struct oob_probe_result=
 *run, int m, int client_margin, int64_t (*rng)(void),</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                       struct gc_arena *=
gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (m &lt;=3D 1)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsig=
ned int best_rtt =3D run[0]=2Ertt_ms; /* run is RTT-sorted: [0] is fastest =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    int *cand =3D gc_malloc(sizeof(i=
nt) * m, false, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    int *non =3D gc_malloc(sizeof(int) * m, false, gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    int nc =3D 0;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    int nn =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    for (int k =3D 0; k &lt; m; k++)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        if (run[k]=2Ertt_ms - best_rtt=
 &lt; (unsigned int)oob_effective_margin(&amp;run[k], client_margin))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            cand[nc++] =3D k;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            non[nn++] =3D k;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    oob_w=
eighted_order(run, cand, nc, rng);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct oob_probe_result *tmp =3D gc_malloc(sizeof(*tmp) * m, false, gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    int t =3D 0;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int k =3D 0; k &=
lt; nc; k++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tmp[t++] =3D =
run[cand[k]];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int k =3D 0=
; k &lt; nn; k++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tmp[t++]=
 =3D run[non[k]];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(run, =
tmp, sizeof(*run) * m);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+oob_rank_probe_results(struct oob_probe_result *=
results, int n, int client_margin,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                       int64_t (*rng)(void), struct gc_arena=
 *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (n &lt;=3D 1)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =
Base order: responders first, grouped by priority, RTT-sorted within=2E */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    qsort(results, (=
size_t)n, sizeof(*results), oob_probe_result_compare);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* Reorder each priority run of responders by candidate=
-band + weight=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    int i =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  while (i &lt; n &amp;&amp; results[i]=2Eresponded)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        int j =3D i;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        while (j &lt; n &amp;&amp; results[j]=2Erespon=
ded &amp;&amp; results[j]=2Epriority =3D=3D results[i]=2Epriority)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            j++;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        oob_order_priority_run(results + i, j - i, =
client_margin, rng, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        i =3D j;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span>diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh</span><br><spa=
n>index 80775a4=2E=2Ea8652ea 100644</span><br><span>--- a/src/openvpn/oob=
=2Eh</span><br><span>+++ b/src/openvpn/oob=2Eh</span><br><span>@@ -180,4 +1=
80,55 @@</span><br><span> bool oob_build_probe_reply(struct buffer *probe_p=
ayload, uint64_t now, uint64_t window_secs,</span><br><span>               =
             const struct session_id *peer_sid, struct oob_probe_reply *rep=
ly);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/* Candidate-band margin (ms) used when neither the client nor the serve=
r</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * specifies one=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OOB_D=
EFAULT_LATENCY_MARGIN_MS 10</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Outcome =
of probing one remote, used to order remotes best-first=2E @index is</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * the caller&#39;s identi=
fier for the remote (e=2Eg=2E its position in the connection</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * list); priority/weight are only=
 meaningful when @responded is true=2E */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+struct oob_probe_result</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    int index;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    bool responded;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    uint16_t priority;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    uint16_t weight;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    uint16_t max_latency_diff; /* margin advertised by this server (=
ms); 0 =3D use client default */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    unsigned int rtt_ms;       /* probe round-trip time in ms =
(responders only) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * Order results best-first, in place, per the serv=
er-probe selection policy:</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *   - remotes that responded rank before those that did not (non-re=
sponders keep</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *    =
 their original relative order, last);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *   - responders are grouped by priority, lowest priori=
ty value first (an</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*     absolute ordering, never overridden by latency or weight);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *   - within a priority group=
, the &quot;candidates&quot; are the responders whose RTT is</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *     within a margin of the fast=
est in the group (see oob_effective_margin())=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *     Candidates are ordered ahead of non-can=
didates;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   - cand=
idates are ordered by DNS-SRV (RFC 2782) weighted-random selection by</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *     weight, so a serve=
r is chosen first with probability proportional to its</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *     weight (load distribution)=2E Non=
-candidates follow, ordered by RTT=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * @param results        results to reorder in place</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param n              number of result=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param client_m=
argin  client&#39;s candidate-band margin in ms, or &lt; 0 if the</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *                        cli=
ent did not set one (see oob_effective_margin())</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @param rng            returns a non-negativ=
e random value (e=2Eg=2E get_random);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *                       injected so this module stays fr=
ee of the crypto layer</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *                       and the weighted ordering is deterministically =
testable</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param g=
c             arena for scratch allocation</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+void oob_rank_probe_results(struct oob_probe_result *results, int n,=
 int client_margin,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                            int64_t (*rng)(void), struct gc_arena *gc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * The candidate-band margin (ms) that applies to one pro=
bed remote=2E The client&#39;s</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * own setting is authoritative: when client_margin &gt;=3D 0 (t=
he client set</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * --s=
erver-probe with a value) it is used for every remote=2E Otherwise the</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * server&#39;s advertis=
ed max_latency_diff is used when non-zero, falling back to</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * OOB_DEFAULT_LATENCY_MARGIN_MS=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+int oob_effective_margin(const struc=
t oob_probe_result *r, int client_margin);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span> #endif /* OOB_H */</span><br><span=
>diff --git a/tests/unit_tests/openvpn/test_oob=2Ec b/tests/unit_tests/open=
vpn/test_oob=2Ec</span><br><span>index 48bec2d=2E=2E004ad8f 100644</span><b=
r><span>--- a/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>+++ b/t=
ests/unit_tests/openvpn/test_oob=2Ec</span><br><span>@@ -517,6 +517,144 @@<=
/span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Deterministic RN=
G stubs for the weighted-selection ordering=2E rank_rng_zero</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * makes the weighted draw always =
pick the first remaining candidate, preserving</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * order; rank_rng_fixed returns a value we set =
to land in a chosen weight slice=2E */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+static int64_t</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+rank_rng_zero(void)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static int64_t rank_rng_value;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static int64_t</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+rank_rng_fixed(void)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return rank_rng_value;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Responders=
 rank ahead of non-responders regardless of index order=2E */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+test_rank_responder_before_nonresponder(v=
oid **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =
=3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct oob_probe_result r[] =3D {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        { =2Eindex =3D 0, =2Eresponded =3D false },</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        { =2Eindex =3D 1, =2Ere=
sponded =3D true, =2Epriority =3D 100, =2Eweight =3D 50 },</span><br><span =
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
40%);">+        { =2Eindex =3D 0, =2Eresponded =3D true, =2Epriority =3D 20=
, =2Eweight =3D 50 },</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        { =2Eindex =3D 1, =2Eresponded =3D true, =2Epriority =3D 5, =2Ewe=
ight =3D 50 },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   { =2Eindex =3D 2, =2Eresponded =3D true, =2Epriority =3D 10, =2Eweight =
=3D 50 },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    oob_rank_probe_resu=
lts(r, 3, 10, rank_rng_zero, &amp;gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_int_equal(r[0]=2Eindex, 1); /* priority 5 */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal=
(r[1]=2Eindex, 2); /* priority 10 */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_int_equal(r[2]=2Eindex, 0); /* priority 20 */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/* Within a priority, only servers within the latency ma=
rgin of the fastest are</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * candidates; a slower (out-of-band) server ranks behind a faster one =
no matter</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * how lar=
ge its weight=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_ran=
k_candidate_band(void **state)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct oob_probe_result r[] =3D {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        { =2Eindex =3D 0, =2Eresponded =3D true=
, =2Epriority =3D 10, =2Eweight =3D 1000, =2Ertt_ms =3D 100 },</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        { =2Eindex =3D 1, =2Eres=
ponded =3D true, =2Epriority =3D 10, =2Eweight =3D 1, =2Ertt_ms =3D 20 },</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* margin 10ms: 20ms is fastes=
t; 100ms is 80ms slower -&gt; out of band */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    oob_rank_probe_results(r, 2, 10, rank_rng_zero=
, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_int_equal(r[0]=2Eindex, 1); /* fast, in-band, despite tiny weight */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(r[=
1]=2Eindex, 0); /* slow, out-of-band, despite huge weight */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+/* A server widens its own band via the advertised max_latency_diff, =
joining the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * candi=
date set even when it is well behind the fastest; it then participates in</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the weighted selec=
tion=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static vo=
id</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_rank_adverti=
sed_margin(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc=
_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct oob_probe_result r[] =3D {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        { =2Eindex =3D 0, =2Eresponded =3D true, =2Ep=
riority =3D 10, =2Eweight =3D 1, =2Ertt_ms =3D 20 },</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        { =2Eindex =3D 1,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+          =2Eresponded =3D true,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+          =2Epriority =
=3D 10,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
=2Eweight =3D 1000,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
          =2Ertt_ms =3D 100,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+          =2Emax_latency_diff =3D 200 },</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* Client did not set a margin (-1), so each server&#3=
9;s advertised value</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     * applies: the 100ms server advertises 200 -&gt; it is a candidate (t=
he</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * default 10=
 would have excluded it); with weight 1000 (slice [1,1001)) a</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     * draw of 500 selects it fir=
st=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rank_rn=
g_value =3D 500;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 oob_rank_probe_results(r, 2, -1, rank_rng_fixed, &amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(r[0]=2Eindex, =
1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp=
;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/* Among candidates, weight drives RFC-2782 proport=
ional selection: a draw is</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * mapped to the server whose cumulative weight slice it falls in=2E=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+test_rank_weighted_selec=
tion(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena=
 gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /* equal priority and RTT -&gt; both in band; weights 30 and 70, sum 100:=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * index 0 owns=
 [0,30), index 1 owns [30,100)=2E */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    const struct oob_probe_result base[] =3D {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        { =2Eindex =3D 0, =2Ere=
sponded =3D true, =2Epriority =3D 10, =2Eweight =3D 30, =2Ertt_ms =3D 20 },=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        { =2Eindex =
=3D 1, =2Eresponded =3D true, =2Epriority =3D 10, =2Eweight =3D 70, =2Ertt_=
ms =3D 20 },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe=
_result r[2];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(r, base, sizeo=
f(base));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rank_r=
ng_value =3D 10; /* falls in index 0&#39;s slice */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    oob_rank_probe_results(r, 2, 50, rank=
_rng_fixed, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_int_equal(r[0]=2Eindex, 0);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    memcpy(r, base, sizeof(base));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    rank_rng_value =3D 50; /* falls in index 1&#39;s slice=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    oob_rank_pro=
be_results(r, 2, 50, rank_rng_fixed, &amp;gc);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_int_equal(r[0]=2Eindex, 1);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Non-r=
esponders are placed last, keeping their original relative order=2E */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+test_rank_nonresponders_last(voi=
d **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D =
gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 oob_probe_result r[] =3D {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        { =2Eindex =3D 0, =2Eresponded =3D false },</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        { =2Eindex =3D 1, =2Erespon=
ded =3D true, =2Epriority =3D 10, =2Eweight =3D 50, =2Ertt_ms =3D 20 },</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        { =2Eindex =3D =
2, =2Eresponded =3D false },</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        { =2Eindex =3D 3, =2Eresponded =3D true, =2Epriority =3D 1=
0, =2Eweight =3D 50, =2Ertt_ms =3D 20 },</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    oob_rank_probe_results(r, 4, 10, rank_rng_zero, &amp;gc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(r[0]=
=2Eindex, 1); /* responder (rng_zero keeps order) */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(r[1]=2Eindex, 3); /*=
 responder */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_int_equal(r[2]=2Eindex, 0); /* non-responder, original order kept */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(=
r[3]=2Eindex, 2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
int</span><br><span> main(void)</span><br><span> {</span><br><span>@@ -542,=
6 +680,12 @@</span><br><span>         cmocka_unit_test(test_client_reply_re=
ad_skips_unknown),</span><br><span>         cmocka_unit_test(test_client_re=
ply_read_missing),</span><br><span>         cmocka_unit_test(test_client_re=
ply_read_wrong_msg_type),</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        cmocka_unit_test(test_rank_responder_before_nonresponder),</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_te=
st(test_rank_by_priority),</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        cmocka_unit_test(test_rank_candidate_band),</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_rank_a=
dvertised_margin),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       cmocka_unit_test(test_rank_weighted_selection),</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_rank_nonre=
sponders_last),</span><br><span>     };</span><br><span> </span><br><span> =
    return cmocka_run_group_tests_name(&quot;oob tests&quot;, tests, NULL, =
NULL);</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1746?usp=3Demail">change 1746</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1746?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none=
"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branc=
h: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I55da68cc34=
1bcfc707fd34ca2f84ff9b6a55501f </div>
<div style=3D"display:none"> Gerrit-C=
hange-Number: 1746 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 =
</div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2E=
com&gt; </div>

</body></html>
--32jKEq5ZqlM=--


--===============3166382886025775993==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3166382886025775993==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3166382886025775993==--

