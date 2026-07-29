Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C363C53200
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 12:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aoa3jfdLVtIvq5nMBP6tpSAeaWLnO7LB+MS4rVjt6wg=; b=gWzS20svFE4l+6znpsUfS2knIT
	BzA67/XJj9cqo+u/EGdHm3DApYxLPh+Z+3yWwvq0OS6vkKeELkfOI+iqC3NIRDZkNggOJrpUAcMUB
	l8XxRfr8MuSNqdIsHU6lLSwqCRBn2/4i7urmjZAvmm/hzlY420wJnVKIdzOdprrOh8+Y=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wp3Jq-0003Ys-9A;
	Wed, 29 Jul 2026 12:23:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wp3Jo-0003Yl-Tz
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 12:23:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Ht8zy9C8LzrRQILUNT4SJG3phKjuJLQv5NRcPn0yt08=; b=Kn18eHOVbza/aCNqKfoijrdOyi
 +e2QGEkOGJVyuDXEBnUjzRwKzKZYKkyqqUfWEQ/okTNmyLGw+YU46uj9i53YdSJ8vNqTMV0vkzbhi
 CnbYeYcDa8T4hLadruBsUW0FkoxGAEasL6xPoyYzvu0HYg4AYaCMzbCMGme0v+rOMgSM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Ht8zy9C8LzrRQILUNT4SJG3phKjuJLQv5NRcPn0yt08=; b=j
 ylhBXonytoUxzTHMj58N4XS1/RHzup1vgGYOBVIk4szMepIlLKHZh+zlQ03SrrDx5vlu9VCS2NUx1
 7QWToqqBWPiJNYocStu5IwrR8w+F2zdUK/ZLF5DCzpcSsi2dz4HvfCMJj1S5JDk6hPPTkxdm49a1o
 d8+zRCnA9rkxrnno=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wp3Jo-0005LN-2S for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 12:23:26 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4954afac04bso9921965e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 29 Jul 2026 05:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785327798; x=1785932598; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Ht8zy9C8LzrRQILUNT4SJG3phKjuJLQv5NRcPn0yt08=;
 b=PJoLPZ1bfN83nta0Y+OdMAu+foVq6ZGDdiIqkJJLKwsSIIkwCACYIYAxe1Nll6Fo67
 DB9osp0BhNP+PgNofg7e/M7gQ909SjZ1aX0tT5/txQvaDPA6GQ6VbuyR7lmAxozbrlia
 KWUbrRUYPh9vs1qNt7acgPC/ui4fc4KYrSZVwIOQD4LjSHLg/ckgflw0041a41ORuxGX
 UjMRiD4iJbJy7adxnu+7uHHPC97q3ib1DQ36p1/RfGdubm0w8+7CFY2VkoSAUCsqGhta
 lNYmNFlhBmVsWT0EIFTFbjiIjtDoMcco0SuCQSLKLDqwSmkK/0QeHm6N9odUyruJO155
 1sbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785327798; x=1785932598;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Ht8zy9C8LzrRQILUNT4SJG3phKjuJLQv5NRcPn0yt08=;
 b=il2jllnVKiA4lVPDfPT4MgNbgZyVj2BHclyDQJ11537Dy6z7UbfKAUN11bggKh73vf
 uCdTABvQtSh9FGmELCf7mIxo9AGQmG7zb9jRsuuEAMh1tYao4auA9ueuWfTliTB6Qbtm
 Oli3OlIjiMX5nFWiVczlgtY/l5L4JXMPAtwthG8kTAGSLvidAGIg66JD8oaMVIZy10Qq
 i+FYO5aXMu9lc4wmal9ONu5v2pCffUXJwwMgi/FU87ZBh0HrF0jfcTCvXwSxIKEFIHSY
 VBQ8mGIg7nItDTMENoYLtnd63GGSTSWsqt4sX6kFiTxbMdMIGCQMrGpRVjOWYNCcSfjD
 chrg==
X-Gm-Message-State: AOJu0YwVJyVfOk+IkfONqxMrXNhI56pjzTY7CIgA5sDKrfpq3yY/sJJI
 MPV7iL3J8ubAW0LEenySlOMjl7ClZdtgUYPKNQRx96WFUSRcB3oX4JW84JBdoVne2O8sJMsJ0gd
 atZbLXOcXVJmvaTbiePF0ANPLn881gMSTYIh7kAN1O3AH/ALJo/8/Qae1GZ2NzPwdcKFa
X-Gm-Gg: AR+sD114CB+4iBOdo8VGaLagJbOpm4YCGdOGI/RQDZL3Ds7U3HmM8pvLqddemeZEqw5
 XV2ZXW92r9/uCbh0N/I0hm7HfhJ3r2cfVUiY93uH5HgXWXpllKZCDr01FJ/mNdDEK/fdYGRhuWg
 p7gZKZuADotFQ8Rb46v9QiDGTa/yWGb219S1jmtDL+bQ0+0DsM7GldkSBI57LbRr4obSg+t+Swe
 kPXts/NPKdEFur9jTbp5V4Qxn30HsuJ/6f439nCtIypmgrgAOw7ndGjW5hBHdozVUd4yKDC2hDk
 8ju6A15wfHwsRSe+QSy749pz+aNdIje86B5DDCHyMdLluiz+b3yovvadhpZxzSFmXOx2yCIc/Z4
 fxhp5Zj/vtOjAWcWqQdBTYXdXcXXcK6Mw8+n9NtiWcRETqunBF4HBAyKJvCod3qtHdibeE7kdqJ
 vuqiazNv3qMCBlwwVDjjqONppO5nRGSRlTdZW9Tkzoj00Cls/2tau3K2of5Zp+3OlN73Qqa1Q19
 YGJNe//9Z7k6z5hV8Tqxba5j7iqEBmbmyWexHd+LFkveg/5abYWeXmN3VOa3Pkasz73ysPy7Vqg
 ILUzcS+KaknFQUdDkP9U8g/9lXHPASC0dfxU/cGu+cGm7P/kXKs=
X-Received: by 2002:a05:600c:3e06:b0:495:5b4a:53b7 with SMTP id
 5b1f17b1804b1-496c65906c8mr72187565e9.19.1785327797768; 
 Wed, 29 Jul 2026 05:23:17 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c44afaecsm170879675e9.2.2026.07.29.05.23.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 05:23:17 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 29 Jul 2026 12:22:54 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 14
X-Gerrit-Change-Id: I375a41749060b7d006647bc27002c55436c8a8bb
X-Gerrit-Change-Number: 1748
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1748?usp=email>
X-Gerrit-Commit: 98a72dc7618f9cf64e37189852a1dc768c91b476
In-Reply-To: <gerrit.1782719911000.I375a41749060b7d006647bc27002c55436c8a8bb@gerrit.openvpn.net>
References: <gerrit.1782719911000.I375a41749060b7d006647bc27002c55436c8a8bb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkzNzVhNDE3NDkwNjBiN2QwMDY2NDdiYzI3MDAyYzU1NDM2YzhhOGJiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <125f554c078a9afb9e42997ee1e050258b25f25d-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wp3Jo-0005LN-2S
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
Content-Type: multipart/mixed; boundary="===============6969258336492862994=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6969258336492862994==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="R46sRr4DW4w="; charset=UTF-8

--R46sRr4DW4w=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1748?usp=3Demail

to look at the new patch set (#14)=2E
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
margin (with its source: client / server-=
advertised / default) at verb 4=2E

Before this the client never measured R=
TT, so every responder sat in the band
and selection was purely weighted-ra=
ndom; with real measurements the
latency-based candidate selection takes ef=
fect=2E

Change-Id: I375a41749060b7d006647bc27002c55436c8a8bb
Signed-off-by=
: Lev Stipakov <lev@openvpn=2Enet>
---
M doc/man-sections/client-options=2E=
rst
M src/openvpn/oob_client=2Ec
2 files changed, 28 insertions(+), 5 delet=
ions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/change=
s/48/1748/14

diff --git a/doc/man-sections/client-options=2Erst b/doc/man-=
sections/client-options=2Erst
index 82e7b22=2E=2E10ca808 100644
--- a/doc/m=
an-sections/client-options=2Erst
+++ b/doc/man-sections/client-options=2Ers=
t
@@ -608,9 +608,13 @@
   remote, and each answering server replies with it=
s advertised priority
   and weight=2E Remotes are then reordered following=
 DNS SRV (RFC 2782)
   semantics: servers that answered are tried before th=
ose that did not,
-  grouped by priority (lowest first); within a priority =
group, servers are
-  picked by weighted-random selection=2E Round-trip tim=
e is not yet taken
-  into account, so ``max-latency-diff`` has no effect f=
or now=2E
+  grouped by priority (lowest first); within a priority group, s=
ervers
+  whose measured round-trip time is within ``max-latency-diff``
+  =
milliseconds of the fastest one are picked by weighted-random
+  selection,=
 the others follow in round-trip-time order=2E When
+  ``max-latency-diff``=
 is not given, the margin advertised by the
+  answering server is used, fa=
lling back to a built-in default of
+  :code:`10` ms=2E
 
   The probe is c=
urrently sent without control-channel wrapping, so it only
   works against=
 a server configured without ``--tls-auth``,
diff --git a/src/openvpn/oob_c=
lient=2Ec b/src/openvpn/oob_client=2Ec
index 4b8c576=2E=2E3de791f 100644
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
@@ -177,7 +178,13 @@
             && addr_port_ma=
tch((const struct openvpn_sockaddr *)(const void *)from,
                  =
              (const struct openvpn_sockaddr *)(const void *)&targets[i]=2E=
dest))
         {
+            struct timeval rcv;
+            openvpn_get=
timeofday(&rcv, NULL);
+            long ms =3D (long)(rcv=2Etv_sec - targe=
ts[i]=2Esent_at=2Etv_sec) * 1000
+                      + (rcv=2Etv_usec - =
targets[i]=2Esent_at=2Etv_usec) / 1000;
+
             results[i]=2Erespond=
ed =3D true;
+            results[i]=2Ertt_ms =3D (ms > 0) ? (unsigned int)=
ms : 0;
             results[i]=2Ereply =3D reply;
             break;
    =
     }
@@ -432,6 +439,7 @@
             }
             else
             {
=
+                openvpn_gettimeofday(&targets[i]=2Esent_at, NULL);
       =
          targets[i]=2Edestlen =3D destlen;
                 targets[i]=2Es=
ent =3D true;
                 sent_count++;
@@ -454,8 +462,19 @@
         =
if (results[i]=2Eresponded)
         {
             responded++;
-         =
   msg(D_LOW, "server-probe: %s:%s answered (priority %d, weight %d)", ce->=
remote,
-                ce->remote_port, results[i]=2Ereply=2Epriority, re=
sults[i]=2Ereply=2Eweight);
+            /* Effective candidate-band margin=
 and where it came from: the
+             * client's own setting wins, els=
e the server's advertised value,
+             * else the built-in default=
=2E */
+            int client_margin =3D c->options=2Eserver_probe_latency=
_margin;
+            int margin =3D oob_effective_margin(&results[i], clie=
nt_margin);
+            const char *margin_src =3D client_margin >=3D 0   =
                   ? "client"
+                                     : resul=
ts[i]=2Ereply=2Emax_latency_diff > 0 ? "server-advertised"
+               =
                                                              : "default";
=
+            msg(D_LOW,
+                "server-probe: %s:%s answered (pri=
ority %d, weight %d, rtt %u ms;"
+                " latency margin %d ms [%=
s])",
+                ce->remote, ce->remote_port, results[i]=2Ereply=2Epr=
iority, results[i]=2Ereply=2Eweight,
+                results[i]=2Ertt_ms, =
margin, margin_src);
         }
         else
         {

-- 
To view, visi=
t http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1748?usp=3Demail
To unsubscribe=
, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
=
Gerrit-Branch: master
Gerrit-Change-Id: I375a41749060b7d006647bc27002c55436=
c8a8bb
Gerrit-Change-Number: 1748
Gerrit-PatchSet: 14
Gerrit-Owner: stipa <=
lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerr=
it-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--R46sRr4DW4w=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #14</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1748?usp=3Demail">View Change</a></p><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">oob: Mea=
sure probe RTT for candidate-band selection<br><br>Record each probe&#39;s =
round-trip time (per-target send timestamp vs reply<br>arrival) and feed it=
 to oob_rank_probe_results(), where RTT forms the<br>candidate band: respon=
ders within the effective margin of the fastest compete<br>on weight, slowe=
r ones fall behind=2E Log the measured RTT and the effective<br>margin (wit=
h its source: client / server-advertised / default) at verb 4=2E<br><br>Bef=
ore this the client never measured RTT, so every responder sat in the band<=
br>and selection was purely weighted-random; with real measurements the<br>=
latency-based candidate selection takes effect=2E<br><br>Change-Id: I375a41=
749060b7d006647bc27002c55436c8a8bb<br>Signed-off-by: Lev Stipakov &lt;lev@o=
penvpn=2Enet&gt;<br>---<br>M doc/man-sections/client-options=2Erst<br>M src=
/openvpn/oob_client=2Ec<br>2 files changed, 28 insertions(+), 5 deletions(-=
)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/op=
envpn refs/changes/48/1748/14</pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/doc/man-sections/client-=
options=2Erst b/doc/man-sections/client-options=2Erst</span><br><span>index=
 82e7b22=2E=2E10ca808 100644</span><br><span>--- a/doc/man-sections/client-=
options=2Erst</span><br><span>+++ b/doc/man-sections/client-options=2Erst</=
span><br><span>@@ -608,9 +608,13 @@</span><br><span>   remote, and each ans=
wering server replies with its advertised priority</span><br><span>   and w=
eight=2E Remotes are then reordered following DNS SRV (RFC 2782)</span><br>=
<span>   semantics: servers that answered are tried before those that did n=
ot,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  grouped by prior=
ity (lowest first); within a priority group, servers are</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-  picked by weighted-random selection=2E=
 Round-trip time is not yet taken</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-  into account, so ``max-latency-diff`` has no effect for now=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  grouped by pri=
ority (lowest first); within a priority group, servers</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  whose measured round-trip time is with=
in ``max-latency-diff``</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  milliseconds of the fastest one are picked by weighted-random</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  selection, the others fol=
low in round-trip-time order=2E When</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  ``max-latency-diff`` is not given, the margin advertised=
 by the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  answering =
server is used, falling back to a built-in default of</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  :code:`10` ms=2E</span><br><span> </spa=
n><br><span>   The probe is currently sent without control-channel wrapping=
, so it only</span><br><span>   works against a server configured without `=
`--tls-auth``,</span><br><span>diff --git a/src/openvpn/oob_client=2Ec b/sr=
c/openvpn/oob_client=2Ec</span><br><span>index 4b8c576=2E=2E3de791f 100644<=
/span><br><span>--- a/src/openvpn/oob_client=2Ec</span><br><span>+++ b/src/=
openvpn/oob_client=2Ec</span><br><span>@@ -56,6 +56,7 @@</span><br><span>  =
   struct sockaddr_storage dest;</span><br><span>     socklen_t destlen;</s=
pan><br><span>     bool sent;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct timeval sent_at; /* when the probe was sent, for RTT m=
easurement */</span><br><span> };</span><br><span> </span><br><span> /* The=
 probe uses one native socket per address family, so every remote is probed=
</span><br><span>@@ -177,7 +178,13 @@</span><br><span>             &amp;&am=
p; addr_port_match((const struct openvpn_sockaddr *)(const void *)from,</sp=
an><br><span>                                (const struct openvpn_sockaddr=
 *)(const void *)&amp;targets[i]=2Edest))</span><br><span>         {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            struct timeval=
 rcv;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            op=
envpn_gettimeofday(&amp;rcv, NULL);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            long ms =3D (long)(rcv=2Etv_sec - targets[i]=2E=
sent_at=2Etv_sec) * 1000</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                      + (rcv=2Etv_usec - targets[i]=2Esent_at=2Etv_use=
c) / 1000;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span>             results[i]=2Eresponded =3D true;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            results[i]=2Ertt_ms =3D (ms &=
gt; 0) ? (unsigned int)ms : 0;</span><br><span>             results[i]=2Ere=
ply =3D reply;</span><br><span>             break;</span><br><span>        =
 }</span><br><span>@@ -432,6 +439,7 @@</span><br><span>             }</span=
><br><span>             else</span><br><span>             {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                openvpn_gettimeofda=
y(&amp;targets[i]=2Esent_at, NULL);</span><br><span>                 target=
s[i]=2Edestlen =3D destlen;</span><br><span>                 targets[i]=2Es=
ent =3D true;</span><br><span>                 sent_count++;</span><br><spa=
n>@@ -454,8 +462,19 @@</span><br><span>         if (results[i]=2Eresponded)=
</span><br><span>         {</span><br><span>             responded++;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(D_LOW, &quo=
t;server-probe: %s:%s answered (priority %d, weight %d)&quot;, ce-&gt;remot=
e,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                ce-=
&gt;remote_port, results[i]=2Ereply=2Epriority, results[i]=2Ereply=2Eweight=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* Ef=
fective candidate-band margin and where it came from: the</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+             * client&#39;s own setti=
ng wins, else the server&#39;s advertised value,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+             * else the built-in default=2E */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            int cli=
ent_margin =3D c-&gt;options=2Eserver_probe_latency_margin;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            int margin =3D oob_effe=
ctive_margin(&amp;results[i], client_margin);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            const char *margin_src =3D client_mar=
gin &gt;=3D 0                      ? &quot;client&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                                     : =
results[i]=2Ereply=2Emax_latency_diff &gt; 0 ? &quot;server-advertised&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
                                                           : &quot;default&=
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
none"> Gerrit-PatchSet: 14 </div>
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
--R46sRr4DW4w=--


--===============6969258336492862994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6969258336492862994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6969258336492862994==--

