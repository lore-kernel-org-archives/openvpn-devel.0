Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E177C61DBC
	for <openvpn-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fwXEvC93RvJYsSLub0YTwekR4VK0V+CPuy588oPDufY=; b=TIRRzVJWNpLMJ7k6rX+573p9FX
	o+xhhLtKUXzNh08aVik52KKVQHaXfsMS38o8Z83o9gg+VQ28rNiBOjDIIKzHfiXPwgBo4zCtKmCMD
	Q0vbd8ECD4RdVXZcuGA5GFGMQXuwWoNRLGWyk8L4HTOdqYE+rSeMq0dY2weQDx7j6es8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyldM-000459-EN;
	Tue, 25 Aug 2026 07:31:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wyldJ-00044r-0k
 for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 07:31:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=zB97jj0+oL9/J/xUYeCFlAZ/SZGFPmtTQujSg1XfHVM=; b=Rx+c9t/8k8RdNW/Inb7zKI4dJA
 5SuOoGa8Z6mQWJ7sYL6nbVNXtflYVGysCmDVLqzexJUSMdxK9X4p343WimdBEHqWViH1UOotocz07
 f7zLhZeKWY+idoqm7OPQQUs+33NETZhmAzpRrIlfxXcnI6i5hQZB2iqxdYb2Gr11vTc8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=zB97jj0+oL9/J/xUYeCFlAZ/SZGFPmtTQujSg1XfHVM=; b=k
 62vxZ+5RjFAoxWkRdiv22IHwhY3+8/NiUjBW2k7AECP7imSS24zk9XCzwOOs1292JZzZVOc/Rjm7R
 8KZEUdYOzhSxC2zd/Y4bjSvycv/NlM6micA38TkAjf9NDG/QYsLTRTBtoLOE1DP94O8jxHF60dMk2
 U/dk6F220eSVx2pY=;
Received: from mail-ed1-f46.google.com ([209.85.208.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wylcz-0000LE-0L for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 07:31:26 +0000
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-6a157f90752so7375080a12.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 00:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787643078; x=1788247878; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zB97jj0+oL9/J/xUYeCFlAZ/SZGFPmtTQujSg1XfHVM=;
 b=b4o7dWjWDdsyRiZE1XDoyJRoDmjyGiK9FJ8NWRYBrfGde7Q+Q0wl9cHOKwrriI7QhQ
 oZzrZEvy808T3xf8HV1O3cn1ZzCVtboAR4LaMOS3hyfNEEeeGLd4oRL1BYJuY3ZSud+A
 xHmKQLiSM12eCyR6bf196yayGUHfHAc9NCOKHJPaPV2vm/hfo5H7rqPHjjNF9JOmkj9q
 MFyBIM89yE2VwmPiU+gVcDuZO8o68U3kY3d73PRWqbxShWtWdme0yK/J9o/5fF/WmT7b
 8sJrLjltUx1eKaiN/a4K+PdIFdLVZxYRorLXA+ZCT7Jm5evQwfarwm9cqWcYjGIPJAwq
 4Vzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787643078; x=1788247878;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zB97jj0+oL9/J/xUYeCFlAZ/SZGFPmtTQujSg1XfHVM=;
 b=JgPy+yNzRxbh+IIfV093h7LDWRTC0vkB0kB8rWqMBbX78qXYg8FMILk74lp3yJMbto
 il9eojMIcLeDZ8CBhvCww1uzOF+UjSa5Mo4Y7dd7o5vJwjUnf+ZWgoyynmzX9RSnJYDk
 LKkBs5VtZEPpESI0B5LjxVTJrG6nNC6TgpEh7G2V0r0FBnyAfW59ccHgbdW+LU3a5Z76
 qUzJ0P32mGwWS6bqJ6UnPgZyWcqqPT7FDeHptUNyl8D60C+z1jpfSh2lXjMaNI7lyDPm
 +tnlc026tFESpKnD1/vrJFl9sesHJIECiaZz/VBeatbH3ipXLn+LZ97TdRNPQ9GqS6g/
 lSFA==
X-Gm-Message-State: AFuF++kGS2rxEbuiv+BLFNoatc7xTZvWp315+xkYahksNXaFO3HcDXGx
 ZKpYP5GAUCLpj0cczWvuFS4T+xHRWn932z8w0Uf+MjCmAE/BhmkThmQR7CrdIDycWM19enduZXq
 4DE06U2CDh1YuRoyzM/KvgiVDKtgC1Ji7UoXkr8epp0+3+InMGstwJtdXkYQtgFxyyH0a
X-Gm-Gg: AR+sD11xeW7ozcXk6ArPhOWhWiItsxTtueRzqhTmile8hrnxgkAD9mz7H3G3IfzgU68
 Pl3ZOGcbTe+Sc4JD/XFLBQV7pKAumOMZzUIFg0yKCkGzEaH0tLVj4ovmj5K4NRQjzUXyoTbaX3K
 ao4Gi5m69zqbnR+Uki9mU3qK0Aj4RUiJ4BGnc+x+SwuaD9sXwZsVS5PWw6nb5hzOiGr+SL/vUVt
 +CBmVnlKfLROiK/GSsqAl0Vo0qXWKkBbLEwR+gSAMcQzu3OOHwZnW4boDt5e0C3JWDNmBaNblhe
 xVbI2xPScA1IR/IhdmzbXJsvM+xvWNBbUoEWWGWtQMoA55DSMYOwrllYcyZ1JjuLFECu7o7xGsX
 qSxSnuUA5TTt+RT59Y80rJ6VHD9k07yIbVDEMNhvJP+QGQajNaE5FQLxq3lBy7XEAjg0qf9JGqZ
 a+vHUOVx/HxsCu2c+kc0EFSs3yCXnf0QxaQlb7I17U7cK1et5jisxxgkm1B4iKYSj5Bf0XALJKX
 6/KSG1dI1PtUMKffB8RMywz4c1BZSfRQQzxYmKORiTlNKdedH1txWwW/xRZKVxApukxWQzw07QB
 rzVymsesHGD1QJ+39WDjJve/Lt/PELVj7gac/C89fDs9eS9fPmg=
X-Received: by 2002:a17:907:940f:b0:c21:74ad:8b7a with SMTP id
 a640c23a62f3a-c24e5a5243amr461787466b.9.1787643077880; 
 Tue, 25 Aug 2026 00:31:17 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2496738e8bsm1566185566b.44.2026.08.25.00.31.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 00:31:17 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 25 Aug 2026 07:31:15 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I395cc722d53201d775c20ae3cf9d50149bfc90ed
X-Gerrit-Change-Number: 1863
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1863?usp=email>
X-Gerrit-Commit: 32d04ebb0adae7e236e3bea708b84cf576cbd0e2
In-Reply-To: <gerrit.1787570563000.I395cc722d53201d775c20ae3cf9d50149bfc90ed@gerrit.openvpn.net>
References: <gerrit.1787570563000.I395cc722d53201d775c20ae3cf9d50149bfc90ed@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3NTcwNTYzMDAwLkkzOTVjYzcyMmQ1MzIwMWQ3NzVjMjBhZTNjZjlkNTAxNDliZmM5MGVkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <860fee538ddb14a81e962c8570342ab3dd9b99b1-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wylcz-0000LE-0L
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco_win: Remove
 unused dco_start_tun declaration
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8358680902981045815=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8358680902981045815==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Bnmopi2d1Kw="; charset=UTF-8

--Bnmopi2d1Kw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1863?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by cron2


Change subject: dco_win: Remove unused dco_start_tun declaration=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dco_win: R=
emove unused dco_start_tun declaration

This function was removed in commit=

1625d927fc79e2926015ded06a01fd8e460a4bc7, but the
declaration and the non-=
Windows definition were
left behind=2E

Identified by cppcheck=2E

Change-I=
d: I395cc722d53201d775c20ae3cf9d50149bfc90ed
Signed-off-by: Frank Lichtenhe=
ld <frank@lichtenheld=2Ecom>
Acked-by: Gert Doering <gert@greenie=2Emuc=2Ed=
e>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1863
Message-Id: =
<20260824161512=2E1720-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-a=
rchive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38640=2Ehtml
Signed=
-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/dco_win=
=2Eh
1 file changed, 0 insertions(+), 10 deletions(-)


  git pull ssh://ge=
rrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/63/1863/2

diff --git a/src=
/openvpn/dco_win=2Eh b/src/openvpn/dco_win=2Eh
index ac3ce33=2E=2Ea92e5ad 1=
00644
--- a/src/openvpn/dco_win=2Eh
+++ b/src/openvpn/dco_win=2Eh
@@ -65,8 =
+65,6 @@
 void dco_p2p_new_peer(HANDLE handle, OVERLAPPED *ov, struct link_=
socket *sock,
                       struct signal_info *sig_info);
 
-void=
 dco_start_tun(struct tuntap *tt);
-
 bool dco_win_supports_multipeer(void)=
;
 
 void dco_win_add_iroute_ipv4(dco_context_t *dco, in_addr_t dst, unsign=
ed int netbits,
@@ -79,13 +77,5 @@
 
 void dco_win_del_iroute_ipv6(dco_cont=
ext_t *dco, struct in6_addr dst, unsigned int netbits);
 
-#else  /* if def=
ined(ENABLE_DCO) && defined(_WIN32) */
-
-static inline void
-dco_start_tun=
(struct tuntap *tt)
-{
-    ASSERT(false);
-}
-
 #endif /* defined(_WIN32) =
*/
 #endif /* ifndef DCO_H */

-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1863?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: I395cc722d53201d775c20ae3cf9d50149bfc90ed
Gerrit-Change-Numb=
er: 1863
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>

--Bnmopi2d1Kw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1863?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">dco_win: Remove unused dco=
_start_tun declaration<br><br>This function was removed in commit<br>1625d9=
27fc79e2926015ded06a01fd8e460a4bc7, but the<br>declaration and the non-Wind=
ows definition were<br>left behind=2E<br><br>Identified by cppcheck=2E<br><=
br>Change-Id: I395cc722d53201d775c20ae3cf9d50149bfc90ed<br>Signed-off-by: F=
rank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Gert Doering =
&lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1863<br>Message-Id: &lt;20260824161512=2E1720-1-gert@greenie=
=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@list=
s=2Esourceforge=2Enet/msg38640=2Ehtml<br>Signed-off-by: Gert Doering &lt;ge=
rt@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/dco_win=2Eh<br>1 file cha=
nged, 0 insertions(+), 10 deletions(-)<br><br></pre><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull =
ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/63/1863/2</pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/src/openvpn/dco_win=2Eh b/src/openvpn/dco_win=2Eh</span><br><sp=
an>index ac3ce33=2E=2Ea92e5ad 100644</span><br><span>--- a/src/openvpn/dco_=
win=2Eh</span><br><span>+++ b/src/openvpn/dco_win=2Eh</span><br><span>@@ -6=
5,8 +65,6 @@</span><br><span> void dco_p2p_new_peer(HANDLE handle, OVERLAPP=
ED *ov, struct link_socket *sock,</span><br><span>                       st=
ruct signal_info *sig_info);</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-void dco_start_tun(struct tuntap *tt);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> bool dco_win_su=
pports_multipeer(void);</span><br><span> </span><br><span> void dco_win_add=
_iroute_ipv4(dco_context_t *dco, in_addr_t dst, unsigned int netbits,</span=
><br><span>@@ -79,13 +77,5 @@</span><br><span> </span><br><span> void dco_w=
in_del_iroute_ipv6(dco_context_t *dco, struct in6_addr dst, unsigned int ne=
tbits);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#else  /* if defined(ENABLE_DCO) &amp;&amp; defined(_WIN32) */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-static inline void</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-dco_start_tun(struct tuntap *tt)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    ASSERT(false);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span> #endif /* defined(_WIN32) */</span><br><span> #endif /* ifndef DCO_H=
 */</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1863?usp=3Demail">change 1863</a>=2E To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1863?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I395cc722d5320=
1d775c20ae3cf9d50149bfc90ed </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 1863 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </di=
v>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichte=
nheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 =
&lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefo=
rge=2Enet&gt; </div>

</body></html>
--Bnmopi2d1Kw=--


--===============8358680902981045815==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8358680902981045815==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8358680902981045815==--

