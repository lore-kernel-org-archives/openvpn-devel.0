Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF48C61DCB
	for <openvpn-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kdOMMsOodW3Xczcox3lWZ5EbKHi4ypGHOGXBaSZVrDs=; b=EWerYijYiB0n178MC7pTlEPS9T
	QR58RVLURMzyDsDwKtwqW6cJ/IQUtk0oShja6+yjZIyevNGLy7ntNvcyEIB6gY+MjRliCldWF/DV8
	i62phlaOIE44vuhMooVSKWNPuMiMGkivIBHGgdD/wXuLCmAxxctq4opD0TRy8XXDSujQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzw3U-0002UT-Sl;
	Fri, 28 Aug 2026 12:51:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzw3S-0002UJ-Ep
 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 12:51:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=CqfcBGacum0ti1S/K6kGxeaA4Zrzbqb0qrf9xdUDjhM=; b=CTQK6sP9pAVc/8L6NBIvGmeZkg
 iaoC4tM4rl0a8L/l16/jfqv10obNrhF+sFiUIG5uK2Zk1Vhoqt2A2UgxUFWYKgniI0XKFp6hel9Dt
 wPG3ErnOq/s6oYHFdrwHbMStHhp13WFqID2Ho36ws70y+qrRtDDF5LlV5IvWjtj+Fvm4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=CqfcBGacum0ti1S/K6kGxeaA4Zrzbqb0qrf9xdUDjhM=; b=V
 idkFpb/5c6F3WuraacpwtEZfrubp+hPxKdmVxxMRhZnO593MLedg4rG2OFB6JzVrJ+gi0Ag1KGFAU
 QdxvX7mpROcORNtjGC2NUYtCxpMLvTGVRqxc3cvLACiQ32yCd0iaQMRh12VyeOnB367PGSFF/lMna
 3rO+oXyDzw7hl+h0=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzw3E-0003Fh-4j for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 12:51:34 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-499ae1c6471so6761205e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 28 Aug 2026 05:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787921474; x=1788526274; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CqfcBGacum0ti1S/K6kGxeaA4Zrzbqb0qrf9xdUDjhM=;
 b=LTNe2aLa5wCCarBDx/SqcWUoQIG8cggQfMoucX9D5mfuR80s2eTFceC846NbGij+lu
 l+n8hEAKOX6zyR+EXFOO3foQ2FotmnThgpabUc9FmJl+t/CbprhkhLImpOOV7Vk3noIE
 E+xoTlHm2skBhUiBT19d3oBsz0qy8au88WSFEXfdnn6X8Ycr/6vKQiNV5Z5o/Rm8ukNL
 1ao/6M7YU0z5+pC50LttRq8A++sXQoWyelVskU9MLaCh3SqZFZEMIaXsZaceyy2J7Nj4
 7ip2qDBzFOqWI70c3/sm+wqwwkgjgANpU6cGOy55zlv7bAe3/0AKeF8Kn0eQKWs4jHlZ
 OTnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787921474; x=1788526274;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CqfcBGacum0ti1S/K6kGxeaA4Zrzbqb0qrf9xdUDjhM=;
 b=VD2VD1dt9k1XjKHHK2aklD27xbcbhRUzItmTzewM50TUSpLP8wmggdSLch1rOtqPBB
 KbxAeyiPzoacsWBvSCCn73mXu0+dJI8eRPRNPkMdoZ4p1iDLlHujf6/bLNLzJsUcdxtA
 uX9q+oMlUvSwzr+L1F9eOdVewFYv4ev/PhPINbeXEY5nkG1lanYkWUcKZBm11Pmn3FT5
 CpFlR8HvzdbQWlgOxkhURIk6IWRhIvozATPIKhQ1vfc1wUBxnpgx+CZuVqQ59+DFY3om
 /SpIrUle431Sibp8t9U2GUm8xCvthjWOi8CBVCHa100dwaGvOSq6exDmBLivCAiDVp4o
 66aA==
X-Gm-Message-State: AFuF++lTsZ56teVvrhGak7M8FrGeS/X4PVyaND6pQ2qWoqP2mwRm7a3w
 TuuuPbhop+D/+LEkEE9454aW/uDRgVlolABIf90nGZUYy3yeUIHCOkC3TWNU+NOKdRMCEO5neoz
 ykIqZCjTwfI/7i//9IYoXChW0vZnAWfqDmZhKWgO9pwJmyhdzDYMnsTvvlVsrNfLS86zPs2Tqbv
 qxOQPlMA==
X-Gm-Gg: AR+sD11SL1LaGVXrm/HqWOjOPtHH8Xx1bTWTcIjHKeFbubTuWDcgd/Fqe9vBiFuXCG4
 OsDO2fjFifmCSfjdkmgguNy6AJ76okHwJhq1Cp6AVcYNOPzc9RPqhuav4gtvAwdisk39IXP1h2J
 pV5vs8Yn5QOzu8sLLhwIWAcnsHa5WOgssAAb377G0QEa91vjxixEM5yex5aizESsMAGyf9gr8Pr
 XDTuZCDKZgbKzGgr5dtQyNJhanWo2VPBgKzt9rVPvu6kmEQs/1Yb/wrIqdtD+sIB46Poy923ZB/
 vW4xDpmPaqgoCUJfD7BRLhk2bXgO2yqFWdJUdyRWzvnE+nVRc/Jf2bxM6qKcjOQy54lK/972Nnr
 cDvgZGTm5FmSKPXze0tLkDbhk/turJIYdjYbJCCGbxr8wBzGNiDdhgJvWfm6sn8afd5i8ohm+8k
 u6pcCCGuZiPXXHtmY2Bfi2HPH8m0rqrABPRA9Xz65NR1DhINF8KDqMRt2mM7zq4eTBfNS6tk4BP
 St5Skaw0QW754iDv1YKSFD1rzjsTxmrapvue8eWPG1uYLeQEU7gs5NrZGensUpyy4haPj6ihiA7
 /154yFVVZakocP9/bd0XUTpJg/Rgvblpz77cB1lI7/zTJ7Fvdzw=
X-Received: by 2002:a05:600c:8587:b0:499:dbae:43d3 with SMTP id
 5b1f17b1804b1-49b91c489bbmr94336475e9.9.1787921473303; 
 Fri, 28 Aug 2026 05:51:13 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b494228bfsm127995775e9.2.2026.08.28.05.51.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 05:51:12 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 28 Aug 2026 12:51:00 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 13
X-Gerrit-Change-Id: I55da68cc341bcfc707fd34ca2f84ff9b6a55501f
X-Gerrit-Change-Number: 1746
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1746?usp=email>
X-Gerrit-Commit: 62443009c1616a4d86f76f5c08264ed79b9926ee
In-Reply-To: <gerrit.1782719911000.I55da68cc341bcfc707fd34ca2f84ff9b6a55501f@gerrit.openvpn.net>
References: <gerrit.1782719911000.I55da68cc341bcfc707fd34ca2f84ff9b6a55501f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk1NWRhNjhjYzM0MWJjZmM3MDdmZDM0Y2EyZjg0ZmY5YjZhNTU1MDFmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a5d0fd19f55587a9efe1ec3a0794447e7f293049-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzw3E-0003Fh-4j
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
Content-Type: multipart/mixed; boundary="===============7698119465299758167=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7698119465299758167==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mSlfVrJAgyE="; charset=UTF-8

--mSlfVrJAgyE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1746?usp=3Demail

to look at the new patch set (#13)=2E
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
    no more t=
han a margin larger than the fastest, so the fastest is always
    one; can=
didates rank ahead of non-candidates;
  - candidates are ordered by RFC-278=
2 weighted-random selection by weight, so
    a server is chosen first with=
 probability proportional to its weight (load
    distribution); non-candid=
ates follow, ordered by RTT=2E

oob_effective_margin() decides that margin:=
 the client's --server-probe value if
it set one, otherwise the server's ad=
vertised max_latency_diff, where 0 admits
only the fastest responder and wh=
atever ties with it=2E

The RNG is injected as a function pointer so this m=
odule stays free of the
crypto layer and the weighted ordering is determini=
stically unit-testable (the
client will pass get_random; the tests pass stu=
bs)=2E

Exercised by unit tests; the client probe path calls it in a follow=
-up, which
also populates RTT -- until then every responder sits in the ban=
d and selection
is purely weighted-random=2E

Change-Id: I55da68cc341bcfc70=
7fd34ca2f84ff9b6a55501f
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---=

M src/openvpn/oob=2Ec
M src/openvpn/oob=2Eh
M tests/unit_tests/openvpn/tes=
t_oob=2Ec
3 files changed, 432 insertions(+), 0 deletions(-)


  git pull s=
sh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/46/1746/13

diff --g=
it a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec
index bc0e7a3=2E=2E3884ae3 1=
00644
--- a/src/openvpn/oob=2Ec
+++ b/src/openvpn/oob=2Ec
@@ -155,3 +155,16=
0 @@
     reply->peer_session_id =3D *peer_sid;
     return true;
 }
+
+/* =
Base ordering: responders before non-responders, then by priority (lower
+ =
* first), then by RTT (lower first), then by original index for determinism=
=2E
+ * This groups responders into priority runs pre-sorted by RTT, which =
the
+ * candidate-band step below relies on (run[0] is the fastest in its g=
roup)=2E */
+static int
+oob_probe_result_compare(const void *a, const void=
 *b)
+{
+    const struct oob_probe_result *ra =3D a;
+    const struct oob=
_probe_result *rb =3D b;
+
+    if (ra->responded && rb->responded)
+    {
=
+        /* both answered: lowest priority first, then lowest RTT */
+     =
   if (ra->reply=2Epriority !=3D rb->reply=2Epriority)
+        {
+        =
    return ra->reply=2Epriority < rb->reply=2Epriority ? -1 : 1;
+        }=

+        if (ra->rtt_ms !=3D rb->rtt_ms)
+        {
+            return ra=
->rtt_ms < rb->rtt_ms ? -1 : 1;
+        }
+    }
+    else if (ra->respond=
ed)
+    {
+        return -1; /* only a answered: it ranks first */
+    }=

+    else if (rb->responded)
+    {
+        return 1; /* only b answered =
*/
+    }
+
+    /* neither answered, or all keys equal: keep the configure=
d order */
+    return ra->index - rb->index;
+}
+
+int
+oob_effective_marg=
in(const struct oob_probe_result *r, int client_margin)
+{
+    if (client_=
margin >=3D 0)
+    {
+        return client_margin;              /* the cl=
ient's own setting is authoritative */
+    }
+    return (int)r->reply=2Em=
ax_latency_diff; /* else the server's advertised value */
+}
+
+/* Reorder =
the index list idx[0=2E=2Em) into DNS-SRV (RFC 2782) weighted-random
+ * or=
der by results[idx[k]]=2Ereply=2Eweight: each position is filled by a remai=
ning entry
+ * chosen with probability proportional to its weight=2E When a=
ll remaining
+ * weights are 0 the current (RTT-sorted) order is kept=2E */=

+static void
+oob_weighted_order(const struct oob_probe_result *results, i=
nt *idx, int m, int64_t (*rng)(void))
+{
+    for (int pos =3D 0; pos < m; =
pos++)
+    {
+        long sum =3D 0;
+        for (int k =3D pos; k < m; =
k++)
+        {
+            sum +=3D results[idx[k]]=2Ereply=2Eweight;
+  =
      }
+        int chosen =3D pos;
+        if (sum > 0)
+        {
+    =
        int64_t r =3D rng() % sum; /* uniform in [0, sum) */
+            l=
ong acc =3D 0;
+            for (int k =3D pos; k < m; k++)
+            {
=
+                acc +=3D results[idx[k]]=2Ereply=2Eweight;
+              =
  if (acc > r)
+                {
+                    chosen =3D k;
+     =
               break;
+                }
+            }
+        }
+       =
 int t =3D idx[pos];
+        idx[pos] =3D idx[chosen];
+        idx[chosen=
] =3D t;
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
index 80775a4=2E=2E0b96a11 100644
--- a/src/openvpn/oob=2Eh=

+++ b/src/openvpn/oob=2Eh
@@ -180,4 +180,56 @@
 bool oob_build_probe_reply=
(struct buffer *probe_payload, uint64_t now, uint64_t window_secs,
        =
                    const struct session_id *peer_sid, struct oob_probe_rep=
ly *reply);
 
+/* Candidate-band margin (ms) a server advertises when --ser=
ver-probe-reply does
+ * not set one=2E Announcing 0 is a valid choice with=
 a distinct meaning -- only
+ * the lowest-latency server is a candidate --=
 so an unconfigured server has to
+ * announce something else; the spec sug=
gests 10 to 20 ms=2E */
+#define OOB_DEFAULT_LATENCY_MARGIN_MS 10
+
+/* Out=
come of probing one remote, used to order remotes best-first=2E @index is
+=
 * the caller's identifier for the remote (e=2Eg=2E its position in the con=
nection
+ * list); priority/weight are only meaningful when @responded is t=
rue=2E */
+struct oob_probe_result
+{
+    int index;
+    bool responded;
=
+    unsigned int rtt_ms;          /* probe round-trip time in ms (responde=
rs only) */
+    struct oob_probe_reply reply; /* the values the server adv=
ertised */
+};
+
+/**
+ * Order results best-first, in place, per the serve=
r-probe selection policy:
+ *   - remotes that responded rank before those =
that did not (non-responders keep
+ *     their original relative order, la=
st);
+ *   - responders are grouped by priority, lowest priority value firs=
t (an
+ *     absolute ordering, never overridden by latency or weight);
+ =
*   - within a priority group, the "candidates" are the responders whose RT=
T is
+ *     no more than a margin larger than the fastest in the group (se=
e
+ *     oob_effective_margin()), so the fastest is always one=2E Candidat=
es are
+ *     ordered ahead of non-candidates;
+ *   - candidates are orde=
red by DNS-SRV (RFC 2782) weighted-random selection by
+ *     weight, so a=
 server is chosen first with probability proportional to its
+ *     weight=
 (load distribution)=2E Non-candidates follow, ordered by RTT=2E
+ *
+ * @p=
aram results        results to reorder in place
+ * @param n              n=
umber of results
+ * @param client_margin  client's candidate-band margin i=
n ms, or < 0 if the
+ *                        client did not set one (see =
oob_effective_margin())
+ * @param rng            returns a non-negative ra=
ndom value (e=2Eg=2E get_random);
+ *                       injected so thi=
s module stays free of the crypto layer
+ *                       and the w=
eighted ordering is deterministically testable
+ * @param gc             ar=
ena for scratch allocation
+ */
+void oob_rank_probe_results(struct oob_pro=
be_result *results, int n, int client_margin,
+                            =
int64_t (*rng)(void), struct gc_arena *gc);
+
+/**
+ * The candidate-band m=
argin (ms) that applies to one probed remote -- how much
+ * slower than th=
e group's fastest that remote may be and still be a candidate=2E
+ * It is =
per-remote: the client's own setting is authoritative, and when
+ * client_=
margin < 0 each remote is judged by the max_latency_diff its own server
+ *=
 advertised=2E 0 then admits only the fastest remote and whatever ties with=
 it=2E
+ */
+int oob_effective_margin(const struct oob_probe_result *r, int=
 client_margin);
+
 #endif /* OOB_H */
diff --git a/tests/unit_tests/openvp=
n/test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec
index 183e107=2E=2E4=
cac61f 100644
--- a/tests/unit_tests/openvpn/test_oob=2Ec
+++ b/tests/unit_=
tests/openvpn/test_oob=2Ec
@@ -566,6 +566,219 @@
     gc_free(&gc);
 }
 
+/=
* Deterministic RNG stubs for the weighted-selection ordering=2E rank_rng_z=
ero
+ * makes the weighted draw always pick the first remaining candidate, =
preserving
+ * order; rank_rng_fixed returns a value we set to land in a ch=
osen weight slice=2E */
+static int64_t
+rank_rng_zero(void)
+{
+    return=
 0;
+}
+
+static int64_t rank_rng_value;
+static int64_t
+rank_rng_fixed(vo=
id)
+{
+    return rank_rng_value;
+}
+
+/* Responders rank ahead of non-re=
sponders regardless of index order=2E */
+static void
+test_rank_responder_=
before_nonresponder(void **state)
+{
+    struct gc_arena gc =3D gc_new();
=
+    struct oob_probe_result r[] =3D {
+        { =2Eindex =3D 0, =2Erespon=
ded =3D false },
+        { =2Eindex =3D 1, =2Eresponded =3D true, =2Ereply=
 =3D { =2Epriority =3D 100, =2Eweight =3D 50 } },
+    };
+    oob_rank_pro=
be_results(r, 2, 10, rank_rng_zero, &gc);
+    assert_int_equal(r[0]=2Einde=
x, 1);
+    assert_int_equal(r[1]=2Eindex, 0);
+    gc_free(&gc);
+}
+
+/* =
Among responders, the lowest priority value wins (an absolute ordering)=2E =
*/
+static void
+test_rank_by_priority(void **state)
+{
+    struct gc_aren=
a gc =3D gc_new();
+    struct oob_probe_result r[] =3D {
+        { =2Eind=
ex =3D 0, =2Eresponded =3D true, =2Ereply =3D { =2Epriority =3D 20, =2Eweig=
ht =3D 50 } },
+        { =2Eindex =3D 1, =2Eresponded =3D true, =2Ereply =
=3D { =2Epriority =3D 5, =2Eweight =3D 50 } },
+        { =2Eindex =3D 2, =
=2Eresponded =3D true, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 50 =
} },
+    };
+    oob_rank_probe_results(r, 3, 10, rank_rng_zero, &gc);
+  =
  assert_int_equal(r[0]=2Eindex, 1); /* priority 5 */
+    assert_int_equal=
(r[1]=2Eindex, 2); /* priority 10 */
+    assert_int_equal(r[2]=2Eindex, 0)=
; /* priority 20 */
+    gc_free(&gc);
+}
+
+/* Within a priority, only ser=
vers within the latency margin of the fastest are
+ * candidates; a slower =
(out-of-band) server ranks behind a faster one no matter
+ * how large its =
weight=2E */
+static void
+test_rank_candidate_band(void **state)
+{
+    s=
truct gc_arena gc =3D gc_new();
+    struct oob_probe_result r[] =3D {
+   =
     { =2Eindex =3D 0, =2Eresponded =3D true, =2Ertt_ms =3D 100, =2Ereply =
=3D { =2Epriority =3D 10, =2Eweight =3D 1000 } },
+        { =2Eindex =3D 1=
, =2Eresponded =3D true, =2Ertt_ms =3D 20, =2Ereply =3D { =2Epriority =3D 1=
0, =2Eweight =3D 1 } },
+    };
+    /* margin 10ms: 20ms is fastest; 100ms=
 is 80ms slower -> out of band */
+    oob_rank_probe_results(r, 2, 10, ran=
k_rng_zero, &gc);
+    assert_int_equal(r[0]=2Eindex, 1); /* fast, in-band,=
 despite tiny weight */
+    assert_int_equal(r[1]=2Eindex, 0); /* slow, ou=
t-of-band, despite huge weight */
+    gc_free(&gc);
+}
+
+/* A server wide=
ns its own band via the advertised max_latency_diff, joining the
+ * candid=
ate set even when it is well behind the fastest; it then participates in
+ =
* the weighted selection=2E */
+static void
+test_rank_advertised_margin(vo=
id **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct oob_probe_=
result r[] =3D {
+        { =2Eindex =3D 0, =2Eresponded =3D true, =2Ertt_m=
s =3D 20, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 1 } },
+        =
{ =2Eindex =3D 1,
+          =2Eresponded =3D true,
+          =2Ertt_ms =
=3D 100,
+          =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 1000, =
=2Emax_latency_diff =3D 200 } },
+    };
+    /* Client did not set a margi=
n (-1), so each server's advertised value
+     * applies: the 100ms server=
 advertises 200 -> it is a candidate 80ms behind
+     * the fastest; with =
weight 1000 (slice [1,1001)) a draw of 500 selects it
+     * first=2E */
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
ex =3D 0, =2Eresponded =3D true, =2Ertt_ms =3D 20, =2Ereply =3D { =2Epriori=
ty =3D 10, =2Eweight =3D 30 } },
+        { =2Eindex =3D 1, =2Eresponded =
=3D true, =2Ertt_ms =3D 20, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =
=3D 70 } },
+    };
+    struct oob_probe_result r[2];
+
+    memcpy(r, bas=
e, sizeof(base));
+    rank_rng_value =3D 10; /* falls in index 0's slice *=
/
+    oob_rank_probe_results(r, 2, 50, rank_rng_fixed, &gc);
+    assert_i=
nt_equal(r[0]=2Eindex, 0);
+
+    memcpy(r, base, sizeof(base));
+    rank_=
rng_value =3D 50; /* falls in index 1's slice */
+    oob_rank_probe_result=
s(r, 2, 50, rank_rng_fixed, &gc);
+    assert_int_equal(r[0]=2Eindex, 1);
+=

+    gc_free(&gc);
+}
+
+/* An advertised max_latency_diff of 0 means "com=
pare on latency alone": the
+ * server's own band is empty, so weight canno=
t float it ahead of a faster peer=2E
+ * The same pair with a band advertis=
ed does let weight decide=2E */
+static void
+test_rank_advertised_zero_mar=
gin(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    const struc=
t oob_probe_result base[] =3D {
+        { =2Eindex =3D 0, =2Eresponded =3D=
 true, =2Ertt_ms =3D 20, =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 1=
 } },
+        { =2Eindex =3D 1, =2Eresponded =3D true, =2Ertt_ms =3D 40, =
=2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 1000 } },
+    };
+    str=
uct oob_probe_result r[2];
+
+    memcpy(r, base, sizeof(base));
+    rank_=
rng_value =3D 500;
+    oob_rank_probe_results(r, 2, -1, rank_rng_fixed, &g=
c);
+    assert_int_equal(r[0]=2Eindex, 0); /* both advertise 0 -> fastest =
wins */
+
+    memcpy(r, base, sizeof(base));
+    r[0]=2Ereply=2Emax_laten=
cy_diff =3D 50;
+    r[1]=2Ereply=2Emax_latency_diff =3D 50;
+    rank_rng_=
value =3D 500;            /* falls in the weight-1000 slice [1,1001) */
+  =
  oob_rank_probe_results(r, 2, -1, rank_rng_fixed, &gc);
+    assert_int_eq=
ual(r[0]=2Eindex, 1); /* 20ms behind but inside a 50ms band */
+
+    gc_fr=
ee(&gc);
+}
+
+/* The fastest remote is a candidate even when it advertises=
 0: it competes with
+ * a slower remote whose own band covers the gap inst=
ead of being ranked behind
+ * it outright=2E Neither carries weight here, =
so the candidate order is RTT order
+ * -- had the fastest fallen out of th=
e band, the slower one would lead=2E */
+static void
+test_rank_zero_margin=
_keeps_fastest_a_candidate(void **state)
+{
+    struct gc_arena gc =3D gc_=
new();
+    struct oob_probe_result r[] =3D {
+        { =2Eindex =3D 0, =
=2Eresponded =3D true, =2Ertt_ms =3D 50, =2Ereply =3D { =2Epriority =3D 10,=
 =2Eweight =3D 0, =2Emax_latency_diff =3D 0 } },
+        { =2Eindex =3D 1,=
 =2Eresponded =3D true, =2Ertt_ms =3D 100, =2Ereply =3D { =2Epriority =3D 1=
0, =2Eweight =3D 0, =2Emax_latency_diff =3D 100 } },
+    };
+    oob_rank_=
probe_results(r, 2, -1, rank_rng_zero, &gc);
+    assert_int_equal(r[0]=2Ei=
ndex, 0);
+    gc_free(&gc);
+}
+
+/* Remotes tied at the fastest RTT are a=
ll candidates even at margin 0, so weight
+ * still distributes load betwee=
n them=2E */
+static void
+test_rank_zero_margin_weights_ties(void **state)=

+{
+    struct gc_arena gc =3D gc_new();
+    struct oob_probe_result r[] =
=3D {
+        { =2Eindex =3D 0, =2Eresponded =3D true, =2Ertt_ms =3D 20, =
=2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 1, =2Emax_latency_diff =3D=
 0 } },
+        { =2Eindex =3D 1, =2Eresponded =3D true, =2Ertt_ms =3D 20,=
 =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 1000, =2Emax_latency_diff=
 =3D 0 } },
+    };
+    rank_rng_value =3D 500; /* falls in the weight-100=
0 slice [1,1001) */
+    oob_rank_probe_results(r, 2, -1, rank_rng_fixed, &=
gc);
+    assert_int_equal(r[0]=2Eindex, 1);
+    gc_free(&gc);
+}
+
+/* A =
remote exactly its advertised margin behind the fastest is still a candidat=
e
+ * ("no more than max_latency_diff larger than the lowest RTT")=2E */
+s=
tatic void
+test_rank_margin_boundary_is_inclusive(void **state)
+{
+    st=
ruct gc_arena gc =3D gc_new();
+    struct oob_probe_result r[] =3D {
+    =
    { =2Eindex =3D 0, =2Eresponded =3D true, =2Ertt_ms =3D 20, =2Ereply =3D=
 { =2Epriority =3D 10, =2Eweight =3D 1, =2Emax_latency_diff =3D 10 } },
+  =
      { =2Eindex =3D 1, =2Eresponded =3D true, =2Ertt_ms =3D 30, =2Ereply =
=3D { =2Epriority =3D 10, =2Eweight =3D 1000, =2Emax_latency_diff =3D 10 } =
},
+    };
+    rank_rng_value =3D 500;
+    oob_rank_probe_results(r, 2, -=
1, rank_rng_fixed, &gc);
+    assert_int_equal(r[0]=2Eindex, 1); /* exactly=
 10ms behind, in band, wins on weight */
+    gc_free(&gc);
+}
+
+/* Non-re=
sponders are placed last, keeping their original relative order=2E */
+stat=
ic void
+test_rank_nonresponders_last(void **state)
+{
+    struct gc_arena=
 gc =3D gc_new();
+    struct oob_probe_result r[] =3D {
+        { =2Einde=
x =3D 0, =2Eresponded =3D false },
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
 int
 main(void)
 {
@@ -593,6 +806,16 @@
         cmocka_unit=
_test(test_client_reply_read_rejects_unknown_mandatory),
         cmocka_un=
it_test(test_client_reply_read_missing),
         cmocka_unit_test(test_cli=
ent_reply_read_wrong_msg_type),
+        cmocka_unit_test(test_rank_respond=
er_before_nonresponder),
+        cmocka_unit_test(test_rank_by_priority),
=
+        cmocka_unit_test(test_rank_candidate_band),
+        cmocka_unit_t=
est(test_rank_advertised_margin),
+        cmocka_unit_test(test_rank_adver=
tised_zero_margin),
+        cmocka_unit_test(test_rank_zero_margin_keeps_f=
astest_a_candidate),
+        cmocka_unit_test(test_rank_zero_margin_weight=
s_ties),
+        cmocka_unit_test(test_rank_margin_boundary_is_inclusive),=

+        cmocka_unit_test(test_rank_weighted_selection),
+        cmocka_u=
nit_test(test_rank_nonresponders_last),
     };
 
     return cmocka_run_gr=
oup_tests_name("oob tests", tests, NULL, NULL);

-- 
To view, visit http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1746?usp=3Demail
To unsubscribe, or for =
help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I55da68cc341bcfc707fd34ca2f84ff9b6a55501f
Ge=
rrit-Change-Number: 1746
Gerrit-PatchSet: 13
Gerrit-Owner: stipa <lstipakov=
@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attent=
ion: plaisthos <arne-openvpn@rfc2549=2Eorg>

--mSlfVrJAgyE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #13</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1746?usp=3Demail">View Change</a></p><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">oob: Add=
 probe-result ranking for server selection<br><br>Add oob_rank_probe_result=
s(), which orders remotes best-first from their probe<br>results, following=
 the DNS-SRV (RFC 2782) semantics of the probe_reply TLV:<br><br>  - remote=
s that answered rank before those that did not (non-responders keep<br>    =
their original relative order, last);<br>  - responders are grouped by prio=
rity, lowest value first (an absolute<br>    ordering, never overridden by =
latency or weight);<br>  - within a priority group the &quot;candidates&quo=
t; are the responders whose RTT is<br>    no more than a margin larger than=
 the fastest, so the fastest is always<br>    one; candidates rank ahead of=
 non-candidates;<br>  - candidates are ordered by RFC-2782 weighted-random =
selection by weight, so<br>    a server is chosen first with probability pr=
oportional to its weight (load<br>    distribution); non-candidates follow,=
 ordered by RTT=2E<br><br>oob_effective_margin() decides that margin: the c=
lient&#39;s --server-probe value if<br>it set one, otherwise the server&#39=
;s advertised max_latency_diff, where 0 admits<br>only the fastest responde=
r and whatever ties with it=2E<br><br>The RNG is injected as a function poi=
nter so this module stays free of the<br>crypto layer and the weighted orde=
ring is deterministically unit-testable (the<br>client will pass get_random=
; the tests pass stubs)=2E<br><br>Exercised by unit tests; the client probe=
 path calls it in a follow-up, which<br>also populates RTT -- until then ev=
ery responder sits in the band and selection<br>is purely weighted-random=
=2E<br><br>Change-Id: I55da68cc341bcfc707fd34ca2f84ff9b6a55501f<br>Signed-o=
ff-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M src/openvpn/oob=
=2Ec<br>M src/openvpn/oob=2Eh<br>M tests/unit_tests/openvpn/test_oob=2Ec<br=
>3 files changed, 432 insertions(+), 0 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/46/174=
6/13</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec</span><=
br><span>index bc0e7a3=2E=2E3884ae3 100644</span><br><span>--- a/src/openvp=
n/oob=2Ec</span><br><span>+++ b/src/openvpn/oob=2Ec</span><br><span>@@ -155=
,3 +155,160 @@</span><br><span>     reply-&gt;peer_session_id =3D *peer_sid=
;</span><br><span>     return true;</span><br><span> }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/* Base ordering: responders before non-responders, then by=
 priority (lower</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
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
t;reply=2Epriority !=3D rb-&gt;reply=2Epriority)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            return ra-&gt;reply=2Epriority &lt; rb-&gt;r=
eply=2Epriority ? -1 : 1;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    if (ra-&gt;rtt_ms !=3D rb-&gt;rtt_ms)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            return ra-&gt;rtt_ms &lt; rb-&gt;rtt_ms ? -1 : 1;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    else if (ra-&gt;responded)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        return -1; /* only a answered: it ranks =
first */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (rb-&gt;respo=
nded)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        return 1; /* only b =
answered */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* neither answered, or all keys equa=
l: keep the configured order */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return ra-&gt;index - rb-&gt;index;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_effective_margi=
n(const struct oob_probe_result *r, int client_margin)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (client_margin &gt;=3D 0)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        return client_margin;              /* the client&#3=
9;s own setting is authoritative */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    return (int)r-&gt;reply=2Emax_latency_diff; /* else the server&#39;s =
advertised value */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/* Reorder the index list idx[0=2E=2E=
m) into DNS-SRV (RFC 2782) weighted-random</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * order by results[idx[k]]=2Ereply=2Eweight: each p=
osition is filled by a remaining entry</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * chosen with probability proportional to its weight=2E=
 When all remaining</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * weights are 0 the current (RTT-sorted) order is kept=2E */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+oob_weighted_order(const struct oob_probe=
_result *results, int *idx, int m, int64_t (*rng)(void))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    for (int pos =3D 0; pos &lt; m; pos++)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        long sum =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        for (int k =3D pos; k &lt; m; k++=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            sum +=3D results=
[idx[k]]=2Ereply=2Eweight;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     int chosen =3D pos;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (sum &gt; 0)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           int64_t r =3D rng() % sum; /* uniform in [0, sum) */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            long acc =3D 0;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            for (int k =
=3D pos; k &lt; m; k++)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              acc +=3D results[idx[k]]=2Ereply=2Eweight;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                if (acc &gt; r)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                    chosen =
=3D k;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
       break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        int t =3D idx[po=
s];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        idx[pos]=
 =3D idx[chosen];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      idx[chosen] =3D t;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/* Reorder one priority run (run[0=2E=2Em), al=
ready RTT-sorted) in place:</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * candidates (RTT within the band of the fastest) first, ordered b=
y weighted</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * random=
; then non-candidates in RTT order=2E */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+oob_order_priority_run(struct oob_probe_result *run, int m, in=
t client_margin, int64_t (*rng)(void),</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                       struct gc_arena *gc)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (m &lt;=3D 1)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int best_rtt=
 =3D run[0]=2Ertt_ms; /* run is RTT-sorted: [0] is fastest */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    int *cand =3D gc_malloc(sizeof(int) * m, false, =
gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int *non =
=3D gc_malloc(sizeof(int) * m, false, gc);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    int nc =3D 0;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    int nn =3D 0;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    for (int k =3D 0; k &lt; m; k++)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        /* &quot;no more than their max_latency_diff =
larger than the lowest RTT&quot;, so the</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+         * comparison includes the margin itself=2E Th=
at also keeps the fastest of</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+         * the run a candidate when it advertises 0: announcing 0 =
asks not to be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
    * compared on weight, not to be ranked behind a slower server=2E */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        unsigned int ga=
p =3D run[k]=2Ertt_ms - best_rtt;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        if (gap &lt;=3D (unsigned int)oob_effective_margin(&a=
mp;run[k], client_margin))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         cand[nc++] =3D k;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            non[nn++=
] =3D k;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    oob_weighted_order(run, cand, nc, rng);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct oob_probe_result *tmp =3D gc_malloc(si=
zeof(*tmp) * m, false, gc);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    int t =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    for (int k =3D 0; k &lt; nc; k++)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        tmp[t++] =3D run[cand[k]];</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    for (int k =3D 0; k &lt; nn; k++)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        tmp[t++] =3D run[non[k]];</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    memcpy(run, tmp, sizeof(*run) * m);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+voi=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_rank_probe_res=
ults(struct oob_probe_result *results, int n, int client_margin,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                       int64_t=
 (*rng)(void), struct gc_arena *gc)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (n &lt;=3D 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* Base order: responders first, grouped by prio=
rity, RTT-sorted within=2E */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    qsort(results, (size_t)n, sizeof(*results), oob_probe_result_=
compare);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* Reorder each priority =
run of responders by candidate-band + weight=2E */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    int i =3D 0;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    while (i &lt; n &amp;&amp; results[i]=2Eres=
ponded)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        int j =3D i;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        while (j &lt; n &=
amp;&amp; results[j]=2Eresponded</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+               &amp;&amp; results[j]=2Ereply=2Epriority =3D=3D=
 results[i]=2Ereply=2Epriority)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            j++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        oob=
_order_priority_run(results + i, j - i, client_margin, rng, gc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        i =3D j;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/src/openvpn/oob=
=2Eh b/src/openvpn/oob=2Eh</span><br><span>index 80775a4=2E=2E0b96a11 10064=
4</span><br><span>--- a/src/openvpn/oob=2Eh</span><br><span>+++ b/src/openv=
pn/oob=2Eh</span><br><span>@@ -180,4 +180,56 @@</span><br><span> bool oob_b=
uild_probe_reply(struct buffer *probe_payload, uint64_t now, uint64_t windo=
w_secs,</span><br><span>                            const struct session_id=
 *peer_sid, struct oob_probe_reply *reply);</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/* Candidate-band margin (ms) a s=
erver advertises when --server-probe-reply does</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * not set one=2E Announcing 0 is a valid choic=
e with a distinct meaning -- only</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * the lowest-latency server is a candidate -- so an unconfig=
ured server has to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* announce something else; the spec suggests 10 to 20 ms=2E */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define OOB_DEFAULT_LATENCY_MARG=
IN_MS 10</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/* Outcome of probing one remo=
te, used to order remotes best-first=2E @index is</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * the caller&#39;s identifier for the remote=
 (e=2Eg=2E its position in the connection</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * list); priority/weight are only meaningful when @r=
esponded is true=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+struct oob_probe_result</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ind=
ex;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool respond=
ed;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int=
 rtt_ms;          /* probe round-trip time in ms (responders only) */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_repl=
y reply; /* the values the server advertised */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Order results best-fi=
rst, in place, per the server-probe selection policy:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *   - remotes that responded rank before=
 those that did not (non-responders keep</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *     their original relative order, last);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *   - responders are grouped=
 by priority, lowest priority value first (an</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *     absolute ordering, never overridden by lat=
ency or weight);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
  - within a priority group, the &quot;candidates&quot; are the responders =
whose RTT is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *     =
no more than a margin larger than the fastest in the group (see</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *     oob_effective_margin()),=
 so the fastest is always one=2E Candidates are</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *     ordered ahead of non-candidates;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *   - candidates are order=
ed by DNS-SRV (RFC 2782) weighted-random selection by</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *     weight, so a server is chosen firs=
t with probability proportional to its</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *     weight (load distribution)=2E Non-candidates foll=
ow, ordered by RTT=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param resul=
ts        results to reorder in place</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @param n              number of results</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @param client_margin  client&#3=
9;s candidate-band margin in ms, or &lt; 0 if the</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *                        client did not set =
one (see oob_effective_margin())</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @param rng            returns a non-negative random value (=
e=2Eg=2E get_random);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *                       injected so this module stays free of the crypto=
 layer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *           =
            and the weighted ordering is deterministically testable</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param gc             ar=
ena for scratch allocation</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void oob_=
rank_probe_results(struct oob_probe_result *results, int n, int client_marg=
in,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
            int64_t (*rng)(void), struct gc_arena *gc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * The candidate-band margin (ms) that applies to one probed remote -- how=
 much</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * slower than=
 the group&#39;s fastest that remote may be and still be a candidate=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * It is per-remote: th=
e client&#39;s own setting is authoritative, and when</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * client_margin &lt; 0 each remote is ju=
dged by the max_latency_diff its own server</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * advertised=2E 0 then admits only the fastest rem=
ote and whatever ties with it=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int=
 oob_effective_margin(const struct oob_probe_result *r, int client_margin);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #=
endif /* OOB_H */</span><br><span>diff --git a/tests/unit_tests/openvpn/tes=
t_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>index 183=
e107=2E=2E4cac61f 100644</span><br><span>--- a/tests/unit_tests/openvpn/tes=
t_oob=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_oob=2Ec</span=
><br><span>@@ -566,6 +566,219 @@</span><br><span>     gc_free(&amp;gc);</sp=
an><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+/* Deterministic RNG stubs for the weighted-selection orderin=
g=2E rank_rng_zero</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* makes the weighted draw always pick the first remaining candidate, preser=
ving</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * order; rank_=
rng_fixed returns a value we set to land in a chosen weight slice=2E */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+static int64_t</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+rank_rng_zero(void)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return 0;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static int64_t=
 rank_rng_value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic int64_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+rank_rng=
_fixed(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return rank_rng_value=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/* Responders rank ahead of non-responders regardless o=
f index order=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_ran=
k_responder_before_nonresponder(void **state)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct oob_probe_result r[] =3D {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        { =2Eindex =3D 0, =2Eres=
ponded =3D false },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        { =2Eindex =3D 1, =2Eresponded =3D true, =2Ereply =3D { =2Epriority=
 =3D 100, =2Eweight =3D 50 } },</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   oob_rank_probe_results(r, 2, 10, rank_rng_zero, &amp;gc);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(r[0]=2Eindex,=
 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_=
equal(r[1]=2Eindex, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/* Among responders, the lowest=
 priority value wins (an absolute ordering)=2E */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+test_rank_by_priority(void **state)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_result r[] =3D {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        { =2Eindex =
=3D 0, =2Eresponded =3D true, =2Ereply =3D { =2Epriority =3D 20, =2Eweight =
=3D 50 } },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
{ =2Eindex =3D 1, =2Eresponded =3D true, =2Ereply =3D { =2Epriority =3D 5, =
=2Eweight =3D 50 } },</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        { =2Eindex =3D 2, =2Eresponded =3D true, =2Ereply =3D { =2Epriori=
ty =3D 10, =2Eweight =3D 50 } },</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    oob_rank_probe_results(r, 3, 10, rank_rng_zero, &amp;gc);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(r[0]=2Eindex=
, 1); /* priority 5 */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_int_equal(r[1]=2Eindex, 2); /* priority 10 */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(r[2]=2Eindex, =
0); /* priority 20 */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/* Within a priority, only server=
s within the latency margin of the fastest are</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * candidates; a slower (out-of-band) server ran=
ks behind a faster one no matter</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * how large its weight=2E */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+test_rank_candidate_band(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_result r[] =3D {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        { =2Eindex =3D =
0, =2Eresponded =3D true, =2Ertt_ms =3D 100, =2Ereply =3D { =2Epriority =3D=
 10, =2Eweight =3D 1000 } },</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        { =2Eindex =3D 1, =2Eresponded =3D true, =2Ertt_ms =3D 20,=
 =2Ereply =3D { =2Epriority =3D 10, =2Eweight =3D 1 } },</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* margin 10ms: 20ms is fastest; 100ms is 80ms =
slower -&gt; out of band */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    oob_rank_probe_results(r, 2, 10, rank_rng_zero, &amp;gc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(r[0]=
=2Eindex, 1); /* fast, in-band, despite tiny weight */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(r[1]=2Eindex, 0); /=
* slow, out-of-band, despite huge weight */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A server=
 widens its own band via the advertised max_latency_diff, joining the</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * candidate set even whe=
n it is well behind the fastest; it then participates in</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * the weighted selection=2E */</span>=
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
 -593,6 +806,16 @@</span><br><span>         cmocka_unit_test(test_client_re=
ply_read_rejects_unknown_mandatory),</span><br><span>         cmocka_unit_t=
est(test_client_reply_read_missing),</span><br><span>         cmocka_unit_t=
est(test_client_reply_read_wrong_msg_type),</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        cmocka_unit_test(test_rank_responder_before=
_nonresponder),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    cmocka_unit_test(test_rank_by_priority),</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_rank_candidate_band)=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_uni=
t_test(test_rank_advertised_margin),</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        cmocka_unit_test(test_rank_advertised_zero_margin)=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_uni=
t_test(test_rank_zero_margin_keeps_fastest_a_candidate),</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_rank_zer=
o_margin_weights_ties),</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        cmocka_unit_test(test_rank_margin_boundary_is_inclusive),</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(=
test_rank_weighted_selection),</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        cmocka_unit_test(test_rank_nonresponders_last),</span><b=
r><span>     };</span><br><span> </span><br><span>     return cmocka_run_gr=
oup_tests_name(&quot;oob tests&quot;, tests, NULL, NULL);</span><br><span><=
/span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1746?usp=3Demail">change 1746</a>=2E To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sche=
ma=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1746?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I55da68cc341bcfc707fd34ca2f84ff9b6a=
55501f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1746 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 13 </div>
<div style=3D"dis=
play:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=


</body></html>
--mSlfVrJAgyE=--


--===============7698119465299758167==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7698119465299758167==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7698119465299758167==--

