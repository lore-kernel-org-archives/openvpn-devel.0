Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DCCCC9830E
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 21:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2jvkCafFZviwQS2uxwHdH50fA5h7SkDn07Rg+niTIe4=; b=Z13uDwWe0is2LswaJzI8fxNRlq
	GgjYwYgXeK29lOtbCO4TepnRcOgd6zrLDjODa5aqvO2F2/p1PWbRSlB2/2tpdotRRCEW0pUcebLIF
	j4fCtVg8+RJwjwN8YXfigksrLiIN9H545gNhi9UTxVoxRS56K64kH1UvgX8A9jWs2bN0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xADu2-0000Yr-7M;
	Fri, 25 Sep 2026 21:56:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xADu1-0000Yi-AG
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 21:56:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=IMNAiqRM8rpWSqpZQxvtTbEd4ZjN8RRLHLXklO8s670=; b=mpHrDJQc3QhTKr5LTjHaujzHf/
 6pplqW2wsIi57tlwMv/3FD03A7QS8z5ZmQ2wx0uh1oYwCKXzmRfi774z1pfnr7B/iuLamlbWYSerP
 KuObcETPnq+Q9kLfYxTKxE9wg2mxcNQiSJuIh8qQGzojHIITaQcDHrLZc7WjKK4XGhBo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=IMNAiqRM8rpWSqpZQxvtTbEd4ZjN8RRLHLXklO8s670=; b=e
 7nPrVdZ2DElLpOx1H+9NvoUZ453Lw+Qy0Z8mWa00Y2me1uKCB2xQEbnqhk881OWCZqKUgJk9uZNSC
 PSrk1Gx8QpkjmtpnS8N8wefRTd1Bwc7n+jdddSYIzmO/LN6T3HnoZlN2Oqd8fFhPT/M6USE9yrF+I
 ouzYgyYn3bDbWZMM=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xADtz-0002gv-T5 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 21:56:21 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e71cdb22bso9873135e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 25 Sep 2026 14:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790373373; x=1790978173; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=IMNAiqRM8rpWSqpZQxvtTbEd4ZjN8RRLHLXklO8s670=;
 b=ZM2T4EuF9AUN7yYdYtPeIrupO5U94oZNoe8Tiq214zZUJnno2zS4oby7Bjcf/a3rbk
 CZjVdHMMtDpHDI9NYFCydB6Z0ramA+euWUvPuJXHpEcNRUu4S5HLbX7A+2Wee6YUYaqr
 0JbHQBRGeb3A9CS0DBIa9D9otRAsXeSQ9/ShsobyHXMi8puDOJ0nFADZRprztG4v3vA/
 8xuobc6CbHJ9rmnHr9B9eYBXWmwgw2d35CMfJuu8kLE/PryjG/ffRJbPYMkbOZVNQYgg
 FdvM1QBRxDHZz24pkqlMDLBKN26GUrARPbcrCggVJiI6m2y/iEdxYQbzetZ42ViWDT7B
 4m/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790373373; x=1790978173;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=IMNAiqRM8rpWSqpZQxvtTbEd4ZjN8RRLHLXklO8s670=;
 b=sdmpReWZHieIMsIc3GTAM2NEWI1I83VAGIXYNgV76QsdzpXu1GHxh9y6S1TQtn3R9x
 ngKo36n8Rz5fHIcRS9kPA0HkienrVWRYG5L6V/rmDiHCojwjt6DflMuS4HPODruS6n9+
 NRI6hGxpzwv7Suc8YoxiJLNyBxn96pIeim9xlIa7Gx3EF4phVQeQuHO11PrX5CpTlvNO
 GJGm4CMcxtJzfvDnCHoE/GOh4gPyS6sUrgc/R//oBcnFys1domxFWu0kLoFMGZaPlbNm
 OXiJWfUr2j8iKpBsS6GXZedAxB7OFkHH5Gy2zxwux0PAJoc91vG7iv1jlEJu7sQjF5gn
 aMOQ==
X-Gm-Message-State: AFuF++m0zB5ZtKtXIjq1uUO+HxvWs4+AWtRhtizPu5hKfxt/rmzkXrG6
 4r4nVAR5wkfs3pkSnLuqvYXAl2V9V/BdZy2Cn81VF02Y0R3sKh5/ML3712FEJwX0Re26zOWSX9i
 T/U8cVj4NCjqV/obYxaBshEC6UR3J/cbr8Z1KVuARfCOPx4j9h6CbsIY614v0v8U/Oq/nQSkotO
 k1orOy2w==
X-Gm-Gg: AYBFou2nT32mj8wVzOMEYiU2nR1Ld+3BBI4O+aRYkpcEP88Y5d4f8R+hpYD4GdlWeus
 /uSoUHufnJ4s+7+dE4pdwnCgQe88WcyvYZpb1e2CG43DDyIJPxADXKkD6TW0Yh8eU8XaYEU94r6
 N5kFdq5CNanc+RTouv3Fzxz/+gTajK2Nv+2cXV0wOEt3lJC0uJLrmTle5Le4PScr5QQoZbAMacj
 kDe4l/2A0/ER/5c3gv5KpgBwrkzKLPiAAK9qgVLIRNDPUjrzmz/5QOumZHKPJ2K6KZ78uVMvcBP
 hB8kzjRlKG1iYndUvPYcfw5A5AH7rraVceT+5RiPO7yhhCOaWUAyrNhWB1ofweA0pSynszFV9tj
 /Um9wSxBLgUFUaGagf50m1+qPTj2mUiSSJch10Nyf2KQyIoCraYsB3KgxphPKGumjS4Lypm+khL
 3L2nsmuY+MW4VY8xcb79RsYnInw3B+1Qds3yUGNpb5YNdwmU9SdY6Umahlcntqp/YiYpL53rLVp
 ueHt+J+2Uuwu8YNKQ0ZNKaUZAZjI4YxRJKPAEBUFONAsXiYhg5O7kDVAM/MZiFDAEAwgcuekKZW
 +Nz8L1eX9HE5xS2hXBk+B4O/c8gps4grJDV5z3tVxHd0ArW8oFN4s1qTiLA/
X-Received: by 2002:a05:600c:4f4f:b0:49e:69f8:e846 with SMTP id
 5b1f17b1804b1-49fe66cbb70mr138411885e9.9.1790373373187; 
 Fri, 25 Sep 2026 14:56:13 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ff06d4394sm91755645e9.15.2026.09.25.14.56.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 14:56:12 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 25 Sep 2026 21:56:11 +0000
To: razvanc <razvanc@mailbox.org>,
	plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I46a9ef71359f42395d69cf899c948014fb72f65a
X-Gerrit-Change-Number: 1738
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1738?usp=email>
X-Gerrit-Commit: e6670b335b99bed5810cf2d0465279e208d14462
In-Reply-To: <gerrit.1782693360000.I46a9ef71359f42395d69cf899c948014fb72f65a@gerrit.openvpn.net>
References: <gerrit.1782693360000.I46a9ef71359f42395d69cf899c948014fb72f65a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNjkzMzYwMDAwLkk0NmE5ZWY3MTM1OWY0MjM5NWQ2OWNmODk5Yzk0ODAxNGZiNzJmNjVhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <037c179edaf4a2c223f4c9bd1160fe4ec80c0972-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xADtz-0002gv-T5
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco_linux: drop the
 now-redundant __is_locked re-entrancy guard
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2280194371032319109=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2280194371032319109==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BRApttCvwig="; charset=UTF-8

--BRApttCvwig=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 ordex=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1738?usp=3Demail )

T=
he following approvals got outdated and were removed:
Code-Review+2 by razv=
anc


Change subject: dco_linux: drop the now-redundant __is_locked re-entr=
ancy guard
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

d=
co_linux: drop the now-redundant __is_locked re-entrancy guard

__is_locked=
 existed only to stop setenv_stats() from issuing a GET_PEER
request/reply =
while the shared socket was still being drained for a batch
of notification=
s, which could fail with NLE_BUSY/NLE_NOMEM or re-enter
nl_recvmsgs() on th=
e busy socket=2E Now that notifications are read on a
dedicated socket and =
GET_PEER goes to the request/reply socket, the two
never share an nl_recvms=
gs() call: the request/reply socket no longer
dispatches notifications, so =
multi_process_incoming_dco() (the only path
that reaches dco_get_peer() dur=
ing message parsing) never runs while that
socket is in flight, and the fla=
g is always false at its check=2E Remove
the flag, its set/clear and the ea=
rly return=2E

Change-Id: I46a9ef71359f42395d69cf899c948014fb72f65a
Signed-=
off-by: Antonio Quartulli <antonio@mandelbit=2Ecom>
Acked-by: Razvan Cojoca=
ru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1738
Message-Id: <20260925131830=2E10902-1-gert@greenie=2Emuc=2Ede>
=
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2En=
et/msg39499=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
--=
-
M src/openvpn/dco_linux=2Ec
1 file changed, 6 insertions(+), 18 deletions=
(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/38=
/1738/4

diff --git a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2Ec=

index 27f4f99=2E=2Ee583696 100644
--- a/src/openvpn/dco_linux=2Ec
+++ b/sr=
c/openvpn/dco_linux=2Ec
@@ -49,16 +49,6 @@
 #include <netlink/genl/family=
=2Eh>
 #include <netlink/genl/ctrl=2Eh>
 
-/* When parsing multiple DEL_PEE=
R notifications, openvpn tries to request stats
- * for each DEL_PEER messa=
ge (see setenv_stats)=2E This triggers a GET_PEER
- * request-reply while w=
e are still parsing the rest of the initial
- * notifications, which can le=
ad to NLE_BUSY or even NLE_NOMEM=2E
- *
- * This basic lock ensures we don'=
t bite our own tail by issuing a dco_get_peer
- * while still busy receivin=
g and parsing other messages=2E
- */
-static bool __is_locked =3D false;
-
=
 /* libnl < 3=2E5=2E0 does not set the NLA_F_NESTED on its own, therefore w=
e
  * have to explicitly do it to prevent the kernel from failing upon
  * =
parsing of the message
@@ -170,12 +160,16 @@
     return ret;
 }
 
+/**
+ *=
 Drain the request/reply socket=2E Used to read command/stats replies=2E Th=
is
+ * socket is never subscribed to the multicast group, so it cannot deli=
ver an
+ * asynchronous notification: a reply being parsed here can therefo=
re never
+ * trigger an instance close or a re-entrant request on the same =
socket=2E
+ */
 static int
 ovpn_nl_recvmsgs(dco_context_t *dco, const char=
 *prefix)
 {
-    __is_locked =3D true;
     int ret =3D nl_recvmsgs(dco->n=
l_sock, dco->nl_cb);
-    __is_locked =3D false;
 
     return ovpn_nl_recv=
msgs_report(ret, prefix);
 }
@@ -1223,12 +1217,6 @@
 {
     ASSERT(dco);
 
=
-    if (__is_locked)
-    {
-        msg(D_DCO_DEBUG, "%s: cannot request =
peer stats while parsing other messages", __func__);
-        return 0;
-  =
  }
-
     /* peer_id =3D=3D -1 means "dump all peers", but this is allowed=
 in MP mode only=2E
      * If it happens in P2P mode it means that the DCO=
 peer was deleted and we
      * can simply bail out

-- 
To view, visit ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1738?usp=3Demail
To unsubscribe, or=
 for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerr=
it-Branch: master
Gerrit-Change-Id: I46a9ef71359f42395d69cf899c948014fb72f6=
5a
Gerrit-Change-Number: 1738
Gerrit-PatchSet: 4
Gerrit-Owner: ordex <anton=
io@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>=

Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel =
<openvpn-devel@lists=2Esourceforge=2Enet>

--BRApttCvwig=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #4</strong> to the change originally created by ordex=2E</p=
><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1738?usp=3Demail">=
View Change</a></p><p>The following approvals got outdated and were removed=
:
Code-Review+2 by razvanc</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">dco_linux: drop the now-redunda=
nt __is_locked re-entrancy guard<br><br>__is_locked existed only to stop se=
tenv_stats() from issuing a GET_PEER<br>request/reply while the shared sock=
et was still being drained for a batch<br>of notifications, which could fai=
l with NLE_BUSY/NLE_NOMEM or re-enter<br>nl_recvmsgs() on the busy socket=
=2E Now that notifications are read on a<br>dedicated socket and GET_PEER g=
oes to the request/reply socket, the two<br>never share an nl_recvmsgs() ca=
ll: the request/reply socket no longer<br>dispatches notifications, so mult=
i_process_incoming_dco() (the only path<br>that reaches dco_get_peer() duri=
ng message parsing) never runs while that<br>socket is in flight, and the f=
lag is always false at its check=2E Remove<br>the flag, its set/clear and t=
he early return=2E<br><br>Change-Id: I46a9ef71359f42395d69cf899c948014fb72f=
65a<br>Signed-off-by: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt;<br>=
Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1738<br>Message-Id: &lt;202609251318=
30=2E10902-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39499=2Ehtml<br>Signed-of=
f-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/=
dco_linux=2Ec<br>1 file changed, 6 insertions(+), 18 deletions(-)<br><br></=
pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/=
changes/38/1738/4</pre><pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;"><span>diff --git a/src/openvpn/dco_linux=2Ec b/src/open=
vpn/dco_linux=2Ec</span><br><span>index 27f4f99=2E=2Ee583696 100644</span><=
br><span>--- a/src/openvpn/dco_linux=2Ec</span><br><span>+++ b/src/openvpn/=
dco_linux=2Ec</span><br><span>@@ -49,16 +49,6 @@</span><br><span> #include =
&lt;netlink/genl/family=2Eh&gt;</span><br><span> #include &lt;netlink/genl/=
ctrl=2Eh&gt;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-/* When parsing multiple DEL_PEER notifications, openvpn tries to =
request stats</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * for e=
ach DEL_PEER message (see setenv_stats)=2E This triggers a GET_PEER</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * request-reply while we are=
 still parsing the rest of the initial</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- * notifications, which can lead to NLE_BUSY or even NLE_N=
OMEM=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * This basic lock ensures we don=
&#39;t bite our own tail by issuing a dco_get_peer</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * while still busy receiving and parsing othe=
r messages=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-static bool __is_locked =
=3D false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span> /* libnl &lt; 3=2E5=2E0 does not set the NLA_F_NESTED on its own, th=
erefore we</span><br><span>  * have to explicitly do it to prevent the kern=
el from failing upon</span><br><span>  * parsing of the message</span><br><=
span>@@ -170,12 +160,16 @@</span><br><span>     return ret;</span><br><span=
> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Drain the r=
equest/reply socket=2E Used to read command/stats replies=2E This</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * socket is never subscribed=
 to the multicast group, so it cannot deliver an</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * asynchronous notification: a reply being pa=
rsed here can therefore never</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * trigger an instance close or a re-entrant request on the same =
socket=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span>=
<br><span> static int</span><br><span> ovpn_nl_recvmsgs(dco_context_t *dco,=
 const char *prefix)</span><br><span> {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    __is_locked =3D true;</span><br><span>     int ret =
=3D nl_recvmsgs(dco-&gt;nl_sock, dco-&gt;nl_cb);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    __is_locked =3D false;</span><br><span> </sp=
an><br><span>     return ovpn_nl_recvmsgs_report(ret, prefix);</span><br><s=
pan> }</span><br><span>@@ -1223,12 +1217,6 @@</span><br><span> {</span><br>=
<span>     ASSERT(dco);</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    if (__is_locked)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        msg(D_DCO_DEBUG, &quot;%s: cannot request peer stats while parsi=
ng other messages&quot;, __func__);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        return 0;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span>     /* peer_id =3D=3D -1 means &quot;dump all peers&quot;, but =
this is allowed in MP mode only=2E</span><br><span>      * If it happens in=
 P2P mode it means that the DCO peer was deleted and we</span><br><span>   =
   * can simply bail out</span><br></pre><p>To view, visit <a href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1738?usp=3Demail">change 1738</a>=2E T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscop=
e itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" =
href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1738?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"disp=
lay:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:non=
e"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bran=
ch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I46a9ef713=
59f42395d69cf899c948014fb72f65a </div>
<div style=3D"display:none"> Gerrit-=
Change-Number: 1738 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 =
</div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandelb=
it=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos=
 &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>

</body></html>
--BRApttCvwig=--


--===============2280194371032319109==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2280194371032319109==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2280194371032319109==--

