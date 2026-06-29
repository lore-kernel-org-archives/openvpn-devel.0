Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B84C44500
	for <openvpn-devel@archiver.kernel.org>; Mon, 29 Jun 2026 07:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=z9SDmY7k5j7/sHQOvqaQHuWJ/yJz2q7gpTeezAG72l8=; b=DeT2vPsoA7y9F/
	3OTVLsC4TUpw0ugKH5SZwNiw0f9BPcw2IiIkGOgZA9Zj53NOspm32yPtnSOMn2HX54tk/ZtZkCG91
	sZBb6SMlX0l1BASohiuzcw24o/+y4DowLYC1BnXka97FQfNxIdDTS24/yY5Kfgm3qLkDqOrAH1NFR
	/yY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1we6tl-0002KN-7w;
	Mon, 29 Jun 2026 07:59:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1we6tj-0002K6-RN
 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 07:59:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kPpXA/i8LU2vjw45BtRQ38llqs9af6UHZ1zHYO7yC90=; b=UDd+EDgHtNdyee/F/WPSC6FisW
 xXfxbZxpQI9YnGsJWf8vEkLQ+ddK5MFiY1oWUoHjUqStuDgn6i+Zdew6RzJzJYGb0xiwfUMf15sav
 3DLK0CL1rLc9tAYh1AFvhyxDzpPEBHmmFqmdawlJjhWMIDqFao9bA+KFz9xJ9PIdc9ok=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=kPpXA/i8LU2vjw45BtRQ38llqs9af6UHZ1zHYO7yC90=; b=W
 8sGxVprM9r4OmgMEJAr+C14ETLB0E1LbKfLAQsak5n9iLaLoU8/FDYwSMMno+aGx8zOMm3l/L417J
 rNgKGr0W38Z9lQvbTxHQ7ABmbGN7oZcJMAbY7pziOwrTR69KFutLheDQwQ/VZmQHVgBoHzW8YqQEG
 MftxrQu9TgkrQ9mw=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1we6ti-0008OI-JR for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 07:59:20 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-4624a44e152so2721920f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 29 Jun 2026 00:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782719947; x=1783324747; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kPpXA/i8LU2vjw45BtRQ38llqs9af6UHZ1zHYO7yC90=;
 b=MSXa4cDjn0a6Jw2bvPdbV+OGPLZWp2/GyKV0HudXVqcxL9yBzReWTY0O84D8/lysiD
 9NA/VAk5dcqN2blKjCrFNL+oGSEp1/aMtotytVzwbruklrn0+/yOy18vbMF4bCd6b9IL
 5xCfskWyIXsClyEhlsV0OxplyI3YTHLdxrjDZT8NOprx51TVLn1G6hkIggLjudK9pW3O
 Cc6++vw1tVVoLFmoh6gfeSxdPR3OI5mImNJoSgp/PjuYwLjK2s/bN9zWES1NnaU/Vcvw
 pc7qZn5fudAdrjolfnDHBo2ZDd2mIuLnJrsdTo65y2HDnCI1ltXQ7oq4nGvX+H68ODXR
 cZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782719947; x=1783324747;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kPpXA/i8LU2vjw45BtRQ38llqs9af6UHZ1zHYO7yC90=;
 b=H3gd2NSydSUufMTa4PU0uo70YTm/ZmX2qjOOAdF9k4B/lt4KWHnxhv2IA091a7kyiM
 d1i5wIc5PAGGZUR7bJ0JG2Fl6fJ4NQTqrl4cMkYdndk4CMWFb3MBmBTX4a2De6eZnIas
 mhz/MXkrgZRen4BsgeYiWY2XNpDAkSA6pRB+iABboh3zEVFpZnNFMB9otmxJFK8KAFfV
 OmjXXeLmyRzXelfhhht/biyA+vMDX9dbxm9N08hjanzR36i1AsaFqJS27jSVekf/gXDy
 2DfFXqUSw1nsa6Zn32RTFn8i3Rxoqb0d5P7aKPrfKC+GIZn6KHJ0AuelkWu8ULRaWhA6
 1P6Q==
X-Gm-Message-State: AOJu0Yw0hmIkqKoe6m6WRom+8ajgDr4/WyRMAQCPwbL7BpuiWIOFhuFL
 1zy8CeqJEKmbGBkG5kHQzpWat5NEinCu9bAnYi+AvDXXpIz3iuMWE+EZsYh49Yt57feQL076rz2
 iJRF8ypwJaLNSks8sGthZhrQZeoyGviuBgrCg3YsNF1/ia7vQ9utJjnw/5zgMTEZJ7CCPo8wlVe
 2vqd/Lyw==
X-Gm-Gg: AfdE7clF8fRsu5GA6hbp7/YrrDLVW3GosDBfBsUTRYItoJnGuz/IlguJw1iVUBO8Zj4
 IQTg2lodcrzgnAXqYbmG44+wO4RfxekzegJt2dzVyNseiEa+SGEZFqUEIkk18SQ/x24ZZHMXHYR
 u5HCljulfNFXHqwtJCkzN42d8DuFG+1/9lnZDK1YD9JQzz4kas2qJr7Ekf4EJi0XiUDvqYjPG9f
 eyHXopFTSaloVk1WwzetaKxivrBOKMFTjrDsQzi2CN7oThPdUD492Cv3eLnuxNqT9wh+gcrpT9C
 fryJbpkZcvXpvMtQcMvaQqQQiKsJGOUbmH91h1xll/AM7ZVG0BbQi/WGwgdqVY650uqev3BA0ru
 jpMD06b72Fp8xwH71fvu/mK1SnGVW6aXshEckSS5BAshQRtCz4P9NPjqbr0sDVCBR6PtuJHmWlL
 XQlHAPZCmnumCJF/eGZofpAdd6pUosUu+fG4hrfAyaDphksVJtp3IapsCCOZqVoE7WgNhGTxFjB
 Z0HtPQx1b9vCKm1vX1u6XAKfnYBMHbMN+D8u7lCYfEdkS1XQ/pSvwjAf3zwlzUjV50g5IGKhebX
 j2g=
X-Received: by 2002:a05:6000:26c6:b0:473:1706:7efe with SMTP id
 ffacd0b85a97d-47317067fdemr5473926f8f.24.1782719947333; 
 Mon, 29 Jun 2026 00:59:07 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4707ed8ee0bsm22043361f8f.27.2026.06.29.00.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 00:59:06 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 29 Jun 2026 07:59:05 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8
X-Gerrit-Change-Number: 1752
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1752?usp=email>
X-Gerrit-Commit: 64c3c1d12fadb070a6bd08eaf158a7918c23de67
References: <gerrit.1782719911000.Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklkNzRjZmFlN2U5ZDY5MDI5ZDJkZGJmNjM1ZWU4NWEyYTZjZWRjM2Q4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <864bca8e4c28d179e789881af0dd7895054ac55a-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1we6ti-0008OI-JR
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Add
 --server-probe-reply to advertise probe priority/weight
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
Content-Type: multipart/mixed; boundary="===============0092491329311503359=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0092491329311503359==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IQXomhqbzgg="; charset=UTF-8

--IQXomhqbzgg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1752?usp=3Demail

to review the following change=2E


Chang=
e subject: oob: Add --server-probe-reply to advertise probe priority/weight=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Add -=
-server-probe-reply to advertise probe priority/weight

Add a server option=
, --server-probe-reply <priority> <weight>, that sets
the DNS-SRV-style pri=
ority and weight the server returns in its OOB
PROBE_REPLY=2E Both default =
to 0 (the previous hardcoded behaviour), and are
range-checked to 0=2E=2E65=
535=2E

The values are plumbed through oob_build_probe_reply() into the pro=
be_reply
TLV; the client already reads and ranks remotes by them=2E

Change=
-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8
Signed-off-by: Lev Stipakov =
<lev@openvpn=2Enet>
---
M src/openvpn/mudp=2Ec
M src/openvpn/oob=2Ec
M src/=
openvpn/oob=2Eh
M src/openvpn/options=2Ec
M src/openvpn/options=2Eh
M tests=
/unit_tests/openvpn/test_oob=2Ec
6 files changed, 58 insertions(+), 15 dele=
tions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/52/1752/1

diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
ind=
ex 9bc2d9c=2E=2E0e9414d 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn=
/mudp=2Ec
@@ -236,7 +236,11 @@
          * tls-auth/tls-crypt wrapping)=2E =
Answer it without creating a session=2E */
         struct oob_probe_reply =
reply;
         if (!oob_build_probe_reply(&state->newbuf, (uint64_t)now, (=
uint64_t)handwindow,
-                                   &state->peer_sessi=
on_id, &reply))
+                                   &state->peer_session_id=
,
+                                   (uint16_t)m->top=2Eoptions=2Eserver_p=
robe_reply_priority,
+                                   (uint16_t)m->top=
=2Eoptions=2Eserver_probe_reply_weight,
+                                  =
 (uint16_t)m->top=2Eoptions=2Eserver_probe_reply_max_latency_diff,
+       =
                            &reply))
         {
             /* malformed o=
r replayed/stale probe: silently drop */
             return false;
diff --=
git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec
index 9b359dd=2E=2E42a618d =
100644
--- a/src/openvpn/oob=2Ec
+++ b/src/openvpn/oob=2Ec
@@ -222,7 +222,8=
 @@
 
 bool
 oob_build_probe_reply(struct buffer *probe_payload, uint64_t n=
ow, uint64_t window_secs,
-                      const struct session_id *p=
eer_sid, struct oob_probe_reply *reply)
+                      const struct=
 session_id *peer_sid, uint16_t priority, uint16_t weight,
+               =
       uint16_t max_latency_diff, struct oob_probe_reply *reply)
 {
     st=
ruct oob_probe_parameter param;
     if (!oob_server_probe_read(probe_paylo=
ad, &param))
@@ -238,7 +239,10 @@
 
     memset(reply, 0, sizeof(*reply));
=
     reply->peer_session_id =3D *peer_sid;
-    /* priority/weight/connect_=
lifetime/flags left at 0 for now */
+    reply->priority =3D priority;
+   =
 reply->weight =3D weight;
+    reply->max_latency_diff =3D max_latency_dif=
f;
+    /* connect_lifetime/flags left at 0 for now */
     return true;
 }=

 
diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh
index 65e84bd=2E=
=2Efcefb26 100644
--- a/src/openvpn/oob=2Eh
+++ b/src/openvpn/oob=2Eh
@@ -2=
00,8 +200,8 @@
  * answer it=2E Combines oob_server_probe_read() and oob_ti=
mestamp_in_window():
  * the probe is dropped (false returned) if it has no=
 valid probe_parameter or
  * its timestamp is outside the acceptable windo=
w=2E On success @p reply is
- * populated with the peer's session id echoed=
 back and the remaining fields
- * zeroed, ready to be wrapped and sent=2E
=
+ * populated with the peer's session id echoed back and the given priority=
 and
+ * weight (other fields zeroed), ready to be wrapped and sent=2E
  *
=
  * This is the transport-agnostic decision step; the caller performs the s=
end=2E
  *
@@ -209,11 +209,15 @@
  * @param now            current time (UN=
IX seconds)
  * @param window_secs    acceptable timestamp skew, in either =
direction
  * @param peer_sid       session id of the requesting peer (echo=
ed in the reply)
+ * @param priority       priority to advertise (DNS-SRV s=
emantics; lower preferred)
+ * @param weight         weight to advertise (D=
NS-SRV semantics; higher preferred)
+ * @param max_latency_diff  candidate-=
band margin (ms) to advertise; 0 =3D defer to client
  * @param reply      =
    filled with the reply to send on success
  * @return true if a reply sh=
ould be sent, false to silently drop the probe
  */
 bool oob_build_probe_r=
eply(struct buffer *probe_payload, uint64_t now, uint64_t window_secs,
-   =
                        const struct session_id *peer_sid, struct oob_probe=
_reply *reply);
+                           const struct session_id *peer_s=
id, uint16_t priority, uint16_t weight,
+                           uint16_=
t max_latency_diff, struct oob_probe_reply *reply);
 
 /* Candidate-band ma=
rgin (ms) used when neither the client nor the server
  * specifies one=2E =
*/
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index d54=
e3ab=2E=2Ef86b438 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/op=
tions=2Ec
@@ -804,10 +804,14 @@
     o->ce=2Eproto =3D PROTO_UDP;
     o->c=
e=2Eaf =3D AF_UNSPEC;
 
-    /* The client latency margin is -1 =3D "not se=
t": the client's value is
-     * authoritative when given, otherwise each =
server's advertised margin (or
-     * the built-in default) applies=2E */
=
+    /* server-probe defaults=2E The client latency margin is -1 =3D "not s=
et": the
+     * client's value is authoritative when given, otherwise each=
 server's
+     * advertised margin (or the built-in default) applies=2E An=
 (unconfigured)
+     * server advertises weight 50 / priority 100 and no m=
argin (0)=2E */
     o->server_probe_latency_margin =3D -1;
+    o->server_=
probe_reply_weight =3D 50;
+    o->server_probe_reply_priority =3D 100;
+  =
  o->server_probe_reply_max_latency_diff =3D 0;
     o->ce=2Ebind_ipv6_only=
 =3D false;
     o->ce=2Econnect_retry_seconds =3D 1;
     o->ce=2Econnect_=
retry_seconds_max =3D 300;
@@ -6526,6 +6530,26 @@
             options->ser=
ver_probe_latency_margin =3D margin;
         }
     }
+    else if (streq(=
p[0], "server-probe-reply") && !p[4])
+    {
+        VERIFY_PERMISSION(OPT=
_P_GENERAL);
+        /* --server-probe-reply [max-latency-diff] [weight] [=
prio]; each optional */
+        int vals[3] =3D { options->server_probe_re=
ply_max_latency_diff,
+                        options->server_probe_reply_=
weight,
+                        options->server_probe_reply_priority };
+ =
       for (int i =3D 0; i < 3 && p[i + 1]; i++)
+        {
+            va=
ls[i] =3D positive_atoi(p[i + 1], msglevel);
+            if (vals[i] > 0xf=
fff)
+            {
+                msg(msglevel, "--server-probe-reply: v=
alues must be 0 to 65535");
+                goto err;
+            }
+    =
    }
+        options->server_probe_reply_max_latency_diff =3D vals[0];
+ =
       options->server_probe_reply_weight =3D vals[1];
+        options->se=
rver_probe_reply_priority =3D vals[2];
+    }
     else if (streq(p[0], "ni=
ce") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_NICE);
diff =
--git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh
index 6b1120a=2E=
=2E6e4829d 100644
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/options=
=2Eh
@@ -339,6 +339,12 @@
     /* client: default candidate-band margin in =
ms (--server-probe [max-latency-diff]):
      * servers within this RTT of =
the fastest are treated as equally fast */
     int server_probe_latency_ma=
rgin;
+    /* server: values advertised in the OOB PROBE_REPLY (--server-pr=
obe-reply)=2E
+     * priority/weight follow DNS-SRV semantics; max_latency=
_diff overrides the
+     * client's margin for this server (0 =3D defer to=
 the client)=2E */
+    int server_probe_reply_priority;
+    int server_pr=
obe_reply_weight;
+    int server_probe_reply_max_latency_diff;
 
     bool=
 mlock;
 
diff --git a/tests/unit_tests/openvpn/test_oob=2Ec b/tests/unit_t=
ests/openvpn/test_oob=2Ec
index b66ade2=2E=2Ec3efbdf 100644
--- a/tests/uni=
t_tests/openvpn/test_oob=2Ec
+++ b/tests/unit_tests/openvpn/test_oob=2Ec
@@=
 -285,7 +285,7 @@
 }
 
 /* A valid, in-window SERVER_PROBE yields a reply t=
hat echoes the peer's
- * session id and zeroes the remaining fields=2E */
=
+ * session id and carries the configured priority and weight=2E */
 static=
 void
 test_build_probe_reply_valid(void **state)
 {
@@ -300,12 +300,13 @@
=
     memcpy(peer=2Eid, "PEER1234", SID_SIZE);
 
     struct oob_probe_reply=
 reply;
-    assert_true(oob_build_probe_reply(&buf, now, 30, &peer, &reply=
));
+    assert_true(oob_build_probe_reply(&buf, now, 30, &peer, 5, 50, 25,=
 &reply));
     assert_memory_equal(reply=2Epeer_session_id=2Eid, peer=2Eid=
, SID_SIZE);
-    assert_int_equal(reply=2Epriority, 0);
-    assert_int_eq=
ual(reply=2Eweight, 0);
+    assert_int_equal(reply=2Epriority, 5);
+    as=
sert_int_equal(reply=2Eweight, 50);
     assert_int_equal(reply=2Econnect_l=
ifetime, 0);
     assert_int_equal(reply=2Eflags, 0);
+    assert_int_equal=
(reply=2Emax_latency_diff, 25);
 
     gc_free(&gc);
 }
@@ -323,7 +324,7 @@=

 
     struct session_id peer =3D { 0 };
     struct oob_probe_reply reply=
;
-    assert_false(oob_build_probe_reply(&buf, now, 30, &peer, &reply));
+=
    assert_false(oob_build_probe_reply(&buf, now, 30, &peer, 0, 0, 0, &repl=
y));
 
     gc_free(&gc);
 }
@@ -341,7 +342,7 @@
 
     struct session_id p=
eer =3D { 0 };
     struct oob_probe_reply reply;
-    assert_false(oob_bui=
ld_probe_reply(&buf, 1000000, 30, &peer, &reply));
+    assert_false(oob_bu=
ild_probe_reply(&buf, 1000000, 30, &peer, 0, 0, 0, &reply));
 
     gc_free=
(&gc);
 }

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/175=
2?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http:=
//gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchang=
e
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id74cfae7=
e9d69029d2ddbf635ee85a2a6cedc3d8
Gerrit-Change-Number: 1752
Gerrit-PatchSet=
: 1
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>

--IQXomhqbzgg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1752?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">oo=
b: Add --server-probe-reply to advertise probe priority/weight<br><br>Add a=
 server option, --server-probe-reply &lt;priority&gt; &lt;weight&gt;, that =
sets<br>the DNS-SRV-style priority and weight the server returns in its OOB=
<br>PROBE_REPLY=2E Both default to 0 (the previous hardcoded behaviour), an=
d are<br>range-checked to 0=2E=2E65535=2E<br><br>The values are plumbed thr=
ough oob_build_probe_reply() into the probe_reply<br>TLV; the client alread=
y reads and ranks remotes by them=2E<br><br>Change-Id: Id74cfae7e9d69029d2d=
dbf635ee85a2a6cedc3d8<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&=
gt;<br>---<br>M src/openvpn/mudp=2Ec<br>M src/openvpn/oob=2Ec<br>M src/open=
vpn/oob=2Eh<br>M src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>M =
tests/unit_tests/openvpn/test_oob=2Ec<br>6 files changed, 58 insertions(+),=
 15 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/52/1752/1</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
n/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index 9bc2d9c=2E=2E0e9414=
d 100644</span><br><span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/s=
rc/openvpn/mudp=2Ec</span><br><span>@@ -236,7 +236,11 @@</span><br><span>  =
        * tls-auth/tls-crypt wrapping)=2E Answer it without creating a sess=
ion=2E */</span><br><span>         struct oob_probe_reply reply;</span><br>=
<span>         if (!oob_build_probe_reply(&amp;state-&gt;newbuf, (uint64_t)=
now, (uint64_t)handwindow,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                                   &amp;state-&gt;peer_session_id, &am=
p;reply))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                         &amp;state-&gt;peer_session_id,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                                   (ui=
nt16_t)m-&gt;top=2Eoptions=2Eserver_probe_reply_priority,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                                   (u=
int16_t)m-&gt;top=2Eoptions=2Eserver_probe_reply_weight,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                                   (ui=
nt16_t)m-&gt;top=2Eoptions=2Eserver_probe_reply_max_latency_diff,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                             =
      &amp;reply))</span><br><span>         {</span><br><span>             =
/* malformed or replayed/stale probe: silently drop */</span><br><span>    =
         return false;</span><br><span>diff --git a/src/openvpn/oob=2Ec b/s=
rc/openvpn/oob=2Ec</span><br><span>index 9b359dd=2E=2E42a618d 100644</span>=
<br><span>--- a/src/openvpn/oob=2Ec</span><br><span>+++ b/src/openvpn/oob=
=2Ec</span><br><span>@@ -222,7 +222,8 @@</span><br><span> </span><br><span>=
 bool</span><br><span> oob_build_probe_reply(struct buffer *probe_payload, =
uint64_t now, uint64_t window_secs,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                      const struct session_id *peer_sid, stru=
ct oob_probe_reply *reply)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                      const struct session_id *peer_sid, uint16_t pr=
iority, uint16_t weight,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                      uint16_t max_latency_diff, struct oob_probe_repl=
y *reply)</span><br><span> {</span><br><span>     struct oob_probe_paramete=
r param;</span><br><span>     if (!oob_server_probe_read(probe_payload, &am=
p;param))</span><br><span>@@ -238,7 +239,10 @@</span><br><span> </span><br>=
<span>     memset(reply, 0, sizeof(*reply));</span><br><span>     reply-&gt=
;peer_session_id =3D *peer_sid;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    /* priority/weight/connect_lifetime/flags left at 0 for now *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    reply-&gt;prio=
rity =3D priority;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   reply-&gt;weight =3D weight;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    reply-&gt;max_latency_diff =3D max_latency_diff;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* connect_lifetime/flags =
left at 0 for now */</span><br><span>     return true;</span><br><span> }</=
span><br><span> </span><br><span>diff --git a/src/openvpn/oob=2Eh b/src/ope=
nvpn/oob=2Eh</span><br><span>index 65e84bd=2E=2Efcefb26 100644</span><br><s=
pan>--- a/src/openvpn/oob=2Eh</span><br><span>+++ b/src/openvpn/oob=2Eh</sp=
an><br><span>@@ -200,8 +200,8 @@</span><br><span>  * answer it=2E Combines =
oob_server_probe_read() and oob_timestamp_in_window():</span><br><span>  * =
the probe is dropped (false returned) if it has no valid probe_parameter or=
</span><br><span>  * its timestamp is outside the acceptable window=2E On s=
uccess @p reply is</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
populated with the peer&#39;s session id echoed back and the remaining fiel=
ds</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * zeroed, ready to=
 be wrapped and sent=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * populated with the peer&#39;s session id echoed back and the given p=
riority and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * weigh=
t (other fields zeroed), ready to be wrapped and sent=2E</span><br><span>  =
*</span><br><span>  * This is the transport-agnostic decision step; the cal=
ler performs the send=2E</span><br><span>  *</span><br><span>@@ -209,11 +20=
9,15 @@</span><br><span>  * @param now            current time (UNIX second=
s)</span><br><span>  * @param window_secs    acceptable timestamp skew, in =
either direction</span><br><span>  * @param peer_sid       session id of th=
e requesting peer (echoed in the reply)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @param priority       priority to advertise (DNS-SRV=
 semantics; lower preferred)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param weight         weight to advertise (DNS-SRV semantics; h=
igher preferred)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
@param max_latency_diff  candidate-band margin (ms) to advertise; 0 =3D def=
er to client</span><br><span>  * @param reply          filled with the repl=
y to send on success</span><br><span>  * @return true if a reply should be =
sent, false to silently drop the probe</span><br><span>  */</span><br><span=
> bool oob_build_probe_reply(struct buffer *probe_payload, uint64_t now, ui=
nt64_t window_secs,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                         const struct session_id *peer_sid, struct oob_prob=
e_reply *reply);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                        const struct session_id *peer_sid, uint16_t priorit=
y, uint16_t weight,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                           uint16_t max_latency_diff, struct oob_probe_repl=
y *reply);</span><br><span> </span><br><span> /* Candidate-band margin (ms)=
 used when neither the client nor the server</span><br><span>  * specifies =
one=2E */</span><br><span>diff --git a/src/openvpn/options=2Ec b/src/openvp=
n/options=2Ec</span><br><span>index d54e3ab=2E=2Ef86b438 100644</span><br><=
span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/option=
s=2Ec</span><br><span>@@ -804,10 +804,14 @@</span><br><span>     o-&gt;ce=
=2Eproto =3D PROTO_UDP;</span><br><span>     o-&gt;ce=2Eaf =3D AF_UNSPEC;</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /=
* The client latency margin is -1 =3D &quot;not set&quot;: the client&#39;s=
 value is</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * autho=
ritative when given, otherwise each server&#39;s advertised margin (or</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-     * the built-in defaul=
t) applies=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* server-probe defaults=2E The client latency margin is -1 =3D &quot;not =
set&quot;: the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
* client&#39;s value is authoritative when given, otherwise each server&#39=
;s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * advertised=
 margin (or the built-in default) applies=2E An (unconfigured)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     * server advertises weight =
50 / priority 100 and no margin (0)=2E */</span><br><span>     o-&gt;server=
_probe_latency_margin =3D -1;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    o-&gt;server_probe_reply_weight =3D 50;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    o-&gt;server_probe_reply_priority =3D=
 100;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;serv=
er_probe_reply_max_latency_diff =3D 0;</span><br><span>     o-&gt;ce=2Ebind=
_ipv6_only =3D false;</span><br><span>     o-&gt;ce=2Econnect_retry_seconds=
 =3D 1;</span><br><span>     o-&gt;ce=2Econnect_retry_seconds_max =3D 300;<=
/span><br><span>@@ -6526,6 +6530,26 @@</span><br><span>             options=
-&gt;server_probe_latency_margin =3D margin;</span><br><span>         }</sp=
an><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    else if (streq(p[0], &quot;server-probe-reply&quot;) &amp;&amp; !p[4])<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_GE=
NERAL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* -=
-server-probe-reply [max-latency-diff] [weight] [prio]; each optional */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        int vals[3] =
=3D { options-&gt;server_probe_reply_max_latency_diff,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                        options-&gt;serv=
er_probe_reply_weight,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                        options-&gt;server_probe_reply_priority };</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D 0;=
 i &lt; 3 &amp;&amp; p[i + 1]; i++)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            vals[i] =3D positive_atoi(p[i + 1], msglevel);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            if (vals[i] &gt; 0=
xffff)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                msg=
(msglevel, &quot;--server-probe-reply: values must be 0 to 65535&quot;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                goto e=
rr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;server_probe=
_reply_max_latency_diff =3D vals[0];</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        options-&gt;server_probe_reply_weight =3D vals[1];=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt=
;server_probe_reply_priority =3D vals[2];</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span>     else if (streq(p[0], &quot=
;nice&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span=
><br><span>         VERIFY_PERMISSION(OPT_P_NICE);</span><br><span>diff --g=
it a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh</span><br><span>inde=
x 6b1120a=2E=2E6e4829d 100644</span><br><span>--- a/src/openvpn/options=2Eh=
</span><br><span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -339,6 +3=
39,12 @@</span><br><span>     /* client: default candidate-band margin in m=
s (--server-probe [max-latency-diff]):</span><br><span>      * servers with=
in this RTT of the fastest are treated as equally fast */</span><br><span> =
    int server_probe_latency_margin;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* server: values advertised in the OOB PROBE_REPLY (-=
-server-probe-reply)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * priority/weight follow DNS-SRV semantics; max_latency_diff overr=
ides the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * clie=
nt&#39;s margin for this server (0 =3D defer to the client)=2E */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    int server_probe_reply_pr=
iority;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int serv=
er_probe_reply_weight;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    int server_probe_reply_max_latency_diff;</span><br><span> </span><br=
><span>     bool mlock;</span><br><span> </span><br><span>diff --git a/test=
s/unit_tests/openvpn/test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec</=
span><br><span>index b66ade2=2E=2Ec3efbdf 100644</span><br><span>--- a/test=
s/unit_tests/openvpn/test_oob=2Ec</span><br><span>+++ b/tests/unit_tests/op=
envpn/test_oob=2Ec</span><br><span>@@ -285,7 +285,7 @@</span><br><span> }</=
span><br><span> </span><br><span> /* A valid, in-window SERVER_PROBE yields=
 a reply that echoes the peer&#39;s</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * session id and zeroes the remaining fields=2E */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * session id and carries the=
 configured priority and weight=2E */</span><br><span> static void</span><b=
r><span> test_build_probe_reply_valid(void **state)</span><br><span> {</spa=
n><br><span>@@ -300,12 +300,13 @@</span><br><span>     memcpy(peer=2Eid, &q=
uot;PEER1234&quot;, SID_SIZE);</span><br><span> </span><br><span>     struc=
t oob_probe_reply reply;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    assert_true(oob_build_probe_reply(&amp;buf, now, 30, &amp;peer, &amp=
;reply));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_true(oob_build_probe_reply(&amp;buf, now, 30, &amp;peer, 5, 50, 25, &amp;r=
eply));</span><br><span>     assert_memory_equal(reply=2Epeer_session_id=2E=
id, peer=2Eid, SID_SIZE);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    assert_int_equal(reply=2Epriority, 0);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    assert_int_equal(reply=2Eweight, 0);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(reply=2E=
priority, 5);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_int_equal(reply=2Eweight, 50);</span><br><span>     assert_int_equal(r=
eply=2Econnect_lifetime, 0);</span><br><span>     assert_int_equal(reply=2E=
flags, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_int_equal(reply=2Emax_latency_diff, 25);</span><br><span> </span><br><spa=
n>     gc_free(&amp;gc);</span><br><span> }</span><br><span>@@ -323,7 +324,=
7 @@</span><br><span> </span><br><span>     struct session_id peer =3D { 0 =
};</span><br><span>     struct oob_probe_reply reply;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    assert_false(oob_build_probe_reply(&amp=
;buf, now, 30, &amp;peer, &amp;reply));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_false(oob_build_probe_reply(&amp;buf, now, 3=
0, &amp;peer, 0, 0, 0, &amp;reply));</span><br><span> </span><br><span>    =
 gc_free(&amp;gc);</span><br><span> }</span><br><span>@@ -341,7 +342,7 @@</=
span><br><span> </span><br><span>     struct session_id peer =3D { 0 };</sp=
an><br><span>     struct oob_probe_reply reply;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    assert_false(oob_build_probe_reply(&amp;buf, =
1000000, 30, &amp;peer, &amp;reply));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_false(oob_build_probe_reply(&amp;buf, 1000000,=
 30, &amp;peer, 0, 0, 0, &amp;reply));</span><br><span> </span><br><span>  =
   gc_free(&amp;gc);</span><br><span> }</span><br><span></span><br></pre><p=
>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752?u=
sp=3Demail">change 1752</a>=2E To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">=
settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1752?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1752 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--IQXomhqbzgg=--


--===============0092491329311503359==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0092491329311503359==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0092491329311503359==--

