Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E94606A332
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 22:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=WEHgo1Hv;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=HhgTW3Za;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=fOHDCgyv;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=BOPceXDk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=/LhSZKILw2a2tdNwPCaDfVSQ7THmblwGXE+7rLkzAP0=; b=WEHgo1Hvwr/CEcPZZLmH/TvQh0
	mrJLPQza2KY12g4X/B750S7xSSsen/G73JTD1w5qhnTgQEIpsSSpmDdDLsX/OkqP/sLwyVdaYRcKk
	pd4l6LC88WXKyBT2ArJVXzhlZFQH7Y74tG2WwUJpi8Be53Aj+uqmAIDCyhqYbMB+CQBg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRzR7-0000000078O-04f3;
	Fri, 13 Nov 2026 22:07:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRzQV-0000000075V-3Sb0
 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 22:07:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LxlazemffO7xOUImJGwl1DTJEy8wU4osBxeS0jSRsrE=; b=HhgTW3ZalyKGMcoZoGHUJ24BBY
 NFm5/b4oiyQKNP6tfAIaSd8WAEcm8TTUjwiOuxt6qwbTlU6hJBTuxUlNUyOXPlOqhTNPdBFHVeXmj
 Yjzt/89k3El9FQQ1SdfKunOAQ/F38MEWmFzj1QOfPmjc09JeAQhNs4clOghH5SY/9hnU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LxlazemffO7xOUImJGwl1DTJEy8wU4osBxeS0jSRsrE=; b=fOHDCgyvSjVHNZqR4St4/TPDCm
 jMYkoD/5TGKEfy1Nk+sVRkagKqxY3I4vt5fACjh+bbDgiWVBsH7xP86QPZFQgmBYdF/6y2f97yTlp
 oCBG4nUZyxS5JUShIIeQkpJR5dRFw7p34PJet+e1qpu+rbHHl44SBFh95yCfx1ibz7rE=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRzQM-000000008JN-0eoz for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 22:07:19 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so24228065e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 13 Nov 2026 14:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794607623; x=1795212423; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LxlazemffO7xOUImJGwl1DTJEy8wU4osBxeS0jSRsrE=;
 b=BOPceXDkmYDdBRM3VtkTVFzSBZj3vHWSYGubQXsjJ6fgX0fsJccqCBf/5Vac4dBrxw
 WhH3DeXcVBOlXeRs4/QYPFkl/ZeqXbf1bD6rEH3XMYUJ6p1p6vbU5uG6GncFZTQ9J3C4
 Mvda5rDcnQvfdeeiZWQOQmiEzpv5PHsgCkgnAQuL4wtUCplSACHZhTbsmUqP/duYNmt7
 sodw6wg/igSThGK0JsYAdoQ0qizI0wpidqVnW+SFTPRaM/dkySuybbioPYDOEGyvnII+
 wpp/YDTx74vBCiofcTThp/70HpLSye9osdgZkxWcc3LfFdOk9mJy4KNbxY0Ah+Xiw9iP
 Z2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794607623; x=1795212423;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LxlazemffO7xOUImJGwl1DTJEy8wU4osBxeS0jSRsrE=;
 b=XKiGyus+ocXDDhiaT90SPuBNsLQqjRB8hP1AgtHO3vCpVCG16oVJz4Lkk2HttnTS3r
 5s2TswgnSb6NHfyEE60PAN2Qn0E4J8rGfssQmdZ72c6P+0RF0GP/cZzWUjXKpKijmSez
 IAXJkXjmSrj2/joCKyE/Ei4Mi5Tu8Tm/mtDm1cIDPBQJtnVjl1NDrIZeHTLgOCtqCHxY
 SrfUDo6qKFy5VZNWak/a3mxhQWO4gp4/+vY0QOqvjwlCPOxRwVAR4iCnHQn0CZHon36Y
 gsTLoBDW7kN0eKlnYYj6nKgoWVZFBF4HdyiieoTAXEDmWecBWWY5W57mvIAjzDZez0X+
 +mPA==
X-Gm-Message-State: APuU4Z8jILXNjrKO20QN9RXvCOWY+MVUQxomX4ouEG5x1mtsEbfOtEMt
 mYhAE/jS2MAts1bJniNZW0cowVLM9Vl2fOVEwKdydrGgqJULIZ+AuLUAAdmfw1a0mfecYT4pp1c
 aqYf71rzw5lMVtgjho4lKemCmgKUWyvezXoQU7uLrjppUVlTRbHmCnpPeC5ATBkgDl4t3
X-Gm-Gg: AYBFou0yOXDipGjTPY8p49osXIPSLX9A8zEgYFOpcaRMPqUlO+KT7mctW1ujEgJ4OwR
 M1WW3uLu2nZ9McTcSikMOrgtiJBAsf6EgzcQf127QlnQtTuuSfA5uXDkgp7FymTW65XaaiFUw4Y
 DaYohPVq/ggCee1vgoARfwKz3aQ7uTh4o4p2zaSsV4w8jlYOt2D8T+qwsbJvBxU4mVHJhI4ppSw
 OZatQNqhrOOdot+eiV3P51Zs0Oi61rhIJJS8XMDm5lc42nh/k5QCH2NPcNia+3KiapdIpJO3/zR
 cNpPwj3RYvtif5P8ZwmpH144btdNQ4OeTMIsHlsmne3Q5tBx2NziEDODjzN3A9lHj3UwaUNCAQ3
 s7eDgHPtDdL6QMoaTuYhTTlOB67fSebJT3k7Yw82YtPwwP00rBkfewB/FOwcMuwvTNHac/X+j7Z
 tcBcw8EnJAoZ2uLKBNvXwU2963W2/PP3GUKbGsPBYQ2Dyt9M4FPs+562jo4YnVBNuJB8KWa/D4J
 5bMRL2ecj4v2G6/+1t8JhBvK1Sr4k9Z58VgMJiMEgUs43ObcOu+T0dONs4XyUmLN9eO4wl9Desm
 HYf223LzZFE3zXQaaptnz3qPFWhvwGzAbCbPymSTsRZywHRZTLA73bKJ2c+uaKSlKgxm1fln7aP
 iMpxUqouA+M9t7n3nTzydnF7NS+1y43MD5JB4p+zXQpBntvYX8Owit8kaFKfQ3AKUtcw11XrMvl
 PoqoxYc9NUSWloppc=
X-Received: by 2002:a05:600c:2c7:b0:4a1:cfa7:e968 with SMTP id
 5b1f17b1804b1-4bb55a595f7mr52086665e9.21.1794607622286; 
 Fri, 13 Nov 2026 14:07:02 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55ae5299sm102501695e9.11.2026.11.13.14.07.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 14:07:01 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 13 Nov 2026 22:06:59 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 21
X-Gerrit-Change-Id: Iecf502ec811e99c56647b2d45298fa0fb66960fb
X-Gerrit-Change-Number: 1186
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1186?usp=email>
X-Gerrit-Commit: 132cc1ada4e28af5a7b49e2de44184ff500daca6
In-Reply-To: <gerrit.1757937905000.Iecf502ec811e99c56647b2d45298fa0fb66960fb@gerrit.openvpn.net>
References: <gerrit.1757937905000.Iecf502ec811e99c56647b2d45298fa0fb66960fb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzU3OTM3OTA1MDAwLkllY2Y1MDJlYzgxMWU5OWM1NjY0N2IyZDQ1Mjk4ZmEwZmI2Njk2MGZiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <df80ef376637ed4e714fbcd3457a0ee0f01bc5b4-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRzQM-000000008JN-0eoz
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Enable
 -Wsign-conversion
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2378278112417232561=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2378278112417232561==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="t56Hrt5BvxY="; charset=UTF-8

--t56Hrt5BvxY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#21) to the change originally cr=
eated by Frank Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1186?usp=3Demail )

The following approvals got outdated and were removed:
=
Code-Review+2 by R=C4=83zvan Cojocaru


Change subject: Enable -Wsign-conve=
rsion
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Enable =
-Wsign-conversion

As before with -Wconversion override all the known issue=
s
to be able to address them one by one=2E

Change-Id: Iecf502ec811e99c5664=
7b2d45298fa0fb66960fb
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1186
Message-Id: <20261112174213=2E23=
832-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvp=
n-devel@lists=2Esourceforge=2Enet/msg41216=2Ehtml
Signed-off-by: Gert Doeri=
ng <gert@greenie=2Emuc=2Ede>
---
M CMakeLists=2Etxt
M configure=2Eac
M src/=
openvpn/acc=2Ec
M src/openvpn/argv=2Ec
M src/openvpn/auth_token=2Ec
M src/o=
penvpn/buffer=2Ec
M src/openvpn/buffer=2Eh
M src/openvpn/comp-lz4=2Ec
M src=
/openvpn/console_builtin=2Ec
M src/openvpn/console_systemd=2Ec
M src/openvp=
n/crypto=2Ec
M src/openvpn/crypto_epoch=2Ec
M src/openvpn/crypto_mbedtls=2E=
c
M src/openvpn/crypto_openssl=2Ec
M src/openvpn/cryptoapi=2Ec
M src/openvp=
n/dco=2Ec
M src/openvpn/dco_freebsd=2Ec
M src/openvpn/dco_linux=2Ec
M src/o=
penvpn/dco_win=2Ec
M src/openvpn/dhcp=2Ec
M src/openvpn/dns=2Ec
M src/openv=
pn/env_set=2Ec
M src/openvpn/error=2Ec
M src/openvpn/error=2Eh
M src/openvp=
n/event=2Ec
M src/openvpn/fdmisc=2Ec
M src/openvpn/fdmisc=2Eh
M src/openvpn=
/forward=2Ec
M src/openvpn/fragment=2Ec
M src/openvpn/helper=2Ec
M src/open=
vpn/init=2Ec
M src/openvpn/lzo=2Ec
M src/openvpn/manage=2Ec
M src/openvpn/m=
isc=2Ec
M src/openvpn/mss=2Ec
M src/openvpn/mtcp=2Ec
M src/openvpn/mtu=2Ec
=
M src/openvpn/multi=2Ec
M src/openvpn/multi_io=2Ec
M src/openvpn/networking=
_sitnl=2Ec
M src/openvpn/occ=2Ec
M src/openvpn/openvpn=2Ec
M src/openvpn/op=
tions=2Ec
M src/openvpn/options_parse=2Ec
M src/openvpn/options_show=2Ec
M =
src/openvpn/options_string=2Ec
M src/openvpn/options_util=2Ec
M src/openvpn=
/packet_id=2Ec
M src/openvpn/ping=2Ec
M src/openvpn/pkcs11=2Ec
M src/openvp=
n/pkcs11_openssl=2Ec
M src/openvpn/platform=2Ec
M src/openvpn/plugin=2Ec
M =
src/openvpn/pool=2Ec
M src/openvpn/proxy=2Ec
M src/openvpn/ps=2Ec
M src/ope=
nvpn/push=2Ec
M src/openvpn/reliable=2Ec
M src/openvpn/route=2Ec
M src/open=
vpn/socket=2Ec
M src/openvpn/socket=2Eh
M src/openvpn/socket_util=2Ec
M src=
/openvpn/socks=2Ec
M src/openvpn/ssl=2Ec
M src/openvpn/ssl_mbedtls=2Ec
M sr=
c/openvpn/ssl_ncp=2Ec
M src/openvpn/ssl_openssl=2Ec
M src/openvpn/ssl_pkt=
=2Ec
M src/openvpn/ssl_util=2Ec
M src/openvpn/ssl_verify=2Ec
M src/openvpn/=
ssl_verify_mbedtls=2Ec
M src/openvpn/ssl_verify_openssl=2Ec
M src/openvpn/s=
tatus=2Ec
M src/openvpn/tls_crypt=2Ec
M src/openvpn/tun=2Ec
M src/openvpn/t=
un_afunix=2Ec
M src/openvpn/vlan=2Ec
M src/openvpn/wfp_block=2Ec
M src/open=
vpn/win32-util=2Ec
M src/openvpn/win32=2Ec
M src/openvpn/xkey_helper=2Ec
M =
src/openvpn/xkey_provider=2Ec
M src/openvpnmsica/dllmain=2Ec
M src/openvpns=
erv/common=2Ec
M src/openvpnserv/interactive=2Ec
M src/plugins/auth-pam/aut=
h-pam=2Ec
M src/tapctl/tap=2Ec
M tests/unit_tests/openvpn/test_buffer=2Ec
M=
 tests/unit_tests/openvpn/test_crypto=2Ec
M tests/unit_tests/openvpn/test_c=
ryptoapi=2Ec
M tests/unit_tests/openvpn/test_dhcp=2Ec
M tests/unit_tests/op=
envpn/test_networking=2Ec
M tests/unit_tests/openvpn/test_pkt=2Ec
M tests/u=
nit_tests/openvpn/test_ssl=2Ec
M tests/unit_tests/openvpn/test_tls_crypt=2E=
c
M tests/unit_tests/openvpn/test_user_pass=2Ec
96 files changed, 1,116 ins=
ertions(+), 11 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418=
/openvpn refs/changes/86/1186/21

diff --git a/CMakeLists=2Etxt b/CMakeList=
s=2Etxt
index 5cf1a30=2E=2Ea90eb1a 100644
--- a/CMakeLists=2Etxt
+++ b/CMak=
eLists=2Etxt
@@ -117,7 +117,7 @@
     check_and_add_compiler_flag(-Wno-stri=
ngop-truncation NoStringOpTruncation)
     check_and_add_compiler_flag(-Wst=
rict-prototypes StrictPrototypes)
     check_and_add_compiler_flag(-Wold-st=
yle-definition OldStyleDefinition)
-    add_compile_options(-Wconversion -W=
no-sign-conversion)
+    add_compile_options(-Wconversion)
     add_compile=
_options(-Wextra -Wno-unused-parameter)
     # clang doesn't have the diffe=
rent levels but also doesn't include it in -Wextra
     check_and_add_compi=
ler_flag(-Wimplicit-fallthrough=3D2 GCCImplicitFallthrough)
diff --git a/co=
nfigure=2Eac b/configure=2Eac
index 9326c4e=2E=2E585c3bd 100644
--- a/confi=
gure=2Eac
+++ b/configure=2Eac
@@ -1248,7 +1248,7 @@
 ACL_CHECK_ADD_COMPILE=
_FLAGS([-Wno-stringop-truncation])
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wstrict-p=
rototypes])
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wold-style-definition])
-ACL_CHE=
CK_ADD_COMPILE_FLAGS([-Wconversion -Wno-sign-conversion])
+ACL_CHECK_ADD_CO=
MPILE_FLAGS([-Wconversion])
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wall])
 ACL_CHEC=
K_ADD_COMPILE_FLAGS([-Wextra -Wno-unused-parameter])
 # clang doesn't have =
the different levels but also doesn't include it in -Wextra
diff --git a/sr=
c/openvpn/acc=2Ec b/src/openvpn/acc=2Ec
index e9656a6=2E=2Eceb7100 100644
-=
-- a/src/openvpn/acc=2Ec
+++ b/src/openvpn/acc=2Ec
@@ -148,6 +148,11 @@
   =
  return parse_acc_message_flags(flags, err_reason, gc);
 }
 
+#if defined(=
__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC d=
iagnostic ignored "-Wsign-conversion"
+#endif
+
 void
 receive_acc_message(=
struct context *c, const struct buffer *buffer)
 {
@@ -236,6 +241,10 @@
 }
=
 
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic po=
p
+#endif
+
 bool
 send_acc_message(struct context *c,
                  st=
ruct tls_multi *multi,
diff --git a/src/openvpn/argv=2Ec b/src/openvpn/argv=
=2Ec
index 028671d=2E=2Ec716e5b0 100644
--- a/src/openvpn/argv=2Ec
+++ b/sr=
c/openvpn/argv=2Ec
@@ -323,6 +323,11 @@
     return f;
 }
 
+#if defined(__=
GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC dia=
gnostic ignored "-Wsign-conversion"
+#endif
+
 /**
  *  Create a struct arg=
v based on a format string
  *
@@ -418,6 +423,10 @@
     return res;
 }
 
+=
#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#e=
ndif
+
 /**
  *  printf() variant which populates a struct argv=2E  It proc=
esses the
  *  format string with the provided arguments=2E  For each space=
 separator found
diff --git a/src/openvpn/auth_token=2Ec b/src/openvpn/auth=
_token=2Ec
index 84558af=2E=2E211af90 100644
--- a/src/openvpn/auth_token=
=2Ec
+++ b/src/openvpn/auth_token=2Ec
@@ -36,6 +36,11 @@
  * padding */
 st=
atic_assert(TOKEN_DATA_LEN % 3 =3D=3D 0, "TOKEN_DATA_LEN is not a multiple =
of 3");
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnos=
tic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 boo=
l
 is_auth_token(const char *password)
 {
@@ -291,6 +296,9 @@
     gc_free(=
&gc);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagno=
stic pop
+#endif
 
 static bool
 check_hmac_token(hmac_ctx_t *ctx, const ui=
nt8_t *b64decoded, const char *username)
diff --git a/src/openvpn/buffer=2E=
c b/src/openvpn/buffer=2Ec
index 8813fa5=2E=2E7f142c4f 100644
--- a/src/ope=
nvpn/buffer=2Ec
+++ b/src/openvpn/buffer=2Ec
@@ -92,6 +92,11 @@
     return=
 buf;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagno=
stic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 st=
ruct buffer
 #ifdef BUF_INIT_TRACKING
 clone_buf_debug(const struct buffer =
*buf, const char *file, int line)
@@ -305,6 +310,10 @@
     return ret;
 }
=
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
=
+#endif
+
 /*
  * Garbage collection
  */
@@ -439,6 +448,11 @@
     }
 }
 
=
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+=
#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /*
  * Hex du=
mp -- Output a binary buffer to a hex string and return it=2E
  */
@@ -538,=
6 +552,10 @@
     buf_null_terminate(buf);
 }
 
+#if defined(__GNUC__) || d=
efined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 const char *
 skip=
_leading_whitespace(const char *str)
 {
@@ -717,6 +735,11 @@
     return me=
mcmp(CBPTR(src), match, size) =3D=3D 0;
 }
 
+#if defined(__GNUC__) || defi=
ned(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored=
 "-Wsign-conversion"
+#endif
+
 bool
 buf_string_compare_advance(struct buf=
fer *src, const char *match)
 {
@@ -731,6 +754,10 @@
     }
 }
 
+#if defin=
ed(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 i=
nt
 buf_substring_len(const struct buffer *buf, int delim)
 {
@@ -957,6 +98=
4,11 @@
     return false;
 }
 
+#if defined(__GNUC__) || defined(__clang__=
)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conv=
ersion"
+#endif
+
 static inline bool
 char_inc_exc(const char c, const uns=
igned int inclusive, const unsigned int exclusive)
 {
@@ -964,6 +996,10 @@
=
            && !char_class((unsigned char)c, exclusive);
 }
 
+#if defined(=
__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 bool=

 string_class(const char *str, const unsigned int inclusive, const unsigne=
d int exclusive)
 {
@@ -1241,6 +1277,11 @@
     }
 }
 
+#if defined(__GNUC_=
_) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnost=
ic ignored "-Wsign-conversion"
+#endif
+
 void
 buffer_list_aggregate_separ=
ator(struct buffer_list *bl, const size_t max_len, const char *sep)
 {
@@ -=
1286,6 +1327,10 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)=

+#pragma GCC diagnostic pop
+#endif
+
 void
 buffer_list_aggregate(struct =
buffer_list *bl, const size_t max)
 {
@@ -1323,6 +1368,11 @@
     }
 }
 
+#=
if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#p=
ragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 struct buffer_l=
ist *
 buffer_list_file(const char *fn, int max_line_len)
 {
@@ -1402,3 +14=
52,7 @@
     buf_advance(buf, field_len + 1);
     return field;
 }
+
+#if =
defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif=

diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh
index 7af4444=
=2E=2Eede3066 100644
--- a/src/openvpn/buffer=2Eh
+++ b/src/openvpn/buffer=
=2Eh
@@ -643,6 +643,11 @@
     return true;
 }
 
+#if defined(__GNUC__) || =
defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ign=
ored "-Wsign-conversion"
+#endif
+
 /**
  * Initialise a buffer with an ext=
ernally provided writable memory region=2E
  *
@@ -1619,6 +1624,10 @@
     =
return memcmp(CBPTR(src), match, size) =3D=3D 0;
 }
 
+#if defined(__GNUC__=
) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /**
  * Retu=
rn true if the head of \c src matches the string \c match=2E
  *
diff --git=
 a/src/openvpn/comp-lz4=2Ec b/src/openvpn/comp-lz4=2Ec
index 57c6bb3=2E=2E0=
c5f22f 100644
--- a/src/openvpn/comp-lz4=2Ec
+++ b/src/openvpn/comp-lz4=2Ec=

@@ -89,6 +89,11 @@
     compv2_escape_data_ifneeded(buf);
 }
 
+#if define=
d(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC=
 diagnostic ignored "-Wsign-conversion"
+#endif
+
 static void
 do_lz4_deco=
mpress(int zlen_max, struct buffer *work, struct buffer *buf,
             =
      struct compress_context *compctx)
@@ -198,6 +203,10 @@
     }
 }
 
+#=
if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#en=
dif
+
 const struct compress_alg lz4_alg =3D { "lz4", lz4_compress_init, lz=
4_compress_uninit, lz4_compress,
                                       lz4=
_decompress };
 
diff --git a/src/openvpn/console_builtin=2Ec b/src/openvpn=
/console_builtin=2Ec
index 4737677=2E=2Edc71d12 100644
--- a/src/openvpn/co=
nsole_builtin=2Ec
+++ b/src/openvpn/console_builtin=2Ec
@@ -41,6 +41,11 @@
=
 #include <termios=2Eh>
 #endif
 
+#if defined(__GNUC__) || defined(__clang=
__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-co=
nversion"
+#endif
+
 #ifdef _WIN32
 
 #include "win32=2Eh"
@@ -289,3 +294,7=
 @@
 
     return ret;
 }
+
+#if defined(__GNUC__) || defined(__clang__)
+#=
pragma GCC diagnostic pop
+#endif
diff --git a/src/openvpn/console_systemd=
=2Ec b/src/openvpn/console_systemd=2Ec
index eaed24e=2E=2E8fc7f72 100644
--=
- a/src/openvpn/console_systemd=2Ec
+++ b/src/openvpn/console_systemd=2Ec
@=
@ -53,6 +53,11 @@
     return (sd_booted() > 0) && (stat(SYSTEMD_ASK_PASSWO=
RD_PATH, &c) =3D=3D 0);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+=
#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-convers=
ion"
+#endif
+
 static bool
 get_console_input_systemd(const char *prompt, =
const bool echo, char *input, const int capacity)
 {
@@ -86,6 +91,10 @@
   =
  return ret;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GC=
C diagnostic pop
+#endif
+
 /**
  *  Systemd aware implementation of query_=
user_exec()=2E  If systemd is not running
  *  it will fall back to use que=
ry_user_exec_builtin() instead=2E
diff --git a/src/openvpn/crypto=2Ec b/src=
/openvpn/crypto=2Ec
index 6efa005=2E=2E9d53006 100644
--- a/src/openvpn/cry=
pto=2Ec
+++ b/src/openvpn/crypto=2Ec
@@ -62,6 +62,11 @@
  * happen unless t=
he frame parameters are wrong=2E
  */
 
+#if defined(__GNUC__) || defined(_=
_clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Ws=
ign-conversion"
+#endif
+
 static void
 openvpn_encrypt_aead(struct buffer =
*buf, struct buffer work, struct crypto_options *opt)
 {
@@ -1573,6 +1578,1=
0 @@
     return nbits;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+=
#pragma GCC diagnostic pop
+#endif
+
 void
 must_have_n_keys(const char *fi=
lename, const char *option, const struct key2 *key2, int n)
 {
diff --git a=
/src/openvpn/crypto_epoch=2Ec b/src/openvpn/crypto_epoch=2Ec
index 35f9b55=
=2E=2E312cf6f 100644
--- a/src/openvpn/crypto_epoch=2Ec
+++ b/src/openvpn/c=
rypto_epoch=2Ec
@@ -38,6 +38,11 @@
 #include "buffer=2Eh"
 #include "intege=
r=2Eh"
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnost=
ic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 void=

 ovpn_hkdf_expand(const uint8_t *secret, const uint8_t *info, size_t info_=
len,
                  uint8_t *out, size_t out_len)
@@ -458,3 +463,7 @@
  =
       epoch_iterate_send_key(opt);
     }
 }
+
+#if defined(__GNUC__) || d=
efined(__clang__)
+#pragma GCC diagnostic pop
+#endif
diff --git a/src/open=
vpn/crypto_mbedtls=2Ec b/src/openvpn/crypto_mbedtls=2Ec
index 3a2a8c6=2E=2E=
ceaaad4 100644
--- a/src/openvpn/crypto_mbedtls=2Ec
+++ b/src/openvpn/crypt=
o_mbedtls=2Ec
@@ -821,6 +821,11 @@
     ASSERT(hmac_length =3D=3D dst_size)=
;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic=
 push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /*
  *=
 Generate the hash required by for the \c tls1_PRF function=2E
  *
@@ -1149=
,4 +1154,8 @@
     return ret;
 }
 
+#if defined(__GNUC__) || defined(__cla=
ng__)
+#pragma GCC diagnostic pop
+#endif
+
 #endif /* defined(ENABLE_CRYPT=
O_MBEDTLS) */
diff --git a/src/openvpn/crypto_openssl=2Ec b/src/openvpn/cry=
pto_openssl=2Ec
index b7f2ef3=2E=2E0a1d00c 100644
--- a/src/openvpn/crypto_=
openssl=2Ec
+++ b/src/openvpn/crypto_openssl=2Ec
@@ -487,6 +487,11 @@
     =
return ret;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC =
diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif=

+
 bool
 crypto_pem_decode(const char *name, struct buffer *dst, const str=
uct buffer *src)
 {
@@ -1306,6 +1311,10 @@
 }
 #endif /* if OPENSSL_VERSION=
_NUMBER < 0x30000000L */
 
+#if defined(__GNUC__) || defined(__clang__)
+#p=
ragma GCC diagnostic pop
+#endif
+
 int
 memcmp_constant_time(const void *a=
, const void *b, size_t size)
 {
diff --git a/src/openvpn/cryptoapi=2Ec b/s=
rc/openvpn/cryptoapi=2Ec
index ef3c94c=2E=2E30a5144 100644
--- a/src/openvp=
n/cryptoapi=2Ec
+++ b/src/openvpn/cryptoapi=2Ec
@@ -62,7 +62,7 @@
     retu=
rn 0;
 }
 
-#else  /* HAVE_XKEY_PROVIDER */
+#else /* HAVE_XKEY_PROVIDER */=

 
 static XKEY_EXTERNAL_SIGN_fn xkey_cng_sign;
 
@@ -260,6 +260,11 @@
    =
 return false;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma G=
CC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#en=
dif
+
 static const CERT_CONTEXT *
 find_certificate_in_store(const char *c=
ert_prop, HCERTSTORE cert_store)
 {
@@ -598,6 +603,10 @@
     return 0;
 }
=
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
=
+#endif
+
 int
 SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const c=
har *cert_prop)
 {
diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec
i=
ndex f3b5d44=2E=2E236be93 100644
--- a/src/openvpn/dco=2Ec
+++ b/src/openvp=
n/dco=2Ec
@@ -50,6 +50,11 @@
 #include <cap-ng=2Eh>
 #endif
 
+#if defined(=
__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC d=
iagnostic ignored "-Wsign-conversion"
+#endif
+
 static int
 dco_install_ke=
y(struct tls_multi *multi, struct key_state *ks, const uint8_t *encrypt_key=
,
                 const uint8_t *encrypt_iv, const uint8_t *decrypt_key, c=
onst uint8_t *decrypt_iv,
@@ -807,4 +812,8 @@
 #endif /* if defined(TARGET_=
LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32) */
 }
 
+#if defined(_=
_GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #endi=
f /* defined(ENABLE_DCO) */
diff --git a/src/openvpn/dco_freebsd=2Ec b/src/=
openvpn/dco_freebsd=2Ec
index 3148f10=2E=2E11b8dff 100644
--- a/src/openvpn=
/dco_freebsd=2Ec
+++ b/src/openvpn/dco_freebsd=2Ec
@@ -577,6 +577,11 @@
   =
      __func__, peerid, mi->context=2Ec2=2Edco_read_bytes, mi->context=2Ec2=
=2Edco_write_bytes);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pr=
agma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion=
"
+#endif
+
 int
 dco_read_and_process(dco_context_t *dco)
 {
@@ -762,6 +76=
7,10 @@
     return available;
 }
 
+#if defined(__GNUC__) || defined(__cla=
ng__)
+#pragma GCC diagnostic pop
+#endif
+
 const char *
 dco_version_stri=
ng(struct gc_arena *gc)
 {
diff --git a/src/openvpn/dco_linux=2Ec b/src/ope=
nvpn/dco_linux=2Ec
index a84e310=2E=2E60107c4 100644
--- a/src/openvpn/dco_=
linux=2Ec
+++ b/src/openvpn/dco_linux=2Ec
@@ -220,6 +220,11 @@
     return =
sock;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagno=
stic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 in=
t
 dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd, struct soc=
kaddr *localaddr,
              struct sockaddr *remoteaddr, const struct i=
n_addr *vpn_ipv4,
@@ -1257,6 +1262,10 @@
     return ret;
 }
 
+#if defined=
(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 int=

 dco_get_peer_stats(struct context *c, const bool raise_sigusr1_on_err)
 {=

diff --git a/src/openvpn/dco_win=2Ec b/src/openvpn/dco_win=2Ec
index 12b06=
66=2E=2Ea854045 100644
--- a/src/openvpn/dco_win=2Ec
+++ b/src/openvpn/dco_=
win=2Ec
@@ -220,6 +220,11 @@
     return 0;
 }
 
+#if defined(__GNUC__) || =
defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ign=
ored "-Wsign-conversion"
+#endif
+
 static void
 dco_connect_wait(HANDLE ha=
ndle, OVERLAPPED *ov, int timeout, struct signal_info *sig_info)
 {
@@ -109=
1,6 +1096,10 @@
     gc_free(&gc);
 }
 
+#if defined(__GNUC__) || defined(_=
_clang__)
+#pragma GCC diagnostic pop
+#endif
+
 bool
 dco_supports_epoch_d=
ata(const struct context *c)
 {
diff --git a/src/openvpn/dhcp=2Ec b/src/ope=
nvpn/dhcp=2Ec
index 19e9e2d=2E=2E525d567 100644
--- a/src/openvpn/dhcp=2Ec
=
+++ b/src/openvpn/dhcp=2Ec
@@ -72,6 +72,11 @@
     return -1;
 }
 
+#if def=
ined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma =
GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static in_addr_t
 do_=
extract(struct dhcp *dhcp, int optlen)
 {
@@ -186,6 +191,10 @@
     return =
0;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnosti=
c pop
+#endif
+
 #if defined(_WIN32) || defined(DHCP_UNIT_TEST)
 
 /*
@@ -3=
27,6 +336,11 @@
     buf_write(buf, tmp_buf, len);
 }
 
+#if defined(__GNUC=
__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnos=
tic ignored "-Wsign-conversion"
+#endif
+
 bool
 build_dhcp_options_string(=
struct buffer *buf, const struct tuntap_options *o)
 {
@@ -375,4 +389,8 @@
=
     return !error;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pra=
gma GCC diagnostic pop
+#endif
+
 #endif /* defined(_WIN32) */
diff --git a=
/src/openvpn/dns=2Ec b/src/openvpn/dns=2Ec
index abe30ed=2E=2Ee2cb981 10064=
4
--- a/src/openvpn/dns=2Ec
+++ b/src/openvpn/dns=2Ec
@@ -58,6 +58,11 @@
  =
   return true;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma =
GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#e=
ndif
+
 bool
 dns_server_addr_parse(struct dns_server *server, const char *=
addr)
 {
@@ -144,6 +149,10 @@
     return true;
 }
 
+#if defined(__GNUC__)=
 || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 bool
 dns_dom=
ain_list_append(struct dns_domain **entry, char **domains, struct gc_arena =
*gc)
 {
@@ -402,6 +411,11 @@
     }
 }
 
+#if defined(__GNUC__) || defined(=
__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-W=
sign-conversion"
+#endif
+
 static void
 run_up_down_service(bool add, cons=
t struct options *o, const struct tuntap *tt)
 {
@@ -476,7 +490,11 @@
     =
send_msg_iservice(o->msg_channel, &nrpt, sizeof(nrpt), &ack, "DNS");
 }
 
-=
#else  /* ifdef _WIN32 */
+#if defined(__GNUC__) || defined(__clang__)
+#pr=
agma GCC diagnostic pop
+#endif
+
+#else /* ifdef _WIN32 */
 
 static void
=
 setenv_dns_option(struct env_set *es, const char *format, size_t i, size_t=
 j, const char *value)
@@ -702,6 +720,11 @@
     return true;
 }
 
+#if def=
ined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma =
GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static void
 run_up_d=
own_command(bool up, struct options *o, const struct tuntap *tt,
          =
           struct dns_updown_runner_info *updown_runner)
@@ -780,6 +803,10 =
@@
     msg(M_INFO, "dns %s command exited with status %d", up ? "up" : "do=
wn", status);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GC=
C diagnostic pop
+#endif
+
 #endif /* _WIN32 */
 
 void
diff --git a/src/op=
envpn/env_set=2Ec b/src/openvpn/env_set=2Ec
index 67a5bf5=2E=2Ed59115a 1006=
44
--- a/src/openvpn/env_set=2Ec
+++ b/src/openvpn/env_set=2Ec
@@ -432,6 +4=
32,11 @@
     return (script_security() >=3D SSEC_PW_ENV || !is_password_en=
v_var(str));
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC=
 diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endi=
f
+
 /* Make arrays of strings */
 
 const char **
@@ -470,3 +475,7 @@
    =
 ret[i] =3D NULL;
     return (const char **)ret;
 }
+
+#if defined(__GNUC_=
_) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
diff --git a/s=
rc/openvpn/error=2Ec b/src/openvpn/error=2Ec
index 32d819d=2E=2Ea3f7990 100=
644
--- a/src/openvpn/error=2Ec
+++ b/src/openvpn/error=2Ec
@@ -219,6 +219,=
11 @@
     va_end(arglist);
 }
 
+#if defined(_WIN32) && (defined(__GNUC__)=
 || defined(__clang__))
+#pragma GCC diagnostic push
+#pragma GCC diagnosti=
c ignored "-Wsign-conversion"
+#endif
+
 static const char *
 openvpn_strer=
ror(int err, bool crt_error, struct gc_arena *gc)
 {
@@ -689,6 +694,10 @@
 =
    }
 }
 
+#if defined(_WIN32) && (defined(__GNUC__) || defined(__clang__)=
)
+#pragma GCC diagnostic pop
+#endif
+
 /*
  * In multiclient mode, put a =
client-specific prefix
  * before each message=2E
diff --git a/src/openvpn/=
error=2Eh b/src/openvpn/error=2Eh
index 373cbc1=2E=2E0056d05 100644
--- a/s=
rc/openvpn/error=2Eh
+++ b/src/openvpn/error=2Eh
@@ -406,6 +406,11 @@
 }
 #=
endif
 
+#if defined(_WIN32) && (defined(__GNUC__) || defined(__clang__))
+=
#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-convers=
ion"
+#endif
+
 static inline int
 openvpn_errno_maybe_crt(bool *crt_error)=

 {
@@ -426,6 +431,10 @@
     return err;
 }
 
+#if defined(_WIN32) && (def=
ined(__GNUC__) || defined(__clang__))
+#pragma GCC diagnostic pop
+#endif
+=

 #include "errlevel=2Eh"
 
 #endif /* ifndef ERROR_H */
diff --git a/src/o=
penvpn/event=2Ec b/src/openvpn/event=2Ec
index 5e17ea1=2E=2Ec4a856d 100644
=
--- a/src/openvpn/event=2Ec
+++ b/src/openvpn/event=2Ec
@@ -486,6 +486,11 @=
@
 #endif
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC di=
agnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+=

 static struct event_set *
 we_init(int *maxevents, unsigned int flags)
 {=

@@ -524,8 +529,17 @@
     return (struct event_set *)wes;
 }
 
+#if define=
d(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #e=
ndif /* _WIN32 */
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma G=
CC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#en=
dif
+
 #if EPOLL
 
 struct ep_set
@@ -1122,6 +1136,10 @@
 }
 #endif /* SELE=
CT */
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnosti=
c pop
+#endif
+
 static struct event_set *
 event_set_init_simple(int *maxe=
vents, unsigned int flags)
 {
diff --git a/src/openvpn/fdmisc=2Ec b/src/ope=
nvpn/fdmisc=2Ec
index 6910f81=2E=2Ee715964 100644
--- a/src/openvpn/fdmisc=
=2Ec
+++ b/src/openvpn/fdmisc=2Ec
@@ -31,6 +31,11 @@
 
 #include "memdbg=2E=
h"
 
+#if defined(_WIN32) && (defined(__GNUC__) || defined(__clang__))
+#pr=
agma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion=
"
+#endif
+
 /* Set a file descriptor to non-blocking */
 bool
 set_nonbloc=
k_action(socket_descriptor_t fd)
@@ -50,6 +55,10 @@
     return true;
 }
 
=
+#if defined(_WIN32) && (defined(__GNUC__) || defined(__clang__))
+#pragma =
GCC diagnostic pop
+#endif
+
 /* Set a file descriptor to not be passed acr=
oss execs */
 bool
 set_cloexec_action(socket_descriptor_t fd)
diff --git a=
/src/openvpn/fdmisc=2Eh b/src/openvpn/fdmisc=2Eh
index eac8075=2E=2E15ee3cd=
 100644
--- a/src/openvpn/fdmisc=2Eh
+++ b/src/openvpn/fdmisc=2Eh
@@ -35,6 =
+35,11 @@
 
 void set_cloexec(socket_descriptor_t fd);
 
+#if defined(__GNU=
C__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagno=
stic ignored "-Wsign-conversion"
+#endif
+
 static inline void
 openvpn_fd_=
set(socket_descriptor_t fd, fd_set *setp)
 {
@@ -45,4 +50,8 @@
 }
 #undef F=
D_SET /* prevent direct use of FD_SET() */
 
-#endif        /* FD_MISC_H */=

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+=
#endif
+
+#endif /* FD_MISC_H */
diff --git a/src/openvpn/forward=2Ec b/src=
/openvpn/forward=2Ec
index ba0e0ec=2E=2Eb4277db 100644
--- a/src/openvpn/fo=
rward=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -286,6 +286,11 @@
     }
 }
 
+#=
if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#p=
ragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /*
  * Handle i=
ncoming configuration
  * messages on the control channel=2E
@@ -2025,6 +20=
30,10 @@
     check_timeout_random_component(c);
 }
 
+#if defined(__GNUC__=
) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 void
 multi_=
io_process_flags(struct context *c, struct event_set *es, struct link_socke=
t *sock, const unsigned int flags)
 {
diff --git a/src/openvpn/fragment=2Ec=
 b/src/openvpn/fragment=2Ec
index c454434=2E=2E55f2a08 100644
--- a/src/ope=
nvpn/fragment=2Ec
+++ b/src/openvpn/fragment=2Ec
@@ -40,6 +40,11 @@
       =
  goto error; \
     }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pra=
gma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"=

+#endif
+
 static void
 fragment_list_buf_init(struct fragment_list *list,=
 const struct frame *frame)
 {
@@ -284,6 +289,10 @@
     ASSERT(buf_write_p=
repend(buf, &flags, sizeof(flags)));
 }
 
+#if defined(__GNUC__) || defined=
(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /*
  * Without changing =
the number of fragments, return a possibly smaller
  * max fragment size th=
at will allow for the last fragment to be of
diff --git a/src/openvpn/helpe=
r=2Ec b/src/openvpn/helper=2Ec
index 6b5fcee6=2E=2Ed9ddf6a 100644
--- a/src=
/openvpn/helper=2Ec
+++ b/src/openvpn/helper=2Ec
@@ -148,6 +148,11 @@
 }
 
=
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push=

+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /*
  * Proc=
ess server, server-bridge, and client helper
  * directives after the param=
eters themselves have been
@@ -507,6 +512,10 @@
     gc_free(&gc);
 }
 
+#i=
f defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#end=
if
+
 /*
  *
  * HELPER DIRECTIVE:
diff --git a/src/openvpn/init=2Ec b/src/=
openvpn/init=2Ec
index 25521f3=2E=2Eea77f16 100644
--- a/src/openvpn/init=
=2Ec
+++ b/src/openvpn/init=2Ec
@@ -102,6 +102,11 @@
     c->persist =3D cp=
save;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagno=
stic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /*=

  * Pass tunnel endpoint and MTU parms to a user-supplied script=2E
  * Us=
ed to execute the up/down script/plugins=2E
@@ -3664,6 +3669,10 @@
     c->=
c2=2Elink_socket_owned =3D true;
 }
 
+#if defined(__GNUC__) || defined(__c=
lang__)
+#pragma GCC diagnostic pop
+#endif
+
 /*
  * bind TCP/UDP sockets
=
  */
diff --git a/src/openvpn/lzo=2Ec b/src/openvpn/lzo=2Ec
index 51cf5e8=
=2E=2E2b0691b 100644
--- a/src/openvpn/lzo=2Ec
+++ b/src/openvpn/lzo=2Ec
@@=
 -40,6 +40,11 @@
 #include "memdbg=2Eh"
 
 
+#if defined(__GNUC__) || defin=
ed(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored =
"-Wsign-conversion"
+#endif
+
 static void
 lzo_compress_init(struct compre=
ss_context *compctx)
 {
@@ -120,6 +125,10 @@
     }
 }
 
+#if defined(__GNU=
C__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 const str=
uct compress_alg lzo_alg =3D { "lzo", lzo_compress_init, lzo_compress_unini=
t, lzo_compress,
                                       lzo_decompress };
 =
#endif /* ENABLE_LZO */
diff --git a/src/openvpn/manage=2Ec b/src/openvpn/m=
anage=2Ec
index 581e7be=2E=2E4809532 100644
--- a/src/openvpn/manage=2Ec
++=
+ b/src/openvpn/manage=2Ec
@@ -779,6 +779,11 @@
     }
 }
 
+#if defined(__=
GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC dia=
gnostic ignored "-Wsign-conversion"
+#endif
+
 static void
 man_query_user_=
pass(struct management *man, const char *type, const char *string, const bo=
ol needed,
                     const char *prompt, char *dest, int len)
@@=
 -804,6 +809,10 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)=

+#pragma GCC diagnostic pop
+#endif
+
 static void
 man_query_username(str=
uct management *man, const char *type, const char *string)
 {
@@ -2473,6 +2=
482,11 @@
 
 #endif /* ifdef TARGET_ANDROID */
 
+#if defined(__GNUC__) || =
defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ign=
ored "-Wsign-conversion"
+#endif
+
 static ssize_t
 man_read(struct managem=
ent *man)
 {
@@ -2611,6 +2625,10 @@
     return sent;
 }
 
+#if defined(__G=
NUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static =
void
 man_connection_clear(struct man_connection *mc)
 {
@@ -2682,6 +2700,1=
1 @@
     CLEAR(*mp);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#p=
ragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversio=
n"
+#endif
+
 static void
 man_settings_init(struct man_settings *ms, const=
 char *addr, const char *port,
                   const char *pass_file, co=
nst char *client_user, const char *client_group,
@@ -3297,6 +3320,10 @@
   =
  return true;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma G=
CC diagnostic pop
+#endif
+
 #ifdef _WIN32
 
 void
@@ -3606,6 +3633,11 @@
 =
    }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagno=
stic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /*=

  * Process the management event loop for sec seconds
  */
@@ -4341,6 +437=
3,10 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma G=
CC diagnostic pop
+#endif
+
 void
 management_check_bytecount_client(struct=
 context *c, struct management *man, struct timeval *timeval)
 {
@@ -4475,6=
 +4511,12 @@
 #else /* ifdef ENABLE_MANAGEMENT */
 
 #include "win32=2Eh"
+=

+#if !defined(_WIN32) && (defined(__GNUC__) || defined(__clang__))
+#pragm=
a GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+=
#endif
+
 void
 management_sleep(const int n)
 {
@@ -4488,4 +4530,8 @@
 #en=
dif /* ifdef _WIN32 */
 }
 
+#if !defined(_WIN32) && (defined(__GNUC__) || =
defined(__clang__))
+#pragma GCC diagnostic pop
+#endif
+
 #endif /* ENABLE=
_MANAGEMENT */
diff --git a/src/openvpn/misc=2Ec b/src/openvpn/misc=2Ec
ind=
ex 8c9ad08=2E=2E9a307a2 100644
--- a/src/openvpn/misc=2Ec
+++ b/src/openvpn=
/misc=2Ec
@@ -72,6 +72,11 @@
 #endif
 }
 
+#if defined(__GNUC__) || defined=
(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-=
Wsign-conversion"
+#endif
+
 #ifdef ENABLE_MANAGEMENT
 /* Get username/pass=
word from the management interface */
 static bool
@@ -762,6 +767,10 @@
   =
  return (state =3D=3D 2);
 }
 
+#if defined(__GNUC__) || defined(__clang__=
)
+#pragma GCC diagnostic pop
+#endif
+
 void
 output_peer_info_env(struct =
env_set *es, const char *peer_info)
 {
diff --git a/src/openvpn/mss=2Ec b/s=
rc/openvpn/mss=2Ec
index 0cfa272d=2E=2E5bc94d9 100644
--- a/src/openvpn/mss=
=2Ec
+++ b/src/openvpn/mss=2Ec
@@ -194,6 +194,11 @@
     }
 }
 
+#if define=
d(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC=
 diagnostic ignored "-Wsign-conversion"
+#endif
+
 static inline size_t
 ad=
just_payload_max_cbc(const struct key_type *kt, size_t target)
 {
@@ -313,6=
 +318,10 @@
     frame->mss_fix =3D (uint16_t)(adjust_payload_max_cbc(kt, t=
arget) - payload_overhead);
 }
 
+#if defined(__GNUC__) || defined(__clang_=
_)
+#pragma GCC diagnostic pop
+#endif
+
 void
 frame_calculate_dynamic(str=
uct frame *frame, const struct key_type *kt, const struct options *options,=

                         const struct link_socket_info *lsi)
diff --git a/=
src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec
index 2d0af06=2E=2Efc5b657 1006=
44
--- a/src/openvpn/mtcp=2Ec
+++ b/src/openvpn/mtcp=2Ec
@@ -37,6 +37,11 @@=

 #include <sys/inotify=2Eh>
 #endif
 
+#if defined(__GNUC__) || defined(__=
clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsi=
gn-conversion"
+#endif
+
 struct multi_instance *
 multi_create_instance_tc=
p(struct multi_context *m, struct link_socket *sock)
 {
@@ -88,6 +93,10 @@
=
     return true;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragm=
a GCC diagnostic pop
+#endif
+
 void
 multi_tcp_instance_specific_free(stru=
ct multi_instance *mi)
 {
diff --git a/src/openvpn/mtu=2Ec b/src/openvpn/mt=
u=2Ec
index 5ce40c8=2E=2E7892935 100644
--- a/src/openvpn/mtu=2Ec
+++ b/src=
/openvpn/mtu=2Ec
@@ -37,6 +37,11 @@
 #include "memdbg=2Eh"
 #include "ssl_c=
ommon=2Eh"
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diag=
nostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 =
/* allocate a buffer for socket or tun layer */
 void
 alloc_buf_sock_tun(s=
truct buffer *buf, const struct frame *frame)
@@ -383,6 +388,10 @@
     ret=
urn BSTR(&out);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma =
GCC diagnostic pop
+#endif
+
 void
 set_sock_extended_error_passing(int sd,=
 sa_family_t proto_af)
 {
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/=
multi=2Ec
index bcaa012=2E=2E0890480 100644
--- a/src/openvpn/multi=2Ec
+++=
 b/src/openvpn/multi=2Ec
@@ -247,6 +247,11 @@
 
 #endif
 
+#if defined(__GN=
UC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagn=
ostic ignored "-Wsign-conversion"
+#endif
+
 #ifdef ENABLE_ASYNC_PUSH
 stat=
ic uint64_t
 /*
@@ -4555,3 +4560,7 @@
     return (!ipv6_net_contains_host(=
&ifconfig_local, o->ifconfig_ipv6_netbits,
                                =
     dest));
 }
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC=
 diagnostic pop
+#endif
diff --git a/src/openvpn/multi_io=2Ec b/src/openvpn=
/multi_io=2Ec
index fb4810b=2E=2Ee07b691 100644
--- a/src/openvpn/multi_io=
=2Ec
+++ b/src/openvpn/multi_io=2Ec
@@ -104,6 +104,11 @@
     }
 }
 
+#if d=
efined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragm=
a GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 struct multi_io *
 =
multi_io_init(const int maxclients)
 {
@@ -121,6 +126,10 @@
     return mul=
ti_io;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagn=
ostic pop
+#endif
+
 void
 multi_io_free(struct multi_io *multi_io)
 {
diff=
 --git a/src/openvpn/networking_sitnl=2Ec b/src/openvpn/networking_sitnl=2E=
c
index eafb9f7=2E=2Ed5ec6bb 100644
--- a/src/openvpn/networking_sitnl=2Ec
=
+++ b/src/openvpn/networking_sitnl=2Ec
@@ -243,6 +243,11 @@
     return 0;
=
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic p=
ush
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /**
  * =
Send Netlink message and run callback on reply (if specified)
  */
@@ -1510=
,6 +1515,10 @@
     return sitnl_send(&req=2En, 0, 0, NULL, NULL);
 }
 
+#i=
f defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#end=
if
+
 #endif /* !ENABLE_SITNL */
 
 #endif /* TARGET_LINUX */
diff --git a/=
src/openvpn/occ=2Ec b/src/openvpn/occ=2Ec
index f25ae19=2E=2E38685f5 100644=

--- a/src/openvpn/occ=2Ec
+++ b/src/openvpn/occ=2Ec
@@ -177,6 +177,7 @@
 #=
if defined(__GNUC__) || defined(__clang__)
 #pragma GCC diagnostic push
 #p=
ragma GCC diagnostic ignored "-Wconversion"
+#pragma GCC diagnostic ignored=
 "-Wsign-conversion"
 #endif
 
 void
@@ -352,10 +353,6 @@
     c->c2=2Eocc_=
op =3D -1;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC d=
iagnostic pop
-#endif
-
 void
 process_received_occ_msg(struct context *c)
=
 {
@@ -426,3 +423,7 @@
     }
     c->c2=2Ebuf=2Elen =3D 0; /* don't pass p=
acket on */
 }
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC =
diagnostic pop
+#endif
diff --git a/src/openvpn/openvpn=2Ec b/src/openvpn/o=
penvpn=2Ec
index b32f009=2E=2E9f0f50c 100644
--- a/src/openvpn/openvpn=2Ec
=
+++ b/src/openvpn/openvpn=2Ec
@@ -351,6 +351,12 @@
 }
 
 #ifdef _WIN32
+
+#=
if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#p=
ragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 int
 wmain(int =
argc, wchar_t *wargv[])
 {
@@ -394,6 +400,11 @@
 
     return ret;
 }
+
+#i=
f defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#end=
if
+
 #else  /* ifdef _WIN32 */
 int
 main(int argc, char *argv[])
diff --g=
it a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 9ed3964=2E=2E1=
d8bb2a 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@=
@ -945,6 +945,11 @@
     setenv_str_i(es, "local_port", e->port, i);
 }
 
+=
#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#=
pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 void
 setenv_s=
ettings(struct env_set *es, const struct options *o)
 {
@@ -7872,6 +7877,7 =
@@
 
 #if defined(__GNUC__) || defined(__clang__)
 #pragma GCC diagnostic p=
op
+#pragma GCC diagnostic pop
 #endif
 
 bool
diff --git a/src/openvpn/opt=
ions_parse=2Ec b/src/openvpn/options_parse=2Ec
index 5d6f93e=2E=2E0a5eae5 1=
00644
--- a/src/openvpn/options_parse=2Ec
+++ b/src/openvpn/options_parse=
=2Ec
@@ -234,6 +234,11 @@
     } u;
 };
 
+#if defined(__GNUC__) || defined=
(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-=
Wsign-conversion"
+#endif
+
 static bool
 in_src_get(const struct in_src *i=
s, char *line, const int size)
 {
@@ -298,6 +303,10 @@
     return ret;
 }
=
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
=
+#endif
+
 static int
 check_inline_file(const struct in_src *is, char *p[]=
, struct gc_arena *gc)
 {
diff --git a/src/openvpn/options_show=2Ec b/src/o=
penvpn/options_show=2Ec
index 54f9c4c=2E=2Eaf9321d 100644
--- a/src/openvpn=
/options_show=2Ec
+++ b/src/openvpn/options_show=2Ec
@@ -341,6 +341,11 @@
 =
    }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagno=
stic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 vo=
id
 show_settings(const struct options *o)
 {
@@ -628,4 +633,8 @@
 #endif
 =
}
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic po=
p
+#endif
+
 #endif /* ifndef ENABLE_SMALL */
diff --git a/src/openvpn/opti=
ons_string=2Ec b/src/openvpn/options_string=2Ec
index 4a43fce4=2E=2E4fe34bf=
 100644
--- a/src/openvpn/options_string=2Ec
+++ b/src/openvpn/options_stri=
ng=2Ec
@@ -380,6 +380,7 @@
 #if defined(__GNUC__) || defined(__clang__)
 #p=
ragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wsign-compare"
=
+#pragma GCC diagnostic ignored "-Wsign-conversion"
 #endif
 
 char *
diff =
--git a/src/openvpn/options_util=2Ec b/src/openvpn/options_util=2Ec
index d=
25d85c=2E=2E23fdac7 100644
--- a/src/openvpn/options_util=2Ec
+++ b/src/ope=
nvpn/options_util=2Ec
@@ -211,6 +211,11 @@
                                =
            "route-metric", "topology",
                                   =
         "tun-mtu", "keepalive" };
 
+#if defined(__GNUC__) || defined(__cl=
ang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign=
-conversion"
+#endif
+
 bool
 check_push_update_option_flags(char *line, in=
t *i, uint64_t *flags)
 {
@@ -273,6 +278,10 @@
     return true;
 }
 
+#if =
defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif=

+
 bool
 apply_pull_filter(const struct options *o, char *line)
 {
diff --=
git a/src/openvpn/packet_id=2Ec b/src/openvpn/packet_id=2Ec
index f1fadd6=
=2E=2E48e37db 100644
--- a/src/openvpn/packet_id=2Ec
+++ b/src/openvpn/pack=
et_id=2Ec
@@ -71,6 +71,11 @@
 #endif
 }
 
+#if defined(__GNUC__) || defined=
(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-=
Wsign-conversion"
+#endif
+
 static void
 packet_id_init_recv(struct packet=
_id_rec *rec, int seq_backtrack, int time_backtrack,
                     c=
onst char *name, int unit)
@@ -175,6 +180,10 @@
     }
 }
 
+#if defined(__=
GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /*
  *=
 Expire sequence numbers which can no longer
  * be accepted because they w=
ould violate
diff --git a/src/openvpn/ping=2Ec b/src/openvpn/ping=2Ec
index=
 526e64c=2E=2Ebbacd20 100644
--- a/src/openvpn/ping=2Ec
+++ b/src/openvpn/p=
ing=2Ec
@@ -64,6 +64,11 @@
     gc_free(&gc);
 }
 
+#if defined(__GNUC__) |=
| defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic i=
gnored "-Wsign-conversion"
+#endif
+
 /*
  * Should we ping the remote?
  *=
/
@@ -84,3 +89,7 @@
     c->c2=2Ebuf=2Elen =3D 0;
     dmsg(D_PING, "SENT P=
ING");
 }
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagn=
ostic pop
+#endif
diff --git a/src/openvpn/pkcs11=2Ec b/src/openvpn/pkcs11=
=2Ec
index f00ba9b=2E=2Eb4bed12 100644
--- a/src/openvpn/pkcs11=2Ec
+++ b/s=
rc/openvpn/pkcs11=2Ec
@@ -54,6 +54,11 @@
 }
 #endif
 
+#if defined(__GNUC__=
) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnosti=
c ignored "-Wsign-conversion"
+#endif
+
 static void
 __mysleep(unsigned lo=
ng usec)
 {
@@ -812,4 +817,9 @@
     pkcs11h_terminate();
     gc_free(&gc)=
;
 }
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic=
 pop
+#endif
+
 #endif /* ENABLE_PKCS11 */
diff --git a/src/openvpn/pkcs11_=
openssl=2Ec b/src/openvpn/pkcs11_openssl=2Ec
index 8abd60a=2E=2Ec5974fce 10=
0644
--- a/src/openvpn/pkcs11_openssl=2Ec
+++ b/src/openvpn/pkcs11_openssl=
=2Ec
@@ -130,6 +130,11 @@
     return ret;
 }
 
+#if defined(__GNUC__) || d=
efined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic igno=
red "-Wsign-conversion"
+#endif
+
 /**
  * Sign op called from xkey provide=
r
  *
@@ -230,6 +235,10 @@
     return 1;
 }
 
+#if defined(__GNUC__) || de=
fined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /* wrapper for hand=
le free */
 static void
 xkey_handle_free(void *handle)
diff --git a/src/op=
envpn/platform=2Ec b/src/openvpn/platform=2Ec
index 9412eeb=2E=2Ee10161f 10=
0644
--- a/src/openvpn/platform=2Ec
+++ b/src/openvpn/platform=2Ec
@@ -76,6=
 +76,11 @@
 
 /* Get/Set UID of process */
 
+#if defined(__GNUC__) || defi=
ned(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored=
 "-Wsign-conversion"
+#endif
+
 bool
 platform_user_get(const char *usernam=
e, struct platform_state_user *state)
 {
@@ -658,6 +663,10 @@
     }
 }
 
+=
#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#e=
ndif
+
 bool
 platform_absolute_pathname(const char *pathname)
 {
diff --gi=
t a/src/openvpn/plugin=2Ec b/src/openvpn/plugin=2Ec
index d1f228e=2E=2E2872=
265 100644
--- a/src/openvpn/plugin=2Ec
+++ b/src/openvpn/plugin=2Ec
@@ -46=
3,6 +463,11 @@
 #define _OPENVPN_PATCH_LEVEL "git:" CONFIGURE_GIT_REVISION =
CONFIGURE_GIT_FLAGS
 #endif
 
+#if defined(__GNUC__) || defined(__clang__)
=
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conver=
sion"
+#endif
+
 static void
 plugin_open_item(struct plugin *p, const stru=
ct plugin_option *o,
                  struct openvpn_plugin_string_list **=
retlist, const char **envp,
@@ -545,6 +550,10 @@
     }
 }
 
+#if defined(_=
_GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 stati=
c int
 plugin_call_item(const struct plugin *p, void *per_client_context, c=
onst int type,
                  const struct argv *av, struct openvpn_plug=
in_string_list **retlist,
diff --git a/src/openvpn/pool=2Ec b/src/openvpn/p=
ool=2Ec
index fff0e3f=2E=2E016f3a8 100644
--- a/src/openvpn/pool=2Ec
+++ b/=
src/openvpn/pool=2Ec
@@ -137,6 +137,11 @@
     return ret;
 }
 
+#if define=
d(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC=
 diagnostic ignored "-Wsign-conversion"
+#endif
+
 struct ifconfig_pool *
 =
ifconfig_pool_init(const bool ipv4_pool, enum pool_type type, in_addr_t sta=
rt, in_addr_t end,
                    const bool duplicate_cn, const bool =
ipv6_pool, const struct in6_addr ipv6_base,
@@ -708,6 +713,10 @@
     }
 }
=
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
=
+#endif
+
 void
 ifconfig_pool_write(struct ifconfig_pool_persist *persist,=
 const struct ifconfig_pool *pool)
 {
diff --git a/src/openvpn/proxy=2Ec b/=
src/openvpn/proxy=2Ec
index 7b5a289=2E=2Ecd9f3b2 100644
--- a/src/openvpn/p=
roxy=2Ec
+++ b/src/openvpn/proxy=2Ec
@@ -53,6 +53,11 @@
 }
 
 
+#if defined=
(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC =
diagnostic ignored "-Wsign-conversion"
+#endif
+
 /* cached proxy username/=
password */
 static struct user_pass static_proxy_user_pass;
 
@@ -288,6 +2=
93,10 @@
     p->up =3D static_proxy_user_pass; /* this is a copy of protec=
ted memory */
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GC=
C diagnostic pop
+#endif
+
 #if 0
 /* function only used in #if 0 debug sta=
tement */
 static void
diff --git a/src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec=

index f8cfe1c5=2E=2E86b4fc9 100644
--- a/src/openvpn/ps=2Ec
+++ b/src/open=
vpn/ps=2Ec
@@ -165,6 +165,11 @@
     return CMSG_SPACE(sizeof(socket_descri=
ptor_t));
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC di=
agnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+=

 /*
  * Send a command (char), data (head), and a file descriptor (sd_send=
) to a local process
  * over unix socket sd=2E  Unfortunately, there's no =
portable way to send file descriptors
@@ -618,6 +623,10 @@
     return IOST=
AT_GOOD;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC dia=
gnostic pop
+#endif
+
 /*
  * Forward data from pc to pc->counterpart=2E
  =
*/
diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec
index a18f33b=
=2E=2E6f628b8 100644
--- a/src/openvpn/push=2Ec
+++ b/src/openvpn/push=2Ec
=
@@ -389,6 +389,11 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang_=
_)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-con=
version"
+#endif
+
 void
 receive_auth_pending(struct context *c, const str=
uct buffer *buffer)
 {
@@ -795,6 +800,10 @@
     }
 }
 
+#if defined(__GNUC=
__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static boo=
l
 send_push_options(struct context *c, struct buffer *buf, struct push_lis=
t *push_list, int safe_cap,
                   bool *push_sent, bool *multi=
_push)
diff --git a/src/openvpn/reliable=2Ec b/src/openvpn/reliable=2Ec
ind=
ex 7b5b17c=2E=2Eb045b1f 100644
--- a/src/openvpn/reliable=2Ec
+++ b/src/ope=
nvpn/reliable=2Ec
@@ -311,6 +311,11 @@
  * struct reliable member functions=
=2E
  */
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagno=
stic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 vo=
id
 reliable_init(struct reliable *rel, int buf_size, int offset, int array=
_size, bool hold)
 {
@@ -780,6 +785,10 @@
     ASSERT(0); /* buf not found =
in rel */
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC di=
agnostic pop
+#endif
+
 /*
  * Enable an outgoing buffer previously returne=
d by a get function as active=2E
  */
diff --git a/src/openvpn/route=2Ec b/=
src/openvpn/route=2Ec
index 449b4f1=2E=2Efa569fa 100644
--- a/src/openvpn/r=
oute=2Ec
+++ b/src/openvpn/route=2Ec
@@ -582,6 +582,11 @@
     }
 }
 
+#if =
defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#prag=
ma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 bool
 block_local_=
needed(const struct route_list *rl)
 {
@@ -3217,6 +3222,10 @@
     }
 }
 
+=
#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#e=
ndif
+
 /* IPv6 implementation using netlink
  * https://www=2Elinuxjournal=
=2Ecom/article/7356 - "Kernel Korner - Why and How to Use Netlink Socket"
 =
 * netlink(3), netlink(7), rtnetlink(7)
diff --git a/src/openvpn/socket=2Ec=
 b/src/openvpn/socket=2Ec
index 1fbd07b=2E=2Ec07ef60 100644
--- a/src/openv=
pn/socket=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -422,6 +422,11 @@
     gc_fre=
e(&gc);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diag=
nostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 =
socket_descriptor_t
 socket_do_accept(socket_descriptor_t sd, struct link_s=
ocket_actual *act, const bool nowait)
 {
@@ -2084,6 +2089,10 @@
     return=
 buf->len;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC d=
iagnostic pop
+#endif
+
 #endif /* ifndef _WIN32 */
 
 /*
diff --git a/src/=
openvpn/socket=2Eh b/src/openvpn/socket=2Eh
index 52e09c9=2E=2E2210bfe 1006=
44
--- a/src/openvpn/socket=2Eh
+++ b/src/openvpn/socket=2Eh
@@ -288,12 +28=
8,21 @@
     return sh=2Eis_handle ? (int)GetLastError() : WSAGetLastError(=
);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnosti=
c push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 inlin=
e static void
 SocketHandleSetLastError(sockethandle_t sh, DWORD err)
 {
  =
   sh=2Eis_handle ? SetLastError(err) : WSASetLastError(err);
 }
 
+#if def=
ined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
=
 static inline void
 SocketHandleSetInvalError(sockethandle_t sh)
 {
@@ -45=
9,6 +468,11 @@
 
 #endif /* if PORT_SHARE */
 
+#if defined(__GNUC__) || de=
fined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignor=
ed "-Wsign-conversion"
+#endif
+
 static inline bool
 socket_connection_res=
et(const struct link_socket *sock, ssize_t status)
 {
@@ -482,6 +496,10 @@
=
     return false;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#prag=
ma GCC diagnostic pop
+#endif
+
 static inline bool
 link_socket_verify_inc=
oming_addr(const struct buffer *buf, const struct link_socket_info *info,
 =
                                 const struct link_socket_actual *from_addr=
)
@@ -649,6 +667,11 @@
 ssize_t link_socket_write_tcp(struct link_socket *s=
ock, struct buffer *buf,
                               struct link_socket_=
actual *to);
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC di=
agnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+=

 #ifdef _WIN32
 
 static inline int
@@ -721,6 +744,10 @@
 
 #endif /* ifde=
f _WIN32 */
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC dia=
gnostic pop
+#endif
+
 static inline ssize_t
 link_socket_write_udp(struct =
link_socket *sock, struct buffer *buf, struct link_socket_actual *to)
 {
di=
ff --git a/src/openvpn/socket_util=2Ec b/src/openvpn/socket_util=2Ec
index =
879be73=2E=2Ea049f33 100644
--- a/src/openvpn/socket_util=2Ec
+++ b/src/ope=
nvpn/socket_util=2Ec
@@ -123,6 +123,11 @@
 #define IF_NAMESIZE 16
 #endif
 =

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
=
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 const char *=

 print_link_socket_actual_ex(const struct link_socket_actual *act, const c=
har *separator,
                             const unsigned int flags, stru=
ct gc_arena *gc)
@@ -188,6 +193,10 @@
     }
 }
 
+#if defined(__GNUC__) ||=
 defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /*
  * Convert a=
n in_addr_t in host byte order
  * to an ascii dotted quad=2E
diff --git a/=
src/openvpn/socks=2Ec b/src/openvpn/socks=2Ec
index a8c9fd3=2E=2E51e3a1e 10=
0644
--- a/src/openvpn/socks=2Ec
+++ b/src/openvpn/socks=2Ec
@@ -226,6 +226=
,11 @@
     return true;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
=
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conver=
sion"
+#endif
+
 static bool
 recv_socks_reply(socket_descriptor_t sd, stru=
ct openvpn_sockaddr *addr,
                  const struct event_timeout *se=
rver_poll_timeout, volatile int *signal_received)
@@ -310,6 +315,10 @@
    =
 return true;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GC=
C diagnostic pop
+#endif
+
 static int
 port_from_servname(const char *serv=
name)
 {
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 7721b=
55=2E=2E00e1712 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
=
@@ -152,6 +152,11 @@
     return limit;
 }
 
+#if defined(__GNUC__) || defi=
ned(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored=
 "-Wsign-conversion"
+#endif
+
 void
 tls_init_control_channel_frame_parame=
ters(struct frame *frame, int tls_mtu)
 {
@@ -236,6 +241,10 @@
     return =
overhead;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC di=
agnostic pop
+#endif
+
 void
 init_ssl_lib(void)
 {
@@ -797,6 +806,11 @@
  =
   return false;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma=
 GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#=
endif
+
 /** @addtogroup control_processor
  *  @{ */
 
@@ -1043,6 +1057,10=
 @@
     gc_free(&gc);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#=
pragma GCC diagnostic pop
+#endif
+
 /**
  * Clean up a \c tls_session stru=
cture=2E
  * @ingroup control_processor
@@ -1325,6 +1343,11 @@
     key_sou=
rce_print(&k->server, "Server");
 }
 
+#if defined(__GNUC__) || defined(__c=
lang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsig=
n-conversion"
+#endif
+
 static bool
 openvpn_PRF(const uint8_t *secret, si=
ze_t secret_len, const char *label, const uint8_t *client_seed,
           =
  size_t client_seed_len, const uint8_t *server_seed, size_t server_seed_le=
n,
@@ -4550,3 +4573,7 @@
 done:
     return BSTR(&out);
 }
+
+#if defined(_=
_GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
diff --g=
it a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec
index 45d771=
5=2E=2Ecbc3118 100644
--- a/src/openvpn/ssl_mbedtls=2Ec
+++ b/src/openvpn/s=
sl_mbedtls=2Ec
@@ -199,6 +199,11 @@
         ciphers);
 }
 
+#if defined(__=
GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC dia=
gnostic ignored "-Wsign-conversion"
+#endif
+
 void
 tls_ctx_restrict_ciphe=
rs(struct tls_root_ctx *ctx, const char *ciphers)
 {
@@ -1187,6 +1192,10 @@=

     return 1;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma =
GCC diagnostic pop
+#endif
+
 /* **************************************
  *=

  * Information functions
diff --git a/src/openvpn/ssl_ncp=2Ec b/src/openv=
pn/ssl_ncp=2Ec
index f13f507=2E=2Edf9e42c 100644
--- a/src/openvpn/ssl_ncp=
=2Ec
+++ b/src/openvpn/ssl_ncp=2Ec
@@ -393,6 +393,11 @@
     return ret;
 }=

 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pus=
h
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static voi=
d
 p2p_ncp_set_options(struct tls_multi *multi, struct tls_session *session=
, const char *common_cipher)
 {
@@ -576,6 +581,10 @@
     o->ncp_ciphers =
=3D (char *)ncp_ciphers;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
=
+#pragma GCC diagnostic pop
+#endif
+
 /**
  * Checks for availibility of C=
hacha20-Poly1305 and sets
  * the ncp_cipher to either AES-256-GCM:AES-128-=
GCM or
diff --git a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=
=2Ec
index fe2bfda=2E=2E035cfb8 100644
--- a/src/openvpn/ssl_openssl=2Ec
++=
+ b/src/openvpn/ssl_openssl=2Ec
@@ -277,7 +277,14 @@
     sslopt |=3D SSL_O=
P_NO_RENEGOTIATION;
 #endif
 
+#if defined(LIBRESSL_VERSION_NUMBER) && (def=
ined(__GNUC__) || defined(__clang__))
+#pragma GCC diagnostic push
+#pragma=
 GCC diagnostic ignored "-Wsign-conversion"
+#endif
     SSL_CTX_set_option=
s(ctx->ctx, sslopt);
+#if defined(LIBRESSL_VERSION_NUMBER) && (defined(__GN=
UC__) || defined(__clang__))
+#pragma GCC diagnostic pop
+#endif
 
     if =
(!tls_ctx_set_tls_versions(ctx, ssl_flags))
     {
@@ -511,6 +518,11 @@
 {
=
     ASSERT(ctx);
 #if OPENSSL_VERSION_NUMBER < 0x30000000L && !defined(ENA=
BLE_CRYPTO_WOLFSSL)
+#if defined(__GNUC__) || defined(__clang__)
+#pragma G=
CC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#en=
dif
+
     struct gc_arena gc =3D gc_new();
     /* This method could be as=
 easy as
      *  SSL_CTX_set1_groups_list(ctx->ctx, groups)
@@ -556,6 +568=
,10 @@
         crypto_msg(M_FATAL, "Failed to set allowed TLS group list: =
%s", groups);
     }
     gc_free(&gc);
+
+#if defined(__GNUC__) || defined=
(__clang__)
+#pragma GCC diagnostic pop
+#endif
 #else  /* if OPENSSL_VERSI=
ON_NUMBER < 0x30000000L */
     if (!SSL_CTX_set1_groups_list(ctx->ctx, gro=
ups))
     {
@@ -1466,6 +1482,11 @@
     }
 }
 
+#if defined(__GNUC__) || d=
efined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic igno=
red "-Wsign-conversion"
+#endif
+
 /**
  * Pass the input hash in 'dgst' to=
 management and get the signature back=2E
  *
@@ -1710,6 +1731,11 @@
     r=
eturn 0;
 }
 #endif /* !defined(OPENSSL_NO_EC) */
+
+#if defined(__GNUC__) =
|| defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #endif /* ENAB=
LE_MANAGEMENT && !HAVE_XKEY_PROVIDER */
 
 #ifdef ENABLE_MANAGEMENT
@@ -209=
9,6 +2125,11 @@
  * to BIOs=2E
  */
 
+#if defined(__GNUC__) || defined(__c=
lang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsig=
n-conversion"
+#endif
+
 static void
 bio_write_post(const int status, stru=
ct buffer *buf)
 {
@@ -2110,6 +2141,10 @@
     }
 }
 
+#if defined(__GNUC__=
) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /*
  * Read =
from an OpenSSL BIO in non-blocking mode=2E
  */
diff --git a/src/openvpn/s=
sl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec
index f78782f=2E=2E60573ee 100644
--- =
a/src/openvpn/ssl_pkt=2Ec
+++ b/src/openvpn/ssl_pkt=2Ec
@@ -40,6 +40,11 @@
=
  */
 #define SWAP_BUF_SIZE 256
 
+#if defined(__GNUC__) || defined(__clang=
__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-co=
nversion"
+#endif
+
 /**
  * Move a packet authentication HMAC + related fi=
elds to or from the front
  * of the buffer so it can be processed by encry=
pt/decrypt=2E
@@ -591,3 +596,7 @@
     buf_advance(buf, cmdlen);
     retur=
n cmdbuf;
 }
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC di=
agnostic pop
+#endif
diff --git a/src/openvpn/ssl_util=2Ec b/src/openvpn/ss=
l_util=2Ec
index ba185c1=2E=2E337faed 100644
--- a/src/openvpn/ssl_util=2Ec=

+++ b/src/openvpn/ssl_util=2Ec
@@ -86,6 +86,10 @@
     return var_value;
 =
}
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pu=
sh
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
 
 unsigned =
int
 peer_info_extract_int(const char *peer_info, const char *field, const =
char *format, unsigned int default_value)
@@ -166,6 +170,10 @@
     return =
BSTR(&buf);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC =
diagnostic pop
+#endif
+
 /**
  * SSL/TLS Cipher suite name translation tab=
le
  */
diff --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2E=
c
index a5b57a5=2E=2E1c3c6bf 100644
--- a/src/openvpn/ssl_verify=2Ec
+++ b/=
src/openvpn/ssl_verify=2Ec
@@ -400,6 +400,11 @@
     return SUCCESS;
 }
 
+=
#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#=
pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /*
  * Export =
the subject, common_name, and raw certificate fields to the
  * environment=
 for later verification by scripts and plugins=2E
@@ -810,6 +815,10 @@
    =
 return ret;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC=
 diagnostic pop
+#endif
+
 /* *********************************************=
******************************
  * Functions for the management of deferred=
 authentication when using
  * user/password authentication=2E
@@ -891,6 +9=
00,11 @@
     return supported;
 }
 
+#if defined(__GNUC__) || defined(__cl=
ang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign=
-conversion"
+#endif
+
 /**
  *  Checks if the deferred state should also s=
end auth pending
  *  request to the client=2E Also removes the auth_pendin=
g control file
@@ -965,6 +979,10 @@
     return ret;
 }
 
+#if defined(__GN=
UC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /**
  * =
 Removes auth_pending and auth_control files from file system
  *  and key_=
state structure
diff --git a/src/openvpn/ssl_verify_mbedtls=2Ec b/src/openv=
pn/ssl_verify_mbedtls=2Ec
index a132f12=2E=2Ebba2f2f 100644
--- a/src/openv=
pn/ssl_verify_mbedtls=2Ec
+++ b/src/openvpn/ssl_verify_mbedtls=2Ec
@@ -222,=
6 +222,11 @@
     return true;
 }
 
+#if defined(__GNUC__) || defined(__cla=
ng__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-=
conversion"
+#endif
+
 result_t
 backend_x509_get_username(char *cn, size_t=
 cn_len, char *x509_username_field, mbedtls_x509_crt *cert)
 {
@@ -786,6 +7=
91,10 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma =
GCC diagnostic pop
+#endif
+
 /* Dummy function because Netscape certificat=
e types are not supported in OpenVPN with mbedtls=2E
  * Returns SUCCESS if=
 usage is NS_CERT_CHECK_NONE, FAILURE otherwise=2E */
 result_t
diff --git =
a/src/openvpn/ssl_verify_openssl=2Ec b/src/openvpn/ssl_verify_openssl=2Ec
i=
ndex 0c36cf2=2E=2E19339ad 100644
--- a/src/openvpn/ssl_verify_openssl=2Ec
+=
++ b/src/openvpn/ssl_verify_openssl=2Ec
@@ -317,6 +317,11 @@
     return se=
rial;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagno=
stic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 ch=
ar *
 backend_x509_get_serial_hex(openvpn_x509_cert_t *cert, struct gc_aren=
a *gc)
 {
@@ -573,6 +578,10 @@
     gc_free(&gc);
 }
 
+#if defined(__GNUC_=
_) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /*
  * Save=
 X509 fields to environment, using the naming convention:
  *
diff --git a/=
src/openvpn/status=2Ec b/src/openvpn/status=2Ec
index 1036536=2E=2E533619f =
100644
--- a/src/openvpn/status=2Ec
+++ b/src/openvpn/status=2Ec
@@ -55,6 +=
55,11 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma =
GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#e=
ndif
+
 struct status_output *
 status_open(const char *filename, const int=
 refresh_freq, const int msglevel,
             const struct virtual_output=
 *vout, const unsigned int flags)
@@ -119,6 +124,10 @@
     return so;
 }
 =

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+=
#endif
+
 bool
 status_trigger(struct status_output *so)
 {
@@ -206,6 +215,=
11 @@
     return ret;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#=
pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversi=
on"
+#endif
+
 #define STATUS_PRINTF_MAXLEN 512
 
 void
@@ -297,3 +311,7 @@=

 
     return ret;
 }
+
+#if defined(__GNUC__) || defined(__clang__)
+#pra=
gma GCC diagnostic pop
+#endif
diff --git a/src/openvpn/tls_crypt=2Ec b/src=
/openvpn/tls_crypt=2Ec
index 3d27e40=2E=2Ee59f55b 100644
--- a/src/openvpn/=
tls_crypt=2Ec
+++ b/src/openvpn/tls_crypt=2Ec
@@ -93,6 +93,11 @@
     }
 }
=
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push=

+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 bool
 tls_s=
ession_generate_dynamic_tls_crypt_key(struct tls_session *session)
 {
@@ -5=
17,6 +522,10 @@
     return ret;
 }
 
+#if defined(__GNUC__) || defined(__c=
lang__)
+#pragma GCC diagnostic pop
+#endif
+
 static bool
 tls_crypt_v2_ch=
eck_client_key_age(const struct buffer *tls_crypt_v2_metadata, int max_days=
)
 {
@@ -697,6 +706,11 @@
     write_pem_key_file(filename, tls_crypt_v2_sr=
v_pem_name);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC=
 diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endi=
f
+
 void
 tls_crypt_v2_write_client_key_file(const char *filename, const c=
har *b64_metadata,
                                    const char *server_k=
ey_file, bool server_key_inline)
@@ -800,3 +814,7 @@
 
     gc_free(&gc);
 =
}
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic po=
p
+#endif
diff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec
index a1f9=
886=2E=2E1ae19eb 100644
--- a/src/openvpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec=

@@ -112,6 +112,11 @@
 
 static const char *netsh_get_id(const char *dev_no=
de, struct gc_arena *gc);
 
+#if defined(__GNUC__) || defined(__clang__)
+#=
pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversi=
on"
+#endif
+
 static bool
 do_address_service(const bool add, const short =
family, const struct tuntap *tt)
 {
@@ -479,6 +484,10 @@
     return ret;
 =
}
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic po=
p
+#endif
+
 #endif /* ifdef _WIN32 */
 
 #ifdef TARGET_SOLARIS
@@ -815,6 +=
824,11 @@
     gc_free(&gc);
 }
 
+#if defined(__GNUC__) || defined(__clang=
__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-co=
nversion"
+#endif
+
 /*
  * Init tun/tap object=2E
  *
@@ -1556,6 +1570,10 =
@@
 #endif
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC d=
iagnostic pop
+#endif
+
 /* execute the ifconfig command through the shell =
*/
 void
 do_ifconfig(struct tuntap *tt, const char *ifname, int tun_mtu, c=
onst struct env_set *es,
@@ -1701,6 +1719,11 @@
 #include <netinet/ip=2Eh>
=
 #include <sys/uio=2Eh>
 
+#if defined(__GNUC__) || defined(__clang__)
+#pr=
agma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion=
"
+#endif
+
 static inline ssize_t
 header_modify_read_write_return(ssize_t=
 len)
 {
@@ -1786,6 +1809,10 @@
 }
 #endif
 
+#if defined(__GNUC__) || defi=
ned(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #endif /* if defined(=
TARGET_FREEBSD) || defined(TARGET_DRAGONFLY) || defined(TARGET_NETBSD) || d=
efined (TARGET_OPENBSD) || defined(TARGET_DARWIN) */
 
 bool
@@ -2043,6 +20=
70,11 @@
     free(tt);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+=
#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-convers=
ion"
+#endif
+
 ssize_t
 write_tun(const struct tuntap *tt, const uint8_t *=
buf, int len)
 {
@@ -2055,6 +2087,10 @@
     return read(tt->fd, buf, len);=

 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic =
pop
+#endif
+
 #elif defined(TARGET_LINUX)
 
 #if !PEDANTIC
@@ -2252,6 +228=
8,11 @@
     free(tt);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#=
pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversi=
on"
+#endif
+
 ssize_t
 write_tun(const struct tuntap *tt, const uint8_t *b=
uf, int len)
 {
@@ -2264,6 +2305,10 @@
     return read(tt->fd, buf, len);
=
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic p=
op
+#endif
+
 #elif defined(TARGET_SOLARIS)
 
 #ifndef TUNNEWPPA
@@ -2881,6=
 +2926,11 @@
 
 #elif defined(TARGET_DARWIN)
 
+#if defined(__GNUC__) || de=
fined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignor=
ed "-Wsign-conversion"
+#endif
+
 /* Darwin (MacOS X) is mostly "just use t=
he generic stuff", but there
  * is always one caveat=2E=2E=2E:
  *
@@ -294=
6,6 +2996,10 @@
     return fd;
 }
 
+#if defined(__GNUC__) || defined(__cl=
ang__)
+#pragma GCC diagnostic pop
+#endif
+
 void
 open_darwin_utun(const =
char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
 =
{
@@ -3095,6 +3149,11 @@
     gc_free(&gc);
 }
 
+#if defined(__GNUC__) || =
defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ign=
ored "-Wsign-conversion"
+#endif
+
 ssize_t
 write_tun(const struct tuntap =
*tt, const uint8_t *buf, int len)
 {
@@ -3121,6 +3180,10 @@
     }
 }
 
+#i=
f defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#end=
if
+
 #elif defined(TARGET_AIX)
 
 void
@@ -3257,6 +3320,11 @@
 
 #elif def=
ined(_WIN32)
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC di=
agnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+=

 int
 tun_read_queue(struct tuntap *tt, int maxsize)
 {
@@ -6101,6 +6169,1=
0 @@
     argv_free(&argv);
 }
 
+#if defined(__GNUC__) || defined(__clang_=
_)
+#pragma GCC diagnostic pop
+#endif
+
 void
 close_tun_handle(struct tun=
tap *tt)
 {
@@ -6280,7 +6352,7 @@
     return BSTR(&out);
 }
 
-#else      =
                  /* generic */
+#else  /* generic */
 
 void
 open_tun(con=
st char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt=
,
@@ -6310,4 +6382,4 @@
     return read(tt->fd, buf, len);
 }
 
-#endif   =
                    /* if defined (TARGET_ANDROID) */
+#endif /* if defined=
 (TARGET_ANDROID) */
diff --git a/src/openvpn/tun_afunix=2Ec b/src/openvpn/=
tun_afunix=2Ec
index 79d706a=2E=2E155bf8d 100644
--- a/src/openvpn/tun_afun=
ix=2Ec
+++ b/src/openvpn/tun_afunix=2Ec
@@ -48,6 +48,11 @@
 #include <stdli=
b=2Eh>
 
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagno=
stic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 st=
atic void
 tun_afunix_exec_child(const char *dev_node, struct tuntap *tt, c=
onst struct env_set *env)
 {
@@ -171,6 +176,11 @@
      * with error messag=
es */
     return read(tt->fd, buf, len);
 }
+
+#if defined(__GNUC__) || de=
fined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #else  /* ifndef WI=
N32 */
 
 // cppcheck-suppress-begin constParameterPointer ; stubs
diff --g=
it a/src/openvpn/vlan=2Ec b/src/openvpn/vlan=2Ec
index 04e18d6=2E=2Ed44dac1=
 100644
--- a/src/openvpn/vlan=2Ec
+++ b/src/openvpn/vlan=2Ec
@@ -56,6 +56,=
11 @@
         (hdr->pcp_cfi_vid & ~OPENVPN_8021Q_MASK_VID) | (htons(vid) &=
 OPENVPN_8021Q_MASK_VID);
 }
 
+#if defined(__GNUC__) || defined(__clang__)=

+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conve=
rsion"
+#endif
+
 /*
  * vlan_decapsulate - remove 802=2E1q header and retu=
rn VID
  *
@@ -170,6 +175,10 @@
     return -1;
 }
 
+#if defined(__GNUC__)=
 || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /*
  * vlan_e=
ncapsulate - add 802=2E1q header and set the context related VID
  *
diff -=
-git a/src/openvpn/wfp_block=2Ec b/src/openvpn/wfp_block=2Ec
index 4d38fdb=
=2E=2Eb576899 100644
--- a/src/openvpn/wfp_block=2Ec
+++ b/src/openvpn/wfp_=
block=2Ec
@@ -131,6 +131,11 @@
     return err;
 }
 
+#if defined(__GNUC__)=
 || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic=
 ignored "-Wsign-conversion"
+#endif
+
 /*
  * Block outgoing local traffic=
, possibly DNS only, except for
  * (i) adapter with the specified index (a=
nd loopback, if all is blocked)
@@ -340,6 +345,10 @@
     return err;
 }
 
=
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#=
endif
+
 DWORD
 delete_wfp_block_filters(HANDLE engine_handle)
 {
diff --gi=
t a/src/openvpn/win32-util=2Ec b/src/openvpn/win32-util=2Ec
index e2c8810=
=2E=2E5f99e2b 100644
--- a/src/openvpn/win32-util=2Ec
+++ b/src/openvpn/win=
32-util=2Ec
@@ -36,6 +36,11 @@
 #include "buffer=2Eh"
 #include "win32-util=
=2Eh"
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnosti=
c push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 WCHAR=
 *
 wide_string(const char *utf8, struct gc_arena *gc)
 {
@@ -131,6 +136,10=
 @@
     return utf8;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#p=
ragma GCC diagnostic pop
+#endif
+
 /*
  * Return true if filename is safe =
to be used on Windows,
  * by avoiding the following reserved names:
diff -=
-git a/src/openvpn/win32=2Ec b/src/openvpn/win32=2Ec
index 3af58ed=2E=2E079=
869f 100644
--- a/src/openvpn/win32=2Ec
+++ b/src/openvpn/win32=2Ec
@@ -545=
,6 +545,11 @@
     CLEAR(*ws);
 }
 
+#if defined(__GNUC__) || defined(__cla=
ng__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-=
conversion"
+#endif
+
 void
 win32_signal_open(struct win32_signal *ws, int=
 force, const char *exit_event_name,
                   bool exit_event_ini=
tial_state)
@@ -1661,4 +1666,8 @@
     return ret;
 }
 
+#if defined(__GNUC=
__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #endif /* =
ifdef _WIN32 */
diff --git a/src/openvpn/xkey_helper=2Ec b/src/openvpn/xkey=
_helper=2Ec
index 6908cbb=2E=2Ef4be796 100644
--- a/src/openvpn/xkey_helper=
=2Ec
+++ b/src/openvpn/xkey_helper=2Ec
@@ -146,6 +146,11 @@
 }
 
 #ifdef EN=
ABLE_MANAGEMENT
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC=
 diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endi=
f
 /**
  * Signature callback for xkey_provider with management-external-ke=
y
  *
@@ -276,6 +281,10 @@
 
     return (*siglen > 0);
 }
+#if defined(__G=
NUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #endif =
/* ENABLE MANAGEMENT */
 
 /**
diff --git a/src/openvpn/xkey_provider=2Ec b=
/src/openvpn/xkey_provider=2Ec
index a349d4d=2E=2E9211c11 100644
--- a/src/=
openvpn/xkey_provider=2Ec
+++ b/src/openvpn/xkey_provider=2Ec
@@ -940,6 +94=
0,11 @@
     return ret;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
=
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conver=
sion"
+#endif
+
 static int
 signature_sign(void *ctx, unsigned char *sig, =
size_t *siglen, size_t sigsize,
                const unsigned char *tbs, s=
ize_t tbslen)
@@ -1074,6 +1079,10 @@
     return signature_sign(ctx, sig, s=
iglen, sigsize, buf, sz);
 }
 
+#if defined(__GNUC__) || defined(__clang__)=

+#pragma GCC diagnostic pop
+#endif
+
 /* Sign digest using native sign fu=
nction -- will only work for native keys
  */
 int
diff --git a/src/openvpn=
msica/dllmain=2Ec b/src/openvpnmsica/dllmain=2Ec
index 85ebda9=2E=2E777c823=
 100644
--- a/src/openvpnmsica/dllmain=2Ec
+++ b/src/openvpnmsica/dllmain=
=2Ec
@@ -98,6 +98,11 @@
     return true;
 }
 
+#if defined(__GNUC__) || de=
fined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignor=
ed "-Wsign-conversion"
+#endif
+
 void
 x_msg_va(const unsigned int flags, =
const char *format, va_list arglist)
 {
@@ -189,3 +194,7 @@
               =
        hRecordProg);
     MsiCloseHandle(hRecordProg);
 }
+
+#if defined(_=
_GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
diff --g=
it a/src/openvpnserv/common=2Ec b/src/openvpnserv/common=2Ec
index 671ddde=
=2E=2Ee20feb7 100644
--- a/src/openvpnserv/common=2Ec
+++ b/src/openvpnserv=
/common=2Ec
@@ -30,6 +30,11 @@
 LPCWSTR service_instance =3D L"";
 static w=
char_t win_sys_path[MAX_PATH];
 
+#if defined(__GNUC__) || defined(__clang_=
_)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-con=
version"
+#endif
+
 static DWORD
 GetRegString(HKEY key, LPCWSTR value, LPW=
STR data, DWORD size, LPCWSTR default_value)
 {
@@ -309,6 +314,10 @@
     r=
eturn utf16;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC=
 diagnostic pop
+#endif
+
 const wchar_t *
 get_win_sys_path(void)
 {
diff =
--git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec
i=
ndex da86e85=2E=2E57f0243 100644
--- a/src/openvpnserv/interactive=2Ec
+++ =
b/src/openvpnserv/interactive=2Ec
@@ -524,6 +524,10 @@
     free(sud->direc=
tory);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagn=
ostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
 
 s=
tatic SOCKADDR_INET
 sockaddr_inet(short family, const inet_address_t *addr=
)
@@ -3970,6 +3974,9 @@
     return 0;
 }
 
+#if defined(__GNUC__) || defin=
ed(__clang__)
+#pragma GCC diagnostic pop
+#endif
 
 static DWORD WINAPI
 S=
erviceCtrlInteractive(DWORD ctrl_code, DWORD event, LPVOID data, LPVOID ctx=
)
diff --git a/src/plugins/auth-pam/auth-pam=2Ec b/src/plugins/auth-pam/aut=
h-pam=2Ec
index 948b6af=2E=2E0cd201d 100644
--- a/src/plugins/auth-pam/auth=
-pam=2Ec
+++ b/src/plugins/auth-pam/auth-pam=2Ec
@@ -184,6 +184,11 @@
     =
return -1;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC d=
iagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
=
+
 static ssize_t
 send_string(int fd, const char *string)
 {
@@ -199,6 +20=
4,10 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma G=
CC diagnostic pop
+#endif
+
 #ifdef DO_DAEMONIZE
 
 /*
diff --git a/src/tap=
ctl/tap=2Ec b/src/tapctl/tap=2Ec
index ac1ecd2=2E=2Ea3d83e9 100644
--- a/sr=
c/tapctl/tap=2Ec
+++ b/src/tapctl/tap=2Ec
@@ -102,6 +102,11 @@
 }
 #endif
 =

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
=
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /**
  * Retu=
rns length of string of strings
  *
@@ -1226,6 +1231,9 @@
     return dwRes=
ult;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnos=
tic pop
+#endif
 
 void
 tap_free_adapter_list(_In_ struct tap_adapter_node=
 *pAdapterList)
diff --git a/tests/unit_tests/openvpn/test_buffer=2Ec b/tes=
ts/unit_tests/openvpn/test_buffer=2Ec
index 338265d=2E=2Eb480985 100644
---=
 a/tests/unit_tests/openvpn/test_buffer=2Ec
+++ b/tests/unit_tests/openvpn/=
test_buffer=2Ec
@@ -106,6 +106,11 @@
     gc_free(&gc);
 }
 
+#if defined(_=
_GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC di=
agnostic ignored "-Wsign-conversion"
+#endif
+
 static void
 test_buffer_fo=
rmat_hex_ex(void **state)
 {
@@ -139,6 +144,10 @@
     gc_free(&gc);
 }
 
+=
#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#e=
ndif
+
 struct test_buffer_list_aggregate_ctx
 {
     struct buffer_list *e=
mpty;
diff --git a/tests/unit_tests/openvpn/test_crypto=2Ec b/tests/unit_te=
sts/openvpn/test_crypto=2Ec
index f86aca8=2E=2Ee68a0b2 100644
--- a/tests/u=
nit_tests/openvpn/test_crypto=2Ec
+++ b/tests/unit_tests/openvpn/test_crypt=
o=2Ec
@@ -52,6 +52,11 @@
 
 static const char testtext[] =3D "Dummy text to=
 test PEM encoding";
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragm=
a GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+=
#endif
+
 static void
 crypto_pem_encode_decode_loopback(void **state)
 {
@=
@ -799,6 +804,10 @@
     assert_null(epoch_lookup_decrypt_key(co, 23));
 }
=
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
=
+#endif
+
 void
 crypto_test_epoch_key_overflow(void **state)
 {
@@ -914,6 =
+923,11 @@
     assert_memory_equal(out, expected_hash, UT_SIPHASH_HASH_SIZ=
E);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnost=
ic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 stat=
ic void
 test_siphash_openssl(void **state)
 {
@@ -959,6 +973,9 @@
     sip=
hash_openssl_uninit(sipctx);
 }
 
+#if defined(__GNUC__) || defined(__clang=
__)
+#pragma GCC diagnostic pop
+#endif
 
 int
 main(void)
diff --git a/tes=
ts/unit_tests/openvpn/test_cryptoapi=2Ec b/tests/unit_tests/openvpn/test_cr=
yptoapi=2Ec
index 37bbe92=2E=2E55aafbb 100644
--- a/tests/unit_tests/openvp=
n/test_cryptoapi=2Ec
+++ b/tests/unit_tests/openvpn/test_cryptoapi=2Ec
@@ -=
137,6 +137,11 @@
     return c->cert ? c : NULL;
 }
 
+#if defined(__GNUC__=
) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnosti=
c ignored "-Wsign-conversion"
+#endif
+
 /* import sample certificates into=
 windows cert store */
 static void
 import_certs(void **state)
@@ -223,6 +=
228,10 @@
     certs_loaded =3D true;
 }
 
+#if defined(__GNUC__) || define=
d(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static int
 cleanup(voi=
d **state)
 {
diff --git a/tests/unit_tests/openvpn/test_dhcp=2Ec b/tests/u=
nit_tests/openvpn/test_dhcp=2Ec
index 3a84e1e=2E=2Ee331d3d 100644
--- a/tes=
ts/unit_tests/openvpn/test_dhcp=2Ec
+++ b/tests/unit_tests/openvpn/test_dhc=
p=2Ec
@@ -50,6 +50,11 @@
     return "dummy";
 }
 
+#if defined(__GNUC__) |=
| defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic i=
gnored "-Wsign-conversion"
+#endif
+
 static void
 test_write_dhcp_search_s=
tr(void **state)
 {
@@ -141,6 +146,10 @@
     gc_free(&gc);
 }
 
+#if defin=
ed(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 i=
nt
 main(void)
 {
diff --git a/tests/unit_tests/openvpn/test_networking=2Ec=
 b/tests/unit_tests/openvpn/test_networking=2Ec
index 1c9cac1=2E=2Eae75386 =
100644
--- a/tests/unit_tests/openvpn/test_networking=2Ec
+++ b/tests/unit_=
tests/openvpn/test_networking=2Ec
@@ -40,6 +40,11 @@
     return net_iface_=
del(NULL, name);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma=
 GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#=
endif
+
 static int
 net__iface_mtu_set(int mtu)
 {
@@ -48,6 +53,10 @@
    =
 return net_iface_mtu_set(NULL, iface, mtu);
 }
 
+#if defined(__GNUC__) ||=
 defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static int
 net_=
_addr_v4_add(const char *addr_str, int prefixlen)
 {
diff --git a/tests/uni=
t_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec
index =
49ba833=2E=2E889e6d7 100644
--- a/tests/unit_tests/openvpn/test_pkt=2Ec
+++=
 b/tests/unit_tests/openvpn/test_pkt=2Ec
@@ -618,6 +618,11 @@
     assert_m=
emory_equal(server_id2_p1=2Eid, server_id_p2=2Eid, SID_SIZE);
 }
 
+#if def=
ined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma =
GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static void
 test_gen=
erate_reset_packet_plain(void **ut_state)
 {
@@ -696,6 +701,10 @@
     free=
_tas(&tas_server);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#prag=
ma GCC diagnostic pop
+#endif
+
 /* A peer can ask us to append the wrapped=
 client key (WKc) to our next
  * control packet=2E Only a tls-crypt-v2 cli=
ent has one, so check that we
  * refuse to build such a packet when we hav=
e no key instead of walking
diff --git a/tests/unit_tests/openvpn/test_ssl=
=2Ec b/tests/unit_tests/openvpn/test_ssl=2Ec
index 4987dd0=2E=2E85b8d12 100=
644
--- a/tests/unit_tests/openvpn/test_ssl=2Ec
+++ b/tests/unit_tests/open=
vpn/test_ssl=2Ec
@@ -265,6 +265,10 @@
 #endif /* HAVE_OPENSSL_STORE */
 }
 =

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
=
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
 
 static void
=
 init_frame_parameters(struct frame *frame)
@@ -886,6 +890,10 @@
     free_=
certificate(cert);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#prag=
ma GCC diagnostic pop
+#endif
+
 /* Certificate with two CNs, "foo" and "ba=
r"=2E
  *
  * Generated with:
diff --git a/tests/unit_tests/openvpn/test_tl=
s_crypt=2Ec b/tests/unit_tests/openvpn/test_tls_crypt=2Ec
index f8aa199=2E=
=2Eab90ea5 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt=2Ec
+++ b/t=
ests/unit_tests/openvpn/test_tls_crypt=2Ec
@@ -232,6 +232,11 @@
     }
 }
 =

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
=
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /**
  * Chec=
k that short messages are successfully wrapped-and-unwrapped=2E
  */
@@ -77=
3,6 +778,10 @@
     tls_wrap_free(&wrap_ctx);
 }
 
+#if defined(__GNUC__) |=
| defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static void
 te=
st_tls_crypt_v2_write_server_key_file(void **state)
 {
diff --git a/tests/u=
nit_tests/openvpn/test_user_pass=2Ec b/tests/unit_tests/openvpn/test_user_p=
ass=2Ec
index 776a86a=2E=2E5bc1d2a 100644
--- a/tests/unit_tests/openvpn/te=
st_user_pass=2Ec
+++ b/tests/unit_tests/openvpn/test_user_pass=2Ec
@@ -46,6=
 +46,12 @@
     return query_user_exec_builtin();
 }
 #endif
+
+#if defined=
(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC =
diagnostic ignored "-Wsign-conversion"
+#endif
+
 bool
 query_user_exec_bui=
ltin(void)
 {
@@ -58,6 +64,11 @@
 
     return mock();
 }
+
+#if defined(__=
GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 void
 =
management_auth_failure(const struct management *man, const char *type, con=
st char *reason)
 {

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1186?usp=3Demail
To unsubscribe, or for help writing mail filters, =
visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: Iecf502ec811e99c56647b2d45298fa0fb66960fb
Gerrit-Change-Number: 1186
G=
errit-PatchSet: 21
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom=
>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewe=
r: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>

--t56Hrt5BvxY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #21</strong> to the change originally created by Fra=
nk Lichtenheld=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1186?usp=3Demail">View Change</a></p><p>The following approvals got outd=
ated and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Enable -Wsign-conversion<br><br>As before with -Wconversion override al=
l the known issues<br>to be able to address them one by one=2E<br><br>Chang=
e-Id: Iecf502ec811e99c56647b2d45298fa0fb66960fb<br>Signed-off-by: Frank Lic=
htenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;r=
azvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1186<br>Message-Id: &lt;20261112174213=2E23832-1-gert@greenie=2Emuc=
=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg41216=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@gre=
enie=2Emuc=2Ede&gt;<br>---<br>M CMakeLists=2Etxt<br>M configure=2Eac<br>M s=
rc/openvpn/acc=2Ec<br>M src/openvpn/argv=2Ec<br>M src/openvpn/auth_token=2E=
c<br>M src/openvpn/buffer=2Ec<br>M src/openvpn/buffer=2Eh<br>M src/openvpn/=
comp-lz4=2Ec<br>M src/openvpn/console_builtin=2Ec<br>M src/openvpn/console_=
systemd=2Ec<br>M src/openvpn/crypto=2Ec<br>M src/openvpn/crypto_epoch=2Ec<b=
r>M src/openvpn/crypto_mbedtls=2Ec<br>M src/openvpn/crypto_openssl=2Ec<br>M=
 src/openvpn/cryptoapi=2Ec<br>M src/openvpn/dco=2Ec<br>M src/openvpn/dco_fr=
eebsd=2Ec<br>M src/openvpn/dco_linux=2Ec<br>M src/openvpn/dco_win=2Ec<br>M =
src/openvpn/dhcp=2Ec<br>M src/openvpn/dns=2Ec<br>M src/openvpn/env_set=2Ec<=
br>M src/openvpn/error=2Ec<br>M src/openvpn/error=2Eh<br>M src/openvpn/even=
t=2Ec<br>M src/openvpn/fdmisc=2Ec<br>M src/openvpn/fdmisc=2Eh<br>M src/open=
vpn/forward=2Ec<br>M src/openvpn/fragment=2Ec<br>M src/openvpn/helper=2Ec<b=
r>M src/openvpn/init=2Ec<br>M src/openvpn/lzo=2Ec<br>M src/openvpn/manage=
=2Ec<br>M src/openvpn/misc=2Ec<br>M src/openvpn/mss=2Ec<br>M src/openvpn/mt=
cp=2Ec<br>M src/openvpn/mtu=2Ec<br>M src/openvpn/multi=2Ec<br>M src/openvpn=
/multi_io=2Ec<br>M src/openvpn/networking_sitnl=2Ec<br>M src/openvpn/occ=2E=
c<br>M src/openvpn/openvpn=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvp=
n/options_parse=2Ec<br>M src/openvpn/options_show=2Ec<br>M src/openvpn/opti=
ons_string=2Ec<br>M src/openvpn/options_util=2Ec<br>M src/openvpn/packet_id=
=2Ec<br>M src/openvpn/ping=2Ec<br>M src/openvpn/pkcs11=2Ec<br>M src/openvpn=
/pkcs11_openssl=2Ec<br>M src/openvpn/platform=2Ec<br>M src/openvpn/plugin=
=2Ec<br>M src/openvpn/pool=2Ec<br>M src/openvpn/proxy=2Ec<br>M src/openvpn/=
ps=2Ec<br>M src/openvpn/push=2Ec<br>M src/openvpn/reliable=2Ec<br>M src/ope=
nvpn/route=2Ec<br>M src/openvpn/socket=2Ec<br>M src/openvpn/socket=2Eh<br>M=
 src/openvpn/socket_util=2Ec<br>M src/openvpn/socks=2Ec<br>M src/openvpn/ss=
l=2Ec<br>M src/openvpn/ssl_mbedtls=2Ec<br>M src/openvpn/ssl_ncp=2Ec<br>M sr=
c/openvpn/ssl_openssl=2Ec<br>M src/openvpn/ssl_pkt=2Ec<br>M src/openvpn/ssl=
_util=2Ec<br>M src/openvpn/ssl_verify=2Ec<br>M src/openvpn/ssl_verify_mbedt=
ls=2Ec<br>M src/openvpn/ssl_verify_openssl=2Ec<br>M src/openvpn/status=2Ec<=
br>M src/openvpn/tls_crypt=2Ec<br>M src/openvpn/tun=2Ec<br>M src/openvpn/tu=
n_afunix=2Ec<br>M src/openvpn/vlan=2Ec<br>M src/openvpn/wfp_block=2Ec<br>M =
src/openvpn/win32-util=2Ec<br>M src/openvpn/win32=2Ec<br>M src/openvpn/xkey=
_helper=2Ec<br>M src/openvpn/xkey_provider=2Ec<br>M src/openvpnmsica/dllmai=
n=2Ec<br>M src/openvpnserv/common=2Ec<br>M src/openvpnserv/interactive=2Ec<=
br>M src/plugins/auth-pam/auth-pam=2Ec<br>M src/tapctl/tap=2Ec<br>M tests/u=
nit_tests/openvpn/test_buffer=2Ec<br>M tests/unit_tests/openvpn/test_crypto=
=2Ec<br>M tests/unit_tests/openvpn/test_cryptoapi=2Ec<br>M tests/unit_tests=
/openvpn/test_dhcp=2Ec<br>M tests/unit_tests/openvpn/test_networking=2Ec<br=
>M tests/unit_tests/openvpn/test_pkt=2Ec<br>M tests/unit_tests/openvpn/test=
_ssl=2Ec<br>M tests/unit_tests/openvpn/test_tls_crypt=2Ec<br>M tests/unit_t=
ests/openvpn/test_user_pass=2Ec<br>96 files changed, 1,116 insertions(+), 1=
1 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/86/1186/21</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeList=
s=2Etxt b/CMakeLists=2Etxt</span><br><span>index 5cf1a30=2E=2Ea90eb1a 10064=
4</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=
=2Etxt</span><br><span>@@ -117,7 +117,7 @@</span><br><span>     check_and_a=
dd_compiler_flag(-Wno-stringop-truncation NoStringOpTruncation)</span><br><=
span>     check_and_add_compiler_flag(-Wstrict-prototypes StrictPrototypes)=
</span><br><span>     check_and_add_compiler_flag(-Wold-style-definition Ol=
dStyleDefinition)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
add_compile_options(-Wconversion -Wno-sign-conversion)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    add_compile_options(-Wconversion)</s=
pan><br><span>     add_compile_options(-Wextra -Wno-unused-parameter)</span=
><br><span>     # clang doesn&#39;t have the different levels but also does=
n&#39;t include it in -Wextra</span><br><span>     check_and_add_compiler_f=
lag(-Wimplicit-fallthrough=3D2 GCCImplicitFallthrough)</span><br><span>diff=
 --git a/configure=2Eac b/configure=2Eac</span><br><span>index 9326c4e=2E=
=2E585c3bd 100644</span><br><span>--- a/configure=2Eac</span><br><span>+++ =
b/configure=2Eac</span><br><span>@@ -1248,7 +1248,7 @@</span><br><span> ACL=
_CHECK_ADD_COMPILE_FLAGS([-Wno-stringop-truncation])</span><br><span> ACL_C=
HECK_ADD_COMPILE_FLAGS([-Wstrict-prototypes])</span><br><span> ACL_CHECK_AD=
D_COMPILE_FLAGS([-Wold-style-definition])</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-ACL_CHECK_ADD_COMPILE_FLAGS([-Wconversion -Wno-sign-con=
version])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ACL_CHECK_=
ADD_COMPILE_FLAGS([-Wconversion])</span><br><span> ACL_CHECK_ADD_COMPILE_FL=
AGS([-Wall])</span><br><span> ACL_CHECK_ADD_COMPILE_FLAGS([-Wextra -Wno-unu=
sed-parameter])</span><br><span> # clang doesn&#39;t have the different lev=
els but also doesn&#39;t include it in -Wextra</span><br><span>diff --git a=
/src/openvpn/acc=2Ec b/src/openvpn/acc=2Ec</span><br><span>index e9656a6=2E=
=2Eceb7100 100644</span><br><span>--- a/src/openvpn/acc=2Ec</span><br><span=
>+++ b/src/openvpn/acc=2Ec</span><br><span>@@ -148,6 +148,11 @@</span><br><=
span>     return parse_acc_message_flags(flags, err_reason, gc);</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot=
;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> void</span><br><span> receive_acc_message(struct context *c, cons=
t struct buffer *buffer)</span><br><span> {</span><br><span>@@ -236,6 +241,=
10 @@</span><br><span> }</span><br><span> </span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(_=
_clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GC=
C diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#en=
dif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
> bool</span><br><span> send_acc_message(struct context *c,</span><br><span=
>                  struct tls_multi *multi,</span><br><span>diff --git a/sr=
c/openvpn/argv=2Ec b/src/openvpn/argv=2Ec</span><br><span>index 028671d=2E=
=2Ec716e5b0 100644</span><br><span>--- a/src/openvpn/argv=2Ec</span><br><sp=
an>+++ b/src/openvpn/argv=2Ec</span><br><span>@@ -323,6 +323,11 @@</span><b=
r><span>     return f;</span><br><span> }</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__=
clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC=
 diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pr=
agma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  *  Create =
a struct argv based on a format string</span><br><span>  *</span><br><span>=
@@ -418,6 +423,10 @@</span><br><span>     return res;</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if =
defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span> /**</span><br><span>  *  printf() variant w=
hich populates a struct argv=2E  It processes the</span><br><span>  *  form=
at string with the provided arguments=2E  For each space separator found</s=
pan><br><span>diff --git a/src/openvpn/auth_token=2Ec b/src/openvpn/auth_to=
ken=2Ec</span><br><span>index 84558af=2E=2E211af90 100644</span><br><span>-=
-- a/src/openvpn/auth_token=2Ec</span><br><span>+++ b/src/openvpn/auth_toke=
n=2Ec</span><br><span>@@ -36,6 +36,11 @@</span><br><span>  * padding */</sp=
an><br><span> static_assert(TOKEN_DATA_LEN % 3 =3D=3D 0, &quot;TOKEN_DATA_L=
EN is not a multiple of 3&quot;);</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma G=
CC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> bool</span><br><span> is_auth_token(=
const char *password)</span><br><span> {</span><br><span>@@ -291,6 +296,9 @=
@</span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNU=
C__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#endif</span><br><span> </span><br><span> static bool</span><=
br><span> check_hmac_token(hmac_ctx_t *ctx, const uint8_t *b64decoded, cons=
t char *username)</span><br><span>diff --git a/src/openvpn/buffer=2Ec b/src=
/openvpn/buffer=2Ec</span><br><span>index 8813fa5=2E=2E7f142c4f 100644</spa=
n><br><span>--- a/src/openvpn/buffer=2Ec</span><br><span>+++ b/src/openvpn/=
buffer=2Ec</span><br><span>@@ -92,6 +92,11 @@</span><br><span>     return b=
uf;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic=
 ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> struct buffer</span><br><span> #ifdef BUF_INIT_TRAC=
KING</span><br><span> clone_buf_debug(const struct buffer *buf, const char =
*file, int line)</span><br><span>@@ -305,6 +310,10 @@</span><br><span>     =
return ret;</span><br><span> }</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic=
 pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><=
br><span>  * Garbage collection</span><br><span>  */</span><br><span>@@ -43=
9,6 +448,11 @@</span><br><span>     }</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__=
) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><spa=
n>  * Hex dump -- Output a binary buffer to a hex string and return it=2E</=
span><br><span>  */</span><br><span>@@ -538,6 +552,10 @@</span><br><span>  =
   buf_null_terminate(buf);</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defin=
ed(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragm=
a GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span> const char *</span><br><span> skip_leading_whitespace(const char *str=
)</span><br><span> {</span><br><span>@@ -717,6 +735,11 @@</span><br><span> =
    return memcmp(CBPTR(src), match, size) =3D=3D 0;</span><br><span> }</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if d=
efined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conv=
ersion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> bo=
ol</span><br><span> buf_string_compare_advance(struct buffer *src, const ch=
ar *match)</span><br><span> {</span><br><span>@@ -731,6 +754,10 @@</span><b=
r><span>     }</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</=
span><br><span> buf_substring_len(const struct buffer *buf, int delim)</spa=
n><br><span> {</span><br><span>@@ -957,6 +984,11 @@</span><br><span>     re=
turn false;</span><br><span> }</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic=
 push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC di=
agnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span> static inline bool</span><br><span> char_in=
c_exc(const char c, const unsigned int inclusive, const unsigned int exclus=
ive)</span><br><span> {</span><br><span>@@ -964,6 +996,10 @@</span><br><spa=
n>            &amp;&amp; !char_class((unsigned char)c, exclusive);</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> bool</span><br><span> string_=
class(const char *str, const unsigned int inclusive, const unsigned int exc=
lusive)</span><br><span> {</span><br><span>@@ -1241,6 +1277,11 @@</span><br=
><span>     }</span><br><span> }</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnost=
ic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC =
diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> void</span><br><span> buffer_list_aggrega=
te_separator(struct buffer_list *bl, const size_t max_len, const char *sep)=
</span><br><span> {</span><br><span>@@ -1286,6 +1327,10 @@</span><br><span>=
     }</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void</span><br>=
<span> buffer_list_aggregate(struct buffer_list *bl, const size_t max)</spa=
n><br><span> {</span><br><span>@@ -1323,6 +1368,11 @@</span><br><span>     =
}</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic i=
gnored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span> struct buffer_list *</span><br><span> buffer_list_fil=
e(const char *fn, int max_line_len)</span><br><span> {</span><br><span>@@ -=
1402,3 +1452,7 @@</span><br><span>     buf_advance(buf, field_len + 1);</sp=
an><br><span>     return field;</span><br><span> }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>diff --gi=
t a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh</span><br><span>index 7=
af4444=2E=2Eede3066 100644</span><br><span>--- a/src/openvpn/buffer=2Eh</sp=
an><br><span>+++ b/src/openvpn/buffer=2Eh</span><br><span>@@ -643,6 +643,11=
 @@</span><br><span>     return true;</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__=
) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><sp=
an>  * Initialise a buffer with an externally provided writable memory regi=
on=2E</span><br><span>  *</span><br><span>@@ -1619,6 +1624,10 @@</span><br>=
<span>     return memcmp(CBPTR(src), match, size) =3D=3D 0;</span><br><span=
> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  * Return true =
if the head of \c src matches the string \c match=2E</span><br><span>  *</s=
pan><br><span>diff --git a/src/openvpn/comp-lz4=2Ec b/src/openvpn/comp-lz4=
=2Ec</span><br><span>index 57c6bb3=2E=2E0c5f22f 100644</span><br><span>--- =
a/src/openvpn/comp-lz4=2Ec</span><br><span>+++ b/src/openvpn/comp-lz4=2Ec</=
span><br><span>@@ -89,6 +89,11 @@</span><br><span>     compv2_escape_data_i=
fneeded(buf);</span><br><span> }</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnost=
ic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC =
diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> static void</span><br><span> do_lz4_decom=
press(int zlen_max, struct buffer *work, struct buffer *buf,</span><br><spa=
n>                   struct compress_context *compctx)</span><br><span>@@ -=
198,6 +203,10 @@</span><br><span>     }</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC=
__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span> const struct compress_alg lz4_alg =3D { &quot;lz4&quot;, =
lz4_compress_init, lz4_compress_uninit, lz4_compress,</span><br><span>     =
                                  lz4_decompress };</span><br><span> </span=
><br><span>diff --git a/src/openvpn/console_builtin=2Ec b/src/openvpn/conso=
le_builtin=2Ec</span><br><span>index 4737677=2E=2Edc71d12 100644</span><br>=
<span>--- a/src/openvpn/console_builtin=2Ec</span><br><span>+++ b/src/openv=
pn/console_builtin=2Ec</span><br><span>@@ -41,6 +41,11 @@</span><br><span> =
#include &lt;termios=2Eh&gt;</span><br><span> #endif</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) ||=
 defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #ifdef _WIN32</span><=
br><span> </span><br><span> #include &quot;win32=2Eh&quot;</span><br><span>=
@@ -289,3 +294,7 @@</span><br><span> </span><br><span>     return ret;</spa=
n><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) ||=
 defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#endif</span><br><span>diff --git a/src/openvpn/console_systemd=2Ec =
b/src/openvpn/console_systemd=2Ec</span><br><span>index eaed24e=2E=2E8fc7f7=
2 100644</span><br><span>--- a/src/openvpn/console_systemd=2Ec</span><br><s=
pan>+++ b/src/openvpn/console_systemd=2Ec</span><br><span>@@ -53,6 +53,11 @=
@</span><br><span>     return (sd_booted() &gt; 0) &amp;&amp; (stat(SYSTEMD=
_ASK_PASSWORD_PATH, &amp;c) =3D=3D 0);</span><br><span> }</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC_=
_) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static bool</spa=
n><br><span> get_console_input_systemd(const char *prompt, const bool echo,=
 char *input, const int capacity)</span><br><span> {</span><br><span>@@ -86=
,6 +91,10 @@</span><br><span>     return ret;</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(=
__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> /**</span><br><span>  *  Systemd aware implementati=
on of query_user_exec()=2E  If systemd is not running</span><br><span>  *  =
it will fall back to use query_user_exec_builtin() instead=2E</span><br><sp=
an>diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec</span><br><=
span>index 6efa005=2E=2E9d53006 100644</span><br><span>--- a/src/openvpn/cr=
ypto=2Ec</span><br><span>+++ b/src/openvpn/crypto=2Ec</span><br><span>@@ -6=
2,6 +62,11 @@</span><br><span>  * happen unless the frame parameters are wr=
ong=2E</span><br><span>  */</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pu=
sh</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span> static void</span><br><span> openvpn_encrypt_a=
ead(struct buffer *buf, struct buffer work, struct crypto_options *opt)</sp=
an><br><span> {</span><br><span>@@ -1573,6 +1578,10 @@</span><br><span>    =
 return nbits;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void<=
/span><br><span> must_have_n_keys(const char *filename, const char *option,=
 const struct key2 *key2, int n)</span><br><span> {</span><br><span>diff --=
git a/src/openvpn/crypto_epoch=2Ec b/src/openvpn/crypto_epoch=2Ec</span><br=
><span>index 35f9b55=2E=2E312cf6f 100644</span><br><span>--- a/src/openvpn/=
crypto_epoch=2Ec</span><br><span>+++ b/src/openvpn/crypto_epoch=2Ec</span><=
br><span>@@ -38,6 +38,11 @@</span><br><span> #include &quot;buffer=2Eh&quot=
;</span><br><span> #include &quot;integer=2Eh&quot;</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || =
defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void</span><br><span> =
ovpn_hkdf_expand(const uint8_t *secret, const uint8_t *info, size_t info_le=
n,</span><br><span>                  uint8_t *out, size_t out_len)</span><b=
r><span>@@ -458,3 +463,7 @@</span><br><span>         epoch_iterate_send_key=
(opt);</span><br><span>     }</span><br><span> }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>diff --git =
a/src/openvpn/crypto_mbedtls=2Ec b/src/openvpn/crypto_mbedtls=2Ec</span><br=
><span>index 3a2a8c6=2E=2Eceaaad4 100644</span><br><span>--- a/src/openvpn/=
crypto_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/crypto_mbedtls=2Ec</sp=
an><br><span>@@ -821,6 +821,11 @@</span><br><span>     ASSERT(hmac_length =
=3D=3D dst_size);</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang=
__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diag=
nostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma =
GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * Generate the =
hash required by for the \c tls1_PRF function=2E</span><br><span>  *</span>=
<br><span>@@ -1149,4 +1154,8 @@</span><br><span>     return ret;</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span> #endif /* defined(ENABLE_CRYPTO_=
MBEDTLS) */</span><br><span>diff --git a/src/openvpn/crypto_openssl=2Ec b/s=
rc/openvpn/crypto_openssl=2Ec</span><br><span>index b7f2ef3=2E=2E0a1d00c 10=
0644</span><br><span>--- a/src/openvpn/crypto_openssl=2Ec</span><br><span>+=
++ b/src/openvpn/crypto_openssl=2Ec</span><br><span>@@ -487,6 +487,11 @@</s=
pan><br><span>     return ret;</span><br><span> }</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || de=
fined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pr=
agma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> bool</span><br><span> c=
rypto_pem_decode(const char *name, struct buffer *dst, const struct buffer =
*src)</span><br><span> {</span><br><span>@@ -1306,6 +1311,10 @@</span><br><=
span> }</span><br><span> #endif /* if OPENSSL_VERSION_NUMBER &lt; 0x3000000=
0L */</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> int</span><br><span> memcmp_constan=
t_time(const void *a, const void *b, size_t size)</span><br><span> {</span>=
<br><span>diff --git a/src/openvpn/cryptoapi=2Ec b/src/openvpn/cryptoapi=2E=
c</span><br><span>index ef3c94c=2E=2E30a5144 100644</span><br><span>--- a/s=
rc/openvpn/cryptoapi=2Ec</span><br><span>+++ b/src/openvpn/cryptoapi=2Ec</s=
pan><br><span>@@ -62,7 +62,7 @@</span><br><span>     return 0;</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#else  /* HAVE_XKEY_PROVIDER */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#else /* HAVE_XKEY_PROVIDER */</span><br><span> </span><br><=
span> static XKEY_EXTERNAL_SIGN_fn xkey_cng_sign;</span><br><span> </span><=
br><span>@@ -260,6 +260,11 @@</span><br><span>     return false;</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot=
;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> static const CERT_CONTEXT *</span><br><span> find_certificate_in_=
store(const char *cert_prop, HCERTSTORE cert_store)</span><br><span> {</spa=
n><br><span>@@ -598,6 +603,10 @@</span><br><span>     return 0;</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> int</span><br><span> SSL_CTX_use_=
CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)</span><br><s=
pan> {</span><br><span>diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=
=2Ec</span><br><span>index f3b5d44=2E=2E236be93 100644</span><br><span>--- =
a/src/openvpn/dco=2Ec</span><br><span>+++ b/src/openvpn/dco=2Ec</span><br><=
span>@@ -50,6 +50,11 @@</span><br><span> #include &lt;cap-ng=2Eh&gt;</span>=
<br><span> #endif</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic igno=
red &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span> static int</span><br><span> dco_install_key(struct tls_m=
ulti *multi, struct key_state *ks, const uint8_t *encrypt_key,</span><br><s=
pan>                 const uint8_t *encrypt_iv, const uint8_t *decrypt_key,=
 const uint8_t *decrypt_iv,</span><br><span>@@ -807,4 +812,8 @@</span><br><=
span> #endif /* if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defi=
ned(_WIN32) */</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endi=
f /* defined(ENABLE_DCO) */</span><br><span>diff --git a/src/openvpn/dco_fr=
eebsd=2Ec b/src/openvpn/dco_freebsd=2Ec</span><br><span>index 3148f10=2E=2E=
11b8dff 100644</span><br><span>--- a/src/openvpn/dco_freebsd=2Ec</span><br>=
<span>+++ b/src/openvpn/dco_freebsd=2Ec</span><br><span>@@ -577,6 +577,11 @=
@</span><br><span>         __func__, peerid, mi-&gt;context=2Ec2=2Edco_read=
_bytes, mi-&gt;context=2Ec2=2Edco_write_bytes);</span><br><span> }</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if define=
d(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversio=
n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</sp=
an><br><span> dco_read_and_process(dco_context_t *dco)</span><br><span> {</=
span><br><span>@@ -762,6 +767,10 @@</span><br><span>     return available;<=
/span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span> const char *</span><br=
><span> dco_version_string(struct gc_arena *gc)</span><br><span> {</span><b=
r><span>diff --git a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2Ec<=
/span><br><span>index a84e310=2E=2E60107c4 100644</span><br><span>--- a/src=
/openvpn/dco_linux=2Ec</span><br><span>+++ b/src/openvpn/dco_linux=2Ec</spa=
n><br><span>@@ -220,6 +220,11 @@</span><br><span>     return sock;</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &q=
uot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> int</span><br><span> dco_new_peer(dco_context_t *dco, unsigned=
 int peerid, int sd, struct sockaddr *localaddr,</span><br><span>          =
    struct sockaddr *remoteaddr, const struct in_addr *vpn_ipv4,</span><br>=
<span>@@ -1257,6 +1262,10 @@</span><br><span>     return ret;</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> int</span><br><span> dco_get_peer_s=
tats(struct context *c, const bool raise_sigusr1_on_err)</span><br><span> {=
</span><br><span>diff --git a/src/openvpn/dco_win=2Ec b/src/openvpn/dco_win=
=2Ec</span><br><span>index 12b0666=2E=2Ea854045 100644</span><br><span>--- =
a/src/openvpn/dco_win=2Ec</span><br><span>+++ b/src/openvpn/dco_win=2Ec</sp=
an><br><span>@@ -220,6 +220,11 @@</span><br><span>     return 0;</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot=
;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> static void</span><br><span> dco_connect_wait(HANDLE handle, OVER=
LAPPED *ov, int timeout, struct signal_info *sig_info)</span><br><span> {</=
span><br><span>@@ -1091,6 +1096,10 @@</span><br><span>     gc_free(&amp;gc)=
;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> bool</span><br><span=
> dco_supports_epoch_data(const struct context *c)</span><br><span> {</span=
><br><span>diff --git a/src/openvpn/dhcp=2Ec b/src/openvpn/dhcp=2Ec</span><=
br><span>index 19e9e2d=2E=2E525d567 100644</span><br><span>--- a/src/openvp=
n/dhcp=2Ec</span><br><span>+++ b/src/openvpn/dhcp=2Ec</span><br><span>@@ -7=
2,6 +72,11 @@</span><br><span>     return -1;</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(=
__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static in=
_addr_t</span><br><span> do_extract(struct dhcp *dhcp, int optlen)</span><b=
r><span> {</span><br><span>@@ -186,6 +191,10 @@</span><br><span>     return=
 0;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #if defined(_WIN32=
) || defined(DHCP_UNIT_TEST)</span><br><span> </span><br><span> /*</span><b=
r><span>@@ -327,6 +336,11 @@</span><br><span>     buf_write(buf, tmp_buf, l=
en);</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnosti=
c ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span> bool</span><br><span> build_dhcp_options_string(st=
ruct buffer *buf, const struct tuntap_options *o)</span><br><span> {</span>=
<br><span>@@ -375,4 +389,8 @@</span><br><span>     return !error;</span><br=
><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> #endif /* defined(_WIN32) */<=
/span><br><span>diff --git a/src/openvpn/dns=2Ec b/src/openvpn/dns=2Ec</spa=
n><br><span>index abe30ed=2E=2Ee2cb981 100644</span><br><span>--- a/src/ope=
nvpn/dns=2Ec</span><br><span>+++ b/src/openvpn/dns=2Ec</span><br><span>@@ -=
58,6 +58,11 @@</span><br><span>     return true;</span><br><span> }</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defin=
ed(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversi=
on&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> bool</=
span><br><span> dns_server_addr_parse(struct dns_server *server, const char=
 *addr)</span><br><span> {</span><br><span>@@ -144,6 +149,10 @@</span><br><=
span>     return true;</span><br><span> }</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__=
clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC=
 diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#end=
if</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
 bool</span><br><span> dns_domain_list_append(struct dns_domain **entry, ch=
ar **domains, struct gc_arena *gc)</span><br><span> {</span><br><span>@@ -4=
02,6 +411,11 @@</span><br><span>     }</span><br><span> }</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC_=
_) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static void</spa=
n><br><span> run_up_down_service(bool add, const struct options *o, const s=
truct tuntap *tt)</span><br><span> {</span><br><span>@@ -476,7 +490,11 @@</=
span><br><span>     send_msg_iservice(o-&gt;msg_channel, &amp;nrpt, sizeof(=
nrpt), &amp;ack, &quot;DNS&quot;);</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#else  /* ifdef _WIN32 */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC_=
_) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else /* ifdef _WIN3=
2 */</span><br><span> </span><br><span> static void</span><br><span> setenv=
_dns_option(struct env_set *es, const char *format, size_t i, size_t j, con=
st char *value)</span><br><span>@@ -702,6 +720,11 @@</span><br><span>     r=
eturn true;</span><br><span> }</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic=
 push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC di=
agnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span> static void</span><br><span> run_up_down_co=
mmand(bool up, struct options *o, const struct tuntap *tt,</span><br><span>=
                     struct dns_updown_runner_info *updown_runner)</span><b=
r><span>@@ -780,6 +803,10 @@</span><br><span>     msg(M_INFO, &quot;dns %s =
command exited with status %d&quot;, up ? &quot;up&quot; : &quot;down&quot;=
, status);</span><br><span> }</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic =
pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* _=
WIN32 */</span><br><span> </span><br><span> void</span><br><span>diff --git=
 a/src/openvpn/env_set=2Ec b/src/openvpn/env_set=2Ec</span><br><span>index =
67a5bf5=2E=2Ed59115a 100644</span><br><span>--- a/src/openvpn/env_set=2Ec</=
span><br><span>+++ b/src/openvpn/env_set=2Ec</span><br><span>@@ -432,6 +432=
,11 @@</span><br><span>     return (script_security() &gt;=3D SSEC_PW_ENV |=
| !is_password_env_var(str));</span><br><span> }</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || def=
ined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pra=
gma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* Make arrays of strin=
gs */</span><br><span> </span><br><span> const char **</span><br><span>@@ -=
470,3 +475,7 @@</span><br><span>     ret[i] =3D NULL;</span><br><span>     =
return (const char **)ret;</span><br><span> }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>diff --git a/s=
rc/openvpn/error=2Ec b/src/openvpn/error=2Ec</span><br><span>index 32d819d=
=2E=2Ea3f7990 100644</span><br><span>--- a/src/openvpn/error=2Ec</span><br>=
<span>+++ b/src/openvpn/error=2Ec</span><br><span>@@ -219,6 +219,11 @@</spa=
n><br><span>     va_end(arglist);</span><br><span> }</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(_WIN32) &amp=
;&amp; (defined(__GNUC__) || defined(__clang__))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-=
Wsign-conversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> static const char *</span><br><span> openvpn_strerror(int err, bool=
 crt_error, struct gc_arena *gc)</span><br><span> {</span><br><span>@@ -689=
,6 +694,10 @@</span><br><span>     }</span><br><span> }</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(_WIN32) &=
amp;&amp; (defined(__GNUC__) || defined(__clang__))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * In mul=
ticlient mode, put a client-specific prefix</span><br><span>  * before each=
 message=2E</span><br><span>diff --git a/src/openvpn/error=2Eh b/src/openvp=
n/error=2Eh</span><br><span>index 373cbc1=2E=2E0056d05 100644</span><br><sp=
an>--- a/src/openvpn/error=2Eh</span><br><span>+++ b/src/openvpn/error=2Eh<=
/span><br><span>@@ -406,6 +406,11 @@</span><br><span> }</span><br><span> #e=
ndif</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#if defined(_WIN32) &amp;&amp; (defined(__GNUC__) || defined(__clang__))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnos=
tic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC=
 diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span> static inline int</span><br><span> openv=
pn_errno_maybe_crt(bool *crt_error)</span><br><span> {</span><br><span>@@ -=
426,6 +431,10 @@</span><br><span>     return err;</span><br><span> }</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defi=
ned(_WIN32) &amp;&amp; (defined(__GNUC__) || defined(__clang__))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #include &quot;err=
level=2Eh&quot;</span><br><span> </span><br><span> #endif /* ifndef ERROR_H=
 */</span><br><span>diff --git a/src/openvpn/event=2Ec b/src/openvpn/event=
=2Ec</span><br><span>index 5e17ea1=2E=2Ec4a856d 100644</span><br><span>--- =
a/src/openvpn/event=2Ec</span><br><span>+++ b/src/openvpn/event=2Ec</span><=
br><span>@@ -486,6 +486,11 @@</span><br><span> #endif</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if =
defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-con=
version&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> s=
tatic struct event_set *</span><br><span> we_init(int *maxevents, unsigned =
int flags)</span><br><span> {</span><br><span>@@ -524,8 +529,17 @@</span><b=
r><span>     return (struct event_set *)wes;</span><br><span> }</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(_=
_GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> #endif /* _WIN32 */</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(_=
_clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GC=
C diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#p=
ragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> #if EPOLL</span><br><span> </sp=
an><br><span> struct ep_set</span><br><span>@@ -1122,6 +1136,10 @@</span><b=
r><span> }</span><br><span> #endif /* SELECT */</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defi=
ned(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#prag=
ma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span> static struct event_set *</span><br><span> event_set_init_simple(int=
 *maxevents, unsigned int flags)</span><br><span> {</span><br><span>diff --=
git a/src/openvpn/fdmisc=2Ec b/src/openvpn/fdmisc=2Ec</span><br><span>index=
 6910f81=2E=2Ee715964 100644</span><br><span>--- a/src/openvpn/fdmisc=2Ec</=
span><br><span>+++ b/src/openvpn/fdmisc=2Ec</span><br><span>@@ -31,6 +31,11=
 @@</span><br><span> </span><br><span> #include &quot;memdbg=2Eh&quot;</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if de=
fined(_WIN32) &amp;&amp; (defined(__GNUC__) || defined(__clang__))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnost=
ic ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span> /* Set a file descriptor to non-blocking */</span=
><br><span> bool</span><br><span> set_nonblock_action(socket_descriptor_t f=
d)</span><br><span>@@ -50,6 +55,10 @@</span><br><span>     return true;</sp=
an><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#if defined(_WIN32) &amp;&amp; (defined(__GNUC__) || defined(=
__clang__))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma =
GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an> /* Set a file descriptor to not be passed across execs */</span><br><sp=
an> bool</span><br><span> set_cloexec_action(socket_descriptor_t fd)</span>=
<br><span>diff --git a/src/openvpn/fdmisc=2Eh b/src/openvpn/fdmisc=2Eh</spa=
n><br><span>index eac8075=2E=2E15ee3cd 100644</span><br><span>--- a/src/ope=
nvpn/fdmisc=2Eh</span><br><span>+++ b/src/openvpn/fdmisc=2Eh</span><br><spa=
n>@@ -35,6 +35,11 @@</span><br><span> </span><br><span> void set_cloexec(so=
cket_descriptor_t fd);</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic=
 ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> static inline void</span><br><span> openvpn_fd_set(=
socket_descriptor_t fd, fd_set *setp)</span><br><span> {</span><br><span>@@=
 -45,4 +50,8 @@</span><br><span> }</span><br><span> #undef FD_SET /* preven=
t direct use of FD_SET() */</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#endif        /* FD_MISC_H */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif /* FD_MISC_H */</span><br><span>di=
ff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec</span><br><spa=
n>index ba0e0ec=2E=2Eb4277db 100644</span><br><span>--- a/src/openvpn/forwa=
rd=2Ec</span><br><span>+++ b/src/openvpn/forward=2Ec</span><br><span>@@ -28=
6,6 +286,11 @@</span><br><span>     }</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__=
) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><spa=
n>  * Handle incoming configuration</span><br><span>  * messages on the con=
trol channel=2E</span><br><span>@@ -2025,6 +2030,10 @@</span><br><span>    =
 check_timeout_random_component(c);</span><br><span> }</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) =
|| defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span> void</span><br><span> multi_io_process_flags(struct context *=
c, struct event_set *es, struct link_socket *sock, const unsigned int flags=
)</span><br><span> {</span><br><span>diff --git a/src/openvpn/fragment=2Ec =
b/src/openvpn/fragment=2Ec</span><br><span>index c454434=2E=2E55f2a08 10064=
4</span><br><span>--- a/src/openvpn/fragment=2Ec</span><br><span>+++ b/src/=
openvpn/fragment=2Ec</span><br><span>@@ -40,6 +40,11 @@</span><br><span>   =
      goto error; \</span><br><span>     }</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(_=
_clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GC=
C diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#p=
ragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> static void</span><br><span> fr=
agment_list_buf_init(struct fragment_list *list, const struct frame *frame)=
</span><br><span> {</span><br><span>@@ -284,6 +289,10 @@</span><br><span>  =
   ASSERT(buf_write_prepend(buf, &amp;flags, sizeof(flags)));</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * Without chan=
ging the number of fragments, return a possibly smaller</span><br><span>  *=
 max fragment size that will allow for the last fragment to be of</span><br=
><span>diff --git a/src/openvpn/helper=2Ec b/src/openvpn/helper=2Ec</span><=
br><span>index 6b5fcee6=2E=2Ed9ddf6a 100644</span><br><span>--- a/src/openv=
pn/helper=2Ec</span><br><span>+++ b/src/openvpn/helper=2Ec</span><br><span>=
@@ -148,6 +148,11 @@</span><br><span> }</span><br><span> </span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC_=
_) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><sp=
an>  * Process server, server-bridge, and client helper</span><br><span>  *=
 directives after the parameters themselves have been</span><br><span>@@ -5=
07,6 +512,10 @@</span><br><span>     gc_free(&amp;gc);</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if=
 defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span> /*</span><br><span>  *</span><br><span>  *=
 HELPER DIRECTIVE:</span><br><span>diff --git a/src/openvpn/init=2Ec b/src/=
openvpn/init=2Ec</span><br><span>index 25521f3=2E=2Eea77f16 100644</span><b=
r><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=
=2Ec</span><br><span>@@ -102,6 +102,11 @@</span><br><span>     c-&gt;persis=
t =3D cpsave;</span><br><span> }</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnost=
ic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC =
diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> /*</span><br><span>  * Pass tunnel endpoi=
nt and MTU parms to a user-supplied script=2E</span><br><span>  * Used to e=
xecute the up/down script/plugins=2E</span><br><span>@@ -3664,6 +3669,10 @@=
</span><br><span>     c-&gt;c2=2Elink_socket_owned =3D true;</span><br><spa=
n> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * bind TCP/UDP =
sockets</span><br><span>  */</span><br><span>diff --git a/src/openvpn/lzo=
=2Ec b/src/openvpn/lzo=2Ec</span><br><span>index 51cf5e8=2E=2E2b0691b 10064=
4</span><br><span>--- a/src/openvpn/lzo=2Ec</span><br><span>+++ b/src/openv=
pn/lzo=2Ec</span><br><span>@@ -40,6 +40,11 @@</span><br><span> #include &qu=
ot;memdbg=2Eh&quot;</span><br><span> </span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clan=
g__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC dia=
gnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma=
 GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> static void</span><br><span> lzo_com=
press_init(struct compress_context *compctx)</span><br><span> {</span><br><=
span>@@ -120,6 +125,10 @@</span><br><span>     }</span><br><span> }</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defin=
ed(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span> const struct compress_alg lzo_alg =3D { &quot;lz=
o&quot;, lzo_compress_init, lzo_compress_uninit, lzo_compress,</span><br><s=
pan>                                       lzo_decompress };</span><br><spa=
n> #endif /* ENABLE_LZO */</span><br><span>diff --git a/src/openvpn/manage=
=2Ec b/src/openvpn/manage=2Ec</span><br><span>index 581e7be=2E=2E4809532 10=
0644</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src=
/openvpn/manage=2Ec</span><br><span>@@ -779,6 +779,11 @@</span><br><span>  =
   }</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnosti=
c ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span> static void</span><br><span> man_query_user_pass(s=
truct management *man, const char *type, const char *string, const bool nee=
ded,</span><br><span>                     const char *prompt, char *dest, i=
nt len)</span><br><span>@@ -804,6 +809,10 @@</span><br><span>     }</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> static void</span><br><span> =
man_query_username(struct management *man, const char *type, const char *st=
ring)</span><br><span> {</span><br><span>@@ -2473,6 +2482,11 @@</span><br><=
span> </span><br><span> #endif /* ifdef TARGET_ANDROID */</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC_=
_) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static ssize_t</=
span><br><span> man_read(struct management *man)</span><br><span> {</span><=
br><span>@@ -2611,6 +2625,10 @@</span><br><span>     return sent;</span><br=
><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> static void</span><br><span> =
man_connection_clear(struct man_connection *mc)</span><br><span> {</span><b=
r><span>@@ -2682,6 +2700,11 @@</span><br><span>     CLEAR(*mp);</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;=
-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span> static void</span><br><span> man_settings_init(struct man_settings=
 *ms, const char *addr, const char *port,</span><br><span>                 =
  const char *pass_file, const char *client_user, const char *client_group,=
</span><br><span>@@ -3297,6 +3320,10 @@</span><br><span>     return true;</=
span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #ifdef _WIN32</span><br=
><span> </span><br><span> void</span><br><span>@@ -3606,6 +3633,11 @@</span=
><br><span>     }</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang=
__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diag=
nostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma =
GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * Process the m=
anagement event loop for sec seconds</span><br><span>  */</span><br><span>@=
@ -4341,6 +4373,10 @@</span><br><span>     }</span><br><span> }</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(_=
_GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> void</span><br><span> management_check_bytecount_cli=
ent(struct context *c, struct management *man, struct timeval *timeval)</sp=
an><br><span> {</span><br><span>@@ -4475,6 +4511,12 @@</span><br><span> #el=
se /* ifdef ENABLE_MANAGEMENT */</span><br><span> </span><br><span> #includ=
e &quot;win32=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if !defined(_W=
IN32) &amp;&amp; (defined(__GNUC__) || defined(__clang__))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignor=
ed &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span> void</span><br><span> management_sleep(const int n)</span=
><br><span> {</span><br><span>@@ -4488,4 +4530,8 @@</span><br><span> #endif=
 /* ifdef _WIN32 */</span><br><span> }</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#if !defined(_WIN32) &amp;&amp; (defin=
ed(__GNUC__) || defined(__clang__))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> #endif /* ENABLE_MANAGEMENT */</span><br><span>=
diff --git a/src/openvpn/misc=2Ec b/src/openvpn/misc=2Ec</span><br><span>in=
dex 8c9ad08=2E=2E9a307a2 100644</span><br><span>--- a/src/openvpn/misc=2Ec<=
/span><br><span>+++ b/src/openvpn/misc=2Ec</span><br><span>@@ -72,6 +72,11 =
@@</span><br><span> #endif</span><br><span> }</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || define=
d(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma=
 GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span> #ifdef ENABLE_MANAGEMENT</sp=
an><br><span> /* Get username/password from the management interface */</sp=
an><br><span> static bool</span><br><span>@@ -762,6 +767,10 @@</span><br><s=
pan>     return (state =3D=3D 2);</span><br><span> }</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) ||=
 defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span> void</span><br><span> output_peer_info_env(struct env_set *es, =
const char *peer_info)</span><br><span> {</span><br><span>diff --git a/src/=
openvpn/mss=2Ec b/src/openvpn/mss=2Ec</span><br><span>index 0cfa272d=2E=2E5=
bc94d9 100644</span><br><span>--- a/src/openvpn/mss=2Ec</span><br><span>+++=
 b/src/openvpn/mss=2Ec</span><br><span>@@ -194,6 +194,11 @@</span><br><span=
>     }</span><br><span> }</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pus=
h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagno=
stic ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> static inline size_t</span><br><span> adjust_pa=
yload_max_cbc(const struct key_type *kt, size_t target)</span><br><span> {<=
/span><br><span>@@ -313,6 +318,10 @@</span><br><span>     frame-&gt;mss_fix=
 =3D (uint16_t)(adjust_payload_max_cbc(kt, target) - payload_overhead);</sp=
an><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void</span><br><span> f=
rame_calculate_dynamic(struct frame *frame, const struct key_type *kt, cons=
t struct options *options,</span><br><span>                         const s=
truct link_socket_info *lsi)</span><br><span>diff --git a/src/openvpn/mtcp=
=2Ec b/src/openvpn/mtcp=2Ec</span><br><span>index 2d0af06=2E=2Efc5b657 1006=
44</span><br><span>--- a/src/openvpn/mtcp=2Ec</span><br><span>+++ b/src/ope=
nvpn/mtcp=2Ec</span><br><span>@@ -37,6 +37,11 @@</span><br><span> #include =
&lt;sys/inotify=2Eh&gt;</span><br><span> #endif</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defi=
ned(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#prag=
ma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span> struct multi_instance *</s=
pan><br><span> multi_create_instance_tcp(struct multi_context *m, struct li=
nk_socket *sock)</span><br><span> {</span><br><span>@@ -88,6 +93,10 @@</spa=
n><br><span>     return true;</span><br><span> }</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || def=
ined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pra=
gma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> void</span><br><span> multi_tcp_instance_specific_free(struct multi=
_instance *mi)</span><br><span> {</span><br><span>diff --git a/src/openvpn/=
mtu=2Ec b/src/openvpn/mtu=2Ec</span><br><span>index 5ce40c8=2E=2E7892935 10=
0644</span><br><span>--- a/src/openvpn/mtu=2Ec</span><br><span>+++ b/src/op=
envpn/mtu=2Ec</span><br><span>@@ -37,6 +37,11 @@</span><br><span> #include =
&quot;memdbg=2Eh&quot;</span><br><span> #include &quot;ssl_common=2Eh&quot;=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-=
conversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#en=
dif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
> /* allocate a buffer for socket or tun layer */</span><br><span> void</sp=
an><br><span> alloc_buf_sock_tun(struct buffer *buf, const struct frame *fr=
ame)</span><br><span>@@ -383,6 +388,10 @@</span><br><span>     return BSTR(=
&amp;out);</span><br><span> }</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic =
pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void</span>=
<br><span> set_sock_extended_error_passing(int sd, sa_family_t proto_af)</s=
pan><br><span> {</span><br><span>diff --git a/src/openvpn/multi=2Ec b/src/o=
penvpn/multi=2Ec</span><br><span>index bcaa012=2E=2E0890480 100644</span><b=
r><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=
=2Ec</span><br><span>@@ -247,6 +247,11 @@</span><br><span> </span><br><span=
> #endif</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot=
;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> #ifdef ENABLE_ASYNC_PUSH</span><br><span> static uint64_t</span><=
br><span> /*</span><br><span>@@ -4555,3 +4560,7 @@</span><br><span>     ret=
urn (!ipv6_net_contains_host(&amp;ifconfig_local, o-&gt;ifconfig_ipv6_netbi=
ts,</span><br><span>                                     dest));</span><br>=
<span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defin=
ed(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragm=
a GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#endif</span><br><span>diff --git a/src/openvpn/multi_io=2Ec b/src/openvpn=
/multi_io=2Ec</span><br><span>index fb4810b=2E=2Ee07b691 100644</span><br><=
span>--- a/src/openvpn/multi_io=2Ec</span><br><span>+++ b/src/openvpn/multi=
_io=2Ec</span><br><span>@@ -104,6 +104,11 @@</span><br><span>     }</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &q=
uot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> struct multi_io *</span><br><span> multi_io_init(const int max=
clients)</span><br><span> {</span><br><span>@@ -121,6 +126,10 @@</span><br>=
<span>     return multi_io;</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defin=
ed(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragm=
a GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span> void</span><br><span> multi_io_free(struct multi_io *multi_io)</span>=
<br><span> {</span><br><span>diff --git a/src/openvpn/networking_sitnl=2Ec =
b/src/openvpn/networking_sitnl=2Ec</span><br><span>index eafb9f7=2E=2Ed5ec6=
bb 100644</span><br><span>--- a/src/openvpn/networking_sitnl=2Ec</span><br>=
<span>+++ b/src/openvpn/networking_sitnl=2Ec</span><br><span>@@ -243,6 +243=
,11 @@</span><br><span>     return 0;</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__=
) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><sp=
an>  * Send Netlink message and run callback on reply (if specified)</span>=
<br><span>  */</span><br><span>@@ -1510,6 +1515,10 @@</span><br><span>     =
return sitnl_send(&amp;req=2En, 0, 0, NULL, NULL);</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if def=
ined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span> #endif /* !ENABLE_SITNL */</span><br><span> </=
span><br><span> #endif /* TARGET_LINUX */</span><br><span>diff --git a/src/=
openvpn/occ=2Ec b/src/openvpn/occ=2Ec</span><br><span>index f25ae19=2E=2E38=
685f5 100644</span><br><span>--- a/src/openvpn/occ=2Ec</span><br><span>+++ =
b/src/openvpn/occ=2Ec</span><br><span>@@ -177,6 +177,7 @@</span><br><span> =
#if defined(__GNUC__) || defined(__clang__)</span><br><span> #pragma GCC di=
agnostic push</span><br><span> #pragma GCC diagnostic ignored &quot;-Wconve=
rsion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma =
GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span> #endi=
f</span><br><span> </span><br><span> void</span><br><span>@@ -352,10 +353,6=
 @@</span><br><span>     c-&gt;c2=2Eocc_op =3D -1;</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defin=
ed(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span> void</span><br><span> process_received_occ_msg(struct =
context *c)</span><br><span> {</span><br><span>@@ -426,3 +423,7 @@</span><b=
r><span>     }</span><br><span>     c-&gt;c2=2Ebuf=2Elen =3D 0; /* don&#39;=
t pass packet on */</span><br><span> }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#endif</span><br><span>diff --git a/src/open=
vpn/openvpn=2Ec b/src/openvpn/openvpn=2Ec</span><br><span>index b32f009=2E=
=2E9f0f50c 100644</span><br><span>--- a/src/openvpn/openvpn=2Ec</span><br><=
span>+++ b/src/openvpn/openvpn=2Ec</span><br><span>@@ -351,6 +351,12 @@</sp=
an><br><span> }</span><br><span> </span><br><span> #ifdef _WIN32</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pu=
sh</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span> int</span><br><span> wmain(int argc, wchar_t *=
wargv[])</span><br><span> {</span><br><span>@@ -394,6 +400,11 @@</span><br>=
<span> </span><br><span>     return ret;</span><br><span> }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #else  /* ifdef _W=
IN32 */</span><br><span> int</span><br><span> main(int argc, char *argv[])<=
/span><br><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=
=2Ec</span><br><span>index 9ed3964=2E=2E1d8bb2a 100644</span><br><span>--- =
a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</sp=
an><br><span>@@ -945,6 +945,11 @@</span><br><span>     setenv_str_i(es, &qu=
ot;local_port&quot;, e-&gt;port, i);</span><br><span> }</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__)=
 || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void</span><br><sp=
an> setenv_settings(struct env_set *es, const struct options *o)</span><br>=
<span> {</span><br><span>@@ -7872,6 +7877,7 @@</span><br><span> </span><br>=
<span> #if defined(__GNUC__) || defined(__clang__)</span><br><span> #pragma=
 GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#pragma GCC diagnostic pop</span><br><span> #endif</span><br><span> </span>=
<br><span> bool</span><br><span>diff --git a/src/openvpn/options_parse=2Ec =
b/src/openvpn/options_parse=2Ec</span><br><span>index 5d6f93e=2E=2E0a5eae5 =
100644</span><br><span>--- a/src/openvpn/options_parse=2Ec</span><br><span>=
+++ b/src/openvpn/options_parse=2Ec</span><br><span>@@ -234,6 +234,11 @@</s=
pan><br><span>     } u;</span><br><span> };</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(=
__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma G=
CC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span> static bool</span><br><span> i=
n_src_get(const struct in_src *is, char *line, const int size)</span><br><s=
pan> {</span><br><span>@@ -298,6 +303,10 @@</span><br><span>     return ret=
;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static int</span><br=
><span> check_inline_file(const struct in_src *is, char *p[], struct gc_are=
na *gc)</span><br><span> {</span><br><span>diff --git a/src/openvpn/options=
_show=2Ec b/src/openvpn/options_show=2Ec</span><br><span>index 54f9c4c=2E=
=2Eaf9321d 100644</span><br><span>--- a/src/openvpn/options_show=2Ec</span>=
<br><span>+++ b/src/openvpn/options_show=2Ec</span><br><span>@@ -341,6 +341=
,11 @@</span><br><span>     }</span><br><span> }</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || def=
ined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pra=
gma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void</span><br><span> s=
how_settings(const struct options *o)</span><br><span> {</span><br><span>@@=
 -628,4 +633,8 @@</span><br><span> #endif</span><br><span> }</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GN=
UC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span> #endif /* ifndef ENABLE_SMALL */</span><br><span>diff -=
-git a/src/openvpn/options_string=2Ec b/src/openvpn/options_string=2Ec</spa=
n><br><span>index 4a43fce4=2E=2E4fe34bf 100644</span><br><span>--- a/src/op=
envpn/options_string=2Ec</span><br><span>+++ b/src/openvpn/options_string=
=2Ec</span><br><span>@@ -380,6 +380,7 @@</span><br><span> #if defined(__GNU=
C__) || defined(__clang__)</span><br><span> #pragma GCC diagnostic push</sp=
an><br><span> #pragma GCC diagnostic ignored &quot;-Wsign-compare&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic =
ignored &quot;-Wsign-conversion&quot;</span><br><span> #endif</span><br><sp=
an> </span><br><span> char *</span><br><span>diff --git a/src/openvpn/optio=
ns_util=2Ec b/src/openvpn/options_util=2Ec</span><br><span>index d25d85c=2E=
=2E23fdac7 100644</span><br><span>--- a/src/openvpn/options_util=2Ec</span>=
<br><span>+++ b/src/openvpn/options_util=2Ec</span><br><span>@@ -211,6 +211=
,11 @@</span><br><span>                                            &quot;ro=
ute-metric&quot;, &quot;topology&quot;,</span><br><span>                   =
                         &quot;tun-mtu&quot;, &quot;keepalive&quot; };</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if de=
fined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conve=
rsion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> boo=
l</span><br><span> check_push_update_option_flags(char *line, int *i, uint6=
4_t *flags)</span><br><span> {</span><br><span>@@ -273,6 +278,10 @@</span><=
br><span>     return true;</span><br><span> }</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || define=
d(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma=
 GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan> bool</span><br><span> apply_pull_filter(const struct options *o, char =
*line)</span><br><span> {</span><br><span>diff --git a/src/openvpn/packet_i=
d=2Ec b/src/openvpn/packet_id=2Ec</span><br><span>index f1fadd6=2E=2E48e37d=
b 100644</span><br><span>--- a/src/openvpn/packet_id=2Ec</span><br><span>++=
+ b/src/openvpn/packet_id=2Ec</span><br><span>@@ -71,6 +71,11 @@</span><br>=
<span> #endif</span><br><span> }</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnost=
ic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC =
diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> static void</span><br><span> packet_id_in=
it_recv(struct packet_id_rec *rec, int seq_backtrack, int time_backtrack,</=
span><br><span>                     const char *name, int unit)</span><br><=
span>@@ -175,6 +180,10 @@</span><br><span>     }</span><br><span> }</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defin=
ed(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span> /*</span><br><span>  * Expire sequence numbers w=
hich can no longer</span><br><span>  * be accepted because they would viola=
te</span><br><span>diff --git a/src/openvpn/ping=2Ec b/src/openvpn/ping=2Ec=
</span><br><span>index 526e64c=2E=2Ebbacd20 100644</span><br><span>--- a/sr=
c/openvpn/ping=2Ec</span><br><span>+++ b/src/openvpn/ping=2Ec</span><br><sp=
an>@@ -64,6 +64,11 @@</span><br><span>     gc_free(&amp;gc);</span><br><spa=
n> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Ws=
ign-conversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span> /*</span><br><span>  * Should we ping the remote?</span><br><span>  *=
/</span><br><span>@@ -84,3 +89,7 @@</span><br><span>     c-&gt;c2=2Ebuf=2El=
en =3D 0;</span><br><span>     dmsg(D_PING, &quot;SENT PING&quot;);</span><=
br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || de=
fined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pr=
agma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#endif</span><br><span>diff --git a/src/openvpn/pkcs11=2Ec b/src/openvp=
n/pkcs11=2Ec</span><br><span>index f00ba9b=2E=2Eb4bed12 100644</span><br><s=
pan>--- a/src/openvpn/pkcs11=2Ec</span><br><span>+++ b/src/openvpn/pkcs11=
=2Ec</span><br><span>@@ -54,6 +54,11 @@</span><br><span> }</span><br><span>=
 #endif</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;=
-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span> static void</span><br><span> __mysleep(unsigned long usec)</span><=
br><span> {</span><br><span>@@ -812,4 +817,9 @@</span><br><span>     pkcs11=
h_terminate();</span><br><span>     gc_free(&amp;gc);</span><br><span> }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endi=
f /* ENABLE_PKCS11 */</span><br><span>diff --git a/src/openvpn/pkcs11_opens=
sl=2Ec b/src/openvpn/pkcs11_openssl=2Ec</span><br><span>index 8abd60a=2E=2E=
c5974fce 100644</span><br><span>--- a/src/openvpn/pkcs11_openssl=2Ec</span>=
<br><span>+++ b/src/openvpn/pkcs11_openssl=2Ec</span><br><span>@@ -130,6 +1=
30,11 @@</span><br><span>     return ret;</span><br><span> }</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GN=
UC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br=
><span>  * Sign op called from xkey provider</span><br><span>  *</span><br>=
<span>@@ -230,6 +235,10 @@</span><br><span>     return 1;</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span> /* wrapper for handle free */</span><br=
><span> static void</span><br><span> xkey_handle_free(void *handle)</span><=
br><span>diff --git a/src/openvpn/platform=2Ec b/src/openvpn/platform=2Ec</=
span><br><span>index 9412eeb=2E=2Ee10161f 100644</span><br><span>--- a/src/=
openvpn/platform=2Ec</span><br><span>+++ b/src/openvpn/platform=2Ec</span><=
br><span>@@ -76,6 +76,11 @@</span><br><span> </span><br><span> /* Get/Set U=
ID of process */</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignor=
ed &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span> bool</span><br><span> platform_user_get(const char *usern=
ame, struct platform_state_user *state)</span><br><span> {</span><br><span>=
@@ -658,6 +663,10 @@</span><br><span>     }</span><br><span> }</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__=
GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span> bool</span><br><span> platform_absolute_pathname(cons=
t char *pathname)</span><br><span> {</span><br><span>diff --git a/src/openv=
pn/plugin=2Ec b/src/openvpn/plugin=2Ec</span><br><span>index d1f228e=2E=2E2=
872265 100644</span><br><span>--- a/src/openvpn/plugin=2Ec</span><br><span>=
+++ b/src/openvpn/plugin=2Ec</span><br><span>@@ -463,6 +463,11 @@</span><br=
><span> #define _OPENVPN_PATCH_LEVEL &quot;git:&quot; CONFIGURE_GIT_REVISIO=
N CONFIGURE_GIT_FLAGS</span><br><span> #endif</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || define=
d(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma=
 GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span> static void</span><br><span>=
 plugin_open_item(struct plugin *p, const struct plugin_option *o,</span><b=
r><span>                  struct openvpn_plugin_string_list **retlist, cons=
t char **envp,</span><br><span>@@ -545,6 +550,10 @@</span><br><span>     }<=
/span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static int</span><br><=
span> plugin_call_item(const struct plugin *p, void *per_client_context, co=
nst int type,</span><br><span>                  const struct argv *av, stru=
ct openvpn_plugin_string_list **retlist,</span><br><span>diff --git a/src/o=
penvpn/pool=2Ec b/src/openvpn/pool=2Ec</span><br><span>index fff0e3f=2E=2E0=
16f3a8 100644</span><br><span>--- a/src/openvpn/pool=2Ec</span><br><span>++=
+ b/src/openvpn/pool=2Ec</span><br><span>@@ -137,6 +137,11 @@</span><br><sp=
an>     return ret;</span><br><span> }</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__cla=
ng__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC di=
agnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragm=
a GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> struct ifconfig_pool *</span><br><s=
pan> ifconfig_pool_init(const bool ipv4_pool, enum pool_type type, in_addr_=
t start, in_addr_t end,</span><br><span>                    const bool dupl=
icate_cn, const bool ipv6_pool, const struct in6_addr ipv6_base,</span><br>=
<span>@@ -708,6 +713,10 @@</span><br><span>     }</span><br><span> }</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defi=
ned(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> void</span><br><span> ifconfig_pool_write(struc=
t ifconfig_pool_persist *persist, const struct ifconfig_pool *pool)</span><=
br><span> {</span><br><span>diff --git a/src/openvpn/proxy=2Ec b/src/openvp=
n/proxy=2Ec</span><br><span>index 7b5a289=2E=2Ecd9f3b2 100644</span><br><sp=
an>--- a/src/openvpn/proxy=2Ec</span><br><span>+++ b/src/openvpn/proxy=2Ec<=
/span><br><span>@@ -53,6 +53,11 @@</span><br><span> }</span><br><span> </sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if d=
efined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conv=
ersion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*=
 cached proxy username/password */</span><br><span> static struct user_pass=
 static_proxy_user_pass;</span><br><span> </span><br><span>@@ -288,6 +293,1=
0 @@</span><br><span>     p-&gt;up =3D static_proxy_user_pass; /* this is a=
 copy of protected memory */</span><br><span> }</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defi=
ned(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#prag=
ma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span> #if 0</span><br><span> /* function only used in #if 0 debug statemen=
t */</span><br><span> static void</span><br><span>diff --git a/src/openvpn/=
ps=2Ec b/src/openvpn/ps=2Ec</span><br><span>index f8cfe1c5=2E=2E86b4fc9 100=
644</span><br><span>--- a/src/openvpn/ps=2Ec</span><br><span>+++ b/src/open=
vpn/ps=2Ec</span><br><span>@@ -165,6 +165,11 @@</span><br><span>     return=
 CMSG_SPACE(sizeof(socket_descriptor_t));</span><br><span> }</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GN=
UC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br>=
<span>  * Send a command (char), data (head), and a file descriptor (sd_sen=
d) to a local process</span><br><span>  * over unix socket sd=2E  Unfortuna=
tely, there&#39;s no portable way to send file descriptors</span><br><span>=
@@ -618,6 +623,10 @@</span><br><span>     return IOSTAT_GOOD;</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * Forward data=
 from pc to pc-&gt;counterpart=2E</span><br><span>  */</span><br><span>diff=
 --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec</span><br><span>index =
a18f33b=2E=2E6f628b8 100644</span><br><span>--- a/src/openvpn/push=2Ec</spa=
n><br><span>+++ b/src/openvpn/push=2Ec</span><br><span>@@ -389,6 +389,11 @@=
</span><br><span>     }</span><br><span> }</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(_=
_clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GC=
C diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#p=
ragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> void</span><br><span> receive_a=
uth_pending(struct context *c, const struct buffer *buffer)</span><br><span=
> {</span><br><span>@@ -795,6 +800,10 @@</span><br><span>     }</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> static bool</span><br><span> send=
_push_options(struct context *c, struct buffer *buf, struct push_list *push=
_list, int safe_cap,</span><br><span>                   bool *push_sent, bo=
ol *multi_push)</span><br><span>diff --git a/src/openvpn/reliable=2Ec b/src=
/openvpn/reliable=2Ec</span><br><span>index 7b5b17c=2E=2Eb045b1f 100644</sp=
an><br><span>--- a/src/openvpn/reliable=2Ec</span><br><span>+++ b/src/openv=
pn/reliable=2Ec</span><br><span>@@ -311,6 +311,11 @@</span><br><span>  * st=
ruct reliable member functions=2E</span><br><span>  */</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) =
|| defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void</span><br><spa=
n> reliable_init(struct reliable *rel, int buf_size, int offset, int array_=
size, bool hold)</span><br><span> {</span><br><span>@@ -780,6 +785,10 @@</s=
pan><br><span>     ASSERT(0); /* buf not found in rel */</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span> /*</span><br><span>  * Enable an outgoin=
g buffer previously returned by a get function as active=2E</span><br><span=
>  */</span><br><span>diff --git a/src/openvpn/route=2Ec b/src/openvpn/rout=
e=2Ec</span><br><span>index 449b4f1=2E=2Efa569fa 100644</span><br><span>---=
 a/src/openvpn/route=2Ec</span><br><span>+++ b/src/openvpn/route=2Ec</span>=
<br><span>@@ -582,6 +582,11 @@</span><br><span>     }</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if =
defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-con=
version&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> b=
ool</span><br><span> block_local_needed(const struct route_list *rl)</span>=
<br><span> {</span><br><span>@@ -3217,6 +3222,10 @@</span><br><span>     }<=
/span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* IPv6 implementation=
 using netlink</span><br><span>  * https://www=2Elinuxjournal=2Ecom/article=
/7356 - &quot;Kernel Korner - Why and How to Use Netlink Socket&quot;</span=
><br><span>  * netlink(3), netlink(7), rtnetlink(7)</span><br><span>diff --=
git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec</span><br><span>index=
 1fbd07b=2E=2Ec07ef60 100644</span><br><span>--- a/src/openvpn/socket=2Ec</=
span><br><span>+++ b/src/openvpn/socket=2Ec</span><br><span>@@ -422,6 +422,=
11 @@</span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(_=
_GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> socket_des=
criptor_t</span><br><span> socket_do_accept(socket_descriptor_t sd, struct =
link_socket_actual *act, const bool nowait)</span><br><span> {</span><br><s=
pan>@@ -2084,6 +2089,10 @@</span><br><span>     return buf-&gt;len;</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> #endif /* ifndef _WIN32 */</s=
pan><br><span> </span><br><span> /*</span><br><span>diff --git a/src/openvp=
n/socket=2Eh b/src/openvpn/socket=2Eh</span><br><span>index 52e09c9=2E=2E22=
10bfe 100644</span><br><span>--- a/src/openvpn/socket=2Eh</span><br><span>+=
++ b/src/openvpn/socket=2Eh</span><br><span>@@ -288,12 +288,21 @@</span><br=
><span>     return sh=2Eis_handle ? (int)GetLastError() : WSAGetLastError()=
;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic i=
gnored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span> inline static void</span><br><span> SocketHandleSetLa=
stError(sockethandle_t sh, DWORD err)</span><br><span> {</span><br><span>  =
   sh=2Eis_handle ? SetLastError(err) : WSASetLastError(err);</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> static inline void</span><br><span>=
 SocketHandleSetInvalError(sockethandle_t sh)</span><br><span> {</span><br>=
<span>@@ -459,6 +468,11 @@</span><br><span> </span><br><span> #endif /* if =
PORT_SHARE */</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored =
&quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span> static inline bool</span><br><span> socket_connection_reset(=
const struct link_socket *sock, ssize_t status)</span><br><span> {</span><b=
r><span>@@ -482,6 +496,10 @@</span><br><span>     return false;</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> static inline bool</span><br><spa=
n> link_socket_verify_incoming_addr(const struct buffer *buf, const struct =
link_socket_info *info,</span><br><span>                                  c=
onst struct link_socket_actual *from_addr)</span><br><span>@@ -649,6 +667,1=
1 @@</span><br><span> ssize_t link_socket_write_tcp(struct link_socket *soc=
k, struct buffer *buf,</span><br><span>                               struc=
t link_socket_actual *to);</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pus=
h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagno=
stic ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> #ifdef _WIN32</span><br><span> </span><br><span=
> static inline int</span><br><span>@@ -721,6 +744,10 @@</span><br><span> <=
/span><br><span> #endif /* ifdef _WIN32 */</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(_=
_clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GC=
C diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#en=
dif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
> static inline ssize_t</span><br><span> link_socket_write_udp(struct link_=
socket *sock, struct buffer *buf, struct link_socket_actual *to)</span><br>=
<span> {</span><br><span>diff --git a/src/openvpn/socket_util=2Ec b/src/ope=
nvpn/socket_util=2Ec</span><br><span>index 879be73=2E=2Ea049f33 100644</spa=
n><br><span>--- a/src/openvpn/socket_util=2Ec</span><br><span>+++ b/src/ope=
nvpn/socket_util=2Ec</span><br><span>@@ -123,6 +123,11 @@</span><br><span> =
#define IF_NAMESIZE 16</span><br><span> #endif</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defin=
ed(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragm=
a GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span> const char *</span><br><spa=
n> print_link_socket_actual_ex(const struct link_socket_actual *act, const =
char *separator,</span><br><span>                             const unsigne=
d int flags, struct gc_arena *gc)</span><br><span>@@ -188,6 +193,10 @@</spa=
n><br><span>     }</span><br><span> }</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clan=
g__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC dia=
gnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*<=
/span><br><span>  * Convert an in_addr_t in host byte order</span><br><span=
>  * to an ascii dotted quad=2E</span><br><span>diff --git a/src/openvpn/so=
cks=2Ec b/src/openvpn/socks=2Ec</span><br><span>index a8c9fd3=2E=2E51e3a1e =
100644</span><br><span>--- a/src/openvpn/socks=2Ec</span><br><span>+++ b/sr=
c/openvpn/socks=2Ec</span><br><span>@@ -226,6 +226,11 @@</span><br><span>  =
   return true;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma G=
CC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> static bool</span><br><span> recv_so=
cks_reply(socket_descriptor_t sd, struct openvpn_sockaddr *addr,</span><br>=
<span>                  const struct event_timeout *server_poll_timeout, vo=
latile int *signal_received)</span><br><span>@@ -310,6 +315,10 @@</span><br=
><span>     return true;</span><br><span> }</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(=
__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma G=
CC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#e=
ndif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n> static int</span><br><span> port_from_servname(const char *servname)</sp=
an><br><span> {</span><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/open=
vpn/ssl=2Ec</span><br><span>index 7721b55=2E=2E00e1712 100644</span><br><sp=
an>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</spa=
n><br><span>@@ -152,6 +152,11 @@</span><br><span>     return limit;</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &q=
uot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> void</span><br><span> tls_init_control_channel_frame_parameter=
s(struct frame *frame, int tls_mtu)</span><br><span> {</span><br><span>@@ -=
236,6 +241,10 @@</span><br><span>     return overhead;</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if=
 defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span> void</span><br><span> init_ssl_lib(void)</=
span><br><span> {</span><br><span>@@ -797,6 +806,11 @@</span><br><span>    =
 return false;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma G=
CC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> /** @addtogroup control_processor</s=
pan><br><span>  *  @{ */</span><br><span> </span><br><span>@@ -1043,6 +1057=
,10 @@</span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(=
__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> /**</span><br><span>  * Clean up a \c tls_session s=
tructure=2E</span><br><span>  * @ingroup control_processor</span><br><span>=
@@ -1325,6 +1343,11 @@</span><br><span>     key_source_print(&amp;k-&gt;ser=
ver, &quot;Server&quot;);</span><br><span> }</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined=
(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma =
GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> static bool</span><br><span> =
openvpn_PRF(const uint8_t *secret, size_t secret_len, const char *label, co=
nst uint8_t *client_seed,</span><br><span>             size_t client_seed_l=
en, const uint8_t *server_seed, size_t server_seed_len,</span><br><span>@@ =
-4550,3 +4573,7 @@</span><br><span> done:</span><br><span>     return BSTR(=
&amp;out);</span><br><span> }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defin=
ed(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif</span><br><span>diff --git a/src/openvpn/ssl_m=
bedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>index 45d7715=2E=
=2Ecbc3118 100644</span><br><span>--- a/src/openvpn/ssl_mbedtls=2Ec</span><=
br><span>+++ b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>@@ -199,6 +199,1=
1 @@</span><br><span>         ciphers);</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC=
__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void</span><br>=
<span> tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphe=
rs)</span><br><span> {</span><br><span>@@ -1187,6 +1192,10 @@</span><br><sp=
an>     return 1;</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang=
__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diag=
nostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* *=
*************************************</span><br><span>  *</span><br><span> =
 * Information functions</span><br><span>diff --git a/src/openvpn/ssl_ncp=
=2Ec b/src/openvpn/ssl_ncp=2Ec</span><br><span>index f13f507=2E=2Edf9e42c 1=
00644</span><br><span>--- a/src/openvpn/ssl_ncp=2Ec</span><br><span>+++ b/s=
rc/openvpn/ssl_ncp=2Ec</span><br><span>@@ -393,6 +393,11 @@</span><br><span=
>     return ret;</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang=
__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diag=
nostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma =
GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> static void</span><br><span> p2p_ncp=
_set_options(struct tls_multi *multi, struct tls_session *session, const ch=
ar *common_cipher)</span><br><span> {</span><br><span>@@ -576,6 +581,10 @@<=
/span><br><span>     o-&gt;ncp_ciphers =3D (char *)ncp_ciphers;</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  * Checks fo=
r availibility of Chacha20-Poly1305 and sets</span><br><span>  * the ncp_ci=
pher to either AES-256-GCM:AES-128-GCM or</span><br><span>diff --git a/src/=
openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec</span><br><span>index=
 fe2bfda=2E=2E035cfb8 100644</span><br><span>--- a/src/openvpn/ssl_openssl=
=2Ec</span><br><span>+++ b/src/openvpn/ssl_openssl=2Ec</span><br><span>@@ -=
277,7 +277,14 @@</span><br><span>     sslopt |=3D SSL_OP_NO_RENEGOTIATION;<=
/span><br><span> #endif</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#if defined(LIBRESSL_VERSION_NUMBER) &amp;&amp; (defi=
ned(__GNUC__) || defined(__clang__))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conver=
sion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</s=
pan><br><span>     SSL_CTX_set_options(ctx-&gt;ctx, sslopt);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#if defined(LIBRESSL_VERSION_NUMBE=
R) &amp;&amp; (defined(__GNUC__) || defined(__clang__))</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><=
br><span>     if (!tls_ctx_set_tls_versions(ctx, ssl_flags))</span><br><spa=
n>     {</span><br><span>@@ -511,6 +518,11 @@</span><br><span> {</span><br>=
<span>     ASSERT(ctx);</span><br><span> #if OPENSSL_VERSION_NUMBER &lt; 0x=
30000000L &amp;&amp; !defined(ENABLE_CRYPTO_WOLFSSL)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma G=
CC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span>     struct gc_arena gc =3D gc_new();=
</span><br><span>     /* This method could be as easy as</span><br><span>  =
    *  SSL_CTX_set1_groups_list(ctx-&gt;ctx, groups)</span><br><span>@@ -55=
6,6 +568,10 @@</span><br><span>         crypto_msg(M_FATAL, &quot;Failed to=
 set allowed TLS group list: %s&quot;, groups);</span><br><span>     }</spa=
n><br><span>     gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if =
defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#endif</span><br><span> #else  /* if OPENSSL_VER=
SION_NUMBER &lt; 0x30000000L */</span><br><span>     if (!SSL_CTX_set1_grou=
ps_list(ctx-&gt;ctx, groups))</span><br><span>     {</span><br><span>@@ -14=
66,6 +1482,11 @@</span><br><span>     }</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC=
__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><=
span>  * Pass the input hash in &#39;dgst&#39; to management and get the si=
gnature back=2E</span><br><span>  *</span><br><span>@@ -1710,6 +1731,11 @@<=
/span><br><span>     return 0;</span><br><span> }</span><br><span> #endif /=
* !defined(OPENSSL_NO_EC) */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if define=
d(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span> #endif /* ENABLE_MANAGEMENT &amp;&amp; !HAVE_XKEY=
_PROVIDER */</span><br><span> </span><br><span> #ifdef ENABLE_MANAGEMENT</s=
pan><br><span>@@ -2099,6 +2125,11 @@</span><br><span>  * to BIOs=2E</span><=
br><span>  */</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored =
&quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span> static void</span><br><span> bio_write_post(const int status=
, struct buffer *buf)</span><br><span> {</span><br><span>@@ -2110,6 +2141,1=
0 @@</span><br><span>     }</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defin=
ed(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragm=
a GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span> /*</span><br><span>  * Read from an OpenSSL BIO in non-blocking mode=
=2E</span><br><span>  */</span><br><span>diff --git a/src/openvpn/ssl_pkt=
=2Ec b/src/openvpn/ssl_pkt=2Ec</span><br><span>index f78782f=2E=2E60573ee 1=
00644</span><br><span>--- a/src/openvpn/ssl_pkt=2Ec</span><br><span>+++ b/s=
rc/openvpn/ssl_pkt=2Ec</span><br><span>@@ -40,6 +40,11 @@</span><br><span> =
 */</span><br><span> #define SWAP_BUF_SIZE 256</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defin=
ed(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragm=
a GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  * Mov=
e a packet authentication HMAC + related fields to or from the front</span>=
<br><span>  * of the buffer so it can be processed by encrypt/decrypt=2E</s=
pan><br><span>@@ -591,3 +596,7 @@</span><br><span>     buf_advance(buf, cmd=
len);</span><br><span>     return cmdbuf;</span><br><span> }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span=
>diff --git a/src/openvpn/ssl_util=2Ec b/src/openvpn/ssl_util=2Ec</span><br=
><span>index ba185c1=2E=2E337faed 100644</span><br><span>--- a/src/openvpn/=
ssl_util=2Ec</span><br><span>+++ b/src/openvpn/ssl_util=2Ec</span><br><span=
>@@ -86,6 +86,10 @@</span><br><span>     return var_value;</span><br><span>=
 }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsi=
gn-conversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#endif</span><br><span> </span><br><span> unsigned int</span><br><span> pee=
r_info_extract_int(const char *peer_info, const char *field, const char *fo=
rmat, unsigned int default_value)</span><br><span>@@ -166,6 +170,10 @@</spa=
n><br><span>     return BSTR(&amp;buf);</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC=
__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span> /**</span><br><span>  * SSL/TLS Cipher suite name transla=
tion table</span><br><span>  */</span><br><span>diff --git a/src/openvpn/ss=
l_verify=2Ec b/src/openvpn/ssl_verify=2Ec</span><br><span>index a5b57a5=2E=
=2E1c3c6bf 100644</span><br><span>--- a/src/openvpn/ssl_verify=2Ec</span><b=
r><span>+++ b/src/openvpn/ssl_verify=2Ec</span><br><span>@@ -400,6 +400,11 =
@@</span><br><span>     return SUCCESS;</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC=
__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><s=
pan>  * Export the subject, common_name, and raw certificate fields to the<=
/span><br><span>  * environment for later verification by scripts and plugi=
ns=2E</span><br><span>@@ -810,6 +815,10 @@</span><br><span>     return ret;=
</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* ******************=
*********************************************************</span><br><span> =
 * Functions for the management of deferred authentication when using</span=
><br><span>  * user/password authentication=2E</span><br><span>@@ -891,6 +9=
00,11 @@</span><br><span>     return supported;</span><br><span> }</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if define=
d(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversio=
n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</sp=
an><br><span>  *  Checks if the deferred state should also send auth pendin=
g</span><br><span>  *  request to the client=2E Also removes the auth_pendi=
ng control file</span><br><span>@@ -965,6 +979,10 @@</span><br><span>     r=
eturn ret;</span><br><span> }</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic =
pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><=
br><span>  *  Removes auth_pending and auth_control files from file system<=
/span><br><span>  *  and key_state structure</span><br><span>diff --git a/s=
rc/openvpn/ssl_verify_mbedtls=2Ec b/src/openvpn/ssl_verify_mbedtls=2Ec</spa=
n><br><span>index a132f12=2E=2Ebba2f2f 100644</span><br><span>--- a/src/ope=
nvpn/ssl_verify_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/ssl_verify_mb=
edtls=2Ec</span><br><span>@@ -222,6 +222,11 @@</span><br><span>     return =
true;</span><br><span> }</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnost=
ic ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span> result_t</span><br><span> backend_x509_get_userna=
me(char *cn, size_t cn_len, char *x509_username_field, mbedtls_x509_crt *ce=
rt)</span><br><span> {</span><br><span>@@ -786,6 +791,10 @@</span><br><span=
>     }</span><br><span> }</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* Dummy funct=
ion because Netscape certificate types are not supported in OpenVPN with mb=
edtls=2E</span><br><span>  * Returns SUCCESS if usage is NS_CERT_CHECK_NONE=
, FAILURE otherwise=2E */</span><br><span> result_t</span><br><span>diff --=
git a/src/openvpn/ssl_verify_openssl=2Ec b/src/openvpn/ssl_verify_openssl=
=2Ec</span><br><span>index 0c36cf2=2E=2E19339ad 100644</span><br><span>--- =
a/src/openvpn/ssl_verify_openssl=2Ec</span><br><span>+++ b/src/openvpn/ssl_=
verify_openssl=2Ec</span><br><span>@@ -317,6 +317,11 @@</span><br><span>   =
  return serial;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma G=
CC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> char *</span><br><span> backend_x509=
_get_serial_hex(openvpn_x509_cert_t *cert, struct gc_arena *gc)</span><br><=
span> {</span><br><span>@@ -573,6 +578,10 @@</span><br><span>     gc_free(&=
amp;gc);</span><br><span> }</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic po=
p</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br>=
<span>  * Save X509 fields to environment, using the naming convention:</sp=
an><br><span>  *</span><br><span>diff --git a/src/openvpn/status=2Ec b/src/=
openvpn/status=2Ec</span><br><span>index 1036536=2E=2E533619f 100644</span>=
<br><span>--- a/src/openvpn/status=2Ec</span><br><span>+++ b/src/openvpn/st=
atus=2Ec</span><br><span>@@ -55,6 +55,11 @@</span><br><span>     }</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &q=
uot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> struct status_output *</span><br><span> status_open(const char=
 *filename, const int refresh_freq, const int msglevel,</span><br><span>   =
          const struct virtual_output *vout, const unsigned int flags)</spa=
n><br><span>@@ -119,6 +124,10 @@</span><br><span>     return so;</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span> bool</span><br><span> status_tri=
gger(struct status_output *so)</span><br><span> {</span><br><span>@@ -206,6=
 +215,11 @@</span><br><span>     return ret;</span><br><span> }</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(_=
_GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #define ST=
ATUS_PRINTF_MAXLEN 512</span><br><span> </span><br><span> void</span><br><s=
pan>@@ -297,3 +311,7 @@</span><br><span> </span><br><span>     return ret;<=
/span><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__=
) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#endif</span><br><span>diff --git a/src/openvpn/tls_crypt=2Ec b/=
src/openvpn/tls_crypt=2Ec</span><br><span>index 3d27e40=2E=2Ee59f55b 100644=
</span><br><span>--- a/src/openvpn/tls_crypt=2Ec</span><br><span>+++ b/src/=
openvpn/tls_crypt=2Ec</span><br><span>@@ -93,6 +93,11 @@</span><br><span>  =
   }</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnosti=
c ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span> bool</span><br><span> tls_session_generate_dynamic=
_tls_crypt_key(struct tls_session *session)</span><br><span> {</span><br><s=
pan>@@ -517,6 +522,10 @@</span><br><span>     return ret;</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span> static bool</span><br><span> tls_crypt_=
v2_check_client_key_age(const struct buffer *tls_crypt_v2_metadata, int max=
_days)</span><br><span> {</span><br><span>@@ -697,6 +706,11 @@</span><br><s=
pan>     write_pem_key_file(filename, tls_crypt_v2_srv_pem_name);</span><br=
><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &q=
uot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> void</span><br><span> tls_crypt_v2_write_client_key_file(const=
 char *filename, const char *b64_metadata,</span><br><span>                =
                    const char *server_key_file, bool server_key_inline)</s=
pan><br><span>@@ -800,3 +814,7 @@</span><br><span> </span><br><span>     gc=
_free(&amp;gc);</span><br><span> }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if =
defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#endif</span><br><span>diff --git a/src/openvpn/=
tun=2Ec b/src/openvpn/tun=2Ec</span><br><span>index a1f9886=2E=2E1ae19eb 10=
0644</span><br><span>--- a/src/openvpn/tun=2Ec</span><br><span>+++ b/src/op=
envpn/tun=2Ec</span><br><span>@@ -112,6 +112,11 @@</span><br><span> </span>=
<br><span> static const char *netsh_get_id(const char *dev_node, struct gc_=
arena *gc);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &q=
uot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> static bool</span><br><span> do_address_service(const bool add=
, const short family, const struct tuntap *tt)</span><br><span> {</span><br=
><span>@@ -479,6 +484,10 @@</span><br><span>     return ret;</span><br><spa=
n> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> #endif /* ifdef _WIN32 */</span><br>=
<span> </span><br><span> #ifdef TARGET_SOLARIS</span><br><span>@@ -815,6 +8=
24,11 @@</span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if define=
d(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversio=
n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</spa=
n><br><span>  * Init tun/tap object=2E</span><br><span>  *</span><br><span>=
@@ -1556,6 +1570,10 @@</span><br><span> #endif</span><br><span> }</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined=
(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span> /* execute the ifconfig command through the shell =
*/</span><br><span> void</span><br><span> do_ifconfig(struct tuntap *tt, co=
nst char *ifname, int tun_mtu, const struct env_set *es,</span><br><span>@@=
 -1701,6 +1719,11 @@</span><br><span> #include &lt;netinet/ip=2Eh&gt;</span=
><br><span> #include &lt;sys/uio=2Eh&gt;</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__c=
lang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC =
diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pra=
gma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> static inline ssize_t</span><br><=
span> header_modify_read_write_return(ssize_t len)</span><br><span> {</span=
><br><span>@@ -1786,6 +1809,10 @@</span><br><span> }</span><br><span> #endi=
f</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span> #endif /* if defined(TARGET_FREEBSD) ||=
 defined(TARGET_DRAGONFLY) || defined(TARGET_NETBSD) || defined (TARGET_OPE=
NBSD) || defined(TARGET_DARWIN) */</span><br><span> </span><br><span> bool<=
/span><br><span>@@ -2043,6 +2070,11 @@</span><br><span>     free(tt);</span=
><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored =
&quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span> ssize_t</span><br><span> write_tun(const struct tuntap *tt, =
const uint8_t *buf, int len)</span><br><span> {</span><br><span>@@ -2055,6 =
+2087,10 @@</span><br><span>     return read(tt-&gt;fd, buf, len);</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> #elif defined(TARGET_LINUX)</=
span><br><span> </span><br><span> #if !PEDANTIC</span><br><span>@@ -2252,6 =
+2288,11 @@</span><br><span>     free(tt);</span><br><span> }</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__G=
NUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> ssize_t</spa=
n><br><span> write_tun(const struct tuntap *tt, const uint8_t *buf, int len=
)</span><br><span> {</span><br><span>@@ -2264,6 +2305,10 @@</span><br><span=
>     return read(tt-&gt;fd, buf, len);</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC=
__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span> #elif defined(TARGET_SOLARIS)</span><br><span> </span><br=
><span> #ifndef TUNNEWPPA</span><br><span>@@ -2881,6 +2926,11 @@</span><br>=
<span> </span><br><span> #elif defined(TARGET_DARWIN)</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) |=
| defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* Darwin (MacOS X) =
is mostly &quot;just use the generic stuff&quot;, but there</span><br><span=
>  * is always one caveat=2E=2E=2E:</span><br><span>  *</span><br><span>@@ =
-2946,6 +2996,10 @@</span><br><span>     return fd;</span><br><span> }</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if de=
fined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span> void</span><br><span> open_darwin_utun(const =
char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)</=
span><br><span> {</span><br><span>@@ -3095,6 +3149,11 @@</span><br><span>  =
   gc_free(&amp;gc);</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__cl=
ang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC d=
iagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#prag=
ma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span> ssize_t</span><br><span> write_tun=
(const struct tuntap *tt, const uint8_t *buf, int len)</span><br><span> {</=
span><br><span>@@ -3121,6 +3180,10 @@</span><br><span>     }</span><br><spa=
n> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> #elif defined(TARGET_AIX)</span><br>=
<span> </span><br><span> void</span><br><span>@@ -3257,6 +3320,11 @@</span>=
<br><span> </span><br><span> #elif defined(_WIN32)</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || d=
efined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#p=
ragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><span> tu=
n_read_queue(struct tuntap *tt, int maxsize)</span><br><span> {</span><br><=
span>@@ -6101,6 +6169,10 @@</span><br><span>     argv_free(&amp;argv);</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span> void</span><br><span> clos=
e_tun_handle(struct tuntap *tt)</span><br><span> {</span><br><span>@@ -6280=
,7 +6352,7 @@</span><br><span>     return BSTR(&amp;out);</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#e=
lse                        /* generic */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#else  /* generic */</span><br><span> </span><br><span=
> void</span><br><span> open_tun(const char *dev, const char *dev_type, con=
st char *dev_node, struct tuntap *tt,</span><br><span>@@ -6310,4 +6382,4 @@=
</span><br><span>     return read(tt-&gt;fd, buf, len);</span><br><span> }<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#end=
if                       /* if defined (TARGET_ANDROID) */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#endif /* if defined (TARGET_ANDROID=
) */</span><br><span>diff --git a/src/openvpn/tun_afunix=2Ec b/src/openvpn/=
tun_afunix=2Ec</span><br><span>index 79d706a=2E=2E155bf8d 100644</span><br>=
<span>--- a/src/openvpn/tun_afunix=2Ec</span><br><span>+++ b/src/openvpn/tu=
n_afunix=2Ec</span><br><span>@@ -48,6 +48,11 @@</span><br><span> #include &=
lt;stdlib=2Eh&gt;</span><br><span> </span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma G=
CC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> static void</span><br><span> tun_afu=
nix_exec_child(const char *dev_node, struct tuntap *tt, const struct env_se=
t *env)</span><br><span> {</span><br><span>@@ -171,6 +176,11 @@</span><br><=
span>      * with error messages */</span><br><span>     return read(tt-&gt=
;fd, buf, len);</span><br><span> }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if =
defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span> #else  /* ifndef WIN32 */</span><br><span> =
</span><br><span> // cppcheck-suppress-begin constParameterPointer ; stubs<=
/span><br><span>diff --git a/src/openvpn/vlan=2Ec b/src/openvpn/vlan=2Ec</s=
pan><br><span>index 04e18d6=2E=2Ed44dac1 100644</span><br><span>--- a/src/o=
penvpn/vlan=2Ec</span><br><span>+++ b/src/openvpn/vlan=2Ec</span><br><span>=
@@ -56,6 +56,11 @@</span><br><span>         (hdr-&gt;pcp_cfi_vid &amp; ~OPE=
NVPN_8021Q_MASK_VID) | (htons(vid) &amp; OPENVPN_8021Q_MASK_VID);</span><br=
><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &q=
uot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> /*</span><br><span>  * vlan_decapsulate - remove 802=2E1q head=
er and return VID</span><br><span>  *</span><br><span>@@ -170,6 +175,10 @@<=
/span><br><span>     return -1;</span><br><span> }</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || d=
efined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#p=
ragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> /*</span><br><span>  * vlan_encapsulate - add 802=2E1q header and=
 set the context related VID</span><br><span>  *</span><br><span>diff --git=
 a/src/openvpn/wfp_block=2Ec b/src/openvpn/wfp_block=2Ec</span><br><span>in=
dex 4d38fdb=2E=2Eb576899 100644</span><br><span>--- a/src/openvpn/wfp_block=
=2Ec</span><br><span>+++ b/src/openvpn/wfp_block=2Ec</span><br><span>@@ -13=
1,6 +131,11 @@</span><br><span>     return err;</span><br><span> }</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if define=
d(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversio=
n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</spa=
n><br><span>  * Block outgoing local traffic, possibly DNS only, except for=
</span><br><span>  * (i) adapter with the specified index (and loopback, if=
 all is blocked)</span><br><span>@@ -340,6 +345,10 @@</span><br><span>     =
return err;</span><br><span> }</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic=
 pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> DWORD</spa=
n><br><span> delete_wfp_block_filters(HANDLE engine_handle)</span><br><span=
> {</span><br><span>diff --git a/src/openvpn/win32-util=2Ec b/src/openvpn/w=
in32-util=2Ec</span><br><span>index e2c8810=2E=2E5f99e2b 100644</span><br><=
span>--- a/src/openvpn/win32-util=2Ec</span><br><span>+++ b/src/openvpn/win=
32-util=2Ec</span><br><span>@@ -36,6 +36,11 @@</span><br><span> #include &q=
uot;buffer=2Eh&quot;</span><br><span> #include &quot;win32-util=2Eh&quot;</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if=
 defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-co=
nversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endi=
f</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
WCHAR *</span><br><span> wide_string(const char *utf8, struct gc_arena *gc)=
</span><br><span> {</span><br><span>@@ -131,6 +136,10 @@</span><br><span>  =
   return utf8;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</s=
pan><br><span>  * Return true if filename is safe to be used on Windows,</s=
pan><br><span>  * by avoiding the following reserved names:</span><br><span=
>diff --git a/src/openvpn/win32=2Ec b/src/openvpn/win32=2Ec</span><br><span=
>index 3af58ed=2E=2E079869f 100644</span><br><span>--- a/src/openvpn/win32=
=2Ec</span><br><span>+++ b/src/openvpn/win32=2Ec</span><br><span>@@ -545,6 =
+545,11 @@</span><br><span>     CLEAR(*ws);</span><br><span> }</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__=
GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void</span>=
<br><span> win32_signal_open(struct win32_signal *ws, int force, const char=
 *exit_event_name,</span><br><span>                   bool exit_event_initi=
al_state)</span><br><span>@@ -1661,4 +1666,8 @@</span><br><span>     return=
 ret;</span><br><span> }</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* ifdef =
_WIN32 */</span><br><span>diff --git a/src/openvpn/xkey_helper=2Ec b/src/op=
envpn/xkey_helper=2Ec</span><br><span>index 6908cbb=2E=2Ef4be796 100644</sp=
an><br><span>--- a/src/openvpn/xkey_helper=2Ec</span><br><span>+++ b/src/op=
envpn/xkey_helper=2Ec</span><br><span>@@ -146,6 +146,11 @@</span><br><span>=
 }</span><br><span> </span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnos=
tic ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif</span><br><span> /**</span><br><span>  * Signa=
ture callback for xkey_provider with management-external-key</span><br><spa=
n>  *</span><br><span>@@ -276,6 +281,10 @@</span><br><span> </span><br><spa=
n>     return (*siglen &gt; 0);</span><br><span> }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnost=
ic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /=
* ENABLE MANAGEMENT */</span><br><span> </span><br><span> /**</span><br><sp=
an>diff --git a/src/openvpn/xkey_provider=2Ec b/src/openvpn/xkey_provider=
=2Ec</span><br><span>index a349d4d=2E=2E9211c11 100644</span><br><span>--- =
a/src/openvpn/xkey_provider=2Ec</span><br><span>+++ b/src/openvpn/xkey_prov=
ider=2Ec</span><br><span>@@ -940,6 +940,11 @@</span><br><span>     return r=
et;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic=
 ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> static int</span><br><span> signature_sign(void *ct=
x, unsigned char *sig, size_t *siglen, size_t sigsize,</span><br><span>    =
            const unsigned char *tbs, size_t tbslen)</span><br><span>@@ -10=
74,6 +1079,10 @@</span><br><span>     return signature_sign(ctx, sig, sigle=
n, sigsize, buf, sz);</span><br><span> }</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__c=
lang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC =
diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endi=
f</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
/* Sign digest using native sign function -- will only work for native keys=
</span><br><span>  */</span><br><span> int</span><br><span>diff --git a/src=
/openvpnmsica/dllmain=2Ec b/src/openvpnmsica/dllmain=2Ec</span><br><span>in=
dex 85ebda9=2E=2E777c823 100644</span><br><span>--- a/src/openvpnmsica/dllm=
ain=2Ec</span><br><span>+++ b/src/openvpnmsica/dllmain=2Ec</span><br><span>=
@@ -98,6 +98,11 @@</span><br><span>     return true;</span><br><span> }</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if d=
efined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conv=
ersion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> vo=
id</span><br><span> x_msg_va(const unsigned int flags, const char *format, =
va_list arglist)</span><br><span> {</span><br><span>@@ -189,3 +194,7 @@</sp=
an><br><span>                       hRecordProg);</span><br><span>     MsiC=
loseHandle(hRecordProg);</span><br><span> }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>diff --git a/src=
/openvpnserv/common=2Ec b/src/openvpnserv/common=2Ec</span><br><span>index =
671ddde=2E=2Ee20feb7 100644</span><br><span>--- a/src/openvpnserv/common=2E=
c</span><br><span>+++ b/src/openvpnserv/common=2Ec</span><br><span>@@ -30,6=
 +30,11 @@</span><br><span> LPCWSTR service_instance =3D L&quot;&quot;;</sp=
an><br><span> static wchar_t win_sys_path[MAX_PATH];</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) ||=
 defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static DWORD</span><b=
r><span> GetRegString(HKEY key, LPCWSTR value, LPWSTR data, DWORD size, LPC=
WSTR default_value)</span><br><span> {</span><br><span>@@ -309,6 +314,10 @@=
</span><br><span>     return utf16;</span><br><span> }</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) =
|| defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span> const wchar_t *</span><br><span> get_win_sys_path(void)</span=
><br><span> {</span><br><span>diff --git a/src/openvpnserv/interactive=2Ec =
b/src/openvpnserv/interactive=2Ec</span><br><span>index da86e85=2E=2E57f024=
3 100644</span><br><span>--- a/src/openvpnserv/interactive=2Ec</span><br><s=
pan>+++ b/src/openvpnserv/interactive=2Ec</span><br><span>@@ -524,6 +524,10=
 @@</span><br><span>     free(sud-&gt;directory);</span><br><span> }</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defi=
ned(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-convers=
ion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</sp=
an><br><span> </span><br><span> static SOCKADDR_INET</span><br><span> socka=
ddr_inet(short family, const inet_address_t *addr)</span><br><span>@@ -3970=
,6 +3974,9 @@</span><br><span>     return 0;</span><br><span> }</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(_=
_GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#endif</span><br><span> </span><br><span> static DWORD WI=
NAPI</span><br><span> ServiceCtrlInteractive(DWORD ctrl_code, DWORD event, =
LPVOID data, LPVOID ctx)</span><br><span>diff --git a/src/plugins/auth-pam/=
auth-pam=2Ec b/src/plugins/auth-pam/auth-pam=2Ec</span><br><span>index 948b=
6af=2E=2E0cd201d 100644</span><br><span>--- a/src/plugins/auth-pam/auth-pam=
=2Ec</span><br><span>+++ b/src/plugins/auth-pam/auth-pam=2Ec</span><br><spa=
n>@@ -184,6 +184,11 @@</span><br><span>     return -1;</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if=
 defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-co=
nversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endi=
f</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
static ssize_t</span><br><span> send_string(int fd, const char *string)</sp=
an><br><span> {</span><br><span>@@ -199,6 +204,10 @@</span><br><span>     }=
</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #ifdef DO_DAEMONIZE</=
span><br><span> </span><br><span> /*</span><br><span>diff --git a/src/tapct=
l/tap=2Ec b/src/tapctl/tap=2Ec</span><br><span>index ac1ecd2=2E=2Ea3d83e9 1=
00644</span><br><span>--- a/src/tapctl/tap=2Ec</span><br><span>+++ b/src/ta=
pctl/tap=2Ec</span><br><span>@@ -102,6 +102,11 @@</span><br><span> }</span>=
<br><span> #endif</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic igno=
red &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span> /**</span><br><span>  * Returns length of string of stri=
ngs</span><br><span>  *</span><br><span>@@ -1226,6 +1231,9 @@</span><br><sp=
an>     return dwResult;</span><br><span> }</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(=
__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma G=
CC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#e=
ndif</span><br><span> </span><br><span> void</span><br><span> tap_free_adap=
ter_list(_In_ struct tap_adapter_node *pAdapterList)</span><br><span>diff -=
-git a/tests/unit_tests/openvpn/test_buffer=2Ec b/tests/unit_tests/openvpn/=
test_buffer=2Ec</span><br><span>index 338265d=2E=2Eb480985 100644</span><br=
><span>--- a/tests/unit_tests/openvpn/test_buffer=2Ec</span><br><span>+++ b=
/tests/unit_tests/openvpn/test_buffer=2Ec</span><br><span>@@ -106,6 +106,11=
 @@</span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__G=
NUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static void<=
/span><br><span> test_buffer_format_hex_ex(void **state)</span><br><span> {=
</span><br><span>@@ -139,6 +144,10 @@</span><br><span>     gc_free(&amp;gc)=
;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> struct test_buffer_l=
ist_aggregate_ctx</span><br><span> {</span><br><span>     struct buffer_lis=
t *empty;</span><br><span>diff --git a/tests/unit_tests/openvpn/test_crypto=
=2Ec b/tests/unit_tests/openvpn/test_crypto=2Ec</span><br><span>index f86ac=
a8=2E=2Ee68a0b2 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_=
crypto=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_crypto=2Ec</=
span><br><span>@@ -52,6 +52,11 @@</span><br><span> </span><br><span> static=
 const char testtext[] =3D &quot;Dummy text to test PEM encoding&quot;;</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if d=
efined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conv=
ersion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> st=
atic void</span><br><span> crypto_pem_encode_decode_loopback(void **state)<=
/span><br><span> {</span><br><span>@@ -799,6 +804,10 @@</span><br><span>   =
  assert_null(epoch_lookup_decrypt_key(co, 23));</span><br><span> }</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defin=
ed(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span> void</span><br><span> crypto_test_epoch_key_over=
flow(void **state)</span><br><span> {</span><br><span>@@ -914,6 +923,11 @@<=
/span><br><span>     assert_memory_equal(out, expected_hash, UT_SIPHASH_HAS=
H_SIZE);</span><br><span> }</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pu=
sh</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span> static void</span><br><span> test_siphash_open=
ssl(void **state)</span><br><span> {</span><br><span>@@ -959,6 +973,9 @@</s=
pan><br><span>     siphash_openssl_uninit(sipctx);</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if def=
ined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br><span> int</span=
><br><span> main(void)</span><br><span>diff --git a/tests/unit_tests/openvp=
n/test_cryptoapi=2Ec b/tests/unit_tests/openvpn/test_cryptoapi=2Ec</span><b=
r><span>index 37bbe92=2E=2E55aafbb 100644</span><br><span>--- a/tests/unit_=
tests/openvpn/test_cryptoapi=2Ec</span><br><span>+++ b/tests/unit_tests/ope=
nvpn/test_cryptoapi=2Ec</span><br><span>@@ -137,6 +137,11 @@</span><br><spa=
n>     return c-&gt;cert ? c : NULL;</span><br><span> }</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__)=
 || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* import sample c=
ertificates into windows cert store */</span><br><span> static void</span><=
br><span> import_certs(void **state)</span><br><span>@@ -223,6 +228,10 @@</=
span><br><span>     certs_loaded =3D true;</span><br><span> }</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__G=
NUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span> static int</span><br><span> cleanup(void **state)</spa=
n><br><span> {</span><br><span>diff --git a/tests/unit_tests/openvpn/test_d=
hcp=2Ec b/tests/unit_tests/openvpn/test_dhcp=2Ec</span><br><span>index 3a84=
e1e=2E=2Ee331d3d 100644</span><br><span>--- a/tests/unit_tests/openvpn/test=
_dhcp=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_dhcp=2Ec</spa=
n><br><span>@@ -50,6 +50,11 @@</span><br><span>     return &quot;dummy&quot=
;;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic =
ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> static void</span><br><span> test_write_dhcp_search_=
str(void **state)</span><br><span> {</span><br><span>@@ -141,6 +146,10 @@</=
span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__=
) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span> int</span><br><span> main(void)</span><br><span> {</span><b=
r><span>diff --git a/tests/unit_tests/openvpn/test_networking=2Ec b/tests/u=
nit_tests/openvpn/test_networking=2Ec</span><br><span>index 1c9cac1=2E=2Eae=
75386 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_networking=
=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_networking=2Ec</sp=
an><br><span>@@ -40,6 +40,11 @@</span><br><span>     return net_iface_del(N=
ULL, name);</span><br><span> }</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic=
 push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC di=
agnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span> static int</span><br><span> net__iface_mtu_=
set(int mtu)</span><br><span> {</span><br><span>@@ -48,6 +53,10 @@</span><b=
r><span>     return net_iface_mtu_set(NULL, iface, mtu);</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span> static int</span><br><span> net__addr_v4=
_add(const char *addr_str, int prefixlen)</span><br><span> {</span><br><spa=
n>diff --git a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/ope=
nvpn/test_pkt=2Ec</span><br><span>index 49ba833=2E=2E889e6d7 100644</span><=
br><span>--- a/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>+++ b/=
tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>@@ -618,6 +618,11 @@<=
/span><br><span>     assert_memory_equal(server_id2_p1=2Eid, server_id_p2=
=2Eid, SID_SIZE);</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang=
__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diag=
nostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma =
GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> static void</span><br><span> test_ge=
nerate_reset_packet_plain(void **ut_state)</span><br><span> {</span><br><sp=
an>@@ -696,6 +701,10 @@</span><br><span>     free_tas(&amp;tas_server);</sp=
an><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* A peer can ask us to=
 append the wrapped client key (WKc) to our next</span><br><span>  * contro=
l packet=2E Only a tls-crypt-v2 client has one, so check that we</span><br>=
<span>  * refuse to build such a packet when we have no key instead of walk=
ing</span><br><span>diff --git a/tests/unit_tests/openvpn/test_ssl=2Ec b/te=
sts/unit_tests/openvpn/test_ssl=2Ec</span><br><span>index 4987dd0=2E=2E85b8=
d12 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_ssl=2Ec</spa=
n><br><span>+++ b/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>@@ =
-265,6 +265,10 @@</span><br><span> #endif /* HAVE_OPENSSL_STORE */</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &q=
uot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#endif</span><br><span> </span><br><span> static void</span><br><sp=
an> init_frame_parameters(struct frame *frame)</span><br><span>@@ -886,6 +8=
90,10 @@</span><br><span>     free_certificate(cert);</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if =
defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span> /* Certificate with two CNs, &quot;foo&quot=
; and &quot;bar&quot;=2E</span><br><span>  *</span><br><span>  * Generated =
with:</span><br><span>diff --git a/tests/unit_tests/openvpn/test_tls_crypt=
=2Ec b/tests/unit_tests/openvpn/test_tls_crypt=2Ec</span><br><span>index f8=
aa199=2E=2Eab90ea5 100644</span><br><span>--- a/tests/unit_tests/openvpn/te=
st_tls_crypt=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_tls_cr=
ypt=2Ec</span><br><span>@@ -232,6 +232,11 @@</span><br><span>     }</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &q=
uot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> /**</span><br><span>  * Check that short messages are successf=
ully wrapped-and-unwrapped=2E</span><br><span>  */</span><br><span>@@ -773,=
6 +778,10 @@</span><br><span>     tls_wrap_free(&amp;wrap_ctx);</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> static void</span><br><span> test=
_tls_crypt_v2_write_server_key_file(void **state)</span><br><span> {</span>=
<br><span>diff --git a/tests/unit_tests/openvpn/test_user_pass=2Ec b/tests/=
unit_tests/openvpn/test_user_pass=2Ec</span><br><span>index 776a86a=2E=2E5b=
c1d2a 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_user_pass=
=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_user_pass=2Ec</spa=
n><br><span>@@ -46,6 +46,12 @@</span><br><span>     return query_user_exec_=
builtin();</span><br><span> }</span><br><span> #endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignor=
ed &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span> bool</span><br><span> query_user_exec_builtin(void)</span=
><br><span> {</span><br><span>@@ -58,6 +64,11 @@</span><br><span> </span><b=
r><span>     return mock();</span><br><span> }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> void</span><br><span> managem=
ent_auth_failure(const struct management *man, const char *type, const char=
 *reason)</span><br><span> {</span><br></pre><p>To view, visit <a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1186?usp=3Demail">change 1186</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1186?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie=
cf502ec811e99c56647b2d45298fa0fb66960fb </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 1186 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 21 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenhel=
d &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mail=
box=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel =
&lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--t56Hrt5BvxY=--


--===============2378278112417232561==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2378278112417232561==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2378278112417232561==--

