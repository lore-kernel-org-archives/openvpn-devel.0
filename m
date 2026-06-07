Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C158DCD8C8C
	for <openvpn-devel@archiver.kernel.org>; Sun,  7 Jun 2026 17:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hi0P7lH/trvbgk4MyyMOLtaZlfDsdPrFmjXN+JSVtq0=; b=j5Vj2VCFP2xdvCEnwvhnI5DUYO
	aV3Rk4Eq8vTljJjzq/RsM1X5nwhvoz8H3nvOt/h1cCLjX0MdJUdbnaQ6+p2b3o8plWeE6bGnNKjv1
	CX39/XyfsV1aM1e7J+bxyVph+fXeTooBhOblTXc/ntxKeFXfs+d7tZDxV3vFScO1eZZU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWGsC-0002CB-KU;
	Sun, 07 Jun 2026 17:01:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wWGsB-0002C4-7w
 for openvpn-devel@lists.sourceforge.net;
 Sun, 07 Jun 2026 17:01:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=awleg9tDajj4lA9dh6Zka9VsOz9SbmjbM8S9RpiFEos=; b=ZFhGe9pipm/RastY4Ioo6UUeGx
 WToTjB/SXGEieZiY1xiroHPV+y8PYo25ED5sOOxIx/XV2xzAJIwx7orLHfLHvaF5RSKXZnOFl/4v/
 RgmmDi7PZDMV4JOgLNvrJNvoWjcNqef53AKyf0Myg0V9BCYru/hbymjKSKOC/sSG/62A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=awleg9tDajj4lA9dh6Zka9VsOz9SbmjbM8S9RpiFEos=; b=c
 wS8SniqVMmoOXdbpk2BET6qsZ8PtvyIQLTifV6j2P3S+KkkgVQOEkZ3KBLeZsuefdAeoT1vut4/SO
 3XHnNefFYbP5RO3sQd5+4GGgU8EGtfpJwb0yWYWrXBNbDdDGroH9dZ+/2QJWP9Y+gpUjrlm9jYRsf
 53CxrO8liP0iC/O4=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wWGs9-0000fT-G2 for openvpn-devel@lists.sourceforge.net;
 Sun, 07 Jun 2026 17:01:19 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so1109295e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 07 Jun 2026 10:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1780851671; x=1781456471; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=awleg9tDajj4lA9dh6Zka9VsOz9SbmjbM8S9RpiFEos=;
 b=N0zZJVMC3gUMhO17FXQrbFOMeuhQWYy5F3Z7LeJ/D49jbSkmT6SW/X4oigUC94Z2eC
 GOPvMshouWdZss0YIRKf1Cs3k9g5LsXKfxkQDYkwvYqIm4gcaIckpFrxXnf9lX4/60QP
 6KipfHFCpCr3jicZeRRkVRU61l6gD9QqV/Mlh0YobPna7guvyx2kce/x7eaZchL/H/gB
 4sfrG449kmxOcnjmik100UCZuRC2AGNNpBDYcRD6X6P/6b8iFUwJCXtG+lsO01C0Aaw1
 c65wEJmQUDUoxVTZqELfs9SuZTu5dA6XEdIWgvT7PnjRHB5i9c8a5VZllYXx3SDPvdp3
 Tdyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780851671; x=1781456471;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=awleg9tDajj4lA9dh6Zka9VsOz9SbmjbM8S9RpiFEos=;
 b=oLea62cL2qwZX3ZGTXsT5V+5FfHqh7TUjQ/f744pl/szNbueeDqfcCaZ72AIqfs7T4
 Pc2BGn/N+Dk0LVcUElNlXYRuZTGJY8gPDfA4BkW/zWqxl5cIPR6Kjl9jbnJ3sZtG4al0
 pOqmF+WGLc+mlp79jnFgiXByHIfLT+YQaTVAYmgWMKj2X2+pWfAyS7QT8Vavk6rm8Rss
 j960YPdlQpMcFYs73QPoE50icTM8sXJpiLiE+Rq+FvlL09mx2UQxfRjUkDcHPZel5vEP
 kfvOoY8f/f8Z49XbnvDmWCpybKGYreeQsHIm6ccuVO5bkE23ttjhifQ2uryCOXvPjUzH
 dQTQ==
X-Gm-Message-State: AOJu0YxCJuoqMdDfXBMStixpLwfG0Hw2R3RLe3Jj8va1+EJjZxiwcX9S
 voDi1NXtvyFSGjdtStA+x7GRY1MP/7tcn1XC2ExxuDLyR60jyaNFWPl7PRF5576gCPQQjxrBRrt
 j9kASmnnBy+NddXLCRxHp7Jotv8abigOo479MqPIyh3poaAAWbjRZTG3MNPW3km/O3SGI
X-Gm-Gg: Acq92OHelDwe45OajLjvCaXfNUcqG1sFF4OmXb/DAK4cqQrgd1yXG6cwZFtCKe+KDug
 aNFVPLvnsRBSBrdi9Gd9Q33gLrXX+X/biOTvLT4jI/tu0tar0WbGg/XmFbb05FcqIZKn54JqUG1
 QMzgLCSdGLoZ7au1beQU24pxK3DfbpOPQsDzIyrfTUoz1pVtdTDeknrW8ckaUXhoJNcKouLC7Hj
 CzzdIm+4IRwYC/sX19yUdZ4K6B9sqeuqKTiNhXPgX7fEOFp9VmrTCpVgoZQoEOWc/JYXy7k9JI3
 SjcCMSlFBCV7iwe0wlLL4uD+6+o891E48F4hHPrfCwFsXjJ1nZPy2mj0GCAa6dVGQGwd9mQ9eTA
 XRpPBDZ6n6ESux9XlwVW7q44w7XYse0S/o+G/fb2pQSH1IfDIvEGuk9rraAaylIQKdN0w38QMr0
 s5iDHMTWrHxdIGQWlmlNi8JqAPfYYSCpxZxd+uwhX2JNe3w8aetBLnn9ohYV1jKlhpWbr83cVgZ
 owPAvr0IYaRH0KhUUJCEJJM4O1AnERAnRSlcwiHCbEFsbj20ANcZTeJbTu6okKU/FGUTsI3j4ze
 rC24qUvHl+s19q7wI86A2HVY
X-Received: by 2002:a05:600c:818c:b0:490:6237:521d with SMTP id
 5b1f17b1804b1-490c25b3ca5mr216123315e9.13.1780851670922; 
 Sun, 07 Jun 2026 10:01:10 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490c2d30eeasm192908725e9.1.2026.06.07.10.01.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 10:01:10 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 7 Jun 2026 17:01:08 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, MaxF <max@max-fillinger.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iff8b336126a5dff9871213664b1e8585fb70d21e
X-Gerrit-Change-Number: 1707
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1707?usp=email>
X-Gerrit-Commit: aca8546df6b04afee275b78f92f5564f5590f76a
In-Reply-To: <gerrit.1780494160000.Iff8b336126a5dff9871213664b1e8585fb70d21e@gerrit.openvpn.net>
References: <gerrit.1780494160000.Iff8b336126a5dff9871213664b1e8585fb70d21e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgwNDk0MTYwMDAwLklmZjhiMzM2MTI2YTVkZmY5ODcxMjEzNjY0YjFlODU4NWZiNzBkMjFlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <de09642160b68f53de39d88962ae1400d25ce147-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wWGs9-0000fT-G2
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Ensure pushed
 tun-mtu is no lower than TUN_MTU_MIN
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
 openvpn-devel@lists.sourceforge.net, max@max-fillinger.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2428764871126705885=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2428764871126705885==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XHQgVLUNngs="; charset=UTF-8

--XHQgVLUNngs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1707?usp=3Demail =
)

The following approvals got outdated and were removed:
Code-Review+2 by =
MaxF


Change subject: Ensure pushed tun-mtu is no lower than TUN_MTU_MIN
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Ensure pushed=
 tun-mtu is no lower than TUN_MTU_MIN

The normal path ensure that the mini=
mum tun mtu is set to at least
TUN_MTU_MIN=2E However, the pushed options p=
ath does not have this
restriction=2E

Check that the tun-mtu is within the=
 limits of min/max mtu
in options=2Ec=2E This ensure that the check is also=
 correctly done
on the pushed variant=2E

Also add an extra check to keep t=
he allowed payload for icmp6 packets
to be at least 64 bytes in the the blo=
ck-ipv6 code path
(ipv6_send_icmp_unreachable) as extra layer of defence=2E=


Pushing a low mtu like 1 and also block-ipv6 could trigger an
assertion i=
n the ipv6_send_icmp_unreachable code path=2E

Reported-By: Haiyang Huang <=
huanghaiyang83@gmail=2Ecom>
Change-Id: Iff8b336126a5dff9871213664b1e8585fb7=
0d21e
Signed-off-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Acked-by: Ma=
xF <max@max-fillinger=2Enet>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1707
Message-Id: <20260605180931=2E3547-1-gert@greenie=2Emuc=2Ede>=

URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2E=
net/msg37069=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
-=
--
M src/openvpn/forward=2Ec
M src/openvpn/mtu=2Eh
M src/openvpn/options=2E=
c
3 files changed, 20 insertions(+), 11 deletions(-)


  git pull ssh://ger=
rit=2Eopenvpn=2Enet:29418/openvpn refs/changes/07/1707/2

diff --git a/src/=
openvpn/forward=2Ec b/src/openvpn/forward=2Ec
index 27cfd36=2E=2Ed24f534 10=
0644
--- a/src/openvpn/forward=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -1598,7=
 +1598,9 @@
      * frame should be <=3D 1280 and have as much as possible =
of the original
      * packet
      */
-    const int max_payload_size =3D=
 min_int(MAX_ICMPV6LEN, c->c2=2Eframe=2Etun_mtu - icmpheader_len);
+    int=
 max_payload_size =3D min_int(MAX_ICMPV6LEN, c->c2=2Eframe=2Etun_mtu - icmp=
header_len);
+    /* Ensure that minimum payload size is at least 64 bytes =
as extra safety layer */
+    max_payload_size =3D max_int(max_payload_size=
, 64);
     const int payload_len =3D min_int(max_payload_size, BLEN(&input=
ipbuf));
     const uint16_t icmp_len =3D (uint16_t)(sizeof(struct openvpn_=
icmp6hdr) + payload_len);
 
diff --git a/src/openvpn/mtu=2Eh b/src/openvpn/=
mtu=2Eh
index ca8109c=2E=2E8f07e75 100644
--- a/src/openvpn/mtu=2Eh
+++ b/s=
rc/openvpn/mtu=2Eh
@@ -68,6 +68,11 @@
  */
 #define TUN_MTU_DEFAULT 1500
 
=
+/**
+ * Maximum MTU we accept for MTU related options
+ */
+#define TUN_MT=
U_MAX 65536
+
 /*
  * Minimum maximum MTU
  */
diff --git a/src/openvpn/opt=
ions=2Ec b/src/openvpn/options=2Ec
index 0c2866c=2E=2E128d1e5 100644
--- a/=
src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -6409,26 +6409,28 =
@@
     else if (streq(p[0], "tun-mtu") && p[1] && !p[3])
     {
         V=
ERIFY_PERMISSION(OPT_P_PUSH_MTU | OPT_P_CONNECTION);
-        options->ce=
=2Etun_mtu =3D positive_atoi(p[1], msglevel);
-        options->ce=2Etun_mt=
u_defined =3D true;
-        if (p[2])
+        if (atoi_constrained(p[1], =
&options->ce=2Etun_mtu, "tun-mtu", TUN_MTU_MIN, TUN_MTU_MAX, msglevel))
   =
      {
-            options->ce=2Eocc_mtu =3D positive_atoi(p[2], msglevel=
);
-        }
-        else
-        {
-            options->ce=2Eocc_mtu =
=3D 0;
+            options->ce=2Etun_mtu_defined =3D true;
+            if=
 (p[2])
+            {
+                atoi_constrained(p[2], &options->ce=
=2Eocc_mtu, "tun-mtu occ-mtu", TUN_MTU_MIN, TUN_MTU_MAX, msglevel);
+      =
      }
+            else
+            {
+                options->ce=2Eocc=
_mtu =3D 0;
+            }
         }
     }
     else if (streq(p[0], "tun=
-mtu-max") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_MTU | =
OPT_P_CONNECTION);
-        atoi_constrained(p[1], &options->ce=2Etun_mtu_m=
ax, p[0], TUN_MTU_MAX_MIN, 65536, msglevel);
+        atoi_constrained(p[1]=
, &options->ce=2Etun_mtu_max, p[0], TUN_MTU_MAX_MIN, TUN_MTU_MAX, msglevel)=
;
     }
     else if (streq(p[0], "tun-mtu-extra") && p[1] && !p[2])
     =
{
         VERIFY_PERMISSION(OPT_P_MTU | OPT_P_CONNECTION);
-        if (at=
oi_constrained(p[1], &options->ce=2Etun_mtu_extra, p[0], 0, 65536, msglevel=
))
+        if (atoi_constrained(p[1], &options->ce=2Etun_mtu_extra, p[0], =
0, TUN_MTU_MAX, msglevel))
         {
             options->ce=2Etun_mtu_ex=
tra_defined =3D true;
         }

-- 
To view, visit http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1707?usp=3Demail
To unsubscribe, or for help writing ma=
il filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: Iff8b336126a5dff9871213664b1e8585fb70d21e
Gerrit-Change-Num=
ber: 1707
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: MaxF <max@max-fillinger=2Enet>
Gerrit-CC: openvpn-=
devel <openvpn-devel@lists=2Esourceforge=2Enet>

--XHQgVLUNngs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by plaisthos=
=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1707?usp=3De=
mail">View Change</a></p><p>The following approvals got outdated and were r=
emoved:
Code-Review+2 by MaxF</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">Ensure pushed tun-mtu is no =
lower than TUN_MTU_MIN<br><br>The normal path ensure that the minimum tun m=
tu is set to at least<br>TUN_MTU_MIN=2E However, the pushed options path do=
es not have this<br>restriction=2E<br><br>Check that the tun-mtu is within =
the limits of min/max mtu<br>in options=2Ec=2E This ensure that the check i=
s also correctly done<br>on the pushed variant=2E<br><br>Also add an extra =
check to keep the allowed payload for icmp6 packets<br>to be at least 64 by=
tes in the the block-ipv6 code path<br>(ipv6_send_icmp_unreachable) as extr=
a layer of defence=2E<br><br>Pushing a low mtu like 1 and also block-ipv6 c=
ould trigger an<br>assertion in the ipv6_send_icmp_unreachable code path=2E=
<br><br>Reported-By: Haiyang Huang &lt;huanghaiyang83@gmail=2Ecom&gt;<br>Ch=
ange-Id: Iff8b336126a5dff9871213664b1e8585fb70d21e<br>Signed-off-by: Arne S=
chwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Acked-by: MaxF &lt;max@max-fil=
linger=2Enet&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1707<br>Message-Id: &lt;20260605180931=2E3547-1-gert@greenie=2Emuc=2Ede&gt;=
<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg37069=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emu=
c=2Ede&gt;<br>---<br>M src/openvpn/forward=2Ec<br>M src/openvpn/mtu=2Eh<br>=
M src/openvpn/options=2Ec<br>3 files changed, 20 insertions(+), 11 deletion=
s(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418=
/openvpn refs/changes/07/1707/2</pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/forward=2E=
c b/src/openvpn/forward=2Ec</span><br><span>index 27cfd36=2E=2Ed24f534 1006=
44</span><br><span>--- a/src/openvpn/forward=2Ec</span><br><span>+++ b/src/=
openvpn/forward=2Ec</span><br><span>@@ -1598,7 +1598,9 @@</span><br><span> =
     * frame should be &lt;=3D 1280 and have as much as possible of the ori=
ginal</span><br><span>      * packet</span><br><span>      */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    const int max_payload_size =3D =
min_int(MAX_ICMPV6LEN, c-&gt;c2=2Eframe=2Etun_mtu - icmpheader_len);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    int max_payload_size =
=3D min_int(MAX_ICMPV6LEN, c-&gt;c2=2Eframe=2Etun_mtu - icmpheader_len);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Ensure that min=
imum payload size is at least 64 bytes as extra safety layer */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    max_payload_size =3D max_in=
t(max_payload_size, 64);</span><br><span>     const int payload_len =3D min=
_int(max_payload_size, BLEN(&amp;inputipbuf));</span><br><span>     const u=
int16_t icmp_len =3D (uint16_t)(sizeof(struct openvpn_icmp6hdr) + payload_l=
en);</span><br><span> </span><br><span>diff --git a/src/openvpn/mtu=2Eh b/s=
rc/openvpn/mtu=2Eh</span><br><span>index ca8109c=2E=2E8f07e75 100644</span>=
<br><span>--- a/src/openvpn/mtu=2Eh</span><br><span>+++ b/src/openvpn/mtu=
=2Eh</span><br><span>@@ -68,6 +68,11 @@</span><br><span>  */</span><br><spa=
n> #define TUN_MTU_DEFAULT 1500</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * Maximum MTU we accept for MTU related options</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#define TUN_MTU_MAX 65536</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * =
Minimum maximum MTU</span><br><span>  */</span><br><span>diff --git a/src/o=
penvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index 0c2866c=
=2E=2E128d1e5 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><b=
r><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -6409,26 +6409,28 =
@@</span><br><span>     else if (streq(p[0], &quot;tun-mtu&quot;) &amp;&amp=
; p[1] &amp;&amp; !p[3])</span><br><span>     {</span><br><span>         VE=
RIFY_PERMISSION(OPT_P_PUSH_MTU | OPT_P_CONNECTION);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        options-&gt;ce=2Etun_mtu =3D positi=
ve_atoi(p[1], msglevel);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        options-&gt;ce=2Etun_mtu_defined =3D true;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (p[2])</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (atoi_constrained(p[1], &amp;optio=
ns-&gt;ce=2Etun_mtu, &quot;tun-mtu&quot;, TUN_MTU_MIN, TUN_MTU_MAX, msgleve=
l))</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            options-&gt;ce=2Eocc_mtu =3D positive_atoi(p[2], msgle=
vel);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        else</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            options-&gt;ce=2Eocc_mtu =3D 0;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            options-&gt;c=
e=2Etun_mtu_defined =3D true;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            if (p[2])</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                atoi_constrained(p[2], &amp;options-&gt;ce=2Eocc_mtu,=
 &quot;tun-mtu occ-mtu&quot;, TUN_MTU_MIN, TUN_MTU_MAX, msglevel);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            else</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                options-&gt;ce=2Eocc_mtu =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }=
</span><br><span>         }</span><br><span>     }</span><br><span>     els=
e if (streq(p[0], &quot;tun-mtu-max&quot;) &amp;&amp; p[1] &amp;&amp; !p[2]=
)</span><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_M=
TU | OPT_P_CONNECTION);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        atoi_constrained(p[1], &amp;options-&gt;ce=2Etun_mtu_max, p[0], T=
UN_MTU_MAX_MIN, 65536, msglevel);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        atoi_constrained(p[1], &amp;options-&gt;ce=2Etun_mtu_=
max, p[0], TUN_MTU_MAX_MIN, TUN_MTU_MAX, msglevel);</span><br><span>     }<=
/span><br><span>     else if (streq(p[0], &quot;tun-mtu-extra&quot;) &amp;&=
amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>        =
 VERIFY_PERMISSION(OPT_P_MTU | OPT_P_CONNECTION);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        if (atoi_constrained(p[1], &amp;options=
-&gt;ce=2Etun_mtu_extra, p[0], 0, 65536, msglevel))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (atoi_constrained(p[1], &amp;o=
ptions-&gt;ce=2Etun_mtu_extra, p[0], 0, TUN_MTU_MAX, msglevel))</span><br><=
span>         {</span><br><span>             options-&gt;ce=2Etun_mtu_extra=
_defined =3D true;</span><br><span>         }</span><br><span></span><br></=
pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1707?usp=3Demail">change 1707</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eo=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1707?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpat=
chset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<d=
iv style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Id: Iff8b336126a5dff9871213664b1e8585fb70d21e </div=
>
<div style=3D"display:none"> Gerrit-Change-Number: 1707 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> G=
errit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@max-fillinger=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-deve=
l@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--XHQgVLUNngs=--


--===============2428764871126705885==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2428764871126705885==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2428764871126705885==--

