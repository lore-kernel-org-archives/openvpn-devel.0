Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98647C61DBD
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 06:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RNi+uhIr1ke3yqL7UikiCESqGxGSpGS82qoilfdWaYI=; b=Nv5A2f2P++jjUMJNyOv+mT2HuX
	7MMI8rlaYxuC43I/6yyRoJIIav8Rx34xAuVE/QJSSDVBeyROP2Z3erzmnnv6ptiOHyupvFYygL0nl
	xTyFc609Fyh5EANATxZhgrl/+yRdPm2NqPMaTeF9h/m/6BSIH5sIOFBki6wwclJzgeKQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wz74d-0001TD-Lm;
	Wed, 26 Aug 2026 06:25:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wz74c-0001T6-5A
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 06:25:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ttf8/fTXT9oTzrPQwDuTTDN+SbfT9xIaInNiaOXbYUY=; b=LmGpQamotHOOCQjNC4NlKjy0On
 rO6N/C7X3623JlCyWn0TcLjKB4nKZpLg/CfyzUrRoMiDq+b9nmER9uEe+LooeHREtWIRvAkeTUWT5
 ljfaTukCVeYttYlyUMmggAxwDeX3CxXmMQWIt+RpZWufN0mmR8tuOAMQaJ/wC1sPi824=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ttf8/fTXT9oTzrPQwDuTTDN+SbfT9xIaInNiaOXbYUY=; b=H
 bhVWKl8oMeFkNTO70u44Q3wLeNqw1jQXDQIDBB9kQejgKc6E+Er2NxIEqsr22wVoXa9Sn4OJRSL4P
 YFrbI61VYEobiK3X4y3EveMRLDgsn3Z3ZJ+NCXccv2G5DIGsOQY8LSs6jQSh1hiP1pysIzrmFmlwO
 WMbS8XXVUmwIesOc=;
Received: from mail-ed1-f41.google.com ([209.85.208.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wz74X-0006vV-UQ for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 06:25:19 +0000
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-6a082b3671fso856214a12.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 23:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787725511; x=1788330311; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ttf8/fTXT9oTzrPQwDuTTDN+SbfT9xIaInNiaOXbYUY=;
 b=Y++ZXhjG8NOHLv3cLgr42xJZkuEx35/hCGm3pQXtnmLSn2tg4BQZ40HH+4LJQ3wiVI
 KODfeVfzZq6Q8kkMQpUwLxjyou+aSGdTzJRu70kDGRIPVuaEZeW/CKJNr2QfGRXvoHeQ
 SrUwUn+ZC1EMPtxZ/Hdiv4HnSnog+HCOeBGzN+2nGJBmQhBLavRhl5SWpZ/EauspRnaA
 PXbLvjU33Lzcj3JYz3vhBFK/k3UyUWT+ENymfJh8CGzEcPuVvCs6piL/BKlillvCyY9e
 67FyIFvr3+twD6Cf+hmYArDfRd/06MaKXJlEMqKijpxneDr8FqHhNCJrahMsFP02/YME
 6qQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787725511; x=1788330311;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ttf8/fTXT9oTzrPQwDuTTDN+SbfT9xIaInNiaOXbYUY=;
 b=Psr545YYBJ1C9BwCUw49DvrloWz0/Y1LBtxQloTUwlpu+9nR1wyQ4euR8SKkWvMV2E
 zHOfQPv2mu+cTSXUEQnqWHzZzEFkqVKx/RE7FaS2mWN2CN+DFFK4SmxXBytpxnyX56Wr
 2kj5bAlI2EHN0PFNOcmwsrAqcO3ZiTdB74i7tI7Ygeedxh/4VcHf180Elhcn7qM7PR0n
 ebFR7rBcx3LVVxbQYoB2pzJaexY4Pm5DROLPze09NUsdC+TpLkvJR8QBJl2Y4w7QRH74
 PEwu+7n8KY3DSDc5RkyUWt1gZvV09n8LCUFs1ICeZRWKuf2ay9hyS9DM9dM3ZAKEDOpy
 u/Cw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqpAX3RBkGMq1utIgZzzqryQsJOv9lz46ogVU4ER8z6FYbyPNsl0cc06BPvyEu/fn/DHDMTVGtiKYJgk47H@lists.sourceforge.net
X-Gm-Message-State: AFuF++l2aM7ffxbRjXzMx5mcxzM0eEn3SlxNzhW+GEVPyV7/ciELQVRp
 CItIxtf0qO8D6oUqhHmiKhnJFGxpe52fNb7acUNHEdtUj4Rp5xLzkf8+Ksiv+G6HXHeTzSO8AF5
 t9cIN8+dBV6wKzE5XewhhrzDcMvMOPl1hcyf/MVbLLRbCrSuCw4KMi+UdIMAvO22aXEY1
X-Gm-Gg: AR+sD13dCJwP/B1wBmdGeNrNs3Zl2n0qrnuJ8unbv/pIs76lWZiDavpudrUHtdh4th6
 tL+HCybp8YMSwcbMMkkVhVuwnRTGSNBT5mnzagksMK4o261lwjC0ZWDVk3FftF+0U2AHEfcUz8t
 t65Ky4auqy8QJ7iv8cNo0oetgNQZuVYJfUEymg8rMmZLihr7WnMLopB+m+IZ7HPQU8FgEWUE5dM
 yvKKRJijFDcgwfyOSFL68/m47rgyXAbTN17y+mlsjcflcRMZB2wsRKZUktZSgBdD/zyNNBO+R8W
 XXK1EOY4/hHGDg2bAQUkPKrbsh9NduNCnxL1nmn4X3aCdrNsS9r9XE1IXlOFDt9Sv3QNHe/U+8G
 61VHp2IA/7bj4Q+prnC1QwUUf/6cfeYWfiGLif/v/bcMbbyaS6yhcwkmRnr81Hk+F58n468q7L5
 nVU9UeYhW/3M3O2HqiDCp2mKJOM84serDZM6J00PwJg2ad2PyXl27H9iO/5B9A7h6cd9GgIeaqq
 LY0p7dRWal+Zs8eAPFnZuzL858CZw4VdGPsCVWGeu65ffZIYQU9QKCdZFb39smp9UxKlKRI1yew
 dL6FtFNszPkx/qD1eGTAwZaPcZKQQcMcz9oorQPOXxwEhrC8TpCMtRO3Y+yC2g==
X-Received: by 2002:a17:907:1907:b0:c20:23f8:99a5 with SMTP id
 a640c23a62f3a-c250c2e9dd9mr512646366b.15.1787725511242; 
 Tue, 25 Aug 2026 23:25:11 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a88ae4dsm423111566b.39.2026.08.25.23.25.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 23:25:10 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 26 Aug 2026 06:25:10 +0000
To: razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I57b4122b292f643ddedd91e81bf95fe2f5b2e03a
X-Gerrit-Change-Number: 1850
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1850?usp=email>
X-Gerrit-Commit: ee3d1df7429486b78445a5caba37f8e16a5ecbd7
In-Reply-To: <gerrit.1787150406000.I57b4122b292f643ddedd91e81bf95fe2f5b2e03a@gerrit.openvpn.net>
References: <gerrit.1787150406000.I57b4122b292f643ddedd91e81bf95fe2f5b2e03a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MTUwNDA2MDAwLkk1N2I0MTIyYjI5MmY2NDNkZGVkZDkxZTgxYmY5NWZlMmY1YjJlMDNhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <daf6dc92ee6bb2f85a259904ecef83c57778f7ad-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wz74X-0006vV-UQ
Subject: [Openvpn-devel] [S] Change in openvpn[master]: doc: Update doxygen
 references to removed tunnel_server_{udp, tcp}()
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0111413540316897627=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0111413540316897627==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bQjJaC1bemc="; charset=UTF-8

--bQjJaC1bemc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1850?usp=3Demail )

Change subject: doc: Update doxygen references to r=
emoved tunnel_server_{udp, tcp}()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

doc: Update doxygen references to removed tunnel_ser=
ver_{udp, tcp}()

The point-to-multipoint server event loop is no longer sp=
lit into
protocol-specific tunnel_server_udp() and tunnel_server_tcp()
func=
tions; tunnel_server() now handles both UDP and TCP=2E

Update the Doxygen =
module documentation accordingly: list
tunnel_server() as the server-mode e=
vent loop implementation, and
rewrite the server-mode startup, initializati=
on and cleanup sections
so that they describe tunnel_server() instead of th=
e removed
functions=2E

Documentation only, no functional change=2E

Change=
-Id: I57b4122b292f643ddedd91e81bf95fe2f5b2e03a
Signed-off-by: Razvan Cojoca=
ru <razvanc@mailbox=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1850
Message=
-Id: <20260825165028=2E9823-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Em=
ail-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38687=2Ehtml
S=
igned-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M doc/doxygen/doc_=
eventloop=2Eh
M doc/doxygen/doc_tunnel_state=2Eh
2 files changed, 11 insert=
ions(+), 14 deletions(-)




diff --git a/doc/doxygen/doc_eventloop=2Eh b/d=
oc/doxygen/doc_eventloop=2Eh
index 55ecd73=2E=2E4c1b012 100644
--- a/doc/do=
xygen/doc_eventloop=2Eh
+++ b/doc/doxygen/doc_eventloop=2Eh
@@ -60,6 +60,5 =
@@
  * event loop function is called to drive the event processing=2E  The
=
  * following implementations are available:
  * - Client mode using UDP or=
 TCP: \c tunnel_point_to_point()
- * - Server mode using UDP: \c tunnel_ser=
ver_udp()
- * - Server mode using TCP: \c tunnel_server_tcp()
+ * - Server =
mode using UDP or TCP: \c tunnel_server()
  */
diff --git a/doc/doxygen/doc=
_tunnel_state=2Eh b/doc/doxygen/doc_tunnel_state=2Eh
index 296e804=2E=2E424=
f81e 100644
--- a/doc/doxygen/doc_tunnel_state=2Eh
+++ b/doc/doxygen/doc_tu=
nnel_state=2Eh
@@ -117,10 +117,10 @@
  * tunnel_point_to_point() or \c tunn=
el_server()=2E
  *
  * In server-mode, \c main() calls the \c tunnel_server=
() function, which
- * transfers control to \c tunnel_server_udp() or \c
- =
* tunnel_server_tcp() depending on the external transport protocol=2E
+ * d=
rives the event loop for both the UDP and TCP external transport
+ * protoc=
ols=2E
  *
- * These functions receive the \c context created in \c main()=
=2E  This
+ * This function receives the \c context created in \c main()=2E=
  This
  * object has a special status in server-mode, as it does not repre=
sent an
  * active VPN tunnel, but does contain process-wide configuration
=
  * parameters=2E  In the source code, it is often stored in "top" variable=
s=2E
@@ -130,11 +130,10 @@
  * CM_CHILD_UDP or \c CM_CHILD_TCP, depending o=
n the external transport
  * protocol=2E
  *
- * Both \c tunnel_server_udp_=
single_threaded() and \c tunnel_server_tcp()
- * perform similar initializa=
tion=2E  In either case, a \c multi_context
- * structure is created, and i=
t is initialized according to the
- * configuration stored in the top \c co=
ntext by the \c multi_init() and
- * \c multi_top_init() functions=2E
+ * D=
uring initialization, \c tunnel_server() creates a \c multi_context
+ * str=
ucture, which is initialized according to the configuration stored
+ * in t=
he top \c context by the \c multi_init() and \c multi_top_init()
+ * functi=
ons=2E
  *
  * @subsection tunnel_state_server_tunnels Creating and destroy=
ing VPN tunnels
  *
@@ -146,8 +145,7 @@
  *
  * @subsection tunnel_state_se=
rver_cleanup Final cleanup
  *
- * After the main event loop exits, both \c=

- * tunnel_server_udp_single_threaded() and \c tunnel_server_tcp() perform=

- * similar cleanup=2E  They call \c multi_uninit() followed by \c
- * mul=
ti_top_free() to clean up the \c multi_context structure=2E
+ * After the m=
ain event loop exits, \c tunnel_server() performs the
+ * cleanup=2E  It ca=
lls \c multi_uninit() followed by \c multi_top_free()
+ * to clean up the \=
c multi_context structure=2E
  */

-- 
To view, visit http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1850?usp=3Demail
To unsubscribe, or for help writing m=
ail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerr=
it-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: I57b4122b292f643ddedd91e81bf95fe2f5b2e03a
Gerrit-Change-Number:=
 1850
Gerrit-PatchSet: 2
Gerrit-Owner: razvanc <razvanc@mailbox=2Eorg>
Gerr=
it-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaist=
hos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>

--bQjJaC1bemc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1850?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">doc: Update doxygen references to removed =
tunnel_server_{udp, tcp}()<br><br>The point-to-multipoint server event loop=
 is no longer split into<br>protocol-specific tunnel_server_udp() and tunne=
l_server_tcp()<br>functions; tunnel_server() now handles both UDP and TCP=
=2E<br><br>Update the Doxygen module documentation accordingly: list<br>tun=
nel_server() as the server-mode event loop implementation, and<br>rewrite t=
he server-mode startup, initialization and cleanup sections<br>so that they=
 describe tunnel_server() instead of the removed<br>functions=2E<br><br>Doc=
umentation only, no functional change=2E<br><br>Change-Id: I57b4122b292f643=
ddedd91e81bf95fe2f5b2e03a<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mai=
lbox=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&g=
t;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1850<br>Messag=
e-Id: &lt;20260825165028=2E9823-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https=
://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg3868=
7=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>=
---<br>M doc/doxygen/doc_eventloop=2Eh<br>M doc/doxygen/doc_tunnel_state=2E=
h<br>2 files changed, 11 insertions(+), 14 deletions(-)<br><br></pre>
<pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>di=
ff --git a/doc/doxygen/doc_eventloop=2Eh b/doc/doxygen/doc_eventloop=2Eh</s=
pan><br><span>index 55ecd73=2E=2E4c1b012 100644</span><br><span>--- a/doc/d=
oxygen/doc_eventloop=2Eh</span><br><span>+++ b/doc/doxygen/doc_eventloop=2E=
h</span><br><span>@@ -60,6 +60,5 @@</span><br><span>  * event loop function=
 is called to drive the event processing=2E  The</span><br><span>  * follow=
ing implementations are available:</span><br><span>  * - Client mode using =
UDP or TCP: \c tunnel_point_to_point()</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- * - Server mode using UDP: \c tunnel_server_udp()</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * - Server mode using TCP: \=
c tunnel_server_tcp()</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * - Server mode using UDP or TCP: \c tunnel_server()</span><br><span>  *=
/</span><br><span>diff --git a/doc/doxygen/doc_tunnel_state=2Eh b/doc/doxyg=
en/doc_tunnel_state=2Eh</span><br><span>index 296e804=2E=2E424f81e 100644</=
span><br><span>--- a/doc/doxygen/doc_tunnel_state=2Eh</span><br><span>+++ b=
/doc/doxygen/doc_tunnel_state=2Eh</span><br><span>@@ -117,10 +117,10 @@</sp=
an><br><span>  * tunnel_point_to_point() or \c tunnel_server()=2E</span><br=
><span>  *</span><br><span>  * In server-mode, \c main() calls the \c tunne=
l_server() function, which</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * transfers control to \c tunnel_server_udp() or \c</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * tunnel_server_tcp() depending on the=
 external transport protocol=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * drives the event loop for both the UDP and TCP external tran=
sport</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * protocols=
=2E</span><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- * These functions receive the \c context created in \c main()=2E  This</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This function rece=
ives the \c context created in \c main()=2E  This</span><br><span>  * objec=
t has a special status in server-mode, as it does not represent an</span><b=
r><span>  * active VPN tunnel, but does contain process-wide configuration<=
/span><br><span>  * parameters=2E  In the source code, it is often stored i=
n &quot;top&quot; variables=2E</span><br><span>@@ -130,11 +130,10 @@</span>=
<br><span>  * CM_CHILD_UDP or \c CM_CHILD_TCP, depending on the external tr=
ansport</span><br><span>  * protocol=2E</span><br><span>  *</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * Both \c tunnel_server_udp_single_t=
hreaded() and \c tunnel_server_tcp()</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * perform similar initialization=2E  In either case, a \c m=
ulti_context</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * struct=
ure is created, and it is initialized according to the</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * configuration stored in the top \c cont=
ext by the \c multi_init() and</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * \c multi_top_init() functions=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * During initialization, \c tunnel_server() creat=
es a \c multi_context</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * structure, which is initialized according to the configuration stored<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * in the top \c con=
text by the \c multi_init() and \c multi_top_init()</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * functions=2E</span><br><span>  *</span=
><br><span>  * @subsection tunnel_state_server_tunnels Creating and destroy=
ing VPN tunnels</span><br><span>  *</span><br><span>@@ -146,8 +145,7 @@</sp=
an><br><span>  *</span><br><span>  * @subsection tunnel_state_server_cleanu=
p Final cleanup</span><br><span>  *</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * After the main event loop exits, both \c</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * tunnel_server_udp_single_threaded() =
and \c tunnel_server_tcp() perform</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * similar cleanup=2E  They call \c multi_uninit() followed by=
 \c</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * multi_top_free(=
) to clean up the \c multi_context structure=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * After the main event loop exits, \c tunnel_s=
erver() performs the</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * cleanup=2E  It calls \c multi_uninit() followed by \c multi_top_free()<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * to clean up the \=
c multi_context structure=2E</span><br><span>  */</span><br><span></span><b=
r></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1850?usp=3Demail">change 1850</a>=2E To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1850?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<=
div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Id: I57b4122b292f643ddedd91e81bf95fe2f5b2e03a </di=
v>
<div style=3D"display:none"> Gerrit-Change-Number: 1850 </div>
<div styl=
e=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> =
Gerrit-Owner: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openv=
pn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></h=
tml>
--bQjJaC1bemc=--


--===============0111413540316897627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0111413540316897627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0111413540316897627==--

