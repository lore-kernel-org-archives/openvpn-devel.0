Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C41606A8A5
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 11:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=OIei6/mp;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=hU2W6Qmk;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=afIEGc7Q;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=DeMgo21g
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=YUUgvZIWhMLtYyonOfIXXKrKcaHsxx7d421pv7qZ+ug=; b=OIei6/mpIYaJ7jFy4v7cVoTSJB
	g9xlYut8D5fEc0MQXYRT1y2ZVJdBtRhOY0qZbSBx4/UleF63tHdxOtgF3SyuB3r3PzbuD2P+5XGj5
	z7ENpE2061qWf8N5hviln/xQYEqwOOSbWnQkxPkZBGK7YYY8Q9E9B9EDkcGYWJxuQuNo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRpXv-000000003li-33h9;
	Fri, 13 Nov 2026 11:34:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRpXu-000000003lc-23Dq
 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 11:34:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kP7LEWvwtreVoRowNEaaaluwtQQEXHBwwsewcGIV6wk=; b=hU2W6Qmkgh0Qgq7M5ONtkiQGIp
 OyhMQMQzW5AxSyKdJVdYd4wi/jO/N6GbN1GgDG3NQ8qawVMfmxBUONHyeVzH153f/CPQQydQMgXma
 JCKwI9TbNMjANNqWLt2LC0UKbPsnE3IztD9xrryhrkZGla4+1Ze3Nv+s7mJnOip2B9qo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kP7LEWvwtreVoRowNEaaaluwtQQEXHBwwsewcGIV6wk=; b=afIEGc7QVKiAo8ECbtXLiBlplF
 65KNPm6RJ1k0yaCkbhgPjKV27JlQune5IAnRF4461ZuQ9Nxmsb5gzjdKxjguYdf9S9h7uem77TWj5
 TvfZDoSeshLGAF73W73sGWOInLV9n40XOLmU6E7pRXeVcgk2h0yb5D5dKQhLzkv9Xizg=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRpXt-000000002Qs-11YU for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 11:34:18 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a5087a5348so6154865e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 13 Nov 2026 03:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794569651; x=1795174451; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kP7LEWvwtreVoRowNEaaaluwtQQEXHBwwsewcGIV6wk=;
 b=DeMgo21g9dTzlUh9KW8hdEdMGBbqspyv8ah65fVmNQl4Mrw9lfyW44zbcXP07g4HWw
 AQ57CRWfVcEqKlC+JiyFLf6PbJ1wCJCtjOUuiSkIjaamfE7hE2c3/lx0EDmbBgbDed7P
 OeeYyVNeYlc6t69lvuk06t0Hw8PLc3RNEzNp1jRwk+49jeZlWPVZGfWRhl1+69Xlmf/V
 sq13bn83m0lsGSso4WYBxo0pwEbbqzGoA+GoMLW0jaLED0Ihs/ZNC4IZNmVQ6Udk+mIg
 15BL3h5Dbdu30hLCy38bSE/UpWBDJnCeemhv660WWhK6azYiqwJgZQY7lf6eg8bFkHxM
 5BHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794569651; x=1795174451;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=kP7LEWvwtreVoRowNEaaaluwtQQEXHBwwsewcGIV6wk=;
 b=jaS/DmLJA76VX2lvF2sQEpT1hEppycSZ1Ta8o+U3UPgYygbMI92f1BvyUuJ5hGYvi8
 1go4CnC340ET5f1FH6ajZ/MUc+a9/ayobngTzMvT3HK85Uk8SIwkHb4zziOC0haPkMqb
 mf4l4SK1qhp94lMaLTlnLgKW++m5XeG0GobZPpN/BYzsHWD5BUUe1Gc7Z0BotbNrs1WP
 nGj6zMIntbXMUVdYng6iNDv1IJYli9jAC/uxBC1JN3q9wO3nXXJBj2zlUv5o7bMax0MA
 3PJbjIuUcJpBHA19CskS+EQDgM1y6VyXx2MTtFkVupS4EJte080Xh0K6hbQjKobeKpst
 YSqg==
X-Gm-Message-State: APuU4Z+gOgUD5xFiQ4a3jyl34RSuFrw2XwaTSv8snmpdYGiqa9NKs2PA
 0Z48ew55ppiXNrZghXnEZLZZuzzk/W0oAFll5YsXgovsoR8WKgp68VHH1b9MlcAkqH2Ax5ptzD8
 THjBJXgVp3hqyCnGrtEvhO/SbavLsa+t3PvHLW8G+sKPTtTD1GgS/9fIzuUYc9XjHIvOAfd8WnP
 l/9gpStQ==
X-Gm-Gg: AYBFou3UXzbxbrxXxHgVYQcKmDs/pKGA09Mq/1rn78SUaQKYMTzRc7++v2kyPNDTXqa
 lZz6HOEMvWdWU5o1AL2KxB9hQmFcIjIXxb36J/V7+m6rOY+lmub6V7x+2pb5p1Q699iICfFr7yn
 ef3RUMYvNA084Uahc0zT4BWP4qKAAmTBmUqHVbHadsSPC9gfTfLbdBhWpjT2Jfg7DzFMk5C+V6H
 dNaY/Ky7mkpeSgg4F4KzpJNYStHxttJ7FGKjvvxQf/vKuXFImD+strd3le5Rp/sLPPkpLt+RzmM
 z9o4yQ3PGJrrrFObkWKs+ZNXFoXRkVVUImY1mjnE5FvHGtpC3QgJcOklb2i9ZywDo/uS1/RlItU
 U4PRY2JaFvWVj3vozMe9fvNar1/Bi2i7HK+xYBcSRA7iKq3T7N18SG8IPgisKsugzexRKfvuZFv
 iTmugOWMlMpoItkD6a7NJpWWnn6TAubHQIcfH1ZTpoeRUMUvYWQQfsJRuGKPbKeVNN6aRxwuLlB
 jiatDIsWhkoILBaOJOErBmcchbWyiybj+4p/7Ct5iXCXsoNIR5Mqn0+NodGHKnTSu5JZgN9WQVn
 tt7CRM1fsCQo/5ebfBRmb/de7z8CcQj2NlwXkJvLoGflB65kTBHDLQyjWfK447UkwXURQfKjioB
 05xZx0FaUk85ko5pOe88LflsoxsA4Qe7PvG9Eam3iOBbZgUCKb/ucCGRDjDpxakSHGe2cNyuTVf
 92sOm3FQZtByf2nos=
X-Received: by 2002:a05:600c:c165:b0:4a3:5a42:b2a4 with SMTP id
 5b1f17b1804b1-4bb55a64243mr43581055e9.12.1794569650471; 
 Fri, 13 Nov 2026 03:34:10 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5f78214dsm4990283f8f.25.2026.11.13.03.34.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 03:34:09 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 13 Nov 2026 11:34:08 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I571e30bb22ec7bffc2c5fa04fdcd73b52ce47e5e
X-Gerrit-Change-Number: 2108
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2108?usp=email>
X-Gerrit-Commit: f6f035bca56e3b7da845f6e08c7b8bff6bfa97e8
In-Reply-To: <gerrit.1793709839000.I571e30bb22ec7bffc2c5fa04fdcd73b52ce47e5e@gerrit.openvpn.net>
References: <gerrit.1793709839000.I571e30bb22ec7bffc2c5fa04fdcd73b52ce47e5e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzA5ODM5MDAwLkk1NzFlMzBiYjIyZWM3YmZmYzJjNWZhMDRmZGNkNzNiNTJjZTQ3ZTVlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6903e7836c8b5706420cdbcf0c1d8cbfd3c79f76-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRpXt-000000002Qs-11YU
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============9162128800691964439=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============9162128800691964439==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="K6TL2qXsnKY="; charset=UTF-8

--K6TL2qXsnKY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by Arne Schwabe=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2108?u=
sp=3Demail )

The following approvals got outdated and were removed:
Code-R=
eview+2 by Frank Lichtenheld


Change subject: Silence remaining cppcheck w=
arnings on macOS and FreeBSD
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

Silence remaining cppcheck warnings on macOS and FreeBSD

=
Change-Id: I571e30bb22ec7bffc2c5fa04fdcd73b52ce47e5e
Signed-off-by: Arne Sc=
hwabe <arne@rfc2549=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2108
Message=
-Id: <20261111152112=2E31478-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2E=
mail-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41164=2Ehtml
=
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/rou=
te=2Ec
M src/openvpn/tun=2Ec
2 files changed, 12 insertions(+), 12 deletion=
s(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/0=
8/2108/3

diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
index =
d0d26c6=2E=2E449b4f1 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/r=
oute=2Ec
@@ -3331,7 +3331,6 @@
     int rtm_addrs;
     struct sockaddr so_=
dst, so_mask;
     char *cp =3D m_rtmsg=2Em_space;
-    struct sockaddr *ga=
te =3D NULL, *ifp =3D NULL, *sa;
     struct rt_msghdr *rtm_aux;
 
 #define=
 rtm m_rtmsg=2Em_rtm
@@ -3396,6 +3395,8 @@
     sockfd =3D -1;
 
     /* ex=
tract return data from routing socket */
+    const struct sockaddr_in *gat=
e =3D NULL;
+    const struct sockaddr_dl *adl =3D NULL;
     rtm_aux =3D &=
rtm;
     cp =3D (char *)(rtm_aux + 1);
     if (rtm_aux->rtm_addrs)
@@ -34=
04,14 +3405,14 @@
         {
             if (i & rtm_aux->rtm_addrs)
     =
        {
-                sa =3D (struct sockaddr *)cp;
+                c=
onst struct sockaddr *sa =3D (const struct sockaddr *)cp;
                 =
if (i =3D=3D RTA_GATEWAY)
                 {
-                    gate =3D =
sa;
+                    gate =3D (const struct sockaddr_in *)sa;
         =
        }
                 else if (i =3D=3D RTA_IFP)
                 {
- =
                   ifp =3D sa;
+                    adl =3D (const struct s=
ockaddr_dl *)sa;
                 }
                 ADVANCE(cp, sa);
     =
        }
@@ -3423,19 +3424,18 @@
     }
 
     /* get gateway addr and int=
erface name */
-    if (gate !=3D NULL)
+    if (gate)
     {
         /* g=
et default gateway addr */
-        rgi->gateway=2Eaddr =3D ntohl(((struct =
sockaddr_in *)gate)->sin_addr=2Es_addr);
+        rgi->gateway=2Eaddr =3D n=
tohl((gate)->sin_addr=2Es_addr);
         if (rgi->gateway=2Eaddr)
        =
 {
             rgi->flags |=3D RGI_ADDR_DEFINED;
         }
 
-        if =
(ifp)
+        if (adl)
         {
             /* get interface name */
- =
           const struct sockaddr_dl *adl =3D (struct sockaddr_dl *)ifp;
   =
          if (adl->sdl_nlen && adl->sdl_nlen < sizeof(rgi->iface))
        =
     {
                 memcpy(rgi->iface, adl->sdl_data, adl->sdl_nlen);
d=
iff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec
index bcea331=2E=2Ea1=
f9886 100644
--- a/src/openvpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -1040,7=
 +1040,7 @@
  * @param ctx       the networking API opaque context
  */
 st=
atic void
-do_ifconfig_ipv6(struct tuntap *tt, const char *ifname, int tun_=
mtu, const struct env_set *es,
+do_ifconfig_ipv6(const struct tuntap *tt, c=
onst char *ifname, int tun_mtu, const struct env_set *es,
                 =
 openvpn_net_ctx_t *ctx)
 {
 #if !defined(TARGET_LINUX)
@@ -1231,7 +1231,7 =
@@
  * @param ctx       the networking API opaque context
  */
 static void=

-do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu, cons=
t struct env_set *es,
+do_ifconfig_ipv4(const struct tuntap *tt, const char=
 *ifname, int tun_mtu, const struct env_set *es,
                  openvpn_=
net_ctx_t *ctx)
 {
 #if !defined(_WIN32) && !defined(TARGET_ANDROID)
@@ -15=
87,7 +1587,7 @@
 }
 
 static void
-undo_ifconfig_ipv4(const struct tuntap *=
tt, openvpn_net_ctx_t *ctx)
+undo_ifconfig_ipv4(const struct tuntap *tt, co=
nst openvpn_net_ctx_t *ctx)
 {
 #if defined(TARGET_LINUX)
     int netbits =
=3D netmask_to_netbits2(tt->remote_netmask);
@@ -1622,7 +1622,7 @@
 }
 
 st=
atic void
-undo_ifconfig_ipv6(const struct tuntap *tt, openvpn_net_ctx_t *c=
tx)
+undo_ifconfig_ipv6(const struct tuntap *tt, const openvpn_net_ctx_t *c=
tx)
 {
 #if defined(TARGET_LINUX)
     if (net_addr_v6_del(ctx, tt->actual_=
name, &tt->local_ipv6, tt->netbits_ipv6) < 0)

-- 
To view, visit https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2108?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I571e30bb22ec7bffc2c5fa04fdcd73b52ce47e5e
Ge=
rrit-Change-Number: 2108
Gerrit-PatchSet: 3
Gerrit-Owner: Arne Schwabe <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenh=
eld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>

--K6TL2qXsnKY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by Arne=
 Schwabe=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/210=
8?usp=3Demail">View Change</a></p><p>The following approvals got outdated a=
nd were removed:
Code-Review+2 by Frank Lichtenheld</p><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Silenc=
e remaining cppcheck warnings on macOS and FreeBSD<br><br>Change-Id: I571e3=
0bb22ec7bffc2c5fa04fdcd73b52ce47e5e<br>Signed-off-by: Arne Schwabe &lt;arne=
@rfc2549=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ec=
om&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2108<br>Me=
ssage-Id: &lt;20261111152112=2E31478-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: =
https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/ms=
g41164=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt=
;<br>---<br>M src/openvpn/route=2Ec<br>M src/openvpn/tun=2Ec<br>2 files cha=
nged, 12 insertions(+), 12 deletions(-)<br><br></pre><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/08/2108/3</pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec</span><br><span>=
index d0d26c6=2E=2E449b4f1 100644</span><br><span>--- a/src/openvpn/route=
=2Ec</span><br><span>+++ b/src/openvpn/route=2Ec</span><br><span>@@ -3331,7=
 +3331,6 @@</span><br><span>     int rtm_addrs;</span><br><span>     struct=
 sockaddr so_dst, so_mask;</span><br><span>     char *cp =3D m_rtmsg=2Em_sp=
ace;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct sockad=
dr *gate =3D NULL, *ifp =3D NULL, *sa;</span><br><span>     struct rt_msghd=
r *rtm_aux;</span><br><span> </span><br><span> #define rtm m_rtmsg=2Em_rtm<=
/span><br><span>@@ -3396,6 +3395,8 @@</span><br><span>     sockfd =3D -1;</=
span><br><span> </span><br><span>     /* extract return data from routing s=
ocket */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const s=
truct sockaddr_in *gate =3D NULL;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    const struct sockaddr_dl *adl =3D NULL;</span><br><span> =
    rtm_aux =3D &amp;rtm;</span><br><span>     cp =3D (char *)(rtm_aux + 1)=
;</span><br><span>     if (rtm_aux-&gt;rtm_addrs)</span><br><span>@@ -3404,=
14 +3405,14 @@</span><br><span>         {</span><br><span>             if (=
i &amp; rtm_aux-&gt;rtm_addrs)</span><br><span>             {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                sa =3D (struct sock=
addr *)cp;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       const struct sockaddr *sa =3D (const struct sockaddr *)cp;</span><br=
><span>                 if (i =3D=3D RTA_GATEWAY)</span><br><span>         =
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
        gate =3D sa;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                    gate =3D (const struct sockaddr_in *)sa;</span><br><sp=
an>                 }</span><br><span>                 else if (i =3D=3D RT=
A_IFP)</span><br><span>                 {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                    ifp =3D sa;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    adl =3D (const struct=
 sockaddr_dl *)sa;</span><br><span>                 }</span><br><span>     =
            ADVANCE(cp, sa);</span><br><span>             }</span><br><span=
>@@ -3423,19 +3424,18 @@</span><br><span>     }</span><br><span> </span><br=
><span>     /* get gateway addr and interface name */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (gate !=3D NULL)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (gate)</span><br><span>     {</s=
pan><br><span>         /* get default gateway addr */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        rgi-&gt;gateway=2Eaddr =3D ntohl(((=
struct sockaddr_in *)gate)-&gt;sin_addr=2Es_addr);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        rgi-&gt;gateway=2Eaddr =3D ntohl((ga=
te)-&gt;sin_addr=2Es_addr);</span><br><span>         if (rgi-&gt;gateway=2E=
addr)</span><br><span>         {</span><br><span>             rgi-&gt;flags=
 |=3D RGI_ADDR_DEFINED;</span><br><span>         }</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        if (ifp)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (adl)</span><br><spa=
n>         {</span><br><span>             /* get interface name */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            const struct socka=
ddr_dl *adl =3D (struct sockaddr_dl *)ifp;</span><br><span>             if =
(adl-&gt;sdl_nlen &amp;&amp; adl-&gt;sdl_nlen &lt; sizeof(rgi-&gt;iface))</=
span><br><span>             {</span><br><span>                 memcpy(rgi-&=
gt;iface, adl-&gt;sdl_data, adl-&gt;sdl_nlen);</span><br><span>diff --git a=
/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec</span><br><span>index bcea331=2E=
=2Ea1f9886 100644</span><br><span>--- a/src/openvpn/tun=2Ec</span><br><span=
>+++ b/src/openvpn/tun=2Ec</span><br><span>@@ -1040,7 +1040,7 @@</span><br>=
<span>  * @param ctx       the networking API opaque context</span><br><spa=
n>  */</span><br><span> static void</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-do_ifconfig_ipv6(struct tuntap *tt, const char *ifname, int t=
un_mtu, const struct env_set *es,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+do_ifconfig_ipv6(const struct tuntap *tt, const char *ifname,=
 int tun_mtu, const struct env_set *es,</span><br><span>                  o=
penvpn_net_ctx_t *ctx)</span><br><span> {</span><br><span> #if !defined(TAR=
GET_LINUX)</span><br><span>@@ -1231,7 +1231,7 @@</span><br><span>  * @param=
 ctx       the networking API opaque context</span><br><span>  */</span><br=
><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-do=
_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu, const st=
ruct env_set *es,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+do=
_ifconfig_ipv4(const struct tuntap *tt, const char *ifname, int tun_mtu, co=
nst struct env_set *es,</span><br><span>                  openvpn_net_ctx_t=
 *ctx)</span><br><span> {</span><br><span> #if !defined(_WIN32) &amp;&amp; =
!defined(TARGET_ANDROID)</span><br><span>@@ -1587,7 +1587,7 @@</span><br><s=
pan> }</span><br><span> </span><br><span> static void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-undo_ifconfig_ipv4(const struct tuntap *tt,=
 openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+undo_ifconfig_ipv4(const struct tuntap *tt, const openvpn_net_ctx_t *c=
tx)</span><br><span> {</span><br><span> #if defined(TARGET_LINUX)</span><br=
><span>     int netbits =3D netmask_to_netbits2(tt-&gt;remote_netmask);</sp=
an><br><span>@@ -1622,7 +1622,7 @@</span><br><span> }</span><br><span> </sp=
an><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-undo_ifconfig_ipv6(const struct tuntap *tt, openvpn_net_ctx_t *ctx)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+undo_ifconfig_ipv6(cons=
t struct tuntap *tt, const openvpn_net_ctx_t *ctx)</span><br><span> {</span=
><br><span> #if defined(TARGET_LINUX)</span><br><span>     if (net_addr_v6_=
del(ctx, tt-&gt;actual_name, &amp;tt-&gt;local_ipv6, tt-&gt;netbits_ipv6) &=
lt; 0)</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2108?usp=3Demail">change 2108</a>=2E To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2108?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: I571e30bb22ec7bffc2c5fa=
04fdcd73b52ce47e5e </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 2108 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>

</body></html>
--K6TL2qXsnKY=--


--===============9162128800691964439==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9162128800691964439==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9162128800691964439==--

