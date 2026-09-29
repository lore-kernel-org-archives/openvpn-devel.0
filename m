Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8380ECA5FA1
	for <openvpn-devel@archiver.kernel.org>; Tue, 29 Sep 2026 13:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v7aZS0v1J6mSvpsIsmeIZiasQw94b/NkDDrwVsrwP5s=; b=NUxBQ7E4/4jYUOhgtD7Fg64t6v
	fgLMCG1f0NY/VIfGRyPorsKyUpLebdNzSV7UjXj520KRvZKFVKSS8Bvku+v970hsEmjrG4wgaUOsr
	M6YB9I9RaHxrYU84jbJ9fxWWDzIx0N9ZA7sgBoNc5ST4wmmpwj/NrDlBvwfRBNILcMgM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBXhf-0003ch-17;
	Tue, 29 Sep 2026 13:17:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBXhc-0003cL-M7
 for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 13:17:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=6ncj/8WZD1plDMEg+PKcQwxSDSWfdAIsXOBfD8f3DNw=; b=FjsaN2r7LCe1SRMj2Y7PN3zxZ7
 14jSpaRaRXbWpq74gxnx2DRlyou5CGLM+5mVxtJ4eg2ItH7i6H7wCy6J535KrrphfzNLtw6iYCROt
 8p+Oqp4jqUP499I1u81+xrHEiuUuiBVZeRHHE489b4g8CN7PzaeLur09KINUdwK6SpYM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6ncj/8WZD1plDMEg+PKcQwxSDSWfdAIsXOBfD8f3DNw=; b=c
 hvOxeXFBu5qawUdWrtlrTPShqk+mBrjSCtSMi0N7nURpp1M1fEpIxh77EM3+TtFosfVWFXh8r3gtl
 CtUzvsSboXnzZqng0HZH0VgR1MCeZas6lfysYKpj5/6dW18Pqdw99rR9N6bWp9XnSjXHpICgPpBCY
 6jAHz+IXDlFafiPE=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBXha-0001Fc-NE for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 13:17:00 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e7bcb94d3so31348965e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 29 Sep 2026 06:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790687812; x=1791292612; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6ncj/8WZD1plDMEg+PKcQwxSDSWfdAIsXOBfD8f3DNw=;
 b=f0Ub3zMBxBG+pXs+voRbBxW/vKNGWYOwwYRUpg0UheVAWMCwWmqZ3UM7CVlXBgKQ/B
 OEZtw9tAwqMYKcgRnPi7Rlsvq0bNk4lrGqSccztRhlvlZ8bn0wsQ5El75GrvNP4IPfoz
 M8zfVBIyVTbRRypkpRydhuQ6oVVd7/6uERKN7X9dzcu4ywVjQWMIk+C+60v/MsJdVKt2
 m7pl+Q9XTdPzfiZRklSYU7WKS3eJ7vpPv1Nu2Fj8MygEXMBRiBbCwoM8TVHsI/4AjniQ
 3HdPTcIBNquEO6+6S2XwM4cUFIM+z+zmr5qcLK9nYUN0bqsZhD7sya/yNLZXqTVAO7qy
 nZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790687812; x=1791292612;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6ncj/8WZD1plDMEg+PKcQwxSDSWfdAIsXOBfD8f3DNw=;
 b=IZSFbXeJn6qcn9Lj0jecS2zJmyUFQHZjT10i2SlSIjP3lVaZ3MaMPcePK1o4Qa+9mK
 OxKyUdoGGkrJhGedKK15KPMNur5l3CZo4P10HIUSPnDFlN+BZTfZN0XdXeue+x2ZWs6b
 ERYvLzkkoyFownbAdnANcD+MeiDkqqV1KBEpsSiUqyAnt832wr7Ha100MmfdJriU3j0p
 3OaN4gYduV5mh8Tx0gyDukoUcekr7c8fandeZeFMlZUWsdNWHdZqHU7JJld7zcWhggWZ
 NTNqCqdarzBbtL1qoTJ8q/e8XXgBNK7NCoHyy/L4q+5S19rkbHgP6u+q5y7eMr3KQPy0
 IwQA==
X-Gm-Message-State: AFuF++monp7T2cpJZfU6duU2NU/XFZ9/kyPJLIOAZCo8otYe+/gw6/zX
 NPwiqigYn1ALrEO5Et8zxfG8eCJHVEQg3uDpjS3Z26dbS6343TPLIoFAAQB5d3JUO6Wd+kj6ZM6
 80nBOcYOZYrEzDZ1JArXn/qJfssi0SdIfsP5aQGpfR/6rcOAC0Atwes+zUWWZVJOYRiBGNAEcEw
 WsYXMFuw==
X-Gm-Gg: AYBFou2LHTja1DDQ4owW3YUocPzZwnMIdreXQehyUAKBZUdBJ9nI3GCEQQZDc2weguB
 M19d2AGVvsOqB0R/tLGkg8tEFjuiPA75sS7AvEXL/rWD0VBE737Zbk+UsJ8+yNZMKFJAuMVGnRE
 /trzVmF6QntxZlVfTeWkq0zPYr2S9IDfCPy/1Ok+eqWERcMsAvYcjdjLJGezHTpZS8vId4ufAOP
 EE6v0qBiYyhHFNN6Rn2+G7HfjWyRtu7Hkxh/2g3HEm2ehNlcLVOuBufpwbRUTRMbM72T4nJnjiU
 +Wv70UQgyM9TNKgl6jwwQ3gJvzJTOTpUeE1KrEh00VmS7O/CCldRKK5CLzZd715zkugDn0ezIyV
 v4hDkFa9IutVx4S/QhDPlLORDdyGhVzLfmk9gJ7jxCBvq5ght0KuPZ3w0a8F8NIqDKnRwZJJBfS
 UDO9JOA5TPsmsZrcTcTkdY5TbXoxWzkPe3tyEIMcqNtEJqgDXo1ZYPcqfhkBkBY7AZ4yoLqKLME
 mMyFLIi0JG6qHpqOtd0QbypDNBfNdSKVeJ/Er/gdP3l796MZ+moy1WUhWKRnJrXTUS+h5atB2ce
 orpeG6dB75ChKtn5vjMIc2hBMw8oex+tDI81B8rohfeZkCCMDSqLkgYwl5cI
X-Received: by 2002:a05:600c:4745:b0:49d:10d6:fd55 with SMTP id
 5b1f17b1804b1-49fe66abd7fmr289236775e9.1.1790687811685; 
 Tue, 29 Sep 2026 06:16:51 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af4f8b1eesm4256484f8f.3.2026.09.29.06.16.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 06:16:51 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 29 Sep 2026 13:16:31 +0000
To: ralf_lici <ralf@mandelbit.com>,
	plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 29
X-Gerrit-Change-Id: I375a41749060b7d006647bc27002c55436c8a8bb
X-Gerrit-Change-Number: 1748
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1748?usp=email>
X-Gerrit-Commit: a21ebd439617e669c6b67e2b1dbfbc5f82f708aa
In-Reply-To: <gerrit.1782719911000.I375a41749060b7d006647bc27002c55436c8a8bb@gerrit.openvpn.net>
References: <gerrit.1782719911000.I375a41749060b7d006647bc27002c55436c8a8bb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkzNzVhNDE3NDkwNjBiN2QwMDY2NDdiYzI3MDAyYzU1NDM2YzhhOGJiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d0dd4f659df08f5350c7ee5214cdc8a2ceccbf7e-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBXha-0001Fc-NE
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Measure probe
 RTT for candidate-band selection
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
Content-Type: multipart/mixed; boundary="===============5873274904322567581=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5873274904322567581==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qqEvwoWoRqk="; charset=UTF-8

--qqEvwoWoRqk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici, stipa=2E

Hello=
 plaisthos, ralf_lici, 

I'd like you to reexamine a change=2E Please visit=


    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1748?usp=3Demail

to look a=
t the new patch set (#29)=2E

The following approvals got outdated and were=
 removed:
Code-Review-1 by ralf_lici


Change subject: oob: Measure probe R=
TT for candidate-band selection
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

oob: Measure probe RTT for candidate-band selection

Un=
til now the client never measured RTT, so every responder sat in the
candid=
ate band and selection was purely weighted-random=2E

Record each probe's r=
ound-trip time (the send time of the transmission a
reply answers vs the re=
ply's arrival) and feed it to
oob_rank_probe_results(), where RTT forms the=
 candidate band: responders
within the effective margin of the fastest comp=
ete on weight, slower
ones fall behind=2E Log the measured RTT and the effe=
ctive margin (with
its source: client or server-advertised) at verb 4=2E

A=
 reply names the probe it answers by its request_id, so a reply to a
resend=
 is measured from the resend and a late reply to the first send
still reads=
 as slow=2E A reply whose request_id names no probe sent to
its source addr=
ess is dropped=2E Entries that resolve to the same address
share the one pr=
obe, and so its RTT=2E

The RTT runs up to the moment the client reads the =
reply: it compares
servers, it is not a network measurement=2E

Change-Id: =
I375a41749060b7d006647bc27002c55436c8a8bb
Signed-off-by: Lev Stipakov <lev@=
openvpn=2Enet>
---
M doc/man-sections/client-options=2Erst
M src/openvpn/oo=
b=2Ec
M src/openvpn/oob=2Eh
M src/openvpn/oob_client=2Ec
M tests/unit_tests=
/openvpn/test_oob=2Ec
5 files changed, 109 insertions(+), 16 deletions(-)

=

  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/48/1748=
/29

diff --git a/doc/man-sections/client-options=2Erst b/doc/man-sections/=
client-options=2Erst
index c49d184=2E=2E9835403 100644
--- a/doc/man-sectio=
ns/client-options=2Erst
+++ b/doc/man-sections/client-options=2Erst
@@ -608=
,9 +608,17 @@
   remote, and each answering server replies with its adverti=
sed priority
   and weight=2E Remotes are then reordered following DNS SRV =
(RFC 2782)
   semantics: servers that answered are tried before those that =
did not,
-  grouped by priority (lowest first); within a priority group, se=
rvers are
-  picked by weighted-random selection=2E Round-trip time is not =
yet taken
-  into account, so ``max-latency-diff`` has no effect for now=2E=

+  grouped by priority (lowest first); within a priority group, servers
+ =
 whose measured round-trip time is within ``max-latency-diff``
+  milliseco=
nds of the fastest one are picked by weighted-random
+  selection, the othe=
rs follow in round-trip-time order=2E When
+  ``max-latency-diff`` is not g=
iven, the margin advertised by the fastest
+  server of a priority group ap=
plies to that group; the margins of the
+  slower servers play no part=2E A=
 server advertising :code:`0` thus says
+  that, when it is the fastest, on=
ly servers tying it count as equal=2E A
+  value of :code:`1000` or more ma=
kes every answering server of a
+  priority group a candidate, since replie=
s only arrive within the
+  one-second probe window; the group is then orde=
red by weight alone=2E
 
   The probe is currently sent without control-cha=
nnel wrapping, so it only
   works against a server configured without ``--=
tls-auth``,
diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec
index 57=
81970=2E=2E20e3fe2 100644
--- a/src/openvpn/oob=2Ec
+++ b/src/openvpn/oob=
=2Ec
@@ -133,6 +133,20 @@
     return -1;
 }
 
+int
+oob_probe_rtt_ms(const=
 struct oob_probe_send *sends, int n_sends, uint32_t index,
+              =
   const struct openvpn_sockaddr *from, const struct timeval *rcv)
+{
+    =
if (index >=3D (uint32_t)n_sends || !addr_port_match(from, &sends[index]=2E=
dest))
+    {
+        return -1; /* not a probe we sent, or not to where t=
he reply came from */
+    }
+    const struct timeval *sent_at =3D &sends[=
index]=2Esent_at;
+    const long ms =3D (long)(rcv->tv_sec - sent_at->tv_s=
ec) * 1000
+                    + (rcv->tv_usec - sent_at->tv_usec) / 1000;=

+    return (ms > 0) ? (int)ms : 0;
+}
+
 /* Base ordering: responders bef=
ore non-responders, then by priority (lower
  * first), then by RTT (lower =
first), then by original index for determinism=2E
  * This groups responder=
s into priority runs pre-sorted by RTT, which the
diff --git a/src/openvpn/=
oob=2Eh b/src/openvpn/oob=2Eh
index 4260703=2E=2E0070904 100644
--- a/src/o=
penvpn/oob=2Eh
+++ b/src/openvpn/oob=2Eh
@@ -184,9 +184,25 @@
 struct oob_p=
robe_send
 {
     struct openvpn_sockaddr dest;
+    struct timeval sent_at=
;
 };
 
 /**
+ * Round-trip time of a reply, measured from the transmission=
 it answers=2E
+ *
+ * @param sends    every transmission so far
+ * @param=
 n_sends  number of transmissions
+ * @param index    the transmission the =
reply names: its request_id minus the
+ *                 run's base
+ * @p=
aram from     source address of the reply
+ * @param rcv      when the repl=
y arrived
+ * @return milliseconds (0 if the clock went backwards), or -1 i=
f index names
+ *         no transmission to from
+ */
+int oob_probe_rtt_m=
s(const struct oob_probe_send *sends, int n_sends, uint32_t index,
+       =
              const struct openvpn_sockaddr *from, const struct timeval *rc=
v);
+
+/**
  * Find the next entry, from index \p start on, that was probed=
 at \p from and
  * has not answered yet=2E Several entries can resolve to =
the same address, so a
  * reply is credited to each of them: call again wi=
th the returned index + 1
diff --git a/src/openvpn/oob_client=2Ec b/src/ope=
nvpn/oob_client=2Ec
index bae2c74=2E=2E960acd2 100644
--- a/src/openvpn/oob=
_client=2Ec
+++ b/src/openvpn/oob_client=2Ec
@@ -115,21 +115,29 @@
     ret=
urn false;
 }
 
-/* Send a probe with the next request_id to dest; false if=
 it did not go out=2E */
+/* Send a probe with the next request_id to dest,=
 recording when it went out so
+ * a reply's RTT is measured from the trans=
mission it answers; false if it did
+ * not go out=2E */
 static bool
 oob_=
probe_send_to(struct probe_ctx *pc, socket_descriptor_t sd,
               =
    const struct openvpn_sockaddr *dest, socklen_t destlen)
 {
     ASSERT(=
pc->n_sends < pc->max_sends);
+    struct oob_probe_send *s =3D &pc->sends[=
pc->n_sends];
     struct buffer probe;
-    if (!oob_probe_build(pc, pc->i=
d_base + (uint32_t)pc->n_sends, &probe)
-        || sendto(sd, (const char =
*)BPTR(&probe), (int)BLEN(&probe), 0,
-                  (const struct sock=
addr *)dest, destlen)
-               < 0)
+    if (!oob_probe_build(pc, pc=
->id_base + (uint32_t)pc->n_sends, &probe))
     {
         return false;
 =
    }
-    pc->sends[pc->n_sends++]=2Edest =3D *dest;
+    openvpn_gettimeo=
fday(&s->sent_at, NULL);
+    if (sendto(sd, (const char *)BPTR(&probe), (i=
nt)BLEN(&probe), 0,
+               (const struct sockaddr *)dest, destlen)=

+        < 0)
+    {
+        return false;
+    }
+    s->dest =3D *dest;=

+    pc->n_sends++;
     return true;
 }
 
@@ -284,7 +292,7 @@
     }
 }
 =

-/* Parse one received datagram as a PROBE_REPLY and, if valid and matchin=
g one
+/* Parse one received datagram as a PROBE_REPLY and, if valid and an=
swering one
  * of the probes we sent, record the reply in results=2E */
 s=
tatic void
 oob_probe_handle_reply(const struct probe_ctx *pc, const uint8_=
t *data, int len,
@@ -308,11 +316,16 @@
     }
 
     /* The reply must ech=
o the request_id of a probe sent to the address it came
-     * from; with =
a random id_base that also rejects spoofed replies=2E */
-    const uint32_=
t index =3D reply=2Erequest_id - pc->id_base;
-    if (index >=3D (uint32_t=
)pc->n_sends || !addr_port_match(from, &pc->sends[index]=2Edest))
+     * f=
rom; with a random id_base that also rejects spoofed replies=2E The RTT
+  =
   * runs from that transmission to now, i=2Ee=2E including any time the re=
ply
+     * waited in the receive queue while we were still sending=2E */
+=
    struct timeval rcv;
+    openvpn_gettimeofday(&rcv, NULL);
+    const i=
nt ms =3D
+        oob_probe_rtt_ms(pc->sends, pc->n_sends, reply=2Erequest=
_id - pc->id_base, from, &rcv);
+    if (ms < 0)
     {
-        return;
+ =
       return; /* answers no probe we sent to that address */
     }
 
    =
 /* Credit the reply to every still-unanswered remote probed at its source
=
@@ -322,6 +335,7 @@
     while (i >=3D 0)
     {
         results[i]=2Eresp=
onded =3D true;
+        results[i]=2Ertt_ms =3D (unsigned int)ms;
        =
 results[i]=2Ereply =3D reply;
 
         i =3D oob_probe_next_target_at(fr=
om, targets, results, n, i + 1);
@@ -662,8 +676,16 @@
         if (results[=
i]=2Eresponded)
         {
             responded++;
-            msg(D_LOW=
, "server-probe: %s:%s answered (priority %d, weight %d)", ce->remote,
-   =
             ce->remote_port, results[i]=2Ereply=2Epriority, results[i]=2Er=
eply=2Eweight);
+            /* The margin this server advertised, or the c=
lient's override; only
+             * the fastest server's margin applies =
to its priority group=2E */
+            int client_margin =3D c->options=
=2Eserver_probe_latency_margin;
+            int margin =3D oob_effective_m=
argin(&results[i], client_margin);
+            const char *margin_src =3D =
client_margin >=3D 0 ? "client" : "server-advertised";
+            msg(D_L=
OW,
+                "server-probe: %s:%s answered (priority %d, weight %d,=
 rtt %u ms;"
+                " latency margin %d ms [%s])",
+             =
   ce->remote, ce->remote_port, results[i]=2Ereply=2Epriority, results[i]=
=2Ereply=2Eweight,
+                results[i]=2Ertt_ms, margin, margin_src=
);
         }
         else
         {
diff --git a/tests/unit_tests/openvp=
n/test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec
index ce5b0ab=2E=2Ee=
0fae4b 100644
--- a/tests/unit_tests/openvpn/test_oob=2Ec
+++ b/tests/unit_=
tests/openvpn/test_oob=2Ec
@@ -607,6 +607,38 @@
     assert_int_equal(oob_p=
robe_next_target_at(&a_other_port, targets, results, 3, 0), -1);
 }
 
+/* T=
he RTT of a reply is measured from the transmission its request_id names (a=
s
+ * an index into the transmissions), which must have gone to the address=
 the
+ * reply came from=2E */
+static void
+test_probe_rtt_from_answered_s=
end(void **state)
+{
+    struct openvpn_sockaddr a =3D v4_addr(0x7f000001,=
 1194);
+    struct openvpn_sockaddr b =3D v4_addr(0x7f000002, 1194);
+    =
/* A at t=3D0 ms, B at t=3D20 ms, then A again at t=3D500 ms (a resend) */
=
+    const struct oob_probe_send sends[3] =3D {
+        { =2Edest =3D a, =
=2Esent_at =3D { =2Etv_sec =3D 1000, =2Etv_usec =3D 0 } },
+        { =2Ede=
st =3D b, =2Esent_at =3D { =2Etv_sec =3D 1000, =2Etv_usec =3D 20000 } },
+ =
       { =2Edest =3D a, =2Esent_at =3D { =2Etv_sec =3D 1000, =2Etv_usec =3D=
 500000 } },
+    };
+    struct timeval rcv =3D { =2Etv_sec =3D 1000, =2Et=
v_usec =3D 520000 };
+
+    assert_int_equal(oob_probe_rtt_ms(sends, 3, 2, =
&a, &rcv), 20);  /* the resend */
+    assert_int_equal(oob_probe_rtt_ms(se=
nds, 3, 0, &a, &rcv), 520); /* the first send */
+    assert_int_equal(oob_=
probe_rtt_ms(sends, 3, 1, &b, &rcv), 500);
+
+    /* a transmission to anot=
her address, and ids we never sent (below the
+     * base, an id wraps to =
a huge index) */
+    assert_int_equal(oob_probe_rtt_ms(sends, 3, 1, &a, &r=
cv), -1);
+    assert_int_equal(oob_probe_rtt_ms(sends, 3, 3, &a, &rcv), -1=
);
+    assert_int_equal(oob_probe_rtt_ms(sends, 3, UINT32_MAX, &a, &rcv), =
-1);
+    assert_int_equal(oob_probe_rtt_ms(sends, 2, 2, &a, &rcv), -1);
+
=
+    /* a clock that went backwards reads as 0, not as a huge value */
+   =
 rcv=2Etv_usec =3D 0;
+    assert_int_equal(oob_probe_rtt_ms(sends, 3, 2, &=
a, &rcv), 0);
+}
+
 /* A PROBE_REPLY carrying a probe reply is found by the=
 client scan, with all
  * fields surviving=2E */
 static void
@@ -996,6 +1=
028,7 @@
         cmocka_unit_test(test_server_probe_check_no_request),
   =
      cmocka_unit_test(test_probe_reply_credits_every_entry_at_address),
  =
       cmocka_unit_test(test_probe_reply_matches_only_its_address),
+      =
  cmocka_unit_test(test_probe_rtt_from_answered_send),
         cmocka_unit=
_test(test_client_reply_read_finds_reply),
         cmocka_unit_test(test_c=
lient_reply_read_skips_unknown),
         cmocka_unit_test(test_client_repl=
y_read_rejects_unknown_mandatory),

-- 
To view, visit http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1748?usp=3Demail
To unsubscribe, or for help writing =
mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ger=
rit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
=
Gerrit-Change-Id: I375a41749060b7d006647bc27002c55436c8a8bb
Gerrit-Change-N=
umber: 1748
Gerrit-PatchSet: 29
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>=

Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: r=
alf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lis=
ts=2Esourceforge=2Enet>
Gerrit-Attention: ralf_lici <ralf@mandelbit=2Ecom>
=
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Attention: plaisthos=
 <arne-openvpn@rfc2549=2Eorg>

--qqEvwoWoRqk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici, stipa=2E </p>
<p>stipa <strong>=
uploaded patch set #29</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1748?usp=3Demail">View Change</a></p><p>T=
he following approvals got outdated and were removed:
Code-Review-1 by ralf=
_lici</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">oob: Measure probe RTT for candidate-band selection<=
br><br>Until now the client never measured RTT, so every responder sat in t=
he<br>candidate band and selection was purely weighted-random=2E<br><br>Rec=
ord each probe&#39;s round-trip time (the send time of the transmission a<b=
r>reply answers vs the reply&#39;s arrival) and feed it to<br>oob_rank_prob=
e_results(), where RTT forms the candidate band: responders<br>within the e=
ffective margin of the fastest compete on weight, slower<br>ones fall behin=
d=2E Log the measured RTT and the effective margin (with<br>its source: cli=
ent or server-advertised) at verb 4=2E<br><br>A reply names the probe it an=
swers by its request_id, so a reply to a<br>resend is measured from the res=
end and a late reply to the first send<br>still reads as slow=2E A reply wh=
ose request_id names no probe sent to<br>its source address is dropped=2E E=
ntries that resolve to the same address<br>share the one probe, and so its =
RTT=2E<br><br>The RTT runs up to the moment the client reads the reply: it =
compares<br>servers, it is not a network measurement=2E<br><br>Change-Id: I=
375a41749060b7d006647bc27002c55436c8a8bb<br>Signed-off-by: Lev Stipakov &lt=
;lev@openvpn=2Enet&gt;<br>---<br>M doc/man-sections/client-options=2Erst<br=
>M src/openvpn/oob=2Ec<br>M src/openvpn/oob=2Eh<br>M src/openvpn/oob_client=
=2Ec<br>M tests/unit_tests/openvpn/test_oob=2Ec<br>5 files changed, 109 ins=
ertions(+), 16 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t=2Eopenvpn=2Enet:29418/openvpn refs/changes/48/1748/29</pre><pre style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git =
a/doc/man-sections/client-options=2Erst b/doc/man-sections/client-options=
=2Erst</span><br><span>index c49d184=2E=2E9835403 100644</span><br><span>--=
- a/doc/man-sections/client-options=2Erst</span><br><span>+++ b/doc/man-sec=
tions/client-options=2Erst</span><br><span>@@ -608,9 +608,17 @@</span><br><=
span>   remote, and each answering server replies with its advertised prior=
ity</span><br><span>   and weight=2E Remotes are then reordered following D=
NS SRV (RFC 2782)</span><br><span>   semantics: servers that answered are t=
ried before those that did not,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-  grouped by priority (lowest first); within a priority group, se=
rvers are</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  picked by =
weighted-random selection=2E Round-trip time is not yet taken</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-  into account, so ``max-latency-di=
ff`` has no effect for now=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  grouped by priority (lowest first); within a priority group, se=
rvers</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  whose measur=
ed round-trip time is within ``max-latency-diff``</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  milliseconds of the fastest one are picked =
by weighted-random</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 selection, the others follow in round-trip-time order=2E When</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  ``max-latency-diff`` is not gi=
ven, the margin advertised by the fastest</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  server of a priority group applies to that group; t=
he margins of the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
slower servers play no part=2E A server advertising :code:`0` thus says</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  that, when it is the =
fastest, only servers tying it count as equal=2E A</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  value of :code:`1000` or more makes every =
answering server of a</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  priority group a candidate, since replies only arrive within the</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  one-second probe window;=
 the group is then ordered by weight alone=2E</span><br><span> </span><br><=
span>   The probe is currently sent without control-channel wrapping, so it=
 only</span><br><span>   works against a server configured without ``--tls-=
auth``,</span><br><span>diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=
=2Ec</span><br><span>index 5781970=2E=2E20e3fe2 100644</span><br><span>--- =
a/src/openvpn/oob=2Ec</span><br><span>+++ b/src/openvpn/oob=2Ec</span><br><=
span>@@ -133,6 +133,20 @@</span><br><span>     return -1;</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_rtt_ms=
(const struct oob_probe_send *sends, int n_sends, uint32_t index,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                 const struct=
 openvpn_sockaddr *from, const struct timeval *rcv)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (index &gt;=3D (uint32_t)n_sends || !addr_port_match=
(from, &amp;sends[index]=2Edest))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        return -1; /* not a probe we sent, or not to where the reply came f=
rom */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct timeval *s=
ent_at =3D &amp;sends[index]=2Esent_at;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    const long ms =3D (long)(rcv-&gt;tv_sec - sent_at-&=
gt;tv_sec) * 1000</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                  + (rcv-&gt;tv_usec - sent_at-&gt;tv_usec) / 1000;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    return (ms &gt; 0) ? (i=
nt)ms : 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* Base o=
rdering: responders before non-responders, then by priority (lower</span><b=
r><span>  * first), then by RTT (lower first), then by original index for d=
eterminism=2E</span><br><span>  * This groups responders into priority runs=
 pre-sorted by RTT, which the</span><br><span>diff --git a/src/openvpn/oob=
=2Eh b/src/openvpn/oob=2Eh</span><br><span>index 4260703=2E=2E0070904 10064=
4</span><br><span>--- a/src/openvpn/oob=2Eh</span><br><span>+++ b/src/openv=
pn/oob=2Eh</span><br><span>@@ -184,9 +184,25 @@</span><br><span> struct oob=
_probe_send</span><br><span> {</span><br><span>     struct openvpn_sockaddr=
 dest;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ti=
meval sent_at;</span><br><span> };</span><br><span> </span><br><span> /**</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Round-trip time of=
 a reply, measured from the transmission it answers=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @param sends    every transmission so far</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @param n_sends  number of tra=
nsmissions</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param=
 index    the transmission the reply names: its request_id minus the</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *                 run&#39=
;s base</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param fr=
om     source address of the reply</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * @param rcv      when the reply arrived</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @return milliseconds (0 if the cloc=
k went backwards), or -1 if index names</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *         no transmission to from</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+int oob_probe_rtt_ms(const struct oob_probe_send *sends,=
 int n_sends, uint32_t index,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                     const struct openvpn_sockaddr *from, const s=
truct timeval *rcv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><spa=
n>  * Find the next entry, from index \p start on, that was probed at \p fr=
om and</span><br><span>  * has not answered yet=2E Several entries can reso=
lve to the same address, so a</span><br><span>  * reply is credited to each=
 of them: call again with the returned index + 1</span><br><span>diff --git=
 a/src/openvpn/oob_client=2Ec b/src/openvpn/oob_client=2Ec</span><br><span>=
index bae2c74=2E=2E960acd2 100644</span><br><span>--- a/src/openvpn/oob_cli=
ent=2Ec</span><br><span>+++ b/src/openvpn/oob_client=2Ec</span><br><span>@@=
 -115,21 +115,29 @@</span><br><span>     return false;</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Se=
nd a probe with the next request_id to dest; false if it did not go out=2E =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Send a probe w=
ith the next request_id to dest, recording when it went out so</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * a reply&#39;s RTT is measured=
 from the transmission it answers; false if it did</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * not go out=2E */</span><br><span> static =
bool</span><br><span> oob_probe_send_to(struct probe_ctx *pc, socket_descri=
ptor_t sd,</span><br><span>                   const struct openvpn_sockaddr=
 *dest, socklen_t destlen)</span><br><span> {</span><br><span>     ASSERT(p=
c-&gt;n_sends &lt; pc-&gt;max_sends);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct oob_probe_send *s =3D &amp;pc-&gt;sends[pc-&gt=
;n_sends];</span><br><span>     struct buffer probe;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (!oob_probe_build(pc, pc-&gt;id_base=
 + (uint32_t)pc-&gt;n_sends, &amp;probe)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        || sendto(sd, (const char *)BPTR(&amp;probe), (i=
nt)BLEN(&amp;probe), 0,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                  (const struct sockaddr *)dest, destlen)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-               &lt; 0)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (!oob_probe_build(pc, pc-&g=
t;id_base + (uint32_t)pc-&gt;n_sends, &amp;probe))</span><br><span>     {</=
span><br><span>         return false;</span><br><span>     }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    pc-&gt;sends[pc-&gt;n_sends++]=
=2Edest =3D *dest;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   openvpn_gettimeofday(&amp;s-&gt;sent_at, NULL);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (sendto(sd, (const char *)BPTR(&amp;p=
robe), (int)BLEN(&amp;probe), 0,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+               (const struct sockaddr *)dest, destlen)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        &lt; 0)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        return false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    s-&gt;dest =3D *dest;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    pc-&gt;n_sends++;</span><br><span>     return=
 true;</span><br><span> }</span><br><span> </span><br><span>@@ -284,7 +292,=
7 @@</span><br><span>     }</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-/* Parse one received datagram a=
s a PROBE_REPLY and, if valid and matching one</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/* Parse one received datagram as a PROBE_REPLY =
and, if valid and answering one</span><br><span>  * of the probes we sent, =
record the reply in results=2E */</span><br><span> static void</span><br><s=
pan> oob_probe_handle_reply(const struct probe_ctx *pc, const uint8_t *data=
, int len,</span><br><span>@@ -308,11 +316,16 @@</span><br><span>     }</sp=
an><br><span> </span><br><span>     /* The reply must echo the request_id o=
f a probe sent to the address it came</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-     * from; with a random id_base that also rejects spoofe=
d replies=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    co=
nst uint32_t index =3D reply=2Erequest_id - pc-&gt;id_base;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    if (index &gt;=3D (uint32_t)pc-&g=
t;n_sends || !addr_port_match(from, &amp;pc-&gt;sends[index]=2Edest))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * from; with a rando=
m id_base that also rejects spoofed replies=2E The RTT</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * runs from that transmission to no=
w, i=2Ee=2E including any time the reply</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * waited in the receive queue while we were still=
 sending=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct timeval rcv;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   openvpn_gettimeofday(&amp;rcv, NULL);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const int ms =3D</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        oob_probe_rtt_ms(pc-&gt;sends, pc-&gt;n_sends=
, reply=2Erequest_id - pc-&gt;id_base, from, &amp;rcv);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (ms &lt; 0)</span><br><span>    =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        return; /* answ=
ers no probe we sent to that address */</span><br><span>     }</span><br><s=
pan> </span><br><span>     /* Credit the reply to every still-unanswered re=
mote probed at its source</span><br><span>@@ -322,6 +335,7 @@</span><br><sp=
an>     while (i &gt;=3D 0)</span><br><span>     {</span><br><span>        =
 results[i]=2Eresponded =3D true;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        results[i]=2Ertt_ms =3D (unsigned int)ms;</span><br><=
span>         results[i]=2Ereply =3D reply;</span><br><span> </span><br><sp=
an>         i =3D oob_probe_next_target_at(from, targets, results, n, i + 1=
);</span><br><span>@@ -662,8 +676,16 @@</span><br><span>         if (result=
s[i]=2Eresponded)</span><br><span>         {</span><br><span>             r=
esponded++;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  msg(D_LOW, &quot;server-probe: %s:%s answered (priority %d, weight %d)&qu=
ot;, ce-&gt;remote,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              ce-&gt;remote_port, results[i]=2Ereply=2Epriority, results[i]=
=2Ereply=2Eweight);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            /* The margin this server advertised, or the client&#39;s overr=
ide; only</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
   * the fastest server&#39;s margin applies to its priority group=2E */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            int client=
_margin =3D c-&gt;options=2Eserver_probe_latency_margin;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            int margin =3D oob_effecti=
ve_margin(&amp;results[i], client_margin);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            const char *margin_src =3D client_margin=
 &gt;=3D 0 ? &quot;client&quot; : &quot;server-advertised&quot;;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_LOW,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                &quot;serve=
r-probe: %s:%s answered (priority %d, weight %d, rtt %u ms;&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                &quot; latenc=
y margin %d ms [%s])&quot;,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                ce-&gt;remote, ce-&gt;remote_port, results[i]=2Erep=
ly=2Epriority, results[i]=2Ereply=2Eweight,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                results[i]=2Ertt_ms, margin, margin=
_src);</span><br><span>         }</span><br><span>         else</span><br><=
span>         {</span><br><span>diff --git a/tests/unit_tests/openvpn/test_=
oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>index ce5b0=
ab=2E=2Ee0fae4b 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_=
oob=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_oob=2Ec</span><=
br><span>@@ -607,6 +607,38 @@</span><br><span>     assert_int_equal(oob_pro=
be_next_target_at(&amp;a_other_port, targets, results, 3, 0), -1);</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/* The RTT of a reply is measured from the transmission its reques=
t_id names (as</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * an=
 index into the transmissions), which must have gone to the address the</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * reply came from=2E *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+test_probe_rtt_from_answer=
ed_send(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct openv=
pn_sockaddr a =3D v4_addr(0x7f000001, 1194);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct openvpn_sockaddr b =3D v4_addr(0x7f0000=
02, 1194);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* A =
at t=3D0 ms, B at t=3D20 ms, then A again at t=3D500 ms (a resend) */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct oob_prob=
e_send sends[3] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        { =2Edest =3D a, =2Esent_at =3D { =2Etv_sec =3D 1000, =2Etv_usec =
=3D 0 } },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
 =2Edest =3D b, =2Esent_at =3D { =2Etv_sec =3D 1000, =2Etv_usec =3D 20000 }=
 },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        { =2Edes=
t =3D a, =2Esent_at =3D { =2Etv_sec =3D 1000, =2Etv_usec =3D 500000 } },</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct timeval rcv =3D { =2Etv_=
sec =3D 1000, =2Etv_usec =3D 520000 };</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_int_equal(oob_probe_rtt_ms(sends, 3, 2, &amp;a, &amp;rcv), 20); =
 /* the resend */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_int_equal(oob_probe_rtt_ms(sends, 3, 0, &amp;a, &amp;rcv), 520); /=
* the first send */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_int_equal(oob_probe_rtt_ms(sends, 3, 1, &amp;b, &amp;rcv), 500);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* a transmission to another addre=
ss, and ids we never sent (below the</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     * base, an id wraps to a huge index) */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(oob_probe_rt=
t_ms(sends, 3, 1, &amp;a, &amp;rcv), -1);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_int_equal(oob_probe_rtt_ms(sends, 3, 3, &a=
mp;a, &amp;rcv), -1);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_int_equal(oob_probe_rtt_ms(sends, 3, UINT32_MAX, &amp;a, &amp;=
rcv), -1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_int_equal(oob_probe_rtt_ms(sends, 2, 2, &amp;a, &amp;rcv), -1);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* a clock that went backwards reads as 0, n=
ot as a huge value */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    rcv=2Etv_usec =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_int_equal(oob_probe_rtt_ms(sends, 3, 2, &amp;a, &amp;rcv)=
, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* A PROBE_REP=
LY carrying a probe reply is found by the client scan, with all</span><br><=
span>  * fields surviving=2E */</span><br><span> static void</span><br><spa=
n>@@ -996,6 +1028,7 @@</span><br><span>         cmocka_unit_test(test_serve=
r_probe_check_no_request),</span><br><span>         cmocka_unit_test(test_p=
robe_reply_credits_every_entry_at_address),</span><br><span>         cmocka=
_unit_test(test_probe_reply_matches_only_its_address),</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_probe_rtt_=
from_answered_send),</span><br><span>         cmocka_unit_test(test_client_=
reply_read_finds_reply),</span><br><span>         cmocka_unit_test(test_cli=
ent_reply_read_skips_unknown),</span><br><span>         cmocka_unit_test(te=
st_client_reply_read_rejects_unknown_mandatory),</span><br></pre><p>To view=
, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1748?usp=3Dema=
il">change 1748</a>=2E To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings=
</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
748?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<=
div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"di=
splay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerr=
it-Change-Id: I375a41749060b7d006647bc27002c55436c8a8bb </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1748 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 29 </div>
<div style=3D"display:none"> Gerrit-Owner=
: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>

</body></html>
--qqEvwoWoRqk=--


--===============5873274904322567581==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5873274904322567581==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5873274904322567581==--

