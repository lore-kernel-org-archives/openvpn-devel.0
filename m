Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F01ADC43638
	for <openvpn-devel@archiver.kernel.org>; Mon, 29 Jun 2026 07:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=ycOZnDLkO2mioIknBv2lJbnBtorJ2B6LX6BEO/kxmGI=; b=H9CDNi89yfIOY6
	zpqEM5X39KAPcNzijpQ2DmU4n1ZmVxzbF64HkxHcY2SbaQm/ZngWGDrukr80rVmTM/12lMt68Weyo
	J7+M53Rym7pfv2qRTn1drv2bHaiJPanEhcBVQQuNK/XYpgYolLOqs34gJ5FD5hlWGn54TAnolkcoY
	SnE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1we6tk-0006Xa-8c;
	Mon, 29 Jun 2026 07:59:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1we6th-0006XE-Q4
 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 07:59:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=w2rtnbaJNq6yKQKTmD0SLgZFXs1UuVsVEi9FOp6Hgv4=; b=XpsLEvBRknzBZPJK4k+8doap3B
 V1NM3pfMawcj2QVBkKCQvWdGsRDsOVeriJeEtX79o3kSPtFh/eCUaR0exBNHh0+BlC6j15neYczj9
 zpTjZtByBYzGcLVZYlgWj7/yP+WRWuNx4vqAlFl4XJY7DB1isGUicijUVNBeJlsAaDGE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=w2rtnbaJNq6yKQKTmD0SLgZFXs1UuVsVEi9FOp6Hgv4=; b=m
 PVF5iXsoYa6CmrpZxRHrbdOd2+tAlaIfJvvSmYF4xKCOEya6mAJb0Iyn3oyAoQUxqhTxGijZ1JQ3u
 jYNW7LxMdiMgUl61ZzddAcO6Nbzf2BfsAJ35jMWTI1E6UpY4yjOonDlsITcc+pK9hbfBztoRyobRu
 YGsToBFaMI9aqiz4=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1we6tb-0008Nm-VE for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 07:59:15 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-461edb387ddso2835270f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 29 Jun 2026 00:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782719941; x=1783324741; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w2rtnbaJNq6yKQKTmD0SLgZFXs1UuVsVEi9FOp6Hgv4=;
 b=TlLIuT2QYDyaUmpTr+HXRH//LLvfhMJfVGLkricT2ejmXC8hyVJgxYUn0tym9zlkIF
 GE7SIUk56QCzU8l+D9kWcirERsYnfkBvukXUHN6Y70Cfr/tFzwEEvg6NfOaF1/BYQW8H
 33PfQW31D/BLV3nNjg+NBx4pmu/CBgVrwcTfAXR011DXPB55xpQ55aIFhup7kzGJ+gcW
 anAlK6quus6jcnEWaxmHnacriN01tHYIJySOEpllAEDLrsXeeSzkk6yEkEbmXzoZaSyT
 jh0QYHepWOtN+ZwdEaV55/2/A50jQqGJ9v/gxvycba4NjmQGwuJdRjpSWeeD+/j0JaGj
 KgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782719941; x=1783324741;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w2rtnbaJNq6yKQKTmD0SLgZFXs1UuVsVEi9FOp6Hgv4=;
 b=idSJxLPOjf3ZJrXmHSyQ5DjSsssbePoe7qQlaq1cebO61+yJ5omv2oMOJazLdqDXR3
 KJRTtsp0ilZPtgMkUlWWrI/zSA428yoIX07wQ/OyV6kvq02iLV2LkhYpn6dwFlSfuysV
 kwGdWGEfldPHMA2p/w+GmkbglrxnpHno9HBAKOO3koKtnwA2r4+f7lpc137jQvLPd7gE
 uDMNUYj2Rl4JxmCdislQsUMged8UdxpMdEZc9jiFIDkJWuW1wVbOptLLp4QRLFFDjXfj
 G2MnHMGby3vN/NC/yBuE8nXdWWi71vPmPTYeYPLDAQhIqL/HoC+t8SawM6i9+HBMhHte
 GJLg==
X-Gm-Message-State: AOJu0Yzg83GO2QaXz74V4z0GfyXZiOAynT2jdzlBSxcyKdKKtXw3N590
 s034JLEl315bVSfIv8+VIVESFZnwM0oe5+TWBOcY6UDa4nrWhA3edZHjelleJRngHqQwEn6dyCD
 mtGy5pax51NYKAg8K1IaVX2IMnQV/Or6U6VN0mqcT8umNhhvSJ9uW9yJFXgKK2U4iwHu21LfAxc
 qYSEVm7A==
X-Gm-Gg: AfdE7ckesFPIB0vl9vvdH0zDUorHutpTcOzDKbWLys1TgSOxAzIGsbQvcuyKzIbCNfg
 1ESEnhj5qEUXQLQSwZ+yQK6nnRtWeKGeOtWEUCWK77Lba5Cl5dVdRpHGQGlhrcsvE9kq60BfHha
 T6vKkIMd4nezAXJ6MpQsr6NhTLQShkk2OKRYya/K9LPI2bHqOgavRmQ9qrGWFCs9W/uBbC+qqOu
 /ZJtZsiYMgMteVax2zGVPaQtkgLONzh9SiNk9ZNeRcRopXsYH5S1vJSq2KiEQ0xxdnNWQUVGB2A
 TM08eRnevlvI0M2zAQ2LS09jPCkqeIgWiaC70FIPdvVR5Da/y+SuHul7hYBouVxNEEEgqrHw/2o
 38ST6njK1F4qh5jbYOAj0+92UT3VUjcxPc+ZkMqBzLMnTNimCPvfGCsFlimnU264o3AjR5EdBmO
 Ep2GhpHb82Xc+Og9JhYsQD2B6IqJED3edhoMT5h564+o9gHQDppHIAmdutKPZYqMkwAcUTCffsy
 HglWMlBRivCpjLhwMtgl/1SW1d9wuSPyGFrNcyO46h/RyaR+UH2sIhPHpduGSDDF4OlLCmEIqlv
 0vc=
X-Received: by 2002:a05:6000:41f9:b0:472:4861:5d4d with SMTP id
 ffacd0b85a97d-47248615f74mr8444423f8f.23.1782719940588; 
 Mon, 29 Jun 2026 00:59:00 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm7022422f8f.35.2026.06.29.00.59.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 00:59:00 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 29 Jun 2026 07:58:59 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I55da68cc341bcfc707fd34ca2f84ff9b6a55501f
X-Gerrit-Change-Number: 1746
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1746?usp=email>
X-Gerrit-Commit: 07fcd8df66eb54dcfd0265176bfd9831304905b8
References: <gerrit.1782719911000.I55da68cc341bcfc707fd34ca2f84ff9b6a55501f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk1NWRhNjhjYzM0MWJjZmM3MDdmZDM0Y2EyZjg0ZmY5YjZhNTU1MDFmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9c562f7821bade0aebd429769b399700980315d4-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1we6tb-0008Nm-VE
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
Content-Type: multipart/mixed; boundary="===============6103127095243849514=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6103127095243849514==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ywD4Iu1UKjw="; charset=UTF-8

--ywD4Iu1UKjw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1746?usp=3Demail

to review the following change=2E


Chang=
e subject: oob: Add probe-result ranking for server selection
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Add probe-result ran=
king for server selection

Add oob_rank_probe_results(), which orders remot=
es best-first from their probe
results, following the DNS-SRV (RFC 2782) se=
mantics of the probe_reply TLV:

  - remotes that answered rank before thos=
e that did not (non-responders keep
    their original relative order, last=
);
  - responders are grouped by priority, lowest value first (an absolute
=
    ordering, never overridden by latency or weight);
  - within a priority=
 group the "candidates" are the responders whose RTT is
    within a margin=
 of the fastest (see oob_effective_margin()); candidates
    rank ahead of =
non-candidates;
  - candidates are ordered by RFC-2782 weighted-random sele=
ction by weight, so
    a server is chosen first with probability proportio=
nal to its weight (load
    distribution); non-candidates follow, ordered b=
y RTT=2E

The RNG is injected as a function pointer so this module stays fr=
ee of the
crypto layer and the weighted ordering is deterministically unit-=
testable
(production passes get_random; the tests pass stubs)=2E

RTT is on=
ly populated once the client measures it (a later commit); until then
every=
 responder sits in the band and selection is purely weighted-random=2E

Cha=
nge-Id: I55da68cc341bcfc707fd34ca2f84ff9b6a55501f
Signed-off-by: Lev Stipak=
ov <lev@openvpn=2Enet>
---
M src/openvpn/oob=2Ec
M src/openvpn/oob=2Eh
M te=
sts/unit_tests/openvpn/test_oob=2Ec
3 files changed, 343 insertions(+), 0 d=
eletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/c=
hanges/46/1746/1

diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec
in=
dex 9cc7c42=2E=2E9b359dd 100644
--- a/src/openvpn/oob=2Ec
+++ b/src/openvpn=
/oob=2Ec
@@ -241,3 +241,151 @@
     /* priority/weight/connect_lifetime/fla=
gs left at 0 for now */
     return true;
 }
+
+/* Base ordering: responder=
s before non-responders, then by priority (lower
+ * first), then by RTT (l=
ower first), then by original index for determinism=2E
+ * This groups resp=
onders into priority runs pre-sorted by RTT, which the
+ * candidate-band s=
tep below relies on (run[0] is the fastest in its group)=2E */
+static int
=
+oob_probe_result_compare(const void *a, const void *b)
+{
+    const struc=
t oob_probe_result *ra =3D a;
+    const struct oob_probe_result *rb =3D b;=

+
+    if (ra->responded !=3D rb->responded)
+    {
+        return ra->re=
sponded ? -1 : 1;
+    }
+    if (ra->responded)
+    {
+        if (ra->pr=
iority !=3D rb->priority)
+        {
+            return ra->priority < rb-=
>priority ? -1 : 1;
+        }
+        if (ra->rtt_ms !=3D rb->rtt_ms)
+  =
      {
+            return ra->rtt_ms < rb->rtt_ms ? -1 : 1;
+        }
+ =
   }
+    return ra->index - rb->index;
+}
+
+int
+oob_effective_margin(con=
st struct oob_probe_result *r, int client_margin)
+{
+    if (client_margin=
 >=3D 0)
+    {
+        return client_margin; /* the client's own setting =
is authoritative */
+    }
+    if (r->max_latency_diff > 0)
+    {
+      =
  return (int)r->max_latency_diff; /* else the server's advertised value */=

+    }
+    return OOB_DEFAULT_LATENCY_MARGIN_MS;
+}
+
+/* Reorder the ind=
ex list @p idx[0=2E=2Em) into DNS-SRV (RFC 2782) weighted-random
+ * order =
by results[idx[k]]=2Eweight: each position is filled by a remaining entry
+=
 * chosen with probability proportional to its weight=2E When all remaining=

+ * weights are 0 the current (RTT-sorted) order is kept=2E */
+static voi=
d
+oob_weighted_order(const struct oob_probe_result *results, int *idx, int=
 m, long (*rng)(void))
+{
+    for (int pos =3D 0; pos < m; pos++)
+    {
+=
        long sum =3D 0;
+        for (int k =3D pos; k < m; k++)
+        {=

+            sum +=3D results[idx[k]]=2Eweight;
+        }
+        int ch=
osen =3D pos;
+        if (sum > 0)
+        {
+            long r =3D rng(=
) % sum; /* uniform in [0, sum) */
+            long acc =3D 0;
+          =
  for (int k =3D pos; k < m; k++)
+            {
+                acc +=3D =
results[idx[k]]=2Eweight;
+                if (acc > r)
+                {
=
+                    chosen =3D k;
+                    break;
+           =
     }
+            }
+        }
+        int t =3D idx[pos];
+        idx[=
pos] =3D idx[chosen];
+        idx[chosen] =3D t;
+    }
+}
+
+/* Reorder o=
ne priority run (@p run[0=2E=2Em), already RTT-sorted) in place:
+ * candid=
ates (RTT within the band of the fastest) first, ordered by weighted
+ * ra=
ndom; then non-candidates in RTT order=2E */
+static void
+oob_order_priori=
ty_run(struct oob_probe_result *run, int m, int client_margin, long (*rng)(=
void),
+                       struct gc_arena *gc)
+{
+    if (m <=3D 1)
+=
    {
+        return;
+    }
+
+    unsigned int best_rtt =3D run[0]=2Ertt=
_ms; /* run is RTT-sorted: [0] is fastest */
+
+    int *cand =3D gc_malloc=
(sizeof(int) * m, false, gc);
+    int *non =3D gc_malloc(sizeof(int) * m, =
false, gc);
+    int nc =3D 0;
+    int nn =3D 0;
+    for (int k =3D 0; k =
< m; k++)
+    {
+        if (run[k]=2Ertt_ms - best_rtt < (unsigned int)oo=
b_effective_margin(&run[k], client_margin))
+        {
+            cand[nc=
++] =3D k;
+        }
+        else
+        {
+            non[nn++] =3D k=
;
+        }
+    }
+
+    oob_weighted_order(run, cand, nc, rng);
+
+    s=
truct oob_probe_result *tmp =3D gc_malloc(sizeof(*tmp) * m, false, gc);
+  =
  int t =3D 0;
+    for (int k =3D 0; k < nc; k++)
+    {
+        tmp[t++]=
 =3D run[cand[k]];
+    }
+    for (int k =3D 0; k < nn; k++)
+    {
+     =
   tmp[t++] =3D run[non[k]];
+    }
+    memcpy(run, tmp, sizeof(*run) * m)=
;
+}
+
+void
+oob_rank_probe_results(struct oob_probe_result *results, int =
n, int client_margin,
+                       long (*rng)(void), struct gc_=
arena *gc)
+{
+    if (n <=3D 1)
+    {
+        return;
+    }
+
+    /* B=
ase order: responders first, grouped by priority, RTT-sorted within=2E */
+=
    qsort(results, (size_t)n, sizeof(*results), oob_probe_result_compare);
=
+
+    /* Reorder each priority run of responders by candidate-band + weigh=
t=2E */
+    int i =3D 0;
+    while (i < n && results[i]=2Eresponded)
+   =
 {
+        int j =3D i;
+        while (j < n && results[j]=2Eresponded &&=
 results[j]=2Epriority =3D=3D results[i]=2Epriority)
+        {
+          =
  j++;
+        }
+        oob_order_priority_run(results + i, j - i, clien=
t_margin, rng, gc);
+        i =3D j;
+    }
+}
diff --git a/src/openvpn/oo=
b=2Eh b/src/openvpn/oob=2Eh
index 9040416=2E=2E65e84bd 100644
--- a/src/ope=
nvpn/oob=2Eh
+++ b/src/openvpn/oob=2Eh
@@ -215,4 +215,55 @@
 bool oob_build=
_probe_reply(struct buffer *probe_payload, uint64_t now, uint64_t window_se=
cs,
                            const struct session_id *peer_sid, struct o=
ob_probe_reply *reply);
 
+/* Candidate-band margin (ms) used when neither =
the client nor the server
+ * specifies one=2E */
+#define OOB_DEFAULT_LATE=
NCY_MARGIN_MS 10
+
+/* Outcome of probing one remote, used to order remotes=
 best-first=2E @index is
+ * the caller's identifier for the remote (e=2Eg=
=2E its position in the connection
+ * list); priority/weight are only mean=
ingful when @responded is true=2E */
+struct oob_probe_result
+{
+    int i=
ndex;
+    bool responded;
+    uint16_t priority;
+    uint16_t weight;
+ =
   uint16_t max_latency_diff; /* margin advertised by this server (ms); 0 =
=3D use client default */
+    unsigned int rtt_ms;       /* probe round-tr=
ip time in ms (responders only) */
+};
+
+/**
+ * Order @p results best-fir=
st, in place, per the server-probe selection policy:
+ *   - remotes that r=
esponded rank before those that did not (non-responders keep
+ *     their =
original relative order, last);
+ *   - responders are grouped by priority,=
 lowest priority value first (an
+ *     absolute ordering, never overridde=
n by latency or weight);
+ *   - within a priority group, the "candidates" =
are the responders whose RTT is
+ *     within a margin of the fastest in t=
he group (see oob_effective_margin())=2E
+ *     Candidates are ordered ahe=
ad of non-candidates;
+ *   - candidates are ordered by DNS-SRV (RFC 2782) =
weighted-random selection by
+ *     weight, so a server is chosen first wi=
th probability proportional to its
+ *     weight (load distribution)=2E No=
n-candidates follow, ordered by RTT=2E
+ *
+ * @param results        result=
s to reorder in place
+ * @param n              number of results
+ * @para=
m client_margin  client's candidate-band margin in ms, or < 0 if the
+ *   =
                     client did not set one (see oob_effective_margin())
+ =
* @param rng            returns a non-negative random value (e=2Eg=2E get_r=
andom);
+ *                       injected so this module stays free of the=
 crypto layer
+ *                       and the weighted ordering is determ=
inistically testable
+ * @param gc             arena for scratch allocation=

+ */
+void oob_rank_probe_results(struct oob_probe_result *results, int n,=
 int client_margin,
+                            long (*rng)(void), struct =
gc_arena *gc);
+
+/**
+ * The candidate-band margin (ms) that applies to on=
e probed remote=2E The client's
+ * own setting is authoritative: when @p c=
lient_margin >=3D 0 (the client set
+ * --server-probe with a value) it is =
used for every remote=2E Otherwise the
+ * server's advertised @c max_laten=
cy_diff is used when non-zero, falling back to
+ * OOB_DEFAULT_LATENCY_MARG=
IN_MS=2E
+ */
+int oob_effective_margin(const struct oob_probe_result *r, i=
nt client_margin);
+
 #endif /* OOB_H */
diff --git a/tests/unit_tests/open=
vpn/test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec
index 1029399=2E=
=2Eb66ade2 100644
--- a/tests/unit_tests/openvpn/test_oob=2Ec
+++ b/tests/u=
nit_tests/openvpn/test_oob=2Ec
@@ -429,6 +429,144 @@
     gc_free(&gc);
 }
=
 
+/* Deterministic RNG stubs for the weighted-selection ordering=2E rank_r=
ng_zero
+ * makes the weighted draw always pick the first remaining candida=
te, preserving
+ * order; rank_rng_fixed returns a value we set to land in =
a chosen weight slice=2E */
+static long
+rank_rng_zero(void)
+{
+    retur=
n 0;
+}
+
+static long rank_rng_value;
+static long
+rank_rng_fixed(void)
+=
{
+    return rank_rng_value;
+}
+
+/* Responders rank ahead of non-respond=
ers regardless of index order=2E */
+static void
+test_rank_responder_befor=
e_nonresponder(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    =
struct oob_probe_result r[] =3D {
+        { =2Eindex =3D 0, =2Eresponded =
=3D false },
+        { =2Eindex =3D 1, =2Eresponded =3D true, =2Epriority =
=3D 100, =2Eweight =3D 50 },
+    };
+    oob_rank_probe_results(r, 2, 10, =
rank_rng_zero, &gc);
+    assert_int_equal(r[0]=2Eindex, 1);
+    assert_in=
t_equal(r[1]=2Eindex, 0);
+    gc_free(&gc);
+}
+
+/* Among responders, the=
 lowest priority value wins (an absolute ordering)=2E */
+static void
+test=
_rank_by_priority(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+ =
   struct oob_probe_result r[] =3D {
+        { =2Eindex =3D 0, =2Eresponde=
d =3D true, =2Epriority =3D 20, =2Eweight =3D 50 },
+        { =2Eindex =3D=
 1, =2Eresponded =3D true, =2Epriority =3D 5, =2Eweight =3D 50 },
+        =
{ =2Eindex =3D 2, =2Eresponded =3D true, =2Epriority =3D 10, =2Eweight =3D =
50 },
+    };
+    oob_rank_probe_results(r, 3, 10, rank_rng_zero, &gc);
+ =
   assert_int_equal(r[0]=2Eindex, 1); /* priority 5 */
+    assert_int_equa=
l(r[1]=2Eindex, 2); /* priority 10 */
+    assert_int_equal(r[2]=2Eindex, 0=
); /* priority 20 */
+    gc_free(&gc);
+}
+
+/* Within a priority, only se=
rvers within the latency margin of the fastest are
+ * candidates; a slower=
 (out-of-band) server ranks behind a faster one no matter
+ * how large its=
 weight=2E */
+static void
+test_rank_candidate_band(void **state)
+{
+    =
struct gc_arena gc =3D gc_new();
+    struct oob_probe_result r[] =3D {
+  =
      { =2Eindex =3D 0, =2Eresponded =3D true, =2Epriority =3D 10, =2Eweigh=
t =3D 1000, =2Ertt_ms =3D 100 },
+        { =2Eindex =3D 1, =2Eresponded =
=3D true, =2Epriority =3D 10, =2Eweight =3D 1, =2Ertt_ms =3D 20 },
+    };
=
+    /* margin 10ms: 20ms is fastest; 100ms is 80ms slower -> out of band *=
/
+    oob_rank_probe_results(r, 2, 10, rank_rng_zero, &gc);
+    assert_in=
t_equal(r[0]=2Eindex, 1); /* fast, in-band, despite tiny weight */
+    ass=
ert_int_equal(r[1]=2Eindex, 0); /* slow, out-of-band, despite huge weight *=
/
+    gc_free(&gc);
+}
+
+/* A server widens its own band via the advertis=
ed max_latency_diff, joining the
+ * candidate set even when it is well beh=
ind the fastest; it then participates in
+ * the weighted selection=2E */
+=
static void
+test_rank_advertised_margin(void **state)
+{
+    struct gc_ar=
ena gc =3D gc_new();
+    struct oob_probe_result r[] =3D {
+        { =2Ei=
ndex =3D 0, =2Eresponded =3D true, =2Epriority =3D 10, =2Eweight =3D 1, =2E=
rtt_ms =3D 20 },
+        { =2Eindex =3D 1,
+          =2Eresponded =3D tru=
e,
+          =2Epriority =3D 10,
+          =2Eweight =3D 1000,
+         =
 =2Ertt_ms =3D 100,
+          =2Emax_latency_diff =3D 200 },
+    };
+    =
/* Client did not set a margin (-1), so each server's advertised value
+   =
  * applies: the 100ms server advertises 200 -> it is a candidate (the
+   =
  * default 10 would have excluded it); with weight 1000 (slice [1,1001)) a=

+     * draw of 500 selects it first=2E */
+    rank_rng_value =3D 500;
+ =
   oob_rank_probe_results(r, 2, -1, rank_rng_fixed, &gc);
+    assert_int_e=
qual(r[0]=2Eindex, 1);
+    gc_free(&gc);
+}
+
+/* Among candidates, weight=
 drives RFC-2782 proportional selection: a draw is
+ * mapped to the server=
 whose cumulative weight slice it falls in=2E */
+static void
+test_rank_we=
ighted_selection(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+  =
  /* equal priority and RTT -> both in band; weights 30 and 70, sum 100:
+ =
    * index 0 owns [0,30), index 1 owns [30,100)=2E */
+    const struct oo=
b_probe_result base[] =3D {
+        { =2Eindex =3D 0, =2Eresponded =3D tru=
e, =2Epriority =3D 10, =2Eweight =3D 30, =2Ertt_ms =3D 20 },
+        { =2E=
index =3D 1, =2Eresponded =3D true, =2Epriority =3D 10, =2Eweight =3D 70, =
=2Ertt_ms =3D 20 },
+    };
+    struct oob_probe_result r[2];
+
+    memcp=
y(r, base, sizeof(base));
+    rank_rng_value =3D 10; /* falls in index 0's=
 slice */
+    oob_rank_probe_results(r, 2, 50, rank_rng_fixed, &gc);
+    =
assert_int_equal(r[0]=2Eindex, 0);
+
+    memcpy(r, base, sizeof(base));
+ =
   rank_rng_value =3D 50; /* falls in index 1's slice */
+    oob_rank_prob=
e_results(r, 2, 50, rank_rng_fixed, &gc);
+    assert_int_equal(r[0]=2Einde=
x, 1);
+
+    gc_free(&gc);
+}
+
+/* Non-responders are placed last, keepin=
g their original relative order=2E */
+static void
+test_rank_nonresponders=
_last(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct oo=
b_probe_result r[] =3D {
+        { =2Eindex =3D 0, =2Eresponded =3D false =
},
+        { =2Eindex =3D 1, =2Eresponded =3D true, =2Epriority =3D 10, =
=2Eweight =3D 50, =2Ertt_ms =3D 20 },
+        { =2Eindex =3D 2, =2Erespond=
ed =3D false },
+        { =2Eindex =3D 3, =2Eresponded =3D true, =2Epriori=
ty =3D 10, =2Eweight =3D 50, =2Ertt_ms =3D 20 },
+    };
+    oob_rank_prob=
e_results(r, 4, 10, rank_rng_zero, &gc);
+    assert_int_equal(r[0]=2Eindex=
, 1); /* responder (rng_zero keeps order) */
+    assert_int_equal(r[1]=2Ei=
ndex, 3); /* responder */
+    assert_int_equal(r[2]=2Eindex, 0); /* non-re=
sponder, original order kept */
+    assert_int_equal(r[3]=2Eindex, 2);
+  =
  gc_free(&gc);
+}
+
 int
 main(void)
 {
@@ -452,6 +590,12 @@
         cmoc=
ka_unit_test(test_client_reply_read_skips_unknown),
         cmocka_unit_te=
st(test_client_reply_read_missing),
         cmocka_unit_test(test_client_r=
eply_read_wrong_msg_type),
+        cmocka_unit_test(test_rank_responder_be=
fore_nonresponder),
+        cmocka_unit_test(test_rank_by_priority),
+    =
    cmocka_unit_test(test_rank_candidate_band),
+        cmocka_unit_test(t=
est_rank_advertised_margin),
+        cmocka_unit_test(test_rank_weighted_s=
election),
+        cmocka_unit_test(test_rank_nonresponders_last),
     };=

 
     return cmocka_run_group_tests_name("oob tests", tests, NULL, NULL);=


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1746?usp=3De=
mail
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit=
-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I55da68cc341bcfc7=
07fd34ca2f84ff9b6a55501f
Gerrit-Change-Number: 1746
Gerrit-PatchSet: 1
Gerr=
it-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--ywD4Iu1UKjw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1746?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">oo=
b: Add probe-result ranking for server selection<br><br>Add oob_rank_probe_=
results(), which orders remotes best-first from their probe<br>results, fol=
lowing the DNS-SRV (RFC 2782) semantics of the probe_reply TLV:<br><br>  - =
remotes that answered rank before those that did not (non-responders keep<b=
r>    their original relative order, last);<br>  - responders are grouped b=
y priority, lowest value first (an absolute<br>    ordering, never overridd=
en by latency or weight);<br>  - within a priority group the &quot;candidat=
es&quot; are the responders whose RTT is<br>    within a margin of the fast=
est (see oob_effective_margin()); candidates<br>    rank ahead of non-candi=
dates;<br>  - candidates are ordered by RFC-2782 weighted-random selection =
by weight, so<br>    a server is chosen first with probability proportional=
 to its weight (load<br>    distribution); non-candidates follow, ordered b=
y RTT=2E<br><br>The RNG is injected as a function pointer so this module st=
ays free of the<br>crypto layer and the weighted ordering is deterministica=
lly unit-testable<br>(production passes get_random; the tests pass stubs)=
=2E<br><br>RTT is only populated once the client measures it (a later commi=
t); until then<br>every responder sits in the band and selection is purely =
weighted-random=2E<br><br>Change-Id: I55da68cc341bcfc707fd34ca2f84ff9b6a555=
01f<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M sr=
c/openvpn/oob=2Ec<br>M src/openvpn/oob=2Eh<br>M tests/unit_tests/openvpn/te=
st_oob=2Ec<br>3 files changed, 343 insertions(+), 0 deletions(-)<br><br></p=
re><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/c=
hanges/46/1746/1</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=
=2Ec</span><br><span>index 9cc7c42=2E=2E9b359dd 100644</span><br><span>--- =
a/src/openvpn/oob=2Ec</span><br><span>+++ b/src/openvpn/oob=2Ec</span><br><=
span>@@ -241,3 +241,151 @@</span><br><span>     /* priority/weight/connect_=
lifetime/flags left at 0 for now */</span><br><span>     return true;</span=
><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Base ordering: respond=
ers before non-responders, then by priority (lower</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * first), then by RTT (lower first), then b=
y original index for determinism=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * This groups responders into priority runs pre-sorted by =
RTT, which the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * ca=
ndidate-band step below relies on (run[0] is the fastest in its group)=2E *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_result_compare(co=
nst void *a, const void *b)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const =
struct oob_probe_result *ra =3D a;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const struct oob_probe_result *rb =3D b;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (ra-&gt;responded !=3D rb-&gt;responded)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        return ra-&gt;responded ? -1 : 1=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (ra-&gt;responded)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (ra-&gt;priority !=3D rb-&gt;=
priority)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return r=
a-&gt;priority &lt; rb-&gt;priority ? -1 : 1;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (ra-&gt;rtt_ms !=3D rb-&gt;rtt_ms)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            return ra-&gt;rtt_ms &lt; rb-=
&gt;rtt_ms ? -1 : 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ra-&gt;index=
 - rb-&gt;index;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+oob_effective_margin(const struct oob_probe_result *r, i=
nt client_margin)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (client_margi=
n &gt;=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return client=
_margin; /* the client&#39;s own setting is authoritative */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (r-&gt;max_latency_diff &gt; 0)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return (int)r-&gt;max_latency_dif=
f; /* else the server&#39;s advertised value */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    return OOB_DEFAULT_LATENCY_MARGIN_MS;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
* Reorder the index list @p idx[0=2E=2Em) into DNS-SRV (RFC 2782) weighted-=
random</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * order by r=
esults[idx[k]]=2Eweight: each position is filled by a remaining entry</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * chosen with probabilit=
y proportional to its weight=2E When all remaining</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * weights are 0 the current (RTT-sorted) or=
der is kept=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_weight=
ed_order(const struct oob_probe_result *results, int *idx, int m, long (*rn=
g)(void))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    for (int pos =3D 0; pos =
&lt; m; pos++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        long sum =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (=
int k =3D pos; k &lt; m; k++)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            sum +=3D results[idx[k]]=2Eweight;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        int chosen =3D pos;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if (sum &gt; 0)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            long r =3D rng() % sum; /* uniform in [0, su=
m) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            lo=
ng acc =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      for (int k =3D pos; k &lt; m; k++)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                acc +=3D results[idx[k]]=2Eweight;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                if (acc &gt; =
r)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
 chosen =3D k;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
               break;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int t =
=3D idx[pos];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  idx[pos] =3D idx[chosen];</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        idx[chosen] =3D t;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/* Reorder one priority run (@p run[=
0=2E=2Em), already RTT-sorted) in place:</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * candidates (RTT within the band of the fastest) fir=
st, ordered by weighted</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * random; then non-candidates in RTT order=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+oob_order_priority_run(struct oob_probe_result *r=
un, int m, int client_margin, long (*rng)(void),</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                       struct gc_arena *gc)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (m &lt;=3D 1)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned in=
t best_rtt =3D run[0]=2Ertt_ms; /* run is RTT-sorted: [0] is fastest */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
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
 100%, 40%);">+                       long (*rng)(void), struct gc_arena *g=
c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (n &lt;=3D 1)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Bas=
e order: responders first, grouped by priority, RTT-sorted within=2E */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    qsort(results, (siz=
e_t)n, sizeof(*results), oob_probe_result_compare);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* Reorder each priority run of responders by candidate-=
band + weight=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    int i =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
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
n>index 9040416=2E=2E65e84bd 100644</span><br><span>--- a/src/openvpn/oob=
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
0%);">+                            long (*rng)(void), struct gc_arena *gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * The candidate-band margin (ms) that applies to one =
probed remote=2E The client&#39;s</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * own setting is authoritative: when @p client_margin &gt;=
=3D 0 (the client set</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * --server-probe with a value) it is used for every remote=2E Otherwise =
the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * server&#39;s =
advertised @c max_latency_diff is used when non-zero, falling back to</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * OOB_DEFAULT_LATENCY_MA=
RGIN_MS=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+int oob_effective_margin(=
const struct oob_probe_result *r, int client_margin);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* OOB_H */</spa=
n><br><span>diff --git a/tests/unit_tests/openvpn/test_oob=2Ec b/tests/unit=
_tests/openvpn/test_oob=2Ec</span><br><span>index 1029399=2E=2Eb66ade2 1006=
44</span><br><span>--- a/tests/unit_tests/openvpn/test_oob=2Ec</span><br><s=
pan>+++ b/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>@@ -429,6 +=
429,144 @@</span><br><span>     gc_free(&amp;gc);</span><br><span> }</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Deter=
ministic RNG stubs for the weighted-selection ordering=2E rank_rng_zero</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * makes the weighted d=
raw always pick the first remaining candidate, preserving</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * order; rank_rng_fixed returns a va=
lue we set to land in a chosen weight slice=2E */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static long</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+rank_rng_zero(void)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+static long rank_rng_value;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+static long</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+rank_rng_fixed(void)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    return rank_rng_value;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Responde=
rs rank ahead of non-responders regardless of index order=2E */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+test_rank_responder_before_nonresponder=
(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =
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
int</span><br><span> main(void)</span><br><span> {</span><br><span>@@ -452,=
6 +590,12 @@</span><br><span>         cmocka_unit_test(test_client_reply_re=
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
ay:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I55da68cc341b=
cfc707fd34ca2f84ff9b6a55501f </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Number: 1746 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>

</body></html>
--ywD4Iu1UKjw=--


--===============6103127095243849514==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6103127095243849514==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6103127095243849514==--

