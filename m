Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FED4C9832A
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 21:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J6ioOt+rBNEzGpNBFmXiv+4db3nm27VmeDV5Sb7lmRo=; b=Ga2ScXKI/KoUPQQAfTL3w8t84h
	XOzOprBJHhNBhFaJOVN+Ad4/jDgu7qEI0hNFFT0C4eSJJqa4vHwTjcm9OacXoonCRDM1WEzAhN60/
	zXkFYjUb/xG5DaqtBg/gmUSYcOIlKR7LvaNUnq71vFaRhyfA3ajQHR6ob6czoRNIUK04=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xADu6-0007V3-Ii;
	Fri, 25 Sep 2026 21:56:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xADu4-0007Uw-Pm
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 21:56:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=YnA0BDy/gJSBnEjZKCy4FpYaimwCr6kYT9nipqa0yLY=; b=GTHHvDakuuZNCatXoIQLf/80En
 lFQROlShtuHWiQbzzPgBXTMx7xXyq58ZG4ww1gbcH54ZbiVoH6/jcGbDPtr1tdCi860EztxyGrx/w
 hvA/7r4Na5uLwbSyh0KsqbZhZHwP9HWPcqt6GUKwWHESfUminhNlIfOhdcNKHgV1adq8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=YnA0BDy/gJSBnEjZKCy4FpYaimwCr6kYT9nipqa0yLY=; b=a
 EFzW48op541xvJ4+ai6nJFZWBfqOjKUISrwIaMCHKNEwGUONi4bnbN0H+iIzjNRchcZ+NOmBKHPjE
 k65fIlBZTmEmD5pFG6IbFovBJhZR/Fg5lDrle3+9nvaQkzJFkyQAGZjRyCFQ7nB50UuPlKQQdi20T
 Q7fsPFV1ssyWt5i8=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xADu1-0002gy-E3 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 21:56:22 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e7bcb94d3so10132955e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 25 Sep 2026 14:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790373375; x=1790978175; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YnA0BDy/gJSBnEjZKCy4FpYaimwCr6kYT9nipqa0yLY=;
 b=I50+/27CC+kpM4hpfiR1NZa4iBYAciSimNju+h3U9hQari1GqrZMfGYWefhlEIAOAu
 1feQL4CzDygoaigo23ZchDE7DhfOMG8RRey3tpCKLTAxRsz7ev433AKQzh3cmAy9U88B
 a4puzuCyka73W6oLHS9GcFplb3+PppRYFRoMGcFI93aWGfXnusxcd+L7wEUrQPHM/NhA
 oFJSWf+j35A7DHbhb3fUz/UiM3PZDp+LMrRroIvZ4Tn4vFoPM1BDtjdRJ8GX/Eud3/Yo
 dzvXW4AXH49FSklozNwpcuTasfq7P/TGRWAwEeO7hXIa2tX3d9po6jLf704Rvgp1+SuH
 MnCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790373375; x=1790978175;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YnA0BDy/gJSBnEjZKCy4FpYaimwCr6kYT9nipqa0yLY=;
 b=YRW1ZC5AJphR+Wuzwbh6nsql3OP4n9WR5Ar6S0RDv8z5uu23Cedk9wDo/W5Sawfcrr
 wQqXu3AghyXceFvYyDGugBnj6CRPgDhpkC7gEKzYWObBRPEvrD4PL6IFEyP0EBZM2//V
 /NVL7OJZq7PfPdrAlF5ibq0ANK/2BfYQ5waFU1zjkliHpU8Mhk3TK9AjZUJZP65itT/n
 1Q4qL41VyU1PRXwWXJ6msH73mT97a6y2rTKQii4TTO3h+dFkZwVs+CRVDQ8n/RxWOQr/
 11v+6vD/LmPAQVB1t6CQqtJtWSb1/ctkCCPqm7UQv/GVw/hC0eEjbhqWreiyhEBKlFm2
 y13g==
X-Forwarded-Encrypted: i=1;
 AKwUvBytFTqKaWLuGIn7kQIn/3q9Sv0IYx3UO24DsTaxBCZjnd/6KzMCiAHByP2pvz22JI5PP8UTbwj/VhutWz7K@lists.sourceforge.net
X-Gm-Message-State: AFuF++m0IR8QFZh3yAuPTJrl6HK/GO3ULrUR7EeeyW1J5x9KX1OpeXWf
 l4/6HR9kZijKGqZCInggR0Ouqplb3Sz/26VIyD4s6EQEki9ezOuuOtsinc8gAUf8+VJRv5jmCrJ
 2yr0PXXEv+1XepVOKmVrgaz2TRnQ2qNu2L/+FV6XOlX6IDIVL3/LQHBdZtVXOpp8kvneWCqeNjK
 /+bExH7g==
X-Gm-Gg: AYBFou3wA4xE+wBmSvCyftKZbh2jcnP4RKkyuS5bBk5eMUK47kt7Mcvgf4/jaZGU7Z6
 oPGAoP43srM2txf6/YcDrHU1muYKJbEvFClwAH1ZicD6GMscOC1a12uX52rio2riDPuDNnIGnC6
 T0gGgJYTQEExS5ppXSFT02pnWr00Spa2CV2I+0CyKq4ReBEQhQ6NgF3mfb0xO4ITwTYUkkRV44D
 jIMCU6tOcPM4UCzShL01EG/Hc1YWJd33anigxoVG3tNv2WoaV2pAvUDpYDtENGamvdmn7RoqWHt
 Ad8DCY6gn5rmSM+HDdxMr3ZwtaGxWzFPz7E6Ws8BvAAmE0YgxrPV/uQ85Fe/XSgA10mfJl4cD67
 j9kiYiivr/rF4q9ihI/PB/A+7aMO6cVRuN271XR9/F3s6sTpU1UJAEHSI3UHUP6PBrxmPSJ3P4U
 JTjwLi+HgfqxNs+8OxJUssmvd+t9WIhP4xARp3909S80rEfjZl+dTBoty6OLKaeONFqPCl9koMZ
 Jukh1s8NovXNG3iZVoa9VRbp9tCNgYk89e0s0WHvoDlIxvlXDbKUVGkgIZsezzl4blVPhoXti/b
 8yr4xyx6Bbp0U8X8WkgmbE8p4a4kPR/dhQ9zfH2vJCy+mchvMryFYNG8DPLY
X-Received: by 2002:a05:600c:4ec6:b0:49d:1a02:4797 with SMTP id
 5b1f17b1804b1-49fe66d828fmr126765235e9.17.1790373374789; 
 Fri, 25 Sep 2026 14:56:14 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a34a314sm10058454f8f.6.2026.09.25.14.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 14:56:14 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 25 Sep 2026 21:56:14 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I46a9ef71359f42395d69cf899c948014fb72f65a
X-Gerrit-Change-Number: 1738
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1738?usp=email>
X-Gerrit-Commit: e6670b335b99bed5810cf2d0465279e208d14462
In-Reply-To: <gerrit.1782693360000.I46a9ef71359f42395d69cf899c948014fb72f65a@gerrit.openvpn.net>
References: <gerrit.1782693360000.I46a9ef71359f42395d69cf899c948014fb72f65a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNjkzMzYwMDAwLkk0NmE5ZWY3MTM1OWY0MjM5NWQ2OWNmODk5Yzk0ODAxNGZiNzJmNjVhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <037c179edaf4a2c223f4c9bd1160fe4ec80c0972-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xADu1-0002gy-E3
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============9115218649924118052=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============9115218649924118052==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uOdhYLJCydw="; charset=UTF-8

--uOdhYLJCydw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1738?usp=3Demail )

Change subject: dco_linux: drop the now-redundant _=
_is_locked re-entrancy guard
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

dco_linux: drop the now-redundant __is_locked re-entrancy =
guard

__is_locked existed only to stop setenv_stats() from issuing a GET_P=
EER
request/reply while the shared socket was still being drained for a bat=
ch
of notifications, which could fail with NLE_BUSY/NLE_NOMEM or re-enter
n=
l_recvmsgs() on the busy socket=2E Now that notifications are read on a
ded=
icated socket and GET_PEER goes to the request/reply socket, the two
never =
share an nl_recvmsgs() call: the request/reply socket no longer
dispatches =
notifications, so multi_process_incoming_dco() (the only path
that reaches =
dco_get_peer() during message parsing) never runs while that
socket is in f=
light, and the flag is always false at its check=2E Remove
the flag, its se=
t/clear and the early return=2E

Change-Id: I46a9ef71359f42395d69cf899c9480=
14fb72f65a
Signed-off-by: Antonio Quartulli <antonio@mandelbit=2Ecom>
Acked=
-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1738
Message-Id: <20260925131830=2E10902-1-gert@gr=
eenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg39499=2Ehtml
Signed-off-by: Gert Doering <gert@gree=
nie=2Emuc=2Ede>
---
M src/openvpn/dco_linux=2Ec
1 file changed, 6 insertion=
s(+), 18 deletions(-)




diff --git a/src/openvpn/dco_linux=2Ec b/src/open=
vpn/dco_linux=2Ec
index 27f4f99=2E=2Ee583696 100644
--- a/src/openvpn/dco_l=
inux=2Ec
+++ b/src/openvpn/dco_linux=2Ec
@@ -49,16 +49,6 @@
 #include <netl=
ink/genl/family=2Eh>
 #include <netlink/genl/ctrl=2Eh>
 
-/* When parsing m=
ultiple DEL_PEER notifications, openvpn tries to request stats
- * for each=
 DEL_PEER message (see setenv_stats)=2E This triggers a GET_PEER
- * reques=
t-reply while we are still parsing the rest of the initial
- * notification=
s, which can lead to NLE_BUSY or even NLE_NOMEM=2E
- *
- * This basic lock =
ensures we don't bite our own tail by issuing a dco_get_peer
- * while stil=
l busy receiving and parsing other messages=2E
- */
-static bool __is_locke=
d =3D false;
-
 /* libnl < 3=2E5=2E0 does not set the NLA_F_NESTED on its o=
wn, therefore we
  * have to explicitly do it to prevent the kernel from fa=
iling upon
  * parsing of the message
@@ -170,12 +160,16 @@
     return ret=
;
 }
 
+/**
+ * Drain the request/reply socket=2E Used to read command/stat=
s replies=2E This
+ * socket is never subscribed to the multicast group, so=
 it cannot deliver an
+ * asynchronous notification: a reply being parsed h=
ere can therefore never
+ * trigger an instance close or a re-entrant reque=
st on the same socket=2E
+ */
 static int
 ovpn_nl_recvmsgs(dco_context_t *=
dco, const char *prefix)
 {
-    __is_locked =3D true;
     int ret =3D nl_=
recvmsgs(dco->nl_sock, dco->nl_cb);
-    __is_locked =3D false;
 
     retu=
rn ovpn_nl_recvmsgs_report(ret, prefix);
 }
@@ -1223,12 +1217,6 @@
 {
     =
ASSERT(dco);
 
-    if (__is_locked)
-    {
-        msg(D_DCO_DEBUG, "%s: =
cannot request peer stats while parsing other messages", __func__);
-      =
  return 0;
-    }
-
     /* peer_id =3D=3D -1 means "dump all peers", but =
this is allowed in MP mode only=2E
      * If it happens in P2P mode it mea=
ns that the DCO peer was deleted and we
      * can simply bail out

-- 
To=
 view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1738?usp=3Demail
To =
unsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I46a9ef71359f42395d69cf899c94=
8014fb72f65a
Gerrit-Change-Number: 1738
Gerrit-PatchSet: 4
Gerrit-Owner: or=
dex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: open=
vpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--uOdhYLJCydw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1738?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">dco_linux: drop the now-redundant __is_loc=
ked re-entrancy guard<br><br>__is_locked existed only to stop setenv_stats(=
) from issuing a GET_PEER<br>request/reply while the shared socket was stil=
l being drained for a batch<br>of notifications, which could fail with NLE_=
BUSY/NLE_NOMEM or re-enter<br>nl_recvmsgs() on the busy socket=2E Now that =
notifications are read on a<br>dedicated socket and GET_PEER goes to the re=
quest/reply socket, the two<br>never share an nl_recvmsgs() call: the reque=
st/reply socket no longer<br>dispatches notifications, so multi_process_inc=
oming_dco() (the only path<br>that reaches dco_get_peer() during message pa=
rsing) never runs while that<br>socket is in flight, and the flag is always=
 false at its check=2E Remove<br>the flag, its set/clear and the early retu=
rn=2E<br><br>Change-Id: I46a9ef71359f42395d69cf899c948014fb72f65a<br>Signed=
-off-by: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt;<br>Acked-by: Raz=
van Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1738<br>Message-Id: &lt;20260925131830=2E10902-1-=
gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvp=
n-devel@lists=2Esourceforge=2Enet/msg39499=2Ehtml<br>Signed-off-by: Gert Do=
ering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/dco_linux=2Ec=
<br>1 file changed, 6 insertions(+), 18 deletions(-)<br><br></pre>
<pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2Ec</span><br><sp=
an>index 27f4f99=2E=2Ee583696 100644</span><br><span>--- a/src/openvpn/dco_=
linux=2Ec</span><br><span>+++ b/src/openvpn/dco_linux=2Ec</span><br><span>@=
@ -49,16 +49,6 @@</span><br><span> #include &lt;netlink/genl/family=2Eh&gt;=
</span><br><span> #include &lt;netlink/genl/ctrl=2Eh&gt;</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* When parsing multip=
le DEL_PEER notifications, openvpn tries to request stats</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * for each DEL_PEER message (see seten=
v_stats)=2E This triggers a GET_PEER</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * request-reply while we are still parsing the rest of the =
initial</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * notificatio=
ns, which can lead to NLE_BUSY or even NLE_NOMEM=2E</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * This basic lock ensures we don&#39;t bite our own tail by i=
ssuing a dco_get_peer</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * while still busy receiving and parsing other messages=2E</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-static bool __is_locked =3D false;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /* libnl &lt; 3=2E5=2E0 =
does not set the NLA_F_NESTED on its own, therefore we</span><br><span>  * =
have to explicitly do it to prevent the kernel from failing upon</span><br>=
<span>  * parsing of the message</span><br><span>@@ -170,12 +160,16 @@</spa=
n><br><span>     return ret;</span><br><span> }</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * Drain the request/reply socket=2E Used to =
read command/stats replies=2E This</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * socket is never subscribed to the multicast group, so it =
cannot deliver an</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 asynchronous notification: a reply being parsed here can therefore never</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * trigger an instanc=
e close or a re-entrant request on the same socket=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> static int</span><br=
><span> ovpn_nl_recvmsgs(dco_context_t *dco, const char *prefix)</span><br>=
<span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    __is_lock=
ed =3D true;</span><br><span>     int ret =3D nl_recvmsgs(dco-&gt;nl_sock, =
dco-&gt;nl_cb);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    __=
is_locked =3D false;</span><br><span> </span><br><span>     return ovpn_nl_=
recvmsgs_report(ret, prefix);</span><br><span> }</span><br><span>@@ -1223,1=
2 +1217,6 @@</span><br><span> {</span><br><span>     ASSERT(dco);</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (__is_=
locked)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_DCO_DEBUG, &quot=
;%s: cannot request peer stats while parsing other messages&quot;, __func__=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return 0;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /* peer_id =3D=3D=
 -1 means &quot;dump all peers&quot;, but this is allowed in MP mode only=
=2E</span><br><span>      * If it happens in P2P mode it means that the DCO=
 peer was deleted and we</span><br><span>      * can simply bail out</span>=
<br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1738?usp=3Demail">change 1738</a>=2E To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eo=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1738?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<=
div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Id: I46a9ef71359f42395d69cf899c948014fb72f65a </di=
v>
<div style=3D"display:none"> Gerrit-Change-Number: 1738 </div>
<div styl=
e=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> =
Gerrit-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@ma=
ilbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-deve=
l &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--uOdhYLJCydw=--


--===============9115218649924118052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9115218649924118052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9115218649924118052==--

