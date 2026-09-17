Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD4F3C88E72
	for <openvpn-devel@archiver.kernel.org>; Thu, 17 Sep 2026 12:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dueJ+0D4EP5kgDynl153e3NkIWv2cTya1aKEGI4vn28=; b=G7jV2mzLx70qT4GCNTeUxikPBj
	BOUacthWCbpvOaSFNmjp4+O1pjonHJKmjwZZgs7LCv8MhT5MNnITxOZNp3LCs/RYW/dzfxd3UEega
	JglPfsop+pN2s/EwhSJ09hdLaWF68AB/doZQZUB7pYZjeUP3P5g3qfRyH0p5qT945d9Y=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x7BE9-0007Xy-My;
	Thu, 17 Sep 2026 12:28:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x7BE8-0007Xr-N6
 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 12:28:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=dOLALz1vVkGQQvke7gVN11UmPxK4RpUrwS8s0jibGVg=; b=ewdNTOs66/GGxe+lkkcpeI9cWF
 7wQ9YCqOv3KGxytiFz4pTigWH5namUp6Nt4iuCxpPTGmQqojEcrVy7411efijt3Nc2I16Nj1Hrbnu
 dExCgMtyRdp8EtDiaXaiXKLGghj/Ei12VMy1uzMcAtkm32kh0Y/qXLlTGyDVV5e7zznY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=dOLALz1vVkGQQvke7gVN11UmPxK4RpUrwS8s0jibGVg=; b=G
 AC3N/BV3elbUhjkpdDrk4NheoKslrwaKgbcXuoEmNOQILqHJ5vuOrSYU59EmMHzyDX/fe3z9JLRet
 1oAawjru8BwPirstV51/7BVAGHw+W+ooDYj0yp+BCfMyiP4lQNpp3Sz9fhMkiyzWBNek7K5CZegic
 kTRlegHjgNezytEs=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x7BE4-0005wt-BH for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 12:28:30 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-484366874b0so467416f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 17 Sep 2026 05:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789648102; x=1790252902; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dOLALz1vVkGQQvke7gVN11UmPxK4RpUrwS8s0jibGVg=;
 b=QvhGrsFLmvKzHDRyCSs/NSwv0mk41ujIrynDUQBZkwSTz/4P2Rs/1plqiaOn0vNgxI
 4KZ3P4p6iNq6385C/IEswTyX/NTNjPqMzxJfDbv63aPqh2LUsF43Y45bLtm/x1zC06Tz
 8vqRQ+nRpFwRkonDZkw2jNNwovleXkJJCRvrP6VMat1f4sMfo2h2f5vmWTHg8h9hwLtH
 lSySvbw/7Fd/a5QNXNH1wS6+75GCehRw/37mEtRgxl9ZVghpohd5rDB9cLXVea98akIT
 0FZLazkTdz52CJZZMohrSvZ1qLAt1Sv/4SpnlRUQ9BFgR1tOvD3LRcnlTXpB4ynYUeCQ
 QsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789648102; x=1790252902;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=dOLALz1vVkGQQvke7gVN11UmPxK4RpUrwS8s0jibGVg=;
 b=MNedGPa04tJ6i5GtCTN6ZarpwNQQXRKLM5naNcHK5so9tFHjy9wLs9yXwrja6ACpsa
 khd8+wM8+BecQJzgZwul0/TgzhWy5mfuGRJdAEFty2P6xeqNgao0daSoXeyGhA5+jy4W
 x9HO3V9r57mLoxoS4md0n5YSVt0ycmfjDFCApy6TkIPm13ylaYe1J0TUx4XwyHKKK3Gx
 wi9Ao8xO/m4f9/FEkuZiv+K2SPqSHdOtKw1YZxk8V/klXRrZwFnlNqazhYqXzKa5Je2j
 KNIDjfHKu7lOCSBOZzFqHK3TIa2OvzJ6jAkM+H2qr+suKQqEPEqDDuKVyHWhzLoKAJjZ
 vm9g==
X-Gm-Message-State: AFuF++kbGhtGEo1e57N/2Rfq8sRi3vl3pTffZVZIy/zxqnmLsrkXV1PX
 uQppt+CIT+FvnZmkbIQaWmQbtnsxoxh6PuH+DkugCrXUimhyrJG259AoUSdsYWMVWuOzdjeqobk
 skUh5F7bUJwDatvpHqI7kfWTD16B7hu2g/qjvbut+lJbbsbFfYY/kDW/hkrksHQbN2xK+
X-Gm-Gg: AYBFou1ENKLY8wuSKlDfzyUC3DcafkGfnHl676z/P2wRYeO+ICTJvE58iSnSZIepuPD
 z4kacN7lIjSKq9xlyyvbO3G2q7dtJQzNMufsCaxYUUEm+H/vdhG/7/NCWbh8DflqtWLKDw3dS6E
 j2RAUKGatmEH1/W/JANJapS5kYK2mDO9OmWHZHCx+MQmuzb0j/Q1axoG3bxmBlKpxgTnPcc8gOV
 8QzYRyJSRPNVPjtdcEp+UWXOGzE0piGO0PCrRwngcm/V+bdkEQvSL4vr9ZJ1Sc41YNPDKh1ZBGn
 SkaBQx4Xwz6e2kLFyH0OUet57yNJswuX0cAS1AfGixXnrwODDZo0eTQ2Vp2LN/pIOufMK7B8Vcu
 64i/yNC0dw8MnrtHgV7FWIEe7+DyLEaAaa3CcUGDQjZGlf3cNfrLlNWf4lxs2xvas6ytPTuiABH
 jw+2nFV7LaXv9PZDmjA0QCubsQiAGpmgkZHVAsfYjzQ6Ccj3mJSUxb45tvGeanMoxCeIxfg8tdl
 vUcK1feYByEH4fLRDzkpgc7ygiUozeexM9zCD470rFQ3MBduaZbBREq+H4aETUNUQ256G02jsRB
 7eLZ55TZaWXcaRA1JEfu50Tgf9INIptu2+Vl1iwGJWQrHhakQuDX+0AMi6MTtw==
X-Received: by 2002:a05:6000:41c7:b0:487:403:84f1 with SMTP id
 ffacd0b85a97d-4870cee9015mr17374459f8f.9.1789648101518; 
 Thu, 17 Sep 2026 05:28:21 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf344fcsm16249682f8f.26.2026.09.17.05.28.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 05:28:21 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 17 Sep 2026 12:28:12 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 26
X-Gerrit-Change-Id: I375a41749060b7d006647bc27002c55436c8a8bb
X-Gerrit-Change-Number: 1748
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1748?usp=email>
X-Gerrit-Commit: 5fc002eff7bf1be5478dae6e28a336f1bc904b06
In-Reply-To: <gerrit.1782719911000.I375a41749060b7d006647bc27002c55436c8a8bb@gerrit.openvpn.net>
References: <gerrit.1782719911000.I375a41749060b7d006647bc27002c55436c8a8bb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkzNzVhNDE3NDkwNjBiN2QwMDY2NDdiYzI3MDAyYzU1NDM2YzhhOGJiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e4996f804e2b08fdddd3deb207c76abb4266b253-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x7BE4-0005wt-BH
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Measure probe
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
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8129141175400253537=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8129141175400253537==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/7BHHX2uxYk="; charset=UTF-8

--/7BHHX2uxYk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici=2E

Hello plaist=
hos, ralf_lici, 

I'd like you to reexamine a change=2E Please visit

    h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1748?usp=3Demail

to look at the n=
ew patch set (#26)=2E


Change subject: oob: Measure probe RTT for candidat=
e-band selection
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

oob: Measure probe RTT for candidate-band selection

Record each probe=
's round-trip time (per-target send timestamp vs reply
arrival) and feed it=
 to oob_rank_probe_results(), where RTT forms the
candidate band: responder=
s within the effective margin of the fastest
compete on weight, slower ones=
 fall behind=2E Log the measured RTT and the
effective margin (with its sou=
rce: client or server-advertised) at verb
4=2E

Before this the client neve=
r measured RTT, so every responder sat in the
band and selection was purely=
 weighted-random; with real measurements
the latency-based candidate select=
ion takes effect=2E

The timestamp is taken at the first send=2E A reply ca=
rries nothing that
ties it to a send round, so measuring from a resend woul=
d report a
server slower than one round as fast, and could rank it ahead of=
 a
genuinely faster one=2E Entries that resolve to the same address share t=
he
send time of the single probe=2E

The RTT therefore runs from the first =
send to the moment the client
reads the reply: it compares servers, it is n=
ot a network measurement=2E A
probe that needed a resend reads high; the re=
send exists so that a
dropped probe does not make a live server look dead, =
not to refine the
measurement=2E

Change-Id: I375a41749060b7d006647bc27002c=
55436c8a8bb
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M doc/man-s=
ections/client-options=2Erst
M src/openvpn/oob=2Eh
M src/openvpn/oob_client=
=2Ec
3 files changed, 65 insertions(+), 17 deletions(-)


  git pull ssh://=
gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/48/1748/26

diff --git a/=
doc/man-sections/client-options=2Erst b/doc/man-sections/client-options=2Er=
st
index b95d605=2E=2E3ba1f62 100644
--- a/doc/man-sections/client-options=
=2Erst
+++ b/doc/man-sections/client-options=2Erst
@@ -608,9 +608,17 @@
   =
remote, and each answering server replies with its advertised priority
   a=
nd weight=2E Remotes are then reordered following DNS SRV (RFC 2782)
   sem=
antics: servers that answered are tried before those that did not,
-  group=
ed by priority (lowest first); within a priority group, servers are
-  pick=
ed by weighted-random selection=2E Round-trip time is not yet taken
-  into=
 account, so ``max-latency-diff`` has no effect for now=2E
+  grouped by pr=
iority (lowest first); within a priority group, servers
+  whose measured r=
ound-trip time is within ``max-latency-diff``
+  milliseconds of the fastes=
t one are picked by weighted-random
+  selection, the others follow in roun=
d-trip-time order=2E When
+  ``max-latency-diff`` is not given, the margin =
advertised by the fastest
+  server of a priority group applies to that gro=
up; the margins of the
+  slower servers play no part=2E A server advertisi=
ng :code:`0` thus says
+  that, when it is the fastest, only servers tying =
it count as equal=2E A
+  value of :code:`1000` or more makes every answeri=
ng server of a
+  priority group a candidate, since replies only arrive wit=
hin the
+  one-second probe window; the group is then ordered by weight alo=
ne=2E
 
   The probe is currently sent without control-channel wrapping, so=
 it only
   works against a server configured without ``--tls-auth``,
diff =
--git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh
index 8d7e4b3=2E=2E42002d=
c 100644
--- a/src/openvpn/oob=2Eh
+++ b/src/openvpn/oob=2Eh
@@ -201,6 +201=
,7 @@
     struct openvpn_sockaddr dest;
     socklen_t destlen;
     bool =
sent;
+    struct timeval sent_at; /* when the first probe went out, for th=
e RTT */
 };
 
 /**
diff --git a/src/openvpn/oob_client=2Ec b/src/openvpn/o=
ob_client=2Ec
index 16217c7=2E=2E12c220b 100644
--- a/src/openvpn/oob_clien=
t=2Ec
+++ b/src/openvpn/oob_client=2Ec
@@ -60,9 +60,11 @@
 struct probe_ctx=

 {
     socket_descriptor_t sd[PROBE_AF_COUNT]; /* SOCKET_UNDEFINED if tha=
t AF is unavailable */
-    /* Addresses probed so far in the current send =
round: an address several
-     * entries resolve to is probed once, and it=
s reply is credited to each=2E */
+    /* Addresses probed so far in the cu=
rrent send round, with the time each
+     * went out: an address several e=
ntries resolve to is probed once, and its
+     * reply is credited to each=
 of them with the same RTT=2E */
     struct openvpn_sockaddr *probed;
+   =
 struct timeval *probed_at;
     int n_probed;
 #ifdef TARGET_ANDROID
     =
bool fd_protected[PROBE_AF_COUNT]; /* VPNService protect(), once per socket=
 */
@@ -277,10 +279,18 @@
     /* Credit the reply to every still-unanswere=
d remote probed at its source
      * address: several entries can resolve =
to the same address, and each takes
      * the first reply for it=2E */
+ =
   struct timeval rcv;
+    openvpn_gettimeofday(&rcv, NULL);
     int i =
=3D oob_probe_next_target_at(from, targets, results, n, 0);
     while (i >=
=3D 0)
     {
+        /* From this round's send to now, i=2Ee=2E including=
 any time the reply
+         * waited in the receive queue while we were s=
till sending=2E */
+        long ms =3D (long)(rcv=2Etv_sec - targets[i]=2E=
sent_at=2Etv_sec) * 1000
+                  + (rcv=2Etv_usec - targets[i]=
=2Esent_at=2Etv_usec) / 1000;
+
         results[i]=2Eresponded =3D true;
+=
        results[i]=2Ertt_ms =3D (ms > 0) ? (unsigned int)ms : 0;
         r=
esults[i]=2Ereply =3D reply;
 
         i =3D oob_probe_next_target_at(from=
, targets, results, n, i + 1);
@@ -368,23 +378,34 @@
 /* Resend the probe t=
o every remote that we probed but that has not answered=2E */
 static void
=
 oob_probe_resend_unanswered(struct probe_ctx *pc, const struct buffer *pro=
be,
-                            const struct oob_probe_target *targets,
+ =
                           struct oob_probe_target *targets,
              =
               const struct oob_probe_result *results, int n)
 {
-    pc->n=
_probed =3D 0; /* a new round: probe each unanswered address once again */
=
+    /* A new round: every unanswered address is probed once more=2E The se=
nd time
+     * is left alone, so the RTT keeps measuring from the first se=
nd=2E */
+    pc->n_probed =3D 0;
     for (int i =3D 0; i < n; i++)
     {=

-        if (!targets[i]=2Esent || results[i]=2Eresponded
-            || =
oob_addr_list_find(pc->probed, pc->n_probed, &targets[i]=2Edest) >=3D 0)
+ =
       if (!targets[i]=2Esent || results[i]=2Eresponded)
+        {
+      =
      continue;
+        }
+        if (oob_addr_list_find(pc->probed, pc->=
n_probed, &targets[i]=2Edest) >=3D 0)
         {
             continue;
   =
      }
         socket_descriptor_t sd =3D pc->sd[probe_af_index(targets[i=
]=2Edest=2Eaddr=2Esa=2Esa_family)];
-        if (sd !=3D SOCKET_UNDEFINED
-=
            && sendto(sd, (const char *)CBPTR(probe), (int)BLEN(probe), 0,
=
-                      (const struct sockaddr *)&targets[i]=2Edest, targets=
[i]=2Edestlen)
-                   >=3D 0)
+        if (sd =3D=3D SOCKET_UN=
DEFINED)
         {
+            continue;
+        }
+        struct timev=
al sent_at;
+        openvpn_gettimeofday(&sent_at, NULL);
+        if (sen=
dto(sd, (const char *)CBPTR(probe), (int)BLEN(probe), 0,
+                 =
  (const struct sockaddr *)&targets[i]=2Edest, targets[i]=2Edestlen)
+     =
       >=3D 0)
+        {
+            pc->probed_at[pc->n_probed] =3D sent=
_at;
             pc->probed[pc->n_probed++] =3D targets[i]=2Edest;
       =
  }
     }
@@ -397,7 +418,7 @@
  * once the window elapses or every sent pr=
obe has been answered=2E */
 static void
 oob_probe_collect(struct probe_ct=
x *pc, const struct buffer *probe,
-                  const struct session_=
id *client_sid, const struct oob_probe_target *targets,
+                  =
const struct session_id *client_sid, struct oob_probe_target *targets,
    =
               struct oob_probe_result *results, int n,
                   =
const struct signal_info *sig)
 {
@@ -572,6 +593,7 @@
      * An address se=
veral entries resolve to is probed once; its reply is
      * credited to e=
ach of them=2E */
     pc=2Eprobed =3D gc_malloc(sizeof(*pc=2Eprobed) * l->=
len, false, &gc);
+    pc=2Eprobed_at =3D gc_malloc(sizeof(*pc=2Eprobed_at)=
 * l->len, false, &gc);
     pc=2En_probed =3D 0;
 
     int sent_count =3D=
 0;
@@ -598,8 +620,16 @@
             pc=2Efd_protected[af] =3D true;
     =
    }
 #endif
-        if (oob_addr_list_find(pc=2Eprobed, pc=2En_probed, &=
targets[i]=2Edest) < 0)
+        const int seen =3D oob_addr_list_find(pc=
=2Eprobed, pc=2En_probed, &targets[i]=2Edest);
+        if (seen >=3D 0)
  =
       {
+            /* Already probed this round by an earlier entry: reu=
se that send
+             * time, so both entries report the same RTT for =
the one reply=2E */
+            targets[i]=2Esent_at =3D pc=2Eprobed_at[se=
en];
+        }
+        else
+        {
+            openvpn_gettimeofday(=
&targets[i]=2Esent_at, NULL);
             if (sendto(sd, (const char *)BPT=
R(&probe), (int)BLEN(&probe), 0,
                        (struct sockaddr *=
)&targets[i]=2Edest, targets[i]=2Edestlen)
                 < 0)
@@ -607,6 =
+637,7 @@
                 msg(D_LOW, "server-probe: %s:%s: probe send fail=
ed", ce->remote, ce->remote_port);
                 continue;
             =
}
+            pc=2Eprobed_at[pc=2En_probed] =3D targets[i]=2Esent_at;
    =
         pc=2Eprobed[pc=2En_probed++] =3D targets[i]=2Edest;
         }
   =
      targets[i]=2Esent =3D true;
@@ -632,8 +663,16 @@
         if (results=
[i]=2Eresponded)
         {
             responded++;
-            msg(D_LO=
W, "server-probe: %s:%s answered (priority %d, weight %d)", ce->remote,
-  =
              ce->remote_port, results[i]=2Ereply=2Epriority, results[i]=2E=
reply=2Eweight);
+            /* The margin this server advertised, or the =
client's override; only
+             * the fastest server's margin applies=
 to its priority group=2E */
+            int client_margin =3D c->options=
=2Eserver_probe_latency_margin;
+            int margin =3D oob_effective_m=
argin(&results[i], client_margin);
+            const char *margin_src =3D =
client_margin >=3D 0 ? "client" : "server-advertised";
+            msg(D_L=
OW,
+                "server-probe: %s:%s answered (priority %d, weight %d,=
 rtt %u ms;"
+                " latency margin %d ms [%s])",
+             =
   ce->remote, ce->remote_port, results[i]=2Ereply=2Epriority, results[i]=
=2Ereply=2Eweight,
+                results[i]=2Ertt_ms, margin, margin_src=
);
         }
         else
         {

-- 
To view, visit http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1748?usp=3Demail
To unsubscribe, or for help writ=
ing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail
=

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: I375a41749060b7d006647bc27002c55436c8a8bb
Gerrit-Chan=
ge-Number: 1748
Gerrit-PatchSet: 26
Gerrit-Owner: stipa <lstipakov@gmail=2E=
com>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewe=
r: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel=
@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-Attention: ralf_lici <ralf@mandelbit=2Ecom>

--/7BHHX2uxYk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici=2E </p>
<p>stipa <strong>uploade=
d patch set #26</strong> to this change=2E</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1748?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">oob: Measure probe RTT for candidate-band selection<br><br>Record each=
 probe&#39;s round-trip time (per-target send timestamp vs reply<br>arrival=
) and feed it to oob_rank_probe_results(), where RTT forms the<br>candidate=
 band: responders within the effective margin of the fastest<br>compete on =
weight, slower ones fall behind=2E Log the measured RTT and the<br>effectiv=
e margin (with its source: client or server-advertised) at verb<br>4=2E<br>=
<br>Before this the client never measured RTT, so every responder sat in th=
e<br>band and selection was purely weighted-random; with real measurements<=
br>the latency-based candidate selection takes effect=2E<br><br>The timesta=
mp is taken at the first send=2E A reply carries nothing that<br>ties it to=
 a send round, so measuring from a resend would report a<br>server slower t=
han one round as fast, and could rank it ahead of a<br>genuinely faster one=
=2E Entries that resolve to the same address share the<br>send time of the =
single probe=2E<br><br>The RTT therefore runs from the first send to the mo=
ment the client<br>reads the reply: it compares servers, it is not a networ=
k measurement=2E A<br>probe that needed a resend reads high; the resend exi=
sts so that a<br>dropped probe does not make a live server look dead, not t=
o refine the<br>measurement=2E<br><br>Change-Id: I375a41749060b7d006647bc27=
002c55436c8a8bb<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br=
>---<br>M doc/man-sections/client-options=2Erst<br>M src/openvpn/oob=2Eh<br=
>M src/openvpn/oob_client=2Ec<br>3 files changed, 65 insertions(+), 17 dele=
tions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:2=
9418/openvpn refs/changes/48/1748/26</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/doc/man-sections/=
client-options=2Erst b/doc/man-sections/client-options=2Erst</span><br><spa=
n>index b95d605=2E=2E3ba1f62 100644</span><br><span>--- a/doc/man-sections/=
client-options=2Erst</span><br><span>+++ b/doc/man-sections/client-options=
=2Erst</span><br><span>@@ -608,9 +608,17 @@</span><br><span>   remote, and =
each answering server replies with its advertised priority</span><br><span>=
   and weight=2E Remotes are then reordered following DNS SRV (RFC 2782)</s=
pan><br><span>   semantics: servers that answered are tried before those th=
at did not,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  grouped =
by priority (lowest first); within a priority group, servers are</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-  picked by weighted-random sele=
ction=2E Round-trip time is not yet taken</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-  into account, so ``max-latency-diff`` has no effect f=
or now=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  grouped =
by priority (lowest first); within a priority group, servers</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  whose measured round-trip time i=
s within ``max-latency-diff``</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  milliseconds of the fastest one are picked by weighted-random</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  selection, the othe=
rs follow in round-trip-time order=2E When</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  ``max-latency-diff`` is not given, the margin adve=
rtised by the fastest</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  server of a priority group applies to that group; the margins of the</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  slower servers play =
no part=2E A server advertising :code:`0` thus says</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  that, when it is the fastest, only serv=
ers tying it count as equal=2E A</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  value of :code:`1000` or more makes every answering server o=
f a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  priority group=
 a candidate, since replies only arrive within the</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  one-second probe window; the group is then=
 ordered by weight alone=2E</span><br><span> </span><br><span>   The probe =
is currently sent without control-channel wrapping, so it only</span><br><s=
pan>   works against a server configured without ``--tls-auth``,</span><br>=
<span>diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh</span><br><spa=
n>index 8d7e4b3=2E=2E42002dc 100644</span><br><span>--- a/src/openvpn/oob=
=2Eh</span><br><span>+++ b/src/openvpn/oob=2Eh</span><br><span>@@ -201,6 +2=
01,7 @@</span><br><span>     struct openvpn_sockaddr dest;</span><br><span>=
     socklen_t destlen;</span><br><span>     bool sent;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct timeval sent_at; /* when the=
 first probe went out, for the RTT */</span><br><span> };</span><br><span> =
</span><br><span> /**</span><br><span>diff --git a/src/openvpn/oob_client=
=2Ec b/src/openvpn/oob_client=2Ec</span><br><span>index 16217c7=2E=2E12c220=
b 100644</span><br><span>--- a/src/openvpn/oob_client=2Ec</span><br><span>+=
++ b/src/openvpn/oob_client=2Ec</span><br><span>@@ -60,9 +60,11 @@</span><b=
r><span> struct probe_ctx</span><br><span> {</span><br><span>     socket_de=
scriptor_t sd[PROBE_AF_COUNT]; /* SOCKET_UNDEFINED if that AF is unavailabl=
e */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Addresses =
probed so far in the current send round: an address several</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-     * entries resolve to is probed o=
nce, and its reply is credited to each=2E */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* Addresses probed so far in the current send=
 round, with the time each</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+     * went out: an address several entries resolve to is probed onc=
e, and its</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * re=
ply is credited to each of them with the same RTT=2E */</span><br><span>   =
  struct openvpn_sockaddr *probed;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct timeval *probed_at;</span><br><span>     int n_pr=
obed;</span><br><span> #ifdef TARGET_ANDROID</span><br><span>     bool fd_p=
rotected[PROBE_AF_COUNT]; /* VPNService protect(), once per socket */</span=
><br><span>@@ -277,10 +279,18 @@</span><br><span>     /* Credit the reply t=
o every still-unanswered remote probed at its source</span><br><span>      =
* address: several entries can resolve to the same address, and each takes<=
/span><br><span>      * the first reply for it=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct timeval rcv;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    openvpn_gettimeofday(&amp;rcv, NU=
LL);</span><br><span>     int i =3D oob_probe_next_target_at(from, targets,=
 results, n, 0);</span><br><span>     while (i &gt;=3D 0)</span><br><span> =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Fro=
m this round&#39;s send to now, i=2Ee=2E including any time the reply</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+         * waited in the =
receive queue while we were still sending=2E */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        long ms =3D (long)(rcv=2Etv_sec - targe=
ts[i]=2Esent_at=2Etv_sec) * 1000</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                  + (rcv=2Etv_usec - targets[i]=2Esent_at=2Etv=
_usec) / 1000;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span>         results[i]=2Eresponded =3D true;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        results[i]=2Ertt_ms =3D (ms &gt; =
0) ? (unsigned int)ms : 0;</span><br><span>         results[i]=2Ereply =3D =
reply;</span><br><span> </span><br><span>         i =3D oob_probe_next_targ=
et_at(from, targets, results, n, i + 1);</span><br><span>@@ -368,23 +378,34=
 @@</span><br><span> /* Resend the probe to every remote that we probed but=
 that has not answered=2E */</span><br><span> static void</span><br><span> =
oob_probe_resend_unanswered(struct probe_ctx *pc, const struct buffer *prob=
e,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
         const struct oob_probe_target *targets,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                            struct oob_probe_t=
arget *targets,</span><br><span>                             const struct o=
ob_probe_result *results, int n)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    pc-&gt;n_probed =3D 0; /* a new round: =
probe each unanswered address once again */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* A new round: every unanswered address is pro=
bed once more=2E The send time</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     * is left alone, so the RTT keeps measuring from the first =
send=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pc-&g=
t;n_probed =3D 0;</span><br><span>     for (int i =3D 0; i &lt; n; i++)</sp=
an><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      if (!targets[i]=2Esent || results[i]=2Eresponded</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            || oob_addr_list_find(pc-&gt;p=
robed, pc-&gt;n_probed, &amp;targets[i]=2Edest) &gt;=3D 0)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if (!targets[i]=2Esent || re=
sults[i]=2Eresponded)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    continue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (oob_=
addr_list_find(pc-&gt;probed, pc-&gt;n_probed, &amp;targets[i]=2Edest) &gt;=
=3D 0)</span><br><span>         {</span><br><span>             continue;</s=
pan><br><span>         }</span><br><span>         socket_descriptor_t sd =
=3D pc-&gt;sd[probe_af_index(targets[i]=2Edest=2Eaddr=2Esa=2Esa_family)];</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (sd !=3D SOC=
KET_UNDEFINED</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    &amp;&amp; sendto(sd, (const char *)CBPTR(probe), (int)BLEN(probe), 0,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
(const struct sockaddr *)&amp;targets[i]=2Edest, targets[i]=2Edestlen)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                   &gt;=3D=
 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (sd =
=3D=3D SOCKET_UNDEFINED)</span><br><span>         {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            continue;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        struct timeval sent_at;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        openvpn_gettimeofday(&amp;sen=
t_at, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if (sendto(sd, (const char *)CBPTR(probe), (int)BLEN(probe), 0,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                   (const stru=
ct sockaddr *)&amp;targets[i]=2Edest, targets[i]=2Edestlen)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            &gt;=3D 0)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            pc-&gt;probed_at[pc-&gt;n_pro=
bed] =3D sent_at;</span><br><span>             pc-&gt;probed[pc-&gt;n_probe=
d++] =3D targets[i]=2Edest;</span><br><span>         }</span><br><span>    =
 }</span><br><span>@@ -397,7 +418,7 @@</span><br><span>  * once the window =
elapses or every sent probe has been answered=2E */</span><br><span> static=
 void</span><br><span> oob_probe_collect(struct probe_ctx *pc, const struct=
 buffer *probe,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
            const struct session_id *client_sid, const struct oob_probe_tar=
get *targets,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
            const struct session_id *client_sid, struct oob_probe_target *t=
argets,</span><br><span>                   struct oob_probe_result *results=
, int n,</span><br><span>                   const struct signal_info *sig)<=
/span><br><span> {</span><br><span>@@ -572,6 +593,7 @@</span><br><span>    =
  * An address several entries resolve to is probed once; its reply is</spa=
n><br><span>      * credited to each of them=2E */</span><br><span>     pc=
=2Eprobed =3D gc_malloc(sizeof(*pc=2Eprobed) * l-&gt;len, false, &amp;gc);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pc=2Eprobed_at =
=3D gc_malloc(sizeof(*pc=2Eprobed_at) * l-&gt;len, false, &amp;gc);</span><=
br><span>     pc=2En_probed =3D 0;</span><br><span> </span><br><span>     i=
nt sent_count =3D 0;</span><br><span>@@ -598,8 +620,16 @@</span><br><span> =
            pc=2Efd_protected[af] =3D true;</span><br><span>         }</spa=
n><br><span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      if (oob_addr_list_find(pc=2Eprobed, pc=2En_probed, &amp;targets[i]=2E=
dest) &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  const int seen =3D oob_addr_list_find(pc=2Eprobed, pc=2En_probed, &amp;ta=
rgets[i]=2Edest);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if (seen &gt;=3D 0)</span><br><span>         {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            /* Already probed this round =
by an earlier entry: reuse that send</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+             * time, so both entries report the same RTT f=
or the one reply=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            targets[i]=2Esent_at =3D pc=2Eprobed_at[seen];</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            openvpn_gettimeofday(&amp;targets[i]=2Esent_at=
, NULL);</span><br><span>             if (sendto(sd, (const char *)BPTR(&am=
p;probe), (int)BLEN(&amp;probe), 0,</span><br><span>                       =
 (struct sockaddr *)&amp;targets[i]=2Edest, targets[i]=2Edestlen)</span><br=
><span>                 &lt; 0)</span><br><span>@@ -607,6 +637,7 @@</span><=
br><span>                 msg(D_LOW, &quot;server-probe: %s:%s: probe send =
failed&quot;, ce-&gt;remote, ce-&gt;remote_port);</span><br><span>         =
        continue;</span><br><span>             }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            pc=2Eprobed_at[pc=2En_probed] =3D =
targets[i]=2Esent_at;</span><br><span>             pc=2Eprobed[pc=2En_probe=
d++] =3D targets[i]=2Edest;</span><br><span>         }</span><br><span>    =
     targets[i]=2Esent =3D true;</span><br><span>@@ -632,8 +663,16 @@</span=
><br><span>         if (results[i]=2Eresponded)</span><br><span>         {<=
/span><br><span>             responded++;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            msg(D_LOW, &quot;server-probe: %s:%s answer=
ed (priority %d, weight %d)&quot;, ce-&gt;remote,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                ce-&gt;remote_port, results[i]=
=2Ereply=2Epriority, results[i]=2Ereply=2Eweight);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            /* The margin this server advert=
ised, or the client&#39;s override; only</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+             * the fastest server&#39;s margin applies=
 to its priority group=2E */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            int client_margin =3D c-&gt;options=2Eserver_probe_lat=
ency_margin;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     int margin =3D oob_effective_margin(&amp;results[i], client_margin);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            const cha=
r *margin_src =3D client_margin &gt;=3D 0 ? &quot;client&quot; : &quot;serv=
er-advertised&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            msg(D_LOW,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                &quot;server-probe: %s:%s answered (priority %d, weight=
 %d, rtt %u ms;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                &quot; latency margin %d ms [%s])&quot;,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                ce-&gt;remote, ce-&g=
t;remote_port, results[i]=2Ereply=2Epriority, results[i]=2Ereply=2Eweight,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                resu=
lts[i]=2Ertt_ms, margin, margin_src);</span><br><span>         }</span><br>=
<span>         else</span><br><span>         {</span><br><span></span><br><=
/pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1748?usp=3Demail">change 1748</a>=2E To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1748?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpa=
tchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<=
div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Id: I375a41749060b7d006647bc27002c55436c8a8bb </di=
v>
<div style=3D"display:none"> Gerrit-Change-Number: 1748 </div>
<div styl=
e=3D"display:none"> Gerrit-PatchSet: 26 </div>
<div style=3D"display:none">=
 Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mand=
elbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-deve=
l &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@man=
delbit=2Ecom&gt; </div>

</body></html>
--/7BHHX2uxYk=--


--===============8129141175400253537==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8129141175400253537==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8129141175400253537==--

