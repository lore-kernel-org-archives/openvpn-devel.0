Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E7CC61DCB
	for <openvpn-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Nl3Iv7UU6Bm8EmXWWivcgQFNXJ2CeLscjv1bFsE7gks=; b=TFU5JplmsJ1dtTpjCoTS+/nbqt
	D3tIyOs7j4MY2owPoQYbZnca5OugYaBbibDzwbuwoFMnarbhgx0698MGAJ+TVSSjdJfkp8v7VxMn2
	slK8eY9z0CV/DoQLEWGbJ2X85rwztsaqmb7ZvHYMIYcmrToiYSjUoVxutmqqPCuIY1E0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzw3O-0001IA-Mb;
	Fri, 28 Aug 2026 12:51:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzw3N-0001I0-Hu
 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 12:51:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=QrEUIs6FGAo+qvyiGQ1UecRzx9F0VX79Ie0OReZ/mXI=; b=BNT4btaAXoMTmSj0QObEuZRvtB
 eMpY23CU/hgcXfb5u5vqq6dkJ74F+DWyUpsC/O8Z3FuvywbbS2FE/3AwSLDqD+9cQF8Q3zJaXHmPT
 HA/hpIK3X8dJBamj+NyZsQ0gIVmzZzgdDm7aTJO096q9K6RJ/z+Lv5z/VBC7kqFGQn44=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=QrEUIs6FGAo+qvyiGQ1UecRzx9F0VX79Ie0OReZ/mXI=; b=m
 4mjUSy04agq7UdGzq8pMaWlaNU/hoDjQnTz0g9AyU1mqF5Ruoz6vzM3UUgMFEiTqKMW94EYNFMVNJ
 Jc5hWWnCLJ2QI88+IhxnaOOrzSQJADGk1mvYbd9Nb/5Eva8owZ6shaBXZboxE/2uT0L9J6F8RtkXf
 bPB5ekTdg9/crVMg=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzw3F-0005G2-IN for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 12:51:30 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-49b392ccaacso11163235e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 28 Aug 2026 05:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787921475; x=1788526275; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QrEUIs6FGAo+qvyiGQ1UecRzx9F0VX79Ie0OReZ/mXI=;
 b=Otiz0rt6YUXpIePDpmOp41DU9AJDVLtmhwQV1ihP/uddKANyV9Sp3GqeXSXWHXTV2b
 0S6/nlU8TjapP5R0rgwsxmf5+7Dop6OkBe0CB1fjPGopxdZr9Y4UxNIg5t8pGKFCGsr0
 dyxNO3tS78Lbs6auyDTnQvuDWTx7gvN5nDbDxlyqmBlklaMoRWw7Rg7GkiepLifUTC48
 8/USA/5UkstqP8bMWuW5hFZs1YnA0s5oiwkIeOwjuVNC5LGlDJ3vjFLh31IK4sCFJr7B
 q5mKDwFXUag651ea0wBuz+eRL90TN5H5uYYSOLqWeiXVusOrt/FzvyV08WouJS7tXXRB
 GOHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787921475; x=1788526275;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=QrEUIs6FGAo+qvyiGQ1UecRzx9F0VX79Ie0OReZ/mXI=;
 b=kKdpCQzlGIY7aTl+pZQpW0AJeHS9rJB8XrCBTddq5T6Nhhbh8NdJao4nalXQyT1xqx
 CpYJ84SWEq2RYsNu8FsWyU+P5vQFvPVKxDmkOU5e/sWrDNTJXXwk3FYtxEzzF2+kGO7H
 Tk7eyLngioZdHaIw+sMKQuc0vaXU9brqLC9ch7zsRBG59dBPvSgDfkcCF1Hlmmu1oyoK
 4UsOi7QdndPqeW2Dml0jh0vEl93NigUrc7wix1kTuiN/++BJo8qC7XJaulFmC+7WaVK0
 AmD9itjNZvHXFYvyY73O796bPF4uW44j4FPs0+/9KARvGuD6OxzjvDxbJ5YgvKIffw7O
 K1Nw==
X-Gm-Message-State: AFuF++m+1CXP2LETdOCmDR/Pieebl8ieXQ5Srx0ZS4T/nZ1EaM9en/xP
 WJFMDY/I7J4i9qFV336X72JXmfaKTw5ajgrLnkgSaNgk4zpk5zw+o/FOSlQ1IhNK2eJoDmhXh10
 DHZiEOZKqBhqRh6cvxqXPtFkzazNWBBavetkAlx4mPE5C9k3OoXhPq5lTP0VnubdZnXG+swY46h
 19ej3Ejg==
X-Gm-Gg: AR+sD12Zeejkm841cA1diw+ujQtSxwX1/OayCUzM9ux5ZXZ/ugni+SMs3qcZHXIqevM
 ag4QmW+qFxvheoRudTITWmC/kA8E0GK49jg06v/jurIOQz9OIvLL2vm9/d/csoKXuGhAYLu+2Fw
 iiQmmxmS9YRAIfrsRaMtbNJiPiNgF3IJU58l0O5x6jPd3Il52kbKE3VENRp+kCTsyjyJr0hiZc6
 5g2d8mN7PcYXxvsCyTLmHyohnX59uVt9QXDdBHIgPTIFSRusAOOCqU+PexfE9aoMegKsQHnmCBn
 V0uQYFu0Wxrcor2Y7g0ZWC0tojQM2A3NzTC0DMpSjEQxcBn34z+xwJswGJ4s/L+1J0i79CDwW8q
 Gbgqb3LQ48vcy0fSbBIpy7BinBMDet50szR4k9XiF+hFVVCQ8gTnD9+v8Fo+rSbukBYA3TzUl5j
 OUTY2trn/CIeLWo8YsTaowbbQTFE+zkNWMzyQEhfdm2NUmHESE10oEzgd/5psbbjQXNxYCum9rB
 lhsn2hpiw7xlTo5wvlikG2WFJn5b2LmunE/GYvurXAKTnoyfgKn3gN/aQXvG7mjnyUtiRTRv2AN
 0C2WBFqIFLPX+zKm/gOeJqayxYmar8KuriQMDdbTL/RD93WcfTkcGLh+TaWACQ==
X-Received: by 2002:a05:600c:8b35:b0:499:7a19:408b with SMTP id
 5b1f17b1804b1-49b91c3b71dmr103665235e9.11.1787921474791; 
 Fri, 28 Aug 2026 05:51:14 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b9500c80asm54976175e9.9.2026.08.28.05.51.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 05:51:14 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 28 Aug 2026 12:51:00 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 16
X-Gerrit-Change-Id: I375a41749060b7d006647bc27002c55436c8a8bb
X-Gerrit-Change-Number: 1748
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1748?usp=email>
X-Gerrit-Commit: 8b689f444c02eba9206eb383d7c0d3c426764bb1
In-Reply-To: <gerrit.1782719911000.I375a41749060b7d006647bc27002c55436c8a8bb@gerrit.openvpn.net>
References: <gerrit.1782719911000.I375a41749060b7d006647bc27002c55436c8a8bb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkzNzVhNDE3NDkwNjBiN2QwMDY2NDdiYzI3MDAyYzU1NDM2YzhhOGJiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <77e3879c171195fe2b59daf7b40a6d3d188b546d-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzw3F-0005G2-IN
Subject: [Openvpn-devel] [S] Change in openvpn[master]: oob: Measure probe
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
 openvpn-devel@lists.sourceforge.net
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4952737968738757216=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4952737968738757216==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FdxTyLN+49Y="; charset=UTF-8

--FdxTyLN+49Y=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1748?usp=3Demail

to look at the new patch set (#16)=2E
=


Change subject: oob: Measure probe RTT for candidate-band selection
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Measure pro=
be RTT for candidate-band selection

Record each probe's round-trip time (p=
er-target send timestamp vs reply
arrival) and feed it to oob_rank_probe_re=
sults(), where RTT forms the
candidate band: responders within the effectiv=
e margin of the fastest compete
on weight, slower ones fall behind=2E Log t=
he measured RTT and the effective
margin (with its source: client or server=
-advertised) at verb 4=2E

Before this the client never measured RTT, so ev=
ery responder sat in the band
and selection was purely weighted-random; wit=
h real measurements the
latency-based candidate selection takes effect=2E

=
Change-Id: I375a41749060b7d006647bc27002c55436c8a8bb
Signed-off-by: Lev Sti=
pakov <lev@openvpn=2Enet>
---
M doc/man-sections/client-options=2Erst
M src=
/openvpn/oob_client=2Ec
2 files changed, 26 insertions(+), 5 deletions(-)

=

  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/48/1748=
/16

diff --git a/doc/man-sections/client-options=2Erst b/doc/man-sections/=
client-options=2Erst
index 82e7b22=2E=2E8cf14f9 100644
--- a/doc/man-sectio=
ns/client-options=2Erst
+++ b/doc/man-sections/client-options=2Erst
@@ -608=
,9 +608,14 @@
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
iven, the margin advertised by the
+  answering server applies; a server ad=
vertising :code:`0` asks to be
+  compared on latency alone, so only the fa=
stest server of its priority
+  group is treated as best=2E
 
   The probe =
is currently sent without control-channel wrapping, so it only
   works aga=
inst a server configured without ``--tls-auth``,
diff --git a/src/openvpn/o=
ob_client=2Ec b/src/openvpn/oob_client=2Ec
index 4b8c576=2E=2E9bdc8cf 10064=
4
--- a/src/openvpn/oob_client=2Ec
+++ b/src/openvpn/oob_client=2Ec
@@ -56,=
6 +56,7 @@
     struct sockaddr_storage dest;
     socklen_t destlen;
     =
bool sent;
+    struct timeval sent_at; /* when the probe was sent, for RTT=
 measurement */
 };
 
 /* The probe uses one native socket per address fami=
ly, so every remote is probed
@@ -177,7 +178,13 @@
             && addr_por=
t_match((const struct openvpn_sockaddr *)(const void *)from,
              =
                  (const struct openvpn_sockaddr *)(const void *)&targets[i=
]=2Edest))
         {
+            struct timeval rcv;
+            openvpn=
_gettimeofday(&rcv, NULL);
+            long ms =3D (long)(rcv=2Etv_sec - t=
argets[i]=2Esent_at=2Etv_sec) * 1000
+                      + (rcv=2Etv_use=
c - targets[i]=2Esent_at=2Etv_usec) / 1000;
+
             results[i]=2Eres=
ponded =3D true;
+            results[i]=2Ertt_ms =3D (ms > 0) ? (unsigned =
int)ms : 0;
             results[i]=2Ereply =3D reply;
             break;
=
         }
@@ -432,6 +439,7 @@
             }
             else
           =
  {
+                openvpn_gettimeofday(&targets[i]=2Esent_at, NULL);
   =
              targets[i]=2Edestlen =3D destlen;
                 targets[i]=
=2Esent =3D true;
                 sent_count++;
@@ -454,8 +462,16 @@
     =
    if (results[i]=2Eresponded)
         {
             responded++;
-     =
       msg(D_LOW, "server-probe: %s:%s answered (priority %d, weight %d)", =
ce->remote,
-                ce->remote_port, results[i]=2Ereply=2Epriority=
, results[i]=2Ereply=2Eweight);
+            /* Effective candidate-band ma=
rgin and where it came from: the
+             * client's own setting wins,=
 else the server's advertised value=2E */
+            int client_margin =
=3D c->options=2Eserver_probe_latency_margin;
+            int margin =3D o=
ob_effective_margin(&results[i], client_margin);
+            const char *m=
argin_src =3D client_margin >=3D 0 ? "client" : "server-advertised";
+     =
       msg(D_LOW,
+                "server-probe: %s:%s answered (priority =
%d, weight %d, rtt %u ms;"
+                " latency margin %d ms [%s])",
=
+                ce->remote, ce->remote_port, results[i]=2Ereply=2Epriority=
, results[i]=2Ereply=2Eweight,
+                results[i]=2Ertt_ms, margin=
, margin_src);
         }
         else
         {

-- 
To view, visit http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1748?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: I375a41749060b7d006647bc27002c55436c8a8bb=

Gerrit-Change-Number: 1748
Gerrit-PatchSet: 16
Gerrit-Owner: stipa <lstipa=
kov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Att=
ention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--FdxTyLN+49Y=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #16</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1748?usp=3Demail">View Change</a></p><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">oob: Mea=
sure probe RTT for candidate-band selection<br><br>Record each probe&#39;s =
round-trip time (per-target send timestamp vs reply<br>arrival) and feed it=
 to oob_rank_probe_results(), where RTT forms the<br>candidate band: respon=
ders within the effective margin of the fastest compete<br>on weight, slowe=
r ones fall behind=2E Log the measured RTT and the effective<br>margin (wit=
h its source: client or server-advertised) at verb 4=2E<br><br>Before this =
the client never measured RTT, so every responder sat in the band<br>and se=
lection was purely weighted-random; with real measurements the<br>latency-b=
ased candidate selection takes effect=2E<br><br>Change-Id: I375a41749060b7d=
006647bc27002c55436c8a8bb<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2E=
net&gt;<br>---<br>M doc/man-sections/client-options=2Erst<br>M src/openvpn/=
oob_client=2Ec<br>2 files changed, 26 insertions(+), 5 deletions(-)<br><br>=
</pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn ref=
s/changes/48/1748/16</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/doc/man-sections/client-options=
=2Erst b/doc/man-sections/client-options=2Erst</span><br><span>index 82e7b2=
2=2E=2E8cf14f9 100644</span><br><span>--- a/doc/man-sections/client-options=
=2Erst</span><br><span>+++ b/doc/man-sections/client-options=2Erst</span><b=
r><span>@@ -608,9 +608,14 @@</span><br><span>   remote, and each answering =
server replies with its advertised priority</span><br><span>   and weight=
=2E Remotes are then reordered following DNS SRV (RFC 2782)</span><br><span=
>   semantics: servers that answered are tried before those that did not,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-  grouped by priority (=
lowest first); within a priority group, servers are</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  picked by weighted-random selection=2E Ro=
und-trip time is not yet taken</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-  into account, so ``max-latency-diff`` has no effect for now=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  grouped by priority=
 (lowest first); within a priority group, servers</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  whose measured round-trip time is within ``=
max-latency-diff``</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 milliseconds of the fastest one are picked by weighted-random</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  selection, the others follow i=
n round-trip-time order=2E When</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  ``max-latency-diff`` is not given, the margin advertised by t=
he</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  answering serve=
r applies; a server advertising :code:`0` asks to be</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  compared on latency alone, so only the =
fastest server of its priority</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  group is treated as best=2E</span><br><span> </span><br><span>=
   The probe is currently sent without control-channel wrapping, so it only=
</span><br><span>   works against a server configured without ``--tls-auth`=
`,</span><br><span>diff --git a/src/openvpn/oob_client=2Ec b/src/openvpn/oo=
b_client=2Ec</span><br><span>index 4b8c576=2E=2E9bdc8cf 100644</span><br><s=
pan>--- a/src/openvpn/oob_client=2Ec</span><br><span>+++ b/src/openvpn/oob_=
client=2Ec</span><br><span>@@ -56,6 +56,7 @@</span><br><span>     struct so=
ckaddr_storage dest;</span><br><span>     socklen_t destlen;</span><br><spa=
n>     bool sent;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct timeval sent_at; /* when the probe was sent, for RTT measurement *=
/</span><br><span> };</span><br><span> </span><br><span> /* The probe uses =
one native socket per address family, so every remote is probed</span><br><=
span>@@ -177,7 +178,13 @@</span><br><span>             &amp;&amp; addr_port=
_match((const struct openvpn_sockaddr *)(const void *)from,</span><br><span=
>                                (const struct openvpn_sockaddr *)(const vo=
id *)&amp;targets[i]=2Edest))</span><br><span>         {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            struct timeval rcv;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            openvpn_gettim=
eofday(&amp;rcv, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            long ms =3D (long)(rcv=2Etv_sec - targets[i]=2Esent_at=2Etv=
_sec) * 1000</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
               + (rcv=2Etv_usec - targets[i]=2Esent_at=2Etv_usec) / 1000;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>    =
         results[i]=2Eresponded =3D true;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            results[i]=2Ertt_ms =3D (ms &gt; 0) ? (un=
signed int)ms : 0;</span><br><span>             results[i]=2Ereply =3D repl=
y;</span><br><span>             break;</span><br><span>         }</span><br=
><span>@@ -432,6 +439,7 @@</span><br><span>             }</span><br><span> =
            else</span><br><span>             {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                openvpn_gettimeofday(&amp;targe=
ts[i]=2Esent_at, NULL);</span><br><span>                 targets[i]=2Edestl=
en =3D destlen;</span><br><span>                 targets[i]=2Esent =3D true=
;</span><br><span>                 sent_count++;</span><br><span>@@ -454,8 =
+462,16 @@</span><br><span>         if (results[i]=2Eresponded)</span><br><=
span>         {</span><br><span>             responded++;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            msg(D_LOW, &quot;server-pro=
be: %s:%s answered (priority %d, weight %d)&quot;, ce-&gt;remote,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                ce-&gt;remote_p=
ort, results[i]=2Ereply=2Epriority, results[i]=2Ereply=2Eweight);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            /* Effective cand=
idate-band margin and where it came from: the</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+             * client&#39;s own setting wins, els=
e the server&#39;s advertised value=2E */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            int client_margin =3D c-&gt;options=2Eser=
ver_probe_latency_margin;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            int margin =3D oob_effective_margin(&amp;results[i], clie=
nt_margin);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    const char *margin_src =3D client_margin &gt;=3D 0 ? &quot;client&quot;=
 : &quot;server-advertised&quot;;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            msg(D_LOW,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                &quot;server-probe: %s:%s answered (priori=
ty %d, weight %d, rtt %u ms;&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                &quot; latency margin %d ms [%s])&quot;,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                ce-&gt;=
remote, ce-&gt;remote_port, results[i]=2Ereply=2Epriority, results[i]=2Erep=
ly=2Eweight,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         results[i]=2Ertt_ms, margin, margin_src);</span><br><span>        =
 }</span><br><span>         else</span><br><span>         {</span><br><span=
></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1748?usp=3Demail">change 1748</a>=2E To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sc=
hema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1748?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: o=
penvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<di=
v style=3D"display:none"> Gerrit-Change-Id: I375a41749060b7d006647bc27002c5=
5436c8a8bb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1748 <=
/div>
<div style=3D"display:none"> Gerrit-PatchSet: 16 </div>
<div style=3D=
"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel =
&lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>

</body></html>
--FdxTyLN+49Y=--


--===============4952737968738757216==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4952737968738757216==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4952737968738757216==--

