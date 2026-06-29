Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B56C43602
	for <openvpn-devel@archiver.kernel.org>; Mon, 29 Jun 2026 07:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=pKQC/Oswrv7u2lEXPSm1pZBGzewQ7wStJdwW6ykI3vo=; b=Bz5sMnzMLn5uMv
	qXjWZSciEX+XcGnMt2B9nFEx6IGjw9KjAdBHbaWIm3eU6Jfdlq8UiOVXYr91NjeM/xgdVKsgsC0no
	MuTGa3IFyEXrWjNi/CxCM60PoIGKj/OSifakH4gw+TMpcWRkRPusAuDBZ0JIL58uzVLrWn2Zvq6OD
	A08=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1we6tk-0001FL-6T;
	Mon, 29 Jun 2026 07:59:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1we6ti-0001Et-R4
 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 07:59:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yvbJod0rdRHyG3l9UWUBhM/mjfSyNkM3OXlVTwGHC8s=; b=ShMOuPCVFULFS8Q6gl0IFuiF6E
 0Y2o+Rtktx6UnD0y5lmbS7ZT+uBrMCDFhlLENp7wwY6Fw60kkUfncpsNL9QFh6GqRwJuSGnf7eP54
 a+CiK12C9KNKoD/ixqnHqdXiDrpSy+C9biY0Fq0hm+dTKJ9O7GQGByzOryaWR1gnwaYw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=yvbJod0rdRHyG3l9UWUBhM/mjfSyNkM3OXlVTwGHC8s=; b=I
 MT9EPUDoAeTv2BysXmB3+mJ97+INiHqzeTaVDRyE7oVDGLSXYRTR5om7SiqkL79r72jyBb9YirU+l
 lAh4pcrIHL7NMsxWiIAee75yjd1KMHq8FPBJwrzRH2+tjqBWggX5G7xQF1zQhMK8C2gHVe9lTdRKN
 aMUQ47x9iv3qhLVE=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1we6tg-0008O9-O2 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 07:59:18 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-472326ca506so487961f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 29 Jun 2026 00:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782719946; x=1783324746; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yvbJod0rdRHyG3l9UWUBhM/mjfSyNkM3OXlVTwGHC8s=;
 b=VdZWObp5QvTsk2KvGfYr/5KWSWG6N42EVJbvEcGDMCa/8jZeA3LBQzifTgZSEzGumS
 mLOyMK5aQKhJ8eg8mEjtTHSmP+SF94P+VyahIiCR3Y7IUTkNwdTVm6a9lGPsKYyhNt69
 1AJH5AAustRxcxwXhXNo+WK5Bz+saZVJR//qsQzwfeC3SHJMPeuh8qn+vlQpN44IG9pK
 n/5LnycFL/5woClaD+b/i+i8ZLnofTJxx351ILPMciWNG/L+tIJa6Z8M2ocd1lMTy0U/
 v2++QHjj5sPzQZofKNsuZnTNu554k28JNbTwQroqvJJShy24UEsSZ6bzknr7b4m1TMrK
 Blqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782719946; x=1783324746;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yvbJod0rdRHyG3l9UWUBhM/mjfSyNkM3OXlVTwGHC8s=;
 b=SB6bcGOmGmSj+W6gmwyzTEoo0ul7dTHJGQWbpv5Lhn/+pwRkiEZZTs0k+dePn3zrFJ
 B3RDOCAxcHSPeDYqcIGFLoLTl2RVHtUoPib+ktzTnMU+A+58FakESZ16GhgbzMud95MD
 vYcUPT+7eqW9pmUcsMPSMYFoA2YgffXnF4M7qnT7plyW0wRJJGDdh4QSm/TUrK1xvroq
 4tmnwG3ft+4xnDYut9LIsPxhd/118KrZ6f9dS8h66iIgeuFHw0M6sfgI8q30utX6TMHa
 D9TdFZyWDhISnlErGE1KCwRHbw3f/kgrNmGQKYsEjpNw5PlNSMBuGd31ufPtKr8+ZT2C
 ou0g==
X-Gm-Message-State: AOJu0YyLCvPUcLEou/gV1Y89Ic6gvlQeyDYa5Lr14dCkMPqbXe1EL16t
 CoVcXYp4hf8SNQ2wD3xNoMjScAoYe1Mm4p9j644gFDL/CY/XgSFD4BTIZEcZY+VlxRT22ddJvkq
 NHo9HM+HR06E2UL4TURx12XR1ElfKj0E7w92mIj1efQsjsWJqENodufOr5kXzalvFIJu7oZWvTC
 23HjJYow==
X-Gm-Gg: AfdE7cnW8s9CYN4S5MBATXwiU6rZO9jejF6nGKOHNVYmWaROpz2/x6UiVJ6Be/1Uivv
 lf26QARQSWpOmNmEiKeX6PXCwFWlFI86MSJ5EeAAGSf3SFwWnXXfufu6LpCLBGbBDa9TRE0U7i1
 PUX5vr0l767DDRrbCY7O/1RM58O7blKdWUoXX9mNHvIURNoXYjY4iFmJ0zrH1nKpkJpGlNZ71xk
 AbeOjJC/CUfksN1re86uJgtICL9i9X2tMuZrW4ZXG/EA6lZ3DYrmEAhUHYg+KFKUKj4am4tz/hX
 yMZpB2c9f6nxhGmo1A1QxjKWCaD9LrnyURLdSv3rbzggqRjf/1dharjWoVkafUkyyAO078KeiBU
 AG/ieLw08pcRdFkXavozEdaqdiXMl/aFRmHhjEq/Ti+rOfjvo+D2QOExt2wGwrUlgENWvuxNBOH
 sTYt1ib0NR1YHxcVkx9WUrnVrXKKKm74qhVFUit6SwYpdsPclS5kNLNIAfAz6DXL7mZmKy3W3F7
 IkbEBR0PPXiZMxxBulxEedPKlgRks2fPG4kLjoI0OlYwc7xc9YiGDhEK2mgh7aTgVngjf2LcuPF
 7lI=
X-Received: by 2002:a05:6000:41c2:b0:471:7cbb:9beb with SMTP id
 ffacd0b85a97d-4717cbb9d3dmr12801163f8f.22.1782719945394; 
 Mon, 29 Jun 2026 00:59:05 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4728072189asm13997570f8f.30.2026.06.29.00.59.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 00:59:04 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 29 Jun 2026 07:59:04 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I00208610e0ce4f3ed9a87233e68ece1b3b8a768a
X-Gerrit-Change-Number: 1751
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1751?usp=email>
X-Gerrit-Commit: c61b7d5a2328624930aa3dd39b82659fe8c16093
References: <gerrit.1782719911000.I00208610e0ce4f3ed9a87233e68ece1b3b8a768a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkwMDIwODYxMGUwY2U0ZjNlZDlhODcyMzNlNjhlY2UxYjNiOGE3NjhhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <69be7f340203db27d3b4c91b06c1d0137b324c2f-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1we6tg-0008O9-O2
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
Content-Type: multipart/mixed; boundary="===============1462792460644063642=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1462792460644063642==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="waZ0/w3QmlA="; charset=UTF-8

--waZ0/w3QmlA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1751?usp=3Demail

to review the following change=2E


Chang=
e subject: oob: Probe every resolved address of a remote
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Probe every resolved addre=
ss of a remote

A remote can resolve to several A/AAAA records; --server-pr=
obe previously
sent a SERVER_PROBE only to the first one, so a remote whose=
 first address
was unreachable looked unresponsive even if another address =
answered, and
the connection could later try an address that was never prob=
ed=2E

Probe every resolved address of each remote in parallel (per-remote =
storage
is sized to the resolved address count, no fixed cap), accept a rep=
ly from
any of them (first reply for a remote wins), and resend to all of a=
 remote's
addresses while it is unanswered=2E

Change-Id: I00208610e0ce4f3e=
d9a87233e68ece1b3b8a768a
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
--=
-
M src/openvpn/oob_client=2Ec
1 file changed, 85 insertions(+), 33 deletio=
ns(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes=
/51/1751/1

diff --git a/src/openvpn/oob_client=2Ec b/src/openvpn/oob_clien=
t=2Ec
index 5f22650=2E=2E7391d1e 100644
--- a/src/openvpn/oob_client=2Ec
++=
+ b/src/openvpn/oob_client=2Ec
@@ -52,11 +52,15 @@
 #define OOB_PROBE_RETRI=
ES 1
 
 /* Where we sent a probe, so a reply's source address can be matche=
d back to the
- * connection-list entry it belongs to=2E */
+ * connection-=
list entry it belongs to=2E A remote may resolve to several
+ * addresses, =
all of which are probed; a reply from any of them counts=2E The
+ * @p dest=
s / @p destlens arrays are gc-allocated, sized to the remote's resolved
+ *=
 address count=2E */
 struct probe_target
 {
-    struct sockaddr_storage d=
est;
-    socklen_t destlen;
+    struct sockaddr_storage *dests;
+    sock=
len_t *destlens;
+    int n_dests;
     bool sent;
     struct timeval sent=
_at; /* when the probe was sent, for RTT measurement */
 };
@@ -173,6 +177,=
25 @@
     return 0;
 }
 
+/* Send the probe to every resolved address of @=
p t=2E Returns true if at least
+ * one send succeeded=2E */
+static bool
+=
oob_probe_send_target(socket_descriptor_t sd, const struct buffer *probe,
+=
                      const struct probe_target *t)
+{
+    bool any_sent =
=3D false;
+    for (int k =3D 0; k < t->n_dests; k++)
+    {
+        if (=
sendto(sd, (const char *)BPTR(probe), (int)BLEN(probe), 0,
+               =
    (const struct sockaddr *)&t->dests[k], t->destlens[k])
+            >=
=3D 0)
+        {
+            any_sent =3D true;
+        }
+    }
+    re=
turn any_sent;
+}
+
 /* Parse one received datagram as a PROBE_REPLY and, i=
f valid and matching one
  * of the probes we sent, record the reply in @p =
results=2E */
 static void
@@ -213,25 +236,38 @@
         return;
     }
 
=
-    /* Match the reply's source address to the remote we probed=2E */
+   =
 /* Match the reply's source address to one of the addresses we probed for =
a
+     * remote=2E The first reply for a remote wins (a remote with severa=
l addresses
+     * may answer from more than one)=2E */
     for (int i =
=3D 0; i < n; i++)
     {
-        if (targets[i]=2Esent
-            && ad=
dr_port_match((const struct openvpn_sockaddr *)(const void *)from,
-       =
                        (const struct openvpn_sockaddr *)(const void *)&tar=
gets[i]=2Edest))
+        if (!targets[i]=2Esent || results[i]=2Eresponded)=

         {
-            struct timeval rcv;
-            openvpn_gettimeof=
day(&rcv, NULL);
-            long ms =3D (long)(rcv=2Etv_sec - targets[i]=
=2Esent_at=2Etv_sec) * 1000
-                      + (rcv=2Etv_usec - targe=
ts[i]=2Esent_at=2Etv_usec) / 1000;
-
-            results[i]=2Eresponded =
=3D true;
-            results[i]=2Epriority =3D reply=2Epriority;
-       =
     results[i]=2Eweight =3D reply=2Eweight;
-            results[i]=2Emax_=
latency_diff =3D reply=2Emax_latency_diff;
-            results[i]=2Ertt_ms=
 =3D (ms > 0) ? (unsigned int)ms : 0;
-            break;
+            cont=
inue;
         }
+
+        bool match =3D false;
+        for (int k =3D 0=
; k < targets[i]=2En_dests && !match; k++)
+        {
+            match =
=3D addr_port_match((const struct openvpn_sockaddr *)(const void *)from,
+ =
                                   (const struct openvpn_sockaddr *)(const =
void *)&targets[i]=2Edests[k]);
+        }
+        if (!match)
+        {
=
+            continue;
+        }
+
+        struct timeval rcv;
+        o=
penvpn_gettimeofday(&rcv, NULL);
+        long ms =3D (long)(rcv=2Etv_sec -=
 targets[i]=2Esent_at=2Etv_sec) * 1000
+                  + (rcv=2Etv_usec =
- targets[i]=2Esent_at=2Etv_usec) / 1000;
+
+        results[i]=2Eresponded=
 =3D true;
+        results[i]=2Epriority =3D reply=2Epriority;
+        re=
sults[i]=2Eweight =3D reply=2Eweight;
+        results[i]=2Emax_latency_dif=
f =3D reply=2Emax_latency_diff;
+        results[i]=2Ertt_ms =3D (ms > 0) ?=
 (unsigned int)ms : 0;
+        break;
     }
 }
 
@@ -306,8 +342,7 @@
    =
 {
         if (targets[i]=2Esent && !results[i]=2Eresponded)
         {
- =
           sendto(sd, (const char *)BPTR(probe), (int)BLEN(probe), 0,
-    =
               (const struct sockaddr *)&targets[i]=2Edest, targets[i]=2Ede=
stlen);
+            oob_probe_send_target(sd, probe, &targets[i]);
       =
  }
     }
 }
@@ -476,26 +511,43 @@
             continue;
         }
 
-  =
      socklen_t destlen =3D oob_probe_make_dest(ai, sock_af, &targets[i]=2E=
dest);
-        if (destlen =3D=3D 0)
+        /* Collect every address thi=
s remote resolves to that the probe socket
+         * can reach=2E Storage=
 is sized to the resolved address count=2E */
+        struct probe_target =
*t =3D &targets[i];
+        int n_addr =3D 0;
+        for (const struct a=
ddrinfo *a =3D ai; a; a =3D a->ai_next)
+        {
+            n_addr++;
+=
        }
+        t->dests =3D gc_malloc(sizeof(*t->dests) * n_addr, true,=
 &gc);
+        t->destlens =3D gc_malloc(sizeof(*t->destlens) * n_addr, tr=
ue, &gc);
+        for (const struct addrinfo *a =3D ai; a; a =3D a->ai_nex=
t)
+        {
+            socklen_t destlen =3D oob_probe_make_dest(a, soc=
k_af, &t->dests[t->n_dests]);
+            if (destlen > 0)
+            {
=
+                t->destlens[t->n_dests] =3D destlen;
+                t->n=
_dests++;
+            }
+        }
+        freeaddrinfo(ai);
+
+        i=
f (t->n_dests =3D=3D 0)
         {
             msg(D_LOW, "server-probe: %=
s:%s: not reachable by the probe socket", ce->remote,
                 ce->=
remote_port);
+            continue;
         }
-        else if (sendto(sd=
, (const char *)BPTR(&probe), (int)BLEN(&probe), 0,
-                      =
  (struct sockaddr *)&targets[i]=2Edest, destlen)
-                 < 0)
+
=
+        if (!oob_probe_send_target(sd, &probe, t))
         {
            =
 msg(D_LOW, "server-probe: %s:%s: probe send failed", ce->remote, ce->remot=
e_port);
+            continue;
         }
-        else
-        {
-      =
      openvpn_gettimeofday(&targets[i]=2Esent_at, NULL);
-            targe=
ts[i]=2Edestlen =3D destlen;
-            targets[i]=2Esent =3D true;
-    =
        sent_count++;
-        }
-        freeaddrinfo(ai);
+
+        open=
vpn_gettimeofday(&t->sent_at, NULL);
+        t->sent =3D true;
+        se=
nt_count++;
     }
 
     if (sent_count > 0)

-- 
To view, visit http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1751?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Bran=
ch: master
Gerrit-Change-Id: I00208610e0ce4f3ed9a87233e68ece1b3b8a768a
Gerr=
it-Change-Number: 1751
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@gm=
ail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-C=
C: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention=
: plaisthos <arne-openvpn@rfc2549=2Eorg>

--waZ0/w3QmlA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1751?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">oo=
b: Probe every resolved address of a remote<br><br>A remote can resolve to =
several A/AAAA records; --server-probe previously<br>sent a SERVER_PROBE on=
ly to the first one, so a remote whose first address<br>was unreachable loo=
ked unresponsive even if another address answered, and<br>the connection co=
uld later try an address that was never probed=2E<br><br>Probe every resolv=
ed address of each remote in parallel (per-remote storage<br>is sized to th=
e resolved address count, no fixed cap), accept a reply from<br>any of them=
 (first reply for a remote wins), and resend to all of a remote&#39;s<br>ad=
dresses while it is unanswered=2E<br><br>Change-Id: I00208610e0ce4f3ed9a872=
33e68ece1b3b8a768a<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;=
<br>---<br>M src/openvpn/oob_client=2Ec<br>1 file changed, 85 insertions(+)=
, 33 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvp=
n=2Enet:29418/openvpn refs/changes/51/1751/1</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openv=
pn/oob_client=2Ec b/src/openvpn/oob_client=2Ec</span><br><span>index 5f2265=
0=2E=2E7391d1e 100644</span><br><span>--- a/src/openvpn/oob_client=2Ec</spa=
n><br><span>+++ b/src/openvpn/oob_client=2Ec</span><br><span>@@ -52,11 +52,=
15 @@</span><br><span> #define OOB_PROBE_RETRIES 1</span><br><span> </span>=
<br><span> /* Where we sent a probe, so a reply&#39;s source address can be=
 matched back to the</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
* connection-list entry it belongs to=2E */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * connection-list entry it belongs to=2E A remote =
may resolve to several</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * addresses, all of which are probed; a reply from any of them counts=
=2E The</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p dests =
/ @p destlens arrays are gc-allocated, sized to the remote&#39;s resolved</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * address count=2E *=
/</span><br><span> struct probe_target</span><br><span> {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    struct sockaddr_storage dest;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    socklen_t destlen;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct sockaddr_stor=
age *dests;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sock=
len_t *destlens;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 int n_dests;</span><br><span>     bool sent;</span><br><span>     struct t=
imeval sent_at; /* when the probe was sent, for RTT measurement */</span><b=
r><span> };</span><br><span>@@ -173,6 +177,25 @@</span><br><span>     retur=
n 0;</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/* Send the probe to every resolved address of @p t=
=2E Returns true if at least</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * one send succeeded=2E */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+oob_probe_send_target(socket_descriptor_t sd, const struct buffer =
*probe,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
          const struct probe_target *t)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    bool any_sent =3D false;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    for (int k =3D 0; k &lt; t-&gt;n_dests; k++)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if (sendto(sd, (const char *)BPTR(probe),=
 (int)BLEN(probe), 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                   (const struct sockaddr *)&amp;t-&gt;dests[k], t-&gt;de=
stlens[k])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   &gt;=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            any_=
sent =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    return any_sent;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span> /* Parse one received datagr=
am as a PROBE_REPLY and, if valid and matching one</span><br><span>  * of t=
he probes we sent, record the reply in @p results=2E */</span><br><span> st=
atic void</span><br><span>@@ -213,25 +236,38 @@</span><br><span>         re=
turn;</span><br><span>     }</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    /* Match the reply&#39;s source address to the=
 remote we probed=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* Match the reply&#39;s source address to one of the addresses we =
probed for a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * =
remote=2E The first reply for a remote wins (a remote with several addresse=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * may answer =
from more than one)=2E */</span><br><span>     for (int i =3D 0; i &lt; n; =
i++)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        if (targets[i]=2Esent</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            &amp;&amp; addr_port_match((const struct openvpn_=
sockaddr *)(const void *)from,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                               (const struct openvpn_sockaddr *)(c=
onst void *)&amp;targets[i]=2Edest))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (!targets[i]=2Esent || results[i]=2Eresponded)<=
/span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            struct timeval rcv;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            openvpn_gettimeofday(&amp;rcv, NULL);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            long ms =3D (long)(r=
cv=2Etv_sec - targets[i]=2Esent_at=2Etv_sec) * 1000</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                      + (rcv=2Etv_usec - ta=
rgets[i]=2Esent_at=2Etv_usec) / 1000;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       results[i]=2Eresponded =3D true;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            results[i]=2Epriority =3D reply=2Epriority;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            results[i]=
=2Eweight =3D reply=2Eweight;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            results[i]=2Emax_latency_diff =3D reply=2Emax_latency_d=
iff;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            resul=
ts[i]=2Ertt_ms =3D (ms &gt; 0) ? (unsigned int)ms : 0;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            break;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            continue;</span><br><span>   =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        bool match =3D false;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (int k =
=3D 0; k &lt; targets[i]=2En_dests &amp;&amp; !match; k++)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            match =3D addr_port_match((const s=
truct openvpn_sockaddr *)(const void *)from,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                                    (const struct =
openvpn_sockaddr *)(const void *)&amp;targets[i]=2Edests[k]);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (!match)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            continue;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     struct timeval rcv;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        openvpn_gettimeofday(&amp;rcv, NULL);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        long ms =3D (long)(rcv=2Etv_sec - ta=
rgets[i]=2Esent_at=2Etv_sec) * 1000</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                  + (rcv=2Etv_usec - targets[i]=2Esent_at=
=2Etv_usec) / 1000;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        results[i]=
=2Eresponded =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        results[i]=2Epriority =3D reply=2Epriority;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        results[i]=2Eweight =3D reply=2E=
weight;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        resu=
lts[i]=2Emax_latency_diff =3D reply=2Emax_latency_diff;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        results[i]=2Ertt_ms =3D (ms &gt=
; 0) ? (unsigned int)ms : 0;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        break;</span><br><span>     }</span><br><span> }</span><br=
><span> </span><br><span>@@ -306,8 +342,7 @@</span><br><span>     {</span><=
br><span>         if (targets[i]=2Esent &amp;&amp; !results[i]=2Eresponded)=
</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            sendto(sd, (const char *)BPTR(probe), (int)BLEN(probe), 0=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   (=
const struct sockaddr *)&amp;targets[i]=2Edest, targets[i]=2Edestlen);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            oob_probe_se=
nd_target(sd, probe, &amp;targets[i]);</span><br><span>         }</span><br=
><span>     }</span><br><span> }</span><br><span>@@ -476,26 +511,43 @@</spa=
n><br><span>             continue;</span><br><span>         }</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        socklen_t=
 destlen =3D oob_probe_make_dest(ai, sock_af, &amp;targets[i]=2Edest);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (destlen =3D=3D=
 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Colle=
ct every address this remote resolves to that the probe socket</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+         * can reach=2E Storage =
is sized to the resolved address count=2E */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        struct probe_target *t =3D &amp;targets[i]=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int n_addr=
 =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for =
(const struct addrinfo *a =3D ai; a; a =3D a-&gt;ai_next)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            n_addr++;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        t-&gt;dests =3D gc_malloc(sizeof(*t-&gt;dests) =
* n_addr, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        t-&gt;destlens =3D gc_malloc(sizeof(*t-&gt;destlens) * n_addr=
, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      for (const struct addrinfo *a =3D ai; a; a =3D a-&gt;ai_next)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            socklen_t destlen =3D oob=
_probe_make_dest(a, sock_af, &amp;t-&gt;dests[t-&gt;n_dests]);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            if (destlen &gt; 0)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                t-&gt;dest=
lens[t-&gt;n_dests] =3D destlen;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                t-&gt;n_dests++;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        freeaddrinfo(ai);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (t-&gt;n_dests =3D=3D 0)</span><br><span>         {</span><br><span=
>             msg(D_LOW, &quot;server-probe: %s:%s: not reachable by the pr=
obe socket&quot;, ce-&gt;remote,</span><br><span>                 ce-&gt;re=
mote_port);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    continue;</span><br><span>         }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        else if (sendto(sd, (const char *)BPTR(&amp;prob=
e), (int)BLEN(&amp;probe), 0,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                        (struct sockaddr *)&amp;targets[i]=2Edest, =
destlen)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
    &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!oob_probe_send=
_target(sd, &amp;probe, t))</span><br><span>         {</span><br><span>    =
         msg(D_LOW, &quot;server-probe: %s:%s: probe send failed&quot;, ce-=
&gt;remote, ce-&gt;remote_port);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            continue;</span><br><span>         }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        else</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            openvpn_gettimeofday(&amp;targets[i]=2Esent=
_at, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  targets[i]=2Edestlen =3D destlen;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            targets[i]=2Esent =3D true;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            sent_count++;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        freeaddrinfo(ai);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        openvpn_gettimeofday(&amp;t-&gt;sent_at, NULL);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        t-&gt;sent =3D true;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sent_count+=
+;</span><br><span>     }</span><br><span> </span><br><span>     if (sent_c=
ount &gt; 0)</span><br><span></span><br></pre><p>To view, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1751?usp=3Demail">change 1751</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1751?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:=
none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-B=
ranch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I002086=
10e0ce4f3ed9a87233e68ece1b3b8a768a </div>
<div style=3D"display:none"> Gerr=
it-Change-Number: 1751 </div>
<div style=3D"display:none"> Gerrit-PatchSet:=
 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gm=
ail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaistho=
s &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>

</body></html>
--waZ0/w3QmlA=--


--===============1462792460644063642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1462792460644063642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1462792460644063642==--

