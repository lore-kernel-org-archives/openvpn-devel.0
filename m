Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 176A9CA5FAC
	for <openvpn-devel@archiver.kernel.org>; Tue, 29 Sep 2026 13:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fM4f3HyjMz5E6h8KGVIZX8q3ZuudVWfJGQYE1DsWCb0=; b=I7W5dB86U6orBGWs6bWpMzut6T
	G+1FsTcTvs9NDJ09dL1Sbt8Te0GgT5rig8S4x8s3qy5WWO3HYjvee4OW11LEJ7MHyz34VfSeYEShL
	Its68fLCPjPUMG+oe+xZD8gsFzZg+ZcnwCmMz7g5r4h05b4rx3E+pVr56IHNDPddjLNo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBXhr-0002vl-48;
	Tue, 29 Sep 2026 13:17:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBXhq-0002vZ-1x
 for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 13:17:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ylI0hTVvwJNwsFh+DvXXh2txH/WpxVhl+d2GHQQNO5s=; b=WcqlwFFUuFegvyD7tHc6/Ys0Ox
 H0chgMdy0vb0UiO1fYyjwi0Hn1yydEJ1Y+tfBs7Yz2yP0gOf2vxreP4DZc/S3HKIxOf1EULWdKpQ4
 Ikvona1sCTucwqn/zWGjkV8URNy/TG6w0oLdwZXauQR7mCOz9kLgqWqO5kes8hG/7xr4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ylI0hTVvwJNwsFh+DvXXh2txH/WpxVhl+d2GHQQNO5s=; b=Y
 TOLvIFkfmPEhjM2wkiEts1zZEiIgRFtFOM7BdJnHb5nFppe9jhM9mJhVBahVal4Szm7iZAurvseZm
 smkncdQaHc62vHi2SQ1KBJCvu1r4+cPuemuyjOpkZnDjgz5s0eW5KXnfY/1Pe9WDCkFqtgZg/L+9q
 UFjCRdpytOtFk64o=;
Received: from mail-wr2-f34.google.com ([74.125.225.98])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBXhk-0001G2-Dn for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 13:17:11 +0000
Received: by mail-wr2-f34.google.com with SMTP id
 ffacd0b85a97d-48af5ae31d8so462844f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 29 Sep 2026 06:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790687822; x=1791292622; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ylI0hTVvwJNwsFh+DvXXh2txH/WpxVhl+d2GHQQNO5s=;
 b=HTZLN58EGtwGl8sxc1nkLk02Ff685XcEV2vHjBMKeQstFTGf/lUravJMmdjmvLt+tw
 qir12ThEDMpWESLXls1zpoiSi7ZSAbeyXqyR/KVu3lp3tVgZNt7PjOYWvWo5BNyyL+E1
 6Coe9yNpiBGnwdQm6MPRw7VEC/uawGX3JviBTFVpWF+Vo1LhDUmVMaq8Z2xAMO/mNPNL
 Zu3mqQXF2+KWWHl/nDrJ09+1B6p2S1Z7lcUQjV7XbTRQAsE4KLYsfglBZ8qhRGhKmCNn
 PRKJGZ14d907hHfXbJgUc7bJ2ezj2ZAbuekjjCSagPop+PIP3aXUKnzAafw/RWZyhJgR
 jloA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790687822; x=1791292622;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ylI0hTVvwJNwsFh+DvXXh2txH/WpxVhl+d2GHQQNO5s=;
 b=pJn4JjL2Vv76JlA/aq1Dv7M7UQBnKRR+U7OinBhPMzT3tky9wwJjRoD6HmcyP91Zzw
 Cog3TkgH3DCCAymxxVzK2CifbZHSqK6Udgzglyr3V/06fEZ895YE36X3eB4hza9Af8Oy
 OaZd4dX6f+QegzEzBLzJhznlc02RMfczqS7/Ctm8eM1JkCda3keMMKeH20ihqMc4vtUE
 G/Hmd9BShsilRHaHhd7KVkOFJVkrZzf7b+P0WB2qC9ZK/MnGC5bOchoSDjqYGB9jsjwG
 7ekiWBTPkSu4hNe7dic5FaGjWLg9LU6Oo9Cq3uMJqjXRo7WHUEHi9gT1uh0QSrSB8TEU
 sWog==
X-Gm-Message-State: AFq9FYK2yN/EgUjsAXLkERJiwYxiyIjbJYC5mPFFEQXIaLIyax7dui//
 edfSV3SIl53B9pjmuB2YhcNoMrYQIvqhgo77robScG3MJ1k8/nQ+rAM1NC3/XXW+pi1Hk5oB23Q
 9Ya+LZ+kLILGqpkMwp7EVbmtiJQKxfL7uyKbEifB0EqUrfPCjpWuDSkJwx66hlRRlZ9iExzJ0PV
 7HNTjaQA==
X-Gm-Gg: AYBFou21f0pXx1b/4rocGWEuVrO3oE4syr6Wco6O0CdDsaOo2mA/3irnmwDpptkVsM/
 U4kl2S/kzq1MVi+1GZ0zpw80vkLalM9INWwMsUNBfK2a9KbvPSEJxV6bAO3EaInLzwcsIyFhQBx
 ctdNzR5Y9Ocgo74ma5VEo0If2zGPWjBJJHLXwmXpFLIdeGiEi7EB5m84YymgLg/4vy1kyT69n6d
 K6m5tM+roKaDROikmy+NXXTF6jEiqROxtbkT4TcPqMZMshWUbVbzYDcwNODhWN7cbJUc1eApIW7
 OjsQ9h6NOgUcomp4hGujzD8YgBMob8PS9zv9SIQESTQSXwXwjOHMZIwBRlVimT/P/jMPz2gK1Pb
 9+TO8fuKYw9d84mFOEwwlBKDY0KQqPttOW3NGFUQ0yG02NGXDEc1wXFU6n+2Zq6Xe46TJLbo7fg
 tjSekx85aAEifjpiQAXrrqWibxi/z5L+AADJGj9aFSPVTx78CXenepmhCVVdd2kPaBCXT1tsVkA
 0/EyXMFlNuyi9eCC7I7FasysdRJJUsyWv4IkmCde36wqB65LuWgZ3Ix1waT/fMwIfjfPIBrWskK
 M3ABWxd5wLFNa3q0SXmHtxgT1ZIcaB3KBAI+MTGLHCQAh0LzqtcFl4i1R0G3Kg==
X-Received: by 2002:a05:6000:41ce:b0:488:8525:4979 with SMTP id
 ffacd0b85a97d-48885254a36mr17786333f8f.45.1790687821154; 
 Tue, 29 Sep 2026 06:17:01 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af508bb41sm4088999f8f.28.2026.09.29.06.17.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 06:17:00 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 29 Sep 2026 13:16:31 +0000
To: ralf_lici <ralf@mandelbit.com>,
	plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 31
X-Gerrit-Change-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8
X-Gerrit-Change-Number: 1752
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1752?usp=email>
X-Gerrit-Commit: 97d8e15031ba874a20c45b5a6b78e04d6a5ed5b7
In-Reply-To: <gerrit.1782719911000.Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8@gerrit.openvpn.net>
References: <gerrit.1782719911000.Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklkNzRjZmFlN2U5ZDY5MDI5ZDJkZGJmNjM1ZWU4NWEyYTZjZWRjM2Q4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <33daf3e50d6ac1d798d624b1d93889941b5a7e22-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBXhk-0001G2-Dn
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Add
 --server-probe-reply to advertise probe reply values
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
Content-Type: multipart/mixed; boundary="===============2185463496173546285=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2185463496173546285==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qpCZG0QDnnE="; charset=UTF-8

--qpCZG0QDnnE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici=2E

Hello plaist=
hos, ralf_lici, 

I'd like you to reexamine a change=2E Please visit

    h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752?usp=3Demail

to look at the n=
ew patch set (#31)=2E


Change subject: oob: Add --server-probe-reply to ad=
vertise probe reply values
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

oob: Add --server-probe-reply to advertise probe reply values=


Add a server option, --server-probe-reply max-latency-diff [weight]
[prio=
], setting the values the server returns in its OOB PROBE_REPLY;
the client=
 already ranks remotes by them=2E An unconfigured server
advertises weight =
50, priority 100 and a 10 ms max-latency-diff=2E

max-latency-diff is how m=
uch slower than the fastest server a server may
be and still count as equal=
ly good; 0 keeps only the servers whose
measured RTT ties the fastest as ca=
ndidates, with weight still splitting
exact ties=2E

Also add the 2=2E8 cha=
ngelog entry for the out-of-band probing feature=2E

Change-Id: Id74cfae7e9=
d69029d2ddbf635ee85a2a6cedc3d8
Signed-off-by: Lev Stipakov <lev@openvpn=2En=
et>
---
M Changes=2Emd
M doc/man-sections/server-options=2Erst
M src/openvp=
n/mudp=2Ec
M src/openvpn/oob=2Eh
M src/openvpn/options=2Ec
M src/openvpn/op=
tions=2Eh
6 files changed, 97 insertions(+), 5 deletions(-)


  git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/52/1752/31

diff --gi=
t a/Changes=2Emd b/Changes=2Emd
index 2684251=2E=2Ecb85456 100644
--- a/Cha=
nges=2Emd
+++ b/Changes=2Emd
@@ -1,5 +1,15 @@
 # Overview of changes in 2=
=2E8
 
+## New features
+
+* **Out-of-band server probing and server-contro=
lled selection**
+
+  With `--server-probe`, a client probes all configured=
 UDP remotes before
+  connecting and reorders them based on the replies: r=
eachable servers are tried
+  first, ordered by server-advertised priority,=
 measured latency and advertised
+  weight with DNS-SRV-like semantics=2E S=
ervers advertise these values with
+  `--server-probe-reply`=2E
+
 ## User-=
visible Changes
 
 * **Parsing Distinguished Names in certificates**
diff -=
-git a/doc/man-sections/server-options=2Erst b/doc/man-sections/server-opti=
ons=2Erst
index 9dfa6bd=2E=2Ebf030d7 100644
--- a/doc/man-sections/server-o=
ptions=2Erst
+++ b/doc/man-sections/server-options=2Erst
@@ -662,6 +662,39 =
@@
   Pushing of the ``--tun-ipv6`` directive is done for older clients whi=
ch
   require an explicit ``--tun-ipv6`` in their configuration=2E
 
+--ser=
ver-probe-reply args
+  Set the values a server advertises in its replies t=
o out-of-band
+  probes from clients using ``--server-probe``=2E
+
+  Valid=
 syntaxes::
+
+     server-probe-reply max-latency-diff
+     server-probe-=
reply max-latency-diff weight
+     server-probe-reply max-latency-diff wei=
ght priority
+
+  ``max-latency-diff`` is the candidate-band margin in mill=
iseconds that
+  *this* server announces=2E When it is the fastest server o=
f its priority
+  group, a probing client treats every server within that m=
argin of it as
+  equal and picks among them by ``weight``; the margin of a=
 slower server
+  has no effect=2E The default is :code:`10`; :code:`0` mea=
ns only servers
+  tying it exactly count as equal, and ``weight`` still di=
stributes load
+  between those=2E A client that sets its own margin with `=
`--server-probe``
+  overrides every advertised value=2E
+
+  ``weight`` (d=
efault :code:`50`) and ``priority`` (default :code:`100`)
+  have DNS SRV (=
RFC 2782) semantics: clients try servers with a lower
+  priority value fir=
st (lower is better), and distribute load between
+  equally-good servers o=
f the same priority proportionally to their
+  weights=2E
+
+  All values a=
re in the range :code:`0` to :code:`65535`=2E A UDP server
+  answers probe=
s by default, whether or not this option is given, and
+  the values above =
only change what it advertises=2E Replies are stateless
+  and rate-limited=
=2E A probe whose timestamp is more than ``--hand-window``
+  away from the=
 server's clock is answered only within a small budget, a
+  twentieth of `=
`--connect-freq-initial``, so a client with a wrong clock
+  can still prob=
e while a replayed probe is answered at most that often=2E
+
 --stale-route=
s-check args
   Remove routes which haven't had activity for ``n`` seconds =
(i=2Ee=2E the ageing
   time)=2E  This check is run every ``t`` seconds (i=
=2Ee=2E check interval)=2E
diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/=
mudp=2Ec
index 3d20d21=2E=2E767a692 100644
--- a/src/openvpn/mudp=2Ec
+++ b=
/src/openvpn/mudp=2Ec
@@ -258,8 +258,13 @@
             return false;
     =
    }
 
-        /* the reply echoes the probe's request_id */
-        str=
uct oob_probe_reply reply =3D { =2Erequest_id =3D req=2Erequest_id };
+    =
    /* the echo of the probe's request_id, plus what we advertise */
+     =
   struct oob_probe_reply reply =3D {
+            =2Erequest_id =3D req=2E=
request_id,
+            =2Epriority =3D m->top=2Eoptions=2Eserver_probe_re=
ply_priority,
+            =2Eweight =3D m->top=2Eoptions=2Eserver_probe_re=
ply_weight,
+            =2Emax_latency_diff =3D m->top=2Eoptions=2Eserver_=
probe_reply_max_latency_diff,
+        };
 
         /* Our session id is a=
 stateless SYN cookie (the same HMAC the three-way
          * handshake us=
es): we keep no per-probe state, and the reply can later
diff --git a/src/o=
penvpn/oob=2Eh b/src/openvpn/oob=2Eh
index f66a1dc=2E=2E2604ff1 100644
--- =
a/src/openvpn/oob=2Eh
+++ b/src/openvpn/oob=2Eh
@@ -159,6 +159,12 @@
 enum =
oob_probe_verdict oob_server_probe_check(struct buffer *probe_payload, uint=
64_t now,
                                               uint64_t window_se=
cs, struct oob_probe_request *req);
 
+/* Candidate-band margin (ms) a serv=
er advertises when --server-probe-reply does
+ * not set one=2E Announcing =
0 is a valid choice with a distinct meaning -- only
+ * servers tying the l=
owest latency are candidates -- so an unconfigured server
+ * has to announ=
ce something else; the spec suggests 10 to 20 ms=2E */
+#define OOB_DEFAULT=
_LATENCY_MARGIN_MS 10
+
 /* Outcome of probing one remote, used to order re=
motes best-first=2E @index is
  * the caller's identifier for the remote (e=
=2Eg=2E its position in the connection
  * list); priority/weight are only =
meaningful when @responded is true=2E */
diff --git a/src/openvpn/options=
=2Ec b/src/openvpn/options=2Ec
index 35ef2af=2E=2Ebcce808 100644
--- a/src/=
openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -44,6 +44,7 @@
 #inclu=
de "ssl=2Eh"
 #include "ssl_ncp=2Eh"
 #include "options=2Eh"
+#include "oob=
=2Eh"
 #include "misc=2Eh"
 #include "socket_util=2Eh"
 #include "packet_id=
=2Eh"
@@ -480,6 +481,8 @@
     "--auth-user-pass-optional : Allow connectio=
ns by clients that don't\n"
     "                  specify a username/pass=
word=2E\n"
     "--client-to-client : Internally route client-to-client tra=
ffic=2E\n"
+    "--server-probe-reply m [w [p]] : Advertise latency margin =
m (ms), weight w\n"
+    "                  and priority p in replies to --=
server-probe clients=2E\n"
     "--duplicate-cn  : Allow multiple clients w=
ith the same common name to\n"
     "                  concurrently connect=
=2E\n"
     "--client-connect cmd : Run command cmd on client connection=2E=
\n"
@@ -813,10 +816,15 @@
     o->ce=2Eproto =3D PROTO_UDP;
     o->ce=2Eaf=
 =3D AF_UNSPEC;
 
-    /* The client latency margin is -1 =3D "not set": th=
e client's value is
-     * authoritative when given, otherwise each server=
's advertised margin (or
-     * the built-in default) applies=2E */
+    /=
* server-probe defaults=2E The client latency margin is -1 =3D "not set": t=
he
+     * client's value is authoritative when given, otherwise the margin=
 advertised
+     * by the fastest server of a priority group applies to th=
at group=2E An
+     * (unconfigured) server advertises weight 50 / priorit=
y 100 and a margin of
+     * OOB_DEFAULT_LATENCY_MARGIN_MS=2E */
     o->s=
erver_probe_latency_margin =3D -1;
+    o->server_probe_reply_weight =3D 50=
;
+    o->server_probe_reply_priority =3D 100;
+    o->server_probe_reply_m=
ax_latency_diff =3D OOB_DEFAULT_LATENCY_MARGIN_MS;
     o->ce=2Ebind_ipv6_o=
nly =3D false;
     o->ce=2Econnect_retry_seconds =3D 1;
     o->ce=2Econne=
ct_retry_seconds_max =3D 300;
@@ -2005,6 +2013,7 @@
         MUST_BE_UNDEF(=
duplicate_cn, "duplicate-cn");
         MUST_BE_UNDEF(cf_max, "connect-freq=
");
         MUST_BE_UNDEF(cf_per, "connect-freq");
+        MUST_BE_UNDEF(=
server_probe_reply_defined, "server-probe-reply");
         MUST_BE_FALSE(o=
ptions->ssl_flags
                           & (SSLF_CLIENT_CERT_NOT_REQUIR=
ED | SSLF_CLIENT_CERT_OPTIONAL),
                       "verify-client-cert=
");
@@ -5105,6 +5114,27 @@
             options->server_probe_latency_margi=
n =3D margin;
         }
     }
+    else if (streq(p[0], "server-probe-rep=
ly") && p[1] && !p[4])
+    {
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+ =
       /* --server-probe-reply max-latency-diff [weight] [prio] */
+       =
 options->server_probe_reply_defined =3D true;
+        int vals[3] =3D { o=
ptions->server_probe_reply_max_latency_diff,
+                        optio=
ns->server_probe_reply_weight,
+                        options->server_pro=
be_reply_priority };
+        for (int i =3D 0; i < 3 && p[i + 1]; i++)
+  =
      {
+            vals[i] =3D positive_atoi(p[i + 1], msglevel);
+      =
      if (vals[i] > 0xffff)
+            {
+                msg(msglevel, "=
--server-probe-reply: values must be 0 to 65535");
+                goto er=
r;
+            }
+        }
+        options->server_probe_reply_max_laten=
cy_diff =3D (uint16_t)vals[0];
+        options->server_probe_reply_weight =
=3D (uint16_t)vals[1];
+        options->server_probe_reply_priority =3D (u=
int16_t)vals[2];
+    }
     else if (streq(p[0], "nice") && p[1] && !p[2])=

     {
         VERIFY_PERMISSION(OPT_P_NICE);
diff --git a/src/openvpn/op=
tions=2Eh b/src/openvpn/options=2Eh
index c2cde60=2E=2Ec228b3b 100644
--- a=
/src/openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -341,6 +341,14 @@=

     /* client: default candidate-band margin in ms (--server-probe [max-l=
atency-diff]):
      * servers within this RTT of the fastest are treated a=
s equally fast */
     int server_probe_latency_margin;
+    /* server: val=
ues advertised in the OOB PROBE_REPLY (--server-probe-reply)=2E
+     * pri=
ority/weight follow DNS-SRV semantics; max_latency_diff is the
+     * cand=
idate band this server asks clients to use (0 =3D only servers tying
+     =
* the fastest of the group are candidates)=2E */
+    uint16_t server_probe=
_reply_priority;
+    uint16_t server_probe_reply_weight;
+    uint16_t ser=
ver_probe_reply_max_latency_diff;
+    bool server_probe_reply_defined;
 
 =
    bool mlock;
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1752?usp=3Demail
To unsubscribe, or for help writing mail filters, vis=
it http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id:=
 Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8
Gerrit-Change-Number: 1752
Gerri=
t-PatchSet: 31
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer:=
 plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@ma=
ndelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Attention=
: plaisthos <arne-openvpn@rfc2549=2Eorg>

--qpCZG0QDnnE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici=2E </p>
<p>stipa <strong>uploade=
d patch set #31</strong> to this change=2E</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1752?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">oob: Add --server-probe-reply to advertise probe reply values<br><br>A=
dd a server option, --server-probe-reply max-latency-diff [weight]<br>[prio=
], setting the values the server returns in its OOB PROBE_REPLY;<br>the cli=
ent already ranks remotes by them=2E An unconfigured server<br>advertises w=
eight 50, priority 100 and a 10 ms max-latency-diff=2E<br><br>max-latency-d=
iff is how much slower than the fastest server a server may<br>be and still=
 count as equally good; 0 keeps only the servers whose<br>measured RTT ties=
 the fastest as candidates, with weight still splitting<br>exact ties=2E<br=
><br>Also add the 2=2E8 changelog entry for the out-of-band probing feature=
=2E<br><br>Change-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8<br>Signed-o=
ff-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M Changes=2Emd<br>M=
 doc/man-sections/server-options=2Erst<br>M src/openvpn/mudp=2Ec<br>M src/o=
penvpn/oob=2Eh<br>M src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br=
>6 files changed, 97 insertions(+), 5 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/52/175=
2/31</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/Changes=2Emd b/Changes=2Emd</span><br><span>index=
 2684251=2E=2Ecb85456 100644</span><br><span>--- a/Changes=2Emd</span><br><=
span>+++ b/Changes=2Emd</span><br><span>@@ -1,5 +1,15 @@</span><br><span> #=
 Overview of changes in 2=2E8</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+## New features</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+* **Out-of-band server probing and server-controlled selection**</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  With `--server-probe`, a client probes all=
 configured UDP remotes before</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  connecting and reorders them based on the replies: reachable s=
ervers are tried</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  f=
irst, ordered by server-advertised priority, measured latency and advertise=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  weight with DNS-=
SRV-like semantics=2E Servers advertise these values with</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  `--server-probe-reply`=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> ## User-vis=
ible Changes</span><br><span> </span><br><span> * **Parsing Distinguished N=
ames in certificates**</span><br><span>diff --git a/doc/man-sections/server=
-options=2Erst b/doc/man-sections/server-options=2Erst</span><br><span>inde=
x 9dfa6bd=2E=2Ebf030d7 100644</span><br><span>--- a/doc/man-sections/server=
-options=2Erst</span><br><span>+++ b/doc/man-sections/server-options=2Erst<=
/span><br><span>@@ -662,6 +662,39 @@</span><br><span>   Pushing of the ``--=
tun-ipv6`` directive is done for older clients which</span><br><span>   req=
uire an explicit ``--tun-ipv6`` in their configuration=2E</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+--server-probe-repl=
y args</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Set the val=
ues a server advertises in its replies to out-of-band</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  probes from clients using ``--server-pr=
obe``=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  Valid syntaxes::</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     server-probe-reply max-latency-diff</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     server-probe-reply max-l=
atency-diff weight</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    server-probe-reply max-latency-diff weight priority</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  ``max-latency-diff`` is the candidate-band margin in mil=
liseconds that</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  *th=
is* server announces=2E When it is the fastest server of its priority</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  group, a probing client=
 treats every server within that margin of it as</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  equal and picks among them by ``weight``; th=
e margin of a slower server</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  has no effect=2E The default is :code:`10`; :code:`0` means only =
servers</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  tying it e=
xactly count as equal, and ``weight`` still distributes load</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  between those=2E A client that s=
ets its own margin with ``--server-probe``</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  overrides every advertised value=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  ``weight`` (default :code:`50`) and ``priority`` (d=
efault :code:`100`)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  have DNS SRV (RFC 2782) semantics: clients try servers with a lower</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  priority value first (l=
ower is better), and distribute load between</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  equally-good servers of the same priority propor=
tionally to their</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
weights=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+  All values are in the rang=
e :code:`0` to :code:`65535`=2E A UDP server</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  answers probes by default, whether or not this o=
ption is given, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  the values above only change what it advertises=2E Replies are stateless<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  and rate-limited=
=2E A probe whose timestamp is more than ``--hand-window``</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  away from the server&#39;s clock i=
s answered only within a small budget, a</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  twentieth of ``--connect-freq-initial``, so a client=
 with a wrong clock</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  can still probe while a replayed probe is answered at most that often=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --=
stale-routes-check args</span><br><span>   Remove routes which haven&#39;t =
had activity for ``n`` seconds (i=2Ee=2E the ageing</span><br><span>   time=
)=2E  This check is run every ``t`` seconds (i=2Ee=2E check interval)=2E</s=
pan><br><span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</spa=
n><br><span>index 3d20d21=2E=2E767a692 100644</span><br><span>--- a/src/ope=
nvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@=
 -258,8 +258,13 @@</span><br><span>             return false;</span><br><sp=
an>         }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        /* the reply echoes the probe&#39;s request_id */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        struct oob_probe_repl=
y reply =3D { =2Erequest_id =3D req=2Erequest_id };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* the echo of the probe&#39;s re=
quest_id, plus what we advertise */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        struct oob_probe_reply reply =3D {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            =2Erequest_id =3D req=2E=
request_id,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    =2Epriority =3D m-&gt;top=2Eoptions=2Eserver_probe_reply_priority,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            =2Eweight =
=3D m-&gt;top=2Eoptions=2Eserver_probe_reply_weight,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            =2Emax_latency_diff =3D m-&gt=
;top=2Eoptions=2Eserver_probe_reply_max_latency_diff,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        };</span><br><span> </span><br><s=
pan>         /* Our session id is a stateless SYN cookie (the same HMAC the=
 three-way</span><br><span>          * handshake uses): we keep no per-prob=
e state, and the reply can later</span><br><span>diff --git a/src/openvpn/o=
ob=2Eh b/src/openvpn/oob=2Eh</span><br><span>index f66a1dc=2E=2E2604ff1 100=
644</span><br><span>--- a/src/openvpn/oob=2Eh</span><br><span>+++ b/src/ope=
nvpn/oob=2Eh</span><br><span>@@ -159,6 +159,12 @@</span><br><span> enum oob=
_probe_verdict oob_server_probe_check(struct buffer *probe_payload, uint64_=
t now,</span><br><span>                                               uint6=
4_t window_secs, struct oob_probe_request *req);</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/* Candidate-band margin (ms=
) a server advertises when --server-probe-reply does</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * not set one=2E Announcing 0 is a valid=
 choice with a distinct meaning -- only</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * servers tying the lowest latency are candidates -- s=
o an unconfigured server</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * has to announce something else; the spec suggests 10 to 20 ms=2E */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OOB_DEFAULT=
_LATENCY_MARGIN_MS 10</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span> /* Outcome of probing one remote, used to order remotes=
 best-first=2E @index is</span><br><span>  * the caller&#39;s identifier fo=
r the remote (e=2Eg=2E its position in the connection</span><br><span>  * l=
ist); priority/weight are only meaningful when @responded is true=2E */</sp=
an><br><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec=
</span><br><span>index 35ef2af=2E=2Ebcce808 100644</span><br><span>--- a/sr=
c/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><=
br><span>@@ -44,6 +44,7 @@</span><br><span> #include &quot;ssl=2Eh&quot;</s=
pan><br><span> #include &quot;ssl_ncp=2Eh&quot;</span><br><span> #include &=
quot;options=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#include &quot;oob=2Eh&quot;</span><br><span> #include &quot;misc=2Eh&qu=
ot;</span><br><span> #include &quot;socket_util=2Eh&quot;</span><br><span> =
#include &quot;packet_id=2Eh&quot;</span><br><span>@@ -480,6 +481,8 @@</spa=
n><br><span>     &quot;--auth-user-pass-optional : Allow connections by cli=
ents that don&#39;t\n&quot;</span><br><span>     &quot;                  sp=
ecify a username/password=2E\n&quot;</span><br><span>     &quot;--client-to=
-client : Internally route client-to-client traffic=2E\n&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    &quot;--server-probe-reply m=
 [w [p]] : Advertise latency margin m (ms), weight w\n&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    &quot;                  and pr=
iority p in replies to --server-probe clients=2E\n&quot;</span><br><span>  =
   &quot;--duplicate-cn  : Allow multiple clients with the same common name=
 to\n&quot;</span><br><span>     &quot;                  concurrently conne=
ct=2E\n&quot;</span><br><span>     &quot;--client-connect cmd : Run command=
 cmd on client connection=2E\n&quot;</span><br><span>@@ -813,10 +816,15 @@<=
/span><br><span>     o-&gt;ce=2Eproto =3D PROTO_UDP;</span><br><span>     o=
-&gt;ce=2Eaf =3D AF_UNSPEC;</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    /* The client latency margin is -1 =3D &quot;no=
t set&quot;: the client&#39;s value is</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-     * authoritative when given, otherwise each server&#39=
;s advertised margin (or</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-     * the built-in default) applies=2E */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* server-probe defaults=2E The client latenc=
y margin is -1 =3D &quot;not set&quot;: the</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * client&#39;s value is authoritative when giv=
en, otherwise the margin advertised</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * by the fastest server of a priority group applies to=
 that group=2E An</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   * (unconfigured) server advertises weight 50 / priority 100 and a margin=
 of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * OOB_DEFAU=
LT_LATENCY_MARGIN_MS=2E */</span><br><span>     o-&gt;server_probe_latency_=
margin =3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    o=
-&gt;server_probe_reply_weight =3D 50;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    o-&gt;server_probe_reply_priority =3D 100;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;server_probe_reply_=
max_latency_diff =3D OOB_DEFAULT_LATENCY_MARGIN_MS;</span><br><span>     o-=
&gt;ce=2Ebind_ipv6_only =3D false;</span><br><span>     o-&gt;ce=2Econnect_=
retry_seconds =3D 1;</span><br><span>     o-&gt;ce=2Econnect_retry_seconds_=
max =3D 300;</span><br><span>@@ -2005,6 +2013,7 @@</span><br><span>        =
 MUST_BE_UNDEF(duplicate_cn, &quot;duplicate-cn&quot;);</span><br><span>   =
      MUST_BE_UNDEF(cf_max, &quot;connect-freq&quot;);</span><br><span>    =
     MUST_BE_UNDEF(cf_per, &quot;connect-freq&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(server_probe_reply_=
defined, &quot;server-probe-reply&quot;);</span><br><span>         MUST_BE_=
FALSE(options-&gt;ssl_flags</span><br><span>                           &amp=
; (SSLF_CLIENT_CERT_NOT_REQUIRED | SSLF_CLIENT_CERT_OPTIONAL),</span><br><s=
pan>                       &quot;verify-client-cert&quot;);</span><br><span=
>@@ -5105,6 +5114,27 @@</span><br><span>             options-&gt;server_pro=
be_latency_margin =3D margin;</span><br><span>         }</span><br><span>  =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (st=
req(p[0], &quot;server-probe-reply&quot;) &amp;&amp; p[1] &amp;&amp; !p[4])=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_G=
ENERAL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* =
--server-probe-reply max-latency-diff [weight] [prio] */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        options-&gt;server_probe_reply=
_defined =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       int vals[3] =3D { options-&gt;server_probe_reply_max_latency_diff,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
   options-&gt;server_probe_reply_weight,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                        options-&gt;server_probe_repl=
y_priority };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  for (int i =3D 0; i &lt; 3 &amp;&amp; p[i + 1]; i++)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            vals[i] =3D positive_atoi(p[i + 1], ms=
glevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 if (vals[i] &gt; 0xffff)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                msg(msglevel, &quot;--server-probe-reply: values must be 0 =
to 65535&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        optio=
ns-&gt;server_probe_reply_max_latency_diff =3D (uint16_t)vals[0];</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;server_pr=
obe_reply_weight =3D (uint16_t)vals[1];</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        options-&gt;server_probe_reply_priority =3D (ui=
nt16_t)vals[2];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span>     else if (streq(p[0], &quot;nice&quot;) &amp;&amp; p[=
1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>         VERIFY=
_PERMISSION(OPT_P_NICE);</span><br><span>diff --git a/src/openvpn/options=
=2Eh b/src/openvpn/options=2Eh</span><br><span>index c2cde60=2E=2Ec228b3b 1=
00644</span><br><span>--- a/src/openvpn/options=2Eh</span><br><span>+++ b/s=
rc/openvpn/options=2Eh</span><br><span>@@ -341,6 +341,14 @@</span><br><span=
>     /* client: default candidate-band margin in ms (--server-probe [max-l=
atency-diff]):</span><br><span>      * servers within this RTT of the faste=
st are treated as equally fast */</span><br><span>     int server_probe_lat=
ency_margin;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =
server: values advertised in the OOB PROBE_REPLY (--server-probe-reply)=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * priority/weig=
ht follow DNS-SRV semantics; max_latency_diff is the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * candidate band this server asks cl=
ients to use (0 =3D only servers tying</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+     * the fastest of the group are candidates)=2E */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t server_pr=
obe_reply_priority;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    uint16_t server_probe_reply_weight;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    uint16_t server_probe_reply_max_latency_diff;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool server_probe_rep=
ly_defined;</span><br><span> </span><br><span>     bool mlock;</span><br></=
pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1752?usp=3Demail">change 1752</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eo=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1752?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpat=
chset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<d=
iv style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8 </div=
>
<div style=3D"display:none"> Gerrit-Change-Number: 1752 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 31 </div>
<div style=3D"display:none"> =
Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mande=
lbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>

</body></html>
--qpCZG0QDnnE=--


--===============2185463496173546285==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2185463496173546285==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2185463496173546285==--

