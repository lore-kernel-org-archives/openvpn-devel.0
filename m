Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FD2606A330
	for <openvpn-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=al05Bqeo;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=idjLQPvQ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ZtjmKxwq;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=LEkmpj95
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=g63JR0qwuI51u8gwfvYEJ8qcpITqdCWrDOWpqWJ+m5I=; b=al05BqeoNoee6IeoXgmTlmrHSq
	/wTgFssnaYQLEpgc0AQqB8DWglrhDL4w3CC5sba+i/s5mOxLxoExhQdV66Z1I0Ktqcf9vh5ga5+nw
	/wm18U6QupFYvOw+TWHr15wppLQVVShBWU7jplZlwwtRI+7cWG+EKSVO+G3H9fmqu+b0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSGcc-0000000044b-1Zdp;
	Sat, 14 Nov 2026 16:28:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSGca-0000000044R-2SmZ
 for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 16:28:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zpP2wYNNbgJaoslF/TkAiAyWxUtQZmKde/gUbLXJio0=; b=idjLQPvQDhir3Z3Q/XJNA838n4
 42unc+0gRXqyJR37H9kyPOZNASDO6cdgZlsqT67L9MI79WwSsBn3KnlDea/4w5atYhj01i68jpniT
 Cdds4LeICODqgUeYDDJdESBytQSXOv/7T0RjPidEy5pZTTsmJiTh5DQoWKLn6Fiq3siw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zpP2wYNNbgJaoslF/TkAiAyWxUtQZmKde/gUbLXJio0=; b=ZtjmKxwqzV+rVksX/YOAkTQraP
 yHlSGcz//7mfifhRNiyNlE4rjanFP1MO351cXEKc2IXNUX3KD1SpUSvvASDtyvEeQ5UKMS4beZITq
 fVpsqUOH3LMBHzdcEHG+HAjtq309iagdXtavg927etaTsI/EKUEPUkJ38UHEg9Q5pH84=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSGcZ-0000000013W-38os for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 16:28:56 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so24697555e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 14 Nov 2026 08:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794673729; x=1795278529; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zpP2wYNNbgJaoslF/TkAiAyWxUtQZmKde/gUbLXJio0=;
 b=LEkmpj95ue/TgnbcQSXEHhzEubq9pNBK63Sm85gVQotB+luxTBRi24n01cmb4mP7Q3
 RXhV9tN6Kp6XoBJOqrTrtq/kLSVUR/lXBpUiKNYGfcF4p4a4fwhWsv/q0Ht6cXrcCORu
 NR1daszLtmZpKCe59oK04wMD/zlNdPTAsaDPOfxlt+M8NQz3/rLfZ7cjD7/dTDi26/v+
 Ou2mqm8ARMJh3UFuAHfnycmNDVcjs1NzvfjOTw2cPRmEptUzVd6tMNoueg7BQ7dg0Eyv
 sqp3OAW/bktuSktFKqN0/rnBnPLuZvi+4qp47UmM8cOp+xTzLReZCIucleG5twmZPtkU
 n3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794673729; x=1795278529;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zpP2wYNNbgJaoslF/TkAiAyWxUtQZmKde/gUbLXJio0=;
 b=vAMN8nFFqndSu16+xDvFBZVO77gRJHBt27fonj9fvDYQsxefc4oazf4EECzcGZ++m1
 lxp05Q4l4pQ53aKlsWd+RZ1V6diVDbPK5LsO66RUkp4HVrdjqW1GdqMGwzotvWRWAQw3
 E26pxXfINblvcdAgn0V4+Cil92mKRCK7Zf5pLqgiOBlftnUKRaFD3/H3iUAcX6bx6eXU
 yq44OciFafEE0xbswlXKkc+/jbNZDSNb1iVBMYLfsNN7dpJNnCOJ+tHJtdF42YPTiGjY
 T0DUREYN5UT/bhZJO5SIyXE3BC+hyfU3eBjRfBSiamrBrsvFcCYkhS0pK04NP4STvd+R
 sEFA==
X-Gm-Message-State: APuU4Z8M5xk/vyUyFz9wx8y+W8M1dWygcHvxRSqauWmWX2jS94GXG9Jm
 c6k1XAxmshQJ6KT6scyZRvL3wRTx3FoUSDujCEmtons1mOiu95F8k84YayZxX3MqqTmV0v/7ed6
 lGgaaIaxMl4u3rfhqcTU7JR4JuqCMomDni8vdtsn19Gzodz8u1dDsldhC8SFziD0m4DAr
X-Gm-Gg: AYBFou1yaFZeNFLIdujgZqmVigyN0hE73V85Pekt7wKSNfaQR+hbYOnPCLWa50y74pI
 AQChVSJGk9dWvTMcFBcGcOlQSeieIuoZp/ZiA9KXhGlKUy3DrPq4z6LgqtavDuhaSjm/lhzYrdw
 HnZhIou/QlkOu42MGWY9HkPhIMXkfjqeODpH/O0IDet6qHkLGYbaHMEl+LhBNxx7Byy8JJB52ek
 hFGqR44jXaNQ50hGG5Be9aeWMT6T/QhnYnYxElBpoZEKXjUZd8USaQYS0y2M2Ru9FmdVczC+8Pc
 A0mR8UoBylBfUWXEypp1qYwZMYyyBYFTufWN3w9dtYvZsabksJNwGx9w6OhU5s5CsPTvszJF+7G
 0TgWaXsQ+KDDlxqMR4wO7h67jARhJwZrsTrMftYNnLKLnGQ1Om2jGMjMi46vLlie/YEmfvBBkZm
 AE4RuzRKR32YpSZdljrKhmioPm5fyBAlB4vTHUo3NAC4yW5758jHcrYv0Q66+c3tiwnzrEwiK7E
 m/c/7mom/imLNb8MDvwrCtSeN/E+Y2iBkx01S+0nILXeA4dBgR+qcKRDw4v4og6xbEDaJ835BR/
 4LBp0N7tWTgRW8bmH6AokLEwTBzcrg/Q0sKtrALVEPvGZbZ8PPdUBr0HsBQxX3DtNen9I51bZLI
 iqVAoNf9qdKarZBLGLoFv2RD2EIaYxIFUW6pdNP2slecA2fywDGcdkwYvYOQPzPCxF9nJqOjPpO
 l3gYNMCS4NUS0CskK2NkhDewyRMbAwunYA4jAL
X-Received: by 2002:a05:600c:46d5:b0:4a3:5991:718 with SMTP id
 5b1f17b1804b1-4bb55a82b16mr127893885e9.16.1794673729048; 
 Sat, 14 Nov 2026 08:28:49 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55ae501bsm164252045e9.10.2026.11.14.08.28.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 08:28:48 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 14 Nov 2026 16:28:47 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I766eff47993375c80895755355919ede11b488db
X-Gerrit-Change-Number: 2124
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2124?usp=email>
X-Gerrit-Commit: 0525e796787bc8414af0c3fa79492f73dc00c26e
In-Reply-To: <gerrit.1793779688000.I766eff47993375c80895755355919ede11b488db@gerrit.openvpn.net>
References: <gerrit.1793779688000.I766eff47993375c80895755355919ede11b488db@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzc5Njg4MDAwLkk3NjZlZmY0Nzk5MzM3NWM4MDg5NTc1NTM1NTkxOWVkZTExYjQ4OGRiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cf5f3fdd4737943907426d73134bf2ed1cf4efb7-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSGcZ-0000000013W-38os
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: tun: make
 delete_route_connected_v6_net() and create_arbitrary_remote...
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7588231956796661389=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7588231956796661389==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="L3LgIqmpLXI="; charset=UTF-8

--L3LgIqmpLXI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2124?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Frank Lichtenheld


Change subject: tun: make delete_rou=
te_connected_v6_net() and create_arbitrary_remote() static
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

tun: make delete_route_conne=
cted_v6_net() and create_arbitrary_remote() static

Neither is used outside=
 tun=2Ec or declared in a header=2E

create_arbitrary_remote() has had no F=
reeBSD/DragonFly caller since
94db3261 ("FreeBSD: for topology subnet, put =
tun interface into
IFF_BROADCAST mode"), so limit it to NetBSD and OpenBSD =
to avoid an
unused static function there=2E

Change-Id: I766eff47993375c808=
95755355919ede11b488db
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eor=
g>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2124
Message-Id: <20261104124915=2E184=
63-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn=
-devel@lists=2Esourceforge=2Enet/msg40729=2Ehtml
Signed-off-by: Gert Doerin=
g <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/tun=2Ec
1 file changed, 3 ins=
ertions(+), 4 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/=
openvpn refs/changes/24/2124/2

diff --git a/src/openvpn/tun=2Ec b/src/open=
vpn/tun=2Ec
index 1ae19eb=2E=2E70fdd7e 100644
--- a/src/openvpn/tun=2Ec
+++=
 b/src/openvpn/tun=2Ec
@@ -1000,7 +1000,7 @@
     add_route_ipv6(&r6, tt, 0=
, es, NULL);
 }
 
-void
+static void
 delete_route_connected_v6_net(const s=
truct tuntap *tt)
 {
     struct route_ipv6 r6;
@@ -1017,8 +1017,7 @@
 #end=
if /* if defined(_WIN32) || defined(TARGET_DARWIN) || defined(TARGET_NETBSD=
) || \
           defined(TARGET_OPENBSD) */
 
-#if defined(TARGET_FREEBSD)=
 || defined(TARGET_DRAGONFLY) || defined(TARGET_NETBSD) \
-    || defined(T=
ARGET_OPENBSD)
+#if defined(TARGET_NETBSD) || defined(TARGET_OPENBSD)
 /* w=
e can't use true subnet mode on tun on all platforms, as that
  * conflicts=
 with IPv6 (wants to use ND then, which we don't do),
  * but the OSes want=
 "a remote address that is different from ours"
@@ -1028,7 +1027,7 @@
  * i=
s still point to point and no layer 2 resolution is done=2E=2E=2E
  */
 
-i=
n_addr_t
+static in_addr_t
 create_arbitrary_remote(const struct tuntap *tt=
)
 {
     in_addr_t remote;

-- 
To view, visit https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2124?usp=3Demail
To unsubscribe, or for help writing mail f=
ilters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-M=
essageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerri=
t-Change-Id: I766eff47993375c80895755355919ede11b488db
Gerrit-Change-Number=
: 2124
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailb=
ox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>

--L3LgIqmpLXI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2124?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Frank Lichtenheld</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">tun: make delete_route_connected_v6_net() and create_arbitrary_remote()=
 static<br><br>Neither is used outside tun=2Ec or declared in a header=2E<b=
r><br>create_arbitrary_remote() has had no FreeBSD/DragonFly caller since<b=
r>94db3261 (&quot;FreeBSD: for topology subnet, put tun interface into<br>I=
FF_BROADCAST mode&quot;), so limit it to NetBSD and OpenBSD to avoid an<br>=
unused static function there=2E<br><br>Change-Id: I766eff47993375c808957553=
55919ede11b488db<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eor=
g&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Ger=
rit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2124<br>Message-Id: &lt=
;20261104124915=2E18463-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40729=2Eht=
ml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br=
>M src/openvpn/tun=2Ec<br>1 file changed, 3 insertions(+), 4 deletions(-)<b=
r><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openv=
pn refs/changes/24/2124/2</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/src/openvpn/tun=2Ec b/src/op=
envpn/tun=2Ec</span><br><span>index 1ae19eb=2E=2E70fdd7e 100644</span><br><=
span>--- a/src/openvpn/tun=2Ec</span><br><span>+++ b/src/openvpn/tun=2Ec</s=
pan><br><span>@@ -1000,7 +1000,7 @@</span><br><span>     add_route_ipv6(&am=
p;r6, tt, 0, es, NULL);</span><br><span> }</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+static void</span><br><span> delete_route_connected=
_v6_net(const struct tuntap *tt)</span><br><span> {</span><br><span>     st=
ruct route_ipv6 r6;</span><br><span>@@ -1017,8 +1017,7 @@</span><br><span> =
#endif /* if defined(_WIN32) || defined(TARGET_DARWIN) || defined(TARGET_NE=
TBSD) || \</span><br><span>           defined(TARGET_OPENBSD) */</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(TA=
RGET_FREEBSD) || defined(TARGET_DRAGONFLY) || defined(TARGET_NETBSD) \</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    || defined(TARGET_OPEN=
BSD)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(TAR=
GET_NETBSD) || defined(TARGET_OPENBSD)</span><br><span> /* we can&#39;t use=
 true subnet mode on tun on all platforms, as that</span><br><span>  * conf=
licts with IPv6 (wants to use ND then, which we don&#39;t do),</span><br><s=
pan>  * but the OSes want &quot;a remote address that is different from our=
s&quot;</span><br><span>@@ -1028,7 +1027,7 @@</span><br><span>  * is still =
point to point and no layer 2 resolution is done=2E=2E=2E</span><br><span> =
 */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
in_addr_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static in_=
addr_t</span><br><span> create_arbitrary_remote(const struct tuntap *tt)</s=
pan><br><span> {</span><br><span>     in_addr_t remote;</span><br></pre><p>=
To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2124?u=
sp=3Demail">change 2124</a>=2E To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail"=
>settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vi=
ewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2124?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchse=
t </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div s=
tyle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:n=
one"> Gerrit-Change-Id: I766eff47993375c80895755355919ede11b488db </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Number: 2124 </div>
<div style=3D"=
display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerri=
t-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>

</body></html>
--L3LgIqmpLXI=--


--===============7588231956796661389==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7588231956796661389==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7588231956796661389==--

