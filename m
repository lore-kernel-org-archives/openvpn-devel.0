Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2949FC88E58
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Te9ch3P3EJjOg/sWgSYTvUfeLI1ZAaaoermF1ITQWcw=; b=MYB4lRvSqodLk/oQ9kDNjY8dfz
	9TL1FyrjboBfvRZvcUthG/rBz3KiENsZzU8s92OCmUL6IW2qYOzTiMmvJ/EiCs/Xzm2U+ct7pxceV
	/tJhuqQ5FmdXWPwJIhK1ArGfuGkh5buh5DmuvWD/kFytvITn2pIPsHkyYXkkvEemo2/U=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x536w-0008JH-46;
	Fri, 11 Sep 2026 15:24:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x536B-0008IH-Rf
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 15:23:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=6s2pGqKy472/JouVqo9Ehvkv/AluPSYpBqDCxLEIseI=; b=OzI1zjGUdXEeoOLluqnnwnEagv
 Uemb+TisvDGshON5uIJH2OoZB+EYiH0DAKsEEQvgkG69NFypCFg8dLTbMTV0qX/eI6edrzl50kgej
 1OjlneRkBgEG4YJ3DuxbZcAyf7oeF9+BwO4Ly930ybtP+NmnGWVPvHMpcHggsKxGFotY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6s2pGqKy472/JouVqo9Ehvkv/AluPSYpBqDCxLEIseI=; b=Y
 I3zt6Wjyu6eZcdoGe7q+zKG7vztitKiMkP4bJSv+P6X+t53sOdb9TiJPYBgT2lXh63oN0ESdBbmnN
 93frtXGKIXBKTIYa8OKqFOSGzP0MwIMviypjI3ZmWCtEYtdr+Ycdr+sYgp9ZRH4hfMSUcWPl/eqfv
 dTHP1OnKWywDQ4wQ=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x536A-0007aQ-D0 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 15:23:32 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-49d0da752ffso13709375e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 08:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789140204; x=1789745004; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6s2pGqKy472/JouVqo9Ehvkv/AluPSYpBqDCxLEIseI=;
 b=eD6eivHMdDEHQ6culeMF6o7d37uqemcA+Px0hIZsS7LUBMtOXJm8QshOnwBAwr746U
 0jIeWox1wNgGNGl0z/rKtXjXxESRdqkMHIKMgn2UkusmQbcnNb9HV3alLIFkcW2pKV4B
 ofzdbp6lEB43rSisAIe1xUi4UQPFRI2sWFr4A0zofjVC77gE8zlAFXnNX13iu7zJaBaw
 Hc0cHbyBJJEEcUpfzJkx2wI978T2MlgX6S+0BzMleQ1fIWKWYYOL2S+nf8RXTbm87yXX
 gLZ4YpSA6WfsJjSaCbsvl3r/AC2KNVVpv17DDNZYPxiIgRIEs5rS7RbO6elu+qILCbT/
 vnWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789140204; x=1789745004;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6s2pGqKy472/JouVqo9Ehvkv/AluPSYpBqDCxLEIseI=;
 b=GaJGRkAsyJr4OYepWOcwFuSAJLt9wJY5qtEHFpTUr0++VmuvkMMBP92MrmNAVmCCyq
 WlNZmiR9eNjvYKVtWhaOpGDgVHHvwQFjho/aihzdGVs97K2xhaJc3Q08uebvYSBzST67
 4tZgmfBL19iaPLPGjBpcIN6wJ0cL46HhsemyM4pFa5EIql/KdWt4qZpKtoI3gpbaOz/8
 6avuuXhkuUBdLdLu/9bUV3OrT8ZGEOJtD8ocElhjav0CSwSbnMgU0qGc40Ukhs4b+5bu
 VEz8NpZT3k2z5hvE5fz5iuF9rAThkcPEe+IR3RczcnrYG+yLQOUc0so5OV7p2pcV5H8V
 HS7w==
X-Gm-Message-State: AFuF++kFrdrcBt+mDnEI73fm8h6o+9Efjyt11M0PMqDzVFR4MP411RxD
 p+39gbMHizlSNHuIjfHPNHbNtfpcjV8AHB4N9BAycflICKanCN2WjiIV6ZKc9/DzMKxDprZImLt
 NgRVqYi3/G0lLgGZ6KjC16tXKJeq7WIM4KsD7SRAWJo5fdLsEg5ClLzuDLaHlNd+ujlwH3KJI+9
 PWUiSkmA==
X-Gm-Gg: AYBFou0nCPkGs003ekKQdDwB9uhtgL/FTj+rqPVCuHDwaYMNZDrUXuuhtJmqf4QOLC0
 9w+Zrl6/LICNfGlzMpBmkFXhkDNoRauBPNPYs0UGEiXIfl366REsYGf6TSkqar5zHuyIOQQuFnu
 IwnxdQvtyXgl4CfPkUj/qT3xFord2hYE2ri5xP1H8gTz92wfhdPjxZmxt7F8V0gw2KajSjXdf/N
 bChUwGCh7aHsk8CPqLQJ8tK/hrcJzs2tl0xxG2bwMwxZcSmJ92fNErZwIVLz2TjTwSr0igEeBxL
 VJcFdf+dJvVsYnPNPeP02nPJaOCAPSIyXU8T4LUB7Psa0PIYu13zLLFE1l/qwZlZrcy7qyA7IdD
 l1HtaB1MEWdbaDBRW9BzhxaWRILaP66Almeopj89tcoKgPng9V6cTwzRbc7+54xhZetVjgVnmlk
 Fsvas+rCmcD4qa8l4RmtlQ0yaQ2hpiz/yTcum7LRYjpXTZaXizfOvxeK35RoOnrDFaq4m2i+HVc
 r+nbk48exQP8r5QITzQlKcTVt3QUDvzsy1nqyC/RqwJfwbTc0rkJDpZTCjoarftPa5I2A92wGkq
 WlSNp792S9azPSyXlEXf4rUm//z7FcIFCXYLa3QiHiYMQWfR529j2LZCESj1vtk=
X-Received: by 2002:a05:600c:1c29:b0:49d:15f8:2bdb with SMTP id
 5b1f17b1804b1-49e619806cemr54943195e9.7.1789140203416; 
 Fri, 11 Sep 2026 08:23:23 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c1bfb5sm171392135e9.5.2026.09.11.08.23.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 08:23:23 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 15:23:13 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 20
X-Gerrit-Change-Id: I375a41749060b7d006647bc27002c55436c8a8bb
X-Gerrit-Change-Number: 1748
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1748?usp=email>
X-Gerrit-Commit: 425572b1adc4d2f0afbfb8ceeccdd80eeb3af3f0
In-Reply-To: <gerrit.1782719911000.I375a41749060b7d006647bc27002c55436c8a8bb@gerrit.openvpn.net>
References: <gerrit.1782719911000.I375a41749060b7d006647bc27002c55436c8a8bb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkzNzVhNDE3NDkwNjBiN2QwMDY2NDdiYzI3MDAyYzU1NDM2YzhhOGJiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d7e9941645ecbb18fa810e00e68c7450532b748c-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x536A-0007aQ-D0
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
Content-Type: multipart/mixed; boundary="===============4475323827910303665=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4475323827910303665==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4c2OdekjC90="; charset=UTF-8

--4c2OdekjC90=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1748?usp=3Demail

to look at the new patch set (#20)=2E
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
e margin of the fastest
compete on weight, slower ones fall behind=2E Log t=
he measured RTT and the
effective margin (with its source: client or server=
-advertised) at verb
4=2E

Before this the client never measured RTT, so ev=
ery responder sat in the
band and selection was purely weighted-random; wit=
h real measurements
the latency-based candidate selection takes effect=2E

=
Change-Id: I375a41749060b7d006647bc27002c55436c8a8bb
Signed-off-by: Lev Sti=
pakov <lev@openvpn=2Enet>
---
M doc/man-sections/client-options=2Erst
M src=
/openvpn/oob=2Eh
M src/openvpn/oob_client=2Ec
3 files changed, 26 insertion=
s(+), 5 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/48/1748/20

diff --git a/doc/man-sections/client-options=2Er=
st b/doc/man-sections/client-options=2Erst
index bdc41f4=2E=2E8af481f 10064=
4
--- a/doc/man-sections/client-options=2Erst
+++ b/doc/man-sections/client=
-options=2Erst
@@ -608,9 +608,14 @@
   remote, and each answering server re=
plies with its advertised priority
   and weight=2E Remotes are then reorde=
red following DNS SRV (RFC 2782)
   semantics: servers that answered are tr=
ied before those that did not,
-  grouped by priority (lowest first); withi=
n a priority group, servers are
-  picked by weighted-random selection=2E R=
ound-trip time is not yet taken
-  into account, so ``max-latency-diff`` ha=
s no effect for now=2E
+  grouped by priority (lowest first); within a prio=
rity group, servers
+  whose measured round-trip time is within ``max-laten=
cy-diff``
+  milliseconds of the fastest one are picked by weighted-random
=
+  selection, the others follow in round-trip-time order=2E When
+  ``max-l=
atency-diff`` is not given, the margin advertised by the
+  answering serve=
r applies; a server advertising :code:`0` asks to be
+  compared on latency=
 alone, so only the fastest server of its priority
+  group is treated as b=
est=2E
 
   The probe is currently sent without control-channel wrapping, s=
o it only
   works against a server configured without ``--tls-auth``,
diff=
 --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh
index b26f3a4=2E=2Eaf067=
0a 100644
--- a/src/openvpn/oob=2Eh
+++ b/src/openvpn/oob=2Eh
@@ -196,6 +19=
6,7 @@
     struct openvpn_sockaddr dest;
     socklen_t destlen;
     bool=
 sent;
+    struct timeval sent_at; /* when the probe was sent, for RTT mea=
surement */
 };
 
 /**
diff --git a/src/openvpn/oob_client=2Ec b/src/openvp=
n/oob_client=2Ec
index a91f8a9=2E=2E05ccfc9 100644
--- a/src/openvpn/oob_cl=
ient=2Ec
+++ b/src/openvpn/oob_client=2Ec
@@ -257,10 +257,16 @@
     /* Cre=
dit the reply to every still-unanswered remote probed at its source
      *=
 address: several entries can resolve to the same address, and each takes
 =
     * the first reply for it=2E */
+    struct timeval rcv;
+    openvpn_g=
ettimeofday(&rcv, NULL);
     int i =3D oob_probe_next_target_at(from, targ=
ets, results, n, 0);
     while (i >=3D 0)
     {
+        long ms =3D (lon=
g)(rcv=2Etv_sec - targets[i]=2Esent_at=2Etv_sec) * 1000
+                  =
+ (rcv=2Etv_usec - targets[i]=2Esent_at=2Etv_usec) / 1000;
+
         resul=
ts[i]=2Eresponded =3D true;
+        results[i]=2Ertt_ms =3D (ms > 0) ? (un=
signed int)ms : 0;
         results[i]=2Ereply =3D reply;
 
         i =3D =
oob_probe_next_target_at(from, targets, results, n, i + 1);
@@ -571,6 +577,=
7 @@
             }
             pc=2Eprobed[pc=2En_probed++] =3D targets[i=
]=2Edest;
         }
+        openvpn_gettimeofday(&targets[i]=2Esent_at, N=
ULL);
         targets[i]=2Esent =3D true;
         sent_count++;
     }
@@=
 -594,8 +601,16 @@
         if (results[i]=2Eresponded)
         {
        =
     responded++;
-            msg(D_LOW, "server-probe: %s:%s answered (pr=
iority %d, weight %d)", ce->remote,
-                ce->remote_port, resul=
ts[i]=2Ereply=2Epriority, results[i]=2Ereply=2Eweight);
+            /* Eff=
ective candidate-band margin and where it came from: the
+             * cl=
ient's own setting wins, else the server's advertised value=2E */
+        =
    int client_margin =3D c->options=2Eserver_probe_latency_margin;
+      =
      int margin =3D oob_effective_margin(&results[i], client_margin);
+   =
         const char *margin_src =3D client_margin >=3D 0 ? "client" : "serv=
er-advertised";
+            msg(D_LOW,
+                "server-probe: %s:=
%s answered (priority %d, weight %d, rtt %u ms;"
+                " latency=
 margin %d ms [%s])",
+                ce->remote, ce->remote_port, results=
[i]=2Ereply=2Epriority, results[i]=2Ereply=2Eweight,
+                resul=
ts[i]=2Ertt_ms, margin, margin_src);
         }
         else
         {

-=
- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1748?usp=3Demai=
l
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I375a41749060b7d006=
647bc27002c55436c8a8bb
Gerrit-Change-Number: 1748
Gerrit-PatchSet: 20
Gerri=
t-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--4c2OdekjC90=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #20</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1748?usp=3Demail">View Change</a></p><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">oob: Mea=
sure probe RTT for candidate-band selection<br><br>Record each probe&#39;s =
round-trip time (per-target send timestamp vs reply<br>arrival) and feed it=
 to oob_rank_probe_results(), where RTT forms the<br>candidate band: respon=
ders within the effective margin of the fastest<br>compete on weight, slowe=
r ones fall behind=2E Log the measured RTT and the<br>effective margin (wit=
h its source: client or server-advertised) at verb<br>4=2E<br><br>Before th=
is the client never measured RTT, so every responder sat in the<br>band and=
 selection was purely weighted-random; with real measurements<br>the latenc=
y-based candidate selection takes effect=2E<br><br>Change-Id: I375a41749060=
b7d006647bc27002c55436c8a8bb<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=
=2Enet&gt;<br>---<br>M doc/man-sections/client-options=2Erst<br>M src/openv=
pn/oob=2Eh<br>M src/openvpn/oob_client=2Ec<br>3 files changed, 26 insertion=
s(+), 5 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/48/1748/20</pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/doc/m=
an-sections/client-options=2Erst b/doc/man-sections/client-options=2Erst</s=
pan><br><span>index bdc41f4=2E=2E8af481f 100644</span><br><span>--- a/doc/m=
an-sections/client-options=2Erst</span><br><span>+++ b/doc/man-sections/cli=
ent-options=2Erst</span><br><span>@@ -608,9 +608,14 @@</span><br><span>   r=
emote, and each answering server replies with its advertised priority</span=
><br><span>   and weight=2E Remotes are then reordered following DNS SRV (R=
FC 2782)</span><br><span>   semantics: servers that answered are tried befo=
re those that did not,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-  grouped by priority (lowest first); within a priority group, servers are=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  picked by weighted-=
random selection=2E Round-trip time is not yet taken</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  into account, so ``max-latency-diff`` has=
 no effect for now=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  grouped by priority (lowest first); within a priority group, servers</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  whose measured round=
-trip time is within ``max-latency-diff``</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  milliseconds of the fastest one are picked by weigh=
ted-random</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  selecti=
on, the others follow in round-trip-time order=2E When</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  ``max-latency-diff`` is not given, the=
 margin advertised by the</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  answering server applies; a server advertising :code:`0` asks to be=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  compared on laten=
cy alone, so only the fastest server of its priority</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  group is treated as best=2E</span><br><=
span> </span><br><span>   The probe is currently sent without control-chann=
el wrapping, so it only</span><br><span>   works against a server configure=
d without ``--tls-auth``,</span><br><span>diff --git a/src/openvpn/oob=2Eh =
b/src/openvpn/oob=2Eh</span><br><span>index b26f3a4=2E=2Eaf0670a 100644</sp=
an><br><span>--- a/src/openvpn/oob=2Eh</span><br><span>+++ b/src/openvpn/oo=
b=2Eh</span><br><span>@@ -196,6 +196,7 @@</span><br><span>     struct openv=
pn_sockaddr dest;</span><br><span>     socklen_t destlen;</span><br><span> =
    bool sent;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct timeval sent_at; /* when the probe was sent, for RTT measurement */</=
span><br><span> };</span><br><span> </span><br><span> /**</span><br><span>d=
iff --git a/src/openvpn/oob_client=2Ec b/src/openvpn/oob_client=2Ec</span><=
br><span>index a91f8a9=2E=2E05ccfc9 100644</span><br><span>--- a/src/openvp=
n/oob_client=2Ec</span><br><span>+++ b/src/openvpn/oob_client=2Ec</span><br=
><span>@@ -257,10 +257,16 @@</span><br><span>     /* Credit the reply to ev=
ery still-unanswered remote probed at its source</span><br><span>      * ad=
dress: several entries can resolve to the same address, and each takes</spa=
n><br><span>      * the first reply for it=2E */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct timeval rcv;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    openvpn_gettimeofday(&amp;rcv, NULL);=
</span><br><span>     int i =3D oob_probe_next_target_at(from, targets, res=
ults, n, 0);</span><br><span>     while (i &gt;=3D 0)</span><br><span>     =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        long ms =
=3D (long)(rcv=2Etv_sec - targets[i]=2Esent_at=2Etv_sec) * 1000</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                  + (rcv=2Etv_u=
sec - targets[i]=2Esent_at=2Etv_usec) / 1000;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span>         results[i]=2Eresponded =
=3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
sults[i]=2Ertt_ms =3D (ms &gt; 0) ? (unsigned int)ms : 0;</span><br><span> =
        results[i]=2Ereply =3D reply;</span><br><span> </span><br><span>   =
      i =3D oob_probe_next_target_at(from, targets, results, n, i + 1);</sp=
an><br><span>@@ -571,6 +577,7 @@</span><br><span>             }</span><br><=
span>             pc=2Eprobed[pc=2En_probed++] =3D targets[i]=2Edest;</span=
><br><span>         }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        openvpn_gettimeofday(&amp;targets[i]=2Esent_at, NULL);</span><br>=
<span>         targets[i]=2Esent =3D true;</span><br><span>         sent_co=
unt++;</span><br><span>     }</span><br><span>@@ -594,8 +601,16 @@</span><b=
r><span>         if (results[i]=2Eresponded)</span><br><span>         {</sp=
an><br><span>             responded++;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            msg(D_LOW, &quot;server-probe: %s:%s answered =
(priority %d, weight %d)&quot;, ce-&gt;remote,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                ce-&gt;remote_port, results[i]=2Er=
eply=2Epriority, results[i]=2Ereply=2Eweight);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            /* Effective candidate-band margin a=
nd where it came from: the</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+             * client&#39;s own setting wins, else the server&#39;s =
advertised value=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            int client_margin =3D c-&gt;options=2Eserver_probe_latency_m=
argin;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            i=
nt margin =3D oob_effective_margin(&amp;results[i], client_margin);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            const char *mar=
gin_src =3D client_margin &gt;=3D 0 ? &quot;client&quot; : &quot;server-adv=
ertised&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       msg(D_LOW,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              &quot;server-probe: %s:%s answered (priority %d, weight %d, r=
tt %u ms;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            &quot; latency margin %d ms [%s])&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                ce-&gt;remote, ce-&gt;rem=
ote_port, results[i]=2Ereply=2Epriority, results[i]=2Ereply=2Eweight,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                results[i=
]=2Ertt_ms, margin, margin_src);</span><br><span>         }</span><br><span=
>         else</span><br><span>         {</span><br><span></span><br></pre>=
<p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1748=
?usp=3Demail">change 1748</a>=2E To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1748?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchse=
t </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div s=
tyle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:n=
one"> Gerrit-Change-Id: I375a41749060b7d006647bc27002c55436c8a8bb </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Number: 1748 </div>
<div style=3D"=
display:none"> Gerrit-PatchSet: 20 </div>
<div style=3D"display:none"> Gerr=
it-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--4c2OdekjC90=--


--===============4475323827910303665==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4475323827910303665==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4475323827910303665==--

