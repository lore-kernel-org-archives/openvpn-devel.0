Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF8DC53219
	for <openvpn-devel@archiver.kernel.org>; Mon, 27 Jul 2026 10:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UIQFp5vPum0STcuscbwkrlKXEmvPUPhY4aqbimVvszo=; b=gv8sTbx666HoT+6gqyvJn3/eyC
	tFaiT7Hha2KqNS3HhQlV/qU3T2tx2Wq0CFUGPZjuzX06YtDpwvi3RGG6Be4onKuqrsoYvOUauOAC9
	AKcNiDO+ePPiLBfCBW83xzCy7L1O7KrL/ITS+5YgiQlUJ9q+6xWfWMAFeDrbts4F0wr4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1woID8-0000GM-Lj;
	Mon, 27 Jul 2026 10:05:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1woID7-0000GE-GD
 for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 10:05:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=I/7sjVve47QjM1CYUs7BC7ByoI9eh90OOLnRl+CjREA=; b=OZoei72vH1lTEKT8Lo8WlRm0Ir
 VbAnQzsReRQuVPzuU7qsV2+FmEI+b8EfiBYvVGm0u6p65QE4vVJqbVHgxJnr0Ma0FnLsrLm1gwz2p
 QMJx9HgDHClACUGc1Vc20Wh7VGQZwynKQQGOqBNXsQ9++NtSVjUeVH3AezW9udytc+i0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=I/7sjVve47QjM1CYUs7BC7ByoI9eh90OOLnRl+CjREA=; b=g
 b7j7cdqu+wA7fyvHeIiGihJmVeVg2TvF9pKDKup9pfy8IpmFFMWVnd/+42IDlpxM+WgGWiDATmeq9
 4tZeisOfKieTfgstOA2pHQJJ0DfXf3qsNpW/byo8mrmV/3YSGM2sXE7HjsQr3xIR3wbKJgVw80/i0
 mKU4j0DK6Ez6Kr9w=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1woID6-0002g4-O8 for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 10:05:22 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4954a32cf1eso12604835e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 27 Jul 2026 03:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785146715; x=1785751515; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=I/7sjVve47QjM1CYUs7BC7ByoI9eh90OOLnRl+CjREA=;
 b=Ru2+OuYsxzEDSrP5S8iNVoWeUVDk9s79yqnsTYoHrAQ6wgY4X8BQyRI7U7spA5MkNF
 IE/Bos7qqaH98QSy8bqlFxCkzf2MH3cajj0XPRuAvu536cLG1WtWLr5AftdwrXxDfFfo
 orz/wlAaMk6NWJH6gWMAzGi8Y2Ewie1shBvUS3cinU4UoU2F9f5bts4sHXgb53qTHT+d
 1iF6Ah9LIL/Rx4nZewg/Ktynn4G5vIkwzPICmlMaXNEMnsz+PED6uhT3IAB0Yix/0d3F
 M7mN5IGll5SUPet39TTpkFFJheJv6pIzxvDY+eweGEJb7pIXCj2fdevEd22X3ZP50YNd
 SteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785146715; x=1785751515;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=I/7sjVve47QjM1CYUs7BC7ByoI9eh90OOLnRl+CjREA=;
 b=istO7VYHDqLw0Llwzj4ECbXD7Kg6Qr+5Gv16QejpyUH+CxqmYaaM90JteTUGZ69cUe
 nDztnB6S3c/uMaCTJHE7qUiGNxsyi8geyF6jp8epG1+g/tT53deihKnyCYAiayqfYnk6
 oeXRuvSVnTLFNBQeJudYiwi/84kMzmFCbNRTRNE1ZdeWGean8rUFDDk7eo456YTK+N4R
 b351KG/M8LeVofPB5vl4qxM669L8Pwaz7f6W02xjd3Bl50b/gDMCnHQG9U3AKy2cbXwn
 4JMTpWN/5ypG+lXaxsj1jidYjYnttffJMfbShUtZ7IL2CW1vyHs/drTgmjcHcolyb8iK
 L/2Q==
X-Gm-Message-State: AOJu0YwuD6AAl+z6I7c1yWdO9zNdqGNNA3sGS2vaBHdovm6M6kEh4Aqa
 4BqrUFSI3/pbPnvgebAeeb9UcBJg3UMrPKCGanlhktPj9fNiqp6IfG+ZaJSpu/NdB1Afz15y+bL
 waGFR4bnQkIVsdr2/B4fKH16GNYuZj+PeHhpwUR35+ZfQ7k1x2EyD7bV4ufuCbqGgxQzSjfEzHg
 TdODBW/g==
X-Gm-Gg: AR+sD12cRQbfJmju6TexiN0NcmjxW8YjlffNTH1skSdxRlJ3N/PNEsmtVYQcTP0mTde
 n0BfnfiuYQUw4aCMY40O/MG+xT2XJHqsu1l8QSlX2IvG+PL1SYm+6iMjd7E2AEwgJvQjLJj+MFV
 6iUUOmz0vCn0srEomu574LeSRqDHwGS0jFmdvgj3fzabZumRTJIqFpJzzAGIzLDy7yUP4l+G3gT
 9wVo+0K0Z87po5ubiMFnR3zWRoD81UW39hDxlxCyXjPenKp9zcp2km8fAaeeKjg2spxdT9lN716
 4wk3T4hMr7wiVIj8YUCpXaikAVcjBMLS4zpFUYKCri5+sgRLDoUxPlESVPnckO/Ar+ATj9SD8rW
 PbFX/CgKlRtJL3QUK3ZHJ1yAEN7RgWZASKdfFfMmGaimRg78GFWP9dRBVJkJasZn8DolsrW0MlM
 BLhLr4dtrBHrVX4k7p+GxEZp9+dPfufa8coJhQAg0SQpxhpcQn5W8D026X/4nzFK9WQW14qGpUm
 TCCgD3pw24rFARs2/Zsu144OVtPRbPgnNkLelf68qmHMAiUg0UJB+QK5yMIdzMNX90PQcgBBs+J
 6AU=
X-Received: by 2002:a05:600c:c4a3:b0:495:51b6:174f with SMTP id
 5b1f17b1804b1-496b5747d82mr101678605e9.20.1785146714304; 
 Mon, 27 Jul 2026 03:05:14 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b480fafasm277401585e9.0.2026.07.27.03.05.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 03:05:13 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 27 Jul 2026 10:05:10 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: Ibe7b3c17176c97a1cbb4d9cc87735b05e62c4f43
X-Gerrit-Change-Number: 1675
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1675?usp=email>
X-Gerrit-Commit: 1e918232e20c4d09b4e0dcdbf91fbb5d5cb9cb23
In-Reply-To: <gerrit.1778239616000.Ibe7b3c17176c97a1cbb4d9cc87735b05e62c4f43@gerrit.openvpn.net>
References: <gerrit.1778239616000.Ibe7b3c17176c97a1cbb4d9cc87735b05e62c4f43@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MjM5NjE2MDAwLkliZTdiM2MxNzE3NmM5N2ExY2JiNGQ5Y2M4NzczNWIwNWU2MmM0ZjQzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <16ed84c2c7e7bc7ac7cf2e3d395897227df26d58-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1woID6-0002g4-O8
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3262227817121676227=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3262227817121676227==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kB89tXVMF1o="; charset=UTF-8

--kB89tXVMF1o=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#6) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1675?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by cron2


Change subject: lladdr: Clean up code and BSD support
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

lladdr: Clean up code =
and BSD support

cppcheck complained about the creation of a useless
variab=
le on Windows=2E With the old code this was not
fixable in a good way=2E So=
 rewrite the whole code to
hopefully be much more readable=2E

While testin=
g this we also found out that the old
code was not really working on Solari=
s, so disable
support for that=2E

Gert Doering contributed support for Net=
BSD=2E

Github: closes OpenVPN/openvpn#1034
Change-Id: Ibe7b3c17176c97a1cbb=
4d9cc87735b05e62c4f43
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Acked-by: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL: https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1675
Message-Id: <20260724220839=2E264=
02-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn=
-devel@lists=2Esourceforge=2Enet/msg37863=2Ehtml
Signed-off-by: Gert Doerin=
g <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/lladdr=2Ec
1 file changed, 39=
 insertions(+), 26 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:2=
9418/openvpn refs/changes/75/1675/6

diff --git a/src/openvpn/lladdr=2Ec b/=
src/openvpn/lladdr=2Ec
index d8bcad9=2E=2E195245f 100644
--- a/src/openvpn/=
lladdr=2Ec
+++ b/src/openvpn/lladdr=2Ec
@@ -13,42 +13,55 @@
 #include "llad=
dr=2Eh"
 #include "proto=2Eh"
 
+#ifdef TARGET_LINUX
+static int
+set_lladd=
r_linux(openvpn_net_ctx_t *ctx, const char *ifname, const char *lladdr)
+{
=
+    uint8_t addr[OPENVPN_ETH_ALEN];
+
+    sscanf(lladdr, MAC_FMT, MAC_SCA=
N_ARG(addr));
+    return (net_addr_ll_set(ctx, ifname, addr) =3D=3D 0);
+}=

+#else /* TARGET_LINUX */
+
+#if defined(TARGET_OPENBSD) || defined(TARGET=
_FREEBSD) || defined(TARGET_DARWIN)
+#define IFCONFIG_LLADDR_FMT "%s %s lla=
ddr %s"
+#elif defined(TARGET_NETBSD)
+#define IFCONFIG_LLADDR_FMT "%s %s l=
ink %s active"
+#endif
+static int
+set_lladdr_ifconfig(const char *ifname,=
 const char *lladdr, const struct env_set *es)
+{
+#ifdef IFCONFIG_LLADDR_F=
MT
+    struct argv argv =3D argv_new();
+    argv_printf(&argv, IFCONFIG_L=
LADDR_FMT, IFCONFIG_PATH, ifname, lladdr);
+    argv_msg(M_INFO, &argv);
+ =
   int r =3D openvpn_execve_check(&argv, es, M_WARN, "ERROR: Unable to set =
link layer address=2E");
+    argv_free(&argv);
+    return r;
+#else
+    =
msg(M_WARN,
+        "Sorry, but I don't know how to configure link layer a=
ddresses on this operating system=2E");
+    return -1;
+#endif
+}
+#endif =
/* TARGET_LINUX */
+
 int
 set_lladdr(openvpn_net_ctx_t *ctx, const char *i=
fname, const char *lladdr, const struct env_set *es)
 {
-    int r;
-
     =
if (!ifname || !lladdr)
     {
         return -1;
     }
 
 #if defined(TA=
RGET_LINUX)
-    uint8_t addr[OPENVPN_ETH_ALEN];
+    int r =3D set_lladdr_=
linux(ctx, ifname, lladdr);
+#else
+    int r =3D set_lladdr_ifconfig(ifnam=
e, lladdr, es);
+#endif
 
-    sscanf(lladdr, MAC_FMT, MAC_SCAN_ARG(addr));=

-    r =3D (net_addr_ll_set(ctx, ifname, addr) =3D=3D 0);
-#else /* if def=
ined(TARGET_LINUX) */
-    struct argv argv =3D argv_new();
-#if defined(TA=
RGET_SOLARIS)
-    argv_printf(&argv, "%s %s ether %s", IFCONFIG_PATH, ifna=
me, lladdr);
-#elif defined(TARGET_OPENBSD)
-    argv_printf(&argv, "%s %s =
lladdr %s", IFCONFIG_PATH, ifname, lladdr);
-#elif defined(TARGET_DARWIN)
-=
    argv_printf(&argv, "%s %s lladdr %s", IFCONFIG_PATH, ifname, lladdr);
-=
#elif defined(TARGET_FREEBSD)
-    argv_printf(&argv, "%s %s ether %s", IFC=
ONFIG_PATH, ifname, lladdr);
-#else  /* if defined(TARGET_SOLARIS) */
-    =
msg(M_WARN,
-        "Sorry, but I don't know how to configure link layer a=
ddresses on this operating system=2E");
-    return -1;
-#endif /* if defin=
ed(TARGET_SOLARIS) */
-    argv_msg(M_INFO, &argv);
-    r =3D openvpn_exec=
ve_check(&argv, es, M_WARN, "ERROR: Unable to set link layer address=2E");
=
-    argv_free(&argv);
-#endif /* if defined(TARGET_LINUX) */
-
-    if (r)=

+    if (r > 0)
     {
         msg(M_INFO, "TUN/TAP link layer address se=
t to %s", lladdr);
     }

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1675?usp=3Demail
To unsubscribe, or for help writing mail filt=
ers, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Ch=
ange-Id: Ibe7b3c17176c97a1cbb4d9cc87735b05e62c4f43
Gerrit-Change-Number: 16=
75
Gerrit-PatchSet: 6
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
=
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>

--kB89tXVMF1o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #6</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1675?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">lladdr: Clean up code and =
BSD support<br><br>cppcheck complained about the creation of a useless<br>v=
ariable on Windows=2E With the old code this was not<br>fixable in a good w=
ay=2E So rewrite the whole code to<br>hopefully be much more readable=2E<br=
><br>While testing this we also found out that the old<br>code was not real=
ly working on Solaris, so disable<br>support for that=2E<br><br>Gert Doerin=
g contributed support for NetBSD=2E<br><br>Github: closes OpenVPN/openvpn#1=
034<br>Change-Id: Ibe7b3c17176c97a1cbb4d9cc87735b05e62c4f43<br>Signed-off-b=
y: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Gert Doer=
ing &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1675<br>Message-Id: &lt;20260724220839=2E26402-1-gert@gr=
eenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel=
@lists=2Esourceforge=2Enet/msg37863=2Ehtml<br>Signed-off-by: Gert Doering &=
lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/lladdr=2Ec<br>1 file=
 changed, 39 insertions(+), 26 deletions(-)<br><br></pre><pre class=3D"bloc=
ks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git =
pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/75/1675/6</pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><s=
pan>diff --git a/src/openvpn/lladdr=2Ec b/src/openvpn/lladdr=2Ec</span><br>=
<span>index d8bcad9=2E=2E195245f 100644</span><br><span>--- a/src/openvpn/l=
laddr=2Ec</span><br><span>+++ b/src/openvpn/lladdr=2Ec</span><br><span>@@ -=
13,42 +13,55 @@</span><br><span> #include &quot;lladdr=2Eh&quot;</span><br>=
<span> #include &quot;proto=2Eh&quot;</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#ifdef TARGET_LINUX</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+set_lladdr_linux(openvpn_net_ctx_t *ctx, const c=
har *ifname, const char *lladdr)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    u=
int8_t addr[OPENVPN_ETH_ALEN];</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ssca=
nf(lladdr, MAC_FMT, MAC_SCAN_ARG(addr));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    return (net_addr_ll_set(ctx, ifname, addr) =3D=3D =
0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#else /* TARGET_LINUX */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#if defined(TARGET_OPENBSD) || defined(TARGET_FR=
EEBSD) || defined(TARGET_DARWIN)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#define IFCONFIG_LLADDR_FMT &quot;%s %s lladdr %s&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#elif defined(TARGET_NETBS=
D)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define IFCONFIG_=
LLADDR_FMT &quot;%s %s link %s active&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static int</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+set_lladdr_ifconfig(const char *ifname, const char *lladdr, const struct =
env_set *es)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef IFCONFIG_LLADDR_FM=
T</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct argv ar=
gv =3D argv_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   argv_printf(&amp;argv, IFCONFIG_LLADDR_FMT, IFCONFIG_PATH, ifname, lladd=
r);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    argv_msg(M_I=
NFO, &amp;argv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 int r =3D openvpn_execve_check(&amp;argv, es, M_WARN, &quot;ERROR: Unable =
to set link layer address=2E&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    argv_free(&amp;argv);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return r;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#else</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    msg(M_WARN,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       &quot;Sorry, but I don&#39;t know how to configure link layer addres=
ses on this operating system=2E&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return -1;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* TARGET=
_LINUX */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> int</span><br><span> set_lladdr(openvpn_net_ctx_t *ctx, const char =
*ifname, const char *lladdr, const struct env_set *es)</span><br><span> {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int r;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     if (!ifname =
|| !lladdr)</span><br><span>     {</span><br><span>         return -1;</spa=
n><br><span>     }</span><br><span> </span><br><span> #if defined(TARGET_LI=
NUX)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t addr[=
OPENVPN_ETH_ALEN];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   int r =3D set_lladdr_linux(ctx, ifname, lladdr);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    int r =3D set_lladdr_ifconfig(ifname, lladdr, es);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    sscanf(lladdr=
, MAC_FMT, MAC_SCAN_ARG(addr));</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    r =3D (net_addr_ll_set(ctx, ifname, addr) =3D=3D 0);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#else /* if defined(TARGET_LIN=
UX) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct argv=
 argv =3D argv_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#if defined(TARGET_SOLARIS)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    argv_printf(&amp;argv, &quot;%s %s ether %s&quot;, IFCONFIG_PATH,=
 ifname, lladdr);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#eli=
f defined(TARGET_OPENBSD)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    argv_printf(&amp;argv, &quot;%s %s lladdr %s&quot;, IFCONFIG_PATH, =
ifname, lladdr);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif=
 defined(TARGET_DARWIN)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    argv_printf(&amp;argv, &quot;%s %s lladdr %s&quot;, IFCONFIG_PATH, if=
name, lladdr);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif d=
efined(TARGET_FREEBSD)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    argv_printf(&amp;argv, &quot;%s %s ether %s&quot;, IFCONFIG_PATH, ifna=
me, lladdr);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else  /*=
 if defined(TARGET_SOLARIS) */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    msg(M_WARN,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        &quot;Sorry, but I don&#39;t know how to configure link layer ad=
dresses on this operating system=2E&quot;);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    return -1;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#endif /* if defined(TARGET_SOLARIS) */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    argv_msg(M_INFO, &amp;argv);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    r =3D openvpn_execve_check(=
&amp;argv, es, M_WARN, &quot;ERROR: Unable to set link layer address=2E&quo=
t;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_free(&am=
p;argv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* if =
defined(TARGET_LINUX) */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (r)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (r &gt; 0)</span><br=
><span>     {</span><br><span>         msg(M_INFO, &quot;TUN/TAP link layer=
 address set to %s&quot;, lladdr);</span><br><span>     }</span><br><span><=
/span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1675?usp=3Demail">change 1675</a>=2E To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sche=
ma=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1675?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: Ibe7b3c17176c97a1cbb4d9cc87735b05e6=
2c4f43 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1675 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emu=
c=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=

</body></html>
--kB89tXVMF1o=--


--===============3262227817121676227==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3262227817121676227==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3262227817121676227==--

