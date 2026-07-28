Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 137AAC54F56
	for <openvpn-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=umDnDevC1hOwd+5m3UUa2UpJqSRwq3ZXPFrpdJ/jp6o=; b=U1nWWN2ygBgC6nk59B29sL0z5k
	qBj2krLH5D7GC5jc3mSlzGmOQs6N+iMB9RYgpPq6MWw0sFZbSX59fMXaO1yV5UzlXhi7TtW0vHBu8
	Ylj2qYnkJLB79Ns0KStt9ZP5J24cvcgbSHnPjySghHx1FksEcOdRbugrtN03218qtDMw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wojLg-0001kH-Mt;
	Tue, 28 Jul 2026 15:04:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wojLe-0001k3-T6
 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 15:04:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=vXGMoLy5m4vJS6ABa0sZhE7Q3eckpTgVoxFm8oizYjg=; b=KwMyYOt+RpR/QsszH1ujBUDNbA
 i75vPW8uZOF+5d9LYALYaXrIQ74JnqohhpSRWZlTrWn36II8Ol0sptjxziBUd399tzY2TkqDSZN7M
 j5DFMQKIjZAH7CzUN7niW7sXIEc3Swx/f7bHIkYcvX8oy8m/p7Es81sbV7GTWUbYsXaU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=vXGMoLy5m4vJS6ABa0sZhE7Q3eckpTgVoxFm8oizYjg=; b=m
 LBxzi6sieAsMKQ3Gn7Bf3MjIsZKo9VCOnPMq3I+OPll6/Bjex/SBWVWZGMsIPSRmP5Vc9FOfH0H6m
 LUv2nDAFV9yd7ZySGFdzgN3tCoukrGh+SoIYdyYLGg60cWnjra3tJjTrigjseA5AKOF7BzNhkKQQk
 MsDERYCrZCh3oOAw=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wojLh-0000R5-Ev for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 15:04:03 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-493f6de72faso8349855e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 28 Jul 2026 08:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785251035; x=1785855835; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vXGMoLy5m4vJS6ABa0sZhE7Q3eckpTgVoxFm8oizYjg=;
 b=Uekk1ir06Q5D5eJEGBaUaVelDekh8UgGKcmSMzwDCCsJ2Q8V+JNAAEm5Hj9530gUeB
 D5NlHKDRbybR1W7xwcAn6G8nyVwv86Bxeeu/Jkp4Nm3XXaJLCqx3690HEjPKmso5qSma
 h3M6aAYTH8CUybw1nQrMsM45OxwX6/aE4urqHD7Guf6v2Bq/tBLfXhq8eHJqZMtgyIDU
 BuaGeAKHdLVrgp/D/5Gh4FobciqdA0KYFlbuVryf0OAnA36sXaiHo5BU+Gyy+cS6m8xa
 37O9S43qUqmI5Akp/NCj07NKnfm+jnG8J4RZsDCu5pGVT1HmfDVQWAGwkZF3ImEhbI6K
 +2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785251035; x=1785855835;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vXGMoLy5m4vJS6ABa0sZhE7Q3eckpTgVoxFm8oizYjg=;
 b=ZQN3ChGnjdbMwXV/dHlzIGWlpISspoPiX1gpdbtLHgtuX95ygMPPIY+u4+gRL7gi00
 cbXnJxRi96nfrCjFgoGktsd86BiEql90H8goL2RLnFV3POKHYyXcZ4z6TKomxvJshSmq
 MiucqkFgitzMiW1D0MJ5RGT1xV80tTZ4ElLBrNIDfr4B9qoVBKrXfgnY9MMAcX5FYjdF
 0TWzfweMD1BpQl4foFzHf+Tq2CqtpxVTO+cY08x2/VOrOGSWXfaOr2qBiWJyn0oITEwK
 sbTPjoY2Y94usxjmhQgUtOr/nhy/Zvo7IAjcs3RnyTCkJYprCCvREe/YO1NtVJJoH6Tp
 Y/eg==
X-Gm-Message-State: AOJu0YytV4qsDVJa0uu16jtaFoVbERLbhn+aTPgUGK29PYMxOh181TtM
 54DLtoTaW68YpicpHjN78MovuFcg3pL1H0Z+I9pdKyQqOwrXpUU1hj2K9LLtETJSG2OaJdG6jE2
 sDB8aGBnqfBYUvQBfixun0Gbj2RImkT7M/R7r9Td8QzpdVBnrpCKGJZ1z8dBUqeo0+CzB
X-Gm-Gg: AR+sD106cVbe9/2f8WTHPveviPyC3fdT6GriKPannd8/UxDLP8GnOU8XHNTQ+C0tjli
 vo+tBZOp/Pn3lb/JICkGEcMhsTAbAuAYFJe0vhOasbN6rB0LfOB4+4NBNArprEcV0szrKujwN5o
 t73ppxlzupAYBF3mq7nH8cPt7ejIp+AhXyesm8jr1sH7xlmFTuOdlAiaJrQ7Pxt0uD4WddHAI14
 UBZcDDEkQF3vOrG5bIKFy2VFGjsKq8JocfOyimeIMR0ZVuDEQDmcO8MUdyDnm4qs1ZUoHIiF5gD
 +NTNmpErnCL/TSbRh5RGkNF/5bltS61JWCOtoEUYUz3AxzbL2+C0NR/CCR/6sTi0dmKP4TTFUNu
 HHhK7FK38TVHzjzi9hZSgwWMO+xkutfAhPwaDGW3NscxcZpSB8pCFBG2ZRjHVXiYQ4GjWGlX8sO
 Tf+6MC0KYWHp/KDLpcdJ7rhYzUoOyfqUqmEXfdJwepZyWnSa6CB5/nKeNq9/VGQBK6OtWnu297r
 OiZfobeI1X/dqWW4e3BHu7f+bgZ00UTABC8+8n63bijrQf4J4OLEc105fR2uTrunn3pC4OoxzVp
 4Wo=
X-Received: by 2002:a05:600c:5d1:b0:495:499e:ec37 with SMTP id
 5b1f17b1804b1-496c657cd58mr22632375e9.18.1785251035063; 
 Tue, 28 Jul 2026 08:03:55 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c532d4sm58022972f8f.22.2026.07.28.08.03.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 08:03:54 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 28 Jul 2026 15:03:23 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 13
X-Gerrit-Change-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8
X-Gerrit-Change-Number: 1752
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1752?usp=email>
X-Gerrit-Commit: f515e228b1a9bfa53245864b80730ea114490183
In-Reply-To: <gerrit.1782719911000.Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8@gerrit.openvpn.net>
References: <gerrit.1782719911000.Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklkNzRjZmFlN2U5ZDY5MDI5ZDJkZGJmNjM1ZWU4NWEyYTZjZWRjM2Q4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9e8ebb5a2e504606087e5a944c8b72bb24e9da08-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wojLh-0000R5-Ev
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Add
 --server-probe-reply to advertise probe reply values
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
Content-Type: multipart/mixed; boundary="===============6325851750954288607=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6325851750954288607==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IVLMtIeiaXY="; charset=UTF-8

--IVLMtIeiaXY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1752?usp=3Demail

to look at the new patch set (#13)=2E
=


Change subject: oob: Add --server-probe-reply to advertise probe reply va=
lues
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Ad=
d --server-probe-reply to advertise probe reply values

Add a server option=
, --server-probe-reply [max-latency-diff] [weight] [prio],
each argument op=
tional, setting the values the server returns in its OOB
PROBE_REPLY=2E An =
unconfigured server advertises weight 50 and priority 100=2E
max-latency-di=
ff is how much slower than the fastest server a server may be
and still cou=
nt as equally good; 0 means the client decides=2E All three are
range-check=
ed to 0=2E=2E65535=2E

The values are plumbed through oob_build_probe_reply=
() into the probe_reply
TLV; the client already reads and ranks remotes by =
them=2E

Change-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8
Signed-off-by=
: Lev Stipakov <lev@openvpn=2Enet>
---
M Changes=2Erst
M doc/man-sections/s=
erver-options=2Erst
M src/openvpn/mudp=2Ec
M src/openvpn/options=2Ec
M src/=
openvpn/options=2Eh
M tests/unit_tests/openvpn/test_oob=2Ec
6 files changed=
, 81 insertions(+), 9 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Ene=
t:29418/openvpn refs/changes/52/1752/13

diff --git a/Changes=2Erst b/Chang=
es=2Erst
index 1f992b2=2E=2E080d928 100644
--- a/Changes=2Erst
+++ b/Change=
s=2Erst
@@ -1,5 +1,13 @@
 Overview of changes in 2=2E8
 =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+New features
=
+------------
+Out-of-band server probing and server-controlled selection
+=
    With ``--server-probe``, a client probes all configured UDP remotes
+  =
  before connecting and reorders them based on the replies: reachable
+    =
servers are tried first, ordered by server-advertised priority,
+    measur=
ed latency and advertised weight with DNS-SRV-like semantics=2E
+    Server=
s advertise these values with ``--server-probe-reply``=2E
 
 
 Overview of =
changes in 2=2E7
diff --git a/doc/man-sections/server-options=2Erst b/doc/m=
an-sections/server-options=2Erst
index f420588=2E=2E1277cf7 100644
--- a/do=
c/man-sections/server-options=2Erst
+++ b/doc/man-sections/server-options=
=2Erst
@@ -662,6 +662,31 @@
   Pushing of the ``--tun-ipv6`` directive is d=
one for older clients which
   require an explicit ``--tun-ipv6`` in their =
configuration=2E
 
+--server-probe-reply args
+  Set the values a server ad=
vertises in its replies to out-of-band
+  probes from clients using ``--ser=
ver-probe``=2E
+
+  Valid syntaxes::
+
+     server-probe-reply max-latency=
-diff
+     server-probe-reply max-latency-diff weight
+     server-probe-r=
eply max-latency-diff weight priority
+
+  ``max-latency-diff`` is the cand=
idate-band margin in milliseconds: a
+  probing client treats servers of th=
e same priority whose round-trip
+  time is within this margin of the faste=
st one as equally good=2E
+  :code:`0` (the default) lets the client use it=
s own margin=2E
+
+  ``weight`` (default :code:`50`) and ``priority`` (defa=
ult :code:`100`)
+  have DNS SRV (RFC 2782) semantics: clients try servers =
with a lower
+  priority value first, and distribute load between equally-g=
ood
+  servers of the same priority proportionally to their weights=2E
+
+ =
 All values are in the range :code:`0` to :code:`65535`=2E A UDP server
+  =
answers probes regardless of this option; replies are stateless,
+  replay-=
protected and rate-limited=2E The option only controls the
+  advertised va=
lues=2E
+
 --stale-routes-check args
   Remove routes which haven't had act=
ivity for ``n`` seconds (i=2Ee=2E the ageing
   time)=2E  This check is run=
 every ``t`` seconds (i=2Ee=2E check interval)=2E
diff --git a/src/openvpn/=
mudp=2Ec b/src/openvpn/mudp=2Ec
index 2209407=2E=2E3e50994 100644
--- a/src=
/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -238,7 +238,12 @@
         =
/* Out-of-band server probe=2E state->newbuf points at the TLV payload
    =
      * (read_control_auth has stripped the opcode, session id and any
    =
      * tls-auth/tls-crypt wrapping)=2E Answer it without creating a sessio=
n=2E */
-        struct oob_probe_reply reply;
+        /* what we advertis=
e; oob_build_probe_reply() adds the peer's session id */
+        struct oo=
b_probe_reply reply =3D {
+            =2Epriority =3D (uint16_t)m->top=2Eo=
ptions=2Eserver_probe_reply_priority,
+            =2Eweight =3D (uint16_t)=
m->top=2Eoptions=2Eserver_probe_reply_weight,
+            =2Emax_latency_d=
iff =3D (uint16_t)m->top=2Eoptions=2Eserver_probe_reply_max_latency_diff,
+=
        };
         if (!oob_build_probe_reply(&state->newbuf, (uint64_t)no=
w, (uint64_t)handwindow,
                                    &state->peer_s=
ession_id, &reply))
         {
diff --git a/src/openvpn/options=2Ec b/src/o=
penvpn/options=2Ec
index dc88a55=2E=2E6edb78b 100644
--- a/src/openvpn/opti=
ons=2Ec
+++ b/src/openvpn/options=2Ec
@@ -805,10 +805,14 @@
     o->ce=2Epr=
oto =3D PROTO_UDP;
     o->ce=2Eaf =3D AF_UNSPEC;
 
-    /* The client late=
ncy margin is -1 =3D "not set": the client's value is
-     * authoritative=
 when given, otherwise each server's advertised margin (or
-     * the buil=
t-in default) applies=2E */
+    /* server-probe defaults=2E The client lat=
ency margin is -1 =3D "not set": the
+     * client's value is authoritativ=
e when given, otherwise each server's
+     * advertised margin (or the bui=
lt-in default) applies=2E An (unconfigured)
+     * server advertises weigh=
t 50 / priority 100 and no margin (0)=2E */
     o->server_probe_latency_ma=
rgin =3D -1;
+    o->server_probe_reply_weight =3D 50;
+    o->server_probe=
_reply_priority =3D 100;
+    o->server_probe_reply_max_latency_diff =3D 0;=

     o->ce=2Ebind_ipv6_only =3D false;
     o->ce=2Econnect_retry_seconds =
=3D 1;
     o->ce=2Econnect_retry_seconds_max =3D 300;
@@ -6527,6 +6531,26 =
@@
             options->server_probe_latency_margin =3D margin;
         }=

     }
+    else if (streq(p[0], "server-probe-reply") && !p[4])
+    {
+ =
       VERIFY_PERMISSION(OPT_P_GENERAL);
+        /* --server-probe-reply [=
max-latency-diff] [weight] [prio]; each optional */
+        int vals[3] =
=3D { options->server_probe_reply_max_latency_diff,
+                      =
  options->server_probe_reply_weight,
+                        options->ser=
ver_probe_reply_priority };
+        for (int i =3D 0; i < 3 && p[i + 1]; i=
++)
+        {
+            vals[i] =3D positive_atoi(p[i + 1], msglevel);
=
+            if (vals[i] > 0xffff)
+            {
+                msg(msgl=
evel, "--server-probe-reply: values must be 0 to 65535");
+                =
goto err;
+            }
+        }
+        options->server_probe_reply_ma=
x_latency_diff =3D vals[0];
+        options->server_probe_reply_weight =3D=
 vals[1];
+        options->server_probe_reply_priority =3D vals[2];
+    }=

     else if (streq(p[0], "nice") && p[1] && !p[2])
     {
         VERIFY=
_PERMISSION(OPT_P_NICE);
diff --git a/src/openvpn/options=2Eh b/src/openvpn=
/options=2Eh
index 6b1120a=2E=2E6e4829d 100644
--- a/src/openvpn/options=2E=
h
+++ b/src/openvpn/options=2Eh
@@ -339,6 +339,12 @@
     /* client: defaul=
t candidate-band margin in ms (--server-probe [max-latency-diff]):
      * =
servers within this RTT of the fastest are treated as equally fast */
     =
int server_probe_latency_margin;
+    /* server: values advertised in the O=
OB PROBE_REPLY (--server-probe-reply)=2E
+     * priority/weight follow DNS=
-SRV semantics; max_latency_diff overrides the
+     * client's margin for =
this server (0 =3D defer to the client)=2E */
+    int server_probe_reply_p=
riority;
+    int server_probe_reply_weight;
+    int server_probe_reply_ma=
x_latency_diff;
 
     bool mlock;
 
diff --git a/tests/unit_tests/openvpn/=
test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec
index 004ad8f=2E=2Ec89=
10b8 100644
--- a/tests/unit_tests/openvpn/test_oob=2Ec
+++ b/tests/unit_te=
sts/openvpn/test_oob=2Ec
@@ -372,7 +372,7 @@
 }
 
 /* A valid, in-window SE=
RVER_PROBE yields a reply that echoes the peer's
- * session id and zeroes =
the remaining fields=2E */
+ * session id and carries the configured priori=
ty and weight=2E */
 static void
 test_build_probe_reply_valid(void **state=
)
 {
@@ -386,14 +386,18 @@
     struct session_id peer;
     memcpy(peer=2E=
id, "PEER1234", SID_SIZE);
 
-    /* left as the caller set them: the funct=
ion only fills the session id */
-    struct oob_probe_reply reply =3D { 0 =
};
+    struct oob_probe_reply reply =3D {
+        =2Epriority =3D 5,
+   =
     =2Eweight =3D 50,
+        =2Emax_latency_diff =3D 25,
+    };
     as=
sert_true(oob_build_probe_reply(&buf, now, 30, &peer, &reply));
     assert=
_memory_equal(reply=2Epeer_session_id=2Eid, peer=2Eid, SID_SIZE);
-    asse=
rt_int_equal(reply=2Epriority, 0);
-    assert_int_equal(reply=2Eweight, 0)=
;
+    assert_int_equal(reply=2Epriority, 5);
+    assert_int_equal(reply=
=2Eweight, 50);
     assert_int_equal(reply=2Econnect_lifetime, 0);
     as=
sert_int_equal(reply=2Eflags, 0);
+    assert_int_equal(reply=2Emax_latency=
_diff, 25);
 
     gc_free(&gc);
 }

-- 
To view, visit http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1752?usp=3Demail
To unsubscribe, or for help writing=
 mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ge=
rrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master=

Gerrit-Change-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8
Gerrit-Change-=
Number: 1752
Gerrit-PatchSet: 13
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom=
>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisth=
os <arne-openvpn@rfc2549=2Eorg>

--IVLMtIeiaXY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #13</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1752?usp=3Demail">View Change</a></p><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">oob: Add=
 --server-probe-reply to advertise probe reply values<br><br>Add a server o=
ption, --server-probe-reply [max-latency-diff] [weight] [prio],<br>each arg=
ument optional, setting the values the server returns in its OOB<br>PROBE_R=
EPLY=2E An unconfigured server advertises weight 50 and priority 100=2E<br>=
max-latency-diff is how much slower than the fastest server a server may be=
<br>and still count as equally good; 0 means the client decides=2E All thre=
e are<br>range-checked to 0=2E=2E65535=2E<br><br>The values are plumbed thr=
ough oob_build_probe_reply() into the probe_reply<br>TLV; the client alread=
y reads and ranks remotes by them=2E<br><br>Change-Id: Id74cfae7e9d69029d2d=
dbf635ee85a2a6cedc3d8<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&=
gt;<br>---<br>M Changes=2Erst<br>M doc/man-sections/server-options=2Erst<br=
>M src/openvpn/mudp=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/optio=
ns=2Eh<br>M tests/unit_tests/openvpn/test_oob=2Ec<br>6 files changed, 81 in=
sertions(+), 9 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t=2Eopenvpn=2Enet:29418/openvpn refs/changes/52/1752/13</pre><pre style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git =
a/Changes=2Erst b/Changes=2Erst</span><br><span>index 1f992b2=2E=2E080d928 =
100644</span><br><span>--- a/Changes=2Erst</span><br><span>+++ b/Changes=2E=
rst</span><br><span>@@ -1,5 +1,13 @@</span><br><span> Overview of changes i=
n 2=2E8</span><br><span> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+New features</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+------------</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Out=
-of-band server probing and server-controlled selection</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    With ``--server-probe``, a client p=
robes all configured UDP remotes</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    before connecting and reorders them based on the replies: =
reachable</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    server=
s are tried first, ordered by server-advertised priority,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    measured latency and advertised w=
eight with DNS-SRV-like semantics=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    Servers advertise these values with ``--server-probe-r=
eply``=2E</span><br><span> </span><br><span> </span><br><span> Overview of =
changes in 2=2E7</span><br><span>diff --git a/doc/man-sections/server-optio=
ns=2Erst b/doc/man-sections/server-options=2Erst</span><br><span>index f420=
588=2E=2E1277cf7 100644</span><br><span>--- a/doc/man-sections/server-optio=
ns=2Erst</span><br><span>+++ b/doc/man-sections/server-options=2Erst</span>=
<br><span>@@ -662,6 +662,31 @@</span><br><span>   Pushing of the ``--tun-ip=
v6`` directive is done for older clients which</span><br><span>   require a=
n explicit ``--tun-ipv6`` in their configuration=2E</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+--server-probe-reply args=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Set the values a =
server advertises in its replies to out-of-band</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  probes from clients using ``--server-probe``=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  Valid syntaxes::</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     server-probe-reply max-latency-diff</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     server-probe-reply max-latenc=
y-diff weight</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     s=
erver-probe-reply max-latency-diff weight priority</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  ``max-latency-diff`` is the candidate-band margin in millisec=
onds: a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  probing cl=
ient treats servers of the same priority whose round-trip</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  time is within this margin of the f=
astest one as equally good=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  :code:`0` (the default) lets the client use its own margin=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  ``weight`` (default :code:`50`) and ``=
priority`` (default :code:`100`)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  have DNS SRV (RFC 2782) semantics: clients try servers with =
a lower</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  priority v=
alue first, and distribute load between equally-good</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  servers of the same priority proportion=
ally to their weights=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  All values a=
re in the range :code:`0` to :code:`65535`=2E A UDP server</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  answers probes regardless of this =
option; replies are stateless,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  replay-protected and rate-limited=2E The option only controls =
the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  advertised val=
ues=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan> --stale-routes-check args</span><br><span>   Remove routes which haven=
&#39;t had activity for ``n`` seconds (i=2Ee=2E the ageing</span><br><span>=
   time)=2E  This check is run every ``t`` seconds (i=2Ee=2E check interval=
)=2E</span><br><span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=
=2Ec</span><br><span>index 2209407=2E=2E3e50994 100644</span><br><span>--- =
a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br=
><span>@@ -238,7 +238,12 @@</span><br><span>         /* Out-of-band server =
probe=2E state-&gt;newbuf points at the TLV payload</span><br><span>       =
   * (read_control_auth has stripped the opcode, session id and any</span><=
br><span>          * tls-auth/tls-crypt wrapping)=2E Answer it without crea=
ting a session=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       struct oob_probe_reply reply;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        /* what we advertise; oob_build_probe_reply() adds=
 the peer&#39;s session id */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        struct oob_probe_reply reply =3D {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            =2Epriority =3D (uint16_t)m-&=
gt;top=2Eoptions=2Eserver_probe_reply_priority,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            =2Eweight =3D (uint16_t)m-&gt;top=
=2Eoptions=2Eserver_probe_reply_weight,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            =2Emax_latency_diff =3D (uint16_t)m-&gt;top=
=2Eoptions=2Eserver_probe_reply_max_latency_diff,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        };</span><br><span>         if (!oob_=
build_probe_reply(&amp;state-&gt;newbuf, (uint64_t)now, (uint64_t)handwindo=
w,</span><br><span>                                    &amp;state-&gt;peer_=
session_id, &amp;reply))</span><br><span>         {</span><br><span>diff --=
git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>ind=
ex dc88a55=2E=2E6edb78b 100644</span><br><span>--- a/src/openvpn/options=2E=
c</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -805,10 =
+805,14 @@</span><br><span>     o-&gt;ce=2Eproto =3D PROTO_UDP;</span><br><=
span>     o-&gt;ce=2Eaf =3D AF_UNSPEC;</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    /* The client latency margin is -1 =
=3D &quot;not set&quot;: the client&#39;s value is</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-     * authoritative when given, otherwise eac=
h server&#39;s advertised margin (or</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-     * the built-in default) applies=2E */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* server-probe defaults=2E The c=
lient latency margin is -1 =3D &quot;not set&quot;: the</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     * client&#39;s value is authoritat=
ive when given, otherwise each server&#39;s</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * advertised margin (or the built-in default) =
applies=2E An (unconfigured)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     * server advertises weight 50 / priority 100 and no margin (0=
)=2E */</span><br><span>     o-&gt;server_probe_latency_margin =3D -1;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;server_probe_r=
eply_weight =3D 50;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    o-&gt;server_probe_reply_priority =3D 100;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    o-&gt;server_probe_reply_max_latency_diff =
=3D 0;</span><br><span>     o-&gt;ce=2Ebind_ipv6_only =3D false;</span><br>=
<span>     o-&gt;ce=2Econnect_retry_seconds =3D 1;</span><br><span>     o-&=
gt;ce=2Econnect_retry_seconds_max =3D 300;</span><br><span>@@ -6527,6 +6531=
,26 @@</span><br><span>             options-&gt;server_probe_latency_margin=
 =3D margin;</span><br><span>         }</span><br><span>     }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;s=
erver-probe-reply&quot;) &amp;&amp; !p[4])</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        /* --server-probe-reply [max-latency=
-diff] [weight] [prio]; each optional */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        int vals[3] =3D { options-&gt;server_probe_rep=
ly_max_latency_diff,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                        options-&gt;server_probe_reply_weight,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                        options=
-&gt;server_probe_reply_priority };</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        for (int i =3D 0; i &lt; 3 &amp;&amp; p[i + 1]; i++=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            vals[i] =3D posi=
tive_atoi(p[i + 1], msglevel);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            if (vals[i] &gt; 0xffff)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                msg(msglevel, &quot;--server-probe-re=
ply: values must be 0 to 65535&quot;);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                goto err;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        options-&gt;server_probe_reply_max_latency_diff =3D vals[0=
];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&=
gt;server_probe_reply_weight =3D vals[1];</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        options-&gt;server_probe_reply_priority =3D v=
als[2];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span>     else if (streq(p[0], &quot;nice&quot;) &amp;&amp; p[1] &amp;=
&amp; !p[2])</span><br><span>     {</span><br><span>         VERIFY_PERMISS=
ION(OPT_P_NICE);</span><br><span>diff --git a/src/openvpn/options=2Eh b/src=
/openvpn/options=2Eh</span><br><span>index 6b1120a=2E=2E6e4829d 100644</spa=
n><br><span>--- a/src/openvpn/options=2Eh</span><br><span>+++ b/src/openvpn=
/options=2Eh</span><br><span>@@ -339,6 +339,12 @@</span><br><span>     /* c=
lient: default candidate-band margin in ms (--server-probe [max-latency-dif=
f]):</span><br><span>      * servers within this RTT of the fastest are tre=
ated as equally fast */</span><br><span>     int server_probe_latency_margi=
n;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* server: va=
lues advertised in the OOB PROBE_REPLY (--server-probe-reply)=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     * priority/weight follow =
DNS-SRV semantics; max_latency_diff overrides the</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     * client&#39;s margin for this server (0=
 =3D defer to the client)=2E */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    int server_probe_reply_priority;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    int server_probe_reply_weight;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    int server_probe_reply_max_=
latency_diff;</span><br><span> </span><br><span>     bool mlock;</span><br>=
<span> </span><br><span>diff --git a/tests/unit_tests/openvpn/test_oob=2Ec =
b/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>index 004ad8f=2E=2E=
c8910b8 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_oob=2Ec<=
/span><br><span>+++ b/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span=
>@@ -372,7 +372,7 @@</span><br><span> }</span><br><span> </span><br><span> =
/* A valid, in-window SERVER_PROBE yields a reply that echoes the peer&#39;=
s</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * session id and ze=
roes the remaining fields=2E */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * session id and carries the configured priority and weight=2E=
 */</span><br><span> static void</span><br><span> test_build_probe_reply_va=
lid(void **state)</span><br><span> {</span><br><span>@@ -386,14 +386,18 @@<=
/span><br><span>     struct session_id peer;</span><br><span>     memcpy(pe=
er=2Eid, &quot;PEER1234&quot;, SID_SIZE);</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    /* left as the caller set them: t=
he function only fills the session id */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    struct oob_probe_reply reply =3D { 0 };</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_reply reply=
 =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Epr=
iority =3D 5,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  =2Eweight =3D 50,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        =2Emax_latency_diff =3D 25,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    };</span><br><span>     assert_true(oob_build_probe_rep=
ly(&amp;buf, now, 30, &amp;peer, &amp;reply));</span><br><span>     assert_=
memory_equal(reply=2Epeer_session_id=2Eid, peer=2Eid, SID_SIZE);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(reply=2Epri=
ority, 0);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_=
int_equal(reply=2Eweight, 0);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_int_equal(reply=2Epriority, 5);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(reply=2Eweight, 50);=
</span><br><span>     assert_int_equal(reply=2Econnect_lifetime, 0);</span>=
<br><span>     assert_int_equal(reply=2Eflags, 0);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_int_equal(reply=2Emax_latency_dif=
f, 25);</span><br><span> </span><br><span>     gc_free(&amp;gc);</span><br>=
<span> }</span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752?usp=3Demail">change 1752</a>=2E =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"dis=
play:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id74cfae7=
e9d69029d2ddbf635ee85a2a6cedc3d8 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1752 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1=
3 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gma=
il=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos=
 &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div=
>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>

</body></html>
--IVLMtIeiaXY=--


--===============6325851750954288607==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6325851750954288607==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6325851750954288607==--

