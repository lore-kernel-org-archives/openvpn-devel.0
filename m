Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E79EC982CF
	for <openvpn-devel@archiver.kernel.org>; Thu, 17 Sep 2026 12:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z1V525GPhZK7B7WHwEp55yfF9k+pzQlNwinERkaC6AE=; b=f8W1t8ohlZ1wKEhc+fjE2wuEeq
	YIp3fGG+f2IgKcCjwyeA3bcVj6TqUn2GfOKenCE/QOwWFKuJNsE0zbShuM74NbvqmuG0yOjLbTUWK
	Ad1DIt3P3rEILYMJP2RaIMaYoN62Dxg1XMzWkxLtpqoq77W79YQ9KKdR8UL5DrvDfZKE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x7BE6-0005Z5-Kb;
	Thu, 17 Sep 2026 12:28:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x7BE5-0005Yz-33
 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 12:28:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=HRJ7VgdHGgxYOhRNXHGZdZHhRnOV1Twn1jpZZ3Ns6RI=; b=jw3ydJGDvpSXB05sluVPUxw5Nb
 7OpOyHAzIwNWHq7K7aTnSoEXBYtEfjwoYFX3YqT2L1PF2Xv9HWpXhu38emcWqQJYmF7lL4Wa/L2NY
 u99dDypotWZ82Pg8OKw1/JqVglDYrjwCfG+q/VD4p+6QqTlbqLz654gZBQzPZTVU9nyI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=HRJ7VgdHGgxYOhRNXHGZdZHhRnOV1Twn1jpZZ3Ns6RI=; b=a
 QYUOPInEXya3NZKupvHZQQS1nHE70Osn9eJJZtq+wlufLyFIkDmDPhFPlbc1koyg+d2/66Fj/P8lM
 nTW0Sbld9hATnQU9sTwK+remFTlnSU7S67c2FgKLeFEiqaDdwrBrk8uui4JNzzguTrHxRMEwYKsAe
 7pcgnlRzff7IZMPw=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x7BE1-0005wn-7H for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 12:28:29 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f633cd78so427883f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 17 Sep 2026 05:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789648099; x=1790252899; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HRJ7VgdHGgxYOhRNXHGZdZHhRnOV1Twn1jpZZ3Ns6RI=;
 b=H3Y0NI/vo2jhSipG/V/zAcOuh4YXbPKMvcSiBMrJMiDOsvNHFre5MSIPMg3knR9mHE
 PL1mMMqp3v7MtKPoJqn43yMZJ7ZnVDvYcXHOZOQvL1U9cJHv7N4+gpPthsgQTfHp4tlE
 bNTCGLcZ1+HGbD9VWko78UqCHVizb8+5JbBgVZTIivayB6bzrp3Ii/gqYy1iBQyMiS3u
 m8Lzld1TBbVFCdervt6TsPyoin7hyqqF1ffBMDOrEsoR/RqGfB/IcTrgb0m6KmD3wODe
 //i8rjCPSvIMKy45jDd6O70LM4EUym8HHB4/VVRuxd5of1PXgOZEPE2EuA0YRGiriObN
 TYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789648099; x=1790252899;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HRJ7VgdHGgxYOhRNXHGZdZHhRnOV1Twn1jpZZ3Ns6RI=;
 b=mM+5FghF+3y9VmR+UQHz0UNeJ4muaDH5t6Lv9hzmg/E9hr28qFjOYMDq/YFQ39ZFXF
 F/xNzJc3c6p5AFAWQyQD2xaaRg2Vcd/2/8DGQYAOXXVQLmcUBxvwhYFrWrINRkgg8QSm
 xer0fELfxyARF2IXxoLbJQ+3WuS0ChL+6/ksld8lmFhxxFtUCka6ot3PlhsGe4FsyP4l
 JvjX4gXaFs36bKSZLQ20Sflabpicdc/bvJPAQHPa9SKoBUiXJYnuqQnhtbWbU7qlCBEC
 n8AlNt4tqLTkFDiu/cFl0sCD8A8ls0ZlbzcUq/fvYc8blbTFL1mDgjNBvf0S9A6bQ8+N
 9JWw==
X-Gm-Message-State: AFuF++lOsMTuxDHGXtRSzky1OVKQJCalgH5AjQdAV1pxpYF5v4zUPKJA
 L729RmiOJMJOvY7ZE4hAYepR4UeIlO2IWMsSMXDJjTblcgoLGT2baS/TW1ZPoL2PQVc5+NRHO48
 07XnNKM7vAIREXTfPSFE3Fj0mZQGnh2zt3Ck2TfpPiO92lFbeDU0MnEAH2eSIu3btrefD
X-Gm-Gg: AYBFou3f2PIRdEGrZxrhLxFLVY2L8A3jHW6z0i9zh60bioLJEOAK5T1Tqa8Lx/8bkHr
 CUKS44qY44Hg/BpjxkKsicBl2io1F42MWQgKLDnti76NZwyzKgIuGY1eYOThanOnckR3nV8WclV
 9h0lyZjDvMJZp942HFR+obc4OvHmZ1LK1CXKALFMe34IQOD1n2E4IuL0MjabENNaEx3n6xw5/DZ
 W1wGbP5uMfNbT/5+xgXXrJo9FAA21/RNuhGAAcwOQgC4OR7jXAs1zDCCD856pmcujbojbCpm0rA
 qF7dQ+1Aa42vjwurSEh+TGwOWLtZEFz/3FJSfKKKrauvV6Lj0ZgjgYLFWohtyrZ8SQ+D5kEW1QR
 /x9jYsaKqpQx0hOH45bGIm1sYVv8yfQWjia59AQCRFqdNN3KtG3Qet8AbiJWlMhdJwBSJ76ryiq
 zxziJo5eKoixf5K0dbuLjYLms9SBrKya6gVDntf+TlXa9h4ps7sM/Xad9dq+xQpmYcpiZIowROC
 o1FNWu6LrEwNjBTg7mppdouBhaY1gRvyXTD9rv8yYAZ/QNbVhqUUPSqjUQMUgT2ZYQjUG3vfRZU
 vxJwp6aB/QB1kazTQRo0aH+oW0ic6NS3T5TMomh9PSH512XKRLlf3/JMwiFhbD8gj/WVxg5r
X-Received: by 2002:a05:6000:27c1:b0:487:f93:d1cc with SMTP id
 ffacd0b85a97d-4870fa31773mr5168903f8f.10.1789648098214; 
 Thu, 17 Sep 2026 05:28:18 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf27198sm15225428f8f.15.2026.09.17.05.28.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 05:28:17 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 17 Sep 2026 12:28:12 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 20
X-Gerrit-Change-Id: I55da68cc341bcfc707fd34ca2f84ff9b6a55501f
X-Gerrit-Change-Number: 1746
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1746?usp=email>
X-Gerrit-Commit: f033251ac0d6b54e2017d85047d26df9db423eea
In-Reply-To: <gerrit.1782719911000.I55da68cc341bcfc707fd34ca2f84ff9b6a55501f@gerrit.openvpn.net>
References: <gerrit.1782719911000.I55da68cc341bcfc707fd34ca2f84ff9b6a55501f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk1NWRhNjhjYzM0MWJjZmM3MDdmZDM0Y2EyZjg0ZmY5YjZhNTU1MDFmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4868e3f80794483cf251947c63cb99bc6550fde5-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x7BE1-0005wn-7H
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
Content-Type: multipart/mixed; boundary="===============1489199371516686358=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1489199371516686358==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wArc4QEFaUk="; charset=UTF-8

--wArc4QEFaUk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici, stipa=2E

Hello=
 plaisthos, ralf_lici, 

I'd like you to reexamine a change=2E Please visit=


    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1746?usp=3Demail

to look a=
t the new patch set (#20)=2E


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
3 files changed, 491 insertion=
s(+), 0 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/46/1746/20

diff --git a/src/openvpn/oob=2Ec b/src/openvpn/o=
ob=2Ec
index 369e500=2E=2E8227e1b 100644
--- a/src/openvpn/oob=2Ec
+++ b/sr=
c/openvpn/oob=2Ec
@@ -146,3 +146,169 @@
     return oob_timestamp_in_window=
(param=2Etimestamp, now, window_secs) ? OOB_PROBE_OK
                      =
                                                   : OOB_PROBE_STALE;
 }
+
=
+/* Base ordering: responders before non-responders, then by priority (lowe=
r
+ * first), then by RTT (lower first), then by original index for determi=
nism=2E
+ * This groups responders into priority runs pre-sorted by RTT, wh=
ich the
+ * candidate-band step below relies on (run[0] is the fastest in i=
ts group)=2E */
+static int
+oob_probe_result_compare(const void *a, const =
void *b)
+{
+    const struct oob_probe_result *ra =3D a;
+    const struct=
 oob_probe_result *rb =3D b;
+
+    if (ra->responded && rb->responded)
+  =
  {
+        /* both answered: lowest priority first, then lowest RTT */
+ =
       if (ra->reply=2Epriority !=3D rb->reply=2Epriority)
+        {
+    =
        return ra->reply=2Epriority < rb->reply=2Epriority ? -1 : 1;
+     =
   }
+        if (ra->rtt_ms !=3D rb->rtt_ms)
+        {
+            retur=
n ra->rtt_ms < rb->rtt_ms ? -1 : 1;
+        }
+    }
+    else if (ra->res=
ponded)
+    {
+        return -1; /* only a answered: it ranks first */
+ =
   }
+    else if (rb->responded)
+    {
+        return 1; /* only b answe=
red */
+    }
+
+    /* neither answered, or all keys equal: keep the confi=
gured order */
+    return ra->index - rb->index;
+}
+
+int
+oob_effective_=
margin(const struct oob_probe_result *r, int client_margin)
+{
+    if (cli=
ent_margin >=3D 0)
+    {
+        return client_margin;              /* th=
e client's own setting is authoritative */
+    }
+    return (int)r->reply=
=2Emax_latency_diff; /* else what the fastest remote advertised */
+}
+
+/*=
 Reorder the index list idx[0=2E=2Em) into DNS-SRV (RFC 2782) weighted-rand=
om
+ * order by results[idx[k]]=2Ereply=2Eweight: each position is filled b=
y a remaining entry
+ * chosen with probability proportional to its weight=
=2E When all remaining
+ * weights are 0 the current (RTT-sorted) order is =
kept=2E */
+static void
+oob_weighted_order(const struct oob_probe_result *=
results, int *idx, int m, int64_t (*rng)(void))
+{
+    for (int pos =3D 0;=
 pos < m; pos++)
+    {
+        long sum =3D 0;
+        for (int k =3D po=
s; k < m; k++)
+        {
+            sum +=3D results[idx[k]]=2Ereply=2Ew=
eight;
+        }
+        int chosen =3D pos;
+        if (sum > 0)
+     =
   {
+            int64_t r =3D rng() % sum; /* uniform in [0, sum) */
+   =
         long acc =3D 0;
+            for (int k =3D pos; k < m; k++)
+    =
        {
+                acc +=3D results[idx[k]]=2Ereply=2Eweight;
+    =
            if (acc > r)
+                {
+                    chosen =3D=
 k;
+                    break;
+                }
+            }
+        =
}
+        /* Move the chosen entry to pos and shift the ones it jumped ove=
r down
+         * by one=2E RFC 2782 removes the selected entry from the l=
ist, so the
+         * rest keep their RTT order; a swap would fling the d=
isplaced entry to
+         * the far end and can leave the fastest server =
tried last=2E */
+        int sel =3D idx[chosen];
+        for (int k =3D =
chosen; k > pos; k--)
+        {
+            idx[k] =3D idx[k - 1];
+     =
   }
+        idx[pos] =3D sel;
+    }
+}
+
+/* Reorder one priority run (r=
un[0=2E=2Em), already RTT-sorted) in place:
+ * candidates (RTT within the =
band of the fastest) first, ordered by weighted
+ * random; then non-candid=
ates in RTT order=2E */
+static void
+oob_order_priority_run(struct oob_pro=
be_result *run, int m, int client_margin, int64_t (*rng)(void),
+          =
             struct gc_arena *gc)
+{
+    if (m <=3D 1)
+    {
+        ret=
urn;
+    }
+
+    unsigned int best_rtt =3D run[0]=2Ertt_ms; /* run is RTT=
-sorted: [0] is fastest */
+
+    int *cand =3D gc_malloc(sizeof(int) * m, =
false, gc);
+    int *non =3D gc_malloc(sizeof(int) * m, false, gc);
+    i=
nt nc =3D 0;
+    int nn =3D 0;
+    /* The band is the fastest remote's: i=
ts margin says how much slower another
+     * remote may be and still coun=
t as equal to it, weight then deciding between
+     * them=2E A slower rem=
ote's own margin plays no part=2E The comparison is
+     * inclusive ("no =
more than max_latency_diff larger than the lowest RTT"),
+     * so the fas=
test is always a candidate, also when it advertises 0=2E */
+    const unsi=
gned int margin =3D (unsigned int)oob_effective_margin(&run[0], client_marg=
in);
+    for (int k =3D 0; k < m; k++)
+    {
+        unsigned int gap =
=3D run[k]=2Ertt_ms - best_rtt;
+        if (gap <=3D margin)
+        {
+ =
           cand[nc++] =3D k;
+        }
+        else
+        {
+         =
   non[nn++] =3D k;
+        }
+    }
+
+    oob_weighted_order(run, cand, =
nc, rng);
+
+    struct oob_probe_result *tmp =3D gc_malloc(sizeof(*tmp) * =
m, false, gc);
+    int t =3D 0;
+    for (int k =3D 0; k < nc; k++)
+    {=

+        tmp[t++] =3D run[cand[k]];
+    }
+    for (int k =3D 0; k < nn; =
k++)
+    {
+        tmp[t++] =3D run[non[k]];
+    }
+    memcpy(run, tmp,=
 sizeof(*run) * m);
+}
+
+void
+oob_rank_probe_results(struct oob_probe_res=
ult *results, int n, int client_margin,
+                       int64_t (*r=
ng)(void), struct gc_arena *gc)
+{
+    if (n <=3D 1)
+    {
+        retur=
n;
+    }
+
+    /* Base order: responders first, grouped by priority, RTT-=
sorted within=2E */
+    qsort(results, (size_t)n, sizeof(*results), oob_pr=
obe_result_compare);
+
+    /* Reorder each priority run of responders by c=
andidate-band + weight=2E */
+    int i =3D 0;
+    while (i < n && results=
[i]=2Eresponded)
+    {
+        int j =3D i;
+        while (j < n && resu=
lts[j]=2Eresponded
+               && results[j]=2Ereply=2Epriority =3D=3D =
results[i]=2Ereply=2Epriority)
+        {
+            j++;
+        }
+   =
     oob_order_priority_run(results + i, j - i, client_margin, rng, gc);
+ =
       i =3D j;
+    }
+}
diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oo=
b=2Eh
index 21af63f=2E=2Eb902363 100644
--- a/src/openvpn/oob=2Eh
+++ b/src=
/openvpn/oob=2Eh
@@ -177,4 +177,56 @@
 enum oob_probe_verdict oob_server_pr=
obe_check(struct buffer *probe_payload, uint64_t now,
                     =
                          uint64_t window_secs);
 
+/* Candidate-band margi=
n (ms) a server advertises when --server-probe-reply does
+ * not set one=
=2E Announcing 0 is a valid choice with a distinct meaning -- only
+ * the =
lowest-latency server is a candidate -- so an unconfigured server has to
+ =
* announce something else; the spec suggests 10 to 20 ms=2E */
+#define OOB=
_DEFAULT_LATENCY_MARGIN_MS 10
+
+/* Outcome of probing one remote, used to =
order remotes best-first=2E @index is
+ * the caller's identifier for the r=
emote (e=2Eg=2E its position in the connection
+ * list); priority/weight a=
re only meaningful when @responded is true=2E */
+struct oob_probe_result
+=
{
+    int index;
+    bool responded;
+    unsigned int rtt_ms;          /=
* probe round-trip time in ms (responders only) */
+    struct oob_probe_re=
ply reply; /* the values the server advertised */
+};
+
+/**
+ * Order resu=
lts best-first, in place, per the server-probe selection policy:
+ *   - re=
motes that responded rank before those that did not (non-responders keep
+ =
*     their original relative order, last);
+ *   - responders are grouped =
by priority, lowest priority value first (an
+ *     absolute ordering, nev=
er overridden by latency or weight);
+ *   - within a priority group, the "=
candidates" are the responders whose RTT is
+ *     no more than the fastes=
t remote's margin larger than its RTT (see
+ *     oob_effective_margin()),=
 so the fastest is always one=2E Candidates are
+ *     ordered ahead of no=
n-candidates;
+ *   - candidates are ordered by DNS-SRV (RFC 2782) weighted=
-random selection by
+ *     weight, so a server is chosen first with proba=
bility proportional to its
+ *     weight (load distribution)=2E Non-candid=
ates follow, ordered by RTT=2E
+ *
+ * @param results        results to reo=
rder in place
+ * @param n              number of results
+ * @param client=
_margin  client's candidate-band margin in ms, or < 0 if the
+ *           =
             client did not set one (see oob_effective_margin())
+ * @param=
 rng            returns a non-negative random value (e=2Eg=2E get_random);
=
+ *                       injected so this module stays free of the crypto =
layer
+ *                       and the weighted ordering is deterministica=
lly testable
+ * @param gc             arena for scratch allocation
+ */
+v=
oid oob_rank_probe_results(struct oob_probe_result *results, int n, int cli=
ent_margin,
+                            int64_t (*rng)(void), struct gc_ar=
ena *gc);
+
+/**
+ * The candidate-band margin (ms) of a priority group -- =
how much slower than
+ * the group's fastest remote another remote may be a=
nd still be a candidate=2E
+ * The client's own setting is authoritative; w=
hen client_margin < 0 the
+ * max_latency_diff advertised by the fastest re=
mote (r) applies to the whole
+ * group=2E 0 then admits only remotes tying=
 the fastest=2E
+ */
+int oob_effective_margin(const struct oob_probe_resul=
t *r, int client_margin);
+
 #endif /* OOB_H */
diff --git a/tests/unit_tes=
ts/openvpn/test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec
index 5805c=
b5=2E=2Ec34b902 100644
--- a/tests/unit_tests/openvpn/test_oob=2Ec
+++ b/te=
sts/unit_tests/openvpn/test_oob=2Ec
@@ -614,6 +614,267 @@
     gc_free(&gc)=
;
 }
 
+/* Deterministic RNG stubs for the weighted-selection ordering=2E r=
ank_rng_zero
+ * makes the weighted draw always pick the first remaining ca=
ndidate, preserving
+ * order; rank_rng_fixed returns a value we set to lan=
d in a chosen weight slice=2E */
+static int64_t
+rank_rng_zero(void)
+{
+ =
   return 0;
+}
+
+static int64_t rank_rng_value;
+static int64_t
+rank_rng=
_fixed(void)
+{
+    return rank_rng_value;
+}
+
+/* Picking a weighted ent=
ry must not disturb the RTT order of the entries it
+ * was picked ahead of=
: RFC 2782 removes the selection, it does not swap=2E */
+static void
+test=
_rank_weighted_keeps_rtt_order_of_rest(void **state)
+{
+    struct gc_aren=
a gc =3D gc_new();
+    /* same priority, all in band; only the slowest adv=
ertises a weight, so it
+     * is drawn first and the two weight-0 entries=
 must follow in RTT order=2E */
+    struct oob_probe_result r[] =3D {
+   =
     { =2Eindex =3D 0, =2Eresponded =3D true, =2Ertt_ms =3D 20, =2Ereply =
=3D { =2Epriority =3D 10, =2Eweight =3D 0 } },
+        { =2Eindex =3D 1, =
=2Eresponded =3D true, =2Ertt_ms =3D 30, =2Ereply =3D { =2Epriority =3D 10,=
 =2Eweight =3D 0 } },
+        { =2Eindex =3D 2, =2Eresponded =3D true, =2E=
rtt_ms =3D 40, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 10 } },
+  =
  };
+
+    rank_rng_value =3D 0;
+    oob_rank_probe_results(r, 3, 100, ra=
nk_rng_fixed, &gc);
+
+    assert_int_equal(r[0]=2Eindex, 2); /* the only w=
eighted entry wins the draw */
+    assert_int_equal(r[1]=2Eindex, 0); /* 2=
0 ms before 30 ms */
+    assert_int_equal(r[2]=2Eindex, 1);
+
+    gc_free=
(&gc);
+}
+
+/* Responders rank ahead of non-responders regardless of index=
 order=2E */
+static void
+test_rank_responder_before_nonresponder(void **s=
tate)
+{
+    struct gc_arena gc =3D gc_new();
+    struct oob_probe_result=
 r[] =3D {
+        { =2Eindex =3D 0, =2Eresponded =3D false },
+        { =
=2Eindex =3D 1, =2Eresponded =3D true, =2Ereply =3D { =2Epriority =3D 100, =
=2Eweight =3D 50 } },
+    };
+    oob_rank_probe_results(r, 2, 10, rank_rn=
g_zero, &gc);
+    assert_int_equal(r[0]=2Eindex, 1);
+    assert_int_equal=
(r[1]=2Eindex, 0);
+    gc_free(&gc);
+}
+
+/* Among responders, the lowest=
 priority value wins (an absolute ordering)=2E */
+static void
+test_rank_b=
y_priority(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    stru=
ct oob_probe_result r[] =3D {
+        { =2Eindex =3D 0, =2Eresponded =3D t=
rue, =2Ereply =3D { =2Epriority =3D 20, =2Eweight =3D 50 } },
+        { =
=2Eindex =3D 1, =2Eresponded =3D true, =2Ereply =3D { =2Epriority =3D 5, =
=2Eweight =3D 50 } },
+        { =2Eindex =3D 2, =2Eresponded =3D true, =2E=
reply =3D { =2Epriority =3D 10, =2Eweight =3D 50 } },
+    };
+    oob_rank=
_probe_results(r, 3, 10, rank_rng_zero, &gc);
+    assert_int_equal(r[0]=2E=
index, 1); /* priority 5 */
+    assert_int_equal(r[1]=2Eindex, 2); /* prio=
rity 10 */
+    assert_int_equal(r[2]=2Eindex, 0); /* priority 20 */
+    g=
c_free(&gc);
+}
+
+/* Within a priority, only servers within the latency ma=
rgin of the fastest are
+ * candidates; a slower (out-of-band) server ranks=
 behind a faster one no matter
+ * how large its weight=2E */
+static void
=
+test_rank_candidate_band(void **state)
+{
+    struct gc_arena gc =3D gc_n=
ew();
+    struct oob_probe_result r[] =3D {
+        { =2Eindex =3D 0, =2E=
responded =3D true, =2Ertt_ms =3D 100, =2Ereply =3D { =2Epriority =3D 10, =
=2Eweight =3D 1000 } },
+        { =2Eindex =3D 1, =2Eresponded =3D true, =
=2Ertt_ms =3D 20, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 1 } },
+=
    };
+    /* margin 10ms: 20ms is fastest; 100ms is 80ms slower -> out of=
 band */
+    oob_rank_probe_results(r, 2, 10, rank_rng_zero, &gc);
+    as=
sert_int_equal(r[0]=2Eindex, 1); /* fast, in-band, despite tiny weight */
+=
    assert_int_equal(r[1]=2Eindex, 0); /* slow, out-of-band, despite huge w=
eight */
+    gc_free(&gc);
+}
+
+/* A server widens its own band via the a=
dvertised max_latency_diff, joining the
+ * candidate set even when it is w=
ell behind the fastest; it then participates in
+ * the weighted selection=
=2E */
+/* A client margin, even 0, overrides whatever the servers advertis=
e=2E */
+static void
+test_rank_client_margin_overrides_advertised(void **s=
tate)
+{
+    struct gc_arena gc =3D gc_new();
+    struct oob_probe_result=
 r[] =3D {
+        { =2Eindex =3D 0, =2Eresponded =3D true, =2Ertt_ms =3D =
20, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 1 } },
+        { =2Ei=
ndex =3D 1,
+          =2Eresponded =3D true,
+          =2Ertt_ms =3D 100,=

+          =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 1000, =2Emax_l=
atency_diff =3D 200 } },
+    };
+    /* With the advertised 200 ms the slo=
w server would be a candidate (see
+     * test_rank_advertised_margin); th=
e client's 0 leaves only the fastest=2E */
+    rank_rng_value =3D 500;
+  =
  oob_rank_probe_results(r, 2, 0, rank_rng_fixed, &gc);
+    assert_int_equ=
al(r[0]=2Eindex, 0);
+    assert_int_equal(r[1]=2Eindex, 1);
+    gc_free(&=
gc);
+}
+
+static void
+test_rank_advertised_margin(void **state)
+{
+    s=
truct gc_arena gc =3D gc_new();
+    struct oob_probe_result r[] =3D {
+   =
     { =2Eindex =3D 0,
+          =2Eresponded =3D true,
+          =2Ertt_=
ms =3D 20,
+          =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 1, =
=2Emax_latency_diff =3D 200 } },
+        { =2Eindex =3D 1, =2Eresponded =
=3D true, =2Ertt_ms =3D 100, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =
=3D 1000 } },
+    };
+    /* Client did not set a margin (-1), so the fast=
est server's advertised
+     * value applies: it says 200, so the 100ms se=
rver is a candidate 80ms
+     * behind it; with weight 1000 (slice [1,1001=
)) a draw of 500 selects it
+     * first=2E */
+    rank_rng_value =3D 500=
;
+    oob_rank_probe_results(r, 2, -1, rank_rng_fixed, &gc);
+    assert_i=
nt_equal(r[0]=2Eindex, 1);
+    gc_free(&gc);
+}
+
+/* A slower server's ow=
n margin does not admit it: with the fastest advertising
+ * 0, the 100ms s=
erver is no candidate however wide its margin or heavy its
+ * weight=2E */=

+static void
+test_rank_slower_servers_margin_has_no_effect(void **state)
=
+{
+    struct gc_arena gc =3D gc_new();
+    struct oob_probe_result r[] =
=3D {
+        { =2Eindex =3D 0, =2Eresponded =3D true, =2Ertt_ms =3D 20, =
=2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 1 } },
+        { =2Eindex=
 =3D 1,
+          =2Eresponded =3D true,
+          =2Ertt_ms =3D 100,
+  =
        =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 1000, =2Emax_laten=
cy_diff =3D 200 } },
+    };
+    rank_rng_value =3D 500;
+    oob_rank_pro=
be_results(r, 2, -1, rank_rng_fixed, &gc);
+    assert_int_equal(r[0]=2Eind=
ex, 0);
+    gc_free(&gc);
+}
+
+/* Among candidates, weight drives RFC-278=
2 proportional selection: a draw is
+ * mapped to the server whose cumulati=
ve weight slice it falls in=2E */
+static void
+test_rank_weighted_selectio=
n(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    /* equal prio=
rity and RTT -> both in band; weights 30 and 70, sum 100:
+     * index 0 o=
wns [0,30), index 1 owns [30,100)=2E */
+    const struct oob_probe_result =
base[] =3D {
+        { =2Eindex =3D 0, =2Eresponded =3D true, =2Ertt_ms =
=3D 20, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 30 } },
+        {=
 =2Eindex =3D 1, =2Eresponded =3D true, =2Ertt_ms =3D 20, =2Ereply =3D { =
=2Epriority =3D 10, =2Eweight =3D 70 } },
+    };
+    struct oob_probe_res=
ult r[2];
+
+    memcpy(r, base, sizeof(base));
+    rank_rng_value =3D 10;=
 /* falls in index 0's slice */
+    oob_rank_probe_results(r, 2, 50, rank_=
rng_fixed, &gc);
+    assert_int_equal(r[0]=2Eindex, 0);
+
+    memcpy(r, b=
ase, sizeof(base));
+    rank_rng_value =3D 50; /* falls in index 1's slice=
 */
+    oob_rank_probe_results(r, 2, 50, rank_rng_fixed, &gc);
+    assert=
_int_equal(r[0]=2Eindex, 1);
+
+    gc_free(&gc);
+}
+
+/* The fastest adve=
rtising 0 means "compare on latency alone": the band is
+ * empty, so weigh=
t cannot float a slower peer ahead of it=2E The same pair with a
+ * band a=
dvertised does let weight decide=2E */
+static void
+test_rank_advertised_z=
ero_margin(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    cons=
t struct oob_probe_result base[] =3D {
+        { =2Eindex =3D 0, =2Erespon=
ded =3D true, =2Ertt_ms =3D 20, =2Ereply =3D { =2Epriority =3D 10, =2Eweigh=
t =3D 1 } },
+        { =2Eindex =3D 1, =2Eresponded =3D true, =2Ertt_ms =
=3D 40, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 1000 } },
+    };
=
+    struct oob_probe_result r[2];
+
+    memcpy(r, base, sizeof(base));
+ =
   rank_rng_value =3D 500;
+    oob_rank_probe_results(r, 2, -1, rank_rng_f=
ixed, &gc);
+    assert_int_equal(r[0]=2Eindex, 0); /* both advertise 0 -> =
fastest wins */
+
+    memcpy(r, base, sizeof(base));
+    r[0]=2Ereply=2Em=
ax_latency_diff =3D 50;
+    r[1]=2Ereply=2Emax_latency_diff =3D 50;
+    r=
ank_rng_value =3D 500;            /* falls in the weight-1000 slice [1,1001=
) */
+    oob_rank_probe_results(r, 2, -1, rank_rng_fixed, &gc);
+    asser=
t_int_equal(r[0]=2Eindex, 1); /* 20ms behind but inside a 50ms band */
+
+ =
   gc_free(&gc);
+}
+
+/* Remotes tied at the fastest RTT are all candidate=
s even at margin 0, so weight
+ * still distributes load between them=2E */=

+static void
+test_rank_zero_margin_weights_ties(void **state)
+{
+    str=
uct gc_arena gc =3D gc_new();
+    struct oob_probe_result r[] =3D {
+     =
   { =2Eindex =3D 0, =2Eresponded =3D true, =2Ertt_ms =3D 20, =2Ereply =3D =
{ =2Epriority =3D 10, =2Eweight =3D 1, =2Emax_latency_diff =3D 0 } },
+    =
    { =2Eindex =3D 1, =2Eresponded =3D true, =2Ertt_ms =3D 20, =2Ereply =3D=
 { =2Epriority =3D 10, =2Eweight =3D 1000, =2Emax_latency_diff =3D 0 } },
+=
    };
+    rank_rng_value =3D 500; /* falls in the weight-1000 slice [1,10=
01) */
+    oob_rank_probe_results(r, 2, -1, rank_rng_fixed, &gc);
+    ass=
ert_int_equal(r[0]=2Eindex, 1);
+    gc_free(&gc);
+}
+
+/* A remote exactl=
y its advertised margin behind the fastest is still a candidate
+ * ("no mo=
re than max_latency_diff larger than the lowest RTT")=2E */
+static void
+t=
est_rank_margin_boundary_is_inclusive(void **state)
+{
+    struct gc_arena=
 gc =3D gc_new();
+    struct oob_probe_result r[] =3D {
+        { =2Einde=
x =3D 0, =2Eresponded =3D true, =2Ertt_ms =3D 20, =2Ereply =3D { =2Epriorit=
y =3D 10, =2Eweight =3D 1, =2Emax_latency_diff =3D 10 } },
+        { =2Ein=
dex =3D 1, =2Eresponded =3D true, =2Ertt_ms =3D 30, =2Ereply =3D { =2Eprior=
ity =3D 10, =2Eweight =3D 1000, =2Emax_latency_diff =3D 10 } },
+    };
+  =
  rank_rng_value =3D 500;
+    oob_rank_probe_results(r, 2, -1, rank_rng_fi=
xed, &gc);
+    assert_int_equal(r[0]=2Eindex, 1); /* exactly 10ms behind, =
in band, wins on weight */
+    gc_free(&gc);
+}
+
+/* Non-responders are p=
laced last, keeping their original relative order=2E */
+static void
+test_=
rank_nonresponders_last(void **state)
+{
+    struct gc_arena gc =3D gc_new=
();
+    struct oob_probe_result r[] =3D {
+        { =2Eindex =3D 0, =2Ere=
sponded =3D false },
+        { =2Eindex =3D 1, =2Eresponded =3D true, =2Er=
tt_ms =3D 20, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 50 } },
+   =
     { =2Eindex =3D 2, =2Eresponded =3D false },
+        { =2Eindex =3D 3,=
 =2Eresponded =3D true, =2Ertt_ms =3D 20, =2Ereply =3D { =2Epriority =3D 10=
, =2Eweight =3D 50 } },
+    };
+    oob_rank_probe_results(r, 4, 10, rank_=
rng_zero, &gc);
+    assert_int_equal(r[0]=2Eindex, 1); /* responder (rng_z=
ero keeps order) */
+    assert_int_equal(r[1]=2Eindex, 3); /* responder */=

+    assert_int_equal(r[2]=2Eindex, 0); /* non-responder, original order k=
ept */
+    assert_int_equal(r[3]=2Eindex, 2);
+    gc_free(&gc);
+}
+
 int=

 main(void)
 {
@@ -644,6 +905,18 @@
         cmocka_unit_test(test_client_=
reply_read_rejects_unknown_mandatory),
         cmocka_unit_test(test_clien=
t_reply_read_missing),
         cmocka_unit_test(test_client_reply_read_wro=
ng_msg_type),
+        cmocka_unit_test(test_rank_responder_before_nonrespo=
nder),
+        cmocka_unit_test(test_rank_by_priority),
+        cmocka_un=
it_test(test_rank_candidate_band),
+        cmocka_unit_test(test_rank_adve=
rtised_margin),
+        cmocka_unit_test(test_rank_client_margin_overrides=
_advertised),
+        cmocka_unit_test(test_rank_advertised_zero_margin),
=
+        cmocka_unit_test(test_rank_slower_servers_margin_has_no_effect),
+=
        cmocka_unit_test(test_rank_zero_margin_weights_ties),
+        cmoc=
ka_unit_test(test_rank_margin_boundary_is_inclusive),
+        cmocka_unit_=
test(test_rank_weighted_selection),
+        cmocka_unit_test(test_rank_wei=
ghted_keeps_rtt_order_of_rest),
+        cmocka_unit_test(test_rank_nonresp=
onders_last),
     };
 
     return cmocka_run_group_tests_name("oob tests"=
, tests, NULL, NULL);

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1746?usp=3Demail
To unsubscribe, or for help writing mail filters,=
 visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: I55da68cc341bcfc707fd34ca2f84ff9b6a55501f
Gerrit-Change-Number: 1746
G=
errit-PatchSet: 20
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Revie=
wer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ral=
f@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefo=
rge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Attention: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: stipa <lstipa=
kov@gmail=2Ecom>

--wArc4QEFaUk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici, stipa=2E </p>
<p>stipa <strong>=
uploaded patch set #20</strong> to this change=2E</p><p><a href=3D"http://g=
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
/openvpn/test_oob=2Ec<br>3 files changed, 491 insertions(+), 0 deletions(-)=
<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/ope=
nvpn refs/changes/46/1746/20</pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;"><span>diff --git a/src/openvpn/oob=2Ec b/src=
/openvpn/oob=2Ec</span><br><span>index 369e500=2E=2E8227e1b 100644</span><b=
r><span>--- a/src/openvpn/oob=2Ec</span><br><span>+++ b/src/openvpn/oob=2Ec=
</span><br><span>@@ -146,3 +146,169 @@</span><br><span>     return oob_time=
stamp_in_window(param=2Etimestamp, now, window_secs) ? OOB_PROBE_OK</span><=
br><span>                                                                  =
       : OOB_PROBE_STALE;</span><br><span> }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+/* Base ordering: responders before non-responders, then by priority =
(lower</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * first), th=
en by RTT (lower first), then by original index for determinism=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * This groups responders in=
to priority runs pre-sorted by RTT, which the</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * candidate-band step below relies on (run[0] is=
 the fastest in its group)=2E */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+static int</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+oob_probe_result_compare(const void *a, const void *b)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const struct oob_probe_result *ra =3D a;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    const struct oob_probe_re=
sult *rb =3D b;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ra-&gt;responde=
d &amp;&amp; rb-&gt;responded)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     /* both answered: lowest priority first, then lowest RTT */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if (ra-&gt;reply=2Epri=
ority !=3D rb-&gt;reply=2Epriority)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            return ra-&gt;reply=2Epriority &lt; rb-&gt;reply=2Epriori=
ty ? -1 : 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (ra-&g=
t;rtt_ms !=3D rb-&gt;rtt_ms)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           return ra-&gt;rtt_ms &lt; rb-&gt;rtt_ms ? -1 : 1;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    else if (ra-&gt;responded)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        return -1; /* only a answered: it ranks first */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    else if (rb-&gt;responded)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return 1; /* only b answered */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* neither answered, or all keys equal: keep the c=
onfigured order */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   return ra-&gt;index - rb-&gt;index;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+oob_effective_margin(const struct =
oob_probe_result *r, int client_margin)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (client_margin &gt;=3D 0)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        return client_margin;              /* the client&#39;s own setting=
 is authoritative */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (i=
nt)r-&gt;reply=2Emax_latency_diff; /* else what the fastest remote advertis=
ed */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/* Reorder the index list idx[0=2E=2Em) into DNS-SR=
V (RFC 2782) weighted-random</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * order by results[idx[k]]=2Ereply=2Eweight: each position is fil=
led by a remaining entry</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * chosen with probability proportional to its weight=2E When all rema=
ining</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * weights are=
 0 the current (RTT-sorted) order is kept=2E */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+oob_weighted_order(const struct oob_probe_result *resul=
ts, int *idx, int m, int64_t (*rng)(void))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    for (int pos =3D 0; pos &lt; m; pos++)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        long sum =3D 0;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        for (int k =3D pos; k &lt; m; k++)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            sum +=3D results[idx[k]]=2Ereply=
=2Eweight;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int chosen =
=3D pos;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
(sum &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            int64=
_t r =3D rng() % sum; /* uniform in [0, sum) */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            long acc =3D 0;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            for (int k =3D pos; k &lt; =
m; k++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                ac=
c +=3D results[idx[k]]=2Ereply=2Eweight;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                if (acc &gt; r)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    chosen =3D k;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                    break;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        /* Move the chosen entry to po=
s and shift the ones it jumped over down</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+         * by one=2E RFC 2782 removes the selected ent=
ry from the list, so the</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+         * rest keep their RTT order; a swap would fling the displaced=
 entry to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         *=
 the far end and can leave the fastest server tried last=2E */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        int sel =3D idx[chosen];=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (int k =
=3D chosen; k &gt; pos; k--)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           idx[k] =3D idx[k - 1];</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        idx[pos] =3D sel;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* Reorder one priority run (run[0=2E=2Em=
), already RTT-sorted) in place:</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * candidates (RTT within the band of the fastest) first, orde=
red by weighted</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * r=
andom; then non-candidates in RTT order=2E */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+oob_order_priority_run(struct oob_probe_result *run, int =
m, int client_margin, int64_t (*rng)(void),</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                       struct gc_arena *gc)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (m &lt;=3D 1)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int bes=
t_rtt =3D run[0]=2Ertt_ms; /* run is RTT-sorted: [0] is fastest */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    int *cand =3D gc_malloc(sizeof(int) * m, fa=
lse, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int *n=
on =3D gc_malloc(sizeof(int) * m, false, gc);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    int nc =3D 0;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    int nn =3D 0;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* The band is the fastest remote&#39;s: its marg=
in says how much slower another</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+     * remote may be and still count as equal to it, weight the=
n deciding between</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    * them=2E A slower remote&#39;s own margin plays no part=2E The compari=
son is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * inclus=
ive (&quot;no more than max_latency_diff larger than the lowest RTT&quot;),=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * so the faste=
st is always a candidate, also when it advertises 0=2E */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    const unsigned int margin =3D (un=
signed int)oob_effective_margin(&amp;run[0], client_margin);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    for (int k =3D 0; k &lt; m; k+=
+)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        unsigned int gap =3D ru=
n[k]=2Ertt_ms - best_rtt;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (gap &lt;=3D margin)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            cand[nc++] =3D k;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   non[nn++] =3D k;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    oob_weighted_order(run, cand, nc, rng=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_result *tmp =3D=
 gc_malloc(sizeof(*tmp) * m, false, gc);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    int t =3D 0;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    for (int k =3D 0; k &lt; nc; k++)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        tmp[t++] =3D run[cand[k]];</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    for (int k =3D 0; k &lt; nn; k++)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        tmp[t++] =3D run[non[k]];</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    memcpy(run, tmp, sizeof(*run) * m);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_r=
ank_probe_results(struct oob_probe_result *results, int n, int client_margi=
n,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
      int64_t (*rng)(void), struct gc_arena *gc)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (n &lt;=3D 1)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* Base order: responders first, gr=
ouped by priority, RTT-sorted within=2E */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    qsort(results, (size_t)n, sizeof(*results), oob_=
probe_result_compare);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Reorder e=
ach priority run of responders by candidate-band + weight=2E */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    int i =3D 0;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    while (i &lt; n &amp;&amp; res=
ults[i]=2Eresponded)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int j=
 =3D i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        whil=
e (j &lt; n &amp;&amp; results[j]=2Eresponded</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+               &amp;&amp; results[j]=2Ereply=2Epr=
iority =3D=3D results[i]=2Ereply=2Epriority)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            j++;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        oob_order_priority_run(results + i, j - i, client_margin, rng, gc=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i =3D j;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/src=
/openvpn/oob=2Eh b/src/openvpn/oob=2Eh</span><br><span>index 21af63f=2E=2Eb=
902363 100644</span><br><span>--- a/src/openvpn/oob=2Eh</span><br><span>+++=
 b/src/openvpn/oob=2Eh</span><br><span>@@ -177,4 +177,56 @@</span><br><span=
> enum oob_probe_verdict oob_server_probe_check(struct buffer *probe_payloa=
d, uint64_t now,</span><br><span>                                          =
     uint64_t window_secs);</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/* Candidate-band margin (ms) a server advertises=
 when --server-probe-reply does</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * not set one=2E Announcing 0 is a valid choice with a distinc=
t meaning -- only</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 the lowest-latency server is a candidate -- so an unconfigured server has =
to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * announce somet=
hing else; the spec suggests 10 to 20 ms=2E */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#define OOB_DEFAULT_LATENCY_MARGIN_MS 10</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/* Outcome of probing one remote, used to orde=
r remotes best-first=2E @index is</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * the caller&#39;s identifier for the remote (e=2Eg=2E its p=
osition in the connection</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * list); priority/weight are only meaningful when @responded is true=
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
oob=2Ec</span><br><span>index 5805cb5=2E=2Ec34b902 100644</span><br><span>-=
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
> int</span><br><span> main(void)</span><br><span> {</span><br><span>@@ -64=
4,6 +905,18 @@</span><br><span>         cmocka_unit_test(test_client_reply_=
read_rejects_unknown_mandatory),</span><br><span>         cmocka_unit_test(=
test_client_reply_read_missing),</span><br><span>         cmocka_unit_test(=
test_client_reply_read_wrong_msg_type),</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        cmocka_unit_test(test_rank_responder_before_non=
responder),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
cmocka_unit_test(test_rank_by_priority),</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        cmocka_unit_test(test_rank_candidate_band),</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_te=
st(test_rank_advertised_margin),</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        cmocka_unit_test(test_rank_client_margin_overrides_adv=
ertised),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cm=
ocka_unit_test(test_rank_advertised_zero_margin),</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_rank_slower_ser=
vers_margin_has_no_effect),</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        cmocka_unit_test(test_rank_zero_margin_weights_ties),</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(=
test_rank_margin_boundary_is_inclusive),</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        cmocka_unit_test(test_rank_weighted_selection)=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_uni=
t_test(test_rank_weighted_keeps_rtt_order_of_rest),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_rank_nonres=
ponders_last),</span><br><span>     };</span><br><span> </span><br><span>  =
   return cmocka_run_group_tests_name(&quot;oob tests&quot;, tests, NULL, N=
ULL);</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1746?usp=3Demail">change 1746</a>=2E To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope =
itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1746?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displa=
y:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"=
> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch=
: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I55da68cc341=
bcfc707fd34ca2f84ff9b6a55501f </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Number: 1746 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 20 <=
/div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
=

</body></html>
--wArc4QEFaUk=--


--===============1489199371516686358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1489199371516686358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1489199371516686358==--

