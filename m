Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA42606A323
	for <openvpn-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Wjb/FGV9;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=j743ZO0J;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=DRCtsM6R;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Zpbq8IER
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=2iM9+0pSxhf3brJGmunaZW5PKpE6iaVwh738Yjkw3wA=; b=Wjb/FGV9ufho622mUiitIOBK+O
	Knkp2EQUOGV2pplQi+RPaEU3r/NuM6bSDjWgIvG4X7ubu2OqTx7ek61lC8lc1Ej+OLINe6YfQpg6b
	/eJPyLkc98qTWxwUc5HJziUOCajwvWk/ruxsf0LoFoDanwMiB4vNOevwM/pZMId8zGuo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSGcd-0000000075y-0cSv;
	Sat, 14 Nov 2026 16:28:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSGcb-0000000075n-0vgi
 for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 16:28:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6N0iuT0IuVYxSEk2UnobdYR9Ph/zQOqyP8bF8SEIfHY=; b=j743ZO0JopfVpgdYec7S3sDzn+
 RD4uwdDTEGwHbwpGEfIcDH1eMU9+vPveruR8T0R2qm/bmxi3XJMPyeachg3ovk7+O4axEp8Dz9e9N
 J7UsK5+ZgOhbfB5sa/0vdqRf6SsC2IIjPszK55qcoYh3k7t+fOOl7kOup79OAP3w1L4U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6N0iuT0IuVYxSEk2UnobdYR9Ph/zQOqyP8bF8SEIfHY=; b=DRCtsM6R532i5dAmeYLDzZDn1q
 Aqqxv1v0Onsp0I6okLNHCE1MMSOXJvl8i9aGTwccajB9HEaxRsX7UMkrm5+JuOfi2eSTHYYmKjjW4
 kh9EppEtWqeQaqlnL5e2lQpkn5ZZR/vWGTTHeJ6DWeCmVTVflNFRGkheEHzl349Kn6Jo=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSGca-000000001kl-2GNV for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 16:28:57 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a60f9474c4so27841095e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 14 Nov 2026 08:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794673730; x=1795278530; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6N0iuT0IuVYxSEk2UnobdYR9Ph/zQOqyP8bF8SEIfHY=;
 b=Zpbq8IERAvsBk/6R7/0MgsDfSTsunW2n7YQVQ3Lk7mdXdJgHahnSywgX4gZ8P1S7io
 XXSKuCfQYC/r7Ems/gvbMOjlisL66sZRv7xUF6DmpkjY0R0bbhGoDgEnCTu4z/KfPk8F
 POnPvWzhq2Rg54Gc0hXix8MiD0ZRf4gORdL5VakD34HVcXkTWnTSCm6CNsVR+x8WDBUK
 18Om/GC6B53+yxmrgHL2eaNXAw8v++8Irv1cYecWtUOmlJ1kq9fZG1P/1rCb8IVDAwmw
 itgfu7MvW3/ZP0YkZR5x9ZkYJak7NUNZEhDgrQQrCZfn0ufBrlfsug+EPmvxv2UpdLlr
 FXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794673730; x=1795278530;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6N0iuT0IuVYxSEk2UnobdYR9Ph/zQOqyP8bF8SEIfHY=;
 b=UnFU2Mj1DZ+uynN6hRmWxUISXGwbhNAqTxw9GjTYG5BnScVuCz5TzybCkDome0fQgW
 T64SxjtbnXdV73O83gcr37oiVnSJP6uoY9YxKWtmqb8iQ6PXe20DPc0FO+6REWT4aILi
 C2QOj11AIDnBB1wgQGZrt63E+AFXshC9KgWK4R+aeAjtO35tbWO4ChkARyeJ9uf/rjAW
 mfgzCyC1fsrfdgeUBKZAE099L6YEhI34ByMcimuAXYMZG9zPIy4YF7WGoJf4RC0cRGg/
 dmkuJG3KHnLBMa5OwCAjxB1XojjUePKWgNAQb5Uxm9p3VXBbm9Y3JLjg9d90t1PGSQrN
 h0ig==
X-Forwarded-Encrypted: i=1;
 AL+hErH6SlpfuDPuz4GVExBUc5GbCGu2Ovh0W2kYrbzkSLq0B38fDXAaCONKZ8Sbq/4WwKtOqi2QjdRUKRmBMqrm@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+M1UF07n8VKOtSm+cqVniKXo3CFmGRWw63JjdLehfEvU+m7nC5
 DfwSxK58yul7UgbRdQp+Y3jU75wePJe5ZYGzIR0/ixVsJH1oMER8T40ozXc6dPrN+MMUElfXCTV
 BnuPCq3WJCN+HdIJVunUVy0KFS162M1JrDRb0vmgG/shwSjSoeJmlLPrL4d5V14scaH6h
X-Gm-Gg: AYBFou3SZ3LuLWRGbyaTFztfJQDSiyjq4cqOwdk5Yncg47+XSAvm9itFidl6iXmA2c/
 +Q9Tb2JpIsD5SPktygShTASgaAIC5wgR9ZUtdAryAYpb9NID68PwqBFksFH2PXnUES2L4aDHRdw
 v6zoZrB3V9y3AXbAkVsS5hTYFYXYA10RlTDrUx17KGjkiJgs8+DoVopa90qWdVpMKFZk9cVjMii
 iW6RMmTr4wfvpSRwGqxICvUowNEUzY/MVgkXW/LYianiMtkWUFhPw+jyOxWf13fCfHPAP7mhHMK
 7att57q6wiBaVW7vlTjtgLGeE3nsxXjmy0nGUXB0mf89D/FcOX9jH5NbMzDYjElgfdCE11qpEa/
 h5svxUsArQ6HLbice5bmDCxgTASwrs7manhqwb9E6j0mmDwLG/RZVThNULhg9KV6IWMEhHMODGz
 AF22w3kEorDahOHpG5GTKZCJcxcziJ3s8AZDrPAnGbW8rTqtCc8xSmGLtU6qBXRgk0ARqyKjFBT
 xdyXTqJCUO3FDXvLyn+6V1hpqgZCTjXMLHot4jF3tHS2CuCx30xw3GrCbBbFPS9jPuLl0970rUV
 sqTpPAs9MeCqusLIvRzJnBy/Vpjn9IeJD2tk2X3viaDCwFyVlgMzJHnKNifKf16XMbsKFubl+YR
 takuXtJRn6I2eC+q1OeOXhs0Fkn25b+ty+jo+x2vxQey3XihXS1vpmUl07ouE8F0hvXfUEAtLUa
 XxOdINMxps28QHUf4=
X-Received: by 2002:a05:600c:a318:b0:4a7:4697:dae3 with SMTP id
 5b1f17b1804b1-4bb55a696e4mr102298675e9.24.1794673729799; 
 Sat, 14 Nov 2026 08:28:49 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb666a3ca1sm52003255e9.9.2026.11.14.08.28.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 08:28:49 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 14 Nov 2026 16:28:49 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I766eff47993375c80895755355919ede11b488db
X-Gerrit-Change-Number: 2124
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2124?usp=email>
X-Gerrit-Commit: 0525e796787bc8414af0c3fa79492f73dc00c26e
In-Reply-To: <gerrit.1793779688000.I766eff47993375c80895755355919ede11b488db@gerrit.openvpn.net>
References: <gerrit.1793779688000.I766eff47993375c80895755355919ede11b488db@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzc5Njg4MDAwLkk3NjZlZmY0Nzk5MzM3NWM4MDg5NTc1NTM1NTkxOWVkZTExYjQ4OGRiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cf5f3fdd4737943907426d73134bf2ed1cf4efb7-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSGca-000000001kl-2GNV
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7717741456148291527=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7717741456148291527==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jioaonS5Y+o="; charset=UTF-8

--jioaonS5Y+o=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2124?usp=3Demail )

Change subject: tun: make delete_route_conn=
ected_v6_net() and create_arbitrary_remote() static
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

tun: make delete_route_connected_v=
6_net() and create_arbitrary_remote() static

Neither is used outside tun=
=2Ec or declared in a header=2E

create_arbitrary_remote() has had no FreeB=
SD/DragonFly caller since
94db3261 ("FreeBSD: for topology subnet, put tun =
interface into
IFF_BROADCAST mode"), so limit it to NetBSD and OpenBSD to a=
void an
unused static function there=2E

Change-Id: I766eff47993375c8089575=
5355919ede11b488db
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
A=
cked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2124
Message-Id: <20261104124915=2E18463-1=
-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-dev=
el@lists=2Esourceforge=2Enet/msg40729=2Ehtml
Signed-off-by: Gert Doering <g=
ert@greenie=2Emuc=2Ede>
---
M src/openvpn/tun=2Ec
1 file changed, 3 inserti=
ons(+), 4 deletions(-)




diff --git a/src/openvpn/tun=2Ec b/src/openvpn/t=
un=2Ec
index 1ae19eb=2E=2E70fdd7e 100644
--- a/src/openvpn/tun=2Ec
+++ b/sr=
c/openvpn/tun=2Ec
@@ -1000,7 +1000,7 @@
     add_route_ipv6(&r6, tt, 0, es,=
 NULL);
 }
 
-void
+static void
 delete_route_connected_v6_net(const struct=
 tuntap *tt)
 {
     struct route_ipv6 r6;
@@ -1017,8 +1017,7 @@
 #endif /*=
 if defined(_WIN32) || defined(TARGET_DARWIN) || defined(TARGET_NETBSD) || =
\
           defined(TARGET_OPENBSD) */
 
-#if defined(TARGET_FREEBSD) || d=
efined(TARGET_DRAGONFLY) || defined(TARGET_NETBSD) \
-    || defined(TARGET=
_OPENBSD)
+#if defined(TARGET_NETBSD) || defined(TARGET_OPENBSD)
 /* we can=
't use true subnet mode on tun on all platforms, as that
  * conflicts with=
 IPv6 (wants to use ND then, which we don't do),
  * but the OSes want "a r=
emote address that is different from ours"
@@ -1028,7 +1027,7 @@
  * is sti=
ll point to point and no layer 2 resolution is done=2E=2E=2E
  */
 
-in_add=
r_t
+static in_addr_t
 create_arbitrary_remote(const struct tuntap *tt)
 {
=
     in_addr_t remote;

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2124?usp=3Demail
To unsubscribe, or for help writing mail filter=
s, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: I766eff47993375c80895755355919ede11b488db
Gerrit-Change-Number: 2124
Ger=
rit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
=
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer:=
 Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>

--jioaonS5Y+o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2124?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">tun: make delete_route_connected_v=
6_net() and create_arbitrary_remote() static<br><br>Neither is used outside=
 tun=2Ec or declared in a header=2E<br><br>create_arbitrary_remote() has ha=
d no FreeBSD/DragonFly caller since<br>94db3261 (&quot;FreeBSD: for topolog=
y subnet, put tun interface into<br>IFF_BROADCAST mode&quot;), so limit it =
to NetBSD and OpenBSD to avoid an<br>unused static function there=2E<br><br=
>Change-Id: I766eff47993375c80895755355919ede11b488db<br>Signed-off-by: Raz=
van Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &=
lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2124<br>Message-Id: &lt;20261104124915=2E18463-1-gert@greenie=
=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@list=
s=2Esourceforge=2Enet/msg40729=2Ehtml<br>Signed-off-by: Gert Doering &lt;ge=
rt@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/tun=2Ec<br>1 file changed=
, 3 insertions(+), 4 deletions(-)<br><br></pre>
<pre style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn=
/tun=2Ec b/src/openvpn/tun=2Ec</span><br><span>index 1ae19eb=2E=2E70fdd7e 1=
00644</span><br><span>--- a/src/openvpn/tun=2Ec</span><br><span>+++ b/src/o=
penvpn/tun=2Ec</span><br><span>@@ -1000,7 +1000,7 @@</span><br><span>     a=
dd_route_ipv6(&amp;r6, tt, 0, es, NULL);</span><br><span> }</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span> delet=
e_route_connected_v6_net(const struct tuntap *tt)</span><br><span> {</span>=
<br><span>     struct route_ipv6 r6;</span><br><span>@@ -1017,8 +1017,7 @@<=
/span><br><span> #endif /* if defined(_WIN32) || defined(TARGET_DARWIN) || =
defined(TARGET_NETBSD) || \</span><br><span>           defined(TARGET_OPENB=
SD) */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#if defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY) || defined(TARG=
ET_NETBSD) \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    || de=
fined(TARGET_OPENBSD)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#if defined(TARGET_NETBSD) || defined(TARGET_OPENBSD)</span><br><span> /*=
 we can&#39;t use true subnet mode on tun on all platforms, as that</span><=
br><span>  * conflicts with IPv6 (wants to use ND then, which we don&#39;t =
do),</span><br><span>  * but the OSes want &quot;a remote address that is d=
ifferent from ours&quot;</span><br><span>@@ -1028,7 +1027,7 @@</span><br><s=
pan>  * is still point to point and no layer 2 resolution is done=2E=2E=2E<=
/span><br><span>  */</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-in_addr_t</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static in_addr_t</span><br><span> create_arbitrary_remote(const stru=
ct tuntap *tt)</span><br><span> {</span><br><span>     in_addr_t remote;</s=
pan><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2124?usp=3Demail">change 2124</a>=2E To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sche=
ma=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2124?usp=3Demail"/><meta itemprop=3D"name" conten=
t=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Messag=
eType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I766eff47993375c80895755355919ede11b48=
8db </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2124 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display=
:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>

</body></html>
--jioaonS5Y+o=--


--===============7717741456148291527==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7717741456148291527==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7717741456148291527==--

