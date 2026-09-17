Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACEA8C982C1
	for <openvpn-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ATlDoQEBQkDAZAwSqZ8jYIoxPt50lla/sEhF+WHxlL4=; b=ImMr1BZHw3TlvYqz/XNEQW/hnT
	gOkTTkdj3x8Qixs0YkYlQ2ZtQpnv1+X/NGqiyvEsGe/oihJeZX7vUquhHLRAVt6hC5kyfYLZXBpEx
	W16iHreH/RHStQJR8yyiOREG/F7hcSFxBXirZ75gTi930UD8PCXp/eE0BJx5WSaatDMw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x76iN-0007Hf-3q;
	Thu, 17 Sep 2026 07:39:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x76iL-0007HX-5i
 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 07:39:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=X2fVYa5ybMuqTjeDsWdnZLAVJ7umRYE6bXV+W+9ENXo=; b=XarzdmX7DVWAiKtGMttbSW6EVx
 CEOvDDuYJlU/4coEA6npi87mDbvPG849p7ZiBD9/FupEkCchfNrZA6gBOXLbPEDDXFKpQXQBjIOee
 KdqR91oNt9K0l77aRD2wo+3OfQk8Tu5kjSW1OGsFpb4E/sm5wVOSUmVfVpT4hFlmK7u0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=X2fVYa5ybMuqTjeDsWdnZLAVJ7umRYE6bXV+W+9ENXo=; b=f
 i9emSDC4f1KSfcG++M7MFntuzZtKz7I5lg4tgut8/5i7X8hqW5lP/LozRweO+mhQ3vENf6xRHo8ms
 zfSQjFzZ5dI0ePJfAyc0scrQPMX9KGsm3ez6VU1pdwu1qdIm390Ahj6lpMoQuo5bLP+1maCxgA0Gm
 DLXyhxXl6m6rRIt8=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x76iG-0007Xa-Tl for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 07:39:25 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e6b885ef8so2662945e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 17 Sep 2026 00:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789630754; x=1790235554; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=X2fVYa5ybMuqTjeDsWdnZLAVJ7umRYE6bXV+W+9ENXo=;
 b=eIlMkLV76pBOWnapZPFenl+o9OviRibn02fXNBxtx1caDfh6GZr2jnydqtFBuozFFa
 PgRZE8id2i+VXHYMM8Fta1D6x/YEODYvSFkFmxW55M2A9Qkt1refsQi2kfCehnMduT/A
 m2qvBvI8yoGzQ9JQ//juKbwzfTk3ebQ8NIKDvMS6OZ3el5BsuwCjGTuvMaRQghx9mEK2
 PkzGkvG/F0U4hDDNObRl0vagB+sVHbRHTNWKjQj4rdyjfEqBdUKnT3u9xA2ecLKE84ez
 1+JbA4UTn/yXtpoKhw6ikG9d+3vzuikaJUiJ6WE/yZ7Wz4dsFhDkUebM92pT62/v0mRD
 0R0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789630754; x=1790235554;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=X2fVYa5ybMuqTjeDsWdnZLAVJ7umRYE6bXV+W+9ENXo=;
 b=0sZwYmrnAdn5R/Fp7T93A0K7SpqYWLY9w5jal9n3lB7I0Y0EzUAqDHcZEIil3gd4rS
 9pXo/WWLtWn3a2aoa4Gg/rCpLU7Gr++6uiF82MW1wW0hOmXd8LMBFeSDg6ZQ7dw/fETc
 cQyWc7zlsUCeS+hnU8KyDRUtULOMRvfGJ3uqFRR8HlqKH1pNBoXhIpn9uazGuLlFiHAf
 AroIfyWdZ55gkfgt7B0zGLba/JqS0vB1JTuvnEqIBvPYFCz6YaYtmh/qhVFfdSkMxB69
 kT5S22+7n98+1dHEYkgumWgcxudtR+A2n90zKZ53SU0dGZi5LNVVAIZ5USdY0qQ8qQzJ
 Zvtg==
X-Gm-Message-State: AFuF++np6UcFqmvpnyDc+JMP6N1ap8WG0/MCmjkz+uSfHO0DfkI3OZmI
 FQXebfnj5kycUbRYhZ1peEASq6xMZkWqp1453Lmb/tvDIiqd087xSJjYUwAOOiudehcBvqxkJHz
 ImKt+3bFD1NTwYzgBLrnj+AeppED7lim5jRKVkLAsi0+eMMPTsL3R7xkJzypyzOdjyABG
X-Gm-Gg: AYBFou3sJsEWK076M4Nnb7t0E4dCEQaEXXaNHjcRoamilcjLxJ/HHmwY1613I54AZy5
 vcMqPWA9x3/LGb4OpW3oYoiI1W3Qc/ZhWziFNsrc/54gmozF/BztXt2r6jKqezxz48MzeYRdh7c
 MV854y2Rm7o8+Sg3f6BqeaHIs7sdeb0DnKiIzUDqkNBQaRqbeT75sm4H7tfmzDfsjFwk7puo7vN
 3YuCdAVVqCdHMbLnGkuoYlN2BSWbgFJa/n0C2saI/T2PxlcxODlloBbclxKCWWwCwfsc0AQXGw3
 SfkxzaQ/3oqm1BEgBgiGH274F5X7uK+JPC7qeBikRbTW+VoCowhOdZu7owpDJBosTh0SrA26MTK
 Ohoy3a+Ti3nKsf46Of3zLweRTmyq+ARmeIH+tmitTGOytVHGo0aZgxh76c2JiA8k/W029COgUfl
 7U9YeqYyXhtY+/Z3OCD5D/2BPrjpEdRh2FzBYx16AjbXmaDC/1fECk6QmBUb4QntwPl4ucju/nA
 +L7xb+9f/jnQ9twqwGlS9EUEz/IvQK4oANSp1l7h3KEhmT8NqjSxamWpfTb2YSjjIrj3xyS0o3s
 y0wlpX6bFL0cPEzAt4FH/RTTo2nProDH627sE+0r0kuat4vVrqglRCoLTZ4A3w==
X-Received: by 2002:a05:600c:314a:b0:49e:799e:c1c3 with SMTP id
 5b1f17b1804b1-49eb73263c6mr65979705e9.17.1789630753809; 
 Thu, 17 Sep 2026 00:39:13 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd216028sm51592545e9.7.2026.09.17.00.39.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 00:39:13 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 17 Sep 2026 07:39:07 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 26
X-Gerrit-Change-Id: I00208610e0ce4f3ed9a87233e68ece1b3b8a768a
X-Gerrit-Change-Number: 1751
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1751?usp=email>
X-Gerrit-Commit: 555fa6dba7f577477cea8b5730f56d9b27967792
In-Reply-To: <gerrit.1782719911000.I00208610e0ce4f3ed9a87233e68ece1b3b8a768a@gerrit.openvpn.net>
References: <gerrit.1782719911000.I00208610e0ce4f3ed9a87233e68ece1b3b8a768a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkwMDIwODYxMGUwY2U0ZjNlZDlhODcyMzNlNjhlY2UxYjNiOGE3NjhhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ff6fb1e7661f398b15e9294018e08a157b803722-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x76iG-0007Xa-Tl
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Probe every
 resolved address of a remote
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
Content-Type: multipart/mixed; boundary="===============9105146490822201987=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============9105146490822201987==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GeEtD8LD55Q="; charset=UTF-8

--GeEtD8LD55Q=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici, stipa=2E

Hello=
 plaisthos, ralf_lici, 

I'd like you to reexamine a change=2E Please visit=


    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1751?usp=3Demail

to look a=
t the new patch set (#26)=2E

The following approvals got outdated and were=
 removed:
Code-Review-1 by ralf_lici


Change subject: oob: Probe every res=
olved address of a remote
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

oob: Probe every resolved address of a remote

A remote can r=
esolve to several A/AAAA records; --server-probe
previously sent a SERVER_P=
ROBE only to the first one, so a remote whose
first address was unreachable=
 looked unresponsive even if another
address answered, and the connection c=
ould later try an address that was
never probed=2E

Probe every resolved ad=
dress of each remote in parallel (per-remote
storage is sized to the resolv=
ed address count, no fixed cap), accept a
reply from any of them (first rep=
ly for a remote wins), and resend to
all of a remote's addresses while it i=
s unanswered=2E The per-address send
moves into oob_probe_send_target(), wh=
ich keeps the
one-probe-per-address rule across the addresses of all entrie=
s=2E

The addresses of one remote are taken to be the same service, adverti=
sing
the same priority, weight and margin; the first of them to answer spea=
ks
for the remote, and its round-trip time is measured from the probe sent =
to
that address=2E

Change-Id: I00208610e0ce4f3ed9a87233e68ece1b3b8a768a
Si=
gned-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M doc/man-sections/client=
-options=2Erst
M src/openvpn/oob=2Ec
M src/openvpn/oob=2Eh
M src/openvpn/oo=
b_client=2Ec
M tests/unit_tests/openvpn/test_oob=2Ec
5 files changed, 249 i=
nsertions(+), 89 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn refs/changes/51/1751/26

diff --git a/doc/man-sections/client-op=
tions=2Erst b/doc/man-sections/client-options=2Erst
index a3102bb=2E=2E4f24=
642 100644
--- a/doc/man-sections/client-options=2Erst
+++ b/doc/man-sectio=
ns/client-options=2Erst
@@ -604,7 +604,7 @@
      server-probe
      server=
-probe max-latency-diff
 
-  A small probe message is sent to the first res=
olved address of every UDP
+  A small probe message is sent to every resolv=
ed address of every UDP
   remote, and each answering server replies with i=
ts advertised priority
   and weight=2E Remotes are then reordered followin=
g DNS SRV (RFC 2782)
   semantics: servers that answered are tried before t=
hose that did not,
@@ -620,6 +620,10 @@
   priority group a candidate, sinc=
e replies only arrive within the
   one-second probe window; the group is t=
hen ordered by weight alone=2E
 
+  The addresses of one remote are expecte=
d to be the same service and to
+  advertise the same values; the first of =
them to answer speaks for the
+  remote=2E
+
   The probe carries the same =
control-channel wrapping as a normal
   connection (``--tls-auth`` or ``--t=
ls-crypt``, when configured)=2E With
   ``--tls-crypt-v2`` the remotes are =
left in their configured order,
diff --git a/src/openvpn/oob=2Ec b/src/open=
vpn/oob=2Ec
index 537e2c0=2E=2E2149dd6 100644
--- a/src/openvpn/oob=2Ec
+++=
 b/src/openvpn/oob=2Ec
@@ -153,9 +153,16 @@
 {
     for (int i =3D start; i=
 < n; i++)
     {
-        if (targets[i]=2Esent && !results[i]=2Eresponded=
 && addr_port_match(from, &targets[i]=2Edest))
+        if (!targets[i]=2Es=
ent || results[i]=2Eresponded)
         {
-            return i;
+         =
   continue;
+        }
+        for (int k =3D 0; k < targets[i]=2En_dests=
; k++)
+        {
+            if (addr_port_match(from, &targets[i]=2Edest=
s[k]))
+            {
+                return i;
+            }
         }
=
     }
     return -1;
@@ -174,6 +181,20 @@
     return -1;
 }
 
+int
+oob_=
probe_rtt_ms(const struct oob_probe_target *t, const struct openvpn_sockadd=
r *from,
+                 const struct timeval *rcv)
+{
+    const int k =
=3D oob_addr_list_find(t->dests, t->n_dests, from);
+    if (k < 0 || oob_s=
ent_at_unset(&t->sent_at[k]))
+    {
+        return -1; /* not this remote=
's address, or never probed */
+    }
+    const long ms =3D (long)(rcv->tv=
_sec - t->sent_at[k]=2Etv_sec) * 1000
+                    + (rcv->tv_usec =
- t->sent_at[k]=2Etv_usec) / 1000;
+    return (ms > 0) ? (int)ms : 0;
+}
+=

 /* Base ordering: responders before non-responders, then by priority (low=
er
  * first), then by RTT (lower first), then by original index for determ=
inism=2E
  * This groups responders into priority runs pre-sorted by RTT, w=
hich the
diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh
index 639ee=
65=2E=2E432ac70 100644
--- a/src/openvpn/oob=2Eh
+++ b/src/openvpn/oob=2Eh
=
@@ -195,15 +195,37 @@
     struct oob_probe_reply reply; /* the values the =
server advertised */
 };
 
-/* Where the client probed one connection entry=
=2E */
+/* Where the client probed one connection entry: its resolved addre=
sses=2E */
 struct oob_probe_target
 {
-    struct openvpn_sockaddr dest;
-=
    socklen_t destlen;
-    bool sent;
-    struct timeval sent_at; /* when=
 the first probe went out, for the RTT */
+    struct openvpn_sockaddr *des=
ts;
+    socklen_t *destlens;
+    struct timeval *sent_at; /* per address:=
 when its first probe went out (zero: never) */
+    int n_dests;
+    bool=
 sent; /* at least one address was probed */
 };
 
+/* An address's first-s=
end time; zero until a probe went out to it=2E */
+static inline bool
+oob_=
sent_at_unset(const struct timeval *tv)
+{
+    return tv->tv_sec =3D=3D 0 =
&& tv->tv_usec =3D=3D 0;
+}
+
+/**
+ * Round-trip time of a reply, measured=
 from the first probe sent to the
+ * address it came from -- not from the =
first probe sent for the remote, as
+ * the addresses of one remote go out =
one after another=2E
+ *
+ * @param t     the probed entry
+ * @param from =
 source address of the reply
+ * @param rcv   when the reply arrived
+ * @r=
eturn milliseconds (0 if the clock went backwards), or -1 if from is not
+ =
*         an address of t or no probe was sent to it
+ */
+int oob_probe_rt=
t_ms(const struct oob_probe_target *t, const struct openvpn_sockaddr *from,=

+                     const struct timeval *rcv);
+
 /**
  * Find the next=
 entry, from index \p start on, that was probed at \p from and
  * has not =
answered yet=2E Several entries can resolve to the same address, so a
diff =
--git a/src/openvpn/oob_client=2Ec b/src/openvpn/oob_client=2Ec
index 5a304=
2a=2E=2Eab8bed4 100644
--- a/src/openvpn/oob_client=2Ec
+++ b/src/openvpn/o=
ob_client=2Ec
@@ -322,6 +322,81 @@
     }
 }
 
+/* Does any address of t ha=
ve a probe socket of its family? */
+static bool
+oob_probe_target_reachabl=
e(const struct probe_ctx *pc, const struct oob_probe_target *t)
+{
+    for=
 (int k =3D 0; k < t->n_dests; k++)
+    {
+        if (pc->sd[probe_af_ind=
ex(t->dests[k]=2Eaddr=2Esa=2Esa_family)] !=3D SOCKET_UNDEFINED)
+        {
=
+            return true;
+        }
+    }
+    return false;
+}
+
+/* Sen=
d the probe to every resolved address of t, each on the socket matching
+ *=
 its address family, recording when each address was first sent so a reply'=
s
+ * RTT is measured from the probe to the address that answered=2E An add=
ress an
+ * earlier entry already probed in this round is not probed again;=
 that probe's
+ * reply covers this entry too=2E Returns true if at least o=
ne address was sent
+ * to or is already covered=2E */
+static bool
+oob_pr=
obe_send_target(struct probe_ctx *pc, const struct buffer *probe, struct oo=
b_probe_target *t)
+{
+    bool any_sent =3D false;
+    /* The RTT runs fr=
om an address's first send=2E A reply carries nothing that
+     * ties it =
to a send round, so measuring from a resend would report a
+     * server s=
lower than one round as fast=2E */
+    for (int k =3D 0; k < t->n_dests; k=
++)
+    {
+        const int af =3D probe_af_index(t->dests[k]=2Eaddr=2Esa=
=2Esa_family);
+        socket_descriptor_t sd =3D pc->sd[af];
+        if =
(sd =3D=3D SOCKET_UNDEFINED)
+        {
+            continue;
+        }
+=
#ifdef TARGET_ANDROID
+        /* Keep the probe out of an active tunnel, a=
s the connection socket is=2E
+         * protect_fd_nonlocal() declines a =
local peer, so only a non-local one
+         * actually protects the socke=
t and may latch the flag=2E */
+        if (!pc->fd_protected[af] && !addr_=
local(&t->dests[k]=2Eaddr=2Esa))
+        {
+            protect_fd_nonloca=
l(sd, &t->dests[k]=2Eaddr=2Esa);
+            pc->fd_protected[af] =3D true=
;
+        }
+#endif
+        const int seen =3D oob_addr_list_find(pc->pro=
bed, pc->n_probed, &t->dests[k]);
+        if (seen >=3D 0)
+        {
+   =
         /* Already probed this round by an earlier entry: share that send
=
+             * time, so both entries report the same RTT for the one reply=
=2E */
+            if (oob_sent_at_unset(&t->sent_at[k]))
+            {
+=
                t->sent_at[k] =3D pc->probed_at[seen];
+            }
+    =
        any_sent =3D true;
+            continue;
+        }
+        struc=
t timeval sent_at;
+        openvpn_gettimeofday(&sent_at, NULL);
+        =
if (sendto(sd, (const char *)CBPTR(probe), (int)BLEN(probe), 0,
+          =
         (const struct sockaddr *)&t->dests[k], t->destlens[k])
+          =
  >=3D 0)
+        {
+            if (oob_sent_at_unset(&t->sent_at[k]))
+ =
           {
+                t->sent_at[k] =3D sent_at;
+            }
+  =
          pc->probed_at[pc->n_probed] =3D sent_at;
+            pc->probed[=
pc->n_probed++] =3D t->dests[k];
+            any_sent =3D true;
+        }=

+    }
+    return any_sent;
+}
+
 /* Parse one received datagram as a PRO=
BE_REPLY and, if valid and matching one
  * of the probes we sent, record t=
he reply in results=2E */
 static void
@@ -364,18 +439,18 @@
         retur=
n;
     }
 
-    /* Credit the reply to every still-unanswered remote probe=
d at its source
-     * address: several entries can resolve to the same ad=
dress, and each takes
-     * the first reply for it=2E */
+    /* Credit t=
he reply to every still-unanswered remote that was probed at its
+     * so=
urce address: several entries can resolve to the same address, and each
+  =
   * takes the first reply for it=2E (A remote with several addresses may a=
nswer
+     * from more than one; the first one wins, and its RTT is that a=
ddress's=2E) */
     struct timeval rcv;
     openvpn_gettimeofday(&rcv, NU=
LL);
     int i =3D oob_probe_next_target_at(from, targets, results, n, 0);=

     while (i >=3D 0)
     {
-        /* From this round's send to now, i=
=2Ee=2E including any time the reply
-         * waited in the receive queu=
e while we were still sending=2E */
-        long ms =3D (long)(rcv=2Etv_se=
c - targets[i]=2Esent_at=2Etv_sec) * 1000
-                  + (rcv=2Etv_us=
ec - targets[i]=2Esent_at=2Etv_usec) / 1000;
+        /* From the first sen=
d to this address to now, i=2Ee=2E including any time
+         * the reply=
 waited in the receive queue while we were still sending=2E */
+        con=
st int ms =3D oob_probe_rtt_ms(&targets[i], from, &rcv);
 
         results=
[i]=2Eresponded =3D true;
         results[i]=2Ertt_ms =3D (ms > 0) ? (unsi=
gned int)ms : 0;
@@ -475,27 +550,9 @@
     pc->n_probed =3D 0;
     for (in=
t i =3D 0; i < n; i++)
     {
-        if (!targets[i]=2Esent || results[i]=
=2Eresponded)
+        if (targets[i]=2Esent && !results[i]=2Eresponded)
  =
       {
-            continue;
-        }
-        if (oob_addr_list_find(=
pc->probed, pc->n_probed, &targets[i]=2Edest) >=3D 0)
-        {
-         =
   continue;
-        }
-        socket_descriptor_t sd =3D pc->sd[probe_af=
_index(targets[i]=2Edest=2Eaddr=2Esa=2Esa_family)];
-        if (sd =3D=3D =
SOCKET_UNDEFINED)
-        {
-            continue;
-        }
-        str=
uct timeval sent_at;
-        openvpn_gettimeofday(&sent_at, NULL);
-      =
  if (sendto(sd, (const char *)CBPTR(probe), (int)BLEN(probe), 0,
-        =
           (const struct sockaddr *)&targets[i]=2Edest, targets[i]=2Edestle=
n)
-            >=3D 0)
-        {
-            pc->probed_at[pc->n_probed]=
 =3D sent_at;
-            pc->probed[pc->n_probed++] =3D targets[i]=2Edest=
;
+            oob_probe_send_target(pc, probe, &targets[i]);
         }
  =
   }
 }
@@ -701,11 +758,24 @@
             continue;
         }
 
-        =
/* Store the first resolved address natively (no IPv4-mapping); it is
-    =
     * later probed on its family's socket=2E */
-        memcpy(&targets[i=
]=2Edest, ai->ai_addr, ai->ai_addrlen);
-        targets[i]=2Edestlen =3D (=
socklen_t)ai->ai_addrlen;
-        need_af[probe_af_index(ai->ai_family)] =
=3D true;
+        /* Store every resolved address natively (no IPv4-mappin=
g); each is later
+         * probed on its family's socket=2E */
+        =
struct oob_probe_target *t =3D &targets[i];
+        int n_addr =3D 0;
+   =
     for (const struct addrinfo *a =3D ai; a; a =3D a->ai_next)
+        {
=
+            n_addr++;
+        }
+        t->dests =3D gc_malloc(sizeof(*t=
->dests) * n_addr, true, &gc);
+        t->destlens =3D gc_malloc(sizeof(*t=
->destlens) * n_addr, true, &gc);
+        t->sent_at =3D gc_malloc(sizeof(=
*t->sent_at) * n_addr, true, &gc);
+        for (const struct addrinfo *a =
=3D ai; a; a =3D a->ai_next)
+        {
+            memcpy(&t->dests[t->n_=
dests], a->ai_addr, a->ai_addrlen);
+            t->destlens[t->n_dests] =
=3D (socklen_t)a->ai_addrlen;
+            t->n_dests++;
+            need_=
af[probe_af_index(a->ai_family)] =3D true;
+        }
         freeaddrinfo=
(ai);
     }
 
@@ -722,58 +792,32 @@
         return;
     }
 
-    /* Send=
 a probe to each resolved remote, on the socket of its address family=2E
- =
    * An address several entries resolve to is probed once; its reply is
- =
    * credited to each of them=2E */
-    pc=2Eprobed =3D gc_malloc(sizeof(=
*pc=2Eprobed) * l->len, false, &gc);
-    pc=2Eprobed_at =3D gc_malloc(size=
of(*pc=2Eprobed_at) * l->len, false, &gc);
+    /* Send a probe to each res=
olved remote, on the socket of each address=2E */
+    int n_addrs =3D 0;
+=
    for (int i =3D 0; i < l->len; i++)
+    {
+        n_addrs +=3D targets=
[i]=2En_dests;
+    }
+    pc=2Eprobed =3D gc_malloc(sizeof(*pc=2Eprobed) *=
 n_addrs, false, &gc);
+    pc=2Eprobed_at =3D gc_malloc(sizeof(*pc=2Eprobe=
d_at) * n_addrs, false, &gc);
     pc=2En_probed =3D 0;
 
     int sent_cou=
nt =3D 0;
     for (int i =3D 0; i < l->len; i++)
     {
         const str=
uct connection_entry *ce =3D l->array[i];
-        if (!targets[i]=2Edestle=
n)
+        struct oob_probe_target *t =3D &targets[i];
+        if (t->n_d=
ests =3D=3D 0 || !oob_probe_target_reachable(&pc, t))
         {
+         =
   continue; /* nothing resolved, or its family is not probed */
+        }=

+
+        if (!oob_probe_send_target(&pc, &probe, t))
+        {
+       =
     msg(D_LOW, "server-probe: %s:%s: probe send failed", ce->remote, ce->r=
emote_port);
             continue;
         }
-        const int af =3D pr=
obe_af_index(targets[i]=2Edest=2Eaddr=2Esa=2Esa_family);
-        socket_de=
scriptor_t sd =3D pc=2Esd[af];
-        if (sd =3D=3D SOCKET_UNDEFINED)
-  =
      {
-            continue; /* family not probed, see oob_probe_sockets_=
open() */
-        }
-#ifdef TARGET_ANDROID
-        /* Keep the probe out =
of an active tunnel, as the connection socket is=2E
-         * protect_fd_=
nonlocal() declines a local peer, so only a non-local one
-         * actua=
lly protects the socket and may latch the flag=2E */
-        if (!pc=2Efd_=
protected[af] && !addr_local(&targets[i]=2Edest=2Eaddr=2Esa))
-        {
- =
           protect_fd_nonlocal(sd, &targets[i]=2Edest=2Eaddr=2Esa);
-      =
      pc=2Efd_protected[af] =3D true;
-        }
-#endif
-        const int=
 seen =3D oob_addr_list_find(pc=2Eprobed, pc=2En_probed, &targets[i]=2Edest=
);
-        if (seen >=3D 0)
-        {
-            /* Already probed this=
 round by an earlier entry: reuse that send
-             * time, so both e=
ntries report the same RTT for the one reply=2E */
-            targets[i]=
=2Esent_at =3D pc=2Eprobed_at[seen];
-        }
-        else
-        {
- =
           openvpn_gettimeofday(&targets[i]=2Esent_at, NULL);
-            =
if (sendto(sd, (const char *)BPTR(&probe), (int)BLEN(&probe), 0,
-         =
              (struct sockaddr *)&targets[i]=2Edest, targets[i]=2Edestlen)
=
-                < 0)
-            {
-                msg(D_LOW, "server-pr=
obe: %s:%s: probe send failed", ce->remote, ce->remote_port);
-            =
    continue;
-            }
-            pc=2Eprobed_at[pc=2En_probed] =3D=
 targets[i]=2Esent_at;
-            pc=2Eprobed[pc=2En_probed++] =3D target=
s[i]=2Edest;
-        }
-        targets[i]=2Esent =3D true;
+        t->se=
nt =3D true;
         sent_count++;
     }
 
diff --git a/tests/unit_tests/=
openvpn/test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec
index 8973f04=
=2E=2E26aacaf 100644
--- a/tests/unit_tests/openvpn/test_oob=2Ec
+++ b/test=
s/unit_tests/openvpn/test_oob=2Ec
@@ -519,10 +519,12 @@
     return sa;
 }
=
 
+/* One probed address per entry=2E */
 static struct oob_probe_target
-p=
robe_target(struct openvpn_sockaddr dest, bool sent)
+probe_target(struct o=
penvpn_sockaddr *dest, bool sent)
 {
-    return (struct oob_probe_target){=
 =2Edest =3D dest, =2Edestlen =3D sizeof(dest=2Eaddr=2Ein4), =2Esent =3D se=
nt };
+    static socklen_t len =3D sizeof(struct sockaddr_in);
+    return=
 (struct oob_probe_target){ =2Edests =3D dest, =2Edestlens =3D &len, =2En_d=
ests =3D 1, =2Esent =3D sent };
 }
 
 /* Two entries resolve to the same ad=
dress=2E The first reply from it is
@@ -531,7 +533,7 @@
 test_probe_reply_c=
redits_every_entry_at_address(void **state)
 {
     struct openvpn_sockaddr=
 a =3D v4_addr(0x7f000001, 1194);
-    struct oob_probe_target targets[2] =
=3D { probe_target(a, true), probe_target(a, true) };
+    struct oob_probe=
_target targets[2] =3D { probe_target(&a, true), probe_target(&a, true) };
=
     struct oob_probe_result results[2] =3D { 0 };
 
     int i =3D oob_pro=
be_next_target_at(&a, targets, results, 2, 0);
@@ -555,9 +557,9 @@
     str=
uct openvpn_sockaddr b =3D v4_addr(0x7f000002, 1194);
     struct openvpn_s=
ockaddr a_other_port =3D v4_addr(0x7f000001, 1195);
     struct oob_probe_t=
arget targets[3] =3D {
-        probe_target(a, true),
-        probe_targe=
t(b, true),
-        probe_target(a, false), /* resolved but never sent */
=
+        probe_target(&a, true),
+        probe_target(&b, true),
+        =
probe_target(&a, false), /* resolved but never sent */
     };
     struct =
oob_probe_result results[3] =3D { 0 };
 
@@ -568,6 +570,70 @@
     assert_i=
nt_equal(oob_probe_next_target_at(&a_other_port, targets, results, 3, 0), -=
1);
 }
 
+/* A remote with several addresses is credited whichever of them =
answers=2E */
+static void
+test_probe_reply_matches_any_address_of_entry(v=
oid **state)
+{
+    struct openvpn_sockaddr addrs[2] =3D { v4_addr(0x7f000=
001, 1194), v4_addr(0x7f000002, 1194) };
+    socklen_t lens[2] =3D { sizeo=
f(struct sockaddr_in), sizeof(struct sockaddr_in) };
+    struct oob_probe_=
target targets[1] =3D {
+        { =2Edests =3D addrs, =2Edestlens =3D lens=
, =2En_dests =3D 2, =2Esent =3D true },
+    };
+    struct oob_probe_resul=
t results[1] =3D { 0 };
+
+    assert_int_equal(oob_probe_next_target_at(&a=
ddrs[1], targets, results, 1, 0), 0);
+    assert_int_equal(oob_probe_next_=
target_at(&addrs[0], targets, results, 1, 0), 0);
+}
+
+/* The RTT of a rep=
ly is measured from the probe sent to the address that
+ * answered, not fr=
om the first probe sent for the remote=2E */
+static void
+test_probe_rtt_p=
er_address(void **state)
+{
+    struct openvpn_sockaddr addrs[2] =3D { v4_=
addr(0x7f000001, 1194), v4_addr(0x7f000002, 1194) };
+    socklen_t lens[2]=
 =3D { sizeof(struct sockaddr_in), sizeof(struct sockaddr_in) };
+    /* A =
went out at t=3D0 ms, B 20 ms later */
+    struct timeval sent_at[2] =3D {=
 { =2Etv_sec =3D 1000, =2Etv_usec =3D 0 }, { =2Etv_sec =3D 1000, =2Etv_usec=
 =3D 20000 } };
+    struct oob_probe_target t =3D { =2Edests =3D addrs, =
=2Edestlens =3D lens, =2Esent_at =3D sent_at, =2En_dests =3D 2, =2Esent =3D=
 true };
+    struct timeval rcv =3D { =2Etv_sec =3D 1000, =2Etv_usec =3D 2=
5000 };
+
+    assert_int_equal(oob_probe_rtt_ms(&t, &addrs[1], &rcv), 5); =
 /* B: 25 - 20 */
+    assert_int_equal(oob_probe_rtt_ms(&t, &addrs[0], &rc=
v), 25); /* A: 25 - 0 */
+
+    /* an address of the remote that was never =
sent to, and a stranger */
+    sent_at[1] =3D (struct timeval){ 0 };
+    =
assert_int_equal(oob_probe_rtt_ms(&t, &addrs[1], &rcv), -1);
+    struct op=
envpn_sockaddr other =3D v4_addr(0x7f000003, 1194);
+    assert_int_equal(o=
ob_probe_rtt_ms(&t, &other, &rcv), -1);
+
+    /* a clock that went backwar=
ds reads as 0, not as a huge value */
+    rcv=2Etv_usec =3D 0;
+    sent_a=
t[0]=2Etv_usec =3D 5000;
+    assert_int_equal(oob_probe_rtt_ms(&t, &addrs[=
0], &rcv), 0);
+}
+
+/* IPv6 addresses match on address and port too=2E */
=
+static void
+test_probe_addresses_ipv6(void **state)
+{
+    struct openvp=
n_sockaddr a =3D { 0 }, b =3D { 0 };
+    a=2Eaddr=2Ein6=2Esin6_family =3D =
AF_INET6;
+    a=2Eaddr=2Ein6=2Esin6_addr=2Es6_addr[15] =3D 1; /* ::1 */
+ =
   a=2Eaddr=2Ein6=2Esin6_port =3D htons(1194);
+    b =3D a;
+    b=2Eaddr=
=2Ein6=2Esin6_port =3D htons(1195);
+    socklen_t len =3D sizeof(struct so=
ckaddr_in6);
+    struct oob_probe_target targets[1] =3D {
+        { =2Ede=
sts =3D &a, =2Edestlens =3D &len, =2En_dests =3D 1, =2Esent =3D true },
+  =
  };
+    struct oob_probe_result results[1] =3D { 0 };
+
+    assert_int_e=
qual(oob_probe_next_target_at(&a, targets, results, 1, 0), 0);
+    assert_=
int_equal(oob_probe_next_target_at(&b, targets, results, 1, 0), -1);
+    a=
ssert_int_equal(oob_addr_list_find(&a, 1, &a), 0);
+    assert_int_equal(oo=
b_addr_list_find(&a, 1, &b), -1);
+}
+
 /* The per-round list of probed add=
resses compares address and port=2E */
 static void
 test_addr_list_find(vo=
id **state)
@@ -973,6 +1039,9 @@
         cmocka_unit_test(test_server_prob=
e_check_no_parameter),
         cmocka_unit_test(test_probe_reply_credits_e=
very_entry_at_address),
         cmocka_unit_test(test_probe_reply_matches_=
only_its_address),
+        cmocka_unit_test(test_probe_reply_matches_any_a=
ddress_of_entry),
+        cmocka_unit_test(test_probe_rtt_per_address),
+ =
       cmocka_unit_test(test_probe_addresses_ipv6),
         cmocka_unit_te=
st(test_addr_list_find),
         cmocka_unit_test(test_client_reply_read_f=
inds_reply),
         cmocka_unit_test(test_client_reply_read_skips_unknown=
),

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1751?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I00208610e0c=
e4f3ed9a87233e68ece1b3b8a768a
Gerrit-Change-Number: 1751
Gerrit-PatchSet: 2=
6
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit=
-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: ralf_l=
ici <ralf@mandelbit=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>

--GeEtD8LD55Q=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici, stipa=2E </p>
<p>stipa <strong>=
uploaded patch set #26</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1751?usp=3Demail">View Change</a></p><p>T=
he following approvals got outdated and were removed:
Code-Review-1 by ralf=
_lici</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">oob: Probe every resolved address of a remote<br><br=
>A remote can resolve to several A/AAAA records; --server-probe<br>previous=
ly sent a SERVER_PROBE only to the first one, so a remote whose<br>first ad=
dress was unreachable looked unresponsive even if another<br>address answer=
ed, and the connection could later try an address that was<br>never probed=
=2E<br><br>Probe every resolved address of each remote in parallel (per-rem=
ote<br>storage is sized to the resolved address count, no fixed cap), accep=
t a<br>reply from any of them (first reply for a remote wins), and resend t=
o<br>all of a remote&#39;s addresses while it is unanswered=2E The per-addr=
ess send<br>moves into oob_probe_send_target(), which keeps the<br>one-prob=
e-per-address rule across the addresses of all entries=2E<br><br>The addres=
ses of one remote are taken to be the same service, advertising<br>the same=
 priority, weight and margin; the first of them to answer speaks<br>for the=
 remote, and its round-trip time is measured from the probe sent to<br>that=
 address=2E<br><br>Change-Id: I00208610e0ce4f3ed9a87233e68ece1b3b8a768a<br>=
Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M doc/man-s=
ections/client-options=2Erst<br>M src/openvpn/oob=2Ec<br>M src/openvpn/oob=
=2Eh<br>M src/openvpn/oob_client=2Ec<br>M tests/unit_tests/openvpn/test_oob=
=2Ec<br>5 files changed, 249 insertions(+), 89 deletions(-)<br><br></pre><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/change=
s/51/1751/26</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/doc/man-sections/client-options=2Erst b/d=
oc/man-sections/client-options=2Erst</span><br><span>index a3102bb=2E=2E4f2=
4642 100644</span><br><span>--- a/doc/man-sections/client-options=2Erst</sp=
an><br><span>+++ b/doc/man-sections/client-options=2Erst</span><br><span>@@=
 -604,7 +604,7 @@</span><br><span>      server-probe</span><br><span>      =
server-probe max-latency-diff</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-  A small probe message is sent to the first reso=
lved address of every UDP</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  A small probe message is sent to every resolved address of every UD=
P</span><br><span>   remote, and each answering server replies with its adv=
ertised priority</span><br><span>   and weight=2E Remotes are then reordere=
d following DNS SRV (RFC 2782)</span><br><span>   semantics: servers that a=
nswered are tried before those that did not,</span><br><span>@@ -620,6 +620=
,10 @@</span><br><span>   priority group a candidate, since replies only ar=
rive within the</span><br><span>   one-second probe window; the group is th=
en ordered by weight alone=2E</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  The addresses of one remote are expected to b=
e the same service and to</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  advertise the same values; the first of them to answer speaks for t=
he</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  remote=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>   The p=
robe carries the same control-channel wrapping as a normal</span><br><span>=
   connection (``--tls-auth`` or ``--tls-crypt``, when configured)=2E With<=
/span><br><span>   ``--tls-crypt-v2`` the remotes are left in their configu=
red order,</span><br><span>diff --git a/src/openvpn/oob=2Ec b/src/openvpn/o=
ob=2Ec</span><br><span>index 537e2c0=2E=2E2149dd6 100644</span><br><span>--=
- a/src/openvpn/oob=2Ec</span><br><span>+++ b/src/openvpn/oob=2Ec</span><br=
><span>@@ -153,9 +153,16 @@</span><br><span> {</span><br><span>     for (in=
t i =3D start; i &lt; n; i++)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (targets[i]=2Esent &amp;&amp; !r=
esults[i]=2Eresponded &amp;&amp; addr_port_match(from, &amp;targets[i]=2Ede=
st))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!ta=
rgets[i]=2Esent || results[i]=2Eresponded)</span><br><span>         {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            return i;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            continue;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        for (int k =3D 0; k &lt; =
targets[i]=2En_dests; k++)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         if (addr_port_match(from, &amp;targets[i]=2Edests[k]))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                return i;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span> =
        }</span><br><span>     }</span><br><span>     return -1;</span><br>=
<span>@@ -174,6 +181,20 @@</span><br><span>     return -1;</span><br><span>=
 }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_rtt_m=
s(const struct oob_probe_target *t, const struct openvpn_sockaddr *from,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                 const=
 struct timeval *rcv)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const int k =
=3D oob_addr_list_find(t-&gt;dests, t-&gt;n_dests, from);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (k &lt; 0 || oob_sent_at_unset=
(&amp;t-&gt;sent_at[k]))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
eturn -1; /* not this remote&#39;s address, or never probed */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    const long ms =3D (long)(rcv-&gt;tv_sec - =
t-&gt;sent_at[k]=2Etv_sec) * 1000</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                    + (rcv-&gt;tv_usec - t-&gt;sent_at[k]=2Et=
v_usec) / 1000;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return (ms &gt; 0) ? (int)ms : 0;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span> /* Base ordering: responders before non-responders, then by p=
riority (lower</span><br><span>  * first), then by RTT (lower first), then =
by original index for determinism=2E</span><br><span>  * This groups respon=
ders into priority runs pre-sorted by RTT, which the</span><br><span>diff -=
-git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh</span><br><span>index 639e=
e65=2E=2E432ac70 100644</span><br><span>--- a/src/openvpn/oob=2Eh</span><br=
><span>+++ b/src/openvpn/oob=2Eh</span><br><span>@@ -195,15 +195,37 @@</spa=
n><br><span>     struct oob_probe_reply reply; /* the values the server adv=
ertised */</span><br><span> };</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-/* Where the client probed one connection entry=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Where the =
client probed one connection entry: its resolved addresses=2E */</span><br>=
<span> struct oob_probe_target</span><br><span> {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    struct openvpn_sockaddr dest;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    socklen_t destlen;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    bool sent;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    struct timeval sent_at; /* when the f=
irst probe went out, for the RTT */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct openvpn_sockaddr *dests;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    socklen_t *destlens;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct timeval *sent_at; /* per =
address: when its first probe went out (zero: never) */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    int n_dests;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    bool sent; /* at least one address wa=
s probed */</span><br><span> };</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/* An address&#39;s first-send time; zero unt=
il a probe went out to it=2E */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+static inline bool</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+oob_sent_at_unset(const struct timeval *tv)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return tv-&gt;tv_sec =3D=3D 0 &amp;&amp; tv-&gt;tv_use=
c =3D=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * Round-trip time of a reply, measured from the first probe =
sent to the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * addre=
ss it came from -- not from the first probe sent for the remote, as</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * the addresses of one rem=
ote go out one after another=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p=
aram t     the probed entry</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @param from  source address of the reply</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param rcv   when the reply arrived</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return millisecond=
s (0 if the clock went backwards), or -1 if from is not</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *         an address of t or no probe =
was sent to it</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+int oob_probe_rtt_ms(=
const struct oob_probe_target *t, const struct openvpn_sockaddr *from,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                     con=
st struct timeval *rcv);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> /**</span><br><span>  * Find the next entry, from in=
dex \p start on, that was probed at \p from and</span><br><span>  * has not=
 answered yet=2E Several entries can resolve to the same address, so a</spa=
n><br><span>diff --git a/src/openvpn/oob_client=2Ec b/src/openvpn/oob_clien=
t=2Ec</span><br><span>index 5a3042a=2E=2Eab8bed4 100644</span><br><span>---=
 a/src/openvpn/oob_client=2Ec</span><br><span>+++ b/src/openvpn/oob_client=
=2Ec</span><br><span>@@ -322,6 +322,81 @@</span><br><span>     }</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/* Does any address of t have a probe socket of its family? */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+oob_probe_target_reachable(const =
struct probe_ctx *pc, const struct oob_probe_target *t)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    for (int k =3D 0; k &lt; t-&gt;n_dests; k++)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (pc-&gt;sd[probe_af_index(t-&g=
t;dests[k]=2Eaddr=2Esa=2Esa_family)] !=3D SOCKET_UNDEFINED)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            return true;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    return false;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/* Send the probe to every r=
esolved address of t, each on the socket matching</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * its address family, recording when each ad=
dress was first sent so a reply&#39;s</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * RTT is measured from the probe to the address that ans=
wered=2E An address an</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * earlier entry already probed in this round is not probed again; that =
probe&#39;s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * reply=
 covers this entry too=2E Returns true if at least one address was sent</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * to or is already cov=
ered=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bo=
ol</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_send_ta=
rget(struct probe_ctx *pc, const struct buffer *probe, struct oob_probe_tar=
get *t)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    bool any_sent =3D false;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* The RTT runs f=
rom an address&#39;s first send=2E A reply carries nothing that</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * ties it to a send round,=
 so measuring from a resend would report a</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * server slower than one round as fast=2E */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int k =3D 0; =
k &lt; t-&gt;n_dests; k++)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 const int af =3D probe_af_index(t-&gt;dests[k]=2Eaddr=2Esa=2Esa_family);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        socket_descri=
ptor_t sd =3D pc-&gt;sd[af];</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (sd =3D=3D SOCKET_UNDEFINED)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            continue;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#ifdef TARGET_ANDROID</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        /* Keep the probe out of an active tunnel, as the conn=
ection socket is=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
         * protect_fd_nonlocal() declines a local peer, so only a non-local=
 one</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * actu=
ally protects the socket and may latch the flag=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (!pc-&gt;fd_protected[af] &amp=
;&amp; !addr_local(&amp;t-&gt;dests[k]=2Eaddr=2Esa))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            protect_fd_nonlocal(sd, &amp;t-&gt;dest=
s[k]=2Eaddr=2Esa);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           pc-&gt;fd_protected[af] =3D true;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        const int seen =3D oob_addr_list_find(pc-&gt;probed, pc-&gt;n_pro=
bed, &amp;t-&gt;dests[k]);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (seen &gt;=3D 0)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            /* Already probed this round by an earlier entry: share th=
at send</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
 * time, so both entries report the same RTT for the one reply=2E */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            if (oob_sent_a=
t_unset(&amp;t-&gt;sent_at[k]))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                t-&gt;sent_at[k] =3D pc-&gt;probed_at[seen];</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            any_sent =3D true;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            continue;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        struct timeval sent_at;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        openvpn_get=
timeofday(&amp;sent_at, NULL);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (sendto(sd, (const char *)CBPTR(probe), (int)BLEN(pro=
be), 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
       (const struct sockaddr *)&amp;t-&gt;dests[k], t-&gt;destlens[k])</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            &gt;=3D 0)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            if (oob_sent_at_un=
set(&amp;t-&gt;sent_at[k]))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                t-&gt;sent_at[k] =3D sent_at;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            pc-&gt;probed_at[pc-&gt;n_probed] =3D sen=
t_at;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            pc=
-&gt;probed[pc-&gt;n_probed++] =3D t-&gt;dests[k];</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            any_sent =3D true;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return any_sent;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span> /* Parse one received datagram as a PROBE_REPLY and, i=
f valid and matching one</span><br><span>  * of the probes we sent, record =
the reply in results=2E */</span><br><span> static void</span><br><span>@@ =
-364,18 +439,18 @@</span><br><span>         return;</span><br><span>     }<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
/* Credit the reply to every still-unanswered remote probed at its source</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * address: several=
 entries can resolve to the same address, and each takes</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-     * the first reply for it=2E */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Credit the reply =
to every still-unanswered remote that was probed at its</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     * source address: several entries =
can resolve to the same address, and each</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     * takes the first reply for it=2E (A remote with=
 several addresses may answer</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * from more than one; the first one wins, and its RTT is tha=
t address&#39;s=2E) */</span><br><span>     struct timeval rcv;</span><br><=
span>     openvpn_gettimeofday(&amp;rcv, NULL);</span><br><span>     int i =
=3D oob_probe_next_target_at(from, targets, results, n, 0);</span><br><span=
>     while (i &gt;=3D 0)</span><br><span>     {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        /* From this round&#39;s send to now, i=
=2Ee=2E including any time the reply</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-         * waited in the receive queue while we were still s=
ending=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        l=
ong ms =3D (long)(rcv=2Etv_sec - targets[i]=2Esent_at=2Etv_sec) * 1000</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                  + (rcv=
=2Etv_usec - targets[i]=2Esent_at=2Etv_usec) / 1000;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* From the first send to this ad=
dress to now, i=2Ee=2E including any time</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+         * the reply waited in the receive queue whil=
e we were still sending=2E */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        const int ms =3D oob_probe_rtt_ms(&amp;targets[i], from, =
&amp;rcv);</span><br><span> </span><br><span>         results[i]=2Eresponde=
d =3D true;</span><br><span>         results[i]=2Ertt_ms =3D (ms &gt; 0) ? =
(unsigned int)ms : 0;</span><br><span>@@ -475,27 +550,9 @@</span><br><span>=
     pc-&gt;n_probed =3D 0;</span><br><span>     for (int i =3D 0; i &lt; n=
; i++)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        if (!targets[i]=2Esent || results[i]=2Eresponded)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if (targets[i]=2Esent=
 &amp;&amp; !results[i]=2Eresponded)</span><br><span>         {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            continue;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (oob_addr_list_find(pc-&gt;probe=
d, pc-&gt;n_probed, &amp;targets[i]=2Edest) &gt;=3D 0)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            continue;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        socket_descriptor_t sd =3D pc-&gt;sd[probe_af_index(target=
s[i]=2Edest=2Eaddr=2Esa=2Esa_family)];</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        if (sd =3D=3D SOCKET_UNDEFINED)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            continue;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        struct timeval sent_at;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        openvpn_gettimeofday(&amp;sent_at, NULL);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (sendto(sd, (co=
nst char *)CBPTR(probe), (int)BLEN(probe), 0,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                   (const struct sockaddr *)&amp;ta=
rgets[i]=2Edest, targets[i]=2Edestlen)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            &gt;=3D 0)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            pc-&gt;probed_at[pc-&gt;n_probed] =3D sent_at;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            pc-&gt;probed[pc-&gt=
;n_probed++] =3D targets[i]=2Edest;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            oob_probe_send_target(pc, probe, &amp;targets[i=
]);</span><br><span>         }</span><br><span>     }</span><br><span> }</s=
pan><br><span>@@ -701,11 +758,24 @@</span><br><span>             continue;<=
/span><br><span>         }</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        /* Store the first resolved address natively=
 (no IPv4-mapping); it is</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-         * later probed on its family&#39;s socket=2E */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        memcpy(&amp;targets[i]=2Edes=
t, ai-&gt;ai_addr, ai-&gt;ai_addrlen);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        targets[i]=2Edestlen =3D (socklen_t)ai-&gt;ai_addr=
len;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        need_af[p=
robe_af_index(ai-&gt;ai_family)] =3D true;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        /* Store every resolved address natively (no=
 IPv4-mapping); each is later</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+         * probed on its family&#39;s socket=2E */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        struct oob_probe_target *t=
 =3D &amp;targets[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        int n_addr =3D 0;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        for (const struct addrinfo *a =3D ai; a; a =3D a-&gt;ai_nex=
t)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            n_addr++;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        t-&gt;dests =3D gc_malloc(s=
izeof(*t-&gt;dests) * n_addr, true, &amp;gc);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        t-&gt;destlens =3D gc_malloc(sizeof(*t-&g=
t;destlens) * n_addr, true, &amp;gc);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        t-&gt;sent_at =3D gc_malloc(sizeof(*t-&gt;sent_at=
) * n_addr, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        for (const struct addrinfo *a =3D ai; a; a =3D a-&gt;ai_nex=
t)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            memcpy(&amp;t-&=
gt;dests[t-&gt;n_dests], a-&gt;ai_addr, a-&gt;ai_addrlen);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            t-&gt;destlens[t-&gt;n_d=
ests] =3D (socklen_t)a-&gt;ai_addrlen;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            t-&gt;n_dests++;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            need_af[probe_af_index(a-&gt;ai_fam=
ily)] =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    }</span><br><span>         freeaddrinfo(ai);</span><br><span>     }</sp=
an><br><span> </span><br><span>@@ -722,58 +792,32 @@</span><br><span>      =
   return;</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    /* Send a probe to each resolved remote=
, on the socket of its address family=2E</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-     * An address several entries resolve to is probed o=
nce; its reply is</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
 * credited to each of them=2E */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    pc=2Eprobed =3D gc_malloc(sizeof(*pc=2Eprobed) * l-&gt;len,=
 false, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
pc=2Eprobed_at =3D gc_malloc(sizeof(*pc=2Eprobed_at) * l-&gt;len, false, &a=
mp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Send =
a probe to each resolved remote, on the socket of each address=2E */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    int n_addrs =3D 0;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i=
 &lt; l-&gt;len; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        n_ad=
drs +=3D targets[i]=2En_dests;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 pc=2Eprobed =3D gc_malloc(sizeof(*pc=2Eprobed) * n_addrs, false, &amp;gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pc=2Eprobed_at =
=3D gc_malloc(sizeof(*pc=2Eprobed_at) * n_addrs, false, &amp;gc);</span><br=
><span>     pc=2En_probed =3D 0;</span><br><span> </span><br><span>     int=
 sent_count =3D 0;</span><br><span>     for (int i =3D 0; i &lt; l-&gt;len;=
 i++)</span><br><span>     {</span><br><span>         const struct connecti=
on_entry *ce =3D l-&gt;array[i];</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        if (!targets[i]=2Edestlen)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        struct oob_probe_target *t =3D &amp;targe=
ts[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (t=
-&gt;n_dests =3D=3D 0 || !oob_probe_target_reachable(&amp;pc, t))</span><br=
><span>         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          continue; /* nothing resolved, or its family is not probed */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if (!oob_probe_send_target(&amp;pc, &amp;pro=
be, t))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_LOW,=
 &quot;server-probe: %s:%s: probe send failed&quot;, ce-&gt;remote, ce-&gt;=
remote_port);</span><br><span>             continue;</span><br><span>      =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const int=
 af =3D probe_af_index(targets[i]=2Edest=2Eaddr=2Esa=2Esa_family);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        socket_descriptor_t sd=
 =3D pc=2Esd[af];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    if (sd =3D=3D SOCKET_UNDEFINED)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            continue; /* family not probed, see oob_probe_sockets_open() =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef TARGET_ANDROID</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        /* Keep the probe out o=
f an active tunnel, as the connection socket is=2E</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-         * protect_fd_nonlocal() declines a lo=
cal peer, so only a non-local one</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-         * actually protects the socket and may latch the flag=
=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!pc=
=2Efd_protected[af] &amp;&amp; !addr_local(&amp;targets[i]=2Edest=2Eaddr=2E=
sa))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            protect_fd_nonloc=
al(sd, &amp;targets[i]=2Edest=2Eaddr=2Esa);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            pc=2Efd_protected[af] =3D true;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        const int seen =3D oob_addr_list_find(pc=2Eprobed,=
 pc=2En_probed, &amp;targets[i]=2Edest);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        if (seen &gt;=3D 0)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            /* Already probed this round by an earlier entry: =
reuse that send</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
       * time, so both entries report the same RTT for the one reply=2E */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            targets[i]=
=2Esent_at =3D pc=2Eprobed_at[seen];</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            openvp=
n_gettimeofday(&amp;targets[i]=2Esent_at, NULL);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            if (sendto(sd, (const char *)BPTR(&a=
mp;probe), (int)BLEN(&amp;probe), 0,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                       (struct sockaddr *)&amp;targets[i]=2E=
dest, targets[i]=2Edestlen)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                &lt; 0)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                msg(D_LOW, &quot;server-probe: %s:%s: probe send failed&quo=
t;, ce-&gt;remote, ce-&gt;remote_port);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                continue;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            pc=2Eprobed_at[pc=2En_probed] =3D targets[i]=2Ese=
nt_at;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            pc=
=2Eprobed[pc=2En_probed++] =3D targets[i]=2Edest;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        targets[i]=2Esent =3D true;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        t-&gt;sent =3D true;</span><br><s=
pan>         sent_count++;</span><br><span>     }</span><br><span> </span><=
br><span>diff --git a/tests/unit_tests/openvpn/test_oob=2Ec b/tests/unit_te=
sts/openvpn/test_oob=2Ec</span><br><span>index 8973f04=2E=2E26aacaf 100644<=
/span><br><span>--- a/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span=
>+++ b/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>@@ -519,10 +51=
9,12 @@</span><br><span>     return sa;</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* One probed addr=
ess per entry=2E */</span><br><span> static struct oob_probe_target</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-probe_target(struct openvpn_s=
ockaddr dest, bool sent)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+probe_target(struct openvpn_sockaddr *dest, bool sent)</span><br><span=
> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return (struct=
 oob_probe_target){ =2Edest =3D dest, =2Edestlen =3D sizeof(dest=2Eaddr=2Ei=
n4), =2Esent =3D sent };</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    static socklen_t len =3D sizeof(struct sockaddr_in);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    return (struct oob_probe_targ=
et){ =2Edests =3D dest, =2Edestlens =3D &amp;len, =2En_dests =3D 1, =2Esent=
 =3D sent };</span><br><span> }</span><br><span> </span><br><span> /* Two e=
ntries resolve to the same address=2E The first reply from it is</span><br>=
<span>@@ -531,7 +533,7 @@</span><br><span> test_probe_reply_credits_every_e=
ntry_at_address(void **state)</span><br><span> {</span><br><span>     struc=
t openvpn_sockaddr a =3D v4_addr(0x7f000001, 1194);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct oob_probe_target targets[2] =3D =
{ probe_target(a, true), probe_target(a, true) };</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct oob_probe_target targets[2] =3D { =
probe_target(&amp;a, true), probe_target(&amp;a, true) };</span><br><span> =
    struct oob_probe_result results[2] =3D { 0 };</span><br><span> </span><=
br><span>     int i =3D oob_probe_next_target_at(&amp;a, targets, results, =
2, 0);</span><br><span>@@ -555,9 +557,9 @@</span><br><span>     struct open=
vpn_sockaddr b =3D v4_addr(0x7f000002, 1194);</span><br><span>     struct o=
penvpn_sockaddr a_other_port =3D v4_addr(0x7f000001, 1195);</span><br><span=
>     struct oob_probe_target targets[3] =3D {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        probe_target(a, true),</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        probe_target(b, true),</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        probe_target(a, false), =
/* resolved but never sent */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        probe_target(&amp;a, true),</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        probe_target(&amp;b, true),</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        probe_target(&amp;a, fals=
e), /* resolved but never sent */</span><br><span>     };</span><br><span> =
    struct oob_probe_result results[3] =3D { 0 };</span><br><span> </span><=
br><span>@@ -568,6 +570,70 @@</span><br><span>     assert_int_equal(oob_pro=
be_next_target_at(&amp;a_other_port, targets, results, 3, 0), -1);</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/* A remote with several addresses is credited whichever of them a=
nswers=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static =
void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_probe_repl=
y_matches_any_address_of_entry(void **state)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct openvpn_sockaddr addrs[2] =3D { v4_addr(0x7f000001, 1194)=
, v4_addr(0x7f000002, 1194) };</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    socklen_t lens[2] =3D { sizeof(struct sockaddr_in), sizeof(s=
truct sockaddr_in) };</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct oob_probe_target targets[1] =3D {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        { =2Edests =3D addrs, =2Edestlens =3D le=
ns, =2En_dests =3D 2, =2Esent =3D true },</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct oob_probe_result results[1] =3D { 0 };</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_int_equal(oob_probe_next_target_at(&amp;addr=
s[1], targets, results, 1, 0), 0);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_int_equal(oob_probe_next_target_at(&amp;addrs[0],=
 targets, results, 1, 0), 0);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/* The RTT of a reply is me=
asured from the probe sent to the address that</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * answered, not from the first probe sent for t=
he remote=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stat=
ic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_probe_r=
tt_per_address(void **state)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t openvpn_sockaddr addrs[2] =3D { v4_addr(0x7f000001, 1194), v4_addr(0x7f00=
0002, 1194) };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
ocklen_t lens[2] =3D { sizeof(struct sockaddr_in), sizeof(struct sockaddr_i=
n) };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* A went =
out at t=3D0 ms, B 20 ms later */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    struct timeval sent_at[2] =3D { { =2Etv_sec =3D 1000, =2E=
tv_usec =3D 0 }, { =2Etv_sec =3D 1000, =2Etv_usec =3D 20000 } };</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_target t =
=3D { =2Edests =3D addrs, =2Edestlens =3D lens, =2Esent_at =3D sent_at, =2E=
n_dests =3D 2, =2Esent =3D true };</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct timeval rcv =3D { =2Etv_sec =3D 1000, =2Etv_usec =
=3D 25000 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(oob_p=
robe_rtt_ms(&amp;t, &amp;addrs[1], &amp;rcv), 5);  /* B: 25 - 20 */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(oob_pr=
obe_rtt_ms(&amp;t, &amp;addrs[0], &amp;rcv), 25); /* A: 25 - 0 */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* an address of the remote that was never s=
ent to, and a stranger */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    sent_at[1] =3D (struct timeval){ 0 };</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_int_equal(oob_probe_rtt_ms(&amp;t, &=
amp;addrs[1], &amp;rcv), -1);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct openvpn_sockaddr other =3D v4_addr(0x7f000003, 1194);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal=
(oob_probe_rtt_ms(&amp;t, &amp;other, &amp;rcv), -1);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* a clock that went backwards reads as 0, not as a huge=
 value */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rcv=2E=
tv_usec =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
ent_at[0]=2Etv_usec =3D 5000;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_int_equal(oob_probe_rtt_ms(&amp;t, &amp;addrs[0], &amp=
;rcv), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/* IPv6 addresses match on address and port to=
o=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_probe_addresses=
_ipv6(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct openvpn=
_sockaddr a =3D { 0 }, b =3D { 0 };</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    a=2Eaddr=2Ein6=2Esin6_family =3D AF_INET6;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    a=2Eaddr=2Ein6=2Esin6_addr=
=2Es6_addr[15] =3D 1; /* ::1 */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    a=2Eaddr=2Ein6=2Esin6_port =3D htons(1194);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    b =3D a;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    b=2Eaddr=2Ein6=2Esin6_port =3D htons(=
1195);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    socklen_t=
 len =3D sizeof(struct sockaddr_in6);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct oob_probe_target targets[1] =3D {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        { =2Edests =3D &amp;a, =
=2Edestlens =3D &amp;len, =2En_dests =3D 1, =2Esent =3D true },</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct oob_probe_result results[1] =3D {=
 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(oob_probe_ne=
xt_target_at(&amp;a, targets, results, 1, 0), 0);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_int_equal(oob_probe_next_target_at=
(&amp;b, targets, results, 1, 0), -1);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_int_equal(oob_addr_list_find(&amp;a, 1, &amp;=
a), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_i=
nt_equal(oob_addr_list_find(&amp;a, 1, &amp;b), -1);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> /* The per-round list of probed addresses=
 compares address and port=2E */</span><br><span> static void</span><br><sp=
an> test_addr_list_find(void **state)</span><br><span>@@ -973,6 +1039,9 @@<=
/span><br><span>         cmocka_unit_test(test_server_probe_check_no_parame=
ter),</span><br><span>         cmocka_unit_test(test_probe_reply_credits_ev=
ery_entry_at_address),</span><br><span>         cmocka_unit_test(test_probe=
_reply_matches_only_its_address),</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        cmocka_unit_test(test_probe_reply_matches_any_address=
_of_entry),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
cmocka_unit_test(test_probe_rtt_per_address),</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_probe_addresses_ipv=
6),</span><br><span>         cmocka_unit_test(test_addr_list_find),</span><=
br><span>         cmocka_unit_test(test_client_reply_read_finds_reply),</sp=
an><br><span>         cmocka_unit_test(test_client_reply_read_skips_unknown=
),</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1751?usp=3Demail">change 1751</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1751?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I00208610e0ce4=
f3ed9a87233e68ece1b3b8a768a </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 1751 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 26 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2En=
et&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-A=
ttention: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>

</b=
ody></html>
--GeEtD8LD55Q=--


--===============9105146490822201987==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9105146490822201987==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9105146490822201987==--

