Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9051C5DF97
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 06:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jj5bSgqfdTTwQymH0k+wRqo+fc36sZtD0rcOog9bGY4=; b=KVMqGcg9u3kBUbT011J217SK1l
	PbDTPRI1h1+owYPtx/1skIPg9MOAaGfDffVEeGyy4rJ8Y7+xEIJK9cXwmrltHQVUb28BuC724BuQ3
	sVYXoMiuH1TEcsaanbZlyYyiFBs+kpJLyymJkmQXz4D03DYlY+jtcbQEjlK3HUv/ypUM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wz74a-0006mS-9R;
	Wed, 26 Aug 2026 06:25:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wz74Y-0006mL-8v
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 06:25:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=lo0YiapSCJc2G0PCRtNp59SWi1zLT4FGciHHByIT+Q8=; b=I98YpOCBQVHCLZ9/X/eC6MkLeD
 7L0kAe4Hq6krFvjj38C7OOtAX4fT1KBux3OrITFN8hNUZNobvr3ZzVumWqX6uhA1j/q//GS97RtWp
 VwNDHjJLnBm3Q8+kFNZnvKz5q/7ibcT+/phnOlKRr2xd2Zrtvxo0d7OMZ+vBLQEvUM8I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=lo0YiapSCJc2G0PCRtNp59SWi1zLT4FGciHHByIT+Q8=; b=J
 WN5+kpl1RG9XvQCmhMIoAtUxdwwH4oti5+k0piTH8RtQE/CTIxxW23MPJzDQ27qtyeNNtGotXkYjI
 iV22ifSGZsdkqwBfAWbElLLfFHyyhg45G1v3zVdxKjkGvqUHeXOORbTRyErqUgAzH+BKzLIxrrM9O
 kcsu1XSIRcc5Ld0g=;
Received: from mail-ej1-f54.google.com ([209.85.218.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wz74X-00072S-1I for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 06:25:18 +0000
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-c250f28f1cdso75975466b.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 23:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787725510; x=1788330310; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lo0YiapSCJc2G0PCRtNp59SWi1zLT4FGciHHByIT+Q8=;
 b=C8bUW2+LdbWwUKV+aYPBosyFeLwvgIEb4c3w4zU5s5aDMhy4PxWSuC8T1vcLXE78B6
 jtR7MdDc3Vf+lxjYQ+wKbsVK2N83xeGPwlPB6gJqGu5FxrNQ4ZTJgyBodBaM7R3DrYkI
 a9S1ShyOoTKZF6esCfXjGXnq062WFB1ZtM7dsV9PiJ7HBzERvnItUgm3hA5TvBxAzUts
 tUMOyKJIhKcH7l9Bah+yBPvIZnftO+ZS/rk8AVlcfLMtIRWT3+Z99m5/fZiTiEaG+AQ0
 ugo3by9TApe+qglqVmmf01ZFdkN4JdOW3zyFDOF/JCB9wI3EBLZHnLnN3HIFEhUYaoKv
 iXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787725510; x=1788330310;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=lo0YiapSCJc2G0PCRtNp59SWi1zLT4FGciHHByIT+Q8=;
 b=hoFQve94LOCBywVqW0Ia9NpHUt3pUKByWSqcOosAeIbU3AGUX2VwgHj5tIhnE8wePx
 jj+t8WQizZ7spLSlahmfxAXa4O2lTTnFJoBoDb84kxAsJEhvCwoczmDfUTVa8QDucAEI
 jMqLQbx8yDQWgUy4Y2d9//JdPIHkfAGmjkfw4tCppDGq0qJic+fEKCCRCPZne2g7wv1l
 79e0nhzBlDBNhg+37ppTJGKqAPhpTED+nzhZy5D71NFUjeTcC7GJkREMqHLWQeo3tS1A
 RYEsO/oqrNWCWppz54bmuCtK7h8jteWOeRq1USOzc1deoFYdmP6wgUJCA9ZpQxtg+Wmy
 M22w==
X-Gm-Message-State: AFuF++lm13v0G/z9SPy0fE7y33a2iWvPHt6zj9YAF+tWnAZJrINv7I6z
 I9LTIXwdABAmZLU6PF34iv3Q2KNBCfu1zL7Kpb3ny7AToqYQLJJ6O2QLoFIQBBN223S77RlpuFy
 mH42QuKFxwHQblEhB72eu6jSB5RT/3W6+0boXQcdYzB+/frkThS7orFDEespHYs9SqEfx
X-Gm-Gg: AR+sD12yBc/vIKQvthNJzC2IbJcOxxdiLigOvLbE2SLVvHoPUlqlIdhYVK0+NDQv9qR
 tG4nPrKMHWAuTaSsI6phhkUlpz4bxFnGjuthqBNQtHaAkCbjZmIoBJQjOSL2faH/UXQnwiKtcOS
 UP393qx1CKsecRscqkn3VbLR8h8xAT/uuB9V2MKyoLJDA6WeJvnRVP8QdbGUS+NA5lF0yguCelH
 VTHufNR1/VeEEpiznyhza5DQ+FQ0lsU+D6xWdujFX34Micd204v2gLuR2ami1cyJ7xBcO/RM01a
 56iUFO0LuCZRpnqDpk3E6ZAdUmGOkXi9wG+CvGIEkbJ2QeU8edXP3dpvoD+EpsJQws+yy/fY0S4
 yj9vDj7jfnDL/S5AwVOBKGwxwoNIdIj33tFjTsIysnAkVUBHbPhSuqogJK9FGYfNlNdhaE66ffR
 Mb7+b864SLCSQjDwR6feYHiU05NmPIVI2dTw4mriMtUUKLU/Ykiy1Ov+5XbM+QZzJxYdf7L7cXo
 fe0O738nOr8gJMM9C9+9wwkF4o6wLfbVZx+mJxyv/cmF9jL5n7Wkc6+A4j76IoS2GQhSPnbWHoW
 D2xCwvB4LdKCq+qJt+rUYKZC0KhnsHvPd1ljdPsIHE8ee8L1AIw=
X-Received: by 2002:a17:907:7b9b:b0:c24:e1e9:69c with SMTP id
 a640c23a62f3a-c250ba431famr491475366b.0.1787725510253; 
 Tue, 25 Aug 2026 23:25:10 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a5d62easm330390566b.6.2026.08.25.23.25.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 23:25:09 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 26 Aug 2026 06:25:07 +0000
To: razvanc <razvanc@mailbox.org>, plaisthos <arne-openvpn@rfc2549.org>,
 flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I57b4122b292f643ddedd91e81bf95fe2f5b2e03a
X-Gerrit-Change-Number: 1850
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1850?usp=email>
X-Gerrit-Commit: ee3d1df7429486b78445a5caba37f8e16a5ecbd7
In-Reply-To: <gerrit.1787150406000.I57b4122b292f643ddedd91e81bf95fe2f5b2e03a@gerrit.openvpn.net>
References: <gerrit.1787150406000.I57b4122b292f643ddedd91e81bf95fe2f5b2e03a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MTUwNDA2MDAwLkk1N2I0MTIyYjI5MmY2NDNkZGVkZDkxZTgxYmY5NWZlMmY1YjJlMDNhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <daf6dc92ee6bb2f85a259904ecef83c57778f7ad-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wz74X-00072S-1I
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3685267691919127857=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3685267691919127857==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VDL2jyLZ2gs="; charset=UTF-8

--VDL2jyLZ2gs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 razvanc=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1850?usp=3Demail )
=

The following approvals got outdated and were removed:
Code-Review+2 by fl=
ichtenheld


Change subject: doc: Update doxygen references to removed tunn=
el_server_{udp, tcp}()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

doc: Update doxygen references to removed tunnel_server_{udp, tc=
p}()

The point-to-multipoint server event loop is no longer split into
pro=
tocol-specific tunnel_server_udp() and tunnel_server_tcp()
functions; tunne=
l_server() now handles both UDP and TCP=2E

Update the Doxygen module docum=
entation accordingly: list
tunnel_server() as the server-mode event loop im=
plementation, and
rewrite the server-mode startup, initialization and clean=
up sections
so that they describe tunnel_server() instead of the removed
fu=
nctions=2E

Documentation only, no functional change=2E

Change-Id: I57b412=
2b292f643ddedd91e81bf95fe2f5b2e03a
Signed-off-by: Razvan Cojocaru <razvanc@=
mailbox=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
 URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1850
Message-Id: <20260825=
165028=2E9823-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2E=
com/openvpn-devel@lists=2Esourceforge=2Enet/msg38687=2Ehtml
Signed-off-by: =
Gert Doering <gert@greenie=2Emuc=2Ede>
---
M doc/doxygen/doc_eventloop=2Eh
=
M doc/doxygen/doc_tunnel_state=2Eh
2 files changed, 11 insertions(+), 14 de=
letions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/cha=
nges/50/1850/2

diff --git a/doc/doxygen/doc_eventloop=2Eh b/doc/doxygen/do=
c_eventloop=2Eh
index 55ecd73=2E=2E4c1b012 100644
--- a/doc/doxygen/doc_eve=
ntloop=2Eh
+++ b/doc/doxygen/doc_eventloop=2Eh
@@ -60,6 +60,5 @@
  * event =
loop function is called to drive the event processing=2E  The
  * following=
 implementations are available:
  * - Client mode using UDP or TCP: \c tunn=
el_point_to_point()
- * - Server mode using UDP: \c tunnel_server_udp()
- *=
 - Server mode using TCP: \c tunnel_server_tcp()
+ * - Server mode using UD=
P or TCP: \c tunnel_server()
  */
diff --git a/doc/doxygen/doc_tunnel_state=
=2Eh b/doc/doxygen/doc_tunnel_state=2Eh
index 296e804=2E=2E424f81e 100644
-=
-- a/doc/doxygen/doc_tunnel_state=2Eh
+++ b/doc/doxygen/doc_tunnel_state=2E=
h
@@ -117,10 +117,10 @@
  * tunnel_point_to_point() or \c tunnel_server()=
=2E
  *
  * In server-mode, \c main() calls the \c tunnel_server() function=
, which
- * transfers control to \c tunnel_server_udp() or \c
- * tunnel_se=
rver_tcp() depending on the external transport protocol=2E
+ * drives the e=
vent loop for both the UDP and TCP external transport
+ * protocols=2E
  *
=
- * These functions receive the \c context created in \c main()=2E  This
+ =
* This function receives the \c context created in \c main()=2E  This
  * o=
bject has a special status in server-mode, as it does not represent an
  * =
active VPN tunnel, but does contain process-wide configuration
  * paramete=
rs=2E  In the source code, it is often stored in "top" variables=2E
@@ -130=
,11 +130,10 @@
  * CM_CHILD_UDP or \c CM_CHILD_TCP, depending on the extern=
al transport
  * protocol=2E
  *
- * Both \c tunnel_server_udp_single_threa=
ded() and \c tunnel_server_tcp()
- * perform similar initialization=2E  In =
either case, a \c multi_context
- * structure is created, and it is initial=
ized according to the
- * configuration stored in the top \c context by the=
 \c multi_init() and
- * \c multi_top_init() functions=2E
+ * During initia=
lization, \c tunnel_server() creates a \c multi_context
+ * structure, whic=
h is initialized according to the configuration stored
+ * in the top \c co=
ntext by the \c multi_init() and \c multi_top_init()
+ * functions=2E
  *
 =
 * @subsection tunnel_state_server_tunnels Creating and destroying VPN tunn=
els
  *
@@ -146,8 +145,7 @@
  *
  * @subsection tunnel_state_server_cleanup=
 Final cleanup
  *
- * After the main event loop exits, both \c
- * tunnel_=
server_udp_single_threaded() and \c tunnel_server_tcp() perform
- * similar=
 cleanup=2E  They call \c multi_uninit() followed by \c
- * multi_top_free(=
) to clean up the \c multi_context structure=2E
+ * After the main event lo=
op exits, \c tunnel_server() performs the
+ * cleanup=2E  It calls \c multi=
_uninit() followed by \c multi_top_free()
+ * to clean up the \c multi_cont=
ext structure=2E
  */

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1850?usp=3Demail
To unsubscribe, or for help writing mail filters,=
 visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: I57b4122b292f643ddedd91e81bf95fe2f5b2e03a
Gerrit-Change-Number: 1850
G=
errit-PatchSet: 2
Gerrit-Owner: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Revi=
ewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Es=
ourceforge=2Enet>

--VDL2jyLZ2gs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by razvanc=2E<=
/p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1850?usp=3Demail=
">View Change</a></p><p>The following approvals got outdated and were remov=
ed:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">doc: Update doxygen refe=
rences to removed tunnel_server_{udp, tcp}()<br><br>The point-to-multipoint=
 server event loop is no longer split into<br>protocol-specific tunnel_serv=
er_udp() and tunnel_server_tcp()<br>functions; tunnel_server() now handles =
both UDP and TCP=2E<br><br>Update the Doxygen module documentation accordin=
gly: list<br>tunnel_server() as the server-mode event loop implementation, =
and<br>rewrite the server-mode startup, initialization and cleanup sections=
<br>so that they describe tunnel_server() instead of the removed<br>functio=
ns=2E<br><br>Documentation only, no functional change=2E<br><br>Change-Id: =
I57b4122b292f643ddedd91e81bf95fe2f5b2e03a<br>Signed-off-by: Razvan Cojocaru=
 &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lic=
htenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1850<br>Message-Id: &lt;20260825165028=2E9823-1-gert@greenie=2Emuc=2Ede&g=
t;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcefor=
ge=2Enet/msg38687=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2E=
muc=2Ede&gt;<br>---<br>M doc/doxygen/doc_eventloop=2Eh<br>M doc/doxygen/doc=
_tunnel_state=2Eh<br>2 files changed, 11 insertions(+), 14 deletions(-)<br>=
<br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn=
 refs/changes/50/1850/2</pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;"><span>diff --git a/doc/doxygen/doc_eventloop=2Eh =
b/doc/doxygen/doc_eventloop=2Eh</span><br><span>index 55ecd73=2E=2E4c1b012 =
100644</span><br><span>--- a/doc/doxygen/doc_eventloop=2Eh</span><br><span>=
+++ b/doc/doxygen/doc_eventloop=2Eh</span><br><span>@@ -60,6 +60,5 @@</span=
><br><span>  * event loop function is called to drive the event processing=
=2E  The</span><br><span>  * following implementations are available:</span=
><br><span>  * - Client mode using UDP or TCP: \c tunnel_point_to_point()</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * - Server mode using =
UDP: \c tunnel_server_udp()</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * - Server mode using TCP: \c tunnel_server_tcp()</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * - Server mode using UDP or TCP: \c =
tunnel_server()</span><br><span>  */</span><br><span>diff --git a/doc/doxyg=
en/doc_tunnel_state=2Eh b/doc/doxygen/doc_tunnel_state=2Eh</span><br><span>=
index 296e804=2E=2E424f81e 100644</span><br><span>--- a/doc/doxygen/doc_tun=
nel_state=2Eh</span><br><span>+++ b/doc/doxygen/doc_tunnel_state=2Eh</span>=
<br><span>@@ -117,10 +117,10 @@</span><br><span>  * tunnel_point_to_point()=
 or \c tunnel_server()=2E</span><br><span>  *</span><br><span>  * In server=
-mode, \c main() calls the \c tunnel_server() function, which</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * transfers control to \c tunnel_s=
erver_udp() or \c</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * t=
unnel_server_tcp() depending on the external transport protocol=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * drives the event loop for=
 both the UDP and TCP external transport</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * protocols=2E</span><br><span>  *</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * These functions receive the \c contex=
t created in \c main()=2E  This</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * This function receives the \c context created in \c main()=
=2E  This</span><br><span>  * object has a special status in server-mode, a=
s it does not represent an</span><br><span>  * active VPN tunnel, but does =
contain process-wide configuration</span><br><span>  * parameters=2E  In th=
e source code, it is often stored in &quot;top&quot; variables=2E</span><br=
><span>@@ -130,11 +130,10 @@</span><br><span>  * CM_CHILD_UDP or \c CM_CHIL=
D_TCP, depending on the external transport</span><br><span>  * protocol=2E<=
/span><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
 Both \c tunnel_server_udp_single_threaded() and \c tunnel_server_tcp()</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * perform similar initia=
lization=2E  In either case, a \c multi_context</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * structure is created, and it is initialized ac=
cording to the</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * conf=
iguration stored in the top \c context by the \c multi_init() and</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- * \c multi_top_init() function=
s=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * During initi=
alization, \c tunnel_server() creates a \c multi_context</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * structure, which is initialized acc=
ording to the configuration stored</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * in the top \c context by the \c multi_init() and \c multi=
_top_init()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * funct=
ions=2E</span><br><span>  *</span><br><span>  * @subsection tunnel_state_se=
rver_tunnels Creating and destroying VPN tunnels</span><br><span>  *</span>=
<br><span>@@ -146,8 +145,7 @@</span><br><span>  *</span><br><span>  * @subs=
ection tunnel_state_server_cleanup Final cleanup</span><br><span>  *</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * After the main event loop=
 exits, both \c</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * tun=
nel_server_udp_single_threaded() and \c tunnel_server_tcp() perform</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * similar cleanup=2E  They c=
all \c multi_uninit() followed by \c</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * multi_top_free() to clean up the \c multi_context structu=
re=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * After the m=
ain event loop exits, \c tunnel_server() performs the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * cleanup=2E  It calls \c multi_uninit()=
 followed by \c multi_top_free()</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * to clean up the \c multi_context structure=2E</span><br><sp=
an>  */</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1850?usp=3Demail">change 1850</a>=2E T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscop=
e itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" =
href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1850?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"disp=
lay:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:non=
e"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bran=
ch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I57b4122b2=
92f643ddedd91e81bf95fe2f5b2e03a </div>
<div style=3D"display:none"> Gerrit-=
Change-Number: 1850 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 =
</div>
<div style=3D"display:none"> Gerrit-Owner: razvanc &lt;razvanc@mailb=
ox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenh=
eld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esour=
ceforge=2Enet&gt; </div>

</body></html>
--VDL2jyLZ2gs=--


--===============3685267691919127857==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3685267691919127857==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3685267691919127857==--

