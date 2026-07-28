Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC3CC54F54
	for <openvpn-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bOagR0UvemweZJeMAdZ9cQ9t+eHdsqe8x8xA7VELzlY=; b=WGKOXDZ02SD0zL24omNbv14NbE
	pkxTY3A4ZXea7XnnzTPLgWOD3A+ickyAJ3IArChnuR7g6eodvjdce7XqmP27yekxUE5A4d3p2ei/q
	5Wr6QAyV/HSw+jhNvAzLPJD1bnlIujgKYjShfP4BELj8gRjQusqSX3+aDKHRgDZl2n3Y=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wojLf-0001va-ML;
	Tue, 28 Jul 2026 15:04:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wojLe-0001vJ-CS
 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 15:04:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=cZ0ho/KM5mYxMNbBf8KB8xU8i6XNyLjLjxB1lswj6c8=; b=MyGsfVxz8/GqQFXie8nel5sqbH
 iySIV6nZt9IEW+ugwRf/DpcHyHFwGXJBh2TJ1QQLPQcI1ZTjya5WnGVAv7ZUBrL/e4S73b9FFTr/3
 nzG3ldfjFRosnwMCaLhVIPktMAZ155koicI1aAWoaoTBB6aih2CDO+JyTw+4Kep/5eqQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=cZ0ho/KM5mYxMNbBf8KB8xU8i6XNyLjLjxB1lswj6c8=; b=B
 9IuB86sHqxMzHaDjg7ZqbkTV+xMb2ZfYEFbP6SbxOhqrQwtWKZ+ln9jgekkBXoGmVFEMTCRxOYnYI
 ByYE6j8B3C/uFlQv+z8J1JJkAzVdvnxWvVU94jPddA11SQJaer2OnZi9ssYyjAFYUQpQtfMdif26t
 QQqZIuWPWci1/LZo=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wojLc-0000Od-Fa for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 15:04:03 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-49553515a8bso49181045e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 28 Jul 2026 08:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785251034; x=1785855834; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cZ0ho/KM5mYxMNbBf8KB8xU8i6XNyLjLjxB1lswj6c8=;
 b=KtV6uB/ZsRHIt9Upzk85iLQfB4Yc7yynMRglZTgs2ml7EmHCpRwKEjypPl500m7wEY
 q6H9v7w68RyC6AGOi2fVtwf7Dud+SySJmGe92JltE+D15WX1CDWWE99w6b9+i9EPjV9l
 z6S+QvimvF0J85T2R9Vk7P8v5gmoezMtAl7zajEjx4pBCgEM0i6LD6g/igh4XIXBY13C
 /yB7E3fjJgIIueVtJ44L0IXI6DyW8AFqngEabcdC7AcYuBeMYpGDvKjoT/XJHh7ti/kG
 i67QlGeB4qlBbyVVX2mAxojdEK20Y8WJgv1U2pv75yfaqqIngOU9bfJDwTIessD96Fes
 6vnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785251034; x=1785855834;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cZ0ho/KM5mYxMNbBf8KB8xU8i6XNyLjLjxB1lswj6c8=;
 b=Z36eJDPZgYOMKtI+YpCMJBCA8V1SRpyrADZYqbxnbC/dW8ju5AloUWVXCFjrP7t9CQ
 iU5tQJmQwJkBll0pKZtRZckwT+fvOumaNfVjTcR5wI/mG9MSCCnefrRGtijAeniTEov3
 suLhzZjIIWGNvp2XBujQDus8HsYq3oOMo4FLmOrxF2ceXNkjEKdldYl8ABU7yXQ9eciK
 EUdPWdfypAQVwXfw/WPQZSofM9RDVChebD18H8hJBmEqwu/GYBxUO/1OGVqDkigPeS+O
 mnoLQRK+ADzP/vVICcYFxYd1aIo1A0YkkgskdDMp2JCcKZSaZ2pfQCQcd714m9p4u8Ij
 2/hA==
X-Gm-Message-State: AOJu0YwmiK1/lAirOYfXLspJ+ei5htcPVP0XAXeLgtW3GdQigy2WmR2l
 MiSanrBWsJUer17l79n7qv/8L0DJ0UkKxmrzfLWkDtuxMeTF4gi8S8H5Y7XrCt3QGnATOyxElSL
 pfMDHgt+dgT86dICIRRdNxkOW37/cmftuwjZtZ9IcL+hTlgdOOsU1PGKZ0QdJz/RWHGdz
X-Gm-Gg: AR+sD10ferpcesi2Ji+qlVeCAt6QQSGJkf446g8tPr1mC67WPoDJWvVsIUHi62ORcSR
 LiH9+rHq0utWrilAjcRIrFZyJ3KYf1RnNLA03E+Q5CPB26TR80SIRwsTFc6PzV5RYr8MaMLwd1S
 /Zz4tRTEFv960mo78LIEkAcXqfrthDZRSdtnMuaJFuB3nfBTDorQMTf8iifkGTXnwVN74hZaD59
 54oCKfMzVmQZNCnQY1/SMIOodf520ZUODOKM1ehymLd4/OhMdMv5VW4T0nOCX26u/H98+vHNwj8
 FYFf31P/rDCek1nW8BLq1IUhys8aSKI2XRqQ1y2lSOL305luKmIbl+31aYfVnbVGTRc7bkTK+v6
 +sZgiWdIs/ulbnsLWo/eaoVqvFedNrbStsNTQ+JR+K1pdWkO0e7F2LgJKb/NuwENG9Fpelj/fZe
 5wEX4WsaAuh+Sn0bCtBdjkvrRR+h78FW1jynhd45dOlGfDxe9+ZgOEoujrU9eS/ZuxGq7/tonxL
 esYMlvFb2VzTk1kh3OMnS1aA/+Mxq26So2pop7Js8a4XLg/x2sPE7LQDLzy8253SiRH
X-Received: by 2002:a05:600c:354a:b0:495:7293:4fe2 with SMTP id
 5b1f17b1804b1-496c653c4fcmr33520875e9.17.1785251033577; 
 Tue, 28 Jul 2026 08:03:53 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c45b0535sm81429085e9.4.2026.07.28.08.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 08:03:52 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 28 Jul 2026 15:03:23 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 13
X-Gerrit-Change-Id: I00208610e0ce4f3ed9a87233e68ece1b3b8a768a
X-Gerrit-Change-Number: 1751
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1751?usp=email>
X-Gerrit-Commit: db28918db4865dd66bb2c50c78f7af1fdd9eba77
In-Reply-To: <gerrit.1782719911000.I00208610e0ce4f3ed9a87233e68ece1b3b8a768a@gerrit.openvpn.net>
References: <gerrit.1782719911000.I00208610e0ce4f3ed9a87233e68ece1b3b8a768a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkwMDIwODYxMGUwY2U0ZjNlZDlhODcyMzNlNjhlY2UxYjNiOGE3NjhhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4107f06f88c19440ed72798d1a487174149f3184-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wojLc-0000Od-Fa
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
Content-Type: multipart/mixed; boundary="===============6394410257033159373=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6394410257033159373==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FbS+hW+VK5k="; charset=UTF-8

--FbS+hW+VK5k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1751?usp=3Demail

to look at the new patch set (#13)=2E
=


Change subject: oob: Probe every resolved address of a remote
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Probe every resol=
ved address of a remote

A remote can resolve to several A/AAAA records; --=
server-probe previously
sent a SERVER_PROBE only to the first one, so a rem=
ote whose first address
was unreachable looked unresponsive even if another=
 address answered, and
the connection could later try an address that was n=
ever probed=2E

Probe every resolved address of each remote in parallel (pe=
r-remote storage
is sized to the resolved address count, no fixed cap), acc=
ept a reply from
any of them (first reply for a remote wins), and resend to=
 all of a remote's
addresses while it is unanswered=2E

Change-Id: I0020861=
0e0ce4f3ed9a87233e68ece1b3b8a768a
Signed-off-by: Lev Stipakov <lev@openvpn=
=2Enet>
---
M src/openvpn/oob_client=2Ec
1 file changed, 92 insertions(+), =
45 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn ref=
s/changes/51/1751/13

diff --git a/src/openvpn/oob_client=2Ec b/src/openvpn=
/oob_client=2Ec
index 5249672=2E=2E8c67da5 100644
--- a/src/openvpn/oob_cli=
ent=2Ec
+++ b/src/openvpn/oob_client=2Ec
@@ -52,11 +52,15 @@
 #define OOB_P=
ROBE_RETRIES 1
 
 /* Where we sent a probe, so a reply's source address can=
 be matched back to the
- * connection-list entry it belongs to=2E */
+ * c=
onnection-list entry it belongs to=2E A remote may resolve to several
+ * a=
ddresses, all of which are probed; a reply from any of them counts=2E The
+=
 * dests / destlens arrays are gc-allocated, sized to the remote's resolved=

+ * address count=2E */
 struct probe_target
 {
-    struct sockaddr_stora=
ge dest;
-    socklen_t destlen;
+    struct sockaddr_storage *dests;
+    =
socklen_t *destlens;
+    int n_dests;
     bool sent;
     struct timeval =
sent_at; /* when the probe was sent, for RTT measurement */
 };
@@ -177,6 +=
181,29 @@
     }
 }
 
+/* Send the probe to every resolved address of t, ea=
ch on the socket matching
+ * its address family=2E Returns true if at leas=
t one send succeeded=2E */
+static bool
+oob_probe_send_target(const struct=
 probe_ctx *pc, const struct buffer *probe,
+                      const st=
ruct probe_target *t)
+{
+    bool any_sent =3D false;
+    for (int k =3D =
0; k < t->n_dests; k++)
+    {
+        socket_descriptor_t sd =3D pc->sd[p=
robe_af_index(t->dests[k]=2Ess_family)];
+        if (sd =3D=3D SOCKET_UNDE=
FINED)
+        {
+            continue;
+        }
+        if (sendto(sd,=
 (const char *)BPTR(probe), (int)BLEN(probe), 0,
+                   (const=
 struct sockaddr *)&t->dests[k], t->destlens[k])
+            >=3D 0)
+    =
    {
+            any_sent =3D true;
+        }
+    }
+    return any_sen=
t;
+}
 
 /* Parse one received datagram as a PROBE_REPLY and, if valid and =
matching one
  * of the probes we sent, record the reply in results=2E */
@=
@ -218,25 +245,38 @@
         return;
     }
 
-    /* Match the reply's so=
urce address to the remote we probed=2E */
+    /* Match the reply's source=
 address to one of the addresses we probed for a
+     * remote=2E The firs=
t reply for a remote wins (a remote with several addresses
+     * may answ=
er from more than one)=2E */
     for (int i =3D 0; i < n; i++)
     {
-   =
     if (targets[i]=2Esent
-            && addr_port_match((const struct op=
envpn_sockaddr *)(const void *)from,
-                               (const=
 struct openvpn_sockaddr *)(const void *)&targets[i]=2Edest))
+        if (=
!targets[i]=2Esent || results[i]=2Eresponded)
         {
-            struc=
t timeval rcv;
-            openvpn_gettimeofday(&rcv, NULL);
-            =
long ms =3D (long)(rcv=2Etv_sec - targets[i]=2Esent_at=2Etv_sec) * 1000
-  =
                    + (rcv=2Etv_usec - targets[i]=2Esent_at=2Etv_usec) / 10=
00;
-
-            results[i]=2Eresponded =3D true;
-            results[i]=
=2Epriority =3D reply=2Epriority;
-            results[i]=2Eweight =3D repl=
y=2Eweight;
-            results[i]=2Emax_latency_diff =3D reply=2Emax_late=
ncy_diff;
-            results[i]=2Ertt_ms =3D (ms > 0) ? (unsigned int)ms =
: 0;
-            break;
+            continue;
         }
+
+        bool =
match =3D false;
+        for (int k =3D 0; k < targets[i]=2En_dests && !ma=
tch; k++)
+        {
+            match =3D addr_port_match((const struct o=
penvpn_sockaddr *)(const void *)from,
+                                    =
(const struct openvpn_sockaddr *)(const void *)&targets[i]=2Edests[k]);
+  =
      }
+        if (!match)
+        {
+            continue;
+        }
+=

+        struct timeval rcv;
+        openvpn_gettimeofday(&rcv, NULL);
+ =
       long ms =3D (long)(rcv=2Etv_sec - targets[i]=2Esent_at=2Etv_sec) * 1=
000
+                  + (rcv=2Etv_usec - targets[i]=2Esent_at=2Etv_usec) /=
 1000;
+
+        results[i]=2Eresponded =3D true;
+        results[i]=2Epr=
iority =3D reply=2Epriority;
+        results[i]=2Eweight =3D reply=2Eweigh=
t;
+        results[i]=2Emax_latency_diff =3D reply=2Emax_latency_diff;
+  =
      results[i]=2Ertt_ms =3D (ms > 0) ? (unsigned int)ms : 0;
+        bre=
ak;
     }
 }
 
@@ -329,12 +369,7 @@
     {
         if (targets[i]=2Esent =
&& !results[i]=2Eresponded)
         {
-            socket_descriptor_t sd =
=3D pc->sd[probe_af_index(targets[i]=2Edest=2Ess_family)];
-            if =
(sd !=3D SOCKET_UNDEFINED)
-            {
-                sendto(sd, (cons=
t char *)BPTR(probe), (int)BLEN(probe), 0,
-                       (const s=
truct sockaddr *)&targets[i]=2Edest, targets[i]=2Edestlen);
-            }
=
+            oob_probe_send_target(pc, probe, &targets[i]);
         }
    =
 }
 }
@@ -502,33 +537,45 @@
             continue;
         }
 
-        /*=
 Probe the first resolved address on the socket matching its address
-     =
    * family (stored natively; no IPv4-mapping)=2E */
-        socket_descr=
iptor_t sd =3D pc=2Esd[probe_af_index(ai->ai_family)];
-        if (sd =3D=
=3D SOCKET_UNDEFINED)
+        /* Collect every resolved address whose addr=
ess family has a probe socket=2E
+         * Each address is stored nativel=
y (no IPv4-mapping) and later probed on
+         * its AF socket=2E Storag=
e is sized to the resolved address count=2E */
+        struct probe_target=
 *t =3D &targets[i];
+        int n_addr =3D 0;
+        for (const struct =
addrinfo *a =3D ai; a; a =3D a->ai_next)
+        {
+            n_addr++;
=
+        }
+        t->dests =3D gc_malloc(sizeof(*t->dests) * n_addr, true=
, &gc);
+        t->destlens =3D gc_malloc(sizeof(*t->destlens) * n_addr, t=
rue, &gc);
+        for (const struct addrinfo *a =3D ai; a; a =3D a->ai_ne=
xt)
+        {
+            if (pc=2Esd[probe_af_index(a->ai_family)] =3D=
=3D SOCKET_UNDEFINED)
+            {
+                continue; /* no socke=
t for this address family */
+            }
+            memcpy(&t->dests[t=
->n_dests], a->ai_addr, a->ai_addrlen);
+            t->destlens[t->n_dests=
] =3D (socklen_t)a->ai_addrlen;
+            t->n_dests++;
+        }
+    =
    freeaddrinfo(ai);
+
+        if (t->n_dests =3D=3D 0)
         {
      =
       msg(D_LOW, "server-probe: %s:%s: not reachable by the probe socket",=
 ce->remote,
                 ce->remote_port);
+            continue;
    =
     }
-        else
+
+        if (!oob_probe_send_target(&pc, &probe, t))=

         {
-            memcpy(&targets[i]=2Edest, ai->ai_addr, ai->ai_add=
rlen);
-            socklen_t destlen =3D (socklen_t)ai->ai_addrlen;
-     =
       if (sendto(sd, (const char *)BPTR(&probe), (int)BLEN(&probe), 0,
-  =
                     (struct sockaddr *)&targets[i]=2Edest, destlen)
-     =
           < 0)
-            {
-                msg(D_LOW, "server-probe: %=
s:%s: probe send failed", ce->remote, ce->remote_port);
-            }
-   =
         else
-            {
-                openvpn_gettimeofday(&targets=
[i]=2Esent_at, NULL);
-                targets[i]=2Edestlen =3D destlen;
- =
               targets[i]=2Esent =3D true;
-                sent_count++;
-=
            }
+            msg(D_LOW, "server-probe: %s:%s: probe send fail=
ed", ce->remote, ce->remote_port);
+            continue;
         }
-     =
   freeaddrinfo(ai);
+
+        openvpn_gettimeofday(&t->sent_at, NULL);
+ =
       t->sent =3D true;
+        sent_count++;
     }
 
     if (sent_coun=
t > 0)

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1751?u=
sp=3Demail
To unsubscribe, or for help writing mail filters, visit http://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset=

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I00208610e=
0ce4f3ed9a87233e68ece1b3b8a768a
Gerrit-Change-Number: 1751
Gerrit-PatchSet:=
 13
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>

--FbS+hW+VK5k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #13</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1751?usp=3Demail">View Change</a></p><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">oob: Pro=
be every resolved address of a remote<br><br>A remote can resolve to severa=
l A/AAAA records; --server-probe previously<br>sent a SERVER_PROBE only to =
the first one, so a remote whose first address<br>was unreachable looked un=
responsive even if another address answered, and<br>the connection could la=
ter try an address that was never probed=2E<br><br>Probe every resolved add=
ress of each remote in parallel (per-remote storage<br>is sized to the reso=
lved address count, no fixed cap), accept a reply from<br>any of them (firs=
t reply for a remote wins), and resend to all of a remote&#39;s<br>addresse=
s while it is unanswered=2E<br><br>Change-Id: I00208610e0ce4f3ed9a87233e68e=
ce1b3b8a768a<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>--=
-<br>M src/openvpn/oob_client=2Ec<br>1 file changed, 92 insertions(+), 45 d=
eletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Ene=
t:29418/openvpn refs/changes/51/1751/13</pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/oo=
b_client=2Ec b/src/openvpn/oob_client=2Ec</span><br><span>index 5249672=2E=
=2E8c67da5 100644</span><br><span>--- a/src/openvpn/oob_client=2Ec</span><b=
r><span>+++ b/src/openvpn/oob_client=2Ec</span><br><span>@@ -52,11 +52,15 @=
@</span><br><span> #define OOB_PROBE_RETRIES 1</span><br><span> </span><br>=
<span> /* Where we sent a probe, so a reply&#39;s source address can be mat=
ched back to the</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * co=
nnection-list entry it belongs to=2E */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * connection-list entry it belongs to=2E A remote may =
resolve to several</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* addresses, all of which are probed; a reply from any of them counts=2E Th=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * dests / destlen=
s arrays are gc-allocated, sized to the remote&#39;s resolved</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * address count=2E */</span><br>=
<span> struct probe_target</span><br><span> {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    struct sockaddr_storage dest;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    socklen_t destlen;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct sockaddr_storage *dests;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    socklen_t *destl=
ens;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int n_dests=
;</span><br><span>     bool sent;</span><br><span>     struct timeval sent_=
at; /* when the probe was sent, for RTT measurement */</span><br><span> };<=
/span><br><span>@@ -177,6 +181,29 @@</span><br><span>     }</span><br><span=
> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/* Send the probe to every resolved address of t, each on the socket matc=
hing</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * its address =
family=2E Returns true if at least one send succeeded=2E */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+oob_probe_send_target(const struct probe_=
ctx *pc, const struct buffer *probe,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                      const struct probe_target *t)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    bool any_sent =3D false;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    for (int k =3D 0; k &lt; t-&gt;=
n_dests; k++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        socket_descr=
iptor_t sd =3D pc-&gt;sd[probe_af_index(t-&gt;dests[k]=2Ess_family)];</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (sd =3D=3D SOC=
KET_UNDEFINED)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            con=
tinue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (sendto(sd, =
(const char *)BPTR(probe), (int)BLEN(probe), 0,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                   (const struct sockaddr *)&am=
p;t-&gt;dests[k], t-&gt;destlens[k])</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            &gt;=3D 0)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            any_sent =3D true;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 return any_sent;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span> </span><br><span> /* Parse one received datagram as a PROB=
E_REPLY and, if valid and matching one</span><br><span>  * of the probes we=
 sent, record the reply in results=2E */</span><br><span>@@ -218,25 +245,38=
 @@</span><br><span>         return;</span><br><span>     }</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Match the re=
ply&#39;s source address to the remote we probed=2E */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* Match the reply&#39;s source addr=
ess to one of the addresses we probed for a</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * remote=2E The first reply for a remote wins =
(a remote with several addresses</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+     * may answer from more than one)=2E */</span><br><span>  =
   for (int i =3D 0; i &lt; n; i++)</span><br><span>     {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        if (targets[i]=2Esent</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            &amp;&amp; addr_po=
rt_match((const struct openvpn_sockaddr *)(const void *)from,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                               (con=
st struct openvpn_sockaddr *)(const void *)&amp;targets[i]=2Edest))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!targets[i]=2Es=
ent || results[i]=2Eresponded)</span><br><span>         {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            struct timeval rcv;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            openvpn_gettimeof=
day(&amp;rcv, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           long ms =3D (long)(rcv=2Etv_sec - targets[i]=2Esent_at=2Etv_sec)=
 * 1000</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
        + (rcv=2Etv_usec - targets[i]=2Esent_at=2Etv_usec) / 1000;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            results[i]=2Eresponded =3D true;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            results[i]=2Epri=
ority =3D reply=2Epriority;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            results[i]=2Eweight =3D reply=2Eweight;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            results[i]=2Emax_latency_di=
ff =3D reply=2Emax_latency_diff;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            results[i]=2Ertt_ms =3D (ms &gt; 0) ? (unsigned int)=
ms : 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            br=
eak;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            con=
tinue;</span><br><span>         }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   bool match =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        for (int k =3D 0; k &lt; targets[i]=2En_dests &amp;&amp; !matc=
h; k++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            match =3D =
addr_port_match((const struct openvpn_sockaddr *)(const void *)from,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
          (const struct openvpn_sockaddr *)(const void *)&amp;targets[i]=2E=
dests[k]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!match)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            continue;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        struct timeval rcv;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        openvpn_gettimeofday(&amp;rcv, NULL);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        long ms =3D (l=
ong)(rcv=2Etv_sec - targets[i]=2Esent_at=2Etv_sec) * 1000</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                  + (rcv=2Etv_usec - =
targets[i]=2Esent_at=2Etv_usec) / 1000;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        results[i]=2Eresponded =3D true;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        results[i]=2Epriority =3D reply=2Epriority;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        results[i]=2E=
weight =3D reply=2Eweight;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        results[i]=2Emax_latency_diff =3D reply=2Emax_latency_diff;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        results[i]=
=2Ertt_ms =3D (ms &gt; 0) ? (unsigned int)ms : 0;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        break;</span><br><span>     }</span><=
br><span> }</span><br><span> </span><br><span>@@ -329,12 +369,7 @@</span><b=
r><span>     {</span><br><span>         if (targets[i]=2Esent &amp;&amp; !r=
esults[i]=2Eresponded)</span><br><span>         {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            socket_descriptor_t sd =3D pc-&gt;s=
d[probe_af_index(targets[i]=2Edest=2Ess_family)];</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            if (sd !=3D SOCKET_UNDEFINED)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                sendto(sd, (const c=
har *)BPTR(probe), (int)BLEN(probe), 0,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                       (const struct sockaddr *)&amp;targ=
ets[i]=2Edest, targets[i]=2Edestlen);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            oob_probe_send_target(pc, probe, &amp;targets[i]);</s=
pan><br><span>         }</span><br><span>     }</span><br><span> }</span><b=
r><span>@@ -502,33 +537,45 @@</span><br><span>             continue;</span>=
<br><span>         }</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        /* Probe the first resolved address on the socket =
matching its address</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
        * family (stored natively; no IPv4-mapping)=2E */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        socket_descriptor_t sd =3D pc=
=2Esd[probe_af_index(ai-&gt;ai_family)];</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        if (sd =3D=3D SOCKET_UNDEFINED)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        /* Collect every resolved ad=
dress whose address family has a probe socket=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+         * Each address is stored natively (no=
 IPv4-mapping) and later probed on</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+         * its AF socket=2E Storage is sized to the resolved=
 address count=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        struct probe_target *t =3D &amp;targets[i];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        int n_addr =3D 0;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        for (const struct addrinfo =
*a =3D ai; a; a =3D a-&gt;ai_next)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            n_addr++;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     t-&gt;dests =3D gc_malloc(sizeof(*t-&gt;dests) * n_addr, true, &amp;gc=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        t-&gt;des=
tlens =3D gc_malloc(sizeof(*t-&gt;destlens) * n_addr, true, &amp;gc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (const struct=
 addrinfo *a =3D ai; a; a =3D a-&gt;ai_next)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            if (pc=2Esd[probe_af_index(a-&gt;ai_family)] =3D=
=3D SOCKET_UNDEFINED)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            continue; /* no socket for this address family */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            memcpy(&amp;t-&gt;dests[t-&=
gt;n_dests], a-&gt;ai_addr, a-&gt;ai_addrlen);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            t-&gt;destlens[t-&gt;n_dests] =3D (s=
ocklen_t)a-&gt;ai_addrlen;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            t-&gt;n_dests++;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        freeaddrinfo(ai);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if (t-&gt;n_dests =3D=3D 0)</span><br><span>         {</span><br><span>   =
          msg(D_LOW, &quot;server-probe: %s:%s: not reachable by the probe =
socket&quot;, ce-&gt;remote,</span><br><span>                 ce-&gt;remote=
_port);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
continue;</span><br><span>         }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        else</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
(!oob_probe_send_target(&amp;pc, &amp;probe, t))</span><br><span>         {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            memcpy(&a=
mp;targets[i]=2Edest, ai-&gt;ai_addr, ai-&gt;ai_addrlen);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            socklen_t destlen =3D (sock=
len_t)ai-&gt;ai_addrlen;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            if (sendto(sd, (const char *)BPTR(&amp;probe), (int)BLEN(&am=
p;probe), 0,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
              (struct sockaddr *)&amp;targets[i]=2Edest, destlen)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                &lt; 0)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                msg(D_LOW, &quot;serv=
er-probe: %s:%s: probe send failed&quot;, ce-&gt;remote, ce-&gt;remote_port=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            else</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                openvpn_gettimeofday(&am=
p;targets[i]=2Esent_at, NULL);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                targets[i]=2Edestlen =3D destlen;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                targets[i]=2Esent =3D =
true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
sent_count++;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ms=
g(D_LOW, &quot;server-probe: %s:%s: probe send failed&quot;, ce-&gt;remote,=
 ce-&gt;remote_port);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            continue;</span><br><span>         }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        freeaddrinfo(ai);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        openvpn_gettimeofday(&amp;t-&gt;sent_at, NULL);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        t-&gt;sent =3D =
true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sent_c=
ount++;</span><br><span>     }</span><br><span> </span><br><span>     if (s=
ent_count &gt; 0)</span><br><span></span><br></pre><p>To view, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1751?usp=3Demail">change 175=
1</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><di=
v itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1751?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"d=
isplay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> G=
errit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: =
I00208610e0ce4f3ed9a87233e68ece1b3b8a768a </div>
<div style=3D"display:none=
"> Gerrit-Change-Number: 1751 </div>
<div style=3D"display:none"> Gerrit-Pa=
tchSet: 13 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lsti=
pakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--FbS+hW+VK5k=--


--===============6394410257033159373==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6394410257033159373==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6394410257033159373==--

