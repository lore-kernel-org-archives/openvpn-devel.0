Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BFD7C43602
	for <openvpn-devel@archiver.kernel.org>; Mon,  6 Jul 2026 06:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B5UjwZcZGXuFLlwTFsjQ4znJtk3/UacM9vAtL1+F1TY=; b=XtaVXbPTfCl6x/vKUbC+xEnlFH
	ROi0/p+o0yNGVaXIIapkp1JQeT3NEWixWPpmQqhYM6zGIlRXqh05eD+99GzjGFgE2b0/LjRrqv1YI
	cllRjtD4B8B61oNcuJcf078wc3nygTdkzGEBKVPZJxJbGEIO+3SjQlr57OZbm+hfX5iA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wgdAf-0005qi-GE;
	Mon, 06 Jul 2026 06:51:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wgdAd-0005qa-L0
 for openvpn-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 06:51:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Cbp6V8BAGOchDgCJ4sSosLvW0JYFBSv3QIJrc/8IvYE=; b=g2bsuplQA+5iIujhd+bURJ6Qaz
 eWjIZ3DKbONgITbv33VFpK/utOoXj3DwpzN5uAOX+8LjLJhA8yybLlprc0RPpmIrWcmC86HtxQ5Sr
 SwCmgXToXal8LWaHzuQHOKLq6IYaRUyFGrtWmH97LGijZyTmRg4e52y/FKSbg5oHOqZo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Cbp6V8BAGOchDgCJ4sSosLvW0JYFBSv3QIJrc/8IvYE=; b=f
 kfCE+B9VSBWU2FSYjHpH48zdErRrw4HXQOCJXISxZ05VWBYEHxRMLjHor3xGa+rs12gQUiUmB6dWz
 XfJvV+DC92lbkRpQBAaPrD7F81YWrU+1dKfG3P72OFpywqn8rIsf23BtpTs3IwDI1Pc81bA34uMvj
 ZVcGIdE0KdGvFUuM=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wgdAb-000468-JM for openvpn-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 06:51:11 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09aaso475744f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 05 Jul 2026 23:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783320658; x=1783925458; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Cbp6V8BAGOchDgCJ4sSosLvW0JYFBSv3QIJrc/8IvYE=;
 b=MGEorM2djqV18Qa+O4E9dyDJUMZxNxpp496PXZyS6WBul7lYOqgot6o121x4EqWYYn
 rWMvq0H67VAkWpnmQkTp2WbAk6x8piw4iaFtxRk+4ykUjVk3RllefPgP+0e0L7NEIuY8
 ROQ2My354F8767FqM5+W56kkpH/sVqPxFHk9mnzHhy59Wdf+wmMxHPAYbDk55stqJCnG
 W+RbMcaYAQiR53XyMEjQzFyBSWqhOzYE63sM7JpsMTC8J9L9o+L9aCEPdyTkCVDsaR5Z
 +IRbqK8CWfZZi21b4oA55GULSwCT1BnmQxpcZIbfYZkwXFstpHhIXr0UWoNWZ+M/O0+H
 9x/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783320658; x=1783925458;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Cbp6V8BAGOchDgCJ4sSosLvW0JYFBSv3QIJrc/8IvYE=;
 b=p+5bmmWecaNKaVYzOVN8Mx3YjaZ0FaZqOcZZ83HNuSKKaavZnJ5cCIrfdjfvfLbrxG
 1mPZm9otHNY0kbLgWe8IdDKz5UxKAatWyoCYnPg95XszeUHyJQXsnTDEPIyx4vr9KStK
 M5JAR7pcj11nKn1lTva1ZtblmE8iGuJlLlgjIkH4iM1CvqcQxHC3xHkc+HXywTFEGyp7
 yH1p8xiPBDQ94cLHLDTsTPp2QPbxFKrhK4RaS7zRJMWA4nNozvLRowT6KxPp5ZZyHjDc
 V5PqsY1uWibnr0V3Mivy40jrz+OReTS5Ngf8b+NvEpHmLGgW2LAB3b18zPmlCgdEvVll
 8gcg==
X-Gm-Message-State: AOJu0YxFdOwyockrYZXel1IYQzXGgnUnbiHpZSnOZXhYUdHtCMLWdZuy
 WQahYpvTM/4Pw8Jv80DrUX4XjbVpJ+qfmstZdUL7olHMK73HLcPywgYKF6unaZvWX/iUFXHSVSG
 KogJ0H5+Yd58KhZED+E5naL1EkEkpOi2XEDGU2ygCYOrbm9fZrE/wY3R2CMUNZIagD8pNknLK0y
 kIAK+fHQ==
X-Gm-Gg: AfdE7ckp4vYcqwX+c6lyTdhyKVLonhhKuC8IBGhuwP1x8f/SlU7r9Jt/2hfn9NxF8wx
 lBTBxqes+AX1pokReag03htDL0pOHCeJknyA9rB1SToeYURLIqPLYExaU1sFINq9amlOHqHYI0I
 1BfN+CG2SuE/vV6VlrMCsxKovQKs4Tm4IEBfCgBXWWJp7ONY0COYmwNKuZ70aGODQGIpuz2uzBY
 SAOvk240GAWjcyaFjT9m3TXtgSSor7rkmcWvntEmd4OIT6AcJFZqLonEdtudtqrxoPGEfxKBbYP
 AFbl3xPRz+9BF3QM86UXp3s3FE+gWe6LBkIBKhpfdvgUQ98mBzEtfl9JPYKjnfvS9GvysIDgDYX
 tAJ3YALkK0UKGpCIuMTM4Nyr0u4otieHWymGmvCPhttfDNQtrKy3dTiuuAFjI4vSl8C9fGmzjYO
 NXKKaL00vX1MKOEqThAsW03QuFo1E+5Ar4rbRtbmdfm8LF/yNVrDdDoYJBzWSKMgOseQ7w6t+t7
 2D7yJzsC/H7YFqkptxDXKqbEZ1w3MDKQRiSeb/X8lhC2g2h4RGz2/1Og4C1xgXOqCK7TuL3ErEe
 Hck=
X-Received: by 2002:a05:6000:1863:b0:46e:47a:dcd3 with SMTP id
 ffacd0b85a97d-47aacab4ab6mr11313654f8f.19.1783320658263; 
 Sun, 05 Jul 2026 23:50:58 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1e6ccsm22779844f8f.5.2026.07.05.23.50.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 23:50:57 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 6 Jul 2026 06:50:47 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I375a41749060b7d006647bc27002c55436c8a8bb
X-Gerrit-Change-Number: 1748
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1748?usp=email>
X-Gerrit-Commit: 9e0e57163f64ccf8b13259b8873959ad2a40b119
In-Reply-To: <gerrit.1782719911000.I375a41749060b7d006647bc27002c55436c8a8bb@gerrit.openvpn.net>
References: <gerrit.1782719911000.I375a41749060b7d006647bc27002c55436c8a8bb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkzNzVhNDE3NDkwNjBiN2QwMDY2NDdiYzI3MDAyYzU1NDM2YzhhOGJiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9e15b991b5ac8328d52cbf3a15f5ade378ab083a-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wgdAb-000468-JM
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
Content-Type: multipart/mixed; boundary="===============4966494221260726574=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4966494221260726574==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GLOPxnPFmtU="; charset=UTF-8

--GLOPxnPFmtU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1748?usp=3Demail

to look at the new patch set (#5)=2E

=

Change subject: oob: Measure probe RTT for candidate-band selection
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Measure probe =
RTT for candidate-band selection

Record each probe's round-trip time (per-=
target send timestamp vs reply
arrival) and feed it to oob_rank_probe_resul=
ts(), where RTT forms the
candidate band: responders within the effective m=
argin of the fastest compete
on weight, slower ones fall behind=2E Log the =
measured RTT and the effective
margin (with its source: client / server-adv=
ertised / default) at verb 4=2E

Before this the client never measured RTT,=
 so every responder sat in the band
and selection was purely weighted-rando=
m; with real measurements the
latency-based candidate selection takes effec=
t=2E

Change-Id: I375a41749060b7d006647bc27002c55436c8a8bb
Signed-off-by: L=
ev Stipakov <lev@openvpn=2Enet>
---
M src/openvpn/oob_client=2Ec
1 file cha=
nged, 21 insertions(+), 2 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/48/1748/5

diff --git a/src/openvpn/oob_c=
lient=2Ec b/src/openvpn/oob_client=2Ec
index 9a53dd5=2E=2E0733508 100644
--=
- a/src/openvpn/oob_client=2Ec
+++ b/src/openvpn/oob_client=2Ec
@@ -56,6 +5=
6,7 @@
     struct sockaddr_storage dest;
     socklen_t destlen;
     bool=
 sent;
+    struct timeval sent_at; /* when the probe was sent, for RTT mea=
surement */
 };
 
 /* The probe uses one native socket per address family, =
so every remote is probed
@@ -175,10 +176,16 @@
             && addr_port_m=
atch((const struct openvpn_sockaddr *)(const void *)from,
                 =
               (const struct openvpn_sockaddr *)(const void *)&targets[i]=
=2Edest))
         {
+            struct timeval rcv;
+            openvpn_=
gettimeofday(&rcv, NULL);
+            long ms =3D (long)(rcv=2Etv_sec - ta=
rgets[i]=2Esent_at=2Etv_sec) * 1000
+                      + (rcv=2Etv_usec=
 - targets[i]=2Esent_at=2Etv_usec) / 1000;
+
             results[i]=2Eresp=
onded =3D true;
             results[i]=2Epriority =3D reply=2Epriority;
  =
           results[i]=2Eweight =3D reply=2Eweight;
             results[i]=
=2Emax_latency_diff =3D reply=2Emax_latency_diff;
+            results[i]=
=2Ertt_ms =3D (ms > 0) ? (unsigned int)ms : 0;
             break;
        =
 }
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
@@ -454,8 +462,19 @@
     =
    if (results[i]=2Eresponded)
         {
             responded++;
-     =
       msg(D_LOW, "server-probe: %s:%s answered (priority %d, weight %d)", =
ce->remote,
-                ce->remote_port, results[i]=2Epriority, result=
s[i]=2Eweight);
+            /* Effective candidate-band margin and where i=
t came from: the
+             * client's own setting wins, else the server=
's advertised value,
+             * else the built-in default=2E */
+     =
       int client_margin =3D c->options=2Eserver_probe_latency_margin;
+   =
         int margin =3D oob_effective_margin(&results[i], client_margin);
+=
            const char *margin_src =3D client_margin >=3D 0                =
? "client"
+                                     : results[i]=2Emax_latency=
_diff > 0 ? "server-advertised"
+                                          =
                             : "default";
+            msg(D_LOW,
+        =
        "server-probe: %s:%s answered (priority %d, weight %d, rtt %u ms;"
=
+                " latency margin %d ms [%s])",
+                ce->remote=
, ce->remote_port, results[i]=2Epriority, results[i]=2Eweight,
+           =
     results[i]=2Ertt_ms, margin, margin_src);
         }
         else
   =
      {

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1748?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchse=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I375a4174=
9060b7d006647bc27002c55436c8a8bb
Gerrit-Change-Number: 1748
Gerrit-PatchSet=
: 5
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>

--GLOPxnPFmtU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #5</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1748?usp=3Demail">View Change</a></p><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">oob: Meas=
ure probe RTT for candidate-band selection<br><br>Record each probe&#39;s r=
ound-trip time (per-target send timestamp vs reply<br>arrival) and feed it =
to oob_rank_probe_results(), where RTT forms the<br>candidate band: respond=
ers within the effective margin of the fastest compete<br>on weight, slower=
 ones fall behind=2E Log the measured RTT and the effective<br>margin (with=
 its source: client / server-advertised / default) at verb 4=2E<br><br>Befo=
re this the client never measured RTT, so every responder sat in the band<b=
r>and selection was purely weighted-random; with real measurements the<br>l=
atency-based candidate selection takes effect=2E<br><br>Change-Id: I375a417=
49060b7d006647bc27002c55436c8a8bb<br>Signed-off-by: Lev Stipakov &lt;lev@op=
envpn=2Enet&gt;<br>---<br>M src/openvpn/oob_client=2Ec<br>1 file changed, 2=
1 insertions(+), 2 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://g=
errit=2Eopenvpn=2Enet:29418/openvpn refs/changes/48/1748/5</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/oob_client=2Ec b/src/openvpn/oob_client=2Ec</span><br><sp=
an>index 9a53dd5=2E=2E0733508 100644</span><br><span>--- a/src/openvpn/oob_=
client=2Ec</span><br><span>+++ b/src/openvpn/oob_client=2Ec</span><br><span=
>@@ -56,6 +56,7 @@</span><br><span>     struct sockaddr_storage dest;</span=
><br><span>     socklen_t destlen;</span><br><span>     bool sent;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct timeval sent_at; =
/* when the probe was sent, for RTT measurement */</span><br><span> };</spa=
n><br><span> </span><br><span> /* The probe uses one native socket per addr=
ess family, so every remote is probed</span><br><span>@@ -175,10 +176,16 @@=
</span><br><span>             &amp;&amp; addr_port_match((const struct open=
vpn_sockaddr *)(const void *)from,</span><br><span>                        =
        (const struct openvpn_sockaddr *)(const void *)&amp;targets[i]=2Ede=
st))</span><br><span>         {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            struct timeval rcv;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            openvpn_gettimeofday(&amp;rcv, NULL);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            long ms =
=3D (long)(rcv=2Etv_sec - targets[i]=2Esent_at=2Etv_sec) * 1000</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                      + (rcv=2E=
tv_usec - targets[i]=2Esent_at=2Etv_usec) / 1000;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span>             results[i]=2Ere=
sponded =3D true;</span><br><span>             results[i]=2Epriority =3D re=
ply=2Epriority;</span><br><span>             results[i]=2Eweight =3D reply=
=2Eweight;</span><br><span>             results[i]=2Emax_latency_diff =3D r=
eply=2Emax_latency_diff;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            results[i]=2Ertt_ms =3D (ms &gt; 0) ? (unsigned int)ms : 0=
;</span><br><span>             break;</span><br><span>         }</span><br>=
<span>     }</span><br><span>@@ -432,6 +439,7 @@</span><br><span>          =
   }</span><br><span>             else</span><br><span>             {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                openvpn_g=
ettimeofday(&amp;targets[i]=2Esent_at, NULL);</span><br><span>             =
    targets[i]=2Edestlen =3D destlen;</span><br><span>                 targ=
ets[i]=2Esent =3D true;</span><br><span>                 sent_count++;</spa=
n><br><span>@@ -454,8 +462,19 @@</span><br><span>         if (results[i]=2E=
responded)</span><br><span>         {</span><br><span>             responde=
d++;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(D=
_LOW, &quot;server-probe: %s:%s answered (priority %d, weight %d)&quot;, ce=
-&gt;remote,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
       ce-&gt;remote_port, results[i]=2Epriority, results[i]=2Eweight);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* Effectiv=
e candidate-band margin and where it came from: the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+             * client&#39;s own setting w=
ins, else the server&#39;s advertised value,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+             * else the built-in default=2E */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            int client_=
margin =3D c-&gt;options=2Eserver_probe_latency_margin;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            int margin =3D oob_effectiv=
e_margin(&amp;results[i], client_margin);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            const char *margin_src =3D client_margin =
&gt;=3D 0                ? &quot;client&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                                     : results[i]=
=2Emax_latency_diff &gt; 0 ? &quot;server-advertised&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                                    =
                                   : &quot;default&quot;;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            msg(D_LOW,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                &quot;server-probe=
: %s:%s answered (priority %d, weight %d, rtt %u ms;&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                &quot; latency margi=
n %d ms [%s])&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                ce-&gt;remote, ce-&gt;remote_port, results[i]=2Epriority, =
results[i]=2Eweight,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                results[i]=2Ertt_ms, margin, margin_src);</span><br><span>=
         }</span><br><span>         else</span><br><span>         {</span><=
br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1748?usp=3Demail">change 1748</a>=2E To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1748?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ger=
rit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pro=
ject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Id: I375a41749060b7d006647bc=
27002c55436c8a8bb </div>
<div style=3D"display:none"> Gerrit-Change-Number:=
 1748 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div st=
yle=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>

</body></html>
--GLOPxnPFmtU=--


--===============4966494221260726574==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4966494221260726574==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4966494221260726574==--

