Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881A66083601
	for <openvpn-devel@archiver.kernel.org>; Sat,  7 Nov 2026 15:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=X4ln3665;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=l07LHX8j;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=g/OXWPVl;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=BWFnLZzQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=Dbudd3HRK2GMqr5FpJ4yXURhCF48HTdd+uHGjVZ9gl8=; b=X4ln36651Sfs2vQpTw0GbGbX0j
	c/ej8vKOfb8ie/s859dvV5ATJWNUlA96Wr4GKwEGs68osUlwIHTH+UX4kkjNQQGMy8rw1Q6icGy5p
	WFyl5y3ukIDTYB+xNdKqQUPh44JE4gBwWRseXjTu8+JRcoSkl1sJVRSGu8vEqgW4IK80=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPi7V-000000007Nd-1qxG;
	Sat, 07 Nov 2026 15:14:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPi7T-000000007NS-2KHE
 for openvpn-devel@lists.sourceforge.net;
 Sat, 07 Nov 2026 15:14:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PcKwfxLiOmlcWlwsD0c4GSVkxN1S/8kdp5vaXfSjqjM=; b=l07LHX8jQnP/kGQAPd2IerXV7w
 nbheFplXuG23HEX17l6TrGYPF7PdGEDqr1fRewNoJZFmystRIGeSRIQw/UUy4rPGH1M9ie1GlATCT
 j6AfLoggEiiIYOhCy7C3CcIwZWU2NYgCqf04nFp7HRP+eV7uWUlHLbpzyv0mh9pXETEs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PcKwfxLiOmlcWlwsD0c4GSVkxN1S/8kdp5vaXfSjqjM=; b=g/OXWPVlkXuwoDFQ+Xg3l4Tq0U
 SEwdWQtTop8Qw33ubspDXOik5N1PjMJXrHw4RKFlKaCu9RgnW9avGghsooPzqvJpySABbM4BlHXWI
 jujUdXYDPCfgpvCqFAl+TKoh76wlw1Adch6F8vHbKJLr9hxXmzIzqG3S+xmy/cjMVE8o=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPi7L-0000000043r-1frk for openvpn-devel@lists.sourceforge.net;
 Sat, 07 Nov 2026 15:14:09 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48fd2e38825so947214f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 07 Nov 2026 07:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794064441; x=1794669241; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PcKwfxLiOmlcWlwsD0c4GSVkxN1S/8kdp5vaXfSjqjM=;
 b=BWFnLZzQj+K9uGRZZ+B9WJwA+OTW7hIx/mcH5kL2WEH5X8caarDPtjM8YD1c165Rpa
 mgHEVTxNXjh0tLLXOIWvUTtm9lKCDusQQQUnuS6D4N+sN/n54Hh9ZMjD3EPwz9cO1oKc
 DNa9cXyGbhAL73FaK7jH7eppgH9RWtY0YIsbQkWTwCQgIOyzoHWE2JpjVeRdkQHZlHR+
 dhBmC5RPytU1hwBPhntMZv36qQxK8kA+SaFNb0mco4ssD7MM19agY3KzKaYKZjmI4ys7
 nsRDI93qY3Krru0hs+S6DhNlwO0fzi/prZmL/kFx4Vxy4sF61V2BrziGW+VnvPia2nKx
 lh3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794064441; x=1794669241;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PcKwfxLiOmlcWlwsD0c4GSVkxN1S/8kdp5vaXfSjqjM=;
 b=yuQJgW5iMZ0FUBvDqq4F0VV3MLBjKi1JoGp/4MdxBrzN8oraOpxgy7kej/eu3L22kl
 uNDnMtietyY5Br11vWWLxftob4krgcTkNVMrc2Py0hpaLK+T6ufe8rSjJSlmLwTwlAxo
 TlR+cZNAHHqtaRIEWJQzhVpXmcvG68icLDY/QeM9tdzHCPQjwUOP+5ZR3+FUpX9IK4UD
 KhscojPpkyzzVRXuuOa5aRIgaiRuPxWH7TsPcbZ56Ai9sofMqSKdW70kCpR1dxD3mYmQ
 4nB82uRzO1tVyGxTl3zpSwTREir2FBOWb9P7EOWcVcLYxmR9AIYXhyeP19BfLtEwcbGP
 X74Q==
X-Gm-Message-State: APuU4Z960NKwNdT0vGy9S5b0bQHg3B1qogoiaZQvTdvmUsIU/vYzbauQ
 6yXPT0rwkWAWbPsaBxQFoSthiu491gt0sDQ9HBpfZigI+StIyzZ6Y9XN8971QGivz11ZLM4rZsL
 JkV7yBL2KePCDeSY1/usCadt9M98bPLNFy/zZbPDJCGvcif2KN8arEGU97+3Uerm4N61Y80sBE/
 t7uYbpKQ==
X-Gm-Gg: AYBFou1sIZMKmH46Mt6uvV6khbBo1MdTJyDjZKyutrvdyocDPWgGyfRCAHwpkDTzgM6
 CKzqQ8+UaQaeMja0YeecQ8O1EHlHEfuhzSKy7Rgy5wm7H7n65v6auJ+ypei0fnK9/Pa8E+TpyWQ
 VLjIWxXesNQJ8Uml9Jmmi+5I5v8KjVoKVVUnpmglfiC3WUl0zJdF8qVcgKTaRwQle/QkJHnhESM
 CGnl9sd1WsICq6AvFXGZg2GRWQ8A5m7iIO/Y7oizEYi2LXhsRaKo/IifjSTgHAjX6ZhOHI053fQ
 AyN4y/iHPTMiPHql9S6gvQNGIJ5BI5QVt+Z20wr9HKv9QB5/J6iv26wPDllhWsXScetuM5V9I+P
 fgzbX5uXXUo3xcDw7cNJighEktnlEQALhURUCy+Fv1GfcYF8bMkcNjgBRkoxKEGhQBKOQL5vuKc
 YnxMF/IECqZR4WjE4mTEQmymd5CjYldk4p/Fy6q9Riz0c4X7neZWDblO6WYiq4dnBg7E1pmGiq4
 PRtI2VfkAlrO4i8yHDAECSmZE3R5F1QBlMvmrCJKBOmRupSX2gg/mTzLRUxmEJHAFqc+2rVJEH9
 NrpITGgkm/f0kMaaWNAxOMnq7rqV1swQDT+fE6H5u3vuIKb1RkIo3788sETgyFSaXqoy7Q+1BK0
 6rW5i+YzAgqmHzBeAVUvXnhjrLNRWMC6X1X8y37Z+U1KdvegwzTDVXVkKb6bKYMEZ0l2N8JcXZS
 0+sucSQ+bHDsJ9+A==
X-Received: by 2002:a05:6000:1861:b0:48a:f36d:fb57 with SMTP id
 ffacd0b85a97d-49275fe4f5dmr12915059f8f.18.1794064440626; 
 Sat, 07 Nov 2026 07:14:00 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d3d609b1sm9509165f8f.8.2026.11.07.07.14.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 07:14:00 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 7 Nov 2026 15:13:59 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I1d545f0a6de5ab795a0c80447002f5cb54b48b32
X-Gerrit-Change-Number: 2151
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2151?usp=email>
X-Gerrit-Commit: c0f3f3916c8909732e773f4e17f46e2ad88cbf4e
References: <gerrit.1794064436000.I1d545f0a6de5ab795a0c80447002f5cb54b48b32@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MDY0NDM2MDAwLkkxZDU0NWYwYTZkZTVhYjc5NWEwYzgwNDQ3MDAyZjVjYjU0YjQ4YjMyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <053163457668cec6004abb13fb8b7b2a3d3225f4-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xPi7L-0000000043r-1frk
Subject: [Openvpn-devel] [S] Change in openvpn[master]: route: merge the
 FreeBSD and DragonFly IPv4 route branches
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5502708735461605871=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5502708735461605871==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2EYtCLkbFxI="; charset=UTF-8

--2EYtCLkbFxI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2151?usp=3Demail

to review the following change=2E
=


Change subject: route: merge the FreeBSD and DragonFly IPv4 route branche=
s
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

route: mer=
ge the FreeBSD and DragonFly IPv4 route branches

add_route() and delete_ro=
ute() had identical FreeBSD and DragonFly
branches, differing only in the e=
rror message=2E Merge them, as the IPv6
functions already do=2E The message=
s now say "FreeBSD/DragonFly", like
the OpenBSD/NetBSD ones=2E

Change-Id: =
I1d545f0a6de5ab795a0c80447002f5cb54b48b32
Signed-off-by: Razvan Cojocaru <r=
azvanc@mailbox=2Eorg>
---
M src/openvpn/route=2Ec
1 file changed, 5 inserti=
ons(+), 28 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/op=
envpn refs/changes/51/2151/1

diff --git a/src/openvpn/route=2Ec b/src/open=
vpn/route=2Ec
index d483c5f=2E=2Eb19e324 100644
--- a/src/openvpn/route=2Ec=

+++ b/src/openvpn/route=2Ec
@@ -1613,7 +1613,7 @@
 
     status =3D route_=
exec(&argv, es, "ERROR: Solaris route add command failed");
 
-#elif define=
d(TARGET_FREEBSD)
+#elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFL=
Y)
 
     argv_printf(&argv, "%s add", ROUTE_PATH);
 
@@ -1626,26 +1626,9 @=
@
 
     argv_printf_cat(&argv, "-net %s %s %s", network, gateway, netmask)=
;
 
-    /* FIXME -- add on-link support for FreeBSD */
+    /* FIXME -- ad=
d on-link support for FreeBSD/DragonFly */
 
-    status =3D route_exec(&ar=
gv, es, "ERROR: FreeBSD route add command failed");
-
-#elif defined(TARGET=
_DRAGONFLY)
-
-    argv_printf(&argv, "%s add", ROUTE_PATH);
-
-#if 0
-    =
if (r->flags & RT_METRIC_DEFINED)
-    {
-        argv_printf_cat(&argv, "-=
rtt %d", r->metric);
-    }
-#endif
-
-    argv_printf_cat(&argv, "-net %s =
%s %s", network, gateway, netmask);
-
-    /* FIXME -- add on-link support =
for Dragonfly */
-
-    status =3D route_exec(&argv, es, "ERROR: DragonFly =
route add command failed");
+    status =3D route_exec(&argv, es, "ERROR: F=
reeBSD/DragonFly route add command failed");
 
 #elif defined(TARGET_DARWIN=
)
 
@@ -2070,17 +2053,11 @@
 
     route_exec(&argv, es, "ERROR: Solaris ro=
ute delete command failed");
 
-#elif defined(TARGET_FREEBSD)
+#elif define=
d(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)
 
     argv_printf(&argv, "%=
s delete -net %s %s %s", ROUTE_PATH, network, gateway, netmask);
 
-    rou=
te_exec(&argv, es, "ERROR: FreeBSD route delete command failed");
-
-#elif =
defined(TARGET_DRAGONFLY)
-
-    argv_printf(&argv, "%s delete -net %s %s %=
s", ROUTE_PATH, network, gateway, netmask);
-
-    route_exec(&argv, es, "E=
RROR: DragonFly route delete command failed");
+    route_exec(&argv, es, "=
ERROR: FreeBSD/DragonFly route delete command failed");
 
 #elif defined(TA=
RGET_DARWIN)
 

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2151?usp=3Demail
To unsubscribe, or for help writing mail filters, visit=
 https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: n=
ewchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1=
d545f0a6de5ab795a0c80447002f5cb54b48b32
Gerrit-Change-Number: 2151
Gerrit-P=
atchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerri=
t-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwab=
e <arne-openvpn@rfc2549=2Eorg>

--2EYtCLkbFxI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2151?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">route: merge the FreeBSD and DragonFly IPv4 route branc=
hes<br><br>add_route() and delete_route() had identical FreeBSD and DragonF=
ly<br>branches, differing only in the error message=2E Merge them, as the I=
Pv6<br>functions already do=2E The messages now say &quot;FreeBSD/DragonFly=
&quot;, like<br>the OpenBSD/NetBSD ones=2E<br><br>Change-Id: I1d545f0a6de5a=
b795a0c80447002f5cb54b48b32<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@m=
ailbox=2Eorg&gt;<br>---<br>M src/openvpn/route=2Ec<br>1 file changed, 5 ins=
ertions(+), 28 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t=2Eopenvpn=2Enet:29418/openvpn refs/changes/51/2151/1</pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/src/openvpn/route=2Ec b/src/openvpn/route=2Ec</span><br><span>index d483c5=
f=2E=2Eb19e324 100644</span><br><span>--- a/src/openvpn/route=2Ec</span><br=
><span>+++ b/src/openvpn/route=2Ec</span><br><span>@@ -1613,7 +1613,7 @@</s=
pan><br><span> </span><br><span>     status =3D route_exec(&amp;argv, es, &=
quot;ERROR: Solaris route add command failed&quot;);</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(TARGET_FREEB=
SD)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#elif defined(TA=
RGET_FREEBSD) || defined(TARGET_DRAGONFLY)</span><br><span> </span><br><spa=
n>     argv_printf(&amp;argv, &quot;%s add&quot;, ROUTE_PATH);</span><br><s=
pan> </span><br><span>@@ -1626,26 +1626,9 @@</span><br><span> </span><br><s=
pan>     argv_printf_cat(&amp;argv, &quot;-net %s %s %s&quot;, network, gat=
eway, netmask);</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    /* FIXME -- add on-link support for FreeBSD */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* FIXME -- add on-link supp=
ort for FreeBSD/DragonFly */</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    status =3D route_exec(&amp;argv, es, &quot;ERR=
OR: FreeBSD route add command failed&quot;);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#elif defined(TARGET_DRAGONFLY)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_=
printf(&amp;argv, &quot;%s add&quot;, ROUTE_PATH);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#if 0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (=
r-&gt;flags &amp; RT_METRIC_DEFINED)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       argv_printf_cat(&amp;argv, &quot;-rtt %d&quot;, r-&gt;metric);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
argv_printf_cat(&amp;argv, &quot;-net %s %s %s&quot;, network, gateway, net=
mask);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    /* FIXME -- add on-link support =
for Dragonfly */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    status =3D route_exec(=
&amp;argv, es, &quot;ERROR: DragonFly route add command failed&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    status =3D route_exe=
c(&amp;argv, es, &quot;ERROR: FreeBSD/DragonFly route add command failed&qu=
ot;);</span><br><span> </span><br><span> #elif defined(TARGET_DARWIN)</span=
><br><span> </span><br><span>@@ -2070,17 +2053,11 @@</span><br><span> </spa=
n><br><span>     route_exec(&amp;argv, es, &quot;ERROR: Solaris route delet=
e command failed&quot;);</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#elif defined(TARGET_FREEBSD)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#elif defined(TARGET_FREEBSD) || defined(TAR=
GET_DRAGONFLY)</span><br><span> </span><br><span>     argv_printf(&amp;argv=
, &quot;%s delete -net %s %s %s&quot;, ROUTE_PATH, network, gateway, netmas=
k);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    route_exec(&amp;argv, es, &quot;ERROR: FreeBSD route delete command fai=
led&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(TARGET_DRAGONFLY)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    argv_printf(&amp;argv, &quot;%s delete=
 -net %s %s %s&quot;, ROUTE_PATH, network, gateway, netmask);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    route_exec(&amp;argv, es, &quot;ERROR: DragonFly rou=
te delete command failed&quot;);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    route_exec(&amp;argv, es, &quot;ERROR: FreeBSD/DragonFly r=
oute delete command failed&quot;);</span><br><span> </span><br><span> #elif=
 defined(TARGET_DARWIN)</span><br></pre><p>To view, visit <a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2151?usp=3Demail">change 2151</a>=2E T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"https://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2151?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"di=
splay:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:non=
e"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bran=
ch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1d545f0a6=
de5ab795a0c80447002f5cb54b48b32 </div>
<div style=3D"display:none"> Gerrit-=
Change-Number: 2151 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 =
</div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;=
razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--2EYtCLkbFxI=--


--===============5502708735461605871==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5502708735461605871==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5502708735461605871==--

