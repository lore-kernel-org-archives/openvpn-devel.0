Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B58FC88E4C
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 08:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IBFgLUQ1+v9JzIe8+KZ/Yj9LnTveHc0Z1pgg0+L3EVo=; b=c/48v7hB17R1fovufxevxe1qkr
	4F/d5SBP5dob7B8Xk0q+qc48oc17m7M/26LWkjUm+0ofHHA7OiYY52jYAz4jVe4NmHMnhxLcOUQ8t
	tOPc1+jixPA4b5DZkztaYcrR4D+3y0qR6AauNpHs+O58Wm8vrpw+rd/dPqKsznQOGW6g=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4wSz-0003fo-IK;
	Fri, 11 Sep 2026 08:18:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4wSy-0003fa-6b
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 08:18:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=1zjUJRRKshdCF+UBKr6xf2OLzx4bZCErl+2AF0yaA40=; b=Yw1FoZgbvlKkddxprk9U/56cQL
 fRGbLb5eYwxAoiiOa+dUtX4vTE0Kf9d8YBASQUf0glfhASWlKhOJTIGCR4n5fR34ghOKIgNVCcXNP
 qhNXGWwn5ahaLe3bErtW6I8oXVCoHyjABqcn0Uvuapgp/mrqM9+9q9oPP1R+TTeMpII8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=1zjUJRRKshdCF+UBKr6xf2OLzx4bZCErl+2AF0yaA40=; b=b
 LnRTmTiQjaM6Dj0e9OilYKYv9wB2KqezlJgy2kXzBNUMky1lpFokcoc4xH95//nPmNo4ro2UuIopP
 gSVWOPunrPyFKXNFyNQTBIiXAJi5wxH+I1Xq4TnHEyzhJ53xUeR7a05z2uoRrT+ov36rmTA9SAoGf
 nZkeYA15sRJYVadw=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4wSt-0005Pb-QX for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 08:18:36 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-49a97714f5dso5870975e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 01:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789114705; x=1789719505; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1zjUJRRKshdCF+UBKr6xf2OLzx4bZCErl+2AF0yaA40=;
 b=fUUG1d2kC3Dm4MpaAmhhXWq5fsef5QTEhlTLG0H/gOG7tuZrcGLK/gc/jpL1pP6MTL
 s3sgqnHdpWV3LnrfwcZUTw7D7F2NSw4vppwHFQlKEx3pRrZw1ZEcvpYfQA299SewSmZG
 cv9h22tzvINpRa8zdPtU07/ZsmRLn5LM9E+4x4nuEiI8oywaXrqCr16QStX9A6al0TTn
 FoumjvpL4xhTM52Sufih/bT1ESO6C2xbhz79ggHZePlNCTzGOYtbvwbRKcZlA5fs2Odx
 TF+xZaxokrn9ivCKe2yulF3XNd/O7it+0YQOf3FJvhqs+afj7YjuexXCXB9zmw+hfftM
 8Mzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789114705; x=1789719505;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=1zjUJRRKshdCF+UBKr6xf2OLzx4bZCErl+2AF0yaA40=;
 b=eqfld8Psy3YHjgAa9A1+rXDTahITI+/yozGmuFYmJXLT7ujjuKGuZqx0wj/CrvuLZt
 /0EGchu5WrXe9KnjqF7YcPezRcLvbIEgHNhlMPS8SIqk0zziJ4tNXpLKUV/wgjTmmZyW
 jbnLcyt7QdE1iw7IjE7YnPDmnP5fyO1M2tU4duLCTAnJu4POSByDXR71ZeMWbnax8avP
 XNg9doExzt12Xf2nLvHUn7f91ieosPPxSLaZ/hrkjpdKxLQedN60aYs/wjJEoM5ZOj2M
 gtdmeCSFMEFeWT1QmcQA+TFXv2QPgH9ypaYFlX9XWAFjilBObJ8qv2r4MvdU5dhj0whe
 42JQ==
X-Gm-Message-State: AFuF++lK2+FIETZIYNNRSByzYJ6T4o7MgTPiyPCSOQIpvGdT3MPF4W4/
 nFdUi0H6XMoPy5P2mUFsfeSnJQomJHMEFdWsqjLaehgHmKGhJ383UwBtIfj7+XDo5BzyR/oPYfL
 fzLjRK8cKKaG3Ea4Wsqgi1PAfqDzgTROJqBfsbK9h/Z890fJEO+ibFvjtXI1wzgmPkiMk
X-Gm-Gg: AYBFou0/7CDFNm4YDoliX3/ZWl8bY5vD17F3w4J6P62jCSJZmeZczqmyV8puJ9k0V4Y
 FCKaaIu7akw7WZs/ma/0+WyNr5c/v7f2VNyd8h425b45AHn8kob/J+Ko4NhELH4l64b9bsq3Wh1
 q1kGzgNcRNRfjbBnQhuSpkNGMuGSfW64nP9VaFesKj8CIeEAHmPQXC/qUdmnU6jZz/tZRGeLvMT
 NLNvQqEkavTgpR0P/zdzjOjCOZpwGkPgguFNPu1lK2alAmH1y2BPkU9Tw7DWpF8u+emf/DYbKfF
 eIoBZAYy1Tki1fbTgpLYe6zQeOGAD+KKsWYulW2a8+yOpP6xA2eENj5zWDcCxlBgP1F/qNh6sBW
 AYLojf4K1GcPbYvUx1K4rWp7YfY0MqZSuO2sarvGEsPL+MYscPG23KxWwpSlcggusVw/BeA1s3u
 wsIYwTuIognnX3wHA3cBsTmCQ5nYwP+zIiPrpYdGVesf254g+/SDKP/KnR+NJ9vJ8YwnunSEPOr
 o899K/QaDskSRzzuM+wUGjWWiXkqHf2zgUp0jn7WFCBKW3hoCqWFVbq0VVcg2QRk55TRwjzX2k+
 FUWs2NXkr+AQS/rsp9do+rbxoT57fMb7bIBBFleQfk2L3OFs6H8V4/Sntwc2IRL2cuMfs8wz
X-Received: by 2002:a05:600c:4686:b0:49c:dadb:18a7 with SMTP id
 5b1f17b1804b1-49e6198f62fmr36879305e9.10.1789114705051; 
 Fri, 11 Sep 2026 01:18:25 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60a8a89esm56598535e9.1.2026.09.11.01.18.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 01:18:24 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 08:18:16 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 18
X-Gerrit-Change-Id: I375a41749060b7d006647bc27002c55436c8a8bb
X-Gerrit-Change-Number: 1748
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1748?usp=email>
X-Gerrit-Commit: 3f9c4e80a5b37ef5c5e357e36ccb2c236df38af5
In-Reply-To: <gerrit.1782719911000.I375a41749060b7d006647bc27002c55436c8a8bb@gerrit.openvpn.net>
References: <gerrit.1782719911000.I375a41749060b7d006647bc27002c55436c8a8bb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkzNzVhNDE3NDkwNjBiN2QwMDY2NDdiYzI3MDAyYzU1NDM2YzhhOGJiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c8ce056c3c082324d5eddd5293a0d11dccfadddb-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4wSt-0005Pb-QX
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
Content-Type: multipart/mixed; boundary="===============0524295131111194598=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0524295131111194598==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8q72kTuMT2I="; charset=UTF-8

--8q72kTuMT2I=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1748?usp=3Demail

to look at the new patch set (#18)=2E
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
/openvpn/oob=2Eh
M src/openvpn/oob_client=2Ec
3 files changed, 26 insertion=
s(+), 5 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/48/1748/18

diff --git a/doc/man-sections/client-options=2Er=
st b/doc/man-sections/client-options=2Erst
index 0db010e=2E=2E76b9b9b 10064=
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
index 75c553d=2E=2E9df8b95 100644
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
@@ -569,6 +575,=
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
 -591,8 +598,16 @@
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
Gerrit-PatchSet: 18
Gerri=
t-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--8q72kTuMT2I=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #18</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
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
oob=2Eh<br>M src/openvpn/oob_client=2Ec<br>3 files changed, 26 insertions(+=
), 5 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvp=
n=2Enet:29418/openvpn refs/changes/48/1748/18</pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/doc/man-=
sections/client-options=2Erst b/doc/man-sections/client-options=2Erst</span=
><br><span>index 0db010e=2E=2E76b9b9b 100644</span><br><span>--- a/doc/man-=
sections/client-options=2Erst</span><br><span>+++ b/doc/man-sections/client=
-options=2Erst</span><br><span>@@ -608,9 +608,14 @@</span><br><span>   remo=
te, and each answering server replies with its advertised priority</span><b=
r><span>   and weight=2E Remotes are then reordered following DNS SRV (RFC =
2782)</span><br><span>   semantics: servers that answered are tried before =
those that did not,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
grouped by priority (lowest first); within a priority group, servers are</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-  picked by weighted-ran=
dom selection=2E Round-trip time is not yet taken</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-  into account, so ``max-latency-diff`` has no =
effect for now=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
grouped by priority (lowest first); within a priority group, servers</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  whose measured round-tri=
p time is within ``max-latency-diff``</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  milliseconds of the fastest one are picked by weighted-=
random</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  selection, =
the others follow in round-trip-time order=2E When</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  ``max-latency-diff`` is not given, the mar=
gin advertised by the</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  answering server applies; a server advertising :code:`0` asks to be</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  compared on latency a=
lone, so only the fastest server of its priority</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  group is treated as best=2E</span><br><span>=
 </span><br><span>   The probe is currently sent without control-channel wr=
apping, so it only</span><br><span>   works against a server configured wit=
hout ``--tls-auth``,</span><br><span>diff --git a/src/openvpn/oob=2Eh b/src=
/openvpn/oob=2Eh</span><br><span>index b26f3a4=2E=2Eaf0670a 100644</span><b=
r><span>--- a/src/openvpn/oob=2Eh</span><br><span>+++ b/src/openvpn/oob=2Eh=
</span><br><span>@@ -196,6 +196,7 @@</span><br><span>     struct openvpn_so=
ckaddr dest;</span><br><span>     socklen_t destlen;</span><br><span>     b=
ool sent;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 timeval sent_at; /* when the probe was sent, for RTT measurement */</span>=
<br><span> };</span><br><span> </span><br><span> /**</span><br><span>diff -=
-git a/src/openvpn/oob_client=2Ec b/src/openvpn/oob_client=2Ec</span><br><s=
pan>index 75c553d=2E=2E9df8b95 100644</span><br><span>--- a/src/openvpn/oob=
_client=2Ec</span><br><span>+++ b/src/openvpn/oob_client=2Ec</span><br><spa=
n>@@ -257,10 +257,16 @@</span><br><span>     /* Credit the reply to every s=
till-unanswered remote probed at its source</span><br><span>      * address=
: several entries can resolve to the same address, and each takes</span><br=
><span>      * the first reply for it=2E */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct timeval rcv;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    openvpn_gettimeofday(&amp;rcv, NULL);</span=
><br><span>     int i =3D oob_probe_next_target_at(from, targets, results, =
n, 0);</span><br><span>     while (i &gt;=3D 0)</span><br><span>     {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        long ms =3D (lon=
g)(rcv=2Etv_sec - targets[i]=2Esent_at=2Etv_sec) * 1000</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                  + (rcv=2Etv_usec - ta=
rgets[i]=2Esent_at=2Etv_usec) / 1000;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span>         results[i]=2Eresponded =3D true=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        results[i]=
=2Ertt_ms =3D (ms &gt; 0) ? (unsigned int)ms : 0;</span><br><span>         =
results[i]=2Ereply =3D reply;</span><br><span> </span><br><span>         i =
=3D oob_probe_next_target_at(from, targets, results, n, i + 1);</span><br><=
span>@@ -569,6 +575,7 @@</span><br><span>             }</span><br><span>   =
          pc=2Eprobed[pc=2En_probed++] =3D targets[i]=2Edest;</span><br><sp=
an>         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  openvpn_gettimeofday(&amp;targets[i]=2Esent_at, NULL);</span><br><span>  =
       targets[i]=2Esent =3D true;</span><br><span>         sent_count++;</=
span><br><span>     }</span><br><span>@@ -591,8 +598,16 @@</span><br><span>=
         if (results[i]=2Eresponded)</span><br><span>         {</span><br><=
span>             responded++;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            msg(D_LOW, &quot;server-probe: %s:%s answered (priorit=
y %d, weight %d)&quot;, ce-&gt;remote,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                ce-&gt;remote_port, results[i]=2Ereply=2Ep=
riority, results[i]=2Ereply=2Eweight);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            /* Effective candidate-band margin and where=
 it came from: the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
            * client&#39;s own setting wins, else the server&#39;s advertis=
ed value=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       int client_margin =3D c-&gt;options=2Eserver_probe_latency_margin;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            int margi=
n =3D oob_effective_margin(&amp;results[i], client_margin);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            const char *margin_src =
=3D client_margin &gt;=3D 0 ? &quot;client&quot; : &quot;server-advertised&=
quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            m=
sg(D_LOW,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      &quot;server-probe: %s:%s answered (priority %d, weight %d, rtt %u ms=
;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    &quot; latency margin %d ms [%s])&quot;,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                ce-&gt;remote, ce-&gt;remote_port,=
 results[i]=2Ereply=2Epriority, results[i]=2Ereply=2Eweight,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                results[i]=2Ertt_m=
s, margin, margin_src);</span><br><span>         }</span><br><span>        =
 else</span><br><span>         {</span><br><span></span><br></pre><p>To vie=
w, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1748?usp=3Dem=
ail">change 1748</a>=2E To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setting=
s</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction=
"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1748?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
=
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"d=
isplay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ger=
rit-Change-Id: I375a41749060b7d006647bc27002c55436c8a8bb </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1748 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 18 </div>
<div style=3D"display:none"> Gerrit-Owner=
: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Eso=
urceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: p=
laisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--8q72kTuMT2I=--


--===============0524295131111194598==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0524295131111194598==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0524295131111194598==--

