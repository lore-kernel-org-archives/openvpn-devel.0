Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA9CC43458
	for <openvpn-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r8FVFiMm/bQeKXNCdPO3pjG14o1OxkYPthYhaiyooNA=; b=cdTo5KFaOx5zl9R7g/tT8fLN/1
	huqKTnViu8aMC/5CMGixNngWvupys4/6HJi7bDX7dfRIn5uBO42B80Qs0gHIJsBi3aRaTE5FuYGPV
	AGJRBvbjvUtKFrf7LpJuaEG2D9LpilXsAVJpbGcLfxwHHEImoHjo96QunlBmeZvQ52mY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1weAnZ-0007cf-SL;
	Mon, 29 Jun 2026 12:09:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1weAnD-0007c4-2m
 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 12:08:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=4vlpJ7fKnuRsHKe+mkJh0blbjnNo81xCt24dGoxP8mw=; b=h9XFORkA6AywicaOlJyRbC2qty
 S5ToUykkst/mikSEFYRNGUqB3NUQTvN8OVuyniW8MGG8AwEEW/j1CiuwtyfHR2C0+UnySB6JoKXLB
 MfMuxk/I/JTh6sly4rcT/DQvaxN6N6Ou3tc3SjdJ3Uf0UBGCSY3e8E5kpuvgZpYH4Wbg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=4vlpJ7fKnuRsHKe+mkJh0blbjnNo81xCt24dGoxP8mw=; b=f
 R9vCqKDen7k7fC/IhmneOuVyG2dgSDP/sNiOUQ9Qr5YfBisVmXuCI4sZoCubkv8n2cNX3Nz6q+mqm
 iVLT3ykTLPXkMHl7tFnpmnPTd96aKQ69fZ3S+IklIH/IwaHLE2S951J1JjzBzYK6H4mZCcs2c60BY
 p944ALMVQGnyQNVM=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1weAn5-0001Qu-Jg for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 12:08:48 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-47362928f65so866540f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 29 Jun 2026 05:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782734912; x=1783339712; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4vlpJ7fKnuRsHKe+mkJh0blbjnNo81xCt24dGoxP8mw=;
 b=cu374+/bjjekEvRj7c244HdaejXxVTXzM3+Tta+Pm40Zw5y7IHL9iprWTGUc6I56Nh
 T0FR3GlmI3Cro8SGdFidh2ojJSmDsc0xDNBFc3C5kFi07hfT0gA25iYPq5IDQ84fG3rr
 zagrvcuuY8PJEoELkcFtIjHldoYCvTQwy4gLjMCNCvPuOuFfiNiNnnCdW0kUIn1wlZvp
 v7NpaMOstu/4satd0ndCz0/eIf2EEM885vCghPIvAANK4UYuEhT/F9wKei9TFJe6DY5J
 8zk3vH74/iI3vqert8eceXxSr+UZwwHQLhwQip2FSgsoN/1jXCv6L7KYfnu7jIEF667m
 DJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734912; x=1783339712;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4vlpJ7fKnuRsHKe+mkJh0blbjnNo81xCt24dGoxP8mw=;
 b=pDQFS62ulr4ChhuwzWu/1yVlP3eb1K3aKqg5wLaOSivpPB9jGp82QjZz+f256QdFW7
 eMM6iu5N+0RPeEesQkfI5OqscjwtJ+hFywHcIl6uCye6hv49hL9Orm9bgPtcsMJqrf/9
 GnR1wpMCf75H7ItnuBiaqdJZop++gfjDPOj8njLYfr2OqHVYDIQz26jFPZWBOKbcNJCq
 /KsZVDuCDAJvi94QjC8BEeyduPS+DGJdFCZhcH5BtXdkHGRauXqnIE54uL9eBNBISRJE
 FyeQE4mAXcIPAVlJXaSiC0Ldt7ZPSC8n3q2AJUHyvD7rL22eyUOUFkMIlXAdJMgOweFK
 okJw==
X-Gm-Message-State: AOJu0Yyl4sOgtX07Cl8JpyttWV/fYJFuV1jrPxxh2qwPckYW2PiQOVxx
 iQQwrKXetTF0kObBM8YmWa1ti7OlLS5eEs6pfKnL8wh6zMq2LW47t+YczhZILvGtcXy8Xf7ACgp
 OD20dwRzL3HiLeI2MuRZtLpT8Nat7Ti4oFrdJ20bZE6MjHpEcoEKKdWdqk+BZhL4AaRiG
X-Gm-Gg: AfdE7cngKyEhf5PD6tRvTMZ/Vd0jNj+D2P/kksggwXiAsuroqySr/tZwnKIDF8r35VC
 +SqNoSwvmxrZoDMz97w1OpHx8pf+x/iQ6XnsW9RWENHcHpdI1ecH8SMNEJ5KIrhdw8gzR11bbLa
 hwXZqEA43VUyATHfXdqb68IeAC7vrTYAkxejjgTGBVYJqTtw0654yij1l/ftOPhpd+XJCXgXWui
 FFyG7dRt0Df+lHeBo+x8RtvHq10a1bGvS985uX2HBoIp0Kai11SYU3JN0U6+9G4EqbWoQ/m25Q9
 O8SiYFjRdRUZiHcJjMeKS9UKFZMpvZztaC/dlJSBtvQQS9R0IpzXws/PQA2cLaiL90haNQcqn8d
 JXADUZNFQAk5PuNv90XlvdIoq/8AsICT8nHPzbGeUtpxHszo83Bm8boLsozcfT1AN/ibC+mQme1
 WzO/YBIPoIq4sh/pvUFjtQcUEUfqB33EDWy6NQvaolmcpCNxLb5GNZpWWCDN8AMrMLPKvGD1frk
 8koYD391v4wFIQ+BTmA+eA5Whb0XSGMQwPsOhxRCrYRU6pwS4l7O5UEUWAOD3BkQernjiZSCj3H
 NAk=
X-Received: by 2002:a05:6000:2388:b0:43b:498f:dceb with SMTP id
 ffacd0b85a97d-474febce226mr325385f8f.9.1782734912211; 
 Mon, 29 Jun 2026 05:08:32 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4721c88bfcasm20402284f8f.10.2026.06.29.05.08.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:08:31 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 29 Jun 2026 12:08:26 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I55da68cc341bcfc707fd34ca2f84ff9b6a55501f
X-Gerrit-Change-Number: 1746
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1746?usp=email>
X-Gerrit-Commit: 52c7c6d63f22545538ec405c368ae9a7f58f34f6
In-Reply-To: <gerrit.1782719911000.I55da68cc341bcfc707fd34ca2f84ff9b6a55501f@gerrit.openvpn.net>
References: <gerrit.1782719911000.I55da68cc341bcfc707fd34ca2f84ff9b6a55501f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk1NWRhNjhjYzM0MWJjZmM3MDdmZDM0Y2EyZjg0ZmY5YjZhNTU1MDFmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d67c16f6546ba363f1193340f87bd413b2dcbe68-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1weAn5-0001Qu-Jg
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
Content-Type: multipart/mixed; boundary="===============8245848195149110862=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8245848195149110862==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="h8Yn1kvJpJo="; charset=UTF-8

--h8Yn1kvJpJo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1746?usp=3Demail

to look at the new patch set (#2)=2E

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
margin of the fastest (see oob_effective_margin()); candidates
    rank ahe=
ad of non-candidates;
  - candidates are ordered by RFC-2782 weighted-rando=
m selection by weight, so
    a server is chosen first with probability pro=
portional to its weight (load
    distribution); non-candidates follow, ord=
ered by RTT=2E

The RNG is injected as a function pointer so this module st=
ays free of the
crypto layer and the weighted ordering is deterministically=
 unit-testable
(production passes get_random; the tests pass stubs)=2E

RTT=
 is only populated once the client measures it (a later commit); until then=

every responder sits in the band and selection is purely weighted-random=
=2E

Change-Id: I55da68cc341bcfc707fd34ca2f84ff9b6a55501f
Signed-off-by: Le=
v Stipakov <lev@openvpn=2Enet>
---
M src/openvpn/oob=2Ec
M src/openvpn/oob=
=2Eh
M tests/unit_tests/openvpn/test_oob=2Ec
3 files changed, 343 insertion=
s(+), 0 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/46/1746/2

diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oo=
b=2Ec
index 9cc7c42=2E=2E3b8713a 100644
--- a/src/openvpn/oob=2Ec
+++ b/src=
/openvpn/oob=2Ec
@@ -241,3 +241,151 @@
     /* priority/weight/connect_life=
time/flags left at 0 for now */
     return true;
 }
+
+/* Base ordering: r=
esponders before non-responders, then by priority (lower
+ * first), then b=
y RTT (lower first), then by original index for determinism=2E
+ * This gro=
ups responders into priority runs pre-sorted by RTT, which the
+ * candidat=
e-band step below relies on (run[0] is the fastest in its group)=2E */
+sta=
tic int
+oob_probe_result_compare(const void *a, const void *b)
+{
+    con=
st struct oob_probe_result *ra =3D a;
+    const struct oob_probe_result *r=
b =3D b;
+
+    if (ra->responded !=3D rb->responded)
+    {
+        retur=
n ra->responded ? -1 : 1;
+    }
+    if (ra->responded)
+    {
+        if=
 (ra->priority !=3D rb->priority)
+        {
+            return ra->priori=
ty < rb->priority ? -1 : 1;
+        }
+        if (ra->rtt_ms !=3D rb->rtt=
_ms)
+        {
+            return ra->rtt_ms < rb->rtt_ms ? -1 : 1;
+    =
    }
+    }
+    return ra->index - rb->index;
+}
+
+int
+oob_effective_ma=
rgin(const struct oob_probe_result *r, int client_margin)
+{
+    if (clien=
t_margin >=3D 0)
+    {
+        return client_margin; /* the client's own =
setting is authoritative */
+    }
+    if (r->max_latency_diff > 0)
+    {=

+        return (int)r->max_latency_diff; /* else the server's advertised =
value */
+    }
+    return OOB_DEFAULT_LATENCY_MARGIN_MS;
+}
+
+/* Reorder=
 the index list @p idx[0=2E=2Em) into DNS-SRV (RFC 2782) weighted-random
+ =
* order by results[idx[k]]=2Eweight: each position is filled by a remaining=
 entry
+ * chosen with probability proportional to its weight=2E When all r=
emaining
+ * weights are 0 the current (RTT-sorted) order is kept=2E */
+st=
atic void
+oob_weighted_order(const struct oob_probe_result *results, int *=
idx, int m, int64_t (*rng)(void))
+{
+    for (int pos =3D 0; pos < m; pos+=
+)
+    {
+        long sum =3D 0;
+        for (int k =3D pos; k < m; k++)=

+        {
+            sum +=3D results[idx[k]]=2Eweight;
+        }
+   =
     int chosen =3D pos;
+        if (sum > 0)
+        {
+            int6=
4_t r =3D rng() % sum; /* uniform in [0, sum) */
+            long acc =3D =
0;
+            for (int k =3D pos; k < m; k++)
+            {
+           =
     acc +=3D results[idx[k]]=2Eweight;
+                if (acc > r)
+    =
            {
+                    chosen =3D k;
+                    break=
;
+                }
+            }
+        }
+        int t =3D idx[pos];=

+        idx[pos] =3D idx[chosen];
+        idx[chosen] =3D t;
+    }
+}
+=

+/* Reorder one priority run (@p run[0=2E=2Em), already RTT-sorted) in pla=
ce:
+ * candidates (RTT within the band of the fastest) first, ordered by w=
eighted
+ * random; then non-candidates in RTT order=2E */
+static void
+oo=
b_order_priority_run(struct oob_probe_result *run, int m, int client_margin=
, int64_t (*rng)(void),
+                       struct gc_arena *gc)
+{
+  =
  if (m <=3D 1)
+    {
+        return;
+    }
+
+    unsigned int best_rtt=
 =3D run[0]=2Ertt_ms; /* run is RTT-sorted: [0] is fastest */
+
+    int *c=
and =3D gc_malloc(sizeof(int) * m, false, gc);
+    int *non =3D gc_malloc(=
sizeof(int) * m, false, gc);
+    int nc =3D 0;
+    int nn =3D 0;
+    for=
 (int k =3D 0; k < m; k++)
+    {
+        if (run[k]=2Ertt_ms - best_rtt <=
 (unsigned int)oob_effective_margin(&run[k], client_margin))
+        {
+  =
          cand[nc++] =3D k;
+        }
+        else
+        {
+          =
  non[nn++] =3D k;
+        }
+    }
+
+    oob_weighted_order(run, cand, n=
c, rng);
+
+    struct oob_probe_result *tmp =3D gc_malloc(sizeof(*tmp) * m=
, false, gc);
+    int t =3D 0;
+    for (int k =3D 0; k < nc; k++)
+    {
=
+        tmp[t++] =3D run[cand[k]];
+    }
+    for (int k =3D 0; k < nn; k=
++)
+    {
+        tmp[t++] =3D run[non[k]];
+    }
+    memcpy(run, tmp, =
sizeof(*run) * m);
+}
+
+void
+oob_rank_probe_results(struct oob_probe_resu=
lt *results, int n, int client_margin,
+                       int64_t (*rn=
g)(void), struct gc_arena *gc)
+{
+    if (n <=3D 1)
+    {
+        return=
;
+    }
+
+    /* Base order: responders first, grouped by priority, RTT-s=
orted within=2E */
+    qsort(results, (size_t)n, sizeof(*results), oob_pro=
be_result_compare);
+
+    /* Reorder each priority run of responders by ca=
ndidate-band + weight=2E */
+    int i =3D 0;
+    while (i < n && results[=
i]=2Eresponded)
+    {
+        int j =3D i;
+        while (j < n && resul=
ts[j]=2Eresponded && results[j]=2Epriority =3D=3D results[i]=2Epriority)
+ =
       {
+            j++;
+        }
+        oob_order_priority_run(resul=
ts + i, j - i, client_margin, rng, gc);
+        i =3D j;
+    }
+}
diff --=
git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh
index 9040416=2E=2Eb48db9d =
100644
--- a/src/openvpn/oob=2Eh
+++ b/src/openvpn/oob=2Eh
@@ -215,4 +215,5=
5 @@
 bool oob_build_probe_reply(struct buffer *probe_payload, uint64_t now=
, uint64_t window_secs,
                            const struct session_id=
 *peer_sid, struct oob_probe_reply *reply);
 
+/* Candidate-band margin (ms=
) used when neither the client nor the server
+ * specifies one=2E */
+#def=
ine OOB_DEFAULT_LATENCY_MARGIN_MS 10
+
+/* Outcome of probing one remote, u=
sed to order remotes best-first=2E @index is
+ * the caller's identifier fo=
r the remote (e=2Eg=2E its position in the connection
+ * list); priority/w=
eight are only meaningful when @responded is true=2E */
+struct oob_probe_r=
esult
+{
+    int index;
+    bool responded;
+    uint16_t priority;
+    =
uint16_t weight;
+    uint16_t max_latency_diff; /* margin advertised by th=
is server (ms); 0 =3D use client default */
+    unsigned int rtt_ms;      =
 /* probe round-trip time in ms (responders only) */
+};
+
+/**
+ * Order @=
p results best-first, in place, per the server-probe selection policy:
+ * =
  - remotes that responded rank before those that did not (non-responders k=
eep
+ *     their original relative order, last);
+ *   - responders are gr=
ouped by priority, lowest priority value first (an
+ *     absolute orderin=
g, never overridden by latency or weight);
+ *   - within a priority group,=
 the "candidates" are the responders whose RTT is
+ *     within a margin o=
f the fastest in the group (see oob_effective_margin())=2E
+ *     Candidat=
es are ordered ahead of non-candidates;
+ *   - candidates are ordered by D=
NS-SRV (RFC 2782) weighted-random selection by
+ *     weight, so a server =
is chosen first with probability proportional to its
+ *     weight (load d=
istribution)=2E Non-candidates follow, ordered by RTT=2E
+ *
+ * @param res=
ults        results to reorder in place
+ * @param n              number of=
 results
+ * @param client_margin  client's candidate-band margin in ms, or=
 < 0 if the
+ *                        client did not set one (see oob_effe=
ctive_margin())
+ * @param rng            returns a non-negative random val=
ue (e=2Eg=2E get_random);
+ *                       injected so this module=
 stays free of the crypto layer
+ *                       and the weighted =
ordering is deterministically testable
+ * @param gc             arena for =
scratch allocation
+ */
+void oob_rank_probe_results(struct oob_probe_resul=
t *results, int n, int client_margin,
+                            int64_t =
(*rng)(void), struct gc_arena *gc);
+
+/**
+ * The candidate-band margin (m=
s) that applies to one probed remote=2E The client's
+ * own setting is aut=
horitative: when @p client_margin >=3D 0 (the client set
+ * --server-probe=
 with a value) it is used for every remote=2E Otherwise the
+ * server's ad=
vertised @c max_latency_diff is used when non-zero, falling back to
+ * OOB=
_DEFAULT_LATENCY_MARGIN_MS=2E
+ */
+int oob_effective_margin(const struct o=
ob_probe_result *r, int client_margin);
+
 #endif /* OOB_H */
diff --git a/=
tests/unit_tests/openvpn/test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=
=2Ec
index 1029399=2E=2Eef94701 100644
--- a/tests/unit_tests/openvpn/test_=
oob=2Ec
+++ b/tests/unit_tests/openvpn/test_oob=2Ec
@@ -429,6 +429,144 @@
 =
    gc_free(&gc);
 }
 
+/* Deterministic RNG stubs for the weighted-selecti=
on ordering=2E rank_rng_zero
+ * makes the weighted draw always pick the fi=
rst remaining candidate, preserving
+ * order; rank_rng_fixed returns a val=
ue we set to land in a chosen weight slice=2E */
+static int64_t
+rank_rng_=
zero(void)
+{
+    return 0;
+}
+
+static int64_t rank_rng_value;
+static i=
nt64_t
+rank_rng_fixed(void)
+{
+    return rank_rng_value;
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
ponded =3D true, =2Epriority =3D 100, =2Eweight =3D 50 },
+    };
+    oob_=
rank_probe_results(r, 2, 10, rank_rng_zero, &gc);
+    assert_int_equal(r[0=
]=2Eindex, 1);
+    assert_int_equal(r[1]=2Eindex, 0);
+    gc_free(&gc);
+=
}
+
+/* Among responders, the lowest priority value wins (an absolute order=
ing)=2E */
+static void
+test_rank_by_priority(void **state)
+{
+    struct=
 gc_arena gc =3D gc_new();
+    struct oob_probe_result r[] =3D {
+        =
{ =2Eindex =3D 0, =2Eresponded =3D true, =2Epriority =3D 20, =2Eweight =3D =
50 },
+        { =2Eindex =3D 1, =2Eresponded =3D true, =2Epriority =3D 5, =
=2Eweight =3D 50 },
+        { =2Eindex =3D 2, =2Eresponded =3D true, =2Epr=
iority =3D 10, =2Eweight =3D 50 },
+    };
+    oob_rank_probe_results(r, 3=
, 10, rank_rng_zero, &gc);
+    assert_int_equal(r[0]=2Eindex, 1); /* prior=
ity 5 */
+    assert_int_equal(r[1]=2Eindex, 2); /* priority 10 */
+    ass=
ert_int_equal(r[2]=2Eindex, 0); /* priority 20 */
+    gc_free(&gc);
+}
+
+=
/* Within a priority, only servers within the latency margin of the fastest=
 are
+ * candidates; a slower (out-of-band) server ranks behind a faster on=
e no matter
+ * how large its weight=2E */
+static void
+test_rank_candidat=
e_band(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct o=
ob_probe_result r[] =3D {
+        { =2Eindex =3D 0, =2Eresponded =3D true,=
 =2Epriority =3D 10, =2Eweight =3D 1000, =2Ertt_ms =3D 100 },
+        { =
=2Eindex =3D 1, =2Eresponded =3D true, =2Epriority =3D 10, =2Eweight =3D 1,=
 =2Ertt_ms =3D 20 },
+    };
+    /* margin 10ms: 20ms is fastest; 100ms is=
 80ms slower -> out of band */
+    oob_rank_probe_results(r, 2, 10, rank_r=
ng_zero, &gc);
+    assert_int_equal(r[0]=2Eindex, 1); /* fast, in-band, de=
spite tiny weight */
+    assert_int_equal(r[1]=2Eindex, 0); /* slow, out-o=
f-band, despite huge weight */
+    gc_free(&gc);
+}
+
+/* A server widens =
its own band via the advertised max_latency_diff, joining the
+ * candidate=
 set even when it is well behind the fastest; it then participates in
+ * t=
he weighted selection=2E */
+static void
+test_rank_advertised_margin(void =
**state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct oob_probe_res=
ult r[] =3D {
+        { =2Eindex =3D 0, =2Eresponded =3D true, =2Epriority=
 =3D 10, =2Eweight =3D 1, =2Ertt_ms =3D 20 },
+        { =2Eindex =3D 1,
+ =
         =2Eresponded =3D true,
+          =2Epriority =3D 10,
+          =
=2Eweight =3D 1000,
+          =2Ertt_ms =3D 100,
+          =2Emax_latency=
_diff =3D 200 },
+    };
+    /* Client did not set a margin (-1), so each =
server's advertised value
+     * applies: the 100ms server advertises 200 =
-> it is a candidate (the
+     * default 10 would have excluded it); with =
weight 1000 (slice [1,1001)) a
+     * draw of 500 selects it first=2E */
+=
    rank_rng_value =3D 500;
+    oob_rank_probe_results(r, 2, -1, rank_rng_=
fixed, &gc);
+    assert_int_equal(r[0]=2Eindex, 1);
+    gc_free(&gc);
+}
=
+
+/* Among candidates, weight drives RFC-2782 proportional selection: a dr=
aw is
+ * mapped to the server whose cumulative weight slice it falls in=2E=
 */
+static void
+test_rank_weighted_selection(void **state)
+{
+    struct=
 gc_arena gc =3D gc_new();
+    /* equal priority and RTT -> both in band; =
weights 30 and 70, sum 100:
+     * index 0 owns [0,30), index 1 owns [30,1=
00)=2E */
+    const struct oob_probe_result base[] =3D {
+        { =2Eind=
ex =3D 0, =2Eresponded =3D true, =2Epriority =3D 10, =2Eweight =3D 30, =2Er=
tt_ms =3D 20 },
+        { =2Eindex =3D 1, =2Eresponded =3D true, =2Epriori=
ty =3D 10, =2Eweight =3D 70, =2Ertt_ms =3D 20 },
+    };
+    struct oob_pr=
obe_result r[2];
+
+    memcpy(r, base, sizeof(base));
+    rank_rng_value =
=3D 10; /* falls in index 0's slice */
+    oob_rank_probe_results(r, 2, 50=
, rank_rng_fixed, &gc);
+    assert_int_equal(r[0]=2Eindex, 0);
+
+    memc=
py(r, base, sizeof(base));
+    rank_rng_value =3D 50; /* falls in index 1'=
s slice */
+    oob_rank_probe_results(r, 2, 50, rank_rng_fixed, &gc);
+   =
 assert_int_equal(r[0]=2Eindex, 1);
+
+    gc_free(&gc);
+}
+
+/* Non-respo=
nders are placed last, keeping their original relative order=2E */
+static =
void
+test_rank_nonresponders_last(void **state)
+{
+    struct gc_arena gc=
 =3D gc_new();
+    struct oob_probe_result r[] =3D {
+        { =2Eindex =
=3D 0, =2Eresponded =3D false },
+        { =2Eindex =3D 1, =2Eresponded =
=3D true, =2Epriority =3D 10, =2Eweight =3D 50, =2Ertt_ms =3D 20 },
+      =
  { =2Eindex =3D 2, =2Eresponded =3D false },
+        { =2Eindex =3D 3, =
=2Eresponded =3D true, =2Epriority =3D 10, =2Eweight =3D 50, =2Ertt_ms =3D =
20 },
+    };
+    oob_rank_probe_results(r, 4, 10, rank_rng_zero, &gc);
+ =
   assert_int_equal(r[0]=2Eindex, 1); /* responder (rng_zero keeps order) *=
/
+    assert_int_equal(r[1]=2Eindex, 3); /* responder */
+    assert_int_e=
qual(r[2]=2Eindex, 0); /* non-responder, original order kept */
+    assert=
_int_equal(r[3]=2Eindex, 2);
+    gc_free(&gc);
+}
+
 int
 main(void)
 {
@@=
 -452,6 +590,12 @@
         cmocka_unit_test(test_client_reply_read_skips_u=
nknown),
         cmocka_unit_test(test_client_reply_read_missing),
       =
  cmocka_unit_test(test_client_reply_read_wrong_msg_type),
+        cmocka_=
unit_test(test_rank_responder_before_nonresponder),
+        cmocka_unit_te=
st(test_rank_by_priority),
+        cmocka_unit_test(test_rank_candidate_ba=
nd),
+        cmocka_unit_test(test_rank_advertised_margin),
+        cmock=
a_unit_test(test_rank_weighted_selection),
+        cmocka_unit_test(test_r=
ank_nonresponders_last),
     };
 
     return cmocka_run_group_tests_name(=
"oob tests", tests, NULL, NULL);

-- 
To view, visit http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1746?usp=3Demail
To unsubscribe, or for help writing ma=
il filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: I55da68cc341bcfc707fd34ca2f84ff9b6a55501f
Gerrit-Change-Num=
ber: 1746
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Ge=
rrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <=
arne-openvpn@rfc2549=2Eorg>

--h8Yn1kvJpJo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #2</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1746?usp=3Demail">View Change</a></p><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">oob: Add =
probe-result ranking for server selection<br><br>Add oob_rank_probe_results=
(), which orders remotes best-first from their probe<br>results, following =
the DNS-SRV (RFC 2782) semantics of the probe_reply TLV:<br><br>  - remotes=
 that answered rank before those that did not (non-responders keep<br>    t=
heir original relative order, last);<br>  - responders are grouped by prior=
ity, lowest value first (an absolute<br>    ordering, never overridden by l=
atency or weight);<br>  - within a priority group the &quot;candidates&quot=
; are the responders whose RTT is<br>    within a margin of the fastest (se=
e oob_effective_margin()); candidates<br>    rank ahead of non-candidates;<=
br>  - candidates are ordered by RFC-2782 weighted-random selection by weig=
ht, so<br>    a server is chosen first with probability proportional to its=
 weight (load<br>    distribution); non-candidates follow, ordered by RTT=
=2E<br><br>The RNG is injected as a function pointer so this module stays f=
ree of the<br>crypto layer and the weighted ordering is deterministically u=
nit-testable<br>(production passes get_random; the tests pass stubs)=2E<br>=
<br>RTT is only populated once the client measures it (a later commit); unt=
il then<br>every responder sits in the band and selection is purely weighte=
d-random=2E<br><br>Change-Id: I55da68cc341bcfc707fd34ca2f84ff9b6a55501f<br>=
Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M src/openv=
pn/oob=2Ec<br>M src/openvpn/oob=2Eh<br>M tests/unit_tests/openvpn/test_oob=
=2Ec<br>3 files changed, 343 insertions(+), 0 deletions(-)<br><br></pre><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes=
/46/1746/2</pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec</=
span><br><span>index 9cc7c42=2E=2E3b8713a 100644</span><br><span>--- a/src/=
openvpn/oob=2Ec</span><br><span>+++ b/src/openvpn/oob=2Ec</span><br><span>@=
@ -241,3 +241,151 @@</span><br><span>     /* priority/weight/connect_lifeti=
me/flags left at 0 for now */</span><br><span>     return true;</span><br><=
span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/* Base ordering: responders be=
fore non-responders, then by priority (lower</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * first), then by RTT (lower first), then by orig=
inal index for determinism=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * This groups responders into priority runs pre-sorted by RTT, w=
hich the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * candidat=
e-band step below relies on (run[0] is the fastest in its group)=2E */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+oob_probe_result_compare(const vo=
id *a, const void *b)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct=
 oob_probe_result *ra =3D a;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    const struct oob_probe_result *rb =3D b;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (ra-&gt;responded !=3D rb-&gt;responded)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        return ra-&gt;responded ? -1 : 1;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (ra-&gt;responded)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if (ra-&gt;priority !=3D rb-&gt;priori=
ty)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            return ra-&gt;=
priority &lt; rb-&gt;priority ? -1 : 1;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        if (ra-&gt;rtt_ms !=3D rb-&gt;rtt_ms)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            return ra-&gt;rtt_ms &lt; rb-&gt;rtt_=
ms ? -1 : 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    return ra-&gt;index - rb-&g=
t;index;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+oob_effective_margin(const struct oob_probe_result *r, int clien=
t_margin)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (client_margin &gt;=
=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        return client_margi=
n; /* the client&#39;s own setting is authoritative */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (r-&gt;max_latency_diff &gt; 0)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        return (int)r-&gt;max_latency_diff; /* el=
se the server&#39;s advertised value */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return OOB_DEFAULT_LATENCY_MARGIN_MS;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Reorde=
r the index list @p idx[0=2E=2Em) into DNS-SRV (RFC 2782) weighted-random</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * order by results[i=
dx[k]]=2Eweight: each position is filled by a remaining entry</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * chosen with probability propor=
tional to its weight=2E When all remaining</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * weights are 0 the current (RTT-sorted) order is k=
ept=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static voi=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_weighted_order=
(const struct oob_probe_result *results, int *idx, int m, int64_t (*rng)(vo=
id))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    for (int pos =3D 0; pos &lt; =
m; pos++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        long sum =3D 0;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (int k =
=3D pos; k &lt; m; k++)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      sum +=3D results[idx[k]]=2Eweight;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        int chosen =3D pos;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        if (sum &gt; 0)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            int64_t r =3D rng() % sum; /* uniform in [0, sum) =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            long =
acc =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   for (int k =3D pos; k &lt; m; k++)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                acc +=3D results[idx[k]]=2Eweight;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                if (acc &gt; r)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                    ch=
osen =3D k;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
            break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int t =3D i=
dx[pos];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        idx=
[pos] =3D idx[chosen];</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        idx[chosen] =3D t;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* Reorder one priority run (@p run[0=2E=
=2Em), already RTT-sorted) in place:</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * candidates (RTT within the band of the fastest) first, =
ordered by weighted</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * random; then non-candidates in RTT order=2E */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+oob_order_priority_run(struct oob_probe_result *run, =
int m, int client_margin, int64_t (*rng)(void),</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                       struct gc_arena *gc)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (m &lt;=3D 1)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int=
 best_rtt =3D run[0]=2Ertt_ms; /* run is RTT-sorted: [0] is fastest */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int *cand =3D gc_malloc(sizeof(int) *=
 m, false, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
int *non =3D gc_malloc(sizeof(int) * m, false, gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int nc =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int nn =3D 0;</span><br><span style=
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
n>index 9040416=2E=2Eb48db9d 100644</span><br><span>--- a/src/openvpn/oob=
=2Eh</span><br><span>+++ b/src/openvpn/oob=2Eh</span><br><span>@@ -215,4 +2=
15,55 @@</span><br><span> bool oob_build_probe_reply(struct buffer *probe_p=
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
 hsl(120, 100%, 40%);">+ * Order @p results best-first, in place, per the s=
erver-probe selection policy:</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *   - remotes that responded rank before those that did not (non=
-responders keep</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
    their original relative order, last);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *   - responders are grouped by priority, lowest pri=
ority value first (an</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *     absolute ordering, never overridden by latency or weight);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *   - within a priority gr=
oup, the &quot;candidates&quot; are the responders whose RTT is</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *     within a margin of the f=
astest in the group (see oob_effective_margin())=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *     Candidates are ordered ahead of no=
n-candidates;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   -=
 candidates are ordered by DNS-SRV (RFC 2782) weighted-random selection by<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *     weight, so a =
server is chosen first with probability proportional to its</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *     weight (load distribution)=
=2E Non-candidates follow, ordered by RTT=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @param results        results to reorder in place</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @param n              number of=
 results</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param c=
lient_margin  client&#39;s candidate-band margin in ms, or &lt; 0 if the</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *                    =
    client did not set one (see oob_effective_margin())</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @param rng            returns a non-=
negative random value (e=2Eg=2E get_random);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *                       injected so this module s=
tays free of the crypto layer</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *                       and the weighted ordering is determinist=
ically testable</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
param gc             arena for scratch allocation</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+void oob_rank_probe_results(struct oob_probe_result *results,=
 int n, int client_margin,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                            int64_t (*rng)(void), struct gc_arena *g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * The candidate-band margin (ms) that applies to o=
ne probed remote=2E The client&#39;s</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * own setting is authoritative: when @p client_margin &gt=
;=3D 0 (the client set</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * --server-probe with a value) it is used for every remote=2E Otherwise=
 the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * server&#39;s=
 advertised @c max_latency_diff is used when non-zero, falling back to</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * OOB_DEFAULT_LATENCY_M=
ARGIN_MS=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+int oob_effective_margin=
(const struct oob_probe_result *r, int client_margin);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* OOB_H */</sp=
an><br><span>diff --git a/tests/unit_tests/openvpn/test_oob=2Ec b/tests/uni=
t_tests/openvpn/test_oob=2Ec</span><br><span>index 1029399=2E=2Eef94701 100=
644</span><br><span>--- a/tests/unit_tests/openvpn/test_oob=2Ec</span><br><=
span>+++ b/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>@@ -429,6 =
+429,144 @@</span><br><span>     gc_free(&amp;gc);</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Dete=
rministic RNG stubs for the weighted-selection ordering=2E rank_rng_zero</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * makes the weighted =
draw always pick the first remaining candidate, preserving</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * order; rank_rng_fixed returns a v=
alue we set to land in a chosen weight slice=2E */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+static int64_t</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+rank_rng_zero(void)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static int64_t rank_rng_value;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+static int64_t</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+rank_rng_fixed(void)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return rank_rng_value;</span><br><span sty=
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
=3D 1, =2Eresponded =3D true, =2Epriority =3D 100, =2Eweight =3D 50 },</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    oob_rank_probe_results(r, 2, 10, =
rank_rng_zero, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_int_equal(r[0]=2Eindex, 1);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_int_equal(r[1]=2Eindex, 0);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/* Among responders, the lowest priority value wins (an absolute or=
dering)=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static=
 void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_rank_by_p=
riority(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_ar=
ena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct oob_probe_result r[] =3D {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        { =2Eindex =3D 0, =2Eresponded =3D true, =2Eprio=
rity =3D 20, =2Eweight =3D 50 },</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        { =2Eindex =3D 1, =2Eresponded =3D true, =2Epriority =
=3D 5, =2Eweight =3D 50 },</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        { =2Eindex =3D 2, =2Eresponded =3D true, =2Epriority =3D 10,=
 =2Eweight =3D 50 },</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    oob_rank=
_probe_results(r, 3, 10, rank_rng_zero, &amp;gc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_int_equal(r[0]=2Eindex, 1); /* pri=
ority 5 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_int_equal(r[1]=2Eindex, 2); /* priority 10 */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_int_equal(r[2]=2Eindex, 0); /* prior=
ity 20 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_fre=
e(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/* Within a priority, only servers within the=
 latency margin of the fastest are</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * candidates; a slower (out-of-band) server ranks behind a =
faster one no matter</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * how large its weight=2E */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+test_rank_candidate_band(void **state)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct oob_probe_result r[] =3D {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        { =2Eindex =3D 0, =2Erespond=
ed =3D true, =2Epriority =3D 10, =2Eweight =3D 1000, =2Ertt_ms =3D 100 },</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        { =2Eindex =
=3D 1, =2Eresponded =3D true, =2Epriority =3D 10, =2Eweight =3D 1, =2Ertt_m=
s =3D 20 },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* margin 10ms: 2=
0ms is fastest; 100ms is 80ms slower -&gt; out of band */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    oob_rank_probe_results(r, 2, 10, =
rank_rng_zero, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_int_equal(r[0]=2Eindex, 1); /* fast, in-band, despite tiny =
weight */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_int_equal(r[1]=2Eindex, 0); /* slow, out-of-band, despite huge weight */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/* A server widens its own band via the advertised max_l=
atency_diff, joining the</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * candidate set even when it is well behind the fastest; it then part=
icipates in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the w=
eighted selection=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test=
_rank_advertised_margin(void **state)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct oob_probe_result r[] =3D {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        { =2Eindex =3D 0, =2Eresponded =
=3D true, =2Epriority =3D 10, =2Eweight =3D 1, =2Ertt_ms =3D 20 },</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        { =2Eindex =3D 1,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+          =2Eresponded=
 =3D true,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
 =2Epriority =3D 10,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+          =2Eweight =3D 1000,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+          =2Ertt_ms =3D 100,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+          =2Emax_latency_diff =3D 200 },</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* Client did not set a margin (-1), so eac=
h server&#39;s advertised value</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+     * applies: the 100ms server advertises 200 -&gt; it is a c=
andidate (the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *=
 default 10 would have excluded it); with weight 1000 (slice [1,1001)) a</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * draw of 500 sel=
ects it first=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    rank_rng_value =3D 500;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    oob_rank_probe_results(r, 2, -1, rank_rng_fixed, &amp;gc);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(r[0=
]=2Eindex, 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    g=
c_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/* Among candidates, weight drives RFC-2=
782 proportional selection: a draw is</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * mapped to the server whose cumulative weight slice it =
falls in=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stati=
c void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_rank_wei=
ghted_selection(void **state)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* equal priority and RTT -&gt; both in band; weights 30 and 7=
0, sum 100:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * i=
ndex 0 owns [0,30), index 1 owns [30,100)=2E */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    const struct oob_probe_result base[] =3D {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        { =2Eindex =
=3D 0, =2Eresponded =3D true, =2Epriority =3D 10, =2Eweight =3D 30, =2Ertt_=
ms =3D 20 },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 { =2Eindex =3D 1, =2Eresponded =3D true, =2Epriority =3D 10, =2Eweight =3D=
 70, =2Ertt_ms =3D 20 },</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct oob_probe_result r[2];</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(r,=
 base, sizeof(base));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    rank_rng_value =3D 10; /* falls in index 0&#39;s slice */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    oob_rank_probe_results(r, 2=
, 50, rank_rng_fixed, &amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_int_equal(r[0]=2Eindex, 0);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    memcpy(r, base, sizeof(base));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    rank_rng_value =3D 50; /* falls in index 1&#=
39;s slice */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    oo=
b_rank_probe_results(r, 2, 50, rank_rng_fixed, &amp;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(r[0]=2Eindex, 1);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/* Non-responders are placed last, keeping their original relative order=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_rank_nonresponde=
rs_last(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_ar=
ena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct oob_probe_result r[] =3D {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        { =2Eindex =3D 0, =2Eresponded =3D false },</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        { =2Eindex =3D 1=
, =2Eresponded =3D true, =2Epriority =3D 10, =2Eweight =3D 50, =2Ertt_ms =
=3D 20 },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        { =
=2Eindex =3D 2, =2Eresponded =3D false },</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        { =2Eindex =3D 3, =2Eresponded =3D true, =2Ep=
riority =3D 10, =2Eweight =3D 50, =2Ertt_ms =3D 20 },</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    oob_rank_probe_results(r, 4, 10, rank_rng_zero, &a=
mp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_i=
nt_equal(r[0]=2Eindex, 1); /* responder (rng_zero keeps order) */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(r[1]=2Ei=
ndex, 3); /* responder */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_int_equal(r[2]=2Eindex, 0); /* non-responder, original ord=
er kept */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_int_equal(r[3]=2Eindex, 2);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span> int</span><br><span> main(void)</span><br><span> {</span><br><s=
pan>@@ -452,6 +590,12 @@</span><br><span>         cmocka_unit_test(test_cli=
ent_reply_read_skips_unknown),</span><br><span>         cmocka_unit_test(te=
st_client_reply_read_missing),</span><br><span>         cmocka_unit_test(te=
st_client_reply_read_wrong_msg_type),</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        cmocka_unit_test(test_rank_responder_before_nonre=
sponder),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cm=
ocka_unit_test(test_rank_by_priority),</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        cmocka_unit_test(test_rank_candidate_band),</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test=
(test_rank_advertised_margin),</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        cmocka_unit_test(test_rank_weighted_selection),</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(tes=
t_rank_nonresponders_last),</span><br><span>     };</span><br><span> </span=
><br><span>     return cmocka_run_group_tests_name(&quot;oob tests&quot;, t=
ests, NULL, NULL);</span><br><span></span><br></pre><p>To view, visit <a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1746?usp=3Demail">change 17=
46</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1746?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I55da68cc341bcfc707fd34ca2f84ff9b6a55501f </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1746 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;=
lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2E=
net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt=
;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--h8Yn1kvJpJo=--


--===============8245848195149110862==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8245848195149110862==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8245848195149110862==--

