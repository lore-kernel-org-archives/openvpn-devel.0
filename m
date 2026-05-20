Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91DBBCD4F3D
	for <openvpn-devel@archiver.kernel.org>; Wed, 20 May 2026 16:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e0uQOEzg0uv8aubeg9dIBYt6tVNsHcvKM9fgHjz5XQU=; b=Sqi8QzteE4D/NSogLmPIxtVhrg
	gD9ROhcFNZsoX2mWbHdTrB/xAaXjYKWnle8I/hCgkdCeGyJPLmaMu7rS5NlHTYEeU1ewu5LRGpmsn
	fih+w851E4sFiC1llHJe+WZnHARUE4JfCJwopHA16eQVj0uIq5izs+v8I1TZxZqt6OBw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wPjpq-0000Gl-3P;
	Wed, 20 May 2026 16:31:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wPjpI-0000Ef-0u
 for openvpn-devel@lists.sourceforge.net;
 Wed, 20 May 2026 16:31:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=JuV/9wd8L2QxT5SDl+oMSwDLY2lwVEzE617Z37ozEXg=; b=QolY9KIcxgaLONgIZpv0/CUffO
 aSv2+heDLZ+V+rzcv17exWT0rivygwOrZ/Rrr3OlH8e+JvyuOM2JD/qS+UFieyVHjhJbfZqOcpPvI
 6YrNTLAtLBWbwYOn+W7BwK3qe5fdV2rqkU7FyQPYXViS9KULis9H9/e8U9zEKn3HU0Ao=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=JuV/9wd8L2QxT5SDl+oMSwDLY2lwVEzE617Z37ozEXg=; b=L
 HcfUN2tXn1B/qCG1K52omP1ACIA5U9ATzcDKURy2Gb13RxClIbyK6vyXxuMFTSi49vRU9C4Gp39ie
 08MOiLMaftAn+WVzo9VFFRfYOIQwoD1EVMJaI+KI3MuHFHcWDpNW7CeY5rjiDGZ9IyBH412HZUwSk
 ndMBAvSB2jU55tUw=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wPjpG-0000cC-KU for openvpn-devel@lists.sourceforge.net;
 Wed, 20 May 2026 16:31:20 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-43d75312379so4223055f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 20 May 2026 09:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1779294667; x=1779899467; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JuV/9wd8L2QxT5SDl+oMSwDLY2lwVEzE617Z37ozEXg=;
 b=CmtNQWLL1XyqHugfDOfofIXY3H9Py5MV5sO3dVpw0Sx2wHYv3yUPkkE6rCKJx40uhr
 Tnkz7C/CaiEsHIINFmYGlp7Gj0SmObcq5xaUmM/sscpiRPKRBPRWkXXxwM+TM4nxetji
 GXqZGFMY/KJMsdpdWAf7S+MH8w9eYdLT84GUaMpzhj5Ag6HolyukgRFVvy8VYbaJSYju
 g2H+rghmZ10HFaUnGOb9eos3+J/Y1BFF0O+//Z/zJoBeJIwYf4H+kRYFPuu/y65vW15X
 IfcZqOIfa3FaObwH8Q6UofxwFHKBecED16x/WKWmD405GTRZ2Om48QnreU9/Ba0+zHN8
 Q7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779294667; x=1779899467;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JuV/9wd8L2QxT5SDl+oMSwDLY2lwVEzE617Z37ozEXg=;
 b=omfcYsIl5Z/Y3iOLxhwRZTxIYGKMhSV1wtOF7Yi22bYSiwlxeuK3TzzhHtKSQV2H2U
 DptdCLQj7qOAaTNSUjY8w4F2QoKXPNEChdYJDI5mDzox2e8MNvxYtdMBlzO+Nezj3iyQ
 MoKkHGeH2/OeCKM8DXiC1YqLH980ScZWiQnf0j6acE8O50nz3PMdktUAYqQNKkpq8g2+
 IUkCMYyMoRSA1JWkeUsm59mSObPKtPKqZ/C6M7jX7+TgvSzCHugYBNSNjSz/WYGgOkAn
 mTxzqNwjtMgNz9zoiHmcG3qy8Nfu1rHSY99cr92RQujcSkGw4OUFFBY29zfhIozjoYk2
 a85A==
X-Gm-Message-State: AOJu0YwzAFLXaO/dO3SABSocHhYHdqBPxyWj3jBMImqimQ/7O04JEnsC
 bgh9FtZ0xudHq+fevrOkd8Y+7x56L7QgCUdHJ2fweHo+ZNI2LHsBDMu4iSXMqJRDAYAQYF47enC
 BC1Ap1tLFSCcS/wx6cjyCfJ0VNyDffePlyAfMTPGmgdpfOCqf8p4z1XD77K+rcjNA0l3f
X-Gm-Gg: Acq92OH+NWoeb0XduV1c8FzF9pKldvk4gI6hLsh24/zNmyu2s4nAI8dU0is2CgjkXdo
 vQdPeBmgaa/TW0NcifGDiocZuU6zUkWHEg7FyMQBF2AmQHaT/ry1isMRaAzJLPbGag9KEW2Fakl
 gn3dB7JeQ0tuIdpREJbd6TCFYJ0DmIhruJtPQ4ktnAOfAGBQoEtP+lIJHScFENRbAgY192FMP+v
 oKeKHgZJlabnHE6Ybilk0LEbenYDa/irHyxof8CUbLyaWa7/1giW1zbfsvIRdPOACx68elti4s2
 0IsMzYdf1a993WK8sDTJf9cbJsaKJQTCxW+kNkUX96AZgF3rxpTuf5CAMb6BNno5tN6UnLaO/FA
 k1ZYVaf65yxyE0uFjVn9iP2PfQSaAliJahykVlfIJR9m+MOeYjAe+AOuHKxT5cBbRwidlz8HfNr
 Z8tJ/+6vPja3Lji59K1VTQb9Xry9stVLJ/65r6vtkPpFQttp+YGo5WmrHSDEd4xd2X/uSP4NjCP
 gsR62Qamltvq25kIXB66ZuxrZ6Bd/zoFqVMOY1PRPOQeWdCnlCYaIXY42Et4hRQSW2fEcnMxE6a
 uzuMqfOG+EkWUA==
X-Received: by 2002:a05:600c:259:b0:488:a502:8955 with SMTP id
 5b1f17b1804b1-49033d08ba0mr2697385e9.4.1779294667301; 
 Wed, 20 May 2026 09:31:07 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a19a0csm52491006f8f.20.2026.05.20.09.31.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 09:31:06 -0700 (PDT)
From: "flichtenheld (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 20 May 2026 16:31:03 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Ibe7b3c17176c97a1cbb4d9cc87735b05e62c4f43
X-Gerrit-Change-Number: 1675
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1675?usp=email>
X-Gerrit-Commit: e9a0645e18dca96e910a41a4ca85352d3298f79e
In-Reply-To: <gerrit.1778239616000.Ibe7b3c17176c97a1cbb4d9cc87735b05e62c4f43@gerrit.openvpn.net>
References: <gerrit.1778239616000.Ibe7b3c17176c97a1cbb4d9cc87735b05e62c4f43@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MjM5NjE2MDAwLkliZTdiM2MxNzE3NmM5N2ExY2JiNGQ5Y2M4NzczNWIwNWU2MmM0ZjQzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4fa99c51eb7759ec33110f97343796ac46dc2be9-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wPjpG-0000cC-KU
Subject: [Openvpn-devel] [M] Change in openvpn[master]: lladdr: Clean up
 code and BSD support
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
Content-Type: multipart/mixed; boundary="===============6020500201900175557=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6020500201900175557==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+atR/FToAg0="; charset=UTF-8

--+atR/FToAg0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos=2E

He=
llo cron2, plaisthos, 

I'd like you to reexamine a change=2E Please visit
=

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1675?usp=3Demail

to look at=
 the new patch set (#5)=2E

The following approvals got outdated and were r=
emoved:
Code-Review-1 by cron2


Change subject: lladdr: Clean up code and =
BSD support
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

l=
laddr: Clean up code and BSD support

cppcheck complained about the creatio=
n of a useless
variable on Windows=2E With the old code this was not
fixabl=
e in a good way=2E So rewrite the whole code to
hopefully be much more read=
able=2E

While testing this we also found out that the old
code was not rea=
lly working on Solaris, so disable
support for that=2E

Gert Doering contri=
buted support for NetBSD=2E

Github: closes #1034
Change-Id: Ibe7b3c17176c9=
7a1cbb4d9cc87735b05e62c4f43
Signed-off-by: Frank Lichtenheld <frank@lichten=
held=2Ecom>
---
M src/openvpn/lladdr=2Ec
1 file changed, 39 insertions(+), =
26 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn ref=
s/changes/75/1675/5

diff --git a/src/openvpn/lladdr=2Ec b/src/openvpn/llad=
dr=2Ec
index d8bcad9=2E=2E195245f 100644
--- a/src/openvpn/lladdr=2Ec
+++ b=
/src/openvpn/lladdr=2Ec
@@ -13,42 +13,55 @@
 #include "lladdr=2Eh"
 #includ=
e "proto=2Eh"
 
+#ifdef TARGET_LINUX
+static int
+set_lladdr_linux(openvpn_=
net_ctx_t *ctx, const char *ifname, const char *lladdr)
+{
+    uint8_t add=
r[OPENVPN_ETH_ALEN];
+
+    sscanf(lladdr, MAC_FMT, MAC_SCAN_ARG(addr));
+ =
   return (net_addr_ll_set(ctx, ifname, addr) =3D=3D 0);
+}
+#else /* TARGE=
T_LINUX */
+
+#if defined(TARGET_OPENBSD) || defined(TARGET_FREEBSD) || def=
ined(TARGET_DARWIN)
+#define IFCONFIG_LLADDR_FMT "%s %s lladdr %s"
+#elif d=
efined(TARGET_NETBSD)
+#define IFCONFIG_LLADDR_FMT "%s %s link %s active"
+=
#endif
+static int
+set_lladdr_ifconfig(const char *ifname, const char *lla=
ddr, const struct env_set *es)
+{
+#ifdef IFCONFIG_LLADDR_FMT
+    struct a=
rgv argv =3D argv_new();
+    argv_printf(&argv, IFCONFIG_LLADDR_FMT, IFCON=
FIG_PATH, ifname, lladdr);
+    argv_msg(M_INFO, &argv);
+    int r =3D ope=
nvpn_execve_check(&argv, es, M_WARN, "ERROR: Unable to set link layer addre=
ss=2E");
+    argv_free(&argv);
+    return r;
+#else
+    msg(M_WARN,
+   =
     "Sorry, but I don't know how to configure link layer addresses on this=
 operating system=2E");
+    return -1;
+#endif
+}
+#endif /* TARGET_LINUX =
*/
+
 int
 set_lladdr(openvpn_net_ctx_t *ctx, const char *ifname, const cha=
r *lladdr, const struct env_set *es)
 {
-    int r;
-
     if (!ifname || !=
lladdr)
     {
         return -1;
     }
 
 #if defined(TARGET_LINUX)
-   =
 uint8_t addr[OPENVPN_ETH_ALEN];
+    int r =3D set_lladdr_linux(ctx, ifnam=
e, lladdr);
+#else
+    int r =3D set_lladdr_ifconfig(ifname, lladdr, es);
=
+#endif
 
-    sscanf(lladdr, MAC_FMT, MAC_SCAN_ARG(addr));
-    r =3D (net=
_addr_ll_set(ctx, ifname, addr) =3D=3D 0);
-#else /* if defined(TARGET_LINU=
X) */
-    struct argv argv =3D argv_new();
-#if defined(TARGET_SOLARIS)
- =
   argv_printf(&argv, "%s %s ether %s", IFCONFIG_PATH, ifname, lladdr);
-#e=
lif defined(TARGET_OPENBSD)
-    argv_printf(&argv, "%s %s lladdr %s", IFCO=
NFIG_PATH, ifname, lladdr);
-#elif defined(TARGET_DARWIN)
-    argv_printf(=
&argv, "%s %s lladdr %s", IFCONFIG_PATH, ifname, lladdr);
-#elif defined(TA=
RGET_FREEBSD)
-    argv_printf(&argv, "%s %s ether %s", IFCONFIG_PATH, ifna=
me, lladdr);
-#else  /* if defined(TARGET_SOLARIS) */
-    msg(M_WARN,
-   =
     "Sorry, but I don't know how to configure link layer addresses on this=
 operating system=2E");
-    return -1;
-#endif /* if defined(TARGET_SOLARI=
S) */
-    argv_msg(M_INFO, &argv);
-    r =3D openvpn_execve_check(&argv, =
es, M_WARN, "ERROR: Unable to set link layer address=2E");
-    argv_free(&=
argv);
-#endif /* if defined(TARGET_LINUX) */
-
-    if (r)
+    if (r > 0)=

     {
         msg(M_INFO, "TUN/TAP link layer address set to %s", lladdr=
);
     }

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/167=
5?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http:=
//gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatch=
set
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ibe7b3c=
17176c97a1cbb4d9cc87735b05e62c4f43
Gerrit-Change-Number: 1675
Gerrit-PatchS=
et: 5
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer:=
 cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Att=
ention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Attention: flichtenheld <fra=
nk@lichtenheld=2Ecom>

--+atR/FToAg0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, plaisthos=2E </p>
<p>flichtenhel=
d <strong>uploaded patch set #5</strong> to this change=2E</p><p><a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1675?usp=3Demail">View Change</a=
></p><p>The following approvals got outdated and were removed:
Code-Review-=
1 by cron2</p><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">lladdr: Clean up code and BSD support<br><br>cp=
pcheck complained about the creation of a useless<br>variable on Windows=2E=
 With the old code this was not<br>fixable in a good way=2E So rewrite the =
whole code to<br>hopefully be much more readable=2E<br><br>While testing th=
is we also found out that the old<br>code was not really working on Solaris=
, so disable<br>support for that=2E<br><br>Gert Doering contributed support=
 for NetBSD=2E<br><br>Github: closes #1034<br>Change-Id: Ibe7b3c17176c97a1c=
bb4d9cc87735b05e62c4f43<br>Signed-off-by: Frank Lichtenheld &lt;frank@licht=
enheld=2Ecom&gt;<br>---<br>M src/openvpn/lladdr=2Ec<br>1 file changed, 39 i=
nsertions(+), 26 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ger=
rit=2Eopenvpn=2Enet:29418/openvpn refs/changes/75/1675/5</pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/src/openvpn/lladdr=2Ec b/src/openvpn/lladdr=2Ec</span><br><span>index d8=
bcad9=2E=2E195245f 100644</span><br><span>--- a/src/openvpn/lladdr=2Ec</spa=
n><br><span>+++ b/src/openvpn/lladdr=2Ec</span><br><span>@@ -13,42 +13,55 @=
@</span><br><span> #include &quot;lladdr=2Eh&quot;</span><br><span> #includ=
e &quot;proto=2Eh&quot;</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#ifdef TARGET_LINUX</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+static int</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+set_lladdr_linux(openvpn_net_ctx_t *ctx, const char *ifname, c=
onst char *lladdr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t addr[OP=
ENVPN_ETH_ALEN];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    sscanf(lladdr, MAC=
_FMT, MAC_SCAN_ARG(addr));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    return (net_addr_ll_set(ctx, ifname, addr) =3D=3D 0);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#else /* TARGET_LINUX */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#if defined(TARGET_OPENBSD) || defined(TARGET_FREEBSD) || de=
fined(TARGET_DARWIN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#define IFCONFIG_LLADDR_FMT &quot;%s %s lladdr %s&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#elif defined(TARGET_NETBSD)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#define IFCONFIG_LLADDR_FMT &=
quot;%s %s link %s active&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+set_lladdr=
_ifconfig(const char *ifname, const char *lladdr, const struct env_set *es)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#ifdef IFCONFIG_LLADDR_FMT</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct argv argv =3D argv_=
new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    argv_prin=
tf(&amp;argv, IFCONFIG_LLADDR_FMT, IFCONFIG_PATH, ifname, lladdr);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    argv_msg(M_INFO, &amp;ar=
gv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int r =3D o=
penvpn_execve_check(&amp;argv, es, M_WARN, &quot;ERROR: Unable to set link =
layer address=2E&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    argv_free(&amp;argv);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    return r;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(M=
_WARN,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &quot=
;Sorry, but I don&#39;t know how to configure link layer addresses on this =
operating system=2E&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    return -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* TARGET_LINUX */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int<=
/span><br><span> set_lladdr(openvpn_net_ctx_t *ctx, const char *ifname, con=
st char *lladdr, const struct env_set *es)</span><br><span> {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    int r;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span>     if (!ifname || !lladdr)<=
/span><br><span>     {</span><br><span>         return -1;</span><br><span>=
     }</span><br><span> </span><br><span> #if defined(TARGET_LINUX)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t addr[OPENVPN_ETH_=
ALEN];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int r =3D=
 set_lladdr_linux(ctx, ifname, lladdr);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#else</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    int r =3D set_lladdr_ifconfig(ifname, lladdr, es);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    sscanf(lladdr, MAC_FMT, MAC=
_SCAN_ARG(addr));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
r =3D (net_addr_ll_set(ctx, ifname, addr) =3D=3D 0);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#else /* if defined(TARGET_LINUX) */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    struct argv argv =3D arg=
v_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(T=
ARGET_SOLARIS)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    arg=
v_printf(&amp;argv, &quot;%s %s ether %s&quot;, IFCONFIG_PATH, ifname, llad=
dr);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(TAR=
GET_OPENBSD)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_=
printf(&amp;argv, &quot;%s %s lladdr %s&quot;, IFCONFIG_PATH, ifname, lladd=
r);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(TARG=
ET_DARWIN)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_pr=
intf(&amp;argv, &quot;%s %s lladdr %s&quot;, IFCONFIG_PATH, ifname, lladdr)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(TARGET=
_FREEBSD)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_pri=
ntf(&amp;argv, &quot;%s %s ether %s&quot;, IFCONFIG_PATH, ifname, lladdr);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else  /* if defined(T=
ARGET_SOLARIS) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
msg(M_WARN,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        &q=
uot;Sorry, but I don&#39;t know how to configure link layer addresses on th=
is operating system=2E&quot;);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    return -1;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#endif /* if defined(TARGET_SOLARIS) */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    argv_msg(M_INFO, &amp;argv);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    r =3D openvpn_execve_check(&amp;argv, e=
s, M_WARN, &quot;ERROR: Unable to set link layer address=2E&quot;);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_free(&amp;argv);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* if defined(TARG=
ET_LINUX) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if (r)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (r &gt; 0)</span><br><span>     =
{</span><br><span>         msg(M_INFO, &quot;TUN/TAP link layer address set=
 to %s&quot;, lladdr);</span><br><span>     }</span><br><span></span><br></=
pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1675?usp=3Demail">change 1675</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eo=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1675?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpat=
chset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<d=
iv style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Id: Ibe7b3c17176c97a1cbb4d9cc87735b05e62c4f43 </div=
>
<div style=3D"display:none"> Gerrit-Change-Number: 1675 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> G=
errit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert=
@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Attentio=
n: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--+atR/FToAg0=--


--===============6020500201900175557==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6020500201900175557==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6020500201900175557==--

