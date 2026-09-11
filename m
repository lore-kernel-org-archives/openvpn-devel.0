Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45ADC88E54
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FCpkELQQzkFt8MWaEUoxJmDHqTt0yZbTmR6acx/ewok=; b=Svy6whc0Y9pjJ9BrtwTLQlzH3R
	pxCcoj2lVt79EqTrlMp8Uo1UlYIgBN4rTEdr83/uld6EbED2bkh/4IKDBHMzg97GaXL+Dru5m6Yc7
	WXz5pxE199pDadsb99GM+MO6erb6X8FDSOO6cBCdmmRdz/SUZVp6ueNYGJNdauIOMTJU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4xIG-0006TD-7C;
	Fri, 11 Sep 2026 09:11:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4xIE-0006Sy-Mx
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 09:11:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=mXQMXDzNyG7ptGcIDN1rZcBivEcemETuqniXNN2uRyE=; b=lBmnDoKZZMYf++9/2Ld73FtJPh
 otu0zuBBMXP2uggoNs7BiaegsjNf+ch/HuAjcp/jA9yn5/C6EWKNXi0LW8R+uR197PZRieOKtmxwo
 OW5Qr3bkcaOwAdf6wls5t12n8fiDwwR2rGI65pb43hQWbEyuhgAISkcn+xA/n4VR1LSs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=mXQMXDzNyG7ptGcIDN1rZcBivEcemETuqniXNN2uRyE=; b=U
 1KttauIcW/eOsGNdsqCMmROFXbp7PV3daZR2vBuQbl1B0oP+kDGlO/q4bKEgqLhyrwShYs1h/SGte
 ATOPY6fA+Mj0wTezyi2VwCE2k1NuBIx2ptsYIz9qRo1JUU2jC6eUGYUlXR1GCG/cHRs/UMo1YqM8J
 GyHDO/F7zUTHtYRA=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4xIA-0008Cv-Kv for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 09:11:34 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b94fce6e8so5389545e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 02:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789117884; x=1789722684; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mXQMXDzNyG7ptGcIDN1rZcBivEcemETuqniXNN2uRyE=;
 b=bCaSKDhnPOklXywzQe5YOrvt+lWf3wlsdoKybDelse+FB9tsaMzJh2gTZ7OvBmJu/i
 JSv4S6eI3GTqOdNQ4h2/xEqz2lP+Xj8+yIE62/EyExWvj/6Kg/AEwnERNK9qQlWCo9CF
 NyQAaxX1To6z8DGzLD1r5bueRMTvD627oVo2/W3rfol3dD35dz9fByR4lEXzWBcvaRt0
 IA6R/rY3Y9h1zFR6Vgh/BoxiJJnbUqq1MZz1mD56ogT3BdbjxTnQgKDGRMRPS8lvCXTH
 E1hu8mraZzFgjBqDtKDs1JLaqmtYgdqlDmRU+FvcWOA35okAnkmssknpSY71oWyk+Lsb
 llcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117884; x=1789722684;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=mXQMXDzNyG7ptGcIDN1rZcBivEcemETuqniXNN2uRyE=;
 b=k/Gw0Kc9lga1RayBWHqVD6H3p8BGHb3X0o90Z6Rb4w3rzCpNazSzPfFMrcRfgqXi9r
 5ElmHn2JUcW8bRQkGKms8QqWhXMPpaV6kdmsu5MXyg3eCiActCAgu1o0q2ZSEc+CYJt+
 dRDVrRIMTB/vMKgnRKxor/qBymEPdW2O5gRorp5BuyyYGd7rSWbK0dFIO6gEI7lU0Jg9
 6gAax2kzeZw+55Nj3gLqwIRncBU0+0OD17y1Tt62VvHXzlbQUtOw6VeeypfXHXW6s/a/
 a7BYcxMo413R+1ucLWKz+UNQgEZCsaujxiRpSvuKGTRhyQh+nPGty1mjl+1/M1JNJK/j
 FR5Q==
X-Gm-Message-State: AFuF++m5zJsNynmPnHNYc2JprM9RgCT28qBCuAMGzZ+8BE9bTLhQgfLp
 VbSopMwTobKfYVc5FJzp2c6gDJgN0LE3kkjSzdgiEwI3CnhZbPBQxHRBaVODf1PCKh0AnQEWxrK
 JSWD5DuJucTbgV+/YJKsw75y7k22aFuPy9ZHKw9raofxzfvHtmqvy1KTuOWRME5APT0ga
X-Gm-Gg: AYBFou1OHnuAwNG4LWsxEDhXFCwqTF5557w+tTlaI3D0upbSdVYhVGljpigMsx+uPLN
 xSi4qH0SlqZrp61/Gxxz0NBePINYB62Do8um2XaQM4RsAsC0gYif3hxbl0hrU3BTGPBwC+6kzMp
 RCFhq0hCLDMP5E5pCHPiCaL99aSCdVHsDzq8b8WVeP3nWlmUyswUSpGArCwW5E6TeNESBkfiDaW
 x7ZZp2HZFlXxDa05147smJTeEXzR2NqMH1+YFnn8FcYZ0V1IwBTQP24r7+cPOIkmzhD4+aFlEg4
 tCpxZSjXpsoBQWh836c3MpPtq+pmG+uM44ZFDkGesHmZE8AXnEMBtdAFJJjLMCNLPbYUZw44xqV
 4SFwVQiMozgOpgwaxVzx6XwhJJOzLfUwAyaXylOzqWeIhm4+hYugppB33OGf/pb8ONKaz8uaRo+
 pGNGWMFkCQsVgWx3KqJMxhlZOQWI2XlezsaHEcy4qLdsP3wG2lxlLYXXwUJFMMllsMLFPCQx49P
 rZ7Rta1SWiQL9h1TP2JPlLIwyXQEcGBOWpoRSGswZiukTaO/Whpj4F+kNMtD1mCHefc8JjVYYsK
 Jl9VrbhVdIRbqqjocb+8+AjAUS19EpjtV2esczAwrAwanzmxzPJye+HrhyEX8g==
X-Received: by 2002:a05:600c:c48f:b0:499:bf0e:95c8 with SMTP id
 5b1f17b1804b1-49e619831b6mr40154595e9.1.1789117882817; 
 Fri, 11 Sep 2026 02:11:22 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60ac42b9sm58685605e9.6.2026.09.11.02.11.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:11:22 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 09:11:03 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 15
X-Gerrit-Change-Id: Ib2b6c2246f9d9c0a505292ee8d879f714901ffae
X-Gerrit-Change-Number: 1768
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1768?usp=email>
X-Gerrit-Commit: 67b9effd64e7147c48159a846a03cee9682d758a
In-Reply-To: <gerrit.1783320647000.Ib2b6c2246f9d9c0a505292ee8d879f714901ffae@gerrit.openvpn.net>
References: <gerrit.1783320647000.Ib2b6c2246f9d9c0a505292ee8d879f714901ffae@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzMzIwNjQ3MDAwLkliMmI2YzIyNDZmOWQ5YzBhNTA1MjkyZWU4ZDg3OWY3MTQ5MDFmZmFlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <84cc337d172253e36ce3ee9413b319882bb026c1-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4xIA-0008Cv-Kv
Subject: [Openvpn-devel] [S] Change in openvpn[master]: oob: advertise a
 connect_lifetime in the probe reply
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
Content-Type: multipart/mixed; boundary="===============0809913410532266291=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0809913410532266291==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XPL3l9AiuaE="; charset=UTF-8

--XPL3l9AiuaE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1768?usp=3Demail

to look at the new patch set (#15)=2E
=


Change subject: oob: advertise a connect_lifetime in the probe reply
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: advertise a=
 connect_lifetime in the probe reply

A server answering an out-of-band SER=
VER_PROBE now also advertises a
connect_lifetime in the PROBE_REPLY: how lo=
ng, in seconds, a probing
client may use the reply as the server's HARD_RES=
ET when it starts a
handshake=2E

The value is inferred, not configurable: =
the reply is only usable as
that reset while its stateless SYN-cookie is va=
lid, i=2Ee=2E the guaranteed
cookie window of ~handshake_window (2 quantise=
d buckets; see
check_session_hmac_and_pkt_id), so the server advertises exa=
ctly that=2E A
probe that arrived as P_CONTROL_OOB_WKC_V1 also gets
OOB_PRO=
BE_REPLY_FLAG_RESEND_WKC, telling the client to resend the WKc
when complet=
ing the handshake, since the server keeps no state=2E

Only the wire advert=
isement is added here -- the server puts both values
into the probe_reply i=
t builds for an accepted probe=2E The client side
that acts on them follows=
=2E

Change-Id: Ib2b6c2246f9d9c0a505292ee8d879f714901ffae
Signed-off-by: Le=
v Stipakov <lev@openvpn=2Enet>
---
M src/openvpn/mudp=2Ec
M src/openvpn/oob=
=2Eh
2 files changed, 21 insertions(+), 0 deletions(-)


  git pull ssh://g=
errit=2Eopenvpn=2Enet:29418/openvpn refs/changes/68/1768/15

diff --git a/s=
rc/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 43aa732=2E=2Eb89b439 10064=
4
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -249,12 +249,27 =
@@
             return false;
         }
 
+        /* A tls-crypt-v2 clien=
t must resend the WKc if it later uses this reply
+         * to start a ha=
ndshake, since we keep no state=2E */
+        uint32_t reply_flags =3D
+  =
          (verdict =3D=3D VERDICT_VALID_OOB_WKC_V1) ? OOB_PROBE_REPLY_FLAG_=
RESEND_WKC : 0;
+
+        /* The client's third packet validates only whil=
e its SYN-cookie does, so
+         * the advertised connect_lifetime is in=
ferred (not configurable): the
+         * guaranteed cookie window of ~han=
dshake_window (2 quantised buckets; see
+         * check_session_hmac_and_=
pkt_id)=2E Advertising more would make the client
+         * trust an alre=
ady-expired cookie=2E (RFC: connect_lifetime is how long the
+         * se=
rver considers the reply valid=2E) */
+        int connect_lifetime =3D min=
_int(2 * ((handwindow + 1) / 2), 0xffff);
+
         /* the echo of the pee=
r's session id, plus what we advertise */
         struct oob_probe_reply r=
eply =3D {
             =2Epeer_session_id =3D state->peer_session_id,
    =
         =2Epriority =3D (uint16_t)m->top=2Eoptions=2Eserver_probe_reply_pr=
iority,
             =2Eweight =3D (uint16_t)m->top=2Eoptions=2Eserver_prob=
e_reply_weight,
             =2Emax_latency_diff =3D (uint16_t)m->top=2Eopt=
ions=2Eserver_probe_reply_max_latency_diff,
+            =2Econnect_lifetim=
e =3D (uint16_t)connect_lifetime,
+            =2Eflags =3D reply_flags,
  =
       };
 
         /* Our session id is a stateless SYN cookie (the same =
HMAC the three-way
diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh
i=
ndex 27ae02a=2E=2E9fde094 100644
--- a/src/openvpn/oob=2Eh
+++ b/src/openvp=
n/oob=2Eh
@@ -159,6 +159,12 @@
  */
 bool oob_timestamp_in_window(uint64_t =
probe_ts, uint64_t now, uint64_t window_secs);
 
+/* probe_reply flags (the=
 reply TLV's 32-bit flags field) */
+/* bit 0: the client must resend the w=
rapped client key (via P_CONTROL_WKC_V1)
+ * when it completes the handshak=
e started from this reply=2E Set
+ * by a tls-crypt-v2 server, which is sta=
teless and discarded the WKc=2E */
+#define OOB_PROBE_REPLY_FLAG_RESEND_WKC=
 0x1
+
 /**
  * Decide whether a received SERVER_PROBE is answered=2E Combi=
nes
  * oob_server_probe_read() and oob_timestamp_in_window(): the probe is=
 dropped

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1768=
?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchs=
et
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib2b6c22=
46f9d9c0a505292ee8d879f714901ffae
Gerrit-Change-Number: 1768
Gerrit-PatchSe=
t: 15
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaistho=
s <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@list=
s=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2E=
org>

--XPL3l9AiuaE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #15</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1768?usp=3Demail">View Change</a></p><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">oob: adv=
ertise a connect_lifetime in the probe reply<br><br>A server answering an o=
ut-of-band SERVER_PROBE now also advertises a<br>connect_lifetime in the PR=
OBE_REPLY: how long, in seconds, a probing<br>client may use the reply as t=
he server&#39;s HARD_RESET when it starts a<br>handshake=2E<br><br>The valu=
e is inferred, not configurable: the reply is only usable as<br>that reset =
while its stateless SYN-cookie is valid, i=2Ee=2E the guaranteed<br>cookie =
window of ~handshake_window (2 quantised buckets; see<br>check_session_hmac=
_and_pkt_id), so the server advertises exactly that=2E A<br>probe that arri=
ved as P_CONTROL_OOB_WKC_V1 also gets<br>OOB_PROBE_REPLY_FLAG_RESEND_WKC, t=
elling the client to resend the WKc<br>when completing the handshake, since=
 the server keeps no state=2E<br><br>Only the wire advertisement is added h=
ere -- the server puts both values<br>into the probe_reply it builds for an=
 accepted probe=2E The client side<br>that acts on them follows=2E<br><br>C=
hange-Id: Ib2b6c2246f9d9c0a505292ee8d879f714901ffae<br>Signed-off-by: Lev S=
tipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M src/openvpn/mudp=2Ec<br>M src=
/openvpn/oob=2Eh<br>2 files changed, 21 insertions(+), 0 deletions(-)<br><b=
r></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn r=
efs/changes/68/1768/15</pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/src/openvpn/mudp=2Ec b/src/open=
vpn/mudp=2Ec</span><br><span>index 43aa732=2E=2Eb89b439 100644</span><br><s=
pan>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</=
span><br><span>@@ -249,12 +249,27 @@</span><br><span>             return fa=
lse;</span><br><span>         }</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        /* A tls-crypt-v2 client must resend =
the WKc if it later uses this reply</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+         * to start a handshake, since we keep no state=2E =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uint32_t =
reply_flags =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        (verdict =3D=3D VERDICT_VALID_OOB_WKC_V1) ? OOB_PROBE_REPLY_FLAG_RE=
SEND_WKC : 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* The client&#39=
;s third packet validates only while its SYN-cookie does, so</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+         * the advertised connect_=
lifetime is inferred (not configurable): the</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+         * guaranteed cookie window of ~handshake_=
window (2 quantised buckets; see</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+         * check_session_hmac_and_pkt_id)=2E Advertising more =
would make the client</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+         * trust an already-expired cookie=2E (RFC: connect_lifetime is h=
ow long the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
 * server considers the reply valid=2E) */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        int connect_lifetime =3D min_int(2 * ((handw=
indow + 1) / 2), 0xffff);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span>         /* the echo of the peer&#39;s session id, p=
lus what we advertise */</span><br><span>         struct oob_probe_reply re=
ply =3D {</span><br><span>             =2Epeer_session_id =3D state-&gt;pee=
r_session_id,</span><br><span>             =2Epriority =3D (uint16_t)m-&gt;=
top=2Eoptions=2Eserver_probe_reply_priority,</span><br><span>             =
=2Eweight =3D (uint16_t)m-&gt;top=2Eoptions=2Eserver_probe_reply_weight,</s=
pan><br><span>             =2Emax_latency_diff =3D (uint16_t)m-&gt;top=2Eop=
tions=2Eserver_probe_reply_max_latency_diff,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            =2Econnect_lifetime =3D (uint16_t)conn=
ect_lifetime,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      =2Eflags =3D reply_flags,</span><br><span>         };</span><br><span=
> </span><br><span>         /* Our session id is a stateless SYN cookie (th=
e same HMAC the three-way</span><br><span>diff --git a/src/openvpn/oob=2Eh =
b/src/openvpn/oob=2Eh</span><br><span>index 27ae02a=2E=2E9fde094 100644</sp=
an><br><span>--- a/src/openvpn/oob=2Eh</span><br><span>+++ b/src/openvpn/oo=
b=2Eh</span><br><span>@@ -159,6 +159,12 @@</span><br><span>  */</span><br><=
span> bool oob_timestamp_in_window(uint64_t probe_ts, uint64_t now, uint64_=
t window_secs);</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+/* probe_reply flags (the reply TLV&#39;s 32-bit flags field)=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* bit 0: the cl=
ient must resend the wrapped client key (via P_CONTROL_WKC_V1)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * when it completes the handsha=
ke started from this reply=2E Set</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * by a tls-crypt-v2 server, which is stateless and discarded=
 the WKc=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defi=
ne OOB_PROBE_REPLY_FLAG_RESEND_WKC 0x1</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span> /**</span><br><span>  * Decide whether=
 a received SERVER_PROBE is answered=2E Combines</span><br><span>  * oob_se=
rver_probe_read() and oob_timestamp_in_window(): the probe is dropped</span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1768?usp=3Demail">change 1768</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D=
"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemt=
ype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1768?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib2b6c2246f9d9c0a505292=
ee8d879f714901ffae </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 1768 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 15 </div>
<div =
style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>

</body></html>
--XPL3l9AiuaE=--


--===============0809913410532266291==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0809913410532266291==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0809913410532266291==--

