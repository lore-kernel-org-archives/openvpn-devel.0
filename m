Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAF0606A330
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 13:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=VeevmDfz;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ICrHGcgD;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Qs4a4cgB;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Qifgbldx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=dtCI5ID1xuRri12f+/nD+8zZZxUcp4XFPqHIHg/5ffs=; b=VeevmDfzBgdnnYCvjuyFM/C60b
	T5m8FSCwyyzkcv8DXg99y1S982mAl/QH44HFt1KFFhC+vDbQDJi5XXarGxEWKm+mLPM4Km/fsKlDM
	Tf8VJUksmS+eJNHk19cO4buZOloEOookjDWh6J9YDfHGvYijjKV6IifbfDSN+KoCLtMY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xR8ct-000000002iH-1UQf;
	Wed, 11 Nov 2026 13:44:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xR8cr-000000002iA-1QOg
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 13:44:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z+TG+u6G8OYv0nfZ0vEBgwMnFlrxEEEtgAcJYskIQ7o=; b=ICrHGcgDY67OxCDfJteKx5mvFX
 W6F2FxjYKpjyWINZAPOq4PKCuX6M7Krq/2CGvLw+CTW44Ei2LeHFEpYR+7zYgxyUziMFVPsgpT0Eo
 F2H9MXEduup47pdhcSleETCFfgY6J/Vr/tRKxjWdaZZMR/Mab3OX6EYwrvRzQhqKJAwU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z+TG+u6G8OYv0nfZ0vEBgwMnFlrxEEEtgAcJYskIQ7o=; b=Qs4a4cgBtK3wCyunzDv4PsSoJn
 zMbALT6I6waA22xUs9sd1S6+PjFpWjfyQqROx1q9zyOrH83Cp+vBKixAL4Pi62vtwtEFkg+phIA8K
 YrE/4yAJRMsEwVP2jRQJC6ZNNuTuce88r+i0pvromCFkm81xPGUFlRQTOloQatLjUN6M=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xR8cp-000000006tj-3BCN for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 13:44:32 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4afe2d546f9so40117295e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 05:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794404665; x=1795009465; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Z+TG+u6G8OYv0nfZ0vEBgwMnFlrxEEEtgAcJYskIQ7o=;
 b=Qifgbldx7K20qEgLbfIXAKwDAlcwKi5oHgXx0oI8dsmqSS6pdQ3mNHgfmKQlQ0qp8k
 5lIGLDwkNPDLP99Vz+OeVSg1Jc0sssP/wiklnFf188YxBY0S5zCN0ngkU1bgOdXb9m75
 l2vzoWcFBvZNfhKiPWurlzZazaE21lyQTYzfghEsutw32Su403p3mCnZAoHJ0hTWQTQU
 N1KmWOXxg3Uj/9w8gOnVvdjdNAKkR7c5HordUF7SlTn4VA3LjXpFGjdb1k8ZOTV8TiyI
 jdd29qLPmpIMfGRoJ4orV3P8d45493BVzChueu86mkuLmseH3rjIFE0paVumkS2yl7JV
 HLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794404665; x=1795009465;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Z+TG+u6G8OYv0nfZ0vEBgwMnFlrxEEEtgAcJYskIQ7o=;
 b=ntKgyd9a1apzsLGbj1PZovt1jE0AYdXRKTS8tORthoHG4aUb5ouDWYdvUBcEmhm2ij
 I8vJj1Ru07KXvTHGnt5r/LDl6Be1PJhKfwAgu6rsUCgyIgWCVCuhsOBaL8QBzMsl/iSE
 N17+GkxQpV//JH/6obL20dEHC3ppVyqw7oQyTdlaYyp9+D4DZPhzOy4RbHfiCuJpb/g2
 lcY5BJuW95SV1WWjiqHy82qiqYGNNFLjdtrn0crb21yzFT7ri11TYWIxk57zKPUmTwm/
 /i6ANOjPGkIhDKVFPYShzL+urnc36WHN9WBDzBy6E+G2OCP1bYxyiS1yoCNyvoZSNAFk
 zIlQ==
X-Gm-Message-State: APuU4Z/52t27vWWgk2E7XM0bIzodvRtjJyrBg0ZdoY9RDluS0bSsofOi
 wwIAnipaO8o51K94B8QiwDc1gGheBkW9KvwaWSUp5B1j5tLLGy3RcQRlXLxES3l5OCspWkIdyy/
 y3FtbsQjEgdvOj6cFtIGXHAcHOxpcSJAjWnhyPaJMh29QIhZdzTbahDLjQUS5O0NhcDMaD1BOVc
 PM06YvBQ==
X-Gm-Gg: AYBFou0VUwZib+SaojEPdhPsLtLn+b2HjBzxpt/O9iKu8EFCtdtcYLzp2rdwSGBBNN2
 Gsko7bKXLOJbcOPPN4iX9AxPMF6OeaZK976zPMdokJ9L2UeslEvXqO7rU2bohIgbGjZKtatpPkR
 51x7mDqnkQb+FuA4EtJXWYxw+CO99yHO9XfCny99Lw7Dq/Z99qZ4a1jb/cczACS+Bo1+d3V1uWv
 Y8oFVJIFkwME79JQDz2YKIratSlzHvk54R9Mcdbxyk9XwCsibCP7lIzuToiReXWiqLzxgVxTvWY
 ZCULIJGci8p+BzhHKaKt90pF6fggWUdAzcvPcS0vMqV0YZnKxXw+Lxr5q71Q88TXqTbWh6YvZ1W
 Y1pBGifxLgXUEQxeQsuSEfH+hUzWszeMXcUEnd7Nc08iBhJwZ9oVrWYcRcazsMkdxPXBLtqSj/B
 UJHsrxM2L1iUJGKHSzKfKtM4NJTuC3GK1Ekm8OycTmdd/chz4zloRSrVVpxn7qu8OOjyGFZ7Qu3
 nq1uBvbrsqYwDAS+uCQsyIKv+0Op2KdUsQbO2dVM8zl/nQFca/vWfzbDSuSKdtE+Tx1BQMCkTba
 feh7Bm2s58Sw3N3nFa5LOrcLao/QA1fzfL0HdJxrbcN/ESJmC5RaCJCXktQx6Pl/bMDrNKsQNeR
 sQpKPweTA0J82zI1UfhOr1wpb8tepBMNP5S10xCM62fqiiejGXVPTFXSnql05aUmHNUDG3I65NC
 mwpHt9j1kNH8mZJaQ=
X-Received: by 2002:a05:6000:4b0b:b0:499:9ffc:59bd with SMTP id
 ffacd0b85a97d-499c95ffec0mr4082712f8f.30.1794404664780; 
 Wed, 11 Nov 2026 05:44:24 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4983585c4fdsm11305199f8f.10.2026.11.11.05.44.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 05:44:24 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 13:44:22 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I571e30bb22ec7bffc2c5fa04fdcd73b52ce47e5e
X-Gerrit-Change-Number: 2108
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2108?usp=email>
X-Gerrit-Commit: d7313577110b6ba56d0826b4467d8bdbf5c45ff3
In-Reply-To: <gerrit.1793709839000.I571e30bb22ec7bffc2c5fa04fdcd73b52ce47e5e@gerrit.openvpn.net>
References: <gerrit.1793709839000.I571e30bb22ec7bffc2c5fa04fdcd73b52ce47e5e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzA5ODM5MDAwLkk1NzFlMzBiYjIyZWM3YmZmYzJjNWZhMDRmZGNkNzNiNTJjZTQ3ZTVlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <95c89673d9d0e8a2609db63d4886b32adda0a5b9-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xR8cp-000000006tj-3BCN
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Silence remaining
 cppcheck warnings on macOS and FreeBSD
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8802827486285063185=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8802827486285063185==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/gvG6gOyfsI="; charset=UTF-8

--/gvG6gOyfsI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld=2E

Hello Frank Lic=
htenheld, 

I'd like you to reexamine a change=2E Please visit

    https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2108?usp=3Demail

to look at the new pa=
tch set (#2)=2E

The following approvals got outdated and were removed:
Cod=
e-Review-1 by Frank Lichtenheld


Change subject: Silence remaining cppchec=
k warnings on macOS and FreeBSD
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

Silence remaining cppcheck warnings on macOS and FreeBS=
D

Change-Id: I571e30bb22ec7bffc2c5fa04fdcd73b52ce47e5e
Signed-off-by: Arne=
 Schwabe <arne@rfc2549=2Eorg>
---
M src/openvpn/route=2Ec
M src/openvpn/tun=
=2Ec
2 files changed, 12 insertions(+), 12 deletions(-)


  git pull ssh://=
gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/08/2108/2

diff --git a/s=
rc/openvpn/route=2Ec b/src/openvpn/route=2Ec
index d0d26c6=2E=2E449b4f1 100=
644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/route=2Ec
@@ -3331,7 +333=
1,6 @@
     int rtm_addrs;
     struct sockaddr so_dst, so_mask;
     char =
*cp =3D m_rtmsg=2Em_space;
-    struct sockaddr *gate =3D NULL, *ifp =3D NU=
LL, *sa;
     struct rt_msghdr *rtm_aux;
 
 #define rtm m_rtmsg=2Em_rtm
@@ =
-3396,6 +3395,8 @@
     sockfd =3D -1;
 
     /* extract return data from r=
outing socket */
+    const struct sockaddr_in *gate =3D NULL;
+    const s=
truct sockaddr_dl *adl =3D NULL;
     rtm_aux =3D &rtm;
     cp =3D (char *=
)(rtm_aux + 1);
     if (rtm_aux->rtm_addrs)
@@ -3404,14 +3405,14 @@
      =
   {
             if (i & rtm_aux->rtm_addrs)
             {
-             =
   sa =3D (struct sockaddr *)cp;
+                const struct sockaddr *sa=
 =3D (const struct sockaddr *)cp;
                 if (i =3D=3D RTA_GATEWAY=
)
                 {
-                    gate =3D sa;
+                   =
 gate =3D (const struct sockaddr_in *)sa;
                 }
              =
   else if (i =3D=3D RTA_IFP)
                 {
-                    ifp =
=3D sa;
+                    adl =3D (const struct sockaddr_dl *)sa;
      =
           }
                 ADVANCE(cp, sa);
             }
@@ -3423,19 +=
3424,18 @@
     }
 
     /* get gateway addr and interface name */
-    if =
(gate !=3D NULL)
+    if (gate)
     {
         /* get default gateway addr=
 */
-        rgi->gateway=2Eaddr =3D ntohl(((struct sockaddr_in *)gate)->si=
n_addr=2Es_addr);
+        rgi->gateway=2Eaddr =3D ntohl((gate)->sin_addr=
=2Es_addr);
         if (rgi->gateway=2Eaddr)
         {
             rgi->=
flags |=3D RGI_ADDR_DEFINED;
         }
 
-        if (ifp)
+        if (ad=
l)
         {
             /* get interface name */
-            const stru=
ct sockaddr_dl *adl =3D (struct sockaddr_dl *)ifp;
             if (adl->sd=
l_nlen && adl->sdl_nlen < sizeof(rgi->iface))
             {
              =
   memcpy(rgi->iface, adl->sdl_data, adl->sdl_nlen);
diff --git a/src/openv=
pn/tun=2Ec b/src/openvpn/tun=2Ec
index bcea331=2E=2Ea1f9886 100644
--- a/sr=
c/openvpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -1040,7 +1040,7 @@
  * @para=
m ctx       the networking API opaque context
  */
 static void
-do_ifconfi=
g_ipv6(struct tuntap *tt, const char *ifname, int tun_mtu, const struct env=
_set *es,
+do_ifconfig_ipv6(const struct tuntap *tt, const char *ifname, in=
t tun_mtu, const struct env_set *es,
                  openvpn_net_ctx_t *c=
tx)
 {
 #if !defined(TARGET_LINUX)
@@ -1231,7 +1231,7 @@
  * @param ctx    =
   the networking API opaque context
  */
 static void
-do_ifconfig_ipv4(st=
ruct tuntap *tt, const char *ifname, int tun_mtu, const struct env_set *es,=

+do_ifconfig_ipv4(const struct tuntap *tt, const char *ifname, int tun_mtu=
, const struct env_set *es,
                  openvpn_net_ctx_t *ctx)
 {
 #=
if !defined(_WIN32) && !defined(TARGET_ANDROID)
@@ -1587,7 +1587,7 @@
 }
 
=
 static void
-undo_ifconfig_ipv4(const struct tuntap *tt, openvpn_net_ctx_t=
 *ctx)
+undo_ifconfig_ipv4(const struct tuntap *tt, const openvpn_net_ctx_t=
 *ctx)
 {
 #if defined(TARGET_LINUX)
     int netbits =3D netmask_to_netbit=
s2(tt->remote_netmask);
@@ -1622,7 +1622,7 @@
 }
 
 static void
-undo_ifcon=
fig_ipv6(const struct tuntap *tt, openvpn_net_ctx_t *ctx)
+undo_ifconfig_ip=
v6(const struct tuntap *tt, const openvpn_net_ctx_t *ctx)
 {
 #if defined(T=
ARGET_LINUX)
     if (net_addr_v6_del(ctx, tt->actual_name, &tt->local_ipv6=
, tt->netbits_ipv6) < 0)

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2108?usp=3Demail
To unsubscribe, or for help writing mail filt=
ers, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mess=
ageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-C=
hange-Id: I571e30bb22ec7bffc2c5fa04fdcd73b52ce47e5e
Gerrit-Change-Number: 2=
108
Gerrit-PatchSet: 2
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC:=
 openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: =
Frank Lichtenheld <frank@lichtenheld=2Ecom>

--/gvG6gOyfsI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld=2E </p>
<p>Arne Schwabe <strong>upl=
oaded patch set #2</strong> to this change=2E</p><p><a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2108?usp=3Demail">View Change</a></p><p>The =
following approvals got outdated and were removed:
Code-Review-1 by Frank L=
ichtenheld</p><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">Silence remaining cppcheck warnings on macOS an=
d FreeBSD<br><br>Change-Id: I571e30bb22ec7bffc2c5fa04fdcd73b52ce47e5e<br>Si=
gned-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvp=
n/route=2Ec<br>M src/openvpn/tun=2Ec<br>2 files changed, 12 insertions(+), =
12 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/08/2108/2</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
n/route=2Ec b/src/openvpn/route=2Ec</span><br><span>index d0d26c6=2E=2E449b=
4f1 100644</span><br><span>--- a/src/openvpn/route=2Ec</span><br><span>+++ =
b/src/openvpn/route=2Ec</span><br><span>@@ -3331,7 +3331,6 @@</span><br><sp=
an>     int rtm_addrs;</span><br><span>     struct sockaddr so_dst, so_mask=
;</span><br><span>     char *cp =3D m_rtmsg=2Em_space;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    struct sockaddr *gate =3D NULL, *ifp =
=3D NULL, *sa;</span><br><span>     struct rt_msghdr *rtm_aux;</span><br><s=
pan> </span><br><span> #define rtm m_rtmsg=2Em_rtm</span><br><span>@@ -3396=
,6 +3395,8 @@</span><br><span>     sockfd =3D -1;</span><br><span> </span><=
br><span>     /* extract return data from routing socket */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    const struct sockaddr_in *gate =
=3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const =
struct sockaddr_dl *adl =3D NULL;</span><br><span>     rtm_aux =3D &amp;rtm=
;</span><br><span>     cp =3D (char *)(rtm_aux + 1);</span><br><span>     i=
f (rtm_aux-&gt;rtm_addrs)</span><br><span>@@ -3404,14 +3405,14 @@</span><br=
><span>         {</span><br><span>             if (i &amp; rtm_aux-&gt;rtm_=
addrs)</span><br><span>             {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                sa =3D (struct sockaddr *)cp;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                const struct sock=
addr *sa =3D (const struct sockaddr *)cp;</span><br><span>                 =
if (i =3D=3D RTA_GATEWAY)</span><br><span>                 {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                    gate =3D sa;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                    gat=
e =3D (const struct sockaddr_in *)sa;</span><br><span>                 }</s=
pan><br><span>                 else if (i =3D=3D RTA_IFP)</span><br><span> =
                {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                ifp =3D sa;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                    adl =3D (const struct sockaddr_dl *)sa;</span><=
br><span>                 }</span><br><span>                 ADVANCE(cp, sa=
);</span><br><span>             }</span><br><span>@@ -3423,19 +3424,18 @@</=
span><br><span>     }</span><br><span> </span><br><span>     /* get gateway=
 addr and interface name */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    if (gate !=3D NULL)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (gate)</span><br><span>     {</span><br><span>         /* =
get default gateway addr */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        rgi-&gt;gateway=2Eaddr =3D ntohl(((struct sockaddr_in *)gate)=
-&gt;sin_addr=2Es_addr);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        rgi-&gt;gateway=2Eaddr =3D ntohl((gate)-&gt;sin_addr=2Es_addr)=
;</span><br><span>         if (rgi-&gt;gateway=2Eaddr)</span><br><span>    =
     {</span><br><span>             rgi-&gt;flags |=3D RGI_ADDR_DEFINED;</s=
pan><br><span>         }</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        if (ifp)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (adl)</span><br><span>         {</span><br><sp=
an>             /* get interface name */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            const struct sockaddr_dl *adl =3D (struct so=
ckaddr_dl *)ifp;</span><br><span>             if (adl-&gt;sdl_nlen &amp;&am=
p; adl-&gt;sdl_nlen &lt; sizeof(rgi-&gt;iface))</span><br><span>           =
  {</span><br><span>                 memcpy(rgi-&gt;iface, adl-&gt;sdl_data=
, adl-&gt;sdl_nlen);</span><br><span>diff --git a/src/openvpn/tun=2Ec b/src=
/openvpn/tun=2Ec</span><br><span>index bcea331=2E=2Ea1f9886 100644</span><b=
r><span>--- a/src/openvpn/tun=2Ec</span><br><span>+++ b/src/openvpn/tun=2Ec=
</span><br><span>@@ -1040,7 +1040,7 @@</span><br><span>  * @param ctx      =
 the networking API opaque context</span><br><span>  */</span><br><span> st=
atic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-do_ifconfig_=
ipv6(struct tuntap *tt, const char *ifname, int tun_mtu, const struct env_s=
et *es,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+do_ifconfig_=
ipv6(const struct tuntap *tt, const char *ifname, int tun_mtu, const struct=
 env_set *es,</span><br><span>                  openvpn_net_ctx_t *ctx)</sp=
an><br><span> {</span><br><span> #if !defined(TARGET_LINUX)</span><br><span=
>@@ -1231,7 +1231,7 @@</span><br><span>  * @param ctx       the networking =
API opaque context</span><br><span>  */</span><br><span> static void</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-do_ifconfig_ipv4(struct tunt=
ap *tt, const char *ifname, int tun_mtu, const struct env_set *es,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+do_ifconfig_ipv4(const struc=
t tuntap *tt, const char *ifname, int tun_mtu, const struct env_set *es,</s=
pan><br><span>                  openvpn_net_ctx_t *ctx)</span><br><span> {<=
/span><br><span> #if !defined(_WIN32) &amp;&amp; !defined(TARGET_ANDROID)</=
span><br><span>@@ -1587,7 +1587,7 @@</span><br><span> }</span><br><span> </=
span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-undo_ifconfig_ipv4(const struct tuntap *tt, openvpn_net_ctx_t *ctx)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+undo_ifconfig_ipv4(co=
nst struct tuntap *tt, const openvpn_net_ctx_t *ctx)</span><br><span> {</sp=
an><br><span> #if defined(TARGET_LINUX)</span><br><span>     int netbits =
=3D netmask_to_netbits2(tt-&gt;remote_netmask);</span><br><span>@@ -1622,7 =
+1622,7 @@</span><br><span> }</span><br><span> </span><br><span> static voi=
d</span><br><span style=3D"color: hsl(0, 100%, 40%);">-undo_ifconfig_ipv6(c=
onst struct tuntap *tt, openvpn_net_ctx_t *ctx)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+undo_ifconfig_ipv6(const struct tuntap *tt, con=
st openvpn_net_ctx_t *ctx)</span><br><span> {</span><br><span> #if defined(=
TARGET_LINUX)</span><br><span>     if (net_addr_v6_del(ctx, tt-&gt;actual_n=
ame, &amp;tt-&gt;local_ipv6, tt-&gt;netbits_ipv6) &lt; 0)</span><br></pre><=
p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2108=
?usp=3Demail">change 2108</a>=2E To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demai=
l">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/=
ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2108?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatch=
set </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div=
 style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display=
:none"> Gerrit-Change-Id: I571e30bb22ec7bffc2c5fa04fdcd73b52ce47e5e </div>
=
<div style=3D"display:none"> Gerrit-Change-Number: 2108 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> G=
errit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenh=
eld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel =
&lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt=
; </div>

</body></html>
--/gvG6gOyfsI=--


--===============8802827486285063185==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8802827486285063185==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8802827486285063185==--

