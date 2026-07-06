Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E9FC44501
	for <openvpn-devel@archiver.kernel.org>; Mon,  6 Jul 2026 06:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dFK2Yf4AtB040edNwF4XmxM8HhfATagaXzFTdpacwtI=; b=DYxLy6pS3McI2tR8YetHf3+j31
	GIYy14Eej49jLZFT5n+eHkeZCwHQ07JGEwuhBn3MEoh7SJlt25iyfvG0KQ3f9vYLIYNFetefbA9V9
	QV1FnN0wqJSBusFdlHir5GDlX6NO2oUFiw/se4XPcs7+RBHd/azLIIGUiA14FUO4hJF0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wgdAc-0001Bz-0E;
	Mon, 06 Jul 2026 06:51:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wgdAa-0001Bs-Jk
 for openvpn-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 06:51:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=gg0e3aFty41Pbjsyr2w+0UNYiRqX0dgU+uSJCyDRnhI=; b=jV6geArWrQiOFZiTtO5yGvkEM4
 xd0m6vKtoAmYQQGTrDDshsffkihvu55AsPsn0XjKHtVs1eXY2B5qwUJtF70iceVlbpv5yOy7dZxhS
 zzRapHLfvAXWKYUmRdzEPg1xJhXoEqSGleY5yQiJ1U88mnFI9Se0D/bsDuVaHeIPp6Vg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=gg0e3aFty41Pbjsyr2w+0UNYiRqX0dgU+uSJCyDRnhI=; b=G
 LsbuTi1bFayfzgQt6SvyxW3BM3XNofrOdsP59yryhbVrEvnAbuJ9Pwy7vUPOMgqCNLS9rBRvPAX+L
 N5VYPp6b8Y0T/3VEUjw5RBARBXCRtrgzN7cNY+3hv8m2E7b1l+cCD3YgbI5PCav1TsQhvZGzBSGvu
 k6Pjiykt4He7umLk=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wgdAZ-00045J-0G for openvpn-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 06:51:09 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-493c5220cb7so19714165e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 05 Jul 2026 23:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783320661; x=1783925461; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gg0e3aFty41Pbjsyr2w+0UNYiRqX0dgU+uSJCyDRnhI=;
 b=TULppllZG+4wfCaD9seOphTuCfhBLsBenuaWdA7zwSBa4Wwxm29OIq6qeULCxVlGI2
 SqNYTzjMMtVmzF6OKa9Xo2ELcjtz/aP2AQRXK9vQEN1LnU50uUJAKgPg8xmK3uPNsSyc
 7s1ME4GznyU3eIs8dBdrJlV++22C0Us7k1MmJVE5wse3cID6ofWwtfU550Yr8XqjgBww
 pesjiCRpj6815wR32dzKOqPKY4lPmjuW+oik6aJZ7Gc9YIdH6QG9qhC5JTvG+/t7kjyM
 m2OReHNwYjLrNPnaLrE5dc6SZQq0P6WlD1qHGURJxfLz+CdAkYTUEGLiaK+C8xO4XMDB
 GVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783320661; x=1783925461;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gg0e3aFty41Pbjsyr2w+0UNYiRqX0dgU+uSJCyDRnhI=;
 b=jc9BCyoR1TWgm3pLK+DnR8XF0ivcdGhlI/SiLjW7QHbCMFw/ixCnayXQvu5P1hrFRQ
 uZ09MygkAzibS9a+Iihl1zsufTKJuf2k+9gVn6DcllXkiO5r1ClIi/Py26Srw9C37kOn
 bBla+Q8a5UgoX0aLPSmCsug46ZI9V4EBVRE+7q3eLPrH7euZgGZrgjpXVc7cZr+4J+WB
 mCrwvya1k6IYfM0OXcPQ8fQY+8nzWuuiuS5xNtSRvE7TcE+nFaAWFdjuVLgLq3MoXU25
 Z7aN831svX/7q3T2ySJ9JRPI5iEFlIkSQGsmMLhgjRLCuSth4JuAO/3j38rl0/w6H156
 DQUg==
X-Gm-Message-State: AOJu0YwgHJWFHtMMLYM+pC5OnaJb8OJyinvS1OJu64kA8e4q6vCUvoak
 GkumKua+aR+k5WkTEi3pD7IwyGYrpDREsxRaeKt9D+ZCIZ3uqsw1zh9NYQDnjsH+SDUmrPSIR3W
 VvKB6Pi+TM8tFVkenlcM0XmJTjZnclMtIxbcsm5X/t4xiuJMK0fGra+upYceaKFPbsm/aseC7QF
 lIZ4z8MA==
X-Gm-Gg: AfdE7clxuK3pjsa+TTmyUL5Vshg8J9u9uu59MByF84K9Jl5h9DKf/uOlWc6kJag7i0l
 uI6R0keA6UgrbEkeEg6IJnV6LTgF3ewVr23IxH2MvNbCmGZZr78PQEQBbSILWJGh7gOq2t+raek
 XWEeBg/yzDGab96QEgsH9JCqZ+Mb6eHR3wd+C8M9+FNmTSa9D0m9KtERaPcuoE8UMGesxKTuofr
 O0Aex0dyY9jPxBVs7i0n2LllFMLJltGylr4gGSZUL0yNJWMInCD+XSrQI/rVC1TYINtDW/scaPx
 QnZtPlDCzbhDKtXH6q13FN0snf7y58C/ZcWYSFOBxmFvMoDQeGm2D8U7KDRB0UDUFfdtXT632qG
 A3papMVjChaqQgH4N+3STlQaTPHDjW2u8js98Ml57TKLwUWuxw/k7JzDk7+0GoVkTT5Mx5MOh0S
 p9MD6mR7ybmDQodaXNoDhx53fZJzuLdPoDc37JsJ1fbsG2SiV4b1HGZzXO+M6NZWQ7/TARDiEEt
 qo7D/2FLr+K8avIRQdkKnE4v4KHvrb9QIK5pISDYsOc1dnRXNgaFFZZL27qYosvearF3pIR+XJJ
 +NQ=
X-Received: by 2002:a05:600c:1f8f:b0:492:7142:f46e with SMTP id
 5b1f17b1804b1-493d11cecabmr107624915e9.2.1783320660727; 
 Sun, 05 Jul 2026 23:51:00 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0f2186bsm21754273f8f.36.2026.07.05.23.51.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 23:51:00 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 6 Jul 2026 06:50:47 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I00208610e0ce4f3ed9a87233e68ece1b3b8a768a
X-Gerrit-Change-Number: 1751
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1751?usp=email>
X-Gerrit-Commit: e448b4dfc464a02d69b89dbaad7129904137020f
In-Reply-To: <gerrit.1782719911000.I00208610e0ce4f3ed9a87233e68ece1b3b8a768a@gerrit.openvpn.net>
References: <gerrit.1782719911000.I00208610e0ce4f3ed9a87233e68ece1b3b8a768a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkwMDIwODYxMGUwY2U0ZjNlZDlhODcyMzNlNjhlY2UxYjNiOGE3NjhhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f3d43b93ad4e2b54e7f7a8b159ab092be18286e5-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wgdAZ-00045J-0G
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Probe every
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
 openvpn-devel@lists.sourceforge.net
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3354363299394680591=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3354363299394680591==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bhxhjuofEmg="; charset=UTF-8

--bhxhjuofEmg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1751?usp=3Demail

to look at the new patch set (#5)=2E

=

Change subject: oob: Probe every resolved address of a remote
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Probe every resolved=
 address of a remote

A remote can resolve to several A/AAAA records; --ser=
ver-probe previously
sent a SERVER_PROBE only to the first one, so a remote=
 whose first address
was unreachable looked unresponsive even if another ad=
dress answered, and
the connection could later try an address that was neve=
r probed=2E

Probe every resolved address of each remote in parallel (per-r=
emote storage
is sized to the resolved address count, no fixed cap), accept=
 a reply from
any of them (first reply for a remote wins), and resend to al=
l of a remote's
addresses while it is unanswered=2E

Change-Id: I00208610e0=
ce4f3ed9a87233e68ece1b3b8a768a
Signed-off-by: Lev Stipakov <lev@openvpn=2En=
et>
---
M src/openvpn/oob_client=2Ec
1 file changed, 92 insertions(+), 45 d=
eletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/ch=
anges/51/1751/5

diff --git a/src/openvpn/oob_client=2Ec b/src/openvpn/oob_=
client=2Ec
index b1ddaf1=2E=2Eda39e81 100644
--- a/src/openvpn/oob_client=
=2Ec
+++ b/src/openvpn/oob_client=2Ec
@@ -52,11 +52,15 @@
 #define OOB_PROB=
E_RETRIES 1
 
 /* Where we sent a probe, so a reply's source address can be=
 matched back to the
- * connection-list entry it belongs to=2E */
+ * conn=
ection-list entry it belongs to=2E A remote may resolve to several
+ * addr=
esses, all of which are probed; a reply from any of them counts=2E The
+ * =
@p dests / @p destlens arrays are gc-allocated, sized to the remote's resol=
ved
+ * address count=2E */
 struct probe_target
 {
-    struct sockaddr_st=
orage dest;
-    socklen_t destlen;
+    struct sockaddr_storage *dests;
+ =
   socklen_t *destlens;
+    int n_dests;
     bool sent;
     struct timev=
al sent_at; /* when the probe was sent, for RTT measurement */
 };
@@ -175,=
6 +179,29 @@
     }
 }
 
+/* Send the probe to every resolved address of @p=
 t, each on the socket matching
+ * its address family=2E Returns true if a=
t least one send succeeded=2E */
+static bool
+oob_probe_send_target(const =
struct probe_ctx *pc, const struct buffer *probe,
+                      co=
nst struct probe_target *t)
+{
+    bool any_sent =3D false;
+    for (int =
k =3D 0; k < t->n_dests; k++)
+    {
+        socket_descriptor_t sd =3D pc=
->sd[probe_af_index(t->dests[k]=2Ess_family)];
+        if (sd =3D=3D SOCKE=
T_UNDEFINED)
+        {
+            continue;
+        }
+        if (send=
to(sd, (const char *)BPTR(probe), (int)BLEN(probe), 0,
+                   =
(const struct sockaddr *)&t->dests[k], t->destlens[k])
+            >=3D 0)=

+        {
+            any_sent =3D true;
+        }
+    }
+    return a=
ny_sent;
+}
 
 /* Parse one received datagram as a PROBE_REPLY and, if vali=
d and matching one
  * of the probes we sent, record the reply in @p result=
s=2E */
@@ -216,25 +243,38 @@
         return;
     }
 
-    /* Match the r=
eply's source address to the remote we probed=2E */
+    /* Match the reply=
's source address to one of the addresses we probed for a
+     * remote=2E=
 The first reply for a remote wins (a remote with several addresses
+     *=
 may answer from more than one)=2E */
     for (int i =3D 0; i < n; i++)
  =
   {
-        if (targets[i]=2Esent
-            && addr_port_match((const =
struct openvpn_sockaddr *)(const void *)from,
-                            =
   (const struct openvpn_sockaddr *)(const void *)&targets[i]=2Edest))
+   =
     if (!targets[i]=2Esent || results[i]=2Eresponded)
         {
-        =
    struct timeval rcv;
-            openvpn_gettimeofday(&rcv, NULL);
-   =
         long ms =3D (long)(rcv=2Etv_sec - targets[i]=2Esent_at=2Etv_sec) *=
 1000
-                      + (rcv=2Etv_usec - targets[i]=2Esent_at=2Etv_u=
sec) / 1000;
-
-            results[i]=2Eresponded =3D true;
-            r=
esults[i]=2Epriority =3D reply=2Epriority;
-            results[i]=2Eweight=
 =3D reply=2Eweight;
-            results[i]=2Emax_latency_diff =3D reply=
=2Emax_latency_diff;
-            results[i]=2Ertt_ms =3D (ms > 0) ? (unsig=
ned int)ms : 0;
-            break;
+            continue;
         }
+
+  =
      bool match =3D false;
+        for (int k =3D 0; k < targets[i]=2En_d=
ests && !match; k++)
+        {
+            match =3D addr_port_match((con=
st struct openvpn_sockaddr *)(const void *)from,
+                         =
           (const struct openvpn_sockaddr *)(const void *)&targets[i]=2Edes=
ts[k]);
+        }
+        if (!match)
+        {
+            continue;
+=
        }
+
+        struct timeval rcv;
+        openvpn_gettimeofday(&rcv=
, NULL);
+        long ms =3D (long)(rcv=2Etv_sec - targets[i]=2Esent_at=2E=
tv_sec) * 1000
+                  + (rcv=2Etv_usec - targets[i]=2Esent_at=
=2Etv_usec) / 1000;
+
+        results[i]=2Eresponded =3D true;
+        re=
sults[i]=2Epriority =3D reply=2Epriority;
+        results[i]=2Eweight =3D =
reply=2Eweight;
+        results[i]=2Emax_latency_diff =3D reply=2Emax_late=
ncy_diff;
+        results[i]=2Ertt_ms =3D (ms > 0) ? (unsigned int)ms : 0;=

+        break;
     }
 }
 
@@ -327,12 +367,7 @@
     {
         if (targe=
ts[i]=2Esent && !results[i]=2Eresponded)
         {
-            socket_des=
criptor_t sd =3D pc->sd[probe_af_index(targets[i]=2Edest=2Ess_family)];
-  =
          if (sd !=3D SOCKET_UNDEFINED)
-            {
-                sen=
dto(sd, (const char *)BPTR(probe), (int)BLEN(probe), 0,
-                  =
     (const struct sockaddr *)&targets[i]=2Edest, targets[i]=2Edestlen);
- =
           }
+            oob_probe_send_target(pc, probe, &targets[i]);
  =
       }
     }
 }
@@ -500,33 +535,45 @@
             continue;
         }
=
 
-        /* Probe the first resolved address on the socket matching its a=
ddress
-         * family (stored natively; no IPv4-mapping)=2E */
-       =
 socket_descriptor_t sd =3D pc=2Esd[probe_af_index(ai->ai_family)];
-      =
  if (sd =3D=3D SOCKET_UNDEFINED)
+        /* Collect every resolved addres=
s whose address family has a probe socket=2E
+         * Each address is st=
ored natively (no IPv4-mapping) and later probed on
+         * its AF sock=
et=2E Storage is sized to the resolved address count=2E */
+        struct =
probe_target *t =3D &targets[i];
+        int n_addr =3D 0;
+        for (c=
onst struct addrinfo *a =3D ai; a; a =3D a->ai_next)
+        {
+          =
  n_addr++;
+        }
+        t->dests =3D gc_malloc(sizeof(*t->dests) * =
n_addr, true, &gc);
+        t->destlens =3D gc_malloc(sizeof(*t->destlens)=
 * n_addr, true, &gc);
+        for (const struct addrinfo *a =3D ai; a; a =
=3D a->ai_next)
+        {
+            if (pc=2Esd[probe_af_index(a->ai_fa=
mily)] =3D=3D SOCKET_UNDEFINED)
+            {
+                continue; /=
* no socket for this address family */
+            }
+            memcpy(&=
t->dests[t->n_dests], a->ai_addr, a->ai_addrlen);
+            t->destlens[=
t->n_dests] =3D (socklen_t)a->ai_addrlen;
+            t->n_dests++;
+     =
   }
+        freeaddrinfo(ai);
+
+        if (t->n_dests =3D=3D 0)
       =
  {
             msg(D_LOW, "server-probe: %s:%s: not reachable by the prob=
e socket", ce->remote,
                 ce->remote_port);
+            cont=
inue;
         }
-        else
+
+        if (!oob_probe_send_target(&pc, &=
probe, t))
         {
-            memcpy(&targets[i]=2Edest, ai->ai_addr, =
ai->ai_addrlen);
-            socklen_t destlen =3D (socklen_t)ai->ai_addrl=
en;
-            if (sendto(sd, (const char *)BPTR(&probe), (int)BLEN(&prob=
e), 0,
-                       (struct sockaddr *)&targets[i]=2Edest, destl=
en)
-                < 0)
-            {
-                msg(D_LOW, "serve=
r-probe: %s:%s: probe send failed", ce->remote, ce->remote_port);
-        =
    }
-            else
-            {
-                openvpn_gettimeofda=
y(&targets[i]=2Esent_at, NULL);
-                targets[i]=2Edestlen =3D d=
estlen;
-                targets[i]=2Esent =3D true;
-                sent_=
count++;
-            }
+            msg(D_LOW, "server-probe: %s:%s: probe=
 send failed", ce->remote, ce->remote_port);
+            continue;
       =
  }
-        freeaddrinfo(ai);
+
+        openvpn_gettimeofday(&t->sent_at,=
 NULL);
+        t->sent =3D true;
+        sent_count++;
     }
 
     if =
(sent_count > 0)

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1751?usp=3Demail
To unsubscribe, or for help writing mail filters, visi=
t http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: n=
ewpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: =
I00208610e0ce4f3ed9a87233e68ece1b3b8a768a
Gerrit-Change-Number: 1751
Gerrit=
-PatchSet: 5
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc=
2549=2Eorg>

--bhxhjuofEmg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #5</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1751?usp=3Demail">View Change</a></p><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">oob: Prob=
e every resolved address of a remote<br><br>A remote can resolve to several=
 A/AAAA records; --server-probe previously<br>sent a SERVER_PROBE only to t=
he first one, so a remote whose first address<br>was unreachable looked unr=
esponsive even if another address answered, and<br>the connection could lat=
er try an address that was never probed=2E<br><br>Probe every resolved addr=
ess of each remote in parallel (per-remote storage<br>is sized to the resol=
ved address count, no fixed cap), accept a reply from<br>any of them (first=
 reply for a remote wins), and resend to all of a remote&#39;s<br>addresses=
 while it is unanswered=2E<br><br>Change-Id: I00208610e0ce4f3ed9a87233e68ec=
e1b3b8a768a<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---=
<br>M src/openvpn/oob_client=2Ec<br>1 file changed, 92 insertions(+), 45 de=
letions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet=
:29418/openvpn refs/changes/51/1751/5</pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/oob_=
client=2Ec b/src/openvpn/oob_client=2Ec</span><br><span>index b1ddaf1=2E=2E=
da39e81 100644</span><br><span>--- a/src/openvpn/oob_client=2Ec</span><br><=
span>+++ b/src/openvpn/oob_client=2Ec</span><br><span>@@ -52,11 +52,15 @@</=
span><br><span> #define OOB_PROBE_RETRIES 1</span><br><span> </span><br><sp=
an> /* Where we sent a probe, so a reply&#39;s source address can be matche=
d back to the</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * conne=
ction-list entry it belongs to=2E */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * connection-list entry it belongs to=2E A remote may res=
olve to several</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * a=
ddresses, all of which are probed; a reply from any of them counts=2E The</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p dests / @p dest=
lens arrays are gc-allocated, sized to the remote&#39;s resolved</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * address count=2E */</span><=
br><span> struct probe_target</span><br><span> {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    struct sockaddr_storage dest;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    socklen_t destlen;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct sockaddr_storage *dest=
s;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    socklen_t *de=
stlens;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int n_de=
sts;</span><br><span>     bool sent;</span><br><span>     struct timeval se=
nt_at; /* when the probe was sent, for RTT measurement */</span><br><span> =
};</span><br><span>@@ -175,6 +179,29 @@</span><br><span>     }</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/* Send the probe to every resolved address of @p t, each on the socke=
t matching</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * its ad=
dress family=2E Returns true if at least one send succeeded=2E */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+oob_probe_send_target(const struct pr=
obe_ctx *pc, const struct buffer *probe,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                      const struct probe_target *t)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    bool any_sent =3D false;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    for (int k =3D 0; k &lt; t-=
&gt;n_dests; k++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        socket_d=
escriptor_t sd =3D pc-&gt;sd[probe_af_index(t-&gt;dests[k]=2Ess_family)];</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (sd =3D=3D=
 SOCKET_UNDEFINED)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 continue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (sendto(=
sd, (const char *)BPTR(probe), (int)BLEN(probe), 0,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                   (const struct sockaddr=
 *)&amp;t-&gt;dests[k], t-&gt;destlens[k])</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            &gt;=3D 0)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            any_sent =3D true;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    return any_sent;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span> </span><br><span> /* Parse one received datagram as =
a PROBE_REPLY and, if valid and matching one</span><br><span>  * of the pro=
bes we sent, record the reply in @p results=2E */</span><br><span>@@ -216,2=
5 +243,38 @@</span><br><span>         return;</span><br><span>     }</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Mat=
ch the reply&#39;s source address to the remote we probed=2E */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /* Match the reply&#39;s so=
urce address to one of the addresses we probed for a</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * remote=2E The first reply for a re=
mote wins (a remote with several addresses</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * may answer from more than one)=2E */</span><b=
r><span>     for (int i =3D 0; i &lt; n; i++)</span><br><span>     {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        if (targets[i]=2Esen=
t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            &amp;&am=
p; addr_port_match((const struct openvpn_sockaddr *)(const void *)from,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                         =
      (const struct openvpn_sockaddr *)(const void *)&amp;targets[i]=2Edest=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!targ=
ets[i]=2Esent || results[i]=2Eresponded)</span><br><span>         {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            struct timeval rc=
v;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            openvpn=
_gettimeofday(&amp;rcv, NULL);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            long ms =3D (long)(rcv=2Etv_sec - targets[i]=2Esent_at=
=2Etv_sec) * 1000</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                  + (rcv=2Etv_usec - targets[i]=2Esent_at=2Etv_usec) / 1000=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            results[i]=2Eresponded =3D tr=
ue;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            result=
s[i]=2Epriority =3D reply=2Epriority;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            results[i]=2Eweight =3D reply=2Eweight;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            results[i]=2Emax_=
latency_diff =3D reply=2Emax_latency_diff;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            results[i]=2Ertt_ms =3D (ms &gt; 0) ? (uns=
igned int)ms : 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       continue;</span><br><span>         }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        bool match =3D false;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        for (int k =3D 0; k &lt; targets[i]=2En_dests &amp;&=
amp; !match; k++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
match =3D addr_port_match((const struct openvpn_sockaddr *)(const void *)fr=
om,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
                    (const struct openvpn_sockaddr *)(const void *)&amp;tar=
gets[i]=2Edests[k]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f (!match)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            continu=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        struct timeval rcv;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        openvpn_gettimeofday(&amp;rcv,=
 NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        long=
 ms =3D (long)(rcv=2Etv_sec - targets[i]=2Esent_at=2Etv_sec) * 1000</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                  + (rcv=2E=
tv_usec - targets[i]=2Esent_at=2Etv_usec) / 1000;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        results[i]=2Eresponded =3D true;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        results[i]=2Epriority =3D reply=
=2Epriority;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 results[i]=2Eweight =3D reply=2Eweight;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        results[i]=2Emax_latency_diff =3D reply=2Emax_=
latency_diff;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  results[i]=2Ertt_ms =3D (ms &gt; 0) ? (unsigned int)ms : 0;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        break;</span><br><span>  =
   }</span><br><span> }</span><br><span> </span><br><span>@@ -327,12 +367,7=
 @@</span><br><span>     {</span><br><span>         if (targets[i]=2Esent &=
amp;&amp; !results[i]=2Eresponded)</span><br><span>         {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            socket_descriptor_t sd =
=3D pc-&gt;sd[probe_af_index(targets[i]=2Edest=2Ess_family)];</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            if (sd !=3D SOCKET_UNDE=
FINED)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                sendto(=
sd, (const char *)BPTR(probe), (int)BLEN(probe), 0,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                       (const struct sockad=
dr *)&amp;targets[i]=2Edest, targets[i]=2Edestlen);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            oob_probe_send_target(pc, probe, &amp=
;targets[i]);</span><br><span>         }</span><br><span>     }</span><br><=
span> }</span><br><span>@@ -500,33 +535,45 @@</span><br><span>             =
continue;</span><br><span>         }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        /* Probe the first resolved addres=
s on the socket matching its address</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-         * family (stored natively; no IPv4-mapping)=2E */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        socket_descript=
or_t sd =3D pc=2Esd[probe_af_index(ai-&gt;ai_family)];</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        if (sd =3D=3D SOCKET_UNDEFINED)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Collect eve=
ry resolved address whose address family has a probe socket=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+         * Each address is store=
d natively (no IPv4-mapping) and later probed on</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+         * its AF socket=2E Storage is sized t=
o the resolved address count=2E */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        struct probe_target *t =3D &amp;targets[i];</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        int n_addr =3D 0;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (const str=
uct addrinfo *a =3D ai; a; a =3D a-&gt;ai_next)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            n_addr++;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        t-&gt;dests =3D gc_malloc(sizeof(*t-&gt;dests) * n_addr, =
true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    t-&gt;destlens =3D gc_malloc(sizeof(*t-&gt;destlens) * n_addr, true, &a=
mp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for =
(const struct addrinfo *a =3D ai; a; a =3D a-&gt;ai_next)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            if (pc=2Esd[probe_af_index(a-&gt;ai=
_family)] =3D=3D SOCKET_UNDEFINED)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                continue; /* no socket for this address family */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            memcpy(&amp;t-=
&gt;dests[t-&gt;n_dests], a-&gt;ai_addr, a-&gt;ai_addrlen);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            t-&gt;destlens[t-&gt;n_=
dests] =3D (socklen_t)a-&gt;ai_addrlen;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            t-&gt;n_dests++;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        freeaddrinfo(ai);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (t-&gt;n_dests =3D=3D 0)</span><br><span>         {</span>=
<br><span>             msg(D_LOW, &quot;server-probe: %s:%s: not reachable =
by the probe socket&quot;, ce-&gt;remote,</span><br><span>                 =
ce-&gt;remote_port);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            continue;</span><br><span>         }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        else</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        if (!oob_probe_send_target(&amp;pc, &amp;probe, t))</span><br><sp=
an>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    memcpy(&amp;targets[i]=2Edest, ai-&gt;ai_addr, ai-&gt;ai_addrlen);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            socklen_t dest=
len =3D (socklen_t)ai-&gt;ai_addrlen;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            if (sendto(sd, (const char *)BPTR(&amp;probe), =
(int)BLEN(&amp;probe), 0,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                       (struct sockaddr *)&amp;targets[i]=2Edest, destl=
en)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                &l=
t; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                msg(D_LO=
W, &quot;server-probe: %s:%s: probe send failed&quot;, ce-&gt;remote, ce-&g=
t;remote_port);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            el=
se</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                openvpn_get=
timeofday(&amp;targets[i]=2Esent_at, NULL);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                targets[i]=2Edestlen =3D destlen;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                targets[i=
]=2Esent =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             sent_count++;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           msg(D_LOW, &quot;server-probe: %s:%s: probe send failed&quot;, c=
e-&gt;remote, ce-&gt;remote_port);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            continue;</span><br><span>         }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        freeaddrinfo(ai);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        openvpn_gettimeofday(&amp;t-&gt;sent_a=
t, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        t-=
&gt;sent =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       sent_count++;</span><br><span>     }</span><br><span> </span><br><sp=
an>     if (sent_count &gt; 0)</span><br><span></span><br></pre><p>To view,=
 visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1751?usp=3Demai=
l">change 1751</a>=2E To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings<=
/a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction">=
<link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/17=
51?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<d=
iv style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"dis=
play:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerri=
t-Change-Id: I00208610e0ce4f3ed9a87233e68ece1b3b8a768a </div>
<div style=3D=
"display:none"> Gerrit-Change-Number: 1751 </div>
<div style=3D"display:non=
e"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: st=
ipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--bhxhjuofEmg=--


--===============3354363299394680591==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3354363299394680591==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3354363299394680591==--

