Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 622EDC54FCD
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 12:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/NNumiEE+aEgy0thoHgo6fntUtfLNMmj3tyx3BVPmy4=; b=PPPRBd82BQMBgj11XLKpks5gIs
	gmRDT+V8/IgtxMpxGbr0xjBjSkl+ci8rrq+F1a45ozZ6nbGnY0+xRhg9wXD6o7S5PxeeNs1LmOFBl
	FRp9ko6TEzXsQuMv+cq3oGZU/S9GAFzcus5KeOq1ALQOQ1U7sjoHmjm7HK5Q/jL/OOXk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wp3Jm-0006YZ-Qr;
	Wed, 29 Jul 2026 12:23:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wp3Jk-0006YR-Hb
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 12:23:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=9lKVsyDRuYa7Y+JgyDyf4yj418kikNyKCvzXUYEoiOs=; b=nDL+hCMD6PH++opy4vxUe7NgdE
 S5WAMsJbMXP6kK9Xe3+w+Ibve3WuszUAXg9spYZYezzikQpw9PsFOxvTcYaWMgtGJuE6qzc5oW1YF
 jvYJ1bOFHalEbxXAtCutJK7sya2Cp+pEeB3HVTtvEvRfPZUbu1HclFYVCq7ngmkDh2Ew=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=9lKVsyDRuYa7Y+JgyDyf4yj418kikNyKCvzXUYEoiOs=; b=E
 VIXKzLPJ3566V/M1hwhUVQVOx/K3vhFRemrtRw39Nbuleu9fA3LZqwIh4MkPZsQ6gr94pjIPR0f+m
 UhltLIwjTatrvVg7+ox2eCGDUy96iPHfPAY5LYTN2H3h2cwyM1HRkkgTkkbKkvLK/pBqlF+EvjeBY
 PSSXKZ4RLB6q+bCI=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wp3Jl-0005LH-Ov for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 12:23:24 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-49553515a8bso11401705e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 29 Jul 2026 05:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785327796; x=1785932596; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9lKVsyDRuYa7Y+JgyDyf4yj418kikNyKCvzXUYEoiOs=;
 b=LpTGUJMD5OSI0KXNzslLrIdXAM4JVDwiCijey2zBDoqp254zc9Cp6J+pZFKbRF14XM
 /cmSJS8r8Q/5XGui5MLTy/4V7C0+Mmrf/1nH9cKJJ5+PeWkUyTYv1vgSoWn8zsKqRPcQ
 NDWKpDUtDka2eE1m4CzgAeB5Tk+BA3P37LuQ7kqLrNvldubQyMIIco858lcKyITIdDIj
 dnOBdKWlU+z2Kz2V0Gp2g8eOMSJjBCE2xGLxHqB+XWl9HV8zf7n1sdYCX3maqMIIVTNV
 SpMhl6LyuDZQUydrTsjOgh/cdqDMd2EePZtVuTf4wWqd+eHV+ooKFdlxULwf7Ch6k9rx
 +68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785327796; x=1785932596;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=9lKVsyDRuYa7Y+JgyDyf4yj418kikNyKCvzXUYEoiOs=;
 b=NNZ/ARVkYPw59huzY4adSecqsd8Z2KF8GxnQrw3BuvYaW7BdBTHymCa52S1wk56dLA
 UcvHTf/uWE175hpOpLghghrglr6w6mNnlMRhbCOuV/BboAPr1Ywb9fGkEC5XsINCJTS3
 39u+28AajhM8Yj/R71e4EyXlDBQzA60HAB/NNO64Zyy1ocdBhy04VdLVPgGCgm8c1gWF
 khEhqcNPE9mqhGirourWBl172XuExi8TAesLl7iMjFMAcNToWRbLPN53nYBvHrvi+H3g
 GkNFWsAUdXlwO3wTal6Qqebu8nIxmqg45zJjLAkwg9Rua+uVusMPDcVhxQfu4iEVaOAT
 OtbQ==
X-Gm-Message-State: AOJu0YxzYe7Cbgp9+gJLSgewNIPG3sqz1QCqFX8NfyMa+fRR/zhSmF9V
 /2J672lhzVNY4lLmnGVFTYg0YfPxIHANQRrx/YFP8NDkdZNmYyGsNX/rDfCIxShYzxeqw2csBpO
 CizewkxDQ37CyLWWv4a5NnHpw2c7zOdNEB2cWaE+BNtHY+jqomzwf0NbFUMvEnWSKqdBl
X-Gm-Gg: AR+sD127r/4NQ0dkfEKA7vYPuw8QUx7drsLa1CFGO4c3X9ZNXzG6yTrqf2o3Yscjuwg
 /pF9kYejuhtbl+pSEKg+R0NYEQ56VNPTcQYNGhjGqCPF3FFhfKs6JVJ9o09C5k9GfskoLY9RFDd
 7/YrWpV0x1HT35mr/we6syF+EOOH0kT3ZQybHEfG00ClTQAVkJvDz1KvUxt9qfHr+FJRSaSToXd
 VcZM9N84JpR2m9z1DpNurR7hPEYK/UwXAwXDBlVLqoVyoKuBgCOvO0kf2SsoMf7ZjGkfNWe7Vb6
 hEnHKnRRNc3QBLflcUWBPlZUU8Vb98hDjfu9mb781+QX13CgPTlgNvUMdzdR2V60nDPMzDIKZqA
 eN/RdR0yw0yumQ0i0hzwUoTP2HjfEalTpuln6/LzbNE56G8acGy8YZ4AhzwN6bq4VFAAvoioV+/
 vgJT/ey+BizKYlOZRkLbtVNyZIGUbgFNKWIGfPh793q11rO4ltJga3sDoCAOzLAWSAXazhE7AgG
 uBR1VM0wYFguYIQ92nKeQecznc6lNub+7VbSqVk3/71/pEyqqsSsm/rr0usThydRPJArFunKlrk
 WkKRdPyI6flbIztUu+qFPHsiGlURBIdGiw8Lju8GUSV9XQbM5Xg=
X-Received: by 2002:a05:600c:8b41:b0:495:734e:4825 with SMTP id
 5b1f17b1804b1-496c653c11fmr76077725e9.16.1785327795256; 
 Wed, 29 Jul 2026 05:23:15 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496e905fa40sm46910815e9.2.2026.07.29.05.23.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 05:23:14 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 29 Jul 2026 12:22:54 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 11
X-Gerrit-Change-Id: I55da68cc341bcfc707fd34ca2f84ff9b6a55501f
X-Gerrit-Change-Number: 1746
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1746?usp=email>
X-Gerrit-Commit: 835db5e4eb2775196d037c341e2da7d3a855e84a
In-Reply-To: <gerrit.1782719911000.I55da68cc341bcfc707fd34ca2f84ff9b6a55501f@gerrit.openvpn.net>
References: <gerrit.1782719911000.I55da68cc341bcfc707fd34ca2f84ff9b6a55501f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk1NWRhNjhjYzM0MWJjZmM3MDdmZDM0Y2EyZjg0ZmY5YjZhNTU1MDFmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ebd945ba53175ee97ed719795c2c38597f96ac71-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wp3Jl-0005LH-Ov
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
Content-Type: multipart/mixed; boundary="===============1869204081921184131=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1869204081921184131==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="39S+ZNc7xoY="; charset=UTF-8

--39S+ZNc7xoY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1746?usp=3Demail

to look at the new patch set (#11)=2E
=


Change subject: oob: Add probe-result ranking for server selection
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Add probe-resu=
lt ranking for server selection

Add oob_rank_probe_results(), which orders=
 remotes best-first from their probe
results, following the DNS-SRV (RFC 27=
82) semantics of the probe_reply TLV:

  - remotes that answered rank befor=
e those that did not (non-responders keep
    their original relative order=
, last);
  - responders are grouped by priority, lowest value first (an abs=
olute
    ordering, never overridden by latency or weight);
  - within a pr=
iority group the "candidates" are the responders whose RTT is
    within a =
margin of the fastest; candidates rank ahead of non-candidates;
  - candida=
tes are ordered by RFC-2782 weighted-random selection by weight, so
    a s=
erver is chosen first with probability proportional to its weight (load
   =
 distribution); non-candidates follow, ordered by RTT=2E

oob_effective_mar=
gin() decides that margin: the client's --server-probe value if
it set one,=
 otherwise the server's advertised max_latency_diff, otherwise 10 ms=2E

Th=
e RNG is injected as a function pointer so this module stays free of the
cr=
ypto layer and the weighted ordering is deterministically unit-testable (th=
e
client will pass get_random; the tests pass stubs)=2E

Exercised by unit =
tests; the client probe path calls it in a follow-up, which
also populates =
RTT -- until then every responder sits in the band and selection
is purely =
weighted-random=2E

Change-Id: I55da68cc341bcfc707fd34ca2f84ff9b6a55501f
Si=
gned-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M src/openvpn/oob=2Ec
M s=
rc/openvpn/oob=2Eh
M tests/unit_tests/openvpn/test_oob=2Ec
3 files changed,=
 347 insertions(+), 0 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Ene=
t:29418/openvpn refs/changes/46/1746/11

diff --git a/src/openvpn/oob=2Ec b=
/src/openvpn/oob=2Ec
index bc0e7a3=2E=2Ec8887a8 100644
--- a/src/openvpn/oo=
b=2Ec
+++ b/src/openvpn/oob=2Ec
@@ -155,3 +155,159 @@
     reply->peer_sess=
ion_id =3D *peer_sid;
     return true;
 }
+
+/* Base ordering: responders =
before non-responders, then by priority (lower
+ * first), then by RTT (low=
er first), then by original index for determinism=2E
+ * This groups respon=
ders into priority runs pre-sorted by RTT, which the
+ * candidate-band ste=
p below relies on (run[0] is the fastest in its group)=2E */
+static int
+o=
ob_probe_result_compare(const void *a, const void *b)
+{
+    const struct =
oob_probe_result *ra =3D a;
+    const struct oob_probe_result *rb =3D b;
+=

+    if (ra->responded && rb->responded)
+    {
+        /* both answered:=
 lowest priority first, then lowest RTT */
+        if (ra->reply=2Epriorit=
y !=3D rb->reply=2Epriority)
+        {
+            return ra->reply=2Epri=
ority < rb->reply=2Epriority ? -1 : 1;
+        }
+        if (ra->rtt_ms !=
=3D rb->rtt_ms)
+        {
+            return ra->rtt_ms < rb->rtt_ms ? -1=
 : 1;
+        }
+    }
+    else if (ra->responded)
+    {
+        return=
 -1; /* only a answered: it ranks first */
+    }
+    else if (rb->respond=
ed)
+    {
+        return 1; /* only b answered */
+    }
+
+    /* neithe=
r answered, or all keys equal: keep the configured order */
+    return ra-=
>index - rb->index;
+}
+
+int
+oob_effective_margin(const struct oob_probe_=
result *r, int client_margin)
+{
+    if (client_margin >=3D 0)
+    {
+   =
     return client_margin; /* the client's own setting is authoritative */
=
+    }
+    if (r->reply=2Emax_latency_diff > 0)
+    {
+        return (in=
t)r->reply=2Emax_latency_diff; /* else the server's advertised value */
+  =
  }
+    return OOB_DEFAULT_LATENCY_MARGIN_MS;
+}
+
+/* Reorder the index l=
ist idx[0=2E=2Em) into DNS-SRV (RFC 2782) weighted-random
+ * order by resu=
lts[idx[k]]=2Ereply=2Eweight: each position is filled by a remaining entry
=
+ * chosen with probability proportional to its weight=2E When all remainin=
g
+ * weights are 0 the current (RTT-sorted) order is kept=2E */
+static vo=
id
+oob_weighted_order(const struct oob_probe_result *results, int *idx, in=
t m, int64_t (*rng)(void))
+{
+    for (int pos =3D 0; pos < m; pos++)
+   =
 {
+        long sum =3D 0;
+        for (int k =3D pos; k < m; k++)
+     =
   {
+            sum +=3D results[idx[k]]=2Ereply=2Eweight;
+        }
+  =
      int chosen =3D pos;
+        if (sum > 0)
+        {
+            int=
64_t r =3D rng() % sum; /* uniform in [0, sum) */
+            long acc =3D=
 0;
+            for (int k =3D pos; k < m; k++)
+            {
+          =
      acc +=3D results[idx[k]]=2Ereply=2Eweight;
+                if (acc >=
 r)
+                {
+                    chosen =3D k;
+                =
    break;
+                }
+            }
+        }
+        int t =3D =
idx[pos];
+        idx[pos] =3D idx[chosen];
+        idx[chosen] =3D t;
+ =
   }
+}
+
+/* Reorder one priority run (run[0=2E=2Em), already RTT-sorted) =
in place:
+ * candidates (RTT within the band of the fastest) first, ordere=
d by weighted
+ * random; then non-candidates in RTT order=2E */
+static vo=
id
+oob_order_priority_run(struct oob_probe_result *run, int m, int client_=
margin, int64_t (*rng)(void),
+                       struct gc_arena *gc)
=
+{
+    if (m <=3D 1)
+    {
+        return;
+    }
+
+    unsigned int be=
st_rtt =3D run[0]=2Ertt_ms; /* run is RTT-sorted: [0] is fastest */
+
+    =
int *cand =3D gc_malloc(sizeof(int) * m, false, gc);
+    int *non =3D gc_m=
alloc(sizeof(int) * m, false, gc);
+    int nc =3D 0;
+    int nn =3D 0;
+ =
   for (int k =3D 0; k < m; k++)
+    {
+        if (run[k]=2Ertt_ms - best=
_rtt < (unsigned int)oob_effective_margin(&run[k], client_margin))
+       =
 {
+            cand[nc++] =3D k;
+        }
+        else
+        {
+    =
        non[nn++] =3D k;
+        }
+    }
+
+    oob_weighted_order(run, c=
and, nc, rng);
+
+    struct oob_probe_result *tmp =3D gc_malloc(sizeof(*tm=
p) * m, false, gc);
+    int t =3D 0;
+    for (int k =3D 0; k < nc; k++)
+=
    {
+        tmp[t++] =3D run[cand[k]];
+    }
+    for (int k =3D 0; k <=
 nn; k++)
+    {
+        tmp[t++] =3D run[non[k]];
+    }
+    memcpy(run,=
 tmp, sizeof(*run) * m);
+}
+
+void
+oob_rank_probe_results(struct oob_prob=
e_result *results, int n, int client_margin,
+                       int64_=
t (*rng)(void), struct gc_arena *gc)
+{
+    if (n <=3D 1)
+    {
+        =
return;
+    }
+
+    /* Base order: responders first, grouped by priority,=
 RTT-sorted within=2E */
+    qsort(results, (size_t)n, sizeof(*results), o=
ob_probe_result_compare);
+
+    /* Reorder each priority run of responders=
 by candidate-band + weight=2E */
+    int i =3D 0;
+    while (i < n && re=
sults[i]=2Eresponded)
+    {
+        int j =3D i;
+        while (j < n &&=
 results[j]=2Eresponded
+               && results[j]=2Ereply=2Epriority =
=3D=3D results[i]=2Ereply=2Epriority)
+        {
+            j++;
+       =
 }
+        oob_order_priority_run(results + i, j - i, client_margin, rng, =
gc);
+        i =3D j;
+    }
+}
diff --git a/src/openvpn/oob=2Eh b/src/ope=
nvpn/oob=2Eh
index 80775a4=2E=2E4eec498 100644
--- a/src/openvpn/oob=2Eh
++=
+ b/src/openvpn/oob=2Eh
@@ -180,4 +180,53 @@
 bool oob_build_probe_reply(st=
ruct buffer *probe_payload, uint64_t now, uint64_t window_secs,
           =
                 const struct session_id *peer_sid, struct oob_probe_reply =
*reply);
 
+/* Candidate-band margin (ms) used when neither the client nor =
the server
+ * specifies one=2E */
+#define OOB_DEFAULT_LATENCY_MARGIN_MS 1=
0
+
+/* Outcome of probing one remote, used to order remotes best-first=2E =
@index is
+ * the caller's identifier for the remote (e=2Eg=2E its position=
 in the connection
+ * list); priority/weight are only meaningful when @res=
ponded is true=2E */
+struct oob_probe_result
+{
+    int index;
+    bool =
responded;
+    unsigned int rtt_ms;          /* probe round-trip time in m=
s (responders only) */
+    struct oob_probe_reply reply; /* the values the=
 server advertised */
+};
+
+/**
+ * Order results best-first, in place, pe=
r the server-probe selection policy:
+ *   - remotes that responded rank be=
fore those that did not (non-responders keep
+ *     their original relativ=
e order, last);
+ *   - responders are grouped by priority, lowest priority=
 value first (an
+ *     absolute ordering, never overridden by latency or =
weight);
+ *   - within a priority group, the "candidates" are the responde=
rs whose RTT is
+ *     within a margin of the fastest in the group (see oo=
b_effective_margin())=2E
+ *     Candidates are ordered ahead of non-candid=
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
+ * The candidate-band margin (ms) that applies to one probed remo=
te=2E The client's
+ * own setting is authoritative: when client_margin >=
=3D 0 (the client set
+ * --server-probe with a value) it is used for every=
 remote=2E Otherwise the
+ * server's advertised max_latency_diff is used w=
hen non-zero, falling back to
+ * OOB_DEFAULT_LATENCY_MARGIN_MS=2E
+ */
+in=
t oob_effective_margin(const struct oob_probe_result *r, int client_margin)=
;
+
 #endif /* OOB_H */
diff --git a/tests/unit_tests/openvpn/test_oob=2Ec =
b/tests/unit_tests/openvpn/test_oob=2Ec
index 48bec2d=2E=2E1fc9258 100644
-=
-- a/tests/unit_tests/openvpn/test_oob=2Ec
+++ b/tests/unit_tests/openvpn/t=
est_oob=2Ec
@@ -517,6 +517,142 @@
     gc_free(&gc);
 }
 
+/* Deterministic=
 RNG stubs for the weighted-selection ordering=2E rank_rng_zero
+ * makes t=
he weighted draw always pick the first remaining candidate, preserving
+ * =
order; rank_rng_fixed returns a value we set to land in a chosen weight sli=
ce=2E */
+static int64_t
+rank_rng_zero(void)
+{
+    return 0;
+}
+
+stati=
c int64_t rank_rng_value;
+static int64_t
+rank_rng_fixed(void)
+{
+    ret=
urn rank_rng_value;
+}
+
+/* Responders rank ahead of non-responders regard=
less of index order=2E */
+static void
+test_rank_responder_before_nonrespo=
nder(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct oob=
_probe_result r[] =3D {
+        { =2Eindex =3D 0, =2Eresponded =3D false }=
,
+        { =2Eindex =3D 1, =2Eresponded =3D true, =2Ereply =3D { =2Eprior=
ity =3D 100, =2Eweight =3D 50 } },
+    };
+    oob_rank_probe_results(r, 2=
, 10, rank_rng_zero, &gc);
+    assert_int_equal(r[0]=2Eindex, 1);
+    ass=
ert_int_equal(r[1]=2Eindex, 0);
+    gc_free(&gc);
+}
+
+/* Among responder=
s, the lowest priority value wins (an absolute ordering)=2E */
+static void=

+test_rank_by_priority(void **state)
+{
+    struct gc_arena gc =3D gc_new=
();
+    struct oob_probe_result r[] =3D {
+        { =2Eindex =3D 0, =2Ere=
sponded =3D true, =2Ereply =3D { =2Epriority =3D 20, =2Eweight =3D 50 } },
=
+        { =2Eindex =3D 1, =2Eresponded =3D true, =2Ereply =3D { =2Epriorit=
y =3D 5, =2Eweight =3D 50 } },
+        { =2Eindex =3D 2, =2Eresponded =3D =
true, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 50 } },
+    };
+   =
 oob_rank_probe_results(r, 3, 10, rank_rng_zero, &gc);
+    assert_int_equa=
l(r[0]=2Eindex, 1); /* priority 5 */
+    assert_int_equal(r[1]=2Eindex, 2)=
; /* priority 10 */
+    assert_int_equal(r[2]=2Eindex, 0); /* priority 20 =
*/
+    gc_free(&gc);
+}
+
+/* Within a priority, only servers within the l=
atency margin of the fastest are
+ * candidates; a slower (out-of-band) ser=
ver ranks behind a faster one no matter
+ * how large its weight=2E */
+sta=
tic void
+test_rank_candidate_band(void **state)
+{
+    struct gc_arena gc=
 =3D gc_new();
+    struct oob_probe_result r[] =3D {
+        { =2Eindex =
=3D 0, =2Eresponded =3D true, =2Ertt_ms =3D 100, =2Ereply =3D { =2Epriority=
 =3D 10, =2Eweight =3D 1000 } },
+        { =2Eindex =3D 1, =2Eresponded =
=3D true, =2Ertt_ms =3D 20, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =
=3D 1 } },
+    };
+    /* margin 10ms: 20ms is fastest; 100ms is 80ms slow=
er -> out of band */
+    oob_rank_probe_results(r, 2, 10, rank_rng_zero, &=
gc);
+    assert_int_equal(r[0]=2Eindex, 1); /* fast, in-band, despite tiny=
 weight */
+    assert_int_equal(r[1]=2Eindex, 0); /* slow, out-of-band, de=
spite huge weight */
+    gc_free(&gc);
+}
+
+/* A server widens its own ba=
nd via the advertised max_latency_diff, joining the
+ * candidate set even =
when it is well behind the fastest; it then participates in
+ * the weighte=
d selection=2E */
+static void
+test_rank_advertised_margin(void **state)
+=
{
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
+    /* Client did not set a margin (-1), so e=
ach server's advertised value
+     * applies: the 100ms server advertises =
200 -> it is a candidate (the
+     * default 10 would have excluded it); w=
ith weight 1000 (slice [1,1001)) a
+     * draw of 500 selects it first=2E =
*/
+    rank_rng_value =3D 500;
+    oob_rank_probe_results(r, 2, -1, rank_=
rng_fixed, &gc);
+    assert_int_equal(r[0]=2Eindex, 1);
+    gc_free(&gc);=

+}
+
+/* Among candidates, weight drives RFC-2782 proportional selection: =
a draw is
+ * mapped to the server whose cumulative weight slice it falls i=
n=2E */
+static void
+test_rank_weighted_selection(void **state)
+{
+    st=
ruct gc_arena gc =3D gc_new();
+    /* equal priority and RTT -> both in ba=
nd; weights 30 and 70, sum 100:
+     * index 0 owns [0,30), index 1 owns [=
30,100)=2E */
+    const struct oob_probe_result base[] =3D {
+        { =
=2Eindex =3D 0, =2Eresponded =3D true, =2Ertt_ms =3D 20, =2Ereply =3D { =2E=
priority =3D 10, =2Eweight =3D 30 } },
+        { =2Eindex =3D 1, =2Erespon=
ded =3D true, =2Ertt_ms =3D 20, =2Ereply =3D { =2Epriority =3D 10, =2Eweigh=
t =3D 70 } },
+    };
+    struct oob_probe_result r[2];
+
+    memcpy(r, b=
ase, sizeof(base));
+    rank_rng_value =3D 10; /* falls in index 0's slice=
 */
+    oob_rank_probe_results(r, 2, 50, rank_rng_fixed, &gc);
+    assert=
_int_equal(r[0]=2Eindex, 0);
+
+    memcpy(r, base, sizeof(base));
+    ran=
k_rng_value =3D 50; /* falls in index 1's slice */
+    oob_rank_probe_resu=
lts(r, 2, 50, rank_rng_fixed, &gc);
+    assert_int_equal(r[0]=2Eindex, 1);=

+
+    gc_free(&gc);
+}
+
+/* Non-responders are placed last, keeping thei=
r original relative order=2E */
+static void
+test_rank_nonresponders_last(=
void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct oob_prob=
e_result r[] =3D {
+        { =2Eindex =3D 0, =2Eresponded =3D false },
+  =
      { =2Eindex =3D 1, =2Eresponded =3D true, =2Ertt_ms =3D 20, =2Ereply =
=3D { =2Epriority =3D 10, =2Eweight =3D 50 } },
+        { =2Eindex =3D 2, =
=2Eresponded =3D false },
+        { =2Eindex =3D 3, =2Eresponded =3D true,=
 =2Ertt_ms =3D 20, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 50 } },=

+    };
+    oob_rank_probe_results(r, 4, 10, rank_rng_zero, &gc);
+    as=
sert_int_equal(r[0]=2Eindex, 1); /* responder (rng_zero keeps order) */
+  =
  assert_int_equal(r[1]=2Eindex, 3); /* responder */
+    assert_int_equal(=
r[2]=2Eindex, 0); /* non-responder, original order kept */
+    assert_int_=
equal(r[3]=2Eindex, 2);
+    gc_free(&gc);
+}
+
 int
 main(void)
 {
@@ -542=
,6 +678,12 @@
         cmocka_unit_test(test_client_reply_read_skips_unknow=
n),
         cmocka_unit_test(test_client_reply_read_missing),
         cmo=
cka_unit_test(test_client_reply_read_wrong_msg_type),
+        cmocka_unit_=
test(test_rank_responder_before_nonresponder),
+        cmocka_unit_test(te=
st_rank_by_priority),
+        cmocka_unit_test(test_rank_candidate_band),
=
+        cmocka_unit_test(test_rank_advertised_margin),
+        cmocka_uni=
t_test(test_rank_weighted_selection),
+        cmocka_unit_test(test_rank_n=
onresponders_last),
     };
 
     return cmocka_run_group_tests_name("oob =
tests", tests, NULL, NULL);

-- 
To view, visit http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1746?usp=3Demail
To unsubscribe, or for help writing mail fi=
lters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mes=
sageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: I55da68cc341bcfc707fd34ca2f84ff9b6a55501f
Gerrit-Change-Number: =
1746
Gerrit-PatchSet: 11
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit=
-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel =
<openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne=
-openvpn@rfc2549=2Eorg>

--39S+ZNc7xoY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #11</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1746?usp=3Demail">View Change</a></p><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">oob: Add=
 probe-result ranking for server selection<br><br>Add oob_rank_probe_result=
s(), which orders remotes best-first from their probe<br>results, following=
 the DNS-SRV (RFC 2782) semantics of the probe_reply TLV:<br><br>  - remote=
s that answered rank before those that did not (non-responders keep<br>    =
their original relative order, last);<br>  - responders are grouped by prio=
rity, lowest value first (an absolute<br>    ordering, never overridden by =
latency or weight);<br>  - within a priority group the &quot;candidates&quo=
t; are the responders whose RTT is<br>    within a margin of the fastest; c=
andidates rank ahead of non-candidates;<br>  - candidates are ordered by RF=
C-2782 weighted-random selection by weight, so<br>    a server is chosen fi=
rst with probability proportional to its weight (load<br>    distribution);=
 non-candidates follow, ordered by RTT=2E<br><br>oob_effective_margin() dec=
ides that margin: the client&#39;s --server-probe value if<br>it set one, o=
therwise the server&#39;s advertised max_latency_diff, otherwise 10 ms=2E<b=
r><br>The RNG is injected as a function pointer so this module stays free o=
f the<br>crypto layer and the weighted ordering is deterministically unit-t=
estable (the<br>client will pass get_random; the tests pass stubs)=2E<br><b=
r>Exercised by unit tests; the client probe path calls it in a follow-up, w=
hich<br>also populates RTT -- until then every responder sits in the band a=
nd selection<br>is purely weighted-random=2E<br><br>Change-Id: I55da68cc341=
bcfc707fd34ca2f84ff9b6a55501f<br>Signed-off-by: Lev Stipakov &lt;lev@openvp=
n=2Enet&gt;<br>---<br>M src/openvpn/oob=2Ec<br>M src/openvpn/oob=2Eh<br>M t=
ests/unit_tests/openvpn/test_oob=2Ec<br>3 files changed, 347 insertions(+),=
 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/46/1746/11</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openv=
pn/oob=2Ec b/src/openvpn/oob=2Ec</span><br><span>index bc0e7a3=2E=2Ec8887a8=
 100644</span><br><span>--- a/src/openvpn/oob=2Ec</span><br><span>+++ b/src=
/openvpn/oob=2Ec</span><br><span>@@ -155,3 +155,159 @@</span><br><span>    =
 reply-&gt;peer_session_id =3D *peer_sid;</span><br><span>     return true;=
</span><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Base ordering: r=
esponders before non-responders, then by priority (lower</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * first), then by RTT (lower first), =
then by original index for determinism=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * This groups responders into priority runs pre-sort=
ed by RTT, which the</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * candidate-band step below relies on (run[0] is the fastest in its group=
)=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_result_comp=
are(const void *a, const void *b)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
const struct oob_probe_result *ra =3D a;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const struct oob_probe_result *rb =3D b;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (ra-&gt;responded &amp;&amp; rb-&gt;respo=
nded)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        /* both answered: lo=
west priority first, then lowest RTT */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (ra-&gt;reply=2Epriority !=3D rb-&gt;reply=
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
margin; /* the client&#39;s own setting is authoritative */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (r-&gt;reply=2Emax_latency_diff &gt; 0)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return (int)r-&gt;reply=2Ema=
x_latency_diff; /* else the server&#39;s advertised value */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    return OOB_DEFAULT_LATENCY_MARGIN_MS;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/* Reorder the index list idx[0=2E=2Em) into DNS-SRV (RFC 2782)=
 weighted-random</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
order by results[idx[k]]=2Ereply=2Eweight: each position is filled by a rem=
aining entry</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * chos=
en with probability proportional to its weight=2E When all remaining</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * weights are 0 the curre=
nt (RTT-sorted) order is kept=2E */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+oob_weighted_order(const struct oob_probe_result *results, int *idx=
, int m, int64_t (*rng)(void))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for=
 (int pos =3D 0; pos &lt; m; pos++)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        long sum =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        for (int k =3D pos; k &lt; m; k++)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            sum +=3D results[idx[k]]=2Ereply=2Eweight;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        int chosen =3D pos;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (sum &gt; 0)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            int64_t r =3D rng=
() % sum; /* uniform in [0, sum) */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            long acc =3D 0;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            for (int k =3D pos; k &lt; m; k++)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                acc +=3D resul=
ts[idx[k]]=2Ereply=2Eweight;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                if (acc &gt; r)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                    chosen =3D k;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    break;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        int t =3D idx[pos];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        idx[pos] =3D idx[chosen];</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        idx[chosen] =3D t;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/* Reorder one priority run (run[0=2E=2Em), already RTT-sorted) in plac=
e:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * candidates (RT=
T within the band of the fastest) first, ordered by weighted</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * random; then non-candidates in =
RTT order=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stat=
ic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_order_pr=
iority_run(struct oob_probe_result *run, int m, int client_margin, int64_t =
(*rng)(void),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                 struct gc_arena *gc)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (m &lt;=3D 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retur=
n;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    unsigned int best_rtt =3D run[0]=2Ertt_ms; /* =
run is RTT-sorted: [0] is fastest */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  int *cand =3D gc_malloc(sizeof(int) * m, false, gc);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    int *non =3D gc_malloc(sizeof(int) *=
 m, false, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
int nc =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    in=
t nn =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for =
(int k =3D 0; k &lt; m; k++)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if (run[k]=2Ertt_ms - best_rtt &lt; (unsigned int)oob_effective_margin(&=
amp;run[k], client_margin))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          cand[nc++] =3D k;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            non[nn+=
+] =3D k;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    oob_weighted_order(run, cand, nc, rng);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct oob_probe_result *tmp =3D gc_malloc(s=
izeof(*tmp) * m, false, gc);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    int t =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    for (int k =3D 0; k &lt; nc; k++)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        tmp[t++] =3D run[cand[k]];</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    for (int k =3D 0; k &lt; nn; k++)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        tmp[t++] =3D run[non[k]];</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    memcpy(run, tmp, sizeof(*run) * m);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+vo=
id</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_rank_probe_re=
sults(struct oob_probe_result *results, int n, int client_margin,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                       int64_=
t (*rng)(void), struct gc_arena *gc)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (n &lt;=3D 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* Base order: responders first, grouped by pri=
ority, RTT-sorted within=2E */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    qsort(results, (size_t)n, sizeof(*results), oob_probe_result=
_compare);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* Reorder each priority=
 run of responders by candidate-band + weight=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int i =3D 0;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    while (i &lt; n &amp;&amp; results[i]=2E=
responded)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        int j =3D i;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        while (j &lt; =
n &amp;&amp; results[j]=2Eresponded</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+               &amp;&amp; results[j]=2Ereply=2Epriority =3D=
=3D results[i]=2Ereply=2Epriority)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            j++;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
oob_order_priority_run(results + i, j - i, client_margin, rng, gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        i =3D j;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/src/openvpn/o=
ob=2Eh b/src/openvpn/oob=2Eh</span><br><span>index 80775a4=2E=2E4eec498 100=
644</span><br><span>--- a/src/openvpn/oob=2Eh</span><br><span>+++ b/src/ope=
nvpn/oob=2Eh</span><br><span>@@ -180,4 +180,53 @@</span><br><span> bool oob=
_build_probe_reply(struct buffer *probe_payload, uint64_t now, uint64_t win=
dow_secs,</span><br><span>                            const struct session_=
id *peer_sid, struct oob_probe_reply *reply);</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/* Candidate-band margin (ms) u=
sed when neither the client nor the server</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * specifies one=2E */</span><br><span style=3D"colo=
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
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *     within a margin =
of the fastest in the group (see oob_effective_margin())=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *     Candidates are ordered ahead=
 of non-candidates;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *   - candidates are ordered by DNS-SRV (RFC 2782) weighted-random selecti=
on by</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *     weight,=
 so a server is chosen first with probability proportional to its</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *     weight (load distribut=
ion)=2E Non-candidates follow, ordered by RTT=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param results        results to reorder in place</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param n              numbe=
r of results</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par=
am client_margin  client&#39;s candidate-band margin in ms, or &lt; 0 if th=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *                =
        client did not set one (see oob_effective_margin())</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * @param rng            returns a =
non-negative random value (e=2Eg=2E get_random);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *                       injected so this modu=
le stays free of the crypto layer</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *                       and the weighted ordering is determi=
nistically testable</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @param gc             arena for scratch allocation</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+void oob_rank_probe_results(struct oob_probe_result *resu=
lts, int n, int client_margin,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                            int64_t (*rng)(void), struct gc_aren=
a *gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * The candidate-band margin (ms) that applies =
to one probed remote=2E The client&#39;s</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * own setting is authoritative: when client_margin &g=
t;=3D 0 (the client set</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * --server-probe with a value) it is used for every remote=2E Otherwis=
e the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * server&#39;=
s advertised max_latency_diff is used when non-zero, falling back to</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * OOB_DEFAULT_LATENCY_MAR=
GIN_MS=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+int oob_effective_margin(c=
onst struct oob_probe_result *r, int client_margin);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* OOB_H */</spa=
n><br><span>diff --git a/tests/unit_tests/openvpn/test_oob=2Ec b/tests/unit=
_tests/openvpn/test_oob=2Ec</span><br><span>index 48bec2d=2E=2E1fc9258 1006=
44</span><br><span>--- a/tests/unit_tests/openvpn/test_oob=2Ec</span><br><s=
pan>+++ b/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>@@ -517,6 +=
517,142 @@</span><br><span>     gc_free(&amp;gc);</span><br><span> }</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Deter=
ministic RNG stubs for the weighted-selection ordering=2E rank_rng_zero</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * makes the weighted d=
raw always pick the first remaining candidate, preserving</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * order; rank_rng_fixed returns a va=
lue we set to land in a chosen weight slice=2E */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static int64_t</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+rank_rng_zero(void)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static int64_t rank_rng_value;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+static int64_t</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+rank_rng_fixed(void)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    return rank_rng_value;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
 Responders rank ahead of non-responders regardless of index order=2E */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+test_rank_responder_before_non=
responder(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_=
arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct oob_probe_result r[] =3D {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        { =2Eindex =3D 0, =2Eresponded =3D false },</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        { =2Eindex =3D=
 1, =2Eresponded =3D true, =2Ereply =3D { =2Epriority =3D 100, =2Eweight =
=3D 50 } },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    oob_rank_probe_re=
sults(r, 2, 10, rank_rng_zero, &amp;gc);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_int_equal(r[0]=2Eindex, 1);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(r[1]=2Eindex, =
0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp=
;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/* Among responders, the lowest priority value wins=
 (an absolute ordering)=2E */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+test_rank_by_priority(void **state)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct oob_probe_result r[] =3D {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        { =2Eindex =3D 0, =2Eresponded =
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
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+test_rank_advertised_margin(void **state)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_result =
r[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        { =
=2Eindex =3D 0, =2Eresponded =3D true, =2Ertt_ms =3D 20, =2Ereply =3D { =2E=
priority =3D 10, =2Eweight =3D 1 } },</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        { =2Eindex =3D 1,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+          =2Eresponded =3D true,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+          =2Ertt_ms =3D 100,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+          =2Ereply =3D { =2Ep=
riority =3D 10, =2Eweight =3D 1000, =2Emax_latency_diff =3D 200 } },</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* Client did not set a margin (-1)=
, so each server&#39;s advertised value</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     * applies: the 100ms server advertises 200 -&gt; i=
t is a candidate (the</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     * default 10 would have excluded it); with weight 1000 (slice [1,100=
1)) a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * draw of=
 500 selects it first=2E */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    rank_rng_value =3D 500;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    oob_rank_probe_results(r, 2, -1, rank_rng_fixed, &amp;g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_e=
qual(r[0]=2Eindex, 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/* Among candidates, weight driv=
es RFC-2782 proportional selection: a draw is</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * mapped to the server whose cumulative weight s=
lice it falls in=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_=
rank_weighted_selection(void **state)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* equal priority and RTT -&gt; both in band; weights =
30 and 70, sum 100:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     * index 0 owns [0,30), index 1 owns [30,100)=2E */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const struct oob_probe_result base[=
] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        { =
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
<span style=3D"color: hsl(120, 100%, 40%);">+/* Non-responders are placed l=
ast, keeping their original relative order=2E */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+test_rank_nonresponders_last(void **state)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_result r[] =
=3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        { =2Ei=
ndex =3D 0, =2Eresponded =3D false },</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        { =2Eindex =3D 1, =2Eresponded =3D true, =2Ertt_m=
s =3D 20, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 50 } },</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        { =2Eindex =3D 2, =
=2Eresponded =3D false },</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        { =2Eindex =3D 3, =2Eresponded =3D true, =2Ertt_ms =3D 20, =
=2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 50 } },</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    oob_rank_probe_results(r, 4, 10, rank_rng_zero,=
 &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_int_equal(r[0]=2Eindex, 1); /* responder (rng_zero keeps order) */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(r[1]=
=2Eindex, 3); /* responder */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_int_equal(r[2]=2Eindex, 0); /* non-responder, original=
 order kept */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_int_equal(r[3]=2Eindex, 2);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span> int</span><br><span> main(void)</span><br><span> {</span><b=
r><span>@@ -542,6 +678,12 @@</span><br><span>         cmocka_unit_test(test=
_client_reply_read_skips_unknown),</span><br><span>         cmocka_unit_tes=
t(test_client_reply_read_missing),</span><br><span>         cmocka_unit_tes=
t(test_client_reply_read_wrong_msg_type),</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        cmocka_unit_test(test_rank_responder_before_n=
onresponder),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  cmocka_unit_test(test_rank_by_priority),</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        cmocka_unit_test(test_rank_candidate_band),<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_=
test(test_rank_advertised_margin),</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        cmocka_unit_test(test_rank_weighted_selection),</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test=
(test_rank_nonresponders_last),</span><br><span>     };</span><br><span> </=
span><br><span>     return cmocka_run_group_tests_name(&quot;oob tests&quot=
;, tests, NULL, NULL);</span><br><span></span><br></pre><p>To view, visit <=
a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1746?usp=3Demail">chang=
e 1746</a>=2E To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1746?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I55da68cc341bcfc707fd34ca2f84ff9b6a55501f </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 1746 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 11 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &=
lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--39S+ZNc7xoY=--


--===============1869204081921184131==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1869204081921184131==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1869204081921184131==--

