Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4CFAC54F51
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 12:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rEoI72RPIgZ1gGjMz8wJz+1JC02XPlwuZEZdcD/ZdoQ=; b=mwRHjEzqomHQ/MGWmIgxhMQ9hD
	Ef+x3pcHIkOzz9xIvz0HILc6h7lJ9dzLr7wDfvhLgnTpfG2/ftRw5w8Cnv6QnJEwQdqVh37l6FywR
	hy3ELVVINeC+88Q1YfddX62/v1jUYA7VNT+dWU+H71SLURFp9HOncQEJWFfk1KuOsWpo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wp3KV-0006ff-8e;
	Wed, 29 Jul 2026 12:24:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wp3Js-0006Zb-Ju
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 12:23:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=faem7vFKJ9z/qhOMsuwdCfWpoTyxJPkebaUPFBJaPIg=; b=QiqEL1LCyoEbBAH76QImLGTX2w
 updXwvmpEDWdK/wCrR8uqsxUE8CMDaF9j3s8bXQqE32eZz+fi4tM1vfgAr1CDMxsOkjYBeyXzJgk8
 e2s5YYqfUbO2UKwpRBvOVV/JdNuHVrwp4UyV/F4/lBnyzmHYMjZniqtBHcO117vjTXp8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=faem7vFKJ9z/qhOMsuwdCfWpoTyxJPkebaUPFBJaPIg=; b=A
 QUooj04qEHvcoLO8RpxOHregZxcxSFtwNGRCZs/HEO5W/LJVwVfLmcaJJFRdVhgrkrltTzSqMr2dn
 jTPOAZcCo+wFOdE/Bh0TiKxtg2iX7be+YiD6FxRJGpxV0HT5fB8uGr8w7LgATxWekrCEmR0BMu7Za
 GMwiTyzSzSd36RfM=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wp3Jr-0005LY-Qb for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 12:23:32 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-496bb7cdf51so9184185e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 29 Jul 2026 05:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785327802; x=1785932602; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=faem7vFKJ9z/qhOMsuwdCfWpoTyxJPkebaUPFBJaPIg=;
 b=REgWzJDwwhs+bnydztShSWhoALhYgJlXBCq3diDGcRu2X1zK1DnFnO0ZBIyWij8OTo
 RzkKqo0eSnE9Mp1m5C4AxgbZun65cWgJTeFmEwVbSzixSp/4eopuf+lw7tQwKQRF4a+i
 GTFCSzT+y76AllcR2XOP42zv+jkFHxXzbTXnQK6QSsKuqRMhmhrE6IsFR4+Z9fNQ3qc8
 vfeMGfeqWqbaRbK2/nnp+7yd+uKKhxUEUu+JmDiI0ycQAsI8uiynu/jBtOQ978/b7sfX
 x6ejv5AWoCax9gd9owhz9OG+FufyPgBNO9AnXaPa5S1EI+9aQijEtJGBbKG8LCbpE9cC
 WK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785327802; x=1785932602;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=faem7vFKJ9z/qhOMsuwdCfWpoTyxJPkebaUPFBJaPIg=;
 b=PMsW1EQL1mWeGA1HmNiGLusaGHj1lyR+G/BSYWCNZiD7DtW0Z6gV1zwwAS5YKu5AyD
 9R8H6RM0oZcUhGfsdxnVP793t/I5yXqhVToi4UOuDMCmlQpOMnEaqUrSyDv2dnAPb7Ao
 5l3eFIdUlEB7ORPnQV9fkCPQD8r3NDS8vERC7FSQxY5LPEj+YvRX2OHsLVf+o6sInlQC
 7FgStnTZhAfr+by3U/PXVtTBFBrZqiXajKIs9dON7gu/JgV0e8ughxrS2Jnh4cqNU53f
 oUJ0XEDimEtQKkPJpa32fyL061uds2dr0LBZuNO/lPBz3V53LRYqkhd7wkPiE5JMQxyL
 P8RQ==
X-Gm-Message-State: AOJu0YxqdUQ0u+OEwpVzuNcXy6yQWHjOvbJxhwF5ro5E7ug02BPcNhWD
 Rpo+oCieTZI1Kg0ujVWv8Eqh+15CKtOvT9d9JyCjT8tPm7PEO2CuKOXz5fYRL8582Ht07WopSXF
 kBuGNPgTla/rcHXMr4ZWWNXnJovqsfxzQ8BHi5FqAMBxv8y3qSpTafj4ODLW84ydtsJFDEnWX2O
 5x/O/zGQ==
X-Gm-Gg: AR+sD12ZFxiiJ9VlU7zDMqD+nbAN1XAHrto3uP89XC6onXaeYfIgcSbt6vJdYFJ8c39
 C1/PU43xVOjy6a1l1eGvdpquA/RDAG6ot0Nc9YpJduvVlgkTTW69swNaRvjKZSFWFymm2sEaVD9
 vBxUSv5ciW6AFiebs3yZ4RDbSqczkDRO1+RXzHbvB5cDd5WthErT6wSofiCqgjmq4Eh7XSdod8d
 NggDnYN7y1MDiYUTB6ZnW/CNx1UrmpUMdIylYev+s5ckUEiIvwXkOsJXuokkXmI6mQ9lZ1gS509
 ygr8apSZcEWjuG4y0+1eBw7PyRlfHvi2qT8ls4TE7vBwrrTlW5VdSrkM1sHqZlI8M50tL7lfYaf
 pBxT0k1DQIPkJPj5XHT4HSnMXBWZxNh0QHvuw+SEcIk1YdH3NhWJZZLuNIzmb6LUxPOV/HYA2qD
 fCbRy86Y1p8Mj2Za1p6Ar4hW2Ny2Cv8KFetN+llmny85QgWcqMOtW25Rtiib2oXEp5MUMtn5RN7
 gAMK57dOeJO+abvn4rkrV7hR40+Act2i6ayQrhn8q6UmoZl5qxevb9mYEESLGVJDevFgGPrNrfW
 JpBph6j/Y6rddzoIEyVuq+MQq56HwmYG7p+lscCibJeppM3FhmGgHN6KPvYS3fE=
X-Received: by 2002:a05:600c:c162:b0:493:c8c6:4989 with SMTP id
 5b1f17b1804b1-496c6414fcbmr75648425e9.6.1785327801547; 
 Wed, 29 Jul 2026 05:23:21 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49764d8e81asm54357335e9.7.2026.07.29.05.23.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 05:23:21 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 29 Jul 2026 12:22:54 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 14
X-Gerrit-Change-Id: I00208610e0ce4f3ed9a87233e68ece1b3b8a768a
X-Gerrit-Change-Number: 1751
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1751?usp=email>
X-Gerrit-Commit: 6b2008ea9ac800b34b16f923b547c31fe23bf003
In-Reply-To: <gerrit.1782719911000.I00208610e0ce4f3ed9a87233e68ece1b3b8a768a@gerrit.openvpn.net>
References: <gerrit.1782719911000.I00208610e0ce4f3ed9a87233e68ece1b3b8a768a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkwMDIwODYxMGUwY2U0ZjNlZDlhODcyMzNlNjhlY2UxYjNiOGE3NjhhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <91721e959192d11635b16cdb6e86105bf3b805eb-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wp3Jr-0005LY-Qb
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
Content-Type: multipart/mixed; boundary="===============3806501950154407146=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3806501950154407146==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ldabSzRRMhU="; charset=UTF-8

--ldabSzRRMhU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1751?usp=3Demail

to look at the new patch set (#14)=2E
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
M doc/man-sections/client-options=2Erst
M src/openvpn/oob_clien=
t=2Ec
2 files changed, 92 insertions(+), 44 deletions(-)


  git pull ssh:/=
/gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/51/1751/14

diff --git a=
/doc/man-sections/client-options=2Erst b/doc/man-sections/client-options=2E=
rst
index f253a94=2E=2E541743f 100644
--- a/doc/man-sections/client-options=
=2Erst
+++ b/doc/man-sections/client-options=2Erst
@@ -604,7 +604,7 @@
    =
  server-probe
      server-probe max-latency-diff
 
-  A small probe messa=
ge is sent to the first resolved address of every UDP
+  A small probe mess=
age is sent to every resolved address of every UDP
   remote, and each answ=
ering server replies with its advertised priority
   and weight=2E Remotes =
are then reordered following DNS SRV (RFC 2782)
   semantics: servers that =
answered are tried before those that did not,
diff --git a/src/openvpn/oob_=
client=2Ec b/src/openvpn/oob_client=2Ec
index 78dc432=2E=2E9979de9 100644
-=
-- a/src/openvpn/oob_client=2Ec
+++ b/src/openvpn/oob_client=2Ec
@@ -52,11 =
+52,15 @@
 #define OOB_PROBE_RETRIES 1
 
 /* Where we sent a probe, so a re=
ply's source address can be matched back to the
- * connection-list entry i=
t belongs to=2E */
+ * connection-list entry it belongs to=2E A remote may =
resolve to several
+ * addresses, all of which are probed; a reply from any=
 of them counts=2E The
+ * dests / destlens arrays are gc-allocated, sized =
to the remote's resolved
+ * address count=2E */
 struct probe_target
 {
- =
   struct sockaddr_storage dest;
-    socklen_t destlen;
+    struct sockad=
dr_storage *dests;
+    socklen_t *destlens;
+    int n_dests;
     bool se=
nt;
     struct timeval sent_at; /* when the probe was sent, for RTT measur=
ement */
 };
@@ -177,6 +181,30 @@
     }
 }
 
+/* Send the probe to every r=
esolved address of t, each on the socket matching
+ * its address family=2E=
 Returns true if at least one send succeeded=2E */
+static bool
+oob_probe_=
send_target(const struct probe_ctx *pc, const struct buffer *probe,
+      =
                const struct probe_target *t)
+{
+    bool any_sent =3D fal=
se;
+    for (int k =3D 0; k < t->n_dests; k++)
+    {
+        socket_desc=
riptor_t sd =3D pc->sd[probe_af_index(t->dests[k]=2Ess_family)];
+        i=
f (sd =3D=3D SOCKET_UNDEFINED)
+        {
+            continue;
+        }=

+        if (sendto(sd, (const char *)BPTR(probe), (int)BLEN(probe), 0,
+ =
                  (const struct sockaddr *)&t->dests[k], t->destlens[k])
+ =
           >=3D 0)
+        {
+            any_sent =3D true;
+        }
+ =
   }
+    return any_sent;
+}
+
 /* Parse one received datagram as a PROBE_=
REPLY and, if valid and matching one
  * of the probes we sent, record the =
reply in results=2E */
 static void
@@ -219,23 +247,36 @@
         return;
=
     }
 
-    /* Match the reply's source address to the remote we probed=
=2E */
+    /* Match the reply's source address to one of the addresses we =
probed for a
+     * remote=2E The first reply for a remote wins (a remote =
with several addresses
+     * may answer from more than one)=2E */
     fo=
r (int i =3D 0; i < n; i++)
     {
-        if (targets[i]=2Esent
-        =
    && addr_port_match((const struct openvpn_sockaddr *)(const void *)from,=

-                               (const struct openvpn_sockaddr *)(const vo=
id *)&targets[i]=2Edest))
+        if (!targets[i]=2Esent || results[i]=2Er=
esponded)
         {
-            struct timeval rcv;
-            openvpn_=
gettimeofday(&rcv, NULL);
-            long ms =3D (long)(rcv=2Etv_sec - ta=
rgets[i]=2Esent_at=2Etv_sec) * 1000
-                      + (rcv=2Etv_usec=
 - targets[i]=2Esent_at=2Etv_usec) / 1000;
-
-            results[i]=2Eresp=
onded =3D true;
-            results[i]=2Ertt_ms =3D (ms > 0) ? (unsigned i=
nt)ms : 0;
-            results[i]=2Ereply =3D reply;
-            break;
+=
            continue;
         }
+
+        bool match =3D false;
+        =
for (int k =3D 0; k < targets[i]=2En_dests && !match; k++)
+        {
+    =
        match =3D addr_port_match((const struct openvpn_sockaddr *)(const v=
oid *)from,
+                                    (const struct openvpn_sock=
addr *)(const void *)&targets[i]=2Edests[k]);
+        }
+        if (!matc=
h)
+        {
+            continue;
+        }
+
+        struct timeval r=
cv;
+        openvpn_gettimeofday(&rcv, NULL);
+        long ms =3D (long)(=
rcv=2Etv_sec - targets[i]=2Esent_at=2Etv_sec) * 1000
+                  + (=
rcv=2Etv_usec - targets[i]=2Esent_at=2Etv_usec) / 1000;
+
+        results[=
i]=2Eresponded =3D true;
+        results[i]=2Ertt_ms =3D (ms > 0) ? (unsig=
ned int)ms : 0;
+        results[i]=2Ereply =3D reply;
+        break;
    =
 }
 }
 
@@ -328,12 +369,7 @@
     {
         if (targets[i]=2Esent && !resu=
lts[i]=2Eresponded)
         {
-            socket_descriptor_t sd =3D pc->=
sd[probe_af_index(targets[i]=2Edest=2Ess_family)];
-            if (sd !=3D=
 SOCKET_UNDEFINED)
-            {
-                sendto(sd, (const char *=
)BPTR(probe), (int)BLEN(probe), 0,
-                       (const struct so=
ckaddr *)&targets[i]=2Edest, targets[i]=2Edestlen);
-            }
+       =
     oob_probe_send_target(pc, probe, &targets[i]);
         }
     }
 }
@@=
 -501,33 +537,45 @@
             continue;
         }
 
-        /* Probe t=
he first resolved address on the socket matching its address
-         * fa=
mily (stored natively; no IPv4-mapping)=2E */
-        socket_descriptor_t =
sd =3D pc=2Esd[probe_af_index(ai->ai_family)];
-        if (sd =3D=3D SOCKE=
T_UNDEFINED)
+        /* Collect every resolved address whose address famil=
y has a probe socket=2E
+         * Each address is stored natively (no IPv=
4-mapping) and later probed on
+         * its AF socket=2E Storage is size=
d to the resolved address count=2E */
+        struct probe_target *t =3D &=
targets[i];
+        int n_addr =3D 0;
+        for (const struct addrinfo =
*a =3D ai; a; a =3D a->ai_next)
+        {
+            n_addr++;
+        =
}
+        t->dests =3D gc_malloc(sizeof(*t->dests) * n_addr, true, &gc);
+=
        t->destlens =3D gc_malloc(sizeof(*t->destlens) * n_addr, true, &gc)=
;
+        for (const struct addrinfo *a =3D ai; a; a =3D a->ai_next)
+    =
    {
+            if (pc=2Esd[probe_af_index(a->ai_family)] =3D=3D SOCKET_=
UNDEFINED)
+            {
+                continue; /* no socket for this =
address family */
+            }
+            memcpy(&t->dests[t->n_dests],=
 a->ai_addr, a->ai_addrlen);
+            t->destlens[t->n_dests] =3D (sock=
len_t)a->ai_addrlen;
+            t->n_dests++;
+        }
+        freeadd=
rinfo(ai);
+
+        if (t->n_dests =3D=3D 0)
         {
             msg(=
D_LOW, "server-probe: %s:%s: not reachable by the probe socket", ce->remote=
,
                 ce->remote_port);
+            continue;
         }
-   =
     else
+
+        if (!oob_probe_send_target(&pc, &probe, t))
         {=

-            memcpy(&targets[i]=2Edest, ai->ai_addr, ai->ai_addrlen);
-   =
         socklen_t destlen =3D (socklen_t)ai->ai_addrlen;
-            if (=
sendto(sd, (const char *)BPTR(&probe), (int)BLEN(&probe), 0,
-             =
          (struct sockaddr *)&targets[i]=2Edest, destlen)
-                =
< 0)
-            {
-                msg(D_LOW, "server-probe: %s:%s: probe=
 send failed", ce->remote, ce->remote_port);
-            }
-            el=
se
-            {
-                openvpn_gettimeofday(&targets[i]=2Esent_=
at, NULL);
-                targets[i]=2Edestlen =3D destlen;
-            =
    targets[i]=2Esent =3D true;
-                sent_count++;
-           =
 }
+            msg(D_LOW, "server-probe: %s:%s: probe send failed", ce->re=
mote, ce->remote_port);
+            continue;
         }
-        freeaddr=
info(ai);
+
+        openvpn_gettimeofday(&t->sent_at, NULL);
+        t->s=
ent =3D true;
+        sent_count++;
     }
 
     if (sent_count > 0)

-- =

To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1751?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Pro=
ject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I00208610e0ce4f3ed9a8=
7233e68ece1b3b8a768a
Gerrit-Change-Number: 1751
Gerrit-PatchSet: 14
Gerrit-=
Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--ldabSzRRMhU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #14</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
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
-<br>M doc/man-sections/client-options=2Erst<br>M src/openvpn/oob_client=2E=
c<br>2 files changed, 92 insertions(+), 44 deletions(-)<br><br></pre><pre c=
lass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/51=
/1751/14</pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;"><span>diff --git a/doc/man-sections/client-options=2Erst b/doc/m=
an-sections/client-options=2Erst</span><br><span>index f253a94=2E=2E541743f=
 100644</span><br><span>--- a/doc/man-sections/client-options=2Erst</span><=
br><span>+++ b/doc/man-sections/client-options=2Erst</span><br><span>@@ -60=
4,7 +604,7 @@</span><br><span>      server-probe</span><br><span>      serv=
er-probe max-latency-diff</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-  A small probe message is sent to the first resolved=
 address of every UDP</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  A small probe message is sent to every resolved address of every UDP</s=
pan><br><span>   remote, and each answering server replies with its adverti=
sed priority</span><br><span>   and weight=2E Remotes are then reordered fo=
llowing DNS SRV (RFC 2782)</span><br><span>   semantics: servers that answe=
red are tried before those that did not,</span><br><span>diff --git a/src/o=
penvpn/oob_client=2Ec b/src/openvpn/oob_client=2Ec</span><br><span>index 78=
dc432=2E=2E9979de9 100644</span><br><span>--- a/src/openvpn/oob_client=2Ec<=
/span><br><span>+++ b/src/openvpn/oob_client=2Ec</span><br><span>@@ -52,11 =
+52,15 @@</span><br><span> #define OOB_PROBE_RETRIES 1</span><br><span> </s=
pan><br><span> /* Where we sent a probe, so a reply&#39;s source address ca=
n be matched back to the</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * connection-list entry it belongs to=2E */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * connection-list entry it belongs to=2E A rem=
ote may resolve to several</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * addresses, all of which are probed; a reply from any of them coun=
ts=2E The</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * dests /=
 destlens arrays are gc-allocated, sized to the remote&#39;s resolved</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * address count=2E */</s=
pan><br><span> struct probe_target</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct sockaddr_storage dest;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    socklen_t destlen;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct sockaddr_storage =
*dests;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    socklen_=
t *destlens;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int=
 n_dests;</span><br><span>     bool sent;</span><br><span>     struct timev=
al sent_at; /* when the probe was sent, for RTT measurement */</span><br><s=
pan> };</span><br><span>@@ -177,6 +181,30 @@</span><br><span>     }</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/* Send the probe to every resolved address of t, each on the soc=
ket matching</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * its =
address family=2E Returns true if at least one send succeeded=2E */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+oob_probe_send_target(const struct =
probe_ctx *pc, const struct buffer *probe,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                      const struct probe_target *t)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    bool any_sent =3D false;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    for (int k =3D 0; k &lt; =
t-&gt;n_dests; k++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        socket=
_descriptor_t sd =3D pc-&gt;sd[probe_af_index(t-&gt;dests[k]=2Ess_family)];=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (sd =3D=
=3D SOCKET_UNDEFINED)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    continue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (send=
to(sd, (const char *)BPTR(probe), (int)BLEN(probe), 0,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                   (const struct sockadd=
r *)&amp;t-&gt;dests[k], t-&gt;destlens[k])</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            &gt;=3D 0)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            any_sent =3D true;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return any_sent;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan> /* Parse one received datagram as a PROBE_REPLY and, if valid and matc=
hing one</span><br><span>  * of the probes we sent, record the reply in res=
ults=2E */</span><br><span> static void</span><br><span>@@ -219,23 +247,36 =
@@</span><br><span>         return;</span><br><span>     }</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Match the rep=
ly&#39;s source address to the remote we probed=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Match the reply&#39;s source addre=
ss to one of the addresses we probed for a</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * remote=2E The first reply for a remote wins (=
a remote with several addresses</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+     * may answer from more than one)=2E */</span><br><span>   =
  for (int i =3D 0; i &lt; n; i++)</span><br><span>     {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        if (targets[i]=2Esent</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            &amp;&amp; addr_por=
t_match((const struct openvpn_sockaddr *)(const void *)from,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                               (cons=
t struct openvpn_sockaddr *)(const void *)&amp;targets[i]=2Edest))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if (!targets[i]=2Ese=
nt || results[i]=2Eresponded)</span><br><span>         {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            struct timeval rcv;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            openvpn_gettimeofd=
ay(&amp;rcv, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          long ms =3D (long)(rcv=2Etv_sec - targets[i]=2Esent_at=2Etv_sec) =
* 1000</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
       + (rcv=2Etv_usec - targets[i]=2Esent_at=2Etv_usec) / 1000;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            results[i]=2Eresponded =3D true;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            results[i]=2Ertt_=
ms =3D (ms &gt; 0) ? (unsigned int)ms : 0;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            results[i]=2Ereply =3D reply;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            break;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            continue;</span><br><sp=
an>         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        bool match =3D fa=
lse;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (in=
t k =3D 0; k &lt; targets[i]=2En_dests &amp;&amp; !match; k++)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            match =3D addr_port_match((co=
nst struct openvpn_sockaddr *)(const void *)from,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                                    (const st=
ruct openvpn_sockaddr *)(const void *)&amp;targets[i]=2Edests[k]);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        if (!match)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            continue;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        struct timeval rcv;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        openvpn_gettimeofday(&amp;rcv, NULL);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        long ms =3D (long)(rcv=2Etv_sec -=
 targets[i]=2Esent_at=2Etv_sec) * 1000</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                  + (rcv=2Etv_usec - targets[i]=2Esent_a=
t=2Etv_usec) / 1000;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        results[i]=
=2Eresponded =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        results[i]=2Ertt_ms =3D (ms &gt; 0) ? (unsigned int)ms : 0;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        results[i]=2Erep=
ly =3D reply;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  break;</span><br><span>     }</span><br><span> }</span><br><span> </span>=
<br><span>@@ -328,12 +369,7 @@</span><br><span>     {</span><br><span>     =
    if (targets[i]=2Esent &amp;&amp; !results[i]=2Eresponded)</span><br><sp=
an>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    socket_descriptor_t sd =3D pc-&gt;sd[probe_af_index(targets[i]=2Edest=
=2Ess_family)];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      if (sd !=3D SOCKET_UNDEFINED)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                sendto(sd, (const char *)BPTR(probe), (int)BLEN(probe=
), 0,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
       (const struct sockaddr *)&amp;targets[i]=2Edest, targets[i]=2Edestle=
n);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            oob_probe_se=
nd_target(pc, probe, &amp;targets[i]);</span><br><span>         }</span><br=
><span>     }</span><br><span> }</span><br><span>@@ -501,33 +537,45 @@</spa=
n><br><span>             continue;</span><br><span>         }</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* Probe =
the first resolved address on the socket matching its address</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-         * family (stored natively;=
 no IPv4-mapping)=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        socket_descriptor_t sd =3D pc=2Esd[probe_af_index(ai-&gt;ai_famil=
y)];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (sd =
=3D=3D SOCKET_UNDEFINED)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        /* Collect every resolved address whose address family has a p=
robe socket=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
    * Each address is stored natively (no IPv4-mapping) and later probed on=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * its AF s=
ocket=2E Storage is sized to the resolved address count=2E */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        struct probe_target *t =
=3D &amp;targets[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        int n_addr =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        for (const struct addrinfo *a =3D ai; a; a =3D a-&gt;ai_next=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            n_addr++;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        t-&gt;dests =3D gc_malloc(si=
zeof(*t-&gt;dests) * n_addr, true, &amp;gc);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        t-&gt;destlens =3D gc_malloc(sizeof(*t-&gt=
;destlens) * n_addr, true, &amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        for (const struct addrinfo *a =3D ai; a; a =3D a-&=
gt;ai_next)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (pc=
=2Esd[probe_af_index(a-&gt;ai_family)] =3D=3D SOCKET_UNDEFINED)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                continue; /* no socke=
t for this address family */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            memcpy(&amp;t-&gt;dests[t-&gt;n_dests], a-&gt;ai_addr, a-&gt=
;ai_addrlen);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      t-&gt;destlens[t-&gt;n_dests] =3D (socklen_t)a-&gt;ai_addrlen;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            t-&gt;n_dests+=
+;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        freeaddrinfo(ai);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (t-&gt;n_dests =3D=3D 0)</spa=
n><br><span>         {</span><br><span>             msg(D_LOW, &quot;server=
-probe: %s:%s: not reachable by the probe socket&quot;, ce-&gt;remote,</spa=
n><br><span>                 ce-&gt;remote_port);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            continue;</span><br><span>       =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        else</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        if (!oob_probe_send_target(&amp;pc, =
&amp;probe, t))</span><br><span>         {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            memcpy(&amp;targets[i]=2Edest, ai-&gt;ai_a=
ddr, ai-&gt;ai_addrlen);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            socklen_t destlen =3D (socklen_t)ai-&gt;ai_addrlen;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            if (sendto(sd, (co=
nst char *)BPTR(&amp;probe), (int)BLEN(&amp;probe), 0,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                       (struct sockaddr *)=
&amp;targets[i]=2Edest, destlen)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                &lt; 0)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                msg(D_LOW, &quot;server-probe: %s:%s: probe send faile=
d&quot;, ce-&gt;remote, ce-&gt;remote_port);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            else</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                openvpn_gettimeofday(&amp;targets[i]=2Esent_at, NULL);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                targets[=
i]=2Edestlen =3D destlen;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                targets[i]=2Esent =3D true;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                sent_count++;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            msg(D_LOW, &quot;server-probe: %s:%=
s: probe send failed&quot;, ce-&gt;remote, ce-&gt;remote_port);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            continue;</span><br=
><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    freeaddrinfo(ai);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        openvpn_g=
ettimeofday(&amp;t-&gt;sent_at, NULL);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        t-&gt;sent =3D true;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        sent_count++;</span><br><span>     }</s=
pan><br><span> </span><br><span>     if (sent_count &gt; 0)</span><br><span=
></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1751?usp=3Demail">change 1751</a>=2E To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sc=
hema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1751?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: o=
penvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<di=
v style=3D"display:none"> Gerrit-Change-Id: I00208610e0ce4f3ed9a87233e68ece=
1b3b8a768a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1751 <=
/div>
<div style=3D"display:none"> Gerrit-PatchSet: 14 </div>
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
--ldabSzRRMhU=--


--===============3806501950154407146==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3806501950154407146==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3806501950154407146==--

