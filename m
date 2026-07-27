Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F457C5321C
	for <openvpn-devel@archiver.kernel.org>; Mon, 27 Jul 2026 10:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s5cNahI213OCVyJZa51IAv5ZKxMLNYqrXJ9EI51bfWw=; b=DTAieBbjq84bpkJXdHAvkzftmF
	jTOdpRDWUo2K1R6BGBG1JddlzxxN8pzH5TA8MO5PDwgDIH8YtWO+jdjUjOdCA70Y0YXpIoWshcEGl
	QbLQbF/h9QBt8B0yWdDu6pKK/RBrkA81VsT3ZErS7LshQNre2SrhKT21F0WCyNTi/Cpo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1woID5-0002cb-RI;
	Mon, 27 Jul 2026 10:05:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1woID5-0002cR-2D
 for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 10:05:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=X0YF2ajj/UDemaWvj32pDt+5lJqGYMwQupG0hvIoijg=; b=L9mCK+LRowNkcqXjrYruZUZ+T3
 Qt5XFIkX+LS7l6P2UVntVfYYGW3PVcdfjxtZANsSiWe0vtzOrbXNTxsWl02IfJxFuK4OU8AhyAK9M
 JzEq3ZydcdrPPeNMMkQYxP2rQgT84Miwp/y+MWkWfIwfD+ZxDPSxffbycmc05+X6kUD4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=X0YF2ajj/UDemaWvj32pDt+5lJqGYMwQupG0hvIoijg=; b=K
 skY15Uth7qyj+hOZQyg/MnWQapXiBBfQEH/CClDmyA5BqduEFXhq+ouzaILH5qlN3XV0gog+2jELl
 h8I1gkhgq1foXnTAPjLFkwHACUvoyL/03Afs06pNZkqfSGHlnOUeRNkrgIKGYNH5LtMvhg2oMn7ID
 Ov3WagdVfNlAQXFg=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1woID4-0000yc-2A for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 10:05:23 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4953de5be0aso16916625e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 27 Jul 2026 03:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785146715; x=1785751515; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=X0YF2ajj/UDemaWvj32pDt+5lJqGYMwQupG0hvIoijg=;
 b=VtW0mehcI65CNcF88NhNxqc2lwSvIKafwoXA3FptOQZB+CICsjFgq0Sb3H18UiGmLV
 q+udI92VTrZLZf307ZnDynBQatH/L0stvc7mscnumLX1fBbuf+ZltK/sxDi1AKi4+BTD
 0OzGNhaqEqAzzznoR3v/oadS0+bjiHAsKldBkLmGhK43rVGe0tVf3bK4d3Rjx+FYxGhW
 JeSTjzgCvq1KuMpLKGGCxbInTep5bGAWN6qzRxchK220oRcQdh16VcKACQaxgVfiuniz
 IbCy2uLzllsVJMSFZl7EJ4F/rZRuQW8xXIDC7RCFMWosnugRuaIDhIviBndQiv1vcXxO
 LU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785146715; x=1785751515;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=X0YF2ajj/UDemaWvj32pDt+5lJqGYMwQupG0hvIoijg=;
 b=AbxKbj4TINnSTNFDvCukzPvzCCAN7qqKHU7U8xguqs+LV2w0YgfoZLhPo261oeuEYl
 88+mq+yJoY7Qogf4yvMPHyLcua+5hRHsBdN7VNGeLObnqQDNCksoV5vlwCEgX13QQkpF
 p1/WUMg8A6xLV7e9anWNuJsz9iVV7DpmXXBRwwy35RC1mZ/E89Tln+gf0rMM5oHjcwB4
 929nw+/myVoacZh3XoKmvSzJ4RzB4fzWNOfqlz+18km8Kwtq7sV7nH77rZUlpA6+lzog
 r1H+Q+yR7Pl7DrqDBekm0+DbO5GFa+k+R9iKlSD3Jj3P7y/SQRzKuKMAX51wqFNrTKXW
 KPLw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrSPWV8iDv7aEmxeRtOaVkEDe9mZO7TY4yYRsiQ8m7IDOuiNISslkbw2FGXf0LRvIG9Q04CGxQw7/q8koXD@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyWv7mCRSbHjYNj3wGWGWILwabEPjsoJTtrvHcW1pofS2F4d9mo
 dcS/0F9SeJCmJ8h8XLRophbPEreBNRoJoz+kCExBjnFi3/39Ye/nEcEX+wSgQpelhvM9tERuMzW
 aBxqUiPEJOvnD5xYM6GrG+TdU5gKi6tyGDxYhKuOyi0QwcyY/cfUrqyAxu8+5m/SdlTDY
X-Gm-Gg: AR+sD11PwV1XUwri2/ah1BsXTT7dLPuqM5SYa4uda9YkLBjNgDPPvKf3Bu0bIOSeZjQ
 dWpH5P+2rcwqP8cDWE+xp37uKjC02o6frUp6sJkNMjXubEqFSRVAz/8OZ8eadePhy5VilXMNvRN
 FpRrGdh9htQ1l3ZdtfSQrtYb9640OpmcfEuph6+JvqIx7IFstBcOdEuXQ2rVq1IWwW+f5b44n8g
 nddqD2vLam+dOnqyeeHjwcorJhwQYWIHElOVLmv26W4S6LATGznUFXAD9cdaTLPkbAF4til7buE
 TwZtz6usDHw1M6gicE3u7KrOYBunPdGNcxDtgZ07Ct9XsTlniLQ0lMitYsgvUDYPh99S5TUpd8n
 L1VdH75mBCuxV2q288bMFRwbIOsGbdijDZTlbJa6oLRX6Sgmjmb3REyifcqpsOHk3y5qgKmL0vR
 9uUudRBLRaVwOvS2znxZOSkys9KbNl7L+FGH/GwobODMCW3o+QbjyEIISXgYYYR6bdJjJBEkcj/
 bPRd2ojiMZ4LnrE20k0gB+E3of8SeHJLRx9vNJw57OJhjkFLQfXAlPEfo582DfymVWJ
X-Received: by 2002:a05:600c:5492:b0:495:7eab:3abd with SMTP id
 5b1f17b1804b1-496b5736f4fmr110712245e9.33.1785146715294; 
 Mon, 27 Jul 2026 03:05:15 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b4c8d6b5sm150618255e9.2.2026.07.27.03.05.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 03:05:14 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 27 Jul 2026 10:05:14 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: Ibe7b3c17176c97a1cbb4d9cc87735b05e62c4f43
X-Gerrit-Change-Number: 1675
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1675?usp=email>
X-Gerrit-Commit: 1e918232e20c4d09b4e0dcdbf91fbb5d5cb9cb23
In-Reply-To: <gerrit.1778239616000.Ibe7b3c17176c97a1cbb4d9cc87735b05e62c4f43@gerrit.openvpn.net>
References: <gerrit.1778239616000.Ibe7b3c17176c97a1cbb4d9cc87735b05e62c4f43@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MjM5NjE2MDAwLkliZTdiM2MxNzE3NmM5N2ExY2JiNGQ5Y2M4NzczNWIwNWU2MmM0ZjQzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <16ed84c2c7e7bc7ac7cf2e3d395897227df26d58-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1woID4-0000yc-2A
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4022895958476259884=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4022895958476259884==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pRH0j+mqq/Y="; charset=UTF-8

--pRH0j+mqq/Y=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1675?usp=3Demail )

Change subject: lladdr: Clean up code and BSD suppo=
rt
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

lladdr: Cl=
ean up code and BSD support

cppcheck complained about the creation of a us=
eless
variable on Windows=2E With the old code this was not
fixable in a go=
od way=2E So rewrite the whole code to
hopefully be much more readable=2E

=
While testing this we also found out that the old
code was not really worki=
ng on Solaris, so disable
support for that=2E

Gert Doering contributed sup=
port for NetBSD=2E

Github: closes OpenVPN/openvpn#1034
Change-Id: Ibe7b3c1=
7176c97a1cbb4d9cc87735b05e62c4f43
Signed-off-by: Frank Lichtenheld <frank@l=
ichtenheld=2Ecom>
Acked-by: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit U=
RL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1675
Message-Id: <2026072422=
0839=2E26402-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ec=
om/openvpn-devel@lists=2Esourceforge=2Enet/msg37863=2Ehtml
Signed-off-by: G=
ert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/lladdr=2Ec
1 file c=
hanged, 39 insertions(+), 26 deletions(-)




diff --git a/src/openvpn/llad=
dr=2Ec b/src/openvpn/lladdr=2Ec
index d8bcad9=2E=2E195245f 100644
--- a/src=
/openvpn/lladdr=2Ec
+++ b/src/openvpn/lladdr=2Ec
@@ -13,42 +13,55 @@
 #incl=
ude "lladdr=2Eh"
 #include "proto=2Eh"
 
+#ifdef TARGET_LINUX
+static int
+=
set_lladdr_linux(openvpn_net_ctx_t *ctx, const char *ifname, const char *ll=
addr)
+{
+    uint8_t addr[OPENVPN_ETH_ALEN];
+
+    sscanf(lladdr, MAC_FMT=
, MAC_SCAN_ARG(addr));
+    return (net_addr_ll_set(ctx, ifname, addr) =3D=
=3D 0);
+}
+#else /* TARGET_LINUX */
+
+#if defined(TARGET_OPENBSD) || defi=
ned(TARGET_FREEBSD) || defined(TARGET_DARWIN)
+#define IFCONFIG_LLADDR_FMT =
"%s %s lladdr %s"
+#elif defined(TARGET_NETBSD)
+#define IFCONFIG_LLADDR_FM=
T "%s %s link %s active"
+#endif
+static int
+set_lladdr_ifconfig(const cha=
r *ifname, const char *lladdr, const struct env_set *es)
+{
+#ifdef IFCONFI=
G_LLADDR_FMT
+    struct argv argv =3D argv_new();
+    argv_printf(&argv, =
IFCONFIG_LLADDR_FMT, IFCONFIG_PATH, ifname, lladdr);
+    argv_msg(M_INFO, =
&argv);
+    int r =3D openvpn_execve_check(&argv, es, M_WARN, "ERROR: Unab=
le to set link layer address=2E");
+    argv_free(&argv);
+    return r;
+#=
else
+    msg(M_WARN,
+        "Sorry, but I don't know how to configure li=
nk layer addresses on this operating system=2E");
+    return -1;
+#endif
+=
}
+#endif /* TARGET_LINUX */
+
 int
 set_lladdr(openvpn_net_ctx_t *ctx, con=
st char *ifname, const char *lladdr, const struct env_set *es)
 {
-    int =
r;
-
     if (!ifname || !lladdr)
     {
         return -1;
     }
 
 #if =
defined(TARGET_LINUX)
-    uint8_t addr[OPENVPN_ETH_ALEN];
+    int r =3D s=
et_lladdr_linux(ctx, ifname, lladdr);
+#else
+    int r =3D set_lladdr_ifco=
nfig(ifname, lladdr, es);
+#endif
 
-    sscanf(lladdr, MAC_FMT, MAC_SCAN_A=
RG(addr));
-    r =3D (net_addr_ll_set(ctx, ifname, addr) =3D=3D 0);
-#else=
 /* if defined(TARGET_LINUX) */
-    struct argv argv =3D argv_new();
-#if =
defined(TARGET_SOLARIS)
-    argv_printf(&argv, "%s %s ether %s", IFCONFIG_=
PATH, ifname, lladdr);
-#elif defined(TARGET_OPENBSD)
-    argv_printf(&arg=
v, "%s %s lladdr %s", IFCONFIG_PATH, ifname, lladdr);
-#elif defined(TARGET=
_DARWIN)
-    argv_printf(&argv, "%s %s lladdr %s", IFCONFIG_PATH, ifname, =
lladdr);
-#elif defined(TARGET_FREEBSD)
-    argv_printf(&argv, "%s %s ethe=
r %s", IFCONFIG_PATH, ifname, lladdr);
-#else  /* if defined(TARGET_SOLARIS=
) */
-    msg(M_WARN,
-        "Sorry, but I don't know how to configure li=
nk layer addresses on this operating system=2E");
-    return -1;
-#endif /=
* if defined(TARGET_SOLARIS) */
-    argv_msg(M_INFO, &argv);
-    r =3D op=
envpn_execve_check(&argv, es, M_WARN, "ERROR: Unable to set link layer addr=
ess=2E");
-    argv_free(&argv);
-#endif /* if defined(TARGET_LINUX) */
-
-=
    if (r)
+    if (r > 0)
     {
         msg(M_INFO, "TUN/TAP link layer =
address set to %s", lladdr);
     }

-- 
To view, visit http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1675?usp=3Demail
To unsubscribe, or for help writing=
 mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ge=
rrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerr=
it-Change-Id: Ibe7b3c17176c97a1cbb4d9cc87735b05e62c4f43
Gerrit-Change-Numbe=
r: 1675
Gerrit-PatchSet: 6
Gerrit-Owner: flichtenheld <frank@lichtenheld=2E=
com>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plai=
sthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@=
lists=2Esourceforge=2Enet>

--pRH0j+mqq/Y=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1675?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">lladdr: Clean up code and BSD support<br><=
br>cppcheck complained about the creation of a useless<br>variable on Windo=
ws=2E With the old code this was not<br>fixable in a good way=2E So rewrite=
 the whole code to<br>hopefully be much more readable=2E<br><br>While testi=
ng this we also found out that the old<br>code was not really working on So=
laris, so disable<br>support for that=2E<br><br>Gert Doering contributed su=
pport for NetBSD=2E<br><br>Github: closes OpenVPN/openvpn#1034<br>Change-Id=
: Ibe7b3c17176c97a1cbb4d9cc87735b05e62c4f43<br>Signed-off-by: Frank Lichten=
held &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Gert Doering &lt;gert@gre=
enie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1675<br>Message-Id: &lt;20260724220839=2E26402-1-gert@greenie=2Emuc=2Ede=
&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcef=
orge=2Enet/msg37863=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/lladdr=2Ec<br>1 file changed, 39 in=
sertions(+), 26 deletions(-)<br><br></pre>
<pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/llad=
dr=2Ec b/src/openvpn/lladdr=2Ec</span><br><span>index d8bcad9=2E=2E195245f =
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
fined(TARGET_OPENBSD) || defined(TARGET_FREEBSD) || defined(TARGET_DARWIN)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define IFCONFIG_LLA=
DDR_FMT &quot;%s %s lladdr %s&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#elif defined(TARGET_NETBSD)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#define IFCONFIG_LLADDR_FMT &quot;%s %s link %s ac=
tive&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+set_lladdr_ifconfig(const char =
*ifname, const char *lladdr, const struct env_set *es)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#ifdef IFCONFIG_LLADDR_FMT</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct argv argv =3D argv_new();</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    argv_printf(&amp;argv, IFCONFI=
G_LLADDR_FMT, IFCONFIG_PATH, ifname, lladdr);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    argv_msg(M_INFO, &amp;argv);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    int r =3D openvpn_execve_check(&=
amp;argv, es, M_WARN, &quot;ERROR: Unable to set link layer address=2E&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    argv_free(&a=
mp;argv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return=
 r;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    msg(M_WARN,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        &quot;Sorry, but I don&#39=
;t know how to configure link layer addresses on this operating system=2E&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return -1=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#endif /* TARGET_LINUX */</span><br><span style=
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


<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: Ibe7b3c17176c97a1cbb4d9cc87735b05e62c4f43 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1675 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-dev=
el@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--pRH0j+mqq/Y=--


--===============4022895958476259884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4022895958476259884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4022895958476259884==--

