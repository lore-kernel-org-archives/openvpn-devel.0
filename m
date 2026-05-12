Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34FB2CD4F25
	for <openvpn-devel@archiver.kernel.org>; Tue, 12 May 2026 17:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7sjNB/Vk6I23I94rouK3efouP3OKa+aFjhl7hh4DS2k=; b=CJVN7Gb88/G9WPHJfNGVm+H1WM
	3OjDE0Oa+fSb5zKmNJ2umCnzjxUoQZNonPNsrsJ+rZrj+Y8q/1oWiAy4dUsoCmIS4sum6+bxXq1N0
	pA+a7YrhS1iLjf+GbkWT7/dxPXjh6DjdTcAweyPIM+EL3fa9uG0rbUtLtPLwhlzXZExo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wMr7S-0002tI-Jz;
	Tue, 12 May 2026 17:42:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wMr7P-0002t2-RU
 for openvpn-devel@lists.sourceforge.net;
 Tue, 12 May 2026 17:42:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Z61KvvUGwfyzBHZrEU6U8DGxwx2Cq9NqazMpy7VO72I=; b=iRmlp6mlT/TCLxmcD/MHtMceU9
 1rXpkhkJCfI/M2AttmWpwrM0hvuMcn8J2aIzaLat8aOx0THuzbAxYyvTYehBy/7xGAwXjm4Y508MW
 S7VNz5lrCwoStLBXYZFYcr6a4zF92mO5seVckzlmzOqevNvu1aYtSwzpM/+/te9mmeNg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Z61KvvUGwfyzBHZrEU6U8DGxwx2Cq9NqazMpy7VO72I=; b=G
 m/8Ano0QHPSOjuuxz7rXH+sDbbOPMl2/x4dPKW4ePxoM+9QyU38HJX1axZ0N6zgYb/HqLcUP8XpGk
 6P1Z3rTeN0Fi+xOXAQlHDZTUbyrZOGiL4vTkIRAphChJlPWjTLOxnd1PHLjYOMqzboLgIdcNEQy9i
 TxyOQK2PV3rXhmzM=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wMr7O-0003Ga-Fs for openvpn-devel@lists.sourceforge.net;
 Tue, 12 May 2026 17:42:08 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso53438275e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 12 May 2026 10:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1778607715; x=1779212515; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z61KvvUGwfyzBHZrEU6U8DGxwx2Cq9NqazMpy7VO72I=;
 b=C3Azmaqg4YUuQGMkX5vkmpLnTM2P5wSM16abttrKVBeELxe5Mtxxzr4g8r/N3wfoJU
 SZ6uCTvfDFm0D5rGli8LUw6n0Z8dO3SDH3Yg8kFl/BJ65sJzy3Y2IjmzX9PQQlYrKQws
 i9VAsgwxTypPvQwm+APfNF6E1jF+lUk0SldE11MmOLWEQy3cu2n64yavU2Ys1N4PtpeE
 WgT21X5SX3IpnN3FrsHEtllmVCA0PJ9gS1asyglRPmQ+xgTXY+ZEaqKt1Gumqm+qM1rK
 8JVvRiqqnEBAkBDcbyncNxiLy7uvdkuQWwKI2itOxv8fU30rcQ8Q1laKak/2XEwlCzFm
 Z1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778607715; x=1779212515;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z61KvvUGwfyzBHZrEU6U8DGxwx2Cq9NqazMpy7VO72I=;
 b=p6F5NYydaTRa9dEptXsJ+ol0vuuoCuitjCQrxwNUV1VmQhyB/Zoe2K/iU13dZnyk3R
 uHQFOid0Wnt9RJ2LA7qPeEXiJnlH1q6j5ud4N/VBwHP36oPUGgslZBX2lfupzHVxDCNv
 oJYGpr0KYvdyQdPKyosdMiBk7KSoosRdJa9Z3c5k0IN0vvUXXytMwyGc+ieXrWMDv7vg
 EVovIcfAeHbJDZ3qliQMQLOm5Cj2SpAPfLrJBCrBYF+kGNTHSZ9TbEJXH8tNartgbd6r
 RDfaXi7SDPXtYk4MtIK3leOWMu0b9wvZ7SWxy8SHQndu0hAgMm2Wf7atbSWJjodbuHlZ
 dheA==
X-Gm-Message-State: AOJu0YyF5KoJ6YL2io85P5Qmm0B7I3ofzgje8bW1wrq9/uC94kmGlEow
 cvgx+xTEd8Br+W0w7z9GHns3AV4QK/70xIO617Z1BebAW7Jw85mp1rLWIiGYEAWbhvD47Qd3xM3
 RLJbO+8CW3VRzKxSTfeeoy0wtGhMTkq9Eia8lCKCReY8qPBQfMswAHgAFtfbeV6HxxF+ZyQ6bfD
 7Mvk5eLg==
X-Gm-Gg: Acq92OExviqpwXCFfva+CWKdwKC9Fj7RY98Ae7dWUG6PQStuuRoLyLDrxLc3Hd1z1y3
 R/FrwdTvwEa1JQTKrY5bKKgzrVaAEdjolA1t9Yx9/nnK5M1mOm9G/B8sKYcbtE1IxBljdG1I+2a
 J1GKJpyZp8SNHcGZoQRsjv1qmHK0I2l0JneDW5TjqIlLmTKxB3qljGkqzqPqvOiCWZn1ljTbTfs
 OMaVOEYQpR/Vj+3DtMhu8gpIgrMRE3AiE0ALui7+EmDwTL6zBY9+Tklose5HiJdDgBykp2UKcTL
 WTbT2U09CyTz00lyTyB2QOJdt4kBie0Me56Bxz3azgi9mBWO6l+2aZE3jbAoEPX68QygXA+qdU8
 zLc16zXoXgggwf6Pt7Okr9z//+F02YKwqs9/JTI9o8weB29yRhDB8NSvJfkaabsOtMhGzPLNYIW
 l0lYMyb+cQW1W4P+cZ5PhewvXJD0Azqrb62LrSXKTwfTmkdDLXrmJk//LpYwP55cbx5MAuRO6ml
 99uw/ky/lCrAWwoERBI1PFuWrJYZoRcnwY7caL5OztsezbkD4Q/ICHMadatUL9eOD+oWYP9Ys7i
 IuNiB6Gm6zOcgw==
X-Received: by 2002:a05:600c:4ba6:b0:488:a882:c7 with SMTP id
 5b1f17b1804b1-48e51f4bab4mr279281925e9.25.1778607715253; 
 Tue, 12 May 2026 10:41:55 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fc8d1f6dbsm12608915e9.6.2026.05.12.10.41.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 10:41:54 -0700 (PDT)
From: "flichtenheld (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 12 May 2026 17:41:53 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Ibe7b3c17176c97a1cbb4d9cc87735b05e62c4f43
X-Gerrit-Change-Number: 1675
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1675?usp=email>
X-Gerrit-Commit: 4f2237d6290877fda67a6c17e34f293c0ff4422e
In-Reply-To: <gerrit.1778239616000.Ibe7b3c17176c97a1cbb4d9cc87735b05e62c4f43@gerrit.openvpn.net>
References: <gerrit.1778239616000.Ibe7b3c17176c97a1cbb4d9cc87735b05e62c4f43@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MjM5NjE2MDAwLkliZTdiM2MxNzE3NmM5N2ExY2JiNGQ5Y2M4NzczNWIwNWU2MmM0ZjQzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <08c49362b0466d16b761c9d365ff137b6e255216-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wMr7O-0003Ga-Fs
Subject: [Openvpn-devel] [M] Change in openvpn[master]: lladdr: Clean up code
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3464069420926989021=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3464069420926989021==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xbgYa5FIY68="; charset=UTF-8

--xbgYa5FIY68=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello cro=
n2, plaisthos, 

I'd like you to reexamine a change=2E Please visit

    ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1675?usp=3Demail

to look at the ne=
w patch set (#4)=2E


Change subject: lladdr: Clean up code
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

lladdr: Clean up code

cppch=
eck complained about the creation of a useless
variable on Windows=2E With =
the old code this was not
fixable in a good way=2E So rewrite the whole cod=
e to
hopefully be much more readable=2E

Change-Id: Ibe7b3c17176c97a1cbb4d9=
cc87735b05e62c4f43
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Eco=
m>
---
M src/openvpn/lladdr=2Ec
1 file changed, 39 insertions(+), 26 deleti=
ons(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes=
/75/1675/4

diff --git a/src/openvpn/lladdr=2Ec b/src/openvpn/lladdr=2Ec
in=
dex d8bcad9=2E=2E6d2afe2 100644
--- a/src/openvpn/lladdr=2Ec
+++ b/src/open=
vpn/lladdr=2Ec
@@ -13,42 +13,55 @@
 #include "lladdr=2Eh"
 #include "proto=
=2Eh"
 
+#ifdef TARGET_LINUX
+static int
+set_lladdr_linux(openvpn_net_ctx_=
t *ctx, const char *ifname, const char *lladdr)
+{
+    uint8_t addr[OPENVP=
N_ETH_ALEN];
+
+    sscanf(lladdr, MAC_FMT, MAC_SCAN_ARG(addr));
+    retur=
n (net_addr_ll_set(ctx, ifname, addr) =3D=3D 0);
+}
+#else /* TARGET_LINUX =
*/
+
+#if defined(TARGET_SOLARIS) || defined(TARGET_FREEBSD)
+#define IFCON=
FIG_LLADDR_CMD "ether"
+#elif defined(TARGET_OPENBSD) || defined(TARGET_DAR=
WIN)
+#define IFCONFIG_LLADDR_CMD "lladdr"
+#endif
+static int
+set_lladdr_=
ifconfig(const char *ifname, const char *lladdr, const struct env_set *es)
=
+{
+#ifdef IFCONFIG_LLADDR_CMD
+    struct argv argv =3D argv_new();
+    a=
rgv_msg(M_INFO, &argv);
+    argv_printf(&argv, "%s %s %s %s", IFCONFIG_PAT=
H, ifname, IFCONFIG_LLADDR_CMD, lladdr);
+    int r =3D openvpn_execve_chec=
k(&argv, es, M_WARN, "ERROR: Unable to set link layer address=2E");
+    ar=
gv_free(&argv);
+    return r;
+#else
+    msg(M_WARN,
+        "Sorry, but=
 I don't know how to configure link layer addresses on this operating syste=
m=2E");
+    return -1;
+#endif
+}
+#endif /* TARGET_LINUX */
+
 int
 set_l=
laddr(openvpn_net_ctx_t *ctx, const char *ifname, const char *lladdr, const=
 struct env_set *es)
 {
-    int r;
-
     if (!ifname || !lladdr)
     {
 =
        return -1;
     }
 
 #if defined(TARGET_LINUX)
-    uint8_t addr[OP=
ENVPN_ETH_ALEN];
+    int r =3D set_lladdr_linux(ctx, ifname, lladdr);
+#el=
se
+    int r =3D set_lladdr_ifconfig(ifname, lladdr, es);
+#endif
 
-    s=
scanf(lladdr, MAC_FMT, MAC_SCAN_ARG(addr));
-    r =3D (net_addr_ll_set(ctx=
, ifname, addr) =3D=3D 0);
-#else /* if defined(TARGET_LINUX) */
-    struc=
t argv argv =3D argv_new();
-#if defined(TARGET_SOLARIS)
-    argv_printf(&=
argv, "%s %s ether %s", IFCONFIG_PATH, ifname, lladdr);
-#elif defined(TARG=
ET_OPENBSD)
-    argv_printf(&argv, "%s %s lladdr %s", IFCONFIG_PATH, ifnam=
e, lladdr);
-#elif defined(TARGET_DARWIN)
-    argv_printf(&argv, "%s %s ll=
addr %s", IFCONFIG_PATH, ifname, lladdr);
-#elif defined(TARGET_FREEBSD)
- =
   argv_printf(&argv, "%s %s ether %s", IFCONFIG_PATH, ifname, lladdr);
-#e=
lse  /* if defined(TARGET_SOLARIS) */
-    msg(M_WARN,
-        "Sorry, but=
 I don't know how to configure link layer addresses on this operating syste=
m=2E");
-    return -1;
-#endif /* if defined(TARGET_SOLARIS) */
-    argv_=
msg(M_INFO, &argv);
-    r =3D openvpn_execve_check(&argv, es, M_WARN, "ERR=
OR: Unable to set link layer address=2E");
-    argv_free(&argv);
-#endif /=
* if defined(TARGET_LINUX) */
-
-    if (r)
+    if (r > 0)
     {
        =
 msg(M_INFO, "TUN/TAP link layer address set to %s", lladdr);
     }

-- 
T=
o view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1675?usp=3Demail
To=
 unsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Proje=
ct: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ibe7b3c17176c97a1cbb4d9=
cc87735b05e62c4f43
Gerrit-Change-Number: 1675
Gerrit-PatchSet: 4
Gerrit-Own=
er: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: cron2 <gert@gre=
enie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Att=
ention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenhe=
ld <frank@lichtenheld=2Ecom>

--xbgYa5FIY68=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>flichtenheld <stro=
ng>uploaded patch set #4</strong> to this change=2E</p><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1675?usp=3Demail">View Change</a></p><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">lladdr: Clean up code<br><br>cppcheck complained about the crea=
tion of a useless<br>variable on Windows=2E With the old code this was not<=
br>fixable in a good way=2E So rewrite the whole code to<br>hopefully be mu=
ch more readable=2E<br><br>Change-Id: Ibe7b3c17176c97a1cbb4d9cc87735b05e62c=
4f43<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br=
>---<br>M src/openvpn/lladdr=2Ec<br>1 file changed, 39 insertions(+), 26 de=
letions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet=
:29418/openvpn refs/changes/75/1675/4</pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/llad=
dr=2Ec b/src/openvpn/lladdr=2Ec</span><br><span>index d8bcad9=2E=2E6d2afe2 =
100644</span><br><span>--- a/src/openvpn/lladdr=2Ec</span><br><span>+++ b/s=
rc/openvpn/lladdr=2Ec</span><br><span>@@ -13,42 +13,55 @@</span><br><span> =
#include &quot;lladdr=2Eh&quot;</span><br><span> #include &quot;proto=2Eh&q=
uot;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#ifdef TARGET_LINUX</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+static int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+set_ll=
addr_linux(openvpn_net_ctx_t *ctx, const char *ifname, const char *lladdr)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    uint8_t addr[OPENVPN_ETH_ALEN];</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    sscanf(lladdr, MAC_FMT, MAC_SCAN_ARG(=
addr));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (=
net_addr_ll_set(ctx, ifname, addr) =3D=3D 0);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#else /* TARGET_LINUX */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if de=
fined(TARGET_SOLARIS) || defined(TARGET_FREEBSD)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#define IFCONFIG_LLADDR_CMD &quot;ether&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#elif defined(TARGET=
_OPENBSD) || defined(TARGET_DARWIN)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#define IFCONFIG_LLADDR_CMD &quot;lladdr&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+set_lladdr_ifconfig(const char *ifname, const char *ll=
addr, const struct env_set *es)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef=
 IFCONFIG_LLADDR_CMD</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct argv argv =3D argv_new();</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    argv_msg(M_INFO, &amp;argv);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    argv_printf(&amp;argv, &quot;%s %s %s %s=
&quot;, IFCONFIG_PATH, ifname, IFCONFIG_LLADDR_CMD, lladdr);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    int r =3D openvpn_execve_check=
(&amp;argv, es, M_WARN, &quot;ERROR: Unable to set link layer address=2E&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    argv_free(=
&amp;argv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retu=
rn r;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    msg(M_WARN,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        &quot;Sorry, but I don&#=
39;t know how to configure link layer addresses on this operating system=2E=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return =
-1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#endif /* TARGET_LINUX */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><span> se=
t_lladdr(openvpn_net_ctx_t *ctx, const char *ifname, const char *lladdr, co=
nst struct env_set *es)</span><br><span> {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    int r;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span>     if (!ifname || !lladdr)</span><br><span>   =
  {</span><br><span>         return -1;</span><br><span>     }</span><br><s=
pan> </span><br><span> #if defined(TARGET_LINUX)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    uint8_t addr[OPENVPN_ETH_ALEN];</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    int r =3D set_lladdr_linux(c=
tx, ifname, lladdr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int r =3D=
 set_lladdr_ifconfig(ifname, lladdr, es);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    sscanf(lladdr, MAC_FMT, MAC_SCAN_ARG(addr));</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    r =3D (net_addr_ll_=
set(ctx, ifname, addr) =3D=3D 0);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#else /* if defined(TARGET_LINUX) */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    struct argv argv =3D argv_new();</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#if defined(TARGET_SOLARIS)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_printf(&amp;argv, =
&quot;%s %s ether %s&quot;, IFCONFIG_PATH, ifname, lladdr);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#elif defined(TARGET_OPENBSD)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_printf(&amp;argv, &q=
uot;%s %s lladdr %s&quot;, IFCONFIG_PATH, ifname, lladdr);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#elif defined(TARGET_DARWIN)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    argv_printf(&amp;argv, &quo=
t;%s %s lladdr %s&quot;, IFCONFIG_PATH, ifname, lladdr);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#elif defined(TARGET_FREEBSD)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    argv_printf(&amp;argv, &quot=
;%s %s ether %s&quot;, IFCONFIG_PATH, ifname, lladdr);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#else  /* if defined(TARGET_SOLARIS) */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(M_WARN,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        &quot;Sorry, but I don=
&#39;t know how to configure link layer addresses on this operating system=
=2E&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return=
 -1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* if defi=
ned(TARGET_SOLARIS) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    argv_msg(M_INFO, &amp;argv);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    r =3D openvpn_execve_check(&amp;argv, es, M_WARN, &quot;ERR=
OR: Unable to set link layer address=2E&quot;);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    argv_free(&amp;argv);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif /* if defined(TARGET_LINUX) */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if (r)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (r &gt; 0)</span><br><span>     {</span><br><span>=
         msg(M_INFO, &quot;TUN/TAP link layer address set to %s&quot;, llad=
dr);</span><br><span>     }</span><br><span></span><br></pre><p>To view, vi=
sit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1675?usp=3Demail">=
change 1675</a>=2E To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1675?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div =
style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displa=
y:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-C=
hange-Id: Ibe7b3c17176c97a1cbb4d9cc87735b05e62c4f43 </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Number: 1675 </div>
<div style=3D"display:none">=
 Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;open=
vpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none">=
 Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenhe=
ld=2Ecom&gt; </div>

</body></html>
--xbgYa5FIY68=--


--===============3464069420926989021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3464069420926989021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3464069420926989021==--

